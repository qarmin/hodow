#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 0) uint x0;
  layout(offset = 4) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x1234) result--;
if (words[1] == 0x5678) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 0) uint x0;
  layout(offset = 20) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x1234) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x5678) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 0) uint x0;
  layout(offset = 36) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x1234) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x5678) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 0) uint x0;
  layout(offset = 52) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x1234) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x5678) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 0) uint x0;
  layout(offset = 68) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x1234) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x5678) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 0) uint x0;
  layout(offset = 84) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x1234) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x5678) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 0) uint x0;
  layout(offset = 100) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x1234) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x5678) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 0) uint x0;
  layout(offset = 116) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x1234) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x5678) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 4) uint x0;
  layout(offset = 8) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x1234) result--;
if (words[2] == 0x5678) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 4) uint x0;
  layout(offset = 24) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x1234) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x5678) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 4) uint x0;
  layout(offset = 40) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x1234) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x5678) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 4) uint x0;
  layout(offset = 56) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x1234) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x5678) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 4) uint x0;
  layout(offset = 72) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x1234) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x5678) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 4) uint x0;
  layout(offset = 88) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x1234) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x5678) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 4) uint x0;
  layout(offset = 104) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x1234) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x5678) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 4) uint x0;
  layout(offset = 120) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x1234) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x5678) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 8) uint x0;
  layout(offset = 12) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x1234) result--;
if (words[3] == 0x5678) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 8) uint x0;
  layout(offset = 28) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x1234) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x5678) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 8) uint x0;
  layout(offset = 44) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x1234) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x5678) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 8) uint x0;
  layout(offset = 60) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x1234) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x5678) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 8) uint x0;
  layout(offset = 76) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x1234) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x5678) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 8) uint x0;
  layout(offset = 92) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x1234) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x5678) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 8) uint x0;
  layout(offset = 108) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x1234) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x5678) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 8) uint x0;
  layout(offset = 124) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x1234) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x5678) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 12) uint x0;
  layout(offset = 16) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x1234) result--;
if (words[4] == 0x5678) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 12) uint x0;
  layout(offset = 32) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x1234) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x5678) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 12) uint x0;
  layout(offset = 48) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x1234) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x5678) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 12) uint x0;
  layout(offset = 64) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x1234) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x5678) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 12) uint x0;
  layout(offset = 80) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x1234) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x5678) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 12) uint x0;
  layout(offset = 96) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x1234) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x5678) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 12) uint x0;
  layout(offset = 112) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x1234) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x5678) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 16) uint x0;
  layout(offset = 20) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x1234) result--;
if (words[5] == 0x5678) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 16) uint x0;
  layout(offset = 36) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x1234) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x5678) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 16) uint x0;
  layout(offset = 52) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x1234) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x5678) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 16) uint x0;
  layout(offset = 68) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x1234) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x5678) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 16) uint x0;
  layout(offset = 84) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x1234) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x5678) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 16) uint x0;
  layout(offset = 100) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x1234) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x5678) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 16) uint x0;
  layout(offset = 116) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x1234) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x5678) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 20) uint x0;
  layout(offset = 24) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x1234) result--;
if (words[6] == 0x5678) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 20) uint x0;
  layout(offset = 40) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x1234) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x5678) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 20) uint x0;
  layout(offset = 56) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x1234) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x5678) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 20) uint x0;
  layout(offset = 72) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x1234) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x5678) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 20) uint x0;
  layout(offset = 88) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x1234) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x5678) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 20) uint x0;
  layout(offset = 104) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x1234) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x5678) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 20) uint x0;
  layout(offset = 120) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x1234) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x5678) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 24) uint x0;
  layout(offset = 28) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x1234) result--;
