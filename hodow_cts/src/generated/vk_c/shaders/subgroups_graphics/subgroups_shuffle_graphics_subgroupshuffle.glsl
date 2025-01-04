#version 450
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int8_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int8_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int8_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int8_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int8_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int8_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  int8_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int8_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  int8_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int8_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int8_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int8_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int8_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int8_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  int8_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int8_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  int8_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int8_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int8_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int8_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i8vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i8vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i8vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  i8vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i8vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  i8vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i8vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i8vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i8vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  i8vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i8vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  i8vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i8vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i8vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i8vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i8vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i8vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  i8vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i8vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  i8vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i8vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i8vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i8vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  i8vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i8vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  i8vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i8vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i8vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i8vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i8vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i8vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  i8vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i8vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  i8vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i8vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i8vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i8vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  i8vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i8vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  i8vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i8vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i8vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int8_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int8_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<int8_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int8_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<int8_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int8_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<int8_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int8_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<int8_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int8_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<int8_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int8_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<int8_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int8_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<int8_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int8_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<int8_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int8_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int8_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int8_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint8_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint8_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint8_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint8_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint8_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint8_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint8_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint8_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint8_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint8_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint8_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint8_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint8_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint8_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint8_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint8_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint8_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint8_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint8_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint8_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u8vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u8vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u8vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u8vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u8vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u8vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u8vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u8vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u8vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u8vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u8vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u8vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u8vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  u8vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u8vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  u8vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u8vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u8vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u8vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  u8vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u8vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  u8vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u8vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u8vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u8vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u8vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u8vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  u8vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u8vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  u8vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u8vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u8vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u8vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  u8vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u8vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  u8vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u8vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u8vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint8_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint8_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<uint8_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint8_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<uint8_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint8_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<uint8_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint8_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<uint8_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint8_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<uint8_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint8_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<uint8_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint8_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<uint8_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint8_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<uint8_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint8_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint8_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint8_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int16_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int16_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int16_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int16_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int16_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int16_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  int16_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int16_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  int16_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int16_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int16_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int16_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int16_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int16_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  int16_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int16_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  int16_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int16_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int16_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int16_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i16vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i16vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i16vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  i16vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i16vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  i16vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i16vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i16vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i16vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  i16vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i16vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  i16vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i16vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i16vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i16vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i16vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i16vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  i16vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i16vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  i16vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i16vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i16vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i16vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  i16vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i16vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  i16vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i16vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i16vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i16vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i16vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i16vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  i16vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i16vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  i16vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i16vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i16vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i16vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  i16vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i16vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  i16vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i16vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i16vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int16_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int16_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<int16_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int16_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<int16_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int16_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<int16_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int16_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<int16_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int16_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<int16_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int16_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<int16_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int16_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<int16_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int16_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<int16_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int16_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int16_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int16_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint16_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint16_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint16_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint16_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint16_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint16_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint16_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint16_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint16_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint16_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint16_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint16_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint16_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint16_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint16_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint16_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint16_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint16_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint16_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint16_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u16vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u16vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u16vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  u16vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u16vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  u16vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u16vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u16vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u16vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  u16vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u16vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  u16vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u16vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u16vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u16vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u16vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u16vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  u16vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u16vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  u16vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u16vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u16vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u16vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  u16vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u16vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  u16vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u16vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u16vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u16vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u16vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u16vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  u16vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u16vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  u16vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u16vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u16vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u16vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  u16vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u16vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  u16vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u16vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u16vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint16_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint16_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<uint16_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint16_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<uint16_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint16_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<uint16_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint16_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<uint16_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint16_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<uint16_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint16_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<uint16_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint16_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<uint16_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint16_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<uint16_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint16_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint16_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint16_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  ivec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  ivec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  ivec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  ivec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  ivec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  ivec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  ivec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  ivec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  ivec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  ivec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  ivec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  ivec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  ivec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  ivec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  ivec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  ivec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  ivec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  ivec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  ivec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  ivec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  ivec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  ivec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  ivec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  ivec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  ivec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  ivec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  ivec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  ivec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  ivec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  ivec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<int, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<int, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<int, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<int, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uvec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uvec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uvec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uvec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uvec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uvec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uvec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uvec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uvec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uvec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uvec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uvec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uvec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uvec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uvec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uvec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uvec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uvec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uvec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uvec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uvec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uvec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uvec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uvec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uvec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uvec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uvec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uvec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uvec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uvec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<uint, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<uint, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<uint, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<uint, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int64_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int64_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int64_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int64_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int64_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int64_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  int64_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int64_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  int64_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int64_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int64_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int64_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int64_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int64_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  int64_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int64_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  int64_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int64_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int64_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  int64_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i64vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i64vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i64vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  i64vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i64vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  i64vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i64vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i64vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i64vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  i64vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i64vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  i64vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i64vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i64vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i64vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i64vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i64vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  i64vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i64vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  i64vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i64vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i64vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i64vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  i64vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i64vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  i64vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i64vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i64vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i64vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i64vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i64vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  i64vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i64vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  i64vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i64vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i64vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i64vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  i64vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i64vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  i64vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i64vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  i64vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int64_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int64_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<int64_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int64_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<int64_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int64_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<int64_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int64_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<int64_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int64_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<int64_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int64_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<int64_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int64_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<int64_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int64_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<int64_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int64_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int64_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<int64_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint64_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint64_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint64_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint64_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint64_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint64_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint64_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint64_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint64_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint64_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint64_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint64_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint64_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint64_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint64_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint64_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  uint64_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint64_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint64_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  uint64_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u64vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u64vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u64vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  u64vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u64vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  u64vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u64vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u64vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u64vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  u64vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u64vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  u64vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u64vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u64vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u64vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u64vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u64vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  u64vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u64vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  u64vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u64vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u64vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u64vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  u64vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u64vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  u64vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u64vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u64vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u64vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u64vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u64vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  u64vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u64vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  u64vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u64vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u64vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u64vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  u64vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u64vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  u64vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u64vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  u64vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint64_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint64_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<uint64_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint64_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<uint64_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint64_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<uint64_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint64_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<uint64_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint64_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<uint64_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint64_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<uint64_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint64_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<uint64_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint64_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<uint64_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint64_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint64_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<uint64_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  float16_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  float16_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  float16_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  float16_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  float16_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  float16_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  float16_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  float16_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  float16_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  float16_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  float16_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  float16_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  float16_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  float16_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  float16_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  float16_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  float16_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  float16_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  float16_t data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  float16_t op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  f16vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  f16vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  f16vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  f16vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  f16vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  f16vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  f16vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  f16vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  f16vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  f16vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  f16vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  f16vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  f16vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  f16vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  f16vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  f16vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  f16vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  f16vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  f16vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  f16vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  f16vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  f16vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  f16vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  f16vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  f16vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  f16vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  f16vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  f16vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  f16vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  f16vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  f16vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  f16vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  f16vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  f16vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  f16vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  f16vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  f16vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  f16vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  f16vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  f16vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  f16vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  f16vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<float16_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<float16_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<float16_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<float16_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<float16_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<float16_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<float16_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<float16_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<float16_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<float16_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<float16_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<float16_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<float16_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<float16_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<float16_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<float16_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<float16_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<float16_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<float16_t, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<float16_t, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  float data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  float op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  float data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  float op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  float data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  float op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  float data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  float op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  float data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  float op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  float data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  float op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  float data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  float op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  float data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  float op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  float data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  float op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  float data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  float op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<float, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<float, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<float, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<float, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<float, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<float, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<float, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<float, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<float, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<float, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<float, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<float, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<float, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<float, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<float, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<float, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<float, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<float, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<float, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<float, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  double data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  double op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  double data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  double op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  double data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  double op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  double data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  double op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  double data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  double op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  double data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  double op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  double data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  double op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  double data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  double op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  double data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  double op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  double data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  double op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  dvec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  dvec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  dvec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  dvec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  dvec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  dvec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  dvec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  dvec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  dvec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  dvec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  dvec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  dvec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  dvec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  dvec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  dvec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  dvec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  dvec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  dvec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  dvec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  dvec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  dvec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  dvec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  dvec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  dvec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  dvec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  dvec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  dvec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  dvec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  dvec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  dvec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<double, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<double, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<double, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<double, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<double, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<double, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<double, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<double, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<double, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<double, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<double, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<double, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<double, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<double, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<double, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<double, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<double, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<double, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<double, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<double, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bool data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bool op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bool data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bool op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bool data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bool op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bool data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bool op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bool data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bool op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bool data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bool op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bool data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bool op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bool data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bool op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bool data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bool op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bool data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bool op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bvec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bvec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bvec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bvec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bvec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bvec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bvec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bvec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bvec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec2 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bvec2 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bvec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bvec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bvec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bvec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bvec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bvec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bvec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bvec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bvec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec3 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bvec3 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bvec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bvec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bvec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bvec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bvec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bvec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bvec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bvec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bvec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec4 data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  bvec4 op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<bool, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<bool, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<bool, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<bool, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<bool, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<bool, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<bool, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<bool, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<bool, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<bool, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<bool, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<bool, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<bool, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<bool, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<bool, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<bool, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
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
  vector<bool, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};

void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<bool, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
#extension GL_KHR_shader_subgroup_shuffle: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<bool, 8> data1[];
};
layout(set = 0, binding = 5, std430) readonly buffer Buffer3
{
  uint data2[];
};
void main (void)
{
  uint tempRes;
  uint temp_res;
  uvec4 mask = subgroupBallot(true);
  uint id_in = data2[gl_SubgroupInvocationID] & (gl_SubgroupSize - 1);
  vector<bool, 8> op = subgroupShuffle(data1[gl_SubgroupInvocationID], id_in);
  uint id = id_in;
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
