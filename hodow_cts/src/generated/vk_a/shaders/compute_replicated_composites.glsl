#version 460 core
#extension GL_EXT_scalar_block_layout : enable
#extension GL_KHR_cooperative_matrix : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_spec_constant_composites : enable
#pragma use_replicated_composites
layout (local_size_x = 1) in;
layout(binding = 0, scalar) buffer Output {
float vec[4];
} sb_out;

void main (void) {
    float one = 1.0;
    vec4 vec = vec4(one);
    sb_out.vec[0] = vec[0];
    sb_out.vec[1] = vec[1];
    sb_out.vec[2] = vec[2];
    sb_out.vec[3] = vec[3];
}
#version 460 core
#extension GL_EXT_scalar_block_layout : enable
#extension GL_KHR_cooperative_matrix : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_spec_constant_composites : enable
#pragma use_replicated_composites
layout (local_size_x = 1) in;
layout(binding = 0, scalar) buffer Output {
float vec[4];
} sb_out;

const float one = 1.0;
const vec4 vec = vec4(one);
void main (void) {
    sb_out.vec[0] = vec[0];
    sb_out.vec[1] = vec[1];
    sb_out.vec[2] = vec[2];
    sb_out.vec[3] = vec[3];
}
#version 460 core
#extension GL_EXT_scalar_block_layout : enable
#extension GL_KHR_cooperative_matrix : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_spec_constant_composites : enable
#pragma use_replicated_composites
layout (local_size_x = 1) in;
layout(binding = 0, scalar) buffer Output {
float vec[4];
} sb_out;

layout(constant_id = 0) const float one = 1.0;
const vec4 vec = vec4(one);
void main (void) {
    sb_out.vec[0] = vec[0];
    sb_out.vec[1] = vec[1];
    sb_out.vec[2] = vec[2];
    sb_out.vec[3] = vec[3];
}
#version 460 core
#extension GL_EXT_scalar_block_layout : enable
#extension GL_KHR_cooperative_matrix : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_spec_constant_composites : enable
#pragma use_replicated_composites
layout (local_size_x = 1) in;
layout(binding = 0, scalar) buffer Output {
float mat[4*4];
} sb_out;

void main (void) {
    float one = 1.0;
    vec4 vec = vec4(one);
    mat4 mat = mat4(vec, vec, vec, vec);
    sb_out.mat[0] = mat[0][0];
    sb_out.mat[1] = mat[0][1];
    sb_out.mat[2] = mat[0][2];
    sb_out.mat[3] = mat[0][3];
    sb_out.mat[4] = mat[1][0];
    sb_out.mat[5] = mat[1][1];
    sb_out.mat[6] = mat[1][2];
    sb_out.mat[7] = mat[1][3];
    sb_out.mat[8] = mat[2][0];
    sb_out.mat[9] = mat[2][1];
    sb_out.mat[10] = mat[2][2];
    sb_out.mat[11] = mat[2][3];
    sb_out.mat[12] = mat[3][0];
    sb_out.mat[13] = mat[3][1];
    sb_out.mat[14] = mat[3][2];
    sb_out.mat[15] = mat[3][3];
}
#version 460 core
#extension GL_EXT_scalar_block_layout : enable
#extension GL_KHR_cooperative_matrix : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_spec_constant_composites : enable
#pragma use_replicated_composites
layout (local_size_x = 1) in;
layout(binding = 0, scalar) buffer Output {
float mat[4*4];
} sb_out;

const float one = 1.0;
const vec4 vec = vec4(one);
const mat4 mat = mat4(vec, vec, vec, vec);
void main (void) {
    sb_out.mat[0] = mat[0][0];
    sb_out.mat[1] = mat[0][1];
    sb_out.mat[2] = mat[0][2];
    sb_out.mat[3] = mat[0][3];
    sb_out.mat[4] = mat[1][0];
    sb_out.mat[5] = mat[1][1];
    sb_out.mat[6] = mat[1][2];
    sb_out.mat[7] = mat[1][3];
    sb_out.mat[8] = mat[2][0];
    sb_out.mat[9] = mat[2][1];
    sb_out.mat[10] = mat[2][2];
    sb_out.mat[11] = mat[2][3];
    sb_out.mat[12] = mat[3][0];
    sb_out.mat[13] = mat[3][1];
    sb_out.mat[14] = mat[3][2];
    sb_out.mat[15] = mat[3][3];
}
#version 460 core
#extension GL_EXT_scalar_block_layout : enable
#extension GL_KHR_cooperative_matrix : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_spec_constant_composites : enable
#pragma use_replicated_composites
layout (local_size_x = 1) in;
layout(binding = 0, scalar) buffer Output {
float mat[4*4];
} sb_out;