if (words[7] == 0x5678) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 24) uint x0;
  layout(offset = 44) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x1234) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x5678) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 24) uint x0;
  layout(offset = 60) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x1234) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x5678) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 24) uint x0;
  layout(offset = 76) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x1234) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x5678) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 24) uint x0;
  layout(offset = 92) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x1234) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x5678) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 24) uint x0;
  layout(offset = 108) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x1234) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x5678) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 24) uint x0;
  layout(offset = 124) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x1234) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x5678) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 28) uint x0;
  layout(offset = 32) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x1234) result--;
if (words[8] == 0x5678) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 28) uint x0;
  layout(offset = 48) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x1234) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x5678) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 28) uint x0;
  layout(offset = 64) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x1234) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x5678) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 28) uint x0;
  layout(offset = 80) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x1234) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x5678) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 28) uint x0;
  layout(offset = 96) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x1234) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x5678) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 28) uint x0;
  layout(offset = 112) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x1234) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x5678) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 32) uint x0;
  layout(offset = 36) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x1234) result--;
if (words[9] == 0x5678) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 32) uint x0;
  layout(offset = 52) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x1234) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x5678) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 32) uint x0;
  layout(offset = 68) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x1234) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x5678) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 32) uint x0;
  layout(offset = 84) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x1234) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x5678) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 32) uint x0;
  layout(offset = 100) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x1234) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x5678) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 32) uint x0;
  layout(offset = 116) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x1234) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x5678) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 36) uint x0;
  layout(offset = 40) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x1234) result--;
if (words[10] == 0x5678) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 36) uint x0;
  layout(offset = 56) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x1234) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x5678) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 36) uint x0;
  layout(offset = 72) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x1234) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x5678) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 36) uint x0;
  layout(offset = 88) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x1234) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x5678) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 36) uint x0;
  layout(offset = 104) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x1234) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x5678) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 36) uint x0;
  layout(offset = 120) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x1234) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x5678) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 40) uint x0;
  layout(offset = 44) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x1234) result--;
if (words[11] == 0x5678) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 40) uint x0;
  layout(offset = 60) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x1234) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x5678) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 40) uint x0;
  layout(offset = 76) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x1234) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x5678) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 40) uint x0;
  layout(offset = 92) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x1234) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x5678) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 40) uint x0;
  layout(offset = 108) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x1234) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x5678) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 40) uint x0;
  layout(offset = 124) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x1234) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x5678) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 44) uint x0;
  layout(offset = 48) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x1234) result--;
if (words[12] == 0x5678) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 44) uint x0;
  layout(offset = 64) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x1234) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x5678) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 44) uint x0;
  layout(offset = 80) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x1234) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x5678) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 44) uint x0;
  layout(offset = 96) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x1234) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x5678) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 44) uint x0;
  layout(offset = 112) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x1234) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x5678) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 48) uint x0;
  layout(offset = 52) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x1234) result--;
if (words[13] == 0x5678) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 48) uint x0;
  layout(offset = 68) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x1234) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x5678) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 48) uint x0;
  layout(offset = 84) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x1234) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x5678) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 48) uint x0;
  layout(offset = 100) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x1234) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x5678) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 48) uint x0;
  layout(offset = 116) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x1234) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x5678) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 52) uint x0;
  layout(offset = 56) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x1234) result--;
if (words[14] == 0x5678) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 52) uint x0;
  layout(offset = 72) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x1234) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x5678) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 52) uint x0;
  layout(offset = 88) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x1234) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x5678) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 52) uint x0;
  layout(offset = 104) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x1234) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x5678) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 52) uint x0;
  layout(offset = 120) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x1234) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x5678) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 56) uint x0;
  layout(offset = 60) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x1234) result--;
if (words[15] == 0x5678) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 56) uint x0;
  layout(offset = 76) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x1234) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x5678) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 56) uint x0;
  layout(offset = 92) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x1234) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x5678) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 56) uint x0;
  layout(offset = 108) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x1234) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x5678) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 56) uint x0;
  layout(offset = 124) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x1234) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x5678) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 60) uint x0;
  layout(offset = 64) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x1234) result--;
