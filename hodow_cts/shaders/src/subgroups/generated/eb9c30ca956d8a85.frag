#version 450
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  double data[];
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
      double op = subgroupClusteredAdd(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        double ref = double(0);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = ref + data[index];
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(abs(ref - op) < (gl_SubgroupSize==128 ? 0.000025:0.00001)))
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
      double op = subgroupClusteredAdd(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        double ref = double(0);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = ref + data[index];
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(abs(ref - op) < (gl_SubgroupSize==128 ? 0.000025:0.00001)))
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
      double op = subgroupClusteredAdd(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        double ref = double(0);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = ref + data[index];
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(abs(ref - op) < (gl_SubgroupSize==128 ? 0.000025:0.00001)))
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
      double op = subgroupClusteredAdd(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        double ref = double(0);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = ref + data[index];
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(abs(ref - op) < (gl_SubgroupSize==128 ? 0.000025:0.00001)))
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
      double op = subgroupClusteredAdd(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        double ref = double(0);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = ref + data[index];
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(abs(ref - op) < (gl_SubgroupSize==128 ? 0.000025:0.00001)))
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
      double op = subgroupClusteredAdd(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        double ref = double(0);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = ref + data[index];
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(abs(ref - op) < (gl_SubgroupSize==128 ? 0.000025:0.00001)))
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
      double op = subgroupClusteredAdd(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        double ref = double(0);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = ref + data[index];
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(abs(ref - op) < (gl_SubgroupSize==128 ? 0.000025:0.00001)))
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
      double op = subgroupClusteredAdd(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        double ref = double(0);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = ref + data[index];
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(abs(ref - op) < (gl_SubgroupSize==128 ? 0.000025:0.00001)))
          {
            tempResult = false;
          }
        }
      }
    }
  }
  tempRes = tempResult ? 1 : 0;
  result = tempRes;
}
