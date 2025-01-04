#version 450 core
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(set=0, binding=0, std430) readonly buffer x {
   int xs[];
};
layout(set=0, binding=1, std430) writeonly buffer y {
   int observed_size;
};
layout(local_size_x=1) in;
void main (void) {
   observed_size = xs.length();
}
#version 450 core
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
#pragma use_variable_pointers
layout(set=0, binding=0, std430) readonly buffer x {
   int xs[];
};
layout(set=0, binding=1, std430) writeonly buffer y {
   int observed_size;
};
layout(local_size_x=1) in;
void main (void) {
   observed_size = xs.length();
}
#version 450 core
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(set=0, binding=0, std430) readonly buffer x {
   int xs[];
};
layout(set=0, binding=1, std430) writeonly buffer y {
   int64_t observed_size;
};
layout(local_size_x=1) in;
void main (void) {
   observed_size = xs.length64();
}
#version 450 core
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
#pragma use_variable_pointers
layout(set=0, binding=0, std430) readonly buffer x {
   int xs[];
};
layout(set=0, binding=1, std430) writeonly buffer y {
   int64_t observed_size;
};
layout(local_size_x=1) in;
void main (void) {
   observed_size = xs.length64();
}
