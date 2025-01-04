#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int8_t v; } a;
shared B { uint8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int8_t(-2);
  if (b.v == uint8_t(0xFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { int8_t v; } a;
layout(std140)shared B { uint8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int8_t(-2);
  if (b.v == uint8_t(0xFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int8_t v; } a;
layout(std430)shared B { uint8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int8_t(-2);
  if (b.v == uint8_t(0xFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int8_t v; } a;
layout(scalar)shared B { uint8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int8_t(-2);
  if (b.v == uint8_t(0xFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int8_t v; } a;
shared B { uint8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t(0xFE))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int8_t(-2);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { int8_t v; } a;
layout(std140)shared B { uint8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t(0xFE))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int8_t(-2);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int8_t v; } a;
layout(std430)shared B { uint8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t(0xFE))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int8_t(-2);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int8_t v; } a;
layout(scalar)shared B { uint8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t(0xFE))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int8_t(-2);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int8_t v; } a;
shared B { uint8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int8_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint8_t(0xFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { int8_t v; } a;
layout(std140)shared B { uint8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int8_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint8_t(0xFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int8_t v; } a;
layout(std430)shared B { uint8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int8_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint8_t(0xFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int8_t v; } a;
layout(scalar)shared B { uint8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int8_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint8_t(0xFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int8_t v; } a;
shared B { uint8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t(0xFE))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int8_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int8_t(-2);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { int8_t v; } a;
layout(std140)shared B { uint8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t(0xFE))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int8_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int8_t(-2);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int8_t v; } a;
layout(std430)shared B { uint8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t(0xFE))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int8_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int8_t(-2);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int8_t v; } a;
layout(scalar)shared B { uint8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t(0xFE))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int8_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int8_t(-2);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int8_t v; } a;
shared B { uint8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int8_t(-2);
  barrier();
  if (b.v == uint8_t(0xFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { int8_t v; } a;
layout(std140)shared B { uint8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int8_t(-2);
  barrier();
  if (b.v == uint8_t(0xFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int8_t v; } a;
layout(std430)shared B { uint8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int8_t(-2);
  barrier();
  if (b.v == uint8_t(0xFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int8_t v; } a;
layout(scalar)shared B { uint8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int8_t(-2);
  barrier();
  if (b.v == uint8_t(0xFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int8_t v; } a;
shared B { uint8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t(0xFE))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int8_t(-2);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { int8_t v; } a;
layout(std140)shared B { uint8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t(0xFE))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int8_t(-2);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int8_t v; } a;
layout(std430)shared B { uint8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t(0xFE))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int8_t(-2);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int8_t v; } a;
layout(scalar)shared B { uint8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t(0xFE))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int8_t(-2);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int8_t v; } a;
shared B { uint8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int8_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint8_t(0xFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { int8_t v; } a;
layout(std140)shared B { uint8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int8_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint8_t(0xFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int8_t v; } a;
layout(std430)shared B { uint8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int8_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint8_t(0xFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int8_t v; } a;
layout(scalar)shared B { uint8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int8_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint8_t(0xFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int8_t v; } a;
shared B { uint8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t(0xFE))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int8_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int8_t(-2);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { int8_t v; } a;
layout(std140)shared B { uint8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t(0xFE))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int8_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int8_t(-2);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int8_t v; } a;
layout(std430)shared B { uint8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t(0xFE))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int8_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int8_t(-2);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int8_t v; } a;
layout(scalar)shared B { uint8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t(0xFE))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int8_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int8_t(-2);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v; } a;
shared B { int8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t(0xFE);
  if (b.v == int8_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint8_t v; } a;
layout(std140)shared B { int8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t(0xFE);
  if (b.v == int8_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v; } a;
layout(std430)shared B { int8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t(0xFE);
  if (b.v == int8_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v; } a;
layout(scalar)shared B { int8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t(0xFE);
  if (b.v == int8_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v; } a;
shared B { int8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int8_t(-2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t(0xFE);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint8_t v; } a;
layout(std140)shared B { int8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int8_t(-2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t(0xFE);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v; } a;
layout(std430)shared B { int8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int8_t(-2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t(0xFE);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v; } a;
layout(scalar)shared B { int8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int8_t(-2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t(0xFE);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v; } a;
shared B { int8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t(0xFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == int8_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint8_t v; } a;
layout(std140)shared B { int8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t(0xFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == int8_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v; } a;
layout(std430)shared B { int8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t(0xFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == int8_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v; } a;
layout(scalar)shared B { int8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t(0xFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == int8_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v; } a;
shared B { int8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int8_t(-2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t(0xFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t(0xFE);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint8_t v; } a;
layout(std140)shared B { int8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int8_t(-2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t(0xFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t(0xFE);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v; } a;
layout(std430)shared B { int8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int8_t(-2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t(0xFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t(0xFE);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v; } a;
layout(scalar)shared B { int8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int8_t(-2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t(0xFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t(0xFE);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v; } a;
shared B { int8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t(0xFE);
  barrier();
  if (b.v == int8_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint8_t v; } a;
layout(std140)shared B { int8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t(0xFE);
  barrier();
  if (b.v == int8_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v; } a;
layout(std430)shared B { int8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t(0xFE);
  barrier();
  if (b.v == int8_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v; } a;
layout(scalar)shared B { int8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t(0xFE);
  barrier();
  if (b.v == int8_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v; } a;
shared B { int8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int8_t(-2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t(0xFE);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint8_t v; } a;
layout(std140)shared B { int8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int8_t(-2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t(0xFE);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v; } a;
layout(std430)shared B { int8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int8_t(-2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t(0xFE);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v; } a;
layout(scalar)shared B { int8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int8_t(-2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t(0xFE);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v; } a;
shared B { int8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t(0xFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == int8_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint8_t v; } a;
layout(std140)shared B { int8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t(0xFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == int8_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v; } a;
layout(std430)shared B { int8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t(0xFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == int8_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v; } a;
layout(scalar)shared B { int8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t(0xFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == int8_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v; } a;
shared B { int8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int8_t(-2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t(0xFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t(0xFE);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint8_t v; } a;
layout(std140)shared B { int8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int8_t(-2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t(0xFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t(0xFE);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v; } a;
layout(std430)shared B { int8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int8_t(-2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t(0xFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t(0xFE);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v; } a;
layout(scalar)shared B { int8_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int8_t(-2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t(0xFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t(0xFE);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int16_t v; } a;
shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int16_t(-2);
  if (b.v == uint16_t(0xFFFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { int16_t v; } a;
layout(std140)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int16_t(-2);
  if (b.v == uint16_t(0xFFFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int16_t v; } a;
layout(std430)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int16_t(-2);
  if (b.v == uint16_t(0xFFFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int16_t v; } a;
layout(scalar)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int16_t(-2);
  if (b.v == uint16_t(0xFFFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int16_t v; } a;
shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0xFFFE))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int16_t(-2);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { int16_t v; } a;
layout(std140)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0xFFFE))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int16_t(-2);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int16_t v; } a;
layout(std430)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0xFFFE))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int16_t(-2);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int16_t v; } a;
layout(scalar)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0xFFFE))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int16_t(-2);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int16_t v; } a;
shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int16_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint16_t(0xFFFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { int16_t v; } a;
layout(std140)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int16_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint16_t(0xFFFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int16_t v; } a;
layout(std430)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int16_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint16_t(0xFFFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int16_t v; } a;
layout(scalar)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int16_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint16_t(0xFFFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int16_t v; } a;
shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0xFFFE))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int16_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int16_t(-2);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { int16_t v; } a;
layout(std140)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0xFFFE))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int16_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int16_t(-2);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int16_t v; } a;
layout(std430)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0xFFFE))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int16_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int16_t(-2);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int16_t v; } a;
layout(scalar)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0xFFFE))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int16_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int16_t(-2);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int16_t v; } a;
shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int16_t(-2);
  barrier();
  if (b.v == uint16_t(0xFFFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { int16_t v; } a;
layout(std140)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int16_t(-2);
  barrier();
  if (b.v == uint16_t(0xFFFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int16_t v; } a;
layout(std430)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int16_t(-2);
  barrier();
  if (b.v == uint16_t(0xFFFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int16_t v; } a;
layout(scalar)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int16_t(-2);
  barrier();
  if (b.v == uint16_t(0xFFFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int16_t v; } a;
shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0xFFFE))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int16_t(-2);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { int16_t v; } a;
layout(std140)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0xFFFE))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int16_t(-2);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int16_t v; } a;
layout(std430)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0xFFFE))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int16_t(-2);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int16_t v; } a;
layout(scalar)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0xFFFE))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int16_t(-2);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int16_t v; } a;
shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int16_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint16_t(0xFFFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { int16_t v; } a;
layout(std140)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int16_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint16_t(0xFFFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int16_t v; } a;
layout(std430)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int16_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint16_t(0xFFFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int16_t v; } a;
layout(scalar)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int16_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint16_t(0xFFFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int16_t v; } a;
shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0xFFFE))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int16_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int16_t(-2);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { int16_t v; } a;
layout(std140)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0xFFFE))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int16_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int16_t(-2);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int16_t v; } a;
layout(std430)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0xFFFE))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int16_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int16_t(-2);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int16_t v; } a;
layout(scalar)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0xFFFE))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int16_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int16_t(-2);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v; } a;
shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0xFFFE);
  if (b.v == int16_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint16_t v; } a;
layout(std140)shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0xFFFE);
  if (b.v == int16_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v; } a;
layout(std430)shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0xFFFE);
  if (b.v == int16_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v; } a;
layout(scalar)shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0xFFFE);
  if (b.v == int16_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v; } a;
shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int16_t(-2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0xFFFE);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint16_t v; } a;
layout(std140)shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int16_t(-2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0xFFFE);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v; } a;
layout(std430)shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int16_t(-2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0xFFFE);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v; } a;
layout(scalar)shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int16_t(-2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0xFFFE);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v; } a;
shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0xFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == int16_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint16_t v; } a;
layout(std140)shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0xFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == int16_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v; } a;
layout(std430)shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0xFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == int16_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v; } a;
layout(scalar)shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0xFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == int16_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v; } a;
shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int16_t(-2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0xFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0xFFFE);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint16_t v; } a;
layout(std140)shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int16_t(-2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0xFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0xFFFE);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v; } a;
layout(std430)shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int16_t(-2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0xFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0xFFFE);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v; } a;
layout(scalar)shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int16_t(-2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0xFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0xFFFE);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v; } a;
shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0xFFFE);
  barrier();
  if (b.v == int16_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint16_t v; } a;
layout(std140)shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0xFFFE);
  barrier();
  if (b.v == int16_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v; } a;
layout(std430)shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0xFFFE);
  barrier();
  if (b.v == int16_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v; } a;
layout(scalar)shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0xFFFE);
  barrier();
  if (b.v == int16_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v; } a;
shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int16_t(-2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0xFFFE);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint16_t v; } a;
layout(std140)shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int16_t(-2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0xFFFE);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v; } a;
layout(std430)shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int16_t(-2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0xFFFE);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v; } a;
layout(scalar)shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int16_t(-2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0xFFFE);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v; } a;
shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0xFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == int16_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint16_t v; } a;
layout(std140)shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0xFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == int16_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v; } a;
layout(std430)shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0xFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == int16_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v; } a;
layout(scalar)shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0xFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == int16_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v; } a;
shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int16_t(-2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0xFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0xFFFE);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint16_t v; } a;
layout(std140)shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int16_t(-2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0xFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0xFFFE);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v; } a;
layout(std430)shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int16_t(-2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0xFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0xFFFE);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v; } a;
layout(scalar)shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int16_t(-2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0xFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0xFFFE);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int32_t v; } a;
shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  if (b.v == uint32_t(0xFFFFFFFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { int32_t v; } a;
layout(std140)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  if (b.v == uint32_t(0xFFFFFFFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int32_t v; } a;
layout(std430)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  if (b.v == uint32_t(0xFFFFFFFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int32_t v; } a;
layout(scalar)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  if (b.v == uint32_t(0xFFFFFFFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int32_t v; } a;
shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0xFFFFFFFE))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { int32_t v; } a;
layout(std140)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0xFFFFFFFE))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int32_t v; } a;
layout(std430)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0xFFFFFFFE))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int32_t v; } a;
layout(scalar)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0xFFFFFFFE))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int32_t v; } a;
shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int32_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint32_t(0xFFFFFFFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { int32_t v; } a;
layout(std140)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int32_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint32_t(0xFFFFFFFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int32_t v; } a;
layout(std430)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int32_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint32_t(0xFFFFFFFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int32_t v; } a;
layout(scalar)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int32_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint32_t(0xFFFFFFFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int32_t v; } a;
shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0xFFFFFFFE))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int32_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { int32_t v; } a;
layout(std140)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0xFFFFFFFE))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int32_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int32_t v; } a;
layout(std430)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0xFFFFFFFE))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int32_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int32_t v; } a;
layout(scalar)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0xFFFFFFFE))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int32_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int32_t v; } a;
shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  barrier();
  if (b.v == uint32_t(0xFFFFFFFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { int32_t v; } a;
layout(std140)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  barrier();
  if (b.v == uint32_t(0xFFFFFFFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int32_t v; } a;
layout(std430)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  barrier();
  if (b.v == uint32_t(0xFFFFFFFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int32_t v; } a;
layout(scalar)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  barrier();
  if (b.v == uint32_t(0xFFFFFFFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int32_t v; } a;
shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0xFFFFFFFE))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { int32_t v; } a;
layout(std140)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0xFFFFFFFE))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int32_t v; } a;
layout(std430)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0xFFFFFFFE))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int32_t v; } a;
layout(scalar)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0xFFFFFFFE))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int32_t v; } a;
shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int32_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint32_t(0xFFFFFFFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { int32_t v; } a;
layout(std140)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int32_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint32_t(0xFFFFFFFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int32_t v; } a;
layout(std430)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int32_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint32_t(0xFFFFFFFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int32_t v; } a;
layout(scalar)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int32_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint32_t(0xFFFFFFFE))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int32_t v; } a;
shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0xFFFFFFFE))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int32_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { int32_t v; } a;
layout(std140)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0xFFFFFFFE))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int32_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int32_t v; } a;
layout(std430)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0xFFFFFFFE))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int32_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int32_t v; } a;
layout(scalar)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0xFFFFFFFE))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int32_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v; } a;
shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0xFFFFFFFE);
  if (b.v == int32_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint32_t v; } a;
layout(std140)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0xFFFFFFFE);
  if (b.v == int32_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v; } a;
layout(std430)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0xFFFFFFFE);
  if (b.v == int32_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v; } a;
layout(scalar)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0xFFFFFFFE);
  if (b.v == int32_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v; } a;
shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int32_t(-2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0xFFFFFFFE);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint32_t v; } a;
layout(std140)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int32_t(-2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0xFFFFFFFE);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v; } a;
layout(std430)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int32_t(-2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0xFFFFFFFE);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v; } a;
layout(scalar)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int32_t(-2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0xFFFFFFFE);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v; } a;
shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0xFFFFFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == int32_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint32_t v; } a;
layout(std140)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0xFFFFFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == int32_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v; } a;
layout(std430)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0xFFFFFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == int32_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v; } a;
layout(scalar)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0xFFFFFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == int32_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v; } a;
shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int32_t(-2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0xFFFFFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0xFFFFFFFE);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint32_t v; } a;
layout(std140)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int32_t(-2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0xFFFFFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0xFFFFFFFE);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v; } a;
layout(std430)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int32_t(-2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0xFFFFFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0xFFFFFFFE);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v; } a;
layout(scalar)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int32_t(-2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0xFFFFFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0xFFFFFFFE);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v; } a;
shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0xFFFFFFFE);
  barrier();
  if (b.v == int32_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint32_t v; } a;
layout(std140)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0xFFFFFFFE);
  barrier();
  if (b.v == int32_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v; } a;
layout(std430)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0xFFFFFFFE);
  barrier();
  if (b.v == int32_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v; } a;
