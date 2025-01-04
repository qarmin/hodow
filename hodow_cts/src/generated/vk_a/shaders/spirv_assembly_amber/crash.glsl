#version 450
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(binding = 0) buffer block0
{
    int data[20];
} ssbo;

void main()
{
  // Zero constants
  int ival = ssbo.data[0];
  float val = float(ival);

  // int div
  ssbo.data[1] = 7 / ival;
  // float div
  ssbo.data[2] = int(7.0 / val);
  // normalize float
  ssbo.data[3] = int(normalize(val));
  // normalize vec2
  ssbo.data[4] = int(normalize(vec2(val))[ival]);
  // normalize vec3
  ssbo.data[5] = int(normalize(vec3(val))[ival]);
  // normalize vec4
  ssbo.data[6] = int(normalize(vec4(val))[ival]);
  // integer mod
  ssbo.data[7] = 7 % ival;
  // float mod
  ssbo.data[8] = int(mod(7.0, val));
  // vec2 mod
  ssbo.data[9] = int(mod(vec2(7.0), vec2(val))[ival]);
  // vec3 mod
  ssbo.data[10] = int(mod(vec3(7.0), vec3(val))[ival]);
  // vec4 mod
  ssbo.data[11] = int(mod(vec4(7.0), vec4(val))[ival]);
  // float smoothstep
  ssbo.data[12] = int(smoothstep(val, val, 0.3));
  // vec2 smoothstep
  ssbo.data[13] = int(smoothstep(vec2(val), vec2(val), vec2(0.3))[ival]);
  // vec3 smoothstep
  ssbo.data[14] = int(smoothstep(vec3(val), vec3(val), vec3(0.3))[ival]);
  // vec4 smoothstep
  ssbo.data[15] = int(smoothstep(vec4(val), vec4(val), vec4(0.3))[ival]);
  // float atan2
  ssbo.data[16] = int(atan(7.0, val));
  // vec2 atan2
  ssbo.data[17] = int(atan(vec2(7.0), vec2(val))[ival]);
  // vec3 atan2
  ssbo.data[18] = int(atan(vec3(7.0), vec3(val))[ival]);
  // vec4 atan2
  ssbo.data[19] = int(atan(vec4(7.0), vec4(val))[ival]);

  // Known good value
  ssbo.data[0] = 42;
}
