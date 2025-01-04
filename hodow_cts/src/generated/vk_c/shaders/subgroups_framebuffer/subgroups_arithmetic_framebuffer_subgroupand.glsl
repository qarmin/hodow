#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  int8_t ref = int8_t(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = int8_t(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  int8_t ref = int8_t(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = int8_t(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  int8_t ref = int8_t(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = int8_t(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  int8_t ref = int8_t(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = int8_t(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  int8_t ref = int8_t(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = int8_t(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  int8_t ref = int8_t(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = int8_t(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  int8_t ref = int8_t(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = int8_t(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i8vec2 ref = i8vec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i8vec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i8vec2 ref = i8vec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i8vec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i8vec2 ref = i8vec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i8vec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i8vec2 ref = i8vec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i8vec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i8vec2 ref = i8vec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i8vec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i8vec2 ref = i8vec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i8vec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i8vec2 ref = i8vec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i8vec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i8vec3 ref = i8vec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i8vec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i8vec3 ref = i8vec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i8vec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i8vec3 ref = i8vec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i8vec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i8vec3 ref = i8vec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i8vec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i8vec3 ref = i8vec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i8vec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i8vec3 ref = i8vec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i8vec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i8vec3 ref = i8vec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i8vec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i8vec4 ref = i8vec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i8vec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i8vec4 ref = i8vec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i8vec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i8vec4 ref = i8vec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i8vec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i8vec4 ref = i8vec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i8vec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i8vec4 ref = i8vec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i8vec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i8vec4 ref = i8vec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i8vec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i8vec4 ref = i8vec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i8vec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<int8_t, 8> ref = vector<int8_t, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<int8_t, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<int8_t, 8> ref = vector<int8_t, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<int8_t, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<int8_t, 8> ref = vector<int8_t, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<int8_t, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<int8_t, 8> ref = vector<int8_t, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<int8_t, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<int8_t, 8> ref = vector<int8_t, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<int8_t, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<int8_t, 8> ref = vector<int8_t, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<int8_t, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<int8_t, 8> ref = vector<int8_t, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<int8_t, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uint8_t ref = uint8_t(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uint8_t(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uint8_t ref = uint8_t(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uint8_t(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uint8_t ref = uint8_t(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uint8_t(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uint8_t ref = uint8_t(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uint8_t(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uint8_t ref = uint8_t(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uint8_t(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uint8_t ref = uint8_t(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uint8_t(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uint8_t ref = uint8_t(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uint8_t(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u8vec2 ref = u8vec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u8vec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u8vec2 ref = u8vec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u8vec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u8vec2 ref = u8vec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u8vec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u8vec2 ref = u8vec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u8vec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u8vec2 ref = u8vec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u8vec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u8vec2 ref = u8vec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u8vec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u8vec2 ref = u8vec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u8vec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u8vec3 ref = u8vec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u8vec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u8vec3 ref = u8vec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u8vec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u8vec3 ref = u8vec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u8vec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u8vec3 ref = u8vec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u8vec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u8vec3 ref = u8vec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u8vec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u8vec3 ref = u8vec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u8vec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u8vec3 ref = u8vec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u8vec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u8vec4 ref = u8vec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u8vec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u8vec4 ref = u8vec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u8vec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u8vec4 ref = u8vec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u8vec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u8vec4 ref = u8vec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u8vec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u8vec4 ref = u8vec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u8vec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u8vec4 ref = u8vec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u8vec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u8vec4 ref = u8vec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u8vec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<uint8_t, 8> ref = vector<uint8_t, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<uint8_t, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<uint8_t, 8> ref = vector<uint8_t, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<uint8_t, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<uint8_t, 8> ref = vector<uint8_t, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<uint8_t, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<uint8_t, 8> ref = vector<uint8_t, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<uint8_t, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<uint8_t, 8> ref = vector<uint8_t, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<uint8_t, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<uint8_t, 8> ref = vector<uint8_t, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<uint8_t, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<uint8_t, 8> ref = vector<uint8_t, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<uint8_t, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  int16_t ref = int16_t(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = int16_t(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  int16_t ref = int16_t(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = int16_t(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  int16_t ref = int16_t(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = int16_t(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  int16_t ref = int16_t(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = int16_t(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  int16_t ref = int16_t(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = int16_t(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  int16_t ref = int16_t(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = int16_t(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  int16_t ref = int16_t(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = int16_t(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i16vec2 ref = i16vec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i16vec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i16vec2 ref = i16vec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i16vec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i16vec2 ref = i16vec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i16vec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i16vec2 ref = i16vec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i16vec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i16vec2 ref = i16vec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i16vec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i16vec2 ref = i16vec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i16vec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i16vec2 ref = i16vec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i16vec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i16vec3 ref = i16vec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i16vec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i16vec3 ref = i16vec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i16vec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i16vec3 ref = i16vec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i16vec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i16vec3 ref = i16vec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i16vec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i16vec3 ref = i16vec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i16vec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i16vec3 ref = i16vec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i16vec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i16vec3 ref = i16vec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i16vec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i16vec4 ref = i16vec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i16vec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i16vec4 ref = i16vec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i16vec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i16vec4 ref = i16vec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i16vec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i16vec4 ref = i16vec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i16vec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i16vec4 ref = i16vec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i16vec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i16vec4 ref = i16vec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i16vec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i16vec4 ref = i16vec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i16vec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<int16_t, 8> ref = vector<int16_t, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<int16_t, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<int16_t, 8> ref = vector<int16_t, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<int16_t, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<int16_t, 8> ref = vector<int16_t, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<int16_t, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<int16_t, 8> ref = vector<int16_t, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<int16_t, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<int16_t, 8> ref = vector<int16_t, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<int16_t, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<int16_t, 8> ref = vector<int16_t, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<int16_t, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<int16_t, 8> ref = vector<int16_t, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<int16_t, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uint16_t ref = uint16_t(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uint16_t(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uint16_t ref = uint16_t(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uint16_t(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uint16_t ref = uint16_t(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uint16_t(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uint16_t ref = uint16_t(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uint16_t(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uint16_t ref = uint16_t(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uint16_t(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uint16_t ref = uint16_t(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uint16_t(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uint16_t ref = uint16_t(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uint16_t(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u16vec2 ref = u16vec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u16vec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u16vec2 ref = u16vec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u16vec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u16vec2 ref = u16vec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u16vec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u16vec2 ref = u16vec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u16vec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u16vec2 ref = u16vec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u16vec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u16vec2 ref = u16vec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u16vec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u16vec2 ref = u16vec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u16vec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u16vec3 ref = u16vec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u16vec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u16vec3 ref = u16vec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u16vec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u16vec3 ref = u16vec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u16vec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u16vec3 ref = u16vec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u16vec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u16vec3 ref = u16vec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u16vec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u16vec3 ref = u16vec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u16vec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u16vec3 ref = u16vec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u16vec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u16vec4 ref = u16vec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u16vec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u16vec4 ref = u16vec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u16vec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u16vec4 ref = u16vec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u16vec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u16vec4 ref = u16vec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u16vec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u16vec4 ref = u16vec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u16vec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u16vec4 ref = u16vec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u16vec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u16vec4 ref = u16vec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u16vec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<uint16_t, 8> ref = vector<uint16_t, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<uint16_t, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<uint16_t, 8> ref = vector<uint16_t, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<uint16_t, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<uint16_t, 8> ref = vector<uint16_t, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<uint16_t, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<uint16_t, 8> ref = vector<uint16_t, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<uint16_t, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<uint16_t, 8> ref = vector<uint16_t, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<uint16_t, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<uint16_t, 8> ref = vector<uint16_t, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<uint16_t, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<uint16_t, 8> ref = vector<uint16_t, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<uint16_t, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  int ref = int(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = int(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  int ref = int(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = int(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  int ref = int(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = int(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  int ref = int(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = int(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  int ref = int(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = int(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  int ref = int(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = int(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  int ref = int(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = int(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  ivec2 ref = ivec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = ivec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  ivec2 ref = ivec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = ivec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  ivec2 ref = ivec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = ivec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  ivec2 ref = ivec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = ivec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  ivec2 ref = ivec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = ivec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  ivec2 ref = ivec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = ivec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  ivec2 ref = ivec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = ivec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  ivec3 ref = ivec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = ivec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  ivec3 ref = ivec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = ivec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  ivec3 ref = ivec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = ivec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  ivec3 ref = ivec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = ivec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  ivec3 ref = ivec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = ivec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  ivec3 ref = ivec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = ivec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  ivec3 ref = ivec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = ivec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  ivec4 ref = ivec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = ivec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  ivec4 ref = ivec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = ivec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  ivec4 ref = ivec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = ivec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  ivec4 ref = ivec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = ivec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  ivec4 ref = ivec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = ivec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  ivec4 ref = ivec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = ivec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  ivec4 ref = ivec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = ivec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<int, 8> ref = vector<int, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<int, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<int, 8> ref = vector<int, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<int, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<int, 8> ref = vector<int, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<int, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<int, 8> ref = vector<int, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<int, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<int, 8> ref = vector<int, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<int, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<int, 8> ref = vector<int, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<int, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<int, 8> ref = vector<int, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<int, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uint ref = uint(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uint(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uint ref = uint(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uint(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uint ref = uint(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uint(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uint ref = uint(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uint(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uint ref = uint(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uint(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uint ref = uint(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uint(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uint ref = uint(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uint(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uvec2 ref = uvec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uvec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uvec2 ref = uvec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uvec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uvec2 ref = uvec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uvec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uvec2 ref = uvec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uvec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uvec2 ref = uvec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uvec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uvec2 ref = uvec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uvec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uvec2 ref = uvec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uvec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uvec3 ref = uvec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uvec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uvec3 ref = uvec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uvec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uvec3 ref = uvec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uvec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uvec3 ref = uvec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uvec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uvec3 ref = uvec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uvec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uvec3 ref = uvec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uvec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uvec3 ref = uvec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uvec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uvec4 ref = uvec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uvec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uvec4 ref = uvec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uvec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uvec4 ref = uvec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uvec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uvec4 ref = uvec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uvec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uvec4 ref = uvec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uvec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uvec4 ref = uvec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uvec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uvec4 ref = uvec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uvec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<uint, 8> ref = vector<uint, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<uint, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<uint, 8> ref = vector<uint, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<uint, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<uint, 8> ref = vector<uint, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<uint, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<uint, 8> ref = vector<uint, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<uint, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<uint, 8> ref = vector<uint, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<uint, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<uint, 8> ref = vector<uint, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<uint, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<uint, 8> ref = vector<uint, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<uint, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  int64_t ref = int64_t(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = int64_t(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  int64_t ref = int64_t(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = int64_t(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  int64_t ref = int64_t(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = int64_t(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  int64_t ref = int64_t(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = int64_t(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  int64_t ref = int64_t(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = int64_t(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  int64_t ref = int64_t(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = int64_t(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  int64_t ref = int64_t(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = int64_t(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i64vec2 ref = i64vec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i64vec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i64vec2 ref = i64vec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i64vec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i64vec2 ref = i64vec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i64vec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i64vec2 ref = i64vec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i64vec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i64vec2 ref = i64vec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i64vec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i64vec2 ref = i64vec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i64vec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i64vec2 ref = i64vec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i64vec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i64vec3 ref = i64vec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i64vec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i64vec3 ref = i64vec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i64vec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i64vec3 ref = i64vec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i64vec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i64vec3 ref = i64vec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i64vec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i64vec3 ref = i64vec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i64vec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i64vec3 ref = i64vec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i64vec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i64vec3 ref = i64vec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i64vec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i64vec4 ref = i64vec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i64vec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i64vec4 ref = i64vec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i64vec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i64vec4 ref = i64vec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i64vec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i64vec4 ref = i64vec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i64vec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i64vec4 ref = i64vec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i64vec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i64vec4 ref = i64vec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i64vec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  i64vec4 ref = i64vec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = i64vec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<int64_t, 8> ref = vector<int64_t, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<int64_t, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<int64_t, 8> ref = vector<int64_t, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<int64_t, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<int64_t, 8> ref = vector<int64_t, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<int64_t, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<int64_t, 8> ref = vector<int64_t, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<int64_t, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<int64_t, 8> ref = vector<int64_t, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<int64_t, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<int64_t, 8> ref = vector<int64_t, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<int64_t, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<int64_t, 8> ref = vector<int64_t, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<int64_t, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uint64_t ref = uint64_t(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uint64_t(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uint64_t ref = uint64_t(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uint64_t(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uint64_t ref = uint64_t(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uint64_t(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uint64_t ref = uint64_t(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uint64_t(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uint64_t ref = uint64_t(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uint64_t(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uint64_t ref = uint64_t(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uint64_t(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  uint64_t ref = uint64_t(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = uint64_t(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u64vec2 ref = u64vec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u64vec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u64vec2 ref = u64vec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u64vec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u64vec2 ref = u64vec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u64vec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u64vec2 ref = u64vec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u64vec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u64vec2 ref = u64vec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u64vec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u64vec2 ref = u64vec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u64vec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u64vec2 ref = u64vec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u64vec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u64vec3 ref = u64vec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u64vec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u64vec3 ref = u64vec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u64vec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u64vec3 ref = u64vec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u64vec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u64vec3 ref = u64vec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u64vec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u64vec3 ref = u64vec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u64vec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u64vec3 ref = u64vec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u64vec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u64vec3 ref = u64vec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u64vec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u64vec4 ref = u64vec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u64vec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u64vec4 ref = u64vec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u64vec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u64vec4 ref = u64vec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u64vec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u64vec4 ref = u64vec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u64vec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u64vec4 ref = u64vec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u64vec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u64vec4 ref = u64vec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u64vec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  u64vec4 ref = u64vec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = u64vec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<uint64_t, 8> ref = vector<uint64_t, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<uint64_t, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<uint64_t, 8> ref = vector<uint64_t, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<uint64_t, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<uint64_t, 8> ref = vector<uint64_t, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<uint64_t, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<uint64_t, 8> ref = vector<uint64_t, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<uint64_t, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<uint64_t, 8> ref = vector<uint64_t, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<uint64_t, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<uint64_t, 8> ref = vector<uint64_t, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<uint64_t, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<uint64_t, 8> ref = vector<uint64_t, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref & data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<uint64_t, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref & data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  bool ref = bool(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref && data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = bool(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref && data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  bool ref = bool(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref && data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = bool(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref && data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  bool ref = bool(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref && data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = bool(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref && data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  bool ref = bool(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref && data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = bool(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref && data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  bool ref = bool(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref && data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = bool(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref && data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  bool ref = bool(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref && data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = bool(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref && data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  bool ref = bool(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = ref && data[index];
      identityOnly &= ~0x1;
    }
  }
  tempRes = (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = bool(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = ref && data[index];
        identityOnly &= ~0x2;
      }
    }
    tempRes |= (ref == subgroupAnd(data[gl_SubgroupInvocationID])) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  bvec2 ref = bvec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = bvec2(ref.x && data[index].x, ref.y && data[index].y);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = bvec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = bvec2(ref.x && data[index].x, ref.y && data[index].y);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  bvec2 ref = bvec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = bvec2(ref.x && data[index].x, ref.y && data[index].y);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = bvec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = bvec2(ref.x && data[index].x, ref.y && data[index].y);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  bvec2 ref = bvec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = bvec2(ref.x && data[index].x, ref.y && data[index].y);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = bvec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = bvec2(ref.x && data[index].x, ref.y && data[index].y);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  bvec2 ref = bvec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = bvec2(ref.x && data[index].x, ref.y && data[index].y);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = bvec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = bvec2(ref.x && data[index].x, ref.y && data[index].y);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  bvec2 ref = bvec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = bvec2(ref.x && data[index].x, ref.y && data[index].y);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = bvec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = bvec2(ref.x && data[index].x, ref.y && data[index].y);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  bvec2 ref = bvec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = bvec2(ref.x && data[index].x, ref.y && data[index].y);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = bvec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = bvec2(ref.x && data[index].x, ref.y && data[index].y);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  bvec2 ref = bvec2(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = bvec2(ref.x && data[index].x, ref.y && data[index].y);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = bvec2(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = bvec2(ref.x && data[index].x, ref.y && data[index].y);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  bvec3 ref = bvec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = bvec3(ref.x && data[index].x, ref.y && data[index].y, ref.z && data[index].z);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = bvec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = bvec3(ref.x && data[index].x, ref.y && data[index].y, ref.z && data[index].z);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  bvec3 ref = bvec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = bvec3(ref.x && data[index].x, ref.y && data[index].y, ref.z && data[index].z);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = bvec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = bvec3(ref.x && data[index].x, ref.y && data[index].y, ref.z && data[index].z);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  bvec3 ref = bvec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = bvec3(ref.x && data[index].x, ref.y && data[index].y, ref.z && data[index].z);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = bvec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = bvec3(ref.x && data[index].x, ref.y && data[index].y, ref.z && data[index].z);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  bvec3 ref = bvec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = bvec3(ref.x && data[index].x, ref.y && data[index].y, ref.z && data[index].z);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = bvec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = bvec3(ref.x && data[index].x, ref.y && data[index].y, ref.z && data[index].z);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  bvec3 ref = bvec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = bvec3(ref.x && data[index].x, ref.y && data[index].y, ref.z && data[index].z);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = bvec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = bvec3(ref.x && data[index].x, ref.y && data[index].y, ref.z && data[index].z);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  bvec3 ref = bvec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = bvec3(ref.x && data[index].x, ref.y && data[index].y, ref.z && data[index].z);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = bvec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = bvec3(ref.x && data[index].x, ref.y && data[index].y, ref.z && data[index].z);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  bvec3 ref = bvec3(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = bvec3(ref.x && data[index].x, ref.y && data[index].y, ref.z && data[index].z);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = bvec3(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = bvec3(ref.x && data[index].x, ref.y && data[index].y, ref.z && data[index].z);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  bvec4 ref = bvec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = bvec4(ref.x && data[index].x, ref.y && data[index].y, ref.z && data[index].z, ref.w && data[index].w);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = bvec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = bvec4(ref.x && data[index].x, ref.y && data[index].y, ref.z && data[index].z, ref.w && data[index].w);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  bvec4 ref = bvec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = bvec4(ref.x && data[index].x, ref.y && data[index].y, ref.z && data[index].z, ref.w && data[index].w);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = bvec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = bvec4(ref.x && data[index].x, ref.y && data[index].y, ref.z && data[index].z, ref.w && data[index].w);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  bvec4 ref = bvec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = bvec4(ref.x && data[index].x, ref.y && data[index].y, ref.z && data[index].z, ref.w && data[index].w);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = bvec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = bvec4(ref.x && data[index].x, ref.y && data[index].y, ref.z && data[index].z, ref.w && data[index].w);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  bvec4 ref = bvec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = bvec4(ref.x && data[index].x, ref.y && data[index].y, ref.z && data[index].z, ref.w && data[index].w);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = bvec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = bvec4(ref.x && data[index].x, ref.y && data[index].y, ref.z && data[index].z, ref.w && data[index].w);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  bvec4 ref = bvec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = bvec4(ref.x && data[index].x, ref.y && data[index].y, ref.z && data[index].z, ref.w && data[index].w);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = bvec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = bvec4(ref.x && data[index].x, ref.y && data[index].y, ref.z && data[index].z, ref.w && data[index].w);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  bvec4 ref = bvec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = bvec4(ref.x && data[index].x, ref.y && data[index].y, ref.z && data[index].z, ref.w && data[index].w);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = bvec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = bvec4(ref.x && data[index].x, ref.y && data[index].y, ref.z && data[index].z, ref.w && data[index].w);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  bvec4 ref = bvec4(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = bvec4(ref.x && data[index].x, ref.y && data[index].y, ref.z && data[index].z, ref.w && data[index].w);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = bvec4(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = bvec4(ref.x && data[index].x, ref.y && data[index].y, ref.z && data[index].z, ref.w && data[index].w);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<bool, 8> ref = vector<bool, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = vector<bool, 8>(ref[0] && data[index][0], ref[1] && data[index][1], ref[2] && data[index][2], ref[3] && data[index][3], ref[4] && data[index][4], ref[5] && data[index][5], ref[6] && data[index][6], ref[7] && data[index][7]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<bool, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = vector<bool, 8>(ref[0] && data[index][0], ref[1] && data[index][1], ref[2] && data[index][2], ref[3] && data[index][3], ref[4] && data[index][4], ref[5] && data[index][5], ref[6] && data[index][6], ref[7] && data[index][7]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<bool, 8> ref = vector<bool, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = vector<bool, 8>(ref[0] && data[index][0], ref[1] && data[index][1], ref[2] && data[index][2], ref[3] && data[index][3], ref[4] && data[index][4], ref[5] && data[index][5], ref[6] && data[index][6], ref[7] && data[index][7]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<bool, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = vector<bool, 8>(ref[0] && data[index][0], ref[1] && data[index][1], ref[2] && data[index][2], ref[3] && data[index][3], ref[4] && data[index][4], ref[5] && data[index][5], ref[6] && data[index][6], ref[7] && data[index][7]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<bool, 8> ref = vector<bool, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = vector<bool, 8>(ref[0] && data[index][0], ref[1] && data[index][1], ref[2] && data[index][2], ref[3] && data[index][3], ref[4] && data[index][4], ref[5] && data[index][5], ref[6] && data[index][6], ref[7] && data[index][7]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<bool, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = vector<bool, 8>(ref[0] && data[index][0], ref[1] && data[index][1], ref[2] && data[index][2], ref[3] && data[index][3], ref[4] && data[index][4], ref[5] && data[index][5], ref[6] && data[index][6], ref[7] && data[index][7]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<bool, 8> ref = vector<bool, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = vector<bool, 8>(ref[0] && data[index][0], ref[1] && data[index][1], ref[2] && data[index][2], ref[3] && data[index][3], ref[4] && data[index][4], ref[5] && data[index][5], ref[6] && data[index][6], ref[7] && data[index][7]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<bool, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = vector<bool, 8>(ref[0] && data[index][0], ref[1] && data[index][1], ref[2] && data[index][2], ref[3] && data[index][3], ref[4] && data[index][4], ref[5] && data[index][5], ref[6] && data[index][6], ref[7] && data[index][7]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<bool, 8> ref = vector<bool, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = vector<bool, 8>(ref[0] && data[index][0], ref[1] && data[index][1], ref[2] && data[index][2], ref[3] && data[index][3], ref[4] && data[index][4], ref[5] && data[index][5], ref[6] && data[index][6], ref[7] && data[index][7]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<bool, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = vector<bool, 8>(ref[0] && data[index][0], ref[1] && data[index][1], ref[2] && data[index][2], ref[3] && data[index][3], ref[4] && data[index][4], ref[5] && data[index][5], ref[6] && data[index][6], ref[7] && data[index][7]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<bool, 8> ref = vector<bool, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = vector<bool, 8>(ref[0] && data[index][0], ref[1] && data[index][1], ref[2] && data[index][2], ref[3] && data[index][3], ref[4] && data[index][4], ref[5] && data[index][5], ref[6] && data[index][6], ref[7] && data[index][7]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<bool, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = vector<bool, 8>(ref[0] && data[index][0], ref[1] && data[index][1], ref[2] && data[index][2], ref[3] && data[index][3], ref[4] && data[index][4], ref[5] && data[index][5], ref[6] && data[index][6], ref[7] && data[index][7]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_arithmetic: enable
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
  uint start = 0, end = gl_SubgroupSize;
  vector<bool, 8> ref = vector<bool, 8>(~0);
  tempRes = 0;
  uint identityOnly = 0x3;
  for (uint index = start; index < end; index++)
  {
    if (subgroupBallotBitExtract(mask, index))
    {
      ref = vector<bool, 8>(ref[0] && data[index][0], ref[1] && data[index][1], ref[2] && data[index][2], ref[3] && data[index][3], ref[4] && data[index][4], ref[5] && data[index][5], ref[6] && data[index][6], ref[7] && data[index][7]);
      identityOnly &= ~0x1;
    }
  }
  tempRes = all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x1 : 0;
  if (1 == (gl_SubgroupInvocationID % 2))
  {
    mask = subgroupBallot(true);
    ref = vector<bool, 8>(~0);
    for (uint index = start; index < end; index++)
    {
      if (subgroupBallotBitExtract(mask, index))
      {
        ref = vector<bool, 8>(ref[0] && data[index][0], ref[1] && data[index][1], ref[2] && data[index][2], ref[3] && data[index][3], ref[4] && data[index][4], ref[5] && data[index][5], ref[6] && data[index][6], ref[7] && data[index][7]);
        identityOnly &= ~0x2;
      }
    }
    tempRes |= all(equal(ref, subgroupAnd(data[gl_SubgroupInvocationID]))) ? 0x2 : 0;
  }
  else
  {
    tempRes |= 0x2;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
