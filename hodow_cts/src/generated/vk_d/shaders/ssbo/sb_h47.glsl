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
	lowp mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 8.0) && allOk;
	allOk = compare_float(var[0][1], 5.0) && allOk;
	allOk = compare_float(var[1][0], -3.0) && allOk;
	allOk = compare_float(var[1][1], 1.0) && allOk;
	allOk = compare_vec2(var[0], vec2(8.0, 5.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-3.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2(-1.0, -4.0, -6.0, -5.0));
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
	lowp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], 1.0) && allOk;
	allOk = compare_float(var[0][2], -2.0) && allOk;
	allOk = compare_float(var[0][3], 0.0) && allOk;
	allOk = compare_float(var[1][0], -1.0) && allOk;
	allOk = compare_float(var[1][1], 5.0) && allOk;
	allOk = compare_float(var[1][2], 5.0) && allOk;
	allOk = compare_float(var[1][3], -5.0) && allOk;
	allOk = compare_float(var[2][0], 2.0) && allOk;
	allOk = compare_float(var[2][1], -6.0) && allOk;
	allOk = compare_float(var[2][2], 4.0) && allOk;
	allOk = compare_float(var[2][3], 6.0) && allOk;
	allOk = compare_float(var[3][0], 8.0) && allOk;
	allOk = compare_float(var[3][1], 1.0) && allOk;
	allOk = compare_float(var[3][2], -2.0) && allOk;
	allOk = compare_float(var[3][3], -1.0) && allOk;
	allOk = compare_vec4(var[0], vec4(1.0, 1.0, -2.0, 0.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-1.0, 5.0, 5.0, -5.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(2.0, -6.0, 4.0, 6.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(8.0, 1.0, -2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(3.0, 5.0, -1.0, -5.0));
	var[1] = (vec4(4.0, 2.0, 8.0, -7.0));
	var[2] = (vec4(-2.0, 6.0, -3.0, -1.0));
	var[3] = (vec4(-2.0, 5.0, 7.0, 1.0));
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
	highp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 0.0) && allOk;
	allOk = compare_float(var[0][1], 7.0) && allOk;
	allOk = compare_float(var[0][2], -1.0) && allOk;
	allOk = compare_float(var[0][3], 4.0) && allOk;
	allOk = compare_float(var[1][0], -3.0) && allOk;
	allOk = compare_float(var[1][1], 5.0) && allOk;
	allOk = compare_float(var[1][2], -4.0) && allOk;
	allOk = compare_float(var[1][3], -3.0) && allOk;
	allOk = compare_float(var[2][0], 2.0) && allOk;
	allOk = compare_float(var[2][1], -6.0) && allOk;
	allOk = compare_float(var[2][2], -1.0) && allOk;
	allOk = compare_float(var[2][3], -7.0) && allOk;
	allOk = compare_float(var[3][0], -4.0) && allOk;
	allOk = compare_float(var[3][1], 5.0) && allOk;
	allOk = compare_float(var[3][2], -7.0) && allOk;
	allOk = compare_float(var[3][3], 1.0) && allOk;
	allOk = compare_vec4(var[0], vec4(0.0, 7.0, -1.0, 4.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-3.0, 5.0, -4.0, -3.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(2.0, -6.0, -1.0, -7.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(-4.0, 5.0, -7.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(2.0, 6.0, -8.0, 9.0));
	var[1] = (vec4(-8.0, 4.0, -8.0, 7.0));
	var[2] = (vec4(9.0, -7.0, -2.0, -7.0));
	var[3] = (vec4(0.0, -7.0, 7.0, -8.0));
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
	mediump mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -3.0) && allOk;
	allOk = compare_float(var[0][1], -7.0) && allOk;
	allOk = compare_float(var[0][2], -2.0) && allOk;
	allOk = compare_float(var[1][0], -1.0) && allOk;
	allOk = compare_float(var[1][1], -7.0) && allOk;
	allOk = compare_float(var[1][2], 4.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-3.0, -7.0, -2.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-1.0, -7.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(2.0, 5.0, 6.0));
	var[1] = (vec3(-7.0, 5.0, 4.0));
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
	mediump mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 8.0) && allOk;
	allOk = compare_float(var[0][1], -6.0) && allOk;
	allOk = compare_float(var[0][2], 9.0) && allOk;
	allOk = compare_float(var[0][3], 4.0) && allOk;
	allOk = compare_float(var[1][0], -3.0) && allOk;
	allOk = compare_float(var[1][1], 2.0) && allOk;
	allOk = compare_float(var[1][2], 9.0) && allOk;
	allOk = compare_float(var[1][3], -9.0) && allOk;
	allOk = compare_vec4(var[0], vec4(8.0, -6.0, 9.0, 4.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-3.0, 2.0, 9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2x4(0.0, 1.0, 1.0, 2.0, -2.0, -8.0, -1.0, 8.0));
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

	var[0] = (vec2(-8.0, -2.0));
	var[1] = (vec2(-8.0, -4.0));
	var[2] = (vec2(5.0, 6.0));
	var[3] = (vec2(-2.0, 5.0));
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
	highp mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -9.0) && allOk;
	allOk = compare_float(var[0][1], 2.0) && allOk;
	allOk = compare_float(var[0][2], 5.0) && allOk;
	allOk = compare_float(var[1][0], -8.0) && allOk;
	allOk = compare_float(var[1][1], -5.0) && allOk;
	allOk = compare_float(var[1][2], -3.0) && allOk;
	allOk = compare_float(var[2][0], 2.0) && allOk;
	allOk = compare_float(var[2][1], 8.0) && allOk;
	allOk = compare_float(var[2][2], 6.0) && allOk;
	allOk = compare_float(var[3][0], -8.0) && allOk;
	allOk = compare_float(var[3][1], -1.0) && allOk;
	allOk = compare_float(var[3][2], 6.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-9.0, 2.0, 5.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-8.0, -5.0, -3.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(2.0, 8.0, 6.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(-8.0, -1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(-5.0, -3.0, -4.0));
	var[1] = (vec3(-5.0, 0.0, -1.0));
	var[2] = (vec3(-1.0, 6.0, -4.0));
	var[3] = (vec3(-1.0, -8.0, 6.0));
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
	highp ivec3 var;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((var), ivec3(-4, 5, 7)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (ivec3(5, -5, 0));
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
	highp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 8.0) && allOk;
	allOk = compare_float(var[0][1], 1.0) && allOk;
	allOk = compare_float(var[0][2], 6.0) && allOk;
	allOk = compare_float(var[1][0], 7.0) && allOk;
	allOk = compare_float(var[1][1], 7.0) && allOk;
	allOk = compare_float(var[1][2], 1.0) && allOk;
	allOk = compare_float(var[2][0], -8.0) && allOk;
	allOk = compare_float(var[2][1], -2.0) && allOk;
	allOk = compare_float(var[2][2], 3.0) && allOk;
	allOk = compare_vec3(var[0], vec3(8.0, 1.0, 6.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(7.0, 7.0, 1.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-8.0, -2.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3(9.0, 3.0, -1.0, -3.0, -3.0, 5.0, -5.0, 2.0, -7.0));
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
	lowp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var, mat2x3(5.0, -7.0, -1.0, -7.0, -8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(4.0, 9.0, -4.0));
	var[1] = (vec3(1.0, 8.0, 1.0));
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
	highp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var, mat3x2(-6.0, -5.0, -4.0, -5.0, 2.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3x2(-1.0, -3.0, -4.0, 9.0, -7.0, -6.0));
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
	lowp mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -9.0) && allOk;
	allOk = compare_float(var[0][1], 1.0) && allOk;
	allOk = compare_float(var[0][2], -9.0) && allOk;
	allOk = compare_float(var[1][0], 9.0) && allOk;
	allOk = compare_float(var[1][1], -2.0) && allOk;
	allOk = compare_float(var[1][2], -2.0) && allOk;
	allOk = compare_float(var[2][0], -4.0) && allOk;
	allOk = compare_float(var[2][1], -2.0) && allOk;
	allOk = compare_float(var[2][2], -9.0) && allOk;
	allOk = compare_float(var[3][0], -7.0) && allOk;
	allOk = compare_float(var[3][1], 0.0) && allOk;
	allOk = compare_float(var[3][2], -6.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-9.0, 1.0, -9.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(9.0, -2.0, -2.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-4.0, -2.0, -9.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(-7.0, 0.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(-9.0, 6.0, -2.0));
	var[1] = (vec3(-9.0, 9.0, -9.0));
	var[2] = (vec3(6.0, 9.0, -6.0));
	var[3] = (vec3(-2.0, 0.0, -9.0));
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
	int8_t var;
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(var), 4294967292) && allOk;
    if (allOk)
        ac_numPassed++;

	var = int8_t(4294967290);
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

	padding = (2.0);
	var[0] = (vec3(8.0, -3.0, 1.0));
	var[1] = (vec3(-8.0, -5.0, 3.0));
	var[2] = (vec3(-4.0, 5.0, -7.0));
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
	mediump mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_mat3(var, mat3(1.0, -6.0, 5.0, 1.0, 0.0, -8.0, -1.0, -9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-1.0);
	var[0] = (vec3(-4.0, 0.0, 5.0));
	var[1] = (vec3(5.0, 5.0, -8.0));
	var[2] = (vec3(-1.0, 4.0, -9.0));
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
	float padding;
	highp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_float(var[0][0], -6.0) && allOk;
	allOk = compare_float(var[0][1], -4.0) && allOk;
	allOk = compare_float(var[0][2], 5.0) && allOk;
	allOk = compare_float(var[1][0], 0.0) && allOk;
	allOk = compare_float(var[1][1], -1.0) && allOk;
	allOk = compare_float(var[1][2], 1.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-6.0, -4.0, 5.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(0.0, -1.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (3.0);
	var = (mat2x3(0.0, 3.0, 5.0, 3.0, -5.0, -5.0));
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
	float padding;
	mediump mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat3x2(var, mat3x2(-2.0, 2.0, -8.0, -6.0, -2.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (1.0);
	var[0] = (vec2(-9.0, -5.0));
	var[1] = (vec2(5.0, 6.0));
	var[2] = (vec2(5.0, 7.0));
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
	int16_t padding;
	i16vec3 var;
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(padding), 3) && allOk;
	allOk = compare_i16vec3(ivec3(var), ivec3(4, 8, 7)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = int16_t(6);
	var = i16vec3(ivec3(1, -2, -3));
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
	highp mat3x4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0], mat3x4(-3.0, -9.0, 3.0, -6.0, -7.0, 8.0, -8.0, -5.0, 9.0, -8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(8.0, -4.0, 9.0, 7.0, -8.0, 9.0, -1.0, 0.0, 9.0, 7.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(-3.0, -6.0, -7.0, 8.0, 1.0, 5.0, 1.0, -1.0, 8.0, -9.0, 7.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec4(-6.0, -4.0, 2.0, -3.0));
	var[0][1] = (vec4(-2.0, 4.0, -5.0, 8.0));
	var[0][2] = (vec4(-4.0, 6.0, -9.0, -9.0));
	var[1][0] = (vec4(0.0, 6.0, 0.0, 6.0));
	var[1][1] = (vec4(5.0, 2.0, 6.0, 6.0));
	var[1][2] = (vec4(-7.0, -6.0, -8.0, 0.0));
	var[2][0] = (vec4(3.0, -3.0, 6.0, -2.0));
	var[2][1] = (vec4(-8.0, -5.0, -5.0, 1.0));
	var[2][2] = (vec4(7.0, -8.0, -3.0, -2.0));
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
	highp ivec4 var[3];
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((var[0]), ivec4(-7, 9, -5, 6)) && allOk;
	allOk = compare_ivec4((var[1]), ivec4(3, 4, 2, -3)) && allOk;
	allOk = compare_ivec4((var[2]), ivec4(-3, -3, -5, -5)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (ivec4(5, -9, 5, -6));
	var[1] = (ivec4(-2, -4, 1, -9));
	var[2] = (ivec4(7, 3, 6, 8));
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
	bvec4 var[3];
};

bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((var[0]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((var[1]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((var[2]), bvec4(false, false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (bvec4(true, true, true, false));
	var[1] = (bvec4(true, false, false, false));
	var[2] = (bvec4(false, true, true, true));
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
	highp mat4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0], mat4(1.0, 6.0, 7.0, 5.0, 2.0, -4.0, 0.0, 8.0, 3.0, 3.0, 9.0, 8.0, -2.0, 7.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(-1.0, 1.0, 9.0, 1.0, -2.0, -7.0, 3.0, 5.0, 2.0, -8.0, 8.0, -1.0, -4.0, -5.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(-9.0, 1.0, 1.0, -6.0, 5.0, -8.0, -6.0, -3.0, -4.0, 8.0, 9.0, -9.0, -4.0, -2.0, -8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec4(-3.0, -6.0, 8.0, 7.0));
	var[0][1] = (vec4(-8.0, 6.0, 1.0, -6.0));
	var[0][2] = (vec4(6.0, 0.0, -6.0, 3.0));
	var[0][3] = (vec4(3.0, 3.0, -3.0, 2.0));
	var[1][0] = (vec4(-8.0, 9.0, -6.0, 6.0));
	var[1][1] = (vec4(1.0, 9.0, -7.0, 4.0));
	var[1][2] = (vec4(-5.0, 5.0, -6.0, 5.0));
	var[1][3] = (vec4(7.0, 7.0, -5.0, -9.0));
	var[2][0] = (vec4(7.0, -2.0, -1.0, -4.0));
	var[2][1] = (vec4(-3.0, 3.0, -8.0, 7.0));
	var[2][2] = (vec4(-8.0, -5.0, -9.0, -1.0));
	var[2][3] = (vec4(0.0, -7.0, 7.0, 8.0));
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
	highp mat2x4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0], mat2x4(3.0, -4.0, 9.0, -7.0, -8.0, 2.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(-7.0, 8.0, -9.0, 4.0, 4.0, -9.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(9.0, -5.0, -4.0, -8.0, -6.0, -2.0, 3.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat2x4(5.0, -1.0, 5.0, 1.0, 1.0, -4.0, 0.0, -8.0));
	var[1] = (mat2x4(-3.0, 9.0, -8.0, -9.0, 1.0, 9.0, 1.0, -2.0));
	var[2] = (mat2x4(-6.0, 3.0, -3.0, -7.0, -6.0, 0.0, 9.0, -7.0));
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
	float padding;
	highp mat4x3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat4x3(var[0], mat4x3(1.0, 0.0, 0.0, -7.0, 2.0, 5.0, 0.0, 3.0, 2.0, 4.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(-5.0, 2.0, 0.0, -1.0, -5.0, 5.0, 5.0, 9.0, -7.0, 5.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(6.0, -7.0, 7.0, 8.0, 6.0, -7.0, -8.0, -5.0, -9.0, -4.0, -9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (7.0);
	var[0] = (mat4x3(8.0, 8.0, -3.0, -9.0, 2.0, -6.0, 0.0, -4.0, -3.0, 4.0, -8.0, 4.0));
	var[1] = (mat4x3(-2.0, 2.0, 8.0, 4.0, -1.0, -8.0, -6.0, -4.0, 9.0, -2.0, 1.0, -7.0));
	var[2] = (mat4x3(-4.0, -4.0, -1.0, 7.0, -6.0, 4.0, 6.0, 7.0, -9.0, -8.0, 3.0, -6.0));
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
	highp mat3x4 var[];
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
	allOk = compare_mat3x4(var[3], mat3x4(8.0, -1.0, -7.0, 5.0, -9.0, 3.0, -2.0, -3.0, 3.0, -3.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[4], mat3x4(-3.0, -9.0, -1.0, -5.0, -4.0, -4.0, -6.0, 0.0, -3.0, -5.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[5], mat3x4(-2.0, -4.0, 8.0, 3.0, -8.0, -8.0, 6.0, -5.0, -9.0, -1.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[6], mat3x4(-9.0, -4.0, -3.0, -7.0, 2.0, -1.0, 8.0, -1.0, 3.0, -7.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[7], mat3x4(-1.0, 9.0, 2.0, 4.0, 6.0, -7.0, -6.0, 4.0, -4.0, 5.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[8], mat3x4(-2.0, 2.0, 0.0, 4.0, 8.0, 7.0, -4.0, -1.0, -4.0, -9.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[9], mat3x4(0.0, 2.0, -8.0, 5.0, -6.0, 3.0, 1.0, -5.0, -3.0, -6.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[10], mat3x4(4.0, 1.0, 9.0, 2.0, -4.0, -7.0, 1.0, 3.0, 1.0, -2.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[11], mat3x4(8.0, -5.0, -5.0, 4.0, 9.0, 5.0, -5.0, -3.0, 9.0, 0.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[12], mat3x4(3.0, 8.0, 5.0, 9.0, 4.0, 6.0, 7.0, 0.0, 4.0, 7.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[13], mat3x4(8.0, -7.0, -1.0, 4.0, -8.0, -5.0, 3.0, 6.0, 4.0, -1.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[14], mat3x4(6.0, -2.0, -4.0, 2.0, -1.0, -5.0, -1.0, -2.0, 9.0, 8.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[15], mat3x4(-9.0, 3.0, 2.0, 5.0, -9.0, -1.0, -7.0, 5.0, -3.0, -9.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[16], mat3x4(7.0, 3.0, 5.0, 9.0, -3.0, -2.0, -1.0, 5.0, -5.0, -7.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[17], mat3x4(2.0, 0.0, -7.0, 6.0, 9.0, -6.0, -1.0, 6.0, 6.0, 4.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[18], mat3x4(8.0, 9.0, 2.0, 2.0, 6.0, -3.0, 4.0, -7.0, 0.0, 1.0, 6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3x4(-8.0, -6.0, 4.0, -9.0, 7.0, -4.0, -7.0, 0.0, -6.0, -6.0, -3.0, 4.0));
	var[1] = (mat3x4(3.0, -2.0, -3.0, 4.0, 2.0, 8.0, 2.0, -4.0, 9.0, -1.0, 9.0, 7.0));
	var[2] = (mat3x4(1.0, -1.0, 1.0, 5.0, 5.0, -4.0, -7.0, -4.0, 0.0, 6.0, 2.0, 0.0));
	var[3] = (mat3x4(-6.0, 7.0, -1.0, 6.0, 4.0, -9.0, -9.0, -1.0, -8.0, 4.0, -6.0, 6.0));
	var[4] = (mat3x4(7.0, -8.0, -5.0, -9.0, -9.0, -2.0, 4.0, 1.0, -3.0, 3.0, -2.0, 2.0));
	var[5] = (mat3x4(-1.0, 2.0, -4.0, -7.0, 9.0, 2.0, -7.0, -8.0, -2.0, -3.0, 3.0, -4.0));
	var[6] = (mat3x4(6.0, 6.0, -8.0, 6.0, 2.0, 8.0, -6.0, 2.0, -8.0, 2.0, 6.0, 9.0));
	var[7] = (mat3x4(3.0, -3.0, 9.0, -1.0, 6.0, 2.0, -8.0, 0.0, 1.0, 1.0, -3.0, 0.0));
	var[8] = (mat3x4(9.0, 4.0, -6.0, 6.0, 2.0, 1.0, 9.0, -3.0, -3.0, -6.0, -6.0, -8.0));
	var[9] = (mat3x4(5.0, 0.0, -6.0, 3.0, 0.0, -8.0, 3.0, 9.0, -6.0, -2.0, 5.0, -8.0));
	var[10] = (mat3x4(0.0, -3.0, -8.0, 2.0, 8.0, 8.0, -1.0, 4.0, -6.0, 8.0, 9.0, 8.0));
	var[11] = (mat3x4(5.0, 7.0, 3.0, 7.0, 9.0, 9.0, 6.0, 5.0, 3.0, 5.0, 2.0, -8.0));
	var[12] = (mat3x4(9.0, -2.0, 8.0, -4.0, 8.0, 4.0, 3.0, -3.0, 3.0, -5.0, 7.0, -8.0));
	var[13] = (mat3x4(5.0, -3.0, 8.0, 6.0, 1.0, 6.0, -2.0, -6.0, 0.0, 1.0, 3.0, 3.0));
	var[14] = (mat3x4(-3.0, 0.0, -3.0, 5.0, -4.0, -5.0, 1.0, -5.0, -5.0, 0.0, 0.0, -6.0));
	var[15] = (mat3x4(4.0, 6.0, -7.0, 7.0, 3.0, 6.0, 4.0, -7.0, 8.0, -1.0, 3.0, 3.0));
	var[16] = (mat3x4(-1.0, 0.0, -1.0, 5.0, 3.0, -9.0, 6.0, 8.0, -9.0, -5.0, -1.0, 1.0));
	var[17] = (mat3x4(-1.0, -4.0, 7.0, 7.0, 5.0, -7.0, 1.0, 3.0, 6.0, 3.0, -3.0, -9.0));
	var[18] = (mat3x4(3.0, -7.0, -1.0, 2.0, -7.0, -9.0, 4.0, 1.0, -9.0, 4.0, 5.0, -1.0));
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
	highp mat2 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0], mat2(8.0, -8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(0.0, -4.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(-7.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2(var[3], mat2(0.0, 6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2(var[4], mat2(-4.0, -1.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2(var[5], mat2(-1.0, 4.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat2(var[6], mat2(-7.0, 8.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat2(var[7], mat2(-9.0, -8.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2(var[8], mat2(-4.0, -9.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2(var[9], mat2(1.0, -9.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat2(var[10], mat2(-9.0, -7.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2(var[11], mat2(-9.0, 2.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2(var[12], mat2(-2.0, -4.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2(var[13], mat2(4.0, -3.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2(var[14], mat2(-5.0, -3.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat2(var[15], mat2(8.0, -9.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2(var[16], mat2(1.0, 1.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat2(var[17], mat2(-6.0, 1.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2(var[18], mat2(7.0, -2.0, -8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec2(-3.0, 3.0));
	var[0][1] = (vec2(4.0, 4.0));
	var[1][0] = (vec2(9.0, -9.0));
	var[1][1] = (vec2(-5.0, 8.0));
	var[2][0] = (vec2(0.0, 4.0));
	var[2][1] = (vec2(2.0, -4.0));
	var[3][0] = (vec2(-3.0, 3.0));
	var[3][1] = (vec2(-8.0, -7.0));
	var[4][0] = (vec2(-7.0, -6.0));
	var[4][1] = (vec2(-2.0, 1.0));
	var[5][0] = (vec2(-4.0, 3.0));
	var[5][1] = (vec2(0.0, 7.0));
	var[6][0] = (vec2(-7.0, -5.0));
	var[6][1] = (vec2(6.0, -6.0));
	var[7][0] = (vec2(-4.0, 0.0));
	var[7][1] = (vec2(2.0, 3.0));
	var[8][0] = (vec2(-2.0, -4.0));
	var[8][1] = (vec2(-1.0, 1.0));
	var[9][0] = (vec2(8.0, -9.0));
	var[9][1] = (vec2(8.0, -6.0));
	var[10][0] = (vec2(7.0, -2.0));
	var[10][1] = (vec2(1.0, -2.0));
	var[11][0] = (vec2(-7.0, -6.0));
	var[11][1] = (vec2(8.0, -4.0));
	var[12][0] = (vec2(-3.0, -8.0));
	var[12][1] = (vec2(-4.0, -7.0));
	var[13][0] = (vec2(-9.0, 5.0));
	var[13][1] = (vec2(5.0, -6.0));
	var[14][0] = (vec2(4.0, -1.0));
	var[14][1] = (vec2(-3.0, -8.0));
	var[15][0] = (vec2(1.0, -2.0));
	var[15][1] = (vec2(-6.0, -3.0));
	var[16][0] = (vec2(-5.0, 4.0));
	var[16][1] = (vec2(-7.0, -6.0));
	var[17][0] = (vec2(1.0, -9.0));
	var[17][1] = (vec2(7.0, -1.0));
	var[18][0] = (vec2(-6.0, -1.0));
	var[18][1] = (vec2(9.0, -5.0));
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
	highp mat3x2 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0], mat3x2(-2.0, -4.0, -6.0, 5.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(2.0, 5.0, 9.0, -1.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(-6.0, -2.0, -3.0, 2.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[3], mat3x2(-8.0, -4.0, -9.0, 9.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[4], mat3x2(0.0, 4.0, -7.0, -7.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[5], mat3x2(7.0, 1.0, 4.0, 8.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[6], mat3x2(-5.0, 4.0, 3.0, -8.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[7], mat3x2(4.0, -7.0, -6.0, 9.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[8], mat3x2(3.0, 0.0, -6.0, 7.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[9], mat3x2(-1.0, 5.0, -6.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[10], mat3x2(-4.0, 8.0, 9.0, -3.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[11], mat3x2(-8.0, -9.0, -6.0, -9.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[12], mat3x2(-5.0, -1.0, -4.0, 9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[13], mat3x2(1.0, -6.0, -3.0, -3.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[14], mat3x2(1.0, 7.0, 5.0, -5.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[15], mat3x2(-8.0, -9.0, 7.0, 4.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[16], mat3x2(8.0, -6.0, -5.0, -7.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[17], mat3x2(3.0, 2.0, -1.0, -1.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[18], mat3x2(-1.0, 2.0, -7.0, 2.0, -8.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3x2(2.0, -1.0, 2.0, -8.0, -4.0, 9.0));
	var[1] = (mat3x2(6.0, 8.0, 5.0, -7.0, -7.0, 0.0));
	var[2] = (mat3x2(5.0, 8.0, 1.0, -4.0, 1.0, 3.0));
	var[3] = (mat3x2(0.0, -6.0, -9.0, 0.0, 8.0, 7.0));
	var[4] = (mat3x2(7.0, -7.0, 8.0, -7.0, -8.0, 9.0));
	var[5] = (mat3x2(-5.0, -9.0, -9.0, -4.0, 7.0, 7.0));
	var[6] = (mat3x2(3.0, -9.0, -7.0, 4.0, -8.0, -2.0));
	var[7] = (mat3x2(9.0, -1.0, 9.0, 7.0, 0.0, 3.0));
	var[8] = (mat3x2(-6.0, 5.0, -8.0, 1.0, 9.0, 5.0));
	var[9] = (mat3x2(-4.0, -3.0, -2.0, 3.0, -1.0, 1.0));
	var[10] = (mat3x2(-9.0, 4.0, 5.0, -3.0, 8.0, 4.0));
	var[11] = (mat3x2(8.0, -4.0, -8.0, 7.0, -4.0, 9.0));
	var[12] = (mat3x2(-6.0, -4.0, 8.0, 4.0, 5.0, 4.0));
	var[13] = (mat3x2(8.0, 3.0, 9.0, -4.0, -3.0, -6.0));
	var[14] = (mat3x2(-9.0, 8.0, 6.0, -7.0, 9.0, 2.0));
	var[15] = (mat3x2(-2.0, -3.0, -2.0, -4.0, 5.0, -4.0));
	var[16] = (mat3x2(9.0, -9.0, -9.0, -6.0, 8.0, 1.0));
	var[17] = (mat3x2(4.0, -2.0, 0.0, -9.0, 4.0, -2.0));
	var[18] = (mat3x2(3.0, 2.0, 8.0, -9.0, -3.0, -7.0));
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
	highp mat4x3 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0], mat4x3(5.0, 0.0, 3.0, -5.0, 9.0, -6.0, 8.0, -6.0, 6.0, 2.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(1.0, 7.0, 3.0, 4.0, 6.0, 2.0, -7.0, -9.0, -6.0, 1.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(4.0, -7.0, -2.0, 5.0, -7.0, 6.0, 7.0, 1.0, -4.0, -7.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[3], mat4x3(8.0, 0.0, -3.0, -3.0, 9.0, 2.0, -6.0, 4.0, 1.0, -1.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[4], mat4x3(7.0, -3.0, -4.0, 9.0, 3.0, 6.0, -1.0, -1.0, 6.0, -7.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[5], mat4x3(7.0, -9.0, -5.0, 9.0, 7.0, -1.0, -2.0, 7.0, -2.0, 0.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[6], mat4x3(-6.0, 1.0, 5.0, 9.0, -2.0, 8.0, 4.0, 6.0, -1.0, -2.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[7], mat4x3(5.0, -5.0, -3.0, 4.0, -3.0, -5.0, 8.0, 4.0, -8.0, -2.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[8], mat4x3(-6.0, -4.0, 6.0, -4.0, -8.0, 2.0, 3.0, -2.0, 0.0, -4.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[9], mat4x3(7.0, 4.0, -7.0, 3.0, 5.0, 4.0, 0.0, -1.0, 2.0, 6.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[10], mat4x3(-8.0, -7.0, -4.0, 9.0, 4.0, -9.0, -4.0, 2.0, -6.0, -4.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[11], mat4x3(-2.0, 3.0, 5.0, 2.0, -4.0, -5.0, -2.0, 4.0, 4.0, -3.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[12], mat4x3(6.0, -5.0, -6.0, 6.0, 3.0, -1.0, 3.0, 3.0, 7.0, 3.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[13], mat4x3(-8.0, 2.0, 5.0, -7.0, 6.0, -6.0, -4.0, 3.0, 5.0, 1.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[14], mat4x3(-3.0, 2.0, 2.0, -2.0, -2.0, 2.0, 5.0, 6.0, 3.0, -8.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[15], mat4x3(-8.0, -7.0, 6.0, 1.0, 0.0, -2.0, -9.0, 5.0, 0.0, 5.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[16], mat4x3(9.0, 5.0, 6.0, 9.0, -3.0, -5.0, -4.0, -2.0, 3.0, -9.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[17], mat4x3(5.0, -9.0, -3.0, 8.0, -8.0, 6.0, 6.0, 8.0, -6.0, 5.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[18], mat4x3(9.0, 7.0, 1.0, 2.0, 8.0, 4.0, 2.0, -2.0, 1.0, 2.0, -9.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4x3(6.0, -7.0, 0.0, 3.0, -1.0, -9.0, -7.0, -5.0, 8.0, 0.0, 1.0, 5.0));
	var[1] = (mat4x3(7.0, 1.0, 5.0, 7.0, -8.0, 4.0, 2.0, -8.0, -8.0, 3.0, -6.0, -5.0));
	var[2] = (mat4x3(5.0, -7.0, 8.0, -7.0, -3.0, -4.0, -9.0, -9.0, -6.0, 5.0, -8.0, 1.0));
	var[3] = (mat4x3(-2.0, 3.0, -2.0, -9.0, 2.0, 9.0, -2.0, 8.0, -8.0, -8.0, -7.0, -5.0));
	var[4] = (mat4x3(7.0, -4.0, -6.0, -5.0, 0.0, 0.0, -6.0, -5.0, 1.0, 9.0, -4.0, -9.0));
	var[5] = (mat4x3(-5.0, 7.0, 2.0, 6.0, -1.0, -7.0, -9.0, -4.0, 5.0, -4.0, -3.0, 3.0));
	var[6] = (mat4x3(-6.0, 0.0, 1.0, -1.0, 4.0, 2.0, 0.0, -8.0, 7.0, -3.0, 1.0, -7.0));
	var[7] = (mat4x3(3.0, 8.0, 6.0, 5.0, 6.0, -2.0, -7.0, -5.0, 0.0, -4.0, -8.0, 5.0));
	var[8] = (mat4x3(3.0, -9.0, -8.0, -7.0, 3.0, 3.0, 3.0, -7.0, -5.0, -9.0, -1.0, -8.0));
	var[9] = (mat4x3(6.0, -5.0, 6.0, -8.0, -2.0, -6.0, 9.0, 0.0, 8.0, -9.0, -7.0, 1.0));
	var[10] = (mat4x3(8.0, -5.0, 0.0, -7.0, -6.0, 2.0, 0.0, -8.0, 1.0, -5.0, -9.0, -2.0));
	var[11] = (mat4x3(1.0, 0.0, 8.0, -8.0, 6.0, 7.0, 6.0, 2.0, 0.0, 3.0, -4.0, -6.0));
	var[12] = (mat4x3(-6.0, 9.0, 3.0, 4.0, 2.0, -2.0, -4.0, 3.0, 0.0, 4.0, -2.0, 0.0));
	var[13] = (mat4x3(6.0, -8.0, 4.0, 9.0, 3.0, 0.0, -8.0, -3.0, 5.0, 5.0, 7.0, 7.0));
	var[14] = (mat4x3(-1.0, -4.0, -7.0, -7.0, 7.0, 9.0, -7.0, 3.0, 7.0, -6.0, -6.0, 8.0));
	var[15] = (mat4x3(7.0, -7.0, -8.0, -3.0, 8.0, -1.0, -8.0, 2.0, -9.0, 9.0, 0.0, -7.0));
	var[16] = (mat4x3(-4.0, -2.0, 9.0, 2.0, -9.0, 7.0, 0.0, -4.0, 0.0, -3.0, 4.0, -6.0));
	var[17] = (mat4x3(9.0, -7.0, 9.0, 4.0, -8.0, 9.0, 0.0, -6.0, -6.0, 4.0, 4.0, 3.0));
	var[18] = (mat4x3(-9.0, -6.0, -4.0, -8.0, 0.0, 1.0, -9.0, -8.0, 1.0, 6.0, 3.0, -7.0));
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

	var[0] = u16vec4(uvec4(0u, 6u, 9u, 4u));
	var[1] = u16vec4(uvec4(5u, 0u, 1u, 0u));
	var[2] = u16vec4(uvec4(7u, 6u, 5u, 9u));
	var[3] = u16vec4(uvec4(8u, 3u, 6u, 1u));
	var[4] = u16vec4(uvec4(7u, 9u, 3u, 8u));
	var[5] = u16vec4(uvec4(1u, 4u, 3u, 9u));
	var[6] = u16vec4(uvec4(9u, 3u, 0u, 2u));
	var[7] = u16vec4(uvec4(3u, 5u, 0u, 2u));
	var[8] = u16vec4(uvec4(5u, 1u, 5u, 5u));
	var[9] = u16vec4(uvec4(4u, 0u, 8u, 4u));
	var[10] = u16vec4(uvec4(0u, 3u, 7u, 1u));
	var[11] = u16vec4(uvec4(1u, 8u, 4u, 7u));
	var[12] = u16vec4(uvec4(6u, 9u, 4u, 2u));
	var[13] = u16vec4(uvec4(9u, 7u, 6u, 2u));
	var[14] = u16vec4(uvec4(8u, 4u, 6u, 2u));
	var[15] = u16vec4(uvec4(2u, 1u, 0u, 1u));
	var[16] = u16vec4(uvec4(9u, 9u, 4u, 6u));
	var[17] = u16vec4(uvec4(4u, 4u, 2u, 8u));
	var[18] = u16vec4(uvec4(7u, 8u, 2u, 8u));
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
	highp mat2x3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0][0], mat2x3(2.0, 5.0, 1.0, 7.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[0][1], mat2x3(3.0, 6.0, -3.0, 8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[0][2], mat2x3(-5.0, -2.0, 6.0, -5.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[1][0], mat2x3(3.0, 6.0, 4.0, 8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[1][1], mat2x3(-7.0, 3.0, -5.0, 2.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[1][2], mat2x3(2.0, 6.0, -6.0, -7.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[2][0], mat2x3(-9.0, 5.0, -2.0, -8.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[2][1], mat2x3(-4.0, 0.0, 4.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[2][2], mat2x3(1.0, -6.0, -1.0, -2.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[3][0], mat2x3(3.0, -1.0, 1.0, 5.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[3][1], mat2x3(-9.0, 3.0, -4.0, 4.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[3][2], mat2x3(6.0, -9.0, -8.0, 0.0, 3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec3(1.0, -1.0, 1.0));
	var[0][0][1] = (vec3(-3.0, 9.0, -8.0));
	var[0][1][0] = (vec3(-5.0, 6.0, 6.0));
	var[0][1][1] = (vec3(3.0, -3.0, 7.0));
	var[0][2][0] = (vec3(-9.0, -2.0, -7.0));
	var[0][2][1] = (vec3(7.0, 0.0, -8.0));
	var[1][0][0] = (vec3(0.0, -5.0, 5.0));
	var[1][0][1] = (vec3(-2.0, 4.0, -8.0));
	var[1][1][0] = (vec3(-3.0, -4.0, 7.0));
	var[1][1][1] = (vec3(-3.0, -1.0, -9.0));
	var[1][2][0] = (vec3(2.0, -3.0, 6.0));
	var[1][2][1] = (vec3(-4.0, 8.0, 2.0));
	var[2][0][0] = (vec3(6.0, -2.0, 0.0));
	var[2][0][1] = (vec3(3.0, 4.0, -6.0));
	var[2][1][0] = (vec3(3.0, -6.0, 2.0));
	var[2][1][1] = (vec3(4.0, -8.0, 0.0));
	var[2][2][0] = (vec3(-3.0, 3.0, 5.0));
	var[2][2][1] = (vec3(-6.0, -8.0, 8.0));
	var[3][0][0] = (vec3(4.0, -9.0, -1.0));
	var[3][0][1] = (vec3(-6.0, 7.0, -3.0));
	var[3][1][0] = (vec3(2.0, -2.0, 4.0));
	var[3][1][1] = (vec3(-3.0, -5.0, 9.0));
	var[3][2][0] = (vec3(-8.0, -1.0, 7.0));
	var[3][2][1] = (vec3(2.0, 0.0, 5.0));
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
	highp mat2x3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0][0][0], mat2x3(-3.0, 6.0, -6.0, -6.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][1], mat2x3(8.0, 3.0, 1.0, 4.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][2], mat2x3(-7.0, -5.0, -8.0, -7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][0], mat2x3(-5.0, 3.0, -2.0, -8.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][1], mat2x3(1.0, -5.0, -5.0, -2.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][2], mat2x3(-2.0, 0.0, 7.0, 6.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][0], mat2x3(3.0, 6.0, -5.0, 3.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][1], mat2x3(9.0, 2.0, 6.0, 8.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][2], mat2x3(-7.0, -2.0, -4.0, -2.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][0], mat2x3(3.0, 9.0, 1.0, 3.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][1], mat2x3(-9.0, -2.0, 6.0, 8.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][2], mat2x3(5.0, -2.0, 0.0, 0.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][0], mat2x3(6.0, 8.0, -4.0, -5.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][1], mat2x3(6.0, 6.0, -9.0, -2.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][2], mat2x3(5.0, -3.0, 6.0, 3.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][0], mat2x3(-2.0, -7.0, 9.0, 9.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][1], mat2x3(0.0, -6.0, -7.0, 2.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][2], mat2x3(3.0, 6.0, -6.0, -5.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][0], mat2x3(-9.0, -2.0, -3.0, -1.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][1], mat2x3(0.0, 2.0, -1.0, -4.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][2], mat2x3(-9.0, -7.0, 7.0, 0.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][0], mat2x3(7.0, 0.0, -9.0, 4.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][1], mat2x3(-9.0, 8.0, 7.0, -9.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][2], mat2x3(-9.0, 3.0, 1.0, -2.0, 9.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2x3(-1.0, -2.0, -5.0, 0.0, 7.0, -2.0));
	var[0][0][1] = (mat2x3(0.0, 9.0, 9.0, 8.0, -6.0, 3.0));
	var[0][0][2] = (mat2x3(-9.0, 0.0, 1.0, 1.0, 7.0, -8.0));
	var[0][1][0] = (mat2x3(-9.0, 1.0, 2.0, -3.0, 0.0, -3.0));
	var[0][1][1] = (mat2x3(-2.0, 3.0, -2.0, 5.0, -6.0, -7.0));
	var[0][1][2] = (mat2x3(-7.0, 3.0, -4.0, -6.0, -2.0, 6.0));
	var[1][0][0] = (mat2x3(7.0, -4.0, 4.0, -5.0, -1.0, 0.0));
	var[1][0][1] = (mat2x3(2.0, -5.0, 6.0, 7.0, -2.0, 4.0));
	var[1][0][2] = (mat2x3(-3.0, 7.0, 6.0, -3.0, -2.0, -6.0));
	var[1][1][0] = (mat2x3(-7.0, -3.0, 3.0, -9.0, 3.0, 8.0));
	var[1][1][1] = (mat2x3(-1.0, 7.0, 4.0, -9.0, -7.0, 2.0));
	var[1][1][2] = (mat2x3(1.0, -7.0, -2.0, 5.0, -6.0, -6.0));
	var[2][0][0] = (mat2x3(7.0, -3.0, 2.0, 8.0, -1.0, 2.0));
	var[2][0][1] = (mat2x3(2.0, -9.0, 3.0, 1.0, -7.0, -7.0));
	var[2][0][2] = (mat2x3(3.0, -3.0, -5.0, 4.0, -6.0, 8.0));
	var[2][1][0] = (mat2x3(-1.0, -2.0, 6.0, 9.0, 1.0, -6.0));
	var[2][1][1] = (mat2x3(6.0, 6.0, 5.0, 3.0, 4.0, 7.0));
	var[2][1][2] = (mat2x3(0.0, 9.0, -5.0, 3.0, -7.0, 1.0));
	var[3][0][0] = (mat2x3(7.0, -9.0, 2.0, -8.0, 9.0, 9.0));
	var[3][0][1] = (mat2x3(3.0, 5.0, 8.0, 5.0, -7.0, 6.0));
	var[3][0][2] = (mat2x3(3.0, 6.0, 6.0, 1.0, 2.0, -7.0));
	var[3][1][0] = (mat2x3(0.0, 6.0, 0.0, 6.0, 4.0, -1.0));
	var[3][1][1] = (mat2x3(-2.0, 2.0, 3.0, 8.0, 3.0, -5.0));
	var[3][1][2] = (mat2x3(1.0, -6.0, -1.0, 5.0, 9.0, -6.0));
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
	highp mat4x2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0][0][0], mat4x2(-7.0, 1.0, 9.0, 3.0, -9.0, -1.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][1], mat4x2(-9.0, 6.0, 5.0, -8.0, 8.0, 9.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][2], mat4x2(4.0, 1.0, -1.0, -5.0, 5.0, -9.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][0], mat4x2(3.0, -1.0, -8.0, -1.0, -7.0, -8.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][1], mat4x2(0.0, -8.0, -7.0, 7.0, 3.0, 7.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][2], mat4x2(-7.0, 7.0, -7.0, -4.0, -2.0, -5.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][0], mat4x2(-2.0, -2.0, -9.0, -2.0, -2.0, 8.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][1], mat4x2(-8.0, 6.0, -4.0, 7.0, 2.0, 3.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][2], mat4x2(7.0, 3.0, 5.0, -2.0, 7.0, 1.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][0], mat4x2(3.0, -9.0, 6.0, -8.0, 0.0, 5.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][1], mat4x2(-2.0, 0.0, 9.0, -8.0, 0.0, 5.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][2], mat4x2(9.0, 1.0, 2.0, -6.0, -9.0, -9.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][0], mat4x2(-5.0, -9.0, 1.0, -6.0, 3.0, -3.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][1], mat4x2(4.0, -4.0, -1.0, 4.0, 0.0, -4.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][2], mat4x2(-7.0, 4.0, 5.0, 4.0, -5.0, 8.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][0], mat4x2(-8.0, 9.0, -5.0, -6.0, -1.0, 1.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][1], mat4x2(8.0, -1.0, -7.0, -7.0, -9.0, -4.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][2], mat4x2(-6.0, -7.0, -8.0, 6.0, -7.0, -6.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][0], mat4x2(-7.0, 5.0, -2.0, -3.0, 7.0, 4.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][1], mat4x2(-4.0, 7.0, 2.0, 3.0, -7.0, -8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][2], mat4x2(-1.0, -8.0, -8.0, 4.0, 6.0, 8.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][0], mat4x2(8.0, -2.0, 9.0, -6.0, 5.0, -1.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][1], mat4x2(-3.0, -3.0, 0.0, -2.0, -5.0, 8.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][2], mat4x2(-5.0, -9.0, 3.0, 5.0, 2.0, -2.0, -7.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec2(6.0, -2.0));
	var[0][0][0][1] = (vec2(2.0, 8.0));
	var[0][0][0][2] = (vec2(-5.0, 3.0));
	var[0][0][0][3] = (vec2(-1.0, -7.0));
	var[0][0][1][0] = (vec2(4.0, 2.0));
	var[0][0][1][1] = (vec2(-4.0, 8.0));
	var[0][0][1][2] = (vec2(3.0, 8.0));
	var[0][0][1][3] = (vec2(-1.0, 6.0));
	var[0][0][2][0] = (vec2(-8.0, 2.0));
	var[0][0][2][1] = (vec2(-5.0, 5.0));
	var[0][0][2][2] = (vec2(-4.0, -9.0));
	var[0][0][2][3] = (vec2(0.0, 4.0));
	var[0][1][0][0] = (vec2(1.0, 7.0));
	var[0][1][0][1] = (vec2(0.0, -4.0));
	var[0][1][0][2] = (vec2(-1.0, 5.0));
	var[0][1][0][3] = (vec2(9.0, -8.0));
	var[0][1][1][0] = (vec2(-3.0, 8.0));
	var[0][1][1][1] = (vec2(-1.0, 7.0));
	var[0][1][1][2] = (vec2(5.0, -7.0));
	var[0][1][1][3] = (vec2(8.0, 0.0));
	var[0][1][2][0] = (vec2(-5.0, 7.0));
	var[0][1][2][1] = (vec2(8.0, 9.0));
	var[0][1][2][2] = (vec2(8.0, 9.0));
	var[0][1][2][3] = (vec2(1.0, 9.0));
	var[1][0][0][0] = (vec2(8.0, 2.0));
	var[1][0][0][1] = (vec2(-3.0, 2.0));
	var[1][0][0][2] = (vec2(-4.0, -4.0));
	var[1][0][0][3] = (vec2(2.0, -8.0));
	var[1][0][1][0] = (vec2(-4.0, 8.0));
	var[1][0][1][1] = (vec2(5.0, 7.0));
	var[1][0][1][2] = (vec2(-4.0, 6.0));
	var[1][0][1][3] = (vec2(8.0, 4.0));
	var[1][0][2][0] = (vec2(-9.0, -7.0));
	var[1][0][2][1] = (vec2(7.0, -5.0));
	var[1][0][2][2] = (vec2(1.0, -9.0));
	var[1][0][2][3] = (vec2(9.0, 5.0));
	var[1][1][0][0] = (vec2(-9.0, 8.0));
	var[1][1][0][1] = (vec2(-2.0, 9.0));
	var[1][1][0][2] = (vec2(6.0, 6.0));
	var[1][1][0][3] = (vec2(3.0, -5.0));
	var[1][1][1][0] = (vec2(1.0, -4.0));
	var[1][1][1][1] = (vec2(-5.0, 7.0));
	var[1][1][1][2] = (vec2(-8.0, 7.0));
	var[1][1][1][3] = (vec2(-1.0, -1.0));
	var[1][1][2][0] = (vec2(-2.0, -7.0));
	var[1][1][2][1] = (vec2(4.0, -8.0));
	var[1][1][2][2] = (vec2(2.0, 4.0));
	var[1][1][2][3] = (vec2(3.0, 1.0));
	var[2][0][0][0] = (vec2(7.0, 3.0));
	var[2][0][0][1] = (vec2(3.0, 3.0));
	var[2][0][0][2] = (vec2(-5.0, -9.0));
	var[2][0][0][3] = (vec2(2.0, 9.0));
	var[2][0][1][0] = (vec2(3.0, 8.0));
	var[2][0][1][1] = (vec2(3.0, -4.0));
	var[2][0][1][2] = (vec2(6.0, 1.0));
	var[2][0][1][3] = (vec2(-3.0, 1.0));
	var[2][0][2][0] = (vec2(-5.0, -2.0));
	var[2][0][2][1] = (vec2(7.0, 8.0));
	var[2][0][2][2] = (vec2(4.0, 7.0));
	var[2][0][2][3] = (vec2(-1.0, -8.0));
	var[2][1][0][0] = (vec2(7.0, 8.0));
	var[2][1][0][1] = (vec2(2.0, -9.0));
	var[2][1][0][2] = (vec2(-8.0, -9.0));
	var[2][1][0][3] = (vec2(-1.0, -3.0));
	var[2][1][1][0] = (vec2(-2.0, -1.0));
	var[2][1][1][1] = (vec2(1.0, -1.0));
	var[2][1][1][2] = (vec2(-5.0, -6.0));
	var[2][1][1][3] = (vec2(-8.0, 7.0));
	var[2][1][2][0] = (vec2(2.0, 0.0));
	var[2][1][2][1] = (vec2(-7.0, -6.0));
	var[2][1][2][2] = (vec2(6.0, 1.0));
	var[2][1][2][3] = (vec2(8.0, 9.0));
	var[3][0][0][0] = (vec2(-6.0, -6.0));
	var[3][0][0][1] = (vec2(-4.0, -2.0));
	var[3][0][0][2] = (vec2(3.0, 8.0));
	var[3][0][0][3] = (vec2(4.0, 4.0));
	var[3][0][1][0] = (vec2(-7.0, -6.0));
	var[3][0][1][1] = (vec2(8.0, -6.0));
	var[3][0][1][2] = (vec2(8.0, -3.0));
	var[3][0][1][3] = (vec2(-7.0, 0.0));
	var[3][0][2][0] = (vec2(-9.0, 2.0));
	var[3][0][2][1] = (vec2(-9.0, 7.0));
	var[3][0][2][2] = (vec2(-2.0, 2.0));
	var[3][0][2][3] = (vec2(-6.0, -1.0));
	var[3][1][0][0] = (vec2(9.0, -8.0));
	var[3][1][0][1] = (vec2(-6.0, -7.0));
	var[3][1][0][2] = (vec2(-5.0, 0.0));
	var[3][1][0][3] = (vec2(-3.0, 1.0));
	var[3][1][1][0] = (vec2(-1.0, -6.0));
	var[3][1][1][1] = (vec2(1.0, 1.0));
	var[3][1][1][2] = (vec2(-7.0, -8.0));
	var[3][1][1][3] = (vec2(-5.0, 5.0));
	var[3][1][2][0] = (vec2(4.0, -9.0));
	var[3][1][2][1] = (vec2(-6.0, -7.0));
	var[3][1][2][2] = (vec2(-8.0, 8.0));
	var[3][1][2][3] = (vec2(-3.0, 6.0));
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

layout(std430, binding = 1) buffer Block
{
	u8vec3 var[4][2][3];
};

bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(var[0][0][0]), uvec3(4u, 3u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[0][0][1]), uvec3(1u, 4u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[0][0][2]), uvec3(8u, 6u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[0][1][0]), uvec3(8u, 6u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[0][1][1]), uvec3(6u, 7u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[0][1][2]), uvec3(3u, 9u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][0][0]), uvec3(6u, 4u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][0][1]), uvec3(5u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][0][2]), uvec3(1u, 4u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][1][0]), uvec3(1u, 1u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][1][1]), uvec3(1u, 9u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][1][2]), uvec3(9u, 3u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][0][0]), uvec3(3u, 8u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][0][1]), uvec3(6u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][0][2]), uvec3(4u, 0u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][1][0]), uvec3(5u, 0u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][1][1]), uvec3(1u, 1u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][1][2]), uvec3(7u, 6u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[3][0][0]), uvec3(9u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[3][0][1]), uvec3(0u, 2u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[3][0][2]), uvec3(9u, 0u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[3][1][0]), uvec3(4u, 9u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[3][1][1]), uvec3(3u, 8u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[3][1][2]), uvec3(7u, 5u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = u8vec3(uvec3(4u, 5u, 9u));
	var[0][0][1] = u8vec3(uvec3(6u, 9u, 4u));
	var[0][0][2] = u8vec3(uvec3(7u, 1u, 5u));
	var[0][1][0] = u8vec3(uvec3(5u, 7u, 3u));
	var[0][1][1] = u8vec3(uvec3(9u, 8u, 1u));
	var[0][1][2] = u8vec3(uvec3(6u, 2u, 7u));
	var[1][0][0] = u8vec3(uvec3(1u, 7u, 9u));
	var[1][0][1] = u8vec3(uvec3(3u, 4u, 3u));
	var[1][0][2] = u8vec3(uvec3(5u, 7u, 4u));
	var[1][1][0] = u8vec3(uvec3(0u, 2u, 7u));
	var[1][1][1] = u8vec3(uvec3(4u, 8u, 8u));
	var[1][1][2] = u8vec3(uvec3(6u, 1u, 2u));
	var[2][0][0] = u8vec3(uvec3(5u, 4u, 7u));
	var[2][0][1] = u8vec3(uvec3(0u, 0u, 5u));
	var[2][0][2] = u8vec3(uvec3(2u, 5u, 5u));
	var[2][1][0] = u8vec3(uvec3(3u, 6u, 6u));
	var[2][1][1] = u8vec3(uvec3(2u, 7u, 9u));
	var[2][1][2] = u8vec3(uvec3(4u, 0u, 2u));
	var[3][0][0] = u8vec3(uvec3(5u, 9u, 6u));
	var[3][0][1] = u8vec3(uvec3(9u, 7u, 3u));
	var[3][0][2] = u8vec3(uvec3(9u, 4u, 9u));
	var[3][1][0] = u8vec3(uvec3(1u, 5u, 4u));
	var[3][1][1] = u8vec3(uvec3(3u, 7u, 7u));
	var[3][1][2] = u8vec3(uvec3(3u, 8u, 8u));
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
	highp mat2x3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 2.0) && allOk;
	allOk = compare_mat2x3(var[0][0][0], mat2x3(7.0, -5.0, -9.0, 5.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][1], mat2x3(8.0, 9.0, 2.0, 6.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][2], mat2x3(-5.0, -8.0, 2.0, -2.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][0], mat2x3(8.0, 5.0, -8.0, 9.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][1], mat2x3(-1.0, -5.0, 5.0, 5.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][2], mat2x3(9.0, 2.0, 2.0, -2.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][0], mat2x3(8.0, -5.0, 6.0, 6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][1], mat2x3(2.0, 2.0, -8.0, 3.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][2], mat2x3(-7.0, 0.0, 7.0, 6.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][0], mat2x3(9.0, -4.0, -5.0, -3.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][1], mat2x3(6.0, 7.0, -5.0, 2.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][2], mat2x3(7.0, 0.0, 0.0, -1.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][0], mat2x3(-8.0, 7.0, -3.0, 5.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][1], mat2x3(-4.0, 6.0, 2.0, 0.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][2], mat2x3(-2.0, 0.0, 8.0, -6.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][0], mat2x3(-9.0, -7.0, -3.0, -9.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][1], mat2x3(-1.0, -3.0, -3.0, -6.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][2], mat2x3(5.0, -7.0, 2.0, -4.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][0], mat2x3(5.0, -9.0, -6.0, -1.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][1], mat2x3(4.0, -7.0, 6.0, 3.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][2], mat2x3(0.0, 3.0, -9.0, -9.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][0], mat2x3(-1.0, 9.0, -2.0, -8.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][1], mat2x3(-2.0, 1.0, 8.0, 8.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][2], mat2x3(-5.0, 4.0, -9.0, 8.0, 5.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (1.0);
	var[0][0][0][0] = (vec3(-3.0, 9.0, -8.0));
	var[0][0][0][1] = (vec3(-1.0, 1.0, -5.0));
	var[0][0][1][0] = (vec3(3.0, -3.0, 7.0));
	var[0][0][1][1] = (vec3(6.0, 6.0, -9.0));
	var[0][0][2][0] = (vec3(7.0, 0.0, -8.0));
	var[0][0][2][1] = (vec3(-2.0, -7.0, 0.0));
	var[0][1][0][0] = (vec3(5.0, 6.0, -3.0));
	var[0][1][0][1] = (vec3(9.0, -7.0, -6.0));
	var[0][1][1][0] = (vec3(7.0, 9.0, -2.0));
	var[0][1][1][1] = (vec3(0.0, -3.0, -7.0));
	var[0][1][2][0] = (vec3(8.0, -6.0, 8.0));
	var[0][1][2][1] = (vec3(6.0, -7.0, 4.0));
	var[1][0][0][0] = (vec3(-2.0, 4.0, -8.0));
	var[1][0][0][1] = (vec3(-5.0, 5.0, -3.0));
	var[1][0][1][0] = (vec3(-3.0, -1.0, -9.0));
	var[1][0][1][1] = (vec3(-4.0, 7.0, 2.0));
	var[1][0][2][0] = (vec3(-4.0, 8.0, 2.0));
	var[1][0][2][1] = (vec3(-3.0, 6.0, 6.0));
	var[1][1][0][0] = (vec3(4.0, 5.0, 5.0));
	var[1][1][0][1] = (vec3(-8.0, 4.0, 2.0));
	var[1][1][1][0] = (vec3(-4.0, -4.0, -1.0));
	var[1][1][1][1] = (vec3(3.0, 6.0, -3.0));
	var[1][1][2][0] = (vec3(6.0, 2.0, 2.0));
	var[1][1][2][1] = (vec3(-1.0, -1.0, 5.0));
	var[2][0][0][0] = (vec3(3.0, 4.0, -6.0));
	var[2][0][0][1] = (vec3(-2.0, 0.0, 3.0));
	var[2][0][1][0] = (vec3(4.0, -8.0, 0.0));
	var[2][0][1][1] = (vec3(-6.0, 2.0, -3.0));
	var[2][0][2][0] = (vec3(-6.0, -8.0, 8.0));
	var[2][0][2][1] = (vec3(3.0, 5.0, 4.0));
	var[2][1][0][0] = (vec3(7.0, -7.0, 5.0));
	var[2][1][0][1] = (vec3(-2.0, -1.0, -3.0));
	var[2][1][1][0] = (vec3(6.0, -5.0, -2.0));
	var[2][1][1][1] = (vec3(6.0, 7.0, 2.0));
	var[2][1][2][0] = (vec3(-3.0, 6.0, -3.0));
	var[2][1][2][1] = (vec3(-1.0, 2.0, -2.0));
	var[3][0][0][0] = (vec3(-6.0, 7.0, -3.0));
	var[3][0][0][1] = (vec3(-9.0, -1.0, 2.0));
	var[3][0][1][0] = (vec3(-3.0, -5.0, 9.0));
	var[3][0][1][1] = (vec3(-2.0, 4.0, -8.0));
	var[3][0][2][0] = (vec3(2.0, 0.0, 5.0));
	var[3][0][2][1] = (vec3(-1.0, 7.0, 0.0));
	var[3][1][0][0] = (vec3(2.0, -7.0, -2.0));
	var[3][1][0][1] = (vec3(0.0, -6.0, 1.0));
	var[3][1][1][0] = (vec3(7.0, 3.0, 1.0));
	var[3][1][1][1] = (vec3(-8.0, -3.0, 2.0));
	var[3][1][2][0] = (vec3(-8.0, -7.0, 0.0));
	var[3][1][2][1] = (vec3(-8.0, 6.0, -3.0));
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
	highp mat3x2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0][0][0], mat3x2(-5.0, -8.0, -4.0, 7.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][1], mat3x2(-7.0, 4.0, 3.0, -1.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][0], mat3x2(9.0, 7.0, 4.0, -7.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][1], mat3x2(-3.0, 1.0, 1.0, -4.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[0][2][0], mat3x2(-5.0, -6.0, -9.0, -3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[0][2][1], mat3x2(1.0, 6.0, 2.0, 2.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[0][3][0], mat3x2(9.0, 7.0, 3.0, 7.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[0][3][1], mat3x2(-5.0, -7.0, 8.0, 4.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][0], mat3x2(-6.0, -3.0, -8.0, 5.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][1], mat3x2(2.0, 6.0, -1.0, -9.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][0], mat3x2(-7.0, 4.0, 1.0, 0.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][1], mat3x2(3.0, -5.0, 6.0, 8.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[1][2][0], mat3x2(-4.0, -2.0, -2.0, 0.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[1][2][1], mat3x2(5.0, -5.0, 9.0, 8.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[1][3][0], mat3x2(2.0, -4.0, -7.0, 4.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[1][3][1], mat3x2(-8.0, 0.0, -2.0, 1.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][0], mat3x2(-8.0, 3.0, 1.0, -2.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][1], mat3x2(0.0, 4.0, 0.0, 1.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][0], mat3x2(-6.0, 3.0, -6.0, 0.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][1], mat3x2(-1.0, 0.0, -5.0, -6.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[2][2][0], mat3x2(7.0, -4.0, -4.0, 5.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[2][2][1], mat3x2(-8.0, 6.0, 4.0, 2.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[2][3][0], mat3x2(-6.0, 1.0, 9.0, 1.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[2][3][1], mat3x2(3.0, -3.0, 9.0, -6.0, 5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3x2(-3.0, 7.0, -3.0, -4.0, 2.0, -7.0));
	var[0][0][1] = (mat3x2(-2.0, 9.0, -8.0, -2.0, 3.0, 4.0));
	var[0][1][0] = (mat3x2(9.0, 7.0, 7.0, -2.0, 8.0, 3.0));
	var[0][1][1] = (mat3x2(-9.0, 8.0, 4.0, -5.0, 3.0, -6.0));
	var[0][2][0] = (mat3x2(7.0, -4.0, 6.0, -9.0, -2.0, -7.0));
	var[0][2][1] = (mat3x2(-2.0, -2.0, -1.0, 7.0, 3.0, -9.0));
	var[0][3][0] = (mat3x2(-3.0, 2.0, -3.0, -9.0, 1.0, -7.0));
	var[0][3][1] = (mat3x2(6.0, -2.0, 9.0, -6.0, 7.0, 1.0));
	var[1][0][0] = (mat3x2(4.0, 1.0, -7.0, 9.0, 9.0, -1.0));
	var[1][0][1] = (mat3x2(-9.0, 3.0, 0.0, -8.0, -3.0, 8.0));
	var[1][1][0] = (mat3x2(7.0, 2.0, 6.0, 3.0, 5.0, 1.0));
	var[1][1][1] = (mat3x2(0.0, 8.0, -4.0, 0.0, -9.0, 0.0));
	var[1][2][0] = (mat3x2(6.0, -8.0, 1.0, -2.0, -2.0, 3.0));
	var[1][2][1] = (mat3x2(-9.0, 8.0, 3.0, 2.0, 3.0, 7.0));
	var[1][3][0] = (mat3x2(9.0, 6.0, -3.0, 1.0, -1.0, 0.0));
	var[1][3][1] = (mat3x2(3.0, -9.0, 6.0, 0.0, -2.0, 4.0));
	var[2][0][0] = (mat3x2(5.0, 0.0, 9.0, 0.0, 9.0, 8.0));
	var[2][0][1] = (mat3x2(2.0, 6.0, 0.0, 7.0, 6.0, 4.0));
	var[2][1][0] = (mat3x2(7.0, 3.0, 5.0, -1.0, 3.0, -3.0));
	var[2][1][1] = (mat3x2(-2.0, 1.0, 0.0, -5.0, -9.0, -4.0));
	var[2][2][0] = (mat3x2(-9.0, 3.0, -6.0, -9.0, -4.0, -8.0));
	var[2][2][1] = (mat3x2(5.0, 8.0, 8.0, -6.0, -8.0, -4.0));
	var[2][3][0] = (mat3x2(9.0, 1.0, 5.0, -7.0, 2.0, 1.0));
	var[2][3][1] = (mat3x2(8.0, 8.0, 9.0, 6.0, -1.0, 4.0));
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
	highp mat3x4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0][0][0], mat3x4(5.0, -7.0, -9.0, 4.0, 5.0, 3.0, -7.0, -3.0, 7.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][1], mat3x4(-9.0, 7.0, -4.0, 5.0, -9.0, -5.0, 2.0, 6.0, -3.0, -5.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][0], mat3x4(2.0, 3.0, 2.0, 5.0, -4.0, -4.0, 2.0, 8.0, 5.0, -5.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][1], mat3x4(-3.0, 3.0, -2.0, 6.0, 9.0, -7.0, 8.0, 8.0, 1.0, 9.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[0][2][0], mat3x4(-3.0, -7.0, 5.0, 2.0, -5.0, 9.0, -1.0, -1.0, 1.0, -7.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[0][2][1], mat3x4(2.0, 0.0, 8.0, -9.0, 5.0, -4.0, 5.0, -7.0, 0.0, 5.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[0][3][0], mat3x4(3.0, 5.0, -2.0, -6.0, -7.0, -4.0, 6.0, 5.0, -9.0, 2.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[0][3][1], mat3x4(3.0, 3.0, 4.0, -2.0, -8.0, -6.0, -3.0, -8.0, 4.0, 4.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][0], mat3x4(4.0, 1.0, 3.0, -1.0, -3.0, -2.0, 2.0, 7.0, 5.0, -1.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][1], mat3x4(5.0, 1.0, -8.0, -9.0, -6.0, 4.0, 0.0, -9.0, 0.0, -1.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][0], mat3x4(1.0, -2.0, 4.0, 2.0, 7.0, -2.0, -9.0, 6.0, -4.0, 0.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][1], mat3x4(6.0, -8.0, 1.0, 3.0, 2.0, -7.0, 4.0, -9.0, -7.0, 0.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[1][2][0], mat3x4(3.0, 6.0, -3.0, 3.0, 9.0, -1.0, -3.0, 6.0, -9.0, 9.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[1][2][1], mat3x4(-2.0, 8.0, 5.0, -9.0, 0.0, -8.0, 8.0, -8.0, 6.0, -2.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[1][3][0], mat3x4(3.0, -8.0, -9.0, 5.0, -7.0, 3.0, -2.0, -7.0, 6.0, 6.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1][3][1], mat3x4(1.0, -4.0, -8.0, 8.0, -6.0, -1.0, -5.0, -2.0, -6.0, 4.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][0], mat3x4(-3.0, 6.0, 3.0, 0.0, -4.0, 2.0, 4.0, 3.0, -4.0, 9.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][1], mat3x4(-1.0, 6.0, 5.0, -4.0, -5.0, 7.0, -4.0, -5.0, 8.0, -9.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][0], mat3x4(-8.0, 4.0, 3.0, 2.0, 2.0, 0.0, -5.0, -4.0, 7.0, 3.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][1], mat3x4(2.0, 0.0, -3.0, 3.0, -7.0, 7.0, -8.0, 9.0, -2.0, 5.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[2][2][0], mat3x4(-5.0, -3.0, 9.0, 7.0, 1.0, -1.0, -8.0, -6.0, 5.0, 0.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[2][2][1], mat3x4(5.0, -7.0, -3.0, -7.0, 3.0, 9.0, -6.0, -7.0, -4.0, 4.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[2][3][0], mat3x4(0.0, 9.0, 4.0, 8.0, 4.0, -1.0, 1.0, -2.0, -5.0, 9.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[2][3][1], mat3x4(-8.0, -6.0, -8.0, -9.0, -5.0, -1.0, 6.0, 9.0, -6.0, -3.0, -6.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3x4(0.0, 2.0, -8.0, -3.0, 5.0, -1.0, 3.0, -5.0, -9.0, -7.0, 8.0, -9.0));
	var[0][0][1] = (mat3x4(0.0, -5.0, 1.0, -9.0, -1.0, 4.0, 7.0, 4.0, -4.0, -6.0, 0.0, -5.0));
	var[0][1][0] = (mat3x4(-7.0, -8.0, -2.0, 9.0, -8.0, 3.0, 9.0, 9.0, 5.0, -8.0, -1.0, 2.0));
	var[0][1][1] = (mat3x4(1.0, 5.0, 7.0, 5.0, -4.0, -7.0, -5.0, -9.0, -1.0, 6.0, 2.0, 4.0));
	var[0][2][0] = (mat3x4(-3.0, -3.0, -1.0, -2.0, 7.0, 1.0, 7.0, 0.0, -9.0, 2.0, -2.0, -6.0));
	var[0][2][1] = (mat3x4(4.0, -5.0, -8.0, -9.0, 4.0, 2.0, -1.0, -3.0, 9.0, -6.0, -9.0, -8.0));
	var[0][3][0] = (mat3x4(-9.0, -9.0, 8.0, -1.0, 9.0, 2.0, -9.0, -3.0, -9.0, -1.0, 3.0, -2.0));
	var[0][3][1] = (mat3x4(4.0, -7.0, 2.0, 7.0, 3.0, -7.0, 7.0, 6.0, 9.0, -4.0, 4.0, 0.0));
	var[1][0][0] = (mat3x4(-7.0, 5.0, -9.0, -3.0, -7.0, 7.0, 1.0, -4.0, 7.0, -8.0, -2.0, -9.0));
	var[1][0][1] = (mat3x4(0.0, -2.0, -8.0, -5.0, 0.0, 5.0, -2.0, -1.0, 5.0, 8.0, -3.0, 1.0));
	var[1][1][0] = (mat3x4(-1.0, 2.0, 3.0, -5.0, -6.0, -4.0, 4.0, -7.0, -1.0, 8.0, -9.0, 2.0));
	var[1][1][1] = (mat3x4(-2.0, 9.0, -8.0, 3.0, -5.0, 6.0, -8.0, 3.0, -8.0, 6.0, 6.0, -8.0));
	var[1][2][0] = (mat3x4(7.0, 6.0, -3.0, -6.0, -1.0, 2.0, 7.0, -9.0, -3.0, -4.0, -1.0, 0.0));
	var[1][2][1] = (mat3x4(-7.0, 4.0, 3.0, -4.0, 4.0, 2.0, -4.0, -3.0, 8.0, 9.0, 9.0, 8.0));
	var[1][3][0] = (mat3x4(7.0, -5.0, 6.0, 4.0, 1.0, 6.0, 4.0, 4.0, 3.0, -2.0, 6.0, -9.0));
	var[1][3][1] = (mat3x4(-6.0, 0.0, 0.0, -3.0, -3.0, 7.0, -1.0, 4.0, 4.0, 5.0, 2.0, 5.0));
	var[2][0][0] = (mat3x4(-1.0, 7.0, 7.0, 7.0, 2.0, -7.0, 8.0, -3.0, -8.0, -2.0, -5.0, -6.0));
	var[2][0][1] = (mat3x4(5.0, 8.0, 9.0, 8.0, 7.0, 0.0, 9.0, 7.0, -3.0, -7.0, -6.0, -5.0));
	var[2][1][0] = (mat3x4(-3.0, 2.0, 8.0, 3.0, -1.0, 0.0, -7.0, 5.0, 3.0, 2.0, 9.0, -2.0));
	var[2][1][1] = (mat3x4(-7.0, -5.0, -3.0, 6.0, -7.0, -8.0, -4.0, 1.0, 0.0, 0.0, 1.0, 9.0));
	var[2][2][0] = (mat3x4(1.0, 2.0, 5.0, 6.0, 8.0, 4.0, 6.0, -3.0, 6.0, -7.0, 9.0, -9.0));
	var[2][2][1] = (mat3x4(-9.0, -8.0, 4.0, 0.0, -8.0, 2.0, 2.0, -2.0, -7.0, 9.0, 5.0, -9.0));
	var[2][3][0] = (mat3x4(1.0, 9.0, -5.0, -8.0, -5.0, 7.0, -5.0, 0.0, -4.0, 2.0, 3.0, 5.0));
	var[2][3][1] = (mat3x4(4.0, 2.0, 3.0, 5.0, 5.0, -9.0, -8.0, -9.0, -7.0, 8.0, 4.0, -2.0));
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
	highp mat4x2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0][0][0], mat4x2(-2.0, 6.0, 5.0, 7.0, 1.0, -5.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][1], mat4x2(4.0, -5.0, -7.0, -4.0, 7.0, 7.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][0], mat4x2(-1.0, -8.0, 5.0, -8.0, 2.0, 3.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][1], mat4x2(0.0, 4.0, -8.0, -3.0, -1.0, 4.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[0][2][0], mat4x2(-1.0, 3.0, -9.0, 4.0, -2.0, 2.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[0][2][1], mat4x2(-3.0, 7.0, -5.0, 3.0, 2.0, -1.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[0][3][0], mat4x2(-4.0, 1.0, -2.0, 4.0, 1.0, -8.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[0][3][1], mat4x2(-3.0, 8.0, -5.0, 6.0, -2.0, -2.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][0], mat4x2(-1.0, 7.0, -9.0, -7.0, -1.0, 8.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][1], mat4x2(-4.0, 7.0, -5.0, -3.0, 4.0, 7.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][0], mat4x2(4.0, 5.0, -7.0, 1.0, 0.0, -9.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][1], mat4x2(-2.0, 4.0, -8.0, 5.0, -3.0, 8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[1][2][0], mat4x2(6.0, 9.0, -5.0, 0.0, 7.0, 6.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[1][2][1], mat4x2(-7.0, -3.0, -5.0, 2.0, 3.0, -3.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[1][3][0], mat4x2(0.0, 0.0, 7.0, -1.0, 5.0, 0.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[1][3][1], mat4x2(-4.0, 8.0, -2.0, -8.0, 3.0, -3.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][0], mat4x2(9.0, -5.0, 9.0, 2.0, -1.0, -1.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][1], mat4x2(-6.0, -7.0, 4.0, 4.0, 9.0, -9.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][0], mat4x2(5.0, -9.0, 5.0, -2.0, -8.0, -1.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][1], mat4x2(3.0, 5.0, 1.0, 5.0, -3.0, -4.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[2][2][0], mat4x2(5.0, -7.0, -9.0, 8.0, 8.0, -7.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[2][2][1], mat4x2(-6.0, 8.0, -1.0, 0.0, 6.0, -2.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[2][3][0], mat4x2(-7.0, -6.0, -2.0, 5.0, -6.0, 7.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[2][3][1], mat4x2(8.0, -4.0, 0.0, -7.0, 2.0, -2.0, 6.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec2(6.0, 9.0));
	var[0][0][0][1] = (vec2(-4.0, -4.0));
	var[0][0][0][2] = (vec2(2.0, 0.0));
	var[0][0][0][3] = (vec2(-7.0, 3.0));
	var[0][0][1][0] = (vec2(9.0, -6.0));
	var[0][0][1][1] = (vec2(8.0, -9.0));
	var[0][0][1][2] = (vec2(-9.0, -6.0));
	var[0][0][1][3] = (vec2(-4.0, -6.0));
	var[0][1][0][0] = (vec2(-2.0, 1.0));
	var[0][1][0][1] = (vec2(6.0, -2.0));
	var[0][1][0][2] = (vec2(2.0, -5.0));
	var[0][1][0][3] = (vec2(3.0, -3.0));
	var[0][1][1][0] = (vec2(-6.0, -4.0));
	var[0][1][1][1] = (vec2(-6.0, -7.0));
	var[0][1][1][2] = (vec2(9.0, 1.0));
	var[0][1][1][3] = (vec2(-4.0, 3.0));
	var[0][2][0][0] = (vec2(-9.0, -3.0));
	var[0][2][0][1] = (vec2(5.0, -5.0));
	var[0][2][0][2] = (vec2(3.0, 4.0));
	var[0][2][0][3] = (vec2(-9.0, 1.0));
	var[0][2][1][0] = (vec2(0.0, 8.0));
	var[0][2][1][1] = (vec2(-8.0, 3.0));
	var[0][2][1][2] = (vec2(-7.0, 9.0));
	var[0][2][1][3] = (vec2(-8.0, -7.0));
	var[0][3][0][0] = (vec2(3.0, 7.0));
	var[0][3][0][1] = (vec2(-6.0, -7.0));
	var[0][3][0][2] = (vec2(-7.0, 5.0));
	var[0][3][0][3] = (vec2(-8.0, 4.0));
	var[0][3][1][0] = (vec2(4.0, -5.0));
	var[0][3][1][1] = (vec2(-6.0, -9.0));
	var[0][3][1][2] = (vec2(7.0, 7.0));
	var[0][3][1][3] = (vec2(-2.0, 6.0));
	var[1][0][0][0] = (vec2(-8.0, 5.0));
	var[1][0][0][1] = (vec2(6.0, -8.0));
	var[1][0][0][2] = (vec2(-8.0, 3.0));
	var[1][0][0][3] = (vec2(2.0, 8.0));
	var[1][0][1][0] = (vec2(-8.0, -1.0));
	var[1][0][1][1] = (vec2(-3.0, 0.0));
	var[1][0][1][2] = (vec2(7.0, 5.0));
	var[1][0][1][3] = (vec2(-8.0, 5.0));
	var[1][1][0][0] = (vec2(7.0, -9.0));
	var[1][1][0][1] = (vec2(7.0, -4.0));
	var[1][1][0][2] = (vec2(8.0, -2.0));
	var[1][1][0][3] = (vec2(9.0, 0.0));
	var[1][1][1][0] = (vec2(-9.0, 7.0));
	var[1][1][1][1] = (vec2(1.0, 4.0));
	var[1][1][1][2] = (vec2(-7.0, 9.0));
	var[1][1][1][3] = (vec2(-5.0, 2.0));
	var[1][2][0][0] = (vec2(7.0, 1.0));
	var[1][2][0][1] = (vec2(-1.0, -2.0));
	var[1][2][0][2] = (vec2(-8.0, -3.0));
	var[1][2][0][3] = (vec2(9.0, -1.0));
	var[1][2][1][0] = (vec2(-2.0, 1.0));
	var[1][2][1][1] = (vec2(-8.0, -7.0));
	var[1][2][1][2] = (vec2(-5.0, 7.0));
	var[1][2][1][3] = (vec2(-5.0, -7.0));
	var[1][3][0][0] = (vec2(1.0, -9.0));
	var[1][3][0][1] = (vec2(7.0, 6.0));
	var[1][3][0][2] = (vec2(-4.0, 2.0));
	var[1][3][0][3] = (vec2(1.0, 5.0));
	var[1][3][1][0] = (vec2(-8.0, -6.0));
	var[1][3][1][1] = (vec2(-6.0, 4.0));
	var[1][3][1][2] = (vec2(4.0, 7.0));
	var[1][3][1][3] = (vec2(-7.0, -9.0));
	var[2][0][0][0] = (vec2(7.0, 8.0));
	var[2][0][0][1] = (vec2(4.0, -2.0));
	var[2][0][0][2] = (vec2(4.0, -2.0));
	var[2][0][0][3] = (vec2(-2.0, 9.0));
	var[2][0][1][0] = (vec2(4.0, -4.0));
	var[2][0][1][1] = (vec2(-5.0, -5.0));
	var[2][0][1][2] = (vec2(-6.0, 8.0));
	var[2][0][1][3] = (vec2(9.0, -5.0));
	var[2][1][0][0] = (vec2(-9.0, -3.0));
	var[2][1][0][1] = (vec2(-8.0, 5.0));
	var[2][1][0][2] = (vec2(-2.0, -8.0));
	var[2][1][0][3] = (vec2(7.0, -6.0));
	var[2][1][1][0] = (vec2(-7.0, 1.0));
	var[2][1][1][1] = (vec2(-3.0, 7.0));
	var[2][1][1][2] = (vec2(6.0, -5.0));
	var[2][1][1][3] = (vec2(9.0, -2.0));
	var[2][2][0][0] = (vec2(-5.0, 2.0));
	var[2][2][0][1] = (vec2(-4.0, 8.0));
	var[2][2][0][2] = (vec2(-7.0, 6.0));
	var[2][2][0][3] = (vec2(5.0, 2.0));
	var[2][2][1][0] = (vec2(-5.0, 3.0));
	var[2][2][1][1] = (vec2(-9.0, 7.0));
	var[2][2][1][2] = (vec2(-3.0, -3.0));
	var[2][2][1][3] = (vec2(-7.0, -4.0));
	var[2][3][0][0] = (vec2(7.0, -6.0));
	var[2][3][0][1] = (vec2(8.0, -8.0));
	var[2][3][0][2] = (vec2(-6.0, -7.0));
	var[2][3][0][3] = (vec2(-4.0, -2.0));
	var[2][3][1][0] = (vec2(-9.0, 9.0));
	var[2][3][1][1] = (vec2(4.0, -6.0));
	var[2][3][1][2] = (vec2(2.0, 3.0));
	var[2][3][1][3] = (vec2(6.0, 8.0));
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
	f16vec3 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(var[0][0][0]), vec3(4.0, 1.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[0][0][1]), vec3(-8.0, 7.0, -5.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[0][1][0]), vec3(1.0, -2.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[0][1][1]), vec3(-7.0, -7.0, -7.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[0][2][0]), vec3(-1.0, -7.0, -9.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[0][2][1]), vec3(2.0, 6.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[0][3][0]), vec3(8.0, 2.0, 0.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[0][3][1]), vec3(-1.0, 2.0, 2.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][0][0]), vec3(4.0, 2.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][0][1]), vec3(4.0, 4.0, 5.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][1][0]), vec3(-8.0, -2.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][1][1]), vec3(6.0, 6.0, -1.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][2][0]), vec3(-5.0, 1.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][2][1]), vec3(5.0, 4.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][3][0]), vec3(-4.0, -8.0, 7.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][3][1]), vec3(5.0, 7.0, 5.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][0][0]), vec3(2.0, 1.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][0][1]), vec3(8.0, 2.0, -3.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][1][0]), vec3(-4.0, -4.0, 6.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][1][1]), vec3(-8.0, 6.0, 4.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][2][0]), vec3(6.0, -7.0, -8.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][2][1]), vec3(6.0, -8.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][3][0]), vec3(6.0, -9.0, -6.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][3][1]), vec3(0.0, -3.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = f16vec3(vec3(3.0, 3.0, 7.0));
	var[0][0][1] = f16vec3(vec3(-3.0, -5.0, -9.0));
	var[0][1][0] = f16vec3(vec3(-5.0, -4.0, 6.0));
	var[0][1][1] = f16vec3(vec3(-3.0, -7.0, -4.0));
	var[0][2][0] = f16vec3(vec3(6.0, 6.0, -6.0));
	var[0][2][1] = f16vec3(vec3(-3.0, 1.0, -5.0));
	var[0][3][0] = f16vec3(vec3(2.0, -5.0, -9.0));
	var[0][3][1] = f16vec3(vec3(-8.0, 4.0, 1.0));
	var[1][0][0] = f16vec3(vec3(-1.0, 0.0, 6.0));
	var[1][0][1] = f16vec3(vec3(5.0, -7.0, 2.0));
	var[1][1][0] = f16vec3(vec3(-4.0, 5.0, 0.0));
	var[1][1][1] = f16vec3(vec3(-6.0, 4.0, -1.0));
	var[1][2][0] = f16vec3(vec3(6.0, 9.0, 7.0));
	var[1][2][1] = f16vec3(vec3(2.0, 5.0, 3.0));
	var[1][3][0] = f16vec3(vec3(-9.0, -5.0, 5.0));
	var[1][3][1] = f16vec3(vec3(-3.0, -6.0, 0.0));
	var[2][0][0] = f16vec3(vec3(9.0, 1.0, -5.0));
	var[2][0][1] = f16vec3(vec3(-5.0, 5.0, 2.0));
	var[2][1][0] = f16vec3(vec3(-2.0, 3.0, -8.0));
	var[2][1][1] = f16vec3(vec3(-4.0, -2.0, 4.0));
	var[2][2][0] = f16vec3(vec3(9.0, -8.0, 2.0));
	var[2][2][1] = f16vec3(vec3(-7.0, -8.0, -3.0));
	var[2][3][0] = f16vec3(vec3(-3.0, 9.0, -1.0));
	var[2][3][1] = f16vec3(vec3(-9.0, 0.0, -5.0));
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
	highp mat2x3 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0][0][0], mat2x3(-2.0, 0.0, -9.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][1], mat2x3(-3.0, -1.0, -3.0, -1.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][0], mat2x3(7.0, -9.0, 0.0, -9.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][1], mat2x3(5.0, 3.0, 9.0, 1.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[0][2][0], mat2x3(1.0, -3.0, -1.0, -4.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat2x3(var[0][2][1], mat2x3(-2.0, 8.0, 1.0, 6.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[0][3][0], mat2x3(-3.0, -8.0, -3.0, 7.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[0][3][1], mat2x3(9.0, 0.0, 2.0, 6.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][0], mat2x3(9.0, 9.0, 0.0, 0.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][1], mat2x3(-6.0, 8.0, -3.0, 7.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][0], mat2x3(5.0, -3.0, 6.0, 8.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][1], mat2x3(9.0, 5.0, 6.0, 7.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[1][2][0], mat2x3(2.0, 5.0, 0.0, -6.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[1][2][1], mat2x3(9.0, 7.0, -7.0, 4.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[1][3][0], mat2x3(4.0, 6.0, 0.0, 9.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[1][3][1], mat2x3(9.0, 6.0, -6.0, -7.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][0], mat2x3(6.0, -2.0, -7.0, -8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][1], mat2x3(7.0, -3.0, 2.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][0], mat2x3(1.0, 9.0, 5.0, 1.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][1], mat2x3(1.0, 6.0, -5.0, 7.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[2][2][0], mat2x3(3.0, 7.0, 0.0, -3.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[2][2][1], mat2x3(9.0, 5.0, -9.0, 3.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[2][3][0], mat2x3(9.0, 2.0, -4.0, -6.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[2][3][1], mat2x3(7.0, -7.0, 9.0, 2.0, -8.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec3(0.0, 5.0, 5.0));
	var[0][0][0][1] = (vec3(0.0, -7.0, 8.0));
	var[0][0][1][0] = (vec3(-7.0, -4.0, 6.0));
	var[0][0][1][1] = (vec3(1.0, 3.0, 2.0));
	var[0][1][0][0] = (vec3(4.0, -1.0, 7.0));
	var[0][1][0][1] = (vec3(9.0, -2.0, -4.0));
	var[0][1][1][0] = (vec3(8.0, -4.0, 2.0));
	var[0][1][1][1] = (vec3(5.0, -1.0, -3.0));
	var[0][2][0][0] = (vec3(8.0, 7.0, -1.0));
	var[0][2][0][1] = (vec3(-6.0, 1.0, -2.0));
	var[0][2][1][0] = (vec3(8.0, -6.0, -8.0));
	var[0][2][1][1] = (vec3(9.0, -5.0, 5.0));
	var[0][3][0][0] = (vec3(5.0, -5.0, 1.0));
	var[0][3][0][1] = (vec3(9.0, 2.0, -6.0));
	var[0][3][1][0] = (vec3(-1.0, -6.0, 5.0));
	var[0][3][1][1] = (vec3(8.0, -5.0, -8.0));
	var[1][0][0][0] = (vec3(-6.0, 5.0, 2.0));
	var[1][0][0][1] = (vec3(1.0, 8.0, -8.0));
	var[1][0][1][0] = (vec3(2.0, -7.0, 5.0));
	var[1][0][1][1] = (vec3(-4.0, -6.0, -9.0));
	var[1][1][0][0] = (vec3(3.0, -2.0, -8.0));
	var[1][1][0][1] = (vec3(6.0, 0.0, 9.0));
	var[1][1][1][0] = (vec3(1.0, -5.0, -1.0));
	var[1][1][1][1] = (vec3(-6.0, -6.0, 3.0));
	var[1][2][0][0] = (vec3(-8.0, 1.0, -3.0));
	var[1][2][0][1] = (vec3(-4.0, -5.0, 1.0));
	var[1][2][1][0] = (vec3(4.0, -2.0, -5.0));
	var[1][2][1][1] = (vec3(-9.0, -8.0, -5.0));
	var[1][3][0][0] = (vec3(-6.0, -6.0, 5.0));
	var[1][3][0][1] = (vec3(-4.0, 8.0, -9.0));
	var[1][3][1][0] = (vec3(0.0, 5.0, -4.0));
	var[1][3][1][1] = (vec3(5.0, 2.0, 5.0));
	var[2][0][0][0] = (vec3(3.0, 0.0, -7.0));
	var[2][0][0][1] = (vec3(2.0, -4.0, 1.0));
	var[2][0][1][0] = (vec3(-2.0, -2.0, -5.0));
	var[2][0][1][1] = (vec3(2.0, 5.0, 4.0));
	var[2][1][0][0] = (vec3(1.0, -8.0, -5.0));
	var[2][1][0][1] = (vec3(8.0, 5.0, 8.0));
	var[2][1][1][0] = (vec3(5.0, 5.0, 7.0));
	var[2][1][1][1] = (vec3(-9.0, 8.0, 0.0));
	var[2][2][0][0] = (vec3(5.0, 9.0, 6.0));
	var[2][2][0][1] = (vec3(7.0, 5.0, 7.0));
	var[2][2][1][0] = (vec3(0.0, 9.0, -4.0));
	var[2][2][1][1] = (vec3(7.0, -3.0, 7.0));
	var[2][3][0][0] = (vec3(-4.0, 5.0, 5.0));
	var[2][3][0][1] = (vec3(-4.0, 4.0, 8.0));
	var[2][3][1][0] = (vec3(2.0, 8.0, 3.0));
	var[2][3][1][1] = (vec3(-1.0, -1.0, 6.0));
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
	highp mat4x2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0][0][0], mat4x2(9.0, 2.0, -3.0, -5.0, -5.0, -4.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][1], mat4x2(7.0, 7.0, -8.0, 9.0, -7.0, -5.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][0], mat4x2(-4.0, 9.0, -1.0, -6.0, 5.0, 3.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][1], mat4x2(-7.0, -7.0, -9.0, 9.0, 5.0, 8.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[0][2][0], mat4x2(7.0, -5.0, 4.0, -9.0, 5.0, 5.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[0][2][1], mat4x2(2.0, 9.0, -6.0, -6.0, 2.0, 8.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[0][3][0], mat4x2(1.0, 0.0, 3.0, -4.0, -6.0, 5.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[0][3][1], mat4x2(1.0, -5.0, -1.0, -2.0, 2.0, 1.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][0], mat4x2(-9.0, 8.0, 3.0, -7.0, 5.0, 3.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][1], mat4x2(7.0, -4.0, -4.0, -6.0, 9.0, -3.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][0], mat4x2(-6.0, -5.0, -7.0, -3.0, 6.0, -7.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][1], mat4x2(7.0, -9.0, -5.0, -3.0, -6.0, -9.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[1][2][0], mat4x2(-6.0, 9.0, -3.0, -1.0, 3.0, 8.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[1][2][1], mat4x2(-7.0, -7.0, -6.0, 2.0, 3.0, -7.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[1][3][0], mat4x2(-3.0, 1.0, 1.0, 4.0, 2.0, -8.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[1][3][1], mat4x2(-4.0, 8.0, 3.0, 1.0, -5.0, 5.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][0], mat4x2(-2.0, 5.0, 6.0, 4.0, -6.0, -2.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][1], mat4x2(-5.0, 9.0, -4.0, -6.0, 4.0, -5.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][0], mat4x2(-4.0, -9.0, 9.0, -7.0, -6.0, -8.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][1], mat4x2(8.0, 6.0, 7.0, -6.0, 0.0, 0.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[2][2][0], mat4x2(8.0, -4.0, 1.0, 3.0, 4.0, -2.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[2][2][1], mat4x2(6.0, -4.0, -6.0, 6.0, -8.0, 8.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[2][3][0], mat4x2(0.0, 1.0, 4.0, 1.0, -3.0, 2.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[2][3][1], mat4x2(-8.0, 6.0, 2.0, 2.0, -4.0, -7.0, -5.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4x2(-9.0, 9.0, 1.0, 5.0, 0.0, 6.0, 3.0, 6.0));
	var[0][0][1] = (mat4x2(-5.0, -7.0, 8.0, -6.0, 1.0, -3.0, 2.0, 4.0));
	var[0][1][0] = (mat4x2(-8.0, 5.0, -9.0, -8.0, -8.0, -4.0, -5.0, -5.0));
	var[0][1][1] = (mat4x2(-6.0, 1.0, 7.0, 7.0, -9.0, 6.0, -8.0, -3.0));
	var[0][2][0] = (mat4x2(9.0, -8.0, 1.0, 3.0, 1.0, -5.0, -5.0, -5.0));
	var[0][2][1] = (mat4x2(2.0, -5.0, 1.0, 5.0, -5.0, 1.0, -2.0, -4.0));
	var[0][3][0] = (mat4x2(1.0, -8.0, 1.0, -6.0, 0.0, -2.0, 2.0, -8.0));
	var[0][3][1] = (mat4x2(2.0, -7.0, -3.0, 7.0, 5.0, 6.0, 5.0, -4.0));
	var[1][0][0] = (mat4x2(8.0, -2.0, 6.0, 6.0, 1.0, -9.0, 9.0, -3.0));
	var[1][0][1] = (mat4x2(2.0, 0.0, -9.0, -3.0, -1.0, 1.0, 8.0, 1.0));
	var[1][1][0] = (mat4x2(4.0, -4.0, 8.0, -6.0, 5.0, 3.0, 3.0, 2.0));
	var[1][1][1] = (mat4x2(2.0, -3.0, 9.0, 9.0, -2.0, 0.0, -5.0, -2.0));
	var[1][2][0] = (mat4x2(0.0, -1.0, -2.0, 7.0, 1.0, -5.0, -2.0, -9.0));
	var[1][2][1] = (mat4x2(-1.0, -5.0, -2.0, 4.0, 6.0, 1.0, -4.0, 9.0));
	var[1][3][0] = (mat4x2(-1.0, -8.0, -3.0, -1.0, 7.0, -2.0, -4.0, 2.0));
	var[1][3][1] = (mat4x2(7.0, 2.0, 0.0, -8.0, 0.0, 2.0, -9.0, 5.0));
	var[2][0][0] = (mat4x2(-3.0, 6.0, -3.0, -6.0, -7.0, 2.0, 2.0, 7.0));
	var[2][0][1] = (mat4x2(3.0, -6.0, -7.0, -9.0, 6.0, 3.0, 6.0, 3.0));
	var[2][1][0] = (mat4x2(3.0, 5.0, 8.0, 9.0, -2.0, -1.0, 3.0, -2.0));
	var[2][1][1] = (mat4x2(7.0, 5.0, 1.0, -1.0, 2.0, 8.0, 7.0, 7.0));
	var[2][2][0] = (mat4x2(3.0, -5.0, -9.0, -6.0, -1.0, 2.0, -9.0, 3.0));
	var[2][2][1] = (mat4x2(-9.0, 2.0, -3.0, -1.0, -3.0, -6.0, -9.0, 9.0));
	var[2][3][0] = (mat4x2(-8.0, -1.0, -4.0, 4.0, -3.0, -5.0, -3.0, 8.0));
	var[2][3][1] = (mat4x2(-4.0, -1.0, -1.0, 0.0, -9.0, 4.0, -2.0, -6.0));
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
	highp uvec2 var[][4][2];
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((var[0][0][0]), uvec2(6u, 0u)) && allOk;
	allOk = compare_uvec2((var[0][0][1]), uvec2(6u, 7u)) && allOk;
	allOk = compare_uvec2((var[0][1][0]), uvec2(0u, 2u)) && allOk;
	allOk = compare_uvec2((var[0][1][1]), uvec2(2u, 9u)) && allOk;
	allOk = compare_uvec2((var[0][2][0]), uvec2(7u, 7u)) && allOk;
	allOk = compare_uvec2((var[0][2][1]), uvec2(4u, 6u)) && allOk;
	allOk = compare_uvec2((var[0][3][0]), uvec2(8u, 6u)) && allOk;
	allOk = compare_uvec2((var[0][3][1]), uvec2(7u, 3u)) && allOk;
	allOk = compare_uvec2((var[1][0][0]), uvec2(1u, 7u)) && allOk;
	allOk = compare_uvec2((var[1][0][1]), uvec2(9u, 0u)) && allOk;
	allOk = compare_uvec2((var[1][1][0]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((var[1][1][1]), uvec2(1u, 4u)) && allOk;
	allOk = compare_uvec2((var[1][2][0]), uvec2(5u, 8u)) && allOk;
	allOk = compare_uvec2((var[1][2][1]), uvec2(9u, 9u)) && allOk;
	allOk = compare_uvec2((var[1][3][0]), uvec2(4u, 9u)) && allOk;
	allOk = compare_uvec2((var[1][3][1]), uvec2(3u, 2u)) && allOk;
	allOk = compare_uvec2((var[2][0][0]), uvec2(6u, 9u)) && allOk;
	allOk = compare_uvec2((var[2][0][1]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((var[2][1][0]), uvec2(7u, 1u)) && allOk;
	allOk = compare_uvec2((var[2][1][1]), uvec2(8u, 8u)) && allOk;
	allOk = compare_uvec2((var[2][2][0]), uvec2(2u, 1u)) && allOk;
	allOk = compare_uvec2((var[2][2][1]), uvec2(0u, 7u)) && allOk;
	allOk = compare_uvec2((var[2][3][0]), uvec2(4u, 8u)) && allOk;
	allOk = compare_uvec2((var[2][3][1]), uvec2(8u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (uvec2(6u, 1u));
	var[0][0][1] = (uvec2(8u, 1u));
	var[0][1][0] = (uvec2(8u, 4u));
	var[0][1][1] = (uvec2(6u, 3u));
	var[0][2][0] = (uvec2(6u, 2u));
	var[0][2][1] = (uvec2(6u, 0u));
	var[0][3][0] = (uvec2(0u, 1u));
	var[0][3][1] = (uvec2(2u, 6u));
	var[1][0][0] = (uvec2(7u, 4u));
	var[1][0][1] = (uvec2(6u, 6u));
	var[1][1][0] = (uvec2(6u, 0u));
	var[1][1][1] = (uvec2(3u, 5u));
	var[1][2][0] = (uvec2(3u, 2u));
	var[1][2][1] = (uvec2(5u, 1u));
	var[1][3][0] = (uvec2(9u, 1u));
	var[1][3][1] = (uvec2(4u, 6u));
	var[2][0][0] = (uvec2(5u, 8u));
	var[2][0][1] = (uvec2(4u, 7u));
	var[2][1][0] = (uvec2(2u, 4u));
	var[2][1][1] = (uvec2(7u, 8u));
	var[2][2][0] = (uvec2(7u, 2u));
	var[2][2][1] = (uvec2(3u, 6u));
	var[2][3][0] = (uvec2(4u, 2u));
	var[2][3][1] = (uvec2(7u, 5u));
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
	highp mat2x3 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0][0][0], mat2x3(5.0, 8.0, 4.0, -6.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][1], mat2x3(0.0, 0.0, 4.0, 3.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][0], mat2x3(-6.0, 9.0, 9.0, -2.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][1], mat2x3(8.0, -6.0, -2.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[0][2][0], mat2x3(8.0, -7.0, 1.0, -9.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[0][2][1], mat2x3(3.0, 8.0, -5.0, -1.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[0][3][0], mat2x3(5.0, -9.0, 5.0, 6.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[0][3][1], mat2x3(4.0, 1.0, -5.0, 7.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][0], mat2x3(-7.0, 2.0, -1.0, 5.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][1], mat2x3(-2.0, -1.0, 3.0, 4.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][0], mat2x3(-2.0, -9.0, -1.0, -8.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][1], mat2x3(-5.0, -9.0, -3.0, -8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[1][2][0], mat2x3(9.0, -5.0, 0.0, 0.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[1][2][1], mat2x3(-8.0, -1.0, 3.0, -7.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[1][3][0], mat2x3(6.0, 2.0, -9.0, 9.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[1][3][1], mat2x3(4.0, -5.0, 0.0, 0.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][0], mat2x3(5.0, 8.0, 1.0, -7.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][1], mat2x3(0.0, 9.0, -1.0, -8.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][0], mat2x3(-9.0, -1.0, -9.0, -9.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][1], mat2x3(-6.0, -1.0, 7.0, -5.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[2][2][0], mat2x3(-7.0, 6.0, -9.0, -5.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[2][2][1], mat2x3(-7.0, 1.0, 7.0, 2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[2][3][0], mat2x3(6.0, 8.0, 9.0, 5.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[2][3][1], mat2x3(-6.0, -1.0, -9.0, 3.0, -2.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2x3(-9.0, -3.0, 4.0, -1.0, 8.0, -5.0));
	var[0][0][1] = (mat2x3(-4.0, -8.0, -3.0, 1.0, -5.0, 6.0));
	var[0][1][0] = (mat2x3(-4.0, -3.0, -6.0, -1.0, -5.0, 7.0));
	var[0][1][1] = (mat2x3(1.0, 9.0, -7.0, 3.0, 3.0, 1.0));
	var[0][2][0] = (mat2x3(-1.0, -7.0, 4.0, 3.0, 8.0, -7.0));
	var[0][2][1] = (mat2x3(-1.0, -2.0, 2.0, 6.0, -5.0, 4.0));
	var[0][3][0] = (mat2x3(-9.0, -9.0, 0.0, 3.0, 6.0, -8.0));
	var[0][3][1] = (mat2x3(-7.0, -4.0, 3.0, -6.0, -7.0, -9.0));
	var[1][0][0] = (mat2x3(0.0, 4.0, 6.0, 2.0, -1.0, -7.0));
	var[1][0][1] = (mat2x3(6.0, 9.0, 2.0, -3.0, 0.0, 5.0));
	var[1][1][0] = (mat2x3(-4.0, -9.0, 4.0, -1.0, -4.0, 1.0));
	var[1][1][1] = (mat2x3(-7.0, 0.0, -4.0, -6.0, -1.0, -1.0));
	var[1][2][0] = (mat2x3(-8.0, 0.0, -4.0, 7.0, -5.0, -1.0));
	var[1][2][1] = (mat2x3(4.0, -6.0, -1.0, -4.0, 7.0, 8.0));
	var[1][3][0] = (mat2x3(-9.0, 8.0, -8.0, 7.0, 8.0, -9.0));
	var[1][3][1] = (mat2x3(0.0, -8.0, -9.0, 3.0, 8.0, -4.0));
	var[2][0][0] = (mat2x3(-9.0, 6.0, -3.0, 9.0, -7.0, 2.0));
	var[2][0][1] = (mat2x3(8.0, -3.0, 7.0, -9.0, 7.0, -1.0));
	var[2][1][0] = (mat2x3(5.0, -5.0, 0.0, -6.0, -9.0, -6.0));
	var[2][1][1] = (mat2x3(-2.0, -1.0, -6.0, -6.0, 3.0, -3.0));
	var[2][2][0] = (mat2x3(-1.0, 4.0, -9.0, -3.0, -5.0, 8.0));
	var[2][2][1] = (mat2x3(5.0, -4.0, -4.0, 8.0, 6.0, 4.0));
	var[2][3][0] = (mat2x3(6.0, -9.0, -1.0, 5.0, 7.0, -4.0));
	var[2][3][1] = (mat2x3(0.0, -7.0, -9.0, -2.0, -6.0, -1.0));
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
	allOk = compare_mat2x4(var[0][0][0], mat2x4(-2.0, 4.0, 3.0, 6.0, 3.0, -7.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(6.0, 4.0, 0.0, 9.0, -2.0, 9.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(-9.0, -1.0, 5.0, -7.0, -9.0, -6.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(1.0, 2.0, -6.0, 1.0, -5.0, 3.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[0][2][0], mat2x4(6.0, 0.0, 6.0, 8.0, -9.0, 4.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[0][2][1], mat2x4(-9.0, -1.0, 7.0, 9.0, 0.0, -2.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[0][3][0], mat2x4(9.0, -3.0, -7.0, 2.0, -4.0, -3.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[0][3][1], mat2x4(1.0, -8.0, -2.0, 6.0, 8.0, 9.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(1.0, -7.0, 0.0, 6.0, -6.0, 9.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(9.0, -9.0, 3.0, -1.0, -8.0, -5.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(-8.0, 1.0, -5.0, 0.0, 7.0, 5.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(-7.0, -6.0, 2.0, 4.0, -8.0, 4.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[1][2][0], mat2x4(-8.0, 4.0, 8.0, 3.0, -3.0, -8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[1][2][1], mat2x4(-9.0, 6.0, -4.0, -8.0, -5.0, -4.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[1][3][0], mat2x4(-7.0, 3.0, 5.0, -3.0, -6.0, 8.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[1][3][1], mat2x4(-6.0, -9.0, 7.0, 2.0, -1.0, 5.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(6.0, -4.0, -5.0, -3.0, -7.0, 1.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(0.0, -5.0, 1.0, 2.0, 7.0, 2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(-5.0, -2.0, -6.0, -2.0, -6.0, 1.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(2.0, -3.0, -2.0, 4.0, 6.0, -7.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[2][2][0], mat2x4(-8.0, 0.0, 4.0, -6.0, 5.0, 2.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[2][2][1], mat2x4(-1.0, -2.0, 0.0, -7.0, 8.0, -2.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[2][3][0], mat2x4(4.0, 2.0, 9.0, -9.0, -1.0, 9.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[2][3][1], mat2x4(7.0, 8.0, 4.0, -3.0, 7.0, 5.0, 2.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2x4(-5.0, -7.0, -7.0, 0.0, -1.0, -9.0, 5.0, -5.0));
	var[0][0][1] = (mat2x4(0.0, 1.0, 8.0, 9.0, 2.0, 4.0, 5.0, 5.0));
	var[0][1][0] = (mat2x4(0.0, -6.0, -6.0, 6.0, -1.0, 8.0, 4.0, 1.0));
	var[0][1][1] = (mat2x4(-5.0, 4.0, -3.0, 3.0, 1.0, -9.0, -1.0, -2.0));
	var[0][2][0] = (mat2x4(8.0, 3.0, 0.0, -3.0, 5.0, -4.0, 8.0, -3.0));
	var[0][2][1] = (mat2x4(7.0, -1.0, 5.0, 0.0, -5.0, 2.0, -3.0, -8.0));
	var[0][3][0] = (mat2x4(-3.0, -9.0, -7.0, -5.0, -2.0, 8.0, -8.0, -8.0));
	var[0][3][1] = (mat2x4(-5.0, 1.0, -1.0, 8.0, 3.0, 3.0, -4.0, 8.0));
	var[1][0][0] = (mat2x4(3.0, 6.0, 2.0, 7.0, -1.0, -8.0, 7.0, -7.0));
	var[1][0][1] = (mat2x4(-8.0, -9.0, 5.0, -5.0, 5.0, -9.0, -7.0, -2.0));
	var[1][1][0] = (mat2x4(-4.0, -7.0, -9.0, 5.0, -3.0, -7.0, 8.0, 3.0));
	var[1][1][1] = (mat2x4(-1.0, 7.0, 6.0, -6.0, -8.0, -8.0, -4.0, 6.0));
	var[1][2][0] = (mat2x4(-9.0, 5.0, -6.0, -2.0, 0.0, 0.0, -2.0, -9.0));
	var[1][2][1] = (mat2x4(3.0, -5.0, -5.0, -6.0, 3.0, 0.0, -2.0, 5.0));
	var[1][3][0] = (mat2x4(2.0, 5.0, -9.0, 0.0, -3.0, 2.0, -2.0, 9.0));
	var[1][3][1] = (mat2x4(-7.0, -3.0, 5.0, -4.0, -2.0, 0.0, 2.0, -6.0));
	var[2][0][0] = (mat2x4(-5.0, 8.0, -8.0, -8.0, 5.0, 4.0, -2.0, -7.0));
	var[2][0][1] = (mat2x4(-6.0, -7.0, 4.0, -6.0, 9.0, 7.0, 1.0, 7.0));
	var[2][1][0] = (mat2x4(-5.0, 3.0, -1.0, -5.0, 7.0, -3.0, -2.0, -2.0));
	var[2][1][1] = (mat2x4(5.0, 7.0, -6.0, -5.0, -9.0, 3.0, 7.0, 0.0));
	var[2][2][0] = (mat2x4(-9.0, -9.0, 4.0, -7.0, -9.0, -2.0, 5.0, 9.0));
	var[2][2][1] = (mat2x4(0.0, 6.0, -3.0, -4.0, 0.0, -2.0, 8.0, 1.0));
	var[2][3][0] = (mat2x4(2.0, 3.0, 1.0, 6.0, -7.0, -8.0, -7.0, 9.0));
	var[2][3][1] = (mat2x4(-6.0, -2.0, -6.0, -8.0, -5.0, 7.0, 9.0, -5.0));
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
	highp mat4x2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0][0][0], mat4x2(0.0, 6.0, -3.0, 7.0, 1.0, -8.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][1], mat4x2(2.0, -3.0, -5.0, 5.0, 5.0, 1.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][0], mat4x2(9.0, 5.0, 0.0, -5.0, 6.0, -8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][1], mat4x2(2.0, 6.0, -5.0, 2.0, -8.0, -2.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[0][2][0], mat4x2(-2.0, -6.0, 4.0, 4.0, 5.0, -9.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[0][2][1], mat4x2(-3.0, 4.0, 3.0, -2.0, -5.0, 0.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[0][3][0], mat4x2(1.0, -7.0, -5.0, 9.0, -9.0, -1.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[0][3][1], mat4x2(-7.0, 7.0, 2.0, 7.0, -3.0, -8.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][0], mat4x2(1.0, 1.0, -2.0, -3.0, -9.0, 3.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][1], mat4x2(6.0, -2.0, -9.0, 5.0, -5.0, -6.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][0], mat4x2(6.0, -1.0, 6.0, -3.0, 4.0, 0.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][1], mat4x2(-5.0, 8.0, 8.0, -7.0, 4.0, 6.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[1][2][0], mat4x2(-3.0, 4.0, -5.0, -8.0, 5.0, -3.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[1][2][1], mat4x2(3.0, 4.0, -7.0, 4.0, -9.0, 4.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[1][3][0], mat4x2(-4.0, -2.0, 8.0, 3.0, -2.0, 8.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[1][3][1], mat4x2(1.0, -7.0, -1.0, 4.0, 4.0, -5.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][0], mat4x2(5.0, -3.0, 5.0, 6.0, -4.0, -8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][1], mat4x2(-5.0, 4.0, -9.0, 6.0, 8.0, -3.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][0], mat4x2(-9.0, -8.0, 9.0, -2.0, -7.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][1], mat4x2(-5.0, 0.0, 3.0, 9.0, -8.0, -1.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[2][2][0], mat4x2(-7.0, 4.0, -9.0, -9.0, -6.0, 2.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[2][2][1], mat4x2(-6.0, 6.0, -7.0, -6.0, -7.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[2][3][0], mat4x2(-2.0, 0.0, -5.0, -8.0, -4.0, -9.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[2][3][1], mat4x2(1.0, 9.0, -1.0, 7.0, -9.0, -1.0, -4.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4x2(8.0, -5.0, 3.0, 0.0, -9.0, 4.0, -5.0, 3.0));
	var[0][0][1] = (mat4x2(6.0, 3.0, 6.0, -6.0, 0.0, -3.0, -2.0, -4.0));
	var[0][1][0] = (mat4x2(1.0, -6.0, 2.0, 4.0, 7.0, 1.0, 9.0, 5.0));
	var[0][1][1] = (mat4x2(8.0, -7.0, 6.0, -7.0, -4.0, 5.0, 3.0, -2.0));
	var[0][2][0] = (mat4x2(4.0, 9.0, -8.0, 5.0, 3.0, 3.0, -4.0, 8.0));
	var[0][2][1] = (mat4x2(-7.0, 2.0, 2.0, -4.0, 6.0, -1.0, 1.0, 1.0));
	var[0][3][0] = (mat4x2(8.0, -7.0, 4.0, 5.0, -8.0, -6.0, -7.0, 1.0));
	var[0][3][1] = (mat4x2(1.0, 6.0, -8.0, -5.0, -6.0, 2.0, -9.0, 0.0));
	var[1][0][0] = (mat4x2(5.0, 4.0, 1.0, 0.0, 7.0, -9.0, -4.0, 5.0));
	var[1][0][1] = (mat4x2(6.0, 1.0, 0.0, 3.0, 2.0, -5.0, -4.0, 5.0));
	var[1][1][0] = (mat4x2(-2.0, -5.0, -1.0, 1.0, -8.0, 4.0, 9.0, 2.0));
	var[1][1][1] = (mat4x2(-5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 1.0, 1.0));
	var[1][2][0] = (mat4x2(-9.0, 7.0, 9.0, -1.0, 3.0, -9.0, 2.0, -2.0));
	var[1][2][1] = (mat4x2(4.0, 1.0, 2.0, 3.0, 5.0, -3.0, -8.0, -1.0));
	var[1][3][0] = (mat4x2(-6.0, 4.0, 2.0, 8.0, 2.0, 4.0, -9.0, 9.0));
	var[1][3][1] = (mat4x2(5.0, -4.0, 5.0, 4.0, -8.0, -6.0, 4.0, 0.0));
	var[2][0][0] = (mat4x2(5.0, -4.0, -7.0, -8.0, 9.0, -4.0, 5.0, 5.0));
	var[2][0][1] = (mat4x2(-1.0, 6.0, -6.0, 5.0, 4.0, -3.0, 1.0, -4.0));
	var[2][1][0] = (mat4x2(1.0, -9.0, -1.0, 6.0, -9.0, -7.0, -8.0, 8.0));
	var[2][1][1] = (mat4x2(-2.0, 7.0, 8.0, -9.0, 4.0, -3.0, 0.0, -7.0));
	var[2][2][0] = (mat4x2(2.0, 6.0, -3.0, 8.0, 3.0, -4.0, 8.0, 5.0));
	var[2][2][1] = (mat4x2(-4.0, 6.0, 7.0, -3.0, 1.0, 9.0, 7.0, 4.0));
	var[2][3][0] = (mat4x2(7.0, -2.0, 3.0, -5.0, -4.0, 1.0, -3.0, 6.0));
	var[2][3][1] = (mat4x2(-3.0, -1.0, 4.0, -1.0, -1.0, -7.0, -7.0, 6.0));
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
	i16vec2 var[][4][2];
};

bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(var[0][0][0]), ivec2(3, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(var[0][0][1]), ivec2(8, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(var[0][1][0]), ivec2(-6, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(var[0][1][1]), ivec2(-5, 6)) && allOk;
	allOk = compare_i16vec2(ivec2(var[0][2][0]), ivec2(-1, 2)) && allOk;
	allOk = compare_i16vec2(ivec2(var[0][2][1]), ivec2(0, -4)) && allOk;
	allOk = compare_i16vec2(ivec2(var[0][3][0]), ivec2(-2, -8)) && allOk;
	allOk = compare_i16vec2(ivec2(var[0][3][1]), ivec2(-6, 7)) && allOk;
	allOk = compare_i16vec2(ivec2(var[1][0][0]), ivec2(-4, 2)) && allOk;
	allOk = compare_i16vec2(ivec2(var[1][0][1]), ivec2(-1, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(var[1][1][0]), ivec2(-1, 8)) && allOk;
	allOk = compare_i16vec2(ivec2(var[1][1][1]), ivec2(1, 1)) && allOk;
	allOk = compare_i16vec2(ivec2(var[1][2][0]), ivec2(-2, -2)) && allOk;
	allOk = compare_i16vec2(ivec2(var[1][2][1]), ivec2(1, 0)) && allOk;
	allOk = compare_i16vec2(ivec2(var[1][3][0]), ivec2(8, -4)) && allOk;
	allOk = compare_i16vec2(ivec2(var[1][3][1]), ivec2(0, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(var[2][0][0]), ivec2(-1, -9)) && allOk;
	allOk = compare_i16vec2(ivec2(var[2][0][1]), ivec2(-1, -7)) && allOk;
	allOk = compare_i16vec2(ivec2(var[2][1][0]), ivec2(6, -6)) && allOk;
	allOk = compare_i16vec2(ivec2(var[2][1][1]), ivec2(1, 1)) && allOk;
	allOk = compare_i16vec2(ivec2(var[2][2][0]), ivec2(-5, -5)) && allOk;
	allOk = compare_i16vec2(ivec2(var[2][2][1]), ivec2(-8, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(var[2][3][0]), ivec2(-2, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(var[2][3][1]), ivec2(-6, 6)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = i16vec2(ivec2(6, -2));
	var[0][0][1] = i16vec2(ivec2(-2, -8));
	var[0][1][0] = i16vec2(ivec2(0, -1));
	var[0][1][1] = i16vec2(ivec2(3, -9));
	var[0][2][0] = i16vec2(ivec2(6, 9));
	var[0][2][1] = i16vec2(ivec2(0, 9));
	var[0][3][0] = i16vec2(ivec2(4, 1));
	var[0][3][1] = i16vec2(ivec2(-5, -1));
	var[1][0][0] = i16vec2(ivec2(3, 5));
	var[1][0][1] = i16vec2(ivec2(-9, -9));
	var[1][1][0] = i16vec2(ivec2(9, -6));
	var[1][1][1] = i16vec2(ivec2(-1, -7));
	var[1][2][0] = i16vec2(ivec2(0, 5));
	var[1][2][1] = i16vec2(ivec2(9, -8));
	var[1][3][0] = i16vec2(ivec2(4, -5));
	var[1][3][1] = i16vec2(ivec2(-6, 1));
	var[2][0][0] = i16vec2(ivec2(-4, -3));
	var[2][0][1] = i16vec2(ivec2(-2, 6));
	var[2][1][0] = i16vec2(ivec2(-1, -6));
	var[2][1][1] = i16vec2(ivec2(6, 5));
	var[2][2][0] = i16vec2(ivec2(4, 6));
	var[2][2][1] = i16vec2(ivec2(-9, -9));
	var[2][3][0] = i16vec2(ivec2(-8, 4));
	var[2][3][1] = i16vec2(ivec2(-6, 1));
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
};

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
	allOk = compare_uint((u), 4u) && allOk;
	allOk = compare_mat4x3(t[0].a, mat4x3(-4.0, 7.0, 5.0, -8.0, -8.0, -3.0, 0.0, -4.0, 9.0, 1.0, -6.0, 4.0)) && allOk;
	allOk = compare_uvec3((t[0].b[0].a), uvec3(2u, 4u, 7u)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[0]), vec2(9.0, 2.0)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[1]), vec2(-1.0, 8.0)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[2]), vec2(1.0, 7.0)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[3]), vec2(-5.0, -5.0)) && allOk;
	allOk = compare_vec4((t[0].b[0].c), vec4(-9.0, -1.0, 1.0, -8.0)) && allOk;
	allOk = compare_uvec3((t[0].b[1].a), uvec3(5u, 8u, 2u)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[0]), vec2(4.0, 7.0)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[1]), vec2(1.0, 0.0)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[2]), vec2(-2.0, -5.0)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[3]), vec2(9.0, -7.0)) && allOk;
	allOk = compare_vec4((t[0].b[1].c), vec4(-1.0, -2.0, 7.0, -4.0)) && allOk;
	allOk = compare_uvec3((t[0].b[2].a), uvec3(8u, 2u, 3u)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[0]), vec2(5.0, 2.0)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[1]), vec2(-1.0, 0.0)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[2]), vec2(-1.0, 5.0)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[3]), vec2(9.0, 9.0)) && allOk;
	allOk = compare_vec4((t[0].b[2].c), vec4(-3.0, -5.0, 9.0, 6.0)) && allOk;
	allOk = compare_int((t[0].c), -2) && allOk;
	allOk = compare_mat4x3(t[1].a, mat4x3(-9.0, 3.0, -7.0, -4.0, -4.0, -1.0, 6.0, -1.0, -3.0, -4.0, -8.0, -7.0)) && allOk;
	allOk = compare_uvec3((t[1].b[0].a), uvec3(5u, 0u, 5u)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[0]), vec2(-6.0, 2.0)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[1]), vec2(-4.0, -8.0)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[2]), vec2(-4.0, -5.0)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[3]), vec2(7.0, -1.0)) && allOk;
	allOk = compare_vec4((t[1].b[0].c), vec4(-1.0, -6.0, -3.0, -6.0)) && allOk;
	allOk = compare_uvec3((t[1].b[1].a), uvec3(2u, 9u, 7u)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[0]), vec2(5.0, 3.0)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[1]), vec2(2.0, -5.0)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[2]), vec2(7.0, 6.0)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[3]), vec2(4.0, 6.0)) && allOk;
	allOk = compare_vec4((t[1].b[1].c), vec4(9.0, 1.0, -7.0, 8.0)) && allOk;
	allOk = compare_uvec3((t[1].b[2].a), uvec3(8u, 5u, 1u)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[0]), vec2(-5.0, 3.0)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[1]), vec2(2.0, 0.0)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[2]), vec2(-7.0, 2.0)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[3]), vec2(6.0, 8.0)) && allOk;
	allOk = compare_vec4((t[1].b[2].c), vec4(-3.0, 3.0, -8.0, -5.0)) && allOk;
	allOk = compare_int((t[1].c), -6) && allOk;
	allOk = compare_mat4x3(t[2].a, mat4x3(-8.0, -6.0, 3.0, -4.0, 1.0, 1.0, -7.0, 9.0, -9.0, 5.0, 5.0, -9.0)) && allOk;
	allOk = compare_uvec3((t[2].b[0].a), uvec3(1u, 1u, 4u)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[0]), vec2(6.0, 7.0)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[1]), vec2(5.0, 6.0)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[2]), vec2(-4.0, -6.0)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[3]), vec2(4.0, 1.0)) && allOk;
	allOk = compare_vec4((t[2].b[0].c), vec4(-4.0, -3.0, -8.0, 5.0)) && allOk;
	allOk = compare_uvec3((t[2].b[1].a), uvec3(2u, 8u, 1u)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[0]), vec2(7.0, 8.0)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[1]), vec2(-2.0, -6.0)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[2]), vec2(3.0, 3.0)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[3]), vec2(4.0, -6.0)) && allOk;
	allOk = compare_vec4((t[2].b[1].c), vec4(7.0, -8.0, 0.0, 2.0)) && allOk;
	allOk = compare_uvec3((t[2].b[2].a), uvec3(8u, 3u, 7u)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[0]), vec2(5.0, -1.0)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[1]), vec2(1.0, -4.0)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[2]), vec2(8.0, -5.0)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[3]), vec2(5.0, -2.0)) && allOk;
	allOk = compare_vec4((t[2].b[2].c), vec4(-1.0, 3.0, -9.0, -1.0)) && allOk;
	allOk = compare_int((t[2].c), -5) && allOk;
	allOk = compare_mat4x3(t[3].a, mat4x3(3.0, -1.0, -5.0, -6.0, 0.0, -7.0, 8.0, -3.0, 1.0, -5.0, 8.0, 7.0)) && allOk;
	allOk = compare_uvec3((t[3].b[0].a), uvec3(1u, 6u, 9u)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[0]), vec2(-6.0, 4.0)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[1]), vec2(-1.0, -9.0)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[2]), vec2(-3.0, 1.0)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[3]), vec2(4.0, -6.0)) && allOk;
	allOk = compare_vec4((t[3].b[0].c), vec4(3.0, 6.0, -9.0, 9.0)) && allOk;
	allOk = compare_uvec3((t[3].b[1].a), uvec3(2u, 9u, 6u)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[0]), vec2(-6.0, 0.0)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[1]), vec2(2.0, 6.0)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[2]), vec2(7.0, 9.0)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[3]), vec2(9.0, -8.0)) && allOk;
	allOk = compare_vec4((t[3].b[1].c), vec4(3.0, -9.0, -3.0, -4.0)) && allOk;
	allOk = compare_uvec3((t[3].b[2].a), uvec3(4u, 6u, 7u)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[0]), vec2(2.0, -1.0)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[1]), vec2(-3.0, 0.0)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[2]), vec2(-7.0, 1.0)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[3]), vec2(-6.0, 7.0)) && allOk;
	allOk = compare_vec4((t[3].b[2].c), vec4(7.0, 4.0, 6.0, -9.0)) && allOk;
	allOk = compare_int((t[3].c), -3) && allOk;
    if (allOk)
        ac_numPassed++;

	s.a = (uvec3(6u, 3u, 3u));
	s.b[0] = (vec2(-6.0, -2.0));
	s.b[1] = (vec2(4.0, -5.0));
	s.b[2] = (vec2(-9.0, -7.0));
	s.b[3] = (vec2(-1.0, 2.0));
	s.c = (vec4(2.0, -5.0, 0.0, -7.0));
	u = (0u);
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
	highp mat4x3 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block[0].var[0][0], -4.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 6.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 7.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -6.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 2.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -5.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 0.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -2.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 8.0) && allOk;
	allOk = compare_float(block[0].var[3][0], -7.0) && allOk;
	allOk = compare_float(block[0].var[3][1], 6.0) && allOk;
	allOk = compare_float(block[0].var[3][2], -8.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(-4.0, 6.0, 7.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(-6.0, 2.0, -5.0)) && allOk;
	allOk = compare_vec3(block[0].var[2], vec3(0.0, -2.0, 8.0)) && allOk;
	allOk = compare_vec3(block[0].var[3], vec3(-7.0, 6.0, -8.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], -4.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -5.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -7.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 0.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -7.0) && allOk;
	allOk = compare_float(block[1].var[1][2], -8.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -3.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 1.0) && allOk;
	allOk = compare_float(block[1].var[2][2], 3.0) && allOk;
	allOk = compare_float(block[1].var[3][0], 7.0) && allOk;
	allOk = compare_float(block[1].var[3][1], 7.0) && allOk;
	allOk = compare_float(block[1].var[3][2], -4.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(-4.0, -5.0, -7.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(0.0, -7.0, -8.0)) && allOk;
	allOk = compare_vec3(block[1].var[2], vec3(-3.0, 1.0, 3.0)) && allOk;
	allOk = compare_vec3(block[1].var[3], vec3(7.0, 7.0, -4.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], -9.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 5.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 2.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -9.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 9.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 2.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 8.0) && allOk;
	allOk = compare_float(block[2].var[2][1], -7.0) && allOk;
	allOk = compare_float(block[2].var[2][2], -4.0) && allOk;
	allOk = compare_float(block[2].var[3][0], 8.0) && allOk;
	allOk = compare_float(block[2].var[3][1], 6.0) && allOk;
	allOk = compare_float(block[2].var[3][2], -6.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(-9.0, 5.0, 2.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(-9.0, 9.0, 2.0)) && allOk;
	allOk = compare_vec3(block[2].var[2], vec3(8.0, -7.0, -4.0)) && allOk;
	allOk = compare_vec3(block[2].var[3], vec3(8.0, 6.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec3(-3.0, -6.0, 6.0));
	block[0].var[1] = (vec3(1.0, -4.0, -3.0));
	block[0].var[2] = (vec3(-3.0, 3.0, -2.0));
	block[0].var[3] = (vec3(-7.0, 1.0, -5.0));
	block[1].var[0] = (vec3(-1.0, -5.0, 7.0));
	block[1].var[1] = (vec3(1.0, -2.0, -4.0));
	block[1].var[2] = (vec3(-4.0, -6.0, 5.0));
	block[1].var[3] = (vec3(-2.0, 6.0, -9.0));
	block[2].var[0] = (vec3(5.0, -5.0, 7.0));
	block[2].var[1] = (vec3(-4.0, 8.0, -3.0));
	block[2].var[2] = (vec3(-2.0, 0.0, 8.0));
	block[2].var[3] = (vec3(-2.0, 6.0, -3.0));
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

layout(std430, binding = 1) buffer BlockA
{
	highp float a;
	lowp uvec3 b;
	mediump mat2 c;
} blockA[3];
layout(std430, binding = 2) buffer BlockB
{
	mediump mat3 a;
	lowp ivec2 b;
	highp vec4 c;
	bool d;
} blockB[3];

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
	allOk = compare_float((blockA[0].a), -2.0) && allOk;
	allOk = compare_mat2(blockA[0].c, mat2(-5.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_float((blockA[1].a), 9.0) && allOk;
	allOk = compare_mat2(blockA[1].c, mat2(-2.0, -6.0, 3.0, -7.0)) && allOk;
	allOk = compare_float((blockA[2].a), -5.0) && allOk;
	allOk = compare_mat2(blockA[2].c, mat2(-2.0, 5.0, 0.0, 0.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b), ivec2(8, 3)) && allOk;
	allOk = compare_bool((blockB[0].d), true) && allOk;
	allOk = compare_ivec2((blockB[1].b), ivec2(4, 9)) && allOk;
	allOk = compare_bool((blockB[1].d), true) && allOk;
	allOk = compare_ivec2((blockB[2].b), ivec2(6, -5)) && allOk;
	allOk = compare_bool((blockB[2].d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (1.0);
	blockA[1].a = (-7.0);
	blockA[2].a = (6.0);
	blockB[0].a = (mat3(8.0, -6.0, 6.0, 1.0, -8.0, 5.0, -6.0, -4.0, 9.0));
	blockB[0].d = (true);
	blockB[1].a = (mat3(-9.0, 6.0, -5.0, -7.0, 6.0, 3.0, 4.0, 6.0, 7.0));
	blockB[1].d = (true);
	blockB[2].a = (mat3(-2.0, 9.0, 0.0, -6.0, -7.0, 7.0, -5.0, 5.0, 9.0));
	blockB[2].d = (true);
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
layout(std430, binding = 1) buffer BlockA
{
	highp float a;
	S b;
	lowp uvec3 c;
} blockA[3];
layout(std430, binding = 2) buffer BlockB
{
	mediump mat2 a;
	T b;
	bvec4 c;
	bool d;
} blockB[3];

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
	allOk = compare_float((blockA[0].a), 5.0) && allOk;
	allOk = compare_float((blockA[1].a), -8.0) && allOk;
	allOk = compare_float((blockA[2].a), -8.0) && allOk;
	allOk = compare_uint((blockB[0].b.a), 5u) && allOk;
	allOk = compare_mat3(blockB[0].b.b.a, mat3(-1.0, -7.0, -7.0, 1.0, 0.0, -6.0, -3.0, -2.0, -2.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[0]), ivec2(0, -2)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[1]), ivec2(9, -7)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[2]), ivec2(6, 4)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[3]), ivec2(-2, -3)) && allOk;
	allOk = compare_vec4((blockB[0].b.b.c), vec4(-9.0, -5.0, 1.0, 9.0)) && allOk;
	allOk = compare_bvec4((blockB[0].b.c), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bool((blockB[0].d), true) && allOk;
	allOk = compare_uint((blockB[1].b.a), 4u) && allOk;
	allOk = compare_mat3(blockB[1].b.b.a, mat3(9.0, 7.0, 4.0, -5.0, 0.0, 1.0, -4.0, -6.0, 6.0)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[0]), ivec2(-3, -1)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[1]), ivec2(5, -1)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[2]), ivec2(-8, -2)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[3]), ivec2(-7, -8)) && allOk;
	allOk = compare_vec4((blockB[1].b.b.c), vec4(3.0, 8.0, -7.0, -5.0)) && allOk;
	allOk = compare_bvec4((blockB[1].b.c), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bool((blockB[1].d), false) && allOk;
	allOk = compare_uint((blockB[2].b.a), 5u) && allOk;
	allOk = compare_mat3(blockB[2].b.b.a, mat3(6.0, 9.0, 9.0, -9.0, 3.0, -2.0, -5.0, -8.0, 7.0)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[0]), ivec2(9, -6)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[1]), ivec2(9, -2)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[2]), ivec2(9, 4)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[3]), ivec2(6, -7)) && allOk;
	allOk = compare_vec4((blockB[2].b.b.c), vec4(-6.0, 1.0, 9.0, -1.0)) && allOk;
	allOk = compare_bvec4((blockB[2].b.c), bvec4(false, true, false, false)) && allOk;
	allOk = compare_bool((blockB[2].d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (-3.0);
	blockA[0].b.a[0] = (vec3(-5.0, 3.0, -2.0));
	blockA[0].b.a[1] = (vec3(-9.0, -6.0, 1.0));
	blockA[0].b.a[2] = (vec3(-4.0, 0.0, 4.0));
	blockA[0].b.b[0] = (ivec2(4, -7));
	blockA[0].b.b[1] = (ivec2(-8, -9));
	blockA[0].b.b[2] = (ivec2(6, 4));
	blockA[0].b.b[3] = (ivec2(-6, 2));
	blockA[0].b.c = (vec4(5.0, 5.0, 1.0, -1.0));
	blockA[1].a = (0.0);
	blockA[1].b.a[0] = (vec3(5.0, -3.0, 0.0));
	blockA[1].b.a[1] = (vec3(5.0, -1.0, 1.0));
	blockA[1].b.a[2] = (vec3(-7.0, -7.0, 8.0));
	blockA[1].b.b[0] = (ivec2(-2, -9));
	blockA[1].b.b[1] = (ivec2(5, 6));
	blockA[1].b.b[2] = (ivec2(6, -9));
	blockA[1].b.b[3] = (ivec2(-4, 6));
	blockA[1].b.c = (vec4(-3.0, 7.0, 5.0, -4.0));
	blockA[2].a = (4.0);
	blockA[2].b.a[0] = (vec3(8.0, -5.0, -8.0));
	blockA[2].b.a[1] = (vec3(6.0, -5.0, -9.0));
	blockA[2].b.a[2] = (vec3(-5.0, -7.0, 2.0));
	blockA[2].b.b[0] = (ivec2(0, 0));
	blockA[2].b.b[1] = (ivec2(0, 1));
	blockA[2].b.b[2] = (ivec2(-9, 0));
	blockA[2].b.b[3] = (ivec2(7, 9));
	blockA[2].b.c = (vec4(-3.0, 5.0, 9.0, 5.0));
	blockB[0].a[0] = (vec2(1.0, 8.0));
	blockB[0].a[1] = (vec2(-7.0, 8.0));
	blockB[0].b.a = (1u);
	blockB[0].b.b.a[0] = (vec3(8.0, 0.0, -4.0));
	blockB[0].b.b.a[1] = (vec3(-7.0, -3.0, 1.0));
	blockB[0].b.b.a[2] = (vec3(-1.0, -2.0, 2.0));
	blockB[0].b.b.b[0] = (ivec2(2, -2));
	blockB[0].b.b.b[1] = (ivec2(3, -9));
	blockB[0].b.b.b[2] = (ivec2(7, -7));
	blockB[0].b.b.b[3] = (ivec2(-7, 7));
	blockB[0].b.b.c = (vec4(0.0, -2.0, -9.0, -1.0));
	blockB[0].b.c = (bvec4(false, true, true, true));
	blockB[0].d = (true);
	blockB[1].a[0] = (vec2(9.0, 1.0));
	blockB[1].a[1] = (vec2(-5.0, 0.0));
	blockB[1].b.a = (1u);
	blockB[1].b.b.a[0] = (vec3(4.0, 0.0, 9.0));
	blockB[1].b.b.a[1] = (vec3(6.0, 8.0, 8.0));
	blockB[1].b.b.a[2] = (vec3(-7.0, 3.0, 1.0));
	blockB[1].b.b.b[0] = (ivec2(6, -9));
	blockB[1].b.b.b[1] = (ivec2(-3, 1));
	blockB[1].b.b.b[2] = (ivec2(5, -2));
	blockB[1].b.b.b[3] = (ivec2(4, -1));
	blockB[1].b.b.c = (vec4(0.0, 3.0, -2.0, -3.0));
	blockB[1].b.c = (bvec4(true, false, true, true));
	blockB[1].d = (true);
	blockB[2].a[0] = (vec2(6.0, -1.0));
	blockB[2].a[1] = (vec2(-2.0, 4.0));
	blockB[2].b.a = (2u);
	blockB[2].b.b.a[0] = (vec3(-9.0, -1.0, 1.0));
	blockB[2].b.b.a[1] = (vec3(5.0, 3.0, -8.0));
	blockB[2].b.b.a[2] = (vec3(-1.0, 2.0, 7.0));
	blockB[2].b.b.b[0] = (ivec2(4, 6));
	blockB[2].b.b.b[1] = (ivec2(-4, -9));
	blockB[2].b.b.b[2] = (ivec2(-4, 4));
	blockB[2].b.b.b[3] = (ivec2(1, -8));
	blockB[2].b.b.c = (vec4(-8.0, -3.0, 7.0, 9.0));
	blockB[2].b.c = (bvec4(false, false, true, true));
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

layout(std430, binding = 1) buffer BlockB
{
	bvec3 a;
	highp vec2 b;
	lowp uvec3 c;
};
layout(std140, binding = 2) buffer BlockC
{
	mediump float d;
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	highp vec2 e;
	bvec2 f;
	highp ivec2 g;
	bvec4 h;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((b), vec2(-4.0, -6.0)) && allOk;
	allOk = compare_vec2((e), vec2(-9.0, -9.0)) && allOk;
	allOk = compare_ivec2((g), ivec2(-8, 6)) && allOk;
	allOk = compare_bvec4((h), bvec4(false, false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	c = (uvec3(2u, 9u, 4u));
	blockC.d = (4.0);
	e = (vec2(-2.0, 5.0));
	f = (bvec2(true, true));
	g = (ivec2(1, 1));
	h = (bvec4(false, false, false, false));
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
	highp ivec4 a;
} blockB;

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec4(1, 1, -4, 1));
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
	bvec3 a;
	highp mat2 b;
	mediump mat2 c;
	lowp int d;
	lowp mat3x2 e;
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	highp mat3 f;
	lowp uvec4 g[4];
};
layout(std140, row_major, binding = 3) buffer BlockD
{
	mediump mat4 h;
	bvec4 i;
	mediump mat4x3 j;
	mediump int k;
} blockD;
layout(std430, row_major, binding = 4) buffer BlockE
{
	mediump mat3x2 l[7];
	mediump uvec3 m;
	lowp mat3x4 n;
	lowp uvec3 o[2];
	lowp vec4 p;
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
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(b, mat2(-5.0, 9.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(e, mat3x2(5.0, 7.0, -2.0, -4.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3(f, mat3(3.0, 1.0, 9.0, 0.0, 8.0, -1.0, 2.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat4(blockD.h, mat4(-1.0, -6.0, -2.0, -7.0, -5.0, -9.0, 3.0, -2.0, -1.0, -8.0, 7.0, -5.0, -9.0, 6.0, 2.0, 4.0)) && allOk;
	allOk = compare_bvec4((blockD.i), bvec4(false, false, true, false)) && allOk;
	allOk = compare_mat4x3(blockD.j, mat4x3(-2.0, -3.0, -9.0, -9.0, 8.0, 2.0, 0.0, -7.0, 4.0, -8.0, 9.0, 7.0)) && allOk;
	allOk = compare_int((blockD.k), 4) && allOk;
	allOk = compare_mat3x2(l[0], mat3x2(-6.0, -7.0, -8.0, 8.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(l[1], mat3x2(6.0, -5.0, 2.0, 4.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat3x2(l[2], mat3x2(-7.0, 7.0, -4.0, 6.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat3x2(l[3], mat3x2(8.0, 4.0, -8.0, 4.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(l[4], mat3x2(-9.0, 6.0, -6.0, -4.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3x2(l[5], mat3x2(-1.0, 3.0, 3.0, 0.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(l[6], mat3x2(-7.0, 5.0, 7.0, -5.0, 6.0, -9.0)) && allOk;
	allOk = compare_uvec3((m), uvec3(9u, 8u, 0u)) && allOk;
	allOk = compare_mat3x4(n, mat3x4(-9.0, 3.0, -3.0, -6.0, -8.0, 6.0, -1.0, 3.0, 6.0, 2.0, 4.0, 0.0)) && allOk;
	allOk = compare_uvec3((o[0]), uvec3(8u, 1u, 9u)) && allOk;
	allOk = compare_uvec3((o[1]), uvec3(9u, 8u, 3u)) && allOk;
	allOk = compare_vec4((p), vec4(-1.0, -6.0, 8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec3(true, true, true));
	b = (mat2(-6.0, 3.0, -7.0, 8.0));
	c = (mat2(5.0, -6.0, -7.0, -2.0));
	d = (2);
	e = (mat3x2(3.0, -1.0, 4.0, -4.0, -6.0, -7.0));
	f = (mat3(-7.0, 2.0, 4.0, -4.0, -9.0, 3.0, 8.0, 0.0, -1.0));
	g[0] = (uvec4(0u, 5u, 5u, 4u));
	g[1] = (uvec4(3u, 0u, 1u, 7u));
	g[2] = (uvec4(8u, 4u, 3u, 5u));
	g[3] = (uvec4(2u, 2u, 0u, 5u));
	blockD.h = (mat4(-1.0, 8.0, 6.0, 6.0, -1.0, 7.0, 5.0, 6.0, 1.0, 0.0, -6.0, -6.0, 7.0, -5.0, -6.0, 3.0));
	blockD.i = (bvec4(true, false, true, true));
	blockD.j = (mat4x3(-1.0, 2.0, 3.0, -8.0, 8.0, -6.0, -7.0, -1.0, 6.0, 8.0, -1.0, -1.0));
	blockD.k = (-9);
	l[0] = (mat3x2(7.0, 5.0, 5.0, -3.0, -7.0, -4.0));
	l[1] = (mat3x2(-1.0, 2.0, 7.0, -7.0, -9.0, 1.0));
	l[2] = (mat3x2(-9.0, 3.0, -7.0, -2.0, 3.0, 8.0));
	l[3] = (mat3x2(2.0, -4.0, -1.0, -2.0, 7.0, 7.0));
	l[4] = (mat3x2(-7.0, 0.0, -1.0, 1.0, 8.0, 0.0));
	l[5] = (mat3x2(0.0, 2.0, 4.0, 7.0, 4.0, 2.0));
	l[6] = (mat3x2(5.0, 0.0, 2.0, -8.0, -5.0, -3.0));
	m = (uvec3(1u, 4u, 6u));
	n = (mat3x4(-6.0, -8.0, -2.0, 9.0, 2.0, -3.0, 5.0, -3.0, 5.0, -6.0, 2.0, -4.0));
	o[0] = (uvec3(4u, 6u, 1u));
	o[1] = (uvec3(2u, 2u, 6u));
	p = (vec4(-2.0, 7.0, -8.0, 6.0));
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
	mediump mat4 a;
	lowp uvec2 b;
	highp mat4x2 c;
	highp vec3 d[];
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	bvec3 e;
};
layout(std430, binding = 3) buffer BlockD
{
	mediump uvec4 f[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((d[0]), vec3(8.0, 2.0, 4.0)) && allOk;
	allOk = compare_vec3((d[1]), vec3(-4.0, -4.0, 1.0)) && allOk;
	allOk = compare_vec3((d[2]), vec3(9.0, -1.0, 6.0)) && allOk;
	allOk = compare_bvec3((e), bvec3(true, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat4(5.0, -5.0, -9.0, -4.0, -5.0, -5.0, 2.0, 8.0, 3.0, 0.0, -4.0, 6.0, 9.0, -1.0, -8.0, -3.0));
	b = (uvec2(5u, 5u));
	d[0] = (vec3(9.0, -8.0, -6.0));
	d[1] = (vec3(4.0, 8.0, -8.0));
	d[2] = (vec3(4.0, 6.0, -9.0));
	e = (bvec3(false, true, false));
	blockD.f[0] = (uvec4(1u, 7u, 1u, 6u));
	blockD.f[1] = (uvec4(0u, 9u, 8u, 9u));
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
	lowp uvec3 mA;
};
struct sB
{
	lowp uvec3 mA;
	lowp mat4x3 mB;
	highp float mC;
	highp mat3 mD;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	sA a[6];
	lowp mat4x3 b;
	highp ivec4 c;
	sB d;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.b, mat4x3(5.0, 2.0, -6.0, -7.0, -6.0, -5.0, 4.0, 8.0, -2.0, 7.0, -3.0, -4.0)) && allOk;
	allOk = compare_ivec4((blockB.c), ivec4(6, 5, 0, -6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat4x3(-2.0, -6.0, 0.0, 3.0, 1.0, 7.0, -7.0, -8.0, 0.0, 8.0, -3.0, -3.0));
	blockB.c = (ivec4(9, 6, -4, -8));
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
	highp ivec2 mA;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	highp uvec3 a;
	highp mat2x3 b;
	sA c;
	bvec4 d[];
};
layout(std430, column_major, binding = 2) buffer BlockC
{
	mediump ivec3 e;
	highp float f[];
};
layout(std140, binding = 3) buffer BlockD
{
	bool g[];
} blockD;
layout(std140, binding = 4) buffer BlockE
{
	lowp mat3 h;
	highp float i[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(b, mat2x3(3.0, -7.0, -2.0, 0.0, 7.0, 3.0)) && allOk;
	allOk = compare_ivec2((c.mA), ivec2(9, 1)) && allOk;
	allOk = compare_ivec3((e), ivec3(-8, 8, -5)) && allOk;
	allOk = compare_bool((blockD.g[0]), true) && allOk;
	allOk = compare_mat3(h, mat3(9.0, 7.0, 9.0, 7.0, 3.0, -3.0, 8.0, 1.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (mat2x3(5.0, 2.0, 9.0, -4.0, -1.0, -3.0));
	d[0] = (bvec4(true, false, true, true));
	d[1] = (bvec4(true, true, true, false));
	d[2] = (bvec4(true, false, false, false));
	d[3] = (bvec4(true, false, false, false));
	e = (ivec3(5, 1, 3));
	f[0] = (-3.0);
	f[1] = (-1.0);
	f[2] = (1.0);
	f[3] = (-6.0);
	f[4] = (-5.0);
	blockD.g[0] = (false);
	h = (mat3(-2.0, 8.0, -7.0, 4.0, 0.0, 7.0, 2.0, -4.0, 1.0));
	i[0] = (6.0);
	i[1] = (-2.0);
	i[2] = (5.0);
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
	highp uvec3 a[5];
	lowp mat3 b;
	highp mat3 c;
	mediump mat4 d;
	lowp float e;
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	lowp int f;
	highp mat3x4 g[3];
	lowp vec4 h[];
} blockC[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a[0]), uvec3(1u, 3u, 0u)) && allOk;
	allOk = compare_uvec3((blockB.a[1]), uvec3(2u, 9u, 2u)) && allOk;
	allOk = compare_uvec3((blockB.a[2]), uvec3(2u, 1u, 4u)) && allOk;
	allOk = compare_uvec3((blockB.a[3]), uvec3(4u, 7u, 0u)) && allOk;
	allOk = compare_uvec3((blockB.a[4]), uvec3(6u, 1u, 6u)) && allOk;
	allOk = compare_mat3(blockB.b, mat3(-6.0, -5.0, -1.0, -3.0, 5.0, 3.0, -3.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat4(blockB.d, mat4(2.0, 4.0, 2.0, -1.0, 5.0, -5.0, 7.0, -6.0, 2.0, -9.0, -7.0, 4.0, -9.0, 3.0, 0.0, -6.0)) && allOk;
	allOk = compare_int((blockC[0].f), 3) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (uvec3(7u, 0u, 3u));
	blockB.a[1] = (uvec3(8u, 6u, 6u));
	blockB.a[2] = (uvec3(7u, 9u, 3u));
	blockB.a[3] = (uvec3(3u, 7u, 3u));
	blockB.a[4] = (uvec3(5u, 5u, 4u));
	blockB.d = (mat4(-3.0, -9.0, 7.0, -2.0, -9.0, 9.0, 0.0, -6.0, -7.0, 1.0, -2.0, 8.0, -2.0, 4.0, 9.0, 4.0));
	blockC[0].f = (2);
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
	layout(offset = 0) bvec2 a[1];
	layout(offset = 16) mediump vec4 b;
	layout(offset = 32) bvec2 c;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump uvec2 d;
	layout(offset = 8) bool e;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) mediump ivec2 f;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a[0]), bvec2(true, false)) && allOk;
	allOk = compare_vec4((blockB.b), vec4(7.0, 4.0, 1.0, 9.0)) && allOk;
	allOk = compare_bool((e), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (bvec2(true, false));
	blockB.b = (vec4(-7.0, -8.0, 8.0, 4.0));
	blockB.c = (bvec2(true, true));
	d = (uvec2(1u, 9u));
	f = (ivec2(0, 9));
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
	highp mat2 mA;
	mediump mat3x4 mB[2];
};
struct sB
{
	lowp mat2 mA;
};
struct sC
{
	highp mat4x2 mA;
	mediump uvec2 mB;
	lowp uvec3 mC;
	sB mD;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	mediump vec2 a[7];
	sA b;
	sC c;
	highp mat2x3 d;
	mediump vec3 e;
} blockB[1];
layout(scalar, binding = 2) buffer BlockC
{
	bvec2 f;
	lowp vec4 g;
	highp mat4x3 h;
	bvec4 i;
	lowp ivec2 j;
};
layout(scalar, binding = 3) buffer BlockD
{
	bvec3 k;
	mediump uvec4 l;
	mediump mat4x2 m;
	highp float n[4];
	bvec4 o[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB[0].b.mA, mat2(-9.0, 7.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat3x4(blockB[0].b.mB[0], mat3x4(-7.0, -4.0, 2.0, -4.0, 2.0, -5.0, -3.0, -4.0, 3.0, -7.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat3x4(blockB[0].b.mB[1], mat3x4(-3.0, 5.0, 3.0, 0.0, 3.0, 1.0, 7.0, -8.0, -9.0, -5.0, 8.0, -2.0)) && allOk;
	allOk = compare_vec3((blockB[0].e), vec3(3.0, 3.0, 5.0)) && allOk;
	allOk = compare_vec4((g), vec4(0.0, -9.0, 0.0, -2.0)) && allOk;
	allOk = compare_ivec2((j), ivec2(-9, -3)) && allOk;
	allOk = compare_mat4x2(blockD.m, mat4x2(5.0, 0.0, 2.0, -9.0, 3.0, 8.0, 4.0, 8.0)) && allOk;
	allOk = compare_bvec4((blockD.o[0]), bvec4(false, false, false, false)) && allOk;
	allOk = compare_bvec4((blockD.o[1]), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec4((blockD.o[2]), bvec4(false, false, true, true)) && allOk;
	allOk = compare_bvec4((blockD.o[3]), bvec4(false, false, true, true)) && allOk;
	allOk = compare_bvec4((blockD.o[4]), bvec4(true, false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (vec2(-1.0, 1.0));
	blockB[0].a[1] = (vec2(-1.0, 8.0));
	blockB[0].a[2] = (vec2(9.0, -4.0));
	blockB[0].a[3] = (vec2(-2.0, 9.0));
	blockB[0].a[4] = (vec2(-9.0, 3.0));
	blockB[0].a[5] = (vec2(-8.0, -9.0));
	blockB[0].a[6] = (vec2(-4.0, -3.0));
	blockB[0].b.mA = (mat2(2.0, 4.0, 5.0, 8.0));
	blockB[0].b.mB[0] = (mat3x4(2.0, -6.0, 4.0, -5.0, -5.0, -9.0, -7.0, 7.0, -8.0, 8.0, -9.0, 1.0));
	blockB[0].b.mB[1] = (mat3x4(1.0, 7.0, 4.0, 5.0, 4.0, 8.0, -7.0, 0.0, 5.0, 7.0, -8.0, -8.0));
	blockB[0].c.mA = (mat4x2(1.0, 1.0, 2.0, -5.0, -9.0, 6.0, -9.0, 0.0));
	blockB[0].c.mB = (uvec2(2u, 5u));
	blockB[0].c.mC = (uvec3(9u, 2u, 5u));
	blockB[0].c.mD.mA = (mat2(-4.0, -3.0, -5.0, -5.0));
	blockB[0].d = (mat2x3(-2.0, -6.0, 5.0, -5.0, -9.0, -8.0));
	blockB[0].e = (vec3(2.0, -9.0, 9.0));
	f = (bvec2(true, false));
	h = (mat4x3(4.0, -4.0, 7.0, -6.0, 6.0, -2.0, 0.0, 4.0, 5.0, 7.0, -5.0, -1.0));
	i = (bvec4(true, true, false, false));
	j = (ivec2(-8, -4));
	blockD.k = (bvec3(false, true, true));
	blockD.l = (uvec4(6u, 4u, 9u, 0u));
	blockD.m = (mat4x2(7.0, -6.0, 8.0, -9.0, -7.0, -7.0, -9.0, -5.0));
	blockD.o[0] = (bvec4(true, false, false, true));
	blockD.o[1] = (bvec4(false, true, false, true));
	blockD.o[2] = (bvec4(false, false, true, false));
	blockD.o[3] = (bvec4(false, false, true, true));
	blockD.o[4] = (bvec4(false, false, true, true));
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
	f16vec2 a;
	i16vec3 b;
	i16vec2 c;
	i16vec4 d;
};
layout(std140, binding = 2) buffer BlockC
{
	bvec2 e;
};
layout(std430, binding = 3) buffer BlockD
{
	u16vec2 f[1];
	highp vec2 g;
	u16vec4 h;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(c), ivec2(-4, 4)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = f16vec2(vec2(-1.0, -4.0));
	b = i16vec3(ivec3(2, -1, 2));
	d = i16vec4(ivec4(7, -5, 5, -3));
	e = (bvec2(true, false));
	f[0] = u16vec2(uvec2(9u, 3u));
	h = u16vec4(uvec4(5u, 8u, 0u, 8u));
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
	lowp uint a;
	u16vec4 b;
	u16vec3 c[4];
	lowp uvec2 d[];
} blockB;

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 0u) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.b), uvec4(2u, 0u, 4u, 4u)) && allOk;
	allOk = compare_uvec2((blockB.d[0]), uvec2(1u, 5u)) && allOk;
	allOk = compare_uvec2((blockB.d[1]), uvec2(6u, 5u)) && allOk;
	allOk = compare_uvec2((blockB.d[2]), uvec2(3u, 0u)) && allOk;
	allOk = compare_uvec2((blockB.d[3]), uvec2(2u, 4u)) && allOk;
	allOk = compare_uvec2((blockB.d[4]), uvec2(8u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (4u);
	blockB.b = u16vec4(uvec4(1u, 0u, 6u, 8u));
	blockB.d[0] = (uvec2(9u, 9u));
	blockB.d[1] = (uvec2(7u, 3u));
	blockB.d[2] = (uvec2(9u, 3u));
	blockB.d[3] = (uvec2(4u, 5u));
	blockB.d[4] = (uvec2(6u, 1u));
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
	f16vec3 a[1];
	bvec3 b[];
} blockB[2];
layout(std140, column_major, binding = 2) buffer BlockC
{
	mediump mat3 c;
	f16vec2 d[];
};
layout(std140, column_major, binding = 3) buffer BlockD
{
	lowp float e;
	float16_t f;
	highp float g[1];
	highp vec4 h;
	u16vec2 i[];
} blockD[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB[0].b[0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((blockB[1].b[0]), bvec3(true, true, true)) && allOk;
	allOk = compare_float((blockD[0].e), 0.0) && allOk;
	allOk = compare_float16_t(float(blockD[0].f), -9.0) && allOk;
	allOk = compare_float((blockD[0].g[0]), -3.0) && allOk;
	allOk = compare_vec4((blockD[0].h), vec4(-2.0, 0.0, -6.0, -3.0)) && allOk;
	allOk = compare_float((blockD[1].e), -5.0) && allOk;
	allOk = compare_float16_t(float(blockD[1].f), 8.0) && allOk;
	allOk = compare_float((blockD[1].g[0]), 8.0) && allOk;
	allOk = compare_vec4((blockD[1].h), vec4(9.0, 6.0, -2.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = f16vec3(vec3(-6.0, -2.0, 3.0));
	blockB[0].b[0] = (bvec3(true, true, true));
	blockB[1].a[0] = f16vec3(vec3(9.0, 5.0, -4.0));
	blockB[1].b[0] = (bvec3(true, true, false));
	c = (mat3(-7.0, 1.0, 3.0, 2.0, -7.0, 4.0, 9.0, -8.0, -1.0));
	d[0] = f16vec2(vec2(3.0, -1.0));
	blockD[0].e = (4.0);
	blockD[0].f = float16_t(1.0);
	blockD[0].h = (vec4(-8.0, -1.0, -5.0, 7.0));
	blockD[1].e = (-8.0);
	blockD[1].f = float16_t(6.0);
	blockD[1].h = (vec4(-9.0, 8.0, -8.0, -5.0));
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
	lowp mat4x2 mA;
};
layout(scalar, row_major, binding = 1) buffer BlockB
{
	highp mat3x2 a;
	lowp mat3x2 b;
	sA c[];
} blockB;
layout(scalar, binding = 2) buffer BlockC
{
	lowp ivec4 d;
	highp mat2 e;
	mediump vec3 f[6];
	mediump mat4x2 g[];
} blockC[1];
layout(scalar, row_major, binding = 3) buffer BlockD
{
	highp mat4x3 h[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.a, mat3x2(6.0, 1.0, -3.0, -7.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(blockB.c[0].mA, mat4x2(-5.0, -3.0, -5.0, -5.0, 4.0, 7.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat4x2(blockB.c[1].mA, mat4x2(0.0, 7.0, 5.0, 6.0, 4.0, -5.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(blockB.c[2].mA, mat4x2(9.0, -2.0, -7.0, 9.0, -7.0, 5.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(blockB.c[3].mA, mat4x2(9.0, -5.0, -4.0, 1.0, -5.0, -5.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat4x2(blockB.c[4].mA, mat4x2(2.0, 9.0, 9.0, 1.0, -8.0, 6.0, 6.0, 9.0)) && allOk;
	allOk = compare_ivec4((blockC[0].d), ivec4(-8, -6, 8, 7)) && allOk;
	allOk = compare_vec3((blockC[0].f[0]), vec3(-8.0, 1.0, -5.0)) && allOk;
	allOk = compare_vec3((blockC[0].f[1]), vec3(9.0, 3.0, -9.0)) && allOk;
	allOk = compare_vec3((blockC[0].f[2]), vec3(1.0, 1.0, 8.0)) && allOk;
	allOk = compare_vec3((blockC[0].f[3]), vec3(-1.0, -1.0, -3.0)) && allOk;
	allOk = compare_vec3((blockC[0].f[4]), vec3(-6.0, -1.0, -6.0)) && allOk;
	allOk = compare_vec3((blockC[0].f[5]), vec3(4.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].g[0], mat4x2(2.0, 8.0, 7.0, 8.0, -8.0, -2.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].g[1], mat4x2(-5.0, -3.0, 8.0, -5.0, -1.0, 2.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].g[2], mat4x2(-8.0, 2.0, 9.0, 1.0, 5.0, 5.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].g[3], mat4x2(6.0, 2.0, -3.0, 6.0, -2.0, 3.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].g[4], mat4x2(-3.0, 1.0, 4.0, 0.0, -5.0, 0.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].g[5], mat4x2(-4.0, 4.0, 3.0, -8.0, 9.0, -1.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(h[0], mat4x3(3.0, 2.0, -9.0, 1.0, -2.0, -3.0, -7.0, 1.0, -1.0, -3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x3(h[1], mat4x3(4.0, 2.0, 9.0, -8.0, 0.0, -8.0, -8.0, -1.0, -5.0, 4.0, -4.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat3x2(5.0, 5.0, -8.0, -6.0, -3.0, 3.0));
	blockB.c[0].mA = (mat4x2(7.0, -9.0, 3.0, -4.0, -3.0, 8.0, 2.0, -3.0));
	blockB.c[1].mA = (mat4x2(-3.0, 9.0, 5.0, -3.0, 1.0, 7.0, 7.0, 7.0));
	blockB.c[2].mA = (mat4x2(-9.0, -4.0, 8.0, 1.0, 5.0, 6.0, 9.0, -5.0));
	blockB.c[3].mA = (mat4x2(-6.0, -3.0, 2.0, -1.0, 3.0, 7.0, -1.0, -8.0));
	blockB.c[4].mA = (mat4x2(4.0, 7.0, -1.0, 4.0, -6.0, -5.0, 2.0, 3.0));
	blockC[0].d = (ivec4(9, 1, -4, -2));
	blockC[0].f[0] = (vec3(9.0, -2.0, -8.0));
	blockC[0].f[1] = (vec3(-8.0, -7.0, 6.0));
	blockC[0].f[2] = (vec3(6.0, -1.0, -4.0));
	blockC[0].f[3] = (vec3(-9.0, 9.0, -6.0));
	blockC[0].f[4] = (vec3(-3.0, 7.0, 1.0));
	blockC[0].f[5] = (vec3(-7.0, 3.0, -6.0));
	blockC[0].g[0] = (mat4x2(-9.0, 7.0, -4.0, -1.0, -3.0, -5.0, -8.0, -7.0));
	blockC[0].g[1] = (mat4x2(7.0, -1.0, 8.0, -8.0, 1.0, -3.0, 5.0, -1.0));
	blockC[0].g[2] = (mat4x2(-4.0, 7.0, 0.0, 6.0, 9.0, -7.0, -3.0, -6.0));
	blockC[0].g[3] = (mat4x2(-9.0, -6.0, 8.0, 3.0, 4.0, -2.0, -9.0, 0.0));
	blockC[0].g[4] = (mat4x2(5.0, 0.0, 7.0, -9.0, 4.0, 7.0, -7.0, 6.0));
	blockC[0].g[5] = (mat4x2(0.0, -3.0, 5.0, -1.0, -9.0, -3.0, 5.0, 8.0));
	h[0] = (mat4x3(-4.0, -9.0, -3.0, 9.0, 6.0, -4.0, 4.0, 5.0, 5.0, -5.0, 4.0, 3.0));
	h[1] = (mat4x3(-5.0, -6.0, -1.0, -5.0, -9.0, -4.0, -2.0, -8.0, -5.0, -5.0, 5.0, -5.0));
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
	highp ivec3 mA;
};
layout(scalar, binding = 1) readonly buffer BlockB
{
	highp mat3x2 a;
	lowp ivec4 b;
	highp mat3x2 c[];
} blockB;
layout(scalar, column_major, binding = 2) buffer BlockC
{
	lowp float d;
	sA e;
	u16vec2 f;
	highp vec2 g[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.b), ivec4(7, 6, -3, 5)) && allOk;
	allOk = compare_float((blockC.d), 7.0) && allOk;
	allOk = compare_ivec3((blockC.e.mA), ivec3(-8, -7, -8)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f), uvec2(5u, 1u)) && allOk;
	allOk = compare_vec2((blockC.g[0]), vec2(-6.0, 6.0)) && allOk;
	allOk = compare_vec2((blockC.g[1]), vec2(-7.0, -5.0)) && allOk;
	allOk = compare_vec2((blockC.g[2]), vec2(-7.0, 2.0)) && allOk;
	allOk = compare_vec2((blockC.g[3]), vec2(-8.0, -2.0)) && allOk;
	allOk = compare_vec2((blockC.g[4]), vec2(6.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.g[0] = (vec2(-3.0, -4.0));
	blockC.g[1] = (vec2(-9.0, 4.0));
	blockC.g[2] = (vec2(8.0, 8.0));
	blockC.g[3] = (vec2(2.0, 1.0));
	blockC.g[4] = (vec2(7.0, -1.0));
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
	bvec2 a;
	uint16_t b[1];
	highp int c;
} blockB[];

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB[nonuniformEXT(0)].c), -1) && allOk;
	allOk = compare_int((blockB[nonuniformEXT(1)].c), -5) && allOk;
	allOk = compare_int((blockB[nonuniformEXT(2)].c), -4) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b[0] = uint16_t(2u);
	blockB[nonuniformEXT(0)].c = (-4);
	blockB[nonuniformEXT(1)].b[0] = uint16_t(1u);
	blockB[nonuniformEXT(1)].c = (5);
	blockB[nonuniformEXT(2)].b[0] = uint16_t(4u);
	blockB[nonuniformEXT(2)].c = (3);
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

layout(scalar, row_major, binding = 1) buffer BlockB
{
	highp mat2 a;
	i16vec4 b;
	i16vec3 c;
	highp uint d;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB[nonuniformEXT(0)].a, mat2(8.0, -1.0, -5.0, 0.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB[nonuniformEXT(0)].c), ivec3(8, -1, -8)) && allOk;
	allOk = compare_mat2(blockB[nonuniformEXT(1)].a, mat2(-9.0, 3.0, 5.0, -9.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB[nonuniformEXT(1)].c), ivec3(2, 1, -8)) && allOk;
	allOk = compare_mat2(blockB[nonuniformEXT(2)].a, mat2(-8.0, 9.0, -7.0, 8.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB[nonuniformEXT(2)].c), ivec3(3, 4, -7)) && allOk;
	allOk = compare_mat2(blockB[nonuniformEXT(3)].a, mat2(1.0, -5.0, 0.0, 4.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB[nonuniformEXT(3)].c), ivec3(3, 1, 6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (mat2(8.0, -4.0, 2.0, 3.0));
	blockB[nonuniformEXT(0)].b = i16vec4(ivec4(-3, 7, -3, 4));
	blockB[nonuniformEXT(0)].c = i16vec3(ivec3(3, -9, 5));
	blockB[nonuniformEXT(0)].d = (6u);
	blockB[nonuniformEXT(1)].a = (mat2(0.0, 2.0, 4.0, -9.0));
	blockB[nonuniformEXT(1)].b = i16vec4(ivec4(-8, 9, -6, -4));
	blockB[nonuniformEXT(1)].c = i16vec3(ivec3(5, -4, -6));
	blockB[nonuniformEXT(1)].d = (6u);
	blockB[nonuniformEXT(2)].a = (mat2(-2.0, 5.0, -8.0, -4.0));
	blockB[nonuniformEXT(2)].b = i16vec4(ivec4(-5, -9, -2, 8));
	blockB[nonuniformEXT(2)].c = i16vec3(ivec3(0, -1, 1));
	blockB[nonuniformEXT(2)].d = (8u);
	blockB[nonuniformEXT(3)].a = (mat2(-4.0, -7.0, -1.0, 1.0));
	blockB[nonuniformEXT(3)].b = i16vec4(ivec4(-5, 2, 6, 8));
	blockB[nonuniformEXT(3)].c = i16vec3(ivec3(-7, 5, 3));
	blockB[nonuniformEXT(3)].d = (8u);
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
	u8vec4 a;
	bvec4 b;
	i8vec4 c;
	bvec4 d;
} blockB;
layout(std140, binding = 2) readonly buffer BlockC
{
	mediump ivec3 e[1];
};
layout(std430, binding = 3) buffer BlockD
{
	int8_t f;
	highp uint g;
	highp vec4 h;
};
layout(std430, binding = 4) buffer BlockE
{
	lowp uvec2 i;
	highp uvec4 j;
	i8vec3 k;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(blockB.a), uvec4(7u, 1u, 2u, 9u)) && allOk;
	allOk = compare_bvec4((blockB.b), bvec4(true, false, false, false)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.c), ivec4(4294967293, 1, 4294967293, 8)) && allOk;
	allOk = compare_bvec4((blockB.d), bvec4(true, true, false, true)) && allOk;
	allOk = compare_uvec4((j), uvec4(4u, 7u, 3u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u8vec4(uvec4(7u, 8u, 1u, 1u));
	blockB.b = (bvec4(true, false, false, false));
	blockB.c = i8vec4(ivec4(7, 4294967295, 6, 5));
	blockB.d = (bvec4(true, false, true, true));
	f = int8_t(0);
	g = (6u);
	i = (uvec2(7u, 7u));
	j = (uvec4(2u, 9u, 4u, 4u));
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
	lowp uvec3 mA;
	i8vec3 mB;
	mediump mat3 mC;
};
struct sB
{
	bool mA;
	mediump mat4 mB;
	lowp mat4 mC;
};
struct sC
{
	i8vec2 mA;
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	sA a;
	bool b;
	i8vec2 c[];
} blockB;
layout(std140, row_major, binding = 2) buffer BlockC
{
	sB d;
	mediump mat4x3 e;
	highp uvec3 f[1];
	mediump uvec2 g;
	highp mat3x4 h[];
} blockC;
layout(std140, column_major, binding = 3) buffer BlockD
{
	mediump uvec2 i;
	bvec3 j;
	highp uvec3 k;
	sC l;
	lowp mat4x3 m[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a.mA), uvec3(5u, 7u, 4u)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.a.mB), ivec3(7, 4294967291, 2)) && allOk;
	allOk = compare_mat3(blockB.a.mC, mat3(-1.0, -8.0, 2.0, -6.0, 5.0, -7.0, 2.0, 8.0, 8.0)) && allOk;
	allOk = compare_bool((blockB.b), true) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.c[0]), ivec2(7, 4294967295)) && allOk;
	allOk = compare_bool((blockC.d.mA), false) && allOk;
	allOk = compare_mat4(blockC.d.mB, mat4(2.0, 1.0, 0.0, 4.0, 6.0, 6.0, -1.0, 0.0, 1.0, -8.0, -1.0, -1.0, 1.0, -9.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4(blockC.d.mC, mat4(-9.0, 0.0, 6.0, -8.0, 1.0, 5.0, 7.0, 5.0, 0.0, -7.0, -7.0, 1.0, 8.0, 6.0, 6.0, -4.0)) && allOk;
	allOk = compare_uvec3((blockC.f[0]), uvec3(9u, 9u, 3u)) && allOk;
	allOk = compare_uvec2((blockC.g), uvec2(9u, 7u)) && allOk;
	allOk = compare_mat3x4(blockC.h[0], mat3x4(-6.0, 9.0, 5.0, -7.0, -3.0, 9.0, 9.0, -3.0, -4.0, 1.0, 5.0, -9.0)) && allOk;
	allOk = compare_uvec2((i), uvec2(1u, 3u)) && allOk;
	allOk = compare_bvec3((j), bvec3(true, false, true)) && allOk;
	allOk = compare_uvec3((k), uvec3(1u, 5u, 0u)) && allOk;
	allOk = compare_i8vec2(ivec2(l.mA), ivec2(2, 2)) && allOk;
	allOk = compare_mat4x3(m[0], mat4x3(3.0, -8.0, -6.0, 3.0, -4.0, -6.0, 3.0, -5.0, 8.0, 3.0, 5.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA = (uvec3(9u, 2u, 5u));
	blockB.a.mB = i8vec3(ivec3(4294967289, 6, 2));
	blockB.a.mC = (mat3(-8.0, 7.0, 6.0, -4.0, 5.0, 7.0, 9.0, -2.0, 6.0));
	blockB.b = (true);
	blockC.d.mA = (false);
	blockC.d.mB = (mat4(1.0, 5.0, -9.0, 9.0, 0.0, 2.0, 7.0, -8.0, -8.0, 6.0, 6.0, 1.0, -8.0, 6.0, 3.0, 4.0));
	blockC.d.mC = (mat4(-5.0, 7.0, -6.0, 5.0, 0.0, 9.0, 0.0, -8.0, -7.0, 5.0, -8.0, 0.0, -1.0, -4.0, -2.0, -6.0));
	blockC.e = (mat4x3(9.0, -1.0, -5.0, 3.0, 8.0, 8.0, -2.0, 4.0, 0.0, 9.0, 9.0, 3.0));
	blockC.f[0] = (uvec3(6u, 6u, 2u));
	blockC.h[0] = (mat3x4(7.0, -5.0, -9.0, 1.0, 3.0, 6.0, 6.0, -3.0, 2.0, 3.0, 8.0, -2.0));
	i = (uvec2(1u, 5u));
	k = (uvec3(0u, 1u, 5u));
	l.mA = i8vec2(ivec2(0, 4294967290));
	m[0] = (mat4x3(-6.0, 7.0, 9.0, 0.0, -6.0, 7.0, 4.0, -6.0, -6.0, 1.0, -1.0, -9.0));
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
	lowp mat3x4 mA;
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	lowp mat2 a;
	bvec4 b;
	uint8_t c;
	mediump vec4 d;
	bool e[];
};
layout(std430, binding = 2) buffer BlockC
{
	highp mat2x3 f;
	lowp int g;
	i8vec3 h;
	uint8_t i;
	u8vec3 j[];
};
layout(std430, binding = 3) buffer BlockD
{
	highp mat3x4 k;
	lowp vec3 l;
	bool m[1];
};
layout(std430, binding = 4) buffer BlockE
{
	mediump mat4x3 n;
	sA o;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(a, mat2(6.0, 6.0, -6.0, -3.0)) && allOk;
	allOk = compare_uint8_t(uint(c), 1u) && allOk;
	allOk = compare_bool((e[0]), false) && allOk;
	allOk = compare_mat2x3(f, mat2x3(-2.0, -2.0, 1.0, 1.0, 7.0, -1.0)) && allOk;
	allOk = compare_int((g), 9) && allOk;
	allOk = compare_i8vec3(ivec3(h), ivec3(4294967291, 8, 4)) && allOk;
	allOk = compare_uint8_t(uint(i), 7u) && allOk;
	allOk = compare_vec3((l), vec3(5.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat3x4(o.mA, mat3x4(-9.0, 6.0, 6.0, 8.0, -1.0, 2.0, 7.0, 8.0, 6.0, 7.0, -7.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	d = (vec4(1.0, 9.0, -5.0, 9.0));
	e[0] = (false);
	g = (5);
	h = i8vec3(ivec3(3, 9, 8));
	i = uint8_t(3u);
	j[0] = u8vec3(uvec3(4u, 4u, 3u));
	l = (vec3(-4.0, -5.0, 7.0));
	m[0] = (true);
	n = (mat4x3(0.0, -7.0, 2.0, 1.0, 9.0, 2.0, -9.0, -2.0, -7.0, 8.0, 8.0, 8.0));
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
	mediump vec2 a;
	highp mat4x2 b;
	lowp mat4 c;
	lowp mat3x2 d[];
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	mediump uvec4 e;
	lowp mat3 f;
	mediump vec3 g[];
} blockC[3];
layout(std140, column_major, binding = 3) buffer BlockD
{
	u8vec4 h;
	mediump uint i[1];
	bvec3 j;
	bvec2 k;
	bvec2 l[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((a), vec2(1.0, -6.0)) && allOk;
	allOk = compare_mat4(c, mat4(4.0, 1.0, 1.0, 1.0, -7.0, 9.0, -4.0, 5.0, 3.0, 5.0, -4.0, 6.0, 8.0, -4.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat3x2(d[0], mat3x2(0.0, 1.0, 1.0, 6.0, -3.0, 6.0)) && allOk;
	allOk = compare_uvec4((blockC[0].e), uvec4(2u, 3u, 6u, 6u)) && allOk;
	allOk = compare_uvec4((blockC[1].e), uvec4(2u, 5u, 8u, 9u)) && allOk;
	allOk = compare_uvec4((blockC[2].e), uvec4(7u, 6u, 7u, 7u)) && allOk;
	allOk = compare_uint((i[0]), 9u) && allOk;
	allOk = compare_bvec3((j), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec2((k), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((l[0]), bvec2(false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec2(9.0, 7.0));
	blockC[0].e = (uvec4(6u, 7u, 8u, 1u));
	blockC[0].g[0] = (vec3(-1.0, 4.0, -2.0));
	blockC[1].e = (uvec4(6u, 5u, 8u, 0u));
	blockC[1].g[0] = (vec3(-9.0, -8.0, 3.0));
	blockC[2].e = (uvec4(4u, 6u, 9u, 5u));
	blockC[2].g[0] = (vec3(-8.0, 8.0, 1.0));
	h = u8vec4(uvec4(1u, 8u, 9u, 0u));
	i[0] = (8u);
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
	mediump mat3x4 a;
	bool b;
	highp vec3 c;
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	highp uvec3 d[][6];
};
layout(std140, row_major, binding = 3) buffer BlockD
{
	int8_t e[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.b), false) && allOk;
	allOk = compare_vec3((blockB.c), vec3(-6.0, -3.0, 2.0)) && allOk;
	allOk = compare_int8_t(int(blockD.e[0]), 1) && allOk;
	allOk = compare_int8_t(int(blockD.e[1]), 4294967288) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (true);
	blockB.c = (vec3(-6.0, -3.0, 9.0));
	d[0][0] = (uvec3(4u, 5u, 1u));
	d[0][1] = (uvec3(8u, 2u, 8u));
	d[0][2] = (uvec3(1u, 9u, 6u));
	d[0][3] = (uvec3(9u, 7u, 2u));
	d[0][4] = (uvec3(5u, 3u, 0u));
	d[0][5] = (uvec3(0u, 4u, 4u));
	blockD.e[0] = int8_t(4294967290);
	blockD.e[1] = int8_t(9);
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
	layout(offset = 0) mediump uvec3 a;
	layout(offset = 12) i8vec4 b;
	layout(offset = 16) lowp float c;
	layout(offset = 32) bvec4 d;
} blockB[1];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump ivec4 e;
	layout(offset = 16) i8vec2 f;
} blockC[1];
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) bvec4 g;
} blockD[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB[0].a), uvec3(9u, 7u, 5u)) && allOk;
	allOk = compare_float((blockB[0].c), -2.0) && allOk;
	allOk = compare_bvec4((blockB[0].d), bvec4(true, true, true, true)) && allOk;
	allOk = compare_ivec4((blockC[0].e), ivec4(5, 1, 5, -7)) && allOk;
	allOk = compare_bvec4((blockD[0].g), bvec4(false, false, false, false)) && allOk;
	allOk = compare_bvec4((blockD[1].g), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec4((blockD[2].g), bvec4(false, true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = i8vec4(ivec4(4294967290, 3, 5, 4294967295));
	blockB[0].c = (2.0);
	blockB[0].d = (bvec4(false, true, true, true));
	blockC[0].f = i8vec2(ivec2(3, 4294967289));
	blockD[0].g = (bvec4(false, true, false, false));
	blockD[1].g = (bvec4(false, false, false, true));
	blockD[2].g = (bvec4(true, true, false, false));
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
	layout(offset = 0) i8vec4 a;
	layout(offset = 8) bvec2 b[1];
	layout(offset = 16) lowp ivec3 c;
	layout(offset = 28) u8vec2 d;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump vec4 e;
	layout(offset = 16) highp uvec3 f;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) u8vec3 g;
	layout(offset = 4) highp uvec3 h;
	layout(offset = 16) u8vec4 i[1];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(blockB.a), ivec4(6, 4294967291, 3, 0)) && allOk;
	allOk = compare_bvec2((blockB.b[0]), bvec2(true, false)) && allOk;
	allOk = compare_ivec3((blockB.c), ivec3(4, 6, 2)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB.d), uvec2(7u, 0u)) && allOk;
	allOk = compare_uvec3((blockC.f), uvec3(3u, 2u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD.g), uvec3(1u, 6u, 4u)) && allOk;
	allOk = compare_uvec3((blockD.h), uvec3(7u, 0u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD.i[0]), uvec4(1u, 7u, 9u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (bvec2(false, true));
	blockB.c = (ivec3(-8, 0, 4));
	blockB.d = u8vec2(uvec2(3u, 8u));
	blockC.e = (vec4(0.0, -1.0, -8.0, -1.0));
	blockD.g = u8vec3(uvec3(7u, 9u, 7u));
	blockD.h = (uvec3(8u, 8u, 0u));
	blockD.i[0] = u8vec4(uvec4(8u, 9u, 6u, 6u));
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
	highp ivec2 mA;
};
struct sB
{
	sA mA;
	lowp int mB;
	u8vec2 mC;
	highp mat3x4 mD;
};
struct sC
{
	mediump uvec4 mA;
};
layout(scalar, binding = 1) buffer BlockB
{
	highp vec4 a[3];
	highp vec3 b[][4];
};
layout(scalar, column_major, binding = 2) buffer BlockC
{
	highp mat3x2 c;
	highp uvec2 d[1];
	lowp uvec2 e;
	highp uvec3 f;
	highp mat4x3 g[];
};
layout(scalar, binding = 3) buffer BlockD
{
	bool h;
	highp mat3x2 i;
	sB j[4];
	sC k[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((a[0]), vec4(-5.0, 5.0, -6.0, -9.0)) && allOk;
	allOk = compare_vec4((a[1]), vec4(9.0, -5.0, 7.0, 7.0)) && allOk;
	allOk = compare_vec4((a[2]), vec4(0.0, 5.0, -7.0, -5.0)) && allOk;
	allOk = compare_uvec2((e), uvec2(9u, 5u)) && allOk;
	allOk = compare_uvec3((f), uvec3(4u, 9u, 9u)) && allOk;
	allOk = compare_mat4x3(g[0], mat4x3(7.0, 1.0, -4.0, 7.0, -6.0, 0.0, 6.0, 8.0, 5.0, 9.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat4x3(g[1], mat4x3(2.0, 3.0, 3.0, -7.0, 7.0, -3.0, -3.0, 8.0, 3.0, -1.0, 0.0, -6.0)) && allOk;
	allOk = compare_bool((h), false) && allOk;
	allOk = compare_mat3x2(i, mat3x2(-3.0, -5.0, 2.0, -9.0, 0.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (vec4(3.0, -4.0, 2.0, 2.0));
	a[1] = (vec4(4.0, 9.0, -2.0, -4.0));
	a[2] = (vec4(-9.0, -2.0, 0.0, 9.0));
	b[0][0] = (vec3(8.0, -5.0, 4.0));
	b[0][1] = (vec3(-6.0, -8.0, -5.0));
	b[0][2] = (vec3(0.0, 4.0, 7.0));
	b[0][3] = (vec3(3.0, -2.0, 9.0));
	f = (uvec3(1u, 4u, 8u));
	g[0] = (mat4x3(-8.0, -8.0, 9.0, 4.0, 4.0, -3.0, 8.0, -6.0, -2.0, -6.0, -9.0, 2.0));
	g[1] = (mat4x3(6.0, -9.0, -4.0, 6.0, 0.0, -2.0, -5.0, -5.0, -4.0, -9.0, 7.0, -1.0));
	h = (false);
	i = (mat3x2(9.0, 2.0, 5.0, -2.0, -5.0, 0.0));
	j[0].mA.mA = (ivec2(-4, 9));
	j[0].mB = (2);
	j[0].mC = u8vec2(uvec2(4u, 0u));
	j[0].mD = (mat3x4(-8.0, 6.0, -7.0, 0.0, 1.0, -9.0, -4.0, 1.0, 6.0, 0.0, 2.0, 3.0));
	j[1].mA.mA = (ivec2(0, -5));
	j[1].mB = (7);
	j[1].mC = u8vec2(uvec2(8u, 8u));
	j[1].mD = (mat3x4(6.0, -6.0, -2.0, 4.0, 9.0, -7.0, -1.0, 9.0, -3.0, -1.0, 7.0, -6.0));
	j[2].mA.mA = (ivec2(8, -4));
	j[2].mB = (8);
	j[2].mC = u8vec2(uvec2(1u, 5u));
	j[2].mD = (mat3x4(1.0, 9.0, -8.0, 6.0, -5.0, -2.0, 2.0, 1.0, 7.0, -9.0, 9.0, -8.0));
	j[3].mA.mA = (ivec2(6, -6));
	j[3].mB = (7);
	j[3].mC = u8vec2(uvec2(1u, 9u));
	j[3].mD = (mat3x4(6.0, 3.0, -5.0, -6.0, 4.0, 2.0, 7.0, -8.0, -9.0, -7.0, 0.0, -7.0));
	k[0].mA = (uvec4(3u, 2u, 6u, 8u));
	k[1].mA = (uvec4(5u, 4u, 2u, 4u));
	k[2].mA = (uvec4(9u, 0u, 9u, 4u));
	k[3].mA = (uvec4(2u, 0u, 2u, 6u));
	k[4].mA = (uvec4(3u, 0u, 7u, 5u));
	k[5].mA = (uvec4(8u, 5u, 3u, 3u));
	k[6].mA = (uvec4(8u, 0u, 7u, 4u));
	k[7].mA = (uvec4(5u, 9u, 8u, 8u));
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
	mediump uint mA;
	highp mat4 mB;
	bvec2 mC;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	sA a;
	lowp mat2 b;
	highp uvec3 c[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((a.mA), 4u) && allOk;
	allOk = compare_mat4(a.mB, mat4(7.0, 9.0, 9.0, 0.0, -6.0, 2.0, 5.0, 2.0, -3.0, -7.0, 8.0, 0.0, 3.0, 4.0, 2.0, 2.0)) && allOk;
	allOk = compare_bvec2((a.mC), bvec2(false, true)) && allOk;
	allOk = compare_mat2(b, mat2(1.0, -5.0, -5.0, -6.0)) && allOk;
	allOk = compare_uvec3((c[0]), uvec3(8u, 5u, 1u)) && allOk;
	allOk = compare_uvec3((c[1]), uvec3(0u, 2u, 2u)) && allOk;
	allOk = compare_uvec3((c[2]), uvec3(3u, 6u, 1u)) && allOk;
	allOk = compare_uvec3((c[3]), uvec3(5u, 3u, 2u)) && allOk;
	allOk = compare_uvec3((c[4]), uvec3(4u, 5u, 3u)) && allOk;
	allOk = compare_uvec3((c[5]), uvec3(0u, 5u, 2u)) && allOk;
	allOk = compare_uvec3((c[6]), uvec3(3u, 0u, 1u)) && allOk;
	allOk = compare_uvec3((c[7]), uvec3(1u, 8u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a.mA = (4u);
	a.mB = (mat4(-4.0, 3.0, 3.0, -9.0, 0.0, 4.0, 3.0, -9.0, -2.0, 3.0, -5.0, 2.0, 8.0, -2.0, 2.0, -4.0));
	a.mC = (bvec2(true, false));
	c[0] = (uvec3(4u, 7u, 8u));
	c[1] = (uvec3(6u, 9u, 0u));
	c[2] = (uvec3(0u, 8u, 2u));
	c[3] = (uvec3(4u, 6u, 6u));
	c[4] = (uvec3(0u, 6u, 6u));
	c[5] = (uvec3(0u, 3u, 9u));
	c[6] = (uvec3(1u, 4u, 7u));
	c[7] = (uvec3(5u, 4u, 3u));
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
	i8vec2 a;
} blockB[];

bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = i8vec2(ivec2(0, 9));
	blockB[nonuniformEXT(1)].a = i8vec2(ivec2(5, 4294967289));
	blockB[nonuniformEXT(2)].a = i8vec2(ivec2(4294967290, 9));
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
	mediump mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var, mat3(6.0, -1.0, -9.0, 1.0, -6.0, 5.0, 1.0, 0.0, -8.0)) && allOk;
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
	mediump mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 6.0) && allOk;
	allOk = compare_float(var[0][1], 6.0) && allOk;
	allOk = compare_float(var[0][2], 5.0) && allOk;
	allOk = compare_float(var[1][0], 3.0) && allOk;
	allOk = compare_float(var[1][1], 1.0) && allOk;
	allOk = compare_float(var[1][2], -8.0) && allOk;
	allOk = compare_float(var[2][0], -9.0) && allOk;
	allOk = compare_float(var[2][1], 1.0) && allOk;
	allOk = compare_float(var[2][2], -6.0) && allOk;
	allOk = compare_vec3(var[0], vec3(6.0, 6.0, 5.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(3.0, 1.0, -8.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-9.0, 1.0, -6.0)) && allOk;
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
	mediump mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 9.0) && allOk;
	allOk = compare_float(var[0][1], 7.0) && allOk;
	allOk = compare_float(var[0][2], 8.0) && allOk;
	allOk = compare_float(var[0][3], -7.0) && allOk;
	allOk = compare_float(var[1][0], 6.0) && allOk;
	allOk = compare_float(var[1][1], 0.0) && allOk;
	allOk = compare_float(var[1][2], -7.0) && allOk;
	allOk = compare_float(var[1][3], -4.0) && allOk;
	allOk = compare_float(var[2][0], -9.0) && allOk;
	allOk = compare_float(var[2][1], -9.0) && allOk;
	allOk = compare_float(var[2][2], -8.0) && allOk;
	allOk = compare_float(var[2][3], 6.0) && allOk;
	allOk = compare_float(var[3][0], 7.0) && allOk;
	allOk = compare_float(var[3][1], 0.0) && allOk;
	allOk = compare_float(var[3][2], 3.0) && allOk;
	allOk = compare_float(var[3][3], 1.0) && allOk;
	allOk = compare_vec4(var[0], vec4(9.0, 7.0, 8.0, -7.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(6.0, 0.0, -7.0, -4.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-9.0, -9.0, -8.0, 6.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(7.0, 0.0, 3.0, 1.0)) && allOk;
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

layout(std140, column_major, binding = 1) readonly buffer Block
{
	highp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var, mat4x2(-7.0, 9.0, -7.0, -8.0, 6.0, -6.0, -5.0, 4.0)) && allOk;
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
	highp ivec4 var;
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((var), ivec4(5, -9, -6, -4)) && allOk;
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
	highp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var, mat4(5.0, 3.0, 1.0, 5.0, -4.0, 3.0, -7.0, 3.0, -7.0, -6.0, 6.0, -4.0, 1.0, 8.0, -5.0, 2.0)) && allOk;
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
	u8vec3 var;
};

bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(var), uvec3(4u, 3u, 0u)) && allOk;
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
	int padding;
	lowp ivec3 var;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((padding), -1) && allOk;
	allOk = compare_ivec3((var), ivec3(-8, 1, -9)) && allOk;
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
	bool var;
};

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((var), false) && allOk;
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
	highp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_float(var[0][0], -6.0) && allOk;
	allOk = compare_float(var[0][1], -3.0) && allOk;
	allOk = compare_float(var[0][2], -5.0) && allOk;
	allOk = compare_float(var[1][0], 2.0) && allOk;
	allOk = compare_float(var[1][1], 9.0) && allOk;
	allOk = compare_float(var[1][2], 4.0) && allOk;
	allOk = compare_float(var[2][0], 6.0) && allOk;
	allOk = compare_float(var[2][1], -8.0) && allOk;
	allOk = compare_float(var[2][2], -8.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-6.0, -3.0, -5.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(2.0, 9.0, 4.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(6.0, -8.0, -8.0)) && allOk;
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
	highp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_float(var[0][0], -6.0) && allOk;
	allOk = compare_float(var[0][1], -4.0) && allOk;
	allOk = compare_float(var[0][2], 5.0) && allOk;
	allOk = compare_float(var[1][0], 0.0) && allOk;
	allOk = compare_float(var[1][1], -1.0) && allOk;
	allOk = compare_float(var[1][2], 1.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-6.0, -4.0, 5.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(0.0, -1.0, 1.0)) && allOk;
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
	mediump mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 2.0) && allOk;
	allOk = compare_mat2x4(var, mat2x4(5.0, -4.0, 1.0, -2.0, 8.0, 7.0, -3.0, -7.0)) && allOk;
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
	highp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -9.0) && allOk;
	allOk = compare_mat3x2(var, mat3x2(5.0, 9.0, -2.0, -3.0, 2.0, -1.0)) && allOk;
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
	mediump mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 8.0) && allOk;
	allOk = compare_float(var[0][0], 5.0) && allOk;
	allOk = compare_float(var[0][1], -8.0) && allOk;
	allOk = compare_float(var[0][2], -5.0) && allOk;
	allOk = compare_float(var[0][3], -1.0) && allOk;
	allOk = compare_float(var[1][0], -3.0) && allOk;
	allOk = compare_float(var[1][1], 5.0) && allOk;
	allOk = compare_float(var[1][2], 6.0) && allOk;
	allOk = compare_float(var[1][3], 3.0) && allOk;
	allOk = compare_float(var[2][0], -2.0) && allOk;
	allOk = compare_float(var[2][1], 9.0) && allOk;
	allOk = compare_float(var[2][2], 0.0) && allOk;
	allOk = compare_float(var[2][3], 4.0) && allOk;
	allOk = compare_vec4(var[0], vec4(5.0, -8.0, -5.0, -1.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-3.0, 5.0, 6.0, 3.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-2.0, 9.0, 0.0, 4.0)) && allOk;
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
	highp mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -4.0) && allOk;
	allOk = compare_mat4x3(var, mat4x3(-2.0, -6.0, -6.0, 8.0, 4.0, -1.0, -1.0, 9.0, 7.0, 2.0, 6.0, 6.0)) && allOk;
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
	highp mat4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0], mat4(6.0, 9.0, -9.0, 2.0, -1.0, -3.0, 3.0, 6.0, 5.0, 1.0, -3.0, -2.0, 3.0, -6.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(8.0, 2.0, 9.0, 5.0, 5.0, 3.0, -9.0, -5.0, -8.0, 6.0, -6.0, -7.0, -6.0, 0.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(-3.0, 5.0, 8.0, -1.0, -4.0, 4.0, 3.0, -8.0, 1.0, -1.0, 7.0, 4.0, -2.0, 1.0, -3.0, -4.0)) && allOk;
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
	highp mat2x3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0], mat2x3(5.0, 8.0, 4.0, -6.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(0.0, 0.0, 4.0, 3.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(-7.0, 2.0, -1.0, 5.0, 5.0, -9.0)) && allOk;
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
	highp mat3x4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -6.0) && allOk;
	allOk = compare_mat3x4(var[0], mat3x4(2.0, 7.0, -8.0, 9.0, -6.0, 1.0, 9.0, -9.0, 1.0, -3.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(-5.0, -5.0, 5.0, -5.0, -3.0, 2.0, 1.0, 2.0, 8.0, -3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(7.0, -5.0, 5.0, 6.0, -3.0, 8.0, -1.0, -1.0, -1.0, -9.0, 8.0, 3.0)) && allOk;
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
	highp mat4 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0], mat4(3.0, 0.0, 6.0, 0.0, -6.0, 5.0, 3.0, -4.0, -9.0, -8.0, 9.0, 3.0, 2.0, -9.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(-8.0, 0.0, 1.0, -5.0, -2.0, 1.0, -6.0, -8.0, -1.0, 5.0, -8.0, 0.0, -6.0, 3.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(-9.0, -3.0, 4.0, 6.0, 2.0, 3.0, 0.0, 7.0, 9.0, -9.0, -6.0, 8.0, 0.0, -9.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4(var[3], mat4(4.0, -7.0, 1.0, -7.0, -1.0, 5.0, 9.0, -8.0, 2.0, -6.0, 1.0, 7.0, 4.0, 1.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4(var[4], mat4(-3.0, 5.0, -7.0, -5.0, -9.0, 3.0, 0.0, 0.0, 3.0, 2.0, -5.0, -8.0, 9.0, 3.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4(var[5], mat4(9.0, -1.0, 6.0, 9.0, 0.0, -6.0, 0.0, 1.0, -1.0, 5.0, -7.0, -8.0, 1.0, -3.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat4(var[6], mat4(-4.0, 1.0, 3.0, -2.0, -8.0, -3.0, 0.0, 4.0, -3.0, -4.0, 6.0, -7.0, 5.0, 4.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4(var[7], mat4(5.0, 5.0, 7.0, -7.0, 1.0, -4.0, 9.0, 7.0, 9.0, -2.0, -8.0, 8.0, -2.0, -7.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat4(var[8], mat4(5.0, 9.0, 4.0, -3.0, 1.0, 9.0, 1.0, 8.0, 6.0, -1.0, -3.0, -2.0, 5.0, -3.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4(var[9], mat4(-5.0, -8.0, 8.0, -5.0, -4.0, -4.0, -8.0, 9.0, -5.0, 5.0, 8.0, -9.0, 2.0, 8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat4(var[10], mat4(3.0, 5.0, -4.0, -4.0, -3.0, -5.0, -8.0, -3.0, -6.0, -5.0, 0.0, -6.0, -9.0, -2.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4(var[11], mat4(-1.0, 8.0, 5.0, 0.0, -7.0, -4.0, 7.0, -7.0, 2.0, -4.0, -2.0, -8.0, 5.0, -4.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat4(var[12], mat4(4.0, 9.0, 6.0, -4.0, -3.0, 3.0, -3.0, 5.0, -3.0, 6.0, -9.0, 2.0, 5.0, 7.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4(var[13], mat4(-5.0, -3.0, 7.0, -5.0, -5.0, -7.0, -9.0, 5.0, 3.0, -1.0, 9.0, -3.0, 4.0, 8.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[14], mat4(-6.0, -7.0, -9.0, 4.0, 6.0, -4.0, 2.0, -1.0, 9.0, 3.0, -3.0, 3.0, -6.0, 5.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat4(var[15], mat4(-8.0, -6.0, 5.0, 0.0, -1.0, -7.0, 4.0, 2.0, -1.0, -9.0, 6.0, 4.0, -9.0, -7.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat4(var[16], mat4(-3.0, 8.0, -5.0, 2.0, -2.0, -2.0, 9.0, 4.0, 0.0, 3.0, -5.0, 4.0, 0.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat4(var[17], mat4(7.0, -4.0, 0.0, -2.0, -9.0, -9.0, 0.0, -9.0, 7.0, 9.0, -9.0, -9.0, -8.0, 3.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat4(var[18], mat4(-9.0, 0.0, -3.0, -3.0, -4.0, -6.0, -9.0, 9.0, 8.0, 6.0, 3.0, -2.0, 1.0, 5.0, -3.0, -4.0)) && allOk;
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
	highp mat4 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0], mat4(9.0, -2.0, -9.0, 2.0, -3.0, 8.0, -1.0, 2.0, 2.0, -5.0, -8.0, -6.0, -6.0, -3.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(0.0, 0.0, 8.0, -6.0, 7.0, -9.0, 0.0, 5.0, -6.0, -4.0, -7.0, 7.0, -3.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(4.0, 4.0, 2.0, -6.0, 2.0, 0.0, -9.0, -1.0, -3.0, 4.0, -3.0, 0.0, -2.0, -5.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4(var[3], mat4(-4.0, -1.0, 7.0, 7.0, 0.0, 8.0, 8.0, 8.0, -3.0, -1.0, -9.0, 9.0, 2.0, 2.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat4(var[4], mat4(5.0, 0.0, 8.0, -9.0, 0.0, -2.0, -9.0, 7.0, -6.0, 0.0, 8.0, -8.0, -2.0, -8.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4(var[5], mat4(-4.0, -3.0, -4.0, -7.0, 4.0, -6.0, 5.0, 2.0, -1.0, -6.0, -7.0, -9.0, 7.0, 4.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat4(var[6], mat4(9.0, -6.0, 6.0, 6.0, -2.0, -1.0, -8.0, 2.0, 6.0, 2.0, 1.0, 4.0, -3.0, -2.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat4(var[7], mat4(-4.0, -3.0, -8.0, 5.0, 8.0, 4.0, -5.0, 9.0, -4.0, -5.0, 2.0, 2.0, -3.0, 2.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat4(var[8], mat4(5.0, -1.0, 6.0, 0.0, -1.0, 7.0, -6.0, -9.0, -8.0, -3.0, -5.0, 0.0, -2.0, -1.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[9], mat4(0.0, -4.0, 0.0, 2.0, 5.0, -7.0, 2.0, 5.0, -6.0, 2.0, -9.0, -9.0, 8.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4(var[10], mat4(9.0, 2.0, 5.0, -7.0, 0.0, 8.0, -5.0, -9.0, -4.0, 7.0, -4.0, -9.0, 7.0, 9.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat4(var[11], mat4(-9.0, -5.0, 3.0, -4.0, -6.0, 7.0, -1.0, -2.0, -5.0, 4.0, -6.0, -7.0, -7.0, -4.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat4(var[12], mat4(2.0, -9.0, 8.0, -3.0, -3.0, -1.0, -8.0, -7.0, -8.0, 4.0, 2.0, -4.0, -5.0, 1.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat4(var[13], mat4(6.0, -2.0, -2.0, -9.0, 7.0, 8.0, -4.0, -9.0, -8.0, -4.0, 6.0, 7.0, -4.0, -5.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4(var[14], mat4(3.0, 8.0, 3.0, 9.0, -8.0, 9.0, 4.0, -3.0, -1.0, -3.0, 5.0, -1.0, 3.0, 9.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4(var[15], mat4(-7.0, 9.0, -8.0, -7.0, -5.0, 5.0, 6.0, 9.0, -7.0, -2.0, 5.0, 7.0, -2.0, 8.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat4(var[16], mat4(3.0, 7.0, 1.0, -2.0, 8.0, 6.0, 9.0, 5.0, 3.0, 4.0, -8.0, -4.0, -5.0, 0.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4(var[17], mat4(-3.0, 9.0, 7.0, -3.0, 8.0, -4.0, -7.0, 1.0, -3.0, 9.0, -9.0, -1.0, 7.0, -1.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat4(var[18], mat4(8.0, 1.0, -4.0, 3.0, 7.0, 9.0, 6.0, -6.0, 2.0, 8.0, 2.0, 3.0, -8.0, 7.0, 6.0, 0.0)) && allOk;
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

layout(std140, column_major, binding = 1) readonly buffer Block
{
	highp mat4 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0], mat4(3.0, 8.0, 5.0, -7.0, -4.0, 0.0, -1.0, -9.0, 2.0, 9.0, 5.0, 5.0, 6.0, 9.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(8.0, 1.0, -3.0, 1.0, 0.0, -7.0, -4.0, 0.0, 1.0, -6.0, -7.0, 5.0, 2.0, 0.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(-5.0, 8.0, 2.0, 3.0, 8.0, -6.0, 7.0, 9.0, -3.0, 7.0, -8.0, -5.0, 6.0, 4.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat4(var[3], mat4(7.0, 0.0, -6.0, -1.0, 5.0, 0.0, -3.0, -3.0, 6.0, -5.0, 1.0, 4.0, -5.0, -7.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat4(var[4], mat4(-2.0, -3.0, 2.0, -9.0, 6.0, -8.0, 8.0, 2.0, -3.0, -9.0, 8.0, 1.0, -4.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4(var[5], mat4(9.0, -2.0, -1.0, -7.0, 6.0, -6.0, -3.0, -9.0, -3.0, -7.0, -2.0, 2.0, -9.0, -2.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat4(var[6], mat4(2.0, -3.0, 7.0, 9.0, 7.0, -1.0, 3.0, 6.0, -3.0, 2.0, -2.0, 7.0, -9.0, 0.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat4(var[7], mat4(-2.0, -1.0, -6.0, -6.0, 5.0, -8.0, 7.0, 3.0, -6.0, 4.0, -8.0, -1.0, 1.0, 4.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4(var[8], mat4(-7.0, -2.0, -4.0, -6.0, -6.0, 8.0, 5.0, -4.0, -7.0, 7.0, -4.0, -9.0, -7.0, -1.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat4(var[9], mat4(5.0, -4.0, -1.0, -3.0, 3.0, 2.0, 1.0, -6.0, 3.0, 5.0, -4.0, 0.0, 2.0, -4.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4(var[10], mat4(-6.0, -9.0, -6.0, -9.0, -4.0, 2.0, 5.0, 4.0, -6.0, -2.0, -5.0, 7.0, 9.0, -4.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4(var[11], mat4(-2.0, 1.0, -2.0, 0.0, -7.0, 2.0, -6.0, -5.0, 2.0, -1.0, -8.0, 8.0, 2.0, -9.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4(var[12], mat4(4.0, 4.0, 9.0, -7.0, 9.0, 2.0, 3.0, 7.0, 0.0, -9.0, 2.0, -1.0, -8.0, -7.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4(var[13], mat4(0.0, -3.0, -1.0, -1.0, -6.0, 1.0, -8.0, 1.0, 5.0, 0.0, 2.0, -1.0, -1.0, -6.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4(var[14], mat4(7.0, 5.0, -2.0, -4.0, 0.0, 1.0, -6.0, -3.0, -1.0, -7.0, -7.0, -6.0, 1.0, -4.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat4(var[15], mat4(8.0, -3.0, 9.0, 6.0, -2.0, -9.0, 4.0, 5.0, 6.0, 4.0, -3.0, -8.0, 6.0, 5.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat4(var[16], mat4(-2.0, 5.0, 8.0, 4.0, -4.0, 9.0, 3.0, -5.0, 1.0, -6.0, 1.0, -5.0, 8.0, 7.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4(var[17], mat4(3.0, 0.0, -3.0, 3.0, 2.0, -8.0, -7.0, 8.0, -3.0, 2.0, -9.0, -7.0, 1.0, -5.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4(var[18], mat4(0.0, 0.0, -1.0, 0.0, -9.0, 5.0, 4.0, 0.0, -6.0, -7.0, 1.0, -9.0, -4.0, -4.0, 0.0, -5.0)) && allOk;
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
	highp mat2 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0], mat2(-5.0, -2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(-2.0, -4.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(-9.0, 9.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat2(var[3], mat2(8.0, -3.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2(var[4], mat2(9.0, -8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2(var[5], mat2(8.0, -2.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat2(var[6], mat2(9.0, 8.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2(var[7], mat2(-1.0, -8.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2(var[8], mat2(8.0, -4.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2(var[9], mat2(3.0, 3.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2(var[10], mat2(0.0, -3.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2(var[11], mat2(8.0, -5.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2(var[12], mat2(7.0, 8.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat2(var[13], mat2(9.0, 8.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat2(var[14], mat2(3.0, 3.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat2(var[15], mat2(-3.0, -8.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat2(var[16], mat2(6.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2(var[17], mat2(-2.0, -9.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat2(var[18], mat2(4.0, -9.0, 2.0, -1.0)) && allOk;
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
	int8_t var[];
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(var[0]), 4294967292) && allOk;
	allOk = compare_int8_t(int(var[1]), 3) && allOk;
	allOk = compare_int8_t(int(var[2]), 3) && allOk;
	allOk = compare_int8_t(int(var[3]), 1) && allOk;
	allOk = compare_int8_t(int(var[4]), 6) && allOk;
	allOk = compare_int8_t(int(var[5]), 8) && allOk;
	allOk = compare_int8_t(int(var[6]), 5) && allOk;
	allOk = compare_int8_t(int(var[7]), 2) && allOk;
	allOk = compare_int8_t(int(var[8]), 0) && allOk;
	allOk = compare_int8_t(int(var[9]), 4294967292) && allOk;
	allOk = compare_int8_t(int(var[10]), 4294967287) && allOk;
	allOk = compare_int8_t(int(var[11]), 4294967289) && allOk;
	allOk = compare_int8_t(int(var[12]), 4294967292) && allOk;
	allOk = compare_int8_t(int(var[13]), 4294967291) && allOk;
	allOk = compare_int8_t(int(var[14]), 7) && allOk;
	allOk = compare_int8_t(int(var[15]), 4294967293) && allOk;
	allOk = compare_int8_t(int(var[16]), 8) && allOk;
	allOk = compare_int8_t(int(var[17]), 4294967292) && allOk;
	allOk = compare_int8_t(int(var[18]), 4294967291) && allOk;
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
	i16vec4 var[];
};

bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(var[0]), ivec4(-6, -9, 9, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1]), ivec4(-1, -8, 8, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2]), ivec4(3, 4, 0, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(var[3]), ivec4(-2, -4, -9, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(var[4]), ivec4(4, -1, 4, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(var[5]), ivec4(6, 7, -4, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[6]), ivec4(-2, 9, 9, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(var[7]), ivec4(-3, -8, -7, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(var[8]), ivec4(7, -2, -8, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[9]), ivec4(1, 6, 9, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(var[10]), ivec4(1, -3, 9, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[11]), ivec4(4, 8, -6, -2)) && allOk;
	allOk = compare_i16vec4(ivec4(var[12]), ivec4(3, -5, 9, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[13]), ivec4(6, 3, 6, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(var[14]), ivec4(9, -8, -9, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[15]), ivec4(-9, -3, -3, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(var[16]), ivec4(-7, -4, 3, 0)) && allOk;
	allOk = compare_i16vec4(ivec4(var[17]), ivec4(-4, 5, -2, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(var[18]), ivec4(4, -6, 5, -3)) && allOk;
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
	highp mat2x3 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0], mat2x3(-2.0, 0.0, -9.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(-3.0, -1.0, -3.0, -1.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(9.0, 9.0, 0.0, 0.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[3], mat2x3(-6.0, 8.0, -3.0, 7.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[4], mat2x3(6.0, -2.0, -7.0, -8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat2x3(var[5], mat2x3(7.0, -3.0, 2.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[6], mat2x3(7.0, -9.0, 0.0, -9.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[7], mat2x3(5.0, 3.0, 9.0, 1.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[8], mat2x3(5.0, -3.0, 6.0, 8.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[9], mat2x3(9.0, 5.0, 6.0, 7.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[10], mat2x3(1.0, 9.0, 5.0, 1.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[11], mat2x3(1.0, 6.0, -5.0, 7.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[12], mat2x3(1.0, -3.0, -1.0, -4.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat2x3(var[13], mat2x3(-2.0, 8.0, 1.0, 6.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[14], mat2x3(2.0, 5.0, 0.0, -6.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[15], mat2x3(9.0, 7.0, -7.0, 4.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[16], mat2x3(3.0, 7.0, 0.0, -3.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[17], mat2x3(9.0, 5.0, -9.0, 3.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[18], mat2x3(-3.0, -8.0, -3.0, 7.0, -3.0, 2.0)) && allOk;
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
	i8vec2 var[];
};

bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(var[0]), ivec2(4294967288, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1]), ivec2(1, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2]), ivec2(0, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(var[3]), ivec2(4294967288, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(var[4]), ivec2(4294967290, 4294967287)) && allOk;
	allOk = compare_i8vec2(ivec2(var[5]), ivec2(4294967289, 2)) && allOk;
	allOk = compare_i8vec2(ivec2(var[6]), ivec2(4294967287, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(var[7]), ivec2(6, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(var[8]), ivec2(3, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(var[9]), ivec2(1, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(var[10]), ivec2(6, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(var[11]), ivec2(3, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(var[12]), ivec2(9, 3)) && allOk;
	allOk = compare_i8vec2(ivec2(var[13]), ivec2(2, 6)) && allOk;
	allOk = compare_i8vec2(ivec2(var[14]), ivec2(4294967290, 4294967289)) && allOk;
	allOk = compare_i8vec2(ivec2(var[15]), ivec2(5, 4294967289)) && allOk;
	allOk = compare_i8vec2(ivec2(var[16]), ivec2(8, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(var[17]), ivec2(4294967294, 4294967288)) && allOk;
	allOk = compare_i8vec2(ivec2(var[18]), ivec2(7, 4294967292)) && allOk;
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

struct S
{
	highp ivec3 a;
	mediump mat3 b[4];
	highp vec4 c;
};
layout(std140, binding = 1) readonly buffer Block
{
	S s;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((s.a), ivec3(0, 2, 6)) && allOk;
	allOk = compare_mat3(s.b[0], mat3(8.0, -8.0, 2.0, -3.0, -1.0, -8.0, 8.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat3(s.b[1], mat3(-7.0, -1.0, 4.0, 9.0, -9.0, 8.0, 0.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat3(s.b[2], mat3(-1.0, -2.0, -1.0, -6.0, 9.0, -8.0, -3.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3(s.b[3], mat3(9.0, -8.0, -7.0, -4.0, 4.0, 0.0, 9.0, 9.0, -8.0)) && allOk;
	allOk = compare_vec4((s.c), vec4(1.0, 3.0, -5.0, 3.0)) && allOk;
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

layout(std140, column_major, buffer_reference) buffer Block
{
	lowp mat2x4 var;
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
	allOk = compare_float(block.var[0][0], 8.0) && allOk;
	allOk = compare_float(block.var[0][1], -9.0) && allOk;
	allOk = compare_float(block.var[0][2], -6.0) && allOk;
	allOk = compare_float(block.var[0][3], -9.0) && allOk;
	allOk = compare_float(block.var[1][0], -3.0) && allOk;
	allOk = compare_float(block.var[1][1], -7.0) && allOk;
	allOk = compare_float(block.var[1][2], 6.0) && allOk;
	allOk = compare_float(block.var[1][3], -6.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(8.0, -9.0, -6.0, -9.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-3.0, -7.0, 6.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x4(8.0, 7.0, 9.0, -5.0, 2.0, 9.0, -8.0, -9.0));
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
	allOk = compare_mat3x2(block.var, mat3x2(8.0, -6.0, -5.0, 4.0, -5.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x2(3.0, 5.0, 4.0, -6.0, -4.0, -1.0));
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
	mediump mat4x3 var;
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
	allOk = compare_float(block.var[0][0], -3.0) && allOk;
	allOk = compare_float(block.var[0][1], 0.0) && allOk;
	allOk = compare_float(block.var[0][2], -9.0) && allOk;
	allOk = compare_float(block.var[1][0], -9.0) && allOk;
	allOk = compare_float(block.var[1][1], -2.0) && allOk;
	allOk = compare_float(block.var[1][2], 5.0) && allOk;
	allOk = compare_float(block.var[2][0], 3.0) && allOk;
	allOk = compare_float(block.var[2][1], -9.0) && allOk;
	allOk = compare_float(block.var[2][2], -4.0) && allOk;
	allOk = compare_float(block.var[3][0], -8.0) && allOk;
	allOk = compare_float(block.var[3][1], -7.0) && allOk;
	allOk = compare_float(block.var[3][2], 2.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-3.0, 0.0, -9.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-9.0, -2.0, 5.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(3.0, -9.0, -4.0)) && allOk;
	allOk = compare_vec3(block.var[3], vec3(-8.0, -7.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(-1.0, 0.0, 6.0));
	block.var[1] = (vec3(-6.0, -6.0, -2.0));
	block.var[2] = (vec3(5.0, 4.0, -9.0));
	block.var[3] = (vec3(-4.0, -2.0, 2.0));
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
	lowp uvec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((block.var), uvec2(2u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (uvec2(6u, 3u));
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
	highp uvec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((block.var), uvec2(2u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (uvec2(2u, 7u));
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
	highp mat4 var;
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
	allOk = compare_mat4(block.var, mat4(5.0, 5.0, 1.0, -2.0, 6.0, -1.0, -4.0, 5.0, 5.0, -8.0, 7.0, -8.0, 5.0, 4.0, 0.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4(4.0, -9.0, -5.0, 2.0, -3.0, -4.0, 6.0, 6.0, 2.0, 2.0, 7.0, -7.0, 5.0, -2.0, 0.0, 8.0));
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
	lowp mat4 var;
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
	allOk = compare_mat4(block.var, mat4(-6.0, -9.0, 1.0, 3.0, -2.0, -4.0, -7.0, -6.0, 1.0, 8.0, 9.0, 8.0, 8.0, 9.0, 8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4(4.0, 9.0, 2.0, -9.0, -4.0, -9.0, -7.0, -7.0, -2.0, -7.0, -3.0, -4.0, 1.0, 0.0, -9.0, -3.0));
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
	lowp mat2x4 var;
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
	allOk = compare_mat2x4(block.var, mat2x4(-7.0, -9.0, -7.0, -3.0, -8.0, 1.0, 3.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x4(3.0, -4.0, -4.0, 3.0, -5.0, 0.0, -8.0, -4.0));
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
	highp mat2x4 var;
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
	allOk = compare_mat2x4(block.var, mat2x4(4.0, -6.0, -1.0, -3.0, -2.0, 8.0, -5.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x4(-3.0, 3.0, -6.0, -5.0, -3.0, -3.0, -7.0, -9.0));
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
	mediump mat4x2 var;
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
	allOk = compare_mat4x2(block.var, mat4x2(-2.0, -5.0, -2.0, 4.0, -3.0, -4.0, 2.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x2(-6.0, -9.0, 0.0, -8.0, -8.0, 5.0, -8.0, 3.0));
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
	highp mat4x3 var;
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
	allOk = compare_float(block.var[0][0], 1.0) && allOk;
	allOk = compare_float(block.var[0][1], 2.0) && allOk;
	allOk = compare_float(block.var[0][2], -6.0) && allOk;
	allOk = compare_float(block.var[1][0], -2.0) && allOk;
	allOk = compare_float(block.var[1][1], 6.0) && allOk;
	allOk = compare_float(block.var[1][2], 2.0) && allOk;
	allOk = compare_float(block.var[2][0], 6.0) && allOk;
	allOk = compare_float(block.var[2][1], -8.0) && allOk;
	allOk = compare_float(block.var[2][2], 2.0) && allOk;
	allOk = compare_float(block.var[3][0], 0.0) && allOk;
	allOk = compare_float(block.var[3][1], -4.0) && allOk;
	allOk = compare_float(block.var[3][2], 8.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(1.0, 2.0, -6.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-2.0, 6.0, 2.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(6.0, -8.0, 2.0)) && allOk;
	allOk = compare_vec3(block.var[3], vec3(0.0, -4.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x3(2.0, 8.0, 7.0, -6.0, -3.0, -1.0, -7.0, -9.0, 8.0, -9.0, -3.0, 1.0));
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
	mediump float var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.var), -6.0) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (2.0);
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
	highp float var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.var), 7.0) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (7.0);
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
	lowp mat2 var;
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
	allOk = compare_float((block.padding), 1.0) && allOk;
	allOk = compare_mat2(block.var, mat2(7.0, -3.0, -2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-1.0);
	block.var = (mat2(0.0, -7.0, 5.0, -3.0));
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
	mediump mat3x4 var;
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
	allOk = compare_float((block.padding), 8.0) && allOk;
	allOk = compare_float(block.var[0][0], 5.0) && allOk;
	allOk = compare_float(block.var[0][1], -8.0) && allOk;
	allOk = compare_float(block.var[0][2], -5.0) && allOk;
	allOk = compare_float(block.var[0][3], -1.0) && allOk;
	allOk = compare_float(block.var[1][0], -3.0) && allOk;
	allOk = compare_float(block.var[1][1], 5.0) && allOk;
	allOk = compare_float(block.var[1][2], 6.0) && allOk;
	allOk = compare_float(block.var[1][3], 3.0) && allOk;
	allOk = compare_float(block.var[2][0], -2.0) && allOk;
	allOk = compare_float(block.var[2][1], 9.0) && allOk;
	allOk = compare_float(block.var[2][2], 0.0) && allOk;
	allOk = compare_float(block.var[2][3], 4.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(5.0, -8.0, -5.0, -1.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-3.0, 5.0, 6.0, 3.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(-2.0, 9.0, 0.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (6.0);
	block.var[0] = (vec4(2.0, 2.0, -6.0, 6.0));
	block.var[1] = (vec4(8.0, 8.0, 2.0, 0.0));
	block.var[2] = (vec4(3.0, 9.0, -5.0, 0.0));
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
	lowp mat4x3 var;
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
	allOk = compare_float((block.padding), 1.0) && allOk;
	allOk = compare_float(block.var[0][0], 7.0) && allOk;
	allOk = compare_float(block.var[0][1], -7.0) && allOk;
	allOk = compare_float(block.var[0][2], 3.0) && allOk;
	allOk = compare_float(block.var[1][0], -1.0) && allOk;
	allOk = compare_float(block.var[1][1], -1.0) && allOk;
	allOk = compare_float(block.var[1][2], -1.0) && allOk;
	allOk = compare_float(block.var[2][0], -6.0) && allOk;
	allOk = compare_float(block.var[2][1], 6.0) && allOk;
	allOk = compare_float(block.var[2][2], 0.0) && allOk;
	allOk = compare_float(block.var[3][0], -3.0) && allOk;
	allOk = compare_float(block.var[3][1], 7.0) && allOk;
	allOk = compare_float(block.var[3][2], 6.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(7.0, -7.0, 3.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-1.0, -1.0, -1.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(-6.0, 6.0, 0.0)) && allOk;
	allOk = compare_vec3(block.var[3], vec3(-3.0, 7.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (1.0);
	block.var[0] = (vec3(1.0, 8.0, 0.0));
	block.var[1] = (vec3(4.0, -9.0, -3.0));
	block.var[2] = (vec3(7.0, -6.0, -7.0));
	block.var[3] = (vec3(-9.0, -7.0, 2.0));
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
	highp mat2 var[3];
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
	allOk = compare_mat2(block.var[0], mat2(-4.0, 3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(5.0, 5.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(-2.0, 2.0, -7.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2(2.0, 4.0, 4.0, -1.0));
	block.var[1] = (mat2(2.0, -5.0, 1.0, -1.0));
	block.var[2] = (mat2(-2.0, -9.0, -3.0, -8.0));
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
	f16vec3 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(block.var[0]), vec3(4.0, 1.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1]), vec3(-8.0, 7.0, -5.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2]), vec3(4.0, 2.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = f16vec3(vec3(3.0, 3.0, 7.0));
	block.var[1] = f16vec3(vec3(-3.0, -5.0, -9.0));
	block.var[2] = f16vec3(vec3(-1.0, 0.0, 6.0));
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
	int padding;
	highp ivec2 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((block.padding), 6) && allOk;
	allOk = compare_ivec2((block.var[0]), ivec2(-1, 7)) && allOk;
	allOk = compare_ivec2((block.var[1]), ivec2(-5, -8)) && allOk;
	allOk = compare_ivec2((block.var[2]), ivec2(8, -2)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-6);
	block.var[0] = (ivec2(8, 3));
	block.var[1] = (ivec2(-1, -5));
	block.var[2] = (ivec2(-2, 0));
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
	allOk = compare_float((block.padding), -5.0) && allOk;
	allOk = compare_mat3x2(block.var[0], mat3x2(-4.0, 7.0, 2.0, 0.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1], mat3x2(3.0, -1.0, 3.0, -5.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[2], mat3x2(-8.0, 5.0, -4.0, 8.0, -3.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-3.0);
	block.var[0] = (mat3x2(-3.0, -4.0, 2.0, -7.0, 7.0, -2.0));
	block.var[1] = (mat3x2(-8.0, -2.0, 3.0, 4.0, 9.0, 4.0));
	block.var[2] = (mat3x2(-7.0, 9.0, 9.0, -1.0, 1.0, -9.0));
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
	uint8_t padding;
	uint8_t var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(block.padding), 7u) && allOk;
	allOk = compare_uint8_t(uint(block.var[0]), 1u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1]), 3u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2]), 1u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = uint8_t(9u);
	block.var[0] = uint8_t(5u);
	block.var[1] = uint8_t(2u);
	block.var[2] = uint8_t(6u);
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
	highp vec3 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((block.var[0]), vec3(7.0, 9.0, -6.0)) && allOk;
	allOk = compare_vec3((block.var[1]), vec3(-9.0, 5.0, -8.0)) && allOk;
	allOk = compare_vec3((block.var[2]), vec3(1.0, -1.0, 7.0)) && allOk;
	allOk = compare_vec3((block.var[3]), vec3(-1.0, -9.0, 3.0)) && allOk;
	allOk = compare_vec3((block.var[4]), vec3(-7.0, -2.0, -4.0)) && allOk;
	allOk = compare_vec3((block.var[5]), vec3(3.0, 3.0, 6.0)) && allOk;
	allOk = compare_vec3((block.var[6]), vec3(1.0, -4.0, 0.0)) && allOk;
	allOk = compare_vec3((block.var[7]), vec3(5.0, 6.0, 5.0)) && allOk;
	allOk = compare_vec3((block.var[8]), vec3(-3.0, 5.0, 7.0)) && allOk;
	allOk = compare_vec3((block.var[9]), vec3(8.0, 5.0, 8.0)) && allOk;
	allOk = compare_vec3((block.var[10]), vec3(5.0, -8.0, -5.0)) && allOk;
	allOk = compare_vec3((block.var[11]), vec3(-7.0, -3.0, 7.0)) && allOk;
	allOk = compare_vec3((block.var[12]), vec3(-1.0, 5.0, 8.0)) && allOk;
	allOk = compare_vec3((block.var[13]), vec3(2.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec3((block.var[14]), vec3(8.0, 9.0, 6.0)) && allOk;
	allOk = compare_vec3((block.var[15]), vec3(6.0, -8.0, 0.0)) && allOk;
	allOk = compare_vec3((block.var[16]), vec3(-6.0, -1.0, 2.0)) && allOk;
	allOk = compare_vec3((block.var[17]), vec3(2.0, 7.0, -9.0)) && allOk;
	allOk = compare_vec3((block.var[18]), vec3(-8.0, -2.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(5.0, 4.0, 7.0));
	block.var[1] = (vec3(8.0, -2.0, 7.0));
	block.var[2] = (vec3(-5.0, -7.0, 9.0));
	block.var[3] = (vec3(6.0, 6.0, 0.0));
	block.var[4] = (vec3(-5.0, 2.0, -8.0));
	block.var[5] = (vec3(5.0, 0.0, 2.0));
	block.var[6] = (vec3(0.0, 5.0, 1.0));
	block.var[7] = (vec3(-5.0, 0.0, 1.0));
	block.var[8] = (vec3(0.0, 7.0, -2.0));
	block.var[9] = (vec3(-2.0, 8.0, -1.0));
	block.var[10] = (vec3(-1.0, 5.0, 1.0));
	block.var[11] = (vec3(-1.0, -3.0, 8.0));
	block.var[12] = (vec3(-4.0, 5.0, 1.0));
	block.var[13] = (vec3(-9.0, 6.0, -2.0));
	block.var[14] = (vec3(-8.0, -9.0, 3.0));
	block.var[15] = (vec3(4.0, -2.0, -9.0));
	block.var[16] = (vec3(-2.0, 6.0, -7.0));
	block.var[17] = (vec3(6.0, -4.0, 3.0));
	block.var[18] = (vec3(3.0, 3.0, -7.0));
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
	highp uvec4 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((block.var[0][0]), uvec4(4u, 1u, 8u, 2u)) && allOk;
	allOk = compare_uvec4((block.var[0][1]), uvec4(1u, 9u, 5u, 9u)) && allOk;
	allOk = compare_uvec4((block.var[0][2]), uvec4(3u, 6u, 5u, 1u)) && allOk;
	allOk = compare_uvec4((block.var[1][0]), uvec4(2u, 3u, 3u, 6u)) && allOk;
	allOk = compare_uvec4((block.var[1][1]), uvec4(0u, 7u, 0u, 0u)) && allOk;
	allOk = compare_uvec4((block.var[1][2]), uvec4(2u, 8u, 5u, 1u)) && allOk;
	allOk = compare_uvec4((block.var[2][0]), uvec4(7u, 3u, 1u, 5u)) && allOk;
	allOk = compare_uvec4((block.var[2][1]), uvec4(8u, 7u, 6u, 2u)) && allOk;
	allOk = compare_uvec4((block.var[2][2]), uvec4(5u, 9u, 5u, 9u)) && allOk;
	allOk = compare_uvec4((block.var[3][0]), uvec4(1u, 6u, 2u, 1u)) && allOk;
	allOk = compare_uvec4((block.var[3][1]), uvec4(7u, 9u, 5u, 3u)) && allOk;
	allOk = compare_uvec4((block.var[3][2]), uvec4(5u, 7u, 4u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (uvec4(2u, 7u, 2u, 9u));
	block.var[0][1] = (uvec4(7u, 9u, 5u, 1u));
	block.var[0][2] = (uvec4(3u, 4u, 4u, 2u));
	block.var[1][0] = (uvec4(0u, 5u, 6u, 2u));
	block.var[1][1] = (uvec4(9u, 5u, 7u, 7u));
	block.var[1][2] = (uvec4(0u, 3u, 8u, 1u));
	block.var[2][0] = (uvec4(4u, 9u, 1u, 3u));
	block.var[2][1] = (uvec4(8u, 8u, 8u, 1u));
	block.var[2][2] = (uvec4(7u, 5u, 4u, 8u));
	block.var[3][0] = (uvec4(6u, 6u, 0u, 9u));
	block.var[3][1] = (uvec4(7u, 2u, 3u, 0u));
	block.var[3][2] = (uvec4(4u, 4u, 8u, 5u));
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
	highp mat2x4 var[4][3];
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
	allOk = compare_mat2x4(block.var[0][0], mat2x4(-3.0, 3.0, 6.0, 0.0, -2.0, 1.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1], mat2x4(0.0, -1.0, 3.0, 9.0, 1.0, 1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2], mat2x4(6.0, 1.0, -8.0, 2.0, 2.0, -6.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0], mat2x4(1.0, -3.0, -7.0, -4.0, 0.0, -9.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1], mat2x4(-2.0, 4.0, -8.0, 4.0, 9.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2], mat2x4(8.0, 0.0, -3.0, 9.0, 5.0, -3.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0], mat2x4(-6.0, -5.0, 8.0, 2.0, -2.0, 9.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1], mat2x4(-1.0, 5.0, 0.0, -4.0, 2.0, 3.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2], mat2x4(2.0, 1.0, 0.0, -1.0, -5.0, 2.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0], mat2x4(3.0, 3.0, 4.0, 8.0, 4.0, -5.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1], mat2x4(-1.0, 0.0, 0.0, -2.0, -1.0, 1.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][2], mat2x4(-9.0, 2.0, -8.0, 1.0, 3.0, -7.0, 6.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec4(2.0, 1.0, 7.0, 1.0));
	block.var[0][0][1] = (vec4(-1.0, -8.0, 7.0, 5.0));
	block.var[0][1][0] = (vec4(-7.0, 2.0, -1.0, 4.0));
	block.var[0][1][1] = (vec4(7.0, -4.0, 8.0, -2.0));
	block.var[0][2][0] = (vec4(2.0, 5.0, -2.0, 1.0));
	block.var[0][2][1] = (vec4(1.0, 0.0, -4.0, 1.0));
	block.var[1][0][0] = (vec4(0.0, 5.0, -3.0, 3.0));
	block.var[1][0][1] = (vec4(9.0, -1.0, -7.0, -7.0));
	block.var[1][1][0] = (vec4(1.0, 9.0, -1.0, 8.0));
	block.var[1][1][1] = (vec4(7.0, 6.0, 7.0, -4.0));
	block.var[1][2][0] = (vec4(-4.0, 2.0, -4.0, 6.0));
	block.var[1][2][1] = (vec4(4.0, -1.0, -9.0, 3.0));
	block.var[2][0][0] = (vec4(0.0, -3.0, -2.0, 3.0));
	block.var[2][0][1] = (vec4(-6.0, 8.0, -9.0, -3.0));
	block.var[2][1][0] = (vec4(-9.0, 3.0, -2.0, 6.0));
	block.var[2][1][1] = (vec4(4.0, 7.0, -7.0, 7.0));
	block.var[2][2][0] = (vec4(5.0, 2.0, 7.0, -9.0));
	block.var[2][2][1] = (vec4(-4.0, -3.0, -2.0, 4.0));
	block.var[3][0][0] = (vec4(-3.0, -8.0, -4.0, 6.0));
	block.var[3][0][1] = (vec4(-1.0, -1.0, 6.0, -8.0));
	block.var[3][1][0] = (vec4(-4.0, -2.0, -8.0, 4.0));
	block.var[3][1][1] = (vec4(-2.0, 4.0, -8.0, 6.0));
	block.var[3][2][0] = (vec4(4.0, -8.0, 8.0, -8.0));
	block.var[3][2][1] = (vec4(4.0, 0.0, -9.0, 1.0));
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
	highp mat2x4 var[4][3];
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
	allOk = compare_mat2x4(block.var[0][0], mat2x4(5.0, -9.0, 4.0, 8.0, -1.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1], mat2x4(-7.0, 1.0, 3.0, -8.0, 0.0, -7.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2], mat2x4(8.0, 3.0, 1.0, -5.0, 2.0, 6.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0], mat2x4(-7.0, 0.0, -7.0, -6.0, -8.0, -6.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1], mat2x4(-9.0, 7.0, 5.0, 2.0, -3.0, -8.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2], mat2x4(-5.0, 4.0, 5.0, -3.0, -7.0, -9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0], mat2x4(-2.0, -5.0, 5.0, -9.0, -6.0, 9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1], mat2x4(-3.0, 4.0, -4.0, -3.0, 7.0, 7.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2], mat2x4(-5.0, -3.0, -3.0, -4.0, -9.0, 2.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0], mat2x4(-4.0, 0.0, -1.0, 2.0, 8.0, 9.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1], mat2x4(5.0, 1.0, 5.0, 8.0, -4.0, -5.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][2], mat2x4(1.0, 9.0, -1.0, 1.0, -2.0, -4.0, -1.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec4(-7.0, -1.0, 8.0, 2.0));
	block.var[0][0][1] = (vec4(-1.0, 2.0, 7.0, -9.0));
	block.var[0][1][0] = (vec4(-9.0, -5.0, 4.0, 7.0));
	block.var[0][1][1] = (vec4(5.0, 8.0, -8.0, -8.0));
	block.var[0][2][0] = (vec4(6.0, -3.0, 7.0, 0.0));
	block.var[0][2][1] = (vec4(4.0, 6.0, -4.0, 0.0));
	block.var[1][0][0] = (vec4(-5.0, 8.0, -9.0, -8.0));
	block.var[1][0][1] = (vec4(7.0, -7.0, -8.0, -6.0));
	block.var[1][1][0] = (vec4(-9.0, -8.0, 1.0, -2.0));
	block.var[1][1][1] = (vec4(7.0, -6.0, -9.0, 9.0));
	block.var[1][2][0] = (vec4(4.0, -6.0, 0.0, -3.0));
	block.var[1][2][1] = (vec4(-7.0, -7.0, 2.0, -1.0));
	block.var[2][0][0] = (vec4(6.0, -1.0, -5.0, 1.0));
	block.var[2][0][1] = (vec4(-1.0, 8.0, 7.0, 6.0));
	block.var[2][1][0] = (vec4(-9.0, 8.0, 2.0, 1.0));
	block.var[2][1][1] = (vec4(9.0, -7.0, 6.0, -8.0));
	block.var[2][2][0] = (vec4(-2.0, -8.0, 6.0, 9.0));
	block.var[2][2][1] = (vec4(5.0, 5.0, -1.0, -1.0));
	block.var[3][0][0] = (vec4(4.0, -3.0, 7.0, -9.0));
	block.var[3][0][1] = (vec4(-3.0, 9.0, 2.0, 6.0));
	block.var[3][1][0] = (vec4(6.0, 1.0, 5.0, -4.0));
	block.var[3][1][1] = (vec4(1.0, -6.0, 2.0, 6.0));
	block.var[3][2][0] = (vec4(-8.0, 7.0, 7.0, -5.0));
	block.var[3][2][1] = (vec4(-8.0, 0.0, -6.0, -4.0));
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
	highp mat3 var[4][3];
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
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_mat3(block.var[0][0], mat3(1.0, -5.0, -1.0, 3.0, 7.0, 4.0, 7.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[0][1], mat3(7.0, -6.0, -4.0, 7.0, -1.0, -5.0, -8.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[0][2], mat3(-3.0, 1.0, -3.0, -8.0, 8.0, 8.0, 2.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[1][0], mat3(5.0, 5.0, -8.0, -1.0, 3.0, 1.0, -6.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[1][1], mat3(0.0, 5.0, 8.0, -9.0, -8.0, -9.0, 3.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[1][2], mat3(9.0, 2.0, 5.0, 5.0, 5.0, -4.0, 4.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[2][0], mat3(8.0, -1.0, -9.0, -1.0, 0.0, 2.0, -6.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[2][1], mat3(-7.0, 6.0, -6.0, 9.0, 2.0, 4.0, 8.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[2][2], mat3(-4.0, -4.0, 9.0, 6.0, 6.0, 4.0, -1.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[3][0], mat3(7.0, -8.0, 2.0, 4.0, -2.0, -7.0, -5.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[3][1], mat3(2.0, 8.0, 1.0, -9.0, 8.0, 6.0, 7.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[3][2], mat3(7.0, 3.0, 2.0, -6.0, 6.0, 0.0, -6.0, 9.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-2.0);
	block.var[0][0] = (mat3(7.0, 5.0, 2.0, 9.0, -1.0, -9.0, -7.0, 1.0, 6.0));
	block.var[0][1] = (mat3(-1.0, -8.0, -8.0, 0.0, 9.0, 1.0, -5.0, 8.0, 1.0));
	block.var[0][2] = (mat3(-6.0, -1.0, 9.0, -6.0, 0.0, 5.0, -4.0, 5.0, -4.0));
	block.var[1][0] = (mat3(-9.0, 9.0, -7.0, -1.0, -9.0, -9.0, 3.0, -8.0, -2.0));
	block.var[1][1] = (mat3(2.0, -6.0, -7.0, 4.0, 8.0, -8.0, 7.0, -3.0, 6.0));
	block.var[1][2] = (mat3(7.0, -9.0, 5.0, -9.0, 9.0, 1.0, 1.0, 9.0, 8.0));
	block.var[2][0] = (mat3(-4.0, 7.0, -5.0, 8.0, 3.0, -4.0, 7.0, -7.0, -5.0));
	block.var[2][1] = (mat3(6.0, -8.0, 1.0, 7.0, 5.0, 7.0, 6.0, -1.0, 1.0));
	block.var[2][2] = (mat3(-8.0, 9.0, -2.0, 7.0, 9.0, -5.0, 7.0, -1.0, 8.0));
	block.var[3][0] = (mat3(-6.0, -1.0, -2.0, 9.0, 6.0, 0.0, 7.0, 6.0, -4.0));
	block.var[3][1] = (mat3(-5.0, -8.0, -6.0, 5.0, -5.0, 2.0, -3.0, -6.0, 7.0));
	block.var[3][2] = (mat3(7.0, 9.0, -8.0, -9.0, 8.0, -9.0, 5.0, -4.0, 8.0));
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
	allOk = compare_mat4(block.var[0][0][0], mat4(5.0, 8.0, -8.0, -2.0, 6.0, -4.0, 3.0, -1.0, 6.0, 4.0, -8.0, -3.0, 9.0, 9.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][1], mat4(-6.0, -5.0, 1.0, 2.0, 1.0, 8.0, 6.0, 2.0, -2.0, -9.0, -8.0, -8.0, -3.0, -9.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][2], mat4(-1.0, -6.0, 8.0, -9.0, -2.0, 9.0, 7.0, 3.0, 4.0, -1.0, -8.0, -8.0, 9.0, -4.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][0], mat4(9.0, -6.0, 0.0, -6.0, -4.0, 0.0, 7.0, 0.0, 7.0, 0.0, 8.0, 2.0, -6.0, -3.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][1], mat4(9.0, -2.0, 1.0, -9.0, -6.0, -1.0, -4.0, 6.0, 8.0, -7.0, 1.0, 3.0, -9.0, 5.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][2], mat4(-2.0, 4.0, 5.0, 9.0, 0.0, 0.0, 9.0, 3.0, -9.0, -4.0, 5.0, -2.0, 7.0, 9.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][0], mat4(-9.0, -1.0, -9.0, 8.0, 9.0, -9.0, -7.0, -2.0, 3.0, -9.0, -3.0, -9.0, 4.0, -4.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][1], mat4(-2.0, 7.0, -4.0, -4.0, 1.0, 2.0, -1.0, -3.0, 8.0, 1.0, -3.0, -1.0, -4.0, -6.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][2], mat4(-9.0, 9.0, 8.0, 7.0, 8.0, -2.0, -2.0, -5.0, -9.0, -8.0, -9.0, -4.0, -9.0, 6.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][0], mat4(9.0, 0.0, -2.0, -7.0, -8.0, 0.0, 3.0, -1.0, -9.0, 1.0, 9.0, -1.0, 5.0, -9.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][1], mat4(4.0, -5.0, -9.0, 5.0, 4.0, 7.0, 0.0, -6.0, -5.0, -9.0, 6.0, 9.0, 4.0, 6.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][2], mat4(2.0, 5.0, 9.0, -6.0, 4.0, 6.0, -4.0, 1.0, 6.0, 1.0, 3.0, 4.0, 3.0, 8.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][0], mat4(1.0, 8.0, -3.0, -5.0, -4.0, -9.0, -2.0, -6.0, -3.0, -9.0, -9.0, -7.0, 7.0, -9.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][1], mat4(4.0, -6.0, -4.0, 8.0, 0.0, -1.0, 3.0, -5.0, 6.0, -8.0, 9.0, 7.0, 3.0, 0.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][2], mat4(9.0, -9.0, 9.0, 2.0, -2.0, -2.0, 3.0, -9.0, 4.0, -1.0, -1.0, -7.0, -4.0, 0.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][0], mat4(-2.0, -4.0, 3.0, -3.0, 5.0, 1.0, -7.0, 8.0, 7.0, -9.0, -3.0, 7.0, 9.0, -9.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][1], mat4(4.0, -2.0, 4.0, -4.0, 1.0, 7.0, 6.0, 9.0, 8.0, -8.0, -3.0, -4.0, -7.0, 4.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][2], mat4(-3.0, -5.0, 2.0, 3.0, -9.0, -7.0, 3.0, -6.0, 4.0, 1.0, -7.0, 9.0, 2.0, 6.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][0], mat4(6.0, 1.0, 6.0, 5.0, 7.0, -7.0, -8.0, 7.0, -2.0, -3.0, 4.0, 3.0, 2.0, -8.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][1], mat4(-3.0, 2.0, -4.0, 7.0, -4.0, 1.0, -9.0, 8.0, 4.0, -8.0, 5.0, 3.0, 7.0, 5.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][2], mat4(-1.0, -3.0, -3.0, -4.0, -9.0, 8.0, 9.0, 0.0, 4.0, 6.0, -9.0, -8.0, 5.0, 3.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][0], mat4(-7.0, -7.0, -4.0, 1.0, 4.0, 3.0, 9.0, -8.0, -6.0, -7.0, -1.0, -7.0, -7.0, 7.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][1], mat4(-6.0, 2.0, 5.0, 3.0, 5.0, -7.0, 3.0, -6.0, -7.0, 6.0, 1.0, -5.0, -6.0, 9.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][2], mat4(2.0, -7.0, -4.0, -2.0, -7.0, 1.0, -1.0, 4.0, -9.0, 4.0, 9.0, -9.0, 0.0, -9.0, -2.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4(6.0, -8.0, 2.0, -8.0, 1.0, -5.0, -7.0, -8.0, -9.0, 3.0, -9.0, -1.0, 7.0, -6.0, -5.0, 2.0));
	block.var[0][0][1] = (mat4(4.0, 3.0, -5.0, 6.0, 5.0, -1.0, -1.0, 7.0, -1.0, 5.0, -8.0, -3.0, 2.0, -6.0, -9.0, -5.0));
	block.var[0][0][2] = (mat4(1.0, -5.0, -9.0, 9.0, -7.0, -1.0, 6.0, -6.0, 6.0, -9.0, -8.0, -3.0, -3.0, 4.0, -5.0, -1.0));
	block.var[0][1][0] = (mat4(-4.0, -9.0, -7.0, -9.0, -9.0, -3.0, -8.0, 0.0, -1.0, -4.0, -1.0, -8.0, 5.0, -8.0, -3.0, 1.0));
	block.var[0][1][1] = (mat4(-1.0, -6.0, -1.0, 0.0, -8.0, 6.0, 6.0, -5.0, -6.0, 9.0, 2.0, 6.0, 6.0, -5.0, -7.0, 0.0));
	block.var[0][1][2] = (mat4(2.0, 6.0, 3.0, 6.0, 1.0, -3.0, -6.0, 0.0, -2.0, 0.0, -9.0, 1.0, 6.0, 9.0, -9.0, 0.0));
	block.var[1][0][0] = (mat4(-3.0, -9.0, -6.0, 5.0, 0.0, 6.0, -5.0, -7.0, -6.0, -5.0, 8.0, -6.0, -2.0, -8.0, -4.0, -8.0));
	block.var[1][0][1] = (mat4(1.0, 5.0, 6.0, -2.0, -7.0, -3.0, -4.0, 6.0, -8.0, -5.0, 2.0, 8.0, 4.0, 3.0, 6.0, -6.0));
	block.var[1][0][2] = (mat4(-7.0, 5.0, 7.0, -7.0, -6.0, 6.0, -2.0, 5.0, 1.0, -3.0, -2.0, 4.0, 6.0, -6.0, -5.0, -5.0));
	block.var[1][1][0] = (mat4(-9.0, 4.0, 1.0, 5.0, 0.0, 9.0, 3.0, -2.0, -8.0, 9.0, -9.0, 2.0, -8.0, 0.0, 7.0, 7.0));
	block.var[1][1][1] = (mat4(6.0, -5.0, 5.0, 3.0, -2.0, -8.0, 6.0, 2.0, 7.0, -1.0, -2.0, 8.0, -9.0, 1.0, -4.0, 1.0));
	block.var[1][1][2] = (mat4(-5.0, -8.0, 1.0, 9.0, -7.0, -4.0, 0.0, -3.0, 6.0, 2.0, 2.0, -2.0, -8.0, 4.0, 1.0, 7.0));
	block.var[2][0][0] = (mat4(6.0, -8.0, -5.0, -4.0, 5.0, -3.0, 4.0, 6.0, 2.0, -2.0, -7.0, 5.0, -9.0, -3.0, 9.0, 5.0));
	block.var[2][0][1] = (mat4(6.0, 9.0, 2.0, 1.0, -6.0, -8.0, 8.0, -2.0, 1.0, 6.0, -5.0, 5.0, -7.0, -8.0, 9.0, 3.0));
	block.var[2][0][2] = (mat4(6.0, -6.0, -4.0, 0.0, 8.0, -9.0, -6.0, 2.0, 6.0, 7.0, 5.0, 9.0, -6.0, -9.0, -5.0, 5.0));
	block.var[2][1][0] = (mat4(4.0, -5.0, 2.0, -2.0, -1.0, 1.0, 4.0, 0.0, -1.0, -4.0, -1.0, 2.0, -4.0, 7.0, -7.0, -7.0));
	block.var[2][1][1] = (mat4(1.0, -8.0, 7.0, -2.0, 3.0, 6.0, -2.0, -7.0, -7.0, -8.0, 7.0, 1.0, -1.0, -5.0, 6.0, -5.0));
	block.var[2][1][2] = (mat4(6.0, -7.0, -1.0, -1.0, -1.0, -3.0, -6.0, 3.0, -9.0, -8.0, -5.0, 6.0, -3.0, 3.0, 8.0, -8.0));
	block.var[3][0][0] = (mat4(-5.0, 3.0, 0.0, -2.0, -1.0, -6.0, -7.0, 9.0, -9.0, 8.0, 2.0, -7.0, -7.0, 9.0, 8.0, 7.0));
	block.var[3][0][1] = (mat4(-9.0, 5.0, -4.0, -4.0, 9.0, -1.0, 3.0, -1.0, 7.0, 2.0, 8.0, -2.0, 2.0, -3.0, 0.0, -9.0));
	block.var[3][0][2] = (mat4(5.0, -1.0, 6.0, 9.0, 1.0, -7.0, -5.0, -3.0, 4.0, 8.0, -9.0, -2.0, -2.0, -1.0, -1.0, 0.0));
	block.var[3][1][0] = (mat4(5.0, -4.0, 6.0, 7.0, 5.0, 0.0, 0.0, -5.0, 4.0, -8.0, -9.0, -1.0, -8.0, 5.0, 0.0, -4.0));
	block.var[3][1][1] = (mat4(2.0, 7.0, -3.0, 8.0, -6.0, 0.0, 1.0, 7.0, 8.0, -8.0, -8.0, -9.0, -3.0, -1.0, -7.0, 0.0));
	block.var[3][1][2] = (mat4(6.0, -2.0, -5.0, -4.0, -6.0, 9.0, -4.0, -9.0, 8.0, -7.0, -5.0, -3.0, 3.0, 5.0, 4.0, -2.0));
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
	highp mat3 var[4][2][3];
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
	allOk = compare_mat3(block.var[0][0][0], mat3(3.0, -9.0, 7.0, 0.0, -1.0, -8.0, 0.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(9.0, 8.0, -4.0, -1.0, 5.0, -5.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][2], mat3(-4.0, -9.0, 4.0, 5.0, -4.0, -4.0, 6.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(9.0, 0.0, 6.0, 4.0, -2.0, 0.0, 6.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(8.0, -5.0, -1.0, -6.0, 1.0, -4.0, 2.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][2], mat3(-1.0, -9.0, 3.0, -9.0, 7.0, -5.0, 5.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(2.0, -8.0, 1.0, -2.0, 6.0, 7.0, 4.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(-9.0, -6.0, -4.0, -1.0, -5.0, 3.0, 3.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][2], mat3(-2.0, 1.0, 6.0, -7.0, 4.0, -7.0, -8.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(-6.0, -7.0, 1.0, 6.0, -5.0, 2.0, -5.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(-4.0, 8.0, -8.0, 1.0, -3.0, -3.0, -6.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][2], mat3(-2.0, 3.0, -9.0, -4.0, 3.0, -4.0, 8.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(2.0, -3.0, 5.0, 3.0, -7.0, -5.0, 0.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(8.0, 0.0, -4.0, 2.0, 4.0, -3.0, 6.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][2], mat3(-2.0, -2.0, 5.0, 9.0, 8.0, -3.0, -5.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(-4.0, 8.0, 5.0, -4.0, 1.0, 8.0, -7.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(2.0, 1.0, -5.0, 9.0, 0.0, -3.0, 6.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][2], mat3(-5.0, -6.0, 5.0, 4.0, 2.0, -6.0, -6.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][0], mat3(7.0, 0.0, 8.0, -3.0, 5.0, -5.0, 0.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][1], mat3(-9.0, -3.0, -8.0, -6.0, -2.0, -4.0, -5.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][2], mat3(2.0, -1.0, 4.0, 7.0, -7.0, 4.0, -7.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][0], mat3(9.0, 1.0, -4.0, -3.0, 1.0, -2.0, -6.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][1], mat3(4.0, -1.0, -3.0, 7.0, -3.0, -5.0, -1.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][2], mat3(4.0, -4.0, -7.0, 8.0, 2.0, 6.0, -7.0, 1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3(7.0, -8.0, -8.0, -4.0, -3.0, 5.0, -3.0, -3.0, -1.0));
	block.var[0][0][1] = (mat3(5.0, 1.0, -3.0, 9.0, 1.0, 5.0, 0.0, 5.0, -1.0));
	block.var[0][0][2] = (mat3(-7.0, 4.0, 1.0, -6.0, 3.0, 6.0, 1.0, 9.0, 3.0));
	block.var[0][1][0] = (mat3(-2.0, 4.0, 1.0, 4.0, 5.0, -8.0, 0.0, 4.0, -7.0));
	block.var[0][1][1] = (mat3(-3.0, 2.0, 7.0, -9.0, -9.0, -4.0, 6.0, -9.0, 9.0));
	block.var[0][1][2] = (mat3(-6.0, 9.0, 8.0, -8.0, -9.0, -8.0, 2.0, 4.0, 8.0));
	block.var[1][0][0] = (mat3(-9.0, 3.0, -7.0, 6.0, -9.0, 3.0, -9.0, 3.0, -6.0));
	block.var[1][0][1] = (mat3(4.0, 7.0, -6.0, -7.0, 1.0, -3.0, -6.0, -2.0, 5.0));
	block.var[1][0][2] = (mat3(7.0, -6.0, -2.0, -8.0, 7.0, 1.0, 3.0, 4.0, 0.0));
	block.var[1][1][0] = (mat3(-5.0, 6.0, -5.0, 3.0, -2.0, -2.0, -3.0, -3.0, 8.0));
	block.var[1][1][1] = (mat3(1.0, -1.0, -6.0, -7.0, -4.0, -9.0, 9.0, -4.0, -3.0));
	block.var[1][1][2] = (mat3(8.0, 7.0, -9.0, 3.0, -6.0, 1.0, -4.0, -4.0, 3.0));
	block.var[2][0][0] = (mat3(5.0, 4.0, -6.0, -9.0, -4.0, 6.0, -1.0, 8.0, -6.0));
	block.var[2][0][1] = (mat3(-3.0, 6.0, -9.0, 2.0, -5.0, 0.0, -7.0, -5.0, -3.0));
	block.var[2][0][2] = (mat3(-4.0, -4.0, 8.0, -8.0, -7.0, 7.0, -4.0, -7.0, 8.0));
	block.var[2][1][0] = (mat3(0.0, 7.0, -3.0, -5.0, -1.0, 1.0, -7.0, 1.0, -9.0));
	block.var[2][1][1] = (mat3(0.0, 7.0, 5.0, -6.0, 4.0, -6.0, 2.0, -3.0, 4.0));
	block.var[2][1][2] = (mat3(7.0, 6.0, 0.0, -2.0, -9.0, 3.0, 8.0, 9.0, -8.0));
	block.var[3][0][0] = (mat3(-8.0, -8.0, -8.0, 1.0, -5.0, -6.0, 8.0, -1.0, 2.0));
	block.var[3][0][1] = (mat3(-3.0, -8.0, 4.0, 8.0, -2.0, 3.0, -5.0, -9.0, -3.0));
	block.var[3][0][2] = (mat3(3.0, -2.0, -2.0, -3.0, 9.0, -6.0, 3.0, 5.0, 5.0));
	block.var[3][1][0] = (mat3(8.0, -8.0, -8.0, -9.0, -1.0, 4.0, 9.0, 9.0, -4.0));
	block.var[3][1][1] = (mat3(0.0, -4.0, -8.0, 9.0, 2.0, 6.0, -7.0, 5.0, -8.0));
	block.var[3][1][2] = (mat3(-9.0, -6.0, -3.0, 1.0, -9.0, -5.0, 5.0, 4.0, 5.0));
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
	highp mat2x4 var[4][2][3];
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
	allOk = compare_float((block.padding), -8.0) && allOk;
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(2.0, -3.0, -5.0, -8.0, -3.0, 6.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(-6.0, 9.0, 2.0, -1.0, 8.0, 0.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][2], mat2x4(-7.0, -3.0, 8.0, 0.0, -1.0, -5.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(-6.0, 5.0, -7.0, 0.0, 3.0, -2.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(-6.0, 1.0, 5.0, -1.0, -1.0, 5.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][2], mat2x4(-9.0, 7.0, 3.0, 1.0, 4.0, 9.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(9.0, -6.0, 8.0, -4.0, -4.0, 0.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(0.0, -1.0, 1.0, 5.0, 5.0, 3.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][2], mat2x4(-5.0, -6.0, 3.0, -2.0, 5.0, -8.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(-9.0, -6.0, -7.0, 5.0, 8.0, -3.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(-3.0, -1.0, -3.0, 3.0, -1.0, -6.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][2], mat2x4(-6.0, -8.0, 1.0, 8.0, -8.0, -4.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(-1.0, 4.0, 5.0, -9.0, 8.0, -1.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(0.0, -9.0, 6.0, -2.0, 3.0, 2.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][2], mat2x4(-2.0, 5.0, -8.0, -8.0, 0.0, -7.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(9.0, -4.0, -1.0, 2.0, 9.0, 9.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(2.0, 1.0, 4.0, 5.0, 6.0, 5.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][2], mat2x4(9.0, 2.0, -7.0, 2.0, 0.0, -9.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][0], mat2x4(9.0, 6.0, 1.0, -5.0, -1.0, 4.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][1], mat2x4(5.0, 3.0, 9.0, -3.0, 4.0, 7.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][2], mat2x4(7.0, -8.0, -2.0, 0.0, -4.0, -8.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][0], mat2x4(2.0, -5.0, 1.0, 2.0, -3.0, -8.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][1], mat2x4(9.0, 4.0, 0.0, -9.0, 5.0, 8.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][2], mat2x4(0.0, -8.0, 1.0, 2.0, 5.0, 6.0, -2.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-2.0);
	block.var[0][0][0] = (mat2x4(2.0, -2.0, 9.0, -4.0, 3.0, 2.0, -4.0, 0.0));
	block.var[0][0][1] = (mat2x4(6.0, 0.0, -1.0, -8.0, 7.0, 4.0, -8.0, 2.0));
	block.var[0][0][2] = (mat2x4(5.0, 4.0, -3.0, 4.0, 8.0, 2.0, 4.0, -6.0));
	block.var[0][1][0] = (mat2x4(7.0, 5.0, -9.0, 8.0, -7.0, -5.0, 8.0, -9.0));
	block.var[0][1][1] = (mat2x4(7.0, 5.0, -2.0, 7.0, -3.0, 4.0, 1.0, 5.0));
	block.var[0][1][2] = (mat2x4(-1.0, 8.0, 4.0, -9.0, 2.0, 3.0, -3.0, 2.0));
	block.var[1][0][0] = (mat2x4(7.0, -5.0, -1.0, -8.0, 1.0, 7.0, -9.0, -2.0));
	block.var[1][0][1] = (mat2x4(6.0, -7.0, 6.0, 9.0, -6.0, -6.0, 6.0, 3.0));
	block.var[1][0][2] = (mat2x4(7.0, -1.0, 9.0, 5.0, 9.0, 4.0, -6.0, -7.0));
	block.var[1][1][0] = (mat2x4(-7.0, 9.0, 4.0, -1.0, 5.0, 5.0, -9.0, 7.0));
	block.var[1][1][1] = (mat2x4(0.0, -9.0, 5.0, -7.0, 7.0, -4.0, 6.0, -4.0));
	block.var[1][1][2] = (mat2x4(8.0, -2.0, -5.0, 5.0, 5.0, -1.0, 5.0, 8.0));
	block.var[2][0][0] = (mat2x4(-6.0, -5.0, 9.0, 2.0, 0.0, -8.0, 2.0, 2.0));
	block.var[2][0][1] = (mat2x4(-7.0, -3.0, 5.0, 2.0, 3.0, 4.0, 6.0, 4.0));
	block.var[2][0][2] = (mat2x4(-9.0, -1.0, 6.0, -2.0, 2.0, 8.0, -5.0, 4.0));
	block.var[2][1][0] = (mat2x4(6.0, -6.0, 6.0, -3.0, 2.0, 5.0, 5.0, 1.0));
	block.var[2][1][1] = (mat2x4(2.0, -5.0, 3.0, 3.0, 8.0, 2.0, 3.0, -4.0));
	block.var[2][1][2] = (mat2x4(6.0, 8.0, 8.0, 7.0, -9.0, -5.0, -3.0, -3.0));
	block.var[3][0][0] = (mat2x4(7.0, 0.0, 6.0, 9.0, 1.0, -1.0, -1.0, 5.0));
	block.var[3][0][1] = (mat2x4(-2.0, -9.0, 9.0, 3.0, 9.0, -6.0, -6.0, 2.0));
	block.var[3][0][2] = (mat2x4(6.0, 9.0, 1.0, 5.0, 4.0, -3.0, 6.0, 1.0));
	block.var[3][1][0] = (mat2x4(-5.0, -2.0, 3.0, 1.0, -4.0, -9.0, -1.0, -1.0));
	block.var[3][1][1] = (mat2x4(-9.0, 0.0, -7.0, 1.0, 9.0, -7.0, 4.0, 9.0));
	block.var[3][1][2] = (mat2x4(-5.0, 3.0, -8.0, 6.0, -7.0, -5.0, 9.0, -7.0));
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
	highp mat2x4 var[4][2][3];
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
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(4.0, 3.0, 6.0, 3.0, -7.0, 6.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(4.0, 0.0, 9.0, -2.0, 9.0, -9.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][2], mat2x4(-7.0, 0.0, 6.0, -6.0, 9.0, 0.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(0.0, 6.0, 8.0, -9.0, 4.0, -5.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(-1.0, 7.0, 9.0, 0.0, -2.0, 5.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][2], mat2x4(4.0, 8.0, 3.0, -3.0, -8.0, 8.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(-9.0, 3.0, -1.0, -8.0, -5.0, -9.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(-4.0, -5.0, -3.0, -7.0, 1.0, -3.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][2], mat2x4(-5.0, 1.0, 2.0, 7.0, 2.0, -3.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(6.0, -4.0, -8.0, -5.0, -4.0, 3.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(0.0, 4.0, -6.0, 5.0, 2.0, 7.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][2], mat2x4(-2.0, 0.0, -7.0, 8.0, -2.0, 7.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(-1.0, 5.0, -7.0, -9.0, -6.0, -2.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(2.0, -6.0, 1.0, -5.0, 3.0, 5.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][2], mat2x4(1.0, -5.0, 0.0, 7.0, 5.0, 2.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(-3.0, -7.0, 2.0, -4.0, -3.0, -7.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(-8.0, -2.0, 6.0, 8.0, 9.0, -4.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][2], mat2x4(3.0, 5.0, -3.0, -6.0, 8.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][0], mat2x4(-6.0, 2.0, 4.0, -8.0, 4.0, 6.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][1], mat2x4(-2.0, -6.0, -2.0, -6.0, 1.0, -4.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][2], mat2x4(-3.0, -2.0, 4.0, 6.0, -7.0, 6.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][0], mat2x4(-9.0, 7.0, 2.0, -1.0, 5.0, 6.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][1], mat2x4(2.0, 9.0, -9.0, -1.0, 9.0, 5.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][2], mat2x4(8.0, 4.0, -3.0, 7.0, 5.0, 2.0, 7.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-5.0);
	block.var[0][0][0] = (mat2x4(-7.0, -7.0, 0.0, -1.0, -9.0, 5.0, -5.0, 0.0));
	block.var[0][0][1] = (mat2x4(1.0, 8.0, 9.0, 2.0, 4.0, 5.0, 5.0, 3.0));
	block.var[0][0][2] = (mat2x4(6.0, 2.0, 7.0, -1.0, -8.0, 7.0, -7.0, -8.0));
	block.var[0][1][0] = (mat2x4(3.0, 0.0, -3.0, 5.0, -4.0, 8.0, -3.0, 7.0));
	block.var[0][1][1] = (mat2x4(-1.0, 5.0, 0.0, -5.0, 2.0, -3.0, -8.0, -9.0));
	block.var[0][1][2] = (mat2x4(5.0, -6.0, -2.0, 0.0, 0.0, -2.0, -9.0, 3.0));
	block.var[1][0][0] = (mat2x4(-9.0, 5.0, -5.0, 5.0, -9.0, -7.0, -2.0, -5.0));
	block.var[1][0][1] = (mat2x4(8.0, -8.0, -8.0, 5.0, 4.0, -2.0, -7.0, -6.0));
	block.var[1][0][2] = (mat2x4(-7.0, 4.0, -6.0, 9.0, 7.0, 1.0, 7.0, 0.0));
	block.var[1][1][0] = (mat2x4(-5.0, -5.0, -6.0, 3.0, 0.0, -2.0, 5.0, -9.0));
	block.var[1][1][1] = (mat2x4(-9.0, 4.0, -7.0, -9.0, -2.0, 5.0, 9.0, 0.0));
	block.var[1][1][2] = (mat2x4(6.0, -3.0, -4.0, 0.0, -2.0, 8.0, 1.0, -3.0));
	block.var[2][0][0] = (mat2x4(-6.0, -6.0, 6.0, -1.0, 8.0, 4.0, 1.0, -5.0));
	block.var[2][0][1] = (mat2x4(4.0, -3.0, 3.0, 1.0, -9.0, -1.0, -2.0, -4.0));
	block.var[2][0][2] = (mat2x4(-7.0, -9.0, 5.0, -3.0, -7.0, 8.0, 3.0, -1.0));
	block.var[2][1][0] = (mat2x4(-9.0, -7.0, -5.0, -2.0, 8.0, -8.0, -8.0, -5.0));
	block.var[2][1][1] = (mat2x4(1.0, -1.0, 8.0, 3.0, 3.0, -4.0, 8.0, 2.0));
	block.var[2][1][2] = (mat2x4(5.0, -9.0, 0.0, -3.0, 2.0, -2.0, 9.0, -7.0));
	block.var[3][0][0] = (mat2x4(7.0, 6.0, -6.0, -8.0, -8.0, -4.0, 6.0, -5.0));
	block.var[3][0][1] = (mat2x4(3.0, -1.0, -5.0, 7.0, -3.0, -2.0, -2.0, 5.0));
	block.var[3][0][2] = (mat2x4(7.0, -6.0, -5.0, -9.0, 3.0, 7.0, 0.0, 8.0));
	block.var[3][1][0] = (mat2x4(-3.0, 5.0, -4.0, -2.0, 0.0, 2.0, -6.0, 2.0));
	block.var[3][1][1] = (mat2x4(3.0, 1.0, 6.0, -7.0, -8.0, -7.0, 9.0, -6.0));
	block.var[3][1][2] = (mat2x4(-2.0, -6.0, -8.0, -5.0, 7.0, 9.0, -5.0, -9.0));
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
	allOk = compare_float((block.padding), -5.0) && allOk;
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(-2.0, -4.0, 7.0, -9.0, -9.0, -9.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(-1.0, -5.0, -9.0, -2.0, -2.0, 2.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][2], mat4x2(-8.0, -8.0, 1.0, 3.0, 0.0, -3.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(-4.0, -2.0, 1.0, 2.0, 6.0, -5.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(8.0, -3.0, -7.0, 8.0, -1.0, -1.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][2], mat4x2(5.0, -6.0, 5.0, -9.0, -3.0, -8.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(-7.0, -1.0, 4.0, -3.0, -1.0, 6.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(8.0, -9.0, -4.0, 3.0, -1.0, -4.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][2], mat4x2(-6.0, 1.0, -7.0, 1.0, -4.0, 2.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(-9.0, 0.0, -2.0, 7.0, 4.0, 5.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(-7.0, -8.0, 5.0, 7.0, -1.0, 7.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][2], mat4x2(3.0, 5.0, -4.0, 8.0, 1.0, 5.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(-8.0, 7.0, 0.0, 5.0, 0.0, 9.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(-5.0, -3.0, 3.0, -3.0, 8.0, -4.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][2], mat4x2(0.0, 3.0, 5.0, 9.0, -9.0, 5.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(8.0, 5.0, -7.0, -9.0, 6.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(-1.0, 8.0, 0.0, -2.0, -2.0, -9.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][2], mat4x2(1.0, -7.0, 0.0, -4.0, 9.0, 4.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][0], mat4x2(-1.0, 3.0, 6.0, 8.0, -8.0, -2.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][1], mat4x2(-9.0, -2.0, 8.0, -2.0, 7.0, 5.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][2], mat4x2(8.0, -6.0, -6.0, -3.0, -1.0, -8.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][0], mat4x2(5.0, 6.0, 1.0, -2.0, 9.0, 1.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][1], mat4x2(8.0, -2.0, -7.0, 4.0, -5.0, -6.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][2], mat4x2(2.0, 3.0, -6.0, 2.0, 8.0, 6.0, 7.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (0.0);
	block.var[0][0][0] = (mat4x2(-3.0, -2.0, 2.0, -2.0, -3.0, 5.0, -5.0, 5.0));
	block.var[0][0][1] = (mat4x2(-6.0, -4.0, -1.0, 4.0, 7.0, -8.0, -2.0, -5.0));
	block.var[0][0][2] = (mat4x2(-1.0, -3.0, 6.0, -2.0, 0.0, -7.0, -7.0, 2.0));
	block.var[0][1][0] = (mat4x2(-6.0, -9.0, 6.0, 2.0, -2.0, 9.0, 8.0, 8.0));
	block.var[0][1][1] = (mat4x2(3.0, -2.0, -8.0, 8.0, 4.0, -3.0, 4.0, -5.0));
	block.var[0][1][2] = (mat4x2(5.0, 9.0, -8.0, -8.0, -5.0, -4.0, -1.0, -1.0));
	block.var[1][0][0] = (mat4x2(0.0, -6.0, 9.0, 1.0, -7.0, 4.0, -6.0, 5.0));
	block.var[1][0][1] = (mat4x2(-4.0, -3.0, 8.0, -6.0, -1.0, -6.0, 7.0, 4.0));
	block.var[1][0][2] = (mat4x2(7.0, -6.0, 5.0, -4.0, -7.0, 2.0, 1.0, 6.0));
	block.var[1][1][0] = (mat4x2(-6.0, 6.0, -3.0, -5.0, 2.0, 6.0, 1.0, -9.0));
	block.var[1][1][1] = (mat4x2(0.0, -5.0, -9.0, 9.0, 8.0, -6.0, -4.0, -4.0));
	block.var[1][1][2] = (mat4x2(-8.0, 9.0, 7.0, -5.0, -3.0, 3.0, 7.0, -1.0));
	block.var[2][0][0] = (mat4x2(-3.0, -5.0, -7.0, -7.0, 4.0, -9.0, 7.0, 2.0));
	block.var[2][0][1] = (mat4x2(2.0, 9.0, 3.0, -1.0, -8.0, 1.0, -5.0, 6.0));
	block.var[2][0][2] = (mat4x2(2.0, -6.0, 4.0, -3.0, -6.0, -7.0, -8.0, -1.0));
	block.var[2][1][0] = (mat4x2(2.0, 5.0, -9.0, 3.0, 2.0, -5.0, 4.0, -2.0));
	block.var[2][1][1] = (mat4x2(3.0, -1.0, -4.0, -7.0, 3.0, 1.0, -1.0, 3.0));
	block.var[2][1][2] = (mat4x2(6.0, -6.0, -2.0, -8.0, 0.0, -9.0, -5.0, -9.0));
	block.var[3][0][0] = (mat4x2(-4.0, -5.0, 2.0, -7.0, -1.0, 7.0, 1.0, 9.0));
	block.var[3][0][1] = (mat4x2(-3.0, -8.0, 4.0, 5.0, -9.0, 9.0, -3.0, 5.0));
	block.var[3][0][2] = (mat4x2(6.0, -5.0, 1.0, 0.0, 8.0, -9.0, -4.0, 2.0));
	block.var[3][1][0] = (mat4x2(5.0, -9.0, 2.0, -2.0, -5.0, -3.0, 5.0, -8.0));
	block.var[3][1][1] = (mat4x2(-1.0, 9.0, 1.0, -6.0, 5.0, -5.0, -9.0, 7.0));
	block.var[3][1][2] = (mat4x2(1.0, 0.0, 3.0, 4.0, 8.0, 8.0, -2.0, 4.0));
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
	int8_t padding;
	i8vec2 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(block.padding), 4294967288) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[0][0][0]), ivec2(4294967293, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[0][0][1]), ivec2(9, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[0][0][2]), ivec2(1, 4294967288)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[0][1][0]), ivec2(3, 2)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[0][1][1]), ivec2(6, 4294967290)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[0][1][2]), ivec2(4294967289, 5)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][0][0]), ivec2(4294967293, 4294967290)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][0][1]), ivec2(4294967287, 4294967289)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][0][2]), ivec2(2, 4294967287)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][1][0]), ivec2(4294967289, 8)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][1][1]), ivec2(7, 4294967294)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][1][2]), ivec2(4294967288, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][0][0]), ivec2(7, 6)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][0][1]), ivec2(0, 3)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][0][2]), ivec2(7, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][1][0]), ivec2(4294967292, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][1][1]), ivec2(4294967293, 2)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][1][2]), ivec2(0, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[3][0][0]), ivec2(4294967293, 6)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[3][0][1]), ivec2(9, 3)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[3][0][2]), ivec2(1, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[3][1][0]), ivec2(0, 4294967289)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[3][1][1]), ivec2(7, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[3][1][2]), ivec2(9, 2)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = int8_t(0);
	block.var[0][0][0] = i8vec2(ivec2(8, 4294967292));
	block.var[0][0][1] = i8vec2(ivec2(9, 4294967294));
	block.var[0][0][2] = i8vec2(ivec2(4294967295, 8));
	block.var[0][1][0] = i8vec2(ivec2(0, 3));
	block.var[0][1][1] = i8vec2(ivec2(4294967291, 4294967295));
	block.var[0][1][2] = i8vec2(ivec2(4294967292, 5));
	block.var[1][0][0] = i8vec2(ivec2(4294967290, 8));
	block.var[1][0][1] = i8vec2(ivec2(4294967289, 7));
	block.var[1][0][2] = i8vec2(ivec2(4294967294, 4294967293));
	block.var[1][1][0] = i8vec2(ivec2(4294967292, 4294967291));
	block.var[1][1][1] = i8vec2(ivec2(4, 0));
	block.var[1][1][2] = i8vec2(ivec2(4294967293, 4294967292));
	block.var[2][0][0] = i8vec2(ivec2(4294967293, 4294967290));
	block.var[2][0][1] = i8vec2(ivec2(3, 4294967295));
	block.var[2][0][2] = i8vec2(ivec2(8, 5));
	block.var[2][1][0] = i8vec2(ivec2(4294967292, 3));
	block.var[2][1][1] = i8vec2(ivec2(4294967294, 8));
	block.var[2][1][2] = i8vec2(ivec2(4, 8));
	block.var[3][0][0] = i8vec2(ivec2(8, 4294967293));
	block.var[3][0][1] = i8vec2(ivec2(4294967292, 4294967287));
	block.var[3][0][2] = i8vec2(ivec2(6, 4294967293));
	block.var[3][1][0] = i8vec2(ivec2(6, 5));
	block.var[3][1][1] = i8vec2(ivec2(4294967294, 4294967288));
	block.var[3][1][2] = i8vec2(ivec2(4294967292, 4));
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
	bvec3 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((block.var[0][0][0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((block.var[0][0][1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((block.var[0][1][0]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((block.var[0][1][1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((block.var[0][2][0]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((block.var[0][2][1]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((block.var[0][3][0]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((block.var[0][3][1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[1][0][0]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((block.var[1][0][1]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((block.var[1][1][0]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((block.var[1][1][1]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((block.var[1][2][0]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[1][2][1]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((block.var[1][3][0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((block.var[1][3][1]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((block.var[2][0][0]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[2][0][1]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((block.var[2][1][0]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[2][1][1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[2][2][0]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[2][2][1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((block.var[2][3][0]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((block.var[2][3][1]), bvec3(false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (bvec3(true, true, false));
	block.var[0][0][1] = (bvec3(false, true, true));
	block.var[0][1][0] = (bvec3(false, true, true));
	block.var[0][1][1] = (bvec3(true, true, true));
	block.var[0][2][0] = (bvec3(false, false, true));
	block.var[0][2][1] = (bvec3(true, false, true));
	block.var[0][3][0] = (bvec3(true, true, false));
	block.var[0][3][1] = (bvec3(false, true, false));
	block.var[1][0][0] = (bvec3(false, false, false));
	block.var[1][0][1] = (bvec3(true, false, false));
	block.var[1][1][0] = (bvec3(true, true, true));
	block.var[1][1][1] = (bvec3(true, false, false));
	block.var[1][2][0] = (bvec3(false, false, false));
	block.var[1][2][1] = (bvec3(true, true, false));
	block.var[1][3][0] = (bvec3(false, true, false));
	block.var[1][3][1] = (bvec3(false, false, false));
	block.var[2][0][0] = (bvec3(true, true, true));
	block.var[2][0][1] = (bvec3(false, true, true));
	block.var[2][1][0] = (bvec3(false, true, false));
	block.var[2][1][1] = (bvec3(true, false, false));
	block.var[2][2][0] = (bvec3(false, false, true));
	block.var[2][2][1] = (bvec3(false, false, true));
	block.var[2][3][0] = (bvec3(true, true, false));
	block.var[2][3][1] = (bvec3(false, true, false));
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

layout(std140, buffer_reference) buffer Block
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
	allOk = compare_mat3x4(block.var[0][0][0], mat3x4(-3.0, 3.0, -8.0, 8.0, 6.0, -9.0, -3.0, -1.0, 6.0, 3.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][1], mat3x4(2.0, -8.0, 1.0, 2.0, -6.0, 8.0, -8.0, -3.0, 2.0, 5.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(-9.0, -4.0, -3.0, -7.0, 2.0, -1.0, 8.0, -1.0, 3.0, -7.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(-1.0, 9.0, 2.0, 4.0, 6.0, -7.0, -6.0, 4.0, -4.0, 5.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][0], mat3x4(3.0, 8.0, 5.0, 9.0, 4.0, 6.0, 7.0, 0.0, 4.0, 7.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][1], mat3x4(8.0, -7.0, -1.0, 4.0, -8.0, -5.0, 3.0, 6.0, 4.0, -1.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][0], mat3x4(8.0, 9.0, 2.0, 2.0, 6.0, -3.0, 4.0, -7.0, 0.0, 1.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][1], mat3x4(-9.0, -7.0, -8.0, -4.0, 8.0, 2.0, 3.0, 0.0, -9.0, -9.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(-6.0, -3.0, 5.0, 7.0, 3.0, -1.0, -9.0, -1.0, 5.0, 0.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(8.0, -1.0, -7.0, 5.0, -9.0, 3.0, -2.0, -3.0, 3.0, -3.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(-2.0, 2.0, 0.0, 4.0, 8.0, 7.0, -4.0, -1.0, -4.0, -9.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(0.0, 2.0, -8.0, 5.0, -6.0, 3.0, 1.0, -5.0, -3.0, -6.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][0], mat3x4(6.0, -2.0, -4.0, 2.0, -1.0, -5.0, -1.0, -2.0, 9.0, 8.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][1], mat3x4(-9.0, 3.0, 2.0, 5.0, -9.0, -1.0, -7.0, 5.0, -3.0, -9.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][0], mat3x4(3.0, -4.0, -8.0, 9.0, -6.0, -5.0, 4.0, -7.0, 8.0, -7.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][1], mat3x4(8.0, 1.0, 3.0, 3.0, 6.0, 0.0, -6.0, 2.0, -5.0, 9.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(-3.0, -9.0, -1.0, -5.0, -4.0, -4.0, -6.0, 0.0, -3.0, -5.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(-2.0, -4.0, 8.0, 3.0, -8.0, -8.0, 6.0, -5.0, -9.0, -1.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(4.0, 1.0, 9.0, 2.0, -4.0, -7.0, 1.0, 3.0, 1.0, -2.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(8.0, -5.0, -5.0, 4.0, 9.0, 5.0, -5.0, -3.0, 9.0, 0.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][0], mat3x4(7.0, 3.0, 5.0, 9.0, -3.0, -2.0, -1.0, 5.0, -5.0, -7.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][1], mat3x4(2.0, 0.0, -7.0, 6.0, 9.0, -6.0, -1.0, 6.0, 6.0, 4.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][0], mat3x4(1.0, 4.0, 2.0, -6.0, 2.0, 3.0, -5.0, 6.0, 7.0, 7.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][1], mat3x4(7.0, -2.0, -5.0, 2.0, -9.0, -4.0, 9.0, -9.0, -8.0, 1.0, -5.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3x4(-8.0, -6.0, 4.0, -9.0, 7.0, -4.0, -7.0, 0.0, -6.0, -6.0, -3.0, 4.0));
	block.var[0][0][1] = (mat3x4(3.0, -2.0, -3.0, 4.0, 2.0, 8.0, 2.0, -4.0, 9.0, -1.0, 9.0, 7.0));
	block.var[0][1][0] = (mat3x4(6.0, 6.0, -8.0, 6.0, 2.0, 8.0, -6.0, 2.0, -8.0, 2.0, 6.0, 9.0));
	block.var[0][1][1] = (mat3x4(3.0, -3.0, 9.0, -1.0, 6.0, 2.0, -8.0, 0.0, 1.0, 1.0, -3.0, 0.0));
	block.var[0][2][0] = (mat3x4(9.0, -2.0, 8.0, -4.0, 8.0, 4.0, 3.0, -3.0, 3.0, -5.0, 7.0, -8.0));
	block.var[0][2][1] = (mat3x4(5.0, -3.0, 8.0, 6.0, 1.0, 6.0, -2.0, -6.0, 0.0, 1.0, 3.0, 3.0));
	block.var[0][3][0] = (mat3x4(3.0, -7.0, -1.0, 2.0, -7.0, -9.0, 4.0, 1.0, -9.0, 4.0, 5.0, -1.0));
	block.var[0][3][1] = (mat3x4(-3.0, -8.0, 4.0, 4.0, -5.0, 6.0, 7.0, 6.0, 5.0, 2.0, 2.0, -5.0));
	block.var[1][0][0] = (mat3x4(1.0, -1.0, 1.0, 5.0, 5.0, -4.0, -7.0, -4.0, 0.0, 6.0, 2.0, 0.0));
	block.var[1][0][1] = (mat3x4(-6.0, 7.0, -1.0, 6.0, 4.0, -9.0, -9.0, -1.0, -8.0, 4.0, -6.0, 6.0));
	block.var[1][1][0] = (mat3x4(9.0, 4.0, -6.0, 6.0, 2.0, 1.0, 9.0, -3.0, -3.0, -6.0, -6.0, -8.0));
	block.var[1][1][1] = (mat3x4(5.0, 0.0, -6.0, 3.0, 0.0, -8.0, 3.0, 9.0, -6.0, -2.0, 5.0, -8.0));
	block.var[1][2][0] = (mat3x4(-3.0, 0.0, -3.0, 5.0, -4.0, -5.0, 1.0, -5.0, -5.0, 0.0, 0.0, -6.0));
	block.var[1][2][1] = (mat3x4(4.0, 6.0, -7.0, 7.0, 3.0, 6.0, 4.0, -7.0, 8.0, -1.0, 3.0, 3.0));
	block.var[1][3][0] = (mat3x4(8.0, -2.0, -8.0, -1.0, -5.0, -1.0, -6.0, 3.0, 7.0, -8.0, -6.0, -9.0));
	block.var[1][3][1] = (mat3x4(-5.0, -1.0, 4.0, 9.0, -9.0, -3.0, -8.0, -1.0, 5.0, 9.0, -6.0, 2.0));
	block.var[2][0][0] = (mat3x4(7.0, -8.0, -5.0, -9.0, -9.0, -2.0, 4.0, 1.0, -3.0, 3.0, -2.0, 2.0));
	block.var[2][0][1] = (mat3x4(-1.0, 2.0, -4.0, -7.0, 9.0, 2.0, -7.0, -8.0, -2.0, -3.0, 3.0, -4.0));
	block.var[2][1][0] = (mat3x4(0.0, -3.0, -8.0, 2.0, 8.0, 8.0, -1.0, 4.0, -6.0, 8.0, 9.0, 8.0));
	block.var[2][1][1] = (mat3x4(5.0, 7.0, 3.0, 7.0, 9.0, 9.0, 6.0, 5.0, 3.0, 5.0, 2.0, -8.0));
	block.var[2][2][0] = (mat3x4(-1.0, 0.0, -1.0, 5.0, 3.0, -9.0, 6.0, 8.0, -9.0, -5.0, -1.0, 1.0));
	block.var[2][2][1] = (mat3x4(-1.0, -4.0, 7.0, 7.0, 5.0, -7.0, 1.0, 3.0, 6.0, 3.0, -3.0, -9.0));
	block.var[2][3][0] = (mat3x4(-6.0, 6.0, -6.0, 7.0, 6.0, -6.0, 8.0, 9.0, 6.0, 0.0, 7.0, 8.0));
	block.var[2][3][1] = (mat3x4(7.0, -9.0, -9.0, -4.0, 2.0, 7.0, 9.0, -8.0, -5.0, 6.0, 2.0, -3.0));
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
	allOk = compare_mat3x4(block.var[0][0][0], mat3x4(5.0, -7.0, -9.0, 4.0, 5.0, 3.0, -7.0, -3.0, 7.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][1], mat3x4(-9.0, 7.0, -4.0, 5.0, -9.0, -5.0, 2.0, 6.0, -3.0, -5.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(2.0, 3.0, 2.0, 5.0, -4.0, -4.0, 2.0, 8.0, 5.0, -5.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(-3.0, 3.0, -2.0, 6.0, 9.0, -7.0, 8.0, 8.0, 1.0, 9.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][0], mat3x4(-3.0, -7.0, 5.0, 2.0, -5.0, 9.0, -1.0, -1.0, 1.0, -7.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][1], mat3x4(2.0, 0.0, 8.0, -9.0, 5.0, -4.0, 5.0, -7.0, 0.0, 5.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][0], mat3x4(3.0, 5.0, -2.0, -6.0, -7.0, -4.0, 6.0, 5.0, -9.0, 2.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][1], mat3x4(3.0, 3.0, 4.0, -2.0, -8.0, -6.0, -3.0, -8.0, 4.0, 4.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(4.0, 1.0, 3.0, -1.0, -3.0, -2.0, 2.0, 7.0, 5.0, -1.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(5.0, 1.0, -8.0, -9.0, -6.0, 4.0, 0.0, -9.0, 0.0, -1.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(1.0, -2.0, 4.0, 2.0, 7.0, -2.0, -9.0, 6.0, -4.0, 0.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(6.0, -8.0, 1.0, 3.0, 2.0, -7.0, 4.0, -9.0, -7.0, 0.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][0], mat3x4(3.0, 6.0, -3.0, 3.0, 9.0, -1.0, -3.0, 6.0, -9.0, 9.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][1], mat3x4(-2.0, 8.0, 5.0, -9.0, 0.0, -8.0, 8.0, -8.0, 6.0, -2.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][0], mat3x4(3.0, -8.0, -9.0, 5.0, -7.0, 3.0, -2.0, -7.0, 6.0, 6.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][1], mat3x4(1.0, -4.0, -8.0, 8.0, -6.0, -1.0, -5.0, -2.0, -6.0, 4.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(-3.0, 6.0, 3.0, 0.0, -4.0, 2.0, 4.0, 3.0, -4.0, 9.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(-1.0, 6.0, 5.0, -4.0, -5.0, 7.0, -4.0, -5.0, 8.0, -9.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(-8.0, 4.0, 3.0, 2.0, 2.0, 0.0, -5.0, -4.0, 7.0, 3.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(2.0, 0.0, -3.0, 3.0, -7.0, 7.0, -8.0, 9.0, -2.0, 5.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][0], mat3x4(-5.0, -3.0, 9.0, 7.0, 1.0, -1.0, -8.0, -6.0, 5.0, 0.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][1], mat3x4(5.0, -7.0, -3.0, -7.0, 3.0, 9.0, -6.0, -7.0, -4.0, 4.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][0], mat3x4(0.0, 9.0, 4.0, 8.0, 4.0, -1.0, 1.0, -2.0, -5.0, 9.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][1], mat3x4(-8.0, -6.0, -8.0, -9.0, -5.0, -1.0, 6.0, 9.0, -6.0, -3.0, -6.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3x4(0.0, 2.0, -8.0, -3.0, 5.0, -1.0, 3.0, -5.0, -9.0, -7.0, 8.0, -9.0));
	block.var[0][0][1] = (mat3x4(0.0, -5.0, 1.0, -9.0, -1.0, 4.0, 7.0, 4.0, -4.0, -6.0, 0.0, -5.0));
	block.var[0][1][0] = (mat3x4(-7.0, -8.0, -2.0, 9.0, -8.0, 3.0, 9.0, 9.0, 5.0, -8.0, -1.0, 2.0));
	block.var[0][1][1] = (mat3x4(1.0, 5.0, 7.0, 5.0, -4.0, -7.0, -5.0, -9.0, -1.0, 6.0, 2.0, 4.0));
	block.var[0][2][0] = (mat3x4(-3.0, -3.0, -1.0, -2.0, 7.0, 1.0, 7.0, 0.0, -9.0, 2.0, -2.0, -6.0));
	block.var[0][2][1] = (mat3x4(4.0, -5.0, -8.0, -9.0, 4.0, 2.0, -1.0, -3.0, 9.0, -6.0, -9.0, -8.0));
	block.var[0][3][0] = (mat3x4(-9.0, -9.0, 8.0, -1.0, 9.0, 2.0, -9.0, -3.0, -9.0, -1.0, 3.0, -2.0));
	block.var[0][3][1] = (mat3x4(4.0, -7.0, 2.0, 7.0, 3.0, -7.0, 7.0, 6.0, 9.0, -4.0, 4.0, 0.0));
	block.var[1][0][0] = (mat3x4(-7.0, 5.0, -9.0, -3.0, -7.0, 7.0, 1.0, -4.0, 7.0, -8.0, -2.0, -9.0));
	block.var[1][0][1] = (mat3x4(0.0, -2.0, -8.0, -5.0, 0.0, 5.0, -2.0, -1.0, 5.0, 8.0, -3.0, 1.0));
	block.var[1][1][0] = (mat3x4(-1.0, 2.0, 3.0, -5.0, -6.0, -4.0, 4.0, -7.0, -1.0, 8.0, -9.0, 2.0));
	block.var[1][1][1] = (mat3x4(-2.0, 9.0, -8.0, 3.0, -5.0, 6.0, -8.0, 3.0, -8.0, 6.0, 6.0, -8.0));
	block.var[1][2][0] = (mat3x4(7.0, 6.0, -3.0, -6.0, -1.0, 2.0, 7.0, -9.0, -3.0, -4.0, -1.0, 0.0));
	block.var[1][2][1] = (mat3x4(-7.0, 4.0, 3.0, -4.0, 4.0, 2.0, -4.0, -3.0, 8.0, 9.0, 9.0, 8.0));
	block.var[1][3][0] = (mat3x4(7.0, -5.0, 6.0, 4.0, 1.0, 6.0, 4.0, 4.0, 3.0, -2.0, 6.0, -9.0));
	block.var[1][3][1] = (mat3x4(-6.0, 0.0, 0.0, -3.0, -3.0, 7.0, -1.0, 4.0, 4.0, 5.0, 2.0, 5.0));
	block.var[2][0][0] = (mat3x4(-1.0, 7.0, 7.0, 7.0, 2.0, -7.0, 8.0, -3.0, -8.0, -2.0, -5.0, -6.0));
	block.var[2][0][1] = (mat3x4(5.0, 8.0, 9.0, 8.0, 7.0, 0.0, 9.0, 7.0, -3.0, -7.0, -6.0, -5.0));
	block.var[2][1][0] = (mat3x4(-3.0, 2.0, 8.0, 3.0, -1.0, 0.0, -7.0, 5.0, 3.0, 2.0, 9.0, -2.0));
	block.var[2][1][1] = (mat3x4(-7.0, -5.0, -3.0, 6.0, -7.0, -8.0, -4.0, 1.0, 0.0, 0.0, 1.0, 9.0));
	block.var[2][2][0] = (mat3x4(1.0, 2.0, 5.0, 6.0, 8.0, 4.0, 6.0, -3.0, 6.0, -7.0, 9.0, -9.0));
	block.var[2][2][1] = (mat3x4(-9.0, -8.0, 4.0, 0.0, -8.0, 2.0, 2.0, -2.0, -7.0, 9.0, 5.0, -9.0));
	block.var[2][3][0] = (mat3x4(1.0, 9.0, -5.0, -8.0, -5.0, 7.0, -5.0, 0.0, -4.0, 2.0, 3.0, 5.0));
	block.var[2][3][1] = (mat3x4(4.0, 2.0, 3.0, 5.0, 5.0, -9.0, -8.0, -9.0, -7.0, 8.0, 4.0, -2.0));
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
	i8vec4 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(block.var[0][0][0]), ivec4(4294967293, 4294967289, 4294967295, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[0][0][1]), ivec4(5, 4294967288, 4294967292, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[0][1][0]), ivec4(1, 4294967295, 4294967292, 6)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[0][1][1]), ivec4(4294967291, 5, 4294967289, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[0][2][0]), ivec4(4294967293, 4294967294, 4, 2)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[0][2][1]), ivec4(4294967289, 6, 8, 5)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[0][3][0]), ivec4(4294967287, 4294967291, 5, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[0][3][1]), ivec4(3, 4294967287, 4294967291, 4294967292)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][0][0]), ivec4(3, 3, 4294967290, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][0][1]), ivec4(4294967289, 4294967292, 4294967291, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][1][0]), ivec4(7, 2, 2, 4)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][1][1]), ivec4(4294967295, 9, 4294967287, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][2][0]), ivec4(4294967290, 4294967289, 4294967295, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][2][1]), ivec4(4294967293, 4294967287, 4294967292, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][3][0]), ivec4(4294967291, 8, 0, 7)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][3][1]), ivec4(6, 4294967288, 3, 4294967292)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][0][0]), ivec4(1, 4294967288, 8, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][0][1]), ivec4(0, 3, 4294967294, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][1][0]), ivec4(8, 4294967290, 4294967289, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][1][1]), ivec4(4294967293, 4294967288, 9, 2)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][2][0]), ivec4(5, 4294967290, 4294967294, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][2][1]), ivec4(9, 3, 7, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][3][0]), ivec4(4, 4294967290, 7, 4294967290)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][3][1]), ivec4(0, 5, 8, 4294967289)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = i8vec4(ivec4(4294967294, 4294967292, 4294967290, 4294967289));
	block.var[0][0][1] = i8vec4(ivec4(4294967291, 4294967291, 4, 4294967290));
	block.var[0][1][0] = i8vec4(ivec4(8, 5, 4, 5));
	block.var[0][1][1] = i8vec4(ivec4(5, 4294967289, 4294967287, 4294967294));
	block.var[0][2][0] = i8vec4(ivec4(3, 4294967293, 4294967290, 4294967290));
	block.var[0][2][1] = i8vec4(ivec4(8, 4294967289, 4294967292, 2));
	block.var[0][3][0] = i8vec4(ivec4(1, 0, 5, 0));
	block.var[0][3][1] = i8vec4(ivec4(4294967293, 0, 4294967294, 6));
	block.var[1][0][0] = i8vec4(ivec4(4294967295, 4294967287, 4294967293, 8));
	block.var[1][0][1] = i8vec4(ivec4(6, 4, 9, 4294967287));
	block.var[1][1][0] = i8vec4(ivec4(4294967291, 4294967291, 4, 5));
	block.var[1][1][1] = i8vec4(ivec4(4294967293, 4294967294, 4294967289, 4294967291));
	block.var[1][2][0] = i8vec4(ivec4(4294967295, 9, 4294967295, 6));
	block.var[1][2][1] = i8vec4(ivec4(6, 4294967289, 4294967293, 4294967289));
	block.var[1][3][0] = i8vec4(ivec4(6, 1, 0, 2));
	block.var[1][3][1] = i8vec4(ivec4(6, 1, 9, 4294967291));
	block.var[2][0][0] = i8vec4(ivec4(4294967295, 4294967292, 4294967287, 3));
	block.var[2][0][1] = i8vec4(ivec4(9, 4294967288, 4294967290, 4294967287));
	block.var[2][1][0] = i8vec4(ivec4(2, 5, 4, 6));
	block.var[2][1][1] = i8vec4(ivec4(4294967292, 7, 8, 9));
	block.var[2][2][0] = i8vec4(ivec4(6, 7, 5, 5));
	block.var[2][2][1] = i8vec4(ivec4(4294967291, 4, 3, 4294967290));
	block.var[2][3][0] = i8vec4(ivec4(4294967295, 0, 3, 9));
	block.var[2][3][1] = i8vec4(ivec4(2, 7, 7, 4294967293));
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
	highp mat4 var[][4][2];
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
	allOk = compare_mat4(block.var[0][0][0], mat4(1.0, 6.0, 7.0, 5.0, 2.0, -4.0, 0.0, 8.0, 3.0, 3.0, 9.0, 8.0, -2.0, 7.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][1], mat4(-1.0, 1.0, 9.0, 1.0, -2.0, -7.0, 3.0, 5.0, 2.0, -8.0, 8.0, -1.0, -4.0, -5.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][0], mat4(-3.0, 8.0, 3.0, 5.0, 3.0, 4.0, 5.0, 4.0, -2.0, -6.0, -8.0, -4.0, -5.0, -1.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][1], mat4(3.0, -1.0, -2.0, -6.0, -8.0, 2.0, 9.0, -9.0, 2.0, -3.0, 5.0, -1.0, -5.0, -4.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[0][2][0], mat4(-3.0, 4.0, 8.0, 3.0, 4.0, -3.0, -4.0, -1.0, -4.0, 5.0, -4.0, 7.0, -7.0, 3.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[0][2][1], mat4(-6.0, -2.0, 6.0, 9.0, 8.0, -2.0, 0.0, 5.0, -9.0, 5.0, -1.0, 4.0, -3.0, 8.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[0][3][0], mat4(1.0, 6.0, -9.0, -8.0, -5.0, -5.0, 8.0, 1.0, 7.0, -6.0, -8.0, 7.0, -7.0, -3.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[0][3][1], mat4(-3.0, -8.0, 9.0, 1.0, 3.0, -9.0, 9.0, -2.0, -7.0, 2.0, 9.0, -7.0, -5.0, 5.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][0], mat4(-9.0, 1.0, 1.0, -6.0, 5.0, -8.0, -6.0, -3.0, -4.0, 8.0, 9.0, -9.0, -4.0, -2.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][1], mat4(-7.0, -7.0, 7.0, -7.0, 4.0, 1.0, -4.0, -7.0, 6.0, -4.0, -3.0, -1.0, -2.0, -9.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][0], mat4(9.0, 9.0, 2.0, -3.0, -5.0, 5.0, 4.0, -6.0, -7.0, -1.0, -4.0, 6.0, -7.0, -9.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][1], mat4(-5.0, -1.0, 3.0, -4.0, 5.0, -7.0, -2.0, 3.0, 0.0, -1.0, 7.0, 5.0, -6.0, -1.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[1][2][0], mat4(0.0, -2.0, 6.0, -1.0, 9.0, 9.0, -9.0, 0.0, 4.0, -3.0, 4.0, 1.0, -1.0, 3.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[1][2][1], mat4(-2.0, -2.0, 2.0, -3.0, 4.0, -1.0, 6.0, -4.0, 3.0, 0.0, 8.0, 1.0, -9.0, 8.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[1][3][0], mat4(-6.0, -4.0, -8.0, -3.0, -3.0, 0.0, 3.0, 9.0, 7.0, 2.0, 4.0, 6.0, -9.0, 8.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[1][3][1], mat4(-5.0, -2.0, 1.0, -4.0, 8.0, -8.0, -5.0, -7.0, 8.0, -9.0, 4.0, 3.0, 2.0, 9.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][0], mat4(0.0, -8.0, 2.0, 0.0, -4.0, 1.0, 6.0, 1.0, 2.0, -1.0, -8.0, -9.0, -1.0, -9.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][1], mat4(-8.0, -3.0, -4.0, -8.0, 3.0, 1.0, 4.0, -4.0, -2.0, 6.0, -8.0, 3.0, 7.0, 5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][0], mat4(1.0, -9.0, -6.0, 7.0, 6.0, 4.0, -5.0, 0.0, 8.0, -4.0, -3.0, -6.0, -7.0, 4.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][1], mat4(-2.0, 4.0, -8.0, 7.0, -3.0, 2.0, -9.0, -8.0, 8.0, 9.0, -5.0, 0.0, 4.0, 3.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[2][2][0], mat4(1.0, -7.0, -9.0, 0.0, -1.0, -2.0, -1.0, 9.0, -9.0, 0.0, -4.0, -1.0, -6.0, 2.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[2][2][1], mat4(-2.0, -9.0, -3.0, 9.0, -7.0, -2.0, 7.0, 7.0, 1.0, 9.0, -4.0, 7.0, 0.0, 3.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[2][3][0], mat4(4.0, -4.0, 9.0, 3.0, -5.0, -7.0, 0.0, 3.0, -3.0, 6.0, -9.0, 9.0, 9.0, 8.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[2][3][1], mat4(9.0, 7.0, -7.0, -6.0, 0.0, -3.0, -2.0, 5.0, 2.0, -1.0, 0.0, -8.0, 1.0, -4.0, -7.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(-3.0, -6.0, 8.0, 7.0));
	block.var[0][0][0][1] = (vec4(-8.0, 6.0, 1.0, -6.0));
	block.var[0][0][0][2] = (vec4(6.0, 0.0, -6.0, 3.0));
	block.var[0][0][0][3] = (vec4(3.0, 3.0, -3.0, 2.0));
	block.var[0][0][1][0] = (vec4(-8.0, 9.0, -6.0, 6.0));
	block.var[0][0][1][1] = (vec4(1.0, 9.0, -7.0, 4.0));
	block.var[0][0][1][2] = (vec4(-5.0, 5.0, -6.0, 5.0));
	block.var[0][0][1][3] = (vec4(7.0, 7.0, -5.0, -9.0));
	block.var[0][1][0][0] = (vec4(7.0, -2.0, -7.0, 3.0));
	block.var[0][1][0][1] = (vec4(8.0, -7.0, -6.0, 4.0));
	block.var[0][1][0][2] = (vec4(-4.0, 6.0, -2.0, -7.0));
	block.var[0][1][0][3] = (vec4(7.0, 8.0, -8.0, -2.0));
	block.var[0][1][1][0] = (vec4(-8.0, 3.0, 9.0, 3.0));
	block.var[0][1][1][1] = (vec4(1.0, -3.0, -5.0, -8.0));
	block.var[0][1][1][2] = (vec4(-7.0, 5.0, -1.0, -6.0));
	block.var[0][1][1][3] = (vec4(8.0, -8.0, 4.0, 8.0));
	block.var[0][2][0][0] = (vec4(8.0, -9.0, 9.0, 7.0));
	block.var[0][2][0][1] = (vec4(-9.0, 5.0, 1.0, -4.0));
	block.var[0][2][0][2] = (vec4(-1.0, -2.0, 1.0, 5.0));
	block.var[0][2][0][3] = (vec4(-1.0, -5.0, 7.0, -6.0));
	block.var[0][2][1][0] = (vec4(1.0, 0.0, 9.0, -3.0));
	block.var[0][2][1][1] = (vec4(7.0, 0.0, -6.0, -7.0));
	block.var[0][2][1][2] = (vec4(-8.0, 1.0, -2.0, 9.0));
	block.var[0][2][1][3] = (vec4(0.0, -2.0, 6.0, -1.0));
	block.var[0][3][0][0] = (vec4(-2.0, -6.0, -2.0, -5.0));
	block.var[0][3][0][1] = (vec4(-9.0, 4.0, 4.0, -5.0));
	block.var[0][3][0][2] = (vec4(-1.0, -1.0, 0.0, -7.0));
	block.var[0][3][0][3] = (vec4(5.0, 7.0, -3.0, -7.0));
	block.var[0][3][1][0] = (vec4(9.0, -7.0, 5.0, 1.0));
	block.var[0][3][1][1] = (vec4(-7.0, 4.0, 8.0, -9.0));
	block.var[0][3][1][2] = (vec4(6.0, 2.0, -8.0, 8.0));
	block.var[0][3][1][3] = (vec4(3.0, 6.0, 9.0, 6.0));
	block.var[1][0][0][0] = (vec4(7.0, -2.0, -1.0, -4.0));
	block.var[1][0][0][1] = (vec4(-3.0, 3.0, -8.0, 7.0));
	block.var[1][0][0][2] = (vec4(-8.0, -5.0, -9.0, -1.0));
	block.var[1][0][0][3] = (vec4(0.0, -7.0, 7.0, 8.0));
	block.var[1][0][1][0] = (vec4(-6.0, -6.0, -1.0, 6.0));
	block.var[1][0][1][1] = (vec4(3.0, 5.0, -8.0, 3.0));
	block.var[1][0][1][2] = (vec4(1.0, -1.0, 3.0, -5.0));
	block.var[1][0][1][3] = (vec4(4.0, -4.0, 3.0, 4.0));
	block.var[1][1][0][0] = (vec4(6.0, -5.0, 4.0, -3.0));
	block.var[1][1][0][1] = (vec4(-1.0, -8.0, 3.0, 5.0));
	block.var[1][1][0][2] = (vec4(0.0, 7.0, 6.0, -4.0));
	block.var[1][1][0][3] = (vec4(1.0, 4.0, 3.0, 6.0));
	block.var[1][1][1][0] = (vec4(-3.0, -8.0, -6.0, 5.0));
	block.var[1][1][1][1] = (vec4(-9.0, -3.0, 0.0, -1.0));
	block.var[1][1][1][2] = (vec4(-5.0, 9.0, -8.0, -9.0));
	block.var[1][1][1][3] = (vec4(-1.0, 2.0, 5.0, 6.0));
	block.var[1][2][0][0] = (vec4(-5.0, -1.0, -3.0, 5.0));
	block.var[1][2][0][1] = (vec4(-7.0, 4.0, 5.0, -9.0));
	block.var[1][2][0][2] = (vec4(-1.0, 0.0, 8.0, 8.0));
	block.var[1][2][0][3] = (vec4(-3.0, 4.0, -4.0, -4.0));
	block.var[1][2][1][0] = (vec4(5.0, 8.0, -8.0, -1.0));
	block.var[1][2][1][1] = (vec4(-7.0, 8.0, 4.0, -1.0));
	block.var[1][2][1][2] = (vec4(-1.0, -9.0, 3.0, 2.0));
	block.var[1][2][1][3] = (vec4(4.0, -2.0, 7.0, 5.0));
	block.var[1][3][0][0] = (vec4(-4.0, -8.0, -1.0, 1.0));
	block.var[1][3][0][1] = (vec4(0.0, 5.0, 8.0, 6.0));
	block.var[1][3][0][2] = (vec4(3.0, 8.0, -7.0, -1.0));
	block.var[1][3][0][3] = (vec4(2.0, 3.0, 7.0, 3.0));
	block.var[1][3][1][0] = (vec4(-2.0, -1.0, 0.0, -2.0));
	block.var[1][3][1][1] = (vec4(7.0, -6.0, 5.0, 5.0));
	block.var[1][3][1][2] = (vec4(-9.0, -8.0, -5.0, 0.0));
	block.var[1][3][1][3] = (vec4(-2.0, 3.0, 8.0, 4.0));
	block.var[2][0][0][0] = (vec4(-4.0, -8.0, 4.0, 5.0));
	block.var[2][0][0][1] = (vec4(-5.0, 0.0, -3.0, -4.0));
	block.var[2][0][0][2] = (vec4(5.0, -4.0, -7.0, 4.0));
	block.var[2][0][0][3] = (vec4(-3.0, 9.0, 3.0, -4.0));
	block.var[2][0][1][0] = (vec4(-3.0, -9.0, 6.0, -3.0));
	block.var[2][0][1][1] = (vec4(-6.0, -1.0, 8.0, 3.0));
	block.var[2][0][1][2] = (vec4(-2.0, 9.0, -2.0, -3.0));
	block.var[2][0][1][3] = (vec4(-8.0, 3.0, -8.0, 5.0));
	block.var[2][1][0][0] = (vec4(2.0, 3.0, 8.0, 8.0));
	block.var[2][1][0][1] = (vec4(-7.0, -1.0, 5.0, -3.0));
	block.var[2][1][0][2] = (vec4(5.0, -3.0, -4.0, 6.0));
	block.var[2][1][0][3] = (vec4(-6.0, -5.0, 7.0, -6.0));
	block.var[2][1][1][0] = (vec4(7.0, -3.0, -8.0, 1.0));
	block.var[2][1][1][1] = (vec4(1.0, 2.0, 3.0, 1.0));
	block.var[2][1][1][2] = (vec4(5.0, -2.0, 2.0, -2.0));
	block.var[2][1][1][3] = (vec4(-9.0, -1.0, 2.0, -1.0));
	block.var[2][2][0][0] = (vec4(0.0, -5.0, 2.0, 2.0));
	block.var[2][2][0][1] = (vec4(4.0, 4.0, -9.0, 3.0));
	block.var[2][2][0][2] = (vec4(1.0, 0.0, 5.0, -8.0));
	block.var[2][2][0][3] = (vec4(-3.0, -3.0, 3.0, -6.0));
	block.var[2][2][1][0] = (vec4(-5.0, 9.0, 0.0, -6.0));
	block.var[2][2][1][1] = (vec4(-2.0, -4.0, 3.0, 1.0));
	block.var[2][2][1][2] = (vec4(4.0, 1.0, -3.0, 6.0));
	block.var[2][2][1][3] = (vec4(-2.0, -7.0, -7.0, 9.0));
	block.var[2][3][0][0] = (vec4(-2.0, -3.0, -9.0, 9.0));
	block.var[2][3][0][1] = (vec4(-6.0, -1.0, -3.0, 3.0));
	block.var[2][3][0][2] = (vec4(-7.0, 5.0, -6.0, 8.0));
	block.var[2][3][0][3] = (vec4(0.0, -5.0, 0.0, 4.0));
	block.var[2][3][1][0] = (vec4(-2.0, -9.0, -1.0, -2.0));
	block.var[2][3][1][1] = (vec4(2.0, -4.0, -6.0, -5.0));
	block.var[2][3][1][2] = (vec4(4.0, -4.0, 7.0, 2.0));
	block.var[2][3][1][3] = (vec4(3.0, 2.0, -2.0, -5.0));
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
layout(scalar, buffer_reference) buffer Block
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
	allOk = compare_ivec3((block[0].s[0][0].a), ivec3(-4, 9, -5)) && allOk;
	allOk = compare_vec4((block[0].s[0][0].c), vec4(2.0, -7.0, -1.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[0].s[0][1].a), ivec3(2, 4, 5)) && allOk;
	allOk = compare_vec4((block[0].s[0][1].c), vec4(-9.0, 3.0, 4.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1][0].a), ivec3(2, 9, -6)) && allOk;
	allOk = compare_vec4((block[0].s[1][0].c), vec4(5.0, 1.0, 8.0, 3.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1][1].a), ivec3(6, 7, 1)) && allOk;
	allOk = compare_vec4((block[0].s[1][1].c), vec4(-6.0, -2.0, -3.0, 7.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2][0].a), ivec3(9, -1, 9)) && allOk;
	allOk = compare_vec4((block[0].s[2][0].c), vec4(-8.0, 5.0, 3.0, -2.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2][1].a), ivec3(-6, -4, -1)) && allOk;
	allOk = compare_vec4((block[0].s[2][1].c), vec4(4.0, 2.0, -3.0, -2.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0][0].a), ivec3(-3, 0, -9)) && allOk;
	allOk = compare_vec4((block[1].s[0][0].c), vec4(-1.0, 5.0, 8.0, -3.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0][1].a), ivec3(-1, 8, 4)) && allOk;
	allOk = compare_vec4((block[1].s[0][1].c), vec4(-1.0, -4.0, 5.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1][0].a), ivec3(0, 9, -7)) && allOk;
	allOk = compare_vec4((block[1].s[1][0].c), vec4(4.0, 4.0, 1.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1][1].a), ivec3(6, -1, 3)) && allOk;
	allOk = compare_vec4((block[1].s[1][1].c), vec4(-2.0, 7.0, 9.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0][0].a), ivec3(3, -3, 8)) && allOk;
	allOk = compare_vec4((block[2].s[0][0].c), vec4(4.0, -3.0, 9.0, -7.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0][1].a), ivec3(-4, 7, -4)) && allOk;
	allOk = compare_vec4((block[2].s[0][1].c), vec4(-1.0, 9.0, -8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].v = (vec4(2.0, -1.0, -4.0, 1.0));
	block[0].s[0][0].a = (ivec3(2, -2, 8));
	block[0].s[0][0].c = (vec4(7.0, -1.0, -6.0, -4.0));
	block[0].s[0][1].a = (ivec3(-2, -9, -6));
	block[0].s[0][1].c = (vec4(9.0, 8.0, -6.0, -2.0));
	block[0].s[1][0].a = (ivec3(7, 2, -4));
	block[0].s[1][0].c = (vec4(-8.0, -2.0, 7.0, -4.0));
	block[0].s[1][1].a = (ivec3(4, 2, 2));
	block[0].s[1][1].c = (vec4(-5.0, 2.0, 8.0, 8.0));
	block[0].s[2][0].a = (ivec3(3, -4, 6));
	block[0].s[2][0].c = (vec4(-9.0, 1.0, 9.0, -5.0));
	block[0].s[2][1].a = (ivec3(-6, -5, 3));
	block[0].s[2][1].c = (vec4(-8.0, -2.0, 7.0, -9.0));
	block[1].v = (vec4(6.0, -9.0, 1.0, 7.0));
	block[1].s[0][0].a = (ivec3(7, -2, -3));
	block[1].s[0][0].c = (vec4(-1.0, 5.0, -4.0, -9.0));
	block[1].s[0][1].a = (ivec3(-5, 0, 5));
	block[1].s[0][1].c = (vec4(-4.0, 7.0, -6.0, -7.0));
	block[1].s[1][0].a = (ivec3(-4, -7, -7));
	block[1].s[1][0].c = (vec4(-7.0, -6.0, -3.0, 8.0));
	block[1].s[1][1].a = (ivec3(4, -2, -1));
	block[1].s[1][1].c = (vec4(3.0, -4.0, -3.0, 4.0));
	block[2].v = (vec4(6.0, 8.0, -5.0, -9.0));
	block[2].s[0][0].a = (ivec3(-7, -1, -4));
	block[2].s[0][0].c = (vec4(3.0, -1.0, -1.0, 3.0));
	block[2].s[0][1].a = (ivec3(-7, -6, -3));
	block[2].s[0][1].c = (vec4(2.0, 3.0, 7.0, 8.0));
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
	highp uvec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((block[0].var), uvec3(9u, 6u, 4u)) && allOk;
	allOk = compare_uvec3((block[1].var), uvec3(7u, 2u, 7u)) && allOk;
	allOk = compare_uvec3((block[2].var), uvec3(5u, 0u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (uvec3(3u, 5u, 6u));
	block[1].var = (uvec3(5u, 4u, 5u));
	block[2].var = (uvec3(4u, 9u, 4u));
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
	allOk = compare_float(block[0].var[0][0], -9.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -2.0) && allOk;
	allOk = compare_float(block[0].var[0][2], -2.0) && allOk;
	allOk = compare_float(block[0].var[0][3], -1.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -8.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -3.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -8.0) && allOk;
	allOk = compare_float(block[0].var[1][3], 8.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(-9.0, -2.0, -2.0, -1.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(-8.0, -3.0, -8.0, 8.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], -4.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 1.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 0.0) && allOk;
	allOk = compare_float(block[1].var[0][3], -7.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 3.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -6.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 9.0) && allOk;
	allOk = compare_float(block[1].var[1][3], -3.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(-4.0, 1.0, 0.0, -7.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(3.0, -6.0, 9.0, -3.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 5.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 4.0) && allOk;
	allOk = compare_float(block[2].var[0][2], -2.0) && allOk;
	allOk = compare_float(block[2].var[0][3], 4.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 2.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -4.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 5.0) && allOk;
	allOk = compare_float(block[2].var[1][3], -1.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(5.0, 4.0, -2.0, 4.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(2.0, -4.0, 5.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec4(-3.0, 4.0, -6.0, 2.0));
	block[0].var[1] = (vec4(-4.0, -6.0, -3.0, 6.0));
	block[1].var[0] = (vec4(-5.0, 1.0, 6.0, 1.0));
	block[1].var[1] = (vec4(1.0, 7.0, 0.0, 9.0));
	block[2].var[0] = (vec4(8.0, 6.0, -7.0, -4.0));
	block[2].var[1] = (vec4(-6.0, 5.0, 5.0, -6.0));
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
	allOk = compare_mat4x3(block[0].var, mat4x3(-7.0, 1.0, 0.0, 0.0, -7.0, 2.0, 5.0, 0.0, 3.0, 2.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block[1].var, mat4x3(-7.0, -5.0, 2.0, 0.0, -1.0, -5.0, 5.0, 5.0, 9.0, -7.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block[2].var, mat4x3(3.0, 6.0, -7.0, 7.0, 8.0, 6.0, -7.0, -8.0, -5.0, -9.0, -4.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat4x3(7.0, 8.0, 8.0, -3.0, -9.0, 2.0, -6.0, 0.0, -4.0, -3.0, 4.0, -8.0));
	block[1].var = (mat4x3(4.0, -2.0, 2.0, 8.0, 4.0, -1.0, -8.0, -6.0, -4.0, 9.0, -2.0, 1.0));
	block[2].var = (mat4x3(-7.0, -4.0, -4.0, -1.0, 7.0, -6.0, 4.0, 6.0, 7.0, -9.0, -8.0, 3.0));
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
	allOk = compare_mat3(block[0].var, mat3(-1.0, 2.0, -7.0, -6.0, 0.0, 4.0, -7.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3(block[1].var, mat3(-9.0, -8.0, 6.0, 6.0, 6.0, -3.0, -6.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(block[2].var, mat3(3.0, 8.0, 0.0, -4.0, -4.0, 3.0, 9.0, 9.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec3(-1.0, 1.0, 4.0));
	block[0].var[1] = (vec3(6.0, -5.0, -5.0));
	block[0].var[2] = (vec3(9.0, -6.0, 5.0));
	block[1].var[0] = (vec3(7.0, 7.0, -2.0));
	block[1].var[1] = (vec3(-4.0, 1.0, -5.0));
	block[1].var[2] = (vec3(8.0, -1.0, -8.0));
	block[2].var[0] = (vec3(-6.0, -4.0, 5.0));
	block[2].var[1] = (vec3(3.0, 9.0, -8.0));
	block[2].var[2] = (vec3(-4.0, 8.0, 0.0));
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
	allOk = compare_float(block[0].var[0][0], 3.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -9.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 7.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 0.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -1.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -8.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 0.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 3.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 0.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(3.0, -9.0, 7.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(0.0, -1.0, -8.0)) && allOk;
	allOk = compare_vec3(block[0].var[2], vec3(0.0, 3.0, 0.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 9.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 8.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -4.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -1.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 5.0) && allOk;
	allOk = compare_float(block[1].var[1][2], -5.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -9.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -6.0) && allOk;
	allOk = compare_float(block[1].var[2][2], 4.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(9.0, 8.0, -4.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(-1.0, 5.0, -5.0)) && allOk;
	allOk = compare_vec3(block[1].var[2], vec3(-9.0, -6.0, 4.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], -4.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -9.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 4.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 5.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -4.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -4.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 6.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 2.0) && allOk;
	allOk = compare_float(block[2].var[2][2], -8.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(-4.0, -9.0, 4.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(5.0, -4.0, -4.0)) && allOk;
	allOk = compare_vec3(block[2].var[2], vec3(6.0, 2.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat3(7.0, -8.0, -8.0, -4.0, -3.0, 5.0, -3.0, -3.0, -1.0));
	block[1].var = (mat3(5.0, 1.0, -3.0, 9.0, 1.0, 5.0, 0.0, 5.0, -1.0));
	block[2].var = (mat3(-7.0, 4.0, 1.0, -6.0, 3.0, 6.0, 1.0, 9.0, 3.0));
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

layout(std430, buffer_reference) buffer BlockA
{
	highp float a;
	lowp uvec3 b;
	mediump mat2 c;
};
layout(std430, buffer_reference) buffer BlockB
{
	mediump mat3 a;
	lowp ivec2 b;
	highp vec4 c;
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
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockA[0].a), -5.0) && allOk;
	allOk = compare_mat2(blockA[0].c, mat2(0.0, -9.0, 5.0, 4.0)) && allOk;
	allOk = compare_float((blockA[1].a), -3.0) && allOk;
	allOk = compare_mat2(blockA[1].c, mat2(0.0, -9.0, -6.0, -1.0)) && allOk;
	allOk = compare_float((blockA[2].a), 8.0) && allOk;
	allOk = compare_mat2(blockA[2].c, mat2(3.0, 4.0, 2.0, -4.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b), ivec2(-9, 0)) && allOk;
	allOk = compare_bool((blockB[0].d), false) && allOk;
	allOk = compare_ivec2((blockB[1].b), ivec2(-5, -2)) && allOk;
	allOk = compare_bool((blockB[1].d), false) && allOk;
	allOk = compare_ivec2((blockB[2].b), ivec2(-8, 3)) && allOk;
	allOk = compare_bool((blockB[2].d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (3.0);
	blockA[1].a = (2.0);
	blockA[2].a = (-9.0);
	blockB[0].a[0] = (vec3(3.0, 0.0, -1.0));
	blockB[0].a[1] = (vec3(-5.0, 7.0, 3.0));
	blockB[0].a[2] = (vec3(2.0, -6.0, 8.0));
	blockB[0].d = (true);
	blockB[1].a[0] = (vec3(2.0, -3.0, -7.0));
	blockB[1].a[1] = (vec3(7.0, 3.0, 8.0));
	blockB[1].a[2] = (vec3(1.0, 8.0, -1.0));
	blockB[1].d = (true);
	blockB[2].a[0] = (vec3(0.0, -6.0, -3.0));
	blockB[2].a[1] = (vec3(-3.0, 7.0, -4.0));
	blockB[2].a[2] = (vec3(5.0, -2.0, 3.0));
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

layout(scalar, buffer_reference) buffer BlockA
{
	highp float a;
	lowp uvec3 b;
	mediump mat2 c;
};
layout(scalar, buffer_reference) buffer BlockB
{
	mediump mat3 a;
	lowp ivec2 b;
	highp vec4 c;
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
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockA[0].a), -9.0) && allOk;
	allOk = compare_float(blockA[0].c[0][0], 4.0) && allOk;
	allOk = compare_float(blockA[0].c[0][1], -2.0) && allOk;
	allOk = compare_float(blockA[0].c[1][0], -6.0) && allOk;
	allOk = compare_float(blockA[0].c[1][1], -7.0) && allOk;
	allOk = compare_vec2(blockA[0].c[0], vec2(4.0, -2.0)) && allOk;
	allOk = compare_vec2(blockA[0].c[1], vec2(-6.0, -7.0)) && allOk;
	allOk = compare_float((blockA[1].a), 7.0) && allOk;
	allOk = compare_float(blockA[1].c[0][0], 4.0) && allOk;
	allOk = compare_float(blockA[1].c[0][1], -1.0) && allOk;
	allOk = compare_float(blockA[1].c[1][0], -5.0) && allOk;
	allOk = compare_float(blockA[1].c[1][1], -7.0) && allOk;
	allOk = compare_vec2(blockA[1].c[0], vec2(4.0, -1.0)) && allOk;
	allOk = compare_vec2(blockA[1].c[1], vec2(-5.0, -7.0)) && allOk;
	allOk = compare_float((blockA[2].a), 6.0) && allOk;
	allOk = compare_float(blockA[2].c[0][0], 0.0) && allOk;
	allOk = compare_float(blockA[2].c[0][1], -5.0) && allOk;
	allOk = compare_float(blockA[2].c[1][0], -7.0) && allOk;
	allOk = compare_float(blockA[2].c[1][1], -8.0) && allOk;
	allOk = compare_vec2(blockA[2].c[0], vec2(0.0, -5.0)) && allOk;
	allOk = compare_vec2(blockA[2].c[1], vec2(-7.0, -8.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b), ivec2(-8, -2)) && allOk;
	allOk = compare_bool((blockB[0].d), false) && allOk;
	allOk = compare_ivec2((blockB[1].b), ivec2(-3, 2)) && allOk;
	allOk = compare_bool((blockB[1].d), true) && allOk;
	allOk = compare_ivec2((blockB[2].b), ivec2(0, 2)) && allOk;
	allOk = compare_bool((blockB[2].d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (-7.0);
	blockA[1].a = (-5.0);
	blockA[2].a = (-9.0);
	blockB[0].a = (mat3(-5.0, 3.0, -2.0, 1.0, 2.0, 5.0, -1.0, -2.0, -6.0));
	blockB[0].d = (true);
	blockB[1].a = (mat3(5.0, -3.0, 0.0, -6.0, 1.0, 1.0, -6.0, -2.0, 7.0));
	blockB[1].d = (false);
	blockB[2].a = (mat3(-4.0, -8.0, -2.0, 3.0, -7.0, 2.0, -2.0, -8.0, 0.0));
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
layout(std140, buffer_reference) buffer BlockA
{
	highp float a;
	S b;
	lowp uvec3 c;
};
layout(std140, buffer_reference) buffer BlockB
{
	mediump mat2 a;
	T b;
	bvec4 c;
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
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockA.a), 4.0) && allOk;
	allOk = compare_uint((blockB.b.a), 0u) && allOk;
	allOk = compare_mat3(blockB.b.b.a, mat3(7.0, -4.0, -9.0, 3.0, -7.0, -7.0, -9.0, 2.0, -1.0)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[0]), ivec2(9, 0)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[1]), ivec2(5, 8)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[2]), ivec2(0, 8)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[3]), ivec2(-7, 3)) && allOk;
	allOk = compare_vec4((blockB.b.b.c), vec4(4.0, 6.0, -9.0, 1.0)) && allOk;
	allOk = compare_bvec4((blockB.b.c), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bool((blockB.d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (-6.0);
	blockA.b.a[0] = (vec3(-2.0, 3.0, 4.0));
	blockA.b.a[1] = (vec3(0.0, -1.0, -9.0));
	blockA.b.a[2] = (vec3(-8.0, 0.0, 7.0));
	blockA.b.b[0] = (ivec2(2, 7));
	blockA.b.b[1] = (ivec2(-7, 5));
	blockA.b.b[2] = (ivec2(1, -7));
	blockA.b.b[3] = (ivec2(-6, -4));
	blockA.b.c = (vec4(-5.0, 1.0, -1.0, 7.0));
	blockB.a[0] = (vec2(7.0, 1.0));
	blockB.a[1] = (vec2(-5.0, 3.0));
	blockB.b.a = (9u);
	blockB.b.b.a[0] = (vec3(9.0, -2.0, -6.0));
	blockB.b.b.a[1] = (vec3(1.0, 1.0, -5.0));
	blockB.b.b.a[2] = (vec3(-7.0, 4.0, 7.0));
	blockB.b.b.b[0] = (ivec2(-6, 2));
	blockB.b.b.b[1] = (ivec2(7, 6));
	blockB.b.b.b[2] = (ivec2(-1, -3));
	blockB.b.b.b[3] = (ivec2(7, 8));
	blockB.b.b.c = (vec4(-8.0, -1.0, -2.0, 9.0));
	blockB.b.c = (bvec4(false, true, false, true));
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

layout(std140, buffer_reference) buffer BlockB
{
	highp uint a;
	lowp float b;
	lowp uint c;
};
layout(std430, buffer_reference) buffer BlockC
{
	mediump int d;
	bool e;
	lowp float f;
	lowp uint g;
};
layout(std430, buffer_reference) buffer BlockD
{
	mediump int h[1];
	lowp float i;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockC.d), -9) && allOk;
	allOk = compare_float((blockC.f), 4.0) && allOk;
	allOk = compare_uint((blockC.g), 8u) && allOk;
	allOk = compare_int((blockD.h[0]), 0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (-9.0);
	blockB.c = (4u);
	blockC.d = (-1);
	blockC.e = (true);
	blockC.g = (8u);
	blockD.h[0] = (-5);
	blockD.i = (-9.0);
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
	lowp int a;
};
layout(std430, buffer_reference) buffer BlockC
{
	mediump uvec4 b;
	mediump ivec4 c;
};
layout(std140, buffer_reference) buffer BlockD
{
	lowp vec2 d;
	highp int e;
};
layout(std140, buffer_reference) buffer BlockE
{
	mediump vec2 f;
	highp vec2 g;
	lowp uvec2 h;
	mediump uvec4 i;
	highp uvec3 j;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.a), 4) && allOk;
	allOk = compare_uvec4((blockC.b), uvec4(0u, 3u, 0u, 8u)) && allOk;
	allOk = compare_int((blockD.e), 8) && allOk;
	allOk = compare_vec2((blockE.g), vec2(-5.0, -8.0)) && allOk;
	allOk = compare_uvec2((blockE.h), uvec2(8u, 6u)) && allOk;
	allOk = compare_uvec4((blockE.i), uvec4(9u, 9u, 7u, 3u)) && allOk;
	allOk = compare_uvec3((blockE.j), uvec3(2u, 1u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (5);
	blockC.b = (uvec4(9u, 2u, 4u, 5u));
	blockC.c = (ivec4(-2, -1, -3, -9));
	blockD.d = (vec2(-9.0, -2.0));
	blockD.e = (-4);
	blockE.f = (vec2(-4.0, 3.0));
	blockE.g = (vec2(4.0, 9.0));
	blockE.i = (uvec4(9u, 9u, 4u, 3u));
	blockE.j = (uvec3(7u, 2u, 0u));
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
	mediump mat3x2 a;
	bvec4 b;
	mediump mat3 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.a, mat3x2(4.0, -1.0, 1.0, 6.0, 1.0, 9.0)) && allOk;
	allOk = compare_bvec4((blockB.b), bvec4(true, false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x2(5.0, 7.0, -9.0, -6.0, 1.0, -2.0));
	blockB.c = (mat3(-4.0, 3.0, 4.0, 9.0, 1.0, 2.0, -6.0, 5.0, 9.0));
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
	highp mat4 a;
	mediump mat3x4 b;
	mediump mat2 c;
	mediump float d;
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	bvec2 e;
	highp ivec4 f;
	lowp ivec4 g;
	bvec4 h;
	highp uint i;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.d), -2.0) && allOk;
	allOk = compare_bvec2((blockC.e), bvec2(true, false)) && allOk;
	allOk = compare_ivec4((blockC.f), ivec4(-1, 7, 9, 1)) && allOk;
	allOk = compare_bvec4((blockC.h), bvec4(false, false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.d = (5.0);
	blockC.e = (bvec2(true, true));
	blockC.f = (ivec4(-9, -1, -1, 7));
	blockC.g = (ivec4(-1, -7, 7, 4));
	blockC.h = (bvec4(true, false, false, false));
	blockC.i = (3u);
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
	bool mA;
	lowp uvec4 mB;
	bvec2 mC;
};
struct sB
{
	mediump mat3x2 mA;
	bvec2 mB;
	highp uvec2 mC;
};
struct sC
{
	mediump ivec2 mA[3];
	bool mB;
};
struct sD
{
	sC mA;
};
struct sE
{
	bool mA;
	mediump vec3 mB[6];
	mediump mat3x2 mC;
};
struct sF
{
	sE mA;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	sA a;
	sB b;
	highp int c[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	sD d;
	sF e;
	bvec4 f[];
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	bvec3 g;
	highp mat2x3 h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a.mA), true) && allOk;
	allOk = compare_uvec4((blockB.a.mB), uvec4(0u, 6u, 4u, 4u)) && allOk;
	allOk = compare_bvec2((blockB.a.mC), bvec2(true, true)) && allOk;
	allOk = compare_mat3x2(blockB.b.mA, mat3x2(8.0, 1.0, 1.0, 6.0, 8.0, 7.0)) && allOk;
	allOk = compare_bvec2((blockB.b.mB), bvec2(true, true)) && allOk;
	allOk = compare_uvec2((blockB.b.mC), uvec2(3u, 2u)) && allOk;
	allOk = compare_int((blockB.c[0]), -1) && allOk;
	allOk = compare_int((blockB.c[1]), -9) && allOk;
	allOk = compare_ivec2((blockC.d.mA.mA[0]), ivec2(4, -5)) && allOk;
	allOk = compare_ivec2((blockC.d.mA.mA[1]), ivec2(9, -3)) && allOk;
	allOk = compare_ivec2((blockC.d.mA.mA[2]), ivec2(0, 9)) && allOk;
	allOk = compare_bool((blockC.d.mA.mB), false) && allOk;
	allOk = compare_bool((blockC.e.mA.mA), true) && allOk;
	allOk = compare_vec3((blockC.e.mA.mB[0]), vec3(1.0, -4.0, 9.0)) && allOk;
	allOk = compare_vec3((blockC.e.mA.mB[1]), vec3(-7.0, 6.0, 2.0)) && allOk;
	allOk = compare_vec3((blockC.e.mA.mB[2]), vec3(-1.0, 4.0, -3.0)) && allOk;
	allOk = compare_vec3((blockC.e.mA.mB[3]), vec3(-7.0, -3.0, -5.0)) && allOk;
	allOk = compare_vec3((blockC.e.mA.mB[4]), vec3(5.0, -2.0, 2.0)) && allOk;
	allOk = compare_vec3((blockC.e.mA.mB[5]), vec3(1.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3x2(blockC.e.mA.mC, mat3x2(-5.0, 9.0, -4.0, 1.0, -5.0, -1.0)) && allOk;
	allOk = compare_bvec4((blockC.f[0]), bvec4(false, true, false, false)) && allOk;
	allOk = compare_bvec4((blockC.f[1]), bvec4(false, false, false, true)) && allOk;
	allOk = compare_bvec4((blockC.f[2]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((blockC.f[3]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((blockC.f[4]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((blockC.f[5]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec4((blockC.f[6]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec3((blockD.g), bvec3(true, true, false)) && allOk;
	allOk = compare_mat2x3(blockD.h[0], mat2x3(1.0, -7.0, -1.0, -5.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat2x3(blockD.h[1], mat2x3(-7.0, -8.0, 7.0, -2.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(blockD.h[2], mat2x3(3.0, -1.0, 2.0, 8.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2x3(blockD.h[3], mat2x3(-6.0, 2.0, 8.0, -1.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat2x3(blockD.h[4], mat2x3(-5.0, 0.0, -5.0, -4.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x3(blockD.h[5], mat2x3(4.0, 4.0, -4.0, -2.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat2x3(blockD.h[6], mat2x3(8.0, -4.0, -3.0, 9.0, 7.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b.mA = (mat3x2(-6.0, 1.0, 5.0, 9.0, -7.0, -4.0));
	blockB.b.mB = (bvec2(true, true));
	blockB.b.mC = (uvec2(2u, 3u));
	blockC.d.mA.mA[0] = (ivec2(-9, 4));
	blockC.d.mA.mA[1] = (ivec2(-3, -3));
	blockC.d.mA.mA[2] = (ivec2(6, -2));
	blockC.d.mA.mB = (false);
	blockC.f[0] = (bvec4(false, true, false, false));
	blockC.f[1] = (bvec4(true, false, true, false));
	blockC.f[2] = (bvec4(false, false, false, false));
	blockC.f[3] = (bvec4(false, false, true, true));
	blockC.f[4] = (bvec4(true, true, true, true));
	blockC.f[5] = (bvec4(true, true, true, false));
	blockC.f[6] = (bvec4(true, false, false, false));
	blockD.g = (bvec3(false, true, true));
	blockD.h[0] = (mat2x3(-5.0, -3.0, -1.0, 4.0, 5.0, 0.0));
	blockD.h[1] = (mat2x3(-2.0, -2.0, -9.0, 0.0, 4.0, 4.0));
	blockD.h[2] = (mat2x3(-4.0, -2.0, -4.0, 4.0, 8.0, 4.0));
	blockD.h[3] = (mat2x3(-2.0, -7.0, 0.0, -6.0, 3.0, 5.0));
	blockD.h[4] = (mat2x3(-3.0, -5.0, -7.0, -8.0, -9.0, -5.0));
	blockD.h[5] = (mat2x3(-9.0, 9.0, -3.0, 4.0, 6.0, -6.0));
	blockD.h[6] = (mat2x3(-7.0, 1.0, 4.0, 5.0, 4.0, 2.0));
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
	lowp int mB;
};
struct sB
{
	mediump ivec2 mA;
	lowp uvec3 mB;
	lowp uint mC;
};
struct sC
{
	mediump ivec3 mA[3];
	mediump mat4 mB;
};
struct sD
{
	sB mA;
	sC mB;
	bvec3 mC;
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	mediump mat3 a;
	highp uvec3 b[];
};
layout(std430, buffer_reference) buffer BlockC
{
	sA c;
	lowp float d;
	highp uvec2 e;
	sD f;
	highp ivec2 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB.a, mat3(-1.0, -5.0, -9.0, -9.0, -9.0, 0.0, 8.0, -9.0, -1.0)) && allOk;
	allOk = compare_uvec3((blockB.b[0]), uvec3(0u, 4u, 5u)) && allOk;
	allOk = compare_uvec3((blockB.b[1]), uvec3(5u, 1u, 3u)) && allOk;
	allOk = compare_uvec3((blockB.b[2]), uvec3(4u, 7u, 1u)) && allOk;
	allOk = compare_uvec3((blockB.b[3]), uvec3(9u, 2u, 8u)) && allOk;
	allOk = compare_float((blockC.d), 4.0) && allOk;
	allOk = compare_uvec2((blockC.e), uvec2(3u, 6u)) && allOk;
	allOk = compare_ivec2((blockC.f.mA.mA), ivec2(-7, 4)) && allOk;
	allOk = compare_uvec3((blockC.f.mA.mB), uvec3(9u, 4u, 9u)) && allOk;
	allOk = compare_uint((blockC.f.mA.mC), 2u) && allOk;
	allOk = compare_ivec3((blockC.f.mB.mA[0]), ivec3(8, -7, -8)) && allOk;
	allOk = compare_ivec3((blockC.f.mB.mA[1]), ivec3(-9, 1, -9)) && allOk;
	allOk = compare_ivec3((blockC.f.mB.mA[2]), ivec3(1, 7, -6)) && allOk;
	allOk = compare_mat4(blockC.f.mB.mB, mat4(-6.0, -8.0, -6.0, 9.0, 4.0, 5.0, -1.0, 3.0, -1.0, 8.0, -6.0, 8.0, -9.0, -5.0, -1.0, 6.0)) && allOk;
	allOk = compare_bvec3((blockC.f.mC), bvec3(true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3(0.0, -7.0, -2.0, -6.0, 0.0, 4.0, -5.0, 5.0, -3.0));
	blockB.b[0] = (uvec3(9u, 0u, 2u));
	blockB.b[1] = (uvec3(5u, 9u, 3u));
	blockB.b[2] = (uvec3(8u, 0u, 4u));
	blockB.b[3] = (uvec3(1u, 3u, 9u));
	blockC.c.mA = (ivec2(7, -4));
	blockC.c.mB = (-2);
	blockC.d = (-4.0);
	blockC.e = (uvec2(7u, 4u));
	blockC.f.mA.mA = (ivec2(8, -4));
	blockC.f.mA.mB = (uvec3(1u, 0u, 8u));
	blockC.f.mA.mC = (5u);
	blockC.f.mB.mA[0] = (ivec3(0, -4, -2));
	blockC.f.mB.mA[1] = (ivec3(-4, 9, -1));
	blockC.f.mB.mA[2] = (ivec3(-7, 9, 3));
	blockC.f.mB.mB = (mat4(-6.0, 9.0, 0.0, 5.0, -4.0, 6.0, -8.0, 4.0, -1.0, -4.0, -6.0, 9.0, -7.0, 8.0, 3.0, -2.0));
	blockC.f.mC = (bvec3(false, false, true));
	blockC.g[0] = (ivec2(4, 2));
	blockC.g[1] = (ivec2(-5, 5));
	blockC.g[2] = (ivec2(7, 9));
	blockC.g[3] = (ivec2(1, 4));
	blockC.g[4] = (ivec2(2, 2));
	blockC.g[5] = (ivec2(-3, -7));
	blockC.g[6] = (ivec2(-2, 2));
	blockC.g[7] = (ivec2(5, 4));
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
	layout(offset = 0) mediump int a;
	layout(offset = 4) highp vec3 b;
	layout(offset = 16) mediump vec3 c;
	layout(offset = 32) highp uvec2 d;
	layout(offset = 40) bool e;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump uvec3 f;
	layout(offset = 16) bvec2 g;
	layout(offset = 24) highp ivec2 h;
	layout(offset = 32) highp vec4 i;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.a), 3) && allOk;
	allOk = compare_vec3((blockB.b), vec3(8.0, -8.0, -3.0)) && allOk;
	allOk = compare_vec3((blockB.c), vec3(-3.0, 3.0, -4.0)) && allOk;
	allOk = compare_bool((blockB.e), true) && allOk;
	allOk = compare_bvec2((blockC.g), bvec2(false, false)) && allOk;
	allOk = compare_vec4((blockC.i), vec4(4.0, 5.0, -8.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (-5);
	blockB.b = (vec3(-4.0, 8.0, -4.0));
	blockB.d = (uvec2(8u, 8u));
	blockB.e = (false);
	blockC.f = (uvec3(3u, 5u, 8u));
	blockC.g = (bvec2(true, true));
	blockC.h = (ivec2(-5, -1));
	blockC.i = (vec4(0.0, 5.0, 5.0, -8.0));
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
	mediump vec4 mA;
};
struct sB
{
	sA mA;
	highp uvec4 mB;
};
struct sC
{
	mediump uvec4 mA;
};
struct sD
{
	lowp mat3 mA;
	bvec2 mB;
	mediump mat4 mC;
};
struct sE
{
	highp mat3x4 mA;
};
struct sF
{
	lowp int mA;
	bvec4 mB;
	sD mC;
	sE mD;
};
struct sG
{
	mediump ivec3 mA;
};
layout(scalar, row_major, buffer_reference) readonly buffer BlockB
{
	highp mat4x3 a[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	lowp mat2x3 b;
	sB c;
	mediump ivec4 d;
	lowp mat4 e;
	sC f;
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	highp uint g;
	highp int h[2];
	highp vec3 i;
	mediump ivec3 j;
	sF k[];
};
layout(scalar, row_major, buffer_reference) buffer BlockE
{
	mediump mat4 l;
	mediump uvec4 m[3];
	highp mat4 n;
	sG o[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.a[0], mat4x3(-4.0, -9.0, 8.0, 6.0, 5.0, 6.0, 6.0, -4.0, -2.0, -7.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1], mat4x3(4.0, -9.0, 3.0, -6.0, -7.0, 5.0, -3.0, -5.0, 2.0, 2.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[2], mat4x3(0.0, -8.0, 5.0, -5.0, 0.0, -7.0, 0.0, 3.0, 1.0, 1.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[3], mat4x3(2.0, -3.0, -5.0, 0.0, 7.0, 6.0, 1.0, -6.0, -8.0, 8.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[4], mat4x3(3.0, -1.0, -6.0, 3.0, 3.0, 2.0, 8.0, -6.0, -4.0, 4.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[5], mat4x3(9.0, 0.0, 4.0, 5.0, -7.0, 7.0, -2.0, -8.0, -9.0, 4.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[6], mat4x3(0.0, 1.0, -5.0, 4.0, 1.0, 6.0, -7.0, -7.0, -8.0, -1.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[7], mat4x3(5.0, 4.0, 2.0, -2.0, 7.0, 0.0, -5.0, -1.0, -9.0, 9.0, -6.0, 8.0)) && allOk;
	allOk = compare_vec4((blockC.c.mA.mA), vec4(1.0, 1.0, -3.0, -4.0)) && allOk;
	allOk = compare_uvec4((blockC.c.mB), uvec4(4u, 6u, 0u, 3u)) && allOk;
	allOk = compare_mat4(blockC.e, mat4(7.0, -9.0, 7.0, -3.0, -3.0, 2.0, 4.0, -4.0, -8.0, 4.0, 1.0, -6.0, 3.0, -5.0, 2.0, -4.0)) && allOk;
	allOk = compare_int((blockD.k[0].mA), -9) && allOk;
	allOk = compare_bvec4((blockD.k[0].mB), bvec4(true, true, false, false)) && allOk;
	allOk = compare_mat3(blockD.k[0].mC.mA, mat3(-5.0, -9.0, 4.0, 7.0, -3.0, -3.0, 8.0, -5.0, 9.0)) && allOk;
	allOk = compare_bvec2((blockD.k[0].mC.mB), bvec2(true, false)) && allOk;
	allOk = compare_mat4(blockD.k[0].mC.mC, mat4(-8.0, -2.0, -2.0, 7.0, 8.0, 9.0, -3.0, 4.0, 6.0, -6.0, 8.0, -6.0, 9.0, 8.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat3x4(blockD.k[0].mD.mA, mat3x4(-1.0, -6.0, 3.0, 5.0, -2.0, 5.0, -2.0, 7.0, -6.0, 4.0, -3.0, 1.0)) && allOk;
	allOk = compare_int((blockD.k[1].mA), -4) && allOk;
	allOk = compare_bvec4((blockD.k[1].mB), bvec4(false, false, false, true)) && allOk;
	allOk = compare_mat3(blockD.k[1].mC.mA, mat3(-2.0, 3.0, -7.0, -6.0, -5.0, 6.0, 2.0, -7.0, 7.0)) && allOk;
	allOk = compare_bvec2((blockD.k[1].mC.mB), bvec2(false, true)) && allOk;
	allOk = compare_mat4(blockD.k[1].mC.mC, mat4(1.0, -4.0, -5.0, -9.0, 9.0, 8.0, 7.0, 5.0, -9.0, -9.0, -5.0, 3.0, -2.0, -2.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat3x4(blockD.k[1].mD.mA, mat3x4(-9.0, -1.0, -3.0, 0.0, -1.0, 9.0, 0.0, -8.0, 0.0, -1.0, -7.0, 5.0)) && allOk;
	allOk = compare_int((blockD.k[2].mA), 0) && allOk;
	allOk = compare_bvec4((blockD.k[2].mB), bvec4(true, false, false, false)) && allOk;
	allOk = compare_mat3(blockD.k[2].mC.mA, mat3(-2.0, -8.0, 6.0, -4.0, -8.0, -6.0, 2.0, 3.0, 0.0)) && allOk;
	allOk = compare_bvec2((blockD.k[2].mC.mB), bvec2(false, false)) && allOk;
	allOk = compare_mat4(blockD.k[2].mC.mC, mat4(7.0, 1.0, -5.0, -6.0, 1.0, -3.0, 8.0, -4.0, -2.0, 0.0, 9.0, 3.0, 8.0, -2.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat3x4(blockD.k[2].mD.mA, mat3x4(-6.0, -2.0, -3.0, 2.0, -7.0, 2.0, 8.0, 0.0, 9.0, -2.0, -5.0, 0.0)) && allOk;
	allOk = compare_uvec4((blockE[0].m[0]), uvec4(1u, 4u, 6u, 4u)) && allOk;
	allOk = compare_uvec4((blockE[0].m[1]), uvec4(0u, 9u, 3u, 4u)) && allOk;
	allOk = compare_uvec4((blockE[0].m[2]), uvec4(6u, 0u, 9u, 8u)) && allOk;
	allOk = compare_mat4(blockE[0].n, mat4(-2.0, -1.0, -3.0, 6.0, 7.0, 8.0, -1.0, -5.0, -8.0, -7.0, 4.0, 0.0, 4.0, -6.0, 8.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (mat2x3(-2.0, -2.0, -8.0, 1.0, 1.0, -6.0));
	blockC.e = (mat4(7.0, -4.0, -9.0, -5.0, 3.0, 8.0, -5.0, 5.0, 7.0, -3.0, -7.0, 2.0, -8.0, 1.0, -4.0, -1.0));
	blockC.f.mA = (uvec4(1u, 9u, 8u, 5u));
	blockD.h[0] = (-7);
	blockD.h[1] = (7);
	blockD.i = (vec3(1.0, -6.0, -3.0));
	blockD.j = (ivec3(-4, 6, -4));
	blockD.k[0].mA = (5);
	blockD.k[0].mB = (bvec4(true, true, true, true));
	blockD.k[0].mC.mA = (mat3(9.0, -6.0, 0.0, -8.0, -1.0, -7.0, 4.0, -3.0, -3.0));
	blockD.k[0].mC.mB = (bvec2(true, false));
	blockD.k[0].mC.mC = (mat4(-9.0, 8.0, -5.0, -5.0, -2.0, 7.0, -6.0, -3.0, -1.0, -6.0, -8.0, -8.0, 7.0, 0.0, 6.0, 9.0));
	blockD.k[0].mD.mA = (mat3x4(-2.0, 9.0, -8.0, -6.0, 8.0, -6.0, -5.0, 1.0, 2.0, 3.0, 3.0, 0.0));
	blockD.k[1].mA = (4);
	blockD.k[1].mB = (bvec4(false, true, true, false));
	blockD.k[1].mC.mA = (mat3(-4.0, -2.0, 8.0, 9.0, 2.0, -3.0, 7.0, 9.0, 5.0));
	blockD.k[1].mC.mB = (bvec2(false, false));
	blockD.k[1].mC.mC = (mat4(-3.0, -7.0, 5.0, 4.0, -1.0, 1.0, -6.0, 9.0, 5.0, 3.0, 8.0, 9.0, 7.0, -2.0, -9.0, 9.0));
	blockD.k[1].mD.mA = (mat3x4(7.0, 2.0, -8.0, -5.0, 0.0, 1.0, 0.0, 1.0, 9.0, 5.0, 7.0, 6.0));
	blockD.k[2].mA = (1);
	blockD.k[2].mB = (bvec4(true, false, false, true));
	blockD.k[2].mC.mA = (mat3(-7.0, -9.0, 7.0, 3.0, 5.0, 5.0, -2.0, 5.0, 7.0));
	blockD.k[2].mC.mB = (bvec2(false, false));
	blockD.k[2].mC.mC = (mat4(-1.0, 5.0, 8.0, -9.0, 1.0, -2.0, -5.0, 6.0, -4.0, 8.0, -4.0, -2.0, -5.0, 4.0, 5.0, 3.0));
	blockD.k[2].mD.mA = (mat3x4(-5.0, 4.0, -9.0, 0.0, -6.0, 9.0, -4.0, 8.0, -3.0, -4.0, 9.0, 0.0));
	blockE[0].m[0] = (uvec4(5u, 4u, 5u, 9u));
	blockE[0].m[1] = (uvec4(7u, 6u, 4u, 4u));
	blockE[0].m[2] = (uvec4(2u, 7u, 7u, 0u));
	blockE[0].n = (mat4(-1.0, 6.0, -2.0, 7.0, -5.0, -6.0, -6.0, 7.0, 5.0, 8.0, 3.0, -6.0, -9.0, 6.0, -8.0, 4.0));
	blockE[0].o[0].mA = (ivec3(-9, -9, -4));
	blockE[0].o[1].mA = (ivec3(-1, -2, 6));
	blockE[0].o[2].mA = (ivec3(9, 9, 7));
	blockE[0].o[3].mA = (ivec3(-2, -9, -1));
	blockE[0].o[4].mA = (ivec3(-8, -6, 4));
	blockE[0].o[5].mA = (ivec3(-7, 2, -2));
	blockE[0].o[6].mA = (ivec3(-6, 8, -8));
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
	bvec2 mA;
	lowp ivec4 mB;
	mediump mat2x3 mC;
};
struct sB
{
	mediump mat3 mA;
	sA mB;
	mediump mat4x2 mC;
};
layout(scalar, row_major, buffer_reference) buffer BlockB
{
	mediump uvec2 a;
	sB b;
	lowp ivec2 c[];
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	bvec3 d[];
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	bvec4 e;
	lowp mat4 f;
	mediump mat4x3 g;
	lowp ivec4 h[7];
	lowp mat4x3 i[];
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
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB.b.mA, mat3(6.0, 2.0, -8.0, 1.0, -1.0, -7.0, -7.0, -2.0, -4.0)) && allOk;
	allOk = compare_bvec2((blockB.b.mB.mA), bvec2(true, false)) && allOk;
	allOk = compare_ivec4((blockB.b.mB.mB), ivec4(4, -8, -3, -5)) && allOk;
	allOk = compare_mat2x3(blockB.b.mB.mC, mat2x3(7.0, 0.0, 4.0, -8.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(blockB.b.mC, mat4x2(7.0, 9.0, 6.0, -7.0, -5.0, -7.0, -9.0, 9.0)) && allOk;
	allOk = compare_bvec3((blockC.d[0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((blockC.d[1]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockC.d[2]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((blockC.d[3]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec4((blockD.e), bvec4(true, true, false, true)) && allOk;
	allOk = compare_mat4(blockD.f, mat4(-1.0, -6.0, 4.0, 7.0, -8.0, 2.0, 8.0, 7.0, 8.0, -8.0, -2.0, -2.0, 8.0, -5.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockD.g, mat4x3(-5.0, -1.0, 2.0, -6.0, -9.0, -8.0, 2.0, 9.0, 1.0, 5.0, 5.0, -9.0)) && allOk;
	allOk = compare_ivec4((blockD.h[0]), ivec4(3, 6, 2, -3)) && allOk;
	allOk = compare_ivec4((blockD.h[1]), ivec4(6, -2, 3, 3)) && allOk;
	allOk = compare_ivec4((blockD.h[2]), ivec4(-8, -3, 1, 4)) && allOk;
	allOk = compare_ivec4((blockD.h[3]), ivec4(0, -5, 0, -2)) && allOk;
	allOk = compare_ivec4((blockD.h[4]), ivec4(9, -4, 4, 3)) && allOk;
	allOk = compare_ivec4((blockD.h[5]), ivec4(-8, 9, -1, -3)) && allOk;
	allOk = compare_ivec4((blockD.h[6]), ivec4(9, 3, 1, -7)) && allOk;
	allOk = compare_mat4x3(blockD.i[0], mat4x3(-3.0, 2.0, -2.0, 1.0, -1.0, -9.0, -3.0, -1.0, -7.0, 4.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat4x3(blockD.i[1], mat4x3(4.0, 2.0, 0.0, -1.0, -4.0, 9.0, -8.0, -5.0, 0.0, -8.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat4x3(blockD.i[2], mat4x3(-7.0, -4.0, 8.0, 3.0, -2.0, 9.0, 2.0, -8.0, 7.0, 7.0, 9.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec2(4u, 4u));
	blockC.d[0] = (bvec3(true, false, false));
	blockC.d[1] = (bvec3(true, false, false));
	blockC.d[2] = (bvec3(true, false, true));
	blockC.d[3] = (bvec3(false, false, false));
	blockD.e = (bvec4(false, true, true, true));
	blockD.g = (mat4x3(-7.0, 7.0, -1.0, 8.0, -8.0, 1.0, -3.0, 5.0, -1.0, -4.0, 7.0, 0.0));
	blockD.i[0] = (mat4x3(8.0, -4.0, 9.0, 4.0, -5.0, -9.0, 6.0, 5.0, 4.0, -3.0, -4.0, 5.0));
	blockD.i[1] = (mat4x3(3.0, -5.0, -5.0, -2.0, -5.0, -6.0, -9.0, -8.0, 5.0, -1.0, -4.0, -5.0));
	blockD.i[2] = (mat4x3(-5.0, -6.0, 0.0, 6.0, -3.0, 9.0, 2.0, 6.0, 7.0, -5.0, 5.0, -9.0));
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
	highp mat4x3 mA;
};
struct sB
{
	highp ivec4 mA[3][6];
};
layout(scalar, row_major, buffer_reference) buffer BlockB
{
	lowp vec4 a;
	mediump mat4 b;
	mediump mat2 c;
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	lowp mat4x2 d[];
};
layout(scalar, row_major, buffer_reference) buffer BlockD
{
	sA e;
	sB f;
};
layout(scalar, column_major, buffer_reference) buffer BlockE
{
	bvec2 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[1];
    BlockD blockD;
    BlockE blockE[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.a), vec4(-4.0, -3.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat2(blockB.c, mat2(1.0, 7.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].d[0], mat4x2(9.0, -1.0, -1.0, -7.0, 0.0, 3.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].d[1], mat4x2(0.0, -7.0, -5.0, -3.0, -8.0, 3.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].d[2], mat4x2(-8.0, -3.0, 8.0, -8.0, 1.0, 7.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].d[3], mat4x2(-8.0, 6.0, 4.0, -5.0, -1.0, 1.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].d[4], mat4x2(9.0, -8.0, 6.0, 4.0, -9.0, 5.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].d[5], mat4x2(0.0, -6.0, -6.0, 3.0, -3.0, -9.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].d[6], mat4x2(-5.0, 3.0, -7.0, -7.0, -6.0, 4.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].d[7], mat4x2(4.0, 5.0, 3.0, 5.0, -5.0, 1.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat4x3(blockD.e.mA, mat4x3(0.0, 0.0, 3.0, -9.0, -1.0, 5.0, 1.0, 3.0, -6.0, 6.0, -3.0, 5.0)) && allOk;
	allOk = compare_ivec4((blockD.f.mA[0][0]), ivec4(1, 5, 6, 9)) && allOk;
	allOk = compare_ivec4((blockD.f.mA[0][1]), ivec4(-7, 5, -9, 5)) && allOk;
	allOk = compare_ivec4((blockD.f.mA[0][2]), ivec4(-1, 5, -5, -8)) && allOk;
	allOk = compare_ivec4((blockD.f.mA[0][3]), ivec4(-3, -2, -2, -1)) && allOk;
	allOk = compare_ivec4((blockD.f.mA[0][4]), ivec4(1, -8, 5, -7)) && allOk;
	allOk = compare_ivec4((blockD.f.mA[0][5]), ivec4(0, 0, 0, -1)) && allOk;
	allOk = compare_ivec4((blockD.f.mA[1][0]), ivec4(6, -5, 2, -5)) && allOk;
	allOk = compare_ivec4((blockD.f.mA[1][1]), ivec4(-3, -4, 2, 5)) && allOk;
	allOk = compare_ivec4((blockD.f.mA[1][2]), ivec4(1, 9, 8, -1)) && allOk;
	allOk = compare_ivec4((blockD.f.mA[1][3]), ivec4(0, 1, 2, 8)) && allOk;
	allOk = compare_ivec4((blockD.f.mA[1][4]), ivec4(6, 6, -3, -5)) && allOk;
	allOk = compare_ivec4((blockD.f.mA[1][5]), ivec4(7, 3, -3, 5)) && allOk;
	allOk = compare_ivec4((blockD.f.mA[2][0]), ivec4(8, -7, -3, -1)) && allOk;
	allOk = compare_ivec4((blockD.f.mA[2][1]), ivec4(4, -8, 7, 0)) && allOk;
	allOk = compare_ivec4((blockD.f.mA[2][2]), ivec4(6, 4, 3, 7)) && allOk;
	allOk = compare_ivec4((blockD.f.mA[2][3]), ivec4(-2, 9, 2, -3)) && allOk;
	allOk = compare_ivec4((blockD.f.mA[2][4]), ivec4(-9, -2, -7, -1)) && allOk;
	allOk = compare_ivec4((blockD.f.mA[2][5]), ivec4(2, -6, 5, 6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec4(2.0, 9.0, -1.0, -2.0));
	blockB.c = (mat2(9.0, 6.0, -5.0, 0.0));
	blockC[0].d[0] = (mat4x2(-7.0, -8.0, 3.0, -2.0, 9.0, -5.0, 4.0, 4.0));
	blockC[0].d[1] = (mat4x2(3.0, -2.0, -7.0, -3.0, -7.0, 6.0, -7.0, -7.0));
	blockC[0].d[2] = (mat4x2(1.0, -6.0, -3.0, 0.0, -3.0, 5.0, 3.0, -8.0));
	blockC[0].d[3] = (mat4x2(-2.0, -2.0, -6.0, 2.0, 0.0, -8.0, 1.0, 3.0));
	blockC[0].d[4] = (mat4x2(3.0, 0.0, -1.0, 1.0, 8.0, -2.0, 7.0, 1.0));
	blockC[0].d[5] = (mat4x2(3.0, -9.0, -8.0, -1.0, 1.0, 1.0, -7.0, 5.0));
	blockC[0].d[6] = (mat4x2(-8.0, -1.0, 9.0, 3.0, -7.0, -3.0, 1.0, 0.0));
	blockC[0].d[7] = (mat4x2(-3.0, -6.0, 7.0, -9.0, -4.0, 3.0, -7.0, 7.0));
	blockD.e.mA = (mat4x3(4.0, 4.0, 3.0, -4.0, 0.0, -1.0, 1.0, 5.0, -3.0, -3.0, -9.0, 8.0));
	blockD.f.mA[0][0] = (ivec4(7, 7, -3, -6));
	blockD.f.mA[0][1] = (ivec4(-6, -5, -6, -9));
	blockD.f.mA[0][2] = (ivec4(7, -3, 0, -2));
	blockD.f.mA[0][3] = (ivec4(-4, 6, 4, -3));
	blockD.f.mA[0][4] = (ivec4(-9, -9, -3, 8));
	blockD.f.mA[0][5] = (ivec4(-7, 1, 3, -6));
	blockD.f.mA[1][0] = (ivec4(5, 1, 4, -4));
	blockD.f.mA[1][1] = (ivec4(2, 3, -6, 3));
	blockD.f.mA[1][2] = (ivec4(-7, 2, 4, -8));
	blockD.f.mA[1][3] = (ivec4(-2, -3, 1, -6));
	blockD.f.mA[1][4] = (ivec4(-3, -1, -4, -5));
	blockD.f.mA[1][5] = (ivec4(-4, 9, 2, 4));
	blockD.f.mA[2][0] = (ivec4(3, 6, -6, 1));
	blockD.f.mA[2][1] = (ivec4(-4, 1, 7, -4));
	blockD.f.mA[2][2] = (ivec4(-7, 0, -9, 6));
	blockD.f.mA[2][3] = (ivec4(7, -1, 5, 4));
	blockD.f.mA[2][4] = (ivec4(5, -6, -3, -2));
	blockD.f.mA[2][5] = (ivec4(1, 1, -3, 0));
	blockE[0].g[0] = (bvec2(true, false));
	blockE[0].g[1] = (bvec2(false, true));
	blockE[1].g[0] = (bvec2(false, false));
	blockE[1].g[1] = (bvec2(false, true));
	blockE[1].g[2] = (bvec2(false, true));
	blockE[1].g[3] = (bvec2(true, false));
	blockE[1].g[4] = (bvec2(true, true));
	blockE[2].g[0] = (bvec2(true, true));
	blockE[2].g[1] = (bvec2(false, false));
	blockE[2].g[2] = (bvec2(false, true));
	blockE[2].g[3] = (bvec2(true, true));
	blockE[2].g[4] = (bvec2(false, false));
	blockE[2].g[5] = (bvec2(false, true));
	blockE[2].g[6] = (bvec2(false, true));
	blockE[2].g[7] = (bvec2(false, true));
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
	lowp vec3 a[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.a[0]), vec3(-5.0, 5.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (vec3(3.0, -4.0, 2.0));
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
	bvec2 mA;
	bvec4 mB;
	highp mat3x4 mC;
	lowp mat3 mD;
};
layout(std430, buffer_reference) buffer BlockB
{
	sA a[][8];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB.a[0][0].mA = (bvec2(true, false));
	blockB.a[0][0].mB = (bvec4(true, false, false, false));
	blockB.a[0][0].mC = (mat3x4(-5.0, 8.0, 8.0, -3.0, -1.0, 2.0, -2.0, 2.0, -1.0, 7.0, -1.0, 3.0));
	blockB.a[0][0].mD = (mat3(-5.0, -4.0, -5.0, -6.0, 7.0, -3.0, 2.0, 4.0, 3.0));
	blockB.a[0][1].mA = (bvec2(false, false));
	blockB.a[0][1].mB = (bvec4(false, false, true, true));
	blockB.a[0][1].mC = (mat3x4(-4.0, 1.0, 6.0, -8.0, -6.0, 8.0, -6.0, 7.0, 7.0, 6.0, -7.0, 1.0));
	blockB.a[0][1].mD = (mat3(-4.0, -4.0, 9.0, 7.0, -8.0, 9.0, -3.0, 6.0, -1.0));
	blockB.a[0][2].mA = (bvec2(false, true));
	blockB.a[0][2].mB = (bvec4(false, true, true, false));
	blockB.a[0][2].mC = (mat3x4(7.0, 8.0, 9.0, 1.0, 0.0, -7.0, -5.0, -1.0, -3.0, -3.0, -5.0, 3.0));
	blockB.a[0][2].mD = (mat3(-8.0, 0.0, 7.0, -7.0, -7.0, -6.0, 3.0, 8.0, 8.0));
	blockB.a[0][3].mA = (bvec2(false, true));
	blockB.a[0][3].mB = (bvec4(false, false, false, false));
	blockB.a[0][3].mC = (mat3x4(-8.0, 0.0, -9.0, 5.0, 5.0, -2.0, 6.0, -7.0, 7.0, -8.0, 6.0, 0.0));
	blockB.a[0][3].mD = (mat3(-5.0, -5.0, -7.0, -8.0, 3.0, 7.0, 8.0, -6.0, 9.0));
	blockB.a[0][4].mA = (bvec2(true, true));
	blockB.a[0][4].mB = (bvec4(false, false, false, true));
	blockB.a[0][4].mC = (mat3x4(9.0, 2.0, -3.0, -7.0, 2.0, -9.0, 2.0, 7.0, 1.0, 9.0, 5.0, -7.0));
	blockB.a[0][4].mD = (mat3(2.0, 7.0, -3.0, 0.0, -1.0, 5.0, -5.0, -9.0, 5.0));
	blockB.a[0][5].mA = (bvec2(false, false));
	blockB.a[0][5].mB = (bvec4(true, true, false, false));
	blockB.a[0][5].mC = (mat3x4(-2.0, -7.0, 0.0, -6.0, -3.0, -5.0, -1.0, 0.0, -8.0, 4.0, 0.0, 1.0));
	blockB.a[0][5].mD = (mat3(-6.0, -3.0, -5.0, -3.0, -9.0, -2.0, 5.0, -3.0, 3.0));
	blockB.a[0][6].mA = (bvec2(true, false));
	blockB.a[0][6].mB = (bvec4(false, false, true, false));
	blockB.a[0][6].mC = (mat3x4(-3.0, -4.0, 5.0, -2.0, 8.0, -7.0, -8.0, -1.0, -3.0, 8.0, -9.0, -5.0));
	blockB.a[0][6].mD = (mat3(-6.0, 7.0, -8.0, 6.0, -5.0, -5.0, -6.0, 1.0, 0.0));
	blockB.a[0][7].mA = (bvec2(false, true));
	blockB.a[0][7].mB = (bvec4(false, false, true, false));
	blockB.a[0][7].mC = (mat3x4(7.0, 6.0, -9.0, -7.0, 3.0, 8.0, -8.0, -8.0, 0.0, 3.0, -1.0, 6.0));
	blockB.a[0][7].mD = (mat3(7.0, -8.0, -1.0, -4.0, 6.0, 4.0, 6.0, -2.0, 9.0));
	blockB.a[1][0].mA = (bvec2(true, true));
	blockB.a[1][0].mB = (bvec4(false, false, false, true));
	blockB.a[1][0].mC = (mat3x4(2.0, -8.0, 9.0, -3.0, 8.0, -7.0, -9.0, -5.0, 9.0, 0.0, -7.0, 7.0));
	blockB.a[1][0].mD = (mat3(-1.0, -4.0, 9.0, 3.0, 8.0, -2.0, 5.0, 7.0, 9.0));
	blockB.a[1][1].mA = (bvec2(false, false));
	blockB.a[1][1].mB = (bvec4(false, true, true, false));
	blockB.a[1][1].mC = (mat3x4(2.0, 6.0, -1.0, 1.0, 4.0, -3.0, 5.0, -8.0, 2.0, 4.0, -7.0, 2.0));
	blockB.a[1][1].mD = (mat3(8.0, -3.0, -8.0, -2.0, -1.0, 7.0, -4.0, -3.0, -9.0));
	blockB.a[1][2].mA = (bvec2(true, true));
	blockB.a[1][2].mB = (bvec4(true, false, true, false));
	blockB.a[1][2].mC = (mat3x4(8.0, 1.0, -1.0, -6.0, 8.0, 5.0, 4.0, 5.0, -9.0, 0.0, -4.0, 1.0));
	blockB.a[1][2].mD = (mat3(-8.0, 3.0, 5.0, 7.0, 6.0, -8.0, -6.0, 6.0, -1.0));
	blockB.a[1][3].mA = (bvec2(true, true));
	blockB.a[1][3].mB = (bvec4(false, true, true, true));
	blockB.a[1][3].mC = (mat3x4(1.0, 9.0, 9.0, -2.0, -6.0, 5.0, 7.0, 7.0, 7.0, 9.0, -7.0, -7.0));
	blockB.a[1][3].mD = (mat3(3.0, -8.0, -3.0, -9.0, -6.0, -6.0, 3.0, -9.0, 7.0));
	blockB.a[1][4].mA = (bvec2(false, true));
	blockB.a[1][4].mB = (bvec4(false, true, false, false));
	blockB.a[1][4].mC = (mat3x4(4.0, 2.0, -4.0, 6.0, 9.0, 4.0, 8.0, 7.0, 4.0, 5.0, -4.0, 9.0));
	blockB.a[1][4].mD = (mat3(9.0, -1.0, -7.0, 3.0, 6.0, 4.0, -9.0, -4.0, 7.0));
	blockB.a[1][5].mA = (bvec2(false, true));
	blockB.a[1][5].mB = (bvec4(true, true, true, false));
	blockB.a[1][5].mC = (mat3x4(7.0, 2.0, -6.0, -3.0, -8.0, 4.0, 0.0, -3.0, -3.0, -8.0, 7.0, -8.0));
	blockB.a[1][5].mD = (mat3(-3.0, 5.0, -6.0, -5.0, 1.0, 2.0, -3.0, -7.0, -2.0));
	blockB.a[1][6].mA = (bvec2(false, true));
	blockB.a[1][6].mB = (bvec4(false, true, false, true));
	blockB.a[1][6].mC = (mat3x4(7.0, 3.0, 7.0, -9.0, -1.0, 0.0, 0.0, 1.0, 3.0, 0.0, 1.0, 2.0));
	blockB.a[1][6].mD = (mat3(-3.0, 1.0, 5.0, -1.0, 0.0, -1.0, -7.0, 6.0, -5.0));
	blockB.a[1][7].mA = (bvec2(true, true));
	blockB.a[1][7].mB = (bvec4(true, true, true, false));
	blockB.a[1][7].mC = (mat3x4(-1.0, 5.0, -6.0, -7.0, -8.0, -6.0, -3.0, 9.0, 3.0, -9.0, 4.0, 6.0));
	blockB.a[1][7].mD = (mat3(8.0, -2.0, 5.0, 7.0, -6.0, -9.0, 4.0, 8.0, 3.0));
	blockB.a[2][0].mA = (bvec2(true, false));
	blockB.a[2][0].mB = (bvec4(false, true, false, true));
	blockB.a[2][0].mC = (mat3x4(7.0, 3.0, -6.0, -4.0, 5.0, -1.0, -8.0, -9.0, -7.0, -4.0, -1.0, -2.0));
	blockB.a[2][0].mD = (mat3(0.0, -1.0, 1.0, -7.0, 7.0, -5.0, 7.0, 7.0, 8.0));
	blockB.a[2][1].mA = (bvec2(false, true));
	blockB.a[2][1].mB = (bvec4(false, true, true, false));
	blockB.a[2][1].mC = (mat3x4(0.0, -5.0, 7.0, 8.0, -5.0, -1.0, 4.0, 3.0, -5.0, 2.0, -8.0, 4.0));
	blockB.a[2][1].mD = (mat3(-7.0, -6.0, 3.0, -6.0, 6.0, -6.0, -9.0, 5.0, -8.0));
	blockB.a[2][2].mA = (bvec2(false, true));
	blockB.a[2][2].mB = (bvec4(false, true, true, true));
	blockB.a[2][2].mC = (mat3x4(-2.0, 9.0, -6.0, -2.0, 3.0, 2.0, -8.0, -1.0, 3.0, -7.0, -5.0, -9.0));
	blockB.a[2][2].mD = (mat3(6.0, -9.0, 5.0, 0.0, 4.0, -6.0, 4.0, -1.0, 7.0));
	blockB.a[2][3].mA = (bvec2(false, false));
	blockB.a[2][3].mB = (bvec4(false, false, true, true));
	blockB.a[2][3].mC = (mat3x4(5.0, 2.0, 3.0, -8.0, 6.0, -7.0, -2.0, 0.0, -5.0, -1.0, 3.0, 1.0));
	blockB.a[2][3].mD = (mat3(7.0, 9.0, 7.0, -2.0, -5.0, 3.0, -1.0, -7.0, -3.0));
	blockB.a[2][4].mA = (bvec2(false, true));
	blockB.a[2][4].mB = (bvec4(false, true, false, true));
	blockB.a[2][4].mC = (mat3x4(-7.0, -6.0, -1.0, 2.0, -1.0, -8.0, 2.0, -2.0, 9.0, 8.0, -9.0, 1.0));
	blockB.a[2][4].mD = (mat3(6.0, 3.0, 8.0, -4.0, 1.0, -4.0, -2.0, -6.0, 1.0));
	blockB.a[2][5].mA = (bvec2(true, true));
	blockB.a[2][5].mB = (bvec4(true, true, true, true));
	blockB.a[2][5].mC = (mat3x4(-2.0, 4.0, 5.0, 0.0, -5.0, -7.0, 2.0, -5.0, -7.0, 2.0, -7.0, 6.0));
	blockB.a[2][5].mD = (mat3(-3.0, -1.0, 7.0, 2.0, -9.0, 9.0, -2.0, -2.0, -9.0));
	blockB.a[2][6].mA = (bvec2(true, false));
	blockB.a[2][6].mB = (bvec4(true, true, false, true));
	blockB.a[2][6].mC = (mat3x4(-4.0, -2.0, 2.0, 3.0, -9.0, -8.0, -1.0, 3.0, 9.0, 3.0, 5.0, -3.0));
	blockB.a[2][6].mD = (mat3(7.0, -7.0, 9.0, -8.0, 1.0, -5.0, 0.0, -1.0, 6.0));
	blockB.a[2][7].mA = (bvec2(true, true));
	blockB.a[2][7].mB = (bvec4(true, false, false, true));
	blockB.a[2][7].mC = (mat3x4(4.0, 5.0, 5.0, 2.0, 6.0, 8.0, 7.0, 3.0, 8.0, 7.0, -5.0, -1.0));
	blockB.a[2][7].mD = (mat3(9.0, -4.0, -8.0, -4.0, 2.0, -8.0, 8.0, 8.0, 6.0));
	blockB.a[3][0].mA = (bvec2(false, true));
	blockB.a[3][0].mB = (bvec4(true, false, true, true));
	blockB.a[3][0].mC = (mat3x4(-1.0, -8.0, 5.0, -6.0, 7.0, -5.0, 8.0, -9.0, 9.0, -1.0, 1.0, -9.0));
	blockB.a[3][0].mD = (mat3(7.0, 4.0, 0.0, 5.0, -9.0, 4.0, 5.0, -6.0, 6.0));
	blockB.a[3][1].mA = (bvec2(false, true));
	blockB.a[3][1].mB = (bvec4(false, true, false, false));
	blockB.a[3][1].mC = (mat3x4(-7.0, 7.0, 8.0, -3.0, 2.0, 9.0, 7.0, 6.0, 1.0, 1.0, 9.0, 2.0));
	blockB.a[3][1].mD = (mat3(-2.0, -7.0, -4.0, -2.0, -9.0, -8.0, 5.0, 5.0, -5.0));
	blockB.a[3][2].mA = (bvec2(false, false));
	blockB.a[3][2].mB = (bvec4(false, true, false, false));
	blockB.a[3][2].mC = (mat3x4(0.0, 3.0, -8.0, 9.0, 5.0, 7.0, -2.0, 9.0, 0.0, 9.0, -7.0, 5.0));
	blockB.a[3][2].mD = (mat3(-7.0, -4.0, 7.0, 1.0, 1.0, 5.0, -4.0, -6.0, 6.0));
	blockB.a[3][3].mA = (bvec2(true, true));
	blockB.a[3][3].mB = (bvec4(false, true, true, false));
	blockB.a[3][3].mC = (mat3x4(-7.0, 2.0, -6.0, 9.0, -7.0, 3.0, -5.0, -2.0, -2.0, -8.0, -2.0, -1.0));
	blockB.a[3][3].mD = (mat3(-6.0, 7.0, -5.0, -5.0, -8.0, 7.0, -5.0, 3.0, 9.0));
	blockB.a[3][4].mA = (bvec2(false, true));
	blockB.a[3][4].mB = (bvec4(false, true, true, true));
	blockB.a[3][4].mC = (mat3x4(-9.0, 7.0, 7.0, 1.0, 8.0, 2.0, 6.0, 7.0, 9.0, -9.0, 4.0, 9.0));
	blockB.a[3][4].mD = (mat3(1.0, -2.0, 4.0, -2.0, -7.0, 0.0, 5.0, -3.0, -5.0));
	blockB.a[3][5].mA = (bvec2(true, false));
	blockB.a[3][5].mB = (bvec4(false, false, false, true));
	blockB.a[3][5].mC = (mat3x4(-4.0, 6.0, 2.0, 9.0, -6.0, 4.0, 5.0, -7.0, 8.0, -1.0, 5.0, -1.0));
	blockB.a[3][5].mD = (mat3(-4.0, -2.0, -5.0, 8.0, -1.0, -6.0, -2.0, -6.0, -3.0));
	blockB.a[3][6].mA = (bvec2(true, true));
	blockB.a[3][6].mB = (bvec4(true, true, false, true));
	blockB.a[3][6].mC = (mat3x4(6.0, -7.0, -4.0, -3.0, 7.0, 8.0, -7.0, 5.0, 6.0, 7.0, -8.0, 2.0));
	blockB.a[3][6].mD = (mat3(6.0, -3.0, -1.0, 9.0, -7.0, 2.0, 7.0, -4.0, 1.0));
	blockB.a[3][7].mA = (bvec2(true, false));
	blockB.a[3][7].mB = (bvec4(true, true, false, false));
	blockB.a[3][7].mC = (mat3x4(-8.0, -5.0, -3.0, -1.0, 6.0, 8.0, -7.0, 4.0, -5.0, -3.0, -7.0, -2.0));
	blockB.a[3][7].mD = (mat3(-2.0, 5.0, 1.0, 7.0, 3.0, -2.0, 8.0, 1.0, -1.0));
	blockB.a[4][0].mA = (bvec2(true, true));
	blockB.a[4][0].mB = (bvec4(false, true, false, false));
	blockB.a[4][0].mC = (mat3x4(4.0, -8.0, 2.0, -1.0, 3.0, 1.0, 9.0, 3.0, 4.0, 8.0, -9.0, -7.0));
	blockB.a[4][0].mD = (mat3(-1.0, 9.0, -8.0, -6.0, 3.0, -7.0, 1.0, -2.0, 6.0));
	blockB.a[4][1].mA = (bvec2(false, true));
	blockB.a[4][1].mB = (bvec4(false, true, false, true));
	blockB.a[4][1].mC = (mat3x4(3.0, 5.0, -7.0, -6.0, -4.0, -5.0, -1.0, -3.0, -2.0, -6.0, 5.0, 3.0));
	blockB.a[4][1].mD = (mat3(-7.0, -3.0, 7.0, -5.0, -1.0, 9.0, 0.0, -9.0, -4.0));
	blockB.a[4][2].mA = (bvec2(true, true));
	blockB.a[4][2].mB = (bvec4(false, false, true, true));
	blockB.a[4][2].mC = (mat3x4(-3.0, 5.0, 2.0, 7.0, -7.0, -6.0, 3.0, 1.0, 5.0, 3.0, -7.0, 5.0));
	blockB.a[4][2].mD = (mat3(4.0, -9.0, -6.0, -5.0, 6.0, -4.0, -3.0, 7.0, 1.0));
	blockB.a[4][3].mA = (bvec2(true, false));
	blockB.a[4][3].mB = (bvec4(true, false, true, false));
	blockB.a[4][3].mC = (mat3x4(8.0, -4.0, -4.0, -8.0, 7.0, 1.0, -1.0, -1.0, 6.0, 2.0, 0.0, 8.0));
	blockB.a[4][3].mD = (mat3(-1.0, -4.0, 0.0, 1.0, 1.0, 5.0, 1.0, 4.0, 2.0));
	blockB.a[4][4].mA = (bvec2(false, true));
	blockB.a[4][4].mB = (bvec4(true, true, false, true));
	blockB.a[4][4].mC = (mat3x4(8.0, -5.0, -3.0, 4.0, -1.0, -6.0, -6.0, -7.0, -3.0, -7.0, 3.0, 3.0));
	blockB.a[4][4].mD = (mat3(0.0, -3.0, -7.0, 6.0, 2.0, 9.0, 8.0, -3.0, -8.0));
	blockB.a[4][5].mA = (bvec2(false, false));
	blockB.a[4][5].mB = (bvec4(false, false, false, true));
	blockB.a[4][5].mC = (mat3x4(3.0, 0.0, -4.0, 8.0, 3.0, -6.0, 9.0, 7.0, -5.0, -4.0, 7.0, 6.0));
	blockB.a[4][5].mD = (mat3(5.0, -4.0, -6.0, 5.0, 4.0, 1.0, -2.0, -2.0, -1.0));
	blockB.a[4][6].mA = (bvec2(true, false));
	blockB.a[4][6].mB = (bvec4(true, false, true, false));
	blockB.a[4][6].mC = (mat3x4(9.0, 0.0, 2.0, 8.0, -5.0, -8.0, 0.0, -8.0, 5.0, -1.0, 6.0, 5.0));
	blockB.a[4][6].mD = (mat3(-2.0, -1.0, 6.0, 1.0, 5.0, -4.0, -6.0, 2.0, -7.0));
	blockB.a[4][7].mA = (bvec2(false, false));
	blockB.a[4][7].mB = (bvec4(false, true, false, true));
	blockB.a[4][7].mC = (mat3x4(-2.0, -5.0, 5.0, 5.0, 0.0, -8.0, 5.0, -3.0, -2.0, 2.0, -5.0, 5.0));
	blockB.a[4][7].mD = (mat3(9.0, -7.0, 7.0, 1.0, 3.0, -4.0, 4.0, -7.0, -8.0));
	blockB.a[5][0].mA = (bvec2(true, false));
	blockB.a[5][0].mB = (bvec4(true, true, true, false));
	blockB.a[5][0].mC = (mat3x4(-3.0, -7.0, -2.0, -3.0, 5.0, -5.0, 6.0, -3.0, 1.0, 4.0, -1.0, -3.0));
	blockB.a[5][0].mD = (mat3(7.0, 0.0, 1.0, 7.0, -8.0, 6.0, -7.0, -9.0, -4.0));
	blockB.a[5][1].mA = (bvec2(true, true));
	blockB.a[5][1].mB = (bvec4(true, true, false, true));
	blockB.a[5][1].mC = (mat3x4(7.0, -8.0, -9.0, 8.0, 9.0, -4.0, -1.0, -2.0, -9.0, -5.0, 5.0, -5.0));
	blockB.a[5][1].mD = (mat3(-8.0, 0.0, -3.0, 1.0, -2.0, 6.0, 0.0, 2.0, -6.0));
	blockB.a[5][2].mA = (bvec2(false, false));
	blockB.a[5][2].mB = (bvec4(false, false, false, true));
	blockB.a[5][2].mC = (mat3x4(3.0, -2.0, 6.0, -1.0, 5.0, -3.0, -5.0, 8.0, -7.0, 2.0, -8.0, 2.0));
	blockB.a[5][2].mD = (mat3(7.0, -3.0, 1.0, 3.0, 1.0, -2.0, 7.0, -7.0, 4.0));
	blockB.a[5][3].mA = (bvec2(true, true));
	blockB.a[5][3].mB = (bvec4(false, false, true, false));
	blockB.a[5][3].mC = (mat3x4(-1.0, -4.0, -4.0, -1.0, 8.0, 3.0, 2.0, 5.0, 5.0, -2.0, 3.0, -7.0));
	blockB.a[5][3].mD = (mat3(-4.0, -4.0, 0.0, 8.0, 5.0, -2.0, -8.0, 9.0, 1.0));
	blockB.a[5][4].mA = (bvec2(false, false));
	blockB.a[5][4].mB = (bvec4(true, true, false, false));
	blockB.a[5][4].mC = (mat3x4(0.0, 9.0, 0.0, 0.0, -7.0, 1.0, -6.0, 9.0, 3.0, 2.0, -7.0, -4.0));
	blockB.a[5][4].mD = (mat3(2.0, 5.0, 3.0, -5.0, 3.0, -8.0, -4.0, 0.0, 2.0));
	blockB.a[5][5].mA = (bvec2(true, false));
	blockB.a[5][5].mB = (bvec4(false, false, false, false));
	blockB.a[5][5].mC = (mat3x4(4.0, -1.0, -3.0, 8.0, 5.0, 1.0, 1.0, 3.0, 2.0, 9.0, -1.0, 3.0));
	blockB.a[5][5].mD = (mat3(-1.0, -3.0, 1.0, -2.0, -4.0, -5.0, 7.0, 7.0, 8.0));
	blockB.a[5][6].mA = (bvec2(true, false));
	blockB.a[5][6].mB = (bvec4(false, true, false, true));
	blockB.a[5][6].mC = (mat3x4(8.0, 6.0, -3.0, 8.0, 6.0, -8.0, -9.0, 5.0, 8.0, -3.0, -5.0, 6.0));
	blockB.a[5][6].mD = (mat3(3.0, 4.0, -1.0, 0.0, -1.0, -8.0, 6.0, -5.0, 1.0));
	blockB.a[5][7].mA = (bvec2(false, true));
	blockB.a[5][7].mB = (bvec4(true, true, false, true));
	blockB.a[5][7].mC = (mat3x4(-1.0, -6.0, -3.0, 1.0, 3.0, 2.0, -6.0, -1.0, 9.0, 8.0, -4.0, -8.0));
	blockB.a[5][7].mD = (mat3(-2.0, 1.0, -5.0, -8.0, 2.0, 7.0, 6.0, -1.0, 7.0));
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
	layout(offset = 0) mediump uvec4 a;
	layout(offset = 16) mediump vec2 b;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) uint16_t c;
	layout(offset = 2) float16_t d;
	layout(offset = 4) u16vec3 e;
	layout(offset = 16) highp ivec3 f;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) lowp ivec3 g;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.b), vec2(5.0, 5.0)) && allOk;
	allOk = compare_uint16_t(uint(blockC.c), 8u) && allOk;
	allOk = compare_float16_t(float(blockC.d), -5.0) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.e), uvec3(8u, 2u, 9u)) && allOk;
	allOk = compare_ivec3((blockC.f), ivec3(-6, -8, -5)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec4(8u, 3u, 1u, 4u));
	blockB.b = (vec2(-3.0, 9.0));
	blockC.c = uint16_t(2u);
	blockC.d = float16_t(2.0);
	blockC.e = u16vec3(uvec3(9u, 4u, 3u));
	blockC.f = (ivec3(2, 9, 8));
	blockD[0].g = (ivec3(5, -5, 8));
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
	layout(offset = 0) bvec4 a;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) bvec2 b;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) lowp int c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockD.c), -3) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec4(true, false, true, false));
	blockC.b = (bvec2(true, false));
	blockD.c = (5);
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
	layout(offset = 4) i16vec4 b;
	layout(offset = 16) lowp vec3 c;
	layout(offset = 32) bvec3 d;
	layout(offset = 48) lowp vec2 e;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump uvec4 f;
	layout(offset = 16) mediump ivec4 g;
	layout(offset = 32) u16vec4 h;
	layout(offset = 40) f16vec2 i;
	layout(offset = 48) f16vec4 j;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) lowp vec3 k[1];
	layout(offset = 16) bvec3 l;
	layout(offset = 32) mediump vec3 m;
	layout(offset = 44) int16_t n;
	layout(offset = 48) mediump int o;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(blockB.a), ivec2(-2, 1)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB.b), ivec4(2, -9, -3, -2)) && allOk;
	allOk = compare_bvec3((blockB.d), bvec3(false, true, true)) && allOk;
	allOk = compare_vec2((blockB.e), vec2(0.0, 1.0)) && allOk;
	allOk = compare_uvec4((blockC.f), uvec4(6u, 1u, 9u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC.h), uvec4(0u, 0u, 1u, 9u)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.i), vec2(-7.0, 9.0)) && allOk;
	allOk = compare_vec3((blockD[0].k[0]), vec3(0.0, 8.0, 5.0)) && allOk;
	allOk = compare_bvec3((blockD[0].l), bvec3(true, false, false)) && allOk;
	allOk = compare_int16_t(int(blockD[0].n), 5) && allOk;
	allOk = compare_int((blockD[0].o), 4) && allOk;
	allOk = compare_vec3((blockD[1].k[0]), vec3(-4.0, 2.0, -2.0)) && allOk;
	allOk = compare_bvec3((blockD[1].l), bvec3(false, false, true)) && allOk;
	allOk = compare_int16_t(int(blockD[1].n), 5) && allOk;
	allOk = compare_int((blockD[1].o), -5) && allOk;
	allOk = compare_vec3((blockD[2].k[0]), vec3(-4.0, 3.0, 0.0)) && allOk;
	allOk = compare_bvec3((blockD[2].l), bvec3(false, true, false)) && allOk;
	allOk = compare_int16_t(int(blockD[2].n), 1) && allOk;
	allOk = compare_int((blockD[2].o), -5) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = i16vec4(ivec4(6, 1, -5, -5));
	blockB.c = (vec3(-8.0, -7.0, -6.0));
	blockB.d = (bvec3(false, true, false));
	blockB.e = (vec2(2.0, 3.0));
	blockC.f = (uvec4(0u, 0u, 9u, 0u));
	blockC.g = (ivec4(-7, -2, 6, 8));
	blockC.h = u16vec4(uvec4(6u, 5u, 1u, 6u));
	blockC.j = f16vec4(vec4(1.0, 7.0, 3.0, 0.0));
	blockD[0].k[0] = (vec3(-6.0, 1.0, 6.0));
	blockD[0].l = (bvec3(false, false, true));
	blockD[0].m = (vec3(-6.0, -4.0, -6.0));
	blockD[1].k[0] = (vec3(-3.0, 7.0, 3.0));
	blockD[1].l = (bvec3(true, true, true));
	blockD[1].m = (vec3(-1.0, -4.0, -2.0));
	blockD[2].k[0] = (vec3(-1.0, 8.0, 0.0));
	blockD[2].l = (bvec3(true, false, false));
	blockD[2].m = (vec3(-6.0, -7.0, 5.0));
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

layout(buffer_reference) readonly buffer BlockB
{
	layout(offset = 0) i16vec2 a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(blockB.a), ivec2(1, 1)) && allOk;
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

layout(scalar, column_major, buffer_reference) buffer BlockB
{
	mediump vec3 a;
	lowp vec2 b;
	lowp mat3 c;
	highp uvec2 d[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	uint16_t e;
	i16vec4 f;
	lowp mat4x3 g;
	mediump mat4x2 h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.a), vec3(-1.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat3(blockB.c, mat3(-8.0, 2.0, -9.0, 4.0, 5.0, -7.0, 4.0, 0.0, -1.0)) && allOk;
	allOk = compare_uvec2((blockB.d[0]), uvec2(0u, 5u)) && allOk;
	allOk = compare_uvec2((blockB.d[1]), uvec2(5u, 5u)) && allOk;
	allOk = compare_uvec2((blockB.d[2]), uvec2(0u, 6u)) && allOk;
	allOk = compare_uvec2((blockB.d[3]), uvec2(2u, 5u)) && allOk;
	allOk = compare_uvec2((blockB.d[4]), uvec2(3u, 0u)) && allOk;
	allOk = compare_uvec2((blockB.d[5]), uvec2(0u, 8u)) && allOk;
	allOk = compare_uint16_t(uint(blockC.e), 3u) && allOk;
	allOk = compare_mat4x3(blockC.g, mat4x3(2.0, -2.0, -9.0, 1.0, 2.0, -3.0, 7.0, -4.0, -5.0, 3.0, -5.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec3(0.0, -7.0, 3.0));
	blockB.c = (mat3(3.0, -7.0, -7.0, 6.0, 0.0, 6.0, -9.0, -2.0, -5.0));
	blockB.d[0] = (uvec2(4u, 0u));
	blockB.d[1] = (uvec2(0u, 6u));
	blockB.d[2] = (uvec2(5u, 7u));
	blockB.d[3] = (uvec2(9u, 9u));
	blockB.d[4] = (uvec2(4u, 0u));
	blockB.d[5] = (uvec2(7u, 2u));
	blockC.e = uint16_t(8u);
	blockC.f = i16vec4(ivec4(2, -7, -3, 6));
	blockC.g = (mat4x3(3.0, 2.0, 3.0, 6.0, 8.0, 5.0, -5.0, -8.0, -3.0, -8.0, 6.0, -1.0));
	blockC.h[0] = (mat4x2(-5.0, -7.0, 0.0, 5.0, -9.0, -3.0, -1.0, 0.0));
	blockC.h[1] = (mat4x2(-3.0, 0.0, -4.0, -8.0, -2.0, 2.0, -6.0, 3.0));
	blockC.h[2] = (mat4x2(-6.0, 8.0, -7.0, 4.0, -3.0, 2.0, 0.0, 0.0));
	blockC.h[3] = (mat4x2(-3.0, 0.0, -2.0, 3.0, 6.0, -9.0, -1.0, 0.0));
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
	i8vec4 a;
	u8vec2 b;
	u8vec4 c;
	lowp mat4 d;
	mediump mat2x3 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(blockB.a), ivec4(2, 7, 4294967287, 3)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB.b), uvec2(3u, 9u)) && allOk;
	allOk = compare_mat4(blockB.d, mat4(1.0, -5.0, -2.0, 0.0, 9.0, -1.0, -9.0, -6.0, -9.0, 6.0, 1.0, -6.0, 0.0, 2.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat2x3(blockB.e[0], mat2x3(4.0, 1.0, -7.0, -5.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat2x3(blockB.e[1], mat2x3(-7.0, 5.0, -6.0, -9.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2x3(blockB.e[2], mat2x3(-5.0, 9.0, -9.0, -2.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat2x3(blockB.e[3], mat2x3(8.0, 3.0, 9.0, 7.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2x3(blockB.e[4], mat2x3(3.0, -3.0, 8.0, 1.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat2x3(blockB.e[5], mat2x3(-3.0, -3.0, 3.0, 3.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat2x3(blockB.e[6], mat2x3(1.0, 9.0, -4.0, 4.0, 8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i8vec4(ivec4(8, 9, 4294967291, 5));
	blockB.c = u8vec4(uvec4(9u, 4u, 7u, 6u));
	blockB.d = (mat4(-8.0, -2.0, 4.0, 1.0, -2.0, -8.0, -6.0, 9.0, 4.0, -5.0, 5.0, -1.0, 4.0, -7.0, 5.0, -6.0));
	blockB.e[0] = (mat2x3(4.0, -3.0, 9.0, 0.0, -8.0, 6.0));
	blockB.e[1] = (mat2x3(-8.0, -7.0, -2.0, 5.0, 1.0, 3.0));
	blockB.e[2] = (mat2x3(-3.0, -1.0, 1.0, -6.0, -5.0, -4.0));
	blockB.e[3] = (mat2x3(-2.0, 8.0, -7.0, 4.0, 0.0, 7.0));
	blockB.e[4] = (mat2x3(2.0, -4.0, 1.0, 6.0, -2.0, 5.0));
	blockB.e[5] = (mat2x3(7.0, -9.0, -4.0, 7.0, -9.0, 7.0));
	blockB.e[6] = (mat2x3(7.0, -8.0, 5.0, -2.0, -3.0, -9.0));
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

layout(std430, row_major, buffer_reference) readonly buffer BlockB
{
	lowp uvec4 a[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB[0].a[0]), uvec4(0u, 2u, 0u, 4u)) && allOk;
	allOk = compare_uvec4((blockB[1].a[0]), uvec4(4u, 0u, 9u, 3u)) && allOk;
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

layout(std430, row_major, buffer_reference) buffer BlockB
{
	lowp uvec3 a;
	bvec4 b;
	lowp uint c;
	highp vec4 d;
	bvec4 e[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	u8vec4 f;
	highp ivec2 g;
	highp mat3x2 h[];
};
layout(std430, buffer_reference) buffer BlockD
{
	u8vec2 i[];
};
layout(std430, column_major, buffer_reference) buffer BlockE
{
	highp uvec2 j;
	highp ivec4 k;
	int8_t l[1];
	mediump vec2 m[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a), uvec3(4u, 9u, 6u)) && allOk;
	allOk = compare_ivec2((blockC.g), ivec2(-9, 9)) && allOk;
	allOk = compare_mat3x2(blockC.h[0], mat3x2(8.0, -4.0, 2.0, -4.0, 4.0, 1.0)) && allOk;
	allOk = compare_uvec2((blockE.j), uvec2(1u, 6u)) && allOk;
	allOk = compare_ivec4((blockE.k), ivec4(-2, -2, 1, 7)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec3(8u, 6u, 1u));
	blockB.b = (bvec4(false, true, true, false));
	blockB.c = (5u);
	blockB.d = (vec4(-4.0, -8.0, -4.0, 8.0));
	blockC.f = u8vec4(uvec4(5u, 3u, 7u, 4u));
	blockC.h[0] = (mat3x2(9.0, 4.0, -8.0, 8.0, -6.0, -8.0));
	blockD.i[0] = u8vec2(uvec2(4u, 6u));
	blockE.j = (uvec2(0u, 8u));
	blockE.k = (ivec4(6, 1, 3, 0));
	blockE.l[0] = int8_t(4294967295);
	blockE.m[0] = (vec2(-3.0, -8.0));
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
	highp ivec3 mA;
	mediump uvec3 mB;
	i8vec3 mC;
	u8vec4 mD;
};
struct sB
{
	highp mat3x2 mA;
	sA mB;
};
layout(std140, buffer_reference) buffer BlockB
{
	bvec4 a;
	sB b;
	lowp int c;
	highp ivec4 d[];
};
layout(std430, buffer_reference) buffer BlockC
{
	highp int e[];
};
layout(std430, buffer_reference) buffer BlockD
{
	mediump mat3x4 f;
	mediump uvec3 g;
	highp mat3x2 h;
	highp mat4x2 i;
	mediump uint j[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, false, false, true)) && allOk;
	allOk = compare_mat3x2(blockB.b.mA, mat3x2(5.0, -7.0, -9.0, 8.0, -4.0, -8.0)) && allOk;
	allOk = compare_ivec3((blockB.b.mB.mA), ivec3(8, -8, -6)) && allOk;
	allOk = compare_uvec3((blockB.b.mB.mB), uvec3(9u, 4u, 9u)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.b.mB.mC), ivec3(4294967294, 1, 1)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB.b.mB.mD), uvec4(6u, 2u, 2u, 6u)) && allOk;
	allOk = compare_int((blockB.c), 8) && allOk;
	allOk = compare_ivec4((blockB.d[0]), ivec4(4, -9, 8, -6)) && allOk;
	allOk = compare_mat3x4(blockD.f, mat3x4(2.0, -5.0, 9.0, 3.0, -5.0, -3.0, 0.0, -2.0, -4.0, 4.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat3x2(blockD.h, mat3x2(-4.0, 8.0, -5.0, -4.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(blockD.i, mat4x2(0.0, -9.0, 9.0, 8.0, -5.0, 8.0, -4.0, -9.0)) && allOk;
	allOk = compare_uint((blockD.j[0]), 4u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec4(true, false, true, false));
	blockB.b.mA = (mat3x2(-8.0, 3.0, -9.0, 2.0, 6.0, 1.0));
	blockB.b.mB.mA = (ivec3(9, -5, 9));
	blockB.b.mB.mB = (uvec3(9u, 6u, 7u));
	blockB.b.mB.mC = i8vec3(ivec3(4294967287, 4294967290, 4294967295));
	blockB.b.mB.mD = u8vec4(uvec4(8u, 6u, 0u, 3u));
	blockB.c = (8);
	blockB.d[0] = (ivec4(-4, -8, -5, -1));
	blockC.e[0] = (2);
	blockD.f = (mat3x4(0.0, 5.0, 3.0, -3.0, 2.0, 4.0, 4.0, -6.0, 4.0, -5.0, -2.0, -4.0));
	blockD.i = (mat4x2(2.0, -9.0, -2.0, -7.0, 8.0, 8.0, 8.0, 7.0));
	blockD.j[0] = (5u);
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
	highp vec4 a[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.a[0]), vec4(-5.0, 5.0, -6.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (vec4(3.0, -4.0, 2.0, 2.0));
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
	i8vec4 mA[4];
	lowp mat4x3 mB;
	u8vec2 mC[4];
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	u8vec2 a;
	i8vec2 b;
	bool c;
	sA d;
};
layout(std140, buffer_reference) buffer BlockC
{
	mediump vec4 e;
	uint8_t f;
	mediump uvec2 g;
	u8vec4 h;
	i8vec2 i[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	mediump ivec3 j;
	bvec2 k;
	u8vec4 l[][6];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(blockB.b), ivec2(0, 4294967287)) && allOk;
	allOk = compare_bool((blockB.c), false) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.d.mA[0]), ivec4(4, 4294967292, 0, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.d.mA[1]), ivec4(4294967291, 1, 5, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.d.mA[2]), ivec4(4294967290, 9, 8, 3)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.d.mA[3]), ivec4(7, 5, 4294967290, 5)) && allOk;
	allOk = compare_mat4x3(blockB.d.mB, mat4x3(-9.0, -1.0, 8.0, -2.0, -5.0, -7.0, 4.0, 2.0, -4.0, -1.0, -6.0, -7.0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB.d.mC[0]), uvec2(5u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB.d.mC[1]), uvec2(8u, 6u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB.d.mC[2]), uvec2(8u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB.d.mC[3]), uvec2(0u, 9u)) && allOk;
	allOk = compare_vec4((blockC.e), vec4(5.0, -9.0, 2.0, 3.0)) && allOk;
	allOk = compare_uvec2((blockC.g), uvec2(6u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC.h), uvec4(3u, 9u, 6u, 5u)) && allOk;
	allOk = compare_ivec3((blockD[0].j), ivec3(-2, -4, -8)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[0].l[0][0]), uvec4(0u, 9u, 1u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[0].l[0][1]), uvec4(7u, 0u, 2u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[0].l[0][2]), uvec4(6u, 9u, 7u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[0].l[0][3]), uvec4(5u, 7u, 0u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[0].l[0][4]), uvec4(6u, 4u, 0u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[0].l[0][5]), uvec4(5u, 1u, 9u, 9u)) && allOk;
	allOk = compare_ivec3((blockD[1].j), ivec3(-9, -2, -4)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].l[0][0]), uvec4(8u, 7u, 2u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].l[0][1]), uvec4(7u, 8u, 5u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].l[0][2]), uvec4(4u, 5u, 7u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].l[0][3]), uvec4(4u, 9u, 9u, 3u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].l[0][4]), uvec4(1u, 6u, 3u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].l[0][5]), uvec4(6u, 6u, 2u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].l[1][0]), uvec4(9u, 4u, 5u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].l[1][1]), uvec4(9u, 9u, 2u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].l[1][2]), uvec4(2u, 7u, 0u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].l[1][3]), uvec4(3u, 1u, 3u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].l[1][4]), uvec4(7u, 6u, 6u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].l[1][5]), uvec4(2u, 0u, 9u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].l[2][0]), uvec4(6u, 3u, 8u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].l[2][1]), uvec4(4u, 5u, 3u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].l[2][2]), uvec4(2u, 9u, 1u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].l[2][3]), uvec4(0u, 0u, 0u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].l[2][4]), uvec4(1u, 5u, 7u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].l[2][5]), uvec4(8u, 1u, 3u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].l[3][0]), uvec4(7u, 7u, 7u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].l[3][1]), uvec4(3u, 9u, 9u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].l[3][2]), uvec4(3u, 9u, 5u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].l[3][3]), uvec4(2u, 6u, 6u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].l[3][4]), uvec4(2u, 9u, 5u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].l[3][5]), uvec4(6u, 1u, 9u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].l[4][0]), uvec4(8u, 3u, 0u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].l[4][1]), uvec4(1u, 9u, 0u, 3u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].l[4][2]), uvec4(0u, 0u, 7u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].l[4][3]), uvec4(1u, 2u, 7u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].l[4][4]), uvec4(3u, 2u, 7u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].l[4][5]), uvec4(9u, 7u, 1u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].l[5][0]), uvec4(3u, 2u, 6u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].l[5][1]), uvec4(0u, 0u, 8u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].l[5][2]), uvec4(6u, 9u, 2u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].l[5][3]), uvec4(5u, 8u, 4u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].l[5][4]), uvec4(4u, 6u, 7u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].l[5][5]), uvec4(5u, 1u, 0u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u8vec2(uvec2(8u, 5u));
	blockB.b = i8vec2(ivec2(4294967293, 4294967295));
	blockB.c = (true);
	blockB.d.mA[0] = i8vec4(ivec4(4294967289, 4294967290, 4294967291, 4294967287));
	blockB.d.mA[1] = i8vec4(ivec4(4, 4294967290, 2, 6));
	blockB.d.mA[2] = i8vec4(ivec4(4, 6, 4294967291, 2));
	blockB.d.mA[3] = i8vec4(ivec4(4294967287, 4294967288, 3, 6));
	blockB.d.mB = (mat4x3(-6.0, 3.0, -6.0, 5.0, 7.0, -3.0, 6.0, -8.0, 0.0, -6.0, -2.0, 7.0));
	blockB.d.mC[0] = u8vec2(uvec2(8u, 6u));
	blockB.d.mC[1] = u8vec2(uvec2(0u, 5u));
	blockB.d.mC[2] = u8vec2(uvec2(6u, 5u));
	blockB.d.mC[3] = u8vec2(uvec2(9u, 5u));
	blockC.f = uint8_t(5u);
	blockC.g = (uvec2(0u, 4u));
	blockC.h = u8vec4(uvec4(9u, 7u, 3u, 4u));
	blockC.i[0] = i8vec2(ivec2(4294967287, 4));
	blockC.i[1] = i8vec2(ivec2(4294967291, 8));
	blockC.i[2] = i8vec2(ivec2(8, 4294967293));
	blockC.i[3] = i8vec2(ivec2(4294967295, 2));
	blockC.i[4] = i8vec2(ivec2(4294967294, 2));
	blockC.i[5] = i8vec2(ivec2(4294967295, 7));
	blockC.i[6] = i8vec2(ivec2(4294967295, 3));
	blockD[0].k = (bvec2(true, true));
	blockD[0].l[0][0] = u8vec4(uvec4(5u, 6u, 6u, 4u));
	blockD[0].l[0][1] = u8vec4(uvec4(9u, 9u, 3u, 2u));
	blockD[0].l[0][2] = u8vec4(uvec4(7u, 5u, 7u, 2u));
	blockD[0].l[0][3] = u8vec4(uvec4(1u, 2u, 5u, 3u));
	blockD[0].l[0][4] = u8vec4(uvec4(3u, 5u, 9u, 8u));
	blockD[0].l[0][5] = u8vec4(uvec4(8u, 6u, 9u, 5u));
	blockD[1].k = (bvec2(false, false));
	blockD[1].l[0][0] = u8vec4(uvec4(6u, 0u, 7u, 1u));
	blockD[1].l[0][1] = u8vec4(uvec4(8u, 5u, 7u, 5u));
	blockD[1].l[0][2] = u8vec4(uvec4(5u, 0u, 7u, 4u));
	blockD[1].l[0][3] = u8vec4(uvec4(0u, 4u, 4u, 7u));
	blockD[1].l[0][4] = u8vec4(uvec4(4u, 7u, 7u, 4u));
	blockD[1].l[0][5] = u8vec4(uvec4(5u, 6u, 0u, 5u));
	blockD[1].l[1][0] = u8vec4(uvec4(1u, 9u, 7u, 0u));
	blockD[1].l[1][1] = u8vec4(uvec4(6u, 0u, 6u, 5u));
	blockD[1].l[1][2] = u8vec4(uvec4(6u, 5u, 2u, 3u));
	blockD[1].l[1][3] = u8vec4(uvec4(3u, 4u, 1u, 5u));
	blockD[1].l[1][4] = u8vec4(uvec4(0u, 1u, 9u, 8u));
	blockD[1].l[1][5] = u8vec4(uvec4(1u, 1u, 6u, 0u));
	blockD[1].l[2][0] = u8vec4(uvec4(8u, 5u, 8u, 0u));
	blockD[1].l[2][1] = u8vec4(uvec4(7u, 4u, 4u, 9u));
	blockD[1].l[2][2] = u8vec4(uvec4(1u, 8u, 4u, 7u));
	blockD[1].l[2][3] = u8vec4(uvec4(2u, 5u, 9u, 6u));
	blockD[1].l[2][4] = u8vec4(uvec4(4u, 4u, 7u, 2u));
	blockD[1].l[2][5] = u8vec4(uvec4(6u, 7u, 9u, 3u));
	blockD[1].l[3][0] = u8vec4(uvec4(3u, 6u, 7u, 7u));
	blockD[1].l[3][1] = u8vec4(uvec4(4u, 5u, 5u, 9u));
	blockD[1].l[3][2] = u8vec4(uvec4(3u, 3u, 5u, 6u));
	blockD[1].l[3][3] = u8vec4(uvec4(2u, 4u, 5u, 1u));
	blockD[1].l[3][4] = u8vec4(uvec4(2u, 8u, 7u, 1u));
	blockD[1].l[3][5] = u8vec4(uvec4(6u, 3u, 5u, 1u));
	blockD[1].l[4][0] = u8vec4(uvec4(5u, 7u, 2u, 7u));
	blockD[1].l[4][1] = u8vec4(uvec4(9u, 1u, 1u, 8u));
	blockD[1].l[4][2] = u8vec4(uvec4(5u, 2u, 9u, 2u));
	blockD[1].l[4][3] = u8vec4(uvec4(2u, 4u, 1u, 4u));
	blockD[1].l[4][4] = u8vec4(uvec4(3u, 0u, 3u, 5u));
	blockD[1].l[4][5] = u8vec4(uvec4(8u, 5u, 6u, 4u));
	blockD[1].l[5][0] = u8vec4(uvec4(9u, 0u, 5u, 7u));
	blockD[1].l[5][1] = u8vec4(uvec4(5u, 4u, 9u, 0u));
	blockD[1].l[5][2] = u8vec4(uvec4(3u, 9u, 6u, 7u));
	blockD[1].l[5][3] = u8vec4(uvec4(9u, 1u, 5u, 3u));
	blockD[1].l[5][4] = u8vec4(uvec4(9u, 9u, 8u, 0u));
	blockD[1].l[5][5] = u8vec4(uvec4(0u, 7u, 1u, 8u));
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
	highp uvec2 a[7];
	highp mat3 b;
	bvec2 c;
	lowp mat3 d;
	bvec3 e[1];
};
layout(std430, buffer_reference) buffer BlockC
{
	mediump vec3 f[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	u8vec2 g[6];
	lowp mat4x2 h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
    BlockD blockD[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(blockD[0].g[0]), uvec2(3u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD[0].g[1]), uvec2(7u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD[0].g[2]), uvec2(4u, 9u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD[0].g[3]), uvec2(9u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD[0].g[4]), uvec2(2u, 1u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD[0].g[5]), uvec2(7u, 2u)) && allOk;
	allOk = compare_mat4x2(blockD[0].h, mat4x2(5.0, -6.0, -3.0, 9.0, 3.0, -2.0, 1.0, -6.0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD[1].g[0]), uvec2(6u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD[1].g[1]), uvec2(1u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD[1].g[2]), uvec2(9u, 1u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD[1].g[3]), uvec2(9u, 9u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD[1].g[4]), uvec2(1u, 1u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD[1].g[5]), uvec2(0u, 7u)) && allOk;
	allOk = compare_mat4x2(blockD[1].h, mat4x2(-3.0, 0.0, -1.0, -4.0, 4.0, 8.0, 4.0, 7.0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD[2].g[0]), uvec2(3u, 1u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD[2].g[1]), uvec2(2u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD[2].g[2]), uvec2(6u, 1u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD[2].g[3]), uvec2(9u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD[2].g[4]), uvec2(5u, 5u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD[2].g[5]), uvec2(5u, 2u)) && allOk;
	allOk = compare_mat4x2(blockD[2].h, mat4x2(1.0, -6.0, 5.0, 7.0, -2.0, -3.0, 2.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat3(-7.0, 6.0, -5.0, -4.0, 8.0, -7.0, 4.0, -3.0, -3.0));
	blockB.c = (bvec2(true, true));
	blockB.d = (mat3(3.0, 9.0, 9.0, 5.0, 6.0, 5.0, -3.0, -9.0, 7.0));
	blockB.e[0] = (bvec3(true, true, false));
	blockC[0].f[0] = (vec3(-7.0, 1.0, -2.0));
	blockC[1].f[0] = (vec3(8.0, -2.0, 4.0));
	blockC[1].f[1] = (vec3(9.0, 4.0, 8.0));
	blockC[2].f[0] = (vec3(2.0, -4.0, 6.0));
	blockC[2].f[1] = (vec3(1.0, 3.0, -7.0));
	blockC[2].f[2] = (vec3(-3.0, 4.0, -4.0));
	blockC[2].f[3] = (vec3(-5.0, 0.0, -2.0));
	blockC[2].f[4] = (vec3(-5.0, -5.0, -5.0));
	blockC[2].f[5] = (vec3(0.0, 7.0, 7.0));
	blockD[0].h = (mat4x2(-2.0, 3.0, -7.0, -2.0, 9.0, -5.0, -4.0, 7.0));
	blockD[1].h = (mat4x2(-9.0, 7.0, -1.0, 3.0, -8.0, 1.0, -5.0, -8.0));
	blockD[2].h = (mat4x2(8.0, -4.0, 1.0, -1.0, -5.0, -1.0, 0.0, 5.0));
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
	i8vec2 a[6];
	highp uvec2 b;
	lowp mat2x3 c[][2];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.b), uvec2(6u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = i8vec2(ivec2(4294967295, 1));
	blockB.a[1] = i8vec2(ivec2(4294967295, 8));
	blockB.a[2] = i8vec2(ivec2(9, 4294967292));
	blockB.a[3] = i8vec2(ivec2(4294967294, 9));
	blockB.a[4] = i8vec2(ivec2(4294967287, 3));
	blockB.a[5] = i8vec2(ivec2(4294967288, 4294967287));
	blockB.b = (uvec2(2u, 7u));
	blockB.c[0][0] = (mat2x3(2.0, 5.0, 2.0, 4.0, 8.0, -6.0));
	blockB.c[0][1] = (mat2x3(4.0, -5.0, -7.0, -5.0, -9.0, 7.0));
	blockB.c[1][0] = (mat2x3(-8.0, -9.0, 1.0, 8.0, 1.0, 7.0));
	blockB.c[1][1] = (mat2x3(4.0, 4.0, -7.0, 5.0, 8.0, 0.0));
	blockB.c[2][0] = (mat2x3(5.0, -8.0, 1.0, 7.0, -8.0, 1.0));
	blockB.c[2][1] = (mat2x3(2.0, -9.0, -9.0, -5.0, 6.0, 0.0));
	blockB.c[3][0] = (mat2x3(1.0, -8.0, 2.0, -7.0, 4.0, -4.0));
	blockB.c[3][1] = (mat2x3(-3.0, -5.0, -6.0, -5.0, -2.0, 5.0));
	blockB.c[4][0] = (mat2x3(-5.0, -8.0, -9.0, -9.0, 2.0, 9.0));
	blockB.c[4][1] = (mat2x3(-4.0, -8.0, -5.0, -1.0, -4.0, 0.0));
	blockB.c[5][0] = (mat2x3(3.0, -4.0, -6.0, 4.0, 7.0, 6.0));
	blockB.c[5][1] = (mat2x3(-2.0, 4.0, 7.0, 0.0, 5.0, -5.0));
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
	layout(offset = 0) lowp int a;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) int8_t b;
	layout(offset = 16) bvec4 c;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) int8_t d;
	layout(offset = 1) u8vec3 e;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) bool f;
	layout(offset = 4) lowp ivec2 g;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(blockC.b), 4294967294) && allOk;
	allOk = compare_bvec4((blockC.c), bvec4(true, true, true, true)) && allOk;
	allOk = compare_int8_t(int(blockD.d), 4294967288) && allOk;
	allOk = compare_bool((blockE.f), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (-6);
	blockB[1].a = (-2);
	blockC.b = int8_t(3);
	blockD.d = int8_t(5);
	blockD.e = u8vec3(uvec3(5u, 4u, 2u));
	blockE.g = (ivec2(2, -7));
}
