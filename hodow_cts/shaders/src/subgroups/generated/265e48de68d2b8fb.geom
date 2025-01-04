#version 450
#extension GL_KHR_shader_subgroup_clustered: enable
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
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      vector<bool, 8> op = subgroupClusteredAnd(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<bool, 8> ref = vector<bool, 8>(~0);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = vector<bool, 8>(ref[0] && data[index][0], ref[1] && data[index][1], ref[2] && data[index][2], ref[3] && data[index][3], ref[4] && data[index][4], ref[5] && data[index][5], ref[6] && data[index][6], ref[7] && data[index][7]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!all(equal(ref, op)))
          {
            tempResult = false;
          }
        }
      }
    }
  }
  {
    const uint clusterSize = 2;
    if (clusterSize <= gl_SubgroupSize)
    {
      vector<bool, 8> op = subgroupClusteredAnd(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<bool, 8> ref = vector<bool, 8>(~0);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = vector<bool, 8>(ref[0] && data[index][0], ref[1] && data[index][1], ref[2] && data[index][2], ref[3] && data[index][3], ref[4] && data[index][4], ref[5] && data[index][5], ref[6] && data[index][6], ref[7] && data[index][7]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!all(equal(ref, op)))
          {
            tempResult = false;
          }
        }
      }
    }
  }
  {
    const uint clusterSize = 4;
    if (clusterSize <= gl_SubgroupSize)
    {
      vector<bool, 8> op = subgroupClusteredAnd(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<bool, 8> ref = vector<bool, 8>(~0);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = vector<bool, 8>(ref[0] && data[index][0], ref[1] && data[index][1], ref[2] && data[index][2], ref[3] && data[index][3], ref[4] && data[index][4], ref[5] && data[index][5], ref[6] && data[index][6], ref[7] && data[index][7]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!all(equal(ref, op)))
          {
            tempResult = false;
          }
        }
      }
    }
  }
  {
    const uint clusterSize = 8;
    if (clusterSize <= gl_SubgroupSize)
    {
      vector<bool, 8> op = subgroupClusteredAnd(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<bool, 8> ref = vector<bool, 8>(~0);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = vector<bool, 8>(ref[0] && data[index][0], ref[1] && data[index][1], ref[2] && data[index][2], ref[3] && data[index][3], ref[4] && data[index][4], ref[5] && data[index][5], ref[6] && data[index][6], ref[7] && data[index][7]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!all(equal(ref, op)))
          {
            tempResult = false;
          }
        }
      }
    }
  }
  {
    const uint clusterSize = 16;
    if (clusterSize <= gl_SubgroupSize)
    {
      vector<bool, 8> op = subgroupClusteredAnd(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<bool, 8> ref = vector<bool, 8>(~0);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = vector<bool, 8>(ref[0] && data[index][0], ref[1] && data[index][1], ref[2] && data[index][2], ref[3] && data[index][3], ref[4] && data[index][4], ref[5] && data[index][5], ref[6] && data[index][6], ref[7] && data[index][7]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!all(equal(ref, op)))
          {
            tempResult = false;
          }
        }
      }
    }
  }
  {
    const uint clusterSize = 32;
    if (clusterSize <= gl_SubgroupSize)
    {
      vector<bool, 8> op = subgroupClusteredAnd(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<bool, 8> ref = vector<bool, 8>(~0);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = vector<bool, 8>(ref[0] && data[index][0], ref[1] && data[index][1], ref[2] && data[index][2], ref[3] && data[index][3], ref[4] && data[index][4], ref[5] && data[index][5], ref[6] && data[index][6], ref[7] && data[index][7]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!all(equal(ref, op)))
          {
            tempResult = false;
          }
        }
      }
    }
  }
  {
    const uint clusterSize = 64;
    if (clusterSize <= gl_SubgroupSize)
    {
      vector<bool, 8> op = subgroupClusteredAnd(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<bool, 8> ref = vector<bool, 8>(~0);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = vector<bool, 8>(ref[0] && data[index][0], ref[1] && data[index][1], ref[2] && data[index][2], ref[3] && data[index][3], ref[4] && data[index][4], ref[5] && data[index][5], ref[6] && data[index][6], ref[7] && data[index][7]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!all(equal(ref, op)))
          {
            tempResult = false;
          }
        }
      }
    }
  }
  {
    const uint clusterSize = 128;
    if (clusterSize <= gl_SubgroupSize)
    {
      vector<bool, 8> op = subgroupClusteredAnd(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<bool, 8> ref = vector<bool, 8>(~0);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = vector<bool, 8>(ref[0] && data[index][0], ref[1] && data[index][1], ref[2] && data[index][2], ref[3] && data[index][3], ref[4] && data[index][4], ref[5] && data[index][5], ref[6] && data[index][6], ref[7] && data[index][7]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!all(equal(ref, op)))
          {
            tempResult = false;
          }
        }
      }
    }
  }
  tempRes = tempResult ? 1 : 0;
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
