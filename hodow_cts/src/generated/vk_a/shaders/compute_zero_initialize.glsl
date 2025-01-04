#version 450
#extension GL_EXT_null_initializer : enable

layout(constant_id = 0) const uint WGX = 1;
layout(constant_id = 1) const uint WGY = 1;
layout(constant_id = 2) const uint WGZ = 1;
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0) buffer A { uint a[]; } a;
shared uint wg_mem[WGX][WGY][WGZ] = {};

void main() {
  a.a[gl_LocalInvocationID.z * gl_WorkGroupSize.x * gl_WorkGroupSize.y + gl_LocalInvocationID.y * gl_WorkGroupSize.x + gl_LocalInvocationID.x] = wg_mem[gl_LocalInvocationID.x][gl_LocalInvocationID.y][gl_LocalInvocationID.z];
}
#version 450
#extension GL_EXT_null_initializer : enable

layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0) buffer A { uint a[]; } a;
shared uint wg_mem[2] = {};

void main() {
  uint idx_z = gl_LocalInvocationID.z * gl_WorkGroupSize.x * gl_WorkGroupSize.y;
  uint idx_y = gl_LocalInvocationID.y * gl_WorkGroupSize.x;
  uint idx_x = gl_LocalInvocationID.x;
  uint idx = idx_x + idx_y + idx_z;
  if (gl_LocalInvocationID.x == 0) {
    wg_mem[0] = atomicExchange(wg_mem[1], wg_mem[0]);
  }
  barrier();
  atomicAdd(a.a[idx], wg_mem[idx_x % 2] == 0 ? 1 : 0);
}
#version 450
#extension GL_EXT_null_initializer : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z_id = 2) in;
layout(set = 0, binding = 0) buffer A { uint a[]; } a;
layout(constant_id = 3) const uint num_elems = 1024;
layout(constant_id = 4) const uint num_wgs = 0;
shared uvec4 wg_mem[num_elems] = {};
void main() {
  uint idx_z = gl_LocalInvocationID.z * gl_WorkGroupSize.x * gl_WorkGroupSize.y;
  uint idx_y = gl_LocalInvocationID.y * gl_WorkGroupSize.x;
  uint idx_x = gl_LocalInvocationID.x;
  uint idx = idx_x + idx_y + idx_z;
  uint wg_size = gl_WorkGroupSize.x * gl_WorkGroupSize.y * gl_WorkGroupSize.z;
  for (uint i = 0; i < num_elems; ++i) {
    for (uint j = 0; j < 4; ++j) {
      uint shared_idx = 4*i + j;
      uint wg_val = wg_mem[i][j];
      if (idx == shared_idx) {
        atomicAdd(a.a[idx], wg_val == 0 ? 1 : 0);
      } else if (idx == 0 && shared_idx >= wg_size) {
        atomicAdd(a.a[shared_idx], wg_val == 0 ? 1 : 0);
      }
    }
  }
}
#version 450
#extension GL_EXT_null_initializer : enable

layout(constant_id = 0) const uint WGX = 1;
layout(local_size_x_id = 0, local_size_y = 2, local_size_z = 1) in;

layout(set = 0, binding = 0) buffer A { uint a[]; } a;
layout(set = 0, binding = 1) buffer B { uint b[]; } b;

shared uint wg_mem[WGX][2] = {};
void main() {
  if (gl_LocalInvocationID.y == 0) {
    wg_mem[gl_LocalInvocationID.x][gl_LocalInvocationID.y] = b.b[gl_LocalInvocationID.y * WGX + gl_LocalInvocationID.x];
  }
  barrier();
  a.a[gl_LocalInvocationID.y * WGX + gl_LocalInvocationID.x] = wg_mem[gl_LocalInvocationID.x][gl_LocalInvocationID.y];
}
#version 450
#extension GL_EXT_null_initializer : enable

layout(constant_id = 0) const uint WGX = 1;
layout(local_size_x_id = 0, local_size_y = 2, local_size_z = 1) in;

layout(set = 0, binding = 0) buffer A { uint a[]; } a;
layout(set = 0, binding = 1) buffer B { uint b[]; } b;

shared uint wg_mem[WGX][2] = {};
void main() {
  if (gl_LocalInvocationID.y == 1) {
    wg_mem[gl_LocalInvocationID.x][gl_LocalInvocationID.y] = b.b[gl_LocalInvocationID.y * WGX + gl_LocalInvocationID.x];
  }
  barrier();
  a.a[gl_LocalInvocationID.y * WGX + gl_LocalInvocationID.x] = wg_mem[gl_LocalInvocationID.x][gl_LocalInvocationID.y];
}
