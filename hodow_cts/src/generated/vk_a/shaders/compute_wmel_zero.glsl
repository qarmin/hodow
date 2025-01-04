#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    float x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == float(0))
    && (arr[1].x == float(0))
    && (arr[2].x == float(0))
    && (arr[3].x == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    vec4 x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    double x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == double(0))
    && (arr[1].x == double(0))
    && (arr[2].x == double(0))
    && (arr[3].x == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    dvec4 x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uint x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[1].x == uint(0))
    && (arr[2].x == uint(0))
    && (arr[3].x == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uvec3 x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    bool x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[1].x == bool(0))
    && (arr[2].x == bool(0))
    && (arr[3].x == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uint8_t x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[1].x == uint8_t(0))
    && (arr[2].x == uint8_t(0))
    && (arr[3].x == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uint16_t x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[1].x == uint16_t(0))
    && (arr[2].x == uint16_t(0))
    && (arr[3].x == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    float16_t x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[1].x == float16_t(0))
    && (arr[2].x == float16_t(0))
    && (arr[3].x == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    float x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == float(0))
    && (arr[1].x == float(0))
    && (arr[1].y == float(0))
    && (arr[2].x == float(0))
    && (arr[2].y == float(0))
    && (arr[3].x == float(0))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    vec4 x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == float(0))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == float(0))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == float(0))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    double x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == float(0))
    && (arr[1].x == double(0))
    && (arr[1].y == float(0))
    && (arr[2].x == double(0))
    && (arr[2].y == float(0))
    && (arr[3].x == double(0))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    dvec4 x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == float(0))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == float(0))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == float(0))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uint x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == float(0))
    && (arr[1].x == uint(0))
    && (arr[1].y == float(0))
    && (arr[2].x == uint(0))
    && (arr[2].y == float(0))
    && (arr[3].x == uint(0))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uvec3 x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == float(0))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == float(0))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == float(0))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    bool x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == float(0))
    && (arr[1].x == bool(0))
    && (arr[1].y == float(0))
    && (arr[2].x == bool(0))
    && (arr[2].y == float(0))
    && (arr[3].x == bool(0))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uint8_t x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == float(0))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == float(0))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == float(0))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uint16_t x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == float(0))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == float(0))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == float(0))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    float16_t x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == float(0))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == float(0))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == float(0))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    float x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == float(0))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == float(0))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == float(0))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    vec4 x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    double x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == double(0))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == double(0))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == double(0))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    dvec4 x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uint x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == uint(0))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == uint(0))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == uint(0))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uvec3 x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    bool x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == bool(0))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == bool(0))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == bool(0))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uint8_t x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uint16_t x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    float16_t x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    float x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == double(0))
    && (arr[1].x == float(0))
    && (arr[1].y == double(0))
    && (arr[2].x == float(0))
    && (arr[2].y == double(0))
    && (arr[3].x == float(0))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    vec4 x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == double(0))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == double(0))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == double(0))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    double x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == double(0))
    && (arr[1].x == double(0))
    && (arr[1].y == double(0))
    && (arr[2].x == double(0))
    && (arr[2].y == double(0))
    && (arr[3].x == double(0))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    dvec4 x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == double(0))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == double(0))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == double(0))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uint x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == double(0))
    && (arr[1].x == uint(0))
    && (arr[1].y == double(0))
    && (arr[2].x == uint(0))
    && (arr[2].y == double(0))
    && (arr[3].x == uint(0))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uvec3 x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == double(0))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == double(0))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == double(0))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    bool x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == double(0))
    && (arr[1].x == bool(0))
    && (arr[1].y == double(0))
    && (arr[2].x == bool(0))
    && (arr[2].y == double(0))
    && (arr[3].x == bool(0))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uint8_t x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == double(0))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == double(0))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == double(0))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uint16_t x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == double(0))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == double(0))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == double(0))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    float16_t x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == double(0))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == double(0))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == double(0))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    float x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == float(0))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == float(0))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == float(0))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    vec4 x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    double x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == double(0))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == double(0))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == double(0))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    dvec4 x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uint x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == uint(0))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == uint(0))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == uint(0))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uvec3 x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    bool x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == bool(0))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == bool(0))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == bool(0))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uint8_t x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uint16_t x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    float16_t x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    float x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == uint(0))
    && (arr[1].x == float(0))
    && (arr[1].y == uint(0))
    && (arr[2].x == float(0))
    && (arr[2].y == uint(0))
    && (arr[3].x == float(0))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    vec4 x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == uint(0))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == uint(0))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == uint(0))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    double x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == uint(0))
    && (arr[1].x == double(0))
    && (arr[1].y == uint(0))
    && (arr[2].x == double(0))
    && (arr[2].y == uint(0))
    && (arr[3].x == double(0))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    dvec4 x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == uint(0))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == uint(0))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == uint(0))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uint x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == uint(0))
    && (arr[1].x == uint(0))
    && (arr[1].y == uint(0))
    && (arr[2].x == uint(0))
    && (arr[2].y == uint(0))
    && (arr[3].x == uint(0))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uvec3 x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == uint(0))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == uint(0))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == uint(0))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    bool x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == uint(0))
    && (arr[1].x == bool(0))
    && (arr[1].y == uint(0))
    && (arr[2].x == bool(0))
    && (arr[2].y == uint(0))
    && (arr[3].x == bool(0))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uint8_t x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == uint(0))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == uint(0))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == uint(0))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uint16_t x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == uint(0))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == uint(0))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == uint(0))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    float16_t x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == uint(0))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == uint(0))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == uint(0))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    float x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == float(0))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == float(0))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == float(0))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    vec4 x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    double x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == double(0))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == double(0))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == double(0))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    dvec4 x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uint x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == uint(0))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == uint(0))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == uint(0))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uvec3 x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    bool x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == bool(0))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == bool(0))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == bool(0))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uint8_t x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uint16_t x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    float16_t x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    float x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == bool(0))
    && (arr[1].x == float(0))
    && (arr[1].y == bool(0))
    && (arr[2].x == float(0))
    && (arr[2].y == bool(0))
    && (arr[3].x == float(0))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    vec4 x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == bool(0))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == bool(0))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == bool(0))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    double x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == bool(0))
    && (arr[1].x == double(0))
    && (arr[1].y == bool(0))
    && (arr[2].x == double(0))
    && (arr[2].y == bool(0))
    && (arr[3].x == double(0))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    dvec4 x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == bool(0))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == bool(0))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == bool(0))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uint x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == bool(0))
    && (arr[1].x == uint(0))
    && (arr[1].y == bool(0))
    && (arr[2].x == uint(0))
    && (arr[2].y == bool(0))
    && (arr[3].x == uint(0))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uvec3 x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == bool(0))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == bool(0))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == bool(0))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    bool x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == bool(0))
    && (arr[1].x == bool(0))
    && (arr[1].y == bool(0))
    && (arr[2].x == bool(0))
    && (arr[2].y == bool(0))
    && (arr[3].x == bool(0))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uint8_t x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == bool(0))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == bool(0))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == bool(0))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uint16_t x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == bool(0))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == bool(0))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == bool(0))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    float16_t x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == bool(0))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == bool(0))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == bool(0))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    float x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == float(0))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == float(0))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == float(0))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    vec4 x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    double x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == double(0))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == double(0))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == double(0))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    dvec4 x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uint x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == uint(0))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == uint(0))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == uint(0))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uvec3 x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    bool x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == bool(0))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == bool(0))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == bool(0))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uint8_t x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uint16_t x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    float16_t x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    float x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == float(0))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == float(0))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == float(0))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    vec4 x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    double x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == double(0))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == double(0))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == double(0))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    dvec4 x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uint x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == uint(0))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == uint(0))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == uint(0))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uvec3 x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    bool x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == bool(0))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == bool(0))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == bool(0))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uint8_t x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uint16_t x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    float16_t x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    float x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == float(0))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == float(0))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == float(0))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    vec4 x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    double x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == double(0))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == double(0))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == double(0))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    dvec4 x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uint x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == uint(0))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == uint(0))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == uint(0))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uvec3 x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    bool x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == bool(0))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == bool(0))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == bool(0))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uint8_t x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    uint16_t x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint arr[256]; } zero;
