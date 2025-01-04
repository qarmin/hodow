#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupEqMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i == gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupEqMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i == gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
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
layout(set = 0, binding = 2, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupEqMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i == gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupEqMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i == gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupEqMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i == gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupEqMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i == gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
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
layout(set = 0, binding = 2, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupEqMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i == gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupEqMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i == gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
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
layout(set = 0, binding = 3, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupEqMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i == gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupEqMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i == gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupGeMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i >= gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupGeMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i >= gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
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
layout(set = 0, binding = 2, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupGeMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i >= gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupGeMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i >= gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupGeMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i >= gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupGeMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i >= gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
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
layout(set = 0, binding = 2, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupGeMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i >= gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupGeMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i >= gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
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
layout(set = 0, binding = 3, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupGeMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i >= gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupGeMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i >= gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupGtMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i > gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupGtMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i > gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
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
layout(set = 0, binding = 2, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupGtMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i > gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupGtMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i > gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupGtMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i > gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupGtMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i > gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
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
layout(set = 0, binding = 2, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupGtMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i > gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupGtMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i > gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
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
layout(set = 0, binding = 3, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupGtMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i > gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupGtMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i > gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupLeMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i <= gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupLeMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i <= gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
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
layout(set = 0, binding = 2, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupLeMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i <= gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupLeMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i <= gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupLeMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i <= gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupLeMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i <= gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
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
layout(set = 0, binding = 2, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupLeMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i <= gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupLeMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i <= gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
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
layout(set = 0, binding = 3, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupLeMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i <= gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupLeMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i <= gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupLtMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i < gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupLtMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i < gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
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
layout(set = 0, binding = 2, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupLtMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i < gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupLtMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i < gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupLtMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i < gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupLtMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i < gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
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
layout(set = 0, binding = 2, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupLtMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i < gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupLtMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i < gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
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
layout(set = 0, binding = 3, std430) buffer Output
{
  uint result[];
};

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupLtMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i < gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  const uvec4 var = gl_SubgroupLtMask;
  for (uint i = 0; i < gl_SubgroupSize; i++)
  {
    if ((i < gl_SubgroupInvocationID) ^^ subgroupBallotBitExtract(var, i))
    {
      tempResult = 0;
    }
  }
  uint c = bitCount(var.x) + bitCount(var.y) + bitCount(var.z) + bitCount(var.w);
  if (subgroupBallotBitCount(var) != c)
  {
    tempResult = 0;
  }
  tempRes = tempResult;
  result = tempRes;
}