layout(constant_id = 0) const float one = 1.0;
const vec4 vec = vec4(one);
const mat4 mat = mat4(vec, vec, vec, vec);
void main (void) {
    sb_out.mat[0] = mat[0][0];
    sb_out.mat[1] = mat[0][1];
    sb_out.mat[2] = mat[0][2];
    sb_out.mat[3] = mat[0][3];
    sb_out.mat[4] = mat[1][0];
    sb_out.mat[5] = mat[1][1];
    sb_out.mat[6] = mat[1][2];
    sb_out.mat[7] = mat[1][3];
    sb_out.mat[8] = mat[2][0];
    sb_out.mat[9] = mat[2][1];
    sb_out.mat[10] = mat[2][2];
    sb_out.mat[11] = mat[2][3];
    sb_out.mat[12] = mat[3][0];
    sb_out.mat[13] = mat[3][1];
    sb_out.mat[14] = mat[3][2];
    sb_out.mat[15] = mat[3][3];
}
#version 460 core
#extension GL_EXT_scalar_block_layout : enable
#extension GL_KHR_cooperative_matrix : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_spec_constant_composites : enable
#pragma use_replicated_composites
layout (local_size_x = 1) in;
layout(binding = 0, scalar) buffer Output {
uint arr[3];
} sb_out;

void main (void) {
    uint three = 3;
    uint arr[3] = {three, three, three};
    sb_out.arr[0] = arr[0];
    sb_out.arr[1] = arr[1];
    sb_out.arr[2] = arr[2];
}
#version 460 core
#extension GL_EXT_scalar_block_layout : enable
#extension GL_KHR_cooperative_matrix : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_spec_constant_composites : enable
#pragma use_replicated_composites
layout (local_size_x = 1) in;
layout(binding = 0, scalar) buffer Output {
uint arr[3];
} sb_out;

const uint three = 3;
const uint arr[3] = {three, three, three};
void main (void) {
    sb_out.arr[0] = arr[0];
    sb_out.arr[1] = arr[1];
    sb_out.arr[2] = arr[2];
}
#version 460 core
#extension GL_EXT_scalar_block_layout : enable
#extension GL_KHR_cooperative_matrix : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_spec_constant_composites : enable
#pragma use_replicated_composites
layout (local_size_x = 1) in;
layout(binding = 0, scalar) buffer Output {
uint arr[3];
} sb_out;

layout(constant_id = 0) const uint three = 3;
const uint arr[3] = {three, three, three};
void main (void) {
    sb_out.arr[0] = arr[0];
    sb_out.arr[1] = arr[1];
    sb_out.arr[2] = arr[2];
}
#version 460 core
#extension GL_EXT_scalar_block_layout : enable
#extension GL_KHR_cooperative_matrix : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_spec_constant_composites : enable
#pragma use_replicated_composites
layout (local_size_x = 1) in;
layout(binding = 0, scalar) buffer Output {
uint arrarr[6];
} sb_out;

void main (void) {
    uint three = 3;
    uint arr[3] = {three, three, three};
    uint arrarr[2][3] = {arr, arr};
    sb_out.arrarr[0] = arrarr[0][0];
    sb_out.arrarr[1] = arrarr[0][1];
    sb_out.arrarr[2] = arrarr[0][2];
    sb_out.arrarr[3] = arrarr[1][0];
    sb_out.arrarr[4] = arrarr[1][1];
    sb_out.arrarr[5] = arrarr[1][2];
}
#version 460 core
#extension GL_EXT_scalar_block_layout : enable
#extension GL_KHR_cooperative_matrix : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_spec_constant_composites : enable
#pragma use_replicated_composites
layout (local_size_x = 1) in;
layout(binding = 0, scalar) buffer Output {
uint arrarr[6];
} sb_out;

