#version 450
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  if (gl_SubgroupSize >= 1)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 1);
    uint rootID = gl_SubgroupInvocationID & ~(0);
    for (uint i = 0; i < 1; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 2)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 2);
    uint rootID = gl_SubgroupInvocationID & ~(1);
    for (uint i = 0; i < 2; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 4)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 4);
    uint rootID = gl_SubgroupInvocationID & ~(3);
    for (uint i = 0; i < 4; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 8)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 8);
    uint rootID = gl_SubgroupInvocationID & ~(7);
    for (uint i = 0; i < 8; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 16)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 16);
    uint rootID = gl_SubgroupInvocationID & ~(15);
    for (uint i = 0; i < 16; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 32)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 32);
    uint rootID = gl_SubgroupInvocationID & ~(31);
    for (uint i = 0; i < 32; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 64)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 64);
    uint rootID = gl_SubgroupInvocationID & ~(63);
    for (uint i = 0; i < 64; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 128)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 128);
    uint rootID = gl_SubgroupInvocationID & ~(127);
    for (uint i = 0; i < 128; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  tempRes = tempResult;
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  if (gl_SubgroupSize >= 1)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 1);
    uint rootID = gl_SubgroupInvocationID & ~(0);
    for (uint i = 0; i < 1; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 2)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 2);
    uint rootID = gl_SubgroupInvocationID & ~(1);
    for (uint i = 0; i < 2; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 4)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 4);
    uint rootID = gl_SubgroupInvocationID & ~(3);
    for (uint i = 0; i < 4; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 8)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 8);
    uint rootID = gl_SubgroupInvocationID & ~(7);
    for (uint i = 0; i < 8; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 16)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 16);
    uint rootID = gl_SubgroupInvocationID & ~(15);
    for (uint i = 0; i < 16; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 32)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 32);
    uint rootID = gl_SubgroupInvocationID & ~(31);
    for (uint i = 0; i < 32; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 64)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 64);
    uint rootID = gl_SubgroupInvocationID & ~(63);
    for (uint i = 0; i < 64; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 128)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 128);
    uint rootID = gl_SubgroupInvocationID & ~(127);
    for (uint i = 0; i < 128; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  tempRes = tempResult;
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  if (gl_SubgroupSize >= 1)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 1);
    uint rootID = gl_SubgroupInvocationID & ~(0);
    for (uint i = 0; i < 1; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 2)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 2);
    uint rootID = gl_SubgroupInvocationID & ~(1);
    for (uint i = 0; i < 2; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 4)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 4);
    uint rootID = gl_SubgroupInvocationID & ~(3);
    for (uint i = 0; i < 4; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 8)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 8);
    uint rootID = gl_SubgroupInvocationID & ~(7);
    for (uint i = 0; i < 8; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 16)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 16);
    uint rootID = gl_SubgroupInvocationID & ~(15);
    for (uint i = 0; i < 16; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 32)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 32);
    uint rootID = gl_SubgroupInvocationID & ~(31);
    for (uint i = 0; i < 32; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 64)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 64);
    uint rootID = gl_SubgroupInvocationID & ~(63);
    for (uint i = 0; i < 64; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 128)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 128);
    uint rootID = gl_SubgroupInvocationID & ~(127);
    for (uint i = 0; i < 128; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  tempRes = tempResult;
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  if (gl_SubgroupSize >= 1)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 1);
    uint rootID = gl_SubgroupInvocationID & ~(0);
    for (uint i = 0; i < 1; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 2)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 2);
    uint rootID = gl_SubgroupInvocationID & ~(1);
    for (uint i = 0; i < 2; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 4)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 4);
    uint rootID = gl_SubgroupInvocationID & ~(3);
    for (uint i = 0; i < 4; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 8)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 8);
    uint rootID = gl_SubgroupInvocationID & ~(7);
    for (uint i = 0; i < 8; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 16)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 16);
    uint rootID = gl_SubgroupInvocationID & ~(15);
    for (uint i = 0; i < 16; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 32)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 32);
    uint rootID = gl_SubgroupInvocationID & ~(31);
    for (uint i = 0; i < 32; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 64)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 64);
    uint rootID = gl_SubgroupInvocationID & ~(63);
    for (uint i = 0; i < 64; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 128)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 128);
    uint rootID = gl_SubgroupInvocationID & ~(127);
    for (uint i = 0; i < 128; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  tempRes = tempResult;
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  if (gl_SubgroupSize >= 1)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 1);
    uint rootID = gl_SubgroupInvocationID & ~(0);
    for (uint i = 0; i < 1; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 2)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 2);
    uint rootID = gl_SubgroupInvocationID & ~(1);
    for (uint i = 0; i < 2; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 4)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 4);
    uint rootID = gl_SubgroupInvocationID & ~(3);
    for (uint i = 0; i < 4; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 8)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 8);
    uint rootID = gl_SubgroupInvocationID & ~(7);
    for (uint i = 0; i < 8; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 16)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 16);
    uint rootID = gl_SubgroupInvocationID & ~(15);
    for (uint i = 0; i < 16; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 32)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 32);
    uint rootID = gl_SubgroupInvocationID & ~(31);
    for (uint i = 0; i < 32; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 64)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 64);
    uint rootID = gl_SubgroupInvocationID & ~(63);
    for (uint i = 0; i < 64; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 128)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 128);
    uint rootID = gl_SubgroupInvocationID & ~(127);
    for (uint i = 0; i < 128; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  tempRes = tempResult;
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  if (gl_SubgroupSize >= 1)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 1);
    uint rootID = gl_SubgroupInvocationID & ~(0);
    for (uint i = 0; i < 1; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 2)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 2);
    uint rootID = gl_SubgroupInvocationID & ~(1);
    for (uint i = 0; i < 2; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 4)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 4);
    uint rootID = gl_SubgroupInvocationID & ~(3);
    for (uint i = 0; i < 4; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 8)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 8);
    uint rootID = gl_SubgroupInvocationID & ~(7);
    for (uint i = 0; i < 8; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 16)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 16);
    uint rootID = gl_SubgroupInvocationID & ~(15);
    for (uint i = 0; i < 16; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 32)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 32);
    uint rootID = gl_SubgroupInvocationID & ~(31);
    for (uint i = 0; i < 32; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 64)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 64);
    uint rootID = gl_SubgroupInvocationID & ~(63);
    for (uint i = 0; i < 64; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 128)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 128);
    uint rootID = gl_SubgroupInvocationID & ~(127);
    for (uint i = 0; i < 128; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  tempRes = tempResult;
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;

void main (void)
{
  uint tempRes;
  uint tempResult = 0x1;
  uvec4 mask = subgroupBallot(true);
  if (gl_SubgroupSize >= 1)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 1);
    uint rootID = gl_SubgroupInvocationID & ~(0);
    for (uint i = 0; i < 1; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 2)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 2);
    uint rootID = gl_SubgroupInvocationID & ~(1);
    for (uint i = 0; i < 2; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 4)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 4);
    uint rootID = gl_SubgroupInvocationID & ~(3);
    for (uint i = 0; i < 4; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 8)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 8);
    uint rootID = gl_SubgroupInvocationID & ~(7);
    for (uint i = 0; i < 8; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 16)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 16);
    uint rootID = gl_SubgroupInvocationID & ~(15);
    for (uint i = 0; i < 16; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 32)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 32);
    uint rootID = gl_SubgroupInvocationID & ~(31);
    for (uint i = 0; i < 32; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 64)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 64);
    uint rootID = gl_SubgroupInvocationID & ~(63);
    for (uint i = 0; i < 64; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  if (gl_SubgroupSize >= 128)
  {
    uvec4 contribution = uvec4(0);
    const uint modID = gl_SubgroupInvocationID % 32;
    switch (gl_SubgroupInvocationID / 32)
    {
    case 0: contribution.x = 1 << modID; break;
    case 1: contribution.y = 1 << modID; break;
    case 2: contribution.z = 1 << modID; break;
    case 3: contribution.w = 1 << modID; break;
    }
    uvec4 result = subgroupClusteredOr(contribution, 128);
    uint rootID = gl_SubgroupInvocationID & ~(127);
    for (uint i = 0; i < 128; i++)
    {
      uint nextID = rootID + i;
      if (subgroupBallotBitExtract(mask, nextID) ^^ subgroupBallotBitExtract(result, nextID))
      {
        tempResult = 0;
      }
    }
  }
  tempRes = tempResult;
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