struct st {
    float16_t x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint(0);
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    float x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == float(0))
    && (arr[1].x == float(0))
    && (arr[2].x == float(0))
    && (arr[3].x == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    vec4 x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    double x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == double(0))
    && (arr[1].x == double(0))
    && (arr[2].x == double(0))
    && (arr[3].x == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    dvec4 x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uint x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[1].x == uint(0))
    && (arr[2].x == uint(0))
    && (arr[3].x == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uvec3 x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    bool x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[1].x == bool(0))
    && (arr[2].x == bool(0))
    && (arr[3].x == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uint8_t x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[1].x == uint8_t(0))
    && (arr[2].x == uint8_t(0))
    && (arr[3].x == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uint16_t x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[1].x == uint16_t(0))
    && (arr[2].x == uint16_t(0))
    && (arr[3].x == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    float16_t x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[1].x == float16_t(0))
    && (arr[2].x == float16_t(0))
    && (arr[3].x == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    float x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == float(0))
    && (arr[1].x == float(0))
    && (arr[1].y == float(0))
    && (arr[2].x == float(0))
    && (arr[2].y == float(0))
    && (arr[3].x == float(0))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    vec4 x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == float(0))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == float(0))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == float(0))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    double x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == float(0))
    && (arr[1].x == double(0))
    && (arr[1].y == float(0))
    && (arr[2].x == double(0))
    && (arr[2].y == float(0))
    && (arr[3].x == double(0))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    dvec4 x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == float(0))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == float(0))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == float(0))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uint x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == float(0))
    && (arr[1].x == uint(0))
    && (arr[1].y == float(0))
    && (arr[2].x == uint(0))
    && (arr[2].y == float(0))
    && (arr[3].x == uint(0))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uvec3 x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == float(0))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == float(0))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == float(0))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    bool x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == float(0))
    && (arr[1].x == bool(0))
    && (arr[1].y == float(0))
    && (arr[2].x == bool(0))
    && (arr[2].y == float(0))
    && (arr[3].x == bool(0))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uint8_t x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == float(0))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == float(0))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == float(0))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uint16_t x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == float(0))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == float(0))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == float(0))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    float16_t x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == float(0))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == float(0))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == float(0))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    float x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == float(0))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == float(0))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == float(0))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    vec4 x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    double x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == double(0))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == double(0))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == double(0))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    dvec4 x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uint x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == uint(0))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == uint(0))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == uint(0))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uvec3 x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    bool x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == bool(0))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == bool(0))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == bool(0))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uint8_t x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uint16_t x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    float16_t x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    float x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == double(0))
    && (arr[1].x == float(0))
    && (arr[1].y == double(0))
    && (arr[2].x == float(0))
    && (arr[2].y == double(0))
    && (arr[3].x == float(0))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    vec4 x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == double(0))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == double(0))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == double(0))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    double x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == double(0))
    && (arr[1].x == double(0))
    && (arr[1].y == double(0))
    && (arr[2].x == double(0))
    && (arr[2].y == double(0))
    && (arr[3].x == double(0))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    dvec4 x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == double(0))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == double(0))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == double(0))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uint x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == double(0))
    && (arr[1].x == uint(0))
    && (arr[1].y == double(0))
    && (arr[2].x == uint(0))
    && (arr[2].y == double(0))
    && (arr[3].x == uint(0))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uvec3 x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == double(0))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == double(0))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == double(0))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    bool x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == double(0))
    && (arr[1].x == bool(0))
    && (arr[1].y == double(0))
    && (arr[2].x == bool(0))
    && (arr[2].y == double(0))
    && (arr[3].x == bool(0))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uint8_t x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == double(0))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == double(0))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == double(0))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uint16_t x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == double(0))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == double(0))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == double(0))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    float16_t x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == double(0))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == double(0))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == double(0))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    float x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == float(0))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == float(0))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == float(0))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    vec4 x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    double x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == double(0))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == double(0))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == double(0))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    dvec4 x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uint x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == uint(0))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == uint(0))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == uint(0))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uvec3 x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    bool x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == bool(0))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == bool(0))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == bool(0))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uint8_t x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uint16_t x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    float16_t x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    float x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == uint(0))
    && (arr[1].x == float(0))
    && (arr[1].y == uint(0))
    && (arr[2].x == float(0))
    && (arr[2].y == uint(0))
    && (arr[3].x == float(0))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    vec4 x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == uint(0))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == uint(0))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == uint(0))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    double x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == uint(0))
    && (arr[1].x == double(0))
    && (arr[1].y == uint(0))
    && (arr[2].x == double(0))
    && (arr[2].y == uint(0))
    && (arr[3].x == double(0))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    dvec4 x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == uint(0))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == uint(0))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == uint(0))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uint x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == uint(0))
    && (arr[1].x == uint(0))
    && (arr[1].y == uint(0))
    && (arr[2].x == uint(0))
    && (arr[2].y == uint(0))
    && (arr[3].x == uint(0))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uvec3 x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == uint(0))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == uint(0))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == uint(0))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    bool x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == uint(0))
    && (arr[1].x == bool(0))
    && (arr[1].y == uint(0))
    && (arr[2].x == bool(0))
    && (arr[2].y == uint(0))
    && (arr[3].x == bool(0))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uint8_t x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == uint(0))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == uint(0))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == uint(0))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uint16_t x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == uint(0))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == uint(0))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == uint(0))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    float16_t x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == uint(0))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == uint(0))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == uint(0))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    float x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == float(0))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == float(0))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == float(0))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    vec4 x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    double x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == double(0))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == double(0))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == double(0))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    dvec4 x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uint x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == uint(0))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == uint(0))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == uint(0))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uvec3 x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    bool x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == bool(0))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == bool(0))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == bool(0))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uint8_t x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uint16_t x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    float16_t x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    float x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == bool(0))
    && (arr[1].x == float(0))
    && (arr[1].y == bool(0))
    && (arr[2].x == float(0))
    && (arr[2].y == bool(0))
    && (arr[3].x == float(0))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    vec4 x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == bool(0))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == bool(0))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == bool(0))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    double x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == bool(0))
    && (arr[1].x == double(0))
    && (arr[1].y == bool(0))
    && (arr[2].x == double(0))
    && (arr[2].y == bool(0))
    && (arr[3].x == double(0))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    dvec4 x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == bool(0))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == bool(0))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == bool(0))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uint x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == bool(0))
    && (arr[1].x == uint(0))
    && (arr[1].y == bool(0))
    && (arr[2].x == uint(0))
    && (arr[2].y == bool(0))
    && (arr[3].x == uint(0))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uvec3 x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == bool(0))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == bool(0))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == bool(0))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    bool x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == bool(0))
    && (arr[1].x == bool(0))
    && (arr[1].y == bool(0))
    && (arr[2].x == bool(0))
    && (arr[2].y == bool(0))
    && (arr[3].x == bool(0))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uint8_t x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == bool(0))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == bool(0))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == bool(0))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uint16_t x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == bool(0))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == bool(0))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == bool(0))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    float16_t x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == bool(0))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == bool(0))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == bool(0))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    float x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == float(0))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == float(0))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == float(0))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    vec4 x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    double x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == double(0))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == double(0))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == double(0))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    dvec4 x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uint x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == uint(0))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == uint(0))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == uint(0))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uvec3 x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    bool x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == bool(0))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == bool(0))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == bool(0))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uint8_t x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uint16_t x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    float16_t x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    float x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == float(0))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == float(0))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == float(0))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    vec4 x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    double x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == double(0))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == double(0))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == double(0))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    dvec4 x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uint x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == uint(0))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == uint(0))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == uint(0))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uvec3 x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    bool x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == bool(0))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == bool(0))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == bool(0))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uint8_t x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uint16_t x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    float16_t x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    float x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == float(0))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == float(0))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == float(0))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    vec4 x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    double x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == double(0))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == double(0))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == double(0))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    dvec4 x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uint x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == uint(0))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == uint(0))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == uint(0))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uvec3 x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    bool x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == bool(0))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == bool(0))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == bool(0))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uint8_t x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    uint16_t x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uvec4 arr[256]; } zero;