if (words[16] == 0x5678) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 60) uint x0;
  layout(offset = 80) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x1234) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x5678) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 60) uint x0;
  layout(offset = 96) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x1234) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x5678) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 60) uint x0;
  layout(offset = 112) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x1234) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x5678) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 64) uint x0;
  layout(offset = 68) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x1234) result--;
if (words[17] == 0x5678) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 64) uint x0;
  layout(offset = 84) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x1234) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x5678) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 64) uint x0;
  layout(offset = 100) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x1234) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x5678) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 64) uint x0;
  layout(offset = 116) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x1234) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x5678) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 68) uint x0;
  layout(offset = 72) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x1234) result--;
if (words[18] == 0x5678) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 68) uint x0;
  layout(offset = 88) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x1234) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x5678) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 68) uint x0;
  layout(offset = 104) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x1234) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x5678) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 68) uint x0;
  layout(offset = 120) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x1234) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x5678) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 72) uint x0;
  layout(offset = 76) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x1234) result--;
if (words[19] == 0x5678) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 72) uint x0;
  layout(offset = 92) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x1234) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x5678) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 72) uint x0;
  layout(offset = 108) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x1234) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x5678) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 72) uint x0;
  layout(offset = 124) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x1234) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x5678) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 76) uint x0;
  layout(offset = 80) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x1234) result--;
if (words[20] == 0x5678) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 76) uint x0;
  layout(offset = 96) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x1234) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x5678) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 76) uint x0;
  layout(offset = 112) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x1234) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x5678) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 80) uint x0;
  layout(offset = 84) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x1234) result--;
if (words[21] == 0x5678) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 80) uint x0;
  layout(offset = 100) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x1234) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x5678) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 80) uint x0;
  layout(offset = 116) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x1234) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x5678) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 84) uint x0;
  layout(offset = 88) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x1234) result--;
if (words[22] == 0x5678) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 84) uint x0;
  layout(offset = 104) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x1234) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x5678) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 84) uint x0;
  layout(offset = 120) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x1234) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x5678) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 88) uint x0;
  layout(offset = 92) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x1234) result--;
if (words[23] == 0x5678) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 88) uint x0;
  layout(offset = 108) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x1234) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x5678) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 88) uint x0;
  layout(offset = 124) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x1234) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x5678) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 92) uint x0;
  layout(offset = 96) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x1234) result--;
if (words[24] == 0x5678) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 92) uint x0;
  layout(offset = 112) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x1234) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x5678) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 96) uint x0;
  layout(offset = 100) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x1234) result--;
if (words[25] == 0x5678) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 96) uint x0;
  layout(offset = 116) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x1234) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x5678) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 100) uint x0;
  layout(offset = 104) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x1234) result--;
if (words[26] == 0x5678) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 100) uint x0;
  layout(offset = 120) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x1234) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x5678) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 104) uint x0;
  layout(offset = 108) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x1234) result--;
if (words[27] == 0x5678) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 104) uint x0;
  layout(offset = 124) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x1234) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x5678) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 108) uint x0;
  layout(offset = 112) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x1234) result--;
if (words[28] == 0x5678) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 112) uint x0;
  layout(offset = 116) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x1234) result--;
if (words[29] == 0x5678) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 116) uint x0;
  layout(offset = 120) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x1234) result--;
if (words[30] == 0x5678) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
shared B {
  layout(offset = 120) uint x0;
  layout(offset = 124) uint x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = 0x1234;
x1 = 0x5678;
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x1234) result--;
if (words[31] == 0x5678) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 0) uint8_t x0;
  layout(offset = 1) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0xBBAA) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 0) uint8_t x0;
  layout(offset = 17) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0xAA) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0xBB00) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 1) uint8_t x0;
  layout(offset = 2) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0xBBAA00) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 1) uint8_t x0;
  layout(offset = 18) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0xAA00) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0xBB0000) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 2) uint8_t x0;
  layout(offset = 3) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0xBBAA0000) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 2) uint8_t x0;
  layout(offset = 19) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0xAA0000) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0xBB000000) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 3) uint8_t x0;
  layout(offset = 4) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0xAA000000) result--;