const uint three = 3;
const uint arr[3] = {three, three, three};
const uint arrarr[2][3] = {arr, arr};
void main (void) {
    sb_out.arrarr[0] = arrarr[0][0];
    sb_out.arrarr[1] = arrarr[0][1];
    sb_out.arrarr[2] = arrarr[0][2];
    sb_out.arrarr[3] = arrarr[1][0];
    sb_out.arrarr[4] = arrarr[1][1];
    sb_out.arrarr[5] = arrarr[1][2];
}
#version 460 core
#extension GL_EXT_scalar_block_layout : enable
#extension GL_KHR_cooperative_matrix : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_spec_constant_composites : enable
#pragma use_replicated_composites
layout (local_size_x = 1) in;
layout(binding = 0, scalar) buffer Output {
uint arrarr[6];
} sb_out;

layout(constant_id = 0) const uint three = 3;
const uint arr[3] = {three, three, three};
const uint arrarr[2][3] = {arr, arr};
void main (void) {
    sb_out.arrarr[0] = arrarr[0][0];
    sb_out.arrarr[1] = arrarr[0][1];
    sb_out.arrarr[2] = arrarr[0][2];
    sb_out.arrarr[3] = arrarr[1][0];
    sb_out.arrarr[4] = arrarr[1][1];
    sb_out.arrarr[5] = arrarr[1][2];
}
#version 460 core
#extension GL_EXT_scalar_block_layout : enable
#extension GL_KHR_cooperative_matrix : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_spec_constant_composites : enable
#pragma use_replicated_composites
layout (local_size_x = 1) in;
layout(binding = 0, scalar) buffer Output {
uint str[3];
} sb_out;

void main (void) {
    uint six = 6;
    struct S { uint a; uint b; uint c; };
    S str = S(six, six, six);

    sb_out.str[0] = str.a;
    sb_out.str[1] = str.b;
    sb_out.str[2] = str.c;
}
#version 460 core
#extension GL_EXT_scalar_block_layout : enable
#extension GL_KHR_cooperative_matrix : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_spec_constant_composites : enable
#pragma use_replicated_composites
layout (local_size_x = 1) in;
layout(binding = 0, scalar) buffer Output {
uint str[3];
} sb_out;

const uint six = 6;
struct S { uint a; uint b; uint c; };
const S str = S(six, six, six);

void main (void) {
    sb_out.str[0] = str.a;
    sb_out.str[1] = str.b;
    sb_out.str[2] = str.c;
}
#version 460 core
#extension GL_EXT_scalar_block_layout : enable
#extension GL_KHR_cooperative_matrix : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_spec_constant_composites : enable
#pragma use_replicated_composites
layout (local_size_x = 1) in;
layout(binding = 0, scalar) buffer Output {
uint str[3];
} sb_out;

layout(constant_id = 0) const uint six = 6;
struct S { uint a; uint b; uint c; };
const S str = S(six, six, six);

void main (void) {
    sb_out.str[0] = str.a;
    sb_out.str[1] = str.b;
    sb_out.str[2] = str.c;
}
#version 460 core
#extension GL_EXT_scalar_block_layout : enable
#extension GL_KHR_cooperative_matrix : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_spec_constant_composites : enable
#pragma use_replicated_composites
layout (local_size_x = 1) in;
layout(binding = 0, scalar) buffer Output {
uint str[6];
} sb_out;

void main (void) {
    uint six = 6;
    struct S { uint a; uint b; uint c; };
    struct SS { S a; S b; };
    S str = S(six, six, six);
    SS str2 = SS(str, str);

    sb_out.str[0] = str2.a.a;
    sb_out.str[1] = str2.a.b;
    sb_out.str[2] = str2.a.c;
    sb_out.str[3] = str2.b.a;
    sb_out.str[4] = str2.b.b;
    sb_out.str[5] = str2.b.c;
}
#version 460 core
#extension GL_EXT_scalar_block_layout : enable
#extension GL_KHR_cooperative_matrix : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_spec_constant_composites : enable
#pragma use_replicated_composites
layout (local_size_x = 1) in;
layout(binding = 0, scalar) buffer Output {
uint str[6];
} sb_out;