layout(scalar)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0xFFFFFFFE);
  barrier();
  if (b.v == int32_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v; } a;
shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int32_t(-2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0xFFFFFFFE);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint32_t v; } a;
layout(std140)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int32_t(-2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0xFFFFFFFE);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v; } a;
layout(std430)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int32_t(-2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0xFFFFFFFE);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v; } a;
layout(scalar)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int32_t(-2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0xFFFFFFFE);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v; } a;
shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0xFFFFFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == int32_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint32_t v; } a;
layout(std140)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0xFFFFFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == int32_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v; } a;
layout(std430)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0xFFFFFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == int32_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v; } a;
layout(scalar)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0xFFFFFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == int32_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v; } a;
shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int32_t(-2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0xFFFFFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0xFFFFFFFE);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint32_t v; } a;
layout(std140)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int32_t(-2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0xFFFFFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0xFFFFFFFE);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v; } a;
layout(std430)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int32_t(-2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0xFFFFFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0xFFFFFFFE);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v; } a;
layout(scalar)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int32_t(-2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0xFFFFFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0xFFFFFFFE);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int64_t v; } a;
shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  if (b.v == uint64_t(0xFFFFFFFFFFFFFFFEUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { int64_t v; } a;
layout(std140)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  if (b.v == uint64_t(0xFFFFFFFFFFFFFFFEUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int64_t v; } a;
layout(std430)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  if (b.v == uint64_t(0xFFFFFFFFFFFFFFFEUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int64_t v; } a;
layout(scalar)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  if (b.v == uint64_t(0xFFFFFFFFFFFFFFFEUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int64_t v; } a;
shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0xFFFFFFFFFFFFFFFEUL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { int64_t v; } a;
layout(std140)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0xFFFFFFFFFFFFFFFEUL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int64_t v; } a;
layout(std430)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0xFFFFFFFFFFFFFFFEUL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int64_t v; } a;
layout(scalar)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0xFFFFFFFFFFFFFFFEUL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int64_t v; } a;
shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint64_t(0xFFFFFFFFFFFFFFFEUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { int64_t v; } a;
layout(std140)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint64_t(0xFFFFFFFFFFFFFFFEUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int64_t v; } a;
layout(std430)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint64_t(0xFFFFFFFFFFFFFFFEUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int64_t v; } a;
layout(scalar)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint64_t(0xFFFFFFFFFFFFFFFEUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int64_t v; } a;
shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0xFFFFFFFFFFFFFFFEUL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { int64_t v; } a;
layout(std140)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0xFFFFFFFFFFFFFFFEUL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int64_t v; } a;
layout(std430)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0xFFFFFFFFFFFFFFFEUL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int64_t v; } a;
layout(scalar)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0xFFFFFFFFFFFFFFFEUL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int64_t v; } a;
shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  barrier();
  if (b.v == uint64_t(0xFFFFFFFFFFFFFFFEUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { int64_t v; } a;
layout(std140)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  barrier();
  if (b.v == uint64_t(0xFFFFFFFFFFFFFFFEUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int64_t v; } a;
layout(std430)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  barrier();
  if (b.v == uint64_t(0xFFFFFFFFFFFFFFFEUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int64_t v; } a;
layout(scalar)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  barrier();
  if (b.v == uint64_t(0xFFFFFFFFFFFFFFFEUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int64_t v; } a;
shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0xFFFFFFFFFFFFFFFEUL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { int64_t v; } a;
layout(std140)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0xFFFFFFFFFFFFFFFEUL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int64_t v; } a;
layout(std430)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0xFFFFFFFFFFFFFFFEUL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int64_t v; } a;
layout(scalar)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0xFFFFFFFFFFFFFFFEUL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int64_t v; } a;
shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint64_t(0xFFFFFFFFFFFFFFFEUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { int64_t v; } a;
layout(std140)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint64_t(0xFFFFFFFFFFFFFFFEUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int64_t v; } a;
layout(std430)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint64_t(0xFFFFFFFFFFFFFFFEUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int64_t v; } a;
layout(scalar)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint64_t(0xFFFFFFFFFFFFFFFEUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int64_t v; } a;
shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0xFFFFFFFFFFFFFFFEUL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { int64_t v; } a;
layout(std140)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0xFFFFFFFFFFFFFFFEUL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int64_t v; } a;
layout(std430)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0xFFFFFFFFFFFFFFFEUL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int64_t v; } a;
layout(scalar)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0xFFFFFFFFFFFFFFFEUL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint64_t v; } a;
shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0xFFFFFFFFFFFFFFFEUL);
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint64_t v; } a;
layout(std140)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0xFFFFFFFFFFFFFFFEUL);
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint64_t v; } a;
layout(std430)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0xFFFFFFFFFFFFFFFEUL);
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint64_t v; } a;
layout(scalar)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0xFFFFFFFFFFFFFFFEUL);
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint64_t v; } a;
shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0xFFFFFFFFFFFFFFFEUL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint64_t v; } a;
layout(std140)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0xFFFFFFFFFFFFFFFEUL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint64_t v; } a;
layout(std430)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0xFFFFFFFFFFFFFFFEUL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint64_t v; } a;
layout(scalar)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0xFFFFFFFFFFFFFFFEUL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint64_t v; } a;
shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0xFFFFFFFFFFFFFFFEUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint64_t v; } a;
layout(std140)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0xFFFFFFFFFFFFFFFEUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint64_t v; } a;
layout(std430)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0xFFFFFFFFFFFFFFFEUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint64_t v; } a;
layout(scalar)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0xFFFFFFFFFFFFFFFEUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint64_t v; } a;
shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0xFFFFFFFFFFFFFFFEUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0xFFFFFFFFFFFFFFFEUL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint64_t v; } a;
layout(std140)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0xFFFFFFFFFFFFFFFEUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0xFFFFFFFFFFFFFFFEUL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint64_t v; } a;
layout(std430)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0xFFFFFFFFFFFFFFFEUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0xFFFFFFFFFFFFFFFEUL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint64_t v; } a;
layout(scalar)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0xFFFFFFFFFFFFFFFEUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0xFFFFFFFFFFFFFFFEUL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint64_t v; } a;
shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0xFFFFFFFFFFFFFFFEUL);
  barrier();
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint64_t v; } a;
layout(std140)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0xFFFFFFFFFFFFFFFEUL);
  barrier();
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint64_t v; } a;
layout(std430)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0xFFFFFFFFFFFFFFFEUL);
  barrier();
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint64_t v; } a;
layout(scalar)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0xFFFFFFFFFFFFFFFEUL);
  barrier();
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint64_t v; } a;
shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0xFFFFFFFFFFFFFFFEUL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint64_t v; } a;
layout(std140)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0xFFFFFFFFFFFFFFFEUL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint64_t v; } a;
layout(std430)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0xFFFFFFFFFFFFFFFEUL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint64_t v; } a;
layout(scalar)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0xFFFFFFFFFFFFFFFEUL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint64_t v; } a;
shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0xFFFFFFFFFFFFFFFEUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint64_t v; } a;
layout(std140)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0xFFFFFFFFFFFFFFFEUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint64_t v; } a;
layout(std430)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0xFFFFFFFFFFFFFFFEUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint64_t v; } a;
layout(scalar)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0xFFFFFFFFFFFFFFFEUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint64_t v; } a;
shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0xFFFFFFFFFFFFFFFEUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0xFFFFFFFFFFFFFFFEUL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint64_t v; } a;
layout(std140)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0xFFFFFFFFFFFFFFFEUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0xFFFFFFFFFFFFFFFEUL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint64_t v; } a;
layout(std430)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0xFFFFFFFFFFFFFFFEUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0xFFFFFFFFFFFFFFFEUL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint64_t v; } a;
layout(scalar)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0xFFFFFFFFFFFFFFFEUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0xFFFFFFFFFFFFFFFEUL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float16_t v; } a;
shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float16_t(1.0);
  if (b.v == uint16_t(0x3C00))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { float16_t v; } a;
layout(std140)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float16_t(1.0);
  if (b.v == uint16_t(0x3C00))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float16_t v; } a;
layout(std430)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float16_t(1.0);
  if (b.v == uint16_t(0x3C00))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float16_t v; } a;
layout(scalar)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float16_t(1.0);
  if (b.v == uint16_t(0x3C00))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float16_t v; } a;
shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0x3C00))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float16_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { float16_t v; } a;
layout(std140)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0x3C00))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float16_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float16_t v; } a;
layout(std430)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0x3C00))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float16_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float16_t v; } a;
layout(scalar)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0x3C00))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float16_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float16_t v; } a;
shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float16_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint16_t(0x3C00))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { float16_t v; } a;
layout(std140)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float16_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint16_t(0x3C00))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float16_t v; } a;
layout(std430)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float16_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint16_t(0x3C00))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float16_t v; } a;
layout(scalar)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float16_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint16_t(0x3C00))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float16_t v; } a;
shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0x3C00))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float16_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float16_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { float16_t v; } a;
layout(std140)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0x3C00))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float16_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float16_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float16_t v; } a;
layout(std430)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0x3C00))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float16_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float16_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float16_t v; } a;
layout(scalar)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0x3C00))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float16_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float16_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float16_t v; } a;
shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float16_t(1.0);
  barrier();
  if (b.v == uint16_t(0x3C00))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { float16_t v; } a;
layout(std140)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float16_t(1.0);
  barrier();
  if (b.v == uint16_t(0x3C00))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float16_t v; } a;
layout(std430)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float16_t(1.0);
  barrier();
  if (b.v == uint16_t(0x3C00))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float16_t v; } a;
layout(scalar)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float16_t(1.0);
  barrier();
  if (b.v == uint16_t(0x3C00))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float16_t v; } a;
shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0x3C00))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float16_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { float16_t v; } a;
layout(std140)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0x3C00))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float16_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float16_t v; } a;
layout(std430)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0x3C00))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float16_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float16_t v; } a;
layout(scalar)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0x3C00))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float16_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float16_t v; } a;
shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float16_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint16_t(0x3C00))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { float16_t v; } a;
layout(std140)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float16_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint16_t(0x3C00))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float16_t v; } a;
layout(std430)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float16_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint16_t(0x3C00))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float16_t v; } a;
layout(scalar)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float16_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint16_t(0x3C00))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float16_t v; } a;
shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0x3C00))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float16_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float16_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { float16_t v; } a;
layout(std140)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0x3C00))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float16_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float16_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float16_t v; } a;
layout(std430)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0x3C00))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float16_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float16_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float16_t v; } a;
layout(scalar)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0x3C00))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float16_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float16_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v; } a;
shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0x3C00);
  if (b.v == float16_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint16_t v; } a;
layout(std140)shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0x3C00);
  if (b.v == float16_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v; } a;
layout(std430)shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0x3C00);
  if (b.v == float16_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v; } a;
layout(scalar)shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0x3C00);
  if (b.v == float16_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v; } a;
shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float16_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0x3C00);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint16_t v; } a;
layout(std140)shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float16_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0x3C00);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v; } a;
layout(std430)shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float16_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0x3C00);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v; } a;
layout(scalar)shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float16_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0x3C00);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v; } a;
shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0x3C00);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == float16_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint16_t v; } a;
layout(std140)shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0x3C00);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == float16_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v; } a;
layout(std430)shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0x3C00);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == float16_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v; } a;
layout(scalar)shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0x3C00);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == float16_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v; } a;
shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float16_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0x3C00);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0x3C00);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint16_t v; } a;
layout(std140)shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float16_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0x3C00);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0x3C00);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v; } a;
layout(std430)shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float16_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0x3C00);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0x3C00);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v; } a;
layout(scalar)shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float16_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0x3C00);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0x3C00);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v; } a;
shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0x3C00);
  barrier();
  if (b.v == float16_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint16_t v; } a;
layout(std140)shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0x3C00);
  barrier();
  if (b.v == float16_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v; } a;
layout(std430)shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0x3C00);
  barrier();
  if (b.v == float16_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v; } a;
layout(scalar)shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0x3C00);
  barrier();
  if (b.v == float16_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v; } a;
shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float16_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0x3C00);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint16_t v; } a;
layout(std140)shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float16_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0x3C00);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v; } a;
layout(std430)shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float16_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0x3C00);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v; } a;
layout(scalar)shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float16_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0x3C00);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v; } a;
shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0x3C00);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == float16_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint16_t v; } a;
layout(std140)shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0x3C00);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == float16_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v; } a;
layout(std430)shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0x3C00);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == float16_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v; } a;
layout(scalar)shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0x3C00);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == float16_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v; } a;
shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float16_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0x3C00);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0x3C00);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint16_t v; } a;
layout(std140)shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float16_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0x3C00);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0x3C00);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v; } a;
layout(std430)shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float16_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0x3C00);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0x3C00);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v; } a;
layout(scalar)shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float16_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0x3C00);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0x3C00);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float32_t v; } a;
shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  if (b.v == uint32_t(0x3F800000))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { float32_t v; } a;
layout(std140)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  if (b.v == uint32_t(0x3F800000))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float32_t v; } a;
layout(std430)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  if (b.v == uint32_t(0x3F800000))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float32_t v; } a;
layout(scalar)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  if (b.v == uint32_t(0x3F800000))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float32_t v; } a;
shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0x3F800000))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { float32_t v; } a;
layout(std140)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0x3F800000))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float32_t v; } a;
layout(std430)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0x3F800000))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float32_t v; } a;
layout(scalar)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0x3F800000))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float32_t v; } a;
shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float32_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint32_t(0x3F800000))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { float32_t v; } a;
layout(std140)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float32_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint32_t(0x3F800000))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float32_t v; } a;
layout(std430)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float32_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint32_t(0x3F800000))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float32_t v; } a;
layout(scalar)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float32_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint32_t(0x3F800000))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float32_t v; } a;
shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0x3F800000))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float32_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { float32_t v; } a;
layout(std140)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0x3F800000))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float32_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float32_t v; } a;
layout(std430)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0x3F800000))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float32_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float32_t v; } a;
layout(scalar)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0x3F800000))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float32_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float32_t v; } a;
shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  barrier();
  if (b.v == uint32_t(0x3F800000))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { float32_t v; } a;
layout(std140)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  barrier();
  if (b.v == uint32_t(0x3F800000))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float32_t v; } a;
layout(std430)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  barrier();
  if (b.v == uint32_t(0x3F800000))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float32_t v; } a;
layout(scalar)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  barrier();
  if (b.v == uint32_t(0x3F800000))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float32_t v; } a;
shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0x3F800000))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { float32_t v; } a;
layout(std140)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0x3F800000))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float32_t v; } a;
layout(std430)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0x3F800000))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float32_t v; } a;
layout(scalar)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0x3F800000))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float32_t v; } a;
shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float32_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint32_t(0x3F800000))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { float32_t v; } a;
layout(std140)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float32_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint32_t(0x3F800000))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float32_t v; } a;
layout(std430)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float32_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint32_t(0x3F800000))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float32_t v; } a;
layout(scalar)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float32_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint32_t(0x3F800000))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float32_t v; } a;
shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0x3F800000))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float32_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { float32_t v; } a;
layout(std140)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0x3F800000))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float32_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float32_t v; } a;
layout(std430)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0x3F800000))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float32_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float32_t v; } a;
layout(scalar)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0x3F800000))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float32_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v; } a;
shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x3F800000);
  if (b.v == float32_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint32_t v; } a;
layout(std140)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x3F800000);
  if (b.v == float32_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v; } a;
layout(std430)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x3F800000);
  if (b.v == float32_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v; } a;
layout(scalar)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x3F800000);
  if (b.v == float32_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v; } a;
shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float32_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x3F800000);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint32_t v; } a;
layout(std140)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float32_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x3F800000);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v; } a;
layout(std430)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float32_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x3F800000);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v; } a;
layout(scalar)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float32_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x3F800000);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v; } a;
shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0x3F800000);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == float32_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint32_t v; } a;
layout(std140)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0x3F800000);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == float32_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v; } a;
layout(std430)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0x3F800000);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == float32_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v; } a;
layout(scalar)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0x3F800000);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == float32_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v; } a;
shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float32_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0x3F800000);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x3F800000);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint32_t v; } a;
layout(std140)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float32_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0x3F800000);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x3F800000);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v; } a;
layout(std430)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float32_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0x3F800000);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x3F800000);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v; } a;
layout(scalar)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float32_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0x3F800000);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x3F800000);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v; } a;
shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x3F800000);
  barrier();
  if (b.v == float32_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint32_t v; } a;
layout(std140)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x3F800000);
  barrier();
  if (b.v == float32_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v; } a;
layout(std430)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x3F800000);
  barrier();
  if (b.v == float32_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v; } a;
layout(scalar)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x3F800000);
  barrier();
  if (b.v == float32_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v; } a;
shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float32_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x3F800000);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint32_t v; } a;
layout(std140)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float32_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x3F800000);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v; } a;
layout(std430)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float32_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x3F800000);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v; } a;
layout(scalar)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float32_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x3F800000);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v; } a;
shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0x3F800000);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == float32_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint32_t v; } a;
layout(std140)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0x3F800000);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == float32_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v; } a;
layout(std430)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0x3F800000);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == float32_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v; } a;
layout(scalar)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0x3F800000);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == float32_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v; } a;
shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float32_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0x3F800000);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x3F800000);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint32_t v; } a;
layout(std140)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float32_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0x3F800000);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x3F800000);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v; } a;
layout(std430)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float32_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0x3F800000);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x3F800000);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v; } a;
layout(scalar)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float32_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0x3F800000);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x3F800000);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float64_t v; } a;
shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  if (b.v == uint64_t(0x3FF0000000000000UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { float64_t v; } a;
layout(std140)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  if (b.v == uint64_t(0x3FF0000000000000UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float64_t v; } a;
layout(std430)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  if (b.v == uint64_t(0x3FF0000000000000UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float64_t v; } a;
layout(scalar)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  if (b.v == uint64_t(0x3FF0000000000000UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float64_t v; } a;
shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x3FF0000000000000UL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { float64_t v; } a;
layout(std140)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x3FF0000000000000UL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float64_t v; } a;
layout(std430)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x3FF0000000000000UL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float64_t v; } a;
layout(scalar)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x3FF0000000000000UL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float64_t v; } a;
shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint64_t(0x3FF0000000000000UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { float64_t v; } a;
layout(std140)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint64_t(0x3FF0000000000000UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float64_t v; } a;
layout(std430)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint64_t(0x3FF0000000000000UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float64_t v; } a;
layout(scalar)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint64_t(0x3FF0000000000000UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float64_t v; } a;
shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x3FF0000000000000UL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { float64_t v; } a;
layout(std140)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x3FF0000000000000UL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float64_t v; } a;
layout(std430)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x3FF0000000000000UL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float64_t v; } a;
layout(scalar)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x3FF0000000000000UL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float64_t v; } a;
shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  barrier();
  if (b.v == uint64_t(0x3FF0000000000000UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { float64_t v; } a;
layout(std140)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  barrier();
  if (b.v == uint64_t(0x3FF0000000000000UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float64_t v; } a;
layout(std430)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  barrier();
  if (b.v == uint64_t(0x3FF0000000000000UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float64_t v; } a;
layout(scalar)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  barrier();
  if (b.v == uint64_t(0x3FF0000000000000UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float64_t v; } a;
shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x3FF0000000000000UL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { float64_t v; } a;
layout(std140)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x3FF0000000000000UL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float64_t v; } a;
layout(std430)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x3FF0000000000000UL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float64_t v; } a;
layout(scalar)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x3FF0000000000000UL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float64_t v; } a;
shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint64_t(0x3FF0000000000000UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { float64_t v; } a;
layout(std140)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint64_t(0x3FF0000000000000UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float64_t v; } a;
layout(std430)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint64_t(0x3FF0000000000000UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float64_t v; } a;
layout(scalar)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint64_t(0x3FF0000000000000UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float64_t v; } a;
shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x3FF0000000000000UL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { float64_t v; } a;
layout(std140)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x3FF0000000000000UL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float64_t v; } a;
layout(std430)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x3FF0000000000000UL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float64_t v; } a;
layout(scalar)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x3FF0000000000000UL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint64_t v; } a;
shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x3FF0000000000000UL);
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint64_t v; } a;
layout(std140)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x3FF0000000000000UL);
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint64_t v; } a;
layout(std430)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x3FF0000000000000UL);
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint64_t v; } a;
layout(scalar)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x3FF0000000000000UL);
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint64_t v; } a;
shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x3FF0000000000000UL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint64_t v; } a;
layout(std140)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x3FF0000000000000UL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint64_t v; } a;
layout(std430)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x3FF0000000000000UL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint64_t v; } a;
layout(scalar)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x3FF0000000000000UL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint64_t v; } a;
shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x3FF0000000000000UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint64_t v; } a;
layout(std140)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x3FF0000000000000UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint64_t v; } a;
layout(std430)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x3FF0000000000000UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint64_t v; } a;
layout(scalar)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x3FF0000000000000UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint64_t v; } a;
shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x3FF0000000000000UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x3FF0000000000000UL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint64_t v; } a;
layout(std140)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x3FF0000000000000UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x3FF0000000000000UL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint64_t v; } a;
layout(std430)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x3FF0000000000000UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x3FF0000000000000UL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint64_t v; } a;
layout(scalar)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x3FF0000000000000UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x3FF0000000000000UL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint64_t v; } a;
shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x3FF0000000000000UL);
  barrier();
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint64_t v; } a;
layout(std140)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x3FF0000000000000UL);
  barrier();
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint64_t v; } a;
layout(std430)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x3FF0000000000000UL);
  barrier();
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint64_t v; } a;
layout(scalar)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x3FF0000000000000UL);
  barrier();
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint64_t v; } a;
shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x3FF0000000000000UL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint64_t v; } a;
layout(std140)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x3FF0000000000000UL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint64_t v; } a;
layout(std430)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x3FF0000000000000UL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint64_t v; } a;
layout(scalar)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x3FF0000000000000UL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint64_t v; } a;
shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x3FF0000000000000UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint64_t v; } a;
layout(std140)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x3FF0000000000000UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint64_t v; } a;
layout(std430)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x3FF0000000000000UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint64_t v; } a;
layout(scalar)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x3FF0000000000000UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint64_t v; } a;
shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x3FF0000000000000UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x3FF0000000000000UL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { uint64_t v; } a;
layout(std140)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x3FF0000000000000UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x3FF0000000000000UL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint64_t v; } a;
layout(std430)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x3FF0000000000000UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x3FF0000000000000UL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint64_t v; } a;
layout(scalar)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x3FF0000000000000UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x3FF0000000000000UL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v; } a;
shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0x1234);
  if (b.v == uint8_t[](uint8_t(52), uint8_t(18)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v; } a;
layout(std430)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0x1234);
  if (b.v == uint8_t[](uint8_t(52), uint8_t(18)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v; } a;
layout(scalar)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0x1234);
  if (b.v == uint8_t[](uint8_t(52), uint8_t(18)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v; } a;
shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(52), uint8_t(18)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0x1234);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v; } a;
layout(std430)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(52), uint8_t(18)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0x1234);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v; } a;
layout(scalar)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(52), uint8_t(18)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0x1234);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v; } a;
shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0x1234);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint8_t[](uint8_t(52), uint8_t(18)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v; } a;
layout(std430)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0x1234);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint8_t[](uint8_t(52), uint8_t(18)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v; } a;
layout(scalar)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0x1234);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint8_t[](uint8_t(52), uint8_t(18)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v; } a;
shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(52), uint8_t(18)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0x1234);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0x1234);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v; } a;
layout(std430)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(52), uint8_t(18)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0x1234);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0x1234);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v; } a;
layout(scalar)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(52), uint8_t(18)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0x1234);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0x1234);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v; } a;
shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0x1234);
  barrier();
  if (b.v == uint8_t[](uint8_t(52), uint8_t(18)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v; } a;
layout(std430)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0x1234);
  barrier();
  if (b.v == uint8_t[](uint8_t(52), uint8_t(18)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v; } a;
layout(scalar)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0x1234);
  barrier();
  if (b.v == uint8_t[](uint8_t(52), uint8_t(18)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v; } a;
shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(52), uint8_t(18)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0x1234);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v; } a;
layout(std430)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(52), uint8_t(18)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0x1234);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v; } a;
layout(scalar)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(52), uint8_t(18)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0x1234);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v; } a;
shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0x1234);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint8_t[](uint8_t(52), uint8_t(18)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v; } a;
layout(std430)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0x1234);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint8_t[](uint8_t(52), uint8_t(18)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v; } a;
layout(scalar)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0x1234);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint8_t[](uint8_t(52), uint8_t(18)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v; } a;
shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(52), uint8_t(18)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0x1234);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0x1234);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v; } a;
layout(std430)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(52), uint8_t(18)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0x1234);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0x1234);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v; } a;
layout(scalar)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(52), uint8_t(18)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t(0x1234);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t(0x1234);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[2]; } a;
shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(52), uint8_t(18));
  if (b.v == uint16_t(0x1234))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[2]; } a;
layout(std430)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(52), uint8_t(18));
  if (b.v == uint16_t(0x1234))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[2]; } a;
layout(scalar)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(52), uint8_t(18));
  if (b.v == uint16_t(0x1234))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[2]; } a;
shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0x1234))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(52), uint8_t(18));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[2]; } a;
layout(std430)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0x1234))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(52), uint8_t(18));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[2]; } a;
layout(scalar)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0x1234))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(52), uint8_t(18));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[2]; } a;
shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(52), uint8_t(18));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint16_t(0x1234))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[2]; } a;
layout(std430)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(52), uint8_t(18));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint16_t(0x1234))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[2]; } a;
layout(scalar)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(52), uint8_t(18));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint16_t(0x1234))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[2]; } a;
shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0x1234))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(52), uint8_t(18));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(52), uint8_t(18));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[2]; } a;
layout(std430)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0x1234))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(52), uint8_t(18));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(52), uint8_t(18));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[2]; } a;
layout(scalar)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0x1234))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(52), uint8_t(18));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(52), uint8_t(18));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[2]; } a;
shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(52), uint8_t(18));
  barrier();
  if (b.v == uint16_t(0x1234))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[2]; } a;
layout(std430)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(52), uint8_t(18));
  barrier();
  if (b.v == uint16_t(0x1234))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[2]; } a;
layout(scalar)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(52), uint8_t(18));
  barrier();
  if (b.v == uint16_t(0x1234))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[2]; } a;
shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0x1234))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(52), uint8_t(18));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[2]; } a;
layout(std430)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0x1234))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(52), uint8_t(18));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[2]; } a;
layout(scalar)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0x1234))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(52), uint8_t(18));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[2]; } a;
shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(52), uint8_t(18));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint16_t(0x1234))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[2]; } a;
layout(std430)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(52), uint8_t(18));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint16_t(0x1234))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[2]; } a;
layout(scalar)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(52), uint8_t(18));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint16_t(0x1234))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[2]; } a;
shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0x1234))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(52), uint8_t(18));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(52), uint8_t(18));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[2]; } a;
layout(std430)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0x1234))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(52), uint8_t(18));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(52), uint8_t(18));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[2]; } a;
layout(scalar)shared B { uint16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t(0x1234))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(52), uint8_t(18));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(52), uint8_t(18));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v; } a;
shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x12345678);
  if (b.v == uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v; } a;
layout(std430)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x12345678);
  if (b.v == uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v; } a;
layout(scalar)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x12345678);
  if (b.v == uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v; } a;
shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x12345678);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v; } a;
layout(std430)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x12345678);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v; } a;
layout(scalar)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x12345678);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v; } a;
shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0x12345678);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v; } a;
layout(std430)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0x12345678);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v; } a;
layout(scalar)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0x12345678);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v; } a;
shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0x12345678);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x12345678);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v; } a;
layout(std430)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0x12345678);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x12345678);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v; } a;
layout(scalar)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0x12345678);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x12345678);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v; } a;
shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x12345678);
  barrier();
  if (b.v == uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v; } a;
layout(std430)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x12345678);
  barrier();
  if (b.v == uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v; } a;
layout(scalar)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x12345678);
  barrier();
  if (b.v == uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v; } a;
shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x12345678);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v; } a;
layout(std430)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x12345678);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v; } a;
layout(scalar)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x12345678);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v; } a;
shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0x12345678);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v; } a;
layout(std430)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0x12345678);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v; } a;
layout(scalar)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0x12345678);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v; } a;
shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0x12345678);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x12345678);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v; } a;
layout(std430)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0x12345678);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x12345678);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v; } a;
layout(scalar)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0x12345678);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x12345678);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[4]; } a;
shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
  if (b.v == uint32_t(0x12345678))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[4]; } a;
layout(std430)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
  if (b.v == uint32_t(0x12345678))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[4]; } a;
layout(scalar)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
  if (b.v == uint32_t(0x12345678))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[4]; } a;
shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0x12345678))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[4]; } a;
layout(std430)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0x12345678))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[4]; } a;
layout(scalar)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0x12345678))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[4]; } a;
shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint32_t(0x12345678))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[4]; } a;
layout(std430)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint32_t(0x12345678))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[4]; } a;
layout(scalar)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint32_t(0x12345678))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[4]; } a;
shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0x12345678))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[4]; } a;
layout(std430)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0x12345678))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[4]; } a;
layout(scalar)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0x12345678))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[4]; } a;
shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
  barrier();
  if (b.v == uint32_t(0x12345678))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[4]; } a;
layout(std430)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
  barrier();
  if (b.v == uint32_t(0x12345678))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[4]; } a;
layout(scalar)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
  barrier();
  if (b.v == uint32_t(0x12345678))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[4]; } a;
shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0x12345678))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[4]; } a;
layout(std430)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0x12345678))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[4]; } a;
layout(scalar)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0x12345678))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[4]; } a;
shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint32_t(0x12345678))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[4]; } a;
layout(std430)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint32_t(0x12345678))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[4]; } a;
layout(scalar)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint32_t(0x12345678))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[4]; } a;
shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0x12345678))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[4]; } a;
layout(std430)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0x12345678))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[4]; } a;
layout(scalar)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0x12345678))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v; } a;
shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x12345678);
  if (b.v == uint16_t[](uint16_t(22136), uint16_t(4660)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v; } a;
layout(std430)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x12345678);
  if (b.v == uint16_t[](uint16_t(22136), uint16_t(4660)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v; } a;
layout(scalar)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x12345678);
  if (b.v == uint16_t[](uint16_t(22136), uint16_t(4660)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v; } a;
shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(22136), uint16_t(4660)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x12345678);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v; } a;
layout(std430)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(22136), uint16_t(4660)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x12345678);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v; } a;
layout(scalar)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(22136), uint16_t(4660)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x12345678);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v; } a;
shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0x12345678);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint16_t[](uint16_t(22136), uint16_t(4660)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v; } a;
layout(std430)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0x12345678);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint16_t[](uint16_t(22136), uint16_t(4660)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v; } a;
layout(scalar)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0x12345678);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint16_t[](uint16_t(22136), uint16_t(4660)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v; } a;
shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(22136), uint16_t(4660)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0x12345678);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x12345678);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v; } a;
layout(std430)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(22136), uint16_t(4660)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0x12345678);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x12345678);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v; } a;
layout(scalar)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(22136), uint16_t(4660)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0x12345678);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x12345678);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v; } a;
shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x12345678);
  barrier();
  if (b.v == uint16_t[](uint16_t(22136), uint16_t(4660)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v; } a;
layout(std430)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x12345678);
  barrier();
  if (b.v == uint16_t[](uint16_t(22136), uint16_t(4660)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v; } a;
layout(scalar)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x12345678);
  barrier();
  if (b.v == uint16_t[](uint16_t(22136), uint16_t(4660)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v; } a;
shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(22136), uint16_t(4660)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x12345678);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v; } a;
layout(std430)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(22136), uint16_t(4660)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x12345678);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v; } a;
layout(scalar)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(22136), uint16_t(4660)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x12345678);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v; } a;
shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0x12345678);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint16_t[](uint16_t(22136), uint16_t(4660)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v; } a;
layout(std430)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0x12345678);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint16_t[](uint16_t(22136), uint16_t(4660)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v; } a;
layout(scalar)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0x12345678);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint16_t[](uint16_t(22136), uint16_t(4660)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v; } a;
shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(22136), uint16_t(4660)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0x12345678);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x12345678);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v; } a;
layout(std430)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(22136), uint16_t(4660)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0x12345678);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x12345678);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v; } a;
layout(scalar)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(22136), uint16_t(4660)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t(0x12345678);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t(0x12345678);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[2]; } a;
shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(22136), uint16_t(4660));
  if (b.v == uint32_t(0x12345678))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[2]; } a;
