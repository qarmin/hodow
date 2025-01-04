#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, row_major, binding = 1) buffer Block
{
	lowp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 9.0) && allOk;
	allOk = compare_float(var[0][1], -1.0) && allOk;
	allOk = compare_float(var[1][0], 3.0) && allOk;
	allOk = compare_float(var[1][1], 0.0) && allOk;
	allOk = compare_float(var[2][0], -6.0) && allOk;
	allOk = compare_float(var[2][1], -7.0) && allOk;
	allOk = compare_float(var[3][0], 9.0) && allOk;
	allOk = compare_float(var[3][1], 7.0) && allOk;
	allOk = compare_vec2(var[0], vec2(9.0, -1.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(3.0, 0.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-6.0, -7.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(9.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x2(-7.0, 3.0, -5.0, 1.0, -6.0, -1.0, -4.0, -5.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, row_major, binding = 1) buffer Block
{
	mediump mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -7.0) && allOk;
	allOk = compare_float(var[0][1], 5.0) && allOk;
	allOk = compare_float(var[1][0], 5.0) && allOk;
	allOk = compare_float(var[1][1], -5.0) && allOk;
	allOk = compare_float(var[2][0], -2.0) && allOk;
	allOk = compare_float(var[2][1], 2.0) && allOk;
	allOk = compare_float(var[3][0], -4.0) && allOk;
	allOk = compare_float(var[3][1], 3.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-7.0, 5.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(5.0, -5.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-2.0, 2.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(-4.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x2(4.0, 4.0, -5.0, -6.0, 0.0, 4.0, 2.0, 9.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, binding = 1) buffer Block
{
	lowp ivec3 var;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((var), ivec3(-1, -8, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (ivec3(5, -9, -8));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, binding = 1) buffer Block
{
	bvec2 var;
};

bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((var), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (bvec2(true, false));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, row_major, binding = 1) buffer Block
{
	mediump mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var, mat4(0.0, -6.0, -5.0, 0.0, 1.0, 3.0, -2.0, 5.0, -5.0, -6.0, 2.0, -1.0, 0.0, -3.0, 9.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(-6.0, -5.0, -2.0, -2.0));
	var[1] = (vec4(-5.0, -9.0, -5.0, 1.0));
	var[2] = (vec4(4.0, 1.0, -2.0, -6.0));
	var[3] = (vec4(-7.0, -7.0, -1.0, 5.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, column_major, binding = 1) buffer Block
{
	lowp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var, mat2x4(-6.0, -6.0, -8.0, -2.0, -6.0, -3.0, 8.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2x4(2.0, -2.0, -6.0, 0.0, -7.0, 7.0, -9.0, 0.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, binding = 1) buffer Block
{
	i16vec2 var;
};

bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(var), ivec2(3, -1)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = i16vec2(ivec2(6, -2));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, row_major, binding = 1) buffer Block
{
	float padding;
	lowp mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 4.0) && allOk;
	allOk = compare_float(var[0][0], -5.0) && allOk;
	allOk = compare_float(var[0][1], -9.0) && allOk;
	allOk = compare_float(var[0][2], -5.0) && allOk;
	allOk = compare_float(var[1][0], 7.0) && allOk;
	allOk = compare_float(var[1][1], 1.0) && allOk;
	allOk = compare_float(var[1][2], -9.0) && allOk;
	allOk = compare_float(var[2][0], -6.0) && allOk;
	allOk = compare_float(var[2][1], 9.0) && allOk;
	allOk = compare_float(var[2][2], -4.0) && allOk;
	allOk = compare_float(var[3][0], -7.0) && allOk;
	allOk = compare_float(var[3][1], 5.0) && allOk;
	allOk = compare_float(var[3][2], 6.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-5.0, -9.0, -5.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(7.0, 1.0, -9.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-6.0, 9.0, -4.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(-7.0, 5.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (1.0);
	var = (mat4x3(1.0, -8.0, -4.0, -5.0, -7.0, -2.0, -5.0, 4.0, -1.0, -9.0, 9.0, -1.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, row_major, binding = 1) buffer Block
{
	highp mat4x3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0], mat4x3(-1.0, -7.0, 8.0, 5.0, -5.0, 7.0, -9.0, 5.0, 0.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(7.0, -9.0, 6.0, 0.0, -8.0, -3.0, -6.0, 8.0, 8.0, -7.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(1.0, 0.0, 7.0, -2.0, 4.0, 9.0, 9.0, 8.0, -2.0, -2.0, -4.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4x3(-2.0, 9.0, 6.0, 4.0, 4.0, 3.0, 2.0, 4.0, 6.0, 7.0, -2.0, 2.0));
	var[1] = (mat4x3(-8.0, -2.0, 9.0, 9.0, 6.0, -2.0, 4.0, -7.0, 6.0, -7.0, 9.0, 6.0));
	var[2] = (mat4x3(6.0, 8.0, 8.0, 9.0, -6.0, 5.0, -3.0, 9.0, -5.0, 9.0, 9.0, -3.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, binding = 1) buffer Block
{
	u16vec2 var[3];
};

bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(var[0]), uvec2(8u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1]), uvec2(2u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2]), uvec2(6u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = u16vec2(uvec2(8u, 0u));
	var[1] = u16vec2(uvec2(6u, 0u));
	var[2] = u16vec2(uvec2(6u, 9u));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, binding = 1) buffer Block
{
	float padding;
	highp mat4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat4(var[0], mat4(0.0, 6.0, 0.0, -6.0, 5.0, 3.0, -4.0, -9.0, -8.0, 9.0, 3.0, 2.0, -9.0, 6.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(0.0, 1.0, -5.0, -2.0, 1.0, -6.0, -8.0, -1.0, 5.0, -8.0, 0.0, -6.0, 3.0, -3.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(-3.0, 4.0, 6.0, 2.0, 3.0, 0.0, 7.0, 9.0, -9.0, -6.0, 8.0, 0.0, -9.0, 9.0, -7.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (4.0);
	var[0] = (mat4(7.0, -2.0, -5.0, 3.0, -6.0, 0.0, -4.0, 2.0, -9.0, -1.0, 6.0, 8.0, 9.0, 5.0, -6.0, 1.0));
	var[1] = (mat4(3.0, -7.0, -5.0, 5.0, -5.0, -2.0, -4.0, 9.0, 5.0, 2.0, -3.0, -8.0, 2.0, 1.0, 5.0, 5.0));
	var[2] = (mat4(2.0, -1.0, -1.0, 5.0, -5.0, 0.0, 3.0, -6.0, -5.0, -1.0, 3.0, -6.0, -5.0, -7.0, -8.0, -1.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, binding = 1) buffer Block
{
	highp mat3 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0], mat3(-9.0, -4.0, 2.0, 9.0, 6.0, -2.0, 1.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(6.0, 3.0, 2.0, 7.0, 4.0, 2.0, 3.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(6.0, 3.0, 7.0, -4.0, -2.0, -7.0, -6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3(var[3], mat3(8.0, -8.0, 9.0, -5.0, 1.0, 4.0, -5.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat3(var[4], mat3(3.0, -6.0, -5.0, 8.0, -7.0, -1.0, 7.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3(var[5], mat3(-3.0, 9.0, -3.0, -6.0, -2.0, -9.0, 4.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat3(var[6], mat3(-9.0, -7.0, 6.0, 9.0, 7.0, 9.0, -3.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3(var[7], mat3(9.0, -2.0, 1.0, 4.0, 4.0, 6.0, -1.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat3(var[8], mat3(-5.0, 6.0, 1.0, -6.0, -3.0, -8.0, -9.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(var[9], mat3(-7.0, 8.0, -9.0, 5.0, -3.0, 6.0, 5.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(var[10], mat3(-4.0, 7.0, -7.0, -7.0, -4.0, 4.0, -5.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(var[11], mat3(2.0, 6.0, -4.0, -8.0, -5.0, -4.0, -7.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(var[12], mat3(6.0, 2.0, -2.0, -8.0, 6.0, -8.0, 9.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat3(var[13], mat3(2.0, -5.0, -3.0, 8.0, -9.0, -7.0, 1.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3(var[14], mat3(4.0, 7.0, -9.0, 5.0, 0.0, -7.0, -9.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3(var[15], mat3(-1.0, -3.0, 9.0, -3.0, 4.0, 3.0, 3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3(var[16], mat3(6.0, 8.0, -8.0, 7.0, -1.0, 4.0, 0.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3(var[17], mat3(2.0, 8.0, 8.0, -5.0, 4.0, -5.0, 8.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3(var[18], mat3(8.0, 6.0, -5.0, 8.0, 3.0, 2.0, -2.0, 5.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3(-1.0, -8.0, 7.0, -5.0, 5.0, 6.0, 0.0, -8.0, -6.0));
	var[1] = (mat3(-4.0, 3.0, 7.0, 1.0, -1.0, 9.0, 6.0, 2.0, 9.0));
	var[2] = (mat3(-6.0, 8.0, 0.0, 1.0, 4.0, 6.0, -9.0, -9.0, 2.0));
	var[3] = (mat3(8.0, -1.0, 9.0, 9.0, 7.0, -5.0, -5.0, -8.0, 8.0));
	var[4] = (mat3(-2.0, 9.0, 8.0, -9.0, 3.0, 2.0, 9.0, 1.0, 2.0));
	var[5] = (mat3(-9.0, -7.0, -5.0, -3.0, 7.0, 2.0, -1.0, 1.0, 2.0));
	var[6] = (mat3(-2.0, 9.0, 0.0, 0.0, -3.0, -9.0, -6.0, 5.0, 0.0));
	var[7] = (mat3(-5.0, 6.0, 3.0, -2.0, 5.0, 6.0, 9.0, -9.0, 8.0));
	var[8] = (mat3(6.0, 6.0, -9.0, -8.0, -3.0, -7.0, 6.0, -1.0, -6.0));
	var[9] = (mat3(-1.0, 6.0, -1.0, 1.0, -5.0, -8.0, 2.0, -7.0, -4.0));
	var[10] = (mat3(3.0, -9.0, 2.0, -1.0, 4.0, 3.0, -2.0, 9.0, -3.0));
	var[11] = (mat3(-6.0, -9.0, 6.0, 9.0, 0.0, 3.0, 8.0, -4.0, -4.0));
	var[12] = (mat3(1.0, -8.0, 4.0, 5.0, 7.0, 9.0, 5.0, 8.0, -6.0));
	var[13] = (mat3(-9.0, -5.0, 9.0, 8.0, -9.0, -8.0, -5.0, 6.0, -7.0));
	var[14] = (mat3(2.0, 4.0, 5.0, -8.0, -2.0, 8.0, 6.0, 2.0, -9.0));
	var[15] = (mat3(-8.0, 1.0, -1.0, 7.0, -2.0, -3.0, 5.0, 3.0, 0.0));
	var[16] = (mat3(-1.0, -2.0, -3.0, 3.0, -9.0, -3.0, -4.0, -7.0, -5.0));
	var[17] = (mat3(-8.0, 9.0, 8.0, 8.0, 4.0, 5.0, 1.0, 8.0, 7.0));
	var[18] = (mat3(2.0, 2.0, -3.0, 0.0, 0.0, 9.0, 3.0, 9.0, 2.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, column_major, binding = 1) buffer Block
{
	highp mat3x4 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0], mat3x4(9.0, -4.0, -6.0, 2.0, -9.0, -8.0, 7.0, 0.0, 5.0, 3.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(9.0, -7.0, 0.0, 6.0, -3.0, 8.0, 6.0, -6.0, -6.0, -4.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(-7.0, 5.0, -6.0, 7.0, -4.0, -9.0, -9.0, -4.0, -8.0, -8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3x4(var[3], mat3x4(-5.0, 6.0, 2.0, -2.0, -3.0, 2.0, 4.0, -3.0, 5.0, 5.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[4], mat3x4(-6.0, 9.0, 8.0, 1.0, -2.0, 9.0, 1.0, -5.0, -9.0, 9.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[5], mat3x4(-4.0, 0.0, 9.0, -6.0, -9.0, -7.0, -7.0, 1.0, 1.0, 2.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[6], mat3x4(4.0, 6.0, -1.0, -2.0, -4.0, 0.0, 4.0, -8.0, 3.0, 4.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[7], mat3x4(8.0, 7.0, 4.0, -4.0, 0.0, 2.0, -5.0, 4.0, 0.0, 7.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[8], mat3x4(7.0, -8.0, 6.0, -8.0, -3.0, -8.0, 4.0, 7.0, 5.0, -2.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[9], mat3x4(-3.0, -4.0, 8.0, 5.0, -1.0, -5.0, -2.0, 2.0, -8.0, -8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[10], mat3x4(6.0, -3.0, -1.0, -3.0, -7.0, -6.0, 1.0, -7.0, -1.0, 8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[11], mat3x4(-1.0, -8.0, 0.0, 1.0, 7.0, -5.0, -6.0, 7.0, 5.0, -3.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[12], mat3x4(0.0, 6.0, 3.0, 9.0, -3.0, 9.0, 3.0, -5.0, -1.0, 6.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[13], mat3x4(-7.0, 6.0, 5.0, -7.0, -2.0, -4.0, 0.0, -8.0, 8.0, 9.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[14], mat3x4(4.0, 4.0, -6.0, -2.0, 7.0, 1.0, -3.0, -2.0, -6.0, -2.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[15], mat3x4(-6.0, -4.0, 8.0, -5.0, -5.0, 7.0, 3.0, -1.0, 7.0, -4.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[16], mat3x4(5.0, -1.0, 4.0, -5.0, -8.0, -7.0, 7.0, -6.0, -4.0, 6.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[17], mat3x4(-5.0, 3.0, 9.0, 0.0, 1.0, 3.0, -8.0, -9.0, 5.0, 8.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[18], mat3x4(-2.0, 9.0, -5.0, -3.0, 3.0, 5.0, 4.0, -7.0, -1.0, 4.0, -9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3x4(3.0, -9.0, -6.0, 7.0, 6.0, -8.0, -1.0, 1.0, -9.0, 7.0, 6.0, 6.0));
	var[1] = (mat3x4(-5.0, -1.0, -8.0, 3.0, 9.0, 9.0, -8.0, 0.0, 0.0, -9.0, -6.0, -7.0));
	var[2] = (mat3x4(-3.0, -3.0, 9.0, -7.0, 4.0, 2.0, -8.0, 4.0, -6.0, -1.0, -9.0, 5.0));
	var[3] = (mat3x4(-5.0, -5.0, -9.0, -1.0, -9.0, -3.0, 0.0, 2.0, 8.0, -5.0, 1.0, 4.0));
	var[4] = (mat3x4(-5.0, 5.0, -5.0, 2.0, -8.0, -3.0, 6.0, 1.0, 0.0, 1.0, 4.0, 6.0));
	var[5] = (mat3x4(-9.0, -1.0, -9.0, -6.0, 8.0, -9.0, -4.0, -6.0, -6.0, -1.0, -3.0, -7.0));
	var[6] = (mat3x4(-4.0, 2.0, -8.0, -7.0, -3.0, 6.0, 6.0, 8.0, -4.0, -1.0, 1.0, -9.0));
	var[7] = (mat3x4(9.0, -2.0, 4.0, 3.0, -2.0, 8.0, -4.0, 5.0, -8.0, 8.0, -2.0, 7.0));
	var[8] = (mat3x4(-6.0, 5.0, -8.0, -5.0, -7.0, -8.0, 3.0, 4.0, -7.0, 2.0, 3.0, 2.0));
	var[9] = (mat3x4(9.0, 2.0, -6.0, 4.0, 9.0, 6.0, 2.0, 0.0, 1.0, 0.0, -3.0, 2.0));
	var[10] = (mat3x4(-1.0, 4.0, -6.0, 4.0, -1.0, 3.0, 1.0, 3.0, 6.0, -6.0, -9.0, -9.0));
	var[11] = (mat3x4(-9.0, 1.0, -6.0, 4.0, 0.0, -2.0, -8.0, 9.0, 6.0, -9.0, 6.0, 7.0));
	var[12] = (mat3x4(-6.0, 0.0, 1.0, -2.0, 1.0, -4.0, -2.0, -6.0, -7.0, -8.0, 0.0, -8.0));
	var[13] = (mat3x4(0.0, 2.0, 9.0, -5.0, 9.0, -5.0, -4.0, 0.0, 4.0, 1.0, 0.0, -9.0));
	var[14] = (mat3x4(1.0, -1.0, -4.0, 9.0, 7.0, 3.0, 5.0, 1.0, 6.0, 6.0, 2.0, 2.0));
	var[15] = (mat3x4(8.0, -5.0, -9.0, 8.0, -3.0, -3.0, 9.0, -9.0, 6.0, -4.0, 9.0, 4.0));
	var[16] = (mat3x4(-8.0, 4.0, 7.0, 3.0, -1.0, -1.0, 9.0, -9.0, 8.0, -3.0, 9.0, -6.0));
	var[17] = (mat3x4(-4.0, 6.0, 2.0, 5.0, 3.0, 7.0, 3.0, 4.0, -4.0, 2.0, 0.0, 8.0));
	var[18] = (mat3x4(-8.0, 0.0, 8.0, -6.0, -2.0, -3.0, 6.0, 4.0, 9.0, -2.0, 4.0, 1.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, row_major, binding = 1) buffer Block
{
	highp mat3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0][0], mat3(2.0, 0.0, -4.0, -3.0, 4.0, 5.0, -1.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3(var[0][1], mat3(-1.0, 4.0, -4.0, -3.0, 0.0, -1.0, -5.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat3(var[0][2], mat3(2.0, 4.0, -3.0, 8.0, 3.0, -2.0, -1.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3(var[1][0], mat3(2.0, 8.0, 1.0, -3.0, -4.0, 7.0, -1.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(var[1][1], mat3(-6.0, -6.0, -5.0, 5.0, -2.0, 0.0, 7.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3(var[1][2], mat3(-3.0, 9.0, 7.0, 8.0, -9.0, -1.0, -4.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3(var[2][0], mat3(-1.0, 8.0, 3.0, 2.0, -6.0, -2.0, -2.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3(var[2][1], mat3(-9.0, 0.0, 6.0, -9.0, -5.0, 8.0, -7.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3(var[2][2], mat3(-7.0, 6.0, 2.0, 5.0, 4.0, 9.0, 7.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3(var[3][0], mat3(1.0, -6.0, -3.0, -1.0, 6.0, 0.0, -2.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[3][1], mat3(2.0, 1.0, 9.0, -4.0, -9.0, 2.0, 5.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[3][2], mat3(0.0, 9.0, 5.0, 1.0, 2.0, 2.0, -5.0, 1.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec3(3.0, -9.0, 3.0));
	var[0][0][1] = (vec3(2.0, 4.0, 6.0));
	var[0][0][2] = (vec3(2.0, -9.0, 0.0));
	var[0][1][0] = (vec3(-7.0, 3.0, -3.0));
	var[0][1][1] = (vec3(-4.0, -4.0, 5.0));
	var[0][1][2] = (vec3(-4.0, 1.0, -7.0));
	var[0][2][0] = (vec3(7.0, 9.0, -7.0));
	var[0][2][1] = (vec3(8.0, 2.0, 5.0));
	var[0][2][2] = (vec3(-9.0, 7.0, -2.0));
	var[1][0][0] = (vec3(-7.0, 3.0, 4.0));
	var[1][0][1] = (vec3(-1.0, 1.0, 0.0));
	var[1][0][2] = (vec3(7.0, 7.0, 9.0));
	var[1][1][0] = (vec3(4.0, 4.0, -3.0));
	var[1][1][1] = (vec3(9.0, 1.0, -6.0));
	var[1][1][2] = (vec3(7.0, -6.0, -1.0));
	var[1][2][0] = (vec3(-5.0, -2.0, -7.0));
	var[1][2][1] = (vec3(-8.0, -9.0, 6.0));
	var[1][2][2] = (vec3(2.0, -2.0, -7.0));
	var[2][0][0] = (vec3(6.0, -2.0, -1.0));
	var[2][0][1] = (vec3(9.0, 2.0, -4.0));
	var[2][0][2] = (vec3(-9.0, -5.0, 4.0));
	var[2][1][0] = (vec3(-1.0, -6.0, 9.0));
	var[2][1][1] = (vec3(-1.0, 3.0, 0.0));
	var[2][1][2] = (vec3(-7.0, 1.0, -6.0));
	var[2][2][0] = (vec3(0.0, -6.0, 0.0));
	var[2][2][1] = (vec3(8.0, 6.0, 4.0));
	var[2][2][2] = (vec3(7.0, -4.0, 4.0));
	var[3][0][0] = (vec3(-6.0, 3.0, -3.0));
	var[3][0][1] = (vec3(0.0, -8.0, 6.0));
	var[3][0][2] = (vec3(-7.0, -2.0, 7.0));
	var[3][1][0] = (vec3(4.0, -8.0, 1.0));
	var[3][1][1] = (vec3(-6.0, 7.0, 1.0));
	var[3][1][2] = (vec3(6.0, 3.0, 0.0));
	var[3][2][0] = (vec3(-2.0, -9.0, 9.0));
	var[3][2][1] = (vec3(1.0, 3.0, 4.0));
	var[3][2][2] = (vec3(5.0, -3.0, -6.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, row_major, binding = 1) buffer Block
{
	highp mat4x3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0][0], mat4x3(3.0, 9.0, 5.0, 5.0, 8.0, -9.0, 1.0, -3.0, 3.0, 6.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[0][1], mat4x3(-9.0, -2.0, -1.0, 6.0, 6.0, 9.0, 0.0, 3.0, -4.0, 2.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[0][2], mat4x3(6.0, 8.0, 7.0, 6.0, 1.0, 3.0, 8.0, -4.0, 7.0, -9.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[1][0], mat4x3(-4.0, -7.0, 7.0, -5.0, 2.0, 4.0, 9.0, 2.0, 6.0, -3.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[1][1], mat4x3(3.0, -3.0, 0.0, 8.0, 6.0, -1.0, 9.0, 6.0, 0.0, 4.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[1][2], mat4x3(6.0, 2.0, -1.0, -6.0, -9.0, 7.0, -9.0, -9.0, 8.0, 6.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[2][0], mat4x3(-9.0, -5.0, -9.0, 1.0, -9.0, 3.0, 4.0, 0.0, -8.0, -3.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[2][1], mat4x3(-7.0, -4.0, 0.0, 2.0, 3.0, -9.0, -3.0, 0.0, -7.0, 8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[2][2], mat4x3(-7.0, 4.0, 9.0, 8.0, -5.0, -5.0, 6.0, 8.0, -7.0, 1.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[3][0], mat4x3(0.0, -9.0, -1.0, 9.0, 2.0, -9.0, 8.0, 0.0, 1.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[3][1], mat4x3(5.0, -5.0, -1.0, -9.0, 7.0, 5.0, 0.0, 7.0, -3.0, -7.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[3][2], mat4x3(-3.0, 1.0, 7.0, -9.0, 6.0, 7.0, -5.0, 8.0, -2.0, -6.0, -3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat4x3(-5.0, 9.0, 2.0, -5.0, 1.0, 6.0, 4.0, 3.0, 9.0, -4.0, 3.0, 1.0));
	var[0][1] = (mat4x3(-5.0, 2.0, 4.0, -6.0, 1.0, 3.0, -6.0, -1.0, -4.0, 3.0, 9.0, -1.0));
	var[0][2] = (mat4x3(4.0, 2.0, 8.0, -9.0, -8.0, -5.0, -9.0, -6.0, -7.0, 6.0, -5.0, -5.0));
	var[1][0] = (mat4x3(9.0, -7.0, -4.0, -3.0, -2.0, 6.0, 2.0, 3.0, -8.0, -7.0, 9.0, -1.0));
	var[1][1] = (mat4x3(9.0, 0.0, 0.0, 7.0, 7.0, 9.0, -7.0, -4.0, 7.0, -5.0, 0.0, -1.0));
	var[1][2] = (mat4x3(-4.0, 1.0, 3.0, -5.0, -2.0, -6.0, -8.0, -7.0, -9.0, -2.0, 2.0, 9.0));
	var[2][0] = (mat4x3(-8.0, -3.0, -8.0, -5.0, 2.0, -9.0, 2.0, 9.0, 8.0, 7.0, 9.0, -6.0));
	var[2][1] = (mat4x3(8.0, -8.0, -9.0, 9.0, 8.0, -3.0, 4.0, 8.0, 2.0, -9.0, -8.0, 5.0));
	var[2][2] = (mat4x3(-8.0, 9.0, 8.0, -9.0, 8.0, -3.0, -9.0, -6.0, 1.0, -1.0, -2.0, -1.0));
	var[3][0] = (mat4x3(8.0, -3.0, -6.0, 2.0, -2.0, 0.0, -4.0, -5.0, 8.0, 2.0, 9.0, -1.0));
	var[3][1] = (mat4x3(1.0, -6.0, -5.0, -5.0, 6.0, 8.0, 7.0, 0.0, 7.0, 1.0, 4.0, 9.0));
	var[3][2] = (mat4x3(-4.0, 8.0, 5.0, -4.0, -9.0, -1.0, 0.0, 5.0, -4.0, -1.0, -3.0, -5.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, row_major, binding = 1) buffer Block
{
	highp mat4x2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0][0], mat4x2(9.0, 2.0, -3.0, -5.0, -5.0, -4.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[0][1], mat4x2(7.0, 7.0, -8.0, 9.0, -7.0, -5.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[0][2], mat4x2(-9.0, 8.0, 3.0, -7.0, 5.0, 3.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[1][0], mat4x2(7.0, -4.0, -4.0, -6.0, 9.0, -3.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[1][1], mat4x2(-2.0, 5.0, 6.0, 4.0, -6.0, -2.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[1][2], mat4x2(-5.0, 9.0, -4.0, -6.0, 4.0, -5.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[2][0], mat4x2(-4.0, 9.0, -1.0, -6.0, 5.0, 3.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[2][1], mat4x2(-7.0, -7.0, -9.0, 9.0, 5.0, 8.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[2][2], mat4x2(-6.0, -5.0, -7.0, -3.0, 6.0, -7.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[3][0], mat4x2(7.0, -9.0, -5.0, -3.0, -6.0, -9.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[3][1], mat4x2(-4.0, -9.0, 9.0, -7.0, -6.0, -8.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[3][2], mat4x2(8.0, 6.0, 7.0, -6.0, 0.0, 0.0, 6.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat4x2(-9.0, 9.0, 1.0, 5.0, 0.0, 6.0, 3.0, 6.0));
	var[0][1] = (mat4x2(-5.0, -7.0, 8.0, -6.0, 1.0, -3.0, 2.0, 4.0));
	var[0][2] = (mat4x2(8.0, -2.0, 6.0, 6.0, 1.0, -9.0, 9.0, -3.0));
	var[1][0] = (mat4x2(2.0, 0.0, -9.0, -3.0, -1.0, 1.0, 8.0, 1.0));
	var[1][1] = (mat4x2(-3.0, 6.0, -3.0, -6.0, -7.0, 2.0, 2.0, 7.0));
	var[1][2] = (mat4x2(3.0, -6.0, -7.0, -9.0, 6.0, 3.0, 6.0, 3.0));
	var[2][0] = (mat4x2(-8.0, 5.0, -9.0, -8.0, -8.0, -4.0, -5.0, -5.0));
	var[2][1] = (mat4x2(-6.0, 1.0, 7.0, 7.0, -9.0, 6.0, -8.0, -3.0));
	var[2][2] = (mat4x2(4.0, -4.0, 8.0, -6.0, 5.0, 3.0, 3.0, 2.0));
	var[3][0] = (mat4x2(2.0, -3.0, 9.0, 9.0, -2.0, 0.0, -5.0, -2.0));
	var[3][1] = (mat4x2(3.0, 5.0, 8.0, 9.0, -2.0, -1.0, 3.0, -2.0));
	var[3][2] = (mat4x2(7.0, 5.0, 1.0, -1.0, 2.0, 8.0, 7.0, 7.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, binding = 1) buffer Block
{
	u8vec4 var[4][3];
};

bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(var[0][0]), uvec4(3u, 4u, 6u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[0][1]), uvec4(1u, 5u, 7u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[0][2]), uvec4(1u, 4u, 6u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[1][0]), uvec4(7u, 7u, 6u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[1][1]), uvec4(3u, 3u, 3u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[1][2]), uvec4(7u, 2u, 2u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[2][0]), uvec4(6u, 9u, 5u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[2][1]), uvec4(5u, 2u, 0u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[2][2]), uvec4(8u, 3u, 7u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[3][0]), uvec4(5u, 7u, 4u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[3][1]), uvec4(5u, 8u, 5u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[3][2]), uvec4(8u, 6u, 3u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = u8vec4(uvec4(9u, 5u, 9u, 4u));
	var[0][1] = u8vec4(uvec4(6u, 8u, 7u, 3u));
	var[0][2] = u8vec4(uvec4(6u, 7u, 1u, 9u));
	var[1][0] = u8vec4(uvec4(8u, 9u, 3u, 3u));
	var[1][1] = u8vec4(uvec4(3u, 9u, 0u, 6u));
	var[1][2] = u8vec4(uvec4(8u, 7u, 6u, 7u));
	var[2][0] = u8vec4(uvec4(7u, 7u, 4u, 8u));
	var[2][1] = u8vec4(uvec4(8u, 5u, 3u, 1u));
	var[2][2] = u8vec4(uvec4(1u, 4u, 7u, 1u));
	var[3][0] = u8vec4(uvec4(3u, 6u, 3u, 3u));
	var[3][1] = u8vec4(uvec4(4u, 7u, 8u, 8u));
	var[3][2] = u8vec4(uvec4(1u, 7u, 7u, 2u));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, column_major, binding = 1) buffer Block
{
	highp mat2x4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0][0][0], mat2x4(5.0, -9.0, 4.0, 8.0, -1.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(-7.0, 1.0, 3.0, -8.0, 0.0, -7.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][2], mat2x4(8.0, 3.0, 1.0, -5.0, 2.0, 6.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(-7.0, -3.0, 7.0, -3.0, 8.0, 3.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(8.0, 0.0, -1.0, 2.0, 2.0, -8.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][2], mat2x4(-5.0, 6.0, 6.0, 8.0, -9.0, 0.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(-7.0, 0.0, -7.0, -6.0, -8.0, -6.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(-9.0, 7.0, 5.0, 2.0, -3.0, -8.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][2], mat2x4(-5.0, 4.0, 5.0, -3.0, -7.0, -9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(-5.0, 5.0, -1.0, 2.0, -3.0, -1.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(-5.0, 8.0, 6.0, 1.0, 3.0, 9.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][2], mat2x4(-8.0, -3.0, 1.0, -2.0, 5.0, 3.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(-2.0, -5.0, 5.0, -9.0, -6.0, 9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(-3.0, 4.0, -4.0, -3.0, 7.0, 7.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][2], mat2x4(-5.0, -3.0, -3.0, -4.0, -9.0, 2.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(5.0, -7.0, 7.0, 2.0, 1.0, -3.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(5.0, -1.0, 6.0, -9.0, -1.0, 6.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][2], mat2x4(-8.0, -2.0, -9.0, 0.0, 5.0, -8.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][0], mat2x4(-4.0, 0.0, -1.0, 2.0, 8.0, 9.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][1], mat2x4(5.0, 1.0, 5.0, 8.0, -4.0, -5.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][2], mat2x4(1.0, 9.0, -1.0, 1.0, -2.0, -4.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][0], mat2x4(-3.0, 3.0, -7.0, 1.0, 1.0, 1.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][1], mat2x4(4.0, -5.0, 0.0, -6.0, 4.0, -3.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][2], mat2x4(-9.0, 1.0, 6.0, -4.0, 3.0, -3.0, 8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(-7.0, -1.0, 8.0, 2.0));
	var[0][0][0][1] = (vec4(-1.0, 2.0, 7.0, -9.0));
	var[0][0][1][0] = (vec4(-9.0, -5.0, 4.0, 7.0));
	var[0][0][1][1] = (vec4(5.0, 8.0, -8.0, -8.0));
	var[0][0][2][0] = (vec4(6.0, -3.0, 7.0, 0.0));
	var[0][0][2][1] = (vec4(4.0, 6.0, -4.0, 0.0));
	var[0][1][0][0] = (vec4(5.0, 0.0, 0.0, -1.0));
	var[0][1][0][1] = (vec4(9.0, 1.0, -4.0, 7.0));
	var[0][1][1][0] = (vec4(8.0, 0.0, -5.0, -4.0));
	var[0][1][1][1] = (vec4(2.0, 1.0, -9.0, 5.0));
	var[0][1][2][0] = (vec4(-5.0, 0.0, 5.0, 7.0));
	var[0][1][2][1] = (vec4(8.0, -8.0, 8.0, 1.0));
	var[1][0][0][0] = (vec4(-5.0, 8.0, -9.0, -8.0));
	var[1][0][0][1] = (vec4(7.0, -7.0, -8.0, -6.0));
	var[1][0][1][0] = (vec4(-9.0, -8.0, 1.0, -2.0));
	var[1][0][1][1] = (vec4(7.0, -6.0, -9.0, 9.0));
	var[1][0][2][0] = (vec4(4.0, -6.0, 0.0, -3.0));
	var[1][0][2][1] = (vec4(-7.0, -7.0, 2.0, -1.0));
	var[1][1][0][0] = (vec4(6.0, -3.0, -3.0, -4.0));
	var[1][1][0][1] = (vec4(-9.0, 1.0, 6.0, -4.0));
	var[1][1][1][0] = (vec4(-8.0, -4.0, -9.0, -8.0));
	var[1][1][1][1] = (vec4(-1.0, -1.0, 1.0, -7.0));
	var[1][1][2][0] = (vec4(7.0, -4.0, -6.0, -8.0));
	var[1][1][2][1] = (vec4(-8.0, -1.0, -2.0, 1.0));
	var[2][0][0][0] = (vec4(6.0, -1.0, -5.0, 1.0));
	var[2][0][0][1] = (vec4(-1.0, 8.0, 7.0, 6.0));
	var[2][0][1][0] = (vec4(-9.0, 8.0, 2.0, 1.0));
	var[2][0][1][1] = (vec4(9.0, -7.0, 6.0, -8.0));
	var[2][0][2][0] = (vec4(-2.0, -8.0, 6.0, 9.0));
	var[2][0][2][1] = (vec4(5.0, 5.0, -1.0, -1.0));
	var[2][1][0][0] = (vec4(-8.0, 3.0, -6.0, 6.0));
	var[2][1][0][1] = (vec4(2.0, 1.0, 3.0, -6.0));
	var[2][1][1][0] = (vec4(-1.0, -4.0, -2.0, 6.0));
	var[2][1][1][1] = (vec4(6.0, 2.0, 1.0, 2.0));
	var[2][1][2][0] = (vec4(8.0, 9.0, 4.0, -4.0));
	var[2][1][2][1] = (vec4(5.0, -4.0, 9.0, 9.0));
	var[3][0][0][0] = (vec4(4.0, -3.0, 7.0, -9.0));
	var[3][0][0][1] = (vec4(-3.0, 9.0, 2.0, 6.0));
	var[3][0][1][0] = (vec4(6.0, 1.0, 5.0, -4.0));
	var[3][0][1][1] = (vec4(1.0, -6.0, 2.0, 6.0));
	var[3][0][2][0] = (vec4(-8.0, 7.0, 7.0, -5.0));
	var[3][0][2][1] = (vec4(-8.0, 0.0, -6.0, -4.0));
	var[3][1][0][0] = (vec4(-8.0, 6.0, 2.0, 3.0));
	var[3][1][0][1] = (vec4(-1.0, 2.0, 2.0, -7.0));
	var[3][1][1][0] = (vec4(9.0, 2.0, -3.0, 1.0));
	var[3][1][1][1] = (vec4(5.0, 2.0, -3.0, 3.0));
	var[3][1][2][0] = (vec4(-9.0, -1.0, -7.0, 1.0));
	var[3][1][2][1] = (vec4(1.0, 5.0, -1.0, -3.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, row_major, binding = 1) buffer Block
{
	highp mat4x3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0][0][0], mat4x3(-1.0, -7.0, 8.0, 5.0, -5.0, 7.0, -9.0, 5.0, 0.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(7.0, -9.0, 6.0, 0.0, -8.0, -3.0, -6.0, 8.0, 8.0, -7.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][2], mat4x3(1.0, 0.0, 7.0, -2.0, 4.0, 9.0, 9.0, 8.0, -2.0, -2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(2.0, -3.0, 7.0, -7.0, -3.0, -9.0, 0.0, 4.0, 2.0, -2.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(7.0, -3.0, 5.0, -8.0, 3.0, -8.0, 3.0, 6.0, 3.0, 7.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][2], mat4x3(0.0, -9.0, -2.0, -4.0, -7.0, 3.0, -9.0, 6.0, -1.0, 1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(-9.0, -4.0, -6.0, -5.0, 7.0, 2.0, -7.0, 7.0, -9.0, -2.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(-9.0, 7.0, -2.0, 5.0, -7.0, -5.0, 3.0, -9.0, 2.0, -7.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][2], mat4x3(3.0, -7.0, -4.0, -1.0, -5.0, 4.0, -4.0, -9.0, 6.0, 6.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(3.0, 8.0, -7.0, -3.0, 4.0, 9.0, 4.0, -3.0, -3.0, 0.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(-9.0, -2.0, 5.0, 9.0, -9.0, 7.0, -7.0, -8.0, 2.0, -8.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][2], mat4x3(4.0, -3.0, 9.0, -4.0, 9.0, 3.0, -2.0, 9.0, 0.0, -3.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(-3.0, 7.0, 3.0, 4.0, -3.0, -1.0, 0.0, -4.0, 3.0, 9.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(5.0, -6.0, -2.0, 1.0, 5.0, -8.0, -3.0, -1.0, 1.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][2], mat4x3(6.0, 1.0, 3.0, -8.0, 4.0, -1.0, -3.0, 8.0, -6.0, 9.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(3.0, 2.0, -1.0, -2.0, -5.0, 9.0, -1.0, -2.0, 6.0, -5.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(0.0, 6.0, 8.0, -6.0, -9.0, 1.0, 7.0, -9.0, 1.0, 3.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][2], mat4x3(8.0, 4.0, -9.0, 4.0, -6.0, 5.0, 3.0, -4.0, 0.0, -3.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][0], mat4x3(5.0, -6.0, 2.0, -3.0, -5.0, 5.0, -4.0, -7.0, 2.0, 2.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][1], mat4x3(5.0, 3.0, -8.0, 6.0, 8.0, 5.0, -3.0, -3.0, 3.0, 3.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][2], mat4x3(-7.0, -1.0, 3.0, -3.0, 2.0, 9.0, 0.0, -7.0, 3.0, -1.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][0], mat4x3(6.0, -5.0, -8.0, -6.0, -3.0, 7.0, 0.0, 0.0, 0.0, -8.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][1], mat4x3(6.0, -4.0, -1.0, -9.0, -9.0, 1.0, -3.0, -7.0, 9.0, -8.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][2], mat4x3(2.0, 2.0, -6.0, -5.0, 6.0, -7.0, -8.0, -1.0, 7.0, -2.0, 1.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4x3(-2.0, 9.0, 6.0, 4.0, 4.0, 3.0, 2.0, 4.0, 6.0, 7.0, -2.0, 2.0));
	var[0][0][1] = (mat4x3(-8.0, -2.0, 9.0, 9.0, 6.0, -2.0, 4.0, -7.0, 6.0, -7.0, 9.0, 6.0));
	var[0][0][2] = (mat4x3(6.0, 8.0, 8.0, 9.0, -6.0, 5.0, -3.0, 9.0, -5.0, 9.0, 9.0, -3.0));
	var[0][1][0] = (mat4x3(7.0, -6.0, 6.0, 6.0, 0.0, 6.0, -2.0, 0.0, 4.0, -2.0, -4.0, 0.0));
	var[0][1][1] = (mat4x3(0.0, 0.0, 8.0, 0.0, 5.0, -8.0, -7.0, 0.0, 2.0, 1.0, 6.0, -6.0));
	var[0][1][2] = (mat4x3(-9.0, 8.0, 6.0, 9.0, -9.0, 5.0, -2.0, 2.0, -2.0, 2.0, -6.0, -1.0));
	var[1][0][0] = (mat4x3(-7.0, 2.0, -4.0, -9.0, 7.0, 8.0, 8.0, 3.0, -3.0, -1.0, -5.0, 5.0));
	var[1][0][1] = (mat4x3(0.0, 1.0, -1.0, -6.0, -2.0, 6.0, -4.0, -8.0, -9.0, 2.0, -1.0, 3.0));
	var[1][0][2] = (mat4x3(-9.0, -1.0, -4.0, -9.0, 1.0, -1.0, -6.0, 4.0, -3.0, 4.0, -4.0, 4.0));
	var[1][1][0] = (mat4x3(1.0, -7.0, -5.0, 9.0, -4.0, -7.0, -9.0, 7.0, -4.0, 9.0, -3.0, 3.0));
	var[1][1][1] = (mat4x3(7.0, -7.0, -2.0, -5.0, 7.0, 7.0, -1.0, 6.0, -1.0, 6.0, -9.0, 8.0));
	var[1][1][2] = (mat4x3(8.0, 7.0, -8.0, 1.0, 9.0, -1.0, -8.0, -3.0, 7.0, 9.0, -5.0, 8.0));
	var[2][0][0] = (mat4x3(0.0, 5.0, -1.0, -3.0, 9.0, 3.0, -4.0, 3.0, -6.0, -2.0, -6.0, 8.0));
	var[2][0][1] = (mat4x3(2.0, 9.0, -6.0, 5.0, 8.0, -3.0, 1.0, 2.0, -1.0, 3.0, -5.0, -5.0));
	var[2][0][2] = (mat4x3(8.0, 9.0, 0.0, 1.0, 3.0, 4.0, 4.0, 7.0, -1.0, 4.0, 0.0, 6.0));
	var[2][1][0] = (mat4x3(-3.0, -3.0, 9.0, 5.0, -4.0, 6.0, 4.0, -2.0, 9.0, 0.0, -7.0, 3.0));
	var[2][1][1] = (mat4x3(5.0, 0.0, 3.0, 8.0, 3.0, -1.0, 5.0, -3.0, 7.0, 3.0, -2.0, 5.0));
	var[2][1][2] = (mat4x3(6.0, -8.0, -9.0, -9.0, 6.0, 1.0, 0.0, 5.0, 1.0, -6.0, 1.0, 8.0));
	var[3][0][0] = (mat4x3(2.0, 7.0, 3.0, 1.0, 4.0, -1.0, -2.0, -5.0, -9.0, -2.0, -1.0, -6.0));
	var[3][0][1] = (mat4x3(-1.0, 7.0, 7.0, 4.0, 3.0, -2.0, -1.0, -2.0, -3.0, -4.0, 4.0, -6.0));
	var[3][0][2] = (mat4x3(9.0, 4.0, 1.0, -2.0, 6.0, 5.0, -8.0, 9.0, 8.0, -5.0, 6.0, 0.0));
	var[3][1][0] = (mat4x3(5.0, 2.0, 7.0, -9.0, -9.0, 7.0, -3.0, 4.0, -7.0, -4.0, -8.0, -6.0));
	var[3][1][1] = (mat4x3(-1.0, 7.0, 7.0, 4.0, -5.0, -2.0, 5.0, -3.0, -9.0, 0.0, 8.0, 3.0));
	var[3][1][2] = (mat4x3(7.0, -1.0, -2.0, 1.0, 4.0, -8.0, 6.0, 1.0, 4.0, -6.0, -1.0, 0.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, binding = 1) buffer Block
{
	u16vec4 var[4][2][3];
};

bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(var[0][0][0]), uvec4(6u, 0u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[0][0][1]), uvec4(8u, 7u, 5u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[0][0][2]), uvec4(8u, 7u, 1u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[0][1][0]), uvec4(0u, 2u, 0u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[0][1][1]), uvec4(9u, 8u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[0][1][2]), uvec4(5u, 2u, 3u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][0][0]), uvec4(5u, 0u, 5u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][0][1]), uvec4(9u, 4u, 6u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][0][2]), uvec4(5u, 3u, 6u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][1][0]), uvec4(5u, 9u, 1u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][1][1]), uvec4(6u, 2u, 0u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][1][2]), uvec4(5u, 5u, 6u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][0][0]), uvec4(9u, 2u, 2u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][0][1]), uvec4(9u, 9u, 3u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][0][2]), uvec4(0u, 0u, 4u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][1][0]), uvec4(2u, 6u, 2u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][1][1]), uvec4(3u, 7u, 0u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][1][2]), uvec4(6u, 4u, 5u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[3][0][0]), uvec4(1u, 7u, 1u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[3][0][1]), uvec4(8u, 7u, 4u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[3][0][2]), uvec4(7u, 0u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[3][1][0]), uvec4(6u, 4u, 0u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[3][1][1]), uvec4(2u, 9u, 7u, 6u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[3][1][2]), uvec4(8u, 1u, 6u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = u16vec4(uvec4(0u, 6u, 9u, 4u));
	var[0][0][1] = u16vec4(uvec4(5u, 0u, 1u, 0u));
	var[0][0][2] = u16vec4(uvec4(7u, 6u, 5u, 9u));
	var[0][1][0] = u16vec4(uvec4(6u, 9u, 4u, 2u));
	var[0][1][1] = u16vec4(uvec4(9u, 7u, 6u, 2u));
	var[0][1][2] = u16vec4(uvec4(8u, 4u, 6u, 2u));
	var[1][0][0] = u16vec4(uvec4(8u, 3u, 6u, 1u));
	var[1][0][1] = u16vec4(uvec4(7u, 9u, 3u, 8u));
	var[1][0][2] = u16vec4(uvec4(1u, 4u, 3u, 9u));
	var[1][1][0] = u16vec4(uvec4(2u, 1u, 0u, 1u));
	var[1][1][1] = u16vec4(uvec4(9u, 9u, 4u, 6u));
	var[1][1][2] = u16vec4(uvec4(4u, 4u, 2u, 8u));
	var[2][0][0] = u16vec4(uvec4(9u, 3u, 0u, 2u));
	var[2][0][1] = u16vec4(uvec4(3u, 5u, 0u, 2u));
	var[2][0][2] = u16vec4(uvec4(5u, 1u, 5u, 5u));
	var[2][1][0] = u16vec4(uvec4(7u, 8u, 2u, 8u));
	var[2][1][1] = u16vec4(uvec4(0u, 3u, 6u, 3u));
	var[2][1][2] = u16vec4(uvec4(4u, 0u, 8u, 2u));
	var[3][0][0] = u16vec4(uvec4(4u, 0u, 8u, 4u));
	var[3][0][1] = u16vec4(uvec4(0u, 3u, 7u, 1u));
	var[3][0][2] = u16vec4(uvec4(1u, 8u, 4u, 7u));
	var[3][1][0] = u16vec4(uvec4(3u, 0u, 4u, 2u));
	var[3][1][1] = u16vec4(uvec4(4u, 7u, 1u, 9u));
	var[3][1][2] = u16vec4(uvec4(5u, 6u, 9u, 9u));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, binding = 1) buffer Block
{
	bvec3 var[4][2][3];
};

bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((var[0][0][0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((var[0][0][1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((var[0][0][2]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((var[0][1][0]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((var[0][1][1]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((var[0][1][2]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((var[1][0][0]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((var[1][0][1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((var[1][0][2]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((var[1][1][0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((var[1][1][1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((var[1][1][2]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((var[2][0][0]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((var[2][0][1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((var[2][0][2]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((var[2][1][0]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((var[2][1][1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((var[2][1][2]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((var[3][0][0]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((var[3][0][1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((var[3][0][2]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((var[3][1][0]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((var[3][1][1]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((var[3][1][2]), bvec3(false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (bvec3(true, true, false));
	var[0][0][1] = (bvec3(false, true, true));
	var[0][0][2] = (bvec3(false, false, false));
	var[0][1][0] = (bvec3(false, false, true));
	var[0][1][1] = (bvec3(true, false, true));
	var[0][1][2] = (bvec3(false, false, false));
	var[1][0][0] = (bvec3(true, false, false));
	var[1][0][1] = (bvec3(true, true, true));
	var[1][0][2] = (bvec3(false, true, true));
	var[1][1][0] = (bvec3(true, true, false));
	var[1][1][1] = (bvec3(false, false, true));
	var[1][1][2] = (bvec3(false, false, true));
	var[2][0][0] = (bvec3(false, true, true));
	var[2][0][1] = (bvec3(true, true, true));
	var[2][0][2] = (bvec3(true, true, true));
	var[2][1][0] = (bvec3(true, true, false));
	var[2][1][1] = (bvec3(false, true, false));
	var[2][1][2] = (bvec3(false, true, false));
	var[3][0][0] = (bvec3(true, false, false));
	var[3][0][1] = (bvec3(false, true, false));
	var[3][0][2] = (bvec3(true, false, false));
	var[3][1][0] = (bvec3(false, false, false));
	var[3][1][1] = (bvec3(true, true, false));
	var[3][1][2] = (bvec3(false, true, false));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, row_major, binding = 1) buffer Block
{
	highp mat4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0][0][0], mat4(-8.0, 3.0, 4.0, 4.0, -5.0, 8.0, 6.0, 7.0, 4.0, 5.0, 7.0, -3.0, 0.0, 2.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(-1.0, -2.0, -3.0, 1.0, -9.0, -9.0, -6.0, 5.0, 6.0, 7.0, 6.0, 1.0, -8.0, -3.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4(var[0][0][2], mat4(6.0, 0.0, 5.0, -6.0, -1.0, -6.0, -1.0, 6.0, 1.0, -1.0, 3.0, -1.0, 6.0, 4.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(1.0, 6.0, -6.0, 7.0, 9.0, 3.0, 0.0, 7.0, 0.0, 9.0, -9.0, 1.0, 4.0, -9.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(7.0, 7.0, -6.0, -6.0, 8.0, -2.0, 4.0, -6.0, 7.0, -4.0, -8.0, -2.0, -2.0, 3.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4(var[0][1][2], mat4(0.0, -2.0, -9.0, 6.0, -2.0, -1.0, 8.0, 5.0, 1.0, 7.0, 0.0, -1.0, 1.0, -2.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(-3.0, 8.0, -3.0, -7.0, -4.0, -6.0, -1.0, 4.0, 9.0, -1.0, 6.0, -4.0, 0.0, -7.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(3.0, -9.0, -5.0, 9.0, -5.0, -7.0, 5.0, 0.0, -5.0, 4.0, 7.0, 2.0, -1.0, 9.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat4(var[1][0][2], mat4(6.0, -4.0, -9.0, 2.0, 1.0, 8.0, -6.0, 0.0, -7.0, -8.0, 5.0, -9.0, -9.0, -5.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(-9.0, -7.0, 3.0, -8.0, 8.0, 3.0, 6.0, -3.0, 8.0, -1.0, 8.0, 0.0, 5.0, 7.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(0.0, 6.0, -8.0, -6.0, 7.0, 9.0, 7.0, -8.0, 2.0, 6.0, 0.0, 5.0, -8.0, 5.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4(var[1][1][2], mat4(0.0, 8.0, 3.0, 5.0, -1.0, 7.0, -5.0, 0.0, -3.0, -6.0, -8.0, -6.0, 6.0, -3.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(5.0, -7.0, -8.0, -6.0, 7.0, 3.0, 0.0, -4.0, 5.0, -2.0, 3.0, -9.0, 2.0, -2.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(-6.0, -8.0, 2.0, -5.0, 0.0, -2.0, 7.0, -3.0, 4.0, 4.0, 4.0, 5.0, 7.0, -1.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4(var[2][0][2], mat4(-1.0, 5.0, 8.0, -3.0, -9.0, 9.0, -4.0, 5.0, 7.0, -3.0, 5.0, 6.0, -8.0, 2.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(0.0, 3.0, 3.0, 8.0, 3.0, 7.0, -3.0, 1.0, -8.0, 3.0, 7.0, -3.0, 7.0, 5.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(3.0, -1.0, 1.0, 1.0, -3.0, 9.0, 9.0, -5.0, 5.0, -1.0, 6.0, -1.0, -4.0, -9.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat4(var[2][1][2], mat4(-2.0, -9.0, 2.0, 5.0, 5.0, 4.0, 1.0, 4.0, -7.0, -4.0, -2.0, -8.0, -7.0, 9.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat4(var[3][0][0], mat4(-3.0, 3.0, 3.0, -3.0, -6.0, -5.0, 3.0, -7.0, -3.0, 7.0, -7.0, 2.0, 7.0, -9.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat4(var[3][0][1], mat4(-8.0, -8.0, 8.0, -1.0, -8.0, -1.0, 7.0, 1.0, 7.0, 3.0, -9.0, -3.0, 2.0, -2.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[3][0][2], mat4(8.0, 8.0, -7.0, -5.0, 0.0, -1.0, -6.0, -9.0, -8.0, -9.0, -1.0, -7.0, -3.0, -7.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4(var[3][1][0], mat4(-9.0, 1.0, 7.0, -3.0, -8.0, 7.0, 0.0, 6.0, -9.0, -5.0, 9.0, -7.0, 6.0, -9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4(var[3][1][1], mat4(-3.0, -7.0, -9.0, 0.0, 6.0, 2.0, -6.0, -9.0, -4.0, -6.0, 3.0, 4.0, 7.0, 1.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(var[3][1][2], mat4(-6.0, 7.0, 3.0, 2.0, 4.0, 8.0, 8.0, -3.0, -8.0, -1.0, -7.0, -6.0, 7.0, -3.0, -6.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(-9.0, 0.0, -1.0, -4.0));
	var[0][0][0][1] = (vec4(-9.0, -4.0, -9.0, -5.0));
	var[0][0][0][2] = (vec4(-2.0, 9.0, 0.0, -8.0));
	var[0][0][0][3] = (vec4(-6.0, -3.0, -8.0, 3.0));
	var[0][0][1][0] = (vec4(4.0, 9.0, 4.0, -3.0));
	var[0][0][1][1] = (vec4(7.0, -9.0, 6.0, 5.0));
	var[0][0][1][2] = (vec4(6.0, -1.0, -3.0, -3.0));
	var[0][0][1][3] = (vec4(-9.0, 3.0, -9.0, 0.0));
	var[0][0][2][0] = (vec4(1.0, -4.0, -6.0, 5.0));
	var[0][0][2][1] = (vec4(2.0, 1.0, 9.0, -4.0));
	var[0][0][2][2] = (vec4(-7.0, 7.0, 0.0, 7.0));
	var[0][0][2][3] = (vec4(9.0, 9.0, -5.0, -7.0));
	var[0][1][0][0] = (vec4(-1.0, -6.0, -8.0, -9.0));
	var[0][1][0][1] = (vec4(0.0, 3.0, 6.0, -1.0));
	var[0][1][0][2] = (vec4(4.0, 6.0, 8.0, 1.0));
	var[0][1][0][3] = (vec4(9.0, -4.0, 7.0, 7.0));
	var[0][1][1][0] = (vec4(2.0, -1.0, -8.0, 9.0));
	var[0][1][1][1] = (vec4(-1.0, 7.0, -4.0, 2.0));
	var[0][1][1][2] = (vec4(9.0, 2.0, -2.0, -1.0));
	var[0][1][1][3] = (vec4(7.0, 3.0, -6.0, 0.0));
	var[0][1][2][0] = (vec4(-7.0, -8.0, -7.0, 8.0));
	var[0][1][2][1] = (vec4(5.0, 7.0, -3.0, -2.0));
	var[0][1][2][2] = (vec4(9.0, -5.0, -2.0, -2.0));
	var[0][1][2][3] = (vec4(2.0, 4.0, -1.0, 9.0));
	var[1][0][0][0] = (vec4(-9.0, 5.0, 8.0, 6.0));
	var[1][0][0][1] = (vec4(4.0, 6.0, -1.0, -7.0));
	var[1][0][0][2] = (vec4(7.0, 8.0, 5.0, -1.0));
	var[1][0][0][3] = (vec4(8.0, 2.0, -8.0, 0.0));
	var[1][0][1][0] = (vec4(-9.0, -1.0, -5.0, 7.0));
	var[1][0][1][1] = (vec4(3.0, 1.0, 2.0, 2.0));
	var[1][0][1][2] = (vec4(-3.0, -7.0, 1.0, 0.0));
	var[1][0][1][3] = (vec4(9.0, 5.0, -2.0, 6.0));
	var[1][0][2][0] = (vec4(-9.0, 1.0, 2.0, -3.0));
	var[1][0][2][1] = (vec4(-2.0, -2.0, -8.0, -4.0));
	var[1][0][2][2] = (vec4(7.0, -4.0, -1.0, 2.0));
	var[1][0][2][3] = (vec4(7.0, 7.0, 2.0, 8.0));
	var[1][1][0][0] = (vec4(3.0, 3.0, 4.0, -8.0));
	var[1][1][0][1] = (vec4(-3.0, -9.0, 9.0, -7.0));
	var[1][1][0][2] = (vec4(-7.0, 9.0, -4.0, 0.0));
	var[1][1][0][3] = (vec4(-4.0, -3.0, 0.0, 6.0));
	var[1][1][1][0] = (vec4(-5.0, -7.0, 3.0, -9.0));
	var[1][1][1][1] = (vec4(4.0, 5.0, 0.0, -6.0));
	var[1][1][1][2] = (vec4(7.0, 4.0, 1.0, 9.0));
	var[1][1][1][3] = (vec4(-8.0, 8.0, 7.0, 4.0));
	var[1][1][2][0] = (vec4(-1.0, 5.0, 9.0, -2.0));
	var[1][1][2][1] = (vec4(-5.0, -8.0, 2.0, -5.0));
	var[1][1][2][2] = (vec4(3.0, -8.0, -1.0, -5.0));
	var[1][1][2][3] = (vec4(-6.0, -2.0, 3.0, 0.0));
	var[2][0][0][0] = (vec4(-5.0, 9.0, 9.0, 4.0));
	var[2][0][0][1] = (vec4(6.0, -2.0, -1.0, -2.0));
	var[2][0][0][2] = (vec4(0.0, 5.0, -4.0, 5.0));
	var[2][0][0][3] = (vec4(8.0, -8.0, 9.0, -3.0));
	var[2][0][1][0] = (vec4(4.0, -8.0, -1.0, 0.0));
	var[2][0][1][1] = (vec4(-3.0, -4.0, -7.0, 1.0));
	var[2][0][1][2] = (vec4(4.0, -2.0, 1.0, -8.0));
	var[2][0][1][3] = (vec4(-8.0, 5.0, 4.0, 7.0));
	var[2][0][2][0] = (vec4(7.0, -2.0, -6.0, 9.0));
	var[2][0][2][1] = (vec4(-7.0, -5.0, 2.0, 2.0));
	var[2][0][2][2] = (vec4(4.0, 8.0, 4.0, -9.0));
	var[2][0][2][3] = (vec4(0.0, -9.0, 0.0, 0.0));
	var[2][1][0][0] = (vec4(1.0, -3.0, -1.0, 9.0));
	var[2][1][0][1] = (vec4(-4.0, -5.0, 6.0, 9.0));
	var[2][1][0][2] = (vec4(-5.0, -7.0, 1.0, 2.0));
	var[2][1][0][3] = (vec4(-7.0, 2.0, -8.0, 9.0));
	var[2][1][1][0] = (vec4(-1.0, 2.0, 4.0, 1.0));
	var[2][1][1][1] = (vec4(5.0, -8.0, -7.0, 3.0));
	var[2][1][1][2] = (vec4(-5.0, 2.0, 5.0, 7.0));
	var[2][1][1][3] = (vec4(-9.0, 2.0, -7.0, 9.0));
	var[2][1][2][0] = (vec4(-7.0, 5.0, -6.0, -3.0));
	var[2][1][2][1] = (vec4(6.0, -2.0, 9.0, 1.0));
	var[2][1][2][2] = (vec4(0.0, -3.0, -6.0, -8.0));
	var[2][1][2][3] = (vec4(-4.0, 0.0, -2.0, 0.0));
	var[3][0][0][0] = (vec4(9.0, -1.0, -1.0, -3.0));
	var[3][0][0][1] = (vec4(-9.0, -6.0, -8.0, 4.0));
	var[3][0][0][2] = (vec4(-6.0, 9.0, -8.0, 3.0));
	var[3][0][0][3] = (vec4(0.0, 1.0, -1.0, -7.0));
	var[3][0][1][0] = (vec4(-9.0, -4.0, 4.0, 6.0));
	var[3][0][1][1] = (vec4(4.0, 9.0, 4.0, -4.0));
	var[3][0][1][2] = (vec4(3.0, -1.0, 2.0, 8.0));
	var[3][0][1][3] = (vec4(-3.0, -6.0, -4.0, 0.0));
	var[3][0][2][0] = (vec4(2.0, -1.0, 1.0, -1.0));
	var[3][0][2][1] = (vec4(8.0, 5.0, 3.0, 0.0));
	var[3][0][2][2] = (vec4(-2.0, 0.0, 7.0, -5.0));
	var[3][0][2][3] = (vec4(6.0, 0.0, 6.0, -6.0));
	var[3][1][0][0] = (vec4(-8.0, 9.0, 5.0, 6.0));
	var[3][1][0][1] = (vec4(-9.0, 1.0, 2.0, 8.0));
	var[3][1][0][2] = (vec4(2.0, 9.0, 8.0, 5.0));
	var[3][1][0][3] = (vec4(-8.0, 4.0, -3.0, -4.0));
	var[3][1][1][0] = (vec4(-5.0, -3.0, 4.0, -1.0));
	var[3][1][1][1] = (vec4(5.0, -5.0, 4.0, 2.0));
	var[3][1][1][2] = (vec4(-4.0, -6.0, -2.0, 5.0));
	var[3][1][1][3] = (vec4(-1.0, -4.0, 1.0, 6.0));
	var[3][1][2][0] = (vec4(-1.0, 0.0, 3.0, -1.0));
	var[3][1][2][1] = (vec4(9.0, 4.0, 8.0, 0.0));
	var[3][1][2][2] = (vec4(0.0, -3.0, -3.0, 1.0));
	var[3][1][2][3] = (vec4(4.0, 6.0, -3.0, -5.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, row_major, binding = 1) buffer Block
{
	highp mat3x2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0][0][0], mat3x2(-4.0, 6.0, 0.0, 6.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][1], mat3x2(5.0, -1.0, 1.0, 7.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][2], mat3x2(4.0, -5.0, -2.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][0], mat3x2(-4.0, -8.0, -7.0, -9.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][1], mat3x2(-1.0, -4.0, -4.0, 6.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][2], mat3x2(-8.0, 8.0, -4.0, -8.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][0], mat3x2(-2.0, -1.0, 5.0, 2.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][1], mat3x2(9.0, -5.0, 7.0, 6.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][2], mat3x2(-1.0, -4.0, 0.0, -2.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][0], mat3x2(-3.0, -7.0, -5.0, -7.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][1], mat3x2(0.0, -8.0, -1.0, 9.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][2], mat3x2(-7.0, -9.0, 6.0, -5.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][0], mat3x2(7.0, 3.0, -1.0, 6.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][1], mat3x2(-8.0, -5.0, 9.0, -3.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][2], mat3x2(-4.0, 6.0, -7.0, 0.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][0], mat3x2(0.0, 9.0, -1.0, -2.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][1], mat3x2(4.0, 8.0, 2.0, -7.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][2], mat3x2(2.0, 6.0, -9.0, 3.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][0], mat3x2(-9.0, 0.0, 9.0, -8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][1], mat3x2(-7.0, -5.0, 3.0, -3.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][2], mat3x2(-3.0, -2.0, 3.0, -8.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][0], mat3x2(-6.0, -1.0, -5.0, 1.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][1], mat3x2(2.0, -1.0, -4.0, 7.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][2], mat3x2(5.0, 5.0, 4.0, -6.0, -5.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec2(9.0, -4.0));
	var[0][0][0][1] = (vec2(-7.0, 8.0));
	var[0][0][0][2] = (vec2(-2.0, -9.0));
	var[0][0][1][0] = (vec2(-1.0, 7.0));
	var[0][0][1][1] = (vec2(-3.0, -3.0));
	var[0][0][1][2] = (vec2(-8.0, 2.0));
	var[0][0][2][0] = (vec2(-2.0, -1.0));
	var[0][0][2][1] = (vec2(-3.0, -3.0));
	var[0][0][2][2] = (vec2(-4.0, 5.0));
	var[0][1][0][0] = (vec2(9.0, 4.0));
	var[0][1][0][1] = (vec2(-8.0, -6.0));
	var[0][1][0][2] = (vec2(4.0, -6.0));
	var[0][1][1][0] = (vec2(-9.0, -3.0));
	var[0][1][1][1] = (vec2(8.0, 9.0));
	var[0][1][1][2] = (vec2(4.0, -8.0));
	var[0][1][2][0] = (vec2(0.0, -4.0));
	var[0][1][2][1] = (vec2(6.0, -1.0));
	var[0][1][2][2] = (vec2(-7.0, 8.0));
	var[1][0][0][0] = (vec2(9.0, 7.0));
	var[1][0][0][1] = (vec2(-4.0, 7.0));
	var[1][0][0][2] = (vec2(1.0, 6.0));
	var[1][0][1][0] = (vec2(-8.0, 9.0));
	var[1][0][1][1] = (vec2(8.0, 1.0));
	var[1][0][1][2] = (vec2(6.0, 8.0));
	var[1][0][2][0] = (vec2(-1.0, 2.0));
	var[1][0][2][1] = (vec2(1.0, -1.0));
	var[1][0][2][2] = (vec2(0.0, 3.0));
	var[1][1][0][0] = (vec2(4.0, 2.0));
	var[1][1][0][1] = (vec2(2.0, -3.0));
	var[1][1][0][2] = (vec2(1.0, -6.0));
	var[1][1][1][0] = (vec2(7.0, 3.0));
	var[1][1][1][1] = (vec2(-7.0, 5.0));
	var[1][1][1][2] = (vec2(2.0, -9.0));
	var[1][1][2][0] = (vec2(-2.0, -8.0));
	var[1][1][2][1] = (vec2(-9.0, 5.0));
	var[1][1][2][2] = (vec2(-2.0, 1.0));
	var[2][0][0][0] = (vec2(-3.0, -2.0));
	var[2][0][0][1] = (vec2(-9.0, -8.0));
	var[2][0][0][2] = (vec2(-8.0, 4.0));
	var[2][0][1][0] = (vec2(-2.0, 9.0));
	var[2][0][1][1] = (vec2(-1.0, 3.0));
	var[2][0][1][2] = (vec2(-2.0, 9.0));
	var[2][0][2][0] = (vec2(-2.0, -4.0));
	var[2][0][2][1] = (vec2(-1.0, 9.0));
	var[2][0][2][2] = (vec2(-9.0, -4.0));
	var[2][1][0][0] = (vec2(2.0, -5.0));
	var[2][1][0][1] = (vec2(2.0, 8.0));
	var[2][1][0][2] = (vec2(1.0, 5.0));
	var[2][1][1][0] = (vec2(-2.0, 0.0));
	var[2][1][1][1] = (vec2(-7.0, 5.0));
	var[2][1][1][2] = (vec2(-8.0, 2.0));
	var[2][1][2][0] = (vec2(6.0, 3.0));
	var[2][1][2][1] = (vec2(0.0, 1.0));
	var[2][1][2][2] = (vec2(7.0, -7.0));
	var[3][0][0][0] = (vec2(-3.0, -2.0));
	var[3][0][0][1] = (vec2(7.0, -5.0));
	var[3][0][0][2] = (vec2(-5.0, 0.0));
	var[3][0][1][0] = (vec2(4.0, -4.0));
	var[3][0][1][1] = (vec2(5.0, 5.0));
	var[3][0][1][2] = (vec2(2.0, -3.0));
	var[3][0][2][0] = (vec2(-5.0, -3.0));
	var[3][0][2][1] = (vec2(-7.0, 6.0));
	var[3][0][2][2] = (vec2(-6.0, 8.0));
	var[3][1][0][0] = (vec2(-4.0, 0.0));
	var[3][1][0][1] = (vec2(8.0, -1.0));
	var[3][1][0][2] = (vec2(-4.0, -1.0));
	var[3][1][1][0] = (vec2(-3.0, 3.0));
	var[3][1][1][1] = (vec2(0.0, 5.0));
	var[3][1][1][2] = (vec2(-6.0, 4.0));
	var[3][1][2][0] = (vec2(-1.0, 1.0));
	var[3][1][2][1] = (vec2(-1.0, -6.0));
	var[3][1][2][2] = (vec2(3.0, -5.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, row_major, binding = 1) buffer Block
{
	highp mat3x4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0][0][0], mat3x4(-1.0, -2.0, -5.0, -5.0, -8.0, 2.0, -9.0, 8.0, -1.0, -4.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][1], mat3x4(2.0, 9.0, -2.0, 5.0, 1.0, 4.0, -5.0, 3.0, -6.0, 9.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][2], mat3x4(-2.0, 8.0, -3.0, 3.0, 5.0, 1.0, -8.0, 4.0, 7.0, 5.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][0], mat3x4(-7.0, -8.0, -1.0, 5.0, 6.0, -6.0, -4.0, 9.0, -5.0, 3.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][1], mat3x4(-9.0, 3.0, 1.0, 8.0, 7.0, 0.0, 7.0, 9.0, -1.0, 9.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][2], mat3x4(3.0, 8.0, 0.0, -6.0, -6.0, -1.0, -2.0, 5.0, 1.0, -3.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][0], mat3x4(-3.0, 1.0, 4.0, 2.0, -2.0, -6.0, -4.0, 8.0, -8.0, -1.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][1], mat3x4(6.0, -6.0, -8.0, 8.0, 4.0, 9.0, 6.0, -6.0, 9.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][2], mat3x4(2.0, 8.0, -9.0, 0.0, 3.0, 2.0, 4.0, -9.0, -1.0, 1.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][0], mat3x4(0.0, 8.0, -9.0, 6.0, -5.0, 3.0, -8.0, -1.0, -9.0, 3.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][1], mat3x4(-8.0, 8.0, -1.0, 9.0, 1.0, -5.0, -4.0, 3.0, 5.0, 7.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][2], mat3x4(-2.0, 6.0, 5.0, 9.0, 2.0, -3.0, 3.0, 8.0, 8.0, 6.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][0], mat3x4(-9.0, -9.0, 1.0, 6.0, -2.0, -2.0, -2.0, 1.0, 3.0, 5.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][1], mat3x4(-6.0, 1.0, -4.0, 2.0, 9.0, -9.0, -2.0, 6.0, 1.0, 4.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][2], mat3x4(-6.0, 5.0, 3.0, -1.0, 6.0, 5.0, 6.0, -4.0, 6.0, -9.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][0], mat3x4(-5.0, -7.0, 0.0, -4.0, 1.0, 2.0, -2.0, -3.0, -4.0, 2.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][1], mat3x4(6.0, -3.0, 9.0, 7.0, -4.0, -2.0, 6.0, 5.0, 2.0, -2.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][2], mat3x4(0.0, -8.0, -2.0, 7.0, 5.0, -6.0, 9.0, 6.0, 4.0, -4.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][0], mat3x4(-8.0, 6.0, 7.0, -3.0, -3.0, 5.0, 9.0, 6.0, 7.0, 2.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][1], mat3x4(-9.0, 1.0, 2.0, 0.0, -3.0, -3.0, 0.0, -7.0, 9.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][2], mat3x4(4.0, 8.0, -1.0, 7.0, 0.0, 2.0, 3.0, 3.0, 7.0, 8.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][0], mat3x4(-2.0, 8.0, -4.0, 7.0, 4.0, 5.0, 1.0, -1.0, 3.0, 0.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][1], mat3x4(-6.0, 1.0, -9.0, 0.0, -5.0, 8.0, -9.0, 1.0, -2.0, -2.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][2], mat3x4(-7.0, -6.0, -7.0, 6.0, 0.0, -6.0, 7.0, 3.0, 0.0, -7.0, 7.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3x4(-1.0, 6.0, 4.0, -6.0, -6.0, 0.0, -6.0, 9.0, -5.0, 3.0, -3.0, -2.0));
	var[0][0][1] = (mat3x4(-9.0, 9.0, -2.0, 3.0, -4.0, 2.0, -4.0, -4.0, 2.0, 1.0, 3.0, -2.0));
	var[0][0][2] = (mat3x4(-7.0, 6.0, 0.0, 4.0, -1.0, -2.0, 4.0, -1.0, 4.0, 1.0, -9.0, 5.0));
	var[0][1][0] = (mat3x4(-5.0, -6.0, -9.0, -2.0, 3.0, 0.0, 8.0, 5.0, 9.0, 8.0, 5.0, -4.0));
	var[0][1][1] = (mat3x4(5.0, 8.0, 3.0, -2.0, -6.0, -3.0, 3.0, 3.0, 0.0, 9.0, -9.0, 4.0));
	var[0][1][2] = (mat3x4(-8.0, -7.0, 4.0, -2.0, -9.0, -4.0, -3.0, -8.0, 7.0, 8.0, -1.0, -7.0));
	var[1][0][0] = (mat3x4(-9.0, 1.0, -3.0, -5.0, -5.0, 8.0, 4.0, -4.0, -5.0, 7.0, 3.0, -5.0));
	var[1][0][1] = (mat3x4(-4.0, 4.0, 3.0, 8.0, -8.0, 9.0, -3.0, -2.0, -4.0, 3.0, -3.0, 7.0));
	var[1][0][2] = (mat3x4(-9.0, -3.0, 7.0, -7.0, -6.0, 5.0, -4.0, -8.0, 2.0, -3.0, -9.0, -5.0));
	var[1][1][0] = (mat3x4(0.0, -4.0, 5.0, 2.0, 2.0, -3.0, 7.0, -3.0, 7.0, 0.0, -2.0, 0.0));
	var[1][1][1] = (mat3x4(-3.0, 7.0, -2.0, 4.0, -6.0, -3.0, 4.0, -8.0, 7.0, -3.0, -5.0, -5.0));
	var[1][1][2] = (mat3x4(-6.0, -2.0, 3.0, 6.0, 7.0, 1.0, -6.0, 7.0, -9.0, 5.0, 5.0, 3.0));
	var[2][0][0] = (mat3x4(3.0, 1.0, -4.0, -8.0, -9.0, -6.0, -2.0, -8.0, 0.0, 0.0, 1.0, 5.0));
	var[2][0][1] = (mat3x4(1.0, -1.0, -1.0, -7.0, -9.0, -5.0, 6.0, -4.0, -3.0, -9.0, -2.0, 8.0));
	var[2][0][2] = (mat3x4(9.0, 2.0, -4.0, -9.0, -7.0, 4.0, -5.0, -9.0, 2.0, -9.0, 4.0, 6.0));
	var[2][1][0] = (mat3x4(2.0, -3.0, -5.0, 8.0, -5.0, 3.0, 2.0, 1.0, 4.0, -5.0, -7.0, -9.0));
	var[2][1][1] = (mat3x4(5.0, 1.0, 4.0, 9.0, -7.0, -7.0, -7.0, 9.0, -4.0, 1.0, 3.0, 5.0));
	var[2][1][2] = (mat3x4(-6.0, 6.0, 7.0, 7.0, -3.0, -3.0, -7.0, -3.0, 5.0, -8.0, 3.0, 3.0));
	var[3][0][0] = (mat3x4(4.0, -5.0, 0.0, -5.0, -7.0, 5.0, 0.0, 7.0, -3.0, -3.0, 9.0, -4.0));
	var[3][0][1] = (mat3x4(-9.0, 0.0, 8.0, 4.0, -9.0, 6.0, 9.0, 3.0, -8.0, -4.0, -4.0, -2.0));
	var[3][0][2] = (mat3x4(6.0, -3.0, -7.0, -8.0, 6.0, -1.0, -8.0, 6.0, -1.0, 6.0, -3.0, 2.0));
	var[3][1][0] = (mat3x4(-9.0, 1.0, 5.0, 5.0, -5.0, 8.0, 4.0, -4.0, 9.0, -2.0, 1.0, -8.0));
	var[3][1][1] = (mat3x4(-2.0, 9.0, 3.0, 9.0, 9.0, -1.0, -9.0, 3.0, -9.0, 2.0, 2.0, -6.0));
	var[3][1][2] = (mat3x4(-9.0, 4.0, 0.0, 2.0, 4.0, -2.0, 9.0, -7.0, 4.0, -5.0, 3.0, -2.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, binding = 1) buffer Block
{
	i16vec3 var[4][2][3];
};

bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(var[0][0][0]), ivec3(3, 4, 8)) && allOk;
	allOk = compare_i16vec3(ivec3(var[0][0][1]), ivec3(7, -4, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(var[0][0][2]), ivec3(6, -5, -9)) && allOk;
	allOk = compare_i16vec3(ivec3(var[0][1][0]), ivec3(6, -2, -7)) && allOk;
	allOk = compare_i16vec3(ivec3(var[0][1][1]), ivec3(-6, 6, -1)) && allOk;
	allOk = compare_i16vec3(ivec3(var[0][1][2]), ivec3(-4, -6, -9)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][0][0]), ivec3(9, 4, 2)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][0][1]), ivec3(-6, 6, -2)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][0][2]), ivec3(2, -1, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][1][0]), ivec3(-5, -9, -4)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][1][1]), ivec3(7, -7, -2)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][1][2]), ivec3(2, 6, 2)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][0][0]), ivec3(-1, -4, -8)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][0][1]), ivec3(2, -8, 6)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][0][2]), ivec3(0, -3, 3)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][1][0]), ivec3(-6, 2, 1)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][1][1]), ivec3(-4, 3, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][1][2]), ivec3(-1, 4, -7)) && allOk;
	allOk = compare_i16vec3(ivec3(var[3][0][0]), ivec3(-6, 0, -1)) && allOk;
	allOk = compare_i16vec3(ivec3(var[3][0][1]), ivec3(5, 1, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(var[3][0][2]), ivec3(8, 5, 1)) && allOk;
	allOk = compare_i16vec3(ivec3(var[3][1][0]), ivec3(2, 8, -9)) && allOk;
	allOk = compare_i16vec3(ivec3(var[3][1][1]), ivec3(-8, -6, -7)) && allOk;
	allOk = compare_i16vec3(ivec3(var[3][1][2]), ivec3(7, -5, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = i16vec3(ivec3(6, 1, -2));
	var[0][0][1] = i16vec3(ivec3(-3, -1, -4));
	var[0][0][2] = i16vec3(ivec3(-2, -2, 2));
	var[0][1][0] = i16vec3(ivec3(-6, 7, -4));
	var[0][1][1] = i16vec3(ivec3(-8, 4, 1));
	var[0][1][2] = i16vec3(ivec3(5, -4, -6));
	var[1][0][0] = i16vec3(ivec3(0, -6, -2));
	var[1][0][1] = i16vec3(ivec3(0, -9, 2));
	var[1][0][2] = i16vec3(ivec3(-8, 6, 2));
	var[1][1][0] = i16vec3(ivec3(-6, 2, -7));
	var[1][1][1] = i16vec3(ivec3(-2, 2, -5));
	var[1][1][2] = i16vec3(ivec3(-3, -1, 0));
	var[2][0][0] = i16vec3(ivec3(-5, -4, -8));
	var[2][0][1] = i16vec3(ivec3(0, 9, 6));
	var[2][0][2] = i16vec3(ivec3(5, -3, 4));
	var[2][1][0] = i16vec3(ivec3(-6, 9, -3));
	var[2][1][1] = i16vec3(ivec3(6, 8, 2));
	var[2][1][2] = i16vec3(ivec3(7, -2, 2));
	var[3][0][0] = i16vec3(ivec3(-3, 9, 0));
	var[3][0][1] = i16vec3(ivec3(1, -5, 8));
	var[3][0][2] = i16vec3(ivec3(-5, 0, 7));
	var[3][1][0] = i16vec3(ivec3(5, -9, -7));
	var[3][1][1] = i16vec3(ivec3(4, -3, -4));
	var[3][1][2] = i16vec3(ivec3(-6, -4, -6));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, row_major, binding = 1) buffer Block
{
	float padding;
	highp mat3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -8.0) && allOk;
	allOk = compare_mat3(var[0][0][0], mat3(-7.0, 8.0, 7.0, 4.0, 4.0, -1.0, -9.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(-4.0, -3.0, 8.0, 7.0, -3.0, -7.0, -4.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat3(var[0][0][2], mat3(-9.0, -1.0, 8.0, 8.0, 3.0, -1.0, 6.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(-9.0, -8.0, 8.0, 0.0, 2.0, 9.0, 8.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(9.0, 7.0, -8.0, -9.0, -6.0, 6.0, 0.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3(var[0][1][2], mat3(-7.0, 1.0, -2.0, 3.0, -2.0, -7.0, 9.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(-2.0, 3.0, 7.0, 0.0, 0.0, 1.0, 4.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(4.0, 6.0, 8.0, 8.0, 6.0, 3.0, 1.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3(var[1][0][2], mat3(8.0, 3.0, 9.0, 3.0, 8.0, -8.0, 0.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(4.0, -2.0, 6.0, 2.0, 7.0, 2.0, 6.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(-8.0, -6.0, -3.0, -4.0, 9.0, -8.0, 9.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3(var[1][1][2], mat3(2.0, 5.0, -6.0, 7.0, 1.0, -5.0, -8.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(-7.0, 4.0, -2.0, -5.0, -4.0, 5.0, 7.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(-9.0, -9.0, 6.0, -6.0, -9.0, -8.0, 2.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat3(var[2][0][2], mat3(4.0, -6.0, -6.0, -7.0, -6.0, -6.0, -3.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(-1.0, -7.0, -1.0, 4.0, -4.0, -7.0, 4.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(-6.0, -4.0, -2.0, -6.0, -2.0, 5.0, 1.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3(var[2][1][2], mat3(8.0, 9.0, -4.0, -2.0, -1.0, -9.0, 3.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat3(var[3][0][0], mat3(5.0, -4.0, -6.0, -5.0, -8.0, -3.0, 6.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3(var[3][0][1], mat3(-2.0, 4.0, -8.0, 0.0, -3.0, -6.0, -1.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3(var[3][0][2], mat3(-7.0, 4.0, -8.0, 4.0, -8.0, -5.0, 6.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3(var[3][1][0], mat3(-1.0, 0.0, -2.0, 4.0, 4.0, -2.0, -9.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat3(var[3][1][1], mat3(1.0, 3.0, -1.0, -8.0, -6.0, -6.0, 3.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat3(var[3][1][2], mat3(1.0, -1.0, -8.0, -9.0, -9.0, 8.0, -4.0, -1.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (5.0);
	var[0][0][0] = (mat3(8.0, 3.0, -2.0, 2.0, -8.0, -5.0, 2.0, 8.0, -6.0));
	var[0][0][1] = (mat3(-5.0, -5.0, 8.0, -2.0, -5.0, 5.0, -1.0, 7.0, 3.0));
	var[0][0][2] = (mat3(-2.0, 3.0, 5.0, 5.0, 1.0, -6.0, 9.0, -7.0, -5.0));
	var[0][1][0] = (mat3(1.0, -5.0, 5.0, 8.0, -6.0, 7.0, 2.0, -8.0, -1.0));
	var[0][1][1] = (mat3(7.0, 5.0, -9.0, 5.0, 3.0, -1.0, 7.0, -7.0, 6.0));
	var[0][1][2] = (mat3(7.0, 0.0, 2.0, 8.0, -5.0, -9.0, -3.0, 9.0, -3.0));
	var[1][0][0] = (mat3(-2.0, -6.0, 2.0, -1.0, 0.0, 2.0, 4.0, 9.0, 9.0));
	var[1][0][1] = (mat3(6.0, 8.0, 4.0, 5.0, -2.0, -5.0, -5.0, 7.0, 7.0));
	var[1][0][2] = (mat3(-3.0, -8.0, 1.0, -4.0, 7.0, 1.0, -1.0, 1.0, 5.0));
	var[1][1][0] = (mat3(-7.0, 1.0, -6.0, -4.0, 1.0, -9.0, 0.0, 7.0, 6.0));
	var[1][1][1] = (mat3(5.0, 8.0, 1.0, 6.0, 4.0, -4.0, 9.0, 8.0, 9.0));
	var[1][1][2] = (mat3(-5.0, 8.0, -3.0, 4.0, -9.0, -8.0, -4.0, 1.0, -7.0));
	var[2][0][0] = (mat3(8.0, 9.0, 6.0, -1.0, 5.0, -2.0, 8.0, -1.0, 1.0));
	var[2][0][1] = (mat3(8.0, 1.0, 2.0, 4.0, -7.0, 3.0, 4.0, -8.0, -1.0));
	var[2][0][2] = (mat3(2.0, -1.0, -7.0, 7.0, -8.0, -6.0, -5.0, 2.0, 5.0));
	var[2][1][0] = (mat3(5.0, 0.0, 7.0, -8.0, -5.0, 8.0, 7.0, -5.0, 4.0));
	var[2][1][1] = (mat3(3.0, -2.0, 4.0, 8.0, -1.0, -5.0, -8.0, -8.0, -5.0));
	var[2][1][2] = (mat3(4.0, 9.0, 2.0, -2.0, -7.0, 2.0, -1.0, -1.0, -5.0));
	var[3][0][0] = (mat3(2.0, -9.0, -9.0, -2.0, 1.0, 8.0, -9.0, 2.0, -4.0));
	var[3][0][1] = (mat3(5.0, -2.0, 2.0, 3.0, 3.0, -8.0, 8.0, -5.0, 0.0));
	var[3][0][2] = (mat3(2.0, -5.0, -9.0, 4.0, 6.0, -3.0, 2.0, 6.0, -9.0));
	var[3][1][0] = (mat3(1.0, -3.0, -9.0, 5.0, 7.0, 7.0, -3.0, -3.0, 6.0));
	var[3][1][1] = (mat3(2.0, 0.0, 2.0, -1.0, 4.0, 2.0, 3.0, -3.0, 2.0));
	var[3][1][2] = (mat3(-9.0, 3.0, 4.0, -6.0, -3.0, -9.0, 3.0, 2.0, -1.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, row_major, binding = 1) buffer Block
{
	float padding;
	highp mat3x2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -9.0) && allOk;
	allOk = compare_mat3x2(var[0][0][0], mat3x2(-4.0, -4.0, -7.0, 2.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][1], mat3x2(-9.0, -1.0, 0.0, -3.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][2], mat3x2(-5.0, 3.0, -3.0, 6.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][0], mat3x2(1.0, 0.0, 3.0, -4.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][1], mat3x2(9.0, 9.0, 3.0, -6.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][2], mat3x2(0.0, -7.0, 7.0, 8.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][0], mat3x2(-9.0, 5.0, -4.0, -5.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][1], mat3x2(-5.0, -8.0, -5.0, -1.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][2], mat3x2(2.0, -6.0, -9.0, 4.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][0], mat3x2(0.0, -9.0, 9.0, -3.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][1], mat3x2(-4.0, 2.0, -5.0, -2.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][2], mat3x2(-2.0, -7.0, -2.0, 5.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][0], mat3x2(9.0, 8.0, -4.0, 4.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][1], mat3x2(5.0, -2.0, -2.0, 2.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][2], mat3x2(8.0, 6.0, -7.0, -3.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][0], mat3x2(3.0, -9.0, 5.0, -2.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][1], mat3x2(-7.0, 5.0, 5.0, 4.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][2], mat3x2(2.0, 5.0, -1.0, -4.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][0], mat3x2(6.0, -9.0, 9.0, 2.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][1], mat3x2(2.0, 5.0, 8.0, 5.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][2], mat3x2(-4.0, 8.0, -3.0, 7.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][0], mat3x2(-5.0, 2.0, -4.0, 5.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][1], mat3x2(-4.0, -9.0, 5.0, -8.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][2], mat3x2(-2.0, -7.0, 5.0, 9.0, -8.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-4.0);
	var[0][0][0] = (mat3x2(-6.0, 1.0, -8.0, 7.0, 6.0, -1.0));
	var[0][0][1] = (mat3x2(-6.0, 7.0, -4.0, -7.0, 0.0, -7.0));
	var[0][0][2] = (mat3x2(-2.0, -6.0, -6.0, -4.0, -5.0, -4.0));
	var[0][1][0] = (mat3x2(-7.0, 5.0, 9.0, -1.0, 9.0, 1.0));
	var[0][1][1] = (mat3x2(8.0, 8.0, -1.0, 5.0, 7.0, -7.0));
	var[0][1][2] = (mat3x2(7.0, -7.0, -4.0, 0.0, -7.0, -4.0));
	var[1][0][0] = (mat3x2(4.0, 7.0, 9.0, 7.0, -9.0, 9.0));
	var[1][0][1] = (mat3x2(-5.0, 6.0, -2.0, 6.0, -1.0, -6.0));
	var[1][0][2] = (mat3x2(1.0, 5.0, 7.0, 1.0, -8.0, 0.0));
	var[1][1][0] = (mat3x2(-1.0, 6.0, -9.0, 7.0, -8.0, -9.0));
	var[1][1][1] = (mat3x2(5.0, -2.0, 2.0, -7.0, 2.0, -7.0));
	var[1][1][2] = (mat3x2(5.0, 0.0, 1.0, -6.0, 2.0, 1.0));
	var[2][0][0] = (mat3x2(2.0, -7.0, 5.0, 1.0, 0.0, 6.0));
	var[2][0][1] = (mat3x2(-1.0, -4.0, -5.0, -3.0, 0.0, -8.0));
	var[2][0][2] = (mat3x2(-1.0, 9.0, -1.0, 7.0, 4.0, -8.0));
	var[2][1][0] = (mat3x2(-7.0, 8.0, -1.0, 1.0, -2.0, 2.0));
	var[2][1][1] = (mat3x2(1.0, -9.0, -8.0, 9.0, -3.0, -7.0));
	var[2][1][2] = (mat3x2(-6.0, -5.0, -8.0, 8.0, 8.0, -5.0));
	var[3][0][0] = (mat3x2(6.0, 0.0, 4.0, 4.0, -3.0, -8.0));
	var[3][0][1] = (mat3x2(-9.0, -4.0, 5.0, 5.0, 8.0, 4.0));
	var[3][0][2] = (mat3x2(-3.0, 2.0, 8.0, 5.0, 7.0, 9.0));
	var[3][1][0] = (mat3x2(4.0, -7.0, -6.0, -8.0, 1.0, 5.0));
	var[3][1][1] = (mat3x2(2.0, 0.0, -8.0, -6.0, -9.0, 8.0));
	var[3][1][2] = (mat3x2(3.0, 8.0, -8.0, 5.0, 7.0, -5.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, binding = 1) buffer Block
{
	u16vec3 var[][4][2];
};

bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(var[0][0][0]), uvec3(1u, 0u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[0][0][1]), uvec3(9u, 0u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[0][1][0]), uvec3(6u, 8u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[0][1][1]), uvec3(5u, 6u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[0][2][0]), uvec3(9u, 4u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[0][2][1]), uvec3(9u, 1u, 4u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[0][3][0]), uvec3(6u, 1u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[0][3][1]), uvec3(5u, 4u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1][0][0]), uvec3(7u, 1u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1][0][1]), uvec3(0u, 4u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1][1][0]), uvec3(3u, 3u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1][1][1]), uvec3(1u, 0u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1][2][0]), uvec3(8u, 5u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1][2][1]), uvec3(3u, 1u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1][3][0]), uvec3(8u, 8u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1][3][1]), uvec3(8u, 7u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2][0][0]), uvec3(9u, 7u, 2u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2][0][1]), uvec3(1u, 0u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2][1][0]), uvec3(1u, 3u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2][1][1]), uvec3(3u, 6u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2][2][0]), uvec3(8u, 0u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2][2][1]), uvec3(2u, 3u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2][3][0]), uvec3(1u, 1u, 4u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2][3][1]), uvec3(3u, 7u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = u16vec3(uvec3(1u, 2u, 6u));
	var[0][0][1] = u16vec3(uvec3(8u, 3u, 3u));
	var[0][1][0] = u16vec3(uvec3(4u, 7u, 0u));
	var[0][1][1] = u16vec3(uvec3(4u, 2u, 1u));
	var[0][2][0] = u16vec3(uvec3(1u, 3u, 3u));
	var[0][2][1] = u16vec3(uvec3(0u, 2u, 2u));
	var[0][3][0] = u16vec3(uvec3(6u, 1u, 7u));
	var[0][3][1] = u16vec3(uvec3(6u, 2u, 5u));
	var[1][0][0] = u16vec3(uvec3(4u, 4u, 9u));
	var[1][0][1] = u16vec3(uvec3(7u, 5u, 4u));
	var[1][1][0] = u16vec3(uvec3(0u, 2u, 8u));
	var[1][1][1] = u16vec3(uvec3(0u, 7u, 0u));
	var[1][2][0] = u16vec3(uvec3(7u, 9u, 1u));
	var[1][2][1] = u16vec3(uvec3(2u, 8u, 7u));
	var[1][3][0] = u16vec3(uvec3(3u, 6u, 4u));
	var[1][3][1] = u16vec3(uvec3(6u, 5u, 2u));
	var[2][0][0] = u16vec3(uvec3(5u, 6u, 5u));
	var[2][0][1] = u16vec3(uvec3(7u, 0u, 6u));
	var[2][1][0] = u16vec3(uvec3(2u, 8u, 7u));
	var[2][1][1] = u16vec3(uvec3(1u, 2u, 8u));
	var[2][2][0] = u16vec3(uvec3(9u, 6u, 3u));
	var[2][2][1] = u16vec3(uvec3(2u, 0u, 6u));
	var[2][3][0] = u16vec3(uvec3(3u, 1u, 1u));
	var[2][3][1] = u16vec3(uvec3(7u, 8u, 8u));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, binding = 1) buffer Block
{
	highp mat4x3 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0][0][0], mat4x3(0.0, 1.0, -8.0, -1.0, 2.0, 8.0, 7.0, -7.0, 9.0, -3.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(4.0, 2.0, 4.0, -2.0, -9.0, -6.0, 8.0, 9.0, 2.0, -2.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(4.0, 4.0, -8.0, 9.0, 2.0, 4.0, 5.0, -1.0, -4.0, -5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(9.0, -3.0, 4.0, -4.0, -8.0, 6.0, 7.0, 7.0, -6.0, -3.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[0][2][0], mat4x3(6.0, -1.0, 2.0, 6.0, -2.0, 2.0, 1.0, 6.0, 6.0, -6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[0][2][1], mat4x3(-5.0, -9.0, 2.0, 5.0, -7.0, 6.0, 6.0, 8.0, -4.0, -3.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[0][3][0], mat4x3(6.0, -3.0, -6.0, -3.0, -5.0, -8.0, 3.0, -5.0, -9.0, 4.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[0][3][1], mat4x3(7.0, 8.0, 7.0, 3.0, 8.0, -3.0, -9.0, -6.0, 2.0, 0.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(-7.0, 9.0, 2.0, -3.0, 3.0, 6.0, 6.0, 3.0, -3.0, -9.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(-5.0, 4.0, -6.0, 7.0, -5.0, 8.0, -1.0, 8.0, 1.0, 9.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(7.0, -9.0, -8.0, -4.0, -3.0, 6.0, 5.0, 4.0, 2.0, 3.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(-3.0, -8.0, -6.0, 5.0, -7.0, 2.0, -2.0, 1.0, 6.0, 5.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[1][2][0], mat4x3(2.0, -1.0, -5.0, -1.0, 3.0, -4.0, 2.0, 0.0, 7.0, -6.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[1][2][1], mat4x3(7.0, 1.0, -8.0, -6.0, 5.0, 7.0, -3.0, 7.0, -1.0, -7.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[1][3][0], mat4x3(4.0, -8.0, 4.0, 1.0, 8.0, -2.0, 5.0, -4.0, -7.0, -4.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[1][3][1], mat4x3(-9.0, 7.0, -5.0, 5.0, -6.0, -9.0, -8.0, 4.0, 1.0, 0.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(4.0, -6.0, 8.0, -9.0, -1.0, -2.0, 1.0, 7.0, 9.0, -5.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(2.0, 4.0, -7.0, 8.0, -1.0, -7.0, -3.0, 2.0, -7.0, 0.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(6.0, 1.0, 7.0, -6.0, -8.0, 9.0, 6.0, 2.0, -4.0, 4.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(7.0, 2.0, -5.0, -3.0, -3.0, 2.0, -4.0, -8.0, -1.0, 5.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[2][2][0], mat4x3(2.0, 9.0, -3.0, 7.0, -8.0, -1.0, 1.0, -2.0, 2.0, -3.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[2][2][1], mat4x3(9.0, 6.0, 5.0, -3.0, 2.0, -5.0, -7.0, 0.0, 6.0, -1.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[2][3][0], mat4x3(-5.0, 3.0, -9.0, 7.0, -8.0, -8.0, 4.0, -3.0, -8.0, -9.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[2][3][1], mat4x3(2.0, -3.0, 2.0, -8.0, 3.0, -8.0, 3.0, 0.0, -9.0, 0.0, -8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4x3(2.0, 4.0, 9.0, -7.0, 5.0, -8.0, 9.0, 1.0, 9.0, -6.0, -6.0, 1.0));
	var[0][0][1] = (mat4x3(6.0, -2.0, -2.0, 5.0, 3.0, -6.0, -8.0, -5.0, 9.0, 8.0, -2.0, -1.0));
	var[0][1][0] = (mat4x3(-3.0, 7.0, -5.0, -3.0, 0.0, -1.0, 8.0, -1.0, 8.0, -9.0, -7.0, 7.0));
	var[0][1][1] = (mat4x3(8.0, 2.0, 0.0, -8.0, -5.0, -8.0, -4.0, 9.0, -6.0, 6.0, -9.0, 9.0));
	var[0][2][0] = (mat4x3(-2.0, 7.0, -6.0, -4.0, -2.0, 0.0, 4.0, -2.0, 6.0, -6.0, -5.0, -8.0));
	var[0][2][1] = (mat4x3(-1.0, 2.0, 4.0, 2.0, -2.0, 9.0, 0.0, -4.0, 6.0, -7.0, -4.0, 2.0));
	var[0][3][0] = (mat4x3(2.0, 6.0, 9.0, -5.0, -9.0, -9.0, 5.0, 6.0, 4.0, 6.0, -3.0, 1.0));
	var[0][3][1] = (mat4x3(3.0, -1.0, 9.0, -2.0, 9.0, 6.0, -9.0, 4.0, 3.0, -7.0, -3.0, 3.0));
	var[1][0][0] = (mat4x3(1.0, 7.0, 0.0, 5.0, 9.0, -6.0, 5.0, 6.0, 2.0, 3.0, -8.0, 7.0));
	var[1][0][1] = (mat4x3(3.0, 1.0, -4.0, 0.0, -7.0, 0.0, 1.0, 6.0, -5.0, -5.0, -2.0, 5.0));
	var[1][1][0] = (mat4x3(-4.0, -2.0, -1.0, -9.0, 0.0, -2.0, 2.0, -1.0, 9.0, 6.0, 5.0, -6.0));
	var[1][1][1] = (mat4x3(9.0, -4.0, 0.0, 0.0, -6.0, -4.0, 1.0, -9.0, -9.0, -6.0, 2.0, 1.0));
	var[1][2][0] = (mat4x3(1.0, 2.0, -9.0, -3.0, 6.0, -9.0, 8.0, 2.0, 1.0, -8.0, 3.0, 2.0));
	var[1][2][1] = (mat4x3(1.0, 4.0, 9.0, -7.0, -5.0, 2.0, -8.0, 0.0, 0.0, -4.0, 9.0, 5.0));
	var[1][3][0] = (mat4x3(-7.0, 9.0, 6.0, -6.0, 1.0, 1.0, -3.0, -1.0, 8.0, -2.0, 3.0, -3.0));
	var[1][3][1] = (mat4x3(-5.0, 4.0, 0.0, -9.0, 9.0, -1.0, 0.0, -9.0, -3.0, 6.0, -2.0, 0.0));
	var[2][0][0] = (mat4x3(0.0, 7.0, 3.0, -7.0, -6.0, -5.0, -6.0, 2.0, -9.0, -1.0, 1.0, 6.0));
	var[2][0][1] = (mat4x3(0.0, 8.0, -4.0, -6.0, -7.0, -1.0, 3.0, -1.0, -6.0, 2.0, 2.0, -2.0));
	var[2][1][0] = (mat4x3(-9.0, 6.0, -7.0, 6.0, 5.0, 4.0, -7.0, -3.0, 6.0, 5.0, 8.0, -2.0));
	var[2][1][1] = (mat4x3(3.0, 0.0, 7.0, -9.0, -2.0, 7.0, -3.0, 4.0, -5.0, -5.0, -2.0, -3.0));
	var[2][2][0] = (mat4x3(-2.0, -9.0, 6.0, -9.0, -4.0, -7.0, 9.0, -5.0, 3.0, 5.0, -1.0, -4.0));
	var[2][2][1] = (mat4x3(1.0, -1.0, -8.0, 4.0, 4.0, 4.0, -3.0, 4.0, 0.0, 0.0, -7.0, -1.0));
	var[2][3][0] = (mat4x3(-5.0, -9.0, 2.0, -1.0, 4.0, 0.0, -4.0, 1.0, 3.0, -9.0, -5.0, -6.0));
	var[2][3][1] = (mat4x3(7.0, -4.0, 3.0, 0.0, -2.0, -5.0, -8.0, 3.0, 5.0, -1.0, 3.0, 5.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, column_major, binding = 1) buffer Block
{
	highp mat2x4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0][0][0], mat2x4(3.0, -4.0, 9.0, -7.0, -8.0, 2.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(-7.0, 8.0, -9.0, 4.0, 4.0, -9.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(-2.0, 5.0, -7.0, -1.0, 7.0, 6.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(-9.0, -7.0, 2.0, 8.0, -5.0, -1.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[0][2][0], mat2x4(-8.0, 0.0, 0.0, 1.0, 3.0, -4.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[0][2][1], mat2x4(0.0, -3.0, 4.0, -6.0, 4.0, 7.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[0][3][0], mat2x4(5.0, -4.0, -9.0, 2.0, -4.0, 7.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[0][3][1], mat2x4(4.0, -6.0, 7.0, 5.0, 5.0, -1.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(9.0, -5.0, -4.0, -8.0, -6.0, -2.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(-5.0, -8.0, -7.0, 8.0, 5.0, 9.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(-5.0, -4.0, -4.0, 5.0, -5.0, 5.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(-9.0, 2.0, 9.0, -6.0, -9.0, -5.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[1][2][0], mat2x4(1.0, -8.0, 0.0, 1.0, -3.0, 4.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[1][2][1], mat2x4(8.0, -3.0, 0.0, -2.0, -4.0, 5.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][3][0], mat2x4(0.0, -2.0, -6.0, 8.0, -4.0, -8.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[1][3][1], mat2x4(8.0, 6.0, 0.0, -2.0, -7.0, -9.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(1.0, 4.0, -4.0, -1.0, 0.0, 1.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(4.0, 4.0, -2.0, 5.0, 0.0, -2.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(-5.0, 2.0, -4.0, 4.0, 3.0, -4.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(6.0, 1.0, 5.0, -1.0, -5.0, 0.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[2][2][0], mat2x4(0.0, -9.0, 7.0, 0.0, -5.0, 7.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[2][2][1], mat2x4(-7.0, -9.0, -7.0, 4.0, -9.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[2][3][0], mat2x4(-7.0, -4.0, 9.0, 0.0, 7.0, 9.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[2][3][1], mat2x4(-3.0, -7.0, -1.0, -5.0, 1.0, 5.0, 9.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2x4(5.0, -1.0, 5.0, 1.0, 1.0, -4.0, 0.0, -8.0));
	var[0][0][1] = (mat2x4(-3.0, 9.0, -8.0, -9.0, 1.0, 9.0, 1.0, -2.0));
	var[0][1][0] = (mat2x4(-6.0, 9.0, -3.0, 5.0, -4.0, 8.0, 0.0, 1.0));
	var[0][1][1] = (mat2x4(8.0, -6.0, 9.0, 7.0, -4.0, -8.0, 6.0, 2.0));
	var[0][2][0] = (mat2x4(4.0, 9.0, -8.0, 5.0, 6.0, -1.0, 4.0, -3.0));
	var[0][2][1] = (mat2x4(3.0, -1.0, -8.0, 3.0, 0.0, 1.0, -4.0, -1.0));
	var[0][3][0] = (mat2x4(-5.0, 6.0, 0.0, 7.0, -5.0, 2.0, 0.0, -5.0));
	var[0][3][1] = (mat2x4(-7.0, 4.0, 4.0, 2.0, -9.0, 5.0, -7.0, -7.0));
	var[1][0][0] = (mat2x4(-6.0, 3.0, -3.0, -7.0, -6.0, 0.0, 9.0, -7.0));
	var[1][0][1] = (mat2x4(-3.0, -9.0, -8.0, 2.0, 1.0, -9.0, 2.0, -1.0));
	var[1][1][0] = (mat2x4(-1.0, 2.0, 9.0, -2.0, 4.0, -9.0, -7.0, 4.0));
	var[1][1][1] = (mat2x4(2.0, 0.0, -8.0, -1.0, -5.0, 5.0, 6.0, 0.0));
	var[1][2][0] = (mat2x4(-3.0, 4.0, 1.0, 2.0, 2.0, 0.0, 7.0, 2.0));
	var[1][2][1] = (mat2x4(6.0, 1.0, -2.0, 4.0, 9.0, -2.0, -7.0, 5.0));
	var[1][3][0] = (mat2x4(0.0, -2.0, -7.0, -5.0, 1.0, 4.0, 6.0, -3.0));
	var[1][3][1] = (mat2x4(4.0, 7.0, -8.0, -8.0, -4.0, -9.0, 3.0, -5.0));
	var[2][0][0] = (mat2x4(-3.0, -3.0, -6.0, -9.0, 2.0, -8.0, -1.0, 3.0));
	var[2][0][1] = (mat2x4(4.0, 9.0, -6.0, -4.0, 7.0, 7.0, -4.0, -4.0));
	var[2][1][0] = (mat2x4(5.0, -8.0, 8.0, 1.0, -4.0, -3.0, 5.0, 6.0));
	var[2][1][1] = (mat2x4(4.0, 9.0, -7.0, -4.0, -4.0, -7.0, 9.0, 4.0));
	var[2][2][0] = (mat2x4(-8.0, 2.0, -4.0, 4.0, -8.0, 1.0, -7.0, -7.0));
	var[2][2][1] = (mat2x4(1.0, 7.0, 2.0, 3.0, -2.0, 1.0, 0.0, 7.0));
	var[2][3][0] = (mat2x4(-7.0, -3.0, -1.0, -4.0, 2.0, -8.0, -5.0, -3.0));
	var[2][3][1] = (mat2x4(-7.0, 7.0, -5.0, 8.0, -1.0, 1.0, 7.0, 5.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, binding = 1) buffer Block
{
	u8vec2 var[][4][2];
};

bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(var[0][0][0]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[0][0][1]), uvec2(7u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[0][1][0]), uvec2(8u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[0][1][1]), uvec2(6u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[0][2][0]), uvec2(8u, 5u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[0][2][1]), uvec2(6u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[0][3][0]), uvec2(6u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[0][3][1]), uvec2(5u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1][0][0]), uvec2(4u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1][0][1]), uvec2(7u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1][1][0]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1][1][1]), uvec2(1u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1][2][0]), uvec2(2u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1][2][1]), uvec2(0u, 6u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1][3][0]), uvec2(2u, 1u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1][3][1]), uvec2(8u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2][0][0]), uvec2(9u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2][0][1]), uvec2(7u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2][1][0]), uvec2(2u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2][1][1]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2][2][0]), uvec2(2u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2][2][1]), uvec2(1u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2][3][0]), uvec2(7u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2][3][1]), uvec2(3u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = u8vec2(uvec2(7u, 7u));
	var[0][0][1] = u8vec2(uvec2(9u, 6u));
	var[0][1][0] = u8vec2(uvec2(2u, 7u));
	var[0][1][1] = u8vec2(uvec2(4u, 4u));
	var[0][2][0] = u8vec2(uvec2(1u, 8u));
	var[0][2][1] = u8vec2(uvec2(4u, 0u));
	var[0][3][0] = u8vec2(uvec2(7u, 4u));
	var[0][3][1] = u8vec2(uvec2(0u, 1u));
	var[1][0][0] = u8vec2(uvec2(0u, 2u));
	var[1][0][1] = u8vec2(uvec2(1u, 1u));
	var[1][1][0] = u8vec2(uvec2(7u, 2u));
	var[1][1][1] = u8vec2(uvec2(4u, 5u));
	var[1][2][0] = u8vec2(uvec2(2u, 7u));
	var[1][2][1] = u8vec2(uvec2(2u, 0u));
	var[1][3][0] = u8vec2(uvec2(2u, 3u));
	var[1][3][1] = u8vec2(uvec2(5u, 4u));
	var[2][0][0] = u8vec2(uvec2(0u, 8u));
	var[2][0][1] = u8vec2(uvec2(8u, 5u));
	var[2][1][0] = u8vec2(uvec2(0u, 2u));
	var[2][1][1] = u8vec2(uvec2(1u, 8u));
	var[2][2][0] = u8vec2(uvec2(2u, 5u));
	var[2][2][1] = u8vec2(uvec2(3u, 4u));
	var[2][3][0] = u8vec2(uvec2(4u, 2u));
	var[2][3][1] = u8vec2(uvec2(1u, 9u));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

struct S
{
	highp ivec3 a;
	mediump ivec2 b[4];
	highp vec4 c;
};
struct T
{
	mediump mat3 a;
	S b[3];
};
layout(scalar, binding = 1) buffer Block
{
	S s;
	lowp vec2 v;
	T t[2];
	highp uint u;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(block[0].t[0].a, mat3(-8.0, 1.0, -5.0, 0.0, -5.0, -7.0, -8.0, -5.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[0].a), ivec3(6, -8, 6)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[0]), ivec2(9, -5)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[1]), ivec2(-7, 9)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[2]), ivec2(-1, -9)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[3]), ivec2(9, 4)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[0].c), vec4(-2.0, 5.0, -2.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[1].a), ivec3(2, 0, 2)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[0]), ivec2(5, -8)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[1]), ivec2(6, 7)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[2]), ivec2(9, -4)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[3]), ivec2(-5, 7)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[1].c), vec4(-5.0, -7.0, -1.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[2].a), ivec3(-6, 8, -8)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[0]), ivec2(-2, 4)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[1]), ivec2(1, -8)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[2]), ivec2(-1, -9)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[3]), ivec2(-2, 1)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[2].c), vec4(-3.0, 6.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat3(block[0].t[1].a, mat3(-9.0, -2.0, 2.0, 2.0, -7.0, 1.0, -6.0, -8.0, -2.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[0].a), ivec3(-5, -3, -7)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[0]), ivec2(-3, 2)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[1]), ivec2(9, 4)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[2]), ivec2(-8, 0)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[3]), ivec2(-2, 3)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[0].c), vec4(8.0, 8.0, 0.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[1].a), ivec3(-4, 3, -5)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[0]), ivec2(0, -6)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[1]), ivec2(3, 9)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[2]), ivec2(-1, 4)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[3]), ivec2(-5, 1)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[1].c), vec4(0.0, 4.0, -3.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[2].a), ivec3(-9, 8, -4)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[0]), ivec2(-5, -6)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[1]), ivec2(8, 1)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[2]), ivec2(-8, 8)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[3]), ivec2(-4, -6)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[2].c), vec4(-4.0, 9.0, 3.0, 5.0)) && allOk;
	allOk = compare_uint((block[0].u), 7u) && allOk;
	allOk = compare_mat3(block[1].t[0].a, mat3(-9.0, -3.0, 9.0, -9.0, 2.0, 7.0, 0.0, -5.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[0].a), ivec3(-5, -4, 4)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[0]), ivec2(-4, 4)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[1]), ivec2(-7, 3)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[2]), ivec2(-3, 4)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[3]), ivec2(9, 2)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[0].c), vec4(8.0, -3.0, -5.0, -3.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[1].a), ivec3(4, -2, -3)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[0]), ivec2(6, -5)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[1]), ivec2(6, 0)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[2]), ivec2(-2, -4)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[3]), ivec2(9, -4)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[1].c), vec4(6.0, 1.0, 0.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[2].a), ivec3(3, -6, -9)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[0]), ivec2(-1, 4)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[1]), ivec2(5, 5)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[2]), ivec2(2, -6)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[3]), ivec2(3, 0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[2].c), vec4(-4.0, -9.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat3(block[1].t[1].a, mat3(2.0, -4.0, 8.0, 8.0, -3.0, -9.0, -7.0, -3.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[0].a), ivec3(8, 5, -3)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[0]), ivec2(-6, -6)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[1]), ivec2(0, -5)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[2]), ivec2(6, 8)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[3]), ivec2(2, 7)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[0].c), vec4(8.0, 0.0, -7.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[1].a), ivec3(-9, 8, 8)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[0]), ivec2(0, 6)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[1]), ivec2(2, 3)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[2]), ivec2(-3, -5)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[3]), ivec2(4, 5)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[1].c), vec4(-2.0, 3.0, -3.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[2].a), ivec3(-8, 9, 9)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[0]), ivec2(2, 1)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[1]), ivec2(-2, -9)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[2]), ivec2(2, 6)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[3]), ivec2(-7, -8)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[2].c), vec4(-2.0, 3.0, 5.0, 0.0)) && allOk;
	allOk = compare_uint((block[1].u), 8u) && allOk;
	allOk = compare_mat3(block[2].t[0].a, mat3(-4.0, -8.0, 5.0, 9.0, 5.0, -3.0, 0.0, -6.0, -7.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[0].a), ivec3(-8, 7, 7)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[0]), ivec2(1, 2)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[1]), ivec2(2, -5)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[2]), ivec2(-9, -8)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[3]), ivec2(-3, -2)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[0].c), vec4(4.0, 4.0, -9.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[1].a), ivec3(-8, -5, -8)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[0]), ivec2(-7, 9)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[1]), ivec2(-1, -6)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[2]), ivec2(-6, -9)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[3]), ivec2(-9, 1)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[1].c), vec4(-4.0, 0.0, 1.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[2].a), ivec3(-5, -1, -6)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[0]), ivec2(6, 2)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[1]), ivec2(-2, 1)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[2]), ivec2(-7, 5)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[3]), ivec2(9, -9)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[2].c), vec4(7.0, -4.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat3(block[2].t[1].a, mat3(8.0, -8.0, 6.0, 1.0, 8.0, -7.0, 6.0, 8.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[0].a), ivec3(6, 4, 9)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[0]), ivec2(7, 5)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[1]), ivec2(-9, 7)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[2]), ivec2(6, 4)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[3]), ivec2(4, 5)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[0].c), vec4(7.0, 1.0, 8.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[1].a), ivec3(-3, -5, 5)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[0]), ivec2(-5, -9)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[1]), ivec2(-2, -1)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[2]), ivec2(-1, -1)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[3]), ivec2(2, -6)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[1].c), vec4(-7.0, 0.0, 8.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[2].a), ivec3(-7, -6, 2)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[0]), ivec2(7, 8)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[1]), ivec2(3, 1)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[2]), ivec2(-5, -5)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[3]), ivec2(-4, 5)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[2].c), vec4(3.0, 7.0, -9.0, -9.0)) && allOk;
	allOk = compare_uint((block[2].u), 1u) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (ivec3(-7, 3, 5));
	block[0].s.b[0] = (ivec2(-3, -2));
	block[0].s.b[1] = (ivec2(2, 9));
	block[0].s.b[2] = (ivec2(8, -5));
	block[0].s.b[3] = (ivec2(1, -8));
	block[0].s.c = (vec4(9.0, 6.0, -3.0, 0.0));
	block[0].u = (2u);
	block[1].s.a = (ivec3(-9, 2, 3));
	block[1].s.b[0] = (ivec2(-9, 4));
	block[1].s.b[1] = (ivec2(5, 9));
	block[1].s.b[2] = (ivec2(-2, 0));
	block[1].s.b[3] = (ivec2(9, -4));
	block[1].s.c = (vec4(-2.0, 3.0, 1.0, -4.0));
	block[1].u = (6u);
	block[2].s.a = (ivec3(-7, -4, 5));
	block[2].s.b[0] = (ivec2(9, 7));
	block[2].s.b[1] = (ivec2(5, 4));
	block[2].s.b[2] = (ivec2(-8, -8));
	block[2].s.b[3] = (ivec2(1, 9));
	block[2].s.c = (vec4(-3.0, -3.0, -2.0, 5.0));
	block[2].u = (3u);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

struct S
{
	highp uvec3 a;
	mediump vec2 b[4];
	highp vec4 c;
};
struct T
{
	mediump mat4x3 a;
	S b[3];
	highp int c;
};
layout(std430, binding = 1) buffer Block
{
	S s;
	lowp vec2 v;
	highp uint u;
	T t[];
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((block[0].u), 2u) && allOk;
	allOk = compare_mat4x3(block[0].t[0].a, mat4x3(-1.0, -4.0, 3.0, 4.0, 2.0, -4.0, 4.0, 7.0, -6.0, -1.0, 6.0, -1.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[0].a), uvec3(9u, 5u, 3u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[0]), vec2(-6.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[1]), vec2(3.0, -7.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[2]), vec2(0.0, 5.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[3]), vec2(-3.0, 6.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[0].c), vec4(1.0, 5.0, -1.0, 9.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[1].a), uvec3(5u, 7u, 9u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[0]), vec2(4.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[1]), vec2(-6.0, 5.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[2]), vec2(6.0, -3.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[3]), vec2(4.0, 7.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[1].c), vec4(-9.0, 3.0, 5.0, 6.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[2].a), uvec3(3u, 6u, 9u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[0]), vec2(8.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[1]), vec2(0.0, -7.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[2]), vec2(-2.0, 5.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[3]), vec2(-4.0, -1.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[2].c), vec4(-8.0, 0.0, -7.0, 1.0)) && allOk;
	allOk = compare_int((block[0].t[0].c), -1) && allOk;
	allOk = compare_mat4x3(block[0].t[1].a, mat4x3(2.0, 8.0, 8.0, -9.0, 0.0, 7.0, 3.0, 5.0, 1.0, 1.0, -9.0, 2.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[0].a), uvec3(3u, 8u, 8u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[0]), vec2(-6.0, -7.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[1]), vec2(-5.0, -8.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[2]), vec2(6.0, 7.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[3]), vec2(-3.0, -7.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[0].c), vec4(-3.0, 2.0, -9.0, 0.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[1].a), uvec3(7u, 0u, 0u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[0]), vec2(1.0, -9.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[1]), vec2(-1.0, -3.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[2]), vec2(6.0, -5.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[3]), vec2(8.0, 9.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[1].c), vec4(-7.0, 2.0, 2.0, 1.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[2].a), uvec3(8u, 2u, 9u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[0]), vec2(3.0, -8.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[1]), vec2(-2.0, -4.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[2]), vec2(-5.0, -8.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[3]), vec2(6.0, 3.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[2].c), vec4(-8.0, -9.0, -9.0, -1.0)) && allOk;
	allOk = compare_int((block[0].t[1].c), -7) && allOk;
	allOk = compare_mat4x3(block[0].t[2].a, mat4x3(-5.0, 7.0, -5.0, -1.0, -7.0, -7.0, 5.0, -5.0, -2.0, -2.0, -3.0, 2.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[0].a), uvec3(2u, 3u, 4u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[0]), vec2(0.0, 6.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[1]), vec2(-5.0, -9.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[2]), vec2(0.0, -8.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[3]), vec2(-1.0, -5.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[0].c), vec4(4.0, 6.0, 7.0, -9.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[1].a), uvec3(7u, 6u, 6u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[0]), vec2(-2.0, 6.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[1]), vec2(4.0, 9.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[2]), vec2(-4.0, 8.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[3]), vec2(-2.0, -2.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[1].c), vec4(-5.0, -9.0, 1.0, 5.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[2].a), uvec3(9u, 3u, 4u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[0]), vec2(-8.0, -4.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[1]), vec2(0.0, -5.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[2]), vec2(5.0, 4.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[3]), vec2(3.0, 1.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[2].c), vec4(5.0, 9.0, -3.0, -2.0)) && allOk;
	allOk = compare_int((block[0].t[2].c), -4) && allOk;
	allOk = compare_mat4x3(block[0].t[3].a, mat4x3(8.0, -1.0, -7.0, 9.0, -2.0, -1.0, -1.0, 7.0, 3.0, 8.0, -9.0, -8.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[0].a), uvec3(0u, 5u, 1u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[0]), vec2(0.0, 8.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[1]), vec2(-2.0, -4.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[2]), vec2(5.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[3]), vec2(8.0, 4.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[0].c), vec4(-1.0, 3.0, -3.0, -9.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[1].a), uvec3(6u, 0u, 5u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[0]), vec2(-5.0, 0.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[1]), vec2(8.0, -5.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[2]), vec2(1.0, 0.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[3]), vec2(-4.0, 5.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[1].c), vec4(-7.0, -8.0, 1.0, -6.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[2].a), uvec3(8u, 1u, 4u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[0]), vec2(-2.0, 7.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[1]), vec2(-4.0, 2.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[2]), vec2(0.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[3]), vec2(6.0, -6.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[2].c), vec4(1.0, 4.0, 8.0, 6.0)) && allOk;
	allOk = compare_int((block[0].t[3].c), 5) && allOk;
	allOk = compare_uint((block[1].u), 8u) && allOk;
	allOk = compare_mat4x3(block[1].t[0].a, mat4x3(-6.0, 8.0, 7.0, -3.0, -4.0, -8.0, 8.0, -9.0, -3.0, -7.0, 1.0, -6.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[0].a), uvec3(4u, 1u, 1u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[0]), vec2(-2.0, 5.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[1]), vec2(-6.0, -4.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[2]), vec2(4.0, 5.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[3]), vec2(2.0, 6.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[0].c), vec4(9.0, -7.0, -5.0, -7.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[1].a), uvec3(0u, 2u, 6u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[0]), vec2(-9.0, -6.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[1]), vec2(-9.0, 9.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[2]), vec2(1.0, 6.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[3]), vec2(2.0, 8.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[1].c), vec4(-1.0, -9.0, 3.0, 7.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[2].a), uvec3(5u, 8u, 4u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[0]), vec2(-5.0, -2.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[1]), vec2(0.0, 5.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[2]), vec2(-4.0, 9.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[3]), vec2(0.0, -8.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[2].c), vec4(0.0, -6.0, -8.0, 4.0)) && allOk;
	allOk = compare_int((block[1].t[0].c), -9) && allOk;
	allOk = compare_uint((block[2].u), 9u) && allOk;
	allOk = compare_mat4x3(block[2].t[0].a, mat4x3(-8.0, 5.0, 7.0, -6.0, 0.0, 6.0, 6.0, -3.0, 9.0, -6.0, -1.0, 5.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[0].a), uvec3(7u, 4u, 1u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[0]), vec2(-2.0, 0.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[1]), vec2(7.0, 9.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[2]), vec2(3.0, 7.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[3]), vec2(-6.0, -1.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[0].c), vec4(-4.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[1].a), uvec3(9u, 9u, 8u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[0]), vec2(0.0, -1.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[1]), vec2(-9.0, 4.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[2]), vec2(-2.0, -4.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[3]), vec2(9.0, -9.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[1].c), vec4(-2.0, 5.0, 8.0, -1.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[2].a), uvec3(4u, 0u, 0u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[0]), vec2(4.0, 1.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[1]), vec2(-3.0, 7.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[2]), vec2(-5.0, 7.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[3]), vec2(-8.0, -9.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[2].c), vec4(-5.0, 5.0, 6.0, -2.0)) && allOk;
	allOk = compare_int((block[2].t[0].c), 8) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (uvec3(7u, 1u, 9u));
	block[0].s.b[0] = (vec2(7.0, -2.0));
	block[0].s.b[1] = (vec2(8.0, -4.0));
	block[0].s.b[2] = (vec2(-3.0, 2.0));
	block[0].s.b[3] = (vec2(-3.0, -9.0));
	block[0].s.c = (vec4(7.0, 5.0, -5.0, 3.0));
	block[0].u = (0u);
	block[1].s.a = (uvec3(0u, 4u, 0u));
	block[1].s.b[0] = (vec2(-6.0, 6.0));
	block[1].s.b[1] = (vec2(-2.0, -3.0));
	block[1].s.b[2] = (vec2(-9.0, -8.0));
	block[1].s.b[3] = (vec2(-2.0, 5.0));
	block[1].s.c = (vec4(6.0, 9.0, 0.0, 3.0));
	block[1].u = (7u);
	block[2].s.a = (uvec3(6u, 7u, 6u));
	block[2].s.b[0] = (vec2(-9.0, -7.0));
	block[2].s.b[1] = (vec2(9.0, -9.0));
	block[2].s.b[2] = (vec2(-2.0, 2.0));
	block[2].s.b[3] = (vec2(-8.0, 5.0));
	block[2].s.c = (vec4(-4.0, 3.0, 8.0, -5.0));
	block[2].u = (3u);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, binding = 1) buffer Block
{
	highp mat2x4 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(block[0].var, mat2x4(-5.0, 8.0, 6.0, -5.0, -7.0, -1.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block[1].var, mat2x4(5.0, -3.0, -3.0, 3.0, 9.0, 3.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block[2].var, mat2x4(9.0, -8.0, 9.0, -7.0, 5.0, -2.0, 7.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat2x4(1.0, 9.0, -7.0, -1.0, 7.0, -5.0, 3.0, -4.0));
	block[1].var = (mat2x4(-1.0, -4.0, -6.0, -7.0, 3.0, 5.0, 1.0, -1.0));
	block[2].var = (mat2x4(9.0, -9.0, -3.0, -7.0, 3.0, 9.0, -5.0, -9.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, row_major, binding = 1) buffer Block
{
	highp mat3x2 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block[0].var[0][0], -9.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 2.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -4.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -4.0) && allOk;
	allOk = compare_float(block[0].var[2][0], -7.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 2.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(-9.0, 2.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(-4.0, -4.0)) && allOk;
	allOk = compare_vec2(block[0].var[2], vec2(-7.0, 2.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 3.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 1.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -9.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -1.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 0.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -3.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(3.0, 1.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(-9.0, -1.0)) && allOk;
	allOk = compare_vec2(block[1].var[2], vec2(0.0, -3.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], -2.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -8.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -5.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 3.0) && allOk;
	allOk = compare_float(block[2].var[2][0], -3.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 6.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(-2.0, -8.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(-5.0, 3.0)) && allOk;
	allOk = compare_vec2(block[2].var[2], vec2(-3.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat3x2(-4.0, 6.0, -6.0, 1.0, -8.0, 7.0));
	block[1].var = (mat3x2(-1.0, 0.0, -6.0, 7.0, -4.0, -7.0));
	block[2].var = (mat3x2(-7.0, -5.0, -2.0, -6.0, -6.0, -4.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, binding = 1) buffer Block
{
	float16_t var;
} block[3];

bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(block[0].var), -7.0) && allOk;
	allOk = compare_float16_t(float(block[1].var), 4.0) && allOk;
	allOk = compare_float16_t(float(block[2].var), 2.0) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = float16_t(-8.0);
	block[1].var = float16_t(9.0);
	block[2].var = float16_t(-2.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, column_major, binding = 1) buffer Block
{
	highp mat2x3 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(block[0].var, mat2x3(-2.0, 0.0, -9.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block[1].var, mat2x3(-3.0, -1.0, -3.0, -1.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block[2].var, mat2x3(9.0, 9.0, 0.0, 0.0, -2.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec3(0.0, 5.0, 5.0));
	block[0].var[1] = (vec3(0.0, -7.0, 8.0));
	block[1].var[0] = (vec3(-7.0, -4.0, 6.0));
	block[1].var[1] = (vec3(1.0, 3.0, 2.0));
	block[2].var[0] = (vec3(-6.0, 5.0, 2.0));
	block[2].var[1] = (vec3(1.0, 8.0, -8.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, row_major, binding = 1) buffer Block
{
	highp mat3x2 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block[0].var[0][0], -9.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 2.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -4.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -4.0) && allOk;
	allOk = compare_float(block[0].var[2][0], -7.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 2.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(-9.0, 2.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(-4.0, -4.0)) && allOk;
	allOk = compare_vec2(block[0].var[2], vec2(-7.0, 2.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 3.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 1.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -9.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -1.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 0.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -3.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(3.0, 1.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(-9.0, -1.0)) && allOk;
	allOk = compare_vec2(block[1].var[2], vec2(0.0, -3.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], -2.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -8.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -5.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 3.0) && allOk;
	allOk = compare_float(block[2].var[2][0], -3.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 6.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(-2.0, -8.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(-5.0, 3.0)) && allOk;
	allOk = compare_vec2(block[2].var[2], vec2(-3.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat3x2(-4.0, 6.0, -6.0, 1.0, -8.0, 7.0));
	block[1].var = (mat3x2(-1.0, 0.0, -6.0, 7.0, -4.0, -7.0));
	block[2].var = (mat3x2(-7.0, -5.0, -2.0, -6.0, -6.0, -4.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, column_major, binding = 1) buffer Block
{
	highp mat3x2 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(block[0].var, mat3x2(-1.0, 4.0, -9.0, -1.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block[1].var, mat3x2(-8.0, 6.0, 3.0, 1.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block[2].var, mat3x2(-8.0, -3.0, 3.0, -3.0, -4.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat3x2(-2.0, -2.0, -8.0, 0.0, -9.0, 9.0));
	block[1].var = (mat3x2(0.0, 1.0, -3.0, -6.0, -5.0, -7.0));
	block[2].var = (mat3x2(5.0, -4.0, 8.0, -1.0, -8.0, 1.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, binding = 1) buffer Block
{
	highp mat3x4 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(block[0].var, mat3x4(-3.0, 3.0, -8.0, 8.0, 6.0, -9.0, -3.0, -1.0, 6.0, 3.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block[1].var, mat3x4(2.0, -8.0, 1.0, 2.0, -6.0, 8.0, -8.0, -3.0, 2.0, 5.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block[2].var, mat3x4(-6.0, -3.0, 5.0, 7.0, 3.0, -1.0, -9.0, -1.0, 5.0, 0.0, 1.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat3x4(-8.0, -6.0, 4.0, -9.0, 7.0, -4.0, -7.0, 0.0, -6.0, -6.0, -3.0, 4.0));
	block[1].var = (mat3x4(3.0, -2.0, -3.0, 4.0, 2.0, 8.0, 2.0, -4.0, 9.0, -1.0, 9.0, 7.0));
	block[2].var = (mat3x4(1.0, -1.0, 1.0, 5.0, 5.0, -4.0, -7.0, -4.0, 0.0, 6.0, 2.0, 0.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, row_major, binding = 1) buffer Block
{
	float padding;
	highp mat3x4 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), -3.0) && allOk;
	allOk = compare_float(block[0].var[0][0], -7.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 8.0) && allOk;
	allOk = compare_float(block[0].var[0][2], -8.0) && allOk;
	allOk = compare_float(block[0].var[0][3], -5.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 9.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -8.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 2.0) && allOk;
	allOk = compare_float(block[0].var[1][3], 4.0) && allOk;
	allOk = compare_float(block[0].var[2][0], -9.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 3.0) && allOk;
	allOk = compare_float(block[0].var[2][2], -6.0) && allOk;
	allOk = compare_float(block[0].var[2][3], 8.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(-7.0, 8.0, -8.0, -5.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(9.0, -8.0, 2.0, 4.0)) && allOk;
	allOk = compare_vec4(block[0].var[2], vec4(-9.0, 3.0, -6.0, 8.0)) && allOk;
	allOk = compare_float((block[1].padding), -8.0) && allOk;
	allOk = compare_float(block[1].var[0][0], 9.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 7.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 4.0) && allOk;
	allOk = compare_float(block[1].var[0][3], -6.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -4.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 9.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 7.0) && allOk;
	allOk = compare_float(block[1].var[1][3], -3.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 9.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -1.0) && allOk;
	allOk = compare_float(block[1].var[2][2], 0.0) && allOk;
	allOk = compare_float(block[1].var[2][3], 1.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(9.0, 7.0, 4.0, -6.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(-4.0, 9.0, 7.0, -3.0)) && allOk;
	allOk = compare_vec4(block[1].var[2], vec4(9.0, -1.0, 0.0, 1.0)) && allOk;
	allOk = compare_float((block[2].padding), 8.0) && allOk;
	allOk = compare_float(block[2].var[0][0], -6.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -7.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 8.0) && allOk;
	allOk = compare_float(block[2].var[0][3], -4.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 5.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 1.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -1.0) && allOk;
	allOk = compare_float(block[2].var[1][3], 1.0) && allOk;
	allOk = compare_float(block[2].var[2][0], -9.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 7.0) && allOk;
	allOk = compare_float(block[2].var[2][2], 3.0) && allOk;
	allOk = compare_float(block[2].var[2][3], 9.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(-6.0, -7.0, 8.0, -4.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(5.0, 1.0, -1.0, 1.0)) && allOk;
	allOk = compare_vec4(block[2].var[2], vec4(-9.0, 7.0, 3.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-6.0);
	block[0].var[0] = (vec4(-2.0, 4.0, -5.0, 8.0));
	block[0].var[1] = (vec4(-4.0, 6.0, -9.0, -9.0));
	block[0].var[2] = (vec4(-4.0, 2.0, -3.0, 0.0));
	block[1].padding = (5.0);
	block[1].var[0] = (vec4(-7.0, -6.0, -8.0, 0.0));
	block[1].var[1] = (vec4(6.0, 0.0, 6.0, 3.0));
	block[1].var[2] = (vec4(2.0, 6.0, 6.0, -8.0));
	block[2].padding = (7.0);
	block[2].var[0] = (vec4(-3.0, 6.0, -2.0, 6.0));
	block[2].var[1] = (vec4(-5.0, -5.0, 1.0, -5.0));
	block[2].var[2] = (vec4(-8.0, -3.0, -2.0, 9.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, binding = 1) buffer Block
{
	float16_t padding;
	f16vec2 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(block[0].padding), -6.0) && allOk;
	allOk = compare_f16vec2(vec2(block[0].var), vec2(-3.0, 1.0)) && allOk;
	allOk = compare_float16_t(float(block[1].padding), -5.0) && allOk;
	allOk = compare_f16vec2(vec2(block[1].var), vec2(6.0, 3.0)) && allOk;
	allOk = compare_float16_t(float(block[2].padding), 2.0) && allOk;
	allOk = compare_f16vec2(vec2(block[2].var), vec2(-1.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = float16_t(-2.0);
	block[0].var = f16vec2(vec2(4.0, -2.0));
	block[1].padding = float16_t(4.0);
	block[1].var = f16vec2(vec2(-1.0, 1.0));
	block[2].padding = float16_t(9.0);
	block[2].var = f16vec2(vec2(4.0, 8.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

struct S
{
	lowp mat3 a;
	mediump ivec2 b[4];
	highp vec4 c;
};
struct T
{
	mediump uint a;
	S b;
	bvec4 c;
};
layout(std140, binding = 1) buffer BlockA
{
	highp float a;
	S b;
	lowp uvec3 c;
} blockA;
layout(std140, binding = 2) buffer BlockB
{
	mediump mat2 a;
	T b;
	bvec4 c;
	bool d;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockA.a), 6.0) && allOk;
	allOk = compare_uint((blockB.b.a), 4u) && allOk;
	allOk = compare_mat3(blockB.b.b.a, mat3(9.0, 7.0, 3.0, -4.0, -7.0, 8.0, -3.0, 3.0, 0.0)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[0]), ivec2(1, -6)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[1]), ivec2(-7, -3)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[2]), ivec2(4, 4)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[3]), ivec2(-9, -3)) && allOk;
	allOk = compare_vec4((blockB.b.b.c), vec4(1.0, 2.0, 4.0, 1.0)) && allOk;
	allOk = compare_bvec4((blockB.b.c), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bool((blockB.d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (2.0);
	blockA.b.a = (mat3(-5.0, -8.0, 6.0, -9.0, -9.0, -8.0, 0.0, -1.0, -9.0));
	blockA.b.b[0] = (ivec2(2, -5));
	blockA.b.b[1] = (ivec2(6, -6));
	blockA.b.b[2] = (ivec2(-5, -4));
	blockA.b.b[3] = (ivec2(-9, 4));
	blockA.b.c = (vec4(6.0, -9.0, 6.0, 7.0));
	blockB.a = (mat2(1.0, 5.0, 1.0, 7.0));
	blockB.b.a = (2u);
	blockB.b.b.a = (mat3(-3.0, -4.0, 9.0, -3.0, -3.0, -4.0, 4.0, -8.0, -1.0));
	blockB.b.b.b[0] = (ivec2(-1, -8));
	blockB.b.b.b[1] = (ivec2(4, -9));
	blockB.b.b.b[2] = (ivec2(-6, -5));
	blockB.b.b.b[3] = (ivec2(7, -8));
	blockB.b.b.c = (vec4(5.0, 2.0, -1.0, -3.0));
	blockB.b.c = (bvec4(true, true, true, true));
	blockB.d = (false);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, binding = 1) buffer BlockB
{
	bool a;
	bool b;
	mediump float c[1];
	mediump uint d;
	lowp int e;
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	highp int f[1];
	highp float g;
	mediump uint h;
};
layout(std140, binding = 3) buffer BlockD
{
	lowp uint i[1];
	highp int j;
	bool k;
	bool l;
	lowp int m[1];
} blockD;
layout(std140, binding = 4) buffer BlockE
{
	lowp uint n;
	lowp int o[1];
	mediump float p;
	mediump float q;
	highp float r;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.b), false) && allOk;
	allOk = compare_uint((blockB.d), 9u) && allOk;
	allOk = compare_int((blockB.e), -2) && allOk;
	allOk = compare_int((f[0]), 6) && allOk;
	allOk = compare_float((g), 3.0) && allOk;
	allOk = compare_uint((h), 1u) && allOk;
	allOk = compare_uint((blockD.i[0]), 8u) && allOk;
	allOk = compare_int((blockD.j), -6) && allOk;
	allOk = compare_bool((blockD.k), false) && allOk;
	allOk = compare_bool((blockD.l), false) && allOk;
	allOk = compare_int((blockE.o[0]), 4) && allOk;
	allOk = compare_float((blockE.p), 8.0) && allOk;
	allOk = compare_float((blockE.r), 6.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
	blockB.b = (false);
	blockB.c[0] = (1.0);
	blockB.e = (-3);
	g = (9.0);
	blockD.i[0] = (1u);
	blockD.j = (0);
	blockD.k = (false);
	blockD.l = (true);
	blockE.o[0] = (-5);
	blockE.p = (5.0);
	blockE.q = (-6.0);
	blockE.r = (3.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, row_major, binding = 1) buffer BlockB
{
	lowp ivec4 a;
	lowp uvec3 b;
	lowp mat3 c;
	mediump mat2x3 d;
	lowp vec4 e;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((a), ivec4(-8, -8, 0, -9)) && allOk;
	allOk = compare_mat3(c, mat3(0.0, 1.0, -6.0, -2.0, 5.0, 9.0, -5.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x3(d, mat2x3(3.0, 5.0, 5.0, 7.0, -6.0, -9.0)) && allOk;
	allOk = compare_vec4((e), vec4(-2.0, 4.0, -1.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (uvec3(5u, 6u, 5u));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, column_major, binding = 1) buffer BlockB
{
	highp mat3x4 a[1];
	highp uvec2 b[];
} blockB[2];
layout(std430, column_major, binding = 2) buffer BlockC
{
	highp ivec4 c;
	highp mat2 d;
	highp uvec4 e[];
};
layout(std140, binding = 3) buffer BlockD
{
	lowp uvec3 f;
	lowp float g;
	mediump ivec2 h[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB[0].a[0], mat3x4(-7.0, 3.0, -2.0, 9.0, -9.0, -1.0, -9.0, 1.0, -8.0, 6.0, -5.0, -8.0)) && allOk;
	allOk = compare_uvec2((blockB[0].b[0]), uvec2(0u, 8u)) && allOk;
	allOk = compare_mat3x4(blockB[1].a[0], mat3x4(-7.0, 7.0, -4.0, 8.0, -1.0, 2.0, 0.0, 1.0, 6.0, -5.0, 2.0, 7.0)) && allOk;
	allOk = compare_uvec2((blockB[1].b[0]), uvec2(4u, 0u)) && allOk;
	allOk = compare_uvec4((e[0]), uvec4(6u, 7u, 2u, 4u)) && allOk;
	allOk = compare_uvec3((blockD.f), uvec3(6u, 3u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (mat3x4(-6.0, -2.0, 3.0, -5.0, -4.0, 5.0, -9.0, 8.0, 1.0, 9.0, 5.0, -4.0));
	blockB[0].b[0] = (uvec2(4u, 2u));
	blockB[1].a[0] = (mat3x4(7.0, 3.0, 2.0, -7.0, 1.0, 3.0, 2.0, -7.0, 4.0, 9.0, -8.0, -1.0));
	blockB[1].b[0] = (uvec2(5u, 1u));
	c = (ivec4(4, 1, -8, -8));
	d = (mat2(-1.0, -5.0, 7.0, -5.0));
	e[0] = (uvec4(1u, 7u, 4u, 1u));
	blockD.f = (uvec3(1u, 6u, 8u));
	blockD.g = (-5.0);
	blockD.h[0] = (ivec2(1, 4));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, column_major, binding = 1) buffer BlockB
{
	mediump mat3 a;
	lowp vec4 b;
	mediump vec4 c[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(a, mat3(4.0, 4.0, -4.0, 7.0, 4.0, 1.0, 9.0, 3.0, -5.0)) && allOk;
	allOk = compare_vec4((b), vec4(-8.0, -6.0, 0.0, 7.0)) && allOk;
	allOk = compare_vec4((c[0]), vec4(-1.0, -1.0, 6.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat3(-5.0, 4.0, -9.0, -7.0, -8.0, 8.0, 4.0, 6.0, -5.0));
	c[0] = (vec4(-4.0, -8.0, 0.0, 9.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

struct sA
{
	lowp uint mA;
	lowp uvec4 mB;
};
struct sB
{
	lowp mat3x2 mA;
	sA mB;
	mediump vec3 mC;
};
struct sC
{
	lowp mat2 mA;
	mediump vec2 mB;
	mediump vec4 mC;
};
struct sD
{
	bvec2 mA;
	lowp mat4x3 mB;
	sC mC;
	lowp vec2 mD;
};
layout(std430, row_major, binding = 1) buffer BlockB
{
	highp uvec3 a;
	sB b;
	sD c;
	mediump mat4 d;
	mediump mat3x4 e;
} blockB;
layout(std140, binding = 2) readonly buffer BlockC
{
	lowp mat2 f;
	mediump mat4 g;
	mediump uvec3 h[];
} blockC;
layout(std430, column_major, binding = 3) buffer BlockD
{
	highp ivec3 i;
	highp mat2 j;
	mediump uint k[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a), uvec3(1u, 9u, 8u)) && allOk;
	allOk = compare_bvec2((blockB.c.mA), bvec2(false, true)) && allOk;
	allOk = compare_mat4x3(blockB.c.mB, mat4x3(4.0, -5.0, 5.0, -2.0, 1.0, 5.0, 9.0, -6.0, -3.0, 2.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat2(blockB.c.mC.mA, mat2(1.0, 7.0, -9.0, -2.0)) && allOk;
	allOk = compare_vec2((blockB.c.mC.mB), vec2(2.0, 9.0)) && allOk;
	allOk = compare_vec4((blockB.c.mC.mC), vec4(-3.0, 3.0, 1.0, 1.0)) && allOk;
	allOk = compare_vec2((blockB.c.mD), vec2(-9.0, -3.0)) && allOk;
	allOk = compare_mat4(blockC.g, mat4(-3.0, 6.0, 6.0, 2.0, 4.0, 4.0, -3.0, 3.0, 8.0, 6.0, -3.0, 4.0, -7.0, 1.0, -5.0, -9.0)) && allOk;
	allOk = compare_ivec3((i), ivec3(-9, 6, 2)) && allOk;
	allOk = compare_mat2(j, mat2(-2.0, -6.0, 4.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec3(5u, 2u, 5u));
	blockB.b.mA = (mat3x2(-4.0, 0.0, -8.0, 0.0, -5.0, -7.0));
	blockB.b.mB.mA = (8u);
	blockB.b.mB.mB = (uvec4(1u, 5u, 2u, 0u));
	blockB.b.mC = (vec3(3.0, 8.0, 8.0));
	blockB.c.mA = (bvec2(true, false));
	blockB.c.mB = (mat4x3(5.0, -9.0, 7.0, 1.0, -2.0, -9.0, 7.0, -7.0, -5.0, -1.0, -5.0, 5.0));
	blockB.c.mC.mA = (mat2(3.0, -7.0, 7.0, -6.0));
	blockB.c.mC.mB = (vec2(1.0, 8.0));
	blockB.c.mC.mC = (vec4(8.0, -9.0, -8.0, 4.0));
	blockB.c.mD = (vec2(8.0, 5.0));
	blockB.e = (mat3x4(-6.0, -4.0, 6.0, 3.0, -3.0, -7.0, 9.0, 4.0, -6.0, 7.0, -9.0, 2.0));
	i = (ivec3(3, -9, 5));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, binding = 1) buffer BlockB
{
	mediump mat4x3 a[];
};
layout(std140, binding = 2) buffer BlockC
{
	mediump mat3x4 b;
	lowp int c;
	lowp mat4x3 d[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((c), 0) && allOk;
	allOk = compare_mat4x3(d[0], mat4x3(6.0, -7.0, 5.0, -9.0, 3.0, -2.0, 6.0, -2.0, 1.0, -6.0, 0.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (mat4x3(-5.0, 4.0, -9.0, -7.0, -8.0, 8.0, 4.0, 6.0, -5.0, -5.0, -7.0, 5.0));
	d[0] = (mat4x3(7.0, 7.0, -8.0, 5.0, -2.0, -7.0, -2.0, 5.0, 0.0, -1.0, 5.0, 4.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, column_major, binding = 1) buffer BlockB
{
	highp vec4 a[2];
	mediump ivec4 b[6];
	bvec3 c[];
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	lowp uint d;
	mediump int e;
	bvec4 f;
	mediump uvec3 g;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockC.e), 2) && allOk;
    if (allOk)
        ac_numPassed++;

	b[0] = (ivec4(-5, -9, 4, -6));
	b[1] = (ivec4(2, 6, 4, 6));
	b[2] = (ivec4(-5, 2, -9, -8));
	b[3] = (ivec4(3, 6, -6, 5));
	b[4] = (ivec4(6, -6, 3, 7));
	b[5] = (ivec4(-8, -2, -6, -3));
	c[0] = (bvec3(true, true, true));
	c[1] = (bvec3(false, true, true));
	blockC.d = (6u);
	blockC.e = (9);
	blockC.f = (bvec4(false, false, false, true));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

struct sA
{
	lowp uvec2 mA;
	mediump ivec3 mB;
	mediump mat4x3 mC;
	highp uvec4 mD[7][5];
};
layout(std430, binding = 1) buffer BlockB
{
	mediump mat2 a;
	lowp uvec2 b[4];
	bvec4 c[];
};
layout(std140, binding = 2) buffer BlockC
{
	highp mat3x4 d;
	sA e;
	bool f;
	bvec2 g;
	lowp uvec4 h[];
} blockC;
layout(std430, row_major, binding = 3) buffer BlockD
{
	highp ivec3 i[];
} blockD;
layout(std430, column_major, binding = 4) buffer BlockE
{
	lowp mat4 j;
	lowp vec4 k;
	bvec3 l[];
} blockE[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(a, mat2(0.0, 6.0, 5.0, 9.0)) && allOk;
	allOk = compare_uvec2((b[0]), uvec2(2u, 1u)) && allOk;
	allOk = compare_uvec2((b[1]), uvec2(7u, 8u)) && allOk;
	allOk = compare_uvec2((b[2]), uvec2(4u, 4u)) && allOk;
	allOk = compare_uvec2((b[3]), uvec2(4u, 1u)) && allOk;
	allOk = compare_uvec2((blockC.e.mA), uvec2(5u, 3u)) && allOk;
	allOk = compare_ivec3((blockC.e.mB), ivec3(-4, 8, -2)) && allOk;
	allOk = compare_mat4x3(blockC.e.mC, mat4x3(5.0, -7.0, 5.0, 8.0, -5.0, 6.0, 6.0, -6.0, 8.0, -7.0, -1.0, -1.0)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[0][0]), uvec4(3u, 6u, 7u, 3u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[0][1]), uvec4(0u, 3u, 9u, 8u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[0][2]), uvec4(0u, 8u, 6u, 3u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[0][3]), uvec4(3u, 3u, 6u, 3u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[0][4]), uvec4(4u, 5u, 4u, 0u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[1][0]), uvec4(2u, 0u, 2u, 6u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[1][1]), uvec4(7u, 7u, 3u, 6u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[1][2]), uvec4(4u, 0u, 8u, 8u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[1][3]), uvec4(1u, 2u, 9u, 8u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[1][4]), uvec4(4u, 2u, 2u, 5u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[2][0]), uvec4(8u, 7u, 6u, 5u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[2][1]), uvec4(4u, 8u, 8u, 3u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[2][2]), uvec4(6u, 7u, 7u, 5u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[2][3]), uvec4(3u, 4u, 1u, 6u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[2][4]), uvec4(5u, 2u, 9u, 8u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[3][0]), uvec4(9u, 8u, 5u, 8u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[3][1]), uvec4(5u, 9u, 9u, 1u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[3][2]), uvec4(0u, 0u, 8u, 6u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[3][3]), uvec4(6u, 4u, 3u, 9u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[3][4]), uvec4(4u, 6u, 7u, 5u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[4][0]), uvec4(9u, 4u, 7u, 5u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[4][1]), uvec4(6u, 4u, 1u, 0u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[4][2]), uvec4(6u, 0u, 2u, 1u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[4][3]), uvec4(9u, 4u, 1u, 5u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[4][4]), uvec4(5u, 2u, 9u, 1u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[5][0]), uvec4(2u, 0u, 6u, 8u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[5][1]), uvec4(5u, 8u, 4u, 1u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[5][2]), uvec4(7u, 2u, 1u, 6u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[5][3]), uvec4(1u, 1u, 5u, 8u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[5][4]), uvec4(5u, 5u, 9u, 1u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[6][0]), uvec4(2u, 1u, 7u, 0u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[6][1]), uvec4(3u, 9u, 3u, 4u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[6][2]), uvec4(6u, 6u, 9u, 7u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[6][3]), uvec4(6u, 7u, 3u, 7u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[6][4]), uvec4(5u, 3u, 9u, 2u)) && allOk;
	allOk = compare_bvec2((blockC.g), bvec2(false, false)) && allOk;
	allOk = compare_uvec4((blockC.h[0]), uvec4(0u, 7u, 6u, 1u)) && allOk;
	allOk = compare_uvec4((blockC.h[1]), uvec4(1u, 5u, 7u, 5u)) && allOk;
	allOk = compare_ivec3((blockD.i[0]), ivec3(6, -3, 4)) && allOk;
	allOk = compare_ivec3((blockD.i[1]), ivec3(8, 6, 3)) && allOk;
	allOk = compare_mat4(blockE[0].j, mat4(-4.0, -5.0, 0.0, 6.0, 7.0, 2.0, -6.0, -4.0, 9.0, -5.0, -3.0, -3.0, 1.0, 3.0, 1.0, 3.0)) && allOk;
	allOk = compare_bvec3((blockE[0].l[0]), bvec3(true, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	b[0] = (uvec2(5u, 4u));
	b[1] = (uvec2(2u, 1u));
	b[2] = (uvec2(7u, 4u));
	b[3] = (uvec2(7u, 2u));
	c[0] = (bvec4(false, false, true, false));
	c[1] = (bvec4(true, true, false, true));
	c[2] = (bvec4(true, true, true, true));
	c[3] = (bvec4(true, true, false, false));
	blockC.d = (mat3x4(-5.0, -6.0, -4.0, 5.0, -7.0, 9.0, -2.0, 5.0, -1.0, 7.0, 2.0, -2.0));
	blockC.e.mA = (uvec2(8u, 5u));
	blockC.e.mB = (ivec3(1, -2, -8));
	blockC.e.mC = (mat4x3(-2.0, -3.0, -5.0, -1.0, -7.0, 3.0, -2.0, -1.0, -9.0, -3.0, 5.0, -8.0));
	blockC.e.mD[0][0] = (uvec4(5u, 9u, 3u, 5u));
	blockC.e.mD[0][1] = (uvec4(7u, 6u, 0u, 6u));
	blockC.e.mD[0][2] = (uvec4(6u, 2u, 6u, 7u));
	blockC.e.mD[0][3] = (uvec4(9u, 2u, 9u, 2u));
	blockC.e.mD[0][4] = (uvec4(6u, 3u, 4u, 2u));
	blockC.e.mD[1][0] = (uvec4(8u, 0u, 6u, 4u));
	blockC.e.mD[1][1] = (uvec4(3u, 0u, 1u, 5u));
	blockC.e.mD[1][2] = (uvec4(0u, 0u, 8u, 5u));
	blockC.e.mD[1][3] = (uvec4(6u, 9u, 9u, 7u));
	blockC.e.mD[1][4] = (uvec4(9u, 0u, 1u, 4u));
	blockC.e.mD[2][0] = (uvec4(4u, 2u, 5u, 6u));
	blockC.e.mD[2][1] = (uvec4(2u, 8u, 2u, 2u));
	blockC.e.mD[2][2] = (uvec4(8u, 9u, 5u, 7u));
	blockC.e.mD[2][3] = (uvec4(9u, 9u, 9u, 2u));
	blockC.e.mD[2][4] = (uvec4(5u, 9u, 0u, 3u));
	blockC.e.mD[3][0] = (uvec4(0u, 8u, 4u, 5u));
	blockC.e.mD[3][1] = (uvec4(4u, 7u, 7u, 0u));
	blockC.e.mD[3][2] = (uvec4(3u, 6u, 2u, 9u));
	blockC.e.mD[3][3] = (uvec4(1u, 3u, 8u, 3u));
	blockC.e.mD[3][4] = (uvec4(8u, 4u, 9u, 5u));
	blockC.e.mD[4][0] = (uvec4(7u, 5u, 8u, 4u));
	blockC.e.mD[4][1] = (uvec4(8u, 9u, 0u, 9u));
	blockC.e.mD[4][2] = (uvec4(3u, 6u, 8u, 9u));
	blockC.e.mD[4][3] = (uvec4(8u, 7u, 3u, 0u));
	blockC.e.mD[4][4] = (uvec4(1u, 4u, 2u, 9u));
	blockC.e.mD[5][0] = (uvec4(0u, 0u, 8u, 3u));
	blockC.e.mD[5][1] = (uvec4(3u, 7u, 8u, 0u));
	blockC.e.mD[5][2] = (uvec4(7u, 2u, 9u, 6u));
	blockC.e.mD[5][3] = (uvec4(5u, 0u, 1u, 5u));
	blockC.e.mD[5][4] = (uvec4(6u, 5u, 3u, 2u));
	blockC.e.mD[6][0] = (uvec4(3u, 7u, 7u, 3u));
	blockC.e.mD[6][1] = (uvec4(8u, 8u, 5u, 2u));
	blockC.e.mD[6][2] = (uvec4(9u, 5u, 0u, 1u));
	blockC.e.mD[6][3] = (uvec4(6u, 2u, 7u, 5u));
	blockC.e.mD[6][4] = (uvec4(9u, 7u, 7u, 0u));
	blockD.i[0] = (ivec3(8, 1, 8));
	blockD.i[1] = (ivec3(6, 6, -3));
	blockE[0].j = (mat4(7.0, -5.0, 0.0, -2.0, 2.0, 6.0, -9.0, -1.0, 7.0, 8.0, -1.0, 6.0, 6.0, 1.0, -3.0, -2.0));
	blockE[0].k = (vec4(7.0, -8.0, 4.0, -6.0));
	blockE[0].l[0] = (bvec3(true, false, true));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, column_major, binding = 1) buffer BlockB
{
	lowp mat3x2 a[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	a[0] = (mat3x2(6.0, 3.0, -9.0, 0.0, 9.0, 2.0));
	a[1] = (mat3x2(-6.0, 6.0, -6.0, 3.0, 5.0, -8.0));
	a[2] = (mat3x2(-7.0, -8.0, 3.0, -6.0, -9.0, 9.0));
	a[3] = (mat3x2(-9.0, 9.0, 8.0, -1.0, -4.0, 0.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(binding = 1) buffer BlockB
{
	layout(offset = 0) mediump vec4 a[1];
	layout(offset = 16) highp uvec4 b;
	layout(offset = 32) mediump uvec3 c;
	layout(offset = 48) mediump uvec3 d;
	layout(offset = 64) lowp uvec2 e;
} blockB[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB[0].a[0]), vec4(-7.0, -6.0, -2.0, -9.0)) && allOk;
	allOk = compare_uvec4((blockB[0].b), uvec4(4u, 4u, 1u, 9u)) && allOk;
	allOk = compare_uvec3((blockB[0].d), uvec3(0u, 9u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (vec4(-6.0, -1.0, 8.0, -4.0));
	blockB[0].b = (uvec4(5u, 3u, 7u, 1u));
	blockB[0].c = (uvec3(7u, 5u, 3u));
	blockB[0].d = (uvec3(7u, 0u, 0u));
	blockB[0].e = (uvec2(0u, 7u));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(binding = 1) buffer BlockB
{
	layout(offset = 0) mediump vec4 a;
	layout(offset = 16) lowp uint b[1];
	layout(offset = 20) lowp uint c;
	layout(offset = 24) highp int d;
	layout(offset = 28) lowp uint e;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) highp ivec2 f[1];
	layout(offset = 16) bvec4 g;
};
layout(binding = 3) readonly buffer BlockD
{
	layout(offset = 0) lowp vec2 h;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((b[0]), 4u) && allOk;
	allOk = compare_uint((c), 7u) && allOk;
	allOk = compare_int((d), 0) && allOk;
	allOk = compare_ivec2((f[0]), ivec2(5, -5)) && allOk;
	allOk = compare_bvec4((g), bvec4(true, false, true, true)) && allOk;
	allOk = compare_vec2((blockD.h), vec2(9.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec4(-4.0, 4.0, 1.0, -2.0));
	b[0] = (3u);
	c = (5u);
	d = (-5);
	e = (6u);
	f[0] = (ivec2(8, -2));
	g = (bvec4(false, false, true, false));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

struct sA
{
	highp uvec2 mA;
};
struct sB
{
	lowp uint mA;
	lowp mat4x3 mB;
	mediump ivec2 mC[3][3];
	bool mD;
};
layout(scalar, binding = 1) buffer BlockB
{
	lowp ivec4 a;
	sA b;
	sB c;
	highp ivec3 d;
	lowp ivec4 e[];
} blockB[2];
layout(scalar, row_major, binding = 2) buffer BlockC
{
	bool f;
	mediump float g;
	bvec4 h;
	mediump int i;
};
layout(scalar, row_major, binding = 3) buffer BlockD
{
	highp mat3x2 j[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB[0].c.mA), 1u) && allOk;
	allOk = compare_mat4x3(blockB[0].c.mB, mat4x3(6.0, 3.0, 5.0, 9.0, 0.0, -4.0, -3.0, -1.0, 8.0, -9.0, 1.0, 8.0)) && allOk;
	allOk = compare_ivec2((blockB[0].c.mC[0][0]), ivec2(-4, 4)) && allOk;
	allOk = compare_ivec2((blockB[0].c.mC[0][1]), ivec2(1, -2)) && allOk;
	allOk = compare_ivec2((blockB[0].c.mC[0][2]), ivec2(-6, -3)) && allOk;
	allOk = compare_ivec2((blockB[0].c.mC[1][0]), ivec2(8, -3)) && allOk;
	allOk = compare_ivec2((blockB[0].c.mC[1][1]), ivec2(-3, 0)) && allOk;
	allOk = compare_ivec2((blockB[0].c.mC[1][2]), ivec2(3, -2)) && allOk;
	allOk = compare_ivec2((blockB[0].c.mC[2][0]), ivec2(-8, -7)) && allOk;
	allOk = compare_ivec2((blockB[0].c.mC[2][1]), ivec2(2, -2)) && allOk;
	allOk = compare_ivec2((blockB[0].c.mC[2][2]), ivec2(2, 7)) && allOk;
	allOk = compare_bool((blockB[0].c.mD), true) && allOk;
	allOk = compare_ivec4((blockB[0].e[0]), ivec4(-5, -7, -8, -8)) && allOk;
	allOk = compare_ivec4((blockB[0].e[1]), ivec4(5, -7, 2, -3)) && allOk;
	allOk = compare_ivec4((blockB[0].e[2]), ivec4(-9, -1, -5, 9)) && allOk;
	allOk = compare_ivec4((blockB[0].e[3]), ivec4(-2, 4, 9, 0)) && allOk;
	allOk = compare_ivec4((blockB[0].e[4]), ivec4(8, 3, -2, -2)) && allOk;
	allOk = compare_ivec4((blockB[0].e[5]), ivec4(9, -6, 8, 7)) && allOk;
	allOk = compare_ivec4((blockB[0].e[6]), ivec4(9, -6, -2, 2)) && allOk;
	allOk = compare_uint((blockB[1].c.mA), 1u) && allOk;
	allOk = compare_mat4x3(blockB[1].c.mB, mat4x3(4.0, 5.0, -2.0, -1.0, -3.0, 6.0, -8.0, -5.0, -1.0, 9.0, -9.0, 9.0)) && allOk;
	allOk = compare_ivec2((blockB[1].c.mC[0][0]), ivec2(-2, -6)) && allOk;
	allOk = compare_ivec2((blockB[1].c.mC[0][1]), ivec2(-7, -4)) && allOk;
	allOk = compare_ivec2((blockB[1].c.mC[0][2]), ivec2(-8, -2)) && allOk;
	allOk = compare_ivec2((blockB[1].c.mC[1][0]), ivec2(-3, -4)) && allOk;
	allOk = compare_ivec2((blockB[1].c.mC[1][1]), ivec2(0, -3)) && allOk;
	allOk = compare_ivec2((blockB[1].c.mC[1][2]), ivec2(9, 4)) && allOk;
	allOk = compare_ivec2((blockB[1].c.mC[2][0]), ivec2(3, -1)) && allOk;
	allOk = compare_ivec2((blockB[1].c.mC[2][1]), ivec2(7, -6)) && allOk;
	allOk = compare_ivec2((blockB[1].c.mC[2][2]), ivec2(-7, -8)) && allOk;
	allOk = compare_bool((blockB[1].c.mD), true) && allOk;
	allOk = compare_ivec4((blockB[1].e[0]), ivec4(-2, 0, 6, 4)) && allOk;
	allOk = compare_ivec4((blockB[1].e[1]), ivec4(-8, -5, 3, -5)) && allOk;
	allOk = compare_ivec4((blockB[1].e[2]), ivec4(-9, 1, 8, 8)) && allOk;
	allOk = compare_ivec4((blockB[1].e[3]), ivec4(-6, 5, -7, -3)) && allOk;
	allOk = compare_ivec4((blockB[1].e[4]), ivec4(6, -4, 5, -3)) && allOk;
	allOk = compare_ivec4((blockB[1].e[5]), ivec4(5, -5, -8, -8)) && allOk;
	allOk = compare_ivec4((blockB[1].e[6]), ivec4(5, 0, -8, -7)) && allOk;
	allOk = compare_bool((f), true) && allOk;
	allOk = compare_float((g), 7.0) && allOk;
	allOk = compare_bvec4((h), bvec4(true, false, true, true)) && allOk;
	allOk = compare_mat3x2(j[0], mat3x2(-7.0, -2.0, -9.0, -7.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3x2(j[1], mat3x2(-7.0, 9.0, -4.0, -8.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(j[2], mat3x2(8.0, -3.0, 6.0, 0.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x2(j[3], mat3x2(2.0, 1.0, -5.0, -7.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat3x2(j[4], mat3x2(-4.0, 4.0, -5.0, -4.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3x2(j[5], mat3x2(-9.0, -4.0, -8.0, 9.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3x2(j[6], mat3x2(-7.0, 0.0, 3.0, 7.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3x2(j[7], mat3x2(7.0, 1.0, 0.0, -5.0, -4.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b.mA = (uvec2(2u, 5u));
	blockB[0].d = (ivec3(-3, -1, -3));
	blockB[0].e[0] = (ivec4(8, 9, -9, 2));
	blockB[0].e[1] = (ivec4(4, -9, -7, -2));
	blockB[0].e[2] = (ivec4(-6, 4, -5, -7));
	blockB[0].e[3] = (ivec4(6, 6, -1, -4));
	blockB[0].e[4] = (ivec4(-7, -7, 6, 7));
	blockB[0].e[5] = (ivec4(-1, -1, 1, 8));
	blockB[0].e[6] = (ivec4(-9, 5, -5, 7));
	blockB[1].b.mA = (uvec2(5u, 9u));
	blockB[1].d = (ivec3(-8, -1, -8));
	blockB[1].e[0] = (ivec4(-4, 5, 9, 6));
	blockB[1].e[1] = (ivec4(1, 9, 4, 5));
	blockB[1].e[2] = (ivec4(6, -9, 0, -9));
	blockB[1].e[3] = (ivec4(8, -4, 8, -1));
	blockB[1].e[4] = (ivec4(-3, -2, -2, 6));
	blockB[1].e[5] = (ivec4(-1, -3, 1, 7));
	blockB[1].e[6] = (ivec4(7, -5, -6, -5));
	f = (false);
	g = (7.0);
	h = (bvec4(true, false, false, true));
	i = (-2);
	j[0] = (mat3x2(-1.0, 8.0, -2.0, -5.0, -2.0, 4.0));
	j[1] = (mat3x2(9.0, 2.0, 9.0, 8.0, -5.0, -1.0));
	j[2] = (mat3x2(-1.0, -9.0, -2.0, 6.0, -7.0, 6.0));
	j[3] = (mat3x2(-6.0, 2.0, -1.0, -6.0, 5.0, -4.0));
	j[4] = (mat3x2(1.0, 4.0, 9.0, -2.0, -9.0, -7.0));
	j[5] = (mat3x2(0.0, -4.0, -9.0, 9.0, 6.0, -4.0));
	j[6] = (mat3x2(-6.0, -8.0, 6.0, -7.0, -9.0, -6.0));
	j[7] = (mat3x2(2.0, -8.0, -4.0, -4.0, -6.0, -5.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, column_major, binding = 1) buffer BlockB
{
	highp vec4 a[1];
	mediump uvec2 b;
	lowp ivec3 c[1];
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB[nonuniformEXT(0)].a[0]), vec4(1.0, 2.0, 2.0, 2.0)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(0)].b), uvec2(9u, 2u)) && allOk;
	allOk = compare_vec4((blockB[nonuniformEXT(1)].a[0]), vec4(2.0, -1.0, -3.0, -9.0)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(1)].b), uvec2(1u, 6u)) && allOk;
	allOk = compare_vec4((blockB[nonuniformEXT(2)].a[0]), vec4(-3.0, 5.0, 3.0, -3.0)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(2)].b), uvec2(0u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a[0] = (vec4(-8.0, -4.0, -7.0, 2.0));
	blockB[nonuniformEXT(0)].b = (uvec2(6u, 6u));
	blockB[nonuniformEXT(0)].c[0] = (ivec3(6, -8, 6));
	blockB[nonuniformEXT(1)].a[0] = (vec4(-1.0, -9.0, 3.0, -6.0));
	blockB[nonuniformEXT(1)].b = (uvec2(5u, 4u));
	blockB[nonuniformEXT(1)].c[0] = (ivec3(6, -5, -4));
	blockB[nonuniformEXT(2)].a[0] = (vec4(8.0, -7.0, 4.0, -3.0));
	blockB[nonuniformEXT(2)].b = (uvec2(2u, 4u));
	blockB[nonuniformEXT(2)].c[0] = (ivec3(6, 7, -8));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, binding = 1) buffer BlockB
{
	bool a;
	uint16_t b;
	highp float c;
};
layout(std430, binding = 2) buffer BlockC
{
	uint16_t d;
	lowp int e;
	int16_t f;
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	float16_t g;
	int16_t h;
	highp float i[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((a), true) && allOk;
	allOk = compare_uint16_t(uint(b), 4u) && allOk;
	allOk = compare_uint16_t(uint(blockC.d), 3u) && allOk;
	allOk = compare_int((blockC.e), 4) && allOk;
	allOk = compare_int16_t(int(blockC.f), -4) && allOk;
	allOk = compare_float16_t(float(g), 0.0) && allOk;
	allOk = compare_int16_t(int(h), -2) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (true);
	b = uint16_t(4u);
	c = (-1.0);
	blockC.d = uint16_t(5u);
	blockC.e = (7);
	g = float16_t(-6.0);
	i[0] = (-9.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, binding = 1) buffer BlockB
{
	u16vec3 a[1];
};
layout(std430, binding = 2) buffer BlockC
{
	i16vec3 b;
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	u16vec3 c;
	highp ivec4 d;
};
layout(std430, binding = 4) readonly buffer BlockE
{
	bvec2 e;
} blockE;

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(blockC.b), ivec3(6, 1, 9)) && allOk;
	allOk = compare_bvec2((blockE.e), bvec2(true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = u16vec3(uvec3(4u, 9u, 2u));
	blockC.b = i16vec3(ivec3(-6, 1, -2));
	d = (ivec4(-9, -2, -4, -4));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, binding = 1) readonly buffer BlockB
{
	highp mat3x2 a;
	highp int b[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((b[0]), -2) && allOk;
	allOk = compare_int((b[1]), -5) && allOk;
	allOk = compare_int((b[2]), -3) && allOk;
	allOk = compare_int((b[3]), -3) && allOk;
	allOk = compare_int((b[4]), 1) && allOk;
	allOk = compare_int((b[5]), -3) && allOk;
	allOk = compare_int((b[6]), 8) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

struct sA
{
	mediump mat3x4 mA;
	i16vec4 mB;
};
layout(std430, binding = 1) buffer BlockB
{
	sA a;
	int16_t b;
	float16_t c[5];
	uint16_t d[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(b), -5) && allOk;
	allOk = compare_float16_t(float(c[0]), 5.0) && allOk;
	allOk = compare_float16_t(float(c[1]), -6.0) && allOk;
	allOk = compare_float16_t(float(c[2]), 5.0) && allOk;
	allOk = compare_float16_t(float(c[3]), -7.0) && allOk;
	allOk = compare_float16_t(float(c[4]), -4.0) && allOk;
	allOk = compare_uint16_t(uint(d[0]), 3u) && allOk;
    if (allOk)
        ac_numPassed++;

	d[0] = uint16_t(9u);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(binding = 1) buffer BlockB
{
	layout(offset = 0) bvec4 a;
	layout(offset = 16) u16vec3 b;
	layout(offset = 22) i16vec4 c;
} blockB[2];
layout(binding = 2) readonly buffer BlockC
{
	layout(offset = 0) i16vec4 d[1];
};
layout(binding = 3) readonly buffer BlockD
{
	layout(offset = 0) int16_t e;
};
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) i16vec2 f;
	layout(offset = 4) bvec2 g;
	layout(offset = 16) u16vec3 h[1];
	layout(offset = 32) lowp vec4 i;
	layout(offset = 48) u16vec2 j;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB[0].a), bvec4(true, true, true, true)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[0].c), ivec4(-8, 1, -5, 6)) && allOk;
	allOk = compare_bvec4((blockB[1].a), bvec4(true, true, false, true)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[1].c), ivec4(-6, -4, 1, 0)) && allOk;
	allOk = compare_i16vec4(ivec4(d[0]), ivec4(1, -3, 2, -6)) && allOk;
	allOk = compare_int16_t(int(e), 9) && allOk;
	allOk = compare_i16vec2(ivec2(f), ivec2(-8, -7)) && allOk;
	allOk = compare_bvec2((g), bvec2(false, false)) && allOk;
	allOk = compare_u16vec3(uvec3(h[0]), uvec3(1u, 9u, 5u)) && allOk;
	allOk = compare_vec4((i), vec4(-4.0, 8.0, 1.0, -9.0)) && allOk;
	allOk = compare_u16vec2(uvec2(j), uvec2(3u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (bvec4(true, true, false, false));
	blockB[0].b = u16vec3(uvec3(5u, 6u, 5u));
	blockB[0].c = i16vec4(ivec4(2, 1, -1, -7));
	blockB[1].a = (bvec4(true, true, false, false));
	blockB[1].b = u16vec3(uvec3(0u, 8u, 3u));
	blockB[1].c = i16vec4(ivec4(-7, 2, 2, -2));
	f = i16vec2(ivec2(8, 9));
	g = (bvec2(true, true));
	h[0] = u16vec3(uvec3(9u, 7u, 3u));
	i = (vec4(9.0, 3.0, -7.0, 0.0));
	j = u16vec2(uvec2(9u, 7u));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(binding = 1) buffer BlockB
{
	layout(offset = 0) highp uint a;
	layout(offset = 4) highp int b;
	layout(offset = 16) lowp vec3 c;
	layout(offset = 32) lowp uvec3 d;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) i16vec2 e;
	layout(offset = 4) bool f;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) highp uint g;
	layout(offset = 4) u16vec2 h;
	layout(offset = 8) highp int i;
} blockD[1];
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) lowp int j;
	layout(offset = 4) highp vec3 k;
	layout(offset = 16) i16vec3 l;
	layout(offset = 24) mediump int m;
	layout(offset = 32) i16vec4 n;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.b), 7) && allOk;
	allOk = compare_vec3((blockB.c), vec3(-3.0, 6.0, 5.0)) && allOk;
	allOk = compare_uvec3((blockB.d), uvec3(7u, 4u, 2u)) && allOk;
	allOk = compare_bool((blockC.f), true) && allOk;
	allOk = compare_uint((blockD[0].g), 6u) && allOk;
	allOk = compare_u16vec2(uvec2(blockD[0].h), uvec2(5u, 5u)) && allOk;
	allOk = compare_int((blockD[0].i), 6) && allOk;
	allOk = compare_i16vec4(ivec4(blockE.n), ivec4(-7, -1, -4, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (4u);
	blockB.b = (7);
	blockB.d = (uvec3(3u, 8u, 5u));
	blockC.e = i16vec2(ivec2(2, 8));
	blockD[0].g = (8u);
	blockD[0].i = (7);
	blockE.j = (5);
	blockE.k = (vec3(-2.0, -4.0, -3.0));
	blockE.l = i16vec3(ivec3(8, -7, 5));
	blockE.m = (-4);
	blockE.n = i16vec4(ivec4(-4, -6, -1, 4));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, binding = 1) buffer BlockB
{
	mediump mat2x3 a;
	mediump ivec4 b;
	highp vec3 c;
	highp mat2x3 d;
	highp ivec2 e;
} blockB;
layout(scalar, column_major, binding = 2) buffer BlockC
{
	highp mat4x3 f;
	mediump mat2x3 g;
	u16vec4 h;
	mediump vec4 i[];
} blockC;
layout(scalar, binding = 3) buffer BlockD
{
	lowp mat3 j;
	bvec3 k;
	bvec2 l;
	i16vec2 m;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB.a, mat2x3(3.0, 4.0, -3.0, 6.0, -1.0, -4.0)) && allOk;
	allOk = compare_ivec2((blockB.e), ivec2(-9, -2)) && allOk;
	allOk = compare_mat4x3(blockC.f, mat4x3(2.0, -8.0, 4.0, -1.0, 3.0, 5.0, -4.0, 0.0, 4.0, 0.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat2x3(blockC.g, mat2x3(2.0, 0.0, 4.0, -5.0, -1.0, 0.0)) && allOk;
	allOk = compare_bvec3((blockD.k), bvec3(false, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2x3(3.0, -9.0, 1.0, -1.0, -7.0, -8.0));
	blockB.b = (ivec4(2, 1, 3, 5));
	blockB.d = (mat2x3(3.0, 1.0, -2.0, 3.0, -4.0, 1.0));
	blockB.e = (ivec2(-1, 3));
	blockC.g = (mat2x3(-3.0, -8.0, 4.0, 6.0, -8.0, 1.0));
	blockD.j = (mat3(8.0, -4.0, 8.0, 5.0, 1.0, 6.0, 5.0, 5.0, -4.0));
	blockD.l = (bvec2(true, false));
	blockD.m = i16vec2(ivec2(-5, -6));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, binding = 1) readonly buffer BlockB
{
	bvec4 a[];
} blockB[1];
layout(scalar, column_major, binding = 2) buffer BlockC
{
	highp mat3x2 b;
	highp vec3 c;
	mediump vec3 d;
	mediump mat2x3 e;
	mediump ivec3 f[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(b, mat3x2(3.0, 2.0, 1.0, 8.0, -1.0, 5.0)) && allOk;
	allOk = compare_vec3((c), vec3(1.0, -1.0, 6.0)) && allOk;
	allOk = compare_vec3((d), vec3(-6.0, 7.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (mat3x2(-1.0, -7.0, -3.0, 8.0, -9.0, -3.0));
	c = (vec3(0.0, 6.0, -5.0));
	d = (vec3(3.0, 4.0, -9.0));
	e = (mat2x3(-5.0, 1.0, 8.0, -6.0, 9.0, 4.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, column_major, binding = 1) buffer BlockB
{
	int16_t a;
	mediump mat3 b;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB[nonuniformEXT(0)].b, mat3(-2.0, -1.0, 7.0, -1.0, 0.0, -7.0, -4.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3(blockB[nonuniformEXT(1)].b, mat3(1.0, 7.0, 6.0, 2.0, -1.0, 2.0, 8.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat3(blockB[nonuniformEXT(2)].b, mat3(-2.0, 4.0, -8.0, 0.0, -2.0, 8.0, -4.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat3(blockB[nonuniformEXT(3)].b, mat3(1.0, 0.0, 7.0, 3.0, -1.0, -3.0, 2.0, 9.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = int16_t(1);
	blockB[nonuniformEXT(1)].a = int16_t(-3);
	blockB[nonuniformEXT(2)].a = int16_t(6);
	blockB[nonuniformEXT(3)].a = int16_t(-2);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, binding = 1) buffer BlockB
{
	mediump uvec3 a;
	mediump vec2 b;
	highp mat2x3 c;
	highp int d;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a), uvec3(3u, 0u, 3u)) && allOk;
	allOk = compare_vec2((blockB.b), vec2(-3.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec3(7u, 9u, 4u));
	blockB.b = (vec2(5.0, -3.0));
	blockB.d = (1);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, binding = 1) buffer BlockB
{
	lowp mat3x2 a;
	bvec2 b;
	i8vec2 c;
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	u8vec3 d;
	bool e;
	lowp uvec2 f;
	mediump mat4 g;
} blockC;
layout(std140, row_major, binding = 3) readonly buffer BlockD
{
	mediump mat4 h;
} blockD;
layout(std430, column_major, binding = 4) buffer BlockE
{
	lowp ivec3 i;
	i8vec2 j;
	mediump mat2 k[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(blockC.d), uvec3(1u, 7u, 0u)) && allOk;
	allOk = compare_ivec3((i), ivec3(3, -3, 8)) && allOk;
	allOk = compare_i8vec2(ivec2(j), ivec2(1, 4294967288)) && allOk;
	allOk = compare_mat2(k[0], mat2(-3.0, -3.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2(k[1], mat2(3.0, 2.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat2(k[2], mat2(9.0, -4.0, 4.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (bvec2(true, false));
	blockB.c = i8vec2(ivec2(5, 4294967288));
	blockC.d = u8vec3(uvec3(3u, 9u, 8u));
	blockC.e = (true);
	blockC.g = (mat4(4.0, -5.0, 5.0, -1.0, 4.0, -7.0, 5.0, -6.0, 4.0, -3.0, 9.0, 0.0, -8.0, 6.0, -8.0, -7.0));
	i = (ivec3(2, -4, 1));
	j = i8vec2(ivec2(6, 4294967294));
	k[0] = (mat2(5.0, 7.0, -9.0, -4.0));
	k[1] = (mat2(7.0, -9.0, 7.0, 7.0));
	k[2] = (mat2(-8.0, 5.0, -2.0, -3.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, column_major, binding = 1) buffer BlockB
{
	lowp uint a;
	mediump mat3 b[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB.a = (4u);
	blockB.b[0] = (mat3(-4.0, 2.0, -1.0, 2.0, 2.0, -5.0, 7.0, -5.0, 5.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

struct sA
{
	mediump ivec3 mA;
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	mediump vec2 a[2];
	highp vec3 b[6];
	lowp mat2x3 c[];
};
layout(std430, binding = 2) buffer BlockC
{
	lowp mat2 d;
	mediump int e;
	lowp mat4x2 f;
	sA g[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((b[0]), vec3(-1.0, 4.0, -4.0)) && allOk;
	allOk = compare_vec3((b[1]), vec3(0.0, -2.0, -5.0)) && allOk;
	allOk = compare_vec3((b[2]), vec3(1.0, 5.0, 1.0)) && allOk;
	allOk = compare_vec3((b[3]), vec3(-6.0, 9.0, 8.0)) && allOk;
	allOk = compare_vec3((b[4]), vec3(3.0, 7.0, 5.0)) && allOk;
	allOk = compare_vec3((b[5]), vec3(-6.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(c[0], mat2x3(-2.0, 4.0, -1.0, -1.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x3(c[1], mat2x3(-6.0, 8.0, -7.0, -4.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat2x3(c[2], mat2x3(2.0, 7.0, 8.0, -1.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat2x3(c[3], mat2x3(-1.0, 5.0, -9.0, 2.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat4x2(blockC.f, mat4x2(-9.0, -5.0, -1.0, 5.0, 8.0, -5.0, 7.0, 4.0)) && allOk;
	allOk = compare_ivec3((blockC.g[0].mA), ivec3(-1, -2, 2)) && allOk;
	allOk = compare_ivec3((blockC.g[1].mA), ivec3(2, 9, -4)) && allOk;
	allOk = compare_ivec3((blockC.g[2].mA), ivec3(8, -2, -4)) && allOk;
    if (allOk)
        ac_numPassed++;

	b[0] = (vec3(-2.0, 7.0, -7.0));
	b[1] = (vec3(-6.0, -5.0, -9.0));
	b[2] = (vec3(4.0, -6.0, 2.0));
	b[3] = (vec3(6.0, 4.0, 6.0));
	b[4] = (vec3(-5.0, 2.0, -9.0));
	b[5] = (vec3(-8.0, 3.0, 6.0));
	blockC.d = (mat2(-2.0, 2.0, -6.0, 0.0));
	blockC.e = (-6);
	blockC.g[0].mA = (ivec3(-1, 2, -2));
	blockC.g[1].mA = (ivec3(2, -1, 7));
	blockC.g[2].mA = (ivec3(-1, 3, 2));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, row_major, binding = 1) buffer BlockB
{
	i8vec3 a[];
};
layout(std430, binding = 2) buffer BlockC
{
	u8vec4 b;
	lowp mat4x2 c;
	lowp vec3 d;
} blockC[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(a[0]), ivec3(4294967288, 4294967294, 9)) && allOk;
	allOk = compare_i8vec3(ivec3(a[1]), ivec3(4294967291, 5, 6)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].b), uvec4(8u, 2u, 6u, 8u)) && allOk;
	allOk = compare_mat4x2(blockC[0].c, mat4x2(0.0, -9.0, 1.0, 8.0, 1.0, -2.0, -8.0, -6.0)) && allOk;
	allOk = compare_vec3((blockC[0].d), vec3(-1.0, -8.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = i8vec3(ivec3(1, 1, 4294967292));
	a[1] = i8vec3(ivec3(1, 8, 4294967292));
	blockC[0].b = u8vec4(uvec4(0u, 8u, 9u, 7u));
	blockC[0].c = (mat4x2(-9.0, -6.0, 3.0, 4.0, -1.0, -4.0, -7.0, -8.0));
	blockC[0].d = (vec3(-3.0, 6.0, 5.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

struct sA
{
	i8vec4 mA[2];
};
layout(std140, binding = 1) buffer BlockB
{
	highp ivec2 a;
	mediump uvec4 b;
	u8vec3 c;
	lowp mat4x3 d;
	sA e;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((b), uvec4(4u, 4u, 9u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (ivec2(6, 0));
	b = (uvec4(7u, 8u, 8u, 2u));
	d = (mat4x3(8.0, 0.0, -8.0, -9.0, 5.0, 4.0, -2.0, -5.0, 5.0, -6.0, 3.0, -5.0));
	e.mA[0] = i8vec4(ivec4(0, 4294967287, 3, 4294967287));
	e.mA[1] = i8vec4(ivec4(4294967295, 6, 2, 7));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(binding = 1) buffer BlockB
{
	layout(offset = 0) highp vec2 a;
	layout(offset = 16) highp uvec3 b;
	layout(offset = 28) mediump float c;
	layout(offset = 32) i8vec2 d;
	layout(offset = 34) i8vec3 e;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((c), 4.0) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec2(-2.0, -9.0));
	b = (uvec3(4u, 8u, 5u));
	c = (7.0);
	d = i8vec2(ivec2(4294967289, 4294967290));
	e = i8vec3(ivec3(4294967291, 4294967287, 4));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(binding = 1) buffer BlockB
{
	layout(offset = 0) i8vec3 a[1];
	layout(offset = 4) lowp float b;
	layout(offset = 8) u8vec3 c;
	layout(offset = 16) lowp ivec3 d;
	layout(offset = 32) lowp uvec4 e;
} blockB[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB[0].b), -9.0) && allOk;
	allOk = compare_u8vec3(uvec3(blockB[0].c), uvec3(4u, 4u, 1u)) && allOk;
	allOk = compare_ivec3((blockB[0].d), ivec3(-2, -2, -4)) && allOk;
	allOk = compare_uvec4((blockB[0].e), uvec4(8u, 0u, 9u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = i8vec3(ivec3(4294967290, 4294967295, 8));
	blockB[0].b = (-4.0);
	blockB[0].c = u8vec3(uvec3(5u, 3u, 7u));
	blockB[0].d = (ivec3(-9, -6, 5));
	blockB[0].e = (uvec4(3u, 7u, 0u, 0u));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, row_major, binding = 1) buffer BlockB
{
	lowp uvec2 a[1];
} blockB[];

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB[nonuniformEXT(0)].a[0]), uvec2(5u, 7u)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(1)].a[0]), uvec2(3u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a[0] = (uvec2(7u, 4u));
	blockB[nonuniformEXT(1)].a[0] = (uvec2(8u, 3u));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, binding = 1) readonly buffer Block
{
	mediump vec4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((var), vec4(-2.0, 4.0, -7.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, row_major, binding = 1) readonly buffer Block
{
	highp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -6.0) && allOk;
	allOk = compare_float(var[0][1], -8.0) && allOk;
	allOk = compare_float(var[1][0], 4.0) && allOk;
	allOk = compare_float(var[1][1], -4.0) && allOk;
	allOk = compare_float(var[2][0], 6.0) && allOk;
	allOk = compare_float(var[2][1], -6.0) && allOk;
	allOk = compare_float(var[3][0], 6.0) && allOk;
	allOk = compare_float(var[3][1], -3.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-6.0, -8.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(4.0, -4.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(6.0, -6.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, binding = 1) readonly buffer Block
{
	highp vec2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((var), vec2(6.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, column_major, binding = 1) readonly buffer Block
{
	lowp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 4.0) && allOk;
	allOk = compare_float(var[0][1], -8.0) && allOk;
	allOk = compare_float(var[0][2], -1.0) && allOk;
	allOk = compare_float(var[1][0], -8.0) && allOk;
	allOk = compare_float(var[1][1], -9.0) && allOk;
	allOk = compare_float(var[1][2], 4.0) && allOk;
	allOk = compare_vec3(var[0], vec3(4.0, -8.0, -1.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-8.0, -9.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, row_major, binding = 1) readonly buffer Block
{
	lowp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -8.0) && allOk;
	allOk = compare_float(var[0][1], 8.0) && allOk;
	allOk = compare_float(var[0][2], -7.0) && allOk;
	allOk = compare_float(var[0][3], -5.0) && allOk;
	allOk = compare_float(var[1][0], 5.0) && allOk;
	allOk = compare_float(var[1][1], -6.0) && allOk;
	allOk = compare_float(var[1][2], -5.0) && allOk;
	allOk = compare_float(var[1][3], -9.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-8.0, 8.0, -7.0, -5.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(5.0, -6.0, -5.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, column_major, binding = 1) readonly buffer Block
{
	lowp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -3.0) && allOk;
	allOk = compare_float(var[0][1], -3.0) && allOk;
	allOk = compare_float(var[1][0], -2.0) && allOk;
	allOk = compare_float(var[1][1], -7.0) && allOk;
	allOk = compare_float(var[2][0], 2.0) && allOk;
	allOk = compare_float(var[2][1], 0.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-3.0, -3.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-2.0, -7.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(2.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, column_major, binding = 1) readonly buffer Block
{
	mediump mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var, mat3x2(-2.0, -2.0, 2.0, -8.0, -6.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, column_major, binding = 1) readonly buffer Block
{
	mediump mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var, mat4x2(-9.0, -6.0, 0.0, 3.0, -8.0, 9.0, -8.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, column_major, binding = 1) readonly buffer Block
{
	mediump mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 2.0) && allOk;
	allOk = compare_float(var[0][1], 4.0) && allOk;
	allOk = compare_float(var[1][0], -6.0) && allOk;
	allOk = compare_float(var[1][1], 6.0) && allOk;
	allOk = compare_float(var[2][0], -3.0) && allOk;
	allOk = compare_float(var[2][1], -8.0) && allOk;
	allOk = compare_float(var[3][0], -7.0) && allOk;
	allOk = compare_float(var[3][1], 1.0) && allOk;
	allOk = compare_vec2(var[0], vec2(2.0, 4.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-6.0, 6.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-3.0, -8.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(-7.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, column_major, binding = 1) readonly buffer Block
{
	highp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var, mat4x2(-5.0, 9.0, 3.0, -7.0, 8.0, 0.0, 9.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, binding = 1) readonly buffer Block
{
	lowp mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var, mat4x3(4.0, 1.0, 0.0, 3.0, 8.0, -3.0, -1.0, 2.0, -9.0, 8.0, -7.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, row_major, binding = 1) readonly buffer Block
{
	lowp mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 4.0) && allOk;
	allOk = compare_float(var[0][1], -7.0) && allOk;
	allOk = compare_float(var[0][2], 5.0) && allOk;
	allOk = compare_float(var[1][0], -5.0) && allOk;
	allOk = compare_float(var[1][1], -9.0) && allOk;
	allOk = compare_float(var[1][2], -5.0) && allOk;
	allOk = compare_float(var[2][0], 7.0) && allOk;
	allOk = compare_float(var[2][1], 1.0) && allOk;
	allOk = compare_float(var[2][2], -9.0) && allOk;
	allOk = compare_float(var[3][0], -6.0) && allOk;
	allOk = compare_float(var[3][1], 9.0) && allOk;
	allOk = compare_float(var[3][2], -4.0) && allOk;
	allOk = compare_vec3(var[0], vec3(4.0, -7.0, 5.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-5.0, -9.0, -5.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(7.0, 1.0, -9.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(-6.0, 9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, column_major, binding = 1) readonly buffer Block
{
	mediump mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -4.0) && allOk;
	allOk = compare_float(var[0][1], -6.0) && allOk;
	allOk = compare_float(var[0][2], -1.0) && allOk;
	allOk = compare_float(var[1][0], 3.0) && allOk;
	allOk = compare_float(var[1][1], 4.0) && allOk;
	allOk = compare_float(var[1][2], -7.0) && allOk;
	allOk = compare_float(var[2][0], 1.0) && allOk;
	allOk = compare_float(var[2][1], -6.0) && allOk;
	allOk = compare_float(var[2][2], -2.0) && allOk;
	allOk = compare_float(var[3][0], 7.0) && allOk;
	allOk = compare_float(var[3][1], 2.0) && allOk;
	allOk = compare_float(var[3][2], -6.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-4.0, -6.0, -1.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(3.0, 4.0, -7.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(1.0, -6.0, -2.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(7.0, 2.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, binding = 1) readonly buffer Block
{
	i8vec4 var;
};

bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(var), ivec4(4294967293, 4294967289, 4294967295, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, binding = 1) readonly buffer Block
{
	uint padding;
	lowp uvec3 var;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((padding), 9u) && allOk;
	allOk = compare_uvec3((var), uvec3(0u, 0u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, row_major, binding = 1) readonly buffer Block
{
	float padding;
	lowp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_float(var[0][0], 3.0) && allOk;
	allOk = compare_float(var[0][1], 1.0) && allOk;
	allOk = compare_float(var[0][2], 1.0) && allOk;
	allOk = compare_float(var[1][0], -6.0) && allOk;
	allOk = compare_float(var[1][1], -2.0) && allOk;
	allOk = compare_float(var[1][2], -5.0) && allOk;
	allOk = compare_float(var[2][0], -6.0) && allOk;
	allOk = compare_float(var[2][1], -8.0) && allOk;
	allOk = compare_float(var[2][2], 3.0) && allOk;
	allOk = compare_vec3(var[0], vec3(3.0, 1.0, 1.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-6.0, -2.0, -5.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-6.0, -8.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, column_major, binding = 1) readonly buffer Block
{
	float padding;
	lowp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_mat3(var, mat3(3.0, -1.0, -6.0, 2.0, 1.0, -4.0, 6.0, -5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, binding = 1) readonly buffer Block
{
	float padding;
	highp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -3.0) && allOk;
	allOk = compare_mat2x4(var, mat2x4(-4.0, -4.0, -7.0, -6.0, -3.0, 1.0, 1.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, column_major, binding = 1) readonly buffer Block
{
	float padding;
	lowp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 8.0) && allOk;
	allOk = compare_mat3x2(var, mat3x2(9.0, 7.0, 1.0, -5.0, -5.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, binding = 1) readonly buffer Block
{
	highp mat2x4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0], mat2x4(-5.0, 8.0, 6.0, -5.0, -7.0, -1.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(5.0, -3.0, -3.0, 3.0, 9.0, 3.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(9.0, -8.0, 9.0, -7.0, 5.0, -2.0, 7.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, binding = 1) readonly buffer Block
{
	highp mat3x4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0], mat3x4(-3.0, 3.0, -8.0, 8.0, 6.0, -9.0, -3.0, -1.0, 6.0, 3.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(2.0, -8.0, 1.0, 2.0, -6.0, 8.0, -8.0, -3.0, 2.0, 5.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(-6.0, -3.0, 5.0, 7.0, 3.0, -1.0, -9.0, -1.0, 5.0, 0.0, 1.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, binding = 1) readonly buffer Block
{
	i16vec4 var[3];
};

bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(var[0]), ivec4(-6, -9, 9, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1]), ivec4(-1, -8, 8, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2]), ivec4(3, 4, 0, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, binding = 1) readonly buffer Block
{
	float16_t var[3];
};

bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(var[0]), -7.0) && allOk;
	allOk = compare_float16_t(float(var[1]), 4.0) && allOk;
	allOk = compare_float16_t(float(var[2]), 2.0) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, row_major, binding = 1) readonly buffer Block
{
	highp mat2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0], mat2(-7.0, -9.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(8.0, 9.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(8.0, -6.0, -3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, column_major, binding = 1) readonly buffer Block
{
	highp mat3x4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0], mat3x4(2.0, 9.0, 7.0, -5.0, 2.0, 3.0, 6.0, 6.0, 9.0, -9.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(-4.0, 6.0, 9.0, 4.0, 9.0, 3.0, 2.0, -4.0, -7.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(3.0, -5.0, 6.0, -3.0, 3.0, 2.0, 7.0, -3.0, -7.0, 0.0, 1.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, binding = 1) readonly buffer Block
{
	uint padding;
	highp uvec2 var[3];
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((padding), 6u) && allOk;
	allOk = compare_uvec2((var[0]), uvec2(0u, 6u)) && allOk;
	allOk = compare_uvec2((var[1]), uvec2(7u, 1u)) && allOk;
	allOk = compare_uvec2((var[2]), uvec2(7u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, binding = 1) readonly buffer Block
{
	float padding;
	highp mat2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat2(var[0], mat2(-2.0, 6.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(4.0, -7.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(-1.0, -9.0, -3.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, binding = 1) readonly buffer Block
{
	float padding;
	highp mat3x4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -3.0) && allOk;
	allOk = compare_mat3x4(var[0], mat3x4(3.0, -8.0, 8.0, 6.0, -9.0, -3.0, -1.0, 6.0, 3.0, -1.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(-8.0, 1.0, 2.0, -6.0, 8.0, -8.0, -3.0, 2.0, 5.0, 2.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(-3.0, 5.0, 7.0, 3.0, -1.0, -9.0, -1.0, 5.0, 0.0, 1.0, -6.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, binding = 1) readonly buffer Block
{
	highp ivec4 var[];
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((var[0]), ivec4(-7, 9, -5, 6)) && allOk;
	allOk = compare_ivec4((var[1]), ivec4(3, 4, 2, -3)) && allOk;
	allOk = compare_ivec4((var[2]), ivec4(-3, -3, -5, -5)) && allOk;
	allOk = compare_ivec4((var[3]), ivec4(3, -5, -9, -7)) && allOk;
	allOk = compare_ivec4((var[4]), ivec4(1, 5, 9, 7)) && allOk;
	allOk = compare_ivec4((var[5]), ivec4(-4, -1, 8, -1)) && allOk;
	allOk = compare_ivec4((var[6]), ivec4(4, 3, 6, -6)) && allOk;
	allOk = compare_ivec4((var[7]), ivec4(1, -3, 0, 0)) && allOk;
	allOk = compare_ivec4((var[8]), ivec4(1, -6, 0, -7)) && allOk;
	allOk = compare_ivec4((var[9]), ivec4(6, -4, -4, 0)) && allOk;
	allOk = compare_ivec4((var[10]), ivec4(8, -3, 3, 3)) && allOk;
	allOk = compare_ivec4((var[11]), ivec4(-3, 1, 3, 1)) && allOk;
	allOk = compare_ivec4((var[12]), ivec4(-7, 2, 6, -5)) && allOk;
	allOk = compare_ivec4((var[13]), ivec4(1, 5, 7, 9)) && allOk;
	allOk = compare_ivec4((var[14]), ivec4(-6, 4, 0, 9)) && allOk;
	allOk = compare_ivec4((var[15]), ivec4(-3, 6, -6, -6)) && allOk;
	allOk = compare_ivec4((var[16]), ivec4(1, -6, -3, 5)) && allOk;
	allOk = compare_ivec4((var[17]), ivec4(9, -7, -1, -9)) && allOk;
	allOk = compare_ivec4((var[18]), ivec4(8, -5, 1, -2)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, binding = 1) readonly buffer Block
{
	highp mat2 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0], mat2(-7.0, -2.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(0.0, 4.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(-2.0, -1.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat2(var[3], mat2(6.0, -4.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat2(var[4], mat2(3.0, 2.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(var[5], mat2(8.0, -3.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat2(var[6], mat2(2.0, -7.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2(var[7], mat2(-7.0, 8.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2(var[8], mat2(3.0, -1.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat2(var[9], mat2(2.0, -7.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat2(var[10], mat2(1.0, 7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(var[11], mat2(-5.0, -4.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2(var[12], mat2(-8.0, 7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2(var[13], mat2(-8.0, 1.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat2(var[14], mat2(-3.0, -8.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2(var[15], mat2(5.0, -3.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat2(var[16], mat2(-9.0, 0.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2(var[17], mat2(9.0, 6.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(var[18], mat2(4.0, 4.0, -9.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, row_major, binding = 1) readonly buffer Block
{
	highp mat2 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0], mat2(3.0, 8.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(-3.0, 1.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(-5.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2(var[3], mat2(-4.0, 5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat2(var[4], mat2(6.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2(var[5], mat2(4.0, 8.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2(var[6], mat2(9.0, 8.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2(var[7], mat2(5.0, 0.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2(var[8], mat2(-9.0, 7.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(var[9], mat2(3.0, 9.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2(var[10], mat2(8.0, 8.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2(var[11], mat2(-5.0, -3.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat2(var[12], mat2(4.0, -7.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat2(var[13], mat2(3.0, -5.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat2(var[14], mat2(-5.0, 8.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2(var[15], mat2(-4.0, 2.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(var[16], mat2(5.0, -6.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat2(var[17], mat2(1.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(var[18], mat2(2.0, -1.0, -1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, binding = 1) readonly buffer Block
{
	highp uint var[];
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((var[0]), 3u) && allOk;
	allOk = compare_uint((var[1]), 6u) && allOk;
	allOk = compare_uint((var[2]), 9u) && allOk;
	allOk = compare_uint((var[3]), 0u) && allOk;
	allOk = compare_uint((var[4]), 3u) && allOk;
	allOk = compare_uint((var[5]), 7u) && allOk;
	allOk = compare_uint((var[6]), 6u) && allOk;
	allOk = compare_uint((var[7]), 4u) && allOk;
	allOk = compare_uint((var[8]), 2u) && allOk;
	allOk = compare_uint((var[9]), 5u) && allOk;
	allOk = compare_uint((var[10]), 7u) && allOk;
	allOk = compare_uint((var[11]), 5u) && allOk;
	allOk = compare_uint((var[12]), 7u) && allOk;
	allOk = compare_uint((var[13]), 8u) && allOk;
	allOk = compare_uint((var[14]), 6u) && allOk;
	allOk = compare_uint((var[15]), 9u) && allOk;
	allOk = compare_uint((var[16]), 0u) && allOk;
	allOk = compare_uint((var[17]), 1u) && allOk;
	allOk = compare_uint((var[18]), 4u) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, row_major, binding = 1) readonly buffer Block
{
	highp mat2x4 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0], mat2x4(-7.0, 8.0, 3.0, -7.0, -7.0, -8.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(7.0, 3.0, -5.0, -7.0, 3.0, -9.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(3.0, 6.0, -4.0, 4.0, -2.0, 8.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[3], mat2x4(-8.0, -1.0, -1.0, -6.0, 2.0, -7.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[4], mat2x4(3.0, -9.0, 1.0, -9.0, 8.0, -7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[5], mat2x4(1.0, -1.0, 0.0, 7.0, 2.0, 5.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[6], mat2x4(2.0, 2.0, -8.0, 6.0, 0.0, -1.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[7], mat2x4(-4.0, -2.0, -4.0, -6.0, -3.0, -4.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[8], mat2x4(8.0, -7.0, 8.0, 8.0, 2.0, 3.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[9], mat2x4(9.0, 0.0, -4.0, -7.0, -7.0, 7.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[10], mat2x4(-3.0, -7.0, -5.0, -4.0, -1.0, -7.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[11], mat2x4(7.0, 0.0, -6.0, -2.0, 9.0, -7.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[12], mat2x4(9.0, -3.0, 5.0, -7.0, 2.0, -7.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[13], mat2x4(5.0, -1.0, 2.0, -6.0, -6.0, -7.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[14], mat2x4(-7.0, -8.0, -7.0, -5.0, 1.0, 3.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[15], mat2x4(-9.0, -4.0, 8.0, 5.0, 6.0, -3.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[16], mat2x4(-8.0, 2.0, 8.0, 5.0, -8.0, 1.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[17], mat2x4(-5.0, 2.0, 7.0, -3.0, 3.0, 9.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[18], mat2x4(6.0, 6.0, 2.0, -4.0, -3.0, 8.0, -4.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, binding = 1) readonly buffer Block
{
	u16vec4 var[];
};

bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(var[0]), uvec4(6u, 0u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1]), uvec4(8u, 7u, 5u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2]), uvec4(8u, 7u, 1u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[3]), uvec4(5u, 0u, 5u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[4]), uvec4(9u, 4u, 6u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[5]), uvec4(5u, 3u, 6u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[6]), uvec4(9u, 2u, 2u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[7]), uvec4(9u, 9u, 3u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[8]), uvec4(0u, 0u, 4u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[9]), uvec4(1u, 7u, 1u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[10]), uvec4(8u, 7u, 4u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[11]), uvec4(7u, 0u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[12]), uvec4(0u, 2u, 0u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[13]), uvec4(9u, 8u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[14]), uvec4(5u, 2u, 3u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[15]), uvec4(5u, 9u, 1u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[16]), uvec4(6u, 2u, 0u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[17]), uvec4(5u, 5u, 6u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[18]), uvec4(2u, 6u, 2u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, row_major, binding = 1) readonly buffer Block
{
	highp mat4 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0], mat4(-8.0, 3.0, 4.0, 4.0, -5.0, 8.0, 6.0, 7.0, 4.0, 5.0, 7.0, -3.0, 0.0, 2.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(-1.0, -2.0, -3.0, 1.0, -9.0, -9.0, -6.0, 5.0, 6.0, 7.0, 6.0, 1.0, -8.0, -3.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(6.0, 0.0, 5.0, -6.0, -1.0, -6.0, -1.0, 6.0, 1.0, -1.0, 3.0, -1.0, 6.0, 4.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat4(var[3], mat4(-3.0, 8.0, -3.0, -7.0, -4.0, -6.0, -1.0, 4.0, 9.0, -1.0, 6.0, -4.0, 0.0, -7.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4(var[4], mat4(3.0, -9.0, -5.0, 9.0, -5.0, -7.0, 5.0, 0.0, -5.0, 4.0, 7.0, 2.0, -1.0, 9.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat4(var[5], mat4(6.0, -4.0, -9.0, 2.0, 1.0, 8.0, -6.0, 0.0, -7.0, -8.0, 5.0, -9.0, -9.0, -5.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat4(var[6], mat4(5.0, -7.0, -8.0, -6.0, 7.0, 3.0, 0.0, -4.0, 5.0, -2.0, 3.0, -9.0, 2.0, -2.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat4(var[7], mat4(-6.0, -8.0, 2.0, -5.0, 0.0, -2.0, 7.0, -3.0, 4.0, 4.0, 4.0, 5.0, 7.0, -1.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4(var[8], mat4(-1.0, 5.0, 8.0, -3.0, -9.0, 9.0, -4.0, 5.0, 7.0, -3.0, 5.0, 6.0, -8.0, 2.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat4(var[9], mat4(-3.0, 3.0, 3.0, -3.0, -6.0, -5.0, 3.0, -7.0, -3.0, 7.0, -7.0, 2.0, 7.0, -9.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat4(var[10], mat4(-8.0, -8.0, 8.0, -1.0, -8.0, -1.0, 7.0, 1.0, 7.0, 3.0, -9.0, -3.0, 2.0, -2.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[11], mat4(8.0, 8.0, -7.0, -5.0, 0.0, -1.0, -6.0, -9.0, -8.0, -9.0, -1.0, -7.0, -3.0, -7.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4(var[12], mat4(1.0, 6.0, -6.0, 7.0, 9.0, 3.0, 0.0, 7.0, 0.0, 9.0, -9.0, 1.0, 4.0, -9.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat4(var[13], mat4(7.0, 7.0, -6.0, -6.0, 8.0, -2.0, 4.0, -6.0, 7.0, -4.0, -8.0, -2.0, -2.0, 3.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4(var[14], mat4(0.0, -2.0, -9.0, 6.0, -2.0, -1.0, 8.0, 5.0, 1.0, 7.0, 0.0, -1.0, 1.0, -2.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat4(var[15], mat4(-9.0, -7.0, 3.0, -8.0, 8.0, 3.0, 6.0, -3.0, 8.0, -1.0, 8.0, 0.0, 5.0, 7.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat4(var[16], mat4(0.0, 6.0, -8.0, -6.0, 7.0, 9.0, 7.0, -8.0, 2.0, 6.0, 0.0, 5.0, -8.0, 5.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4(var[17], mat4(0.0, 8.0, 3.0, 5.0, -1.0, 7.0, -5.0, 0.0, -3.0, -6.0, -8.0, -6.0, 6.0, -3.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat4(var[18], mat4(0.0, 3.0, 3.0, 8.0, 3.0, 7.0, -3.0, 1.0, -8.0, 3.0, 7.0, -3.0, 7.0, 5.0, -7.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, row_major, binding = 1) readonly buffer Block
{
	highp mat2x4 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0], mat2x4(-8.0, -3.0, 6.0, -5.0, 2.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(-2.0, 8.0, 0.0, 5.0, -6.0, 9.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(1.0, -1.0, -5.0, 4.0, -7.0, -3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[3], mat2x4(-3.0, -4.0, 0.0, 0.0, 9.0, -6.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[4], mat2x4(4.0, 5.0, 3.0, 4.0, 0.0, -1.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[5], mat2x4(1.0, 5.0, -8.0, -9.0, -5.0, -6.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[6], mat2x4(0.0, 8.0, -1.0, 5.0, -1.0, 4.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[7], mat2x4(5.0, 3.0, 2.0, 2.0, 0.0, -9.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[8], mat2x4(8.0, 0.0, -7.0, -9.0, -2.0, 5.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[9], mat2x4(9.0, -1.0, 4.0, -4.0, 9.0, 6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[10], mat2x4(0.0, 4.0, 7.0, 0.0, 5.0, 3.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[11], mat2x4(4.0, -4.0, -8.0, -7.0, 7.0, -8.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[12], mat2x4(1.0, 3.0, -2.0, -3.0, -6.0, 5.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[13], mat2x4(8.0, -1.0, 5.0, 7.0, -6.0, 1.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[14], mat2x4(-6.0, 4.0, 9.0, -5.0, -9.0, 7.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[15], mat2x4(-9.0, 8.0, -3.0, 8.0, -9.0, -6.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[16], mat2x4(-6.0, -1.0, -6.0, -5.0, -3.0, -1.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[17], mat2x4(-1.0, -8.0, -4.0, 8.0, -6.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[18], mat2x4(-4.0, 9.0, 9.0, 0.0, 9.0, -4.0, -1.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, binding = 1) readonly buffer Block
{
	i16vec3 var[];
};

bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(var[0]), ivec3(3, 4, 8)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1]), ivec3(7, -4, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2]), ivec3(6, -5, -9)) && allOk;
	allOk = compare_i16vec3(ivec3(var[3]), ivec3(9, 4, 2)) && allOk;
	allOk = compare_i16vec3(ivec3(var[4]), ivec3(-6, 6, -2)) && allOk;
	allOk = compare_i16vec3(ivec3(var[5]), ivec3(2, -1, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(var[6]), ivec3(-1, -4, -8)) && allOk;
	allOk = compare_i16vec3(ivec3(var[7]), ivec3(2, -8, 6)) && allOk;
	allOk = compare_i16vec3(ivec3(var[8]), ivec3(0, -3, 3)) && allOk;
	allOk = compare_i16vec3(ivec3(var[9]), ivec3(-6, 0, -1)) && allOk;
	allOk = compare_i16vec3(ivec3(var[10]), ivec3(5, 1, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(var[11]), ivec3(8, 5, 1)) && allOk;
	allOk = compare_i16vec3(ivec3(var[12]), ivec3(6, -2, -7)) && allOk;
	allOk = compare_i16vec3(ivec3(var[13]), ivec3(-6, 6, -1)) && allOk;
	allOk = compare_i16vec3(ivec3(var[14]), ivec3(-4, -6, -9)) && allOk;
	allOk = compare_i16vec3(ivec3(var[15]), ivec3(-5, -9, -4)) && allOk;
	allOk = compare_i16vec3(ivec3(var[16]), ivec3(7, -7, -2)) && allOk;
	allOk = compare_i16vec3(ivec3(var[17]), ivec3(2, 6, 2)) && allOk;
	allOk = compare_i16vec3(ivec3(var[18]), ivec3(-6, 2, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, row_major, buffer_reference) buffer Block
{
	highp mat2x3 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block.var[0][0], -2.0) && allOk;
	allOk = compare_float(block.var[0][1], 6.0) && allOk;
	allOk = compare_float(block.var[0][2], -2.0) && allOk;
	allOk = compare_float(block.var[1][0], 8.0) && allOk;
	allOk = compare_float(block.var[1][1], 7.0) && allOk;
	allOk = compare_float(block.var[1][2], -2.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-2.0, 6.0, -2.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(8.0, 7.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x3(4.0, 6.0, 6.0, 0.0, -9.0, 3.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, column_major, buffer_reference) buffer Block
{
	highp mat2x3 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(block.var, mat2x3(-9.0, -1.0, 8.0, -7.0, 7.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x3(-7.0, 9.0, 4.0, 0.0, -8.0, -2.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, column_major, buffer_reference) buffer Block
{
	lowp mat3x2 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(block.var, mat3x2(3.0, -5.0, -7.0, -2.0, 6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x2(-5.0, 7.0, 6.0, -7.0, 5.0, 0.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, buffer_reference) buffer Block
{
	highp mat3x4 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(block.var, mat3x4(6.0, -1.0, -3.0, -3.0, -7.0, 2.0, 4.0, 3.0, -7.0, 9.0, 7.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x4(6.0, 7.0, -9.0, -7.0, 8.0, 0.0, -5.0, -6.0, 0.0, -3.0, -8.0, 3.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, buffer_reference) buffer Block
{
	int8_t var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(block.var), 4294967292) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = int8_t(4294967290);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, buffer_reference) buffer Block
{
	highp uvec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((block.var), uvec3(5u, 4u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (uvec3(5u, 3u, 8u));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, row_major, buffer_reference) buffer Block
{
	highp mat2 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block.var[0][0], 0.0) && allOk;
	allOk = compare_float(block.var[0][1], 8.0) && allOk;
	allOk = compare_float(block.var[1][0], 2.0) && allOk;
	allOk = compare_float(block.var[1][1], 0.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(0.0, 8.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(2.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2(4.0, -7.0, -8.0, 5.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, buffer_reference) buffer Block
{
	highp mat3 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(block.var, mat3(8.0, -7.0, 5.0, 2.0, 1.0, 1.0, -5.0, 3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3(5.0, 1.0, 8.0, -8.0, -6.0, -2.0, 1.0, 6.0, 1.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, buffer_reference) buffer Block
{
	lowp mat2x3 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(block.var, mat2x3(6.0, 0.0, 4.0, -7.0, -8.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x3(-3.0, -5.0, -2.0, -1.0, -6.0, 1.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, row_major, buffer_reference) buffer Block
{
	highp mat3x2 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block.var[0][0], 1.0) && allOk;
	allOk = compare_float(block.var[0][1], -7.0) && allOk;
	allOk = compare_float(block.var[1][0], -5.0) && allOk;
	allOk = compare_float(block.var[1][1], 1.0) && allOk;
	allOk = compare_float(block.var[2][0], -4.0) && allOk;
	allOk = compare_float(block.var[2][1], 6.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(1.0, -7.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-5.0, 1.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(-4.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(-5.0, 1.0));
	block.var[1] = (vec2(1.0, -5.0));
	block.var[2] = (vec2(1.0, -4.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, buffer_reference) buffer Block
{
	lowp mat3x4 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(block.var, mat3x4(-7.0, -5.0, -3.0, 4.0, 0.0, 4.0, -6.0, 9.0, 3.0, 2.0, 0.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x4(2.0, 6.0, -2.0, -9.0, -5.0, 6.0, -9.0, -5.0, 5.0, -4.0, 9.0, -7.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, column_major, buffer_reference) buffer Block
{
	highp mat3x4 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(block.var, mat3x4(6.0, 3.0, -5.0, -5.0, -3.0, 3.0, -1.0, 2.0, 2.0, -2.0, -8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x4(5.0, 3.0, -6.0, 0.0, -5.0, -3.0, 7.0, -5.0, -3.0, 6.0, 8.0, 7.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, buffer_reference) buffer Block
{
	bool padding;
	bvec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((block.padding), true) && allOk;
	allOk = compare_bvec3((block.var), bvec3(true, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (true);
	block.var = (bvec3(true, false, false));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, column_major, buffer_reference) buffer Block
{
	float padding;
	mediump mat3x2 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.padding), 1.0) && allOk;
	allOk = compare_float(block.var[0][0], 3.0) && allOk;
	allOk = compare_float(block.var[0][1], 9.0) && allOk;
	allOk = compare_float(block.var[1][0], -5.0) && allOk;
	allOk = compare_float(block.var[1][1], -6.0) && allOk;
	allOk = compare_float(block.var[2][0], 3.0) && allOk;
	allOk = compare_float(block.var[2][1], -9.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(3.0, 9.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-6.0);
	block.var[0] = (vec2(-9.0, -3.0));
	block.var[1] = (vec2(1.0, 7.0));
	block.var[2] = (vec2(-8.0, -9.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, row_major, buffer_reference) buffer Block
{
	float padding;
	highp mat4x2 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.padding), 1.0) && allOk;
	allOk = compare_mat4x2(block.var, mat4x2(3.0, -2.0, -4.0, 2.0, -1.0, 0.0, 1.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-8.0);
	block.var[0] = (vec2(3.0, 2.0));
	block.var[1] = (vec2(3.0, -1.0));
	block.var[2] = (vec2(-9.0, -8.0));
	block.var[3] = (vec2(9.0, -4.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, buffer_reference) buffer Block
{
	highp uvec2 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((block.var[0]), uvec2(6u, 0u)) && allOk;
	allOk = compare_uvec2((block.var[1]), uvec2(6u, 7u)) && allOk;
	allOk = compare_uvec2((block.var[2]), uvec2(1u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (uvec2(6u, 1u));
	block.var[1] = (uvec2(8u, 1u));
	block.var[2] = (uvec2(7u, 4u));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, column_major, buffer_reference) buffer Block
{
	highp mat4 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(block.var[0], mat4(3.0, 8.0, 5.0, -7.0, -4.0, 0.0, -1.0, -9.0, 2.0, 9.0, 5.0, 5.0, 6.0, 9.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[1], mat4(8.0, 1.0, -3.0, 1.0, 0.0, -7.0, -4.0, 0.0, 1.0, -6.0, -7.0, 5.0, 2.0, 0.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[2], mat4(-5.0, 8.0, 2.0, 3.0, 8.0, -6.0, 7.0, 9.0, -3.0, 7.0, -8.0, -5.0, 6.0, 4.0, -9.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec4(-7.0, -2.0, 7.0, -7.0));
	block.var[0][1] = (vec4(2.0, -4.0, 3.0, -5.0));
	block.var[0][2] = (vec4(2.0, 3.0, 8.0, 8.0));
	block.var[0][3] = (vec4(3.0, 0.0, -4.0, -1.0));
	block.var[1][0] = (vec4(-3.0, 0.0, 8.0, 1.0));
	block.var[1][1] = (vec4(-8.0, 9.0, 2.0, 7.0));
	block.var[1][2] = (vec4(-2.0, -7.0, -9.0, 1.0));
	block.var[1][3] = (vec4(6.0, -9.0, -1.0, -5.0));
	block.var[2][0] = (vec4(-6.0, -3.0, 7.0, -1.0));
	block.var[2][1] = (vec4(0.0, -1.0, -2.0, 1.0));
	block.var[2][2] = (vec4(-3.0, -1.0, -4.0, 7.0));
	block.var[2][3] = (vec4(-3.0, 1.0, 1.0, -9.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, column_major, buffer_reference) buffer Block
{
	highp mat3x2 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(block.var[0], mat3x2(5.0, -6.0, -5.0, 5.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1], mat3x2(-5.0, -6.0, -8.0, 6.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2], mat3x2(2.0, -8.0, 9.0, -8.0, -3.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3x2(-1.0, -5.0, -1.0, -8.0, 7.0, 8.0));
	block.var[1] = (mat3x2(-4.0, -8.0, 1.0, 5.0, -2.0, 7.0));
	block.var[2] = (mat3x2(4.0, -6.0, 7.0, -6.0, 2.0, 5.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, row_major, buffer_reference) buffer Block
{
	highp mat4x2 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(block.var[0], mat4x2(-2.0, 6.0, 5.0, 7.0, 1.0, -5.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(4.0, -5.0, -7.0, -4.0, 7.0, 7.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(-1.0, 7.0, -9.0, -7.0, -1.0, 8.0, 0.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec2(6.0, 9.0));
	block.var[0][1] = (vec2(-4.0, -4.0));
	block.var[0][2] = (vec2(2.0, 0.0));
	block.var[0][3] = (vec2(-7.0, 3.0));
	block.var[1][0] = (vec2(9.0, -6.0));
	block.var[1][1] = (vec2(8.0, -9.0));
	block.var[1][2] = (vec2(-9.0, -6.0));
	block.var[1][3] = (vec2(-4.0, -6.0));
	block.var[2][0] = (vec2(-8.0, 5.0));
	block.var[2][1] = (vec2(6.0, -8.0));
	block.var[2][2] = (vec2(-8.0, 3.0));
	block.var[2][3] = (vec2(2.0, 8.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, buffer_reference) buffer Block
{
	u8vec4 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(block.var[0]), uvec4(3u, 4u, 6u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[1]), uvec4(1u, 5u, 7u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[2]), uvec4(1u, 4u, 6u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = u8vec4(uvec4(9u, 5u, 9u, 4u));
	block.var[1] = u8vec4(uvec4(6u, 8u, 7u, 3u));
	block.var[2] = u8vec4(uvec4(6u, 7u, 1u, 9u));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, buffer_reference) buffer Block
{
	bvec3 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((block.var[0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((block.var[1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((block.var[2]), bvec3(false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (bvec3(true, true, false));
	block.var[1] = (bvec3(false, true, true));
	block.var[2] = (bvec3(false, false, false));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, column_major, buffer_reference) buffer Block
{
	highp mat2x4 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(block.var[0], mat2x4(-2.0, 4.0, 3.0, 6.0, 3.0, -7.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(6.0, 4.0, 0.0, 9.0, -2.0, 9.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(1.0, -7.0, 0.0, 6.0, -6.0, 9.0, 0.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2x4(-5.0, -7.0, -7.0, 0.0, -1.0, -9.0, 5.0, -5.0));
	block.var[1] = (mat2x4(0.0, 1.0, 8.0, 9.0, 2.0, 4.0, 5.0, 5.0));
	block.var[2] = (mat2x4(3.0, 6.0, 2.0, 7.0, -1.0, -8.0, 7.0, -7.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, buffer_reference) buffer Block
{
	int16_t padding;
	i16vec3 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(block.padding), 3) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[0]), ivec3(4, 8, 7)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[1]), ivec3(-4, 0, 6)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[2]), ivec3(-5, -9, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = int16_t(6);
	block.var[0] = i16vec3(ivec3(1, -2, -3));
	block.var[1] = i16vec3(ivec3(-1, -4, -2));
	block.var[2] = i16vec3(ivec3(-2, 2, 0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, column_major, buffer_reference) buffer Block
{
	highp mat3x2 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(block.var[0], mat3x2(-1.0, 4.0, -9.0, -1.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[1], mat3x2(-8.0, 6.0, 3.0, 1.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[2], mat3x2(-8.0, -3.0, 3.0, -3.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[3], mat3x2(1.0, 1.0, -3.0, -8.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[4], mat3x2(2.0, 8.0, 7.0, 7.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[5], mat3x2(-4.0, -7.0, 1.0, -1.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[6], mat3x2(8.0, -8.0, -7.0, 7.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[7], mat3x2(3.0, 9.0, -2.0, 2.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[8], mat3x2(-3.0, 9.0, 6.0, 2.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[9], mat3x2(7.0, 1.0, 1.0, 8.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[10], mat3x2(2.0, 7.0, -2.0, -4.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[11], mat3x2(-8.0, -1.0, -7.0, 9.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[12], mat3x2(-7.0, 3.0, -2.0, 8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[13], mat3x2(0.0, 9.0, -3.0, 8.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[14], mat3x2(8.0, -3.0, 6.0, 0.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[15], mat3x2(6.0, -8.0, 1.0, -6.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[16], mat3x2(8.0, 9.0, 4.0, 6.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[17], mat3x2(1.0, -7.0, 6.0, 0.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[18], mat3x2(-9.0, 9.0, 5.0, -2.0, -4.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3x2(-2.0, -2.0, -8.0, 0.0, -9.0, 9.0));
	block.var[1] = (mat3x2(0.0, 1.0, -3.0, -6.0, -5.0, -7.0));
	block.var[2] = (mat3x2(5.0, -4.0, 8.0, -1.0, -8.0, 1.0));
	block.var[3] = (mat3x2(2.0, 1.0, -5.0, 0.0, -3.0, 1.0));
	block.var[4] = (mat3x2(-4.0, 4.0, 5.0, -5.0, -6.0, 3.0));
	block.var[5] = (mat3x2(1.0, -2.0, 3.0, -8.0, -6.0, 2.0));
	block.var[6] = (mat3x2(-5.0, -4.0, -8.0, 9.0, -9.0, -8.0));
	block.var[7] = (mat3x2(8.0, -4.0, 1.0, -1.0, 7.0, 0.0));
	block.var[8] = (mat3x2(1.0, -3.0, 6.0, -4.0, -6.0, -5.0));
	block.var[9] = (mat3x2(-6.0, -4.0, 6.0, 4.0, 2.0, -8.0));
	block.var[10] = (mat3x2(2.0, 1.0, -3.0, -3.0, -5.0, -1.0));
	block.var[11] = (mat3x2(6.0, 9.0, 9.0, 9.0, -4.0, 8.0));
	block.var[12] = (mat3x2(-7.0, -7.0, -1.0, 1.0, -5.0, 2.0));
	block.var[13] = (mat3x2(5.0, 5.0, 3.0, -9.0, 7.0, -4.0));
	block.var[14] = (mat3x2(-1.0, -7.0, -6.0, -4.0, -4.0, 8.0));
	block.var[15] = (mat3x2(3.0, -5.0, 8.0, 6.0, 0.0, -2.0));
	block.var[16] = (mat3x2(9.0, -9.0, -7.0, -9.0, -9.0, 4.0));
	block.var[17] = (mat3x2(5.0, 9.0, 6.0, -1.0, 0.0, -2.0));
	block.var[18] = (mat3x2(-2.0, -4.0, 7.0, -2.0, 0.0, 0.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, column_major, buffer_reference) buffer Block
{
	highp mat4x2 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(block.var[0], mat4x2(4.0, -5.0, -2.0, 7.0, 3.0, 2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(-7.0, -1.0, -9.0, 4.0, -9.0, -4.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(-7.0, -7.0, 4.0, 6.0, 6.0, -6.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[3], mat4x2(-1.0, 1.0, 8.0, 3.0, 5.0, -2.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[4], mat4x2(3.0, 8.0, -6.0, 7.0, 4.0, -6.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[5], mat4x2(-5.0, -6.0, 1.0, 5.0, 0.0, -2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[6], mat4x2(3.0, -9.0, 6.0, -5.0, 3.0, -2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[7], mat4x2(-2.0, 0.0, 8.0, 5.0, -1.0, 3.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[8], mat4x2(-2.0, -7.0, 7.0, 1.0, 2.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[9], mat4x2(1.0, 4.0, 5.0, -1.0, -2.0, 5.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[10], mat4x2(-4.0, 2.0, 1.0, -4.0, 1.0, -1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[11], mat4x2(-9.0, 2.0, -1.0, 8.0, 2.0, 1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[12], mat4x2(-6.0, 3.0, 3.0, -2.0, -1.0, -4.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[13], mat4x2(-9.0, -3.0, 4.0, 8.0, 5.0, 2.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[14], mat4x2(-1.0, 1.0, 5.0, -9.0, -5.0, 2.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[15], mat4x2(8.0, 8.0, -9.0, -1.0, 8.0, 1.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[16], mat4x2(1.0, 4.0, 5.0, -5.0, 0.0, 3.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[17], mat4x2(0.0, 7.0, -7.0, -3.0, -7.0, -5.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[18], mat4x2(1.0, 5.0, -7.0, -1.0, 5.0, 3.0, -2.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec2(2.0, -4.0));
	block.var[0][1] = (vec2(-5.0, 3.0));
	block.var[0][2] = (vec2(7.0, 1.0));
	block.var[0][3] = (vec2(8.0, -5.0));
	block.var[1][0] = (vec2(7.0, -3.0));
	block.var[1][1] = (vec2(1.0, -6.0));
	block.var[1][2] = (vec2(9.0, -3.0));
	block.var[1][3] = (vec2(1.0, -5.0));
	block.var[2][0] = (vec2(-8.0, 4.0));
	block.var[2][1] = (vec2(5.0, -9.0));
	block.var[2][2] = (vec2(1.0, -5.0));
	block.var[2][3] = (vec2(-4.0, -2.0));
	block.var[3][0] = (vec2(6.0, -1.0));
	block.var[3][1] = (vec2(-7.0, -5.0));
	block.var[3][2] = (vec2(-2.0, -8.0));
	block.var[3][3] = (vec2(1.0, 3.0));
	block.var[4][0] = (vec2(4.0, 2.0));
	block.var[4][1] = (vec2(-9.0, 2.0));
	block.var[4][2] = (vec2(-3.0, 3.0));
	block.var[4][3] = (vec2(0.0, 1.0));
	block.var[5][0] = (vec2(-5.0, -9.0));
	block.var[5][1] = (vec2(2.0, -2.0));
	block.var[5][2] = (vec2(-3.0, 0.0));
	block.var[5][3] = (vec2(9.0, 6.0));
	block.var[6][0] = (vec2(3.0, -4.0));
	block.var[6][1] = (vec2(2.0, -3.0));
	block.var[6][2] = (vec2(6.0, 5.0));
	block.var[6][3] = (vec2(0.0, -2.0));
	block.var[7][0] = (vec2(-3.0, -2.0));
	block.var[7][1] = (vec2(-7.0, 3.0));
	block.var[7][2] = (vec2(-6.0, 2.0));
	block.var[7][3] = (vec2(9.0, 6.0));
	block.var[8][0] = (vec2(-4.0, 4.0));
	block.var[8][1] = (vec2(0.0, -3.0));
	block.var[8][2] = (vec2(-7.0, 0.0));
	block.var[8][3] = (vec2(-9.0, 1.0));
	block.var[9][0] = (vec2(7.0, 2.0));
	block.var[9][1] = (vec2(1.0, 9.0));
	block.var[9][2] = (vec2(-3.0, 3.0));
	block.var[9][3] = (vec2(-7.0, 9.0));
	block.var[10][0] = (vec2(-4.0, -1.0));
	block.var[10][1] = (vec2(3.0, 6.0));
	block.var[10][2] = (vec2(8.0, 3.0));
	block.var[10][3] = (vec2(1.0, 5.0));
	block.var[11][0] = (vec2(7.0, 0.0));
	block.var[11][1] = (vec2(0.0, -2.0));
	block.var[11][2] = (vec2(3.0, -7.0));
	block.var[11][3] = (vec2(-3.0, 1.0));
	block.var[12][0] = (vec2(4.0, 2.0));
	block.var[12][1] = (vec2(-4.0, 1.0));
	block.var[12][2] = (vec2(5.0, -7.0));
	block.var[12][3] = (vec2(5.0, 5.0));
	block.var[13][0] = (vec2(-5.0, 1.0));
	block.var[13][1] = (vec2(-7.0, -3.0));
	block.var[13][2] = (vec2(-1.0, 1.0));
	block.var[13][3] = (vec2(4.0, 7.0));
	block.var[14][0] = (vec2(-9.0, 1.0));
	block.var[14][1] = (vec2(-6.0, 7.0));
	block.var[14][2] = (vec2(8.0, -7.0));
	block.var[14][3] = (vec2(2.0, 1.0));
	block.var[15][0] = (vec2(-7.0, 4.0));
	block.var[15][1] = (vec2(-4.0, 4.0));
	block.var[15][2] = (vec2(0.0, 7.0));
	block.var[15][3] = (vec2(7.0, -1.0));
	block.var[16][0] = (vec2(0.0, -2.0));
	block.var[16][1] = (vec2(-8.0, 2.0));
	block.var[16][2] = (vec2(8.0, -1.0));
	block.var[16][3] = (vec2(5.0, 2.0));
	block.var[17][0] = (vec2(4.0, 1.0));
	block.var[17][1] = (vec2(-6.0, 7.0));
	block.var[17][2] = (vec2(-7.0, 1.0));
	block.var[17][3] = (vec2(2.0, -4.0));
	block.var[18][0] = (vec2(-8.0, -5.0));
	block.var[18][1] = (vec2(8.0, -8.0));
	block.var[18][2] = (vec2(7.0, -2.0));
	block.var[18][3] = (vec2(-7.0, -7.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, buffer_reference) buffer Block
{
	i8vec3 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(block.var[0]), ivec3(4294967295, 4294967290, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[1]), ivec3(4294967293, 4294967289, 3)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[2]), ivec3(7, 9, 4294967292)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[3]), ivec3(5, 4294967288, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[4]), ivec3(9, 0, 4294967291)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[5]), ivec3(4294967290, 4294967292, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[6]), ivec3(4294967289, 4294967293, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[7]), ivec3(8, 6, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[8]), ivec3(2, 3, 5)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[9]), ivec3(1, 4294967288, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[10]), ivec3(9, 7, 4294967290)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[11]), ivec3(2, 4294967294, 0)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[12]), ivec3(7, 1, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[13]), ivec3(4294967294, 5, 0)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[14]), ivec3(4294967295, 1, 4294967294)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[15]), ivec3(4294967292, 7, 4294967293)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[16]), ivec3(4294967290, 4294967291, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[17]), ivec3(9, 4294967290, 4294967292)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[18]), ivec3(1, 4294967293, 4294967294)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = i8vec3(ivec3(4294967292, 0, 0));
	block.var[1] = i8vec3(ivec3(7, 9, 4294967290));
	block.var[2] = i8vec3(ivec3(4294967288, 9, 4294967288));
	block.var[3] = i8vec3(ivec3(4294967293, 3, 4294967295));
	block.var[4] = i8vec3(ivec3(9, 7, 5));
	block.var[5] = i8vec3(ivec3(5, 4294967293, 6));
	block.var[6] = i8vec3(ivec3(4294967293, 4294967295, 3));
	block.var[7] = i8vec3(ivec3(5, 4294967292, 4294967295));
	block.var[8] = i8vec3(ivec3(4294967293, 8, 4294967290));
	block.var[9] = i8vec3(ivec3(3, 7, 4));
	block.var[10] = i8vec3(ivec3(4294967292, 8, 8));
	block.var[11] = i8vec3(ivec3(4294967294, 8, 1));
	block.var[12] = i8vec3(ivec3(7, 4294967293, 7));
	block.var[13] = i8vec3(ivec3(4294967293, 4294967288, 2));
	block.var[14] = i8vec3(ivec3(4294967287, 4294967295, 4294967293));
	block.var[15] = i8vec3(ivec3(4294967292, 4294967290, 4294967295));
	block.var[16] = i8vec3(ivec3(4294967287, 1, 4294967288));
	block.var[17] = i8vec3(ivec3(4294967291, 8, 6));
	block.var[18] = i8vec3(ivec3(4294967288, 4, 8));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, row_major, buffer_reference) buffer Block
{
	highp mat3x2 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(block.var[0], mat3x2(-4.0, 6.0, 0.0, 6.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1], mat3x2(5.0, -1.0, 1.0, 7.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[2], mat3x2(4.0, -5.0, -2.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[3], mat3x2(-2.0, -1.0, 5.0, 2.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[4], mat3x2(9.0, -5.0, 7.0, 6.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[5], mat3x2(-1.0, -4.0, 0.0, -2.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[6], mat3x2(7.0, 3.0, -1.0, 6.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[7], mat3x2(-8.0, -5.0, 9.0, -3.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[8], mat3x2(-4.0, 6.0, -7.0, 0.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[9], mat3x2(-9.0, 0.0, 9.0, -8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[10], mat3x2(-7.0, -5.0, 3.0, -3.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[11], mat3x2(-3.0, -2.0, 3.0, -8.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[12], mat3x2(-4.0, -8.0, -7.0, -9.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[13], mat3x2(-1.0, -4.0, -4.0, 6.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[14], mat3x2(-8.0, 8.0, -4.0, -8.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[15], mat3x2(-3.0, -7.0, -5.0, -7.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[16], mat3x2(0.0, -8.0, -1.0, 9.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[17], mat3x2(-7.0, -9.0, 6.0, -5.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[18], mat3x2(0.0, 9.0, -1.0, -2.0, 0.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec2(9.0, -4.0));
	block.var[0][1] = (vec2(-7.0, 8.0));
	block.var[0][2] = (vec2(-2.0, -9.0));
	block.var[1][0] = (vec2(-1.0, 7.0));
	block.var[1][1] = (vec2(-3.0, -3.0));
	block.var[1][2] = (vec2(-8.0, 2.0));
	block.var[2][0] = (vec2(-2.0, -1.0));
	block.var[2][1] = (vec2(-3.0, -3.0));
	block.var[2][2] = (vec2(-4.0, 5.0));
	block.var[3][0] = (vec2(9.0, 7.0));
	block.var[3][1] = (vec2(-4.0, 7.0));
	block.var[3][2] = (vec2(1.0, 6.0));
	block.var[4][0] = (vec2(-8.0, 9.0));
	block.var[4][1] = (vec2(8.0, 1.0));
	block.var[4][2] = (vec2(6.0, 8.0));
	block.var[5][0] = (vec2(-1.0, 2.0));
	block.var[5][1] = (vec2(1.0, -1.0));
	block.var[5][2] = (vec2(0.0, 3.0));
	block.var[6][0] = (vec2(-3.0, -2.0));
	block.var[6][1] = (vec2(-9.0, -8.0));
	block.var[6][2] = (vec2(-8.0, 4.0));
	block.var[7][0] = (vec2(-2.0, 9.0));
	block.var[7][1] = (vec2(-1.0, 3.0));
	block.var[7][2] = (vec2(-2.0, 9.0));
	block.var[8][0] = (vec2(-2.0, -4.0));
	block.var[8][1] = (vec2(-1.0, 9.0));
	block.var[8][2] = (vec2(-9.0, -4.0));
	block.var[9][0] = (vec2(-3.0, -2.0));
	block.var[9][1] = (vec2(7.0, -5.0));
	block.var[9][2] = (vec2(-5.0, 0.0));
	block.var[10][0] = (vec2(4.0, -4.0));
	block.var[10][1] = (vec2(5.0, 5.0));
	block.var[10][2] = (vec2(2.0, -3.0));
	block.var[11][0] = (vec2(-5.0, -3.0));
	block.var[11][1] = (vec2(-7.0, 6.0));
	block.var[11][2] = (vec2(-6.0, 8.0));
	block.var[12][0] = (vec2(9.0, 4.0));
	block.var[12][1] = (vec2(-8.0, -6.0));
	block.var[12][2] = (vec2(4.0, -6.0));
	block.var[13][0] = (vec2(-9.0, -3.0));
	block.var[13][1] = (vec2(8.0, 9.0));
	block.var[13][2] = (vec2(4.0, -8.0));
	block.var[14][0] = (vec2(0.0, -4.0));
	block.var[14][1] = (vec2(6.0, -1.0));
	block.var[14][2] = (vec2(-7.0, 8.0));
	block.var[15][0] = (vec2(4.0, 2.0));
	block.var[15][1] = (vec2(2.0, -3.0));
	block.var[15][2] = (vec2(1.0, -6.0));
	block.var[16][0] = (vec2(7.0, 3.0));
	block.var[16][1] = (vec2(-7.0, 5.0));
	block.var[16][2] = (vec2(2.0, -9.0));
	block.var[17][0] = (vec2(-2.0, -8.0));
	block.var[17][1] = (vec2(-9.0, 5.0));
	block.var[17][2] = (vec2(-2.0, 1.0));
	block.var[18][0] = (vec2(2.0, -5.0));
	block.var[18][1] = (vec2(2.0, 8.0));
	block.var[18][2] = (vec2(1.0, 5.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, buffer_reference) buffer Block
{
	float16_t var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(block.var[0]), -7.0) && allOk;
	allOk = compare_float16_t(float(block.var[1]), 4.0) && allOk;
	allOk = compare_float16_t(float(block.var[2]), 2.0) && allOk;
	allOk = compare_float16_t(float(block.var[3]), 0.0) && allOk;
	allOk = compare_float16_t(float(block.var[4]), 5.0) && allOk;
	allOk = compare_float16_t(float(block.var[5]), 9.0) && allOk;
	allOk = compare_float16_t(float(block.var[6]), 5.0) && allOk;
	allOk = compare_float16_t(float(block.var[7]), 4.0) && allOk;
	allOk = compare_float16_t(float(block.var[8]), 7.0) && allOk;
	allOk = compare_float16_t(float(block.var[9]), 5.0) && allOk;
	allOk = compare_float16_t(float(block.var[10]), 1.0) && allOk;
	allOk = compare_float16_t(float(block.var[11]), -3.0) && allOk;
	allOk = compare_float16_t(float(block.var[12]), 2.0) && allOk;
	allOk = compare_float16_t(float(block.var[13]), 1.0) && allOk;
	allOk = compare_float16_t(float(block.var[14]), -8.0) && allOk;
	allOk = compare_float16_t(float(block.var[15]), -2.0) && allOk;
	allOk = compare_float16_t(float(block.var[16]), 2.0) && allOk;
	allOk = compare_float16_t(float(block.var[17]), 3.0) && allOk;
	allOk = compare_float16_t(float(block.var[18]), 2.0) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = float16_t(-8.0);
	block.var[1] = float16_t(9.0);
	block.var[2] = float16_t(-2.0);
	block.var[3] = float16_t(7.0);
	block.var[4] = float16_t(8.0);
	block.var[5] = float16_t(-9.0);
	block.var[6] = float16_t(2.0);
	block.var[7] = float16_t(-8.0);
	block.var[8] = float16_t(-1.0);
	block.var[9] = float16_t(6.0);
	block.var[10] = float16_t(-7.0);
	block.var[11] = float16_t(-5.0);
	block.var[12] = float16_t(8.0);
	block.var[13] = float16_t(-3.0);
	block.var[14] = float16_t(6.0);
	block.var[15] = float16_t(-3.0);
	block.var[16] = float16_t(-8.0);
	block.var[17] = float16_t(1.0);
	block.var[18] = float16_t(3.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, column_major, buffer_reference) buffer Block
{
	highp mat2 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(block.var[0][0], mat2(-6.0, 3.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[0][1], mat2(3.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[0][2], mat2(9.0, -5.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[1][0], mat2(0.0, 8.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[1][1], mat2(-8.0, -4.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[1][2], mat2(8.0, 1.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[2][0], mat2(-1.0, -4.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[2][1], mat2(0.0, -4.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[2][2], mat2(8.0, -3.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[3][0], mat2(5.0, -6.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[3][1], mat2(0.0, 1.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[3][2], mat2(4.0, 3.0, 7.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec2(-2.0, 1.0));
	block.var[0][0][1] = (vec2(-7.0, -1.0));
	block.var[0][1][0] = (vec2(5.0, -3.0));
	block.var[0][1][1] = (vec2(4.0, 8.0));
	block.var[0][2][0] = (vec2(-2.0, -6.0));
	block.var[0][2][1] = (vec2(-5.0, -1.0));
	block.var[1][0][0] = (vec2(3.0, 4.0));
	block.var[1][0][1] = (vec2(-8.0, 6.0));
	block.var[1][1][0] = (vec2(6.0, -2.0));
	block.var[1][1][1] = (vec2(1.0, 3.0));
	block.var[1][2][0] = (vec2(2.0, 1.0));
	block.var[1][2][1] = (vec2(7.0, -2.0));
	block.var[2][0][0] = (vec2(-4.0, 2.0));
	block.var[2][0][1] = (vec2(-1.0, -4.0));
	block.var[2][1][0] = (vec2(-5.0, -8.0));
	block.var[2][1][1] = (vec2(3.0, -7.0));
	block.var[2][2][0] = (vec2(5.0, 0.0));
	block.var[2][2][1] = (vec2(-4.0, -9.0));
	block.var[3][0][0] = (vec2(9.0, 1.0));
	block.var[3][0][1] = (vec2(7.0, 9.0));
	block.var[3][1][0] = (vec2(1.0, 3.0));
	block.var[3][1][1] = (vec2(-3.0, 7.0));
	block.var[3][2][0] = (vec2(1.0, 5.0));
	block.var[3][2][1] = (vec2(4.0, 1.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, row_major, buffer_reference) buffer Block
{
	highp mat3x4 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(block.var[0][0], mat3x4(5.0, -7.0, -9.0, 4.0, 5.0, 3.0, -7.0, -3.0, 7.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1], mat3x4(-9.0, 7.0, -4.0, 5.0, -9.0, -5.0, 2.0, 6.0, -3.0, -5.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2], mat3x4(4.0, 1.0, 3.0, -1.0, -3.0, -2.0, 2.0, 7.0, 5.0, -1.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0], mat3x4(5.0, 1.0, -8.0, -9.0, -6.0, 4.0, 0.0, -9.0, 0.0, -1.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1], mat3x4(-3.0, 6.0, 3.0, 0.0, -4.0, 2.0, 4.0, 3.0, -4.0, 9.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2], mat3x4(-1.0, 6.0, 5.0, -4.0, -5.0, 7.0, -4.0, -5.0, 8.0, -9.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0], mat3x4(2.0, 3.0, 2.0, 5.0, -4.0, -4.0, 2.0, 8.0, 5.0, -5.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1], mat3x4(-3.0, 3.0, -2.0, 6.0, 9.0, -7.0, 8.0, 8.0, 1.0, 9.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2], mat3x4(1.0, -2.0, 4.0, 2.0, 7.0, -2.0, -9.0, 6.0, -4.0, 0.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0], mat3x4(6.0, -8.0, 1.0, 3.0, 2.0, -7.0, 4.0, -9.0, -7.0, 0.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1], mat3x4(-8.0, 4.0, 3.0, 2.0, 2.0, 0.0, -5.0, -4.0, 7.0, 3.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][2], mat3x4(2.0, 0.0, -3.0, 3.0, -7.0, 7.0, -8.0, 9.0, -2.0, 5.0, 8.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat3x4(0.0, 2.0, -8.0, -3.0, 5.0, -1.0, 3.0, -5.0, -9.0, -7.0, 8.0, -9.0));
	block.var[0][1] = (mat3x4(0.0, -5.0, 1.0, -9.0, -1.0, 4.0, 7.0, 4.0, -4.0, -6.0, 0.0, -5.0));
	block.var[0][2] = (mat3x4(-7.0, 5.0, -9.0, -3.0, -7.0, 7.0, 1.0, -4.0, 7.0, -8.0, -2.0, -9.0));
	block.var[1][0] = (mat3x4(0.0, -2.0, -8.0, -5.0, 0.0, 5.0, -2.0, -1.0, 5.0, 8.0, -3.0, 1.0));
	block.var[1][1] = (mat3x4(-1.0, 7.0, 7.0, 7.0, 2.0, -7.0, 8.0, -3.0, -8.0, -2.0, -5.0, -6.0));
	block.var[1][2] = (mat3x4(5.0, 8.0, 9.0, 8.0, 7.0, 0.0, 9.0, 7.0, -3.0, -7.0, -6.0, -5.0));
	block.var[2][0] = (mat3x4(-7.0, -8.0, -2.0, 9.0, -8.0, 3.0, 9.0, 9.0, 5.0, -8.0, -1.0, 2.0));
	block.var[2][1] = (mat3x4(1.0, 5.0, 7.0, 5.0, -4.0, -7.0, -5.0, -9.0, -1.0, 6.0, 2.0, 4.0));
	block.var[2][2] = (mat3x4(-1.0, 2.0, 3.0, -5.0, -6.0, -4.0, 4.0, -7.0, -1.0, 8.0, -9.0, 2.0));
	block.var[3][0] = (mat3x4(-2.0, 9.0, -8.0, 3.0, -5.0, 6.0, -8.0, 3.0, -8.0, 6.0, 6.0, -8.0));
	block.var[3][1] = (mat3x4(-3.0, 2.0, 8.0, 3.0, -1.0, 0.0, -7.0, 5.0, 3.0, 2.0, 9.0, -2.0));
	block.var[3][2] = (mat3x4(-7.0, -5.0, -3.0, 6.0, -7.0, -8.0, -4.0, 1.0, 0.0, 0.0, 1.0, 9.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, row_major, buffer_reference) buffer Block
{
	highp mat3x4 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(block.var[0][0], mat3x4(-2.0, 8.0, -6.0, -5.0, -7.0, 8.0, -7.0, -5.0, 5.0, -2.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1], mat3x4(-7.0, -3.0, -5.0, 8.0, -1.0, -9.0, 0.0, -5.0, -1.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2], mat3x4(2.0, -8.0, 6.0, 3.0, -1.0, -1.0, 2.0, 5.0, -7.0, -3.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0], mat3x4(-4.0, 5.0, -5.0, 2.0, -9.0, 2.0, -4.0, -7.0, -3.0, 1.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1], mat3x4(3.0, -2.0, 3.0, -8.0, -1.0, -1.0, 0.0, 9.0, 3.0, 9.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2], mat3x4(-1.0, -3.0, 1.0, -7.0, 6.0, -9.0, 9.0, 4.0, 1.0, -5.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0], mat3x4(-1.0, 6.0, -8.0, 3.0, 8.0, -8.0, 2.0, 8.0, -6.0, -7.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1], mat3x4(-6.0, 8.0, -9.0, -3.0, 9.0, -9.0, -2.0, -8.0, 8.0, -5.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2], mat3x4(4.0, -3.0, -4.0, 3.0, 7.0, 7.0, 1.0, 8.0, -2.0, 0.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0], mat3x4(5.0, -5.0, 7.0, 4.0, 2.0, 1.0, -1.0, 0.0, -7.0, -6.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1], mat3x4(9.0, 4.0, 1.0, 5.0, 8.0, -4.0, -6.0, -8.0, 8.0, 1.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][2], mat3x4(1.0, 1.0, 8.0, -1.0, 0.0, 9.0, 7.0, -5.0, 1.0, -6.0, -2.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec4(-2.0, -8.0, -5.0, 9.0));
	block.var[0][0][1] = (vec4(-8.0, -4.0, 1.0, -8.0));
	block.var[0][0][2] = (vec4(-4.0, 3.0, 6.0, -4.0));
	block.var[0][1][0] = (vec4(-4.0, -7.0, 6.0, -4.0));
	block.var[0][1][1] = (vec4(0.0, 7.0, -9.0, 4.0));
	block.var[0][1][2] = (vec4(-4.0, -4.0, -8.0, 9.0));
	block.var[0][2][0] = (vec4(2.0, -7.0, 2.0, -6.0));
	block.var[0][2][1] = (vec4(-1.0, -7.0, 7.0, 1.0));
	block.var[0][2][2] = (vec4(0.0, 4.0, 1.0, -9.0));
	block.var[1][0][0] = (vec4(3.0, -3.0, 5.0, 9.0));
	block.var[1][0][1] = (vec4(4.0, -2.0, -3.0, -6.0));
	block.var[1][0][2] = (vec4(8.0, 9.0, -9.0, -5.0));
	block.var[1][1][0] = (vec4(3.0, 4.0, -1.0, -5.0));
	block.var[1][1][1] = (vec4(9.0, -2.0, 4.0, -9.0));
	block.var[1][1][2] = (vec4(1.0, -8.0, -2.0, 1.0));
	block.var[1][2][0] = (vec4(-8.0, -2.0, 9.0, 8.0));
	block.var[1][2][1] = (vec4(-5.0, -8.0, -2.0, 7.0));
	block.var[1][2][2] = (vec4(-3.0, -9.0, 0.0, -9.0));
	block.var[2][0][0] = (vec4(7.0, 4.0, -2.0, -4.0));
	block.var[2][0][1] = (vec4(6.0, -9.0, -7.0, 3.0));
	block.var[2][0][2] = (vec4(-3.0, -6.0, -1.0, 0.0));
	block.var[2][1][0] = (vec4(2.0, 3.0, -1.0, 9.0));
	block.var[2][1][1] = (vec4(-3.0, -9.0, -1.0, 0.0));
	block.var[2][1][2] = (vec4(-9.0, 1.0, 6.0, 5.0));
	block.var[2][2][0] = (vec4(-8.0, 4.0, -8.0, 5.0));
	block.var[2][2][1] = (vec4(4.0, 3.0, -7.0, 5.0));
	block.var[2][2][2] = (vec4(-4.0, 7.0, 2.0, -6.0));
	block.var[3][0][0] = (vec4(-2.0, 4.0, -9.0, -3.0));
	block.var[3][0][1] = (vec4(7.0, 5.0, -1.0, 1.0));
	block.var[3][0][2] = (vec4(6.0, -2.0, -5.0, 9.0));
	block.var[3][1][0] = (vec4(-6.0, 2.0, 5.0, -5.0));
	block.var[3][1][1] = (vec4(2.0, 4.0, -3.0, 1.0));
	block.var[3][1][2] = (vec4(9.0, -1.0, -1.0, -1.0));
	block.var[3][2][0] = (vec4(7.0, -4.0, -7.0, -3.0));
	block.var[3][2][1] = (vec4(9.0, -7.0, -5.0, -9.0));
	block.var[3][2][2] = (vec4(3.0, 9.0, 2.0, -5.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, row_major, buffer_reference) buffer Block
{
	highp mat4x2 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(block.var[0][0], mat4x2(-4.0, 6.0, 0.0, -5.0, 0.0, -1.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1], mat4x2(-6.0, -1.0, 4.0, 0.0, 2.0, -3.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2], mat4x2(-8.0, -1.0, 5.0, 4.0, 9.0, -2.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0], mat4x2(-5.0, -4.0, 3.0, 6.0, 4.0, 3.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1], mat4x2(-1.0, -1.0, 3.0, -6.0, 6.0, 2.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2], mat4x2(2.0, -2.0, -4.0, 7.0, -1.0, -9.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0], mat4x2(-5.0, 5.0, 5.0, 7.0, 5.0, 2.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1], mat4x2(9.0, -6.0, 5.0, -9.0, 6.0, 0.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2], mat4x2(-8.0, 7.0, -6.0, -1.0, -9.0, -7.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0], mat4x2(5.0, 9.0, 3.0, 7.0, 1.0, -3.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1], mat4x2(4.0, 5.0, 5.0, 6.0, 2.0, 0.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][2], mat4x2(5.0, -2.0, 4.0, 7.0, -2.0, 4.0, 5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat4x2(1.0, 8.0, -9.0, 4.0, 1.0, -5.0, 2.0, -5.0));
	block.var[0][1] = (mat4x2(8.0, -8.0, 8.0, 3.0, 2.0, -6.0, 3.0, 8.0));
	block.var[0][2] = (mat4x2(8.0, 9.0, -3.0, -9.0, -2.0, 6.0, -1.0, 6.0));
	block.var[1][0] = (mat4x2(-5.0, -9.0, -1.0, -9.0, 0.0, -4.0, 2.0, -7.0));
	block.var[1][1] = (mat4x2(-3.0, -5.0, 1.0, -5.0, -1.0, 7.0, 4.0, 4.0));
	block.var[1][2] = (mat4x2(-5.0, 2.0, -4.0, -3.0, 0.0, 4.0, -7.0, 5.0));
	block.var[2][0] = (mat4x2(1.0, -9.0, 0.0, -4.0, 2.0, 9.0, -5.0, -3.0));
	block.var[2][1] = (mat4x2(6.0, -4.0, -9.0, 5.0, -5.0, -6.0, 8.0, -5.0));
	block.var[2][2] = (mat4x2(-4.0, -5.0, 6.0, 9.0, -3.0, -4.0, 3.0, -7.0));
	block.var[3][0] = (mat4x2(-8.0, 8.0, -4.0, -6.0, 0.0, -3.0, -6.0, -4.0));
	block.var[3][1] = (mat4x2(5.0, 4.0, 5.0, 7.0, 2.0, -7.0, 8.0, -3.0));
	block.var[3][2] = (mat4x2(8.0, 7.0, 0.0, -5.0, 4.0, 5.0, -6.0, -8.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, row_major, buffer_reference) buffer Block
{
	highp mat4x2 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(block.var[0][0], mat4x2(8.0, -9.0, 9.0, -6.0, -8.0, -7.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1], mat4x2(3.0, 6.0, -4.0, 1.0, 5.0, 2.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2], mat4x2(2.0, -9.0, 8.0, 9.0, 2.0, -7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0], mat4x2(-6.0, 7.0, 6.0, 4.0, 1.0, -8.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1], mat4x2(7.0, 6.0, -2.0, -3.0, 3.0, 9.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2], mat4x2(3.0, -3.0, 6.0, -6.0, -5.0, -5.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0], mat4x2(0.0, 7.0, -8.0, 7.0, 2.0, -1.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1], mat4x2(5.0, -3.0, 1.0, -3.0, -2.0, 3.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2], mat4x2(-6.0, 2.0, 4.0, 7.0, -8.0, 0.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0], mat4x2(-4.0, 3.0, 2.0, -4.0, -2.0, 1.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1], mat4x2(-7.0, 1.0, 1.0, 6.0, -5.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][2], mat4x2(0.0, 8.0, -2.0, 7.0, 8.0, -1.0, -1.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec2(4.0, -9.0));
	block.var[0][0][1] = (vec2(-2.0, 8.0));
	block.var[0][0][2] = (vec2(-4.0, 4.0));
	block.var[0][0][3] = (vec2(9.0, 5.0));
	block.var[0][1][0] = (vec2(-2.0, 4.0));
	block.var[0][1][1] = (vec2(6.0, -8.0));
	block.var[0][1][2] = (vec2(-5.0, -1.0));
	block.var[0][1][3] = (vec2(9.0, 0.0));
	block.var[0][2][0] = (vec2(5.0, -2.0));
	block.var[0][2][1] = (vec2(4.0, -5.0));
	block.var[0][2][2] = (vec2(-2.0, -4.0));
	block.var[0][2][3] = (vec2(6.0, 4.0));
	block.var[1][0][0] = (vec2(5.0, 5.0));
	block.var[1][0][1] = (vec2(-6.0, -5.0));
	block.var[1][0][2] = (vec2(7.0, -6.0));
	block.var[1][0][3] = (vec2(8.0, 5.0));
	block.var[1][1][0] = (vec2(5.0, -5.0));
	block.var[1][1][1] = (vec2(-6.0, -3.0));
	block.var[1][1][2] = (vec2(-1.0, -1.0));
	block.var[1][1][3] = (vec2(-2.0, 6.0));
	block.var[1][2][0] = (vec2(-1.0, -8.0));
	block.var[1][2][1] = (vec2(-5.0, 5.0));
	block.var[1][2][2] = (vec2(5.0, 9.0));
	block.var[1][2][3] = (vec2(-7.0, 0.0));
	block.var[2][0][0] = (vec2(6.0, 4.0));
	block.var[2][0][1] = (vec2(5.0, 2.0));
	block.var[2][0][2] = (vec2(6.0, -4.0));
	block.var[2][0][3] = (vec2(-4.0, 8.0));
	block.var[2][1][0] = (vec2(5.0, -1.0));
	block.var[2][1][1] = (vec2(7.0, 0.0));
	block.var[2][1][2] = (vec2(-7.0, -4.0));
	block.var[2][1][3] = (vec2(1.0, -1.0));
	block.var[2][2][0] = (vec2(7.0, -6.0));
	block.var[2][2][1] = (vec2(9.0, -9.0));
	block.var[2][2][2] = (vec2(7.0, -8.0));
	block.var[2][2][3] = (vec2(5.0, -4.0));
	block.var[3][0][0] = (vec2(4.0, 3.0));
	block.var[3][0][1] = (vec2(9.0, 1.0));
	block.var[3][0][2] = (vec2(-6.0, -3.0));
	block.var[3][0][3] = (vec2(-7.0, 9.0));
	block.var[3][1][0] = (vec2(3.0, 5.0));
	block.var[3][1][1] = (vec2(3.0, -7.0));
	block.var[3][1][2] = (vec2(0.0, 6.0));
	block.var[3][1][3] = (vec2(-8.0, -2.0));
	block.var[3][2][0] = (vec2(7.0, -6.0));
	block.var[3][2][1] = (vec2(2.0, -2.0));
	block.var[3][2][2] = (vec2(8.0, 8.0));
	block.var[3][2][3] = (vec2(1.0, -3.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, buffer_reference) buffer Block
{
	highp ivec2 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((block.var[0][0]), ivec2(6, -1)) && allOk;
	allOk = compare_ivec2((block.var[0][1]), ivec2(7, -5)) && allOk;
	allOk = compare_ivec2((block.var[0][2]), ivec2(-8, 8)) && allOk;
	allOk = compare_ivec2((block.var[1][0]), ivec2(-2, -6)) && allOk;
	allOk = compare_ivec2((block.var[1][1]), ivec2(6, 2)) && allOk;
	allOk = compare_ivec2((block.var[1][2]), ivec2(-2, 7)) && allOk;
	allOk = compare_ivec2((block.var[2][0]), ivec2(-1, -1)) && allOk;
	allOk = compare_ivec2((block.var[2][1]), ivec2(0, 8)) && allOk;
	allOk = compare_ivec2((block.var[2][2]), ivec2(-9, -5)) && allOk;
	allOk = compare_ivec2((block.var[3][0]), ivec2(6, 4)) && allOk;
	allOk = compare_ivec2((block.var[3][1]), ivec2(-8, 3)) && allOk;
	allOk = compare_ivec2((block.var[3][2]), ivec2(7, -6)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (ivec2(-6, 8));
	block.var[0][1] = (ivec2(3, -1));
	block.var[0][2] = (ivec2(-5, -2));
	block.var[1][0] = (ivec2(0, -2));
	block.var[1][1] = (ivec2(5, 2));
	block.var[1][2] = (ivec2(-8, 4));
	block.var[2][0] = (ivec2(-6, -4));
	block.var[2][1] = (ivec2(3, -2));
	block.var[2][2] = (ivec2(5, -7));
	block.var[3][0] = (ivec2(-3, 4));
	block.var[3][1] = (ivec2(1, 6));
	block.var[3][2] = (ivec2(8, 7));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, buffer_reference) buffer Block
{
	bvec3 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((block.var[0][0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((block.var[0][1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((block.var[0][2]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((block.var[1][0]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((block.var[1][1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[1][2]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((block.var[2][0]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((block.var[2][1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((block.var[2][2]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((block.var[3][0]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((block.var[3][1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[3][2]), bvec3(true, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (bvec3(true, true, false));
	block.var[0][1] = (bvec3(false, true, true));
	block.var[0][2] = (bvec3(false, false, false));
	block.var[1][0] = (bvec3(true, false, false));
	block.var[1][1] = (bvec3(true, true, true));
	block.var[1][2] = (bvec3(false, true, true));
	block.var[2][0] = (bvec3(false, true, true));
	block.var[2][1] = (bvec3(true, true, true));
	block.var[2][2] = (bvec3(true, true, true));
	block.var[3][0] = (bvec3(true, false, false));
	block.var[3][1] = (bvec3(false, true, false));
	block.var[3][2] = (bvec3(true, false, false));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, row_major, buffer_reference) buffer Block
{
	highp mat2x3 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(block.var[0][0], mat2x3(3.0, -1.0, 4.0, -3.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1], mat2x3(7.0, 0.0, -3.0, 7.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2], mat2x3(-3.0, -5.0, -4.0, -9.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0], mat2x3(8.0, -6.0, -1.0, 4.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1], mat2x3(-5.0, -2.0, 2.0, -7.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2], mat2x3(3.0, 5.0, 2.0, -6.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0], mat2x3(-1.0, 9.0, -7.0, -1.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1], mat2x3(6.0, -9.0, -4.0, 2.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2], mat2x3(6.0, 0.0, -9.0, -8.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0], mat2x3(0.0, 1.0, -9.0, -2.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1], mat2x3(-4.0, 5.0, -3.0, 7.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][2], mat2x3(9.0, 8.0, 8.0, 5.0, 4.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat2x3(2.0, 0.0, 7.0, -7.0, 9.0, -3.0));
	block.var[0][1] = (mat2x3(1.0, 6.0, -4.0, -4.0, 1.0, 9.0));
	block.var[0][2] = (mat2x3(-1.0, 8.0, 0.0, -8.0, 4.0, 7.0));
	block.var[1][0] = (mat2x3(9.0, 3.0, 8.0, 4.0, 4.0, 2.0));
	block.var[1][1] = (mat2x3(4.0, -1.0, -6.0, -5.0, 9.0, 7.0));
	block.var[1][2] = (mat2x3(-1.0, -3.0, -1.0, 6.0, 4.0, 8.0));
	block.var[2][0] = (mat2x3(-2.0, -1.0, 6.0, 5.0, -8.0, 8.0));
	block.var[2][1] = (mat2x3(-3.0, 5.0, -8.0, -9.0, 9.0, 7.0));
	block.var[2][2] = (mat2x3(-3.0, -1.0, -2.0, 6.0, 2.0, -6.0));
	block.var[3][0] = (mat2x3(-7.0, 6.0, 7.0, -8.0, 5.0, -5.0));
	block.var[3][1] = (mat2x3(5.0, -1.0, 8.0, -7.0, -3.0, -4.0));
	block.var[3][2] = (mat2x3(-5.0, 3.0, -8.0, 9.0, -8.0, 3.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, column_major, buffer_reference) buffer Block
{
	float padding;
	highp mat2x3 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_mat2x3(block.var[0][0], mat2x3(0.0, -9.0, 8.0, -4.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1], mat2x3(-1.0, -3.0, -1.0, 7.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2], mat2x3(9.0, 0.0, 0.0, -2.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0], mat2x3(8.0, -3.0, 7.0, 3.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1], mat2x3(-2.0, -7.0, -8.0, 8.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2], mat2x3(-3.0, 2.0, 8.0, -4.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0], mat2x3(-9.0, 0.0, -9.0, -8.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1], mat2x3(3.0, 9.0, 1.0, 6.0, 0.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2], mat2x3(-3.0, 6.0, 8.0, -6.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0], mat2x3(5.0, 6.0, 7.0, -1.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1], mat2x3(9.0, 5.0, 1.0, 3.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][2], mat2x3(6.0, -5.0, 7.0, -3.0, 1.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (0.0);
	block.var[0][0][0] = (vec3(5.0, 5.0, 0.0));
	block.var[0][0][1] = (vec3(-7.0, 8.0, -7.0));
	block.var[0][1][0] = (vec3(-4.0, 6.0, 1.0));
	block.var[0][1][1] = (vec3(3.0, 2.0, -6.0));
	block.var[0][2][0] = (vec3(5.0, 2.0, 1.0));
	block.var[0][2][1] = (vec3(8.0, -8.0, 2.0));
	block.var[1][0][0] = (vec3(-7.0, 5.0, -4.0));
	block.var[1][0][1] = (vec3(-6.0, -9.0, 3.0));
	block.var[1][1][0] = (vec3(0.0, -7.0, 2.0));
	block.var[1][1][1] = (vec3(-4.0, 1.0, -2.0));
	block.var[1][2][0] = (vec3(-2.0, -5.0, 2.0));
	block.var[1][2][1] = (vec3(5.0, 4.0, 4.0));
	block.var[2][0][0] = (vec3(-1.0, 7.0, 9.0));
	block.var[2][0][1] = (vec3(-2.0, -4.0, 8.0));
	block.var[2][1][0] = (vec3(-4.0, 2.0, 5.0));
	block.var[2][1][1] = (vec3(-1.0, -3.0, 3.0));
	block.var[2][2][0] = (vec3(-2.0, -8.0, 6.0));
	block.var[2][2][1] = (vec3(0.0, 9.0, 1.0));
	block.var[3][0][0] = (vec3(-5.0, -1.0, -6.0));
	block.var[3][0][1] = (vec3(-6.0, 3.0, 1.0));
	block.var[3][1][0] = (vec3(-8.0, -5.0, 8.0));
	block.var[3][1][1] = (vec3(5.0, 8.0, 5.0));
	block.var[3][2][0] = (vec3(5.0, 7.0, -9.0));
	block.var[3][2][1] = (vec3(8.0, 0.0, 8.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, column_major, buffer_reference) buffer Block
{
	float padding;
	highp mat4x2 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.padding), 0.0) && allOk;
	allOk = compare_mat4x2(block.var[0][0], mat4x2(6.0, -3.0, 7.0, 1.0, -8.0, 8.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1], mat4x2(-3.0, -5.0, 5.0, 5.0, 1.0, -7.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2], mat4x2(1.0, -2.0, -3.0, -9.0, 3.0, 9.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0], mat4x2(-2.0, -9.0, 5.0, -5.0, -6.0, 9.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1], mat4x2(-3.0, 5.0, 6.0, -4.0, -8.0, -3.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2], mat4x2(4.0, -9.0, 6.0, 8.0, -3.0, -2.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0], mat4x2(5.0, 0.0, -5.0, 6.0, -8.0, 3.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1], mat4x2(6.0, -5.0, 2.0, -8.0, -2.0, -4.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2], mat4x2(-1.0, 6.0, -3.0, 4.0, 0.0, 9.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0], mat4x2(8.0, 8.0, -7.0, 4.0, 6.0, 2.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1], mat4x2(-8.0, 9.0, -2.0, -7.0, -9.0, 1.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][2], mat4x2(0.0, 3.0, 9.0, -8.0, -1.0, 4.0, -2.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (8.0);
	block.var[0][0] = (mat4x2(-5.0, 3.0, 0.0, -9.0, 4.0, -5.0, 3.0, 6.0));
	block.var[0][1] = (mat4x2(3.0, 6.0, -6.0, 0.0, -3.0, -2.0, -4.0, 5.0));
	block.var[0][2] = (mat4x2(4.0, 1.0, 0.0, 7.0, -9.0, -4.0, 5.0, 6.0));
	block.var[1][0] = (mat4x2(1.0, 0.0, 3.0, 2.0, -5.0, -4.0, 5.0, 5.0));
	block.var[1][1] = (mat4x2(-4.0, -7.0, -8.0, 9.0, -4.0, 5.0, 5.0, -1.0));
	block.var[1][2] = (mat4x2(6.0, -6.0, 5.0, 4.0, -3.0, 1.0, -4.0, 1.0));
	block.var[2][0] = (mat4x2(-6.0, 2.0, 4.0, 7.0, 1.0, 9.0, 5.0, 8.0));
	block.var[2][1] = (mat4x2(-7.0, 6.0, -7.0, -4.0, 5.0, 3.0, -2.0, -2.0));
	block.var[2][2] = (mat4x2(-5.0, -1.0, 1.0, -8.0, 4.0, 9.0, 2.0, -5.0));
	block.var[3][0] = (mat4x2(6.0, 0.0, 4.0, -8.0, -7.0, 1.0, 1.0, 1.0));
	block.var[3][1] = (mat4x2(-9.0, -1.0, 6.0, -9.0, -7.0, -8.0, 8.0, -2.0));
	block.var[3][2] = (mat4x2(7.0, 8.0, -9.0, 4.0, -3.0, 0.0, -7.0, 4.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, row_major, buffer_reference) buffer Block
{
	highp mat4x3 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(block.var[0][0][0], mat4x3(3.0, 9.0, 5.0, 5.0, 8.0, -9.0, 1.0, -3.0, 3.0, 6.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][1], mat4x3(-9.0, -2.0, -1.0, 6.0, 6.0, 9.0, 0.0, 3.0, -4.0, 2.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][2], mat4x3(6.0, 8.0, 7.0, 6.0, 1.0, 3.0, 8.0, -4.0, 7.0, -9.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][0], mat4x3(-1.0, 1.0, 9.0, 7.0, 0.0, 9.0, -1.0, -1.0, -7.0, 0.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][1], mat4x3(5.0, 7.0, -6.0, -7.0, 6.0, -5.0, -4.0, -1.0, 8.0, 7.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][2], mat4x3(-2.0, -5.0, -2.0, -2.0, 9.0, 9.0, -6.0, 0.0, -5.0, 6.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][0], mat4x3(-4.0, -7.0, 7.0, -5.0, 2.0, 4.0, 9.0, 2.0, 6.0, -3.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][1], mat4x3(3.0, -3.0, 0.0, 8.0, 6.0, -1.0, 9.0, 6.0, 0.0, 4.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][2], mat4x3(6.0, 2.0, -1.0, -6.0, -9.0, 7.0, -9.0, -9.0, 8.0, 6.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][0], mat4x3(8.0, -9.0, 6.0, -7.0, 6.0, 5.0, -5.0, -1.0, 5.0, -7.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][1], mat4x3(8.0, 3.0, -1.0, 2.0, 5.0, -8.0, 0.0, -6.0, 4.0, 6.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][2], mat4x3(8.0, 4.0, -1.0, -5.0, 0.0, -6.0, 3.0, 7.0, -8.0, -4.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][0], mat4x3(-9.0, -5.0, -9.0, 1.0, -9.0, 3.0, 4.0, 0.0, -8.0, -3.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][1], mat4x3(-7.0, -4.0, 0.0, 2.0, 3.0, -9.0, -3.0, 0.0, -7.0, 8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][2], mat4x3(-7.0, 4.0, 9.0, 8.0, -5.0, -5.0, 6.0, 8.0, -7.0, 1.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][0], mat4x3(6.0, -3.0, 0.0, -6.0, -3.0, -6.0, 8.0, 4.0, 2.0, 4.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][1], mat4x3(-1.0, -7.0, 6.0, -3.0, -8.0, -4.0, 6.0, 4.0, 6.0, 3.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][2], mat4x3(2.0, -8.0, 4.0, 7.0, -9.0, -4.0, 2.0, -4.0, -9.0, 4.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][0], mat4x3(0.0, -9.0, -1.0, 9.0, 2.0, -9.0, 8.0, 0.0, 1.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][1], mat4x3(5.0, -5.0, -1.0, -9.0, 7.0, 5.0, 0.0, 7.0, -3.0, -7.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][2], mat4x3(-3.0, 1.0, 7.0, -9.0, 6.0, 7.0, -5.0, 8.0, -2.0, -6.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][0], mat4x3(-7.0, -3.0, 9.0, -6.0, 0.0, -2.0, -4.0, 8.0, 3.0, -4.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][1], mat4x3(-5.0, -4.0, -7.0, 2.0, -5.0, -5.0, 2.0, 4.0, -5.0, 4.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][2], mat4x3(2.0, 3.0, -9.0, -6.0, -1.0, -7.0, 8.0, -6.0, 1.0, 7.0, -2.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4x3(-5.0, 9.0, 2.0, -5.0, 1.0, 6.0, 4.0, 3.0, 9.0, -4.0, 3.0, 1.0));
	block.var[0][0][1] = (mat4x3(-5.0, 2.0, 4.0, -6.0, 1.0, 3.0, -6.0, -1.0, -4.0, 3.0, 9.0, -1.0));
	block.var[0][0][2] = (mat4x3(4.0, 2.0, 8.0, -9.0, -8.0, -5.0, -9.0, -6.0, -7.0, 6.0, -5.0, -5.0));
	block.var[0][1][0] = (mat4x3(4.0, 9.0, 7.0, 5.0, 7.0, -2.0, -4.0, -2.0, 3.0, -6.0, 0.0, -7.0));
	block.var[0][1][1] = (mat4x3(9.0, -6.0, -9.0, 5.0, -1.0, -2.0, 4.0, 7.0, 2.0, 8.0, -7.0, 9.0));
	block.var[0][1][2] = (mat4x3(7.0, 3.0, 4.0, 9.0, 8.0, -1.0, -6.0, -4.0, 5.0, -8.0, -4.0, 1.0));
	block.var[1][0][0] = (mat4x3(9.0, -7.0, -4.0, -3.0, -2.0, 6.0, 2.0, 3.0, -8.0, -7.0, 9.0, -1.0));
	block.var[1][0][1] = (mat4x3(9.0, 0.0, 0.0, 7.0, 7.0, 9.0, -7.0, -4.0, 7.0, -5.0, 0.0, -1.0));
	block.var[1][0][2] = (mat4x3(-4.0, 1.0, 3.0, -5.0, -2.0, -6.0, -8.0, -7.0, -9.0, -2.0, 2.0, 9.0));
	block.var[1][1][0] = (mat4x3(-1.0, 6.0, 7.0, -9.0, 0.0, 8.0, -4.0, 2.0, 0.0, 3.0, -3.0, 1.0));
	block.var[1][1][1] = (mat4x3(7.0, 7.0, -6.0, 0.0, 1.0, 7.0, 2.0, 8.0, -2.0, -5.0, 8.0, 3.0));
	block.var[1][1][2] = (mat4x3(-1.0, -5.0, -8.0, 1.0, 4.0, 0.0, 2.0, -3.0, 8.0, -5.0, -9.0, 4.0));
	block.var[2][0][0] = (mat4x3(-8.0, -3.0, -8.0, -5.0, 2.0, -9.0, 2.0, 9.0, 8.0, 7.0, 9.0, -6.0));
	block.var[2][0][1] = (mat4x3(8.0, -8.0, -9.0, 9.0, 8.0, -3.0, 4.0, 8.0, 2.0, -9.0, -8.0, 5.0));
	block.var[2][0][2] = (mat4x3(-8.0, 9.0, 8.0, -9.0, 8.0, -3.0, -9.0, -6.0, 1.0, -1.0, -2.0, -1.0));
	block.var[2][1][0] = (mat4x3(5.0, -9.0, 3.0, -6.0, -1.0, 2.0, 6.0, -2.0, 0.0, 5.0, -5.0, -5.0));
	block.var[2][1][1] = (mat4x3(-3.0, -7.0, -1.0, -5.0, 2.0, -7.0, 9.0, 1.0, 1.0, -5.0, 8.0, -6.0));
	block.var[2][1][2] = (mat4x3(-7.0, -1.0, 4.0, 4.0, -4.0, -4.0, -1.0, -2.0, 0.0, -3.0, 8.0, 7.0));
	block.var[3][0][0] = (mat4x3(8.0, -3.0, -6.0, 2.0, -2.0, 0.0, -4.0, -5.0, 8.0, 2.0, 9.0, -1.0));
	block.var[3][0][1] = (mat4x3(1.0, -6.0, -5.0, -5.0, 6.0, 8.0, 7.0, 0.0, 7.0, 1.0, 4.0, 9.0));
	block.var[3][0][2] = (mat4x3(-4.0, 8.0, 5.0, -4.0, -9.0, -1.0, 0.0, 5.0, -4.0, -1.0, -3.0, -5.0));
	block.var[3][1][0] = (mat4x3(-8.0, -4.0, -4.0, 2.0, 3.0, -9.0, 2.0, -1.0, -4.0, 3.0, 5.0, 1.0));
	block.var[3][1][1] = (mat4x3(1.0, -2.0, 8.0, -8.0, -5.0, -8.0, -8.0, -7.0, 7.0, -9.0, 8.0, -2.0));
	block.var[3][1][2] = (mat4x3(-7.0, -4.0, 2.0, 2.0, 5.0, 7.0, -5.0, 5.0, 2.0, -2.0, 9.0, -6.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, buffer_reference) buffer Block
{
	uint16_t var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(block.var[0][0][0]), 9u) && allOk;
	allOk = compare_uint16_t(uint(block.var[0][0][1]), 5u) && allOk;
	allOk = compare_uint16_t(uint(block.var[0][0][2]), 4u) && allOk;
	allOk = compare_uint16_t(uint(block.var[0][1][0]), 7u) && allOk;
	allOk = compare_uint16_t(uint(block.var[0][1][1]), 8u) && allOk;
	allOk = compare_uint16_t(uint(block.var[0][1][2]), 2u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][0][0]), 1u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][0][1]), 0u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][0][2]), 9u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][1][0]), 7u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][1][1]), 1u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][1][2]), 0u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][0][0]), 2u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][0][1]), 0u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][0][2]), 6u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][1][0]), 8u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][1][1]), 6u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][1][2]), 6u) && allOk;
	allOk = compare_uint16_t(uint(block.var[3][0][0]), 9u) && allOk;
	allOk = compare_uint16_t(uint(block.var[3][0][1]), 8u) && allOk;
	allOk = compare_uint16_t(uint(block.var[3][0][2]), 1u) && allOk;
	allOk = compare_uint16_t(uint(block.var[3][1][0]), 4u) && allOk;
	allOk = compare_uint16_t(uint(block.var[3][1][1]), 6u) && allOk;
	allOk = compare_uint16_t(uint(block.var[3][1][2]), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = uint16_t(9u);
	block.var[0][0][1] = uint16_t(1u);
	block.var[0][0][2] = uint16_t(1u);
	block.var[0][1][0] = uint16_t(3u);
	block.var[0][1][1] = uint16_t(1u);
	block.var[0][1][2] = uint16_t(0u);
	block.var[1][0][0] = uint16_t(0u);
	block.var[1][0][1] = uint16_t(7u);
	block.var[1][0][2] = uint16_t(5u);
	block.var[1][1][0] = uint16_t(2u);
	block.var[1][1][1] = uint16_t(1u);
	block.var[1][1][2] = uint16_t(1u);
	block.var[2][0][0] = uint16_t(8u);
	block.var[2][0][1] = uint16_t(1u);
	block.var[2][0][2] = uint16_t(9u);
	block.var[2][1][0] = uint16_t(2u);
	block.var[2][1][1] = uint16_t(9u);
	block.var[2][1][2] = uint16_t(3u);
	block.var[3][0][0] = uint16_t(7u);
	block.var[3][0][1] = uint16_t(2u);
	block.var[3][0][2] = uint16_t(6u);
	block.var[3][1][0] = uint16_t(0u);
	block.var[3][1][1] = uint16_t(8u);
	block.var[3][1][2] = uint16_t(4u);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, buffer_reference) buffer Block
{
	highp ivec2 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((block.var[0][0][0]), ivec2(6, -1)) && allOk;
	allOk = compare_ivec2((block.var[0][0][1]), ivec2(7, -5)) && allOk;
	allOk = compare_ivec2((block.var[0][0][2]), ivec2(-8, 8)) && allOk;
	allOk = compare_ivec2((block.var[0][1][0]), ivec2(-4, 1)) && allOk;
	allOk = compare_ivec2((block.var[0][1][1]), ivec2(-3, -1)) && allOk;
	allOk = compare_ivec2((block.var[0][1][2]), ivec2(2, 1)) && allOk;
	allOk = compare_ivec2((block.var[1][0][0]), ivec2(-2, -6)) && allOk;
	allOk = compare_ivec2((block.var[1][0][1]), ivec2(6, 2)) && allOk;
	allOk = compare_ivec2((block.var[1][0][2]), ivec2(-2, 7)) && allOk;
	allOk = compare_ivec2((block.var[1][1][0]), ivec2(-4, -3)) && allOk;
	allOk = compare_ivec2((block.var[1][1][1]), ivec2(-9, 0)) && allOk;
	allOk = compare_ivec2((block.var[1][1][2]), ivec2(9, 8)) && allOk;
	allOk = compare_ivec2((block.var[2][0][0]), ivec2(-1, -1)) && allOk;
	allOk = compare_ivec2((block.var[2][0][1]), ivec2(0, 8)) && allOk;
	allOk = compare_ivec2((block.var[2][0][2]), ivec2(-9, -5)) && allOk;
	allOk = compare_ivec2((block.var[2][1][0]), ivec2(6, 3)) && allOk;
	allOk = compare_ivec2((block.var[2][1][1]), ivec2(-5, -3)) && allOk;
	allOk = compare_ivec2((block.var[2][1][2]), ivec2(-4, 7)) && allOk;
	allOk = compare_ivec2((block.var[3][0][0]), ivec2(6, 4)) && allOk;
	allOk = compare_ivec2((block.var[3][0][1]), ivec2(-8, 3)) && allOk;
	allOk = compare_ivec2((block.var[3][0][2]), ivec2(7, -6)) && allOk;
	allOk = compare_ivec2((block.var[3][1][0]), ivec2(-3, -4)) && allOk;
	allOk = compare_ivec2((block.var[3][1][1]), ivec2(8, -5)) && allOk;
	allOk = compare_ivec2((block.var[3][1][2]), ivec2(-2, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (ivec2(-6, 8));
	block.var[0][0][1] = (ivec2(3, -1));
	block.var[0][0][2] = (ivec2(-5, -2));
	block.var[0][1][0] = (ivec2(4, 1));
	block.var[0][1][1] = (ivec2(1, 9));
	block.var[0][1][2] = (ivec2(-2, -9));
	block.var[1][0][0] = (ivec2(0, -2));
	block.var[1][0][1] = (ivec2(5, 2));
	block.var[1][0][2] = (ivec2(-8, 4));
	block.var[1][1][0] = (ivec2(9, 6));
	block.var[1][1][1] = (ivec2(-8, 1));
	block.var[1][1][2] = (ivec2(-3, 2));
	block.var[2][0][0] = (ivec2(-6, -4));
	block.var[2][0][1] = (ivec2(3, -2));
	block.var[2][0][2] = (ivec2(5, -7));
	block.var[2][1][0] = (ivec2(-3, -1));
	block.var[2][1][1] = (ivec2(-4, 6));
	block.var[2][1][2] = (ivec2(-4, -7));
	block.var[3][0][0] = (ivec2(-3, 4));
	block.var[3][0][1] = (ivec2(1, 6));
	block.var[3][0][2] = (ivec2(8, 7));
	block.var[3][1][0] = (ivec2(-9, 1));
	block.var[3][1][1] = (ivec2(8, 1));
	block.var[3][1][2] = (ivec2(-8, 3));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, column_major, buffer_reference) buffer Block
{
	highp mat4 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(block.var[0][0][0], mat4(3.0, 8.0, 5.0, -7.0, -4.0, 0.0, -1.0, -9.0, 2.0, 9.0, 5.0, 5.0, 6.0, 9.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][1], mat4(8.0, 1.0, -3.0, 1.0, 0.0, -7.0, -4.0, 0.0, 1.0, -6.0, -7.0, 5.0, 2.0, 0.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][2], mat4(-5.0, 8.0, 2.0, 3.0, 8.0, -6.0, 7.0, 9.0, -3.0, 7.0, -8.0, -5.0, 6.0, 4.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][0], mat4(4.0, 4.0, 9.0, -7.0, 9.0, 2.0, 3.0, 7.0, 0.0, -9.0, 2.0, -1.0, -8.0, -7.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][1], mat4(0.0, -3.0, -1.0, -1.0, -6.0, 1.0, -8.0, 1.0, 5.0, 0.0, 2.0, -1.0, -1.0, -6.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][2], mat4(7.0, 5.0, -2.0, -4.0, 0.0, 1.0, -6.0, -3.0, -1.0, -7.0, -7.0, -6.0, 1.0, -4.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][0], mat4(7.0, 0.0, -6.0, -1.0, 5.0, 0.0, -3.0, -3.0, 6.0, -5.0, 1.0, 4.0, -5.0, -7.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][1], mat4(-2.0, -3.0, 2.0, -9.0, 6.0, -8.0, 8.0, 2.0, -3.0, -9.0, 8.0, 1.0, -4.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][2], mat4(9.0, -2.0, -1.0, -7.0, 6.0, -6.0, -3.0, -9.0, -3.0, -7.0, -2.0, 2.0, -9.0, -2.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][0], mat4(8.0, -3.0, 9.0, 6.0, -2.0, -9.0, 4.0, 5.0, 6.0, 4.0, -3.0, -8.0, 6.0, 5.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][1], mat4(-2.0, 5.0, 8.0, 4.0, -4.0, 9.0, 3.0, -5.0, 1.0, -6.0, 1.0, -5.0, 8.0, 7.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][2], mat4(3.0, 0.0, -3.0, 3.0, 2.0, -8.0, -7.0, 8.0, -3.0, 2.0, -9.0, -7.0, 1.0, -5.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][0], mat4(2.0, -3.0, 7.0, 9.0, 7.0, -1.0, 3.0, 6.0, -3.0, 2.0, -2.0, 7.0, -9.0, 0.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][1], mat4(-2.0, -1.0, -6.0, -6.0, 5.0, -8.0, 7.0, 3.0, -6.0, 4.0, -8.0, -1.0, 1.0, 4.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][2], mat4(-7.0, -2.0, -4.0, -6.0, -6.0, 8.0, 5.0, -4.0, -7.0, 7.0, -4.0, -9.0, -7.0, -1.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][0], mat4(0.0, 0.0, -1.0, 0.0, -9.0, 5.0, 4.0, 0.0, -6.0, -7.0, 1.0, -9.0, -4.0, -4.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][1], mat4(0.0, 5.0, -7.0, -5.0, 9.0, 2.0, -2.0, 5.0, 8.0, -7.0, 9.0, 9.0, -8.0, 3.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][2], mat4(5.0, 3.0, 5.0, -5.0, 6.0, 3.0, 0.0, -9.0, -1.0, 0.0, -8.0, 3.0, 4.0, -1.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][0], mat4(5.0, -4.0, -1.0, -3.0, 3.0, 2.0, 1.0, -6.0, 3.0, 5.0, -4.0, 0.0, 2.0, -4.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][1], mat4(-6.0, -9.0, -6.0, -9.0, -4.0, 2.0, 5.0, 4.0, -6.0, -2.0, -5.0, 7.0, 9.0, -4.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][2], mat4(-2.0, 1.0, -2.0, 0.0, -7.0, 2.0, -6.0, -5.0, 2.0, -1.0, -8.0, 8.0, 2.0, -9.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][0], mat4(-6.0, -9.0, -8.0, -2.0, -6.0, -8.0, 8.0, 4.0, 4.0, 1.0, 5.0, 0.0, -1.0, 4.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][1], mat4(-2.0, 2.0, 9.0, 7.0, -2.0, -6.0, -3.0, -7.0, 1.0, 2.0, -3.0, 0.0, -5.0, 5.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][2], mat4(3.0, 5.0, 2.0, -6.0, 9.0, 7.0, 4.0, 4.0, 5.0, 8.0, 4.0, -9.0, 3.0, -7.0, 7.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(-7.0, -2.0, 7.0, -7.0));
	block.var[0][0][0][1] = (vec4(2.0, -4.0, 3.0, -5.0));
	block.var[0][0][0][2] = (vec4(2.0, 3.0, 8.0, 8.0));
	block.var[0][0][0][3] = (vec4(3.0, 0.0, -4.0, -1.0));
	block.var[0][0][1][0] = (vec4(-3.0, 0.0, 8.0, 1.0));
	block.var[0][0][1][1] = (vec4(-8.0, 9.0, 2.0, 7.0));
	block.var[0][0][1][2] = (vec4(-2.0, -7.0, -9.0, 1.0));
	block.var[0][0][1][3] = (vec4(6.0, -9.0, -1.0, -5.0));
	block.var[0][0][2][0] = (vec4(-6.0, -3.0, 7.0, -1.0));
	block.var[0][0][2][1] = (vec4(0.0, -1.0, -2.0, 1.0));
	block.var[0][0][2][2] = (vec4(-3.0, -1.0, -4.0, 7.0));
	block.var[0][0][2][3] = (vec4(-3.0, 1.0, 1.0, -9.0));
	block.var[0][1][0][0] = (vec4(-3.0, 9.0, 5.0, -2.0));
	block.var[0][1][0][1] = (vec4(-7.0, 3.0, 3.0, 1.0));
	block.var[0][1][0][2] = (vec4(-7.0, -9.0, -5.0, -7.0));
	block.var[0][1][0][3] = (vec4(-7.0, -8.0, -2.0, -8.0));
	block.var[0][1][1][0] = (vec4(3.0, 7.0, 3.0, 7.0));
	block.var[0][1][1][1] = (vec4(-8.0, 9.0, -9.0, -9.0));
	block.var[0][1][1][2] = (vec4(3.0, -4.0, -8.0, 3.0));
	block.var[0][1][1][3] = (vec4(9.0, -7.0, -5.0, -5.0));
	block.var[0][1][2][0] = (vec4(2.0, 2.0, -3.0, 9.0));
	block.var[0][1][2][1] = (vec4(0.0, -6.0, 7.0, 1.0));
	block.var[0][1][2][2] = (vec4(-1.0, 2.0, -7.0, 2.0));
	block.var[0][1][2][3] = (vec4(-1.0, -6.0, -8.0, 1.0));
	block.var[1][0][0][0] = (vec4(-3.0, 2.0, 9.0, -4.0));
	block.var[1][0][0][1] = (vec4(2.0, 9.0, -9.0, -2.0));
	block.var[1][0][0][2] = (vec4(-1.0, 1.0, -9.0, 0.0));
	block.var[1][0][0][3] = (vec4(-7.0, 7.0, -3.0, -9.0));
	block.var[1][0][1][0] = (vec4(-1.0, 0.0, 7.0, 7.0));
	block.var[1][0][1][1] = (vec4(-5.0, -2.0, -6.0, 0.0));
	block.var[1][0][1][2] = (vec4(-2.0, 1.0, -2.0, 4.0));
	block.var[1][0][1][3] = (vec4(4.0, 0.0, 0.0, -2.0));
	block.var[1][0][2][0] = (vec4(4.0, 7.0, -5.0, -3.0));
	block.var[1][0][2][1] = (vec4(9.0, 1.0, 5.0, 5.0));
	block.var[1][0][2][2] = (vec4(9.0, -4.0, -6.0, 8.0));
	block.var[1][0][2][3] = (vec4(1.0, -5.0, 5.0, -3.0));
	block.var[1][1][0][0] = (vec4(1.0, -4.0, -6.0, -4.0));
	block.var[1][1][0][1] = (vec4(-9.0, 0.0, -2.0, 6.0));
	block.var[1][1][0][2] = (vec4(3.0, 3.0, 4.0, -6.0));
	block.var[1][1][0][3] = (vec4(-7.0, 9.0, -1.0, 6.0));
	block.var[1][1][1][0] = (vec4(-8.0, -1.0, 0.0, -8.0));
	block.var[1][1][1][1] = (vec4(3.0, -1.0, 9.0, -7.0));
	block.var[1][1][1][2] = (vec4(-4.0, 7.0, 9.0, -5.0));
	block.var[1][1][1][3] = (vec4(2.0, -8.0, 7.0, 8.0));
	block.var[1][1][2][0] = (vec4(1.0, -8.0, -3.0, -8.0));
	block.var[1][1][2][1] = (vec4(-8.0, -6.0, -2.0, -9.0));
	block.var[1][1][2][2] = (vec4(-4.0, 4.0, -9.0, -5.0));
	block.var[1][1][2][3] = (vec4(-2.0, 9.0, -7.0, -6.0));
	block.var[2][0][0][0] = (vec4(-4.0, -3.0, 4.0, -8.0));
	block.var[2][0][0][1] = (vec4(-2.0, 0.0, -8.0, 2.0));
	block.var[2][0][0][2] = (vec4(-3.0, -5.0, 3.0, -2.0));
	block.var[2][0][0][3] = (vec4(-9.0, -8.0, -3.0, 5.0));
	block.var[2][0][1][0] = (vec4(-9.0, 6.0, -6.0, 7.0));
	block.var[2][0][1][1] = (vec4(-8.0, 2.0, 7.0, -5.0));
	block.var[2][0][1][2] = (vec4(0.0, -4.0, -7.0, 6.0));
	block.var[2][0][1][3] = (vec4(0.0, 0.0, 4.0, -5.0));
	block.var[2][0][2][0] = (vec4(-1.0, -9.0, -7.0, 5.0));
	block.var[2][0][2][1] = (vec4(3.0, 9.0, -8.0, -6.0));
	block.var[2][0][2][2] = (vec4(-3.0, 6.0, -9.0, 4.0));
	block.var[2][0][2][3] = (vec4(6.0, -6.0, -6.0, -2.0));
	block.var[2][1][0][0] = (vec4(-2.0, -9.0, -3.0, -3.0));
	block.var[2][1][0][1] = (vec4(-3.0, 0.0, -7.0, 1.0));
	block.var[2][1][0][2] = (vec4(6.0, -1.0, 3.0, 4.0));
	block.var[2][1][0][3] = (vec4(8.0, 7.0, 7.0, -9.0));
	block.var[2][1][1][0] = (vec4(-9.0, 3.0, 5.0, 7.0));
	block.var[2][1][1][1] = (vec4(3.0, -6.0, -1.0, -5.0));
	block.var[2][1][1][2] = (vec4(9.0, -7.0, 9.0, -7.0));
	block.var[2][1][1][3] = (vec4(7.0, 5.0, -8.0, 6.0));
	block.var[2][1][2][0] = (vec4(1.0, 7.0, -7.0, -7.0));
	block.var[2][1][2][1] = (vec4(-9.0, -7.0, -8.0, 7.0));
	block.var[2][1][2][2] = (vec4(5.0, -2.0, 5.0, -4.0));
	block.var[2][1][2][3] = (vec4(-8.0, 0.0, 0.0, 7.0));
	block.var[3][0][0][0] = (vec4(-8.0, -3.0, -8.0, 5.0));
	block.var[3][0][0][1] = (vec4(6.0, -9.0, -7.0, -7.0));
	block.var[3][0][0][2] = (vec4(6.0, 1.0, 0.0, -3.0));
	block.var[3][0][0][3] = (vec4(4.0, 1.0, -7.0, 4.0));
	block.var[3][0][1][0] = (vec4(6.0, 4.0, 3.0, -5.0));
	block.var[3][0][1][1] = (vec4(-8.0, 0.0, -2.0, 7.0));
	block.var[3][0][1][2] = (vec4(5.0, -1.0, -3.0, -2.0));
	block.var[3][0][1][3] = (vec4(-6.0, -9.0, -3.0, 5.0));
	block.var[3][0][2][0] = (vec4(8.0, 7.0, -4.0, 1.0));
	block.var[3][0][2][1] = (vec4(6.0, -9.0, 8.0, 3.0));
	block.var[3][0][2][2] = (vec4(-6.0, -7.0, 7.0, -1.0));
	block.var[3][0][2][3] = (vec4(-7.0, 6.0, -5.0, 9.0));
	block.var[3][1][0][0] = (vec4(-9.0, 2.0, -4.0, 0.0));
	block.var[3][1][0][1] = (vec4(-5.0, -8.0, -8.0, 2.0));
	block.var[3][1][0][2] = (vec4(9.0, -9.0, -6.0, 5.0));
	block.var[3][1][0][3] = (vec4(0.0, 9.0, 6.0, 5.0));
	block.var[3][1][1][0] = (vec4(-2.0, -9.0, 6.0, -7.0));
	block.var[3][1][1][1] = (vec4(5.0, 4.0, 2.0, -6.0));
	block.var[3][1][1][2] = (vec4(-8.0, -7.0, 4.0, 1.0));
	block.var[3][1][1][3] = (vec4(1.0, 1.0, 6.0, 2.0));
	block.var[3][1][2][0] = (vec4(-7.0, 8.0, -8.0, 4.0));
	block.var[3][1][2][1] = (vec4(2.0, 3.0, -3.0, -2.0));
	block.var[3][1][2][2] = (vec4(9.0, 1.0, -8.0, 2.0));
	block.var[3][1][2][3] = (vec4(2.0, -1.0, -9.0, 9.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, row_major, buffer_reference) buffer Block
{
	float padding;
	highp mat3x2 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.padding), 0.0) && allOk;
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(5.0, 2.0, -5.0, 9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(-9.0, 0.0, -5.0, 3.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][2], mat3x2(-2.0, 6.0, -3.0, -4.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(-1.0, -7.0, -4.0, 7.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(-2.0, -2.0, -1.0, 9.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][2], mat3x2(1.0, 9.0, -1.0, 7.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(1.0, -5.0, -2.0, 0.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(-4.0, -9.0, 2.0, 4.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][2], mat3x2(1.0, 2.0, 0.0, -6.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(-7.0, 8.0, 8.0, 9.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(0.0, -5.0, 4.0, -6.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][2], mat3x2(-7.0, -9.0, -7.0, 6.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(-8.0, 5.0, 8.0, -7.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(-5.0, -4.0, 8.0, 0.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][2], mat3x2(9.0, -7.0, 8.0, -9.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(-6.0, -4.0, 8.0, -9.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(-9.0, 2.0, -7.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][2], mat3x2(7.0, -1.0, 1.0, -7.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][0], mat3x2(7.0, 6.0, -8.0, 4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][1], mat3x2(5.0, 6.0, -9.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][2], mat3x2(7.0, 1.0, 5.0, 1.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][0], mat3x2(-8.0, 9.0, -6.0, -8.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][1], mat3x2(9.0, -2.0, -7.0, 4.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][2], mat3x2(-2.0, 2.0, -1.0, -1.0, -7.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-2.0);
	block.var[0][0][0][0] = (vec2(1.0, 8.0));
	block.var[0][0][0][1] = (vec2(-7.0, 5.0));
	block.var[0][0][0][2] = (vec2(8.0, 2.0));
	block.var[0][0][1][0] = (vec2(-3.0, 1.0));
	block.var[0][0][1][1] = (vec2(2.0, -5.0));
	block.var[0][0][1][2] = (vec2(0.0, 6.0));
	block.var[0][0][2][0] = (vec2(6.0, 5.0));
	block.var[0][0][2][1] = (vec2(-5.0, 9.0));
	block.var[0][0][2][2] = (vec2(3.0, -8.0));
	block.var[0][1][0][0] = (vec2(-2.0, -8.0));
	block.var[0][1][0][1] = (vec2(7.0, -7.0));
	block.var[0][1][0][2] = (vec2(-2.0, -1.0));
	block.var[0][1][1][0] = (vec2(-8.0, 4.0));
	block.var[0][1][1][1] = (vec2(-5.0, 3.0));
	block.var[0][1][1][2] = (vec2(6.0, -9.0));
	block.var[0][1][2][0] = (vec2(8.0, -9.0));
	block.var[0][1][2][1] = (vec2(-1.0, 1.0));
	block.var[0][1][2][2] = (vec2(-8.0, 0.0));
	block.var[1][0][0][0] = (vec2(3.0, -3.0));
	block.var[1][0][0][1] = (vec2(3.0, -5.0));
	block.var[1][0][0][2] = (vec2(9.0, 7.0));
	block.var[1][0][1][0] = (vec2(3.0, 1.0));
	block.var[1][0][1][1] = (vec2(-2.0, 1.0));
	block.var[1][0][1][2] = (vec2(-8.0, 4.0));
	block.var[1][0][2][0] = (vec2(3.0, 6.0));
	block.var[1][0][2][1] = (vec2(7.0, 1.0));
	block.var[1][0][2][2] = (vec2(-9.0, 9.0));
	block.var[1][1][0][0] = (vec2(-1.0, -9.0));
	block.var[1][1][0][1] = (vec2(3.0, 4.0));
	block.var[1][1][0][2] = (vec2(2.0, 6.0));
	block.var[1][1][1][0] = (vec2(-4.0, -4.0));
	block.var[1][1][1][1] = (vec2(0.0, -6.0));
	block.var[1][1][1][2] = (vec2(-1.0, 5.0));
	block.var[1][1][2][0] = (vec2(6.0, -8.0));
	block.var[1][1][2][1] = (vec2(-5.0, -8.0));
	block.var[1][1][2][2] = (vec2(-8.0, 4.0));
	block.var[2][0][0][0] = (vec2(0.0, -6.0));
	block.var[2][0][0][1] = (vec2(-7.0, 7.0));
	block.var[2][0][0][2] = (vec2(-9.0, -8.0));
	block.var[2][0][1][0] = (vec2(9.0, 6.0));
	block.var[2][0][1][1] = (vec2(-1.0, 0.0));
	block.var[2][0][1][2] = (vec2(7.0, -3.0));
	block.var[2][0][2][0] = (vec2(-1.0, -6.0));
	block.var[2][0][2][1] = (vec2(-1.0, -3.0));
	block.var[2][0][2][2] = (vec2(6.0, 0.0));
	block.var[2][1][0][0] = (vec2(-4.0, 4.0));
	block.var[2][1][0][1] = (vec2(5.0, 3.0));
	block.var[2][1][0][2] = (vec2(-9.0, -3.0));
	block.var[2][1][1][0] = (vec2(5.0, 1.0));
	block.var[2][1][1][1] = (vec2(3.0, -3.0));
	block.var[2][1][1][2] = (vec2(-5.0, -1.0));
	block.var[2][1][2][0] = (vec2(-6.0, 8.0));
	block.var[2][1][2][1] = (vec2(-3.0, 7.0));
	block.var[2][1][2][2] = (vec2(-6.0, -6.0));
	block.var[3][0][0][0] = (vec2(4.0, -9.0));
	block.var[3][0][0][1] = (vec2(1.0, 1.0));
	block.var[3][0][0][2] = (vec2(-1.0, -9.0));
	block.var[3][0][1][0] = (vec2(0.0, 4.0));
	block.var[3][0][1][1] = (vec2(-3.0, -3.0));
	block.var[3][0][1][2] = (vec2(7.0, 6.0));
	block.var[3][0][2][0] = (vec2(-7.0, 5.0));
	block.var[3][0][2][1] = (vec2(-6.0, -5.0));
	block.var[3][0][2][2] = (vec2(8.0, 2.0));
	block.var[3][1][0][0] = (vec2(6.0, 7.0));
	block.var[3][1][0][1] = (vec2(3.0, -9.0));
	block.var[3][1][0][2] = (vec2(6.0, -4.0));
	block.var[3][1][1][0] = (vec2(-6.0, 2.0));
	block.var[3][1][1][1] = (vec2(6.0, -3.0));
	block.var[3][1][1][2] = (vec2(-6.0, -1.0));
	block.var[3][1][2][0] = (vec2(8.0, -4.0));
	block.var[3][1][2][1] = (vec2(-9.0, -4.0));
	block.var[3][1][2][2] = (vec2(-9.0, 3.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, column_major, buffer_reference) buffer Block
{
	float padding;
	highp mat4x2 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.padding), 4.0) && allOk;
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(-5.0, -2.0, 7.0, 3.0, 2.0, -3.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(-1.0, -9.0, 4.0, -9.0, -4.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][2], mat4x2(-7.0, 4.0, 6.0, 6.0, -6.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(3.0, 3.0, -2.0, -1.0, -4.0, -1.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(-3.0, 4.0, 8.0, 5.0, 2.0, -4.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][2], mat4x2(1.0, 5.0, -9.0, -5.0, 2.0, -5.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(1.0, 8.0, 3.0, 5.0, -2.0, 2.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(8.0, -6.0, 7.0, 4.0, -6.0, 1.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][2], mat4x2(-6.0, 1.0, 5.0, 0.0, -2.0, -5.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(8.0, -9.0, -1.0, 8.0, 1.0, -5.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(4.0, 5.0, -5.0, 0.0, 3.0, -8.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][2], mat4x2(7.0, -7.0, -3.0, -7.0, -5.0, -9.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(-9.0, 6.0, -5.0, 3.0, -2.0, -3.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(0.0, 8.0, 5.0, -1.0, 3.0, -2.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][2], mat4x2(-7.0, 7.0, 1.0, 2.0, -1.0, -5.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(5.0, -7.0, -1.0, 5.0, 3.0, -2.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(-3.0, 5.0, -1.0, 9.0, -5.0, -1.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][2], mat4x2(-3.0, 6.0, -4.0, 1.0, -7.0, -4.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][0], mat4x2(4.0, 5.0, -1.0, -2.0, 5.0, -3.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][1], mat4x2(2.0, 1.0, -4.0, 1.0, -1.0, 2.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][2], mat4x2(2.0, -1.0, 8.0, 2.0, 1.0, -4.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][0], mat4x2(6.0, -3.0, -8.0, 8.0, 9.0, -8.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][1], mat4x2(8.0, 1.0, -5.0, 6.0, 5.0, -7.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][2], mat4x2(-9.0, 5.0, 1.0, -8.0, 1.0, -6.0, 3.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2.0);
	block.var[0][0][0][0] = (vec2(-4.0, -5.0));
	block.var[0][0][0][1] = (vec2(3.0, 7.0));
	block.var[0][0][0][2] = (vec2(1.0, 8.0));
	block.var[0][0][0][3] = (vec2(-5.0, 7.0));
	block.var[0][0][1][0] = (vec2(-3.0, 1.0));
	block.var[0][0][1][1] = (vec2(-6.0, 9.0));
	block.var[0][0][1][2] = (vec2(-3.0, 1.0));
	block.var[0][0][1][3] = (vec2(-5.0, -8.0));
	block.var[0][0][2][0] = (vec2(4.0, 5.0));
	block.var[0][0][2][1] = (vec2(-9.0, 1.0));
	block.var[0][0][2][2] = (vec2(-5.0, -4.0));
	block.var[0][0][2][3] = (vec2(-2.0, 6.0));
	block.var[0][1][0][0] = (vec2(2.0, -4.0));
	block.var[0][1][0][1] = (vec2(1.0, 5.0));
	block.var[0][1][0][2] = (vec2(-7.0, 5.0));
	block.var[0][1][0][3] = (vec2(5.0, -5.0));
	block.var[0][1][1][0] = (vec2(1.0, -7.0));
	block.var[0][1][1][1] = (vec2(-3.0, -1.0));
	block.var[0][1][1][2] = (vec2(1.0, 4.0));
	block.var[0][1][1][3] = (vec2(7.0, -9.0));
	block.var[0][1][2][0] = (vec2(1.0, -6.0));
	block.var[0][1][2][1] = (vec2(7.0, 8.0));
	block.var[0][1][2][2] = (vec2(-7.0, 2.0));
	block.var[0][1][2][3] = (vec2(1.0, -7.0));
	block.var[1][0][0][0] = (vec2(-1.0, -7.0));
	block.var[1][0][0][1] = (vec2(-5.0, -2.0));
	block.var[1][0][0][2] = (vec2(-8.0, 1.0));
	block.var[1][0][0][3] = (vec2(3.0, 4.0));
	block.var[1][0][1][0] = (vec2(2.0, -9.0));
	block.var[1][0][1][1] = (vec2(2.0, -3.0));
	block.var[1][0][1][2] = (vec2(3.0, 0.0));
	block.var[1][0][1][3] = (vec2(1.0, -5.0));
	block.var[1][0][2][0] = (vec2(-9.0, 2.0));
	block.var[1][0][2][1] = (vec2(-2.0, -3.0));
	block.var[1][0][2][2] = (vec2(0.0, 9.0));
	block.var[1][0][2][3] = (vec2(6.0, 3.0));
	block.var[1][1][0][0] = (vec2(4.0, -4.0));
	block.var[1][1][0][1] = (vec2(4.0, 0.0));
	block.var[1][1][0][2] = (vec2(7.0, 7.0));
	block.var[1][1][0][3] = (vec2(-1.0, 0.0));
	block.var[1][1][1][0] = (vec2(-2.0, -8.0));
	block.var[1][1][1][1] = (vec2(2.0, 8.0));
	block.var[1][1][1][2] = (vec2(-1.0, 5.0));
	block.var[1][1][1][3] = (vec2(2.0, 4.0));
	block.var[1][1][2][0] = (vec2(1.0, -6.0));
	block.var[1][1][2][1] = (vec2(7.0, -7.0));
	block.var[1][1][2][2] = (vec2(1.0, 2.0));
	block.var[1][1][2][3] = (vec2(-4.0, -8.0));
	block.var[2][0][0][0] = (vec2(-4.0, 2.0));
	block.var[2][0][0][1] = (vec2(-3.0, 6.0));
	block.var[2][0][0][2] = (vec2(5.0, 0.0));
	block.var[2][0][0][3] = (vec2(-2.0, -3.0));
	block.var[2][0][1][0] = (vec2(-2.0, -7.0));
	block.var[2][0][1][1] = (vec2(3.0, -6.0));
	block.var[2][0][1][2] = (vec2(2.0, 9.0));
	block.var[2][0][1][3] = (vec2(6.0, -4.0));
	block.var[2][0][2][0] = (vec2(4.0, 0.0));
	block.var[2][0][2][1] = (vec2(-3.0, -7.0));
	block.var[2][0][2][2] = (vec2(0.0, -9.0));
	block.var[2][0][2][3] = (vec2(1.0, 7.0));
	block.var[2][1][0][0] = (vec2(-5.0, 8.0));
	block.var[2][1][0][1] = (vec2(-8.0, 7.0));
	block.var[2][1][0][2] = (vec2(-2.0, -7.0));
	block.var[2][1][0][3] = (vec2(-7.0, 6.0));
	block.var[2][1][1][0] = (vec2(-1.0, 0.0));
	block.var[2][1][1][1] = (vec2(-4.0, -5.0));
	block.var[2][1][1][2] = (vec2(-3.0, -7.0));
	block.var[2][1][1][3] = (vec2(-5.0, -7.0));
	block.var[2][1][2][0] = (vec2(-7.0, -6.0));
	block.var[2][1][2][1] = (vec2(-7.0, 3.0));
	block.var[2][1][2][2] = (vec2(1.0, 9.0));
	block.var[2][1][2][3] = (vec2(-1.0, -5.0));
	block.var[3][0][0][0] = (vec2(2.0, 1.0));
	block.var[3][0][0][1] = (vec2(9.0, -3.0));
	block.var[3][0][0][2] = (vec2(3.0, -7.0));
	block.var[3][0][0][3] = (vec2(9.0, -4.0));
	block.var[3][0][1][0] = (vec2(-1.0, 3.0));
	block.var[3][0][1][1] = (vec2(6.0, 8.0));
	block.var[3][0][1][2] = (vec2(3.0, 1.0));
	block.var[3][0][1][3] = (vec2(5.0, 7.0));
	block.var[3][0][2][0] = (vec2(0.0, 0.0));
	block.var[3][0][2][1] = (vec2(-2.0, 3.0));
	block.var[3][0][2][2] = (vec2(-7.0, -3.0));
	block.var[3][0][2][3] = (vec2(1.0, 4.0));
	block.var[3][1][0][0] = (vec2(4.0, 6.0));
	block.var[3][1][0][1] = (vec2(6.0, -4.0));
	block.var[3][1][0][2] = (vec2(-7.0, 1.0));
	block.var[3][1][0][3] = (vec2(-7.0, -5.0));
	block.var[3][1][1][0] = (vec2(3.0, -7.0));
	block.var[3][1][1][1] = (vec2(-3.0, -6.0));
	block.var[3][1][1][2] = (vec2(7.0, -4.0));
	block.var[3][1][1][3] = (vec2(1.0, -7.0));
	block.var[3][1][2][0] = (vec2(-7.0, 0.0));
	block.var[3][1][2][1] = (vec2(4.0, 4.0));
	block.var[3][1][2][2] = (vec2(-9.0, -5.0));
	block.var[3][1][2][3] = (vec2(-8.0, -8.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, row_major, buffer_reference) buffer Block
{
	highp mat2x3 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(block.var[0][0][0], mat2x3(2.0, 5.0, 1.0, 7.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][1], mat2x3(3.0, 6.0, -3.0, 8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][0], mat2x3(-9.0, 5.0, -2.0, -8.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][1], mat2x3(-4.0, 0.0, 4.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2][0], mat2x3(3.0, 9.0, -7.0, 8.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2][1], mat2x3(6.0, 5.0, -8.0, -1.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][3][0], mat2x3(9.0, -9.0, -8.0, -9.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][3][1], mat2x3(-5.0, -6.0, -2.0, -1.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][0], mat2x3(-5.0, -2.0, 6.0, -5.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][1], mat2x3(3.0, 6.0, 4.0, 8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][0], mat2x3(1.0, -6.0, -1.0, -2.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][1], mat2x3(3.0, -1.0, 1.0, 5.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2][0], mat2x3(-2.0, -2.0, 2.0, 9.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2][1], mat2x3(-5.0, -3.0, -1.0, 9.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][3][0], mat2x3(-4.0, -4.0, 3.0, 5.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][3][1], mat2x3(-6.0, -8.0, 0.0, -1.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][0], mat2x3(-7.0, 3.0, -5.0, 2.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][1], mat2x3(2.0, 6.0, -6.0, -7.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][0], mat2x3(-9.0, 3.0, -4.0, 4.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][1], mat2x3(6.0, -9.0, -8.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2][0], mat2x3(9.0, 2.0, -2.0, 6.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2][1], mat2x3(9.0, -1.0, -8.0, 7.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][3][0], mat2x3(-4.0, 8.0, 6.0, -2.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][3][1], mat2x3(-8.0, 8.0, 5.0, -5.0, 4.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec3(1.0, -1.0, 1.0));
	block.var[0][0][0][1] = (vec3(-3.0, 9.0, -8.0));
	block.var[0][0][1][0] = (vec3(-5.0, 6.0, 6.0));
	block.var[0][0][1][1] = (vec3(3.0, -3.0, 7.0));
	block.var[0][1][0][0] = (vec3(6.0, -2.0, 0.0));
	block.var[0][1][0][1] = (vec3(3.0, 4.0, -6.0));
	block.var[0][1][1][0] = (vec3(3.0, -6.0, 2.0));
	block.var[0][1][1][1] = (vec3(4.0, -8.0, 0.0));
	block.var[0][2][0][0] = (vec3(0.0, 9.0, -7.0));
	block.var[0][2][0][1] = (vec3(5.0, 6.0, -3.0));
	block.var[0][2][1][0] = (vec3(-6.0, 0.0, -3.0));
	block.var[0][2][1][1] = (vec3(7.0, 9.0, -2.0));
	block.var[0][3][0][0] = (vec3(5.0, -2.0, -1.0));
	block.var[0][3][0][1] = (vec3(7.0, -7.0, 5.0));
	block.var[0][3][1][0] = (vec3(-3.0, 6.0, 7.0));
	block.var[0][3][1][1] = (vec3(6.0, -5.0, -2.0));
	block.var[1][0][0][0] = (vec3(-9.0, -2.0, -7.0));
	block.var[1][0][0][1] = (vec3(7.0, 0.0, -8.0));
	block.var[1][0][1][0] = (vec3(0.0, -5.0, 5.0));
	block.var[1][0][1][1] = (vec3(-2.0, 4.0, -8.0));
	block.var[1][1][0][0] = (vec3(-3.0, 3.0, 5.0));
	block.var[1][1][0][1] = (vec3(-6.0, -8.0, 8.0));
	block.var[1][1][1][0] = (vec3(4.0, -9.0, -1.0));
	block.var[1][1][1][1] = (vec3(-6.0, 7.0, -3.0));
	block.var[1][2][0][0] = (vec3(-7.0, 6.0, -7.0));
	block.var[1][2][0][1] = (vec3(8.0, -6.0, 8.0));
	block.var[1][2][1][0] = (vec3(4.0, -8.0, 4.0));
	block.var[1][2][1][1] = (vec3(4.0, 5.0, 5.0));
	block.var[1][3][0][0] = (vec3(2.0, -1.0, 2.0));
	block.var[1][3][0][1] = (vec3(-3.0, 6.0, -3.0));
	block.var[1][3][1][0] = (vec3(-2.0, 0.0, -6.0));
	block.var[1][3][1][1] = (vec3(2.0, -7.0, -2.0));
	block.var[2][0][0][0] = (vec3(-3.0, -4.0, 7.0));
	block.var[2][0][0][1] = (vec3(-3.0, -1.0, -9.0));
	block.var[2][0][1][0] = (vec3(2.0, -3.0, 6.0));
	block.var[2][0][1][1] = (vec3(-4.0, 8.0, 2.0));
	block.var[2][1][0][0] = (vec3(2.0, -2.0, 4.0));
	block.var[2][1][0][1] = (vec3(-3.0, -5.0, 9.0));
	block.var[2][1][1][0] = (vec3(-8.0, -1.0, 7.0));
	block.var[2][1][1][1] = (vec3(2.0, 0.0, 5.0));
	block.var[2][2][0][0] = (vec3(2.0, 3.0, 6.0));
	block.var[2][2][0][1] = (vec3(-4.0, -4.0, -1.0));
	block.var[2][2][1][0] = (vec3(-3.0, -1.0, -1.0));
	block.var[2][2][1][1] = (vec3(6.0, 2.0, 2.0));
	block.var[2][3][0][0] = (vec3(1.0, -8.0, -3.0));
	block.var[2][3][0][1] = (vec3(7.0, 3.0, 1.0));
	block.var[2][3][1][0] = (vec3(2.0, -8.0, 6.0));
	block.var[2][3][1][1] = (vec3(-8.0, -7.0, 0.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, row_major, buffer_reference) buffer Block
{
	highp mat3x4 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(block.var[0][0][0], mat3x4(-3.0, -9.0, 3.0, -6.0, -7.0, 8.0, -8.0, -5.0, 9.0, -8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][1], mat3x4(8.0, -4.0, 9.0, 7.0, -8.0, 9.0, -1.0, 0.0, 9.0, 7.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(6.0, 0.0, -7.0, 9.0, -8.0, 6.0, 0.0, 9.0, -1.0, -9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(1.0, 9.0, -9.0, -8.0, 0.0, 2.0, 9.0, 6.0, 3.0, 9.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][0], mat3x4(6.0, 7.0, 9.0, 7.0, 0.0, 8.0, -1.0, 0.0, 6.0, -3.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][1], mat3x4(7.0, -7.0, 1.0, 0.0, -9.0, 2.0, -3.0, 7.0, 8.0, -6.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][0], mat3x4(-2.0, -2.0, 7.0, -9.0, 3.0, 6.0, -5.0, -8.0, -3.0, -3.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][1], mat3x4(-9.0, 0.0, -2.0, -3.0, 4.0, -7.0, 8.0, -2.0, -7.0, -1.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(-3.0, -6.0, -7.0, 8.0, 1.0, 5.0, 1.0, -1.0, 8.0, -9.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(-4.0, -4.0, 2.0, -2.0, 1.0, 3.0, -5.0, -4.0, 9.0, 6.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(-7.0, -2.0, -1.0, -9.0, -9.0, 6.0, -6.0, -9.0, -4.0, -4.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(9.0, 1.0, -6.0, 9.0, -3.0, -9.0, -2.0, -9.0, -7.0, -4.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][0], mat3x4(0.0, 8.0, -8.0, -9.0, 5.0, -4.0, -5.0, 3.0, 4.0, 3.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][1], mat3x4(9.0, -4.0, -6.0, 0.0, 0.0, -9.0, 6.0, 4.0, -6.0, -3.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][0], mat3x4(6.0, 7.0, 1.0, 5.0, 4.0, 9.0, 5.0, 4.0, 9.0, -4.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][1], mat3x4(1.0, 0.0, -7.0, -4.0, -3.0, 3.0, -7.0, 4.0, 1.0, 0.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(9.0, 3.0, 9.0, -8.0, 9.0, -4.0, -4.0, 7.0, -1.0, -7.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(-5.0, -4.0, -9.0, 1.0, 6.0, 6.0, 2.0, 1.0, 0.0, 1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(-3.0, 5.0, 0.0, -7.0, 9.0, -8.0, -9.0, -4.0, -6.0, 7.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(4.0, 4.0, 1.0, -1.0, 9.0, -6.0, -6.0, -4.0, 4.0, 8.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][0], mat3x4(5.0, 2.0, -1.0, 1.0, 1.0, 7.0, 0.0, 8.0, 9.0, 0.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][1], mat3x4(-5.0, 1.0, 4.0, 5.0, 5.0, 0.0, 7.0, -5.0, 6.0, -2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][0], mat3x4(-1.0, 9.0, 4.0, -7.0, -2.0, 8.0, 8.0, 5.0, 3.0, -7.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][1], mat3x4(-8.0, -3.0, 1.0, -8.0, -6.0, 9.0, 2.0, 4.0, 4.0, 1.0, -1.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(-6.0, -4.0, 2.0, -3.0));
	block.var[0][0][0][1] = (vec4(-2.0, 4.0, -5.0, 8.0));
	block.var[0][0][0][2] = (vec4(-4.0, 6.0, -9.0, -9.0));
	block.var[0][0][1][0] = (vec4(0.0, 6.0, 0.0, 6.0));
	block.var[0][0][1][1] = (vec4(5.0, 2.0, 6.0, 6.0));
	block.var[0][0][1][2] = (vec4(-7.0, -6.0, -8.0, 0.0));
	block.var[0][1][0][0] = (vec4(0.0, -7.0, 3.0, -8.0));
	block.var[0][1][0][1] = (vec4(3.0, -2.0, -3.0, 1.0));
	block.var[0][1][0][2] = (vec4(-5.0, -9.0, -7.0, -7.0));
	block.var[0][1][1][0] = (vec4(-2.0, -9.0, -7.0, -8.0));
	block.var[0][1][1][1] = (vec4(7.0, -6.0, -4.0, 6.0));
	block.var[0][1][1][2] = (vec4(-5.0, -4.0, -8.0, -4.0));
	block.var[0][2][0][0] = (vec4(6.0, 2.0, 8.0, -5.0));
	block.var[0][2][0][1] = (vec4(9.0, 5.0, 9.0, -1.0));
	block.var[0][2][0][2] = (vec4(-2.0, -5.0, -6.0, -8.0));
	block.var[0][2][1][0] = (vec4(0.0, -4.0, 7.0, 1.0));
	block.var[0][2][1][1] = (vec4(4.0, 1.0, 9.0, 9.0));
	block.var[0][2][1][2] = (vec4(-9.0, -5.0, 3.0, 8.0));
	block.var[0][3][0][0] = (vec4(1.0, -1.0, -4.0, 2.0));
	block.var[0][3][0][1] = (vec4(5.0, 8.0, 5.0, -9.0));
	block.var[0][3][0][2] = (vec4(7.0, -9.0, 0.0, -3.0));
	block.var[0][3][1][0] = (vec4(-6.0, 6.0, -6.0, -5.0));
	block.var[0][3][1][1] = (vec4(5.0, 3.0, 4.0, 8.0));
	block.var[0][3][1][2] = (vec4(7.0, 0.0, -5.0, -6.0));
	block.var[1][0][0][0] = (vec4(3.0, -3.0, 6.0, -2.0));
	block.var[1][0][0][1] = (vec4(-8.0, -5.0, -5.0, 1.0));
	block.var[1][0][0][2] = (vec4(7.0, -8.0, -3.0, -2.0));
	block.var[1][0][1][0] = (vec4(6.0, 4.0, -5.0, 8.0));
	block.var[1][0][1][1] = (vec4(-5.0, -8.0, -9.0, -8.0));
	block.var[1][0][1][2] = (vec4(9.0, 0.0, 3.0, -4.0));
	block.var[1][1][0][0] = (vec4(9.0, -2.0, 7.0, -9.0));
	block.var[1][1][0][1] = (vec4(-6.0, -4.0, 5.0, -5.0));
	block.var[1][1][0][2] = (vec4(-5.0, 7.0, 6.0, 6.0));
	block.var[1][1][1][0] = (vec4(0.0, 9.0, -3.0, -9.0));
	block.var[1][1][1][1] = (vec4(-7.0, 6.0, -7.0, -1.0));
	block.var[1][1][1][2] = (vec4(-6.0, -6.0, 2.0, 8.0));
	block.var[1][2][0][0] = (vec4(4.0, -1.0, -2.0, 2.0));
	block.var[1][2][0][1] = (vec4(-5.0, 4.0, -2.0, -4.0));
	block.var[1][2][0][2] = (vec4(8.0, -7.0, -1.0, -9.0));
	block.var[1][2][1][0] = (vec4(8.0, 5.0, 3.0, 6.0));
	block.var[1][2][1][1] = (vec4(0.0, 6.0, 0.0, 2.0));
	block.var[1][2][1][2] = (vec4(-1.0, -5.0, -6.0, -4.0));
	block.var[1][3][0][0] = (vec4(5.0, 0.0, 8.0, 4.0));
	block.var[1][3][0][1] = (vec4(3.0, -1.0, -7.0, 0.0));
	block.var[1][3][0][2] = (vec4(-1.0, 6.0, -6.0, 1.0));
	block.var[1][3][1][0] = (vec4(0.0, 8.0, 0.0, 9.0));
	block.var[1][3][1][1] = (vec4(-6.0, 8.0, -5.0, -1.0));
	block.var[1][3][1][2] = (vec4(0.0, 6.0, -9.0, 9.0));
	block.var[2][0][0][0] = (vec4(0.0, -6.0, 5.0, 1.0));
	block.var[2][0][0][1] = (vec4(9.0, -8.0, -1.0, -7.0));
	block.var[2][0][0][2] = (vec4(1.0, 2.0, 0.0, -9.0));
	block.var[2][0][1][0] = (vec4(2.0, 0.0, 5.0, -4.0));
	block.var[2][0][1][1] = (vec4(-7.0, 0.0, 3.0, 4.0));
	block.var[2][0][1][2] = (vec4(4.0, 5.0, 2.0, -3.0));
	block.var[2][1][0][0] = (vec4(-6.0, 6.0, -8.0, -3.0));
	block.var[2][1][0][1] = (vec4(2.0, 0.0, 0.0, -2.0));
	block.var[2][1][0][2] = (vec4(-9.0, -3.0, 2.0, 2.0));
	block.var[2][1][1][0] = (vec4(-7.0, -4.0, 9.0, 7.0));
	block.var[2][1][1][1] = (vec4(-3.0, 1.0, -7.0, 9.0));
	block.var[2][1][1][2] = (vec4(-9.0, -8.0, 0.0, 8.0));
	block.var[2][2][0][0] = (vec4(-3.0, -5.0, -4.0, -4.0));
	block.var[2][2][0][1] = (vec4(-8.0, -8.0, 1.0, 7.0));
	block.var[2][2][0][2] = (vec4(-6.0, -3.0, -7.0, 1.0));
	block.var[2][2][1][0] = (vec4(-5.0, 5.0, 0.0, 1.0));
	block.var[2][2][1][1] = (vec4(6.0, 2.0, 5.0, 5.0));
	block.var[2][2][1][2] = (vec4(5.0, -1.0, -7.0, -1.0));
	block.var[2][3][0][0] = (vec4(8.0, -2.0, -5.0, 0.0));
	block.var[2][3][0][1] = (vec4(1.0, 4.0, -3.0, -6.0));
	block.var[2][3][0][2] = (vec4(2.0, -2.0, -2.0, 3.0));
	block.var[2][3][1][0] = (vec4(-5.0, -4.0, -6.0, 2.0));
	block.var[2][3][1][1] = (vec4(-6.0, 0.0, 1.0, 9.0));
	block.var[2][3][1][2] = (vec4(2.0, 5.0, -8.0, 5.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, column_major, buffer_reference) buffer Block
{
	highp mat4x2 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(4.0, -5.0, -2.0, 7.0, 3.0, 2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(-7.0, -1.0, -9.0, 4.0, -9.0, -4.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(3.0, -9.0, 6.0, -5.0, 3.0, -2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(-2.0, 0.0, 8.0, 5.0, -1.0, 3.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][0], mat4x2(-6.0, 3.0, 3.0, -2.0, -1.0, -4.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][1], mat4x2(-9.0, -3.0, 4.0, 8.0, 5.0, 2.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][0], mat4x2(1.0, 5.0, -7.0, -1.0, 5.0, 3.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][1], mat4x2(1.0, -3.0, 5.0, -1.0, 9.0, -5.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(-7.0, -7.0, 4.0, 6.0, 6.0, -6.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(-1.0, 1.0, 8.0, 3.0, 5.0, -2.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(-2.0, -7.0, 7.0, 1.0, 2.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(1.0, 4.0, 5.0, -1.0, -2.0, 5.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][0], mat4x2(-1.0, 1.0, 5.0, -9.0, -5.0, 2.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][1], mat4x2(8.0, 8.0, -9.0, -1.0, 8.0, 1.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][0], mat4x2(-9.0, -3.0, 6.0, -4.0, 1.0, -7.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][1], mat4x2(6.0, 6.0, -3.0, -8.0, 8.0, 9.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(3.0, 8.0, -6.0, 7.0, 4.0, -6.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(-5.0, -6.0, 1.0, 5.0, 0.0, -2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(-4.0, 2.0, 1.0, -4.0, 1.0, -1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(-9.0, 2.0, -1.0, 8.0, 2.0, 1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][0], mat4x2(1.0, 4.0, 5.0, -5.0, 0.0, 3.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][1], mat4x2(0.0, 7.0, -7.0, -3.0, -7.0, -5.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][0], mat4x2(2.0, 8.0, 1.0, -5.0, 6.0, 5.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][1], mat4x2(-6.0, -9.0, 5.0, 1.0, -8.0, 1.0, -6.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(2.0, -4.0));
	block.var[0][0][0][1] = (vec2(-5.0, 3.0));
	block.var[0][0][0][2] = (vec2(7.0, 1.0));
	block.var[0][0][0][3] = (vec2(8.0, -5.0));
	block.var[0][0][1][0] = (vec2(7.0, -3.0));
	block.var[0][0][1][1] = (vec2(1.0, -6.0));
	block.var[0][0][1][2] = (vec2(9.0, -3.0));
	block.var[0][0][1][3] = (vec2(1.0, -5.0));
	block.var[0][1][0][0] = (vec2(3.0, -4.0));
	block.var[0][1][0][1] = (vec2(2.0, -3.0));
	block.var[0][1][0][2] = (vec2(6.0, 5.0));
	block.var[0][1][0][3] = (vec2(0.0, -2.0));
	block.var[0][1][1][0] = (vec2(-3.0, -2.0));
	block.var[0][1][1][1] = (vec2(-7.0, 3.0));
	block.var[0][1][1][2] = (vec2(-6.0, 2.0));
	block.var[0][1][1][3] = (vec2(9.0, 6.0));
	block.var[0][2][0][0] = (vec2(4.0, 2.0));
	block.var[0][2][0][1] = (vec2(-4.0, 1.0));
	block.var[0][2][0][2] = (vec2(5.0, -7.0));
	block.var[0][2][0][3] = (vec2(5.0, 5.0));
	block.var[0][2][1][0] = (vec2(-5.0, 1.0));
	block.var[0][2][1][1] = (vec2(-7.0, -3.0));
	block.var[0][2][1][2] = (vec2(-1.0, 1.0));
	block.var[0][2][1][3] = (vec2(4.0, 7.0));
	block.var[0][3][0][0] = (vec2(-8.0, -5.0));
	block.var[0][3][0][1] = (vec2(8.0, -8.0));
	block.var[0][3][0][2] = (vec2(7.0, -2.0));
	block.var[0][3][0][3] = (vec2(-7.0, -7.0));
	block.var[0][3][1][0] = (vec2(6.0, -1.0));
	block.var[0][3][1][1] = (vec2(0.0, -4.0));
	block.var[0][3][1][2] = (vec2(-5.0, -3.0));
	block.var[0][3][1][3] = (vec2(-7.0, -5.0));
	block.var[1][0][0][0] = (vec2(-8.0, 4.0));
	block.var[1][0][0][1] = (vec2(5.0, -9.0));
	block.var[1][0][0][2] = (vec2(1.0, -5.0));
	block.var[1][0][0][3] = (vec2(-4.0, -2.0));
	block.var[1][0][1][0] = (vec2(6.0, -1.0));
	block.var[1][0][1][1] = (vec2(-7.0, -5.0));
	block.var[1][0][1][2] = (vec2(-2.0, -8.0));
	block.var[1][0][1][3] = (vec2(1.0, 3.0));
	block.var[1][1][0][0] = (vec2(-4.0, 4.0));
	block.var[1][1][0][1] = (vec2(0.0, -3.0));
	block.var[1][1][0][2] = (vec2(-7.0, 0.0));
	block.var[1][1][0][3] = (vec2(-9.0, 1.0));
	block.var[1][1][1][0] = (vec2(7.0, 2.0));
	block.var[1][1][1][1] = (vec2(1.0, 9.0));
	block.var[1][1][1][2] = (vec2(-3.0, 3.0));
	block.var[1][1][1][3] = (vec2(-7.0, 9.0));
	block.var[1][2][0][0] = (vec2(-9.0, 1.0));
	block.var[1][2][0][1] = (vec2(-6.0, 7.0));
	block.var[1][2][0][2] = (vec2(8.0, -7.0));
	block.var[1][2][0][3] = (vec2(2.0, 1.0));
	block.var[1][2][1][0] = (vec2(-7.0, 4.0));
	block.var[1][2][1][1] = (vec2(-4.0, 4.0));
	block.var[1][2][1][2] = (vec2(0.0, 7.0));
	block.var[1][2][1][3] = (vec2(7.0, -1.0));
	block.var[1][3][0][0] = (vec2(-7.0, -7.0));
	block.var[1][3][0][1] = (vec2(-6.0, -7.0));
	block.var[1][3][0][2] = (vec2(3.0, 1.0));
	block.var[1][3][0][3] = (vec2(9.0, -1.0));
	block.var[1][3][1][0] = (vec2(-5.0, 4.0));
	block.var[1][3][1][1] = (vec2(6.0, 6.0));
	block.var[1][3][1][2] = (vec2(-4.0, -7.0));
	block.var[1][3][1][3] = (vec2(1.0, -7.0));
	block.var[2][0][0][0] = (vec2(4.0, 2.0));
	block.var[2][0][0][1] = (vec2(-9.0, 2.0));
	block.var[2][0][0][2] = (vec2(-3.0, 3.0));
	block.var[2][0][0][3] = (vec2(0.0, 1.0));
	block.var[2][0][1][0] = (vec2(-5.0, -9.0));
	block.var[2][0][1][1] = (vec2(2.0, -2.0));
	block.var[2][0][1][2] = (vec2(-3.0, 0.0));
	block.var[2][0][1][3] = (vec2(9.0, 6.0));
	block.var[2][1][0][0] = (vec2(-4.0, -1.0));
	block.var[2][1][0][1] = (vec2(3.0, 6.0));
	block.var[2][1][0][2] = (vec2(8.0, 3.0));
	block.var[2][1][0][3] = (vec2(1.0, 5.0));
	block.var[2][1][1][0] = (vec2(7.0, 0.0));
	block.var[2][1][1][1] = (vec2(0.0, -2.0));
	block.var[2][1][1][2] = (vec2(3.0, -7.0));
	block.var[2][1][1][3] = (vec2(-3.0, 1.0));
	block.var[2][2][0][0] = (vec2(0.0, -2.0));
	block.var[2][2][0][1] = (vec2(-8.0, 2.0));
	block.var[2][2][0][2] = (vec2(8.0, -1.0));
	block.var[2][2][0][3] = (vec2(5.0, 2.0));
	block.var[2][2][1][0] = (vec2(4.0, 1.0));
	block.var[2][2][1][1] = (vec2(-6.0, 7.0));
	block.var[2][2][1][2] = (vec2(-7.0, 1.0));
	block.var[2][2][1][3] = (vec2(2.0, -4.0));
	block.var[2][3][0][0] = (vec2(-5.0, 3.0));
	block.var[2][3][0][1] = (vec2(-7.0, -3.0));
	block.var[2][3][0][2] = (vec2(-6.0, 7.0));
	block.var[2][3][0][3] = (vec2(-4.0, 1.0));
	block.var[2][3][1][0] = (vec2(-7.0, -7.0));
	block.var[2][3][1][1] = (vec2(0.0, 4.0));
	block.var[2][3][1][2] = (vec2(4.0, -9.0));
	block.var[2][3][1][3] = (vec2(-5.0, -8.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, row_major, buffer_reference) buffer Block
{
	highp mat2 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(block.var[0][0][0], mat2(-2.0, -7.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(3.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(5.0, -4.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(1.0, 9.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[0][2][0], mat2(-9.0, 4.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[0][2][1], mat2(-8.0, 5.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[0][3][0], mat2(2.0, -4.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[0][3][1], mat2(9.0, 3.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(2.0, 8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(8.0, -4.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(5.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(-6.0, -8.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[1][2][0], mat2(-9.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[1][2][1], mat2(-5.0, -4.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[1][3][0], mat2(-8.0, -9.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[1][3][1], mat2(1.0, -2.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(-4.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(-6.0, 5.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(6.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(2.0, 1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[2][2][0], mat2(1.0, 0.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[2][2][1], mat2(-9.0, 9.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[2][3][0], mat2(4.0, -3.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[2][3][1], mat2(4.0, -6.0, 7.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2(3.0, 1.0, -4.0, -2.0));
	block.var[0][0][1] = (mat2(1.0, -4.0, -1.0, -3.0));
	block.var[0][1][0] = (mat2(2.0, -5.0, 9.0, 6.0));
	block.var[0][1][1] = (mat2(5.0, 8.0, -5.0, -7.0));
	block.var[0][2][0] = (mat2(8.0, -7.0, 0.0, -7.0));
	block.var[0][2][1] = (mat2(-6.0, 8.0, 5.0, 2.0));
	block.var[0][3][0] = (mat2(6.0, 1.0, 8.0, -1.0));
	block.var[0][3][1] = (mat2(9.0, 1.0, -2.0, -9.0));
	block.var[1][0][0] = (mat2(-8.0, 5.0, -6.0, -2.0));
	block.var[1][0][1] = (mat2(8.0, -5.0, 0.0, -2.0));
	block.var[1][1][0] = (mat2(-2.0, -9.0, -1.0, 8.0));
	block.var[1][1][1] = (mat2(-7.0, 5.0, -9.0, 3.0));
	block.var[1][2][0] = (mat2(5.0, -4.0, 3.0, 8.0));
	block.var[1][2][1] = (mat2(0.0, -2.0, 7.0, 4.0));
	block.var[1][3][0] = (mat2(1.0, -5.0, -9.0, -7.0));
	block.var[1][3][1] = (mat2(-6.0, 7.0, 4.0, 1.0));
	block.var[2][0][0] = (mat2(-1.0, -6.0, 4.0, -4.0));
	block.var[2][0][1] = (mat2(9.0, 7.0, -9.0, 0.0));
	block.var[2][1][0] = (mat2(-3.0, -1.0, -2.0, -9.0));
	block.var[2][1][1] = (mat2(5.0, 8.0, -2.0, 4.0));
	block.var[2][2][0] = (mat2(4.0, -4.0, 0.0, 7.0));
	block.var[2][2][1] = (mat2(-7.0, 7.0, -1.0, 4.0));
	block.var[2][3][0] = (mat2(-8.0, 7.0, -5.0, -1.0));
	block.var[2][3][1] = (mat2(-1.0, -7.0, -4.0, 0.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, row_major, buffer_reference) buffer Block
{
	highp mat3 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(block.var[0][0][0], mat3(2.0, 0.0, -4.0, -3.0, 4.0, 5.0, -1.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(-1.0, 4.0, -4.0, -3.0, 0.0, -1.0, -5.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(-1.0, 8.0, 3.0, 2.0, -6.0, -2.0, -2.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(-9.0, 0.0, 6.0, -9.0, -5.0, 8.0, -7.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[0][2][0], mat3(5.0, 9.0, 9.0, 5.0, -5.0, 9.0, 1.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[0][2][1], mat3(8.0, 8.0, -6.0, 5.0, 4.0, 8.0, -9.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[0][3][0], mat3(2.0, 2.0, 9.0, -8.0, -2.0, -1.0, 8.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[0][3][1], mat3(2.0, 4.0, -3.0, 1.0, -4.0, 4.0, 2.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(2.0, 4.0, -3.0, 8.0, 3.0, -2.0, -1.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(2.0, 8.0, 1.0, -3.0, -4.0, 7.0, -1.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(-7.0, 6.0, 2.0, 5.0, 4.0, 9.0, 7.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(1.0, -6.0, -3.0, -1.0, 6.0, 0.0, -2.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[1][2][0], mat3(2.0, 8.0, -1.0, -2.0, -4.0, 3.0, 5.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[1][2][1], mat3(8.0, 0.0, -9.0, -4.0, -9.0, 0.0, 9.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[1][3][0], mat3(-5.0, -1.0, 4.0, 8.0, 7.0, 0.0, 8.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[1][3][1], mat3(-4.0, -1.0, 6.0, 8.0, -8.0, 8.0, -5.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(-6.0, -6.0, -5.0, 5.0, -2.0, 0.0, 7.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(-3.0, 9.0, 7.0, 8.0, -9.0, -1.0, -4.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(2.0, 1.0, 9.0, -4.0, -9.0, 2.0, 5.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(0.0, 9.0, 5.0, 1.0, 2.0, 2.0, -5.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[2][2][0], mat3(-2.0, -2.0, -5.0, -6.0, -1.0, -4.0, 8.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[2][2][1], mat3(5.0, 2.0, 4.0, -8.0, 2.0, -4.0, -7.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[2][3][0], mat3(9.0, -3.0, 1.0, 6.0, -6.0, -5.0, 2.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[2][3][1], mat3(4.0, 5.0, 6.0, 1.0, 5.0, 9.0, 2.0, -4.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec3(3.0, -9.0, 3.0));
	block.var[0][0][0][1] = (vec3(2.0, 4.0, 6.0));
	block.var[0][0][0][2] = (vec3(2.0, -9.0, 0.0));
	block.var[0][0][1][0] = (vec3(-7.0, 3.0, -3.0));
	block.var[0][0][1][1] = (vec3(-4.0, -4.0, 5.0));
	block.var[0][0][1][2] = (vec3(-4.0, 1.0, -7.0));
	block.var[0][1][0][0] = (vec3(6.0, -2.0, -1.0));
	block.var[0][1][0][1] = (vec3(9.0, 2.0, -4.0));
	block.var[0][1][0][2] = (vec3(-9.0, -5.0, 4.0));
	block.var[0][1][1][0] = (vec3(-1.0, -6.0, 9.0));
	block.var[0][1][1][1] = (vec3(-1.0, 3.0, 0.0));
	block.var[0][1][1][2] = (vec3(-7.0, 1.0, -6.0));
	block.var[0][2][0][0] = (vec3(-7.0, 1.0, -4.0));
	block.var[0][2][0][1] = (vec3(8.0, -5.0, 4.0));
	block.var[0][2][0][2] = (vec3(1.0, -7.0, 3.0));
	block.var[0][2][1][0] = (vec3(-3.0, -3.0, 6.0));
	block.var[0][2][1][1] = (vec3(8.0, 1.0, -8.0));
	block.var[0][2][1][2] = (vec3(5.0, 9.0, -2.0));
	block.var[0][3][0][0] = (vec3(-3.0, -9.0, 1.0));
	block.var[0][3][0][1] = (vec3(-2.0, 3.0, -3.0));
	block.var[0][3][0][2] = (vec3(-1.0, 5.0, -8.0));
	block.var[0][3][1][0] = (vec3(3.0, -4.0, 8.0));
	block.var[0][3][1][1] = (vec3(-7.0, -8.0, -8.0));
	block.var[0][3][1][2] = (vec3(-6.0, 2.0, -1.0));
	block.var[1][0][0][0] = (vec3(7.0, 9.0, -7.0));
	block.var[1][0][0][1] = (vec3(8.0, 2.0, 5.0));
	block.var[1][0][0][2] = (vec3(-9.0, 7.0, -2.0));
	block.var[1][0][1][0] = (vec3(-7.0, 3.0, 4.0));
	block.var[1][0][1][1] = (vec3(-1.0, 1.0, 0.0));
	block.var[1][0][1][2] = (vec3(7.0, 7.0, 9.0));
	block.var[1][1][0][0] = (vec3(0.0, -6.0, 0.0));
	block.var[1][1][0][1] = (vec3(8.0, 6.0, 4.0));
	block.var[1][1][0][2] = (vec3(7.0, -4.0, 4.0));
	block.var[1][1][1][0] = (vec3(-6.0, 3.0, -3.0));
	block.var[1][1][1][1] = (vec3(0.0, -8.0, 6.0));
	block.var[1][1][1][2] = (vec3(-7.0, -2.0, 7.0));
	block.var[1][2][0][0] = (vec3(4.0, -7.0, 4.0));
	block.var[1][2][0][1] = (vec3(-6.0, 5.0, -4.0));
	block.var[1][2][0][2] = (vec3(5.0, -3.0, 3.0));
	block.var[1][2][1][0] = (vec3(8.0, 6.0, 1.0));
	block.var[1][2][1][1] = (vec3(6.0, 5.0, 1.0));
	block.var[1][2][1][2] = (vec3(7.0, 9.0, 0.0));
	block.var[1][3][0][0] = (vec3(5.0, 1.0, 3.0));
	block.var[1][3][0][1] = (vec3(-4.0, -5.0, 5.0));
	block.var[1][3][0][2] = (vec3(-6.0, 8.0, -7.0));
	block.var[1][3][1][0] = (vec3(0.0, -1.0, -9.0));
	block.var[1][3][1][1] = (vec3(-3.0, -5.0, 3.0));
	block.var[1][3][1][2] = (vec3(-3.0, -4.0, -7.0));
	block.var[2][0][0][0] = (vec3(4.0, 4.0, -3.0));
	block.var[2][0][0][1] = (vec3(9.0, 1.0, -6.0));
	block.var[2][0][0][2] = (vec3(7.0, -6.0, -1.0));
	block.var[2][0][1][0] = (vec3(-5.0, -2.0, -7.0));
	block.var[2][0][1][1] = (vec3(-8.0, -9.0, 6.0));
	block.var[2][0][1][2] = (vec3(2.0, -2.0, -7.0));
	block.var[2][1][0][0] = (vec3(4.0, -8.0, 1.0));
	block.var[2][1][0][1] = (vec3(-6.0, 7.0, 1.0));
	block.var[2][1][0][2] = (vec3(6.0, 3.0, 0.0));
	block.var[2][1][1][0] = (vec3(-2.0, -9.0, 9.0));
	block.var[2][1][1][1] = (vec3(1.0, 3.0, 4.0));
	block.var[2][1][1][2] = (vec3(5.0, -3.0, -6.0));
	block.var[2][2][0][0] = (vec3(-7.0, 8.0, 6.0));
	block.var[2][2][0][1] = (vec3(4.0, -8.0, -8.0));
	block.var[2][2][0][2] = (vec3(8.0, 9.0, -9.0));
	block.var[2][2][1][0] = (vec3(-8.0, -3.0, -7.0));
	block.var[2][2][1][1] = (vec3(4.0, -6.0, -4.0));
	block.var[2][2][1][2] = (vec3(-6.0, 0.0, 0.0));
	block.var[2][3][0][0] = (vec3(-5.0, 4.0, -6.0));
	block.var[2][3][0][1] = (vec3(-3.0, -1.0, -3.0));
	block.var[2][3][0][2] = (vec3(3.0, 3.0, 9.0));
	block.var[2][3][1][0] = (vec3(-6.0, -4.0, -5.0));
	block.var[2][3][1][1] = (vec3(5.0, 6.0, 7.0));
	block.var[2][3][1][2] = (vec3(-1.0, -3.0, -3.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, row_major, buffer_reference) buffer Block
{
	highp mat3x2 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(-4.0, 6.0, 0.0, 6.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(5.0, -1.0, 1.0, 7.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(7.0, 3.0, -1.0, 6.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(-8.0, -5.0, 9.0, -3.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][0], mat3x2(-4.0, -8.0, -7.0, -9.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][1], mat3x2(-1.0, -4.0, -4.0, 6.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][0], mat3x2(0.0, 9.0, -1.0, -2.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][1], mat3x2(4.0, 8.0, 2.0, -7.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(4.0, -5.0, -2.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(-2.0, -1.0, 5.0, 2.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(-4.0, 6.0, -7.0, 0.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(-9.0, 0.0, 9.0, -8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][0], mat3x2(-8.0, 8.0, -4.0, -8.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][1], mat3x2(-3.0, -7.0, -5.0, -7.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][0], mat3x2(2.0, 6.0, -9.0, 3.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][1], mat3x2(-6.0, -1.0, -5.0, 1.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(9.0, -5.0, 7.0, 6.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(-1.0, -4.0, 0.0, -2.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(-7.0, -5.0, 3.0, -3.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(-3.0, -2.0, 3.0, -8.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][0], mat3x2(0.0, -8.0, -1.0, 9.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][1], mat3x2(-7.0, -9.0, 6.0, -5.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][0], mat3x2(2.0, -1.0, -4.0, 7.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][1], mat3x2(5.0, 5.0, 4.0, -6.0, -5.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(9.0, -4.0));
	block.var[0][0][0][1] = (vec2(-7.0, 8.0));
	block.var[0][0][0][2] = (vec2(-2.0, -9.0));
	block.var[0][0][1][0] = (vec2(-1.0, 7.0));
	block.var[0][0][1][1] = (vec2(-3.0, -3.0));
	block.var[0][0][1][2] = (vec2(-8.0, 2.0));
	block.var[0][1][0][0] = (vec2(-3.0, -2.0));
	block.var[0][1][0][1] = (vec2(-9.0, -8.0));
	block.var[0][1][0][2] = (vec2(-8.0, 4.0));
	block.var[0][1][1][0] = (vec2(-2.0, 9.0));
	block.var[0][1][1][1] = (vec2(-1.0, 3.0));
	block.var[0][1][1][2] = (vec2(-2.0, 9.0));
	block.var[0][2][0][0] = (vec2(9.0, 4.0));
	block.var[0][2][0][1] = (vec2(-8.0, -6.0));
	block.var[0][2][0][2] = (vec2(4.0, -6.0));
	block.var[0][2][1][0] = (vec2(-9.0, -3.0));
	block.var[0][2][1][1] = (vec2(8.0, 9.0));
	block.var[0][2][1][2] = (vec2(4.0, -8.0));
	block.var[0][3][0][0] = (vec2(2.0, -5.0));
	block.var[0][3][0][1] = (vec2(2.0, 8.0));
	block.var[0][3][0][2] = (vec2(1.0, 5.0));
	block.var[0][3][1][0] = (vec2(-2.0, 0.0));
	block.var[0][3][1][1] = (vec2(-7.0, 5.0));
	block.var[0][3][1][2] = (vec2(-8.0, 2.0));
	block.var[1][0][0][0] = (vec2(-2.0, -1.0));
	block.var[1][0][0][1] = (vec2(-3.0, -3.0));
	block.var[1][0][0][2] = (vec2(-4.0, 5.0));
	block.var[1][0][1][0] = (vec2(9.0, 7.0));
	block.var[1][0][1][1] = (vec2(-4.0, 7.0));
	block.var[1][0][1][2] = (vec2(1.0, 6.0));
	block.var[1][1][0][0] = (vec2(-2.0, -4.0));
	block.var[1][1][0][1] = (vec2(-1.0, 9.0));
	block.var[1][1][0][2] = (vec2(-9.0, -4.0));
	block.var[1][1][1][0] = (vec2(-3.0, -2.0));
	block.var[1][1][1][1] = (vec2(7.0, -5.0));
	block.var[1][1][1][2] = (vec2(-5.0, 0.0));
	block.var[1][2][0][0] = (vec2(0.0, -4.0));
	block.var[1][2][0][1] = (vec2(6.0, -1.0));
	block.var[1][2][0][2] = (vec2(-7.0, 8.0));
	block.var[1][2][1][0] = (vec2(4.0, 2.0));
	block.var[1][2][1][1] = (vec2(2.0, -3.0));
	block.var[1][2][1][2] = (vec2(1.0, -6.0));
	block.var[1][3][0][0] = (vec2(6.0, 3.0));
	block.var[1][3][0][1] = (vec2(0.0, 1.0));
	block.var[1][3][0][2] = (vec2(7.0, -7.0));
	block.var[1][3][1][0] = (vec2(-4.0, 0.0));
	block.var[1][3][1][1] = (vec2(8.0, -1.0));
	block.var[1][3][1][2] = (vec2(-4.0, -1.0));
	block.var[2][0][0][0] = (vec2(-8.0, 9.0));
	block.var[2][0][0][1] = (vec2(8.0, 1.0));
	block.var[2][0][0][2] = (vec2(6.0, 8.0));
	block.var[2][0][1][0] = (vec2(-1.0, 2.0));
	block.var[2][0][1][1] = (vec2(1.0, -1.0));
	block.var[2][0][1][2] = (vec2(0.0, 3.0));
	block.var[2][1][0][0] = (vec2(4.0, -4.0));
	block.var[2][1][0][1] = (vec2(5.0, 5.0));
	block.var[2][1][0][2] = (vec2(2.0, -3.0));
	block.var[2][1][1][0] = (vec2(-5.0, -3.0));
	block.var[2][1][1][1] = (vec2(-7.0, 6.0));
	block.var[2][1][1][2] = (vec2(-6.0, 8.0));
	block.var[2][2][0][0] = (vec2(7.0, 3.0));
	block.var[2][2][0][1] = (vec2(-7.0, 5.0));
	block.var[2][2][0][2] = (vec2(2.0, -9.0));
	block.var[2][2][1][0] = (vec2(-2.0, -8.0));
	block.var[2][2][1][1] = (vec2(-9.0, 5.0));
	block.var[2][2][1][2] = (vec2(-2.0, 1.0));
	block.var[2][3][0][0] = (vec2(-3.0, 3.0));
	block.var[2][3][0][1] = (vec2(0.0, 5.0));
	block.var[2][3][0][2] = (vec2(-6.0, 4.0));
	block.var[2][3][1][0] = (vec2(-1.0, 1.0));
	block.var[2][3][1][1] = (vec2(-1.0, -6.0));
	block.var[2][3][1][2] = (vec2(3.0, -5.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, column_major, buffer_reference) buffer Block
{
	highp mat4x3 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(block.var[0][0][0], mat4x3(-4.0, 6.0, 7.0, -6.0, 2.0, -5.0, 0.0, -2.0, 8.0, -7.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][1], mat4x3(-4.0, -5.0, -7.0, 0.0, -7.0, -8.0, -3.0, 1.0, 3.0, 7.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][0], mat4x3(1.0, -2.0, 6.0, 7.0, -5.0, 9.0, -9.0, 6.0, -8.0, -3.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][1], mat4x3(5.0, -9.0, 6.0, 3.0, 3.0, 0.0, 0.0, -6.0, 9.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2][0], mat4x3(3.0, -6.0, 9.0, 8.0, -1.0, 8.0, -4.0, 2.0, 6.0, -9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2][1], mat4x3(5.0, -1.0, 4.0, 2.0, -4.0, -2.0, -1.0, -4.0, 5.0, 9.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][3][0], mat4x3(0.0, 1.0, 5.0, -8.0, -8.0, 0.0, -9.0, 5.0, 2.0, -6.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][3][1], mat4x3(5.0, -4.0, 3.0, -9.0, 3.0, 4.0, -2.0, 4.0, 4.0, 2.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][0], mat4x3(-9.0, 5.0, 2.0, -9.0, 9.0, 2.0, 8.0, -7.0, -4.0, 8.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][1], mat4x3(-9.0, 3.0, 0.0, 1.0, -4.0, 8.0, 3.0, -7.0, 8.0, -3.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][0], mat4x3(-1.0, -2.0, 2.0, -7.0, -8.0, -5.0, 3.0, -4.0, 5.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][1], mat4x3(5.0, 4.0, 1.0, -4.0, -7.0, 2.0, 0.0, 9.0, 7.0, -2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2][0], mat4x3(2.0, -6.0, -1.0, 6.0, 9.0, -3.0, -8.0, 7.0, -5.0, 0.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2][1], mat4x3(7.0, -5.0, -4.0, -3.0, 5.0, 8.0, 9.0, -5.0, -5.0, -3.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][3][0], mat4x3(-2.0, 0.0, 6.0, 2.0, -9.0, 3.0, 3.0, -4.0, 5.0, -3.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][3][1], mat4x3(8.0, -9.0, -9.0, -6.0, 7.0, -8.0, 3.0, 0.0, -3.0, 3.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][0], mat4x3(9.0, -8.0, -2.0, 4.0, -2.0, -5.0, -8.0, -4.0, -1.0, -9.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][1], mat4x3(-3.0, -2.0, 9.0, -5.0, -8.0, 1.0, -7.0, 6.0, -4.0, -6.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][0], mat4x3(-1.0, 6.0, -7.0, -6.0, 3.0, -7.0, -6.0, 4.0, 7.0, 5.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][1], mat4x3(1.0, 6.0, 2.0, 0.0, -4.0, 0.0, 8.0, -8.0, 7.0, 6.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2][0], mat4x3(9.0, -2.0, 0.0, 1.0, -8.0, -4.0, -9.0, 3.0, -1.0, 1.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2][1], mat4x3(-5.0, 1.0, 6.0, 5.0, 6.0, -1.0, -1.0, 1.0, -6.0, -5.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][3][0], mat4x3(-6.0, 1.0, 6.0, -1.0, 3.0, -4.0, 7.0, -7.0, -6.0, -3.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][3][1], mat4x3(-8.0, -1.0, 9.0, -6.0, 8.0, -4.0, -1.0, 0.0, -5.0, 0.0, -6.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec3(-3.0, -6.0, 6.0));
	block.var[0][0][0][1] = (vec3(1.0, -4.0, -3.0));
	block.var[0][0][0][2] = (vec3(-3.0, 3.0, -2.0));
	block.var[0][0][0][3] = (vec3(-7.0, 1.0, -5.0));
	block.var[0][0][1][0] = (vec3(-1.0, -5.0, 7.0));
	block.var[0][0][1][1] = (vec3(1.0, -2.0, -4.0));
	block.var[0][0][1][2] = (vec3(-4.0, -6.0, 5.0));
	block.var[0][0][1][3] = (vec3(-2.0, 6.0, -9.0));
	block.var[0][1][0][0] = (vec3(-7.0, -7.0, -7.0));
	block.var[0][1][0][1] = (vec3(6.0, -9.0, 3.0));
	block.var[0][1][0][2] = (vec3(-5.0, 2.0, 4.0));
	block.var[0][1][0][3] = (vec3(-2.0, -4.0, -6.0));
	block.var[0][1][1][0] = (vec3(-1.0, 5.0, 5.0));
	block.var[0][1][1][1] = (vec3(-9.0, -3.0, -9.0));
	block.var[0][1][1][2] = (vec3(3.0, 2.0, 0.0));
	block.var[0][1][1][3] = (vec3(0.0, -9.0, 7.0));
	block.var[0][2][0][0] = (vec3(-5.0, -6.0, -3.0));
	block.var[0][2][0][1] = (vec3(-2.0, 5.0, 8.0));
	block.var[0][2][0][2] = (vec3(2.0, -9.0, 7.0));
	block.var[0][2][0][3] = (vec3(7.0, -3.0, 4.0));
	block.var[0][2][1][0] = (vec3(9.0, 4.0, 1.0));
	block.var[0][2][1][1] = (vec3(5.0, -9.0, 2.0));
	block.var[0][2][1][2] = (vec3(-7.0, -3.0, -9.0));
	block.var[0][2][1][3] = (vec3(9.0, -6.0, 3.0));
	block.var[0][3][0][0] = (vec3(-4.0, -7.0, 3.0));
	block.var[0][3][0][1] = (vec3(6.0, 4.0, 1.0));
	block.var[0][3][0][2] = (vec3(-3.0, 3.0, 8.0));
	block.var[0][3][0][3] = (vec3(-6.0, 5.0, -6.0));
	block.var[0][3][1][0] = (vec3(3.0, 2.0, 3.0));
	block.var[0][3][1][1] = (vec3(1.0, -7.0, 3.0));
	block.var[0][3][1][2] = (vec3(6.0, -3.0, -2.0));
	block.var[0][3][1][3] = (vec3(3.0, 1.0, -1.0));
	block.var[1][0][0][0] = (vec3(5.0, -5.0, 7.0));
	block.var[1][0][0][1] = (vec3(-4.0, 8.0, -3.0));
	block.var[1][0][0][2] = (vec3(-2.0, 0.0, 8.0));
	block.var[1][0][0][3] = (vec3(-2.0, 6.0, -3.0));
	block.var[1][0][1][0] = (vec3(-9.0, -2.0, -2.0));
	block.var[1][0][1][1] = (vec3(7.0, 9.0, -4.0));
	block.var[1][0][1][2] = (vec3(3.0, 1.0, 0.0));
	block.var[1][0][1][3] = (vec3(-9.0, -2.0, -7.0));
	block.var[1][1][0][0] = (vec3(5.0, -5.0, -2.0));
	block.var[1][1][0][1] = (vec3(6.0, 5.0, -4.0));
	block.var[1][1][0][2] = (vec3(-2.0, 9.0, -3.0));
	block.var[1][1][0][3] = (vec3(2.0, 5.0, -4.0));
	block.var[1][1][1][0] = (vec3(6.0, 4.0, 7.0));
	block.var[1][1][1][1] = (vec3(1.0, -4.0, -6.0));
	block.var[1][1][1][2] = (vec3(4.0, -6.0, -5.0));
	block.var[1][1][1][3] = (vec3(5.0, 6.0, -1.0));
	block.var[1][2][0][0] = (vec3(-9.0, -4.0, 0.0));
	block.var[1][2][0][1] = (vec3(5.0, 8.0, 9.0));
	block.var[1][2][0][2] = (vec3(-7.0, -9.0, -5.0));
	block.var[1][2][0][3] = (vec3(0.0, -1.0, -6.0));
	block.var[1][2][1][0] = (vec3(-9.0, -9.0, 9.0));
	block.var[1][2][1][1] = (vec3(9.0, -1.0, 8.0));
	block.var[1][2][1][2] = (vec3(8.0, -8.0, 4.0));
	block.var[1][2][1][3] = (vec3(9.0, -8.0, 8.0));
	block.var[1][3][0][0] = (vec3(0.0, 9.0, -4.0));
	block.var[1][3][0][1] = (vec3(6.0, -5.0, 0.0));
	block.var[1][3][0][2] = (vec3(-2.0, 4.0, 6.0));
	block.var[1][3][0][3] = (vec3(-5.0, 2.0, 4.0));
	block.var[1][3][1][0] = (vec3(-4.0, -4.0, 0.0));
	block.var[1][3][1][1] = (vec3(-2.0, 5.0, 7.0));
	block.var[1][3][1][2] = (vec3(8.0, 8.0, -3.0));
	block.var[1][3][1][3] = (vec3(-9.0, -7.0, 5.0));
	block.var[2][0][0][0] = (vec3(-5.0, -6.0, 5.0));
	block.var[2][0][0][1] = (vec3(-2.0, -7.0, 5.0));
	block.var[2][0][0][2] = (vec3(-2.0, -6.0, 4.0));
	block.var[2][0][0][3] = (vec3(9.0, 5.0, -9.0));
	block.var[2][0][1][0] = (vec3(-3.0, 3.0, 7.0));
	block.var[2][0][1][1] = (vec3(3.0, -4.0, -8.0));
	block.var[2][0][1][2] = (vec3(-2.0, 2.0, -1.0));
	block.var[2][0][1][3] = (vec3(1.0, -9.0, 9.0));
	block.var[2][1][0][0] = (vec3(6.0, 3.0, -9.0));
	block.var[2][1][0][1] = (vec3(-7.0, 3.0, -4.0));
	block.var[2][1][0][2] = (vec3(1.0, 2.0, 6.0));
	block.var[2][1][0][3] = (vec3(-2.0, 3.0, 7.0));
	block.var[2][1][1][0] = (vec3(-5.0, 8.0, -9.0));
	block.var[2][1][1][1] = (vec3(-4.0, -1.0, -9.0));
	block.var[2][1][1][2] = (vec3(5.0, 5.0, 6.0));
	block.var[2][1][1][3] = (vec3(-8.0, 1.0, -7.0));
	block.var[2][2][0][0] = (vec3(4.0, 6.0, 1.0));
	block.var[2][2][0][1] = (vec3(-9.0, 7.0, 3.0));
	block.var[2][2][0][2] = (vec3(-4.0, -3.0, 8.0));
	block.var[2][2][0][3] = (vec3(-9.0, -9.0, 2.0));
	block.var[2][2][1][0] = (vec3(0.0, -2.0, 5.0));
	block.var[2][2][1][1] = (vec3(8.0, 4.0, -4.0));
	block.var[2][2][1][2] = (vec3(5.0, 4.0, -5.0));
	block.var[2][2][1][3] = (vec3(0.0, -3.0, 9.0));
	block.var[2][3][0][0] = (vec3(6.0, -7.0, -2.0));
	block.var[2][3][0][1] = (vec3(0.0, 3.0, -5.0));
	block.var[2][3][0][2] = (vec3(-6.0, -7.0, -4.0));
	block.var[2][3][0][3] = (vec3(-8.0, 1.0, -7.0));
	block.var[2][3][1][0] = (vec3(2.0, -4.0, -7.0));
	block.var[2][3][1][1] = (vec3(-3.0, -4.0, 0.0));
	block.var[2][3][1][2] = (vec3(-8.0, -2.0, 6.0));
	block.var[2][3][1][3] = (vec3(-7.0, -7.0, 2.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

struct S
{
	highp ivec3 a;
	mediump mat3 b[4];
	highp vec4 c;
};
layout(std140, buffer_reference) buffer Block
{
	S s;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((block.s.a), ivec3(4, -9, 2)) && allOk;
	allOk = compare_mat3(block.s.b[0], mat3(-4.0, 1.0, 2.0, 9.0, -7.0, -8.0, -6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3(block.s.b[1], mat3(5.0, 2.0, 9.0, 9.0, 7.0, -7.0, 5.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat3(block.s.b[2], mat3(3.0, 0.0, -3.0, 5.0, -2.0, -5.0, -5.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3(block.s.b[3], mat3(7.0, -4.0, -9.0, 3.0, -7.0, -7.0, -9.0, 2.0, -1.0)) && allOk;
	allOk = compare_vec4((block.s.c), vec4(9.0, 0.0, 5.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s.a = (ivec3(-6, -2, 3));
	block.s.b[0][0] = (vec3(4.0, 0.0, -1.0));
	block.s.b[0][1] = (vec3(-9.0, -8.0, 0.0));
	block.s.b[0][2] = (vec3(7.0, 2.0, 7.0));
	block.s.b[1][0] = (vec3(-7.0, 5.0, 1.0));
	block.s.b[1][1] = (vec3(-7.0, -6.0, -4.0));
	block.s.b[1][2] = (vec3(-5.0, 1.0, -1.0));
	block.s.b[2][0] = (vec3(7.0, -4.0, 6.0));
	block.s.b[2][1] = (vec3(-5.0, 7.0, 1.0));
	block.s.b[2][2] = (vec3(-5.0, 3.0, 8.0));
	block.s.b[3][0] = (vec3(9.0, -2.0, -6.0));
	block.s.b[3][1] = (vec3(1.0, 1.0, -5.0));
	block.s.b[3][2] = (vec3(-7.0, 4.0, 7.0));
	block.s.c = (vec4(-6.0, 2.0, 7.0, 6.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

struct S
{
	highp ivec3 a;
	mediump mat3 b[4];
	highp vec4 c;
};
struct T
{
	mediump mat3 a;
	S b;
};
layout(std140, buffer_reference) buffer Block
{
	S s;
	lowp vec2 v;
	T t;
	highp uint u;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((block.s.a), ivec3(0, 2, 6)) && allOk;
	allOk = compare_mat3(block.s.b[0], mat3(8.0, -8.0, 2.0, -3.0, -1.0, -8.0, 8.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat3(block.s.b[1], mat3(-7.0, -1.0, 4.0, 9.0, -9.0, 8.0, 0.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat3(block.s.b[2], mat3(-1.0, -2.0, -1.0, -6.0, 9.0, -8.0, -3.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3(block.s.b[3], mat3(9.0, -8.0, -7.0, -4.0, 4.0, 0.0, 9.0, 9.0, -8.0)) && allOk;
	allOk = compare_vec4((block.s.c), vec4(1.0, 3.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3(block.t.a, mat3(7.0, -4.0, -9.0, 1.0, -7.0, 7.0, 2.0, 2.0, -7.0)) && allOk;
	allOk = compare_ivec3((block.t.b.a), ivec3(-7, -6, -7)) && allOk;
	allOk = compare_mat3(block.t.b.b[0], mat3(-7.0, -3.0, 6.0, -3.0, 5.0, 2.0, -4.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat3(block.t.b.b[1], mat3(6.0, -4.0, 5.0, -3.0, 5.0, 5.0, 5.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3(block.t.b.b[2], mat3(1.0, -9.0, -3.0, -8.0, -7.0, -3.0, 0.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat3(block.t.b.b[3], mat3(3.0, -7.0, 6.0, 0.0, -7.0, -2.0, -2.0, -6.0, 8.0)) && allOk;
	allOk = compare_vec4((block.t.b.c), vec4(1.0, -8.0, -3.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.t.a[0] = (vec3(1.0, 6.0, 5.0));
	block.t.a[1] = (vec3(4.0, 1.0, -8.0));
	block.t.a[2] = (vec3(-1.0, -3.0, -7.0));
	block.t.b.a = (ivec3(-7, -4, -4));
	block.t.b.b[0][0] = (vec3(6.0, -7.0, -1.0));
	block.t.b.b[0][1] = (vec3(-7.0, -2.0, 0.0));
	block.t.b.b[0][2] = (vec3(-2.0, 5.0, 2.0));
	block.t.b.b[1][0] = (vec3(7.0, -6.0, 0.0));
	block.t.b.b[1][1] = (vec3(2.0, 9.0, 6.0));
	block.t.b.b[1][2] = (vec3(-7.0, 4.0, -3.0));
	block.t.b.b[2][0] = (vec3(5.0, -3.0, 0.0));
	block.t.b.b[2][1] = (vec3(9.0, 0.0, 8.0));
	block.t.b.b[2][2] = (vec3(7.0, -6.0, 0.0));
	block.t.b.b[3][0] = (vec3(5.0, -8.0, 1.0));
	block.t.b.b[3][1] = (vec3(4.0, 1.0, 3.0));
	block.t.b.b[3][2] = (vec3(-2.0, -7.0, -3.0));
	block.t.b.c = (vec4(-3.0, -3.0, 6.0, 4.0));
	block.u = (5u);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

struct S
{
	highp ivec3 a;
	mediump ivec2 b[4];
	highp vec4 c;
};
struct T
{
	mediump mat3 a;
	S b[3];
};
layout(std140, buffer_reference) buffer Block
{
	S s;
	lowp vec2 v;
	T t[2];
	highp uint u;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(block.t[0].a, mat3(2.0, 4.0, -1.0, 9.0, 0.0, -9.0, 1.0, -2.0, 4.0)) && allOk;
	allOk = compare_ivec3((block.t[0].b[0].a), ivec3(8, -3, 3)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[0]), ivec2(-7, -3)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[1]), ivec2(4, 4)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[2]), ivec2(-9, -3)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[3]), ivec2(1, 2)) && allOk;
	allOk = compare_vec4((block.t[0].b[0].c), vec4(-8.0, -2.0, 3.0, 1.0)) && allOk;
	allOk = compare_ivec3((block.t[0].b[1].a), ivec3(2, 0, 7)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[0]), ivec2(-5, 5)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[1]), ivec2(9, 4)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[2]), ivec2(-3, -6)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[3]), ivec2(1, 1)) && allOk;
	allOk = compare_vec4((block.t[0].b[1].c), vec4(-2.0, 1.0, -3.0, 1.0)) && allOk;
	allOk = compare_ivec3((block.t[0].b[2].a), ivec3(-9, -1, -1)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[0]), ivec2(-2, -3)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[1]), ivec2(4, -9)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[2]), ivec2(4, 6)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[3]), ivec2(-7, 8)) && allOk;
	allOk = compare_vec4((block.t[0].b[2].c), vec4(-3.0, 4.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat3(block.t[1].a, mat3(-9.0, 9.0, -4.0, 2.0, 9.0, 7.0, 3.0, -4.0, -7.0)) && allOk;
	allOk = compare_ivec3((block.t[1].b[0].a), ivec3(0, 1, -6)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[0]), ivec2(4, 1)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[1]), ivec2(-6, 6)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[2]), ivec2(1, 0)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[3]), ivec2(-2, -9)) && allOk;
	allOk = compare_vec4((block.t[1].b[0].c), vec4(-5.0, -3.0, -2.0, -2.0)) && allOk;
	allOk = compare_ivec3((block.t[1].b[1].a), ivec3(0, -4, 8)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[0]), ivec2(1, 8)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[1]), ivec2(2, -1)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[2]), ivec2(1, -1)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[3]), ivec2(7, -3)) && allOk;
	allOk = compare_vec4((block.t[1].b[1].c), vec4(9.0, -6.0, -9.0, -2.0)) && allOk;
	allOk = compare_ivec3((block.t[1].b[2].a), ivec3(2, 2, 2)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[0]), ivec2(-8, 7)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[1]), ivec2(-9, 1)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[2]), ivec2(1, -2)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[3]), ivec2(9, 3)) && allOk;
	allOk = compare_vec4((block.t[1].b[2].c), vec4(1.0, -4.0, 2.0, -2.0)) && allOk;
	allOk = compare_uint((block.u), 5u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s.a = (ivec3(2, -5, -8));
	block.s.b[0] = (ivec2(6, -9));
	block.s.b[1] = (ivec2(-9, -8));
	block.s.b[2] = (ivec2(0, -1));
	block.s.b[3] = (ivec2(-9, 2));
	block.s.c = (vec4(-5.0, 6.0, -6.0, -5.0));
	block.u = (4u);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

struct S
{
	highp ivec3 a;
	mediump ivec2 b[4];
	highp vec4 c;
};
struct T
{
	mediump mat3 a;
	S b[3];
};
layout(std140, buffer_reference) buffer Block
{
	S s;
	lowp vec2 v;
	T t[2];
	highp uint u;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(block[0].t[0].a, mat3(-4.0, -9.0, 0.0, -8.0, -1.0, -4.0, 7.0, -8.0, 2.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[0].a), ivec3(3, -2, -2)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[0]), ivec2(8, 1)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[1]), ivec2(1, -8)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[2]), ivec2(1, 8)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[3]), ivec2(-7, 4)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[0].c), vec4(1.0, 1.0, -3.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[1].a), ivec3(4, 4, -4)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[0]), ivec2(4, 9)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[1]), ivec2(-8, 0)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[2]), ivec2(-3, -6)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[3]), ivec2(-8, -8)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[1].c), vec4(6.0, -6.0, 2.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[2].a), ivec3(-5, -8, -3)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[0]), ivec2(-2, -1)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[1]), ivec2(-1, 7)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[2]), ivec2(-6, 8)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[3]), ivec2(3, 7)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[2].c), vec4(6.0, -8.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat3(block[0].t[1].a, mat3(-6.0, -5.0, -6.0, 7.0, -1.0, -7.0, 9.0, 0.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[0].a), ivec3(-8, 1, -6)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[0]), ivec2(2, 4)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[1]), ivec2(1, 2)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[2]), ivec2(-1, 2)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[3]), ivec2(3, -4)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[0].c), vec4(4.0, 3.0, 8.0, 7.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[1].a), ivec3(6, -6, 6)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[0]), ivec2(9, -7)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[1]), ivec2(2, -8)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[2]), ivec2(3, 7)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[3]), ivec2(3, 9)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[1].c), vec4(7.0, -6.0, -7.0, 2.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[2].a), ivec3(5, -9, 1)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[0]), ivec2(2, -1)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[1]), ivec2(-5, -1)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[2]), ivec2(-3, 5)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[3]), ivec2(-6, -7)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[2].c), vec4(-5.0, -6.0, -4.0, -7.0)) && allOk;
	allOk = compare_uint((block[0].u), 1u) && allOk;
	allOk = compare_mat3(block[1].t[0].a, mat3(7.0, 2.0, 6.0, 4.0, -1.0, -7.0, -1.0, 8.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[0].a), ivec3(3, 9, 0)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[0]), ivec2(-1, 6)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[1]), ivec2(1, 5)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[2]), ivec2(1, 0)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[3]), ivec2(4, -8)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[0].c), vec4(-4.0, 9.0, 7.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[1].a), ivec3(1, 2, -9)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[0]), ivec2(7, -7)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[1]), ivec2(-4, -8)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[2]), ivec2(5, -3)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[3]), ivec2(7, -9)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[1].c), vec4(2.0, 3.0, -3.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[2].a), ivec3(-9, 5, 1)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[0]), ivec2(-5, -1)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[1]), ivec2(5, -7)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[2]), ivec2(-2, 4)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[3]), ivec2(-8, -7)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[2].c), vec4(-7.0, 0.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat3(block[1].t[1].a, mat3(-4.0, 1.0, 6.0, 1.0, -8.0, -1.0, -5.0, 3.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[0].a), ivec3(1, 1, 3)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[0]), ivec2(4, -8)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[1]), ivec2(-2, -3)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[2]), ivec2(-9, -4)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[3]), ivec2(4, -5)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[0].c), vec4(-7.0, -5.0, 1.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[1].a), ivec3(3, 4, -7)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[0]), ivec2(9, 3)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[1]), ivec2(1, -8)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[2]), ivec2(8, 0)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[3]), ivec2(-2, -4)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[1].c), vec4(2.0, 6.0, 4.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[2].a), ivec3(5, 3, -6)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[0]), ivec2(-1, 2)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[1]), ivec2(-6, 0)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[2]), ivec2(2, -7)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[3]), ivec2(-2, 0)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[2].c), vec4(8.0, 8.0, -6.0, 5.0)) && allOk;
	allOk = compare_uint((block[1].u), 7u) && allOk;
	allOk = compare_mat3(block[2].t[0].a, mat3(-5.0, 0.0, -6.0, 5.0, -4.0, -5.0, 6.0, 1.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[0].a), ivec3(5, -9, -3)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[0]), ivec2(-1, -5)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[1]), ivec2(8, 2)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[2]), ivec2(0, 8)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[3]), ivec2(3, -3)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[0].c), vec4(-3.0, 1.0, -9.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[1].a), ivec3(7, -7, -2)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[0]), ivec2(-8, 8)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[1]), ivec2(1, -2)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[2]), ivec2(4, -5)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[3]), ivec2(-8, -5)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[1].c), vec4(-5.0, -5.0, -6.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[2].a), ivec3(-4, 7, 9)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[0]), ivec2(-6, 6)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[1]), ivec2(5, -5)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[2]), ivec2(-2, -5)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[3]), ivec2(-3, -3)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[2].c), vec4(-7.0, -2.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat3(block[2].t[1].a, mat3(-6.0, -6.0, 8.0, -2.0, 2.0, 6.0, -7.0, 6.0, -3.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[0].a), ivec3(-6, -5, -8)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[0]), ivec2(2, -8)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[1]), ivec2(-7, -5)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[2]), ivec2(9, 7)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[3]), ivec2(9, 4)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[0].c), vec4(-4.0, 2.0, -9.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[1].a), ivec3(-4, 3, 3)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[0]), ivec2(-2, -6)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[1]), ivec2(6, -9)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[2]), ivec2(4, 3)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[3]), ivec2(-8, 5)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[1].c), vec4(3.0, 7.0, -2.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[2].a), ivec3(-3, -3, -3)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[0]), ivec2(-1, 8)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[1]), ivec2(-7, 9)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[2]), ivec2(7, 0)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[3]), ivec2(3, 6)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[2].c), vec4(-3.0, -1.0, 6.0, -6.0)) && allOk;
	allOk = compare_uint((block[2].u), 5u) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (ivec3(-2, -2, 5));
	block[0].s.b[0] = (ivec2(6, -1));
	block[0].s.b[1] = (ivec2(-7, 3));
	block[0].s.b[2] = (ivec2(2, -9));
	block[0].s.b[3] = (ivec2(-5, 6));
	block[0].s.c = (vec4(-7.0, 7.0, 4.0, -9.0));
	block[0].u = (5u);
	block[1].s.a = (ivec3(4, 4, 9));
	block[1].s.b[0] = (ivec2(-3, 1));
	block[1].s.b[1] = (ivec2(9, -9));
	block[1].s.b[2] = (ivec2(-4, -9));
	block[1].s.b[3] = (ivec2(-5, 1));
	block[1].s.c = (vec4(4.0, -6.0, 7.0, -7.0));
	block[1].u = (3u);
	block[2].s.a = (ivec3(-7, -4, 0));
	block[2].s.b[0] = (ivec2(6, -2));
	block[2].s.b[1] = (ivec2(6, 5));
	block[2].s.b[2] = (ivec2(7, -1));
	block[2].s.b[3] = (ivec2(9, 7));
	block[2].s.c = (vec4(3.0, 0.0, -3.0, 0.0));
	block[2].u = (1u);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

struct S
{
	highp ivec3 a;
	mediump ivec2 b[4];
	highp vec4 c;
};
struct T
{
	mediump mat3 a;
	S b[3];
};
layout(scalar, buffer_reference) buffer Block
{
	S s;
	lowp vec2 v;
	T t[2];
	highp uint u;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(block[0].t[0].a, mat3(-8.0, 0.0, 6.0, -4.0, -5.0, 0.0, -4.0, 6.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[0].a), ivec3(8, -3, 1)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[0]), ivec2(8, 5)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[1]), ivec2(-1, -3)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[2]), ivec2(-8, -4)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[3]), ivec2(-8, -9)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[0].c), vec4(7.0, 8.0, 0.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[1].a), ivec3(1, 5, 1)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[0]), ivec2(2, -4)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[1]), ivec2(7, -9)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[2]), ivec2(0, -9)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[3]), ivec2(0, 5)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[1].c), vec4(-4.0, 1.0, 1.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[2].a), ivec3(-8, 6, 7)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[0]), ivec2(8, -9)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[1]), ivec2(3, 0)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[2]), ivec2(3, -2)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[3]), ivec2(-8, -9)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[2].c), vec4(3.0, -9.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat3(block[0].t[1].a, mat3(1.0, 8.0, -2.0, -9.0, -5.0, 3.0, -9.0, 6.0, -3.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[0].a), ivec3(-5, 2, 1)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[0]), ivec2(-3, -1)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[1]), ivec2(-8, 0)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[2]), ivec2(-7, -5)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[3]), ivec2(3, 3)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[0].c), vec4(0.0, -2.0, -2.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[1].a), ivec3(9, -9, 9)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[0]), ivec2(-8, 2)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[1]), ivec2(6, 1)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[2]), ivec2(6, -9)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[3]), ivec2(3, 7)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[1].c), vec4(0.0, -4.0, -7.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[2].a), ivec3(2, -8, -7)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[0]), ivec2(-2, -6)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[1]), ivec2(0, -9)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[2]), ivec2(5, -4)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[3]), ivec2(-9, 6)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[2].c), vec4(1.0, 0.0, 6.0, -2.0)) && allOk;
	allOk = compare_uint((block[0].u), 4u) && allOk;
	allOk = compare_mat3(block[1].t[0].a, mat3(-6.0, -6.0, 0.0, 8.0, 7.0, -7.0, 7.0, -6.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[0].a), ivec3(-4, 4, -1)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[0]), ivec2(-2, 2)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[1]), ivec2(6, 2)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[2]), ivec2(-3, 2)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[3]), ivec2(-4, -9)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[0].c), vec4(-3.0, -5.0, 8.0, 2.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[1].a), ivec3(2, 8, 9)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[0]), ivec2(7, -4)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[1]), ivec2(3, -4)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[2]), ivec2(-1, 3)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[3]), ivec2(-8, 0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[1].c), vec4(-6.0, -6.0, -1.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[2].a), ivec3(-7, 8, 6)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[0]), ivec2(-7, 4)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[1]), ivec2(0, 9)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[2]), ivec2(9, 5)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[3]), ivec2(2, -4)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[2].c), vec4(-9.0, 0.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3(block[1].t[1].a, mat3(3.0, 8.0, 6.0, -4.0, 3.0, 6.0, 5.0, -3.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[0].a), ivec3(9, 4, -6)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[0]), ivec2(5, -6)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[1]), ivec2(4, 2)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[2]), ivec2(7, 9)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[3]), ivec2(3, 4)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[0].c), vec4(-1.0, 3.0, 0.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[1].a), ivec3(-7, 3, -6)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[0]), ivec2(4, -9)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[1]), ivec2(-9, -8)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[2]), ivec2(-4, 0)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[3]), ivec2(-8, -5)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[1].c), vec4(8.0, 2.0, -2.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[2].a), ivec3(-3, -4, 9)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[0]), ivec2(3, -4)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[1]), ivec2(-5, -1)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[2]), ivec2(0, -9)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[3]), ivec2(-2, 5)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[2].c), vec4(-7.0, -9.0, 3.0, 0.0)) && allOk;
	allOk = compare_uint((block[1].u), 7u) && allOk;
	allOk = compare_mat3(block[2].t[0].a, mat3(4.0, -2.0, 8.0, -7.0, 9.0, -8.0, -4.0, -6.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[0].a), ivec3(2, -8, 2)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[0]), ivec2(-3, -4)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[1]), ivec2(-2, 2)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[2]), ivec2(6, 2)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[3]), ivec2(-5, 9)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[0].c), vec4(-5.0, 7.0, -9.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[1].a), ivec3(0, 7, -4)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[0]), ivec2(-5, -2)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[1]), ivec2(6, -3)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[2]), ivec2(-7, 8)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[3]), ivec2(-8, 5)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[1].c), vec4(7.0, 5.0, -5.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[2].a), ivec3(-7, 0, 8)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[0]), ivec2(-2, -6)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[1]), ivec2(4, 4)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[2]), ivec2(-9, 4)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[3]), ivec2(4, 8)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[2].c), vec4(-5.0, 5.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat3(block[2].t[1].a, mat3(-7.0, 0.0, -8.0, -1.0, 2.0, 6.0, 6.0, 6.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[0].a), ivec3(4, -9, 2)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[0]), ivec2(-9, 1)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[1]), ivec2(2, 9)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[2]), ivec2(3, -2)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[3]), ivec2(1, -6)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[0].c), vec4(-7.0, -2.0, -8.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[1].a), ivec3(1, 7, 0)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[0]), ivec2(-8, 8)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[1]), ivec2(-3, -1)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[2]), ivec2(1, 0)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[3]), ivec2(6, -7)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[1].c), vec4(3.0, 1.0, 7.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[2].a), ivec3(4, 0, 6)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[0]), ivec2(-9, 6)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[1]), ivec2(-5, -6)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[2]), ivec2(1, -4)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[3]), ivec2(2, -8)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[2].c), vec4(2.0, 9.0, 5.0, 2.0)) && allOk;
	allOk = compare_uint((block[2].u), 2u) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (ivec3(-3, 1, 0));
	block[0].s.b[0] = (ivec2(-9, -4));
	block[0].s.b[1] = (ivec2(-7, 3));
	block[0].s.b[2] = (ivec2(-8, 0));
	block[0].s.b[3] = (ivec2(-3, -8));
	block[0].s.c = (vec4(9.0, 4.0, -7.0, -4.0));
	block[0].u = (5u);
	block[1].s.a = (ivec3(-8, 2, 2));
	block[1].s.b[0] = (ivec2(0, -4));
	block[1].s.b[1] = (ivec2(-7, 6));
	block[1].s.b[2] = (ivec2(5, 2));
	block[1].s.b[3] = (ivec2(-9, 5));
	block[1].s.c = (vec4(-5.0, 0.0, -3.0, 0.0));
	block[1].u = (1u);
	block[2].s.a = (ivec3(0, 7, 7));
	block[2].s.b[0] = (ivec2(7, -8));
	block[2].s.b[1] = (ivec2(2, -4));
	block[2].s.b[2] = (ivec2(-3, 0));
	block[2].s.b[3] = (ivec2(2, 4));
	block[2].s.c = (vec4(6.0, -3.0, 0.0, 2.0));
	block[2].u = (3u);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

struct S
{
	highp uvec2 a;
	mediump mat2x4 b[4];
	highp vec3 c;
};
layout(std140, buffer_reference) buffer Block
{
	lowp vec2 u;
	mediump uint v;
	S s[];
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((block[0].s[0].a), uvec2(3u, 5u)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[0], mat2x4(3.0, -8.0, -7.0, 7.0, -2.0, -2.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[1], mat2x4(0.0, -8.0, -1.0, -4.0, 7.0, -8.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[2], mat2x4(-5.0, -6.0, 7.0, -1.0, -7.0, 9.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[3], mat2x4(3.0, -2.0, -2.0, -8.0, 1.0, -6.0, 8.0, 1.0)) && allOk;
	allOk = compare_vec3((block[0].s[0].c), vec3(3.0, 9.0, -3.0)) && allOk;
	allOk = compare_uvec2((block[0].s[1].a), uvec2(3u, 4u)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[0], mat2x4(1.0, -8.0, 1.0, 8.0, -7.0, 4.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[1], mat2x4(1.0, 2.0, -1.0, 2.0, 3.0, -4.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[2], mat2x4(-3.0, -4.0, 4.0, 3.0, 8.0, 7.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[3], mat2x4(-4.0, 6.0, -6.0, 6.0, 4.0, 9.0, -8.0, 0.0)) && allOk;
	allOk = compare_vec3((block[0].s[1].c), vec3(-5.0, 7.0, 2.0)) && allOk;
	allOk = compare_uvec2((block[0].s[2].a), uvec2(4u, 6u)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[0], mat2x4(-3.0, -6.0, -8.0, -8.0, 9.0, -7.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[1], mat2x4(3.0, 7.0, 3.0, 9.0, 6.0, -6.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[2], mat2x4(7.0, -6.0, -7.0, 2.0, -5.0, -8.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[3], mat2x4(-9.0, 1.0, -2.0, -1.0, -1.0, 7.0, -6.0, 8.0)) && allOk;
	allOk = compare_vec3((block[0].s[2].c), vec3(6.0, 4.0, -1.0)) && allOk;
	allOk = compare_uvec2((block[0].s[3].a), uvec2(2u, 4u)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[0], mat2x4(3.0, 7.0, 2.0, -1.0, -5.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[1], mat2x4(-6.0, -7.0, 6.0, -8.0, -8.0, 8.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[2], mat2x4(-4.0, -7.0, -4.0, 9.0, 7.0, 1.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[3], mat2x4(-2.0, 2.0, 1.0, 2.0, 8.0, -2.0, 4.0, 2.0)) && allOk;
	allOk = compare_vec3((block[0].s[3].c), vec3(-7.0, -1.0, 8.0)) && allOk;
	allOk = compare_uvec2((block[1].s[0].a), uvec2(8u, 9u)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[0], mat2x4(9.0, 0.0, 1.0, 1.0, 3.0, -1.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[1], mat2x4(5.0, 1.0, 0.0, 4.0, -8.0, 4.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[2], mat2x4(-3.0, -9.0, -4.0, 4.0, -5.0, -4.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[3], mat2x4(-6.0, -7.0, -5.0, 1.0, 0.0, 1.0, 2.0, -9.0)) && allOk;
	allOk = compare_vec3((block[1].s[0].c), vec3(-6.0, -5.0, -8.0)) && allOk;
	allOk = compare_uvec2((block[1].s[1].a), uvec2(0u, 0u)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[0], mat2x4(3.0, 4.0, -7.0, 7.0, -7.0, -4.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[1], mat2x4(-3.0, 7.0, -9.0, 9.0, 3.0, 1.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[2], mat2x4(0.0, -2.0, -4.0, 2.0, 3.0, -3.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[3], mat2x4(6.0, 4.0, 6.0, -9.0, 5.0, 1.0, 5.0, 3.0)) && allOk;
	allOk = compare_vec3((block[1].s[1].c), vec3(-1.0, -5.0, 8.0)) && allOk;
	allOk = compare_uvec2((block[1].s[2].a), uvec2(0u, 6u)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[0], mat2x4(-6.0, -5.0, -1.0, 5.0, -7.0, -2.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[1], mat2x4(-7.0, -1.0, 2.0, -6.0, 0.0, 2.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[2], mat2x4(0.0, -7.0, 0.0, -8.0, 0.0, 8.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[3], mat2x4(5.0, 6.0, -2.0, 6.0, 4.0, -1.0, 2.0, -2.0)) && allOk;
	allOk = compare_vec3((block[1].s[2].c), vec3(2.0, 0.0, 8.0)) && allOk;
	allOk = compare_uvec2((block[1].s[3].a), uvec2(6u, 6u)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[0], mat2x4(1.0, 9.0, 7.0, 9.0, -2.0, 7.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[1], mat2x4(-3.0, -6.0, -2.0, -5.0, 0.0, -6.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[2], mat2x4(-5.0, 6.0, 1.0, 9.0, -6.0, -6.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[3], mat2x4(2.0, 6.0, -7.0, 6.0, -3.0, 5.0, -9.0, -3.0)) && allOk;
	allOk = compare_vec3((block[1].s[3].c), vec3(3.0, -3.0, 2.0)) && allOk;
	allOk = compare_uvec2((block[2].s[0].a), uvec2(1u, 1u)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[0], mat2x4(-9.0, -9.0, -4.0, 2.0, -9.0, 9.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[1], mat2x4(-2.0, -4.0, 3.0, 3.0, -8.0, 8.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[2], mat2x4(4.0, -5.0, -8.0, -5.0, -2.0, -6.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[3], mat2x4(4.0, 3.0, -8.0, 5.0, -5.0, -5.0, -6.0, -9.0)) && allOk;
	allOk = compare_vec3((block[2].s[0].c), vec3(-6.0, 2.0, -4.0)) && allOk;
	allOk = compare_uvec2((block[2].s[1].a), uvec2(9u, 2u)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[0], mat2x4(3.0, 7.0, -2.0, -6.0, -4.0, 7.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[1], mat2x4(-3.0, -3.0, -6.0, 6.0, 5.0, -5.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[2], mat2x4(-3.0, -3.0, -1.0, 8.0, -7.0, 9.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[3], mat2x4(3.0, 6.0, -7.0, -2.0, 5.0, 9.0, -3.0, -1.0)) && allOk;
	allOk = compare_vec3((block[2].s[1].c), vec3(9.0, 4.0, 5.0)) && allOk;
	allOk = compare_uvec2((block[2].s[2].a), uvec2(2u, 6u)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[0], mat2x4(6.0, -6.0, -9.0, -6.0, 9.0, 6.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[1], mat2x4(-3.0, 7.0, 7.0, -3.0, 7.0, 6.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[2], mat2x4(-5.0, 7.0, 1.0, 1.0, -8.0, -5.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[3], mat2x4(5.0, -7.0, -9.0, 0.0, -4.0, 3.0, -9.0, -2.0)) && allOk;
	allOk = compare_vec3((block[2].s[2].c), vec3(-8.0, -7.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].v = (7u);
	block[0].s[0].a = (uvec2(9u, 1u));
	block[0].s[0].b[0] = (mat2x4(-7.0, 7.0, 4.0, -9.0, -4.0, 2.0, -4.0, -6.0));
	block[0].s[0].b[1] = (mat2x4(-7.0, -6.0, -8.0, 3.0, 1.0, -8.0, 3.0, 1.0));
	block[0].s[0].b[2] = (mat2x4(8.0, -4.0, 1.0, -2.0, -2.0, 0.0, -3.0, -5.0));
	block[0].s[0].b[3] = (mat2x4(-6.0, 4.0, 4.0, 0.0, 6.0, -4.0, -1.0, -2.0));
	block[0].s[0].c = (vec3(7.0, -7.0, 1.0));
	block[0].s[1].a = (uvec2(3u, 3u));
	block[0].s[1].b[0] = (mat2x4(3.0, 0.0, -5.0, -5.0, 6.0, -7.0, 5.0, 1.0));
	block[0].s[1].b[1] = (mat2x4(-5.0, 1.0, -5.0, 6.0, -3.0, 0.0, 6.0, -2.0));
	block[0].s[1].b[2] = (mat2x4(-6.0, -5.0, -6.0, -1.0, 6.0, 8.0, -7.0, -9.0));
	block[0].s[1].b[3] = (mat2x4(0.0, 2.0, 1.0, 9.0, -3.0, 5.0, 3.0, -8.0));
	block[0].s[1].c = (vec3(-5.0, -3.0, -1.0));
	block[0].s[2].a = (uvec2(4u, 9u));
	block[0].s[2].b[0] = (mat2x4(3.0, 0.0, 7.0, 6.0, 3.0, 7.0, -4.0, -5.0));
	block[0].s[2].b[1] = (mat2x4(-9.0, -2.0, 1.0, 3.0, -3.0, -3.0, 1.0, -4.0));
	block[0].s[2].b[2] = (mat2x4(0.0, 5.0, -9.0, 1.0, -4.0, -7.0, 6.0, 7.0));
	block[0].s[2].b[3] = (mat2x4(0.0, -8.0, -2.0, 0.0, 5.0, -3.0, -1.0, -3.0));
	block[0].s[2].c = (vec3(3.0, 1.0, 1.0));
	block[0].s[3].a = (uvec2(8u, 5u));
	block[0].s[3].b[0] = (mat2x4(7.0, 1.0, -1.0, -4.0, -5.0, 0.0, 4.0, 0.0));
	block[0].s[3].b[1] = (mat2x4(3.0, -2.0, -5.0, -7.0, -1.0, 9.0, -8.0, -2.0));
	block[0].s[3].b[2] = (mat2x4(-8.0, -6.0, 7.0, 4.0, 4.0, 9.0, -3.0, 1.0));
	block[0].s[3].b[3] = (mat2x4(9.0, -9.0, -4.0, -9.0, -5.0, 1.0, 4.0, -6.0));
	block[0].s[3].c = (vec3(-8.0, -1.0, 9.0));
	block[1].v = (0u);
	block[1].s[0].a = (uvec2(6u, 3u));
	block[1].s[0].b[0] = (mat2x4(-9.0, 2.0, -6.0, -2.0, -8.0, 0.0, -1.0, -4.0));
	block[1].s[0].b[1] = (mat2x4(-9.0, 3.0, 7.0, -8.0, -9.0, -1.0, -3.0, 5.0));
	block[1].s[0].b[2] = (mat2x4(-1.0, -8.0, 7.0, -5.0, 4.0, -4.0, -1.0, -4.0));
	block[1].s[0].b[3] = (mat2x4(8.0, 6.0, 6.0, 1.0, -8.0, 3.0, -3.0, -1.0));
	block[1].s[0].c = (vec3(4.0, 3.0, -9.0));
	block[1].s[1].a = (uvec2(4u, 3u));
	block[1].s[1].b[0] = (mat2x4(-8.0, -9.0, 9.0, 0.0, -2.0, -2.0, 0.0, 4.0));
	block[1].s[1].b[1] = (mat2x4(-6.0, -1.0, -4.0, -3.0, -8.0, 5.0, -9.0, -6.0));
	block[1].s[1].b[2] = (mat2x4(5.0, 9.0, -2.0, -6.0, -8.0, 7.0, -1.0, 3.0));
	block[1].s[1].b[3] = (mat2x4(3.0, -3.0, -1.0, 9.0, -7.0, 4.0, 9.0, 4.0));
	block[1].s[1].c = (vec3(6.0, 3.0, -9.0));
	block[1].s[2].a = (uvec2(9u, 1u));
	block[1].s[2].b[0] = (mat2x4(-4.0, 8.0, 6.0, 5.0, -1.0, -1.0, 1.0, 0.0));
	block[1].s[2].b[1] = (mat2x4(0.0, 6.0, 6.0, 7.0, 5.0, 4.0, 1.0, -9.0));
	block[1].s[2].b[2] = (mat2x4(9.0, 3.0, -6.0, 3.0, -8.0, -3.0, 3.0, 4.0));
	block[1].s[2].b[3] = (mat2x4(9.0, 7.0, -7.0, -4.0, 0.0, 6.0, -2.0, 6.0));
	block[1].s[2].c = (vec3(4.0, 0.0, -6.0));
	block[1].s[3].a = (uvec2(7u, 2u));
	block[1].s[3].b[0] = (mat2x4(5.0, 7.0, -1.0, 9.0, 7.0, 3.0, 0.0, -3.0));
	block[1].s[3].b[1] = (mat2x4(0.0, 1.0, -8.0, -7.0, 3.0, -5.0, 9.0, 9.0));
	block[1].s[3].b[2] = (mat2x4(2.0, 7.0, 4.0, 6.0, 5.0, -4.0, -9.0, 1.0));
	block[1].s[3].b[3] = (mat2x4(-4.0, -1.0, 0.0, 9.0, -2.0, 6.0, 8.0, 5.0));
	block[1].s[3].c = (vec3(-3.0, -1.0, 7.0));
	block[2].v = (2u);
	block[2].s[0].a = (uvec2(9u, 2u));
	block[2].s[0].b[0] = (mat2x4(-3.0, 3.0, -6.0, 3.0, 8.0, -6.0, 9.0, 0.0));
	block[2].s[0].b[1] = (mat2x4(1.0, 1.0, 7.0, 2.0, 6.0, -9.0, 5.0, 3.0));
	block[2].s[0].b[2] = (mat2x4(-8.0, -6.0, 2.0, 5.0, 7.0, -8.0, 1.0, 4.0));
	block[2].s[0].b[3] = (mat2x4(-3.0, 8.0, 8.0, 0.0, -8.0, -9.0, -4.0, -7.0));
	block[2].s[0].c = (vec3(-7.0, 3.0, 6.0));
	block[2].s[1].a = (uvec2(1u, 7u));
	block[2].s[1].b[0] = (mat2x4(-5.0, -4.0, 0.0, -4.0, -1.0, 0.0, 4.0, -6.0));
	block[2].s[1].b[1] = (mat2x4(-3.0, 7.0, -5.0, 0.0, -8.0, -8.0, 1.0, 0.0));
	block[2].s[1].b[2] = (mat2x4(6.0, -5.0, 2.0, 3.0, -2.0, 4.0, -3.0, 2.0));
	block[2].s[1].b[3] = (mat2x4(1.0, 5.0, 8.0, 8.0, 8.0, 5.0, -2.0, -6.0));
	block[2].s[1].c = (vec3(8.0, 9.0, 3.0));
	block[2].s[2].a = (uvec2(0u, 0u));
	block[2].s[2].b[0] = (mat2x4(0.0, 2.0, 3.0, -8.0, 1.0, -7.0, 8.0, -6.0));
	block[2].s[2].b[1] = (mat2x4(-2.0, 8.0, -6.0, -6.0, -7.0, 3.0, 6.0, 1.0));
	block[2].s[2].b[2] = (mat2x4(0.0, 9.0, 8.0, 2.0, 4.0, 5.0, 5.0, -6.0));
	block[2].s[2].b[3] = (mat2x4(-5.0, -2.0, 1.0, 3.0, 7.0, -6.0, -4.0, -8.0));
	block[2].s[2].c = (vec3(-7.0, -5.0, -8.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

struct S
{
	highp ivec3 a;
	highp vec4 c;
};
layout(std430, buffer_reference) buffer Block
{
	lowp uint u;
	mediump vec4 v;
	S s[][2];
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((block[0].s[0][0].a), ivec3(4, -2, -7)) && allOk;
	allOk = compare_vec4((block[0].s[0][0].c), vec4(3.0, -7.0, -5.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[0].s[0][1].a), ivec3(3, 1, -4)) && allOk;
	allOk = compare_vec4((block[0].s[0][1].c), vec4(9.0, 8.0, 6.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1][0].a), ivec3(9, -8, 9)) && allOk;
	allOk = compare_vec4((block[0].s[1][0].c), vec4(-7.0, -4.0, -2.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1][1].a), ivec3(0, -4, -8)) && allOk;
	allOk = compare_vec4((block[0].s[1][1].c), vec4(7.0, 8.0, 9.0, -3.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2][0].a), ivec3(3, -2, -6)) && allOk;
	allOk = compare_vec4((block[0].s[2][0].c), vec4(0.0, 0.0, -6.0, 7.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2][1].a), ivec3(7, 8, 3)) && allOk;
	allOk = compare_vec4((block[0].s[2][1].c), vec4(5.0, -7.0, 2.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0][0].a), ivec3(0, 9, 5)) && allOk;
	allOk = compare_vec4((block[1].s[0][0].c), vec4(-3.0, -6.0, 6.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0][1].a), ivec3(-4, 6, -5)) && allOk;
	allOk = compare_vec4((block[1].s[0][1].c), vec4(8.0, -3.0, -8.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1][0].a), ivec3(-1, 8, 4)) && allOk;
	allOk = compare_vec4((block[1].s[1][0].c), vec4(9.0, -7.0, -8.0, -7.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1][1].a), ivec3(6, 9, -3)) && allOk;
	allOk = compare_vec4((block[1].s[1][1].c), vec4(-4.0, -2.0, 6.0, -7.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0][0].a), ivec3(9, 2, 5)) && allOk;
	allOk = compare_vec4((block[2].s[0][0].c), vec4(9.0, -1.0, -4.0, 3.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0][1].a), ivec3(9, 3, -6)) && allOk;
	allOk = compare_vec4((block[2].s[0][1].c), vec4(0.0, 6.0, -9.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].v = (vec4(-5.0, 3.0, 4.0, 8.0));
	block[0].s[0][0].a = (ivec3(-9, -3, -2));
	block[0].s[0][0].c = (vec4(0.0, -1.0, 6.0, 9.0));
	block[0].s[0][1].a = (ivec3(6, 1, -8));
	block[0].s[0][1].c = (vec4(5.0, 3.0, -9.0, -6.0));
	block[0].s[1][0].a = (ivec3(-7, 1, -3));
	block[0].s[1][0].c = (vec4(-7.0, -2.0, 1.0, -6.0));
	block[0].s[1][1].a = (ivec3(5, -6, -4));
	block[0].s[1][1].c = (vec4(-3.0, -3.0, -9.0, 6.0));
	block[0].s[2][0].a = (ivec3(-8, 9, 5));
	block[0].s[2][0].c = (vec4(-5.0, 3.0, 8.0, -6.0));
	block[0].s[2][1].a = (ivec3(9, 4, 0));
	block[0].s[2][1].c = (vec4(-5.0, -7.0, 6.0, 3.0));
	block[1].v = (vec4(6.0, 7.0, 8.0, 5.0));
	block[1].s[0][0].a = (ivec3(1, 2, 4));
	block[1].s[0][0].c = (vec4(-2.0, 9.0, 0.0, -6.0));
	block[1].s[0][1].a = (ivec3(9, 7, -2));
	block[1].s[0][1].c = (vec4(8.0, 1.0, -5.0, -4.0));
	block[1].s[1][0].a = (ivec3(-6, -7, -6));
	block[1].s[1][0].c = (vec4(-7.0, 7.0, -5.0, 5.0));
	block[1].s[1][1].a = (ivec3(-9, -2, 6));
	block[1].s[1][1].c = (vec4(0.0, 2.0, -1.0, 1.0));
	block[2].v = (vec4(2.0, 4.0, 5.0, 8.0));
	block[2].s[0][0].a = (ivec3(6, 7, 9));
	block[2].s[0][0].c = (vec4(-1.0, 5.0, 5.0, -6.0));
	block[2].s[0][1].a = (ivec3(-7, -4, 2));
	block[2].s[0][1].c = (vec4(-1.0, 5.0, -3.0, 3.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, row_major, buffer_reference) buffer Block
{
	highp mat4x3 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(block[0].var, mat4x3(-2.0, 8.0, 0.0, 9.0, -7.0, -7.0, 8.0, 2.0, 7.0, 3.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block[1].var, mat4x3(9.0, -7.0, -6.0, -8.0, -6.0, 3.0, -8.0, -8.0, -4.0, 5.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block[2].var, mat4x3(-6.0, 1.0, 9.0, 4.0, -4.0, -7.0, 9.0, -3.0, -7.0, 9.0, 2.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec3(1.0, 3.0, -7.0));
	block[0].var[1] = (vec3(-7.0, 2.0, 3.0));
	block[0].var[2] = (vec3(1.0, -2.0, -1.0));
	block[0].var[3] = (vec3(-5.0, -1.0, 9.0));
	block[1].var[0] = (vec3(8.0, -4.0, 3.0));
	block[1].var[1] = (vec3(4.0, 9.0, -6.0));
	block[1].var[2] = (vec3(7.0, 6.0, -5.0));
	block[1].var[3] = (vec3(2.0, 6.0, 3.0));
	block[2].var[0] = (vec3(2.0, 7.0, -1.0));
	block[2].var[1] = (vec3(-3.0, -3.0, -7.0));
	block[2].var[2] = (vec3(-5.0, 3.0, 4.0));
	block[2].var[3] = (vec3(-4.0, -2.0, 8.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, column_major, buffer_reference) buffer Block
{
	highp mat2x3 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(block[0].var, mat2x3(-2.0, 0.0, -9.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block[1].var, mat2x3(-3.0, -1.0, -3.0, -1.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block[2].var, mat2x3(9.0, 9.0, 0.0, 0.0, -2.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec3(0.0, 5.0, 5.0));
	block[0].var[1] = (vec3(0.0, -7.0, 8.0));
	block[1].var[0] = (vec3(-7.0, -4.0, 6.0));
	block[1].var[1] = (vec3(1.0, 3.0, 2.0));
	block[2].var[0] = (vec3(-6.0, 5.0, 2.0));
	block[2].var[1] = (vec3(1.0, 8.0, -8.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, row_major, buffer_reference) buffer Block
{
	float padding;
	highp mat3 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), -8.0) && allOk;
	allOk = compare_mat3(block[0].var, mat3(-7.0, 8.0, 7.0, 4.0, 4.0, -1.0, -9.0, -7.0, 5.0)) && allOk;
	allOk = compare_float((block[1].padding), -4.0) && allOk;
	allOk = compare_mat3(block[1].var, mat3(7.0, -3.0, -7.0, -4.0, 7.0, 1.0, -3.0, 8.0, -9.0)) && allOk;
	allOk = compare_float((block[2].padding), 8.0) && allOk;
	allOk = compare_mat3(block[2].var, mat3(6.0, 8.0, -6.0, -1.0, 8.0, -2.0, 3.0, -1.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (5.0);
	block[0].var = (mat3(8.0, 3.0, -2.0, 2.0, -8.0, -5.0, 2.0, 8.0, -6.0));
	block[1].padding = (-5.0);
	block[1].var = (mat3(-2.0, -5.0, 5.0, -1.0, 7.0, 3.0, -5.0, 8.0, -2.0));
	block[2].padding = (5.0);
	block[2].var = (mat3(9.0, -7.0, -5.0, 3.0, 5.0, -2.0, 1.0, -6.0, -1.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, column_major, buffer_reference) buffer Block
{
	float padding;
	highp mat3 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), -1.0) && allOk;
	allOk = compare_mat3(block[0].var, mat3(2.0, -7.0, -6.0, 0.0, 4.0, -7.0, 4.0, 2.0, -9.0)) && allOk;
	allOk = compare_float((block[1].padding), -8.0) && allOk;
	allOk = compare_mat3(block[1].var, mat3(6.0, 6.0, 6.0, -3.0, -6.0, 7.0, 4.0, 3.0, 8.0)) && allOk;
	allOk = compare_float((block[2].padding), 0.0) && allOk;
	allOk = compare_mat3(block[2].var, mat3(-4.0, -4.0, 3.0, 9.0, 9.0, 0.0, -4.0, -2.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-1.0);
	block[0].var[0] = (vec3(1.0, 4.0, 6.0));
	block[0].var[1] = (vec3(-5.0, -5.0, 9.0));
	block[0].var[2] = (vec3(-6.0, 5.0, 7.0));
	block[1].padding = (7.0);
	block[1].var[0] = (vec3(-2.0, -4.0, 1.0));
	block[1].var[1] = (vec3(-5.0, 8.0, -1.0));
	block[1].var[2] = (vec3(-8.0, -6.0, -4.0));
	block[2].padding = (5.0);
	block[2].var[0] = (vec3(3.0, 9.0, -8.0));
	block[2].var[1] = (vec3(-4.0, 8.0, 0.0));
	block[2].var[2] = (vec3(5.0, -1.0, 2.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, column_major, buffer_reference) buffer Block
{
	float padding;
	highp mat2x4 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), -2.0) && allOk;
	allOk = compare_float(block[0].var[0][0], 4.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 3.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 6.0) && allOk;
	allOk = compare_float(block[0].var[0][3], 3.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -7.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 6.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 9.0) && allOk;
	allOk = compare_float(block[0].var[1][3], 6.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(4.0, 3.0, 6.0, 3.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(-7.0, 6.0, 9.0, 6.0)) && allOk;
	allOk = compare_float((block[1].padding), 4.0) && allOk;
	allOk = compare_float(block[1].var[0][0], 0.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 9.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -2.0) && allOk;
	allOk = compare_float(block[1].var[0][3], 9.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -9.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -6.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 1.0) && allOk;
	allOk = compare_float(block[1].var[1][3], -7.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(0.0, 9.0, -2.0, 9.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(-9.0, -6.0, 1.0, -7.0)) && allOk;
	allOk = compare_float((block[2].padding), 0.0) && allOk;
	allOk = compare_float(block[2].var[0][0], 6.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -6.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 9.0) && allOk;
	allOk = compare_float(block[2].var[0][3], 0.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 4.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 9.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -9.0) && allOk;
	allOk = compare_float(block[2].var[1][3], 3.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(6.0, -6.0, 9.0, 0.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(4.0, 9.0, -9.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-5.0);
	block[0].var = (mat2x4(-7.0, -7.0, 0.0, -1.0, -9.0, 5.0, -5.0, 0.0));
	block[1].padding = (1.0);
	block[1].var = (mat2x4(8.0, 9.0, 2.0, 4.0, 5.0, 5.0, 3.0, 6.0));
	block[2].padding = (2.0);
	block[2].var = (mat2x4(7.0, -1.0, -8.0, 7.0, -7.0, -8.0, -9.0, 5.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, buffer_reference) buffer BlockA
{
	highp float a;
	lowp uvec3 b;
	mediump mat2 c;
};
layout(std140, buffer_reference) buffer BlockB
{
	mediump mat3 a;
	lowp ivec2 b;
	highp vec4 c;
	bool d;
};
layout (push_constant, std430) uniform PC {
    BlockA blockA;
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockA.a), 6.0) && allOk;
	allOk = compare_mat2(blockA.c, mat2(-3.0, 2.0, -9.0, 4.0)) && allOk;
	allOk = compare_ivec2((blockB.b), ivec2(2, 4)) && allOk;
	allOk = compare_bool((blockB.d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (2.0);
	blockB.a = (mat3(-1.0, -9.0, 2.0, -5.0, 6.0, -6.0, -5.0, -4.0, -9.0));
	blockB.d = (true);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

struct S
{
	lowp mat3 a;
	mediump ivec2 b[4];
	highp vec4 c;
};
struct T
{
	mediump uint a;
	S b;
	bvec4 c;
};
layout(scalar, buffer_reference) buffer BlockA
{
	highp float a;
	S b;
	lowp uvec3 c;
};
layout(scalar, buffer_reference) buffer BlockB
{
	mediump mat2 a;
	T b;
	bvec4 c;
	bool d;
};
layout (push_constant, std430) uniform PC {
    BlockA blockA[3];
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockA[0].a), -7.0) && allOk;
	allOk = compare_float((blockA[1].a), -2.0) && allOk;
	allOk = compare_float((blockA[2].a), 2.0) && allOk;
	allOk = compare_uint((blockB[0].b.a), 0u) && allOk;
	allOk = compare_mat3(blockB[0].b.b.a, mat3(2.0, 7.0, -6.0, -8.0, 5.0, 3.0, -3.0, 8.0, 4.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[0]), ivec2(-3, 9)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[1]), ivec2(-7, -4)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[2]), ivec2(7, -4)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[3]), ivec2(-1, 9)) && allOk;
	allOk = compare_vec4((blockB[0].b.b.c), vec4(-8.0, -5.0, 9.0, 3.0)) && allOk;
	allOk = compare_bvec4((blockB[0].b.c), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bool((blockB[0].d), true) && allOk;
	allOk = compare_uint((blockB[1].b.a), 0u) && allOk;
	allOk = compare_mat3(blockB[1].b.b.a, mat3(-2.0, 6.0, -9.0, 1.0, -1.0, 2.0, 3.0, 8.0, 9.0)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[0]), ivec2(6, 7)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[1]), ivec2(5, -6)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[2]), ivec2(-3, -6)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[3]), ivec2(9, -4)) && allOk;
	allOk = compare_vec4((blockB[1].b.b.c), vec4(5.0, -6.0, 0.0, -9.0)) && allOk;
	allOk = compare_bvec4((blockB[1].b.c), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bool((blockB[1].d), false) && allOk;
	allOk = compare_uint((blockB[2].b.a), 2u) && allOk;
	allOk = compare_mat3(blockB[2].b.b.a, mat3(6.0, -6.0, -9.0, -4.0, -1.0, 1.0, 1.0, -2.0, -1.0)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[0]), ivec2(5, -9)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[1]), ivec2(0, -9)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[2]), ivec2(1, -7)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[3]), ivec2(7, 2)) && allOk;
	allOk = compare_vec4((blockB[2].b.b.c), vec4(2.0, -2.0, 8.0, 5.0)) && allOk;
	allOk = compare_bvec4((blockB[2].b.c), bvec4(false, false, false, true)) && allOk;
	allOk = compare_bool((blockB[2].d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (-5.0);
	blockA[0].b.a = (mat3(2.0, -1.0, -4.0, 1.0, 2.0, -2.0, 8.0, 7.0, 2.0));
	blockA[0].b.b[0] = (ivec2(-4, 3));
	blockA[0].b.b[1] = (ivec2(-4, 6));
	blockA[0].b.b[2] = (ivec2(7, -1));
	blockA[0].b.b[3] = (ivec2(-6, -4));
	blockA[0].b.c = (vec4(-8.0, -2.0, 7.0, -4.0));
	blockA[1].a = (-5.0);
	blockA[1].b.a = (mat3(-2.0, -9.0, -6.0, 4.0, 2.0, 2.0, -6.0, -5.0, 3.0));
	blockA[1].b.b[0] = (ivec2(9, 8));
	blockA[1].b.b[1] = (ivec2(-6, -2));
	blockA[1].b.b[2] = (ivec2(-5, 2));
	blockA[1].b.b[3] = (ivec2(8, 8));
	blockA[1].b.c = (vec4(-8.0, -2.0, 7.0, -9.0));
	blockA[2].a = (1.0);
	blockA[2].b.a = (mat3(7.0, 7.0, -2.0, -3.0, -4.0, -7.0, -7.0, -1.0, 5.0));
	blockA[2].b.b[0] = (ivec2(-4, -9));
	blockA[2].b.b[1] = (ivec2(-7, -6));
	blockA[2].b.b[2] = (ivec2(-3, 8));
	blockA[2].b.b[3] = (ivec2(-5, 0));
	blockA[2].b.c = (vec4(5.0, 4.0, -2.0, -1.0));
	blockB[0].a = (mat2(-7.0, 3.0, -4.0, -3.0));
	blockB[0].b.a = (8u);
	blockB[0].b.b.a = (mat3(4.0, 6.0, 8.0, -5.0, -9.0, -7.0, -1.0, -4.0, 3.0));
	blockB[0].b.b.b[0] = (ivec2(-1, -1));
	blockB[0].b.b.b[1] = (ivec2(3, -7));
	blockB[0].b.b.b[2] = (ivec2(-6, -3));
	blockB[0].b.b.b[3] = (ivec2(2, 3));
	blockB[0].b.b.c = (vec4(7.0, 8.0, -3.0, 6.0));
	blockB[0].b.c = (bvec4(false, false, false, false));
	blockB[0].d = (false);
	blockB[1].a = (mat2(-7.0, -9.0, -6.0, 9.0));
	blockB[1].b.a = (0u);
	blockB[1].b.b.a = (mat3(4.0, 8.0, -9.0, -7.0, -3.0, -2.0, -7.0, -8.0, 0.0));
	blockB[1].b.b.b[0] = (ivec2(4, -5));
	blockB[1].b.b.b[1] = (ivec2(-9, -2));
	blockB[1].b.b.b[2] = (ivec2(-8, -5));
	blockB[1].b.b.b[3] = (ivec2(-9, -8));
	blockB[1].b.b.c = (vec4(1.0, -8.0, -9.0, 5.0));
	blockB[1].b.c = (bvec4(false, false, false, false));
	blockB[1].d = (false);
	blockB[2].a = (mat2(8.0, -4.0, -4.0, 3.0));
	blockB[2].b.a = (1u);
	blockB[2].b.b.a = (mat3(6.0, -9.0, 2.0, 7.0, -8.0, 5.0, 7.0, -1.0, -5.0));
	blockB[2].b.b.b[0] = (ivec2(-4, -5));
	blockB[2].b.b.b[1] = (ivec2(7, -2));
	blockB[2].b.b.b[2] = (ivec2(8, -7));
	blockB[2].b.b.b[3] = (ivec2(5, 6));
	blockB[2].b.b.c = (vec4(-4.0, 0.0, 5.0, -1.0));
	blockB[2].b.c = (bvec4(false, false, true, false));
	blockB[2].d = (false);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, row_major, buffer_reference) buffer BlockB
{
	highp ivec2 a;
	bvec2 b;
	highp mat4 c[];
};
layout(std430, buffer_reference) buffer BlockC
{
	mediump mat4 d[6];
	lowp vec4 e;
	highp ivec2 f[];
};
layout(std430, buffer_reference) buffer BlockD
{
	lowp vec2 g;
	highp mat3 h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a), ivec2(2, -8)) && allOk;
	allOk = compare_bvec2((blockB.b), bvec2(true, true)) && allOk;
	allOk = compare_mat4(blockC.d[0], mat4(6.0, 7.0, 5.0, 8.0, -9.0, -5.0, -1.0, -8.0, 9.0, 7.0, -8.0, 5.0, -1.0, 1.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4(blockC.d[1], mat4(-7.0, 7.0, 6.0, 7.0, 2.0, 9.0, 1.0, 5.0, 3.0, -6.0, -5.0, 6.0, 9.0, -5.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4(blockC.d[2], mat4(-3.0, -1.0, -9.0, 5.0, -2.0, -1.0, -4.0, 3.0, 2.0, -2.0, 8.0, 6.0, -2.0, 2.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat4(blockC.d[3], mat4(5.0, 9.0, -1.0, 7.0, -5.0, 3.0, -9.0, -4.0, -9.0, -2.0, 6.0, 3.0, -2.0, 1.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat4(blockC.d[4], mat4(4.0, 9.0, 5.0, -7.0, 7.0, 0.0, 0.0, 0.0, -5.0, 3.0, -8.0, 6.0, -6.0, 9.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat4(blockC.d[5], mat4(2.0, 4.0, 4.0, 1.0, -4.0, 4.0, 5.0, 6.0, -5.0, 7.0, 6.0, 9.0, 9.0, 8.0, 4.0, -3.0)) && allOk;
	allOk = compare_vec4((blockC.e), vec4(-5.0, -5.0, 5.0, -1.0)) && allOk;
	allOk = compare_ivec2((blockC.f[0]), ivec2(-9, -7)) && allOk;
	allOk = compare_ivec2((blockC.f[1]), ivec2(-9, -9)) && allOk;
	allOk = compare_ivec2((blockC.f[2]), ivec2(2, -6)) && allOk;
	allOk = compare_ivec2((blockC.f[3]), ivec2(0, 6)) && allOk;
	allOk = compare_ivec2((blockC.f[4]), ivec2(-1, 4)) && allOk;
	allOk = compare_ivec2((blockC.f[5]), ivec2(2, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c[0] = (mat4(0.0, 8.0, 5.0, 7.0, 9.0, 6.0, -2.0, 0.0, 5.0, 7.0, 7.0, 9.0, 4.0, -5.0, 4.0, -4.0));
	blockB.c[1] = (mat4(-5.0, -6.0, -6.0, -6.0, 4.0, -2.0, -4.0, 8.0, 9.0, -4.0, 6.0, -6.0, -7.0, 8.0, -3.0, -7.0));
	blockC.d[0] = (mat4(-1.0, 4.0, -7.0, 2.0, -1.0, 4.0, -6.0, 5.0, -5.0, -1.0, -2.0, -3.0, -7.0, 8.0, -6.0, 7.0));
	blockC.d[1] = (mat4(9.0, 8.0, -3.0, -4.0, 4.0, 9.0, 0.0, 1.0, 2.0, -3.0, -9.0, -9.0, 0.0, -6.0, -8.0, 4.0));
	blockC.d[2] = (mat4(-1.0, -8.0, -9.0, 0.0, 0.0, 9.0, -9.0, 4.0, 7.0, 6.0, 6.0, -5.0, -4.0, 3.0, -5.0, -2.0));
	blockC.d[3] = (mat4(0.0, -5.0, 2.0, 9.0, -4.0, 4.0, -2.0, -5.0, 4.0, -1.0, 3.0, 8.0, -9.0, -7.0, -2.0, -2.0));
	blockC.d[4] = (mat4(-1.0, -6.0, 8.0, -5.0, -3.0, 5.0, 9.0, -5.0, -8.0, -9.0, 9.0, 5.0, 1.0, -7.0, 3.0, -7.0));
	blockC.d[5] = (mat4(-4.0, -6.0, 5.0, 3.0, -1.0, 0.0, 4.0, 4.0, -4.0, -3.0, 8.0, 7.0, -6.0, 1.0, 1.0, 6.0));
	blockC.e = (vec4(2.0, 2.0, -3.0, -5.0));
	blockC.f[0] = (ivec2(3, 0));
	blockC.f[1] = (ivec2(-7, 6));
	blockC.f[2] = (ivec2(3, 2));
	blockC.f[3] = (ivec2(-2, 8));
	blockC.f[4] = (ivec2(-5, -9));
	blockC.f[5] = (ivec2(-5, 2));
	blockD.g = (vec2(4.0, 3.0));
	blockD.h = (mat3(-1.0, 4.0, -5.0, -4.0, 3.0, -9.0, -5.0, 2.0, -3.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, row_major, buffer_reference) buffer BlockB
{
	lowp uvec4 a[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	highp mat4 b;
	mediump int c;
	lowp mat4x2 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a[0]), uvec4(0u, 4u, 2u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (uvec4(4u, 1u, 0u, 4u));
	blockC.b = (mat4(-4.0, -4.0, 0.0, -4.0, -1.0, 3.0, -7.0, -7.0, 9.0, -7.0, -9.0, 2.0, -4.0, -4.0, -8.0, -5.0));
	blockC.c = (-9);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(buffer_reference) buffer BlockB
{
	layout(offset = 0) mediump vec4 a;
	layout(offset = 16) lowp uvec4 b;
	layout(offset = 32) mediump vec3 c;
	layout(offset = 48) bvec3 d[1];
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) highp ivec2 e;
	layout(offset = 16) mediump ivec3 f;
	layout(offset = 32) mediump uvec4 g;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.b), uvec4(2u, 5u, 6u, 4u)) && allOk;
	allOk = compare_vec3((blockB.c), vec3(-5.0, -1.0, 2.0)) && allOk;
	allOk = compare_bvec3((blockB.d[0]), bvec3(true, true, false)) && allOk;
	allOk = compare_ivec2((blockC.e), ivec2(-6, -8)) && allOk;
	allOk = compare_ivec3((blockC.f), ivec3(6, -4, 2)) && allOk;
	allOk = compare_uvec4((blockC.g), uvec4(2u, 0u, 0u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec4(0.0, 9.0, 5.0, -7.0));
	blockC.f = (ivec3(-4, 6, 5));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(buffer_reference) buffer BlockB
{
	layout(offset = 0) highp ivec3 a;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) bool b;
	layout(offset = 16) lowp ivec4 c;
	layout(offset = 32) highp uint d;
	layout(offset = 36) bvec3 e;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) mediump uvec4 f;
	layout(offset = 16) lowp vec4 g;
	layout(offset = 32) highp uint h;
	layout(offset = 36) lowp ivec3 i;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a), ivec3(2, 8, 9)) && allOk;
	allOk = compare_ivec4((blockC.c), ivec4(-8, 1, 7, -1)) && allOk;
	allOk = compare_uint((blockC.d), 3u) && allOk;
	allOk = compare_bvec3((blockC.e), bvec3(false, true, true)) && allOk;
	allOk = compare_uvec4((blockD.f), uvec4(0u, 0u, 4u, 4u)) && allOk;
	allOk = compare_vec4((blockD.g), vec4(-4.0, 0.0, 7.0, -2.0)) && allOk;
	allOk = compare_uint((blockD.h), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec3(-3, 9, -3));
	blockC.b = (true);
	blockC.c = (ivec4(-2, -9, 5, 6));
	blockD.f = (uvec4(4u, 4u, 4u, 1u));
	blockD.g = (vec4(9.0, -5.0, -9.0, -9.0));
	blockD.h = (6u);
	blockD.i = (ivec3(5, 8, -9));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(buffer_reference) buffer BlockB
{
	layout(offset = 0) bool a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

struct sA
{
	mediump vec4 mA[2];
};
layout(scalar, buffer_reference) buffer BlockB
{
	highp mat3 a;
	sA b[3];
	highp mat3x4 c;
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	highp ivec4 d[2];
	mediump mat3x2 e;
	lowp mat3 f;
	lowp mat2 g;
	mediump mat4x3 h[6];
};
layout(scalar, buffer_reference) buffer BlockD
{
	bvec2 i;
	highp mat3 j;
	highp mat2 k;
	lowp int l[];
};
layout(scalar, row_major, buffer_reference) buffer BlockE
{
	highp mat3x4 m[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
    BlockD blockD;
    BlockE blockE[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB[0].b[0].mA[0]), vec4(-7.0, -2.0, -8.0, 1.0)) && allOk;
	allOk = compare_vec4((blockB[0].b[0].mA[1]), vec4(-5.0, 6.0, -6.0, 0.0)) && allOk;
	allOk = compare_vec4((blockB[0].b[1].mA[0]), vec4(8.0, 3.0, 4.0, -8.0)) && allOk;
	allOk = compare_vec4((blockB[0].b[1].mA[1]), vec4(8.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_vec4((blockB[0].b[2].mA[0]), vec4(-6.0, -4.0, 1.0, 0.0)) && allOk;
	allOk = compare_vec4((blockB[0].b[2].mA[1]), vec4(1.0, -3.0, 2.0, -6.0)) && allOk;
	allOk = compare_vec4((blockB[1].b[0].mA[0]), vec4(-7.0, 2.0, 5.0, -3.0)) && allOk;
	allOk = compare_vec4((blockB[1].b[0].mA[1]), vec4(8.0, 5.0, 1.0, 5.0)) && allOk;
	allOk = compare_vec4((blockB[1].b[1].mA[0]), vec4(-9.0, -7.0, 7.0, 2.0)) && allOk;
	allOk = compare_vec4((blockB[1].b[1].mA[1]), vec4(5.0, 1.0, 2.0, 9.0)) && allOk;
	allOk = compare_vec4((blockB[1].b[2].mA[0]), vec4(0.0, -6.0, -9.0, 5.0)) && allOk;
	allOk = compare_vec4((blockB[1].b[2].mA[1]), vec4(-3.0, -6.0, 2.0, -3.0)) && allOk;
	allOk = compare_ivec4((blockC.d[0]), ivec4(7, -7, -6, -6)) && allOk;
	allOk = compare_ivec4((blockC.d[1]), ivec4(-6, -6, -1, -7)) && allOk;
	allOk = compare_mat3x2(blockC.e, mat3x2(-9.0, -7.0, -7.0, 3.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat3(blockC.f, mat3(4.0, -5.0, 3.0, 1.0, 2.0, 0.0, 9.0, 4.0, -7.0)) && allOk;
	allOk = compare_bvec2((blockD.i), bvec2(false, true)) && allOk;
	allOk = compare_mat3(blockD.j, mat3(9.0, 0.0, 5.0, 5.0, -9.0, 6.0, -2.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat2(blockD.k, mat2(-1.0, -6.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat3x4(blockE[0].m[0], mat3x4(-2.0, -2.0, -2.0, 0.0, -7.0, -6.0, -7.0, 9.0, 2.0, -8.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat3x4(blockE[0].m[1], mat3x4(7.0, -8.0, -6.0, 4.0, -1.0, 5.0, -9.0, 2.0, -9.0, -8.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3x4(blockE[0].m[2], mat3x4(2.0, -8.0, 0.0, 0.0, 9.0, -8.0, 9.0, -1.0, -3.0, 4.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3x4(blockE[0].m[3], mat3x4(-4.0, 6.0, 1.0, 8.0, -9.0, -9.0, -4.0, 7.0, 8.0, 8.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat3x4(blockE[0].m[4], mat3x4(-8.0, 5.0, -8.0, 3.0, -5.0, -2.0, 1.0, -5.0, 5.0, -1.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(blockE[0].m[5], mat3x4(-9.0, 3.0, -9.0, 3.0, -1.0, -3.0, 9.0, 9.0, -6.0, 2.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat3x4(blockE[0].m[6], mat3x4(4.0, 9.0, -4.0, 2.0, 0.0, 4.0, 9.0, 4.0, 4.0, 5.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat3x4(blockE[0].m[7], mat3x4(6.0, -4.0, 9.0, 6.0, 4.0, 0.0, -7.0, 3.0, 5.0, 1.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3x4(blockE[1].m[0], mat3x4(0.0, 6.0, 0.0, -4.0, -7.0, -3.0, -4.0, -2.0, -3.0, 5.0, 3.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (mat3(-1.0, -2.0, 8.0, -9.0, -6.0, 0.0, 7.0, -6.0, 5.0));
	blockB[0].c = (mat3x4(6.0, -4.0, -8.0, 7.0, 4.0, -7.0, 4.0, 9.0, 3.0, -7.0, 0.0, -3.0));
	blockB[1].a = (mat3(7.0, 4.0, 9.0, 6.0, 9.0, -6.0, 2.0, 0.0, -5.0));
	blockB[1].c = (mat3x4(-8.0, -5.0, -3.0, -7.0, -1.0, 7.0, -9.0, -6.0, -1.0, 0.0, -1.0, 9.0));
	blockC.d[0] = (ivec4(-6, 0, -7, -5));
	blockC.d[1] = (ivec4(6, 2, -6, -5));
	blockC.e = (mat3x2(-5.0, -5.0, -1.0, -1.0, 2.0, 9.0));
	blockC.f = (mat3(-9.0, -2.0, -7.0, 4.0, 6.0, 9.0, -3.0, -3.0, 1.0));
	blockC.g = (mat2(4.0, 6.0, -9.0, 9.0));
	blockC.h[0] = (mat4x3(0.0, -7.0, 4.0, 8.0, 2.0, 0.0, -6.0, -9.0, -8.0, -3.0, 8.0, -9.0));
	blockC.h[1] = (mat4x3(8.0, 5.0, 7.0, -8.0, 2.0, -5.0, 0.0, -3.0, 6.0, 1.0, -6.0, 1.0));
	blockC.h[2] = (mat4x3(5.0, 7.0, -4.0, -1.0, 4.0, 7.0, -1.0, -4.0, 4.0, -9.0, 4.0, 8.0));
	blockC.h[3] = (mat4x3(-6.0, 2.0, 7.0, 3.0, -1.0, -2.0, 1.0, 5.0, -3.0, 6.0, -3.0, -4.0));
	blockC.h[4] = (mat4x3(0.0, -6.0, -1.0, 9.0, 2.0, -6.0, 9.0, 4.0, -8.0, -8.0, 3.0, 7.0));
	blockC.h[5] = (mat4x3(1.0, -9.0, -8.0, -1.0, -6.0, 4.0, -9.0, -1.0, -1.0, 7.0, 1.0, 6.0));
	blockD.k = (mat2(-1.0, -4.0, 4.0, 9.0));
	blockD.l[0] = (1);
	blockD.l[1] = (6);
	blockD.l[2] = (6);
	blockD.l[3] = (5);
	blockD.l[4] = (4);
	blockD.l[5] = (-6);
	blockD.l[6] = (8);
	blockE[0].m[0] = (mat3x4(0.0, 5.0, 6.0, -7.0, -2.0, 4.0, 6.0, 5.0, 3.0, 0.0, 2.0, 7.0));
	blockE[0].m[1] = (mat3x4(-9.0, 2.0, 4.0, -7.0, -5.0, -9.0, 5.0, -4.0, 0.0, -9.0, -3.0, -8.0));
	blockE[0].m[2] = (mat3x4(-8.0, -4.0, 6.0, 4.0, 7.0, 4.0, -7.0, 3.0, -4.0, -5.0, 1.0, -7.0));
	blockE[0].m[3] = (mat3x4(-7.0, 9.0, -3.0, -2.0, 9.0, -2.0, -8.0, -3.0, -4.0, 7.0, -6.0, 2.0));
	blockE[0].m[4] = (mat3x4(-2.0, 5.0, -9.0, -4.0, -1.0, -5.0, -3.0, -4.0, 0.0, 5.0, 5.0, -7.0));
	blockE[0].m[5] = (mat3x4(9.0, 1.0, 6.0, -6.0, 6.0, 1.0, -4.0, -3.0, -8.0, 9.0, 2.0, 0.0));
	blockE[0].m[6] = (mat3x4(8.0, -9.0, -2.0, -2.0, -3.0, 2.0, -7.0, -2.0, 0.0, 0.0, -6.0, -8.0));
	blockE[0].m[7] = (mat3x4(-6.0, -8.0, -9.0, -6.0, -2.0, -9.0, 3.0, 4.0, 3.0, -9.0, -5.0, -6.0));
	blockE[1].m[0] = (mat3x4(-1.0, -2.0, 3.0, -6.0, 8.0, 8.0, -8.0, -6.0, 6.0, -2.0, 9.0, 5.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, buffer_reference) buffer BlockB
{
	mediump mat2 a;
	bvec4 b;
	lowp mat4x2 c;
	lowp uvec4 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (mat2(9.0, 7.0, 5.0, -2.0));
	blockB[nonuniformEXT(1)].a = (mat2(1.0, -6.0, 2.0, -1.0));
	blockB[nonuniformEXT(2)].a = (mat2(-9.0, -1.0, -1.0, 4.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, column_major, buffer_reference) buffer BlockB
{
	u16vec4 a;
	i16vec3 b;
	lowp ivec2 c[1];
	highp mat3x4 d;
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	lowp uvec3 e;
	mediump mat2 f[1];
	lowp mat4 g;
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	bvec3 h;
	int16_t i;
	lowp ivec4 j;
};
layout(std140, row_major, buffer_reference) buffer BlockE
{
	mediump mat3 k;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(blockB.a), uvec4(8u, 2u, 7u, 1u)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB.b), ivec3(-4, -4, -6)) && allOk;
	allOk = compare_ivec2((blockB.c[0]), ivec2(-2, 8)) && allOk;
	allOk = compare_uvec3((blockC.e), uvec3(9u, 8u, 0u)) && allOk;
	allOk = compare_mat2(blockC.f[0], mat2(-7.0, 6.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat4(blockC.g, mat4(-1.0, 6.0, 1.0, 1.0, 7.0, 2.0, -6.0, 8.0, -2.0, 4.0, 0.0, -1.0, 1.0, -8.0, -9.0, 5.0)) && allOk;
	allOk = compare_bvec3((blockD.h), bvec3(false, false, false)) && allOk;
	allOk = compare_int16_t(int(blockD.i), 1) && allOk;
	allOk = compare_ivec4((blockD.j), ivec4(-6, 1, 0, -5)) && allOk;
	allOk = compare_mat3(blockE.k, mat3(-7.0, -4.0, 3.0, -9.0, -1.0, 8.0, 6.0, 5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec4(uvec4(9u, 2u, 1u, 0u));
	blockB.b = i16vec3(ivec3(1, -7, -4));
	blockB.c[0] = (ivec2(-4, -6));
	blockB.d = (mat3x4(-5.0, -2.0, 4.0, -2.0, 5.0, -9.0, -3.0, -1.0, -9.0, 1.0, 1.0, 7.0));
	blockC.e = (uvec3(6u, 7u, 9u));
	blockC.f[0] = (mat2(-1.0, -6.0, 5.0, 6.0));
	blockD.h = (bvec3(true, false, false));
	blockE.k = (mat3(-3.0, -9.0, 3.0, 0.0, -1.0, -6.0, 8.0, 8.0, 7.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, column_major, buffer_reference) buffer BlockB
{
	highp ivec4 a;
	u16vec2 b;
	f16vec4 c;
	f16vec4 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(blockB.c), vec4(5.0, -7.0, -9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec4(-5, 9, 5, 5));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, buffer_reference) buffer BlockB
{
	lowp mat3x2 a;
	mediump uvec3 b;
	lowp vec3 c;
	highp mat4x3 d;
	mediump vec3 e[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	bvec2 f;
	highp mat3x4 g;
	mediump mat4 h[8];
	lowp int i[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.a, mat3x2(2.0, -8.0, -4.0, 7.0, 4.0, 0.0)) && allOk;
	allOk = compare_uvec3((blockB.b), uvec3(6u, 0u, 4u)) && allOk;
	allOk = compare_mat4x3(blockB.d, mat4x3(-6.0, 1.0, 8.0, 1.0, -7.0, 7.0, 5.0, 8.0, 5.0, -9.0, -8.0, 6.0)) && allOk;
	allOk = compare_vec3((blockB.e[0]), vec3(2.0, 3.0, -7.0)) && allOk;
	allOk = compare_vec3((blockB.e[1]), vec3(-8.0, 9.0, -9.0)) && allOk;
	allOk = compare_vec3((blockB.e[2]), vec3(1.0, 1.0, 3.0)) && allOk;
	allOk = compare_vec3((blockB.e[3]), vec3(6.0, -3.0, 8.0)) && allOk;
	allOk = compare_vec3((blockB.e[4]), vec3(6.0, -4.0, 6.0)) && allOk;
	allOk = compare_vec3((blockB.e[5]), vec3(7.0, 5.0, 8.0)) && allOk;
	allOk = compare_vec3((blockB.e[6]), vec3(-9.0, -5.0, -1.0)) && allOk;
	allOk = compare_bvec2((blockC.f), bvec2(true, false)) && allOk;
	allOk = compare_mat3x4(blockC.g, mat3x4(-8.0, 1.0, -7.0, 7.0, 5.0, 7.0, 7.0, 2.0, -1.0, -7.0, 6.0, 9.0)) && allOk;
	allOk = compare_int((blockC.i[0]), 2) && allOk;
	allOk = compare_int((blockC.i[1]), 2) && allOk;
	allOk = compare_int((blockC.i[2]), 1) && allOk;
	allOk = compare_int((blockC.i[3]), 1) && allOk;
	allOk = compare_int((blockC.i[4]), -9) && allOk;
	allOk = compare_int((blockC.i[5]), 3) && allOk;
	allOk = compare_int((blockC.i[6]), 9) && allOk;
	allOk = compare_int((blockC.i[7]), 9) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (uvec3(3u, 8u, 3u));
	blockB.c = (vec3(8.0, 6.0, 7.0));
	blockB.e[0] = (vec3(-7.0, -6.0, -2.0));
	blockB.e[1] = (vec3(-4.0, 8.0, -6.0));
	blockB.e[2] = (vec3(-4.0, 6.0, -3.0));
	blockB.e[3] = (vec3(-6.0, 8.0, -6.0));
	blockB.e[4] = (vec3(-7.0, -1.0, 4.0));
	blockB.e[5] = (vec3(-7.0, 2.0, -1.0));
	blockB.e[6] = (vec3(4.0, -6.0, 5.0));
	blockC.f = (bvec2(true, false));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, buffer_reference) buffer BlockB
{
	highp ivec2 a;
	mediump mat3x4 b;
	highp mat3 c[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	i16vec2 d;
	lowp vec4 e[];
};
layout(std140, buffer_reference) buffer BlockD
{
	mediump mat2x3 f;
	highp mat4x3 g;
	highp mat2x3 h[4];
	mediump mat2 i;
	mediump uvec2 j[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a), ivec2(-2, 4)) && allOk;
	allOk = compare_mat3(blockB.c[0], mat3(-2.0, 5.0, -6.0, -3.0, 0.0, -6.0, 1.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3(blockB.c[1], mat3(8.0, 8.0, 0.0, 1.0, 4.0, -9.0, 9.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat3(blockB.c[2], mat3(-8.0, 7.0, 5.0, -7.0, -5.0, -4.0, 3.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat3(blockB.c[3], mat3(-3.0, -6.0, 6.0, 6.0, 0.0, 1.0, -9.0, 2.0, -2.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockC.d), ivec2(-3, 0)) && allOk;
	allOk = compare_vec4((blockC.e[0]), vec4(-4.0, 4.0, 0.0, 9.0)) && allOk;
	allOk = compare_vec4((blockC.e[1]), vec4(-5.0, 7.0, -4.0, 5.0)) && allOk;
	allOk = compare_vec4((blockC.e[2]), vec4(7.0, -8.0, -1.0, 8.0)) && allOk;
	allOk = compare_vec4((blockC.e[3]), vec4(8.0, 7.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat2x3(blockD.f, mat2x3(2.0, -6.0, -1.0, 5.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat2x3(blockD.h[0], mat2x3(6.0, 7.0, 5.0, 7.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2x3(blockD.h[1], mat2x3(-4.0, -8.0, 8.0, 4.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat2x3(blockD.h[2], mat2x3(-5.0, -1.0, 6.0, -1.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat2x3(blockD.h[3], mat2x3(-9.0, 4.0, -7.0, -3.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat2(blockD.i, mat2(1.0, -9.0, -8.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec2(-7, 3));
	blockC.d = i16vec2(ivec2(3, 6));
	blockD.f = (mat2x3(-8.0, -6.0, 7.0, 6.0, -5.0, 7.0));
	blockD.h[0] = (mat2x3(7.0, -2.0, 2.0, 2.0, 4.0, -9.0));
	blockD.h[1] = (mat2x3(9.0, -2.0, -4.0, -3.0, 7.0, 8.0));
	blockD.h[2] = (mat2x3(-4.0, -5.0, -8.0, -1.0, -1.0, -9.0));
	blockD.h[3] = (mat2x3(-8.0, 1.0, 9.0, -2.0, 2.0, 1.0));
	blockD.i = (mat2(2.0, -8.0, 0.0, 6.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, row_major, buffer_reference) buffer BlockB
{
	f16vec4 a;
	lowp mat3x2 b;
	i16vec2 c;
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	lowp uvec2 d;
	bvec3 e[1];
	mediump mat4x2 f;
	mediump mat4x3 g;
	uint16_t h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.b, mat3x2(4.0, -5.0, 6.0, -3.0, -2.0, -3.0)) && allOk;
	allOk = compare_uvec2((blockC[0].d), uvec2(8u, 9u)) && allOk;
	allOk = compare_bvec3((blockC[0].e[0]), bvec3(false, true, false)) && allOk;
	allOk = compare_mat4x3(blockC[0].g, mat4x3(9.0, -6.0, 8.0, -4.0, 4.0, 1.0, -6.0, -2.0, -3.0, -5.0, 4.0, 3.0)) && allOk;
	allOk = compare_uint16_t(uint(blockC[0].h[0]), 5u) && allOk;
	allOk = compare_uint16_t(uint(blockC[0].h[1]), 4u) && allOk;
	allOk = compare_uint16_t(uint(blockC[0].h[2]), 7u) && allOk;
	allOk = compare_uint16_t(uint(blockC[0].h[3]), 8u) && allOk;
	allOk = compare_uint16_t(uint(blockC[0].h[4]), 3u) && allOk;
	allOk = compare_uvec2((blockC[1].d), uvec2(4u, 8u)) && allOk;
	allOk = compare_bvec3((blockC[1].e[0]), bvec3(true, true, false)) && allOk;
	allOk = compare_mat4x3(blockC[1].g, mat4x3(1.0, 0.0, 9.0, -2.0, -1.0, -4.0, -8.0, 0.0, 6.0, -5.0, -2.0, -7.0)) && allOk;
	allOk = compare_uint16_t(uint(blockC[1].h[0]), 1u) && allOk;
	allOk = compare_uint16_t(uint(blockC[1].h[1]), 0u) && allOk;
	allOk = compare_uint16_t(uint(blockC[1].h[2]), 6u) && allOk;
	allOk = compare_uint16_t(uint(blockC[1].h[3]), 4u) && allOk;
	allOk = compare_uint16_t(uint(blockC[1].h[4]), 9u) && allOk;
	allOk = compare_uint16_t(uint(blockC[1].h[5]), 7u) && allOk;
	allOk = compare_uint16_t(uint(blockC[1].h[6]), 7u) && allOk;
	allOk = compare_uint16_t(uint(blockC[1].h[7]), 2u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = f16vec4(vec4(8.0, 7.0, -2.0, 6.0));
	blockC[0].e[0] = (bvec3(true, true, true));
	blockC[0].g = (mat4x3(6.0, -2.0, -5.0, 3.0, 0.0, 9.0, -2.0, 3.0, -3.0, 3.0, 2.0, 2.0));
	blockC[0].h[0] = uint16_t(9u);
	blockC[0].h[1] = uint16_t(0u);
	blockC[0].h[2] = uint16_t(4u);
	blockC[0].h[3] = uint16_t(9u);
	blockC[0].h[4] = uint16_t(3u);
	blockC[1].e[0] = (bvec3(false, false, true));
	blockC[1].g = (mat4x3(-8.0, 9.0, 2.0, -2.0, -2.0, 7.0, 3.0, 7.0, 3.0, -1.0, -2.0, 1.0));
	blockC[1].h[0] = uint16_t(9u);
	blockC[1].h[1] = uint16_t(5u);
	blockC[1].h[2] = uint16_t(6u);
	blockC[1].h[3] = uint16_t(3u);
	blockC[1].h[4] = uint16_t(4u);
	blockC[1].h[5] = uint16_t(7u);
	blockC[1].h[6] = uint16_t(7u);
	blockC[1].h[7] = uint16_t(4u);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, column_major, buffer_reference) buffer BlockB
{
	f16vec4 a;
	highp vec2 b[6];
	bvec2 c;
};
layout(std140, buffer_reference) buffer BlockC
{
	f16vec3 d;
	highp mat2 e;
	float16_t f[2];
	mediump mat3x4 g;
	mediump ivec4 h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(blockB.a), vec4(-8.0, -8.0, 0.0, -9.0)) && allOk;
	allOk = compare_bvec2((blockB.c), bvec2(true, true)) && allOk;
	allOk = compare_f16vec3(vec3(blockC[0].d), vec3(5.0, -9.0, -2.0)) && allOk;
	allOk = compare_float16_t(float(blockC[0].f[0]), 2.0) && allOk;
	allOk = compare_float16_t(float(blockC[0].f[1]), -6.0) && allOk;
	allOk = compare_mat3x4(blockC[0].g, mat3x4(8.0, -7.0, -4.0, -7.0, -2.0, 2.0, 7.0, 8.0, -1.0, 5.0, 9.0, -1.0)) && allOk;
	allOk = compare_ivec4((blockC[0].h[0]), ivec4(5, -9, 2, 3)) && allOk;
	allOk = compare_ivec4((blockC[0].h[1]), ivec4(2, -3, -9, -2)) && allOk;
	allOk = compare_ivec4((blockC[0].h[2]), ivec4(5, -8, -9, -5)) && allOk;
	allOk = compare_ivec4((blockC[0].h[3]), ivec4(-1, 5, 8, -5)) && allOk;
	allOk = compare_ivec4((blockC[0].h[4]), ivec4(7, 4, -1, -2)) && allOk;
	allOk = compare_ivec4((blockC[0].h[5]), ivec4(2, 2, 9, -4)) && allOk;
	allOk = compare_ivec4((blockC[0].h[6]), ivec4(8, -2, -4, -8)) && allOk;
	allOk = compare_ivec4((blockC[0].h[7]), ivec4(-4, 7, -2, -6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (bvec2(true, true));
	blockC[0].d = f16vec3(vec3(3.0, 6.0, -6.0));
	blockC[0].e = (mat2(5.0, 6.0, -6.0, 3.0));
	blockC[0].f[0] = float16_t(7.0);
	blockC[0].f[1] = float16_t(-8.0);
	blockC[0].g = (mat3x4(-2.0, -6.0, -3.0, 0.0, 7.0, -1.0, -5.0, -8.0, 9.0, 7.0, -9.0, -8.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

struct sA
{
	lowp int mA;
	mediump vec2 mB[6];
	highp uvec2 mC;
};
struct sB
{
	int16_t mA;
};
layout(std430, column_major, buffer_reference) buffer BlockB
{
	u16vec2 a;
	uint16_t b;
	sA c;
	sB d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(blockB.a), uvec2(4u, 0u)) && allOk;
	allOk = compare_uint16_t(uint(blockB.b), 4u) && allOk;
	allOk = compare_int16_t(int(blockB.d[0].mA), 5) && allOk;
	allOk = compare_int16_t(int(blockB.d[1].mA), -5) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec2(uvec2(8u, 3u));
	blockB.b = uint16_t(1u);
	blockB.c.mA = (0);
	blockB.c.mB[0] = (vec2(-3.0, 9.0));
	blockB.c.mB[1] = (vec2(-5.0, 2.0));
	blockB.c.mB[2] = (vec2(1.0, 8.0));
	blockB.c.mB[3] = (vec2(6.0, 2.0));
	blockB.c.mB[4] = (vec2(9.0, 8.0));
	blockB.c.mB[5] = (vec2(5.0, -5.0));
	blockB.c.mC = (uvec2(4u, 0u));
	blockB.d[0].mA = int16_t(7);
	blockB.d[1].mA = int16_t(-9);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, buffer_reference) buffer BlockB
{
	mediump uint a;
	uint16_t b;
	highp vec4 c[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	highp ivec2 d;
	bool e;
	highp uint f;
	mediump mat4x3 g;
	mediump vec4 h[];
};
layout(std430, buffer_reference) buffer BlockD
{
	lowp mat2 i;
	lowp mat3x2 j[];
};
layout(std430, buffer_reference) buffer BlockE
{
	lowp uint k[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[3];
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 1u) && allOk;
	allOk = compare_uint16_t(uint(blockB.b), 2u) && allOk;
	allOk = compare_uint((blockC.f), 3u) && allOk;
	allOk = compare_mat4x3(blockC.g, mat4x3(8.0, 0.0, 6.0, -8.0, 1.0, -7.0, 8.0, 0.0, 8.0, -4.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat3x2(blockD[0].j[0], mat3x2(5.0, 8.0, -5.0, 6.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat3x2(blockD[0].j[1], mat3x2(8.0, -7.0, -1.0, -1.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x2(blockD[0].j[2], mat3x2(-9.0, -5.0, -2.0, 1.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat3x2(blockD[0].j[3], mat3x2(-3.0, -1.0, 1.0, 9.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3x2(blockD[0].j[4], mat3x2(6.0, -6.0, -5.0, -1.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x2(blockD[0].j[5], mat3x2(8.0, -9.0, 1.0, 8.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(blockD[0].j[6], mat3x2(9.0, -9.0, -5.0, 3.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat3x2(blockD[1].j[0], mat3x2(6.0, -1.0, 7.0, 9.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(blockD[1].j[1], mat3x2(0.0, -7.0, 0.0, -1.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat3x2(blockD[1].j[2], mat3x2(0.0, 1.0, -8.0, -3.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockD[1].j[3], mat3x2(-3.0, -8.0, 6.0, -6.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockD[1].j[4], mat3x2(-7.0, -8.0, 4.0, -7.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3x2(blockD[2].j[0], mat3x2(9.0, 5.0, 3.0, 4.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockD[2].j[1], mat3x2(-6.0, 9.0, 6.0, 7.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3x2(blockD[2].j[2], mat3x2(4.0, -2.0, 0.0, 4.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockD[2].j[3], mat3x2(1.0, 7.0, -1.0, 6.0, -2.0, 3.0)) && allOk;
	allOk = compare_uint((blockE.k[0]), 1u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (7u);
	blockB.b = uint16_t(1u);
	blockB.c[0] = (vec4(-1.0, -1.0, -1.0, -7.0));
	blockB.c[1] = (vec4(2.0, -3.0, -3.0, 5.0));
	blockB.c[2] = (vec4(2.0, 2.0, 4.0, 9.0));
	blockB.c[3] = (vec4(3.0, -6.0, -7.0, -9.0));
	blockB.c[4] = (vec4(-4.0, 7.0, 1.0, -2.0));
	blockB.c[5] = (vec4(-2.0, -8.0, -2.0, 0.0));
	blockC.e = (true);
	blockC.f = (2u);
	blockC.g = (mat4x3(-3.0, 7.0, -6.0, -4.0, 1.0, -4.0, -7.0, 4.0, 5.0, 4.0, -5.0, -7.0));
	blockD[0].i = (mat2(-2.0, 1.0, -2.0, -8.0));
	blockD[0].j[0] = (mat3x2(-2.0, -3.0, -5.0, -1.0, -7.0, 3.0));
	blockD[0].j[1] = (mat3x2(-2.0, -1.0, -9.0, -3.0, 5.0, -8.0));
	blockD[0].j[2] = (mat3x2(-5.0, 3.0, -3.0, -7.0, -4.0, 8.0));
	blockD[0].j[3] = (mat3x2(-2.0, 3.0, -2.0, 3.0, 9.0, -9.0));
	blockD[0].j[4] = (mat3x2(8.0, 0.0, 8.0, -7.0, -4.0, 4.0));
	blockD[0].j[5] = (mat3x2(5.0, -3.0, 8.0, -3.0, 3.0, -1.0));
	blockD[0].j[6] = (mat3x2(5.0, -3.0, 8.0, -4.0, -1.0, -5.0));
	blockD[1].i = (mat2(6.0, 5.0, 6.0, -1.0));
	blockD[1].j[0] = (mat3x2(-3.0, -4.0, 0.0, -7.0, 0.0, -3.0));
	blockD[1].j[1] = (mat3x2(-6.0, -6.0, 0.0, 2.0, 0.0, 5.0));
	blockD[1].j[2] = (mat3x2(0.0, 3.0, 5.0, 9.0, -4.0, -7.0));
	blockD[1].j[3] = (mat3x2(-2.0, 1.0, 4.0, 7.0, 2.0, -3.0));
	blockD[1].j[4] = (mat3x2(9.0, -8.0, -7.0, 2.0, -7.0, 1.0));
	blockD[2].i = (mat2(-1.0, 1.0, -3.0, 6.0));
	blockD[2].j[0] = (mat3x2(3.0, -1.0, 7.0, 0.0, -7.0, 5.0));
	blockD[2].j[1] = (mat3x2(-9.0, 9.0, 4.0, 4.0, -9.0, 5.0));
	blockD[2].j[2] = (mat3x2(-5.0, 1.0, 5.0, -8.0, 7.0, -8.0));
	blockD[2].j[3] = (mat3x2(-6.0, -2.0, -5.0, 9.0, 4.0, -7.0));
	blockE.k[0] = (8u);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

struct sA
{
	lowp mat2x3 mA;
	mediump vec4 mB;
};
struct sB
{
	float16_t mA;
	highp mat4 mB;
	mediump ivec3 mC;
};
struct sC
{
	mediump ivec3 mA;
	sB mB;
};
struct sD
{
	lowp mat2x3 mA;
	u16vec4 mB;
	u16vec2 mC;
};
struct sE
{
	mediump float mA;
	i16vec3 mB;
	sD mC;
	bvec2 mD;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	bvec2 a;
	highp ivec4 b;
	lowp mat2x3 c[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	bool d;
	highp mat4 e;
	sA f;
	lowp uint g;
	mediump uvec3 h[];
};
layout(std140, buffer_reference) buffer BlockD
{
	bvec3 i;
	mediump mat3x2 j[];
};
layout(std430, column_major, buffer_reference) buffer BlockE
{
	sC k;
	sE l;
	highp mat4x2 m[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
    BlockD blockD[3];
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.b), ivec4(1, -7, 2, -1)) && allOk;
	allOk = compare_mat2x3(blockB.c[0], mat2x3(-2.0, -7.0, -1.0, -8.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2x3(blockB.c[1], mat2x3(-5.0, -8.0, -5.0, 4.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2x3(blockB.c[2], mat2x3(-8.0, 5.0, -3.0, 0.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2x3(blockB.c[3], mat2x3(6.0, -9.0, -7.0, -5.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat2x3(blockB.c[4], mat2x3(9.0, 9.0, 5.0, -2.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat2x3(blockB.c[5], mat2x3(-4.0, 7.0, 1.0, -5.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat2x3(blockB.c[6], mat2x3(4.0, 9.0, 6.0, 2.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(blockB.c[7], mat2x3(1.0, 9.0, -6.0, 6.0, -8.0, 8.0)) && allOk;
	allOk = compare_bool((blockC[0].d), false) && allOk;
	allOk = compare_mat4(blockC[0].e, mat4(1.0, 5.0, 5.0, -4.0, -8.0, 1.0, -5.0, 9.0, 3.0, -9.0, 1.0, 1.0, 8.0, -1.0, -1.0, -3.0)) && allOk;
	allOk = compare_uint((blockC[0].g), 5u) && allOk;
	allOk = compare_bool((blockC[1].d), false) && allOk;
	allOk = compare_mat4(blockC[1].e, mat4(-9.0, -8.0, 2.0, 9.0, 1.0, 5.0, 5.0, -9.0, 3.0, 6.0, 2.0, -3.0, 6.0, -2.0, 3.0, 3.0)) && allOk;
	allOk = compare_uint((blockC[1].g), 8u) && allOk;
	allOk = compare_bool((blockC[2].d), false) && allOk;
	allOk = compare_mat4(blockC[2].e, mat4(-3.0, 9.0, 3.0, 1.0, -7.0, -3.0, 2.0, -2.0, 1.0, -1.0, -9.0, -3.0, -1.0, -7.0, 4.0, -8.0)) && allOk;
	allOk = compare_uint((blockC[2].g), 9u) && allOk;
	allOk = compare_mat3x2(blockD[0].j[0], mat3x2(7.0, 7.0, 9.0, 0.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat3x2(blockD[0].j[1], mat3x2(4.0, 9.0, 7.0, 8.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat3x2(blockD[1].j[0], mat3x2(1.0, -1.0, 3.0, 0.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(blockD[1].j[1], mat3x2(0.0, -5.0, -5.0, -3.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3x2(blockD[1].j[2], mat3x2(-2.0, -8.0, 0.0, 0.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x2(blockD[1].j[3], mat3x2(-2.0, -2.0, 1.0, 7.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x2(blockD[2].j[0], mat3x2(-6.0, -4.0, 1.0, -7.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(blockD[2].j[1], mat3x2(-4.0, -5.0, -7.0, -9.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x2(blockD[2].j[2], mat3x2(-9.0, 4.0, 5.0, 7.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3x2(blockD[2].j[3], mat3x2(9.0, 1.0, -7.0, -7.0, 1.0, 7.0)) && allOk;
	allOk = compare_ivec3((blockE.k.mA), ivec3(-1, 8, -6)) && allOk;
	allOk = compare_float16_t(float(blockE.k.mB.mA), 0.0) && allOk;
	allOk = compare_mat4(blockE.k.mB.mB, mat4(-8.0, -2.0, 5.0, 7.0, 8.0, -1.0, -4.0, -6.0, -1.0, 1.0, 4.0, 9.0, 1.0, 8.0, 1.0, -6.0)) && allOk;
	allOk = compare_ivec3((blockE.k.mB.mC), ivec3(7, 7, 5)) && allOk;
	allOk = compare_mat4x2(blockE.m[0], mat4x2(9.0, -1.0, 8.0, 8.0, -3.0, -2.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat4x2(blockE.m[1], mat4x2(2.0, -5.0, -6.0, 3.0, 9.0, 6.0, 8.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, false));
	blockB.b = (ivec4(-1, 5, 2, 5));
	blockB.c[0] = (mat2x3(-8.0, 5.0, 3.0, -3.0, -6.0, 7.0));
	blockB.c[1] = (mat2x3(3.0, 2.0, -4.0, -3.0, -9.0, 8.0));
	blockB.c[2] = (mat2x3(-3.0, 5.0, 7.0, -3.0, 1.0, 9.0));
	blockB.c[3] = (mat2x3(-3.0, 7.0, 8.0, 7.0, -9.0, 5.0));
	blockB.c[4] = (mat2x3(9.0, 1.0, -5.0, -4.0, 6.0, -6.0));
	blockB.c[5] = (mat2x3(2.0, -1.0, -1.0, 3.0, -3.0, 7.0));
	blockB.c[6] = (mat2x3(-8.0, -1.0, 2.0, 4.0, -6.0, 7.0));
	blockB.c[7] = (mat2x3(4.0, 3.0, 1.0, -5.0, 9.0, -4.0));
	blockC[0].e = (mat4(-6.0, 2.0, -7.0, 9.0, -2.0, -8.0, -8.0, -7.0, 6.0, 6.0, -1.0, -4.0, -9.0, 9.0, -6.0, -3.0));
	blockC[0].f.mA = (mat2x3(7.0, 1.0, -7.0, 3.0, -6.0, -9.0));
	blockC[0].f.mB = (vec4(7.0, -4.0, -1.0, -3.0));
	blockC[0].g = (5u);
	blockC[0].h[0] = (uvec3(3u, 7u, 4u));
	blockC[0].h[1] = (uvec3(3u, 7u, 2u));
	blockC[0].h[2] = (uvec3(0u, 3u, 0u));
	blockC[1].e = (mat4(7.0, 0.0, 6.0, 9.0, -7.0, -3.0, -6.0, -9.0, -6.0, 8.0, 3.0, 4.0, -2.0, -9.0, 0.0, 5.0));
	blockC[1].f.mA = (mat2x3(0.0, 7.0, -9.0, 4.0, 7.0, -7.0));
	blockC[1].f.mB = (vec4(6.0, 0.0, -3.0, 5.0));
	blockC[1].g = (7u);
	blockC[1].h[0] = (uvec3(4u, 3u, 4u));
	blockC[2].e = (mat4(-4.0, 9.0, 4.0, -5.0, -9.0, 6.0, 5.0, 4.0, -3.0, -4.0, 5.0, 3.0, -5.0, -5.0, -2.0, -5.0));
	blockC[2].f.mA = (mat2x3(-6.0, -9.0, -8.0, 5.0, -1.0, -4.0));
	blockC[2].f.mB = (vec4(-5.0, -5.0, -6.0, 0.0));
	blockC[2].g = (5u);
	blockC[2].h[0] = (uvec3(1u, 5u, 8u));
	blockC[2].h[1] = (uvec3(0u, 1u, 7u));
	blockD[0].j[0] = (mat3x2(5.0, -5.0, -4.0, 2.0, -3.0, 3.0));
	blockD[0].j[1] = (mat3x2(1.0, 2.0, -7.0, -1.0, 6.0, -1.0));
	blockD[1].j[0] = (mat3x2(-9.0, -2.0, -2.0, 9.0, 8.0, -7.0));
	blockD[1].j[1] = (mat3x2(1.0, -3.0, 8.0, 2.0, -4.0, -9.0));
	blockD[1].j[2] = (mat3x2(1.0, 4.0, -3.0, -1.0, 4.0, -2.0));
	blockD[1].j[3] = (mat3x2(8.0, -7.0, 1.0, -1.0, 7.0, 5.0));
	blockD[2].j[0] = (mat3x2(2.0, 3.0, 4.0, 3.0, -9.0, -4.0));
	blockD[2].j[1] = (mat3x2(-2.0, 9.0, -2.0, -2.0, -5.0, 4.0));
	blockD[2].j[2] = (mat3x2(-1.0, 2.0, -5.0, 9.0, -1.0, 2.0));
	blockD[2].j[3] = (mat3x2(-1.0, -8.0, 7.0, -6.0, 2.0, -5.0));
	blockE.l.mA = (5.0);
	blockE.l.mB = i16vec3(ivec3(-4, 7, 8));
	blockE.l.mC.mA = (mat2x3(-5.0, -1.0, -5.0, 0.0, -8.0, -7.0));
	blockE.l.mC.mB = u16vec4(uvec4(4u, 8u, 3u, 5u));
	blockE.l.mC.mC = u16vec2(uvec2(2u, 2u));
	blockE.l.mD = (bvec2(false, false));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(buffer_reference) buffer BlockB
{
	layout(offset = 0) i16vec2 a;
	layout(offset = 4) u16vec2 b;
	layout(offset = 8) highp uint c;
	layout(offset = 16) i16vec3 d;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump ivec4 e;
	layout(offset = 16) int16_t f;
	layout(offset = 20) lowp uint g;
	layout(offset = 24) uint16_t h;
	layout(offset = 32) highp ivec3 i;
};
layout(buffer_reference) readonly buffer BlockD
{
	layout(offset = 0) f16vec2 j;
	layout(offset = 4) i16vec4 k;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) int16_t l;
	layout(offset = 2) i16vec3 m;
	layout(offset = 8) lowp int n[1];
	layout(offset = 12) int16_t o;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[3];
    BlockE blockE[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(blockB.a), ivec2(-8, 7)) && allOk;
	allOk = compare_uint((blockB.c), 6u) && allOk;
	allOk = compare_int16_t(int(blockC.f), 0) && allOk;
	allOk = compare_uint((blockC.g), 5u) && allOk;
	allOk = compare_uint16_t(uint(blockC.h), 5u) && allOk;
	allOk = compare_f16vec2(vec2(blockD[0].j), vec2(0.0, -7.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD[0].k), ivec4(5, 5, 8, 1)) && allOk;
	allOk = compare_f16vec2(vec2(blockD[1].j), vec2(-7.0, -1.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD[1].k), ivec4(-4, 5, 7, -9)) && allOk;
	allOk = compare_f16vec2(vec2(blockD[2].j), vec2(-1.0, 8.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD[2].k), ivec4(8, -7, 2, 9)) && allOk;
	allOk = compare_int16_t(int(blockE[0].l), -2) && allOk;
	allOk = compare_i16vec3(ivec3(blockE[0].m), ivec3(-1, -5, 1)) && allOk;
	allOk = compare_int((blockE[0].n[0]), 0) && allOk;
	allOk = compare_int16_t(int(blockE[0].o), 7) && allOk;
	allOk = compare_int16_t(int(blockE[1].l), -9) && allOk;
	allOk = compare_i16vec3(ivec3(blockE[1].m), ivec3(3, -8, 4)) && allOk;
	allOk = compare_int((blockE[1].n[0]), 9) && allOk;
	allOk = compare_int16_t(int(blockE[1].o), 6) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i16vec2(ivec2(2, 7));
	blockB.b = u16vec2(uvec2(8u, 7u));
	blockB.c = (2u);
	blockB.d = i16vec3(ivec3(4, 9, -3));
	blockC.e = (ivec4(2, 8, -9, -7));
	blockC.f = int16_t(4);
	blockC.g = (6u);
	blockC.i = (ivec3(5, -2, -4));
	blockE[0].o = int16_t(-2);
	blockE[1].o = int16_t(-3);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, column_major, buffer_reference) buffer BlockB
{
	float16_t a;
	highp int b;
	i16vec3 c;
};
layout(scalar, buffer_reference) buffer BlockC
{
	f16vec4 d;
	highp uvec2 e;
	bvec2 f;
	lowp uvec3 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockB[0].a), -5.0) && allOk;
	allOk = compare_int((blockB[0].b), -9) && allOk;
	allOk = compare_i16vec3(ivec3(blockB[0].c), ivec3(-7, 9, -1)) && allOk;
	allOk = compare_float16_t(float(blockB[1].a), 0.0) && allOk;
	allOk = compare_int((blockB[1].b), -3) && allOk;
	allOk = compare_i16vec3(ivec3(blockB[1].c), ivec3(9, -2, 0)) && allOk;
	allOk = compare_float16_t(float(blockB[2].a), 3.0) && allOk;
	allOk = compare_int((blockB[2].b), -3) && allOk;
	allOk = compare_i16vec3(ivec3(blockB[2].c), ivec3(2, -3, 8)) && allOk;
	allOk = compare_f16vec4(vec4(blockC.d), vec4(8.0, -3.0, 8.0, 5.0)) && allOk;
	allOk = compare_bvec2((blockC.f), bvec2(false, true)) && allOk;
	allOk = compare_uvec3((blockC.g[0]), uvec3(2u, 4u, 3u)) && allOk;
	allOk = compare_uvec3((blockC.g[1]), uvec3(0u, 3u, 4u)) && allOk;
	allOk = compare_uvec3((blockC.g[2]), uvec3(5u, 6u, 0u)) && allOk;
	allOk = compare_uvec3((blockC.g[3]), uvec3(7u, 9u, 8u)) && allOk;
	allOk = compare_uvec3((blockC.g[4]), uvec3(1u, 0u, 4u)) && allOk;
	allOk = compare_uvec3((blockC.g[5]), uvec3(7u, 2u, 4u)) && allOk;
	allOk = compare_uvec3((blockC.g[6]), uvec3(9u, 3u, 1u)) && allOk;
	allOk = compare_uvec3((blockC.g[7]), uvec3(0u, 8u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = float16_t(-7.0);
	blockB[0].b = (4);
	blockB[0].c = i16vec3(ivec3(-4, -7, -3));
	blockB[1].a = float16_t(-9.0);
	blockB[1].b = (1);
	blockB[1].c = i16vec3(ivec3(2, 8, -2));
	blockB[2].a = float16_t(5.0);
	blockB[2].b = (-7);
	blockB[2].c = i16vec3(ivec3(-5, -9, -9));
	blockC.d = f16vec4(vec4(-7.0, 3.0, 1.0, 2.0));
	blockC.e = (uvec2(7u, 5u));
	blockC.f = (bvec2(true, false));
	blockC.g[0] = (uvec3(0u, 2u, 3u));
	blockC.g[1] = (uvec3(3u, 8u, 6u));
	blockC.g[2] = (uvec3(3u, 3u, 4u));
	blockC.g[3] = (uvec3(4u, 8u, 4u));
	blockC.g[4] = (uvec3(4u, 7u, 0u));
	blockC.g[5] = (uvec3(4u, 8u, 9u));
	blockC.g[6] = (uvec3(3u, 2u, 2u));
	blockC.g[7] = (uvec3(1u, 7u, 2u));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, buffer_reference) buffer BlockB
{
	int8_t a;
	int8_t b;
	int8_t c;
	int8_t d;
	highp uint e;
};
layout(std140, buffer_reference) buffer BlockC
{
	uint8_t f;
	bool g;
	mediump int h[1];
	int8_t i;
	bool j;
};
layout(std140, buffer_reference) buffer BlockD
{
	highp uint k;
	mediump int l;
	highp uint m;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(blockB.b), 4294967295) && allOk;
	allOk = compare_int8_t(int(blockB.d), 6) && allOk;
	allOk = compare_uint((blockB.e), 8u) && allOk;
	allOk = compare_uint8_t(uint(blockC.f), 2u) && allOk;
	allOk = compare_bool((blockC.g), true) && allOk;
	allOk = compare_int8_t(int(blockC.i), 4294967287) && allOk;
	allOk = compare_bool((blockC.j), false) && allOk;
	allOk = compare_int((blockD.l), -9) && allOk;
	allOk = compare_uint((blockD.m), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = int8_t(5);
	blockB.b = int8_t(7);
	blockB.e = (5u);
	blockC.f = uint8_t(7u);
	blockC.h[0] = (-3);
	blockC.i = int8_t(4294967287);
	blockC.j = (false);
	blockD.l = (-4);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, buffer_reference) buffer BlockB
{
	i8vec2 a;
	i8vec2 b;
	u8vec2 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(blockB.b), ivec2(1, 6)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB.c), uvec2(8u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i8vec2(ivec2(5, 7));
	blockB.b = i8vec2(ivec2(4294967287, 4294967290));
	blockB.c = u8vec2(uvec2(5u, 7u));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, column_major, buffer_reference) buffer BlockB
{
	highp mat2 a;
	highp vec3 b;
	mediump float c[];
};
layout(std430, row_major, buffer_reference) readonly buffer BlockC
{
	mediump ivec3 d;
	lowp mat4x2 e;
};
layout(std430, buffer_reference) buffer BlockD
{
	highp mat4 f;
	lowp mat2x3 g[];
};
layout(std140, buffer_reference) buffer BlockE
{
	mediump int h;
	lowp mat3 i;
	bvec3 j[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.c[0]), 5.0) && allOk;
	allOk = compare_float((blockB.c[1]), 3.0) && allOk;
	allOk = compare_float((blockB.c[2]), 7.0) && allOk;
	allOk = compare_float((blockB.c[3]), 5.0) && allOk;
	allOk = compare_float((blockB.c[4]), 1.0) && allOk;
	allOk = compare_float((blockB.c[5]), -2.0) && allOk;
	allOk = compare_float((blockB.c[6]), 6.0) && allOk;
	allOk = compare_ivec3((blockC.d), ivec3(3, -6, -9)) && allOk;
	allOk = compare_mat4x2(blockC.e, mat4x2(-9.0, -6.0, 3.0, 2.0, 8.0, -6.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat4(blockD.f, mat4(9.0, -9.0, 8.0, -6.0, -5.0, -9.0, -3.0, -5.0, 3.0, 0.0, 7.0, 8.0, -9.0, -4.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat2x3(blockD.g[0], mat2x3(-4.0, -5.0, -1.0, 2.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat2x3(blockD.g[1], mat2x3(2.0, -1.0, 8.0, -8.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x3(blockD.g[2], mat2x3(8.0, -1.0, -8.0, -7.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat2x3(blockD.g[3], mat2x3(4.0, 7.0, -4.0, 1.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat2x3(blockD.g[4], mat2x3(8.0, 0.0, -3.0, 1.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat2x3(blockD.g[5], mat2x3(0.0, 9.0, -5.0, -9.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat2x3(blockD.g[6], mat2x3(1.0, -3.0, -7.0, 1.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat2x3(blockD.g[7], mat2x3(-6.0, -8.0, 0.0, -8.0, 1.0, -8.0)) && allOk;
	allOk = compare_int((blockE.h), -1) && allOk;
	allOk = compare_mat3(blockE.i, mat3(-6.0, -9.0, -8.0, -2.0, 8.0, 7.0, -2.0, -5.0, 9.0)) && allOk;
	allOk = compare_bvec3((blockE.j[0]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((blockE.j[1]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((blockE.j[2]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockE.j[3]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockE.j[4]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((blockE.j[5]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((blockE.j[6]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((blockE.j[7]), bvec3(true, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (vec3(2.0, 2.0, -5.0));
	blockB.c[0] = (7.0);
	blockB.c[1] = (-5.0);
	blockB.c[2] = (5.0);
	blockB.c[3] = (-3.0);
	blockB.c[4] = (4.0);
	blockB.c[5] = (-8.0);
	blockB.c[6] = (9.0);
	blockD.f = (mat4(5.0, 9.0, 3.0, -9.0, -1.0, -5.0, -8.0, 3.0, 0.0, -6.0, -8.0, -3.0, 8.0, 2.0, -4.0, 6.0));
	blockE.h = (8);
	blockE.i = (mat3(-9.0, 4.0, -4.0, -1.0, 6.0, -7.0, -1.0, -7.0, 7.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, row_major, buffer_reference) buffer BlockB
{
	lowp float a;
	lowp mat4 b;
	bvec3 c;
	int8_t d;
	lowp uvec2 e[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	bvec3 f[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	uint8_t g;
	i8vec2 h;
	mediump vec3 i[6];
	u8vec2 j;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.b, mat4(2.0, 5.0, -4.0, 9.0, -8.0, -6.0, -3.0, -9.0, 6.0, 1.0, 4.0, -8.0, 7.0, 9.0, 4.0, -9.0)) && allOk;
	allOk = compare_bvec3((blockB.c), bvec3(false, true, true)) && allOk;
	allOk = compare_int8_t(int(blockB.d), 2) && allOk;
	allOk = compare_uvec2((blockB.e[0]), uvec2(4u, 2u)) && allOk;
	allOk = compare_uvec2((blockB.e[1]), uvec2(9u, 7u)) && allOk;
	allOk = compare_uvec2((blockB.e[2]), uvec2(9u, 0u)) && allOk;
	allOk = compare_uvec2((blockB.e[3]), uvec2(5u, 6u)) && allOk;
	allOk = compare_bvec3((blockC.f[0]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((blockC.f[1]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((blockC.f[2]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((blockC.f[3]), bvec3(true, true, false)) && allOk;
	allOk = compare_uint8_t(uint(blockD.g), 0u) && allOk;
	allOk = compare_vec3((blockD.i[0]), vec3(5.0, -3.0, 0.0)) && allOk;
	allOk = compare_vec3((blockD.i[1]), vec3(-8.0, 1.0, -9.0)) && allOk;
	allOk = compare_vec3((blockD.i[2]), vec3(-9.0, -9.0, -7.0)) && allOk;
	allOk = compare_vec3((blockD.i[3]), vec3(7.0, -2.0, 2.0)) && allOk;
	allOk = compare_vec3((blockD.i[4]), vec3(-4.0, 4.0, -8.0)) && allOk;
	allOk = compare_vec3((blockD.i[5]), vec3(4.0, 8.0, 5.0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD.j), uvec2(3u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (6.0);
	blockB.d = int8_t(4294967294);
	blockB.e[0] = (uvec2(8u, 0u));
	blockB.e[1] = (uvec2(4u, 7u));
	blockB.e[2] = (uvec2(4u, 2u));
	blockB.e[3] = (uvec2(3u, 4u));
	blockC.f[0] = (bvec3(false, true, false));
	blockC.f[1] = (bvec3(true, false, true));
	blockC.f[2] = (bvec3(true, true, false));
	blockC.f[3] = (bvec3(true, true, false));
	blockD.g = uint8_t(9u);
	blockD.j = u8vec2(uvec2(3u, 8u));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

struct sA
{
	lowp mat4x3 mA;
	mediump vec2 mB;
};
struct sB
{
	u8vec4 mA;
	lowp vec4 mB;
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	sA a;
	sB b[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	highp ivec3 c;
	mediump int d[];
};
layout(std140, buffer_reference) buffer BlockD
{
	mediump vec4 e;
	lowp uvec3 f;
	mediump vec3 g[];
};
layout(std140, row_major, buffer_reference) buffer BlockE
{
	mediump float h;
	mediump mat4 i;
	highp vec4 j;
	i8vec3 k;
	i8vec3 l[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.a.mA, mat4x3(6.0, -4.0, -6.0, 8.0, -5.0, -1.0, 8.0, 9.0, -1.0, 0.0, -4.0, -2.0)) && allOk;
	allOk = compare_vec2((blockB.a.mB), vec2(1.0, 6.0)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB.b[0].mA), uvec4(8u, 2u, 3u, 1u)) && allOk;
	allOk = compare_vec4((blockB.b[0].mB), vec4(0.0, 2.0, 0.0, 6.0)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB.b[1].mA), uvec4(5u, 6u, 5u, 3u)) && allOk;
	allOk = compare_vec4((blockB.b[1].mB), vec4(2.0, 3.0, -5.0, -1.0)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB.b[2].mA), uvec4(0u, 2u, 4u, 8u)) && allOk;
	allOk = compare_vec4((blockB.b[2].mB), vec4(-5.0, -1.0, -9.0, -6.0)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB.b[3].mA), uvec4(0u, 9u, 4u, 9u)) && allOk;
	allOk = compare_vec4((blockB.b[3].mB), vec4(-9.0, -8.0, 6.0, -2.0)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB.b[4].mA), uvec4(1u, 8u, 6u, 2u)) && allOk;
	allOk = compare_vec4((blockB.b[4].mB), vec4(3.0, 7.0, 2.0, -7.0)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB.b[5].mA), uvec4(0u, 8u, 1u, 3u)) && allOk;
	allOk = compare_vec4((blockB.b[5].mB), vec4(-2.0, -5.0, 4.0, 8.0)) && allOk;
	allOk = compare_int((blockC.d[0]), -8) && allOk;
	allOk = compare_uvec3((blockD.f), uvec3(5u, 7u, 0u)) && allOk;
	allOk = compare_vec3((blockD.g[0]), vec3(9.0, -9.0, 2.0)) && allOk;
	allOk = compare_vec3((blockD.g[1]), vec3(4.0, 7.0, 4.0)) && allOk;
	allOk = compare_vec3((blockD.g[2]), vec3(-6.0, -8.0, 5.0)) && allOk;
	allOk = compare_vec3((blockD.g[3]), vec3(-7.0, 8.0, -2.0)) && allOk;
	allOk = compare_vec3((blockD.g[4]), vec3(6.0, 2.0, -9.0)) && allOk;
	allOk = compare_vec3((blockD.g[5]), vec3(-5.0, 4.0, 4.0)) && allOk;
	allOk = compare_vec3((blockD.g[6]), vec3(-7.0, -4.0, -9.0)) && allOk;
	allOk = compare_vec3((blockD.g[7]), vec3(7.0, 6.0, 9.0)) && allOk;
	allOk = compare_float((blockE.h), 8.0) && allOk;
	allOk = compare_vec4((blockE.j), vec4(6.0, -7.0, 7.0, 6.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE.k), ivec3(5, 4294967291, 4294967287)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE.l[0]), ivec3(4294967289, 4294967293, 7)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE.l[1]), ivec3(4294967287, 4294967288, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE.l[2]), ivec3(3, 6, 2)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE.l[3]), ivec3(4294967293, 4294967295, 4)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE.l[4]), ivec3(4294967290, 3, 0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE.l[5]), ivec3(4294967295, 4294967290, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA = (mat4x3(-5.0, -6.0, -7.0, -3.0, 6.0, 8.0, -2.0, -6.0, 5.0, 0.0, 3.0, -6.0));
	blockB.a.mB = (vec2(-7.0, -2.0));
	blockB.b[0].mA = u8vec4(uvec4(7u, 8u, 7u, 9u));
	blockB.b[0].mB = (vec4(-8.0, 5.0, -4.0, 8.0));
	blockB.b[1].mA = u8vec4(uvec4(9u, 7u, 3u, 9u));
	blockB.b[1].mB = (vec4(-5.0, 2.0, -2.0, 8.0));
	blockB.b[2].mA = u8vec4(uvec4(3u, 4u, 5u, 6u));
	blockB.b[2].mB = (vec4(-1.0, -1.0, 1.0, 7.0));
	blockB.b[3].mA = u8vec4(uvec4(1u, 9u, 7u, 4u));
	blockB.b[3].mB = (vec4(8.0, 7.0, 0.0, -5.0));
	blockB.b[4].mA = u8vec4(uvec4(0u, 5u, 5u, 4u));
	blockB.b[4].mB = (vec4(6.0, 5.0, -6.0, -6.0));
	blockB.b[5].mA = u8vec4(uvec4(3u, 0u, 1u, 7u));
	blockB.b[5].mB = (vec4(6.0, 6.0, -6.0, 3.0));
	blockC.d[0] = (-9);
	blockD.f = (uvec3(4u, 4u, 2u));
	blockD.g[0] = (vec3(2.0, 8.0, -1.0));
	blockD.g[1] = (vec3(-1.0, 3.0, -6.0));
	blockD.g[2] = (vec3(6.0, -1.0, -9.0));
	blockD.g[3] = (vec3(7.0, 5.0, -7.0));
	blockD.g[4] = (vec3(5.0, -3.0, -4.0));
	blockD.g[5] = (vec3(-1.0, 7.0, -9.0));
	blockD.g[6] = (vec3(2.0, -7.0, 1.0));
	blockD.g[7] = (vec3(-9.0, -7.0, 3.0));
	blockE.h = (3.0);
	blockE.j = (vec4(4.0, 2.0, 7.0, 2.0));
	blockE.l[0] = i8vec3(ivec3(0, 4294967288, 4294967293));
	blockE.l[1] = i8vec3(ivec3(4294967294, 4294967292, 4294967295));
	blockE.l[2] = i8vec3(ivec3(4294967290, 2, 5));
	blockE.l[3] = i8vec3(ivec3(4294967288, 4294967293, 4294967290));
	blockE.l[4] = i8vec3(ivec3(4294967294, 5, 2));
	blockE.l[5] = i8vec3(ivec3(9, 4294967293, 4294967292));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

struct sA
{
	mediump ivec2 mA;
	u8vec2 mB;
	lowp uint mC;
	mediump uvec2 mD;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	highp mat3x2 a;
	lowp mat2x3 b;
	mediump vec4 c[6];
	highp vec4 d[];
};
layout(std140, buffer_reference) buffer BlockC
{
	i8vec4 e;
	sA f;
	i8vec2 g;
	highp mat4x2 h;
	mediump mat3x2 i[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB[0].b, mat2x3(-6.0, 8.0, -4.0, -2.0, 4.0, -9.0)) && allOk;
	allOk = compare_vec4((blockB[0].d[0]), vec4(-2.0, 4.0, 0.0, -1.0)) && allOk;
	allOk = compare_vec4((blockB[0].d[1]), vec4(1.0, -8.0, -9.0, 5.0)) && allOk;
	allOk = compare_vec4((blockB[0].d[2]), vec4(0.0, -3.0, 9.0, 1.0)) && allOk;
	allOk = compare_vec4((blockB[0].d[3]), vec4(-6.0, 1.0, 0.0, -5.0)) && allOk;
	allOk = compare_vec4((blockB[0].d[4]), vec4(-7.0, -9.0, 6.0, -4.0)) && allOk;
	allOk = compare_vec4((blockB[0].d[5]), vec4(-1.0, 5.0, 3.0, 8.0)) && allOk;
	allOk = compare_vec4((blockB[0].d[6]), vec4(-2.0, 1.0, -3.0, 0.0)) && allOk;
	allOk = compare_vec4((blockB[0].d[7]), vec4(0.0, 0.0, -7.0, -9.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.e), ivec4(6, 4, 5, 3)) && allOk;
	allOk = compare_mat3x2(blockC.i[0], mat3x2(8.0, -6.0, -4.0, 9.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat3x2(blockC.i[1], mat3x2(-8.0, 4.0, -7.0, 6.0, 6.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (mat3x2(4.0, 4.0, 0.0, 1.0, 9.0, -7.0));
	blockB[0].b = (mat2x3(-4.0, -6.0, -2.0, -4.0, -5.0, 4.0));
	blockB[0].c[0] = (vec4(-2.0, 5.0, -9.0, -3.0));
	blockB[0].c[1] = (vec4(-1.0, -9.0, 1.0, 1.0));
	blockB[0].c[2] = (vec4(7.0, 8.0, 9.0, -7.0));
	blockB[0].c[3] = (vec4(-1.0, -6.0, 5.0, 6.0));
	blockB[0].c[4] = (vec4(5.0, 6.0, -6.0, -9.0));
	blockB[0].c[5] = (vec4(3.0, -7.0, -4.0, -6.0));
	blockB[0].d[0] = (vec4(-5.0, 3.0, -9.0, -6.0));
	blockB[0].d[1] = (vec4(-3.0, -7.0, -1.0, -5.0));
	blockB[0].d[2] = (vec4(6.0, -5.0, -6.0, 8.0));
	blockB[0].d[3] = (vec4(9.0, 6.0, -9.0, 4.0));
	blockB[0].d[4] = (vec4(7.0, -3.0, 0.0, 8.0));
	blockB[0].d[5] = (vec4(-9.0, -1.0, 8.0, 3.0));
	blockB[0].d[6] = (vec4(-6.0, 7.0, 0.0, 5.0));
	blockB[0].d[7] = (vec4(-9.0, 0.0, -2.0, -6.0));
	blockC.e = i8vec4(ivec4(4294967293, 4294967289, 9, 5));
	blockC.f.mA = (ivec2(-5, -2));
	blockC.f.mB = u8vec2(uvec2(1u, 4u));
	blockC.f.mC = (7u);
	blockC.f.mD = (uvec2(0u, 1u));
	blockC.g = i8vec2(ivec2(8, 4294967288));
	blockC.i[0] = (mat3x2(0.0, -9.0, -4.0, 1.0, -2.0, 1.0));
	blockC.i[1] = (mat3x2(6.0, 9.0, -8.0, -1.0, 5.0, -6.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(buffer_reference) buffer BlockB
{
	layout(offset = 0) mediump ivec3 a;
	layout(offset = 12) u8vec3 b;
	layout(offset = 16) i8vec4 c;
	layout(offset = 20) i8vec4 d;
	layout(offset = 24) i8vec2 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(blockB.b), uvec3(7u, 3u, 3u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.c), ivec4(4294967295, 4294967288, 2, 4294967290)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.d), ivec4(5, 4294967289, 2, 8)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.e), ivec2(8, 6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec3(9, -2, -3));
	blockB.c = i8vec4(ivec4(4294967288, 7, 6, 4294967292));
	blockB.d = i8vec4(ivec4(5, 7, 9, 4294967294));
	blockB.e = i8vec2(ivec2(6, 4));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(buffer_reference) buffer BlockB
{
	layout(offset = 0) highp vec2 a;
	layout(offset = 16) highp uvec4 b;
	layout(offset = 32) int8_t c;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) lowp uvec2 d;
	layout(offset = 16) bvec3 e;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) u8vec3 f;
	layout(offset = 4) highp uvec2 g;
	layout(offset = 16) mediump uvec2 h[1];
	layout(offset = 32) highp vec3 i;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) u8vec3 j;
	layout(offset = 4) lowp int k;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.b), uvec4(0u, 5u, 4u, 2u)) && allOk;
	allOk = compare_uvec2((blockC.d), uvec2(5u, 0u)) && allOk;
	allOk = compare_bvec3((blockC.e), bvec3(false, false, true)) && allOk;
	allOk = compare_uvec2((blockD.g), uvec2(9u, 0u)) && allOk;
	allOk = compare_uvec2((blockD.h[0]), uvec2(5u, 6u)) && allOk;
	allOk = compare_vec3((blockD.i), vec3(3.0, -7.0, 4.0)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE.j), uvec3(9u, 3u, 2u)) && allOk;
	allOk = compare_int((blockE.k), 2) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec2(6.0, 3.0));
	blockB.b = (uvec4(6u, 2u, 4u, 6u));
	blockB.c = int8_t(4294967290);
	blockC.d = (uvec2(8u, 5u));
	blockC.e = (bvec3(false, true, false));
	blockD.f = u8vec3(uvec3(2u, 6u, 4u));
	blockD.g = (uvec2(1u, 7u));
	blockD.i = (vec3(8.0, -1.0, -4.0));
	blockE.j = u8vec3(uvec3(6u, 7u, 2u));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(buffer_reference) buffer BlockB
{
	layout(offset = 0) bool a;
	layout(offset = 4) highp uint b;
	layout(offset = 16) bvec4 c;
	layout(offset = 32) highp ivec4 d;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) lowp uvec3 e[1];
	layout(offset = 16) mediump uint f;
	layout(offset = 32) mediump vec4 g;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.b), 7u) && allOk;
	allOk = compare_bvec4((blockB.c), bvec4(true, false, true, true)) && allOk;
	allOk = compare_ivec4((blockB.d), ivec4(-4, -9, -9, -7)) && allOk;
	allOk = compare_uint((blockC[0].f), 8u) && allOk;
	allOk = compare_vec4((blockC[0].g), vec4(0.0, -1.0, -3.0, 0.0)) && allOk;
	allOk = compare_uint((blockC[1].f), 6u) && allOk;
	allOk = compare_vec4((blockC[1].g), vec4(9.0, -1.0, -1.0, 6.0)) && allOk;
	allOk = compare_uint((blockC[2].f), 5u) && allOk;
	allOk = compare_vec4((blockC[2].g), vec4(-6.0, 8.0, -2.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
	blockB.b = (1u);
	blockB.d = (ivec4(-5, -2, 4, -2));
	blockC[0].e[0] = (uvec3(6u, 2u, 9u));
	blockC[0].f = (3u);
	blockC[1].e[0] = (uvec3(6u, 7u, 9u));
	blockC[1].f = (5u);
	blockC[2].e[0] = (uvec3(8u, 1u, 8u));
	blockC[2].f = (3u);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(buffer_reference) buffer BlockB
{
	layout(offset = 0) bool a;
	layout(offset = 16) highp vec3 b[1];
	layout(offset = 32) bvec2 c[1];
	layout(offset = 40) lowp uint d;
	layout(offset = 48) lowp uvec3 e;
};
layout(buffer_reference) readonly buffer BlockC
{
	layout(offset = 0) highp float f;
};
layout(buffer_reference) readonly buffer BlockD
{
	layout(offset = 0) bool g;
	layout(offset = 16) highp ivec4 h;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) bvec3 i;
	layout(offset = 12) uint8_t j;
	layout(offset = 16) highp float k;
	layout(offset = 32) highp uvec4 l[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a), true) && allOk;
	allOk = compare_bvec2((blockB.c[0]), bvec2(false, true)) && allOk;
	allOk = compare_uint((blockB.d), 1u) && allOk;
	allOk = compare_uvec3((blockB.e), uvec3(8u, 9u, 3u)) && allOk;
	allOk = compare_float((blockC.f), -6.0) && allOk;
	allOk = compare_bool((blockD.g), true) && allOk;
	allOk = compare_ivec4((blockD.h), ivec4(4, 8, -1, 6)) && allOk;
	allOk = compare_uint8_t(uint(blockE[0].j), 4u) && allOk;
	allOk = compare_float((blockE[0].k), -5.0) && allOk;
	allOk = compare_uvec4((blockE[0].l[0]), uvec4(0u, 3u, 8u, 1u)) && allOk;
	allOk = compare_uint8_t(uint(blockE[1].j), 2u) && allOk;
	allOk = compare_float((blockE[1].k), -5.0) && allOk;
	allOk = compare_uvec4((blockE[1].l[0]), uvec4(2u, 7u, 4u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (vec3(5.0, 1.0, -7.0));
	blockB.d = (3u);
	blockB.e = (uvec3(1u, 6u, 3u));
	blockE[0].i = (bvec3(false, true, true));
	blockE[0].j = uint8_t(9u);
	blockE[1].i = (bvec3(false, true, false));
	blockE[1].j = uint8_t(3u);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(buffer_reference) buffer BlockB
{
	layout(offset = 0) u8vec2 a;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump vec2 b;
	layout(offset = 16) highp uvec4 c;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) highp int d;
	layout(offset = 4) highp int e;
	layout(offset = 8) mediump ivec2 f;
	layout(offset = 16) mediump vec2 g;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockD.d), -4) && allOk;
	allOk = compare_int((blockD.e), -5) && allOk;
	allOk = compare_vec2((blockD.g), vec2(6.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u8vec2(uvec2(0u, 3u));
	blockC.b = (vec2(-4.0, 8.0));
	blockC.c = (uvec4(3u, 1u, 5u, 7u));
	blockD.d = (-6);
	blockD.f = (ivec2(1, 6));
	blockD.g = (vec2(3.0, -5.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, column_major, buffer_reference) buffer BlockB
{
	mediump ivec4 a;
	highp mat4 b;
	mediump mat4x3 c;
	mediump ivec2 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB[nonuniformEXT(0)].a), ivec4(0, 3, 3, 2)) && allOk;
	allOk = compare_mat4(blockB[nonuniformEXT(0)].b, mat4(0.0, -3.0, 1.0, -5.0, -2.0, -7.0, 3.0, 6.0, 2.0, 3.0, 3.0, 3.0, 5.0, -5.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat4x3(blockB[nonuniformEXT(0)].c, mat4x3(6.0, -8.0, 7.0, -3.0, -9.0, 9.0, 8.0, 2.0, 4.0, -4.0, -4.0, 1.0)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(0)].d), ivec2(9, -1)) && allOk;
	allOk = compare_ivec4((blockB[nonuniformEXT(1)].a), ivec4(6, -9, -2, -2)) && allOk;
	allOk = compare_mat4(blockB[nonuniformEXT(1)].b, mat4(1.0, 7.0, -4.0, -5.0, 9.0, 1.0, 9.0, -8.0, -7.0, -6.0, -3.0, 6.0, 6.0, 1.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat4x3(blockB[nonuniformEXT(1)].c, mat4x3(1.0, 0.0, 9.0, -5.0, -2.0, -3.0, -4.0, -1.0, -6.0, 7.0, -6.0, -8.0)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(1)].d), ivec2(6, 8)) && allOk;
	allOk = compare_ivec4((blockB[nonuniformEXT(2)].a), ivec4(9, 2, 0, -7)) && allOk;
	allOk = compare_mat4(blockB[nonuniformEXT(2)].b, mat4(-6.0, -7.0, 0.0, 4.0, 7.0, 2.0, 5.0, -3.0, 6.0, 7.0, 4.0, 5.0, 8.0, 5.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat4x3(blockB[nonuniformEXT(2)].c, mat4x3(5.0, 8.0, -7.0, -5.0, 7.0, -6.0, 4.0, 9.0, -2.0, 2.0, 3.0, -7.0)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(2)].d), ivec2(-5, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (ivec4(5, -5, 3, 9));
	blockB[nonuniformEXT(0)].b = (mat4(-5.0, -5.0, 0.0, -1.0, -9.0, 2.0, -4.0, -8.0, -4.0, 8.0, 6.0, -3.0, -7.0, -4.0, -2.0, -9.0));
	blockB[nonuniformEXT(0)].c = (mat4x3(-8.0, -5.0, 9.0, -1.0, 1.0, 7.0, 9.0, -8.0, -6.0, 4.0, 8.0, -8.0));
	blockB[nonuniformEXT(0)].d = (ivec2(4, 6));
	blockB[nonuniformEXT(1)].a = (ivec4(-9, 5, 6, 1));
	blockB[nonuniformEXT(1)].b = (mat4(3.0, 0.0, -1.0, -3.0, -8.0, -6.0, 3.0, 2.0, 7.0, 2.0, -9.0, 1.0, -9.0, 6.0, 2.0, -1.0));
	blockB[nonuniformEXT(1)].c = (mat4x3(2.0, -5.0, -8.0, -7.0, 8.0, -9.0, 2.0, -2.0, 3.0, -7.0, 2.0, 0.0));
	blockB[nonuniformEXT(1)].d = (ivec2(4, -1));
	blockB[nonuniformEXT(2)].a = (ivec4(-7, -2, -2, -7));
	blockB[nonuniformEXT(2)].b = (mat4(-8.0, -9.0, -2.0, 6.0, 0.0, -7.0, 3.0, -7.0, -1.0, -5.0, 1.0, 4.0, -3.0, 4.0, 5.0, 0.0));
	blockB[nonuniformEXT(2)].c = (mat4x3(7.0, -5.0, 0.0, -3.0, 0.0, 8.0, -6.0, 4.0, -6.0, -7.0, -6.0, 7.0));
	blockB[nonuniformEXT(2)].d = (ivec2(-6, -5));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, buffer_reference) buffer BlockB
{
	int8_t a;
	mediump mat4x2 b;
	bvec2 c[1];
	highp ivec4 d;
	uint8_t e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB[nonuniformEXT(0)].d), ivec4(-5, -5, 4, -8)) && allOk;
	allOk = compare_uint8_t(uint(blockB[nonuniformEXT(0)].e), 1u) && allOk;
	allOk = compare_ivec4((blockB[nonuniformEXT(1)].d), ivec4(-7, -7, 9, -2)) && allOk;
	allOk = compare_uint8_t(uint(blockB[nonuniformEXT(1)].e), 6u) && allOk;
	allOk = compare_ivec4((blockB[nonuniformEXT(2)].d), ivec4(6, 9, 1, 6)) && allOk;
	allOk = compare_uint8_t(uint(blockB[nonuniformEXT(2)].e), 5u) && allOk;
	allOk = compare_ivec4((blockB[nonuniformEXT(3)].d), ivec4(-9, 1, 1, 8)) && allOk;
	allOk = compare_uint8_t(uint(blockB[nonuniformEXT(3)].e), 5u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = (mat4x2(9.0, -9.0, -1.0, 5.0, 2.0, 5.0, -8.0, -3.0));
	blockB[nonuniformEXT(0)].d = (ivec4(3, -3, 2, -9));
	blockB[nonuniformEXT(0)].e = uint8_t(3u);
	blockB[nonuniformEXT(1)].b = (mat4x2(-3.0, -3.0, 5.0, 1.0, 7.0, 9.0, -3.0, 7.0));
	blockB[nonuniformEXT(1)].d = (ivec4(5, 9, -4, 1));
	blockB[nonuniformEXT(1)].e = uint8_t(8u);
	blockB[nonuniformEXT(2)].b = (mat4x2(-6.0, 2.0, 3.0, -1.0, -3.0, -1.0, 7.0, -8.0));
	blockB[nonuniformEXT(2)].d = (ivec4(7, 4, -5, 3));
	blockB[nonuniformEXT(2)].e = uint8_t(4u);
	blockB[nonuniformEXT(3)].b = (mat4x2(-4.0, -2.0, 2.0, -6.0, 2.0, -7.0, 9.0, -2.0));
	blockB[nonuniformEXT(3)].d = (ivec4(6, 6, -1, -4));
	blockB[nonuniformEXT(3)].e = uint8_t(6u);
}