struct st {
    float16_t x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(1), uint(1), uint(1), uint(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uvec4(uint(0), uint(0), uint(0), uint(0));
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    float x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == float(0))
    && (arr[1].x == float(0))
    && (arr[2].x == float(0))
    && (arr[3].x == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    vec4 x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    double x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == double(0))
    && (arr[1].x == double(0))
    && (arr[2].x == double(0))
    && (arr[3].x == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    dvec4 x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uint x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[1].x == uint(0))
    && (arr[2].x == uint(0))
    && (arr[3].x == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uvec3 x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    bool x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[1].x == bool(0))
    && (arr[2].x == bool(0))
    && (arr[3].x == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uint8_t x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[1].x == uint8_t(0))
    && (arr[2].x == uint8_t(0))
    && (arr[3].x == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uint16_t x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[1].x == uint16_t(0))
    && (arr[2].x == uint16_t(0))
    && (arr[3].x == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    float16_t x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[1].x == float16_t(0))
    && (arr[2].x == float16_t(0))
    && (arr[3].x == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    float x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == float(0))
    && (arr[1].x == float(0))
    && (arr[1].y == float(0))
    && (arr[2].x == float(0))
    && (arr[2].y == float(0))
    && (arr[3].x == float(0))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    vec4 x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == float(0))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == float(0))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == float(0))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    double x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == float(0))
    && (arr[1].x == double(0))
    && (arr[1].y == float(0))
    && (arr[2].x == double(0))
    && (arr[2].y == float(0))
    && (arr[3].x == double(0))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    dvec4 x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == float(0))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == float(0))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == float(0))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uint x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == float(0))
    && (arr[1].x == uint(0))
    && (arr[1].y == float(0))
    && (arr[2].x == uint(0))
    && (arr[2].y == float(0))
    && (arr[3].x == uint(0))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uvec3 x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == float(0))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == float(0))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == float(0))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    bool x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == float(0))
    && (arr[1].x == bool(0))
    && (arr[1].y == float(0))
    && (arr[2].x == bool(0))
    && (arr[2].y == float(0))
    && (arr[3].x == bool(0))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uint8_t x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == float(0))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == float(0))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == float(0))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uint16_t x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == float(0))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == float(0))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == float(0))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    float16_t x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == float(0))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == float(0))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == float(0))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    float x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == float(0))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == float(0))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == float(0))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    vec4 x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    double x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == double(0))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == double(0))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == double(0))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    dvec4 x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uint x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == uint(0))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == uint(0))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == uint(0))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uvec3 x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    bool x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == bool(0))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == bool(0))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == bool(0))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uint8_t x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uint16_t x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    float16_t x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    float x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == double(0))
    && (arr[1].x == float(0))
    && (arr[1].y == double(0))
    && (arr[2].x == float(0))
    && (arr[2].y == double(0))
    && (arr[3].x == float(0))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    vec4 x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == double(0))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == double(0))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == double(0))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    double x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == double(0))
    && (arr[1].x == double(0))
    && (arr[1].y == double(0))
    && (arr[2].x == double(0))
    && (arr[2].y == double(0))
    && (arr[3].x == double(0))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    dvec4 x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == double(0))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == double(0))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == double(0))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uint x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == double(0))
    && (arr[1].x == uint(0))
    && (arr[1].y == double(0))
    && (arr[2].x == uint(0))
    && (arr[2].y == double(0))
    && (arr[3].x == uint(0))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uvec3 x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == double(0))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == double(0))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == double(0))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    bool x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == double(0))
    && (arr[1].x == bool(0))
    && (arr[1].y == double(0))
    && (arr[2].x == bool(0))
    && (arr[2].y == double(0))
    && (arr[3].x == bool(0))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uint8_t x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == double(0))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == double(0))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == double(0))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uint16_t x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == double(0))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == double(0))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == double(0))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    float16_t x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == double(0))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == double(0))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == double(0))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    float x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == float(0))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == float(0))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == float(0))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    vec4 x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    double x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == double(0))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == double(0))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == double(0))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    dvec4 x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uint x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == uint(0))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == uint(0))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == uint(0))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uvec3 x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    bool x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == bool(0))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == bool(0))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == bool(0))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uint8_t x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uint16_t x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    float16_t x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    float x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == uint(0))
    && (arr[1].x == float(0))
    && (arr[1].y == uint(0))
    && (arr[2].x == float(0))
    && (arr[2].y == uint(0))
    && (arr[3].x == float(0))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    vec4 x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == uint(0))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == uint(0))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == uint(0))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    double x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == uint(0))
    && (arr[1].x == double(0))
    && (arr[1].y == uint(0))
    && (arr[2].x == double(0))
    && (arr[2].y == uint(0))
    && (arr[3].x == double(0))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    dvec4 x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == uint(0))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == uint(0))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == uint(0))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uint x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == uint(0))
    && (arr[1].x == uint(0))
    && (arr[1].y == uint(0))
    && (arr[2].x == uint(0))
    && (arr[2].y == uint(0))
    && (arr[3].x == uint(0))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uvec3 x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == uint(0))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == uint(0))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == uint(0))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    bool x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == uint(0))
    && (arr[1].x == bool(0))
    && (arr[1].y == uint(0))
    && (arr[2].x == bool(0))
    && (arr[2].y == uint(0))
    && (arr[3].x == bool(0))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uint8_t x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == uint(0))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == uint(0))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == uint(0))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uint16_t x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == uint(0))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == uint(0))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == uint(0))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    float16_t x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == uint(0))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == uint(0))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == uint(0))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    float x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == float(0))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == float(0))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == float(0))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    vec4 x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    double x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == double(0))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == double(0))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == double(0))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    dvec4 x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uint x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == uint(0))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == uint(0))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == uint(0))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uvec3 x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    bool x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == bool(0))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == bool(0))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == bool(0))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uint8_t x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uint16_t x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    float16_t x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    float x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == bool(0))
    && (arr[1].x == float(0))
    && (arr[1].y == bool(0))
    && (arr[2].x == float(0))
    && (arr[2].y == bool(0))
    && (arr[3].x == float(0))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    vec4 x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == bool(0))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == bool(0))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == bool(0))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    double x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == bool(0))
    && (arr[1].x == double(0))
    && (arr[1].y == bool(0))
    && (arr[2].x == double(0))
    && (arr[2].y == bool(0))
    && (arr[3].x == double(0))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    dvec4 x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == bool(0))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == bool(0))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == bool(0))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uint x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == bool(0))
    && (arr[1].x == uint(0))
    && (arr[1].y == bool(0))
    && (arr[2].x == uint(0))
    && (arr[2].y == bool(0))
    && (arr[3].x == uint(0))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uvec3 x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == bool(0))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == bool(0))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == bool(0))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    bool x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == bool(0))
    && (arr[1].x == bool(0))
    && (arr[1].y == bool(0))
    && (arr[2].x == bool(0))
    && (arr[2].y == bool(0))
    && (arr[3].x == bool(0))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uint8_t x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == bool(0))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == bool(0))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == bool(0))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uint16_t x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == bool(0))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == bool(0))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == bool(0))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    float16_t x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == bool(0))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == bool(0))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == bool(0))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    float x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == float(0))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == float(0))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == float(0))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    vec4 x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    double x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == double(0))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == double(0))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == double(0))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    dvec4 x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uint x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == uint(0))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == uint(0))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == uint(0))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uvec3 x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    bool x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == bool(0))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == bool(0))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == bool(0))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uint8_t x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uint16_t x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    float16_t x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    float x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == float(0))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == float(0))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == float(0))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    vec4 x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    double x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == double(0))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == double(0))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == double(0))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    dvec4 x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uint x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == uint(0))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == uint(0))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == uint(0))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uvec3 x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    bool x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == bool(0))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == bool(0))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == bool(0))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uint8_t x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uint16_t x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    float16_t x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    float x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == float(0))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == float(0))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == float(0))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    vec4 x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    double x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == double(0))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == double(0))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == double(0))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    dvec4 x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uint x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == uint(0))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == uint(0))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == uint(0))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uvec3 x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    bool x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == bool(0))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == bool(0))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == bool(0))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uint8_t x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    uint16_t x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint8_t arr[256]; } zero;