layout(std430)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(22136), uint16_t(4660));
  if (b.v == uint32_t(0x12345678))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[2]; } a;
layout(scalar)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(22136), uint16_t(4660));
  if (b.v == uint32_t(0x12345678))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[2]; } a;
shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0x12345678))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(22136), uint16_t(4660));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[2]; } a;
layout(std430)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0x12345678))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(22136), uint16_t(4660));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[2]; } a;
layout(scalar)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0x12345678))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(22136), uint16_t(4660));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[2]; } a;
shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(22136), uint16_t(4660));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint32_t(0x12345678))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[2]; } a;
layout(std430)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(22136), uint16_t(4660));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint32_t(0x12345678))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[2]; } a;
layout(scalar)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(22136), uint16_t(4660));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint32_t(0x12345678))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[2]; } a;
shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0x12345678))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(22136), uint16_t(4660));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(22136), uint16_t(4660));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[2]; } a;
layout(std430)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0x12345678))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(22136), uint16_t(4660));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(22136), uint16_t(4660));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[2]; } a;
layout(scalar)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0x12345678))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(22136), uint16_t(4660));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(22136), uint16_t(4660));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[2]; } a;
shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(22136), uint16_t(4660));
  barrier();
  if (b.v == uint32_t(0x12345678))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[2]; } a;
layout(std430)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(22136), uint16_t(4660));
  barrier();
  if (b.v == uint32_t(0x12345678))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[2]; } a;
layout(scalar)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(22136), uint16_t(4660));
  barrier();
  if (b.v == uint32_t(0x12345678))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[2]; } a;
shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0x12345678))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(22136), uint16_t(4660));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[2]; } a;
layout(std430)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0x12345678))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(22136), uint16_t(4660));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[2]; } a;
layout(scalar)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0x12345678))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(22136), uint16_t(4660));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[2]; } a;
shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(22136), uint16_t(4660));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint32_t(0x12345678))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[2]; } a;
layout(std430)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(22136), uint16_t(4660));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint32_t(0x12345678))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[2]; } a;
layout(scalar)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(22136), uint16_t(4660));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint32_t(0x12345678))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[2]; } a;
shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0x12345678))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(22136), uint16_t(4660));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(22136), uint16_t(4660));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[2]; } a;
layout(std430)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0x12345678))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(22136), uint16_t(4660));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(22136), uint16_t(4660));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[2]; } a;
layout(scalar)shared B { uint32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t(0x12345678))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(22136), uint16_t(4660));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(22136), uint16_t(4660));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint64_t v; } a;
shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  if (b.v == uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint64_t v; } a;
layout(std430)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  if (b.v == uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint64_t v; } a;
layout(scalar)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  if (b.v == uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint64_t v; } a;
shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint64_t v; } a;
layout(std430)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint64_t v; } a;
layout(scalar)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint64_t v; } a;
shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x1234567890ABCDEFUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint64_t v; } a;
layout(std430)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x1234567890ABCDEFUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint64_t v; } a;
layout(scalar)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x1234567890ABCDEFUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint64_t v; } a;
shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x1234567890ABCDEFUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint64_t v; } a;
layout(std430)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x1234567890ABCDEFUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint64_t v; } a;
layout(scalar)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x1234567890ABCDEFUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint64_t v; } a;
shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  barrier();
  if (b.v == uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint64_t v; } a;
layout(std430)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  barrier();
  if (b.v == uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint64_t v; } a;
layout(scalar)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  barrier();
  if (b.v == uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint64_t v; } a;
shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint64_t v; } a;
layout(std430)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint64_t v; } a;
layout(scalar)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint64_t v; } a;
shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x1234567890ABCDEFUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint64_t v; } a;
layout(std430)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x1234567890ABCDEFUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint64_t v; } a;
layout(scalar)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x1234567890ABCDEFUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint64_t v; } a;
shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x1234567890ABCDEFUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint64_t v; } a;
layout(std430)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x1234567890ABCDEFUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint64_t v; } a;
layout(scalar)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x1234567890ABCDEFUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[8]; } a;
shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[8]; } a;
layout(std430)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[8]; } a;
layout(scalar)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[8]; } a;
shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[8]; } a;
layout(std430)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[8]; } a;
layout(scalar)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[8]; } a;
shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[8]; } a;
layout(std430)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[8]; } a;
layout(scalar)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[8]; } a;
shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[8]; } a;
layout(std430)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[8]; } a;
layout(scalar)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[8]; } a;
shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
  barrier();
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[8]; } a;
layout(std430)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
  barrier();
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[8]; } a;
layout(scalar)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
  barrier();
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[8]; } a;
shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[8]; } a;
layout(std430)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[8]; } a;
layout(scalar)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[8]; } a;
shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[8]; } a;
layout(std430)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[8]; } a;
layout(scalar)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[8]; } a;
shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[8]; } a;
layout(std430)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[8]; } a;
layout(scalar)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(239), uint8_t(205), uint8_t(171), uint8_t(144), uint8_t(120), uint8_t(86), uint8_t(52), uint8_t(18));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint64_t v; } a;
shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  if (b.v == uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint64_t v; } a;
layout(std430)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  if (b.v == uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint64_t v; } a;
layout(scalar)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  if (b.v == uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint64_t v; } a;
shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint64_t v; } a;
layout(std430)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint64_t v; } a;
layout(scalar)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint64_t v; } a;
shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x1234567890ABCDEFUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint64_t v; } a;
layout(std430)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x1234567890ABCDEFUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint64_t v; } a;
layout(scalar)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x1234567890ABCDEFUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint64_t v; } a;
shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x1234567890ABCDEFUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint64_t v; } a;
layout(std430)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x1234567890ABCDEFUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint64_t v; } a;
layout(scalar)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x1234567890ABCDEFUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint64_t v; } a;
shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  barrier();
  if (b.v == uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint64_t v; } a;
layout(std430)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  barrier();
  if (b.v == uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint64_t v; } a;
layout(scalar)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  barrier();
  if (b.v == uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint64_t v; } a;
shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint64_t v; } a;
layout(std430)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint64_t v; } a;
layout(scalar)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint64_t v; } a;
shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x1234567890ABCDEFUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint64_t v; } a;
layout(std430)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x1234567890ABCDEFUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint64_t v; } a;
layout(scalar)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x1234567890ABCDEFUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint64_t v; } a;
shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x1234567890ABCDEFUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint64_t v; } a;
layout(std430)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x1234567890ABCDEFUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint64_t v; } a;
layout(scalar)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x1234567890ABCDEFUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[4]; } a;
shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660));
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[4]; } a;
layout(std430)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660));
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[4]; } a;
layout(scalar)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660));
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[4]; } a;
shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[4]; } a;
layout(std430)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[4]; } a;
layout(scalar)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[4]; } a;
shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[4]; } a;
layout(std430)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[4]; } a;
layout(scalar)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[4]; } a;
shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[4]; } a;
layout(std430)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[4]; } a;
layout(scalar)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[4]; } a;
shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660));
  barrier();
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[4]; } a;
layout(std430)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660));
  barrier();
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[4]; } a;
layout(scalar)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660));
  barrier();
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[4]; } a;
shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[4]; } a;
layout(std430)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[4]; } a;
layout(scalar)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[4]; } a;
shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[4]; } a;
layout(std430)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[4]; } a;
layout(scalar)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[4]; } a;
shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[4]; } a;
layout(std430)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[4]; } a;
layout(scalar)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(52719), uint16_t(37035), uint16_t(22136), uint16_t(4660));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint64_t v; } a;
shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  if (b.v == uint32_t[](uint32_t(2427178479), uint32_t(305419896)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint64_t v; } a;
layout(std430)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  if (b.v == uint32_t[](uint32_t(2427178479), uint32_t(305419896)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint64_t v; } a;
layout(scalar)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  if (b.v == uint32_t[](uint32_t(2427178479), uint32_t(305419896)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint64_t v; } a;
shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t[](uint32_t(2427178479), uint32_t(305419896)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint64_t v; } a;
layout(std430)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t[](uint32_t(2427178479), uint32_t(305419896)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint64_t v; } a;
layout(scalar)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t[](uint32_t(2427178479), uint32_t(305419896)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint64_t v; } a;
shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x1234567890ABCDEFUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint32_t[](uint32_t(2427178479), uint32_t(305419896)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint64_t v; } a;
layout(std430)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x1234567890ABCDEFUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint32_t[](uint32_t(2427178479), uint32_t(305419896)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint64_t v; } a;
layout(scalar)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x1234567890ABCDEFUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint32_t[](uint32_t(2427178479), uint32_t(305419896)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint64_t v; } a;
shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t[](uint32_t(2427178479), uint32_t(305419896)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x1234567890ABCDEFUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint64_t v; } a;
layout(std430)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t[](uint32_t(2427178479), uint32_t(305419896)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x1234567890ABCDEFUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint64_t v; } a;
layout(scalar)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t[](uint32_t(2427178479), uint32_t(305419896)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x1234567890ABCDEFUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint64_t v; } a;
shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  barrier();
  if (b.v == uint32_t[](uint32_t(2427178479), uint32_t(305419896)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint64_t v; } a;
layout(std430)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  barrier();
  if (b.v == uint32_t[](uint32_t(2427178479), uint32_t(305419896)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint64_t v; } a;
layout(scalar)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  barrier();
  if (b.v == uint32_t[](uint32_t(2427178479), uint32_t(305419896)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint64_t v; } a;
shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t[](uint32_t(2427178479), uint32_t(305419896)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint64_t v; } a;
layout(std430)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t[](uint32_t(2427178479), uint32_t(305419896)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint64_t v; } a;
layout(scalar)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t[](uint32_t(2427178479), uint32_t(305419896)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint64_t v; } a;
shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x1234567890ABCDEFUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint32_t[](uint32_t(2427178479), uint32_t(305419896)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint64_t v; } a;
layout(std430)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x1234567890ABCDEFUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint32_t[](uint32_t(2427178479), uint32_t(305419896)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint64_t v; } a;
layout(scalar)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x1234567890ABCDEFUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint32_t[](uint32_t(2427178479), uint32_t(305419896)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint64_t v; } a;
shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t[](uint32_t(2427178479), uint32_t(305419896)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x1234567890ABCDEFUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint64_t v; } a;
layout(std430)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t[](uint32_t(2427178479), uint32_t(305419896)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x1234567890ABCDEFUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint64_t v; } a;
layout(scalar)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t[](uint32_t(2427178479), uint32_t(305419896)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint64_t(0x1234567890ABCDEFUL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint64_t(0x1234567890ABCDEFUL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v[2]; } a;
shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(2427178479), uint32_t(305419896));
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v[2]; } a;
layout(std430)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(2427178479), uint32_t(305419896));
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v[2]; } a;
layout(scalar)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(2427178479), uint32_t(305419896));
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v[2]; } a;
shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(2427178479), uint32_t(305419896));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v[2]; } a;
layout(std430)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(2427178479), uint32_t(305419896));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v[2]; } a;
layout(scalar)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(2427178479), uint32_t(305419896));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v[2]; } a;
shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t[](uint32_t(2427178479), uint32_t(305419896));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v[2]; } a;
layout(std430)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t[](uint32_t(2427178479), uint32_t(305419896));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v[2]; } a;
layout(scalar)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t[](uint32_t(2427178479), uint32_t(305419896));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v[2]; } a;
shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t[](uint32_t(2427178479), uint32_t(305419896));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(2427178479), uint32_t(305419896));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v[2]; } a;
layout(std430)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t[](uint32_t(2427178479), uint32_t(305419896));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(2427178479), uint32_t(305419896));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v[2]; } a;
layout(scalar)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t[](uint32_t(2427178479), uint32_t(305419896));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(2427178479), uint32_t(305419896));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v[2]; } a;
shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(2427178479), uint32_t(305419896));
  barrier();
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v[2]; } a;
layout(std430)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(2427178479), uint32_t(305419896));
  barrier();
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v[2]; } a;
layout(scalar)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(2427178479), uint32_t(305419896));
  barrier();
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v[2]; } a;
shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(2427178479), uint32_t(305419896));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v[2]; } a;
layout(std430)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(2427178479), uint32_t(305419896));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v[2]; } a;
layout(scalar)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(2427178479), uint32_t(305419896));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v[2]; } a;
shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t[](uint32_t(2427178479), uint32_t(305419896));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v[2]; } a;
layout(std430)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t[](uint32_t(2427178479), uint32_t(305419896));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v[2]; } a;
layout(scalar)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t[](uint32_t(2427178479), uint32_t(305419896));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v[2]; } a;
shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t[](uint32_t(2427178479), uint32_t(305419896));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(2427178479), uint32_t(305419896));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v[2]; } a;
layout(std430)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t[](uint32_t(2427178479), uint32_t(305419896));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(2427178479), uint32_t(305419896));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v[2]; } a;
layout(scalar)shared B { uint64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint64_t(0x1234567890ABCDEFUL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t[](uint32_t(2427178479), uint32_t(305419896));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(2427178479), uint32_t(305419896));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int16_t v; } a;
shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int16_t(-2);
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int16_t v; } a;
layout(std430)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int16_t(-2);
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int16_t v; } a;
layout(scalar)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int16_t(-2);
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int16_t v; } a;
shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int16_t(-2);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int16_t v; } a;
layout(std430)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int16_t(-2);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int16_t v; } a;
layout(scalar)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int16_t(-2);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int16_t v; } a;
shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int16_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int16_t v; } a;
layout(std430)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int16_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int16_t v; } a;
layout(scalar)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int16_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int16_t v; } a;
shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int16_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int16_t(-2);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int16_t v; } a;
layout(std430)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int16_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int16_t(-2);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int16_t v; } a;
layout(scalar)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int16_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int16_t(-2);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int16_t v; } a;
shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int16_t(-2);
  barrier();
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int16_t v; } a;
layout(std430)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int16_t(-2);
  barrier();
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int16_t v; } a;
layout(scalar)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int16_t(-2);
  barrier();
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int16_t v; } a;
shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int16_t(-2);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int16_t v; } a;
layout(std430)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int16_t(-2);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int16_t v; } a;
layout(scalar)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int16_t(-2);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int16_t v; } a;
shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int16_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int16_t v; } a;
layout(std430)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int16_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int16_t v; } a;
layout(scalar)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int16_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int16_t v; } a;
shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int16_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int16_t(-2);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int16_t v; } a;
layout(std430)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int16_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int16_t(-2);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int16_t v; } a;
layout(scalar)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int16_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int16_t(-2);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[2]; } a;
shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255));
  if (b.v == int16_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[2]; } a;
layout(std430)shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255));
  if (b.v == int16_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[2]; } a;
layout(scalar)shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255));
  if (b.v == int16_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[2]; } a;
shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int16_t(-2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[2]; } a;
layout(std430)shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int16_t(-2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[2]; } a;
layout(scalar)shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int16_t(-2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[2]; } a;
shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(254), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == int16_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[2]; } a;
layout(std430)shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(254), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == int16_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[2]; } a;
layout(scalar)shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(254), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == int16_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[2]; } a;
shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int16_t(-2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(254), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[2]; } a;
layout(std430)shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int16_t(-2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(254), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[2]; } a;
layout(scalar)shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int16_t(-2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(254), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[2]; } a;
shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255));
  barrier();
  if (b.v == int16_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[2]; } a;
layout(std430)shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255));
  barrier();
  if (b.v == int16_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[2]; } a;
layout(scalar)shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255));
  barrier();
  if (b.v == int16_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[2]; } a;
shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int16_t(-2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[2]; } a;
layout(std430)shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int16_t(-2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[2]; } a;
layout(scalar)shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int16_t(-2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[2]; } a;
shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(254), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == int16_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[2]; } a;
layout(std430)shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(254), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == int16_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[2]; } a;
layout(scalar)shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(254), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == int16_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[2]; } a;
shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int16_t(-2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(254), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[2]; } a;
layout(std430)shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int16_t(-2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(254), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[2]; } a;
layout(scalar)shared B { int16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int16_t(-2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(254), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int32_t v; } a;
shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int32_t v; } a;
layout(std430)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int32_t v; } a;
layout(scalar)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int32_t v; } a;
shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int32_t v; } a;
layout(std430)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int32_t v; } a;
layout(scalar)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int32_t v; } a;
shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int32_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int32_t v; } a;
layout(std430)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int32_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int32_t v; } a;
layout(scalar)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int32_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int32_t v; } a;
shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int32_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int32_t v; } a;
layout(std430)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int32_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int32_t v; } a;
layout(scalar)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int32_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int32_t v; } a;
shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  barrier();
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int32_t v; } a;
layout(std430)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  barrier();
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int32_t v; } a;
layout(scalar)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  barrier();
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int32_t v; } a;
shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int32_t v; } a;
layout(std430)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int32_t v; } a;
layout(scalar)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int32_t v; } a;
shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int32_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int32_t v; } a;
layout(std430)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int32_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int32_t v; } a;
layout(scalar)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int32_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int32_t v; } a;
shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int32_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int32_t v; } a;
layout(std430)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int32_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int32_t v; } a;
layout(scalar)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int32_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[4]; } a;
shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
  if (b.v == int32_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[4]; } a;
layout(std430)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
  if (b.v == int32_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[4]; } a;
layout(scalar)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
  if (b.v == int32_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[4]; } a;
shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int32_t(-2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[4]; } a;
layout(std430)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int32_t(-2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[4]; } a;
layout(scalar)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int32_t(-2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[4]; } a;
shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == int32_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[4]; } a;
layout(std430)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == int32_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[4]; } a;
layout(scalar)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == int32_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[4]; } a;
shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int32_t(-2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[4]; } a;
layout(std430)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int32_t(-2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[4]; } a;
layout(scalar)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int32_t(-2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[4]; } a;
shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
  barrier();
  if (b.v == int32_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[4]; } a;
layout(std430)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
  barrier();
  if (b.v == int32_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[4]; } a;
layout(scalar)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
  barrier();
  if (b.v == int32_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[4]; } a;
shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int32_t(-2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[4]; } a;
layout(std430)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int32_t(-2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[4]; } a;
layout(scalar)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int32_t(-2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[4]; } a;
shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == int32_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[4]; } a;
layout(std430)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == int32_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[4]; } a;
layout(scalar)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == int32_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[4]; } a;
shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int32_t(-2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[4]; } a;
layout(std430)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int32_t(-2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[4]; } a;
layout(scalar)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int32_t(-2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int32_t v; } a;
shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int32_t v; } a;
layout(std430)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int32_t v; } a;
layout(scalar)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int32_t v; } a;
shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int32_t v; } a;
layout(std430)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int32_t v; } a;
layout(scalar)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int32_t v; } a;
shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int32_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int32_t v; } a;
layout(std430)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int32_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int32_t v; } a;
layout(scalar)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int32_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int32_t v; } a;
shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int32_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int32_t v; } a;
layout(std430)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int32_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int32_t v; } a;
layout(scalar)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int32_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int32_t v; } a;
shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  barrier();
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int32_t v; } a;
layout(std430)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  barrier();
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int32_t v; } a;
layout(scalar)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  barrier();
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int32_t v; } a;
shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int32_t v; } a;
layout(std430)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int32_t v; } a;
layout(scalar)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int32_t v; } a;
shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int32_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int32_t v; } a;
layout(std430)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int32_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int32_t v; } a;
layout(scalar)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int32_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int32_t v; } a;
shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int32_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int32_t v; } a;
layout(std430)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int32_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int32_t v; } a;
layout(scalar)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int32_t(-2);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int32_t(-2);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[2]; } a;
shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(65534), uint16_t(65535));
  if (b.v == int32_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[2]; } a;
layout(std430)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(65534), uint16_t(65535));
  if (b.v == int32_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[2]; } a;
layout(scalar)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(65534), uint16_t(65535));
  if (b.v == int32_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[2]; } a;
shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int32_t(-2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(65534), uint16_t(65535));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[2]; } a;
layout(std430)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int32_t(-2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(65534), uint16_t(65535));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[2]; } a;
layout(scalar)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int32_t(-2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(65534), uint16_t(65535));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[2]; } a;
shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(65534), uint16_t(65535));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == int32_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[2]; } a;
layout(std430)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(65534), uint16_t(65535));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == int32_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[2]; } a;
layout(scalar)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(65534), uint16_t(65535));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == int32_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[2]; } a;
shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int32_t(-2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(65534), uint16_t(65535));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(65534), uint16_t(65535));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[2]; } a;
layout(std430)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int32_t(-2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(65534), uint16_t(65535));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(65534), uint16_t(65535));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[2]; } a;
layout(scalar)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int32_t(-2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(65534), uint16_t(65535));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(65534), uint16_t(65535));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[2]; } a;
shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(65534), uint16_t(65535));
  barrier();
  if (b.v == int32_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[2]; } a;
layout(std430)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(65534), uint16_t(65535));
  barrier();
  if (b.v == int32_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[2]; } a;
layout(scalar)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(65534), uint16_t(65535));
  barrier();
  if (b.v == int32_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[2]; } a;
shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int32_t(-2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(65534), uint16_t(65535));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[2]; } a;
layout(std430)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int32_t(-2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(65534), uint16_t(65535));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[2]; } a;
layout(scalar)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int32_t(-2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(65534), uint16_t(65535));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[2]; } a;
shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(65534), uint16_t(65535));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == int32_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[2]; } a;
layout(std430)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(65534), uint16_t(65535));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == int32_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[2]; } a;
layout(scalar)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(65534), uint16_t(65535));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == int32_t(-2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[2]; } a;
shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int32_t(-2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(65534), uint16_t(65535));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(65534), uint16_t(65535));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[2]; } a;
layout(std430)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int32_t(-2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(65534), uint16_t(65535));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(65534), uint16_t(65535));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[2]; } a;
layout(scalar)shared B { int32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int32_t(-2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(65534), uint16_t(65535));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(65534), uint16_t(65535));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int64_t v; } a;
shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int64_t v; } a;
layout(std430)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int64_t v; } a;
layout(scalar)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int64_t v; } a;
shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int64_t v; } a;
layout(std430)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int64_t v; } a;
layout(scalar)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int64_t v; } a;
shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int64_t v; } a;
layout(std430)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int64_t v; } a;
layout(scalar)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int64_t v; } a;
shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int64_t v; } a;
layout(std430)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int64_t v; } a;
layout(scalar)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int64_t v; } a;
shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  barrier();
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int64_t v; } a;
layout(std430)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  barrier();
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int64_t v; } a;
layout(scalar)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  barrier();
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int64_t v; } a;
shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int64_t v; } a;
layout(std430)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int64_t v; } a;
layout(scalar)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int64_t v; } a;
shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int64_t v; } a;
layout(std430)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int64_t v; } a;
layout(scalar)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int64_t v; } a;
shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int64_t v; } a;
layout(std430)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int64_t v; } a;
layout(scalar)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[8]; } a;
shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255));
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[8]; } a;
layout(std430)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255));
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[8]; } a;
layout(scalar)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255));
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[8]; } a;
shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[8]; } a;
layout(std430)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[8]; } a;
layout(scalar)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[8]; } a;
shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[8]; } a;
layout(std430)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[8]; } a;
layout(scalar)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[8]; } a;
shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[8]; } a;
layout(std430)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[8]; } a;
layout(scalar)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[8]; } a;
shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255));
  barrier();
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[8]; } a;
layout(std430)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255));
  barrier();
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[8]; } a;
layout(scalar)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255));
  barrier();
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[8]; } a;
shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[8]; } a;
layout(std430)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[8]; } a;
layout(scalar)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[8]; } a;
shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[8]; } a;
layout(std430)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[8]; } a;
layout(scalar)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[8]; } a;
shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[8]; } a;
layout(std430)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[8]; } a;
layout(scalar)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255), uint8_t(255));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int64_t v; } a;
shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int64_t v; } a;
layout(std430)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int64_t v; } a;
layout(scalar)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int64_t v; } a;
shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int64_t v; } a;
layout(std430)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int64_t v; } a;
layout(scalar)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int64_t v; } a;
shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int64_t v; } a;
layout(std430)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int64_t v; } a;
layout(scalar)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int64_t v; } a;
shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int64_t v; } a;
layout(std430)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int64_t v; } a;
layout(scalar)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int64_t v; } a;
shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  barrier();
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int64_t v; } a;
layout(std430)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  barrier();
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int64_t v; } a;
layout(scalar)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  barrier();
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int64_t v; } a;
shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int64_t v; } a;
layout(std430)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int64_t v; } a;
layout(scalar)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int64_t v; } a;
shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int64_t v; } a;
layout(std430)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int64_t v; } a;
layout(scalar)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int64_t v; } a;
shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int64_t v; } a;
layout(std430)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int64_t v; } a;
layout(scalar)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[4]; } a;
shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535));
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[4]; } a;
layout(std430)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535));
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[4]; } a;
layout(scalar)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535));
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[4]; } a;
shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[4]; } a;
layout(std430)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[4]; } a;
layout(scalar)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[4]; } a;
shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[4]; } a;
layout(std430)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[4]; } a;
layout(scalar)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[4]; } a;
shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[4]; } a;
layout(std430)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[4]; } a;
layout(scalar)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[4]; } a;
shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535));
  barrier();
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[4]; } a;
layout(std430)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535));
  barrier();
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[4]; } a;
layout(scalar)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535));
  barrier();
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[4]; } a;
shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[4]; } a;
layout(std430)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[4]; } a;
layout(scalar)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[4]; } a;
shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[4]; } a;
layout(std430)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[4]; } a;
layout(scalar)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[4]; } a;
shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[4]; } a;
layout(std430)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[4]; } a;
layout(scalar)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(65534), uint16_t(65535), uint16_t(65535), uint16_t(65535));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int64_t v; } a;
shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  if (b.v == uint32_t[](uint32_t(4294967294), uint32_t(4294967295)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int64_t v; } a;
layout(std430)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  if (b.v == uint32_t[](uint32_t(4294967294), uint32_t(4294967295)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int64_t v; } a;
layout(scalar)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  if (b.v == uint32_t[](uint32_t(4294967294), uint32_t(4294967295)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int64_t v; } a;
shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t[](uint32_t(4294967294), uint32_t(4294967295)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int64_t v; } a;
layout(std430)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t[](uint32_t(4294967294), uint32_t(4294967295)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int64_t v; } a;
layout(scalar)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t[](uint32_t(4294967294), uint32_t(4294967295)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int64_t v; } a;
shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint32_t[](uint32_t(4294967294), uint32_t(4294967295)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int64_t v; } a;
layout(std430)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint32_t[](uint32_t(4294967294), uint32_t(4294967295)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int64_t v; } a;
layout(scalar)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint32_t[](uint32_t(4294967294), uint32_t(4294967295)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int64_t v; } a;
shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t[](uint32_t(4294967294), uint32_t(4294967295)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int64_t v; } a;
layout(std430)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t[](uint32_t(4294967294), uint32_t(4294967295)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int64_t v; } a;
layout(scalar)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t[](uint32_t(4294967294), uint32_t(4294967295)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int64_t v; } a;
shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  barrier();
  if (b.v == uint32_t[](uint32_t(4294967294), uint32_t(4294967295)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int64_t v; } a;
layout(std430)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  barrier();
  if (b.v == uint32_t[](uint32_t(4294967294), uint32_t(4294967295)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int64_t v; } a;
layout(scalar)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  barrier();
  if (b.v == uint32_t[](uint32_t(4294967294), uint32_t(4294967295)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int64_t v; } a;
shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t[](uint32_t(4294967294), uint32_t(4294967295)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int64_t v; } a;
layout(std430)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t[](uint32_t(4294967294), uint32_t(4294967295)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int64_t v; } a;
layout(scalar)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t[](uint32_t(4294967294), uint32_t(4294967295)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int64_t v; } a;
shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint32_t[](uint32_t(4294967294), uint32_t(4294967295)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int64_t v; } a;
layout(std430)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint32_t[](uint32_t(4294967294), uint32_t(4294967295)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int64_t v; } a;
layout(scalar)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint32_t[](uint32_t(4294967294), uint32_t(4294967295)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { int64_t v; } a;
shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t[](uint32_t(4294967294), uint32_t(4294967295)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { int64_t v; } a;
layout(std430)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t[](uint32_t(4294967294), uint32_t(4294967295)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { int64_t v; } a;
layout(scalar)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t[](uint32_t(4294967294), uint32_t(4294967295)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = int64_t(-2UL);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = int64_t(-2UL);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v[2]; } a;
shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(4294967294), uint32_t(4294967295));
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v[2]; } a;
layout(std430)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(4294967294), uint32_t(4294967295));
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v[2]; } a;
layout(scalar)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(4294967294), uint32_t(4294967295));
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v[2]; } a;
shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(4294967294), uint32_t(4294967295));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v[2]; } a;
layout(std430)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(4294967294), uint32_t(4294967295));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v[2]; } a;
layout(scalar)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(4294967294), uint32_t(4294967295));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v[2]; } a;
shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t[](uint32_t(4294967294), uint32_t(4294967295));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v[2]; } a;
layout(std430)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t[](uint32_t(4294967294), uint32_t(4294967295));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v[2]; } a;
layout(scalar)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t[](uint32_t(4294967294), uint32_t(4294967295));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v[2]; } a;
shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t[](uint32_t(4294967294), uint32_t(4294967295));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(4294967294), uint32_t(4294967295));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v[2]; } a;
layout(std430)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t[](uint32_t(4294967294), uint32_t(4294967295));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(4294967294), uint32_t(4294967295));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v[2]; } a;
layout(scalar)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t[](uint32_t(4294967294), uint32_t(4294967295));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(4294967294), uint32_t(4294967295));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v[2]; } a;
shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(4294967294), uint32_t(4294967295));
  barrier();
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v[2]; } a;
layout(std430)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(4294967294), uint32_t(4294967295));
  barrier();
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v[2]; } a;
layout(scalar)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(4294967294), uint32_t(4294967295));
  barrier();
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v[2]; } a;
shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(4294967294), uint32_t(4294967295));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v[2]; } a;
layout(std430)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(4294967294), uint32_t(4294967295));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v[2]; } a;
layout(scalar)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(4294967294), uint32_t(4294967295));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v[2]; } a;
shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t[](uint32_t(4294967294), uint32_t(4294967295));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v[2]; } a;
layout(std430)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t[](uint32_t(4294967294), uint32_t(4294967295));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v[2]; } a;
layout(scalar)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t[](uint32_t(4294967294), uint32_t(4294967295));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == int64_t(-2UL))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v[2]; } a;
shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t[](uint32_t(4294967294), uint32_t(4294967295));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(4294967294), uint32_t(4294967295));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v[2]; } a;
layout(std430)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t[](uint32_t(4294967294), uint32_t(4294967295));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(4294967294), uint32_t(4294967295));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v[2]; } a;
layout(scalar)shared B { int64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == int64_t(-2UL))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t[](uint32_t(4294967294), uint32_t(4294967295));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(4294967294), uint32_t(4294967295));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float16_t v; } a;
shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float16_t(1.0);
  if (b.v == uint8_t[](uint8_t(0), uint8_t(60)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float16_t v; } a;
layout(std430)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float16_t(1.0);
  if (b.v == uint8_t[](uint8_t(0), uint8_t(60)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float16_t v; } a;
layout(scalar)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float16_t(1.0);
  if (b.v == uint8_t[](uint8_t(0), uint8_t(60)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float16_t v; } a;
shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(0), uint8_t(60)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float16_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float16_t v; } a;
layout(std430)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(0), uint8_t(60)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float16_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float16_t v; } a;
layout(scalar)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(0), uint8_t(60)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float16_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float16_t v; } a;
shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float16_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint8_t[](uint8_t(0), uint8_t(60)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float16_t v; } a;
layout(std430)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float16_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint8_t[](uint8_t(0), uint8_t(60)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float16_t v; } a;
layout(scalar)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float16_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint8_t[](uint8_t(0), uint8_t(60)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float16_t v; } a;
shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(0), uint8_t(60)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float16_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float16_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float16_t v; } a;
layout(std430)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(0), uint8_t(60)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float16_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float16_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float16_t v; } a;
layout(scalar)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(0), uint8_t(60)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float16_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float16_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float16_t v; } a;
shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float16_t(1.0);
  barrier();
  if (b.v == uint8_t[](uint8_t(0), uint8_t(60)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float16_t v; } a;
layout(std430)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float16_t(1.0);
  barrier();
  if (b.v == uint8_t[](uint8_t(0), uint8_t(60)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float16_t v; } a;
layout(scalar)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float16_t(1.0);
  barrier();
  if (b.v == uint8_t[](uint8_t(0), uint8_t(60)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float16_t v; } a;
shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(0), uint8_t(60)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float16_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float16_t v; } a;
layout(std430)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(0), uint8_t(60)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float16_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float16_t v; } a;
layout(scalar)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(0), uint8_t(60)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float16_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float16_t v; } a;
shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float16_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint8_t[](uint8_t(0), uint8_t(60)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float16_t v; } a;
layout(std430)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float16_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint8_t[](uint8_t(0), uint8_t(60)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float16_t v; } a;
layout(scalar)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float16_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint8_t[](uint8_t(0), uint8_t(60)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float16_t v; } a;
shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(0), uint8_t(60)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float16_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float16_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float16_t v; } a;
layout(std430)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(0), uint8_t(60)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float16_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float16_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float16_t v; } a;
layout(scalar)shared B { uint8_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(0), uint8_t(60)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float16_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float16_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[2]; } a;
shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(60));
  if (b.v == float16_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[2]; } a;