if (words[1] == 0xBB) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 3) uint8_t x0;
  layout(offset = 20) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0xAA000000) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0xBB) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 4) uint8_t x0;
  layout(offset = 5) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0xBBAA) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 4) uint8_t x0;
  layout(offset = 21) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0xAA) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0xBB00) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 5) uint8_t x0;
  layout(offset = 6) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0xBBAA00) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 5) uint8_t x0;
  layout(offset = 22) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0xAA00) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0xBB0000) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 6) uint8_t x0;
  layout(offset = 7) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0xBBAA0000) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 6) uint8_t x0;
  layout(offset = 23) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0xAA0000) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0xBB000000) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 7) uint8_t x0;
  layout(offset = 8) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0xAA000000) result--;
if (words[2] == 0xBB) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 7) uint8_t x0;
  layout(offset = 24) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0xAA000000) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0xBB) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 8) uint8_t x0;
  layout(offset = 9) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0xBBAA) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 8) uint8_t x0;
  layout(offset = 25) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0xAA) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0xBB00) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 9) uint8_t x0;
  layout(offset = 10) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0xBBAA00) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 9) uint8_t x0;
  layout(offset = 26) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0xAA00) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0xBB0000) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 10) uint8_t x0;
  layout(offset = 11) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0xBBAA0000) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 10) uint8_t x0;
  layout(offset = 27) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0xAA0000) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0xBB000000) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 11) uint8_t x0;
  layout(offset = 12) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0xAA000000) result--;
if (words[3] == 0xBB) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 11) uint8_t x0;
  layout(offset = 28) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0xAA000000) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0xBB) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 12) uint8_t x0;
  layout(offset = 13) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0xBBAA) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 12) uint8_t x0;
  layout(offset = 29) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0xAA) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0xBB00) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 13) uint8_t x0;
  layout(offset = 14) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0xBBAA00) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 13) uint8_t x0;
  layout(offset = 30) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0xAA00) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0xBB0000) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 14) uint8_t x0;
  layout(offset = 15) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0xBBAA0000) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 14) uint8_t x0;
  layout(offset = 31) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0xAA0000) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0xBB000000) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 15) uint8_t x0;
  layout(offset = 16) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0xAA000000) result--;
if (words[4] == 0xBB) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 16) uint8_t x0;
  layout(offset = 17) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0xBBAA) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 17) uint8_t x0;
  layout(offset = 18) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0xBBAA00) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 18) uint8_t x0;
  layout(offset = 19) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0xBBAA0000) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 19) uint8_t x0;
  layout(offset = 20) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0xAA000000) result--;
if (words[5] == 0xBB) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 20) uint8_t x0;
  layout(offset = 21) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0xBBAA) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 21) uint8_t x0;
  layout(offset = 22) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0xBBAA00) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 22) uint8_t x0;
  layout(offset = 23) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0xBBAA0000) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 23) uint8_t x0;
  layout(offset = 24) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0xAA000000) result--;
if (words[6] == 0xBB) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 24) uint8_t x0;
  layout(offset = 25) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0xBBAA) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 25) uint8_t x0;
  layout(offset = 26) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0xBBAA00) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 26) uint8_t x0;
  layout(offset = 27) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0xBBAA0000) result--;
if (words[7] == 0x0) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 27) uint8_t x0;
  layout(offset = 28) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0xAA000000) result--;
if (words[7] == 0xBB) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 28) uint8_t x0;
  layout(offset = 29) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0xBBAA) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 29) uint8_t x0;
  layout(offset = 30) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0xBBAA00) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t words[32]; };
