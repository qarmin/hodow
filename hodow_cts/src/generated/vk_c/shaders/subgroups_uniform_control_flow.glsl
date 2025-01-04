#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
layout(local_size_x = 128, local_size_y = 2, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer C { uint c[]; } c;
layout(set=0, binding=2) coherent buffer COMPARE { uint x[]; } compare;

void main()
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  uint cmp_val = subgroupElect() ? 1 : 0;
  if (a.a[gl_SubgroupID] % 2 != 0) {
    cmp_val = 4;
  }
  compare.x[idx] = cmp_val;
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x = 128, local_size_y = 2, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer B { uint b[]; } b;
layout(set=0, binding=2) coherent buffer C { uint c[]; } c;
layout(set=0, binding=3) coherent buffer D { uint d[]; } d;

void main()
[[subgroup_uniform_control_flow]]
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  if (a.a[gl_SubgroupID] % 2 == 0) {
    if (gl_SubgroupInvocationID == 0) {
      c.c[idx] += 4;
    } else {
      c.c[idx]++;
    }
    b.b[idx] = subgroupElect() ? 1 : 0;
  }
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
layout(local_size_x = 128, local_size_y = 2, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer C { uint c[]; } c;
layout(set=0, binding=2) coherent buffer COMPARE { uint x[]; } compare;

void main()
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  uint a_val = subgroupElect() ? 1 : 0;
  if (a.a[gl_SubgroupID] % 2 != 0) {
    a_val = 4;
  }
  compare.x[idx] = a_val;
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x = 128, local_size_y = 2, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer B { uint b[]; } b;
layout(set=0, binding=2) coherent buffer C { uint c[]; } c;
layout(set=0, binding=3) coherent buffer D { uint d[]; } d;

void main()
[[subgroup_uniform_control_flow]]
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  if (a.a[gl_SubgroupID] % 2 == 0) {
    do {
      c.c[idx] = d.d[idx];
    } while (!subgroupElect());
    b.b[idx] = subgroupElect() ? 1 : 0;
  }
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x = 128, local_size_y = 2, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer B { uint b[]; } b;
layout(set=0, binding=2) coherent buffer C { uint c[]; } c;
layout(set=0, binding=3) coherent buffer D { uint d[]; } d;

void main()
[[subgroup_uniform_control_flow]]
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  if (a.a[gl_SubgroupID] % 2 == 0) {
    while (true) {
      atomicAdd(c.c[0], 1);
      if (subgroupElect())
        break;
    }
    b.b[idx] = subgroupElect() ? 1 : 0;
  }
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x = 128, local_size_y = 2, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer B { uint b[]; } b;
layout(set=0, binding=2) volatile buffer C { uint c[]; } c;
layout(set=0, binding=3) coherent buffer D { uint d[]; } d;

void main()
[[subgroup_uniform_control_flow]]
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  if (a.a[gl_SubgroupID] % 2 == 0) {
    if (gl_SubgroupInvocationID == 0) {
      d.d[idx] += 4;
    } else {
      c.c[idx]++;
    }
    b.b[idx] = subgroupElect() ? 1 : 0;
  }
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x = 128, local_size_y = 2, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer B { uint b[]; } b;
layout(set=0, binding=2) coherent buffer C { uint c[]; } c;
layout(set=0, binding=3) coherent buffer D { uint d[]; } d;

void main()
[[subgroup_uniform_control_flow]]
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  if (a.a[gl_SubgroupID] % 2 != 0)
    return;

  if (gl_SubgroupInvocationID == 0) {
    c.c[idx] += 4;
  } else {
    c.c[idx]++;
  }
  b.b[idx] = subgroupElect() ? 1 : 0;
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x = 128, local_size_y = 2, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer B { uint b[]; } b;
layout(set=0, binding=2) volatile buffer C { uint c[]; } c;
layout(set=0, binding=3) coherent buffer D { uint d[]; } d;

void main()
[[subgroup_uniform_control_flow]]
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  if (a.a[gl_SubgroupID] % 2 != 0)
    return;

  if (gl_SubgroupInvocationID == 0) {
    c.c[idx] += 4;
  } else {
    c.c[idx]++;
  }
  b.b[idx] = subgroupElect() ? 1 : 0;
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
layout(local_size_x = 128, local_size_y = 2, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer C { uint c[]; } c;
layout(set=0, binding=2) coherent buffer COMPARE { uint x[]; } compare;

void main()
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  uint a_val = subgroupElect() ? 1 : 0;
  if (a.a[gl_SubgroupID] % 2 != 0) {
    a_val = 4;
  }
  compare.x[idx] = a_val;

  uint c_val = 0;
  if (a.a[gl_SubgroupID] % 2 != 0) {
    c_val = 10;
  }
  c.c[idx] = c_val;
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x = 128, local_size_y = 2, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer B { uint b[]; } b;
layout(set=0, binding=2) coherent buffer C { uint c[]; } c;
layout(set=0, binding=3) volatile buffer D { uint d[]; } d;

void main()
[[subgroup_uniform_control_flow]]
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  if (c.c[idx] > 5)
    return;

  while (true) {
    if (d.d[idx]++ > idx)
      break;
  }
  b.b[idx] = subgroupElect() ? 1 : 0;
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x = 128, local_size_y = 2, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer B { uint b[]; } b;
layout(set=0, binding=2) coherent buffer C { uint c[]; } c;
layout(set=0, binding=3) volatile buffer D { uint d[]; } d;

void main()
[[subgroup_uniform_control_flow]]
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  while (true) {
    if (c.c[idx] > 5)
      return;
    if (d.d[idx]++ > idx)
      break;
  }
  b.b[idx] = subgroupElect() ? 1 : 0;
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x = 128, local_size_y = 2, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer B { uint b[]; } b;
layout(set=0, binding=2) coherent buffer C { uint c[]; } c;
layout(set=0, binding=3) volatile buffer D { uint d[]; } d;

void main()
[[subgroup_uniform_control_flow]]
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  for (uint i = 0; i < c.c[idx]; ++i) {
    if (a.a[gl_SubgroupID] % 2 != 0)
      return;

    atomicAdd(d.d[idx], 1);
    if (i == gl_SubgroupID % 4)
      break;
  }

  b.b[idx] = subgroupElect() ? 1 : 0;
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
layout(local_size_x = 128, local_size_y = 2, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer C { uint c[]; } c;
layout(set=0, binding=2) coherent buffer COMPARE { uint x[]; } compare;

void main()
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  uint a_val = 50;
  if (gl_SubgroupID % 2 == 0) {
    if (gl_SubgroupInvocationID == 0)
      a_val = 0;
    else
      a_val = 5;
  }
  a.a[idx] = a_val;

  uint cmp_val = subgroupElect() ? 1 : 0;
  if (gl_SubgroupID % 2 != 0) {
    cmp_val = 4;
  }
  compare.x[idx] = cmp_val;
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x = 128, local_size_y = 2, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer B { uint b[]; } b;
layout(set=0, binding=2) coherent buffer C { uint c[]; } c;
layout(set=0, binding=3) volatile buffer D { uint d[]; } d;

void main()
[[subgroup_uniform_control_flow]]
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  for (int i = 0; i < c.c[0]; ++i) {
    atomicAdd(d.d[idx], 1);
    if (a.a[idx] < 10) {
      if (a.a[idx] == 0)
        atomicAdd(d.d[idx], 2);
      b.b[idx] = subgroupElect() ? 1 : 0;
    }
  }
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x = 128, local_size_y = 2, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer B { uint b[]; } b;
layout(set=0, binding=2) coherent buffer C { uint c[]; } c;
layout(set=0, binding=3) volatile buffer D { uint d[]; } d;

void main()
[[subgroup_uniform_control_flow]]
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  for (int i = 0; i < c.c[0]; ++i) {
    atomicAdd(d.d[idx], 1);
    if (a.a[idx] >= 10)
      break;

    if (a.a[idx] == 0)
      atomicAdd(d.d[idx], 2);
    b.b[idx] = subgroupElect() ? 1 : 0;
  }
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x = 128, local_size_y = 2, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer B { uint b[]; } b;
layout(set=0, binding=2) coherent buffer C { uint c[]; } c;
layout(set=0, binding=3) volatile buffer D { uint d[]; } d;

void main()
[[subgroup_uniform_control_flow]]
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  for (int i = 0; i < c.c[0]; ++i) {
    atomicAdd(d.d[idx], 1);
    if (a.a[idx] >= 10)
      continue;

    if (a.a[idx] == 0)
      atomicAdd(d.d[idx], 2);
    b.b[idx] = subgroupElect() ? 1 : 0;
  }
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
layout(local_size_x = 128, local_size_y = 2, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer C { uint c[]; } c;
layout(set=0, binding=2) coherent buffer COMPARE { uint x[]; } compare;

void main()
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  uint cmp_val = subgroupElect() ? 1 : 0;
  if (a.a[gl_SubgroupID] % 2 != 0) {
    cmp_val = 4;
  }
  compare.x[idx] = cmp_val;

  c.c[idx] = gl_SubgroupID % 4;
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x = 128, local_size_y = 2, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer B { uint b[]; } b;
layout(set=0, binding=2) coherent buffer C { uint c[]; } c;
layout(set=0, binding=3) volatile buffer D { uint d[]; } d;

void main()
[[subgroup_uniform_control_flow]]
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  if (a.a[gl_SubgroupID] % 2 != 0)
    return;

  switch (c.c[idx]) {
    case 0:
    case 1:
      atomicAdd(d.d[idx], 1);
      break;
    case 2:
      d.d[idx] = gl_SubgroupID;
      break;
    default:
      break;
  }
  b.b[idx] = subgroupElect() ? 1 : 0;
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
layout(local_size_x = 128, local_size_y = 2, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer C { uint c[]; } c;
layout(set=0, binding=2) coherent buffer COMPARE { uint x[]; } compare;

void main()
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  uint cmp_val = subgroupElect() ? 1 : 0;
  if (gl_SubgroupID % 2 != 0) {
    cmp_val = 4;
  }
  compare.x[idx] = cmp_val;

  a.a[idx] = gl_SubgroupID;

  c.c[idx] = gl_SubgroupID % 4;
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x = 128, local_size_y = 2, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer B { uint b[]; } b;
layout(set=0, binding=2) coherent buffer C { uint c[]; } c;
layout(set=0, binding=3) volatile buffer D { uint d[]; } d;

void main()
[[subgroup_uniform_control_flow]]
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  if (a.a[idx] % 2 != 0)
    return;

  switch (c.c[idx]) {
    case 0:
    case 1:
      atomicAdd(d.d[idx], 1);
      break;
    default:
      d.d[idx] = gl_SubgroupID;
      break;
  }
  b.b[idx] = subgroupElect() ? 1 : 0;
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
layout(local_size_x = 128, local_size_y = 2, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer C { uint c[]; } c;
layout(set=0, binding=2) coherent buffer COMPARE { uint x[]; } compare;

void main()
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  uint cmp_val = subgroupElect() ? 1 : 0;
  if (gl_SubgroupID % 2 != 0) {
    cmp_val = 4;
  }
  compare.x[idx] = cmp_val;

  a.a[idx] = gl_SubgroupID % 4;

  c.c[idx] = gl_SubgroupID;
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x = 128, local_size_y = 2, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer B { uint b[]; } b;
layout(set=0, binding=2) coherent buffer C { uint c[]; } c;
layout(set=0, binding=3) volatile buffer D { uint d[]; } d;

void main()
[[subgroup_uniform_control_flow]]
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  switch (a.a[idx]) {
    case 1:
      atomicAdd(d.d[idx], 1);
      // fallthrough...
    case 3:
      return;
    default:
      atomicExchange(d.d[0], gl_SubgroupID);
      break;
  }
  b.b[idx] = subgroupElect() ? 1 : 0;
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x = 128, local_size_y = 2, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer B { uint b[]; } b;
layout(set=0, binding=2) coherent buffer C { uint c[]; } c;
layout(set=0, binding=3) volatile buffer D { uint d[]; } d;

void main()
[[subgroup_uniform_control_flow]]
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  switch (a.a[idx]) {
    case 1:
      atomicAdd(d.d[idx], 1);
      break;
    case 3:
      return;
    default:
      switch (c.c[idx]) {
        case 0:
        case 1:
          atomicExchange(d.d[0], gl_SubgroupID);
          break;
        case 2:
          c.c[idx]++;
          break;
        default:
          atomicAdd(d.d[1], 32);
          break;
      }
      b.b[idx] = subgroupElect() ? 1 : 0;
      break;
  }
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
layout(local_size_x = 128, local_size_y = 2, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer C { uint c[]; } c;
layout(set=0, binding=2) coherent buffer COMPARE { uint x[]; } compare;

void main()
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  uint a_val = 50;
  if (gl_SubgroupID % 2 == 0) {
    if (gl_SubgroupInvocationID == 0)
      a_val = 0;
    else
      a_val = 5;
  }
  a.a[idx] = a_val;

  uint cmp_val = subgroupElect() ? 1 : 0;
  if (gl_SubgroupID % 2 != 0) {
    cmp_val = 4;
  }
  compare.x[256 * 0 + idx] = cmp_val;
  compare.x[256 * 1 + idx] = cmp_val;
  compare.x[256 * 2 + idx] = cmp_val;
  compare.x[256 * 3 + idx] = cmp_val;
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x = 128, local_size_y = 2, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer B { uint b[]; } b;
layout(set=0, binding=2) coherent buffer C { uint c[]; } c;
layout(set=0, binding=3) volatile buffer D { uint d[]; } d;

void main()
[[subgroup_uniform_control_flow]]
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  for (int i = 0; i < c.c[0]; ++i) {
    atomicAdd(d.d[idx], 1);
    if (a.a[idx] < 10) {
      if (a.a[idx] == 0)
        atomicAdd(d.d[idx], 2);
      b.b[256 * i + idx] = subgroupElect() ? 1 : 0;
    }
  }
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x = 128, local_size_y = 2, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer B { uint b[]; } b;
layout(set=0, binding=2) volatile buffer C { uint c[]; } c;
layout(set=0, binding=3) coherent buffer D { uint d[]; } d;

void main()
[[subgroup_uniform_control_flow]]
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;

  if (gl_SubgroupInvocationID == 0) {
    c.c[idx] += 4;
    if (a.a[gl_SubgroupID] % 2 != 0)
      return;
  } else {
    c.c[idx]++;
    if (a.a[gl_SubgroupID] % 2 != 0)
      return;
  }
  b.b[idx] = subgroupElect() ? 1 : 0;
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
layout(local_size_x = 128, local_size_y = 2, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer C { uint c[]; } c;
layout(set=0, binding=2) coherent buffer COMPARE { uint x[]; } compare;

void main()
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  uint a_val = subgroupElect() ? 1 : 0;
  if (a.a[gl_SubgroupID] % 2 != 0) {
    a_val = 4;
  }
  compare.x[idx] = a_val;

  uint c_val = c.c[idx];
  if (a.a[gl_SubgroupID] % 2 != 0) {
    c_val = 10;
  }
  c.c[idx] = c_val;
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x = 128, local_size_y = 2, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer B { uint b[]; } b;
layout(set=0, binding=2) coherent buffer C { uint c[]; } c;
layout(set=0, binding=3) volatile buffer D { uint d[]; } d;

void main()
[[subgroup_uniform_control_flow]]
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  uint c_val = c.c[idx];
  if (!subgroupAllEqual(c_val)) {
    atomicAdd(d.d[0], 1);
    if (c_val % 2 == 0) {
      atomicAdd(d.d[idx], gl_SubgroupID);
    }
    b.b[idx] = subgroupElect() ? 1 : 0;
  }
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x = 128, local_size_y = 2, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer B { uint b[]; } b;
layout(set=0, binding=2) coherent buffer C { uint c[]; } c;
layout(set=0, binding=3) volatile buffer D { uint d[]; } d;

void main()
[[subgroup_uniform_control_flow]]
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  uint c_val = c.c[idx];
  bool test = (c_val % 2) == 0;
  if (subgroupAny(test)) {
    atomicAdd(d.d[0], 1);
    if (a.a[gl_SubgroupID] % 2 != 0)
      return;

    if (c_val % 2 == 0) {
      atomicAdd(d.d[idx], gl_SubgroupID);
    }
    b.b[idx] = subgroupElect() ? 1 : 0;
  }
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
layout(local_size_x = 128, local_size_y = 2, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer C { uint c[]; } c;
layout(set=0, binding=2) coherent buffer COMPARE { uint x[]; } compare;

void main()
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  uint cmp_val = subgroupElect() ? 1 : 0;
  if (gl_SubgroupID % 2 != 0) {
    cmp_val = 4;
  }
  compare.x[idx] = cmp_val;

  uint c_val = c.c[idx];
  if (a.a[idx] < 128) {
    if (gl_SubgroupID % 2 != 0) {
      c_val = 1;
    } else {
      c_val = gl_SubgroupInvocationID % 4;
      if (c_val == 1) c_val += 4;
    }
  } else if (a.a[idx] < 192) {
    if (gl_SubgroupInvocationID == 0 && gl_SubgroupID % 2 != 0) {
      c_val = 0;
    } else {
      c_val = c_val + 1;
    }
  }
  c.c[idx] = c_val;
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x = 128, local_size_y = 2, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer B { uint b[]; } b;
layout(set=0, binding=2) coherent buffer C { uint c[]; } c;
layout(set=0, binding=3) volatile buffer D { uint d[]; } d;

void main()
[[subgroup_uniform_control_flow]]
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  uint a_val = a.a[idx];
  if (a_val < 128) {
    uint c_val = c.c[idx];
    switch (c_val) {
      case 0:
        atomicAdd(d.d[idx], 1);
        break;
      case 1:
      case 2:
        if (a_val > 4) {
          uint val = a_val;
          for (uint i = 0; i < 4; ++i) {
            val = atomicExchange(d.d[0], val);
            if (c_val == 1) return;
          }
        } else if (a_val == 3) {
          atomicAdd(d.d[1], gl_SubgroupID);
        } else {
          atomicAdd(d.d[2], gl_SubgroupInvocationID);
          if (c_val == 1) return;
        }
        break;
      default:
        if (a.a[gl_SubgroupID] % 2 != 0) return;
        atomicExchange(d.d[idx], c_val);
        break;
    }
  } else if (a_val < 192) {
    atomicExchange(d.d[idx], a_val);
    uint c_val = c.c[idx];
    if (subgroupAny(c_val == 0)) {
      return;
    } else {
      uint val = atomicAdd(d.d[idx], gl_SubgroupInvocationID);
      while (!subgroupElect()) {
        val = atomicExchange(d.d[0], val);
      }
      if (val > 10) {
        atomicAnd(d.d[idx], 0xff00ff00);
      }
    }
  } else {
    if (a.a[gl_SubgroupID] % 2 != 0) return;
  }

  b.b[idx] = subgroupElect() ? 1 : 0;
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer C { uint c[]; } c;
layout(set=0, binding=2) coherent buffer COMPARE { uint x[]; } compare;

void main()
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  uint cmp_val = subgroupElect() ? 1 : 0;
  if (a.a[gl_SubgroupID] % 2 != 0) {
    cmp_val = 4;
  }
  compare.x[idx] = cmp_val;
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer B { uint b[]; } b;
layout(set=0, binding=2) coherent buffer C { uint c[]; } c;
layout(set=0, binding=3) coherent buffer D { uint d[]; } d;

void main()
[[subgroup_uniform_control_flow]]
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  if (a.a[gl_SubgroupID] % 2 == 0) {
    if (gl_SubgroupInvocationID == 0) {
      c.c[idx] += 4;
    } else {
      c.c[idx]++;
    }
    b.b[idx] = subgroupElect() ? 1 : 0;
  }
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer C { uint c[]; } c;
layout(set=0, binding=2) coherent buffer COMPARE { uint x[]; } compare;

void main()
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  uint a_val = subgroupElect() ? 1 : 0;
  if (a.a[gl_SubgroupID] % 2 != 0) {
    a_val = 4;
  }
  compare.x[idx] = a_val;
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer B { uint b[]; } b;
layout(set=0, binding=2) coherent buffer C { uint c[]; } c;
layout(set=0, binding=3) coherent buffer D { uint d[]; } d;

void main()
[[subgroup_uniform_control_flow]]
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  if (a.a[gl_SubgroupID] % 2 == 0) {
    do {
      c.c[idx] = d.d[idx];
    } while (!subgroupElect());
    b.b[idx] = subgroupElect() ? 1 : 0;
  }
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer B { uint b[]; } b;
layout(set=0, binding=2) coherent buffer C { uint c[]; } c;
layout(set=0, binding=3) coherent buffer D { uint d[]; } d;

void main()
[[subgroup_uniform_control_flow]]
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  if (a.a[gl_SubgroupID] % 2 == 0) {
    while (true) {
      atomicAdd(c.c[0], 1);
      if (subgroupElect())
        break;
    }
    b.b[idx] = subgroupElect() ? 1 : 0;
  }
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer B { uint b[]; } b;
layout(set=0, binding=2) volatile buffer C { uint c[]; } c;
layout(set=0, binding=3) coherent buffer D { uint d[]; } d;

void main()
[[subgroup_uniform_control_flow]]
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  if (a.a[gl_SubgroupID] % 2 == 0) {
    if (gl_SubgroupInvocationID == 0) {
      d.d[idx] += 4;
    } else {
      c.c[idx]++;
    }
    b.b[idx] = subgroupElect() ? 1 : 0;
  }
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer B { uint b[]; } b;
layout(set=0, binding=2) coherent buffer C { uint c[]; } c;
layout(set=0, binding=3) coherent buffer D { uint d[]; } d;

void main()
[[subgroup_uniform_control_flow]]
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  if (a.a[gl_SubgroupID] % 2 != 0)
    return;

  if (gl_SubgroupInvocationID == 0) {
    c.c[idx] += 4;
  } else {
    c.c[idx]++;
  }
  b.b[idx] = subgroupElect() ? 1 : 0;
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer B { uint b[]; } b;
layout(set=0, binding=2) volatile buffer C { uint c[]; } c;
layout(set=0, binding=3) coherent buffer D { uint d[]; } d;

void main()
[[subgroup_uniform_control_flow]]
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  if (a.a[gl_SubgroupID] % 2 != 0)
    return;

  if (gl_SubgroupInvocationID == 0) {
    c.c[idx] += 4;
  } else {
    c.c[idx]++;
  }
  b.b[idx] = subgroupElect() ? 1 : 0;
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer C { uint c[]; } c;
layout(set=0, binding=2) coherent buffer COMPARE { uint x[]; } compare;

void main()
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  uint a_val = subgroupElect() ? 1 : 0;
  if (a.a[gl_SubgroupID] % 2 != 0) {
    a_val = 4;
  }
  compare.x[idx] = a_val;

  uint c_val = 0;
  if (a.a[gl_SubgroupID] % 2 != 0) {
    c_val = 10;
  }
  c.c[idx] = c_val;
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer B { uint b[]; } b;
layout(set=0, binding=2) coherent buffer C { uint c[]; } c;
layout(set=0, binding=3) volatile buffer D { uint d[]; } d;

void main()
[[subgroup_uniform_control_flow]]
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  if (c.c[idx] > 5)
    return;

  while (true) {
    if (d.d[idx]++ > idx)
      break;
  }
  b.b[idx] = subgroupElect() ? 1 : 0;
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer B { uint b[]; } b;
layout(set=0, binding=2) coherent buffer C { uint c[]; } c;
layout(set=0, binding=3) volatile buffer D { uint d[]; } d;

void main()
[[subgroup_uniform_control_flow]]
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  while (true) {
    if (c.c[idx] > 5)
      return;
    if (d.d[idx]++ > idx)
      break;
  }
  b.b[idx] = subgroupElect() ? 1 : 0;
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer B { uint b[]; } b;
layout(set=0, binding=2) coherent buffer C { uint c[]; } c;
layout(set=0, binding=3) volatile buffer D { uint d[]; } d;

void main()
[[subgroup_uniform_control_flow]]
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  for (uint i = 0; i < c.c[idx]; ++i) {
    if (a.a[gl_SubgroupID] % 2 != 0)
      return;

    atomicAdd(d.d[idx], 1);
    if (i == gl_SubgroupID % 4)
      break;
  }

  b.b[idx] = subgroupElect() ? 1 : 0;
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer C { uint c[]; } c;
layout(set=0, binding=2) coherent buffer COMPARE { uint x[]; } compare;

void main()
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  uint a_val = 50;
  if (gl_SubgroupID % 2 == 0) {
    if (gl_SubgroupInvocationID == 0)
      a_val = 0;
    else
      a_val = 5;
  }
  a.a[idx] = a_val;

  uint cmp_val = subgroupElect() ? 1 : 0;
  if (gl_SubgroupID % 2 != 0) {
    cmp_val = 4;
  }
  compare.x[idx] = cmp_val;
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer B { uint b[]; } b;
layout(set=0, binding=2) coherent buffer C { uint c[]; } c;
layout(set=0, binding=3) volatile buffer D { uint d[]; } d;

void main()
[[subgroup_uniform_control_flow]]
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  for (int i = 0; i < c.c[0]; ++i) {
    atomicAdd(d.d[idx], 1);
    if (a.a[idx] < 10) {
      if (a.a[idx] == 0)
        atomicAdd(d.d[idx], 2);
      b.b[idx] = subgroupElect() ? 1 : 0;
    }
  }
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer B { uint b[]; } b;
layout(set=0, binding=2) coherent buffer C { uint c[]; } c;
layout(set=0, binding=3) volatile buffer D { uint d[]; } d;

void main()
[[subgroup_uniform_control_flow]]
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  for (int i = 0; i < c.c[0]; ++i) {
    atomicAdd(d.d[idx], 1);
    if (a.a[idx] >= 10)
      break;

    if (a.a[idx] == 0)
      atomicAdd(d.d[idx], 2);
    b.b[idx] = subgroupElect() ? 1 : 0;
  }
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer B { uint b[]; } b;
layout(set=0, binding=2) coherent buffer C { uint c[]; } c;
layout(set=0, binding=3) volatile buffer D { uint d[]; } d;

void main()
[[subgroup_uniform_control_flow]]
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  for (int i = 0; i < c.c[0]; ++i) {
    atomicAdd(d.d[idx], 1);
    if (a.a[idx] >= 10)
      continue;

    if (a.a[idx] == 0)
      atomicAdd(d.d[idx], 2);
    b.b[idx] = subgroupElect() ? 1 : 0;
  }
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer C { uint c[]; } c;
layout(set=0, binding=2) coherent buffer COMPARE { uint x[]; } compare;

void main()
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  uint cmp_val = subgroupElect() ? 1 : 0;
  if (a.a[gl_SubgroupID] % 2 != 0) {
    cmp_val = 4;
  }
  compare.x[idx] = cmp_val;

  c.c[idx] = gl_SubgroupID % 4;
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer B { uint b[]; } b;
layout(set=0, binding=2) coherent buffer C { uint c[]; } c;
layout(set=0, binding=3) volatile buffer D { uint d[]; } d;

void main()
[[subgroup_uniform_control_flow]]
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  if (a.a[gl_SubgroupID] % 2 != 0)
    return;

  switch (c.c[idx]) {
    case 0:
    case 1:
      atomicAdd(d.d[idx], 1);
      break;
    case 2:
      d.d[idx] = gl_SubgroupID;
      break;
    default:
      break;
  }
  b.b[idx] = subgroupElect() ? 1 : 0;
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer C { uint c[]; } c;
layout(set=0, binding=2) coherent buffer COMPARE { uint x[]; } compare;

void main()
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  uint cmp_val = subgroupElect() ? 1 : 0;
  if (gl_SubgroupID % 2 != 0) {
    cmp_val = 4;
  }
  compare.x[idx] = cmp_val;

  a.a[idx] = gl_SubgroupID;

  c.c[idx] = gl_SubgroupID % 4;
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer B { uint b[]; } b;
layout(set=0, binding=2) coherent buffer C { uint c[]; } c;
layout(set=0, binding=3) volatile buffer D { uint d[]; } d;

void main()
[[subgroup_uniform_control_flow]]
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  if (a.a[idx] % 2 != 0)
    return;

  switch (c.c[idx]) {
    case 0:
    case 1:
      atomicAdd(d.d[idx], 1);
      break;
    default:
      d.d[idx] = gl_SubgroupID;
      break;
  }
  b.b[idx] = subgroupElect() ? 1 : 0;
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer C { uint c[]; } c;
layout(set=0, binding=2) coherent buffer COMPARE { uint x[]; } compare;

void main()
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  uint cmp_val = subgroupElect() ? 1 : 0;
  if (gl_SubgroupID % 2 != 0) {
    cmp_val = 4;
  }
  compare.x[idx] = cmp_val;

  a.a[idx] = gl_SubgroupID % 4;

  c.c[idx] = gl_SubgroupID;
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer B { uint b[]; } b;
layout(set=0, binding=2) coherent buffer C { uint c[]; } c;
layout(set=0, binding=3) volatile buffer D { uint d[]; } d;

void main()
[[subgroup_uniform_control_flow]]
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  switch (a.a[idx]) {
    case 1:
      atomicAdd(d.d[idx], 1);
      // fallthrough...
    case 3:
      return;
    default:
      atomicExchange(d.d[0], gl_SubgroupID);
      break;
  }
  b.b[idx] = subgroupElect() ? 1 : 0;
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer B { uint b[]; } b;
layout(set=0, binding=2) coherent buffer C { uint c[]; } c;
layout(set=0, binding=3) volatile buffer D { uint d[]; } d;

void main()
[[subgroup_uniform_control_flow]]
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  switch (a.a[idx]) {
    case 1:
      atomicAdd(d.d[idx], 1);
      break;
    case 3:
      return;
    default:
      switch (c.c[idx]) {
        case 0:
        case 1:
          atomicExchange(d.d[0], gl_SubgroupID);
          break;
        case 2:
          c.c[idx]++;
          break;
        default:
          atomicAdd(d.d[1], 32);
          break;
      }
      b.b[idx] = subgroupElect() ? 1 : 0;
      break;
  }
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer C { uint c[]; } c;
layout(set=0, binding=2) coherent buffer COMPARE { uint x[]; } compare;

void main()
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  uint a_val = 50;
  if (gl_SubgroupID % 2 == 0) {
    if (gl_SubgroupInvocationID == 0)
      a_val = 0;
    else
      a_val = 5;
  }
  a.a[idx] = a_val;

  uint cmp_val = subgroupElect() ? 1 : 0;
  if (gl_SubgroupID % 2 != 0) {
    cmp_val = 4;
  }
  compare.x[128 * 0 + idx] = cmp_val;
  compare.x[128 * 1 + idx] = cmp_val;
  compare.x[128 * 2 + idx] = cmp_val;
  compare.x[128 * 3 + idx] = cmp_val;
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer B { uint b[]; } b;
layout(set=0, binding=2) coherent buffer C { uint c[]; } c;
layout(set=0, binding=3) volatile buffer D { uint d[]; } d;

void main()
[[subgroup_uniform_control_flow]]
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  for (int i = 0; i < c.c[0]; ++i) {
    atomicAdd(d.d[idx], 1);
    if (a.a[idx] < 10) {
      if (a.a[idx] == 0)
        atomicAdd(d.d[idx], 2);
      b.b[128 * i + idx] = subgroupElect() ? 1 : 0;
    }
  }
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer B { uint b[]; } b;
layout(set=0, binding=2) volatile buffer C { uint c[]; } c;
layout(set=0, binding=3) coherent buffer D { uint d[]; } d;

void main()
[[subgroup_uniform_control_flow]]
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;

  if (gl_SubgroupInvocationID == 0) {
    c.c[idx] += 4;
    if (a.a[gl_SubgroupID] % 2 != 0)
      return;
  } else {
    c.c[idx]++;
    if (a.a[gl_SubgroupID] % 2 != 0)
      return;
  }
  b.b[idx] = subgroupElect() ? 1 : 0;
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer C { uint c[]; } c;
layout(set=0, binding=2) coherent buffer COMPARE { uint x[]; } compare;

void main()
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  uint a_val = subgroupElect() ? 1 : 0;
  if (a.a[gl_SubgroupID] % 2 != 0) {
    a_val = 4;
  }
  compare.x[idx] = a_val;

  uint c_val = c.c[idx];
  if (a.a[gl_SubgroupID] % 2 != 0) {
    c_val = 10;
  }
  c.c[idx] = c_val;
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer B { uint b[]; } b;
layout(set=0, binding=2) coherent buffer C { uint c[]; } c;
layout(set=0, binding=3) volatile buffer D { uint d[]; } d;

void main()
[[subgroup_uniform_control_flow]]
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  uint c_val = c.c[idx];
  if (!subgroupAllEqual(c_val)) {
    atomicAdd(d.d[0], 1);
    if (c_val % 2 == 0) {
      atomicAdd(d.d[idx], gl_SubgroupID);
    }
    b.b[idx] = subgroupElect() ? 1 : 0;
  }
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer B { uint b[]; } b;
layout(set=0, binding=2) coherent buffer C { uint c[]; } c;
layout(set=0, binding=3) volatile buffer D { uint d[]; } d;

void main()
[[subgroup_uniform_control_flow]]
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  uint c_val = c.c[idx];
  bool test = (c_val % 2) == 0;
  if (subgroupAny(test)) {
    atomicAdd(d.d[0], 1);
    if (a.a[gl_SubgroupID] % 2 != 0)
      return;

    if (c_val % 2 == 0) {
      atomicAdd(d.d[idx], gl_SubgroupID);
    }
    b.b[idx] = subgroupElect() ? 1 : 0;
  }
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_ballot : enable
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer C { uint c[]; } c;
layout(set=0, binding=2) coherent buffer COMPARE { uint x[]; } compare;

void main()
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  uint cmp_val = subgroupElect() ? 1 : 0;
  if (gl_SubgroupID % 2 != 0) {
    cmp_val = 4;
  }
  compare.x[idx] = cmp_val;

  uint c_val = c.c[idx];
  if (a.a[idx] < 128) {
    if (gl_SubgroupID % 2 != 0) {
      c_val = 1;
    } else {
      c_val = gl_SubgroupInvocationID % 4;
      if (c_val == 1) c_val += 4;
    }
  } else if (a.a[idx] < 192) {
    if (gl_SubgroupInvocationID == 0 && gl_SubgroupID % 2 != 0) {
      c_val = 0;
    } else {
      c_val = c_val + 1;
    }
  }
  c.c[idx] = c_val;
}
#version 450 core
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;

layout(set=0, binding=0) coherent buffer A { uint a[]; } a;
layout(set=0, binding=1) coherent buffer B { uint b[]; } b;
layout(set=0, binding=2) coherent buffer C { uint c[]; } c;
layout(set=0, binding=3) volatile buffer D { uint d[]; } d;

void main()
[[subgroup_uniform_control_flow]]
{
  uint idx = gl_SubgroupID * gl_SubgroupSize + gl_SubgroupInvocationID;
  uint a_val = a.a[idx];
  if (a_val < 128) {
    uint c_val = c.c[idx];
    switch (c_val) {
      case 0:
        atomicAdd(d.d[idx], 1);
        break;
      case 1:
      case 2:
        if (a_val > 4) {
          uint val = a_val;
          for (uint i = 0; i < 4; ++i) {
            val = atomicExchange(d.d[0], val);
            if (c_val == 1) return;
          }
        } else if (a_val == 3) {
          atomicAdd(d.d[1], gl_SubgroupID);
        } else {
          atomicAdd(d.d[2], gl_SubgroupInvocationID);
          if (c_val == 1) return;
        }
        break;
      default:
        if (a.a[gl_SubgroupID] % 2 != 0) return;
        atomicExchange(d.d[idx], c_val);
        break;
    }
  } else if (a_val < 192) {
    atomicExchange(d.d[idx], a_val);
    uint c_val = c.c[idx];
    if (subgroupAny(c_val == 0)) {
      return;
    } else {
      uint val = atomicAdd(d.d[idx], gl_SubgroupInvocationID);
      while (!subgroupElect()) {
        val = atomicExchange(d.d[0], val);
      }
      if (val > 10) {
        atomicAnd(d.d[idx], 0xff00ff00);
      }
    }
  } else {
    if (a.a[gl_SubgroupID] % 2 != 0) return;
  }

  b.b[idx] = subgroupElect() ? 1 : 0;
}
