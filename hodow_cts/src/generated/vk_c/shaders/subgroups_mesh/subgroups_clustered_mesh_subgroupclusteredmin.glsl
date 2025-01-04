#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  int8_t data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      int8_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int8_t ref = int8_t(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int8_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int8_t ref = int8_t(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int8_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int8_t ref = int8_t(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int8_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int8_t ref = int8_t(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int8_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int8_t ref = int8_t(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int8_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int8_t ref = int8_t(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int8_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int8_t ref = int8_t(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int8_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int8_t ref = int8_t(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
          {
            tempResult = false;
          }
        }
      }
    }
  }
  tempRes = tempResult ? 1 : 0;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  int8_t data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      int8_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int8_t ref = int8_t(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int8_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int8_t ref = int8_t(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int8_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int8_t ref = int8_t(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int8_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int8_t ref = int8_t(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int8_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int8_t ref = int8_t(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int8_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int8_t ref = int8_t(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int8_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int8_t ref = int8_t(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int8_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int8_t ref = int8_t(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
          {
            tempResult = false;
          }
        }
      }
    }
  }
  tempRes = tempResult ? 1 : 0;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;

void main (void)
{
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  i8vec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      i8vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec2 ref = i8vec2(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i8vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec2 ref = i8vec2(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i8vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec2 ref = i8vec2(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i8vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec2 ref = i8vec2(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i8vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec2 ref = i8vec2(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i8vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec2 ref = i8vec2(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i8vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec2 ref = i8vec2(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i8vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec2 ref = i8vec2(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  i8vec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      i8vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec2 ref = i8vec2(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i8vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec2 ref = i8vec2(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i8vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec2 ref = i8vec2(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i8vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec2 ref = i8vec2(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i8vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec2 ref = i8vec2(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i8vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec2 ref = i8vec2(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i8vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec2 ref = i8vec2(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i8vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec2 ref = i8vec2(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  i8vec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      i8vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec3 ref = i8vec3(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i8vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec3 ref = i8vec3(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i8vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec3 ref = i8vec3(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i8vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec3 ref = i8vec3(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i8vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec3 ref = i8vec3(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i8vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec3 ref = i8vec3(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i8vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec3 ref = i8vec3(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i8vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec3 ref = i8vec3(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  i8vec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      i8vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec3 ref = i8vec3(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i8vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec3 ref = i8vec3(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i8vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec3 ref = i8vec3(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i8vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec3 ref = i8vec3(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i8vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec3 ref = i8vec3(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i8vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec3 ref = i8vec3(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i8vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec3 ref = i8vec3(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i8vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec3 ref = i8vec3(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  i8vec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      i8vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec4 ref = i8vec4(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i8vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec4 ref = i8vec4(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i8vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec4 ref = i8vec4(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i8vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec4 ref = i8vec4(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i8vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec4 ref = i8vec4(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i8vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec4 ref = i8vec4(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i8vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec4 ref = i8vec4(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i8vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec4 ref = i8vec4(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  i8vec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      i8vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec4 ref = i8vec4(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i8vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec4 ref = i8vec4(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i8vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec4 ref = i8vec4(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i8vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec4 ref = i8vec4(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i8vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec4 ref = i8vec4(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i8vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec4 ref = i8vec4(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i8vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec4 ref = i8vec4(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i8vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i8vec4 ref = i8vec4(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<int8_t, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      vector<int8_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int8_t, 8> ref = vector<int8_t, 8>(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int8_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int8_t, 8> ref = vector<int8_t, 8>(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int8_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int8_t, 8> ref = vector<int8_t, 8>(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int8_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int8_t, 8> ref = vector<int8_t, 8>(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int8_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int8_t, 8> ref = vector<int8_t, 8>(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int8_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int8_t, 8> ref = vector<int8_t, 8>(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int8_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int8_t, 8> ref = vector<int8_t, 8>(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int8_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int8_t, 8> ref = vector<int8_t, 8>(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<int8_t, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      vector<int8_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int8_t, 8> ref = vector<int8_t, 8>(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int8_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int8_t, 8> ref = vector<int8_t, 8>(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int8_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int8_t, 8> ref = vector<int8_t, 8>(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int8_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int8_t, 8> ref = vector<int8_t, 8>(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int8_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int8_t, 8> ref = vector<int8_t, 8>(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int8_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int8_t, 8> ref = vector<int8_t, 8>(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int8_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int8_t, 8> ref = vector<int8_t, 8>(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int8_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int8_t, 8> ref = vector<int8_t, 8>(0x7f);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  uint8_t data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      uint8_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint8_t ref = uint8_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint8_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint8_t ref = uint8_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint8_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint8_t ref = uint8_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint8_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint8_t ref = uint8_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint8_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint8_t ref = uint8_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint8_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint8_t ref = uint8_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint8_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint8_t ref = uint8_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint8_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint8_t ref = uint8_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
          {
            tempResult = false;
          }
        }
      }
    }
  }
  tempRes = tempResult ? 1 : 0;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  uint8_t data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      uint8_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint8_t ref = uint8_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint8_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint8_t ref = uint8_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint8_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint8_t ref = uint8_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint8_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint8_t ref = uint8_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint8_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint8_t ref = uint8_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint8_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint8_t ref = uint8_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint8_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint8_t ref = uint8_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint8_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint8_t ref = uint8_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
          {
            tempResult = false;
          }
        }
      }
    }
  }
  tempRes = tempResult ? 1 : 0;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  u8vec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      u8vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec2 ref = u8vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u8vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec2 ref = u8vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u8vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec2 ref = u8vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u8vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec2 ref = u8vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u8vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec2 ref = u8vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u8vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec2 ref = u8vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u8vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec2 ref = u8vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u8vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec2 ref = u8vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  u8vec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      u8vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec2 ref = u8vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u8vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec2 ref = u8vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u8vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec2 ref = u8vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u8vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec2 ref = u8vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u8vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec2 ref = u8vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u8vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec2 ref = u8vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u8vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec2 ref = u8vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u8vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec2 ref = u8vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  u8vec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      u8vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec3 ref = u8vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u8vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec3 ref = u8vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u8vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec3 ref = u8vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u8vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec3 ref = u8vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u8vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec3 ref = u8vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u8vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec3 ref = u8vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u8vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec3 ref = u8vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u8vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec3 ref = u8vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  u8vec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      u8vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec3 ref = u8vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u8vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec3 ref = u8vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u8vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec3 ref = u8vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u8vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec3 ref = u8vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u8vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec3 ref = u8vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u8vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec3 ref = u8vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u8vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec3 ref = u8vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u8vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec3 ref = u8vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  u8vec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      u8vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec4 ref = u8vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u8vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec4 ref = u8vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u8vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec4 ref = u8vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u8vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec4 ref = u8vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u8vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec4 ref = u8vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u8vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec4 ref = u8vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u8vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec4 ref = u8vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u8vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec4 ref = u8vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  u8vec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      u8vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec4 ref = u8vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u8vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec4 ref = u8vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u8vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec4 ref = u8vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u8vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec4 ref = u8vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u8vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec4 ref = u8vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u8vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec4 ref = u8vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u8vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec4 ref = u8vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u8vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u8vec4 ref = u8vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<uint8_t, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      vector<uint8_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint8_t, 8> ref = vector<uint8_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint8_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint8_t, 8> ref = vector<uint8_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint8_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint8_t, 8> ref = vector<uint8_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint8_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint8_t, 8> ref = vector<uint8_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint8_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint8_t, 8> ref = vector<uint8_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint8_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint8_t, 8> ref = vector<uint8_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint8_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint8_t, 8> ref = vector<uint8_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint8_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint8_t, 8> ref = vector<uint8_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<uint8_t, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      vector<uint8_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint8_t, 8> ref = vector<uint8_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint8_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint8_t, 8> ref = vector<uint8_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint8_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint8_t, 8> ref = vector<uint8_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint8_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint8_t, 8> ref = vector<uint8_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint8_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint8_t, 8> ref = vector<uint8_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint8_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint8_t, 8> ref = vector<uint8_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint8_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint8_t, 8> ref = vector<uint8_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint8_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint8_t, 8> ref = vector<uint8_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  int16_t data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      int16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int16_t ref = int16_t(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int16_t ref = int16_t(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int16_t ref = int16_t(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int16_t ref = int16_t(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int16_t ref = int16_t(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int16_t ref = int16_t(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int16_t ref = int16_t(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int16_t ref = int16_t(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
          {
            tempResult = false;
          }
        }
      }
    }
  }
  tempRes = tempResult ? 1 : 0;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  int16_t data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      int16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int16_t ref = int16_t(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int16_t ref = int16_t(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int16_t ref = int16_t(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int16_t ref = int16_t(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int16_t ref = int16_t(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int16_t ref = int16_t(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int16_t ref = int16_t(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int16_t ref = int16_t(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
          {
            tempResult = false;
          }
        }
      }
    }
  }
  tempRes = tempResult ? 1 : 0;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  i16vec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      i16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec2 ref = i16vec2(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec2 ref = i16vec2(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec2 ref = i16vec2(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec2 ref = i16vec2(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec2 ref = i16vec2(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec2 ref = i16vec2(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec2 ref = i16vec2(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec2 ref = i16vec2(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  i16vec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      i16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec2 ref = i16vec2(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec2 ref = i16vec2(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec2 ref = i16vec2(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec2 ref = i16vec2(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec2 ref = i16vec2(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec2 ref = i16vec2(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec2 ref = i16vec2(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec2 ref = i16vec2(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  i16vec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      i16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec3 ref = i16vec3(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec3 ref = i16vec3(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec3 ref = i16vec3(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec3 ref = i16vec3(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec3 ref = i16vec3(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec3 ref = i16vec3(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec3 ref = i16vec3(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec3 ref = i16vec3(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  i16vec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      i16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec3 ref = i16vec3(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec3 ref = i16vec3(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec3 ref = i16vec3(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec3 ref = i16vec3(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec3 ref = i16vec3(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec3 ref = i16vec3(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec3 ref = i16vec3(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec3 ref = i16vec3(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  i16vec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      i16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec4 ref = i16vec4(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec4 ref = i16vec4(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec4 ref = i16vec4(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec4 ref = i16vec4(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec4 ref = i16vec4(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec4 ref = i16vec4(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec4 ref = i16vec4(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec4 ref = i16vec4(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  i16vec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      i16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec4 ref = i16vec4(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec4 ref = i16vec4(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec4 ref = i16vec4(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec4 ref = i16vec4(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec4 ref = i16vec4(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec4 ref = i16vec4(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec4 ref = i16vec4(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i16vec4 ref = i16vec4(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<int16_t, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      vector<int16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int16_t, 8> ref = vector<int16_t, 8>(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int16_t, 8> ref = vector<int16_t, 8>(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int16_t, 8> ref = vector<int16_t, 8>(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int16_t, 8> ref = vector<int16_t, 8>(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int16_t, 8> ref = vector<int16_t, 8>(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int16_t, 8> ref = vector<int16_t, 8>(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int16_t, 8> ref = vector<int16_t, 8>(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int16_t, 8> ref = vector<int16_t, 8>(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<int16_t, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      vector<int16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int16_t, 8> ref = vector<int16_t, 8>(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int16_t, 8> ref = vector<int16_t, 8>(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int16_t, 8> ref = vector<int16_t, 8>(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int16_t, 8> ref = vector<int16_t, 8>(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int16_t, 8> ref = vector<int16_t, 8>(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int16_t, 8> ref = vector<int16_t, 8>(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int16_t, 8> ref = vector<int16_t, 8>(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int16_t, 8> ref = vector<int16_t, 8>(0x7fff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  uint16_t data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      uint16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint16_t ref = uint16_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint16_t ref = uint16_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint16_t ref = uint16_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint16_t ref = uint16_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint16_t ref = uint16_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint16_t ref = uint16_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint16_t ref = uint16_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint16_t ref = uint16_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
          {
            tempResult = false;
          }
        }
      }
    }
  }
  tempRes = tempResult ? 1 : 0;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  uint16_t data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      uint16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint16_t ref = uint16_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint16_t ref = uint16_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint16_t ref = uint16_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint16_t ref = uint16_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint16_t ref = uint16_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint16_t ref = uint16_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint16_t ref = uint16_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint16_t ref = uint16_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
          {
            tempResult = false;
          }
        }
      }
    }
  }
  tempRes = tempResult ? 1 : 0;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  u16vec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      u16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec2 ref = u16vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec2 ref = u16vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec2 ref = u16vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec2 ref = u16vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec2 ref = u16vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec2 ref = u16vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec2 ref = u16vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec2 ref = u16vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  u16vec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      u16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec2 ref = u16vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec2 ref = u16vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec2 ref = u16vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec2 ref = u16vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec2 ref = u16vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec2 ref = u16vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec2 ref = u16vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec2 ref = u16vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  u16vec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      u16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec3 ref = u16vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec3 ref = u16vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec3 ref = u16vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec3 ref = u16vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec3 ref = u16vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec3 ref = u16vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec3 ref = u16vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec3 ref = u16vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  u16vec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      u16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec3 ref = u16vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec3 ref = u16vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec3 ref = u16vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec3 ref = u16vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec3 ref = u16vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec3 ref = u16vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec3 ref = u16vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec3 ref = u16vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  u16vec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      u16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec4 ref = u16vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec4 ref = u16vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec4 ref = u16vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec4 ref = u16vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec4 ref = u16vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec4 ref = u16vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec4 ref = u16vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec4 ref = u16vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  u16vec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      u16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec4 ref = u16vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec4 ref = u16vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec4 ref = u16vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec4 ref = u16vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec4 ref = u16vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec4 ref = u16vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec4 ref = u16vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u16vec4 ref = u16vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<uint16_t, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      vector<uint16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint16_t, 8> ref = vector<uint16_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint16_t, 8> ref = vector<uint16_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint16_t, 8> ref = vector<uint16_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint16_t, 8> ref = vector<uint16_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint16_t, 8> ref = vector<uint16_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint16_t, 8> ref = vector<uint16_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint16_t, 8> ref = vector<uint16_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint16_t, 8> ref = vector<uint16_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<uint16_t, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      vector<uint16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint16_t, 8> ref = vector<uint16_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint16_t, 8> ref = vector<uint16_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint16_t, 8> ref = vector<uint16_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint16_t, 8> ref = vector<uint16_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint16_t, 8> ref = vector<uint16_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint16_t, 8> ref = vector<uint16_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint16_t, 8> ref = vector<uint16_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint16_t, 8> ref = vector<uint16_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  int data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      int op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int ref = int(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int ref = int(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int ref = int(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int ref = int(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int ref = int(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int ref = int(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int ref = int(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int ref = int(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
          {
            tempResult = false;
          }
        }
      }
    }
  }
  tempRes = tempResult ? 1 : 0;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  int data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      int op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int ref = int(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int ref = int(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int ref = int(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int ref = int(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int ref = int(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int ref = int(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int ref = int(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int ref = int(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
          {
            tempResult = false;
          }
        }
      }
    }
  }
  tempRes = tempResult ? 1 : 0;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  ivec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      ivec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec2 ref = ivec2(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      ivec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec2 ref = ivec2(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      ivec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec2 ref = ivec2(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      ivec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec2 ref = ivec2(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      ivec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec2 ref = ivec2(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      ivec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec2 ref = ivec2(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      ivec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec2 ref = ivec2(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      ivec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec2 ref = ivec2(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  ivec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      ivec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec2 ref = ivec2(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      ivec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec2 ref = ivec2(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      ivec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec2 ref = ivec2(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      ivec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec2 ref = ivec2(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      ivec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec2 ref = ivec2(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      ivec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec2 ref = ivec2(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      ivec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec2 ref = ivec2(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      ivec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec2 ref = ivec2(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  ivec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      ivec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec3 ref = ivec3(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      ivec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec3 ref = ivec3(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      ivec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec3 ref = ivec3(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      ivec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec3 ref = ivec3(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      ivec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec3 ref = ivec3(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      ivec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec3 ref = ivec3(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      ivec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec3 ref = ivec3(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      ivec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec3 ref = ivec3(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  ivec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      ivec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec3 ref = ivec3(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      ivec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec3 ref = ivec3(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      ivec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec3 ref = ivec3(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      ivec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec3 ref = ivec3(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      ivec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec3 ref = ivec3(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      ivec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec3 ref = ivec3(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      ivec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec3 ref = ivec3(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      ivec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec3 ref = ivec3(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  ivec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      ivec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec4 ref = ivec4(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      ivec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec4 ref = ivec4(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      ivec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec4 ref = ivec4(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      ivec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec4 ref = ivec4(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      ivec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec4 ref = ivec4(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      ivec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec4 ref = ivec4(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      ivec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec4 ref = ivec4(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      ivec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec4 ref = ivec4(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  ivec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      ivec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec4 ref = ivec4(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      ivec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec4 ref = ivec4(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      ivec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec4 ref = ivec4(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      ivec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec4 ref = ivec4(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      ivec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec4 ref = ivec4(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      ivec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec4 ref = ivec4(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      ivec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec4 ref = ivec4(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      ivec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        ivec4 ref = ivec4(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<int, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      vector<int, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int, 8> ref = vector<int, 8>(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int, 8> ref = vector<int, 8>(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int, 8> ref = vector<int, 8>(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int, 8> ref = vector<int, 8>(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int, 8> ref = vector<int, 8>(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int, 8> ref = vector<int, 8>(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int, 8> ref = vector<int, 8>(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int, 8> ref = vector<int, 8>(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<int, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      vector<int, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int, 8> ref = vector<int, 8>(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int, 8> ref = vector<int, 8>(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int, 8> ref = vector<int, 8>(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int, 8> ref = vector<int, 8>(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int, 8> ref = vector<int, 8>(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int, 8> ref = vector<int, 8>(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int, 8> ref = vector<int, 8>(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int, 8> ref = vector<int, 8>(0x7fffffff);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  uint data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      uint op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint ref = uint(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint ref = uint(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint ref = uint(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint ref = uint(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint ref = uint(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint ref = uint(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint ref = uint(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint ref = uint(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
          {
            tempResult = false;
          }
        }
      }
    }
  }
  tempRes = tempResult ? 1 : 0;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  uint data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      uint op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint ref = uint(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint ref = uint(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint ref = uint(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint ref = uint(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint ref = uint(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint ref = uint(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint ref = uint(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint ref = uint(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
          {
            tempResult = false;
          }
        }
      }
    }
  }
  tempRes = tempResult ? 1 : 0;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  uvec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      uvec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec2 ref = uvec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      uvec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec2 ref = uvec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      uvec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec2 ref = uvec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      uvec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec2 ref = uvec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      uvec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec2 ref = uvec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      uvec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec2 ref = uvec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      uvec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec2 ref = uvec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      uvec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec2 ref = uvec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  uvec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      uvec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec2 ref = uvec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      uvec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec2 ref = uvec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      uvec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec2 ref = uvec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      uvec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec2 ref = uvec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      uvec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec2 ref = uvec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      uvec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec2 ref = uvec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      uvec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec2 ref = uvec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      uvec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec2 ref = uvec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  uvec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      uvec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec3 ref = uvec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      uvec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec3 ref = uvec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      uvec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec3 ref = uvec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      uvec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec3 ref = uvec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      uvec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec3 ref = uvec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      uvec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec3 ref = uvec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      uvec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec3 ref = uvec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      uvec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec3 ref = uvec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  uvec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      uvec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec3 ref = uvec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      uvec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec3 ref = uvec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      uvec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec3 ref = uvec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      uvec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec3 ref = uvec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      uvec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec3 ref = uvec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      uvec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec3 ref = uvec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      uvec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec3 ref = uvec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      uvec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec3 ref = uvec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  uvec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      uvec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec4 ref = uvec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      uvec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec4 ref = uvec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      uvec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec4 ref = uvec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      uvec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec4 ref = uvec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      uvec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec4 ref = uvec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      uvec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec4 ref = uvec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      uvec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec4 ref = uvec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      uvec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec4 ref = uvec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  uvec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      uvec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec4 ref = uvec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      uvec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec4 ref = uvec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      uvec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec4 ref = uvec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      uvec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec4 ref = uvec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      uvec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec4 ref = uvec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      uvec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec4 ref = uvec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      uvec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec4 ref = uvec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      uvec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uvec4 ref = uvec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<uint, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      vector<uint, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint, 8> ref = vector<uint, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint, 8> ref = vector<uint, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint, 8> ref = vector<uint, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint, 8> ref = vector<uint, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint, 8> ref = vector<uint, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint, 8> ref = vector<uint, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint, 8> ref = vector<uint, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint, 8> ref = vector<uint, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<uint, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      vector<uint, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint, 8> ref = vector<uint, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint, 8> ref = vector<uint, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint, 8> ref = vector<uint, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint, 8> ref = vector<uint, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint, 8> ref = vector<uint, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint, 8> ref = vector<uint, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint, 8> ref = vector<uint, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint, 8> ref = vector<uint, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  int64_t data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      int64_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int64_t ref = int64_t(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int64_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int64_t ref = int64_t(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int64_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int64_t ref = int64_t(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int64_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int64_t ref = int64_t(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int64_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int64_t ref = int64_t(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int64_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int64_t ref = int64_t(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int64_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int64_t ref = int64_t(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int64_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int64_t ref = int64_t(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
          {
            tempResult = false;
          }
        }
      }
    }
  }
  tempRes = tempResult ? 1 : 0;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  int64_t data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      int64_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int64_t ref = int64_t(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int64_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int64_t ref = int64_t(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int64_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int64_t ref = int64_t(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int64_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int64_t ref = int64_t(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int64_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int64_t ref = int64_t(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int64_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int64_t ref = int64_t(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int64_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int64_t ref = int64_t(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      int64_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        int64_t ref = int64_t(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
          {
            tempResult = false;
          }
        }
      }
    }
  }
  tempRes = tempResult ? 1 : 0;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  i64vec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      i64vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec2 ref = i64vec2(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i64vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec2 ref = i64vec2(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i64vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec2 ref = i64vec2(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i64vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec2 ref = i64vec2(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i64vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec2 ref = i64vec2(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i64vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec2 ref = i64vec2(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i64vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec2 ref = i64vec2(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i64vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec2 ref = i64vec2(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  i64vec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      i64vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec2 ref = i64vec2(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i64vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec2 ref = i64vec2(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i64vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec2 ref = i64vec2(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i64vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec2 ref = i64vec2(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i64vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec2 ref = i64vec2(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i64vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec2 ref = i64vec2(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i64vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec2 ref = i64vec2(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i64vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec2 ref = i64vec2(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  i64vec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      i64vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec3 ref = i64vec3(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i64vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec3 ref = i64vec3(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i64vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec3 ref = i64vec3(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i64vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec3 ref = i64vec3(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i64vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec3 ref = i64vec3(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i64vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec3 ref = i64vec3(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i64vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec3 ref = i64vec3(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i64vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec3 ref = i64vec3(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  i64vec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      i64vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec3 ref = i64vec3(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i64vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec3 ref = i64vec3(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i64vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec3 ref = i64vec3(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i64vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec3 ref = i64vec3(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i64vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec3 ref = i64vec3(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i64vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec3 ref = i64vec3(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i64vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec3 ref = i64vec3(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i64vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec3 ref = i64vec3(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  i64vec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      i64vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec4 ref = i64vec4(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i64vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec4 ref = i64vec4(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i64vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec4 ref = i64vec4(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i64vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec4 ref = i64vec4(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i64vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec4 ref = i64vec4(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i64vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec4 ref = i64vec4(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i64vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec4 ref = i64vec4(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i64vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec4 ref = i64vec4(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  i64vec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      i64vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec4 ref = i64vec4(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i64vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec4 ref = i64vec4(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i64vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec4 ref = i64vec4(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i64vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec4 ref = i64vec4(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i64vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec4 ref = i64vec4(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i64vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec4 ref = i64vec4(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i64vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec4 ref = i64vec4(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      i64vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        i64vec4 ref = i64vec4(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<int64_t, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      vector<int64_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int64_t, 8> ref = vector<int64_t, 8>(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int64_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int64_t, 8> ref = vector<int64_t, 8>(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int64_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int64_t, 8> ref = vector<int64_t, 8>(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int64_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int64_t, 8> ref = vector<int64_t, 8>(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int64_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int64_t, 8> ref = vector<int64_t, 8>(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int64_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int64_t, 8> ref = vector<int64_t, 8>(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int64_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int64_t, 8> ref = vector<int64_t, 8>(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int64_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int64_t, 8> ref = vector<int64_t, 8>(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<int64_t, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      vector<int64_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int64_t, 8> ref = vector<int64_t, 8>(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int64_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int64_t, 8> ref = vector<int64_t, 8>(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int64_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int64_t, 8> ref = vector<int64_t, 8>(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int64_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int64_t, 8> ref = vector<int64_t, 8>(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int64_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int64_t, 8> ref = vector<int64_t, 8>(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int64_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int64_t, 8> ref = vector<int64_t, 8>(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int64_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int64_t, 8> ref = vector<int64_t, 8>(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<int64_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<int64_t, 8> ref = vector<int64_t, 8>(0x7fffffffffffffffUL);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  uint64_t data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      uint64_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint64_t ref = uint64_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint64_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint64_t ref = uint64_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint64_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint64_t ref = uint64_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint64_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint64_t ref = uint64_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint64_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint64_t ref = uint64_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint64_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint64_t ref = uint64_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint64_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint64_t ref = uint64_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint64_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint64_t ref = uint64_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
          {
            tempResult = false;
          }
        }
      }
    }
  }
  tempRes = tempResult ? 1 : 0;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  uint64_t data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      uint64_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint64_t ref = uint64_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint64_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint64_t ref = uint64_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint64_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint64_t ref = uint64_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint64_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint64_t ref = uint64_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint64_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint64_t ref = uint64_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint64_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint64_t ref = uint64_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint64_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint64_t ref = uint64_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      uint64_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        uint64_t ref = uint64_t(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
          {
            tempResult = false;
          }
        }
      }
    }
  }
  tempRes = tempResult ? 1 : 0;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  u64vec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      u64vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec2 ref = u64vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u64vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec2 ref = u64vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u64vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec2 ref = u64vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u64vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec2 ref = u64vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u64vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec2 ref = u64vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u64vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec2 ref = u64vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u64vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec2 ref = u64vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u64vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec2 ref = u64vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  u64vec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      u64vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec2 ref = u64vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u64vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec2 ref = u64vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u64vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec2 ref = u64vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u64vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec2 ref = u64vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u64vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec2 ref = u64vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u64vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec2 ref = u64vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u64vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec2 ref = u64vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u64vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec2 ref = u64vec2(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  u64vec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      u64vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec3 ref = u64vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u64vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec3 ref = u64vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u64vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec3 ref = u64vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u64vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec3 ref = u64vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u64vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec3 ref = u64vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u64vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec3 ref = u64vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u64vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec3 ref = u64vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u64vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec3 ref = u64vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  u64vec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      u64vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec3 ref = u64vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u64vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec3 ref = u64vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u64vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec3 ref = u64vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u64vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec3 ref = u64vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u64vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec3 ref = u64vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u64vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec3 ref = u64vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u64vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec3 ref = u64vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u64vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec3 ref = u64vec3(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  u64vec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      u64vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec4 ref = u64vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u64vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec4 ref = u64vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u64vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec4 ref = u64vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u64vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec4 ref = u64vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u64vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec4 ref = u64vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u64vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec4 ref = u64vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u64vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec4 ref = u64vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u64vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec4 ref = u64vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  u64vec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      u64vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec4 ref = u64vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u64vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec4 ref = u64vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u64vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec4 ref = u64vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u64vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec4 ref = u64vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u64vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec4 ref = u64vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u64vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec4 ref = u64vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u64vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec4 ref = u64vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      u64vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        u64vec4 ref = u64vec4(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<uint64_t, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      vector<uint64_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint64_t, 8> ref = vector<uint64_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint64_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint64_t, 8> ref = vector<uint64_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint64_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint64_t, 8> ref = vector<uint64_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint64_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint64_t, 8> ref = vector<uint64_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint64_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint64_t, 8> ref = vector<uint64_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint64_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint64_t, 8> ref = vector<uint64_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint64_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint64_t, 8> ref = vector<uint64_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint64_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint64_t, 8> ref = vector<uint64_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<uint64_t, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      vector<uint64_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint64_t, 8> ref = vector<uint64_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint64_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint64_t, 8> ref = vector<uint64_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint64_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint64_t, 8> ref = vector<uint64_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint64_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint64_t, 8> ref = vector<uint64_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint64_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint64_t, 8> ref = vector<uint64_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint64_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint64_t, 8> ref = vector<uint64_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint64_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint64_t, 8> ref = vector<uint64_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
      vector<uint64_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<uint64_t, 8> ref = vector<uint64_t, 8>(-1);
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = min(ref, data[index]);
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  float16_t data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      float16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        float16_t ref = float16_t(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      float16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        float16_t ref = float16_t(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      float16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        float16_t ref = float16_t(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      float16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        float16_t ref = float16_t(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      float16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        float16_t ref = float16_t(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      float16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        float16_t ref = float16_t(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      float16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        float16_t ref = float16_t(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      float16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        float16_t ref = float16_t(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
          {
            tempResult = false;
          }
        }
      }
    }
  }
  tempRes = tempResult ? 1 : 0;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  float16_t data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      float16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        float16_t ref = float16_t(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      float16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        float16_t ref = float16_t(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      float16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        float16_t ref = float16_t(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      float16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        float16_t ref = float16_t(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      float16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        float16_t ref = float16_t(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      float16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        float16_t ref = float16_t(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      float16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        float16_t ref = float16_t(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      float16_t op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        float16_t ref = float16_t(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
          {
            tempResult = false;
          }
        }
      }
    }
  }
  tempRes = tempResult ? 1 : 0;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  f16vec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      f16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec2 ref = f16vec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      f16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec2 ref = f16vec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      f16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec2 ref = f16vec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      f16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec2 ref = f16vec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      f16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec2 ref = f16vec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      f16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec2 ref = f16vec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      f16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec2 ref = f16vec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      f16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec2 ref = f16vec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  f16vec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      f16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec2 ref = f16vec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      f16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec2 ref = f16vec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      f16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec2 ref = f16vec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      f16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec2 ref = f16vec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      f16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec2 ref = f16vec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      f16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec2 ref = f16vec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      f16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec2 ref = f16vec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      f16vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec2 ref = f16vec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  f16vec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      f16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec3 ref = f16vec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      f16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec3 ref = f16vec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      f16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec3 ref = f16vec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      f16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec3 ref = f16vec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      f16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec3 ref = f16vec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      f16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec3 ref = f16vec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      f16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec3 ref = f16vec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      f16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec3 ref = f16vec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  f16vec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      f16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec3 ref = f16vec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      f16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec3 ref = f16vec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      f16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec3 ref = f16vec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      f16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec3 ref = f16vec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      f16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec3 ref = f16vec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      f16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec3 ref = f16vec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      f16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec3 ref = f16vec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      f16vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec3 ref = f16vec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  f16vec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      f16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec4 ref = f16vec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      f16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec4 ref = f16vec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      f16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec4 ref = f16vec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      f16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec4 ref = f16vec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      f16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec4 ref = f16vec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      f16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec4 ref = f16vec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      f16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec4 ref = f16vec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      f16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec4 ref = f16vec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  f16vec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      f16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec4 ref = f16vec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      f16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec4 ref = f16vec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      f16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec4 ref = f16vec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      f16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec4 ref = f16vec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      f16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec4 ref = f16vec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      f16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec4 ref = f16vec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      f16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec4 ref = f16vec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      f16vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        f16vec4 ref = f16vec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<float16_t, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      vector<float16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<float16_t, 8> ref = vector<float16_t, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vector<float16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<float16_t, 8> ref = vector<float16_t, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vector<float16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<float16_t, 8> ref = vector<float16_t, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vector<float16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<float16_t, 8> ref = vector<float16_t, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vector<float16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<float16_t, 8> ref = vector<float16_t, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vector<float16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<float16_t, 8> ref = vector<float16_t, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vector<float16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<float16_t, 8> ref = vector<float16_t, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vector<float16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<float16_t, 8> ref = vector<float16_t, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<float16_t, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      vector<float16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<float16_t, 8> ref = vector<float16_t, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vector<float16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<float16_t, 8> ref = vector<float16_t, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vector<float16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<float16_t, 8> ref = vector<float16_t, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vector<float16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<float16_t, 8> ref = vector<float16_t, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vector<float16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<float16_t, 8> ref = vector<float16_t, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vector<float16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<float16_t, 8> ref = vector<float16_t, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vector<float16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<float16_t, 8> ref = vector<float16_t, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vector<float16_t, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<float16_t, 8> ref = vector<float16_t, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  float data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      float op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        float ref = float(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      float op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        float ref = float(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      float op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        float ref = float(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      float op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        float ref = float(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      float op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        float ref = float(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      float op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        float ref = float(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      float op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        float ref = float(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      float op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        float ref = float(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
          {
            tempResult = false;
          }
        }
      }
    }
  }
  tempRes = tempResult ? 1 : 0;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  float data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      float op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        float ref = float(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      float op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        float ref = float(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      float op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        float ref = float(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      float op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        float ref = float(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      float op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        float ref = float(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      float op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        float ref = float(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      float op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        float ref = float(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      float op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        float ref = float(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
          {
            tempResult = false;
          }
        }
      }
    }
  }
  tempRes = tempResult ? 1 : 0;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec2 ref = vec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec2 ref = vec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec2 ref = vec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec2 ref = vec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec2 ref = vec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec2 ref = vec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec2 ref = vec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec2 ref = vec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec2 ref = vec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec2 ref = vec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec2 ref = vec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec2 ref = vec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec2 ref = vec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec2 ref = vec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec2 ref = vec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec2 ref = vec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec3 ref = vec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec3 ref = vec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec3 ref = vec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec3 ref = vec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec3 ref = vec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec3 ref = vec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec3 ref = vec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec3 ref = vec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec3 ref = vec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec3 ref = vec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec3 ref = vec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec3 ref = vec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec3 ref = vec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec3 ref = vec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec3 ref = vec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec3 ref = vec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec4 ref = vec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec4 ref = vec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec4 ref = vec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec4 ref = vec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec4 ref = vec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec4 ref = vec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec4 ref = vec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec4 ref = vec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec4 ref = vec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec4 ref = vec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec4 ref = vec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec4 ref = vec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec4 ref = vec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec4 ref = vec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec4 ref = vec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vec4 ref = vec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<float, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      vector<float, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<float, 8> ref = vector<float, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vector<float, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<float, 8> ref = vector<float, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vector<float, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<float, 8> ref = vector<float, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vector<float, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<float, 8> ref = vector<float, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vector<float, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<float, 8> ref = vector<float, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vector<float, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<float, 8> ref = vector<float, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vector<float, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<float, 8> ref = vector<float, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vector<float, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<float, 8> ref = vector<float, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<float, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      vector<float, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<float, 8> ref = vector<float, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vector<float, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<float, 8> ref = vector<float, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vector<float, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<float, 8> ref = vector<float, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vector<float, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<float, 8> ref = vector<float, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vector<float, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<float, 8> ref = vector<float, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vector<float, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<float, 8> ref = vector<float, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vector<float, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<float, 8> ref = vector<float, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vector<float, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<float, 8> ref = vector<float, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  double data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      double op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        double ref = double(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      double op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        double ref = double(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      double op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        double ref = double(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      double op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        double ref = double(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      double op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        double ref = double(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      double op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        double ref = double(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      double op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        double ref = double(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      double op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        double ref = double(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
          {
            tempResult = false;
          }
        }
      }
    }
  }
  tempRes = tempResult ? 1 : 0;
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  double data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      double op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        double ref = double(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      double op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        double ref = double(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      double op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        double ref = double(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      double op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        double ref = double(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      double op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        double ref = double(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      double op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        double ref = double(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      double op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        double ref = double(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
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
      double op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        double ref = double(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = (isnan(ref) ? data[index] : (isnan(data[index]) ? ref : min(ref, data[index])));
          }
        }
        if ((clusterOffset <= gl_SubgroupInvocationID) && (gl_SubgroupInvocationID < (clusterOffset + clusterSize)))
        {
          if (!(ref == op))
          {
            tempResult = false;
          }
        }
      }
    }
  }
  tempRes = tempResult ? 1 : 0;
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  dvec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      dvec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec2 ref = dvec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      dvec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec2 ref = dvec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      dvec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec2 ref = dvec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      dvec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec2 ref = dvec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      dvec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec2 ref = dvec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      dvec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec2 ref = dvec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      dvec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec2 ref = dvec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      dvec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec2 ref = dvec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  dvec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      dvec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec2 ref = dvec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      dvec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec2 ref = dvec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      dvec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec2 ref = dvec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      dvec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec2 ref = dvec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      dvec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec2 ref = dvec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      dvec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec2 ref = dvec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      dvec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec2 ref = dvec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      dvec2 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec2 ref = dvec2(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  dvec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      dvec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec3 ref = dvec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      dvec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec3 ref = dvec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      dvec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec3 ref = dvec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      dvec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec3 ref = dvec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      dvec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec3 ref = dvec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      dvec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec3 ref = dvec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      dvec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec3 ref = dvec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      dvec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec3 ref = dvec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  dvec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      dvec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec3 ref = dvec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      dvec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec3 ref = dvec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      dvec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec3 ref = dvec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      dvec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec3 ref = dvec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      dvec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec3 ref = dvec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      dvec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec3 ref = dvec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      dvec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec3 ref = dvec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      dvec3 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec3 ref = dvec3(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  dvec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      dvec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec4 ref = dvec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      dvec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec4 ref = dvec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      dvec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec4 ref = dvec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      dvec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec4 ref = dvec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      dvec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec4 ref = dvec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      dvec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec4 ref = dvec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      dvec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec4 ref = dvec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      dvec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec4 ref = dvec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  dvec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      dvec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec4 ref = dvec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      dvec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec4 ref = dvec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      dvec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec4 ref = dvec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      dvec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec4 ref = dvec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      dvec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec4 ref = dvec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      dvec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec4 ref = dvec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      dvec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec4 ref = dvec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      dvec4 op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        dvec4 ref = dvec4(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout (points) out;
layout (max_vertices = 1, max_primitives = 1) out;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<double, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      vector<double, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<double, 8> ref = vector<double, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vector<double, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<double, 8> ref = vector<double, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vector<double, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<double, 8> ref = vector<double, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vector<double, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<double, 8> ref = vector<double, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vector<double, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<double, 8> ref = vector<double, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vector<double, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<double, 8> ref = vector<double, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vector<double, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<double, 8> ref = vector<double, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vector<double, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<double, 8> ref = vector<double, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
  result[offset] = tempRes;
  SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_clustered: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<double, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool tempResult = true;
  uvec4 mask = subgroupBallot(true);
  {
    const uint clusterSize = 1;
    if (clusterSize <= gl_SubgroupSize)
    {
      vector<double, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<double, 8> ref = vector<double, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vector<double, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<double, 8> ref = vector<double, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vector<double, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<double, 8> ref = vector<double, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vector<double, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<double, 8> ref = vector<double, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vector<double, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<double, 8> ref = vector<double, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vector<double, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<double, 8> ref = vector<double, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vector<double, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<double, 8> ref = vector<double, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
      vector<double, 8> op = subgroupClusteredMin(data[gl_SubgroupInvocationID], clusterSize);
      for (uint clusterOffset = 0; clusterOffset < gl_SubgroupSize; clusterOffset += clusterSize)
      {
        vector<double, 8> ref = vector<double, 8>(intBitsToFloat(0x7f800000));
        for (uint index = clusterOffset; index < (clusterOffset + clusterSize); index++)
        {
          if (subgroupBallotBitExtract(mask, index))
          {
            ref = mix(mix(min(ref, data[index]), ref, isnan(data[index])), data[index], isnan(ref));
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
  result[offset] = tempRes;
  EmitMeshTasksEXT(0, 0, 0);
}