layout(std430)shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(60));
  if (b.v == float16_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[2]; } a;
layout(scalar)shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(60));
  if (b.v == float16_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[2]; } a;
shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float16_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(60));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[2]; } a;
layout(std430)shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float16_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(60));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[2]; } a;
layout(scalar)shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float16_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(60));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[2]; } a;
shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(0), uint8_t(60));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == float16_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[2]; } a;
layout(std430)shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(0), uint8_t(60));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == float16_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[2]; } a;
layout(scalar)shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(0), uint8_t(60));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == float16_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[2]; } a;
shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float16_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(0), uint8_t(60));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(60));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[2]; } a;
layout(std430)shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float16_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(0), uint8_t(60));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(60));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[2]; } a;
layout(scalar)shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float16_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(0), uint8_t(60));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(60));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[2]; } a;
shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(60));
  barrier();
  if (b.v == float16_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[2]; } a;
layout(std430)shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(60));
  barrier();
  if (b.v == float16_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[2]; } a;
layout(scalar)shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(60));
  barrier();
  if (b.v == float16_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[2]; } a;
shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float16_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(60));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[2]; } a;
layout(std430)shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float16_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(60));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[2]; } a;
layout(scalar)shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float16_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(60));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[2]; } a;
shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(0), uint8_t(60));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == float16_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[2]; } a;
layout(std430)shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(0), uint8_t(60));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == float16_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[2]; } a;
layout(scalar)shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(0), uint8_t(60));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == float16_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[2]; } a;
shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float16_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(0), uint8_t(60));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(60));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[2]; } a;
layout(std430)shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float16_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(0), uint8_t(60));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(60));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[2]; } a;
layout(scalar)shared B { float16_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float16_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(0), uint8_t(60));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(60));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float32_t v; } a;
shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float32_t v; } a;
layout(std430)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float32_t v; } a;
layout(scalar)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float32_t v; } a;
shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float32_t v; } a;
layout(std430)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float32_t v; } a;
layout(scalar)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float32_t v; } a;
shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float32_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float32_t v; } a;
layout(std430)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float32_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float32_t v; } a;
layout(scalar)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float32_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float32_t v; } a;
shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float32_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float32_t v; } a;
layout(std430)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float32_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float32_t v; } a;
layout(scalar)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float32_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float32_t v; } a;
shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  barrier();
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float32_t v; } a;
layout(std430)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  barrier();
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float32_t v; } a;
layout(scalar)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  barrier();
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float32_t v; } a;
shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float32_t v; } a;
layout(std430)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float32_t v; } a;
layout(scalar)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float32_t v; } a;
shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float32_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float32_t v; } a;
layout(std430)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float32_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float32_t v; } a;
layout(scalar)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float32_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float32_t v; } a;
shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float32_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float32_t v; } a;
layout(std430)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float32_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float32_t v; } a;
layout(scalar)shared B { uint8_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float32_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[4]; } a;
shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63));
  if (b.v == float32_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[4]; } a;
layout(std430)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63));
  if (b.v == float32_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[4]; } a;
layout(scalar)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63));
  if (b.v == float32_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[4]; } a;
shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float32_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[4]; } a;
layout(std430)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float32_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[4]; } a;
layout(scalar)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float32_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[4]; } a;
shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == float32_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[4]; } a;
layout(std430)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == float32_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[4]; } a;
layout(scalar)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == float32_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[4]; } a;
shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float32_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[4]; } a;
layout(std430)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float32_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[4]; } a;
layout(scalar)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float32_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[4]; } a;
shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63));
  barrier();
  if (b.v == float32_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[4]; } a;
layout(std430)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63));
  barrier();
  if (b.v == float32_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[4]; } a;
layout(scalar)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63));
  barrier();
  if (b.v == float32_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[4]; } a;
shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float32_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[4]; } a;
layout(std430)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float32_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[4]; } a;
layout(scalar)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float32_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[4]; } a;
shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == float32_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[4]; } a;
layout(std430)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == float32_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[4]; } a;
layout(scalar)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == float32_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[4]; } a;
shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float32_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[4]; } a;
layout(std430)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float32_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[4]; } a;
layout(scalar)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float32_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(128), uint8_t(63));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float32_t v; } a;
shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  if (b.v == uint16_t[](uint16_t(0), uint16_t(16256)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float32_t v; } a;
layout(std430)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  if (b.v == uint16_t[](uint16_t(0), uint16_t(16256)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float32_t v; } a;
layout(scalar)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  if (b.v == uint16_t[](uint16_t(0), uint16_t(16256)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float32_t v; } a;
shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(0), uint16_t(16256)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float32_t v; } a;
layout(std430)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(0), uint16_t(16256)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float32_t v; } a;
layout(scalar)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(0), uint16_t(16256)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float32_t v; } a;
shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float32_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint16_t[](uint16_t(0), uint16_t(16256)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float32_t v; } a;
layout(std430)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float32_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint16_t[](uint16_t(0), uint16_t(16256)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float32_t v; } a;
layout(scalar)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float32_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint16_t[](uint16_t(0), uint16_t(16256)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float32_t v; } a;
shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(0), uint16_t(16256)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float32_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float32_t v; } a;
layout(std430)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(0), uint16_t(16256)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float32_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float32_t v; } a;
layout(scalar)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(0), uint16_t(16256)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float32_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float32_t v; } a;
shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  barrier();
  if (b.v == uint16_t[](uint16_t(0), uint16_t(16256)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float32_t v; } a;
layout(std430)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  barrier();
  if (b.v == uint16_t[](uint16_t(0), uint16_t(16256)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float32_t v; } a;
layout(scalar)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  barrier();
  if (b.v == uint16_t[](uint16_t(0), uint16_t(16256)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float32_t v; } a;
shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(0), uint16_t(16256)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float32_t v; } a;
layout(std430)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(0), uint16_t(16256)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float32_t v; } a;
layout(scalar)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(0), uint16_t(16256)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float32_t v; } a;
shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float32_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint16_t[](uint16_t(0), uint16_t(16256)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float32_t v; } a;
layout(std430)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float32_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint16_t[](uint16_t(0), uint16_t(16256)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float32_t v; } a;
layout(scalar)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float32_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint16_t[](uint16_t(0), uint16_t(16256)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float32_t v; } a;
shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(0), uint16_t(16256)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float32_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float32_t v; } a;
layout(std430)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(0), uint16_t(16256)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float32_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float32_t v; } a;
layout(scalar)shared B { uint16_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(0), uint16_t(16256)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float32_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float32_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[2]; } a;
shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(0), uint16_t(16256));
  if (b.v == float32_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[2]; } a;
layout(std430)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(0), uint16_t(16256));
  if (b.v == float32_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[2]; } a;
layout(scalar)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(0), uint16_t(16256));
  if (b.v == float32_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[2]; } a;
shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float32_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(0), uint16_t(16256));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[2]; } a;
layout(std430)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float32_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(0), uint16_t(16256));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[2]; } a;
layout(scalar)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float32_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(0), uint16_t(16256));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[2]; } a;
shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(0), uint16_t(16256));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == float32_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[2]; } a;
layout(std430)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(0), uint16_t(16256));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == float32_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[2]; } a;
layout(scalar)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(0), uint16_t(16256));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == float32_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[2]; } a;
shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float32_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(0), uint16_t(16256));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(0), uint16_t(16256));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[2]; } a;
layout(std430)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float32_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(0), uint16_t(16256));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(0), uint16_t(16256));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[2]; } a;
layout(scalar)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float32_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(0), uint16_t(16256));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(0), uint16_t(16256));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[2]; } a;
shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(0), uint16_t(16256));
  barrier();
  if (b.v == float32_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[2]; } a;
layout(std430)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(0), uint16_t(16256));
  barrier();
  if (b.v == float32_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[2]; } a;
layout(scalar)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(0), uint16_t(16256));
  barrier();
  if (b.v == float32_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[2]; } a;
shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float32_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(0), uint16_t(16256));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[2]; } a;
layout(std430)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float32_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(0), uint16_t(16256));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[2]; } a;
layout(scalar)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float32_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(0), uint16_t(16256));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[2]; } a;
shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(0), uint16_t(16256));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == float32_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[2]; } a;
layout(std430)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(0), uint16_t(16256));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == float32_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[2]; } a;
layout(scalar)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(0), uint16_t(16256));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == float32_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[2]; } a;
shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float32_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(0), uint16_t(16256));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(0), uint16_t(16256));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[2]; } a;
layout(std430)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float32_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(0), uint16_t(16256));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(0), uint16_t(16256));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[2]; } a;
layout(scalar)shared B { float32_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float32_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(0), uint16_t(16256));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(0), uint16_t(16256));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float64_t v; } a;
shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float64_t v; } a;
layout(std430)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float64_t v; } a;
layout(scalar)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float64_t v; } a;
shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float64_t v; } a;
layout(std430)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float64_t v; } a;
layout(scalar)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float64_t v; } a;
shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float64_t v; } a;
layout(std430)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float64_t v; } a;
layout(scalar)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float64_t v; } a;
shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float64_t v; } a;
layout(std430)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float64_t v; } a;
layout(scalar)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float64_t v; } a;
shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  barrier();
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float64_t v; } a;
layout(std430)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  barrier();
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float64_t v; } a;
layout(scalar)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  barrier();
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float64_t v; } a;
shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float64_t v; } a;
layout(std430)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float64_t v; } a;
layout(scalar)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float64_t v; } a;
shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float64_t v; } a;
layout(std430)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float64_t v; } a;
layout(scalar)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float64_t v; } a;
shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float64_t v; } a;
layout(std430)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float64_t v; } a;
layout(scalar)shared B { uint8_t v[8]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[8]; } a;
shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63));
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[8]; } a;
layout(std430)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63));
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[8]; } a;
layout(scalar)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63));
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[8]; } a;
shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[8]; } a;
layout(std430)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[8]; } a;
layout(scalar)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[8]; } a;
shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[8]; } a;
layout(std430)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[8]; } a;
layout(scalar)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[8]; } a;
shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[8]; } a;
layout(std430)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[8]; } a;
layout(scalar)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[8]; } a;
shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63));
  barrier();
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[8]; } a;
layout(std430)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63));
  barrier();
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[8]; } a;
layout(scalar)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63));
  barrier();
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[8]; } a;
shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[8]; } a;
layout(std430)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[8]; } a;
layout(scalar)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[8]; } a;
shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[8]; } a;
layout(std430)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[8]; } a;
layout(scalar)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t v[8]; } a;
shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint8_t v[8]; } a;
layout(std430)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint8_t v[8]; } a;
layout(scalar)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(240), uint8_t(63));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float64_t v; } a;
shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  if (b.v == uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float64_t v; } a;
layout(std430)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  if (b.v == uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float64_t v; } a;
layout(scalar)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  if (b.v == uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float64_t v; } a;
shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float64_t v; } a;
layout(std430)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float64_t v; } a;
layout(scalar)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float64_t v; } a;
shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float64_t v; } a;
layout(std430)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float64_t v; } a;
layout(scalar)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float64_t v; } a;
shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float64_t v; } a;
layout(std430)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float64_t v; } a;
layout(scalar)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float64_t v; } a;
shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  barrier();
  if (b.v == uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float64_t v; } a;
layout(std430)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  barrier();
  if (b.v == uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float64_t v; } a;
layout(scalar)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  barrier();
  if (b.v == uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float64_t v; } a;
shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float64_t v; } a;
layout(std430)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float64_t v; } a;
layout(scalar)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float64_t v; } a;
shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float64_t v; } a;
layout(std430)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float64_t v; } a;
layout(scalar)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float64_t v; } a;
shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float64_t v; } a;
layout(std430)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float64_t v; } a;
layout(scalar)shared B { uint16_t v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[4]; } a;
shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368));
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[4]; } a;
layout(std430)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368));
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[4]; } a;
layout(scalar)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368));
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[4]; } a;
shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[4]; } a;
layout(std430)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[4]; } a;
layout(scalar)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[4]; } a;
shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[4]; } a;
layout(std430)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[4]; } a;
layout(scalar)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[4]; } a;
shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[4]; } a;
layout(std430)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[4]; } a;
layout(scalar)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[4]; } a;
shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368));
  barrier();
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[4]; } a;
layout(std430)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368));
  barrier();
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[4]; } a;
layout(scalar)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368));
  barrier();
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[4]; } a;
shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[4]; } a;
layout(std430)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[4]; } a;
layout(scalar)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[4]; } a;
shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[4]; } a;
layout(std430)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[4]; } a;
layout(scalar)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t v[4]; } a;
shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint16_t v[4]; } a;
layout(std430)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint16_t v[4]; } a;
layout(scalar)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint16_t[](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(16368));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float64_t v; } a;
shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  if (b.v == uint32_t[](uint32_t(0), uint32_t(1072693248)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float64_t v; } a;
layout(std430)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  if (b.v == uint32_t[](uint32_t(0), uint32_t(1072693248)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float64_t v; } a;
layout(scalar)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  if (b.v == uint32_t[](uint32_t(0), uint32_t(1072693248)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float64_t v; } a;
shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t[](uint32_t(0), uint32_t(1072693248)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float64_t v; } a;
layout(std430)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t[](uint32_t(0), uint32_t(1072693248)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float64_t v; } a;
layout(scalar)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t[](uint32_t(0), uint32_t(1072693248)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float64_t v; } a;
shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint32_t[](uint32_t(0), uint32_t(1072693248)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float64_t v; } a;
layout(std430)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint32_t[](uint32_t(0), uint32_t(1072693248)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float64_t v; } a;
layout(scalar)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == uint32_t[](uint32_t(0), uint32_t(1072693248)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float64_t v; } a;
shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t[](uint32_t(0), uint32_t(1072693248)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float64_t v; } a;
layout(std430)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t[](uint32_t(0), uint32_t(1072693248)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float64_t v; } a;
layout(scalar)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t[](uint32_t(0), uint32_t(1072693248)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float64_t v; } a;
shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  barrier();
  if (b.v == uint32_t[](uint32_t(0), uint32_t(1072693248)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float64_t v; } a;
layout(std430)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  barrier();
  if (b.v == uint32_t[](uint32_t(0), uint32_t(1072693248)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float64_t v; } a;
layout(scalar)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  barrier();
  if (b.v == uint32_t[](uint32_t(0), uint32_t(1072693248)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float64_t v; } a;
shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t[](uint32_t(0), uint32_t(1072693248)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float64_t v; } a;
layout(std430)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t[](uint32_t(0), uint32_t(1072693248)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float64_t v; } a;
layout(scalar)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t[](uint32_t(0), uint32_t(1072693248)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float64_t v; } a;
shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint32_t[](uint32_t(0), uint32_t(1072693248)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float64_t v; } a;
layout(std430)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint32_t[](uint32_t(0), uint32_t(1072693248)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float64_t v; } a;
layout(scalar)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == uint32_t[](uint32_t(0), uint32_t(1072693248)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { float64_t v; } a;
shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t[](uint32_t(0), uint32_t(1072693248)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { float64_t v; } a;
layout(std430)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t[](uint32_t(0), uint32_t(1072693248)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { float64_t v; } a;
layout(scalar)shared B { uint32_t v[2]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == uint32_t[](uint32_t(0), uint32_t(1072693248)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = float64_t(1.0);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = float64_t(1.0);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v[2]; } a;
shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(0), uint32_t(1072693248));
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v[2]; } a;
layout(std430)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(0), uint32_t(1072693248));
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v[2]; } a;
layout(scalar)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(0), uint32_t(1072693248));
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v[2]; } a;
shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(0), uint32_t(1072693248));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v[2]; } a;
layout(std430)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(0), uint32_t(1072693248));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v[2]; } a;
layout(scalar)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(0), uint32_t(1072693248));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v[2]; } a;
shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t[](uint32_t(0), uint32_t(1072693248));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v[2]; } a;
layout(std430)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t[](uint32_t(0), uint32_t(1072693248));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v[2]; } a;
layout(scalar)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t[](uint32_t(0), uint32_t(1072693248));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v[2]; } a;
shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t[](uint32_t(0), uint32_t(1072693248));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(0), uint32_t(1072693248));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v[2]; } a;
layout(std430)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t[](uint32_t(0), uint32_t(1072693248));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(0), uint32_t(1072693248));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v[2]; } a;
layout(scalar)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t[](uint32_t(0), uint32_t(1072693248));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(0), uint32_t(1072693248));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v[2]; } a;
shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(0), uint32_t(1072693248));
  barrier();
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v[2]; } a;
layout(std430)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(0), uint32_t(1072693248));
  barrier();
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v[2]; } a;
layout(scalar)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(0), uint32_t(1072693248));
  barrier();
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v[2]; } a;
shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(0), uint32_t(1072693248));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v[2]; } a;
layout(std430)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(0), uint32_t(1072693248));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v[2]; } a;
layout(scalar)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(0), uint32_t(1072693248));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v[2]; } a;
shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t[](uint32_t(0), uint32_t(1072693248));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v[2]; } a;
layout(std430)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t[](uint32_t(0), uint32_t(1072693248));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v[2]; } a;
layout(scalar)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint32_t[](uint32_t(0), uint32_t(1072693248));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == float64_t(1.0))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint32_t v[2]; } a;
shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t[](uint32_t(0), uint32_t(1072693248));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(0), uint32_t(1072693248));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { uint32_t v[2]; } a;
layout(std430)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t[](uint32_t(0), uint32_t(1072693248));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(0), uint32_t(1072693248));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { uint32_t v[2]; } a;
layout(scalar)shared B { float64_t v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == float64_t(1.0))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint32_t[](uint32_t(0), uint32_t(1072693248));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint32_t[](uint32_t(0), uint32_t(1072693248));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { vec4 v[3]; } a;
shared B { vec2 v[6]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 2, 2), vec4(3, 3, 4, 4), vec4(5, 5, 6, 6));
  if (b.v == vec2[](vec2(1), vec2(2), vec2(3), vec2(4), vec2(5), vec2(6)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { vec4 v[3]; } a;
layout(std430)shared B { vec2 v[6]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 2, 2), vec4(3, 3, 4, 4), vec4(5, 5, 6, 6));
  if (b.v == vec2[](vec2(1), vec2(2), vec2(3), vec2(4), vec2(5), vec2(6)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { vec4 v[3]; } a;
shared B { vec2 v[6]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == vec2[](vec2(1), vec2(2), vec2(3), vec2(4), vec2(5), vec2(6)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 2, 2), vec4(3, 3, 4, 4), vec4(5, 5, 6, 6));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { vec4 v[3]; } a;
layout(std430)shared B { vec2 v[6]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == vec2[](vec2(1), vec2(2), vec2(3), vec2(4), vec2(5), vec2(6)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 2, 2), vec4(3, 3, 4, 4), vec4(5, 5, 6, 6));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { vec4 v[3]; } a;
shared B { vec2 v[6]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = vec4[](vec4(1, 1, 2, 2), vec4(3, 3, 4, 4), vec4(5, 5, 6, 6));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == vec2[](vec2(1), vec2(2), vec2(3), vec2(4), vec2(5), vec2(6)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { vec4 v[3]; } a;
layout(std430)shared B { vec2 v[6]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = vec4[](vec4(1, 1, 2, 2), vec4(3, 3, 4, 4), vec4(5, 5, 6, 6));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == vec2[](vec2(1), vec2(2), vec2(3), vec2(4), vec2(5), vec2(6)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { vec4 v[3]; } a;
shared B { vec2 v[6]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == vec2[](vec2(1), vec2(2), vec2(3), vec2(4), vec2(5), vec2(6)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = vec4[](vec4(1, 1, 2, 2), vec4(3, 3, 4, 4), vec4(5, 5, 6, 6));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 2, 2), vec4(3, 3, 4, 4), vec4(5, 5, 6, 6));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { vec4 v[3]; } a;
layout(std430)shared B { vec2 v[6]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == vec2[](vec2(1), vec2(2), vec2(3), vec2(4), vec2(5), vec2(6)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = vec4[](vec4(1, 1, 2, 2), vec4(3, 3, 4, 4), vec4(5, 5, 6, 6));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 2, 2), vec4(3, 3, 4, 4), vec4(5, 5, 6, 6));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { vec4 v[3]; } a;
shared B { vec2 v[6]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 2, 2), vec4(3, 3, 4, 4), vec4(5, 5, 6, 6));
  barrier();
  if (b.v == vec2[](vec2(1), vec2(2), vec2(3), vec2(4), vec2(5), vec2(6)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { vec4 v[3]; } a;
layout(std430)shared B { vec2 v[6]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 2, 2), vec4(3, 3, 4, 4), vec4(5, 5, 6, 6));
  barrier();
  if (b.v == vec2[](vec2(1), vec2(2), vec2(3), vec2(4), vec2(5), vec2(6)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { vec4 v[3]; } a;
shared B { vec2 v[6]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == vec2[](vec2(1), vec2(2), vec2(3), vec2(4), vec2(5), vec2(6)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 2, 2), vec4(3, 3, 4, 4), vec4(5, 5, 6, 6));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { vec4 v[3]; } a;
layout(std430)shared B { vec2 v[6]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == vec2[](vec2(1), vec2(2), vec2(3), vec2(4), vec2(5), vec2(6)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 2, 2), vec4(3, 3, 4, 4), vec4(5, 5, 6, 6));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { vec4 v[3]; } a;
shared B { vec2 v[6]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = vec4[](vec4(1, 1, 2, 2), vec4(3, 3, 4, 4), vec4(5, 5, 6, 6));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == vec2[](vec2(1), vec2(2), vec2(3), vec2(4), vec2(5), vec2(6)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { vec4 v[3]; } a;
layout(std430)shared B { vec2 v[6]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = vec4[](vec4(1, 1, 2, 2), vec4(3, 3, 4, 4), vec4(5, 5, 6, 6));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == vec2[](vec2(1), vec2(2), vec2(3), vec2(4), vec2(5), vec2(6)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { vec4 v[3]; } a;
shared B { vec2 v[6]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == vec2[](vec2(1), vec2(2), vec2(3), vec2(4), vec2(5), vec2(6)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = vec4[](vec4(1, 1, 2, 2), vec4(3, 3, 4, 4), vec4(5, 5, 6, 6));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 2, 2), vec4(3, 3, 4, 4), vec4(5, 5, 6, 6));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { vec4 v[3]; } a;
layout(std430)shared B { vec2 v[6]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == vec2[](vec2(1), vec2(2), vec2(3), vec2(4), vec2(5), vec2(6)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = vec4[](vec4(1, 1, 2, 2), vec4(3, 3, 4, 4), vec4(5, 5, 6, 6));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 2, 2), vec4(3, 3, 4, 4), vec4(5, 5, 6, 6));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { vec4 v[3]; } a;
layout(std140)shared B { vec2 v[3]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 999, 999), vec4(2, 2, 999, 999), vec4(3, 3, 999, 999));
  if (b.v == vec2[](vec2(1), vec2(2), vec2(3)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { vec4 v[3]; } a;
layout(std140)shared B { vec2 v[3]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == vec2[](vec2(1), vec2(2), vec2(3)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 999, 999), vec4(2, 2, 999, 999), vec4(3, 3, 999, 999));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { vec4 v[3]; } a;
layout(std140)shared B { vec2 v[3]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = vec4[](vec4(1, 1, 999, 999), vec4(2, 2, 999, 999), vec4(3, 3, 999, 999));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == vec2[](vec2(1), vec2(2), vec2(3)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { vec4 v[3]; } a;
layout(std140)shared B { vec2 v[3]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == vec2[](vec2(1), vec2(2), vec2(3)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = vec4[](vec4(1, 1, 999, 999), vec4(2, 2, 999, 999), vec4(3, 3, 999, 999));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 999, 999), vec4(2, 2, 999, 999), vec4(3, 3, 999, 999));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { vec4 v[3]; } a;
layout(std140)shared B { vec2 v[3]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 999, 999), vec4(2, 2, 999, 999), vec4(3, 3, 999, 999));
  barrier();
  if (b.v == vec2[](vec2(1), vec2(2), vec2(3)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { vec4 v[3]; } a;
layout(std140)shared B { vec2 v[3]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == vec2[](vec2(1), vec2(2), vec2(3)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 999, 999), vec4(2, 2, 999, 999), vec4(3, 3, 999, 999));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { vec4 v[3]; } a;
layout(std140)shared B { vec2 v[3]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = vec4[](vec4(1, 1, 999, 999), vec4(2, 2, 999, 999), vec4(3, 3, 999, 999));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == vec2[](vec2(1), vec2(2), vec2(3)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { vec4 v[3]; } a;
layout(std140)shared B { vec2 v[3]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == vec2[](vec2(1), vec2(2), vec2(3)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = vec4[](vec4(1, 1, 999, 999), vec4(2, 2, 999, 999), vec4(3, 3, 999, 999));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 999, 999), vec4(2, 2, 999, 999), vec4(3, 3, 999, 999));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { vec4 v[3]; } a;
layout(scalar)shared B { vec2 v[6]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 2, 2), vec4(3, 3, 4, 4), vec4(5, 5, 6, 6));
  if (b.v == vec2[](vec2(1), vec2(2), vec2(3), vec2(4), vec2(5), vec2(6)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { vec4 v[3]; } a;
layout(scalar)shared B { vec2 v[6]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == vec2[](vec2(1), vec2(2), vec2(3), vec2(4), vec2(5), vec2(6)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 2, 2), vec4(3, 3, 4, 4), vec4(5, 5, 6, 6));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { vec4 v[3]; } a;
layout(scalar)shared B { vec2 v[6]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = vec4[](vec4(1, 1, 2, 2), vec4(3, 3, 4, 4), vec4(5, 5, 6, 6));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == vec2[](vec2(1), vec2(2), vec2(3), vec2(4), vec2(5), vec2(6)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { vec4 v[3]; } a;
layout(scalar)shared B { vec2 v[6]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == vec2[](vec2(1), vec2(2), vec2(3), vec2(4), vec2(5), vec2(6)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = vec4[](vec4(1, 1, 2, 2), vec4(3, 3, 4, 4), vec4(5, 5, 6, 6));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 2, 2), vec4(3, 3, 4, 4), vec4(5, 5, 6, 6));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { vec4 v[3]; } a;
layout(scalar)shared B { vec2 v[6]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 2, 2), vec4(3, 3, 4, 4), vec4(5, 5, 6, 6));
  barrier();
  if (b.v == vec2[](vec2(1), vec2(2), vec2(3), vec2(4), vec2(5), vec2(6)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { vec4 v[3]; } a;
layout(scalar)shared B { vec2 v[6]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == vec2[](vec2(1), vec2(2), vec2(3), vec2(4), vec2(5), vec2(6)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 2, 2), vec4(3, 3, 4, 4), vec4(5, 5, 6, 6));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { vec4 v[3]; } a;
layout(scalar)shared B { vec2 v[6]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = vec4[](vec4(1, 1, 2, 2), vec4(3, 3, 4, 4), vec4(5, 5, 6, 6));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == vec2[](vec2(1), vec2(2), vec2(3), vec2(4), vec2(5), vec2(6)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { vec4 v[3]; } a;
layout(scalar)shared B { vec2 v[6]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == vec2[](vec2(1), vec2(2), vec2(3), vec2(4), vec2(5), vec2(6)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = vec4[](vec4(1, 1, 2, 2), vec4(3, 3, 4, 4), vec4(5, 5, 6, 6));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 2, 2), vec4(3, 3, 4, 4), vec4(5, 5, 6, 6));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { vec4 v[3]; } a;
shared B { vec3 v[3]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 1, 999), vec4(2, 2, 2, 999), vec4(3, 3, 3, 999));
  if (b.v == vec3[](vec3(1), vec3(2), vec3(3)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { vec4 v[3]; } a;
layout(std430)shared B { vec3 v[3]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 1, 999), vec4(2, 2, 2, 999), vec4(3, 3, 3, 999));
  if (b.v == vec3[](vec3(1), vec3(2), vec3(3)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { vec4 v[3]; } a;
shared B { vec3 v[3]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == vec3[](vec3(1), vec3(2), vec3(3)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 1, 999), vec4(2, 2, 2, 999), vec4(3, 3, 3, 999));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { vec4 v[3]; } a;
layout(std430)shared B { vec3 v[3]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == vec3[](vec3(1), vec3(2), vec3(3)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 1, 999), vec4(2, 2, 2, 999), vec4(3, 3, 3, 999));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { vec4 v[3]; } a;
shared B { vec3 v[3]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = vec4[](vec4(1, 1, 1, 999), vec4(2, 2, 2, 999), vec4(3, 3, 3, 999));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == vec3[](vec3(1), vec3(2), vec3(3)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { vec4 v[3]; } a;
layout(std430)shared B { vec3 v[3]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = vec4[](vec4(1, 1, 1, 999), vec4(2, 2, 2, 999), vec4(3, 3, 3, 999));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == vec3[](vec3(1), vec3(2), vec3(3)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { vec4 v[3]; } a;
shared B { vec3 v[3]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == vec3[](vec3(1), vec3(2), vec3(3)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = vec4[](vec4(1, 1, 1, 999), vec4(2, 2, 2, 999), vec4(3, 3, 3, 999));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 1, 999), vec4(2, 2, 2, 999), vec4(3, 3, 3, 999));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { vec4 v[3]; } a;
layout(std430)shared B { vec3 v[3]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == vec3[](vec3(1), vec3(2), vec3(3)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = vec4[](vec4(1, 1, 1, 999), vec4(2, 2, 2, 999), vec4(3, 3, 3, 999));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 1, 999), vec4(2, 2, 2, 999), vec4(3, 3, 3, 999));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { vec4 v[3]; } a;
shared B { vec3 v[3]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 1, 999), vec4(2, 2, 2, 999), vec4(3, 3, 3, 999));
  barrier();
  if (b.v == vec3[](vec3(1), vec3(2), vec3(3)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { vec4 v[3]; } a;
layout(std430)shared B { vec3 v[3]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 1, 999), vec4(2, 2, 2, 999), vec4(3, 3, 3, 999));
  barrier();
  if (b.v == vec3[](vec3(1), vec3(2), vec3(3)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { vec4 v[3]; } a;
shared B { vec3 v[3]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == vec3[](vec3(1), vec3(2), vec3(3)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 1, 999), vec4(2, 2, 2, 999), vec4(3, 3, 3, 999));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { vec4 v[3]; } a;
layout(std430)shared B { vec3 v[3]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == vec3[](vec3(1), vec3(2), vec3(3)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 1, 999), vec4(2, 2, 2, 999), vec4(3, 3, 3, 999));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { vec4 v[3]; } a;
shared B { vec3 v[3]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = vec4[](vec4(1, 1, 1, 999), vec4(2, 2, 2, 999), vec4(3, 3, 3, 999));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == vec3[](vec3(1), vec3(2), vec3(3)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { vec4 v[3]; } a;
layout(std430)shared B { vec3 v[3]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = vec4[](vec4(1, 1, 1, 999), vec4(2, 2, 2, 999), vec4(3, 3, 3, 999));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == vec3[](vec3(1), vec3(2), vec3(3)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { vec4 v[3]; } a;
shared B { vec3 v[3]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == vec3[](vec3(1), vec3(2), vec3(3)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = vec4[](vec4(1, 1, 1, 999), vec4(2, 2, 2, 999), vec4(3, 3, 3, 999));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 1, 999), vec4(2, 2, 2, 999), vec4(3, 3, 3, 999));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430)shared A { vec4 v[3]; } a;
layout(std430)shared B { vec3 v[3]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == vec3[](vec3(1), vec3(2), vec3(3)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = vec4[](vec4(1, 1, 1, 999), vec4(2, 2, 2, 999), vec4(3, 3, 3, 999));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 1, 999), vec4(2, 2, 2, 999), vec4(3, 3, 3, 999));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { vec4 v[3]; } a;
layout(std140)shared B { vec3 v[3]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 1, 999), vec4(2, 2, 2, 999), vec4(3, 3, 3, 999));
  if (b.v == vec3[](vec3(1), vec3(2), vec3(3)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { vec4 v[3]; } a;
layout(std140)shared B { vec3 v[3]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == vec3[](vec3(1), vec3(2), vec3(3)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 1, 999), vec4(2, 2, 2, 999), vec4(3, 3, 3, 999));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { vec4 v[3]; } a;
layout(std140)shared B { vec3 v[3]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = vec4[](vec4(1, 1, 1, 999), vec4(2, 2, 2, 999), vec4(3, 3, 3, 999));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == vec3[](vec3(1), vec3(2), vec3(3)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { vec4 v[3]; } a;
layout(std140)shared B { vec3 v[3]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == vec3[](vec3(1), vec3(2), vec3(3)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = vec4[](vec4(1, 1, 1, 999), vec4(2, 2, 2, 999), vec4(3, 3, 3, 999));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 1, 999), vec4(2, 2, 2, 999), vec4(3, 3, 3, 999));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { vec4 v[3]; } a;
layout(std140)shared B { vec3 v[3]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 1, 999), vec4(2, 2, 2, 999), vec4(3, 3, 3, 999));
  barrier();
  if (b.v == vec3[](vec3(1), vec3(2), vec3(3)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { vec4 v[3]; } a;
layout(std140)shared B { vec3 v[3]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == vec3[](vec3(1), vec3(2), vec3(3)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 1, 999), vec4(2, 2, 2, 999), vec4(3, 3, 3, 999));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { vec4 v[3]; } a;
layout(std140)shared B { vec3 v[3]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = vec4[](vec4(1, 1, 1, 999), vec4(2, 2, 2, 999), vec4(3, 3, 3, 999));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == vec3[](vec3(1), vec3(2), vec3(3)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std140)shared A { vec4 v[3]; } a;
layout(std140)shared B { vec3 v[3]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == vec3[](vec3(1), vec3(2), vec3(3)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = vec4[](vec4(1, 1, 1, 999), vec4(2, 2, 2, 999), vec4(3, 3, 3, 999));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 1, 999), vec4(2, 2, 2, 999), vec4(3, 3, 3, 999));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { vec4 v[3]; } a;
layout(scalar)shared B { vec3 v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 1, 2), vec4(2, 2, 3, 3), vec4(3, 4, 4, 4));
  if (b.v == vec3[](vec3(1), vec3(2), vec3(3), vec3(4)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { vec4 v[3]; } a;
layout(scalar)shared B { vec3 v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == vec3[](vec3(1), vec3(2), vec3(3), vec3(4)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 1, 2), vec4(2, 2, 3, 3), vec4(3, 4, 4, 4));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { vec4 v[3]; } a;
layout(scalar)shared B { vec3 v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = vec4[](vec4(1, 1, 1, 2), vec4(2, 2, 3, 3), vec4(3, 4, 4, 4));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == vec3[](vec3(1), vec3(2), vec3(3), vec3(4)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { vec4 v[3]; } a;
layout(scalar)shared B { vec3 v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == vec3[](vec3(1), vec3(2), vec3(3), vec3(4)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = vec4[](vec4(1, 1, 1, 2), vec4(2, 2, 3, 3), vec4(3, 4, 4, 4));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 1, 2), vec4(2, 2, 3, 3), vec4(3, 4, 4, 4));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { vec4 v[3]; } a;
layout(scalar)shared B { vec3 v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 1, 2), vec4(2, 2, 3, 3), vec4(3, 4, 4, 4));
  barrier();
  if (b.v == vec3[](vec3(1), vec3(2), vec3(3), vec3(4)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { vec4 v[3]; } a;
layout(scalar)shared B { vec3 v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == vec3[](vec3(1), vec3(2), vec3(3), vec3(4)))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 1, 2), vec4(2, 2, 3, 3), vec4(3, 4, 4, 4));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { vec4 v[3]; } a;
layout(scalar)shared B { vec3 v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = vec4[](vec4(1, 1, 1, 2), vec4(2, 2, 3, 3), vec4(3, 4, 4, 4));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == vec3[](vec3(1), vec3(2), vec3(3), vec3(4)))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(scalar)shared A { vec4 v[3]; } a;
layout(scalar)shared B { vec3 v[4]; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == vec3[](vec3(1), vec3(2), vec3(3), vec3(4)))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = vec4[](vec4(1, 1, 1, 2), vec4(2, 2, 3, 3), vec4(3, 4, 4, 4));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = vec4[](vec4(1, 1, 1, 2), vec4(2, 2, 3, 3), vec4(3, 4, 4, 4));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
shared A { uint8_t v[8]; } a;
shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(2), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
  if (b.v == s(2, -2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
layout(std430)shared A { uint8_t v[8]; } a;
layout(std430)shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(2), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
  if (b.v == s(2, -2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
layout(scalar)shared A { uint8_t v[8]; } a;
layout(scalar)shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(2), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
  if (b.v == s(2, -2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
shared A { uint8_t v[8]; } a;
shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == s(2, -2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(2), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
layout(std430)shared A { uint8_t v[8]; } a;
layout(std430)shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == s(2, -2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(2), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
layout(scalar)shared A { uint8_t v[8]; } a;
layout(scalar)shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == s(2, -2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(2), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
shared A { uint8_t v[8]; } a;
shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(2), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == s(2, -2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
layout(std430)shared A { uint8_t v[8]; } a;
layout(std430)shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(2), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == s(2, -2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
layout(scalar)shared A { uint8_t v[8]; } a;
layout(scalar)shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(2), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == s(2, -2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
shared A { uint8_t v[8]; } a;
shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == s(2, -2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(2), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(2), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
layout(std430)shared A { uint8_t v[8]; } a;
layout(std430)shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == s(2, -2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(2), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(2), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
layout(scalar)shared A { uint8_t v[8]; } a;
layout(scalar)shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == s(2, -2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(2), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(2), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
shared A { uint8_t v[8]; } a;
shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(2), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
  barrier();
  if (b.v == s(2, -2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
layout(std430)shared A { uint8_t v[8]; } a;
layout(std430)shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(2), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
  barrier();
  if (b.v == s(2, -2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
layout(scalar)shared A { uint8_t v[8]; } a;
layout(scalar)shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(2), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
  barrier();
  if (b.v == s(2, -2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
shared A { uint8_t v[8]; } a;
shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == s(2, -2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(2), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
layout(std430)shared A { uint8_t v[8]; } a;
layout(std430)shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == s(2, -2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(2), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
layout(scalar)shared A { uint8_t v[8]; } a;
layout(scalar)shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == s(2, -2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(2), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
shared A { uint8_t v[8]; } a;
shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(2), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == s(2, -2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
layout(std430)shared A { uint8_t v[8]; } a;
layout(std430)shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(2), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == s(2, -2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
layout(scalar)shared A { uint8_t v[8]; } a;
layout(scalar)shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(2), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == s(2, -2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
shared A { uint8_t v[8]; } a;
shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == s(2, -2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(2), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(2), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
layout(std430)shared A { uint8_t v[8]; } a;
layout(std430)shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == s(2, -2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(2), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(2), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
layout(scalar)shared A { uint8_t v[8]; } a;
layout(scalar)shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == s(2, -2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uint8_t[](uint8_t(2), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uint8_t[](uint8_t(2), uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(254), uint8_t(255), uint8_t(255), uint8_t(255));
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
shared A { uvec2 v; } a;
shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uvec2(2, 0xFFFFFFFE);
  if (b.v == s(2, -2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
layout(std140)shared A { uvec2 v; } a;
layout(std140)shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uvec2(2, 0xFFFFFFFE);
  if (b.v == s(2, -2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
layout(std430)shared A { uvec2 v; } a;
layout(std430)shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uvec2(2, 0xFFFFFFFE);
  if (b.v == s(2, -2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
layout(scalar)shared A { uvec2 v; } a;
layout(scalar)shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uvec2(2, 0xFFFFFFFE);
  if (b.v == s(2, -2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
shared A { uvec2 v; } a;
shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == s(2, -2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uvec2(2, 0xFFFFFFFE);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
layout(std140)shared A { uvec2 v; } a;
layout(std140)shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == s(2, -2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uvec2(2, 0xFFFFFFFE);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
layout(std430)shared A { uvec2 v; } a;
layout(std430)shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == s(2, -2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uvec2(2, 0xFFFFFFFE);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
layout(scalar)shared A { uvec2 v; } a;
layout(scalar)shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == s(2, -2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uvec2(2, 0xFFFFFFFE);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
shared A { uvec2 v; } a;
shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uvec2(2, 0xFFFFFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == s(2, -2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
layout(std140)shared A { uvec2 v; } a;
layout(std140)shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uvec2(2, 0xFFFFFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == s(2, -2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
layout(std430)shared A { uvec2 v; } a;
layout(std430)shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uvec2(2, 0xFFFFFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == s(2, -2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
layout(scalar)shared A { uvec2 v; } a;
layout(scalar)shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uvec2(2, 0xFFFFFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  if (b.v == s(2, -2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
shared A { uvec2 v; } a;
shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == s(2, -2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uvec2(2, 0xFFFFFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uvec2(2, 0xFFFFFFFE);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
layout(std140)shared A { uvec2 v; } a;
layout(std140)shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == s(2, -2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uvec2(2, 0xFFFFFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uvec2(2, 0xFFFFFFFE);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
layout(std430)shared A { uvec2 v; } a;
layout(std430)shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == s(2, -2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uvec2(2, 0xFFFFFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uvec2(2, 0xFFFFFFFE);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
layout(scalar)shared A { uvec2 v; } a;
layout(scalar)shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == s(2, -2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uvec2(2, 0xFFFFFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uvec2(2, 0xFFFFFFFE);
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
shared A { uvec2 v; } a;
shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uvec2(2, 0xFFFFFFFE);
  barrier();
  if (b.v == s(2, -2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
layout(std140)shared A { uvec2 v; } a;
layout(std140)shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uvec2(2, 0xFFFFFFFE);
  barrier();
  if (b.v == s(2, -2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
layout(std430)shared A { uvec2 v; } a;
layout(std430)shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uvec2(2, 0xFFFFFFFE);
  barrier();
  if (b.v == s(2, -2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
layout(scalar)shared A { uvec2 v; } a;
layout(scalar)shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uvec2(2, 0xFFFFFFFE);
  barrier();
  if (b.v == s(2, -2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
shared A { uvec2 v; } a;
shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == s(2, -2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uvec2(2, 0xFFFFFFFE);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
layout(std140)shared A { uvec2 v; } a;
layout(std140)shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == s(2, -2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uvec2(2, 0xFFFFFFFE);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
layout(std430)shared A { uvec2 v; } a;
layout(std430)shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == s(2, -2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uvec2(2, 0xFFFFFFFE);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
layout(scalar)shared A { uvec2 v; } a;
layout(scalar)shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == s(2, -2))
    result = index;
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uvec2(2, 0xFFFFFFFE);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
shared A { uvec2 v; } a;
shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uvec2(2, 0xFFFFFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == s(2, -2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
layout(std140)shared A { uvec2 v; } a;
layout(std140)shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uvec2(2, 0xFFFFFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == s(2, -2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
layout(std430)shared A { uvec2 v; } a;
layout(std430)shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uvec2(2, 0xFFFFFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == s(2, -2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
layout(scalar)shared A { uvec2 v; } a;
layout(scalar)shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void write(int index) {
  if (index == 0)
    a.v = uvec2(2, 0xFFFFFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  write(index);
  barrier();
  if (b.v == s(2, -2))
    result = index;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
shared A { uvec2 v; } a;
shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == s(2, -2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uvec2(2, 0xFFFFFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uvec2(2, 0xFFFFFFFE);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
layout(std140)shared A { uvec2 v; } a;
layout(std140)shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == s(2, -2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uvec2(2, 0xFFFFFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uvec2(2, 0xFFFFFFFE);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
layout(std430)shared A { uvec2 v; } a;
layout(std430)shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == s(2, -2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uvec2(2, 0xFFFFFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uvec2(2, 0xFFFFFFFE);
  barrier();
  read(index);
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
struct s { int a; int b; };
layout(scalar)shared A { uvec2 v; } a;
layout(scalar)shared B { s v; } b;
layout(set = 0, binding = 0) buffer Result { uint result; };
void read(int index) {
  if (b.v == s(2, -2))
    result = index;
}
void write(int index) {
  if (index == 0)
    a.v = uvec2(2, 0xFFFFFFFE);
}
void main() {
  int index = int(gl_LocalInvocationIndex);
  a.v = uvec2(2, 0xFFFFFFFE);
  barrier();
  read(index);
}