const uint six = 6;
struct S { uint a; uint b; uint c; };
struct SS { S a; S b; };
const S str = S(six, six, six);
const SS str2 = SS(str, str);

void main (void) {
    sb_out.str[0] = str2.a.a;
    sb_out.str[1] = str2.a.b;
    sb_out.str[2] = str2.a.c;
    sb_out.str[3] = str2.b.a;
    sb_out.str[4] = str2.b.b;
    sb_out.str[5] = str2.b.c;
}
#version 460 core
#extension GL_EXT_scalar_block_layout : enable
#extension GL_KHR_cooperative_matrix : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_spec_constant_composites : enable
#pragma use_replicated_composites
layout (local_size_x = 1) in;
layout(binding = 0, scalar) buffer Output {
uint str[6];
} sb_out;

layout(constant_id = 0) const uint six = 6;
struct S { uint a; uint b; uint c; };
struct SS { S a; S b; };
const S str = S(six, six, six);
const SS str2 = SS(str, str);

void main (void) {
    sb_out.str[0] = str2.a.a;
    sb_out.str[1] = str2.a.b;
    sb_out.str[2] = str2.a.c;
    sb_out.str[3] = str2.b.a;
    sb_out.str[4] = str2.b.b;
    sb_out.str[5] = str2.b.c;
}
#version 460 core
#extension GL_EXT_scalar_block_layout : enable
#extension GL_KHR_cooperative_matrix : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_spec_constant_composites : enable
#pragma use_replicated_composites
layout (local_size_x = 64) in;
layout(binding = 0, scalar) buffer Output {
float mat[2];
} sb_out;

layout(constant_id = 1) const uint rows = 1;
layout(constant_id = 2) const uint cols = 1;
void main (void) {
    float one = 1.0;
    coopmat<float16_t, gl_ScopeSubgroup, rows, cols, gl_MatrixUseA> mat = coopmat<float16_t, gl_ScopeSubgroup, rows, cols, gl_MatrixUseA>(one);
    if (gl_LocalInvocationIndex == 0) {
        sb_out.mat[0] = float(mat[0]);
        sb_out.mat[1] = (mat.length() > 1) ? float(mat[1]) : float(mat[0]);
    }
}
#version 460 core
#extension GL_EXT_scalar_block_layout : enable
#extension GL_KHR_cooperative_matrix : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_spec_constant_composites : enable
#pragma use_replicated_composites
layout (local_size_x = 64) in;
layout(binding = 0, scalar) buffer Output {
float mat[2];
} sb_out;

layout(constant_id = 1) const uint rows = 1;
layout(constant_id = 2) const uint cols = 1;
const float one = 1.0;
const coopmat<float16_t, gl_ScopeSubgroup, rows, cols, gl_MatrixUseA> mat = coopmat<float16_t, gl_ScopeSubgroup, rows, cols, gl_MatrixUseA>(one);
void main (void) {
    if (gl_LocalInvocationIndex == 0) {
        sb_out.mat[0] = float(mat[0]);
        sb_out.mat[1] = (mat.length() > 1) ? float(mat[1]) : float(mat[0]);
    }
}
#version 460 core
#extension GL_EXT_scalar_block_layout : enable
#extension GL_KHR_cooperative_matrix : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_EXT_spec_constant_composites : enable
#pragma use_replicated_composites
layout (local_size_x = 64) in;
layout(binding = 0, scalar) buffer Output {
float mat[2];
} sb_out;

layout(constant_id = 1) const uint rows = 1;
layout(constant_id = 2) const uint cols = 1;
layout(constant_id = 0) const float one = 1.0;
const coopmat<float16_t, gl_ScopeSubgroup, rows, cols, gl_MatrixUseA> mat = coopmat<float16_t, gl_ScopeSubgroup, rows, cols, gl_MatrixUseA>(one);
void main (void) {
    if (gl_LocalInvocationIndex == 0) {
        sb_out.mat[0] = float(mat[0]);
        sb_out.mat[1] = (mat.length() > 1) ? float(mat[1]) : float(mat[0]);
    }
}
#version 450
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std430) buffer Out
{
    uint data[];
};
void main (void)
{
data[0] = 1;}