#extension GL_EXT_scalar_block_layout : enable
layout (scalar) shared B {
  layout(offset = 30) uint8_t x0;
  layout(offset = 31) uint8_t x1;
};
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < 32; i++) words[i] = 0;
x0 = uint8_t(0xAA);
x1 = uint8_t(0xBB);
result = 32;
if (words[0] == 0x0) result--;
if (words[1] == 0x0) result--;
if (words[2] == 0x0) result--;
if (words[3] == 0x0) result--;
if (words[4] == 0x0) result--;
if (words[5] == 0x0) result--;
if (words[6] == 0x0) result--;
if (words[7] == 0xBBAA0000) result--;
if (words[8] == 0x0) result--;
if (words[9] == 0x0) result--;
if (words[10] == 0x0) result--;
if (words[11] == 0x0) result--;
if (words[12] == 0x0) result--;
if (words[13] == 0x0) result--;
if (words[14] == 0x0) result--;
if (words[15] == 0x0) result--;
if (words[16] == 0x0) result--;
if (words[17] == 0x0) result--;
if (words[18] == 0x0) result--;
if (words[19] == 0x0) result--;
if (words[20] == 0x0) result--;
if (words[21] == 0x0) result--;
if (words[22] == 0x0) result--;
if (words[23] == 0x0) result--;
if (words[24] == 0x0) result--;
if (words[25] == 0x0) result--;
if (words[26] == 0x0) result--;
if (words[27] == 0x0) result--;
if (words[28] == 0x0) result--;
if (words[29] == 0x0) result--;
if (words[30] == 0x0) result--;
if (words[31] == 0x0) result--;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 8, local_size_y = 1, local_size_z = 1) in;
shared B0 { uint32_t words[2]; } b0;
shared B1 { uint32_t words[2]; } b1;
shared B2 { uint32_t words[2]; } b2;
shared B3 { uint32_t words[2]; } b3;
shared B4 { uint32_t words[2]; } b4;
shared B5 { uint32_t words[2]; } b5;
shared B6 { uint32_t words[2]; } b6;
shared B7 { uint32_t words[2]; } b7;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  int size = 2;
  if (index == 0) for (int x = 0; x < size; x++) b0.words[x] = 0xFFFF;
  barrier();
  for (int x = 0; x < size; x++) {
    if (x % 8 != index) continue;
    if (index == 0) b0.words[x] = (x << 3) | 0;
    if (index == 1) b1.words[x] = (x << 3) | 1;
    if (index == 2) b2.words[x] = (x << 3) | 2;
    if (index == 3) b3.words[x] = (x << 3) | 3;
    if (index == 4) b4.words[x] = (x << 3) | 4;
    if (index == 5) b5.words[x] = (x << 3) | 5;
    if (index == 6) b6.words[x] = (x << 3) | 6;
    if (index == 7) b7.words[x] = (x << 3) | 7;
  }
  barrier();
  if (index != 0) return;
  int r = size;
  for (int x = 0; x < size; x++) {
    int expected = (x << 3) | (x % 8);
    if (b0.words[x] == expected) r--;
  }
  result = r;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 8, local_size_y = 1, local_size_z = 1) in;
shared B0 { uint32_t words[16]; } b0;
shared B1 { uint32_t words[16]; } b1;
shared B2 { uint32_t words[16]; } b2;
shared B3 { uint32_t words[16]; } b3;
shared B4 { uint32_t words[16]; } b4;
shared B5 { uint32_t words[16]; } b5;
shared B6 { uint32_t words[16]; } b6;
shared B7 { uint32_t words[16]; } b7;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  int size = 16;
  if (index == 0) for (int x = 0; x < size; x++) b0.words[x] = 0xFFFF;
  barrier();
  for (int x = 0; x < size; x++) {
    if (x % 8 != index) continue;
    if (index == 0) b0.words[x] = (x << 3) | 0;
    if (index == 1) b1.words[x] = (x << 3) | 1;
    if (index == 2) b2.words[x] = (x << 3) | 2;
    if (index == 3) b3.words[x] = (x << 3) | 3;
    if (index == 4) b4.words[x] = (x << 3) | 4;
    if (index == 5) b5.words[x] = (x << 3) | 5;
    if (index == 6) b6.words[x] = (x << 3) | 6;
    if (index == 7) b7.words[x] = (x << 3) | 7;
  }
  barrier();
  if (index != 0) return;
  int r = size;
  for (int x = 0; x < size; x++) {
    int expected = (x << 3) | (x % 8);
    if (b0.words[x] == expected) r--;
  }
  result = r;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 8, local_size_y = 1, local_size_z = 1) in;