struct st {
    float16_t x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint8_t(0);
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    float x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == float(0))
    && (arr[1].x == float(0))
    && (arr[2].x == float(0))
    && (arr[3].x == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    vec4 x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    double x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == double(0))
    && (arr[1].x == double(0))
    && (arr[2].x == double(0))
    && (arr[3].x == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    dvec4 x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uint x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[1].x == uint(0))
    && (arr[2].x == uint(0))
    && (arr[3].x == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uvec3 x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    bool x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[1].x == bool(0))
    && (arr[2].x == bool(0))
    && (arr[3].x == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uint8_t x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[1].x == uint8_t(0))
    && (arr[2].x == uint8_t(0))
    && (arr[3].x == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uint16_t x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[1].x == uint16_t(0))
    && (arr[2].x == uint16_t(0))
    && (arr[3].x == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    float16_t x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[1].x == float16_t(0))
    && (arr[2].x == float16_t(0))
    && (arr[3].x == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    float x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == float(0))
    && (arr[1].x == float(0))
    && (arr[1].y == float(0))
    && (arr[2].x == float(0))
    && (arr[2].y == float(0))
    && (arr[3].x == float(0))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    vec4 x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == float(0))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == float(0))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == float(0))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    double x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == float(0))
    && (arr[1].x == double(0))
    && (arr[1].y == float(0))
    && (arr[2].x == double(0))
    && (arr[2].y == float(0))
    && (arr[3].x == double(0))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    dvec4 x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == float(0))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == float(0))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == float(0))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uint x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == float(0))
    && (arr[1].x == uint(0))
    && (arr[1].y == float(0))
    && (arr[2].x == uint(0))
    && (arr[2].y == float(0))
    && (arr[3].x == uint(0))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uvec3 x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == float(0))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == float(0))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == float(0))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    bool x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == float(0))
    && (arr[1].x == bool(0))
    && (arr[1].y == float(0))
    && (arr[2].x == bool(0))
    && (arr[2].y == float(0))
    && (arr[3].x == bool(0))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uint8_t x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == float(0))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == float(0))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == float(0))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uint16_t x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == float(0))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == float(0))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == float(0))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    float16_t x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == float(0))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == float(0))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == float(0))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    float x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == float(0))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == float(0))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == float(0))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    vec4 x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    double x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == double(0))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == double(0))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == double(0))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    dvec4 x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uint x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == uint(0))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == uint(0))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == uint(0))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uvec3 x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    bool x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == bool(0))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == bool(0))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == bool(0))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uint8_t x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uint16_t x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    float16_t x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    float x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == double(0))
    && (arr[1].x == float(0))
    && (arr[1].y == double(0))
    && (arr[2].x == float(0))
    && (arr[2].y == double(0))
    && (arr[3].x == float(0))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    vec4 x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == double(0))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == double(0))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == double(0))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    double x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == double(0))
    && (arr[1].x == double(0))
    && (arr[1].y == double(0))
    && (arr[2].x == double(0))
    && (arr[2].y == double(0))
    && (arr[3].x == double(0))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    dvec4 x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == double(0))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == double(0))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == double(0))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uint x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == double(0))
    && (arr[1].x == uint(0))
    && (arr[1].y == double(0))
    && (arr[2].x == uint(0))
    && (arr[2].y == double(0))
    && (arr[3].x == uint(0))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uvec3 x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == double(0))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == double(0))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == double(0))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    bool x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == double(0))
    && (arr[1].x == bool(0))
    && (arr[1].y == double(0))
    && (arr[2].x == bool(0))
    && (arr[2].y == double(0))
    && (arr[3].x == bool(0))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uint8_t x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == double(0))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == double(0))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == double(0))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uint16_t x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == double(0))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == double(0))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == double(0))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    float16_t x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == double(0))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == double(0))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == double(0))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    float x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == float(0))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == float(0))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == float(0))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    vec4 x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    double x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == double(0))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == double(0))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == double(0))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    dvec4 x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uint x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == uint(0))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == uint(0))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == uint(0))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uvec3 x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    bool x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == bool(0))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == bool(0))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == bool(0))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uint8_t x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uint16_t x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    float16_t x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    float x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == uint(0))
    && (arr[1].x == float(0))
    && (arr[1].y == uint(0))
    && (arr[2].x == float(0))
    && (arr[2].y == uint(0))
    && (arr[3].x == float(0))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    vec4 x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == uint(0))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == uint(0))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == uint(0))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    double x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == uint(0))
    && (arr[1].x == double(0))
    && (arr[1].y == uint(0))
    && (arr[2].x == double(0))
    && (arr[2].y == uint(0))
    && (arr[3].x == double(0))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    dvec4 x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == uint(0))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == uint(0))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == uint(0))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uint x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == uint(0))
    && (arr[1].x == uint(0))
    && (arr[1].y == uint(0))
    && (arr[2].x == uint(0))
    && (arr[2].y == uint(0))
    && (arr[3].x == uint(0))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uvec3 x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == uint(0))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == uint(0))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == uint(0))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    bool x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == uint(0))
    && (arr[1].x == bool(0))
    && (arr[1].y == uint(0))
    && (arr[2].x == bool(0))
    && (arr[2].y == uint(0))
    && (arr[3].x == bool(0))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uint8_t x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == uint(0))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == uint(0))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == uint(0))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uint16_t x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == uint(0))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == uint(0))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == uint(0))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    float16_t x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == uint(0))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == uint(0))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == uint(0))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    float x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == float(0))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == float(0))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == float(0))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    vec4 x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    double x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == double(0))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == double(0))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == double(0))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    dvec4 x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uint x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == uint(0))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == uint(0))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == uint(0))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uvec3 x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    bool x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == bool(0))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == bool(0))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == bool(0))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uint8_t x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uint16_t x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    float16_t x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    float x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == bool(0))
    && (arr[1].x == float(0))
    && (arr[1].y == bool(0))
    && (arr[2].x == float(0))
    && (arr[2].y == bool(0))
    && (arr[3].x == float(0))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    vec4 x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == bool(0))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == bool(0))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == bool(0))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    double x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == bool(0))
    && (arr[1].x == double(0))
    && (arr[1].y == bool(0))
    && (arr[2].x == double(0))
    && (arr[2].y == bool(0))
    && (arr[3].x == double(0))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    dvec4 x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == bool(0))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == bool(0))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == bool(0))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uint x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == bool(0))
    && (arr[1].x == uint(0))
    && (arr[1].y == bool(0))
    && (arr[2].x == uint(0))
    && (arr[2].y == bool(0))
    && (arr[3].x == uint(0))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uvec3 x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == bool(0))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == bool(0))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == bool(0))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    bool x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == bool(0))
    && (arr[1].x == bool(0))
    && (arr[1].y == bool(0))
    && (arr[2].x == bool(0))
    && (arr[2].y == bool(0))
    && (arr[3].x == bool(0))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uint8_t x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == bool(0))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == bool(0))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == bool(0))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uint16_t x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == bool(0))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == bool(0))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == bool(0))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    float16_t x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == bool(0))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == bool(0))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == bool(0))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    float x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == float(0))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == float(0))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == float(0))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    vec4 x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    double x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == double(0))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == double(0))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == double(0))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    dvec4 x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uint x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == uint(0))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == uint(0))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == uint(0))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uvec3 x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    bool x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == bool(0))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == bool(0))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == bool(0))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uint8_t x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uint16_t x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    float16_t x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    float x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == float(0))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == float(0))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == float(0))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    vec4 x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    double x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == double(0))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == double(0))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == double(0))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    dvec4 x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uint x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == uint(0))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == uint(0))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == uint(0))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uvec3 x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    bool x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == bool(0))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == bool(0))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == bool(0))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uint8_t x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uint16_t x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    float16_t x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    float x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == float(0))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == float(0))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == float(0))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    vec4 x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    double x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == double(0))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == double(0))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == double(0))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    dvec4 x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uint x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == uint(0))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == uint(0))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == uint(0))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uvec3 x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    bool x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == bool(0))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == bool(0))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == bool(0))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uint8_t x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    uint16_t x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { u8vec4 arr[256]; } zero;
