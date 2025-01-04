#version 450
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
	highp uvec3 var;
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((var), uvec3(5u, 4u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (uvec3(5u, 3u, 8u));
}
#version 450
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
	mediump mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 2.0) && allOk;
	allOk = compare_float(var[0][1], 2.0) && allOk;
	allOk = compare_float(var[1][0], 9.0) && allOk;
	allOk = compare_float(var[1][1], 8.0) && allOk;
	allOk = compare_vec2(var[0], vec2(2.0, 2.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2(2.0, -5.0, 3.0, 0.0));
}
#version 450
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
	highp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var, mat3(-9.0, 3.0, -5.0, 1.0, 4.0, 5.0, -2.0, 1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3(-9.0, 5.0, 1.0, 3.0, 2.0, -5.0, 9.0, -3.0, -7.0));
}
#version 450
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
	highp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var, mat2x3(0.0, 2.0, -5.0, -4.0, 3.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(-6.0, -2.0, 5.0));
	var[1] = (vec3(0.0, 0.0, 6.0));
}
#version 450
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
	allOk = compare_mat2x4(var, mat2x4(-1.0, -9.0, 2.0, -8.0, 9.0, -1.0, 7.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(1.0, 8.0, 5.0, -5.0));
	var[1] = (vec4(9.0, 8.0, -8.0, -2.0));
}
#version 450
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
	mediump mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -7.0) && allOk;
	allOk = compare_float(var[0][1], -4.0) && allOk;
	allOk = compare_float(var[0][2], 2.0) && allOk;
	allOk = compare_float(var[0][3], 2.0) && allOk;
	allOk = compare_float(var[1][0], 3.0) && allOk;
	allOk = compare_float(var[1][1], -9.0) && allOk;
	allOk = compare_float(var[1][2], -5.0) && allOk;
	allOk = compare_float(var[1][3], -1.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-7.0, -4.0, 2.0, 2.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(3.0, -9.0, -5.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2x4(0.0, 9.0, 8.0, 6.0, 6.0, 7.0, -3.0, 2.0));
}
#version 450
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

layout(std140, row_major, binding = 1) buffer Block
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

	var[0] = (vec4(-5.0, 3.0, -1.0, -4.0));
	var[1] = (vec4(4.0, 5.0, 9.0, -8.0));
	var[2] = (vec4(-7.0, -1.0, -4.0, 6.0));
}
#version 450
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
	lowp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var, mat4x2(6.0, 9.0, 9.0, 6.0, 5.0, -7.0, -2.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x2(-3.0, 9.0, -1.0, 2.0, 4.0, 5.0, -6.0, 6.0));
}
#version 450
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
	lowp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 2.0) && allOk;
	allOk = compare_float(var[0][1], 9.0) && allOk;
	allOk = compare_float(var[1][0], 8.0) && allOk;
	allOk = compare_float(var[1][1], -2.0) && allOk;
	allOk = compare_float(var[2][0], 6.0) && allOk;
	allOk = compare_float(var[2][1], -2.0) && allOk;
	allOk = compare_float(var[3][0], -8.0) && allOk;
	allOk = compare_float(var[3][1], 1.0) && allOk;
	allOk = compare_vec2(var[0], vec2(2.0, 9.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(8.0, -2.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(6.0, -2.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(-8.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x2(-7.0, 1.0, 7.0, -9.0, 8.0, -3.0, -3.0, 4.0));
}
#version 450
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
	allOk = compare_float(var[0][0], 4.0) && allOk;
	allOk = compare_float(var[0][1], 6.0) && allOk;
	allOk = compare_float(var[0][2], -4.0) && allOk;
	allOk = compare_float(var[1][0], -1.0) && allOk;
	allOk = compare_float(var[1][1], -5.0) && allOk;
	allOk = compare_float(var[1][2], -2.0) && allOk;
	allOk = compare_float(var[2][0], 4.0) && allOk;
	allOk = compare_float(var[2][1], -2.0) && allOk;
	allOk = compare_float(var[2][2], -6.0) && allOk;
	allOk = compare_float(var[3][0], -4.0) && allOk;
	allOk = compare_float(var[3][1], -1.0) && allOk;
	allOk = compare_float(var[3][2], 1.0) && allOk;
	allOk = compare_vec3(var[0], vec3(4.0, 6.0, -4.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-1.0, -5.0, -2.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(4.0, -2.0, -6.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(-4.0, -1.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x3(1.0, 0.0, 4.0, -1.0, -5.0, 5.0, -9.0, -3.0, 5.0, 8.0, 4.0, 6.0));
}
#version 450
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
	lowp ivec4 var;
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((var), ivec4(-7, 7, 7, -6)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (ivec4(-2, 0, -7, -6));
}
#version 450
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
	highp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var, mat3(8.0, -7.0, 5.0, 2.0, 1.0, 1.0, -5.0, 3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3(5.0, 1.0, 8.0, -8.0, -6.0, -2.0, 1.0, 6.0, 1.0));
}
#version 450
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
	highp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 7.0) && allOk;
	allOk = compare_float(var[0][1], 7.0) && allOk;
	allOk = compare_float(var[0][2], 3.0) && allOk;
	allOk = compare_float(var[1][0], 1.0) && allOk;
	allOk = compare_float(var[1][1], 3.0) && allOk;
	allOk = compare_float(var[1][2], -6.0) && allOk;
	allOk = compare_float(var[2][0], -7.0) && allOk;
	allOk = compare_float(var[2][1], -9.0) && allOk;
	allOk = compare_float(var[2][2], 2.0) && allOk;
	allOk = compare_vec3(var[0], vec3(7.0, 7.0, 3.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(1.0, 3.0, -6.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-7.0, -9.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(6.0, -1.0, 9.0));
	var[1] = (vec3(-9.0, -2.0, -3.0));
	var[2] = (vec3(6.0, 6.0, -4.0));
}
#version 450
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
	mediump mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_float(var[0][0], 7.0) && allOk;
	allOk = compare_float(var[0][1], 3.0) && allOk;
	allOk = compare_float(var[1][0], -8.0) && allOk;
	allOk = compare_float(var[1][1], 6.0) && allOk;
	allOk = compare_vec2(var[0], vec2(7.0, 3.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-8.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (1.0);
	var[0] = (vec2(2.0, -8.0));
	var[1] = (vec2(-5.0, 2.0));
}
#version 450
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
	highp mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_mat2(var, mat2(4.0, 9.0, 8.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (5.0);
	var[0] = (vec2(-5.0, -3.0));
	var[1] = (vec2(5.0, 0.0));
}
#version 450
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
	mediump mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 9.0) && allOk;
	allOk = compare_float(var[0][0], 6.0) && allOk;
	allOk = compare_float(var[0][1], 0.0) && allOk;
	allOk = compare_float(var[0][2], -7.0) && allOk;
	allOk = compare_float(var[0][3], -4.0) && allOk;
	allOk = compare_float(var[1][0], -9.0) && allOk;
	allOk = compare_float(var[1][1], -9.0) && allOk;
	allOk = compare_float(var[1][2], -8.0) && allOk;
	allOk = compare_float(var[1][3], 6.0) && allOk;
	allOk = compare_float(var[2][0], 7.0) && allOk;
	allOk = compare_float(var[2][1], 0.0) && allOk;
	allOk = compare_float(var[2][2], 3.0) && allOk;
	allOk = compare_float(var[2][3], 1.0) && allOk;
	allOk = compare_float(var[3][0], 7.0) && allOk;
	allOk = compare_float(var[3][1], 8.0) && allOk;
	allOk = compare_float(var[3][2], -7.0) && allOk;
	allOk = compare_float(var[3][3], 4.0) && allOk;
	allOk = compare_vec4(var[0], vec4(6.0, 0.0, -7.0, -4.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-9.0, -9.0, -8.0, 6.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(7.0, 0.0, 3.0, 1.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(7.0, 8.0, -7.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (9.0);
	var = (mat4(1.0, 8.0, -8.0, -6.0, 2.0, -9.0, 7.0, -2.0, 8.0, 7.0, 2.0, -8.0, 1.0, -6.0, 1.0, -9.0));
}
#version 450
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
	lowp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_mat4x2(var, mat4x2(-6.0, 5.0, -1.0, -8.0, 2.0, -8.0, 9.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-9.0);
	var[0] = (vec2(-6.0, 6.0));
	var[1] = (vec2(8.0, -4.0));
	var[2] = (vec2(3.0, 6.0));
	var[3] = (vec2(7.0, -8.0));
}
#version 450
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
	highp mat2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0], mat2(-6.0, 3.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(3.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(9.0, -5.0, -3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec2(-2.0, 1.0));
	var[0][1] = (vec2(-7.0, -1.0));
	var[1][0] = (vec2(5.0, -3.0));
	var[1][1] = (vec2(4.0, 8.0));
	var[2][0] = (vec2(-2.0, -6.0));
	var[2][1] = (vec2(-5.0, -1.0));
}
#version 450
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
	highp mat3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0], mat3(-2.0, 7.0, 9.0, 1.0, -5.0, -1.0, 3.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(-8.0, -8.0, 2.0, 7.0, -6.0, -4.0, 7.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(-2.0, 2.0, -3.0, -3.0, 1.0, -3.0, -8.0, 8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3(-2.0, -7.0, 1.0, 7.0, 5.0, 2.0, 9.0, -1.0, -9.0));
	var[1] = (mat3(6.0, -5.0, 8.0, -1.0, -8.0, -8.0, 0.0, 9.0, 1.0));
	var[2] = (mat3(1.0, -4.0, 5.0, -6.0, -1.0, 9.0, -6.0, 0.0, 5.0));
}
#version 450
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
	highp uvec3 var[3];
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((padding), 9u) && allOk;
	allOk = compare_uvec3((var[0]), uvec3(6u, 4u, 7u)) && allOk;
	allOk = compare_uvec3((var[1]), uvec3(2u, 7u, 5u)) && allOk;
	allOk = compare_uvec3((var[2]), uvec3(0u, 2u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (3u);
	var[0] = (uvec3(5u, 6u, 5u));
	var[1] = (uvec3(4u, 5u, 4u));
	var[2] = (uvec3(9u, 4u, 4u));
}
#version 450
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
	highp mat2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat2(var[0], mat2(-4.0, -1.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(-6.0, -6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(-5.0, -8.0, -3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (3.0);
	var[0] = (mat2(2.0, -8.0, -6.0, 2.0));
	var[1] = (mat2(-3.0, 9.0, -5.0, 4.0));
	var[2] = (mat2(-2.0, -6.0, -9.0, -2.0));
}
#version 450
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
	highp mat4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 0.0) && allOk;
	allOk = compare_mat4(var[0], mat4(-2.0, -7.0, -4.0, -6.0, 1.0, -5.0, 2.0, -7.0, 8.0, 2.0, -9.0, 3.0, 6.0, -9.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(-1.0, -6.0, 8.0, -2.0, -2.0, 6.0, -7.0, 7.0, 9.0, -7.0, 5.0, 5.0, 8.0, 1.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(-5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 6.0, 1.0, -8.0, -3.0, 6.0, -5.0, -4.0, -7.0, -3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-6.0);
	var[0] = (mat4(5.0, -1.0, 2.0, -9.0, 1.0, -5.0, -2.0, -8.0, 8.0, 8.0, 1.0, -8.0, 6.0, -9.0, 9.0, -6.0));
	var[1] = (mat4(-2.0, 6.0, -2.0, -6.0, 9.0, 1.0, 3.0, -1.0, -2.0, 1.0, 7.0, 0.0, 3.0, -2.0, 2.0, -7.0));
	var[2] = (mat4(-4.0, 7.0, 8.0, -3.0, 3.0, -4.0, 7.0, -3.0, -2.0, 9.0, -2.0, 6.0, -7.0, 8.0, 1.0, 6.0));
}
#version 450
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
	highp mat2x3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat2x3(var[0], mat2x3(-3.0, -7.0, 1.0, -1.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(7.0, -9.0, 1.0, 0.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(-9.0, 1.0, -7.0, -5.0, -4.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (2.0);
	var[0] = (mat2x3(-7.0, 9.0, -3.0, 0.0, 7.0, 1.0));
	var[1] = (mat2x3(-4.0, 1.0, 9.0, 6.0, -4.0, -1.0));
	var[2] = (mat2x3(-8.0, 4.0, 7.0, 8.0, 0.0, 9.0));
}
#version 450
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
	highp mat3x4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 9.0) && allOk;
	allOk = compare_mat3x4(var[0], mat3x4(-4.0, -6.0, 2.0, -9.0, -8.0, 7.0, 0.0, 5.0, 3.0, 9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(-7.0, 0.0, 6.0, -3.0, 8.0, 6.0, -6.0, -6.0, -4.0, 6.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(5.0, -6.0, 7.0, -4.0, -9.0, -9.0, -4.0, -8.0, -8.0, 3.0, -1.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (3.0);
	var[0] = (mat3x4(-9.0, -6.0, 7.0, 6.0, -8.0, -1.0, 1.0, -9.0, 7.0, 6.0, 6.0, -5.0));
	var[1] = (mat3x4(-1.0, -8.0, 3.0, 9.0, 9.0, -8.0, 0.0, 0.0, -9.0, -6.0, -7.0, -3.0));
	var[2] = (mat3x4(-3.0, 9.0, -7.0, 4.0, 2.0, -8.0, 4.0, -6.0, -1.0, -9.0, 5.0, -5.0));
}
#version 450
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
	uint16_t padding;
	u16vec4 var[3];
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(padding), 6u) && allOk;
	allOk = compare_u16vec4(uvec4(var[0]), uvec4(0u, 8u, 3u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1]), uvec4(7u, 5u, 4u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2]), uvec4(7u, 1u, 8u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = uint16_t(0u);
	var[0] = u16vec4(uvec4(6u, 9u, 4u, 5u));
	var[1] = u16vec4(uvec4(0u, 1u, 0u, 7u));
	var[2] = u16vec4(uvec4(6u, 5u, 9u, 8u));
}
#version 450
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

	var[0] = (mat4(4.0, 7.0, -2.0, -5.0, 3.0, -6.0, 0.0, -4.0, 2.0, -9.0, -1.0, 6.0, 8.0, 9.0, 5.0, -6.0));
	var[1] = (mat4(1.0, 3.0, -7.0, -5.0, 5.0, -5.0, -2.0, -4.0, 9.0, 5.0, 2.0, -3.0, -8.0, 2.0, 1.0, 5.0));
	var[2] = (mat4(5.0, 2.0, -1.0, -1.0, 5.0, -5.0, 0.0, 3.0, -6.0, -5.0, -1.0, 3.0, -6.0, -5.0, -7.0, -8.0));
	var[3] = (mat4(-1.0, 9.0, 8.0, 0.0, -5.0, 0.0, -3.0, -7.0, 8.0, -9.0, -9.0, 0.0, 9.0, -8.0, -8.0, -5.0));
	var[4] = (mat4(5.0, 6.0, -1.0, 7.0, -2.0, 2.0, -7.0, 1.0, 8.0, 0.0, 7.0, 1.0, 2.0, 7.0, 5.0, 0.0));
	var[5] = (mat4(7.0, -1.0, 8.0, 4.0, -9.0, -9.0, -4.0, 6.0, 9.0, -3.0, 3.0, -9.0, 5.0, -1.0, -2.0, -9.0));
	var[6] = (mat4(4.0, -8.0, -4.0, -7.0, -9.0, 6.0, 9.0, 1.0, 2.0, -8.0, 2.0, 5.0, -6.0, -1.0, -7.0, 3.0));
	var[7] = (mat4(-9.0, -2.0, 3.0, -9.0, -1.0, -2.0, 6.0, 4.0, 7.0, -4.0, 1.0, -8.0, 4.0, 9.0, -7.0, -6.0));
	var[8] = (mat4(5.0, -2.0, 0.0, 3.0, 4.0, -3.0, 8.0, -1.0, -3.0, 2.0, 7.0, -7.0, 1.0, -2.0, 8.0, -1.0));
	var[9] = (mat4(-2.0, -6.0, -4.0, 5.0, 6.0, -2.0, 8.0, 8.0, 5.0, -6.0, -4.0, -6.0, -1.0, -3.0, -6.0, 0.0));
	var[10] = (mat4(-9.0, -3.0, -7.0, 7.0, 2.0, -7.0, -7.0, 0.0, -5.0, -9.0, 6.0, -3.0, -5.0, -4.0, -4.0, -5.0));
	var[11] = (mat4(6.0, 9.0, 3.0, -8.0, -3.0, 0.0, -9.0, 2.0, 6.0, 0.0, -4.0, 1.0, 0.0, 2.0, 2.0, 5.0));
	var[12] = (mat4(5.0, 4.0, 4.0, 1.0, 7.0, -5.0, 1.0, 7.0, 8.0, 8.0, 5.0, 4.0, 9.0, -4.0, 9.0, 7.0));
	var[13] = (mat4(8.0, 7.0, -8.0, 1.0, -7.0, 7.0, 0.0, -2.0, 1.0, -8.0, -2.0, 8.0, -8.0, 9.0, -6.0, -1.0));
	var[14] = (mat4(-3.0, -5.0, -4.0, -7.0, -9.0, -6.0, -8.0, 6.0, -1.0, 8.0, 0.0, -8.0, -4.0, 4.0, 8.0, -5.0));
	var[15] = (mat4(-4.0, -9.0, 6.0, 9.0, -4.0, -2.0, -8.0, -8.0, 4.0, 7.0, 3.0, 6.0, -4.0, -3.0, -4.0, 6.0));
	var[16] = (mat4(7.0, 4.0, 4.0, 3.0, -8.0, -4.0, -4.0, 7.0, -3.0, -4.0, 4.0, -6.0, 2.0, 8.0, 4.0, -7.0));
	var[17] = (mat4(1.0, 1.0, 6.0, 3.0, 8.0, 2.0, -7.0, 7.0, 9.0, -8.0, 9.0, 0.0, 8.0, 4.0, 8.0, 2.0));
	var[18] = (mat4(4.0, 2.0, -9.0, 1.0, 5.0, -7.0, -4.0, -2.0, -7.0, -5.0, 1.0, -6.0, -8.0, 6.0, -2.0, 4.0));
}
#version 450
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
	highp mat3x2 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0], mat3x2(-9.0, 2.0, -4.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(3.0, 1.0, -9.0, -1.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(-2.0, -8.0, -5.0, 3.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[3], mat3x2(-7.0, 6.0, -9.0, 5.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[4], mat3x2(8.0, -3.0, -5.0, -8.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[5], mat3x2(-1.0, 3.0, 2.0, -6.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[6], mat3x2(8.0, -3.0, 9.0, 8.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[7], mat3x2(2.0, 4.0, 5.0, -2.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[8], mat3x2(0.0, 1.0, 8.0, 6.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[9], mat3x2(-4.0, 8.0, 6.0, -9.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[10], mat3x2(-5.0, -5.0, 2.0, 5.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[11], mat3x2(-7.0, -1.0, -4.0, 8.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[12], mat3x2(-2.0, -1.0, 1.0, 0.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x2(var[13], mat3x2(-1.0, -3.0, 9.0, 9.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[14], mat3x2(6.0, -9.0, 0.0, -7.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[15], mat3x2(-9.0, 7.0, 0.0, -9.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[16], mat3x2(-7.0, -4.0, -4.0, 2.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[17], mat3x2(-7.0, -7.0, -2.0, -7.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[18], mat3x2(1.0, -7.0, 3.0, -9.0, 5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3x2(-4.0, 6.0, -6.0, 1.0, -8.0, 7.0));
	var[1] = (mat3x2(-1.0, 0.0, -6.0, 7.0, -4.0, -7.0));
	var[2] = (mat3x2(-7.0, -5.0, -2.0, -6.0, -6.0, -4.0));
	var[3] = (mat3x2(-4.0, -9.0, 4.0, 7.0, 9.0, 7.0));
	var[4] = (mat3x2(9.0, -1.0, -5.0, 6.0, -2.0, 6.0));
	var[5] = (mat3x2(-6.0, -8.0, 1.0, 5.0, 7.0, 1.0));
	var[6] = (mat3x2(0.0, 0.0, 2.0, -7.0, 5.0, 1.0));
	var[7] = (mat3x2(6.0, 0.0, -1.0, -4.0, -5.0, -3.0));
	var[8] = (mat3x2(-8.0, 4.0, -1.0, 9.0, -1.0, 7.0));
	var[9] = (mat3x2(-8.0, -3.0, 6.0, 0.0, 4.0, 4.0));
	var[10] = (mat3x2(-8.0, 8.0, -9.0, -4.0, 5.0, 5.0));
	var[11] = (mat3x2(4.0, 7.0, -3.0, 2.0, 8.0, 5.0));
	var[12] = (mat3x2(9.0, 9.0, -7.0, 5.0, 9.0, -1.0));
	var[13] = (mat3x2(1.0, 7.0, 8.0, 8.0, -1.0, 5.0));
	var[14] = (mat3x2(-7.0, -7.0, 7.0, -7.0, -4.0, 0.0));
	var[15] = (mat3x2(-4.0, -8.0, -1.0, 6.0, -9.0, 7.0));
	var[16] = (mat3x2(-9.0, 2.0, 5.0, -2.0, 2.0, -7.0));
	var[17] = (mat3x2(-7.0, 2.0, 5.0, 0.0, 1.0, -6.0));
	var[18] = (mat3x2(1.0, -2.0, -7.0, 8.0, -1.0, 1.0));
}
#version 450
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

layout(std430, binding = 1) buffer Block
{
	highp mat4x3 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0], mat4x3(0.0, 1.0, -8.0, -1.0, 2.0, 8.0, 7.0, -7.0, 9.0, -3.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(4.0, 2.0, 4.0, -2.0, -9.0, -6.0, 8.0, 9.0, 2.0, -2.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(-7.0, 9.0, 2.0, -3.0, 3.0, 6.0, 6.0, 3.0, -3.0, -9.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[3], mat4x3(-5.0, 4.0, -6.0, 7.0, -5.0, 8.0, -1.0, 8.0, 1.0, 9.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[4], mat4x3(4.0, -6.0, 8.0, -9.0, -1.0, -2.0, 1.0, 7.0, 9.0, -5.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[5], mat4x3(2.0, 4.0, -7.0, 8.0, -1.0, -7.0, -3.0, 2.0, -7.0, 0.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[6], mat4x3(4.0, 4.0, -8.0, 9.0, 2.0, 4.0, 5.0, -1.0, -4.0, -5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[7], mat4x3(9.0, -3.0, 4.0, -4.0, -8.0, 6.0, 7.0, 7.0, -6.0, -3.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[8], mat4x3(7.0, -9.0, -8.0, -4.0, -3.0, 6.0, 5.0, 4.0, 2.0, 3.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[9], mat4x3(-3.0, -8.0, -6.0, 5.0, -7.0, 2.0, -2.0, 1.0, 6.0, 5.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[10], mat4x3(6.0, 1.0, 7.0, -6.0, -8.0, 9.0, 6.0, 2.0, -4.0, 4.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[11], mat4x3(7.0, 2.0, -5.0, -3.0, -3.0, 2.0, -4.0, -8.0, -1.0, 5.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[12], mat4x3(6.0, -1.0, 2.0, 6.0, -2.0, 2.0, 1.0, 6.0, 6.0, -6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[13], mat4x3(-5.0, -9.0, 2.0, 5.0, -7.0, 6.0, 6.0, 8.0, -4.0, -3.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[14], mat4x3(2.0, -1.0, -5.0, -1.0, 3.0, -4.0, 2.0, 0.0, 7.0, -6.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[15], mat4x3(7.0, 1.0, -8.0, -6.0, 5.0, 7.0, -3.0, 7.0, -1.0, -7.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[16], mat4x3(2.0, 9.0, -3.0, 7.0, -8.0, -1.0, 1.0, -2.0, 2.0, -3.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[17], mat4x3(9.0, 6.0, 5.0, -3.0, 2.0, -5.0, -7.0, 0.0, 6.0, -1.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[18], mat4x3(6.0, -3.0, -6.0, -3.0, -5.0, -8.0, 3.0, -5.0, -9.0, 4.0, -7.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4x3(2.0, 4.0, 9.0, -7.0, 5.0, -8.0, 9.0, 1.0, 9.0, -6.0, -6.0, 1.0));
	var[1] = (mat4x3(6.0, -2.0, -2.0, 5.0, 3.0, -6.0, -8.0, -5.0, 9.0, 8.0, -2.0, -1.0));
	var[2] = (mat4x3(1.0, 7.0, 0.0, 5.0, 9.0, -6.0, 5.0, 6.0, 2.0, 3.0, -8.0, 7.0));
	var[3] = (mat4x3(3.0, 1.0, -4.0, 0.0, -7.0, 0.0, 1.0, 6.0, -5.0, -5.0, -2.0, 5.0));
	var[4] = (mat4x3(0.0, 7.0, 3.0, -7.0, -6.0, -5.0, -6.0, 2.0, -9.0, -1.0, 1.0, 6.0));
	var[5] = (mat4x3(0.0, 8.0, -4.0, -6.0, -7.0, -1.0, 3.0, -1.0, -6.0, 2.0, 2.0, -2.0));
	var[6] = (mat4x3(-3.0, 7.0, -5.0, -3.0, 0.0, -1.0, 8.0, -1.0, 8.0, -9.0, -7.0, 7.0));
	var[7] = (mat4x3(8.0, 2.0, 0.0, -8.0, -5.0, -8.0, -4.0, 9.0, -6.0, 6.0, -9.0, 9.0));
	var[8] = (mat4x3(-4.0, -2.0, -1.0, -9.0, 0.0, -2.0, 2.0, -1.0, 9.0, 6.0, 5.0, -6.0));
	var[9] = (mat4x3(9.0, -4.0, 0.0, 0.0, -6.0, -4.0, 1.0, -9.0, -9.0, -6.0, 2.0, 1.0));
	var[10] = (mat4x3(-9.0, 6.0, -7.0, 6.0, 5.0, 4.0, -7.0, -3.0, 6.0, 5.0, 8.0, -2.0));
	var[11] = (mat4x3(3.0, 0.0, 7.0, -9.0, -2.0, 7.0, -3.0, 4.0, -5.0, -5.0, -2.0, -3.0));
	var[12] = (mat4x3(-2.0, 7.0, -6.0, -4.0, -2.0, 0.0, 4.0, -2.0, 6.0, -6.0, -5.0, -8.0));
	var[13] = (mat4x3(-1.0, 2.0, 4.0, 2.0, -2.0, 9.0, 0.0, -4.0, 6.0, -7.0, -4.0, 2.0));
	var[14] = (mat4x3(1.0, 2.0, -9.0, -3.0, 6.0, -9.0, 8.0, 2.0, 1.0, -8.0, 3.0, 2.0));
	var[15] = (mat4x3(1.0, 4.0, 9.0, -7.0, -5.0, 2.0, -8.0, 0.0, 0.0, -4.0, 9.0, 5.0));
	var[16] = (mat4x3(-2.0, -9.0, 6.0, -9.0, -4.0, -7.0, 9.0, -5.0, 3.0, 5.0, -1.0, -4.0));
	var[17] = (mat4x3(1.0, -1.0, -8.0, 4.0, 4.0, 4.0, -3.0, 4.0, 0.0, 0.0, -7.0, -1.0));
	var[18] = (mat4x3(2.0, 6.0, 9.0, -5.0, -9.0, -9.0, 5.0, 6.0, 4.0, 6.0, -3.0, 1.0));
}
#version 450
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
	u16vec3 var[];
};

bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(var[0]), uvec3(1u, 0u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1]), uvec3(9u, 0u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2]), uvec3(7u, 1u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[3]), uvec3(0u, 4u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[4]), uvec3(9u, 7u, 2u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[5]), uvec3(1u, 0u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[6]), uvec3(6u, 8u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[7]), uvec3(5u, 6u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[8]), uvec3(3u, 3u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[9]), uvec3(1u, 0u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[10]), uvec3(1u, 3u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[11]), uvec3(3u, 6u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[12]), uvec3(9u, 4u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[13]), uvec3(9u, 1u, 4u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[14]), uvec3(8u, 5u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[15]), uvec3(3u, 1u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[16]), uvec3(8u, 0u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[17]), uvec3(2u, 3u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[18]), uvec3(6u, 1u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = u16vec3(uvec3(1u, 2u, 6u));
	var[1] = u16vec3(uvec3(8u, 3u, 3u));
	var[2] = u16vec3(uvec3(4u, 4u, 9u));
	var[3] = u16vec3(uvec3(7u, 5u, 4u));
	var[4] = u16vec3(uvec3(5u, 6u, 5u));
	var[5] = u16vec3(uvec3(7u, 0u, 6u));
	var[6] = u16vec3(uvec3(4u, 7u, 0u));
	var[7] = u16vec3(uvec3(4u, 2u, 1u));
	var[8] = u16vec3(uvec3(0u, 2u, 8u));
	var[9] = u16vec3(uvec3(0u, 7u, 0u));
	var[10] = u16vec3(uvec3(2u, 8u, 7u));
	var[11] = u16vec3(uvec3(1u, 2u, 8u));
	var[12] = u16vec3(uvec3(1u, 3u, 3u));
	var[13] = u16vec3(uvec3(0u, 2u, 2u));
	var[14] = u16vec3(uvec3(7u, 9u, 1u));
	var[15] = u16vec3(uvec3(2u, 8u, 7u));
	var[16] = u16vec3(uvec3(9u, 6u, 3u));
	var[17] = u16vec3(uvec3(2u, 0u, 6u));
	var[18] = u16vec3(uvec3(6u, 1u, 7u));
}
#version 450
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
	highp mat2x3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0][0], mat2x3(5.0, 8.0, 4.0, -6.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[0][1], mat2x3(0.0, 0.0, 4.0, 3.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[0][2], mat2x3(-7.0, 2.0, -1.0, 5.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[1][0], mat2x3(-2.0, -1.0, 3.0, 4.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[1][1], mat2x3(5.0, 8.0, 1.0, -7.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[1][2], mat2x3(0.0, 9.0, -1.0, -8.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[2][0], mat2x3(-6.0, 9.0, 9.0, -2.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[2][1], mat2x3(8.0, -6.0, -2.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[2][2], mat2x3(-2.0, -9.0, -1.0, -8.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[3][0], mat2x3(-5.0, -9.0, -3.0, -8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[3][1], mat2x3(-9.0, -1.0, -9.0, -9.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[3][2], mat2x3(-6.0, -1.0, 7.0, -5.0, 9.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat2x3(-9.0, -3.0, 4.0, -1.0, 8.0, -5.0));
	var[0][1] = (mat2x3(-4.0, -8.0, -3.0, 1.0, -5.0, 6.0));
	var[0][2] = (mat2x3(0.0, 4.0, 6.0, 2.0, -1.0, -7.0));
	var[1][0] = (mat2x3(6.0, 9.0, 2.0, -3.0, 0.0, 5.0));
	var[1][1] = (mat2x3(-9.0, 6.0, -3.0, 9.0, -7.0, 2.0));
	var[1][2] = (mat2x3(8.0, -3.0, 7.0, -9.0, 7.0, -1.0));
	var[2][0] = (mat2x3(-4.0, -3.0, -6.0, -1.0, -5.0, 7.0));
	var[2][1] = (mat2x3(1.0, 9.0, -7.0, 3.0, 3.0, 1.0));
	var[2][2] = (mat2x3(-4.0, -9.0, 4.0, -1.0, -4.0, 1.0));
	var[3][0] = (mat2x3(-7.0, 0.0, -4.0, -6.0, -1.0, -1.0));
	var[3][1] = (mat2x3(5.0, -5.0, 0.0, -6.0, -9.0, -6.0));
	var[3][2] = (mat2x3(-2.0, -1.0, -6.0, -6.0, 3.0, -3.0));
}
#version 450
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
	highp mat2x4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0][0], mat2x4(-8.0, -3.0, 6.0, -5.0, 2.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[0][1], mat2x4(-2.0, 8.0, 0.0, 5.0, -6.0, 9.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[0][2], mat2x4(1.0, -1.0, -5.0, 4.0, -7.0, -3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[1][0], mat2x4(-3.0, -4.0, 0.0, 0.0, 9.0, -6.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[1][1], mat2x4(4.0, 5.0, 3.0, 4.0, 0.0, -1.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[1][2], mat2x4(1.0, 5.0, -8.0, -9.0, -5.0, -6.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[2][0], mat2x4(0.0, 8.0, -1.0, 5.0, -1.0, 4.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[2][1], mat2x4(5.0, 3.0, 2.0, 2.0, 0.0, -9.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[2][2], mat2x4(8.0, 0.0, -7.0, -9.0, -2.0, 5.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[3][0], mat2x4(9.0, -1.0, 4.0, -4.0, 9.0, 6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[3][1], mat2x4(0.0, 4.0, 7.0, 0.0, 5.0, 3.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[3][2], mat2x4(4.0, -4.0, -8.0, -7.0, 7.0, -8.0, -2.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat2x4(-2.0, 3.0, 2.0, -4.0, 2.0, -2.0, 9.0, -4.0));
	var[0][1] = (mat2x4(0.0, 7.0, 4.0, -8.0, 6.0, 0.0, -1.0, -8.0));
	var[0][2] = (mat2x4(2.0, 8.0, 2.0, 4.0, 5.0, 4.0, -3.0, 4.0));
	var[1][0] = (mat2x4(-6.0, 1.0, 7.0, -9.0, 7.0, -5.0, -1.0, -8.0));
	var[1][1] = (mat2x4(-2.0, -6.0, -6.0, 6.0, 6.0, -7.0, 6.0, 9.0));
	var[1][2] = (mat2x4(3.0, 9.0, 4.0, -6.0, 7.0, -1.0, 9.0, 5.0));
	var[2][0] = (mat2x4(-7.0, 0.0, -8.0, 2.0, -6.0, -5.0, 9.0, 2.0));
	var[2][1] = (mat2x4(2.0, 3.0, 4.0, 6.0, -7.0, -3.0, 5.0, 2.0));
	var[2][2] = (mat2x4(4.0, 2.0, 8.0, -5.0, -9.0, -1.0, 6.0, -2.0));
	var[3][0] = (mat2x4(4.0, 1.0, -1.0, -1.0, 7.0, 0.0, 6.0, 9.0));
	var[3][1] = (mat2x4(5.0, 9.0, -6.0, -6.0, -2.0, -9.0, 9.0, 3.0));
	var[3][2] = (mat2x4(2.0, 4.0, -3.0, 6.0, 6.0, 9.0, 1.0, 5.0));
}
#version 450
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
	highp mat4x3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0][0], mat4x3(0.0, 1.0, -8.0, -1.0, 2.0, 8.0, 7.0, -7.0, 9.0, -3.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[0][1], mat4x3(4.0, 2.0, 4.0, -2.0, -9.0, -6.0, 8.0, 9.0, 2.0, -2.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[0][2], mat4x3(-7.0, 9.0, 2.0, -3.0, 3.0, 6.0, 6.0, 3.0, -3.0, -9.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[1][0], mat4x3(-5.0, 4.0, -6.0, 7.0, -5.0, 8.0, -1.0, 8.0, 1.0, 9.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[1][1], mat4x3(4.0, -6.0, 8.0, -9.0, -1.0, -2.0, 1.0, 7.0, 9.0, -5.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[1][2], mat4x3(2.0, 4.0, -7.0, 8.0, -1.0, -7.0, -3.0, 2.0, -7.0, 0.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[2][0], mat4x3(4.0, 4.0, -8.0, 9.0, 2.0, 4.0, 5.0, -1.0, -4.0, -5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[2][1], mat4x3(9.0, -3.0, 4.0, -4.0, -8.0, 6.0, 7.0, 7.0, -6.0, -3.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[2][2], mat4x3(7.0, -9.0, -8.0, -4.0, -3.0, 6.0, 5.0, 4.0, 2.0, 3.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[3][0], mat4x3(-3.0, -8.0, -6.0, 5.0, -7.0, 2.0, -2.0, 1.0, 6.0, 5.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[3][1], mat4x3(6.0, 1.0, 7.0, -6.0, -8.0, 9.0, 6.0, 2.0, -4.0, 4.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[3][2], mat4x3(7.0, 2.0, -5.0, -3.0, -3.0, 2.0, -4.0, -8.0, -1.0, 5.0, -7.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat4x3(2.0, 4.0, 9.0, -7.0, 5.0, -8.0, 9.0, 1.0, 9.0, -6.0, -6.0, 1.0));
	var[0][1] = (mat4x3(6.0, -2.0, -2.0, 5.0, 3.0, -6.0, -8.0, -5.0, 9.0, 8.0, -2.0, -1.0));
	var[0][2] = (mat4x3(1.0, 7.0, 0.0, 5.0, 9.0, -6.0, 5.0, 6.0, 2.0, 3.0, -8.0, 7.0));
	var[1][0] = (mat4x3(3.0, 1.0, -4.0, 0.0, -7.0, 0.0, 1.0, 6.0, -5.0, -5.0, -2.0, 5.0));
	var[1][1] = (mat4x3(0.0, 7.0, 3.0, -7.0, -6.0, -5.0, -6.0, 2.0, -9.0, -1.0, 1.0, 6.0));
	var[1][2] = (mat4x3(0.0, 8.0, -4.0, -6.0, -7.0, -1.0, 3.0, -1.0, -6.0, 2.0, 2.0, -2.0));
	var[2][0] = (mat4x3(-3.0, 7.0, -5.0, -3.0, 0.0, -1.0, 8.0, -1.0, 8.0, -9.0, -7.0, 7.0));
	var[2][1] = (mat4x3(8.0, 2.0, 0.0, -8.0, -5.0, -8.0, -4.0, 9.0, -6.0, 6.0, -9.0, 9.0));
	var[2][2] = (mat4x3(-4.0, -2.0, -1.0, -9.0, 0.0, -2.0, 2.0, -1.0, 9.0, 6.0, 5.0, -6.0));
	var[3][0] = (mat4x3(9.0, -4.0, 0.0, 0.0, -6.0, -4.0, 1.0, -9.0, -9.0, -6.0, 2.0, 1.0));
	var[3][1] = (mat4x3(-9.0, 6.0, -7.0, 6.0, 5.0, 4.0, -7.0, -3.0, 6.0, 5.0, 8.0, -2.0));
	var[3][2] = (mat4x3(3.0, 0.0, 7.0, -9.0, -2.0, 7.0, -3.0, 4.0, -5.0, -5.0, -2.0, -3.0));
}
#version 450
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
	f16vec3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(var[0][0]), vec3(4.0, 1.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[0][1]), vec3(-8.0, 7.0, -5.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[0][2]), vec3(4.0, 2.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][0]), vec3(4.0, 4.0, 5.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][1]), vec3(2.0, 1.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][2]), vec3(8.0, 2.0, -3.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][0]), vec3(1.0, -2.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][1]), vec3(-7.0, -7.0, -7.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][2]), vec3(-8.0, -2.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[3][0]), vec3(6.0, 6.0, -1.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[3][1]), vec3(-4.0, -4.0, 6.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[3][2]), vec3(-8.0, 6.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = f16vec3(vec3(3.0, 3.0, 7.0));
	var[0][1] = f16vec3(vec3(-3.0, -5.0, -9.0));
	var[0][2] = f16vec3(vec3(-1.0, 0.0, 6.0));
	var[1][0] = f16vec3(vec3(5.0, -7.0, 2.0));
	var[1][1] = f16vec3(vec3(9.0, 1.0, -5.0));
	var[1][2] = f16vec3(vec3(-5.0, 5.0, 2.0));
	var[2][0] = f16vec3(vec3(-5.0, -4.0, 6.0));
	var[2][1] = f16vec3(vec3(-3.0, -7.0, -4.0));
	var[2][2] = f16vec3(vec3(-4.0, 5.0, 0.0));
	var[3][0] = f16vec3(vec3(-6.0, 4.0, -1.0));
	var[3][1] = f16vec3(vec3(-2.0, 3.0, -8.0));
	var[3][2] = f16vec3(vec3(-4.0, -2.0, 4.0));
}
#version 450
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
	highp mat3x4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat3x4(var[0][0], mat3x4(-7.0, 8.0, -7.0, -5.0, 5.0, -2.0, -5.0, -5.0, 8.0, -6.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[0][1], mat3x4(-1.0, -9.0, 0.0, -5.0, -1.0, -2.0, -3.0, -8.0, -3.0, -5.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[0][2], mat3x4(-1.0, -1.0, 2.0, 5.0, -7.0, -3.0, 8.0, -6.0, -8.0, 6.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[1][0], mat3x4(-9.0, 2.0, -4.0, -7.0, -3.0, 1.0, 1.0, 3.0, 5.0, -5.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[1][1], mat3x4(-1.0, -1.0, 0.0, 9.0, 3.0, 9.0, -8.0, -3.0, -2.0, 3.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat3x4(var[1][2], mat3x4(6.0, -9.0, 9.0, 4.0, 1.0, -5.0, 5.0, -6.0, -3.0, 1.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat3x4(var[2][0], mat3x4(8.0, -8.0, 2.0, 8.0, -6.0, -7.0, 7.0, -5.0, 6.0, -8.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[2][1], mat3x4(9.0, -9.0, -2.0, -8.0, 8.0, -5.0, -7.0, 9.0, 8.0, -9.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[2][2], mat3x4(7.0, 7.0, 1.0, 8.0, -2.0, 0.0, 6.0, -4.0, -3.0, -4.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[3][0], mat3x4(2.0, 1.0, -1.0, 0.0, -7.0, -6.0, 8.0, -6.0, -5.0, 7.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[3][1], mat3x4(8.0, -4.0, -6.0, -8.0, 8.0, 1.0, 6.0, -7.0, 4.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[3][2], mat3x4(0.0, 9.0, 7.0, -5.0, 1.0, -6.0, -2.0, -7.0, 1.0, 8.0, -1.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-2.0);
	var[0][0][0] = (vec4(-8.0, -4.0, 1.0, -8.0));
	var[0][0][1] = (vec4(-4.0, 3.0, 6.0, -4.0));
	var[0][0][2] = (vec4(-8.0, -5.0, 9.0, -4.0));
	var[0][1][0] = (vec4(0.0, 7.0, -9.0, 4.0));
	var[0][1][1] = (vec4(-4.0, -4.0, -8.0, 9.0));
	var[0][1][2] = (vec4(-7.0, 6.0, -4.0, 2.0));
	var[0][2][0] = (vec4(-1.0, -7.0, 7.0, 1.0));
	var[0][2][1] = (vec4(0.0, 4.0, 1.0, -9.0));
	var[0][2][2] = (vec4(-7.0, 2.0, -6.0, 3.0));
	var[1][0][0] = (vec4(4.0, -2.0, -3.0, -6.0));
	var[1][0][1] = (vec4(8.0, 9.0, -9.0, -5.0));
	var[1][0][2] = (vec4(-3.0, 5.0, 9.0, 3.0));
	var[1][1][0] = (vec4(9.0, -2.0, 4.0, -9.0));
	var[1][1][1] = (vec4(1.0, -8.0, -2.0, 1.0));
	var[1][1][2] = (vec4(4.0, -1.0, -5.0, -8.0));
	var[1][2][0] = (vec4(-5.0, -8.0, -2.0, 7.0));
	var[1][2][1] = (vec4(-3.0, -9.0, 0.0, -9.0));
	var[1][2][2] = (vec4(-2.0, 9.0, 8.0, 7.0));
	var[2][0][0] = (vec4(6.0, -9.0, -7.0, 3.0));
	var[2][0][1] = (vec4(-3.0, -6.0, -1.0, 0.0));
	var[2][0][2] = (vec4(4.0, -2.0, -4.0, 2.0));
	var[2][1][0] = (vec4(-3.0, -9.0, -1.0, 0.0));
	var[2][1][1] = (vec4(-9.0, 1.0, 6.0, 5.0));
	var[2][1][2] = (vec4(3.0, -1.0, 9.0, -8.0));
	var[2][2][0] = (vec4(4.0, 3.0, -7.0, 5.0));
	var[2][2][1] = (vec4(-4.0, 7.0, 2.0, -6.0));
	var[2][2][2] = (vec4(4.0, -8.0, 5.0, -2.0));
	var[3][0][0] = (vec4(7.0, 5.0, -1.0, 1.0));
	var[3][0][1] = (vec4(6.0, -2.0, -5.0, 9.0));
	var[3][0][2] = (vec4(4.0, -9.0, -3.0, -6.0));
	var[3][1][0] = (vec4(2.0, 4.0, -3.0, 1.0));
	var[3][1][1] = (vec4(9.0, -1.0, -1.0, -1.0));
	var[3][1][2] = (vec4(2.0, 5.0, -5.0, 7.0));
	var[3][2][0] = (vec4(9.0, -7.0, -5.0, -9.0));
	var[3][2][1] = (vec4(3.0, 9.0, 2.0, -5.0));
	var[3][2][2] = (vec4(-4.0, -7.0, -3.0, 7.0));
}
#version 450
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
	highp mat4x2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 9.0) && allOk;
	allOk = compare_mat4x2(var[0][0], mat4x2(-3.0, -5.0, -5.0, -4.0, 8.0, -3.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[0][1], mat4x2(-8.0, 9.0, -7.0, -5.0, -5.0, -5.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[0][2], mat4x2(3.0, -7.0, 5.0, 3.0, 9.0, -8.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[1][0], mat4x2(-4.0, -6.0, 9.0, -3.0, -6.0, 2.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[1][1], mat4x2(6.0, 4.0, -6.0, -2.0, -8.0, 6.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][2], mat4x2(-4.0, -6.0, 4.0, -5.0, -8.0, 9.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[2][0], mat4x2(-1.0, -6.0, 5.0, 3.0, -9.0, 9.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[2][1], mat4x2(-9.0, 9.0, 5.0, 8.0, -3.0, 7.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[2][2], mat4x2(-7.0, -3.0, 6.0, -7.0, -5.0, 5.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[3][0], mat4x2(-5.0, -3.0, -6.0, -9.0, 1.0, 3.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[3][1], mat4x2(9.0, -7.0, -6.0, -8.0, 6.0, 3.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[3][2], mat4x2(7.0, -6.0, 0.0, 0.0, 6.0, -4.0, 6.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-9.0);
	var[0][0] = (mat4x2(1.0, 5.0, 0.0, 6.0, 3.0, 6.0, 9.0, -5.0));
	var[0][1] = (mat4x2(8.0, -6.0, 1.0, -3.0, 2.0, 4.0, -7.0, 8.0));
	var[0][2] = (mat4x2(6.0, 6.0, 1.0, -9.0, 9.0, -3.0, -2.0, 2.0));
	var[1][0] = (mat4x2(-9.0, -3.0, -1.0, 1.0, 8.0, 1.0, 0.0, -3.0));
	var[1][1] = (mat4x2(-3.0, -6.0, -7.0, 2.0, 2.0, 7.0, 6.0, 3.0));
	var[1][2] = (mat4x2(-7.0, -9.0, 6.0, 3.0, 6.0, 3.0, -6.0, -8.0));
	var[2][0] = (mat4x2(-9.0, -8.0, -8.0, -4.0, -5.0, -5.0, 5.0, -6.0));
	var[2][1] = (mat4x2(7.0, 7.0, -9.0, 6.0, -8.0, -3.0, 1.0, 4.0));
	var[2][2] = (mat4x2(8.0, -6.0, 5.0, 3.0, 3.0, 2.0, -4.0, 2.0));
	var[3][0] = (mat4x2(9.0, 9.0, -2.0, 0.0, -5.0, -2.0, -3.0, 3.0));
	var[3][1] = (mat4x2(8.0, 9.0, -2.0, -1.0, 3.0, -2.0, 5.0, 7.0));
	var[3][2] = (mat4x2(1.0, -1.0, 2.0, 8.0, 7.0, 7.0, 5.0, 9.0));
}
#version 450
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
	highp mat4x2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 0.0) && allOk;
	allOk = compare_mat4x2(var[0][0], mat4x2(6.0, -3.0, 7.0, 1.0, -8.0, 8.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[0][1], mat4x2(-3.0, -5.0, 5.0, 5.0, 1.0, -7.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[0][2], mat4x2(1.0, -2.0, -3.0, -9.0, 3.0, 9.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[1][0], mat4x2(-2.0, -9.0, 5.0, -5.0, -6.0, 9.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[1][1], mat4x2(-3.0, 5.0, 6.0, -4.0, -8.0, -3.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][2], mat4x2(4.0, -9.0, 6.0, 8.0, -3.0, -2.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[2][0], mat4x2(5.0, 0.0, -5.0, 6.0, -8.0, 3.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[2][1], mat4x2(6.0, -5.0, 2.0, -8.0, -2.0, -4.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[2][2], mat4x2(-1.0, 6.0, -3.0, 4.0, 0.0, 9.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[3][0], mat4x2(8.0, 8.0, -7.0, 4.0, 6.0, 2.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[3][1], mat4x2(-8.0, 9.0, -2.0, -7.0, -9.0, 1.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[3][2], mat4x2(0.0, 3.0, 9.0, -8.0, -1.0, 4.0, -2.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (8.0);
	var[0][0] = (mat4x2(-5.0, 3.0, 0.0, -9.0, 4.0, -5.0, 3.0, 6.0));
	var[0][1] = (mat4x2(3.0, 6.0, -6.0, 0.0, -3.0, -2.0, -4.0, 5.0));
	var[0][2] = (mat4x2(4.0, 1.0, 0.0, 7.0, -9.0, -4.0, 5.0, 6.0));
	var[1][0] = (mat4x2(1.0, 0.0, 3.0, 2.0, -5.0, -4.0, 5.0, 5.0));
	var[1][1] = (mat4x2(-4.0, -7.0, -8.0, 9.0, -4.0, 5.0, 5.0, -1.0));
	var[1][2] = (mat4x2(6.0, -6.0, 5.0, 4.0, -3.0, 1.0, -4.0, 1.0));
	var[2][0] = (mat4x2(-6.0, 2.0, 4.0, 7.0, 1.0, 9.0, 5.0, 8.0));
	var[2][1] = (mat4x2(-7.0, 6.0, -7.0, -4.0, 5.0, 3.0, -2.0, -2.0));
	var[2][2] = (mat4x2(-5.0, -1.0, 1.0, -8.0, 4.0, 9.0, 2.0, -5.0));
	var[3][0] = (mat4x2(6.0, 0.0, 4.0, -8.0, -7.0, 1.0, 1.0, 1.0));
	var[3][1] = (mat4x2(-9.0, -1.0, 6.0, -9.0, -7.0, -8.0, 8.0, -2.0));
	var[3][2] = (mat4x2(7.0, 8.0, -9.0, 4.0, -3.0, 0.0, -7.0, 4.0));
}
#version 450
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
	allOk = compare_mat4x3(var[0][0][0], mat4x3(-2.0, 8.0, 0.0, 9.0, -7.0, -7.0, 8.0, 2.0, 7.0, 3.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(9.0, -7.0, -6.0, -8.0, -6.0, 3.0, -8.0, -8.0, -4.0, 5.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][2], mat4x3(-6.0, 1.0, 9.0, 4.0, -4.0, -7.0, 9.0, -3.0, -7.0, 9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(8.0, 3.0, -4.0, -1.0, -1.0, 6.0, 4.0, -5.0, 5.0, 4.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(-2.0, -4.0, 7.0, -7.0, -5.0, 7.0, 0.0, 0.0, -1.0, -5.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][2], mat4x3(8.0, 9.0, 4.0, 2.0, 6.0, 1.0, -3.0, 0.0, 1.0, -6.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(1.0, 7.0, -4.0, 6.0, 0.0, 2.0, 2.0, 3.0, -9.0, 4.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(5.0, 4.0, 8.0, -8.0, 0.0, 5.0, -5.0, 7.0, 9.0, -8.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][2], mat4x3(6.0, 3.0, 0.0, -3.0, 0.0, -2.0, 5.0, 1.0, 1.0, 6.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(0.0, 9.0, 4.0, -6.0, 8.0, 9.0, 3.0, -5.0, -8.0, 4.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(7.0, -4.0, -1.0, -2.0, 6.0, 7.0, 5.0, -4.0, 3.0, 1.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][2], mat4x3(4.0, -5.0, 9.0, 5.0, 6.0, 2.0, 5.0, 5.0, 4.0, 6.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(5.0, -7.0, -7.0, -6.0, -9.0, 6.0, 7.0, -3.0, -3.0, 9.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(2.0, 5.0, 2.0, 0.0, 9.0, -8.0, -2.0, -2.0, -1.0, -2.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][2], mat4x3(-9.0, -1.0, -2.0, -2.0, 8.0, -3.0, -7.0, 1.0, -6.0, 8.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(-4.0, -2.0, -6.0, -6.0, -1.0, -4.0, 1.0, 5.0, -2.0, 2.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(-7.0, 4.0, -9.0, 9.0, -7.0, -9.0, -7.0, -1.0, 9.0, -4.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][2], mat4x3(4.0, -3.0, 2.0, 1.0, -6.0, 3.0, 7.0, -1.0, 0.0, 8.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][0], mat4x3(-5.0, -8.0, 7.0, 3.0, 7.0, 9.0, 7.0, 9.0, -2.0, -4.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][1], mat4x3(5.0, 2.0, 7.0, 6.0, -5.0, -7.0, 3.0, -9.0, -5.0, -8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][2], mat4x3(-7.0, 4.0, 6.0, 2.0, 8.0, -1.0, 5.0, 2.0, 7.0, 1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][0], mat4x3(-9.0, -9.0, -9.0, 3.0, 7.0, 2.0, 9.0, 2.0, 9.0, 2.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][1], mat4x3(1.0, 3.0, -2.0, 4.0, 1.0, 2.0, 5.0, -9.0, -7.0, 3.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][2], mat4x3(-5.0, 3.0, 3.0, 2.0, -4.0, 4.0, -8.0, -3.0, 4.0, 4.0, 0.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec3(1.0, 3.0, -7.0));
	var[0][0][0][1] = (vec3(-7.0, 2.0, 3.0));
	var[0][0][0][2] = (vec3(1.0, -2.0, -1.0));
	var[0][0][0][3] = (vec3(-5.0, -1.0, 9.0));
	var[0][0][1][0] = (vec3(8.0, -4.0, 3.0));
	var[0][0][1][1] = (vec3(4.0, 9.0, -6.0));
	var[0][0][1][2] = (vec3(7.0, 6.0, -5.0));
	var[0][0][1][3] = (vec3(2.0, 6.0, 3.0));
	var[0][0][2][0] = (vec3(2.0, 7.0, -1.0));
	var[0][0][2][1] = (vec3(-3.0, -3.0, -7.0));
	var[0][0][2][2] = (vec3(-5.0, 3.0, 4.0));
	var[0][0][2][3] = (vec3(-4.0, -2.0, 8.0));
	var[0][1][0][0] = (vec3(-5.0, 5.0, -2.0));
	var[0][1][0][1] = (vec3(1.0, -7.0, -9.0));
	var[0][1][0][2] = (vec3(4.0, -9.0, 8.0));
	var[0][1][0][3] = (vec3(2.0, 5.0, -4.0));
	var[0][1][1][0] = (vec3(-9.0, -9.0, 5.0));
	var[0][1][1][1] = (vec3(-3.0, 6.0, -3.0));
	var[0][1][1][2] = (vec3(7.0, -9.0, -4.0));
	var[0][1][1][3] = (vec3(9.0, 6.0, 2.0));
	var[0][1][2][0] = (vec3(-3.0, -5.0, 2.0));
	var[0][1][2][1] = (vec3(-9.0, 5.0, -6.0));
	var[0][1][2][2] = (vec3(5.0, -7.0, -9.0));
	var[0][1][2][3] = (vec3(0.0, 9.0, 9.0));
	var[1][0][0][0] = (vec3(-1.0, -8.0, 8.0));
	var[1][0][0][1] = (vec3(-4.0, -7.0, -7.0));
	var[1][0][0][2] = (vec3(8.0, 4.0, -6.0));
	var[1][0][0][3] = (vec3(6.0, 0.0, 1.0));
	var[1][0][1][0] = (vec3(7.0, -1.0, -8.0));
	var[1][0][1][1] = (vec3(9.0, 9.0, -6.0));
	var[1][0][1][2] = (vec3(0.0, 1.0, 1.0));
	var[1][0][1][3] = (vec3(2.0, 7.0, 2.0));
	var[1][0][2][0] = (vec3(-3.0, -6.0, 5.0));
	var[1][0][2][1] = (vec3(3.0, -1.0, -1.0));
	var[1][0][2][2] = (vec3(-2.0, 9.0, -5.0));
	var[1][0][2][3] = (vec3(8.0, -6.0, -5.0));
	var[1][1][0][0] = (vec3(-9.0, 5.0, 5.0));
	var[1][1][0][1] = (vec3(-2.0, 7.0, 7.0));
	var[1][1][0][2] = (vec3(-2.0, 7.0, -9.0));
	var[1][1][0][3] = (vec3(5.0, 5.0, -4.0));
	var[1][1][1][0] = (vec3(6.0, -3.0, 7.0));
	var[1][1][1][1] = (vec3(-3.0, 1.0, -7.0));
	var[1][1][1][2] = (vec3(-1.0, 0.0, -9.0));
	var[1][1][1][3] = (vec3(0.0, -4.0, 9.0));
	var[1][1][2][0] = (vec3(-6.0, -5.0, 7.0));
	var[1][1][2][1] = (vec3(6.0, 1.0, -2.0));
	var[1][1][2][2] = (vec3(2.0, 8.0, 9.0));
	var[1][1][2][3] = (vec3(2.0, -8.0, -9.0));
	var[2][0][0][0] = (vec3(-9.0, 3.0, -2.0));
	var[2][0][0][1] = (vec3(5.0, 6.0, -7.0));
	var[2][0][0][2] = (vec3(-8.0, 1.0, 8.0));
	var[2][0][0][3] = (vec3(1.0, 6.0, -1.0));
	var[2][0][1][0] = (vec3(-5.0, 0.0, -6.0));
	var[2][0][1][1] = (vec3(5.0, -3.0, 2.0));
	var[2][0][1][2] = (vec3(-5.0, 2.0, -2.0));
	var[2][0][1][3] = (vec3(-7.0, -9.0, -1.0));
	var[2][0][2][0] = (vec3(-2.0, -3.0, -7.0));
	var[2][0][2][1] = (vec3(-9.0, -4.0, 9.0));
	var[2][0][2][2] = (vec3(4.0, -4.0, 5.0));
	var[2][0][2][3] = (vec3(7.0, 1.0, 7.0));
	var[2][1][0][0] = (vec3(-1.0, -5.0, 2.0));
	var[2][1][0][1] = (vec3(4.0, 7.0, -4.0));
	var[2][1][0][2] = (vec3(6.0, 2.0, -4.0));
	var[2][1][0][3] = (vec3(8.0, -8.0, -1.0));
	var[2][1][1][0] = (vec3(-8.0, -9.0, 2.0));
	var[2][1][1][1] = (vec3(-8.0, -2.0, -1.0));
	var[2][1][1][2] = (vec3(-4.0, 5.0, 4.0));
	var[2][1][1][3] = (vec3(-6.0, -1.0, 7.0));
	var[2][1][2][0] = (vec3(1.0, -1.0, 9.0));
	var[2][1][2][1] = (vec3(-9.0, 4.0, 7.0));
	var[2][1][2][2] = (vec3(-5.0, -9.0, 1.0));
	var[2][1][2][3] = (vec3(-1.0, 2.0, -5.0));
	var[3][0][0][0] = (vec3(-9.0, 5.0, 4.0));
	var[3][0][0][1] = (vec3(4.0, 0.0, 0.0));
	var[3][0][0][2] = (vec3(0.0, -3.0, 3.0));
	var[3][0][0][3] = (vec3(1.0, 8.0, 0.0));
	var[3][0][1][0] = (vec3(-2.0, 9.0, -8.0));
	var[3][0][1][1] = (vec3(-8.0, 7.0, -9.0));
	var[3][0][1][2] = (vec3(3.0, -2.0, -3.0));
	var[3][0][1][3] = (vec3(-5.0, 1.0, -4.0));
	var[3][0][2][0] = (vec3(5.0, 5.0, 8.0));
	var[3][0][2][1] = (vec3(3.0, 7.0, -3.0));
	var[3][0][2][2] = (vec3(-2.0, 2.0, -9.0));
	var[3][0][2][3] = (vec3(0.0, 9.0, 5.0));
	var[3][1][0][0] = (vec3(3.0, 6.0, 7.0));
	var[3][1][0][1] = (vec3(4.0, -5.0, 8.0));
	var[3][1][0][2] = (vec3(4.0, 6.0, 1.0));
	var[3][1][0][3] = (vec3(-4.0, 5.0, -7.0));
	var[3][1][1][0] = (vec3(-2.0, -3.0, -9.0));
	var[3][1][1][1] = (vec3(5.0, -8.0, -5.0));
	var[3][1][1][2] = (vec3(-7.0, -4.0, -3.0));
	var[3][1][1][3] = (vec3(-1.0, 8.0, -8.0));
	var[3][1][2][0] = (vec3(-2.0, -6.0, 6.0));
	var[3][1][2][1] = (vec3(-3.0, -2.0, -8.0));
	var[3][1][2][2] = (vec3(-3.0, -2.0, -2.0));
	var[3][1][2][3] = (vec3(-9.0, 4.0, 7.0));
}
#version 450
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
	highp mat4x3 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0][0][0], mat4x3(3.0, 6.0, 1.0, -6.0, -9.0, -8.0, 6.0, 4.0, 5.0, -6.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(-1.0, 1.0, 2.0, 9.0, 3.0, 1.0, 1.0, 7.0, -1.0, 8.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(-3.0, 0.0, 6.0, -2.0, 7.0, 3.0, 6.0, -7.0, 3.0, -8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(-1.0, 0.0, -7.0, 9.0, -7.0, -6.0, -5.0, 2.0, 8.0, 6.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[0][2][0], mat4x3(7.0, -9.0, 1.0, -8.0, -1.0, -4.0, -7.0, -5.0, 8.0, -9.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[0][2][1], mat4x3(-5.0, 9.0, 1.0, 3.0, 0.0, -5.0, 3.0, 4.0, -5.0, 1.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[0][3][0], mat4x3(-8.0, 1.0, -1.0, -1.0, -9.0, 7.0, -4.0, 0.0, -7.0, -9.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[0][3][1], mat4x3(5.0, -9.0, 6.0, -3.0, 3.0, -7.0, 3.0, -1.0, 2.0, -7.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(9.0, 4.0, 5.0, -9.0, 2.0, 0.0, -9.0, -2.0, 1.0, -7.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(-5.0, -5.0, -5.0, 8.0, -6.0, 8.0, -7.0, -4.0, -1.0, 2.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(7.0, -1.0, -6.0, 5.0, 6.0, -1.0, -1.0, -3.0, -1.0, 5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(2.0, 6.0, 4.0, 7.0, 3.0, -8.0, 0.0, 3.0, -4.0, 2.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[1][2][0], mat4x3(7.0, -8.0, -6.0, 5.0, -1.0, -9.0, 2.0, -2.0, 6.0, -5.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[1][2][1], mat4x3(-9.0, -8.0, -9.0, -3.0, -2.0, 8.0, 4.0, 3.0, -8.0, -6.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[1][3][0], mat4x3(-9.0, 1.0, 7.0, 0.0, 0.0, -4.0, 3.0, -4.0, -6.0, -7.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[1][3][1], mat4x3(-4.0, -2.0, -1.0, -2.0, -5.0, -7.0, -6.0, 8.0, -9.0, -3.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(-5.0, 8.0, 5.0, 8.0, -2.0, 2.0, -5.0, -4.0, -3.0, 8.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(5.0, -4.0, 3.0, -9.0, 7.0, 8.0, -7.0, -7.0, 6.0, -2.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(2.0, -4.0, 3.0, 9.0, 2.0, 9.0, 2.0, -5.0, -7.0, -1.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(-7.0, -7.0, 9.0, -8.0, -1.0, 0.0, 5.0, 6.0, 4.0, -7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[2][2][0], mat4x3(8.0, -3.0, -6.0, 8.0, -2.0, 8.0, 9.0, 0.0, 1.0, -3.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[2][2][1], mat4x3(7.0, 0.0, 3.0, 4.0, -5.0, -8.0, 5.0, 0.0, 8.0, 2.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[2][3][0], mat4x3(9.0, 8.0, -4.0, -7.0, 9.0, 5.0, -7.0, 3.0, -2.0, -4.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[2][3][1], mat4x3(5.0, 4.0, -4.0, -7.0, 7.0, -2.0, 9.0, 5.0, 1.0, -9.0, 0.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec3(1.0, 2.0, -5.0));
	var[0][0][0][1] = (vec3(-3.0, -2.0, 2.0));
	var[0][0][0][2] = (vec3(-5.0, 9.0, 4.0));
	var[0][0][0][3] = (vec3(2.0, -4.0, 9.0));
	var[0][0][1][0] = (vec3(8.0, -4.0, -5.0));
	var[0][0][1][1] = (vec3(-5.0, 6.0, 8.0));
	var[0][0][1][2] = (vec3(-7.0, 4.0, -8.0));
	var[0][0][1][3] = (vec3(-1.0, 1.0, 1.0));
	var[0][1][0][0] = (vec3(2.0, 5.0, 2.0));
	var[0][1][0][1] = (vec3(2.0, 3.0, -2.0));
	var[0][1][0][2] = (vec3(5.0, 4.0, 6.0));
	var[0][1][0][3] = (vec3(-1.0, 5.0, 6.0));
	var[0][1][1][0] = (vec3(1.0, 2.0, -4.0));
	var[0][1][1][1] = (vec3(9.0, -1.0, 6.0));
	var[0][1][1][2] = (vec3(9.0, -1.0, -2.0));
	var[0][1][1][3] = (vec3(-1.0, -8.0, 3.0));
	var[0][2][0][0] = (vec3(-5.0, 3.0, -5.0));
	var[0][2][0][1] = (vec3(-6.0, 6.0, 3.0));
	var[0][2][0][2] = (vec3(-6.0, 0.0, -5.0));
	var[0][2][0][3] = (vec3(-9.0, 8.0, -8.0));
	var[0][2][1][0] = (vec3(-5.0, 2.0, -7.0));
	var[0][2][1][1] = (vec3(-1.0, -2.0, 7.0));
	var[0][2][1][2] = (vec3(4.0, -7.0, 7.0));
	var[0][2][1][3] = (vec3(-3.0, 7.0, 6.0));
	var[0][3][0][0] = (vec3(1.0, -1.0, 8.0));
	var[0][3][0][1] = (vec3(8.0, 3.0, -9.0));
	var[0][3][0][2] = (vec3(1.0, -1.0, -7.0));
	var[0][3][0][3] = (vec3(-1.0, -7.0, -5.0));
	var[0][3][1][0] = (vec3(-5.0, 1.0, 8.0));
	var[0][3][1][1] = (vec3(5.0, 5.0, -8.0));
	var[0][3][1][2] = (vec3(-8.0, 2.0, 8.0));
	var[0][3][1][3] = (vec3(2.0, -8.0, -6.0));
	var[1][0][0][0] = (vec3(-4.0, 5.0, 7.0));
	var[1][0][0][1] = (vec3(9.0, 5.0, -7.0));
	var[1][0][0][2] = (vec3(8.0, 9.0, 0.0));
	var[1][0][0][3] = (vec3(-3.0, 3.0, 0.0));
	var[1][0][1][0] = (vec3(7.0, -8.0, -7.0));
	var[1][0][1][1] = (vec3(2.0, 7.0, 5.0));
	var[1][0][1][2] = (vec3(5.0, -7.0, 0.0));
	var[1][0][1][3] = (vec3(-2.0, 9.0, -7.0));
	var[1][1][0][0] = (vec3(-4.0, 1.0, -4.0));
	var[1][1][0][1] = (vec3(4.0, 2.0, 0.0));
	var[1][1][0][2] = (vec3(1.0, -6.0, 1.0));
	var[1][1][0][3] = (vec3(-7.0, -9.0, 8.0));
	var[1][1][1][0] = (vec3(1.0, 9.0, -4.0));
	var[1][1][1][1] = (vec3(1.0, -5.0, 9.0));
	var[1][1][1][2] = (vec3(2.0, -1.0, -1.0));
	var[1][1][1][3] = (vec3(5.0, 7.0, -4.0));
	var[1][2][0][0] = (vec3(9.0, -2.0, 2.0));
	var[1][2][0][1] = (vec3(-3.0, -6.0, 3.0));
	var[1][2][0][2] = (vec3(7.0, -7.0, -1.0));
	var[1][2][0][3] = (vec3(0.0, 1.0, -3.0));
	var[1][2][1][0] = (vec3(-6.0, 6.0, 2.0));
	var[1][2][1][1] = (vec3(-5.0, 0.0, 4.0));
	var[1][2][1][2] = (vec3(7.0, -6.0, -6.0));
	var[1][2][1][3] = (vec3(3.0, 8.0, 1.0));
	var[1][3][0][0] = (vec3(-9.0, 1.0, 5.0));
	var[1][3][0][1] = (vec3(4.0, 5.0, 1.0));
	var[1][3][0][2] = (vec3(-7.0, 4.0, -5.0));
	var[1][3][0][3] = (vec3(4.0, 8.0, 8.0));
	var[1][3][1][0] = (vec3(-4.0, -2.0, -5.0));
	var[1][3][1][1] = (vec3(-5.0, -9.0, 8.0));
	var[1][3][1][2] = (vec3(4.0, 8.0, 0.0));
	var[1][3][1][3] = (vec3(0.0, 9.0, 5.0));
	var[2][0][0][0] = (vec3(2.0, -9.0, 0.0));
	var[2][0][0][1] = (vec3(9.0, -2.0, -8.0));
	var[2][0][0][2] = (vec3(-9.0, 5.0, 9.0));
	var[2][0][0][3] = (vec3(0.0, 8.0, -9.0));
	var[2][0][1][0] = (vec3(2.0, 1.0, -7.0));
	var[2][0][1][1] = (vec3(-7.0, 8.0, 7.0));
	var[2][0][1][2] = (vec3(8.0, -8.0, -5.0));
	var[2][0][1][3] = (vec3(5.0, 1.0, -3.0));
	var[2][1][0][0] = (vec3(-2.0, 9.0, -4.0));
	var[2][1][0][1] = (vec3(-4.0, 4.0, -1.0));
	var[2][1][0][2] = (vec3(0.0, 7.0, 9.0));
	var[2][1][0][3] = (vec3(-8.0, 3.0, 9.0));
	var[2][1][1][0] = (vec3(-7.0, -1.0, -9.0));
	var[2][1][1][1] = (vec3(-7.0, 3.0, 5.0));
	var[2][1][1][2] = (vec3(-7.0, 1.0, -1.0));
	var[2][1][1][3] = (vec3(-5.0, -7.0, 7.0));
	var[2][2][0][0] = (vec3(-3.0, -1.0, 7.0));
	var[2][2][0][1] = (vec3(-2.0, -7.0, -9.0));
	var[2][2][0][2] = (vec3(-8.0, -1.0, 4.0));
	var[2][2][0][3] = (vec3(0.0, -2.0, -5.0));
	var[2][2][1][0] = (vec3(2.0, -7.0, 3.0));
	var[2][2][1][1] = (vec3(-2.0, 4.0, -6.0));
	var[2][2][1][2] = (vec3(8.0, -7.0, -9.0));
	var[2][2][1][3] = (vec3(-4.0, 5.0, 4.0));
	var[2][3][0][0] = (vec3(-3.0, 8.0, 6.0));
	var[2][3][0][1] = (vec3(7.0, 8.0, -7.0));
	var[2][3][0][2] = (vec3(-3.0, -6.0, -2.0));
	var[2][3][0][3] = (vec3(-6.0, 0.0, -8.0));
	var[2][3][1][0] = (vec3(-6.0, 0.0, 6.0));
	var[2][3][1][1] = (vec3(-1.0, 6.0, -7.0));
	var[2][3][1][2] = (vec3(7.0, 0.0, 1.0));
	var[2][3][1][3] = (vec3(-8.0, 2.0, 7.0));
}
#version 450
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
	highp vec3 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((var[0][0][0]), vec3(7.0, 9.0, -6.0)) && allOk;
	allOk = compare_vec3((var[0][0][1]), vec3(-9.0, 5.0, -8.0)) && allOk;
	allOk = compare_vec3((var[0][1][0]), vec3(1.0, -4.0, 0.0)) && allOk;
	allOk = compare_vec3((var[0][1][1]), vec3(5.0, 6.0, 5.0)) && allOk;
	allOk = compare_vec3((var[0][2][0]), vec3(-1.0, 5.0, 8.0)) && allOk;
	allOk = compare_vec3((var[0][2][1]), vec3(2.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec3((var[0][3][0]), vec3(-8.0, -2.0, 6.0)) && allOk;
	allOk = compare_vec3((var[0][3][1]), vec3(8.0, 7.0, -2.0)) && allOk;
	allOk = compare_vec3((var[1][0][0]), vec3(1.0, -1.0, 7.0)) && allOk;
	allOk = compare_vec3((var[1][0][1]), vec3(-1.0, -9.0, 3.0)) && allOk;
	allOk = compare_vec3((var[1][1][0]), vec3(-3.0, 5.0, 7.0)) && allOk;
	allOk = compare_vec3((var[1][1][1]), vec3(8.0, 5.0, 8.0)) && allOk;
	allOk = compare_vec3((var[1][2][0]), vec3(8.0, 9.0, 6.0)) && allOk;
	allOk = compare_vec3((var[1][2][1]), vec3(6.0, -8.0, 0.0)) && allOk;
	allOk = compare_vec3((var[1][3][0]), vec3(9.0, 2.0, 9.0)) && allOk;
	allOk = compare_vec3((var[1][3][1]), vec3(9.0, 4.0, 9.0)) && allOk;
	allOk = compare_vec3((var[2][0][0]), vec3(-7.0, -2.0, -4.0)) && allOk;
	allOk = compare_vec3((var[2][0][1]), vec3(3.0, 3.0, 6.0)) && allOk;
	allOk = compare_vec3((var[2][1][0]), vec3(5.0, -8.0, -5.0)) && allOk;
	allOk = compare_vec3((var[2][1][1]), vec3(-7.0, -3.0, 7.0)) && allOk;
	allOk = compare_vec3((var[2][2][0]), vec3(-6.0, -1.0, 2.0)) && allOk;
	allOk = compare_vec3((var[2][2][1]), vec3(2.0, 7.0, -9.0)) && allOk;
	allOk = compare_vec3((var[2][3][0]), vec3(-5.0, 0.0, -8.0)) && allOk;
	allOk = compare_vec3((var[2][3][1]), vec3(-2.0, -4.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec3(5.0, 4.0, 7.0));
	var[0][0][1] = (vec3(8.0, -2.0, 7.0));
	var[0][1][0] = (vec3(0.0, 5.0, 1.0));
	var[0][1][1] = (vec3(-5.0, 0.0, 1.0));
	var[0][2][0] = (vec3(-4.0, 5.0, 1.0));
	var[0][2][1] = (vec3(-9.0, 6.0, -2.0));
	var[0][3][0] = (vec3(3.0, 3.0, -7.0));
	var[0][3][1] = (vec3(2.0, 9.0, 0.0));
	var[1][0][0] = (vec3(-5.0, -7.0, 9.0));
	var[1][0][1] = (vec3(6.0, 6.0, 0.0));
	var[1][1][0] = (vec3(0.0, 7.0, -2.0));
	var[1][1][1] = (vec3(-2.0, 8.0, -1.0));
	var[1][2][0] = (vec3(-8.0, -9.0, 3.0));
	var[1][2][1] = (vec3(4.0, -2.0, -9.0));
	var[1][3][0] = (vec3(5.0, 9.0, 4.0));
	var[1][3][1] = (vec3(-1.0, 6.0, -1.0));
	var[2][0][0] = (vec3(-5.0, 2.0, -8.0));
	var[2][0][1] = (vec3(5.0, 0.0, 2.0));
	var[2][1][0] = (vec3(-1.0, 5.0, 1.0));
	var[2][1][1] = (vec3(-1.0, -3.0, 8.0));
	var[2][2][0] = (vec3(-2.0, 6.0, -7.0));
	var[2][2][1] = (vec3(6.0, -4.0, 3.0));
	var[2][3][0] = (vec3(4.0, 2.0, -8.0));
	var[2][3][1] = (vec3(-3.0, 2.0, -9.0));
}
#version 450
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
	allOk = compare_mat4(var[0][0][0], mat4(-8.0, 3.0, 4.0, 4.0, -5.0, 8.0, 6.0, 7.0, 4.0, 5.0, 7.0, -3.0, 0.0, 2.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(-1.0, -2.0, -3.0, 1.0, -9.0, -9.0, -6.0, 5.0, 6.0, 7.0, 6.0, 1.0, -8.0, -3.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(5.0, -7.0, -8.0, -6.0, 7.0, 3.0, 0.0, -4.0, 5.0, -2.0, 3.0, -9.0, 2.0, -2.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(-6.0, -8.0, 2.0, -5.0, 0.0, -2.0, 7.0, -3.0, 4.0, 4.0, 4.0, 5.0, 7.0, -1.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4(var[0][2][0], mat4(1.0, 6.0, -6.0, 7.0, 9.0, 3.0, 0.0, 7.0, 0.0, 9.0, -9.0, 1.0, 4.0, -9.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat4(var[0][2][1], mat4(7.0, 7.0, -6.0, -6.0, 8.0, -2.0, 4.0, -6.0, 7.0, -4.0, -8.0, -2.0, -2.0, 3.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4(var[0][3][0], mat4(0.0, 3.0, 3.0, 8.0, 3.0, 7.0, -3.0, 1.0, -8.0, 3.0, 7.0, -3.0, 7.0, 5.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4(var[0][3][1], mat4(3.0, -1.0, 1.0, 1.0, -3.0, 9.0, 9.0, -5.0, 5.0, -1.0, 6.0, -1.0, -4.0, -9.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(6.0, 0.0, 5.0, -6.0, -1.0, -6.0, -1.0, 6.0, 1.0, -1.0, 3.0, -1.0, 6.0, 4.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(-3.0, 8.0, -3.0, -7.0, -4.0, -6.0, -1.0, 4.0, 9.0, -1.0, 6.0, -4.0, 0.0, -7.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(-1.0, 5.0, 8.0, -3.0, -9.0, 9.0, -4.0, 5.0, 7.0, -3.0, 5.0, 6.0, -8.0, 2.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(-3.0, 3.0, 3.0, -3.0, -6.0, -5.0, 3.0, -7.0, -3.0, 7.0, -7.0, 2.0, 7.0, -9.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat4(var[1][2][0], mat4(0.0, -2.0, -9.0, 6.0, -2.0, -1.0, 8.0, 5.0, 1.0, 7.0, 0.0, -1.0, 1.0, -2.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat4(var[1][2][1], mat4(-9.0, -7.0, 3.0, -8.0, 8.0, 3.0, 6.0, -3.0, 8.0, -1.0, 8.0, 0.0, 5.0, 7.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat4(var[1][3][0], mat4(-2.0, -9.0, 2.0, 5.0, 5.0, 4.0, 1.0, 4.0, -7.0, -4.0, -2.0, -8.0, -7.0, 9.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat4(var[1][3][1], mat4(-9.0, 1.0, 7.0, -3.0, -8.0, 7.0, 0.0, 6.0, -9.0, -5.0, 9.0, -7.0, 6.0, -9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(3.0, -9.0, -5.0, 9.0, -5.0, -7.0, 5.0, 0.0, -5.0, 4.0, 7.0, 2.0, -1.0, 9.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(6.0, -4.0, -9.0, 2.0, 1.0, 8.0, -6.0, 0.0, -7.0, -8.0, 5.0, -9.0, -9.0, -5.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(-8.0, -8.0, 8.0, -1.0, -8.0, -1.0, 7.0, 1.0, 7.0, 3.0, -9.0, -3.0, 2.0, -2.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(8.0, 8.0, -7.0, -5.0, 0.0, -1.0, -6.0, -9.0, -8.0, -9.0, -1.0, -7.0, -3.0, -7.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4(var[2][2][0], mat4(0.0, 6.0, -8.0, -6.0, 7.0, 9.0, 7.0, -8.0, 2.0, 6.0, 0.0, 5.0, -8.0, 5.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4(var[2][2][1], mat4(0.0, 8.0, 3.0, 5.0, -1.0, 7.0, -5.0, 0.0, -3.0, -6.0, -8.0, -6.0, 6.0, -3.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat4(var[2][3][0], mat4(-3.0, -7.0, -9.0, 0.0, 6.0, 2.0, -6.0, -9.0, -4.0, -6.0, 3.0, 4.0, 7.0, 1.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(var[2][3][1], mat4(-6.0, 7.0, 3.0, 2.0, 4.0, 8.0, 8.0, -3.0, -8.0, -1.0, -7.0, -6.0, 7.0, -3.0, -6.0, -6.0)) && allOk;
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
	var[0][1][0][0] = (vec4(-5.0, 9.0, 9.0, 4.0));
	var[0][1][0][1] = (vec4(6.0, -2.0, -1.0, -2.0));
	var[0][1][0][2] = (vec4(0.0, 5.0, -4.0, 5.0));
	var[0][1][0][3] = (vec4(8.0, -8.0, 9.0, -3.0));
	var[0][1][1][0] = (vec4(4.0, -8.0, -1.0, 0.0));
	var[0][1][1][1] = (vec4(-3.0, -4.0, -7.0, 1.0));
	var[0][1][1][2] = (vec4(4.0, -2.0, 1.0, -8.0));
	var[0][1][1][3] = (vec4(-8.0, 5.0, 4.0, 7.0));
	var[0][2][0][0] = (vec4(-1.0, -6.0, -8.0, -9.0));
	var[0][2][0][1] = (vec4(0.0, 3.0, 6.0, -1.0));
	var[0][2][0][2] = (vec4(4.0, 6.0, 8.0, 1.0));
	var[0][2][0][3] = (vec4(9.0, -4.0, 7.0, 7.0));
	var[0][2][1][0] = (vec4(2.0, -1.0, -8.0, 9.0));
	var[0][2][1][1] = (vec4(-1.0, 7.0, -4.0, 2.0));
	var[0][2][1][2] = (vec4(9.0, 2.0, -2.0, -1.0));
	var[0][2][1][3] = (vec4(7.0, 3.0, -6.0, 0.0));
	var[0][3][0][0] = (vec4(1.0, -3.0, -1.0, 9.0));
	var[0][3][0][1] = (vec4(-4.0, -5.0, 6.0, 9.0));
	var[0][3][0][2] = (vec4(-5.0, -7.0, 1.0, 2.0));
	var[0][3][0][3] = (vec4(-7.0, 2.0, -8.0, 9.0));
	var[0][3][1][0] = (vec4(-1.0, 2.0, 4.0, 1.0));
	var[0][3][1][1] = (vec4(5.0, -8.0, -7.0, 3.0));
	var[0][3][1][2] = (vec4(-5.0, 2.0, 5.0, 7.0));
	var[0][3][1][3] = (vec4(-9.0, 2.0, -7.0, 9.0));
	var[1][0][0][0] = (vec4(1.0, -4.0, -6.0, 5.0));
	var[1][0][0][1] = (vec4(2.0, 1.0, 9.0, -4.0));
	var[1][0][0][2] = (vec4(-7.0, 7.0, 0.0, 7.0));
	var[1][0][0][3] = (vec4(9.0, 9.0, -5.0, -7.0));
	var[1][0][1][0] = (vec4(-9.0, 5.0, 8.0, 6.0));
	var[1][0][1][1] = (vec4(4.0, 6.0, -1.0, -7.0));
	var[1][0][1][2] = (vec4(7.0, 8.0, 5.0, -1.0));
	var[1][0][1][3] = (vec4(8.0, 2.0, -8.0, 0.0));
	var[1][1][0][0] = (vec4(7.0, -2.0, -6.0, 9.0));
	var[1][1][0][1] = (vec4(-7.0, -5.0, 2.0, 2.0));
	var[1][1][0][2] = (vec4(4.0, 8.0, 4.0, -9.0));
	var[1][1][0][3] = (vec4(0.0, -9.0, 0.0, 0.0));
	var[1][1][1][0] = (vec4(9.0, -1.0, -1.0, -3.0));
	var[1][1][1][1] = (vec4(-9.0, -6.0, -8.0, 4.0));
	var[1][1][1][2] = (vec4(-6.0, 9.0, -8.0, 3.0));
	var[1][1][1][3] = (vec4(0.0, 1.0, -1.0, -7.0));
	var[1][2][0][0] = (vec4(-7.0, -8.0, -7.0, 8.0));
	var[1][2][0][1] = (vec4(5.0, 7.0, -3.0, -2.0));
	var[1][2][0][2] = (vec4(9.0, -5.0, -2.0, -2.0));
	var[1][2][0][3] = (vec4(2.0, 4.0, -1.0, 9.0));
	var[1][2][1][0] = (vec4(3.0, 3.0, 4.0, -8.0));
	var[1][2][1][1] = (vec4(-3.0, -9.0, 9.0, -7.0));
	var[1][2][1][2] = (vec4(-7.0, 9.0, -4.0, 0.0));
	var[1][2][1][3] = (vec4(-4.0, -3.0, 0.0, 6.0));
	var[1][3][0][0] = (vec4(-7.0, 5.0, -6.0, -3.0));
	var[1][3][0][1] = (vec4(6.0, -2.0, 9.0, 1.0));
	var[1][3][0][2] = (vec4(0.0, -3.0, -6.0, -8.0));
	var[1][3][0][3] = (vec4(-4.0, 0.0, -2.0, 0.0));
	var[1][3][1][0] = (vec4(-8.0, 9.0, 5.0, 6.0));
	var[1][3][1][1] = (vec4(-9.0, 1.0, 2.0, 8.0));
	var[1][3][1][2] = (vec4(2.0, 9.0, 8.0, 5.0));
	var[1][3][1][3] = (vec4(-8.0, 4.0, -3.0, -4.0));
	var[2][0][0][0] = (vec4(-9.0, -1.0, -5.0, 7.0));
	var[2][0][0][1] = (vec4(3.0, 1.0, 2.0, 2.0));
	var[2][0][0][2] = (vec4(-3.0, -7.0, 1.0, 0.0));
	var[2][0][0][3] = (vec4(9.0, 5.0, -2.0, 6.0));
	var[2][0][1][0] = (vec4(-9.0, 1.0, 2.0, -3.0));
	var[2][0][1][1] = (vec4(-2.0, -2.0, -8.0, -4.0));
	var[2][0][1][2] = (vec4(7.0, -4.0, -1.0, 2.0));
	var[2][0][1][3] = (vec4(7.0, 7.0, 2.0, 8.0));
	var[2][1][0][0] = (vec4(-9.0, -4.0, 4.0, 6.0));
	var[2][1][0][1] = (vec4(4.0, 9.0, 4.0, -4.0));
	var[2][1][0][2] = (vec4(3.0, -1.0, 2.0, 8.0));
	var[2][1][0][3] = (vec4(-3.0, -6.0, -4.0, 0.0));
	var[2][1][1][0] = (vec4(2.0, -1.0, 1.0, -1.0));
	var[2][1][1][1] = (vec4(8.0, 5.0, 3.0, 0.0));
	var[2][1][1][2] = (vec4(-2.0, 0.0, 7.0, -5.0));
	var[2][1][1][3] = (vec4(6.0, 0.0, 6.0, -6.0));
	var[2][2][0][0] = (vec4(-5.0, -7.0, 3.0, -9.0));
	var[2][2][0][1] = (vec4(4.0, 5.0, 0.0, -6.0));
	var[2][2][0][2] = (vec4(7.0, 4.0, 1.0, 9.0));
	var[2][2][0][3] = (vec4(-8.0, 8.0, 7.0, 4.0));
	var[2][2][1][0] = (vec4(-1.0, 5.0, 9.0, -2.0));
	var[2][2][1][1] = (vec4(-5.0, -8.0, 2.0, -5.0));
	var[2][2][1][2] = (vec4(3.0, -8.0, -1.0, -5.0));
	var[2][2][1][3] = (vec4(-6.0, -2.0, 3.0, 0.0));
	var[2][3][0][0] = (vec4(-5.0, -3.0, 4.0, -1.0));
	var[2][3][0][1] = (vec4(5.0, -5.0, 4.0, 2.0));
	var[2][3][0][2] = (vec4(-4.0, -6.0, -2.0, 5.0));
	var[2][3][0][3] = (vec4(-1.0, -4.0, 1.0, 6.0));
	var[2][3][1][0] = (vec4(-1.0, 0.0, 3.0, -1.0));
	var[2][3][1][1] = (vec4(9.0, 4.0, 8.0, 0.0));
	var[2][3][1][2] = (vec4(0.0, -3.0, -3.0, 1.0));
	var[2][3][1][3] = (vec4(4.0, 6.0, -3.0, -5.0));
}
#version 450
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
layout(scalar, binding = 1) buffer Block
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
	allOk = compare_ivec3((s.a), ivec3(-5, -1, -9)) && allOk;
	allOk = compare_mat3(s.b[0], mat3(-2.0, 6.0, -3.0, -6.0, -2.0, -6.0, 3.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3(s.b[1], mat3(0.0, -9.0, 8.0, -9.0, 9.0, 3.0, 6.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat3(s.b[2], mat3(6.0, -1.0, 9.0, -2.0, -7.0, -8.0, 2.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3(s.b[3], mat3(-2.0, 0.0, -2.0, 7.0, -7.0, 6.0, -5.0, -8.0, -8.0)) && allOk;
	allOk = compare_vec4((s.c), vec4(4.0, 4.0, -9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	s.a = (ivec3(-9, -7, 5));
	s.b[0][0] = (vec3(-6.0, 3.0, -3.0));
	s.b[0][1] = (vec3(-2.0, -9.0, 1.0));
	s.b[0][2] = (vec3(-7.0, 9.0, 9.0));
	s.b[1][0] = (vec3(-7.0, -8.0, 3.0));
	s.b[1][1] = (vec3(-7.0, 8.0, 6.0));
	s.b[1][2] = (vec3(8.0, 0.0, 5.0));
	s.b[2][0] = (vec3(-7.0, -6.0, -1.0));
	s.b[2][1] = (vec3(3.0, 7.0, 3.0));
	s.b[2][2] = (vec3(-2.0, 9.0, 9.0));
	s.b[3][0] = (vec3(-1.0, 9.0, 0.0));
	s.b[3][1] = (vec3(5.0, -2.0, 4.0));
	s.b[3][2] = (vec3(-3.0, 0.0, 7.0));
	s.c = (vec4(-2.0, -7.0, 1.0, 4.0));
}
#version 450
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
layout(std430, binding = 1) buffer Block
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
	allOk = compare_mat3(block[0].t[0].a, mat3(-2.0, -1.0, -4.0, 3.0, 4.0, 2.0, -4.0, 4.0, 7.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[0].a), ivec3(7, 3, 5)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[0]), ivec2(2, -5)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[1]), ivec2(7, -5)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[2]), ivec2(-1, -7)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[3]), ivec2(-7, 5)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[0].c), vec4(9.0, -2.0, -1.0, -1.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[1].a), ivec3(-8, 3, 0)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[0]), ivec2(6, -9)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[1]), ivec2(6, 3)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[2]), ivec2(-4, -6)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[3]), ivec2(6, -6)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[1].c), vec4(-7.0, -5.0, -8.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[2].a), ivec3(6, -5, -9)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[0]), ivec2(-5, 0)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[1]), ivec2(8, -2)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[2]), ivec2(-4, 5)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[3]), ivec2(-2, 8)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[2].c), vec4(0.0, 4.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat3(block[0].t[1].a, mat3(-6.0, -1.0, 6.0, -1.0, 2.0, 8.0, 8.0, -9.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[0].a), ivec3(1, 1, -9)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[0]), ivec2(-5, -2)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[1]), ivec2(-2, -3)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[2]), ivec2(2, 8)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[3]), ivec2(-1, -7)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[0].c), vec4(7.0, 3.0, 8.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[1].a), ivec3(3, -1, 1)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[0]), ivec2(-1, 3)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[1]), ivec2(-7, 0)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[2]), ivec2(5, -3)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[3]), ivec2(6, -6)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[1].c), vec4(7.0, -3.0, -7.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[2].a), ivec3(0, -8, -1)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[0]), ivec2(4, 1)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[1]), ivec2(5, -1)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[2]), ivec2(9, -3)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[3]), ivec2(2, -9)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[2].c), vec4(-9.0, -1.0, 3.0, -3.0)) && allOk;
	allOk = compare_uint((block[0].u), 1u) && allOk;
	allOk = compare_mat3(block[1].t[0].a, mat3(-3.0, 4.0, 7.0, 1.0, -9.0, -1.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[0].a), ivec3(-2, -5, 0)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[0]), ivec2(0, -4)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[1]), ivec2(5, -9)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[2]), ivec2(3, 5)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[3]), ivec2(6, -7)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[0].c), vec4(-8.0, 1.0, -6.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[1].a), ivec3(-5, 4, 7)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[0]), ivec2(9, 8)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[1]), ivec2(-2, 0)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[2]), ivec2(-7, -2)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[3]), ivec2(5, -4)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[1].c), vec4(3.0, -8.0, -4.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[2].a), ivec3(1, -2, 7)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[0]), ivec2(-1, 6)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[1]), ivec2(-6, -8)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[2]), ivec2(0, -7)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[3]), ivec2(1, -8)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[2].c), vec4(4.0, 8.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3(block[1].t[1].a, mat3(8.0, 9.0, -2.0, 6.0, 4.0, 9.0, -4.0, 8.0, -2.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[0].a), ivec3(8, -5, 1)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[0]), ivec2(2, 2)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[1]), ivec2(1, -5)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[2]), ivec2(-9, 1)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[3]), ivec2(5, -7)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[0].c), vec4(2.0, -6.0, -2.0, -1.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[1].a), ivec3(-9, 9, -9)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[0]), ivec2(-1, 3)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[1]), ivec2(-8, -2)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[2]), ivec2(-4, -5)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[3]), ivec2(-8, 6)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[1].c), vec4(-5.0, 5.0, 4.0, 3.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[2].a), ivec3(-4, 2, 0)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[0]), ivec2(-9, -9)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[1]), ivec2(-1, 5)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[2]), ivec2(9, -3)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[3]), ivec2(-2, 1)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[2].c), vec4(-7.0, -4.0, 5.0, 4.0)) && allOk;
	allOk = compare_uint((block[1].u), 3u) && allOk;
	allOk = compare_mat3(block[2].t[0].a, mat3(8.0, 7.0, -3.0, -4.0, -8.0, 8.0, -9.0, -3.0, -7.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[0].a), ivec3(4, 5, 2)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[0]), ivec2(-5, -7)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[1]), ivec2(-2, 3)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[2]), ivec2(8, -9)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[3]), ivec2(-6, -9)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[0].c), vec4(7.0, -8.0, 3.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[1].a), ivec3(-4, 9, 0)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[0]), ivec2(-8, 4)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[1]), ivec2(-9, -9)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[2]), ivec2(-6, 4)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[3]), ivec2(-4, 6)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[1].c), vec4(-9.0, -8.0, -3.0, 3.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[2].a), ivec3(-6, 0, 6)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[0]), ivec2(-6, -1)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[1]), ivec2(5, 5)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[2]), ivec2(6, 2)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[3]), ivec2(-2, 0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[2].c), vec4(4.0, 2.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat3(block[2].t[1].a, mat3(1.0, -6.0, -2.0, 5.0, 0.0, -2.0, 5.0, -6.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[0].a), ivec3(6, 9, -7)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[0]), ivec2(9, 1)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[1]), ivec2(6, 2)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[2]), ivec2(8, -1)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[3]), ivec2(-9, 3)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[0].c), vec4(-5.0, -2.0, 0.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[1].a), ivec3(-8, 0, -6)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[0]), ivec2(-2, 2)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[1]), ivec2(-4, 0)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[2]), ivec2(1, -5)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[3]), ivec2(-5, -9)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[1].c), vec4(-5.0, -8.0, 5.0, 7.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[2].a), ivec3(6, -3, 9)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[0]), ivec2(7, 9)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[1]), ivec2(3, 7)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[2]), ivec2(-6, -1)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[3]), ivec2(-4, -3)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[2].c), vec4(-4.0, 0.0, -1.0, -9.0)) && allOk;
	allOk = compare_uint((block[2].u), 2u) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (ivec3(3, -4, 1));
	block[0].s.b[0] = (ivec2(7, -2));
	block[0].s.b[1] = (ivec2(8, -4));
	block[0].s.b[2] = (ivec2(-3, 2));
	block[0].s.b[3] = (ivec2(-3, -9));
	block[0].s.c = (vec4(7.0, 5.0, -5.0, 3.0));
	block[0].u = (0u);
	block[1].s.a = (ivec3(9, 6, -1));
	block[1].s.b[0] = (ivec2(-9, -4));
	block[1].s.b[1] = (ivec2(8, 3));
	block[1].s.b[2] = (ivec2(6, -7));
	block[1].s.b[3] = (ivec2(-5, -8));
	block[1].s.c = (vec4(7.0, -7.0, 5.0, 5.0));
	block[1].u = (4u);
	block[2].s.a = (ivec3(3, -6, 6));
	block[2].s.b[0] = (ivec2(-2, -3));
	block[2].s.b[1] = (ivec2(-9, -8));
	block[2].s.b[2] = (ivec2(-2, 5));
	block[2].s.b[3] = (ivec2(6, 9));
	block[2].s.c = (vec4(0.0, 3.0, 0.0, 0.0));
	block[2].u = (6u);
}
#version 450
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
layout(std140, binding = 1) buffer Block
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
	allOk = compare_uint((u), 9u) && allOk;
	allOk = compare_mat4x3(t[0].a, mat4x3(4.0, -1.0, 9.0, 0.0, -9.0, 1.0, -2.0, 4.0, -9.0, 9.0, -4.0, 2.0)) && allOk;
	allOk = compare_uvec3((t[0].b[0].a), uvec3(0u, 8u, 2u)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[0]), vec2(1.0, 1.0)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[1]), vec2(8.0, 2.0)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[2]), vec2(-1.0, 1.0)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[3]), vec2(-1.0, 7.0)) && allOk;
	allOk = compare_vec4((t[0].b[0].c), vec4(7.0, -9.0, 1.0, 1.0)) && allOk;
	allOk = compare_uvec3((t[0].b[1].a), uvec3(5u, 2u, 5u)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[0]), vec2(0.0, 9.0)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[1]), vec2(8.0, 5.0)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[2]), vec2(5.0, -7.0)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[3]), vec2(1.0, -9.0)) && allOk;
	allOk = compare_vec4((t[0].b[1].c), vec4(0.0, 7.0, 3.0, -3.0)) && allOk;
	allOk = compare_uvec3((t[0].b[2].a), uvec3(4u, 0u, 6u)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[0]), vec2(-6.0, 0.0)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[1]), vec2(0.0, 7.0)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[2]), vec2(-5.0, -3.0)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[3]), vec2(8.0, -9.0)) && allOk;
	allOk = compare_vec4((t[0].b[2].c), vec4(0.0, -7.0, 0.0, 8.0)) && allOk;
	allOk = compare_int((t[0].c), -9) && allOk;
	allOk = compare_mat4x3(t[1].a, mat4x3(9.0, 7.0, 3.0, -4.0, -7.0, 8.0, -3.0, 3.0, 0.0, 1.0, -6.0, -7.0)) && allOk;
	allOk = compare_uvec3((t[1].b[0].a), uvec3(7u, 5u, 0u)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[0]), vec2(-3.0, -2.0)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[1]), vec2(1.0, -3.0)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[2]), vec2(1.0, 9.0)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[3]), vec2(-6.0, -9.0)) && allOk;
	allOk = compare_vec4((t[1].b[0].c), vec4(-2.0, 9.0, 3.0, -3.0)) && allOk;
	allOk = compare_uvec3((t[1].b[1].a), uvec3(5u, 6u, 5u)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[0]), vec2(0.0, 4.0)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[1]), vec2(-3.0, -5.0)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[2]), vec2(-8.0, -3.0)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[3]), vec2(-8.0, 8.0)) && allOk;
	allOk = compare_vec4((t[1].b[1].c), vec4(-2.0, 4.0, -8.0, 8.0)) && allOk;
	allOk = compare_uvec3((t[1].b[2].a), uvec3(9u, 9u, 0u)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[0]), vec2(-4.0, -5.0)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[1]), vec2(-6.0, -8.0)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[2]), vec2(-4.0, 0.0)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[3]), vec2(5.0, -8.0)) && allOk;
	allOk = compare_vec4((t[1].b[2].c), vec4(-3.0, 5.0, -4.0, -7.0)) && allOk;
	allOk = compare_int((t[1].c), 2) && allOk;
	allOk = compare_mat4x3(t[2].a, mat4x3(-3.0, 4.0, 4.0, -9.0, -3.0, 1.0, 2.0, 4.0, 1.0, -6.0, 6.0, 1.0)) && allOk;
	allOk = compare_uvec3((t[2].b[0].a), uvec3(1u, 9u, 7u)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[0]), vec2(-2.0, -9.0)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[1]), vec2(-1.0, -1.0)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[2]), vec2(2.0, 2.0)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[3]), vec2(2.0, -2.0)) && allOk;
	allOk = compare_vec4((t[2].b[0].c), vec4(4.0, 4.0, 3.0, 1.0)) && allOk;
	allOk = compare_uvec3((t[2].b[1].a), uvec3(8u, 1u, 3u)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[0]), vec2(-6.0, 4.0)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[1]), vec2(-4.0, -1.0)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[2]), vec2(-7.0, -9.0)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[3]), vec2(0.0, -4.0)) && allOk;
	allOk = compare_vec4((t[2].b[1].c), vec4(4.0, 7.0, -8.0, 5.0)) && allOk;
	allOk = compare_uvec3((t[2].b[2].a), uvec3(6u, 9u, 9u)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[0]), vec2(0.0, 3.0)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[1]), vec2(-4.0, 6.0)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[2]), vec2(-6.0, -7.0)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[3]), vec2(5.0, 2.0)) && allOk;
	allOk = compare_vec4((t[2].b[2].c), vec4(8.0, -3.0, -1.0, -8.0)) && allOk;
	allOk = compare_int((t[2].c), 1) && allOk;
	allOk = compare_mat4x3(t[3].a, mat4x3(0.0, -2.0, -9.0, -8.0, -2.0, 3.0, 1.0, -5.0, -3.0, -2.0, -2.0, 2.0)) && allOk;
	allOk = compare_uvec3((t[3].b[0].a), uvec3(5u, 2u, 0u)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[0]), vec2(-3.0, 4.0)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[1]), vec2(-9.0, 4.0)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[2]), vec2(6.0, -7.0)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[3]), vec2(8.0, -8.0)) && allOk;
	allOk = compare_vec4((t[3].b[0].c), vec4(-4.0, 2.0, -2.0, 4.0)) && allOk;
	allOk = compare_uvec3((t[3].b[1].a), uvec3(1u, 3u, 2u)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[0]), vec2(0.0, 1.0)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[1]), vec2(8.0, -6.0)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[2]), vec2(1.0, -6.0)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[3]), vec2(-9.0, 2.0)) && allOk;
	allOk = compare_vec4((t[3].b[1].c), vec4(-9.0, -3.0, 0.0, -5.0)) && allOk;
	allOk = compare_uvec3((t[3].b[2].a), uvec3(0u, 3u, 5u)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[0]), vec2(9.0, 6.0)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[1]), vec2(-5.0, -5.0)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[2]), vec2(5.0, -4.0)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[3]), vec2(3.0, -2.0)) && allOk;
	allOk = compare_vec4((t[3].b[2].c), vec4(-8.0, -3.0, -8.0, 9.0)) && allOk;
	allOk = compare_int((t[3].c), -9) && allOk;
    if (allOk)
        ac_numPassed++;

	s.a = (uvec3(2u, 1u, 3u));
	s.b[0] = (vec2(6.0, -9.0));
	s.b[1] = (vec2(-9.0, -8.0));
	s.b[2] = (vec2(0.0, -1.0));
	s.b[3] = (vec2(-9.0, 2.0));
	s.c = (vec4(-5.0, 6.0, -6.0, -5.0));
	u = (2u);
}
#version 450
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
	highp mat3 var;
} block[3];

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

layout(std140, column_major, binding = 1) buffer Block
{
	highp mat2x3 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(block[0].var, mat2x3(-3.0, 6.0, -6.0, -6.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block[1].var, mat2x3(8.0, 3.0, 1.0, 4.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block[2].var, mat2x3(-7.0, -5.0, -8.0, -7.0, 1.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat2x3(-1.0, -2.0, -5.0, 0.0, 7.0, -2.0));
	block[1].var = (mat2x3(0.0, 9.0, 9.0, 8.0, -6.0, 3.0));
	block[2].var = (mat2x3(-9.0, 0.0, 1.0, 1.0, 7.0, -8.0));
}
#version 450
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
	highp mat3x2 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(block[0].var, mat3x2(-8.0, -5.0, -1.0, 5.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block[1].var, mat3x2(7.0, -5.0, -1.0, -7.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block[2].var, mat3x2(3.0, 7.0, 0.0, 5.0, 0.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec2(-4.0, -6.0));
	block[0].var[1] = (vec2(1.0, -3.0));
	block[0].var[2] = (vec2(-1.0, -9.0));
	block[1].var[0] = (vec2(3.0, -2.0));
	block[1].var[1] = (vec2(5.0, -8.0));
	block[1].var[2] = (vec2(2.0, -9.0));
	block[2].var[0] = (vec2(1.0, -5.0));
	block[2].var[1] = (vec2(0.0, -2.0));
	block[2].var[2] = (vec2(2.0, -1.0));
}
#version 450
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
	highp mat4x2 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block[0].var[0][0], -7.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 1.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 9.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 3.0) && allOk;
	allOk = compare_float(block[0].var[2][0], -9.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -1.0) && allOk;
	allOk = compare_float(block[0].var[3][0], 6.0) && allOk;
	allOk = compare_float(block[0].var[3][1], -3.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(-7.0, 1.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(9.0, 3.0)) && allOk;
	allOk = compare_vec2(block[0].var[2], vec2(-9.0, -1.0)) && allOk;
	allOk = compare_vec2(block[0].var[3], vec2(6.0, -3.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], -9.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 6.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 5.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -8.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 8.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 9.0) && allOk;
	allOk = compare_float(block[1].var[3][0], 1.0) && allOk;
	allOk = compare_float(block[1].var[3][1], -4.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(-9.0, 6.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(5.0, -8.0)) && allOk;
	allOk = compare_vec2(block[1].var[2], vec2(8.0, 9.0)) && allOk;
	allOk = compare_vec2(block[1].var[3], vec2(1.0, -4.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 4.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 1.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -1.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -5.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 5.0) && allOk;
	allOk = compare_float(block[2].var[2][1], -9.0) && allOk;
	allOk = compare_float(block[2].var[3][0], -7.0) && allOk;
	allOk = compare_float(block[2].var[3][1], -2.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(4.0, 1.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(-1.0, -5.0)) && allOk;
	allOk = compare_vec2(block[2].var[2], vec2(5.0, -9.0)) && allOk;
	allOk = compare_vec2(block[2].var[3], vec2(-7.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec2(6.0, -2.0));
	block[0].var[1] = (vec2(2.0, 8.0));
	block[0].var[2] = (vec2(-5.0, 3.0));
	block[0].var[3] = (vec2(-1.0, -7.0));
	block[1].var[0] = (vec2(4.0, 2.0));
	block[1].var[1] = (vec2(-4.0, 8.0));
	block[1].var[2] = (vec2(3.0, 8.0));
	block[1].var[3] = (vec2(-1.0, 6.0));
	block[2].var[0] = (vec2(-8.0, 2.0));
	block[2].var[1] = (vec2(-5.0, 5.0));
	block[2].var[2] = (vec2(-4.0, -9.0));
	block[2].var[3] = (vec2(0.0, 4.0));
}
#version 450
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
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block[0].var[0][0], -2.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 7.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 9.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 1.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -5.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -1.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 3.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 7.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 4.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(-2.0, 7.0, 9.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(1.0, -5.0, -1.0)) && allOk;
	allOk = compare_vec3(block[0].var[2], vec3(3.0, 7.0, 4.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], -8.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -8.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 2.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 7.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -6.0) && allOk;
	allOk = compare_float(block[1].var[1][2], -4.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 7.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -1.0) && allOk;
	allOk = compare_float(block[1].var[2][2], -5.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(-8.0, -8.0, 2.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(7.0, -6.0, -4.0)) && allOk;
	allOk = compare_vec3(block[1].var[2], vec3(7.0, -1.0, -5.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], -2.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 2.0) && allOk;
	allOk = compare_float(block[2].var[0][2], -3.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -3.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 1.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -3.0) && allOk;
	allOk = compare_float(block[2].var[2][0], -8.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 8.0) && allOk;
	allOk = compare_float(block[2].var[2][2], 8.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(-2.0, 2.0, -3.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(-3.0, 1.0, -3.0)) && allOk;
	allOk = compare_vec3(block[2].var[2], vec3(-8.0, 8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat3(-2.0, -7.0, 1.0, 7.0, 5.0, 2.0, 9.0, -1.0, -9.0));
	block[1].var = (mat3(6.0, -5.0, 8.0, -1.0, -8.0, -8.0, 0.0, 9.0, 1.0));
	block[2].var = (mat3(1.0, -4.0, 5.0, -6.0, -1.0, 9.0, -6.0, 0.0, 5.0));
}
#version 450
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
	highp mat3x2 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), -2.0) && allOk;
	allOk = compare_mat3x2(block[0].var, mat3x2(-4.0, -6.0, 5.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_float((block[1].padding), 5.0) && allOk;
	allOk = compare_mat3x2(block[1].var, mat3x2(9.0, -1.0, 4.0, 4.0, -6.0, -2.0)) && allOk;
	allOk = compare_float((block[2].padding), -3.0) && allOk;
	allOk = compare_mat3x2(block[2].var, mat3x2(2.0, 7.0, 6.0, -8.0, -4.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (2.0);
	block[0].var = (mat3x2(-1.0, 2.0, -8.0, -4.0, 9.0, 6.0));
	block[1].padding = (8.0);
	block[1].var = (mat3x2(5.0, -7.0, -7.0, 0.0, 5.0, 8.0));
	block[2].padding = (1.0);
	block[2].var = (mat3x2(-4.0, 1.0, 3.0, 0.0, -6.0, -9.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), -1.0) && allOk;
	allOk = compare_float(block[0].var[0][0], -8.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 2.0) && allOk;
	allOk = compare_float(block[0].var[0][2], -9.0) && allOk;
	allOk = compare_float(block[0].var[0][3], 8.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -1.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -4.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 9.0) && allOk;
	allOk = compare_float(block[0].var[1][3], -5.0) && allOk;
	allOk = compare_float(block[0].var[2][0], -2.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -5.0) && allOk;
	allOk = compare_float(block[0].var[2][2], -5.0) && allOk;
	allOk = compare_float(block[0].var[2][3], 2.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(-8.0, 2.0, -9.0, 8.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(-1.0, -4.0, 9.0, -5.0)) && allOk;
	allOk = compare_vec4(block[0].var[2], vec4(-2.0, -5.0, -5.0, 2.0)) && allOk;
	allOk = compare_float((block[1].padding), 1.0) && allOk;
	allOk = compare_float(block[1].var[0][0], -6.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 9.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -9.0) && allOk;
	allOk = compare_float(block[1].var[0][3], 6.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 9.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -2.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 5.0) && allOk;
	allOk = compare_float(block[1].var[1][3], -2.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 4.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -5.0) && allOk;
	allOk = compare_float(block[1].var[2][2], 3.0) && allOk;
	allOk = compare_float(block[1].var[2][3], 5.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(-6.0, 9.0, -9.0, 6.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(9.0, -2.0, 5.0, -2.0)) && allOk;
	allOk = compare_vec4(block[1].var[2], vec4(4.0, -5.0, 3.0, 5.0)) && allOk;
	allOk = compare_float((block[2].padding), 7.0) && allOk;
	allOk = compare_float(block[2].var[0][0], 8.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -3.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 3.0) && allOk;
	allOk = compare_float(block[2].var[0][3], -3.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 1.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -8.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 4.0) && allOk;
	allOk = compare_float(block[2].var[1][3], -2.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 5.0) && allOk;
	allOk = compare_float(block[2].var[2][1], -6.0) && allOk;
	allOk = compare_float(block[2].var[2][2], -7.0) && allOk;
	allOk = compare_float(block[2].var[2][3], -8.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(8.0, -3.0, 3.0, -3.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(1.0, -8.0, 4.0, -2.0)) && allOk;
	allOk = compare_vec4(block[2].var[2], vec4(5.0, -6.0, -7.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-1.0);
	block[0].var = (mat3x4(-6.0, 0.0, -6.0, 9.0, -5.0, 3.0, -3.0, -2.0, 6.0, 4.0, -6.0, -9.0));
	block[1].padding = (-4.0);
	block[1].var = (mat3x4(2.0, 1.0, 3.0, -2.0, 9.0, -2.0, 3.0, -7.0, 2.0, -4.0, -4.0, -1.0));
	block[2].padding = (4.0);
	block[2].var = (mat3x4(6.0, 0.0, 4.0, -9.0, -2.0, 4.0, -1.0, -5.0, 1.0, -9.0, 5.0, -5.0));
}
#version 450
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
	mediump float b;
	mediump ivec3 c;
	lowp ivec3 d;
	bvec2 e;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((a), vec4(-7.0, 3.0, -2.0, 9.0)) && allOk;
	allOk = compare_float((b), -9.0) && allOk;
	allOk = compare_ivec3((c), ivec3(-1, -9, 1)) && allOk;
	allOk = compare_ivec3((d), ivec3(-8, 6, -5)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (-4.0);
	c = (ivec3(5, -9, 8));
	e = (bvec2(true, false));
}
#version 450
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
	lowp mat3x2 mB;
	mediump mat2 mC;
	lowp mat3x2 mD;
};
struct sB
{
	sA mA;
	lowp mat4 mB;
	lowp mat4 mC;
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	highp mat2 a;
	bvec4 b;
	bool c;
	lowp int d[];
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	mediump uvec3 e[1];
	highp int f[1];
	highp uvec2 g;
	lowp vec2 h;
	mediump mat4x3 i[];
} blockC;
layout(std430, column_major, binding = 3) buffer BlockD
{
	lowp ivec4 j;
	lowp ivec3 k;
	sB l;
	highp int m;
	highp vec4 n;
};
layout(std140, row_major, binding = 4) readonly buffer BlockE
{
	lowp ivec3 o;
	mediump float p;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB.a, mat2(-4.0, 6.0, 6.0, -7.0)) && allOk;
	allOk = compare_bvec4((blockB.b), bvec4(false, false, true, false)) && allOk;
	allOk = compare_uvec3((blockC.e[0]), uvec3(4u, 6u, 4u)) && allOk;
	allOk = compare_int((blockC.f[0]), 2) && allOk;
	allOk = compare_uvec2((blockC.g), uvec2(2u, 3u)) && allOk;
	allOk = compare_ivec4((j), ivec4(5, -7, 1, -8)) && allOk;
	allOk = compare_ivec3((k), ivec3(2, 0, 1)) && allOk;
	allOk = compare_mat4x3(l.mA.mA, mat4x3(8.0, -3.0, 7.0, -6.0, -9.0, -5.0, 6.0, -8.0, -8.0, 3.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat3x2(l.mA.mB, mat3x2(4.0, -1.0, 3.0, -6.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2(l.mA.mC, mat2(2.0, -4.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat3x2(l.mA.mD, mat3x2(5.0, -2.0, 4.0, 0.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4(l.mB, mat4(2.0, 4.0, 7.0, -9.0, -3.0, 0.0, 4.0, -7.0, -1.0, 1.0, 1.0, -7.0, 1.0, -5.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4(l.mC, mat4(-5.0, 5.0, -2.0, -5.0, 9.0, 4.0, 7.0, -1.0, -6.0, 2.0, 0.0, -9.0, 8.0, 3.0, -7.0, -1.0)) && allOk;
	allOk = compare_int((m), 0) && allOk;
	allOk = compare_vec4((n), vec4(-2.0, -9.0, 1.0, 1.0)) && allOk;
	allOk = compare_float((p), -9.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (bvec4(true, false, true, true));
	blockB.c = (true);
	blockB.d[0] = (9);
	blockC.f[0] = (4);
	blockC.g = (uvec2(5u, 1u));
	blockC.h = (vec2(5.0, -2.0));
	blockC.i[0] = (mat4x3(4.0, -6.0, 5.0, -4.0, 9.0, 1.0, 4.0, -5.0, 8.0, -5.0, 4.0, -9.0));
	k = (ivec3(-4, -9, 9));
	l.mA.mA = (mat4x3(-2.0, 3.0, 1.0, -6.0, -2.0, 5.0, -3.0, 4.0, 7.0, -1.0, -2.0, 2.0));
	l.mA.mB = (mat3x2(-2.0, 1.0, 0.0, 2.0, -9.0, 0.0));
	l.mA.mC = (mat2(7.0, -3.0, -5.0, 8.0));
	l.mA.mD = (mat3x2(2.0, 2.0, -2.0, -1.0, 4.0, -3.0));
	l.mB = (mat4(-1.0, -2.0, 2.0, -3.0, -1.0, -6.0, -4.0, 3.0, -8.0, 6.0, 7.0, -3.0, -2.0, -3.0, 0.0, 7.0));
	l.mC = (mat4(3.0, -1.0, -9.0, 0.0, 3.0, -4.0, -5.0, 0.0, 2.0, -2.0, -7.0, -2.0, -2.0, -8.0, 1.0, 1.0));
}
#version 450
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
	highp mat4x3 a[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.a[0], mat4x3(-9.0, 5.0, -2.0, 9.0, 5.0, -9.0, 2.0, 5.0, 1.0, 0.0, -5.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat4x3(-9.0, -3.0, 1.0, -3.0, 9.0, 8.0, 8.0, -5.0, 6.0, 0.0, 2.0, 2.0));
}
#version 450
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
	mediump float mB;
	mediump uvec3 mC;
};
struct sB
{
	lowp mat3x4 mA[7];
	lowp mat4 mB;
	lowp vec2 mC;
	lowp mat3x4 mD;
};
layout(std140, binding = 1) buffer BlockB
{
	lowp vec2 a;
	sA b;
	bvec3 c[];
} blockB[2];
layout(std140, binding = 2) buffer BlockC
{
	sB d[2];
	mediump vec2 e[];
} blockC;
layout(std430, column_major, binding = 3) buffer BlockD
{
	highp float f;
	lowp vec3 g;
	highp vec3 h[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB[0].a), vec2(8.0, 0.0)) && allOk;
	allOk = compare_bvec3((blockB[0].c[0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((blockB[0].c[1]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockB[0].c[2]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((blockB[0].c[3]), bvec3(true, true, false)) && allOk;
	allOk = compare_vec2((blockB[1].a), vec2(-3.0, -5.0)) && allOk;
	allOk = compare_bvec3((blockB[1].c[0]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockB[1].c[1]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockB[1].c[2]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((blockB[1].c[3]), bvec3(true, true, true)) && allOk;
	allOk = compare_mat3x4(blockC.d[0].mA[0], mat3x4(5.0, -8.0, 5.0, 7.0, -2.0, -8.0, -3.0, -5.0, 7.0, 2.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x4(blockC.d[0].mA[1], mat3x4(-6.0, -5.0, 6.0, -3.0, 9.0, -8.0, -5.0, -6.0, -1.0, 3.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x4(blockC.d[0].mA[2], mat3x4(1.0, -3.0, 6.0, 0.0, 4.0, 8.0, -6.0, 9.0, 9.0, 9.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat3x4(blockC.d[0].mA[3], mat3x4(-5.0, 8.0, 3.0, -1.0, -6.0, -6.0, 7.0, 6.0, -8.0, -6.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(blockC.d[0].mA[4], mat3x4(5.0, -2.0, 1.0, 1.0, 8.0, 0.0, -6.0, -3.0, -5.0, 4.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3x4(blockC.d[0].mA[5], mat3x4(4.0, -4.0, -4.0, 6.0, -9.0, 5.0, -8.0, 6.0, -4.0, -1.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat3x4(blockC.d[0].mA[6], mat3x4(9.0, -5.0, -6.0, -7.0, -2.0, 9.0, -5.0, -4.0, -2.0, 0.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat4(blockC.d[0].mB, mat4(4.0, -9.0, 1.0, 1.0, 1.0, -8.0, 2.0, 5.0, -7.0, -1.0, 4.0, 7.0, -2.0, 9.0, 7.0, 5.0)) && allOk;
	allOk = compare_vec2((blockC.d[0].mC), vec2(-1.0, 9.0)) && allOk;
	allOk = compare_mat3x4(blockC.d[0].mD, mat3x4(3.0, 8.0, -5.0, -4.0, 0.0, 0.0, 0.0, 3.0, 8.0, -9.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat3x4(blockC.d[1].mA[0], mat3x4(-1.0, -2.0, -1.0, -8.0, -4.0, -9.0, -4.0, -7.0, 5.0, -9.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat3x4(blockC.d[1].mA[1], mat3x4(-6.0, -8.0, -6.0, -7.0, -5.0, -3.0, 6.0, -3.0, 7.0, 0.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3x4(blockC.d[1].mA[2], mat3x4(-6.0, 5.0, -5.0, -9.0, -4.0, 4.0, 2.0, 4.0, 1.0, 1.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x4(blockC.d[1].mA[3], mat3x4(5.0, 0.0, -9.0, 0.0, 0.0, -1.0, 3.0, -4.0, -6.0, 4.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3x4(blockC.d[1].mA[4], mat3x4(0.0, -5.0, 1.0, 9.0, 2.0, 4.0, -7.0, 0.0, -3.0, 2.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(blockC.d[1].mA[5], mat3x4(4.0, -9.0, 2.0, -8.0, -9.0, 7.0, -3.0, 8.0, -4.0, 9.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat3x4(blockC.d[1].mA[6], mat3x4(-5.0, -1.0, 7.0, -8.0, -7.0, 2.0, 2.0, 7.0, -7.0, -4.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat4(blockC.d[1].mB, mat4(9.0, -7.0, -2.0, -5.0, -6.0, 1.0, -8.0, 6.0, -8.0, -2.0, 9.0, -8.0, 5.0, 0.0, 3.0, -1.0)) && allOk;
	allOk = compare_vec2((blockC.d[1].mC), vec2(6.0, -1.0)) && allOk;
	allOk = compare_mat3x4(blockC.d[1].mD, mat3x4(2.0, 3.0, 8.0, -6.0, 1.0, 5.0, 4.0, -8.0, 1.0, -8.0, -9.0, 2.0)) && allOk;
	allOk = compare_vec2((blockC.e[0]), vec2(4.0, -9.0)) && allOk;
	allOk = compare_vec2((blockC.e[1]), vec2(2.0, -3.0)) && allOk;
	allOk = compare_vec2((blockC.e[2]), vec2(9.0, -5.0)) && allOk;
	allOk = compare_vec3((g), vec3(0.0, 5.0, 0.0)) && allOk;
	allOk = compare_vec3((h[0]), vec3(-4.0, -8.0, -4.0)) && allOk;
	allOk = compare_vec3((h[1]), vec3(0.0, 7.0, 5.0)) && allOk;
	allOk = compare_vec3((h[2]), vec3(-8.0, 6.0, -5.0)) && allOk;
	allOk = compare_vec3((h[3]), vec3(2.0, 2.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (vec2(5.0, -4.0));
	blockB[1].a = (vec2(1.0, -3.0));
	blockC.d[0].mA[0] = (mat3x4(3.0, 9.0, -5.0, 6.0, 1.0, 6.0, 6.0, 6.0, 5.0, -2.0, -6.0, 7.0));
	blockC.d[0].mA[1] = (mat3x4(1.0, -1.0, 9.0, 2.0, 3.0, 5.0, 0.0, -8.0, 8.0, 2.0, -1.0, 8.0));
	blockC.d[0].mA[2] = (mat3x4(8.0, 2.0, 1.0, 8.0, -3.0, -7.0, 9.0, 2.0, -7.0, -3.0, 8.0, -6.0));
	blockC.d[0].mA[3] = (mat3x4(3.0, -1.0, -9.0, 3.0, 8.0, 3.0, 2.0, -6.0, 4.0, 7.0, 8.0, -3.0));
	blockC.d[0].mA[4] = (mat3x4(-4.0, -2.0, 5.0, -8.0, -2.0, -1.0, -7.0, -3.0, -5.0, -4.0, 2.0, 7.0));
	blockC.d[0].mA[5] = (mat3x4(-4.0, 7.0, -1.0, 5.0, 9.0, 2.0, -7.0, 7.0, 3.0, -9.0, -7.0, -1.0));
	blockC.d[0].mA[6] = (mat3x4(-8.0, 4.0, -1.0, 2.0, -2.0, 2.0, 9.0, 0.0, -8.0, -9.0, 5.0, 2.0));
	blockC.d[0].mB = (mat4(3.0, 8.0, 9.0, -3.0, 5.0, -9.0, -6.0, 7.0, -6.0, 3.0, 1.0, -1.0, -1.0, -3.0, 5.0, 0.0));
	blockC.d[0].mC = (vec2(0.0, -5.0));
	blockC.d[0].mD = (mat3x4(-9.0, -3.0, -2.0, -9.0, -4.0, 3.0, -4.0, 2.0, -8.0, 8.0, -3.0, 7.0));
	blockC.d[1].mA[0] = (mat3x4(4.0, 8.0, 8.0, 5.0, 5.0, -7.0, 8.0, -3.0, -2.0, 6.0, 7.0, -2.0));
	blockC.d[1].mA[1] = (mat3x4(-8.0, -9.0, -6.0, 9.0, 9.0, 7.0, 3.0, 1.0, 5.0, -9.0, 6.0, 9.0));
	blockC.d[1].mA[2] = (mat3x4(-2.0, 0.0, 7.0, -3.0, -3.0, -1.0, 0.0, 8.0, -7.0, 5.0, 6.0, 0.0));
	blockC.d[1].mA[3] = (mat3x4(6.0, 1.0, -5.0, 1.0, 5.0, 4.0, -4.0, 5.0, 1.0, -3.0, 7.0, -7.0));
	blockC.d[1].mA[4] = (mat3x4(9.0, 4.0, 9.0, -3.0, -7.0, 0.0, 8.0, 4.0, -9.0, 5.0, -1.0, 0.0));
	blockC.d[1].mA[5] = (mat3x4(2.0, -5.0, 6.0, 7.0, -1.0, 4.0, -6.0, 3.0, 9.0, 5.0, 9.0, 2.0));
	blockC.d[1].mA[6] = (mat3x4(-6.0, -2.0, -7.0, 0.0, -4.0, 0.0, 8.0, -4.0, 8.0, 2.0, -8.0, -6.0));
	blockC.d[1].mB = (mat4(1.0, -5.0, 1.0, 5.0, 1.0, 3.0, 7.0, 2.0, 7.0, -5.0, -6.0, 6.0, 3.0, 4.0, 3.0, 8.0));
	blockC.d[1].mC = (vec2(-3.0, 9.0));
	blockC.d[1].mD = (mat3x4(8.0, -9.0, 2.0, -5.0, -5.0, 1.0, -1.0, -9.0, -3.0, -6.0, 7.0, -4.0));
	g = (vec3(-2.0, -4.0, 6.0));
}
#version 450
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
	layout(offset = 0) lowp uint a[1];
	layout(offset = 4) highp int b;
	layout(offset = 16) highp uvec3 c;
	layout(offset = 32) mediump vec2 d;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump uint e;
	layout(offset = 16) mediump vec4 f;
	layout(offset = 32) lowp uvec2 g;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.c), uvec3(7u, 1u, 6u)) && allOk;
	allOk = compare_uint((e), 9u) && allOk;
	allOk = compare_vec4((f), vec4(8.0, 4.0, -4.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (9u);
	blockB.b = (0);
	blockB.d = (vec2(-7.0, -4.0));
	f = (vec4(-6.0, -5.0, -2.0, 4.0));
	g = (uvec2(4u, 6u));
}
#version 450
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
	layout(offset = 0) bvec3 a;
} blockB;

bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.a), bvec3(true, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec3(true, false, true));
}
#version 450
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
	bool a;
	highp vec2 b[4];
	mediump uvec3 c;
	bvec4 d;
	lowp ivec2 e[];
} blockB[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB[0].c), uvec3(5u, 9u, 6u)) && allOk;
	allOk = compare_bvec4((blockB[0].d), bvec4(false, false, true, false)) && allOk;
	allOk = compare_uvec3((blockB[1].c), uvec3(9u, 9u, 6u)) && allOk;
	allOk = compare_bvec4((blockB[1].d), bvec4(false, true, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (true);
	blockB[0].b[0] = (vec2(-5.0, -5.0));
	blockB[0].b[1] = (vec2(8.0, -6.0));
	blockB[0].b[2] = (vec2(-1.0, -8.0));
	blockB[0].b[3] = (vec2(-8.0, -6.0));
	blockB[0].c = (uvec3(6u, 9u, 4u));
	blockB[0].d = (bvec4(true, true, false, true));
	blockB[1].a = (true);
	blockB[1].b[0] = (vec2(0.0, -2.0));
	blockB[1].b[1] = (vec2(-6.0, 1.0));
	blockB[1].b[2] = (vec2(-1.0, -5.0));
	blockB[1].b[3] = (vec2(4.0, -5.0));
	blockB[1].c = (uvec3(8u, 2u, 8u));
	blockB[1].d = (bvec4(true, false, true, true));
}
#version 450
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
	lowp mat3x2 a[];
} blockB[1];
layout(scalar, binding = 2) buffer BlockC
{
	mediump vec2 b;
	mediump mat3x4 c[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(c[0], mat3x4(0.0, 0.0, 3.0, 9.0, 4.0, -7.0, -3.0, -1.0, -5.0, -8.0, -1.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (mat3x2(-5.0, 5.0, -3.0, 3.0, 2.0, 7.0));
	blockB[0].a[1] = (mat3x2(5.0, 9.0, -8.0, -3.0, 9.0, 6.0));
	b = (vec2(7.0, 3.0));
	c[0] = (mat3x4(-7.0, 0.0, -4.0, 2.0, 7.0, -3.0, -9.0, -2.0, 5.0, 4.0, -6.0, 2.0));
}
#version 450
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
	highp mat4x3 a;
	mediump mat4x3 b[1];
	highp mat3x2 c;
	highp uvec3 d;
	bool e;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB[nonuniformEXT(0)].a, mat4x3(6.0, 8.0, 4.0, -9.0, -4.0, 4.0, 0.0, 7.0, 2.0, -8.0, 2.0, -3.0)) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(0)].e), true) && allOk;
	allOk = compare_mat4x3(blockB[nonuniformEXT(1)].a, mat4x3(4.0, -1.0, 6.0, 1.0, -9.0, 3.0, 3.0, 8.0, -2.0, -3.0, -6.0, 0.0)) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(1)].e), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b[0] = (mat4x3(-6.0, 0.0, -8.0, -3.0, -7.0, 1.0, 0.0, 1.0, -4.0, 2.0, -7.0, -7.0));
	blockB[nonuniformEXT(0)].d = (uvec3(0u, 1u, 5u));
	blockB[nonuniformEXT(0)].e = (false);
	blockB[nonuniformEXT(1)].b[0] = (mat4x3(6.0, 9.0, -8.0, -3.0, -4.0, 5.0, -3.0, -2.0, 9.0, 3.0, -1.0, 3.0));
	blockB[nonuniformEXT(1)].d = (uvec3(6u, 9u, 0u));
	blockB[nonuniformEXT(1)].e = (true);
}
#version 450
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
	float16_t a;
	lowp float b;
	u16vec4 c;
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	i16vec3 d;
	mediump mat4x2 e;
} blockC;
layout(std140, row_major, binding = 3) buffer BlockD
{
	mediump uint f;
	mediump uvec2 g;
	i16vec4 h[6];
	bvec4 i[5];
} blockD;
layout(std430, binding = 4) readonly buffer BlockE
{
	highp int j;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockB.a), 2.0) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.c), uvec4(7u, 6u, 2u, 4u)) && allOk;
	allOk = compare_i16vec3(ivec3(blockC.d), ivec3(4, 5, 3)) && allOk;
	allOk = compare_mat4x2(blockC.e, mat4x2(7.0, 5.0, 1.0, -2.0, 6.0, 3.0, -6.0, -9.0)) && allOk;
	allOk = compare_uint((blockD.f), 7u) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.h[0]), ivec4(8, -6, 2, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.h[1]), ivec4(-8, 9, -9, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.h[2]), ivec4(-6, -5, -9, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.h[3]), ivec4(-5, 3, 0, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.h[4]), ivec4(8, -9, -4, 1)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.h[5]), ivec4(1, -4, -5, -1)) && allOk;
	allOk = compare_int((j), -5) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = float16_t(-1.0);
	blockB.b = (-4.0);
	blockB.c = u16vec4(uvec4(2u, 8u, 3u, 2u));
	blockC.d = i16vec3(ivec3(-5, 7, -5));
	blockC.e = (mat4x2(5.0, -3.0, 4.0, -8.0, 9.0, -2.0, 5.0, -1.0));
	blockD.f = (7u);
	blockD.h[0] = i16vec4(ivec4(-2, 9, -6, 3));
	blockD.h[1] = i16vec4(ivec4(5, 5, 9, 3));
	blockD.h[2] = i16vec4(ivec4(-9, -1, -5, -8));
	blockD.h[3] = i16vec4(ivec4(3, 0, -6, -8));
	blockD.h[4] = i16vec4(ivec4(-3, 8, 2, -4));
	blockD.h[5] = i16vec4(ivec4(6, 9, 9, -1));
	blockD.i[0] = (bvec4(true, false, true, true));
	blockD.i[1] = (bvec4(true, true, false, false));
	blockD.i[2] = (bvec4(false, true, true, true));
	blockD.i[3] = (bvec4(true, false, false, false));
	blockD.i[4] = (bvec4(true, true, true, true));
}
#version 450
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
	f16vec3 a;
	lowp mat2 b;
	lowp vec4 c;
	u16vec4 d[];
} blockB[3];
layout(std430, row_major, binding = 2) buffer BlockC
{
	lowp mat2 e;
	highp ivec3 f;
	u16vec2 g[5];
	mediump mat4 h[];
} blockC[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockC[0].f), ivec3(6, 2, -9)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[0].g[0]), uvec2(7u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[0].g[1]), uvec2(7u, 0u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[0].g[2]), uvec2(2u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[0].g[3]), uvec2(3u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[0].g[4]), uvec2(7u, 0u)) && allOk;
	allOk = compare_mat4(blockC[0].h[0], mat4(-8.0, 9.0, 6.0, 3.0, 8.0, -9.0, -4.0, 3.0, 4.0, -6.0, 7.0, 3.0, 4.0, 7.0, -1.0, 0.0)) && allOk;
	allOk = compare_ivec3((blockC[1].f), ivec3(5, -5, -9)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[1].g[0]), uvec2(9u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[1].g[1]), uvec2(0u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[1].g[2]), uvec2(3u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[1].g[3]), uvec2(0u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[1].g[4]), uvec2(2u, 9u)) && allOk;
	allOk = compare_mat4(blockC[1].h[0], mat4(-1.0, 0.0, 0.0, -6.0, 4.0, -1.0, 6.0, 8.0, -6.0, -6.0, -9.0, 2.0, 3.0, 5.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat4(blockC[1].h[1], mat4(-3.0, -9.0, -3.0, 2.0, 4.0, -3.0, 8.0, 1.0, -7.0, 8.0, -7.0, -5.0, -7.0, -1.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat4(blockC[1].h[2], mat4(2.0, 1.0, 4.0, 7.0, 3.0, -2.0, 3.0, -5.0, 9.0, -4.0, -8.0, 0.0, 4.0, 2.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4(blockC[1].h[3], mat4(3.0, -7.0, 9.0, 5.0, -2.0, -3.0, -1.0, 9.0, -7.0, -8.0, 1.0, -9.0, -6.0, 8.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat4(blockC[1].h[4], mat4(1.0, -2.0, -4.0, -9.0, 7.0, 6.0, -3.0, -7.0, -6.0, -9.0, -9.0, -8.0, 7.0, -5.0, -6.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (mat2(0.0, -6.0, 6.0, -6.0));
	blockB[0].c = (vec4(3.0, -7.0, 8.0, 5.0));
	blockB[1].b = (mat2(-5.0, 2.0, -2.0, 8.0));
	blockB[1].c = (vec4(-1.0, -1.0, 1.0, 7.0));
	blockB[2].b = (mat2(-1.0, -8.0, -7.0, 8.0));
	blockB[2].c = (vec4(2.0, 8.0, -1.0, -1.0));
	blockC[0].e = (mat2(-9.0, 5.0, 7.0, -7.0));
	blockC[0].f = (ivec3(5, -3, -4));
	blockC[0].g[0] = u16vec2(uvec2(7u, 1u));
	blockC[0].g[1] = u16vec2(uvec2(1u, 0u));
	blockC[0].g[2] = u16vec2(uvec2(2u, 0u));
	blockC[0].g[3] = u16vec2(uvec2(0u, 3u));
	blockC[0].g[4] = u16vec2(uvec2(2u, 0u));
	blockC[0].h[0] = (mat4(-2.0, 7.0, -7.0, 1.0, 8.0, -4.0, -1.0, 0.0, 2.0, -2.0, 8.0, 0.0, -1.0, 7.0, 0.0, 4.0));
	blockC[1].e = (mat2(4.0, 7.0, 2.0, 2.0));
	blockC[1].f = (ivec3(5, 2, -5));
	blockC[1].g[0] = u16vec2(uvec2(8u, 0u));
	blockC[1].g[1] = u16vec2(uvec2(4u, 1u));
	blockC[1].g[2] = u16vec2(uvec2(4u, 6u));
	blockC[1].g[3] = u16vec2(uvec2(8u, 2u));
	blockC[1].g[4] = u16vec2(uvec2(9u, 2u));
	blockC[1].h[0] = (mat4(-3.0, 2.0, 3.0, 0.0, -6.0, 9.0, -4.0, 8.0, -2.0, -3.0, 9.0, -2.0, 5.0, -4.0, -8.0, 7.0));
	blockC[1].h[1] = (mat4(-8.0, -1.0, 6.0, 3.0, 6.0, 4.0, -7.0, -4.0, -5.0, 7.0, 4.0, 8.0, -6.0, 4.0, -9.0, 1.0));
	blockC[1].h[2] = (mat4(-4.0, -6.0, 4.0, -1.0, 4.0, -5.0, -9.0, -3.0, 1.0, -3.0, 4.0, 4.0, 8.0, -7.0, -2.0, 6.0));
	blockC[1].h[3] = (mat4(8.0, 9.0, -1.0, -7.0, 1.0, 9.0, 6.0, -2.0, 9.0, -5.0, 9.0, -4.0, 7.0, -8.0, -1.0, 4.0));
	blockC[1].h[4] = (mat4(7.0, 8.0, -1.0, -1.0, 0.0, -8.0, 1.0, 3.0, 6.0, -5.0, -3.0, 1.0, -8.0, 6.0, 9.0, -1.0));
}
#version 450
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
	u16vec3 a;
	uint16_t b;
	mediump mat3 c;
	f16vec4 d;
} blockB[1];
layout(std430, row_major, binding = 2) buffer BlockC
{
	bvec2 e[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(blockB[0].a), uvec3(8u, 2u, 7u)) && allOk;
	allOk = compare_f16vec4(vec4(blockB[0].d), vec4(-7.0, 9.0, -3.0, -8.0)) && allOk;
	allOk = compare_bvec2((e[0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((e[1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((e[2]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((e[3]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((e[4]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((e[5]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((e[6]), bvec2(false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = u16vec3(uvec3(9u, 2u, 1u));
	blockB[0].b = uint16_t(0u);
	blockB[0].c = (mat3(1.0, -4.0, -2.0, -7.0, -6.0, 4.0, -4.0, -5.0, -2.0));
	blockB[0].d = f16vec4(vec4(5.0, -9.0, -3.0, -1.0));
	e[0] = (bvec2(true, false));
	e[1] = (bvec2(false, false));
	e[2] = (bvec2(false, false));
	e[3] = (bvec2(true, false));
	e[4] = (bvec2(false, true));
	e[5] = (bvec2(false, true));
	e[6] = (bvec2(true, true));
}
#version 450
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
	u16vec2 mA;
	mediump mat3x2 mB;
	lowp mat2x3 mC;
};
struct sB
{
	bool mA;
	highp vec3 mB;
};
struct sC
{
	i16vec3 mA;
	sB mB;
	mediump mat4x2 mC;
	lowp ivec2 mD;
};
layout(std430, binding = 1) buffer BlockB
{
	mediump mat3x2 a;
	sA b;
	u16vec4 c;
	bvec4 d;
	float16_t e[];
} blockB[2];
layout(std430, column_major, binding = 2) buffer BlockC
{
	i16vec3 f;
	lowp mat2x3 g;
	f16vec4 h;
	highp mat2x3 i[][8][3];
} blockC[1];
layout(std140, row_major, binding = 3) buffer BlockD
{
	highp vec2 j;
	sC k[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB[0].a, mat3x2(-1.0, -5.0, -9.0, -9.0, -9.0, 0.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB[0].c), uvec4(8u, 1u, 9u, 3u)) && allOk;
	allOk = compare_bvec4((blockB[0].d), bvec4(false, false, false, false)) && allOk;
	allOk = compare_float16_t(float(blockB[0].e[0]), 4.0) && allOk;
	allOk = compare_float16_t(float(blockB[0].e[1]), -5.0) && allOk;
	allOk = compare_mat3x2(blockB[1].a, mat3x2(3.0, 0.0, -7.0, 8.0, -7.0, -8.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB[1].c), uvec4(1u, 1u, 2u, 8u)) && allOk;
	allOk = compare_bvec4((blockB[1].d), bvec4(false, false, true, true)) && allOk;
	allOk = compare_float16_t(float(blockB[1].e[0]), 4.0) && allOk;
	allOk = compare_i16vec3(ivec3(blockC[0].f), ivec3(7, -9, -2)) && allOk;
	allOk = compare_mat2x3(blockC[0].g, mat2x3(2.0, 0.0, 1.0, -6.0, -7.0, -2.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[0].h), vec4(-3.0, 0.0, 3.0, 4.0)) && allOk;
	allOk = compare_vec2((j), vec2(1.0, -8.0)) && allOk;
	allOk = compare_i16vec3(ivec3(k[0].mA), ivec3(-1, -2, 8)) && allOk;
	allOk = compare_bool((k[0].mB.mA), false) && allOk;
	allOk = compare_vec3((k[0].mB.mB), vec3(0.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x2(k[0].mC, mat4x2(-3.0, -3.0, 0.0, -1.0, 5.0, -1.0, 8.0, -4.0)) && allOk;
	allOk = compare_ivec2((k[0].mD), ivec2(2, 9)) && allOk;
	allOk = compare_i16vec3(ivec3(k[1].mA), ivec3(-8, 5, -8)) && allOk;
	allOk = compare_bool((k[1].mB.mA), true) && allOk;
	allOk = compare_vec3((k[1].mB.mB), vec3(2.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat4x2(k[1].mC, mat4x2(1.0, -2.0, 3.0, 2.0, -2.0, -5.0, -9.0, -6.0)) && allOk;
	allOk = compare_ivec2((k[1].mD), ivec2(-5, 4)) && allOk;
	allOk = compare_i16vec3(ivec3(k[2].mA), ivec3(-8, 2, -8)) && allOk;
	allOk = compare_bool((k[2].mB.mA), false) && allOk;
	allOk = compare_vec3((k[2].mB.mB), vec3(-8.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat4x2(k[2].mC, mat4x2(-9.0, -7.0, 8.0, -7.0, 8.0, 7.0, -7.0, 0.0)) && allOk;
	allOk = compare_ivec2((k[2].mD), ivec2(-9, -2)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (mat3x2(0.0, -7.0, -2.0, -6.0, 0.0, 4.0));
	blockB[0].b.mA = u16vec2(uvec2(5u, 5u));
	blockB[0].b.mB = (mat3x2(-3.0, 4.0, 9.0, 1.0, -6.0, 4.0));
	blockB[0].b.mC = (mat2x3(-7.0, 9.0, 7.0, -4.0, -8.0, -7.0));
	blockB[0].c = u16vec4(uvec4(9u, 5u, 4u, 1u));
	blockB[0].d = (bvec4(false, false, false, false));
	blockB[0].e[0] = float16_t(-4.0);
	blockB[0].e[1] = float16_t(-3.0);
	blockB[1].a = (mat3x2(-3.0, 9.0, -8.0, 0.0, -4.0, -2.0));
	blockB[1].b.mA = u16vec2(uvec2(6u, 5u));
	blockB[1].b.mB = (mat3x2(-1.0, -7.0, 9.0, 3.0, -6.0, 9.0));
	blockB[1].b.mC = (mat2x3(0.0, 5.0, -4.0, 6.0, -8.0, 4.0));
	blockB[1].c = u16vec4(uvec4(7u, 3u, 3u, 6u));
	blockB[1].d = (bvec4(true, false, true, false));
	blockB[1].e[0] = float16_t(9.0);
	blockC[0].g = (mat2x3(-5.0, 5.0, 7.0, 9.0, 1.0, 4.0));
	blockC[0].i[0][0][0] = (mat2x3(-2.0, 2.0, 5.0, 4.0, 3.0, -9.0));
	blockC[0].i[0][0][1] = (mat2x3(-8.0, 2.0, 7.0, -5.0, -4.0, 9.0));
	blockC[0].i[0][0][2] = (mat2x3(9.0, -3.0, -1.0, -7.0, -1.0, 7.0));
	blockC[0].i[0][1][0] = (mat2x3(3.0, -2.0, 5.0, -5.0, -1.0, -1.0));
	blockC[0].i[0][1][1] = (mat2x3(-5.0, 8.0, -6.0, 2.0, 6.0, 6.0));
	blockC[0].i[0][1][2] = (mat2x3(-1.0, 3.0, -6.0, 7.0, -2.0, 3.0));
	blockC[0].i[0][2][0] = (mat2x3(2.0, 9.0, 6.0, -8.0, 2.0, -2.0));
	blockC[0].i[0][2][1] = (mat2x3(3.0, -5.0, -4.0, 0.0, 1.0, 9.0));
	blockC[0].i[0][2][2] = (mat2x3(-9.0, 4.0, -8.0, -9.0, -4.0, 3.0));
	blockC[0].i[0][3][0] = (mat2x3(8.0, 0.0, 4.0, 4.0, 8.0, 8.0));
	blockC[0].i[0][3][1] = (mat2x3(2.0, 9.0, -5.0, -2.0, 7.0, -8.0));
	blockC[0].i[0][3][2] = (mat2x3(-6.0, -8.0, 1.0, 3.0, 3.0, 4.0));
	blockC[0].i[0][4][0] = (mat2x3(5.0, -3.0, 3.0, 6.0, -3.0, 6.0));
	blockC[0].i[0][4][1] = (mat2x3(-6.0, 4.0, 2.0, -4.0, -1.0, 0.0));
	blockC[0].i[0][4][2] = (mat2x3(-8.0, 8.0, 4.0, 8.0, 8.0, -1.0));
	blockC[0].i[0][5][0] = (mat2x3(0.0, 9.0, -1.0, 8.0, -3.0, -9.0));
	blockC[0].i[0][5][1] = (mat2x3(9.0, 5.0, 4.0, 8.0, -1.0, -9.0));
	blockC[0].i[0][5][2] = (mat2x3(3.0, -9.0, -5.0, 3.0, -5.0, 5.0));
	blockC[0].i[0][6][0] = (mat2x3(-5.0, -1.0, 1.0, 8.0, 5.0, 5.0));
	blockC[0].i[0][6][1] = (mat2x3(6.0, -2.0, -7.0, 5.0, 4.0, -2.0));
	blockC[0].i[0][6][2] = (mat2x3(0.0, 1.0, -8.0, 8.0, -7.0, -7.0));
	blockC[0].i[0][7][0] = (mat2x3(-2.0, 7.0, -2.0, 3.0, 8.0, -9.0));
	blockC[0].i[0][7][1] = (mat2x3(9.0, 8.0, 5.0, 5.0, 1.0, -1.0));
	blockC[0].i[0][7][2] = (mat2x3(9.0, -8.0, 5.0, 4.0, -4.0, 2.0));
	blockC[0].i[1][0][0] = (mat2x3(5.0, 1.0, -3.0, -7.0, 6.0, -3.0));
	blockC[0].i[1][0][1] = (mat2x3(3.0, -5.0, 2.0, -6.0, 8.0, -3.0));
	blockC[0].i[1][0][2] = (mat2x3(-2.0, 4.0, -8.0, -5.0, 2.0, -9.0));
	blockC[0].i[1][1][0] = (mat2x3(-5.0, 8.0, 5.0, -9.0, 5.0, 4.0));
	blockC[0].i[1][1][1] = (mat2x3(-5.0, -8.0, 6.0, 2.0, 5.0, 7.0));
	blockC[0].i[1][1][2] = (mat2x3(3.0, 7.0, -7.0, 3.0, -2.0, 1.0));
	blockC[0].i[1][2][0] = (mat2x3(-8.0, -7.0, 5.0, 6.0, 6.0, -4.0));
	blockC[0].i[1][2][1] = (mat2x3(0.0, -1.0, -5.0, -4.0, 1.0, 8.0));
	blockC[0].i[1][2][2] = (mat2x3(7.0, 9.0, 4.0, 2.0, 8.0, -2.0));
	blockC[0].i[1][3][0] = (mat2x3(4.0, -5.0, 8.0, 3.0, -8.0, 4.0));
	blockC[0].i[1][3][1] = (mat2x3(-6.0, 3.0, 4.0, 5.0, 0.0, 5.0));
	blockC[0].i[1][3][2] = (mat2x3(-8.0, 4.0, -1.0, -2.0, -6.0, 5.0));
	blockC[0].i[1][4][0] = (mat2x3(3.0, -6.0, -8.0, -2.0, 3.0, -2.0));
	blockC[0].i[1][4][1] = (mat2x3(-7.0, -8.0, 9.0, -7.0, -7.0, -2.0));
	blockC[0].i[1][4][2] = (mat2x3(7.0, -9.0, 2.0, -6.0, -8.0, 1.0));
	blockC[0].i[1][5][0] = (mat2x3(8.0, -6.0, -5.0, -3.0, -7.0, 4.0));
	blockC[0].i[1][5][1] = (mat2x3(3.0, -8.0, -1.0, -2.0, 2.0, 5.0));
	blockC[0].i[1][5][2] = (mat2x3(-9.0, -5.0, 1.0, 9.0, 5.0, 3.0));
	blockC[0].i[1][6][0] = (mat2x3(-4.0, 3.0, -6.0, 9.0, 2.0, -3.0));
	blockC[0].i[1][6][1] = (mat2x3(-2.0, 2.0, 0.0, -6.0, 4.0, -6.0));
	blockC[0].i[1][6][2] = (mat2x3(3.0, 0.0, -7.0, 4.0, 4.0, 8.0));
	blockC[0].i[1][7][0] = (mat2x3(7.0, -6.0, 8.0, -6.0, -8.0, -7.0));
	blockC[0].i[1][7][1] = (mat2x3(7.0, 9.0, -3.0, -5.0, -6.0, 6.0));
	blockC[0].i[1][7][2] = (mat2x3(-5.0, 3.0, 1.0, 6.0, 7.0, -9.0));
	blockC[0].i[2][0][0] = (mat2x3(-7.0, 9.0, -1.0, 9.0, 7.0, 3.0));
	blockC[0].i[2][0][1] = (mat2x3(-7.0, 1.0, 2.0, 8.0, 1.0, -9.0));
	blockC[0].i[2][0][2] = (mat2x3(5.0, -7.0, -9.0, -4.0, 8.0, 0.0));
	blockC[0].i[2][1][0] = (mat2x3(-2.0, 3.0, 5.0, 0.0, 0.0, -7.0));
	blockC[0].i[2][1][1] = (mat2x3(-7.0, -9.0, 1.0, 8.0, -5.0, -1.0));
	blockC[0].i[2][1][2] = (mat2x3(-6.0, -9.0, 2.0, -8.0, 4.0, -1.0));
	blockC[0].i[2][2][0] = (mat2x3(4.0, -2.0, 4.0, 5.0, 5.0, -6.0));
	blockC[0].i[2][2][1] = (mat2x3(-9.0, -5.0, 2.0, -8.0, -3.0, -6.0));
	blockC[0].i[2][2][2] = (mat2x3(-9.0, -9.0, -5.0, 8.0, 6.0, 2.0));
	blockC[0].i[2][3][0] = (mat2x3(-5.0, 6.0, -8.0, 4.0, -4.0, -6.0));
	blockC[0].i[2][3][1] = (mat2x3(-1.0, -1.0, 6.0, -3.0, -3.0, -5.0));
	blockC[0].i[2][3][2] = (mat2x3(8.0, -2.0, -7.0, -1.0, -4.0, 0.0));
	blockC[0].i[2][4][0] = (mat2x3(-9.0, 9.0, -9.0, 1.0, -8.0, 8.0));
	blockC[0].i[2][4][1] = (mat2x3(9.0, -8.0, 9.0, -1.0, 9.0, -5.0));
	blockC[0].i[2][4][2] = (mat2x3(-9.0, -5.0, -2.0, 1.0, -2.0, -3.0));
	blockC[0].i[2][5][0] = (mat2x3(9.0, 7.0, 2.0, -2.0, 3.0, -5.0));
	blockC[0].i[2][5][1] = (mat2x3(7.0, -7.0, -7.0, 1.0, 4.0, -8.0));
	blockC[0].i[2][5][2] = (mat2x3(-5.0, 0.0, -2.0, -4.0, 8.0, -2.0));
	blockC[0].i[2][6][0] = (mat2x3(-4.0, 7.0, 8.0, -1.0, -3.0, -9.0));
	blockC[0].i[2][6][1] = (mat2x3(3.0, 4.0, 6.0, 9.0, 8.0, 8.0));
	blockC[0].i[2][6][2] = (mat2x3(1.0, -1.0, -9.0, 2.0, -4.0, -9.0));
	blockC[0].i[2][7][0] = (mat2x3(-6.0, -2.0, -8.0, 1.0, -3.0, -2.0));
	blockC[0].i[2][7][1] = (mat2x3(-5.0, -9.0, -7.0, 2.0, 4.0, -6.0));
	blockC[0].i[2][7][2] = (mat2x3(-2.0, -9.0, 5.0, -4.0, -6.0, 8.0));
	blockC[0].i[3][0][0] = (mat2x3(-1.0, 6.0, 5.0, 0.0, 3.0, 1.0));
	blockC[0].i[3][0][1] = (mat2x3(5.0, -2.0, -7.0, -3.0, -3.0, -9.0));
	blockC[0].i[3][0][2] = (mat2x3(8.0, -5.0, 5.0, -1.0, -8.0, -9.0));
	blockC[0].i[3][1][0] = (mat2x3(-6.0, -4.0, 3.0, 3.0, 0.0, 4.0));
	blockC[0].i[3][1][1] = (mat2x3(4.0, 2.0, -6.0, 4.0, 2.0, -2.0));
	blockC[0].i[3][1][2] = (mat2x3(0.0, 0.0, -4.0, -5.0, 5.0, 8.0));
	blockC[0].i[3][2][0] = (mat2x3(-1.0, 3.0, -3.0, -5.0, -2.0, 2.0));
	blockC[0].i[3][2][1] = (mat2x3(4.0, 8.0, -7.0, 4.0, 0.0, -5.0));
	blockC[0].i[3][2][2] = (mat2x3(-1.0, -3.0, -6.0, -6.0, 1.0, -4.0));
	blockC[0].i[3][3][0] = (mat2x3(-5.0, -2.0, -8.0, 3.0, -2.0, 2.0));
	blockC[0].i[3][3][1] = (mat2x3(2.0, 4.0, -3.0, -1.0, 8.0, 2.0));
	blockC[0].i[3][3][2] = (mat2x3(-1.0, -2.0, -2.0, -7.0, 5.0, 7.0));
	blockC[0].i[3][4][0] = (mat2x3(6.0, -5.0, 6.0, 7.0, -9.0, 8.0));
	blockC[0].i[3][4][1] = (mat2x3(3.0, 0.0, -5.0, -9.0, 1.0, -1.0));
	blockC[0].i[3][4][2] = (mat2x3(8.0, -4.0, 0.0, -8.0, 6.0, -9.0));
	blockC[0].i[3][5][0] = (mat2x3(7.0, -3.0, -2.0, 0.0, 3.0, -5.0));
	blockC[0].i[3][5][1] = (mat2x3(7.0, 2.0, 8.0, 8.0, -4.0, -2.0));
	blockC[0].i[3][5][2] = (mat2x3(-9.0, 8.0, 1.0, -9.0, 8.0, -4.0));
	blockC[0].i[3][6][0] = (mat2x3(-9.0, 7.0, -9.0, -9.0, 0.0, 0.0));
	blockC[0].i[3][6][1] = (mat2x3(-2.0, -1.0, 9.0, 2.0, -9.0, -5.0));
	blockC[0].i[3][6][2] = (mat2x3(-7.0, -2.0, -7.0, -6.0, -9.0, -1.0));
	blockC[0].i[3][7][0] = (mat2x3(1.0, 0.0, 9.0, 1.0, 0.0, -9.0));
	blockC[0].i[3][7][1] = (mat2x3(-7.0, 8.0, -2.0, -2.0, -1.0, -1.0));
	blockC[0].i[3][7][2] = (mat2x3(7.0, -9.0, 7.0, -3.0, -1.0, -9.0));
	blockC[0].i[4][0][0] = (mat2x3(4.0, 4.0, 0.0, -4.0, 5.0, -8.0));
	blockC[0].i[4][0][1] = (mat2x3(-5.0, -7.0, 6.0, -5.0, 8.0, -3.0));
	blockC[0].i[4][0][2] = (mat2x3(-2.0, 7.0, 6.0, -4.0, 0.0, -3.0));
	blockC[0].i[4][1][0] = (mat2x3(3.0, 6.0, -6.0, -5.0, -3.0, -4.0));
	blockC[0].i[4][1][1] = (mat2x3(4.0, -7.0, 9.0, 0.0, 3.0, 2.0));
	blockC[0].i[4][1][2] = (mat2x3(1.0, -4.0, -5.0, 4.0, 0.0, 3.0));
	blockC[0].i[4][2][0] = (mat2x3(-2.0, 6.0, -1.0, 7.0, -1.0, 3.0));
	blockC[0].i[4][2][1] = (mat2x3(-1.0, 6.0, 1.0, 7.0, 3.0, -9.0));
	blockC[0].i[4][2][2] = (mat2x3(-9.0, -1.0, 4.0, -7.0, -3.0, 0.0));
	blockC[0].i[4][3][0] = (mat2x3(-2.0, -5.0, 7.0, 0.0, 9.0, -1.0));
	blockC[0].i[4][3][1] = (mat2x3(4.0, 3.0, 8.0, -9.0, 8.0, 9.0));
	blockC[0].i[4][3][2] = (mat2x3(6.0, 1.0, -5.0, 0.0, 5.0, 2.0));
	blockC[0].i[4][4][0] = (mat2x3(3.0, -1.0, 2.0, 9.0, 1.0, -1.0));
	blockC[0].i[4][4][1] = (mat2x3(-9.0, 5.0, -9.0, 5.0, 8.0, 6.0));
	blockC[0].i[4][4][2] = (mat2x3(7.0, -2.0, -8.0, 0.0, -5.0, -4.0));
	blockC[0].i[4][5][0] = (mat2x3(-3.0, 1.0, 5.0, 0.0, -8.0, 9.0));
	blockC[0].i[4][5][1] = (mat2x3(4.0, -1.0, -2.0, 3.0, -2.0, -5.0));
	blockC[0].i[4][5][2] = (mat2x3(-3.0, 8.0, 9.0, 5.0, 2.0, 1.0));
	blockC[0].i[4][6][0] = (mat2x3(2.0, 2.0, -2.0, 0.0, -8.0, 2.0));
	blockC[0].i[4][6][1] = (mat2x3(-2.0, -9.0, 9.0, -1.0, -9.0, -5.0));
	blockC[0].i[4][6][2] = (mat2x3(5.0, -5.0, -7.0, -4.0, -8.0, -2.0));
	blockC[0].i[4][7][0] = (mat2x3(-7.0, -3.0, -3.0, 3.0, 3.0, 5.0));
	blockC[0].i[4][7][1] = (mat2x3(8.0, 5.0, -8.0, 4.0, 2.0, 7.0));
	blockC[0].i[4][7][2] = (mat2x3(-1.0, 6.0, -2.0, 8.0, -2.0, 8.0));
	j = (vec2(-3.0, 5.0));
}
#version 450
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
	i16vec2 a[2];
	mediump ivec2 b[];
} blockB;

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(blockB.a[0]), ivec2(1, 3)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.a[1]), ivec2(9, -6)) && allOk;
	allOk = compare_ivec2((blockB.b[0]), ivec2(1, -2)) && allOk;
	allOk = compare_ivec2((blockB.b[1]), ivec2(-8, -7)) && allOk;
	allOk = compare_ivec2((blockB.b[2]), ivec2(-4, -2)) && allOk;
	allOk = compare_ivec2((blockB.b[3]), ivec2(-4, -5)) && allOk;
	allOk = compare_ivec2((blockB.b[4]), ivec2(-1, 2)) && allOk;
	allOk = compare_ivec2((blockB.b[5]), ivec2(-2, -4)) && allOk;
	allOk = compare_ivec2((blockB.b[6]), ivec2(7, -1)) && allOk;
	allOk = compare_ivec2((blockB.b[7]), ivec2(-1, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = i16vec2(ivec2(-1, -1));
	blockB.a[1] = i16vec2(ivec2(-1, 9));
	blockB.b[0] = (ivec2(5, 9));
	blockB.b[1] = (ivec2(5, -5));
	blockB.b[2] = (ivec2(-6, -5));
	blockB.b[3] = (ivec2(9, 0));
	blockB.b[4] = (ivec2(6, 2));
	blockB.b[5] = (ivec2(7, 9));
	blockB.b[6] = (ivec2(-4, -5));
	blockB.b[7] = (ivec2(-1, -4));
}
#version 450
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
	layout(offset = 0) highp uvec2 a;
	layout(offset = 8) mediump uvec2 b;
	layout(offset = 16) highp ivec4 c[1];
	layout(offset = 32) mediump uvec3 d[1];
} blockB[1];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) i16vec2 e;
	layout(offset = 4) uint16_t f;
	layout(offset = 16) bvec4 g;
	layout(offset = 32) uint16_t h;
} blockC[1];
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) highp ivec2 i;
	layout(offset = 8) f16vec4 j;
	layout(offset = 16) highp uvec3 k;
	layout(offset = 32) i16vec4 l;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB[0].a), uvec2(9u, 7u)) && allOk;
	allOk = compare_uvec2((blockB[0].b), uvec2(5u, 2u)) && allOk;
	allOk = compare_ivec4((blockB[0].c[0]), ivec4(3, 0, -5, -2)) && allOk;
	allOk = compare_uvec3((blockB[0].d[0]), uvec3(0u, 5u, 6u)) && allOk;
	allOk = compare_i16vec2(ivec2(blockC[0].e), ivec2(4, 6)) && allOk;
	allOk = compare_uint16_t(uint(blockC[0].f), 9u) && allOk;
	allOk = compare_uint16_t(uint(blockC[0].h), 7u) && allOk;
	allOk = compare_f16vec4(vec4(j), vec4(2.0, -6.0, 8.0, -3.0)) && allOk;
	allOk = compare_uvec3((k), uvec3(7u, 8u, 8u)) && allOk;
	allOk = compare_i16vec4(ivec4(l), ivec4(-4, 6, 5, 0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (uvec2(7u, 1u));
	blockB[0].b = (uvec2(5u, 1u));
	blockB[0].c[0] = (ivec4(3, 5, -1, 2));
	blockB[0].d[0] = (uvec3(9u, 8u, 7u));
	blockC[0].g = (bvec4(false, true, true, false));
	i = (ivec2(8, -6));
	j = f16vec4(vec4(1.0, -8.0, -3.0, 0.0));
	k = (uvec3(2u, 3u, 5u));
	l = i16vec4(ivec4(9, 6, -4, -8));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(binding = 1) readonly buffer BlockB
{
	layout(offset = 0) mediump vec3 a;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.a), vec3(1.0, 2.0, 2.0)) && allOk;
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

layout(binding = 1) buffer BlockB
{
	layout(offset = 0) mediump int a[1];
} blockB[2];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) i16vec4 b;
	layout(offset = 8) u16vec2 c;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) lowp uint d;
	layout(offset = 4) i16vec4 e;
	layout(offset = 16) mediump ivec2 f;
	layout(offset = 32) lowp uvec3 g;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(blockC.b), ivec4(4, 3, 7, -3)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.c), uvec2(7u, 2u)) && allOk;
	allOk = compare_uint((d), 6u) && allOk;
	allOk = compare_uvec3((g), uvec3(4u, 6u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (-7);
	blockB[1].a[0] = (-2);
	blockC.b = i16vec4(ivec4(8, -4, -8, 5));
	d = (9u);
	e = i16vec4(ivec4(-4, 3, -8, -8));
	f = (ivec2(-8, -4));
	g = (uvec3(1u, 4u, 9u));
}
#version 450
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
	i8vec2 c[];
} blockB;

bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(blockB.c[0]), ivec2(2, 4294967295)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.c[1]), ivec2(4294967288, 2)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.c[2]), ivec2(4294967290, 5)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.c[3]), ivec2(4294967289, 2)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.c[4]), ivec2(8, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = int8_t(9);
	blockB.c[0] = i8vec2(ivec2(6, 2));
	blockB.c[1] = i8vec2(ivec2(4294967288, 7));
	blockB.c[2] = i8vec2(ivec2(6, 4294967292));
	blockB.c[3] = i8vec2(ivec2(5, 7));
	blockB.c[4] = i8vec2(ivec2(9, 4294967294));
}
#version 450
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
	highp mat2x3 a;
	mediump mat4x2 b;
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	mediump mat2x3 c;
	lowp mat3x2 d[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB.a, mat2x3(-8.0, 9.0, 5.0, -2.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat4x2(blockB.b, mat4x2(-1.0, 0.0, 9.0, -9.0, -1.0, 1.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat3x2(d[0], mat3x2(-7.0, 9.0, 7.0, -6.0, 0.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2x3(1.0, -4.0, 8.0, 1.0, 1.0, -4.0));
	blockB.b = (mat4x2(1.0, -9.0, -9.0, -6.0, 3.0, 3.0, 0.0, 4.0));
	d[0] = (mat3x2(5.0, -4.0, -2.0, -8.0, -1.0, 2.0));
}
#version 450
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
	bvec3 mA;
	lowp uvec4 mB;
	highp float mC;
};
struct sB
{
	lowp mat4x3 mA;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	sA a[];
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	i8vec3 b;
	lowp uvec3 c;
	mediump vec2 d;
	bvec2 e;
	sB f[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((a[0].mA), bvec3(true, true, false)) && allOk;
	allOk = compare_uvec4((a[0].mB), uvec4(8u, 3u, 1u, 8u)) && allOk;
	allOk = compare_float((a[0].mC), 5.0) && allOk;
	allOk = compare_i8vec3(ivec3(b), ivec3(4294967287, 9, 4294967294)) && allOk;
	allOk = compare_uvec3((c), uvec3(5u, 6u, 6u)) && allOk;
	allOk = compare_vec2((d), vec2(-9.0, 0.0)) && allOk;
	allOk = compare_bvec2((e), bvec2(false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0].mA = (bvec3(true, true, true));
	a[0].mB = (uvec4(2u, 1u, 3u, 2u));
	a[0].mC = (-3.0);
	b = i8vec3(ivec3(3, 4294967293, 4294967295));
	c = (uvec3(0u, 2u, 3u));
}
#version 450
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
	u8vec3 mB;
	uint8_t mC;
};
struct sB
{
	bvec3 mA;
	lowp uvec2 mB;
};
struct sC
{
	lowp mat2 mA;
	highp uvec4 mB;
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	sA a;
	sB b;
	int8_t c;
	highp ivec2 d;
	i8vec2 e[];
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	sC f[];
};
layout(std430, binding = 3) buffer BlockD
{
	i8vec4 g;
	lowp int h[];
} blockD[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a.mA), uvec2(1u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.a.mB), uvec3(0u, 2u, 9u)) && allOk;
	allOk = compare_uint8_t(uint(blockB.a.mC), 2u) && allOk;
	allOk = compare_int8_t(int(blockB.c), 4294967288) && allOk;
	allOk = compare_ivec2((blockB.d), ivec2(0, -6)) && allOk;
	allOk = compare_mat2(f[0].mA, mat2(7.0, 2.0, 1.0, 3.0)) && allOk;
	allOk = compare_uvec4((f[0].mB), uvec4(8u, 5u, 1u, 3u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD[0].g), ivec4(4294967295, 5, 4294967291, 7)) && allOk;
	allOk = compare_int((blockD[0].h[0]), -6) && allOk;
	allOk = compare_int((blockD[0].h[1]), 2) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA = (uvec2(7u, 0u));
	blockB.a.mB = u8vec3(uvec3(3u, 8u, 6u));
	blockB.a.mC = uint8_t(6u);
	blockB.b.mA = (bvec3(false, false, true));
	blockB.b.mB = (uvec2(7u, 3u));
	blockB.c = int8_t(4294967290);
	blockB.d = (ivec2(4, -7));
	blockB.e[0] = i8vec2(ivec2(6, 4294967291));
	blockB.e[1] = i8vec2(ivec2(4294967292, 8));
	blockB.e[2] = i8vec2(ivec2(4294967289, 4));
	blockB.e[3] = i8vec2(ivec2(4294967293, 4294967293));
	blockB.e[4] = i8vec2(ivec2(5, 6));
	blockB.e[5] = i8vec2(ivec2(7, 4294967288));
	f[0].mA = (mat2(3.0, 9.0, 9.0, 5.0));
	f[0].mB = (uvec4(0u, 7u, 1u, 1u));
	blockD[0].g = i8vec4(ivec4(7, 4294967294, 4294967287, 9));
	blockD[0].h[0] = (0);
	blockD[0].h[1] = (-6);
}
#version 450
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
	lowp uvec3 a;
	bvec3 b[];
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((a), uvec3(9u, 8u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (uvec3(1u, 5u, 5u));
	b[0] = (bvec3(true, true, true));
	b[1] = (bvec3(false, false, true));
	b[2] = (bvec3(false, true, false));
	b[3] = (bvec3(true, false, false));
	b[4] = (bvec3(false, false, true));
	b[5] = (bvec3(false, true, false));
	b[6] = (bvec3(true, false, false));
	b[7] = (bvec3(false, true, false));
}
#version 450
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
	layout(offset = 0) highp vec3 a;
	layout(offset = 16) highp vec3 b;
	layout(offset = 32) highp uvec4 c;
	layout(offset = 48) i8vec4 d[1];
	layout(offset = 52) mediump int e;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) i8vec2 f;
	layout(offset = 4) lowp int g;
	layout(offset = 8) u8vec2 h[1];
} blockC[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.a), vec3(2.0, 5.0, 9.0)) && allOk;
	allOk = compare_vec3((blockB.b), vec3(-9.0, -9.0, -4.0)) && allOk;
	allOk = compare_uvec4((blockB.c), uvec4(4u, 0u, 4u, 1u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.d[0]), ivec4(5, 1, 4294967294, 6)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC[0].f), ivec2(4294967290, 4294967287)) && allOk;
	allOk = compare_int((blockC[0].g), -9) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec3(-1.0, -4.0, 2.0));
	blockB.b = (vec3(-1.0, 2.0, 2.0));
	blockB.c = (uvec4(5u, 2u, 5u, 2u));
	blockB.e = (-2);
	blockC[0].f = i8vec2(ivec2(5, 4294967295));
	blockC[0].g = (9);
	blockC[0].h[0] = u8vec2(uvec2(5u, 8u));
}
#version 450
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
	layout(offset = 0) bvec2 a;
	layout(offset = 8) bool b;
	layout(offset = 16) mediump ivec4 c;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) highp uvec4 d;
	layout(offset = 16) u8vec3 e[1];
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) u8vec3 f;
	layout(offset = 3) int8_t g;
	layout(offset = 4) mediump uvec3 h;
	layout(offset = 16) mediump uint i;
	layout(offset = 20) bvec2 j;
} blockD[1];

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.c), ivec4(-7, 2, -1, -2)) && allOk;
	allOk = compare_uvec4((blockC.d), uvec4(3u, 3u, 4u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.e[0]), uvec3(1u, 9u, 8u)) && allOk;
	allOk = compare_uvec3((blockD[0].h), uvec3(5u, 1u, 8u)) && allOk;
	allOk = compare_uint((blockD[0].i), 9u) && allOk;
	allOk = compare_bvec2((blockD[0].j), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, false));
	blockB.b = (true);
	blockB.c = (ivec4(2, 5, -8, -3));
	blockC.d = (uvec4(0u, 9u, 3u, 8u));
	blockC.e[0] = u8vec3(uvec3(3u, 7u, 0u));
	blockD[0].f = u8vec3(uvec3(4u, 3u, 4u));
	blockD[0].g = int8_t(4294967293);
	blockD[0].h = (uvec3(0u, 9u, 0u));
	blockD[0].j = (bvec2(false, true));
}
#version 450
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
	bvec2 mB;
};
struct sB
{
	lowp ivec3 mA;
	mediump ivec4 mB;
};
layout(scalar, binding = 1) buffer BlockB
{
	sA a[][3][7];
} blockB;
layout(scalar, binding = 2) buffer BlockC
{
	sB b;
	mediump uvec4 c;
	lowp ivec3 d;
	lowp mat3x2 e[];
};
layout(scalar, column_major, binding = 3) buffer BlockD
{
	lowp mat4x2 f;
	highp ivec2 g;
	i8vec3 h;
	mediump float i[];
} blockD;
layout(scalar, column_major, binding = 4) readonly buffer BlockE
{
	mediump ivec3 j;
	i8vec2 k[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((b.mA), ivec3(-1, -3, -9)) && allOk;
	allOk = compare_ivec4((b.mB), ivec4(-7, 7, -6, 9)) && allOk;
	allOk = compare_uvec4((c), uvec4(3u, 1u, 7u, 6u)) && allOk;
	allOk = compare_ivec3((d), ivec3(-6, -6, 6)) && allOk;
	allOk = compare_mat3x2(e[0], mat3x2(4.0, 3.0, -4.0, -5.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(e[1], mat3x2(-3.0, -1.0, 7.0, 6.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat3x2(e[2], mat3x2(0.0, -5.0, -7.0, 4.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat3x2(e[3], mat3x2(-1.0, -6.0, 1.0, 2.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat3x2(e[4], mat3x2(-5.0, -5.0, -6.0, 9.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat3x2(e[5], mat3x2(-4.0, -9.0, 4.0, -9.0, 7.0, -5.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockD.h), ivec3(4294967291, 5, 7)) && allOk;
	allOk = compare_float((blockD.i[0]), -6.0) && allOk;
	allOk = compare_float((blockD.i[1]), 3.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0][0][0].mA = (ivec3(5, 6, 1));
	blockB.a[0][0][0].mB = (bvec2(false, false));
	blockB.a[0][0][1].mA = (ivec3(-3, -6, 2));
	blockB.a[0][0][1].mB = (bvec2(false, true));
	blockB.a[0][0][2].mA = (ivec3(2, 1, -5));
	blockB.a[0][0][2].mB = (bvec2(true, false));
	blockB.a[0][0][3].mA = (ivec3(6, -2, 5));
	blockB.a[0][0][3].mB = (bvec2(true, true));
	blockB.a[0][0][4].mA = (ivec3(5, 1, 0));
	blockB.a[0][0][4].mB = (bvec2(true, false));
	blockB.a[0][0][5].mA = (ivec3(-1, -4, 4));
	blockB.a[0][0][5].mB = (bvec2(true, false));
	blockB.a[0][0][6].mA = (ivec3(4, 7, 2));
	blockB.a[0][0][6].mB = (bvec2(true, true));
	blockB.a[0][1][0].mA = (ivec3(2, -5, -7));
	blockB.a[0][1][0].mB = (bvec2(true, true));
	blockB.a[0][1][1].mA = (ivec3(-8, 2, -8));
	blockB.a[0][1][1].mB = (bvec2(true, true));
	blockB.a[0][1][2].mA = (ivec3(5, -6, -4));
	blockB.a[0][1][2].mB = (bvec2(true, true));
	blockB.a[0][1][3].mA = (ivec3(4, 1, -3));
	blockB.a[0][1][3].mB = (bvec2(true, false));
	blockB.a[0][1][4].mA = (ivec3(6, 8, 7));
	blockB.a[0][1][4].mB = (bvec2(false, false));
	blockB.a[0][1][5].mA = (ivec3(-5, 2, -6));
	blockB.a[0][1][5].mB = (bvec2(false, true));
	blockB.a[0][1][6].mA = (ivec3(4, 0, 2));
	blockB.a[0][1][6].mB = (bvec2(false, true));
	blockB.a[0][2][0].mA = (ivec3(-3, -3, -7));
	blockB.a[0][2][0].mB = (bvec2(false, false));
	blockB.a[0][2][1].mA = (ivec3(-5, -5, 7));
	blockB.a[0][2][1].mB = (bvec2(true, true));
	blockB.a[0][2][2].mA = (ivec3(7, -2, 0));
	blockB.a[0][2][2].mB = (bvec2(true, true));
	blockB.a[0][2][3].mA = (ivec3(-2, 8, 0));
	blockB.a[0][2][3].mB = (bvec2(false, false));
	blockB.a[0][2][4].mA = (ivec3(0, 1, 2));
	blockB.a[0][2][4].mB = (bvec2(false, false));
	blockB.a[0][2][5].mA = (ivec3(6, 7, -5));
	blockB.a[0][2][5].mB = (bvec2(true, false));
	blockB.a[0][2][6].mA = (ivec3(-2, -7, -8));
	blockB.a[0][2][6].mB = (bvec2(true, false));
	blockB.a[1][0][0].mA = (ivec3(-5, 7, -4));
	blockB.a[1][0][0].mB = (bvec2(true, true));
	blockB.a[1][0][1].mA = (ivec3(-6, -5, 1));
	blockB.a[1][0][1].mB = (bvec2(false, false));
	blockB.a[1][0][2].mA = (ivec3(-7, -4, 4));
	blockB.a[1][0][2].mB = (bvec2(false, true));
	blockB.a[1][0][3].mA = (ivec3(-7, 1, -1));
	blockB.a[1][0][3].mB = (bvec2(false, true));
	blockB.a[1][0][4].mA = (ivec3(-3, -4, -3));
	blockB.a[1][0][4].mB = (bvec2(false, true));
	blockB.a[1][0][5].mA = (ivec3(-9, 3, 8));
	blockB.a[1][0][5].mB = (bvec2(true, false));
	blockB.a[1][0][6].mA = (ivec3(3, -2, 4));
	blockB.a[1][0][6].mB = (bvec2(true, false));
	blockB.a[1][1][0].mA = (ivec3(3, 4, -7));
	blockB.a[1][1][0].mB = (bvec2(false, true));
	blockB.a[1][1][1].mA = (ivec3(6, -7, 6));
	blockB.a[1][1][1].mB = (bvec2(false, true));
	blockB.a[1][1][2].mA = (ivec3(1, 1, -9));
	blockB.a[1][1][2].mB = (bvec2(false, true));
	blockB.a[1][1][3].mA = (ivec3(-8, 4, 2));
	blockB.a[1][1][3].mB = (bvec2(true, true));
	blockB.a[1][1][4].mA = (ivec3(-9, 4, -3));
	blockB.a[1][1][4].mB = (bvec2(true, true));
	blockB.a[1][1][5].mA = (ivec3(-2, -6, 1));
	blockB.a[1][1][5].mB = (bvec2(true, true));
	blockB.a[1][1][6].mA = (ivec3(7, 9, -3));
	blockB.a[1][1][6].mB = (bvec2(false, false));
	blockB.a[1][2][0].mA = (ivec3(3, -2, -6));
	blockB.a[1][2][0].mB = (bvec2(false, false));
	blockB.a[1][2][1].mA = (ivec3(-8, 9, -8));
	blockB.a[1][2][1].mB = (bvec2(false, false));
	blockB.a[1][2][2].mA = (ivec3(4, -6, -6));
	blockB.a[1][2][2].mB = (bvec2(false, false));
	blockB.a[1][2][3].mA = (ivec3(-7, -4, -9));
	blockB.a[1][2][3].mB = (bvec2(true, true));
	blockB.a[1][2][4].mA = (ivec3(-4, 1, 0));
	blockB.a[1][2][4].mB = (bvec2(true, true));
	blockB.a[1][2][5].mA = (ivec3(-6, 6, -6));
	blockB.a[1][2][5].mB = (bvec2(true, true));
	blockB.a[1][2][6].mA = (ivec3(2, 3, -5));
	blockB.a[1][2][6].mB = (bvec2(false, false));
	blockB.a[2][0][0].mA = (ivec3(4, -2, 4));
	blockB.a[2][0][0].mB = (bvec2(false, true));
	blockB.a[2][0][1].mA = (ivec3(-1, 4, -7));
	blockB.a[2][0][1].mB = (bvec2(true, true));
	blockB.a[2][0][2].mA = (ivec3(-3, -7, 7));
	blockB.a[2][0][2].mB = (bvec2(false, true));
	blockB.a[2][0][3].mA = (ivec3(1, 5, 4));
	blockB.a[2][0][3].mB = (bvec2(false, true));
	blockB.a[2][0][4].mA = (ivec3(-3, 3, 7));
	blockB.a[2][0][4].mB = (bvec2(false, true));
	blockB.a[2][0][5].mA = (ivec3(-6, 8, 6));
	blockB.a[2][0][5].mB = (bvec2(true, false));
	blockB.a[2][0][6].mA = (ivec3(-5, -7, -3));
	blockB.a[2][0][6].mB = (bvec2(false, false));
	blockB.a[2][1][0].mA = (ivec3(9, 4, -6));
	blockB.a[2][1][0].mB = (bvec2(true, false));
	blockB.a[2][1][1].mA = (ivec3(5, 9, 7));
	blockB.a[2][1][1].mB = (bvec2(true, false));
	blockB.a[2][1][2].mA = (ivec3(0, -7, -6));
	blockB.a[2][1][2].mB = (bvec2(true, true));
	blockB.a[2][1][3].mA = (ivec3(0, -1, -5));
	blockB.a[2][1][3].mB = (bvec2(false, false));
	blockB.a[2][1][4].mA = (ivec3(-4, 6, -6));
	blockB.a[2][1][4].mB = (bvec2(true, true));
	blockB.a[2][1][5].mA = (ivec3(9, -3, 1));
	blockB.a[2][1][5].mB = (bvec2(false, true));
	blockB.a[2][1][6].mA = (ivec3(-6, -7, -6));
	blockB.a[2][1][6].mB = (bvec2(false, false));
	blockB.a[2][2][0].mA = (ivec3(-2, -3, 3));
	blockB.a[2][2][0].mB = (bvec2(false, true));
	blockB.a[2][2][1].mA = (ivec3(2, -2, 8));
	blockB.a[2][2][1].mB = (bvec2(false, false));
	blockB.a[2][2][2].mA = (ivec3(-2, 8, 2));
	blockB.a[2][2][2].mB = (bvec2(true, false));
	blockB.a[2][2][3].mA = (ivec3(5, -2, 2));
	blockB.a[2][2][3].mB = (bvec2(true, true));
	blockB.a[2][2][4].mA = (ivec3(0, 7, -1));
	blockB.a[2][2][4].mB = (bvec2(true, false));
	blockB.a[2][2][5].mA = (ivec3(-9, -7, -7));
	blockB.a[2][2][5].mB = (bvec2(true, false));
	blockB.a[2][2][6].mA = (ivec3(-9, 0, 9));
	blockB.a[2][2][6].mB = (bvec2(true, true));
	blockB.a[3][0][0].mA = (ivec3(5, -5, 7));
	blockB.a[3][0][0].mB = (bvec2(true, false));
	blockB.a[3][0][1].mA = (ivec3(-1, -6, 4));
	blockB.a[3][0][1].mB = (bvec2(true, true));
	blockB.a[3][0][2].mA = (ivec3(-5, 5, 3));
	blockB.a[3][0][2].mB = (bvec2(false, false));
	blockB.a[3][0][3].mA = (ivec3(-6, -2, -1));
	blockB.a[3][0][3].mB = (bvec2(false, false));
	blockB.a[3][0][4].mA = (ivec3(4, 4, -2));
	blockB.a[3][0][4].mB = (bvec2(true, true));
	blockB.a[3][0][5].mA = (ivec3(4, -3, 1));
	blockB.a[3][0][5].mB = (bvec2(true, false));
	blockB.a[3][0][6].mA = (ivec3(7, 5, 8));
	blockB.a[3][0][6].mB = (bvec2(false, true));
	blockB.a[3][1][0].mA = (ivec3(-6, 0, 0));
	blockB.a[3][1][0].mB = (bvec2(false, false));
	blockB.a[3][1][1].mA = (ivec3(0, -2, 7));
	blockB.a[3][1][1].mB = (bvec2(true, true));
	blockB.a[3][1][2].mA = (ivec3(1, -9, 9));
	blockB.a[3][1][2].mB = (bvec2(true, false));
	blockB.a[3][1][3].mA = (ivec3(3, 7, -9));
	blockB.a[3][1][3].mB = (bvec2(false, true));
	blockB.a[3][1][4].mA = (ivec3(3, -3, 4));
	blockB.a[3][1][4].mB = (bvec2(false, true));
	blockB.a[3][1][5].mA = (ivec3(2, 3, 5));
	blockB.a[3][1][5].mB = (bvec2(false, false));
	blockB.a[3][1][6].mA = (ivec3(0, 1, 8));
	blockB.a[3][1][6].mB = (bvec2(false, false));
	blockB.a[3][2][0].mA = (ivec3(-3, 4, 0));
	blockB.a[3][2][0].mB = (bvec2(true, true));
	blockB.a[3][2][1].mA = (ivec3(1, 3, -3));
	blockB.a[3][2][1].mB = (bvec2(true, false));
	blockB.a[3][2][2].mA = (ivec3(8, 1, -1));
	blockB.a[3][2][2].mB = (bvec2(false, true));
	blockB.a[3][2][3].mA = (ivec3(5, -7, 7));
	blockB.a[3][2][3].mB = (bvec2(true, true));
	blockB.a[3][2][4].mA = (ivec3(4, 7, -7));
	blockB.a[3][2][4].mB = (bvec2(true, true));
	blockB.a[3][2][5].mA = (ivec3(1, 8, -7));
	blockB.a[3][2][5].mB = (bvec2(false, true));
	blockB.a[3][2][6].mA = (ivec3(4, -7, 3));
	blockB.a[3][2][6].mB = (bvec2(true, false));
	blockB.a[4][0][0].mA = (ivec3(4, 5, 9));
	blockB.a[4][0][0].mB = (bvec2(false, true));
	blockB.a[4][0][1].mA = (ivec3(9, -3, 2));
	blockB.a[4][0][1].mB = (bvec2(false, false));
	blockB.a[4][0][2].mA = (ivec3(-9, -5, -1));
	blockB.a[4][0][2].mB = (bvec2(true, true));
	blockB.a[4][0][3].mA = (ivec3(-2, 1, 5));
	blockB.a[4][0][3].mB = (bvec2(false, false));
	blockB.a[4][0][4].mA = (ivec3(6, -4, -5));
	blockB.a[4][0][4].mB = (bvec2(false, true));
	blockB.a[4][0][5].mA = (ivec3(-4, -1, -9));
	blockB.a[4][0][5].mB = (bvec2(true, false));
	blockB.a[4][0][6].mA = (ivec3(-2, -7, 5));
	blockB.a[4][0][6].mB = (bvec2(true, true));
	blockB.a[4][1][0].mA = (ivec3(-1, 3, -3));
	blockB.a[4][1][0].mB = (bvec2(false, true));
	blockB.a[4][1][1].mA = (ivec3(-6, 2, -1));
	blockB.a[4][1][1].mB = (bvec2(true, false));
	blockB.a[4][1][2].mA = (ivec3(-3, -6, 2));
	blockB.a[4][1][2].mB = (bvec2(false, false));
	blockB.a[4][1][3].mA = (ivec3(-3, 2, -3));
	blockB.a[4][1][3].mB = (bvec2(true, false));
	blockB.a[4][1][4].mA = (ivec3(3, 7, -4));
	blockB.a[4][1][4].mB = (bvec2(false, true));
	blockB.a[4][1][5].mA = (ivec3(2, -8, 8));
	blockB.a[4][1][5].mB = (bvec2(false, true));
	blockB.a[4][1][6].mA = (ivec3(-7, -5, 8));
	blockB.a[4][1][6].mB = (bvec2(true, false));
	blockB.a[4][2][0].mA = (ivec3(1, 8, 8));
	blockB.a[4][2][0].mB = (bvec2(true, true));
	blockB.a[4][2][1].mA = (ivec3(-8, 7, -3));
	blockB.a[4][2][1].mB = (bvec2(true, true));
	blockB.a[4][2][2].mA = (ivec3(2, 4, 8));
	blockB.a[4][2][2].mB = (bvec2(false, true));
	blockB.a[4][2][3].mA = (ivec3(-9, 0, 7));
	blockB.a[4][2][3].mB = (bvec2(false, false));
	blockB.a[4][2][4].mA = (ivec3(9, -1, 7));
	blockB.a[4][2][4].mB = (bvec2(false, true));
	blockB.a[4][2][5].mA = (ivec3(-4, 6, 3));
	blockB.a[4][2][5].mB = (bvec2(false, true));
	blockB.a[4][2][6].mA = (ivec3(7, -3, -4));
	blockB.a[4][2][6].mB = (bvec2(true, true));
	blockB.a[5][0][0].mA = (ivec3(-3, 1, 7));
	blockB.a[5][0][0].mB = (bvec2(true, false));
	blockB.a[5][0][1].mA = (ivec3(7, 2, -5));
	blockB.a[5][0][1].mB = (bvec2(true, true));
	blockB.a[5][0][2].mA = (ivec3(-3, -1, 0));
	blockB.a[5][0][2].mB = (bvec2(false, false));
	blockB.a[5][0][3].mA = (ivec3(5, -7, 0));
	blockB.a[5][0][3].mB = (bvec2(true, false));
	blockB.a[5][0][4].mA = (ivec3(-5, -9, -1));
	blockB.a[5][0][4].mB = (bvec2(true, false));
	blockB.a[5][0][5].mA = (ivec3(-5, -6, -7));
	blockB.a[5][0][5].mB = (bvec2(true, true));
	blockB.a[5][0][6].mA = (ivec3(-8, 2, -2));
	blockB.a[5][0][6].mB = (bvec2(true, false));
	blockB.a[5][1][0].mA = (ivec3(8, -7, 5));
	blockB.a[5][1][0].mB = (bvec2(false, true));
	blockB.a[5][1][1].mA = (ivec3(-3, 5, 7));
	blockB.a[5][1][1].mB = (bvec2(true, true));
	blockB.a[5][1][2].mA = (ivec3(-1, -3, -7));
	blockB.a[5][1][2].mB = (bvec2(true, true));
	blockB.a[5][1][3].mA = (ivec3(-5, -9, -5));
	blockB.a[5][1][3].mB = (bvec2(true, true));
	blockB.a[5][1][4].mA = (ivec3(0, 0, 5));
	blockB.a[5][1][4].mB = (bvec2(false, false));
	blockB.a[5][1][5].mA = (ivec3(3, -3, -8));
	blockB.a[5][1][5].mB = (bvec2(false, true));
	blockB.a[5][1][6].mA = (ivec3(8, 4, 6));
	blockB.a[5][1][6].mB = (bvec2(true, true));
	blockB.a[5][2][0].mA = (ivec3(8, 0, 2));
	blockB.a[5][2][0].mB = (bvec2(false, false));
	blockB.a[5][2][1].mA = (ivec3(6, 5, -7));
	blockB.a[5][2][1].mB = (bvec2(true, true));
	blockB.a[5][2][2].mA = (ivec3(-5, -1, 1));
	blockB.a[5][2][2].mB = (bvec2(true, true));
	blockB.a[5][2][3].mA = (ivec3(1, 5, 9));
	blockB.a[5][2][3].mB = (bvec2(false, true));
	blockB.a[5][2][4].mA = (ivec3(7, 2, -6));
	blockB.a[5][2][4].mB = (bvec2(false, false));
	blockB.a[5][2][5].mA = (ivec3(5, 0, 5));
	blockB.a[5][2][5].mB = (bvec2(true, true));
	blockB.a[5][2][6].mA = (ivec3(7, -2, 2));
	blockB.a[5][2][6].mB = (bvec2(false, false));
	blockB.a[6][0][0].mA = (ivec3(-2, -2, -2));
	blockB.a[6][0][0].mB = (bvec2(false, true));
	blockB.a[6][0][1].mA = (ivec3(-8, 8, 0));
	blockB.a[6][0][1].mB = (bvec2(false, false));
	blockB.a[6][0][2].mA = (ivec3(-4, -8, -2));
	blockB.a[6][0][2].mB = (bvec2(false, false));
	blockB.a[6][0][3].mA = (ivec3(-7, 1, 3));
	blockB.a[6][0][3].mB = (bvec2(false, true));
	blockB.a[6][0][4].mA = (ivec3(3, 7, -1));
	blockB.a[6][0][4].mB = (bvec2(true, true));
	blockB.a[6][0][5].mA = (ivec3(-1, 4, -2));
	blockB.a[6][0][5].mB = (bvec2(false, false));
	blockB.a[6][0][6].mA = (ivec3(8, -5, 9));
	blockB.a[6][0][6].mB = (bvec2(false, false));
	blockB.a[6][1][0].mA = (ivec3(-4, -1, -9));
	blockB.a[6][1][0].mB = (bvec2(false, false));
	blockB.a[6][1][1].mA = (ivec3(-7, 8, -9));
	blockB.a[6][1][1].mB = (bvec2(true, true));
	blockB.a[6][1][2].mA = (ivec3(5, 8, 9));
	blockB.a[6][1][2].mB = (bvec2(true, true));
	blockB.a[6][1][3].mA = (ivec3(-9, 6, -8));
	blockB.a[6][1][3].mB = (bvec2(true, true));
	blockB.a[6][1][4].mA = (ivec3(5, -7, 7));
	blockB.a[6][1][4].mB = (bvec2(false, true));
	blockB.a[6][1][5].mA = (ivec3(9, 3, -2));
	blockB.a[6][1][5].mB = (bvec2(true, true));
	blockB.a[6][1][6].mA = (ivec3(-9, 5, -8));
	blockB.a[6][1][6].mB = (bvec2(true, false));
	blockB.a[6][2][0].mA = (ivec3(8, 9, -7));
	blockB.a[6][2][0].mB = (bvec2(true, true));
	blockB.a[6][2][1].mA = (ivec3(1, 2, -5));
	blockB.a[6][2][1].mB = (bvec2(true, true));
	blockB.a[6][2][2].mA = (ivec3(0, -3, 2));
	blockB.a[6][2][2].mB = (bvec2(true, false));
	blockB.a[6][2][3].mA = (ivec3(8, 1, 5));
	blockB.a[6][2][3].mB = (bvec2(true, true));
	blockB.a[6][2][4].mA = (ivec3(5, 7, -7));
	blockB.a[6][2][4].mB = (bvec2(true, false));
	blockB.a[6][2][5].mA = (ivec3(7, -3, 0));
	blockB.a[6][2][5].mB = (bvec2(true, false));
	blockB.a[6][2][6].mA = (ivec3(0, 6, 1));
	blockB.a[6][2][6].mB = (bvec2(true, true));
	blockB.a[7][0][0].mA = (ivec3(1, 4, 9));
	blockB.a[7][0][0].mB = (bvec2(false, false));
	blockB.a[7][0][1].mA = (ivec3(-1, -6, 9));
	blockB.a[7][0][1].mB = (bvec2(false, true));
	blockB.a[7][0][2].mA = (ivec3(-4, 5, 1));
	blockB.a[7][0][2].mB = (bvec2(false, true));
	blockB.a[7][0][3].mA = (ivec3(5, -1, 4));
	blockB.a[7][0][3].mB = (bvec2(true, false));
	blockB.a[7][0][4].mA = (ivec3(4, 9, 5));
	blockB.a[7][0][4].mB = (bvec2(true, true));
	blockB.a[7][0][5].mA = (ivec3(5, -9, -3));
	blockB.a[7][0][5].mB = (bvec2(false, false));
	blockB.a[7][0][6].mA = (ivec3(7, -7, 8));
	blockB.a[7][0][6].mB = (bvec2(true, false));
	blockB.a[7][1][0].mA = (ivec3(-6, -7, 1));
	blockB.a[7][1][0].mB = (bvec2(true, true));
	blockB.a[7][1][1].mA = (ivec3(7, 4, -6));
	blockB.a[7][1][1].mB = (bvec2(true, false));
	blockB.a[7][1][2].mA = (ivec3(2, -5, -2));
	blockB.a[7][1][2].mB = (bvec2(false, false));
	blockB.a[7][1][3].mA = (ivec3(1, 4, 3));
	blockB.a[7][1][3].mB = (bvec2(true, false));
	blockB.a[7][1][4].mA = (ivec3(-1, -1, -3));
	blockB.a[7][1][4].mB = (bvec2(false, false));
	blockB.a[7][1][5].mA = (ivec3(3, 2, 9));
	blockB.a[7][1][5].mB = (bvec2(true, true));
	blockB.a[7][1][6].mA = (ivec3(-3, 6, -6));
	blockB.a[7][1][6].mB = (bvec2(false, true));
	blockB.a[7][2][0].mA = (ivec3(6, 5, -4));
	blockB.a[7][2][0].mB = (bvec2(false, true));
	blockB.a[7][2][1].mA = (ivec3(9, 5, 1));
	blockB.a[7][2][1].mB = (bvec2(false, true));
	blockB.a[7][2][2].mA = (ivec3(-1, 8, 0));
	blockB.a[7][2][2].mB = (bvec2(false, false));
	blockB.a[7][2][3].mA = (ivec3(0, 6, 9));
	blockB.a[7][2][3].mB = (bvec2(false, false));
	blockB.a[7][2][4].mA = (ivec3(1, 1, 7));
	blockB.a[7][2][4].mB = (bvec2(false, true));
	blockB.a[7][2][5].mA = (ivec3(-1, 8, -7));
	blockB.a[7][2][5].mB = (bvec2(true, true));
	blockB.a[7][2][6].mA = (ivec3(5, 5, 0));
	blockB.a[7][2][6].mB = (bvec2(false, true));
	c = (uvec4(9u, 4u, 1u, 9u));
	e[0] = (mat3x2(2.0, 2.0, 4.0, -3.0, -6.0, 2.0));
	e[1] = (mat3x2(5.0, 7.0, -2.0, -8.0, 6.0, 0.0));
	e[2] = (mat3x2(2.0, -3.0, -6.0, -3.0, -2.0, 4.0));
	e[3] = (mat3x2(-5.0, -9.0, -9.0, 5.0, -8.0, -7.0));
	e[4] = (mat3x2(-7.0, -2.0, 0.0, -4.0, -6.0, -7.0));
	e[5] = (mat3x2(1.0, 0.0, -5.0, -4.0, -8.0, -5.0));
	blockD.g = (ivec2(8, -5));
}
#version 450
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
	mediump mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var, mat4(-9.0, 2.0, 5.0, 5.0, 7.0, -4.0, 0.0, 3.0, 4.0, -6.0, -8.0, 5.0, 5.0, 1.0, 4.0, 5.0)) && allOk;
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
	highp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 9.0) && allOk;
	allOk = compare_float(var[0][1], 5.0) && allOk;
	allOk = compare_float(var[0][2], -9.0) && allOk;
	allOk = compare_float(var[0][3], -5.0) && allOk;
	allOk = compare_float(var[1][0], -8.0) && allOk;
	allOk = compare_float(var[1][1], -6.0) && allOk;
	allOk = compare_float(var[1][2], 1.0) && allOk;
	allOk = compare_float(var[1][3], -9.0) && allOk;
	allOk = compare_float(var[2][0], -1.0) && allOk;
	allOk = compare_float(var[2][1], -1.0) && allOk;
	allOk = compare_float(var[2][2], 4.0) && allOk;
	allOk = compare_float(var[2][3], -1.0) && allOk;
	allOk = compare_float(var[3][0], 8.0) && allOk;
	allOk = compare_float(var[3][1], 6.0) && allOk;
	allOk = compare_float(var[3][2], -6.0) && allOk;
	allOk = compare_float(var[3][3], 3.0) && allOk;
	allOk = compare_vec4(var[0], vec4(9.0, 5.0, -9.0, -5.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-8.0, -6.0, 1.0, -9.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-1.0, -1.0, 4.0, -1.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(8.0, 6.0, -6.0, 3.0)) && allOk;
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
	highp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var, mat4x2(8.0, -8.0, -2.0, -5.0, 4.0, 3.0, -8.0, 9.0)) && allOk;
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
	mediump vec2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((var), vec2(7.0, -1.0)) && allOk;
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
	lowp uvec2 var;
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((var), uvec2(2u, 3u)) && allOk;
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
	mediump uvec4 var;
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((var), uvec4(1u, 4u, 9u, 6u)) && allOk;
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
	allOk = compare_mat4(var, mat4(5.0, 5.0, 1.0, -2.0, 6.0, -1.0, -4.0, 5.0, 5.0, -8.0, 7.0, -8.0, 5.0, 4.0, 0.0, 6.0)) && allOk;
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

}
#version 450
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
	mediump mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -6.0) && allOk;
	allOk = compare_float(var[0][1], -5.0) && allOk;
	allOk = compare_float(var[1][0], -5.0) && allOk;
	allOk = compare_float(var[1][1], -6.0) && allOk;
	allOk = compare_float(var[2][0], -5.0) && allOk;
	allOk = compare_float(var[2][1], -4.0) && allOk;
	allOk = compare_float(var[3][0], -7.0) && allOk;
	allOk = compare_float(var[3][1], 5.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-6.0, -5.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-5.0, -4.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(-7.0, 5.0)) && allOk;
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
	mediump mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -4.0) && allOk;
	allOk = compare_float(var[0][1], 7.0) && allOk;
	allOk = compare_float(var[0][2], -3.0) && allOk;
	allOk = compare_float(var[1][0], -4.0) && allOk;
	allOk = compare_float(var[1][1], 6.0) && allOk;
	allOk = compare_float(var[1][2], -8.0) && allOk;
	allOk = compare_float(var[2][0], 4.0) && allOk;
	allOk = compare_float(var[2][1], -7.0) && allOk;
	allOk = compare_float(var[2][2], -5.0) && allOk;
	allOk = compare_float(var[3][0], -6.0) && allOk;
	allOk = compare_float(var[3][1], 7.0) && allOk;
	allOk = compare_float(var[3][2], 5.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-4.0, 7.0, -3.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-4.0, 6.0, -8.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(4.0, -7.0, -5.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(-6.0, 7.0, 5.0)) && allOk;
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
	mediump uvec4 var;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((padding), 1u) && allOk;
	allOk = compare_uvec4((var), uvec4(4u, 9u, 6u, 3u)) && allOk;
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
	lowp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -1.0) && allOk;
	allOk = compare_float(var[0][0], 0.0) && allOk;
	allOk = compare_float(var[0][1], 7.0) && allOk;
	allOk = compare_float(var[0][2], -6.0) && allOk;
	allOk = compare_float(var[0][3], 5.0) && allOk;
	allOk = compare_float(var[1][0], 5.0) && allOk;
	allOk = compare_float(var[1][1], 0.0) && allOk;
	allOk = compare_float(var[1][2], 1.0) && allOk;
	allOk = compare_float(var[1][3], -6.0) && allOk;
	allOk = compare_vec4(var[0], vec4(0.0, 7.0, -6.0, 5.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(5.0, 0.0, 1.0, -6.0)) && allOk;
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
	lowp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -6.0) && allOk;
	allOk = compare_mat3x2(var, mat3x2(-6.0, 8.0, -5.0, -4.0, 6.0, 4.0)) && allOk;
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
	int8_t padding;
	i8vec2 var;
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(padding), 4294967288) && allOk;
	allOk = compare_i8vec2(ivec2(var), ivec2(4294967293, 1)) && allOk;
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
	int16_t padding;
	i16vec2 var;
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(padding), 3) && allOk;
	allOk = compare_i16vec2(ivec2(var), ivec2(-1, 8)) && allOk;
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
	highp mat4x3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0], mat4x3(-4.0, 6.0, 7.0, -6.0, 2.0, -5.0, 0.0, -2.0, 8.0, -7.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(-4.0, -5.0, -7.0, 0.0, -7.0, -8.0, -3.0, 1.0, 3.0, 7.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(-9.0, 5.0, 2.0, -9.0, 9.0, 2.0, 8.0, -7.0, -4.0, 8.0, 6.0, -6.0)) && allOk;
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
	highp uvec2 var[3];
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((var[0]), uvec2(6u, 0u)) && allOk;
	allOk = compare_uvec2((var[1]), uvec2(6u, 7u)) && allOk;
	allOk = compare_uvec2((var[2]), uvec2(1u, 7u)) && allOk;
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
	allOk = compare_mat2(var[0], mat2(3.0, 8.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(-3.0, 1.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(-5.0, -3.0, -5.0, -8.0)) && allOk;
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
	allOk = compare_mat4(var[0], mat4(0.0, 6.0, -9.0, 9.0, -2.0, -7.0, -4.0, -6.0, 1.0, -5.0, 2.0, -7.0, 8.0, 2.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(2.0, 8.0, 1.0, 7.0, -1.0, -6.0, 8.0, -2.0, -2.0, 6.0, -7.0, 7.0, 9.0, -7.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(-9.0, -4.0, -7.0, -3.0, -5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 6.0, 1.0, -8.0, -3.0, 6.0, -5.0)) && allOk;
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
	highp mat4 var[3];
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
	highp mat2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat2(var[0], mat2(-7.0, -1.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(8.0, -6.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(-3.0, -8.0, -6.0, -1.0)) && allOk;
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
	highp mat2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_mat2(var[0], mat2(-2.0, -2.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(-4.0, 8.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(9.0, 7.0, -2.0, 8.0)) && allOk;
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
	highp mat4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 9.0) && allOk;
	allOk = compare_mat4(var[0], mat4(0.0, -9.0, -9.0, 5.0, -4.0, 8.0, 7.0, 8.0, -4.0, -5.0, -7.0, 8.0, 9.0, -2.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(4.0, 1.0, -3.0, 3.0, -2.0, -9.0, 6.0, -5.0, 3.0, 1.0, 3.0, -4.0, -9.0, 1.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(-8.0, 2.0, 0.0, -3.0, -8.0, 3.0, -7.0, 8.0, -5.0, -6.0, -1.0, -7.0, 5.0, -3.0, 3.0, 8.0)) && allOk;
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
	highp mat4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_mat4(var[0], mat4(6.0, 7.0, 5.0, 2.0, -4.0, 0.0, 8.0, 3.0, 3.0, 9.0, 8.0, -2.0, 7.0, 0.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(1.0, 9.0, 1.0, -2.0, -7.0, 3.0, 5.0, 2.0, -8.0, 8.0, -1.0, -4.0, -5.0, 8.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(1.0, 1.0, -6.0, 5.0, -8.0, -6.0, -3.0, -4.0, 8.0, 9.0, -9.0, -4.0, -2.0, -8.0, 8.0, -7.0)) && allOk;
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
	highp mat2x3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 5.0) && allOk;
	allOk = compare_mat2x3(var[0], mat2x3(-6.0, 5.0, -5.0, 8.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(3.0, 9.0, -4.0, 0.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(5.0, 5.0, -9.0, 2.0, -1.0, -2.0)) && allOk;
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
	highp mat2x3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -3.0) && allOk;
	allOk = compare_mat2x3(var[0], mat2x3(6.0, -6.0, -6.0, -7.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(3.0, 1.0, 4.0, -2.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(-5.0, -8.0, -7.0, 1.0, -3.0, 3.0)) && allOk;
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
	highp mat2x4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat2x4(var[0], mat2x4(-4.0, 9.0, -7.0, -8.0, 2.0, 5.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(8.0, -9.0, 4.0, 4.0, -9.0, -1.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(-5.0, -4.0, -8.0, -6.0, -2.0, 3.0, 0.0, -5.0)) && allOk;
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
	highp mat4x3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat4x3(var[0], mat4x3(9.0, -7.0, -7.0, 8.0, 2.0, 7.0, 3.0, -1.0, -1.0, 8.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(-8.0, -6.0, 3.0, -8.0, -8.0, -4.0, 5.0, -9.0, 2.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(4.0, -4.0, -7.0, 9.0, -3.0, -7.0, 9.0, 2.0, 9.0, 1.0, 9.0, 1.0)) && allOk;
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

layout(std140, row_major, binding = 1) readonly buffer Block
{
	highp mat3x2 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0], mat3x2(-5.0, -8.0, -4.0, 7.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(-7.0, 4.0, 3.0, -1.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(-6.0, -3.0, -8.0, 5.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[3], mat3x2(2.0, 6.0, -1.0, -9.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[4], mat3x2(-8.0, 3.0, 1.0, -2.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[5], mat3x2(0.0, 4.0, 0.0, 1.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[6], mat3x2(9.0, 7.0, 4.0, -7.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[7], mat3x2(-3.0, 1.0, 1.0, -4.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[8], mat3x2(-7.0, 4.0, 1.0, 0.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[9], mat3x2(3.0, -5.0, 6.0, 8.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[10], mat3x2(-6.0, 3.0, -6.0, 0.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[11], mat3x2(-1.0, 0.0, -5.0, -6.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[12], mat3x2(-5.0, -6.0, -9.0, -3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[13], mat3x2(1.0, 6.0, 2.0, 2.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[14], mat3x2(-4.0, -2.0, -2.0, 0.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[15], mat3x2(5.0, -5.0, 9.0, 8.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[16], mat3x2(7.0, -4.0, -4.0, 5.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[17], mat3x2(-8.0, 6.0, 4.0, 2.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[18], mat3x2(9.0, 7.0, 3.0, 7.0, -8.0, 8.0)) && allOk;
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

layout(scalar, row_major, binding = 1) readonly buffer Block
{
	highp mat3x2 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0], mat3x2(-4.0, 6.0, 0.0, 6.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(5.0, -1.0, 1.0, 7.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(4.0, -5.0, -2.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[3], mat3x2(-2.0, -1.0, 5.0, 2.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[4], mat3x2(9.0, -5.0, 7.0, 6.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[5], mat3x2(-1.0, -4.0, 0.0, -2.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[6], mat3x2(7.0, 3.0, -1.0, 6.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[7], mat3x2(-8.0, -5.0, 9.0, -3.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[8], mat3x2(-4.0, 6.0, -7.0, 0.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[9], mat3x2(-9.0, 0.0, 9.0, -8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[10], mat3x2(-7.0, -5.0, 3.0, -3.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[11], mat3x2(-3.0, -2.0, 3.0, -8.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[12], mat3x2(-4.0, -8.0, -7.0, -9.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[13], mat3x2(-1.0, -4.0, -4.0, 6.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[14], mat3x2(-8.0, 8.0, -4.0, -8.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[15], mat3x2(-3.0, -7.0, -5.0, -7.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[16], mat3x2(0.0, -8.0, -1.0, 9.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[17], mat3x2(-7.0, -9.0, 6.0, -5.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[18], mat3x2(0.0, 9.0, -1.0, -2.0, 0.0, -5.0)) && allOk;
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

layout(std140, column_major, buffer_reference) buffer Block
{
	mediump mat4 var;
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
	allOk = compare_float(block.var[0][0], -4.0) && allOk;
	allOk = compare_float(block.var[0][1], -1.0) && allOk;
	allOk = compare_float(block.var[0][2], 8.0) && allOk;
	allOk = compare_float(block.var[0][3], -9.0) && allOk;
	allOk = compare_float(block.var[1][0], 7.0) && allOk;
	allOk = compare_float(block.var[1][1], 4.0) && allOk;
	allOk = compare_float(block.var[1][2], -2.0) && allOk;
	allOk = compare_float(block.var[1][3], 5.0) && allOk;
	allOk = compare_float(block.var[2][0], 3.0) && allOk;
	allOk = compare_float(block.var[2][1], -6.0) && allOk;
	allOk = compare_float(block.var[2][2], -4.0) && allOk;
	allOk = compare_float(block.var[2][3], 8.0) && allOk;
	allOk = compare_float(block.var[3][0], -4.0) && allOk;
	allOk = compare_float(block.var[3][1], -2.0) && allOk;
	allOk = compare_float(block.var[3][2], -9.0) && allOk;
	allOk = compare_float(block.var[3][3], -5.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-4.0, -1.0, 8.0, -9.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(7.0, 4.0, -2.0, 5.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(3.0, -6.0, -4.0, 8.0)) && allOk;
	allOk = compare_vec4(block.var[3], vec4(-4.0, -2.0, -9.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(2.0, -1.0, -7.0, 2.0));
	block.var[1] = (vec4(-1.0, -5.0, 0.0, -1.0));
	block.var[2] = (vec4(7.0, 7.0, 2.0, 1.0));
	block.var[3] = (vec4(8.0, 2.0, -3.0, 0.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var, mat2x4(1.0, -3.0, -1.0, -4.0, 4.0, -7.0, 8.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(-1.0, 9.0, -3.0, 7.0));
	block.var[1] = (vec4(1.0, -1.0, 6.0, 9.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 5.0) && allOk;
	allOk = compare_float(block.var[0][1], -8.0) && allOk;
	allOk = compare_float(block.var[0][2], 1.0) && allOk;
	allOk = compare_float(block.var[0][3], 8.0) && allOk;
	allOk = compare_float(block.var[1][0], -7.0) && allOk;
	allOk = compare_float(block.var[1][1], -7.0) && allOk;
	allOk = compare_float(block.var[1][2], 5.0) && allOk;
	allOk = compare_float(block.var[1][3], -5.0) && allOk;
	allOk = compare_float(block.var[2][0], -6.0) && allOk;
	allOk = compare_float(block.var[2][1], -3.0) && allOk;
	allOk = compare_float(block.var[2][2], 3.0) && allOk;
	allOk = compare_float(block.var[2][3], 1.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(5.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-7.0, -7.0, 5.0, -5.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(-6.0, -3.0, 3.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x4(-3.0, 0.0, -2.0, -2.0, -2.0, 6.0, 2.0, 9.0, -5.0, -2.0, -8.0, -8.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var, mat4x3(-6.0, -3.0, 6.0, -8.0, -3.0, 8.0, 3.0, 2.0, -5.0, -2.0, -1.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(6.0, 0.0, -2.0));
	block.var[1] = (vec3(-1.0, 5.0, -6.0));
	block.var[2] = (vec3(6.0, 0.0, 8.0));
	block.var[3] = (vec3(-4.0, -1.0, 2.0));
}
#version 450
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
	mediump mat2 var;
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
	allOk = compare_float(block.var[0][0], 6.0) && allOk;
	allOk = compare_float(block.var[0][1], -2.0) && allOk;
	allOk = compare_float(block.var[1][0], 9.0) && allOk;
	allOk = compare_float(block.var[1][1], -4.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(6.0, -2.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(-1.0, -3.0));
	block.var[1] = (vec2(-7.0, -2.0));
}
#version 450
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
	lowp mat3 var;
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
	allOk = compare_float(block.var[0][0], 1.0) && allOk;
	allOk = compare_float(block.var[0][1], -6.0) && allOk;
	allOk = compare_float(block.var[0][2], -8.0) && allOk;
	allOk = compare_float(block.var[1][0], 3.0) && allOk;
	allOk = compare_float(block.var[1][1], 1.0) && allOk;
	allOk = compare_float(block.var[1][2], 1.0) && allOk;
	allOk = compare_float(block.var[2][0], -6.0) && allOk;
	allOk = compare_float(block.var[2][1], -2.0) && allOk;
	allOk = compare_float(block.var[2][2], -5.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(1.0, -6.0, -8.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(3.0, 1.0, 1.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(-6.0, -2.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(2.0, -4.0, 5.0));
	block.var[1] = (vec3(8.0, -3.0, 1.0));
	block.var[2] = (vec3(-8.0, -5.0, 3.0));
}
#version 450
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
	mediump mat3 var;
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
	allOk = compare_mat3(block.var, mat3(8.0, -3.0, -9.0, 8.0, -4.0, 0.0, -8.0, -7.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3(-4.0, 1.0, 7.0, -2.0, 4.0, 1.0, 5.0, -4.0, 1.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var, mat3x2(8.0, 9.0, 7.0, 1.0, -5.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(7.0, 7.0));
	block.var[1] = (vec2(5.0, 7.0));
	block.var[2] = (vec2(4.0, 8.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -4.0) && allOk;
	allOk = compare_float(block.var[0][1], -7.0) && allOk;
	allOk = compare_float(block.var[1][0], -3.0) && allOk;
	allOk = compare_float(block.var[1][1], -5.0) && allOk;
	allOk = compare_float(block.var[2][0], 8.0) && allOk;
	allOk = compare_float(block.var[2][1], 0.0) && allOk;
	allOk = compare_float(block.var[3][0], -7.0) && allOk;
	allOk = compare_float(block.var[3][1], -1.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(-4.0, -7.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-3.0, -5.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(8.0, 0.0)) && allOk;
	allOk = compare_vec2(block.var[3], vec2(-7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x2(-9.0, 4.0, -1.0, 9.0, -3.0, 8.0, 3.0, 2.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 1.0) && allOk;
	allOk = compare_float(block.var[0][1], 7.0) && allOk;
	allOk = compare_float(block.var[0][2], -7.0) && allOk;
	allOk = compare_float(block.var[1][0], 3.0) && allOk;
	allOk = compare_float(block.var[1][1], -1.0) && allOk;
	allOk = compare_float(block.var[1][2], -1.0) && allOk;
	allOk = compare_float(block.var[2][0], -1.0) && allOk;
	allOk = compare_float(block.var[2][1], -6.0) && allOk;
	allOk = compare_float(block.var[2][2], 6.0) && allOk;
	allOk = compare_float(block.var[3][0], 0.0) && allOk;
	allOk = compare_float(block.var[3][1], -3.0) && allOk;
	allOk = compare_float(block.var[3][2], 7.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(1.0, 7.0, -7.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(3.0, -1.0, -1.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(-1.0, -6.0, 6.0)) && allOk;
	allOk = compare_vec3(block.var[3], vec3(0.0, -3.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(1.0, 1.0, 8.0));
	block.var[1] = (vec3(0.0, 4.0, -9.0));
	block.var[2] = (vec3(-3.0, 7.0, -6.0));
	block.var[3] = (vec3(-7.0, -9.0, -7.0));
}
#version 450
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
	lowp int var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((block.var), 3) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (-7);
}
#version 450
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
	allOk = compare_float((block.padding), 7.0) && allOk;
	allOk = compare_mat4(block.var, mat4(-3.0, -9.0, -7.0, 4.0, 5.0, 2.0, -6.0, -8.0, -1.0, -2.0, -5.0, -8.0, -7.0, 0.0, -4.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (3.0);
	block.var[0] = (vec4(9.0, 2.0, 1.0, -5.0));
	block.var[1] = (vec4(-7.0, 8.0, -8.0, 7.0));
	block.var[2] = (vec4(0.0, -3.0, 1.0, -5.0));
	block.var[3] = (vec4(0.0, 5.0, -8.0, -7.0));
}
#version 450
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
	allOk = compare_float((block.padding), 2.0) && allOk;
	allOk = compare_float(block.var[0][0], 4.0) && allOk;
	allOk = compare_float(block.var[0][1], 1.0) && allOk;
	allOk = compare_float(block.var[0][2], 2.0) && allOk;
	allOk = compare_float(block.var[1][0], -6.0) && allOk;
	allOk = compare_float(block.var[1][1], -7.0) && allOk;
	allOk = compare_float(block.var[1][2], 3.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(4.0, 1.0, 2.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-6.0, -7.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (9.0);
	block.var[0] = (vec3(8.0, -3.0, -5.0));
	block.var[1] = (vec3(9.0, 9.0, -9.0));
}
#version 450
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
	mediump mat2x3 var;
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
	allOk = compare_float((block.padding), -3.0) && allOk;
	allOk = compare_float(block.var[0][0], 3.0) && allOk;
	allOk = compare_float(block.var[0][1], 4.0) && allOk;
	allOk = compare_float(block.var[0][2], 7.0) && allOk;
	allOk = compare_float(block.var[1][0], 8.0) && allOk;
	allOk = compare_float(block.var[1][1], 7.0) && allOk;
	allOk = compare_float(block.var[1][2], -3.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(3.0, 4.0, 7.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(8.0, 7.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (1.0);
	block.var[0] = (vec3(-7.0, -7.0, -7.0));
	block.var[1] = (vec3(6.0, 9.0, 5.0));
}
#version 450
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
	allOk = compare_float((block.padding), 3.0) && allOk;
	allOk = compare_mat3x4(block.var, mat3x4(-8.0, 0.0, 1.0, -9.0, 4.0, -4.0, -2.0, -5.0, -9.0, -9.0, 1.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-5.0);
	block.var = (mat3x4(5.0, -9.0, -3.0, -7.0, 1.0, -6.0, -2.0, -4.0, 8.0, 7.0, 9.0, -7.0));
}
#version 450
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
	allOk = compare_float((block.padding), 6.0) && allOk;
	allOk = compare_mat3x4(block.var, mat3x4(3.0, -5.0, -5.0, -3.0, 3.0, -1.0, 2.0, 2.0, -2.0, -8.0, -3.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (5.0);
	block.var = (mat3x4(3.0, -6.0, 0.0, -5.0, -3.0, 7.0, -5.0, -3.0, 6.0, 8.0, 7.0, 5.0));
}
#version 450
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
	allOk = compare_float((block.padding), -9.0) && allOk;
	allOk = compare_mat4x2(block.var, mat4x2(-6.0, 0.0, 3.0, -8.0, 9.0, -8.0, 5.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-8.0);
	block.var[0] = (vec2(-2.0, -8.0));
	block.var[1] = (vec2(-4.0, 5.0));
	block.var[2] = (vec2(6.0, -2.0));
	block.var[3] = (vec2(5.0, 6.0));
}
#version 450
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

layout(scalar, buffer_reference) buffer Block
{
	uint16_t padding;
	u16vec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(block.padding), 1u) && allOk;
	allOk = compare_u16vec3(uvec3(block.var), uvec3(0u, 5u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = uint16_t(1u);
	block.var = u16vec3(uvec3(2u, 6u, 8u));
}
#version 450
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
	highp int var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((block.var[0]), 6) && allOk;
	allOk = compare_int((block.var[1]), 0) && allOk;
	allOk = compare_int((block.var[2]), 9) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (8);
	block.var[1] = (2);
	block.var[2] = (-5);
}
#version 450
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
	allOk = compare_mat2x4(block.var[0], mat2x4(-7.0, 8.0, 3.0, -7.0, -7.0, -8.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(7.0, 3.0, -5.0, -7.0, 3.0, -9.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(3.0, 6.0, -4.0, 4.0, -2.0, 8.0, -6.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2x4(4.0, 9.0, 1.0, 2.0, 5.0, -4.0, -9.0, -9.0));
	block.var[1] = (mat2x4(5.0, -4.0, -4.0, 8.0, 5.0, -1.0, -3.0, -2.0));
	block.var[2] = (mat2x4(8.0, 2.0, 5.0, 4.0, 3.0, 1.0, -6.0, 2.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0], mat4x3(5.0, 0.0, 3.0, -5.0, 9.0, -6.0, 8.0, -6.0, 6.0, 2.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1], mat4x3(1.0, 7.0, 3.0, 4.0, 6.0, 2.0, -7.0, -9.0, -6.0, 1.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[2], mat4x3(4.0, -7.0, -2.0, 5.0, -7.0, 6.0, 7.0, 1.0, -4.0, -7.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[3], mat4x3(8.0, 0.0, -3.0, -3.0, 9.0, 2.0, -6.0, 4.0, 1.0, -1.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[4], mat4x3(7.0, -3.0, -4.0, 9.0, 3.0, 6.0, -1.0, -1.0, 6.0, -7.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[5], mat4x3(7.0, -9.0, -5.0, 9.0, 7.0, -1.0, -2.0, 7.0, -2.0, 0.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[6], mat4x3(-6.0, 1.0, 5.0, 9.0, -2.0, 8.0, 4.0, 6.0, -1.0, -2.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[7], mat4x3(5.0, -5.0, -3.0, 4.0, -3.0, -5.0, 8.0, 4.0, -8.0, -2.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[8], mat4x3(-6.0, -4.0, 6.0, -4.0, -8.0, 2.0, 3.0, -2.0, 0.0, -4.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[9], mat4x3(7.0, 4.0, -7.0, 3.0, 5.0, 4.0, 0.0, -1.0, 2.0, 6.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[10], mat4x3(-8.0, -7.0, -4.0, 9.0, 4.0, -9.0, -4.0, 2.0, -6.0, -4.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[11], mat4x3(-2.0, 3.0, 5.0, 2.0, -4.0, -5.0, -2.0, 4.0, 4.0, -3.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[12], mat4x3(6.0, -5.0, -6.0, 6.0, 3.0, -1.0, 3.0, 3.0, 7.0, 3.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[13], mat4x3(-8.0, 2.0, 5.0, -7.0, 6.0, -6.0, -4.0, 3.0, 5.0, 1.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[14], mat4x3(-3.0, 2.0, 2.0, -2.0, -2.0, 2.0, 5.0, 6.0, 3.0, -8.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[15], mat4x3(-8.0, -7.0, 6.0, 1.0, 0.0, -2.0, -9.0, 5.0, 0.0, 5.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[16], mat4x3(9.0, 5.0, 6.0, 9.0, -3.0, -5.0, -4.0, -2.0, 3.0, -9.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[17], mat4x3(5.0, -9.0, -3.0, 8.0, -8.0, 6.0, 6.0, 8.0, -6.0, 5.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[18], mat4x3(9.0, 7.0, 1.0, 2.0, 8.0, 4.0, 2.0, -2.0, 1.0, 2.0, -9.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4x3(6.0, -7.0, 0.0, 3.0, -1.0, -9.0, -7.0, -5.0, 8.0, 0.0, 1.0, 5.0));
	block.var[1] = (mat4x3(7.0, 1.0, 5.0, 7.0, -8.0, 4.0, 2.0, -8.0, -8.0, 3.0, -6.0, -5.0));
	block.var[2] = (mat4x3(5.0, -7.0, 8.0, -7.0, -3.0, -4.0, -9.0, -9.0, -6.0, 5.0, -8.0, 1.0));
	block.var[3] = (mat4x3(-2.0, 3.0, -2.0, -9.0, 2.0, 9.0, -2.0, 8.0, -8.0, -8.0, -7.0, -5.0));
	block.var[4] = (mat4x3(7.0, -4.0, -6.0, -5.0, 0.0, 0.0, -6.0, -5.0, 1.0, 9.0, -4.0, -9.0));
	block.var[5] = (mat4x3(-5.0, 7.0, 2.0, 6.0, -1.0, -7.0, -9.0, -4.0, 5.0, -4.0, -3.0, 3.0));
	block.var[6] = (mat4x3(-6.0, 0.0, 1.0, -1.0, 4.0, 2.0, 0.0, -8.0, 7.0, -3.0, 1.0, -7.0));
	block.var[7] = (mat4x3(3.0, 8.0, 6.0, 5.0, 6.0, -2.0, -7.0, -5.0, 0.0, -4.0, -8.0, 5.0));
	block.var[8] = (mat4x3(3.0, -9.0, -8.0, -7.0, 3.0, 3.0, 3.0, -7.0, -5.0, -9.0, -1.0, -8.0));
	block.var[9] = (mat4x3(6.0, -5.0, 6.0, -8.0, -2.0, -6.0, 9.0, 0.0, 8.0, -9.0, -7.0, 1.0));
	block.var[10] = (mat4x3(8.0, -5.0, 0.0, -7.0, -6.0, 2.0, 0.0, -8.0, 1.0, -5.0, -9.0, -2.0));
	block.var[11] = (mat4x3(1.0, 0.0, 8.0, -8.0, 6.0, 7.0, 6.0, 2.0, 0.0, 3.0, -4.0, -6.0));
	block.var[12] = (mat4x3(-6.0, 9.0, 3.0, 4.0, 2.0, -2.0, -4.0, 3.0, 0.0, 4.0, -2.0, 0.0));
	block.var[13] = (mat4x3(6.0, -8.0, 4.0, 9.0, 3.0, 0.0, -8.0, -3.0, 5.0, 5.0, 7.0, 7.0));
	block.var[14] = (mat4x3(-1.0, -4.0, -7.0, -7.0, 7.0, 9.0, -7.0, 3.0, 7.0, -6.0, -6.0, 8.0));
	block.var[15] = (mat4x3(7.0, -7.0, -8.0, -3.0, 8.0, -1.0, -8.0, 2.0, -9.0, 9.0, 0.0, -7.0));
	block.var[16] = (mat4x3(-4.0, -2.0, 9.0, 2.0, -9.0, 7.0, 0.0, -4.0, 0.0, -3.0, 4.0, -6.0));
	block.var[17] = (mat4x3(9.0, -7.0, 9.0, 4.0, -8.0, 9.0, 0.0, -6.0, -6.0, 4.0, 4.0, 3.0));
	block.var[18] = (mat4x3(-9.0, -6.0, -4.0, -8.0, 0.0, 1.0, -9.0, -8.0, 1.0, 6.0, 3.0, -7.0));
}
#version 450
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
	highp ivec2 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((block.var[0]), ivec2(6, -1)) && allOk;
	allOk = compare_ivec2((block.var[1]), ivec2(7, -5)) && allOk;
	allOk = compare_ivec2((block.var[2]), ivec2(-8, 8)) && allOk;
	allOk = compare_ivec2((block.var[3]), ivec2(-2, -6)) && allOk;
	allOk = compare_ivec2((block.var[4]), ivec2(6, 2)) && allOk;
	allOk = compare_ivec2((block.var[5]), ivec2(-2, 7)) && allOk;
	allOk = compare_ivec2((block.var[6]), ivec2(-1, -1)) && allOk;
	allOk = compare_ivec2((block.var[7]), ivec2(0, 8)) && allOk;
	allOk = compare_ivec2((block.var[8]), ivec2(-9, -5)) && allOk;
	allOk = compare_ivec2((block.var[9]), ivec2(6, 4)) && allOk;
	allOk = compare_ivec2((block.var[10]), ivec2(-8, 3)) && allOk;
	allOk = compare_ivec2((block.var[11]), ivec2(7, -6)) && allOk;
	allOk = compare_ivec2((block.var[12]), ivec2(-4, 1)) && allOk;
	allOk = compare_ivec2((block.var[13]), ivec2(-3, -1)) && allOk;
	allOk = compare_ivec2((block.var[14]), ivec2(2, 1)) && allOk;
	allOk = compare_ivec2((block.var[15]), ivec2(-4, -3)) && allOk;
	allOk = compare_ivec2((block.var[16]), ivec2(-9, 0)) && allOk;
	allOk = compare_ivec2((block.var[17]), ivec2(9, 8)) && allOk;
	allOk = compare_ivec2((block.var[18]), ivec2(6, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (ivec2(-6, 8));
	block.var[1] = (ivec2(3, -1));
	block.var[2] = (ivec2(-5, -2));
	block.var[3] = (ivec2(0, -2));
	block.var[4] = (ivec2(5, 2));
	block.var[5] = (ivec2(-8, 4));
	block.var[6] = (ivec2(-6, -4));
	block.var[7] = (ivec2(3, -2));
	block.var[8] = (ivec2(5, -7));
	block.var[9] = (ivec2(-3, 4));
	block.var[10] = (ivec2(1, 6));
	block.var[11] = (ivec2(8, 7));
	block.var[12] = (ivec2(4, 1));
	block.var[13] = (ivec2(1, 9));
	block.var[14] = (ivec2(-2, -9));
	block.var[15] = (ivec2(9, 6));
	block.var[16] = (ivec2(-8, 1));
	block.var[17] = (ivec2(-3, 2));
	block.var[18] = (ivec2(-3, -1));
}
#version 450
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
	highp ivec4 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((block.var[0]), ivec4(-7, 9, -5, 6)) && allOk;
	allOk = compare_ivec4((block.var[1]), ivec4(3, 4, 2, -3)) && allOk;
	allOk = compare_ivec4((block.var[2]), ivec4(-3, -3, -5, -5)) && allOk;
	allOk = compare_ivec4((block.var[3]), ivec4(3, -5, -9, -7)) && allOk;
	allOk = compare_ivec4((block.var[4]), ivec4(1, 5, 9, 7)) && allOk;
	allOk = compare_ivec4((block.var[5]), ivec4(-4, -1, 8, -1)) && allOk;
	allOk = compare_ivec4((block.var[6]), ivec4(4, 3, 6, -6)) && allOk;
	allOk = compare_ivec4((block.var[7]), ivec4(1, -3, 0, 0)) && allOk;
	allOk = compare_ivec4((block.var[8]), ivec4(1, -6, 0, -7)) && allOk;
	allOk = compare_ivec4((block.var[9]), ivec4(6, -4, -4, 0)) && allOk;
	allOk = compare_ivec4((block.var[10]), ivec4(8, -3, 3, 3)) && allOk;
	allOk = compare_ivec4((block.var[11]), ivec4(-3, 1, 3, 1)) && allOk;
	allOk = compare_ivec4((block.var[12]), ivec4(-7, 2, 6, -5)) && allOk;
	allOk = compare_ivec4((block.var[13]), ivec4(1, 5, 7, 9)) && allOk;
	allOk = compare_ivec4((block.var[14]), ivec4(-6, 4, 0, 9)) && allOk;
	allOk = compare_ivec4((block.var[15]), ivec4(-3, 6, -6, -6)) && allOk;
	allOk = compare_ivec4((block.var[16]), ivec4(1, -6, -3, 5)) && allOk;
	allOk = compare_ivec4((block.var[17]), ivec4(9, -7, -1, -9)) && allOk;
	allOk = compare_ivec4((block.var[18]), ivec4(8, -5, 1, -2)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (ivec4(5, -9, 5, -6));
	block.var[1] = (ivec4(-2, -4, 1, -9));
	block.var[2] = (ivec4(7, 3, 6, 8));
	block.var[3] = (ivec4(6, -4, 6, -7));
	block.var[4] = (ivec4(9, -8, -9, 0));
	block.var[5] = (ivec4(5, -7, 2, 9));
	block.var[6] = (ivec4(6, 5, 4, 0));
	block.var[7] = (ivec4(5, 9, 0, 0));
	block.var[8] = (ivec4(-6, 4, 4, 2));
	block.var[9] = (ivec4(9, 7, 5, 5));
	block.var[10] = (ivec4(3, -3, -9, -8));
	block.var[11] = (ivec4(-6, 3, 2, 0));
	block.var[12] = (ivec4(7, 1, -4, 4));
	block.var[13] = (ivec4(-2, 5, -8, 0));
	block.var[14] = (ivec4(8, -9, -8, -3));
	block.var[15] = (ivec4(3, -9, -5, -4));
	block.var[16] = (ivec4(-8, 8, -3, 2));
	block.var[17] = (ivec4(-2, -6, 4, -5));
	block.var[18] = (ivec4(6, 8, -7, -2));
}
#version 450
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
	highp mat4 var[];
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
	allOk = compare_mat4(block.var[0], mat4(1.0, 6.0, 7.0, 5.0, 2.0, -4.0, 0.0, 8.0, 3.0, 3.0, 9.0, 8.0, -2.0, 7.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[1], mat4(-1.0, 1.0, 9.0, 1.0, -2.0, -7.0, 3.0, 5.0, 2.0, -8.0, 8.0, -1.0, -4.0, -5.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[2], mat4(-9.0, 1.0, 1.0, -6.0, 5.0, -8.0, -6.0, -3.0, -4.0, 8.0, 9.0, -9.0, -4.0, -2.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[3], mat4(-7.0, -7.0, 7.0, -7.0, 4.0, 1.0, -4.0, -7.0, 6.0, -4.0, -3.0, -1.0, -2.0, -9.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[4], mat4(0.0, -8.0, 2.0, 0.0, -4.0, 1.0, 6.0, 1.0, 2.0, -1.0, -8.0, -9.0, -1.0, -9.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[5], mat4(-8.0, -3.0, -4.0, -8.0, 3.0, 1.0, 4.0, -4.0, -2.0, 6.0, -8.0, 3.0, 7.0, 5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[6], mat4(-3.0, 8.0, 3.0, 5.0, 3.0, 4.0, 5.0, 4.0, -2.0, -6.0, -8.0, -4.0, -5.0, -1.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[7], mat4(3.0, -1.0, -2.0, -6.0, -8.0, 2.0, 9.0, -9.0, 2.0, -3.0, 5.0, -1.0, -5.0, -4.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[8], mat4(9.0, 9.0, 2.0, -3.0, -5.0, 5.0, 4.0, -6.0, -7.0, -1.0, -4.0, 6.0, -7.0, -9.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[9], mat4(-5.0, -1.0, 3.0, -4.0, 5.0, -7.0, -2.0, 3.0, 0.0, -1.0, 7.0, 5.0, -6.0, -1.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[10], mat4(1.0, -9.0, -6.0, 7.0, 6.0, 4.0, -5.0, 0.0, 8.0, -4.0, -3.0, -6.0, -7.0, 4.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[11], mat4(-2.0, 4.0, -8.0, 7.0, -3.0, 2.0, -9.0, -8.0, 8.0, 9.0, -5.0, 0.0, 4.0, 3.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[12], mat4(-3.0, 4.0, 8.0, 3.0, 4.0, -3.0, -4.0, -1.0, -4.0, 5.0, -4.0, 7.0, -7.0, 3.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[13], mat4(-6.0, -2.0, 6.0, 9.0, 8.0, -2.0, 0.0, 5.0, -9.0, 5.0, -1.0, 4.0, -3.0, 8.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[14], mat4(0.0, -2.0, 6.0, -1.0, 9.0, 9.0, -9.0, 0.0, 4.0, -3.0, 4.0, 1.0, -1.0, 3.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[15], mat4(-2.0, -2.0, 2.0, -3.0, 4.0, -1.0, 6.0, -4.0, 3.0, 0.0, 8.0, 1.0, -9.0, 8.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[16], mat4(1.0, -7.0, -9.0, 0.0, -1.0, -2.0, -1.0, 9.0, -9.0, 0.0, -4.0, -1.0, -6.0, 2.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[17], mat4(-2.0, -9.0, -3.0, 9.0, -7.0, -2.0, 7.0, 7.0, 1.0, 9.0, -4.0, 7.0, 0.0, 3.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[18], mat4(1.0, 6.0, -9.0, -8.0, -5.0, -5.0, 8.0, 1.0, 7.0, -6.0, -8.0, 7.0, -7.0, -3.0, -2.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec4(-3.0, -6.0, 8.0, 7.0));
	block.var[0][1] = (vec4(-8.0, 6.0, 1.0, -6.0));
	block.var[0][2] = (vec4(6.0, 0.0, -6.0, 3.0));
	block.var[0][3] = (vec4(3.0, 3.0, -3.0, 2.0));
	block.var[1][0] = (vec4(-8.0, 9.0, -6.0, 6.0));
	block.var[1][1] = (vec4(1.0, 9.0, -7.0, 4.0));
	block.var[1][2] = (vec4(-5.0, 5.0, -6.0, 5.0));
	block.var[1][3] = (vec4(7.0, 7.0, -5.0, -9.0));
	block.var[2][0] = (vec4(7.0, -2.0, -1.0, -4.0));
	block.var[2][1] = (vec4(-3.0, 3.0, -8.0, 7.0));
	block.var[2][2] = (vec4(-8.0, -5.0, -9.0, -1.0));
	block.var[2][3] = (vec4(0.0, -7.0, 7.0, 8.0));
	block.var[3][0] = (vec4(-6.0, -6.0, -1.0, 6.0));
	block.var[3][1] = (vec4(3.0, 5.0, -8.0, 3.0));
	block.var[3][2] = (vec4(1.0, -1.0, 3.0, -5.0));
	block.var[3][3] = (vec4(4.0, -4.0, 3.0, 4.0));
	block.var[4][0] = (vec4(-4.0, -8.0, 4.0, 5.0));
	block.var[4][1] = (vec4(-5.0, 0.0, -3.0, -4.0));
	block.var[4][2] = (vec4(5.0, -4.0, -7.0, 4.0));
	block.var[4][3] = (vec4(-3.0, 9.0, 3.0, -4.0));
	block.var[5][0] = (vec4(-3.0, -9.0, 6.0, -3.0));
	block.var[5][1] = (vec4(-6.0, -1.0, 8.0, 3.0));
	block.var[5][2] = (vec4(-2.0, 9.0, -2.0, -3.0));
	block.var[5][3] = (vec4(-8.0, 3.0, -8.0, 5.0));
	block.var[6][0] = (vec4(7.0, -2.0, -7.0, 3.0));
	block.var[6][1] = (vec4(8.0, -7.0, -6.0, 4.0));
	block.var[6][2] = (vec4(-4.0, 6.0, -2.0, -7.0));
	block.var[6][3] = (vec4(7.0, 8.0, -8.0, -2.0));
	block.var[7][0] = (vec4(-8.0, 3.0, 9.0, 3.0));
	block.var[7][1] = (vec4(1.0, -3.0, -5.0, -8.0));
	block.var[7][2] = (vec4(-7.0, 5.0, -1.0, -6.0));
	block.var[7][3] = (vec4(8.0, -8.0, 4.0, 8.0));
	block.var[8][0] = (vec4(6.0, -5.0, 4.0, -3.0));
	block.var[8][1] = (vec4(-1.0, -8.0, 3.0, 5.0));
	block.var[8][2] = (vec4(0.0, 7.0, 6.0, -4.0));
	block.var[8][3] = (vec4(1.0, 4.0, 3.0, 6.0));
	block.var[9][0] = (vec4(-3.0, -8.0, -6.0, 5.0));
	block.var[9][1] = (vec4(-9.0, -3.0, 0.0, -1.0));
	block.var[9][2] = (vec4(-5.0, 9.0, -8.0, -9.0));
	block.var[9][3] = (vec4(-1.0, 2.0, 5.0, 6.0));
	block.var[10][0] = (vec4(2.0, 3.0, 8.0, 8.0));
	block.var[10][1] = (vec4(-7.0, -1.0, 5.0, -3.0));
	block.var[10][2] = (vec4(5.0, -3.0, -4.0, 6.0));
	block.var[10][3] = (vec4(-6.0, -5.0, 7.0, -6.0));
	block.var[11][0] = (vec4(7.0, -3.0, -8.0, 1.0));
	block.var[11][1] = (vec4(1.0, 2.0, 3.0, 1.0));
	block.var[11][2] = (vec4(5.0, -2.0, 2.0, -2.0));
	block.var[11][3] = (vec4(-9.0, -1.0, 2.0, -1.0));
	block.var[12][0] = (vec4(8.0, -9.0, 9.0, 7.0));
	block.var[12][1] = (vec4(-9.0, 5.0, 1.0, -4.0));
	block.var[12][2] = (vec4(-1.0, -2.0, 1.0, 5.0));
	block.var[12][3] = (vec4(-1.0, -5.0, 7.0, -6.0));
	block.var[13][0] = (vec4(1.0, 0.0, 9.0, -3.0));
	block.var[13][1] = (vec4(7.0, 0.0, -6.0, -7.0));
	block.var[13][2] = (vec4(-8.0, 1.0, -2.0, 9.0));
	block.var[13][3] = (vec4(0.0, -2.0, 6.0, -1.0));
	block.var[14][0] = (vec4(-5.0, -1.0, -3.0, 5.0));
	block.var[14][1] = (vec4(-7.0, 4.0, 5.0, -9.0));
	block.var[14][2] = (vec4(-1.0, 0.0, 8.0, 8.0));
	block.var[14][3] = (vec4(-3.0, 4.0, -4.0, -4.0));
	block.var[15][0] = (vec4(5.0, 8.0, -8.0, -1.0));
	block.var[15][1] = (vec4(-7.0, 8.0, 4.0, -1.0));
	block.var[15][2] = (vec4(-1.0, -9.0, 3.0, 2.0));
	block.var[15][3] = (vec4(4.0, -2.0, 7.0, 5.0));
	block.var[16][0] = (vec4(0.0, -5.0, 2.0, 2.0));
	block.var[16][1] = (vec4(4.0, 4.0, -9.0, 3.0));
	block.var[16][2] = (vec4(1.0, 0.0, 5.0, -8.0));
	block.var[16][3] = (vec4(-3.0, -3.0, 3.0, -6.0));
	block.var[17][0] = (vec4(-5.0, 9.0, 0.0, -6.0));
	block.var[17][1] = (vec4(-2.0, -4.0, 3.0, 1.0));
	block.var[17][2] = (vec4(4.0, 1.0, -3.0, 6.0));
	block.var[17][3] = (vec4(-2.0, -7.0, -7.0, 9.0));
	block.var[18][0] = (vec4(-2.0, -6.0, -2.0, -5.0));
	block.var[18][1] = (vec4(-9.0, 4.0, 4.0, -5.0));
	block.var[18][2] = (vec4(-1.0, -1.0, 0.0, -7.0));
	block.var[18][3] = (vec4(5.0, 7.0, -3.0, -7.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0], mat4x2(-2.0, 6.0, 5.0, 7.0, 1.0, -5.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(4.0, -5.0, -7.0, -4.0, 7.0, 7.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(-1.0, 7.0, -9.0, -7.0, -1.0, 8.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[3], mat4x2(-4.0, 7.0, -5.0, -3.0, 4.0, 7.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[4], mat4x2(9.0, -5.0, 9.0, 2.0, -1.0, -1.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[5], mat4x2(-6.0, -7.0, 4.0, 4.0, 9.0, -9.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[6], mat4x2(-1.0, -8.0, 5.0, -8.0, 2.0, 3.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[7], mat4x2(0.0, 4.0, -8.0, -3.0, -1.0, 4.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[8], mat4x2(4.0, 5.0, -7.0, 1.0, 0.0, -9.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[9], mat4x2(-2.0, 4.0, -8.0, 5.0, -3.0, 8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[10], mat4x2(5.0, -9.0, 5.0, -2.0, -8.0, -1.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[11], mat4x2(3.0, 5.0, 1.0, 5.0, -3.0, -4.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[12], mat4x2(-1.0, 3.0, -9.0, 4.0, -2.0, 2.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[13], mat4x2(-3.0, 7.0, -5.0, 3.0, 2.0, -1.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[14], mat4x2(6.0, 9.0, -5.0, 0.0, 7.0, 6.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[15], mat4x2(-7.0, -3.0, -5.0, 2.0, 3.0, -3.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[16], mat4x2(5.0, -7.0, -9.0, 8.0, 8.0, -7.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[17], mat4x2(-6.0, 8.0, -1.0, 0.0, 6.0, -2.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[18], mat4x2(-4.0, 1.0, -2.0, 4.0, 1.0, -8.0, 8.0, -1.0)) && allOk;
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
	block.var[3][0] = (vec2(-8.0, -1.0));
	block.var[3][1] = (vec2(-3.0, 0.0));
	block.var[3][2] = (vec2(7.0, 5.0));
	block.var[3][3] = (vec2(-8.0, 5.0));
	block.var[4][0] = (vec2(7.0, 8.0));
	block.var[4][1] = (vec2(4.0, -2.0));
	block.var[4][2] = (vec2(4.0, -2.0));
	block.var[4][3] = (vec2(-2.0, 9.0));
	block.var[5][0] = (vec2(4.0, -4.0));
	block.var[5][1] = (vec2(-5.0, -5.0));
	block.var[5][2] = (vec2(-6.0, 8.0));
	block.var[5][3] = (vec2(9.0, -5.0));
	block.var[6][0] = (vec2(-2.0, 1.0));
	block.var[6][1] = (vec2(6.0, -2.0));
	block.var[6][2] = (vec2(2.0, -5.0));
	block.var[6][3] = (vec2(3.0, -3.0));
	block.var[7][0] = (vec2(-6.0, -4.0));
	block.var[7][1] = (vec2(-6.0, -7.0));
	block.var[7][2] = (vec2(9.0, 1.0));
	block.var[7][3] = (vec2(-4.0, 3.0));
	block.var[8][0] = (vec2(7.0, -9.0));
	block.var[8][1] = (vec2(7.0, -4.0));
	block.var[8][2] = (vec2(8.0, -2.0));
	block.var[8][3] = (vec2(9.0, 0.0));
	block.var[9][0] = (vec2(-9.0, 7.0));
	block.var[9][1] = (vec2(1.0, 4.0));
	block.var[9][2] = (vec2(-7.0, 9.0));
	block.var[9][3] = (vec2(-5.0, 2.0));
	block.var[10][0] = (vec2(-9.0, -3.0));
	block.var[10][1] = (vec2(-8.0, 5.0));
	block.var[10][2] = (vec2(-2.0, -8.0));
	block.var[10][3] = (vec2(7.0, -6.0));
	block.var[11][0] = (vec2(-7.0, 1.0));
	block.var[11][1] = (vec2(-3.0, 7.0));
	block.var[11][2] = (vec2(6.0, -5.0));
	block.var[11][3] = (vec2(9.0, -2.0));
	block.var[12][0] = (vec2(-9.0, -3.0));
	block.var[12][1] = (vec2(5.0, -5.0));
	block.var[12][2] = (vec2(3.0, 4.0));
	block.var[12][3] = (vec2(-9.0, 1.0));
	block.var[13][0] = (vec2(0.0, 8.0));
	block.var[13][1] = (vec2(-8.0, 3.0));
	block.var[13][2] = (vec2(-7.0, 9.0));
	block.var[13][3] = (vec2(-8.0, -7.0));
	block.var[14][0] = (vec2(7.0, 1.0));
	block.var[14][1] = (vec2(-1.0, -2.0));
	block.var[14][2] = (vec2(-8.0, -3.0));
	block.var[14][3] = (vec2(9.0, -1.0));
	block.var[15][0] = (vec2(-2.0, 1.0));
	block.var[15][1] = (vec2(-8.0, -7.0));
	block.var[15][2] = (vec2(-5.0, 7.0));
	block.var[15][3] = (vec2(-5.0, -7.0));
	block.var[16][0] = (vec2(-5.0, 2.0));
	block.var[16][1] = (vec2(-4.0, 8.0));
	block.var[16][2] = (vec2(-7.0, 6.0));
	block.var[16][3] = (vec2(5.0, 2.0));
	block.var[17][0] = (vec2(-5.0, 3.0));
	block.var[17][1] = (vec2(-9.0, 7.0));
	block.var[17][2] = (vec2(-3.0, -3.0));
	block.var[17][3] = (vec2(-7.0, -4.0));
	block.var[18][0] = (vec2(3.0, 7.0));
	block.var[18][1] = (vec2(-6.0, -7.0));
	block.var[18][2] = (vec2(-7.0, 5.0));
	block.var[18][3] = (vec2(-8.0, 4.0));
}
#version 450
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
	int8_t var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(block.var[0]), 4294967292) && allOk;
	allOk = compare_int8_t(int(block.var[1]), 3) && allOk;
	allOk = compare_int8_t(int(block.var[2]), 3) && allOk;
	allOk = compare_int8_t(int(block.var[3]), 1) && allOk;
	allOk = compare_int8_t(int(block.var[4]), 6) && allOk;
	allOk = compare_int8_t(int(block.var[5]), 8) && allOk;
	allOk = compare_int8_t(int(block.var[6]), 5) && allOk;
	allOk = compare_int8_t(int(block.var[7]), 2) && allOk;
	allOk = compare_int8_t(int(block.var[8]), 0) && allOk;
	allOk = compare_int8_t(int(block.var[9]), 4294967292) && allOk;
	allOk = compare_int8_t(int(block.var[10]), 4294967287) && allOk;
	allOk = compare_int8_t(int(block.var[11]), 4294967289) && allOk;
	allOk = compare_int8_t(int(block.var[12]), 4294967292) && allOk;
	allOk = compare_int8_t(int(block.var[13]), 4294967291) && allOk;
	allOk = compare_int8_t(int(block.var[14]), 7) && allOk;
	allOk = compare_int8_t(int(block.var[15]), 4294967293) && allOk;
	allOk = compare_int8_t(int(block.var[16]), 8) && allOk;
	allOk = compare_int8_t(int(block.var[17]), 4294967292) && allOk;
	allOk = compare_int8_t(int(block.var[18]), 4294967291) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = int8_t(4294967290);
	block.var[1] = int8_t(4294967294);
	block.var[2] = int8_t(3);
	block.var[3] = int8_t(4294967288);
	block.var[4] = int8_t(1);
	block.var[5] = int8_t(2);
	block.var[6] = int8_t(4294967288);
	block.var[7] = int8_t(4294967294);
	block.var[8] = int8_t(7);
	block.var[9] = int8_t(9);
	block.var[10] = int8_t(0);
	block.var[11] = int8_t(4294967292);
	block.var[12] = int8_t(0);
	block.var[13] = int8_t(4294967289);
	block.var[14] = int8_t(1);
	block.var[15] = int8_t(7);
	block.var[16] = int8_t(4294967287);
	block.var[17] = int8_t(4294967289);
	block.var[18] = int8_t(6);
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0], mat2x4(-9.0, -2.0, -2.0, -1.0, -8.0, -3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1], mat2x4(-4.0, 1.0, 0.0, -7.0, 3.0, -6.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2], mat2x4(5.0, 4.0, -2.0, 4.0, 2.0, -4.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0], mat2x4(2.0, -7.0, -6.0, -5.0, 6.0, 3.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1], mat2x4(0.0, -7.0, 0.0, 0.0, 6.0, -7.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2], mat2x4(-4.0, -2.0, -3.0, 7.0, -4.0, 6.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0], mat2x4(-3.0, 2.0, -6.0, -2.0, -7.0, -5.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1], mat2x4(-8.0, 4.0, -2.0, 8.0, 5.0, -2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2], mat2x4(-1.0, -5.0, -5.0, 6.0, -9.0, 1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0], mat2x4(3.0, 8.0, -1.0, 5.0, -1.0, 8.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1], mat2x4(3.0, -9.0, -2.0, 3.0, -1.0, -9.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][2], mat2x4(-2.0, 8.0, -1.0, 6.0, -7.0, 7.0, 5.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec4(-3.0, 4.0, -6.0, 2.0));
	block.var[0][0][1] = (vec4(-4.0, -6.0, -3.0, 6.0));
	block.var[0][1][0] = (vec4(-5.0, 1.0, 6.0, 1.0));
	block.var[0][1][1] = (vec4(1.0, 7.0, 0.0, 9.0));
	block.var[0][2][0] = (vec4(8.0, 6.0, -7.0, -4.0));
	block.var[0][2][1] = (vec4(-6.0, 5.0, 5.0, -6.0));
	block.var[1][0][0] = (vec4(5.0, -4.0, 0.0, 2.0));
	block.var[1][0][1] = (vec4(-8.0, 6.0, 9.0, 4.0));
	block.var[1][1][0] = (vec4(-8.0, 0.0, -2.0, -3.0));
	block.var[1][1][1] = (vec4(-7.0, 4.0, 2.0, -2.0));
	block.var[1][2][0] = (vec4(2.0, 3.0, 8.0, -9.0));
	block.var[1][2][1] = (vec4(-7.0, 3.0, -4.0, -7.0));
	block.var[2][0][0] = (vec4(-3.0, -1.0, -6.0, -2.0));
	block.var[2][0][1] = (vec4(-8.0, 6.0, 0.0, 4.0));
	block.var[2][1][0] = (vec4(0.0, -8.0, -6.0, 7.0));
	block.var[2][1][1] = (vec4(3.0, -7.0, -4.0, 3.0));
	block.var[2][2][0] = (vec4(-8.0, 2.0, 8.0, -7.0));
	block.var[2][2][1] = (vec4(5.0, -9.0, 7.0, 7.0));
	block.var[3][0][0] = (vec4(6.0, 7.0, -7.0, 4.0));
	block.var[3][0][1] = (vec4(0.0, 8.0, -1.0, -1.0));
	block.var[3][1][0] = (vec4(4.0, -5.0, 4.0, 6.0));
	block.var[3][1][1] = (vec4(9.0, 0.0, 5.0, -9.0));
	block.var[3][2][0] = (vec4(2.0, 0.0, -8.0, 6.0));
	block.var[3][2][1] = (vec4(1.0, 2.0, 2.0, -6.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0], mat4x2(4.0, -5.0, -2.0, 7.0, 3.0, 2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1], mat4x2(-7.0, -1.0, -9.0, 4.0, -9.0, -4.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2], mat4x2(-7.0, -7.0, 4.0, 6.0, 6.0, -6.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0], mat4x2(-1.0, 1.0, 8.0, 3.0, 5.0, -2.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1], mat4x2(3.0, 8.0, -6.0, 7.0, 4.0, -6.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2], mat4x2(-5.0, -6.0, 1.0, 5.0, 0.0, -2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0], mat4x2(3.0, -9.0, 6.0, -5.0, 3.0, -2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1], mat4x2(-2.0, 0.0, 8.0, 5.0, -1.0, 3.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2], mat4x2(-2.0, -7.0, 7.0, 1.0, 2.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0], mat4x2(1.0, 4.0, 5.0, -1.0, -2.0, 5.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1], mat4x2(-4.0, 2.0, 1.0, -4.0, 1.0, -1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][2], mat4x2(-9.0, 2.0, -1.0, 8.0, 2.0, 1.0, -4.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec2(2.0, -4.0));
	block.var[0][0][1] = (vec2(-5.0, 3.0));
	block.var[0][0][2] = (vec2(7.0, 1.0));
	block.var[0][0][3] = (vec2(8.0, -5.0));
	block.var[0][1][0] = (vec2(7.0, -3.0));
	block.var[0][1][1] = (vec2(1.0, -6.0));
	block.var[0][1][2] = (vec2(9.0, -3.0));
	block.var[0][1][3] = (vec2(1.0, -5.0));
	block.var[0][2][0] = (vec2(-8.0, 4.0));
	block.var[0][2][1] = (vec2(5.0, -9.0));
	block.var[0][2][2] = (vec2(1.0, -5.0));
	block.var[0][2][3] = (vec2(-4.0, -2.0));
	block.var[1][0][0] = (vec2(6.0, -1.0));
	block.var[1][0][1] = (vec2(-7.0, -5.0));
	block.var[1][0][2] = (vec2(-2.0, -8.0));
	block.var[1][0][3] = (vec2(1.0, 3.0));
	block.var[1][1][0] = (vec2(4.0, 2.0));
	block.var[1][1][1] = (vec2(-9.0, 2.0));
	block.var[1][1][2] = (vec2(-3.0, 3.0));
	block.var[1][1][3] = (vec2(0.0, 1.0));
	block.var[1][2][0] = (vec2(-5.0, -9.0));
	block.var[1][2][1] = (vec2(2.0, -2.0));
	block.var[1][2][2] = (vec2(-3.0, 0.0));
	block.var[1][2][3] = (vec2(9.0, 6.0));
	block.var[2][0][0] = (vec2(3.0, -4.0));
	block.var[2][0][1] = (vec2(2.0, -3.0));
	block.var[2][0][2] = (vec2(6.0, 5.0));
	block.var[2][0][3] = (vec2(0.0, -2.0));
	block.var[2][1][0] = (vec2(-3.0, -2.0));
	block.var[2][1][1] = (vec2(-7.0, 3.0));
	block.var[2][1][2] = (vec2(-6.0, 2.0));
	block.var[2][1][3] = (vec2(9.0, 6.0));
	block.var[2][2][0] = (vec2(-4.0, 4.0));
	block.var[2][2][1] = (vec2(0.0, -3.0));
	block.var[2][2][2] = (vec2(-7.0, 0.0));
	block.var[2][2][3] = (vec2(-9.0, 1.0));
	block.var[3][0][0] = (vec2(7.0, 2.0));
	block.var[3][0][1] = (vec2(1.0, 9.0));
	block.var[3][0][2] = (vec2(-3.0, 3.0));
	block.var[3][0][3] = (vec2(-7.0, 9.0));
	block.var[3][1][0] = (vec2(-4.0, -1.0));
	block.var[3][1][1] = (vec2(3.0, 6.0));
	block.var[3][1][2] = (vec2(8.0, 3.0));
	block.var[3][1][3] = (vec2(1.0, 5.0));
	block.var[3][2][0] = (vec2(7.0, 0.0));
	block.var[3][2][1] = (vec2(0.0, -2.0));
	block.var[3][2][2] = (vec2(3.0, -7.0));
	block.var[3][2][3] = (vec2(-3.0, 1.0));
}
#version 450
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
	highp vec2 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((block.var[0][0][0]), vec2(5.0, 4.0)) && allOk;
	allOk = compare_vec2((block.var[0][0][1]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((block.var[0][0][2]), vec2(-7.0, -5.0)) && allOk;
	allOk = compare_vec2((block.var[0][1][0]), vec2(-1.0, -4.0)) && allOk;
	allOk = compare_vec2((block.var[0][1][1]), vec2(6.0, -7.0)) && allOk;
	allOk = compare_vec2((block.var[0][1][2]), vec2(-8.0, 7.0)) && allOk;
	allOk = compare_vec2((block.var[1][0][0]), vec2(-9.0, 7.0)) && allOk;
	allOk = compare_vec2((block.var[1][0][1]), vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec2((block.var[1][0][2]), vec2(-8.0, 2.0)) && allOk;
	allOk = compare_vec2((block.var[1][1][0]), vec2(2.0, -3.0)) && allOk;
	allOk = compare_vec2((block.var[1][1][1]), vec2(4.0, -5.0)) && allOk;
	allOk = compare_vec2((block.var[1][1][2]), vec2(-6.0, -4.0)) && allOk;
	allOk = compare_vec2((block.var[2][0][0]), vec2(4.0, -2.0)) && allOk;
	allOk = compare_vec2((block.var[2][0][1]), vec2(2.0, 2.0)) && allOk;
	allOk = compare_vec2((block.var[2][0][2]), vec2(-8.0, 3.0)) && allOk;
	allOk = compare_vec2((block.var[2][1][0]), vec2(-5.0, 7.0)) && allOk;
	allOk = compare_vec2((block.var[2][1][1]), vec2(1.0, -2.0)) && allOk;
	allOk = compare_vec2((block.var[2][1][2]), vec2(-3.0, -5.0)) && allOk;
	allOk = compare_vec2((block.var[3][0][0]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((block.var[3][0][1]), vec2(7.0, 5.0)) && allOk;
	allOk = compare_vec2((block.var[3][0][2]), vec2(-6.0, -1.0)) && allOk;
	allOk = compare_vec2((block.var[3][1][0]), vec2(5.0, -8.0)) && allOk;
	allOk = compare_vec2((block.var[3][1][1]), vec2(-1.0, -7.0)) && allOk;
	allOk = compare_vec2((block.var[3][1][2]), vec2(-7.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec2(3.0, 8.0));
	block.var[0][0][1] = (vec2(7.0, -1.0));
	block.var[0][0][2] = (vec2(-4.0, 8.0));
	block.var[0][1][0] = (vec2(-6.0, -2.0));
	block.var[0][1][1] = (vec2(5.0, 4.0));
	block.var[0][1][2] = (vec2(0.0, 0.0));
	block.var[1][0][0] = (vec2(-2.0, -5.0));
	block.var[1][0][1] = (vec2(-2.0, 5.0));
	block.var[1][0][2] = (vec2(6.0, -2.0));
	block.var[1][1][0] = (vec2(-4.0, -9.0));
	block.var[1][1][1] = (vec2(-2.0, 2.0));
	block.var[1][1][2] = (vec2(-2.0, 8.0));
	block.var[2][0][0] = (vec2(-6.0, -6.0));
	block.var[2][0][1] = (vec2(1.0, 6.0));
	block.var[2][0][2] = (vec2(-7.0, 6.0));
	block.var[2][1][0] = (vec2(-4.0, -4.0));
	block.var[2][1][1] = (vec2(-2.0, -8.0));
	block.var[2][1][2] = (vec2(2.0, 9.0));
	block.var[3][0][0] = (vec2(1.0, -6.0));
	block.var[3][0][1] = (vec2(-9.0, 0.0));
	block.var[3][0][2] = (vec2(-8.0, -4.0));
	block.var[3][1][0] = (vec2(-8.0, 9.0));
	block.var[3][1][1] = (vec2(0.0, -8.0));
	block.var[3][1][2] = (vec2(1.0, 5.0));
}
#version 450
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
	bvec3 var[4][2][3];
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
	allOk = compare_bvec3((block.var[0][0][2]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((block.var[0][1][0]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((block.var[0][1][1]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((block.var[0][1][2]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[1][0][0]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((block.var[1][0][1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[1][0][2]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((block.var[1][1][0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((block.var[1][1][1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[1][1][2]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((block.var[2][0][0]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((block.var[2][0][1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((block.var[2][0][2]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((block.var[2][1][0]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((block.var[2][1][1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[2][1][2]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((block.var[3][0][0]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((block.var[3][0][1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[3][0][2]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[3][1][0]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((block.var[3][1][1]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((block.var[3][1][2]), bvec3(false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (bvec3(true, true, false));
	block.var[0][0][1] = (bvec3(false, true, true));
	block.var[0][0][2] = (bvec3(false, false, false));
	block.var[0][1][0] = (bvec3(false, false, true));
	block.var[0][1][1] = (bvec3(true, false, true));
	block.var[0][1][2] = (bvec3(false, false, false));
	block.var[1][0][0] = (bvec3(true, false, false));
	block.var[1][0][1] = (bvec3(true, true, true));
	block.var[1][0][2] = (bvec3(false, true, true));
	block.var[1][1][0] = (bvec3(true, true, false));
	block.var[1][1][1] = (bvec3(false, false, true));
	block.var[1][1][2] = (bvec3(false, false, true));
	block.var[2][0][0] = (bvec3(false, true, true));
	block.var[2][0][1] = (bvec3(true, true, true));
	block.var[2][0][2] = (bvec3(true, true, true));
	block.var[2][1][0] = (bvec3(true, true, false));
	block.var[2][1][1] = (bvec3(false, true, false));
	block.var[2][1][2] = (bvec3(false, true, false));
	block.var[3][0][0] = (bvec3(true, false, false));
	block.var[3][0][1] = (bvec3(false, true, false));
	block.var[3][0][2] = (bvec3(true, false, false));
	block.var[3][1][0] = (bvec3(false, false, false));
	block.var[3][1][1] = (bvec3(true, true, false));
	block.var[3][1][2] = (bvec3(false, true, false));
}
#version 450
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
	allOk = compare_mat3(block.var[0][0][0], mat3(-8.0, -9.0, -7.0, -7.0, 8.0, 7.0, 4.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(5.0, -4.0, 7.0, -4.0, -3.0, 8.0, 7.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][2], mat3(1.0, 6.0, 8.0, -9.0, -1.0, 8.0, 8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(-7.0, 8.0, -6.0, -9.0, -8.0, 8.0, 0.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(-6.0, 0.0, -3.0, 9.0, 7.0, -8.0, -9.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][2], mat3(-8.0, 9.0, 0.0, -7.0, 1.0, -2.0, 3.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(-6.0, 4.0, -3.0, -2.0, 3.0, 7.0, 0.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(-1.0, 1.0, -9.0, 4.0, 6.0, 8.0, 8.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][2], mat3(3.0, 0.0, -4.0, 8.0, 3.0, 9.0, 3.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(6.0, 6.0, -4.0, 4.0, -2.0, 6.0, 2.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(2.0, 9.0, 6.0, -8.0, -6.0, -3.0, -4.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][2], mat3(-5.0, -8.0, 6.0, 2.0, 5.0, -6.0, 7.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(-8.0, 7.0, 2.0, -7.0, 4.0, -2.0, -5.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(-1.0, 2.0, 0.0, -9.0, -9.0, 6.0, -6.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][2], mat3(-4.0, -3.0, -3.0, 4.0, -6.0, -6.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(3.0, 4.0, -4.0, -1.0, -7.0, -1.0, 4.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(1.0, 1.0, 3.0, -6.0, -4.0, -2.0, -6.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][2], mat3(2.0, 3.0, 1.0, 8.0, 9.0, -4.0, -2.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][0], mat3(4.0, 6.0, -3.0, 5.0, -4.0, -6.0, -5.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][1], mat3(8.0, -1.0, -4.0, -2.0, 4.0, -8.0, 0.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][2], mat3(9.0, 6.0, 8.0, -7.0, 4.0, -8.0, 4.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][0], mat3(4.0, -9.0, 6.0, -1.0, 0.0, -2.0, 4.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][1], mat3(-8.0, 3.0, -2.0, 1.0, 3.0, -1.0, -8.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][2], mat3(-2.0, -4.0, -1.0, 1.0, -1.0, -8.0, -9.0, -9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3(5.0, 2.0, 8.0, 8.0, 3.0, -2.0, 2.0, -8.0, -5.0));
	block.var[0][0][1] = (mat3(-6.0, -1.0, 7.0, -5.0, -5.0, 8.0, -2.0, -5.0, 5.0));
	block.var[0][0][2] = (mat3(3.0, 9.0, -7.0, -2.0, 3.0, 5.0, 5.0, 1.0, -6.0));
	block.var[0][1][0] = (mat3(-9.0, 2.0, -8.0, 1.0, -5.0, 5.0, 8.0, -6.0, 7.0));
	block.var[0][1][1] = (mat3(-1.0, 7.0, -7.0, 7.0, 5.0, -9.0, 5.0, 3.0, -1.0));
	block.var[0][1][2] = (mat3(6.0, -3.0, 9.0, 7.0, 0.0, 2.0, 8.0, -5.0, -9.0));
	block.var[1][0][0] = (mat3(-5.0, 4.0, 9.0, -2.0, -6.0, 2.0, -1.0, 0.0, 2.0));
	block.var[1][0][1] = (mat3(9.0, -5.0, 7.0, 6.0, 8.0, 4.0, 5.0, -2.0, -5.0));
	block.var[1][0][2] = (mat3(7.0, -1.0, 1.0, -3.0, -8.0, 1.0, -4.0, 7.0, 1.0));
	block.var[1][1][0] = (mat3(-3.0, 0.0, 7.0, -7.0, 1.0, -6.0, -4.0, 1.0, -9.0));
	block.var[1][1][1] = (mat3(6.0, 9.0, 8.0, 5.0, 8.0, 1.0, 6.0, 4.0, -4.0));
	block.var[1][1][2] = (mat3(9.0, -4.0, 1.0, -5.0, 8.0, -3.0, 4.0, -9.0, -8.0));
	block.var[2][0][0] = (mat3(5.0, 8.0, -1.0, 8.0, 9.0, 6.0, -1.0, 5.0, -2.0));
	block.var[2][0][1] = (mat3(1.0, 4.0, -8.0, 8.0, 1.0, 2.0, 4.0, -7.0, 3.0));
	block.var[2][0][2] = (mat3(-1.0, -5.0, 2.0, 2.0, -1.0, -7.0, 7.0, -8.0, -6.0));
	block.var[2][1][0] = (mat3(-7.0, 7.0, -5.0, 5.0, 0.0, 7.0, -8.0, -5.0, 8.0));
	block.var[2][1][1] = (mat3(4.0, -8.0, -8.0, 3.0, -2.0, 4.0, 8.0, -1.0, -5.0));
	block.var[2][1][2] = (mat3(-5.0, -1.0, -1.0, 4.0, 9.0, 2.0, -2.0, -7.0, 2.0));
	block.var[3][0][0] = (mat3(5.0, -9.0, 2.0, 2.0, -9.0, -9.0, -2.0, 1.0, 8.0));
	block.var[3][0][1] = (mat3(-4.0, 8.0, -5.0, 5.0, -2.0, 2.0, 3.0, 3.0, -8.0));
	block.var[3][0][2] = (mat3(0.0, 2.0, 6.0, 2.0, -5.0, -9.0, 4.0, 6.0, -3.0));
	block.var[3][1][0] = (mat3(-5.0, -3.0, -3.0, 1.0, -3.0, -9.0, 5.0, 7.0, 7.0));
	block.var[3][1][1] = (mat3(6.0, 3.0, -3.0, 2.0, 0.0, 2.0, -1.0, 4.0, 2.0));
	block.var[3][1][2] = (mat3(2.0, 3.0, 2.0, -9.0, 3.0, 4.0, -6.0, -3.0, -9.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0][0][0], mat4(-8.0, 3.0, 4.0, 4.0, -5.0, 8.0, 6.0, 7.0, 4.0, 5.0, 7.0, -3.0, 0.0, 2.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][1], mat4(-1.0, -2.0, -3.0, 1.0, -9.0, -9.0, -6.0, 5.0, 6.0, 7.0, 6.0, 1.0, -8.0, -3.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][2], mat4(6.0, 0.0, 5.0, -6.0, -1.0, -6.0, -1.0, 6.0, 1.0, -1.0, 3.0, -1.0, 6.0, 4.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][0], mat4(1.0, 6.0, -6.0, 7.0, 9.0, 3.0, 0.0, 7.0, 0.0, 9.0, -9.0, 1.0, 4.0, -9.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][1], mat4(7.0, 7.0, -6.0, -6.0, 8.0, -2.0, 4.0, -6.0, 7.0, -4.0, -8.0, -2.0, -2.0, 3.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][2], mat4(0.0, -2.0, -9.0, 6.0, -2.0, -1.0, 8.0, 5.0, 1.0, 7.0, 0.0, -1.0, 1.0, -2.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][0], mat4(-3.0, 8.0, -3.0, -7.0, -4.0, -6.0, -1.0, 4.0, 9.0, -1.0, 6.0, -4.0, 0.0, -7.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][1], mat4(3.0, -9.0, -5.0, 9.0, -5.0, -7.0, 5.0, 0.0, -5.0, 4.0, 7.0, 2.0, -1.0, 9.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][2], mat4(6.0, -4.0, -9.0, 2.0, 1.0, 8.0, -6.0, 0.0, -7.0, -8.0, 5.0, -9.0, -9.0, -5.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][0], mat4(-9.0, -7.0, 3.0, -8.0, 8.0, 3.0, 6.0, -3.0, 8.0, -1.0, 8.0, 0.0, 5.0, 7.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][1], mat4(0.0, 6.0, -8.0, -6.0, 7.0, 9.0, 7.0, -8.0, 2.0, 6.0, 0.0, 5.0, -8.0, 5.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][2], mat4(0.0, 8.0, 3.0, 5.0, -1.0, 7.0, -5.0, 0.0, -3.0, -6.0, -8.0, -6.0, 6.0, -3.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][0], mat4(5.0, -7.0, -8.0, -6.0, 7.0, 3.0, 0.0, -4.0, 5.0, -2.0, 3.0, -9.0, 2.0, -2.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][1], mat4(-6.0, -8.0, 2.0, -5.0, 0.0, -2.0, 7.0, -3.0, 4.0, 4.0, 4.0, 5.0, 7.0, -1.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][2], mat4(-1.0, 5.0, 8.0, -3.0, -9.0, 9.0, -4.0, 5.0, 7.0, -3.0, 5.0, 6.0, -8.0, 2.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][0], mat4(0.0, 3.0, 3.0, 8.0, 3.0, 7.0, -3.0, 1.0, -8.0, 3.0, 7.0, -3.0, 7.0, 5.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][1], mat4(3.0, -1.0, 1.0, 1.0, -3.0, 9.0, 9.0, -5.0, 5.0, -1.0, 6.0, -1.0, -4.0, -9.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][2], mat4(-2.0, -9.0, 2.0, 5.0, 5.0, 4.0, 1.0, 4.0, -7.0, -4.0, -2.0, -8.0, -7.0, 9.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][0], mat4(-3.0, 3.0, 3.0, -3.0, -6.0, -5.0, 3.0, -7.0, -3.0, 7.0, -7.0, 2.0, 7.0, -9.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][1], mat4(-8.0, -8.0, 8.0, -1.0, -8.0, -1.0, 7.0, 1.0, 7.0, 3.0, -9.0, -3.0, 2.0, -2.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][2], mat4(8.0, 8.0, -7.0, -5.0, 0.0, -1.0, -6.0, -9.0, -8.0, -9.0, -1.0, -7.0, -3.0, -7.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][0], mat4(-9.0, 1.0, 7.0, -3.0, -8.0, 7.0, 0.0, 6.0, -9.0, -5.0, 9.0, -7.0, 6.0, -9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][1], mat4(-3.0, -7.0, -9.0, 0.0, 6.0, 2.0, -6.0, -9.0, -4.0, -6.0, 3.0, 4.0, 7.0, 1.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][2], mat4(-6.0, 7.0, 3.0, 2.0, 4.0, 8.0, 8.0, -3.0, -8.0, -1.0, -7.0, -6.0, 7.0, -3.0, -6.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(-9.0, 0.0, -1.0, -4.0));
	block.var[0][0][0][1] = (vec4(-9.0, -4.0, -9.0, -5.0));
	block.var[0][0][0][2] = (vec4(-2.0, 9.0, 0.0, -8.0));
	block.var[0][0][0][3] = (vec4(-6.0, -3.0, -8.0, 3.0));
	block.var[0][0][1][0] = (vec4(4.0, 9.0, 4.0, -3.0));
	block.var[0][0][1][1] = (vec4(7.0, -9.0, 6.0, 5.0));
	block.var[0][0][1][2] = (vec4(6.0, -1.0, -3.0, -3.0));
	block.var[0][0][1][3] = (vec4(-9.0, 3.0, -9.0, 0.0));
	block.var[0][0][2][0] = (vec4(1.0, -4.0, -6.0, 5.0));
	block.var[0][0][2][1] = (vec4(2.0, 1.0, 9.0, -4.0));
	block.var[0][0][2][2] = (vec4(-7.0, 7.0, 0.0, 7.0));
	block.var[0][0][2][3] = (vec4(9.0, 9.0, -5.0, -7.0));
	block.var[0][1][0][0] = (vec4(-1.0, -6.0, -8.0, -9.0));
	block.var[0][1][0][1] = (vec4(0.0, 3.0, 6.0, -1.0));
	block.var[0][1][0][2] = (vec4(4.0, 6.0, 8.0, 1.0));
	block.var[0][1][0][3] = (vec4(9.0, -4.0, 7.0, 7.0));
	block.var[0][1][1][0] = (vec4(2.0, -1.0, -8.0, 9.0));
	block.var[0][1][1][1] = (vec4(-1.0, 7.0, -4.0, 2.0));
	block.var[0][1][1][2] = (vec4(9.0, 2.0, -2.0, -1.0));
	block.var[0][1][1][3] = (vec4(7.0, 3.0, -6.0, 0.0));
	block.var[0][1][2][0] = (vec4(-7.0, -8.0, -7.0, 8.0));
	block.var[0][1][2][1] = (vec4(5.0, 7.0, -3.0, -2.0));
	block.var[0][1][2][2] = (vec4(9.0, -5.0, -2.0, -2.0));
	block.var[0][1][2][3] = (vec4(2.0, 4.0, -1.0, 9.0));
	block.var[1][0][0][0] = (vec4(-9.0, 5.0, 8.0, 6.0));
	block.var[1][0][0][1] = (vec4(4.0, 6.0, -1.0, -7.0));
	block.var[1][0][0][2] = (vec4(7.0, 8.0, 5.0, -1.0));
	block.var[1][0][0][3] = (vec4(8.0, 2.0, -8.0, 0.0));
	block.var[1][0][1][0] = (vec4(-9.0, -1.0, -5.0, 7.0));
	block.var[1][0][1][1] = (vec4(3.0, 1.0, 2.0, 2.0));
	block.var[1][0][1][2] = (vec4(-3.0, -7.0, 1.0, 0.0));
	block.var[1][0][1][3] = (vec4(9.0, 5.0, -2.0, 6.0));
	block.var[1][0][2][0] = (vec4(-9.0, 1.0, 2.0, -3.0));
	block.var[1][0][2][1] = (vec4(-2.0, -2.0, -8.0, -4.0));
	block.var[1][0][2][2] = (vec4(7.0, -4.0, -1.0, 2.0));
	block.var[1][0][2][3] = (vec4(7.0, 7.0, 2.0, 8.0));
	block.var[1][1][0][0] = (vec4(3.0, 3.0, 4.0, -8.0));
	block.var[1][1][0][1] = (vec4(-3.0, -9.0, 9.0, -7.0));
	block.var[1][1][0][2] = (vec4(-7.0, 9.0, -4.0, 0.0));
	block.var[1][1][0][3] = (vec4(-4.0, -3.0, 0.0, 6.0));
	block.var[1][1][1][0] = (vec4(-5.0, -7.0, 3.0, -9.0));
	block.var[1][1][1][1] = (vec4(4.0, 5.0, 0.0, -6.0));
	block.var[1][1][1][2] = (vec4(7.0, 4.0, 1.0, 9.0));
	block.var[1][1][1][3] = (vec4(-8.0, 8.0, 7.0, 4.0));
	block.var[1][1][2][0] = (vec4(-1.0, 5.0, 9.0, -2.0));
	block.var[1][1][2][1] = (vec4(-5.0, -8.0, 2.0, -5.0));
	block.var[1][1][2][2] = (vec4(3.0, -8.0, -1.0, -5.0));
	block.var[1][1][2][3] = (vec4(-6.0, -2.0, 3.0, 0.0));
	block.var[2][0][0][0] = (vec4(-5.0, 9.0, 9.0, 4.0));
	block.var[2][0][0][1] = (vec4(6.0, -2.0, -1.0, -2.0));
	block.var[2][0][0][2] = (vec4(0.0, 5.0, -4.0, 5.0));
	block.var[2][0][0][3] = (vec4(8.0, -8.0, 9.0, -3.0));
	block.var[2][0][1][0] = (vec4(4.0, -8.0, -1.0, 0.0));
	block.var[2][0][1][1] = (vec4(-3.0, -4.0, -7.0, 1.0));
	block.var[2][0][1][2] = (vec4(4.0, -2.0, 1.0, -8.0));
	block.var[2][0][1][3] = (vec4(-8.0, 5.0, 4.0, 7.0));
	block.var[2][0][2][0] = (vec4(7.0, -2.0, -6.0, 9.0));
	block.var[2][0][2][1] = (vec4(-7.0, -5.0, 2.0, 2.0));
	block.var[2][0][2][2] = (vec4(4.0, 8.0, 4.0, -9.0));
	block.var[2][0][2][3] = (vec4(0.0, -9.0, 0.0, 0.0));
	block.var[2][1][0][0] = (vec4(1.0, -3.0, -1.0, 9.0));
	block.var[2][1][0][1] = (vec4(-4.0, -5.0, 6.0, 9.0));
	block.var[2][1][0][2] = (vec4(-5.0, -7.0, 1.0, 2.0));
	block.var[2][1][0][3] = (vec4(-7.0, 2.0, -8.0, 9.0));
	block.var[2][1][1][0] = (vec4(-1.0, 2.0, 4.0, 1.0));
	block.var[2][1][1][1] = (vec4(5.0, -8.0, -7.0, 3.0));
	block.var[2][1][1][2] = (vec4(-5.0, 2.0, 5.0, 7.0));
	block.var[2][1][1][3] = (vec4(-9.0, 2.0, -7.0, 9.0));
	block.var[2][1][2][0] = (vec4(-7.0, 5.0, -6.0, -3.0));
	block.var[2][1][2][1] = (vec4(6.0, -2.0, 9.0, 1.0));
	block.var[2][1][2][2] = (vec4(0.0, -3.0, -6.0, -8.0));
	block.var[2][1][2][3] = (vec4(-4.0, 0.0, -2.0, 0.0));
	block.var[3][0][0][0] = (vec4(9.0, -1.0, -1.0, -3.0));
	block.var[3][0][0][1] = (vec4(-9.0, -6.0, -8.0, 4.0));
	block.var[3][0][0][2] = (vec4(-6.0, 9.0, -8.0, 3.0));
	block.var[3][0][0][3] = (vec4(0.0, 1.0, -1.0, -7.0));
	block.var[3][0][1][0] = (vec4(-9.0, -4.0, 4.0, 6.0));
	block.var[3][0][1][1] = (vec4(4.0, 9.0, 4.0, -4.0));
	block.var[3][0][1][2] = (vec4(3.0, -1.0, 2.0, 8.0));
	block.var[3][0][1][3] = (vec4(-3.0, -6.0, -4.0, 0.0));
	block.var[3][0][2][0] = (vec4(2.0, -1.0, 1.0, -1.0));
	block.var[3][0][2][1] = (vec4(8.0, 5.0, 3.0, 0.0));
	block.var[3][0][2][2] = (vec4(-2.0, 0.0, 7.0, -5.0));
	block.var[3][0][2][3] = (vec4(6.0, 0.0, 6.0, -6.0));
	block.var[3][1][0][0] = (vec4(-8.0, 9.0, 5.0, 6.0));
	block.var[3][1][0][1] = (vec4(-9.0, 1.0, 2.0, 8.0));
	block.var[3][1][0][2] = (vec4(2.0, 9.0, 8.0, 5.0));
	block.var[3][1][0][3] = (vec4(-8.0, 4.0, -3.0, -4.0));
	block.var[3][1][1][0] = (vec4(-5.0, -3.0, 4.0, -1.0));
	block.var[3][1][1][1] = (vec4(5.0, -5.0, 4.0, 2.0));
	block.var[3][1][1][2] = (vec4(-4.0, -6.0, -2.0, 5.0));
	block.var[3][1][1][3] = (vec4(-1.0, -4.0, 1.0, 6.0));
	block.var[3][1][2][0] = (vec4(-1.0, 0.0, 3.0, -1.0));
	block.var[3][1][2][1] = (vec4(9.0, 4.0, 8.0, 0.0));
	block.var[3][1][2][2] = (vec4(0.0, -3.0, -3.0, 1.0));
	block.var[3][1][2][3] = (vec4(4.0, 6.0, -3.0, -5.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0][0][0], mat4(9.0, 0.0, -9.0, -9.0, 5.0, -4.0, 8.0, 7.0, 8.0, -4.0, -5.0, -7.0, 8.0, 9.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][1], mat4(3.0, 4.0, 1.0, -3.0, 3.0, -2.0, -9.0, 6.0, -5.0, 3.0, 1.0, 3.0, -4.0, -9.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][2], mat4(6.0, -8.0, 2.0, 0.0, -3.0, -8.0, 3.0, -7.0, 8.0, -5.0, -6.0, -1.0, -7.0, 5.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][0], mat4(-3.0, 6.0, 6.0, -1.0, -2.0, -7.0, 1.0, 0.0, -5.0, 3.0, -7.0, 2.0, 6.0, 9.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][1], mat4(5.0, -4.0, -3.0, 9.0, -8.0, -9.0, 2.0, 5.0, -3.0, -3.0, -4.0, 9.0, -2.0, -8.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][2], mat4(-9.0, 0.0, 3.0, 0.0, 6.0, -5.0, 8.0, 6.0, -3.0, -9.0, -1.0, 2.0, 3.0, -7.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][0], mat4(8.0, -5.0, -2.0, -1.0, 5.0, 7.0, 2.0, 7.0, 0.0, 5.0, 9.0, 7.0, -5.0, 9.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][1], mat4(8.0, 7.0, 1.0, -9.0, 8.0, 7.0, -3.0, 1.0, -5.0, 0.0, 7.0, -9.0, -9.0, 1.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][2], mat4(-7.0, 4.0, -4.0, 2.0, -2.0, 6.0, 3.0, -1.0, -9.0, 1.0, 2.0, -8.0, -1.0, 3.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][0], mat4(9.0, -8.0, -7.0, -1.0, -3.0, 9.0, -4.0, -9.0, 3.0, -3.0, -7.0, -7.0, 3.0, 1.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][1], mat4(3.0, 0.0, 5.0, -1.0, 2.0, 2.0, -2.0, 3.0, -9.0, 7.0, 0.0, -8.0, -4.0, -2.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][2], mat4(-2.0, 8.0, -8.0, -3.0, 0.0, -5.0, 4.0, -3.0, -1.0, -8.0, 4.0, -2.0, -7.0, 0.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][0], mat4(-7.0, -9.0, 9.0, 6.0, -7.0, 9.0, 7.0, 4.0, 8.0, -5.0, 3.0, 2.0, 2.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][1], mat4(5.0, -2.0, 7.0, 6.0, -3.0, 2.0, -4.0, -5.0, -6.0, 7.0, 1.0, 1.0, 4.0, -5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][2], mat4(-6.0, 8.0, 6.0, 9.0, -2.0, -8.0, 3.0, 5.0, 0.0, -8.0, 8.0, -3.0, 2.0, -8.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][0], mat4(1.0, 5.0, -7.0, -8.0, 2.0, 4.0, -9.0, -7.0, -4.0, 6.0, -7.0, 0.0, 5.0, 3.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][1], mat4(-1.0, 9.0, 7.0, 3.0, 6.0, 4.0, -2.0, 2.0, -4.0, 0.0, -3.0, 6.0, -6.0, -3.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][2], mat4(5.0, 7.0, -3.0, 4.0, 0.0, 8.0, -1.0, -4.0, 0.0, -5.0, 3.0, -8.0, -7.0, 5.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][0], mat4(6.0, 4.0, -5.0, 5.0, -6.0, 1.0, -9.0, 6.0, -7.0, 3.0, 1.0, 0.0, 2.0, -7.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][1], mat4(4.0, -6.0, 8.0, -5.0, 7.0, 6.0, 1.0, -6.0, -2.0, 0.0, 1.0, 0.0, -6.0, -8.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][2], mat4(-4.0, -7.0, -7.0, 1.0, 4.0, -7.0, 4.0, -1.0, -3.0, -7.0, 6.0, 9.0, 3.0, 7.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][0], mat4(-6.0, 7.0, -2.0, 2.0, 4.0, 7.0, -2.0, 9.0, -2.0, -5.0, 2.0, -7.0, 7.0, -5.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][1], mat4(-6.0, -6.0, -9.0, 2.0, 9.0, 6.0, -9.0, -1.0, -3.0, -9.0, -4.0, 4.0, -8.0, -7.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][2], mat4(-3.0, -1.0, 6.0, -9.0, 6.0, -3.0, -5.0, 3.0, 8.0, -8.0, -6.0, 6.0, -1.0, 4.0, -2.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4(-3.0, -8.0, 5.0, -8.0, 8.0, -2.0, 8.0, 1.0, -9.0, 5.0, -7.0, -7.0, -5.0, -8.0, 9.0, -1.0));
	block.var[0][0][1] = (mat4(1.0, 6.0, -3.0, 2.0, -1.0, -8.0, -2.0, 0.0, -9.0, 3.0, 5.0, -5.0, -1.0, 1.0, -5.0, -2.0));
	block.var[0][0][2] = (mat4(1.0, -7.0, 1.0, 9.0, -4.0, 9.0, 7.0, 0.0, -4.0, -7.0, -9.0, -6.0, 0.0, -9.0, -8.0, -5.0));
	block.var[0][1][0] = (mat4(5.0, 1.0, 7.0, 8.0, 0.0, -3.0, 8.0, 5.0, -2.0, -2.0, -1.0, -2.0, 4.0, -6.0, 1.0, 5.0));
	block.var[0][1][1] = (mat4(-1.0, 8.0, 6.0, 8.0, -7.0, -4.0, -5.0, -8.0, 5.0, 0.0, 7.0, -8.0, 8.0, -2.0, 6.0, 5.0));
	block.var[0][1][2] = (mat4(2.0, 8.0, -1.0, 1.0, -9.0, -1.0, 9.0, -4.0, 9.0, 4.0, -2.0, 9.0, 6.0, 7.0, 1.0, 3.0));
	block.var[1][0][0] = (mat4(2.0, 3.0, 0.0, 3.0, 8.0, 6.0, -2.0, -6.0, 3.0, -5.0, 3.0, 5.0, -3.0, -2.0, 8.0, -1.0));
	block.var[1][0][1] = (mat4(-4.0, -1.0, -9.0, -2.0, 9.0, 7.0, -3.0, -1.0, 9.0, 1.0, -5.0, -1.0, -4.0, -2.0, 9.0, -1.0));
	block.var[1][0][2] = (mat4(-5.0, -1.0, 2.0, 4.0, -8.0, -6.0, 8.0, -7.0, -5.0, 2.0, -1.0, -8.0, -1.0, -6.0, 5.0, -4.0));
	block.var[1][1][0] = (mat4(-7.0, -5.0, 2.0, -5.0, 8.0, -5.0, -6.0, 3.0, -5.0, -8.0, 1.0, -1.0, 1.0, 2.0, -5.0, 3.0));
	block.var[1][1][1] = (mat4(7.0, 2.0, 8.0, -4.0, -1.0, 2.0, 4.0, 1.0, 9.0, 7.0, -6.0, 7.0, 7.0, -5.0, 0.0, 3.0));
	block.var[1][1][2] = (mat4(-4.0, -1.0, -2.0, -3.0, 6.0, 2.0, 7.0, 0.0, 3.0, 4.0, -4.0, 2.0, 8.0, -4.0, 7.0, -4.0));
	block.var[2][0][0] = (mat4(3.0, 6.0, 4.0, 6.0, 0.0, 3.0, 8.0, 0.0, 2.0, -1.0, 4.0, 8.0, 1.0, 3.0, 6.0, 2.0));
	block.var[2][0][1] = (mat4(1.0, 2.0, 4.0, -4.0, -6.0, 6.0, -8.0, 2.0, 4.0, 0.0, -6.0, 4.0, 1.0, 7.0, 3.0, -3.0));
	block.var[2][0][2] = (mat4(2.0, 4.0, -5.0, 3.0, 6.0, 0.0, 1.0, -8.0, 0.0, -1.0, 2.0, 3.0, 3.0, 6.0, 9.0, 4.0));
	block.var[2][1][0] = (mat4(-2.0, -1.0, 8.0, 8.0, -9.0, 9.0, 6.0, -1.0, 3.0, -9.0, -4.0, -6.0, -2.0, 6.0, -7.0, 3.0));
	block.var[2][1][1] = (mat4(9.0, -7.0, 6.0, 8.0, -2.0, -6.0, -5.0, 5.0, -8.0, -5.0, 8.0, 4.0, 2.0, 2.0, 4.0, -9.0));
	block.var[2][1][2] = (mat4(-5.0, -6.0, 9.0, -7.0, 8.0, -4.0, 0.0, -3.0, -1.0, 7.0, 1.0, -5.0, 8.0, 4.0, -7.0, 8.0));
	block.var[3][0][0] = (mat4(8.0, 9.0, 2.0, -7.0, 5.0, -9.0, 8.0, -4.0, 5.0, -1.0, -2.0, 4.0, 8.0, -4.0, 4.0, -1.0));
	block.var[3][0][1] = (mat4(-8.0, 6.0, -7.0, -1.0, 0.0, -7.0, 5.0, -1.0, -7.0, -2.0, -5.0, 6.0, -7.0, -9.0, -7.0, -8.0));
	block.var[3][0][2] = (mat4(-2.0, 0.0, 5.0, 7.0, 4.0, 4.0, 9.0, -9.0, 6.0, 5.0, -7.0, -1.0, -1.0, 5.0, -9.0, -1.0));
	block.var[3][1][0] = (mat4(7.0, 1.0, 8.0, -1.0, 2.0, -4.0, 3.0, 6.0, -2.0, 9.0, 0.0, 2.0, -1.0, -5.0, 2.0, -6.0));
	block.var[3][1][1] = (mat4(4.0, 2.0, -1.0, 5.0, 7.0, 1.0, -8.0, 4.0, 2.0, -3.0, -2.0, 1.0, -5.0, -8.0, 3.0, -8.0));
	block.var[3][1][2] = (mat4(-8.0, 9.0, 1.0, 7.0, -4.0, 3.0, -8.0, 6.0, 8.0, -5.0, -3.0, 2.0, 4.0, -5.0, -3.0, 8.0));
}
#version 450
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
	allOk = compare_float((block.padding), -7.0) && allOk;
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(1.0, 9.0, 3.0, -9.0, -1.0, 6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(6.0, 5.0, -8.0, 8.0, 9.0, 1.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][2], mat4x2(1.0, -1.0, -5.0, 5.0, -9.0, -7.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(-1.0, -8.0, -1.0, -7.0, -8.0, 6.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(-8.0, -7.0, 7.0, 3.0, 7.0, 1.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][2], mat4x2(7.0, -7.0, -4.0, -2.0, -5.0, -5.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(-2.0, -9.0, -2.0, -2.0, 8.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(6.0, -4.0, 7.0, 2.0, 3.0, 7.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][2], mat4x2(3.0, 5.0, -2.0, 7.0, 1.0, 8.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(-9.0, 6.0, -8.0, 0.0, 5.0, 5.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(0.0, 9.0, -8.0, 0.0, 5.0, 5.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][2], mat4x2(1.0, 2.0, -6.0, -9.0, -9.0, 7.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(-9.0, 1.0, -6.0, 3.0, -3.0, 0.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(-4.0, -1.0, 4.0, 0.0, -4.0, 3.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][2], mat4x2(4.0, 5.0, 4.0, -5.0, 8.0, -8.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(9.0, -5.0, -6.0, -1.0, 1.0, -8.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(-1.0, -7.0, -7.0, -9.0, -4.0, 9.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][2], mat4x2(-7.0, -8.0, 6.0, -7.0, -6.0, -1.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][0], mat4x2(5.0, -2.0, -3.0, 7.0, 4.0, -3.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][1], mat4x2(7.0, 2.0, 3.0, -7.0, -8.0, 5.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][2], mat4x2(-8.0, -8.0, 4.0, 6.0, 8.0, -2.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][0], mat4x2(-2.0, 9.0, -6.0, 5.0, -1.0, 3.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][1], mat4x2(-3.0, 0.0, -2.0, -5.0, 8.0, -7.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][2], mat4x2(-9.0, 3.0, 5.0, 2.0, -2.0, -7.0, 6.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (6.0);
	block.var[0][0][0][0] = (vec2(-2.0, 2.0));
	block.var[0][0][0][1] = (vec2(8.0, -5.0));
	block.var[0][0][0][2] = (vec2(3.0, -1.0));
	block.var[0][0][0][3] = (vec2(-7.0, 4.0));
	block.var[0][0][1][0] = (vec2(2.0, -4.0));
	block.var[0][0][1][1] = (vec2(8.0, 3.0));
	block.var[0][0][1][2] = (vec2(8.0, -1.0));
	block.var[0][0][1][3] = (vec2(6.0, -8.0));
	block.var[0][0][2][0] = (vec2(2.0, -5.0));
	block.var[0][0][2][1] = (vec2(5.0, -4.0));
	block.var[0][0][2][2] = (vec2(-9.0, 0.0));
	block.var[0][0][2][3] = (vec2(4.0, 8.0));
	block.var[0][1][0][0] = (vec2(7.0, 0.0));
	block.var[0][1][0][1] = (vec2(-4.0, -1.0));
	block.var[0][1][0][2] = (vec2(5.0, 9.0));
	block.var[0][1][0][3] = (vec2(-8.0, -3.0));
	block.var[0][1][1][0] = (vec2(8.0, -1.0));
	block.var[0][1][1][1] = (vec2(7.0, 5.0));
	block.var[0][1][1][2] = (vec2(-7.0, 8.0));
	block.var[0][1][1][3] = (vec2(0.0, -5.0));
	block.var[0][1][2][0] = (vec2(7.0, 8.0));
	block.var[0][1][2][1] = (vec2(9.0, 8.0));
	block.var[0][1][2][2] = (vec2(9.0, 1.0));
	block.var[0][1][2][3] = (vec2(9.0, -9.0));
	block.var[1][0][0][0] = (vec2(2.0, -3.0));
	block.var[1][0][0][1] = (vec2(2.0, -4.0));
	block.var[1][0][0][2] = (vec2(-4.0, 2.0));
	block.var[1][0][0][3] = (vec2(-8.0, -4.0));
	block.var[1][0][1][0] = (vec2(8.0, 5.0));
	block.var[1][0][1][1] = (vec2(7.0, -4.0));
	block.var[1][0][1][2] = (vec2(6.0, 8.0));
	block.var[1][0][1][3] = (vec2(4.0, -9.0));
	block.var[1][0][2][0] = (vec2(-7.0, 7.0));
	block.var[1][0][2][1] = (vec2(-5.0, 1.0));
	block.var[1][0][2][2] = (vec2(-9.0, 9.0));
	block.var[1][0][2][3] = (vec2(5.0, 7.0));
	block.var[1][1][0][0] = (vec2(8.0, -2.0));
	block.var[1][1][0][1] = (vec2(9.0, 6.0));
	block.var[1][1][0][2] = (vec2(6.0, 3.0));
	block.var[1][1][0][3] = (vec2(-5.0, 1.0));
	block.var[1][1][1][0] = (vec2(-4.0, -5.0));
	block.var[1][1][1][1] = (vec2(7.0, -8.0));
	block.var[1][1][1][2] = (vec2(7.0, -1.0));
	block.var[1][1][1][3] = (vec2(-1.0, -2.0));
	block.var[1][1][2][0] = (vec2(-7.0, 4.0));
	block.var[1][1][2][1] = (vec2(-8.0, 2.0));
	block.var[1][1][2][2] = (vec2(4.0, 3.0));
	block.var[1][1][2][3] = (vec2(1.0, 7.0));
	block.var[2][0][0][0] = (vec2(3.0, 3.0));
	block.var[2][0][0][1] = (vec2(3.0, -5.0));
	block.var[2][0][0][2] = (vec2(-9.0, 2.0));
	block.var[2][0][0][3] = (vec2(9.0, 3.0));
	block.var[2][0][1][0] = (vec2(8.0, 3.0));
	block.var[2][0][1][1] = (vec2(-4.0, 6.0));
	block.var[2][0][1][2] = (vec2(1.0, -3.0));
	block.var[2][0][1][3] = (vec2(1.0, -5.0));
	block.var[2][0][2][0] = (vec2(-2.0, 7.0));
	block.var[2][0][2][1] = (vec2(8.0, 4.0));
	block.var[2][0][2][2] = (vec2(7.0, -1.0));
	block.var[2][0][2][3] = (vec2(-8.0, -6.0));
	block.var[2][1][0][0] = (vec2(8.0, 2.0));
	block.var[2][1][0][1] = (vec2(-9.0, -8.0));
	block.var[2][1][0][2] = (vec2(-9.0, -1.0));
	block.var[2][1][0][3] = (vec2(-3.0, -2.0));
	block.var[2][1][1][0] = (vec2(-1.0, 1.0));
	block.var[2][1][1][1] = (vec2(-1.0, -5.0));
	block.var[2][1][1][2] = (vec2(-6.0, -8.0));
	block.var[2][1][1][3] = (vec2(7.0, 2.0));
	block.var[2][1][2][0] = (vec2(0.0, -7.0));
	block.var[2][1][2][1] = (vec2(-6.0, 6.0));
	block.var[2][1][2][2] = (vec2(1.0, 8.0));
	block.var[2][1][2][3] = (vec2(9.0, 9.0));
	block.var[3][0][0][0] = (vec2(-6.0, -4.0));
	block.var[3][0][0][1] = (vec2(-2.0, 3.0));
	block.var[3][0][0][2] = (vec2(8.0, 4.0));
	block.var[3][0][0][3] = (vec2(4.0, -7.0));
	block.var[3][0][1][0] = (vec2(-6.0, 8.0));
	block.var[3][0][1][1] = (vec2(-6.0, 8.0));
	block.var[3][0][1][2] = (vec2(-3.0, -7.0));
	block.var[3][0][1][3] = (vec2(0.0, -9.0));
	block.var[3][0][2][0] = (vec2(2.0, -9.0));
	block.var[3][0][2][1] = (vec2(7.0, -2.0));
	block.var[3][0][2][2] = (vec2(2.0, -6.0));
	block.var[3][0][2][3] = (vec2(-1.0, 1.0));
	block.var[3][1][0][0] = (vec2(-8.0, -6.0));
	block.var[3][1][0][1] = (vec2(-7.0, -5.0));
	block.var[3][1][0][2] = (vec2(0.0, -3.0));
	block.var[3][1][0][3] = (vec2(1.0, -1.0));
	block.var[3][1][1][0] = (vec2(-6.0, 1.0));
	block.var[3][1][1][1] = (vec2(1.0, -7.0));
	block.var[3][1][1][2] = (vec2(-8.0, -5.0));
	block.var[3][1][1][3] = (vec2(5.0, 4.0));
	block.var[3][1][2][0] = (vec2(-9.0, -6.0));
	block.var[3][1][2][1] = (vec2(-7.0, -8.0));
	block.var[3][1][2][2] = (vec2(8.0, -3.0));
	block.var[3][1][2][3] = (vec2(6.0, 0.0));
}
#version 450
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
	uint16_t padding;
	u16vec4 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(block.padding), 6u) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[0][0][0]), uvec4(0u, 8u, 3u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[0][0][1]), uvec4(7u, 5u, 4u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[0][0][2]), uvec4(7u, 1u, 8u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[0][1][0]), uvec4(2u, 0u, 3u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[0][1][1]), uvec4(8u, 8u, 3u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[0][1][2]), uvec4(2u, 3u, 0u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][0][0]), uvec4(0u, 5u, 8u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][0][1]), uvec4(4u, 6u, 1u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][0][2]), uvec4(3u, 6u, 0u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][1][0]), uvec4(9u, 1u, 1u, 6u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][1][1]), uvec4(2u, 0u, 4u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][1][2]), uvec4(5u, 6u, 3u, 2u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][0][0]), uvec4(2u, 2u, 4u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][0][1]), uvec4(9u, 3u, 0u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][0][2]), uvec4(0u, 4u, 9u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][1][0]), uvec4(6u, 2u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][1][1]), uvec4(7u, 0u, 1u, 6u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][1][2]), uvec4(4u, 5u, 5u, 6u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[3][0][0]), uvec4(7u, 1u, 0u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[3][0][1]), uvec4(7u, 4u, 5u, 7u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[3][0][2]), uvec4(0u, 8u, 3u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[3][1][0]), uvec4(4u, 0u, 5u, 2u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[3][1][1]), uvec4(9u, 7u, 6u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[3][1][2]), uvec4(1u, 6u, 9u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = uint16_t(0u);
	block.var[0][0][0] = u16vec4(uvec4(6u, 9u, 4u, 5u));
	block.var[0][0][1] = u16vec4(uvec4(0u, 1u, 0u, 7u));
	block.var[0][0][2] = u16vec4(uvec4(6u, 5u, 9u, 8u));
	block.var[0][1][0] = u16vec4(uvec4(9u, 4u, 2u, 9u));
	block.var[0][1][1] = u16vec4(uvec4(7u, 6u, 2u, 8u));
	block.var[0][1][2] = u16vec4(uvec4(4u, 6u, 2u, 2u));
	block.var[1][0][0] = u16vec4(uvec4(3u, 6u, 1u, 7u));
	block.var[1][0][1] = u16vec4(uvec4(9u, 3u, 8u, 1u));
	block.var[1][0][2] = u16vec4(uvec4(4u, 3u, 9u, 9u));
	block.var[1][1][0] = u16vec4(uvec4(1u, 0u, 1u, 9u));
	block.var[1][1][1] = u16vec4(uvec4(9u, 4u, 6u, 4u));
	block.var[1][1][2] = u16vec4(uvec4(4u, 2u, 8u, 7u));
	block.var[2][0][0] = u16vec4(uvec4(3u, 0u, 2u, 3u));
	block.var[2][0][1] = u16vec4(uvec4(5u, 0u, 2u, 5u));
	block.var[2][0][2] = u16vec4(uvec4(1u, 5u, 5u, 4u));
	block.var[2][1][0] = u16vec4(uvec4(8u, 2u, 8u, 0u));
	block.var[2][1][1] = u16vec4(uvec4(3u, 6u, 3u, 4u));
	block.var[2][1][2] = u16vec4(uvec4(0u, 8u, 2u, 3u));
	block.var[3][0][0] = u16vec4(uvec4(0u, 8u, 4u, 0u));
	block.var[3][0][1] = u16vec4(uvec4(3u, 7u, 1u, 1u));
	block.var[3][0][2] = u16vec4(uvec4(8u, 4u, 7u, 6u));
	block.var[3][1][0] = u16vec4(uvec4(0u, 4u, 2u, 4u));
	block.var[3][1][1] = u16vec4(uvec4(7u, 1u, 9u, 5u));
	block.var[3][1][2] = u16vec4(uvec4(6u, 9u, 9u, 9u));
}
#version 450
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
layout(std430, buffer_reference) buffer Block
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
	allOk = compare_ivec3((block.s.a), ivec3(-3, -3, -8)) && allOk;
	allOk = compare_mat3(block.s.b[0], mat3(-9.0, 1.0, 3.0, -3.0, -7.0, 8.0, -8.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3(block.s.b[1], mat3(-2.0, 4.0, 8.0, -7.0, -3.0, -2.0, -8.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat3(block.s.b[2], mat3(-8.0, 9.0, 0.0, 9.0, 7.0, -8.0, 1.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3(block.s.b[3], mat3(-9.0, 1.0, -4.0, -5.0, -5.0, -2.0, -1.0, 8.0, -9.0)) && allOk;
	allOk = compare_vec4((block.s.c), vec4(2.0, -2.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat3(block.t.a, mat3(6.0, 9.0, 6.0, -5.0, -9.0, -5.0, -6.0, -4.0, -9.0)) && allOk;
	allOk = compare_ivec3((block.t.b.a), ivec3(-8, -4, -8)) && allOk;
	allOk = compare_mat3(block.t.b.b[0], mat3(5.0, -9.0, -1.0, 7.0, -9.0, -8.0, -4.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3(block.t.b.b[1], mat3(8.0, 5.0, -9.0, -8.0, 2.0, 3.0, 4.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat3(block.t.b.b[2], mat3(-6.0, 3.0, -8.0, 4.0, 5.0, 6.0, 2.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat3(block.t.b.b[3], mat3(-4.0, -9.0, -8.0, -2.0, -8.0, -9.0, 4.0, -5.0, 7.0)) && allOk;
	allOk = compare_vec4((block.t.b.c), vec4(2.0, -5.0, 3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.t.a = (mat3(6.0, -5.0, 3.0, -7.0, 0.0, -5.0, 0.0, 7.0, 8.0));
	block.t.b.a = (ivec3(4, 8, 8));
	block.t.b.b[0] = (mat3(-5.0, 2.0, -2.0, 7.0, 2.0, -2.0, 0.0, -8.0, 5.0));
	block.t.b.b[1] = (mat3(3.0, -5.0, 1.0, -7.0, -3.0, 2.0, -6.0, -6.0, -5.0));
	block.t.b.b[2] = (mat3(-6.0, 9.0, -8.0, -1.0, 8.0, 1.0, -1.0, -9.0, -6.0));
	block.t.b.b[3] = (mat3(-8.0, -7.0, -3.0, 1.0, -4.0, 3.0, 5.0, 7.0, -1.0));
	block.t.b.c = (vec4(7.0, 1.0, -2.0, 8.0));
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
	allOk = compare_mat3(block[0].t[0].a, mat3(9.0, 1.0, 4.0, 9.0, 2.0, -8.0, 4.0, 8.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[0].a), ivec3(-9, 9, 3)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[0]), ivec2(-2, -9)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[1]), ivec2(4, -4)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[2]), ivec2(7, -4)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[3]), ivec2(7, 6)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[0].c), vec4(4.0, -2.0, 1.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[1].a), ivec3(0, 8, -3)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[0]), ivec2(4, 0)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[1]), ivec2(-9, -2)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[2]), ivec2(-4, -2)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[3]), ivec2(-9, -5)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[1].c), vec4(-1.0, 8.0, 5.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[2].a), ivec3(-6, 7, 3)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[0]), ivec2(4, 1)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[1]), ivec2(3, 4)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[2]), ivec2(-9, -8)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[3]), ivec2(1, -2)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[2].c), vec4(6.0, -9.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3(block[0].t[1].a, mat3(8.0, 7.0, -6.0, 1.0, 1.0, -3.0, -2.0, 0.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[0].a), ivec3(-1, 4, -3)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[0]), ivec2(-2, -3)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[1]), ivec2(6, -6)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[2]), ivec2(0, 6)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[3]), ivec2(-3, -1)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[0].c), vec4(-9.0, 3.0, -9.0, 3.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[1].a), ivec3(-5, -3, -5)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[0]), ivec2(-6, -7)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[1]), ivec2(1, 7)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[2]), ivec2(4, 6)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[3]), ivec2(4, -7)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[1].c), vec4(-4.0, 8.0, 0.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[2].a), ivec3(-3, 5, 9)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[0]), ivec2(-6, -3)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[1]), ivec2(-2, -2)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[2]), ivec2(-1, -7)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[3]), ivec2(-5, -7)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[2].c), vec4(3.0, 7.0, -7.0, -7.0)) && allOk;
	allOk = compare_uint((block[0].u), 4u) && allOk;
	allOk = compare_mat3(block[1].t[0].a, mat3(2.0, -8.0, -5.0, 2.0, 5.0, -8.0, -3.0, -9.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[0].a), ivec3(1, 1, -4)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[0]), ivec2(0, 0)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[1]), ivec2(6, -1)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[2]), ivec2(9, 6)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[3]), ivec2(0, -4)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[0].c), vec4(-2.0, 4.0, 5.0, 7.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[1].a), ivec3(-9, -9, 2)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[0]), ivec2(8, -6)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[1]), ivec2(-8, -5)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[2]), ivec2(-5, -6)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[3]), ivec2(-4, 8)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[1].c), vec4(-1.0, -5.0, 5.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[2].a), ivec3(5, -8, -3)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[0]), ivec2(1, -3)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[1]), ivec2(-2, -2)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[2]), ivec2(-7, -3)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[3]), ivec2(-3, 0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[2].c), vec4(-2.0, -1.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3(block[1].t[1].a, mat3(9.0, -6.0, -8.0, 9.0, 8.0, -8.0, -7.0, -6.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[0].a), ivec3(-3, 5, -8)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[0]), ivec2(9, -2)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[1]), ivec2(8, -1)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[2]), ivec2(-9, 7)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[3]), ivec2(8, -3)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[0].c), vec4(-6.0, -6.0, 7.0, 2.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[1].a), ivec3(-7, -5, 6)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[0]), ivec2(2, 5)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[1]), ivec2(-7, 3)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[2]), ivec2(1, 0)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[3]), ivec2(3, 6)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[1].c), vec4(-1.0, 4.0, 3.0, 2.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[2].a), ivec3(-6, 7, -9)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[0]), ivec2(4, -2)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[1]), ivec2(9, -8)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[2]), ivec2(-1, -7)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[3]), ivec2(6, 5)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[2].c), vec4(5.0, 6.0, 6.0, 0.0)) && allOk;
	allOk = compare_uint((block[1].u), 2u) && allOk;
	allOk = compare_mat3(block[2].t[0].a, mat3(-2.0, 4.0, 1.0, -1.0, -1.0, -4.0, 7.0, -8.0, -2.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[0].a), ivec3(-6, 4, -1)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[0]), ivec2(-9, 0)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[1]), ivec2(1, -4)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[2]), ivec2(4, 5)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[3]), ivec2(-8, -2)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[0].c), vec4(8.0, -4.0, 0.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[1].a), ivec3(-1, -6, -9)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[0]), ivec2(1, 3)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[1]), ivec2(-3, 8)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[2]), ivec2(-4, -4)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[3]), ivec2(7, -5)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[1].c), vec4(1.0, 7.0, 5.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[2].a), ivec3(4, 6, -6)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[0]), ivec2(1, 9)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[1]), ivec2(-7, 1)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[2]), ivec2(3, 1)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[3]), ivec2(-6, -2)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[2].c), vec4(6.0, -5.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3(block[2].t[1].a, mat3(-3.0, 4.0, -4.0, 6.0, -3.0, -3.0, 0.0, 4.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[0].a), ivec3(-9, 5, -2)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[0]), ivec2(-9, 1)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[1]), ivec2(8, 3)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[2]), ivec2(1, -3)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[3]), ivec2(6, -1)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[0].c), vec4(-9.0, 2.0, 3.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[1].a), ivec3(-2, -8, -3)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[0]), ivec2(9, 6)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[1]), ivec2(-8, -7)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[2]), ivec2(-2, 8)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[3]), ivec2(6, 4)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[1].c), vec4(-8.0, -3.0, -4.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[2].a), ivec3(-5, 8, 7)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[0]), ivec2(-6, -9)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[1]), ivec2(-7, 8)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[2]), ivec2(4, 4)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[3]), ivec2(9, -8)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[2].c), vec4(9.0, -8.0, -9.0, 0.0)) && allOk;
	allOk = compare_uint((block[2].u), 4u) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (ivec3(5, -9, -8));
	block[0].s.b[0] = (ivec2(1, 8));
	block[0].s.b[1] = (ivec2(-1, 4));
	block[0].s.b[2] = (ivec2(-7, 5));
	block[0].s.b[3] = (ivec2(5, 1));
	block[0].s.c = (vec4(-2.0, 7.0, 4.0, 3.0));
	block[0].u = (4u);
	block[1].s.a = (ivec3(4, -2, -3));
	block[1].s.b[0] = (ivec2(-9, 5));
	block[1].s.b[1] = (ivec2(-2, -5));
	block[1].s.b[2] = (ivec2(6, -9));
	block[1].s.b[3] = (ivec2(-3, -6));
	block[1].s.c = (vec4(-7.0, 3.0, -4.0, 8.0));
	block[1].u = (2u);
	block[2].s.a = (ivec3(-5, 8, 9));
	block[2].s.b[0] = (ivec2(8, -7));
	block[2].s.b[1] = (ivec2(-1, -1));
	block[2].s.b[2] = (ivec2(-8, 7));
	block[2].s.b[3] = (ivec2(-6, -9));
	block[2].s.c = (vec4(-9.0, 2.0, -5.0, -4.0));
	block[2].u = (0u);
}
#version 450
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

layout(std140, column_major, buffer_reference) buffer Block
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
	allOk = compare_mat2x3(block[0].var, mat2x3(-3.0, 6.0, -6.0, -6.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block[1].var, mat2x3(8.0, 3.0, 1.0, 4.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block[2].var, mat2x3(-7.0, -5.0, -8.0, -7.0, 1.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat2x3(-1.0, -2.0, -5.0, 0.0, 7.0, -2.0));
	block[1].var = (mat2x3(0.0, 9.0, 9.0, 8.0, -6.0, 3.0));
	block[2].var = (mat2x3(-9.0, 0.0, 1.0, 1.0, 7.0, -8.0));
}
#version 450
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
	i8vec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(block[0].var), ivec4(4294967293, 4294967289, 4294967295, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(block[1].var), ivec4(5, 4294967288, 4294967292, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(block[2].var), ivec4(3, 3, 4294967290, 4294967293)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = i8vec4(ivec4(4294967294, 4294967292, 4294967290, 4294967289));
	block[1].var = i8vec4(ivec4(4294967291, 4294967291, 4, 4294967290));
	block[2].var = i8vec4(ivec4(4294967295, 4294967287, 4294967293, 8));
}
#version 450
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
	bvec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((block[0].var), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((block[1].var), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((block[2].var), bvec3(false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (bvec3(true, true, false));
	block[1].var = (bvec3(false, true, true));
	block[2].var = (bvec3(false, false, false));
}
#version 450
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
	allOk = compare_mat3x2(block[0].var, mat3x2(-5.0, -8.0, -4.0, 7.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block[1].var, mat3x2(-7.0, 4.0, 3.0, -1.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block[2].var, mat3x2(-6.0, -3.0, -8.0, 5.0, -4.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat3x2(-3.0, 7.0, -3.0, -4.0, 2.0, -7.0));
	block[1].var = (mat3x2(-2.0, 9.0, -8.0, -2.0, 3.0, 4.0));
	block[2].var = (mat3x2(4.0, 1.0, -7.0, 9.0, 9.0, -1.0));
}
#version 450
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
	highp mat4 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), 9.0) && allOk;
	allOk = compare_float(block[0].var[0][0], -3.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 8.0) && allOk;
	allOk = compare_float(block[0].var[0][2], -1.0) && allOk;
	allOk = compare_float(block[0].var[0][3], 2.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 2.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -5.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -8.0) && allOk;
	allOk = compare_float(block[0].var[1][3], -6.0) && allOk;
	allOk = compare_float(block[0].var[2][0], -6.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -3.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 4.0) && allOk;
	allOk = compare_float(block[0].var[2][3], -9.0) && allOk;
	allOk = compare_float(block[0].var[3][0], -2.0) && allOk;
	allOk = compare_float(block[0].var[3][1], -9.0) && allOk;
	allOk = compare_float(block[0].var[3][2], 2.0) && allOk;
	allOk = compare_float(block[0].var[3][3], 0.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(-3.0, 8.0, -1.0, 2.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(2.0, -5.0, -8.0, -6.0)) && allOk;
	allOk = compare_vec4(block[0].var[2], vec4(-6.0, -3.0, 4.0, -9.0)) && allOk;
	allOk = compare_vec4(block[0].var[3], vec4(-2.0, -9.0, 2.0, 0.0)) && allOk;
	allOk = compare_float((block[1].padding), 7.0) && allOk;
	allOk = compare_float(block[1].var[0][0], -6.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -4.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -7.0) && allOk;
	allOk = compare_float(block[1].var[0][3], 7.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -3.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 8.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 6.0) && allOk;
	allOk = compare_float(block[1].var[1][3], 1.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 0.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 8.0) && allOk;
	allOk = compare_float(block[1].var[2][2], -6.0) && allOk;
	allOk = compare_float(block[1].var[2][3], 4.0) && allOk;
	allOk = compare_float(block[1].var[3][0], -9.0) && allOk;
	allOk = compare_float(block[1].var[3][1], 0.0) && allOk;
	allOk = compare_float(block[1].var[3][2], 5.0) && allOk;
	allOk = compare_float(block[1].var[3][3], 2.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(-6.0, -4.0, -7.0, 7.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(-3.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec4(block[1].var[2], vec4(0.0, 8.0, -6.0, 4.0)) && allOk;
	allOk = compare_vec4(block[1].var[3], vec4(-9.0, 0.0, 5.0, 2.0)) && allOk;
	allOk = compare_float((block[2].padding), -3.0) && allOk;
	allOk = compare_float(block[2].var[0][0], -2.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -5.0) && allOk;
	allOk = compare_float(block[2].var[0][2], -7.0) && allOk;
	allOk = compare_float(block[2].var[0][3], -1.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 4.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 2.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -6.0) && allOk;
	allOk = compare_float(block[2].var[1][3], -4.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 0.0) && allOk;
	allOk = compare_float(block[2].var[2][1], -9.0) && allOk;
	allOk = compare_float(block[2].var[2][2], -1.0) && allOk;
	allOk = compare_float(block[2].var[2][3], 0.0) && allOk;
	allOk = compare_float(block[2].var[3][0], 4.0) && allOk;
	allOk = compare_float(block[2].var[3][1], -3.0) && allOk;
	allOk = compare_float(block[2].var[3][2], 0.0) && allOk;
	allOk = compare_float(block[2].var[3][3], -3.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(-2.0, -5.0, -7.0, -1.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(4.0, 2.0, -6.0, -4.0)) && allOk;
	allOk = compare_vec4(block[2].var[2], vec4(0.0, -9.0, -1.0, 0.0)) && allOk;
	allOk = compare_vec4(block[2].var[3], vec4(4.0, -3.0, 0.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (7.0);
	block[0].var = (mat4(7.0, 7.0, -1.0, -6.0, -2.0, -6.0, 5.0, 9.0, 8.0, -6.0, 9.0, -8.0, 8.0, 6.0, 5.0, -7.0));
	block[1].padding = (2.0);
	block[1].var = (mat4(-3.0, 6.0, -8.0, 3.0, 0.0, -9.0, 1.0, 4.0, -6.0, -1.0, 8.0, 8.0, -9.0, 8.0, -8.0, 9.0));
	block[2].padding = (4.0);
	block[2].var = (mat4(2.0, 2.0, 3.0, -6.0, -2.0, 0.0, -2.0, -3.0, 2.0, -3.0, 0.0, -1.0, -8.0, 3.0, 2.0, 6.0));
}
#version 450
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
	highp mat4x2 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), 4.0) && allOk;
	allOk = compare_mat4x2(block[0].var, mat4x2(-5.0, -2.0, 7.0, 3.0, 2.0, -3.0, 1.0, -7.0)) && allOk;
	allOk = compare_float((block[1].padding), -1.0) && allOk;
	allOk = compare_mat4x2(block[1].var, mat4x2(-9.0, 4.0, -9.0, -4.0, 3.0, -1.0, -7.0, -7.0)) && allOk;
	allOk = compare_float((block[2].padding), 4.0) && allOk;
	allOk = compare_mat4x2(block[2].var, mat4x2(6.0, 6.0, -6.0, -1.0, -5.0, -1.0, 1.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (2.0);
	block[0].var[0] = (vec2(-4.0, -5.0));
	block[0].var[1] = (vec2(3.0, 7.0));
	block[0].var[2] = (vec2(1.0, 8.0));
	block[0].var[3] = (vec2(-5.0, 7.0));
	block[1].padding = (-3.0);
	block[1].var[0] = (vec2(1.0, -6.0));
	block[1].var[1] = (vec2(9.0, -3.0));
	block[1].var[2] = (vec2(1.0, -5.0));
	block[1].var[3] = (vec2(-8.0, 4.0));
	block[2].padding = (5.0);
	block[2].var[0] = (vec2(-9.0, 1.0));
	block[2].var[1] = (vec2(-5.0, -4.0));
	block[2].var[2] = (vec2(-2.0, 6.0));
	block[2].var[3] = (vec2(-1.0, -7.0));
}
#version 450
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
	bvec2 a;
	bvec4 b;
	lowp vec4 c;
	highp vec2 d;
};
layout(std140, buffer_reference) buffer BlockC
{
	mediump vec4 e;
	lowp uvec3 f;
	mediump uvec2 g;
	lowp int h;
	lowp float i;
};
layout(std430, buffer_reference) buffer BlockD
{
	highp vec4 j;
	highp ivec2 k;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.b), bvec4(false, true, true, false)) && allOk;
	allOk = compare_vec4((blockB.c), vec4(-9.0, 9.0, -2.0, -9.0)) && allOk;
	allOk = compare_vec2((blockB.d), vec2(2.0, 0.0)) && allOk;
	allOk = compare_uvec2((blockC.g), uvec2(4u, 4u)) && allOk;
	allOk = compare_float((blockC.i), -2.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (bvec4(true, true, false, true));
	blockB.c = (vec4(3.0, -3.0, -1.0, 6.0));
	blockB.d = (vec2(9.0, 5.0));
	blockC.e = (vec4(-6.0, -1.0, -2.0, 2.0));
	blockC.f = (uvec3(8u, 6u, 4u));
	blockC.g = (uvec2(2u, 0u));
	blockC.h = (-5);
	blockC.i = (-2.0);
	blockD.j = (vec4(-2.0, 8.0, -3.0, -3.0));
	blockD.k = (ivec2(-8, 1));
}
#version 450
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
	mediump uvec3 a;
};
layout(std430, row_major, buffer_reference) readonly buffer BlockC
{
	lowp ivec3 b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a), uvec3(8u, 0u, 0u)) && allOk;
	allOk = compare_ivec3((blockC.b), ivec3(6, 7, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec3(0u, 7u, 5u));
}
#version 450
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
	highp vec2 a;
	lowp mat4x3 b;
	highp mat4x2 c[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	bool d;
	highp mat3 e;
	mediump ivec3 f;
	mediump ivec3 g;
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
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(-5.0, 5.0)) && allOk;
	allOk = compare_mat4x3(blockB.b, mat4x3(-6.0, 7.0, -7.0, -9.0, 7.0, -5.0, 9.0, 0.0, -2.0, -5.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(blockB.c[0], mat4x2(5.0, 7.0, 2.0, -1.0, -4.0, 3.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat4x2(blockB.c[1], mat4x2(-1.0, 9.0, -5.0, -5.0, 5.0, 1.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat4x2(blockB.c[2], mat4x2(-8.0, -1.0, 4.0, 4.0, -8.0, -9.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(blockB.c[3], mat4x2(1.0, 0.0, -4.0, 6.0, 7.0, 8.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4x2(blockB.c[4], mat4x2(9.0, 3.0, -3.0, 3.0, 2.0, -7.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(blockB.c[5], mat4x2(-3.0, -1.0, -3.0, 0.0, 8.0, -6.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3(blockC.e, mat3(-5.0, 0.0, 4.0, 2.0, 5.0, -4.0, -9.0, -4.0, -1.0)) && allOk;
	allOk = compare_ivec3((blockC.g), ivec3(-1, 9, -4)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec2(3.0, -4.0));
	blockB.b = (mat4x3(2.0, -2.0, 0.0, 2.0, -4.0, 9.0, 4.0, -9.0, 8.0, 9.0, -2.0, -5.0));
	blockB.c[0] = (mat4x2(4.0, 0.0, -6.0, 4.0, -8.0, 7.0, -5.0, 3.0));
	blockB.c[1] = (mat4x2(-2.0, -5.0, 9.0, 5.0, 0.0, 5.0, 6.0, -5.0));
	blockB.c[2] = (mat4x2(-2.0, -5.0, -4.0, 4.0, -4.0, -3.0, -9.0, -8.0));
	blockB.c[3] = (mat4x2(-8.0, -3.0, 9.0, 8.0, 4.0, -6.0, 4.0, -2.0));
	blockB.c[4] = (mat4x2(-6.0, -9.0, -9.0, -4.0, 2.0, 6.0, 6.0, 0.0));
	blockB.c[5] = (mat4x2(-2.0, -9.0, -5.0, 7.0, -5.0, -1.0, -4.0, -8.0));
	blockC.e = (mat3(5.0, 0.0, 0.0, -2.0, -4.0, -5.0, -5.0, 9.0, 8.0));
	blockC.f = (ivec3(-4, 6, -6));
	blockC.g = (ivec3(2, 7, 8));
}
#version 450
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
	mediump ivec2 a;
	lowp mat3x2 b[7];
	highp float c;
	bvec2 d;
	highp vec2 e[][7];
};
layout(std430, row_major, buffer_reference) readonly buffer BlockC
{
	highp ivec4 f;
	bool g;
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	mediump ivec4 h;
	mediump vec4 i[];
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
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a), ivec2(1, -5)) && allOk;
	allOk = compare_mat3x2(blockB.b[0], mat3x2(-9.0, -5.0, 1.0, -7.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[1], mat3x2(8.0, 7.0, 9.0, -8.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[2], mat3x2(6.0, -5.0, 7.0, 3.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[3], mat3x2(4.0, -2.0, 9.0, 2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[4], mat3x2(-6.0, 8.0, 5.0, 5.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[5], mat3x2(1.0, -9.0, 7.0, -2.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[6], mat3x2(-3.0, 3.0, 1.0, 1.0, -9.0, -3.0)) && allOk;
	allOk = compare_float((blockB.c), -9.0) && allOk;
	allOk = compare_bool((blockC.g), true) && allOk;
	allOk = compare_ivec4((blockD.h), ivec4(3, 8, 6, -3)) && allOk;
	allOk = compare_vec4((blockD.i[0]), vec4(4.0, -7.0, 1.0, -5.0)) && allOk;
	allOk = compare_vec4((blockD.i[1]), vec4(-9.0, 7.0, -6.0, 6.0)) && allOk;
	allOk = compare_vec4((blockD.i[2]), vec4(-3.0, -4.0, 5.0, -9.0)) && allOk;
	allOk = compare_vec4((blockD.i[3]), vec4(6.0, 2.0, -2.0, -6.0)) && allOk;
	allOk = compare_vec4((blockD.i[4]), vec4(4.0, -8.0, 7.0, 1.0)) && allOk;
	allOk = compare_vec4((blockD.i[5]), vec4(-6.0, 8.0, 4.0, -4.0)) && allOk;
	allOk = compare_vec4((blockD.i[6]), vec4(6.0, -7.0, 7.0, -2.0)) && allOk;
	allOk = compare_vec4((blockD.i[7]), vec4(-7.0, 4.0, 1.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec2(2, 7));
	blockB.d = (bvec2(true, false));
	blockB.e[0][0] = (vec2(8.0, 0.0));
	blockB.e[0][1] = (vec2(-8.0, 1.0));
	blockB.e[0][2] = (vec2(-8.0, 2.0));
	blockB.e[0][3] = (vec2(-7.0, -2.0));
	blockB.e[0][4] = (vec2(2.0, -5.0));
	blockB.e[0][5] = (vec2(-5.0, -8.0));
	blockB.e[0][6] = (vec2(-6.0, -3.0));
	blockB.e[1][0] = (vec2(-6.0, -4.0));
	blockB.e[1][1] = (vec2(-7.0, 7.0));
	blockB.e[1][2] = (vec2(6.0, 9.0));
	blockB.e[1][3] = (vec2(-9.0, 3.0));
	blockB.e[1][4] = (vec2(4.0, 2.0));
	blockB.e[1][5] = (vec2(-6.0, 4.0));
	blockB.e[1][6] = (vec2(-6.0, -4.0));
	blockD.h = (ivec4(-6, 1, 9, -7));
	blockD.i[0] = (vec4(2.0, 5.0, 9.0, 3.0));
	blockD.i[1] = (vec4(-4.0, 6.0, 4.0, 5.0));
	blockD.i[2] = (vec4(5.0, 6.0, 8.0, 1.0));
	blockD.i[3] = (vec4(-8.0, 3.0, -9.0, 5.0));
	blockD.i[4] = (vec4(-8.0, 0.0, 5.0, 0.0));
	blockD.i[5] = (vec4(-7.0, 7.0, -2.0, 9.0));
	blockD.i[6] = (vec4(8.0, 0.0, 5.0, -3.0));
	blockD.i[7] = (vec4(8.0, 7.0, 4.0, 7.0));
}
#version 450
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
	highp uvec2 a;
	bvec2 b;
	mediump mat3x2 c;
	lowp mat4x3 d;
	lowp uvec3 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a), uvec2(6u, 7u)) && allOk;
	allOk = compare_mat3x2(blockB.c, mat3x2(-1.0, 3.0, -2.0, 2.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(blockB.d, mat4x3(-6.0, -1.0, 6.0, -4.0, 4.0, 5.0, -6.0, 8.0, -8.0, -3.0, -1.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec2(6u, 4u));
	blockB.b = (bvec2(false, true));
	blockB.c = (mat3x2(-3.0, -9.0, -7.0, 8.0, 9.0, 0.0));
	blockB.d = (mat4x3(-8.0, -2.0, 3.0, -9.0, -5.0, -5.0, 5.0, 5.0, 0.0, 4.0, -6.0, -9.0));
	blockB.e[0] = (uvec3(8u, 9u, 1u));
	blockB.e[1] = (uvec3(6u, 3u, 6u));
	blockB.e[2] = (uvec3(5u, 5u, 6u));
	blockB.e[3] = (uvec3(5u, 2u, 3u));
}
#version 450
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
	mediump float mB;
	mediump uvec3 mC;
};
layout(std140, buffer_reference) buffer BlockB
{
	lowp vec2 a;
	sA b;
	bvec3 c[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	highp uvec2 d;
	bool e;
};
layout(std430, column_major, buffer_reference) readonly buffer BlockD
{
	lowp uvec4 f;
	mediump vec4 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB[0].a), vec2(8.0, 0.0)) && allOk;
	allOk = compare_bvec3((blockB[0].c[0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((blockB[0].c[1]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockB[0].c[2]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((blockB[0].c[3]), bvec3(true, true, false)) && allOk;
	allOk = compare_vec2((blockB[1].a), vec2(-3.0, -5.0)) && allOk;
	allOk = compare_bvec3((blockB[1].c[0]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockB[1].c[1]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockB[1].c[2]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((blockB[1].c[3]), bvec3(true, true, true)) && allOk;
	allOk = compare_uvec2((blockC.d), uvec2(4u, 8u)) && allOk;
	allOk = compare_bool((blockC.e), false) && allOk;
	allOk = compare_vec4((blockD.g[0]), vec4(-5.0, 7.0, 2.0, 7.0)) && allOk;
	allOk = compare_vec4((blockD.g[1]), vec4(5.0, -6.0, -5.0, 6.0)) && allOk;
	allOk = compare_vec4((blockD.g[2]), vec4(-3.0, 9.0, -8.0, -5.0)) && allOk;
	allOk = compare_vec4((blockD.g[3]), vec4(-6.0, -1.0, 3.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (vec2(5.0, -4.0));
	blockB[1].a = (vec2(1.0, -3.0));
	blockC.e = (true);
}
#version 450
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
	layout(offset = 16) lowp int b;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) lowp uvec4 c;
	layout(offset = 16) bool d;
	layout(offset = 20) highp float e;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) bool f;
	layout(offset = 4) mediump float g;
	layout(offset = 16) lowp ivec3 h;
	layout(offset = 32) highp uvec3 i;
	layout(offset = 48) mediump vec4 j;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, false, false, true)) && allOk;
	allOk = compare_int((blockB.b), 5) && allOk;
	allOk = compare_uvec4((blockC.c), uvec4(8u, 8u, 2u, 9u)) && allOk;
	allOk = compare_bool((blockC.d), false) && allOk;
	allOk = compare_float((blockC.e), -8.0) && allOk;
	allOk = compare_ivec3((blockD.h), ivec3(-8, 1, 5)) && allOk;
	allOk = compare_vec4((blockD.j), vec4(7.0, -5.0, 8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec4(true, false, true, true));
	blockB.b = (2);
	blockC.e = (5.0);
	blockD.f = (false);
	blockD.g = (8.0);
	blockD.h = (ivec3(-1, 7, -9));
	blockD.i = (uvec3(1u, 7u, 8u));
	blockD.j = (vec4(-2.0, -4.0, 9.0, -4.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, buffer_reference) buffer BlockB
{
	bvec3 a;
	mediump mat4x3 b;
	lowp vec4 c;
	mediump int d;
	highp vec3 e[];
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	highp uvec2 f[];
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	bool g[1][1];
	bvec2 h;
	highp mat4 i;
	mediump float j;
	bvec2 k[];
};
layout(scalar, buffer_reference) buffer BlockE
{
	highp uvec3 l;
	mediump vec4 m;
	lowp mat3 n;
	mediump ivec4 o;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB[0].a), bvec3(true, false, false)) && allOk;
	allOk = compare_vec4((blockB[0].c), vec4(2.0, 5.0, -1.0, 6.0)) && allOk;
	allOk = compare_int((blockB[0].d), 6) && allOk;
	allOk = compare_bvec2((blockD.h), bvec2(false, true)) && allOk;
	allOk = compare_mat4(blockD.i, mat4(-6.0, 7.0, -7.0, -5.0, -2.0, 5.0, 9.0, 7.0, -9.0, -9.0, 4.0, -7.0, 4.0, 4.0, -7.0, 9.0)) && allOk;
	allOk = compare_float((blockD.j), 6.0) && allOk;
	allOk = compare_vec4((blockE.m), vec4(1.0, 7.0, 6.0, -7.0)) && allOk;
	allOk = compare_ivec4((blockE.o), ivec4(-3, -7, -7, -5)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (mat4x3(5.0, 9.0, -2.0, -5.0, 6.0, 4.0, -8.0, 7.0, -1.0, -6.0, 8.0, -2.0));
	blockB[0].c = (vec4(3.0, -3.0, 9.0, 0.0));
	blockB[0].d = (-9);
	blockB[0].e[0] = (vec3(4.0, 7.0, -9.0));
	blockB[0].e[1] = (vec3(-5.0, 5.0, -9.0));
	blockC.f[0] = (uvec2(5u, 8u));
	blockC.f[1] = (uvec2(3u, 8u));
	blockC.f[2] = (uvec2(9u, 4u));
	blockC.f[3] = (uvec2(5u, 9u));
	blockC.f[4] = (uvec2(6u, 5u));
	blockC.f[5] = (uvec2(1u, 2u));
	blockC.f[6] = (uvec2(1u, 7u));
	blockC.f[7] = (uvec2(5u, 5u));
	blockD.h = (bvec2(true, false));
	blockD.i = (mat4(-5.0, -2.0, -9.0, -3.0, 9.0, -9.0, 4.0, -4.0, 0.0, -8.0, 4.0, -8.0, 3.0, 6.0, -7.0, 8.0));
	blockD.j = (-1.0);
	blockD.k[0] = (bvec2(false, true));
	blockD.k[1] = (bvec2(true, true));
	blockD.k[2] = (bvec2(false, true));
	blockD.k[3] = (bvec2(false, true));
	blockD.k[4] = (bvec2(false, true));
	blockD.k[5] = (bvec2(true, false));
	blockE.l = (uvec3(4u, 7u, 3u));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(column_major, buffer_reference) buffer BlockB
{
	layout(offset = 0) mediump uvec2 a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB[nonuniformEXT(0)].a), uvec2(7u, 9u)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(1)].a), uvec2(0u, 1u)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(2)].a), uvec2(6u, 9u)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(3)].a), uvec2(7u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (uvec2(7u, 5u));
	blockB[nonuniformEXT(1)].a = (uvec2(2u, 4u));
	blockB[nonuniformEXT(2)].a = (uvec2(6u, 5u));
	blockB[nonuniformEXT(3)].a = (uvec2(3u, 5u));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, row_major, buffer_reference) buffer BlockB
{
	lowp vec2 a[1];
	lowp mat3x2 b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB[nonuniformEXT(0)].a[0]), vec2(8.0, -2.0)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(1)].a[0]), vec2(-5.0, 9.0)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(2)].a[0]), vec2(-9.0, -7.0)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(3)].a[0]), vec2(-4.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a[0] = (vec2(-8.0, -5.0));
	blockB[nonuniformEXT(1)].a[0] = (vec2(0.0, -8.0));
	blockB[nonuniformEXT(2)].a[0] = (vec2(-8.0, -7.0));
	blockB[nonuniformEXT(3)].a[0] = (vec2(3.0, -9.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, column_major, buffer_reference) readonly buffer BlockB
{
	highp mat2x3 a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

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

layout(std430, row_major, buffer_reference) buffer BlockB
{
	highp mat3x2 a;
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	lowp mat3x4 b;
	f16vec3 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockC.b, mat3x4(-6.0, -4.0, 4.0, -8.0, 1.0, -3.0, 9.0, -9.0, 9.0, 4.0, -9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x2(6.0, 3.0, -1.0, -7.0, 0.0, 6.0));
	blockC.c = f16vec3(vec3(-5.0, -2.0, -2.0));
}
#version 450
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
	bvec2 a;
	u16vec3 b;
	mediump int c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a), bvec2(true, true)) && allOk;
	allOk = compare_int((blockB.c[0]), -8) && allOk;
	allOk = compare_int((blockB.c[1]), 2) && allOk;
	allOk = compare_int((blockB.c[2]), -6) && allOk;
	allOk = compare_int((blockB.c[3]), 5) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = u16vec3(uvec3(0u, 7u, 4u));
}
#version 450
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
	highp mat4x2 mA;
	mediump ivec3 mB;
};
layout(std140, buffer_reference) buffer BlockB
{
	u16vec3 a;
	u16vec2 b;
	lowp uint c[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	u16vec4 d[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	sA e;
};
layout(std430, buffer_reference) buffer BlockE
{
	highp vec2 f;
	f16vec3 g;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(blockC.d[0]), uvec4(5u, 5u, 6u, 6u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC.d[1]), uvec4(7u, 2u, 9u, 1u)) && allOk;
	allOk = compare_mat4x2(blockD.e.mA, mat4x2(0.0, 4.0, -2.0, -7.0, -5.0, -2.0, 2.0, 9.0)) && allOk;
	allOk = compare_ivec3((blockD.e.mB), ivec3(8, 9, 0)) && allOk;
	allOk = compare_vec2((blockE.f), vec2(-5.0, 2.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE.g), vec3(3.0, 8.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec3(uvec3(3u, 1u, 6u));
	blockB.b = u16vec2(uvec2(8u, 6u));
	blockB.c[0] = (3u);
	blockB.c[1] = (2u);
	blockB.c[2] = (1u);
	blockB.c[3] = (3u);
	blockB.c[4] = (2u);
	blockB.c[5] = (6u);
	blockB.c[6] = (7u);
	blockC.d[0] = u16vec4(uvec4(9u, 6u, 0u, 2u));
	blockC.d[1] = u16vec4(uvec4(3u, 6u, 3u, 4u));
	blockD.e.mA = (mat4x2(2.0, 3.0, -3.0, 5.0, -9.0, -5.0, -5.0, -2.0));
	blockD.e.mB = (ivec3(-2, 8, -3));
	blockE.f = (vec2(-3.0, -8.0));
	blockE.g = f16vec3(vec3(1.0, -3.0, -1.0));
}
#version 450
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
	highp vec2 mA;
	lowp mat3x2 mB;
	highp mat3 mC;
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	highp ivec4 a;
	i16vec3 b;
	mediump uvec2 c[7];
	lowp ivec2 d[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	sA e;
	lowp float f;
	float16_t g;
	highp uint h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.a), ivec4(6, 6, -6, -3)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB.b), ivec3(-1, -9, 5)) && allOk;
	allOk = compare_uvec2((blockB.c[0]), uvec2(3u, 2u)) && allOk;
	allOk = compare_uvec2((blockB.c[1]), uvec2(6u, 9u)) && allOk;
	allOk = compare_uvec2((blockB.c[2]), uvec2(1u, 4u)) && allOk;
	allOk = compare_uvec2((blockB.c[3]), uvec2(1u, 4u)) && allOk;
	allOk = compare_uvec2((blockB.c[4]), uvec2(9u, 4u)) && allOk;
	allOk = compare_uvec2((blockB.c[5]), uvec2(9u, 6u)) && allOk;
	allOk = compare_uvec2((blockB.c[6]), uvec2(8u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec4(-5, 9, 5, 5));
	blockB.c[0] = (uvec2(2u, 4u));
	blockB.c[1] = (uvec2(5u, 4u));
	blockB.c[2] = (uvec2(9u, 7u));
	blockB.c[3] = (uvec2(2u, 2u));
	blockB.c[4] = (uvec2(9u, 6u));
	blockB.c[5] = (uvec2(7u, 8u));
	blockB.c[6] = (uvec2(0u, 1u));
	blockB.d[0] = (ivec2(3, 5));
	blockB.d[1] = (ivec2(3, 9));
	blockB.d[2] = (ivec2(8, -4));
	blockC.f = (7.0);
	blockC.h = (0u);
}
#version 450
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
	bvec4 mA[5];
	mediump uvec2 mB[7];
};
struct sB
{
	mediump ivec4 mA;
	int16_t mB;
};
layout(std140, buffer_reference) readonly buffer BlockB
{
	bool a[];
};
layout(std430, buffer_reference) buffer BlockC
{
	mediump mat4 b;
	mediump vec3 c;
	i16vec3 d;
	lowp vec2 e;
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	sA f;
	lowp ivec2 g;
	lowp uvec2 h;
	u16vec2 i;
	sB j[];
};
layout(std430, column_major, buffer_reference) buffer BlockE
{
	highp int k[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[1];
    BlockD blockD[2];
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockC[0].b, mat4(-6.0, -8.0, -5.0, 9.0, 7.0, -8.0, 1.0, 5.0, -5.0, -8.0, -7.0, 7.0, -5.0, 8.0, -5.0, 7.0)) && allOk;
	allOk = compare_vec3((blockC[0].c), vec3(-8.0, -4.0, -3.0)) && allOk;
	allOk = compare_bvec4((blockD[0].f.mA[0]), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec4((blockD[0].f.mA[1]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((blockD[0].f.mA[2]), bvec4(false, false, true, true)) && allOk;
	allOk = compare_bvec4((blockD[0].f.mA[3]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((blockD[0].f.mA[4]), bvec4(true, true, true, false)) && allOk;
	allOk = compare_uvec2((blockD[0].f.mB[0]), uvec2(8u, 0u)) && allOk;
	allOk = compare_uvec2((blockD[0].f.mB[1]), uvec2(0u, 8u)) && allOk;
	allOk = compare_uvec2((blockD[0].f.mB[2]), uvec2(5u, 7u)) && allOk;
	allOk = compare_uvec2((blockD[0].f.mB[3]), uvec2(3u, 1u)) && allOk;
	allOk = compare_uvec2((blockD[0].f.mB[4]), uvec2(2u, 3u)) && allOk;
	allOk = compare_uvec2((blockD[0].f.mB[5]), uvec2(7u, 3u)) && allOk;
	allOk = compare_uvec2((blockD[0].f.mB[6]), uvec2(8u, 7u)) && allOk;
	allOk = compare_uvec2((blockD[0].h), uvec2(9u, 1u)) && allOk;
	allOk = compare_ivec4((blockD[0].j[0].mA), ivec4(-9, -3, 0, 4)) && allOk;
	allOk = compare_int16_t(int(blockD[0].j[0].mB), -2) && allOk;
	allOk = compare_ivec4((blockD[0].j[1].mA), ivec4(9, 5, 7, -3)) && allOk;
	allOk = compare_int16_t(int(blockD[0].j[1].mB), 2) && allOk;
	allOk = compare_ivec4((blockD[0].j[2].mA), ivec4(-7, 0, -5, -1)) && allOk;
	allOk = compare_int16_t(int(blockD[0].j[2].mB), 2) && allOk;
	allOk = compare_ivec4((blockD[0].j[3].mA), ivec4(7, 2, 7, 7)) && allOk;
	allOk = compare_int16_t(int(blockD[0].j[3].mB), -8) && allOk;
	allOk = compare_ivec4((blockD[0].j[4].mA), ivec4(-3, -7, -7, 1)) && allOk;
	allOk = compare_int16_t(int(blockD[0].j[4].mB), -3) && allOk;
	allOk = compare_bvec4((blockD[1].f.mA[0]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((blockD[1].f.mA[1]), bvec4(false, false, false, true)) && allOk;
	allOk = compare_bvec4((blockD[1].f.mA[2]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((blockD[1].f.mA[3]), bvec4(false, false, true, true)) && allOk;
	allOk = compare_bvec4((blockD[1].f.mA[4]), bvec4(true, false, false, false)) && allOk;
	allOk = compare_uvec2((blockD[1].f.mB[0]), uvec2(4u, 6u)) && allOk;
	allOk = compare_uvec2((blockD[1].f.mB[1]), uvec2(6u, 3u)) && allOk;
	allOk = compare_uvec2((blockD[1].f.mB[2]), uvec2(3u, 5u)) && allOk;
	allOk = compare_uvec2((blockD[1].f.mB[3]), uvec2(3u, 8u)) && allOk;
	allOk = compare_uvec2((blockD[1].f.mB[4]), uvec2(0u, 5u)) && allOk;
	allOk = compare_uvec2((blockD[1].f.mB[5]), uvec2(2u, 2u)) && allOk;
	allOk = compare_uvec2((blockD[1].f.mB[6]), uvec2(3u, 0u)) && allOk;
	allOk = compare_uvec2((blockD[1].h), uvec2(8u, 7u)) && allOk;
	allOk = compare_ivec4((blockD[1].j[0].mA), ivec4(0, -5, 8, 9)) && allOk;
	allOk = compare_int16_t(int(blockD[1].j[0].mB), -9) && allOk;
	allOk = compare_ivec4((blockD[1].j[1].mA), ivec4(7, 4, 8, -5)) && allOk;
	allOk = compare_int16_t(int(blockD[1].j[1].mB), 8) && allOk;
	allOk = compare_ivec4((blockD[1].j[2].mA), ivec4(8, -4, 8, 5)) && allOk;
	allOk = compare_int16_t(int(blockD[1].j[2].mB), -8) && allOk;
	allOk = compare_ivec4((blockD[1].j[3].mA), ivec4(1, -8, -6, 8)) && allOk;
	allOk = compare_int16_t(int(blockD[1].j[3].mB), 2) && allOk;
	allOk = compare_ivec4((blockD[1].j[4].mA), ivec4(4, -6, -4, -1)) && allOk;
	allOk = compare_int16_t(int(blockD[1].j[4].mB), 9) && allOk;
	allOk = compare_int((blockE.k[0]), -3) && allOk;
	allOk = compare_int((blockE.k[1]), -4) && allOk;
	allOk = compare_int((blockE.k[2]), -7) && allOk;
	allOk = compare_int((blockE.k[3]), 2) && allOk;
	allOk = compare_int((blockE.k[4]), 5) && allOk;
	allOk = compare_int((blockE.k[5]), 8) && allOk;
	allOk = compare_int((blockE.k[6]), -4) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC[0].b = (mat4(8.0, 5.0, -5.0, 8.0, -1.0, 7.0, -9.0, -3.0, -1.0, 6.0, -2.0, -4.0, 9.0, -4.0, 2.0, -4.0));
	blockC[0].e = (vec2(-7.0, -1.0));
	blockD[0].f.mA[0] = (bvec4(false, false, true, true));
	blockD[0].f.mA[1] = (bvec4(false, true, true, true));
	blockD[0].f.mA[2] = (bvec4(false, true, false, true));
	blockD[0].f.mA[3] = (bvec4(false, false, true, false));
	blockD[0].f.mA[4] = (bvec4(true, false, true, false));
	blockD[0].f.mB[0] = (uvec2(4u, 4u));
	blockD[0].f.mB[1] = (uvec2(4u, 0u));
	blockD[0].f.mB[2] = (uvec2(8u, 4u));
	blockD[0].f.mB[3] = (uvec2(7u, 7u));
	blockD[0].f.mB[4] = (uvec2(1u, 7u));
	blockD[0].f.mB[5] = (uvec2(9u, 9u));
	blockD[0].f.mB[6] = (uvec2(7u, 7u));
	blockD[0].h = (uvec2(0u, 0u));
	blockD[0].j[0].mA = (ivec4(-6, -6, -1, -6));
	blockD[0].j[0].mB = int16_t(-1);
	blockD[0].j[1].mA = (ivec4(-2, 3, -4, 7));
	blockD[0].j[1].mB = int16_t(8);
	blockD[0].j[2].mA = (ivec4(-6, -9, -3, 1));
	blockD[0].j[2].mB = int16_t(1);
	blockD[0].j[3].mA = (ivec4(8, 7, -9, 6));
	blockD[0].j[3].mB = int16_t(-2);
	blockD[0].j[4].mA = (ivec4(-4, 4, -5, 5));
	blockD[0].j[4].mB = int16_t(0);
	blockD[1].f.mA[0] = (bvec4(true, false, false, false));
	blockD[1].f.mA[1] = (bvec4(true, true, true, true));
	blockD[1].f.mA[2] = (bvec4(true, true, false, true));
	blockD[1].f.mA[3] = (bvec4(false, false, false, true));
	blockD[1].f.mA[4] = (bvec4(false, true, false, true));
	blockD[1].f.mB[0] = (uvec2(6u, 0u));
	blockD[1].f.mB[1] = (uvec2(9u, 7u));
	blockD[1].f.mB[2] = (uvec2(8u, 9u));
	blockD[1].f.mB[3] = (uvec2(1u, 2u));
	blockD[1].f.mB[4] = (uvec2(7u, 7u));
	blockD[1].f.mB[5] = (uvec2(5u, 8u));
	blockD[1].f.mB[6] = (uvec2(0u, 6u));
	blockD[1].h = (uvec2(3u, 7u));
	blockD[1].j[0].mA = (ivec4(-3, 9, 5, -8));
	blockD[1].j[0].mB = int16_t(8);
	blockD[1].j[1].mA = (ivec4(0, -5, -1, 7));
	blockD[1].j[1].mB = int16_t(9);
	blockD[1].j[2].mA = (ivec4(5, 8, 8, 9));
	blockD[1].j[2].mB = int16_t(-7);
	blockD[1].j[3].mA = (ivec4(1, -8, -4, -9));
	blockD[1].j[3].mB = int16_t(-5);
	blockD[1].j[4].mA = (ivec4(3, -5, 4, -1));
	blockD[1].j[4].mB = int16_t(1);
	blockE.k[0] = (-4);
	blockE.k[1] = (-8);
	blockE.k[2] = (-6);
	blockE.k[3] = (5);
	blockE.k[4] = (8);
	blockE.k[5] = (0);
	blockE.k[6] = (2);
}
#version 450
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
	f16vec4 mA;
	lowp mat4x3 mB;
	mediump vec4 mC[4];
};
struct sB
{
	sA mA;
	highp mat2 mB;
	lowp vec2 mC;
};
layout(std140, buffer_reference) buffer BlockB
{
	mediump mat3x2 a;
	sB b;
	mediump vec2 c;
	lowp uvec3 d;
	highp mat2 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB[0].a, mat3x2(7.0, -7.0, 0.0, -3.0, 7.0, 2.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB[0].b.mA.mA), vec4(3.0, 9.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat4x3(blockB[0].b.mA.mB, mat4x3(0.0, -9.0, 8.0, 7.0, -8.0, -8.0, -4.0, 8.0, -1.0, 6.0, -1.0, -3.0)) && allOk;
	allOk = compare_vec4((blockB[0].b.mA.mC[0]), vec4(9.0, 4.0, 6.0, 0.0)) && allOk;
	allOk = compare_vec4((blockB[0].b.mA.mC[1]), vec4(6.0, -3.0, 7.0, -3.0)) && allOk;
	allOk = compare_vec4((blockB[0].b.mA.mC[2]), vec4(-2.0, 4.0, 8.0, 6.0)) && allOk;
	allOk = compare_vec4((blockB[0].b.mA.mC[3]), vec4(9.0, -6.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat2(blockB[0].b.mB, mat2(5.0, 1.0, -2.0, -7.0)) && allOk;
	allOk = compare_vec2((blockB[0].b.mC), vec2(8.0, -3.0)) && allOk;
	allOk = compare_vec2((blockB[0].c), vec2(5.0, -1.0)) && allOk;
	allOk = compare_mat2(blockB[0].e, mat2(0.0, 2.0, 1.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b.mA.mA = f16vec4(vec4(4.0, -2.0, 4.0, 5.0));
	blockB[0].b.mA.mB = (mat4x3(-5.0, 7.0, 4.0, 5.0, 9.0, -3.0, 1.0, 7.0, -2.0, -2.0, -2.0, 1.0));
	blockB[0].b.mA.mC[0] = (vec4(4.0, 9.0, 0.0, 5.0));
	blockB[0].b.mA.mC[1] = (vec4(1.0, -9.0, 4.0, -3.0));
	blockB[0].b.mA.mC[2] = (vec4(-8.0, -9.0, 7.0, -5.0));
	blockB[0].b.mA.mC[3] = (vec4(7.0, 1.0, 2.0, -4.0));
	blockB[0].b.mB = (mat2(-5.0, -1.0, 0.0, -4.0));
	blockB[0].b.mC = (vec2(3.0, -2.0));
	blockB[0].c = (vec2(-4.0, -6.0));
	blockB[0].d = (uvec3(6u, 5u, 6u));
	blockB[0].e = (mat2(2.0, -6.0, -5.0, 1.0));
}
#version 450
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
	bvec2 a;
	i16vec2 b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a), bvec2(true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, true));
}
#version 450
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
	layout(offset = 0) bvec4 a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, true, false, true)) && allOk;
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
	i16vec2 mA;
	i16vec4 mB;
	float16_t mC;
};
layout(scalar, buffer_reference) buffer BlockB
{
	mediump ivec4 a;
	f16vec4 b;
	sA c;
	lowp ivec4 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.a), ivec4(-9, 7, 2, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = f16vec4(vec4(-5.0, 6.0, -3.0, -4.0));
	blockB.c.mA = i16vec2(ivec2(-4, -2));
	blockB.c.mB = i16vec4(ivec4(-2, 1, -4, 8));
	blockB.c.mC = float16_t(9.0);
}
#version 450
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
	mediump ivec3 a;
	mediump vec3 b;
	highp ivec4 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.b), vec3(-2.0, -1.0, -2.0)) && allOk;
	allOk = compare_ivec4((blockB.c), ivec4(6, 3, 2, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (ivec4(-7, 9, -9, 8));
}
#version 450
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
	highp mat4x3 a[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	mediump vec3 b;
	highp ivec4 c;
	i8vec3 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.a[0], mat4x3(0.0, 7.0, 9.0, 2.0, 5.0, -4.0, -8.0, -6.0, -3.0, 6.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1], mat4x3(4.0, -9.0, -4.0, 9.0, 8.0, 7.0, -9.0, 0.0, 2.0, -8.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[2], mat4x3(7.0, -5.0, 0.0, -5.0, -3.0, -3.0, -4.0, -1.0, 1.0, 3.0, 1.0, 3.0)) && allOk;
	allOk = compare_vec3((blockC.b), vec3(-9.0, -4.0, 3.0)) && allOk;
	allOk = compare_ivec4((blockC.c), ivec4(9, 1, 3, -9)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.d[0]), ivec3(4294967291, 9, 4294967289)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat4x3(6.0, -7.0, -8.0, -1.0, 6.0, -4.0, 0.0, -7.0, -6.0, 3.0, 6.0, 3.0));
	blockB.a[1] = (mat4x3(-2.0, 7.0, -2.0, 5.0, -5.0, 7.0, -2.0, -5.0, -2.0, 6.0, -2.0, 1.0));
	blockB.a[2] = (mat4x3(3.0, 9.0, 8.0, -9.0, -9.0, 4.0, -2.0, 4.0, -4.0, -7.0, -1.0, 0.0));
	blockC.c = (ivec4(3, 3, -4, -6));
	blockC.d[0] = i8vec3(ivec3(4, 2, 4294967290));
}
#version 450
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
	lowp mat2x3 a;
	highp mat3x2 b;
	bvec2 c;
	bool d[];
};
layout(std140, buffer_reference) buffer BlockC
{
	uint8_t e;
	lowp uvec2 f[];
};
layout(std430, row_major, buffer_reference) readonly buffer BlockD
{
	u8vec4 g;
	mediump uvec4 h[5];
	mediump mat2x3 i[];
};
layout(std140, row_major, buffer_reference) buffer BlockE
{
	highp uvec4 j[];
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
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockC.f[0]), uvec2(4u, 8u)) && allOk;
	allOk = compare_uvec2((blockC.f[1]), uvec2(4u, 1u)) && allOk;
	allOk = compare_uvec2((blockC.f[2]), uvec2(4u, 6u)) && allOk;
	allOk = compare_uvec2((blockC.f[3]), uvec2(7u, 3u)) && allOk;
	allOk = compare_uvec4((blockE.j[0]), uvec4(8u, 9u, 9u, 3u)) && allOk;
	allOk = compare_uvec4((blockE.j[1]), uvec4(9u, 7u, 4u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2x3(9.0, -2.0, -3.0, -7.0, 6.0, 2.0));
	blockB.b = (mat3x2(-8.0, 7.0, 6.0, -4.0, 5.0, 7.0));
	blockC.e = uint8_t(3u);
	blockE.j[0] = (uvec4(3u, 8u, 3u, 5u));
	blockE.j[1] = (uvec4(8u, 6u, 3u, 7u));
}
#version 450
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
	bool a;
	lowp mat2 b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
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

layout(std140, column_major, buffer_reference) buffer BlockB
{
	bvec3 a;
	highp mat3 b;
	lowp mat3x4 c;
	uint8_t d;
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	mediump mat2x3 e;
	mediump uvec2 f;
	mediump uvec3 g;
	i8vec3 h[][3][1];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	i8vec3 i[];
};
layout(std430, column_major, buffer_reference) readonly buffer BlockE
{
	mediump mat4x2 j[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB.c, mat3x4(-2.0, -4.0, 7.0, -1.0, -1.0, -9.0, 4.0, 0.0, -1.0, -5.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(blockC.e, mat2x3(-4.0, 3.0, -9.0, -4.0, -2.0, 9.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.h[0][0][0]), ivec3(1, 7, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.h[0][1][0]), ivec3(2, 4294967292, 5)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.h[0][2][0]), ivec3(2, 4294967295, 2)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.h[1][0][0]), ivec3(6, 2, 7)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.h[1][1][0]), ivec3(7, 4, 4294967288)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.h[1][2][0]), ivec3(7, 4294967288, 4294967293)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.h[2][0][0]), ivec3(0, 4294967295, 7)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.h[2][1][0]), ivec3(4294967293, 2, 4294967287)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.h[2][2][0]), ivec3(7, 4294967295, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.h[3][0][0]), ivec3(5, 4294967294, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.h[3][1][0]), ivec3(4294967295, 2, 9)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.h[3][2][0]), ivec3(0, 9, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.h[4][0][0]), ivec3(4294967289, 2, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.h[4][1][0]), ivec3(7, 4294967293, 4294967293)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.h[4][2][0]), ivec3(6, 7, 0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.h[5][0][0]), ivec3(4294967295, 4294967290, 3)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.h[5][1][0]), ivec3(3, 9, 2)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.h[5][2][0]), ivec3(4294967292, 4294967291, 0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.h[6][0][0]), ivec3(9, 1, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.h[6][1][0]), ivec3(4, 4294967295, 4294967289)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.h[6][2][0]), ivec3(4294967291, 7, 4294967287)) && allOk;
	allOk = compare_i8vec3(ivec3(blockD.i[0]), ivec3(4294967290, 4294967287, 4294967293)) && allOk;
	allOk = compare_i8vec3(ivec3(blockD.i[1]), ivec3(5, 4294967293, 3)) && allOk;
	allOk = compare_i8vec3(ivec3(blockD.i[2]), ivec3(9, 3, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(blockD.i[3]), ivec3(4294967288, 4294967295, 4294967289)) && allOk;
	allOk = compare_i8vec3(ivec3(blockD.i[4]), ivec3(1, 8, 9)) && allOk;
	allOk = compare_i8vec3(ivec3(blockD.i[5]), ivec3(2, 0, 4294967287)) && allOk;
	allOk = compare_mat4x2(blockE[0].j[0], mat4x2(-2.0, 7.0, 5.0, -8.0, -9.0, -8.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat4x2(blockE[0].j[1], mat4x2(-5.0, 6.0, -9.0, -5.0, -5.0, 4.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat4x2(blockE[0].j[2], mat4x2(-4.0, -1.0, 6.0, 2.0, -9.0, -6.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat4x2(blockE[1].j[0], mat4x2(-4.0, 9.0, 9.0, -6.0, 8.0, -8.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat4x2(blockE[1].j[1], mat4x2(2.0, -6.0, -3.0, 7.0, -3.0, -6.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat4x2(blockE[1].j[2], mat4x2(8.0, 3.0, -7.0, -5.0, -3.0, 6.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(blockE[2].j[0], mat4x2(-1.0, -3.0, 2.0, 2.0, 3.0, -8.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat4x2(blockE[2].j[1], mat4x2(-3.0, 3.0, 9.0, 7.0, -6.0, -6.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(blockE[2].j[2], mat4x2(-6.0, -1.0, 8.0, 4.0, -5.0, 7.0, -5.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec3(true, false, true));
	blockB.b = (mat3(9.0, 5.0, -5.0, -6.0, -5.0, 9.0, 0.0, 6.0, 2.0));
	blockB.c = (mat3x4(7.0, 9.0, -4.0, -5.0, -1.0, -4.0, -4.0, 2.0, 4.0, -3.0, -5.0, -9.0));
	blockB.d = uint8_t(9u);
	blockC.f = (uvec2(5u, 4u));
	blockC.g = (uvec3(5u, 9u, 0u));
	blockC.h[0][0][0] = i8vec3(ivec3(1, 4294967288, 3));
	blockC.h[0][1][0] = i8vec3(ivec3(4294967292, 5, 2));
	blockC.h[0][2][0] = i8vec3(ivec3(6, 4294967289, 4));
	blockC.h[1][0][0] = i8vec3(ivec3(4294967288, 0, 2));
	blockC.h[1][1][0] = i8vec3(ivec3(4294967287, 2, 2));
	blockC.h[1][2][0] = i8vec3(ivec3(3, 4294967293, 9));
	blockC.h[2][0][0] = i8vec3(ivec3(4, 2, 4294967293));
	blockC.h[2][1][0] = i8vec3(ivec3(1, 4, 0));
	blockC.h[2][2][0] = i8vec3(ivec3(7, 4294967291, 4294967287));
	blockC.h[3][0][0] = i8vec3(ivec3(4294967295, 5, 4294967291));
	blockC.h[3][1][0] = i8vec3(ivec3(7, 2, 0));
	blockC.h[3][2][0] = i8vec3(ivec3(8, 5, 4294967288));
	blockC.h[4][0][0] = i8vec3(ivec3(8, 4294967292, 9));
	blockC.h[4][1][0] = i8vec3(ivec3(4294967292, 0, 6));
	blockC.h[4][2][0] = i8vec3(ivec3(2, 3, 4294967291));
	blockC.h[5][0][0] = i8vec3(ivec3(2, 4294967290, 8));
	blockC.h[5][1][0] = i8vec3(ivec3(4294967291, 4294967289, 4294967295));
	blockC.h[5][2][0] = i8vec3(ivec3(2, 4294967293, 4294967290));
	blockC.h[6][0][0] = i8vec3(ivec3(1, 4294967291, 4294967295));
	blockC.h[6][1][0] = i8vec3(ivec3(4294967293, 4294967287, 2));
	blockC.h[6][2][0] = i8vec3(ivec3(1, 5, 4294967292));
	blockD.i[0] = i8vec3(ivec3(4294967294, 4294967287, 9));
	blockD.i[1] = i8vec3(ivec3(9, 4294967295, 8));
	blockD.i[2] = i8vec3(ivec3(0, 8, 9));
	blockD.i[3] = i8vec3(ivec3(0, 5, 4294967292));
	blockD.i[4] = i8vec3(ivec3(4294967293, 7, 4294967293));
	blockD.i[5] = i8vec3(ivec3(9, 4294967290, 7));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, row_major, buffer_reference) readonly buffer BlockB
{
	mediump uint a[];
};
layout(std140, buffer_reference) buffer BlockC
{
	mediump mat2 b;
	int8_t c[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	lowp vec2 d;
	highp mat4x2 e;
	u8vec4 f;
	mediump mat4 g;
	uint8_t h[];
};
layout(std140, row_major, buffer_reference) readonly buffer BlockE
{
	lowp ivec3 i[8];
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
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a[0]), 0u) && allOk;
	allOk = compare_uint((blockB.a[1]), 2u) && allOk;
	allOk = compare_uint((blockB.a[2]), 0u) && allOk;
	allOk = compare_uint((blockB.a[3]), 4u) && allOk;
	allOk = compare_uint((blockB.a[4]), 4u) && allOk;
	allOk = compare_uint((blockB.a[5]), 0u) && allOk;
	allOk = compare_uint((blockB.a[6]), 9u) && allOk;
	allOk = compare_uint((blockB.a[7]), 3u) && allOk;
	allOk = compare_mat2(blockC.b, mat2(-6.0, -1.0, -1.0, -2.0)) && allOk;
	allOk = compare_vec2((blockD.d), vec2(6.0, 5.0)) && allOk;
	allOk = compare_mat4x2(blockD.e, mat4x2(7.0, -2.0, -4.0, -9.0, 8.0, 3.0, 0.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (mat2(-7.0, 8.0, 5.0, -6.0));
	blockD.e = (mat4x2(3.0, -1.0, 4.0, -4.0, -6.0, -7.0, -7.0, -4.0));
	blockD.f = u8vec4(uvec4(4u, 5u, 6u, 1u));
}
#version 450
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
	highp ivec4 a;
	i8vec4 b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.a), ivec4(-7, 3, -2, 9)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.b[0]), ivec4(4294967287, 4294967295, 4294967287, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.b[1]), ivec4(4294967288, 6, 4294967291, 4294967288)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.b[2]), ivec4(2, 7, 4294967289, 7)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.b[3]), ivec4(4294967292, 8, 4294967295, 2)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.b[4]), ivec4(0, 1, 6, 4294967291)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.b[5]), ivec4(2, 7, 4294967291, 4)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.b[6]), ivec4(4294967289, 0, 4294967287, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.b[7]), ivec4(4294967294, 0, 4294967290, 4294967293)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec4(-6, -2, 3, -5));
}
#version 450
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
	layout(offset = 0) highp vec4 a;
	layout(offset = 16) lowp ivec3 b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.b), ivec3(-1, -9, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec4(-5.0, 9.0, 5.0, 5.0));
}
#version 450
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
	layout(offset = 0) highp ivec4 a;
	layout(offset = 16) u8vec2 b;
	layout(offset = 20) bool c;
	layout(offset = 32) highp uvec3 d;
	layout(offset = 48) highp ivec3 e;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) lowp vec4 f;
	layout(offset = 16) bvec4 g;
	layout(offset = 32) bvec4 h;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) mediump int i;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.a), ivec4(3, 4, -3, 6)) && allOk;
	allOk = compare_bool((blockB.c), false) && allOk;
	allOk = compare_uvec3((blockB.d), uvec3(2u, 0u, 6u)) && allOk;
	allOk = compare_ivec3((blockB.e), ivec3(9, 9, 9)) && allOk;
	allOk = compare_vec4((blockC.f), vec4(-8.0, 9.0, -9.0, 9.0)) && allOk;
	allOk = compare_bvec4((blockC.h), bvec4(false, true, true, false)) && allOk;
	allOk = compare_int((blockD.i), -4) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec4(3, -9, 1, -1));
	blockB.b = u8vec2(uvec2(0u, 8u));
	blockC.f = (vec4(1.0, -2.0, 3.0, -4.0));
	blockC.g = (bvec4(false, true, true, false));
	blockC.h = (bvec4(true, false, true, true));
	blockD.i = (4);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, row_major, buffer_reference) buffer BlockB
{
	highp uint a[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a[0]), 0u) && allOk;
	allOk = compare_uint((blockB.a[1]), 6u) && allOk;
	allOk = compare_uint((blockB.a[2]), 0u) && allOk;
	allOk = compare_uint((blockB.a[3]), 4u) && allOk;
	allOk = compare_uint((blockB.a[4]), 7u) && allOk;
	allOk = compare_uint((blockB.a[5]), 1u) && allOk;
	allOk = compare_uint((blockB.a[6]), 7u) && allOk;
	allOk = compare_uint((blockB.a[7]), 1u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (0u);
	blockB.a[1] = (7u);
	blockB.a[2] = (8u);
	blockB.a[3] = (4u);
	blockB.a[4] = (0u);
	blockB.a[5] = (5u);
	blockB.a[6] = (1u);
	blockB.a[7] = (1u);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, buffer_reference) buffer BlockB
{
	highp ivec3 a;
	mediump mat4 b[];
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	uint8_t c;
	lowp mat3 d;
	i8vec2 e;
	i8vec4 f[];
};
layout(scalar, row_major, buffer_reference) buffer BlockD
{
	highp mat2x3 g;
	highp uvec3 h[];
};
layout(scalar, buffer_reference) buffer BlockE
{
	mediump vec3 i;
	bvec2 j;
	bool k;
	mediump vec2 l;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a), ivec3(4, -7, 3)) && allOk;
	allOk = compare_uint8_t(uint(blockC.c), 9u) && allOk;
	allOk = compare_mat3(blockC.d, mat3(-9.0, -8.0, -5.0, 5.0, 2.0, 1.0, -6.0, 7.0, -6.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.e), ivec2(4294967291, 9)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.f[0]), ivec4(4294967292, 4294967295, 4294967290, 3)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.f[1]), ivec4(4294967288, 0, 4294967291, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.f[2]), ivec4(4294967288, 2, 9, 4)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.f[3]), ivec4(7, 4294967288, 4294967294, 4)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.f[4]), ivec4(1, 4294967291, 4294967290, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.f[5]), ivec4(4294967294, 4294967291, 6, 4294967289)) && allOk;
	allOk = compare_mat2x3(blockD.g, mat2x3(3.0, -6.0, -4.0, -2.0, -7.0, -6.0)) && allOk;
	allOk = compare_bvec2((blockE[0].j), bvec2(true, true)) && allOk;
	allOk = compare_bool((blockE[0].k), true) && allOk;
	allOk = compare_vec2((blockE[0].l), vec2(9.0, 2.0)) && allOk;
	allOk = compare_bvec2((blockE[1].j), bvec2(false, false)) && allOk;
	allOk = compare_bool((blockE[1].k), true) && allOk;
	allOk = compare_vec2((blockE[1].l), vec2(-3.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec3(4, 8, -8));
	blockB.b[0] = (mat4(-3.0, 8.0, -6.0, 4.0, -4.0, -7.0, 9.0, 4.0, 6.0, -1.0, -5.0, 0.0, 8.0, -1.0, 4.0, -1.0));
	blockC.e = i8vec2(ivec2(1, 2));
	blockC.f[0] = i8vec4(ivec4(4294967294, 3, 2, 0));
	blockC.f[1] = i8vec4(ivec4(7, 4294967294, 4294967287, 9));
	blockC.f[2] = i8vec4(ivec4(4294967287, 4294967292, 4294967288, 0));
	blockC.f[3] = i8vec4(ivec4(8, 4294967287, 4294967291, 2));
	blockC.f[4] = i8vec4(ivec4(4294967293, 4, 4294967294, 4294967290));
	blockC.f[5] = i8vec4(ivec4(4294967293, 4294967294, 4294967290, 4294967293));
	blockD.g = (mat2x3(-9.0, -2.0, -6.0, 7.0, -6.0, 2.0));
	blockD.h[0] = (uvec3(5u, 6u, 8u));
	blockD.h[1] = (uvec3(0u, 7u, 7u));
	blockD.h[2] = (uvec3(5u, 5u, 9u));
	blockD.h[3] = (uvec3(0u, 0u, 9u));
	blockD.h[4] = (uvec3(5u, 5u, 9u));
	blockD.h[5] = (uvec3(6u, 9u, 6u));
	blockE[0].i = (vec3(0.0, -5.0, 7.0));
	blockE[0].j = (bvec2(false, false));
	blockE[0].l = (vec2(8.0, -3.0));
	blockE[1].i = (vec3(-3.0, 3.0, -8.0));
	blockE[1].j = (bvec2(false, true));
	blockE[1].l = (vec2(3.0, -3.0));
}
#version 450
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
};
layout(scalar, buffer_reference) readonly buffer BlockB
{
	i8vec3 a[];
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	highp vec4 b;
	mediump uvec4 c;
	uint8_t d;
	lowp mat4 e[][7];
};
layout(scalar, column_major, buffer_reference) readonly buffer BlockD
{
	sA f;
	mediump mat3 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[2];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(blockB.a[0]), ivec3(4294967293, 4294967288, 4294967290)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.a[1]), ivec3(6, 9, 3)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.a[2]), ivec3(9, 4294967289, 4294967292)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.a[3]), ivec3(4294967291, 9, 5)) && allOk;
	allOk = compare_vec4((blockC[0].b), vec4(6.0, -9.0, 5.0, 5.0)) && allOk;
	allOk = compare_uvec4((blockC[0].c), uvec4(0u, 6u, 7u, 3u)) && allOk;
	allOk = compare_mat4(blockC[0].e[0][0], mat4(2.0, 3.0, 9.0, 3.0, -1.0, -9.0, -2.0, 9.0, 0.0, 2.0, -4.0, 1.0, 6.0, -8.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat4(blockC[0].e[0][1], mat4(-1.0, 1.0, -6.0, -3.0, 9.0, -5.0, 5.0, -7.0, 4.0, 7.0, -9.0, 7.0, 6.0, 3.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4(blockC[0].e[0][2], mat4(4.0, -6.0, 3.0, -8.0, -2.0, -8.0, 3.0, 6.0, -1.0, 1.0, 2.0, 7.0, 8.0, -1.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4(blockC[0].e[0][3], mat4(6.0, -9.0, 4.0, -1.0, -5.0, -9.0, 2.0, 2.0, -8.0, -2.0, 3.0, 1.0, -3.0, -9.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat4(blockC[0].e[0][4], mat4(9.0, -3.0, 4.0, -5.0, -8.0, 7.0, 1.0, -7.0, 9.0, 8.0, 2.0, -7.0, 8.0, 6.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4(blockC[0].e[0][5], mat4(-9.0, 3.0, 4.0, 6.0, -7.0, -3.0, 5.0, 3.0, -4.0, 8.0, 8.0, -1.0, 3.0, -5.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat4(blockC[0].e[0][6], mat4(2.0, -6.0, 5.0, -5.0, -8.0, -6.0, 2.0, 4.0, 9.0, 1.0, -5.0, 2.0, 5.0, -4.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4(blockC[0].e[1][0], mat4(8.0, 9.0, 7.0, -4.0, -5.0, -3.0, -5.0, -7.0, 6.0, 7.0, -3.0, 2.0, -5.0, 5.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat4(blockC[0].e[1][1], mat4(-3.0, 2.0, -6.0, 1.0, 6.0, 7.0, 2.0, 6.0, 7.0, 1.0, -7.0, -8.0, -2.0, 3.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat4(blockC[0].e[1][2], mat4(-2.0, 2.0, 6.0, -6.0, 1.0, -1.0, -6.0, -6.0, -4.0, -6.0, 8.0, 0.0, 7.0, 4.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat4(blockC[0].e[1][3], mat4(-5.0, 4.0, 3.0, -9.0, 3.0, -2.0, -4.0, 8.0, 5.0, -9.0, -9.0, 2.0, 7.0, 2.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat4(blockC[0].e[1][4], mat4(3.0, 9.0, 1.0, -4.0, 0.0, 9.0, -7.0, 9.0, -3.0, 6.0, -6.0, 1.0, -7.0, -3.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4(blockC[0].e[1][5], mat4(-5.0, -3.0, -1.0, 4.0, -7.0, 1.0, -5.0, 4.0, 8.0, 5.0, -3.0, 4.0, -4.0, -2.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4(blockC[0].e[1][6], mat4(-7.0, -2.0, -4.0, 7.0, -2.0, 3.0, 5.0, 0.0, -6.0, 2.0, -7.0, -5.0, -5.0, -5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4(blockC[0].e[2][0], mat4(7.0, 1.0, 4.0, 6.0, 8.0, 6.0, -6.0, -3.0, 2.0, 3.0, -3.0, 9.0, -9.0, -3.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat4(blockC[0].e[2][1], mat4(8.0, 6.0, 5.0, 8.0, -6.0, 8.0, 5.0, 4.0, -3.0, -1.0, 3.0, 7.0, -8.0, 2.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat4(blockC[0].e[2][2], mat4(7.0, 4.0, 1.0, 8.0, -4.0, 5.0, 3.0, 0.0, 6.0, -4.0, -6.0, -9.0, 8.0, -8.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat4(blockC[0].e[2][3], mat4(8.0, -8.0, 8.0, -8.0, 9.0, 7.0, -4.0, 7.0, 4.0, -9.0, -7.0, 7.0, 0.0, -1.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat4(blockC[0].e[2][4], mat4(5.0, 0.0, -3.0, -3.0, -7.0, 9.0, 8.0, -4.0, 6.0, 3.0, 4.0, -8.0, -1.0, 0.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4(blockC[0].e[2][5], mat4(2.0, 5.0, -7.0, -8.0, 3.0, -6.0, -8.0, 3.0, -2.0, 2.0, -8.0, -4.0, -1.0, -5.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4(blockC[0].e[2][6], mat4(5.0, -7.0, 4.0, -2.0, 9.0, -9.0, -9.0, 4.0, 5.0, -6.0, -3.0, -9.0, -6.0, 0.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat4(blockC[0].e[3][0], mat4(4.0, 1.0, -5.0, -5.0, 2.0, 6.0, 3.0, -4.0, -4.0, 2.0, 2.0, 1.0, 1.0, -3.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat4(blockC[0].e[3][1], mat4(-4.0, -1.0, 0.0, 7.0, -4.0, 9.0, 9.0, 7.0, 4.0, -7.0, -1.0, 3.0, -6.0, 3.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat4(blockC[0].e[3][2], mat4(-2.0, 1.0, -7.0, -8.0, 1.0, 4.0, 9.0, 3.0, 6.0, -7.0, -8.0, -3.0, 7.0, 7.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat4(blockC[0].e[3][3], mat4(4.0, -3.0, -4.0, 9.0, 3.0, -6.0, -2.0, -7.0, 3.0, 1.0, 1.0, 1.0, 8.0, -9.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat4(blockC[0].e[3][4], mat4(1.0, -6.0, -1.0, 6.0, -7.0, -2.0, -4.0, 5.0, 6.0, 4.0, -8.0, 1.0, -8.0, -8.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4(blockC[0].e[3][5], mat4(6.0, -5.0, 2.0, 5.0, 6.0, -4.0, 1.0, 6.0, 4.0, 2.0, -7.0, -9.0, 0.0, -1.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat4(blockC[0].e[3][6], mat4(6.0, -1.0, -8.0, -9.0, -2.0, 8.0, -8.0, 8.0, 1.0, -7.0, 6.0, -7.0, -6.0, -5.0, 6.0, 8.0)) && allOk;
	allOk = compare_vec4((blockC[1].b), vec4(2.0, -9.0, 2.0, 8.0)) && allOk;
	allOk = compare_uvec4((blockC[1].c), uvec4(6u, 2u, 7u, 6u)) && allOk;
	allOk = compare_mat4(blockC[1].e[0][0], mat4(2.0, 6.0, 6.0, -2.0, -7.0, 6.0, -5.0, 8.0, -4.0, 3.0, -9.0, 5.0, 9.0, 8.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat4(blockC[1].e[0][1], mat4(-2.0, 0.0, 3.0, 3.0, -7.0, 6.0, -9.0, -5.0, -7.0, 5.0, -1.0, 4.0, 3.0, 4.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4(blockC[1].e[0][2], mat4(1.0, 9.0, -5.0, -7.0, 8.0, 5.0, 5.0, -9.0, -5.0, -2.0, 7.0, 8.0, 9.0, 7.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat4(blockC[1].e[0][3], mat4(5.0, 8.0, 2.0, 7.0, 3.0, 6.0, -6.0, -5.0, 5.0, 6.0, 3.0, 5.0, 4.0, -9.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat4(blockC[1].e[0][4], mat4(-9.0, -6.0, 1.0, -1.0, 7.0, 8.0, -8.0, 7.0, -2.0, 0.0, 9.0, 3.0, -4.0, -9.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4(blockC[1].e[0][5], mat4(-1.0, 8.0, -1.0, 0.0, 7.0, 3.0, 2.0, 5.0, 4.0, -9.0, -8.0, 6.0, 2.0, -8.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4(blockC[1].e[0][6], mat4(-3.0, 4.0, 6.0, 7.0, 3.0, 4.0, 0.0, 3.0, 5.0, 2.0, 9.0, -7.0, -7.0, -5.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3(blockD.g[0], mat3(-3.0, -1.0, 9.0, 6.0, -9.0, -6.0, 7.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat3(blockD.g[1], mat3(0.0, -4.0, -4.0, 1.0, 7.0, -1.0, 2.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat3(blockD.g[2], mat3(4.0, -9.0, -7.0, 7.0, -2.0, -8.0, -8.0, -5.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC[0].b = (vec4(3.0, -5.0, -2.0, -7.0));
	blockC[0].c = (uvec4(2u, 2u, 1u, 6u));
	blockC[0].e[0][0] = (mat4(1.0, -8.0, -6.0, -1.0, 7.0, -9.0, -1.0, -6.0, 4.0, 6.0, 5.0, 3.0, 9.0, -5.0, -1.0, 2.0));
	blockC[0].e[0][1] = (mat4(2.0, -8.0, 2.0, 6.0, 0.0, 5.0, 9.0, 4.0, -2.0, -3.0, -8.0, -7.0, -8.0, -5.0, -1.0, -7.0));
	blockC[0].e[0][2] = (mat4(-5.0, -2.0, -2.0, -5.0, 6.0, 9.0, -4.0, -6.0, 7.0, -2.0, 4.0, -1.0, -1.0, -6.0, 8.0, -8.0));
	blockC[0].e[0][3] = (mat4(3.0, -1.0, -5.0, 8.0, -8.0, 0.0, -1.0, -3.0, 0.0, -4.0, -3.0, 5.0, 8.0, 2.0, -5.0, -7.0));
	blockC[0].e[0][4] = (mat4(-6.0, 2.0, 8.0, -2.0, 6.0, 9.0, -9.0, 8.0, 9.0, 3.0, -9.0, -1.0, 3.0, -8.0, -7.0, 7.0));
	blockC[0].e[0][5] = (mat4(-5.0, -7.0, -1.0, 4.0, 9.0, 2.0, -8.0, -8.0, -4.0, 2.0, 3.0, 2.0, 2.0, -2.0, -1.0, -7.0));
	blockC[0].e[0][6] = (mat4(-5.0, 8.0, 0.0, 6.0, -5.0, -4.0, -3.0, -6.0, 5.0, -5.0, 4.0, 3.0, 3.0, 9.0, 0.0, 9.0));
	blockC[0].e[1][0] = (mat4(2.0, 2.0, -5.0, 5.0, 8.0, 4.0, 4.0, 6.0, -9.0, 6.0, 3.0, 3.0, -3.0, -1.0, 6.0, 2.0));
	blockC[0].e[1][1] = (mat4(-2.0, -8.0, -1.0, -4.0, 8.0, 7.0, 5.0, 3.0, 0.0, 0.0, 3.0, 8.0, -8.0, 4.0, 0.0, -9.0));
	blockC[0].e[1][2] = (mat4(-5.0, 5.0, 0.0, 6.0, -8.0, 8.0, -6.0, 6.0, 3.0, -2.0, -2.0, 1.0, -8.0, -5.0, -6.0, 6.0));
	blockC[0].e[1][3] = (mat4(5.0, 4.0, 9.0, -7.0, -7.0, 0.0, -4.0, 3.0, 0.0, -6.0, 7.0, -6.0, -2.0, 7.0, -4.0, -4.0));
	blockC[0].e[1][4] = (mat4(5.0, 5.0, 4.0, 1.0, -6.0, -6.0, 0.0, -2.0, 0.0, 5.0, -5.0, -9.0, -8.0, 9.0, 7.0, 8.0));
	blockC[0].e[1][5] = (mat4(6.0, -7.0, 0.0, -8.0, 1.0, 5.0, 1.0, -3.0, 9.0, -3.0, 6.0, 7.0, -6.0, -5.0, -3.0, -7.0));
	blockC[0].e[1][6] = (mat4(6.0, 4.0, -7.0, -7.0, -4.0, -5.0, -1.0, -2.0, -9.0, -7.0, -8.0, 8.0, -1.0, 8.0, 6.0, -5.0));
	blockC[0].e[2][0] = (mat4(4.0, 3.0, 9.0, -6.0, 3.0, -8.0, 9.0, -6.0, -7.0, -3.0, -1.0, -5.0, 9.0, 1.0, -8.0, 7.0));
	blockC[0].e[2][1] = (mat4(-9.0, -3.0, 0.0, 1.0, -3.0, -5.0, 0.0, 7.0, 1.0, 7.0, 0.0, 8.0, -2.0, 2.0, -6.0, 8.0));
	blockC[0].e[2][2] = (mat4(-6.0, -4.0, 1.0, -8.0, 4.0, 6.0, 3.0, 9.0, -5.0, -1.0, -5.0, -1.0, 9.0, 1.0, -3.0, 5.0));
	blockC[0].e[2][3] = (mat4(2.0, 5.0, 4.0, -6.0, 4.0, -7.0, 3.0, -5.0, 5.0, -4.0, -8.0, -1.0, -4.0, -2.0, -4.0, 5.0));
	blockC[0].e[2][4] = (mat4(-3.0, 2.0, -5.0, 4.0, -1.0, 4.0, -5.0, 3.0, -8.0, -5.0, -1.0, 2.0, 3.0, -3.0, -9.0, 4.0));
	blockC[0].e[2][5] = (mat4(-3.0, -3.0, -1.0, 1.0, 0.0, -4.0, -9.0, 1.0, -6.0, 5.0, 2.0, -2.0, -6.0, 2.0, -1.0, -7.0));
	blockC[0].e[2][6] = (mat4(1.0, 2.0, 9.0, -8.0, -2.0, -4.0, -2.0, 4.0, 5.0, 9.0, 5.0, -6.0, 0.0, 9.0, 1.0, -6.0));
	blockC[0].e[3][0] = (mat4(-2.0, -8.0, 9.0, 1.0, 4.0, -1.0, -8.0, 6.0, -1.0, -5.0, -5.0, 5.0, 8.0, 9.0, 8.0, -2.0));
	blockC[0].e[3][1] = (mat4(6.0, 3.0, -9.0, -8.0, 9.0, -2.0, 4.0, -3.0, 9.0, -5.0, -8.0, -1.0, -1.0, 2.0, 9.0, -6.0));
	blockC[0].e[3][2] = (mat4(6.0, -8.0, 8.0, -6.0, 6.0, -6.0, -4.0, 3.0, -2.0, -6.0, -6.0, 2.0, -6.0, -1.0, -8.0, -7.0));
	blockC[0].e[3][3] = (mat4(8.0, 5.0, -8.0, 7.0, 4.0, 4.0, 2.0, 3.0, -7.0, 5.0, 2.0, 4.0, -3.0, 7.0, 2.0, -7.0));
	blockC[0].e[3][4] = (mat4(6.0, 1.0, 8.0, -5.0, -9.0, 1.0, -4.0, -2.0, -9.0, -6.0, 5.0, 8.0, -3.0, 1.0, -6.0, -7.0));
	blockC[0].e[3][5] = (mat4(9.0, -5.0, -9.0, 0.0, 0.0, 4.0, -2.0, -2.0, 0.0, 4.0, -2.0, 9.0, -1.0, -3.0, 1.0, 5.0));
	blockC[0].e[3][6] = (mat4(9.0, -1.0, 8.0, 6.0, 8.0, 9.0, 6.0, -2.0, -4.0, -1.0, -5.0, -6.0, 1.0, -1.0, -1.0, -3.0));
	blockC[1].b = (vec4(7.0, 2.0, -1.0, -6.0));
	blockC[1].c = (uvec4(8u, 2u, 2u, 2u));
	blockC[1].e[0][0] = (mat4(8.0, 9.0, 2.0, 4.0, -2.0, -4.0, 1.0, -5.0, -5.0, -6.0, 6.0, -3.0, -8.0, -1.0, 3.0, -5.0));
	blockC[1].e[0][1] = (mat4(-5.0, -1.0, 7.0, -5.0, -2.0, 9.0, 0.0, 2.0, 5.0, 1.0, 9.0, 2.0, 4.0, 0.0, -1.0, 1.0));
	blockC[1].e[0][2] = (mat4(0.0, -1.0, 4.0, -4.0, 4.0, 0.0, -2.0, -2.0, -3.0, 3.0, -5.0, 6.0, -8.0, 2.0, -4.0, -4.0));
	blockC[1].e[0][3] = (mat4(-6.0, -8.0, 4.0, 5.0, -2.0, -1.0, 7.0, 2.0, 4.0, 4.0, -1.0, 6.0, 1.0, -1.0, 9.0, -4.0));
	blockC[1].e[0][4] = (mat4(-8.0, -2.0, 9.0, -8.0, -8.0, -1.0, -9.0, 2.0, 2.0, -1.0, -9.0, 4.0, 5.0, -4.0, 8.0, -8.0));
	blockC[1].e[0][5] = (mat4(2.0, -8.0, -6.0, -8.0, 8.0, 4.0, 3.0, 5.0, -1.0, 5.0, -3.0, -8.0, 7.0, 6.0, -9.0, 5.0));
	blockC[1].e[0][6] = (mat4(6.0, -7.0, -8.0, -9.0, 6.0, 6.0, 8.0, 9.0, 3.0, -2.0, -6.0, -5.0, 7.0, 1.0, 3.0, 2.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, buffer_reference) buffer BlockB
{
	u8vec2 a;
	lowp mat4x2 b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = (mat4x2(2.0, -1.0, 2.0, 2.0, -5.0, 7.0, -5.0, 5.0));
	blockB[nonuniformEXT(1)].b = (mat4x2(-8.0, 9.0, -2.0, 5.0, -1.0, 9.0, 2.0, 3.0));
	blockB[nonuniformEXT(2)].b = (mat4x2(-6.0, 3.0, 5.0, 5.0, 9.0, 3.0, -9.0, -1.0));
	blockB[nonuniformEXT(3)].b = (mat4x2(3.0, 0.0, -6.0, -8.0, -3.0, 8.0, 2.0, -4.0));
}