shared B0 { uint32_t words[1024]; } b0;
shared B1 { uint32_t words[1024]; } b1;
shared B2 { uint32_t words[1024]; } b2;
shared B3 { uint32_t words[1024]; } b3;
shared B4 { uint32_t words[1024]; } b4;
shared B5 { uint32_t words[1024]; } b5;
shared B6 { uint32_t words[1024]; } b6;
shared B7 { uint32_t words[1024]; } b7;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  int size = 1024;
  if (index == 0) for (int x = 0; x < size; x++) b0.words[x] = 0xFFFF;
  barrier();
  for (int x = 0; x < size; x++) {
    if (x % 8 != index) continue;
    if (index == 0) b0.words[x] = (x << 3) | 0;
    if (index == 1) b1.words[x] = (x << 3) | 1;
    if (index == 2) b2.words[x] = (x << 3) | 2;
    if (index == 3) b3.words[x] = (x << 3) | 3;
    if (index == 4) b4.words[x] = (x << 3) | 4;
    if (index == 5) b5.words[x] = (x << 3) | 5;
    if (index == 6) b6.words[x] = (x << 3) | 6;
    if (index == 7) b7.words[x] = (x << 3) | 7;
  }
  barrier();
  if (index != 0) return;
  int r = size;
  for (int x = 0; x < size; x++) {
    int expected = (x << 3) | (x % 8);
    if (b0.words[x] == expected) r--;
  }
  result = r;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 8, local_size_y = 1, local_size_z = 1) in;
shared B0 { uint32_t words[4096]; } b0;
shared B1 { uint32_t words[4096]; } b1;
shared B2 { uint32_t words[4096]; } b2;
shared B3 { uint32_t words[4096]; } b3;
shared B4 { uint32_t words[4096]; } b4;
shared B5 { uint32_t words[4096]; } b5;
shared B6 { uint32_t words[4096]; } b6;
shared B7 { uint32_t words[4096]; } b7;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  int size = 4096;
  if (index == 0) for (int x = 0; x < size; x++) b0.words[x] = 0xFFFF;
  barrier();
  for (int x = 0; x < size; x++) {
    if (x % 8 != index) continue;
    if (index == 0) b0.words[x] = (x << 3) | 0;
    if (index == 1) b1.words[x] = (x << 3) | 1;
    if (index == 2) b2.words[x] = (x << 3) | 2;
    if (index == 3) b3.words[x] = (x << 3) | 3;
    if (index == 4) b4.words[x] = (x << 3) | 4;
    if (index == 5) b5.words[x] = (x << 3) | 5;
    if (index == 6) b6.words[x] = (x << 3) | 6;
    if (index == 7) b7.words[x] = (x << 3) | 7;
  }
  barrier();
  if (index != 0) return;
  int r = size;
  for (int x = 0; x < size; x++) {
    int expected = (x << 3) | (x % 8);
    if (b0.words[x] == expected) r--;
  }
  result = r;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 8, local_size_y = 1, local_size_z = 1) in;