struct st {
    float16_t x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(1), uint8_t(1), uint8_t(1), uint8_t(1));
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = u8vec4(uint8_t(0), uint8_t(0), uint8_t(0), uint8_t(0));
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    float x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == float(0))
    && (arr[1].x == float(0))
    && (arr[2].x == float(0))
    && (arr[3].x == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    vec4 x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    double x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == double(0))
    && (arr[1].x == double(0))
    && (arr[2].x == double(0))
    && (arr[3].x == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    dvec4 x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uint x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[1].x == uint(0))
    && (arr[2].x == uint(0))
    && (arr[3].x == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uvec3 x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    bool x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[1].x == bool(0))
    && (arr[2].x == bool(0))
    && (arr[3].x == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uint8_t x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[1].x == uint8_t(0))
    && (arr[2].x == uint8_t(0))
    && (arr[3].x == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uint16_t x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[1].x == uint16_t(0))
    && (arr[2].x == uint16_t(0))
    && (arr[3].x == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    float16_t x;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[1].x == float16_t(0))
    && (arr[2].x == float16_t(0))
    && (arr[3].x == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    float x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == float(0))
    && (arr[1].x == float(0))
    && (arr[1].y == float(0))
    && (arr[2].x == float(0))
    && (arr[2].y == float(0))
    && (arr[3].x == float(0))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    vec4 x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == float(0))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == float(0))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == float(0))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    double x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == float(0))
    && (arr[1].x == double(0))
    && (arr[1].y == float(0))
    && (arr[2].x == double(0))
    && (arr[2].y == float(0))
    && (arr[3].x == double(0))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    dvec4 x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == float(0))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == float(0))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == float(0))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uint x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == float(0))
    && (arr[1].x == uint(0))
    && (arr[1].y == float(0))
    && (arr[2].x == uint(0))
    && (arr[2].y == float(0))
    && (arr[3].x == uint(0))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uvec3 x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == float(0))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == float(0))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == float(0))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    bool x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == float(0))
    && (arr[1].x == bool(0))
    && (arr[1].y == float(0))
    && (arr[2].x == bool(0))
    && (arr[2].y == float(0))
    && (arr[3].x == bool(0))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uint8_t x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == float(0))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == float(0))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == float(0))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uint16_t x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == float(0))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == float(0))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == float(0))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    float16_t x;
    float y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == float(0))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == float(0))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == float(0))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == float(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    float x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == float(0))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == float(0))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == float(0))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    vec4 x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    double x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == double(0))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == double(0))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == double(0))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    dvec4 x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uint x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == uint(0))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == uint(0))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == uint(0))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uvec3 x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    bool x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == bool(0))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == bool(0))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == bool(0))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uint8_t x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uint16_t x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    float16_t x;
    vec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == vec4(float(0), float(0), float(0), float(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    float x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == double(0))
    && (arr[1].x == float(0))
    && (arr[1].y == double(0))
    && (arr[2].x == float(0))
    && (arr[2].y == double(0))
    && (arr[3].x == float(0))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    vec4 x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == double(0))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == double(0))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == double(0))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    double x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == double(0))
    && (arr[1].x == double(0))
    && (arr[1].y == double(0))
    && (arr[2].x == double(0))
    && (arr[2].y == double(0))
    && (arr[3].x == double(0))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    dvec4 x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == double(0))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == double(0))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == double(0))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uint x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == double(0))
    && (arr[1].x == uint(0))
    && (arr[1].y == double(0))
    && (arr[2].x == uint(0))
    && (arr[2].y == double(0))
    && (arr[3].x == uint(0))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uvec3 x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == double(0))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == double(0))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == double(0))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    bool x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == double(0))
    && (arr[1].x == bool(0))
    && (arr[1].y == double(0))
    && (arr[2].x == bool(0))
    && (arr[2].y == double(0))
    && (arr[3].x == bool(0))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uint8_t x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == double(0))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == double(0))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == double(0))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uint16_t x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == double(0))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == double(0))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == double(0))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    float16_t x;
    double y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == double(0))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == double(0))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == double(0))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == double(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    float x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == float(0))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == float(0))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == float(0))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    vec4 x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    double x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == double(0))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == double(0))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == double(0))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    dvec4 x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uint x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == uint(0))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == uint(0))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == uint(0))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uvec3 x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    bool x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == bool(0))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == bool(0))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == bool(0))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uint8_t x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uint16_t x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    float16_t x;
    dvec4 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == dvec4(double(0), double(0), double(0), double(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    float x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == uint(0))
    && (arr[1].x == float(0))
    && (arr[1].y == uint(0))
    && (arr[2].x == float(0))
    && (arr[2].y == uint(0))
    && (arr[3].x == float(0))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    vec4 x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == uint(0))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == uint(0))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == uint(0))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    double x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == uint(0))
    && (arr[1].x == double(0))
    && (arr[1].y == uint(0))
    && (arr[2].x == double(0))
    && (arr[2].y == uint(0))
    && (arr[3].x == double(0))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    dvec4 x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == uint(0))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == uint(0))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == uint(0))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uint x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == uint(0))
    && (arr[1].x == uint(0))
    && (arr[1].y == uint(0))
    && (arr[2].x == uint(0))
    && (arr[2].y == uint(0))
    && (arr[3].x == uint(0))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uvec3 x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == uint(0))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == uint(0))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == uint(0))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    bool x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == uint(0))
    && (arr[1].x == bool(0))
    && (arr[1].y == uint(0))
    && (arr[2].x == bool(0))
    && (arr[2].y == uint(0))
    && (arr[3].x == bool(0))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uint8_t x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == uint(0))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == uint(0))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == uint(0))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uint16_t x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == uint(0))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == uint(0))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == uint(0))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    float16_t x;
    uint y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == uint(0))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == uint(0))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == uint(0))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == uint(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    float x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == float(0))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == float(0))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == float(0))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    vec4 x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    double x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == double(0))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == double(0))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == double(0))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    dvec4 x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uint x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == uint(0))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == uint(0))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == uint(0))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uvec3 x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    bool x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == bool(0))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == bool(0))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == bool(0))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uint8_t x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uint16_t x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    float16_t x;
    uvec3 y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == uvec3(uint(0), uint(0), uint(0)))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    float x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == bool(0))
    && (arr[1].x == float(0))
    && (arr[1].y == bool(0))
    && (arr[2].x == float(0))
    && (arr[2].y == bool(0))
    && (arr[3].x == float(0))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    vec4 x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == bool(0))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == bool(0))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == bool(0))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    double x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == bool(0))
    && (arr[1].x == double(0))
    && (arr[1].y == bool(0))
    && (arr[2].x == double(0))
    && (arr[2].y == bool(0))
    && (arr[3].x == double(0))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    dvec4 x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == bool(0))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == bool(0))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == bool(0))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uint x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == bool(0))
    && (arr[1].x == uint(0))
    && (arr[1].y == bool(0))
    && (arr[2].x == uint(0))
    && (arr[2].y == bool(0))
    && (arr[3].x == uint(0))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uvec3 x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == bool(0))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == bool(0))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == bool(0))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    bool x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == bool(0))
    && (arr[1].x == bool(0))
    && (arr[1].y == bool(0))
    && (arr[2].x == bool(0))
    && (arr[2].y == bool(0))
    && (arr[3].x == bool(0))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uint8_t x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == bool(0))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == bool(0))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == bool(0))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uint16_t x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == bool(0))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == bool(0))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == bool(0))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    float16_t x;
    bool y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == bool(0))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == bool(0))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == bool(0))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == bool(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    float x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == float(0))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == float(0))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == float(0))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    vec4 x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    double x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == double(0))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == double(0))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == double(0))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    dvec4 x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uint x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == uint(0))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == uint(0))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == uint(0))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uvec3 x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    bool x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == bool(0))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == bool(0))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == bool(0))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uint8_t x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uint16_t x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    float16_t x;
    uint8_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == uint8_t(0))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == uint8_t(0))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == uint8_t(0))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == uint8_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    float x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == float(0))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == float(0))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == float(0))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    vec4 x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    double x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == double(0))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == double(0))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == double(0))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    dvec4 x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uint x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == uint(0))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == uint(0))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == uint(0))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uvec3 x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    bool x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == bool(0))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == bool(0))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == bool(0))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uint8_t x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uint16_t x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    float16_t x;
    uint16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == uint16_t(0))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == uint16_t(0))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == uint16_t(0))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == uint16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    float x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == float(0))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == float(0))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == float(0))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == float(0))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    vec4 x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == vec4(float(0), float(0), float(0), float(0)))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    double x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == double(0))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == double(0))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == double(0))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == double(0))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    dvec4 x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == dvec4(double(0), double(0), double(0), double(0)))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uint x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uint(0))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == uint(0))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == uint(0))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == uint(0))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uvec3 x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == uvec3(uint(0), uint(0), uint(0)))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    bool x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == bool(0))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == bool(0))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == bool(0))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == bool(0))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uint8_t x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uint8_t(0))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == uint8_t(0))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == uint8_t(0))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == uint8_t(0))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    uint16_t x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == uint16_t(0))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == uint16_t(0))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == uint16_t(0))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == uint16_t(0))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
#version 450
#extension GL_EXT_shared_memory_block : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
shared A { uint16_t arr[256]; } zero;
struct st {
    float16_t x;
    float16_t y;
};
shared B { st arr[4]; };
layout(set = 0, binding = 0) buffer Result { uint result; };
void main() {
for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(1);
  }
  for (int i = 0; i < zero.arr.length(); i++) {
    zero.arr[i] = uint16_t(0);
  }
  result = (
    (arr[0].x == float16_t(0))
    && (arr[0].y == float16_t(0))
    && (arr[1].x == float16_t(0))
    && (arr[1].y == float16_t(0))
    && (arr[2].x == float16_t(0))
    && (arr[2].y == float16_t(0))
    && (arr[3].x == float16_t(0))
    && (arr[3].y == float16_t(0))
  ) ? 0 : 0xFF;
}
