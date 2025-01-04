#version 450
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
	highp vec4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((var), vec4(8.0, -4.0, -9.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (vec4(-6.0, 1.0, 5.0, 7.0));
}
#version 450
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
	lowp uvec4 var;
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((var), uvec4(2u, 4u, 5u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (uvec4(6u, 6u, 2u, 2u));
}
#version 450
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
	highp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -7.0) && allOk;
	allOk = compare_float(var[0][1], 5.0) && allOk;
	allOk = compare_float(var[0][2], 0.0) && allOk;
	allOk = compare_float(var[0][3], -8.0) && allOk;
	allOk = compare_float(var[1][0], 6.0) && allOk;
	allOk = compare_float(var[1][1], 9.0) && allOk;
	allOk = compare_float(var[1][2], -2.0) && allOk;
	allOk = compare_float(var[1][3], -2.0) && allOk;
	allOk = compare_float(var[2][0], -1.0) && allOk;
	allOk = compare_float(var[2][1], 0.0) && allOk;
	allOk = compare_float(var[2][2], 1.0) && allOk;
	allOk = compare_float(var[2][3], 4.0) && allOk;
	allOk = compare_float(var[3][0], 2.0) && allOk;
	allOk = compare_float(var[3][1], -4.0) && allOk;
	allOk = compare_float(var[3][2], -5.0) && allOk;
	allOk = compare_float(var[3][3], -2.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-7.0, 5.0, 0.0, -8.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(6.0, 9.0, -2.0, -2.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-1.0, 0.0, 1.0, 4.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(2.0, -4.0, -5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(-9.0, -7.0, -8.0, -9.0));
	var[1] = (vec4(5.0, 0.0, 3.0, -7.0));
	var[2] = (vec4(9.0, -4.0, -5.0, 2.0));
	var[3] = (vec4(-2.0, 4.0, 1.0, 9.0));
}
#version 450
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
	highp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -5.0) && allOk;
	allOk = compare_float(var[0][1], 8.0) && allOk;
	allOk = compare_float(var[0][2], -9.0) && allOk;
	allOk = compare_float(var[0][3], -1.0) && allOk;
	allOk = compare_float(var[1][0], 3.0) && allOk;
	allOk = compare_float(var[1][1], -8.0) && allOk;
	allOk = compare_float(var[1][2], -2.0) && allOk;
	allOk = compare_float(var[1][3], 4.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-5.0, 8.0, -9.0, -1.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(3.0, -8.0, -2.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(-5.0, 4.0, -1.0, -1.0));
	var[1] = (vec4(-4.0, -7.0, -4.0, -8.0));
}
#version 450
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
	allOk = compare_float(var[0][0], 4.0) && allOk;
	allOk = compare_float(var[0][1], 4.0) && allOk;
	allOk = compare_float(var[1][0], 2.0) && allOk;
	allOk = compare_float(var[1][1], 4.0) && allOk;
	allOk = compare_float(var[2][0], 6.0) && allOk;
	allOk = compare_float(var[2][1], -4.0) && allOk;
	allOk = compare_float(var[3][0], -5.0) && allOk;
	allOk = compare_float(var[3][1], 0.0) && allOk;
	allOk = compare_vec2(var[0], vec2(4.0, 4.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(2.0, 4.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(6.0, -4.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(-5.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec2(3.0, 5.0));
	var[1] = (vec2(-2.0, 7.0));
	var[2] = (vec2(-7.0, 3.0));
	var[3] = (vec2(4.0, -1.0));
}
#version 450
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
	allOk = compare_mat4x3(var, mat4x3(3.0, 8.0, -1.0, 9.0, 0.0, 0.0, 0.0, -4.0, 3.0, 0.0, 0.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(-8.0, 1.0, -9.0));
	var[1] = (vec3(8.0, 5.0, -4.0));
	var[2] = (vec3(7.0, -3.0, -3.0));
	var[3] = (vec3(2.0, -7.0, 4.0));
}
#version 450
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
	u16vec4 var;
};

bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(var), uvec4(6u, 0u, 8u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = u16vec4(uvec4(0u, 6u, 9u, 4u));
}
#version 450
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

	var[0] = (vec3(-1.0, -1.0, 4.0));
	var[1] = (vec3(-4.0, 0.0, 5.0));
	var[2] = (vec3(5.0, 5.0, -8.0));
}
#version 450
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
	allOk = compare_float(var[0][0], 2.0) && allOk;
	allOk = compare_float(var[0][1], -6.0) && allOk;
	allOk = compare_float(var[0][2], -7.0) && allOk;
	allOk = compare_float(var[1][0], 4.0) && allOk;
	allOk = compare_float(var[1][1], 1.0) && allOk;
	allOk = compare_float(var[1][2], 2.0) && allOk;
	allOk = compare_vec3(var[0], vec3(2.0, -6.0, -7.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(4.0, 1.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(9.0, 9.0, 9.0));
	var[1] = (vec3(8.0, -3.0, -5.0));
}
#version 450
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
	mediump mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -2.0) && allOk;
	allOk = compare_float(var[0][1], -8.0) && allOk;
	allOk = compare_float(var[0][2], -1.0) && allOk;
	allOk = compare_float(var[1][0], 3.0) && allOk;
	allOk = compare_float(var[1][1], 4.0) && allOk;
	allOk = compare_float(var[1][2], 5.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-2.0, -8.0, -1.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(3.0, 4.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2x3(-6.0, 8.0, -1.0, -4.0, -5.0, 4.0));
}
#version 450
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
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var, mat3x2(9.0, 4.0, 5.0, 6.0, 8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec2(4.0, 5.0));
	var[1] = (vec2(3.0, -1.0));
	var[2] = (vec2(-8.0, 3.0));
}
#version 450
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
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -7.0) && allOk;
	allOk = compare_float(var[0][1], -7.0) && allOk;
	allOk = compare_float(var[1][0], -4.0) && allOk;
	allOk = compare_float(var[1][1], -8.0) && allOk;
	allOk = compare_float(var[2][0], -8.0) && allOk;
	allOk = compare_float(var[2][1], 6.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-7.0, -7.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-4.0, -8.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-8.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec2(2.0, 4.0));
	var[1] = (vec2(8.0, 4.0));
	var[2] = (vec2(0.0, 7.0));
}
#version 450
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

	var[0] = (vec2(6.0, 0.0));
	var[1] = (vec2(-6.0, -8.0));
	var[2] = (vec2(-6.0, -7.0));
	var[3] = (vec2(-7.0, 1.0));
}
#version 450
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
	i16vec3 var;
};

bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(var), ivec3(3, 4, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = i16vec3(ivec3(6, 1, -2));
}
#version 450
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
	mediump int var;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((var), -2) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (2);
}
#version 450
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
	highp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -3.0) && allOk;
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], -5.0) && allOk;
	allOk = compare_float(var[0][2], 8.0) && allOk;
	allOk = compare_float(var[0][3], 3.0) && allOk;
	allOk = compare_float(var[1][0], -9.0) && allOk;
	allOk = compare_float(var[1][1], 2.0) && allOk;
	allOk = compare_float(var[1][2], 2.0) && allOk;
	allOk = compare_float(var[1][3], 2.0) && allOk;
	allOk = compare_vec4(var[0], vec4(1.0, -5.0, 8.0, 3.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-9.0, 2.0, 2.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-5.0);
	var[0] = (vec4(5.0, -3.0, 7.0, 4.0));
	var[1] = (vec4(-6.0, 0.0, 2.0, 7.0));
}
#version 450
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
	highp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 8.0) && allOk;
	allOk = compare_mat3x2(var, mat3x2(-5.0, 4.0, -5.0, -8.0, -6.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (3.0);
	var = (mat3x2(4.0, -6.0, -4.0, -1.0, 5.0, -3.0));
}
#version 450
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
	highp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 9.0) && allOk;
	allOk = compare_mat3x2(var, mat3x2(4.0, 5.0, 6.0, 8.0, -5.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (4.0);
	var[0] = (vec2(5.0, 3.0));
	var[1] = (vec2(-1.0, -8.0));
	var[2] = (vec2(3.0, -8.0));
}
#version 450
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
	highp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -4.0) && allOk;
	allOk = compare_float(var[0][0], -7.0) && allOk;
	allOk = compare_float(var[0][1], -3.0) && allOk;
	allOk = compare_float(var[1][0], -5.0) && allOk;
	allOk = compare_float(var[1][1], 8.0) && allOk;
	allOk = compare_float(var[2][0], 0.0) && allOk;
	allOk = compare_float(var[2][1], -7.0) && allOk;
	allOk = compare_float(var[3][0], -1.0) && allOk;
	allOk = compare_float(var[3][1], -7.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-7.0, -3.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-5.0, 8.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(0.0, -7.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(-1.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-9.0);
	var = (mat4x2(4.0, -1.0, 9.0, -3.0, 8.0, 3.0, 2.0, -5.0));
}
#version 450
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
	lowp mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_float(var[0][0], -7.0) && allOk;
	allOk = compare_float(var[0][1], -6.0) && allOk;
	allOk = compare_float(var[0][2], 9.0) && allOk;
	allOk = compare_float(var[1][0], 3.0) && allOk;
	allOk = compare_float(var[1][1], -4.0) && allOk;
	allOk = compare_float(var[1][2], 9.0) && allOk;
	allOk = compare_float(var[2][0], 6.0) && allOk;
	allOk = compare_float(var[2][1], -6.0) && allOk;
	allOk = compare_float(var[2][2], 1.0) && allOk;
	allOk = compare_float(var[3][0], 8.0) && allOk;
	allOk = compare_float(var[3][1], 1.0) && allOk;
	allOk = compare_float(var[3][2], 2.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-7.0, -6.0, 9.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(3.0, -4.0, 9.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(6.0, -6.0, 1.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(8.0, 1.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (0.0);
	var = (mat4x3(7.0, -1.0, 6.0, -7.0, 7.0, -9.0, -9.0, 4.0, 1.0, 2.0, -2.0, -1.0));
}
#version 450
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
	bvec3 var[3];
};

bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((var[0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((var[1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((var[2]), bvec3(false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (bvec3(true, true, false));
	var[1] = (bvec3(false, true, true));
	var[2] = (bvec3(false, false, false));
}
#version 450
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
	highp mat3x2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0], mat3x2(-1.0, 4.0, -9.0, -1.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(-8.0, 6.0, 3.0, 1.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(-8.0, -3.0, 3.0, -3.0, -4.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3x2(-2.0, -2.0, -8.0, 0.0, -9.0, 9.0));
	var[1] = (mat3x2(0.0, 1.0, -3.0, -6.0, -5.0, -7.0));
	var[2] = (mat3x2(5.0, -4.0, 8.0, -1.0, -8.0, 1.0));
}
#version 450
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
	highp mat3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 2.0) && allOk;
	allOk = compare_mat3(var[0], mat3(-3.0, 4.0, 5.0, -1.0, 7.0, 7.0, 0.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(-3.0, 0.0, -1.0, -5.0, 6.0, 9.0, 4.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(8.0, 3.0, -2.0, -1.0, 8.0, -2.0, 4.0, -3.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (3.0);
	var[0][0] = (vec3(2.0, 4.0, 6.0));
	var[0][1] = (vec3(2.0, -9.0, 0.0));
	var[0][2] = (vec3(-9.0, 3.0, -7.0));
	var[1][0] = (vec3(-4.0, -4.0, 5.0));
	var[1][1] = (vec3(-4.0, 1.0, -7.0));
	var[1][2] = (vec3(3.0, -3.0, 7.0));
	var[2][0] = (vec3(8.0, 2.0, 5.0));
	var[2][1] = (vec3(-9.0, 7.0, -2.0));
	var[2][2] = (vec3(9.0, -7.0, -7.0));
}
#version 450
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
	highp mat3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -1.0) && allOk;
	allOk = compare_mat3(var[0], mat3(2.0, -7.0, -6.0, 0.0, 4.0, -7.0, 4.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(-8.0, 6.0, 6.0, 6.0, -3.0, -6.0, 7.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(8.0, 0.0, -4.0, -4.0, 3.0, 9.0, 9.0, 0.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-1.0);
	var[0][0] = (vec3(1.0, 4.0, 6.0));
	var[0][1] = (vec3(-5.0, -5.0, 9.0));
	var[0][2] = (vec3(-6.0, 5.0, 7.0));
	var[1][0] = (vec3(7.0, -2.0, -4.0));
	var[1][1] = (vec3(1.0, -5.0, 8.0));
	var[1][2] = (vec3(-1.0, -8.0, -6.0));
	var[2][0] = (vec3(-4.0, 5.0, 3.0));
	var[2][1] = (vec3(9.0, -8.0, -4.0));
	var[2][2] = (vec3(8.0, 0.0, 5.0));
}
#version 450
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
	highp mat3x4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 5.0) && allOk;
	allOk = compare_mat3x4(var[0], mat3x4(5.0, 3.0, -7.0, -3.0, 7.0, -8.0, -8.0, -3.0, -7.0, -9.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(-9.0, -5.0, 2.0, 6.0, -3.0, -5.0, -9.0, -4.0, 7.0, -4.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(-3.0, -2.0, 2.0, 7.0, 5.0, -1.0, 2.0, -6.0, 1.0, 3.0, -1.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (0.0);
	var[0] = (mat3x4(5.0, -1.0, 3.0, -5.0, -9.0, -7.0, 8.0, -9.0, 2.0, -8.0, -3.0, 0.0));
	var[1] = (mat3x4(-1.0, 4.0, 7.0, 4.0, -4.0, -6.0, 0.0, -5.0, -5.0, 1.0, -9.0, -7.0));
	var[2] = (mat3x4(-7.0, 7.0, 1.0, -4.0, 7.0, -8.0, -2.0, -9.0, 5.0, -9.0, -3.0, 0.0));
}
#version 450
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
	highp mat3x4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -1.0) && allOk;
	allOk = compare_mat3x4(var[0], mat3x4(-8.0, 2.0, -9.0, 8.0, -1.0, -4.0, 9.0, -5.0, -2.0, -5.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(1.0, 4.0, -5.0, 3.0, -6.0, 9.0, -9.0, 6.0, 9.0, -2.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(5.0, 1.0, -8.0, 4.0, 7.0, 5.0, -6.0, -7.0, 8.0, -3.0, 3.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-1.0);
	var[0] = (mat3x4(-6.0, 0.0, -6.0, 9.0, -5.0, 3.0, -3.0, -2.0, 6.0, 4.0, -6.0, -9.0));
	var[1] = (mat3x4(-4.0, 2.0, -4.0, -4.0, 2.0, 1.0, 3.0, -2.0, 9.0, -2.0, 3.0, -7.0));
	var[2] = (mat3x4(-1.0, -2.0, 4.0, -1.0, 4.0, 1.0, -9.0, 5.0, 6.0, 0.0, 4.0, -9.0));
}
#version 450
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
	highp mat3x4 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0], mat3x4(5.0, -7.0, -9.0, 4.0, 5.0, 3.0, -7.0, -3.0, 7.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(-9.0, 7.0, -4.0, 5.0, -9.0, -5.0, 2.0, 6.0, -3.0, -5.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(4.0, 1.0, 3.0, -1.0, -3.0, -2.0, 2.0, 7.0, 5.0, -1.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[3], mat3x4(5.0, 1.0, -8.0, -9.0, -6.0, 4.0, 0.0, -9.0, 0.0, -1.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[4], mat3x4(-3.0, 6.0, 3.0, 0.0, -4.0, 2.0, 4.0, 3.0, -4.0, 9.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[5], mat3x4(-1.0, 6.0, 5.0, -4.0, -5.0, 7.0, -4.0, -5.0, 8.0, -9.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[6], mat3x4(2.0, 3.0, 2.0, 5.0, -4.0, -4.0, 2.0, 8.0, 5.0, -5.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[7], mat3x4(-3.0, 3.0, -2.0, 6.0, 9.0, -7.0, 8.0, 8.0, 1.0, 9.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[8], mat3x4(1.0, -2.0, 4.0, 2.0, 7.0, -2.0, -9.0, 6.0, -4.0, 0.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[9], mat3x4(6.0, -8.0, 1.0, 3.0, 2.0, -7.0, 4.0, -9.0, -7.0, 0.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[10], mat3x4(-8.0, 4.0, 3.0, 2.0, 2.0, 0.0, -5.0, -4.0, 7.0, 3.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[11], mat3x4(2.0, 0.0, -3.0, 3.0, -7.0, 7.0, -8.0, 9.0, -2.0, 5.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[12], mat3x4(-3.0, -7.0, 5.0, 2.0, -5.0, 9.0, -1.0, -1.0, 1.0, -7.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[13], mat3x4(2.0, 0.0, 8.0, -9.0, 5.0, -4.0, 5.0, -7.0, 0.0, 5.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[14], mat3x4(3.0, 6.0, -3.0, 3.0, 9.0, -1.0, -3.0, 6.0, -9.0, 9.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[15], mat3x4(-2.0, 8.0, 5.0, -9.0, 0.0, -8.0, 8.0, -8.0, 6.0, -2.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[16], mat3x4(-5.0, -3.0, 9.0, 7.0, 1.0, -1.0, -8.0, -6.0, 5.0, 0.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[17], mat3x4(5.0, -7.0, -3.0, -7.0, 3.0, 9.0, -6.0, -7.0, -4.0, 4.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[18], mat3x4(3.0, 5.0, -2.0, -6.0, -7.0, -4.0, 6.0, 5.0, -9.0, 2.0, 7.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3x4(0.0, 2.0, -8.0, -3.0, 5.0, -1.0, 3.0, -5.0, -9.0, -7.0, 8.0, -9.0));
	var[1] = (mat3x4(0.0, -5.0, 1.0, -9.0, -1.0, 4.0, 7.0, 4.0, -4.0, -6.0, 0.0, -5.0));
	var[2] = (mat3x4(-7.0, 5.0, -9.0, -3.0, -7.0, 7.0, 1.0, -4.0, 7.0, -8.0, -2.0, -9.0));
	var[3] = (mat3x4(0.0, -2.0, -8.0, -5.0, 0.0, 5.0, -2.0, -1.0, 5.0, 8.0, -3.0, 1.0));
	var[4] = (mat3x4(-1.0, 7.0, 7.0, 7.0, 2.0, -7.0, 8.0, -3.0, -8.0, -2.0, -5.0, -6.0));
	var[5] = (mat3x4(5.0, 8.0, 9.0, 8.0, 7.0, 0.0, 9.0, 7.0, -3.0, -7.0, -6.0, -5.0));
	var[6] = (mat3x4(-7.0, -8.0, -2.0, 9.0, -8.0, 3.0, 9.0, 9.0, 5.0, -8.0, -1.0, 2.0));
	var[7] = (mat3x4(1.0, 5.0, 7.0, 5.0, -4.0, -7.0, -5.0, -9.0, -1.0, 6.0, 2.0, 4.0));
	var[8] = (mat3x4(-1.0, 2.0, 3.0, -5.0, -6.0, -4.0, 4.0, -7.0, -1.0, 8.0, -9.0, 2.0));
	var[9] = (mat3x4(-2.0, 9.0, -8.0, 3.0, -5.0, 6.0, -8.0, 3.0, -8.0, 6.0, 6.0, -8.0));
	var[10] = (mat3x4(-3.0, 2.0, 8.0, 3.0, -1.0, 0.0, -7.0, 5.0, 3.0, 2.0, 9.0, -2.0));
	var[11] = (mat3x4(-7.0, -5.0, -3.0, 6.0, -7.0, -8.0, -4.0, 1.0, 0.0, 0.0, 1.0, 9.0));
	var[12] = (mat3x4(-3.0, -3.0, -1.0, -2.0, 7.0, 1.0, 7.0, 0.0, -9.0, 2.0, -2.0, -6.0));
	var[13] = (mat3x4(4.0, -5.0, -8.0, -9.0, 4.0, 2.0, -1.0, -3.0, 9.0, -6.0, -9.0, -8.0));
	var[14] = (mat3x4(7.0, 6.0, -3.0, -6.0, -1.0, 2.0, 7.0, -9.0, -3.0, -4.0, -1.0, 0.0));
	var[15] = (mat3x4(-7.0, 4.0, 3.0, -4.0, 4.0, 2.0, -4.0, -3.0, 8.0, 9.0, 9.0, 8.0));
	var[16] = (mat3x4(1.0, 2.0, 5.0, 6.0, 8.0, 4.0, 6.0, -3.0, 6.0, -7.0, 9.0, -9.0));
	var[17] = (mat3x4(-9.0, -8.0, 4.0, 0.0, -8.0, 2.0, 2.0, -2.0, -7.0, 9.0, 5.0, -9.0));
	var[18] = (mat3x4(-9.0, -9.0, 8.0, -1.0, 9.0, 2.0, -9.0, -3.0, -9.0, -1.0, 3.0, -2.0));
}
#version 450
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
	f16vec3 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(var[0]), vec3(4.0, 1.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1]), vec3(-8.0, 7.0, -5.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2]), vec3(4.0, 2.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[3]), vec3(4.0, 4.0, 5.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[4]), vec3(2.0, 1.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[5]), vec3(8.0, 2.0, -3.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[6]), vec3(1.0, -2.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[7]), vec3(-7.0, -7.0, -7.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[8]), vec3(-8.0, -2.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[9]), vec3(6.0, 6.0, -1.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[10]), vec3(-4.0, -4.0, 6.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[11]), vec3(-8.0, 6.0, 4.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[12]), vec3(-1.0, -7.0, -9.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[13]), vec3(2.0, 6.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[14]), vec3(-5.0, 1.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[15]), vec3(5.0, 4.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[16]), vec3(6.0, -7.0, -8.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[17]), vec3(6.0, -8.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[18]), vec3(8.0, 2.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = f16vec3(vec3(3.0, 3.0, 7.0));
	var[1] = f16vec3(vec3(-3.0, -5.0, -9.0));
	var[2] = f16vec3(vec3(-1.0, 0.0, 6.0));
	var[3] = f16vec3(vec3(5.0, -7.0, 2.0));
	var[4] = f16vec3(vec3(9.0, 1.0, -5.0));
	var[5] = f16vec3(vec3(-5.0, 5.0, 2.0));
	var[6] = f16vec3(vec3(-5.0, -4.0, 6.0));
	var[7] = f16vec3(vec3(-3.0, -7.0, -4.0));
	var[8] = f16vec3(vec3(-4.0, 5.0, 0.0));
	var[9] = f16vec3(vec3(-6.0, 4.0, -1.0));
	var[10] = f16vec3(vec3(-2.0, 3.0, -8.0));
	var[11] = f16vec3(vec3(-4.0, -2.0, 4.0));
	var[12] = f16vec3(vec3(6.0, 6.0, -6.0));
	var[13] = f16vec3(vec3(-3.0, 1.0, -5.0));
	var[14] = f16vec3(vec3(6.0, 9.0, 7.0));
	var[15] = f16vec3(vec3(2.0, 5.0, 3.0));
	var[16] = f16vec3(vec3(9.0, -8.0, 2.0));
	var[17] = f16vec3(vec3(-7.0, -8.0, -3.0));
	var[18] = f16vec3(vec3(2.0, -5.0, -9.0));
}
#version 450
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
	highp mat4x2 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0], mat4x2(8.0, 1.0, 9.0, 3.0, -8.0, 3.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(8.0, -6.0, -5.0, 7.0, -8.0, -2.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(9.0, 4.0, 4.0, 4.0, 3.0, -6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[3], mat4x2(3.0, -2.0, -4.0, 6.0, -1.0, 6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[4], mat4x2(-1.0, 0.0, -1.0, -3.0, 6.0, -8.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[5], mat4x2(2.0, -2.0, 9.0, -1.0, 8.0, -1.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[6], mat4x2(0.0, 7.0, 4.0, 1.0, -9.0, -2.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[7], mat4x2(8.0, 8.0, -1.0, -5.0, -4.0, 4.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[8], mat4x2(7.0, 4.0, 2.0, -2.0, -2.0, 5.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[9], mat4x2(8.0, -7.0, 6.0, -9.0, -2.0, -4.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[10], mat4x2(-4.0, 1.0, -6.0, 5.0, -7.0, -4.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[11], mat4x2(2.0, -3.0, -2.0, -6.0, 9.0, -8.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[12], mat4x2(3.0, -3.0, -9.0, 4.0, -4.0, -4.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[13], mat4x2(-1.0, -6.0, -9.0, 0.0, 2.0, -7.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[14], mat4x2(4.0, -4.0, -5.0, -5.0, 1.0, -5.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[15], mat4x2(-4.0, 2.0, -1.0, -3.0, -7.0, -8.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[16], mat4x2(4.0, 9.0, -6.0, -7.0, 1.0, 2.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[17], mat4x2(2.0, -5.0, -5.0, -2.0, 5.0, 3.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[18], mat4x2(1.0, -1.0, 1.0, -8.0, -7.0, -2.0, 3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4x2(-9.0, -8.0, -8.0, 3.0, 8.0, 7.0, 0.0, 5.0));
	var[1] = (mat4x2(5.0, 8.0, 8.0, 8.0, 6.0, -3.0, -6.0, -4.0));
	var[2] = (mat4x2(-6.0, -9.0, 1.0, -1.0, 8.0, -7.0, 5.0, -3.0));
	var[3] = (mat4x2(8.0, 7.0, 6.0, 9.0, 0.0, -1.0, 7.0, 0.0));
	var[4] = (mat4x2(1.0, 6.0, 8.0, 3.0, 9.0, 0.0, -5.0, -5.0));
	var[5] = (mat4x2(3.0, -5.0, 8.0, 2.0, -9.0, 0.0, 7.0, 6.0));
	var[6] = (mat4x2(-4.0, 4.0, -6.0, 9.0, 5.0, 8.0, -2.0, -7.0));
	var[7] = (mat4x2(8.0, -4.0, 6.0, -7.0, 8.0, -5.0, 8.0, 4.0));
	var[8] = (mat4x2(-4.0, -8.0, 4.0, 9.0, 5.0, 6.0, 9.0, 3.0));
	var[9] = (mat4x2(-5.0, 7.0, -9.0, 1.0, 1.0, -3.0, 9.0, -2.0));
	var[10] = (mat4x2(6.0, -7.0, 7.0, -9.0, 7.0, -6.0, -9.0, -4.0));
	var[11] = (mat4x2(3.0, -8.0, 2.0, -9.0, 6.0, 2.0, -6.0, 3.0));
	var[12] = (mat4x2(8.0, 9.0, 4.0, -2.0, -8.0, -5.0, -3.0, 9.0));
	var[13] = (mat4x2(9.0, -3.0, 8.0, 2.0, -9.0, 2.0, 1.0, -2.0));
	var[14] = (mat4x2(6.0, 7.0, -3.0, 4.0, 8.0, -4.0, -9.0, -6.0));
	var[15] = (mat4x2(-8.0, 1.0, 6.0, -6.0, 6.0, -2.0, -8.0, 8.0));
	var[16] = (mat4x2(0.0, 7.0, -6.0, 0.0, -7.0, 3.0, -3.0, 1.0));
	var[17] = (mat4x2(-4.0, -6.0, -8.0, -9.0, 1.0, 4.0, 2.0, -5.0));
	var[18] = (mat4x2(-4.0, 0.0, 5.0, 8.0, 4.0, -1.0, 1.0, 4.0));
}
#version 450
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
	u16vec2 var[];
};

bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(var[0]), uvec2(8u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1]), uvec2(2u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2]), uvec2(6u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[3]), uvec2(7u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[4]), uvec2(0u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[5]), uvec2(1u, 3u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[6]), uvec2(8u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[7]), uvec2(7u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[8]), uvec2(2u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[9]), uvec2(5u, 5u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[10]), uvec2(4u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[11]), uvec2(6u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[12]), uvec2(7u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[13]), uvec2(7u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[14]), uvec2(3u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[15]), uvec2(4u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[16]), uvec2(3u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[17]), uvec2(1u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[18]), uvec2(1u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = u16vec2(uvec2(8u, 0u));
	var[1] = u16vec2(uvec2(6u, 0u));
	var[2] = u16vec2(uvec2(6u, 9u));
	var[3] = u16vec2(uvec2(3u, 2u));
	var[4] = u16vec2(uvec2(9u, 2u));
	var[5] = u16vec2(uvec2(4u, 5u));
	var[6] = u16vec2(uvec2(1u, 1u));
	var[7] = u16vec2(uvec2(2u, 8u));
	var[8] = u16vec2(uvec2(1u, 5u));
	var[9] = u16vec2(uvec2(0u, 2u));
	var[10] = u16vec2(uvec2(3u, 8u));
	var[11] = u16vec2(uvec2(1u, 8u));
	var[12] = u16vec2(uvec2(7u, 0u));
	var[13] = u16vec2(uvec2(3u, 9u));
	var[14] = u16vec2(uvec2(8u, 9u));
	var[15] = u16vec2(uvec2(1u, 2u));
	var[16] = u16vec2(uvec2(5u, 7u));
	var[17] = u16vec2(uvec2(9u, 9u));
	var[18] = u16vec2(uvec2(7u, 6u));
}
#version 450
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
	highp uvec2 var[4][3];
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((var[0][0]), uvec2(6u, 0u)) && allOk;
	allOk = compare_uvec2((var[0][1]), uvec2(6u, 7u)) && allOk;
	allOk = compare_uvec2((var[0][2]), uvec2(1u, 7u)) && allOk;
	allOk = compare_uvec2((var[1][0]), uvec2(9u, 0u)) && allOk;
	allOk = compare_uvec2((var[1][1]), uvec2(6u, 9u)) && allOk;
	allOk = compare_uvec2((var[1][2]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((var[2][0]), uvec2(0u, 2u)) && allOk;
	allOk = compare_uvec2((var[2][1]), uvec2(2u, 9u)) && allOk;
	allOk = compare_uvec2((var[2][2]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((var[3][0]), uvec2(1u, 4u)) && allOk;
	allOk = compare_uvec2((var[3][1]), uvec2(7u, 1u)) && allOk;
	allOk = compare_uvec2((var[3][2]), uvec2(8u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (uvec2(6u, 1u));
	var[0][1] = (uvec2(8u, 1u));
	var[0][2] = (uvec2(7u, 4u));
	var[1][0] = (uvec2(6u, 6u));
	var[1][1] = (uvec2(5u, 8u));
	var[1][2] = (uvec2(4u, 7u));
	var[2][0] = (uvec2(8u, 4u));
	var[2][1] = (uvec2(6u, 3u));
	var[2][2] = (uvec2(6u, 0u));
	var[3][0] = (uvec2(3u, 5u));
	var[3][1] = (uvec2(2u, 4u));
	var[3][2] = (uvec2(7u, 8u));
}
#version 450
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
	highp mat3x4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0][0], mat3x4(2.0, 9.0, 7.0, -5.0, 2.0, 3.0, 6.0, 6.0, 9.0, -9.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[0][1], mat3x4(-4.0, 6.0, 9.0, 4.0, 9.0, 3.0, 2.0, -4.0, -7.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[0][2], mat3x4(3.0, -5.0, 6.0, -3.0, 3.0, 2.0, 7.0, -3.0, -7.0, 0.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[1][0], mat3x4(-9.0, 6.0, 1.0, 3.0, -1.0, 8.0, -8.0, 6.0, -4.0, 9.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[1][1], mat3x4(6.0, 2.0, 4.0, -4.0, -1.0, -1.0, 6.0, 3.0, 5.0, -7.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[1][2], mat3x4(6.0, 4.0, -9.0, 9.0, 0.0, -6.0, -5.0, 8.0, 5.0, -9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[2][0], mat3x4(8.0, 9.0, -9.0, -3.0, 9.0, -7.0, 7.0, 3.0, 7.0, -5.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[2][1], mat3x4(-7.0, 2.0, 6.0, -9.0, -3.0, -3.0, 7.0, -4.0, 6.0, -9.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[2][2], mat3x4(-3.0, -4.0, 1.0, -5.0, 9.0, -1.0, 0.0, 0.0, 1.0, 9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[3][0], mat3x4(4.0, 7.0, 7.0, -7.0, -1.0, 1.0, 0.0, 6.0, 5.0, -6.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[3][1], mat3x4(9.0, -4.0, 1.0, -5.0, 8.0, -9.0, -6.0, 4.0, 2.0, -7.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[3][2], mat3x4(-7.0, -3.0, -6.0, 4.0, 5.0, -8.0, -6.0, 9.0, -3.0, 9.0, -2.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec4(8.0, 8.0, -2.0, 8.0));
	var[0][0][1] = (vec4(8.0, 3.0, 5.0, -5.0));
	var[0][0][2] = (vec4(7.0, 6.0, -9.0, 3.0));
	var[0][1][0] = (vec4(0.0, -3.0, 1.0, -9.0));
	var[0][1][1] = (vec4(-9.0, -6.0, -5.0, 1.0));
	var[0][1][2] = (vec4(9.0, 0.0, -9.0, -2.0));
	var[0][2][0] = (vec4(-4.0, -3.0, -1.0, -6.0));
	var[0][2][1] = (vec4(1.0, -2.0, -2.0, -1.0));
	var[0][2][2] = (vec4(-7.0, 8.0, 0.0, -6.0));
	var[1][0][0] = (vec4(-1.0, 7.0, -6.0, -1.0));
	var[1][0][1] = (vec4(-7.0, -8.0, 7.0, -8.0));
	var[1][0][2] = (vec4(6.0, -8.0, 2.0, -5.0));
	var[1][1][0] = (vec4(9.0, -7.0, 4.0, -1.0));
	var[1][1][1] = (vec4(-3.0, -8.0, -1.0, 1.0));
	var[1][1][2] = (vec4(-6.0, -4.0, -8.0, 4.0));
	var[1][2][0] = (vec4(5.0, 0.0, -6.0, 5.0));
	var[1][2][1] = (vec4(-1.0, 4.0, 3.0, -6.0));
	var[1][2][2] = (vec4(1.0, 8.0, -2.0, 3.0));
	var[2][0][0] = (vec4(-1.0, -9.0, 4.0, 9.0));
	var[2][0][1] = (vec4(0.0, 2.0, -7.0, -7.0));
	var[2][0][2] = (vec4(-1.0, 8.0, -9.0, -3.0));
	var[2][1][0] = (vec4(5.0, 7.0, -8.0, 1.0));
	var[2][1][1] = (vec4(-5.0, 0.0, -7.0, -3.0));
	var[2][1][2] = (vec4(-5.0, -4.0, 3.0, -5.0));
	var[2][2][0] = (vec4(4.0, 5.0, -9.0, -6.0));
	var[2][2][1] = (vec4(5.0, 3.0, -6.0, -7.0));
	var[2][2][2] = (vec4(-3.0, 9.0, 3.0, -7.0));
	var[3][0][0] = (vec4(-9.0, -9.0, 6.0, -9.0));
	var[3][0][1] = (vec4(6.0, -1.0, -1.0, -4.0));
	var[3][0][2] = (vec4(5.0, 2.0, -6.0, 8.0));
	var[3][1][0] = (vec4(4.0, 2.0, 4.0, -3.0));
	var[3][1][1] = (vec4(9.0, 8.0, 5.0, -3.0));
	var[3][1][2] = (vec4(7.0, -4.0, 6.0, 4.0));
	var[3][2][0] = (vec4(0.0, -2.0, 1.0, 8.0));
	var[3][2][1] = (vec4(1.0, 4.0, 6.0, 4.0));
	var[3][2][2] = (vec4(-2.0, 9.0, 9.0, 7.0));
}
#version 450
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
	allOk = compare_mat2x3(var[0][0], mat2x3(1.0, -3.0, 8.0, -6.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[0][1], mat2x3(4.0, -9.0, -8.0, -2.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[0][2], mat2x3(-7.0, -2.0, 0.0, -6.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[1][0], mat2x3(0.0, -5.0, -8.0, -2.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[1][1], mat2x3(8.0, 5.0, -3.0, -8.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[1][2], mat2x3(-6.0, -2.0, 1.0, -3.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[2][0], mat2x3(1.0, 7.0, 8.0, -2.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[2][1], mat2x3(-8.0, -9.0, -2.0, 7.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[2][2], mat2x3(-5.0, -5.0, 6.0, 2.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[3][0], mat2x3(7.0, 0.0, 2.0, 4.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[3][1], mat2x3(4.0, -9.0, 5.0, 3.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[3][2], mat2x3(1.0, 5.0, -6.0, 4.0, 1.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec3(-7.0, -8.0, 7.0));
	var[0][0][1] = (vec3(-6.0, -3.0, -4.0));
	var[0][1][0] = (vec3(3.0, -8.0, -9.0));
	var[0][1][1] = (vec3(-2.0, 5.0, 6.0));
	var[0][2][0] = (vec3(6.0, -5.0, -7.0));
	var[0][2][1] = (vec3(1.0, 1.0, -3.0));
	var[1][0][0] = (vec3(9.0, -7.0, 2.0));
	var[1][0][1] = (vec3(5.0, -4.0, 6.0));
	var[1][1][0] = (vec3(-3.0, -8.0, 6.0));
	var[1][1][1] = (vec3(8.0, 2.0, 4.0));
	var[1][2][0] = (vec3(0.0, 8.0, 0.0));
	var[1][2][1] = (vec3(-2.0, 1.0, -3.0));
	var[2][0][0] = (vec3(-6.0, 3.0, 9.0));
	var[2][0][1] = (vec3(3.0, -2.0, -9.0));
	var[2][1][0] = (vec3(-7.0, -8.0, -6.0));
	var[2][1][1] = (vec3(-7.0, 2.0, -3.0));
	var[2][2][0] = (vec3(1.0, -1.0, 8.0));
	var[2][2][1] = (vec3(7.0, -2.0, -6.0));
	var[3][0][0] = (vec3(-1.0, -1.0, -5.0));
	var[3][0][1] = (vec3(-1.0, 1.0, -1.0));
	var[3][1][0] = (vec3(5.0, 5.0, -6.0));
	var[3][1][1] = (vec3(6.0, 7.0, -2.0));
	var[3][2][0] = (vec3(-5.0, -7.0, -1.0));
	var[3][2][1] = (vec3(4.0, -3.0, -7.0));
}
#version 450
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
	highp mat2x4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0][0], mat2x4(-2.0, 4.0, 3.0, 6.0, 3.0, -7.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[0][1], mat2x4(6.0, 4.0, 0.0, 9.0, -2.0, 9.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[0][2], mat2x4(1.0, -7.0, 0.0, 6.0, -6.0, 9.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[1][0], mat2x4(9.0, -9.0, 3.0, -1.0, -8.0, -5.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[1][1], mat2x4(6.0, -4.0, -5.0, -3.0, -7.0, 1.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[1][2], mat2x4(0.0, -5.0, 1.0, 2.0, 7.0, 2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[2][0], mat2x4(-9.0, -1.0, 5.0, -7.0, -9.0, -6.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[2][1], mat2x4(1.0, 2.0, -6.0, 1.0, -5.0, 3.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[2][2], mat2x4(-8.0, 1.0, -5.0, 0.0, 7.0, 5.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[3][0], mat2x4(-7.0, -6.0, 2.0, 4.0, -8.0, 4.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[3][1], mat2x4(-5.0, -2.0, -6.0, -2.0, -6.0, 1.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[3][2], mat2x4(2.0, -3.0, -2.0, 4.0, 6.0, -7.0, 6.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat2x4(-5.0, -7.0, -7.0, 0.0, -1.0, -9.0, 5.0, -5.0));
	var[0][1] = (mat2x4(0.0, 1.0, 8.0, 9.0, 2.0, 4.0, 5.0, 5.0));
	var[0][2] = (mat2x4(3.0, 6.0, 2.0, 7.0, -1.0, -8.0, 7.0, -7.0));
	var[1][0] = (mat2x4(-8.0, -9.0, 5.0, -5.0, 5.0, -9.0, -7.0, -2.0));
	var[1][1] = (mat2x4(-5.0, 8.0, -8.0, -8.0, 5.0, 4.0, -2.0, -7.0));
	var[1][2] = (mat2x4(-6.0, -7.0, 4.0, -6.0, 9.0, 7.0, 1.0, 7.0));
	var[2][0] = (mat2x4(0.0, -6.0, -6.0, 6.0, -1.0, 8.0, 4.0, 1.0));
	var[2][1] = (mat2x4(-5.0, 4.0, -3.0, 3.0, 1.0, -9.0, -1.0, -2.0));
	var[2][2] = (mat2x4(-4.0, -7.0, -9.0, 5.0, -3.0, -7.0, 8.0, 3.0));
	var[3][0] = (mat2x4(-1.0, 7.0, 6.0, -6.0, -8.0, -8.0, -4.0, 6.0));
	var[3][1] = (mat2x4(-5.0, 3.0, -1.0, -5.0, 7.0, -3.0, -2.0, -2.0));
	var[3][2] = (mat2x4(5.0, 7.0, -6.0, -5.0, -9.0, 3.0, 7.0, 0.0));
}
#version 450
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
	highp mat3x2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0][0], mat3x2(5.0, -6.0, -5.0, 5.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[0][1], mat3x2(-5.0, -6.0, -8.0, 6.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[0][2], mat3x2(2.0, -8.0, 9.0, -8.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[1][0], mat3x2(5.0, 0.0, 4.0, 3.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[1][1], mat3x2(-1.0, -1.0, -2.0, -8.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[1][2], mat3x2(-8.0, -6.0, 0.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[2][0], mat3x2(-1.0, 7.0, -4.0, 3.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[2][1], mat3x2(-5.0, -2.0, 0.0, -2.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[2][2], mat3x2(-7.0, -4.0, 1.0, -1.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[3][0], mat3x2(-8.0, -7.0, -1.0, -4.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[3][1], mat3x2(7.0, 9.0, 8.0, 2.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[3][2], mat3x2(8.0, -3.0, 8.0, -5.0, 6.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat3x2(-1.0, -5.0, -1.0, -8.0, 7.0, 8.0));
	var[0][1] = (mat3x2(-4.0, -8.0, 1.0, 5.0, -2.0, 7.0));
	var[0][2] = (mat3x2(4.0, -6.0, 7.0, -6.0, 2.0, 5.0));
	var[1][0] = (mat3x2(0.0, 6.0, -5.0, 4.0, -2.0, 0.0));
	var[1][1] = (mat3x2(-3.0, -3.0, -2.0, 9.0, -2.0, -7.0));
	var[1][2] = (mat3x2(-9.0, -2.0, -8.0, 4.0, 3.0, 8.0));
	var[2][0] = (mat3x2(7.0, 9.0, -5.0, 9.0, -1.0, 4.0));
	var[2][1] = (mat3x2(6.0, -4.0, -6.0, 0.0, 7.0, -2.0));
	var[2][2] = (mat3x2(-1.0, -9.0, 8.0, -6.0, -9.0, 5.0));
	var[3][0] = (mat3x2(2.0, -9.0, 9.0, 4.0, -4.0, 9.0));
	var[3][1] = (mat3x2(3.0, 3.0, 1.0, -4.0, 0.0, -7.0));
	var[3][2] = (mat3x2(-4.0, 7.0, 7.0, -1.0, -2.0, 6.0));
}
#version 450
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
	f16vec4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(var[0][0]), vec4(-8.0, -9.0, 9.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[0][1]), vec4(4.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[0][2]), vec4(-8.0, 6.0, 1.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][0]), vec4(4.0, 7.0, 5.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][1]), vec4(7.0, -4.0, -8.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][2]), vec4(-3.0, 6.0, -4.0, 5.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][0]), vec4(2.0, 3.0, -3.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][1]), vec4(9.0, -9.0, 0.0, 3.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][2]), vec4(2.0, -2.0, -4.0, -2.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[3][0]), vec4(-6.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[3][1]), vec4(7.0, 5.0, -9.0, 9.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[3][2]), vec4(8.0, 7.0, 9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = f16vec4(vec4(9.0, -6.0, 2.0, -8.0));
	var[0][1] = f16vec4(vec4(-7.0, -4.0, 2.0, -5.0));
	var[0][2] = f16vec4(vec4(9.0, 1.0, -6.0, 3.0));
	var[1][0] = f16vec4(vec4(-1.0, 4.0, -1.0, -8.0));
	var[1][1] = f16vec4(vec4(5.0, 8.0, 7.0, 0.0));
	var[1][2] = f16vec4(vec4(4.0, -5.0, -6.0, -8.0));
	var[2][0] = f16vec4(vec4(-6.0, 2.0, -4.0, 8.0));
	var[2][1] = f16vec4(vec4(-4.0, -1.0, 8.0, 9.0));
	var[2][2] = f16vec4(vec4(0.0, 0.0, -5.0, 5.0));
	var[3][0] = f16vec4(vec4(7.0, -6.0, -7.0, -8.0));
	var[3][1] = f16vec4(vec4(-3.0, -4.0, -7.0, 0.0));
	var[3][2] = f16vec4(vec4(-7.0, -2.0, 7.0, -1.0));
}
#version 450
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
	highp mat2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -4.0) && allOk;
	allOk = compare_mat2(var[0][0], mat2(3.0, -8.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat2(var[0][1], mat2(5.0, 4.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat2(var[0][2], mat2(2.0, -7.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat2(var[1][0], mat2(9.0, 1.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat2(var[1][1], mat2(-6.0, 4.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat2(var[1][2], mat2(3.0, 7.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat2(var[2][0], mat2(6.0, -5.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat2(var[2][1], mat2(-4.0, -1.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat2(var[2][2], mat2(-4.0, -3.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat2(var[3][0], mat2(7.0, -8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2(var[3][1], mat2(4.0, -2.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat2(var[3][2], mat2(6.0, -7.0, -6.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (2.0);
	var[0][0] = (mat2(4.0, 4.0, -1.0, 2.0));
	var[0][1] = (mat2(-5.0, 1.0, -1.0, -2.0));
	var[0][2] = (mat2(-9.0, -3.0, -8.0, -6.0));
	var[1][0] = (mat2(-7.0, 1.0, -1.0, 6.0));
	var[1][1] = (mat2(2.0, -7.0, 8.0, -3.0));
	var[1][2] = (mat2(-2.0, 2.0, -7.0, -1.0));
	var[2][0] = (mat2(-3.0, -7.0, 2.0, -3.0));
	var[2][1] = (mat2(-6.0, 2.0, 7.0, 4.0));
	var[2][2] = (mat2(-2.0, -7.0, 4.0, -7.0));
	var[3][0] = (mat2(-5.0, -7.0, -5.0, -6.0));
	var[3][1] = (mat2(4.0, 6.0, 4.0, 2.0));
	var[3][2] = (mat2(-1.0, 9.0, 6.0, -5.0));
}
#version 450
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
	highp float var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((var[0][0][0]), 7.0) && allOk;
	allOk = compare_float((var[0][0][1]), -1.0) && allOk;
	allOk = compare_float((var[0][0][2]), -6.0) && allOk;
	allOk = compare_float((var[0][1][0]), 1.0) && allOk;
	allOk = compare_float((var[0][1][1]), -3.0) && allOk;
	allOk = compare_float((var[0][1][2]), -7.0) && allOk;
	allOk = compare_float((var[1][0][0]), 0.0) && allOk;
	allOk = compare_float((var[1][0][1]), -7.0) && allOk;
	allOk = compare_float((var[1][0][2]), 5.0) && allOk;
	allOk = compare_float((var[1][1][0]), 8.0) && allOk;
	allOk = compare_float((var[1][1][1]), -9.0) && allOk;
	allOk = compare_float((var[1][1][2]), -4.0) && allOk;
	allOk = compare_float((var[2][0][0]), 4.0) && allOk;
	allOk = compare_float((var[2][0][1]), 2.0) && allOk;
	allOk = compare_float((var[2][0][2]), -1.0) && allOk;
	allOk = compare_float((var[2][1][0]), -4.0) && allOk;
	allOk = compare_float((var[2][1][1]), -5.0) && allOk;
	allOk = compare_float((var[2][1][2]), 9.0) && allOk;
	allOk = compare_float((var[3][0][0]), -6.0) && allOk;
	allOk = compare_float((var[3][0][1]), -2.0) && allOk;
	allOk = compare_float((var[3][0][2]), -1.0) && allOk;
	allOk = compare_float((var[3][1][0]), 7.0) && allOk;
	allOk = compare_float((var[3][1][1]), -7.0) && allOk;
	allOk = compare_float((var[3][1][2]), 8.0) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (-2.0);
	var[0][0][1] = (4.0);
	var[0][0][2] = (6.0);
	var[0][1][0] = (-6.0);
	var[0][1][1] = (-9.0);
	var[0][1][2] = (-4.0);
	var[1][0][0] = (7.0);
	var[1][0][1] = (-4.0);
	var[1][0][2] = (5.0);
	var[1][1][0] = (3.0);
	var[1][1][1] = (7.0);
	var[1][1][2] = (6.0);
	var[2][0][0] = (-8.0);
	var[2][0][1] = (9.0);
	var[2][0][2] = (-5.0);
	var[2][1][0] = (5.0);
	var[2][1][1] = (4.0);
	var[2][1][2] = (-8.0);
	var[3][0][0] = (8.0);
	var[3][0][1] = (-5.0);
	var[3][0][2] = (6.0);
	var[3][1][0] = (5.0);
	var[3][1][1] = (8.0);
	var[3][1][2] = (9.0);
}
#version 450
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
	float16_t var[4][2][3];
};

bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(var[0][0][0]), -7.0) && allOk;
	allOk = compare_float16_t(float(var[0][0][1]), 4.0) && allOk;
	allOk = compare_float16_t(float(var[0][0][2]), 2.0) && allOk;
	allOk = compare_float16_t(float(var[0][1][0]), 2.0) && allOk;
	allOk = compare_float16_t(float(var[0][1][1]), 1.0) && allOk;
	allOk = compare_float16_t(float(var[0][1][2]), -8.0) && allOk;
	allOk = compare_float16_t(float(var[1][0][0]), 0.0) && allOk;
	allOk = compare_float16_t(float(var[1][0][1]), 5.0) && allOk;
	allOk = compare_float16_t(float(var[1][0][2]), 9.0) && allOk;
	allOk = compare_float16_t(float(var[1][1][0]), -2.0) && allOk;
	allOk = compare_float16_t(float(var[1][1][1]), 2.0) && allOk;
	allOk = compare_float16_t(float(var[1][1][2]), 3.0) && allOk;
	allOk = compare_float16_t(float(var[2][0][0]), 5.0) && allOk;
	allOk = compare_float16_t(float(var[2][0][1]), 4.0) && allOk;
	allOk = compare_float16_t(float(var[2][0][2]), 7.0) && allOk;
	allOk = compare_float16_t(float(var[2][1][0]), 2.0) && allOk;
	allOk = compare_float16_t(float(var[2][1][1]), 9.0) && allOk;
	allOk = compare_float16_t(float(var[2][1][2]), 8.0) && allOk;
	allOk = compare_float16_t(float(var[3][0][0]), 5.0) && allOk;
	allOk = compare_float16_t(float(var[3][0][1]), 1.0) && allOk;
	allOk = compare_float16_t(float(var[3][0][2]), -3.0) && allOk;
	allOk = compare_float16_t(float(var[3][1][0]), -1.0) && allOk;
	allOk = compare_float16_t(float(var[3][1][1]), 2.0) && allOk;
	allOk = compare_float16_t(float(var[3][1][2]), 2.0) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = float16_t(-8.0);
	var[0][0][1] = float16_t(9.0);
	var[0][0][2] = float16_t(-2.0);
	var[0][1][0] = float16_t(8.0);
	var[0][1][1] = float16_t(-3.0);
	var[0][1][2] = float16_t(6.0);
	var[1][0][0] = float16_t(7.0);
	var[1][0][1] = float16_t(8.0);
	var[1][0][2] = float16_t(-9.0);
	var[1][1][0] = float16_t(-3.0);
	var[1][1][1] = float16_t(-8.0);
	var[1][1][2] = float16_t(1.0);
	var[2][0][0] = float16_t(2.0);
	var[2][0][1] = float16_t(-8.0);
	var[2][0][2] = float16_t(-1.0);
	var[2][1][0] = float16_t(3.0);
	var[2][1][1] = float16_t(8.0);
	var[2][1][2] = float16_t(-7.0);
	var[3][0][0] = float16_t(6.0);
	var[3][0][1] = float16_t(-7.0);
	var[3][0][2] = float16_t(-5.0);
	var[3][1][0] = float16_t(-4.0);
	var[3][1][1] = float16_t(-6.0);
	var[3][1][2] = float16_t(8.0);
}
#version 450
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
	highp uvec4 var[4][2][3];
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((var[0][0][0]), uvec4(4u, 1u, 8u, 2u)) && allOk;
	allOk = compare_uvec4((var[0][0][1]), uvec4(1u, 9u, 5u, 9u)) && allOk;
	allOk = compare_uvec4((var[0][0][2]), uvec4(3u, 6u, 5u, 1u)) && allOk;
	allOk = compare_uvec4((var[0][1][0]), uvec4(8u, 5u, 8u, 5u)) && allOk;
	allOk = compare_uvec4((var[0][1][1]), uvec4(3u, 6u, 1u, 2u)) && allOk;
	allOk = compare_uvec4((var[0][1][2]), uvec4(4u, 0u, 8u, 0u)) && allOk;
	allOk = compare_uvec4((var[1][0][0]), uvec4(2u, 3u, 3u, 6u)) && allOk;
	allOk = compare_uvec4((var[1][0][1]), uvec4(0u, 7u, 0u, 0u)) && allOk;
	allOk = compare_uvec4((var[1][0][2]), uvec4(2u, 8u, 5u, 1u)) && allOk;
	allOk = compare_uvec4((var[1][1][0]), uvec4(6u, 2u, 8u, 7u)) && allOk;
	allOk = compare_uvec4((var[1][1][1]), uvec4(5u, 8u, 6u, 1u)) && allOk;
	allOk = compare_uvec4((var[1][1][2]), uvec4(9u, 8u, 2u, 8u)) && allOk;
	allOk = compare_uvec4((var[2][0][0]), uvec4(7u, 3u, 1u, 5u)) && allOk;
	allOk = compare_uvec4((var[2][0][1]), uvec4(8u, 7u, 6u, 2u)) && allOk;
	allOk = compare_uvec4((var[2][0][2]), uvec4(5u, 9u, 5u, 9u)) && allOk;
	allOk = compare_uvec4((var[2][1][0]), uvec4(9u, 6u, 7u, 7u)) && allOk;
	allOk = compare_uvec4((var[2][1][1]), uvec4(5u, 5u, 7u, 9u)) && allOk;
	allOk = compare_uvec4((var[2][1][2]), uvec4(1u, 6u, 5u, 2u)) && allOk;
	allOk = compare_uvec4((var[3][0][0]), uvec4(1u, 6u, 2u, 1u)) && allOk;
	allOk = compare_uvec4((var[3][0][1]), uvec4(7u, 9u, 5u, 3u)) && allOk;
	allOk = compare_uvec4((var[3][0][2]), uvec4(5u, 7u, 4u, 7u)) && allOk;
	allOk = compare_uvec4((var[3][1][0]), uvec4(8u, 0u, 6u, 7u)) && allOk;
	allOk = compare_uvec4((var[3][1][1]), uvec4(9u, 4u, 5u, 3u)) && allOk;
	allOk = compare_uvec4((var[3][1][2]), uvec4(2u, 3u, 8u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (uvec4(2u, 7u, 2u, 9u));
	var[0][0][1] = (uvec4(7u, 9u, 5u, 1u));
	var[0][0][2] = (uvec4(3u, 4u, 4u, 2u));
	var[0][1][0] = (uvec4(6u, 1u, 9u, 4u));
	var[0][1][1] = (uvec4(5u, 7u, 7u, 0u));
	var[0][1][2] = (uvec4(2u, 5u, 1u, 3u));
	var[1][0][0] = (uvec4(0u, 5u, 6u, 2u));
	var[1][0][1] = (uvec4(9u, 5u, 7u, 7u));
	var[1][0][2] = (uvec4(0u, 3u, 8u, 1u));
	var[1][1][0] = (uvec4(9u, 6u, 1u, 2u));
	var[1][1][1] = (uvec4(0u, 0u, 8u, 4u));
	var[1][1][2] = (uvec4(9u, 5u, 7u, 1u));
	var[2][0][0] = (uvec4(4u, 9u, 1u, 3u));
	var[2][0][1] = (uvec4(8u, 8u, 8u, 1u));
	var[2][0][2] = (uvec4(7u, 5u, 4u, 8u));
	var[2][1][0] = (uvec4(2u, 0u, 0u, 4u));
	var[2][1][1] = (uvec4(4u, 2u, 5u, 9u));
	var[2][1][2] = (uvec4(6u, 9u, 6u, 2u));
	var[3][0][0] = (uvec4(6u, 6u, 0u, 9u));
	var[3][0][1] = (uvec4(7u, 2u, 3u, 0u));
	var[3][0][2] = (uvec4(4u, 4u, 8u, 5u));
	var[3][1][0] = (uvec4(3u, 6u, 1u, 7u));
	var[3][1][1] = (uvec4(5u, 6u, 4u, 8u));
	var[3][1][2] = (uvec4(6u, 3u, 2u, 5u));
}
#version 450
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
	highp mat4x3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0][0][0], mat4x3(7.0, -2.0, 6.0, 3.0, 1.0, -7.0, 1.0, -4.0, 0.0, 9.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(3.0, 2.0, 2.0, 6.0, 6.0, 0.0, 3.0, 6.0, -4.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][2], mat4x3(-6.0, -5.0, 4.0, -4.0, 1.0, 2.0, -5.0, 9.0, -7.0, -2.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(1.0, 8.0, 9.0, 7.0, 0.0, -2.0, -4.0, 7.0, 0.0, -9.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(-9.0, -9.0, -7.0, -5.0, 2.0, 5.0, 0.0, -2.0, -3.0, -6.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][2], mat4x3(-8.0, -7.0, 9.0, 6.0, 6.0, -5.0, -3.0, 9.0, -4.0, -3.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(-7.0, 1.0, -9.0, 8.0, 8.0, 5.0, 0.0, 5.0, -1.0, 2.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(4.0, -2.0, -8.0, -5.0, -8.0, -5.0, -4.0, -1.0, -1.0, -5.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][2], mat4x3(3.0, 8.0, 5.0, 3.0, -2.0, 8.0, -6.0, -2.0, -8.0, -1.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(-5.0, -8.0, -6.0, 4.0, -5.0, 6.0, 5.0, -8.0, 5.0, -9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(-5.0, -1.0, 5.0, 4.0, -3.0, -3.0, -5.0, 1.0, -4.0, 6.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][2], mat4x3(0.0, -6.0, -8.0, -7.0, 6.0, -3.0, 0.0, 2.0, -9.0, -7.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(-9.0, 0.0, 6.0, -9.0, -9.0, 9.0, 6.0, 9.0, -2.0, 8.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(-8.0, 6.0, 8.0, 4.0, -3.0, -9.0, 9.0, 1.0, 2.0, 8.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][2], mat4x3(-4.0, -3.0, 7.0, 7.0, 0.0, -3.0, 5.0, -5.0, -9.0, -3.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(-2.0, 8.0, 2.0, 7.0, 9.0, 8.0, -3.0, 8.0, -9.0, -3.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(0.0, 8.0, 9.0, -9.0, -9.0, 4.0, 1.0, -1.0, 9.0, 0.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][2], mat4x3(-2.0, -8.0, 7.0, 1.0, 5.0, 7.0, 8.0, -2.0, 4.0, -4.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][0], mat4x3(8.0, -2.0, 1.0, 2.0, -3.0, 9.0, 6.0, -5.0, 8.0, -1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][1], mat4x3(-5.0, -7.0, 4.0, 5.0, 7.0, 5.0, 9.0, 4.0, 8.0, 2.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][2], mat4x3(-8.0, -9.0, -8.0, 2.0, -2.0, 8.0, 4.0, 4.0, -3.0, 2.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][0], mat4x3(6.0, 3.0, 4.0, -2.0, 5.0, 6.0, -9.0, 4.0, 7.0, 7.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][1], mat4x3(9.0, 9.0, -6.0, -7.0, -9.0, -9.0, 5.0, 9.0, 5.0, 4.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][2], mat4x3(3.0, 6.0, -3.0, -8.0, -1.0, 5.0, -8.0, -5.0, 3.0, -4.0, -9.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec3(7.0, 4.0, -4.0));
	var[0][0][0][1] = (vec3(-6.0, 3.0, -3.0));
	var[0][0][0][2] = (vec3(9.0, -2.0, 3.0));
	var[0][0][0][3] = (vec3(9.0, -9.0, 7.0));
	var[0][0][1][0] = (vec3(5.0, 1.0, -9.0));
	var[0][0][1][1] = (vec3(-1.0, -2.0, 6.0));
	var[0][0][1][2] = (vec3(-4.0, 6.0, 4.0));
	var[0][0][1][3] = (vec3(-8.0, 7.0, 3.0));
	var[0][0][2][0] = (vec3(-4.0, -9.0, 8.0));
	var[0][0][2][1] = (vec3(9.0, 2.0, 2.0));
	var[0][0][2][2] = (vec3(9.0, -7.0, 3.0));
	var[0][0][2][3] = (vec3(8.0, 2.0, 4.0));
	var[0][1][0][0] = (vec3(-5.0, 2.0, -4.0));
	var[0][1][0][1] = (vec3(-7.0, -3.0, -4.0));
	var[0][1][0][2] = (vec3(4.0, -3.0, -8.0));
	var[0][1][0][3] = (vec3(-5.0, -1.0, 1.0));
	var[0][1][1][0] = (vec3(6.0, -2.0, 8.0));
	var[0][1][1][1] = (vec3(-7.0, 1.0, 4.0));
	var[0][1][1][2] = (vec3(6.0, 8.0, -5.0));
	var[0][1][1][3] = (vec3(1.0, -6.0, 4.0));
	var[0][1][2][0] = (vec3(-9.0, 3.0, -3.0));
	var[0][1][2][1] = (vec3(0.0, -5.0, -3.0));
	var[0][1][2][2] = (vec3(-5.0, -8.0, 3.0));
	var[0][1][2][3] = (vec3(3.0, -6.0, 8.0));
	var[1][0][0][0] = (vec3(2.0, 4.0, -3.0));
	var[1][0][0][1] = (vec3(-8.0, 7.0, 3.0));
	var[1][0][0][2] = (vec3(0.0, -8.0, 0.0));
	var[1][0][0][3] = (vec3(6.0, -9.0, 0.0));
	var[1][0][1][0] = (vec3(-4.0, 5.0, 5.0));
	var[1][0][1][1] = (vec3(-7.0, -8.0, -1.0));
	var[1][0][1][2] = (vec3(6.0, -3.0, -5.0));
	var[1][0][1][3] = (vec3(0.0, 8.0, -8.0));
	var[1][0][2][0] = (vec3(-4.0, 4.0, 8.0));
	var[1][0][2][1] = (vec3(-4.0, -4.0, -3.0));
	var[1][0][2][2] = (vec3(3.0, 3.0, 2.0));
	var[1][0][2][3] = (vec3(8.0, -8.0, -6.0));
	var[1][1][0][0] = (vec3(-3.0, 5.0, 6.0));
	var[1][1][0][1] = (vec3(5.0, -1.0, 6.0));
	var[1][1][0][2] = (vec3(8.0, 7.0, 1.0));
	var[1][1][0][3] = (vec3(-5.0, 6.0, -6.0));
	var[1][1][1][0] = (vec3(-3.0, -7.0, 7.0));
	var[1][1][1][1] = (vec3(-9.0, -3.0, 6.0));
	var[1][1][1][2] = (vec3(0.0, -7.0, 3.0));
	var[1][1][1][3] = (vec3(2.0, -7.0, 1.0));
	var[1][1][2][0] = (vec3(8.0, -1.0, -9.0));
	var[1][1][2][1] = (vec3(8.0, 8.0, 2.0));
	var[1][1][2][2] = (vec3(7.0, -5.0, -2.0));
	var[1][1][2][3] = (vec3(-9.0, 6.0, 2.0));
	var[2][0][0][0] = (vec3(9.0, 1.0, -1.0));
	var[2][0][0][1] = (vec3(-1.0, 2.0, 4.0));
	var[2][0][0][2] = (vec3(4.0, 2.0, 0.0));
	var[2][0][0][3] = (vec3(5.0, 6.0, -6.0));
	var[2][0][1][0] = (vec3(-3.0, 7.0, -6.0));
	var[2][0][1][1] = (vec3(7.0, 9.0, 8.0));
	var[2][0][1][2] = (vec3(-9.0, -9.0, -9.0));
	var[2][0][1][3] = (vec3(6.0, -7.0, -3.0));
	var[2][0][2][0] = (vec3(7.0, -1.0, -4.0));
	var[2][0][2][1] = (vec3(-9.0, 0.0, -1.0));
	var[2][0][2][2] = (vec3(-7.0, -2.0, -3.0));
	var[2][0][2][3] = (vec3(1.0, 4.0, 5.0));
	var[2][1][0][0] = (vec3(-1.0, 7.0, 7.0));
	var[2][1][0][1] = (vec3(3.0, -4.0, -1.0));
	var[2][1][0][2] = (vec3(-4.0, 5.0, 7.0));
	var[2][1][0][3] = (vec3(-5.0, 7.0, 5.0));
	var[2][1][1][0] = (vec3(-1.0, -1.0, 5.0));
	var[2][1][1][1] = (vec3(9.0, 7.0, -5.0));
	var[2][1][1][2] = (vec3(3.0, -1.0, 3.0));
	var[2][1][1][3] = (vec3(8.0, -5.0, 3.0));
	var[2][1][2][0] = (vec3(-6.0, 1.0, 0.0));
	var[2][1][2][1] = (vec3(8.0, -8.0, 5.0));
	var[2][1][2][2] = (vec3(-3.0, 5.0, -4.0));
	var[2][1][2][3] = (vec3(-3.0, -2.0, 2.0));
	var[3][0][0][0] = (vec3(9.0, 8.0, 7.0));
	var[3][0][0][1] = (vec3(5.0, 4.0, 7.0));
	var[3][0][0][2] = (vec3(3.0, -3.0, 4.0));
	var[3][0][0][3] = (vec3(3.0, -6.0, 5.0));
	var[3][0][1][0] = (vec3(-8.0, -4.0, -9.0));
	var[3][0][1][1] = (vec3(4.0, 8.0, -3.0));
	var[3][0][1][2] = (vec3(-9.0, 7.0, -2.0));
	var[3][0][1][3] = (vec3(0.0, -3.0, -3.0));
	var[3][0][2][0] = (vec3(4.0, -2.0, -4.0));
	var[3][0][2][1] = (vec3(-5.0, -7.0, 1.0));
	var[3][0][2][2] = (vec3(-8.0, 1.0, 9.0));
	var[3][0][2][3] = (vec3(-8.0, 0.0, -2.0));
	var[3][1][0][0] = (vec3(-5.0, 3.0, -6.0));
	var[3][1][0][1] = (vec3(-6.0, -4.0, -2.0));
	var[3][1][0][2] = (vec3(-5.0, -2.0, -2.0));
	var[3][1][0][3] = (vec3(-8.0, 2.0, 4.0));
	var[3][1][1][0] = (vec3(-1.0, -1.0, 1.0));
	var[3][1][1][1] = (vec3(-9.0, -7.0, -8.0));
	var[3][1][1][2] = (vec3(-8.0, -5.0, -1.0));
	var[3][1][1][3] = (vec3(2.0, 0.0, -4.0));
	var[3][1][2][0] = (vec3(7.0, 6.0, 4.0));
	var[3][1][2][1] = (vec3(-5.0, -5.0, 8.0));
	var[3][1][2][2] = (vec3(-3.0, 4.0, -5.0));
	var[3][1][2][3] = (vec3(-8.0, 5.0, -2.0));
}
#version 450
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
	f16vec4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(var[0][0][0]), vec4(-8.0, -9.0, 9.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[0][0][1]), vec4(4.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[0][0][2]), vec4(-8.0, 6.0, 1.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[0][1][0]), vec4(7.0, -7.0, -3.0, 1.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[0][1][1]), vec4(7.0, 0.0, -2.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[0][1][2]), vec4(-6.0, -5.0, 8.0, 0.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][0][0]), vec4(4.0, 7.0, 5.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][0][1]), vec4(7.0, -4.0, -8.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][0][2]), vec4(-3.0, 6.0, -4.0, 5.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][1][0]), vec4(-9.0, 7.0, -3.0, -1.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][1][1]), vec4(2.0, 7.0, 0.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][1][2]), vec4(-7.0, 6.0, 0.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][0][0]), vec4(2.0, 3.0, -3.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][0][1]), vec4(9.0, -9.0, 0.0, 3.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][0][2]), vec4(2.0, -2.0, -4.0, -2.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][1][0]), vec4(1.0, 0.0, -7.0, 0.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][1][1]), vec4(-9.0, 0.0, 9.0, -9.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][1][2]), vec4(-5.0, 3.0, 4.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[3][0][0]), vec4(-6.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[3][0][1]), vec4(7.0, 5.0, -9.0, 9.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[3][0][2]), vec4(8.0, 7.0, 9.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[3][1][0]), vec4(-5.0, -8.0, 6.0, -5.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[3][1][1]), vec4(0.0, -8.0, -9.0, 7.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[3][1][2]), vec4(3.0, 9.0, -3.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = f16vec4(vec4(9.0, -6.0, 2.0, -8.0));
	var[0][0][1] = f16vec4(vec4(-7.0, -4.0, 2.0, -5.0));
	var[0][0][2] = f16vec4(vec4(9.0, 1.0, -6.0, 3.0));
	var[0][1][0] = f16vec4(vec4(8.0, 3.0, -7.0, -9.0));
	var[0][1][1] = f16vec4(vec4(6.0, -8.0, -8.0, 3.0));
	var[0][1][2] = f16vec4(vec4(1.0, -6.0, -6.0, 9.0));
	var[1][0][0] = f16vec4(vec4(-1.0, 4.0, -1.0, -8.0));
	var[1][0][1] = f16vec4(vec4(5.0, 8.0, 7.0, 0.0));
	var[1][0][2] = f16vec4(vec4(4.0, -5.0, -6.0, -8.0));
	var[1][1][0] = f16vec4(vec4(9.0, -7.0, 7.0, -4.0));
	var[1][1][1] = f16vec4(vec4(-3.0, 0.0, -5.0, -5.0));
	var[1][1][2] = f16vec4(vec4(-6.0, -7.0, -2.0, -8.0));
	var[2][0][0] = f16vec4(vec4(-6.0, 2.0, -4.0, 8.0));
	var[2][0][1] = f16vec4(vec4(-4.0, -1.0, 8.0, 9.0));
	var[2][0][2] = f16vec4(vec4(0.0, 0.0, -5.0, 5.0));
	var[2][1][0] = f16vec4(vec4(-3.0, -6.0, 7.0, 3.0));
	var[2][1][1] = f16vec4(vec4(-6.0, -9.0, -2.0, 7.0));
	var[2][1][2] = f16vec4(vec4(2.0, -6.0, -5.0, 8.0));
	var[3][0][0] = f16vec4(vec4(7.0, -6.0, -7.0, -8.0));
	var[3][0][1] = f16vec4(vec4(-3.0, -4.0, -7.0, 0.0));
	var[3][0][2] = f16vec4(vec4(-7.0, -2.0, 7.0, -1.0));
	var[3][1][0] = f16vec4(vec4(6.0, 1.0, -5.0, 6.0));
	var[3][1][1] = f16vec4(vec4(-5.0, -9.0, -6.0, -4.0));
	var[3][1][2] = f16vec4(vec4(-5.0, -8.0, 1.0, 2.0));
}
#version 450
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
	uint padding;
	highp uvec4 var[4][2][3];
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((padding), 4u) && allOk;
	allOk = compare_uvec4((var[0][0][0]), uvec4(1u, 8u, 2u, 1u)) && allOk;
	allOk = compare_uvec4((var[0][0][1]), uvec4(9u, 5u, 9u, 3u)) && allOk;
	allOk = compare_uvec4((var[0][0][2]), uvec4(6u, 5u, 1u, 2u)) && allOk;
	allOk = compare_uvec4((var[0][1][0]), uvec4(5u, 8u, 5u, 3u)) && allOk;
	allOk = compare_uvec4((var[0][1][1]), uvec4(6u, 1u, 2u, 4u)) && allOk;
	allOk = compare_uvec4((var[0][1][2]), uvec4(0u, 8u, 0u, 6u)) && allOk;
	allOk = compare_uvec4((var[1][0][0]), uvec4(3u, 3u, 6u, 0u)) && allOk;
	allOk = compare_uvec4((var[1][0][1]), uvec4(7u, 0u, 0u, 2u)) && allOk;
	allOk = compare_uvec4((var[1][0][2]), uvec4(8u, 5u, 1u, 7u)) && allOk;
	allOk = compare_uvec4((var[1][1][0]), uvec4(2u, 8u, 7u, 5u)) && allOk;
	allOk = compare_uvec4((var[1][1][1]), uvec4(8u, 6u, 1u, 9u)) && allOk;
	allOk = compare_uvec4((var[1][1][2]), uvec4(8u, 2u, 8u, 9u)) && allOk;
	allOk = compare_uvec4((var[2][0][0]), uvec4(3u, 1u, 5u, 8u)) && allOk;
	allOk = compare_uvec4((var[2][0][1]), uvec4(7u, 6u, 2u, 5u)) && allOk;
	allOk = compare_uvec4((var[2][0][2]), uvec4(9u, 5u, 9u, 1u)) && allOk;
	allOk = compare_uvec4((var[2][1][0]), uvec4(6u, 7u, 7u, 5u)) && allOk;
	allOk = compare_uvec4((var[2][1][1]), uvec4(5u, 7u, 9u, 1u)) && allOk;
	allOk = compare_uvec4((var[2][1][2]), uvec4(6u, 5u, 2u, 8u)) && allOk;
	allOk = compare_uvec4((var[3][0][0]), uvec4(6u, 2u, 1u, 7u)) && allOk;
	allOk = compare_uvec4((var[3][0][1]), uvec4(9u, 5u, 3u, 5u)) && allOk;
	allOk = compare_uvec4((var[3][0][2]), uvec4(7u, 4u, 7u, 8u)) && allOk;
	allOk = compare_uvec4((var[3][1][0]), uvec4(0u, 6u, 7u, 9u)) && allOk;
	allOk = compare_uvec4((var[3][1][1]), uvec4(4u, 5u, 3u, 2u)) && allOk;
	allOk = compare_uvec4((var[3][1][2]), uvec4(3u, 8u, 1u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (2u);
	var[0][0][0] = (uvec4(7u, 2u, 9u, 7u));
	var[0][0][1] = (uvec4(9u, 5u, 1u, 3u));
	var[0][0][2] = (uvec4(4u, 4u, 2u, 0u));
	var[0][1][0] = (uvec4(1u, 9u, 4u, 5u));
	var[0][1][1] = (uvec4(7u, 7u, 0u, 2u));
	var[0][1][2] = (uvec4(5u, 1u, 3u, 9u));
	var[1][0][0] = (uvec4(5u, 6u, 2u, 9u));
	var[1][0][1] = (uvec4(5u, 7u, 7u, 0u));
	var[1][0][2] = (uvec4(3u, 8u, 1u, 4u));
	var[1][1][0] = (uvec4(6u, 1u, 2u, 0u));
	var[1][1][1] = (uvec4(0u, 8u, 4u, 9u));
	var[1][1][2] = (uvec4(5u, 7u, 1u, 2u));
	var[2][0][0] = (uvec4(9u, 1u, 3u, 8u));
	var[2][0][1] = (uvec4(8u, 8u, 1u, 7u));
	var[2][0][2] = (uvec4(5u, 4u, 8u, 6u));
	var[2][1][0] = (uvec4(0u, 0u, 4u, 4u));
	var[2][1][1] = (uvec4(2u, 5u, 9u, 6u));
	var[2][1][2] = (uvec4(9u, 6u, 2u, 3u));
	var[3][0][0] = (uvec4(6u, 0u, 9u, 7u));
	var[3][0][1] = (uvec4(2u, 3u, 0u, 4u));
	var[3][0][2] = (uvec4(4u, 8u, 5u, 6u));
	var[3][1][0] = (uvec4(6u, 1u, 7u, 5u));
	var[3][1][1] = (uvec4(6u, 4u, 8u, 6u));
	var[3][1][2] = (uvec4(3u, 2u, 5u, 3u));
}
#version 450
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
	highp mat3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_mat3(var[0][0][0], mat3(-4.0, 9.0, -9.0, 3.0, 9.0, 6.0, -9.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(5.0, -8.0, -6.0, -8.0, -7.0, -4.0, 6.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat3(var[0][0][2], mat3(-2.0, -2.0, -8.0, -8.0, -5.0, -4.0, -6.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(8.0, -5.0, -5.0, -8.0, -4.0, -7.0, 9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(-8.0, 6.0, 4.0, -3.0, 9.0, -2.0, 2.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat3(var[0][1][2], mat3(7.0, -4.0, 4.0, -4.0, 1.0, 6.0, -2.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(7.0, 0.0, 6.0, 5.0, 0.0, -5.0, -4.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(9.0, 9.0, -6.0, 9.0, -6.0, 9.0, 6.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat3(var[1][0][2], mat3(-9.0, -2.0, -6.0, 7.0, 7.0, 8.0, 3.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(-6.0, 4.0, -6.0, 8.0, 1.0, -7.0, -1.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(5.0, 5.0, -1.0, -9.0, -7.0, 7.0, 9.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat3(var[1][1][2], mat3(-7.0, 0.0, -4.0, 1.0, -7.0, 1.0, -8.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(-1.0, -3.0, 3.0, -5.0, -1.0, 1.0, -8.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(9.0, 6.0, -9.0, 2.0, 8.0, -5.0, 5.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat3(var[2][0][2], mat3(-4.0, -2.0, 3.0, 0.0, -7.0, -5.0, 7.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(-4.0, -2.0, -7.0, 2.0, -2.0, 9.0, 2.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(-2.0, 5.0, -3.0, 7.0, -5.0, 2.0, 4.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3(var[2][1][2], mat3(2.0, 8.0, -3.0, -7.0, -9.0, -7.0, 4.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat3(var[3][0][0], mat3(5.0, 6.0, -6.0, -7.0, 9.0, 0.0, -5.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3(var[3][0][1], mat3(-7.0, -7.0, -5.0, 8.0, 3.0, 7.0, 6.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat3(var[3][0][2], mat3(4.0, -6.0, 0.0, 6.0, 5.0, -3.0, 1.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3(var[3][1][0], mat3(7.0, -4.0, 4.0, 5.0, 3.0, 0.0, -1.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat3(var[3][1][1], mat3(-9.0, 6.0, -4.0, -2.0, -4.0, 3.0, 8.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat3(var[3][1][2], mat3(-9.0, 2.0, -6.0, 6.0, 7.0, 8.0, -2.0, 1.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (2.0);
	var[0][0][0][0] = (vec3(-4.0, 9.0, -4.0));
	var[0][0][0][1] = (vec3(2.0, 5.0, 5.0));
	var[0][0][0][2] = (vec3(-9.0, -5.0, 3.0));
	var[0][0][1][0] = (vec3(1.0, 8.0, 6.0));
	var[0][0][1][1] = (vec3(9.0, -8.0, -1.0));
	var[0][0][1][2] = (vec3(5.0, 1.0, 6.0));
	var[0][0][2][0] = (vec3(-5.0, -4.0, -8.0));
	var[0][0][2][1] = (vec3(-8.0, -2.0, 9.0));
	var[0][0][2][2] = (vec3(-4.0, 4.0, 4.0));
	var[0][1][0][0] = (vec3(-8.0, 2.0, -6.0));
	var[0][1][0][1] = (vec3(9.0, -7.0, 9.0));
	var[0][1][0][2] = (vec3(6.0, 1.0, -4.0));
	var[0][1][1][0] = (vec3(8.0, -7.0, 1.0));
	var[0][1][1][1] = (vec3(0.0, 4.0, -6.0));
	var[0][1][1][2] = (vec3(-3.0, 3.0, -5.0));
	var[0][1][2][0] = (vec3(-6.0, 5.0, 4.0));
	var[0][1][2][1] = (vec3(3.0, -2.0, -6.0));
	var[0][1][2][2] = (vec3(-4.0, -1.0, 4.0));
	var[1][0][0][0] = (vec3(-1.0, 5.0, -1.0));
	var[1][0][0][1] = (vec3(0.0, 9.0, 7.0));
	var[1][0][0][2] = (vec3(7.0, 5.0, 8.0));
	var[1][0][1][0] = (vec3(-6.0, -1.0, -1.0));
	var[1][0][1][1] = (vec3(-2.0, -5.0, -5.0));
	var[1][0][1][2] = (vec3(6.0, -3.0, -4.0));
	var[1][0][2][0] = (vec3(-6.0, 2.0, 3.0));
	var[1][0][2][1] = (vec3(-1.0, 2.0, -3.0));
	var[1][0][2][2] = (vec3(4.0, 1.0, 9.0));
	var[1][1][0][0] = (vec3(4.0, -6.0, 0.0));
	var[1][1][0][1] = (vec3(2.0, -5.0, 5.0));
	var[1][1][0][2] = (vec3(8.0, -2.0, 3.0));
	var[1][1][1][0] = (vec3(-1.0, 7.0, -9.0));
	var[1][1][1][1] = (vec3(-9.0, -8.0, 9.0));
	var[1][1][1][2] = (vec3(-9.0, -5.0, 1.0));
	var[1][1][2][0] = (vec3(-2.0, 1.0, -8.0));
	var[1][1][2][1] = (vec3(-4.0, -3.0, 3.0));
	var[1][1][2][2] = (vec3(-4.0, -3.0, -5.0));
	var[2][0][0][0] = (vec3(-3.0, -9.0, 6.0));
	var[2][0][0][1] = (vec3(-1.0, -6.0, 6.0));
	var[2][0][0][2] = (vec3(2.0, -5.0, -1.0));
	var[2][0][1][0] = (vec3(-2.0, 2.0, 9.0));
	var[2][0][1][1] = (vec3(1.0, -8.0, 6.0));
	var[2][0][1][2] = (vec3(-1.0, 7.0, 4.0));
	var[2][0][2][0] = (vec3(2.0, -8.0, 0.0));
	var[2][0][2][1] = (vec3(3.0, 9.0, 9.0));
	var[2][0][2][2] = (vec3(-8.0, -4.0, -8.0));
	var[2][1][0][0] = (vec3(7.0, 5.0, -2.0));
	var[2][1][0][1] = (vec3(-2.0, 8.0, -3.0));
	var[2][1][0][2] = (vec3(1.0, 7.0, -9.0));
	var[2][1][1][0] = (vec3(8.0, 7.0, 2.0));
	var[2][1][1][1] = (vec3(2.0, -5.0, -8.0));
	var[2][1][1][2] = (vec3(-5.0, 6.0, 4.0));
	var[2][1][2][0] = (vec3(1.0, 9.0, 5.0));
	var[2][1][2][1] = (vec3(-6.0, 7.0, -7.0));
	var[2][1][2][2] = (vec3(-2.0, -6.0, 0.0));
	var[3][0][0][0] = (vec3(3.0, 4.0, -4.0));
	var[3][0][0][1] = (vec3(4.0, 1.0, 0.0));
	var[3][0][0][2] = (vec3(4.0, 5.0, -9.0));
	var[3][0][1][0] = (vec3(-4.0, 2.0, -6.0));
	var[3][0][1][1] = (vec3(8.0, 3.0, 2.0));
	var[3][0][1][2] = (vec3(0.0, -1.0, 7.0));
	var[3][0][2][0] = (vec3(1.0, 3.0, 5.0));
	var[3][0][2][1] = (vec3(1.0, -6.0, 2.0));
	var[3][0][2][2] = (vec3(-5.0, 4.0, -9.0));
	var[3][1][0][0] = (vec3(-9.0, 7.0, -2.0));
	var[3][1][0][1] = (vec3(0.0, 5.0, 8.0));
	var[3][1][0][2] = (vec3(8.0, -1.0, -4.0));
	var[3][1][1][0] = (vec3(3.0, 5.0, -9.0));
	var[3][1][1][1] = (vec3(8.0, -7.0, 7.0));
	var[3][1][1][2] = (vec3(-3.0, 4.0, -6.0));
	var[3][1][2][0] = (vec3(3.0, 6.0, -9.0));
	var[3][1][2][1] = (vec3(9.0, 3.0, 8.0));
	var[3][1][2][2] = (vec3(8.0, -2.0, 3.0));
}
#version 450
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
	highp mat3x4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -1.0) && allOk;
	allOk = compare_mat3x4(var[0][0][0], mat3x4(-8.0, 2.0, -9.0, 8.0, -1.0, -4.0, 9.0, -5.0, -2.0, -5.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][1], mat3x4(1.0, 4.0, -5.0, 3.0, -6.0, 9.0, -9.0, 6.0, 9.0, -2.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][2], mat3x4(5.0, 1.0, -8.0, 4.0, 7.0, 5.0, -6.0, -7.0, 8.0, -3.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][0], mat3x4(6.0, -6.0, -4.0, 9.0, -5.0, 3.0, -2.0, -1.0, -8.0, -1.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][1], mat3x4(7.0, 0.0, 7.0, 9.0, -1.0, 9.0, 2.0, -5.0, 3.0, 1.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][2], mat3x4(-6.0, -1.0, -2.0, 5.0, 1.0, -3.0, -3.0, -9.0, 8.0, 0.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][0], mat3x4(-2.0, -6.0, -4.0, 8.0, -8.0, -1.0, -6.0, 9.0, 1.0, 4.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][1], mat3x4(4.0, 9.0, 6.0, -6.0, 9.0, -8.0, 6.0, 1.0, -6.0, -8.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][2], mat3x4(3.0, 2.0, 4.0, -9.0, -1.0, 1.0, 4.0, -3.0, 8.0, -9.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][0], mat3x4(-5.0, 3.0, -8.0, -1.0, -9.0, 3.0, -9.0, -2.0, 8.0, -9.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][1], mat3x4(1.0, -5.0, -4.0, 3.0, 5.0, 7.0, 8.0, 6.0, 8.0, -1.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][2], mat3x4(2.0, -3.0, 3.0, 8.0, 8.0, 6.0, 1.0, 3.0, 6.0, 5.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][0], mat3x4(-2.0, -2.0, -2.0, 1.0, 3.0, 5.0, -2.0, 3.0, -9.0, 1.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][1], mat3x4(9.0, -9.0, -2.0, 6.0, 1.0, 4.0, -1.0, 6.0, 1.0, -4.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][2], mat3x4(6.0, 5.0, 6.0, -4.0, 6.0, -9.0, 9.0, -3.0, 5.0, 3.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][0], mat3x4(1.0, 2.0, -2.0, -3.0, -4.0, 2.0, 7.0, -2.0, -7.0, 0.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][1], mat3x4(-4.0, -2.0, 6.0, 5.0, 2.0, -2.0, -9.0, 3.0, -3.0, 9.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][2], mat3x4(5.0, -6.0, 9.0, 6.0, 4.0, -4.0, -9.0, 6.0, -8.0, -2.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][0], mat3x4(-3.0, 5.0, 9.0, 6.0, 7.0, 2.0, -1.0, 5.0, 6.0, 7.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][1], mat3x4(-3.0, -3.0, 0.0, -7.0, 9.0, -3.0, 4.0, 2.0, 1.0, 2.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][2], mat3x4(0.0, 2.0, 3.0, 3.0, 7.0, 8.0, -3.0, -2.0, 8.0, -1.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][0], mat3x4(4.0, 5.0, 1.0, -1.0, 3.0, 0.0, -3.0, -4.0, 8.0, -4.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][1], mat3x4(-5.0, 8.0, -9.0, 1.0, -2.0, -2.0, -3.0, -7.0, 1.0, -9.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][2], mat3x4(0.0, -6.0, 7.0, 3.0, 0.0, -7.0, 7.0, -3.0, -6.0, -7.0, 6.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-1.0);
	var[0][0][0] = (mat3x4(-6.0, 0.0, -6.0, 9.0, -5.0, 3.0, -3.0, -2.0, 6.0, 4.0, -6.0, -9.0));
	var[0][0][1] = (mat3x4(-4.0, 2.0, -4.0, -4.0, 2.0, 1.0, 3.0, -2.0, 9.0, -2.0, 3.0, -7.0));
	var[0][0][2] = (mat3x4(-1.0, -2.0, 4.0, -1.0, 4.0, 1.0, -9.0, 5.0, 6.0, 0.0, 4.0, -9.0));
	var[0][1][0] = (mat3x4(3.0, 0.0, 8.0, 5.0, 9.0, 8.0, 5.0, -4.0, -6.0, -9.0, -2.0, 5.0));
	var[0][1][1] = (mat3x4(-6.0, -3.0, 3.0, 3.0, 0.0, 9.0, -9.0, 4.0, 8.0, 3.0, -2.0, -8.0));
	var[0][1][2] = (mat3x4(-9.0, -4.0, -3.0, -8.0, 7.0, 8.0, -1.0, -7.0, -7.0, 4.0, -2.0, 0.0));
	var[1][0][0] = (mat3x4(-5.0, 8.0, 4.0, -4.0, -5.0, 7.0, 3.0, -5.0, 1.0, -3.0, -5.0, -4.0));
	var[1][0][1] = (mat3x4(-8.0, 9.0, -3.0, -2.0, -4.0, 3.0, -3.0, 7.0, 4.0, 3.0, 8.0, -9.0));
	var[1][0][2] = (mat3x4(-6.0, 5.0, -4.0, -8.0, 2.0, -3.0, -9.0, -5.0, -3.0, 7.0, -7.0, 3.0));
	var[1][1][0] = (mat3x4(2.0, -3.0, 7.0, -3.0, 7.0, 0.0, -2.0, 0.0, -4.0, 5.0, 2.0, -3.0));
	var[1][1][1] = (mat3x4(-6.0, -3.0, 4.0, -8.0, 7.0, -3.0, -5.0, -5.0, 7.0, -2.0, 4.0, -6.0));
	var[1][1][2] = (mat3x4(7.0, 1.0, -6.0, 7.0, -9.0, 5.0, 5.0, 3.0, -2.0, 3.0, 6.0, 2.0));
	var[2][0][0] = (mat3x4(-9.0, -6.0, -2.0, -8.0, 0.0, 0.0, 1.0, 5.0, 1.0, -4.0, -8.0, 1.0));
	var[2][0][1] = (mat3x4(-9.0, -5.0, 6.0, -4.0, -3.0, -9.0, -2.0, 8.0, -1.0, -1.0, -7.0, 9.0));
	var[2][0][2] = (mat3x4(-7.0, 4.0, -5.0, -9.0, 2.0, -9.0, 4.0, 6.0, 2.0, -4.0, -9.0, 4.0));
	var[2][1][0] = (mat3x4(-5.0, 3.0, 2.0, 1.0, 4.0, -5.0, -7.0, -9.0, -3.0, -5.0, 8.0, 5.0));
	var[2][1][1] = (mat3x4(-7.0, -7.0, -7.0, 9.0, -4.0, 1.0, 3.0, 5.0, 1.0, 4.0, 9.0, -6.0));
	var[2][1][2] = (mat3x4(-3.0, -3.0, -7.0, -3.0, 5.0, -8.0, 3.0, 3.0, 6.0, 7.0, 7.0, -9.0));
	var[3][0][0] = (mat3x4(-7.0, 5.0, 0.0, 7.0, -3.0, -3.0, 9.0, -4.0, -5.0, 0.0, -5.0, -9.0));
	var[3][0][1] = (mat3x4(-9.0, 6.0, 9.0, 3.0, -8.0, -4.0, -4.0, -2.0, 0.0, 8.0, 4.0, 6.0));
	var[3][0][2] = (mat3x4(6.0, -1.0, -8.0, 6.0, -1.0, 6.0, -3.0, 2.0, -3.0, -7.0, -8.0, -5.0));
	var[3][1][0] = (mat3x4(-5.0, 8.0, 4.0, -4.0, 9.0, -2.0, 1.0, -8.0, 1.0, 5.0, 5.0, -2.0));
	var[3][1][1] = (mat3x4(9.0, -1.0, -9.0, 3.0, -9.0, 2.0, 2.0, -6.0, 9.0, 3.0, 9.0, -9.0));
	var[3][1][2] = (mat3x4(4.0, -2.0, 9.0, -7.0, 4.0, -5.0, 3.0, -2.0, 4.0, 0.0, 2.0, -4.0));
}
#version 450
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
	highp mat4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0][0][0], mat4(0.0, 6.0, -9.0, 9.0, -2.0, -7.0, -4.0, -6.0, 1.0, -5.0, 2.0, -7.0, 8.0, 2.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(2.0, 8.0, 1.0, 7.0, -1.0, -6.0, 8.0, -2.0, -2.0, 6.0, -7.0, 7.0, 9.0, -7.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(8.0, 1.0, -9.0, 5.0, -9.0, 5.0, -9.0, -6.0, 2.0, 0.0, -8.0, -6.0, -7.0, 7.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(-9.0, 9.0, -6.0, -5.0, 7.0, -9.0, 5.0, -1.0, 7.0, -9.0, -6.0, 6.0, -2.0, -9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat4(var[0][2][0], mat4(4.0, 9.0, -7.0, -4.0, 6.0, 6.0, 9.0, 9.0, 7.0, 3.0, 6.0, 1.0, 5.0, 1.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4(var[0][2][1], mat4(6.0, 7.0, 4.0, 7.0, 0.0, 3.0, -7.0, -8.0, -9.0, 1.0, 4.0, 2.0, 0.0, -6.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4(var[0][3][0], mat4(-1.0, 4.0, -8.0, -2.0, 4.0, 0.0, -4.0, -1.0, 4.0, -5.0, -8.0, 0.0, 8.0, 4.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat4(var[0][3][1], mat4(2.0, -8.0, 8.0, -6.0, -1.0, -8.0, 9.0, 7.0, 4.0, -2.0, -7.0, 3.0, -9.0, -1.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(-9.0, -4.0, -7.0, -3.0, -5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 6.0, 1.0, -8.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(-5.0, 6.0, 6.0, 7.0, -2.0, -4.0, -7.0, 5.0, 9.0, -9.0, -9.0, -7.0, 6.0, 7.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(9.0, 3.0, -9.0, 0.0, -6.0, -3.0, -3.0, -7.0, -5.0, 3.0, -6.0, 8.0, -4.0, 8.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(0.0, -3.0, -3.0, 1.0, -4.0, 9.0, 7.0, -1.0, -7.0, 0.0, 5.0, -9.0, 7.0, 3.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat4(var[1][2][0], mat4(-7.0, 7.0, -7.0, 6.0, 6.0, -7.0, 3.0, -2.0, -8.0, 6.0, 5.0, 8.0, 5.0, 1.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4(var[1][2][1], mat4(1.0, -3.0, -5.0, -3.0, 4.0, 2.0, -1.0, 8.0, -6.0, 2.0, 6.0, 6.0, 5.0, 4.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1][3][0], mat4(6.0, -4.0, -3.0, -9.0, -3.0, 1.0, -4.0, -5.0, 3.0, -9.0, 9.0, -1.0, -6.0, 8.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat4(var[1][3][1], mat4(-7.0, 8.0, 6.0, 5.0, 7.0, 6.0, 2.0, 2.0, 3.0, -2.0, -1.0, 2.0, 5.0, 3.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(-9.0, -5.0, -8.0, -7.0, -2.0, -1.0, -6.0, 6.0, -7.0, 5.0, -9.0, -3.0, 0.0, 4.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(-1.0, -8.0, -9.0, 2.0, 0.0, -8.0, -5.0, -1.0, -9.0, -4.0, 9.0, 0.0, -8.0, 4.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(8.0, 7.0, -4.0, 9.0, -4.0, -7.0, 2.0, -7.0, 1.0, 0.0, 2.0, 2.0, -5.0, 2.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(6.0, -1.0, 8.0, -1.0, 3.0, 8.0, -1.0, 9.0, 0.0, -8.0, 6.0, -8.0, 9.0, -3.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4(var[2][2][0], mat4(6.0, -2.0, -6.0, 6.0, -1.0, 9.0, 7.0, 9.0, 5.0, -5.0, -5.0, 8.0, -5.0, 7.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4(var[2][2][1], mat4(-8.0, -6.0, 5.0, -5.0, 7.0, -6.0, -4.0, 7.0, 5.0, -4.0, -1.0, 2.0, 6.0, 9.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4(var[2][3][0], mat4(8.0, 6.0, 8.0, 2.0, -4.0, 2.0, 7.0, 7.0, 6.0, 6.0, 7.0, -3.0, 6.0, -1.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4(var[2][3][1], mat4(2.0, -5.0, 8.0, -7.0, -1.0, -5.0, -9.0, 8.0, -6.0, 4.0, 3.0, 9.0, 3.0, -1.0, 0.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4(-6.0, 6.0, -9.0, 9.0, 5.0, -1.0, 2.0, -9.0, 1.0, -5.0, -2.0, -8.0, 8.0, 8.0, 1.0, -8.0));
	var[0][0][1] = (mat4(-6.0, 3.0, -2.0, 2.0, -2.0, 6.0, -2.0, -6.0, 9.0, 1.0, 3.0, -1.0, -2.0, 1.0, 7.0, 0.0));
	var[0][1][0] = (mat4(3.0, -8.0, 9.0, 8.0, 0.0, 3.0, 7.0, 6.0, 4.0, 6.0, 8.0, -9.0, 5.0, 9.0, -4.0, -4.0));
	var[0][1][1] = (mat4(1.0, 0.0, -1.0, 1.0, 7.0, 1.0, -7.0, -6.0, -9.0, 6.0, -5.0, -8.0, 1.0, -3.0, 3.0, 4.0));
	var[0][2][0] = (mat4(-8.0, 4.0, 7.0, 8.0, 2.0, -8.0, -3.0, 3.0, -4.0, 1.0, 2.0, 3.0, -1.0, 1.0, 8.0, -3.0));
	var[0][2][1] = (mat4(0.0, 5.0, -3.0, -5.0, 2.0, 8.0, 7.0, 5.0, 3.0, 8.0, 4.0, -1.0, 5.0, -1.0, -3.0, 5.0));
	var[0][3][0] = (mat4(-6.0, 6.0, 8.0, 4.0, 1.0, 3.0, 4.0, -7.0, -9.0, -3.0, 3.0, -1.0, 8.0, 6.0, 3.0, 3.0));
	var[0][3][1] = (mat4(-8.0, 1.0, -8.0, -4.0, 4.0, -4.0, -8.0, 9.0, 7.0, 7.0, -3.0, -6.0, 5.0, -5.0, -1.0, 7.0));
	var[1][0][0] = (mat4(-7.0, -7.0, 8.0, 1.0, -4.0, 7.0, 8.0, -3.0, 3.0, -4.0, 7.0, -3.0, -2.0, 9.0, -2.0, 6.0));
	var[1][0][1] = (mat4(6.0, -6.0, 8.0, 6.0, 6.0, 3.0, 3.0, 2.0, -4.0, 4.0, 2.0, -3.0, -7.0, -8.0, -6.0, 1.0));
	var[1][1][0] = (mat4(-4.0, 2.0, 6.0, -8.0, 2.0, -4.0, 9.0, -7.0, -6.0, 4.0, 4.0, -2.0, -6.0, 1.0, 2.0, -7.0));
	var[1][1][1] = (mat4(-2.0, 7.0, 4.0, 1.0, 4.0, -4.0, 2.0, 4.0, 2.0, -1.0, -8.0, 0.0, -9.0, 2.0, 8.0, 9.0));
	var[1][2][0] = (mat4(-7.0, 1.0, 5.0, -4.0, 9.0, -1.0, 0.0, 8.0, -3.0, 4.0, 5.0, -5.0, 1.0, -8.0, -1.0, 3.0));
	var[1][2][1] = (mat4(9.0, -4.0, -2.0, 7.0, 1.0, -8.0, 4.0, 2.0, 8.0, 3.0, -2.0, -6.0, 2.0, -7.0, 1.0, 0.0));
	var[1][3][0] = (mat4(9.0, 7.0, -2.0, -4.0, 8.0, 2.0, -9.0, 3.0, -4.0, 5.0, 1.0, -7.0, 4.0, 7.0, 6.0, -4.0));
	var[1][3][1] = (mat4(3.0, 4.0, 2.0, 1.0, -9.0, -3.0, -4.0, 6.0, 9.0, 3.0, 8.0, -1.0, -7.0, -5.0, -3.0, 0.0));
	var[2][0][0] = (mat4(-4.0, -6.0, -2.0, -5.0, -2.0, -9.0, 0.0, 3.0, 9.0, 2.0, -5.0, 5.0, 1.0, 9.0, -1.0, 0.0));
	var[2][0][1] = (mat4(-4.0, 8.0, 6.0, -2.0, 1.0, -1.0, -7.0, -1.0, -1.0, 3.0, -8.0, 4.0, 8.0, 4.0, -3.0, -8.0));
	var[2][1][0] = (mat4(-1.0, -7.0, -2.0, -1.0, 7.0, 1.0, -8.0, -8.0, -3.0, -2.0, 5.0, 7.0, -2.0, -8.0, 8.0, -6.0));
	var[2][1][1] = (mat4(4.0, 3.0, -2.0, -4.0, -1.0, -3.0, -8.0, 3.0, -3.0, 8.0, 1.0, -4.0, -9.0, -7.0, 3.0, 6.0));
	var[2][2][0] = (mat4(5.0, 9.0, 8.0, 8.0, -3.0, 9.0, 9.0, 8.0, 9.0, 7.0, 5.0, 1.0, -6.0, -4.0, -4.0, 4.0));
	var[2][2][1] = (mat4(1.0, 4.0, 7.0, 6.0, -1.0, 2.0, 2.0, 4.0, -1.0, -9.0, 4.0, 4.0, 1.0, -7.0, 7.0, -7.0));
	var[2][3][0] = (mat4(3.0, -6.0, -2.0, 7.0, -7.0, 8.0, -5.0, -9.0, 7.0, 9.0, 7.0, -5.0, -8.0, -4.0, 1.0, -8.0));
	var[2][3][1] = (mat4(-5.0, -6.0, 4.0, 9.0, 2.0, -4.0, 1.0, -3.0, -5.0, -5.0, 1.0, -7.0, 7.0, -1.0, -5.0, 5.0));
}
#version 450
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
layout(scalar, binding = 1) buffer Block
{
	lowp vec2 u;
	mediump uint v;
	S s[];
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
	allOk = compare_uvec2((s[0].a), uvec2(8u, 5u)) && allOk;
	allOk = compare_mat2x4(s[0].b[0], mat2x4(-2.0, 2.0, 7.0, 3.0, -7.0, -2.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat2x4(s[0].b[1], mat2x4(6.0, 0.0, 9.0, 6.0, 1.0, 8.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x4(s[0].b[2], mat2x4(-9.0, -1.0, 5.0, 6.0, 6.0, 0.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat2x4(s[0].b[3], mat2x4(-5.0, -9.0, -5.0, -2.0, 8.0, -4.0, 0.0, -9.0)) && allOk;
	allOk = compare_vec3((s[0].c), vec3(-8.0, -2.0, -4.0)) && allOk;
	allOk = compare_uvec2((s[1].a), uvec2(1u, 1u)) && allOk;
	allOk = compare_mat2x4(s[1].b[0], mat2x4(-5.0, 9.0, 3.0, 7.0, 8.0, 6.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat2x4(s[1].b[1], mat2x4(1.0, 1.0, 8.0, -9.0, -2.0, 8.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat2x4(s[1].b[2], mat2x4(4.0, 0.0, -9.0, 5.0, 8.0, 6.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x4(s[1].b[3], mat2x4(-9.0, -4.0, 0.0, -4.0, -6.0, 1.0, 1.0, 2.0)) && allOk;
	allOk = compare_vec3((s[1].c), vec3(-6.0, -8.0, 7.0)) && allOk;
	allOk = compare_uvec2((s[2].a), uvec2(0u, 5u)) && allOk;
	allOk = compare_mat2x4(s[2].b[0], mat2x4(5.0, -8.0, -4.0, 4.0, -3.0, -2.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat2x4(s[2].b[1], mat2x4(-7.0, 0.0, 1.0, 9.0, -3.0, -2.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2x4(s[2].b[2], mat2x4(-3.0, 4.0, -1.0, 5.0, -6.0, -3.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat2x4(s[2].b[3], mat2x4(-1.0, 4.0, -6.0, -2.0, 8.0, 0.0, 1.0, -2.0)) && allOk;
	allOk = compare_vec3((s[2].c), vec3(-8.0, 6.0, -5.0)) && allOk;
	allOk = compare_uvec2((s[3].a), uvec2(5u, 4u)) && allOk;
	allOk = compare_mat2x4(s[3].b[0], mat2x4(8.0, -1.0, 7.0, 1.0, -8.0, 0.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x4(s[3].b[1], mat2x4(-1.0, -7.0, -6.0, -2.0, 1.0, -8.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(s[3].b[2], mat2x4(-9.0, -8.0, -1.0, 5.0, -3.0, -5.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat2x4(s[3].b[3], mat2x4(4.0, 6.0, 4.0, 6.0, -6.0, -9.0, -4.0, 4.0)) && allOk;
	allOk = compare_vec3((s[3].c), vec3(7.0, 3.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	v = (3u);
	s[0].a = (uvec2(2u, 6u));
	s[0].b[0] = (mat2x4(-6.0, 7.0, 1.0, 8.0, 8.0, 9.0, -7.0, -4.0));
	s[0].b[1] = (mat2x4(0.0, -9.0, -2.0, 7.0, 2.0, 3.0, -7.0, -4.0));
	s[0].b[2] = (mat2x4(2.0, -2.0, -7.0, 3.0, 5.0, 3.0, 1.0, -6.0));
	s[0].b[3] = (mat2x4(-6.0, -6.0, 0.0, -7.0, 4.0, 5.0, -6.0, -8.0));
	s[0].c = (vec3(-5.0, 9.0, 9.0));
	s[1].a = (uvec2(6u, 0u));
	s[1].b[0] = (mat2x4(4.0, -7.0, 5.0, -9.0, 7.0, 8.0, -1.0, -4.0));
	s[1].b[1] = (mat2x4(-3.0, -9.0, -1.0, 4.0, 9.0, 3.0, -6.0, -7.0));
	s[1].b[2] = (mat2x4(-3.0, 5.0, 5.0, 3.0, -1.0, 6.0, -8.0, -1.0));
	s[1].b[3] = (mat2x4(2.0, -5.0, 7.0, 7.0, 7.0, -2.0, -7.0, -3.0));
	s[1].c = (vec3(8.0, 4.0, 4.0));
	s[2].a = (uvec2(6u, 0u));
	s[2].b[0] = (mat2x4(-2.0, 6.0, 4.0, 3.0, -2.0, -9.0, -2.0, -3.0));
	s[2].b[1] = (mat2x4(-4.0, 6.0, -2.0, 9.0, 3.0, -4.0, 4.0, 4.0));
	s[2].b[2] = (mat2x4(8.0, 5.0, 6.0, -7.0, -7.0, 3.0, -6.0, -8.0));
	s[2].b[3] = (mat2x4(5.0, 4.0, -6.0, 8.0, 7.0, -6.0, 9.0, 3.0));
	s[2].c = (vec3(-6.0, -3.0, -4.0));
	s[3].a = (uvec2(2u, 6u));
	s[3].b[0] = (mat2x4(-6.0, 4.0, 2.0, -6.0, -2.0, 9.0, -6.0, -4.0));
	s[3].b[1] = (mat2x4(0.0, 7.0, 9.0, -6.0, 9.0, 0.0, -6.0, -2.0));
	s[3].b[2] = (mat2x4(-7.0, 1.0, 3.0, -6.0, 2.0, -6.0, 4.0, 1.0));
	s[3].b[3] = (mat2x4(-5.0, 8.0, -2.0, 0.0, -6.0, -7.0, -2.0, 3.0));
	s[3].c = (vec3(-8.0, 8.0, 0.0));
}
#version 450
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
	highp float var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].var), 7.0) && allOk;
	allOk = compare_float((block[1].var), -1.0) && allOk;
	allOk = compare_float((block[2].var), -6.0) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (-2.0);
	block[1].var = (4.0);
	block[2].var = (6.0);
}
#version 450
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
	highp int var;
} block[3];

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((block[0].var), 6) && allOk;
	allOk = compare_int((block[1].var), 0) && allOk;
	allOk = compare_int((block[2].var), 9) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (8);
	block[1].var = (2);
	block[2].var = (-5);
}
#version 450
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
	highp mat2x3 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(block[0].var, mat2x3(-2.0, 3.0, -3.0, 8.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block[1].var, mat2x3(-4.0, -6.0, -3.0, -8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block[2].var, mat2x3(1.0, -5.0, 8.0, -3.0, 0.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat2x3(0.0, 4.0, 4.0, 5.0, -5.0, 2.0));
	block[1].var = (mat2x3(8.0, -1.0, -2.0, -7.0, -8.0, -2.0));
	block[2].var = (mat2x3(2.0, -2.0, 7.0, -9.0, 7.0, -7.0));
}
#version 450
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
	highp mat4 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), 3.0) && allOk;
	allOk = compare_mat4(block[0].var, mat4(8.0, 5.0, -7.0, -4.0, 0.0, -1.0, -9.0, 2.0, 9.0, 5.0, 5.0, 6.0, 9.0, 8.0, -9.0, 8.0)) && allOk;
	allOk = compare_float((block[1].padding), 1.0) && allOk;
	allOk = compare_mat4(block[1].var, mat4(-3.0, 1.0, 0.0, -7.0, -4.0, 0.0, 1.0, -6.0, -7.0, 5.0, 2.0, 0.0, 7.0, 9.0, -5.0, 8.0)) && allOk;
	allOk = compare_float((block[2].padding), 2.0) && allOk;
	allOk = compare_mat4(block[2].var, mat4(3.0, 8.0, -6.0, 7.0, 9.0, -3.0, 7.0, -8.0, -5.0, 6.0, 4.0, -9.0, 6.0, 7.0, 0.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-7.0);
	block[0].var[0] = (vec4(-2.0, 7.0, -7.0, 2.0));
	block[0].var[1] = (vec4(-4.0, 3.0, -5.0, 2.0));
	block[0].var[2] = (vec4(3.0, 8.0, 8.0, 3.0));
	block[0].var[3] = (vec4(0.0, -4.0, -1.0, -3.0));
	block[1].padding = (0.0);
	block[1].var[0] = (vec4(8.0, 1.0, -8.0, 9.0));
	block[1].var[1] = (vec4(2.0, 7.0, -2.0, -7.0));
	block[1].var[2] = (vec4(-9.0, 1.0, 6.0, -9.0));
	block[1].var[3] = (vec4(-1.0, -5.0, -6.0, -3.0));
	block[2].padding = (7.0);
	block[2].var[0] = (vec4(-1.0, 0.0, -1.0, -2.0));
	block[2].var[1] = (vec4(1.0, -3.0, -1.0, -4.0));
	block[2].var[2] = (vec4(7.0, -3.0, 1.0, 1.0));
	block[2].var[3] = (vec4(-9.0, -3.0, 2.0, 9.0));
}
#version 450
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
	highp mat4x3 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), -2.0) && allOk;
	allOk = compare_mat4x3(block[0].var, mat4x3(9.0, -7.0, -7.0, 8.0, 2.0, 7.0, 3.0, -1.0, -1.0, 8.0, 0.0, 9.0)) && allOk;
	allOk = compare_float((block[1].padding), -8.0) && allOk;
	allOk = compare_mat4x3(block[1].var, mat4x3(-8.0, -8.0, -4.0, 5.0, -9.0, 2.0, -7.0, -6.0, -6.0, -6.0, 3.0, 4.0)) && allOk;
	allOk = compare_float((block[2].padding), 9.0) && allOk;
	allOk = compare_mat4x3(block[2].var, mat4x3(9.0, 2.0, 9.0, 1.0, 9.0, 1.0, -4.0, -7.0, 6.0, -3.0, -7.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (1.0);
	block[0].var[0] = (vec3(-7.0, 2.0, 3.0));
	block[0].var[1] = (vec3(1.0, -2.0, -1.0));
	block[0].var[2] = (vec3(-5.0, -1.0, 9.0));
	block[0].var[3] = (vec3(3.0, -7.0, 8.0));
	block[1].padding = (4.0);
	block[1].var[0] = (vec3(7.0, 6.0, -5.0));
	block[1].var[1] = (vec3(2.0, 6.0, 3.0));
	block[1].var[2] = (vec3(-4.0, 3.0, 2.0));
	block[1].var[3] = (vec3(9.0, -6.0, -3.0));
	block[2].padding = (-5.0);
	block[2].var[0] = (vec3(-4.0, -2.0, 8.0));
	block[2].var[1] = (vec3(7.0, -1.0, -1.0));
	block[2].var[2] = (vec3(-3.0, -7.0, -4.0));
	block[2].var[3] = (vec3(3.0, 4.0, 8.0));
}
#version 450
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
	highp float a;
	mediump int b[1];
	lowp float c[1];
	highp int d;
};
layout(std140, binding = 2) readonly buffer BlockC
{
	mediump uint e;
	mediump float f;
	mediump uint g;
	mediump int h;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((d), 9) && allOk;
	allOk = compare_uint((blockC.e), 6u) && allOk;
	allOk = compare_int((blockC.h), 9) && allOk;
    if (allOk)
        ac_numPassed++;

	b[0] = (4);
	c[0] = (-4.0);
	d = (-7);
}
#version 450
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
	mediump uvec2 a[1];
	lowp mat3x2 b;
	highp int c;
	bvec4 d[];
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	bvec3 e;
	highp uvec4 f[];
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	bvec2 g;
	bvec3 h;
	highp vec4 i[];
} blockD;
layout(std430, column_major, binding = 4) buffer BlockE
{
	mediump mat3x2 j;
	highp int k;
	highp vec2 l[1];
	highp uint m[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((a[0]), uvec2(3u, 1u)) && allOk;
	allOk = compare_int((c), -5) && allOk;
	allOk = compare_bvec2((blockD.g), bvec2(true, true)) && allOk;
	allOk = compare_bvec3((blockD.h), bvec3(false, true, false)) && allOk;
	allOk = compare_mat3x2(blockE.j, mat3x2(-1.0, 7.0, 9.0, 1.0, -8.0, 1.0)) && allOk;
	allOk = compare_vec2((blockE.l[0]), vec2(-5.0, 3.0)) && allOk;
	allOk = compare_uint((blockE.m[0]), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (mat3x2(-9.0, 8.0, -7.0, 4.0, -8.0, 6.0));
	c = (-5);
	blockC.f[0] = (uvec4(8u, 2u, 9u, 0u));
	blockD.g = (bvec2(false, true));
	blockD.h = (bvec3(true, false, false));
	blockD.i[0] = (vec4(-2.0, 5.0, 0.0, -1.0));
	blockE.j = (mat3x2(5.0, 4.0, -9.0, -1.0, -1.0, 7.0));
	blockE.l[0] = (vec2(-7.0, 7.0));
	blockE.m[0] = (4u);
}
#version 450
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
	highp uvec2 a;
	bvec2 b[4];
	highp mat4x3 c;
	lowp int d[][8][3];
} blockB;
layout(scalar, row_major, binding = 2) buffer BlockC
{
	highp ivec2 e;
	lowp int f;
	mediump vec4 g;
	bvec2 h;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a), uvec2(4u, 9u)) && allOk;
	allOk = compare_bvec2((blockB.b[0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockB.b[1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockB.b[2]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockB.b[3]), bvec2(false, true)) && allOk;
	allOk = compare_mat4x3(blockB.c, mat4x3(0.0, 9.0, 9.0, 0.0, 3.0, -2.0, 5.0, -8.0, 0.0, -8.0, -4.0, 3.0)) && allOk;
	allOk = compare_int((blockC.f), -5) && allOk;
	allOk = compare_vec4((blockC.g), vec4(3.0, 6.0, 9.0, 8.0)) && allOk;
	allOk = compare_bvec2((blockC.h), bvec2(false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec2(8u, 0u));
	blockB.b[0] = (bvec2(false, true));
	blockB.b[1] = (bvec2(false, true));
	blockB.b[2] = (bvec2(true, false));
	blockB.b[3] = (bvec2(true, false));
	blockB.c = (mat4x3(-4.0, -1.0, 6.0, 4.0, -2.0, 0.0, -6.0, -3.0, 6.0, 9.0, 5.0, 1.0));
	blockB.d[0][0][0] = (8);
	blockB.d[0][0][1] = (-4);
	blockB.d[0][0][2] = (-4);
	blockB.d[0][1][0] = (-7);
	blockB.d[0][1][1] = (2);
	blockB.d[0][1][2] = (-1);
	blockB.d[0][2][0] = (-6);
	blockB.d[0][2][1] = (-1);
	blockB.d[0][2][2] = (-9);
	blockB.d[0][3][0] = (6);
	blockB.d[0][3][1] = (-1);
	blockB.d[0][3][2] = (7);
	blockB.d[0][4][0] = (8);
	blockB.d[0][4][1] = (-4);
	blockB.d[0][4][2] = (5);
	blockB.d[0][5][0] = (-3);
	blockB.d[0][5][1] = (-2);
	blockB.d[0][5][2] = (7);
	blockB.d[0][6][0] = (-8);
	blockB.d[0][6][1] = (-1);
	blockB.d[0][6][2] = (-7);
	blockB.d[0][7][0] = (-7);
	blockB.d[0][7][1] = (-6);
	blockB.d[0][7][2] = (-3);
	blockB.d[1][0][0] = (-4);
	blockB.d[1][0][1] = (-2);
	blockB.d[1][0][2] = (-2);
	blockB.d[1][1][0] = (9);
	blockB.d[1][1][1] = (0);
	blockB.d[1][1][2] = (9);
	blockB.d[1][2][0] = (-4);
	blockB.d[1][2][1] = (-6);
	blockB.d[1][2][2] = (9);
	blockB.d[1][3][0] = (5);
	blockB.d[1][3][1] = (-9);
	blockB.d[1][3][2] = (7);
	blockB.d[1][4][0] = (-1);
	blockB.d[1][4][1] = (0);
	blockB.d[1][4][2] = (0);
	blockB.d[1][5][0] = (4);
	blockB.d[1][5][1] = (-1);
	blockB.d[1][5][2] = (9);
	blockB.d[1][6][0] = (-7);
	blockB.d[1][6][1] = (1);
	blockB.d[1][6][2] = (-3);
	blockB.d[1][7][0] = (5);
	blockB.d[1][7][1] = (9);
	blockB.d[1][7][2] = (6);
	blockB.d[2][0][0] = (-5);
	blockB.d[2][0][1] = (-9);
	blockB.d[2][0][2] = (9);
	blockB.d[2][1][0] = (6);
	blockB.d[2][1][1] = (-2);
	blockB.d[2][1][2] = (8);
	blockB.d[2][2][0] = (6);
	blockB.d[2][2][1] = (-8);
	blockB.d[2][2][2] = (-8);
	blockB.d[2][3][0] = (-8);
	blockB.d[2][3][1] = (-1);
	blockB.d[2][3][2] = (-8);
	blockB.d[2][4][0] = (1);
	blockB.d[2][4][1] = (9);
	blockB.d[2][4][2] = (-7);
	blockB.d[2][5][0] = (-5);
	blockB.d[2][5][1] = (7);
	blockB.d[2][5][2] = (7);
	blockB.d[2][6][0] = (5);
	blockB.d[2][6][1] = (-6);
	blockB.d[2][6][2] = (-2);
	blockB.d[2][7][0] = (-5);
	blockB.d[2][7][1] = (0);
	blockB.d[2][7][2] = (-9);
	blockB.d[3][0][0] = (6);
	blockB.d[3][0][1] = (3);
	blockB.d[3][0][2] = (7);
	blockB.d[3][1][0] = (0);
	blockB.d[3][1][1] = (4);
	blockB.d[3][1][2] = (2);
	blockB.d[3][2][0] = (8);
	blockB.d[3][2][1] = (6);
	blockB.d[3][2][2] = (0);
	blockB.d[3][3][0] = (-6);
	blockB.d[3][3][1] = (-5);
	blockB.d[3][3][2] = (-7);
	blockB.d[3][4][0] = (2);
	blockB.d[3][4][1] = (6);
	blockB.d[3][4][2] = (8);
	blockB.d[3][5][0] = (-7);
	blockB.d[3][5][1] = (-6);
	blockB.d[3][5][2] = (4);
	blockB.d[3][6][0] = (2);
	blockB.d[3][6][1] = (-7);
	blockB.d[3][6][2] = (-8);
	blockB.d[3][7][0] = (-1);
	blockB.d[3][7][1] = (5);
	blockB.d[3][7][2] = (-7);
	blockB.d[4][0][0] = (-6);
	blockB.d[4][0][1] = (-1);
	blockB.d[4][0][2] = (-3);
	blockB.d[4][1][0] = (-5);
	blockB.d[4][1][1] = (-5);
	blockB.d[4][1][2] = (2);
	blockB.d[4][2][0] = (-7);
	blockB.d[4][2][1] = (-6);
	blockB.d[4][2][2] = (-9);
	blockB.d[4][3][0] = (-4);
	blockB.d[4][3][1] = (6);
	blockB.d[4][3][2] = (-2);
	blockB.d[4][4][0] = (4);
	blockB.d[4][4][1] = (-2);
	blockB.d[4][4][2] = (4);
	blockB.d[4][5][0] = (-7);
	blockB.d[4][5][1] = (-7);
	blockB.d[4][5][2] = (9);
	blockB.d[4][6][0] = (-7);
	blockB.d[4][6][1] = (-7);
	blockB.d[4][6][2] = (-7);
	blockB.d[4][7][0] = (-5);
	blockB.d[4][7][1] = (2);
	blockB.d[4][7][2] = (-2);
	blockB.d[5][0][0] = (-2);
	blockB.d[5][0][1] = (9);
	blockB.d[5][0][2] = (-6);
	blockB.d[5][1][0] = (-5);
	blockB.d[5][1][1] = (0);
	blockB.d[5][1][2] = (-2);
	blockB.d[5][2][0] = (-7);
	blockB.d[5][2][1] = (1);
	blockB.d[5][2][2] = (2);
	blockB.d[5][3][0] = (-6);
	blockB.d[5][3][1] = (7);
	blockB.d[5][3][2] = (5);
	blockB.d[5][4][0] = (-3);
	blockB.d[5][4][1] = (-6);
	blockB.d[5][4][2] = (2);
	blockB.d[5][5][0] = (7);
	blockB.d[5][5][1] = (6);
	blockB.d[5][5][2] = (-1);
	blockB.d[5][6][0] = (-3);
	blockB.d[5][6][1] = (-3);
	blockB.d[5][6][2] = (-9);
	blockB.d[5][7][0] = (-1);
	blockB.d[5][7][1] = (7);
	blockB.d[5][7][2] = (-8);
	blockB.d[6][0][0] = (1);
	blockB.d[6][0][1] = (6);
	blockB.d[6][0][2] = (7);
	blockB.d[6][1][0] = (-3);
	blockB.d[6][1][1] = (-3);
	blockB.d[6][1][2] = (5);
	blockB.d[6][2][0] = (3);
	blockB.d[6][2][1] = (-7);
	blockB.d[6][2][2] = (-5);
	blockB.d[6][3][0] = (4);
	blockB.d[6][3][1] = (0);
	blockB.d[6][3][2] = (9);
	blockB.d[6][4][0] = (-7);
	blockB.d[6][4][1] = (9);
	blockB.d[6][4][2] = (5);
	blockB.d[6][5][0] = (-7);
	blockB.d[6][5][1] = (-6);
	blockB.d[6][5][2] = (-1);
	blockB.d[6][6][0] = (3);
	blockB.d[6][6][1] = (1);
	blockB.d[6][6][2] = (3);
	blockB.d[6][7][0] = (7);
	blockB.d[6][7][1] = (3);
	blockB.d[6][7][2] = (-8);
	blockC.f = (2);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, column_major, binding = 1) readonly buffer BlockB
{
	highp mat2x3 a;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB[nonuniformEXT(0)].a, mat2x3(-7.0, 3.0, 4.0, -6.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat2x3(blockB[nonuniformEXT(1)].a, mat2x3(6.0, -9.0, 6.0, -2.0, -7.0, -1.0)) && allOk;
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

layout(std140, row_major, binding = 1) buffer BlockB
{
	lowp vec4 a;
	highp mat2x3 b;
	uint16_t c;
};
layout(std430, column_major, binding = 2) buffer BlockC
{
	lowp ivec4 d;
	i16vec3 e[1];
	float16_t f;
};
layout(std140, binding = 3) readonly buffer BlockD
{
	u16vec4 g;
} blockD;
layout(std140, row_major, binding = 4) readonly buffer BlockE
{
	lowp mat3x2 h;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(b, mat2x3(-1.0, -3.0, -2.0, 0.0, 9.0, 0.0)) && allOk;
	allOk = compare_ivec4((d), ivec4(-3, 2, -3, 8)) && allOk;
	allOk = compare_float16_t(float(f), 5.0) && allOk;
	allOk = compare_u16vec4(uvec4(blockD.g), uvec4(8u, 9u, 0u, 4u)) && allOk;
	allOk = compare_mat3x2(blockE.h, mat3x2(-9.0, 6.0, 7.0, 7.0, 4.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec4(-7.0, 4.0, -4.0, -7.0));
	b = (mat2x3(-3.0, 1.0, 8.0, -9.0, 2.0, -2.0));
	c = uint16_t(6u);
	e[0] = i16vec3(ivec3(-7, 3, 1));
}
#version 450
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
	lowp uvec3 a;
	mediump mat3x4 b;
	uint16_t c;
	highp mat4x2 d[][7];
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	mediump uint e;
	mediump ivec4 f;
	i16vec2 g;
	int16_t h;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a), uvec3(3u, 1u, 9u)) && allOk;
	allOk = compare_uint16_t(uint(blockB.c), 1u) && allOk;
	allOk = compare_mat4x2(blockB.d[0][0], mat4x2(-5.0, 5.0, -6.0, 5.0, -7.0, -4.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[0][1], mat4x2(0.0, 6.0, -7.0, 5.0, -9.0, 3.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[0][2], mat4x2(-2.0, 1.0, -6.0, 0.0, -1.0, 7.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[0][3], mat4x2(-8.0, 1.0, 6.0, -5.0, 3.0, 6.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[0][4], mat4x2(-1.0, -5.0, -3.0, 3.0, 2.0, 1.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[0][5], mat4x2(2.0, -3.0, 4.0, 9.0, -4.0, 9.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[0][6], mat4x2(1.0, -6.0, -7.0, -7.0, 1.0, -6.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[1][0], mat4x2(-1.0, 1.0, -1.0, -8.0, -9.0, 2.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[1][1], mat4x2(-5.0, 5.0, 8.0, 2.0, 7.0, -4.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[1][2], mat4x2(5.0, -9.0, 6.0, 6.0, -7.0, -5.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[1][3], mat4x2(-6.0, 2.0, -8.0, 6.0, 2.0, -6.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[1][4], mat4x2(-2.0, -2.0, -2.0, -2.0, -9.0, 3.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[1][5], mat4x2(-1.0, -3.0, -9.0, -4.0, -2.0, -6.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[1][6], mat4x2(-5.0, -5.0, 9.0, 0.0, 0.0, -8.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[2][0], mat4x2(0.0, -1.0, -8.0, -7.0, -4.0, 4.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[2][1], mat4x2(-1.0, 8.0, 8.0, 4.0, -4.0, 9.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[2][2], mat4x2(6.0, -2.0, -5.0, -1.0, -6.0, 2.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[2][3], mat4x2(-6.0, 2.0, 9.0, -9.0, 8.0, -4.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[2][4], mat4x2(1.0, 1.0, 7.0, 2.0, 9.0, -8.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[2][5], mat4x2(-1.0, 6.0, 4.0, -1.0, -7.0, 2.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[2][6], mat4x2(-5.0, 4.0, -2.0, 0.0, 2.0, 8.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[3][0], mat4x2(-9.0, -5.0, 1.0, 5.0, 9.0, 3.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[3][1], mat4x2(-5.0, 4.0, -9.0, 0.0, -6.0, 7.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[3][2], mat4x2(-6.0, 9.0, 9.0, -9.0, 4.0, 2.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[3][3], mat4x2(7.0, -7.0, 6.0, 7.0, -8.0, 9.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[3][4], mat4x2(-2.0, -9.0, 6.0, 5.0, 5.0, -6.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[3][5], mat4x2(-4.0, 8.0, -7.0, -4.0, -8.0, -7.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[3][6], mat4x2(0.0, 2.0, 1.0, 8.0, -5.0, -6.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[4][0], mat4x2(-4.0, -3.0, -4.0, -3.0, -7.0, 2.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[4][1], mat4x2(6.0, 1.0, 1.0, -1.0, 9.0, 5.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[4][2], mat4x2(0.0, -7.0, -7.0, -2.0, 4.0, -2.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[4][3], mat4x2(-6.0, 8.0, 1.0, -3.0, 6.0, 3.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[4][4], mat4x2(8.0, -5.0, 5.0, -2.0, -3.0, -1.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[4][5], mat4x2(9.0, -4.0, 4.0, 4.0, -2.0, 9.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[4][6], mat4x2(-2.0, -1.0, -2.0, 6.0, 2.0, -4.0, -3.0, -9.0)) && allOk;
	allOk = compare_ivec4((blockC.f), ivec4(8, 3, -9, 4)) && allOk;
	allOk = compare_i16vec2(ivec2(blockC.g), ivec2(3, -2)) && allOk;
	allOk = compare_int16_t(int(blockC.h), -7) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = uint16_t(3u);
	blockB.d[0][0] = (mat4x2(9.0, 3.0, 1.0, -6.0, 4.0, -4.0, -6.0, 9.0));
	blockB.d[0][1] = (mat4x2(3.0, 7.0, 7.0, -8.0, 5.0, -2.0, -7.0, -2.0));
	blockB.d[0][2] = (mat4x2(5.0, 0.0, -1.0, 5.0, 4.0, -9.0, -1.0, -1.0));
	blockB.d[0][3] = (mat4x2(7.0, -1.0, -7.0, 7.0, 4.0, -3.0, 1.0, 6.0));
	blockB.d[0][4] = (mat4x2(5.0, 8.0, 5.0, -1.0, -1.0, -1.0, 2.0, -8.0));
	blockB.d[0][5] = (mat4x2(-1.0, -2.0, -8.0, 1.0, -7.0, -3.0, 3.0, -6.0));
	blockB.d[0][6] = (mat4x2(1.0, -1.0, -1.0, 1.0, 2.0, -5.0, -4.0, 4.0));
	blockB.d[1][0] = (mat4x2(7.0, -2.0, 8.0, -5.0, -9.0, 2.0, 3.0, 1.0));
	blockB.d[1][1] = (mat4x2(-5.0, -2.0, 5.0, -1.0, 0.0, -2.0, 2.0, -7.0));
	blockB.d[1][2] = (mat4x2(-7.0, -7.0, 9.0, -6.0, -8.0, 6.0, 5.0, 3.0));
	blockB.d[1][3] = (mat4x2(2.0, 4.0, -9.0, 9.0, 1.0, 6.0, -8.0, -6.0));
	blockB.d[1][4] = (mat4x2(-8.0, -6.0, -8.0, 7.0, 3.0, -6.0, -5.0, 1.0));
	blockB.d[1][5] = (mat4x2(6.0, 6.0, 4.0, 8.0, 0.0, -8.0, 1.0, -1.0));
	blockB.d[1][6] = (mat4x2(-7.0, 5.0, 9.0, 0.0, -2.0, 1.0, 5.0, -6.0));
	blockB.d[2][0] = (mat4x2(4.0, -2.0, 5.0, -5.0, 6.0, -3.0, -7.0, 6.0));
	blockB.d[2][1] = (mat4x2(8.0, 9.0, 4.0, -7.0, 4.0, -5.0, 4.0, 3.0));
	blockB.d[2][2] = (mat4x2(-6.0, 9.0, -9.0, -4.0, -9.0, 9.0, -7.0, 5.0));
	blockB.d[2][3] = (mat4x2(-3.0, 1.0, 1.0, -9.0, 1.0, 0.0, -6.0, 8.0));
	blockB.d[2][4] = (mat4x2(-7.0, -8.0, -3.0, 7.0, 5.0, 4.0, 5.0, -7.0));
	blockB.d[2][5] = (mat4x2(6.0, 7.0, 6.0, -2.0, 5.0, 8.0, 4.0, -7.0));
	blockB.d[2][6] = (mat4x2(-6.0, 9.0, 7.0, 4.0, -3.0, -3.0, 8.0, 9.0));
	blockB.d[3][0] = (mat4x2(-5.0, -2.0, 7.0, 5.0, 4.0, -4.0, 2.0, -1.0));
	blockB.d[3][1] = (mat4x2(2.0, 0.0, -5.0, -2.0, 2.0, -5.0, 0.0, -7.0));
	blockB.d[3][2] = (mat4x2(4.0, 8.0, -4.0, -5.0, -8.0, -1.0, 3.0, -8.0));
	blockB.d[3][3] = (mat4x2(-4.0, 5.0, 8.0, -5.0, -3.0, 6.0, -9.0, -6.0));
	blockB.d[3][4] = (mat4x2(1.0, 3.0, 9.0, -2.0, -5.0, 2.0, 2.0, 8.0));
	blockB.d[3][5] = (mat4x2(4.0, -3.0, 4.0, -8.0, -7.0, -9.0, -2.0, -9.0));
	blockB.d[3][6] = (mat4x2(-3.0, -2.0, 0.0, 6.0, -4.0, 8.0, -1.0, 0.0));
	blockB.d[4][0] = (mat4x2(2.0, -2.0, 5.0, -6.0, 1.0, -4.0, 9.0, 0.0));
	blockB.d[4][1] = (mat4x2(8.0, 6.0, -5.0, 5.0, -3.0, -8.0, 7.0, 0.0));
	blockB.d[4][2] = (mat4x2(-3.0, 1.0, -1.0, 0.0, 0.0, -5.0, -5.0, 5.0));
	blockB.d[4][3] = (mat4x2(1.0, -6.0, -9.0, -5.0, 6.0, 1.0, 3.0, 9.0));
	blockB.d[4][4] = (mat4x2(-1.0, -3.0, 9.0, 6.0, -9.0, -8.0, -4.0, -2.0));
	blockB.d[4][5] = (mat4x2(-5.0, -3.0, 6.0, 5.0, -9.0, -6.0, 4.0, 2.0));
	blockB.d[4][6] = (mat4x2(0.0, -4.0, 2.0, 3.0, -2.0, -8.0, 8.0, 1.0));
	blockC.h = int16_t(2);
}
#version 450
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
	bvec2 mB;
	highp vec3 mC;
};
struct sB
{
	bool mA;
};
struct sC
{
	u16vec4 mA;
	highp uvec4 mB;
	sB mC;
};
struct sD
{
	i16vec2 mA;
	highp mat4x3 mB;
	f16vec4 mC;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	sA a[];
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	lowp mat3x4 b;
	sC c;
	f16vec4 d;
	highp float e;
	sD f[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((a[0].mA), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((a[0].mB), bvec2(false, true)) && allOk;
	allOk = compare_vec3((a[0].mC), vec3(6.0, -1.0, 5.0)) && allOk;
	allOk = compare_u16vec4(uvec4(c.mA), uvec4(4u, 4u, 4u, 0u)) && allOk;
	allOk = compare_uvec4((c.mB), uvec4(6u, 9u, 7u, 7u)) && allOk;
	allOk = compare_bool((c.mC.mA), true) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0].mA = (bvec2(true, true));
	a[0].mB = (bvec2(true, true));
	a[0].mC = (vec3(-8.0, 8.0, -3.0));
	b = (mat3x4(3.0, 6.0, -6.0, 2.0, -3.0, 9.0, -1.0, -3.0, -1.0, 5.0, -2.0, -9.0));
	e = (7.0);
}
#version 450
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
	mediump vec4 a;
	mediump float b[2];
	lowp vec2 c;
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	highp mat3x2 d;
	lowp ivec2 e[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((b[0]), 4.0) && allOk;
	allOk = compare_float((b[1]), 7.0) && allOk;
	allOk = compare_ivec2((blockC.e[0]), ivec2(-2, -5)) && allOk;
	allOk = compare_ivec2((blockC.e[1]), ivec2(1, 0)) && allOk;
	allOk = compare_ivec2((blockC.e[2]), ivec2(3, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec4(7.0, -6.0, 8.0, 6.0));
	c = (vec2(8.0, 1.0));
	blockC.e[0] = (ivec2(-2, -9));
	blockC.e[1] = (ivec2(8, 3));
	blockC.e[2] = (ivec2(4, 9));
}
#version 450
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
	i16vec2 a;
	bool b[];
} blockB;

bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(blockB.a), ivec2(-7, 3)) && allOk;
	allOk = compare_bool((blockB.b[0]), false) && allOk;
	allOk = compare_bool((blockB.b[1]), false) && allOk;
	allOk = compare_bool((blockB.b[2]), true) && allOk;
	allOk = compare_bool((blockB.b[3]), false) && allOk;
	allOk = compare_bool((blockB.b[4]), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i16vec2(ivec2(0, -2));
	blockB.b[0] = (true);
	blockB.b[1] = (true);
	blockB.b[2] = (true);
	blockB.b[3] = (false);
	blockB.b[4] = (true);
}
#version 450
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
	layout(offset = 0) lowp ivec2 a;
	layout(offset = 8) u16vec3 b;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) f16vec2 c;
	layout(offset = 4) int16_t d;
	layout(offset = 16) bvec3 e;
	layout(offset = 28) lowp float f[1];
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) i16vec4 g;
	layout(offset = 16) highp ivec4 h;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((a), ivec2(-9, 9)) && allOk;
	allOk = compare_u16vec3(uvec3(b), uvec3(4u, 6u, 7u)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.c), vec2(5.0, 5.0)) && allOk;
	allOk = compare_int16_t(int(blockC.d), -5) && allOk;
	allOk = compare_bvec3((blockC.e), bvec3(false, false, false)) && allOk;
	allOk = compare_float((blockC.f[0]), -6.0) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (ivec2(-9, -3));
	b = u16vec3(uvec3(1u, 4u, 8u));
	blockC.c = f16vec2(vec2(9.0, -5.0));
	blockC.d = int16_t(2);
	blockC.f[0] = (8.0);
	g = i16vec4(ivec4(5, -5, 8, -1));
	h = (ivec4(7, -9, -3, -1));
}
#version 450
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
	layout(offset = 0) float16_t a;
	layout(offset = 4) highp uvec2 b;
	layout(offset = 16) f16vec3 c;
	layout(offset = 22) f16vec2 d;
	layout(offset = 32) highp ivec4 e[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(a), -8.0) && allOk;
	allOk = compare_uvec2((b), uvec2(5u, 4u)) && allOk;
	allOk = compare_f16vec3(vec3(c), vec3(-9.0, -1.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (uvec2(5u, 4u));
	c = f16vec3(vec3(-1.0, -2.0, 7.0));
	d = f16vec2(vec2(-7.0, -6.0));
	e[0] = (ivec4(-5, -9, 4, -6));
}
#version 450
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
	int16_t mA;
	highp mat2x3 mB;
	bvec3 mC;
};
layout(scalar, binding = 1) buffer BlockB
{
	mediump uvec4 a;
	mediump mat4x3 b;
	highp int c;
	i16vec4 d;
	float16_t e[][8];
} blockB;
layout(scalar, binding = 2) buffer BlockC
{
	int16_t f;
	i16vec2 g;
	highp mat3x4 h;
	mediump mat3x2 i;
};
layout(scalar, column_major, binding = 3) buffer BlockD
{
	f16vec4 j;
	bvec2 k;
	float16_t l;
	float16_t m;
	i16vec2 n[];
} blockD[3];
layout(scalar, binding = 4) buffer BlockE
{
	sA o[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.b, mat4x3(1.0, -2.0, -8.0, -7.0, -4.0, -2.0, -4.0, -5.0, -1.0, 2.0, -2.0, -4.0)) && allOk;
	allOk = compare_int((blockB.c), 7) && allOk;
	allOk = compare_i16vec4(ivec4(blockB.d), ivec4(-1, -1, -9, 4)) && allOk;
	allOk = compare_float16_t(float(blockB.e[0][0]), 0.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[0][1]), -1.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[0][2]), -5.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[0][3]), 7.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[0][4]), 6.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[0][5]), 7.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[0][6]), -4.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[0][7]), -4.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[1][0]), 3.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[1][1]), -2.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[1][2]), -9.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[1][3]), 9.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[1][4]), -3.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[1][5]), -9.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[1][6]), -5.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[1][7]), 8.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[2][0]), -2.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[2][1]), 1.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[2][2]), 7.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[2][3]), 6.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[2][4]), 6.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[2][5]), 2.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[2][6]), 7.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[2][7]), 0.0) && allOk;
	allOk = compare_int16_t(int(f), -1) && allOk;
	allOk = compare_i16vec2(ivec2(g), ivec2(7, 5)) && allOk;
	allOk = compare_mat3x4(h, mat3x4(-2.0, 6.0, -7.0, 2.0, -1.0, -1.0, -6.0, 3.0, 9.0, 1.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat3x2(i, mat3x2(-4.0, 5.0, 7.0, 4.0, -8.0, -3.0)) && allOk;
	allOk = compare_float16_t(float(blockD[0].l), -3.0) && allOk;
	allOk = compare_float16_t(float(blockD[0].m), 3.0) && allOk;
	allOk = compare_float16_t(float(blockD[1].l), 7.0) && allOk;
	allOk = compare_float16_t(float(blockD[1].m), -8.0) && allOk;
	allOk = compare_float16_t(float(blockD[2].l), 9.0) && allOk;
	allOk = compare_float16_t(float(blockD[2].m), 3.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat4x3(5.0, 9.0, 5.0, -5.0, -6.0, -5.0, 9.0, 0.0, 6.0, 2.0, 7.0, 9.0));
	blockB.c = (-4);
	blockB.d = i16vec4(ivec4(-5, -1, -4, -4));
	blockB.e[0][0] = float16_t(2.0);
	blockB.e[0][1] = float16_t(4.0);
	blockB.e[0][2] = float16_t(-3.0);
	blockB.e[0][3] = float16_t(-5.0);
	blockB.e[0][4] = float16_t(-9.0);
	blockB.e[0][5] = float16_t(3.0);
	blockB.e[0][6] = float16_t(7.0);
	blockB.e[0][7] = float16_t(6.0);
	blockB.e[1][0] = float16_t(3.0);
	blockB.e[1][1] = float16_t(-4.0);
	blockB.e[1][2] = float16_t(-1.0);
	blockB.e[1][3] = float16_t(6.0);
	blockB.e[1][4] = float16_t(1.0);
	blockB.e[1][5] = float16_t(-3.0);
	blockB.e[1][6] = float16_t(-4.0);
	blockB.e[1][7] = float16_t(-9.0);
	blockB.e[2][0] = float16_t(-2.0);
	blockB.e[2][1] = float16_t(1.0);
	blockB.e[2][2] = float16_t(-8.0);
	blockB.e[2][3] = float16_t(3.0);
	blockB.e[2][4] = float16_t(-8.0);
	blockB.e[2][5] = float16_t(0.0);
	blockB.e[2][6] = float16_t(2.0);
	blockB.e[2][7] = float16_t(4.0);
	f = int16_t(2);
	g = i16vec2(ivec2(-3, -1));
	h = (mat3x4(5.0, -5.0, 8.0, -4.0, 9.0, 2.0, -6.0, 8.0, 1.0, -5.0, -1.0, -4.0));
	i = (mat3x2(5.0, 2.0, -9.0, 2.0, 2.0, 1.0));
	blockD[0].k = (bvec2(true, true));
	blockD[0].l = float16_t(-5.0);
	blockD[0].n[0] = i16vec2(ivec2(-1, -3));
	blockD[1].k = (bvec2(true, false));
	blockD[1].l = float16_t(9.0);
	blockD[1].n[0] = i16vec2(ivec2(-5, -9));
	blockD[1].n[1] = i16vec2(ivec2(8, 5));
	blockD[1].n[2] = i16vec2(ivec2(-8, 2));
	blockD[1].n[3] = i16vec2(ivec2(3, -5));
	blockD[1].n[4] = i16vec2(ivec2(2, -3));
	blockD[1].n[5] = i16vec2(ivec2(-6, 1));
	blockD[1].n[6] = i16vec2(ivec2(5, -4));
	blockD[1].n[7] = i16vec2(ivec2(-2, -9));
	blockD[2].k = (bvec2(false, false));
	blockD[2].l = float16_t(9.0);
	blockD[2].n[0] = i16vec2(ivec2(5, -4));
	blockD[2].n[1] = i16vec2(ivec2(-3, 7));
	blockD[2].n[2] = i16vec2(ivec2(-3, 9));
	blockD[2].n[3] = i16vec2(ivec2(-6, 7));
	blockE.o[0].mA = int16_t(-7);
	blockE.o[0].mB = (mat2x3(8.0, -7.0, 1.0, -8.0, 4.0, 5.0));
	blockE.o[0].mC = (bvec3(true, true, false));
	blockE.o[1].mA = int16_t(2);
	blockE.o[1].mB = (mat2x3(-3.0, 7.0, -6.0, 6.0, 7.0, 2.0));
	blockE.o[1].mC = (bvec3(false, true, false));
}
#version 450
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
	mediump uint mB[5];
	int16_t mC;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	mediump mat3 a;
	highp float b;
	sA c;
	lowp mat3x2 d[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(a, mat3(-1.0, -5.0, -9.0, -9.0, -9.0, 0.0, 8.0, -9.0, -1.0)) && allOk;
	allOk = compare_float((b), 6.0) && allOk;
	allOk = compare_mat3x2(d[0], mat3x2(4.0, -5.0, 3.0, 0.0, -7.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat3(0.0, -7.0, -2.0, -6.0, 0.0, 4.0, -5.0, 5.0, -3.0));
	b = (4.0);
	c.mA = (mat4x3(9.0, 1.0, -6.0, 4.0, -7.0, 9.0, 7.0, -4.0, -8.0, -7.0, 9.0, 7.0));
	c.mB[0] = (4u);
	c.mB[1] = (1u);
	c.mB[2] = (6u);
	c.mB[3] = (7u);
	c.mB[4] = (4u);
	c.mC = int16_t(8);
	d[0] = (mat3x2(-4.0, -3.0, -3.0, 9.0, -8.0, 0.0));
}
#version 450
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
	u16vec3 mA;
};
layout(scalar, row_major, binding = 1) readonly buffer BlockB
{
	sA a;
	lowp vec4 b[][8];
} blockB[1];
layout(scalar, column_major, binding = 2) buffer BlockC
{
	i16vec3 c;
	highp vec3 d;
	mediump mat2 e[];
} blockC;
layout(scalar, row_major, binding = 3) buffer BlockD
{
	bvec4 f;
	float16_t g;
	u16vec3 h;
	highp mat3x4 i[];
} blockD[2];
layout(scalar, binding = 4) buffer BlockE
{
	highp mat4 j;
	i16vec4 k[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB[0].b[0][0]), vec4(-6.0, 4.0, -7.0, -1.0)) && allOk;
	allOk = compare_vec4((blockB[0].b[0][1]), vec4(-2.0, 2.0, -9.0, -1.0)) && allOk;
	allOk = compare_vec4((blockB[0].b[0][2]), vec4(-4.0, -8.0, 7.0, -8.0)) && allOk;
	allOk = compare_vec4((blockB[0].b[0][3]), vec4(-5.0, -8.0, 6.0, 9.0)) && allOk;
	allOk = compare_vec4((blockB[0].b[0][4]), vec4(4.0, 5.0, -9.0, 0.0)) && allOk;
	allOk = compare_vec4((blockB[0].b[0][5]), vec4(1.0, 9.0, 8.0, 1.0)) && allOk;
	allOk = compare_vec4((blockB[0].b[0][6]), vec4(6.0, 2.0, 3.0, -1.0)) && allOk;
	allOk = compare_vec4((blockB[0].b[0][7]), vec4(-9.0, -6.0, -3.0, -4.0)) && allOk;
	allOk = compare_vec4((blockB[0].b[1][0]), vec4(-8.0, -7.0, 0.0, -2.0)) && allOk;
	allOk = compare_vec4((blockB[0].b[1][1]), vec4(-1.0, 8.0, 6.0, -7.0)) && allOk;
	allOk = compare_vec4((blockB[0].b[1][2]), vec4(9.0, -3.0, -5.0, -4.0)) && allOk;
	allOk = compare_vec4((blockB[0].b[1][3]), vec4(8.0, 8.0, -6.0, 2.0)) && allOk;
	allOk = compare_vec4((blockB[0].b[1][4]), vec4(-9.0, 9.0, -5.0, -7.0)) && allOk;
	allOk = compare_vec4((blockB[0].b[1][5]), vec4(6.0, -2.0, -1.0, 3.0)) && allOk;
	allOk = compare_vec4((blockB[0].b[1][6]), vec4(-6.0, 3.0, -7.0, -8.0)) && allOk;
	allOk = compare_vec4((blockB[0].b[1][7]), vec4(-9.0, 5.0, -7.0, 4.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockC.c), ivec3(-5, -3, -7)) && allOk;
	allOk = compare_vec3((blockC.d), vec3(-8.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat2(blockC.e[0], mat2(3.0, 4.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat2(blockC.e[1], mat2(-8.0, -3.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat2(blockC.e[2], mat2(1.0, 6.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat2(blockC.e[3], mat2(2.0, 5.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat2(blockC.e[4], mat2(4.0, -7.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].i[0], mat3x4(6.0, 5.0, 2.0, 8.0, -1.0, -1.0, 6.0, 4.0, 1.0, 5.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].i[1], mat3x4(-6.0, 4.0, -6.0, 2.0, -4.0, 8.0, -4.0, -7.0, 4.0, -5.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].i[2], mat3x4(-8.0, -2.0, 7.0, -6.0, -4.0, -2.0, -5.0, -9.0, 3.0, 5.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].i[3], mat3x4(-1.0, 9.0, 4.0, 3.0, -1.0, 0.0, -7.0, -7.0, -8.0, -9.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].i[4], mat3x4(-2.0, 9.0, -8.0, 6.0, 3.0, -9.0, -9.0, 0.0, 5.0, -1.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat3x4(blockD[1].i[0], mat3x4(4.0, 3.0, 3.0, 9.0, -3.0, 8.0, -6.0, 9.0, 8.0, 9.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat3x4(blockD[1].i[1], mat3x4(-9.0, 9.0, 3.0, -1.0, 0.0, -4.0, -4.0, -7.0, -6.0, -1.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x4(blockD[1].i[2], mat3x4(-6.0, -9.0, 7.0, 1.0, -2.0, 7.0, -6.0, -8.0, -6.0, -9.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3x4(blockD[1].i[3], mat3x4(-4.0, -4.0, -5.0, -1.0, -3.0, 8.0, -1.0, 7.0, -9.0, 3.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat3x4(blockD[1].i[4], mat3x4(3.0, -2.0, -5.0, 8.0, -1.0, -1.0, -4.0, 3.0, 5.0, 5.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3x4(blockD[1].i[5], mat3x4(0.0, 9.0, -4.0, 3.0, -5.0, 2.0, 7.0, -6.0, -5.0, -9.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat4(blockE.j, mat4(-9.0, -5.0, -2.0, -1.0, -6.0, -9.0, -7.0, 6.0, 3.0, -2.0, -2.0, 2.0, -5.0, 5.0, -5.0, -7.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockE.k[0]), ivec4(-2, 0, -4, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(blockE.k[1]), ivec4(-8, 9, 3, -9)) && allOk;
	allOk = compare_i16vec4(ivec4(blockE.k[2]), ivec4(-2, -2, 0, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(blockE.k[3]), ivec4(-6, 9, 8, 4)) && allOk;
	allOk = compare_i16vec4(ivec4(blockE.k[4]), ivec4(-3, 1, 7, -3)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.c = i16vec3(ivec3(4, 0, 5));
	blockC.d = (vec3(-7.0, -2.0, -7.0));
	blockC.e[0] = (mat2(-7.0, -2.0, 8.0, -7.0));
	blockC.e[1] = (mat2(-5.0, 0.0, 0.0, -8.0));
	blockC.e[2] = (mat2(4.0, 3.0, 6.0, 1.0));
	blockC.e[3] = (mat2(-1.0, -1.0, -6.0, -6.0));
	blockC.e[4] = (mat2(-8.0, -5.0, 7.0, -5.0));
	blockD[0].g = float16_t(-1.0);
	blockD[0].h = u16vec3(uvec3(0u, 2u, 4u));
	blockD[0].i[0] = (mat3x4(1.0, -8.0, -2.0, 0.0, -3.0, -3.0, -5.0, 4.0, -3.0, 9.0, 8.0, -9.0));
	blockD[0].i[1] = (mat3x4(-3.0, 7.0, 5.0, -1.0, -4.0, 9.0, 0.0, 6.0, 3.0, -1.0, -8.0, -4.0));
	blockD[0].i[2] = (mat3x4(2.0, -1.0, 3.0, 6.0, 5.0, -5.0, 0.0, 8.0, -5.0, 2.0, -3.0, 0.0));
	blockD[0].i[3] = (mat3x4(-3.0, -9.0, 1.0, 4.0, -3.0, 7.0, 0.0, 8.0, 2.0, -8.0, 5.0, 6.0));
	blockD[0].i[4] = (mat3x4(-6.0, -8.0, 5.0, -8.0, -4.0, -8.0, 0.0, -8.0, -5.0, -8.0, -4.0, 5.0));
	blockD[1].g = float16_t(4.0);
	blockD[1].h = u16vec3(uvec3(9u, 3u, 4u));
	blockD[1].i[0] = (mat3x4(-9.0, -4.0, -9.0, 6.0, -6.0, -1.0, 4.0, 1.0, -4.0, -9.0, -2.0, 8.0));
	blockD[1].i[1] = (mat3x4(5.0, -3.0, 6.0, 0.0, -9.0, 7.0, -6.0, -4.0, 0.0, -8.0, 4.0, 0.0));
	blockD[1].i[2] = (mat3x4(-7.0, 8.0, 1.0, -5.0, -8.0, 2.0, 4.0, -9.0, -2.0, 1.0, -5.0, 7.0));
	blockD[1].i[3] = (mat3x4(-4.0, 7.0, 8.0, 1.0, 7.0, 6.0, -3.0, -8.0, 2.0, -3.0, 7.0, 6.0));
	blockD[1].i[4] = (mat3x4(-3.0, 5.0, -5.0, 6.0, 8.0, 3.0, 9.0, -4.0, -4.0, 1.0, 6.0, 6.0));
	blockD[1].i[5] = (mat3x4(0.0, -1.0, -8.0, -5.0, -9.0, 2.0, 8.0, 4.0, -3.0, -1.0, 4.0, -8.0));
	blockE.j = (mat4(3.0, 0.0, -1.0, 4.0, -8.0, 2.0, -2.0, 9.0, 6.0, -3.0, 0.0, 3.0, -7.0, 4.0, 9.0, 9.0));
	blockE.k[0] = i16vec4(ivec4(1, -2, -4, -9));
	blockE.k[1] = i16vec4(ivec4(4, 7, -3, -2));
	blockE.k[2] = i16vec4(ivec4(6, 2, 3, -9));
	blockE.k[3] = i16vec4(ivec4(8, 8, 0, 5));
	blockE.k[4] = i16vec4(ivec4(-7, -8, 5, 3));
}
#version 450
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
	highp uvec2 a;
	float16_t b;
	i16vec2 c;
} blockB[];

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB[nonuniformEXT(0)].a), uvec2(0u, 2u)) && allOk;
	allOk = compare_float16_t(float(blockB[nonuniformEXT(0)].b), 8.0) && allOk;
	allOk = compare_i16vec2(ivec2(blockB[nonuniformEXT(0)].c), ivec2(0, -4)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(1)].a), uvec2(0u, 9u)) && allOk;
	allOk = compare_float16_t(float(blockB[nonuniformEXT(1)].b), -4.0) && allOk;
	allOk = compare_i16vec2(ivec2(blockB[nonuniformEXT(1)].c), ivec2(-6, -1)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = float16_t(-2.0);
	blockB[nonuniformEXT(1)].b = float16_t(3.0);
}
#version 450
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
	int8_t a;
	bvec2 b;
	highp uint c[1];
} blockB;

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB.a = int8_t(9);
	blockB.c[0] = (0u);
}
#version 450
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
	mediump mat4 a;
	uint8_t b;
	lowp ivec2 c;
	i8vec2 d;
	bvec3 e;
} blockB;
layout(std430, binding = 2) readonly buffer BlockC
{
	mediump mat3 f;
};
layout(std430, column_major, binding = 3) buffer BlockD
{
	highp vec4 g;
	lowp vec3 h;
	lowp uvec2 i;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(blockB.b), 8u) && allOk;
	allOk = compare_ivec2((blockB.c), ivec2(5, -6)) && allOk;
	allOk = compare_bvec3((blockB.e), bvec3(true, true, false)) && allOk;
	allOk = compare_mat3(f, mat3(-7.0, 5.0, -9.0, 3.0, -2.0, 6.0, -2.0, 1.0, -6.0)) && allOk;
	allOk = compare_vec3((h), vec3(1.0, -8.0, 1.0)) && allOk;
	allOk = compare_uvec2((i), uvec2(6u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4(-5.0, 4.0, -9.0, -7.0, -8.0, 8.0, 4.0, 6.0, -5.0, -5.0, -7.0, 5.0, 2.0, -4.0, -8.0, 0.0));
	blockB.b = uint8_t(9u);
	blockB.c = (ivec2(3, 1));
	h = (vec3(-9.0, -1.0, -1.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, column_major, binding = 1) readonly buffer BlockB
{
	mediump uvec4 a[];
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	mediump mat3x2 b;
	mediump mat2x3 c;
	i8vec2 d;
	mediump mat3x4 e;
	bool f[];
} blockC;
layout(std430, column_major, binding = 3) buffer BlockD
{
	mediump mat4x3 g[2][3];
	bool h;
	u8vec4 i[];
} blockD[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(blockC.d), ivec2(0, 4294967294)) && allOk;
	allOk = compare_bool((blockC.f[0]), false) && allOk;
	allOk = compare_bool((blockC.f[1]), false) && allOk;
	allOk = compare_bool((blockC.f[2]), true) && allOk;
	allOk = compare_bool((blockC.f[3]), true) && allOk;
	allOk = compare_bool((blockC.f[4]), false) && allOk;
	allOk = compare_bool((blockD[0].h), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.d = i8vec2(ivec2(8, 8));
	blockD[0].g[0][0] = (mat4x3(-1.0, 9.0, 1.0, 1.0, -3.0, -5.0, 0.0, -3.0, -2.0, 8.0, 3.0, 7.0));
	blockD[0].g[0][1] = (mat4x3(-4.0, -2.0, -4.0, -8.0, 5.0, -6.0, 8.0, 6.0, 4.0, 6.0, -4.0, -6.0));
	blockD[0].g[0][2] = (mat4x3(3.0, 1.0, 7.0, 7.0, 9.0, 0.0, 3.0, -3.0, 4.0, -1.0, 6.0, -2.0));
	blockD[0].g[1][0] = (mat4x3(5.0, -6.0, -8.0, -5.0, 0.0, 4.0, 3.0, -1.0, 9.0, -6.0, -4.0, 3.0));
	blockD[0].g[1][1] = (mat4x3(-3.0, -1.0, 6.0, -6.0, -4.0, 3.0, 2.0, 9.0, 5.0, 2.0, -3.0, -7.0));
	blockD[0].g[1][2] = (mat4x3(3.0, 0.0, 7.0, -4.0, 4.0, -4.0, 3.0, -4.0, -1.0, 0.0, -6.0, 4.0));
	blockD[0].h = (true);
}
#version 450
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
	layout(offset = 0) u8vec3 a;
	layout(offset = 16) highp vec3 b[1];
	layout(offset = 32) bvec2 c[1];
	layout(offset = 40) lowp uint d;
	layout(offset = 48) lowp uvec3 e;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) lowp ivec2 f[1];
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) int8_t g;
	layout(offset = 4) bool h;
	layout(offset = 16) bvec3 i[1];
} blockD[3];
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) lowp ivec4 j;
	layout(offset = 16) bvec4 k[1];
	layout(offset = 32) highp uvec4 l[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((c[0]), bvec2(true, false)) && allOk;
	allOk = compare_uint((d), 8u) && allOk;
	allOk = compare_uvec3((e), uvec3(9u, 3u, 2u)) && allOk;
	allOk = compare_int8_t(int(blockD[0].g), 4) && allOk;
	allOk = compare_bool((blockD[0].h), true) && allOk;
	allOk = compare_int8_t(int(blockD[1].g), 4294967295) && allOk;
	allOk = compare_bool((blockD[1].h), false) && allOk;
	allOk = compare_int8_t(int(blockD[2].g), 4294967287) && allOk;
	allOk = compare_bool((blockD[2].h), false) && allOk;
	allOk = compare_uvec4((l[0]), uvec4(3u, 4u, 7u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = u8vec3(uvec3(6u, 4u, 7u));
	b[0] = (vec3(1.0, -7.0, -3.0));
	d = (3u);
	e = (uvec3(1u, 6u, 3u));
	blockC.f[0] = (ivec2(-9, 5));
	blockD[0].g = int8_t(4);
	blockD[0].i[0] = (bvec3(true, true, true));
	blockD[1].g = int8_t(4294967287);
	blockD[1].i[0] = (bvec3(true, false, true));
	blockD[2].g = int8_t(4294967290);
	blockD[2].i[0] = (bvec3(false, true, true));
	j = (ivec4(-9, 3, 5, -9));
	k[0] = (bvec4(true, true, false, false));
}
#version 450
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
	lowp float mA;
};
layout(scalar, binding = 1) buffer BlockB
{
	lowp mat3x2 a;
	highp uint b;
	highp int c;
	mediump ivec4 d;
	sA e;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(a, mat3x2(-8.0, -8.0, 0.0, -9.0, -1.0, 4.0)) && allOk;
	allOk = compare_int((c), 0) && allOk;
	allOk = compare_ivec4((d), ivec4(-2, -5, 1, 5)) && allOk;
	allOk = compare_float((e.mA), 1.0) && allOk;
    if (allOk)
        ac_numPassed++;

	d = (ivec4(-5, -9, 4, -6));
	e.mA = (2.0);
}
#version 450
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
	highp ivec3 mA;
	bvec2 mB;
	sA mC;
	bvec4 mD;
};
struct sC
{
	highp ivec3 mA;
	mediump mat4x2 mB;
	mediump uvec3 mC;
	lowp uvec4 mD;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	mediump uvec3 a;
	lowp float b;
	lowp vec3 c[];
} blockB;
layout(scalar, column_major, binding = 2) buffer BlockC
{
	sB d;
	u8vec3 e;
	bvec3 f;
	sC g;
	u8vec3 h[][1];
};
layout(scalar, binding = 3) buffer BlockD
{
	mediump uvec3 i;
	lowp mat3 j;
	mediump int k;
	bvec4 l[];
};
layout(scalar, column_major, binding = 4) buffer BlockE
{
	int8_t m;
	highp mat4x3 n;
	i8vec2 o;
	highp ivec3 p[4];
	highp mat4x2 q[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a), uvec3(5u, 5u, 0u)) && allOk;
	allOk = compare_float((blockB.b), -5.0) && allOk;
	allOk = compare_vec3((blockB.c[0]), vec3(0.0, 3.0, 7.0)) && allOk;
	allOk = compare_vec3((blockB.c[1]), vec3(-1.0, -8.0, 2.0)) && allOk;
	allOk = compare_vec3((blockB.c[2]), vec3(8.0, -2.0, -2.0)) && allOk;
	allOk = compare_vec3((blockB.c[3]), vec3(4.0, -7.0, -2.0)) && allOk;
	allOk = compare_vec3((blockB.c[4]), vec3(-1.0, 1.0, -1.0)) && allOk;
	allOk = compare_vec3((blockB.c[5]), vec3(-6.0, 3.0, -7.0)) && allOk;
	allOk = compare_vec3((blockB.c[6]), vec3(4.0, 1.0, -6.0)) && allOk;
	allOk = compare_vec3((blockB.c[7]), vec3(-7.0, 2.0, 8.0)) && allOk;
	allOk = compare_u8vec3(uvec3(e), uvec3(4u, 9u, 8u)) && allOk;
	allOk = compare_ivec3((g.mA), ivec3(9, 8, 4)) && allOk;
	allOk = compare_mat4x2(g.mB, mat4x2(-3.0, 0.0, -9.0, 7.0, -9.0, 8.0, -2.0, -2.0)) && allOk;
	allOk = compare_uvec3((g.mC), uvec3(5u, 7u, 9u)) && allOk;
	allOk = compare_uvec4((g.mD), uvec4(3u, 9u, 4u, 4u)) && allOk;
	allOk = compare_int((k), -6) && allOk;
	allOk = compare_mat4x3(n, mat4x3(3.0, 5.0, 6.0, 1.0, 9.0, 9.0, -3.0, 8.0, 6.0, 7.0, 7.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec3(5u, 5u, 6u));
	blockB.b = (0.0);
	blockB.c[0] = (vec3(9.0, 2.0, -6.0));
	blockB.c[1] = (vec3(6.0, -6.0, 3.0));
	blockB.c[2] = (vec3(5.0, -8.0, -7.0));
	blockB.c[3] = (vec3(-8.0, 3.0, -6.0));
	blockB.c[4] = (vec3(-9.0, 9.0, -9.0));
	blockB.c[5] = (vec3(9.0, 8.0, -1.0));
	blockB.c[6] = (vec3(-4.0, 0.0, -4.0));
	blockB.c[7] = (vec3(2.0, 1.0, 2.0));
	g.mA = (ivec3(-8, -4, -3));
	g.mB = (mat4x2(-8.0, 8.0, -8.0, 3.0, -1.0, 4.0, 4.0, -4.0));
	g.mC = (uvec3(9u, 5u, 6u));
	g.mD = (uvec4(5u, 6u, 7u, 4u));
	h[0][0] = u8vec3(uvec3(7u, 3u, 8u));
	h[1][0] = u8vec3(uvec3(4u, 1u, 5u));
	h[2][0] = u8vec3(uvec3(4u, 5u, 4u));
	h[3][0] = u8vec3(uvec3(5u, 0u, 0u));
	h[4][0] = u8vec3(uvec3(8u, 5u, 6u));
	i = (uvec3(2u, 1u, 4u));
	k = (-1);
	l[0] = (bvec4(true, true, true, true));
	l[1] = (bvec4(false, false, false, false));
	l[2] = (bvec4(true, false, false, false));
	l[3] = (bvec4(true, false, true, false));
	l[4] = (bvec4(false, true, false, true));
	l[5] = (bvec4(false, false, false, true));
	l[6] = (bvec4(true, false, false, true));
	l[7] = (bvec4(false, false, true, false));
	m = int8_t(4294967295);
	n = (mat4x3(-2.0, 5.0, -6.0, -9.0, 4.0, -8.0, 7.0, 4.0, 3.0, 3.0, -9.0, -2.0));
	p[0] = (ivec3(-5, 2, 9));
	p[1] = (ivec3(8, 8, 5));
	p[2] = (ivec3(0, 7, 6));
	p[3] = (ivec3(-3, -1, 1));
}
#version 450
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
	i8vec4 a;
} blockB[];

bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(blockB[nonuniformEXT(0)].a), ivec4(7, 4294967289, 0, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[nonuniformEXT(1)].a), ivec4(7, 2, 3, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = i8vec4(ivec4(5, 6, 1, 4294967291));
	blockB[nonuniformEXT(1)].a = i8vec4(ivec4(7, 4294967292, 4, 4294967294));
}
#version 450
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
	lowp mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var, mat2(1.0, -6.0, 0.0, -9.0)) && allOk;
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
	highp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var, mat2x3(-1.0, -1.0, 3.0, 5.0, 6.0, 9.0)) && allOk;
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
	lowp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var, mat2x3(0.0, -5.0, 6.0, -5.0, -4.0, 8.0)) && allOk;
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

}
#version 450
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
	highp mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var, mat3x4(-7.0, 2.0, 0.0, 9.0, 8.0, 1.0, -1.0, 5.0, -1.0, 6.0, 8.0, 5.0)) && allOk;
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
	allOk = compare_float(var[0][0], 2.0) && allOk;
	allOk = compare_float(var[0][1], -3.0) && allOk;
	allOk = compare_float(var[1][0], -3.0) && allOk;
	allOk = compare_float(var[1][1], -5.0) && allOk;
	allOk = compare_float(var[2][0], -9.0) && allOk;
	allOk = compare_float(var[2][1], 0.0) && allOk;
	allOk = compare_float(var[3][0], -8.0) && allOk;
	allOk = compare_float(var[3][1], -5.0) && allOk;
	allOk = compare_vec2(var[0], vec2(2.0, -3.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-3.0, -5.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-9.0, 0.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(-8.0, -5.0)) && allOk;
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
	lowp mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var, mat4x3(-6.0, -3.0, 6.0, -8.0, -3.0, 8.0, 3.0, 2.0, -5.0, -2.0, -1.0, -1.0)) && allOk;
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

layout(std430, column_major, binding = 1) readonly buffer Block
{
	lowp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 8.0) && allOk;
	allOk = compare_float(var[0][1], -9.0) && allOk;
	allOk = compare_float(var[0][2], -6.0) && allOk;
	allOk = compare_float(var[0][3], -9.0) && allOk;
	allOk = compare_float(var[1][0], -3.0) && allOk;
	allOk = compare_float(var[1][1], -7.0) && allOk;
	allOk = compare_float(var[1][2], 6.0) && allOk;
	allOk = compare_float(var[1][3], -6.0) && allOk;
	allOk = compare_vec4(var[0], vec4(8.0, -9.0, -6.0, -9.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-3.0, -7.0, 6.0, -6.0)) && allOk;
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
	highp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -7.0) && allOk;
	allOk = compare_float(var[0][1], -7.0) && allOk;
	allOk = compare_float(var[1][0], -4.0) && allOk;
	allOk = compare_float(var[1][1], -8.0) && allOk;
	allOk = compare_float(var[2][0], -8.0) && allOk;
	allOk = compare_float(var[2][1], 6.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-7.0, -7.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-4.0, -8.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-8.0, 6.0)) && allOk;
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
	uint8_t var;
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(var), 7u) && allOk;
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
	highp mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_float(var[0][0], -9.0) && allOk;
	allOk = compare_float(var[0][1], 7.0) && allOk;
	allOk = compare_float(var[1][0], 7.0) && allOk;
	allOk = compare_float(var[1][1], 7.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-9.0, 7.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(7.0, 7.0)) && allOk;
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
	lowp mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_float(var[0][0], 7.0) && allOk;
	allOk = compare_float(var[0][1], -7.0) && allOk;
	allOk = compare_float(var[0][2], 3.0) && allOk;
	allOk = compare_float(var[1][0], -1.0) && allOk;
	allOk = compare_float(var[1][1], -1.0) && allOk;
	allOk = compare_float(var[1][2], -1.0) && allOk;
	allOk = compare_float(var[2][0], -6.0) && allOk;
	allOk = compare_float(var[2][1], 6.0) && allOk;
	allOk = compare_float(var[2][2], 0.0) && allOk;
	allOk = compare_float(var[3][0], -3.0) && allOk;
	allOk = compare_float(var[3][1], 7.0) && allOk;
	allOk = compare_float(var[3][2], 6.0) && allOk;
	allOk = compare_vec3(var[0], vec3(7.0, -7.0, 3.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-1.0, -1.0, -1.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-6.0, 6.0, 0.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(-3.0, 7.0, 6.0)) && allOk;
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
	highp ivec3 var[3];
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((var[0]), ivec3(7, -4, 3)) && allOk;
	allOk = compare_ivec3((var[1]), ivec3(-4, -6, -8)) && allOk;
	allOk = compare_ivec3((var[2]), ivec3(3, -1, -7)) && allOk;
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
	highp mat4x3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0], mat4x3(-2.0, 8.0, 0.0, 9.0, -7.0, -7.0, 8.0, 2.0, 7.0, 3.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(9.0, -7.0, -6.0, -8.0, -6.0, 3.0, -8.0, -8.0, -4.0, 5.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(-6.0, 1.0, 9.0, 4.0, -4.0, -7.0, 9.0, -3.0, -7.0, 9.0, 2.0, 9.0)) && allOk;
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
	highp mat4x2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0], mat4x2(8.0, -9.0, 9.0, -6.0, -8.0, -7.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(3.0, 6.0, -4.0, 1.0, 5.0, 2.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(2.0, -9.0, 8.0, 9.0, 2.0, -7.0, -8.0, 9.0)) && allOk;
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
	i8vec4 var[3];
};

bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(var[0]), ivec4(4294967293, 4294967289, 4294967295, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1]), ivec4(5, 4294967288, 4294967292, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2]), ivec4(3, 3, 4294967290, 4294967293)) && allOk;
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
	allOk = compare_mat2(var[0], mat2(-7.0, -9.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(8.0, 9.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(8.0, -6.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2(var[3], mat2(-1.0, -5.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2(var[4], mat2(4.0, 1.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat2(var[5], mat2(7.0, -5.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat2(var[6], mat2(0.0, 9.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat2(var[7], mat2(-6.0, 5.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2(var[8], mat2(-9.0, -1.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat2(var[9], mat2(-9.0, 8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2(var[10], mat2(4.0, -8.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat2(var[11], mat2(8.0, -1.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2(var[12], mat2(-4.0, -7.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2(var[13], mat2(-4.0, -8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat2(var[14], mat2(-2.0, -6.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat2(var[15], mat2(3.0, 4.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2(var[16], mat2(-5.0, -9.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2(var[17], mat2(-2.0, -8.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat2(var[18], mat2(4.0, 3.0, -8.0, 8.0)) && allOk;
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
	highp vec3 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((var[0]), vec3(7.0, 9.0, -6.0)) && allOk;
	allOk = compare_vec3((var[1]), vec3(-9.0, 5.0, -8.0)) && allOk;
	allOk = compare_vec3((var[2]), vec3(1.0, -1.0, 7.0)) && allOk;
	allOk = compare_vec3((var[3]), vec3(-1.0, -9.0, 3.0)) && allOk;
	allOk = compare_vec3((var[4]), vec3(-7.0, -2.0, -4.0)) && allOk;
	allOk = compare_vec3((var[5]), vec3(3.0, 3.0, 6.0)) && allOk;
	allOk = compare_vec3((var[6]), vec3(1.0, -4.0, 0.0)) && allOk;
	allOk = compare_vec3((var[7]), vec3(5.0, 6.0, 5.0)) && allOk;
	allOk = compare_vec3((var[8]), vec3(-3.0, 5.0, 7.0)) && allOk;
	allOk = compare_vec3((var[9]), vec3(8.0, 5.0, 8.0)) && allOk;
	allOk = compare_vec3((var[10]), vec3(5.0, -8.0, -5.0)) && allOk;
	allOk = compare_vec3((var[11]), vec3(-7.0, -3.0, 7.0)) && allOk;
	allOk = compare_vec3((var[12]), vec3(-1.0, 5.0, 8.0)) && allOk;
	allOk = compare_vec3((var[13]), vec3(2.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec3((var[14]), vec3(8.0, 9.0, 6.0)) && allOk;
	allOk = compare_vec3((var[15]), vec3(6.0, -8.0, 0.0)) && allOk;
	allOk = compare_vec3((var[16]), vec3(-6.0, -1.0, 2.0)) && allOk;
	allOk = compare_vec3((var[17]), vec3(2.0, 7.0, -9.0)) && allOk;
	allOk = compare_vec3((var[18]), vec3(-8.0, -2.0, 6.0)) && allOk;
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
	highp mat2x3 var[];
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
	allOk = compare_mat2x3(var[3], mat2x3(-2.0, -1.0, 3.0, 4.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[4], mat2x3(5.0, 8.0, 1.0, -7.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[5], mat2x3(0.0, 9.0, -1.0, -8.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[6], mat2x3(-6.0, 9.0, 9.0, -2.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[7], mat2x3(8.0, -6.0, -2.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[8], mat2x3(-2.0, -9.0, -1.0, -8.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[9], mat2x3(-5.0, -9.0, -3.0, -8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[10], mat2x3(-9.0, -1.0, -9.0, -9.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[11], mat2x3(-6.0, -1.0, 7.0, -5.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[12], mat2x3(8.0, -7.0, 1.0, -9.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[13], mat2x3(3.0, 8.0, -5.0, -1.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[14], mat2x3(9.0, -5.0, 0.0, 0.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[15], mat2x3(-8.0, -1.0, 3.0, -7.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[16], mat2x3(-7.0, 6.0, -9.0, -5.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[17], mat2x3(-7.0, 1.0, 7.0, 2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[18], mat2x3(5.0, -9.0, 5.0, 6.0, 6.0, 0.0)) && allOk;
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
layout(std430, binding = 1) readonly buffer Block
{
	S s;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((block[0].s.a), ivec3(-5, 6, -9)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(7.0, 0.0, -9.0, 5.0, 4.0, -3.0, -2.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(0.0, -9.0, -6.0, -1.0, 8.0, -2.0, -1.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(4.0, 2.0, -4.0, 4.0, 7.0, -6.0, -1.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(2.0, 8.0, 8.0, -9.0, 0.0, 7.0, 3.0, 5.0, 1.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(1.0, -9.0, 2.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(7, -5, -1)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(-7.0, -7.0, 5.0, -5.0, -2.0, -2.0, -3.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(-1.0, -7.0, 9.0, -2.0, -1.0, -1.0, 7.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(-9.0, -8.0, 3.0, 0.0, 3.0, -1.0, 1.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(6.0, 3.0, -4.0, -6.0, 6.0, -6.0, -1.0, 3.0, -7.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(0.0, 5.0, -3.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(-6, -7, -5)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(-8.0, 6.0, 7.0, -3.0, -7.0, 0.0, 6.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(0.0, -8.0, -1.0, -5.0, 0.0, 8.0, -2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(-2.0, 8.0, 4.0, 1.0, 5.0, -1.0, 9.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(-9.0, 0.0, 4.0, 6.0, 7.0, -9.0, -1.0, 3.0, -3.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(-9.0, -8.0, 0.0, -7.0)) && allOk;
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

layout(std140, buffer_reference) buffer Block
{
	mediump uint var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((block.var), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (0u);
}
#version 450
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
	bvec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((block.var), bvec4(true, false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (bvec4(true, true, true, false));
}
#version 450
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
	allOk = compare_mat4(block.var, mat4(3.0, -4.0, 1.0, -6.0, 0.0, 0.0, -1.0, -6.0, -3.0, 1.0, 1.0, 9.0, 6.0, 8.0, 9.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4(-7.0, 2.0, -1.0, 7.0, -7.0, 9.0, 1.0, 3.0, -1.0, -4.0, -5.0, 4.0, 4.0, 3.0, 2.0, 7.0));
}
#version 450
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
	mediump mat2x4 var;
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
	allOk = compare_float(block.var[0][0], 1.0) && allOk;
	allOk = compare_float(block.var[0][1], -7.0) && allOk;
	allOk = compare_float(block.var[0][2], 8.0) && allOk;
	allOk = compare_float(block.var[0][3], 6.0) && allOk;
	allOk = compare_float(block.var[1][0], -6.0) && allOk;
	allOk = compare_float(block.var[1][1], -7.0) && allOk;
	allOk = compare_float(block.var[1][2], 8.0) && allOk;
	allOk = compare_float(block.var[1][3], -2.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(1.0, -7.0, 8.0, 6.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-6.0, -7.0, 8.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(-6.0, 0.0, 1.0, 2.0));
	block.var[1] = (vec4(6.0, -4.0, 2.0, -7.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -2.0) && allOk;
	allOk = compare_float(block.var[0][1], 5.0) && allOk;
	allOk = compare_float(block.var[1][0], 1.0) && allOk;
	allOk = compare_float(block.var[1][1], 9.0) && allOk;
	allOk = compare_float(block.var[2][0], -5.0) && allOk;
	allOk = compare_float(block.var[2][1], 0.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(-2.0, 5.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(1.0, 9.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(-5.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x2(5.0, -7.0, 9.0, -6.0, 5.0, -9.0));
}
#version 450
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
	highp ivec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((block.var), ivec2(-4, -6)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (ivec2(5, -1));
}
#version 450
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
	allOk = compare_mat2(block.var, mat2(-4.0, 0.0, 8.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2(-7.0, -4.0, 9.0, 7.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -8.0) && allOk;
	allOk = compare_float(block.var[0][1], 8.0) && allOk;
	allOk = compare_float(block.var[0][2], -7.0) && allOk;
	allOk = compare_float(block.var[0][3], -5.0) && allOk;
	allOk = compare_float(block.var[1][0], 5.0) && allOk;
	allOk = compare_float(block.var[1][1], -6.0) && allOk;
	allOk = compare_float(block.var[1][2], -5.0) && allOk;
	allOk = compare_float(block.var[1][3], -9.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-8.0, 8.0, -7.0, -5.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(5.0, -6.0, -5.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x4(2.0, 5.0, -9.0, 2.0, -2.0, 3.0, 7.0, -3.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -9.0) && allOk;
	allOk = compare_float(block.var[0][1], 5.0) && allOk;
	allOk = compare_float(block.var[1][0], 6.0) && allOk;
	allOk = compare_float(block.var[1][1], -1.0) && allOk;
	allOk = compare_float(block.var[2][0], 8.0) && allOk;
	allOk = compare_float(block.var[2][1], 2.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(-9.0, 5.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(6.0, -1.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x2(1.0, 2.0, 7.0, -2.0, 0.0, 7.0));
}
#version 450
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
	lowp mat4x2 var;
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
	allOk = compare_mat4x2(block.var, mat4x2(6.0, 9.0, 9.0, 6.0, 5.0, -7.0, -2.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x2(-3.0, 9.0, -1.0, 2.0, 4.0, 5.0, -6.0, 6.0));
}
#version 450
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
	highp ivec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((block.padding), 5) && allOk;
	allOk = compare_ivec4((block.var), ivec4(-9, -6, -4, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-9);
	block.var = (ivec4(-9, -3, -7, -5));
}
#version 450
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
	uint padding;
	mediump uvec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((block.padding), 1u) && allOk;
	allOk = compare_uvec4((block.var), uvec4(4u, 9u, 6u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (5u);
	block.var = (uvec4(0u, 1u, 3u, 9u));
}
#version 450
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
	allOk = compare_float((block.padding), 1.0) && allOk;
	allOk = compare_float(block.var[0][0], -9.0) && allOk;
	allOk = compare_float(block.var[0][1], 7.0) && allOk;
	allOk = compare_float(block.var[1][0], 7.0) && allOk;
	allOk = compare_float(block.var[1][1], 7.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(-9.0, 7.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(7.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (4.0);
	block.var[0] = (vec2(8.0, 5.0));
	block.var[1] = (vec2(-8.0, 0.0));
}
#version 450
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
	allOk = compare_float((block.padding), -7.0) && allOk;
	allOk = compare_float(block.var[0][0], -4.0) && allOk;
	allOk = compare_float(block.var[0][1], 7.0) && allOk;
	allOk = compare_float(block.var[0][2], -2.0) && allOk;
	allOk = compare_float(block.var[0][3], -5.0) && allOk;
	allOk = compare_float(block.var[1][0], -7.0) && allOk;
	allOk = compare_float(block.var[1][1], 0.0) && allOk;
	allOk = compare_float(block.var[1][2], -9.0) && allOk;
	allOk = compare_float(block.var[1][3], -4.0) && allOk;
	allOk = compare_float(block.var[2][0], -9.0) && allOk;
	allOk = compare_float(block.var[2][1], 9.0) && allOk;
	allOk = compare_float(block.var[2][2], 8.0) && allOk;
	allOk = compare_float(block.var[2][3], -9.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-4.0, 7.0, -2.0, -5.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-7.0, 0.0, -9.0, -4.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(-9.0, 9.0, 8.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (5.0);
	block.var = (mat3x4(4.0, -1.0, 9.0, -2.0, 3.0, 2.0, -7.0, 7.0, 7.0, -4.0, 0.0, 5.0));
}
#version 450
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
	allOk = compare_float((block.padding), 9.0) && allOk;
	allOk = compare_float(block.var[0][0], -1.0) && allOk;
	allOk = compare_float(block.var[0][1], -8.0) && allOk;
	allOk = compare_float(block.var[1][0], 6.0) && allOk;
	allOk = compare_float(block.var[1][1], -4.0) && allOk;
	allOk = compare_float(block.var[2][0], -8.0) && allOk;
	allOk = compare_float(block.var[2][1], -3.0) && allOk;
	allOk = compare_float(block.var[3][0], -8.0) && allOk;
	allOk = compare_float(block.var[3][1], 7.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(-1.0, -8.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(6.0, -4.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(-8.0, -3.0)) && allOk;
	allOk = compare_vec2(block.var[3], vec2(-8.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-6.0);
	block.var = (mat4x2(-9.0, 0.0, 8.0, -9.0, 9.0, 4.0, -9.0, 6.0));
}
#version 450
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
	highp ivec3 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((block.var[0]), ivec3(7, -4, 3)) && allOk;
	allOk = compare_ivec3((block.var[1]), ivec3(-4, -6, -8)) && allOk;
	allOk = compare_ivec3((block.var[2]), ivec3(3, -1, -7)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (ivec3(-5, 0, -9));
	block.var[1] = (ivec3(2, 4, 1));
	block.var[2] = (ivec3(6, 6, 2));
}
#version 450
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
	highp mat2x3 var[3];
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
	allOk = compare_mat2x3(block.var[0], mat2x3(1.0, -3.0, 8.0, -6.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1], mat2x3(4.0, -9.0, -8.0, -2.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2], mat2x3(-7.0, -2.0, 0.0, -6.0, 5.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec3(-7.0, -8.0, 7.0));
	block.var[0][1] = (vec3(-6.0, -3.0, -4.0));
	block.var[1][0] = (vec3(3.0, -8.0, -9.0));
	block.var[1][1] = (vec3(-2.0, 5.0, 6.0));
	block.var[2][0] = (vec3(6.0, -5.0, -7.0));
	block.var[2][1] = (vec3(1.0, 1.0, -3.0));
}
#version 450
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
	highp mat3 var[3];
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
	allOk = compare_mat3(block.var[0], mat3(-1.0, 2.0, -7.0, -6.0, 0.0, 4.0, -7.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(-9.0, -8.0, 6.0, 6.0, 6.0, -3.0, -6.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(3.0, 8.0, 0.0, -4.0, -4.0, 3.0, 9.0, 9.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec3(-1.0, 1.0, 4.0));
	block.var[0][1] = (vec3(6.0, -5.0, -5.0));
	block.var[0][2] = (vec3(9.0, -6.0, 5.0));
	block.var[1][0] = (vec3(7.0, 7.0, -2.0));
	block.var[1][1] = (vec3(-4.0, 1.0, -5.0));
	block.var[1][2] = (vec3(8.0, -1.0, -8.0));
	block.var[2][0] = (vec3(-6.0, -4.0, 5.0));
	block.var[2][1] = (vec3(3.0, 9.0, -8.0));
	block.var[2][2] = (vec3(-4.0, 8.0, 0.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0], mat2x4(3.0, -4.0, 9.0, -7.0, -8.0, 2.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(-7.0, 8.0, -9.0, 4.0, 4.0, -9.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(9.0, -5.0, -4.0, -8.0, -6.0, -2.0, 3.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2x4(5.0, -1.0, 5.0, 1.0, 1.0, -4.0, 0.0, -8.0));
	block.var[1] = (mat2x4(-3.0, 9.0, -8.0, -9.0, 1.0, 9.0, 1.0, -2.0));
	block.var[2] = (mat2x4(-6.0, 3.0, -3.0, -7.0, -6.0, 0.0, 9.0, -7.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0], mat4x2(8.0, 1.0, 9.0, 3.0, -8.0, 3.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(8.0, -6.0, -5.0, 7.0, -8.0, -2.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(9.0, 4.0, 4.0, 4.0, 3.0, -6.0, -6.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4x2(-9.0, -8.0, -8.0, 3.0, 8.0, 7.0, 0.0, 5.0));
	block.var[1] = (mat4x2(5.0, 8.0, 8.0, 8.0, 6.0, -3.0, -6.0, -4.0));
	block.var[2] = (mat4x2(-6.0, -9.0, 1.0, -1.0, 8.0, -7.0, 5.0, -3.0));
}
#version 450
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
	uint padding;
	highp uvec4 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((block.padding), 4u) && allOk;
	allOk = compare_uvec4((block.var[0]), uvec4(1u, 8u, 2u, 1u)) && allOk;
	allOk = compare_uvec4((block.var[1]), uvec4(9u, 5u, 9u, 3u)) && allOk;
	allOk = compare_uvec4((block.var[2]), uvec4(6u, 5u, 1u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2u);
	block.var[0] = (uvec4(7u, 2u, 9u, 7u));
	block.var[1] = (uvec4(9u, 5u, 1u, 3u));
	block.var[2] = (uvec4(4u, 4u, 2u, 0u));
}
#version 450
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
	allOk = compare_float((block.padding), -4.0) && allOk;
	allOk = compare_mat2(block.var[0], mat2(3.0, -8.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(5.0, 4.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(2.0, -7.0, 4.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2.0);
	block.var[0] = (mat2(4.0, 4.0, -1.0, 2.0));
	block.var[1] = (mat2(-5.0, 1.0, -1.0, -2.0));
	block.var[2] = (mat2(-9.0, -3.0, -8.0, -6.0));
}
#version 450
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
	bvec3 var[];
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
	allOk = compare_bvec3((block.var[3]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((block.var[4]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[5]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((block.var[6]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((block.var[7]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((block.var[8]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((block.var[9]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((block.var[10]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[11]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[12]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((block.var[13]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((block.var[14]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[15]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((block.var[16]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[17]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((block.var[18]), bvec3(true, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (bvec3(true, true, false));
	block.var[1] = (bvec3(false, true, true));
	block.var[2] = (bvec3(false, false, false));
	block.var[3] = (bvec3(true, false, false));
	block.var[4] = (bvec3(true, true, true));
	block.var[5] = (bvec3(false, true, true));
	block.var[6] = (bvec3(false, true, true));
	block.var[7] = (bvec3(true, true, true));
	block.var[8] = (bvec3(true, true, true));
	block.var[9] = (bvec3(true, false, false));
	block.var[10] = (bvec3(false, true, false));
	block.var[11] = (bvec3(true, false, false));
	block.var[12] = (bvec3(false, false, true));
	block.var[13] = (bvec3(true, false, true));
	block.var[14] = (bvec3(false, false, false));
	block.var[15] = (bvec3(true, true, false));
	block.var[16] = (bvec3(false, false, true));
	block.var[17] = (bvec3(false, false, true));
	block.var[18] = (bvec3(true, true, false));
}
#version 450
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
	highp mat3 var[];
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
	allOk = compare_mat3(block.var[0], mat3(-8.0, -9.0, -7.0, -7.0, 8.0, 7.0, 4.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(5.0, -4.0, 7.0, -4.0, -3.0, 8.0, 7.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(1.0, 6.0, 8.0, -9.0, -1.0, 8.0, 8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[3], mat3(-6.0, 4.0, -3.0, -2.0, 3.0, 7.0, 0.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[4], mat3(-1.0, 1.0, -9.0, 4.0, 6.0, 8.0, 8.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[5], mat3(3.0, 0.0, -4.0, 8.0, 3.0, 9.0, 3.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[6], mat3(-8.0, 7.0, 2.0, -7.0, 4.0, -2.0, -5.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[7], mat3(-1.0, 2.0, 0.0, -9.0, -9.0, 6.0, -6.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[8], mat3(-4.0, -3.0, -3.0, 4.0, -6.0, -6.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[9], mat3(4.0, 6.0, -3.0, 5.0, -4.0, -6.0, -5.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[10], mat3(8.0, -1.0, -4.0, -2.0, 4.0, -8.0, 0.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[11], mat3(9.0, 6.0, 8.0, -7.0, 4.0, -8.0, 4.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[12], mat3(-7.0, 8.0, -6.0, -9.0, -8.0, 8.0, 0.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[13], mat3(-6.0, 0.0, -3.0, 9.0, 7.0, -8.0, -9.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[14], mat3(-8.0, 9.0, 0.0, -7.0, 1.0, -2.0, 3.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[15], mat3(6.0, 6.0, -4.0, 4.0, -2.0, 6.0, 2.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[16], mat3(2.0, 9.0, 6.0, -8.0, -6.0, -3.0, -4.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[17], mat3(-5.0, -8.0, 6.0, 2.0, 5.0, -6.0, 7.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[18], mat3(3.0, 4.0, -4.0, -1.0, -7.0, -1.0, 4.0, -4.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3(5.0, 2.0, 8.0, 8.0, 3.0, -2.0, 2.0, -8.0, -5.0));
	block.var[1] = (mat3(-6.0, -1.0, 7.0, -5.0, -5.0, 8.0, -2.0, -5.0, 5.0));
	block.var[2] = (mat3(3.0, 9.0, -7.0, -2.0, 3.0, 5.0, 5.0, 1.0, -6.0));
	block.var[3] = (mat3(-5.0, 4.0, 9.0, -2.0, -6.0, 2.0, -1.0, 0.0, 2.0));
	block.var[4] = (mat3(9.0, -5.0, 7.0, 6.0, 8.0, 4.0, 5.0, -2.0, -5.0));
	block.var[5] = (mat3(7.0, -1.0, 1.0, -3.0, -8.0, 1.0, -4.0, 7.0, 1.0));
	block.var[6] = (mat3(5.0, 8.0, -1.0, 8.0, 9.0, 6.0, -1.0, 5.0, -2.0));
	block.var[7] = (mat3(1.0, 4.0, -8.0, 8.0, 1.0, 2.0, 4.0, -7.0, 3.0));
	block.var[8] = (mat3(-1.0, -5.0, 2.0, 2.0, -1.0, -7.0, 7.0, -8.0, -6.0));
	block.var[9] = (mat3(5.0, -9.0, 2.0, 2.0, -9.0, -9.0, -2.0, 1.0, 8.0));
	block.var[10] = (mat3(-4.0, 8.0, -5.0, 5.0, -2.0, 2.0, 3.0, 3.0, -8.0));
	block.var[11] = (mat3(0.0, 2.0, 6.0, 2.0, -5.0, -9.0, 4.0, 6.0, -3.0));
	block.var[12] = (mat3(-9.0, 2.0, -8.0, 1.0, -5.0, 5.0, 8.0, -6.0, 7.0));
	block.var[13] = (mat3(-1.0, 7.0, -7.0, 7.0, 5.0, -9.0, 5.0, 3.0, -1.0));
	block.var[14] = (mat3(6.0, -3.0, 9.0, 7.0, 0.0, 2.0, 8.0, -5.0, -9.0));
	block.var[15] = (mat3(-3.0, 0.0, 7.0, -7.0, 1.0, -6.0, -4.0, 1.0, -9.0));
	block.var[16] = (mat3(6.0, 9.0, 8.0, 5.0, 8.0, 1.0, 6.0, 4.0, -4.0));
	block.var[17] = (mat3(9.0, -4.0, 1.0, -5.0, 8.0, -3.0, 4.0, -9.0, -8.0));
	block.var[18] = (mat3(-7.0, 7.0, -5.0, 5.0, 0.0, 7.0, -8.0, -5.0, 8.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0], mat3x2(0.0, -1.0, 5.0, 2.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[1], mat3x2(-2.0, -3.0, -9.0, 0.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2], mat3x2(6.0, -9.0, -2.0, 6.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3x2(block.var[3], mat3x2(8.0, -7.0, 1.0, -5.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[4], mat3x2(4.0, -3.0, -4.0, -9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[5], mat3x2(8.0, 4.0, 1.0, 2.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[6], mat3x2(6.0, 6.0, -8.0, 5.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[7], mat3x2(-9.0, -8.0, -5.0, -4.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[8], mat3x2(-7.0, -9.0, 9.0, -7.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[9], mat3x2(8.0, -7.0, 7.0, 6.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[10], mat3x2(2.0, -1.0, 5.0, 6.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[11], mat3x2(-7.0, -5.0, 7.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[12], mat3x2(2.0, -3.0, -1.0, -7.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[13], mat3x2(1.0, -2.0, -2.0, -2.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[14], mat3x2(0.0, -1.0, 1.0, 9.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[15], mat3x2(-9.0, 7.0, -7.0, 8.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[16], mat3x2(7.0, 4.0, 0.0, -5.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[17], mat3x2(-3.0, 3.0, -7.0, -9.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[18], mat3x2(7.0, 5.0, -6.0, -4.0, 8.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec2(-2.0, 8.0));
	block.var[0][1] = (vec2(1.0, 8.0));
	block.var[0][2] = (vec2(-7.0, 5.0));
	block.var[1][0] = (vec2(2.0, 0.0));
	block.var[1][1] = (vec2(-3.0, 1.0));
	block.var[1][2] = (vec2(2.0, -5.0));
	block.var[2][0] = (vec2(6.0, 3.0));
	block.var[2][1] = (vec2(6.0, 5.0));
	block.var[2][2] = (vec2(-5.0, 9.0));
	block.var[3][0] = (vec2(-8.0, 9.0));
	block.var[3][1] = (vec2(3.0, -3.0));
	block.var[3][2] = (vec2(3.0, -5.0));
	block.var[4][0] = (vec2(7.0, -8.0));
	block.var[4][1] = (vec2(3.0, 1.0));
	block.var[4][2] = (vec2(-2.0, 1.0));
	block.var[5][0] = (vec2(4.0, -9.0));
	block.var[5][1] = (vec2(3.0, 6.0));
	block.var[5][2] = (vec2(7.0, 1.0));
	block.var[6][0] = (vec2(9.0, -9.0));
	block.var[6][1] = (vec2(0.0, -6.0));
	block.var[6][2] = (vec2(-7.0, 7.0));
	block.var[7][0] = (vec2(-8.0, 7.0));
	block.var[7][1] = (vec2(9.0, 6.0));
	block.var[7][2] = (vec2(-1.0, 0.0));
	block.var[8][0] = (vec2(-3.0, 6.0));
	block.var[8][1] = (vec2(-1.0, -6.0));
	block.var[8][2] = (vec2(-1.0, -3.0));
	block.var[9][0] = (vec2(0.0, -1.0));
	block.var[9][1] = (vec2(4.0, -9.0));
	block.var[9][2] = (vec2(1.0, 1.0));
	block.var[10][0] = (vec2(-9.0, 7.0));
	block.var[10][1] = (vec2(0.0, 4.0));
	block.var[10][2] = (vec2(-3.0, -3.0));
	block.var[11][0] = (vec2(6.0, 8.0));
	block.var[11][1] = (vec2(-7.0, 5.0));
	block.var[11][2] = (vec2(-6.0, -5.0));
	block.var[12][0] = (vec2(2.0, -2.0));
	block.var[12][1] = (vec2(-2.0, -8.0));
	block.var[12][2] = (vec2(7.0, -7.0));
	block.var[13][0] = (vec2(-1.0, 6.0));
	block.var[13][1] = (vec2(-8.0, 4.0));
	block.var[13][2] = (vec2(-5.0, 3.0));
	block.var[14][0] = (vec2(-9.0, -8.0));
	block.var[14][1] = (vec2(8.0, -9.0));
	block.var[14][2] = (vec2(-1.0, 1.0));
	block.var[15][0] = (vec2(0.0, 2.0));
	block.var[15][1] = (vec2(-1.0, -9.0));
	block.var[15][2] = (vec2(3.0, 4.0));
	block.var[16][0] = (vec2(6.0, -1.0));
	block.var[16][1] = (vec2(-4.0, -4.0));
	block.var[16][2] = (vec2(0.0, -6.0));
	block.var[17][0] = (vec2(5.0, -8.0));
	block.var[17][1] = (vec2(6.0, -8.0));
	block.var[17][2] = (vec2(-5.0, -8.0));
	block.var[18][0] = (vec2(4.0, -9.0));
	block.var[18][1] = (vec2(-4.0, 4.0));
	block.var[18][2] = (vec2(5.0, 3.0));
}
#version 450
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
	int16_t var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(block.var[0]), -5) && allOk;
	allOk = compare_int16_t(int(block.var[1]), 1) && allOk;
	allOk = compare_int16_t(int(block.var[2]), 8) && allOk;
	allOk = compare_int16_t(int(block.var[3]), -2) && allOk;
	allOk = compare_int16_t(int(block.var[4]), 9) && allOk;
	allOk = compare_int16_t(int(block.var[5]), -5) && allOk;
	allOk = compare_int16_t(int(block.var[6]), -8) && allOk;
	allOk = compare_int16_t(int(block.var[7]), 6) && allOk;
	allOk = compare_int16_t(int(block.var[8]), 3) && allOk;
	allOk = compare_int16_t(int(block.var[9]), -8) && allOk;
	allOk = compare_int16_t(int(block.var[10]), 6) && allOk;
	allOk = compare_int16_t(int(block.var[11]), -7) && allOk;
	allOk = compare_int16_t(int(block.var[12]), 9) && allOk;
	allOk = compare_int16_t(int(block.var[13]), 5) && allOk;
	allOk = compare_int16_t(int(block.var[14]), 9) && allOk;
	allOk = compare_int16_t(int(block.var[15]), -3) && allOk;
	allOk = compare_int16_t(int(block.var[16]), -1) && allOk;
	allOk = compare_int16_t(int(block.var[17]), -2) && allOk;
	allOk = compare_int16_t(int(block.var[18]), 1) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = int16_t(6);
	block.var[1] = int16_t(8);
	block.var[2] = int16_t(-2);
	block.var[3] = int16_t(-4);
	block.var[4] = int16_t(-3);
	block.var[5] = int16_t(9);
	block.var[6] = int16_t(-5);
	block.var[7] = int16_t(-8);
	block.var[8] = int16_t(-3);
	block.var[9] = int16_t(2);
	block.var[10] = int16_t(-1);
	block.var[11] = int16_t(4);
	block.var[12] = int16_t(3);
	block.var[13] = int16_t(9);
	block.var[14] = int16_t(6);
	block.var[15] = int16_t(2);
	block.var[16] = int16_t(3);
	block.var[17] = int16_t(7);
	block.var[18] = int16_t(7);
}
#version 450
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
	highp uvec2 var[];
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
	allOk = compare_uvec2((block.var[3]), uvec2(9u, 0u)) && allOk;
	allOk = compare_uvec2((block.var[4]), uvec2(6u, 9u)) && allOk;
	allOk = compare_uvec2((block.var[5]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((block.var[6]), uvec2(0u, 2u)) && allOk;
	allOk = compare_uvec2((block.var[7]), uvec2(2u, 9u)) && allOk;
	allOk = compare_uvec2((block.var[8]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((block.var[9]), uvec2(1u, 4u)) && allOk;
	allOk = compare_uvec2((block.var[10]), uvec2(7u, 1u)) && allOk;
	allOk = compare_uvec2((block.var[11]), uvec2(8u, 8u)) && allOk;
	allOk = compare_uvec2((block.var[12]), uvec2(7u, 7u)) && allOk;
	allOk = compare_uvec2((block.var[13]), uvec2(4u, 6u)) && allOk;
	allOk = compare_uvec2((block.var[14]), uvec2(5u, 8u)) && allOk;
	allOk = compare_uvec2((block.var[15]), uvec2(9u, 9u)) && allOk;
	allOk = compare_uvec2((block.var[16]), uvec2(2u, 1u)) && allOk;
	allOk = compare_uvec2((block.var[17]), uvec2(0u, 7u)) && allOk;
	allOk = compare_uvec2((block.var[18]), uvec2(8u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (uvec2(6u, 1u));
	block.var[1] = (uvec2(8u, 1u));
	block.var[2] = (uvec2(7u, 4u));
	block.var[3] = (uvec2(6u, 6u));
	block.var[4] = (uvec2(5u, 8u));
	block.var[5] = (uvec2(4u, 7u));
	block.var[6] = (uvec2(8u, 4u));
	block.var[7] = (uvec2(6u, 3u));
	block.var[8] = (uvec2(6u, 0u));
	block.var[9] = (uvec2(3u, 5u));
	block.var[10] = (uvec2(2u, 4u));
	block.var[11] = (uvec2(7u, 8u));
	block.var[12] = (uvec2(6u, 2u));
	block.var[13] = (uvec2(6u, 0u));
	block.var[14] = (uvec2(3u, 2u));
	block.var[15] = (uvec2(5u, 1u));
	block.var[16] = (uvec2(7u, 2u));
	block.var[17] = (uvec2(3u, 6u));
	block.var[18] = (uvec2(0u, 1u));
}
#version 450
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
	highp mat3 var[];
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
	allOk = compare_mat3(block.var[0], mat3(-8.0, -9.0, -7.0, -7.0, 8.0, 7.0, 4.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(5.0, -4.0, 7.0, -4.0, -3.0, 8.0, 7.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(1.0, 6.0, 8.0, -9.0, -1.0, 8.0, 8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[3], mat3(-6.0, 4.0, -3.0, -2.0, 3.0, 7.0, 0.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[4], mat3(-1.0, 1.0, -9.0, 4.0, 6.0, 8.0, 8.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[5], mat3(3.0, 0.0, -4.0, 8.0, 3.0, 9.0, 3.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[6], mat3(-8.0, 7.0, 2.0, -7.0, 4.0, -2.0, -5.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[7], mat3(-1.0, 2.0, 0.0, -9.0, -9.0, 6.0, -6.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[8], mat3(-4.0, -3.0, -3.0, 4.0, -6.0, -6.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[9], mat3(4.0, 6.0, -3.0, 5.0, -4.0, -6.0, -5.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[10], mat3(8.0, -1.0, -4.0, -2.0, 4.0, -8.0, 0.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[11], mat3(9.0, 6.0, 8.0, -7.0, 4.0, -8.0, 4.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[12], mat3(-7.0, 8.0, -6.0, -9.0, -8.0, 8.0, 0.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[13], mat3(-6.0, 0.0, -3.0, 9.0, 7.0, -8.0, -9.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[14], mat3(-8.0, 9.0, 0.0, -7.0, 1.0, -2.0, 3.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[15], mat3(6.0, 6.0, -4.0, 4.0, -2.0, 6.0, 2.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[16], mat3(2.0, 9.0, 6.0, -8.0, -6.0, -3.0, -4.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[17], mat3(-5.0, -8.0, 6.0, 2.0, 5.0, -6.0, 7.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[18], mat3(3.0, 4.0, -4.0, -1.0, -7.0, -1.0, 4.0, -4.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3(5.0, 2.0, 8.0, 8.0, 3.0, -2.0, 2.0, -8.0, -5.0));
	block.var[1] = (mat3(-6.0, -1.0, 7.0, -5.0, -5.0, 8.0, -2.0, -5.0, 5.0));
	block.var[2] = (mat3(3.0, 9.0, -7.0, -2.0, 3.0, 5.0, 5.0, 1.0, -6.0));
	block.var[3] = (mat3(-5.0, 4.0, 9.0, -2.0, -6.0, 2.0, -1.0, 0.0, 2.0));
	block.var[4] = (mat3(9.0, -5.0, 7.0, 6.0, 8.0, 4.0, 5.0, -2.0, -5.0));
	block.var[5] = (mat3(7.0, -1.0, 1.0, -3.0, -8.0, 1.0, -4.0, 7.0, 1.0));
	block.var[6] = (mat3(5.0, 8.0, -1.0, 8.0, 9.0, 6.0, -1.0, 5.0, -2.0));
	block.var[7] = (mat3(1.0, 4.0, -8.0, 8.0, 1.0, 2.0, 4.0, -7.0, 3.0));
	block.var[8] = (mat3(-1.0, -5.0, 2.0, 2.0, -1.0, -7.0, 7.0, -8.0, -6.0));
	block.var[9] = (mat3(5.0, -9.0, 2.0, 2.0, -9.0, -9.0, -2.0, 1.0, 8.0));
	block.var[10] = (mat3(-4.0, 8.0, -5.0, 5.0, -2.0, 2.0, 3.0, 3.0, -8.0));
	block.var[11] = (mat3(0.0, 2.0, 6.0, 2.0, -5.0, -9.0, 4.0, 6.0, -3.0));
	block.var[12] = (mat3(-9.0, 2.0, -8.0, 1.0, -5.0, 5.0, 8.0, -6.0, 7.0));
	block.var[13] = (mat3(-1.0, 7.0, -7.0, 7.0, 5.0, -9.0, 5.0, 3.0, -1.0));
	block.var[14] = (mat3(6.0, -3.0, 9.0, 7.0, 0.0, 2.0, 8.0, -5.0, -9.0));
	block.var[15] = (mat3(-3.0, 0.0, 7.0, -7.0, 1.0, -6.0, -4.0, 1.0, -9.0));
	block.var[16] = (mat3(6.0, 9.0, 8.0, 5.0, 8.0, 1.0, 6.0, 4.0, -4.0));
	block.var[17] = (mat3(9.0, -4.0, 1.0, -5.0, 8.0, -3.0, 4.0, -9.0, -8.0));
	block.var[18] = (mat3(-7.0, 7.0, -5.0, 5.0, 0.0, 7.0, -8.0, -5.0, 8.0));
}
#version 450
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
	highp mat2x4 var[];
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
	allOk = compare_mat2x4(block.var[3], mat2x4(9.0, -9.0, 3.0, -1.0, -8.0, -5.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[4], mat2x4(6.0, -4.0, -5.0, -3.0, -7.0, 1.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[5], mat2x4(0.0, -5.0, 1.0, 2.0, 7.0, 2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[6], mat2x4(-9.0, -1.0, 5.0, -7.0, -9.0, -6.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[7], mat2x4(1.0, 2.0, -6.0, 1.0, -5.0, 3.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[8], mat2x4(-8.0, 1.0, -5.0, 0.0, 7.0, 5.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[9], mat2x4(-7.0, -6.0, 2.0, 4.0, -8.0, 4.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[10], mat2x4(-5.0, -2.0, -6.0, -2.0, -6.0, 1.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[11], mat2x4(2.0, -3.0, -2.0, 4.0, 6.0, -7.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[12], mat2x4(6.0, 0.0, 6.0, 8.0, -9.0, 4.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[13], mat2x4(-9.0, -1.0, 7.0, 9.0, 0.0, -2.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[14], mat2x4(-8.0, 4.0, 8.0, 3.0, -3.0, -8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[15], mat2x4(-9.0, 6.0, -4.0, -8.0, -5.0, -4.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[16], mat2x4(-8.0, 0.0, 4.0, -6.0, 5.0, 2.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[17], mat2x4(-1.0, -2.0, 0.0, -7.0, 8.0, -2.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[18], mat2x4(9.0, -3.0, -7.0, 2.0, -4.0, -3.0, -7.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2x4(-5.0, -7.0, -7.0, 0.0, -1.0, -9.0, 5.0, -5.0));
	block.var[1] = (mat2x4(0.0, 1.0, 8.0, 9.0, 2.0, 4.0, 5.0, 5.0));
	block.var[2] = (mat2x4(3.0, 6.0, 2.0, 7.0, -1.0, -8.0, 7.0, -7.0));
	block.var[3] = (mat2x4(-8.0, -9.0, 5.0, -5.0, 5.0, -9.0, -7.0, -2.0));
	block.var[4] = (mat2x4(-5.0, 8.0, -8.0, -8.0, 5.0, 4.0, -2.0, -7.0));
	block.var[5] = (mat2x4(-6.0, -7.0, 4.0, -6.0, 9.0, 7.0, 1.0, 7.0));
	block.var[6] = (mat2x4(0.0, -6.0, -6.0, 6.0, -1.0, 8.0, 4.0, 1.0));
	block.var[7] = (mat2x4(-5.0, 4.0, -3.0, 3.0, 1.0, -9.0, -1.0, -2.0));
	block.var[8] = (mat2x4(-4.0, -7.0, -9.0, 5.0, -3.0, -7.0, 8.0, 3.0));
	block.var[9] = (mat2x4(-1.0, 7.0, 6.0, -6.0, -8.0, -8.0, -4.0, 6.0));
	block.var[10] = (mat2x4(-5.0, 3.0, -1.0, -5.0, 7.0, -3.0, -2.0, -2.0));
	block.var[11] = (mat2x4(5.0, 7.0, -6.0, -5.0, -9.0, 3.0, 7.0, 0.0));
	block.var[12] = (mat2x4(8.0, 3.0, 0.0, -3.0, 5.0, -4.0, 8.0, -3.0));
	block.var[13] = (mat2x4(7.0, -1.0, 5.0, 0.0, -5.0, 2.0, -3.0, -8.0));
	block.var[14] = (mat2x4(-9.0, 5.0, -6.0, -2.0, 0.0, 0.0, -2.0, -9.0));
	block.var[15] = (mat2x4(3.0, -5.0, -5.0, -6.0, 3.0, 0.0, -2.0, 5.0));
	block.var[16] = (mat2x4(-9.0, -9.0, 4.0, -7.0, -9.0, -2.0, 5.0, 9.0));
	block.var[17] = (mat2x4(0.0, 6.0, -3.0, -4.0, 0.0, -2.0, 8.0, 1.0));
	block.var[18] = (mat2x4(-3.0, -9.0, -7.0, -5.0, -2.0, 8.0, -8.0, -8.0));
}
#version 450
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
	highp mat4x3 var[];
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
	allOk = compare_mat4x3(block.var[0], mat4x3(7.0, -2.0, 6.0, 3.0, 1.0, -7.0, 1.0, -4.0, 0.0, 9.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[1], mat4x3(3.0, 2.0, 2.0, 6.0, 6.0, 0.0, 3.0, 6.0, -4.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2], mat4x3(-6.0, -5.0, 4.0, -4.0, 1.0, 2.0, -5.0, 9.0, -7.0, -2.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[3], mat4x3(-7.0, 1.0, -9.0, 8.0, 8.0, 5.0, 0.0, 5.0, -1.0, 2.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[4], mat4x3(4.0, -2.0, -8.0, -5.0, -8.0, -5.0, -4.0, -1.0, -1.0, -5.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[5], mat4x3(3.0, 8.0, 5.0, 3.0, -2.0, 8.0, -6.0, -2.0, -8.0, -1.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[6], mat4x3(-9.0, 0.0, 6.0, -9.0, -9.0, 9.0, 6.0, 9.0, -2.0, 8.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[7], mat4x3(-8.0, 6.0, 8.0, 4.0, -3.0, -9.0, 9.0, 1.0, 2.0, 8.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[8], mat4x3(-4.0, -3.0, 7.0, 7.0, 0.0, -3.0, 5.0, -5.0, -9.0, -3.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[9], mat4x3(8.0, -2.0, 1.0, 2.0, -3.0, 9.0, 6.0, -5.0, 8.0, -1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[10], mat4x3(-5.0, -7.0, 4.0, 5.0, 7.0, 5.0, 9.0, 4.0, 8.0, 2.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[11], mat4x3(-8.0, -9.0, -8.0, 2.0, -2.0, 8.0, 4.0, 4.0, -3.0, 2.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[12], mat4x3(1.0, 8.0, 9.0, 7.0, 0.0, -2.0, -4.0, 7.0, 0.0, -9.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[13], mat4x3(-9.0, -9.0, -7.0, -5.0, 2.0, 5.0, 0.0, -2.0, -3.0, -6.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[14], mat4x3(-8.0, -7.0, 9.0, 6.0, 6.0, -5.0, -3.0, 9.0, -4.0, -3.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[15], mat4x3(-5.0, -8.0, -6.0, 4.0, -5.0, 6.0, 5.0, -8.0, 5.0, -9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[16], mat4x3(-5.0, -1.0, 5.0, 4.0, -3.0, -3.0, -5.0, 1.0, -4.0, 6.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[17], mat4x3(0.0, -6.0, -8.0, -7.0, 6.0, -3.0, 0.0, 2.0, -9.0, -7.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[18], mat4x3(-2.0, 8.0, 2.0, 7.0, 9.0, 8.0, -3.0, 8.0, -9.0, -3.0, -1.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec3(7.0, 4.0, -4.0));
	block.var[0][1] = (vec3(-6.0, 3.0, -3.0));
	block.var[0][2] = (vec3(9.0, -2.0, 3.0));
	block.var[0][3] = (vec3(9.0, -9.0, 7.0));
	block.var[1][0] = (vec3(5.0, 1.0, -9.0));
	block.var[1][1] = (vec3(-1.0, -2.0, 6.0));
	block.var[1][2] = (vec3(-4.0, 6.0, 4.0));
	block.var[1][3] = (vec3(-8.0, 7.0, 3.0));
	block.var[2][0] = (vec3(-4.0, -9.0, 8.0));
	block.var[2][1] = (vec3(9.0, 2.0, 2.0));
	block.var[2][2] = (vec3(9.0, -7.0, 3.0));
	block.var[2][3] = (vec3(8.0, 2.0, 4.0));
	block.var[3][0] = (vec3(2.0, 4.0, -3.0));
	block.var[3][1] = (vec3(-8.0, 7.0, 3.0));
	block.var[3][2] = (vec3(0.0, -8.0, 0.0));
	block.var[3][3] = (vec3(6.0, -9.0, 0.0));
	block.var[4][0] = (vec3(-4.0, 5.0, 5.0));
	block.var[4][1] = (vec3(-7.0, -8.0, -1.0));
	block.var[4][2] = (vec3(6.0, -3.0, -5.0));
	block.var[4][3] = (vec3(0.0, 8.0, -8.0));
	block.var[5][0] = (vec3(-4.0, 4.0, 8.0));
	block.var[5][1] = (vec3(-4.0, -4.0, -3.0));
	block.var[5][2] = (vec3(3.0, 3.0, 2.0));
	block.var[5][3] = (vec3(8.0, -8.0, -6.0));
	block.var[6][0] = (vec3(9.0, 1.0, -1.0));
	block.var[6][1] = (vec3(-1.0, 2.0, 4.0));
	block.var[6][2] = (vec3(4.0, 2.0, 0.0));
	block.var[6][3] = (vec3(5.0, 6.0, -6.0));
	block.var[7][0] = (vec3(-3.0, 7.0, -6.0));
	block.var[7][1] = (vec3(7.0, 9.0, 8.0));
	block.var[7][2] = (vec3(-9.0, -9.0, -9.0));
	block.var[7][3] = (vec3(6.0, -7.0, -3.0));
	block.var[8][0] = (vec3(7.0, -1.0, -4.0));
	block.var[8][1] = (vec3(-9.0, 0.0, -1.0));
	block.var[8][2] = (vec3(-7.0, -2.0, -3.0));
	block.var[8][3] = (vec3(1.0, 4.0, 5.0));
	block.var[9][0] = (vec3(9.0, 8.0, 7.0));
	block.var[9][1] = (vec3(5.0, 4.0, 7.0));
	block.var[9][2] = (vec3(3.0, -3.0, 4.0));
	block.var[9][3] = (vec3(3.0, -6.0, 5.0));
	block.var[10][0] = (vec3(-8.0, -4.0, -9.0));
	block.var[10][1] = (vec3(4.0, 8.0, -3.0));
	block.var[10][2] = (vec3(-9.0, 7.0, -2.0));
	block.var[10][3] = (vec3(0.0, -3.0, -3.0));
	block.var[11][0] = (vec3(4.0, -2.0, -4.0));
	block.var[11][1] = (vec3(-5.0, -7.0, 1.0));
	block.var[11][2] = (vec3(-8.0, 1.0, 9.0));
	block.var[11][3] = (vec3(-8.0, 0.0, -2.0));
	block.var[12][0] = (vec3(-5.0, 2.0, -4.0));
	block.var[12][1] = (vec3(-7.0, -3.0, -4.0));
	block.var[12][2] = (vec3(4.0, -3.0, -8.0));
	block.var[12][3] = (vec3(-5.0, -1.0, 1.0));
	block.var[13][0] = (vec3(6.0, -2.0, 8.0));
	block.var[13][1] = (vec3(-7.0, 1.0, 4.0));
	block.var[13][2] = (vec3(6.0, 8.0, -5.0));
	block.var[13][3] = (vec3(1.0, -6.0, 4.0));
	block.var[14][0] = (vec3(-9.0, 3.0, -3.0));
	block.var[14][1] = (vec3(0.0, -5.0, -3.0));
	block.var[14][2] = (vec3(-5.0, -8.0, 3.0));
	block.var[14][3] = (vec3(3.0, -6.0, 8.0));
	block.var[15][0] = (vec3(-3.0, 5.0, 6.0));
	block.var[15][1] = (vec3(5.0, -1.0, 6.0));
	block.var[15][2] = (vec3(8.0, 7.0, 1.0));
	block.var[15][3] = (vec3(-5.0, 6.0, -6.0));
	block.var[16][0] = (vec3(-3.0, -7.0, 7.0));
	block.var[16][1] = (vec3(-9.0, -3.0, 6.0));
	block.var[16][2] = (vec3(0.0, -7.0, 3.0));
	block.var[16][3] = (vec3(2.0, -7.0, 1.0));
	block.var[17][0] = (vec3(8.0, -1.0, -9.0));
	block.var[17][1] = (vec3(8.0, 8.0, 2.0));
	block.var[17][2] = (vec3(7.0, -5.0, -2.0));
	block.var[17][3] = (vec3(-9.0, 6.0, 2.0));
	block.var[18][0] = (vec3(-1.0, 7.0, 7.0));
	block.var[18][1] = (vec3(3.0, -4.0, -1.0));
	block.var[18][2] = (vec3(-4.0, 5.0, 7.0));
	block.var[18][3] = (vec3(-5.0, 7.0, 5.0));
}
#version 450
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
	allOk = compare_mat3(block.var[0][0], mat3(-1.0, 2.0, -7.0, -6.0, 0.0, 4.0, -7.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[0][1], mat3(-9.0, -8.0, 6.0, 6.0, 6.0, -3.0, -6.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[0][2], mat3(3.0, 8.0, 0.0, -4.0, -4.0, 3.0, 9.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[1][0], mat3(-4.0, -2.0, 2.0, 2.0, -7.0, 5.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[1][1], mat3(-2.0, 1.0, -3.0, -2.0, -1.0, -1.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[1][2], mat3(3.0, 0.0, 8.0, 2.0, -7.0, 8.0, -8.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[2][0], mat3(0.0, 1.0, -8.0, 2.0, 9.0, -7.0, -1.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[2][1], mat3(-5.0, -7.0, 5.0, 0.0, -8.0, 3.0, -1.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[2][2], mat3(4.0, -4.0, 0.0, 6.0, 9.0, 9.0, 1.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[3][0], mat3(0.0, -5.0, 5.0, -4.0, 5.0, 1.0, 4.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[3][1], mat3(-1.0, 3.0, 0.0, 3.0, -9.0, -7.0, -8.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[3][2], mat3(-4.0, 7.0, -3.0, 0.0, -4.0, 7.0, 9.0, 8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec3(-1.0, 1.0, 4.0));
	block.var[0][0][1] = (vec3(6.0, -5.0, -5.0));
	block.var[0][0][2] = (vec3(9.0, -6.0, 5.0));
	block.var[0][1][0] = (vec3(7.0, 7.0, -2.0));
	block.var[0][1][1] = (vec3(-4.0, 1.0, -5.0));
	block.var[0][1][2] = (vec3(8.0, -1.0, -8.0));
	block.var[0][2][0] = (vec3(-6.0, -4.0, 5.0));
	block.var[0][2][1] = (vec3(3.0, 9.0, -8.0));
	block.var[0][2][2] = (vec3(-4.0, 8.0, 0.0));
	block.var[1][0][0] = (vec3(5.0, -1.0, 2.0));
	block.var[1][0][1] = (vec3(3.0, 0.0, 8.0));
	block.var[1][0][2] = (vec3(-8.0, -9.0, -1.0));
	block.var[1][1][0] = (vec3(-9.0, 4.0, -9.0));
	block.var[1][1][1] = (vec3(7.0, 3.0, 7.0));
	block.var[1][1][2] = (vec3(5.0, -4.0, 3.0));
	block.var[1][2][0] = (vec3(-9.0, 9.0, 4.0));
	block.var[1][2][1] = (vec3(7.0, -1.0, 2.0));
	block.var[1][2][2] = (vec3(-5.0, 2.0, -9.0));
	block.var[2][0][0] = (vec3(9.0, -7.0, -5.0));
	block.var[2][0][1] = (vec3(-4.0, -8.0, -6.0));
	block.var[2][0][2] = (vec3(-9.0, -6.0, -5.0));
	block.var[2][1][0] = (vec3(7.0, -5.0, 1.0));
	block.var[2][1][1] = (vec3(-7.0, 6.0, -4.0));
	block.var[2][1][2] = (vec3(-3.0, -4.0, -2.0));
	block.var[2][2][0] = (vec3(-4.0, -4.0, 3.0));
	block.var[2][2][1] = (vec3(-9.0, -7.0, 0.0));
	block.var[2][2][2] = (vec3(3.0, 0.0, -1.0));
	block.var[3][0][0] = (vec3(-5.0, -6.0, 8.0));
	block.var[3][0][1] = (vec3(3.0, 3.0, -1.0));
	block.var[3][0][2] = (vec3(-7.0, 5.0, 7.0));
	block.var[3][1][0] = (vec3(7.0, 4.0, -7.0));
	block.var[3][1][1] = (vec3(7.0, 7.0, -4.0));
	block.var[3][1][2] = (vec3(-5.0, 9.0, -8.0));
	block.var[3][2][0] = (vec3(-6.0, -7.0, -1.0));
	block.var[3][2][1] = (vec3(8.0, 9.0, 3.0));
	block.var[3][2][2] = (vec3(0.0, -5.0, -7.0));
}
#version 450
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
	u16vec2 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(block.var[0][0]), uvec2(8u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[0][1]), uvec2(2u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[0][2]), uvec2(6u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[1][0]), uvec2(7u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[1][1]), uvec2(0u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[1][2]), uvec2(1u, 3u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[2][0]), uvec2(8u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[2][1]), uvec2(7u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[2][2]), uvec2(2u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[3][0]), uvec2(5u, 5u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[3][1]), uvec2(4u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[3][2]), uvec2(6u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = u16vec2(uvec2(8u, 0u));
	block.var[0][1] = u16vec2(uvec2(6u, 0u));
	block.var[0][2] = u16vec2(uvec2(6u, 9u));
	block.var[1][0] = u16vec2(uvec2(3u, 2u));
	block.var[1][1] = u16vec2(uvec2(9u, 2u));
	block.var[1][2] = u16vec2(uvec2(4u, 5u));
	block.var[2][0] = u16vec2(uvec2(1u, 1u));
	block.var[2][1] = u16vec2(uvec2(2u, 8u));
	block.var[2][2] = u16vec2(uvec2(1u, 5u));
	block.var[3][0] = u16vec2(uvec2(0u, 2u));
	block.var[3][1] = u16vec2(uvec2(3u, 8u));
	block.var[3][2] = u16vec2(uvec2(1u, 8u));
}
#version 450
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
	allOk = compare_mat2(block.var[0][0], mat2(8.0, -8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[0][1], mat2(0.0, -4.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[0][2], mat2(-7.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[1][0], mat2(0.0, 6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[1][1], mat2(-4.0, -1.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[1][2], mat2(-1.0, 4.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[2][0], mat2(-7.0, 8.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[2][1], mat2(-9.0, -8.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[2][2], mat2(-4.0, -9.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[3][0], mat2(1.0, -9.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[3][1], mat2(-9.0, -7.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[3][2], mat2(-9.0, 2.0, -7.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec2(-3.0, 3.0));
	block.var[0][0][1] = (vec2(4.0, 4.0));
	block.var[0][1][0] = (vec2(9.0, -9.0));
	block.var[0][1][1] = (vec2(-5.0, 8.0));
	block.var[0][2][0] = (vec2(0.0, 4.0));
	block.var[0][2][1] = (vec2(2.0, -4.0));
	block.var[1][0][0] = (vec2(-3.0, 3.0));
	block.var[1][0][1] = (vec2(-8.0, -7.0));
	block.var[1][1][0] = (vec2(-7.0, -6.0));
	block.var[1][1][1] = (vec2(-2.0, 1.0));
	block.var[1][2][0] = (vec2(-4.0, 3.0));
	block.var[1][2][1] = (vec2(0.0, 7.0));
	block.var[2][0][0] = (vec2(-7.0, -5.0));
	block.var[2][0][1] = (vec2(6.0, -6.0));
	block.var[2][1][0] = (vec2(-4.0, 0.0));
	block.var[2][1][1] = (vec2(2.0, 3.0));
	block.var[2][2][0] = (vec2(-2.0, -4.0));
	block.var[2][2][1] = (vec2(-1.0, 1.0));
	block.var[3][0][0] = (vec2(8.0, -9.0));
	block.var[3][0][1] = (vec2(8.0, -6.0));
	block.var[3][1][0] = (vec2(7.0, -2.0));
	block.var[3][1][1] = (vec2(1.0, -2.0));
	block.var[3][2][0] = (vec2(-7.0, -6.0));
	block.var[3][2][1] = (vec2(8.0, -4.0));
}
#version 450
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

layout(scalar, column_major, buffer_reference) buffer Block
{
	float padding;
	highp mat3x2 var[4][3];
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
	allOk = compare_mat3x2(block.var[0][0], mat3x2(7.0, -1.0, -4.0, 8.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1], mat3x2(7.0, -4.0, -3.0, 4.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2], mat3x2(-3.0, 3.0, -5.0, -3.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0], mat3x2(-4.0, 7.0, 3.0, -4.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1], mat3x2(9.0, -4.0, -9.0, -6.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2], mat3x2(9.0, 2.0, -2.0, -9.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0], mat3x2(6.0, -2.0, 6.0, -7.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1], mat3x2(5.0, 8.0, 3.0, 0.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2], mat3x2(9.0, -2.0, 3.0, -1.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0], mat3x2(4.0, 1.0, -5.0, -2.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1], mat3x2(-8.0, -7.0, -8.0, 1.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][2], mat3x2(-4.0, 7.0, 3.0, 3.0, 2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-8.0);
	block.var[0][0][0] = (vec2(-4.0, -3.0));
	block.var[0][0][1] = (vec2(5.0, -9.0));
	block.var[0][0][2] = (vec2(4.0, -2.0));
	block.var[0][1][0] = (vec2(-1.0, 8.0));
	block.var[0][1][1] = (vec2(3.0, 7.0));
	block.var[0][1][2] = (vec2(2.0, -4.0));
	block.var[0][2][0] = (vec2(4.0, 3.0));
	block.var[0][2][1] = (vec2(-6.0, -4.0));
	block.var[0][2][2] = (vec2(3.0, 4.0));
	block.var[1][0][0] = (vec2(6.0, 3.0));
	block.var[1][0][1] = (vec2(6.0, -2.0));
	block.var[1][0][2] = (vec2(-9.0, -9.0));
	block.var[1][1][0] = (vec2(0.0, -4.0));
	block.var[1][1][1] = (vec2(9.0, -1.0));
	block.var[1][1][2] = (vec2(-1.0, -8.0));
	block.var[1][2][0] = (vec2(6.0, 5.0));
	block.var[1][2][1] = (vec2(-2.0, 1.0));
	block.var[1][2][2] = (vec2(4.0, 2.0));
	block.var[2][0][0] = (vec2(-5.0, -5.0));
	block.var[2][0][1] = (vec2(-9.0, -7.0));
	block.var[2][0][2] = (vec2(3.0, -1.0));
	block.var[2][1][0] = (vec2(0.0, -1.0));
	block.var[2][1][1] = (vec2(4.0, -1.0));
	block.var[2][1][2] = (vec2(-6.0, -8.0));
	block.var[2][2][0] = (vec2(-6.0, 8.0));
	block.var[2][2][1] = (vec2(7.0, 4.0));
	block.var[2][2][2] = (vec2(-9.0, -4.0));
	block.var[3][0][0] = (vec2(-1.0, -3.0));
	block.var[3][0][1] = (vec2(-2.0, -5.0));
	block.var[3][0][2] = (vec2(-2.0, -7.0));
	block.var[3][1][0] = (vec2(-3.0, 5.0));
	block.var[3][1][1] = (vec2(4.0, 4.0));
	block.var[3][1][2] = (vec2(1.0, -3.0));
	block.var[3][2][0] = (vec2(-6.0, -4.0));
	block.var[3][2][1] = (vec2(-2.0, -5.0));
	block.var[3][2][2] = (vec2(-7.0, 2.0));
}
#version 450
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
	f16vec4 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(block.var[0][0][0]), vec4(-8.0, -9.0, 9.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[0][0][1]), vec4(4.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[0][0][2]), vec4(-8.0, 6.0, 1.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[0][1][0]), vec4(7.0, -7.0, -3.0, 1.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[0][1][1]), vec4(7.0, 0.0, -2.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[0][1][2]), vec4(-6.0, -5.0, 8.0, 0.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[1][0][0]), vec4(4.0, 7.0, 5.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[1][0][1]), vec4(7.0, -4.0, -8.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[1][0][2]), vec4(-3.0, 6.0, -4.0, 5.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[1][1][0]), vec4(-9.0, 7.0, -3.0, -1.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[1][1][1]), vec4(2.0, 7.0, 0.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[1][1][2]), vec4(-7.0, 6.0, 0.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[2][0][0]), vec4(2.0, 3.0, -3.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[2][0][1]), vec4(9.0, -9.0, 0.0, 3.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[2][0][2]), vec4(2.0, -2.0, -4.0, -2.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[2][1][0]), vec4(1.0, 0.0, -7.0, 0.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[2][1][1]), vec4(-9.0, 0.0, 9.0, -9.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[2][1][2]), vec4(-5.0, 3.0, 4.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[3][0][0]), vec4(-6.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[3][0][1]), vec4(7.0, 5.0, -9.0, 9.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[3][0][2]), vec4(8.0, 7.0, 9.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[3][1][0]), vec4(-5.0, -8.0, 6.0, -5.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[3][1][1]), vec4(0.0, -8.0, -9.0, 7.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[3][1][2]), vec4(3.0, 9.0, -3.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = f16vec4(vec4(9.0, -6.0, 2.0, -8.0));
	block.var[0][0][1] = f16vec4(vec4(-7.0, -4.0, 2.0, -5.0));
	block.var[0][0][2] = f16vec4(vec4(9.0, 1.0, -6.0, 3.0));
	block.var[0][1][0] = f16vec4(vec4(8.0, 3.0, -7.0, -9.0));
	block.var[0][1][1] = f16vec4(vec4(6.0, -8.0, -8.0, 3.0));
	block.var[0][1][2] = f16vec4(vec4(1.0, -6.0, -6.0, 9.0));
	block.var[1][0][0] = f16vec4(vec4(-1.0, 4.0, -1.0, -8.0));
	block.var[1][0][1] = f16vec4(vec4(5.0, 8.0, 7.0, 0.0));
	block.var[1][0][2] = f16vec4(vec4(4.0, -5.0, -6.0, -8.0));
	block.var[1][1][0] = f16vec4(vec4(9.0, -7.0, 7.0, -4.0));
	block.var[1][1][1] = f16vec4(vec4(-3.0, 0.0, -5.0, -5.0));
	block.var[1][1][2] = f16vec4(vec4(-6.0, -7.0, -2.0, -8.0));
	block.var[2][0][0] = f16vec4(vec4(-6.0, 2.0, -4.0, 8.0));
	block.var[2][0][1] = f16vec4(vec4(-4.0, -1.0, 8.0, 9.0));
	block.var[2][0][2] = f16vec4(vec4(0.0, 0.0, -5.0, 5.0));
	block.var[2][1][0] = f16vec4(vec4(-3.0, -6.0, 7.0, 3.0));
	block.var[2][1][1] = f16vec4(vec4(-6.0, -9.0, -2.0, 7.0));
	block.var[2][1][2] = f16vec4(vec4(2.0, -6.0, -5.0, 8.0));
	block.var[3][0][0] = f16vec4(vec4(7.0, -6.0, -7.0, -8.0));
	block.var[3][0][1] = f16vec4(vec4(-3.0, -4.0, -7.0, 0.0));
	block.var[3][0][2] = f16vec4(vec4(-7.0, -2.0, 7.0, -1.0));
	block.var[3][1][0] = f16vec4(vec4(6.0, 1.0, -5.0, 6.0));
	block.var[3][1][1] = f16vec4(vec4(-5.0, -9.0, -6.0, -4.0));
	block.var[3][1][2] = f16vec4(vec4(-5.0, -8.0, 1.0, 2.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(-4.0, 6.0, 0.0, 6.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(5.0, -1.0, 1.0, 7.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][2], mat3x2(4.0, -5.0, -2.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(-4.0, -8.0, -7.0, -9.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(-1.0, -4.0, -4.0, 6.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][2], mat3x2(-8.0, 8.0, -4.0, -8.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(-2.0, -1.0, 5.0, 2.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(9.0, -5.0, 7.0, 6.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][2], mat3x2(-1.0, -4.0, 0.0, -2.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(-3.0, -7.0, -5.0, -7.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(0.0, -8.0, -1.0, 9.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][2], mat3x2(-7.0, -9.0, 6.0, -5.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(7.0, 3.0, -1.0, 6.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(-8.0, -5.0, 9.0, -3.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][2], mat3x2(-4.0, 6.0, -7.0, 0.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(0.0, 9.0, -1.0, -2.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(4.0, 8.0, 2.0, -7.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][2], mat3x2(2.0, 6.0, -9.0, 3.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][0], mat3x2(-9.0, 0.0, 9.0, -8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][1], mat3x2(-7.0, -5.0, 3.0, -3.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][2], mat3x2(-3.0, -2.0, 3.0, -8.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][0], mat3x2(-6.0, -1.0, -5.0, 1.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][1], mat3x2(2.0, -1.0, -4.0, 7.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][2], mat3x2(5.0, 5.0, 4.0, -6.0, -5.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(9.0, -4.0));
	block.var[0][0][0][1] = (vec2(-7.0, 8.0));
	block.var[0][0][0][2] = (vec2(-2.0, -9.0));
	block.var[0][0][1][0] = (vec2(-1.0, 7.0));
	block.var[0][0][1][1] = (vec2(-3.0, -3.0));
	block.var[0][0][1][2] = (vec2(-8.0, 2.0));
	block.var[0][0][2][0] = (vec2(-2.0, -1.0));
	block.var[0][0][2][1] = (vec2(-3.0, -3.0));
	block.var[0][0][2][2] = (vec2(-4.0, 5.0));
	block.var[0][1][0][0] = (vec2(9.0, 4.0));
	block.var[0][1][0][1] = (vec2(-8.0, -6.0));
	block.var[0][1][0][2] = (vec2(4.0, -6.0));
	block.var[0][1][1][0] = (vec2(-9.0, -3.0));
	block.var[0][1][1][1] = (vec2(8.0, 9.0));
	block.var[0][1][1][2] = (vec2(4.0, -8.0));
	block.var[0][1][2][0] = (vec2(0.0, -4.0));
	block.var[0][1][2][1] = (vec2(6.0, -1.0));
	block.var[0][1][2][2] = (vec2(-7.0, 8.0));
	block.var[1][0][0][0] = (vec2(9.0, 7.0));
	block.var[1][0][0][1] = (vec2(-4.0, 7.0));
	block.var[1][0][0][2] = (vec2(1.0, 6.0));
	block.var[1][0][1][0] = (vec2(-8.0, 9.0));
	block.var[1][0][1][1] = (vec2(8.0, 1.0));
	block.var[1][0][1][2] = (vec2(6.0, 8.0));
	block.var[1][0][2][0] = (vec2(-1.0, 2.0));
	block.var[1][0][2][1] = (vec2(1.0, -1.0));
	block.var[1][0][2][2] = (vec2(0.0, 3.0));
	block.var[1][1][0][0] = (vec2(4.0, 2.0));
	block.var[1][1][0][1] = (vec2(2.0, -3.0));
	block.var[1][1][0][2] = (vec2(1.0, -6.0));
	block.var[1][1][1][0] = (vec2(7.0, 3.0));
	block.var[1][1][1][1] = (vec2(-7.0, 5.0));
	block.var[1][1][1][2] = (vec2(2.0, -9.0));
	block.var[1][1][2][0] = (vec2(-2.0, -8.0));
	block.var[1][1][2][1] = (vec2(-9.0, 5.0));
	block.var[1][1][2][2] = (vec2(-2.0, 1.0));
	block.var[2][0][0][0] = (vec2(-3.0, -2.0));
	block.var[2][0][0][1] = (vec2(-9.0, -8.0));
	block.var[2][0][0][2] = (vec2(-8.0, 4.0));
	block.var[2][0][1][0] = (vec2(-2.0, 9.0));
	block.var[2][0][1][1] = (vec2(-1.0, 3.0));
	block.var[2][0][1][2] = (vec2(-2.0, 9.0));
	block.var[2][0][2][0] = (vec2(-2.0, -4.0));
	block.var[2][0][2][1] = (vec2(-1.0, 9.0));
	block.var[2][0][2][2] = (vec2(-9.0, -4.0));
	block.var[2][1][0][0] = (vec2(2.0, -5.0));
	block.var[2][1][0][1] = (vec2(2.0, 8.0));
	block.var[2][1][0][2] = (vec2(1.0, 5.0));
	block.var[2][1][1][0] = (vec2(-2.0, 0.0));
	block.var[2][1][1][1] = (vec2(-7.0, 5.0));
	block.var[2][1][1][2] = (vec2(-8.0, 2.0));
	block.var[2][1][2][0] = (vec2(6.0, 3.0));
	block.var[2][1][2][1] = (vec2(0.0, 1.0));
	block.var[2][1][2][2] = (vec2(7.0, -7.0));
	block.var[3][0][0][0] = (vec2(-3.0, -2.0));
	block.var[3][0][0][1] = (vec2(7.0, -5.0));
	block.var[3][0][0][2] = (vec2(-5.0, 0.0));
	block.var[3][0][1][0] = (vec2(4.0, -4.0));
	block.var[3][0][1][1] = (vec2(5.0, 5.0));
	block.var[3][0][1][2] = (vec2(2.0, -3.0));
	block.var[3][0][2][0] = (vec2(-5.0, -3.0));
	block.var[3][0][2][1] = (vec2(-7.0, 6.0));
	block.var[3][0][2][2] = (vec2(-6.0, 8.0));
	block.var[3][1][0][0] = (vec2(-4.0, 0.0));
	block.var[3][1][0][1] = (vec2(8.0, -1.0));
	block.var[3][1][0][2] = (vec2(-4.0, -1.0));
	block.var[3][1][1][0] = (vec2(-3.0, 3.0));
	block.var[3][1][1][1] = (vec2(0.0, 5.0));
	block.var[3][1][1][2] = (vec2(-6.0, 4.0));
	block.var[3][1][2][0] = (vec2(-1.0, 1.0));
	block.var[3][1][2][1] = (vec2(-1.0, -6.0));
	block.var[3][1][2][2] = (vec2(3.0, -5.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0][0], mat4x3(7.0, -2.0, 6.0, 3.0, 1.0, -7.0, 1.0, -4.0, 0.0, 9.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][1], mat4x3(3.0, 2.0, 2.0, 6.0, 6.0, 0.0, 3.0, 6.0, -4.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][2], mat4x3(-6.0, -5.0, 4.0, -4.0, 1.0, 2.0, -5.0, 9.0, -7.0, -2.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][0], mat4x3(1.0, 8.0, 9.0, 7.0, 0.0, -2.0, -4.0, 7.0, 0.0, -9.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][1], mat4x3(-9.0, -9.0, -7.0, -5.0, 2.0, 5.0, 0.0, -2.0, -3.0, -6.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][2], mat4x3(-8.0, -7.0, 9.0, 6.0, 6.0, -5.0, -3.0, 9.0, -4.0, -3.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][0], mat4x3(-7.0, 1.0, -9.0, 8.0, 8.0, 5.0, 0.0, 5.0, -1.0, 2.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][1], mat4x3(4.0, -2.0, -8.0, -5.0, -8.0, -5.0, -4.0, -1.0, -1.0, -5.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][2], mat4x3(3.0, 8.0, 5.0, 3.0, -2.0, 8.0, -6.0, -2.0, -8.0, -1.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][0], mat4x3(-5.0, -8.0, -6.0, 4.0, -5.0, 6.0, 5.0, -8.0, 5.0, -9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][1], mat4x3(-5.0, -1.0, 5.0, 4.0, -3.0, -3.0, -5.0, 1.0, -4.0, 6.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][2], mat4x3(0.0, -6.0, -8.0, -7.0, 6.0, -3.0, 0.0, 2.0, -9.0, -7.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][0], mat4x3(-9.0, 0.0, 6.0, -9.0, -9.0, 9.0, 6.0, 9.0, -2.0, 8.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][1], mat4x3(-8.0, 6.0, 8.0, 4.0, -3.0, -9.0, 9.0, 1.0, 2.0, 8.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][2], mat4x3(-4.0, -3.0, 7.0, 7.0, 0.0, -3.0, 5.0, -5.0, -9.0, -3.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][0], mat4x3(-2.0, 8.0, 2.0, 7.0, 9.0, 8.0, -3.0, 8.0, -9.0, -3.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][1], mat4x3(0.0, 8.0, 9.0, -9.0, -9.0, 4.0, 1.0, -1.0, 9.0, 0.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][2], mat4x3(-2.0, -8.0, 7.0, 1.0, 5.0, 7.0, 8.0, -2.0, 4.0, -4.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][0], mat4x3(8.0, -2.0, 1.0, 2.0, -3.0, 9.0, 6.0, -5.0, 8.0, -1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][1], mat4x3(-5.0, -7.0, 4.0, 5.0, 7.0, 5.0, 9.0, 4.0, 8.0, 2.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][2], mat4x3(-8.0, -9.0, -8.0, 2.0, -2.0, 8.0, 4.0, 4.0, -3.0, 2.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][0], mat4x3(6.0, 3.0, 4.0, -2.0, 5.0, 6.0, -9.0, 4.0, 7.0, 7.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][1], mat4x3(9.0, 9.0, -6.0, -7.0, -9.0, -9.0, 5.0, 9.0, 5.0, 4.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][2], mat4x3(3.0, 6.0, -3.0, -8.0, -1.0, 5.0, -8.0, -5.0, 3.0, -4.0, -9.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec3(7.0, 4.0, -4.0));
	block.var[0][0][0][1] = (vec3(-6.0, 3.0, -3.0));
	block.var[0][0][0][2] = (vec3(9.0, -2.0, 3.0));
	block.var[0][0][0][3] = (vec3(9.0, -9.0, 7.0));
	block.var[0][0][1][0] = (vec3(5.0, 1.0, -9.0));
	block.var[0][0][1][1] = (vec3(-1.0, -2.0, 6.0));
	block.var[0][0][1][2] = (vec3(-4.0, 6.0, 4.0));
	block.var[0][0][1][3] = (vec3(-8.0, 7.0, 3.0));
	block.var[0][0][2][0] = (vec3(-4.0, -9.0, 8.0));
	block.var[0][0][2][1] = (vec3(9.0, 2.0, 2.0));
	block.var[0][0][2][2] = (vec3(9.0, -7.0, 3.0));
	block.var[0][0][2][3] = (vec3(8.0, 2.0, 4.0));
	block.var[0][1][0][0] = (vec3(-5.0, 2.0, -4.0));
	block.var[0][1][0][1] = (vec3(-7.0, -3.0, -4.0));
	block.var[0][1][0][2] = (vec3(4.0, -3.0, -8.0));
	block.var[0][1][0][3] = (vec3(-5.0, -1.0, 1.0));
	block.var[0][1][1][0] = (vec3(6.0, -2.0, 8.0));
	block.var[0][1][1][1] = (vec3(-7.0, 1.0, 4.0));
	block.var[0][1][1][2] = (vec3(6.0, 8.0, -5.0));
	block.var[0][1][1][3] = (vec3(1.0, -6.0, 4.0));
	block.var[0][1][2][0] = (vec3(-9.0, 3.0, -3.0));
	block.var[0][1][2][1] = (vec3(0.0, -5.0, -3.0));
	block.var[0][1][2][2] = (vec3(-5.0, -8.0, 3.0));
	block.var[0][1][2][3] = (vec3(3.0, -6.0, 8.0));
	block.var[1][0][0][0] = (vec3(2.0, 4.0, -3.0));
	block.var[1][0][0][1] = (vec3(-8.0, 7.0, 3.0));
	block.var[1][0][0][2] = (vec3(0.0, -8.0, 0.0));
	block.var[1][0][0][3] = (vec3(6.0, -9.0, 0.0));
	block.var[1][0][1][0] = (vec3(-4.0, 5.0, 5.0));
	block.var[1][0][1][1] = (vec3(-7.0, -8.0, -1.0));
	block.var[1][0][1][2] = (vec3(6.0, -3.0, -5.0));
	block.var[1][0][1][3] = (vec3(0.0, 8.0, -8.0));
	block.var[1][0][2][0] = (vec3(-4.0, 4.0, 8.0));
	block.var[1][0][2][1] = (vec3(-4.0, -4.0, -3.0));
	block.var[1][0][2][2] = (vec3(3.0, 3.0, 2.0));
	block.var[1][0][2][3] = (vec3(8.0, -8.0, -6.0));
	block.var[1][1][0][0] = (vec3(-3.0, 5.0, 6.0));
	block.var[1][1][0][1] = (vec3(5.0, -1.0, 6.0));
	block.var[1][1][0][2] = (vec3(8.0, 7.0, 1.0));
	block.var[1][1][0][3] = (vec3(-5.0, 6.0, -6.0));
	block.var[1][1][1][0] = (vec3(-3.0, -7.0, 7.0));
	block.var[1][1][1][1] = (vec3(-9.0, -3.0, 6.0));
	block.var[1][1][1][2] = (vec3(0.0, -7.0, 3.0));
	block.var[1][1][1][3] = (vec3(2.0, -7.0, 1.0));
	block.var[1][1][2][0] = (vec3(8.0, -1.0, -9.0));
	block.var[1][1][2][1] = (vec3(8.0, 8.0, 2.0));
	block.var[1][1][2][2] = (vec3(7.0, -5.0, -2.0));
	block.var[1][1][2][3] = (vec3(-9.0, 6.0, 2.0));
	block.var[2][0][0][0] = (vec3(9.0, 1.0, -1.0));
	block.var[2][0][0][1] = (vec3(-1.0, 2.0, 4.0));
	block.var[2][0][0][2] = (vec3(4.0, 2.0, 0.0));
	block.var[2][0][0][3] = (vec3(5.0, 6.0, -6.0));
	block.var[2][0][1][0] = (vec3(-3.0, 7.0, -6.0));
	block.var[2][0][1][1] = (vec3(7.0, 9.0, 8.0));
	block.var[2][0][1][2] = (vec3(-9.0, -9.0, -9.0));
	block.var[2][0][1][3] = (vec3(6.0, -7.0, -3.0));
	block.var[2][0][2][0] = (vec3(7.0, -1.0, -4.0));
	block.var[2][0][2][1] = (vec3(-9.0, 0.0, -1.0));
	block.var[2][0][2][2] = (vec3(-7.0, -2.0, -3.0));
	block.var[2][0][2][3] = (vec3(1.0, 4.0, 5.0));
	block.var[2][1][0][0] = (vec3(-1.0, 7.0, 7.0));
	block.var[2][1][0][1] = (vec3(3.0, -4.0, -1.0));
	block.var[2][1][0][2] = (vec3(-4.0, 5.0, 7.0));
	block.var[2][1][0][3] = (vec3(-5.0, 7.0, 5.0));
	block.var[2][1][1][0] = (vec3(-1.0, -1.0, 5.0));
	block.var[2][1][1][1] = (vec3(9.0, 7.0, -5.0));
	block.var[2][1][1][2] = (vec3(3.0, -1.0, 3.0));
	block.var[2][1][1][3] = (vec3(8.0, -5.0, 3.0));
	block.var[2][1][2][0] = (vec3(-6.0, 1.0, 0.0));
	block.var[2][1][2][1] = (vec3(8.0, -8.0, 5.0));
	block.var[2][1][2][2] = (vec3(-3.0, 5.0, -4.0));
	block.var[2][1][2][3] = (vec3(-3.0, -2.0, 2.0));
	block.var[3][0][0][0] = (vec3(9.0, 8.0, 7.0));
	block.var[3][0][0][1] = (vec3(5.0, 4.0, 7.0));
	block.var[3][0][0][2] = (vec3(3.0, -3.0, 4.0));
	block.var[3][0][0][3] = (vec3(3.0, -6.0, 5.0));
	block.var[3][0][1][0] = (vec3(-8.0, -4.0, -9.0));
	block.var[3][0][1][1] = (vec3(4.0, 8.0, -3.0));
	block.var[3][0][1][2] = (vec3(-9.0, 7.0, -2.0));
	block.var[3][0][1][3] = (vec3(0.0, -3.0, -3.0));
	block.var[3][0][2][0] = (vec3(4.0, -2.0, -4.0));
	block.var[3][0][2][1] = (vec3(-5.0, -7.0, 1.0));
	block.var[3][0][2][2] = (vec3(-8.0, 1.0, 9.0));
	block.var[3][0][2][3] = (vec3(-8.0, 0.0, -2.0));
	block.var[3][1][0][0] = (vec3(-5.0, 3.0, -6.0));
	block.var[3][1][0][1] = (vec3(-6.0, -4.0, -2.0));
	block.var[3][1][0][2] = (vec3(-5.0, -2.0, -2.0));
	block.var[3][1][0][3] = (vec3(-8.0, 2.0, 4.0));
	block.var[3][1][1][0] = (vec3(-1.0, -1.0, 1.0));
	block.var[3][1][1][1] = (vec3(-9.0, -7.0, -8.0));
	block.var[3][1][1][2] = (vec3(-8.0, -5.0, -1.0));
	block.var[3][1][1][3] = (vec3(2.0, 0.0, -4.0));
	block.var[3][1][2][0] = (vec3(7.0, 6.0, 4.0));
	block.var[3][1][2][1] = (vec3(-5.0, -5.0, 8.0));
	block.var[3][1][2][2] = (vec3(-3.0, 4.0, -5.0));
	block.var[3][1][2][3] = (vec3(-8.0, 5.0, -2.0));
}
#version 450
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
	allOk = compare_float((block.padding), -6.0) && allOk;
	allOk = compare_mat3(block.var[0][0][0], mat3(-8.0, -3.0, -9.0, -1.0, 8.0, 8.0, 3.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(1.0, 3.0, 0.0, -1.0, -1.0, -1.0, 5.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][2], mat3(1.0, -7.0, 1.0, 3.0, 1.0, 1.0, 4.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(-4.0, -1.0, -2.0, 2.0, -4.0, -2.0, -7.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(5.0, 2.0, -2.0, 5.0, 7.0, 6.0, -7.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][2], mat3(0.0, -1.0, 8.0, 6.0, -4.0, 9.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(7.0, -9.0, -1.0, 5.0, -4.0, -7.0, -2.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(3.0, 0.0, 1.0, 6.0, 4.0, -7.0, 3.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][2], mat3(9.0, -3.0, 2.0, 4.0, 3.0, -9.0, 6.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(3.0, 3.0, -2.0, 9.0, 6.0, -1.0, 7.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(1.0, 0.0, -1.0, -5.0, 3.0, 3.0, 4.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][2], mat3(4.0, 7.0, -5.0, 6.0, -1.0, -8.0, 4.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(5.0, 7.0, -9.0, 3.0, -3.0, 8.0, 3.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(3.0, 4.0, -7.0, 5.0, -5.0, 5.0, 3.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][2], mat3(-9.0, -4.0, 5.0, 3.0, 1.0, -8.0, 0.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(-6.0, -4.0, -4.0, 7.0, -9.0, -8.0, -5.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(-2.0, -6.0, -6.0, 1.0, 5.0, 8.0, 4.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][2], mat3(5.0, 0.0, 4.0, 4.0, -2.0, 2.0, -1.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][0], mat3(1.0, -5.0, 4.0, 2.0, -5.0, 1.0, 7.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][1], mat3(7.0, 8.0, 5.0, 7.0, 0.0, 0.0, -9.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][2], mat3(9.0, -5.0, 8.0, -5.0, -9.0, 7.0, -3.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][0], mat3(-6.0, 5.0, -7.0, -5.0, -1.0, -1.0, -1.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][1], mat3(6.0, 0.0, 5.0, 6.0, -4.0, -8.0, 8.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][2], mat3(-6.0, -7.0, -9.0, -5.0, -2.0, -5.0, 7.0, 3.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (8.0);
	block.var[0][0][0][0] = (vec3(6.0, 2.0, -9.0));
	block.var[0][0][0][1] = (vec3(-8.0, 5.0, 2.0));
	block.var[0][0][0][2] = (vec3(3.0, 9.0, 3.0));
	block.var[0][0][1][0] = (vec3(2.0, -9.0, -5.0));
	block.var[0][0][1][1] = (vec3(5.0, 8.0, 8.0));
	block.var[0][0][1][2] = (vec3(-3.0, -4.0, -5.0));
	block.var[0][0][2][0] = (vec3(3.0, -5.0, -4.0));
	block.var[0][0][2][1] = (vec3(-7.0, 5.0, 3.0));
	block.var[0][0][2][2] = (vec3(-3.0, -3.0, -8.0));
	block.var[0][1][0][0] = (vec3(1.0, 7.0, -5.0));
	block.var[0][1][0][1] = (vec3(7.0, 9.0, 4.0));
	block.var[0][1][0][2] = (vec3(8.0, 7.0, -2.0));
	block.var[0][1][1][0] = (vec3(-8.0, -6.0, 7.0));
	block.var[0][1][1][1] = (vec3(-3.0, 2.0, -5.0));
	block.var[0][1][1][2] = (vec3(2.0, 1.0, -6.0));
	block.var[0][1][2][0] = (vec3(1.0, 3.0, -7.0));
	block.var[0][1][2][1] = (vec3(6.0, -8.0, 4.0));
	block.var[0][1][2][2] = (vec3(6.0, -7.0, -3.0));
	block.var[1][0][0][0] = (vec3(8.0, 2.0, -9.0));
	block.var[1][0][0][1] = (vec3(-3.0, 6.0, -3.0));
	block.var[1][0][0][2] = (vec3(7.0, 8.0, 7.0));
	block.var[1][0][1][0] = (vec3(-7.0, 6.0, -7.0));
	block.var[1][0][1][1] = (vec3(2.0, 3.0, -3.0));
	block.var[1][0][1][2] = (vec3(-3.0, 6.0, -1.0));
	block.var[1][0][2][0] = (vec3(8.0, 4.0, -3.0));
	block.var[1][0][2][1] = (vec3(8.0, -6.0, 4.0));
	block.var[1][0][2][2] = (vec3(-5.0, -1.0, 5.0));
	block.var[1][1][0][0] = (vec3(-5.0, -8.0, 8.0));
	block.var[1][1][0][1] = (vec3(7.0, 2.0, -3.0));
	block.var[1][1][0][2] = (vec3(-8.0, 3.0, 3.0));
	block.var[1][1][1][0] = (vec3(-1.0, 6.0, 7.0));
	block.var[1][1][1][1] = (vec3(9.0, -1.0, 2.0));
	block.var[1][1][1][2] = (vec3(-1.0, -6.0, -9.0));
	block.var[1][1][2][0] = (vec3(4.0, 9.0, 5.0));
	block.var[1][1][2][1] = (vec3(5.0, 4.0, -9.0));
	block.var[1][1][2][2] = (vec3(-6.0, 9.0, 3.0));
	block.var[2][0][0][0] = (vec3(1.0, -3.0, -7.0));
	block.var[2][0][0][1] = (vec3(-5.0, 4.0, 1.0));
	block.var[2][0][0][2] = (vec3(9.0, -7.0, -3.0));
	block.var[2][0][1][0] = (vec3(-5.0, 6.0, 2.0));
	block.var[2][0][1][1] = (vec3(-9.0, -9.0, -1.0));
	block.var[2][0][1][2] = (vec3(-5.0, -8.0, 2.0));
	block.var[2][0][2][0] = (vec3(-6.0, 0.0, 3.0));
	block.var[2][0][2][1] = (vec3(9.0, -8.0, 3.0));
	block.var[2][0][2][2] = (vec3(8.0, -8.0, -9.0));
	block.var[2][1][0][0] = (vec3(1.0, -2.0, 0.0));
	block.var[2][1][0][1] = (vec3(-9.0, 5.0, 1.0));
	block.var[2][1][0][2] = (vec3(3.0, 8.0, -2.0));
	block.var[2][1][1][0] = (vec3(-3.0, 7.0, -8.0));
	block.var[2][1][1][1] = (vec3(0.0, 1.0, -3.0));
	block.var[2][1][1][2] = (vec3(0.0, 0.0, -7.0));
	block.var[2][1][2][0] = (vec3(-2.0, -1.0, -5.0));
	block.var[2][1][2][1] = (vec3(-1.0, 4.0, -2.0));
	block.var[2][1][2][2] = (vec3(1.0, 4.0, -9.0));
	block.var[3][0][0][0] = (vec3(6.0, -4.0, -8.0));
	block.var[3][0][0][1] = (vec3(3.0, 8.0, 1.0));
	block.var[3][0][0][2] = (vec3(9.0, 2.0, -9.0));
	block.var[3][0][1][0] = (vec3(-4.0, -1.0, -4.0));
	block.var[3][0][1][1] = (vec3(-6.0, 4.0, 9.0));
	block.var[3][0][1][2] = (vec3(-5.0, -7.0, -3.0));
	block.var[3][0][2][0] = (vec3(-9.0, -5.0, -9.0));
	block.var[3][0][2][1] = (vec3(-1.0, -9.0, 7.0));
	block.var[3][0][2][2] = (vec3(-9.0, 0.0, -4.0));
	block.var[3][1][0][0] = (vec3(-4.0, 8.0, 0.0));
	block.var[3][1][0][1] = (vec3(-5.0, -4.0, 2.0));
	block.var[3][1][0][2] = (vec3(-3.0, 6.0, -8.0));
	block.var[3][1][1][0] = (vec3(-8.0, 8.0, 0.0));
	block.var[3][1][1][1] = (vec3(-8.0, -6.0, -9.0));
	block.var[3][1][1][2] = (vec3(0.0, -8.0, 1.0));
	block.var[3][1][2][0] = (vec3(-2.0, 9.0, -6.0));
	block.var[3][1][2][1] = (vec3(-2.0, 6.0, 0.0));
	block.var[3][1][2][2] = (vec3(3.0, 8.0, 4.0));
}
#version 450
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
	allOk = compare_float((block.padding), -7.0) && allOk;
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(-1.0, -3.0, -6.0, -2.0, 4.0, -8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(9.0, -2.0, -3.0, 3.0, 3.0, 3.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][2], mat2x4(2.0, -4.0, 1.0, -2.0, -8.0, -7.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(7.0, -6.0, -6.0, -4.0, -1.0, 5.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(0.0, -1.0, 1.0, -2.0, -5.0, 0.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][2], mat2x4(7.0, 8.0, 8.0, -5.0, -8.0, 2.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(4.0, 2.0, -6.0, -7.0, -3.0, -4.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(2.0, -5.0, -2.0, -1.0, 5.0, 6.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][2], mat2x4(-6.0, 3.0, -5.0, -6.0, 5.0, 6.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(9.0, -1.0, -6.0, 3.0, 9.0, 2.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(-8.0, -5.0, 4.0, -4.0, -5.0, 8.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][2], mat2x4(-3.0, -8.0, 8.0, 8.0, -2.0, 7.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(8.0, 3.0, 6.0, 7.0, -1.0, -2.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(-4.0, -9.0, 5.0, -4.0, 9.0, -4.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][2], mat2x4(9.0, 8.0, 9.0, -6.0, 0.0, 4.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(-2.0, -2.0, 9.0, -2.0, 3.0, 7.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(-1.0, -5.0, 9.0, -1.0, -8.0, -6.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][2], mat2x4(6.0, 2.0, -6.0, 9.0, -8.0, 5.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][0], mat2x4(4.0, 4.0, 1.0, 6.0, -8.0, -5.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][1], mat2x4(1.0, -9.0, -7.0, 3.0, 9.0, -1.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][2], mat2x4(7.0, -6.0, 2.0, 0.0, -3.0, -4.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][0], mat2x4(4.0, -9.0, -9.0, -7.0, -2.0, -4.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][1], mat2x4(-5.0, -6.0, 1.0, 6.0, -7.0, 2.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][2], mat2x4(-4.0, -5.0, -1.0, -7.0, 6.0, -3.0, -2.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (4.0);
	block.var[0][0][0][0] = (vec4(-6.0, -9.0, -3.0, 5.0));
	block.var[0][0][0][1] = (vec4(1.0, -7.0, 1.0, -7.0));
	block.var[0][0][1][0] = (vec4(-4.0, 1.0, 9.0, -1.0));
	block.var[0][0][1][1] = (vec4(-2.0, 2.0, 4.0, -1.0));
	block.var[0][0][2][0] = (vec4(-9.0, -6.0, 6.0, -7.0));
	block.var[0][0][2][1] = (vec4(5.0, 8.0, 4.0, -8.0));
	block.var[0][1][0][0] = (vec4(4.0, -9.0, 1.0, 0.0));
	block.var[0][1][0][1] = (vec4(-5.0, 6.0, -3.0, -9.0));
	block.var[0][1][1][0] = (vec4(-4.0, 8.0, -1.0, 7.0));
	block.var[0][1][1][1] = (vec4(-1.0, -9.0, -2.0, -9.0));
	block.var[0][1][2][0] = (vec4(-6.0, -1.0, -3.0, 6.0));
	block.var[0][1][2][1] = (vec4(-6.0, 2.0, 1.0, -3.0));
	block.var[1][0][0][0] = (vec4(1.0, 8.0, -9.0, -7.0));
	block.var[1][0][0][1] = (vec4(-8.0, 4.0, -2.0, 5.0));
	block.var[1][0][1][0] = (vec4(5.0, -2.0, 2.0, -6.0));
	block.var[1][0][1][1] = (vec4(0.0, 8.0, 8.0, -6.0));
	block.var[1][0][2][0] = (vec4(-5.0, 0.0, 5.0, -1.0));
	block.var[1][0][2][1] = (vec4(2.0, 3.0, 0.0, 1.0));
	block.var[1][1][0][0] = (vec4(-3.0, -5.0, -1.0, 4.0));
	block.var[1][1][0][1] = (vec4(0.0, -9.0, -1.0, 1.0));
	block.var[1][1][1][0] = (vec4(-2.0, 4.0, -4.0, 3.0));
	block.var[1][1][1][1] = (vec4(-9.0, 0.0, -4.0, -7.0));
	block.var[1][1][2][0] = (vec4(7.0, 9.0, -2.0, 5.0));
	block.var[1][1][2][1] = (vec4(-3.0, -5.0, 5.0, -2.0));
	block.var[2][0][0][0] = (vec4(-8.0, 7.0, 2.0, 5.0));
	block.var[2][0][0][1] = (vec4(-8.0, 3.0, 8.0, 1.0));
	block.var[2][0][1][0] = (vec4(5.0, 3.0, -5.0, 5.0));
	block.var[2][0][1][1] = (vec4(-8.0, 3.0, 1.0, 3.0));
	block.var[2][0][2][0] = (vec4(9.0, -9.0, -1.0, 5.0));
	block.var[2][0][2][1] = (vec4(7.0, 6.0, 7.0, 7.0));
	block.var[2][1][0][0] = (vec4(4.0, 0.0, -2.0, 9.0));
	block.var[2][1][0][1] = (vec4(-8.0, 7.0, 0.0, -8.0));
	block.var[2][1][1][0] = (vec4(7.0, 0.0, 3.0, 1.0));
	block.var[2][1][1][1] = (vec4(-9.0, -3.0, -8.0, 1.0));
	block.var[2][1][2][0] = (vec4(2.0, -4.0, -3.0, 6.0));
	block.var[2][1][2][1] = (vec4(-7.0, 1.0, 0.0, -8.0));
	block.var[3][0][0][0] = (vec4(-3.0, 4.0, 4.0, -9.0));
	block.var[3][0][0][1] = (vec4(-1.0, -2.0, -1.0, -1.0));
	block.var[3][0][1][0] = (vec4(7.0, -2.0, 3.0, 7.0));
	block.var[3][0][1][1] = (vec4(-2.0, -4.0, -8.0, 2.0));
	block.var[3][0][2][0] = (vec4(7.0, 2.0, -9.0, -2.0));
	block.var[3][0][2][1] = (vec4(-1.0, 1.0, -4.0, -7.0));
	block.var[3][1][0][0] = (vec4(1.0, -9.0, 2.0, 9.0));
	block.var[3][1][0][1] = (vec4(1.0, 2.0, -7.0, 9.0));
	block.var[3][1][1][0] = (vec4(-9.0, -9.0, -8.0, -5.0));
	block.var[3][1][1][1] = (vec4(8.0, 3.0, -6.0, -2.0));
	block.var[3][1][2][0] = (vec4(-3.0, 3.0, -1.0, 8.0));
	block.var[3][1][2][1] = (vec4(7.0, -4.0, -8.0, 2.0));
}
#version 450
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
	allOk = compare_float((block.padding), -5.0) && allOk;
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(-4.0, 7.0, 2.0, 0.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(3.0, -1.0, 3.0, -5.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][2], mat3x2(-8.0, 5.0, -4.0, 8.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(-9.0, -3.0, 8.0, 0.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(2.0, 2.0, -9.0, -9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][2], mat3x2(-2.0, 0.0, 0.0, 3.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(-1.0, -9.0, -5.0, -2.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(1.0, -2.0, -4.0, 1.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][2], mat3x2(0.0, 1.0, 7.0, 4.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(9.0, 8.0, 3.0, 2.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(-4.0, 5.0, -3.0, 4.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][2], mat3x2(4.0, 2.0, -9.0, -7.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(4.0, -7.0, 8.0, 0.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(1.0, -4.0, -3.0, 4.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][2], mat3x2(1.0, 0.0, 8.0, -1.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(3.0, 7.0, -8.0, 8.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(8.0, 4.0, 6.0, 6.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][2], mat3x2(-7.0, 4.0, -5.0, 7.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][0], mat3x2(6.0, 8.0, 7.0, 5.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][1], mat3x2(-6.0, 0.0, 7.0, 3.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][2], mat3x2(-5.0, -6.0, 5.0, -8.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][0], mat3x2(-2.0, 1.0, 3.0, 0.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][1], mat3x2(9.0, 1.0, -3.0, -8.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][2], mat3x2(9.0, -6.0, 5.0, -2.0, -3.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-3.0);
	block.var[0][0][0] = (mat3x2(-3.0, -4.0, 2.0, -7.0, 7.0, -2.0));
	block.var[0][0][1] = (mat3x2(-8.0, -2.0, 3.0, 4.0, 9.0, 4.0));
	block.var[0][0][2] = (mat3x2(-7.0, 9.0, 9.0, -1.0, 1.0, -9.0));
	block.var[0][1][0] = (mat3x2(6.0, -9.0, -2.0, -7.0, -4.0, -2.0));
	block.var[0][1][1] = (mat3x2(-1.0, 7.0, 3.0, -9.0, -2.0, 6.0));
	block.var[0][1][2] = (mat3x2(1.0, -2.0, -2.0, 3.0, -8.0, -9.0));
	block.var[1][0][0] = (mat3x2(0.0, -8.0, -3.0, 8.0, 3.0, 5.0));
	block.var[1][0][1] = (mat3x2(9.0, 0.0, 9.0, 8.0, 0.0, 2.0));
	block.var[1][0][2] = (mat3x2(0.0, 7.0, 6.0, 4.0, 6.0, 9.0));
	block.var[1][1][0] = (mat3x2(3.0, 2.0, 3.0, 7.0, 8.0, -9.0));
	block.var[1][1][1] = (mat3x2(-6.0, -9.0, -4.0, -8.0, 3.0, 5.0));
	block.var[1][1][2] = (mat3x2(8.0, -6.0, -8.0, -4.0, 8.0, -3.0));
	block.var[2][0][0] = (mat3x2(7.0, -2.0, 8.0, 3.0, 7.0, -9.0));
	block.var[2][0][1] = (mat3x2(4.0, -5.0, 3.0, -6.0, 8.0, 7.0));
	block.var[2][0][2] = (mat3x2(6.0, 3.0, 5.0, 1.0, 2.0, 0.0));
	block.var[2][1][0] = (mat3x2(-3.0, -9.0, 1.0, -7.0, 2.0, 6.0));
	block.var[2][1][1] = (mat3x2(9.0, -6.0, 7.0, 1.0, -2.0, 9.0));
	block.var[2][1][2] = (mat3x2(-3.0, 1.0, -1.0, 0.0, 6.0, 3.0));
	block.var[3][0][0] = (mat3x2(-4.0, 0.0, -9.0, 0.0, 8.0, 7.0));
	block.var[3][0][1] = (mat3x2(5.0, -1.0, 3.0, -3.0, 3.0, -2.0));
	block.var[3][0][2] = (mat3x2(0.0, -5.0, -9.0, -4.0, 1.0, 7.0));
	block.var[3][1][0] = (mat3x2(6.0, 0.0, -2.0, 4.0, -9.0, 9.0));
	block.var[3][1][1] = (mat3x2(5.0, -7.0, 2.0, 1.0, 1.0, 8.0));
	block.var[3][1][2] = (mat3x2(9.0, 6.0, -1.0, 4.0, 8.0, -4.0));
}
#version 450
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
	allOk = compare_float((block.padding), -1.0) && allOk;
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(4.0, -9.0, -1.0, -8.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(6.0, 3.0, 1.0, 8.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][2], mat3x2(-3.0, 3.0, -3.0, -4.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(3.0, -2.0, 8.0, -5.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(9.0, -3.0, 8.0, 4.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][2], mat3x2(-3.0, 6.0, 0.0, -8.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(1.0, -3.0, -8.0, -2.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(8.0, 7.0, 7.0, -8.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][2], mat3x2(-7.0, 1.0, -1.0, 4.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(-8.0, 1.0, -6.0, -3.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(9.0, 4.0, 6.0, -4.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][2], mat3x2(-7.0, 6.0, 0.0, -3.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(-8.0, -7.0, 7.0, 2.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(9.0, -2.0, 2.0, 1.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][2], mat3x2(9.0, 6.0, 2.0, 9.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(9.0, 5.0, -2.0, -4.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(6.0, 4.0, 5.0, 1.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][2], mat3x2(-9.0, -7.0, 3.0, -4.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][0], mat3x2(1.0, 1.0, 8.0, 4.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][1], mat3x2(7.0, -2.0, -4.0, 1.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][2], mat3x2(-1.0, -7.0, 9.0, 5.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][0], mat3x2(9.0, 2.0, -2.0, -8.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][1], mat3x2(1.0, 6.0, 9.0, 8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][2], mat3x2(-2.0, -9.0, -3.0, -9.0, 8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-2.0);
	block.var[0][0][0] = (mat3x2(-2.0, -8.0, 0.0, -9.0, 9.0, 0.0));
	block.var[0][0][1] = (mat3x2(1.0, -3.0, -6.0, -5.0, -7.0, 5.0));
	block.var[0][0][2] = (mat3x2(-4.0, 8.0, -1.0, -8.0, 1.0, 2.0));
	block.var[0][1][0] = (mat3x2(-7.0, -1.0, 1.0, -5.0, 2.0, 5.0));
	block.var[0][1][1] = (mat3x2(5.0, 3.0, -9.0, 7.0, -4.0, -1.0));
	block.var[0][1][2] = (mat3x2(-7.0, -6.0, -4.0, -4.0, 8.0, 3.0));
	block.var[1][0][0] = (mat3x2(1.0, -5.0, 0.0, -3.0, 1.0, -4.0));
	block.var[1][0][1] = (mat3x2(4.0, 5.0, -5.0, -6.0, 3.0, 1.0));
	block.var[1][0][2] = (mat3x2(-2.0, 3.0, -8.0, -6.0, 2.0, -5.0));
	block.var[1][1][0] = (mat3x2(-5.0, 8.0, 6.0, 0.0, -2.0, 9.0));
	block.var[1][1][1] = (mat3x2(-9.0, -7.0, -9.0, -9.0, 4.0, 5.0));
	block.var[1][1][2] = (mat3x2(9.0, 6.0, -1.0, 0.0, -2.0, -2.0));
	block.var[2][0][0] = (mat3x2(-4.0, -8.0, 9.0, -9.0, -8.0, 8.0));
	block.var[2][0][1] = (mat3x2(-4.0, 1.0, -1.0, 7.0, 0.0, 1.0));
	block.var[2][0][2] = (mat3x2(-3.0, 6.0, -4.0, -6.0, -5.0, -6.0));
	block.var[2][1][0] = (mat3x2(-4.0, 7.0, -2.0, 0.0, 0.0, -4.0));
	block.var[2][1][1] = (mat3x2(1.0, -6.0, -5.0, -1.0, 0.0, -7.0));
	block.var[2][1][2] = (mat3x2(-3.0, -5.0, -9.0, 7.0, -3.0, 4.0));
	block.var[3][0][0] = (mat3x2(-4.0, 6.0, 4.0, 2.0, -8.0, 2.0));
	block.var[3][0][1] = (mat3x2(1.0, -3.0, -3.0, -5.0, -1.0, 6.0));
	block.var[3][0][2] = (mat3x2(9.0, 9.0, 9.0, -4.0, 8.0, -7.0));
	block.var[3][1][0] = (mat3x2(1.0, 0.0, 2.0, -6.0, -1.0, -4.0));
	block.var[3][1][1] = (mat3x2(4.0, 0.0, -1.0, -4.0, -4.0, -2.0));
	block.var[3][1][2] = (mat3x2(9.0, 8.0, 9.0, -3.0, -7.0, 0.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0][0][0], mat3x4(9.0, -4.0, -6.0, 2.0, -9.0, -8.0, 7.0, 0.0, 5.0, 3.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][1], mat3x4(9.0, -7.0, 0.0, 6.0, -3.0, 8.0, 6.0, -6.0, -6.0, -4.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(4.0, 6.0, -1.0, -2.0, -4.0, 0.0, 4.0, -8.0, 3.0, 4.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(8.0, 7.0, 4.0, -4.0, 0.0, 2.0, -5.0, 4.0, 0.0, 7.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][0], mat3x4(0.0, 6.0, 3.0, 9.0, -3.0, 9.0, 3.0, -5.0, -1.0, 6.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][1], mat3x4(-7.0, 6.0, 5.0, -7.0, -2.0, -4.0, 0.0, -8.0, 8.0, 9.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][0], mat3x4(-2.0, 9.0, -5.0, -3.0, 3.0, 5.0, 4.0, -7.0, -1.0, 4.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][1], mat3x4(-5.0, 1.0, 5.0, -9.0, 3.0, 5.0, 3.0, 8.0, -8.0, -5.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(-7.0, 5.0, -6.0, 7.0, -4.0, -9.0, -9.0, -4.0, -8.0, -8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(-5.0, 6.0, 2.0, -2.0, -3.0, 2.0, 4.0, -3.0, 5.0, 5.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(7.0, -8.0, 6.0, -8.0, -3.0, -8.0, 4.0, 7.0, 5.0, -2.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(-3.0, -4.0, 8.0, 5.0, -1.0, -5.0, -2.0, 2.0, -8.0, -8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][0], mat3x4(4.0, 4.0, -6.0, -2.0, 7.0, 1.0, -3.0, -2.0, -6.0, -2.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][1], mat3x4(-6.0, -4.0, 8.0, -5.0, -5.0, 7.0, 3.0, -1.0, 7.0, -4.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][0], mat3x4(-9.0, -3.0, -8.0, -8.0, 8.0, 8.0, 3.0, -6.0, -7.0, 4.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][1], mat3x4(7.0, 0.0, 9.0, -1.0, 2.0, 9.0, -3.0, 7.0, 4.0, -2.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(-6.0, 9.0, 8.0, 1.0, -2.0, 9.0, 1.0, -5.0, -9.0, 9.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(-4.0, 0.0, 9.0, -6.0, -9.0, -7.0, -7.0, 1.0, 1.0, 2.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(6.0, -3.0, -1.0, -3.0, -7.0, -6.0, 1.0, -7.0, -1.0, 8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(-1.0, -8.0, 0.0, 1.0, 7.0, -5.0, -6.0, 7.0, 5.0, -3.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][0], mat3x4(5.0, -1.0, 4.0, -5.0, -8.0, -7.0, 7.0, -6.0, -4.0, 6.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][1], mat3x4(-5.0, 3.0, 9.0, 0.0, 1.0, 3.0, -8.0, -9.0, 5.0, 8.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][0], mat3x4(-4.0, -4.0, -1.0, -8.0, 9.0, -4.0, -1.0, -5.0, -8.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][1], mat3x4(7.0, -1.0, -3.0, -4.0, -4.0, -3.0, 3.0, -7.0, -5.0, 8.0, 1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3x4(3.0, -9.0, -6.0, 7.0, 6.0, -8.0, -1.0, 1.0, -9.0, 7.0, 6.0, 6.0));
	block.var[0][0][1] = (mat3x4(-5.0, -1.0, -8.0, 3.0, 9.0, 9.0, -8.0, 0.0, 0.0, -9.0, -6.0, -7.0));
	block.var[0][1][0] = (mat3x4(-4.0, 2.0, -8.0, -7.0, -3.0, 6.0, 6.0, 8.0, -4.0, -1.0, 1.0, -9.0));
	block.var[0][1][1] = (mat3x4(9.0, -2.0, 4.0, 3.0, -2.0, 8.0, -4.0, 5.0, -8.0, 8.0, -2.0, 7.0));
	block.var[0][2][0] = (mat3x4(-6.0, 0.0, 1.0, -2.0, 1.0, -4.0, -2.0, -6.0, -7.0, -8.0, 0.0, -8.0));
	block.var[0][2][1] = (mat3x4(0.0, 2.0, 9.0, -5.0, 9.0, -5.0, -4.0, 0.0, 4.0, 1.0, 0.0, -9.0));
	block.var[0][3][0] = (mat3x4(-8.0, 0.0, 8.0, -6.0, -2.0, -3.0, 6.0, 4.0, 9.0, -2.0, 4.0, 1.0));
	block.var[0][3][1] = (mat3x4(-9.0, -5.0, -8.0, 5.0, 4.0, 2.0, 7.0, 1.0, -6.0, 2.0, -6.0, -4.0));
	block.var[1][0][0] = (mat3x4(-3.0, -3.0, 9.0, -7.0, 4.0, 2.0, -8.0, 4.0, -6.0, -1.0, -9.0, 5.0));
	block.var[1][0][1] = (mat3x4(-5.0, -5.0, -9.0, -1.0, -9.0, -3.0, 0.0, 2.0, 8.0, -5.0, 1.0, 4.0));
	block.var[1][1][0] = (mat3x4(-6.0, 5.0, -8.0, -5.0, -7.0, -8.0, 3.0, 4.0, -7.0, 2.0, 3.0, 2.0));
	block.var[1][1][1] = (mat3x4(9.0, 2.0, -6.0, 4.0, 9.0, 6.0, 2.0, 0.0, 1.0, 0.0, -3.0, 2.0));
	block.var[1][2][0] = (mat3x4(1.0, -1.0, -4.0, 9.0, 7.0, 3.0, 5.0, 1.0, 6.0, 6.0, 2.0, 2.0));
	block.var[1][2][1] = (mat3x4(8.0, -5.0, -9.0, 8.0, -3.0, -3.0, 9.0, -9.0, 6.0, -4.0, 9.0, 4.0));
	block.var[1][3][0] = (mat3x4(-3.0, 1.0, -5.0, -9.0, -2.0, 3.0, 0.0, -4.0, 8.0, -3.0, 4.0, 9.0));
	block.var[1][3][1] = (mat3x4(-6.0, -1.0, 3.0, -9.0, -6.0, -6.0, -3.0, 5.0, 0.0, -9.0, -4.0, 9.0));
	block.var[2][0][0] = (mat3x4(-5.0, 5.0, -5.0, 2.0, -8.0, -3.0, 6.0, 1.0, 0.0, 1.0, 4.0, 6.0));
	block.var[2][0][1] = (mat3x4(-9.0, -1.0, -9.0, -6.0, 8.0, -9.0, -4.0, -6.0, -6.0, -1.0, -3.0, -7.0));
	block.var[2][1][0] = (mat3x4(-1.0, 4.0, -6.0, 4.0, -1.0, 3.0, 1.0, 3.0, 6.0, -6.0, -9.0, -9.0));
	block.var[2][1][1] = (mat3x4(-9.0, 1.0, -6.0, 4.0, 0.0, -2.0, -8.0, 9.0, 6.0, -9.0, 6.0, 7.0));
	block.var[2][2][0] = (mat3x4(-8.0, 4.0, 7.0, 3.0, -1.0, -1.0, 9.0, -9.0, 8.0, -3.0, 9.0, -6.0));
	block.var[2][2][1] = (mat3x4(-4.0, 6.0, 2.0, 5.0, 3.0, 7.0, 3.0, 4.0, -4.0, 2.0, 0.0, 8.0));
	block.var[2][3][0] = (mat3x4(-8.0, 6.0, -4.0, -3.0, -4.0, 3.0, 3.0, 4.0, 4.0, 4.0, 3.0, 8.0));
	block.var[2][3][1] = (mat3x4(-3.0, -6.0, -3.0, 6.0, -9.0, -3.0, -6.0, 9.0, 3.0, -1.0, 6.0, 3.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(-7.0, 1.0, 9.0, 3.0, -9.0, -1.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(-9.0, 6.0, 5.0, -8.0, 8.0, 9.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(-5.0, -9.0, 1.0, -6.0, 3.0, -3.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(4.0, -4.0, -1.0, 4.0, 0.0, -4.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][0], mat4x2(3.0, -1.0, -8.0, -1.0, -7.0, -8.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][1], mat4x2(0.0, -8.0, -7.0, 7.0, 3.0, 7.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][0], mat4x2(-8.0, 9.0, -5.0, -6.0, -1.0, 1.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][1], mat4x2(8.0, -1.0, -7.0, -7.0, -9.0, -4.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(4.0, 1.0, -1.0, -5.0, 5.0, -9.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(-2.0, -2.0, -9.0, -2.0, -2.0, 8.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(-7.0, 4.0, 5.0, 4.0, -5.0, 8.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(-7.0, 5.0, -2.0, -3.0, 7.0, 4.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][0], mat4x2(-7.0, 7.0, -7.0, -4.0, -2.0, -5.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][1], mat4x2(3.0, -9.0, 6.0, -8.0, 0.0, 5.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][0], mat4x2(-6.0, -7.0, -8.0, 6.0, -7.0, -6.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][1], mat4x2(8.0, -2.0, 9.0, -6.0, 5.0, -1.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(-8.0, 6.0, -4.0, 7.0, 2.0, 3.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(7.0, 3.0, 5.0, -2.0, 7.0, 1.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(-4.0, 7.0, 2.0, 3.0, -7.0, -8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(-1.0, -8.0, -8.0, 4.0, 6.0, 8.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][0], mat4x2(-2.0, 0.0, 9.0, -8.0, 0.0, 5.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][1], mat4x2(9.0, 1.0, 2.0, -6.0, -9.0, -9.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][0], mat4x2(-3.0, -3.0, 0.0, -2.0, -5.0, 8.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][1], mat4x2(-5.0, -9.0, 3.0, 5.0, 2.0, -2.0, -7.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(6.0, -2.0));
	block.var[0][0][0][1] = (vec2(2.0, 8.0));
	block.var[0][0][0][2] = (vec2(-5.0, 3.0));
	block.var[0][0][0][3] = (vec2(-1.0, -7.0));
	block.var[0][0][1][0] = (vec2(4.0, 2.0));
	block.var[0][0][1][1] = (vec2(-4.0, 8.0));
	block.var[0][0][1][2] = (vec2(3.0, 8.0));
	block.var[0][0][1][3] = (vec2(-1.0, 6.0));
	block.var[0][1][0][0] = (vec2(7.0, 3.0));
	block.var[0][1][0][1] = (vec2(3.0, 3.0));
	block.var[0][1][0][2] = (vec2(-5.0, -9.0));
	block.var[0][1][0][3] = (vec2(2.0, 9.0));
	block.var[0][1][1][0] = (vec2(3.0, 8.0));
	block.var[0][1][1][1] = (vec2(3.0, -4.0));
	block.var[0][1][1][2] = (vec2(6.0, 1.0));
	block.var[0][1][1][3] = (vec2(-3.0, 1.0));
	block.var[0][2][0][0] = (vec2(1.0, 7.0));
	block.var[0][2][0][1] = (vec2(0.0, -4.0));
	block.var[0][2][0][2] = (vec2(-1.0, 5.0));
	block.var[0][2][0][3] = (vec2(9.0, -8.0));
	block.var[0][2][1][0] = (vec2(-3.0, 8.0));
	block.var[0][2][1][1] = (vec2(-1.0, 7.0));
	block.var[0][2][1][2] = (vec2(5.0, -7.0));
	block.var[0][2][1][3] = (vec2(8.0, 0.0));
	block.var[0][3][0][0] = (vec2(7.0, 8.0));
	block.var[0][3][0][1] = (vec2(2.0, -9.0));
	block.var[0][3][0][2] = (vec2(-8.0, -9.0));
	block.var[0][3][0][3] = (vec2(-1.0, -3.0));
	block.var[0][3][1][0] = (vec2(-2.0, -1.0));
	block.var[0][3][1][1] = (vec2(1.0, -1.0));
	block.var[0][3][1][2] = (vec2(-5.0, -6.0));
	block.var[0][3][1][3] = (vec2(-8.0, 7.0));
	block.var[1][0][0][0] = (vec2(-8.0, 2.0));
	block.var[1][0][0][1] = (vec2(-5.0, 5.0));
	block.var[1][0][0][2] = (vec2(-4.0, -9.0));
	block.var[1][0][0][3] = (vec2(0.0, 4.0));
	block.var[1][0][1][0] = (vec2(8.0, 2.0));
	block.var[1][0][1][1] = (vec2(-3.0, 2.0));
	block.var[1][0][1][2] = (vec2(-4.0, -4.0));
	block.var[1][0][1][3] = (vec2(2.0, -8.0));
	block.var[1][1][0][0] = (vec2(-5.0, -2.0));
	block.var[1][1][0][1] = (vec2(7.0, 8.0));
	block.var[1][1][0][2] = (vec2(4.0, 7.0));
	block.var[1][1][0][3] = (vec2(-1.0, -8.0));
	block.var[1][1][1][0] = (vec2(-6.0, -6.0));
	block.var[1][1][1][1] = (vec2(-4.0, -2.0));
	block.var[1][1][1][2] = (vec2(3.0, 8.0));
	block.var[1][1][1][3] = (vec2(4.0, 4.0));
	block.var[1][2][0][0] = (vec2(-5.0, 7.0));
	block.var[1][2][0][1] = (vec2(8.0, 9.0));
	block.var[1][2][0][2] = (vec2(8.0, 9.0));
	block.var[1][2][0][3] = (vec2(1.0, 9.0));
	block.var[1][2][1][0] = (vec2(-9.0, 8.0));
	block.var[1][2][1][1] = (vec2(-2.0, 9.0));
	block.var[1][2][1][2] = (vec2(6.0, 6.0));
	block.var[1][2][1][3] = (vec2(3.0, -5.0));
	block.var[1][3][0][0] = (vec2(2.0, 0.0));
	block.var[1][3][0][1] = (vec2(-7.0, -6.0));
	block.var[1][3][0][2] = (vec2(6.0, 1.0));
	block.var[1][3][0][3] = (vec2(8.0, 9.0));
	block.var[1][3][1][0] = (vec2(9.0, -8.0));
	block.var[1][3][1][1] = (vec2(-6.0, -7.0));
	block.var[1][3][1][2] = (vec2(-5.0, 0.0));
	block.var[1][3][1][3] = (vec2(-3.0, 1.0));
	block.var[2][0][0][0] = (vec2(-4.0, 8.0));
	block.var[2][0][0][1] = (vec2(5.0, 7.0));
	block.var[2][0][0][2] = (vec2(-4.0, 6.0));
	block.var[2][0][0][3] = (vec2(8.0, 4.0));
	block.var[2][0][1][0] = (vec2(-9.0, -7.0));
	block.var[2][0][1][1] = (vec2(7.0, -5.0));
	block.var[2][0][1][2] = (vec2(1.0, -9.0));
	block.var[2][0][1][3] = (vec2(9.0, 5.0));
	block.var[2][1][0][0] = (vec2(-7.0, -6.0));
	block.var[2][1][0][1] = (vec2(8.0, -6.0));
	block.var[2][1][0][2] = (vec2(8.0, -3.0));
	block.var[2][1][0][3] = (vec2(-7.0, 0.0));
	block.var[2][1][1][0] = (vec2(-9.0, 2.0));
	block.var[2][1][1][1] = (vec2(-9.0, 7.0));
	block.var[2][1][1][2] = (vec2(-2.0, 2.0));
	block.var[2][1][1][3] = (vec2(-6.0, -1.0));
	block.var[2][2][0][0] = (vec2(1.0, -4.0));
	block.var[2][2][0][1] = (vec2(-5.0, 7.0));
	block.var[2][2][0][2] = (vec2(-8.0, 7.0));
	block.var[2][2][0][3] = (vec2(-1.0, -1.0));
	block.var[2][2][1][0] = (vec2(-2.0, -7.0));
	block.var[2][2][1][1] = (vec2(4.0, -8.0));
	block.var[2][2][1][2] = (vec2(2.0, 4.0));
	block.var[2][2][1][3] = (vec2(3.0, 1.0));
	block.var[2][3][0][0] = (vec2(-1.0, -6.0));
	block.var[2][3][0][1] = (vec2(1.0, 1.0));
	block.var[2][3][0][2] = (vec2(-7.0, -8.0));
	block.var[2][3][0][3] = (vec2(-5.0, 5.0));
	block.var[2][3][1][0] = (vec2(4.0, -9.0));
	block.var[2][3][1][1] = (vec2(-6.0, -7.0));
	block.var[2][3][1][2] = (vec2(-8.0, 8.0));
	block.var[2][3][1][3] = (vec2(-3.0, 6.0));
}
#version 450
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
	allOk = compare_mat3(block.var[0][0][0], mat3(3.0, -9.0, 7.0, 0.0, -1.0, -8.0, 0.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(9.0, 8.0, -4.0, -1.0, 5.0, -5.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(2.0, -3.0, 5.0, 3.0, -7.0, -5.0, 0.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(8.0, 0.0, -4.0, 2.0, 4.0, -3.0, 6.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[0][2][0], mat3(9.0, 0.0, 6.0, 4.0, -2.0, 0.0, 6.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[0][2][1], mat3(8.0, -5.0, -1.0, -6.0, 1.0, -4.0, 2.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[0][3][0], mat3(-4.0, 8.0, 5.0, -4.0, 1.0, 8.0, -7.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[0][3][1], mat3(2.0, 1.0, -5.0, 9.0, 0.0, -3.0, 6.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(-4.0, -9.0, 4.0, 5.0, -4.0, -4.0, 6.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(2.0, -8.0, 1.0, -2.0, 6.0, 7.0, 4.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(-2.0, -2.0, 5.0, 9.0, 8.0, -3.0, -5.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(7.0, 0.0, 8.0, -3.0, 5.0, -5.0, 0.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[1][2][0], mat3(-1.0, -9.0, 3.0, -9.0, 7.0, -5.0, 5.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[1][2][1], mat3(-6.0, -7.0, 1.0, 6.0, -5.0, 2.0, -5.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[1][3][0], mat3(-5.0, -6.0, 5.0, 4.0, 2.0, -6.0, -6.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[1][3][1], mat3(9.0, 1.0, -4.0, -3.0, 1.0, -2.0, -6.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(-9.0, -6.0, -4.0, -1.0, -5.0, 3.0, 3.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(-2.0, 1.0, 6.0, -7.0, 4.0, -7.0, -8.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(-9.0, -3.0, -8.0, -6.0, -2.0, -4.0, -5.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(2.0, -1.0, 4.0, 7.0, -7.0, 4.0, -7.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[2][2][0], mat3(-4.0, 8.0, -8.0, 1.0, -3.0, -3.0, -6.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[2][2][1], mat3(-2.0, 3.0, -9.0, -4.0, 3.0, -4.0, 8.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[2][3][0], mat3(4.0, -1.0, -3.0, 7.0, -3.0, -5.0, -1.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[2][3][1], mat3(4.0, -4.0, -7.0, 8.0, 2.0, 6.0, -7.0, 1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3(7.0, -8.0, -8.0, -4.0, -3.0, 5.0, -3.0, -3.0, -1.0));
	block.var[0][0][1] = (mat3(5.0, 1.0, -3.0, 9.0, 1.0, 5.0, 0.0, 5.0, -1.0));
	block.var[0][1][0] = (mat3(5.0, 4.0, -6.0, -9.0, -4.0, 6.0, -1.0, 8.0, -6.0));
	block.var[0][1][1] = (mat3(-3.0, 6.0, -9.0, 2.0, -5.0, 0.0, -7.0, -5.0, -3.0));
	block.var[0][2][0] = (mat3(-2.0, 4.0, 1.0, 4.0, 5.0, -8.0, 0.0, 4.0, -7.0));
	block.var[0][2][1] = (mat3(-3.0, 2.0, 7.0, -9.0, -9.0, -4.0, 6.0, -9.0, 9.0));
	block.var[0][3][0] = (mat3(0.0, 7.0, -3.0, -5.0, -1.0, 1.0, -7.0, 1.0, -9.0));
	block.var[0][3][1] = (mat3(0.0, 7.0, 5.0, -6.0, 4.0, -6.0, 2.0, -3.0, 4.0));
	block.var[1][0][0] = (mat3(-7.0, 4.0, 1.0, -6.0, 3.0, 6.0, 1.0, 9.0, 3.0));
	block.var[1][0][1] = (mat3(-9.0, 3.0, -7.0, 6.0, -9.0, 3.0, -9.0, 3.0, -6.0));
	block.var[1][1][0] = (mat3(-4.0, -4.0, 8.0, -8.0, -7.0, 7.0, -4.0, -7.0, 8.0));
	block.var[1][1][1] = (mat3(-8.0, -8.0, -8.0, 1.0, -5.0, -6.0, 8.0, -1.0, 2.0));
	block.var[1][2][0] = (mat3(-6.0, 9.0, 8.0, -8.0, -9.0, -8.0, 2.0, 4.0, 8.0));
	block.var[1][2][1] = (mat3(-5.0, 6.0, -5.0, 3.0, -2.0, -2.0, -3.0, -3.0, 8.0));
	block.var[1][3][0] = (mat3(7.0, 6.0, 0.0, -2.0, -9.0, 3.0, 8.0, 9.0, -8.0));
	block.var[1][3][1] = (mat3(8.0, -8.0, -8.0, -9.0, -1.0, 4.0, 9.0, 9.0, -4.0));
	block.var[2][0][0] = (mat3(4.0, 7.0, -6.0, -7.0, 1.0, -3.0, -6.0, -2.0, 5.0));
	block.var[2][0][1] = (mat3(7.0, -6.0, -2.0, -8.0, 7.0, 1.0, 3.0, 4.0, 0.0));
	block.var[2][1][0] = (mat3(-3.0, -8.0, 4.0, 8.0, -2.0, 3.0, -5.0, -9.0, -3.0));
	block.var[2][1][1] = (mat3(3.0, -2.0, -2.0, -3.0, 9.0, -6.0, 3.0, 5.0, 5.0));
	block.var[2][2][0] = (mat3(1.0, -1.0, -6.0, -7.0, -4.0, -9.0, 9.0, -4.0, -3.0));
	block.var[2][2][1] = (mat3(8.0, 7.0, -9.0, 3.0, -6.0, 1.0, -4.0, -4.0, 3.0));
	block.var[2][3][0] = (mat3(0.0, -4.0, -8.0, 9.0, 2.0, 6.0, -7.0, 5.0, -8.0));
	block.var[2][3][1] = (mat3(-9.0, -6.0, -3.0, 1.0, -9.0, -5.0, 5.0, 4.0, 5.0));
}
#version 450
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
layout(std140, buffer_reference) buffer Block
{
	S s;
	lowp vec2 v;
	highp uint u;
	T t[];
};
layout (push_constant, std430) uniform PC {
    Block block;
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
	allOk = compare_uint((block.u), 9u) && allOk;
	allOk = compare_mat4x3(block.t[0].a, mat4x3(4.0, -1.0, 9.0, 0.0, -9.0, 1.0, -2.0, 4.0, -9.0, 9.0, -4.0, 2.0)) && allOk;
	allOk = compare_uvec3((block.t[0].b[0].a), uvec3(0u, 8u, 2u)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[0]), vec2(1.0, 1.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[1]), vec2(8.0, 2.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[2]), vec2(-1.0, 1.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[3]), vec2(-1.0, 7.0)) && allOk;
	allOk = compare_vec4((block.t[0].b[0].c), vec4(7.0, -9.0, 1.0, 1.0)) && allOk;
	allOk = compare_uvec3((block.t[0].b[1].a), uvec3(5u, 2u, 5u)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[0]), vec2(0.0, 9.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[1]), vec2(8.0, 5.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[2]), vec2(5.0, -7.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[3]), vec2(1.0, -9.0)) && allOk;
	allOk = compare_vec4((block.t[0].b[1].c), vec4(0.0, 7.0, 3.0, -3.0)) && allOk;
	allOk = compare_uvec3((block.t[0].b[2].a), uvec3(4u, 0u, 6u)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[0]), vec2(-6.0, 0.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[1]), vec2(0.0, 7.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[2]), vec2(-5.0, -3.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[3]), vec2(8.0, -9.0)) && allOk;
	allOk = compare_vec4((block.t[0].b[2].c), vec4(0.0, -7.0, 0.0, 8.0)) && allOk;
	allOk = compare_int((block.t[0].c), -9) && allOk;
	allOk = compare_mat4x3(block.t[1].a, mat4x3(9.0, 7.0, 3.0, -4.0, -7.0, 8.0, -3.0, 3.0, 0.0, 1.0, -6.0, -7.0)) && allOk;
	allOk = compare_uvec3((block.t[1].b[0].a), uvec3(7u, 5u, 0u)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[0]), vec2(-3.0, -2.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[1]), vec2(1.0, -3.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[2]), vec2(1.0, 9.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[3]), vec2(-6.0, -9.0)) && allOk;
	allOk = compare_vec4((block.t[1].b[0].c), vec4(-2.0, 9.0, 3.0, -3.0)) && allOk;
	allOk = compare_uvec3((block.t[1].b[1].a), uvec3(5u, 6u, 5u)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[0]), vec2(0.0, 4.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[1]), vec2(-3.0, -5.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[2]), vec2(-8.0, -3.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[3]), vec2(-8.0, 8.0)) && allOk;
	allOk = compare_vec4((block.t[1].b[1].c), vec4(-2.0, 4.0, -8.0, 8.0)) && allOk;
	allOk = compare_uvec3((block.t[1].b[2].a), uvec3(9u, 9u, 0u)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[0]), vec2(-4.0, -5.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[1]), vec2(-6.0, -8.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[2]), vec2(-4.0, 0.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[3]), vec2(5.0, -8.0)) && allOk;
	allOk = compare_vec4((block.t[1].b[2].c), vec4(-3.0, 5.0, -4.0, -7.0)) && allOk;
	allOk = compare_int((block.t[1].c), 2) && allOk;
	allOk = compare_mat4x3(block.t[2].a, mat4x3(-3.0, 4.0, 4.0, -9.0, -3.0, 1.0, 2.0, 4.0, 1.0, -6.0, 6.0, 1.0)) && allOk;
	allOk = compare_uvec3((block.t[2].b[0].a), uvec3(1u, 9u, 7u)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[0]), vec2(-2.0, -9.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[1]), vec2(-1.0, -1.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[2]), vec2(2.0, 2.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[3]), vec2(2.0, -2.0)) && allOk;
	allOk = compare_vec4((block.t[2].b[0].c), vec4(4.0, 4.0, 3.0, 1.0)) && allOk;
	allOk = compare_uvec3((block.t[2].b[1].a), uvec3(8u, 1u, 3u)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[0]), vec2(-6.0, 4.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[1]), vec2(-4.0, -1.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[2]), vec2(-7.0, -9.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[3]), vec2(0.0, -4.0)) && allOk;
	allOk = compare_vec4((block.t[2].b[1].c), vec4(4.0, 7.0, -8.0, 5.0)) && allOk;
	allOk = compare_uvec3((block.t[2].b[2].a), uvec3(6u, 9u, 9u)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[0]), vec2(0.0, 3.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[1]), vec2(-4.0, 6.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[2]), vec2(-6.0, -7.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[3]), vec2(5.0, 2.0)) && allOk;
	allOk = compare_vec4((block.t[2].b[2].c), vec4(8.0, -3.0, -1.0, -8.0)) && allOk;
	allOk = compare_int((block.t[2].c), 1) && allOk;
	allOk = compare_mat4x3(block.t[3].a, mat4x3(0.0, -2.0, -9.0, -8.0, -2.0, 3.0, 1.0, -5.0, -3.0, -2.0, -2.0, 2.0)) && allOk;
	allOk = compare_uvec3((block.t[3].b[0].a), uvec3(5u, 2u, 0u)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[0]), vec2(-3.0, 4.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[1]), vec2(-9.0, 4.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[2]), vec2(6.0, -7.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[3]), vec2(8.0, -8.0)) && allOk;
	allOk = compare_vec4((block.t[3].b[0].c), vec4(-4.0, 2.0, -2.0, 4.0)) && allOk;
	allOk = compare_uvec3((block.t[3].b[1].a), uvec3(1u, 3u, 2u)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[0]), vec2(0.0, 1.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[1]), vec2(8.0, -6.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[2]), vec2(1.0, -6.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[3]), vec2(-9.0, 2.0)) && allOk;
	allOk = compare_vec4((block.t[3].b[1].c), vec4(-9.0, -3.0, 0.0, -5.0)) && allOk;
	allOk = compare_uvec3((block.t[3].b[2].a), uvec3(0u, 3u, 5u)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[0]), vec2(9.0, 6.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[1]), vec2(-5.0, -5.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[2]), vec2(5.0, -4.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[3]), vec2(3.0, -2.0)) && allOk;
	allOk = compare_vec4((block.t[3].b[2].c), vec4(-8.0, -3.0, -8.0, 9.0)) && allOk;
	allOk = compare_int((block.t[3].c), -9) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s.a = (uvec3(2u, 1u, 3u));
	block.s.b[0] = (vec2(6.0, -9.0));
	block.s.b[1] = (vec2(-9.0, -8.0));
	block.s.b[2] = (vec2(0.0, -1.0));
	block.s.b[3] = (vec2(-9.0, 2.0));
	block.s.c = (vec4(-5.0, 6.0, -6.0, -5.0));
	block.u = (2u);
}
#version 450
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
layout(scalar, buffer_reference) buffer Block
{
	S s;
	lowp vec2 v;
	highp uint u;
	T t[];
};
layout (push_constant, std430) uniform PC {
    Block block;
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
	allOk = compare_uint((block.u), 1u) && allOk;
	allOk = compare_mat4x3(block.t[0].a, mat4x3(9.0, 3.0, -1.0, 0.0, -4.0, 7.0, 2.0, -1.0, -3.0, 5.0, 2.0, 6.0)) && allOk;
	allOk = compare_uvec3((block.t[0].b[0].a), uvec3(4u, 4u, 4u)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[0]), vec2(-1.0, 3.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[1]), vec2(-9.0, 6.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[2]), vec2(4.0, 6.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[3]), vec2(9.0, 5.0)) && allOk;
	allOk = compare_vec4((block.t[0].b[0].c), vec4(-5.0, 4.0, -9.0, 0.0)) && allOk;
	allOk = compare_uvec3((block.t[0].b[1].a), uvec3(1u, 2u, 6u)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[0]), vec2(-9.0, 6.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[1]), vec2(4.0, 8.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[2]), vec2(-8.0, 0.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[3]), vec2(-7.0, -2.0)) && allOk;
	allOk = compare_vec4((block.t[0].b[1].c), vec4(-5.0, -3.0, -2.0, -8.0)) && allOk;
	allOk = compare_uvec3((block.t[0].b[2].a), uvec3(3u, 4u, 2u)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[0]), vec2(4.0, 3.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[1]), vec2(7.0, -9.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[2]), vec2(-7.0, 6.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[3]), vec2(5.0, -8.0)) && allOk;
	allOk = compare_vec4((block.t[0].b[2].c), vec4(-4.0, -1.0, 4.0, -1.0)) && allOk;
	allOk = compare_int((block.t[0].c), 0) && allOk;
	allOk = compare_mat4x3(block.t[1].a, mat4x3(-8.0, 2.0, 1.0, 5.0, -2.0, -9.0, 7.0, 4.0, 0.0, 7.0, 7.0, 8.0)) && allOk;
	allOk = compare_uvec3((block.t[1].b[0].a), uvec3(7u, 2u, 0u)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[0]), vec2(9.0, -7.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[1]), vec2(-8.0, 8.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[2]), vec2(1.0, -1.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[3]), vec2(1.0, 3.0)) && allOk;
	allOk = compare_vec4((block.t[1].b[0].c), vec4(5.0, 9.0, 2.0, -3.0)) && allOk;
	allOk = compare_uvec3((block.t[1].b[1].a), uvec3(0u, 7u, 3u)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[0]), vec2(7.0, 0.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[1]), vec2(7.0, 0.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[2]), vec2(-4.0, -2.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[3]), vec2(-2.0, -8.0)) && allOk;
	allOk = compare_vec4((block.t[1].b[1].c), vec4(5.0, 3.0, -3.0, 1.0)) && allOk;
	allOk = compare_uvec3((block.t[1].b[2].a), uvec3(5u, 9u, 7u)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[0]), vec2(5.0, 5.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[1]), vec2(-4.0, 4.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[2]), vec2(-2.0, -1.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[3]), vec2(2.0, 0.0)) && allOk;
	allOk = compare_vec4((block.t[1].b[2].c), vec4(-2.0, -7.0, -2.0, -9.0)) && allOk;
	allOk = compare_int((block.t[1].c), 5) && allOk;
	allOk = compare_mat4x3(block.t[2].a, mat4x3(9.0, 9.0, -2.0, -1.0, -7.0, -7.0, 6.0, 9.0, -5.0, 2.0, 5.0, -4.0)) && allOk;
	allOk = compare_uvec3((block.t[2].b[0].a), uvec3(3u, 8u, 5u)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[0]), vec2(9.0, -8.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[1]), vec2(-6.0, 4.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[2]), vec2(0.0, -3.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[3]), vec2(-3.0, 4.0)) && allOk;
	allOk = compare_vec4((block.t[2].b[0].c), vec4(-8.0, -7.0, -3.0, -9.0)) && allOk;
	allOk = compare_uvec3((block.t[2].b[1].a), uvec3(2u, 9u, 0u)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[0]), vec2(9.0, 9.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[1]), vec2(8.0, -9.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[2]), vec2(-5.0, 8.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[3]), vec2(1.0, 6.0)) && allOk;
	allOk = compare_vec4((block.t[2].b[1].c), vec4(9.0, 9.0, -9.0, -6.0)) && allOk;
	allOk = compare_uvec3((block.t[2].b[2].a), uvec3(4u, 1u, 8u)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[0]), vec2(-2.0, 3.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[1]), vec2(-2.0, 9.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[2]), vec2(6.0, -5.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[3]), vec2(0.0, -5.0)) && allOk;
	allOk = compare_vec4((block.t[2].b[2].c), vec4(-3.0, -7.0, -9.0, 1.0)) && allOk;
	allOk = compare_int((block.t[2].c), -2) && allOk;
	allOk = compare_mat4x3(block.t[3].a, mat4x3(3.0, -4.0, 7.0, 8.0, -9.0, 4.0, 7.0, -7.0, 6.0, 8.0, 9.0, -5.0)) && allOk;
	allOk = compare_uvec3((block.t[3].b[0].a), uvec3(3u, 1u, 4u)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[0]), vec2(4.0, 8.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[1]), vec2(6.0, -6.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[2]), vec2(9.0, -3.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[3]), vec2(8.0, -7.0)) && allOk;
	allOk = compare_vec4((block.t[3].b[0].c), vec4(-9.0, 1.0, -1.0, 3.0)) && allOk;
	allOk = compare_uvec3((block.t[3].b[1].a), uvec3(2u, 7u, 6u)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[0]), vec2(7.0, -2.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[1]), vec2(3.0, 9.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[2]), vec2(0.0, 9.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[3]), vec2(-6.0, 1.0)) && allOk;
	allOk = compare_vec4((block.t[3].b[1].c), vec4(-5.0, -1.0, 6.0, -6.0)) && allOk;
	allOk = compare_uvec3((block.t[3].b[2].a), uvec3(4u, 4u, 8u)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[0]), vec2(3.0, -4.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[1]), vec2(-2.0, 4.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[2]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[3]), vec2(8.0, 0.0)) && allOk;
	allOk = compare_vec4((block.t[3].b[2].c), vec4(-5.0, -7.0, 8.0, 9.0)) && allOk;
	allOk = compare_int((block.t[3].c), -7) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s.a = (uvec3(4u, 1u, 1u));
	block.s.b[0] = (vec2(-7.0, 3.0));
	block.s.b[1] = (vec2(2.0, 8.0));
	block.s.b[2] = (vec2(2.0, -9.0));
	block.s.b[3] = (vec2(5.0, -5.0));
	block.s.c = (vec4(3.0, -9.0, 6.0, 9.0));
	block.u = (3u);
}
#version 450
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
	allOk = compare_mat2x4(block[0].var, mat2x4(-7.0, 8.0, 3.0, -7.0, -7.0, -8.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block[1].var, mat2x4(7.0, 3.0, -5.0, -7.0, 3.0, -9.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[2].var, mat2x4(3.0, 6.0, -4.0, 4.0, -2.0, 8.0, -6.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat2x4(4.0, 9.0, 1.0, 2.0, 5.0, -4.0, -9.0, -9.0));
	block[1].var = (mat2x4(5.0, -4.0, -4.0, 8.0, 5.0, -1.0, -3.0, -2.0));
	block[2].var = (mat2x4(8.0, 2.0, 5.0, 4.0, 3.0, 1.0, -6.0, 2.0));
}
#version 450
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
	i16vec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(block[0].var), ivec2(3, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(block[1].var), ivec2(8, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(block[2].var), ivec2(-4, 2)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = i16vec2(ivec2(6, -2));
	block[1].var = i16vec2(ivec2(-2, -8));
	block[2].var = i16vec2(ivec2(3, 5));
}
#version 450
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
	highp mat2 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(block[0].var, mat2(-6.0, 3.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(block[1].var, mat2(3.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2(block[2].var, mat2(9.0, -5.0, -3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec2(-2.0, 1.0));
	block[0].var[1] = (vec2(-7.0, -1.0));
	block[1].var[0] = (vec2(5.0, -3.0));
	block[1].var[1] = (vec2(4.0, 8.0));
	block[2].var[0] = (vec2(-2.0, -6.0));
	block[2].var[1] = (vec2(-5.0, -1.0));
}
#version 450
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
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block[0].var[0][0], -4.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 6.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 0.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 6.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 4.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 7.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(-4.0, 6.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(0.0, 6.0)) && allOk;
	allOk = compare_vec2(block[0].var[2], vec2(4.0, 7.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 5.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -1.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 1.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 7.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -4.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 9.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(5.0, -1.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(1.0, 7.0)) && allOk;
	allOk = compare_vec2(block[1].var[2], vec2(-4.0, 9.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 4.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -5.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -2.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -4.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 6.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 2.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(4.0, -5.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(-2.0, -4.0)) && allOk;
	allOk = compare_vec2(block[2].var[2], vec2(6.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec2(9.0, -4.0));
	block[0].var[1] = (vec2(-7.0, 8.0));
	block[0].var[2] = (vec2(-2.0, -9.0));
	block[1].var[0] = (vec2(-1.0, 7.0));
	block[1].var[1] = (vec2(-3.0, -3.0));
	block[1].var[2] = (vec2(-8.0, 2.0));
	block[2].var[0] = (vec2(-2.0, -1.0));
	block[2].var[1] = (vec2(-3.0, -3.0));
	block[2].var[2] = (vec2(-4.0, 5.0));
}
#version 450
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
	i16vec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(block[0].var), ivec4(-6, -9, 9, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(block[1].var), ivec4(-1, -8, 8, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(block[2].var), ivec4(3, 4, 0, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = i16vec4(ivec4(-4, -8, -4, 9));
	block[1].var = i16vec4(ivec4(2, 7, -4, 4));
	block[2].var = i16vec4(ivec4(8, 9, 5, 1));
}
#version 450
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
	f16vec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(block[0].var), vec2(-6.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(block[1].var), vec2(1.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(block[2].var), vec2(6.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = f16vec2(vec2(-2.0, 4.0));
	block[1].var = f16vec2(vec2(-2.0, 4.0));
	block[2].var = f16vec2(vec2(-1.0, 1.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), 5.0) && allOk;
	allOk = compare_mat2x3(block[0].var, mat2x3(-6.0, 5.0, -5.0, 8.0, 4.0, 0.0)) && allOk;
	allOk = compare_float((block[1].padding), 3.0) && allOk;
	allOk = compare_mat2x3(block[1].var, mat2x3(0.0, 4.0, -7.0, 9.0, -4.0, 5.0)) && allOk;
	allOk = compare_float((block[2].padding), 2.0) && allOk;
	allOk = compare_mat2x3(block[2].var, mat2x3(5.0, -9.0, 4.0, -1.0, -2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-9.0);
	block[0].var = (mat2x3(-1.0, 8.0, -5.0, -3.0, 4.0, -4.0));
	block[1].padding = (1.0);
	block[1].var = (mat2x3(-8.0, -3.0, 0.0, -5.0, 6.0, 2.0));
	block[2].padding = (4.0);
	block[2].var = (mat2x3(-1.0, -7.0, -3.0, 6.0, 6.0, 9.0));
}
#version 450
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
	highp mat3x2 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), 5.0) && allOk;
	allOk = compare_float(block[0].var[0][0], -6.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -5.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 5.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -6.0) && allOk;
	allOk = compare_float(block[0].var[2][0], -1.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -5.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(-6.0, -5.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(5.0, -6.0)) && allOk;
	allOk = compare_vec2(block[0].var[2], vec2(-1.0, -5.0)) && allOk;
	allOk = compare_float((block[1].padding), -6.0) && allOk;
	allOk = compare_float(block[1].var[0][0], -8.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 6.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -3.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 2.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 2.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -8.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(-8.0, 6.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(-3.0, 2.0)) && allOk;
	allOk = compare_vec2(block[1].var[2], vec2(2.0, -8.0)) && allOk;
	allOk = compare_float((block[2].padding), 9.0) && allOk;
	allOk = compare_float(block[2].var[0][0], -8.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -3.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 6.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 5.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 0.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 4.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(-8.0, -3.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(6.0, 5.0)) && allOk;
	allOk = compare_vec2(block[2].var[2], vec2(0.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-1.0);
	block[0].var = (mat3x2(-5.0, -1.0, -8.0, 7.0, 8.0, -4.0));
	block[1].padding = (-8.0);
	block[1].var = (mat3x2(1.0, 5.0, -2.0, 7.0, 4.0, -6.0));
	block[2].padding = (7.0);
	block[2].var = (mat3x2(-6.0, 2.0, 5.0, 0.0, 6.0, -5.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), -4.0) && allOk;
	allOk = compare_float(block[0].var[0][0], 6.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 7.0) && allOk;
	allOk = compare_float(block[0].var[0][2], -6.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 2.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -5.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 0.0) && allOk;
	allOk = compare_float(block[0].var[2][0], -2.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 8.0) && allOk;
	allOk = compare_float(block[0].var[2][2], -7.0) && allOk;
	allOk = compare_float(block[0].var[3][0], 6.0) && allOk;
	allOk = compare_float(block[0].var[3][1], -8.0) && allOk;
	allOk = compare_float(block[0].var[3][2], -4.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(6.0, 7.0, -6.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(2.0, -5.0, 0.0)) && allOk;
	allOk = compare_vec3(block[0].var[2], vec3(-2.0, 8.0, -7.0)) && allOk;
	allOk = compare_vec3(block[0].var[3], vec3(6.0, -8.0, -4.0)) && allOk;
	allOk = compare_float((block[1].padding), -5.0) && allOk;
	allOk = compare_float(block[1].var[0][0], -7.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 0.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -7.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -8.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -3.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 1.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 3.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 7.0) && allOk;
	allOk = compare_float(block[1].var[2][2], 7.0) && allOk;
	allOk = compare_float(block[1].var[3][0], -4.0) && allOk;
	allOk = compare_float(block[1].var[3][1], -9.0) && allOk;
	allOk = compare_float(block[1].var[3][2], 5.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(-7.0, 0.0, -7.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(-8.0, -3.0, 1.0)) && allOk;
	allOk = compare_vec3(block[1].var[2], vec3(3.0, 7.0, 7.0)) && allOk;
	allOk = compare_vec3(block[1].var[3], vec3(-4.0, -9.0, 5.0)) && allOk;
	allOk = compare_float((block[2].padding), 2.0) && allOk;
	allOk = compare_float(block[2].var[0][0], -9.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 9.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 2.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 8.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -7.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -4.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 8.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 6.0) && allOk;
	allOk = compare_float(block[2].var[2][2], -6.0) && allOk;
	allOk = compare_float(block[2].var[3][0], -9.0) && allOk;
	allOk = compare_float(block[2].var[3][1], 3.0) && allOk;
	allOk = compare_float(block[2].var[3][2], 0.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(-9.0, 9.0, 2.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(8.0, -7.0, -4.0)) && allOk;
	allOk = compare_vec3(block[2].var[2], vec3(8.0, 6.0, -6.0)) && allOk;
	allOk = compare_vec3(block[2].var[3], vec3(-9.0, 3.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-3.0);
	block[0].var[0] = (vec3(-6.0, 6.0, 1.0));
	block[0].var[1] = (vec3(-4.0, -3.0, -3.0));
	block[0].var[2] = (vec3(3.0, -2.0, -7.0));
	block[0].var[3] = (vec3(1.0, -5.0, -1.0));
	block[1].padding = (-5.0);
	block[1].var[0] = (vec3(7.0, 1.0, -2.0));
	block[1].var[1] = (vec3(-4.0, -4.0, -6.0));
	block[1].var[2] = (vec3(5.0, -2.0, 6.0));
	block[1].var[3] = (vec3(-9.0, 5.0, -5.0));
	block[2].padding = (7.0);
	block[2].var[0] = (vec3(-4.0, 8.0, -3.0));
	block[2].var[1] = (vec3(-2.0, 0.0, 8.0));
	block[2].var[2] = (vec3(-2.0, 6.0, -3.0));
	block[2].var[3] = (vec3(-9.0, -2.0, -2.0));
}
#version 450
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
	allOk = compare_float((blockA[0].a), 4.0) && allOk;
	allOk = compare_mat2(blockA[0].c, mat2(-8.0, 8.0, 0.0, 4.0)) && allOk;
	allOk = compare_float((blockA[1].a), 5.0) && allOk;
	allOk = compare_mat2(blockA[1].c, mat2(2.0, -8.0, 0.0, 6.0)) && allOk;
	allOk = compare_float((blockA[2].a), 0.0) && allOk;
	allOk = compare_mat2(blockA[2].c, mat2(9.0, 2.0, -8.0, 4.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b), ivec2(0, 6)) && allOk;
	allOk = compare_bool((blockB[0].d), true) && allOk;
	allOk = compare_ivec2((blockB[1].b), ivec2(-3, 6)) && allOk;
	allOk = compare_bool((blockB[1].d), true) && allOk;
	allOk = compare_ivec2((blockB[2].b), ivec2(-3, -5)) && allOk;
	allOk = compare_bool((blockB[2].d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (5.0);
	blockA[1].a = (5.0);
	blockA[2].a = (2.0);
	blockB[0].a[0] = (vec3(9.0, 2.0, -4.0));
	blockB[0].a[1] = (vec3(4.0, 3.0, -1.0));
	blockB[0].a[2] = (vec3(4.0, -3.0, 1.0));
	blockB[0].d = (false);
	blockB[1].a[0] = (vec3(8.0, -1.0, 8.0));
	blockB[1].a[1] = (vec3(-2.0, -4.0, 0.0));
	blockB[1].a[2] = (vec3(7.0, -3.0, -1.0));
	blockB[1].d = (true);
	blockB[2].a[0] = (vec3(-4.0, 3.0, -2.0));
	blockB[2].a[1] = (vec3(-5.0, 6.0, -9.0));
	blockB[2].a[2] = (vec3(-8.0, 4.0, -6.0));
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

layout(std430, row_major, buffer_reference) buffer BlockB
{
	mediump uvec3 a[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	highp int b;
	mediump mat3x2 c;
	bool d;
	mediump ivec3 e;
	highp mat4 f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a[0]), uvec3(8u, 0u, 0u)) && allOk;
	allOk = compare_uvec3((blockB.a[1]), uvec3(0u, 2u, 5u)) && allOk;
	allOk = compare_uvec3((blockB.a[2]), uvec3(5u, 2u, 5u)) && allOk;
	allOk = compare_uvec3((blockB.a[3]), uvec3(1u, 5u, 2u)) && allOk;
	allOk = compare_uvec3((blockB.a[4]), uvec3(0u, 0u, 3u)) && allOk;
	allOk = compare_uvec3((blockB.a[5]), uvec3(0u, 7u, 4u)) && allOk;
	allOk = compare_uvec3((blockB.a[6]), uvec3(8u, 9u, 8u)) && allOk;
	allOk = compare_bool((blockC.d), false) && allOk;
	allOk = compare_ivec3((blockC.e), ivec3(-3, -1, 1)) && allOk;
	allOk = compare_mat4(blockC.f[0], mat4(0.0, -3.0, 1.0, 3.0, -9.0, -4.0, 3.0, 9.0, 1.0, 3.0, -9.0, -5.0, 9.0, -7.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat4(blockC.f[1], mat4(6.0, 0.0, -3.0, 4.0, -7.0, -1.0, 5.0, -3.0, 0.0, -8.0, 1.0, -9.0, -9.0, -9.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat4(blockC.f[2], mat4(-2.0, 2.0, -4.0, 4.0, -8.0, 4.0, 8.0, 5.0, -7.0, -8.0, -5.0, 0.0, 1.0, -4.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat4(blockC.f[3], mat4(-4.0, -5.0, 1.0, 5.0, 4.0, -7.0, 6.0, 8.0, 0.0, -7.0, -8.0, -7.0, -3.0, 3.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat4(blockC.f[4], mat4(-1.0, -7.0, 0.0, 6.0, -5.0, 4.0, -3.0, 7.0, -5.0, 1.0, 8.0, 0.0, -3.0, -8.0, 6.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (uvec3(0u, 7u, 5u));
	blockB.a[1] = (uvec3(6u, 7u, 2u));
	blockB.a[2] = (uvec3(9u, 7u, 2u));
	blockB.a[3] = (uvec3(4u, 4u, 4u));
	blockB.a[4] = (uvec3(3u, 2u, 5u));
	blockB.a[5] = (uvec3(6u, 0u, 2u));
	blockB.a[6] = (uvec3(1u, 9u, 4u));
	blockC.b = (7);
	blockC.c = (mat3x2(-2.0, 1.0, 3.0, -9.0, -2.0, -7.0));
	blockC.e = (ivec3(4, -1, 8));
}
#version 450
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
	bvec3 a;
	mediump uvec4 b;
	highp vec3 c;
	bool d[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	bool e[1];
	highp uvec4 f;
	bool g;
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	bvec3 h;
	lowp mat4x3 i[1];
	highp int j;
	mediump mat2 k;
	highp vec3 l[];
};
layout(std430, column_major, buffer_reference) buffer BlockE
{
	bvec3 m;
	bvec2 n[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[1];
    BlockE blockE[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.b), uvec4(9u, 6u, 8u, 8u)) && allOk;
	allOk = compare_vec3((blockB.c), vec3(-5.0, -8.0, -6.0)) && allOk;
	allOk = compare_bool((blockB.d[0]), true) && allOk;
	allOk = compare_bool((blockC.e[0]), false) && allOk;
	allOk = compare_bool((blockC.g), true) && allOk;
	allOk = compare_bvec3((blockD[0].h), bvec3(true, false, true)) && allOk;
	allOk = compare_mat2(blockD[0].k, mat2(9.0, 1.0, -8.0, 1.0)) && allOk;
	allOk = compare_bvec3((blockE[0].m), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((blockE[1].m), bvec3(false, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec3(true, false, true));
	blockB.b = (uvec4(6u, 4u, 0u, 5u));
	blockB.c = (vec3(-5.0, -7.0, 5.0));
	blockB.d[0] = (true);
	blockC.f = (uvec4(9u, 8u, 1u, 3u));
	blockD[0].h = (bvec3(false, false, false));
	blockD[0].j = (-9);
	blockD[0].k = (mat2(-1.0, -1.0, 7.0, -1.0));
	blockD[0].l[0] = (vec3(-7.0, 7.0, 4.0));
	blockE[0].m = (bvec3(true, false, false));
	blockE[1].m = (bvec3(false, false, false));
}
#version 450
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
	mediump vec3 a[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	bvec4 b;
	mediump mat2x3 c;
	bvec3 d;
	highp mat4 e;
	mediump ivec3 f[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	mediump uint g;
	bvec2 h[];
};
layout(std430, buffer_reference) readonly buffer BlockE
{
	mediump ivec2 i;
	bvec3 j;
	highp mat4x2 k;
	bvec2 l[];
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
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockC.b), bvec4(true, true, true, true)) && allOk;
	allOk = compare_mat2x3(blockC.c, mat2x3(-8.0, 2.0, 7.0, -7.0, 7.0, -4.0)) && allOk;
	allOk = compare_uint((blockD.g), 3u) && allOk;
	allOk = compare_bvec2((blockD.h[0]), bvec2(true, false)) && allOk;
	allOk = compare_ivec2((blockE.i), ivec2(1, 6)) && allOk;
	allOk = compare_bvec3((blockE.j), bvec3(true, true, false)) && allOk;
	allOk = compare_mat4x2(blockE.k, mat4x2(-5.0, 5.0, -5.0, -4.0, -6.0, -4.0, 8.0, 9.0)) && allOk;
	allOk = compare_bvec2((blockE.l[0]), bvec2(true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (vec3(-6.0, -2.0, 3.0));
	blockC.b = (bvec4(true, true, true, false));
	blockC.c = (mat2x3(5.0, -4.0, -9.0, -3.0, 7.0, 3.0));
	blockC.d = (bvec3(false, true, false));
	blockC.e = (mat4(2.0, -7.0, 4.0, 9.0, -8.0, -1.0, 3.0, -1.0, 4.0, 1.0, -8.0, -8.0, -1.0, -5.0, 7.0, -5.0));
	blockD.g = (1u);
	blockD.h[0] = (bvec2(false, false));
}
#version 450
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
	highp mat4x2 a;
	mediump mat4x3 b;
	mediump ivec3 c[6];
	highp mat4 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB.a, mat4x2(6.0, 8.0, 8.0, 0.0, -4.0, -5.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(blockB.b, mat4x3(-6.0, -1.0, -1.0, -2.0, 1.0, 6.0, 5.0, 7.0, -2.0, -4.0, -9.0, 8.0)) && allOk;
	allOk = compare_ivec3((blockB.c[0]), ivec3(3, 0, 2)) && allOk;
	allOk = compare_ivec3((blockB.c[1]), ivec3(1, 8, 0)) && allOk;
	allOk = compare_ivec3((blockB.c[2]), ivec3(9, -1, -1)) && allOk;
	allOk = compare_ivec3((blockB.c[3]), ivec3(-7, 7, -4)) && allOk;
	allOk = compare_ivec3((blockB.c[4]), ivec3(-3, 1, -4)) && allOk;
	allOk = compare_ivec3((blockB.c[5]), ivec3(-9, 1, -4)) && allOk;
	allOk = compare_mat4(blockB.d, mat4(0.0, 2.0, 0.0, 6.0, 2.0, 3.0, -5.0, -1.0, -5.0, -1.0, -9.0, -6.0, -9.0, -8.0, 6.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x2(-5.0, -3.0, -2.0, 0.0, -6.0, 6.0, -6.0, 3.0));
	blockB.b = (mat4x3(-7.0, 8.0, 5.0, -6.0, -7.0, -2.0, 2.0, 3.0, -1.0, 4.0, -4.0, -6.0));
	blockB.d = (mat4(-8.0, 5.0, -4.0, 8.0, -5.0, 2.0, -2.0, 8.0, -1.0, -1.0, 1.0, 7.0, 8.0, 7.0, 0.0, -5.0));
}
#version 450
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
	lowp uvec4 mA;
	bvec3 mB;
};
struct sB
{
	sA mA[7];
	bvec4 mB;
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	lowp mat4x3 a[6];
	highp float b[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	bvec4 c;
	mediump ivec3 d;
	mediump mat4x3 e;
	lowp mat3x2 f;
	lowp ivec4 g[];
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	lowp mat2 h;
	sB i;
	lowp mat3 j[][3];
};
layout(std140, row_major, buffer_reference) buffer BlockE
{
	mediump uvec3 k;
	lowp ivec2 l;
	bool m[1];
	lowp vec4 n;
	lowp float o;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[2];
    BlockD blockD[1];
    BlockE blockE[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.a[0], mat4x3(0.0, 2.0, -8.0, 6.0, 7.0, 5.0, -6.0, 1.0, 9.0, -4.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1], mat4x3(4.0, 9.0, -9.0, -8.0, -9.0, 8.0, 0.0, 4.0, -4.0, 7.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[2], mat4x3(7.0, -5.0, -4.0, 3.0, -5.0, -3.0, -1.0, 1.0, 0.0, -3.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[3], mat4x3(-9.0, -4.0, 3.0, 9.0, 1.0, 3.0, -9.0, -5.0, 9.0, -7.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[4], mat4x3(6.0, 0.0, -3.0, 4.0, -7.0, -1.0, 5.0, -3.0, 0.0, -8.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[5], mat4x3(-9.0, -9.0, -7.0, 7.0, -2.0, 2.0, -4.0, 4.0, -8.0, 4.0, 8.0, 5.0)) && allOk;
	allOk = compare_float((blockB.b[0]), -7.0) && allOk;
	allOk = compare_float((blockB.b[1]), -8.0) && allOk;
	allOk = compare_float((blockB.b[2]), -5.0) && allOk;
	allOk = compare_float((blockB.b[3]), 0.0) && allOk;
	allOk = compare_float((blockB.b[4]), 1.0) && allOk;
	allOk = compare_float((blockB.b[5]), -4.0) && allOk;
	allOk = compare_float((blockB.b[6]), -9.0) && allOk;
	allOk = compare_float((blockB.b[7]), 2.0) && allOk;
	allOk = compare_bvec4((blockC[0].c), bvec4(true, false, true, true)) && allOk;
	allOk = compare_mat4x3(blockC[0].e, mat4x3(-8.0, 2.0, 0.0, -7.0, -8.0, 6.0, -3.0, -1.0, -5.0, 3.0, -7.0, 4.0)) && allOk;
	allOk = compare_bvec4((blockC[1].c), bvec4(false, false, true, false)) && allOk;
	allOk = compare_mat4x3(blockC[1].e, mat4x3(0.0, -5.0, -5.0, -7.0, 1.0, -1.0, 9.0, -8.0, -2.0, 6.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat2(blockD[0].h, mat2(7.0, 1.0, 3.0, 5.0)) && allOk;
	allOk = compare_uvec4((blockD[0].i.mA[0].mA), uvec4(0u, 3u, 0u, 3u)) && allOk;
	allOk = compare_bvec3((blockD[0].i.mA[0].mB), bvec3(false, false, true)) && allOk;
	allOk = compare_uvec4((blockD[0].i.mA[1].mA), uvec4(4u, 7u, 0u, 0u)) && allOk;
	allOk = compare_bvec3((blockD[0].i.mA[1].mB), bvec3(false, false, false)) && allOk;
	allOk = compare_uvec4((blockD[0].i.mA[2].mA), uvec4(9u, 9u, 5u, 9u)) && allOk;
	allOk = compare_bvec3((blockD[0].i.mA[2].mB), bvec3(true, true, true)) && allOk;
	allOk = compare_uvec4((blockD[0].i.mA[3].mA), uvec4(3u, 7u, 9u, 7u)) && allOk;
	allOk = compare_bvec3((blockD[0].i.mA[3].mB), bvec3(true, false, true)) && allOk;
	allOk = compare_uvec4((blockD[0].i.mA[4].mA), uvec4(8u, 5u, 1u, 4u)) && allOk;
	allOk = compare_bvec3((blockD[0].i.mA[4].mB), bvec3(false, false, false)) && allOk;
	allOk = compare_uvec4((blockD[0].i.mA[5].mA), uvec4(9u, 8u, 5u, 7u)) && allOk;
	allOk = compare_bvec3((blockD[0].i.mA[5].mB), bvec3(false, true, false)) && allOk;
	allOk = compare_uvec4((blockD[0].i.mA[6].mA), uvec4(8u, 3u, 1u, 8u)) && allOk;
	allOk = compare_bvec3((blockD[0].i.mA[6].mB), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec4((blockD[0].i.mB), bvec4(true, false, false, true)) && allOk;
	allOk = compare_float((blockE[0].o), -7.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat4x3(6.0, -1.0, 0.0, 3.0, -7.0, 6.0, -7.0, 6.0, -8.0, -4.0, -6.0, 3.0));
	blockB.a[1] = (mat4x3(-2.0, 5.0, -2.0, 6.0, 7.0, -5.0, -5.0, -2.0, -2.0, 7.0, -2.0, 1.0));
	blockB.a[2] = (mat4x3(3.0, -9.0, -2.0, -7.0, 9.0, -9.0, 4.0, -1.0, 8.0, 4.0, -4.0, 0.0));
	blockB.a[3] = (mat4x3(7.0, 6.0, 5.0, 3.0, 3.0, -4.0, -6.0, 4.0, 2.0, -6.0, 7.0, -8.0));
	blockB.a[4] = (mat4x3(5.0, 6.0, 8.0, 9.0, 0.0, -7.0, -6.0, -3.0, 8.0, 1.0, -3.0, 0.0));
	blockB.a[5] = (mat4x3(7.0, -5.0, -5.0, 7.0, 8.0, -6.0, 1.0, 8.0, -5.0, 4.0, 8.0, 5.0));
	blockB.b[0] = (-5.0);
	blockB.b[1] = (-7.0);
	blockB.b[2] = (-3.0);
	blockB.b[3] = (-6.0);
	blockB.b[4] = (4.0);
	blockB.b[5] = (-9.0);
	blockB.b[6] = (5.0);
	blockB.b[7] = (1.0);
	blockC[0].d = (ivec3(-3, 4, 9));
	blockC[0].e = (mat4x3(-8.0, -3.0, -6.0, -8.0, -3.0, 6.0, 5.0, -3.0, 4.0, -9.0, -1.0, -3.0));
	blockC[0].f = (mat3x2(8.0, -6.0, 5.0, 0.0, -7.0, -5.0));
	blockC[0].g[0] = (ivec4(-7, 4, -8, -7));
	blockC[0].g[1] = (ivec4(-7, -5, -3, -7));
	blockC[0].g[2] = (ivec4(-5, 3, -1, -5));
	blockC[0].g[3] = (ivec4(-9, -2, -7, -6));
	blockC[0].g[4] = (ivec4(9, 4, 1, -6));
	blockC[0].g[5] = (ivec4(8, 6, -1, -4));
	blockC[0].g[6] = (ivec4(-9, -4, -7, 9));
	blockC[0].g[7] = (ivec4(0, -3, 8, -5));
	blockC[1].d = (ivec3(-1, 9, -8));
	blockC[1].e = (mat4x3(-2.0, 8.0, -6.0, -4.0, 9.0, 6.0, -8.0, -7.0, -7.0, 9.0, 8.0, -3.0));
	blockC[1].f = (mat3x2(-2.0, 6.0, -5.0, -3.0, -9.0, -7.0));
	blockC[1].g[0] = (ivec4(-8, 3, -4, 2));
	blockC[1].g[1] = (ivec4(9, 7, -9, -7));
	blockC[1].g[2] = (ivec4(-2, 6, -3, -6));
	blockC[1].g[3] = (ivec4(2, 2, 3, -9));
	blockC[1].g[4] = (ivec4(-6, 0, 3, -5));
	blockC[1].g[5] = (ivec4(-2, 2, -5, 5));
	blockD[0].h = (mat2(0.0, 6.0, 5.0, 9.0));
	blockD[0].i.mA[0].mA = (uvec4(3u, 1u, 2u, 0u));
	blockD[0].i.mA[0].mB = (bvec3(true, true, false));
	blockD[0].i.mA[1].mA = (uvec4(9u, 4u, 0u, 8u));
	blockD[0].i.mA[1].mB = (bvec3(false, false, false));
	blockD[0].i.mA[2].mA = (uvec4(6u, 9u, 5u, 6u));
	blockD[0].i.mA[2].mB = (bvec3(true, false, true));
	blockD[0].i.mA[3].mA = (uvec4(5u, 4u, 3u, 6u));
	blockD[0].i.mA[3].mB = (bvec3(false, true, false));
	blockD[0].i.mA[4].mA = (uvec4(6u, 3u, 9u, 9u));
	blockD[0].i.mA[4].mB = (bvec3(false, false, true));
	blockD[0].i.mA[5].mA = (uvec4(2u, 7u, 9u, 0u));
	blockD[0].i.mA[5].mB = (bvec3(false, false, false));
	blockD[0].i.mA[6].mA = (uvec4(1u, 8u, 2u, 5u));
	blockD[0].i.mA[6].mB = (bvec3(true, true, true));
	blockD[0].i.mB = (bvec4(false, true, true, true));
	blockE[0].l = (ivec2(5, -9));
	blockE[0].n = (vec4(5.0, 7.0, 0.0, -7.0));
}
#version 450
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
	lowp ivec2 a;
	highp ivec2 b;
	lowp vec2 c[3];
	mediump uvec3 d[7];
	highp vec3 e[];
};
layout(std430, buffer_reference) readonly buffer BlockC
{
	highp int f;
	lowp mat3x4 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.b), ivec2(-9, 7)) && allOk;
	allOk = compare_uvec3((blockB.d[0]), uvec3(7u, 3u, 9u)) && allOk;
	allOk = compare_uvec3((blockB.d[1]), uvec3(3u, 0u, 5u)) && allOk;
	allOk = compare_uvec3((blockB.d[2]), uvec3(5u, 5u, 0u)) && allOk;
	allOk = compare_uvec3((blockB.d[3]), uvec3(6u, 2u, 5u)) && allOk;
	allOk = compare_uvec3((blockB.d[4]), uvec3(3u, 0u, 0u)) && allOk;
	allOk = compare_uvec3((blockB.d[5]), uvec3(8u, 3u, 2u)) && allOk;
	allOk = compare_uvec3((blockB.d[6]), uvec3(7u, 1u, 0u)) && allOk;
	allOk = compare_vec3((blockB.e[0]), vec3(2.0, -2.0, -9.0)) && allOk;
	allOk = compare_vec3((blockB.e[1]), vec3(1.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x4(blockC.g[0], mat3x4(-4.0, -5.0, 3.0, -5.0, 3.0, -4.0, -8.0, -3.0, -7.0, -6.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat3x4(blockC.g[1], mat3x4(4.0, 5.0, -8.0, -1.0, 6.0, -2.0, -6.0, 5.0, -1.0, -8.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x4(blockC.g[2], mat3x4(-7.0, -9.0, -1.0, 2.0, 9.0, 7.0, -8.0, 6.0, 9.0, 5.0, -2.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec2(0, -7));
	blockB.c[0] = (vec2(-1.0, 3.0));
	blockB.c[1] = (vec2(-7.0, -7.0));
	blockB.c[2] = (vec2(6.0, 0.0));
	blockB.d[0] = (uvec3(9u, 7u, 9u));
	blockB.d[1] = (uvec3(0u, 4u, 0u));
	blockB.d[2] = (uvec3(0u, 6u, 5u));
	blockB.d[3] = (uvec3(7u, 9u, 9u));
	blockB.d[4] = (uvec3(4u, 0u, 7u));
	blockB.d[5] = (uvec3(2u, 8u, 2u));
	blockB.d[6] = (uvec3(4u, 0u, 3u));
}
#version 450
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
layout(buffer_reference) readonly buffer BlockC
{
	layout(offset = 0) lowp uint b;
	layout(offset = 4) lowp float c;
	layout(offset = 8) bvec2 d;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) lowp uvec3 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC[1];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB[0].a), 4) && allOk;
	allOk = compare_uint((blockC[0].b), 0u) && allOk;
	allOk = compare_float((blockC[0].c), 8.0) && allOk;
	allOk = compare_bvec2((blockC[0].d), bvec2(true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (1);
	blockD.e = (uvec3(8u, 3u, 4u));
}
#version 450
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
layout(scalar, buffer_reference) buffer BlockB
{
	lowp ivec4 a;
	sA b;
	sB c;
	highp ivec3 d;
	lowp ivec4 e[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	mediump mat3x2 f;
	lowp uvec3 g;
	lowp mat4x2 h;
	bvec2 i;
};
layout(scalar, row_major, buffer_reference) readonly buffer BlockD
{
	bvec3 j[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

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
	allOk = compare_mat3x2(blockC.f, mat3x2(-9.0, 6.0, -2.0, 2.0, 7.0, -1.0)) && allOk;
	allOk = compare_uvec3((blockC.g), uvec3(1u, 2u, 1u)) && allOk;
	allOk = compare_bvec2((blockC.i), bvec2(true, false)) && allOk;
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
	blockC.g = (uvec3(2u, 9u, 7u));
}
#version 450
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
	int16_t mA;
};
struct sB
{
	mediump ivec3 mA;
};
layout(std140, buffer_reference) buffer BlockB
{
	bvec3 a;
	highp float b;
	mediump mat3x2 c;
	f16vec3 d[1];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	mediump int e;
	mediump uint f;
	highp vec3 g;
	bool h;
	i16vec3 i;
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	float16_t j;
	highp ivec3 k[1];
	highp ivec3 l;
	sA m;
	sB n[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.a), bvec3(true, false, false)) && allOk;
	allOk = compare_float((blockB.b), -1.0) && allOk;
	allOk = compare_f16vec3(vec3(blockB.d[0]), vec3(-8.0, 8.0, -8.0)) && allOk;
	allOk = compare_int((blockC.e), -6) && allOk;
	allOk = compare_float16_t(float(blockD.j), 9.0) && allOk;
	allOk = compare_int16_t(int(blockD.m.mA), 8) && allOk;
	allOk = compare_ivec3((blockD.n[0].mA), ivec3(2, -5, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec3(true, false, true));
	blockB.b = (-5.0);
	blockB.c = (mat3x2(-8.0, 3.0, -9.0, 2.0, 6.0, 1.0));
	blockC.e = (-3);
	blockC.g = (vec3(7.0, -9.0, -6.0));
	blockC.i = i16vec3(ivec3(5, 3, 9));
	blockD.j = float16_t(8.0);
	blockD.k[0] = (ivec3(-4, -8, -5));
	blockD.l = (ivec3(-1, 2, 0));
	blockD.m.mA = int16_t(5);
	blockD.n[0].mA = (ivec3(3, -3, 2));
}
#version 450
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
	bvec3 a[7];
	mediump mat3x4 b[];
};
layout(std430, buffer_reference) buffer BlockC
{
	float16_t c;
	f16vec2 d;
	bool e;
	u16vec4 f[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	i16vec4 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(blockC.d), vec2(-7.0, 2.0)) && allOk;
	allOk = compare_bool((blockC.e), true) && allOk;
	allOk = compare_u16vec4(uvec4(blockC.f[0]), uvec4(0u, 8u, 9u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC.f[1]), uvec4(0u, 3u, 4u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (bvec3(true, false, true));
	blockB.a[1] = (bvec3(true, false, true));
	blockB.a[2] = (bvec3(true, true, false));
	blockB.a[3] = (bvec3(false, false, true));
	blockB.a[4] = (bvec3(false, true, false));
	blockB.a[5] = (bvec3(true, true, false));
	blockB.a[6] = (bvec3(false, true, true));
	blockC.d = f16vec2(vec2(7.0, 6.0));
	blockC.e = (false);
	blockC.f[0] = u16vec4(uvec4(5u, 5u, 9u, 0u));
	blockC.f[1] = u16vec4(uvec4(7u, 9u, 9u, 9u));
	blockD.g[0] = i16vec4(ivec4(-8, 1, -6, 7));
	blockD.g[1] = i16vec4(ivec4(-7, 7, -2, 2));
	blockD.g[2] = i16vec4(ivec4(2, 4, -9, 9));
	blockD.g[3] = i16vec4(ivec4(-2, -4, -3, 7));
	blockD.g[4] = i16vec4(ivec4(8, -4, -5, -8));
	blockD.g[5] = i16vec4(ivec4(-1, -1, -9, -8));
	blockD.g[6] = i16vec4(ivec4(1, 9, -2, 2));
}
#version 450
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
	lowp ivec3 mA;
};
layout(std140, buffer_reference) buffer BlockB
{
	uint16_t a;
	bool b[1];
	sA c[];
};
layout(std430, column_major, buffer_reference) readonly buffer BlockC
{
	f16vec2 d[][7][6];
};
layout(std140, buffer_reference) buffer BlockD
{
	u16vec4 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(blockB[0].a), 0u) && allOk;
	allOk = compare_bool((blockB[0].b[0]), false) && allOk;
	allOk = compare_uint16_t(uint(blockB[1].a), 1u) && allOk;
	allOk = compare_bool((blockB[1].b[0]), true) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0][0][0]), vec2(-2.0, -4.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0][0][1]), vec2(9.0, 7.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0][0][2]), vec2(6.0, 2.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0][0][3]), vec2(3.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0][0][4]), vec2(8.0, 0.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0][0][5]), vec2(8.0, -4.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0][1][0]), vec2(-4.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0][1][1]), vec2(-5.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0][1][2]), vec2(3.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0][1][3]), vec2(-6.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0][1][4]), vec2(7.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0][1][5]), vec2(-8.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0][2][0]), vec2(-2.0, -9.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0][2][1]), vec2(-6.0, -8.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0][2][2]), vec2(-6.0, -7.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0][2][3]), vec2(-5.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0][2][4]), vec2(6.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0][2][5]), vec2(7.0, 0.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0][3][0]), vec2(5.0, 7.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0][3][1]), vec2(-5.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0][3][2]), vec2(7.0, -8.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0][3][3]), vec2(-7.0, 2.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0][3][4]), vec2(2.0, 7.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0][3][5]), vec2(-7.0, -4.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0][4][0]), vec2(2.0, 5.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0][4][1]), vec2(2.0, 3.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0][4][2]), vec2(8.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0][4][3]), vec2(1.0, 5.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0][4][4]), vec2(4.0, -8.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0][4][5]), vec2(1.0, -8.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0][5][0]), vec2(3.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0][5][1]), vec2(5.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0][5][2]), vec2(-9.0, -7.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0][5][3]), vec2(-7.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0][5][4]), vec2(1.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0][5][5]), vec2(4.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0][6][0]), vec2(1.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0][6][1]), vec2(6.0, 9.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0][6][2]), vec2(-1.0, 4.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0][6][3]), vec2(8.0, 3.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0][6][4]), vec2(9.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0][6][5]), vec2(-5.0, 0.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1][0][0]), vec2(-6.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1][0][1]), vec2(-1.0, 5.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1][0][2]), vec2(-1.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1][0][3]), vec2(0.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1][0][4]), vec2(-5.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1][0][5]), vec2(2.0, 4.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1][1][0]), vec2(3.0, -9.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1][1][1]), vec2(5.0, -2.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1][1][2]), vec2(1.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1][1][3]), vec2(8.0, 0.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1][1][4]), vec2(-6.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1][1][5]), vec2(-5.0, 4.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1][2][0]), vec2(7.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1][2][1]), vec2(-6.0, 5.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1][2][2]), vec2(-5.0, -9.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1][2][3]), vec2(-4.0, 4.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1][2][4]), vec2(2.0, 4.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1][2][5]), vec2(1.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1][3][0]), vec2(6.0, 9.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1][3][1]), vec2(4.0, -9.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1][3][2]), vec2(1.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1][3][3]), vec2(1.0, -8.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1][3][4]), vec2(2.0, 5.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1][3][5]), vec2(-7.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1][4][0]), vec2(-9.0, 2.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1][4][1]), vec2(4.0, -9.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1][4][2]), vec2(2.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1][4][3]), vec2(9.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1][4][4]), vec2(-4.0, 0.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1][4][5]), vec2(5.0, 0.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1][5][0]), vec2(2.0, 9.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1][5][1]), vec2(-7.0, 5.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1][5][2]), vec2(-4.0, -4.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1][5][3]), vec2(8.0, 3.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1][5][4]), vec2(-9.0, -9.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1][5][5]), vec2(-8.0, -9.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1][6][0]), vec2(-1.0, -2.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1][6][1]), vec2(9.0, 5.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1][6][2]), vec2(-1.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1][6][3]), vec2(-5.0, 3.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1][6][4]), vec2(2.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[1][6][5]), vec2(4.0, -9.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2][0][0]), vec2(-8.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2][0][1]), vec2(5.0, -8.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2][0][2]), vec2(5.0, 7.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2][0][3]), vec2(-2.0, -8.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2][0][4]), vec2(-3.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2][0][5]), vec2(7.0, 2.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2][1][0]), vec2(3.0, 3.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2][1][1]), vec2(4.0, -4.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2][1][2]), vec2(-4.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2][1][3]), vec2(-9.0, 5.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2][1][4]), vec2(-8.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2][1][5]), vec2(-4.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2][2][0]), vec2(-2.0, 7.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2][2][1]), vec2(5.0, 0.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2][2][2]), vec2(-9.0, 0.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2][2][3]), vec2(0.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2][2][4]), vec2(3.0, -4.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2][2][5]), vec2(-6.0, 4.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2][3][0]), vec2(4.0, 7.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2][3][1]), vec2(-2.0, 9.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2][3][2]), vec2(7.0, 5.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2][3][3]), vec2(9.0, -7.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2][3][4]), vec2(-2.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2][3][5]), vec2(-6.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2][4][0]), vec2(-4.0, -8.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2][4][1]), vec2(-4.0, 0.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2][4][2]), vec2(7.0, 5.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2][4][3]), vec2(-8.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2][4][4]), vec2(-5.0, 2.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2][4][5]), vec2(2.0, 0.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2][5][0]), vec2(9.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2][5][1]), vec2(-8.0, -4.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2][5][2]), vec2(1.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2][5][3]), vec2(3.0, 9.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2][5][4]), vec2(-7.0, 9.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2][5][5]), vec2(-3.0, 4.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2][6][0]), vec2(1.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2][6][1]), vec2(1.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2][6][2]), vec2(5.0, 0.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2][6][3]), vec2(-1.0, -4.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2][6][4]), vec2(-2.0, -7.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[2][6][5]), vec2(3.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = uint16_t(2u);
	blockB[0].b[0] = (true);
	blockB[0].c[0].mA = (ivec3(9, 0, 9));
	blockB[0].c[1].mA = (ivec3(-5, -3, 3));
	blockB[0].c[2].mA = (ivec3(5, -9, 5));
	blockB[0].c[3].mA = (ivec3(5, 2, 6));
	blockB[0].c[4].mA = (ivec3(-5, -8, -8));
	blockB[0].c[5].mA = (ivec3(-6, 9, 7));
	blockB[0].c[6].mA = (ivec3(0, 1, -3));
	blockB[1].a = uint16_t(6u);
	blockB[1].b[0] = (true);
	blockB[1].c[0].mA = (ivec3(-9, -5, -8));
	blockD.e = u16vec4(uvec4(8u, 6u, 7u, 1u));
}
#version 450
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
	f16vec2 a;
	u16vec2 b[];
};
layout(std140, row_major, buffer_reference) readonly buffer BlockC
{
	i16vec4 c;
	lowp mat2 d;
	lowp uvec4 e[4];
	lowp ivec2 f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(blockB.a), vec2(-1.0, -5.0)) && allOk;
	allOk = compare_u16vec2(uvec2(blockB.b[0]), uvec2(0u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockB.b[1]), uvec2(6u, 0u)) && allOk;
	allOk = compare_uvec4((blockC.e[0]), uvec4(3u, 4u, 7u, 1u)) && allOk;
	allOk = compare_uvec4((blockC.e[1]), uvec4(9u, 2u, 8u, 1u)) && allOk;
	allOk = compare_uvec4((blockC.e[2]), uvec4(9u, 3u, 5u, 3u)) && allOk;
	allOk = compare_uvec4((blockC.e[3]), uvec4(6u, 8u, 7u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = f16vec2(vec2(0.0, -7.0));
}
#version 450
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
	layout(offset = 0) float16_t a;
	layout(offset = 4) bvec3 b;
	layout(offset = 16) f16vec4 c;
	layout(offset = 24) lowp float d;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump ivec2 e;
	layout(offset = 8) u16vec4 f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(blockB.c), vec4(9.0, -4.0, -6.0, -1.0)) && allOk;
	allOk = compare_float((blockB.d), -1.0) && allOk;
	allOk = compare_ivec2((blockC.e), ivec2(-2, 1)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC.f), uvec4(3u, 8u, 2u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = float16_t(-5.0);
	blockB.b = (bvec3(false, true, true));
	blockB.c = f16vec4(vec4(-6.0, 3.0, -7.0, 8.0));
	blockB.d = (5.0);
	blockC.e = (ivec2(-6, -7));
}
#version 450
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
	lowp vec3 mA;
	i16vec4 mB;
};
struct sB
{
	lowp mat3x4 mA;
	mediump mat4x3 mB;
	f16vec3 mC;
	f16vec2 mD;
};
struct sC
{
	highp vec4 mA;
	mediump mat2 mB;
};
struct sD
{
	sC mA;
	lowp mat3 mB;
	lowp ivec3 mC;
	f16vec2 mD;
};
struct sE
{
	f16vec4 mA;
	bool mB;
	highp int mC;
};
layout(scalar, buffer_reference) buffer BlockB
{
	sA a;
	i16vec4 b;
	lowp uvec4 c;
	i16vec2 d;
	sB e[];
};
layout(scalar, buffer_reference) readonly buffer BlockC
{
	mediump ivec3 f;
};
layout(scalar, row_major, buffer_reference) buffer BlockD
{
	i16vec2 g;
	mediump mat3 h;
	lowp ivec4 i;
	highp mat3x4 j;
};
layout(scalar, row_major, buffer_reference) buffer BlockE
{
	sD k;
	sE l;
	float16_t m[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
    BlockD blockD[1];
    BlockE blockE[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB[0].a.mA), vec3(-3.0, -9.0, -9.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[0].a.mB), ivec4(-6, 3, 4, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[0].b), ivec4(6, -2, 9, 1)) && allOk;
	allOk = compare_vec3((blockB[1].a.mA), vec3(-6.0, -9.0, 3.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[1].a.mB), ivec4(-9, -2, -5, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[1].b), ivec4(-5, 7, -2, -2)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD[0].g), ivec2(-7, -7)) && allOk;
	allOk = compare_mat3(blockD[0].h, mat3(-5.0, -3.0, 5.0, -4.0, -2.0, -8.0, -7.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].j, mat3x4(8.0, -2.0, 6.0, 9.0, -7.0, -5.0, 5.0, -9.0, -3.0, -2.0, 3.0, 9.0)) && allOk;
	allOk = compare_vec4((blockE[0].k.mA.mA), vec4(-3.0, 1.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat2(blockE[0].k.mA.mB, mat2(2.0, -7.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3(blockE[0].k.mB, mat3(3.0, -5.0, 7.0, -7.0, 5.0, 1.0, -1.0, -2.0, -4.0)) && allOk;
	allOk = compare_ivec3((blockE[0].k.mC), ivec3(-2, -6, -7)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[0].k.mD), vec2(-1.0, -3.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockE[0].l.mA), vec4(3.0, 3.0, -4.0, 5.0)) && allOk;
	allOk = compare_bool((blockE[0].l.mB), false) && allOk;
	allOk = compare_int((blockE[0].l.mC), 7) && allOk;
	allOk = compare_vec4((blockE[1].k.mA.mA), vec4(0.0, -1.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat2(blockE[1].k.mA.mB, mat2(5.0, 2.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat3(blockE[1].k.mB, mat3(-5.0, -4.0, -6.0, 7.0, 8.0, 5.0, 1.0, 8.0, -3.0)) && allOk;
	allOk = compare_ivec3((blockE[1].k.mC), ivec3(7, 7, 3)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[1].k.mD), vec2(3.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockE[1].l.mA), vec4(3.0, 0.0, 1.0, -3.0)) && allOk;
	allOk = compare_bool((blockE[1].l.mB), true) && allOk;
	allOk = compare_int((blockE[1].l.mC), 9) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a.mA = (vec3(-3.0, -9.0, 9.0));
	blockB[0].a.mB = i16vec4(ivec4(-6, 8, 7, -8));
	blockB[0].b = i16vec4(ivec4(2, -8, -7, 8));
	blockB[0].c = (uvec4(3u, 1u, 3u, 9u));
	blockB[1].a.mA = (vec3(7.0, -4.0, -9.0));
	blockB[1].a.mB = i16vec4(ivec4(5, 6, 2, -1));
	blockB[1].b = i16vec4(ivec4(4, 9, 7, -8));
	blockB[1].c = (uvec4(2u, 7u, 0u, 7u));
	blockD[0].g = i16vec2(ivec2(-5, 7));
	blockD[0].h = (mat3(6.0, -7.0, 7.0, 1.0, 0.0, 2.0, 5.0, 4.0, -6.0));
	blockD[0].i = (ivec4(2, -7, -2, -6));
	blockD[0].j = (mat3x4(8.0, 0.0, -2.0, 9.0, -5.0, 1.0, -8.0, -4.0, -2.0, -7.0, -8.0, -4.0));
	blockE[0].l.mA = f16vec4(vec4(8.0, 6.0, 3.0, 8.0));
	blockE[0].l.mB = (false);
	blockE[0].l.mC = (3);
	blockE[0].m[0] = float16_t(7.0);
	blockE[0].m[1] = float16_t(5.0);
	blockE[0].m[2] = float16_t(-4.0);
	blockE[0].m[3] = float16_t(-4.0);
	blockE[1].l.mA = f16vec4(vec4(6.0, 9.0, -6.0, -6.0));
	blockE[1].l.mB = (true);
	blockE[1].l.mC = (-9);
	blockE[1].m[0] = float16_t(-5.0);
	blockE[1].m[1] = float16_t(7.0);
	blockE[1].m[2] = float16_t(5.0);
}
#version 450
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
	highp int a;
	uint8_t b;
	lowp float c;
	highp uint d;
	bool e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.a), 4) && allOk;
	allOk = compare_uint8_t(uint(blockB.b), 1u) && allOk;
	allOk = compare_float((blockB.c), -4.0) && allOk;
	allOk = compare_uint((blockB.d), 8u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = uint8_t(2u);
}
#version 450
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
	mediump vec3 a;
	i8vec3 b;
	highp ivec2 c;
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	uint8_t d;
	lowp ivec2 e;
	int8_t f;
};
layout(std430, buffer_reference) buffer BlockD
{
	mediump uvec2 g;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.a), vec3(-5.0, 5.0, -6.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.b), ivec3(4294967287, 9, 4294967291)) && allOk;
	allOk = compare_ivec2((blockB.c), ivec2(7, 7)) && allOk;
	allOk = compare_ivec2((blockC.e), ivec2(5, -7)) && allOk;
	allOk = compare_uvec2((blockD.g), uvec2(9u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec3(3.0, -4.0, 2.0));
	blockB.b = i8vec3(ivec3(2, 4, 9));
	blockB.c = (ivec2(-2, -4));
	blockC.d = uint8_t(8u);
	blockC.e = (ivec2(-2, 0));
	blockD.g = (uvec2(8u, 2u));
}
#version 450
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
	mediump vec3 a;
	i8vec3 b;
	bvec4 c;
};
layout(std140, column_major, buffer_reference) readonly buffer BlockC
{
	int8_t d[];
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	lowp uvec3 e;
	lowp vec2 f;
	mediump uvec3 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.a), vec3(-5.0, 5.0, -6.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.b), ivec3(4294967287, 9, 4294967291)) && allOk;
	allOk = compare_bvec4((blockB.c), bvec4(true, true, false, true)) && allOk;
	allOk = compare_int8_t(int(blockC.d[0]), 4294967295) && allOk;
	allOk = compare_int8_t(int(blockC.d[1]), 5) && allOk;
	allOk = compare_uvec3((blockD.e), uvec3(4u, 5u, 0u)) && allOk;
	allOk = compare_vec2((blockD.f), vec2(7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec3(3.0, -4.0, 2.0));
	blockB.b = i8vec3(ivec3(2, 4, 9));
	blockB.c = (bvec4(false, false, true, false));
	blockD.e = (uvec3(2u, 7u, 5u));
	blockD.g[0] = (uvec3(2u, 5u, 8u));
	blockD.g[1] = (uvec3(6u, 1u, 4u));
	blockD.g[2] = (uvec3(5u, 8u, 2u));
	blockD.g[3] = (uvec3(6u, 0u, 5u));
	blockD.g[4] = (uvec3(2u, 9u, 4u));
	blockD.g[5] = (uvec3(5u, 1u, 4u));
	blockD.g[6] = (uvec3(8u, 8u, 3u));
	blockD.g[7] = (uvec3(6u, 1u, 4u));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, buffer_reference) readonly buffer BlockB
{
	highp vec4 a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
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

layout(std140, column_major, buffer_reference) buffer BlockB
{
	highp uvec3 a;
	u8vec3 b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a), uvec3(8u, 2u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.b), uvec3(1u, 6u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = u8vec3(uvec3(0u, 9u, 6u));
}
#version 450
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
	bvec4 mA;
};
struct sB
{
	highp uvec3 mA;
	u8vec4 mB;
	sA mC;
};
layout(std430, buffer_reference) buffer BlockB
{
	i8vec4 a;
	lowp mat2 b;
	highp int c;
	highp ivec3 d;
	sB e[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	highp uint f;
	lowp int g;
	bool h[];
};
layout(std140, buffer_reference) buffer BlockD
{
	lowp mat3x2 i[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(blockB[0].a), ivec4(2, 4294967288, 4294967292, 7)) && allOk;
	allOk = compare_mat2(blockB[0].b, mat2(4.0, 0.0, -5.0, -8.0)) && allOk;
	allOk = compare_int((blockB[0].c), -6) && allOk;
	allOk = compare_ivec3((blockB[0].d), ivec3(4, 5, 6)) && allOk;
	allOk = compare_uvec3((blockB[0].e[0].mA), uvec3(2u, 6u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[0].e[0].mB), uvec4(8u, 5u, 7u, 2u)) && allOk;
	allOk = compare_bvec4((blockB[0].e[0].mC.mA), bvec4(true, false, true, true)) && allOk;
	allOk = compare_uvec3((blockB[0].e[1].mA), uvec3(2u, 4u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[0].e[1].mB), uvec4(4u, 2u, 8u, 2u)) && allOk;
	allOk = compare_bvec4((blockB[0].e[1].mC.mA), bvec4(true, true, false, true)) && allOk;
	allOk = compare_uvec3((blockB[0].e[2].mA), uvec3(1u, 4u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[0].e[2].mB), uvec4(8u, 5u, 1u, 9u)) && allOk;
	allOk = compare_bvec4((blockB[0].e[2].mC.mA), bvec4(true, true, false, false)) && allOk;
	allOk = compare_uvec3((blockB[0].e[3].mA), uvec3(4u, 0u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[0].e[3].mB), uvec4(0u, 1u, 7u, 1u)) && allOk;
	allOk = compare_bvec4((blockB[0].e[3].mC.mA), bvec4(true, true, false, true)) && allOk;
	allOk = compare_uvec3((blockB[0].e[4].mA), uvec3(1u, 3u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[0].e[4].mB), uvec4(8u, 5u, 6u, 3u)) && allOk;
	allOk = compare_bvec4((blockB[0].e[4].mC.mA), bvec4(true, false, false, false)) && allOk;
	allOk = compare_uvec3((blockB[0].e[5].mA), uvec3(8u, 5u, 3u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[0].e[5].mB), uvec4(3u, 8u, 5u, 2u)) && allOk;
	allOk = compare_bvec4((blockB[0].e[5].mC.mA), bvec4(false, false, true, true)) && allOk;
	allOk = compare_uvec3((blockB[0].e[6].mA), uvec3(7u, 9u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[0].e[6].mB), uvec4(7u, 5u, 6u, 3u)) && allOk;
	allOk = compare_bvec4((blockB[0].e[6].mC.mA), bvec4(false, true, true, false)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[1].a), ivec4(4294967289, 7, 0, 0)) && allOk;
	allOk = compare_mat2(blockB[1].b, mat2(0.0, -5.0, 3.0, -8.0)) && allOk;
	allOk = compare_int((blockB[1].c), 6) && allOk;
	allOk = compare_ivec3((blockB[1].d), ivec3(-6, 9, 0)) && allOk;
	allOk = compare_uvec3((blockB[1].e[0].mA), uvec3(9u, 9u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[1].e[0].mB), uvec4(8u, 1u, 4u, 7u)) && allOk;
	allOk = compare_bvec4((blockB[1].e[0].mC.mA), bvec4(true, true, true, false)) && allOk;
	allOk = compare_uvec3((blockB[1].e[1].mA), uvec3(7u, 9u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[1].e[1].mB), uvec4(8u, 0u, 0u, 2u)) && allOk;
	allOk = compare_bvec4((blockB[1].e[1].mC.mA), bvec4(false, true, false, true)) && allOk;
	allOk = compare_uvec3((blockB[1].e[2].mA), uvec3(7u, 9u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[1].e[2].mB), uvec4(2u, 1u, 9u, 8u)) && allOk;
	allOk = compare_bvec4((blockB[1].e[2].mC.mA), bvec4(true, true, false, false)) && allOk;
	allOk = compare_uvec3((blockB[1].e[3].mA), uvec3(4u, 7u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[1].e[3].mB), uvec4(3u, 4u, 2u, 8u)) && allOk;
	allOk = compare_bvec4((blockB[1].e[3].mC.mA), bvec4(false, false, false, true)) && allOk;
	allOk = compare_uvec3((blockB[1].e[4].mA), uvec3(8u, 8u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[1].e[4].mB), uvec4(6u, 3u, 2u, 6u)) && allOk;
	allOk = compare_bvec4((blockB[1].e[4].mC.mA), bvec4(true, true, false, true)) && allOk;
	allOk = compare_uint((blockC.f), 2u) && allOk;
	allOk = compare_int((blockC.g), -7) && allOk;
	allOk = compare_bool((blockC.h[0]), true) && allOk;
	allOk = compare_bool((blockC.h[1]), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = i8vec4(ivec4(8, 4294967294, 4294967295, 4294967290));
	blockB[0].b = (mat2(6.0, 0.0, 9.0, 5.0));
	blockB[0].c = (4);
	blockB[0].d = (ivec3(8, 6, 7));
	blockB[0].e[0].mA = (uvec3(8u, 3u, 0u));
	blockB[0].e[0].mB = u8vec4(uvec4(4u, 3u, 2u, 6u));
	blockB[0].e[0].mC.mA = (bvec4(false, true, true, false));
	blockB[0].e[1].mA = (uvec3(7u, 1u, 3u));
	blockB[0].e[1].mB = u8vec4(uvec4(0u, 3u, 6u, 1u));
	blockB[0].e[1].mC.mA = (bvec4(false, true, true, true));
	blockB[0].e[2].mA = (uvec3(9u, 6u, 4u));
	blockB[0].e[2].mB = u8vec4(uvec4(7u, 1u, 6u, 5u));
	blockB[0].e[2].mC.mA = (bvec4(true, true, false, true));
	blockB[0].e[3].mA = (uvec3(7u, 4u, 6u));
	blockB[0].e[3].mB = u8vec4(uvec4(2u, 0u, 0u, 2u));
	blockB[0].e[3].mC.mA = (bvec4(false, true, false, true));
	blockB[0].e[4].mA = (uvec3(2u, 2u, 7u));
	blockB[0].e[4].mB = u8vec4(uvec4(2u, 0u, 7u, 7u));
	blockB[0].e[4].mC.mA = (bvec4(false, false, true, false));
	blockB[0].e[5].mA = (uvec3(7u, 0u, 5u));
	blockB[0].e[5].mB = u8vec4(uvec4(1u, 0u, 4u, 8u));
	blockB[0].e[5].mC.mA = (bvec4(true, true, true, false));
	blockB[0].e[6].mA = (uvec3(4u, 6u, 3u));
	blockB[0].e[6].mB = u8vec4(uvec4(5u, 7u, 6u, 4u));
	blockB[0].e[6].mC.mA = (bvec4(true, false, false, true));
	blockB[1].a = i8vec4(ivec4(4294967293, 5, 9, 4294967291));
	blockB[1].b = (mat2(-8.0, -9.0, 9.0, 5.0));
	blockB[1].c = (1);
	blockB[1].d = (ivec3(-7, 3, -7));
	blockB[1].e[0].mA = (uvec3(0u, 6u, 7u));
	blockB[1].e[0].mB = u8vec4(uvec4(9u, 4u, 1u, 1u));
	blockB[1].e[0].mC.mA = (bvec4(true, false, true, true));
	blockB[1].e[1].mA = (uvec3(3u, 9u, 4u));
	blockB[1].e[1].mB = u8vec4(uvec4(8u, 7u, 7u, 5u));
	blockB[1].e[1].mC.mA = (bvec4(true, false, true, false));
	blockB[1].e[2].mA = (uvec3(7u, 4u, 9u));
	blockB[1].e[2].mB = u8vec4(uvec4(3u, 9u, 3u, 1u));
	blockB[1].e[2].mC.mA = (bvec4(false, false, true, true));
	blockB[1].e[3].mA = (uvec3(1u, 5u, 7u));
	blockB[1].e[3].mB = u8vec4(uvec4(4u, 6u, 9u, 3u));
	blockB[1].e[3].mC.mA = (bvec4(false, false, false, true));
	blockB[1].e[4].mA = (uvec3(6u, 9u, 1u));
	blockB[1].e[4].mB = u8vec4(uvec4(3u, 9u, 5u, 1u));
	blockB[1].e[4].mC.mA = (bvec4(false, false, false, false));
	blockC.f = (5u);
	blockC.h[0] = (true);
	blockC.h[1] = (false);
	blockD.i[0] = (mat3x2(0.0, -4.0, -2.0, 5.0, -2.0, 6.0));
	blockD.i[1] = (mat3x2(-8.0, -4.0, -7.0, 2.0, 7.0, -3.0));
	blockD.i[2] = (mat3x2(-5.0, 2.0, -7.0, 6.0, -5.0, 0.0));
}
#version 450
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
	highp vec3 a;
	bvec3 b;
	mediump mat4x2 c;
	mediump uvec4 d;
	bool e[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	i8vec4 f;
	highp mat4x3 g;
	lowp mat2x3 h;
	highp int i[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.a), vec3(2.0, 7.0, -9.0)) && allOk;
	allOk = compare_bool((blockB.e[0]), true) && allOk;
	allOk = compare_bool((blockB.e[1]), true) && allOk;
	allOk = compare_bool((blockB.e[2]), false) && allOk;
	allOk = compare_bool((blockB.e[3]), true) && allOk;
	allOk = compare_bool((blockB.e[4]), true) && allOk;
	allOk = compare_bool((blockB.e[5]), false) && allOk;
	allOk = compare_i8vec4(ivec4(blockC[0].f), ivec4(1, 2, 4294967289, 5)) && allOk;
	allOk = compare_int((blockC[0].i[0]), 8) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (mat4x2(-3.0, 5.0, -8.0, -2.0, 4.0, 1.0, -2.0, -8.0));
	blockB.e[0] = (true);
	blockB.e[1] = (true);
	blockB.e[2] = (false);
	blockB.e[3] = (true);
	blockB.e[4] = (false);
	blockB.e[5] = (false);
	blockC[0].f = i8vec4(ivec4(0, 4294967288, 6, 4294967288));
	blockC[0].g = (mat4x3(-7.0, -2.0, 5.0, 1.0, 3.0, -3.0, -1.0, 1.0, -6.0, -5.0, -4.0, -2.0));
	blockC[0].h = (mat2x3(8.0, -7.0, 4.0, 0.0, 7.0, 2.0));
	blockC[0].i[0] = (-4);
}
#version 450
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
	mediump mat4x2 a[];
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp vec4 b;
	int8_t c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockC.b), vec4(3.0, 2.0, 9.0, 1.0)) && allOk;
	allOk = compare_int8_t(int(blockC.c), 3) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (mat4x2(1.0, -6.0, -2.0, 5.0, 1.0, -6.0, -5.0, -1.0));
	blockB[0].a[1] = (mat4x2(4.0, -7.0, -3.0, -5.0, 7.0, -3.0, -4.0, 3.0));
	blockB[0].a[2] = (mat4x2(-5.0, -1.0, -5.0, -6.0, 6.0, 5.0, -1.0, 2.0));
	blockB[1].a[0] = (mat4x2(8.0, 8.0, -2.0, -7.0, -6.0, 5.0, -2.0, -2.0));
	blockB[1].a[1] = (mat4x2(6.0, 8.0, -3.0, 7.0, 9.0, -9.0, -8.0, -5.0));
	blockB[2].a[0] = (mat4x2(3.0, -8.0, -7.0, -1.0, -1.0, -1.0, 9.0, 1.0));
	blockB[2].a[1] = (mat4x2(1.0, -3.0, -5.0, 0.0, -3.0, -2.0, 8.0, 3.0));
	blockB[2].a[2] = (mat4x2(7.0, -4.0, -2.0, -4.0, -8.0, 5.0, -6.0, 8.0));
	blockC.b = (vec4(6.0, 4.0, 6.0, -4.0));
	blockC.c = int8_t(4294967290);
}
#version 450
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
	layout(offset = 0) u8vec3 a;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) lowp vec2 b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
    BlockC blockC[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockC[0].b), vec2(9.0, 1.0)) && allOk;
	allOk = compare_vec2((blockC[1].b), vec2(-5.0, -2.0)) && allOk;
	allOk = compare_vec2((blockC[2].b), vec2(0.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = u8vec3(uvec3(4u, 4u, 9u));
	blockB[1].a = u8vec3(uvec3(1u, 5u, 2u));
	blockB[2].a = u8vec3(uvec3(9u, 4u, 7u));
	blockC[0].b = (vec2(5.0, -8.0));
	blockC[1].b = (vec2(-2.0, 4.0));
	blockC[2].b = (vec2(1.0, -2.0));
}
#version 450
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
};
layout(scalar, buffer_reference) buffer BlockB
{
	bvec4 a[8];
	u8vec3 b;
	highp mat3x2 c;
	int8_t d[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	lowp ivec3 e;
	sA f;
	mediump uvec3 g;
	bvec2 h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a[0]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((blockB.a[1]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((blockB.a[2]), bvec4(false, false, false, false)) && allOk;
	allOk = compare_bvec4((blockB.a[3]), bvec4(false, false, false, false)) && allOk;
	allOk = compare_bvec4((blockB.a[4]), bvec4(false, false, false, true)) && allOk;
	allOk = compare_bvec4((blockB.a[5]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((blockB.a[6]), bvec4(false, false, false, true)) && allOk;
	allOk = compare_bvec4((blockB.a[7]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_ivec3((blockC.e), ivec3(-5, 9, 1)) && allOk;
	allOk = compare_mat2x3(blockC.f.mA, mat2x3(5.0, -7.0, 6.0, -1.0, -9.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (mat3x2(3.0, -7.0, 0.0, -2.0, -2.0, 7.0));
	blockC.e = (ivec3(-1, 7, -1));
	blockC.f.mA = (mat2x3(-8.0, 0.0, -8.0, 4.0, -3.0, -4.0));
	blockC.g = (uvec3(9u, 5u, 7u));
}
#version 450
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
	lowp mat4x2 mB;
	i8vec3 mC;
	bool mD;
};
layout(scalar, column_major, buffer_reference) buffer BlockB
{
	highp mat4 a;
	highp int b;
	sA c;
	bvec2 d;
	bool e[];
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	highp mat2 f;
	bvec4 g;
	highp uvec3 h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.a, mat4(2.0, 5.0, 9.0, -9.0, -9.0, -4.0, 4.0, 5.0, 3.0, 7.0, 5.0, 1.0, -2.0, 6.0, 3.0, -6.0)) && allOk;
	allOk = compare_uvec2((blockB.c.mA), uvec2(7u, 4u)) && allOk;
	allOk = compare_mat4x2(blockB.c.mB, mat4x2(8.0, 8.0, -6.0, 2.0, -6.0, -8.0, 9.0, -9.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.c.mC), ivec3(8, 4294967290, 4294967291)) && allOk;
	allOk = compare_bool((blockB.c.mD), false) && allOk;
	allOk = compare_bvec2((blockB.d), bvec2(false, true)) && allOk;
	allOk = compare_bool((blockB.e[0]), true) && allOk;
	allOk = compare_bool((blockB.e[1]), true) && allOk;
	allOk = compare_bvec4((blockC.g), bvec4(true, true, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (-1);
	blockB.c.mA = (uvec2(7u, 5u));
	blockB.c.mB = (mat4x2(3.0, -2.0, 9.0, -6.0, 3.0, 5.0, 5.0, 9.0));
	blockB.c.mC = i8vec3(ivec3(3, 4294967287, 4294967295));
	blockB.c.mD = (true);
	blockB.d = (bvec2(false, true));
	blockC.f = (mat2(8.0, 2.0, -4.0, 6.0));
}
#version 450
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
	layout(offset = 0) uint8_t a;
	layout(offset = 1) u8vec4 b;
	layout(offset = 16) highp vec3 c[1];
	layout(offset = 32) mediump mat3 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(blockB[nonuniformEXT(0)].a), 3u) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[nonuniformEXT(0)].b), uvec4(1u, 0u, 6u, 8u)) && allOk;
	allOk = compare_mat3(blockB[nonuniformEXT(0)].d, mat3(-1.0, 6.0, 0.0, -9.0, 1.0, 8.0, 1.0, -2.0, -8.0)) && allOk;
	allOk = compare_uint8_t(uint(blockB[nonuniformEXT(1)].a), 9u) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[nonuniformEXT(1)].b), uvec4(8u, 6u, 8u, 1u)) && allOk;
	allOk = compare_mat3(blockB[nonuniformEXT(1)].d, mat3(5.0, -2.0, -8.0, -1.0, -6.0, 5.0, 3.0, 3.0, -9.0)) && allOk;
	allOk = compare_uint8_t(uint(blockB[nonuniformEXT(2)].a), 3u) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[nonuniformEXT(2)].b), uvec4(8u, 8u, 4u, 3u)) && allOk;
	allOk = compare_mat3(blockB[nonuniformEXT(2)].d, mat3(-5.0, -9.0, -7.0, 6.0, -3.0, 6.0, 4.0, 1.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = u8vec4(uvec4(4u, 3u, 2u, 1u));
	blockB[nonuniformEXT(1)].b = u8vec4(uvec4(6u, 4u, 8u, 5u));
	blockB[nonuniformEXT(2)].b = u8vec4(uvec4(4u, 6u, 9u, 5u));
}
