#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  int8_t valueEqual = int8_t(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  int8_t valueNoEqual = int8_t(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(int8_t(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(int8_t(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  i8vec2 valueEqual = i8vec2(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  i8vec2 valueNoEqual = i8vec2(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(i8vec2(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(i8vec2(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  i8vec3 valueEqual = i8vec3(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  i8vec3 valueNoEqual = i8vec3(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(i8vec3(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(i8vec3(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  i8vec4 valueEqual = i8vec4(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  i8vec4 valueNoEqual = i8vec4(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(i8vec4(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(i8vec4(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  vector<int8_t, 8> valueEqual = vector<int8_t, 8>(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  vector<int8_t, 8> valueNoEqual = vector<int8_t, 8>(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(vector<int8_t, 8>(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(vector<int8_t, 8>(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  uint8_t valueEqual = uint8_t(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  uint8_t valueNoEqual = uint8_t(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(uint8_t(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(uint8_t(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  u8vec2 valueEqual = u8vec2(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  u8vec2 valueNoEqual = u8vec2(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(u8vec2(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(u8vec2(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  u8vec3 valueEqual = u8vec3(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  u8vec3 valueNoEqual = u8vec3(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(u8vec3(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(u8vec3(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  u8vec4 valueEqual = u8vec4(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  u8vec4 valueNoEqual = u8vec4(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(u8vec4(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(u8vec4(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  vector<uint8_t, 8> valueEqual = vector<uint8_t, 8>(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  vector<uint8_t, 8> valueNoEqual = vector<uint8_t, 8>(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(vector<uint8_t, 8>(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(vector<uint8_t, 8>(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  int16_t valueEqual = int16_t(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  int16_t valueNoEqual = int16_t(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(int16_t(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(int16_t(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  i16vec2 valueEqual = i16vec2(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  i16vec2 valueNoEqual = i16vec2(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(i16vec2(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(i16vec2(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  i16vec3 valueEqual = i16vec3(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  i16vec3 valueNoEqual = i16vec3(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(i16vec3(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(i16vec3(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  i16vec4 valueEqual = i16vec4(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  i16vec4 valueNoEqual = i16vec4(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(i16vec4(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(i16vec4(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  vector<int16_t, 8> valueEqual = vector<int16_t, 8>(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  vector<int16_t, 8> valueNoEqual = vector<int16_t, 8>(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(vector<int16_t, 8>(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(vector<int16_t, 8>(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  uint16_t valueEqual = uint16_t(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  uint16_t valueNoEqual = uint16_t(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(uint16_t(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(uint16_t(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  u16vec2 valueEqual = u16vec2(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  u16vec2 valueNoEqual = u16vec2(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(u16vec2(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(u16vec2(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  u16vec3 valueEqual = u16vec3(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  u16vec3 valueNoEqual = u16vec3(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(u16vec3(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(u16vec3(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  u16vec4 valueEqual = u16vec4(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  u16vec4 valueNoEqual = u16vec4(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(u16vec4(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(u16vec4(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  vector<uint16_t, 8> valueEqual = vector<uint16_t, 8>(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  vector<uint16_t, 8> valueNoEqual = vector<uint16_t, 8>(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(vector<uint16_t, 8>(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(vector<uint16_t, 8>(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  int valueEqual = int(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  int valueNoEqual = int(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(int(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(int(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  ivec2 valueEqual = ivec2(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  ivec2 valueNoEqual = ivec2(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(ivec2(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(ivec2(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  ivec3 valueEqual = ivec3(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  ivec3 valueNoEqual = ivec3(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(ivec3(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(ivec3(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  ivec4 valueEqual = ivec4(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  ivec4 valueNoEqual = ivec4(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(ivec4(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(ivec4(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  vector<int, 8> valueEqual = vector<int, 8>(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  vector<int, 8> valueNoEqual = vector<int, 8>(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(vector<int, 8>(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(vector<int, 8>(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  uint valueEqual = uint(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  uint valueNoEqual = uint(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(uint(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(uint(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  uvec2 valueEqual = uvec2(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  uvec2 valueNoEqual = uvec2(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(uvec2(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(uvec2(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  uvec3 valueEqual = uvec3(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  uvec3 valueNoEqual = uvec3(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(uvec3(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(uvec3(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  uvec4 valueEqual = uvec4(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  uvec4 valueNoEqual = uvec4(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(uvec4(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(uvec4(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  vector<uint, 8> valueEqual = vector<uint, 8>(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  vector<uint, 8> valueNoEqual = vector<uint, 8>(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(vector<uint, 8>(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(vector<uint, 8>(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  int64_t valueEqual = int64_t(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  int64_t valueNoEqual = int64_t(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(int64_t(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(int64_t(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  i64vec2 valueEqual = i64vec2(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  i64vec2 valueNoEqual = i64vec2(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(i64vec2(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(i64vec2(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  i64vec3 valueEqual = i64vec3(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  i64vec3 valueNoEqual = i64vec3(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(i64vec3(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(i64vec3(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  i64vec4 valueEqual = i64vec4(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  i64vec4 valueNoEqual = i64vec4(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(i64vec4(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(i64vec4(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  vector<int64_t, 8> valueEqual = vector<int64_t, 8>(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  vector<int64_t, 8> valueNoEqual = vector<int64_t, 8>(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(vector<int64_t, 8>(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(vector<int64_t, 8>(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  uint64_t valueEqual = uint64_t(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  uint64_t valueNoEqual = uint64_t(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(uint64_t(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(uint64_t(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  u64vec2 valueEqual = u64vec2(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  u64vec2 valueNoEqual = u64vec2(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(u64vec2(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(u64vec2(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  u64vec3 valueEqual = u64vec3(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  u64vec3 valueNoEqual = u64vec3(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(u64vec3(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(u64vec3(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  u64vec4 valueEqual = u64vec4(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  u64vec4 valueNoEqual = u64vec4(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(u64vec4(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(u64vec4(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  vector<uint64_t, 8> valueEqual = vector<uint64_t, 8>(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  vector<uint64_t, 8> valueNoEqual = vector<uint64_t, 8>(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(vector<uint64_t, 8>(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(vector<uint64_t, 8>(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  float16_t valueEqual = float16_t(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  float16_t valueNoEqual = float16_t(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(float16_t(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(float16_t(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  f16vec2 valueEqual = f16vec2(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  f16vec2 valueNoEqual = f16vec2(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(f16vec2(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(f16vec2(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  f16vec3 valueEqual = f16vec3(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  f16vec3 valueNoEqual = f16vec3(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(f16vec3(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(f16vec3(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  f16vec4 valueEqual = f16vec4(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  f16vec4 valueNoEqual = f16vec4(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(f16vec4(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(f16vec4(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  vector<float16_t, 8> valueEqual = vector<float16_t, 8>(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  vector<float16_t, 8> valueNoEqual = vector<float16_t, 8>(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(vector<float16_t, 8>(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(vector<float16_t, 8>(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  float valueEqual = float(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  float valueNoEqual = float(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(float(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(float(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  vec2 valueEqual = vec2(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  vec2 valueNoEqual = vec2(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(vec2(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(vec2(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  vec3 valueEqual = vec3(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  vec3 valueNoEqual = vec3(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(vec3(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(vec3(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  vec4 valueEqual = vec4(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  vec4 valueNoEqual = vec4(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(vec4(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(vec4(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  vector<float, 8> valueEqual = vector<float, 8>(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  vector<float, 8> valueNoEqual = vector<float, 8>(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(vector<float, 8>(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(vector<float, 8>(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  double valueEqual = double(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  double valueNoEqual = double(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(double(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(double(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  dvec2 valueEqual = dvec2(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  dvec2 valueNoEqual = dvec2(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(dvec2(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(dvec2(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  dvec3 valueEqual = dvec3(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  dvec3 valueNoEqual = dvec3(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(dvec3(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(dvec3(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  dvec4 valueEqual = dvec4(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  dvec4 valueNoEqual = dvec4(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(dvec4(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(dvec4(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
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
  vector<double, 8> valueEqual = vector<double, 8>(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  vector<double, 8> valueNoEqual = vector<double, 8>(gl_SubgroupInvocationID);
  tempRes = subgroupAllEqual(vector<double, 8>(1)) ? 0x1 : 0;
  tempRes |= subgroupAllEqual(vector<double, 8>(gl_SubgroupInvocationID)) ? 0 : 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  bool data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bool valueEqual = bool(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  bool valueNoEqual = bool(subgroupElect());
  tempRes = subgroupAllEqual(bool(1)) ? 0x1 : 0;
  tempRes |= 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  bvec2 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bvec2 valueEqual = bvec2(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  bvec2 valueNoEqual = bvec2(subgroupElect());
  tempRes = subgroupAllEqual(bvec2(1)) ? 0x1 : 0;
  tempRes |= 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  bvec3 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bvec3 valueEqual = bvec3(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  bvec3 valueNoEqual = bvec3(subgroupElect());
  tempRes = subgroupAllEqual(bvec3(1)) ? 0x1 : 0;
  tempRes |= 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  bvec4 data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  bvec4 valueEqual = bvec4(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  bvec4 valueNoEqual = bvec4(subgroupElect());
  tempRes = subgroupAllEqual(bvec4(1)) ? 0x1 : 0;
  tempRes |= 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
#extension GL_EXT_long_vector : enable
layout (local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 1, std430) buffer Buffer2
{
  vector<bool, 8> data[];
};

void main (void)
{
  uvec3 globalSize = gl_NumWorkGroups * gl_WorkGroupSize;
  highp uint offset = globalSize.x * ((globalSize.y * gl_GlobalInvocationID.z) + gl_GlobalInvocationID.y) + gl_GlobalInvocationID.x;
  uint tempRes;
  vector<bool, 8> valueEqual = vector<bool, 8>(1.25 * float(data[gl_SubgroupInvocationID]) + 5.0);
  vector<bool, 8> valueNoEqual = vector<bool, 8>(subgroupElect());
  tempRes = subgroupAllEqual(vector<bool, 8>(1)) ? 0x1 : 0;
  tempRes |= 0x2;
  tempRes |= subgroupAllEqual(data[0]) ? 0x4 : 0;
  tempRes |= subgroupAllEqual(valueEqual) ? 0x8 : 0x0;
  tempRes |= subgroupAllEqual(valueNoEqual) ? 0x0 : 0x10;
  if (subgroupElect()) tempRes |= 0x2 | 0x10;
  result[offset] = tempRes;
}