shared B0 { uint32_t words[8192]; } b0;
shared B1 { uint32_t words[8192]; } b1;
shared B2 { uint32_t words[8192]; } b2;
shared B3 { uint32_t words[8192]; } b3;
shared B4 { uint32_t words[8192]; } b4;
shared B5 { uint32_t words[8192]; } b5;
shared B6 { uint32_t words[8192]; } b6;
shared B7 { uint32_t words[8192]; } b7;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  int size = 8192;
  if (index == 0) for (int x = 0; x < size; x++) b0.words[x] = 0xFFFF;
  barrier();
  for (int x = 0; x < size; x++) {
    if (x % 8 != index) continue;
    if (index == 0) b0.words[x] = (x << 3) | 0;
    if (index == 1) b1.words[x] = (x << 3) | 1;
    if (index == 2) b2.words[x] = (x << 3) | 2;
    if (index == 3) b3.words[x] = (x << 3) | 3;
    if (index == 4) b4.words[x] = (x << 3) | 4;
    if (index == 5) b5.words[x] = (x << 3) | 5;
    if (index == 6) b6.words[x] = (x << 3) | 6;
    if (index == 7) b7.words[x] = (x << 3) | 7;
  }
  barrier();
  if (index != 0) return;
  int r = size;
  for (int x = 0; x < size; x++) {
    int expected = (x << 3) | (x % 8);
    if (b0.words[x] == expected) r--;
  }
  result = r;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 8, local_size_y = 1, local_size_z = 1) in;
shared B0 { uint32_t words[12288]; } b0;
shared B1 { uint32_t words[12288]; } b1;
shared B2 { uint32_t words[12288]; } b2;
shared B3 { uint32_t words[12288]; } b3;
shared B4 { uint32_t words[12288]; } b4;
shared B5 { uint32_t words[12288]; } b5;
shared B6 { uint32_t words[12288]; } b6;
shared B7 { uint32_t words[12288]; } b7;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  int size = 12288;
  if (index == 0) for (int x = 0; x < size; x++) b0.words[x] = 0xFFFF;
  barrier();
  for (int x = 0; x < size; x++) {
    if (x % 8 != index) continue;
    if (index == 0) b0.words[x] = (x << 3) | 0;
    if (index == 1) b1.words[x] = (x << 3) | 1;
    if (index == 2) b2.words[x] = (x << 3) | 2;
    if (index == 3) b3.words[x] = (x << 3) | 3;
    if (index == 4) b4.words[x] = (x << 3) | 4;
    if (index == 5) b5.words[x] = (x << 3) | 5;
    if (index == 6) b6.words[x] = (x << 3) | 6;
    if (index == 7) b7.words[x] = (x << 3) | 7;
  }
  barrier();
  if (index != 0) return;
  int r = size;
  for (int x = 0; x < size; x++) {
    int expected = (x << 3) | (x % 8);
    if (b0.words[x] == expected) r--;
  }
  result = r;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 8, local_size_y = 1, local_size_z = 1) in;
shared B0 { uint32_t words[16384]; } b0;
shared B1 { uint32_t words[16384]; } b1;
shared B2 { uint32_t words[16384]; } b2;
shared B3 { uint32_t words[16384]; } b3;
shared B4 { uint32_t words[16384]; } b4;
shared B5 { uint32_t words[16384]; } b5;
shared B6 { uint32_t words[16384]; } b6;
shared B7 { uint32_t words[16384]; } b7;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  int size = 16384;
  if (index == 0) for (int x = 0; x < size; x++) b0.words[x] = 0xFFFF;
  barrier();
  for (int x = 0; x < size; x++) {
    if (x % 8 != index) continue;
    if (index == 0) b0.words[x] = (x << 3) | 0;
    if (index == 1) b1.words[x] = (x << 3) | 1;
    if (index == 2) b2.words[x] = (x << 3) | 2;
    if (index == 3) b3.words[x] = (x << 3) | 3;
    if (index == 4) b4.words[x] = (x << 3) | 4;
    if (index == 5) b5.words[x] = (x << 3) | 5;
    if (index == 6) b6.words[x] = (x << 3) | 6;
    if (index == 7) b7.words[x] = (x << 3) | 7;
  }
  barrier();
  if (index != 0) return;
  int r = size;
  for (int x = 0; x < size; x++) {
    int expected = (x << 3) | (x % 8);
    if (b0.words[x] == expected) r--;
  }
  result = r;
}
