#version 450
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
	mediump mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var, mat3(8.0, -3.0, -9.0, 8.0, -4.0, 0.0, -8.0, -7.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3(-4.0, 1.0, 7.0, -2.0, 4.0, 1.0, 5.0, -4.0, 1.0));
}
#version 450
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
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -1.0) && allOk;
	allOk = compare_float(var[0][1], -9.0) && allOk;
	allOk = compare_float(var[1][0], 4.0) && allOk;
	allOk = compare_float(var[1][1], 5.0) && allOk;
	allOk = compare_float(var[2][0], 3.0) && allOk;
	allOk = compare_float(var[2][1], -5.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-1.0, -9.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(4.0, 5.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3x2(-2.0, 9.0, -5.0, -5.0, -7.0, -2.0));
}
#version 450
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
	allOk = compare_float(var[0][0], -3.0) && allOk;
	allOk = compare_float(var[0][1], -1.0) && allOk;
	allOk = compare_float(var[0][2], -2.0) && allOk;
	allOk = compare_float(var[0][3], -7.0) && allOk;
	allOk = compare_float(var[1][0], 6.0) && allOk;
	allOk = compare_float(var[1][1], 2.0) && allOk;
	allOk = compare_float(var[1][2], 8.0) && allOk;
	allOk = compare_float(var[1][3], -5.0) && allOk;
	allOk = compare_float(var[2][0], 6.0) && allOk;
	allOk = compare_float(var[2][1], -4.0) && allOk;
	allOk = compare_float(var[2][2], 2.0) && allOk;
	allOk = compare_float(var[2][3], 5.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-3.0, -1.0, -2.0, -7.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(6.0, 2.0, 8.0, -5.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(6.0, -4.0, 2.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3x4(-5.0, 8.0, 7.0, 1.0, -4.0, -9.0, 1.0, 4.0, 3.0, 8.0, 8.0, -7.0));
}
#version 450
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
	highp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var, mat4x2(4.0, 9.0, -1.0, 1.0, 7.0, -8.0, 9.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x2(3.0, -6.0, -3.0, 7.0, 2.0, -3.0, 7.0, 4.0));
}
#version 450
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
	highp float var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((var), 7.0) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (7.0);
}
#version 450
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
	highp uint var;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((var), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (7u);
}
#version 450
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
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var, mat2x3(-9.0, -1.0, 8.0, -7.0, 7.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2x3(-7.0, 9.0, 4.0, 0.0, -8.0, -2.0));
}
#version 450
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
	lowp mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -7.0) && allOk;
	allOk = compare_float(var[0][1], -9.0) && allOk;
	allOk = compare_float(var[0][2], 9.0) && allOk;
	allOk = compare_float(var[0][3], 8.0) && allOk;
	allOk = compare_float(var[1][0], -4.0) && allOk;
	allOk = compare_float(var[1][1], 7.0) && allOk;
	allOk = compare_float(var[1][2], -2.0) && allOk;
	allOk = compare_float(var[1][3], -5.0) && allOk;
	allOk = compare_float(var[2][0], -7.0) && allOk;
	allOk = compare_float(var[2][1], 0.0) && allOk;
	allOk = compare_float(var[2][2], -9.0) && allOk;
	allOk = compare_float(var[2][3], -4.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-7.0, -9.0, 9.0, 8.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-4.0, 7.0, -2.0, -5.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-7.0, 0.0, -9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3x4(5.0, 7.0, -4.0, 0.0, 4.0, -1.0, 9.0, -2.0, 3.0, 2.0, -7.0, 7.0));
}
#version 450
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

layout(std430, row_major, binding = 1) buffer Block
{
	lowp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var, mat4x2(-2.0, 1.0, 8.0, 4.0, 9.0, -4.0, -1.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x2(4.0, 7.0, 1.0, -9.0, -6.0, 7.0, -3.0, 8.0));
}
#version 450
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
	highp mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var, mat4x3(-5.0, 2.0, -3.0, 1.0, -2.0, -6.0, 1.0, -8.0, -3.0, -4.0, 3.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(-3.0, -5.0, 8.0));
	var[1] = (vec3(-8.0, -1.0, -5.0));
	var[2] = (vec3(0.0, 7.0, 3.0));
	var[3] = (vec3(-1.0, 7.0, 1.0));
}
#version 450
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
	highp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -9.0) && allOk;
	allOk = compare_mat3(var, mat3(-8.0, 7.0, 3.0, -2.0, -8.0, -1.0, 4.0, -2.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (4.0);
	var[0] = (vec3(4.0, 6.0, -7.0));
	var[1] = (vec3(9.0, -1.0, -5.0));
	var[2] = (vec3(5.0, 3.0, -7.0));
}
#version 450
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
	highp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_float(var[0][0], 6.0) && allOk;
	allOk = compare_float(var[0][1], 9.0) && allOk;
	allOk = compare_float(var[0][2], -2.0) && allOk;
	allOk = compare_float(var[0][3], -2.0) && allOk;
	allOk = compare_float(var[1][0], -1.0) && allOk;
	allOk = compare_float(var[1][1], 0.0) && allOk;
	allOk = compare_float(var[1][2], 1.0) && allOk;
	allOk = compare_float(var[1][3], 4.0) && allOk;
	allOk = compare_float(var[2][0], 2.0) && allOk;
	allOk = compare_float(var[2][1], -4.0) && allOk;
	allOk = compare_float(var[2][2], -5.0) && allOk;
	allOk = compare_float(var[2][3], -2.0) && allOk;
	allOk = compare_float(var[3][0], 5.0) && allOk;
	allOk = compare_float(var[3][1], 0.0) && allOk;
	allOk = compare_float(var[3][2], -8.0) && allOk;
	allOk = compare_float(var[3][3], -2.0) && allOk;
	allOk = compare_vec4(var[0], vec4(6.0, 9.0, -2.0, -2.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-1.0, 0.0, 1.0, 4.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(2.0, -4.0, -5.0, -2.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(5.0, 0.0, -8.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-9.0);
	var[0] = (vec4(5.0, 0.0, 3.0, -7.0));
	var[1] = (vec4(9.0, -4.0, -5.0, 2.0));
	var[2] = (vec4(-2.0, 4.0, 1.0, 9.0));
	var[3] = (vec4(-7.0, -8.0, -9.0, -7.0));
}
#version 450
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
	f16vec3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(padding), 4.0) && allOk;
	allOk = compare_f16vec3(vec3(var), vec3(1.0, 9.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = float16_t(3.0);
	var = f16vec3(vec3(3.0, 7.0, -3.0));
}
#version 450
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
	allOk = compare_mat3x2(var[0], mat3x2(-5.0, 7.0, -1.0, -4.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(-5.0, 7.0, -4.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(8.0, -3.0, 3.0, -5.0, -3.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec2(-8.0, -4.0));
	var[0][1] = (vec2(-3.0, 5.0));
	var[0][2] = (vec2(-9.0, 4.0));
	var[1][0] = (vec2(-2.0, -1.0));
	var[1][1] = (vec2(8.0, 3.0));
	var[1][2] = (vec2(7.0, 2.0));
	var[2][0] = (vec2(-4.0, 4.0));
	var[2][1] = (vec2(3.0, -6.0));
	var[2][2] = (vec2(-4.0, 3.0));
}
#version 450
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

	var[0][0] = (vec4(8.0, 8.0, -2.0, 8.0));
	var[0][1] = (vec4(8.0, 3.0, 5.0, -5.0));
	var[0][2] = (vec4(7.0, 6.0, -9.0, 3.0));
	var[1][0] = (vec4(0.0, -3.0, 1.0, -9.0));
	var[1][1] = (vec4(-9.0, -6.0, -5.0, 1.0));
	var[1][2] = (vec4(9.0, 0.0, -9.0, -2.0));
	var[2][0] = (vec4(-4.0, -3.0, -1.0, -6.0));
	var[2][1] = (vec4(1.0, -2.0, -2.0, -1.0));
	var[2][2] = (vec4(-7.0, 8.0, 0.0, -6.0));
}
#version 450
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

	var[0] = i16vec4(ivec4(-4, -8, -4, 9));
	var[1] = i16vec4(ivec4(2, 7, -4, 4));
	var[2] = i16vec4(ivec4(8, 9, 5, 1));
}
#version 450
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

	var[0] = (7u);
	var[1] = (9u);
	var[2] = (1u);
	var[3] = (0u);
	var[4] = (7u);
	var[5] = (7u);
	var[6] = (4u);
	var[7] = (8u);
	var[8] = (7u);
	var[9] = (5u);
	var[10] = (7u);
	var[11] = (2u);
	var[12] = (7u);
	var[13] = (8u);
	var[14] = (6u);
	var[15] = (1u);
	var[16] = (9u);
	var[17] = (8u);
	var[18] = (6u);
}
#version 450
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
	highp mat2x4 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0], mat2x4(-3.0, 3.0, 6.0, 0.0, -2.0, 1.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(0.0, -1.0, 3.0, 9.0, 1.0, 1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(6.0, 1.0, -8.0, 2.0, 2.0, -6.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[3], mat2x4(1.0, -3.0, -7.0, -4.0, 0.0, -9.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[4], mat2x4(-2.0, 4.0, -8.0, 4.0, 9.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[5], mat2x4(8.0, 0.0, -3.0, 9.0, 5.0, -3.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[6], mat2x4(-6.0, -5.0, 8.0, 2.0, -2.0, 9.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[7], mat2x4(-1.0, 5.0, 0.0, -4.0, 2.0, 3.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[8], mat2x4(2.0, 1.0, 0.0, -1.0, -5.0, 2.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[9], mat2x4(3.0, 3.0, 4.0, 8.0, 4.0, -5.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[10], mat2x4(-1.0, 0.0, 0.0, -2.0, -1.0, 1.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[11], mat2x4(-9.0, 2.0, -8.0, 1.0, 3.0, -7.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[12], mat2x4(9.0, 0.0, -3.0, 4.0, 4.0, -5.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[13], mat2x4(-8.0, -3.0, 1.0, 8.0, -8.0, 0.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[14], mat2x4(-5.0, 5.0, 8.0, -8.0, 4.0, 7.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[15], mat2x4(5.0, 9.0, 3.0, -3.0, -8.0, 3.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[16], mat2x4(4.0, -7.0, 1.0, -4.0, 7.0, 0.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[17], mat2x4(8.0, -6.0, 1.0, 8.0, 5.0, 8.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[18], mat2x4(1.0, 9.0, -9.0, -8.0, 5.0, -5.0, -1.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec4(2.0, 1.0, 7.0, 1.0));
	var[0][1] = (vec4(-1.0, -8.0, 7.0, 5.0));
	var[1][0] = (vec4(-7.0, 2.0, -1.0, 4.0));
	var[1][1] = (vec4(7.0, -4.0, 8.0, -2.0));
	var[2][0] = (vec4(2.0, 5.0, -2.0, 1.0));
	var[2][1] = (vec4(1.0, 0.0, -4.0, 1.0));
	var[3][0] = (vec4(0.0, 5.0, -3.0, 3.0));
	var[3][1] = (vec4(9.0, -1.0, -7.0, -7.0));
	var[4][0] = (vec4(1.0, 9.0, -1.0, 8.0));
	var[4][1] = (vec4(7.0, 6.0, 7.0, -4.0));
	var[5][0] = (vec4(-4.0, 2.0, -4.0, 6.0));
	var[5][1] = (vec4(4.0, -1.0, -9.0, 3.0));
	var[6][0] = (vec4(0.0, -3.0, -2.0, 3.0));
	var[6][1] = (vec4(-6.0, 8.0, -9.0, -3.0));
	var[7][0] = (vec4(-9.0, 3.0, -2.0, 6.0));
	var[7][1] = (vec4(4.0, 7.0, -7.0, 7.0));
	var[8][0] = (vec4(5.0, 2.0, 7.0, -9.0));
	var[8][1] = (vec4(-4.0, -3.0, -2.0, 4.0));
	var[9][0] = (vec4(-3.0, -8.0, -4.0, 6.0));
	var[9][1] = (vec4(-1.0, -1.0, 6.0, -8.0));
	var[10][0] = (vec4(-4.0, -2.0, -8.0, 4.0));
	var[10][1] = (vec4(-2.0, 4.0, -8.0, 6.0));
	var[11][0] = (vec4(4.0, -8.0, 8.0, -8.0));
	var[11][1] = (vec4(4.0, 0.0, -9.0, 1.0));
	var[12][0] = (vec4(-4.0, 8.0, 5.0, 5.0));
	var[12][1] = (vec4(6.0, 7.0, 9.0, 5.0));
	var[13][0] = (vec4(9.0, 9.0, 2.0, -5.0));
	var[13][1] = (vec4(5.0, 9.0, -6.0, -8.0));
	var[14][0] = (vec4(-2.0, 0.0, 7.0, 4.0));
	var[14][1] = (vec4(8.0, -3.0, -7.0, -6.0));
	var[15][0] = (vec4(-6.0, -1.0, 5.0, -7.0));
	var[15][1] = (vec4(-8.0, -6.0, 3.0, -3.0));
	var[16][0] = (vec4(-4.0, -4.0, 5.0, -9.0));
	var[16][1] = (vec4(-3.0, 0.0, -2.0, 7.0));
	var[17][0] = (vec4(3.0, 3.0, -3.0, 9.0));
	var[17][1] = (vec4(-2.0, 1.0, -8.0, -2.0));
	var[18][0] = (vec4(6.0, -5.0, 0.0, 4.0));
	var[18][1] = (vec4(8.0, -6.0, 8.0, -7.0));
}
#version 450
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

	var[0] = (mat2x4(-2.0, 3.0, 2.0, -4.0, 2.0, -2.0, 9.0, -4.0));
	var[1] = (mat2x4(0.0, 7.0, 4.0, -8.0, 6.0, 0.0, -1.0, -8.0));
	var[2] = (mat2x4(2.0, 8.0, 2.0, 4.0, 5.0, 4.0, -3.0, 4.0));
	var[3] = (mat2x4(-6.0, 1.0, 7.0, -9.0, 7.0, -5.0, -1.0, -8.0));
	var[4] = (mat2x4(-2.0, -6.0, -6.0, 6.0, 6.0, -7.0, 6.0, 9.0));
	var[5] = (mat2x4(3.0, 9.0, 4.0, -6.0, 7.0, -1.0, 9.0, 5.0));
	var[6] = (mat2x4(-7.0, 0.0, -8.0, 2.0, -6.0, -5.0, 9.0, 2.0));
	var[7] = (mat2x4(2.0, 3.0, 4.0, 6.0, -7.0, -3.0, 5.0, 2.0));
	var[8] = (mat2x4(4.0, 2.0, 8.0, -5.0, -9.0, -1.0, 6.0, -2.0));
	var[9] = (mat2x4(4.0, 1.0, -1.0, -1.0, 7.0, 0.0, 6.0, 9.0));
	var[10] = (mat2x4(5.0, 9.0, -6.0, -6.0, -2.0, -9.0, 9.0, 3.0));
	var[11] = (mat2x4(2.0, 4.0, -3.0, 6.0, 6.0, 9.0, 1.0, 5.0));
	var[12] = (mat2x4(1.0, -7.0, -5.0, 8.0, 7.0, 5.0, -9.0, 8.0));
	var[13] = (mat2x4(-9.0, -3.0, 4.0, 1.0, 7.0, 5.0, -2.0, 7.0));
	var[14] = (mat2x4(5.0, 2.0, 3.0, -3.0, -1.0, 8.0, 4.0, -9.0));
	var[15] = (mat2x4(2.0, 5.0, 5.0, -9.0, -7.0, 9.0, 4.0, -1.0));
	var[16] = (mat2x4(7.0, 7.0, -4.0, 6.0, 0.0, -9.0, 5.0, -7.0));
	var[17] = (mat2x4(-4.0, 5.0, -1.0, 5.0, 8.0, -2.0, -5.0, 5.0));
	var[18] = (mat2x4(8.0, 2.0, 5.0, 5.0, 6.0, -6.0, 6.0, -3.0));
}
#version 450
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
	highp mat3x4 var[];
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
	allOk = compare_mat3x4(var[3], mat3x4(-4.0, -4.0, 2.0, -2.0, 1.0, 3.0, -5.0, -4.0, 9.0, 6.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[4], mat3x4(9.0, 3.0, 9.0, -8.0, 9.0, -4.0, -4.0, 7.0, -1.0, -7.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[5], mat3x4(-5.0, -4.0, -9.0, 1.0, 6.0, 6.0, 2.0, 1.0, 0.0, 1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[6], mat3x4(6.0, 0.0, -7.0, 9.0, -8.0, 6.0, 0.0, 9.0, -1.0, -9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[7], mat3x4(1.0, 9.0, -9.0, -8.0, 0.0, 2.0, 9.0, 6.0, 3.0, 9.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[8], mat3x4(-7.0, -2.0, -1.0, -9.0, -9.0, 6.0, -6.0, -9.0, -4.0, -4.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[9], mat3x4(9.0, 1.0, -6.0, 9.0, -3.0, -9.0, -2.0, -9.0, -7.0, -4.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[10], mat3x4(-3.0, 5.0, 0.0, -7.0, 9.0, -8.0, -9.0, -4.0, -6.0, 7.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[11], mat3x4(4.0, 4.0, 1.0, -1.0, 9.0, -6.0, -6.0, -4.0, 4.0, 8.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[12], mat3x4(6.0, 7.0, 9.0, 7.0, 0.0, 8.0, -1.0, 0.0, 6.0, -3.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[13], mat3x4(7.0, -7.0, 1.0, 0.0, -9.0, 2.0, -3.0, 7.0, 8.0, -6.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[14], mat3x4(0.0, 8.0, -8.0, -9.0, 5.0, -4.0, -5.0, 3.0, 4.0, 3.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[15], mat3x4(9.0, -4.0, -6.0, 0.0, 0.0, -9.0, 6.0, 4.0, -6.0, -3.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[16], mat3x4(5.0, 2.0, -1.0, 1.0, 1.0, 7.0, 0.0, 8.0, 9.0, 0.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[17], mat3x4(-5.0, 1.0, 4.0, 5.0, 5.0, 0.0, 7.0, -5.0, 6.0, -2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[18], mat3x4(-2.0, -2.0, 7.0, -9.0, 3.0, 6.0, -5.0, -8.0, -3.0, -3.0, 9.0, -8.0)) && allOk;
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
	var[3][0] = (vec4(6.0, 4.0, -5.0, 8.0));
	var[3][1] = (vec4(-5.0, -8.0, -9.0, -8.0));
	var[3][2] = (vec4(9.0, 0.0, 3.0, -4.0));
	var[4][0] = (vec4(0.0, -6.0, 5.0, 1.0));
	var[4][1] = (vec4(9.0, -8.0, -1.0, -7.0));
	var[4][2] = (vec4(1.0, 2.0, 0.0, -9.0));
	var[5][0] = (vec4(2.0, 0.0, 5.0, -4.0));
	var[5][1] = (vec4(-7.0, 0.0, 3.0, 4.0));
	var[5][2] = (vec4(4.0, 5.0, 2.0, -3.0));
	var[6][0] = (vec4(0.0, -7.0, 3.0, -8.0));
	var[6][1] = (vec4(3.0, -2.0, -3.0, 1.0));
	var[6][2] = (vec4(-5.0, -9.0, -7.0, -7.0));
	var[7][0] = (vec4(-2.0, -9.0, -7.0, -8.0));
	var[7][1] = (vec4(7.0, -6.0, -4.0, 6.0));
	var[7][2] = (vec4(-5.0, -4.0, -8.0, -4.0));
	var[8][0] = (vec4(9.0, -2.0, 7.0, -9.0));
	var[8][1] = (vec4(-6.0, -4.0, 5.0, -5.0));
	var[8][2] = (vec4(-5.0, 7.0, 6.0, 6.0));
	var[9][0] = (vec4(0.0, 9.0, -3.0, -9.0));
	var[9][1] = (vec4(-7.0, 6.0, -7.0, -1.0));
	var[9][2] = (vec4(-6.0, -6.0, 2.0, 8.0));
	var[10][0] = (vec4(-6.0, 6.0, -8.0, -3.0));
	var[10][1] = (vec4(2.0, 0.0, 0.0, -2.0));
	var[10][2] = (vec4(-9.0, -3.0, 2.0, 2.0));
	var[11][0] = (vec4(-7.0, -4.0, 9.0, 7.0));
	var[11][1] = (vec4(-3.0, 1.0, -7.0, 9.0));
	var[11][2] = (vec4(-9.0, -8.0, 0.0, 8.0));
	var[12][0] = (vec4(6.0, 2.0, 8.0, -5.0));
	var[12][1] = (vec4(9.0, 5.0, 9.0, -1.0));
	var[12][2] = (vec4(-2.0, -5.0, -6.0, -8.0));
	var[13][0] = (vec4(0.0, -4.0, 7.0, 1.0));
	var[13][1] = (vec4(4.0, 1.0, 9.0, 9.0));
	var[13][2] = (vec4(-9.0, -5.0, 3.0, 8.0));
	var[14][0] = (vec4(4.0, -1.0, -2.0, 2.0));
	var[14][1] = (vec4(-5.0, 4.0, -2.0, -4.0));
	var[14][2] = (vec4(8.0, -7.0, -1.0, -9.0));
	var[15][0] = (vec4(8.0, 5.0, 3.0, 6.0));
	var[15][1] = (vec4(0.0, 6.0, 0.0, 2.0));
	var[15][2] = (vec4(-1.0, -5.0, -6.0, -4.0));
	var[16][0] = (vec4(-3.0, -5.0, -4.0, -4.0));
	var[16][1] = (vec4(-8.0, -8.0, 1.0, 7.0));
	var[16][2] = (vec4(-6.0, -3.0, -7.0, 1.0));
	var[17][0] = (vec4(-5.0, 5.0, 0.0, 1.0));
	var[17][1] = (vec4(6.0, 2.0, 5.0, 5.0));
	var[17][2] = (vec4(5.0, -1.0, -7.0, -1.0));
	var[18][0] = (vec4(1.0, -1.0, -4.0, 2.0));
	var[18][1] = (vec4(5.0, 8.0, 5.0, -9.0));
	var[18][2] = (vec4(7.0, -9.0, 0.0, -3.0));
}
#version 450
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

layout(scalar, row_major, binding = 1) buffer Block
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

	var[0] = (mat3x2(-3.0, 7.0, -3.0, -4.0, 2.0, -7.0));
	var[1] = (mat3x2(-2.0, 9.0, -8.0, -2.0, 3.0, 4.0));
	var[2] = (mat3x2(4.0, 1.0, -7.0, 9.0, 9.0, -1.0));
	var[3] = (mat3x2(-9.0, 3.0, 0.0, -8.0, -3.0, 8.0));
	var[4] = (mat3x2(5.0, 0.0, 9.0, 0.0, 9.0, 8.0));
	var[5] = (mat3x2(2.0, 6.0, 0.0, 7.0, 6.0, 4.0));
	var[6] = (mat3x2(9.0, 7.0, 7.0, -2.0, 8.0, 3.0));
	var[7] = (mat3x2(-9.0, 8.0, 4.0, -5.0, 3.0, -6.0));
	var[8] = (mat3x2(7.0, 2.0, 6.0, 3.0, 5.0, 1.0));
	var[9] = (mat3x2(0.0, 8.0, -4.0, 0.0, -9.0, 0.0));
	var[10] = (mat3x2(7.0, 3.0, 5.0, -1.0, 3.0, -3.0));
	var[11] = (mat3x2(-2.0, 1.0, 0.0, -5.0, -9.0, -4.0));
	var[12] = (mat3x2(7.0, -4.0, 6.0, -9.0, -2.0, -7.0));
	var[13] = (mat3x2(-2.0, -2.0, -1.0, 7.0, 3.0, -9.0));
	var[14] = (mat3x2(6.0, -8.0, 1.0, -2.0, -2.0, 3.0));
	var[15] = (mat3x2(-9.0, 8.0, 3.0, 2.0, 3.0, 7.0));
	var[16] = (mat3x2(-9.0, 3.0, -6.0, -9.0, -4.0, -8.0));
	var[17] = (mat3x2(5.0, 8.0, 8.0, -6.0, -8.0, -4.0));
	var[18] = (mat3x2(-3.0, 2.0, -3.0, -9.0, 1.0, -7.0));
}
#version 450
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
	highp mat4x3 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0], mat4x3(3.0, 9.0, 5.0, 5.0, 8.0, -9.0, 1.0, -3.0, 3.0, 6.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(-9.0, -2.0, -1.0, 6.0, 6.0, 9.0, 0.0, 3.0, -4.0, 2.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(6.0, 8.0, 7.0, 6.0, 1.0, 3.0, 8.0, -4.0, 7.0, -9.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[3], mat4x3(-4.0, -7.0, 7.0, -5.0, 2.0, 4.0, 9.0, 2.0, 6.0, -3.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[4], mat4x3(3.0, -3.0, 0.0, 8.0, 6.0, -1.0, 9.0, 6.0, 0.0, 4.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[5], mat4x3(6.0, 2.0, -1.0, -6.0, -9.0, 7.0, -9.0, -9.0, 8.0, 6.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[6], mat4x3(-9.0, -5.0, -9.0, 1.0, -9.0, 3.0, 4.0, 0.0, -8.0, -3.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[7], mat4x3(-7.0, -4.0, 0.0, 2.0, 3.0, -9.0, -3.0, 0.0, -7.0, 8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[8], mat4x3(-7.0, 4.0, 9.0, 8.0, -5.0, -5.0, 6.0, 8.0, -7.0, 1.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[9], mat4x3(0.0, -9.0, -1.0, 9.0, 2.0, -9.0, 8.0, 0.0, 1.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[10], mat4x3(5.0, -5.0, -1.0, -9.0, 7.0, 5.0, 0.0, 7.0, -3.0, -7.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[11], mat4x3(-3.0, 1.0, 7.0, -9.0, 6.0, 7.0, -5.0, 8.0, -2.0, -6.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[12], mat4x3(-1.0, 1.0, 9.0, 7.0, 0.0, 9.0, -1.0, -1.0, -7.0, 0.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[13], mat4x3(5.0, 7.0, -6.0, -7.0, 6.0, -5.0, -4.0, -1.0, 8.0, 7.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[14], mat4x3(-2.0, -5.0, -2.0, -2.0, 9.0, 9.0, -6.0, 0.0, -5.0, 6.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[15], mat4x3(8.0, -9.0, 6.0, -7.0, 6.0, 5.0, -5.0, -1.0, 5.0, -7.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[16], mat4x3(8.0, 3.0, -1.0, 2.0, 5.0, -8.0, 0.0, -6.0, 4.0, 6.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[17], mat4x3(8.0, 4.0, -1.0, -5.0, 0.0, -6.0, 3.0, 7.0, -8.0, -4.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[18], mat4x3(6.0, -3.0, 0.0, -6.0, -3.0, -6.0, 8.0, 4.0, 2.0, 4.0, -2.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4x3(-5.0, 9.0, 2.0, -5.0, 1.0, 6.0, 4.0, 3.0, 9.0, -4.0, 3.0, 1.0));
	var[1] = (mat4x3(-5.0, 2.0, 4.0, -6.0, 1.0, 3.0, -6.0, -1.0, -4.0, 3.0, 9.0, -1.0));
	var[2] = (mat4x3(4.0, 2.0, 8.0, -9.0, -8.0, -5.0, -9.0, -6.0, -7.0, 6.0, -5.0, -5.0));
	var[3] = (mat4x3(9.0, -7.0, -4.0, -3.0, -2.0, 6.0, 2.0, 3.0, -8.0, -7.0, 9.0, -1.0));
	var[4] = (mat4x3(9.0, 0.0, 0.0, 7.0, 7.0, 9.0, -7.0, -4.0, 7.0, -5.0, 0.0, -1.0));
	var[5] = (mat4x3(-4.0, 1.0, 3.0, -5.0, -2.0, -6.0, -8.0, -7.0, -9.0, -2.0, 2.0, 9.0));
	var[6] = (mat4x3(-8.0, -3.0, -8.0, -5.0, 2.0, -9.0, 2.0, 9.0, 8.0, 7.0, 9.0, -6.0));
	var[7] = (mat4x3(8.0, -8.0, -9.0, 9.0, 8.0, -3.0, 4.0, 8.0, 2.0, -9.0, -8.0, 5.0));
	var[8] = (mat4x3(-8.0, 9.0, 8.0, -9.0, 8.0, -3.0, -9.0, -6.0, 1.0, -1.0, -2.0, -1.0));
	var[9] = (mat4x3(8.0, -3.0, -6.0, 2.0, -2.0, 0.0, -4.0, -5.0, 8.0, 2.0, 9.0, -1.0));
	var[10] = (mat4x3(1.0, -6.0, -5.0, -5.0, 6.0, 8.0, 7.0, 0.0, 7.0, 1.0, 4.0, 9.0));
	var[11] = (mat4x3(-4.0, 8.0, 5.0, -4.0, -9.0, -1.0, 0.0, 5.0, -4.0, -1.0, -3.0, -5.0));
	var[12] = (mat4x3(4.0, 9.0, 7.0, 5.0, 7.0, -2.0, -4.0, -2.0, 3.0, -6.0, 0.0, -7.0));
	var[13] = (mat4x3(9.0, -6.0, -9.0, 5.0, -1.0, -2.0, 4.0, 7.0, 2.0, 8.0, -7.0, 9.0));
	var[14] = (mat4x3(7.0, 3.0, 4.0, 9.0, 8.0, -1.0, -6.0, -4.0, 5.0, -8.0, -4.0, 1.0));
	var[15] = (mat4x3(-1.0, 6.0, 7.0, -9.0, 0.0, 8.0, -4.0, 2.0, 0.0, 3.0, -3.0, 1.0));
	var[16] = (mat4x3(7.0, 7.0, -6.0, 0.0, 1.0, 7.0, 2.0, 8.0, -2.0, -5.0, 8.0, 3.0));
	var[17] = (mat4x3(-1.0, -5.0, -8.0, 1.0, 4.0, 0.0, 2.0, -3.0, 8.0, -5.0, -9.0, 4.0));
	var[18] = (mat4x3(5.0, -9.0, 3.0, -6.0, -1.0, 2.0, 6.0, -2.0, 0.0, 5.0, -5.0, -5.0));
}
#version 450
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
	highp mat4x3 var[];
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
	allOk = compare_mat4x3(var[3], mat4x3(1.0, 7.0, -4.0, 6.0, 0.0, 2.0, 2.0, 3.0, -9.0, 4.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[4], mat4x3(5.0, 4.0, 8.0, -8.0, 0.0, 5.0, -5.0, 7.0, 9.0, -8.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[5], mat4x3(6.0, 3.0, 0.0, -3.0, 0.0, -2.0, 5.0, 1.0, 1.0, 6.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[6], mat4x3(5.0, -7.0, -7.0, -6.0, -9.0, 6.0, 7.0, -3.0, -3.0, 9.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[7], mat4x3(2.0, 5.0, 2.0, 0.0, 9.0, -8.0, -2.0, -2.0, -1.0, -2.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[8], mat4x3(-9.0, -1.0, -2.0, -2.0, 8.0, -3.0, -7.0, 1.0, -6.0, 8.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[9], mat4x3(-5.0, -8.0, 7.0, 3.0, 7.0, 9.0, 7.0, 9.0, -2.0, -4.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[10], mat4x3(5.0, 2.0, 7.0, 6.0, -5.0, -7.0, 3.0, -9.0, -5.0, -8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[11], mat4x3(-7.0, 4.0, 6.0, 2.0, 8.0, -1.0, 5.0, 2.0, 7.0, 1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[12], mat4x3(8.0, 3.0, -4.0, -1.0, -1.0, 6.0, 4.0, -5.0, 5.0, 4.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[13], mat4x3(-2.0, -4.0, 7.0, -7.0, -5.0, 7.0, 0.0, 0.0, -1.0, -5.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[14], mat4x3(8.0, 9.0, 4.0, 2.0, 6.0, 1.0, -3.0, 0.0, 1.0, -6.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[15], mat4x3(0.0, 9.0, 4.0, -6.0, 8.0, 9.0, 3.0, -5.0, -8.0, 4.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[16], mat4x3(7.0, -4.0, -1.0, -2.0, 6.0, 7.0, 5.0, -4.0, 3.0, 1.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[17], mat4x3(4.0, -5.0, 9.0, 5.0, 6.0, 2.0, 5.0, 5.0, 4.0, 6.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[18], mat4x3(-4.0, -2.0, -6.0, -6.0, -1.0, -4.0, 1.0, 5.0, -2.0, 2.0, -5.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec3(1.0, 3.0, -7.0));
	var[0][1] = (vec3(-7.0, 2.0, 3.0));
	var[0][2] = (vec3(1.0, -2.0, -1.0));
	var[0][3] = (vec3(-5.0, -1.0, 9.0));
	var[1][0] = (vec3(8.0, -4.0, 3.0));
	var[1][1] = (vec3(4.0, 9.0, -6.0));
	var[1][2] = (vec3(7.0, 6.0, -5.0));
	var[1][3] = (vec3(2.0, 6.0, 3.0));
	var[2][0] = (vec3(2.0, 7.0, -1.0));
	var[2][1] = (vec3(-3.0, -3.0, -7.0));
	var[2][2] = (vec3(-5.0, 3.0, 4.0));
	var[2][3] = (vec3(-4.0, -2.0, 8.0));
	var[3][0] = (vec3(-1.0, -8.0, 8.0));
	var[3][1] = (vec3(-4.0, -7.0, -7.0));
	var[3][2] = (vec3(8.0, 4.0, -6.0));
	var[3][3] = (vec3(6.0, 0.0, 1.0));
	var[4][0] = (vec3(7.0, -1.0, -8.0));
	var[4][1] = (vec3(9.0, 9.0, -6.0));
	var[4][2] = (vec3(0.0, 1.0, 1.0));
	var[4][3] = (vec3(2.0, 7.0, 2.0));
	var[5][0] = (vec3(-3.0, -6.0, 5.0));
	var[5][1] = (vec3(3.0, -1.0, -1.0));
	var[5][2] = (vec3(-2.0, 9.0, -5.0));
	var[5][3] = (vec3(8.0, -6.0, -5.0));
	var[6][0] = (vec3(-9.0, 3.0, -2.0));
	var[6][1] = (vec3(5.0, 6.0, -7.0));
	var[6][2] = (vec3(-8.0, 1.0, 8.0));
	var[6][3] = (vec3(1.0, 6.0, -1.0));
	var[7][0] = (vec3(-5.0, 0.0, -6.0));
	var[7][1] = (vec3(5.0, -3.0, 2.0));
	var[7][2] = (vec3(-5.0, 2.0, -2.0));
	var[7][3] = (vec3(-7.0, -9.0, -1.0));
	var[8][0] = (vec3(-2.0, -3.0, -7.0));
	var[8][1] = (vec3(-9.0, -4.0, 9.0));
	var[8][2] = (vec3(4.0, -4.0, 5.0));
	var[8][3] = (vec3(7.0, 1.0, 7.0));
	var[9][0] = (vec3(-9.0, 5.0, 4.0));
	var[9][1] = (vec3(4.0, 0.0, 0.0));
	var[9][2] = (vec3(0.0, -3.0, 3.0));
	var[9][3] = (vec3(1.0, 8.0, 0.0));
	var[10][0] = (vec3(-2.0, 9.0, -8.0));
	var[10][1] = (vec3(-8.0, 7.0, -9.0));
	var[10][2] = (vec3(3.0, -2.0, -3.0));
	var[10][3] = (vec3(-5.0, 1.0, -4.0));
	var[11][0] = (vec3(5.0, 5.0, 8.0));
	var[11][1] = (vec3(3.0, 7.0, -3.0));
	var[11][2] = (vec3(-2.0, 2.0, -9.0));
	var[11][3] = (vec3(0.0, 9.0, 5.0));
	var[12][0] = (vec3(-5.0, 5.0, -2.0));
	var[12][1] = (vec3(1.0, -7.0, -9.0));
	var[12][2] = (vec3(4.0, -9.0, 8.0));
	var[12][3] = (vec3(2.0, 5.0, -4.0));
	var[13][0] = (vec3(-9.0, -9.0, 5.0));
	var[13][1] = (vec3(-3.0, 6.0, -3.0));
	var[13][2] = (vec3(7.0, -9.0, -4.0));
	var[13][3] = (vec3(9.0, 6.0, 2.0));
	var[14][0] = (vec3(-3.0, -5.0, 2.0));
	var[14][1] = (vec3(-9.0, 5.0, -6.0));
	var[14][2] = (vec3(5.0, -7.0, -9.0));
	var[14][3] = (vec3(0.0, 9.0, 9.0));
	var[15][0] = (vec3(-9.0, 5.0, 5.0));
	var[15][1] = (vec3(-2.0, 7.0, 7.0));
	var[15][2] = (vec3(-2.0, 7.0, -9.0));
	var[15][3] = (vec3(5.0, 5.0, -4.0));
	var[16][0] = (vec3(6.0, -3.0, 7.0));
	var[16][1] = (vec3(-3.0, 1.0, -7.0));
	var[16][2] = (vec3(-1.0, 0.0, -9.0));
	var[16][3] = (vec3(0.0, -4.0, 9.0));
	var[17][0] = (vec3(-6.0, -5.0, 7.0));
	var[17][1] = (vec3(6.0, 1.0, -2.0));
	var[17][2] = (vec3(2.0, 8.0, 9.0));
	var[17][3] = (vec3(2.0, -8.0, -9.0));
	var[18][0] = (vec3(-1.0, -5.0, 2.0));
	var[18][1] = (vec3(4.0, 7.0, -4.0));
	var[18][2] = (vec3(6.0, 2.0, -4.0));
	var[18][3] = (vec3(8.0, -8.0, -1.0));
}
#version 450
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
	allOk = compare_mat2x4(var[0][0], mat2x4(-7.0, 8.0, 3.0, -7.0, -7.0, -8.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[0][1], mat2x4(7.0, 3.0, -5.0, -7.0, 3.0, -9.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[0][2], mat2x4(3.0, 6.0, -4.0, 4.0, -2.0, 8.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[1][0], mat2x4(-8.0, -1.0, -1.0, -6.0, 2.0, -7.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[1][1], mat2x4(3.0, -9.0, 1.0, -9.0, 8.0, -7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[1][2], mat2x4(1.0, -1.0, 0.0, 7.0, 2.0, 5.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[2][0], mat2x4(2.0, 2.0, -8.0, 6.0, 0.0, -1.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[2][1], mat2x4(-4.0, -2.0, -4.0, -6.0, -3.0, -4.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[2][2], mat2x4(8.0, -7.0, 8.0, 8.0, 2.0, 3.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[3][0], mat2x4(9.0, 0.0, -4.0, -7.0, -7.0, 7.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[3][1], mat2x4(-3.0, -7.0, -5.0, -4.0, -1.0, -7.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[3][2], mat2x4(7.0, 0.0, -6.0, -2.0, 9.0, -7.0, -6.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat2x4(4.0, 9.0, 1.0, 2.0, 5.0, -4.0, -9.0, -9.0));
	var[0][1] = (mat2x4(5.0, -4.0, -4.0, 8.0, 5.0, -1.0, -3.0, -2.0));
	var[0][2] = (mat2x4(8.0, 2.0, 5.0, 4.0, 3.0, 1.0, -6.0, 2.0));
	var[1][0] = (mat2x4(-3.0, 4.0, 7.0, -8.0, -6.0, -3.0, -2.0, -9.0));
	var[1][1] = (mat2x4(-6.0, 7.0, 6.0, -2.0, 2.0, 7.0, 4.0, -7.0));
	var[1][2] = (mat2x4(-8.0, 4.0, 3.0, -6.0, -9.0, -3.0, 5.0, -6.0));
	var[2][0] = (mat2x4(-5.0, 8.0, 2.0, 0.0, -9.0, 1.0, -2.0, -6.0));
	var[2][1] = (mat2x4(0.0, 6.0, 7.0, -2.0, -1.0, -3.0, -3.0, -9.0));
	var[2][2] = (mat2x4(7.0, -5.0, 9.0, -1.0, -1.0, 9.0, 0.0, 7.0));
	var[3][0] = (mat2x4(6.0, -8.0, -2.0, 3.0, 1.0, -8.0, -4.0, -9.0));
	var[3][1] = (mat2x4(-7.0, 0.0, -8.0, -1.0, 5.0, 7.0, 7.0, -3.0));
	var[3][2] = (mat2x4(1.0, -9.0, 2.0, -9.0, -3.0, 0.0, -4.0, 5.0));
}
#version 450
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
	u16vec3 var[4][3];
};

bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(var[0][0]), uvec3(1u, 0u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[0][1]), uvec3(9u, 0u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[0][2]), uvec3(7u, 1u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1][0]), uvec3(0u, 4u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1][1]), uvec3(9u, 7u, 2u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1][2]), uvec3(1u, 0u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2][0]), uvec3(6u, 8u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2][1]), uvec3(5u, 6u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2][2]), uvec3(3u, 3u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[3][0]), uvec3(1u, 0u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[3][1]), uvec3(1u, 3u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[3][2]), uvec3(3u, 6u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = u16vec3(uvec3(1u, 2u, 6u));
	var[0][1] = u16vec3(uvec3(8u, 3u, 3u));
	var[0][2] = u16vec3(uvec3(4u, 4u, 9u));
	var[1][0] = u16vec3(uvec3(7u, 5u, 4u));
	var[1][1] = u16vec3(uvec3(5u, 6u, 5u));
	var[1][2] = u16vec3(uvec3(7u, 0u, 6u));
	var[2][0] = u16vec3(uvec3(4u, 7u, 0u));
	var[2][1] = u16vec3(uvec3(4u, 2u, 1u));
	var[2][2] = u16vec3(uvec3(0u, 2u, 8u));
	var[3][0] = u16vec3(uvec3(0u, 7u, 0u));
	var[3][1] = u16vec3(uvec3(2u, 8u, 7u));
	var[3][2] = u16vec3(uvec3(1u, 2u, 8u));
}
#version 450
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
	i16vec4 var[4][3];
};

bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(var[0][0]), ivec4(-6, -9, 9, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(var[0][1]), ivec4(-1, -8, 8, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(var[0][2]), ivec4(3, 4, 0, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][0]), ivec4(-2, -4, -9, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][1]), ivec4(4, -1, 4, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][2]), ivec4(6, 7, -4, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][0]), ivec4(-2, 9, 9, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][1]), ivec4(-3, -8, -7, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][2]), ivec4(7, -2, -8, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[3][0]), ivec4(1, 6, 9, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(var[3][1]), ivec4(1, -3, 9, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[3][2]), ivec4(4, 8, -6, -2)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = i16vec4(ivec4(-4, -8, -4, 9));
	var[0][1] = i16vec4(ivec4(2, 7, -4, 4));
	var[0][2] = i16vec4(ivec4(8, 9, 5, 1));
	var[1][0] = i16vec4(ivec4(-3, 3, 8, 7));
	var[1][1] = i16vec4(ivec4(2, 6, -9, 9));
	var[1][2] = i16vec4(ivec4(-2, 4, -8, -7));
	var[2][0] = i16vec4(ivec4(-9, -1, -8, -1));
	var[2][1] = i16vec4(ivec4(-1, -6, 5, 2));
	var[2][2] = i16vec4(ivec4(-3, 8, -7, -2));
	var[3][0] = i16vec4(ivec4(9, 7, 6, -9));
	var[3][1] = i16vec4(ivec4(5, -3, 8, 5));
	var[3][2] = i16vec4(ivec4(-6, -9, -6, 2));
}
#version 450
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
	highp mat4x2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0][0], mat4x2(-5.0, -2.0, -4.0, 7.0, -9.0, -9.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[0][1], mat4x2(-6.0, -1.0, -5.0, -9.0, -2.0, -2.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[0][2], mat4x2(-3.0, -8.0, -8.0, 1.0, 3.0, 0.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[1][0], mat4x2(0.0, -7.0, -1.0, 4.0, -3.0, -1.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[1][1], mat4x2(0.0, 8.0, -9.0, -4.0, 3.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[1][2], mat4x2(-8.0, -6.0, 1.0, -7.0, 1.0, -4.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[2][0], mat4x2(4.0, -8.0, 7.0, 0.0, 5.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[2][1], mat4x2(-9.0, -5.0, -3.0, 3.0, -3.0, 8.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[2][2], mat4x2(-2.0, 0.0, 3.0, 5.0, 9.0, -9.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[3][0], mat4x2(9.0, -1.0, 3.0, 6.0, 8.0, -8.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[3][1], mat4x2(-3.0, -9.0, -2.0, 8.0, -2.0, 7.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[3][2], mat4x2(-5.0, 8.0, -6.0, -6.0, -3.0, -1.0, -8.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat4x2(0.0, -3.0, -2.0, 2.0, -2.0, -3.0, 5.0, -5.0));
	var[0][1] = (mat4x2(5.0, -6.0, -4.0, -1.0, 4.0, 7.0, -8.0, -2.0));
	var[0][2] = (mat4x2(-5.0, -1.0, -3.0, 6.0, -2.0, 0.0, -7.0, -7.0));
	var[1][0] = (mat4x2(2.0, 0.0, -6.0, 9.0, 1.0, -7.0, 4.0, -6.0));
	var[1][1] = (mat4x2(5.0, -4.0, -3.0, 8.0, -6.0, -1.0, -6.0, 7.0));
	var[1][2] = (mat4x2(4.0, 7.0, -6.0, 5.0, -4.0, -7.0, 2.0, 1.0));
	var[2][0] = (mat4x2(6.0, -3.0, -5.0, -7.0, -7.0, 4.0, -9.0, 7.0));
	var[2][1] = (mat4x2(2.0, 2.0, 9.0, 3.0, -1.0, -8.0, 1.0, -5.0));
	var[2][2] = (mat4x2(6.0, 2.0, -6.0, 4.0, -3.0, -6.0, -7.0, -8.0));
	var[3][0] = (mat4x2(-1.0, -4.0, -5.0, 2.0, -7.0, -1.0, 7.0, 1.0));
	var[3][1] = (mat4x2(9.0, -3.0, -8.0, 4.0, 5.0, -9.0, 9.0, -3.0));
	var[3][2] = (mat4x2(5.0, 6.0, -5.0, 1.0, 0.0, 8.0, -9.0, -4.0));
}
#version 450
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
	highp mat4x3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0][0], mat4x3(5.0, 0.0, 3.0, -5.0, 9.0, -6.0, 8.0, -6.0, 6.0, 2.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[0][1], mat4x3(1.0, 7.0, 3.0, 4.0, 6.0, 2.0, -7.0, -9.0, -6.0, 1.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[0][2], mat4x3(4.0, -7.0, -2.0, 5.0, -7.0, 6.0, 7.0, 1.0, -4.0, -7.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[1][0], mat4x3(8.0, 0.0, -3.0, -3.0, 9.0, 2.0, -6.0, 4.0, 1.0, -1.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[1][1], mat4x3(7.0, -3.0, -4.0, 9.0, 3.0, 6.0, -1.0, -1.0, 6.0, -7.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[1][2], mat4x3(7.0, -9.0, -5.0, 9.0, 7.0, -1.0, -2.0, 7.0, -2.0, 0.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[2][0], mat4x3(-6.0, 1.0, 5.0, 9.0, -2.0, 8.0, 4.0, 6.0, -1.0, -2.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[2][1], mat4x3(5.0, -5.0, -3.0, 4.0, -3.0, -5.0, 8.0, 4.0, -8.0, -2.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[2][2], mat4x3(-6.0, -4.0, 6.0, -4.0, -8.0, 2.0, 3.0, -2.0, 0.0, -4.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[3][0], mat4x3(7.0, 4.0, -7.0, 3.0, 5.0, 4.0, 0.0, -1.0, 2.0, 6.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[3][1], mat4x3(-8.0, -7.0, -4.0, 9.0, 4.0, -9.0, -4.0, 2.0, -6.0, -4.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[3][2], mat4x3(-2.0, 3.0, 5.0, 2.0, -4.0, -5.0, -2.0, 4.0, 4.0, -3.0, 5.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat4x3(6.0, -7.0, 0.0, 3.0, -1.0, -9.0, -7.0, -5.0, 8.0, 0.0, 1.0, 5.0));
	var[0][1] = (mat4x3(7.0, 1.0, 5.0, 7.0, -8.0, 4.0, 2.0, -8.0, -8.0, 3.0, -6.0, -5.0));
	var[0][2] = (mat4x3(5.0, -7.0, 8.0, -7.0, -3.0, -4.0, -9.0, -9.0, -6.0, 5.0, -8.0, 1.0));
	var[1][0] = (mat4x3(-2.0, 3.0, -2.0, -9.0, 2.0, 9.0, -2.0, 8.0, -8.0, -8.0, -7.0, -5.0));
	var[1][1] = (mat4x3(7.0, -4.0, -6.0, -5.0, 0.0, 0.0, -6.0, -5.0, 1.0, 9.0, -4.0, -9.0));
	var[1][2] = (mat4x3(-5.0, 7.0, 2.0, 6.0, -1.0, -7.0, -9.0, -4.0, 5.0, -4.0, -3.0, 3.0));
	var[2][0] = (mat4x3(-6.0, 0.0, 1.0, -1.0, 4.0, 2.0, 0.0, -8.0, 7.0, -3.0, 1.0, -7.0));
	var[2][1] = (mat4x3(3.0, 8.0, 6.0, 5.0, 6.0, -2.0, -7.0, -5.0, 0.0, -4.0, -8.0, 5.0));
	var[2][2] = (mat4x3(3.0, -9.0, -8.0, -7.0, 3.0, 3.0, 3.0, -7.0, -5.0, -9.0, -1.0, -8.0));
	var[3][0] = (mat4x3(6.0, -5.0, 6.0, -8.0, -2.0, -6.0, 9.0, 0.0, 8.0, -9.0, -7.0, 1.0));
	var[3][1] = (mat4x3(8.0, -5.0, 0.0, -7.0, -6.0, 2.0, 0.0, -8.0, 1.0, -5.0, -9.0, -2.0));
	var[3][2] = (mat4x3(1.0, 0.0, 8.0, -8.0, 6.0, 7.0, 6.0, 2.0, 0.0, 3.0, -4.0, -6.0));
}
#version 450
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
	u16vec2 var[4][3];
};

bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(var[0][0]), uvec2(8u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[0][1]), uvec2(2u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[0][2]), uvec2(6u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][0]), uvec2(7u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][1]), uvec2(0u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][2]), uvec2(1u, 3u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][0]), uvec2(8u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][1]), uvec2(7u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][2]), uvec2(2u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[3][0]), uvec2(5u, 5u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[3][1]), uvec2(4u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[3][2]), uvec2(6u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = u16vec2(uvec2(8u, 0u));
	var[0][1] = u16vec2(uvec2(6u, 0u));
	var[0][2] = u16vec2(uvec2(6u, 9u));
	var[1][0] = u16vec2(uvec2(3u, 2u));
	var[1][1] = u16vec2(uvec2(9u, 2u));
	var[1][2] = u16vec2(uvec2(4u, 5u));
	var[2][0] = u16vec2(uvec2(1u, 1u));
	var[2][1] = u16vec2(uvec2(2u, 8u));
	var[2][2] = u16vec2(uvec2(1u, 5u));
	var[3][0] = u16vec2(uvec2(0u, 2u));
	var[3][1] = u16vec2(uvec2(3u, 8u));
	var[3][2] = u16vec2(uvec2(1u, 8u));
}
#version 450
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
	highp mat3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat3(var[0][0], mat3(-9.0, 7.0, 0.0, -1.0, -8.0, 0.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3(var[0][1], mat3(8.0, -4.0, -1.0, 5.0, -5.0, -9.0, -6.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat3(var[0][2], mat3(-9.0, 4.0, 5.0, -4.0, -4.0, 6.0, 2.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat3(var[1][0], mat3(-8.0, 1.0, -2.0, 6.0, 7.0, 4.0, -7.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat3(var[1][1], mat3(-6.0, -4.0, -1.0, -5.0, 3.0, 3.0, -3.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat3(var[1][2], mat3(1.0, 6.0, -7.0, 4.0, -7.0, -8.0, -1.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat3(var[2][0], mat3(-3.0, 5.0, 3.0, -7.0, -5.0, 0.0, -3.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3(var[2][1], mat3(0.0, -4.0, 2.0, 4.0, -3.0, 6.0, 4.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat3(var[2][2], mat3(-2.0, 5.0, 9.0, 8.0, -3.0, -5.0, -5.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3(var[3][0], mat3(0.0, 8.0, -3.0, 5.0, -5.0, 0.0, 8.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat3(var[3][1], mat3(-3.0, -8.0, -6.0, -2.0, -4.0, -5.0, 3.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3(var[3][2], mat3(-1.0, 4.0, 7.0, -7.0, 4.0, -7.0, 2.0, 4.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (7.0);
	var[0][0] = (mat3(-8.0, -8.0, -4.0, -3.0, 5.0, -3.0, -3.0, -1.0, 5.0));
	var[0][1] = (mat3(1.0, -3.0, 9.0, 1.0, 5.0, 0.0, 5.0, -1.0, -7.0));
	var[0][2] = (mat3(4.0, 1.0, -6.0, 3.0, 6.0, 1.0, 9.0, 3.0, -9.0));
	var[1][0] = (mat3(3.0, -7.0, 6.0, -9.0, 3.0, -9.0, 3.0, -6.0, 4.0));
	var[1][1] = (mat3(7.0, -6.0, -7.0, 1.0, -3.0, -6.0, -2.0, 5.0, 7.0));
	var[1][2] = (mat3(-6.0, -2.0, -8.0, 7.0, 1.0, 3.0, 4.0, 0.0, 5.0));
	var[2][0] = (mat3(4.0, -6.0, -9.0, -4.0, 6.0, -1.0, 8.0, -6.0, -3.0));
	var[2][1] = (mat3(6.0, -9.0, 2.0, -5.0, 0.0, -7.0, -5.0, -3.0, -4.0));
	var[2][2] = (mat3(-4.0, 8.0, -8.0, -7.0, 7.0, -4.0, -7.0, 8.0, -8.0));
	var[3][0] = (mat3(-8.0, -8.0, 1.0, -5.0, -6.0, 8.0, -1.0, 2.0, -3.0));
	var[3][1] = (mat3(-8.0, 4.0, 8.0, -2.0, 3.0, -5.0, -9.0, -3.0, 3.0));
	var[3][2] = (mat3(-2.0, -2.0, -3.0, 9.0, -6.0, 3.0, 5.0, 5.0, -2.0));
}
#version 450
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
	highp mat3x4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -6.0) && allOk;
	allOk = compare_mat3x4(var[0][0], mat3x4(2.0, 7.0, -8.0, 9.0, -6.0, 1.0, 9.0, -9.0, 1.0, -3.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[0][1], mat3x4(-5.0, -5.0, 5.0, -5.0, -3.0, 2.0, 1.0, 2.0, 8.0, -3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[0][2], mat3x4(7.0, -5.0, 5.0, 6.0, -3.0, 8.0, -1.0, -1.0, -1.0, -9.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[1][0], mat3x4(2.0, 8.0, 7.0, 5.0, 9.0, -1.0, -1.0, -5.0, -3.0, 4.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[1][1], mat3x4(-6.0, -8.0, 7.0, 0.0, -7.0, -9.0, 1.0, 0.0, -4.0, -2.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[1][2], mat3x4(9.0, 6.0, 6.0, 5.0, -9.0, 3.0, -1.0, -1.0, 4.0, 8.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[2][0], mat3x4(6.0, -1.0, 0.0, 8.0, 9.0, 6.0, 2.0, 2.0, 5.0, -2.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[2][1], mat3x4(6.0, 8.0, 7.0, -7.0, 9.0, 5.0, 7.0, 1.0, 1.0, 4.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[2][2], mat3x4(9.0, -1.0, -4.0, 9.0, -9.0, 9.0, 3.0, -1.0, -5.0, 0.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3x4(var[3][0], mat3x4(0.0, -4.0, -5.0, -8.0, 9.0, 5.0, -7.0, 6.0, -6.0, -7.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[3][1], mat3x4(-3.0, -4.0, -7.0, 2.0, 4.0, 4.0, -8.0, 0.0, -9.0, -4.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[3][2], mat3x4(-2.0, 0.0, -8.0, -7.0, -1.0, -3.0, 0.0, 4.0, 9.0, 0.0, -7.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (0.0);
	var[0][0] = (mat3x4(0.0, -5.0, -3.0, -2.0, -8.0, -3.0, 0.0, -6.0, -6.0, 8.0, 5.0, 8.0));
	var[0][1] = (mat3x4(1.0, 7.0, 4.0, -7.0, -3.0, -4.0, 0.0, 6.0, 9.0, -2.0, 5.0, 8.0));
	var[0][2] = (mat3x4(-2.0, 7.0, 3.0, -8.0, -8.0, 5.0, -7.0, -9.0, 1.0, 9.0, -3.0, -9.0));
	var[1][0] = (mat3x4(4.0, -1.0, 0.0, 4.0, -3.0, -5.0, -7.0, 1.0, 2.0, -2.0, -6.0, 3.0));
	var[1][1] = (mat3x4(1.0, -1.0, -3.0, 5.0, 8.0, 1.0, 3.0, -9.0, 1.0, -2.0, 9.0, 1.0));
	var[1][2] = (mat3x4(5.0, 2.0, 4.0, 6.0, 3.0, 7.0, 0.0, 8.0, 8.0, -2.0, 7.0, -2.0));
	var[2][0] = (mat3x4(-7.0, -5.0, -7.0, -6.0, 8.0, 4.0, -6.0, 5.0, 6.0, -5.0, 8.0, -8.0));
	var[2][1] = (mat3x4(8.0, -7.0, -4.0, -6.0, -9.0, 3.0, -6.0, -1.0, -2.0, -2.0, 2.0, 6.0));
	var[2][2] = (mat3x4(-1.0, -9.0, -5.0, -4.0, 3.0, -7.0, 1.0, 2.0, 1.0, -1.0, 6.0, 5.0));
	var[3][0] = (mat3x4(5.0, -9.0, -4.0, 9.0, -4.0, 7.0, -6.0, 2.0, 1.0, -6.0, 1.0, -4.0));
	var[3][1] = (mat3x4(7.0, -5.0, 0.0, 4.0, 0.0, 0.0, 0.0, 4.0, 0.0, -1.0, -9.0, -1.0));
	var[3][2] = (mat3x4(3.0, -6.0, 6.0, 3.0, 8.0, 4.0, 4.0, 7.0, 8.0, 1.0, 7.0, -7.0));
}
#version 450
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

layout(std430, column_major, binding = 1) buffer Block
{
	highp mat4x3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0][0][0], mat4x3(-4.0, 6.0, 7.0, -6.0, 2.0, -5.0, 0.0, -2.0, 8.0, -7.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(-4.0, -5.0, -7.0, 0.0, -7.0, -8.0, -3.0, 1.0, 3.0, 7.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][2], mat4x3(-9.0, 5.0, 2.0, -9.0, 9.0, 2.0, 8.0, -7.0, -4.0, 8.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(3.0, -6.0, 9.0, 8.0, -1.0, 8.0, -4.0, 2.0, 6.0, -9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(5.0, -1.0, 4.0, 2.0, -4.0, -2.0, -1.0, -4.0, 5.0, 9.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][2], mat4x3(2.0, -6.0, -1.0, 6.0, 9.0, -3.0, -8.0, 7.0, -5.0, 0.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(-9.0, 3.0, 0.0, 1.0, -4.0, 8.0, 3.0, -7.0, 8.0, -3.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(9.0, -8.0, -2.0, 4.0, -2.0, -5.0, -8.0, -4.0, -1.0, -9.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][2], mat4x3(-3.0, -2.0, 9.0, -5.0, -8.0, 1.0, -7.0, 6.0, -4.0, -6.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(7.0, -5.0, -4.0, -3.0, 5.0, 8.0, 9.0, -5.0, -5.0, -3.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(9.0, -2.0, 0.0, 1.0, -8.0, -4.0, -9.0, 3.0, -1.0, 1.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][2], mat4x3(-5.0, 1.0, 6.0, 5.0, 6.0, -1.0, -1.0, 1.0, -6.0, -5.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(1.0, -2.0, 6.0, 7.0, -5.0, 9.0, -9.0, 6.0, -8.0, -3.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(5.0, -9.0, 6.0, 3.0, 3.0, 0.0, 0.0, -6.0, 9.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][2], mat4x3(-1.0, -2.0, 2.0, -7.0, -8.0, -5.0, 3.0, -4.0, 5.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(0.0, 1.0, 5.0, -8.0, -8.0, 0.0, -9.0, 5.0, 2.0, -6.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(5.0, -4.0, 3.0, -9.0, 3.0, 4.0, -2.0, 4.0, 4.0, 2.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][2], mat4x3(-2.0, 0.0, 6.0, 2.0, -9.0, 3.0, 3.0, -4.0, 5.0, -3.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][0], mat4x3(5.0, 4.0, 1.0, -4.0, -7.0, 2.0, 0.0, 9.0, 7.0, -2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][1], mat4x3(-1.0, 6.0, -7.0, -6.0, 3.0, -7.0, -6.0, 4.0, 7.0, 5.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][2], mat4x3(1.0, 6.0, 2.0, 0.0, -4.0, 0.0, 8.0, -8.0, 7.0, 6.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][0], mat4x3(8.0, -9.0, -9.0, -6.0, 7.0, -8.0, 3.0, 0.0, -3.0, 3.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][1], mat4x3(-6.0, 1.0, 6.0, -1.0, 3.0, -4.0, 7.0, -7.0, -6.0, -3.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][2], mat4x3(-8.0, -1.0, 9.0, -6.0, 8.0, -4.0, -1.0, 0.0, -5.0, 0.0, -6.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec3(-3.0, -6.0, 6.0));
	var[0][0][0][1] = (vec3(1.0, -4.0, -3.0));
	var[0][0][0][2] = (vec3(-3.0, 3.0, -2.0));
	var[0][0][0][3] = (vec3(-7.0, 1.0, -5.0));
	var[0][0][1][0] = (vec3(-1.0, -5.0, 7.0));
	var[0][0][1][1] = (vec3(1.0, -2.0, -4.0));
	var[0][0][1][2] = (vec3(-4.0, -6.0, 5.0));
	var[0][0][1][3] = (vec3(-2.0, 6.0, -9.0));
	var[0][0][2][0] = (vec3(5.0, -5.0, 7.0));
	var[0][0][2][1] = (vec3(-4.0, 8.0, -3.0));
	var[0][0][2][2] = (vec3(-2.0, 0.0, 8.0));
	var[0][0][2][3] = (vec3(-2.0, 6.0, -3.0));
	var[0][1][0][0] = (vec3(-5.0, -6.0, -3.0));
	var[0][1][0][1] = (vec3(-2.0, 5.0, 8.0));
	var[0][1][0][2] = (vec3(2.0, -9.0, 7.0));
	var[0][1][0][3] = (vec3(7.0, -3.0, 4.0));
	var[0][1][1][0] = (vec3(9.0, 4.0, 1.0));
	var[0][1][1][1] = (vec3(5.0, -9.0, 2.0));
	var[0][1][1][2] = (vec3(-7.0, -3.0, -9.0));
	var[0][1][1][3] = (vec3(9.0, -6.0, 3.0));
	var[0][1][2][0] = (vec3(-9.0, -4.0, 0.0));
	var[0][1][2][1] = (vec3(5.0, 8.0, 9.0));
	var[0][1][2][2] = (vec3(-7.0, -9.0, -5.0));
	var[0][1][2][3] = (vec3(0.0, -1.0, -6.0));
	var[1][0][0][0] = (vec3(-9.0, -2.0, -2.0));
	var[1][0][0][1] = (vec3(7.0, 9.0, -4.0));
	var[1][0][0][2] = (vec3(3.0, 1.0, 0.0));
	var[1][0][0][3] = (vec3(-9.0, -2.0, -7.0));
	var[1][0][1][0] = (vec3(-5.0, -6.0, 5.0));
	var[1][0][1][1] = (vec3(-2.0, -7.0, 5.0));
	var[1][0][1][2] = (vec3(-2.0, -6.0, 4.0));
	var[1][0][1][3] = (vec3(9.0, 5.0, -9.0));
	var[1][0][2][0] = (vec3(-3.0, 3.0, 7.0));
	var[1][0][2][1] = (vec3(3.0, -4.0, -8.0));
	var[1][0][2][2] = (vec3(-2.0, 2.0, -1.0));
	var[1][0][2][3] = (vec3(1.0, -9.0, 9.0));
	var[1][1][0][0] = (vec3(-9.0, -9.0, 9.0));
	var[1][1][0][1] = (vec3(9.0, -1.0, 8.0));
	var[1][1][0][2] = (vec3(8.0, -8.0, 4.0));
	var[1][1][0][3] = (vec3(9.0, -8.0, 8.0));
	var[1][1][1][0] = (vec3(4.0, 6.0, 1.0));
	var[1][1][1][1] = (vec3(-9.0, 7.0, 3.0));
	var[1][1][1][2] = (vec3(-4.0, -3.0, 8.0));
	var[1][1][1][3] = (vec3(-9.0, -9.0, 2.0));
	var[1][1][2][0] = (vec3(0.0, -2.0, 5.0));
	var[1][1][2][1] = (vec3(8.0, 4.0, -4.0));
	var[1][1][2][2] = (vec3(5.0, 4.0, -5.0));
	var[1][1][2][3] = (vec3(0.0, -3.0, 9.0));
	var[2][0][0][0] = (vec3(-7.0, -7.0, -7.0));
	var[2][0][0][1] = (vec3(6.0, -9.0, 3.0));
	var[2][0][0][2] = (vec3(-5.0, 2.0, 4.0));
	var[2][0][0][3] = (vec3(-2.0, -4.0, -6.0));
	var[2][0][1][0] = (vec3(-1.0, 5.0, 5.0));
	var[2][0][1][1] = (vec3(-9.0, -3.0, -9.0));
	var[2][0][1][2] = (vec3(3.0, 2.0, 0.0));
	var[2][0][1][3] = (vec3(0.0, -9.0, 7.0));
	var[2][0][2][0] = (vec3(5.0, -5.0, -2.0));
	var[2][0][2][1] = (vec3(6.0, 5.0, -4.0));
	var[2][0][2][2] = (vec3(-2.0, 9.0, -3.0));
	var[2][0][2][3] = (vec3(2.0, 5.0, -4.0));
	var[2][1][0][0] = (vec3(-4.0, -7.0, 3.0));
	var[2][1][0][1] = (vec3(6.0, 4.0, 1.0));
	var[2][1][0][2] = (vec3(-3.0, 3.0, 8.0));
	var[2][1][0][3] = (vec3(-6.0, 5.0, -6.0));
	var[2][1][1][0] = (vec3(3.0, 2.0, 3.0));
	var[2][1][1][1] = (vec3(1.0, -7.0, 3.0));
	var[2][1][1][2] = (vec3(6.0, -3.0, -2.0));
	var[2][1][1][3] = (vec3(3.0, 1.0, -1.0));
	var[2][1][2][0] = (vec3(0.0, 9.0, -4.0));
	var[2][1][2][1] = (vec3(6.0, -5.0, 0.0));
	var[2][1][2][2] = (vec3(-2.0, 4.0, 6.0));
	var[2][1][2][3] = (vec3(-5.0, 2.0, 4.0));
	var[3][0][0][0] = (vec3(6.0, 4.0, 7.0));
	var[3][0][0][1] = (vec3(1.0, -4.0, -6.0));
	var[3][0][0][2] = (vec3(4.0, -6.0, -5.0));
	var[3][0][0][3] = (vec3(5.0, 6.0, -1.0));
	var[3][0][1][0] = (vec3(6.0, 3.0, -9.0));
	var[3][0][1][1] = (vec3(-7.0, 3.0, -4.0));
	var[3][0][1][2] = (vec3(1.0, 2.0, 6.0));
	var[3][0][1][3] = (vec3(-2.0, 3.0, 7.0));
	var[3][0][2][0] = (vec3(-5.0, 8.0, -9.0));
	var[3][0][2][1] = (vec3(-4.0, -1.0, -9.0));
	var[3][0][2][2] = (vec3(5.0, 5.0, 6.0));
	var[3][0][2][3] = (vec3(-8.0, 1.0, -7.0));
	var[3][1][0][0] = (vec3(-4.0, -4.0, 0.0));
	var[3][1][0][1] = (vec3(-2.0, 5.0, 7.0));
	var[3][1][0][2] = (vec3(8.0, 8.0, -3.0));
	var[3][1][0][3] = (vec3(-9.0, -7.0, 5.0));
	var[3][1][1][0] = (vec3(6.0, -7.0, -2.0));
	var[3][1][1][1] = (vec3(0.0, 3.0, -5.0));
	var[3][1][1][2] = (vec3(-6.0, -7.0, -4.0));
	var[3][1][1][3] = (vec3(-8.0, 1.0, -7.0));
	var[3][1][2][0] = (vec3(2.0, -4.0, -7.0));
	var[3][1][2][1] = (vec3(-3.0, -4.0, 0.0));
	var[3][1][2][2] = (vec3(-8.0, -2.0, 6.0));
	var[3][1][2][3] = (vec3(-7.0, -7.0, 2.0));
}
#version 450
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
	i16vec4 var[4][2][3];
};

bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(var[0][0][0]), ivec4(-6, -9, 9, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(var[0][0][1]), ivec4(-1, -8, 8, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(var[0][0][2]), ivec4(3, 4, 0, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(var[0][1][0]), ivec4(3, -5, 9, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[0][1][1]), ivec4(6, 3, 6, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(var[0][1][2]), ivec4(9, -8, -9, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][0][0]), ivec4(-2, -4, -9, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][0][1]), ivec4(4, -1, 4, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][0][2]), ivec4(6, 7, -4, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][1][0]), ivec4(-9, -3, -3, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][1][1]), ivec4(-7, -4, 3, 0)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][1][2]), ivec4(-4, 5, -2, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][0][0]), ivec4(-2, 9, 9, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][0][1]), ivec4(-3, -8, -7, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][0][2]), ivec4(7, -2, -8, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][1][0]), ivec4(4, -6, 5, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][1][1]), ivec4(5, -2, 3, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][1][2]), ivec4(0, 5, -8, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(var[3][0][0]), ivec4(1, 6, 9, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(var[3][0][1]), ivec4(1, -3, 9, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[3][0][2]), ivec4(4, 8, -6, -2)) && allOk;
	allOk = compare_i16vec4(ivec4(var[3][1][0]), ivec4(-6, 7, 7, 2)) && allOk;
	allOk = compare_i16vec4(ivec4(var[3][1][1]), ivec4(-5, 7, 3, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(var[3][1][2]), ivec4(-4, 7, 8, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = i16vec4(ivec4(-4, -8, -4, 9));
	var[0][0][1] = i16vec4(ivec4(2, 7, -4, 4));
	var[0][0][2] = i16vec4(ivec4(8, 9, 5, 1));
	var[0][1][0] = i16vec4(ivec4(7, -1, 8, -5));
	var[0][1][1] = i16vec4(ivec4(-9, -6, -2, -2));
	var[0][1][2] = i16vec4(ivec4(-3, 8, 7, -4));
	var[1][0][0] = i16vec4(ivec4(-3, 3, 8, 7));
	var[1][0][1] = i16vec4(ivec4(2, 6, -9, 9));
	var[1][0][2] = i16vec4(ivec4(-2, 4, -8, -7));
	var[1][1][0] = i16vec4(ivec4(-2, 0, 6, -2));
	var[1][1][1] = i16vec4(ivec4(6, -5, -6, -3));
	var[1][1][2] = i16vec4(ivec4(4, -4, -4, 9));
	var[2][0][0] = i16vec4(ivec4(-9, -1, -8, -1));
	var[2][0][1] = i16vec4(ivec4(-1, -6, 5, 2));
	var[2][0][2] = i16vec4(ivec4(-3, 8, -7, -2));
	var[2][1][0] = i16vec4(ivec4(7, 6, 4, -1));
	var[2][1][1] = i16vec4(ivec4(8, 3, 4, 5));
	var[2][1][2] = i16vec4(ivec4(-3, 5, -8, -5));
	var[3][0][0] = i16vec4(ivec4(9, 7, 6, -9));
	var[3][0][1] = i16vec4(ivec4(5, -3, 8, 5));
	var[3][0][2] = i16vec4(ivec4(-6, -9, -6, 2));
	var[3][1][0] = i16vec4(ivec4(9, 3, -3, 9));
	var[3][1][1] = i16vec4(ivec4(1, -5, 8, -2));
	var[3][1][2] = i16vec4(ivec4(7, -6, -6, 0));
}
#version 450
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
	uint8_t padding;
	uint8_t var[4][2][3];
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(padding), 7u) && allOk;
	allOk = compare_uint8_t(uint(var[0][0][0]), 1u) && allOk;
	allOk = compare_uint8_t(uint(var[0][0][1]), 3u) && allOk;
	allOk = compare_uint8_t(uint(var[0][0][2]), 1u) && allOk;
	allOk = compare_uint8_t(uint(var[0][1][0]), 2u) && allOk;
	allOk = compare_uint8_t(uint(var[0][1][1]), 5u) && allOk;
	allOk = compare_uint8_t(uint(var[0][1][2]), 9u) && allOk;
	allOk = compare_uint8_t(uint(var[1][0][0]), 2u) && allOk;
	allOk = compare_uint8_t(uint(var[1][0][1]), 4u) && allOk;
	allOk = compare_uint8_t(uint(var[1][0][2]), 9u) && allOk;
	allOk = compare_uint8_t(uint(var[1][1][0]), 8u) && allOk;
	allOk = compare_uint8_t(uint(var[1][1][1]), 1u) && allOk;
	allOk = compare_uint8_t(uint(var[1][1][2]), 3u) && allOk;
	allOk = compare_uint8_t(uint(var[2][0][0]), 2u) && allOk;
	allOk = compare_uint8_t(uint(var[2][0][1]), 1u) && allOk;
	allOk = compare_uint8_t(uint(var[2][0][2]), 4u) && allOk;
	allOk = compare_uint8_t(uint(var[2][1][0]), 9u) && allOk;
	allOk = compare_uint8_t(uint(var[2][1][1]), 1u) && allOk;
	allOk = compare_uint8_t(uint(var[2][1][2]), 0u) && allOk;
	allOk = compare_uint8_t(uint(var[3][0][0]), 2u) && allOk;
	allOk = compare_uint8_t(uint(var[3][0][1]), 7u) && allOk;
	allOk = compare_uint8_t(uint(var[3][0][2]), 6u) && allOk;
	allOk = compare_uint8_t(uint(var[3][1][0]), 6u) && allOk;
	allOk = compare_uint8_t(uint(var[3][1][1]), 6u) && allOk;
	allOk = compare_uint8_t(uint(var[3][1][2]), 4u) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = uint8_t(9u);
	var[0][0][0] = uint8_t(5u);
	var[0][0][1] = uint8_t(2u);
	var[0][0][2] = uint8_t(6u);
	var[0][1][0] = uint8_t(0u);
	var[0][1][1] = uint8_t(5u);
	var[0][1][2] = uint8_t(4u);
	var[1][0][0] = uint8_t(7u);
	var[1][0][1] = uint8_t(5u);
	var[1][0][2] = uint8_t(8u);
	var[1][1][0] = uint8_t(1u);
	var[1][1][1] = uint8_t(3u);
	var[1][1][2] = uint8_t(0u);
	var[2][0][0] = uint8_t(4u);
	var[2][0][1] = uint8_t(2u);
	var[2][0][2] = uint8_t(6u);
	var[2][1][0] = uint8_t(3u);
	var[2][1][1] = uint8_t(3u);
	var[2][1][2] = uint8_t(3u);
	var[3][0][0] = uint8_t(0u);
	var[3][0][1] = uint8_t(1u);
	var[3][0][2] = uint8_t(6u);
	var[3][1][0] = uint8_t(3u);
	var[3][1][1] = uint8_t(3u);
	var[3][1][2] = uint8_t(9u);
}
#version 450
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
	highp mat3 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0][0][0], mat3(6.0, -4.0, 9.0, -9.0, 3.0, 9.0, 6.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(8.0, 5.0, -8.0, -6.0, -8.0, -7.0, -4.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(-2.0, -1.0, -3.0, 3.0, -5.0, -1.0, 1.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(-4.0, 9.0, 6.0, -9.0, 2.0, 8.0, -5.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3(var[0][2][0], mat3(1.0, 8.0, -5.0, -5.0, -8.0, -4.0, -7.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(var[0][2][1], mat3(-5.0, -8.0, 6.0, 4.0, -3.0, 9.0, -2.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3(var[0][3][0], mat3(2.0, -4.0, -2.0, -7.0, 2.0, -2.0, 9.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3(var[0][3][1], mat3(3.0, -2.0, 5.0, -3.0, 7.0, -5.0, 2.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(-4.0, -2.0, -2.0, -8.0, -8.0, -5.0, -4.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(3.0, 7.0, 0.0, 6.0, 5.0, 0.0, -5.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(6.0, -4.0, -2.0, 3.0, 0.0, -7.0, -5.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(0.0, 5.0, 6.0, -6.0, -7.0, 9.0, 0.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3(var[1][2][0], mat3(-2.0, 7.0, -4.0, 4.0, -4.0, 1.0, 6.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat3(var[1][2][1], mat3(2.0, -6.0, 4.0, -6.0, 8.0, 1.0, -7.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3(var[1][3][0], mat3(2.0, 2.0, 8.0, -3.0, -7.0, -9.0, -7.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat3(var[1][3][1], mat3(-6.0, 7.0, -4.0, 4.0, 5.0, 3.0, 0.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(4.0, 9.0, 9.0, -6.0, 9.0, -6.0, 9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(-9.0, -9.0, -2.0, -6.0, 7.0, 7.0, 8.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(-3.0, -7.0, -7.0, -5.0, 8.0, 3.0, 7.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(8.0, 4.0, -6.0, 0.0, 6.0, 5.0, -3.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3(var[2][2][0], mat3(6.0, 5.0, 5.0, -1.0, -9.0, -7.0, 7.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3(var[2][2][1], mat3(0.0, -7.0, 0.0, -4.0, 1.0, -7.0, 1.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat3(var[2][3][0], mat3(5.0, -9.0, 6.0, -4.0, -2.0, -4.0, 3.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3(var[2][3][1], mat3(0.0, -9.0, 2.0, -6.0, 6.0, 7.0, 8.0, -2.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec3(2.0, -4.0, 9.0));
	var[0][0][0][1] = (vec3(-4.0, 2.0, 5.0));
	var[0][0][0][2] = (vec3(5.0, -9.0, -5.0));
	var[0][0][1][0] = (vec3(3.0, 1.0, 8.0));
	var[0][0][1][1] = (vec3(6.0, 9.0, -8.0));
	var[0][0][1][2] = (vec3(-1.0, 5.0, 1.0));
	var[0][1][0][0] = (vec3(9.0, -3.0, -9.0));
	var[0][1][0][1] = (vec3(6.0, -1.0, -6.0));
	var[0][1][0][2] = (vec3(6.0, 2.0, -5.0));
	var[0][1][1][0] = (vec3(-1.0, -2.0, 2.0));
	var[0][1][1][1] = (vec3(9.0, 1.0, -8.0));
	var[0][1][1][2] = (vec3(6.0, -1.0, 7.0));
	var[0][2][0][0] = (vec3(-9.0, -8.0, 2.0));
	var[0][2][0][1] = (vec3(-6.0, 9.0, -7.0));
	var[0][2][0][2] = (vec3(9.0, 6.0, 1.0));
	var[0][2][1][0] = (vec3(-4.0, 8.0, -7.0));
	var[0][2][1][1] = (vec3(1.0, 0.0, 4.0));
	var[0][2][1][2] = (vec3(-6.0, -3.0, 3.0));
	var[0][3][0][0] = (vec3(-5.0, 7.0, 5.0));
	var[0][3][0][1] = (vec3(-2.0, -2.0, 8.0));
	var[0][3][0][2] = (vec3(-3.0, 1.0, 7.0));
	var[0][3][1][0] = (vec3(-9.0, 8.0, 7.0));
	var[0][3][1][1] = (vec3(2.0, 2.0, -5.0));
	var[0][3][1][2] = (vec3(-8.0, -5.0, 6.0));
	var[1][0][0][0] = (vec3(6.0, -5.0, -4.0));
	var[1][0][0][1] = (vec3(-8.0, -8.0, -2.0));
	var[1][0][0][2] = (vec3(9.0, -4.0, 4.0));
	var[1][0][1][0] = (vec3(4.0, -1.0, 5.0));
	var[1][0][1][1] = (vec3(-1.0, 0.0, 9.0));
	var[1][0][1][2] = (vec3(7.0, 7.0, 5.0));
	var[1][1][0][0] = (vec3(4.0, 2.0, -8.0));
	var[1][1][0][1] = (vec3(0.0, 3.0, 9.0));
	var[1][1][0][2] = (vec3(9.0, -8.0, -4.0));
	var[1][1][1][0] = (vec3(-8.0, 3.0, 4.0));
	var[1][1][1][1] = (vec3(-4.0, 4.0, 1.0));
	var[1][1][1][2] = (vec3(0.0, 4.0, 5.0));
	var[1][2][0][0] = (vec3(-5.0, -6.0, 5.0));
	var[1][2][0][1] = (vec3(4.0, 3.0, -2.0));
	var[1][2][0][2] = (vec3(-6.0, -4.0, -1.0));
	var[1][2][1][0] = (vec3(4.0, 4.0, -6.0));
	var[1][2][1][1] = (vec3(0.0, 2.0, -5.0));
	var[1][2][1][2] = (vec3(5.0, 8.0, -2.0));
	var[1][3][0][0] = (vec3(4.0, 1.0, 9.0));
	var[1][3][0][1] = (vec3(5.0, -6.0, 7.0));
	var[1][3][0][2] = (vec3(-7.0, -2.0, -6.0));
	var[1][3][1][0] = (vec3(0.0, -9.0, 7.0));
	var[1][3][1][1] = (vec3(-2.0, 0.0, 5.0));
	var[1][3][1][2] = (vec3(8.0, 8.0, -1.0));
	var[2][0][0][0] = (vec3(8.0, -6.0, -1.0));
	var[2][0][0][1] = (vec3(-1.0, -2.0, -5.0));
	var[2][0][0][2] = (vec3(-5.0, 6.0, -3.0));
	var[2][0][1][0] = (vec3(-4.0, -6.0, 2.0));
	var[2][0][1][1] = (vec3(3.0, -1.0, 2.0));
	var[2][0][1][2] = (vec3(-3.0, 4.0, 1.0));
	var[2][1][0][0] = (vec3(-9.0, -4.0, 2.0));
	var[2][1][0][1] = (vec3(-6.0, 8.0, 3.0));
	var[2][1][0][2] = (vec3(2.0, 0.0, -1.0));
	var[2][1][1][0] = (vec3(7.0, 1.0, 3.0));
	var[2][1][1][1] = (vec3(5.0, 1.0, -6.0));
	var[2][1][1][2] = (vec3(2.0, -5.0, 4.0));
	var[2][2][0][0] = (vec3(3.0, -1.0, 7.0));
	var[2][2][0][1] = (vec3(-9.0, -9.0, -8.0));
	var[2][2][0][2] = (vec3(9.0, -9.0, -5.0));
	var[2][2][1][0] = (vec3(1.0, -2.0, 1.0));
	var[2][2][1][1] = (vec3(-8.0, -4.0, -3.0));
	var[2][2][1][2] = (vec3(3.0, -4.0, -3.0));
	var[2][3][0][0] = (vec3(-4.0, 3.0, 5.0));
	var[2][3][0][1] = (vec3(-9.0, 8.0, -7.0));
	var[2][3][0][2] = (vec3(7.0, -3.0, 4.0));
	var[2][3][1][0] = (vec3(-6.0, 3.0, 6.0));
	var[2][3][1][1] = (vec3(-9.0, 9.0, 3.0));
	var[2][3][1][2] = (vec3(8.0, 8.0, -2.0));
}
#version 450
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
	highp mat2x4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0][0][0], mat2x4(-5.0, 8.0, 6.0, -5.0, -7.0, -1.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(5.0, -3.0, -3.0, 3.0, 9.0, 3.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(-6.0, -5.0, 3.0, -6.0, -6.0, -6.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(-1.0, -4.0, -7.0, -1.0, -6.0, -5.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[0][2][0], mat2x4(-9.0, 2.0, -4.0, -7.0, -8.0, -5.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[0][2][1], mat2x4(0.0, 5.0, 4.0, -5.0, 1.0, -3.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[0][3][0], mat2x4(4.0, -5.0, -6.0, -5.0, 5.0, 1.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[0][3][1], mat2x4(6.0, -6.0, -1.0, -2.0, -4.0, 3.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(9.0, -8.0, 9.0, -7.0, 5.0, -2.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(6.0, -7.0, -9.0, 1.0, -3.0, -5.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(8.0, 9.0, 3.0, 4.0, -2.0, 8.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(1.0, 1.0, 5.0, -9.0, 7.0, 2.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[1][2][0], mat2x4(-2.0, -8.0, -5.0, -3.0, -6.0, -1.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[1][2][1], mat2x4(2.0, -8.0, -6.0, -8.0, 7.0, 8.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[1][3][0], mat2x4(-1.0, 6.0, -6.0, 3.0, -7.0, -1.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[1][3][1], mat2x4(-8.0, -4.0, -7.0, -3.0, -8.0, -2.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(7.0, 0.0, 8.0, -4.0, -8.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(5.0, -8.0, -2.0, 1.0, -7.0, 7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(-2.0, 0.0, -8.0, 8.0, 2.0, 9.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(8.0, 3.0, -8.0, 0.0, -3.0, -4.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[2][2][0], mat2x4(4.0, 5.0, 0.0, 5.0, -4.0, -9.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[2][2][1], mat2x4(-9.0, 3.0, -9.0, 0.0, 2.0, -8.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[2][3][0], mat2x4(0.0, 8.0, 9.0, -5.0, -4.0, -9.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[2][3][1], mat2x4(9.0, -2.0, -5.0, 3.0, 7.0, -8.0, -6.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2x4(1.0, 9.0, -7.0, -1.0, 7.0, -5.0, 3.0, -4.0));
	var[0][0][1] = (mat2x4(-1.0, -4.0, -6.0, -7.0, 3.0, 5.0, 1.0, -1.0));
	var[0][1][0] = (mat2x4(4.0, -7.0, 8.0, 0.0, 4.0, 0.0, -9.0, 2.0));
	var[0][1][1] = (mat2x4(-2.0, 1.0, -6.0, -9.0, -2.0, -7.0, 1.0, -5.0));
	var[0][2][0] = (mat2x4(7.0, -5.0, -6.0, -8.0, -5.0, 3.0, -4.0, -5.0));
	var[0][2][1] = (mat2x4(-3.0, -5.0, 7.0, -7.0, 7.0, 8.0, 6.0, 7.0));
	var[0][3][0] = (mat2x4(-7.0, -3.0, -2.0, -2.0, -6.0, -7.0, 1.0, 6.0));
	var[0][3][1] = (mat2x4(0.0, 7.0, 8.0, 8.0, 2.0, -2.0, 6.0, -8.0));
	var[1][0][0] = (mat2x4(9.0, -9.0, -3.0, -7.0, 3.0, 9.0, -5.0, -9.0));
	var[1][0][1] = (mat2x4(-7.0, -4.0, -2.0, -7.0, -9.0, 1.0, -6.0, 2.0));
	var[1][1][0] = (mat2x4(-8.0, 7.0, 1.0, 7.0, -3.0, -1.0, 5.0, -8.0));
	var[1][1][1] = (mat2x4(2.0, 9.0, -6.0, 0.0, 1.0, -7.0, -8.0, 5.0));
	var[1][2][0] = (mat2x4(-8.0, 2.0, 0.0, 3.0, 7.0, 9.0, 3.0, 0.0));
	var[1][2][1] = (mat2x4(-9.0, 1.0, -3.0, 3.0, 2.0, 9.0, -5.0, 3.0));
	var[1][3][0] = (mat2x4(5.0, -2.0, 5.0, -9.0, -1.0, 4.0, 6.0, 1.0));
	var[1][3][1] = (mat2x4(6.0, -8.0, 1.0, -8.0, -1.0, 0.0, -1.0, 9.0));
	var[2][0][0] = (mat2x4(0.0, -4.0, -2.0, 7.0, 9.0, -5.0, -2.0, -7.0));
	var[2][0][1] = (mat2x4(3.0, -8.0, 1.0, 7.0, 5.0, -5.0, 7.0, -9.0));
	var[2][1][0] = (mat2x4(5.0, -9.0, 9.0, 8.0, -3.0, -6.0, 3.0, 4.0));
	var[2][1][1] = (mat2x4(-6.0, -9.0, 2.0, 9.0, -2.0, 3.0, 6.0, 5.0));
	var[2][2][0] = (mat2x4(4.0, 1.0, 6.0, 5.0, 6.0, -8.0, 9.0, -8.0));
	var[2][2][1] = (mat2x4(-6.0, -7.0, 0.0, -1.0, -3.0, -5.0, -4.0, 3.0));
	var[2][3][0] = (mat2x4(-7.0, 0.0, 8.0, 0.0, -6.0, 3.0, -9.0, -7.0));
	var[2][3][1] = (mat2x4(0.0, 2.0, -7.0, -2.0, -3.0, 9.0, 7.0, 7.0));
}
#version 450
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

struct S
{
	highp ivec3 a;
	mediump mat3 b[4];
	highp vec4 c;
};
layout(std430, binding = 1) buffer Block
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
	allOk = compare_ivec3((block[0].s.a), ivec3(-2, 8, 0)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(-9.0, -5.0, 4.0, -2.0, -7.0, 9.0, -8.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(-2.0, -6.0, 3.0, -7.0, -5.0, 8.0, -7.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(5.0, 0.0, 0.0, -6.0, 7.0, 3.0, 1.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(-4.0, -8.0, 7.0, 8.0, 3.0, 9.0, 8.0, 6.0, -9.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(7.0, 8.0, 9.0, -3.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(5, -7, 2)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(8.0, -1.0, 6.0, 0.0, 4.0, 9.0, 0.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(-1.0, 8.0, 4.0, -3.0, -6.0, 6.0, 0.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(-8.0, -7.0, -4.0, 6.0, -5.0, 6.0, 9.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(-3.0, -8.0, -6.0, -4.0, -2.0, 6.0, -7.0, -5.0, 6.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(6.0, 3.0, -7.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(2, 5, 9)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(-1.0, -4.0, 3.0, 9.0, 3.0, -6.0, 0.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(2.0, 5.0, -5.0, -5.0, 5.0, 2.0, -2.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(-2.0, -4.0, 5.0, 2.0, 1.0, -6.0, 7.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(7.0, 0.0, -7.0, 7.0, -1.0, 1.0, -4.0, -2.0, 3.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(6.0, 9.0, -3.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (ivec3(1, -5, 3));
	block[0].s.b[0] = (mat3(4.0, 8.0, -9.0, -3.0, -2.0, -7.0, 1.0, -3.0, -8.0));
	block[0].s.b[1] = (mat3(9.0, 5.0, 0.0, -1.0, 6.0, 9.0, -7.0, -2.0, 1.0));
	block[0].s.b[2] = (mat3(-6.0, -5.0, 3.0, 8.0, -6.0, 6.0, 1.0, -8.0, 5.0));
	block[0].s.b[3] = (mat3(-6.0, -4.0, 9.0, 4.0, 0.0, 5.0, 3.0, -9.0, -6.0));
	block[0].s.c = (vec4(-3.0, -3.0, -9.0, 6.0));
	block[1].s.a = (ivec3(-5, -7, 6));
	block[1].s.b[0] = (mat3(3.0, 4.0, 6.0, 7.0, 8.0, 5.0, 1.0, 2.0, 4.0));
	block[1].s.b[1] = (mat3(-6.0, -7.0, -6.0, -2.0, 9.0, 0.0, -6.0, -7.0, 7.0));
	block[1].s.b[2] = (mat3(-5.0, 5.0, 9.0, 7.0, -2.0, -9.0, -2.0, 6.0, 8.0));
	block[1].s.b[3] = (mat3(1.0, -5.0, -4.0, 0.0, 2.0, -1.0, 1.0, 5.0, 2.0));
	block[1].s.c = (vec4(4.0, 5.0, 8.0, 6.0));
	block[2].s.a = (ivec3(7, 9, -1));
	block[2].s.b[0] = (mat3(5.0, 5.0, -6.0, -7.0, -4.0, 2.0, -1.0, 5.0, -3.0));
	block[2].s.b[1] = (mat3(3.0, 4.0, 0.0, 3.0, -5.0, 0.0, -7.0, 1.0, -7.0));
	block[2].s.b[2] = (mat3(-8.0, -3.0, 0.0, 7.0, 9.0, 9.0, 1.0, -4.0, 2.0));
	block[2].s.b[3] = (mat3(4.0, -1.0, -6.0, 3.0, 6.0, -1.0, 6.0, 6.0, -7.0));
	block[2].s.c = (vec4(7.0, 2.0, -2.0, -8.0));
}
#version 450
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
	lowp uint u;
	S s[3];
	mediump vec4 v;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((block[0].s[0].a), ivec3(2, 6, -5)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[0], mat3(7.0, 1.0, 4.0, -1.0, -5.0, -7.0, 6.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[1], mat3(-5.0, 0.0, -5.0, -7.0, -8.0, -5.0, -6.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[2], mat3(2.0, 2.0, -7.0, 1.0, -6.0, -8.0, -2.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[3], mat3(6.0, -5.0, -3.0, -7.0, 9.0, -5.0, -7.0, 9.0, -1.0)) && allOk;
	allOk = compare_vec4((block[0].s[0].c), vec4(6.0, 0.0, 7.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1].a), ivec3(4, -2, -6)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[0], mat3(-9.0, 9.0, 4.0, -3.0, 2.0, 9.0, 4.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[1], mat3(-2.0, 3.0, -2.0, 5.0, -2.0, 8.0, 8.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[2], mat3(9.0, 2.0, 0.0, 2.0, -4.0, 3.0, -5.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[3], mat3(6.0, 7.0, 9.0, -4.0, -5.0, 7.0, 0.0, -6.0, 3.0)) && allOk;
	allOk = compare_vec4((block[0].s[1].c), vec4(9.0, 3.0, 5.0, -3.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2].a), ivec3(-7, 7, 9)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[0], mat3(9.0, -1.0, 4.0, -5.0, 1.0, -5.0, -7.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[1], mat3(0.0, 4.0, -3.0, 1.0, -6.0, 8.0, -8.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[2], mat3(-4.0, -2.0, 4.0, 1.0, -8.0, -1.0, -9.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[3], mat3(-5.0, -6.0, 8.0, 1.0, -8.0, 8.0, -4.0, -6.0, -3.0)) && allOk;
	allOk = compare_vec4((block[0].s[2].c), vec4(-2.0, 1.0, 6.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0].a), ivec3(8, 6, -6)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[0], mat3(-3.0, 9.0, -9.0, 2.0, 7.0, 0.0, -5.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[1], mat3(-4.0, 8.0, 8.0, -3.0, -9.0, -7.0, -3.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[2], mat3(-4.0, 4.0, 8.0, 5.0, -3.0, -4.0, 4.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[3], mat3(-3.0, 4.0, 9.0, 2.0, -6.0, -6.0, 0.0, -5.0, 6.0)) && allOk;
	allOk = compare_vec4((block[1].s[0].c), vec4(8.0, -7.0, -5.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1].a), ivec3(7, 4, -7)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[0], mat3(8.0, 2.0, 7.0, 8.0, -3.0, -5.0, -3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[1], mat3(-7.0, 4.0, 4.0, -2.0, -3.0, -9.0, 8.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[2], mat3(-5.0, 6.0, 0.0, -2.0, -4.0, 9.0, -4.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[3], mat3(2.0, 3.0, -3.0, -5.0, 4.0, 5.0, 6.0, 1.0, 0.0)) && allOk;
	allOk = compare_vec4((block[1].s[1].c), vec4(3.0, 6.0, 5.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[1].s[2].a), ivec3(-6, -2, -9)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[0], mat3(-5.0, -2.0, 3.0, -3.0, 4.0, 3.0, -6.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[1], mat3(9.0, 9.0, -1.0, 4.0, 5.0, 5.0, 2.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[2], mat3(0.0, 2.0, 1.0, -2.0, -9.0, 2.0, 6.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[3], mat3(-4.0, -9.0, -8.0, -4.0, -2.0, 3.0, 5.0, 0.0, 9.0)) && allOk;
	allOk = compare_vec4((block[1].s[2].c), vec4(-3.0, 2.0, -9.0, 2.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0].a), ivec3(-4, -8, 5)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[0], mat3(8.0, -8.0, 6.0, 1.0, 8.0, -7.0, 6.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[1], mat3(-8.0, 7.0, 7.0, 6.0, 4.0, 9.0, 1.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[2], mat3(-5.0, -9.0, -8.0, -3.0, -2.0, 7.0, 5.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[3], mat3(6.0, 4.0, 4.0, 5.0, 4.0, 4.0, -9.0, 8.0, 7.0)) && allOk;
	allOk = compare_vec4((block[2].s[0].c), vec4(-3.0, -8.0, 9.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[2].s[1].a), ivec3(9, 5, -3)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[0], mat3(1.0, 8.0, 1.0, -8.0, -5.0, -8.0, -3.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[1], mat3(-7.0, 9.0, -1.0, -6.0, -6.0, -9.0, -9.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[2], mat3(-9.0, -2.0, -1.0, -1.0, -1.0, 2.0, -6.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[3], mat3(1.0, -4.0, -7.0, 0.0, 8.0, -8.0, -5.0, -1.0, -6.0)) && allOk;
	allOk = compare_vec4((block[2].s[1].c), vec4(4.0, -5.0, 8.0, -3.0)) && allOk;
	allOk = compare_ivec3((block[2].s[2].a), ivec3(0, -6, -7)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[0], mat3(-7.0, -6.0, 2.0, 6.0, 2.0, -2.0, 1.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[1], mat3(9.0, -9.0, 7.0, 8.0, 3.0, 1.0, -5.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[2], mat3(5.0, 7.0, -4.0, 9.0, -4.0, 3.0, 7.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[3], mat3(-2.0, -9.0, -4.0, 5.0, 5.0, 7.0, -3.0, 8.0, -2.0)) && allOk;
	allOk = compare_vec4((block[2].s[2].c), vec4(-8.0, 7.0, 5.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s[0].a = (ivec3(3, 5, -3));
	block[0].s[0].b[0] = (mat3(-8.0, 9.0, 6.0, -3.0, 0.0, -4.0, -9.0, 9.0, -5.0));
	block[0].s[0].b[1] = (mat3(7.0, -5.0, 4.0, 8.0, -2.0, -5.0, 3.0, -2.0, 1.0));
	block[0].s[0].b[2] = (mat3(2.0, 5.0, -1.0, -2.0, -6.0, 2.0, -9.0, 2.0, -6.0));
	block[0].s[0].b[3] = (mat3(-8.0, -1.0, 5.0, -9.0, 5.0, -3.0, 0.0, -6.0, 1.0));
	block[0].s[0].c = (vec4(-7.0, 4.0, -8.0, 2.0));
	block[0].s[1].a = (ivec3(-2, 2, 9));
	block[0].s[1].b[0] = (mat3(1.0, -6.0, -2.0, 7.0, 6.0, -6.0, -9.0, 1.0, -1.0));
	block[0].s[1].b[1] = (mat3(-9.0, 2.0, -4.0, -8.0, -2.0, 3.0, -7.0, 2.0, -2.0));
	block[0].s[1].b[2] = (mat3(-8.0, 0.0, -4.0, 6.0, -7.0, 8.0, 0.0, -9.0, -1.0));
	block[0].s[1].b[3] = (mat3(-3.0, -4.0, 0.0, -6.0, -6.0, 5.0, -7.0, 3.0, 3.0));
	block[0].s[1].c = (vec4(-7.0, -8.0, 1.0, -4.0));
	block[0].s[2].a = (ivec3(8, -5, 1));
	block[0].s[2].b[0] = (mat3(5.0, 0.0, 5.0, -3.0, -5.0, 0.0, -8.0, 4.0, 0.0));
	block[0].s[2].b[1] = (mat3(0.0, -2.0, -3.0, 9.0, 6.0, 6.0, -9.0, 6.0, -7.0));
	block[0].s[2].b[2] = (mat3(6.0, 8.0, -6.0, 1.0, -9.0, -2.0, -1.0, -5.0, 4.0));
	block[0].s[2].b[3] = (mat3(3.0, 0.0, -5.0, -4.0, -7.0, 7.0, -5.0, 6.0, 8.0));
	block[0].s[2].c = (vec4(-9.0, 2.0, 3.0, -9.0));
	block[0].v = (vec4(4.0, 5.0, 9.0, -2.0));
	block[1].s[0].a = (ivec3(9, -4, -2));
	block[1].s[0].b[0] = (mat3(-2.0, -2.0, 3.0, -9.0, 4.0, -6.0, 5.0, 0.0, -1.0));
	block[1].s[0].b[1] = (mat3(-8.0, -2.0, -6.0, 5.0, -5.0, 6.0, -1.0, -9.0, 5.0));
	block[1].s[0].b[2] = (mat3(7.0, -1.0, -7.0, -5.0, 2.0, 9.0, -1.0, -5.0, 7.0));
	block[1].s[0].b[3] = (mat3(-7.0, 2.0, 7.0, -3.0, 1.0, 0.0, 8.0, 3.0, 6.0));
	block[1].s[0].c = (vec4(-7.0, -4.0, 5.0, 9.0));
	block[1].s[1].a = (ivec3(3, 1, -4));
	block[1].s[1].b[0] = (mat3(-8.0, -5.0, 0.0, -8.0, 7.0, -7.0, -2.0, 9.0, 4.0));
	block[1].s[1].b[1] = (mat3(8.0, 2.0, -6.0, -2.0, 9.0, -3.0, 6.0, -2.0, 8.0));
	block[1].s[1].b[2] = (mat3(9.0, 1.0, 0.0, 6.0, 7.0, -7.0, 6.0, -2.0, 8.0));
	block[1].s[1].b[3] = (mat3(-6.0, 7.0, -3.0, -8.0, -3.0, -7.0, -9.0, -1.0, -7.0));
	block[1].s[1].c = (vec4(7.0, 5.0, 4.0, -8.0));
	block[1].s[2].a = (ivec3(-4, 3, 4));
	block[1].s[2].b[0] = (mat3(5.0, 3.0, 3.0, 5.0, -6.0, 0.0, -3.0, 0.0, 9.0));
	block[1].s[2].b[1] = (mat3(5.0, 2.0, -3.0, 0.0, 7.0, 5.0, 3.0, 8.0, -1.0));
	block[1].s[2].b[2] = (mat3(2.0, -1.0, -1.0, 5.0, -8.0, 7.0, -1.0, -8.0, 0.0));
	block[1].s[2].b[3] = (mat3(-9.0, -1.0, -7.0, -5.0, -5.0, -4.0, 5.0, -2.0, -3.0));
	block[1].s[2].c = (vec4(-8.0, 1.0, 9.0, -3.0));
	block[1].v = (vec4(-3.0, -2.0, 5.0, 5.0));
	block[2].s[0].a = (ivec3(-2, -7, 2));
	block[2].s[0].b[0] = (mat3(-5.0, 4.0, 0.0, -4.0, -4.0, 4.0, 5.0, -8.0, -9.0));
	block[2].s[0].b[1] = (mat3(-6.0, -4.0, 9.0, -7.0, 0.0, 7.0, -3.0, -9.0, -1.0));
	block[2].s[0].b[2] = (mat3(-8.0, 3.0, 9.0, -6.0, -9.0, -8.0, 3.0, 5.0, -1.0));
	block[2].s[0].b[3] = (mat3(-2.0, 2.0, -7.0, -1.0, 6.0, -2.0, -4.0, 3.0, -8.0));
	block[2].s[0].c = (vec4(-3.0, -3.0, 7.0, -7.0));
	block[2].s[1].a = (ivec3(8, 6, 4));
	block[2].s[1].b[0] = (mat3(7.0, 3.0, -2.0, 5.0, 0.0, 5.0, -9.0, -4.0, 2.0));
	block[2].s[1].b[1] = (mat3(6.0, 6.0, -5.0, 1.0, -7.0, 9.0, 6.0, 2.0, 1.0));
	block[2].s[1].b[2] = (mat3(-6.0, 2.0, 1.0, -3.0, -6.0, 7.0, -8.0, -8.0, -7.0));
	block[2].s[1].b[3] = (mat3(5.0, -4.0, 2.0, 7.0, 3.0, -6.0, -4.0, 4.0, -2.0));
	block[2].s[1].c = (vec4(7.0, -6.0, -3.0, -1.0));
	block[2].s[2].a = (ivec3(-8, 3, 6));
	block[2].s[2].b[0] = (mat3(5.0, 4.0, 8.0, -2.0, -9.0, 8.0, -7.0, -2.0, -3.0));
	block[2].s[2].b[1] = (mat3(-5.0, -8.0, -9.0, 1.0, 2.0, -1.0, -5.0, -5.0, -8.0));
	block[2].s[2].b[2] = (mat3(-5.0, -4.0, -3.0, 9.0, 0.0, 4.0, -6.0, -8.0, -1.0));
	block[2].s[2].b[3] = (mat3(-8.0, -7.0, -3.0, 8.0, -3.0, 6.0, 5.0, 2.0, 6.0));
	block[2].s[2].c = (vec4(-8.0, 5.0, -1.0, 0.0));
	block[2].v = (vec4(-4.0, 9.0, 0.0, -3.0));
}
#version 450
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
layout(scalar, binding = 1) buffer Block
{
	S s;
	lowp vec2 v;
	T t;
	highp uint u;
} block[3];

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
	allOk = compare_ivec3((block[0].s.a), ivec3(-7, 4, 4)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(-4.0, -4.0, -4.0, 9.0, -5.0, 2.0, 9.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(-1.0, 9.0, 2.0, -7.0, -1.0, 1.0, 5.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(3.0, -8.0, 5.0, 3.0, -2.0, 2.0, 4.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(7.0, 1.0, -6.0, -4.0, -1.0, -9.0, 3.0, 4.0, 5.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(-6.0, -2.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat3(block[0].t.a, mat3(-3.0, -2.0, -2.0, 3.0, -5.0, 2.0, 1.0, -3.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[0].t.b.a), ivec3(-9, 0, 9)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[0], mat3(-7.0, -1.0, 5.0, 8.0, -3.0, 4.0, 4.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[1], mat3(-1.0, 8.0, 4.0, 6.0, -1.0, 3.0, -1.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[2], mat3(0.0, -2.0, 7.0, 9.0, 9.0, 2.0, 7.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[3], mat3(5.0, 3.0, -3.0, 8.0, 4.0, -3.0, 9.0, -7.0, -4.0)) && allOk;
	allOk = compare_vec4((block[0].t.b.c), vec4(7.0, -4.0, -1.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(-5, 9, 3)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(7.0, -2.0, 9.0, 3.0, -3.0, 1.0, -9.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(-8.0, -6.0, -2.0, 6.0, 2.0, 7.0, 3.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(0.0, -6.0, 2.0, -7.0, -2.0, 6.0, -9.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(2.0, 3.0, 8.0, 9.0, 6.0, 7.0, 5.0, -6.0, -3.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(-6.0, 9.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3(block[1].t.a, mat3(-9.0, 2.0, -8.0, 3.0, 0.0, 3.0, -9.0, -1.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[1].t.b.a), ivec3(-4, 9, 6)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[0], mat3(-4.0, -4.0, 5.0, 3.0, 1.0, 4.0, 6.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[1], mat3(-4.0, -1.0, 1.0, 1.0, -2.0, -1.0, 5.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[2], mat3(-9.0, 1.0, -7.0, 7.0, 2.0, 2.0, -2.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[3], mat3(9.0, 6.0, 3.0, 4.0, 8.0, 5.0, -3.0, -3.0, -1.0)) && allOk;
	allOk = compare_vec4((block[1].t.b.c), vec4(-6.0, 5.0, -6.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(-6, -3, 9)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(9.0, 2.0, -5.0, 2.0, -4.0, 9.0, 4.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(2.0, -2.0, -8.0, 1.0, 8.0, -4.0, 0.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(0.0, 0.0, 6.0, -9.0, -9.0, -2.0, -6.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(-2.0, -9.0, -4.0, -7.0, -2.0, 1.0, -2.0, 2.0, 6.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(-3.0, -4.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3(block[2].t.a, mat3(9.0, -9.0, -2.0, 7.0, 1.0, 4.0, -8.0, -4.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[2].t.b.a), ivec3(-8, -1, 0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[0], mat3(-2.0, 2.0, 7.0, -7.0, -6.0, 8.0, 1.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[1], mat3(0.0, 0.0, -2.0, 8.0, 0.0, -6.0, 2.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[2], mat3(4.0, 0.0, -8.0, -4.0, 0.0, 1.0, 9.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[3], mat3(6.0, -1.0, 7.0, 5.0, -6.0, 4.0, 8.0, -5.0, -7.0)) && allOk;
	allOk = compare_vec4((block[2].t.b.c), vec4(3.0, 2.0, -3.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].t.a = (mat3(7.0, -9.0, 6.0, 6.0, -9.0, 1.0, 7.0, 7.0, -2.0));
	block[0].t.b.a = (ivec3(-3, -4, -7));
	block[0].t.b.b[0] = (mat3(-7.0, -1.0, 5.0, -4.0, -9.0, -7.0, -6.0, -3.0, 8.0));
	block[0].t.b.b[1] = (mat3(-5.0, 0.0, 5.0, 4.0, -2.0, -1.0, -4.0, 7.0, -6.0));
	block[0].t.b.b[2] = (mat3(-7.0, 3.0, -4.0, -3.0, 4.0, 4.0, 6.0, 8.0, -5.0));
	block[0].t.b.b[3] = (mat3(-9.0, -7.0, -1.0, -4.0, 3.0, -1.0, -1.0, 3.0, -7.0));
	block[0].t.b.c = (vec4(-6.0, -3.0, 2.0, 3.0));
	block[0].u = (1u);
	block[1].t.a = (mat3(8.0, -2.0, -8.0, -8.0, -7.0, 8.0, -4.0, -4.0, 3.0));
	block[1].t.b.a = (ivec3(3, 6, -9));
	block[1].t.b.b[0] = (mat3(2.0, 7.0, -8.0, 5.0, 7.0, -1.0, -5.0, -4.0, -5.0));
	block[1].t.b.b[1] = (mat3(7.0, -2.0, 8.0, -7.0, 5.0, 6.0, -4.0, 0.0, 5.0));
	block[1].t.b.b[2] = (mat3(-1.0, 0.0, -3.0, 0.0, 0.0, -4.0, 2.0, -7.0, 3.0));
	block[1].t.b.b[3] = (mat3(0.0, -1.0, 9.0, 2.0, 6.0, 1.0, -9.0, 2.0, 8.0));
	block[1].t.b.c = (vec4(-7.0, -3.0, -1.0, 4.0));
	block[1].u = (4u);
	block[2].t.a = (mat3(4.0, 1.0, -7.0, 2.0, 8.0, 2.0, 1.0, 7.0, 2.0));
	block[2].t.b.a = (ivec3(-6, -1, -8));
	block[2].t.b.b[0] = (mat3(5.0, 4.0, -9.0, -7.0, -9.0, -2.0, 9.0, -6.0, -3.0));
	block[2].t.b.b[1] = (mat3(6.0, 3.0, -8.0, -5.0, -8.0, 0.0, 8.0, 3.0, -7.0));
	block[2].t.b.b[2] = (mat3(0.0, -2.0, 3.0, 2.0, 7.0, 0.0, 1.0, -4.0, -6.0));
	block[2].t.b.b[3] = (mat3(3.0, 9.0, 5.0, 4.0, 7.0, -1.0, -6.0, -6.0, -8.0));
	block[2].t.b.c = (vec4(-9.0, -1.0, -9.0, -7.0));
	block[2].u = (9u);
}
#version 450
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
layout(scalar, binding = 1) buffer Block
{
	lowp uint u;
	mediump vec4 v;
	S s[][2];
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((block[0].s[0][0].a), ivec3(-2, -6, -7)) && allOk;
	allOk = compare_vec4((block[0].s[0][0].c), vec4(-5.0, -7.0, 6.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[0].s[0][1].a), ivec3(-9, -2, 2)) && allOk;
	allOk = compare_vec4((block[0].s[0][1].c), vec4(6.0, -8.0, 6.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1][0].a), ivec3(7, 9, 7)) && allOk;
	allOk = compare_vec4((block[0].s[1][0].c), vec4(1.0, -5.0, 0.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1][1].a), ivec3(2, -7, 1)) && allOk;
	allOk = compare_vec4((block[0].s[1][1].c), vec4(-3.0, -7.0, 9.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2][0].a), ivec3(1, 4, -1)) && allOk;
	allOk = compare_vec4((block[0].s[2][0].c), vec4(-7.0, -8.0, -5.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2][1].a), ivec3(-6, -8, -2)) && allOk;
	allOk = compare_vec4((block[0].s[2][1].c), vec4(-7.0, 9.0, -1.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0][0].a), ivec3(4, -8, 0)) && allOk;
	allOk = compare_vec4((block[1].s[0][0].c), vec4(5.0, -2.0, 8.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0][1].a), ivec3(0, 2, -4)) && allOk;
	allOk = compare_vec4((block[1].s[0][1].c), vec4(-8.0, 6.0, 7.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1][0].a), ivec3(-2, 3, -2)) && allOk;
	allOk = compare_vec4((block[1].s[1][0].c), vec4(8.0, 0.0, 9.0, 2.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1][1].a), ivec3(3, -5, 5)) && allOk;
	allOk = compare_vec4((block[1].s[1][1].c), vec4(-4.0, -5.0, 7.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0][0].a), ivec3(-5, 1, -5)) && allOk;
	allOk = compare_vec4((block[2].s[0][0].c), vec4(-7.0, -1.0, -6.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0][1].a), ivec3(4, -3, 1)) && allOk;
	allOk = compare_vec4((block[2].s[0][1].c), vec4(-6.0, 8.0, -8.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].v = (vec4(3.0, 5.0, -3.0, -2.0));
	block[0].s[0][0].a = (ivec3(2, 9, 8));
	block[0].s[0][0].c = (vec4(0.0, -4.0, -9.0, 9.0));
	block[0].s[0][1].a = (ivec3(-2, 1, 2));
	block[0].s[0][1].c = (vec4(2.0, -6.0, -8.0, -1.0));
	block[0].s[1][0].a = (ivec3(-5, 1, -8));
	block[0].s[1][0].c = (vec4(-5.0, 7.0, -5.0, 4.0));
	block[0].s[1][1].a = (ivec3(5, -1, -2));
	block[0].s[1][1].c = (vec4(5.0, -9.0, 5.0, -3.0));
	block[0].s[2][0].a = (ivec3(9, 6, -3));
	block[0].s[2][0].c = (vec4(8.0, -2.0, -5.0, 3.0));
	block[0].s[2][1].a = (ivec3(-6, 2, -9));
	block[0].s[2][1].c = (vec4(0.0, -6.0, 1.0, 1.0));
	block[1].v = (vec4(-2.0, 7.0, 6.0, -6.0));
	block[1].s[0][0].a = (ivec3(-9, 1, -1));
	block[1].s[0][0].c = (vec4(-8.0, -2.0, 3.0, -7.0));
	block[1].s[0][1].a = (ivec3(-4, 6, -7));
	block[1].s[0][1].c = (vec4(-1.0, -3.0, -4.0, 0.0));
	block[1].s[1][0].a = (ivec3(-9, 2, -4));
	block[1].s[1][0].c = (vec4(2.0, -2.0, -8.0, 0.0));
	block[1].s[1][1].a = (ivec3(8, 0, -9));
	block[1].s[1][1].c = (vec4(-6.0, -6.0, 5.0, -7.0));
	block[2].v = (vec4(3.0, 5.0, 0.0, 5.0));
	block[2].s[0][0].a = (ivec3(-3, -5, 0));
	block[2].s[0][0].c = (vec4(-8.0, 4.0, 0.0, 0.0));
	block[2].s[0][1].a = (ivec3(-2, -3, 9));
	block[2].s[0][1].c = (vec4(6.0, 6.0, -9.0, 6.0));
}
#version 450
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
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(block[0].var, mat4(3.0, 8.0, 5.0, -7.0, -4.0, 0.0, -1.0, -9.0, 2.0, 9.0, 5.0, 5.0, 6.0, 9.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4(block[1].var, mat4(8.0, 1.0, -3.0, 1.0, 0.0, -7.0, -4.0, 0.0, 1.0, -6.0, -7.0, 5.0, 2.0, 0.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4(block[2].var, mat4(-5.0, 8.0, 2.0, 3.0, 8.0, -6.0, 7.0, 9.0, -3.0, 7.0, -8.0, -5.0, 6.0, 4.0, -9.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec4(-7.0, -2.0, 7.0, -7.0));
	block[0].var[1] = (vec4(2.0, -4.0, 3.0, -5.0));
	block[0].var[2] = (vec4(2.0, 3.0, 8.0, 8.0));
	block[0].var[3] = (vec4(3.0, 0.0, -4.0, -1.0));
	block[1].var[0] = (vec4(-3.0, 0.0, 8.0, 1.0));
	block[1].var[1] = (vec4(-8.0, 9.0, 2.0, 7.0));
	block[1].var[2] = (vec4(-2.0, -7.0, -9.0, 1.0));
	block[1].var[3] = (vec4(6.0, -9.0, -1.0, -5.0));
	block[2].var[0] = (vec4(-6.0, -3.0, 7.0, -1.0));
	block[2].var[1] = (vec4(0.0, -1.0, -2.0, 1.0));
	block[2].var[2] = (vec4(-3.0, -1.0, -4.0, 7.0));
	block[2].var[3] = (vec4(-3.0, 1.0, 1.0, -9.0));
}
#version 450
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
	highp mat2 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(block[0].var, mat2(8.0, -8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2(block[1].var, mat2(0.0, -4.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat2(block[2].var, mat2(-7.0, -4.0, 6.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec2(-3.0, 3.0));
	block[0].var[1] = (vec2(4.0, 4.0));
	block[1].var[0] = (vec2(9.0, -9.0));
	block[1].var[1] = (vec2(-5.0, 8.0));
	block[2].var[0] = (vec2(0.0, 4.0));
	block[2].var[1] = (vec2(2.0, -4.0));
}
#version 450
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
	highp mat4x3 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), 0.0) && allOk;
	allOk = compare_mat4x3(block[0].var, mat4x3(1.0, -8.0, -1.0, 2.0, 8.0, 7.0, -7.0, 9.0, -3.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_float((block[1].padding), 2.0) && allOk;
	allOk = compare_mat4x3(block[1].var, mat4x3(4.0, -2.0, -9.0, -6.0, 8.0, 9.0, 2.0, -2.0, 3.0, 9.0, -7.0, 9.0)) && allOk;
	allOk = compare_float((block[2].padding), 2.0) && allOk;
	allOk = compare_mat4x3(block[2].var, mat4x3(-3.0, 3.0, 6.0, 6.0, 3.0, -3.0, -9.0, 4.0, 8.0, -5.0, 4.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (2.0);
	block[0].var = (mat4x3(4.0, 9.0, -7.0, 5.0, -8.0, 9.0, 1.0, 9.0, -6.0, -6.0, 1.0, 6.0));
	block[1].padding = (-2.0);
	block[1].var = (mat4x3(-2.0, 5.0, 3.0, -6.0, -8.0, -5.0, 9.0, 8.0, -2.0, -1.0, 1.0, 7.0));
	block[2].padding = (0.0);
	block[2].var = (mat4x3(5.0, 9.0, -6.0, 5.0, 6.0, 2.0, 3.0, -8.0, 7.0, 3.0, 1.0, -4.0));
}
#version 450
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
	lowp uint a;
	highp int b;
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	bvec2 c;
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	lowp int d;
	lowp vec2 e;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 2u) && allOk;
	allOk = compare_int((d), 2) && allOk;
	allOk = compare_vec2((e), vec2(-1.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (6u);
	blockB.b = (7);
	blockC.c = (bvec2(true, true));
	d = (1);
}
#version 450
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
	mediump uint a;
	lowp mat3x2 b;
	highp ivec3 c[4];
	bvec3 d[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 0u) && allOk;
	allOk = compare_ivec3((blockB.c[0]), ivec3(-4, -6, -1)) && allOk;
	allOk = compare_ivec3((blockB.c[1]), ivec3(-1, -2, 1)) && allOk;
	allOk = compare_ivec3((blockB.c[2]), ivec3(6, 5, 7)) && allOk;
	allOk = compare_ivec3((blockB.c[3]), ivec3(-2, -4, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (4u);
	blockB.b = (mat3x2(-3.0, -2.0, 0.0, -6.0, 6.0, -6.0));
	blockB.d[0] = (bvec3(true, false, true));
	blockB.d[1] = (bvec3(true, true, false));
	blockB.d[2] = (bvec3(false, true, false));
}
#version 450
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
	mediump mat4x2 mA;
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	lowp uvec3 a[];
};
layout(std430, column_major, binding = 2) readonly buffer BlockC
{
	sA b;
	highp mat4 c[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((a[0]), uvec3(8u, 9u, 7u)) && allOk;
	allOk = compare_mat4x2(blockC.b.mA, mat4x2(-9.0, -9.0, -4.0, 4.0, 5.0, 3.0, 7.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (uvec3(4u, 0u, 2u));
}
#version 450
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
	layout(offset = 0) lowp vec4 a;
	layout(offset = 16) lowp float b;
	layout(offset = 20) bvec3 c;
	layout(offset = 32) lowp uvec4 d;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) bool e;
	layout(offset = 4) lowp vec3 f;
	layout(offset = 16) mediump vec3 g[1];
	layout(offset = 32) highp ivec3 h;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((a), vec4(-1.0, 5.0, -9.0, 7.0)) && allOk;
	allOk = compare_float((b), 5.0) && allOk;
	allOk = compare_bvec3((c), bvec3(false, true, true)) && allOk;
	allOk = compare_vec3((g[0]), vec3(-2.0, 6.0, -9.0)) && allOk;
	allOk = compare_ivec3((h), ivec3(-8, -2, 0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (-1.0);
	c = (bvec3(true, false, false));
	d = (uvec4(1u, 9u, 7u, 9u));
	e = (false);
	f = (vec3(-3.0, -5.0, -1.0));
	h = (ivec3(-6, -4, -4));
}
#version 450
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
	layout(offset = 0) lowp vec2 a;
} blockB[1];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) lowp ivec2 b;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB[0].a), vec2(-3.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (vec2(-5.0, 5.0));
	b = (ivec2(-3, 3));
}
#version 450
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
	mediump int mA;
};
struct sB
{
	highp uint mA;
	sA mB;
	bvec3 mC;
	mediump uint mD;
};
layout(scalar, binding = 1) buffer BlockB
{
	lowp mat3 a;
	bvec4 b;
	sB c;
	mediump vec3 d;
	mediump ivec2 e[];
} blockB[2];
layout(scalar, row_major, binding = 2) buffer BlockC
{
	highp mat3x4 f;
	bvec3 g;
	bvec4 h[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB[0].a, mat3(-7.0, 8.0, 8.0, 2.0, 4.0, 0.0, -2.0, 6.0, -1.0)) && allOk;
	allOk = compare_bvec4((blockB[0].b), bvec4(false, true, true, true)) && allOk;
	allOk = compare_uint((blockB[0].c.mA), 7u) && allOk;
	allOk = compare_int((blockB[0].c.mB.mA), 0) && allOk;
	allOk = compare_bvec3((blockB[0].c.mC), bvec3(false, false, false)) && allOk;
	allOk = compare_uint((blockB[0].c.mD), 4u) && allOk;
	allOk = compare_vec3((blockB[0].d), vec3(-5.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3(blockB[1].a, mat3(2.0, 7.0, -1.0, -3.0, 5.0, 0.0, 2.0, 7.0, 3.0)) && allOk;
	allOk = compare_bvec4((blockB[1].b), bvec4(true, false, false, false)) && allOk;
	allOk = compare_uint((blockB[1].c.mA), 1u) && allOk;
	allOk = compare_int((blockB[1].c.mB.mA), 4) && allOk;
	allOk = compare_bvec3((blockB[1].c.mC), bvec3(false, true, true)) && allOk;
	allOk = compare_uint((blockB[1].c.mD), 5u) && allOk;
	allOk = compare_vec3((blockB[1].d), vec3(-1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3x4(blockC.f, mat3x4(1.0, 3.0, 5.0, -1.0, 5.0, 4.0, -9.0, -2.0, -1.0, 6.0, 3.0, 9.0)) && allOk;
	allOk = compare_bvec4((blockC.h[0]), bvec4(false, true, false, false)) && allOk;
	allOk = compare_bvec4((blockC.h[1]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((blockC.h[2]), bvec4(false, true, false, false)) && allOk;
	allOk = compare_bvec4((blockC.h[3]), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec4((blockC.h[4]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((blockC.h[5]), bvec4(false, false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (mat3(0.0, -7.0, 3.0, -2.0, 2.0, -7.0, 4.0, 6.0, -8.0));
	blockB[0].d = (vec3(-3.0, -9.0, -5.0));
	blockB[0].e[0] = (ivec2(3, 5));
	blockB[0].e[1] = (ivec2(-5, -2));
	blockB[0].e[2] = (ivec2(-2, 8));
	blockB[0].e[3] = (ivec2(-3, -3));
	blockB[0].e[4] = (ivec2(-8, 1));
	blockB[0].e[5] = (ivec2(-3, -1));
	blockB[0].e[6] = (ivec2(3, 7));
	blockB[0].e[7] = (ivec2(-4, -5));
	blockB[1].a = (mat3(-1.0, -3.0, 1.0, -9.0, 8.0, 9.0, -8.0, -8.0, 3.0));
	blockB[1].d = (vec3(-6.0, -2.0, -6.0));
	blockB[1].e[0] = (ivec2(9, 9));
	blockB[1].e[1] = (ivec2(-9, 5));
	blockB[1].e[2] = (ivec2(-3, 9));
	blockB[1].e[3] = (ivec2(-9, -7));
	blockB[1].e[4] = (ivec2(6, 9));
	blockB[1].e[5] = (ivec2(0, 4));
	blockC.f = (mat3x4(5.0, 5.0, -1.0, -6.0, -3.0, 0.0, 0.0, 7.0, 0.0, 1.0, -7.0, -2.0));
	blockC.h[0] = (bvec4(false, false, true, false));
	blockC.h[1] = (bvec4(true, false, true, false));
	blockC.h[2] = (bvec4(true, true, false, true));
	blockC.h[3] = (bvec4(true, true, false, true));
	blockC.h[4] = (bvec4(false, true, true, false));
	blockC.h[5] = (bvec4(true, false, true, true));
}
#version 450
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
	highp mat2x3 a[];
};
layout(scalar, row_major, binding = 2) buffer BlockC
{
	mediump uvec4 b;
	highp mat2 c;
};
layout(scalar, column_major, binding = 3) buffer BlockD
{
	mediump mat3x4 d;
	highp uint e;
	lowp uvec4 f[3];
	mediump uvec4 g;
	mediump vec4 h[][6];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((b), uvec4(7u, 1u, 3u, 6u)) && allOk;
	allOk = compare_mat3x4(d, mat3x4(3.0, -7.0, -1.0, 3.0, -4.0, 0.0, -7.0, 0.0, 4.0, -1.0, -8.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (mat2x3(6.0, -5.0, -1.0, -3.0, -1.0, -2.0));
	a[1] = (mat2x3(7.0, -5.0, -5.0, -4.0, 1.0, -7.0));
	a[2] = (mat2x3(1.0, 1.0, -9.0, -7.0, -8.0, 6.0));
	a[3] = (mat2x3(5.0, 0.0, 1.0, -1.0, 6.0, 3.0));
	a[4] = (mat2x3(6.0, -6.0, 2.0, 6.0, 9.0, -9.0));
	a[5] = (mat2x3(4.0, 4.0, -4.0, -4.0, 0.0, 3.0));
	a[6] = (mat2x3(-8.0, 1.0, 0.0, 0.0, -5.0, -3.0));
	b = (uvec4(4u, 9u, 6u, 3u));
	c = (mat2(1.0, -6.0, 6.0, 9.0));
	d = (mat3x4(6.0, -7.0, -3.0, 3.0, 1.0, -1.0, 8.0, -1.0, 8.0, -1.0, -5.0, 5.0));
	e = (4u);
	g = (uvec4(2u, 7u, 6u, 6u));
	h[0][0] = (vec4(3.0, 6.0, -9.0, 8.0));
	h[0][1] = (vec4(9.0, 6.0, -2.0, -9.0));
	h[0][2] = (vec4(-6.0, -8.0, 3.0, 4.0));
	h[0][3] = (vec4(-5.0, -6.0, 3.0, -7.0));
	h[0][4] = (vec4(4.0, 4.0, -7.0, 0.0));
	h[0][5] = (vec4(-5.0, -8.0, 9.0, 6.0));
	h[1][0] = (vec4(2.0, 1.0, -6.0, -4.0));
	h[1][1] = (vec4(4.0, 2.0, 2.0, -1.0));
	h[1][2] = (vec4(0.0, 0.0, -6.0, -3.0));
	h[1][3] = (vec4(0.0, -8.0, -3.0, 6.0));
	h[1][4] = (vec4(-2.0, -2.0, -7.0, 2.0));
	h[1][5] = (vec4(8.0, 5.0, 3.0, -8.0));
	h[2][0] = (vec4(3.0, 7.0, -6.0, 4.0));
	h[2][1] = (vec4(-9.0, 6.0, -5.0, 2.0));
	h[2][2] = (vec4(-8.0, -5.0, 0.0, -5.0));
	h[2][3] = (vec4(3.0, 0.0, 3.0, -7.0));
	h[2][4] = (vec4(-6.0, 6.0, -1.0, 8.0));
	h[2][5] = (vec4(-3.0, -8.0, 1.0, 1.0));
	h[3][0] = (vec4(-5.0, -9.0, 0.0, -3.0));
	h[3][1] = (vec4(-1.0, -4.0, -8.0, 3.0));
	h[3][2] = (vec4(9.0, -2.0, 0.0, 1.0));
	h[3][3] = (vec4(-6.0, -7.0, -9.0, -2.0));
	h[3][4] = (vec4(-1.0, 2.0, 7.0, 4.0));
	h[3][5] = (vec4(3.0, 3.0, 4.0, 8.0));
	h[4][0] = (vec4(0.0, 9.0, 7.0, 0.0));
	h[4][1] = (vec4(-3.0, 3.0, -1.0, -5.0));
	h[4][2] = (vec4(-8.0, -3.0, 0.0, 1.0));
	h[4][3] = (vec4(8.0, -5.0, 8.0, -5.0));
	h[4][4] = (vec4(3.0, 4.0, -9.0, -4.0));
	h[4][5] = (vec4(3.0, 6.0, -4.0, -6.0));
	h[5][0] = (vec4(7.0, -7.0, 9.0, 0.0));
	h[5][1] = (vec4(5.0, -5.0, 7.0, -2.0));
	h[5][2] = (vec4(3.0, 1.0, -1.0, 8.0));
	h[5][3] = (vec4(9.0, 7.0, -1.0, -4.0));
	h[5][4] = (vec4(9.0, -5.0, 6.0, -8.0));
	h[5][5] = (vec4(-5.0, 8.0, 9.0, -4.0));
}
#version 450
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
	lowp int a;
	float16_t b;
	int16_t c;
	lowp float d[1];
	highp uint e;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.a), 0) && allOk;
	allOk = compare_int16_t(int(blockB.c), 3) && allOk;
	allOk = compare_uint((blockB.e), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (5);
	blockB.b = float16_t(-5.0);
}
#version 450
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
	int16_t a;
	u16vec3 b;
	mediump int c;
} blockB;

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.c), -5) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = int16_t(9);
	blockB.b = u16vec3(uvec3(2u, 5u, 7u));
}
#version 450
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
	mediump mat2 a;
	mediump mat2x3 b;
	f16vec3 c;
	bvec4 d;
	lowp mat3x4 e[];
};
layout(std140, binding = 2) buffer BlockC
{
	u16vec2 f;
	highp ivec2 g;
	float16_t h[6];
	lowp int i[];
} blockC;
layout(std430, column_major, binding = 3) buffer BlockD
{
	highp uvec2 j;
	u16vec4 k;
	i16vec2 l[3];
	f16vec3 m;
	bvec3 n[];
};
layout(std140, binding = 4) buffer BlockE
{
	u16vec4 o;
	highp int p;
	highp uvec3 q;
	highp mat2x3 r;
	highp vec4 s[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(a, mat2(6.0, 8.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat2x3(b, mat2x3(-4.0, -5.0, 9.0, -4.0, -6.0, -1.0)) && allOk;
	allOk = compare_f16vec3(vec3(c), vec3(-1.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat3x4(e[0], mat3x4(8.0, 3.0, 0.0, 2.0, 1.0, 8.0, 0.0, 9.0, -1.0, -1.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat3x4(e[1], mat3x4(-4.0, -3.0, 1.0, -4.0, -9.0, 1.0, -4.0, 0.0, 2.0, 0.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat3x4(e[2], mat3x4(3.0, -5.0, -1.0, -5.0, -1.0, -9.0, -6.0, -9.0, -8.0, 6.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(e[3], mat3x4(7.0, 2.0, -7.0, -2.0, -5.0, 4.0, 8.0, -9.0, -8.0, -2.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat3x4(e[4], mat3x4(-9.0, 0.0, -8.0, -3.0, 8.0, -7.0, 9.0, -9.0, 2.0, 4.0, 7.0, 4.0)) && allOk;
	allOk = compare_ivec2((blockC.g), ivec2(5, -7)) && allOk;
	allOk = compare_float16_t(float(blockC.h[0]), 8.0) && allOk;
	allOk = compare_float16_t(float(blockC.h[1]), -2.0) && allOk;
	allOk = compare_float16_t(float(blockC.h[2]), 6.0) && allOk;
	allOk = compare_float16_t(float(blockC.h[3]), 2.0) && allOk;
	allOk = compare_float16_t(float(blockC.h[4]), -9.0) && allOk;
	allOk = compare_float16_t(float(blockC.h[5]), -5.0) && allOk;
	allOk = compare_uvec2((j), uvec2(0u, 2u)) && allOk;
	allOk = compare_f16vec3(vec3(m), vec3(-9.0, -6.0, 7.0)) && allOk;
	allOk = compare_bvec3((n[0]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((n[1]), bvec3(false, false, false)) && allOk;
	allOk = compare_u16vec4(uvec4(blockE.o), uvec4(8u, 8u, 1u, 5u)) && allOk;
	allOk = compare_int((blockE.p), 5) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat2(-5.0, -3.0, -2.0, 0.0));
	b = (mat2x3(-6.0, 6.0, -6.0, 3.0, -7.0, 8.0));
	d = (bvec4(true, true, true, true));
	e[0] = (mat3x4(-7.0, -4.0, 8.0, 2.0, -9.0, 0.0, 4.0, 3.0, -1.0, -6.0, -4.0, -5.0));
	e[1] = (mat3x4(3.0, -5.0, 6.0, -6.0, -2.0, -8.0, 5.0, -4.0, 8.0, -5.0, 2.0, -2.0));
	e[2] = (mat3x4(8.0, -1.0, -1.0, 1.0, 7.0, 8.0, 7.0, 0.0, -5.0, 6.0, 5.0, -6.0));
	e[3] = (mat3x4(-6.0, 6.0, 6.0, -6.0, 3.0, 2.0, -4.0, 5.0, -9.0, 5.0, -9.0, -5.0));
	e[4] = (mat3x4(-1.0, -8.0, -7.0, 8.0, 2.0, 8.0, -1.0, -1.0, 3.0, -6.0, 6.0, -1.0));
	blockC.g = (ivec2(5, -7));
	j = (uvec2(0u, 0u));
	k = u16vec4(uvec4(3u, 2u, 0u, 3u));
	n[0] = (bvec3(true, true, true));
	n[1] = (bvec3(false, false, false));
	blockE.q = (uvec3(0u, 4u, 1u));
	blockE.r = (mat2x3(-4.0, -1.0, -6.0, 2.0, 5.0, -8.0));
	blockE.s[0] = (vec4(-3.0, -6.0, -2.0, 5.0));
	blockE.s[1] = (vec4(2.0, 9.0, -3.0, -4.0));
	blockE.s[2] = (vec4(3.0, -4.0, 9.0, -8.0));
	blockE.s[3] = (vec4(0.0, 8.0, -2.0, 7.0));
	blockE.s[4] = (vec4(-8.0, 6.0, -5.0, -6.0));
	blockE.s[5] = (vec4(-1.0, 4.0, 7.0, 4.0));
	blockE.s[6] = (vec4(6.0, -7.0, 4.0, -9.0));
	blockE.s[7] = (vec4(3.0, -4.0, 8.0, 1.0));
}
#version 450
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
	uint16_t a;
	u16vec2 b;
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(a), 4u) && allOk;
	allOk = compare_u16vec2(uvec2(b), uvec2(9u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = uint16_t(8u);
}
#version 450
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
	highp uvec2 a;
	f16vec4 b;
	lowp int c;
	lowp uvec2 d;
	i16vec3 e[];
};
layout(std140, binding = 2) buffer BlockC
{
	highp vec3 f;
	i16vec4 g;
	highp mat4 h;
	highp ivec4 i[];
} blockC;
layout(std140, row_major, binding = 3) buffer BlockD
{
	highp vec4 j[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(b), vec4(9.0, -5.0, 0.0, 3.0)) && allOk;
	allOk = compare_int((c), 7) && allOk;
	allOk = compare_uvec2((d), uvec2(5u, 0u)) && allOk;
	allOk = compare_i16vec3(ivec3(e[0]), ivec3(2, 8, -2)) && allOk;
	allOk = compare_i16vec3(ivec3(e[1]), ivec3(-2, 4, -7)) && allOk;
	allOk = compare_i16vec3(ivec3(e[2]), ivec3(-2, -1, 1)) && allOk;
	allOk = compare_i16vec3(ivec3(e[3]), ivec3(-1, -6, 3)) && allOk;
	allOk = compare_i16vec3(ivec3(e[4]), ivec3(-7, 4, 1)) && allOk;
	allOk = compare_i16vec3(ivec3(e[5]), ivec3(-6, -7, 2)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.g), ivec4(0, 2, 2, -2)) && allOk;
	allOk = compare_mat4(blockC.h, mat4(3.0, -6.0, 7.0, -7.0, 9.0, -2.0, 7.0, 6.0, 3.0, -8.0, -8.0, 0.0, 6.0, 7.0, 2.0, -4.0)) && allOk;
	allOk = compare_ivec4((blockC.i[0]), ivec4(-9, -8, 2, -3)) && allOk;
	allOk = compare_ivec4((blockC.i[1]), ivec4(6, 1, 7, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = f16vec4(vec4(-9.0, 0.0, 9.0, 2.0));
	c = (-6);
	d = (uvec2(8u, 5u));
	e[0] = i16vec3(ivec3(3, 5, -8));
	e[1] = i16vec3(ivec3(-7, -8, 3));
	e[2] = i16vec3(ivec3(-6, -9, 9));
	e[3] = i16vec3(ivec3(-9, 9, 8));
	e[4] = i16vec3(ivec3(-1, -4, 0));
	e[5] = i16vec3(ivec3(-4, 2, 1));
	blockC.f = (vec3(2.0, 9.0, -3.0));
	blockC.g = i16vec4(ivec4(-2, -6, -2, 5));
	blockC.h = (mat4(-3.0, 2.0, 0.0, 0.0, 2.0, -8.0, -5.0, -3.0, -3.0, 0.0, 8.0, -9.0, 2.0, -4.0, 1.0, 8.0));
	blockC.i[0] = (ivec4(7, -4, -3, -2));
	blockC.i[1] = (ivec4(7, -9, 3, 8));
	j[0] = (vec4(2.0, 4.0, -8.0, -4.0));
	j[1] = (vec4(-3.0, -8.0, 8.0, -8.0));
	j[2] = (vec4(3.0, -1.0, 4.0, 4.0));
	j[3] = (vec4(-4.0, 9.0, 8.0, -7.0));
	j[4] = (vec4(-1.0, -7.0, 2.0, -7.0));
	j[5] = (vec4(3.0, -2.0, -4.0, 9.0));
	j[6] = (vec4(-4.0, 0.0, 5.0, -5.0));
}
#version 450
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
	layout(offset = 4) bvec3 b;
	layout(offset = 16) int16_t c;
	layout(offset = 20) mediump uint d;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) u16vec4 e;
	layout(offset = 8) float16_t f;
	layout(offset = 10) i16vec2 g;
} blockC;

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a[0]), 8u) && allOk;
	allOk = compare_uint((blockB.d), 6u) && allOk;
	allOk = compare_u16vec4(uvec4(blockC.e), uvec4(9u, 4u, 5u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (9u);
	blockB.b = (bvec3(true, false, true));
	blockB.c = int16_t(-4);
	blockC.f = float16_t(-2.0);
	blockC.g = i16vec2(ivec2(5, -9));
}
#version 450
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
	layout(offset = 0) lowp uvec2 a[1];
	layout(offset = 8) u16vec3 b;
	layout(offset = 16) bvec4 c[1];
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump ivec3 d;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) bool e;
	layout(offset = 4) mediump int f;
	layout(offset = 16) lowp vec3 g;
	layout(offset = 32) f16vec3 h;
	layout(offset = 48) bvec4 i[1];
} blockD[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a[0]), uvec2(3u, 1u)) && allOk;
	allOk = compare_bool((blockD[0].e), false) && allOk;
	allOk = compare_int((blockD[0].f), 6) && allOk;
	allOk = compare_f16vec3(vec3(blockD[0].h), vec3(5.0, -7.0, -4.0)) && allOk;
	allOk = compare_bvec4((blockD[0].i[0]), bvec4(false, true, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = u16vec3(uvec3(9u, 0u, 7u));
	blockB.c[0] = (bvec4(true, true, true, true));
	d = (ivec3(-4, -8, 0));
	blockD[0].e = (true);
	blockD[0].f = (1);
	blockD[0].g = (vec3(-6.0, 4.0, -4.0));
}
#version 450
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
	layout(offset = 0) int16_t a;
	layout(offset = 2) uint16_t b;
	layout(offset = 4) u16vec4 c;
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	a = int16_t(1);
	b = uint16_t(2u);
	c = u16vec4(uvec4(0u, 1u, 0u, 6u));
}
#version 450
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
	float16_t a;
	highp int b;
	i16vec3 c;
} blockB[3];
layout(scalar, binding = 2) buffer BlockC
{
	mediump ivec3 d;
	bvec4 e;
	bvec2 f;
	lowp uvec3 g[];
} blockC;

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

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
	allOk = compare_ivec3((blockC.d), ivec3(8, -3, 8)) && allOk;
	allOk = compare_bvec2((blockC.f), bvec2(false, true)) && allOk;
	allOk = compare_uvec3((blockC.g[0]), uvec3(0u, 3u, 4u)) && allOk;
	allOk = compare_uvec3((blockC.g[1]), uvec3(5u, 6u, 0u)) && allOk;
	allOk = compare_uvec3((blockC.g[2]), uvec3(7u, 9u, 8u)) && allOk;
	allOk = compare_uvec3((blockC.g[3]), uvec3(1u, 0u, 4u)) && allOk;
	allOk = compare_uvec3((blockC.g[4]), uvec3(7u, 2u, 4u)) && allOk;
	allOk = compare_uvec3((blockC.g[5]), uvec3(9u, 3u, 1u)) && allOk;
	allOk = compare_uvec3((blockC.g[6]), uvec3(0u, 8u, 7u)) && allOk;
	allOk = compare_uvec3((blockC.g[7]), uvec3(2u, 4u, 8u)) && allOk;
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
	blockC.d = (ivec3(-7, 3, 1));
	blockC.f = (bvec2(false, false));
	blockC.g[0] = (uvec3(2u, 3u, 3u));
	blockC.g[1] = (uvec3(8u, 6u, 3u));
	blockC.g[2] = (uvec3(3u, 4u, 4u));
	blockC.g[3] = (uvec3(8u, 4u, 4u));
	blockC.g[4] = (uvec3(7u, 0u, 4u));
	blockC.g[5] = (uvec3(8u, 9u, 3u));
	blockC.g[6] = (uvec3(2u, 2u, 1u));
	blockC.g[7] = (uvec3(7u, 2u, 5u));
}
#version 450
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
	f16vec4 mA[7];
};
layout(scalar, row_major, binding = 1) buffer BlockB
{
	lowp ivec2 a;
	sA b[7];
	lowp mat4x2 c;
	lowp uvec2 d[];
} blockB;
layout(scalar, row_major, binding = 2) readonly buffer BlockC
{
	lowp mat4x2 e;
	bvec2 f[][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a), ivec2(1, -8)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[0].mA[0]), vec4(7.0, -4.0, -9.0, 0.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[0].mA[1]), vec4(-2.0, -3.0, -3.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[0].mA[2]), vec4(-8.0, 6.0, -6.0, 3.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[0].mA[3]), vec4(9.0, -7.0, 3.0, 0.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[0].mA[4]), vec4(0.0, 5.0, -8.0, 9.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[0].mA[5]), vec4(3.0, -8.0, -4.0, 9.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[0].mA[6]), vec4(-2.0, 0.0, 3.0, 9.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[1].mA[0]), vec4(-7.0, -9.0, 7.0, -9.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[1].mA[1]), vec4(-6.0, -4.0, 3.0, 8.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[1].mA[2]), vec4(-1.0, -4.0, 1.0, 6.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[1].mA[3]), vec4(-2.0, -7.0, -1.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[1].mA[4]), vec4(-4.0, -6.0, 7.0, -1.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[1].mA[5]), vec4(-5.0, -5.0, 6.0, -1.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[1].mA[6]), vec4(2.0, 1.0, -5.0, 1.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[2].mA[0]), vec4(7.0, 1.0, -1.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[2].mA[1]), vec4(-1.0, 2.0, 9.0, 5.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[2].mA[2]), vec4(2.0, 3.0, 7.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[2].mA[3]), vec4(7.0, 4.0, -9.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[2].mA[4]), vec4(7.0, -2.0, 3.0, 6.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[2].mA[5]), vec4(9.0, -1.0, -4.0, 5.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[2].mA[6]), vec4(-9.0, -8.0, 7.0, 8.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[3].mA[0]), vec4(5.0, -4.0, 7.0, -1.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[3].mA[1]), vec4(8.0, -6.0, -2.0, 8.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[3].mA[2]), vec4(-1.0, 1.0, 5.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[3].mA[3]), vec4(-2.0, -5.0, 9.0, 2.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[3].mA[4]), vec4(-3.0, 8.0, 0.0, 1.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[3].mA[5]), vec4(-2.0, -3.0, 5.0, -9.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[3].mA[6]), vec4(-8.0, -9.0, 6.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[4].mA[0]), vec4(5.0, -6.0, -6.0, -2.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[4].mA[1]), vec4(-9.0, 9.0, 1.0, -1.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[4].mA[2]), vec4(-5.0, -8.0, 8.0, 7.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[4].mA[3]), vec4(-8.0, 2.0, -5.0, 0.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[4].mA[4]), vec4(5.0, -8.0, 7.0, 7.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[4].mA[5]), vec4(-5.0, -1.0, 7.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[4].mA[6]), vec4(-3.0, 3.0, -7.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[5].mA[0]), vec4(9.0, -2.0, -6.0, 8.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[5].mA[1]), vec4(9.0, 9.0, 1.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[5].mA[2]), vec4(-7.0, -5.0, 8.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[5].mA[3]), vec4(7.0, -9.0, 8.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[5].mA[4]), vec4(4.0, -1.0, 1.0, 1.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[5].mA[5]), vec4(8.0, -3.0, 9.0, 6.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[5].mA[6]), vec4(1.0, 9.0, 8.0, 5.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[6].mA[0]), vec4(9.0, -1.0, 2.0, 0.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[6].mA[1]), vec4(-1.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[6].mA[2]), vec4(9.0, 5.0, -9.0, 8.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[6].mA[3]), vec4(-9.0, 2.0, 8.0, 8.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[6].mA[4]), vec4(-6.0, 0.0, -2.0, 6.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[6].mA[5]), vec4(6.0, -1.0, 3.0, 3.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[6].mA[6]), vec4(-5.0, -7.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4x2(blockB.c, mat4x2(1.0, 9.0, -5.0, 8.0, 3.0, -8.0, 6.0, -5.0)) && allOk;
	allOk = compare_uvec2((blockB.d[0]), uvec2(0u, 4u)) && allOk;
	allOk = compare_uvec2((blockB.d[1]), uvec2(4u, 2u)) && allOk;
	allOk = compare_bvec2((f[0][0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((f[0][1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((f[1][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((f[1][1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((f[2][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((f[2][1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((f[3][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((f[3][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((f[4][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((f[4][1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((f[5][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((f[5][1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((f[6][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((f[6][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((f[7][0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((f[7][1]), bvec2(false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0].mA[0] = f16vec4(vec4(6.0, -4.0, -9.0, -3.0));
	blockB.b[0].mA[1] = f16vec4(vec4(2.0, -5.0, 1.0, -9.0));
	blockB.b[0].mA[2] = f16vec4(vec4(-8.0, 5.0, -1.0, -9.0));
	blockB.b[0].mA[3] = f16vec4(vec4(-4.0, 4.0, -6.0, 9.0));
	blockB.b[0].mA[4] = f16vec4(vec4(-1.0, -2.0, -3.0, 5.0));
	blockB.b[0].mA[5] = f16vec4(vec4(6.0, 0.0, 6.0, 1.0));
	blockB.b[0].mA[6] = f16vec4(vec4(8.0, -4.0, -4.0, -4.0));
	blockB.b[1].mA[0] = f16vec4(vec4(-2.0, -2.0, -5.0, -9.0));
	blockB.b[1].mA[1] = f16vec4(vec4(9.0, 6.0, 3.0, 7.0));
	blockB.b[1].mA[2] = f16vec4(vec4(-6.0, -1.0, -3.0, -2.0));
	blockB.b[1].mA[3] = f16vec4(vec4(9.0, -6.0, 1.0, 6.0));
	blockB.b[1].mA[4] = f16vec4(vec4(7.0, -7.0, 2.0, -1.0));
	blockB.b[1].mA[5] = f16vec4(vec4(9.0, 0.0, 9.0, 6.0));
	blockB.b[1].mA[6] = f16vec4(vec4(-2.0, 8.0, 0.0, 4.0));
	blockB.b[2].mA[0] = f16vec4(vec4(2.0, -5.0, -5.0, 2.0));
	blockB.b[2].mA[1] = f16vec4(vec4(-5.0, 0.0, -2.0, -3.0));
	blockB.b[2].mA[2] = f16vec4(vec4(-3.0, 5.0, -6.0, -1.0));
	blockB.b[2].mA[3] = f16vec4(vec4(-9.0, -4.0, -6.0, 9.0));
	blockB.b[2].mA[4] = f16vec4(vec4(6.0, -8.0, -8.0, 8.0));
	blockB.b[2].mA[5] = f16vec4(vec4(6.0, 0.0, -7.0, -6.0));
	blockB.b[2].mA[6] = f16vec4(vec4(-9.0, -7.0, 1.0, 2.0));
	blockB.b[3].mA[0] = f16vec4(vec4(3.0, -7.0, -5.0, 6.0));
	blockB.b[3].mA[1] = f16vec4(vec4(-1.0, 7.0, 5.0, -9.0));
	blockB.b[3].mA[2] = f16vec4(vec4(7.0, -8.0, -1.0, -8.0));
	blockB.b[3].mA[3] = f16vec4(vec4(-6.0, -5.0, -7.0, -4.0));
	blockB.b[3].mA[4] = f16vec4(vec4(6.0, -2.0, -6.0, 7.0));
	blockB.b[3].mA[5] = f16vec4(vec4(5.0, 4.0, 0.0, 9.0));
	blockB.b[3].mA[6] = f16vec4(vec4(8.0, -4.0, 5.0, -1.0));
	blockB.b[4].mA[0] = f16vec4(vec4(0.0, 0.0, 1.0, 9.0));
	blockB.b[4].mA[1] = f16vec4(vec4(-7.0, 2.0, 6.0, 8.0));
	blockB.b[4].mA[2] = f16vec4(vec4(4.0, -2.0, 4.0, -3.0));
	blockB.b[4].mA[3] = f16vec4(vec4(-6.0, 2.0, -7.0, 9.0));
	blockB.b[4].mA[4] = f16vec4(vec4(5.0, -3.0, -2.0, 7.0));
	blockB.b[4].mA[5] = f16vec4(vec4(4.0, -1.0, 9.0, -5.0));
	blockB.b[4].mA[6] = f16vec4(vec4(7.0, 7.0, -7.0, -6.0));
	blockB.b[5].mA[0] = f16vec4(vec4(4.0, -7.0, -7.0, 9.0));
	blockB.b[5].mA[1] = f16vec4(vec4(7.0, 6.0, -1.0, -7.0));
	blockB.b[5].mA[2] = f16vec4(vec4(-6.0, -1.0, -8.0, -1.0));
	blockB.b[5].mA[3] = f16vec4(vec4(-7.0, -7.0, 1.0, -3.0));
	blockB.b[5].mA[4] = f16vec4(vec4(5.0, -6.0, -2.0, 2.0));
	blockB.b[5].mA[5] = f16vec4(vec4(-7.0, -8.0, -7.0, -7.0));
	blockB.b[5].mA[6] = f16vec4(vec4(-7.0, -3.0, -3.0, -9.0));
	blockB.b[6].mA[0] = f16vec4(vec4(3.0, 1.0, 3.0, -7.0));
	blockB.b[6].mA[1] = f16vec4(vec4(-6.0, -3.0, 5.0, 9.0));
	blockB.b[6].mA[2] = f16vec4(vec4(6.0, -5.0, 0.0, -9.0));
	blockB.b[6].mA[3] = f16vec4(vec4(-1.0, 5.0, -7.0, -5.0));
	blockB.b[6].mA[4] = f16vec4(vec4(2.0, -2.0, -1.0, 7.0));
	blockB.b[6].mA[5] = f16vec4(vec4(-8.0, 7.0, 3.0, -8.0));
	blockB.b[6].mA[6] = f16vec4(vec4(-4.0, -1.0, 2.0, 0.0));
	blockB.d[0] = (uvec2(5u, 9u));
	blockB.d[1] = (uvec2(3u, 3u));
}
#version 450
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
	float16_t mA;
	mediump vec2 mB;
	mediump mat4x3 mC;
	bvec3 mD;
};
struct sB
{
	mediump mat4x3 mA;
	highp vec2 mB;
	lowp mat3 mC;
	uint16_t mD;
};
layout(scalar, row_major, binding = 1) buffer BlockB
{
	int16_t a;
};
layout(scalar, column_major, binding = 2) buffer BlockC
{
	float16_t b[];
} blockC;
layout(scalar, binding = 3) buffer BlockD
{
	sA c;
	u16vec2 d;
	sB e;
	u16vec2 f;
	highp ivec4 g[];
} blockD[3];
layout(scalar, column_major, binding = 4) buffer BlockE
{
	mediump mat2x3 h;
	highp mat3 i[1];
	lowp int j;
} blockE[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(a), 0) && allOk;
	allOk = compare_mat4x3(blockD[0].e.mA, mat4x3(7.0, 8.0, -8.0, 8.0, -4.0, 0.0, 1.0, 0.0, -6.0, 6.0, -7.0, 8.0)) && allOk;
	allOk = compare_vec2((blockD[0].e.mB), vec2(-8.0, -3.0)) && allOk;
	allOk = compare_mat3(blockD[0].e.mC, mat3(-7.0, -9.0, 2.0, 3.0, 3.0, -3.0, -4.0, 8.0, -2.0)) && allOk;
	allOk = compare_uint16_t(uint(blockD[0].e.mD), 1u) && allOk;
	allOk = compare_u16vec2(uvec2(blockD[0].f), uvec2(6u, 4u)) && allOk;
	allOk = compare_mat4x3(blockD[1].e.mA, mat4x3(0.0, 9.0, -9.0, -5.0, 3.0, -9.0, -4.0, -1.0, 1.0, -9.0, -4.0, 6.0)) && allOk;
	allOk = compare_vec2((blockD[1].e.mB), vec2(-1.0, 7.0)) && allOk;
	allOk = compare_mat3(blockD[1].e.mC, mat3(9.0, 5.0, -2.0, 0.0, -7.0, 0.0, -1.0, -5.0, 0.0)) && allOk;
	allOk = compare_uint16_t(uint(blockD[1].e.mD), 6u) && allOk;
	allOk = compare_u16vec2(uvec2(blockD[1].f), uvec2(7u, 7u)) && allOk;
	allOk = compare_mat4x3(blockD[2].e.mA, mat4x3(7.0, -7.0, -3.0, 6.0, -6.0, -4.0, -5.0, -9.0, -4.0, -7.0, -7.0, -9.0)) && allOk;
	allOk = compare_vec2((blockD[2].e.mB), vec2(0.0, -9.0)) && allOk;
	allOk = compare_mat3(blockD[2].e.mC, mat3(2.0, -4.0, -9.0, 3.0, 0.0, -6.0, -7.0, 7.0, -3.0)) && allOk;
	allOk = compare_uint16_t(uint(blockD[2].e.mD), 6u) && allOk;
	allOk = compare_u16vec2(uvec2(blockD[2].f), uvec2(6u, 9u)) && allOk;
	allOk = compare_mat2x3(blockE[0].h, mat2x3(6.0, -3.0, 4.0, 8.0, 6.0, 3.0)) && allOk;
	allOk = compare_int((blockE[0].j), -5) && allOk;
    if (allOk)
        ac_numPassed++;

	a = int16_t(-3);
	blockC.b[0] = float16_t(-9.0);
	blockC.b[1] = float16_t(-1.0);
	blockC.b[2] = float16_t(-1.0);
	blockC.b[3] = float16_t(-1.0);
	blockC.b[4] = float16_t(-7.0);
	blockC.b[5] = float16_t(2.0);
	blockD[0].d = u16vec2(uvec2(5u, 7u));
	blockD[1].d = u16vec2(uvec2(8u, 0u));
	blockD[2].d = u16vec2(uvec2(0u, 0u));
	blockE[0].h = (mat2x3(9.0, 1.0, -5.0, 7.0, -2.0, 8.0));
	blockE[0].i[0] = (mat3(1.0, 8.0, 6.0, 6.0, -3.0, 7.0, -5.0, 0.0, -2.0));
	blockE[0].j = (2);
}
#version 450
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
	lowp uvec3 a;
	mediump uvec4 b;
	lowp float c;
	highp uint d;
	bvec3 e;
} blockB;
layout(std430, binding = 2) readonly buffer BlockC
{
	i8vec3 f;
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	i8vec3 g[1];
	highp uint h;
	highp ivec2 i;
	lowp vec4 j;
	highp uvec4 k;
};
layout(std140, binding = 4) buffer BlockE
{
	mediump vec4 l;
	lowp vec3 m;
	bool n;
	u8vec2 o;
	bool p;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.b), uvec4(6u, 8u, 1u, 8u)) && allOk;
	allOk = compare_float((blockB.c), 9.0) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.f), ivec3(8, 1, 4294967294)) && allOk;
	allOk = compare_uint((h), 6u) && allOk;
	allOk = compare_vec4((j), vec4(0.0, 9.0, -6.0, 5.0)) && allOk;
	allOk = compare_vec4((blockE.l), vec4(5.0, 3.0, 3.0, -9.0)) && allOk;
	allOk = compare_vec3((blockE.m), vec3(4.0, 8.0, 5.0)) && allOk;
	allOk = compare_bool((blockE.n), false) && allOk;
	allOk = compare_u8vec2(uvec2(blockE.o), uvec2(3u, 8u)) && allOk;
	allOk = compare_bool((blockE.p), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec3(5u, 4u, 3u));
	blockB.b = (uvec4(2u, 1u, 8u, 0u));
	blockB.d = (9u);
	blockB.e = (bvec3(false, true, false));
	g[0] = i8vec3(ivec3(4294967289, 4294967288, 4294967293));
	i = (ivec2(5, -2));
	j = (vec4(-1.0, -4.0, -8.0, 2.0));
	blockE.l = (vec4(-9.0, -2.0, 0.0, 2.0));
	blockE.m = (vec3(6.0, -7.0, 3.0));
	blockE.o = u8vec2(uvec2(3u, 0u));
	blockE.p = (false);
}
#version 450
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
	uint8_t a;
	highp int b[3];
	mediump mat4 c;
	highp mat3x2 d;
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	u8vec2 e[7];
	i8vec4 f;
	u8vec3 g;
	bvec4 h;
	bvec4 i;
};
layout(std430, column_major, binding = 3) buffer BlockD
{
	int8_t j;
} blockD;
layout(std430, column_major, binding = 4) buffer BlockE
{
	highp uvec2 k;
	bvec3 l;
	i8vec4 m;
	lowp mat3x4 n;
	highp vec2 o;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(blockB.a), 8u) && allOk;
	allOk = compare_int((blockB.b[0]), 9) && allOk;
	allOk = compare_int((blockB.b[1]), 9) && allOk;
	allOk = compare_int((blockB.b[2]), -7) && allOk;
	allOk = compare_mat3x2(blockB.d, mat3x2(-3.0, 0.0, -1.0, -7.0, -7.0, 6.0)) && allOk;
	allOk = compare_i8vec4(ivec4(f), ivec4(1, 4294967288, 4294967287, 5)) && allOk;
	allOk = compare_u8vec3(uvec3(g), uvec3(0u, 4u, 0u)) && allOk;
	allOk = compare_bvec4((h), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec3((l), bvec3(true, true, false)) && allOk;
	allOk = compare_i8vec4(ivec4(m), ivec4(6, 4, 5, 3)) && allOk;
	allOk = compare_vec2((o), vec2(-6.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = uint8_t(9u);
	blockB.b[0] = (0);
	blockB.b[1] = (9);
	blockB.b[2] = (4);
	blockB.c = (mat4(1.0, -7.0, -4.0, -4.0, -6.0, -5.0, -2.0, 4.0, -2.0, 5.0, -9.0, -3.0, -1.0, -9.0, 1.0, 1.0));
	blockB.d = (mat3x2(7.0, 8.0, 9.0, -7.0, -1.0, -6.0));
	e[0] = u8vec2(uvec2(6u, 8u));
	e[1] = u8vec2(uvec2(5u, 8u));
	e[2] = u8vec2(uvec2(1u, 8u));
	e[3] = u8vec2(uvec2(3u, 7u));
	e[4] = u8vec2(uvec2(3u, 2u));
	e[5] = u8vec2(uvec2(6u, 7u));
	e[6] = u8vec2(uvec2(0u, 4u));
	f = i8vec4(ivec4(4294967293, 4294967289, 4294967295, 4294967291));
	g = u8vec3(uvec3(5u, 6u, 5u));
	h = (bvec4(false, false, false, false));
	i = (bvec4(false, false, true, true));
	blockD.j = int8_t(4294967295);
	k = (uvec2(4u, 7u));
	n = (mat3x4(9.0, 5.0, -5.0, -2.0, 1.0, 8.0, -2.0, -4.0, -5.0, 8.0, -8.0, -8.0));
	o = (vec2(6.0, 4.0));
}
#version 450
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
	u8vec4 a[];
};

bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(a[0]), uvec4(2u, 5u, 1u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(a[1]), uvec4(5u, 7u, 9u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(a[2]), uvec4(0u, 4u, 5u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(a[3]), uvec4(0u, 2u, 4u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(a[4]), uvec4(8u, 6u, 3u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(a[5]), uvec4(5u, 8u, 8u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(a[6]), uvec4(5u, 8u, 9u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = u8vec4(uvec4(6u, 8u, 4u, 7u));
	a[1] = u8vec4(uvec4(4u, 8u, 4u, 7u));
	a[2] = u8vec4(uvec4(8u, 6u, 6u, 8u));
	a[3] = u8vec4(uvec4(4u, 2u, 4u, 9u));
	a[4] = u8vec4(uvec4(2u, 5u, 6u, 6u));
	a[5] = u8vec4(uvec4(9u, 3u, 0u, 9u));
	a[6] = u8vec4(uvec4(5u, 7u, 7u, 7u));
}
#version 450
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
	mediump mat2x3 mA;
	highp mat3x2 mB[5];
	lowp ivec2 mC;
	highp ivec2 mD;
};
layout(std430, row_major, binding = 1) buffer BlockB
{
	lowp mat3x2 a;
	highp ivec2 b;
	int8_t c;
	int8_t d[];
} blockB;
layout(std140, row_major, binding = 2) buffer BlockC
{
	bvec4 e;
	highp uint f;
	sA g;
	bool h[];
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	u8vec2 i;
	bvec4 j;
	bool k;
	highp mat3x2 l[][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.b), ivec2(6, 4)) && allOk;
	allOk = compare_int8_t(int(blockB.c), 8) && allOk;
	allOk = compare_int8_t(int(blockB.d[0]), 4294967295) && allOk;
	allOk = compare_int8_t(int(blockB.d[1]), 4294967288) && allOk;
	allOk = compare_int8_t(int(blockB.d[2]), 4) && allOk;
	allOk = compare_int8_t(int(blockB.d[3]), 4294967287) && allOk;
	allOk = compare_int8_t(int(blockB.d[4]), 5) && allOk;
	allOk = compare_int8_t(int(blockB.d[5]), 3) && allOk;
	allOk = compare_int8_t(int(blockB.d[6]), 4294967287) && allOk;
	allOk = compare_int8_t(int(blockB.d[7]), 4294967291) && allOk;
	allOk = compare_bvec4((blockC.e), bvec4(true, true, true, false)) && allOk;
	allOk = compare_uint((blockC.f), 1u) && allOk;
	allOk = compare_u8vec2(uvec2(i), uvec2(8u, 6u)) && allOk;
	allOk = compare_bool((k), true) && allOk;
	allOk = compare_mat3x2(l[0][0], mat3x2(6.0, -8.0, 7.0, 2.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x2(l[0][1], mat3x2(6.0, -5.0, 4.0, -7.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat3x2(l[0][2], mat3x2(-9.0, -2.0, 5.0, 2.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat3x2(l[1][0], mat3x2(-4.0, 1.0, -4.0, 6.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat3x2(l[1][1], mat3x2(-2.0, 6.0, -7.0, 2.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(l[1][2], mat3x2(4.0, -1.0, 1.0, -5.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat3x2(l[2][0], mat3x2(-2.0, 9.0, 0.0, -4.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat3x2(l[2][1], mat3x2(5.0, 0.0, -2.0, 8.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x2(l[2][2], mat3x2(-1.0, 3.0, -3.0, -4.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(l[3][0], mat3x2(-2.0, 4.0, -1.0, -8.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3x2(l[3][1], mat3x2(-4.0, 4.0, -5.0, 2.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x2(l[3][2], mat3x2(-3.0, -5.0, 1.0, 9.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat3x2(l[4][0], mat3x2(-1.0, -6.0, -3.0, -1.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat3x2(l[4][1], mat3x2(6.0, -8.0, -4.0, 3.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat3x2(l[4][2], mat3x2(8.0, 8.0, 6.0, -9.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(l[5][0], mat3x2(8.0, -3.0, -8.0, -3.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(l[5][1], mat3x2(8.0, 8.0, -1.0, -7.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat3x2(l[5][2], mat3x2(-5.0, 0.0, -1.0, 6.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat3x2(l[6][0], mat3x2(3.0, 9.0, -8.0, -5.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat3x2(l[6][1], mat3x2(-9.0, -2.0, -8.0, -1.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3x2(l[6][2], mat3x2(-9.0, -6.0, -6.0, 7.0, 1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x2(8.0, 3.0, 2.0, -3.0, -4.0, 7.0));
	blockB.b = (ivec2(-3, 4));
	blockB.c = int8_t(3);
	blockC.e = (bvec4(false, false, true, false));
	blockC.f = (0u);
	blockC.h[0] = (true);
	blockC.h[1] = (false);
	blockC.h[2] = (false);
	blockC.h[3] = (false);
	blockC.h[4] = (true);
	i = u8vec2(uvec2(2u, 4u));
}
#version 450
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
	layout(offset = 0) mediump vec3 a[1];
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump vec2 b;
	layout(offset = 8) lowp vec2 c;
	layout(offset = 16) highp int d[1];
	layout(offset = 32) mediump uvec4 e;
	layout(offset = 48) lowp uvec2 f;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) lowp uvec3 g;
	layout(offset = 16) bvec3 h[1];
	layout(offset = 32) lowp uvec4 i;
	layout(offset = 48) lowp uint j;
};
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) mediump int k;
	layout(offset = 16) mediump ivec4 l;
	layout(offset = 32) mediump uvec2 m;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.a[0]), vec3(-6.0, 0.0, 9.0)) && allOk;
	allOk = compare_vec2((blockC.b), vec2(-4.0, 2.0)) && allOk;
	allOk = compare_vec2((blockC.c), vec2(9.0, -9.0)) && allOk;
	allOk = compare_int((blockC.d[0]), -7) && allOk;
	allOk = compare_uvec4((blockC.e), uvec4(3u, 1u, 4u, 7u)) && allOk;
	allOk = compare_uvec2((blockC.f), uvec2(8u, 3u)) && allOk;
	allOk = compare_uvec3((g), uvec3(3u, 9u, 1u)) && allOk;
	allOk = compare_bvec3((h[0]), bvec3(true, false, true)) && allOk;
	allOk = compare_uvec4((i), uvec4(2u, 7u, 5u, 2u)) && allOk;
	allOk = compare_uint((j), 8u) && allOk;
	allOk = compare_uvec2((blockE.m), uvec2(6u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (vec3(4.0, 8.0, -7.0));
	blockC.b = (vec2(-4.0, 1.0));
	blockC.c = (vec2(-2.0, -6.0));
	blockC.e = (uvec4(8u, 6u, 1u, 8u));
	g = (uvec3(3u, 8u, 2u));
	h[0] = (bvec3(false, true, false));
	i = (uvec4(5u, 1u, 6u, 1u));
	j = (8u);
	blockE.k = (6);
	blockE.l = (ivec4(-1, -2, 2, 0));
	blockE.m = (uvec2(3u, 8u));
}
#version 450
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
	layout(offset = 3) uint8_t b;
	layout(offset = 4) i8vec3 c;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) i8vec2 d;
	layout(offset = 4) mediump uint e;
	layout(offset = 8) lowp uint f;
} blockC;

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(a), uvec3(7u, 6u, 2u)) && allOk;
	allOk = compare_uint8_t(uint(b), 4u) && allOk;
	allOk = compare_i8vec3(ivec3(c), ivec3(4294967294, 4294967288, 4294967288)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.d), ivec2(4294967295, 7)) && allOk;
	allOk = compare_uint((blockC.f), 6u) && allOk;
    if (allOk)
        ac_numPassed++;

	a = u8vec3(uvec3(5u, 3u, 3u));
	c = i8vec3(ivec3(4294967287, 4294967288, 5));
	blockC.d = i8vec2(ivec2(8, 4294967288));
	blockC.e = (8u);
	blockC.f = (7u);
}
#version 450
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

layout(std140, column_major, binding = 1) readonly buffer Block
{
	lowp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var, mat4(7.0, -3.0, -9.0, -7.0, 4.0, 5.0, 2.0, -6.0, -8.0, -1.0, -2.0, -5.0, -8.0, -7.0, 0.0, -4.0)) && allOk;
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
	allOk = compare_mat3x4(var, mat3x4(8.0, -8.0, -2.0, -6.0, -3.0, 1.0, 4.0, -6.0, 6.0, 8.0, -7.0, -4.0)) && allOk;
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
	highp uvec2 var;
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((var), uvec2(2u, 8u)) && allOk;
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
	highp mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], -9.0) && allOk;
	allOk = compare_float(var[1][0], 7.0) && allOk;
	allOk = compare_float(var[1][1], 7.0) && allOk;
	allOk = compare_vec2(var[0], vec2(1.0, -9.0)) && allOk;
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

layout(std430, column_major, binding = 1) readonly buffer Block
{
	mediump mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var, mat2x3(0.0, -7.0, -2.0, 6.0, 8.0, 5.0)) && allOk;
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
	mediump mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -6.0) && allOk;
	allOk = compare_float(var[0][1], 5.0) && allOk;
	allOk = compare_float(var[0][2], -7.0) && allOk;
	allOk = compare_float(var[0][3], 5.0) && allOk;
	allOk = compare_float(var[1][0], 2.0) && allOk;
	allOk = compare_float(var[1][1], -6.0) && allOk;
	allOk = compare_float(var[1][2], 7.0) && allOk;
	allOk = compare_float(var[1][3], 8.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-6.0, 5.0, -7.0, 5.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(2.0, -6.0, 7.0, 8.0)) && allOk;
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
	mediump mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var, mat3x2(-2.0, 4.0, 1.0, -8.0, 7.0, -5.0)) && allOk;
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
	highp mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var, mat4x3(-4.0, 2.0, 6.0, -2.0, -6.0, -6.0, 8.0, 4.0, -1.0, -1.0, 9.0, 7.0)) && allOk;
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
	i8vec3 var;
};

bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(var), ivec3(4294967295, 4294967290, 1)) && allOk;
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
	u16vec4 var;
};

bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(var), uvec4(6u, 0u, 8u, 3u)) && allOk;
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
	highp ivec4 var;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((padding), 5) && allOk;
	allOk = compare_ivec4((var), ivec4(-9, -6, -4, 1)) && allOk;
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
	highp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -6.0) && allOk;
	allOk = compare_mat3x2(var, mat3x2(-5.0, -4.0, -5.0, 2.0, -2.0, -3.0)) && allOk;
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
	mediump mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -9.0) && allOk;
	allOk = compare_float(var[0][0], 5.0) && allOk;
	allOk = compare_float(var[0][1], 6.0) && allOk;
	allOk = compare_float(var[1][0], -1.0) && allOk;
	allOk = compare_float(var[1][1], 8.0) && allOk;
	allOk = compare_float(var[2][0], 2.0) && allOk;
	allOk = compare_float(var[2][1], 0.0) && allOk;
	allOk = compare_vec2(var[0], vec2(5.0, 6.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-1.0, 8.0)) && allOk;
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

layout(std140, column_major, binding = 1) readonly buffer Block
{
	highp mat3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0], mat3(-1.0, 2.0, -7.0, -6.0, 0.0, 4.0, -7.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(-9.0, -8.0, 6.0, 6.0, 6.0, -3.0, -6.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(3.0, 8.0, 0.0, -4.0, -4.0, 3.0, 9.0, 9.0, 0.0)) && allOk;
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

layout(std140, binding = 1) readonly buffer Block
{
	f16vec2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(var[0]), vec2(-6.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1]), vec2(1.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2]), vec2(6.0, 3.0)) && allOk;
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

layout(std430, row_major, binding = 1) readonly buffer Block
{
	highp mat3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0], mat3(-8.0, -9.0, -7.0, -7.0, 8.0, 7.0, 4.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(5.0, -4.0, 7.0, -4.0, -3.0, 8.0, 7.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(1.0, 6.0, 8.0, -9.0, -1.0, 8.0, 8.0, 3.0, -1.0)) && allOk;
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
	highp mat4x2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0], mat4x2(0.0, 6.0, -3.0, 7.0, 1.0, -8.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(2.0, -3.0, -5.0, 5.0, 5.0, 1.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(1.0, 1.0, -2.0, -3.0, -9.0, 3.0, 9.0, -7.0)) && allOk;
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
	u16vec3 var[3];
};

bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(var[0]), uvec3(1u, 0u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1]), uvec3(9u, 0u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2]), uvec3(7u, 1u, 1u)) && allOk;
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
	uint16_t var[];
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(var[0]), 9u) && allOk;
	allOk = compare_uint16_t(uint(var[1]), 5u) && allOk;
	allOk = compare_uint16_t(uint(var[2]), 4u) && allOk;
	allOk = compare_uint16_t(uint(var[3]), 1u) && allOk;
	allOk = compare_uint16_t(uint(var[4]), 0u) && allOk;
	allOk = compare_uint16_t(uint(var[5]), 9u) && allOk;
	allOk = compare_uint16_t(uint(var[6]), 2u) && allOk;
	allOk = compare_uint16_t(uint(var[7]), 0u) && allOk;
	allOk = compare_uint16_t(uint(var[8]), 6u) && allOk;
	allOk = compare_uint16_t(uint(var[9]), 9u) && allOk;
	allOk = compare_uint16_t(uint(var[10]), 8u) && allOk;
	allOk = compare_uint16_t(uint(var[11]), 1u) && allOk;
	allOk = compare_uint16_t(uint(var[12]), 7u) && allOk;
	allOk = compare_uint16_t(uint(var[13]), 8u) && allOk;
	allOk = compare_uint16_t(uint(var[14]), 2u) && allOk;
	allOk = compare_uint16_t(uint(var[15]), 7u) && allOk;
	allOk = compare_uint16_t(uint(var[16]), 1u) && allOk;
	allOk = compare_uint16_t(uint(var[17]), 0u) && allOk;
	allOk = compare_uint16_t(uint(var[18]), 8u) && allOk;
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
	highp mat3 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0], mat3(-6.0, 3.0, -6.0, -8.0, -3.0, -9.0, -1.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(-4.0, 5.0, 8.0, 1.0, 3.0, 0.0, -1.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(9.0, 4.0, 0.0, 1.0, -7.0, 1.0, 3.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3(var[3], mat3(-2.0, -2.0, 5.0, 7.0, -9.0, -1.0, 5.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(var[4], mat3(7.0, 3.0, -6.0, 3.0, 0.0, 1.0, 6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat3(var[5], mat3(-7.0, 6.0, -6.0, 9.0, -3.0, 2.0, 4.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3(var[6], mat3(6.0, 3.0, 3.0, 5.0, 7.0, -9.0, 3.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3(var[7], mat3(7.0, 3.0, 7.0, 3.0, 4.0, -7.0, 5.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat3(var[8], mat3(-5.0, 0.0, 3.0, -9.0, -4.0, 5.0, 3.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3(var[9], mat3(0.0, 7.0, 7.0, 1.0, -5.0, 4.0, 2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3(var[10], mat3(-5.0, -9.0, 2.0, 7.0, 8.0, 5.0, 7.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3(var[11], mat3(8.0, -3.0, 8.0, 9.0, -5.0, 8.0, -5.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat3(var[12], mat3(5.0, -7.0, 2.0, -4.0, -1.0, -2.0, 2.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3(var[13], mat3(5.0, -7.0, 6.0, 5.0, 2.0, -2.0, 5.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3(var[14], mat3(1.0, -3.0, 4.0, 0.0, -1.0, 8.0, 6.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3(var[15], mat3(2.0, 7.0, -2.0, 3.0, 3.0, -2.0, 9.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3(var[16], mat3(9.0, 4.0, -5.0, 1.0, 0.0, -1.0, -5.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3(var[17], mat3(9.0, 4.0, -9.0, 4.0, 7.0, -5.0, 6.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat3(var[18], mat3(-3.0, -5.0, 8.0, -6.0, -4.0, -4.0, 7.0, -9.0, -8.0)) && allOk;
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
	highp mat4x2 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0], mat4x2(-7.0, 1.0, 9.0, 3.0, -9.0, -1.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(-9.0, 6.0, 5.0, -8.0, 8.0, 9.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(4.0, 1.0, -1.0, -5.0, 5.0, -9.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[3], mat4x2(-2.0, -2.0, -9.0, -2.0, -2.0, 8.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[4], mat4x2(-8.0, 6.0, -4.0, 7.0, 2.0, 3.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[5], mat4x2(7.0, 3.0, 5.0, -2.0, 7.0, 1.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[6], mat4x2(-5.0, -9.0, 1.0, -6.0, 3.0, -3.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[7], mat4x2(4.0, -4.0, -1.0, 4.0, 0.0, -4.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[8], mat4x2(-7.0, 4.0, 5.0, 4.0, -5.0, 8.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[9], mat4x2(-7.0, 5.0, -2.0, -3.0, 7.0, 4.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[10], mat4x2(-4.0, 7.0, 2.0, 3.0, -7.0, -8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[11], mat4x2(-1.0, -8.0, -8.0, 4.0, 6.0, 8.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[12], mat4x2(3.0, -1.0, -8.0, -1.0, -7.0, -8.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[13], mat4x2(0.0, -8.0, -7.0, 7.0, 3.0, 7.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[14], mat4x2(-7.0, 7.0, -7.0, -4.0, -2.0, -5.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[15], mat4x2(3.0, -9.0, 6.0, -8.0, 0.0, 5.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[16], mat4x2(-2.0, 0.0, 9.0, -8.0, 0.0, 5.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[17], mat4x2(9.0, 1.0, 2.0, -6.0, -9.0, -9.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[18], mat4x2(-8.0, 9.0, -5.0, -6.0, -1.0, 1.0, -8.0, 7.0)) && allOk;
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
	highp vec4 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((var[0]), vec4(-5.0, 4.0, -4.0, 6.0)) && allOk;
	allOk = compare_vec4((var[1]), vec4(1.0, 4.0, 8.0, 7.0)) && allOk;
	allOk = compare_vec4((var[2]), vec4(2.0, -4.0, 3.0, -8.0)) && allOk;
	allOk = compare_vec4((var[3]), vec4(-3.0, -3.0, -6.0, -4.0)) && allOk;
	allOk = compare_vec4((var[4]), vec4(-1.0, 0.0, -8.0, -8.0)) && allOk;
	allOk = compare_vec4((var[5]), vec4(7.0, 1.0, 8.0, -8.0)) && allOk;
	allOk = compare_vec4((var[6]), vec4(6.0, 9.0, -5.0, -1.0)) && allOk;
	allOk = compare_vec4((var[7]), vec4(8.0, -5.0, -7.0, 0.0)) && allOk;
	allOk = compare_vec4((var[8]), vec4(-7.0, 2.0, -6.0, 6.0)) && allOk;
	allOk = compare_vec4((var[9]), vec4(-1.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_vec4((var[10]), vec4(8.0, 1.0, 8.0, 2.0)) && allOk;
	allOk = compare_vec4((var[11]), vec4(3.0, -4.0, 2.0, 1.0)) && allOk;
	allOk = compare_vec4((var[12]), vec4(-1.0, 3.0, 2.0, -5.0)) && allOk;
	allOk = compare_vec4((var[13]), vec4(9.0, 1.0, -6.0, 3.0)) && allOk;
	allOk = compare_vec4((var[14]), vec4(0.0, 6.0, 1.0, -9.0)) && allOk;
	allOk = compare_vec4((var[15]), vec4(6.0, -7.0, 0.0, 0.0)) && allOk;
	allOk = compare_vec4((var[16]), vec4(8.0, -6.0, 5.0, -4.0)) && allOk;
	allOk = compare_vec4((var[17]), vec4(5.0, -5.0, -2.0, -4.0)) && allOk;
	allOk = compare_vec4((var[18]), vec4(6.0, -4.0, -2.0, -7.0)) && allOk;
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
	highp mat3x4 var[];
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
	allOk = compare_mat3x4(var[3], mat3x4(-9.0, 6.0, 1.0, 3.0, -1.0, 8.0, -8.0, 6.0, -4.0, 9.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[4], mat3x4(6.0, 2.0, 4.0, -4.0, -1.0, -1.0, 6.0, 3.0, 5.0, -7.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[5], mat3x4(6.0, 4.0, -9.0, 9.0, 0.0, -6.0, -5.0, 8.0, 5.0, -9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[6], mat3x4(8.0, 9.0, -9.0, -3.0, 9.0, -7.0, 7.0, 3.0, 7.0, -5.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[7], mat3x4(-7.0, 2.0, 6.0, -9.0, -3.0, -3.0, 7.0, -4.0, 6.0, -9.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[8], mat3x4(-3.0, -4.0, 1.0, -5.0, 9.0, -1.0, 0.0, 0.0, 1.0, 9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[9], mat3x4(4.0, 7.0, 7.0, -7.0, -1.0, 1.0, 0.0, 6.0, 5.0, -6.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[10], mat3x4(9.0, -4.0, 1.0, -5.0, 8.0, -9.0, -6.0, 4.0, 2.0, -7.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[11], mat3x4(-7.0, -3.0, -6.0, 4.0, 5.0, -8.0, -6.0, 9.0, -3.0, 9.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[12], mat3x4(-7.0, -9.0, 9.0, 4.0, 9.0, 5.0, -2.0, -3.0, 8.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[13], mat3x4(1.0, 1.0, -3.0, 0.0, -6.0, -1.0, -5.0, -8.0, -9.0, -1.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[14], mat3x4(9.0, 0.0, -8.0, 0.0, -8.0, 1.0, -3.0, 3.0, -4.0, -9.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[15], mat3x4(-4.0, -3.0, 7.0, 1.0, -8.0, -8.0, -5.0, 8.0, -6.0, 9.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[16], mat3x4(-9.0, -2.0, 7.0, -7.0, 5.0, -9.0, 2.0, 8.0, 1.0, 1.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[17], mat3x4(-1.0, -3.0, 3.0, -5.0, 9.0, -5.0, 3.0, 9.0, 7.0, 0.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[18], mat3x4(8.0, -7.0, 0.0, 6.0, 2.0, -6.0, 7.0, -8.0, -5.0, 4.0, -3.0, 7.0)) && allOk;
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
	u8vec2 var[];
};

bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(var[0]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1]), uvec2(7u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2]), uvec2(4u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[3]), uvec2(7u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[4]), uvec2(9u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[5]), uvec2(7u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[6]), uvec2(8u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[7]), uvec2(6u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[8]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[9]), uvec2(1u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[10]), uvec2(2u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[11]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[12]), uvec2(8u, 5u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[13]), uvec2(6u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[14]), uvec2(2u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[15]), uvec2(0u, 6u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[16]), uvec2(2u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[17]), uvec2(1u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[18]), uvec2(6u, 7u)) && allOk;
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

layout(std140, row_major, buffer_reference) buffer Block
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
	allOk = compare_float(block.var[0][0], 2.0) && allOk;
	allOk = compare_float(block.var[0][1], 2.0) && allOk;
	allOk = compare_float(block.var[1][0], 9.0) && allOk;
	allOk = compare_float(block.var[1][1], 8.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(2.0, 2.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2(2.0, -5.0, 3.0, 0.0));
}
#version 450
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
	allOk = compare_mat4(block.var, mat4(-5.0, 5.0, 6.0, -3.0, 3.0, 8.0, -6.0, 6.0, 4.0, 6.0, 4.0, 6.0, 4.0, 5.0, -2.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4(-8.0, 8.0, -7.0, -7.0, 5.0, 9.0, -3.0, -7.0, 6.0, -4.0, -3.0, 0.0, -4.0, -5.0, 5.0, 0.0));
}
#version 450
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
	float16_t var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(block.var), -7.0) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = float16_t(-8.0);
}
#version 450
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
	allOk = compare_float(block.var[0][0], 0.0) && allOk;
	allOk = compare_float(block.var[0][1], -1.0) && allOk;
	allOk = compare_float(block.var[0][2], 7.0) && allOk;
	allOk = compare_float(block.var[0][3], 9.0) && allOk;
	allOk = compare_float(block.var[1][0], -3.0) && allOk;
	allOk = compare_float(block.var[1][1], -5.0) && allOk;
	allOk = compare_float(block.var[1][2], 7.0) && allOk;
	allOk = compare_float(block.var[1][3], -1.0) && allOk;
	allOk = compare_float(block.var[2][0], 4.0) && allOk;
	allOk = compare_float(block.var[2][1], -2.0) && allOk;
	allOk = compare_float(block.var[2][2], 9.0) && allOk;
	allOk = compare_float(block.var[2][3], 9.0) && allOk;
	allOk = compare_float(block.var[3][0], 7.0) && allOk;
	allOk = compare_float(block.var[3][1], -5.0) && allOk;
	allOk = compare_float(block.var[3][2], 0.0) && allOk;
	allOk = compare_float(block.var[3][3], -6.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(0.0, -1.0, 7.0, 9.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-3.0, -5.0, 7.0, -1.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(4.0, -2.0, 9.0, 9.0)) && allOk;
	allOk = compare_vec4(block.var[3], vec4(7.0, -5.0, 0.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4(1.0, -3.0, -8.0, 1.0, 3.0, -4.0, -4.0, -4.0, -6.0, -6.0, 9.0, 1.0, 1.0, 3.0, 2.0, -6.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -8.0) && allOk;
	allOk = compare_float(block.var[0][1], 1.0) && allOk;
	allOk = compare_float(block.var[0][2], 4.0) && allOk;
	allOk = compare_float(block.var[1][0], -2.0) && allOk;
	allOk = compare_float(block.var[1][1], 8.0) && allOk;
	allOk = compare_float(block.var[1][2], -8.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-8.0, 1.0, 4.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-2.0, 8.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(-3.0, -5.0, -7.0));
	block.var[1] = (vec3(-3.0, 1.0, -6.0));
}
#version 450
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
	f16vec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(block.var), vec4(-8.0, -9.0, 9.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = f16vec4(vec4(9.0, -6.0, 2.0, -8.0));
}
#version 450
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
	lowp ivec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((block.padding), -1) && allOk;
	allOk = compare_ivec3((block.var), ivec3(-8, 1, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (5);
	block.var = (ivec3(-9, -8, 1));
}
#version 450
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
	lowp uvec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((block.padding), 9u) && allOk;
	allOk = compare_uvec3((block.var), uvec3(0u, 0u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (7u);
	block.var = (uvec3(4u, 8u, 4u));
}
#version 450
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
	lowp uvec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((block.padding), 2u) && allOk;
	allOk = compare_uvec4((block.var), uvec4(4u, 5u, 5u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (6u);
	block.var = (uvec4(6u, 2u, 2u, 3u));
}
#version 450
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
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_float(block.var[0][0], -2.0) && allOk;
	allOk = compare_float(block.var[0][1], 8.0) && allOk;
	allOk = compare_float(block.var[0][2], -8.0) && allOk;
	allOk = compare_float(block.var[0][3], -4.0) && allOk;
	allOk = compare_float(block.var[1][0], 5.0) && allOk;
	allOk = compare_float(block.var[1][1], 8.0) && allOk;
	allOk = compare_float(block.var[1][2], -5.0) && allOk;
	allOk = compare_float(block.var[1][3], -2.0) && allOk;
	allOk = compare_float(block.var[2][0], -9.0) && allOk;
	allOk = compare_float(block.var[2][1], 3.0) && allOk;
	allOk = compare_float(block.var[2][2], -9.0) && allOk;
	allOk = compare_float(block.var[2][3], -2.0) && allOk;
	allOk = compare_float(block.var[3][0], -5.0) && allOk;
	allOk = compare_float(block.var[3][1], 0.0) && allOk;
	allOk = compare_float(block.var[3][2], 1.0) && allOk;
	allOk = compare_float(block.var[3][3], 5.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-2.0, 8.0, -8.0, -4.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(5.0, 8.0, -5.0, -2.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(-9.0, 3.0, -9.0, -2.0)) && allOk;
	allOk = compare_vec4(block.var[3], vec4(-5.0, 0.0, 1.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-4.0);
	block.var[0] = (vec4(6.0, -6.0, 8.0, -4.0));
	block.var[1] = (vec4(-5.0, 6.0, 5.0, 5.0));
	block.var[2] = (vec4(3.0, 2.0, -5.0, -7.0));
	block.var[3] = (vec4(-3.0, -1.0, -1.0, 0.0));
}
#version 450
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
	allOk = compare_float((block.padding), 1.0) && allOk;
	allOk = compare_float(block.var[0][0], 9.0) && allOk;
	allOk = compare_float(block.var[0][1], -8.0) && allOk;
	allOk = compare_float(block.var[0][2], 5.0) && allOk;
	allOk = compare_float(block.var[1][0], 9.0) && allOk;
	allOk = compare_float(block.var[1][1], 8.0) && allOk;
	allOk = compare_float(block.var[1][2], 7.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(9.0, -8.0, 5.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(9.0, 8.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-7.0);
	block.var[0] = (vec3(2.0, 1.0, 8.0));
	block.var[1] = (vec3(3.0, 9.0, -8.0));
}
#version 450
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
	allOk = compare_float((block.padding), 1.0) && allOk;
	allOk = compare_float(block.var[0][0], -6.0) && allOk;
	allOk = compare_float(block.var[0][1], -4.0) && allOk;
	allOk = compare_float(block.var[0][2], 5.0) && allOk;
	allOk = compare_float(block.var[1][0], 0.0) && allOk;
	allOk = compare_float(block.var[1][1], -1.0) && allOk;
	allOk = compare_float(block.var[1][2], 1.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-6.0, -4.0, 5.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(0.0, -1.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (3.0);
	block.var = (mat2x3(0.0, 3.0, 5.0, 3.0, -5.0, -5.0));
}
#version 450
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
	allOk = compare_float((block.padding), -8.0) && allOk;
	allOk = compare_mat4x2(block.var, mat4x2(7.0, -1.0, 7.0, 8.0, -6.0, 1.0, 4.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-9.0);
	block.var[0] = (vec2(9.0, 6.0));
	block.var[1] = (vec2(6.0, -5.0));
	block.var[2] = (vec2(-4.0, -3.0));
	block.var[3] = (vec2(-2.0, 4.0));
}
#version 450
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
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_mat4x2(block.var, mat4x2(-2.0, 4.0, -3.0, -4.0, 2.0, -8.0, -5.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-6.0);
	block.var = (mat4x2(0.0, -8.0, -8.0, 5.0, -8.0, 3.0, -9.0, 5.0));
}
#version 450
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
	allOk = compare_float((block.padding), 4.0) && allOk;
	allOk = compare_float(block.var[0][0], 0.0) && allOk;
	allOk = compare_float(block.var[0][1], 2.0) && allOk;
	allOk = compare_float(block.var[1][0], -9.0) && allOk;
	allOk = compare_float(block.var[1][1], -6.0) && allOk;
	allOk = compare_float(block.var[2][0], 9.0) && allOk;
	allOk = compare_float(block.var[2][1], -5.0) && allOk;
	allOk = compare_float(block.var[3][0], -6.0) && allOk;
	allOk = compare_float(block.var[3][1], -5.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(0.0, 2.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-9.0, -6.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(9.0, -5.0)) && allOk;
	allOk = compare_vec2(block.var[3], vec2(-6.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (3.0);
	block.var[0] = (vec2(2.0, 2.0));
	block.var[1] = (vec2(-4.0, 5.0));
	block.var[2] = (vec2(-4.0, -3.0));
	block.var[3] = (vec2(-3.0, 2.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0], mat2(-5.0, -2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(-2.0, -4.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(-9.0, 9.0, 7.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2(-2.0, -8.0, -7.0, 9.0));
	block.var[1] = (mat2(2.0, 2.0, -4.0, -5.0));
	block.var[2] = (mat2(-1.0, -4.0, 0.0, -1.0));
}
#version 450
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
	highp mat4x3 var[3];
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
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4x3(6.0, -7.0, 0.0, 3.0, -1.0, -9.0, -7.0, -5.0, 8.0, 0.0, 1.0, 5.0));
	block.var[1] = (mat4x3(7.0, 1.0, 5.0, 7.0, -8.0, 4.0, 2.0, -8.0, -8.0, 3.0, -6.0, -5.0));
	block.var[2] = (mat4x3(5.0, -7.0, 8.0, -7.0, -3.0, -4.0, -9.0, -9.0, -6.0, 5.0, -8.0, 1.0));
}
#version 450
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

layout(scalar, column_major, buffer_reference) buffer Block
{
	float padding;
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
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_mat2x4(block.var[0], mat2x4(4.0, 3.0, 6.0, 3.0, -7.0, 6.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(4.0, 0.0, 9.0, -2.0, 9.0, -9.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(-7.0, 0.0, 6.0, -6.0, 9.0, 0.0, 4.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-5.0);
	block.var[0] = (mat2x4(-7.0, -7.0, 0.0, -1.0, -9.0, 5.0, -5.0, 0.0));
	block.var[1] = (mat2x4(1.0, 8.0, 9.0, 2.0, 4.0, 5.0, 5.0, 3.0));
	block.var[2] = (mat2x4(6.0, 2.0, 7.0, -1.0, -8.0, 7.0, -7.0, -8.0));
}
#version 450
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
	bvec4 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((block.var[0]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((block.var[1]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((block.var[2]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((block.var[3]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((block.var[4]), bvec4(false, false, true, true)) && allOk;
	allOk = compare_bvec4((block.var[5]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec4((block.var[6]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((block.var[7]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((block.var[8]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((block.var[9]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((block.var[10]), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec4((block.var[11]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((block.var[12]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((block.var[13]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((block.var[14]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((block.var[15]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((block.var[16]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((block.var[17]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((block.var[18]), bvec4(false, true, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (bvec4(true, true, true, false));
	block.var[1] = (bvec4(true, false, false, false));
	block.var[2] = (bvec4(false, true, true, true));
	block.var[3] = (bvec4(true, true, true, false));
	block.var[4] = (bvec4(true, false, true, false));
	block.var[5] = (bvec4(true, false, false, true));
	block.var[6] = (bvec4(false, true, true, false));
	block.var[7] = (bvec4(true, true, true, false));
	block.var[8] = (bvec4(false, false, true, true));
	block.var[9] = (bvec4(true, false, true, false));
	block.var[10] = (bvec4(true, true, true, true));
	block.var[11] = (bvec4(false, true, false, true));
	block.var[12] = (bvec4(false, true, false, true));
	block.var[13] = (bvec4(true, true, true, false));
	block.var[14] = (bvec4(false, true, false, false));
	block.var[15] = (bvec4(true, false, false, true));
	block.var[16] = (bvec4(true, true, true, false));
	block.var[17] = (bvec4(true, false, false, false));
	block.var[18] = (bvec4(false, false, true, true));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0], mat2x4(-7.0, -1.0, -3.0, -6.0, -2.0, 4.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(4.0, 9.0, -2.0, -3.0, 3.0, 3.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(9.0, 2.0, -4.0, 1.0, -2.0, -8.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[3], mat2x4(9.0, 4.0, 2.0, -6.0, -7.0, -3.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[4], mat2x4(7.0, 2.0, -5.0, -2.0, -1.0, 5.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[5], mat2x4(-1.0, -6.0, 3.0, -5.0, -6.0, 5.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[6], mat2x4(-7.0, 8.0, 3.0, 6.0, 7.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[7], mat2x4(9.0, -4.0, -9.0, 5.0, -4.0, 9.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[8], mat2x4(-5.0, 9.0, 8.0, 9.0, -6.0, 0.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[9], mat2x4(0.0, 4.0, 4.0, 1.0, 6.0, -8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[10], mat2x4(1.0, 1.0, -9.0, -7.0, 3.0, 9.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[11], mat2x4(4.0, 7.0, -6.0, 2.0, 0.0, -3.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[12], mat2x4(4.0, 7.0, -6.0, -6.0, -4.0, -1.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[13], mat2x4(-6.0, 0.0, -1.0, 1.0, -2.0, -5.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[14], mat2x4(-1.0, 7.0, 8.0, 8.0, -5.0, -8.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[15], mat2x4(-7.0, 9.0, -1.0, -6.0, 3.0, 9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[16], mat2x4(6.0, -8.0, -5.0, 4.0, -4.0, -5.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[17], mat2x4(-1.0, -3.0, -8.0, 8.0, 8.0, -2.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[18], mat2x4(-2.0, -2.0, -2.0, 9.0, -2.0, 3.0, 7.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec4(4.0, -6.0, -9.0, -3.0));
	block.var[0][1] = (vec4(5.0, 1.0, -7.0, 1.0));
	block.var[1][0] = (vec4(-7.0, -4.0, 1.0, 9.0));
	block.var[1][1] = (vec4(-1.0, -2.0, 2.0, 4.0));
	block.var[2][0] = (vec4(-1.0, -9.0, -6.0, 6.0));
	block.var[2][1] = (vec4(-7.0, 5.0, 8.0, 4.0));
	block.var[3][0] = (vec4(-8.0, 1.0, 8.0, -9.0));
	block.var[3][1] = (vec4(-7.0, -8.0, 4.0, -2.0));
	block.var[4][0] = (vec4(5.0, 5.0, -2.0, 2.0));
	block.var[4][1] = (vec4(-6.0, 0.0, 8.0, 8.0));
	block.var[5][0] = (vec4(-6.0, -5.0, 0.0, 5.0));
	block.var[5][1] = (vec4(-1.0, 2.0, 3.0, 0.0));
	block.var[6][0] = (vec4(1.0, -8.0, 7.0, 2.0));
	block.var[6][1] = (vec4(5.0, -8.0, 3.0, 8.0));
	block.var[7][0] = (vec4(1.0, 5.0, 3.0, -5.0));
	block.var[7][1] = (vec4(5.0, -8.0, 3.0, 1.0));
	block.var[8][0] = (vec4(3.0, 9.0, -9.0, -1.0));
	block.var[8][1] = (vec4(5.0, 7.0, 6.0, 7.0));
	block.var[9][0] = (vec4(7.0, -3.0, 4.0, 4.0));
	block.var[9][1] = (vec4(-9.0, -1.0, -2.0, -1.0));
	block.var[10][0] = (vec4(-1.0, 7.0, -2.0, 3.0));
	block.var[10][1] = (vec4(7.0, -2.0, -4.0, -8.0));
	block.var[11][0] = (vec4(2.0, 7.0, 2.0, -9.0));
	block.var[11][1] = (vec4(-2.0, -1.0, 1.0, -4.0));
	block.var[12][0] = (vec4(-7.0, 4.0, -9.0, 1.0));
	block.var[12][1] = (vec4(0.0, -5.0, 6.0, -3.0));
	block.var[13][0] = (vec4(-9.0, -4.0, 8.0, -1.0));
	block.var[13][1] = (vec4(7.0, -1.0, -9.0, -2.0));
	block.var[14][0] = (vec4(-9.0, -6.0, -1.0, -3.0));
	block.var[14][1] = (vec4(6.0, -6.0, 2.0, 1.0));
	block.var[15][0] = (vec4(-3.0, -3.0, -5.0, -1.0));
	block.var[15][1] = (vec4(4.0, 0.0, -9.0, -1.0));
	block.var[16][0] = (vec4(1.0, -2.0, 4.0, -4.0));
	block.var[16][1] = (vec4(3.0, -9.0, 0.0, -4.0));
	block.var[17][0] = (vec4(-7.0, 7.0, 9.0, -2.0));
	block.var[17][1] = (vec4(5.0, -3.0, -5.0, 5.0));
	block.var[18][0] = (vec4(-2.0, 4.0, 0.0, -2.0));
	block.var[18][1] = (vec4(9.0, -8.0, 7.0, 0.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0], mat4x3(-7.0, 1.0, 0.0, 0.0, -7.0, 2.0, 5.0, 0.0, 3.0, 2.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1], mat4x3(-7.0, -5.0, 2.0, 0.0, -1.0, -5.0, 5.0, 5.0, 9.0, -7.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[2], mat4x3(3.0, 6.0, -7.0, 7.0, 8.0, 6.0, -7.0, -8.0, -5.0, -9.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[3], mat4x3(-7.0, -7.0, 7.0, 2.0, -5.0, 3.0, 2.0, 0.0, 8.0, -1.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[4], mat4x3(-8.0, 6.0, 2.0, -5.0, -7.0, -7.0, -4.0, -9.0, 7.0, 3.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[5], mat4x3(-7.0, 7.0, 6.0, 3.0, 4.0, 5.0, -2.0, 3.0, 8.0, -7.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[6], mat4x3(0.0, 7.0, 1.0, -2.0, 9.0, -5.0, -3.0, 1.0, -6.0, 6.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[7], mat4x3(9.0, 8.0, 5.0, 4.0, 7.0, -1.0, 6.0, -6.0, 2.0, 8.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[8], mat4x3(0.0, 6.0, -8.0, -4.0, -8.0, 8.0, -5.0, 7.0, 3.0, 9.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[9], mat4x3(6.0, -3.0, 0.0, -3.0, 2.0, -8.0, 6.0, 5.0, -2.0, 2.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[10], mat4x3(-7.0, 4.0, 5.0, -8.0, -1.0, -2.0, -8.0, -4.0, 2.0, 8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[11], mat4x3(4.0, -1.0, 3.0, 3.0, -3.0, 4.0, -6.0, -5.0, 1.0, 4.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[12], mat4x3(8.0, -2.0, 5.0, 8.0, 5.0, -1.0, 2.0, -4.0, -9.0, -5.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[13], mat4x3(-2.0, 7.0, -4.0, 9.0, 4.0, -1.0, -2.0, -8.0, 7.0, 9.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[14], mat4x3(6.0, 1.0, 9.0, 3.0, -6.0, -4.0, 9.0, 3.0, -7.0, -3.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[15], mat4x3(2.0, -4.0, -5.0, 2.0, -6.0, -3.0, -7.0, 2.0, 6.0, 4.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[16], mat4x3(7.0, 2.0, -9.0, -6.0, -7.0, -2.0, -2.0, 6.0, -5.0, -9.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[17], mat4x3(-4.0, 1.0, -3.0, -3.0, -1.0, -5.0, -5.0, 7.0, -9.0, 6.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[18], mat4x3(8.0, -3.0, 5.0, 4.0, -3.0, 7.0, -7.0, -8.0, -9.0, 2.0, 6.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4x3(7.0, 8.0, 8.0, -3.0, -9.0, 2.0, -6.0, 0.0, -4.0, -3.0, 4.0, -8.0));
	block.var[1] = (mat4x3(4.0, -2.0, 2.0, 8.0, 4.0, -1.0, -8.0, -6.0, -4.0, 9.0, -2.0, 1.0));
	block.var[2] = (mat4x3(-7.0, -4.0, -4.0, -1.0, 7.0, -6.0, 4.0, 6.0, 7.0, -9.0, -8.0, 3.0));
	block.var[3] = (mat4x3(-6.0, -5.0, 6.0, -2.0, -7.0, 5.0, 4.0, -6.0, -4.0, -7.0, 2.0, -7.0));
	block.var[4] = (mat4x3(-6.0, 5.0, -6.0, 9.0, -8.0, -5.0, -2.0, -8.0, -9.0, -8.0, -1.0, 2.0));
	block.var[5] = (mat4x3(-7.0, -2.0, 1.0, 0.0, 8.0, -7.0, 0.0, 0.0, 7.0, 0.0, -4.0, -7.0));
	block.var[6] = (mat4x3(-9.0, -7.0, 2.0, 2.0, 6.0, 9.0, 9.0, 5.0, -3.0, -4.0, -1.0, -5.0));
	block.var[7] = (mat4x3(-8.0, -4.0, -2.0, 7.0, 3.0, -9.0, 8.0, 1.0, -1.0, -7.0, -6.0, 2.0));
	block.var[8] = (mat4x3(-3.0, -7.0, 7.0, -5.0, 5.0, -8.0, 4.0, 8.0, -9.0, 6.0, -3.0, 2.0));
	block.var[9] = (mat4x3(3.0, -8.0, 6.0, -2.0, 8.0, -2.0, -2.0, -5.0, -1.0, -7.0, -9.0, 3.0));
	block.var[10] = (mat4x3(-6.0, -9.0, -4.0, -6.0, -1.0, -8.0, 9.0, 6.0, -8.0, -6.0, -5.0, 1.0));
	block.var[11] = (mat4x3(-1.0, -9.0, 4.0, 0.0, 9.0, 3.0, 5.0, 7.0, -4.0, -7.0, 3.0, 9.0));
	block.var[12] = (mat4x3(-2.0, 3.0, 9.0, 9.0, -7.0, 4.0, 4.0, 8.0, 7.0, -7.0, 2.0, 2.0));
	block.var[13] = (mat4x3(-2.0, -1.0, -7.0, 6.0, 7.0, -7.0, 6.0, 0.0, 2.0, -3.0, -6.0, -4.0));
	block.var[14] = (mat4x3(5.0, -5.0, 1.0, 9.0, 0.0, 3.0, 6.0, -8.0, 7.0, -6.0, 0.0, -2.0));
	block.var[15] = (mat4x3(3.0, 0.0, 5.0, 8.0, 6.0, -4.0, 7.0, 1.0, 1.0, 5.0, -3.0, -3.0));
	block.var[16] = (mat4x3(5.0, -3.0, -4.0, -9.0, 2.0, 9.0, -3.0, 1.0, -8.0, -8.0, 0.0, 9.0));
	block.var[17] = (mat4x3(-8.0, 9.0, -9.0, 4.0, -4.0, 3.0, -4.0, -1.0, -6.0, -7.0, 7.0, 6.0));
	block.var[18] = (mat4x3(-6.0, 5.0, 8.0, 3.0, -8.0, 8.0, -6.0, -2.0, 5.0, 6.0, 4.0, 8.0));
}
#version 450
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
	i16vec4 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(block.var[0]), ivec4(-6, -9, 9, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1]), ivec4(-1, -8, 8, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2]), ivec4(3, 4, 0, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[3]), ivec4(-2, -4, -9, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[4]), ivec4(4, -1, 4, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[5]), ivec4(6, 7, -4, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[6]), ivec4(-2, 9, 9, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[7]), ivec4(-3, -8, -7, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[8]), ivec4(7, -2, -8, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[9]), ivec4(1, 6, 9, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[10]), ivec4(1, -3, 9, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[11]), ivec4(4, 8, -6, -2)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[12]), ivec4(3, -5, 9, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[13]), ivec4(6, 3, 6, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[14]), ivec4(9, -8, -9, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[15]), ivec4(-9, -3, -3, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[16]), ivec4(-7, -4, 3, 0)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[17]), ivec4(-4, 5, -2, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[18]), ivec4(4, -6, 5, -3)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = i16vec4(ivec4(-4, -8, -4, 9));
	block.var[1] = i16vec4(ivec4(2, 7, -4, 4));
	block.var[2] = i16vec4(ivec4(8, 9, 5, 1));
	block.var[3] = i16vec4(ivec4(-3, 3, 8, 7));
	block.var[4] = i16vec4(ivec4(2, 6, -9, 9));
	block.var[5] = i16vec4(ivec4(-2, 4, -8, -7));
	block.var[6] = i16vec4(ivec4(-9, -1, -8, -1));
	block.var[7] = i16vec4(ivec4(-1, -6, 5, 2));
	block.var[8] = i16vec4(ivec4(-3, 8, -7, -2));
	block.var[9] = i16vec4(ivec4(9, 7, 6, -9));
	block.var[10] = i16vec4(ivec4(5, -3, 8, 5));
	block.var[11] = i16vec4(ivec4(-6, -9, -6, 2));
	block.var[12] = i16vec4(ivec4(7, -1, 8, -5));
	block.var[13] = i16vec4(ivec4(-9, -6, -2, -2));
	block.var[14] = i16vec4(ivec4(-3, 8, 7, -4));
	block.var[15] = i16vec4(ivec4(-2, 0, 6, -2));
	block.var[16] = i16vec4(ivec4(6, -5, -6, -3));
	block.var[17] = i16vec4(ivec4(4, -4, -4, 9));
	block.var[18] = i16vec4(ivec4(7, 6, 4, -1));
}
#version 450
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

layout(std140, column_major, buffer_reference) buffer Block
{
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
	allOk = compare_mat3x2(block.var[0][0], mat3x2(-5.0, 7.0, -1.0, -4.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1], mat3x2(-5.0, 7.0, -4.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2], mat3x2(8.0, -3.0, 3.0, -5.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0], mat3x2(-8.0, -4.0, 7.0, 3.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1], mat3x2(0.0, 9.0, -4.0, -9.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2], mat3x2(0.0, 9.0, 2.0, -2.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0], mat3x2(0.0, 6.0, -2.0, 6.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1], mat3x2(1.0, 5.0, 8.0, 3.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2], mat3x2(0.0, 9.0, -2.0, 3.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0], mat3x2(-3.0, 4.0, 1.0, -5.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1], mat3x2(1.0, -8.0, -7.0, -8.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][2], mat3x2(-5.0, -4.0, 7.0, 3.0, 3.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec2(-8.0, -4.0));
	block.var[0][0][1] = (vec2(-3.0, 5.0));
	block.var[0][0][2] = (vec2(-9.0, 4.0));
	block.var[0][1][0] = (vec2(-2.0, -1.0));
	block.var[0][1][1] = (vec2(8.0, 3.0));
	block.var[0][1][2] = (vec2(7.0, 2.0));
	block.var[0][2][0] = (vec2(-4.0, 4.0));
	block.var[0][2][1] = (vec2(3.0, -6.0));
	block.var[0][2][2] = (vec2(-4.0, 3.0));
	block.var[1][0][0] = (vec2(4.0, 6.0));
	block.var[1][0][1] = (vec2(3.0, 6.0));
	block.var[1][0][2] = (vec2(-2.0, -9.0));
	block.var[1][1][0] = (vec2(-9.0, 0.0));
	block.var[1][1][1] = (vec2(-4.0, 9.0));
	block.var[1][1][2] = (vec2(-1.0, -1.0));
	block.var[1][2][0] = (vec2(-8.0, 6.0));
	block.var[1][2][1] = (vec2(5.0, -2.0));
	block.var[1][2][2] = (vec2(1.0, 4.0));
	block.var[2][0][0] = (vec2(2.0, -5.0));
	block.var[2][0][1] = (vec2(-5.0, -9.0));
	block.var[2][0][2] = (vec2(-7.0, 3.0));
	block.var[2][1][0] = (vec2(-1.0, 0.0));
	block.var[2][1][1] = (vec2(-1.0, 4.0));
	block.var[2][1][2] = (vec2(-1.0, -6.0));
	block.var[2][2][0] = (vec2(-8.0, -6.0));
	block.var[2][2][1] = (vec2(8.0, 7.0));
	block.var[2][2][2] = (vec2(4.0, -9.0));
	block.var[3][0][0] = (vec2(-4.0, -1.0));
	block.var[3][0][1] = (vec2(-3.0, -2.0));
	block.var[3][0][2] = (vec2(-5.0, -2.0));
	block.var[3][1][0] = (vec2(-7.0, -3.0));
	block.var[3][1][1] = (vec2(5.0, 4.0));
	block.var[3][1][2] = (vec2(4.0, 1.0));
	block.var[3][2][0] = (vec2(-3.0, -6.0));
	block.var[3][2][1] = (vec2(-4.0, -2.0));
	block.var[3][2][2] = (vec2(-5.0, -7.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0], mat4x2(8.0, 1.0, 9.0, 3.0, -8.0, 3.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1], mat4x2(8.0, -6.0, -5.0, 7.0, -8.0, -2.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2], mat4x2(9.0, 4.0, 4.0, 4.0, 3.0, -6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0], mat4x2(3.0, -2.0, -4.0, 6.0, -1.0, 6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1], mat4x2(-1.0, 0.0, -1.0, -3.0, 6.0, -8.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2], mat4x2(2.0, -2.0, 9.0, -1.0, 8.0, -1.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0], mat4x2(0.0, 7.0, 4.0, 1.0, -9.0, -2.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1], mat4x2(8.0, 8.0, -1.0, -5.0, -4.0, 4.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2], mat4x2(7.0, 4.0, 2.0, -2.0, -2.0, 5.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0], mat4x2(8.0, -7.0, 6.0, -9.0, -2.0, -4.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1], mat4x2(-4.0, 1.0, -6.0, 5.0, -7.0, -4.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][2], mat4x2(2.0, -3.0, -2.0, -6.0, 9.0, -8.0, 3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat4x2(-9.0, -8.0, -8.0, 3.0, 8.0, 7.0, 0.0, 5.0));
	block.var[0][1] = (mat4x2(5.0, 8.0, 8.0, 8.0, 6.0, -3.0, -6.0, -4.0));
	block.var[0][2] = (mat4x2(-6.0, -9.0, 1.0, -1.0, 8.0, -7.0, 5.0, -3.0));
	block.var[1][0] = (mat4x2(8.0, 7.0, 6.0, 9.0, 0.0, -1.0, 7.0, 0.0));
	block.var[1][1] = (mat4x2(1.0, 6.0, 8.0, 3.0, 9.0, 0.0, -5.0, -5.0));
	block.var[1][2] = (mat4x2(3.0, -5.0, 8.0, 2.0, -9.0, 0.0, 7.0, 6.0));
	block.var[2][0] = (mat4x2(-4.0, 4.0, -6.0, 9.0, 5.0, 8.0, -2.0, -7.0));
	block.var[2][1] = (mat4x2(8.0, -4.0, 6.0, -7.0, 8.0, -5.0, 8.0, 4.0));
	block.var[2][2] = (mat4x2(-4.0, -8.0, 4.0, 9.0, 5.0, 6.0, 9.0, 3.0));
	block.var[3][0] = (mat4x2(-5.0, 7.0, -9.0, 1.0, 1.0, -3.0, 9.0, -2.0));
	block.var[3][1] = (mat4x2(6.0, -7.0, 7.0, -9.0, 7.0, -6.0, -9.0, -4.0));
	block.var[3][2] = (mat4x2(3.0, -8.0, 2.0, -9.0, 6.0, 2.0, -6.0, 3.0));
}
#version 450
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
	highp int var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((block.var[0][0]), 6) && allOk;
	allOk = compare_int((block.var[0][1]), 0) && allOk;
	allOk = compare_int((block.var[0][2]), 9) && allOk;
	allOk = compare_int((block.var[1][0]), -6) && allOk;
	allOk = compare_int((block.var[1][1]), -9) && allOk;
	allOk = compare_int((block.var[1][2]), -8) && allOk;
	allOk = compare_int((block.var[2][0]), 8) && allOk;
	allOk = compare_int((block.var[2][1]), -9) && allOk;
	allOk = compare_int((block.var[2][2]), -1) && allOk;
	allOk = compare_int((block.var[3][0]), 0) && allOk;
	allOk = compare_int((block.var[3][1]), -9) && allOk;
	allOk = compare_int((block.var[3][2]), 5) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (8);
	block.var[0][1] = (2);
	block.var[0][2] = (-5);
	block.var[1][0] = (0);
	block.var[1][1] = (-7);
	block.var[1][2] = (-7);
	block.var[2][0] = (-8);
	block.var[2][1] = (6);
	block.var[2][2] = (-6);
	block.var[3][0] = (6);
	block.var[3][1] = (-5);
	block.var[3][2] = (5);
}
#version 450
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
	highp ivec3 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((block.var[0][0]), ivec3(7, -4, 3)) && allOk;
	allOk = compare_ivec3((block.var[0][1]), ivec3(-4, -6, -8)) && allOk;
	allOk = compare_ivec3((block.var[0][2]), ivec3(3, -1, -7)) && allOk;
	allOk = compare_ivec3((block.var[1][0]), ivec3(-1, 2, 9)) && allOk;
	allOk = compare_ivec3((block.var[1][1]), ivec3(-8, 4, 9)) && allOk;
	allOk = compare_ivec3((block.var[1][2]), ivec3(-3, -3, -9)) && allOk;
	allOk = compare_ivec3((block.var[2][0]), ivec3(9, 3, -6)) && allOk;
	allOk = compare_ivec3((block.var[2][1]), ivec3(-6, 7, 3)) && allOk;
	allOk = compare_ivec3((block.var[2][2]), ivec3(6, 9, 0)) && allOk;
	allOk = compare_ivec3((block.var[3][0]), ivec3(5, 8, 2)) && allOk;
	allOk = compare_ivec3((block.var[3][1]), ivec3(7, -7, 2)) && allOk;
	allOk = compare_ivec3((block.var[3][2]), ivec3(1, -4, 0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (ivec3(-5, 0, -9));
	block.var[0][1] = (ivec3(2, 4, 1));
	block.var[0][2] = (ivec3(6, 6, 2));
	block.var[1][0] = (ivec3(4, 4, 2));
	block.var[1][1] = (ivec3(-4, -1, -7));
	block.var[1][2] = (ivec3(8, -4, 1));
	block.var[2][0] = (ivec3(-4, -1, 5));
	block.var[2][1] = (ivec3(-4, 2, -2));
	block.var[2][2] = (ivec3(6, 7, -1));
	block.var[3][0] = (ivec3(-1, -3, -1));
	block.var[3][1] = (ivec3(-4, -1, -3));
	block.var[3][2] = (ivec3(6, -3, 8));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0][0], mat2x3(-2.0, 3.0, -3.0, 8.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1], mat2x3(-4.0, -6.0, -3.0, -8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2], mat2x3(1.0, -5.0, 8.0, -3.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0], mat2x3(6.0, -1.0, -8.0, 3.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1], mat2x3(4.0, 7.0, 2.0, -2.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2], mat2x3(0.0, 3.0, 1.0, 1.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0], mat2x3(-5.0, 0.0, 2.0, -8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1], mat2x3(-7.0, 0.0, -6.0, -3.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2], mat2x3(2.0, 2.0, 8.0, 8.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0], mat2x3(5.0, -5.0, 7.0, 3.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1], mat2x3(-4.0, 4.0, -6.0, -4.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][2], mat2x3(-1.0, 2.0, 6.0, 0.0, -5.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat2x3(0.0, 4.0, 4.0, 5.0, -5.0, 2.0));
	block.var[0][1] = (mat2x3(8.0, -1.0, -2.0, -7.0, -8.0, -2.0));
	block.var[0][2] = (mat2x3(2.0, -2.0, 7.0, -9.0, 7.0, -7.0));
	block.var[1][0] = (mat2x3(-5.0, 6.0, 8.0, -8.0, 0.0, 2.0));
	block.var[1][1] = (mat2x3(7.0, -9.0, -2.0, -9.0, -1.0, -1.0));
	block.var[1][2] = (mat2x3(-4.0, -3.0, 7.0, 9.0, 0.0, -4.0));
	block.var[2][0] = (mat2x3(9.0, 0.0, 7.0, 7.0, 9.0, -8.0));
	block.var[2][1] = (mat2x3(5.0, 5.0, 1.0, 6.0, 3.0, -6.0));
	block.var[2][2] = (mat2x3(8.0, 9.0, 6.0, 7.0, 0.0, -6.0));
	block.var[3][0] = (mat2x3(-7.0, 6.0, 4.0, 8.0, 5.0, -1.0));
	block.var[3][1] = (mat2x3(4.0, 4.0, 9.0, 9.0, -8.0, 6.0));
	block.var[3][2] = (mat2x3(6.0, 3.0, 8.0, 3.0, 4.0, 4.0));
}
#version 450
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
	highp uint var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((block.padding), 3u) && allOk;
	allOk = compare_uint((block.var[0][0]), 6u) && allOk;
	allOk = compare_uint((block.var[0][1]), 9u) && allOk;
	allOk = compare_uint((block.var[0][2]), 0u) && allOk;
	allOk = compare_uint((block.var[1][0]), 3u) && allOk;
	allOk = compare_uint((block.var[1][1]), 7u) && allOk;
	allOk = compare_uint((block.var[1][2]), 6u) && allOk;
	allOk = compare_uint((block.var[2][0]), 4u) && allOk;
	allOk = compare_uint((block.var[2][1]), 2u) && allOk;
	allOk = compare_uint((block.var[2][2]), 5u) && allOk;
	allOk = compare_uint((block.var[3][0]), 7u) && allOk;
	allOk = compare_uint((block.var[3][1]), 5u) && allOk;
	allOk = compare_uint((block.var[3][2]), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (7u);
	block.var[0][0] = (9u);
	block.var[0][1] = (1u);
	block.var[0][2] = (0u);
	block.var[1][0] = (7u);
	block.var[1][1] = (7u);
	block.var[1][2] = (4u);
	block.var[2][0] = (8u);
	block.var[2][1] = (7u);
	block.var[2][2] = (5u);
	block.var[3][0] = (7u);
	block.var[3][1] = (2u);
	block.var[3][2] = (7u);
}
#version 450
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
	float padding;
	highp mat4 var[4][3];
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
	allOk = compare_float((block.padding), 3.0) && allOk;
	allOk = compare_mat4(block.var[0][0], mat4(0.0, 6.0, 0.0, -6.0, 5.0, 3.0, -4.0, -9.0, -8.0, 9.0, 3.0, 2.0, -9.0, 6.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[0][1], mat4(0.0, 1.0, -5.0, -2.0, 1.0, -6.0, -8.0, -1.0, 5.0, -8.0, 0.0, -6.0, 3.0, -3.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[0][2], mat4(-3.0, 4.0, 6.0, 2.0, 3.0, 0.0, 7.0, 9.0, -9.0, -6.0, 8.0, 0.0, -9.0, 9.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[1][0], mat4(-7.0, 1.0, -7.0, -1.0, 5.0, 9.0, -8.0, 2.0, -6.0, 1.0, 7.0, 4.0, 1.0, -4.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[1][1], mat4(5.0, -7.0, -5.0, -9.0, 3.0, 0.0, 0.0, 3.0, 2.0, -5.0, -8.0, 9.0, 3.0, -4.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[1][2], mat4(-1.0, 6.0, 9.0, 0.0, -6.0, 0.0, 1.0, -1.0, 5.0, -7.0, -8.0, 1.0, -3.0, 1.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[2][0], mat4(1.0, 3.0, -2.0, -8.0, -3.0, 0.0, 4.0, -3.0, -4.0, 6.0, -7.0, 5.0, 4.0, 0.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2][1], mat4(5.0, 7.0, -7.0, 1.0, -4.0, 9.0, 7.0, 9.0, -2.0, -8.0, 8.0, -2.0, -7.0, -5.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2][2], mat4(9.0, 4.0, -3.0, 1.0, 9.0, 1.0, 8.0, 6.0, -1.0, -3.0, -2.0, 5.0, -3.0, -7.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[3][0], mat4(-8.0, 8.0, -5.0, -4.0, -4.0, -8.0, 9.0, -5.0, 5.0, 8.0, -9.0, 2.0, 8.0, 2.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[3][1], mat4(5.0, -4.0, -4.0, -3.0, -5.0, -8.0, -3.0, -6.0, -5.0, 0.0, -6.0, -9.0, -2.0, 9.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[3][2], mat4(8.0, 5.0, 0.0, -7.0, -4.0, 7.0, -7.0, 2.0, -4.0, -2.0, -8.0, 5.0, -4.0, 9.0, -2.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (4.0);
	block.var[0][0] = (mat4(7.0, -2.0, -5.0, 3.0, -6.0, 0.0, -4.0, 2.0, -9.0, -1.0, 6.0, 8.0, 9.0, 5.0, -6.0, 1.0));
	block.var[0][1] = (mat4(3.0, -7.0, -5.0, 5.0, -5.0, -2.0, -4.0, 9.0, 5.0, 2.0, -3.0, -8.0, 2.0, 1.0, 5.0, 5.0));
	block.var[0][2] = (mat4(2.0, -1.0, -1.0, 5.0, -5.0, 0.0, 3.0, -6.0, -5.0, -1.0, 3.0, -6.0, -5.0, -7.0, -8.0, -1.0));
	block.var[1][0] = (mat4(9.0, 8.0, 0.0, -5.0, 0.0, -3.0, -7.0, 8.0, -9.0, -9.0, 0.0, 9.0, -8.0, -8.0, -5.0, 5.0));
	block.var[1][1] = (mat4(6.0, -1.0, 7.0, -2.0, 2.0, -7.0, 1.0, 8.0, 0.0, 7.0, 1.0, 2.0, 7.0, 5.0, 0.0, 7.0));
	block.var[1][2] = (mat4(-1.0, 8.0, 4.0, -9.0, -9.0, -4.0, 6.0, 9.0, -3.0, 3.0, -9.0, 5.0, -1.0, -2.0, -9.0, 4.0));
	block.var[2][0] = (mat4(-8.0, -4.0, -7.0, -9.0, 6.0, 9.0, 1.0, 2.0, -8.0, 2.0, 5.0, -6.0, -1.0, -7.0, 3.0, -9.0));
	block.var[2][1] = (mat4(-2.0, 3.0, -9.0, -1.0, -2.0, 6.0, 4.0, 7.0, -4.0, 1.0, -8.0, 4.0, 9.0, -7.0, -6.0, 5.0));
	block.var[2][2] = (mat4(-2.0, 0.0, 3.0, 4.0, -3.0, 8.0, -1.0, -3.0, 2.0, 7.0, -7.0, 1.0, -2.0, 8.0, -1.0, -2.0));
	block.var[3][0] = (mat4(-6.0, -4.0, 5.0, 6.0, -2.0, 8.0, 8.0, 5.0, -6.0, -4.0, -6.0, -1.0, -3.0, -6.0, 0.0, -9.0));
	block.var[3][1] = (mat4(-3.0, -7.0, 7.0, 2.0, -7.0, -7.0, 0.0, -5.0, -9.0, 6.0, -3.0, -5.0, -4.0, -4.0, -5.0, 6.0));
	block.var[3][2] = (mat4(9.0, 3.0, -8.0, -3.0, 0.0, -9.0, 2.0, 6.0, 0.0, -4.0, 1.0, 0.0, 2.0, 2.0, 5.0, 5.0));
}
#version 450
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
	allOk = compare_float((block.padding), 0.0) && allOk;
	allOk = compare_mat3x2(block.var[0][0], mat3x2(5.0, 2.0, -5.0, 9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1], mat3x2(-9.0, 0.0, -5.0, 3.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2], mat3x2(-2.0, 6.0, -3.0, -4.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0], mat3x2(1.0, -5.0, -2.0, 0.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1], mat3x2(-4.0, -9.0, 2.0, 4.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2], mat3x2(1.0, 2.0, 0.0, -6.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0], mat3x2(-8.0, 5.0, 8.0, -7.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1], mat3x2(-5.0, -4.0, 8.0, 0.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2], mat3x2(9.0, -7.0, 8.0, -9.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0], mat3x2(7.0, 6.0, -8.0, 4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1], mat3x2(5.0, 6.0, -9.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][2], mat3x2(7.0, 1.0, 5.0, 1.0, -5.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-2.0);
	block.var[0][0][0] = (vec2(1.0, 8.0));
	block.var[0][0][1] = (vec2(-7.0, 5.0));
	block.var[0][0][2] = (vec2(8.0, 2.0));
	block.var[0][1][0] = (vec2(-3.0, 1.0));
	block.var[0][1][1] = (vec2(2.0, -5.0));
	block.var[0][1][2] = (vec2(0.0, 6.0));
	block.var[0][2][0] = (vec2(6.0, 5.0));
	block.var[0][2][1] = (vec2(-5.0, 9.0));
	block.var[0][2][2] = (vec2(3.0, -8.0));
	block.var[1][0][0] = (vec2(3.0, -3.0));
	block.var[1][0][1] = (vec2(3.0, -5.0));
	block.var[1][0][2] = (vec2(9.0, 7.0));
	block.var[1][1][0] = (vec2(3.0, 1.0));
	block.var[1][1][1] = (vec2(-2.0, 1.0));
	block.var[1][1][2] = (vec2(-8.0, 4.0));
	block.var[1][2][0] = (vec2(3.0, 6.0));
	block.var[1][2][1] = (vec2(7.0, 1.0));
	block.var[1][2][2] = (vec2(-9.0, 9.0));
	block.var[2][0][0] = (vec2(0.0, -6.0));
	block.var[2][0][1] = (vec2(-7.0, 7.0));
	block.var[2][0][2] = (vec2(-9.0, -8.0));
	block.var[2][1][0] = (vec2(9.0, 6.0));
	block.var[2][1][1] = (vec2(-1.0, 0.0));
	block.var[2][1][2] = (vec2(7.0, -3.0));
	block.var[2][2][0] = (vec2(-1.0, -6.0));
	block.var[2][2][1] = (vec2(-1.0, -3.0));
	block.var[2][2][2] = (vec2(6.0, 0.0));
	block.var[3][0][0] = (vec2(4.0, -9.0));
	block.var[3][0][1] = (vec2(1.0, 1.0));
	block.var[3][0][2] = (vec2(-1.0, -9.0));
	block.var[3][1][0] = (vec2(0.0, 4.0));
	block.var[3][1][1] = (vec2(-3.0, -3.0));
	block.var[3][1][2] = (vec2(7.0, 6.0));
	block.var[3][2][0] = (vec2(-7.0, 5.0));
	block.var[3][2][1] = (vec2(-6.0, -5.0));
	block.var[3][2][2] = (vec2(8.0, 2.0));
}
#version 450
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
	highp mat2 var[4][2][3];
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
	allOk = compare_mat2(block.var[0][0][0], mat2(-7.0, -2.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(0.0, 4.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][2], mat2(-2.0, -1.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(-8.0, 7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(-8.0, 1.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][2], mat2(-3.0, -8.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(6.0, -4.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(3.0, 2.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][2], mat2(8.0, -3.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(5.0, -3.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(-9.0, 0.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][2], mat2(9.0, 6.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(2.0, -7.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(-7.0, 8.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][2], mat2(3.0, -1.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(4.0, 4.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(-3.0, -7.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][2], mat2(5.0, -7.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][0], mat2(2.0, -7.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][1], mat2(1.0, 7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][2], mat2(-5.0, -4.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][0], mat2(-3.0, -7.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][1], mat2(6.0, -2.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][2], mat2(2.0, 7.0, 8.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2(1.0, 2.0, 6.0, -6.0));
	block.var[0][0][1] = (mat2(2.0, 4.0, 4.0, 7.0));
	block.var[0][0][2] = (mat2(0.0, 8.0, 0.0, -1.0));
	block.var[0][1][0] = (mat2(5.0, 1.0, -7.0, -2.0));
	block.var[0][1][1] = (mat2(-8.0, -9.0, 4.0, -4.0));
	block.var[0][1][2] = (mat2(-7.0, -9.0, -5.0, 3.0));
	block.var[1][0][0] = (mat2(8.0, -4.0, -5.0, 7.0));
	block.var[1][0][1] = (mat2(-3.0, -1.0, 0.0, 6.0));
	block.var[1][0][2] = (mat2(-6.0, 7.0, 4.0, -7.0));
	block.var[1][1][0] = (mat2(-1.0, -1.0, -6.0, -3.0));
	block.var[1][1][1] = (mat2(-9.0, -4.0, -8.0, -1.0));
	block.var[1][1][2] = (mat2(-8.0, 1.0, -2.0, 9.0));
	block.var[2][0][0] = (mat2(1.0, -8.0, -9.0, -7.0));
	block.var[2][0][1] = (mat2(1.0, -2.0, -6.0, -8.0));
	block.var[2][0][2] = (mat2(-6.0, -6.0, 2.0, -9.0));
	block.var[2][1][0] = (mat2(9.0, 4.0, -3.0, -3.0));
	block.var[2][1][1] = (mat2(0.0, -1.0, -5.0, -6.0));
	block.var[2][1][2] = (mat2(-8.0, 0.0, 8.0, 8.0));
	block.var[3][0][0] = (mat2(9.0, 0.0, -3.0, -7.0));
	block.var[3][0][1] = (mat2(8.0, 8.0, 7.0, -3.0));
	block.var[3][0][2] = (mat2(7.0, 2.0, -8.0, -7.0));
	block.var[3][1][0] = (mat2(-3.0, -9.0, 5.0, -2.0));
	block.var[3][1][1] = (mat2(1.0, 9.0, -3.0, -5.0));
	block.var[3][1][2] = (mat2(-3.0, 5.0, 0.0, -9.0));
}
#version 450
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
	highp mat2 var[4][2][3];
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
	allOk = compare_mat2(block.var[0][0][0], mat2(-2.0, 3.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(8.0, 2.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][2], mat2(3.0, 2.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(6.0, -3.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(3.0, 6.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][2], mat2(3.0, -9.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(5.0, 8.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(-7.0, 8.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][2], mat2(-6.0, 2.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(6.0, -4.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(0.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][2], mat2(-4.0, 8.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(9.0, -3.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(-2.0, 8.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][2], mat2(3.0, 5.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(6.0, -8.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(8.0, 4.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][2], mat2(6.0, 4.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][0], mat2(-8.0, -1.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][1], mat2(-6.0, 9.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][2], mat2(-7.0, 1.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][0], mat2(5.0, -3.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][1], mat2(-6.0, -7.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][2], mat2(-8.0, -2.0, -3.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(5.0, -4.0));
	block.var[0][0][0][1] = (vec2(5.0, 1.0));
	block.var[0][0][1][0] = (vec2(-8.0, -1.0));
	block.var[0][0][1][1] = (vec2(9.0, -8.0));
	block.var[0][0][2][0] = (vec2(5.0, -4.0));
	block.var[0][0][2][1] = (vec2(5.0, -2.0));
	block.var[0][1][0][0] = (vec2(7.0, 7.0));
	block.var[0][1][0][1] = (vec2(0.0, 2.0));
	block.var[0][1][1][0] = (vec2(4.0, -7.0));
	block.var[0][1][1][1] = (vec2(-5.0, -7.0));
	block.var[0][1][2][0] = (vec2(8.0, 2.0));
	block.var[0][1][2][1] = (vec2(1.0, -1.0));
	block.var[1][0][0][0] = (vec2(9.0, -9.0));
	block.var[1][0][0][1] = (vec2(-1.0, 6.0));
	block.var[1][0][1][0] = (vec2(-4.0, 7.0));
	block.var[1][0][1][1] = (vec2(-8.0, 1.0));
	block.var[1][0][2][0] = (vec2(4.0, -4.0));
	block.var[1][0][2][1] = (vec2(6.0, -5.0));
	block.var[1][1][0][0] = (vec2(9.0, 0.0));
	block.var[1][1][0][1] = (vec2(-8.0, -9.0));
	block.var[1][1][1][0] = (vec2(-2.0, 7.0));
	block.var[1][1][1][1] = (vec2(8.0, 2.0));
	block.var[1][1][2][0] = (vec2(-3.0, -3.0));
	block.var[1][1][2][1] = (vec2(7.0, -2.0));
	block.var[2][0][0][0] = (vec2(4.0, -3.0));
	block.var[2][0][0][1] = (vec2(6.0, 7.0));
	block.var[2][0][1][0] = (vec2(-7.0, -9.0));
	block.var[2][0][1][1] = (vec2(5.0, 0.0));
	block.var[2][0][2][0] = (vec2(9.0, 2.0));
	block.var[2][0][2][1] = (vec2(1.0, -6.0));
	block.var[2][1][0][0] = (vec2(4.0, -2.0));
	block.var[2][1][0][1] = (vec2(6.0, 1.0));
	block.var[2][1][1][0] = (vec2(-2.0, -8.0));
	block.var[2][1][1][1] = (vec2(9.0, 1.0));
	block.var[2][1][2][0] = (vec2(3.0, 4.0));
	block.var[2][1][2][1] = (vec2(-1.0, 5.0));
	block.var[3][0][0][0] = (vec2(8.0, -8.0));
	block.var[3][0][0][1] = (vec2(5.0, -5.0));
	block.var[3][0][1][0] = (vec2(-5.0, 4.0));
	block.var[3][0][1][1] = (vec2(5.0, 0.0));
	block.var[3][0][2][0] = (vec2(6.0, 9.0));
	block.var[3][0][2][1] = (vec2(5.0, -8.0));
	block.var[3][1][0][0] = (vec2(2.0, -6.0));
	block.var[3][1][0][1] = (vec2(7.0, -4.0));
	block.var[3][1][1][0] = (vec2(5.0, 3.0));
	block.var[3][1][1][1] = (vec2(9.0, -9.0));
	block.var[3][1][2][0] = (vec2(7.0, 1.0));
	block.var[3][1][2][1] = (vec2(-5.0, -7.0));
}
#version 450
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
	highp mat3x4 var[4][2][3];
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
	allOk = compare_mat3x4(block.var[0][0][2], mat3x4(-7.0, 5.0, -6.0, 7.0, -4.0, -9.0, -9.0, -4.0, -8.0, -8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(0.0, 6.0, 3.0, 9.0, -3.0, 9.0, 3.0, -5.0, -1.0, 6.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(-7.0, 6.0, 5.0, -7.0, -2.0, -4.0, 0.0, -8.0, 8.0, 9.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][2], mat3x4(4.0, 4.0, -6.0, -2.0, 7.0, 1.0, -3.0, -2.0, -6.0, -2.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(-5.0, 6.0, 2.0, -2.0, -3.0, 2.0, 4.0, -3.0, 5.0, 5.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(-6.0, 9.0, 8.0, 1.0, -2.0, 9.0, 1.0, -5.0, -9.0, 9.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][2], mat3x4(-4.0, 0.0, 9.0, -6.0, -9.0, -7.0, -7.0, 1.0, 1.0, 2.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(-6.0, -4.0, 8.0, -5.0, -5.0, 7.0, 3.0, -1.0, 7.0, -4.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(5.0, -1.0, 4.0, -5.0, -8.0, -7.0, 7.0, -6.0, -4.0, 6.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][2], mat3x4(-5.0, 3.0, 9.0, 0.0, 1.0, 3.0, -8.0, -9.0, 5.0, 8.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(4.0, 6.0, -1.0, -2.0, -4.0, 0.0, 4.0, -8.0, 3.0, 4.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(8.0, 7.0, 4.0, -4.0, 0.0, 2.0, -5.0, 4.0, 0.0, 7.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][2], mat3x4(7.0, -8.0, 6.0, -8.0, -3.0, -8.0, 4.0, 7.0, 5.0, -2.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(-2.0, 9.0, -5.0, -3.0, 3.0, 5.0, 4.0, -7.0, -1.0, 4.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(-5.0, 1.0, 5.0, -9.0, 3.0, 5.0, 3.0, 8.0, -8.0, -5.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][2], mat3x4(-9.0, -3.0, -8.0, -8.0, 8.0, 8.0, 3.0, -6.0, -7.0, 4.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][0], mat3x4(-3.0, -4.0, 8.0, 5.0, -1.0, -5.0, -2.0, 2.0, -8.0, -8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][1], mat3x4(6.0, -3.0, -1.0, -3.0, -7.0, -6.0, 1.0, -7.0, -1.0, 8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][2], mat3x4(-1.0, -8.0, 0.0, 1.0, 7.0, -5.0, -6.0, 7.0, 5.0, -3.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][0], mat3x4(7.0, 0.0, 9.0, -1.0, 2.0, 9.0, -3.0, 7.0, 4.0, -2.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][1], mat3x4(-4.0, -4.0, -1.0, -8.0, 9.0, -4.0, -1.0, -5.0, -8.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][2], mat3x4(7.0, -1.0, -3.0, -4.0, -4.0, -3.0, 3.0, -7.0, -5.0, 8.0, 1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3x4(3.0, -9.0, -6.0, 7.0, 6.0, -8.0, -1.0, 1.0, -9.0, 7.0, 6.0, 6.0));
	block.var[0][0][1] = (mat3x4(-5.0, -1.0, -8.0, 3.0, 9.0, 9.0, -8.0, 0.0, 0.0, -9.0, -6.0, -7.0));
	block.var[0][0][2] = (mat3x4(-3.0, -3.0, 9.0, -7.0, 4.0, 2.0, -8.0, 4.0, -6.0, -1.0, -9.0, 5.0));
	block.var[0][1][0] = (mat3x4(-6.0, 0.0, 1.0, -2.0, 1.0, -4.0, -2.0, -6.0, -7.0, -8.0, 0.0, -8.0));
	block.var[0][1][1] = (mat3x4(0.0, 2.0, 9.0, -5.0, 9.0, -5.0, -4.0, 0.0, 4.0, 1.0, 0.0, -9.0));
	block.var[0][1][2] = (mat3x4(1.0, -1.0, -4.0, 9.0, 7.0, 3.0, 5.0, 1.0, 6.0, 6.0, 2.0, 2.0));
	block.var[1][0][0] = (mat3x4(-5.0, -5.0, -9.0, -1.0, -9.0, -3.0, 0.0, 2.0, 8.0, -5.0, 1.0, 4.0));
	block.var[1][0][1] = (mat3x4(-5.0, 5.0, -5.0, 2.0, -8.0, -3.0, 6.0, 1.0, 0.0, 1.0, 4.0, 6.0));
	block.var[1][0][2] = (mat3x4(-9.0, -1.0, -9.0, -6.0, 8.0, -9.0, -4.0, -6.0, -6.0, -1.0, -3.0, -7.0));
	block.var[1][1][0] = (mat3x4(8.0, -5.0, -9.0, 8.0, -3.0, -3.0, 9.0, -9.0, 6.0, -4.0, 9.0, 4.0));
	block.var[1][1][1] = (mat3x4(-8.0, 4.0, 7.0, 3.0, -1.0, -1.0, 9.0, -9.0, 8.0, -3.0, 9.0, -6.0));
	block.var[1][1][2] = (mat3x4(-4.0, 6.0, 2.0, 5.0, 3.0, 7.0, 3.0, 4.0, -4.0, 2.0, 0.0, 8.0));
	block.var[2][0][0] = (mat3x4(-4.0, 2.0, -8.0, -7.0, -3.0, 6.0, 6.0, 8.0, -4.0, -1.0, 1.0, -9.0));
	block.var[2][0][1] = (mat3x4(9.0, -2.0, 4.0, 3.0, -2.0, 8.0, -4.0, 5.0, -8.0, 8.0, -2.0, 7.0));
	block.var[2][0][2] = (mat3x4(-6.0, 5.0, -8.0, -5.0, -7.0, -8.0, 3.0, 4.0, -7.0, 2.0, 3.0, 2.0));
	block.var[2][1][0] = (mat3x4(-8.0, 0.0, 8.0, -6.0, -2.0, -3.0, 6.0, 4.0, 9.0, -2.0, 4.0, 1.0));
	block.var[2][1][1] = (mat3x4(-9.0, -5.0, -8.0, 5.0, 4.0, 2.0, 7.0, 1.0, -6.0, 2.0, -6.0, -4.0));
	block.var[2][1][2] = (mat3x4(-3.0, 1.0, -5.0, -9.0, -2.0, 3.0, 0.0, -4.0, 8.0, -3.0, 4.0, 9.0));
	block.var[3][0][0] = (mat3x4(9.0, 2.0, -6.0, 4.0, 9.0, 6.0, 2.0, 0.0, 1.0, 0.0, -3.0, 2.0));
	block.var[3][0][1] = (mat3x4(-1.0, 4.0, -6.0, 4.0, -1.0, 3.0, 1.0, 3.0, 6.0, -6.0, -9.0, -9.0));
	block.var[3][0][2] = (mat3x4(-9.0, 1.0, -6.0, 4.0, 0.0, -2.0, -8.0, 9.0, 6.0, -9.0, 6.0, 7.0));
	block.var[3][1][0] = (mat3x4(-6.0, -1.0, 3.0, -9.0, -6.0, -6.0, -3.0, 5.0, 0.0, -9.0, -4.0, 9.0));
	block.var[3][1][1] = (mat3x4(-8.0, 6.0, -4.0, -3.0, -4.0, 3.0, 3.0, 4.0, 4.0, 4.0, 3.0, 8.0));
	block.var[3][1][2] = (mat3x4(-3.0, -6.0, -3.0, 6.0, -9.0, -3.0, -6.0, 9.0, 3.0, -1.0, 6.0, 3.0));
}
#version 450
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
	highp mat3x4 var[4][2][3];
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
	allOk = compare_mat3x4(block.var[0][0][2], mat3x4(4.0, 1.0, 3.0, -1.0, -3.0, -2.0, 2.0, 7.0, 5.0, -1.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(-3.0, -7.0, 5.0, 2.0, -5.0, 9.0, -1.0, -1.0, 1.0, -7.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(2.0, 0.0, 8.0, -9.0, 5.0, -4.0, 5.0, -7.0, 0.0, 5.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][2], mat3x4(3.0, 6.0, -3.0, 3.0, 9.0, -1.0, -3.0, 6.0, -9.0, 9.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(5.0, 1.0, -8.0, -9.0, -6.0, 4.0, 0.0, -9.0, 0.0, -1.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(-3.0, 6.0, 3.0, 0.0, -4.0, 2.0, 4.0, 3.0, -4.0, 9.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][2], mat3x4(-1.0, 6.0, 5.0, -4.0, -5.0, 7.0, -4.0, -5.0, 8.0, -9.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(-2.0, 8.0, 5.0, -9.0, 0.0, -8.0, 8.0, -8.0, 6.0, -2.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(-5.0, -3.0, 9.0, 7.0, 1.0, -1.0, -8.0, -6.0, 5.0, 0.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][2], mat3x4(5.0, -7.0, -3.0, -7.0, 3.0, 9.0, -6.0, -7.0, -4.0, 4.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(2.0, 3.0, 2.0, 5.0, -4.0, -4.0, 2.0, 8.0, 5.0, -5.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(-3.0, 3.0, -2.0, 6.0, 9.0, -7.0, 8.0, 8.0, 1.0, 9.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][2], mat3x4(1.0, -2.0, 4.0, 2.0, 7.0, -2.0, -9.0, 6.0, -4.0, 0.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(3.0, 5.0, -2.0, -6.0, -7.0, -4.0, 6.0, 5.0, -9.0, 2.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(3.0, 3.0, 4.0, -2.0, -8.0, -6.0, -3.0, -8.0, 4.0, 4.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][2], mat3x4(3.0, -8.0, -9.0, 5.0, -7.0, 3.0, -2.0, -7.0, 6.0, 6.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][0], mat3x4(6.0, -8.0, 1.0, 3.0, 2.0, -7.0, 4.0, -9.0, -7.0, 0.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][1], mat3x4(-8.0, 4.0, 3.0, 2.0, 2.0, 0.0, -5.0, -4.0, 7.0, 3.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][2], mat3x4(2.0, 0.0, -3.0, 3.0, -7.0, 7.0, -8.0, 9.0, -2.0, 5.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][0], mat3x4(1.0, -4.0, -8.0, 8.0, -6.0, -1.0, -5.0, -2.0, -6.0, 4.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][1], mat3x4(0.0, 9.0, 4.0, 8.0, 4.0, -1.0, 1.0, -2.0, -5.0, 9.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][2], mat3x4(-8.0, -6.0, -8.0, -9.0, -5.0, -1.0, 6.0, 9.0, -6.0, -3.0, -6.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3x4(0.0, 2.0, -8.0, -3.0, 5.0, -1.0, 3.0, -5.0, -9.0, -7.0, 8.0, -9.0));
	block.var[0][0][1] = (mat3x4(0.0, -5.0, 1.0, -9.0, -1.0, 4.0, 7.0, 4.0, -4.0, -6.0, 0.0, -5.0));
	block.var[0][0][2] = (mat3x4(-7.0, 5.0, -9.0, -3.0, -7.0, 7.0, 1.0, -4.0, 7.0, -8.0, -2.0, -9.0));
	block.var[0][1][0] = (mat3x4(-3.0, -3.0, -1.0, -2.0, 7.0, 1.0, 7.0, 0.0, -9.0, 2.0, -2.0, -6.0));
	block.var[0][1][1] = (mat3x4(4.0, -5.0, -8.0, -9.0, 4.0, 2.0, -1.0, -3.0, 9.0, -6.0, -9.0, -8.0));
	block.var[0][1][2] = (mat3x4(7.0, 6.0, -3.0, -6.0, -1.0, 2.0, 7.0, -9.0, -3.0, -4.0, -1.0, 0.0));
	block.var[1][0][0] = (mat3x4(0.0, -2.0, -8.0, -5.0, 0.0, 5.0, -2.0, -1.0, 5.0, 8.0, -3.0, 1.0));
	block.var[1][0][1] = (mat3x4(-1.0, 7.0, 7.0, 7.0, 2.0, -7.0, 8.0, -3.0, -8.0, -2.0, -5.0, -6.0));
	block.var[1][0][2] = (mat3x4(5.0, 8.0, 9.0, 8.0, 7.0, 0.0, 9.0, 7.0, -3.0, -7.0, -6.0, -5.0));
	block.var[1][1][0] = (mat3x4(-7.0, 4.0, 3.0, -4.0, 4.0, 2.0, -4.0, -3.0, 8.0, 9.0, 9.0, 8.0));
	block.var[1][1][1] = (mat3x4(1.0, 2.0, 5.0, 6.0, 8.0, 4.0, 6.0, -3.0, 6.0, -7.0, 9.0, -9.0));
	block.var[1][1][2] = (mat3x4(-9.0, -8.0, 4.0, 0.0, -8.0, 2.0, 2.0, -2.0, -7.0, 9.0, 5.0, -9.0));
	block.var[2][0][0] = (mat3x4(-7.0, -8.0, -2.0, 9.0, -8.0, 3.0, 9.0, 9.0, 5.0, -8.0, -1.0, 2.0));
	block.var[2][0][1] = (mat3x4(1.0, 5.0, 7.0, 5.0, -4.0, -7.0, -5.0, -9.0, -1.0, 6.0, 2.0, 4.0));
	block.var[2][0][2] = (mat3x4(-1.0, 2.0, 3.0, -5.0, -6.0, -4.0, 4.0, -7.0, -1.0, 8.0, -9.0, 2.0));
	block.var[2][1][0] = (mat3x4(-9.0, -9.0, 8.0, -1.0, 9.0, 2.0, -9.0, -3.0, -9.0, -1.0, 3.0, -2.0));
	block.var[2][1][1] = (mat3x4(4.0, -7.0, 2.0, 7.0, 3.0, -7.0, 7.0, 6.0, 9.0, -4.0, 4.0, 0.0));
	block.var[2][1][2] = (mat3x4(7.0, -5.0, 6.0, 4.0, 1.0, 6.0, 4.0, 4.0, 3.0, -2.0, 6.0, -9.0));
	block.var[3][0][0] = (mat3x4(-2.0, 9.0, -8.0, 3.0, -5.0, 6.0, -8.0, 3.0, -8.0, 6.0, 6.0, -8.0));
	block.var[3][0][1] = (mat3x4(-3.0, 2.0, 8.0, 3.0, -1.0, 0.0, -7.0, 5.0, 3.0, 2.0, 9.0, -2.0));
	block.var[3][0][2] = (mat3x4(-7.0, -5.0, -3.0, 6.0, -7.0, -8.0, -4.0, 1.0, 0.0, 0.0, 1.0, 9.0));
	block.var[3][1][0] = (mat3x4(-6.0, 0.0, 0.0, -3.0, -3.0, 7.0, -1.0, 4.0, 4.0, 5.0, 2.0, 5.0));
	block.var[3][1][1] = (mat3x4(1.0, 9.0, -5.0, -8.0, -5.0, 7.0, -5.0, 0.0, -4.0, 2.0, 3.0, 5.0));
	block.var[3][1][2] = (mat3x4(4.0, 2.0, 3.0, 5.0, 5.0, -9.0, -8.0, -9.0, -7.0, 8.0, 4.0, -2.0));
}
#version 450
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
	float padding;
	highp mat2 var[4][2][3];
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
	allOk = compare_float((block.padding), -7.0) && allOk;
	allOk = compare_mat2(block.var[0][0][0], mat2(-2.0, 6.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(4.0, -7.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][2], mat2(-1.0, -9.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(7.0, 1.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(1.0, -1.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][2], mat2(-8.0, -2.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(-4.0, 1.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(2.0, -3.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][2], mat2(-3.0, -2.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(-3.0, 3.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(0.0, -5.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][2], mat2(6.0, 4.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(-7.0, -4.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(8.0, -7.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][2], mat2(-1.0, -5.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(4.0, -9.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(-7.0, 6.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][2], mat2(-7.0, 4.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][0], mat2(-7.0, -8.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][1], mat2(7.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][2], mat2(-4.0, -3.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][0], mat2(-7.0, 0.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][1], mat2(-2.0, 3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][2], mat2(7.0, 8.0, -2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (1.0);
	block.var[0][0][0] = (mat2(2.0, 6.0, -6.0, 2.0));
	block.var[0][0][1] = (mat2(4.0, 4.0, 7.0, 0.0));
	block.var[0][0][2] = (mat2(8.0, 0.0, -1.0, 8.0));
	block.var[0][1][0] = (mat2(1.0, -7.0, -2.0, -8.0));
	block.var[0][1][1] = (mat2(-9.0, 4.0, -4.0, -7.0));
	block.var[0][1][2] = (mat2(-9.0, -5.0, 3.0, -1.0));
	block.var[1][0][0] = (mat2(-4.0, -5.0, 7.0, -3.0));
	block.var[1][0][1] = (mat2(-1.0, 0.0, 6.0, -6.0));
	block.var[1][0][2] = (mat2(7.0, 4.0, -7.0, 1.0));
	block.var[1][1][0] = (mat2(-1.0, -6.0, -3.0, -9.0));
	block.var[1][1][1] = (mat2(-4.0, -8.0, -1.0, -8.0));
	block.var[1][1][2] = (mat2(1.0, -2.0, 9.0, 9.0));
	block.var[2][0][0] = (mat2(-8.0, -9.0, -7.0, 1.0));
	block.var[2][0][1] = (mat2(-2.0, -6.0, -8.0, -6.0));
	block.var[2][0][2] = (mat2(-6.0, 2.0, -9.0, 9.0));
	block.var[2][1][0] = (mat2(4.0, -3.0, -3.0, 0.0));
	block.var[2][1][1] = (mat2(-1.0, -5.0, -6.0, -8.0));
	block.var[2][1][2] = (mat2(0.0, 8.0, 8.0, -3.0));
	block.var[3][0][0] = (mat2(0.0, -3.0, -7.0, 8.0));
	block.var[3][0][1] = (mat2(8.0, 7.0, -3.0, 7.0));
	block.var[3][0][2] = (mat2(2.0, -8.0, -7.0, 5.0));
	block.var[3][1][0] = (mat2(-9.0, 5.0, -2.0, 1.0));
	block.var[3][1][1] = (mat2(9.0, -3.0, -5.0, -3.0));
	block.var[3][1][2] = (mat2(5.0, 0.0, -9.0, 4.0));
}
#version 450
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
	allOk = compare_float((block.padding), 5.0) && allOk;
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(-9.0, 4.0, 8.0, -1.0, 3.0, 0.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(1.0, 3.0, -8.0, 0.0, -7.0, 0.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][2], mat2x4(3.0, 1.0, -5.0, 2.0, 6.0, -6.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(-3.0, 7.0, -3.0, 8.0, 3.0, -9.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(0.0, -1.0, 2.0, 2.0, -8.0, -6.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][2], mat2x4(6.0, 6.0, 8.0, -9.0, 0.0, -9.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(0.0, -7.0, -6.0, -8.0, -6.0, -1.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(7.0, 5.0, 2.0, -3.0, -8.0, -7.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][2], mat2x4(4.0, 5.0, -3.0, -7.0, -9.0, 5.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(5.0, -1.0, 2.0, -3.0, -1.0, -9.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(8.0, 6.0, 1.0, 3.0, 9.0, -7.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][2], mat2x4(-3.0, 1.0, -2.0, 5.0, 3.0, 1.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(-5.0, 5.0, -9.0, -6.0, 9.0, 6.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(4.0, -4.0, -3.0, 7.0, 7.0, 5.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][2], mat2x4(-3.0, -3.0, -4.0, -9.0, 2.0, 0.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(-7.0, 7.0, 2.0, 1.0, -3.0, -3.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(-1.0, 6.0, -9.0, -1.0, 6.0, -9.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][2], mat2x4(-2.0, -9.0, 0.0, 5.0, -8.0, -5.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][0], mat2x4(0.0, -1.0, 2.0, 8.0, 9.0, 4.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][1], mat2x4(1.0, 5.0, 8.0, -4.0, -5.0, -3.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][2], mat2x4(9.0, -1.0, 1.0, -2.0, -4.0, -1.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][0], mat2x4(3.0, -7.0, 1.0, 1.0, 1.0, -1.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][1], mat2x4(-5.0, 0.0, -6.0, 4.0, -3.0, -9.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][2], mat2x4(1.0, 6.0, -4.0, 3.0, -3.0, 8.0, 8.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-7.0);
	block.var[0][0][0][0] = (vec4(-1.0, 8.0, 2.0, -1.0));
	block.var[0][0][0][1] = (vec4(2.0, 7.0, -9.0, -9.0));
	block.var[0][0][1][0] = (vec4(-5.0, 4.0, 7.0, 5.0));
	block.var[0][0][1][1] = (vec4(8.0, -8.0, -8.0, 6.0));
	block.var[0][0][2][0] = (vec4(-3.0, 7.0, 0.0, 4.0));
	block.var[0][0][2][1] = (vec4(6.0, -4.0, 0.0, -5.0));
	block.var[0][1][0][0] = (vec4(0.0, 0.0, -1.0, 9.0));
	block.var[0][1][0][1] = (vec4(1.0, -4.0, 7.0, 8.0));
	block.var[0][1][1][0] = (vec4(0.0, -5.0, -4.0, 2.0));
	block.var[0][1][1][1] = (vec4(1.0, -9.0, 5.0, -5.0));
	block.var[0][1][2][0] = (vec4(0.0, 5.0, 7.0, 8.0));
	block.var[0][1][2][1] = (vec4(-8.0, 8.0, 1.0, 6.0));
	block.var[1][0][0][0] = (vec4(8.0, -9.0, -8.0, 7.0));
	block.var[1][0][0][1] = (vec4(-7.0, -8.0, -6.0, -9.0));
	block.var[1][0][1][0] = (vec4(-8.0, 1.0, -2.0, 7.0));
	block.var[1][0][1][1] = (vec4(-6.0, -9.0, 9.0, 4.0));
	block.var[1][0][2][0] = (vec4(-6.0, 0.0, -3.0, -7.0));
	block.var[1][0][2][1] = (vec4(-7.0, 2.0, -1.0, 6.0));
	block.var[1][1][0][0] = (vec4(-3.0, -3.0, -4.0, -9.0));
	block.var[1][1][0][1] = (vec4(1.0, 6.0, -4.0, -8.0));
	block.var[1][1][1][0] = (vec4(-4.0, -9.0, -8.0, -1.0));
	block.var[1][1][1][1] = (vec4(-1.0, 1.0, -7.0, 7.0));
	block.var[1][1][2][0] = (vec4(-4.0, -6.0, -8.0, -8.0));
	block.var[1][1][2][1] = (vec4(-1.0, -2.0, 1.0, -8.0));
	block.var[2][0][0][0] = (vec4(-1.0, -5.0, 1.0, -1.0));
	block.var[2][0][0][1] = (vec4(8.0, 7.0, 6.0, -9.0));
	block.var[2][0][1][0] = (vec4(8.0, 2.0, 1.0, 9.0));
	block.var[2][0][1][1] = (vec4(-7.0, 6.0, -8.0, -2.0));
	block.var[2][0][2][0] = (vec4(-8.0, 6.0, 9.0, 5.0));
	block.var[2][0][2][1] = (vec4(5.0, -1.0, -1.0, 4.0));
	block.var[2][1][0][0] = (vec4(3.0, -6.0, 6.0, 2.0));
	block.var[2][1][0][1] = (vec4(1.0, 3.0, -6.0, -1.0));
	block.var[2][1][1][0] = (vec4(-4.0, -2.0, 6.0, 6.0));
	block.var[2][1][1][1] = (vec4(2.0, 1.0, 2.0, 8.0));
	block.var[2][1][2][0] = (vec4(9.0, 4.0, -4.0, 5.0));
	block.var[2][1][2][1] = (vec4(-4.0, 9.0, 9.0, -8.0));
	block.var[3][0][0][0] = (vec4(-3.0, 7.0, -9.0, -3.0));
	block.var[3][0][0][1] = (vec4(9.0, 2.0, 6.0, 6.0));
	block.var[3][0][1][0] = (vec4(1.0, 5.0, -4.0, 1.0));
	block.var[3][0][1][1] = (vec4(-6.0, 2.0, 6.0, -8.0));
	block.var[3][0][2][0] = (vec4(7.0, 7.0, -5.0, -8.0));
	block.var[3][0][2][1] = (vec4(0.0, -6.0, -4.0, 5.0));
	block.var[3][1][0][0] = (vec4(6.0, 2.0, 3.0, -1.0));
	block.var[3][1][0][1] = (vec4(2.0, 2.0, -7.0, 9.0));
	block.var[3][1][1][0] = (vec4(2.0, -3.0, 1.0, 5.0));
	block.var[3][1][1][1] = (vec4(2.0, -3.0, 3.0, -9.0));
	block.var[3][1][2][0] = (vec4(-1.0, -7.0, 1.0, 1.0));
	block.var[3][1][2][1] = (vec4(5.0, -1.0, -3.0, -6.0));
}
#version 450
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
	float padding;
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
	allOk = compare_float((block.padding), 0.0) && allOk;
	allOk = compare_mat4x3(block.var[0][0][0], mat4x3(1.0, -8.0, -1.0, 2.0, 8.0, 7.0, -7.0, 9.0, -3.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][1], mat4x3(2.0, 4.0, -2.0, -9.0, -6.0, 8.0, 9.0, 2.0, -2.0, 3.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][2], mat4x3(9.0, 2.0, -3.0, 3.0, 6.0, 6.0, 3.0, -3.0, -9.0, 4.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][0], mat4x3(-1.0, 2.0, 6.0, -2.0, 2.0, 1.0, 6.0, 6.0, -6.0, 4.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][1], mat4x3(-9.0, 2.0, 5.0, -7.0, 6.0, 6.0, 8.0, -4.0, -3.0, 0.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][2], mat4x3(-1.0, -5.0, -1.0, 3.0, -4.0, 2.0, 0.0, 7.0, -6.0, 6.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][0], mat4x3(4.0, -6.0, 7.0, -5.0, 8.0, -1.0, 8.0, 1.0, 9.0, -4.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][1], mat4x3(-6.0, 8.0, -9.0, -1.0, -2.0, 1.0, 7.0, 9.0, -5.0, 9.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][2], mat4x3(4.0, -7.0, 8.0, -1.0, -7.0, -3.0, 2.0, -7.0, 0.0, -3.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][0], mat4x3(1.0, -8.0, -6.0, 5.0, 7.0, -3.0, 7.0, -1.0, -7.0, -5.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][1], mat4x3(9.0, -3.0, 7.0, -8.0, -1.0, 1.0, -2.0, 2.0, -3.0, -3.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][2], mat4x3(6.0, 5.0, -3.0, 2.0, -5.0, -7.0, 0.0, 6.0, -1.0, 3.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][0], mat4x3(4.0, -8.0, 9.0, 2.0, 4.0, 5.0, -1.0, -4.0, -5.0, -7.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][1], mat4x3(-3.0, 4.0, -4.0, -8.0, 6.0, 7.0, 7.0, -6.0, -3.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][2], mat4x3(-9.0, -8.0, -4.0, -3.0, 6.0, 5.0, 4.0, 2.0, 3.0, 4.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][0], mat4x3(-3.0, -6.0, -3.0, -5.0, -8.0, 3.0, -5.0, -9.0, 4.0, -7.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][1], mat4x3(8.0, 7.0, 3.0, 8.0, -3.0, -9.0, -6.0, 2.0, 0.0, 0.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][2], mat4x3(-8.0, 4.0, 1.0, 8.0, -2.0, 5.0, -4.0, -7.0, -4.0, -1.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][0], mat4x3(-8.0, -6.0, 5.0, -7.0, 2.0, -2.0, 1.0, 6.0, 5.0, 5.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][1], mat4x3(1.0, 7.0, -6.0, -8.0, 9.0, 6.0, 2.0, -4.0, 4.0, 1.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][2], mat4x3(2.0, -5.0, -3.0, -3.0, 2.0, -4.0, -8.0, -1.0, 5.0, -7.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][0], mat4x3(7.0, -5.0, 5.0, -6.0, -9.0, -8.0, 4.0, 1.0, 0.0, 3.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][1], mat4x3(3.0, -9.0, 7.0, -8.0, -8.0, 4.0, -3.0, -8.0, -9.0, 5.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][2], mat4x3(-3.0, 2.0, -8.0, 3.0, -8.0, 3.0, 0.0, -9.0, 0.0, -8.0, 2.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2.0);
	block.var[0][0][0] = (mat4x3(4.0, 9.0, -7.0, 5.0, -8.0, 9.0, 1.0, 9.0, -6.0, -6.0, 1.0, 6.0));
	block.var[0][0][1] = (mat4x3(-2.0, -2.0, 5.0, 3.0, -6.0, -8.0, -5.0, 9.0, 8.0, -2.0, -1.0, 1.0));
	block.var[0][0][2] = (mat4x3(7.0, 0.0, 5.0, 9.0, -6.0, 5.0, 6.0, 2.0, 3.0, -8.0, 7.0, 3.0));
	block.var[0][1][0] = (mat4x3(7.0, -6.0, -4.0, -2.0, 0.0, 4.0, -2.0, 6.0, -6.0, -5.0, -8.0, -1.0));
	block.var[0][1][1] = (mat4x3(2.0, 4.0, 2.0, -2.0, 9.0, 0.0, -4.0, 6.0, -7.0, -4.0, 2.0, 1.0));
	block.var[0][1][2] = (mat4x3(2.0, -9.0, -3.0, 6.0, -9.0, 8.0, 2.0, 1.0, -8.0, 3.0, 2.0, 1.0));
	block.var[1][0][0] = (mat4x3(1.0, -4.0, 0.0, -7.0, 0.0, 1.0, 6.0, -5.0, -5.0, -2.0, 5.0, 0.0));
	block.var[1][0][1] = (mat4x3(7.0, 3.0, -7.0, -6.0, -5.0, -6.0, 2.0, -9.0, -1.0, 1.0, 6.0, 0.0));
	block.var[1][0][2] = (mat4x3(8.0, -4.0, -6.0, -7.0, -1.0, 3.0, -1.0, -6.0, 2.0, 2.0, -2.0, -3.0));
	block.var[1][1][0] = (mat4x3(4.0, 9.0, -7.0, -5.0, 2.0, -8.0, 0.0, 0.0, -4.0, 9.0, 5.0, -2.0));
	block.var[1][1][1] = (mat4x3(-9.0, 6.0, -9.0, -4.0, -7.0, 9.0, -5.0, 3.0, 5.0, -1.0, -4.0, 1.0));
	block.var[1][1][2] = (mat4x3(-1.0, -8.0, 4.0, 4.0, 4.0, -3.0, 4.0, 0.0, 0.0, -7.0, -1.0, 2.0));
	block.var[2][0][0] = (mat4x3(7.0, -5.0, -3.0, 0.0, -1.0, 8.0, -1.0, 8.0, -9.0, -7.0, 7.0, 8.0));
	block.var[2][0][1] = (mat4x3(2.0, 0.0, -8.0, -5.0, -8.0, -4.0, 9.0, -6.0, 6.0, -9.0, 9.0, -4.0));
	block.var[2][0][2] = (mat4x3(-2.0, -1.0, -9.0, 0.0, -2.0, 2.0, -1.0, 9.0, 6.0, 5.0, -6.0, 9.0));
	block.var[2][1][0] = (mat4x3(6.0, 9.0, -5.0, -9.0, -9.0, 5.0, 6.0, 4.0, 6.0, -3.0, 1.0, 3.0));
	block.var[2][1][1] = (mat4x3(-1.0, 9.0, -2.0, 9.0, 6.0, -9.0, 4.0, 3.0, -7.0, -3.0, 3.0, -7.0));
	block.var[2][1][2] = (mat4x3(9.0, 6.0, -6.0, 1.0, 1.0, -3.0, -1.0, 8.0, -2.0, 3.0, -3.0, -5.0));
	block.var[3][0][0] = (mat4x3(-4.0, 0.0, 0.0, -6.0, -4.0, 1.0, -9.0, -9.0, -6.0, 2.0, 1.0, -9.0));
	block.var[3][0][1] = (mat4x3(6.0, -7.0, 6.0, 5.0, 4.0, -7.0, -3.0, 6.0, 5.0, 8.0, -2.0, 3.0));
	block.var[3][0][2] = (mat4x3(0.0, 7.0, -9.0, -2.0, 7.0, -3.0, 4.0, -5.0, -5.0, -2.0, -3.0, -2.0));
	block.var[3][1][0] = (mat4x3(4.0, 0.0, -9.0, 9.0, -1.0, 0.0, -9.0, -3.0, 6.0, -2.0, 0.0, -5.0));
	block.var[3][1][1] = (mat4x3(-9.0, 2.0, -1.0, 4.0, 0.0, -4.0, 1.0, 3.0, -9.0, -5.0, -6.0, 7.0));
	block.var[3][1][2] = (mat4x3(-4.0, 3.0, 0.0, -2.0, -5.0, -8.0, 3.0, 5.0, -1.0, 3.0, 5.0, 9.0));
}
#version 450
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
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_mat4x3(block.var[0][0][0], mat4x3(9.0, -7.0, -7.0, 8.0, 2.0, 7.0, 3.0, -1.0, -1.0, 8.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][1], mat4x3(-8.0, -6.0, 3.0, -8.0, -8.0, -4.0, 5.0, -9.0, 2.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][2], mat4x3(4.0, -4.0, -7.0, 9.0, -3.0, -7.0, 9.0, 2.0, 9.0, 1.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][0], mat4x3(-1.0, -1.0, 6.0, 4.0, -5.0, 5.0, 4.0, 2.0, -9.0, 3.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][1], mat4x3(-7.0, -5.0, 7.0, 0.0, 0.0, -1.0, -5.0, -7.0, -7.0, -4.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][2], mat4x3(2.0, 6.0, 1.0, -3.0, 0.0, 1.0, -6.0, -3.0, 5.0, 9.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][0], mat4x3(6.0, 0.0, 2.0, 2.0, 3.0, -9.0, 4.0, 5.0, -5.0, 7.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][1], mat4x3(-8.0, 0.0, 5.0, -5.0, 7.0, 9.0, -8.0, 3.0, -6.0, 4.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][2], mat4x3(-3.0, 0.0, -2.0, 5.0, 1.0, 1.0, 6.0, 5.0, -4.0, 3.0, 0.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][0], mat4x3(-6.0, 8.0, 9.0, 3.0, -5.0, -8.0, 4.0, 9.0, -8.0, 9.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][1], mat4x3(-2.0, 6.0, 7.0, 5.0, -4.0, 3.0, 1.0, 5.0, -7.0, -4.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][2], mat4x3(5.0, 6.0, 2.0, 5.0, 5.0, 4.0, 6.0, -4.0, -2.0, -5.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][0], mat4x3(-6.0, -9.0, 6.0, 7.0, -3.0, -3.0, 9.0, 4.0, -8.0, -7.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][1], mat4x3(0.0, 9.0, -8.0, -2.0, -2.0, -1.0, -2.0, -1.0, 2.0, 5.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][2], mat4x3(-2.0, 8.0, -3.0, -7.0, 1.0, -6.0, 8.0, 4.0, -6.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][0], mat4x3(-6.0, -1.0, -4.0, 1.0, 5.0, -2.0, 2.0, -5.0, 0.0, -2.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][1], mat4x3(9.0, -7.0, -9.0, -7.0, -1.0, 9.0, -4.0, 0.0, 4.0, 4.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][2], mat4x3(1.0, -6.0, 3.0, 7.0, -1.0, 0.0, 8.0, 9.0, 7.0, -3.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][0], mat4x3(3.0, 7.0, 9.0, 7.0, 9.0, -2.0, -4.0, -9.0, 4.0, -8.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][1], mat4x3(6.0, -5.0, -7.0, 3.0, -9.0, -5.0, -8.0, 8.0, -2.0, 2.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][2], mat4x3(2.0, 8.0, -1.0, 5.0, 2.0, 7.0, 1.0, 4.0, -8.0, 4.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][0], mat4x3(3.0, 7.0, 2.0, 9.0, 2.0, 9.0, 2.0, 9.0, 4.0, -9.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][1], mat4x3(4.0, 1.0, 2.0, 5.0, -9.0, -7.0, 3.0, -2.0, 3.0, 3.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][2], mat4x3(2.0, -4.0, 4.0, -8.0, -3.0, 4.0, 4.0, 0.0, -8.0, 3.0, 3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (1.0);
	block.var[0][0][0][0] = (vec3(-7.0, 2.0, 3.0));
	block.var[0][0][0][1] = (vec3(1.0, -2.0, -1.0));
	block.var[0][0][0][2] = (vec3(-5.0, -1.0, 9.0));
	block.var[0][0][0][3] = (vec3(3.0, -7.0, 8.0));
	block.var[0][0][1][0] = (vec3(4.0, 9.0, -6.0));
	block.var[0][0][1][1] = (vec3(7.0, 6.0, -5.0));
	block.var[0][0][1][2] = (vec3(2.0, 6.0, 3.0));
	block.var[0][0][1][3] = (vec3(-4.0, 3.0, 2.0));
	block.var[0][0][2][0] = (vec3(-3.0, -3.0, -7.0));
	block.var[0][0][2][1] = (vec3(-5.0, 3.0, 4.0));
	block.var[0][0][2][2] = (vec3(-4.0, -2.0, 8.0));
	block.var[0][0][2][3] = (vec3(7.0, -1.0, -1.0));
	block.var[0][1][0][0] = (vec3(1.0, -7.0, -9.0));
	block.var[0][1][0][1] = (vec3(4.0, -9.0, 8.0));
	block.var[0][1][0][2] = (vec3(2.0, 5.0, -4.0));
	block.var[0][1][0][3] = (vec3(5.0, -2.0, -9.0));
	block.var[0][1][1][0] = (vec3(-3.0, 6.0, -3.0));
	block.var[0][1][1][1] = (vec3(7.0, -9.0, -4.0));
	block.var[0][1][1][2] = (vec3(9.0, 6.0, 2.0));
	block.var[0][1][1][3] = (vec3(-9.0, 5.0, -3.0));
	block.var[0][1][2][0] = (vec3(-9.0, 5.0, -6.0));
	block.var[0][1][2][1] = (vec3(5.0, -7.0, -9.0));
	block.var[0][1][2][2] = (vec3(0.0, 9.0, 9.0));
	block.var[0][1][2][3] = (vec3(-5.0, 2.0, -9.0));
	block.var[1][0][0][0] = (vec3(-4.0, -7.0, -7.0));
	block.var[1][0][0][1] = (vec3(8.0, 4.0, -6.0));
	block.var[1][0][0][2] = (vec3(6.0, 0.0, 1.0));
	block.var[1][0][0][3] = (vec3(-8.0, 8.0, 7.0));
	block.var[1][0][1][0] = (vec3(9.0, 9.0, -6.0));
	block.var[1][0][1][1] = (vec3(0.0, 1.0, 1.0));
	block.var[1][0][1][2] = (vec3(2.0, 7.0, 2.0));
	block.var[1][0][1][3] = (vec3(-1.0, -8.0, -3.0));
	block.var[1][0][2][0] = (vec3(3.0, -1.0, -1.0));
	block.var[1][0][2][1] = (vec3(-2.0, 9.0, -5.0));
	block.var[1][0][2][2] = (vec3(8.0, -6.0, -5.0));
	block.var[1][0][2][3] = (vec3(-6.0, 5.0, -9.0));
	block.var[1][1][0][0] = (vec3(-2.0, 7.0, 7.0));
	block.var[1][1][0][1] = (vec3(-2.0, 7.0, -9.0));
	block.var[1][1][0][2] = (vec3(5.0, 5.0, -4.0));
	block.var[1][1][0][3] = (vec3(5.0, 5.0, 6.0));
	block.var[1][1][1][0] = (vec3(-3.0, 1.0, -7.0));
	block.var[1][1][1][1] = (vec3(-1.0, 0.0, -9.0));
	block.var[1][1][1][2] = (vec3(0.0, -4.0, 9.0));
	block.var[1][1][1][3] = (vec3(-3.0, 7.0, -6.0));
	block.var[1][1][2][0] = (vec3(6.0, 1.0, -2.0));
	block.var[1][1][2][1] = (vec3(2.0, 8.0, 9.0));
	block.var[1][1][2][2] = (vec3(2.0, -8.0, -9.0));
	block.var[1][1][2][3] = (vec3(-5.0, 7.0, -1.0));
	block.var[2][0][0][0] = (vec3(5.0, 6.0, -7.0));
	block.var[2][0][0][1] = (vec3(-8.0, 1.0, 8.0));
	block.var[2][0][0][2] = (vec3(1.0, 6.0, -1.0));
	block.var[2][0][0][3] = (vec3(3.0, -2.0, -5.0));
	block.var[2][0][1][0] = (vec3(5.0, -3.0, 2.0));
	block.var[2][0][1][1] = (vec3(-5.0, 2.0, -2.0));
	block.var[2][0][1][2] = (vec3(-7.0, -9.0, -1.0));
	block.var[2][0][1][3] = (vec3(0.0, -6.0, -2.0));
	block.var[2][0][2][0] = (vec3(-9.0, -4.0, 9.0));
	block.var[2][0][2][1] = (vec3(4.0, -4.0, 5.0));
	block.var[2][0][2][2] = (vec3(7.0, 1.0, 7.0));
	block.var[2][0][2][3] = (vec3(-3.0, -7.0, -9.0));
	block.var[2][1][0][0] = (vec3(4.0, 7.0, -4.0));
	block.var[2][1][0][1] = (vec3(6.0, 2.0, -4.0));
	block.var[2][1][0][2] = (vec3(8.0, -8.0, -1.0));
	block.var[2][1][0][3] = (vec3(-5.0, 2.0, -8.0));
	block.var[2][1][1][0] = (vec3(-8.0, -2.0, -1.0));
	block.var[2][1][1][1] = (vec3(-4.0, 5.0, 4.0));
	block.var[2][1][1][2] = (vec3(-6.0, -1.0, 7.0));
	block.var[2][1][1][3] = (vec3(-9.0, 2.0, 1.0));
	block.var[2][1][2][0] = (vec3(-9.0, 4.0, 7.0));
	block.var[2][1][2][1] = (vec3(-5.0, -9.0, 1.0));
	block.var[2][1][2][2] = (vec3(-1.0, 2.0, -5.0));
	block.var[2][1][2][3] = (vec3(-1.0, 9.0, 3.0));
	block.var[3][0][0][0] = (vec3(4.0, 0.0, 0.0));
	block.var[3][0][0][1] = (vec3(0.0, -3.0, 3.0));
	block.var[3][0][0][2] = (vec3(1.0, 8.0, 0.0));
	block.var[3][0][0][3] = (vec3(5.0, 4.0, -2.0));
	block.var[3][0][1][0] = (vec3(-8.0, 7.0, -9.0));
	block.var[3][0][1][1] = (vec3(3.0, -2.0, -3.0));
	block.var[3][0][1][2] = (vec3(-5.0, 1.0, -4.0));
	block.var[3][0][1][3] = (vec3(9.0, -8.0, 5.0));
	block.var[3][0][2][0] = (vec3(3.0, 7.0, -3.0));
	block.var[3][0][2][1] = (vec3(-2.0, 2.0, -9.0));
	block.var[3][0][2][2] = (vec3(0.0, 9.0, 5.0));
	block.var[3][0][2][3] = (vec3(5.0, 8.0, -5.0));
	block.var[3][1][0][0] = (vec3(4.0, -5.0, 8.0));
	block.var[3][1][0][1] = (vec3(4.0, 6.0, 1.0));
	block.var[3][1][0][2] = (vec3(-4.0, 5.0, -7.0));
	block.var[3][1][0][3] = (vec3(6.0, 7.0, -2.0));
	block.var[3][1][1][0] = (vec3(5.0, -8.0, -5.0));
	block.var[3][1][1][1] = (vec3(-7.0, -4.0, -3.0));
	block.var[3][1][1][2] = (vec3(-1.0, 8.0, -8.0));
	block.var[3][1][1][3] = (vec3(-3.0, -9.0, -2.0));
	block.var[3][1][2][0] = (vec3(-3.0, -2.0, -8.0));
	block.var[3][1][2][1] = (vec3(-3.0, -2.0, -2.0));
	block.var[3][1][2][2] = (vec3(-9.0, 4.0, 7.0));
	block.var[3][1][2][3] = (vec3(-6.0, 6.0, 6.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0][0][0], mat3x4(-1.0, -2.0, -5.0, -5.0, -8.0, 2.0, -9.0, 8.0, -1.0, -4.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][1], mat3x4(2.0, 9.0, -2.0, 5.0, 1.0, 4.0, -5.0, 3.0, -6.0, 9.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(-9.0, -9.0, 1.0, 6.0, -2.0, -2.0, -2.0, 1.0, 3.0, 5.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(-6.0, 1.0, -4.0, 2.0, 9.0, -9.0, -2.0, 6.0, 1.0, 4.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][0], mat3x4(-7.0, -8.0, -1.0, 5.0, 6.0, -6.0, -4.0, 9.0, -5.0, 3.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][1], mat3x4(-9.0, 3.0, 1.0, 8.0, 7.0, 0.0, 7.0, 9.0, -1.0, 9.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][0], mat3x4(-5.0, -7.0, 0.0, -4.0, 1.0, 2.0, -2.0, -3.0, -4.0, 2.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][1], mat3x4(6.0, -3.0, 9.0, 7.0, -4.0, -2.0, 6.0, 5.0, 2.0, -2.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(-2.0, 8.0, -3.0, 3.0, 5.0, 1.0, -8.0, 4.0, 7.0, 5.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(-3.0, 1.0, 4.0, 2.0, -2.0, -6.0, -4.0, 8.0, -8.0, -1.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(-6.0, 5.0, 3.0, -1.0, 6.0, 5.0, 6.0, -4.0, 6.0, -9.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(-8.0, 6.0, 7.0, -3.0, -3.0, 5.0, 9.0, 6.0, 7.0, 2.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][0], mat3x4(3.0, 8.0, 0.0, -6.0, -6.0, -1.0, -2.0, 5.0, 1.0, -3.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][1], mat3x4(0.0, 8.0, -9.0, 6.0, -5.0, 3.0, -8.0, -1.0, -9.0, 3.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][0], mat3x4(0.0, -8.0, -2.0, 7.0, 5.0, -6.0, 9.0, 6.0, 4.0, -4.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][1], mat3x4(-2.0, 8.0, -4.0, 7.0, 4.0, 5.0, 1.0, -1.0, 3.0, 0.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(6.0, -6.0, -8.0, 8.0, 4.0, 9.0, 6.0, -6.0, 9.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(2.0, 8.0, -9.0, 0.0, 3.0, 2.0, 4.0, -9.0, -1.0, 1.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(-9.0, 1.0, 2.0, 0.0, -3.0, -3.0, 0.0, -7.0, 9.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(4.0, 8.0, -1.0, 7.0, 0.0, 2.0, 3.0, 3.0, 7.0, 8.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][0], mat3x4(-8.0, 8.0, -1.0, 9.0, 1.0, -5.0, -4.0, 3.0, 5.0, 7.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][1], mat3x4(-2.0, 6.0, 5.0, 9.0, 2.0, -3.0, 3.0, 8.0, 8.0, 6.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][0], mat3x4(-6.0, 1.0, -9.0, 0.0, -5.0, 8.0, -9.0, 1.0, -2.0, -2.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][1], mat3x4(-7.0, -6.0, -7.0, 6.0, 0.0, -6.0, 7.0, 3.0, 0.0, -7.0, 7.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3x4(-1.0, 6.0, 4.0, -6.0, -6.0, 0.0, -6.0, 9.0, -5.0, 3.0, -3.0, -2.0));
	block.var[0][0][1] = (mat3x4(-9.0, 9.0, -2.0, 3.0, -4.0, 2.0, -4.0, -4.0, 2.0, 1.0, 3.0, -2.0));
	block.var[0][1][0] = (mat3x4(3.0, 1.0, -4.0, -8.0, -9.0, -6.0, -2.0, -8.0, 0.0, 0.0, 1.0, 5.0));
	block.var[0][1][1] = (mat3x4(1.0, -1.0, -1.0, -7.0, -9.0, -5.0, 6.0, -4.0, -3.0, -9.0, -2.0, 8.0));
	block.var[0][2][0] = (mat3x4(-5.0, -6.0, -9.0, -2.0, 3.0, 0.0, 8.0, 5.0, 9.0, 8.0, 5.0, -4.0));
	block.var[0][2][1] = (mat3x4(5.0, 8.0, 3.0, -2.0, -6.0, -3.0, 3.0, 3.0, 0.0, 9.0, -9.0, 4.0));
	block.var[0][3][0] = (mat3x4(2.0, -3.0, -5.0, 8.0, -5.0, 3.0, 2.0, 1.0, 4.0, -5.0, -7.0, -9.0));
	block.var[0][3][1] = (mat3x4(5.0, 1.0, 4.0, 9.0, -7.0, -7.0, -7.0, 9.0, -4.0, 1.0, 3.0, 5.0));
	block.var[1][0][0] = (mat3x4(-7.0, 6.0, 0.0, 4.0, -1.0, -2.0, 4.0, -1.0, 4.0, 1.0, -9.0, 5.0));
	block.var[1][0][1] = (mat3x4(-9.0, 1.0, -3.0, -5.0, -5.0, 8.0, 4.0, -4.0, -5.0, 7.0, 3.0, -5.0));
	block.var[1][1][0] = (mat3x4(9.0, 2.0, -4.0, -9.0, -7.0, 4.0, -5.0, -9.0, 2.0, -9.0, 4.0, 6.0));
	block.var[1][1][1] = (mat3x4(4.0, -5.0, 0.0, -5.0, -7.0, 5.0, 0.0, 7.0, -3.0, -3.0, 9.0, -4.0));
	block.var[1][2][0] = (mat3x4(-8.0, -7.0, 4.0, -2.0, -9.0, -4.0, -3.0, -8.0, 7.0, 8.0, -1.0, -7.0));
	block.var[1][2][1] = (mat3x4(0.0, -4.0, 5.0, 2.0, 2.0, -3.0, 7.0, -3.0, 7.0, 0.0, -2.0, 0.0));
	block.var[1][3][0] = (mat3x4(-6.0, 6.0, 7.0, 7.0, -3.0, -3.0, -7.0, -3.0, 5.0, -8.0, 3.0, 3.0));
	block.var[1][3][1] = (mat3x4(-9.0, 1.0, 5.0, 5.0, -5.0, 8.0, 4.0, -4.0, 9.0, -2.0, 1.0, -8.0));
	block.var[2][0][0] = (mat3x4(-4.0, 4.0, 3.0, 8.0, -8.0, 9.0, -3.0, -2.0, -4.0, 3.0, -3.0, 7.0));
	block.var[2][0][1] = (mat3x4(-9.0, -3.0, 7.0, -7.0, -6.0, 5.0, -4.0, -8.0, 2.0, -3.0, -9.0, -5.0));
	block.var[2][1][0] = (mat3x4(-9.0, 0.0, 8.0, 4.0, -9.0, 6.0, 9.0, 3.0, -8.0, -4.0, -4.0, -2.0));
	block.var[2][1][1] = (mat3x4(6.0, -3.0, -7.0, -8.0, 6.0, -1.0, -8.0, 6.0, -1.0, 6.0, -3.0, 2.0));
	block.var[2][2][0] = (mat3x4(-3.0, 7.0, -2.0, 4.0, -6.0, -3.0, 4.0, -8.0, 7.0, -3.0, -5.0, -5.0));
	block.var[2][2][1] = (mat3x4(-6.0, -2.0, 3.0, 6.0, 7.0, 1.0, -6.0, 7.0, -9.0, 5.0, 5.0, 3.0));
	block.var[2][3][0] = (mat3x4(-2.0, 9.0, 3.0, 9.0, 9.0, -1.0, -9.0, 3.0, -9.0, 2.0, 2.0, -6.0));
	block.var[2][3][1] = (mat3x4(-9.0, 4.0, 0.0, 2.0, 4.0, -2.0, 9.0, -7.0, 4.0, -5.0, 3.0, -2.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(8.0, -9.0, 9.0, -6.0, -8.0, -7.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(3.0, 6.0, -4.0, 1.0, 5.0, 2.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(0.0, 7.0, -8.0, 7.0, 2.0, -1.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(5.0, -3.0, 1.0, -3.0, -2.0, 3.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][0], mat4x2(-5.0, 5.0, 2.0, -9.0, -1.0, 9.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][1], mat4x2(-9.0, -9.0, 4.0, 4.0, 6.0, -7.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][0], mat4x2(6.0, 8.0, 7.0, 0.0, -5.0, 3.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][1], mat4x2(-9.0, 9.0, -5.0, 9.0, -3.0, 8.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(2.0, -9.0, 8.0, 9.0, 2.0, -7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(-6.0, 7.0, 6.0, 4.0, 1.0, -8.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(-6.0, 2.0, 4.0, 7.0, -8.0, 0.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(-4.0, 3.0, 2.0, -4.0, -2.0, 1.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][0], mat4x2(-2.0, -4.0, 4.0, 7.0, 4.0, 9.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][1], mat4x2(-8.0, 0.0, -3.0, -4.0, 4.0, -9.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][0], mat4x2(-6.0, 7.0, 6.0, -8.0, 7.0, 6.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][1], mat4x2(-7.0, 0.0, -1.0, 6.0, -3.0, 7.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(7.0, 6.0, -2.0, -3.0, 3.0, 9.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(3.0, -3.0, 6.0, -6.0, -5.0, -5.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(-7.0, 1.0, 1.0, 6.0, -5.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(0.0, 8.0, -2.0, 7.0, 8.0, -1.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][0], mat4x2(7.0, 6.0, -7.0, 5.0, 0.0, -2.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][1], mat4x2(7.0, -5.0, 3.0, -8.0, 1.0, -3.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][0], mat4x2(-3.0, -5.0, -2.0, -9.0, 3.0, 4.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][1], mat4x2(-6.0, -2.0, -3.0, -3.0, -9.0, 4.0, -5.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(4.0, -9.0));
	block.var[0][0][0][1] = (vec2(-2.0, 8.0));
	block.var[0][0][0][2] = (vec2(-4.0, 4.0));
	block.var[0][0][0][3] = (vec2(9.0, 5.0));
	block.var[0][0][1][0] = (vec2(-2.0, 4.0));
	block.var[0][0][1][1] = (vec2(6.0, -8.0));
	block.var[0][0][1][2] = (vec2(-5.0, -1.0));
	block.var[0][0][1][3] = (vec2(9.0, 0.0));
	block.var[0][1][0][0] = (vec2(6.0, 4.0));
	block.var[0][1][0][1] = (vec2(5.0, 2.0));
	block.var[0][1][0][2] = (vec2(6.0, -4.0));
	block.var[0][1][0][3] = (vec2(-4.0, 8.0));
	block.var[0][1][1][0] = (vec2(5.0, -1.0));
	block.var[0][1][1][1] = (vec2(7.0, 0.0));
	block.var[0][1][1][2] = (vec2(-7.0, -4.0));
	block.var[0][1][1][3] = (vec2(1.0, -1.0));
	block.var[0][2][0][0] = (vec2(-8.0, 0.0));
	block.var[0][2][0][1] = (vec2(-4.0, 6.0));
	block.var[0][2][0][2] = (vec2(-7.0, 4.0));
	block.var[0][2][0][3] = (vec2(-6.0, -5.0));
	block.var[0][2][1][0] = (vec2(-2.0, 7.0));
	block.var[0][2][1][1] = (vec2(-3.0, 0.0));
	block.var[0][2][1][2] = (vec2(-8.0, -9.0));
	block.var[0][2][1][3] = (vec2(6.0, 0.0));
	block.var[0][3][0][0] = (vec2(6.0, 5.0));
	block.var[0][3][0][1] = (vec2(3.0, 5.0));
	block.var[0][3][0][2] = (vec2(2.0, 5.0));
	block.var[0][3][0][3] = (vec2(-8.0, 8.0));
	block.var[0][3][1][0] = (vec2(-9.0, 3.0));
	block.var[0][3][1][1] = (vec2(-5.0, 3.0));
	block.var[0][3][1][2] = (vec2(3.0, 5.0));
	block.var[0][3][1][3] = (vec2(9.0, -6.0));
	block.var[1][0][0][0] = (vec2(5.0, -2.0));
	block.var[1][0][0][1] = (vec2(4.0, -5.0));
	block.var[1][0][0][2] = (vec2(-2.0, -4.0));
	block.var[1][0][0][3] = (vec2(6.0, 4.0));
	block.var[1][0][1][0] = (vec2(5.0, 5.0));
	block.var[1][0][1][1] = (vec2(-6.0, -5.0));
	block.var[1][0][1][2] = (vec2(7.0, -6.0));
	block.var[1][0][1][3] = (vec2(8.0, 5.0));
	block.var[1][1][0][0] = (vec2(7.0, -6.0));
	block.var[1][1][0][1] = (vec2(9.0, -9.0));
	block.var[1][1][0][2] = (vec2(7.0, -8.0));
	block.var[1][1][0][3] = (vec2(5.0, -4.0));
	block.var[1][1][1][0] = (vec2(4.0, 3.0));
	block.var[1][1][1][1] = (vec2(9.0, 1.0));
	block.var[1][1][1][2] = (vec2(-6.0, -3.0));
	block.var[1][1][1][3] = (vec2(-7.0, 9.0));
	block.var[1][2][0][0] = (vec2(6.0, -7.0));
	block.var[1][2][0][1] = (vec2(2.0, 3.0));
	block.var[1][2][0][2] = (vec2(-4.0, -6.0));
	block.var[1][2][0][3] = (vec2(5.0, -1.0));
	block.var[1][2][1][0] = (vec2(-8.0, 7.0));
	block.var[1][2][1][1] = (vec2(0.0, 0.0));
	block.var[1][2][1][2] = (vec2(-7.0, -3.0));
	block.var[1][2][1][3] = (vec2(-7.0, -3.0));
	block.var[1][3][0][0] = (vec2(4.0, -3.0));
	block.var[1][3][0][1] = (vec2(-1.0, 3.0));
	block.var[1][3][0][2] = (vec2(0.0, 0.0));
	block.var[1][3][0][3] = (vec2(-4.0, 6.0));
	block.var[1][3][1][0] = (vec2(-3.0, 9.0));
	block.var[1][3][1][1] = (vec2(-9.0, 4.0));
	block.var[1][3][1][2] = (vec2(0.0, 1.0));
	block.var[1][3][1][3] = (vec2(4.0, 4.0));
	block.var[2][0][0][0] = (vec2(5.0, -5.0));
	block.var[2][0][0][1] = (vec2(-6.0, -3.0));
	block.var[2][0][0][2] = (vec2(-1.0, -1.0));
	block.var[2][0][0][3] = (vec2(-2.0, 6.0));
	block.var[2][0][1][0] = (vec2(-1.0, -8.0));
	block.var[2][0][1][1] = (vec2(-5.0, 5.0));
	block.var[2][0][1][2] = (vec2(5.0, 9.0));
	block.var[2][0][1][3] = (vec2(-7.0, 0.0));
	block.var[2][1][0][0] = (vec2(3.0, 5.0));
	block.var[2][1][0][1] = (vec2(3.0, -7.0));
	block.var[2][1][0][2] = (vec2(0.0, 6.0));
	block.var[2][1][0][3] = (vec2(-8.0, -2.0));
	block.var[2][1][1][0] = (vec2(7.0, -6.0));
	block.var[2][1][1][1] = (vec2(2.0, -2.0));
	block.var[2][1][1][2] = (vec2(8.0, 8.0));
	block.var[2][1][1][3] = (vec2(1.0, -3.0));
	block.var[2][2][0][0] = (vec2(2.0, 6.0));
	block.var[2][2][0][1] = (vec2(3.0, 3.0));
	block.var[2][2][0][2] = (vec2(-8.0, -2.0));
	block.var[2][2][0][3] = (vec2(-4.0, 0.0));
	block.var[2][2][1][0] = (vec2(2.0, 5.0));
	block.var[2][2][1][1] = (vec2(2.0, 3.0));
	block.var[2][2][1][2] = (vec2(-3.0, 2.0));
	block.var[2][2][1][3] = (vec2(4.0, 1.0));
	block.var[2][3][0][0] = (vec2(9.0, -8.0));
	block.var[2][3][0][1] = (vec2(-6.0, 2.0));
	block.var[2][3][0][2] = (vec2(-2.0, -9.0));
	block.var[2][3][0][3] = (vec2(-4.0, 6.0));
	block.var[2][3][1][0] = (vec2(1.0, 7.0));
	block.var[2][3][1][1] = (vec2(-8.0, -1.0));
	block.var[2][3][1][2] = (vec2(8.0, 4.0));
	block.var[2][3][1][3] = (vec2(7.0, -3.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0][0][0], mat4(3.0, 0.0, 6.0, 0.0, -6.0, 5.0, 3.0, -4.0, -9.0, -8.0, 9.0, 3.0, 2.0, -9.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][1], mat4(-8.0, 0.0, 1.0, -5.0, -2.0, 1.0, -6.0, -8.0, -1.0, 5.0, -8.0, 0.0, -6.0, 3.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][0], mat4(-4.0, 1.0, 3.0, -2.0, -8.0, -3.0, 0.0, 4.0, -3.0, -4.0, 6.0, -7.0, 5.0, 4.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][1], mat4(5.0, 5.0, 7.0, -7.0, 1.0, -4.0, 9.0, 7.0, 9.0, -2.0, -8.0, 8.0, -2.0, -7.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[0][2][0], mat4(4.0, 9.0, 6.0, -4.0, -3.0, 3.0, -3.0, 5.0, -3.0, 6.0, -9.0, 2.0, 5.0, 7.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[0][2][1], mat4(-5.0, -3.0, 7.0, -5.0, -5.0, -7.0, -9.0, 5.0, 3.0, -1.0, 9.0, -3.0, 4.0, 8.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[0][3][0], mat4(-9.0, 0.0, -3.0, -3.0, -4.0, -6.0, -9.0, 9.0, 8.0, 6.0, 3.0, -2.0, 1.0, 5.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[0][3][1], mat4(5.0, -4.0, -6.0, -5.0, 7.0, -3.0, 5.0, -5.0, -8.0, 2.0, -5.0, 8.0, 2.0, -1.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][0], mat4(-9.0, -3.0, 4.0, 6.0, 2.0, 3.0, 0.0, 7.0, 9.0, -9.0, -6.0, 8.0, 0.0, -9.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][1], mat4(4.0, -7.0, 1.0, -7.0, -1.0, 5.0, 9.0, -8.0, 2.0, -6.0, 1.0, 7.0, 4.0, 1.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][0], mat4(5.0, 9.0, 4.0, -3.0, 1.0, 9.0, 1.0, 8.0, 6.0, -1.0, -3.0, -2.0, 5.0, -3.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][1], mat4(-5.0, -8.0, 8.0, -5.0, -4.0, -4.0, -8.0, 9.0, -5.0, 5.0, 8.0, -9.0, 2.0, 8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[1][2][0], mat4(-6.0, -7.0, -9.0, 4.0, 6.0, -4.0, 2.0, -1.0, 9.0, 3.0, -3.0, 3.0, -6.0, 5.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[1][2][1], mat4(-8.0, -6.0, 5.0, 0.0, -1.0, -7.0, 4.0, 2.0, -1.0, -9.0, 6.0, 4.0, -9.0, -7.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[1][3][0], mat4(6.0, -2.0, 6.0, -6.0, 6.0, 4.0, 7.0, 9.0, -7.0, -3.0, -4.0, 9.0, 5.0, -8.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[1][3][1], mat4(-8.0, 1.0, 4.0, -5.0, 3.0, 6.0, -6.0, 7.0, -1.0, -4.0, 7.0, 1.0, -6.0, 5.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][0], mat4(-3.0, 5.0, -7.0, -5.0, -9.0, 3.0, 0.0, 0.0, 3.0, 2.0, -5.0, -8.0, 9.0, 3.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][1], mat4(9.0, -1.0, 6.0, 9.0, 0.0, -6.0, 0.0, 1.0, -1.0, 5.0, -7.0, -8.0, 1.0, -3.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][0], mat4(3.0, 5.0, -4.0, -4.0, -3.0, -5.0, -8.0, -3.0, -6.0, -5.0, 0.0, -6.0, -9.0, -2.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][1], mat4(-1.0, 8.0, 5.0, 0.0, -7.0, -4.0, 7.0, -7.0, 2.0, -4.0, -2.0, -8.0, 5.0, -4.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[2][2][0], mat4(-3.0, 8.0, -5.0, 2.0, -2.0, -2.0, 9.0, 4.0, 0.0, 3.0, -5.0, 4.0, 0.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[2][2][1], mat4(7.0, -4.0, 0.0, -2.0, -9.0, -9.0, 0.0, -9.0, 7.0, 9.0, -9.0, -9.0, -8.0, 3.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[2][3][0], mat4(8.0, 6.0, 6.0, 7.0, 8.0, 4.0, 5.0, 0.0, 6.0, -6.0, 6.0, 7.0, 9.0, -2.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[2][3][1], mat4(4.0, -6.0, -6.0, -8.0, 9.0, 3.0, 8.0, -6.0, -4.0, -5.0, -7.0, -4.0, -7.0, -4.0, 3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4(4.0, 7.0, -2.0, -5.0, 3.0, -6.0, 0.0, -4.0, 2.0, -9.0, -1.0, 6.0, 8.0, 9.0, 5.0, -6.0));
	block.var[0][0][1] = (mat4(1.0, 3.0, -7.0, -5.0, 5.0, -5.0, -2.0, -4.0, 9.0, 5.0, 2.0, -3.0, -8.0, 2.0, 1.0, 5.0));
	block.var[0][1][0] = (mat4(4.0, -8.0, -4.0, -7.0, -9.0, 6.0, 9.0, 1.0, 2.0, -8.0, 2.0, 5.0, -6.0, -1.0, -7.0, 3.0));
	block.var[0][1][1] = (mat4(-9.0, -2.0, 3.0, -9.0, -1.0, -2.0, 6.0, 4.0, 7.0, -4.0, 1.0, -8.0, 4.0, 9.0, -7.0, -6.0));
	block.var[0][2][0] = (mat4(5.0, 4.0, 4.0, 1.0, 7.0, -5.0, 1.0, 7.0, 8.0, 8.0, 5.0, 4.0, 9.0, -4.0, 9.0, 7.0));
	block.var[0][2][1] = (mat4(8.0, 7.0, -8.0, 1.0, -7.0, 7.0, 0.0, -2.0, 1.0, -8.0, -2.0, 8.0, -8.0, 9.0, -6.0, -1.0));
	block.var[0][3][0] = (mat4(4.0, 2.0, -9.0, 1.0, 5.0, -7.0, -4.0, -2.0, -7.0, -5.0, 1.0, -6.0, -8.0, 6.0, -2.0, 4.0));
	block.var[0][3][1] = (mat4(-4.0, 2.0, -7.0, -3.0, -2.0, 4.0, -5.0, 8.0, -3.0, 2.0, -8.0, -9.0, 0.0, 8.0, 5.0, -5.0));
	block.var[1][0][0] = (mat4(5.0, 2.0, -1.0, -1.0, 5.0, -5.0, 0.0, 3.0, -6.0, -5.0, -1.0, 3.0, -6.0, -5.0, -7.0, -8.0));
	block.var[1][0][1] = (mat4(-1.0, 9.0, 8.0, 0.0, -5.0, 0.0, -3.0, -7.0, 8.0, -9.0, -9.0, 0.0, 9.0, -8.0, -8.0, -5.0));
	block.var[1][1][0] = (mat4(5.0, -2.0, 0.0, 3.0, 4.0, -3.0, 8.0, -1.0, -3.0, 2.0, 7.0, -7.0, 1.0, -2.0, 8.0, -1.0));
	block.var[1][1][1] = (mat4(-2.0, -6.0, -4.0, 5.0, 6.0, -2.0, 8.0, 8.0, 5.0, -6.0, -4.0, -6.0, -1.0, -3.0, -6.0, 0.0));
	block.var[1][2][0] = (mat4(-3.0, -5.0, -4.0, -7.0, -9.0, -6.0, -8.0, 6.0, -1.0, 8.0, 0.0, -8.0, -4.0, 4.0, 8.0, -5.0));
	block.var[1][2][1] = (mat4(-4.0, -9.0, 6.0, 9.0, -4.0, -2.0, -8.0, -8.0, 4.0, 7.0, 3.0, 6.0, -4.0, -3.0, -4.0, 6.0));
	block.var[1][3][0] = (mat4(-1.0, -9.0, -7.0, 0.0, -9.0, -9.0, 7.0, -8.0, -5.0, -2.0, -2.0, -8.0, 5.0, 1.0, 7.0, -6.0));
	block.var[1][3][1] = (mat4(-8.0, -1.0, 9.0, 1.0, -8.0, -1.0, -6.0, 2.0, -8.0, -8.0, -9.0, -1.0, -8.0, 1.0, -1.0, 0.0));
	block.var[2][0][0] = (mat4(5.0, 6.0, -1.0, 7.0, -2.0, 2.0, -7.0, 1.0, 8.0, 0.0, 7.0, 1.0, 2.0, 7.0, 5.0, 0.0));
	block.var[2][0][1] = (mat4(7.0, -1.0, 8.0, 4.0, -9.0, -9.0, -4.0, 6.0, 9.0, -3.0, 3.0, -9.0, 5.0, -1.0, -2.0, -9.0));
	block.var[2][1][0] = (mat4(-9.0, -3.0, -7.0, 7.0, 2.0, -7.0, -7.0, 0.0, -5.0, -9.0, 6.0, -3.0, -5.0, -4.0, -4.0, -5.0));
	block.var[2][1][1] = (mat4(6.0, 9.0, 3.0, -8.0, -3.0, 0.0, -9.0, 2.0, 6.0, 0.0, -4.0, 1.0, 0.0, 2.0, 2.0, 5.0));
	block.var[2][2][0] = (mat4(7.0, 4.0, 4.0, 3.0, -8.0, -4.0, -4.0, 7.0, -3.0, -4.0, 4.0, -6.0, 2.0, 8.0, 4.0, -7.0));
	block.var[2][2][1] = (mat4(1.0, 1.0, 6.0, 3.0, 8.0, 2.0, -7.0, 7.0, 9.0, -8.0, 9.0, 0.0, 8.0, 4.0, 8.0, 2.0));
	block.var[2][3][0] = (mat4(4.0, 8.0, 5.0, 7.0, -8.0, -2.0, 3.0, -9.0, 5.0, -1.0, -6.0, -3.0, -9.0, 9.0, -8.0, 9.0));
	block.var[2][3][1] = (mat4(2.0, 0.0, 2.0, 2.0, 9.0, -4.0, -4.0, 8.0, -8.0, -2.0, -7.0, 4.0, -1.0, 2.0, -6.0, 1.0));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
{
	f16vec3 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(block.var[0][0][0]), vec3(4.0, 1.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[0][0][1]), vec3(-8.0, 7.0, -5.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[0][1][0]), vec3(1.0, -2.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[0][1][1]), vec3(-7.0, -7.0, -7.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[0][2][0]), vec3(-1.0, -7.0, -9.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[0][2][1]), vec3(2.0, 6.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[0][3][0]), vec3(8.0, 2.0, 0.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[0][3][1]), vec3(-1.0, 2.0, 2.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1][0][0]), vec3(4.0, 2.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1][0][1]), vec3(4.0, 4.0, 5.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1][1][0]), vec3(-8.0, -2.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1][1][1]), vec3(6.0, 6.0, -1.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1][2][0]), vec3(-5.0, 1.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1][2][1]), vec3(5.0, 4.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1][3][0]), vec3(-4.0, -8.0, 7.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1][3][1]), vec3(5.0, 7.0, 5.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2][0][0]), vec3(2.0, 1.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2][0][1]), vec3(8.0, 2.0, -3.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2][1][0]), vec3(-4.0, -4.0, 6.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2][1][1]), vec3(-8.0, 6.0, 4.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2][2][0]), vec3(6.0, -7.0, -8.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2][2][1]), vec3(6.0, -8.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2][3][0]), vec3(6.0, -9.0, -6.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2][3][1]), vec3(0.0, -3.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = f16vec3(vec3(3.0, 3.0, 7.0));
	block.var[0][0][1] = f16vec3(vec3(-3.0, -5.0, -9.0));
	block.var[0][1][0] = f16vec3(vec3(-5.0, -4.0, 6.0));
	block.var[0][1][1] = f16vec3(vec3(-3.0, -7.0, -4.0));
	block.var[0][2][0] = f16vec3(vec3(6.0, 6.0, -6.0));
	block.var[0][2][1] = f16vec3(vec3(-3.0, 1.0, -5.0));
	block.var[0][3][0] = f16vec3(vec3(2.0, -5.0, -9.0));
	block.var[0][3][1] = f16vec3(vec3(-8.0, 4.0, 1.0));
	block.var[1][0][0] = f16vec3(vec3(-1.0, 0.0, 6.0));
	block.var[1][0][1] = f16vec3(vec3(5.0, -7.0, 2.0));
	block.var[1][1][0] = f16vec3(vec3(-4.0, 5.0, 0.0));
	block.var[1][1][1] = f16vec3(vec3(-6.0, 4.0, -1.0));
	block.var[1][2][0] = f16vec3(vec3(6.0, 9.0, 7.0));
	block.var[1][2][1] = f16vec3(vec3(2.0, 5.0, 3.0));
	block.var[1][3][0] = f16vec3(vec3(-9.0, -5.0, 5.0));
	block.var[1][3][1] = f16vec3(vec3(-3.0, -6.0, 0.0));
	block.var[2][0][0] = f16vec3(vec3(9.0, 1.0, -5.0));
	block.var[2][0][1] = f16vec3(vec3(-5.0, 5.0, 2.0));
	block.var[2][1][0] = f16vec3(vec3(-2.0, 3.0, -8.0));
	block.var[2][1][1] = f16vec3(vec3(-4.0, -2.0, 4.0));
	block.var[2][2][0] = f16vec3(vec3(9.0, -8.0, 2.0));
	block.var[2][2][1] = f16vec3(vec3(-7.0, -8.0, -3.0));
	block.var[2][3][0] = f16vec3(vec3(-3.0, 9.0, -1.0));
	block.var[2][3][1] = f16vec3(vec3(-9.0, 0.0, -5.0));
}
#version 450
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
	allOk = compare_mat3(block.var[0][0][0], mat3(-8.0, -9.0, -7.0, -7.0, 8.0, 7.0, 4.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(5.0, -4.0, 7.0, -4.0, -3.0, 8.0, 7.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(-8.0, 7.0, 2.0, -7.0, 4.0, -2.0, -5.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(-1.0, 2.0, 0.0, -9.0, -9.0, 6.0, -6.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[0][2][0], mat3(-7.0, 8.0, -6.0, -9.0, -8.0, 8.0, 0.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[0][2][1], mat3(-6.0, 0.0, -3.0, 9.0, 7.0, -8.0, -9.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[0][3][0], mat3(3.0, 4.0, -4.0, -1.0, -7.0, -1.0, 4.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[0][3][1], mat3(1.0, 1.0, 3.0, -6.0, -4.0, -2.0, -6.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(1.0, 6.0, 8.0, -9.0, -1.0, 8.0, 8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(-6.0, 4.0, -3.0, -2.0, 3.0, 7.0, 0.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(-4.0, -3.0, -3.0, 4.0, -6.0, -6.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(4.0, 6.0, -3.0, 5.0, -4.0, -6.0, -5.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[1][2][0], mat3(-8.0, 9.0, 0.0, -7.0, 1.0, -2.0, 3.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[1][2][1], mat3(6.0, 6.0, -4.0, 4.0, -2.0, 6.0, 2.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[1][3][0], mat3(2.0, 3.0, 1.0, 8.0, 9.0, -4.0, -2.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[1][3][1], mat3(4.0, -9.0, 6.0, -1.0, 0.0, -2.0, 4.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(-1.0, 1.0, -9.0, 4.0, 6.0, 8.0, 8.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(3.0, 0.0, -4.0, 8.0, 3.0, 9.0, 3.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(8.0, -1.0, -4.0, -2.0, 4.0, -8.0, 0.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(9.0, 6.0, 8.0, -7.0, 4.0, -8.0, 4.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[2][2][0], mat3(2.0, 9.0, 6.0, -8.0, -6.0, -3.0, -4.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[2][2][1], mat3(-5.0, -8.0, 6.0, 2.0, 5.0, -6.0, 7.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[2][3][0], mat3(-8.0, 3.0, -2.0, 1.0, 3.0, -1.0, -8.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[2][3][1], mat3(-2.0, -4.0, -1.0, 1.0, -1.0, -8.0, -9.0, -9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3(5.0, 2.0, 8.0, 8.0, 3.0, -2.0, 2.0, -8.0, -5.0));
	block.var[0][0][1] = (mat3(-6.0, -1.0, 7.0, -5.0, -5.0, 8.0, -2.0, -5.0, 5.0));
	block.var[0][1][0] = (mat3(5.0, 8.0, -1.0, 8.0, 9.0, 6.0, -1.0, 5.0, -2.0));
	block.var[0][1][1] = (mat3(1.0, 4.0, -8.0, 8.0, 1.0, 2.0, 4.0, -7.0, 3.0));
	block.var[0][2][0] = (mat3(-9.0, 2.0, -8.0, 1.0, -5.0, 5.0, 8.0, -6.0, 7.0));
	block.var[0][2][1] = (mat3(-1.0, 7.0, -7.0, 7.0, 5.0, -9.0, 5.0, 3.0, -1.0));
	block.var[0][3][0] = (mat3(-7.0, 7.0, -5.0, 5.0, 0.0, 7.0, -8.0, -5.0, 8.0));
	block.var[0][3][1] = (mat3(4.0, -8.0, -8.0, 3.0, -2.0, 4.0, 8.0, -1.0, -5.0));
	block.var[1][0][0] = (mat3(3.0, 9.0, -7.0, -2.0, 3.0, 5.0, 5.0, 1.0, -6.0));
	block.var[1][0][1] = (mat3(-5.0, 4.0, 9.0, -2.0, -6.0, 2.0, -1.0, 0.0, 2.0));
	block.var[1][1][0] = (mat3(-1.0, -5.0, 2.0, 2.0, -1.0, -7.0, 7.0, -8.0, -6.0));
	block.var[1][1][1] = (mat3(5.0, -9.0, 2.0, 2.0, -9.0, -9.0, -2.0, 1.0, 8.0));
	block.var[1][2][0] = (mat3(6.0, -3.0, 9.0, 7.0, 0.0, 2.0, 8.0, -5.0, -9.0));
	block.var[1][2][1] = (mat3(-3.0, 0.0, 7.0, -7.0, 1.0, -6.0, -4.0, 1.0, -9.0));
	block.var[1][3][0] = (mat3(-5.0, -1.0, -1.0, 4.0, 9.0, 2.0, -2.0, -7.0, 2.0));
	block.var[1][3][1] = (mat3(-5.0, -3.0, -3.0, 1.0, -3.0, -9.0, 5.0, 7.0, 7.0));
	block.var[2][0][0] = (mat3(9.0, -5.0, 7.0, 6.0, 8.0, 4.0, 5.0, -2.0, -5.0));
	block.var[2][0][1] = (mat3(7.0, -1.0, 1.0, -3.0, -8.0, 1.0, -4.0, 7.0, 1.0));
	block.var[2][1][0] = (mat3(-4.0, 8.0, -5.0, 5.0, -2.0, 2.0, 3.0, 3.0, -8.0));
	block.var[2][1][1] = (mat3(0.0, 2.0, 6.0, 2.0, -5.0, -9.0, 4.0, 6.0, -3.0));
	block.var[2][2][0] = (mat3(6.0, 9.0, 8.0, 5.0, 8.0, 1.0, 6.0, 4.0, -4.0));
	block.var[2][2][1] = (mat3(9.0, -4.0, 1.0, -5.0, 8.0, -3.0, 4.0, -9.0, -8.0));
	block.var[2][3][0] = (mat3(6.0, 3.0, -3.0, 2.0, 0.0, 2.0, -1.0, 4.0, 2.0));
	block.var[2][3][1] = (mat3(2.0, 3.0, 2.0, -9.0, 3.0, 4.0, -6.0, -3.0, -9.0));
}
#version 450
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
	highp mat2x4 var[][4][2];
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
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(3.0, -4.0, 9.0, -7.0, -8.0, 2.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(-7.0, 8.0, -9.0, 4.0, 4.0, -9.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(-2.0, 5.0, -7.0, -1.0, 7.0, 6.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(-9.0, -7.0, 2.0, 8.0, -5.0, -1.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2][0], mat2x4(-8.0, 0.0, 0.0, 1.0, 3.0, -4.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2][1], mat2x4(0.0, -3.0, 4.0, -6.0, 4.0, 7.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][3][0], mat2x4(5.0, -4.0, -9.0, 2.0, -4.0, 7.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][3][1], mat2x4(4.0, -6.0, 7.0, 5.0, 5.0, -1.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(9.0, -5.0, -4.0, -8.0, -6.0, -2.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(-5.0, -8.0, -7.0, 8.0, 5.0, 9.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(-5.0, -4.0, -4.0, 5.0, -5.0, 5.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(-9.0, 2.0, 9.0, -6.0, -9.0, -5.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2][0], mat2x4(1.0, -8.0, 0.0, 1.0, -3.0, 4.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2][1], mat2x4(8.0, -3.0, 0.0, -2.0, -4.0, 5.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][3][0], mat2x4(0.0, -2.0, -6.0, 8.0, -4.0, -8.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][3][1], mat2x4(8.0, 6.0, 0.0, -2.0, -7.0, -9.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(1.0, 4.0, -4.0, -1.0, 0.0, 1.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(4.0, 4.0, -2.0, 5.0, 0.0, -2.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(-5.0, 2.0, -4.0, 4.0, 3.0, -4.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(6.0, 1.0, 5.0, -1.0, -5.0, 0.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2][0], mat2x4(0.0, -9.0, 7.0, 0.0, -5.0, 7.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2][1], mat2x4(-7.0, -9.0, -7.0, 4.0, -9.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][3][0], mat2x4(-7.0, -4.0, 9.0, 0.0, 7.0, 9.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][3][1], mat2x4(-3.0, -7.0, -1.0, -5.0, 1.0, 5.0, 9.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2x4(5.0, -1.0, 5.0, 1.0, 1.0, -4.0, 0.0, -8.0));
	block.var[0][0][1] = (mat2x4(-3.0, 9.0, -8.0, -9.0, 1.0, 9.0, 1.0, -2.0));
	block.var[0][1][0] = (mat2x4(-6.0, 9.0, -3.0, 5.0, -4.0, 8.0, 0.0, 1.0));
	block.var[0][1][1] = (mat2x4(8.0, -6.0, 9.0, 7.0, -4.0, -8.0, 6.0, 2.0));
	block.var[0][2][0] = (mat2x4(4.0, 9.0, -8.0, 5.0, 6.0, -1.0, 4.0, -3.0));
	block.var[0][2][1] = (mat2x4(3.0, -1.0, -8.0, 3.0, 0.0, 1.0, -4.0, -1.0));
	block.var[0][3][0] = (mat2x4(-5.0, 6.0, 0.0, 7.0, -5.0, 2.0, 0.0, -5.0));
	block.var[0][3][1] = (mat2x4(-7.0, 4.0, 4.0, 2.0, -9.0, 5.0, -7.0, -7.0));
	block.var[1][0][0] = (mat2x4(-6.0, 3.0, -3.0, -7.0, -6.0, 0.0, 9.0, -7.0));
	block.var[1][0][1] = (mat2x4(-3.0, -9.0, -8.0, 2.0, 1.0, -9.0, 2.0, -1.0));
	block.var[1][1][0] = (mat2x4(-1.0, 2.0, 9.0, -2.0, 4.0, -9.0, -7.0, 4.0));
	block.var[1][1][1] = (mat2x4(2.0, 0.0, -8.0, -1.0, -5.0, 5.0, 6.0, 0.0));
	block.var[1][2][0] = (mat2x4(-3.0, 4.0, 1.0, 2.0, 2.0, 0.0, 7.0, 2.0));
	block.var[1][2][1] = (mat2x4(6.0, 1.0, -2.0, 4.0, 9.0, -2.0, -7.0, 5.0));
	block.var[1][3][0] = (mat2x4(0.0, -2.0, -7.0, -5.0, 1.0, 4.0, 6.0, -3.0));
	block.var[1][3][1] = (mat2x4(4.0, 7.0, -8.0, -8.0, -4.0, -9.0, 3.0, -5.0));
	block.var[2][0][0] = (mat2x4(-3.0, -3.0, -6.0, -9.0, 2.0, -8.0, -1.0, 3.0));
	block.var[2][0][1] = (mat2x4(4.0, 9.0, -6.0, -4.0, 7.0, 7.0, -4.0, -4.0));
	block.var[2][1][0] = (mat2x4(5.0, -8.0, 8.0, 1.0, -4.0, -3.0, 5.0, 6.0));
	block.var[2][1][1] = (mat2x4(4.0, 9.0, -7.0, -4.0, -4.0, -7.0, 9.0, 4.0));
	block.var[2][2][0] = (mat2x4(-8.0, 2.0, -4.0, 4.0, -8.0, 1.0, -7.0, -7.0));
	block.var[2][2][1] = (mat2x4(1.0, 7.0, 2.0, 3.0, -2.0, 1.0, 0.0, 7.0));
	block.var[2][3][0] = (mat2x4(-7.0, -3.0, -1.0, -4.0, 2.0, -8.0, -5.0, -3.0));
	block.var[2][3][1] = (mat2x4(-7.0, 7.0, -5.0, 8.0, -1.0, 1.0, 7.0, 5.0));
}
#version 450
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
	uint16_t var[][4][2];
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
	allOk = compare_uint16_t(uint(block.var[0][1][0]), 2u) && allOk;
	allOk = compare_uint16_t(uint(block.var[0][1][1]), 0u) && allOk;
	allOk = compare_uint16_t(uint(block.var[0][2][0]), 7u) && allOk;
	allOk = compare_uint16_t(uint(block.var[0][2][1]), 8u) && allOk;
	allOk = compare_uint16_t(uint(block.var[0][3][0]), 8u) && allOk;
	allOk = compare_uint16_t(uint(block.var[0][3][1]), 6u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][0][0]), 4u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][0][1]), 1u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][1][0]), 6u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][1][1]), 9u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][2][0]), 2u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][2][1]), 7u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][3][0]), 6u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][3][1]), 4u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][0][0]), 0u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][0][1]), 9u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][1][0]), 8u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][1][1]), 1u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][2][0]), 1u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][2][1]), 0u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][3][0]), 6u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][3][1]), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = uint16_t(9u);
	block.var[0][0][1] = uint16_t(1u);
	block.var[0][1][0] = uint16_t(8u);
	block.var[0][1][1] = uint16_t(1u);
	block.var[0][2][0] = uint16_t(3u);
	block.var[0][2][1] = uint16_t(1u);
	block.var[0][3][0] = uint16_t(2u);
	block.var[0][3][1] = uint16_t(9u);
	block.var[1][0][0] = uint16_t(1u);
	block.var[1][0][1] = uint16_t(0u);
	block.var[1][1][0] = uint16_t(9u);
	block.var[1][1][1] = uint16_t(7u);
	block.var[1][2][0] = uint16_t(0u);
	block.var[1][2][1] = uint16_t(2u);
	block.var[1][3][0] = uint16_t(3u);
	block.var[1][3][1] = uint16_t(0u);
	block.var[2][0][0] = uint16_t(7u);
	block.var[2][0][1] = uint16_t(5u);
	block.var[2][1][0] = uint16_t(2u);
	block.var[2][1][1] = uint16_t(6u);
	block.var[2][2][0] = uint16_t(1u);
	block.var[2][2][1] = uint16_t(1u);
	block.var[2][3][0] = uint16_t(8u);
	block.var[2][3][1] = uint16_t(4u);
}
#version 450
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
	f16vec3 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(block.var[0][0][0]), vec3(4.0, 1.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[0][0][1]), vec3(-8.0, 7.0, -5.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[0][1][0]), vec3(1.0, -2.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[0][1][1]), vec3(-7.0, -7.0, -7.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[0][2][0]), vec3(-1.0, -7.0, -9.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[0][2][1]), vec3(2.0, 6.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[0][3][0]), vec3(8.0, 2.0, 0.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[0][3][1]), vec3(-1.0, 2.0, 2.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1][0][0]), vec3(4.0, 2.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1][0][1]), vec3(4.0, 4.0, 5.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1][1][0]), vec3(-8.0, -2.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1][1][1]), vec3(6.0, 6.0, -1.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1][2][0]), vec3(-5.0, 1.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1][2][1]), vec3(5.0, 4.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1][3][0]), vec3(-4.0, -8.0, 7.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1][3][1]), vec3(5.0, 7.0, 5.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2][0][0]), vec3(2.0, 1.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2][0][1]), vec3(8.0, 2.0, -3.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2][1][0]), vec3(-4.0, -4.0, 6.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2][1][1]), vec3(-8.0, 6.0, 4.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2][2][0]), vec3(6.0, -7.0, -8.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2][2][1]), vec3(6.0, -8.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2][3][0]), vec3(6.0, -9.0, -6.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2][3][1]), vec3(0.0, -3.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = f16vec3(vec3(3.0, 3.0, 7.0));
	block.var[0][0][1] = f16vec3(vec3(-3.0, -5.0, -9.0));
	block.var[0][1][0] = f16vec3(vec3(-5.0, -4.0, 6.0));
	block.var[0][1][1] = f16vec3(vec3(-3.0, -7.0, -4.0));
	block.var[0][2][0] = f16vec3(vec3(6.0, 6.0, -6.0));
	block.var[0][2][1] = f16vec3(vec3(-3.0, 1.0, -5.0));
	block.var[0][3][0] = f16vec3(vec3(2.0, -5.0, -9.0));
	block.var[0][3][1] = f16vec3(vec3(-8.0, 4.0, 1.0));
	block.var[1][0][0] = f16vec3(vec3(-1.0, 0.0, 6.0));
	block.var[1][0][1] = f16vec3(vec3(5.0, -7.0, 2.0));
	block.var[1][1][0] = f16vec3(vec3(-4.0, 5.0, 0.0));
	block.var[1][1][1] = f16vec3(vec3(-6.0, 4.0, -1.0));
	block.var[1][2][0] = f16vec3(vec3(6.0, 9.0, 7.0));
	block.var[1][2][1] = f16vec3(vec3(2.0, 5.0, 3.0));
	block.var[1][3][0] = f16vec3(vec3(-9.0, -5.0, 5.0));
	block.var[1][3][1] = f16vec3(vec3(-3.0, -6.0, 0.0));
	block.var[2][0][0] = f16vec3(vec3(9.0, 1.0, -5.0));
	block.var[2][0][1] = f16vec3(vec3(-5.0, 5.0, 2.0));
	block.var[2][1][0] = f16vec3(vec3(-2.0, 3.0, -8.0));
	block.var[2][1][1] = f16vec3(vec3(-4.0, -2.0, 4.0));
	block.var[2][2][0] = f16vec3(vec3(9.0, -8.0, 2.0));
	block.var[2][2][1] = f16vec3(vec3(-7.0, -8.0, -3.0));
	block.var[2][3][0] = f16vec3(vec3(-3.0, 9.0, -1.0));
	block.var[2][3][1] = f16vec3(vec3(-9.0, 0.0, -5.0));
}
#version 450
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
	allOk = compare_ivec3((block.s.a), ivec3(8, 2, -1)) && allOk;
	allOk = compare_mat3(block.s.b[0], mat3(-2.0, 7.0, 2.0, 9.0, 0.0, 5.0, 4.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat3(block.s.b[1], mat3(-3.0, -2.0, -3.0, -7.0, 7.0, -5.0, -4.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(block.s.b[2], mat3(1.0, -5.0, -8.0, -8.0, -8.0, -2.0, 8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3(block.s.b[3], mat3(8.0, -2.0, -6.0, -6.0, -8.0, 6.0, 9.0, 9.0, 9.0)) && allOk;
	allOk = compare_vec4((block.s.c), vec4(-7.0, -1.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat3(block.t.a, mat3(-1.0, -5.0, -4.0, 9.0, 5.0, 0.0, 4.0, -5.0, -7.0)) && allOk;
	allOk = compare_ivec3((block.t.b.a), ivec3(-7, -6, -8)) && allOk;
	allOk = compare_mat3(block.t.b.b[0], mat3(-7.0, 2.0, 7.0, -1.0, -5.0, 4.0, 0.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat3(block.t.b.b[1], mat3(-5.0, 6.0, 0.0, 4.0, 5.0, 9.0, 8.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3(block.t.b.b[2], mat3(8.0, -7.0, -2.0, 4.0, -2.0, 9.0, -8.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat3(block.t.b.b[3], mat3(5.0, 4.0, 9.0, -3.0, 5.0, 3.0, -6.0, 0.0, -6.0)) && allOk;
	allOk = compare_vec4((block.t.b.c), vec4(6.0, -2.0, -8.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.t.a[0] = (vec3(-2.0, -2.0, 9.0));
	block.t.a[1] = (vec3(3.0, -8.0, -5.0));
	block.t.a[2] = (vec3(2.0, 9.0, 4.0));
	block.t.b.a = (ivec3(-2, -1, -6));
	block.t.b.b[0][0] = (vec3(-1.0, 1.0, -4.0));
	block.t.b.b[0][1] = (vec3(6.0, 5.0, -4.0));
	block.t.b.b[0][2] = (vec3(4.0, -1.0, 1.0));
	block.t.b.b[1][0] = (vec3(-5.0, -4.0, -9.0));
	block.t.b.b[1][1] = (vec3(1.0, -3.0, -1.0));
	block.t.b.b[1][2] = (vec3(1.0, 2.0, -7.0));
	block.t.b.b[2][0] = (vec3(-3.0, -9.0, -3.0));
	block.t.b.b[2][1] = (vec3(0.0, 4.0, 5.0));
	block.t.b.b[2][2] = (vec3(-8.0, 6.0, 5.0));
	block.t.b.b[3][0] = (vec3(-3.0, 2.0, 0.0));
	block.t.b.b[3][1] = (vec3(1.0, 6.0, -2.0));
	block.t.b.b[3][2] = (vec3(-7.0, 3.0, -6.0));
	block.t.b.c = (vec4(-2.0, 2.0, 5.0, -9.0));
	block.u = (0u);
}
#version 450
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
layout(std430, buffer_reference) buffer Block
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
	allOk = compare_mat3(block.t[0].a, mat3(1.0, 2.0, 0.0, -7.0, 7.0, -5.0, 1.0, -5.0, 1.0)) && allOk;
	allOk = compare_ivec3((block.t[0].b[0].a), ivec3(-9, -3, -8)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[0]), ivec2(1, 1)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[1]), ivec2(0, 6)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[2]), ivec2(-9, -3)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[3]), ivec2(2, 5)) && allOk;
	allOk = compare_vec4((block.t[0].b[0].c), vec4(9.0, -7.0, -5.0, -9.0)) && allOk;
	allOk = compare_ivec3((block.t[0].b[1].a), ivec3(0, -3, -9)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[0]), ivec2(6, 6)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[1]), ivec2(3, -6)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[2]), ivec2(0, 0)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[3]), ivec2(4, -4)) && allOk;
	allOk = compare_vec4((block.t[0].b[1].c), vec4(9.0, -1.0, -6.0, 5.0)) && allOk;
	allOk = compare_ivec3((block.t[0].b[2].a), ivec3(4, -4, -2)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[0]), ivec2(-2, -9)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[1]), ivec2(9, 9)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[2]), ivec2(-2, 3)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[3]), ivec2(6, -3)) && allOk;
	allOk = compare_vec4((block.t[0].b[2].c), vec4(-4.0, 6.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat3(block.t[1].a, mat3(6.0, 2.0, -1.0, 4.0, 1.0, -3.0, 5.0, -5.0, -7.0)) && allOk;
	allOk = compare_ivec3((block.t[1].b[0].a), ivec3(-4, -3, 6)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[0]), ivec2(-4, -1)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[1]), ivec2(9, 4)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[2]), ivec2(-3, -3)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[3]), ivec2(2, 4)) && allOk;
	allOk = compare_vec4((block.t[1].b[0].c), vec4(-6.0, 8.0, -6.0, 7.0)) && allOk;
	allOk = compare_ivec3((block.t[1].b[1].a), ivec3(-8, -8, 5)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[0]), ivec2(9, -7)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[1]), ivec2(0, -2)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[2]), ivec2(4, 5)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[3]), ivec2(5, -3)) && allOk;
	allOk = compare_vec4((block.t[1].b[1].c), vec4(6.0, 1.0, -4.0, 6.0)) && allOk;
	allOk = compare_ivec3((block.t[1].b[2].a), ivec3(2, -2, -8)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[0]), ivec2(-9, -6)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[1]), ivec2(-7, 4)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[2]), ivec2(-1, 4)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[3]), ivec2(8, -8)) && allOk;
	allOk = compare_vec4((block.t[1].b[2].c), vec4(-8.0, 3.0, -3.0, 8.0)) && allOk;
	allOk = compare_uint((block.u), 5u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s.a = (ivec3(-8, 8, -7));
	block.s.b[0] = (ivec2(-9, 5));
	block.s.b[1] = (ivec2(2, 9));
	block.s.b[2] = (ivec2(-9, -9));
	block.s.b[3] = (ivec2(0, -3));
	block.s.c = (vec4(7.0, -9.0, 8.0, -2.0));
	block.u = (1u);
}
#version 450
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
    Block block;
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
	allOk = compare_uvec2((block.s[0].a), uvec2(6u, 9u)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[0], mat2x4(-2.0, -7.0, -1.0, 4.0, 9.0, -9.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[1], mat2x4(7.0, 8.0, -1.0, -2.0, -1.0, -6.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[2], mat2x4(-3.0, 2.0, 8.0, 9.0, -8.0, -7.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[3], mat2x4(0.0, 9.0, 9.0, -8.0, 1.0, 3.0, -5.0, 3.0)) && allOk;
	allOk = compare_vec3((block.s[0].c), vec3(-2.0, 0.0, -1.0)) && allOk;
	allOk = compare_uvec2((block.s[1].a), uvec2(4u, 6u)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[0], mat2x4(2.0, -9.0, 7.0, -4.0, -9.0, 1.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[1], mat2x4(2.0, 2.0, -7.0, -7.0, -6.0, -7.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[2], mat2x4(6.0, -3.0, 5.0, 2.0, -4.0, 7.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[3], mat2x4(-4.0, 5.0, -3.0, 5.0, 5.0, 5.0, -3.0, 0.0)) && allOk;
	allOk = compare_vec3((block.s[1].c), vec3(-2.0, -6.0, -6.0)) && allOk;
	allOk = compare_uvec2((block.s[2].a), uvec2(2u, 9u)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[0], mat2x4(1.0, -9.0, -3.0, -8.0, -7.0, -3.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[1], mat2x4(8.0, 3.0, -7.0, 6.0, 0.0, -7.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[2], mat2x4(-6.0, 8.0, 1.0, -8.0, -3.0, -2.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[3], mat2x4(-4.0, -5.0, -6.0, 2.0, -2.0, 3.0, -9.0, 8.0)) && allOk;
	allOk = compare_vec3((block.s[2].c), vec3(7.0, 4.0, 5.0)) && allOk;
	allOk = compare_uvec2((block.s[3].a), uvec2(5u, 5u)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[0], mat2x4(-1.0, 5.0, 4.0, -8.0, -4.0, 1.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[1], mat2x4(-4.0, -5.0, 4.0, 2.0, 8.0, -8.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[2], mat2x4(6.0, -7.0, -8.0, 8.0, 0.0, -6.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[3], mat2x4(-1.0, -6.0, 4.0, -1.0, 0.0, 7.0, -9.0, 5.0)) && allOk;
	allOk = compare_vec3((block.s[3].c), vec3(6.0, 4.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.v = (9u);
	block.s[0].a = (uvec2(1u, 5u));
	block.s[0].b[0][0] = (vec4(-7.0, 9.0, -3.0, 9.0));
	block.s[0].b[0][1] = (vec4(8.0, 4.0, 0.0, -6.0));
	block.s[0].b[1][0] = (vec4(-4.0, -6.0, 7.0, -5.0));
	block.s[0].b[1][1] = (vec4(4.0, -2.0, 4.0, -1.0));
	block.s[0].b[2][0] = (vec4(-1.0, 6.0, 6.0, -5.0));
	block.s[0].b[2][1] = (vec4(-5.0, 3.0, -6.0, 5.0));
	block.s[0].b[3][0] = (vec4(2.0, 2.0, -9.0, -5.0));
	block.s[0].b[3][1] = (vec4(-5.0, 1.0, -2.0, 9.0));
	block.s[0].c = (vec3(-9.0, -5.0, -2.0));
	block.s[1].a = (uvec2(2u, 6u));
	block.s[1].b[0][0] = (vec4(-9.0, 4.0, 1.0, 6.0));
	block.s[1].b[0][1] = (vec4(5.0, 4.0, 1.0, -8.0));
	block.s[1].b[1][0] = (vec4(-1.0, -3.0, -7.0, -7.0));
	block.s[1].b[1][1] = (vec4(-4.0, -4.0, 6.0, -7.0));
	block.s[1].b[2][0] = (vec4(-1.0, -7.0, -2.0, 0.0));
	block.s[1].b[2][1] = (vec4(-2.0, 5.0, 2.0, 7.0));
	block.s[1].b[3][0] = (vec4(-6.0, 0.0, 2.0, 9.0));
	block.s[1].b[3][1] = (vec4(6.0, -7.0, 4.0, -3.0));
	block.s[1].c = (vec3(-7.0, 8.0, -7.0));
	block.s[2].a = (uvec2(8u, 8u));
	block.s[2].b[0][0] = (vec4(5.0, -3.0, 0.0, 9.0));
	block.s[2].b[0][1] = (vec4(0.0, 8.0, 7.0, -6.0));
	block.s[2].b[1][0] = (vec4(0.0, 5.0, -8.0, 1.0));
	block.s[2].b[1][1] = (vec4(4.0, 1.0, 3.0, -2.0));
	block.s[2].b[2][0] = (vec4(-7.0, -3.0, -3.0, -3.0));
	block.s[2].b[2][1] = (vec4(6.0, 4.0, 4.0, 1.0));
	block.s[2].b[3][0] = (vec4(-6.0, -1.0, -3.0, -2.0));
	block.s[2].b[3][1] = (vec4(-6.0, 8.0, -8.0, 0.0));
	block.s[2].c = (vec3(-6.0, 7.0, -6.0));
	block.s[3].a = (uvec2(7u, 9u));
	block.s[3].b[0][0] = (vec4(4.0, 1.0, -6.0, 7.0));
	block.s[3].b[0][1] = (vec4(-8.0, -1.0, 1.0, 2.0));
	block.s[3].b[1][0] = (vec4(-2.0, -9.0, 4.0, -7.0));
	block.s[3].b[1][1] = (vec4(-3.0, -6.0, 4.0, 3.0));
	block.s[3].b[2][0] = (vec4(-1.0, 3.0, 8.0, 7.0));
	block.s[3].b[2][1] = (vec4(-3.0, -4.0, 7.0, -5.0));
	block.s[3].b[3][0] = (vec4(-1.0, 6.0, 5.0, 1.0));
	block.s[3].b[3][1] = (vec4(8.0, 8.0, -2.0, -8.0));
	block.s[3].c = (vec3(9.0, 5.0, -7.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((block.s[0][0].a), ivec3(2, -6, 5)) && allOk;
	allOk = compare_vec4((block.s[0][0].c), vec4(3.0, -7.0, 4.0, 0.0)) && allOk;
	allOk = compare_ivec3((block.s[0][1].a), ivec3(4, -2, -2)) && allOk;
	allOk = compare_vec4((block.s[0][1].c), vec4(8.0, -7.0, 9.0, 8.0)) && allOk;
	allOk = compare_ivec3((block.s[1][0].a), ivec3(-9, -6, -3)) && allOk;
	allOk = compare_vec4((block.s[1][0].c), vec4(-7.0, 8.0, -4.0, 6.0)) && allOk;
	allOk = compare_ivec3((block.s[1][1].a), ivec3(-1, 7, 2)) && allOk;
	allOk = compare_vec4((block.s[1][1].c), vec4(-7.0, -3.0, -8.0, 8.0)) && allOk;
	allOk = compare_ivec3((block.s[2][0].a), ivec3(-9, 9, 4)) && allOk;
	allOk = compare_vec4((block.s[2][0].c), vec4(-2.0, -9.0, -2.0, 8.0)) && allOk;
	allOk = compare_ivec3((block.s[2][1].a), ivec3(6, 0, 9)) && allOk;
	allOk = compare_vec4((block.s[2][1].c), vec4(4.0, 0.0, 0.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.v = (vec4(-3.0, 7.0, 0.0, -9.0));
	block.s[0][0].a = (ivec3(6, 1, -9));
	block.s[0][0].c = (vec4(3.0, 7.0, -4.0, -3.0));
	block.s[0][1].a = (ivec3(-5, -2, 3));
	block.s[0][1].c = (vec4(-7.0, -7.0, 1.0, 5.0));
	block.s[1][0].a = (ivec3(-8, -6, 5));
	block.s[1][0].c = (vec4(-3.0, -4.0, 2.0, -2.0));
	block.s[1][1].a = (ivec3(-7, 5, 8));
	block.s[1][1].c = (vec4(2.0, 0.0, -9.0, -6.0));
	block.s[2][0].a = (ivec3(4, -2, -8));
	block.s[2][0].c = (vec4(-8.0, -5.0, 6.0, -2.0));
	block.s[2][1].a = (ivec3(0, 4, -4));
	block.s[2][1].c = (vec4(-7.0, -7.0, 9.0, -1.0));
}
#version 450
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

layout(scalar, buffer_reference) buffer Block
{
	highp int var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

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

layout(scalar, row_major, buffer_reference) buffer Block
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
	allOk = compare_float((block[0].padding), -2.0) && allOk;
	allOk = compare_mat4x2(block[0].var, mat4x2(5.0, 7.0, 1.0, -5.0, 5.0, 9.0, 6.0, 4.0)) && allOk;
	allOk = compare_float((block[1].padding), -7.0) && allOk;
	allOk = compare_mat4x2(block[1].var, mat4x2(7.0, 7.0, 5.0, -1.0, -5.0, -1.0, -4.0, -9.0)) && allOk;
	allOk = compare_float((block[2].padding), -1.0) && allOk;
	allOk = compare_mat4x2(block[2].var, mat4x2(0.0, 4.0, 7.0, -4.0, -7.0, -5.0, 8.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (6.0);
	block[0].var[0] = (vec2(-4.0, -4.0));
	block[0].var[1] = (vec2(2.0, 0.0));
	block[0].var[2] = (vec2(-7.0, 3.0));
	block[0].var[3] = (vec2(9.0, 9.0));
	block[1].padding = (8.0);
	block[1].var[0] = (vec2(-9.0, -6.0));
	block[1].var[1] = (vec2(-4.0, -6.0));
	block[1].var[2] = (vec2(-6.0, -8.0));
	block[1].var[3] = (vec2(-9.0, 6.0));
	block[2].padding = (-8.0);
	block[2].var[0] = (vec2(2.0, 8.0));
	block[2].var[1] = (vec2(5.0, -8.0));
	block[2].var[2] = (vec2(-8.0, -3.0));
	block[2].var[3] = (vec2(3.0, 7.0));
}
#version 450
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
	u8vec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(block[0].padding), 3u) && allOk;
	allOk = compare_u8vec4(uvec4(block[0].var), uvec4(4u, 6u, 8u, 1u)) && allOk;
	allOk = compare_uint8_t(uint(block[1].padding), 5u) && allOk;
	allOk = compare_u8vec4(uvec4(block[1].var), uvec4(7u, 0u, 1u, 4u)) && allOk;
	allOk = compare_uint8_t(uint(block[2].padding), 6u) && allOk;
	allOk = compare_u8vec4(uvec4(block[2].var), uvec4(1u, 7u, 7u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = uint8_t(9u);
	block[0].var = u8vec4(uvec4(5u, 9u, 4u, 6u));
	block[1].padding = uint8_t(8u);
	block[1].var = u8vec4(uvec4(7u, 3u, 6u, 7u));
	block[2].padding = uint8_t(1u);
	block[2].var = u8vec4(uvec4(9u, 8u, 9u, 3u));
}
#version 450
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
	float16_t padding;
	f16vec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(block[0].padding), 4.0) && allOk;
	allOk = compare_f16vec3(vec3(block[0].var), vec3(1.0, 9.0, -8.0)) && allOk;
	allOk = compare_float16_t(float(block[1].padding), 7.0) && allOk;
	allOk = compare_f16vec3(vec3(block[1].var), vec3(-5.0, 4.0, 2.0)) && allOk;
	allOk = compare_float16_t(float(block[2].padding), -4.0) && allOk;
	allOk = compare_f16vec3(vec3(block[2].var), vec3(4.0, 4.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = float16_t(3.0);
	block[0].var = f16vec3(vec3(3.0, 7.0, -3.0));
	block[1].padding = float16_t(-5.0);
	block[1].var = f16vec3(vec3(-9.0, -1.0, 0.0));
	block[2].padding = float16_t(6.0);
	block[2].var = f16vec3(vec3(5.0, -7.0, 2.0));
}
#version 450
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
	allOk = compare_float((blockA[0].a), -8.0) && allOk;
	allOk = compare_mat2(blockA[0].c, mat2(-6.0, 4.0, 1.0, -8.0)) && allOk;
	allOk = compare_float((blockA[1].a), -7.0) && allOk;
	allOk = compare_mat2(blockA[1].c, mat2(1.0, 8.0, 3.0, 7.0)) && allOk;
	allOk = compare_float((blockA[2].a), -3.0) && allOk;
	allOk = compare_mat2(blockA[2].c, mat2(3.0, -9.0, -1.0, 3.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b), ivec2(-7, 0)) && allOk;
	allOk = compare_bool((blockB[0].d), true) && allOk;
	allOk = compare_ivec2((blockB[1].b), ivec2(-5, 9)) && allOk;
	allOk = compare_bool((blockB[1].d), true) && allOk;
	allOk = compare_ivec2((blockB[2].b), ivec2(2, -8)) && allOk;
	allOk = compare_bool((blockB[2].d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (-4.0);
	blockA[1].a = (4.0);
	blockA[2].a = (3.0);
	blockB[0].a = (mat3(1.0, 2.0, 1.0, -8.0, -8.0, -4.0, 4.0, 0.0, -5.0));
	blockB[0].d = (true);
	blockB[1].a = (mat3(3.0, 5.0, 4.0, 3.0, -6.0, 8.0, 4.0, -6.0, 1.0));
	blockB[1].d = (false);
	blockB[2].a = (mat3(2.0, -2.0, 4.0, -6.0, 6.0, -4.0, -1.0, 3.0, 0.0));
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

layout(std140, row_major, buffer_reference) buffer BlockB
{
	bvec4 a;
	lowp mat4 b;
	lowp uvec2 c[];
};
layout(std430, buffer_reference) buffer BlockC
{
	highp uint d;
	lowp mat3 e;
	mediump float f;
	mediump uvec3 g[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	highp float h;
	bvec2 i[];
};
layout(std430, buffer_reference) buffer BlockE
{
	highp mat2 j[];
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
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, true, true, true)) && allOk;
	allOk = compare_uvec3((blockC.g[0]), uvec3(6u, 9u, 1u)) && allOk;
	allOk = compare_float((blockD.h), 7.0) && allOk;
	allOk = compare_bvec2((blockD.i[0]), bvec2(true, false)) && allOk;
	allOk = compare_mat2(blockE.j[0], mat2(8.0, 5.0, 9.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec4(true, false, true, false));
	blockB.b = (mat4(-2.0, 0.0, 4.0, 0.0, -4.0, 9.0, -6.0, 4.0, -9.0, 8.0, -8.0, 7.0, -2.0, -5.0, -5.0, 3.0));
	blockC.d = (5u);
	blockC.f = (-5.0);
	blockC.g[0] = (uvec3(4u, 8u, 8u));
	blockD.i[0] = (bvec2(false, false));
	blockE.j[0] = (mat2(4.0, -3.0, 8.0, -6.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, column_major, buffer_reference) readonly buffer BlockB
{
	highp float a[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	lowp mat4x3 b;
	bool c;
	lowp uvec3 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a[0]), 4.0) && allOk;
	allOk = compare_bool((blockC.c), false) && allOk;
	allOk = compare_uvec3((blockC.d[0]), uvec3(8u, 1u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.c = (true);
	blockC.d[0] = (uvec3(3u, 9u, 8u));
}
#version 450
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
	highp mat3x2 mB;
};
layout(std430, column_major, buffer_reference) buffer BlockB
{
	lowp mat4x2 a;
	bool b;
	mediump int c;
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	sA d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.b), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (true);
	blockB.c = (4);
	blockC.d[0].mA = (bvec2(true, true));
	blockC.d[0].mB = (mat3x2(-3.0, -1.0, 0.0, -5.0, 7.0, -8.0));
	blockC.d[1].mA = (bvec2(true, true));
	blockC.d[1].mB = (mat3x2(9.0, -8.0, 7.0, -4.0, -9.0, 0.0));
	blockC.d[2].mA = (bvec2(false, true));
	blockC.d[2].mB = (mat3x2(-3.0, -2.0, 9.0, 2.0, 9.0, -6.0));
	blockC.d[3].mA = (bvec2(false, false));
	blockC.d[3].mB = (mat3x2(0.0, -4.0, -6.0, -9.0, -6.0, 4.0));
	blockC.d[4].mA = (bvec2(false, false));
	blockC.d[4].mB = (mat3x2(-5.0, -3.0, 8.0, -1.0, 8.0, 2.0));
	blockC.d[5].mA = (bvec2(false, false));
	blockC.d[5].mB = (mat3x2(-2.0, 7.0, 2.0, -1.0, -1.0, 3.0));
	blockC.d[6].mA = (bvec2(true, false));
	blockC.d[6].mB = (mat3x2(2.0, -3.0, -8.0, 8.0, 9.0, -7.0));
}
#version 450
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
	mediump mat2x3 a;
	mediump vec2 b;
	mediump vec3 c;
	lowp uvec4 d;
	mediump mat3x2 e[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	lowp uvec3 f;
	mediump mat2 g;
	mediump uvec2 h;
	lowp mat3x4 i[];
};
layout(std140, buffer_reference) buffer BlockD
{
	lowp mat2 j;
	mediump uvec4 k;
	mediump mat3x2 l[];
};
layout(std140, column_major, buffer_reference) buffer BlockE
{
	highp mat4 m;
	highp mat2x3 n;
	highp float o;
	highp uvec4 p;
	mediump ivec2 q[];
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
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.b), vec2(-5.0, -2.0)) && allOk;
	allOk = compare_vec3((blockB.c), vec3(3.0, 4.0, 1.0)) && allOk;
	allOk = compare_uvec4((blockB.d), uvec4(4u, 9u, 9u, 8u)) && allOk;
	allOk = compare_mat2(blockC.g, mat2(6.0, 4.0, -5.0, 8.0)) && allOk;
	allOk = compare_uvec2((blockC.h), uvec2(7u, 8u)) && allOk;
	allOk = compare_mat3x4(blockC.i[0], mat3x4(-7.0, -3.0, -7.0, 7.0, -3.0, -2.0, -9.0, 9.0, -3.0, 9.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3x4(blockC.i[1], mat3x4(-4.0, 5.0, -9.0, 2.0, 4.0, 2.0, 8.0, -7.0, -4.0, 3.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3x4(blockC.i[2], mat3x4(8.0, 3.0, 2.0, 8.0, 4.0, 7.0, -7.0, 8.0, 7.0, 1.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat2(blockD.j, mat2(-2.0, -2.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat3x2(blockD.l[0], mat3x2(-6.0, -3.0, 5.0, 7.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(blockD.l[1], mat3x2(-4.0, 1.0, -1.0, 4.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockD.l[2], mat3x2(0.0, -4.0, 4.0, -2.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3x2(blockD.l[3], mat3x2(8.0, -9.0, 3.0, 9.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockD.l[4], mat3x2(5.0, -4.0, -7.0, -3.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockD.l[5], mat3x2(-8.0, -6.0, 8.0, -1.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockD.l[6], mat3x2(1.0, -9.0, 1.0, -9.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x2(blockD.l[7], mat3x2(0.0, -5.0, 6.0, -3.0, 9.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (vec3(9.0, 3.0, -7.0));
	blockB.e[0] = (mat3x2(-3.0, -2.0, -2.0, 3.0, 4.0, -7.0));
	blockB.e[1] = (mat3x2(8.0, -8.0, -6.0, -3.0, 1.0, 0.0));
	blockB.e[2] = (mat3x2(7.0, 9.0, 0.0, 6.0, -3.0, -4.0));
	blockB.e[3] = (mat3x2(-8.0, 6.0, 5.0, -6.0, -9.0, -2.0));
	blockB.e[4] = (mat3x2(6.0, 6.0, -5.0, -3.0, 6.0, 7.0));
	blockC.f = (uvec3(8u, 7u, 9u));
	blockC.g = (mat2(-2.0, -9.0, 7.0, -9.0));
	blockC.h = (uvec2(6u, 2u));
	blockC.i[0] = (mat3x4(9.0, 2.0, -5.0, -7.0, -1.0, 8.0, 1.0, 7.0, -6.0, 2.0, 8.0, 0.0));
	blockC.i[1] = (mat3x4(-7.0, -3.0, -1.0, -2.0, -4.0, -1.0, 6.0, 1.0, -1.0, -2.0, -7.0, 6.0));
	blockC.i[2] = (mat3x4(5.0, -4.0, 9.0, 4.0, -7.0, -9.0, -3.0, 0.0, 0.0, 5.0, 1.0, -3.0));
	blockD.l[0] = (mat3x2(-5.0, 6.0, -4.0, 0.0, -9.0, -1.0));
	blockD.l[1] = (mat3x2(-2.0, 2.0, 5.0, -5.0, 2.0, -4.0));
	blockD.l[2] = (mat3x2(9.0, 6.0, -6.0, 3.0, -4.0, 7.0));
	blockD.l[3] = (mat3x2(2.0, 8.0, 8.0, -4.0, 6.0, -5.0));
	blockD.l[4] = (mat3x2(-6.0, -2.0, -7.0, 0.0, -1.0, -1.0));
	blockD.l[5] = (mat3x2(-2.0, -5.0, -8.0, -6.0, -6.0, 2.0));
	blockD.l[6] = (mat3x2(4.0, 1.0, 8.0, 6.0, 2.0, 1.0));
	blockD.l[7] = (mat3x2(6.0, 8.0, -1.0, -7.0, 5.0, 8.0));
	blockE.m = (mat4(-2.0, -7.0, 2.0, -5.0, 1.0, -3.0, 4.0, -3.0, 5.0, -1.0, 5.0, -8.0, 3.0, 7.0, -3.0, 0.0));
	blockE.o = (0.0);
	blockE.p = (uvec4(9u, 7u, 8u, 8u));
	blockE.q[0] = (ivec2(9, -6));
}
#version 450
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
	highp ivec3 a;
	highp mat4x2 b;
	highp mat3x4 c;
};
layout(std140, buffer_reference) buffer BlockC
{
	mediump mat3 d[];
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	highp ivec2 e[2];
	mediump uvec2 f;
	mediump int g;
	highp vec4 h;
	mediump ivec4 i[];
};
layout(std430, buffer_reference) buffer BlockE
{
	highp int j;
	lowp mat3x4 k;
	mediump int l;
	mediump vec4 m;
	lowp mat4x3 n[];
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
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a), ivec3(7, 2, -9)) && allOk;
	allOk = compare_mat4x2(blockB.b, mat4x2(4.0, -4.0, -3.0, 9.0, -1.0, 0.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat3x4(blockB.c, mat3x4(5.0, -9.0, -1.0, 2.0, -5.0, 7.0, -7.0, -4.0, 8.0, 0.0, -4.0, 2.0)) && allOk;
	allOk = compare_ivec2((blockD.e[0]), ivec2(3, 0)) && allOk;
	allOk = compare_ivec2((blockD.e[1]), ivec2(3, 1)) && allOk;
	allOk = compare_ivec4((blockD.i[0]), ivec4(-8, 7, -4, -9)) && allOk;
	allOk = compare_mat3x4(blockE.k, mat3x4(0.0, -4.0, 5.0, -4.0, 6.0, 5.0, -5.0, -4.0, 5.0, -6.0, -7.0, -1.0)) && allOk;
	allOk = compare_vec4((blockE.m), vec4(8.0, -3.0, -5.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat4x2(8.0, 9.0, 9.0, -9.0, -4.0, 3.0, -2.0, -8.0));
	blockB.c = (mat3x4(-9.0, 2.0, 8.0, 4.0, -4.0, 4.0, 2.0, -5.0, -3.0, 5.0, -6.0, -5.0));
	blockC.d[0] = (mat3(-9.0, -7.0, 7.0, -8.0, 8.0, -9.0, 1.0, 1.0, 7.0));
	blockD.f = (uvec2(0u, 4u));
	blockD.h = (vec4(7.0, -8.0, -8.0, 1.0));
	blockD.i[0] = (ivec4(1, 2, -5, -9));
	blockE.j = (6);
	blockE.k = (mat3x4(-9.0, 0.0, 1.0, -7.0, -8.0, 4.0, 2.0, -4.0, -3.0, -5.0, -5.0, -2.0));
	blockE.l = (-6);
	blockE.m = (vec4(5.0, -5.0, -9.0, -8.0));
	blockE.n[0] = (mat4x3(2.0, -9.0, 9.0, -4.0, -1.0, -8.0, -4.0, -5.0, 0.0, 3.0, 4.0, -4.0));
	blockE.n[1] = (mat4x3(7.0, -6.0, 6.0, -2.0, 0.0, 4.0, 5.0, 7.0, -5.0, -1.0, -2.0, 6.0));
}
#version 450
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
	layout(offset = 0) highp vec3 a;
	layout(offset = 16) mediump ivec3 b;
	layout(offset = 32) mediump ivec3 c[1];
	layout(offset = 48) mediump float d;
	layout(offset = 64) bvec4 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.d), 6.0) && allOk;
	allOk = compare_bvec4((blockB.e), bvec4(false, true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec3(1.0, 1.0, -4.0));
	blockB.b = (ivec3(1, 8, -4));
	blockB.c[0] = (ivec3(1, -9, 3));
	blockB.d = (0.0);
	blockB.e = (bvec4(true, false, true, true));
}
#version 450
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
	mediump float a;
	lowp mat2 b;
	lowp mat2 c;
	lowp uint d[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	bool e;
	lowp vec2 f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB.c, mat2(-5.0, 9.0, -4.0, -6.0)) && allOk;
	allOk = compare_uint((blockB.d[0]), 6u) && allOk;
	allOk = compare_uint((blockB.d[1]), 7u) && allOk;
	allOk = compare_uint((blockB.d[2]), 4u) && allOk;
	allOk = compare_uint((blockB.d[3]), 1u) && allOk;
	allOk = compare_bool((blockC.e), true) && allOk;
	allOk = compare_vec2((blockC.f[0]), vec2(7.0, -2.0)) && allOk;
	allOk = compare_vec2((blockC.f[1]), vec2(-4.0, -9.0)) && allOk;
	allOk = compare_vec2((blockC.f[2]), vec2(8.0, 3.0)) && allOk;
	allOk = compare_vec2((blockC.f[3]), vec2(0.0, 2.0)) && allOk;
	allOk = compare_vec2((blockC.f[4]), vec2(1.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (mat2(6.0, -6.0, 3.0, -7.0));
	blockB.d[0] = (5u);
	blockB.d[1] = (9u);
	blockB.d[2] = (9u);
	blockB.d[3] = (4u);
	blockC.e = (true);
	blockC.f[0] = (vec2(3.0, -1.0));
	blockC.f[1] = (vec2(4.0, -4.0));
	blockC.f[2] = (vec2(-6.0, -7.0));
	blockC.f[3] = (vec2(-7.0, -4.0));
	blockC.f[4] = (vec2(8.0, 2.0));
}
#version 450
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
	lowp mat4x2 a[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	lowp mat4x3 b;
	highp uint c[][3];
};
layout(scalar, buffer_reference) buffer BlockD
{
	bool d;
	mediump mat2x3 e[];
};
layout(scalar, column_major, buffer_reference) buffer BlockE
{
	highp vec2 f[4];
	highp uint g;
	lowp mat4x3 h;
	highp uvec3 i;
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockC.c[0][0]), 7u) && allOk;
	allOk = compare_uint((blockC.c[0][1]), 0u) && allOk;
	allOk = compare_uint((blockC.c[0][2]), 0u) && allOk;
	allOk = compare_uint((blockC.c[1][0]), 2u) && allOk;
	allOk = compare_uint((blockC.c[1][1]), 7u) && allOk;
	allOk = compare_uint((blockC.c[1][2]), 6u) && allOk;
	allOk = compare_uint((blockC.c[2][0]), 6u) && allOk;
	allOk = compare_uint((blockC.c[2][1]), 2u) && allOk;
	allOk = compare_uint((blockC.c[2][2]), 6u) && allOk;
	allOk = compare_uint((blockC.c[3][0]), 7u) && allOk;
	allOk = compare_uint((blockC.c[3][1]), 5u) && allOk;
	allOk = compare_uint((blockC.c[3][2]), 6u) && allOk;
	allOk = compare_bool((blockD.d), false) && allOk;
	allOk = compare_mat2x3(blockD.e[0], mat2x3(4.0, -9.0, -6.0, 1.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat2x3(blockD.e[1], mat2x3(-6.0, -5.0, 7.0, -4.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2x3(blockD.e[2], mat2x3(3.0, 9.0, 8.0, 7.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat2x3(blockD.e[3], mat2x3(8.0, 8.0, -8.0, -2.0, 4.0, -5.0)) && allOk;
	allOk = compare_vec2((blockE.f[0]), vec2(5.0, 7.0)) && allOk;
	allOk = compare_vec2((blockE.f[1]), vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec2((blockE.f[2]), vec2(3.0, 6.0)) && allOk;
	allOk = compare_vec2((blockE.f[3]), vec2(2.0, 6.0)) && allOk;
	allOk = compare_mat4x3(blockE.h, mat4x3(1.0, -5.0, -8.0, 1.0, -8.0, 8.0, 6.0, -5.0, 3.0, 7.0, 0.0, -5.0)) && allOk;
	allOk = compare_uvec3((blockE.i), uvec3(5u, 6u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat4x2(9.0, 2.0, 5.0, 0.0, -3.0, 0.0, -2.0, 1.0));
	blockB.a[1] = (mat4x2(1.0, 3.0, 9.0, -9.0, 1.0, -8.0, 0.0, -6.0));
	blockB.a[2] = (mat4x2(-6.0, 6.0, -5.0, -8.0, -3.0, -1.0, 4.0, 8.0));
	blockB.a[3] = (mat4x2(5.0, -7.0, -5.0, 4.0, 4.0, -2.0, 4.0, -5.0));
	blockC.b = (mat4x3(-4.0, -3.0, -3.0, -5.0, 8.0, 4.0, -2.0, 0.0, -1.0, 1.0, 1.0, 5.0));
	blockD.d = (true);
	blockE.h = (mat4x3(5.0, -3.0, -2.0, 7.0, 9.0, 4.0, 6.0, 6.0, -9.0, -3.0, 3.0, -7.0));
	blockE.i = (uvec3(4u, 3u, 9u));
}
#version 450
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
	lowp uint a;
	lowp mat3x4 b;
	lowp int c;
	lowp mat4x2 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB[nonuniformEXT(0)].a), 9u) && allOk;
	allOk = compare_uint((blockB[nonuniformEXT(1)].a), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (9u);
	blockB[nonuniformEXT(0)].b = (mat3x4(-2.0, 6.0, 5.0, 6.0, -1.0, 0.0, 4.0, 7.0, -6.0, 9.0, 8.0, -5.0));
	blockB[nonuniformEXT(0)].d = (mat4x2(-2.0, 0.0, 7.0, 9.0, 4.0, -4.0, 7.0, -5.0));
	blockB[nonuniformEXT(1)].a = (4u);
	blockB[nonuniformEXT(1)].b = (mat3x4(9.0, -2.0, -6.0, -3.0, -7.0, -4.0, -4.0, -6.0, -6.0, 8.0, 6.0, 8.0));
	blockB[nonuniformEXT(1)].d = (mat4x2(-7.0, 2.0, -1.0, -1.0, 4.0, 4.0, -7.0, -6.0));
}
#version 450
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
	highp int a;
	uint16_t b;
	mediump float c;
	highp int d;
	uint16_t e;
};
layout(std430, buffer_reference) buffer BlockC
{
	mediump float f;
	uint16_t g;
};
layout(std140, buffer_reference) buffer BlockD
{
	mediump float h[1];
};
layout(std430, buffer_reference) buffer BlockE
{
	float16_t i;
	int16_t j;
	highp int k;
	bool l;
	lowp uint m;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.a), 0) && allOk;
	allOk = compare_int((blockB.d), -5) && allOk;
	allOk = compare_float((blockC.f), 3.0) && allOk;
	allOk = compare_uint16_t(uint(blockC.g), 5u) && allOk;
	allOk = compare_float((blockD.h[0]), -1.0) && allOk;
	allOk = compare_float16_t(float(blockE.i), -8.0) && allOk;
	allOk = compare_int((blockE.k), 8) && allOk;
	allOk = compare_bool((blockE.l), true) && allOk;
	allOk = compare_uint((blockE.m), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = uint16_t(5u);
	blockB.c = (-9.0);
	blockB.e = uint16_t(4u);
	blockC.f = (2.0);
	blockC.g = uint16_t(1u);
	blockD.h[0] = (6.0);
	blockE.i = float16_t(-6.0);
	blockE.j = int16_t(3);
	blockE.l = (false);
	blockE.m = (1u);
}
#version 450
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
	float16_t a;
	f16vec4 b[1];
	bvec4 c;
	u16vec3 d;
	bvec2 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(blockB.b[0]), vec4(3.0, -2.0, 9.0, -9.0)) && allOk;
	allOk = compare_bvec4((blockB.c), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec2((blockB.e), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = f16vec4(vec4(-2.0, 3.0, -5.0, -4.0));
	blockB.e = (bvec2(true, false));
}
#version 450
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
	u16vec3 a;
	i16vec3 b;
	highp uvec3 c[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(blockB.b), ivec3(-2, -1, -2)) && allOk;
	allOk = compare_uvec3((blockB.c[0]), uvec3(7u, 6u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec3(uvec3(6u, 4u, 7u));
	blockB.b = i16vec3(ivec3(1, -7, -3));
	blockB.c[0] = (uvec3(9u, 3u, 3u));
}
#version 450
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
	mediump mat4x3 a;
	u16vec4 b;
	mediump mat4x3 c;
	lowp vec2 d;
	bvec2 e;
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	lowp vec4 f;
	mediump ivec4 g;
	int16_t h;
	bool i;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.d), vec2(-8.0, 0.0)) && allOk;
	allOk = compare_vec4((blockC.f), vec4(1.0, -8.0, 2.0, 0.0)) && allOk;
	allOk = compare_int16_t(int(blockC.h), -6) && allOk;
	allOk = compare_bool((blockC.i), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = u16vec4(uvec4(1u, 1u, 6u, 4u));
	blockB.c = (mat4x3(9.0, 4.0, 0.0, 4.0, 5.0, -2.0, 4.0, -6.0, 5.0, -4.0, 9.0, 1.0));
	blockB.d = (vec2(4.0, -5.0));
	blockB.e = (bvec2(false, true));
	blockC.g = (ivec4(-8, -4, -9, 9));
	blockC.h = int16_t(-2);
}
#version 450
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
	f16vec3 a[];
};
layout(std430, buffer_reference) buffer BlockC
{
	lowp uvec3 b;
	i16vec4 c;
	mediump uvec4 d;
	int16_t e[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	lowp mat4 f;
	int16_t g[7][4];
	i16vec2 h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockC.b), uvec3(4u, 6u, 4u)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.c), ivec4(2, -9, -7, -5)) && allOk;
	allOk = compare_uvec4((blockC.d), uvec4(4u, 1u, 1u, 7u)) && allOk;
	allOk = compare_mat4(blockD.f, mat4(-8.0, 5.0, 2.0, -3.0, 0.0, -7.0, 0.0, 7.0, 3.0, 1.0, 1.0, -6.0, -5.0, -8.0, 8.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = f16vec3(vec3(9.0, -7.0, -5.0));
	blockB.a[1] = f16vec3(vec3(-9.0, -8.0, 0.0));
	blockB.a[2] = f16vec3(vec3(8.0, 0.0, 8.0));
	blockB.a[3] = f16vec3(vec3(7.0, 1.0, 2.0));
	blockC.b = (uvec3(1u, 1u, 6u));
	blockC.c = i16vec4(ivec4(-3, 9, 4, 0));
	blockC.d = (uvec4(1u, 8u, 2u, 8u));
	blockC.e[0] = int16_t(-6);
	blockC.e[1] = int16_t(5);
	blockC.e[2] = int16_t(-4);
	blockC.e[3] = int16_t(9);
	blockC.e[4] = int16_t(1);
	blockD.f = (mat4(4.0, 4.0, 9.0, 9.0, -5.0, -9.0, -8.0, -2.0, 8.0, -1.0, -4.0, 3.0, -5.0, -6.0, -9.0, 1.0));
	blockD.g[0][0] = int16_t(-6);
	blockD.g[0][1] = int16_t(-2);
	blockD.g[0][2] = int16_t(5);
	blockD.g[0][3] = int16_t(-3);
	blockD.g[1][0] = int16_t(4);
	blockD.g[1][1] = int16_t(7);
	blockD.g[1][2] = int16_t(-1);
	blockD.g[1][3] = int16_t(-2);
	blockD.g[2][0] = int16_t(2);
	blockD.g[2][1] = int16_t(-2);
	blockD.g[2][2] = int16_t(1);
	blockD.g[2][3] = int16_t(0);
	blockD.g[3][0] = int16_t(2);
	blockD.g[3][1] = int16_t(-9);
	blockD.g[3][2] = int16_t(0);
	blockD.g[3][3] = int16_t(7);
	blockD.g[4][0] = int16_t(-3);
	blockD.g[4][1] = int16_t(-5);
	blockD.g[4][2] = int16_t(8);
	blockD.g[4][3] = int16_t(2);
	blockD.g[5][0] = int16_t(2);
	blockD.g[5][1] = int16_t(-2);
	blockD.g[5][2] = int16_t(-1);
	blockD.g[5][3] = int16_t(4);
	blockD.g[6][0] = int16_t(-3);
	blockD.g[6][1] = int16_t(-1);
	blockD.g[6][2] = int16_t(-2);
	blockD.g[6][3] = int16_t(2);
	blockD.h = i16vec2(ivec2(-3, -1));
}
#version 450
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
	highp vec3 a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.a), vec3(1.0, -6.0, -5.0)) && allOk;
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

layout(std430, buffer_reference) buffer BlockB
{
	lowp int a;
	lowp uvec2 b;
	highp ivec3 c;
	highp int d;
	mediump vec2 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.a), 2) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (8);
	blockB.b = (uvec2(4u, 9u));
	blockB.c = (ivec3(5, -4, 2));
	blockB.e[0] = (vec2(9.0, -3.0));
}
#version 450
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
	mediump uvec4 mA;
};
struct sB
{
	lowp mat3x2 mA;
};
layout(std140, buffer_reference) buffer BlockB
{
	mediump ivec2 a[1];
	sA b;
	lowp vec3 c;
	lowp mat4 d[];
};
layout(std430, buffer_reference) buffer BlockC
{
	highp mat4x2 e;
	highp uvec4 f;
	i16vec2 g;
	lowp ivec2 h[];
};
layout(std140, buffer_reference) buffer BlockD
{
	f16vec3 i;
	sB j;
	mediump mat3 k;
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
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.d[0], mat4(-4.0, -3.0, 4.0, 4.0, 9.0, -9.0, -8.0, -9.0, 8.0, 0.0, 4.0, -4.0, 7.0, 2.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat4(blockB.d[1], mat4(-5.0, -4.0, 3.0, -5.0, -3.0, -1.0, 1.0, 0.0, -3.0, 1.0, 3.0, -9.0, -4.0, 3.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat4(blockB.d[2], mat4(3.0, -9.0, -5.0, 9.0, -7.0, -8.0, 1.0, 6.0, 0.0, -3.0, 4.0, -7.0, -1.0, 5.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat4(blockB.d[3], mat4(-8.0, 1.0, -9.0, -9.0, -9.0, -7.0, 7.0, -2.0, 2.0, -4.0, 4.0, -8.0, 4.0, 8.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat4x2(blockC.e, mat4x2(-8.0, -5.0, 0.0, 1.0, -4.0, -9.0, 2.0, -4.0)) && allOk;
	allOk = compare_ivec2((blockC.h[0]), ivec2(8, 0)) && allOk;
	allOk = compare_ivec2((blockC.h[1]), ivec2(-7, -8)) && allOk;
	allOk = compare_ivec2((blockC.h[2]), ivec2(-7, -3)) && allOk;
	allOk = compare_ivec2((blockC.h[3]), ivec2(3, 2)) && allOk;
	allOk = compare_ivec2((blockC.h[4]), ivec2(-8, -1)) && allOk;
	allOk = compare_ivec2((blockC.h[5]), ivec2(-7, 0)) && allOk;
	allOk = compare_ivec2((blockC.h[6]), ivec2(6, -5)) && allOk;
	allOk = compare_ivec2((blockC.h[7]), ivec2(4, -3)) && allOk;
	allOk = compare_f16vec3(vec3(blockD.i), vec3(7.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3x2(blockD.j.mA, mat3x2(8.0, 0.0, -3.0, -8.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3(blockD.k, mat3(5.0, 8.0, 8.0, -5.0, 4.0, 9.0, -1.0, -4.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (ivec2(6, -1));
	blockB.b.mA = (uvec4(5u, 6u, 7u, 2u));
	blockC.e = (mat4x2(-7.0, -3.0, -6.0, 4.0, -9.0, 5.0, 1.0, -9.0));
	blockC.f = (uvec4(9u, 4u, 0u, 1u));
	blockC.h[0] = (ivec2(-3, 4));
	blockC.h[1] = (ivec2(9, -8));
	blockC.h[2] = (ivec2(-8, 5));
	blockC.h[3] = (ivec2(-9, -3));
	blockC.h[4] = (ivec2(-3, -3));
	blockC.h[5] = (ivec2(-1, -6));
	blockC.h[6] = (ivec2(6, 4));
	blockC.h[7] = (ivec2(-3, 8));
	blockD.j.mA = (mat3x2(0.0, -5.0, -7.0, 4.0, -8.0, -7.0));
}
#version 450
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
	f16vec3 mA;
	int16_t mB;
	mediump mat2 mC;
};
struct sB
{
	i16vec3 mA;
	int16_t mB;
	highp int mC;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	sA a;
	lowp mat2 b;
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	u16vec3 c;
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	lowp mat4 d;
	f16vec4 e[1];
	sB f;
	bvec2 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB[0].b, mat2(8.0, -4.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2(blockB[1].b, mat2(-3.0, -1.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat2(blockB[2].b, mat2(7.0, -6.0, 2.0, 8.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.c), uvec3(2u, 5u, 8u)) && allOk;
	allOk = compare_mat4(blockD.d, mat4(-1.0, 1.0, -8.0, -9.0, 5.0, 0.0, -3.0, 9.0, 1.0, -6.0, 1.0, 0.0, -5.0, -7.0, -9.0, 6.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockD.e[0]), vec4(-4.0, -1.0, 5.0, 3.0)) && allOk;
	allOk = compare_bvec2((blockD.g[0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockD.g[1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockD.g[2]), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (mat2(-6.0, -2.0, -5.0, 4.0));
	blockB[1].b = (mat2(7.0, 9.0, 8.0, -7.0));
	blockB[2].b = (mat2(3.0, -4.0, -7.0, -6.0));
	blockC.c = u16vec3(uvec3(6u, 7u, 0u));
	blockD.d = (mat4(-6.0, -3.0, -7.0, -1.0, -5.0, 6.0, -5.0, -6.0, 8.0, 9.0, 6.0, -9.0, 4.0, 7.0, -3.0, 0.0));
	blockD.g[0] = (bvec2(true, true));
	blockD.g[1] = (bvec2(false, false));
	blockD.g[2] = (bvec2(false, true));
}
#version 450
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
	mediump vec4 a;
	bvec4 b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.b[0]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((blockB.b[1]), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bvec4((blockB.b[2]), bvec4(true, true, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (bvec4(true, false, true, false));
	blockB.b[1] = (bvec4(false, true, false, true));
	blockB.b[2] = (bvec4(false, true, true, false));
}
#version 450
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
	layout(offset = 16) bvec3 b;
	layout(offset = 32) bvec2 c;
	layout(offset = 40) i16vec4 d;
	layout(offset = 48) highp uint e;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) bool f[1];
	layout(offset = 4) highp uvec2 g;
	layout(offset = 16) i16vec4 h;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) int16_t i;
	layout(offset = 2) f16vec2 j;
	layout(offset = 16) highp ivec3 k;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a), ivec3(3, 4, -3)) && allOk;
	allOk = compare_bvec3((blockB.b), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec2((blockB.c), bvec2(true, true)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB.d), ivec4(9, 9, -8, 9)) && allOk;
	allOk = compare_uvec2((blockC.g), uvec2(1u, 6u)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.h), ivec4(-9, -2, 2, -8)) && allOk;
	allOk = compare_int16_t(int(blockD.i), 4) && allOk;
	allOk = compare_f16vec2(vec2(blockD.j), vec2(-1.0, 3.0)) && allOk;
	allOk = compare_ivec3((blockD.k), ivec3(5, -4, 0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec3(3, -9, 1));
	blockB.b = (bvec3(true, false, true));
	blockB.c = (bvec2(false, true));
	blockB.d = i16vec4(ivec4(1, -2, 3, 1));
	blockB.e = (2u);
	blockC.f[0] = (true);
	blockC.g = (uvec2(8u, 5u));
	blockC.h = i16vec4(ivec4(3, 2, -3, -8));
	blockD.j = f16vec2(vec2(9.0, 2.0));
	blockD.k = (ivec3(-5, 1, 6));
}
#version 450
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
	layout(offset = 0) u16vec2 a;
	layout(offset = 4) highp vec2 b;
	layout(offset = 12) float16_t c[1];
	layout(offset = 16) i16vec4 d;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) bvec3 e;
	layout(offset = 16) bvec4 f;
	layout(offset = 32) lowp uint g;
	layout(offset = 48) bvec4 h;
	layout(offset = 64) i16vec4 i;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockB[0].c[0]), -8.0) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[0].d), ivec4(3, -3, 6, -7)) && allOk;
	allOk = compare_float16_t(float(blockB[1].c[0]), 5.0) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[1].d), ivec4(1, 4, 6, -1)) && allOk;
	allOk = compare_float16_t(float(blockB[2].c[0]), -8.0) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[2].d), ivec4(1, 2, 9, 1)) && allOk;
	allOk = compare_bvec3((blockC.e), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec4((blockC.f), bvec4(false, false, true, false)) && allOk;
	allOk = compare_uint((blockC.g), 2u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = u16vec2(uvec2(1u, 3u));
	blockB[0].b = (vec2(8.0, -4.0));
	blockB[0].c[0] = float16_t(-7.0);
	blockB[0].d = i16vec4(ivec4(-4, 8, 3, -1));
	blockB[1].a = u16vec2(uvec2(1u, 7u));
	blockB[1].b = (vec2(-4.0, 7.0));
	blockB[1].c[0] = float16_t(8.0);
	blockB[1].d = i16vec4(ivec4(-6, -9, 0, 7));
	blockB[2].a = u16vec2(uvec2(1u, 2u));
	blockB[2].b = (vec2(-7.0, 4.0));
	blockB[2].c[0] = float16_t(-9.0);
	blockB[2].d = i16vec4(ivec4(6, 7, -2, 9));
	blockC.f = (bvec4(true, false, false, true));
	blockC.g = (1u);
	blockC.h = (bvec4(false, true, true, true));
	blockC.i = i16vec4(ivec4(8, -8, -8, -1));
}
#version 450
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
	highp vec4 mA;
	bvec4 mB;
};
struct sB
{
	i16vec4 mA;
	i16vec2 mB[5];
	highp mat2x3 mC;
	f16vec4 mD;
};
struct sC
{
	sA mA;
	lowp mat4x2 mB;
	highp mat3x2 mC;
	sB mD;
};
layout(scalar, column_major, buffer_reference) buffer BlockB
{
	highp mat3 a;
	bvec4 b;
	sC c;
	lowp mat4x3 d;
	highp mat4 e[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	highp vec4 f;
	lowp vec2 g[1];
	highp float h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB.a, mat3(2.0, 5.0, 9.0, -9.0, -9.0, -4.0, 4.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat4x3(blockB.d, mat4x3(-8.0, 8.0, 0.0, -3.0, 1.0, -6.0, 9.0, 0.0, 9.0, -5.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat4(blockB.e[0], mat4(-6.0, 1.0, -3.0, -7.0, 1.0, -6.0, -2.0, -6.0, -8.0, 0.0, -8.0, 1.0, -8.0, -1.0, -6.0, -9.0)) && allOk;
	allOk = compare_vec4((blockC.f), vec4(-8.0, -2.0, 8.0, 7.0)) && allOk;
	allOk = compare_vec2((blockC.g[0]), vec2(-2.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3(-1.0, -4.0, 2.0, -1.0, 2.0, 2.0, -5.0, 7.0, -5.0));
	blockB.b = (bvec4(false, true, false, false));
	blockB.d = (mat4x3(-5.0, 8.0, -3.0, 8.0, 5.0, 0.0, 1.0, 2.0, 6.0, 8.0, 2.0, -3.0));
	blockB.e[0] = (mat4(-3.0, -6.0, -5.0, 3.0, 3.0, 0.0, -4.0, -9.0, 0.0, -3.0, -8.0, 8.0, -7.0, -7.0, 8.0, -9.0));
	blockC.f = (vec4(4.0, -4.0, -1.0, 6.0));
	blockC.g[0] = (vec2(-7.0, -1.0));
	blockC.h = (-7.0);
}
#version 450
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
	i16vec2 a;
	bvec3 b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(blockB[nonuniformEXT(0)].a), ivec2(-6, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB[nonuniformEXT(1)].a), ivec2(8, 0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB[nonuniformEXT(2)].a), ivec2(-4, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = i16vec2(ivec2(-6, -9));
	blockB[nonuniformEXT(0)].b = (bvec3(true, true, true));
	blockB[nonuniformEXT(1)].a = i16vec2(ivec2(-5, 0));
	blockB[nonuniformEXT(1)].b = (bvec3(false, true, false));
	blockB[nonuniformEXT(2)].a = i16vec2(ivec2(9, -4));
	blockB[nonuniformEXT(2)].b = (bvec3(false, true, false));
}
#version 450
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
	highp int a;
	highp uint b;
	lowp uint c[1];
	lowp float d;
};
layout(std430, buffer_reference) buffer BlockC
{
	highp uint e;
	lowp float f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.a), -7) && allOk;
	allOk = compare_uint((blockB.b), 4u) && allOk;
	allOk = compare_float((blockB.d), 2.0) && allOk;
	allOk = compare_float((blockC.f), 0.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (0);
	blockB.c[0] = (6u);
	blockB.d = (-2.0);
	blockC.e = (6u);
	blockC.f = (-7.0);
}
#version 450
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
	lowp uvec3 a;
	bvec3 b;
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp uvec4 c;
	lowp uvec3 d;
};
layout(std140, buffer_reference) buffer BlockD
{
	lowp uint e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a), uvec3(7u, 9u, 0u)) && allOk;
	allOk = compare_bvec3((blockB.b), bvec3(false, true, true)) && allOk;
	allOk = compare_uint((blockD.e), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec3(7u, 5u, 2u));
	blockB.b = (bvec3(true, true, true));
	blockC.c = (uvec4(6u, 6u, 4u, 4u));
	blockC.d = (uvec3(1u, 9u, 5u));
	blockD.e = (2u);
}
#version 450
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
	highp int a;
	bvec4 b;
	u8vec3 c[1];
	highp uvec3 d;
};
layout(std430, buffer_reference) buffer BlockC
{
	uint8_t e;
	u8vec3 f;
	i8vec2 g;
	u8vec3 h;
	highp uvec3 i;
};
layout(std430, buffer_reference) buffer BlockD
{
	bvec2 j;
	lowp ivec3 k;
	highp int l;
};
layout(std430, buffer_reference) buffer BlockE
{
	highp int m;
	highp float n;
	mediump ivec2 o;
	u8vec3 p;
	bvec2 q;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(blockB.c[0]), uvec3(8u, 1u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.f), uvec3(8u, 0u, 3u)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.g), ivec2(3, 7)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.h), uvec3(0u, 0u, 3u)) && allOk;
	allOk = compare_uvec3((blockC.i), uvec3(4u, 6u, 5u)) && allOk;
	allOk = compare_bvec2((blockD.j), bvec2(true, false)) && allOk;
	allOk = compare_ivec3((blockD.k), ivec3(2, -6, 8)) && allOk;
	allOk = compare_int((blockE.m), -4) && allOk;
	allOk = compare_ivec2((blockE.o), ivec2(-2, 2)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE.p), uvec3(8u, 6u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (-2);
	blockB.b = (bvec4(false, false, true, true));
	blockB.c[0] = u8vec3(uvec3(8u, 5u, 9u));
	blockC.e = uint8_t(5u);
	blockC.f = u8vec3(uvec3(0u, 2u, 5u));
	blockC.g = i8vec2(ivec2(2, 4294967287));
	blockC.i = (uvec3(2u, 8u, 3u));
	blockD.k = (ivec3(7, -8, -2));
	blockD.l = (-6);
	blockE.m = (-3);
	blockE.n = (0.0);
	blockE.p = u8vec3(uvec3(6u, 0u, 5u));
}
#version 450
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
	lowp mat4x3 a;
	lowp int b;
	highp mat2x3 c;
	u8vec3 d;
	mediump mat2 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB.c, mat2x3(-6.0, 9.0, 8.0, 3.0, 7.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (2);
	blockB.d = u8vec3(uvec3(0u, 5u, 8u));
}
#version 450
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
	lowp mat3 a;
	highp int b;
	mediump mat4 c;
	uint8_t d;
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	highp mat3x2 e;
	i8vec4 f;
	u8vec3 g[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	bvec2 h;
	uint8_t i[];
};
layout(std430, column_major, buffer_reference) buffer BlockE
{
	bvec4 j;
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
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB.a, mat3(-8.0, 9.0, 9.0, -7.0, -4.0, -4.0, -6.0, -2.0, 8.0)) && allOk;
	allOk = compare_int((blockB.b), 4) && allOk;
	allOk = compare_uint8_t(uint(blockB.d), 1u) && allOk;
	allOk = compare_mat3x2(blockC.e, mat3x2(-1.0, 1.0, -1.0, 1.0, 6.0, 7.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.f), ivec4(2, 4294967290, 8, 4294967294)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.g[0]), uvec3(5u, 8u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.g[1]), uvec3(6u, 2u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.g[2]), uvec3(5u, 0u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.g[3]), uvec3(0u, 3u, 4u)) && allOk;
	allOk = compare_uint8_t(uint(blockD.i[0]), 4u) && allOk;
	allOk = compare_uint8_t(uint(blockD.i[1]), 9u) && allOk;
	allOk = compare_uint8_t(uint(blockD.i[2]), 2u) && allOk;
	allOk = compare_uint8_t(uint(blockD.i[3]), 0u) && allOk;
	allOk = compare_uint8_t(uint(blockD.i[4]), 9u) && allOk;
	allOk = compare_uint8_t(uint(blockD.i[5]), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3(4.0, 0.0, 9.0, 4.0, 1.0, -7.0, -4.0, -4.0, -6.0));
	blockB.b = (-5);
	blockB.c = (mat4(-2.0, 4.0, -2.0, 5.0, -9.0, -3.0, -1.0, -9.0, 1.0, 1.0, 7.0, 8.0, 9.0, -7.0, -1.0, -6.0));
	blockB.d = uint8_t(6u);
	blockC.f = i8vec4(ivec4(4294967289, 4294967292, 4294967290, 4294967291));
	blockC.g[0] = u8vec3(uvec3(7u, 0u, 4u));
	blockC.g[1] = u8vec3(uvec3(8u, 1u, 5u));
	blockC.g[2] = u8vec3(uvec3(1u, 5u, 6u));
	blockC.g[3] = u8vec3(uvec3(5u, 5u, 4u));
	blockD.i[0] = uint8_t(6u);
	blockD.i[1] = uint8_t(3u);
	blockD.i[2] = uint8_t(2u);
	blockD.i[3] = uint8_t(7u);
	blockD.i[4] = uint8_t(1u);
	blockD.i[5] = uint8_t(5u);
	blockE.j = (bvec4(true, false, true, true));
}
#version 450
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
	i8vec3 a;
	u8vec2 b;
	uint8_t c[3];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	i8vec3 d;
	bool e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(blockB.a), ivec3(4294967292, 6, 6)) && allOk;
	allOk = compare_uint8_t(uint(blockB.c[0]), 2u) && allOk;
	allOk = compare_uint8_t(uint(blockB.c[1]), 4u) && allOk;
	allOk = compare_uint8_t(uint(blockB.c[2]), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i8vec3(ivec3(9, 4294967289, 4294967291));
	blockB.b = u8vec2(uvec2(7u, 4u));
	blockC.d = i8vec3(ivec3(8, 7, 1));
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

struct sA
{
	bool mA;
	bool mB;
	u8vec3 mC;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	sA a;
	i8vec2 b;
	lowp mat2x3 c[];
};
layout(std140, buffer_reference) buffer BlockC
{
	highp mat4 d;
	mediump vec3 e;
	lowp ivec4 f;
	mediump mat4x2 g[];
};
layout(std430, buffer_reference) buffer BlockD
{
	bool h;
	bool i[];
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a.mA), true) && allOk;
	allOk = compare_bool((blockB.a.mB), true) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.a.mC), uvec3(4u, 4u, 1u)) && allOk;
	allOk = compare_mat2x3(blockB.c[0], mat2x3(-4.0, 1.0, 1.0, 8.0, 8.0, 6.0)) && allOk;
	allOk = compare_ivec4((blockC.f), ivec4(-4, 9, -7, 6)) && allOk;
	allOk = compare_mat4x2(blockC.g[0], mat4x2(2.0, -1.0, 4.0, -3.0, -7.0, -3.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(blockC.g[1], mat4x2(-2.0, 2.0, 1.0, -3.0, -4.0, -5.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x2(blockC.g[2], mat4x2(1.0, -5.0, -1.0, -4.0, 8.0, 4.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat4x2(blockC.g[3], mat4x2(7.0, 8.0, -3.0, -1.0, 7.0, 7.0, -7.0, 3.0)) && allOk;
	allOk = compare_bool((blockD.h), false) && allOk;
	allOk = compare_bool((blockD.i[0]), true) && allOk;
	allOk = compare_bool((blockD.i[1]), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA = (true);
	blockB.a.mB = (true);
	blockB.a.mC = u8vec3(uvec3(5u, 3u, 7u));
	blockB.b = i8vec2(ivec2(4294967287, 4294967290));
	blockB.c[0] = (mat2x3(5.0, 1.0, -4.0, -7.0, 9.0, -9.0));
	blockC.d = (mat4(-8.0, 5.0, 5.0, 1.0, 3.0, -6.0, 9.0, -9.0, 4.0, -3.0, -3.0, 6.0, -2.0, -2.0, 5.0, -1.0));
	blockC.e = (vec3(-4.0, -9.0, -6.0));
	blockC.f = (ivec4(4, -3, -9, -1));
	blockD.h = (false);
	blockD.i[0] = (false);
	blockD.i[1] = (true);
}
#version 450
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
	int8_t mA;
	highp int mB;
	bvec4 mC;
	lowp mat2x3 mD;
};
struct sB
{
	sA mA;
	u8vec2 mB;
	highp mat3x2 mC;
	lowp uvec4 mD;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	u8vec2 a;
	sB b;
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	highp mat2 c;
	bool d;
	i8vec4 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(blockB.a), uvec2(2u, 0u)) && allOk;
	allOk = compare_mat2(blockC.c, mat2(3.0, -7.0, 9.0, 9.0)) && allOk;
	allOk = compare_bool((blockC.d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u8vec2(uvec2(4u, 9u));
	blockC.d = (true);
	blockC.e[0] = i8vec4(ivec4(9, 5, 7, 4294967291));
	blockC.e[1] = i8vec4(ivec4(9, 4294967293, 8, 4294967293));
	blockC.e[2] = i8vec4(ivec4(7, 4294967292, 4294967287, 4294967294));
	blockC.e[3] = i8vec4(ivec4(9, 7, 8, 4294967295));
	blockC.e[4] = i8vec4(ivec4(5, 4294967292, 9, 4294967294));
	blockC.e[5] = i8vec4(ivec4(4294967291, 4294967288, 4294967292, 0));
	blockC.e[6] = i8vec4(ivec4(8, 2, 6, 3));
}
#version 450
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
	bvec4 mC;
	mediump mat4 mD;
};
struct sB
{
	uint8_t mA;
	sA mB;
};
layout(scalar, column_major, buffer_reference) buffer BlockB
{
	highp float a;
	u8vec4 b;
	mediump uvec4 c;
	mediump uvec2 d;
	i8vec3 e[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	sB f[];
};
layout(scalar, row_major, buffer_reference) buffer BlockD
{
	bvec2 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(blockB.b), uvec4(9u, 6u, 3u, 9u)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.e[0]), ivec3(6, 2, 3)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.e[1]), ivec3(3, 3, 5)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.e[2]), ivec3(4294967291, 4294967294, 4294967290)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.e[3]), ivec3(6, 4294967288, 7)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.e[4]), ivec3(4294967293, 4294967287, 9)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.e[5]), ivec3(8, 2, 4)) && allOk;
	allOk = compare_bvec2((blockD.g[0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockD.g[1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockD.g[2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockD.g[3]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockD.g[4]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockD.g[5]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockD.g[6]), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = u8vec4(uvec4(6u, 1u, 3u, 3u));
	blockB.c = (uvec4(9u, 6u, 8u, 0u));
	blockB.d = (uvec2(5u, 7u));
	blockB.e[0] = i8vec3(ivec3(4294967288, 4294967292, 8));
	blockB.e[1] = i8vec3(ivec3(6, 4294967293, 4294967289));
	blockB.e[2] = i8vec3(ivec3(4294967292, 4294967294, 4294967287));
	blockB.e[3] = i8vec3(ivec3(4294967288, 4294967291, 9));
	blockB.e[4] = i8vec3(ivec3(4294967295, 1, 7));
	blockB.e[5] = i8vec3(ivec3(9, 4294967288, 4294967290));
	blockC[0].f[0].mA = uint8_t(2u);
	blockC[0].f[0].mB.mA = (uvec2(0u, 8u));
	blockC[0].f[0].mB.mB = u8vec3(uvec3(9u, 8u, 9u));
	blockC[0].f[0].mB.mC = (bvec4(true, false, true, false));
	blockC[0].f[0].mB.mD = (mat4(8.0, -6.0, 4.0, -6.0, -7.0, -6.0, 7.0, -6.0, -5.0, 3.0, 9.0, -3.0, 5.0, 9.0, 4.0, 7.0));
	blockC[0].f[1].mA = uint8_t(0u);
	blockC[0].f[1].mB.mA = (uvec2(1u, 4u));
	blockC[0].f[1].mB.mB = u8vec3(uvec3(1u, 1u, 4u));
	blockC[0].f[1].mB.mC = (bvec4(false, true, true, true));
	blockC[0].f[1].mB.mD = (mat4(-3.0, -1.0, 1.0, 1.0, -3.0, -8.0, 7.0, 9.0, 0.0, 4.0, 1.0, -4.0, 1.0, -6.0, 3.0, 8.0));
	blockC[0].f[2].mA = uint8_t(1u);
	blockC[0].f[2].mB.mA = (uvec2(8u, 1u));
	blockC[0].f[2].mB.mB = u8vec3(uvec3(9u, 5u, 7u));
	blockC[0].f[2].mB.mC = (bvec4(true, true, true, true));
	blockC[0].f[2].mB.mD = (mat4(4.0, 9.0, 9.0, -4.0, 9.0, -2.0, -7.0, 5.0, 9.0, 0.0, -6.0, -1.0, -7.0, -8.0, 3.0, 7.0));
	blockC[0].f[3].mA = uint8_t(4u);
	blockC[0].f[3].mB.mA = (uvec2(7u, 1u));
	blockC[0].f[3].mB.mB = u8vec3(uvec3(6u, 6u, 7u));
	blockC[0].f[3].mB.mC = (bvec4(true, true, false, true));
	blockC[0].f[3].mB.mD = (mat4(-3.0, -1.0, -6.0, 5.0, 5.0, -2.0, -1.0, -1.0, 1.0, 5.0, -6.0, 2.0, 6.0, -7.0, -9.0, -9.0));
	blockC[0].f[4].mA = uint8_t(6u);
	blockC[0].f[4].mB.mA = (uvec2(6u, 0u));
	blockC[0].f[4].mB.mB = u8vec3(uvec3(5u, 9u, 0u));
	blockC[0].f[4].mB.mC = (bvec4(true, false, true, false));
	blockC[0].f[4].mB.mD = (mat4(5.0, 0.0, -1.0, 8.0, -4.0, -6.0, -2.0, -2.0, -9.0, -8.0, 9.0, 3.0, 0.0, 4.0, 4.0, -1.0));
	blockC[1].f[0].mA = uint8_t(8u);
	blockC[1].f[0].mB.mA = (uvec2(1u, 9u));
	blockC[1].f[0].mB.mB = u8vec3(uvec3(7u, 8u, 6u));
	blockC[1].f[0].mB.mC = (bvec4(true, true, true, true));
	blockC[1].f[0].mB.mD = (mat4(2.0, 2.0, 8.0, 8.0, 1.0, -5.0, 3.0, -4.0, -5.0, 3.0, -8.0, 6.0, 7.0, 6.0, 3.0, -6.0));
	blockC[2].f[0].mA = uint8_t(0u);
	blockC[2].f[0].mB.mA = (uvec2(5u, 0u));
	blockC[2].f[0].mB.mB = u8vec3(uvec3(7u, 1u, 8u));
	blockC[2].f[0].mB.mC = (bvec4(false, true, false, false));
	blockC[2].f[0].mB.mD = (mat4(0.0, -5.0, 3.0, 2.0, 3.0, 3.0, 3.0, 3.0, 6.0, 2.0, 2.0, -4.0, 4.0, -8.0, -2.0, 3.0));
	blockC[2].f[1].mA = uint8_t(5u);
	blockC[2].f[1].mB.mA = (uvec2(2u, 2u));
	blockC[2].f[1].mB.mB = u8vec3(uvec3(6u, 3u, 8u));
	blockC[2].f[1].mB.mC = (bvec4(false, true, true, false));
	blockC[2].f[1].mB.mD = (mat4(5.0, -8.0, 0.0, -2.0, -4.0, 1.0, 5.0, 5.0, -1.0, 1.0, -3.0, 7.0, -9.0, 5.0, -4.0, 2.0));
	blockC[2].f[2].mA = uint8_t(9u);
	blockC[2].f[2].mB.mA = (uvec2(5u, 0u));
	blockC[2].f[2].mB.mB = u8vec3(uvec3(6u, 1u, 2u));
	blockC[2].f[2].mB.mC = (bvec4(true, true, false, true));
	blockC[2].f[2].mB.mD = (mat4(4.0, -1.0, 9.0, -2.0, -4.0, -6.0, 4.0, 5.0, -9.0, -5.0, 2.0, -2.0, 7.0, -7.0, -5.0, -5.0));
	blockC[2].f[3].mA = uint8_t(4u);
	blockC[2].f[3].mB.mA = (uvec2(7u, 1u));
	blockC[2].f[3].mB.mB = u8vec3(uvec3(5u, 9u, 2u));
	blockC[2].f[3].mB.mC = (bvec4(true, false, true, false));
	blockC[2].f[3].mB.mD = (mat4(4.0, 7.0, 1.0, 7.0, -4.0, -5.0, 1.0, 8.0, -1.0, -2.0, -6.0, 2.0, -6.0, 9.0, 1.0, -2.0));
	blockC[2].f[4].mA = uint8_t(5u);
	blockC[2].f[4].mB.mA = (uvec2(6u, 2u));
	blockC[2].f[4].mB.mB = u8vec3(uvec3(4u, 8u, 7u));
	blockC[2].f[4].mB.mC = (bvec4(false, true, false, true));
	blockC[2].f[4].mB.mD = (mat4(-4.0, -2.0, -3.0, 8.0, -8.0, -6.0, -9.0, 0.0, 6.0, -2.0, -3.0, -2.0, -2.0, -6.0, 5.0, 7.0));
	blockC[2].f[5].mA = uint8_t(0u);
	blockC[2].f[5].mB.mA = (uvec2(9u, 6u));
	blockC[2].f[5].mB.mB = u8vec3(uvec3(5u, 3u, 9u));
	blockC[2].f[5].mB.mC = (bvec4(false, false, false, true));
	blockC[2].f[5].mB.mD = (mat4(-7.0, 9.0, 2.0, 7.0, -5.0, 4.0, 7.0, -3.0, 7.0, 8.0, -9.0, 8.0, 3.0, -5.0, -2.0, -9.0));
	blockC[2].f[6].mA = uint8_t(7u);
	blockC[2].f[6].mB.mA = (uvec2(4u, 4u));
	blockC[2].f[6].mB.mB = u8vec3(uvec3(4u, 3u, 1u));
	blockC[2].f[6].mB.mC = (bvec4(true, false, false, false));
	blockC[2].f[6].mB.mD = (mat4(-7.0, 6.0, -5.0, 8.0, 0.0, 6.0, -6.0, 7.0, 4.0, 9.0, -8.0, 9.0, 7.0, 2.0, -6.0, 6.0));
	blockC[2].f[7].mA = uint8_t(1u);
	blockC[2].f[7].mB.mA = (uvec2(8u, 7u));
	blockC[2].f[7].mB.mB = u8vec3(uvec3(4u, 2u, 8u));
	blockC[2].f[7].mB.mC = (bvec4(true, true, false, false));
	blockC[2].f[7].mB.mD = (mat4(1.0, 5.0, -1.0, -8.0, 0.0, 2.0, 3.0, 4.0, -2.0, 3.0, 2.0, -4.0, 7.0, -5.0, 5.0, 2.0));
	blockD.g[0] = (bvec2(true, true));
	blockD.g[1] = (bvec2(true, false));
	blockD.g[2] = (bvec2(true, false));
	blockD.g[3] = (bvec2(false, false));
	blockD.g[4] = (bvec2(false, false));
	blockD.g[5] = (bvec2(true, true));
	blockD.g[6] = (bvec2(false, true));
}
#version 450
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
	highp uvec4 mA;
	mediump vec2 mB;
};
layout(scalar, buffer_reference) buffer BlockB
{
	i8vec3 a;
	u8vec3 b;
	mediump mat3x2 c[];
};
layout(scalar, buffer_reference) readonly buffer BlockC
{
	mediump mat4x2 d[];
};
layout(scalar, buffer_reference) buffer BlockD
{
	bvec2 e;
	bvec3 f;
	sA g[];
};
layout(scalar, column_major, buffer_reference) buffer BlockE
{
	lowp mat3x4 h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
    BlockD blockD;
    BlockE blockE[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(blockB[0].a), ivec3(3, 4294967287, 4294967294)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB[1].a), ivec3(4294967293, 2, 4294967290)) && allOk;
	allOk = compare_mat4x2(blockC.d[0], mat4x2(-5.0, 5.0, 3.0, -7.0, 9.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(blockC.d[1], mat4x2(5.0, -3.0, 8.0, 5.0, 1.0, 5.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat4x2(blockC.d[2], mat4x2(7.0, 2.0, 5.0, 1.0, 2.0, 9.0, 0.0, -6.0)) && allOk;
	allOk = compare_bvec2((blockD.e), bvec2(true, false)) && allOk;
	allOk = compare_bvec3((blockD.f), bvec3(true, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = i8vec3(ivec3(4294967295, 4294967294, 8));
	blockB[0].b = u8vec3(uvec3(2u, 8u, 5u));
	blockB[0].c[0] = (mat3x2(7.0, -6.0, 5.0, 2.0, 1.0, -1.0));
	blockB[0].c[1] = (mat3x2(-7.0, -8.0, -8.0, -5.0, 1.0, -3.0));
	blockB[0].c[2] = (mat3x2(9.0, 1.0, 8.0, -1.0, -7.0, 2.0));
	blockB[0].c[3] = (mat3x2(2.0, -2.0, 9.0, 1.0, 0.0, 1.0));
	blockB[1].a = i8vec3(ivec3(1, 8, 9));
	blockB[1].b = u8vec3(uvec3(3u, 4u, 9u));
	blockB[1].c[0] = (mat3x2(7.0, 4.0, -7.0, 4.0, 9.0, 3.0));
	blockB[1].c[1] = (mat3x2(-7.0, 0.0, -3.0, 7.0, 4.0, 9.0));
	blockD.e = (bvec2(true, false));
	blockD.g[0].mA = (uvec4(3u, 3u, 3u, 7u));
	blockD.g[0].mB = (vec2(0.0, -1.0));
	blockD.g[1].mA = (uvec4(5u, 2u, 1u, 6u));
	blockD.g[1].mB = (vec2(9.0, -6.0));
	blockE[0].h[0] = (mat3x4(0.0, -7.0, -5.0, 6.0, 2.0, -6.0, -5.0, -5.0, -1.0, 2.0, -5.0, -1.0));
	blockE[0].h[1] = (mat3x4(9.0, -9.0, 4.0, -3.0, -2.0, 6.0, -3.0, -7.0, 9.0, 1.0, 4.0, -9.0));
	blockE[0].h[2] = (mat3x4(6.0, 9.0, 0.0, 8.0, -6.0, -3.0, -7.0, 2.0, -9.0, 8.0, 4.0, 0.0));
	blockE[0].h[3] = (mat3x4(-8.0, -9.0, 8.0, -8.0, 0.0, 1.0, 5.0, 2.0, -3.0, -6.0, 7.0, -5.0));
	blockE[0].h[4] = (mat3x4(6.0, 1.0, 5.0, -1.0, -1.0, -9.0, 7.0, 4.0, -4.0, 4.0, -4.0, 7.0));
	blockE[1].h[0] = (mat3x4(4.0, 8.0, -6.0, 3.0, 1.0, 6.0, 2.0, -1.0, 5.0, -3.0, 7.0, -2.0));
	blockE[1].h[1] = (mat3x4(-3.0, -4.0, 0.0, 9.0, 9.0, -8.0, -6.0, 2.0, 4.0, 3.0, -1.0, -6.0));
	blockE[1].h[2] = (mat3x4(-8.0, 7.0, 1.0, -1.0, -9.0, 7.0, -9.0, -6.0, -1.0, 1.0, -8.0, 4.0));
	blockE[1].h[3] = (mat3x4(-1.0, 6.0, -3.0, 5.0, -6.0, -6.0, -1.0, -9.0, 7.0, -5.0, -4.0, -6.0));
}
#version 450
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
	bvec3 a;
	lowp mat2 b;
	lowp mat3 c;
	highp float d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB[nonuniformEXT(0)].a), bvec3(true, false, false)) && allOk;
	allOk = compare_mat3(blockB[nonuniformEXT(0)].c, mat3(-8.0, -1.0, 4.0, -7.0, 3.0, 8.0, 1.0, 9.0, 5.0)) && allOk;
	allOk = compare_bvec3((blockB[nonuniformEXT(1)].a), bvec3(false, false, false)) && allOk;
	allOk = compare_mat3(blockB[nonuniformEXT(1)].c, mat3(9.0, 0.0, 1.0, -3.0, 1.0, 6.0, 6.0, 6.0, -8.0)) && allOk;
	allOk = compare_bvec3((blockB[nonuniformEXT(2)].a), bvec3(true, false, true)) && allOk;
	allOk = compare_mat3(blockB[nonuniformEXT(2)].c, mat3(-1.0, 9.0, -9.0, 9.0, 3.0, -9.0, 3.0, 5.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (bvec3(true, true, true));
	blockB[nonuniformEXT(1)].a = (bvec3(true, true, true));
	blockB[nonuniformEXT(2)].a = (bvec3(false, false, true));
}
#version 450
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
	int8_t a;
	mediump float b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB[nonuniformEXT(0)].b), -2.0) && allOk;
	allOk = compare_float((blockB[nonuniformEXT(1)].b), 7.0) && allOk;
	allOk = compare_float((blockB[nonuniformEXT(2)].b), 0.0) && allOk;
	allOk = compare_float((blockB[nonuniformEXT(3)].b), -4.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = int8_t(1);
	blockB[nonuniformEXT(0)].b = (-6.0);
	blockB[nonuniformEXT(1)].a = int8_t(4294967294);
	blockB[nonuniformEXT(1)].b = (5.0);
	blockB[nonuniformEXT(2)].a = int8_t(1);
	blockB[nonuniformEXT(2)].b = (-6.0);
	blockB[nonuniformEXT(3)].a = int8_t(4294967291);
	blockB[nonuniformEXT(3)].b = (-1.0);
}
