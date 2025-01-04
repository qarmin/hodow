#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec2 data1[];
};
layout(set = 0, binding = 5, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
  u8vec2 op = subgroupRotate(data1[gl_SubgroupInvocationID], id_in);
  uint id = (gl_SubgroupInvocationID + id_in) & (gl_SubgroupSize - 1);
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec2 data1[];
};
layout(set = 0, binding = 5, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
  u8vec2 op = subgroupRotate(data1[gl_SubgroupInvocationID], id_in);
  uint id = (gl_SubgroupInvocationID + id_in) & (gl_SubgroupSize - 1);
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec2 data1[];
};
layout(set = 0, binding = 5, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
  u8vec2 op = subgroupRotate(data1[gl_SubgroupInvocationID], id_in);
  uint id = (gl_SubgroupInvocationID + id_in) & (gl_SubgroupSize - 1);
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
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
  u8vec2 data1[];
};
layout(set = 0, binding = 5, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
  u8vec2 op = subgroupRotate(data1[gl_SubgroupInvocationID], id_in);
  uint id = (gl_SubgroupInvocationID + id_in) & (gl_SubgroupSize - 1);
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
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
  u8vec2 data1[];
};
layout(set = 0, binding = 5, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
  u8vec2 op = subgroupRotate(data1[gl_SubgroupInvocationID], id_in);
  uint id = (gl_SubgroupInvocationID + id_in) & (gl_SubgroupSize - 1);
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec2 data1[];
};
layout(set = 0, binding = 5, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
  u8vec2 op = subgroupRotate(data1[gl_SubgroupInvocationID], id_in);
  uint id = (gl_SubgroupInvocationID + id_in) & (gl_SubgroupSize - 1);
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
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
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec2 data1[];
};
layout(set = 0, binding = 5, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
  u8vec2 op = subgroupRotate(data1[gl_SubgroupInvocationID], id_in);
  uint id = (gl_SubgroupInvocationID + id_in) & (gl_SubgroupSize - 1);
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
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
  u8vec2 data1[];
};
layout(set = 0, binding = 5, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
  u8vec2 op = subgroupRotate(data1[gl_SubgroupInvocationID], id_in);
  uint id = (gl_SubgroupInvocationID + id_in) & (gl_SubgroupSize - 1);
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
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
  u8vec2 data1[];
};
layout(set = 0, binding = 5, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
  u8vec2 op = subgroupRotate(data1[gl_SubgroupInvocationID], id_in);
  uint id = (gl_SubgroupInvocationID + id_in) & (gl_SubgroupSize - 1);
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec2 data1[];
};
layout(set = 0, binding = 5, std140) uniform Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[0] & (gl_SubgroupSize * 2 - 1);
  u8vec2 op = subgroupRotate(data1[gl_SubgroupInvocationID], id_in);
  uint id = (gl_SubgroupInvocationID + id_in) & (gl_SubgroupSize - 1);
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec2 data1[];
};
layout(set = 0, binding = 5, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  u8vec2 op = subgroupRotate(data1[gl_SubgroupInvocationID], id_in);
  uint id = (gl_SubgroupInvocationID + id_in) & (gl_SubgroupSize - 1);
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec2 data1[];
};
layout(set = 0, binding = 5, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  u8vec2 op = subgroupRotate(data1[gl_SubgroupInvocationID], id_in);
  uint id = (gl_SubgroupInvocationID + id_in) & (gl_SubgroupSize - 1);
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec2 data1[];
};
layout(set = 0, binding = 5, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  u8vec2 op = subgroupRotate(data1[gl_SubgroupInvocationID], id_in);
  uint id = (gl_SubgroupInvocationID + id_in) & (gl_SubgroupSize - 1);
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
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
  u8vec2 data1[];
};
layout(set = 0, binding = 5, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  u8vec2 op = subgroupRotate(data1[gl_SubgroupInvocationID], id_in);
  uint id = (gl_SubgroupInvocationID + id_in) & (gl_SubgroupSize - 1);
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
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
  u8vec2 data1[];
};
layout(set = 0, binding = 5, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  u8vec2 op = subgroupRotate(data1[gl_SubgroupInvocationID], id_in);
  uint id = (gl_SubgroupInvocationID + id_in) & (gl_SubgroupSize - 1);
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec2 data1[];
};
layout(set = 0, binding = 5, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  u8vec2 op = subgroupRotate(data1[gl_SubgroupInvocationID], id_in);
  uint id = (gl_SubgroupInvocationID + id_in) & (gl_SubgroupSize - 1);
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
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
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec2 data1[];
};
layout(set = 0, binding = 5, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  u8vec2 op = subgroupRotate(data1[gl_SubgroupInvocationID], id_in);
  uint id = (gl_SubgroupInvocationID + id_in) & (gl_SubgroupSize - 1);
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
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
  u8vec2 data1[];
};
layout(set = 0, binding = 5, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  u8vec2 op = subgroupRotate(data1[gl_SubgroupInvocationID], id_in);
  uint id = (gl_SubgroupInvocationID + id_in) & (gl_SubgroupSize - 1);
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
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
  u8vec2 data1[];
};
layout(set = 0, binding = 5, std140) uniform Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  u8vec2 op = subgroupRotate(data1[gl_SubgroupInvocationID], id_in);
  uint id = (gl_SubgroupInvocationID + id_in) & (gl_SubgroupSize - 1);
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_rotate: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec2 data1[];
};
layout(set = 0, binding = 5, std140) uniform Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = 5;
  u8vec2 op = subgroupRotate(data1[gl_SubgroupInvocationID], id_in);
  uint id = (gl_SubgroupInvocationID + id_in) & (gl_SubgroupSize - 1);
  if ((id < gl_SubgroupSize) && subgroupBallotBitExtract(mask, id))
  {
    temp_res = (op == data1[id]) ? 1 : 0;
  }
  else
  {
    temp_res = 1; // Invocation we read from was inactive, so we can't verify results!
  }
  tempRes = temp_res;
  result = tempRes;
}
