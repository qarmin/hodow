#version 450
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
	lowp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var, mat3(4.0, -3.0, 1.0, -7.0, 7.0, -7.0, -5.0, 6.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3(-5.0, -3.0, -5.0, -2.0, 2.0, -5.0, 6.0, 3.0, -8.0));
}
#version 450
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
	highp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var, mat3(8.0, 6.0, -1.0, -6.0, 1.0, -4.0, -9.0, 1.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3(2.0, -3.0, 9.0, -8.0, 1.0, 7.0, 4.0, -1.0, 8.0));
}
#version 450
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

	var = (mat4(0.0, 9.0, -7.0, 3.0, 6.0, 6.0, 6.0, 1.0, -1.0, 2.0, 3.0, 8.0, 3.0, 1.0, 2.0, -2.0));
}
#version 450
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
	allOk = compare_float(var[0][0], -7.0) && allOk;
	allOk = compare_float(var[0][1], 5.0) && allOk;
	allOk = compare_float(var[0][2], -8.0) && allOk;
	allOk = compare_float(var[0][3], -5.0) && allOk;
	allOk = compare_float(var[1][0], 6.0) && allOk;
	allOk = compare_float(var[1][1], -3.0) && allOk;
	allOk = compare_float(var[1][2], -2.0) && allOk;
	allOk = compare_float(var[1][3], 1.0) && allOk;
	allOk = compare_float(var[2][0], -6.0) && allOk;
	allOk = compare_float(var[2][1], 2.0) && allOk;
	allOk = compare_float(var[2][2], -7.0) && allOk;
	allOk = compare_float(var[2][3], -4.0) && allOk;
	allOk = compare_float(var[3][0], 2.0) && allOk;
	allOk = compare_float(var[3][1], -6.0) && allOk;
	allOk = compare_float(var[3][2], -4.0) && allOk;
	allOk = compare_float(var[3][3], -7.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-7.0, 5.0, -8.0, -5.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(6.0, -3.0, -2.0, 1.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-6.0, 2.0, -7.0, -4.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(2.0, -6.0, -4.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4(-7.0, -6.0, -9.0, 9.0, -9.0, 8.0, 8.0, -8.0, 3.0, -3.0, 5.0, -9.0, -3.0, 2.0, 0.0, -1.0));
}
#version 450
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
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var, mat2x4(-3.0, -4.0, -4.0, -7.0, -6.0, -3.0, 1.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2x4(-9.0, 2.0, 2.0, -2.0, -9.0, 4.0, 6.0, 5.0));
}
#version 450
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
	lowp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], -6.0) && allOk;
	allOk = compare_float(var[0][2], -8.0) && allOk;
	allOk = compare_float(var[1][0], 3.0) && allOk;
	allOk = compare_float(var[1][1], 1.0) && allOk;
	allOk = compare_float(var[1][2], 1.0) && allOk;
	allOk = compare_float(var[2][0], -6.0) && allOk;
	allOk = compare_float(var[2][1], -2.0) && allOk;
	allOk = compare_float(var[2][2], -5.0) && allOk;
	allOk = compare_vec3(var[0], vec3(1.0, -6.0, -8.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(3.0, 1.0, 1.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-6.0, -2.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(2.0, -4.0, 5.0));
	var[1] = (vec3(8.0, -3.0, 1.0));
	var[2] = (vec3(-8.0, -5.0, 3.0));
}
#version 450
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
	lowp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var, mat4(2.0, 7.0, 4.0, -4.0, -1.0, -9.0, -2.0, 4.0, -5.0, -5.0, -7.0, -8.0, 5.0, 2.0, -1.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4(2.0, 0.0, -9.0, -5.0, 3.0, -8.0, 5.0, -4.0, 0.0, 1.0, 6.0, -2.0, -7.0, -5.0, 0.0, -5.0));
}
#version 450
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
	highp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var, mat4(1.0, -7.0, -7.0, -8.0, -2.0, 6.0, -6.0, 5.0, -8.0, -5.0, -8.0, -4.0, 4.0, -4.0, 4.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4(-9.0, 1.0, 7.0, 9.0, -7.0, 2.0, -9.0, -7.0, 1.0, 9.0, 5.0, 4.0, -3.0, 0.0, 6.0, 0.0));
}
#version 450
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
	allOk = compare_float(var[0][0], 0.0) && allOk;
	allOk = compare_float(var[0][1], -6.0) && allOk;
	allOk = compare_float(var[0][2], -4.0) && allOk;
	allOk = compare_float(var[1][0], 8.0) && allOk;
	allOk = compare_float(var[1][1], 2.0) && allOk;
	allOk = compare_float(var[1][2], -3.0) && allOk;
	allOk = compare_vec3(var[0], vec3(0.0, -6.0, -4.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(8.0, 2.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2x3(6.0, -8.0, 5.0, 2.0, -3.0, 6.0));
}
#version 450
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
	highp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -1.0) && allOk;
	allOk = compare_mat2x4(var, mat2x4(9.0, -1.0, 7.0, -5.0, -9.0, 2.0, -8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (1.0);
	var[0] = (vec4(9.0, 8.0, -8.0, -2.0));
	var[1] = (vec4(8.0, 5.0, -5.0, -7.0));
}
#version 450
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
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 8.0) && allOk;
	allOk = compare_mat3x4(var, mat3x4(-3.0, 1.0, 4.0, -6.0, 6.0, 8.0, -7.0, -4.0, -8.0, -2.0, -6.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (6.0);
	var = (mat3x4(1.0, -5.0, 8.0, 0.0, 5.0, 6.0, 6.0, 8.0, -8.0, -6.0, -7.0, 0.0));
}
#version 450
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
	highp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -6.0) && allOk;
	allOk = compare_float(var[0][0], 4.0) && allOk;
	allOk = compare_float(var[0][1], -4.0) && allOk;
	allOk = compare_float(var[1][0], 6.0) && allOk;
	allOk = compare_float(var[1][1], -6.0) && allOk;
	allOk = compare_float(var[2][0], 6.0) && allOk;
	allOk = compare_float(var[2][1], -3.0) && allOk;
	allOk = compare_float(var[3][0], -8.0) && allOk;
	allOk = compare_float(var[3][1], 4.0) && allOk;
	allOk = compare_vec2(var[0], vec2(4.0, -4.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(6.0, -6.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(6.0, -3.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(-8.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (4.0);
	var[0] = (vec2(9.0, -6.0));
	var[1] = (vec2(6.0, -1.0));
	var[2] = (vec2(8.0, 1.0));
	var[3] = (vec2(3.0, 0.0));
}
#version 450
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
	u8vec2 var[3];
};

bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(var[0]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1]), uvec2(7u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2]), uvec2(4u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = u8vec2(uvec2(7u, 7u));
	var[1] = u8vec2(uvec2(9u, 6u));
	var[2] = u8vec2(uvec2(0u, 2u));
}
#version 450
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

	var[0] = float16_t(-8.0);
	var[1] = float16_t(9.0);
	var[2] = float16_t(-2.0);
}
#version 450
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
	highp mat2 var[3];
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
    if (allOk)
        ac_numPassed++;

	var[0] = (mat2(1.0, 2.0, 6.0, -6.0));
	var[1] = (mat2(2.0, 4.0, 4.0, 7.0));
	var[2] = (mat2(0.0, 8.0, 0.0, -1.0));
}
#version 450
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
	highp mat3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0], mat3(3.0, -9.0, 7.0, 0.0, -1.0, -8.0, 0.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(9.0, 8.0, -4.0, -1.0, 5.0, -5.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(-4.0, -9.0, 4.0, 5.0, -4.0, -4.0, 6.0, 2.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3(7.0, -8.0, -8.0, -4.0, -3.0, 5.0, -3.0, -3.0, -1.0));
	var[1] = (mat3(5.0, 1.0, -3.0, 9.0, 1.0, 5.0, 0.0, 5.0, -1.0));
	var[2] = (mat3(-7.0, 4.0, 1.0, -6.0, 3.0, 6.0, 1.0, 9.0, 3.0));
}
#version 450
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
	highp mat2x3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0], mat2x3(-2.0, 3.0, -3.0, 8.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(-4.0, -6.0, -3.0, -8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(1.0, -5.0, 8.0, -3.0, 0.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat2x3(0.0, 4.0, 4.0, 5.0, -5.0, 2.0));
	var[1] = (mat2x3(8.0, -1.0, -2.0, -7.0, -8.0, -2.0));
	var[2] = (mat2x3(2.0, -2.0, 7.0, -9.0, 7.0, -7.0));
}
#version 450
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
	i8vec2 var[3];
};

bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(var[0]), ivec2(4294967288, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1]), ivec2(1, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2]), ivec2(0, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = i8vec2(ivec2(0, 8));
	var[1] = i8vec2(ivec2(4294967292, 9));
	var[2] = i8vec2(ivec2(4294967294, 4294967295));
}
#version 450
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
	int padding;
	highp ivec2 var[3];
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((padding), 6) && allOk;
	allOk = compare_ivec2((var[0]), ivec2(-1, 7)) && allOk;
	allOk = compare_ivec2((var[1]), ivec2(-5, -8)) && allOk;
	allOk = compare_ivec2((var[2]), ivec2(8, -2)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-6);
	var[0] = (ivec2(8, 3));
	var[1] = (ivec2(-1, -5));
	var[2] = (ivec2(-2, 0));
}
#version 450
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

	padding = (-8.0);
	var[0] = (mat3x4(-6.0, 4.0, -9.0, 7.0, -4.0, -7.0, 0.0, -6.0, -6.0, -3.0, 4.0, 3.0));
	var[1] = (mat3x4(-2.0, -3.0, 4.0, 2.0, 8.0, 2.0, -4.0, 9.0, -1.0, 9.0, 7.0, 1.0));
	var[2] = (mat3x4(-1.0, 1.0, 5.0, 5.0, -4.0, -7.0, -4.0, 0.0, 6.0, 2.0, 0.0, -6.0));
}
#version 450
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
	highp mat4x2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat4x2(var[0], mat4x2(5.0, 7.0, 1.0, -5.0, 5.0, 9.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(-7.0, -4.0, 7.0, 7.0, 5.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(-9.0, -7.0, -1.0, 8.0, 0.0, 4.0, 7.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (6.0);
	var[0][0] = (vec2(-4.0, -4.0));
	var[0][1] = (vec2(2.0, 0.0));
	var[0][2] = (vec2(-7.0, 3.0));
	var[0][3] = (vec2(9.0, 9.0));
	var[1][0] = (vec2(8.0, -9.0));
	var[1][1] = (vec2(-9.0, -6.0));
	var[1][2] = (vec2(-4.0, -6.0));
	var[1][3] = (vec2(-6.0, -8.0));
	var[2][0] = (vec2(6.0, -8.0));
	var[2][1] = (vec2(-8.0, 3.0));
	var[2][2] = (vec2(2.0, 8.0));
	var[2][3] = (vec2(5.0, -8.0));
}
#version 450
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

	var[0] = (mat2(-2.0, -8.0, -7.0, 9.0));
	var[1] = (mat2(2.0, 2.0, -4.0, -5.0));
	var[2] = (mat2(-1.0, -4.0, 0.0, -1.0));
	var[3] = (mat2(0.0, 4.0, -3.0, -4.0));
	var[4] = (mat2(-6.0, 0.0, 5.0, 1.0));
	var[5] = (mat2(-6.0, 9.0, 5.0, 9.0));
	var[6] = (mat2(5.0, -3.0, -3.0, 6.0));
	var[7] = (mat2(-4.0, -6.0, -2.0, -6.0));
	var[8] = (mat2(-3.0, -4.0, -7.0, -9.0));
	var[9] = (mat2(8.0, 2.0, -6.0, 9.0));
	var[10] = (mat2(-5.0, -2.0, 4.0, 9.0));
	var[11] = (mat2(4.0, 7.0, 4.0, -8.0));
	var[12] = (mat2(5.0, 7.0, 7.0, -8.0));
	var[13] = (mat2(7.0, -9.0, -2.0, 4.0));
	var[14] = (mat2(3.0, 3.0, 3.0, -6.0));
	var[15] = (mat2(-4.0, -8.0, -2.0, 5.0));
	var[16] = (mat2(-3.0, 5.0, 0.0, -2.0));
	var[17] = (mat2(-3.0, 0.0, -9.0, 1.0));
	var[18] = (mat2(-8.0, 1.0, -1.0, -3.0));
}
#version 450
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
	highp mat3x4 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0], mat3x4(6.0, 7.0, 2.0, -5.0, -4.0, 6.0, 5.0, 2.0, 9.0, -7.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(5.0, -9.0, 0.0, -9.0, -4.0, 7.0, -1.0, -8.0, -5.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(-1.0, -5.0, -7.0, -9.0, 6.0, -8.0, -6.0, -8.0, 5.0, 1.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[3], mat3x4(-5.0, 7.0, -8.0, 7.0, -8.0, 4.0, 8.0, 0.0, 9.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[4], mat3x4(-9.0, 6.0, -3.0, 4.0, -1.0, 1.0, 6.0, 2.0, 4.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[5], mat3x4(-9.0, 7.0, -1.0, 8.0, -6.0, 4.0, -2.0, 6.0, 9.0, -4.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[6], mat3x4(-8.0, 1.0, -8.0, -8.0, 5.0, -8.0, 1.0, 0.0, -6.0, 3.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[7], mat3x4(-9.0, 9.0, -5.0, 3.0, 0.0, 0.0, -5.0, -9.0, -9.0, 7.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[8], mat3x4(-5.0, -8.0, -1.0, -1.0, -2.0, 1.0, 5.0, 7.0, 6.0, 6.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[9], mat3x4(8.0, 4.0, 7.0, 2.0, -3.0, -4.0, 8.0, 3.0, 2.0, -5.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[10], mat3x4(7.0, -3.0, -3.0, 1.0, 8.0, 3.0, 5.0, 6.0, 8.0, 1.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[11], mat3x4(9.0, 2.0, 5.0, 7.0, -4.0, 2.0, 1.0, 6.0, -3.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[12], mat3x4(8.0, 5.0, 9.0, 6.0, -3.0, 4.0, 6.0, -8.0, -9.0, -2.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[13], mat3x4(1.0, 7.0, -6.0, 3.0, 2.0, 9.0, -9.0, 1.0, 0.0, -1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[14], mat3x4(1.0, 0.0, 9.0, -2.0, -2.0, 1.0, 8.0, 0.0, 0.0, -4.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[15], mat3x4(9.0, -5.0, 2.0, 8.0, -5.0, -3.0, -6.0, 9.0, -7.0, -7.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[16], mat3x4(2.0, 0.0, -2.0, -7.0, 6.0, -9.0, 9.0, -6.0, 3.0, -2.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[17], mat3x4(-5.0, 4.0, 0.0, 2.0, 9.0, 7.0, -3.0, 3.0, 5.0, 2.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[18], mat3x4(-8.0, -4.0, 5.0, -8.0, -2.0, -1.0, -3.0, 5.0, 7.0, -7.0, -9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec4(-3.0, -5.0, 2.0, 5.0));
	var[0][1] = (vec4(-2.0, -3.0, 9.0, -2.0));
	var[0][2] = (vec4(-6.0, 7.0, 4.0, -6.0));
	var[1][0] = (vec4(2.0, 6.0, 9.0, -2.0));
	var[1][1] = (vec4(7.0, 9.0, 0.0, 0.0));
	var[1][2] = (vec4(8.0, -3.0, 0.0, 3.0));
	var[2][0] = (vec4(-6.0, 1.0, 9.0, 6.0));
	var[2][1] = (vec4(-9.0, -9.0, 2.0, -4.0));
	var[2][2] = (vec4(-8.0, 5.0, -1.0, 9.0));
	var[3][0] = (vec4(8.0, -2.0, 1.0, 1.0));
	var[3][1] = (vec4(-6.0, -1.0, -9.0, 6.0));
	var[3][2] = (vec4(7.0, -1.0, 1.0, -8.0));
	var[4][0] = (vec4(6.0, 8.0, -2.0, 7.0));
	var[4][1] = (vec4(1.0, -6.0, -3.0, 9.0));
	var[4][2] = (vec4(1.0, -6.0, 1.0, -6.0));
	var[5][0] = (vec4(3.0, -1.0, 5.0, -2.0));
	var[5][1] = (vec4(7.0, -1.0, -2.0, -3.0));
	var[5][2] = (vec4(-6.0, 4.0, -4.0, -1.0));
	var[6][0] = (vec4(-3.0, -3.0, 3.0, -7.0));
	var[6][1] = (vec4(2.0, 8.0, -4.0, 1.0));
	var[6][2] = (vec4(-1.0, 6.0, -4.0, 7.0));
	var[7][0] = (vec4(5.0, -8.0, -2.0, 6.0));
	var[7][1] = (vec4(-2.0, 8.0, -2.0, 2.0));
	var[7][2] = (vec4(3.0, 7.0, 0.0, 2.0));
	var[8][0] = (vec4(3.0, 9.0, 8.0, 5.0));
	var[8][1] = (vec4(2.0, -3.0, -7.0, 2.0));
	var[8][2] = (vec4(-1.0, 1.0, -4.0, -1.0));
	var[9][0] = (vec4(-6.0, -4.0, -1.0, -3.0));
	var[9][1] = (vec4(-8.0, 5.0, -4.0, -9.0));
	var[9][2] = (vec4(8.0, 3.0, -8.0, 0.0));
	var[10][0] = (vec4(7.0, -2.0, 0.0, 8.0));
	var[10][1] = (vec4(-9.0, 2.0, -3.0, -7.0));
	var[10][2] = (vec4(-5.0, 3.0, 9.0, -6.0));
	var[11][0] = (vec4(-7.0, -8.0, -8.0, -7.0));
	var[11][1] = (vec4(-9.0, 2.0, 4.0, -7.0));
	var[11][2] = (vec4(8.0, -7.0, 4.0, -8.0));
	var[12][0] = (vec4(0.0, 7.0, 3.0, -7.0));
	var[12][1] = (vec4(-7.0, 7.0, -4.0, -5.0));
	var[12][2] = (vec4(-8.0, -8.0, -7.0, 4.0));
	var[13][0] = (vec4(6.0, -3.0, 8.0, -1.0));
	var[13][1] = (vec4(-4.0, 8.0, 8.0, 1.0));
	var[13][2] = (vec4(-8.0, -7.0, 5.0, -9.0));
	var[14][0] = (vec4(1.0, -8.0, 2.0, -2.0));
	var[14][1] = (vec4(-8.0, -9.0, 1.0, -3.0));
	var[14][2] = (vec4(-4.0, 3.0, -9.0, 6.0));
	var[15][0] = (vec4(-8.0, 3.0, -5.0, 6.0));
	var[15][1] = (vec4(9.0, 2.0, -1.0, 8.0));
	var[15][2] = (vec4(-2.0, 5.0, -2.0, 6.0));
	var[16][0] = (vec4(1.0, 2.0, 8.0, -3.0));
	var[16][1] = (vec4(6.0, -3.0, -8.0, 2.0));
	var[16][2] = (vec4(-6.0, -8.0, 3.0, 3.0));
	var[17][0] = (vec4(0.0, 9.0, 4.0, -8.0));
	var[17][1] = (vec4(-7.0, 6.0, -4.0, -8.0));
	var[17][2] = (vec4(2.0, 9.0, 1.0, 0.0));
	var[18][0] = (vec4(3.0, 0.0, -5.0, -4.0));
	var[18][1] = (vec4(-9.0, -4.0, 0.0, -5.0));
	var[18][2] = (vec4(-9.0, -9.0, 6.0, -4.0));
}
#version 450
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

	var[0] = u8vec2(uvec2(7u, 7u));
	var[1] = u8vec2(uvec2(9u, 6u));
	var[2] = u8vec2(uvec2(0u, 2u));
	var[3] = u8vec2(uvec2(1u, 1u));
	var[4] = u8vec2(uvec2(0u, 8u));
	var[5] = u8vec2(uvec2(8u, 5u));
	var[6] = u8vec2(uvec2(2u, 7u));
	var[7] = u8vec2(uvec2(4u, 4u));
	var[8] = u8vec2(uvec2(7u, 2u));
	var[9] = u8vec2(uvec2(4u, 5u));
	var[10] = u8vec2(uvec2(0u, 2u));
	var[11] = u8vec2(uvec2(1u, 8u));
	var[12] = u8vec2(uvec2(1u, 8u));
	var[13] = u8vec2(uvec2(4u, 0u));
	var[14] = u8vec2(uvec2(2u, 7u));
	var[15] = u8vec2(uvec2(2u, 0u));
	var[16] = u8vec2(uvec2(2u, 5u));
	var[17] = u8vec2(uvec2(3u, 4u));
	var[18] = u8vec2(uvec2(7u, 4u));
}
#version 450
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
	highp vec2 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((var[0]), vec2(5.0, 4.0)) && allOk;
	allOk = compare_vec2((var[1]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((var[2]), vec2(-7.0, -5.0)) && allOk;
	allOk = compare_vec2((var[3]), vec2(-9.0, 7.0)) && allOk;
	allOk = compare_vec2((var[4]), vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec2((var[5]), vec2(-8.0, 2.0)) && allOk;
	allOk = compare_vec2((var[6]), vec2(4.0, -2.0)) && allOk;
	allOk = compare_vec2((var[7]), vec2(2.0, 2.0)) && allOk;
	allOk = compare_vec2((var[8]), vec2(-8.0, 3.0)) && allOk;
	allOk = compare_vec2((var[9]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((var[10]), vec2(7.0, 5.0)) && allOk;
	allOk = compare_vec2((var[11]), vec2(-6.0, -1.0)) && allOk;
	allOk = compare_vec2((var[12]), vec2(-1.0, -4.0)) && allOk;
	allOk = compare_vec2((var[13]), vec2(6.0, -7.0)) && allOk;
	allOk = compare_vec2((var[14]), vec2(-8.0, 7.0)) && allOk;
	allOk = compare_vec2((var[15]), vec2(2.0, -3.0)) && allOk;
	allOk = compare_vec2((var[16]), vec2(4.0, -5.0)) && allOk;
	allOk = compare_vec2((var[17]), vec2(-6.0, -4.0)) && allOk;
	allOk = compare_vec2((var[18]), vec2(-5.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec2(3.0, 8.0));
	var[1] = (vec2(7.0, -1.0));
	var[2] = (vec2(-4.0, 8.0));
	var[3] = (vec2(-2.0, -5.0));
	var[4] = (vec2(-2.0, 5.0));
	var[5] = (vec2(6.0, -2.0));
	var[6] = (vec2(-6.0, -6.0));
	var[7] = (vec2(1.0, 6.0));
	var[8] = (vec2(-7.0, 6.0));
	var[9] = (vec2(1.0, -6.0));
	var[10] = (vec2(-9.0, 0.0));
	var[11] = (vec2(-8.0, -4.0));
	var[12] = (vec2(-6.0, -2.0));
	var[13] = (vec2(5.0, 4.0));
	var[14] = (vec2(0.0, 0.0));
	var[15] = (vec2(-4.0, -9.0));
	var[16] = (vec2(-2.0, 2.0));
	var[17] = (vec2(-2.0, 8.0));
	var[18] = (vec2(-4.0, -4.0));
}
#version 450
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

layout(std430, column_major, binding = 1) buffer Block
{
	highp mat4x2 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0], mat4x2(-5.0, -2.0, -4.0, 7.0, -9.0, -9.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(-6.0, -1.0, -5.0, -9.0, -2.0, -2.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(-3.0, -8.0, -8.0, 1.0, 3.0, 0.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[3], mat4x2(0.0, -7.0, -1.0, 4.0, -3.0, -1.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[4], mat4x2(0.0, 8.0, -9.0, -4.0, 3.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[5], mat4x2(-8.0, -6.0, 1.0, -7.0, 1.0, -4.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[6], mat4x2(4.0, -8.0, 7.0, 0.0, 5.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[7], mat4x2(-9.0, -5.0, -3.0, 3.0, -3.0, 8.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[8], mat4x2(-2.0, 0.0, 3.0, 5.0, 9.0, -9.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[9], mat4x2(9.0, -1.0, 3.0, 6.0, 8.0, -8.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[10], mat4x2(-3.0, -9.0, -2.0, 8.0, -2.0, 7.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[11], mat4x2(-5.0, 8.0, -6.0, -6.0, -3.0, -1.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[12], mat4x2(4.0, -4.0, -2.0, 1.0, 2.0, 6.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[13], mat4x2(8.0, 8.0, -3.0, -7.0, 8.0, -1.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[14], mat4x2(-4.0, 5.0, -6.0, 5.0, -9.0, -3.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[15], mat4x2(-9.0, -9.0, 0.0, -2.0, 7.0, 4.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[16], mat4x2(0.0, -7.0, -8.0, 5.0, 7.0, -1.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[17], mat4x2(4.0, 3.0, 5.0, -4.0, 8.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[18], mat4x2(6.0, 8.0, 5.0, -7.0, -9.0, 6.0, -8.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4x2(0.0, -3.0, -2.0, 2.0, -2.0, -3.0, 5.0, -5.0));
	var[1] = (mat4x2(5.0, -6.0, -4.0, -1.0, 4.0, 7.0, -8.0, -2.0));
	var[2] = (mat4x2(-5.0, -1.0, -3.0, 6.0, -2.0, 0.0, -7.0, -7.0));
	var[3] = (mat4x2(2.0, 0.0, -6.0, 9.0, 1.0, -7.0, 4.0, -6.0));
	var[4] = (mat4x2(5.0, -4.0, -3.0, 8.0, -6.0, -1.0, -6.0, 7.0));
	var[5] = (mat4x2(4.0, 7.0, -6.0, 5.0, -4.0, -7.0, 2.0, 1.0));
	var[6] = (mat4x2(6.0, -3.0, -5.0, -7.0, -7.0, 4.0, -9.0, 7.0));
	var[7] = (mat4x2(2.0, 2.0, 9.0, 3.0, -1.0, -8.0, 1.0, -5.0));
	var[8] = (mat4x2(6.0, 2.0, -6.0, 4.0, -3.0, -6.0, -7.0, -8.0));
	var[9] = (mat4x2(-1.0, -4.0, -5.0, 2.0, -7.0, -1.0, 7.0, 1.0));
	var[10] = (mat4x2(9.0, -3.0, -8.0, 4.0, 5.0, -9.0, 9.0, -3.0));
	var[11] = (mat4x2(5.0, 6.0, -5.0, 1.0, 0.0, 8.0, -9.0, -4.0));
	var[12] = (mat4x2(2.0, -6.0, -9.0, 6.0, 2.0, -2.0, 9.0, 8.0));
	var[13] = (mat4x2(8.0, 3.0, -2.0, -8.0, 8.0, 4.0, -3.0, 4.0));
	var[14] = (mat4x2(-5.0, 5.0, 9.0, -8.0, -8.0, -5.0, -4.0, -1.0));
	var[15] = (mat4x2(-1.0, -6.0, 6.0, -3.0, -5.0, 2.0, 6.0, 1.0));
	var[16] = (mat4x2(-9.0, 0.0, -5.0, -9.0, 9.0, 8.0, -6.0, -4.0));
	var[17] = (mat4x2(-4.0, -8.0, 9.0, 7.0, -5.0, -3.0, 3.0, 7.0));
	var[18] = (mat4x2(-1.0, 2.0, 5.0, -9.0, 3.0, 2.0, -5.0, 4.0));
}
#version 450
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
	highp uvec4 var[4][3];
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((var[0][0]), uvec4(4u, 1u, 8u, 2u)) && allOk;
	allOk = compare_uvec4((var[0][1]), uvec4(1u, 9u, 5u, 9u)) && allOk;
	allOk = compare_uvec4((var[0][2]), uvec4(3u, 6u, 5u, 1u)) && allOk;
	allOk = compare_uvec4((var[1][0]), uvec4(2u, 3u, 3u, 6u)) && allOk;
	allOk = compare_uvec4((var[1][1]), uvec4(0u, 7u, 0u, 0u)) && allOk;
	allOk = compare_uvec4((var[1][2]), uvec4(2u, 8u, 5u, 1u)) && allOk;
	allOk = compare_uvec4((var[2][0]), uvec4(7u, 3u, 1u, 5u)) && allOk;
	allOk = compare_uvec4((var[2][1]), uvec4(8u, 7u, 6u, 2u)) && allOk;
	allOk = compare_uvec4((var[2][2]), uvec4(5u, 9u, 5u, 9u)) && allOk;
	allOk = compare_uvec4((var[3][0]), uvec4(1u, 6u, 2u, 1u)) && allOk;
	allOk = compare_uvec4((var[3][1]), uvec4(7u, 9u, 5u, 3u)) && allOk;
	allOk = compare_uvec4((var[3][2]), uvec4(5u, 7u, 4u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (uvec4(2u, 7u, 2u, 9u));
	var[0][1] = (uvec4(7u, 9u, 5u, 1u));
	var[0][2] = (uvec4(3u, 4u, 4u, 2u));
	var[1][0] = (uvec4(0u, 5u, 6u, 2u));
	var[1][1] = (uvec4(9u, 5u, 7u, 7u));
	var[1][2] = (uvec4(0u, 3u, 8u, 1u));
	var[2][0] = (uvec4(4u, 9u, 1u, 3u));
	var[2][1] = (uvec4(8u, 8u, 8u, 1u));
	var[2][2] = (uvec4(7u, 5u, 4u, 8u));
	var[3][0] = (uvec4(6u, 6u, 0u, 9u));
	var[3][1] = (uvec4(7u, 2u, 3u, 0u));
	var[3][2] = (uvec4(4u, 4u, 8u, 5u));
}
#version 450
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
	allOk = compare_mat3(var[0][0], mat3(-2.0, 7.0, 9.0, 1.0, -5.0, -1.0, 3.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(var[0][1], mat3(-8.0, -8.0, 2.0, 7.0, -6.0, -4.0, 7.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3(var[0][2], mat3(-2.0, 2.0, -3.0, -3.0, 1.0, -3.0, -8.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(var[1][0], mat3(3.0, -6.0, -6.0, 5.0, 5.0, -8.0, -1.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3(var[1][1], mat3(-6.0, 3.0, -5.0, 0.0, 5.0, 8.0, -9.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3(var[1][2], mat3(-1.0, 4.0, -4.0, 9.0, 2.0, 5.0, 5.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat3(var[2][0], mat3(1.0, -6.0, -4.0, 8.0, -1.0, -9.0, -1.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat3(var[2][1], mat3(3.0, 8.0, -3.0, -7.0, 6.0, -6.0, 9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3(var[2][2], mat3(-9.0, -1.0, -4.0, -4.0, -4.0, 9.0, 6.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3(var[3][0], mat3(4.0, -5.0, 6.0, 7.0, -8.0, 2.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3(var[3][1], mat3(9.0, 7.0, 4.0, 2.0, 8.0, 1.0, -9.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3(var[3][2], mat3(0.0, -6.0, 9.0, 7.0, 3.0, 2.0, -6.0, 6.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat3(-2.0, -7.0, 1.0, 7.0, 5.0, 2.0, 9.0, -1.0, -9.0));
	var[0][1] = (mat3(6.0, -5.0, 8.0, -1.0, -8.0, -8.0, 0.0, 9.0, 1.0));
	var[0][2] = (mat3(1.0, -4.0, 5.0, -6.0, -1.0, 9.0, -6.0, 0.0, 5.0));
	var[1][0] = (mat3(-4.0, 3.0, -8.0, -9.0, 9.0, -7.0, -1.0, -9.0, -9.0));
	var[1][1] = (mat3(-2.0, 7.0, -3.0, 2.0, -6.0, -7.0, 4.0, 8.0, -8.0));
	var[1][2] = (mat3(6.0, 1.0, 9.0, 7.0, -9.0, 5.0, -9.0, 9.0, 1.0));
	var[2][0] = (mat3(8.0, 7.0, -7.0, -4.0, 7.0, -5.0, 8.0, 3.0, -4.0));
	var[2][1] = (mat3(-5.0, 6.0, -1.0, 6.0, -8.0, 1.0, 7.0, 5.0, 7.0));
	var[2][2] = (mat3(1.0, 7.0, -1.0, -8.0, 9.0, -2.0, 7.0, 9.0, -5.0));
	var[3][0] = (mat3(8.0, 7.0, 6.0, -6.0, -1.0, -2.0, 9.0, 6.0, 0.0));
	var[3][1] = (mat3(-4.0, -3.0, -6.0, -5.0, -8.0, -6.0, 5.0, -5.0, 2.0));
	var[3][2] = (mat3(7.0, 5.0, -4.0, 7.0, 9.0, -8.0, -9.0, 8.0, -9.0));
}
#version 450
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
	highp mat3x4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0][0], mat3x4(-3.0, 3.0, -8.0, 8.0, 6.0, -9.0, -3.0, -1.0, 6.0, 3.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[0][1], mat3x4(2.0, -8.0, 1.0, 2.0, -6.0, 8.0, -8.0, -3.0, 2.0, 5.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[0][2], mat3x4(-6.0, -3.0, 5.0, 7.0, 3.0, -1.0, -9.0, -1.0, 5.0, 0.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1][0], mat3x4(8.0, -1.0, -7.0, 5.0, -9.0, 3.0, -2.0, -3.0, 3.0, -3.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[1][1], mat3x4(-3.0, -9.0, -1.0, -5.0, -4.0, -4.0, -6.0, 0.0, -3.0, -5.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[1][2], mat3x4(-2.0, -4.0, 8.0, 3.0, -8.0, -8.0, 6.0, -5.0, -9.0, -1.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[2][0], mat3x4(-9.0, -4.0, -3.0, -7.0, 2.0, -1.0, 8.0, -1.0, 3.0, -7.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[2][1], mat3x4(-1.0, 9.0, 2.0, 4.0, 6.0, -7.0, -6.0, 4.0, -4.0, 5.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[2][2], mat3x4(-2.0, 2.0, 0.0, 4.0, 8.0, 7.0, -4.0, -1.0, -4.0, -9.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[3][0], mat3x4(0.0, 2.0, -8.0, 5.0, -6.0, 3.0, 1.0, -5.0, -3.0, -6.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[3][1], mat3x4(4.0, 1.0, 9.0, 2.0, -4.0, -7.0, 1.0, 3.0, 1.0, -2.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[3][2], mat3x4(8.0, -5.0, -5.0, 4.0, 9.0, 5.0, -5.0, -3.0, 9.0, 0.0, -4.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat3x4(-8.0, -6.0, 4.0, -9.0, 7.0, -4.0, -7.0, 0.0, -6.0, -6.0, -3.0, 4.0));
	var[0][1] = (mat3x4(3.0, -2.0, -3.0, 4.0, 2.0, 8.0, 2.0, -4.0, 9.0, -1.0, 9.0, 7.0));
	var[0][2] = (mat3x4(1.0, -1.0, 1.0, 5.0, 5.0, -4.0, -7.0, -4.0, 0.0, 6.0, 2.0, 0.0));
	var[1][0] = (mat3x4(-6.0, 7.0, -1.0, 6.0, 4.0, -9.0, -9.0, -1.0, -8.0, 4.0, -6.0, 6.0));
	var[1][1] = (mat3x4(7.0, -8.0, -5.0, -9.0, -9.0, -2.0, 4.0, 1.0, -3.0, 3.0, -2.0, 2.0));
	var[1][2] = (mat3x4(-1.0, 2.0, -4.0, -7.0, 9.0, 2.0, -7.0, -8.0, -2.0, -3.0, 3.0, -4.0));
	var[2][0] = (mat3x4(6.0, 6.0, -8.0, 6.0, 2.0, 8.0, -6.0, 2.0, -8.0, 2.0, 6.0, 9.0));
	var[2][1] = (mat3x4(3.0, -3.0, 9.0, -1.0, 6.0, 2.0, -8.0, 0.0, 1.0, 1.0, -3.0, 0.0));
	var[2][2] = (mat3x4(9.0, 4.0, -6.0, 6.0, 2.0, 1.0, 9.0, -3.0, -3.0, -6.0, -6.0, -8.0));
	var[3][0] = (mat3x4(5.0, 0.0, -6.0, 3.0, 0.0, -8.0, 3.0, 9.0, -6.0, -2.0, 5.0, -8.0));
	var[3][1] = (mat3x4(0.0, -3.0, -8.0, 2.0, 8.0, 8.0, -1.0, 4.0, -6.0, 8.0, 9.0, 8.0));
	var[3][2] = (mat3x4(5.0, 7.0, 3.0, 7.0, 9.0, 9.0, 6.0, 5.0, 3.0, 5.0, 2.0, -8.0));
}
#version 450
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
	highp mat3x4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0][0], mat3x4(6.0, 7.0, 2.0, -5.0, -4.0, 6.0, 5.0, 2.0, 9.0, -7.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[0][1], mat3x4(5.0, -9.0, 0.0, -9.0, -4.0, 7.0, -1.0, -8.0, -5.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[0][2], mat3x4(-1.0, -5.0, -7.0, -9.0, 6.0, -8.0, -6.0, -8.0, 5.0, 1.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[1][0], mat3x4(-5.0, 7.0, -8.0, 7.0, -8.0, 4.0, 8.0, 0.0, 9.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[1][1], mat3x4(-9.0, 6.0, -3.0, 4.0, -1.0, 1.0, 6.0, 2.0, 4.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[1][2], mat3x4(-9.0, 7.0, -1.0, 8.0, -6.0, 4.0, -2.0, 6.0, 9.0, -4.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[2][0], mat3x4(-8.0, 1.0, -8.0, -8.0, 5.0, -8.0, 1.0, 0.0, -6.0, 3.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[2][1], mat3x4(-9.0, 9.0, -5.0, 3.0, 0.0, 0.0, -5.0, -9.0, -9.0, 7.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[2][2], mat3x4(-5.0, -8.0, -1.0, -1.0, -2.0, 1.0, 5.0, 7.0, 6.0, 6.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[3][0], mat3x4(8.0, 4.0, 7.0, 2.0, -3.0, -4.0, 8.0, 3.0, 2.0, -5.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[3][1], mat3x4(7.0, -3.0, -3.0, 1.0, 8.0, 3.0, 5.0, 6.0, 8.0, 1.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[3][2], mat3x4(9.0, 2.0, 5.0, 7.0, -4.0, 2.0, 1.0, 6.0, -3.0, -8.0, 6.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec4(-3.0, -5.0, 2.0, 5.0));
	var[0][0][1] = (vec4(-2.0, -3.0, 9.0, -2.0));
	var[0][0][2] = (vec4(-6.0, 7.0, 4.0, -6.0));
	var[0][1][0] = (vec4(2.0, 6.0, 9.0, -2.0));
	var[0][1][1] = (vec4(7.0, 9.0, 0.0, 0.0));
	var[0][1][2] = (vec4(8.0, -3.0, 0.0, 3.0));
	var[0][2][0] = (vec4(-6.0, 1.0, 9.0, 6.0));
	var[0][2][1] = (vec4(-9.0, -9.0, 2.0, -4.0));
	var[0][2][2] = (vec4(-8.0, 5.0, -1.0, 9.0));
	var[1][0][0] = (vec4(8.0, -2.0, 1.0, 1.0));
	var[1][0][1] = (vec4(-6.0, -1.0, -9.0, 6.0));
	var[1][0][2] = (vec4(7.0, -1.0, 1.0, -8.0));
	var[1][1][0] = (vec4(6.0, 8.0, -2.0, 7.0));
	var[1][1][1] = (vec4(1.0, -6.0, -3.0, 9.0));
	var[1][1][2] = (vec4(1.0, -6.0, 1.0, -6.0));
	var[1][2][0] = (vec4(3.0, -1.0, 5.0, -2.0));
	var[1][2][1] = (vec4(7.0, -1.0, -2.0, -3.0));
	var[1][2][2] = (vec4(-6.0, 4.0, -4.0, -1.0));
	var[2][0][0] = (vec4(-3.0, -3.0, 3.0, -7.0));
	var[2][0][1] = (vec4(2.0, 8.0, -4.0, 1.0));
	var[2][0][2] = (vec4(-1.0, 6.0, -4.0, 7.0));
	var[2][1][0] = (vec4(5.0, -8.0, -2.0, 6.0));
	var[2][1][1] = (vec4(-2.0, 8.0, -2.0, 2.0));
	var[2][1][2] = (vec4(3.0, 7.0, 0.0, 2.0));
	var[2][2][0] = (vec4(3.0, 9.0, 8.0, 5.0));
	var[2][2][1] = (vec4(2.0, -3.0, -7.0, 2.0));
	var[2][2][2] = (vec4(-1.0, 1.0, -4.0, -1.0));
	var[3][0][0] = (vec4(-6.0, -4.0, -1.0, -3.0));
	var[3][0][1] = (vec4(-8.0, 5.0, -4.0, -9.0));
	var[3][0][2] = (vec4(8.0, 3.0, -8.0, 0.0));
	var[3][1][0] = (vec4(7.0, -2.0, 0.0, 8.0));
	var[3][1][1] = (vec4(-9.0, 2.0, -3.0, -7.0));
	var[3][1][2] = (vec4(-5.0, 3.0, 9.0, -6.0));
	var[3][2][0] = (vec4(-7.0, -8.0, -8.0, -7.0));
	var[3][2][1] = (vec4(-9.0, 2.0, 4.0, -7.0));
	var[3][2][2] = (vec4(8.0, -7.0, 4.0, -8.0));
}
#version 450
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
	highp mat2x3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat2x3(var[0][0], mat2x3(3.0, -3.0, 8.0, 7.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[0][1], mat2x3(-6.0, -3.0, -8.0, 6.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[0][2], mat2x3(-5.0, 8.0, -3.0, 0.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[1][0], mat2x3(-1.0, -8.0, 3.0, 6.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[1][1], mat2x3(7.0, 2.0, -2.0, 6.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[1][2], mat2x3(3.0, 1.0, 1.0, 2.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[2][0], mat2x3(0.0, 2.0, -8.0, 5.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[2][1], mat2x3(0.0, -6.0, -3.0, 2.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[2][2], mat2x3(2.0, 8.0, 8.0, -3.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[3][0], mat2x3(-5.0, 7.0, 3.0, -7.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[3][1], mat2x3(4.0, -6.0, -4.0, 0.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[3][2], mat2x3(2.0, 6.0, 0.0, -5.0, -9.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (0.0);
	var[0][0] = (mat2x3(4.0, 4.0, 5.0, -5.0, 2.0, 8.0));
	var[0][1] = (mat2x3(-1.0, -2.0, -7.0, -8.0, -2.0, 2.0));
	var[0][2] = (mat2x3(-2.0, 7.0, -9.0, 7.0, -7.0, -5.0));
	var[1][0] = (mat2x3(6.0, 8.0, -8.0, 0.0, 2.0, 7.0));
	var[1][1] = (mat2x3(-9.0, -2.0, -9.0, -1.0, -1.0, -4.0));
	var[1][2] = (mat2x3(-3.0, 7.0, 9.0, 0.0, -4.0, 9.0));
	var[2][0] = (mat2x3(0.0, 7.0, 7.0, 9.0, -8.0, 5.0));
	var[2][1] = (mat2x3(5.0, 1.0, 6.0, 3.0, -6.0, 8.0));
	var[2][2] = (mat2x3(9.0, 6.0, 7.0, 0.0, -6.0, -7.0));
	var[3][0] = (mat2x3(6.0, 4.0, 8.0, 5.0, -1.0, 4.0));
	var[3][1] = (mat2x3(4.0, 9.0, 9.0, -8.0, 6.0, 6.0));
	var[3][2] = (mat2x3(3.0, 8.0, 3.0, 4.0, 4.0, 3.0));
}
#version 450
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
	highp mat2x3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 5.0) && allOk;
	allOk = compare_mat2x3(var[0][0], mat2x3(-6.0, 5.0, -5.0, 8.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[0][1], mat2x3(3.0, 9.0, -4.0, 0.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[0][2], mat2x3(5.0, 5.0, -9.0, 2.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat2x3(var[1][0], mat2x3(4.0, 4.0, -4.0, -1.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[1][1], mat2x3(-7.0, -1.0, 6.0, 8.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[1][2], mat2x3(-8.0, 9.0, 5.0, 9.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[2][0], mat2x3(-2.0, 6.0, 6.0, 9.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[2][1], mat2x3(3.0, 0.0, 3.0, -6.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat2x3(var[2][2], mat2x3(-8.0, 9.0, -3.0, -9.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[3][0], mat2x3(-8.0, 9.0, 2.0, -9.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[3][1], mat2x3(-9.0, -4.0, -1.0, -1.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[3][2], mat2x3(-5.0, 9.0, -8.0, -1.0, 7.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-9.0);
	var[0][0] = (mat2x3(-1.0, 8.0, -5.0, -3.0, 4.0, -4.0));
	var[0][1] = (mat2x3(1.0, -5.0, 6.0, -8.0, -3.0, 0.0));
	var[0][2] = (mat2x3(2.0, -1.0, -7.0, 4.0, 6.0, 6.0));
	var[1][0] = (mat2x3(-3.0, 0.0, 5.0, 9.0, 2.0, -9.0));
	var[1][1] = (mat2x3(9.0, -7.0, 2.0, 6.0, -3.0, 8.0));
	var[1][2] = (mat2x3(-9.0, 7.0, -1.0, -3.0, 7.0, -4.0));
	var[2][0] = (mat2x3(-1.0, -5.0, 7.0, -3.0, -6.0, 1.0));
	var[2][1] = (mat2x3(3.0, 3.0, 1.0, 9.0, -7.0, -4.0));
	var[2][2] = (mat2x3(-1.0, -4.0, 1.0, -9.0, 4.0, -7.0));
	var[3][0] = (mat2x3(-6.0, -1.0, -1.0, 0.0, -4.0, 5.0));
	var[3][1] = (mat2x3(-6.0, -9.0, -6.0, -5.0, 0.0, -2.0));
	var[3][2] = (mat2x3(-6.0, 3.0, -3.0, -1.0, -6.0, -1.0));
}
#version 450
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
	highp mat3x2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -1.0) && allOk;
	allOk = compare_mat3x2(var[0][0], mat3x2(4.0, -9.0, -1.0, -8.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[0][1], mat3x2(6.0, 3.0, 1.0, 8.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[0][2], mat3x2(-3.0, 3.0, -3.0, -4.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[1][0], mat3x2(1.0, -3.0, -8.0, -2.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[1][1], mat3x2(8.0, 7.0, 7.0, -8.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3x2(var[1][2], mat3x2(-7.0, 1.0, -1.0, 4.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[2][0], mat3x2(-8.0, -7.0, 7.0, 2.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[2][1], mat3x2(9.0, -2.0, 2.0, 1.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[2][2], mat3x2(9.0, 6.0, 2.0, 9.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[3][0], mat3x2(1.0, 1.0, 8.0, 4.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[3][1], mat3x2(7.0, -2.0, -4.0, 1.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[3][2], mat3x2(-1.0, -7.0, 9.0, 5.0, 3.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-2.0);
	var[0][0] = (mat3x2(-2.0, -8.0, 0.0, -9.0, 9.0, 0.0));
	var[0][1] = (mat3x2(1.0, -3.0, -6.0, -5.0, -7.0, 5.0));
	var[0][2] = (mat3x2(-4.0, 8.0, -1.0, -8.0, 1.0, 2.0));
	var[1][0] = (mat3x2(1.0, -5.0, 0.0, -3.0, 1.0, -4.0));
	var[1][1] = (mat3x2(4.0, 5.0, -5.0, -6.0, 3.0, 1.0));
	var[1][2] = (mat3x2(-2.0, 3.0, -8.0, -6.0, 2.0, -5.0));
	var[2][0] = (mat3x2(-4.0, -8.0, 9.0, -9.0, -8.0, 8.0));
	var[2][1] = (mat3x2(-4.0, 1.0, -1.0, 7.0, 0.0, 1.0));
	var[2][2] = (mat3x2(-3.0, 6.0, -4.0, -6.0, -5.0, -6.0));
	var[3][0] = (mat3x2(-4.0, 6.0, 4.0, 2.0, -8.0, 2.0));
	var[3][1] = (mat3x2(1.0, -3.0, -3.0, -5.0, -1.0, 6.0));
	var[3][2] = (mat3x2(9.0, 9.0, 9.0, -4.0, 8.0, -7.0));
}
#version 450
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
	allOk = compare_float((padding), 5.0) && allOk;
	allOk = compare_mat3x4(var[0][0], mat3x4(5.0, 3.0, -7.0, -3.0, 7.0, -8.0, -8.0, -3.0, -7.0, -9.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[0][1], mat3x4(-9.0, -5.0, 2.0, 6.0, -3.0, -5.0, -9.0, -4.0, 7.0, -4.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[0][2], mat3x4(-3.0, -2.0, 2.0, 7.0, 5.0, -1.0, 2.0, -6.0, 1.0, 3.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[1][0], mat3x4(-6.0, 4.0, 0.0, -9.0, 0.0, -1.0, 2.0, -4.0, 1.0, -8.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[1][1], mat3x4(-4.0, 2.0, 4.0, 3.0, -4.0, 9.0, 2.0, -2.0, 6.0, 3.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat3x4(var[1][2], mat3x4(-5.0, 7.0, -4.0, -5.0, 8.0, -9.0, -1.0, -7.0, 6.0, 5.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[2][0], mat3x4(-4.0, -4.0, 2.0, 8.0, 5.0, -5.0, 8.0, 8.0, 3.0, 2.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[2][1], mat3x4(9.0, -7.0, 8.0, 8.0, 1.0, 9.0, -8.0, -2.0, 3.0, -2.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[2][2], mat3x4(7.0, -2.0, -9.0, 6.0, -4.0, 0.0, 9.0, 0.0, -2.0, 4.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[3][0], mat3x4(2.0, -7.0, 4.0, -9.0, -7.0, 0.0, -7.0, 4.0, -8.0, 1.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[3][1], mat3x4(2.0, 0.0, -5.0, -4.0, 7.0, 3.0, 3.0, -9.0, 4.0, 3.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[3][2], mat3x4(-7.0, 7.0, -8.0, 9.0, -2.0, 5.0, 8.0, 5.0, 0.0, -3.0, 3.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (0.0);
	var[0][0] = (mat3x4(5.0, -1.0, 3.0, -5.0, -9.0, -7.0, 8.0, -9.0, 2.0, -8.0, -3.0, 0.0));
	var[0][1] = (mat3x4(-1.0, 4.0, 7.0, 4.0, -4.0, -6.0, 0.0, -5.0, -5.0, 1.0, -9.0, -7.0));
	var[0][2] = (mat3x4(-7.0, 7.0, 1.0, -4.0, 7.0, -8.0, -2.0, -9.0, 5.0, -9.0, -3.0, 0.0));
	var[1][0] = (mat3x4(0.0, 5.0, -2.0, -1.0, 5.0, 8.0, -3.0, 1.0, -2.0, -8.0, -5.0, -1.0));
	var[1][1] = (mat3x4(2.0, -7.0, 8.0, -3.0, -8.0, -2.0, -5.0, -6.0, 7.0, 7.0, 7.0, 5.0));
	var[1][2] = (mat3x4(7.0, 0.0, 9.0, 7.0, -3.0, -7.0, -6.0, -5.0, 8.0, 9.0, 8.0, -7.0));
	var[2][0] = (mat3x4(-8.0, 3.0, 9.0, 9.0, 5.0, -8.0, -1.0, 2.0, -8.0, -2.0, 9.0, 1.0));
	var[2][1] = (mat3x4(-4.0, -7.0, -5.0, -9.0, -1.0, 6.0, 2.0, 4.0, 5.0, 7.0, 5.0, -1.0));
	var[2][2] = (mat3x4(-6.0, -4.0, 4.0, -7.0, -1.0, 8.0, -9.0, 2.0, 2.0, 3.0, -5.0, -2.0));
	var[3][0] = (mat3x4(-5.0, 6.0, -8.0, 3.0, -8.0, 6.0, 6.0, -8.0, 9.0, -8.0, 3.0, -3.0));
	var[3][1] = (mat3x4(-1.0, 0.0, -7.0, 5.0, 3.0, 2.0, 9.0, -2.0, 2.0, 8.0, 3.0, -7.0));
	var[3][2] = (mat3x4(-7.0, -8.0, -4.0, 1.0, 0.0, 0.0, 1.0, 9.0, -5.0, -3.0, 6.0, -3.0));
}
#version 450
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
	allOk = compare_float((padding), 8.0) && allOk;
	allOk = compare_mat4x2(var[0][0], mat4x2(9.0, -6.0, -8.0, -7.0, 2.0, 3.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[0][1], mat4x2(-4.0, 1.0, 5.0, 2.0, -6.0, 5.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[0][2], mat4x2(8.0, 9.0, 2.0, -7.0, -8.0, 9.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[1][0], mat4x2(6.0, 4.0, 1.0, -8.0, -6.0, -5.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[1][1], mat4x2(-2.0, -3.0, 3.0, 9.0, -4.0, 6.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[1][2], mat4x2(6.0, -6.0, -5.0, -5.0, -2.0, -1.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[2][0], mat4x2(-8.0, 7.0, 2.0, -1.0, -4.0, 9.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[2][1], mat4x2(1.0, -3.0, -2.0, 3.0, 7.0, 1.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[2][2], mat4x2(4.0, 7.0, -8.0, 0.0, 4.0, 0.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[3][0], mat4x2(2.0, -4.0, -2.0, 1.0, -7.0, 6.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[3][1], mat4x2(1.0, 6.0, -5.0, -9.0, -6.0, 4.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[3][2], mat4x2(-2.0, 7.0, 8.0, -1.0, -1.0, -3.0, 8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (4.0);
	var[0][0][0] = (vec2(-2.0, 8.0));
	var[0][0][1] = (vec2(-4.0, 4.0));
	var[0][0][2] = (vec2(9.0, 5.0));
	var[0][0][3] = (vec2(-9.0, -2.0));
	var[0][1][0] = (vec2(6.0, -8.0));
	var[0][1][1] = (vec2(-5.0, -1.0));
	var[0][1][2] = (vec2(9.0, 0.0));
	var[0][1][3] = (vec2(4.0, 5.0));
	var[0][2][0] = (vec2(4.0, -5.0));
	var[0][2][1] = (vec2(-2.0, -4.0));
	var[0][2][2] = (vec2(6.0, 4.0));
	var[0][2][3] = (vec2(-2.0, 5.0));
	var[1][0][0] = (vec2(-6.0, -5.0));
	var[1][0][1] = (vec2(7.0, -6.0));
	var[1][0][2] = (vec2(8.0, 5.0));
	var[1][0][3] = (vec2(5.0, 5.0));
	var[1][1][0] = (vec2(-6.0, -3.0));
	var[1][1][1] = (vec2(-1.0, -1.0));
	var[1][1][2] = (vec2(-2.0, 6.0));
	var[1][1][3] = (vec2(-5.0, -1.0));
	var[1][2][0] = (vec2(-5.0, 5.0));
	var[1][2][1] = (vec2(5.0, 9.0));
	var[1][2][2] = (vec2(-7.0, 0.0));
	var[1][2][3] = (vec2(-8.0, 6.0));
	var[2][0][0] = (vec2(5.0, 2.0));
	var[2][0][1] = (vec2(6.0, -4.0));
	var[2][0][2] = (vec2(-4.0, 8.0));
	var[2][0][3] = (vec2(4.0, 5.0));
	var[2][1][0] = (vec2(7.0, 0.0));
	var[2][1][1] = (vec2(-7.0, -4.0));
	var[2][1][2] = (vec2(1.0, -1.0));
	var[2][1][3] = (vec2(-1.0, 7.0));
	var[2][2][0] = (vec2(9.0, -9.0));
	var[2][2][1] = (vec2(7.0, -8.0));
	var[2][2][2] = (vec2(5.0, -4.0));
	var[2][2][3] = (vec2(-6.0, 4.0));
	var[3][0][0] = (vec2(9.0, 1.0));
	var[3][0][1] = (vec2(-6.0, -3.0));
	var[3][0][2] = (vec2(-7.0, 9.0));
	var[3][0][3] = (vec2(3.0, 3.0));
	var[3][1][0] = (vec2(3.0, -7.0));
	var[3][1][1] = (vec2(0.0, 6.0));
	var[3][1][2] = (vec2(-8.0, -2.0));
	var[3][1][3] = (vec2(5.0, 7.0));
	var[3][2][0] = (vec2(2.0, -2.0));
	var[3][2][1] = (vec2(8.0, 8.0));
	var[3][2][2] = (vec2(1.0, -3.0));
	var[3][2][3] = (vec2(-6.0, -8.0));
}
#version 450
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
	highp vec4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((var[0][0][0]), vec4(-5.0, 4.0, -4.0, 6.0)) && allOk;
	allOk = compare_vec4((var[0][0][1]), vec4(1.0, 4.0, 8.0, 7.0)) && allOk;
	allOk = compare_vec4((var[0][0][2]), vec4(2.0, -4.0, 3.0, -8.0)) && allOk;
	allOk = compare_vec4((var[0][1][0]), vec4(-1.0, 3.0, 2.0, -5.0)) && allOk;
	allOk = compare_vec4((var[0][1][1]), vec4(9.0, 1.0, -6.0, 3.0)) && allOk;
	allOk = compare_vec4((var[0][1][2]), vec4(0.0, 6.0, 1.0, -9.0)) && allOk;
	allOk = compare_vec4((var[1][0][0]), vec4(-3.0, -3.0, -6.0, -4.0)) && allOk;
	allOk = compare_vec4((var[1][0][1]), vec4(-1.0, 0.0, -8.0, -8.0)) && allOk;
	allOk = compare_vec4((var[1][0][2]), vec4(7.0, 1.0, 8.0, -8.0)) && allOk;
	allOk = compare_vec4((var[1][1][0]), vec4(6.0, -7.0, 0.0, 0.0)) && allOk;
	allOk = compare_vec4((var[1][1][1]), vec4(8.0, -6.0, 5.0, -4.0)) && allOk;
	allOk = compare_vec4((var[1][1][2]), vec4(5.0, -5.0, -2.0, -4.0)) && allOk;
	allOk = compare_vec4((var[2][0][0]), vec4(6.0, 9.0, -5.0, -1.0)) && allOk;
	allOk = compare_vec4((var[2][0][1]), vec4(8.0, -5.0, -7.0, 0.0)) && allOk;
	allOk = compare_vec4((var[2][0][2]), vec4(-7.0, 2.0, -6.0, 6.0)) && allOk;
	allOk = compare_vec4((var[2][1][0]), vec4(6.0, -4.0, -2.0, -7.0)) && allOk;
	allOk = compare_vec4((var[2][1][1]), vec4(-2.0, 7.0, -3.0, -4.0)) && allOk;
	allOk = compare_vec4((var[2][1][2]), vec4(-2.0, -5.0, 1.0, 8.0)) && allOk;
	allOk = compare_vec4((var[3][0][0]), vec4(-1.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_vec4((var[3][0][1]), vec4(8.0, 1.0, 8.0, 2.0)) && allOk;
	allOk = compare_vec4((var[3][0][2]), vec4(3.0, -4.0, 2.0, 1.0)) && allOk;
	allOk = compare_vec4((var[3][1][0]), vec4(3.0, -9.0, 9.0, 9.0)) && allOk;
	allOk = compare_vec4((var[3][1][1]), vec4(5.0, -9.0, -7.0, -7.0)) && allOk;
	allOk = compare_vec4((var[3][1][2]), vec4(-6.0, -9.0, 4.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec4(-5.0, 8.0, 3.0, -4.0));
	var[0][0][1] = (vec4(-6.0, -1.0, -3.0, 6.0));
	var[0][0][2] = (vec4(5.0, -9.0, 4.0, -1.0));
	var[0][1][0] = (vec4(1.0, 7.0, 1.0, 1.0));
	var[0][1][1] = (vec4(-7.0, -6.0, -7.0, -4.0));
	var[0][1][2] = (vec4(8.0, -1.0, -6.0, -8.0));
	var[1][0][0] = (vec4(-7.0, -6.0, -2.0, -8.0));
	var[1][0][1] = (vec4(8.0, 7.0, 5.0, 1.0));
	var[1][0][2] = (vec4(-6.0, -5.0, -8.0, 8.0));
	var[1][1][0] = (vec4(9.0, 7.0, -3.0, -8.0));
	var[1][1][1] = (vec4(-3.0, -9.0, 2.0, 1.0));
	var[1][1][2] = (vec4(-7.0, 3.0, -5.0, 8.0));
	var[2][0][0] = (vec4(0.0, 8.0, 4.0, -4.0));
	var[2][0][1] = (vec4(-8.0, -3.0, 9.0, -7.0));
	var[2][0][2] = (vec4(-9.0, 2.0, -6.0, 6.0));
	var[2][1][0] = (vec4(5.0, -4.0, -5.0, 6.0));
	var[2][1][1] = (vec4(0.0, -2.0, -8.0, 7.0));
	var[2][1][2] = (vec4(0.0, -7.0, -2.0, -7.0));
	var[3][0][0] = (vec4(6.0, 2.0, -3.0, 0.0));
	var[3][0][1] = (vec4(-9.0, 8.0, -8.0, 0.0));
	var[3][0][2] = (vec4(2.0, 6.0, 6.0, 1.0));
	var[3][1][0] = (vec4(3.0, -8.0, 1.0, 6.0));
	var[3][1][1] = (vec4(0.0, 5.0, -3.0, -2.0));
	var[3][1][2] = (vec4(-9.0, -7.0, 2.0, -7.0));
}
#version 450
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
	highp mat2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0][0][0], mat2(8.0, -8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(0.0, -4.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat2(var[0][0][2], mat2(-7.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(-2.0, -4.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(4.0, -3.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2(var[0][1][2], mat2(-5.0, -3.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(0.0, 6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(-4.0, -1.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2(var[1][0][2], mat2(-1.0, 4.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(8.0, -9.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(1.0, 1.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat2(var[1][1][2], mat2(-6.0, 1.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(-7.0, 8.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(-9.0, -8.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2(var[2][0][2], mat2(-4.0, -9.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(7.0, -2.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(-8.0, -5.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2(var[2][1][2], mat2(-3.0, -9.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat2(var[3][0][0], mat2(1.0, -9.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat2(var[3][0][1], mat2(-9.0, -7.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2(var[3][0][2], mat2(-9.0, 2.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2(var[3][1][0], mat2(6.0, -1.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2(var[3][1][1], mat2(9.0, -7.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat2(var[3][1][2], mat2(-7.0, 1.0, -3.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec2(-3.0, 3.0));
	var[0][0][0][1] = (vec2(4.0, 4.0));
	var[0][0][1][0] = (vec2(9.0, -9.0));
	var[0][0][1][1] = (vec2(-5.0, 8.0));
	var[0][0][2][0] = (vec2(0.0, 4.0));
	var[0][0][2][1] = (vec2(2.0, -4.0));
	var[0][1][0][0] = (vec2(-3.0, -8.0));
	var[0][1][0][1] = (vec2(-4.0, -7.0));
	var[0][1][1][0] = (vec2(-9.0, 5.0));
	var[0][1][1][1] = (vec2(5.0, -6.0));
	var[0][1][2][0] = (vec2(4.0, -1.0));
	var[0][1][2][1] = (vec2(-3.0, -8.0));
	var[1][0][0][0] = (vec2(-3.0, 3.0));
	var[1][0][0][1] = (vec2(-8.0, -7.0));
	var[1][0][1][0] = (vec2(-7.0, -6.0));
	var[1][0][1][1] = (vec2(-2.0, 1.0));
	var[1][0][2][0] = (vec2(-4.0, 3.0));
	var[1][0][2][1] = (vec2(0.0, 7.0));
	var[1][1][0][0] = (vec2(1.0, -2.0));
	var[1][1][0][1] = (vec2(-6.0, -3.0));
	var[1][1][1][0] = (vec2(-5.0, 4.0));
	var[1][1][1][1] = (vec2(-7.0, -6.0));
	var[1][1][2][0] = (vec2(1.0, -9.0));
	var[1][1][2][1] = (vec2(7.0, -1.0));
	var[2][0][0][0] = (vec2(-7.0, -5.0));
	var[2][0][0][1] = (vec2(6.0, -6.0));
	var[2][0][1][0] = (vec2(-4.0, 0.0));
	var[2][0][1][1] = (vec2(2.0, 3.0));
	var[2][0][2][0] = (vec2(-2.0, -4.0));
	var[2][0][2][1] = (vec2(-1.0, 1.0));
	var[2][1][0][0] = (vec2(-6.0, -1.0));
	var[2][1][0][1] = (vec2(9.0, -5.0));
	var[2][1][1][0] = (vec2(-2.0, -2.0));
	var[2][1][1][1] = (vec2(9.0, -8.0));
	var[2][1][2][0] = (vec2(2.0, 6.0));
	var[2][1][2][1] = (vec2(-1.0, 7.0));
	var[3][0][0][0] = (vec2(8.0, -9.0));
	var[3][0][0][1] = (vec2(8.0, -6.0));
	var[3][0][1][0] = (vec2(7.0, -2.0));
	var[3][0][1][1] = (vec2(1.0, -2.0));
	var[3][0][2][0] = (vec2(-7.0, -6.0));
	var[3][0][2][1] = (vec2(8.0, -4.0));
	var[3][1][0][0] = (vec2(4.0, -9.0));
	var[3][1][0][1] = (vec2(-8.0, -4.0));
	var[3][1][1][0] = (vec2(6.0, 9.0));
	var[3][1][1][1] = (vec2(-3.0, -1.0));
	var[3][1][2][0] = (vec2(-1.0, 5.0));
	var[3][1][2][1] = (vec2(-8.0, 1.0));
}
#version 450
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
	u8vec2 var[4][2][3];
};

bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(var[0][0][0]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[0][0][1]), uvec2(7u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[0][0][2]), uvec2(4u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[0][1][0]), uvec2(8u, 5u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[0][1][1]), uvec2(6u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[0][1][2]), uvec2(2u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1][0][0]), uvec2(7u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1][0][1]), uvec2(9u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1][0][2]), uvec2(7u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1][1][0]), uvec2(0u, 6u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1][1][1]), uvec2(2u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1][1][2]), uvec2(1u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2][0][0]), uvec2(8u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2][0][1]), uvec2(6u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2][0][2]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2][1][0]), uvec2(6u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2][1][1]), uvec2(5u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2][1][2]), uvec2(2u, 1u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[3][0][0]), uvec2(1u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[3][0][1]), uvec2(2u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[3][0][2]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[3][1][0]), uvec2(8u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[3][1][1]), uvec2(7u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[3][1][2]), uvec2(3u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = u8vec2(uvec2(7u, 7u));
	var[0][0][1] = u8vec2(uvec2(9u, 6u));
	var[0][0][2] = u8vec2(uvec2(0u, 2u));
	var[0][1][0] = u8vec2(uvec2(1u, 8u));
	var[0][1][1] = u8vec2(uvec2(4u, 0u));
	var[0][1][2] = u8vec2(uvec2(2u, 7u));
	var[1][0][0] = u8vec2(uvec2(1u, 1u));
	var[1][0][1] = u8vec2(uvec2(0u, 8u));
	var[1][0][2] = u8vec2(uvec2(8u, 5u));
	var[1][1][0] = u8vec2(uvec2(2u, 0u));
	var[1][1][1] = u8vec2(uvec2(2u, 5u));
	var[1][1][2] = u8vec2(uvec2(3u, 4u));
	var[2][0][0] = u8vec2(uvec2(2u, 7u));
	var[2][0][1] = u8vec2(uvec2(4u, 4u));
	var[2][0][2] = u8vec2(uvec2(7u, 2u));
	var[2][1][0] = u8vec2(uvec2(7u, 4u));
	var[2][1][1] = u8vec2(uvec2(0u, 1u));
	var[2][1][2] = u8vec2(uvec2(2u, 3u));
	var[3][0][0] = u8vec2(uvec2(4u, 5u));
	var[3][0][1] = u8vec2(uvec2(0u, 2u));
	var[3][0][2] = u8vec2(uvec2(1u, 8u));
	var[3][1][0] = u8vec2(uvec2(5u, 4u));
	var[3][1][1] = u8vec2(uvec2(4u, 2u));
	var[3][1][2] = u8vec2(uvec2(1u, 9u));
}
#version 450
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
	highp uint var[4][2][3];
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((var[0][0][0]), 3u) && allOk;
	allOk = compare_uint((var[0][0][1]), 6u) && allOk;
	allOk = compare_uint((var[0][0][2]), 9u) && allOk;
	allOk = compare_uint((var[0][1][0]), 7u) && allOk;
	allOk = compare_uint((var[0][1][1]), 8u) && allOk;
	allOk = compare_uint((var[0][1][2]), 6u) && allOk;
	allOk = compare_uint((var[1][0][0]), 0u) && allOk;
	allOk = compare_uint((var[1][0][1]), 3u) && allOk;
	allOk = compare_uint((var[1][0][2]), 7u) && allOk;
	allOk = compare_uint((var[1][1][0]), 9u) && allOk;
	allOk = compare_uint((var[1][1][1]), 0u) && allOk;
	allOk = compare_uint((var[1][1][2]), 1u) && allOk;
	allOk = compare_uint((var[2][0][0]), 6u) && allOk;
	allOk = compare_uint((var[2][0][1]), 4u) && allOk;
	allOk = compare_uint((var[2][0][2]), 2u) && allOk;
	allOk = compare_uint((var[2][1][0]), 4u) && allOk;
	allOk = compare_uint((var[2][1][1]), 8u) && allOk;
	allOk = compare_uint((var[2][1][2]), 7u) && allOk;
	allOk = compare_uint((var[3][0][0]), 5u) && allOk;
	allOk = compare_uint((var[3][0][1]), 7u) && allOk;
	allOk = compare_uint((var[3][0][2]), 5u) && allOk;
	allOk = compare_uint((var[3][1][0]), 9u) && allOk;
	allOk = compare_uint((var[3][1][1]), 7u) && allOk;
	allOk = compare_uint((var[3][1][2]), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (7u);
	var[0][0][1] = (9u);
	var[0][0][2] = (1u);
	var[0][1][0] = (7u);
	var[0][1][1] = (8u);
	var[0][1][2] = (6u);
	var[1][0][0] = (0u);
	var[1][0][1] = (7u);
	var[1][0][2] = (7u);
	var[1][1][0] = (1u);
	var[1][1][1] = (9u);
	var[1][1][2] = (8u);
	var[2][0][0] = (4u);
	var[2][0][1] = (8u);
	var[2][0][2] = (7u);
	var[2][1][0] = (6u);
	var[2][1][1] = (8u);
	var[2][1][2] = (6u);
	var[3][0][0] = (5u);
	var[3][0][1] = (7u);
	var[3][0][2] = (2u);
	var[3][1][0] = (2u);
	var[3][1][1] = (5u);
	var[3][1][2] = (3u);
}
#version 450
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
	highp mat4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0][0][0], mat4(5.0, 8.0, -8.0, -2.0, 6.0, -4.0, 3.0, -1.0, 6.0, 4.0, -8.0, -3.0, 9.0, 9.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(-6.0, -5.0, 1.0, 2.0, 1.0, 8.0, 6.0, 2.0, -2.0, -9.0, -8.0, -8.0, -3.0, -9.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[0][0][2], mat4(-1.0, -6.0, 8.0, -9.0, -2.0, 9.0, 7.0, 3.0, 4.0, -1.0, -8.0, -8.0, 9.0, -4.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(9.0, -6.0, 0.0, -6.0, -4.0, 0.0, 7.0, 0.0, 7.0, 0.0, 8.0, 2.0, -6.0, -3.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(9.0, -2.0, 1.0, -9.0, -6.0, -1.0, -4.0, 6.0, 8.0, -7.0, 1.0, 3.0, -9.0, 5.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4(var[0][1][2], mat4(-2.0, 4.0, 5.0, 9.0, 0.0, 0.0, 9.0, 3.0, -9.0, -4.0, 5.0, -2.0, 7.0, 9.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(-9.0, -1.0, -9.0, 8.0, 9.0, -9.0, -7.0, -2.0, 3.0, -9.0, -3.0, -9.0, 4.0, -4.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(-2.0, 7.0, -4.0, -4.0, 1.0, 2.0, -1.0, -3.0, 8.0, 1.0, -3.0, -1.0, -4.0, -6.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat4(var[1][0][2], mat4(-9.0, 9.0, 8.0, 7.0, 8.0, -2.0, -2.0, -5.0, -9.0, -8.0, -9.0, -4.0, -9.0, 6.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(9.0, 0.0, -2.0, -7.0, -8.0, 0.0, 3.0, -1.0, -9.0, 1.0, 9.0, -1.0, 5.0, -9.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(4.0, -5.0, -9.0, 5.0, 4.0, 7.0, 0.0, -6.0, -5.0, -9.0, 6.0, 9.0, 4.0, 6.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4(var[1][1][2], mat4(2.0, 5.0, 9.0, -6.0, 4.0, 6.0, -4.0, 1.0, 6.0, 1.0, 3.0, 4.0, 3.0, 8.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(1.0, 8.0, -3.0, -5.0, -4.0, -9.0, -2.0, -6.0, -3.0, -9.0, -9.0, -7.0, 7.0, -9.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(4.0, -6.0, -4.0, 8.0, 0.0, -1.0, 3.0, -5.0, 6.0, -8.0, 9.0, 7.0, 3.0, 0.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4(var[2][0][2], mat4(9.0, -9.0, 9.0, 2.0, -2.0, -2.0, 3.0, -9.0, 4.0, -1.0, -1.0, -7.0, -4.0, 0.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(-2.0, -4.0, 3.0, -3.0, 5.0, 1.0, -7.0, 8.0, 7.0, -9.0, -3.0, 7.0, 9.0, -9.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(4.0, -2.0, 4.0, -4.0, 1.0, 7.0, 6.0, 9.0, 8.0, -8.0, -3.0, -4.0, -7.0, 4.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat4(var[2][1][2], mat4(-3.0, -5.0, 2.0, 3.0, -9.0, -7.0, 3.0, -6.0, 4.0, 1.0, -7.0, 9.0, 2.0, 6.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4(var[3][0][0], mat4(6.0, 1.0, 6.0, 5.0, 7.0, -7.0, -8.0, 7.0, -2.0, -3.0, 4.0, 3.0, 2.0, -8.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4(var[3][0][1], mat4(-3.0, 2.0, -4.0, 7.0, -4.0, 1.0, -9.0, 8.0, 4.0, -8.0, 5.0, 3.0, 7.0, 5.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4(var[3][0][2], mat4(-1.0, -3.0, -3.0, -4.0, -9.0, 8.0, 9.0, 0.0, 4.0, 6.0, -9.0, -8.0, 5.0, 3.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4(var[3][1][0], mat4(-7.0, -7.0, -4.0, 1.0, 4.0, 3.0, 9.0, -8.0, -6.0, -7.0, -1.0, -7.0, -7.0, 7.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat4(var[3][1][1], mat4(-6.0, 2.0, 5.0, 3.0, 5.0, -7.0, 3.0, -6.0, -7.0, 6.0, 1.0, -5.0, -6.0, 9.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat4(var[3][1][2], mat4(2.0, -7.0, -4.0, -2.0, -7.0, 1.0, -1.0, 4.0, -9.0, 4.0, 9.0, -9.0, 0.0, -9.0, -2.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4(6.0, -8.0, 2.0, -8.0, 1.0, -5.0, -7.0, -8.0, -9.0, 3.0, -9.0, -1.0, 7.0, -6.0, -5.0, 2.0));
	var[0][0][1] = (mat4(4.0, 3.0, -5.0, 6.0, 5.0, -1.0, -1.0, 7.0, -1.0, 5.0, -8.0, -3.0, 2.0, -6.0, -9.0, -5.0));
	var[0][0][2] = (mat4(1.0, -5.0, -9.0, 9.0, -7.0, -1.0, 6.0, -6.0, 6.0, -9.0, -8.0, -3.0, -3.0, 4.0, -5.0, -1.0));
	var[0][1][0] = (mat4(-4.0, -9.0, -7.0, -9.0, -9.0, -3.0, -8.0, 0.0, -1.0, -4.0, -1.0, -8.0, 5.0, -8.0, -3.0, 1.0));
	var[0][1][1] = (mat4(-1.0, -6.0, -1.0, 0.0, -8.0, 6.0, 6.0, -5.0, -6.0, 9.0, 2.0, 6.0, 6.0, -5.0, -7.0, 0.0));
	var[0][1][2] = (mat4(2.0, 6.0, 3.0, 6.0, 1.0, -3.0, -6.0, 0.0, -2.0, 0.0, -9.0, 1.0, 6.0, 9.0, -9.0, 0.0));
	var[1][0][0] = (mat4(-3.0, -9.0, -6.0, 5.0, 0.0, 6.0, -5.0, -7.0, -6.0, -5.0, 8.0, -6.0, -2.0, -8.0, -4.0, -8.0));
	var[1][0][1] = (mat4(1.0, 5.0, 6.0, -2.0, -7.0, -3.0, -4.0, 6.0, -8.0, -5.0, 2.0, 8.0, 4.0, 3.0, 6.0, -6.0));
	var[1][0][2] = (mat4(-7.0, 5.0, 7.0, -7.0, -6.0, 6.0, -2.0, 5.0, 1.0, -3.0, -2.0, 4.0, 6.0, -6.0, -5.0, -5.0));
	var[1][1][0] = (mat4(-9.0, 4.0, 1.0, 5.0, 0.0, 9.0, 3.0, -2.0, -8.0, 9.0, -9.0, 2.0, -8.0, 0.0, 7.0, 7.0));
	var[1][1][1] = (mat4(6.0, -5.0, 5.0, 3.0, -2.0, -8.0, 6.0, 2.0, 7.0, -1.0, -2.0, 8.0, -9.0, 1.0, -4.0, 1.0));
	var[1][1][2] = (mat4(-5.0, -8.0, 1.0, 9.0, -7.0, -4.0, 0.0, -3.0, 6.0, 2.0, 2.0, -2.0, -8.0, 4.0, 1.0, 7.0));
	var[2][0][0] = (mat4(6.0, -8.0, -5.0, -4.0, 5.0, -3.0, 4.0, 6.0, 2.0, -2.0, -7.0, 5.0, -9.0, -3.0, 9.0, 5.0));
	var[2][0][1] = (mat4(6.0, 9.0, 2.0, 1.0, -6.0, -8.0, 8.0, -2.0, 1.0, 6.0, -5.0, 5.0, -7.0, -8.0, 9.0, 3.0));
	var[2][0][2] = (mat4(6.0, -6.0, -4.0, 0.0, 8.0, -9.0, -6.0, 2.0, 6.0, 7.0, 5.0, 9.0, -6.0, -9.0, -5.0, 5.0));
	var[2][1][0] = (mat4(4.0, -5.0, 2.0, -2.0, -1.0, 1.0, 4.0, 0.0, -1.0, -4.0, -1.0, 2.0, -4.0, 7.0, -7.0, -7.0));
	var[2][1][1] = (mat4(1.0, -8.0, 7.0, -2.0, 3.0, 6.0, -2.0, -7.0, -7.0, -8.0, 7.0, 1.0, -1.0, -5.0, 6.0, -5.0));
	var[2][1][2] = (mat4(6.0, -7.0, -1.0, -1.0, -1.0, -3.0, -6.0, 3.0, -9.0, -8.0, -5.0, 6.0, -3.0, 3.0, 8.0, -8.0));
	var[3][0][0] = (mat4(-5.0, 3.0, 0.0, -2.0, -1.0, -6.0, -7.0, 9.0, -9.0, 8.0, 2.0, -7.0, -7.0, 9.0, 8.0, 7.0));
	var[3][0][1] = (mat4(-9.0, 5.0, -4.0, -4.0, 9.0, -1.0, 3.0, -1.0, 7.0, 2.0, 8.0, -2.0, 2.0, -3.0, 0.0, -9.0));
	var[3][0][2] = (mat4(5.0, -1.0, 6.0, 9.0, 1.0, -7.0, -5.0, -3.0, 4.0, 8.0, -9.0, -2.0, -2.0, -1.0, -1.0, 0.0));
	var[3][1][0] = (mat4(5.0, -4.0, 6.0, 7.0, 5.0, 0.0, 0.0, -5.0, 4.0, -8.0, -9.0, -1.0, -8.0, 5.0, 0.0, -4.0));
	var[3][1][1] = (mat4(2.0, 7.0, -3.0, 8.0, -6.0, 0.0, 1.0, 7.0, 8.0, -8.0, -8.0, -9.0, -3.0, -1.0, -7.0, 0.0));
	var[3][1][2] = (mat4(6.0, -2.0, -5.0, -4.0, -6.0, 9.0, -4.0, -9.0, 8.0, -7.0, -5.0, -3.0, 3.0, 5.0, 4.0, -2.0));
}
#version 450
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
	highp mat4x2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0][0][0], mat4x2(-5.0, -2.0, -4.0, 7.0, -9.0, -9.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][1], mat4x2(-6.0, -1.0, -5.0, -9.0, -2.0, -2.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][2], mat4x2(-3.0, -8.0, -8.0, 1.0, 3.0, 0.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][0], mat4x2(4.0, -4.0, -2.0, 1.0, 2.0, 6.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][1], mat4x2(8.0, 8.0, -3.0, -7.0, 8.0, -1.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][2], mat4x2(-4.0, 5.0, -6.0, 5.0, -9.0, -3.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][0], mat4x2(0.0, -7.0, -1.0, 4.0, -3.0, -1.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][1], mat4x2(0.0, 8.0, -9.0, -4.0, 3.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][2], mat4x2(-8.0, -6.0, 1.0, -7.0, 1.0, -4.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][0], mat4x2(-9.0, -9.0, 0.0, -2.0, 7.0, 4.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][1], mat4x2(0.0, -7.0, -8.0, 5.0, 7.0, -1.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][2], mat4x2(4.0, 3.0, 5.0, -4.0, 8.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][0], mat4x2(4.0, -8.0, 7.0, 0.0, 5.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][1], mat4x2(-9.0, -5.0, -3.0, 3.0, -3.0, 8.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][2], mat4x2(-2.0, 0.0, 3.0, 5.0, 9.0, -9.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][0], mat4x2(6.0, 8.0, 5.0, -7.0, -9.0, 6.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][1], mat4x2(1.0, -1.0, 8.0, 0.0, -2.0, -2.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][2], mat4x2(0.0, 1.0, -7.0, 0.0, -4.0, 9.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][0], mat4x2(9.0, -1.0, 3.0, 6.0, 8.0, -8.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][1], mat4x2(-3.0, -9.0, -2.0, 8.0, -2.0, 7.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][2], mat4x2(-5.0, 8.0, -6.0, -6.0, -3.0, -1.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][0], mat4x2(-3.0, 5.0, 6.0, 1.0, -2.0, 9.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][1], mat4x2(2.0, 8.0, -2.0, -7.0, 4.0, -5.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][2], mat4x2(-1.0, 2.0, 3.0, -6.0, 2.0, 8.0, 6.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4x2(0.0, -3.0, -2.0, 2.0, -2.0, -3.0, 5.0, -5.0));
	var[0][0][1] = (mat4x2(5.0, -6.0, -4.0, -1.0, 4.0, 7.0, -8.0, -2.0));
	var[0][0][2] = (mat4x2(-5.0, -1.0, -3.0, 6.0, -2.0, 0.0, -7.0, -7.0));
	var[0][1][0] = (mat4x2(2.0, -6.0, -9.0, 6.0, 2.0, -2.0, 9.0, 8.0));
	var[0][1][1] = (mat4x2(8.0, 3.0, -2.0, -8.0, 8.0, 4.0, -3.0, 4.0));
	var[0][1][2] = (mat4x2(-5.0, 5.0, 9.0, -8.0, -8.0, -5.0, -4.0, -1.0));
	var[1][0][0] = (mat4x2(2.0, 0.0, -6.0, 9.0, 1.0, -7.0, 4.0, -6.0));
	var[1][0][1] = (mat4x2(5.0, -4.0, -3.0, 8.0, -6.0, -1.0, -6.0, 7.0));
	var[1][0][2] = (mat4x2(4.0, 7.0, -6.0, 5.0, -4.0, -7.0, 2.0, 1.0));
	var[1][1][0] = (mat4x2(-1.0, -6.0, 6.0, -3.0, -5.0, 2.0, 6.0, 1.0));
	var[1][1][1] = (mat4x2(-9.0, 0.0, -5.0, -9.0, 9.0, 8.0, -6.0, -4.0));
	var[1][1][2] = (mat4x2(-4.0, -8.0, 9.0, 7.0, -5.0, -3.0, 3.0, 7.0));
	var[2][0][0] = (mat4x2(6.0, -3.0, -5.0, -7.0, -7.0, 4.0, -9.0, 7.0));
	var[2][0][1] = (mat4x2(2.0, 2.0, 9.0, 3.0, -1.0, -8.0, 1.0, -5.0));
	var[2][0][2] = (mat4x2(6.0, 2.0, -6.0, 4.0, -3.0, -6.0, -7.0, -8.0));
	var[2][1][0] = (mat4x2(-1.0, 2.0, 5.0, -9.0, 3.0, 2.0, -5.0, 4.0));
	var[2][1][1] = (mat4x2(-2.0, 3.0, -1.0, -4.0, -7.0, 3.0, 1.0, -1.0));
	var[2][1][2] = (mat4x2(3.0, 6.0, -6.0, -2.0, -8.0, 0.0, -9.0, -5.0));
	var[3][0][0] = (mat4x2(-1.0, -4.0, -5.0, 2.0, -7.0, -1.0, 7.0, 1.0));
	var[3][0][1] = (mat4x2(9.0, -3.0, -8.0, 4.0, 5.0, -9.0, 9.0, -3.0));
	var[3][0][2] = (mat4x2(5.0, 6.0, -5.0, 1.0, 0.0, 8.0, -9.0, -4.0));
	var[3][1][0] = (mat4x2(-9.0, 5.0, -9.0, 2.0, -2.0, -5.0, -3.0, 5.0));
	var[3][1][1] = (mat4x2(-8.0, -1.0, 9.0, 1.0, -6.0, 5.0, -5.0, -9.0));
	var[3][1][2] = (mat4x2(7.0, 1.0, 0.0, 3.0, 4.0, 8.0, 8.0, -2.0));
}
#version 450
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
	int padding;
	highp int var[4][2][3];
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((padding), 6) && allOk;
	allOk = compare_int((var[0][0][0]), 0) && allOk;
	allOk = compare_int((var[0][0][1]), 9) && allOk;
	allOk = compare_int((var[0][0][2]), -6) && allOk;
	allOk = compare_int((var[0][1][0]), -3) && allOk;
	allOk = compare_int((var[0][1][1]), 4) && allOk;
	allOk = compare_int((var[0][1][2]), 4) && allOk;
	allOk = compare_int((var[1][0][0]), -9) && allOk;
	allOk = compare_int((var[1][0][1]), -8) && allOk;
	allOk = compare_int((var[1][0][2]), 8) && allOk;
	allOk = compare_int((var[1][1][0]), -9) && allOk;
	allOk = compare_int((var[1][1][1]), -9) && allOk;
	allOk = compare_int((var[1][1][2]), 3) && allOk;
	allOk = compare_int((var[2][0][0]), -9) && allOk;
	allOk = compare_int((var[2][0][1]), -1) && allOk;
	allOk = compare_int((var[2][0][2]), 0) && allOk;
	allOk = compare_int((var[2][1][0]), -1) && allOk;
	allOk = compare_int((var[2][1][1]), -9) && allOk;
	allOk = compare_int((var[2][1][2]), -7) && allOk;
	allOk = compare_int((var[3][0][0]), -9) && allOk;
	allOk = compare_int((var[3][0][1]), 5) && allOk;
	allOk = compare_int((var[3][0][2]), 5) && allOk;
	allOk = compare_int((var[3][1][0]), 9) && allOk;
	allOk = compare_int((var[3][1][1]), -8) && allOk;
	allOk = compare_int((var[3][1][2]), -6) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (8);
	var[0][0][0] = (2);
	var[0][0][1] = (-5);
	var[0][0][2] = (0);
	var[0][1][0] = (9);
	var[0][1][1] = (-8);
	var[0][1][2] = (4);
	var[1][0][0] = (-7);
	var[1][0][1] = (-7);
	var[1][0][2] = (-8);
	var[1][1][0] = (-4);
	var[1][1][1] = (5);
	var[1][1][2] = (-3);
	var[2][0][0] = (6);
	var[2][0][1] = (-6);
	var[2][0][2] = (6);
	var[2][1][0] = (-3);
	var[2][1][1] = (6);
	var[2][1][2] = (-2);
	var[3][0][0] = (-5);
	var[3][0][1] = (5);
	var[3][0][2] = (-4);
	var[3][1][0] = (5);
	var[3][1][1] = (7);
	var[3][1][2] = (7);
}
#version 450
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
	highp mat4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -8.0) && allOk;
	allOk = compare_mat4(var[0][0][0], mat4(-5.0, 8.0, 6.0, 7.0, 4.0, 5.0, 7.0, -3.0, 0.0, 2.0, 5.0, 8.0, 3.0, 4.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(-9.0, -9.0, -6.0, 5.0, 6.0, 7.0, 6.0, 1.0, -8.0, -3.0, -3.0, 7.0, -2.0, -3.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat4(var[0][0][2], mat4(-1.0, -6.0, -1.0, 6.0, 1.0, -1.0, 3.0, -1.0, 6.0, 4.0, -2.0, -9.0, 0.0, 5.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(9.0, 3.0, 0.0, 7.0, 0.0, 9.0, -9.0, 1.0, 4.0, -9.0, -8.0, 4.0, 6.0, -6.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(8.0, -2.0, 4.0, -6.0, 7.0, -4.0, -8.0, -2.0, -2.0, 3.0, -3.0, 8.0, 7.0, -6.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat4(var[0][1][2], mat4(-2.0, -1.0, 8.0, 5.0, 1.0, 7.0, 0.0, -1.0, 1.0, -2.0, 7.0, -8.0, -2.0, -9.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(-4.0, -6.0, -1.0, 4.0, 9.0, -1.0, 6.0, -4.0, 0.0, -7.0, 7.0, -7.0, 8.0, -3.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(-5.0, -7.0, 5.0, 0.0, -5.0, 4.0, 7.0, 2.0, -1.0, 9.0, -8.0, -1.0, -9.0, -5.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat4(var[1][0][2], mat4(1.0, 8.0, -6.0, 0.0, -7.0, -8.0, 5.0, -9.0, -9.0, -5.0, 9.0, 0.0, -4.0, -9.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(8.0, 3.0, 6.0, -3.0, 8.0, -1.0, 8.0, 0.0, 5.0, 7.0, 9.0, -3.0, -7.0, 3.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(7.0, 9.0, 7.0, -8.0, 2.0, 6.0, 0.0, 5.0, -8.0, 5.0, 3.0, 9.0, 6.0, -8.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat4(var[1][1][2], mat4(-1.0, 7.0, -5.0, 0.0, -3.0, -6.0, -8.0, -6.0, 6.0, -3.0, -1.0, -6.0, 8.0, 3.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(7.0, 3.0, 0.0, -4.0, 5.0, -2.0, 3.0, -9.0, 2.0, -2.0, -6.0, -1.0, -7.0, -8.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(0.0, -2.0, 7.0, -3.0, 4.0, 4.0, 4.0, 5.0, 7.0, -1.0, 7.0, 7.0, -8.0, 2.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4(var[2][0][2], mat4(-9.0, 9.0, -4.0, 5.0, 7.0, -3.0, 5.0, 6.0, -8.0, 2.0, 2.0, -7.0, 5.0, 8.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(3.0, 7.0, -3.0, 1.0, -8.0, 3.0, 7.0, -3.0, 7.0, 5.0, -7.0, -8.0, 3.0, 3.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(-3.0, 9.0, 9.0, -5.0, 5.0, -1.0, 6.0, -1.0, -4.0, -9.0, -9.0, -9.0, -1.0, 1.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4(var[2][1][2], mat4(5.0, 4.0, 1.0, 4.0, -7.0, -4.0, -2.0, -8.0, -7.0, 9.0, -6.0, 8.0, -9.0, 2.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4(var[3][0][0], mat4(-6.0, -5.0, 3.0, -7.0, -3.0, 7.0, -7.0, 2.0, 7.0, -9.0, -3.0, 4.0, 3.0, 3.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat4(var[3][0][1], mat4(-8.0, -1.0, 7.0, 1.0, 7.0, 3.0, -9.0, -3.0, 2.0, -2.0, 4.0, -9.0, -8.0, 8.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat4(var[3][0][2], mat4(0.0, -1.0, -6.0, -9.0, -8.0, -9.0, -1.0, -7.0, -3.0, -7.0, 1.0, -2.0, 8.0, -7.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat4(var[3][1][0], mat4(-8.0, 7.0, 0.0, 6.0, -9.0, -5.0, 9.0, -7.0, 6.0, -9.0, 6.0, -4.0, 1.0, 7.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4(var[3][1][1], mat4(6.0, 2.0, -6.0, -9.0, -4.0, -6.0, 3.0, 4.0, 7.0, 1.0, -8.0, 8.0, -7.0, -9.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat4(var[3][1][2], mat4(4.0, 8.0, 8.0, -3.0, -8.0, -1.0, -7.0, -6.0, 7.0, -3.0, -6.0, -6.0, 7.0, 3.0, 2.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-9.0);
	var[0][0][0][0] = (vec4(-9.0, -4.0, -9.0, -5.0));
	var[0][0][0][1] = (vec4(-2.0, 9.0, 0.0, -8.0));
	var[0][0][0][2] = (vec4(-6.0, -3.0, -8.0, 3.0));
	var[0][0][0][3] = (vec4(0.0, -1.0, -4.0, 4.0));
	var[0][0][1][0] = (vec4(7.0, -9.0, 6.0, 5.0));
	var[0][0][1][1] = (vec4(6.0, -1.0, -3.0, -3.0));
	var[0][0][1][2] = (vec4(-9.0, 3.0, -9.0, 0.0));
	var[0][0][1][3] = (vec4(9.0, 4.0, -3.0, 1.0));
	var[0][0][2][0] = (vec4(2.0, 1.0, 9.0, -4.0));
	var[0][0][2][1] = (vec4(-7.0, 7.0, 0.0, 7.0));
	var[0][0][2][2] = (vec4(9.0, 9.0, -5.0, -7.0));
	var[0][0][2][3] = (vec4(-4.0, -6.0, 5.0, -9.0));
	var[0][1][0][0] = (vec4(0.0, 3.0, 6.0, -1.0));
	var[0][1][0][1] = (vec4(4.0, 6.0, 8.0, 1.0));
	var[0][1][0][2] = (vec4(9.0, -4.0, 7.0, 7.0));
	var[0][1][0][3] = (vec4(-6.0, -8.0, -9.0, 2.0));
	var[0][1][1][0] = (vec4(-1.0, 7.0, -4.0, 2.0));
	var[0][1][1][1] = (vec4(9.0, 2.0, -2.0, -1.0));
	var[0][1][1][2] = (vec4(7.0, 3.0, -6.0, 0.0));
	var[0][1][1][3] = (vec4(-1.0, -8.0, 9.0, -7.0));
	var[0][1][2][0] = (vec4(5.0, 7.0, -3.0, -2.0));
	var[0][1][2][1] = (vec4(9.0, -5.0, -2.0, -2.0));
	var[0][1][2][2] = (vec4(2.0, 4.0, -1.0, 9.0));
	var[0][1][2][3] = (vec4(-8.0, -7.0, 8.0, 3.0));
	var[1][0][0][0] = (vec4(4.0, 6.0, -1.0, -7.0));
	var[1][0][0][1] = (vec4(7.0, 8.0, 5.0, -1.0));
	var[1][0][0][2] = (vec4(8.0, 2.0, -8.0, 0.0));
	var[1][0][0][3] = (vec4(5.0, 8.0, 6.0, -9.0));
	var[1][0][1][0] = (vec4(3.0, 1.0, 2.0, 2.0));
	var[1][0][1][1] = (vec4(-3.0, -7.0, 1.0, 0.0));
	var[1][0][1][2] = (vec4(9.0, 5.0, -2.0, 6.0));
	var[1][0][1][3] = (vec4(-1.0, -5.0, 7.0, -9.0));
	var[1][0][2][0] = (vec4(-2.0, -2.0, -8.0, -4.0));
	var[1][0][2][1] = (vec4(7.0, -4.0, -1.0, 2.0));
	var[1][0][2][2] = (vec4(7.0, 7.0, 2.0, 8.0));
	var[1][0][2][3] = (vec4(1.0, 2.0, -3.0, -5.0));
	var[1][1][0][0] = (vec4(-3.0, -9.0, 9.0, -7.0));
	var[1][1][0][1] = (vec4(-7.0, 9.0, -4.0, 0.0));
	var[1][1][0][2] = (vec4(-4.0, -3.0, 0.0, 6.0));
	var[1][1][0][3] = (vec4(3.0, 4.0, -8.0, -5.0));
	var[1][1][1][0] = (vec4(4.0, 5.0, 0.0, -6.0));
	var[1][1][1][1] = (vec4(7.0, 4.0, 1.0, 9.0));
	var[1][1][1][2] = (vec4(-8.0, 8.0, 7.0, 4.0));
	var[1][1][1][3] = (vec4(-7.0, 3.0, -9.0, -1.0));
	var[1][1][2][0] = (vec4(-5.0, -8.0, 2.0, -5.0));
	var[1][1][2][1] = (vec4(3.0, -8.0, -1.0, -5.0));
	var[1][1][2][2] = (vec4(-6.0, -2.0, 3.0, 0.0));
	var[1][1][2][3] = (vec4(5.0, 9.0, -2.0, 1.0));
	var[2][0][0][0] = (vec4(6.0, -2.0, -1.0, -2.0));
	var[2][0][0][1] = (vec4(0.0, 5.0, -4.0, 5.0));
	var[2][0][0][2] = (vec4(8.0, -8.0, 9.0, -3.0));
	var[2][0][0][3] = (vec4(9.0, 9.0, 4.0, 4.0));
	var[2][0][1][0] = (vec4(-3.0, -4.0, -7.0, 1.0));
	var[2][0][1][1] = (vec4(4.0, -2.0, 1.0, -8.0));
	var[2][0][1][2] = (vec4(-8.0, 5.0, 4.0, 7.0));
	var[2][0][1][3] = (vec4(-8.0, -1.0, 0.0, 7.0));
	var[2][0][2][0] = (vec4(-7.0, -5.0, 2.0, 2.0));
	var[2][0][2][1] = (vec4(4.0, 8.0, 4.0, -9.0));
	var[2][0][2][2] = (vec4(0.0, -9.0, 0.0, 0.0));
	var[2][0][2][3] = (vec4(-2.0, -6.0, 9.0, 9.0));
	var[2][1][0][0] = (vec4(-4.0, -5.0, 6.0, 9.0));
	var[2][1][0][1] = (vec4(-5.0, -7.0, 1.0, 2.0));
	var[2][1][0][2] = (vec4(-7.0, 2.0, -8.0, 9.0));
	var[2][1][0][3] = (vec4(-3.0, -1.0, 9.0, -1.0));
	var[2][1][1][0] = (vec4(5.0, -8.0, -7.0, 3.0));
	var[2][1][1][1] = (vec4(-5.0, 2.0, 5.0, 7.0));
	var[2][1][1][2] = (vec4(-9.0, 2.0, -7.0, 9.0));
	var[2][1][1][3] = (vec4(2.0, 4.0, 1.0, -7.0));
	var[2][1][2][0] = (vec4(6.0, -2.0, 9.0, 1.0));
	var[2][1][2][1] = (vec4(0.0, -3.0, -6.0, -8.0));
	var[2][1][2][2] = (vec4(-4.0, 0.0, -2.0, 0.0));
	var[2][1][2][3] = (vec4(5.0, -6.0, -3.0, -8.0));
	var[3][0][0][0] = (vec4(-9.0, -6.0, -8.0, 4.0));
	var[3][0][0][1] = (vec4(-6.0, 9.0, -8.0, 3.0));
	var[3][0][0][2] = (vec4(0.0, 1.0, -1.0, -7.0));
	var[3][0][0][3] = (vec4(-1.0, -1.0, -3.0, -9.0));
	var[3][0][1][0] = (vec4(4.0, 9.0, 4.0, -4.0));
	var[3][0][1][1] = (vec4(3.0, -1.0, 2.0, 8.0));
	var[3][0][1][2] = (vec4(-3.0, -6.0, -4.0, 0.0));
	var[3][0][1][3] = (vec4(-4.0, 4.0, 6.0, 2.0));
	var[3][0][2][0] = (vec4(8.0, 5.0, 3.0, 0.0));
	var[3][0][2][1] = (vec4(-2.0, 0.0, 7.0, -5.0));
	var[3][0][2][2] = (vec4(6.0, 0.0, 6.0, -6.0));
	var[3][0][2][3] = (vec4(-1.0, 1.0, -1.0, -1.0));
	var[3][1][0][0] = (vec4(-9.0, 1.0, 2.0, 8.0));
	var[3][1][0][1] = (vec4(2.0, 9.0, 8.0, 5.0));
	var[3][1][0][2] = (vec4(-8.0, 4.0, -3.0, -4.0));
	var[3][1][0][3] = (vec4(9.0, 5.0, 6.0, -5.0));
	var[3][1][1][0] = (vec4(5.0, -5.0, 4.0, 2.0));
	var[3][1][1][1] = (vec4(-4.0, -6.0, -2.0, 5.0));
	var[3][1][1][2] = (vec4(-1.0, -4.0, 1.0, 6.0));
	var[3][1][1][3] = (vec4(-3.0, 4.0, -1.0, -1.0));
	var[3][1][2][0] = (vec4(9.0, 4.0, 8.0, 0.0));
	var[3][1][2][1] = (vec4(0.0, -3.0, -3.0, 1.0));
	var[3][1][2][2] = (vec4(4.0, 6.0, -3.0, -5.0));
	var[3][1][2][3] = (vec4(0.0, 3.0, -1.0, 5.0));
}
#version 450
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
	highp mat4x3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat4x3(var[0][0][0], mat4x3(5.0, 8.0, -9.0, 1.0, -3.0, 3.0, 6.0, -8.0, 9.0, 9.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(6.0, 6.0, 9.0, 0.0, 3.0, -4.0, 2.0, 0.0, -9.0, -2.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][2], mat4x3(6.0, 1.0, 3.0, 8.0, -4.0, 7.0, -9.0, -8.0, 2.0, 8.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(7.0, 0.0, 9.0, -1.0, -1.0, -7.0, 0.0, 9.0, 5.0, 1.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(-7.0, 6.0, -5.0, -4.0, -1.0, 8.0, 7.0, -9.0, -3.0, 7.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][2], mat4x3(-2.0, 9.0, 9.0, -6.0, 0.0, -5.0, 6.0, -3.0, 8.0, -5.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(-5.0, 2.0, 4.0, 9.0, 2.0, 6.0, -3.0, -4.0, -6.0, -7.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(8.0, 6.0, -1.0, 9.0, 6.0, 0.0, 4.0, -9.0, -2.0, -3.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][2], mat4x3(-6.0, -9.0, 7.0, -9.0, -9.0, 8.0, 6.0, 3.0, -6.0, 2.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(-7.0, 6.0, 5.0, -5.0, -1.0, 5.0, -7.0, 1.0, 3.0, -9.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(2.0, 5.0, -8.0, 0.0, -6.0, 4.0, 6.0, 0.0, -2.0, 3.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][2], mat4x3(-5.0, 0.0, -6.0, 3.0, 7.0, -8.0, -4.0, -3.0, 1.0, 4.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(1.0, -9.0, 3.0, 4.0, 0.0, -8.0, -3.0, -6.0, -4.0, -5.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(2.0, 3.0, -9.0, -3.0, 0.0, -7.0, 8.0, -9.0, -4.0, -4.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][2], mat4x3(8.0, -5.0, -5.0, 6.0, 8.0, -7.0, 1.0, -4.0, -3.0, 4.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(-6.0, -3.0, -6.0, 8.0, 4.0, 2.0, 4.0, -2.0, -3.0, -3.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(-3.0, -8.0, -4.0, 6.0, 4.0, 6.0, 3.0, -7.0, 3.0, -7.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][2], mat4x3(7.0, -9.0, -4.0, 2.0, -4.0, -9.0, 4.0, 9.0, 5.0, -8.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][0], mat4x3(9.0, 2.0, -9.0, 8.0, 0.0, 1.0, -3.0, -1.0, 0.0, -9.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][1], mat4x3(-9.0, 7.0, 5.0, 0.0, 7.0, -3.0, -7.0, 6.0, -5.0, -5.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][2], mat4x3(-9.0, 6.0, 7.0, -5.0, 8.0, -2.0, -6.0, -3.0, -5.0, 1.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][0], mat4x3(-6.0, 0.0, -2.0, -4.0, 8.0, 3.0, -4.0, -4.0, 7.0, -3.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][1], mat4x3(2.0, -5.0, -5.0, 2.0, 4.0, -5.0, 4.0, -7.0, 6.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][2], mat4x3(-6.0, -1.0, -7.0, 8.0, -6.0, 1.0, 7.0, -2.0, 9.0, 3.0, -9.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-5.0);
	var[0][0][0] = (mat4x3(-5.0, 1.0, 6.0, 4.0, 3.0, 9.0, -4.0, 3.0, 1.0, 9.0, 2.0, -5.0));
	var[0][0][1] = (mat4x3(-6.0, 1.0, 3.0, -6.0, -1.0, -4.0, 3.0, 9.0, -1.0, 2.0, 4.0, 4.0));
	var[0][0][2] = (mat4x3(-9.0, -8.0, -5.0, -9.0, -6.0, -7.0, 6.0, -5.0, -5.0, 2.0, 8.0, 9.0));
	var[0][1][0] = (mat4x3(5.0, 7.0, -2.0, -4.0, -2.0, 3.0, -6.0, 0.0, -7.0, 9.0, 7.0, 9.0));
	var[0][1][1] = (mat4x3(5.0, -1.0, -2.0, 4.0, 7.0, 2.0, 8.0, -7.0, 9.0, -6.0, -9.0, 7.0));
	var[0][1][2] = (mat4x3(9.0, 8.0, -1.0, -6.0, -4.0, 5.0, -8.0, -4.0, 1.0, 3.0, 4.0, -1.0));
	var[1][0][0] = (mat4x3(-3.0, -2.0, 6.0, 2.0, 3.0, -8.0, -7.0, 9.0, -1.0, -7.0, -4.0, 9.0));
	var[1][0][1] = (mat4x3(7.0, 7.0, 9.0, -7.0, -4.0, 7.0, -5.0, 0.0, -1.0, 0.0, 0.0, -4.0));
	var[1][0][2] = (mat4x3(-5.0, -2.0, -6.0, -8.0, -7.0, -9.0, -2.0, 2.0, 9.0, 1.0, 3.0, -8.0));
	var[1][1][0] = (mat4x3(-9.0, 0.0, 8.0, -4.0, 2.0, 0.0, 3.0, -3.0, 1.0, 6.0, 7.0, 7.0));
	var[1][1][1] = (mat4x3(0.0, 1.0, 7.0, 2.0, 8.0, -2.0, -5.0, 8.0, 3.0, 7.0, -6.0, -1.0));
	var[1][1][2] = (mat4x3(1.0, 4.0, 0.0, 2.0, -3.0, 8.0, -5.0, -9.0, 4.0, -5.0, -8.0, 5.0));
	var[2][0][0] = (mat4x3(-5.0, 2.0, -9.0, 2.0, 9.0, 8.0, 7.0, 9.0, -6.0, -3.0, -8.0, 8.0));
	var[2][0][1] = (mat4x3(9.0, 8.0, -3.0, 4.0, 8.0, 2.0, -9.0, -8.0, 5.0, -8.0, -9.0, -8.0));
	var[2][0][2] = (mat4x3(-9.0, 8.0, -3.0, -9.0, -6.0, 1.0, -1.0, -2.0, -1.0, 9.0, 8.0, 8.0));
	var[2][1][0] = (mat4x3(-6.0, -1.0, 2.0, 6.0, -2.0, 0.0, 5.0, -5.0, -5.0, -9.0, 3.0, -3.0));
	var[2][1][1] = (mat4x3(-5.0, 2.0, -7.0, 9.0, 1.0, 1.0, -5.0, 8.0, -6.0, -7.0, -1.0, -7.0));
	var[2][1][2] = (mat4x3(4.0, -4.0, -4.0, -1.0, -2.0, 0.0, -3.0, 8.0, 7.0, -1.0, 4.0, -8.0));
	var[3][0][0] = (mat4x3(2.0, -2.0, 0.0, -4.0, -5.0, 8.0, 2.0, 9.0, -1.0, -3.0, -6.0, 1.0));
	var[3][0][1] = (mat4x3(-5.0, 6.0, 8.0, 7.0, 0.0, 7.0, 1.0, 4.0, 9.0, -6.0, -5.0, -4.0));
	var[3][0][2] = (mat4x3(-4.0, -9.0, -1.0, 0.0, 5.0, -4.0, -1.0, -3.0, -5.0, 8.0, 5.0, 4.0));
	var[3][1][0] = (mat4x3(2.0, 3.0, -9.0, 2.0, -1.0, -4.0, 3.0, 5.0, 1.0, -4.0, -4.0, 1.0));
	var[3][1][1] = (mat4x3(-8.0, -5.0, -8.0, -8.0, -7.0, 7.0, -9.0, 8.0, -2.0, -2.0, 8.0, -7.0));
	var[3][1][2] = (mat4x3(2.0, 5.0, 7.0, -5.0, 5.0, 2.0, -2.0, 9.0, -6.0, -4.0, 2.0, -4.0));
}
#version 450
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
	allOk = compare_mat3x4(var[0][0][0], mat3x4(-2.0, 8.0, -6.0, -5.0, -7.0, 8.0, -7.0, -5.0, 5.0, -2.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][1], mat3x4(-7.0, -3.0, -5.0, 8.0, -1.0, -9.0, 0.0, -5.0, -1.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][0], mat3x4(-1.0, 6.0, -8.0, 3.0, 8.0, -8.0, 2.0, 8.0, -6.0, -7.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][1], mat3x4(-6.0, 8.0, -9.0, -3.0, 9.0, -9.0, -2.0, -8.0, 8.0, -5.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[0][2][0], mat3x4(0.0, -5.0, 8.0, -6.0, -1.0, -7.0, 0.0, 3.0, -2.0, -4.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[0][2][1], mat3x4(-4.0, -5.0, 4.0, 2.0, -5.0, -5.0, -9.0, 2.0, -7.0, 9.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[0][3][0], mat3x4(0.0, -3.0, -6.0, 4.0, -8.0, -1.0, 9.0, 9.0, 2.0, 9.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[0][3][1], mat3x4(-7.0, 4.0, 7.0, 7.0, 0.0, -9.0, -8.0, -1.0, -6.0, 9.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][0], mat3x4(2.0, -8.0, 6.0, 3.0, -1.0, -1.0, 2.0, 5.0, -7.0, -3.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][1], mat3x4(-4.0, 5.0, -5.0, 2.0, -9.0, 2.0, -4.0, -7.0, -3.0, 1.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][0], mat3x4(4.0, -3.0, -4.0, 3.0, 7.0, 7.0, 1.0, 8.0, -2.0, 0.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][1], mat3x4(5.0, -5.0, 7.0, 4.0, 2.0, 1.0, -1.0, 0.0, -7.0, -6.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1][2][0], mat3x4(2.0, 0.0, -4.0, 6.0, 3.0, -2.0, -9.0, 8.0, -8.0, 8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[1][2][1], mat3x4(-7.0, -2.0, 9.0, -3.0, 9.0, -8.0, 1.0, -7.0, -8.0, -9.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[1][3][0], mat3x4(8.0, -2.0, 1.0, 8.0, 4.0, 6.0, -6.0, -5.0, 1.0, -7.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1][3][1], mat3x4(5.0, 1.0, 1.0, -6.0, 0.0, -8.0, -7.0, 3.0, 3.0, -8.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][0], mat3x4(3.0, -2.0, 3.0, -8.0, -1.0, -1.0, 0.0, 9.0, 3.0, 9.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][1], mat3x4(-1.0, -3.0, 1.0, -7.0, 6.0, -9.0, 9.0, 4.0, 1.0, -5.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][0], mat3x4(9.0, 4.0, 1.0, 5.0, 8.0, -4.0, -6.0, -8.0, 8.0, 1.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][1], mat3x4(1.0, 1.0, 8.0, -1.0, 0.0, 9.0, 7.0, -5.0, 1.0, -6.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[2][2][0], mat3x4(-2.0, 9.0, -3.0, -1.0, -8.0, 5.0, 9.0, -3.0, 7.0, 2.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[2][2][1], mat3x4(0.0, 7.0, -2.0, 1.0, 7.0, 1.0, -5.0, 4.0, 4.0, -5.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[2][3][0], mat3x4(-2.0, -2.0, 3.0, -6.0, -5.0, -1.0, 2.0, -4.0, -8.0, -7.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[2][3][1], mat3x4(-3.0, -9.0, 3.0, 8.0, 3.0, 7.0, 9.0, 3.0, -3.0, 7.0, -8.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(-2.0, -8.0, -5.0, 9.0));
	var[0][0][0][1] = (vec4(-8.0, -4.0, 1.0, -8.0));
	var[0][0][0][2] = (vec4(-4.0, 3.0, 6.0, -4.0));
	var[0][0][1][0] = (vec4(-4.0, -7.0, 6.0, -4.0));
	var[0][0][1][1] = (vec4(0.0, 7.0, -9.0, 4.0));
	var[0][0][1][2] = (vec4(-4.0, -4.0, -8.0, 9.0));
	var[0][1][0][0] = (vec4(7.0, 4.0, -2.0, -4.0));
	var[0][1][0][1] = (vec4(6.0, -9.0, -7.0, 3.0));
	var[0][1][0][2] = (vec4(-3.0, -6.0, -1.0, 0.0));
	var[0][1][1][0] = (vec4(2.0, 3.0, -1.0, 9.0));
	var[0][1][1][1] = (vec4(-3.0, -9.0, -1.0, 0.0));
	var[0][1][1][2] = (vec4(-9.0, 1.0, 6.0, 5.0));
	var[0][2][0][0] = (vec4(7.0, 5.0, 1.0, 8.0));
	var[0][2][0][1] = (vec4(-4.0, 6.0, -3.0, -6.0));
	var[0][2][0][2] = (vec4(2.0, -9.0, -8.0, 6.0));
	var[0][2][1][0] = (vec4(-7.0, 0.0, 5.0, 8.0));
	var[0][2][1][1] = (vec4(9.0, 8.0, -6.0, -2.0));
	var[0][2][1][2] = (vec4(9.0, -5.0, 4.0, -4.0));
	var[0][3][0][0] = (vec4(-1.0, -1.0, -9.0, -5.0));
	var[0][3][0][1] = (vec4(6.0, 2.0, -2.0, 8.0));
	var[0][3][0][2] = (vec4(9.0, 2.0, -4.0, 7.0));
	var[0][3][1][0] = (vec4(-8.0, -7.0, 8.0, -8.0));
	var[0][3][1][1] = (vec4(-5.0, 2.0, -3.0, 5.0));
	var[0][3][1][2] = (vec4(-3.0, -2.0, -5.0, 3.0));
	var[1][0][0][0] = (vec4(2.0, -7.0, 2.0, -6.0));
	var[1][0][0][1] = (vec4(-1.0, -7.0, 7.0, 1.0));
	var[1][0][0][2] = (vec4(0.0, 4.0, 1.0, -9.0));
	var[1][0][1][0] = (vec4(3.0, -3.0, 5.0, 9.0));
	var[1][0][1][1] = (vec4(4.0, -2.0, -3.0, -6.0));
	var[1][0][1][2] = (vec4(8.0, 9.0, -9.0, -5.0));
	var[1][1][0][0] = (vec4(-8.0, 4.0, -8.0, 5.0));
	var[1][1][0][1] = (vec4(4.0, 3.0, -7.0, 5.0));
	var[1][1][0][2] = (vec4(-4.0, 7.0, 2.0, -6.0));
	var[1][1][1][0] = (vec4(-2.0, 4.0, -9.0, -3.0));
	var[1][1][1][1] = (vec4(7.0, 5.0, -1.0, 1.0));
	var[1][1][1][2] = (vec4(6.0, -2.0, -5.0, 9.0));
	var[1][2][0][0] = (vec4(-5.0, -1.0, -2.0, -8.0));
	var[1][2][0][1] = (vec4(-2.0, 5.0, -5.0, 9.0));
	var[1][2][0][2] = (vec4(7.0, -5.0, -3.0, 0.0));
	var[1][2][1][0] = (vec4(-5.0, -6.0, 7.0, 0.0));
	var[1][2][1][1] = (vec4(7.0, -8.0, -6.0, 0.0));
	var[1][2][1][2] = (vec4(7.0, -9.0, 2.0, 3.0));
	var[1][3][0][0] = (vec4(-3.0, 8.0, -3.0, -6.0));
	var[1][3][0][1] = (vec4(-4.0, 6.0, -2.0, -2.0));
	var[1][3][0][2] = (vec4(-4.0, -3.0, -1.0, -3.0));
	var[1][3][1][0] = (vec4(7.0, 9.0, -4.0, 8.0));
	var[1][3][1][1] = (vec4(-6.0, 4.0, -4.0, -8.0));
	var[1][3][1][2] = (vec4(1.0, 2.0, 2.0, -4.0));
	var[2][0][0][0] = (vec4(3.0, 4.0, -1.0, -5.0));
	var[2][0][0][1] = (vec4(9.0, -2.0, 4.0, -9.0));
	var[2][0][0][2] = (vec4(1.0, -8.0, -2.0, 1.0));
	var[2][0][1][0] = (vec4(-8.0, -2.0, 9.0, 8.0));
	var[2][0][1][1] = (vec4(-5.0, -8.0, -2.0, 7.0));
	var[2][0][1][2] = (vec4(-3.0, -9.0, 0.0, -9.0));
	var[2][1][0][0] = (vec4(-6.0, 2.0, 5.0, -5.0));
	var[2][1][0][1] = (vec4(2.0, 4.0, -3.0, 1.0));
	var[2][1][0][2] = (vec4(9.0, -1.0, -1.0, -1.0));
	var[2][1][1][0] = (vec4(7.0, -4.0, -7.0, -3.0));
	var[2][1][1][1] = (vec4(9.0, -7.0, -5.0, -9.0));
	var[2][1][1][2] = (vec4(3.0, 9.0, 2.0, -5.0));
	var[2][2][0][0] = (vec4(6.0, -9.0, -7.0, 6.0));
	var[2][2][0][1] = (vec4(0.0, 2.0, 9.0, -1.0));
	var[2][2][0][2] = (vec4(3.0, -4.0, 9.0, -2.0));
	var[2][2][1][0] = (vec4(-4.0, 6.0, 1.0, -2.0));
	var[2][2][1][1] = (vec4(-4.0, 3.0, 1.0, -1.0));
	var[2][2][1][2] = (vec4(9.0, -4.0, -1.0, 3.0));
	var[2][3][0][0] = (vec4(-1.0, -9.0, 2.0, 6.0));
	var[2][3][0][1] = (vec4(5.0, 9.0, 3.0, -7.0));
	var[2][3][0][2] = (vec4(7.0, -8.0, -1.0, -8.0));
	var[2][3][1][0] = (vec4(3.0, -4.0, 6.0, -5.0));
	var[2][3][1][1] = (vec4(-5.0, 3.0, 5.0, -2.0));
	var[2][3][1][2] = (vec4(-3.0, 2.0, 1.0, 6.0));
}
#version 450
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
	allOk = compare_mat2x3(var[0][0][0], mat2x3(-3.0, 6.0, -6.0, -6.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][1], mat2x3(8.0, 3.0, 1.0, 4.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][0], mat2x3(6.0, 8.0, -4.0, -5.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][1], mat2x3(6.0, 6.0, -9.0, -2.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[0][2][0], mat2x3(-5.0, 3.0, -2.0, -8.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[0][2][1], mat2x3(1.0, -5.0, -5.0, -2.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[0][3][0], mat2x3(-2.0, -7.0, 9.0, 9.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[0][3][1], mat2x3(0.0, -6.0, -7.0, 2.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][0], mat2x3(-7.0, -5.0, -8.0, -7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][1], mat2x3(3.0, 6.0, -5.0, 3.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][0], mat2x3(5.0, -3.0, 6.0, 3.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][1], mat2x3(-9.0, -2.0, -3.0, -1.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[1][2][0], mat2x3(-2.0, 0.0, 7.0, 6.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[1][2][1], mat2x3(3.0, 9.0, 1.0, 3.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[1][3][0], mat2x3(3.0, 6.0, -6.0, -5.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[1][3][1], mat2x3(7.0, 0.0, -9.0, 4.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][0], mat2x3(9.0, 2.0, 6.0, 8.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][1], mat2x3(-7.0, -2.0, -4.0, -2.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][0], mat2x3(0.0, 2.0, -1.0, -4.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][1], mat2x3(-9.0, -7.0, 7.0, 0.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[2][2][0], mat2x3(-9.0, -2.0, 6.0, 8.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[2][2][1], mat2x3(5.0, -2.0, 0.0, 0.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[2][3][0], mat2x3(-9.0, 8.0, 7.0, -9.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[2][3][1], mat2x3(-9.0, 3.0, 1.0, -2.0, 9.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2x3(-1.0, -2.0, -5.0, 0.0, 7.0, -2.0));
	var[0][0][1] = (mat2x3(0.0, 9.0, 9.0, 8.0, -6.0, 3.0));
	var[0][1][0] = (mat2x3(7.0, -3.0, 2.0, 8.0, -1.0, 2.0));
	var[0][1][1] = (mat2x3(2.0, -9.0, 3.0, 1.0, -7.0, -7.0));
	var[0][2][0] = (mat2x3(-9.0, 1.0, 2.0, -3.0, 0.0, -3.0));
	var[0][2][1] = (mat2x3(-2.0, 3.0, -2.0, 5.0, -6.0, -7.0));
	var[0][3][0] = (mat2x3(-1.0, -2.0, 6.0, 9.0, 1.0, -6.0));
	var[0][3][1] = (mat2x3(6.0, 6.0, 5.0, 3.0, 4.0, 7.0));
	var[1][0][0] = (mat2x3(-9.0, 0.0, 1.0, 1.0, 7.0, -8.0));
	var[1][0][1] = (mat2x3(7.0, -4.0, 4.0, -5.0, -1.0, 0.0));
	var[1][1][0] = (mat2x3(3.0, -3.0, -5.0, 4.0, -6.0, 8.0));
	var[1][1][1] = (mat2x3(7.0, -9.0, 2.0, -8.0, 9.0, 9.0));
	var[1][2][0] = (mat2x3(-7.0, 3.0, -4.0, -6.0, -2.0, 6.0));
	var[1][2][1] = (mat2x3(-7.0, -3.0, 3.0, -9.0, 3.0, 8.0));
	var[1][3][0] = (mat2x3(0.0, 9.0, -5.0, 3.0, -7.0, 1.0));
	var[1][3][1] = (mat2x3(0.0, 6.0, 0.0, 6.0, 4.0, -1.0));
	var[2][0][0] = (mat2x3(2.0, -5.0, 6.0, 7.0, -2.0, 4.0));
	var[2][0][1] = (mat2x3(-3.0, 7.0, 6.0, -3.0, -2.0, -6.0));
	var[2][1][0] = (mat2x3(3.0, 5.0, 8.0, 5.0, -7.0, 6.0));
	var[2][1][1] = (mat2x3(3.0, 6.0, 6.0, 1.0, 2.0, -7.0));
	var[2][2][0] = (mat2x3(-1.0, 7.0, 4.0, -9.0, -7.0, 2.0));
	var[2][2][1] = (mat2x3(1.0, -7.0, -2.0, 5.0, -6.0, -6.0));
	var[2][3][0] = (mat2x3(-2.0, 2.0, 3.0, 8.0, 3.0, -5.0));
	var[2][3][1] = (mat2x3(1.0, -6.0, -1.0, 5.0, 9.0, -6.0));
}
#version 450
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
	i8vec2 var[][4][2];
};

bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(var[0][0][0]), ivec2(4294967288, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(var[0][0][1]), ivec2(1, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(var[0][1][0]), ivec2(4294967287, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(var[0][1][1]), ivec2(6, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(var[0][2][0]), ivec2(9, 3)) && allOk;
	allOk = compare_i8vec2(ivec2(var[0][2][1]), ivec2(2, 6)) && allOk;
	allOk = compare_i8vec2(ivec2(var[0][3][0]), ivec2(7, 4294967292)) && allOk;
	allOk = compare_i8vec2(ivec2(var[0][3][1]), ivec2(1, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][0][0]), ivec2(0, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][0][1]), ivec2(4294967288, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][1][0]), ivec2(3, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][1][1]), ivec2(1, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][2][0]), ivec2(4294967290, 4294967289)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][2][1]), ivec2(5, 4294967289)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][3][0]), ivec2(2, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][3][1]), ivec2(0, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][0][0]), ivec2(4294967290, 4294967287)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][0][1]), ivec2(4294967289, 2)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][1][0]), ivec2(6, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][1][1]), ivec2(3, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][2][0]), ivec2(8, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][2][1]), ivec2(4294967294, 4294967288)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][3][0]), ivec2(4294967289, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][3][1]), ivec2(7, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = i8vec2(ivec2(0, 8));
	var[0][0][1] = i8vec2(ivec2(4294967292, 9));
	var[0][1][0] = i8vec2(ivec2(4294967293, 4294967293));
	var[0][1][1] = i8vec2(ivec2(4294967290, 3));
	var[0][2][0] = i8vec2(ivec2(4294967293, 0));
	var[0][2][1] = i8vec2(ivec2(3, 4294967291));
	var[0][3][0] = i8vec2(ivec2(4294967292, 4294967292));
	var[0][3][1] = i8vec2(ivec2(3, 4294967294));
	var[1][0][0] = i8vec2(ivec2(4294967294, 4294967295));
	var[1][0][1] = i8vec2(ivec2(8, 4294967290));
	var[1][1][0] = i8vec2(ivec2(4294967295, 8));
	var[1][1][1] = i8vec2(ivec2(5, 8));
	var[1][2][0] = i8vec2(ivec2(4294967295, 4294967292));
	var[1][2][1] = i8vec2(ivec2(5, 4294967292));
	var[1][3][0] = i8vec2(ivec2(8, 4));
	var[1][3][1] = i8vec2(ivec2(8, 6));
	var[2][0][0] = i8vec2(ivec2(8, 4294967289));
	var[2][0][1] = i8vec2(ivec2(7, 4294967294));
	var[2][1][0] = i8vec2(ivec2(4294967293, 4294967292));
	var[2][1][1] = i8vec2(ivec2(4294967287, 6));
	var[2][2][0] = i8vec2(ivec2(4294967291, 4));
	var[2][2][1] = i8vec2(ivec2(0, 4294967293));
	var[2][3][0] = i8vec2(ivec2(5, 4294967294));
	var[2][3][1] = i8vec2(ivec2(4294967288, 4294967292));
}
#version 450
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
layout(std430, binding = 1) buffer Block
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
	allOk = compare_ivec3((block[0].s.a), ivec3(5, -4, -3)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(4.0, 9.0, 7.0, 0.0, 8.0, -5.0, -9.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(8.0, 0.0, 8.0, 8.0, -4.0, 8.0, -8.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(-2.0, -3.0, -7.0, 4.0, -8.0, 8.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(2.0, 1.0, 6.0, 1.0, 5.0, -8.0, -9.0, 3.0, 5.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(6.0, -3.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat3(block[0].t.a, mat3(8.0, -1.0, 2.0, -4.0, -3.0, -8.0, 8.0, 6.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[0].t.b.a), ivec3(-8, -5, -5)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[0], mat3(7.0, -5.0, 5.0, -6.0, -7.0, 1.0, 0.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[1], mat3(-7.0, 9.0, 0.0, 4.0, -1.0, 1.0, -8.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[2], mat3(-9.0, -3.0, -1.0, -2.0, -9.0, -1.0, -7.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[3], mat3(0.0, -6.0, -3.0, -2.0, -2.0, 0.0, -2.0, 9.0, -7.0)) && allOk;
	allOk = compare_vec4((block[0].t.b.c), vec4(6.0, 4.0, -2.0, -3.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(-5, 1, 9)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(3.0, -3.0, 8.0, -1.0, -9.0, -6.0, -5.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(1.0, -2.0, -5.0, 2.0, 8.0, -5.0, -8.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(9.0, 7.0, 4.0, -5.0, 0.0, 1.0, -4.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(-3.0, -1.0, 5.0, -1.0, -8.0, -2.0, -7.0, -8.0, 3.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(8.0, -7.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3(block[1].t.a, mat3(1.0, -6.0, -6.0, 5.0, -4.0, 4.0, 8.0, 5.0, -7.0)) && allOk;
	allOk = compare_ivec3((block[1].t.b.a), ivec3(-8, 3, -8)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[0], mat3(-2.0, 1.0, -6.0, -9.0, 6.0, 9.0, 9.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[1], mat3(-2.0, -5.0, -8.0, 7.0, 9.0, -6.0, 9.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[2], mat3(4.0, 6.0, -7.0, -6.0, 1.0, 9.0, -1.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[3], mat3(-9.0, -8.0, 6.0, 4.0, -4.0, -1.0, 0.0, -9.0, 3.0)) && allOk;
	allOk = compare_vec4((block[1].t.b.c), vec4(-8.0, 8.0, 6.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(3, 1, -1)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(8.0, 5.0, 2.0, -7.0, -6.0, -6.0, -7.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(8.0, 3.0, 1.0, 7.0, 4.0, -3.0, 1.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(-1.0, -6.0, 4.0, 8.0, 7.0, -7.0, 4.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(5.0, 0.0, 7.0, -4.0, -1.0, 3.0, 3.0, 0.0, 6.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(6.0, -1.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat3(block[2].t.a, mat3(4.0, 3.0, -4.0, -2.0, 7.0, 0.0, -2.0, 9.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[2].t.b.a), ivec3(-3, -5, 3)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[0], mat3(-4.0, 3.0, 9.0, 2.0, -4.0, 8.0, -9.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[1], mat3(-5.0, 1.0, 9.0, 8.0, -8.0, 5.0, 8.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[2], mat3(6.0, 5.0, 5.0, 4.0, 5.0, -7.0, -1.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[3], mat3(1.0, -7.0, 8.0, -3.0, -6.0, 9.0, -7.0, 2.0, 9.0)) && allOk;
	allOk = compare_vec4((block[2].t.b.c), vec4(5.0, -5.0, -6.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].t.a[0] = (vec3(5.0, -4.0, 7.0));
	block[0].t.a[1] = (vec3(-2.0, 8.0, 4.0));
	block[0].t.a[2] = (vec3(8.0, -5.0, -8.0));
	block[0].t.b.a = (ivec3(6, -5, -9));
	block[0].t.b.b[0][0] = (vec3(-5.0, -7.0, 2.0));
	block[0].t.b.b[0][1] = (vec3(0.0, 0.0, 0.0));
	block[0].t.b.b[0][2] = (vec3(1.0, -9.0, 0.0));
	block[0].t.b.b[1][0] = (vec3(7.0, 9.0, -3.0));
	block[0].t.b.b[1][1] = (vec3(5.0, 9.0, 5.0));
	block[0].t.b.b[1][2] = (vec3(-1.0, -7.0, -8.0));
	block[0].t.b.b[2][0] = (vec3(1.0, 8.0, -7.0));
	block[0].t.b.b[2][1] = (vec3(8.0, 1.0, 8.0));
	block[0].t.b.b[2][2] = (vec3(0.0, -4.0, -7.0));
	block[0].t.b.b[3][0] = (vec3(-3.0, 1.0, -1.0));
	block[0].t.b.b[3][1] = (vec3(-2.0, 2.0, 2.0));
	block[0].t.b.b[3][2] = (vec3(-2.0, 3.0, -9.0));
	block[0].t.b.c = (vec4(7.0, -7.0, -7.0, 7.0));
	block[0].u = (4u);
	block[1].t.a[0] = (vec3(-4.0, 2.0, 6.0));
	block[1].t.a[1] = (vec3(9.0, -6.0, 4.0));
	block[1].t.a[2] = (vec3(6.0, -5.0, -2.0));
	block[1].t.b.a = (ivec3(0, 1, -5));
	block[1].t.b.b[0][0] = (vec3(2.0, 6.0, 6.0));
	block[1].t.b.b[0][1] = (vec3(-1.0, -2.0, 4.0));
	block[1].t.b.b[0][2] = (vec3(9.0, -9.0, -1.0));
	block[1].t.b.b[1][0] = (vec3(1.0, 5.0, 3.0));
	block[1].t.b.b[1][1] = (vec3(-8.0, -1.0, 2.0));
	block[1].t.b.b[1][2] = (vec3(7.0, 4.0, 6.0));
	block[1].t.b.b[2][0] = (vec3(-4.0, -9.0, -4.0));
	block[1].t.b.b[2][1] = (vec3(4.0, 1.0, -8.0));
	block[1].t.b.b[2][2] = (vec3(-8.0, -3.0, 7.0));
	block[1].t.b.b[3][0] = (vec3(9.0, -1.0, 2.0));
	block[1].t.b.b[3][1] = (vec3(7.0, 0.0, -4.0));
	block[1].t.b.b[3][2] = (vec3(-4.0, 5.0, 7.0));
	block[1].t.b.c = (vec4(7.0, 8.0, 2.0, 2.0));
	block[1].u = (4u);
	block[2].t.a[0] = (vec3(6.0, -5.0, -5.0));
	block[2].t.a[1] = (vec3(-5.0, -9.0, 9.0));
	block[2].t.a[2] = (vec3(-6.0, -3.0, 6.0));
	block[2].t.b.a = (ivec3(4, -1, -9));
	block[2].t.b.b[0][0] = (vec3(-5.0, -2.0, 5.0));
	block[2].t.b.b[0][1] = (vec3(2.0, 9.0, -3.0));
	block[2].t.b.b[0][2] = (vec3(8.0, -1.0, 3.0));
	block[2].t.b.b[1][0] = (vec3(4.0, 5.0, 3.0));
	block[2].t.b.b[1][1] = (vec3(1.0, 6.0, -9.0));
	block[2].t.b.b[1][2] = (vec3(-1.0, 5.0, 8.0));
	block[2].t.b.b[2][0] = (vec3(-2.0, -1.0, 9.0));
	block[2].t.b.b[2][1] = (vec3(9.0, -5.0, 6.0));
	block[2].t.b.b[2][2] = (vec3(9.0, -5.0, -5.0));
	block[2].t.b.b[3][0] = (vec3(-8.0, 8.0, -7.0));
	block[2].t.b.b[3][1] = (vec3(-3.0, -9.0, -3.0));
	block[2].t.b.b[3][2] = (vec3(7.0, 0.0, 1.0));
	block[2].t.b.c = (vec4(-4.0, 6.0, -9.0, -7.0));
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

layout(std140, binding = 1) buffer Block
{
	i16vec4 var;
} block[3];

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

layout(std140, binding = 1) buffer Block
{
	f16vec4 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(block[0].var), vec4(-8.0, -9.0, 9.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(block[1].var), vec4(4.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_f16vec4(vec4(block[2].var), vec4(-8.0, 6.0, 1.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = f16vec4(vec4(9.0, -6.0, 2.0, -8.0));
	block[1].var = f16vec4(vec4(-7.0, -4.0, 2.0, -5.0));
	block[2].var = f16vec4(vec4(9.0, 1.0, -6.0, 3.0));
}
#version 450
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
	highp mat3x4 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(block[0].var, mat3x4(9.0, -4.0, -6.0, 2.0, -9.0, -8.0, 7.0, 0.0, 5.0, 3.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block[1].var, mat3x4(9.0, -7.0, 0.0, 6.0, -3.0, 8.0, 6.0, -6.0, -6.0, -4.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block[2].var, mat3x4(-7.0, 5.0, -6.0, 7.0, -4.0, -9.0, -9.0, -4.0, -8.0, -8.0, 3.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat3x4(3.0, -9.0, -6.0, 7.0, 6.0, -8.0, -1.0, 1.0, -9.0, 7.0, 6.0, 6.0));
	block[1].var = (mat3x4(-5.0, -1.0, -8.0, 3.0, 9.0, 9.0, -8.0, 0.0, 0.0, -9.0, -6.0, -7.0));
	block[2].var = (mat3x4(-3.0, -3.0, 9.0, -7.0, 4.0, 2.0, -8.0, 4.0, -6.0, -1.0, -9.0, 5.0));
}
#version 450
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
} block[3];

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(block[0].var), 4294967292) && allOk;
	allOk = compare_int8_t(int(block[1].var), 3) && allOk;
	allOk = compare_int8_t(int(block[2].var), 3) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = int8_t(4294967290);
	block[1].var = int8_t(4294967294);
	block[2].var = int8_t(3);
}
#version 450
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
	highp mat2x3 var;
} block[3];

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
	allOk = compare_float((block[0].padding), 7.0) && allOk;
	allOk = compare_float(block[0].var[0][0], 3.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 1.0) && allOk;
	allOk = compare_float(block[0].var[0][2], -7.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 1.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -4.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 0.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 9.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 9.0) && allOk;
	allOk = compare_float(block[0].var[2][2], -4.0) && allOk;
	allOk = compare_float(block[0].var[3][0], -2.0) && allOk;
	allOk = compare_float(block[0].var[3][1], 6.0) && allOk;
	allOk = compare_float(block[0].var[3][2], 3.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(3.0, 1.0, -7.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(1.0, -4.0, 0.0)) && allOk;
	allOk = compare_vec3(block[0].var[2], vec3(9.0, 9.0, -4.0)) && allOk;
	allOk = compare_vec3(block[0].var[3], vec3(-2.0, 6.0, 3.0)) && allOk;
	allOk = compare_float((block[1].padding), 6.0) && allOk;
	allOk = compare_float(block[1].var[0][0], 3.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 6.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -4.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 8.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 5.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 4.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 2.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 2.0) && allOk;
	allOk = compare_float(block[1].var[2][2], -6.0) && allOk;
	allOk = compare_float(block[1].var[3][0], 6.0) && allOk;
	allOk = compare_float(block[1].var[3][1], 0.0) && allOk;
	allOk = compare_float(block[1].var[3][2], -4.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(3.0, 6.0, -4.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(8.0, 5.0, 4.0)) && allOk;
	allOk = compare_vec3(block[1].var[2], vec3(2.0, 2.0, -6.0)) && allOk;
	allOk = compare_vec3(block[1].var[3], vec3(6.0, 0.0, -4.0)) && allOk;
	allOk = compare_float((block[2].padding), -5.0) && allOk;
	allOk = compare_float(block[2].var[0][0], -2.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -5.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 8.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -5.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 4.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -7.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 1.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 2.0) && allOk;
	allOk = compare_float(block[2].var[2][2], 8.0) && allOk;
	allOk = compare_float(block[2].var[3][0], 9.0) && allOk;
	allOk = compare_float(block[2].var[3][1], -7.0) && allOk;
	allOk = compare_float(block[2].var[3][2], 0.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(-2.0, -5.0, 8.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(-5.0, 4.0, -7.0)) && allOk;
	allOk = compare_vec3(block[2].var[2], vec3(1.0, 2.0, 8.0)) && allOk;
	allOk = compare_vec3(block[2].var[3], vec3(9.0, -7.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (7.0);
	block[0].var[0] = (vec3(-6.0, 3.0, -3.0));
	block[0].var[1] = (vec3(9.0, -2.0, 3.0));
	block[0].var[2] = (vec3(9.0, -9.0, 7.0));
	block[0].var[3] = (vec3(4.0, -4.0, 5.0));
	block[1].padding = (-1.0);
	block[1].var[0] = (vec3(-4.0, 6.0, 4.0));
	block[1].var[1] = (vec3(-8.0, 7.0, 3.0));
	block[1].var[2] = (vec3(1.0, -9.0, -4.0));
	block[1].var[3] = (vec3(-2.0, 6.0, 9.0));
	block[2].padding = (9.0);
	block[2].var[0] = (vec3(8.0, 2.0, 4.0));
	block[2].var[1] = (vec3(-9.0, 8.0, 2.0));
	block[2].var[2] = (vec3(2.0, 2.0, -8.0));
	block[2].var[3] = (vec3(-7.0, 3.0, 0.0));
}
#version 450
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
	int8_t var;
} block[3];

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(block[0].var), 4294967292) && allOk;
	allOk = compare_int8_t(int(block[1].var), 3) && allOk;
	allOk = compare_int8_t(int(block[2].var), 3) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = int8_t(4294967290);
	block[1].var = int8_t(4294967294);
	block[2].var = int8_t(3);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(binding = 1) buffer BlockA
{
	layout(offset = 0) highp float a;
	layout(offset = 4) lowp uvec3 b;
	layout(offset = 16) mediump mat2 c;
} blockA[3];
layout(binding = 2) buffer BlockB
{
	layout(offset = 0) mediump mat3 a;
	layout(offset = 48) lowp ivec2 b;
	layout(offset = 64) highp vec4 c;
	layout(offset = 80) bool d;
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
	allOk = compare_float((blockA[0].a), 8.0) && allOk;
	allOk = compare_float(blockA[0].c[0][0], 9.0) && allOk;
	allOk = compare_float(blockA[0].c[0][1], -2.0) && allOk;
	allOk = compare_float(blockA[0].c[1][0], -5.0) && allOk;
	allOk = compare_float(blockA[0].c[1][1], 0.0) && allOk;
	allOk = compare_vec2(blockA[0].c[0], vec2(9.0, -2.0)) && allOk;
	allOk = compare_vec2(blockA[0].c[1], vec2(-5.0, 0.0)) && allOk;
	allOk = compare_float((blockA[1].a), -3.0) && allOk;
	allOk = compare_float(blockA[1].c[0][0], -2.0) && allOk;
	allOk = compare_float(blockA[1].c[0][1], -4.0) && allOk;
	allOk = compare_float(blockA[1].c[1][0], -9.0) && allOk;
	allOk = compare_float(blockA[1].c[1][1], 1.0) && allOk;
	allOk = compare_vec2(blockA[1].c[0], vec2(-2.0, -4.0)) && allOk;
	allOk = compare_vec2(blockA[1].c[1], vec2(-9.0, 1.0)) && allOk;
	allOk = compare_float((blockA[2].a), 5.0) && allOk;
	allOk = compare_float(blockA[2].c[0][0], -4.0) && allOk;
	allOk = compare_float(blockA[2].c[0][1], 4.0) && allOk;
	allOk = compare_float(blockA[2].c[1][0], -8.0) && allOk;
	allOk = compare_float(blockA[2].c[1][1], 3.0) && allOk;
	allOk = compare_vec2(blockA[2].c[0], vec2(-4.0, 4.0)) && allOk;
	allOk = compare_vec2(blockA[2].c[1], vec2(-8.0, 3.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b), ivec2(-5, -3)) && allOk;
	allOk = compare_bool((blockB[0].d), false) && allOk;
	allOk = compare_ivec2((blockB[1].b), ivec2(-3, 7)) && allOk;
	allOk = compare_bool((blockB[1].d), true) && allOk;
	allOk = compare_ivec2((blockB[2].b), ivec2(-6, -1)) && allOk;
	allOk = compare_bool((blockB[2].d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (4.0);
	blockA[1].a = (0.0);
	blockA[2].a = (-2.0);
	blockB[0].a[0] = (vec3(5.0, -8.0, -7.0));
	blockB[0].a[1] = (vec3(-7.0, 0.0, 2.0));
	blockB[0].a[2] = (vec3(8.0, -6.0, 4.0));
	blockB[0].d = (false);
	blockB[1].a[0] = (vec3(5.0, -1.0, -7.0));
	blockB[1].a[1] = (vec3(-2.0, -1.0, -7.0));
	blockB[1].a[2] = (vec3(7.0, -9.0, -2.0));
	blockB[1].d = (false);
	blockB[2].a[0] = (vec3(2.0, -4.0, 5.0));
	blockB[2].a[1] = (vec3(8.0, 5.0, 4.0));
	blockB[2].a[2] = (vec3(7.0, -9.0, -4.0));
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

layout(std140, binding = 1) buffer BlockB
{
	bool a;
};
layout(std430, binding = 2) buffer BlockC
{
	lowp float b;
	mediump int c;
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	mediump int d;
	bool e;
	lowp int f;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((a), true) && allOk;
	allOk = compare_int((blockC.c), -4) && allOk;
	allOk = compare_int((d), 4) && allOk;
	allOk = compare_int((f), -5) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (true);
	blockC.b = (-2.0);
	blockC.c = (6);
	d = (0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, row_major, binding = 1) readonly buffer BlockB
{
	highp mat4x2 a;
};
layout(std140, binding = 2) readonly buffer BlockC
{
	highp vec3 b;
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	mediump mat3 c;
} blockD;
layout(std140, row_major, binding = 4) buffer BlockE
{
	mediump ivec2 d;
	lowp mat4 e;
	mediump mat3x2 f;
	bvec4 g[1];
	mediump float h;
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
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(a, mat4x2(1.0, 2.0, -6.0, -1.0, -5.0, 4.0, 7.0, 1.0)) && allOk;
	allOk = compare_vec3((blockC.b), vec3(-8.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat3(blockD.c, mat3(-7.0, 3.0, 8.0, 1.0, 9.0, 5.0, -4.0, 1.0, -4.0)) && allOk;
	allOk = compare_ivec2((d), ivec2(-4, -3)) && allOk;
	allOk = compare_bvec4((g[0]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_float((h), -9.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockD.c = (mat3(0.0, 0.0, 6.0, -6.0, -5.0, 2.0, 3.0, 0.0, 4.0));
	e = (mat4(1.0, 4.0, -8.0, -3.0, -6.0, -4.0, 1.0, 2.0, 2.0, -7.0, -1.0, 0.0, -1.0, 8.0, -6.0, -6.0));
	f = (mat3x2(-5.0, -7.0, -6.0, 0.0, 6.0, -9.0));
	g[0] = (bvec4(true, true, true, true));
}
#version 450
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
	lowp float a;
	lowp mat3 b;
	highp int c[];
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	lowp uvec4 d;
	mediump uvec4 e;
	mediump ivec3 f;
	mediump mat4 g[1];
	highp mat4 h[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((d), uvec4(9u, 9u, 1u, 8u)) && allOk;
	allOk = compare_mat4(g[0], mat4(-1.0, 9.0, -8.0, -1.0, -5.0, -5.0, 4.0, 4.0, 5.0, 1.0, -8.0, -9.0, 3.0, 8.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4(h[0], mat4(1.0, 0.0, 9.0, 3.0, -4.0, 6.0, -3.0, 3.0, 7.0, 8.0, 2.0, -7.0, -6.0, 5.0, 2.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat3(-4.0, 2.0, 2.0, 4.0, 9.0, -2.0, -4.0, -9.0, -2.0));
	blockB.c[0] = (0);
	d = (uvec4(0u, 8u, 2u, 7u));
	f = (ivec3(4, 7, 3));
	g[0] = (mat4(-2.0, -5.0, -2.0, -5.0, 9.0, 5.0, -4.0, 4.0, 0.0, 5.0, -4.0, -3.0, 6.0, -5.0, -9.0, -8.0));
}
#version 450
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
	mediump mat3 mA;
	highp mat4x2 mB;
	mediump mat3x4 mC[7];
	mediump uint mD;
};
struct sB
{
	lowp int mA;
	bvec2 mB;
	sA mC[5];
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	mediump vec2 a;
	highp mat4 b;
	highp uvec4 c;
	lowp mat4x2 d[3];
} blockB[1];
layout(std430, row_major, binding = 2) buffer BlockC
{
	highp mat2x3 e;
	lowp vec4 f;
	bvec4 g;
} blockC[2];
layout(std140, binding = 3) buffer BlockD
{
	sB h;
	lowp float i;
	bool j;
	lowp ivec4 k[];
} blockD[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB[0].d[0], mat4x2(9.0, 2.0, -5.0, 1.0, -6.0, 8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(blockB[0].d[1], mat4x2(-3.0, 3.0, 1.0, -9.0, 7.0, -2.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat4x2(blockB[0].d[2], mat4x2(-3.0, 3.0, 1.0, 1.0, -9.0, -3.0, -9.0, -7.0)) && allOk;
	allOk = compare_vec4((blockC[0].f), vec4(-4.0, 0.0, 1.0, -3.0)) && allOk;
	allOk = compare_vec4((blockC[1].f), vec4(1.0, -8.0, -9.0, 5.0)) && allOk;
	allOk = compare_int((blockD[0].h.mA), 4) && allOk;
	allOk = compare_bvec2((blockD[0].h.mB), bvec2(true, false)) && allOk;
	allOk = compare_mat3(blockD[0].h.mC[0].mA, mat3(6.0, -3.0, 4.0, -7.0, 1.0, -5.0, -9.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat4x2(blockD[0].h.mC[0].mB, mat4x2(6.0, -3.0, -4.0, 5.0, -9.0, 6.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[0].mC[0], mat3x4(-6.0, 4.0, -8.0, 7.0, 1.0, -6.0, 8.0, 4.0, -4.0, 6.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[0].mC[1], mat3x4(-2.0, -7.0, 4.0, 1.0, -2.0, 4.0, -3.0, 6.0, 1.0, -2.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[0].mC[2], mat3x4(-8.0, -6.0, -5.0, 7.0, 5.0, -6.0, 5.0, -5.0, 3.0, -8.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[0].mC[3], mat3x4(-9.0, 7.0, 5.0, -8.0, 9.0, -8.0, -7.0, 9.0, -9.0, 2.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[0].mC[4], mat3x4(-1.0, 7.0, -7.0, 9.0, -1.0, 7.0, 7.0, -6.0, 9.0, -4.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[0].mC[5], mat3x4(4.0, 1.0, -6.0, -2.0, -8.0, 6.0, 6.0, 2.0, 9.0, 7.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[0].mC[6], mat3x4(8.0, -3.0, -5.0, 7.0, -3.0, -5.0, 7.0, -2.0, 1.0, -9.0, 5.0, 9.0)) && allOk;
	allOk = compare_uint((blockD[0].h.mC[0].mD), 2u) && allOk;
	allOk = compare_mat3(blockD[0].h.mC[1].mA, mat3(-8.0, -2.0, -1.0, -1.0, -7.0, -9.0, 2.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat4x2(blockD[0].h.mC[1].mB, mat4x2(7.0, 7.0, 1.0, -8.0, 7.0, 1.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[1].mC[0], mat3x4(-1.0, 9.0, 0.0, -1.0, 7.0, 5.0, -2.0, 0.0, -2.0, 2.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[1].mC[1], mat3x4(-9.0, 4.0, 2.0, 6.0, 2.0, -1.0, -8.0, 8.0, 0.0, -7.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[1].mC[2], mat3x4(3.0, 6.0, 3.0, -3.0, -2.0, 0.0, 4.0, 4.0, -2.0, 8.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[1].mC[3], mat3x4(-2.0, 0.0, -5.0, 4.0, 9.0, -6.0, -1.0, 8.0, 5.0, 0.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[1].mC[4], mat3x4(5.0, 1.0, 7.0, -3.0, -8.0, -5.0, 6.0, -9.0, 6.0, -4.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[1].mC[5], mat3x4(2.0, 9.0, 2.0, -5.0, 8.0, -6.0, 3.0, -9.0, 4.0, -4.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[1].mC[6], mat3x4(4.0, 0.0, 4.0, 5.0, -7.0, 7.0, 6.0, 4.0, -7.0, -9.0, -1.0, 7.0)) && allOk;
	allOk = compare_uint((blockD[0].h.mC[1].mD), 4u) && allOk;
	allOk = compare_mat3(blockD[0].h.mC[2].mA, mat3(-2.0, 2.0, -3.0, 7.0, 7.0, -3.0, -2.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat4x2(blockD[0].h.mC[2].mB, mat4x2(-4.0, -8.0, 9.0, -4.0, 8.0, 8.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[2].mC[0], mat3x4(-4.0, 1.0, -8.0, 1.0, 7.0, 2.0, 3.0, -6.0, 3.0, -3.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[2].mC[1], mat3x4(7.0, 4.0, -9.0, 5.0, 5.0, -2.0, -4.0, 5.0, -9.0, -7.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[2].mC[2], mat3x4(9.0, 9.0, -7.0, -6.0, 1.0, 8.0, -2.0, 5.0, 6.0, 1.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[2].mC[3], mat3x4(8.0, 0.0, -8.0, -6.0, 6.0, -3.0, 4.0, -5.0, 7.0, 4.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[2].mC[4], mat3x4(1.0, 1.0, -1.0, 6.0, -2.0, -3.0, -6.0, 9.0, 6.0, -9.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[2].mC[5], mat3x4(0.0, -4.0, 6.0, 6.0, -9.0, -2.0, 9.0, 4.0, -7.0, 3.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[2].mC[6], mat3x4(-8.0, 8.0, -1.0, -8.0, 6.0, 4.0, 2.0, -2.0, 1.0, -8.0, -3.0, 0.0)) && allOk;
	allOk = compare_uint((blockD[0].h.mC[2].mD), 4u) && allOk;
	allOk = compare_mat3(blockD[0].h.mC[3].mA, mat3(-6.0, 6.0, 7.0, -1.0, -8.0, -5.0, -2.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4x2(blockD[0].h.mC[3].mB, mat4x2(1.0, -4.0, -2.0, -8.0, -3.0, 4.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[3].mC[0], mat3x4(9.0, -1.0, -4.0, 8.0, 1.0, 1.0, -1.0, -2.0, 6.0, 7.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[3].mC[1], mat3x4(3.0, 8.0, 8.0, 2.0, -4.0, 9.0, 9.0, -6.0, 3.0, -8.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[3].mC[2], mat3x4(5.0, 1.0, -5.0, -3.0, 2.0, -8.0, 2.0, 3.0, -4.0, 2.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[3].mC[3], mat3x4(-9.0, 5.0, -6.0, 0.0, 0.0, -3.0, -9.0, -7.0, -4.0, 5.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[3].mC[4], mat3x4(0.0, 0.0, 6.0, -5.0, -8.0, 7.0, -5.0, -6.0, 6.0, 5.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[3].mC[5], mat3x4(-1.0, 0.0, -5.0, 9.0, -3.0, 5.0, -4.0, -5.0, 9.0, -7.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[3].mC[6], mat3x4(3.0, 2.0, 5.0, 4.0, -2.0, 7.0, 8.0, 3.0, 9.0, 9.0, -9.0, -6.0)) && allOk;
	allOk = compare_uint((blockD[0].h.mC[3].mD), 0u) && allOk;
	allOk = compare_mat3(blockD[0].h.mC[4].mA, mat3(-1.0, -3.0, -7.0, 8.0, -9.0, -6.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(blockD[0].h.mC[4].mB, mat4x2(2.0, -4.0, -1.0, 8.0, -5.0, -5.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[4].mC[0], mat3x4(3.0, -5.0, 0.0, 4.0, 6.0, 3.0, -2.0, 1.0, 3.0, -6.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[4].mC[1], mat3x4(4.0, 9.0, 7.0, -4.0, 7.0, -9.0, 5.0, 8.0, -7.0, 0.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[4].mC[2], mat3x4(-7.0, -9.0, -8.0, -4.0, 1.0, -7.0, 5.0, 8.0, 1.0, -8.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[4].mC[3], mat3x4(-9.0, -7.0, 4.0, 7.0, 8.0, 8.0, 0.0, -1.0, 0.0, -2.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[4].mC[4], mat3x4(2.0, 2.0, -6.0, -4.0, -3.0, 6.0, 4.0, -3.0, 5.0, 7.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[4].mC[5], mat3x4(-7.0, -6.0, 4.0, -2.0, 0.0, -5.0, 1.0, 8.0, 0.0, -3.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].h.mC[4].mC[6], mat3x4(7.0, -3.0, 2.0, 8.0, 7.0, 6.0, 6.0, 3.0, -2.0, -7.0, -4.0, 7.0)) && allOk;
	allOk = compare_uint((blockD[0].h.mC[4].mD), 3u) && allOk;
	allOk = compare_bool((blockD[0].j), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (vec2(2.0, 7.0));
	blockB[0].b = (mat4(-5.0, -4.0, -8.0, -5.0, 0.0, 0.0, -7.0, 5.0, 3.0, 4.0, 7.0, 8.0, 3.0, 8.0, 8.0, 0.0));
	blockB[0].c = (uvec4(7u, 5u, 3u, 1u));
	blockC[0].g = (bvec4(false, true, true, true));
	blockC[1].g = (bvec4(true, false, true, false));
	blockD[0].h.mA = (3);
	blockD[0].h.mB = (bvec2(false, true));
	blockD[0].h.mC[0].mA = (mat3(9.0, -7.0, 2.0, 5.0, 9.0, 3.0, -4.0, 6.0, 4.0));
	blockD[0].h.mC[0].mB = (mat4x2(5.0, 5.0, 6.0, 8.0, 1.0, -8.0, 3.0, -9.0));
	blockD[0].h.mC[0].mC[0] = (mat3x4(5.0, -8.0, 0.0, 5.0, 0.0, -7.0, 7.0, -2.0, 9.0, 8.0, 0.0, 5.0));
	blockD[0].h.mC[0].mC[1] = (mat3x4(-3.0, 8.0, 7.0, 4.0, 7.0, -3.0, 9.0, -4.0, 7.0, -1.0, 5.0, 3.0));
	blockD[0].h.mC[0].mC[2] = (mat3x4(-8.0, 4.0, 2.0, -4.0, 1.0, 6.0, -8.0, -2.0, -6.0, 8.0, -6.0, 2.0));
	blockD[0].h.mC[0].mC[3] = (mat3x4(-5.0, -8.0, -5.0, -4.0, 2.0, 2.0, 2.0, -1.0, -2.0, 6.0, -1.0, 1.0));
	blockD[0].h.mC[0].mC[4] = (mat3x4(-7.0, 3.0, -3.0, 3.0, 4.0, 9.0, 3.0, -7.0, -9.0, -8.0, -7.0, 1.0));
	blockD[0].h.mC[0].mC[5] = (mat3x4(-5.0, -5.0, 6.0, 0.0, 1.0, -6.0, -1.0, -7.0, 0.0, 9.0, -3.0, -4.0));
	blockD[0].h.mC[0].mC[6] = (mat3x4(-9.0, -1.0, -3.0, -9.0, 4.0, 2.0, -2.0, -7.0, 5.0, -4.0, -7.0, -6.0));
	blockD[0].h.mC[0].mD = (6u);
	blockD[0].h.mC[1].mA = (mat3(2.0, 1.0, 2.0, -3.0, 2.0, -2.0, -6.0, 9.0, 3.0));
	blockD[0].h.mC[1].mB = (mat4x2(1.0, -9.0, -9.0, 5.0, -1.0, -4.0, -7.0, 5.0));
	blockD[0].h.mC[1].mC[0] = (mat3x4(6.0, 3.0, 7.0, -6.0, -5.0, -4.0, -5.0, -6.0, 5.0, 0.0, 5.0, -3.0));
	blockD[0].h.mC[1].mC[1] = (mat3x4(9.0, -7.0, 9.0, 9.0, -3.0, -7.0, -3.0, 8.0, -1.0, -1.0, -1.0, 1.0));
	blockD[0].h.mC[1].mC[2] = (mat3x4(7.0, -6.0, -2.0, -8.0, -1.0, -6.0, 2.0, 1.0, 4.0, 1.0, 8.0, 1.0));
	blockD[0].h.mC[1].mC[3] = (mat3x4(6.0, 6.0, -8.0, -5.0, 1.0, -5.0, -4.0, 5.0, -7.0, 7.0, 2.0, -3.0));
	blockD[0].h.mC[1].mC[4] = (mat3x4(5.0, 1.0, 8.0, 6.0, 4.0, -3.0, 0.0, -6.0, -6.0, 3.0, -8.0, 8.0));
	blockD[0].h.mC[1].mC[5] = (mat3x4(-6.0, -4.0, 6.0, 4.0, 5.0, 2.0, -1.0, -3.0, 4.0, 5.0, 3.0, -8.0));
	blockD[0].h.mC[1].mC[6] = (mat3x4(5.0, 1.0, 2.0, -1.0, 4.0, -8.0, -9.0, -2.0, -6.0, -2.0, -6.0, 3.0));
	blockD[0].h.mC[1].mD = (4u);
	blockD[0].h.mC[2].mA = (mat3(-9.0, 0.0, -7.0, -5.0, -5.0, -1.0, 2.0, 2.0, -5.0));
	blockD[0].h.mC[2].mB = (mat4x2(3.0, 9.0, -4.0, -8.0, 6.0, 4.0, 6.0, -5.0));
	blockD[0].h.mC[2].mC[0] = (mat3x4(2.0, 5.0, -1.0, -8.0, -9.0, 6.0, -4.0, 8.0, -9.0, -6.0, -6.0, 2.0));
	blockD[0].h.mC[2].mC[1] = (mat3x4(8.0, 8.0, -4.0, -5.0, 4.0, 5.0, 2.0, -6.0, 3.0, -5.0, -9.0, -6.0));
	blockD[0].h.mC[2].mC[2] = (mat3x4(-2.0, -5.0, 4.0, -2.0, -9.0, 2.0, 9.0, -8.0, 1.0, -7.0, -4.0, 1.0));
	blockD[0].h.mC[2].mC[3] = (mat3x4(-5.0, -4.0, 8.0, 0.0, -5.0, 0.0, 0.0, 3.0, -3.0, 5.0, 2.0, 9.0));
	blockD[0].h.mC[2].mC[4] = (mat3x4(-3.0, 4.0, -4.0, -7.0, 7.0, 3.0, -7.0, -5.0, -3.0, -6.0, -6.0, 2.0));
	blockD[0].h.mC[2].mC[5] = (mat3x4(5.0, 3.0, -2.0, 5.0, 9.0, 8.0, -9.0, 7.0, 0.0, 8.0, -9.0, -9.0));
	blockD[0].h.mC[2].mC[6] = (mat3x4(7.0, -6.0, 2.0, 9.0, -4.0, -5.0, -1.0, -4.0, -5.0, 8.0, 4.0, -7.0));
	blockD[0].h.mC[2].mD = (1u);
	blockD[0].h.mC[3].mA = (mat3(-4.0, 0.0, -7.0, 7.0, 4.0, -2.0, 9.0, 7.0, 8.0));
	blockD[0].h.mC[3].mB = (mat4x2(3.0, -9.0, 4.0, -3.0, 3.0, 4.0, 4.0, 8.0));
	blockD[0].h.mC[3].mC[0] = (mat3x4(-6.0, -2.0, 1.0, 0.0, 6.0, 2.0, 1.0, 3.0, 3.0, 2.0, 8.0, -3.0));
	blockD[0].h.mC[3].mC[1] = (mat3x4(-6.0, -6.0, -2.0, -7.0, -5.0, -7.0, 5.0, 8.0, -8.0, -9.0, -9.0, -8.0));
	blockD[0].h.mC[3].mC[2] = (mat3x4(-9.0, -1.0, 7.0, 1.0, -8.0, -1.0, -7.0, 9.0, 6.0, 3.0, -4.0, 3.0));
	blockD[0].h.mC[3].mC[3] = (mat3x4(4.0, -3.0, 6.0, -4.0, -4.0, 0.0, 2.0, -8.0, -4.0, -1.0, 8.0, 4.0));
	blockD[0].h.mC[3].mC[4] = (mat3x4(-5.0, 8.0, 1.0, -3.0, 4.0, 9.0, 7.0, -8.0, 0.0, 9.0, -3.0, -3.0));
	blockD[0].h.mC[3].mC[5] = (mat3x4(8.0, 9.0, 3.0, -9.0, -7.0, -2.0, -8.0, -4.0, 4.0, 3.0, -7.0, -8.0));
	blockD[0].h.mC[3].mC[6] = (mat3x4(0.0, -7.0, 6.0, 0.0, -2.0, -8.0, 4.0, -6.0, 8.0, -2.0, -4.0, -7.0));
	blockD[0].h.mC[3].mD = (7u);
	blockD[0].h.mC[4].mA = (mat3(7.0, -7.0, -9.0, -1.0, 5.0, 6.0, 1.0, 4.0, -6.0));
	blockD[0].h.mC[4].mB = (mat4x2(-9.0, 1.0, 7.0, 1.0, 1.0, 1.0, 1.0, 6.0));
	blockD[0].h.mC[4].mC[0] = (mat3x4(-7.0, 0.0, 8.0, -2.0, -7.0, 3.0, -2.0, 1.0, 1.0, -5.0, -9.0, 6.0));
	blockD[0].h.mC[4].mC[1] = (mat3x4(6.0, 0.0, 2.0, 1.0, 7.0, -4.0, -8.0, 9.0, 2.0, 7.0, -6.0, 6.0));
	blockD[0].h.mC[4].mC[2] = (mat3x4(0.0, -5.0, -8.0, -1.0, 1.0, 4.0, 2.0, 6.0, 8.0, -3.0, -3.0, 6.0));
	blockD[0].h.mC[4].mC[3] = (mat3x4(-9.0, 3.0, 9.0, -3.0, 1.0, -8.0, 0.0, -1.0, -4.0, 0.0, -3.0, 2.0));
	blockD[0].h.mC[4].mC[4] = (mat3x4(-9.0, -1.0, 3.0, 5.0, 0.0, -3.0, -9.0, -6.0, -7.0, 5.0, -4.0, -3.0));
	blockD[0].h.mC[4].mC[5] = (mat3x4(-5.0, 9.0, -2.0, 7.0, 1.0, 9.0, 8.0, 7.0, -8.0, -5.0, 8.0, -7.0));
	blockD[0].h.mC[4].mC[6] = (mat3x4(5.0, 7.0, 0.0, -5.0, -3.0, 9.0, -3.0, 6.0, -6.0, -8.0, -8.0, 5.0));
	blockD[0].h.mC[4].mD = (3u);
	blockD[0].i = (4.0);
	blockD[0].j = (true);
}
#version 450
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
	layout(offset = 0) mediump uint a;
	layout(offset = 16) mediump ivec4 b;
	layout(offset = 32) lowp vec2 c;
	layout(offset = 48) highp ivec3 d;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) bvec2 e;
	layout(offset = 16) mediump ivec4 f;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) highp ivec4 g;
	layout(offset = 16) lowp uvec2 h;
	layout(offset = 24) lowp ivec2 i;
	layout(offset = 32) mediump uint j;
	layout(offset = 48) mediump vec4 k;
} blockD;
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) lowp vec4 l;
	layout(offset = 16) lowp uvec3 m;
	layout(offset = 32) highp uvec4 n;
	layout(offset = 48) lowp vec4 o[1];
	layout(offset = 64) mediump vec2 p;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 8u) && allOk;
	allOk = compare_ivec4((blockB.b), ivec4(7, -3, 6, 5)) && allOk;
	allOk = compare_vec2((blockB.c), vec2(-9.0, -2.0)) && allOk;
	allOk = compare_bvec2((blockC.e), bvec2(true, false)) && allOk;
	allOk = compare_ivec4((blockD.g), ivec4(5, 0, -7, 5)) && allOk;
	allOk = compare_uvec2((blockD.h), uvec2(5u, 7u)) && allOk;
	allOk = compare_ivec2((blockD.i), ivec2(1, -7)) && allOk;
	allOk = compare_uint((blockD.j), 0u) && allOk;
	allOk = compare_vec4((blockD.k), vec4(-4.0, 5.0, 7.0, -9.0)) && allOk;
	allOk = compare_uvec3((blockE.m), uvec3(7u, 0u, 6u)) && allOk;
	allOk = compare_uvec4((blockE.n), uvec4(1u, 4u, 4u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (ivec4(7, 2, 3, 4));
	blockB.d = (ivec3(-3, 2, 8));
	blockC.e = (bvec2(false, true));
	blockC.f = (ivec4(9, 7, 5, -2));
	blockD.g = (ivec4(-4, -3, 8, -7));
	blockD.h = (uvec2(9u, 8u));
	blockD.i = (ivec2(-4, -6));
	blockD.j = (1u);
	blockD.k = (vec4(4.0, 9.0, 8.0, -6.0));
	blockE.l = (vec4(-2.0, 8.0, -6.0, 1.0));
	blockE.n = (uvec4(0u, 7u, 7u, 9u));
	blockE.o[0] = (vec4(-2.0, 8.0, 7.0, -3.0));
	blockE.p = (vec2(6.0, 9.0));
}
#version 450
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
	highp int mA;
};
layout(scalar, row_major, binding = 1) buffer BlockB
{
	sA a;
	highp int b[];
} blockB[1];
layout(scalar, row_major, binding = 2) buffer BlockC
{
	highp vec3 c;
	highp float d;
} blockC;
layout(scalar, row_major, binding = 3) buffer BlockD
{
	lowp vec3 e;
	mediump vec2 f;
	mediump ivec4 g;
	lowp mat3x2 h[];
};
layout(scalar, column_major, binding = 4) buffer BlockE
{
	highp vec4 i;
	highp mat4 j;
	lowp uvec2 k;
	lowp vec3 l[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB[0].a.mA), 4) && allOk;
	allOk = compare_vec3((blockC.c), vec3(2.0, -9.0, -1.0)) && allOk;
	allOk = compare_float((blockC.d), -4.0) && allOk;
	allOk = compare_vec3((e), vec3(-8.0, 7.0, -8.0)) && allOk;
	allOk = compare_vec4((blockE.i), vec4(-1.0, 3.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4(blockE.j, mat4(-7.0, -8.0, -9.0, 5.0, -7.0, 4.0, -5.0, -3.0, -7.0, -8.0, 8.0, 2.0, 3.0, 4.0, -1.0, -1.0)) && allOk;
	allOk = compare_uvec2((blockE.k), uvec2(6u, 7u)) && allOk;
	allOk = compare_vec3((blockE.l[0]), vec3(9.0, -8.0, 1.0)) && allOk;
	allOk = compare_vec3((blockE.l[1]), vec3(6.0, -7.0, 9.0)) && allOk;
	allOk = compare_vec3((blockE.l[2]), vec3(2.0, 5.0, -1.0)) && allOk;
	allOk = compare_vec3((blockE.l[3]), vec3(-3.0, 4.0, -7.0)) && allOk;
	allOk = compare_vec3((blockE.l[4]), vec3(-2.0, -9.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b[0] = (1);
	blockB[0].b[1] = (-7);
	blockB[0].b[2] = (-7);
	blockB[0].b[3] = (-9);
	blockB[0].b[4] = (8);
	blockB[0].b[5] = (2);
	blockB[0].b[6] = (5);
	blockC.c = (vec3(3.0, -7.0, -9.0));
	e = (vec3(6.0, -9.0, -9.0));
	f = (vec2(5.0, -2.0));
	g = (ivec4(5, -2, -3, -5));
	h[0] = (mat3x2(-9.0, 4.0, 5.0, -2.0, -7.0, -2.0));
	h[1] = (mat3x2(3.0, 3.0, -8.0, -5.0, -8.0, -8.0));
	h[2] = (mat3x2(4.0, -6.0, -8.0, 2.0, 1.0, -6.0));
	h[3] = (mat3x2(1.0, -2.0, 8.0, -9.0, -2.0, 4.0));
	h[4] = (mat3x2(8.0, 6.0, 1.0, -5.0, 3.0, -7.0));
	h[5] = (mat3x2(5.0, 1.0, 2.0, 9.0, -6.0, -9.0));
	blockE.i = (vec4(3.0, 8.0, 1.0, -9.0));
	blockE.j = (mat4(-8.0, 6.0, 1.0, 8.0, -6.0, -6.0, 4.0, 0.0, 5.0, -7.0, -2.0, -7.0, -7.0, -2.0, 8.0, -7.0));
}
#version 450
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
	mediump mat2 a;
	highp int b[1];
	bvec4 c[1];
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB[nonuniformEXT(0)].a, mat2(-7.0, 3.0, -2.0, 9.0)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(0)].c[0]), bvec4(true, true, true, true)) && allOk;
	allOk = compare_mat2(blockB[nonuniformEXT(1)].a, mat2(7.0, -7.0, 7.0, -4.0)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(1)].c[0]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_mat2(blockB[nonuniformEXT(2)].a, mat2(7.0, -5.0, 4.0, -7.0)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(2)].c[0]), bvec4(false, false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (mat2(-6.0, -2.0, 3.0, -5.0));
	blockB[nonuniformEXT(0)].b[0] = (-4);
	blockB[nonuniformEXT(0)].c[0] = (bvec4(true, true, false, false));
	blockB[nonuniformEXT(1)].a = (mat2(-4.0, -9.0, -3.0, 7.0));
	blockB[nonuniformEXT(1)].b[0] = (3);
	blockB[nonuniformEXT(1)].c[0] = (bvec4(false, true, false, false));
	blockB[nonuniformEXT(2)].a = (mat2(-7.0, 4.0, 9.0, -8.0));
	blockB[nonuniformEXT(2)].b[0] = (-1);
	blockB[nonuniformEXT(2)].c[0] = (bvec4(true, false, true, false));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, row_major, binding = 1) readonly buffer BlockB
{
	mediump float a;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB[nonuniformEXT(0)].a), 0.0) && allOk;
	allOk = compare_float((blockB[nonuniformEXT(1)].a), -6.0) && allOk;
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

layout(std140, column_major, binding = 1) buffer BlockB
{
	mediump mat4x3 a;
	lowp ivec2 b[1];
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB[nonuniformEXT(0)].b[0]), ivec2(-8, 9)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(1)].b[0]), ivec2(-1, 9)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(2)].b[0]), ivec2(-5, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (mat4x3(-6.0, -9.0, 9.0, 5.0, 6.0, -9.0, 4.0, 0.0, -5.0, 0.0, -7.0, -6.0));
	blockB[nonuniformEXT(0)].b[0] = (ivec2(-7, 3));
	blockB[nonuniformEXT(1)].a = (mat4x3(9.0, -4.0, 1.0, -6.0, 4.0, 6.0, 9.0, 8.0, -8.0, -8.0, -4.0, 9.0));
	blockB[nonuniformEXT(1)].b[0] = (ivec2(-2, -5));
	blockB[nonuniformEXT(2)].a = (mat4x3(3.0, -8.0, 1.0, 2.0, 9.0, -1.0, -6.0, 4.0, -2.0, -1.0, 3.0, 3.0));
	blockB[nonuniformEXT(2)].b[0] = (ivec2(-9, 7));
}
#version 450
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
	lowp ivec4 a;
	highp mat4x2 b[1];
	lowp mat3x4 c;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b[0] = (mat4x2(-1.0, -2.0, 7.0, -5.0, -5.0, -4.0, 1.0, -7.0));
	blockB[nonuniformEXT(1)].b[0] = (mat4x2(9.0, -9.0, 4.0, 4.0, -4.0, -4.0, 0.0, 3.0));
}
#version 450
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
	uint16_t a;
	mediump mat4x3 b;
	lowp mat4x3 c;
	uint16_t d[];
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	mediump uint e;
	highp mat3 f;
	bvec4 g;
	highp int h;
	i16vec4 i[];
} blockC;
layout(std430, column_major, binding = 3) buffer BlockD
{
	lowp ivec4 j;
	bvec3 k;
	mediump vec2 l;
	lowp uvec4 m[1];
	i16vec2 n[];
};
layout(std430, binding = 4) buffer BlockE
{
	int16_t o[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(blockB.a), 8u) && allOk;
	allOk = compare_mat4x3(blockB.b, mat4x3(9.0, 9.0, -7.0, -4.0, -4.0, -6.0, -2.0, 8.0, 4.0, -4.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat4x3(blockB.c, mat4x3(-7.0, 9.0, -3.0, -8.0, 6.0, 0.0, -1.0, -3.0, 0.0, -1.0, -7.0, -7.0)) && allOk;
	allOk = compare_uint((blockC.e), 5u) && allOk;
	allOk = compare_mat3(blockC.f, mat3(-6.0, 4.0, 1.0, 8.0, 0.0, -8.0, -2.0, -1.0, -9.0)) && allOk;
	allOk = compare_bvec4((blockC.g), bvec4(true, false, false, true)) && allOk;
	allOk = compare_ivec4((j), ivec4(-7, -9, 6, 4)) && allOk;
	allOk = compare_bvec3((k), bvec3(true, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = uint16_t(9u);
	blockB.b = (mat4x3(0.0, 9.0, 4.0, 1.0, -7.0, -4.0, -4.0, -6.0, -5.0, -2.0, 4.0, -2.0));
	blockB.c = (mat4x3(5.0, -9.0, -3.0, -1.0, -9.0, 1.0, 1.0, 7.0, 8.0, 9.0, -7.0, -1.0));
	blockB.d[0] = uint16_t(9u);
	blockB.d[1] = uint16_t(6u);
	blockB.d[2] = uint16_t(8u);
	blockB.d[3] = uint16_t(5u);
	blockB.d[4] = uint16_t(8u);
	blockB.d[5] = uint16_t(1u);
	blockB.d[6] = uint16_t(8u);
	blockB.d[7] = uint16_t(3u);
	blockC.e = (7u);
	blockC.f = (mat3(-4.0, 3.0, -3.0, -6.0, -9.0, -7.0, -5.0, -6.0, -1.0));
	blockC.g = (bvec4(true, false, false, false));
	blockC.i[0] = i16vec4(ivec4(6, -9, 4, 7));
	blockC.i[1] = i16vec4(ivec4(-3, 0, 8, -9));
	blockC.i[2] = i16vec4(ivec4(-1, 8, 3, -6));
	blockC.i[3] = i16vec4(ivec4(7, 0, 5, -9));
	k = (bvec3(false, false, true));
	l = (vec2(-2.0, 1.0));
	m[0] = (uvec4(4u, 7u, 0u, 1u));
	n[0] = i16vec2(ivec2(8, -8));
	n[1] = i16vec2(ivec2(-8, 6));
	n[2] = i16vec2(ivec2(4, 5));
	o[0] = int16_t(8);
	o[1] = int16_t(3);
}
#version 450
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
	lowp mat3 a;
	i16vec4 b;
	uint16_t c;
	i16vec2 d;
	highp mat2x3 e[];
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	bvec3 f;
	lowp mat4x2 g[];
} blockC;
layout(std430, row_major, binding = 3) buffer BlockD
{
	mediump float h;
	highp mat2x3 i[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(blockB.c), 3u) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.d), ivec2(-1, 6)) && allOk;
	allOk = compare_mat4x2(blockC.g[0], mat4x2(-3.0, 9.0, 4.0, 8.0, 9.0, 9.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat4x2(blockC.g[1], mat4x2(-6.0, -6.0, -7.0, -2.0, -7.0, 2.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat4x2(blockC.g[2], mat4x2(1.0, 2.0, -1.0, -6.0, -8.0, 9.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat4x2(blockC.g[3], mat4x2(5.0, -4.0, 8.0, 3.0, 2.0, -3.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat2x3(i[0], mat2x3(6.0, -7.0, 3.0, 6.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2x3(i[1], mat2x3(-6.0, -8.0, 2.0, 2.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat2x3(i[2], mat2x3(7.0, -2.0, -2.0, -7.0, -2.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = i16vec4(ivec4(-5, -7, 5, 2));
	blockB.e[0] = (mat2x3(9.0, 3.0, 1.0, -6.0, 4.0, -4.0));
	blockB.e[1] = (mat2x3(-6.0, 9.0, 3.0, 7.0, 7.0, -8.0));
	blockB.e[2] = (mat2x3(5.0, -2.0, -7.0, -2.0, 5.0, 0.0));
	blockB.e[3] = (mat2x3(-1.0, 5.0, 4.0, -9.0, -1.0, -1.0));
	blockB.e[4] = (mat2x3(7.0, -1.0, -7.0, 7.0, 4.0, -3.0));
	blockB.e[5] = (mat2x3(1.0, 6.0, 5.0, 8.0, 5.0, -1.0));
	blockC.f = (bvec3(false, false, false));
	blockC.g[0] = (mat4x2(-8.0, 1.0, -1.0, -7.0, -2.0, -3.0, -8.0, 3.0));
	blockC.g[1] = (mat4x2(-6.0, 1.0, 1.0, 2.0, -1.0, -5.0, -1.0, -4.0));
	blockC.g[2] = (mat4x2(4.0, -5.0, 7.0, -9.0, -2.0, 2.0, 8.0, 3.0));
	blockC.g[3] = (mat4x2(1.0, -1.0, -5.0, 0.0, -2.0, -2.0, 5.0, 2.0));
	h = (-7.0);
	i[0] = (mat2x3(-7.0, 9.0, -8.0, -7.0, -6.0, 6.0));
	i[1] = (mat2x3(5.0, 2.0, -9.0, 3.0, 4.0, 9.0));
	i[2] = (mat2x3(1.0, -8.0, -8.0, 6.0, -6.0, -6.0));
}
#version 450
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
	bvec3 a;
	f16vec4 b;
	i16vec3 c[];
};
layout(std430, column_major, binding = 2) buffer BlockC
{
	highp mat4 d;
	i16vec2 e;
	i16vec4 f;
	u16vec3 g;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(b), vec4(7.0, 7.0, 0.0, 5.0)) && allOk;
	allOk = compare_i16vec2(ivec2(e), ivec2(3, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(f), ivec4(-7, 7, -3, -3)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec3(true, false, true));
	b = f16vec4(vec4(9.0, -2.0, -4.0, -9.0));
	d = (mat4(-9.0, -5.0, 4.0, -3.0, -8.0, -8.0, 9.0, 4.0, 4.0, -3.0, 8.0, -6.0, -2.0, -6.0, -9.0, 2.0));
	e = i16vec2(ivec2(6, -9));
	f = i16vec4(ivec4(-4, 6, 0, -2));
}
#version 450
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
	i16vec4 mB;
};
struct sB
{
	highp ivec3 mA;
	sA mB;
	bvec2 mC;
	highp vec4 mD;
};
struct sC
{
	i16vec4 mA;
	lowp vec4 mB;
	lowp mat2x3 mC;
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	mediump ivec2 a;
	bvec4 b;
	lowp mat4 c;
	f16vec3 d[1];
};
layout(std140, binding = 2) buffer BlockC
{
	highp mat2 e;
	bvec4 f;
	highp vec3 g;
	bool h;
	i16vec3 i;
};
layout(std430, column_major, binding = 3) buffer BlockD
{
	f16vec2 j;
	sB k;
	f16vec3 l;
	sC m[1];
	int16_t n[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((a), ivec2(6, 6)) && allOk;
	allOk = compare_bvec4((b), bvec4(false, false, true, false)) && allOk;
	allOk = compare_f16vec3(vec3(d[0]), vec3(9.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat2(e, mat2(4.0, -9.0, 8.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockD.j), vec2(-3.0, 5.0)) && allOk;
	allOk = compare_ivec3((blockD.k.mA), ivec3(-2, 4, -4)) && allOk;
	allOk = compare_bvec3((blockD.k.mB.mA), bvec3(true, false, false)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k.mB.mB), ivec4(-3, 0, -9, 9)) && allOk;
	allOk = compare_bvec2((blockD.k.mC), bvec2(true, true)) && allOk;
	allOk = compare_vec4((blockD.k.mD), vec4(-9.0, 6.0, 6.0, 8.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockD.l), vec3(-1.0, 2.0, 7.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.m[0].mA), ivec4(8, 6, 7, -7)) && allOk;
	allOk = compare_vec4((blockD.m[0].mB), vec4(0.0, -3.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat2x3(blockD.m[0].mC, mat2x3(-5.0, 4.0, -8.0, -1.0, 2.0, -5.0)) && allOk;
	allOk = compare_int16_t(int(blockD.n[0]), 6) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (ivec2(-5, 9));
	e = (mat2(-8.0, -5.0, -1.0, 2.0));
	f = (bvec4(false, true, false, true));
	g = (vec3(4.0, -6.0, 4.0));
	i = i16vec3(ivec3(-4, -5, 7));
	blockD.k.mA = (ivec3(0, -7, 2));
	blockD.k.mB.mA = (bvec3(false, false, true));
	blockD.k.mB.mB = i16vec4(ivec4(-2, -7, 8, 8));
	blockD.k.mC = (bvec2(true, false));
	blockD.k.mD = (vec4(-6.0, -3.0, -1.0, 3.0));
	blockD.l = f16vec3(vec3(7.0, -2.0, -7.0));
	blockD.m[0].mA = i16vec4(ivec4(-7, -5, 3, 8));
	blockD.m[0].mB = (vec4(6.0, -1.0, -8.0, -7.0));
	blockD.m[0].mC = (mat2x3(3.0, 8.0, 1.0, 4.0, -7.0, -3.0));
	blockD.n[0] = int16_t(7);
}
#version 450
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
	mediump uvec2 mA;
	mediump vec4 mB;
	i16vec2 mC;
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	sA a;
	mediump mat4x2 b;
	highp uint c[];
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	mediump uvec3 d;
	u16vec2 e[];
} blockC;
layout(std140, row_major, binding = 3) readonly buffer BlockD
{
	f16vec2 f[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB.b, mat4x2(2.0, -6.0, 5.0, -7.0, 2.0, 8.0, 8.0, 6.0)) && allOk;
	allOk = compare_uint((blockB.c[0]), 9u) && allOk;
	allOk = compare_uvec3((blockC.d), uvec3(2u, 1u, 5u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.e[0]), uvec2(9u, 6u)) && allOk;
	allOk = compare_f16vec2(vec2(blockD.f[0]), vec2(1.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA = (uvec2(9u, 2u));
	blockB.a.mB = (vec4(-3.0, -7.0, 6.0, 2.0));
	blockB.a.mC = i16vec2(ivec2(-8, 7));
	blockB.b = (mat4x2(6.0, -4.0, 5.0, 7.0, 9.0, -2.0, 6.0, 4.0));
	blockB.c[0] = (7u);
	blockC.d = (uvec3(5u, 0u, 9u));
	blockC.e[0] = u16vec2(uvec2(5u, 7u));
}
#version 450
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
	bool a[];
};

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	a[0] = (true);
	a[1] = (true);
	a[2] = (true);
	a[3] = (true);
	a[4] = (false);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, row_major, binding = 1) readonly buffer BlockB
{
	mediump mat4x2 a;
} blockB[1];
layout(scalar, row_major, binding = 2) buffer BlockC
{
	lowp mat3x2 b[];
};
layout(scalar, row_major, binding = 3) buffer BlockD
{
	lowp mat4x3 c;
	mediump mat4 d;
	highp mat4x2 e;
	i16vec4 f[];
} blockD[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(b[0], mat3x2(-9.0, 9.0, -9.0, -6.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3x2(b[1], mat3x2(0.0, -8.0, -6.0, 4.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat3x2(b[2], mat3x2(-2.0, 0.0, 2.0, 0.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat3x2(b[3], mat3x2(5.0, 2.0, 8.0, -7.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3x2(b[4], mat3x2(4.0, 6.0, -6.0, 3.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat4x3(blockD[0].c, mat4x3(-3.0, -9.0, 1.0, -1.0, -1.0, 3.0, 6.0, 6.0, 2.0, -1.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat4(blockD[0].d, mat4(6.0, -9.0, 7.0, 4.0, -9.0, -8.0, 9.0, 9.0, 7.0, 1.0, 7.0, -2.0, 2.0, -1.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4x3(blockD[1].c, mat4x3(-8.0, -4.0, 5.0, -5.0, 0.0, -9.0, -7.0, -2.0, -6.0, 8.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat4(blockD[1].d, mat4(-9.0, 9.0, 5.0, -9.0, -3.0, 7.0, 3.0, -3.0, -5.0, 6.0, -5.0, 8.0, 3.0, 2.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat4x3(blockD[2].c, mat4x3(4.0, 8.0, -1.0, -1.0, -4.0, -8.0, 1.0, 3.0, 4.0, 1.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat4(blockD[2].d, mat4(4.0, -6.0, -2.0, -7.0, -7.0, 8.0, 3.0, 3.0, -5.0, -3.0, 7.0, 7.0, -6.0, 4.0, 4.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b[0] = (mat3x2(-3.0, 1.0, -6.0, -5.0, -9.0, 1.0));
	b[1] = (mat3x2(5.0, -7.0, -7.0, 4.0, 9.0, -5.0));
	b[2] = (mat3x2(7.0, -6.0, 4.0, 7.0, 3.0, -9.0));
	b[3] = (mat3x2(4.0, 8.0, 8.0, 7.0, -4.0, 8.0));
	b[4] = (mat3x2(5.0, 3.0, 7.0, -5.0, -8.0, 6.0));
	blockD[0].c = (mat4x3(0.0, -1.0, -2.0, 4.0, -3.0, 3.0, 1.0, 5.0, -6.0, -8.0, 7.0, -1.0));
	blockD[0].d = (mat4(5.0, 1.0, -1.0, 9.0, 7.0, 5.0, -8.0, 0.0, 4.0, -6.0, -3.0, 8.0, -7.0, 4.0, 0.0, 6.0));
	blockD[0].e = (mat4x2(-9.0, -2.0, 1.0, -7.0, 9.0, -2.0, -1.0, -3.0));
	blockD[0].f[0] = i16vec4(ivec4(-3, -6, 3, -1));
	blockD[0].f[1] = i16vec4(ivec4(7, -1, 2, -4));
	blockD[1].c = (mat4x3(7.0, 7.0, 0.0, 6.0, 6.0, 5.0, -9.0, -9.0, 9.0, 3.0, 1.0, 1.0));
	blockD[1].d = (mat4(-7.0, -8.0, 2.0, 1.0, -2.0, 7.0, 8.0, 8.0, 4.0, 6.0, -5.0, -6.0, 7.0, 0.0, 9.0, -8.0));
	blockD[1].e = (mat4x2(-1.0, -8.0, -6.0, 6.0, 5.0, -1.0, -9.0, 4.0));
	blockD[1].f[0] = i16vec4(ivec4(-5, 8, 2, -3));
	blockD[1].f[1] = i16vec4(ivec4(1, 2, -5, -4));
	blockD[1].f[2] = i16vec4(ivec4(8, 2, 3, -4));
	blockD[1].f[3] = i16vec4(ivec4(-6, 4, -6, -8));
	blockD[1].f[4] = i16vec4(ivec4(-5, 3, -9, -3));
	blockD[1].f[5] = i16vec4(ivec4(3, -1, 7, -3));
	blockD[2].c = (mat4x3(-4.0, -2.0, -1.0, -5.0, 0.0, -8.0, 6.0, -7.0, 8.0, 1.0, 2.0, 6.0));
	blockD[2].d = (mat4(8.0, -1.0, 8.0, -8.0, 4.0, 6.0, 1.0, 0.0, -8.0, 3.0, 9.0, 3.0, -5.0, -2.0, -6.0, 6.0));
	blockD[2].e = (mat4x2(-6.0, 0.0, -6.0, 6.0, -4.0, -5.0, -6.0, 1.0));
	blockD[2].f[0] = i16vec4(ivec4(5, 5, -3, -8));
	blockD[2].f[1] = i16vec4(ivec4(5, -8, -3, -2));
	blockD[2].f[2] = i16vec4(ivec4(7, 3, 0, -7));
	blockD[2].f[3] = i16vec4(ivec4(-3, 1, -3, -2));
	blockD[2].f[4] = i16vec4(ivec4(-4, 4, -4, 4));
	blockD[2].f[5] = i16vec4(ivec4(-1, -6, 8, -2));
	blockD[2].f[6] = i16vec4(ivec4(-4, 3, 3, 9));
}
#version 450
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
};
layout(std140, binding = 2) buffer BlockC
{
	highp int b;
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	mediump int c;
	int8_t d;
} blockD;

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockC.b), 2) && allOk;
	allOk = compare_int((blockD.c), -4) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (true);
	blockC.b = (-2);
	blockD.c = (6);
	blockD.d = int8_t(0);
}
#version 450
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
	i8vec4 a;
	lowp vec2 b;
};
layout(std140, row_major, binding = 2) readonly buffer BlockC
{
	u8vec2 c[6];
};
layout(std140, row_major, binding = 3) readonly buffer BlockD
{
	mediump mat2 d;
	lowp uint e;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(a), ivec4(1, 4294967291, 4294967287, 4294967291)) && allOk;
	allOk = compare_vec2((b), vec2(1.0, -7.0)) && allOk;
	allOk = compare_uint((blockD.e), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	a = i8vec4(ivec4(2, 7, 4294967291, 4294967292));
}
#version 450
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
	lowp ivec2 a;
	highp uvec3 b;
	highp mat2x3 c;
};
layout(std140, binding = 2) buffer BlockC
{
	highp float d[4];
	u8vec4 e;
	bvec2 f;
	uint8_t g;
};
layout(std140, row_major, binding = 3) buffer BlockD
{
	bool h;
	lowp float i;
};
layout(std140, column_major, binding = 4) buffer BlockE
{
	highp int j;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((b), uvec3(0u, 1u, 6u)) && allOk;
	allOk = compare_mat2x3(c, mat2x3(0.0, 9.0, 0.0, -3.0, -2.0, 3.0)) && allOk;
	allOk = compare_float((d[0]), -3.0) && allOk;
	allOk = compare_float((d[1]), 2.0) && allOk;
	allOk = compare_float((d[2]), -3.0) && allOk;
	allOk = compare_float((d[3]), 8.0) && allOk;
	allOk = compare_u8vec4(uvec4(e), uvec4(7u, 4u, 6u, 4u)) && allOk;
	allOk = compare_bvec2((f), bvec2(false, false)) && allOk;
	allOk = compare_uint8_t(uint(g), 0u) && allOk;
	allOk = compare_int((blockE.j), 4) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (ivec2(-7, 4));
	b = (uvec3(2u, 4u, 6u));
	d[0] = (-7.0);
	d[1] = (-5.0);
	d[2] = (-9.0);
	d[3] = (-9.0);
	f = (bvec2(false, true));
	g = uint8_t(6u);
	h = (false);
	i = (1.0);
	blockE.j = (3);
}
#version 450
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
	u8vec3 a[][7];
} blockB;
layout(std140, row_major, binding = 2) buffer BlockC
{
	highp ivec2 b;
	lowp mat4x2 c;
	mediump uvec4 d;
	mediump mat4x3 e;
	mediump vec3 f[];
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	highp mat3x2 g[];
};
layout(std430, binding = 4) buffer BlockE
{
	i8vec2 h[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(blockB.a[0][0]), uvec3(2u, 0u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.a[0][1]), uvec3(0u, 8u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.a[0][2]), uvec3(7u, 1u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.a[0][3]), uvec3(7u, 0u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.a[0][4]), uvec3(6u, 9u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.a[0][5]), uvec3(2u, 8u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.a[0][6]), uvec3(9u, 9u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.a[1][0]), uvec3(3u, 2u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.a[1][1]), uvec3(8u, 6u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.a[1][2]), uvec3(5u, 1u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.a[1][3]), uvec3(7u, 5u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.a[1][4]), uvec3(5u, 5u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.a[1][5]), uvec3(8u, 3u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.a[1][6]), uvec3(2u, 7u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.a[2][0]), uvec3(2u, 7u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.a[2][1]), uvec3(2u, 6u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.a[2][2]), uvec3(9u, 7u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.a[2][3]), uvec3(3u, 2u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.a[2][4]), uvec3(1u, 7u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.a[2][5]), uvec3(0u, 7u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.a[2][6]), uvec3(4u, 5u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.a[3][0]), uvec3(9u, 9u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.a[3][1]), uvec3(6u, 2u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.a[3][2]), uvec3(3u, 2u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.a[3][3]), uvec3(2u, 1u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.a[3][4]), uvec3(4u, 0u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.a[3][5]), uvec3(1u, 0u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.a[3][6]), uvec3(1u, 3u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.a[4][0]), uvec3(5u, 7u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.a[4][1]), uvec3(9u, 3u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.a[4][2]), uvec3(2u, 4u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.a[4][3]), uvec3(1u, 5u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.a[4][4]), uvec3(3u, 0u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.a[4][5]), uvec3(5u, 1u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.a[4][6]), uvec3(8u, 8u, 5u)) && allOk;
	allOk = compare_ivec2((blockC.b), ivec2(-7, -7)) && allOk;
	allOk = compare_mat4x2(blockC.c, mat4x2(-1.0, -8.0, -9.0, 6.0, -2.0, -8.0, 6.0, -6.0)) && allOk;
	allOk = compare_vec3((blockC.f[0]), vec3(0.0, -8.0, 6.0)) && allOk;
	allOk = compare_vec3((blockC.f[1]), vec3(-6.0, 8.0, -9.0)) && allOk;
	allOk = compare_vec3((blockC.f[2]), vec3(5.0, 0.0, 5.0)) && allOk;
	allOk = compare_vec3((blockC.f[3]), vec3(-6.0, -9.0, -6.0)) && allOk;
	allOk = compare_vec3((blockC.f[4]), vec3(-7.0, -2.0, 0.0)) && allOk;
	allOk = compare_vec3((blockC.f[5]), vec3(-8.0, 3.0, -9.0)) && allOk;
	allOk = compare_vec3((blockC.f[6]), vec3(-7.0, -1.0, 6.0)) && allOk;
	allOk = compare_vec3((blockC.f[7]), vec3(9.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3x2(g[0], mat3x2(8.0, 6.0, -7.0, -3.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat3x2(g[1], mat3x2(-2.0, 4.0, -2.0, -8.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat3x2(g[2], mat3x2(-4.0, 5.0, 9.0, -7.0, -1.0, -6.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockE.h[0]), ivec2(5, 4294967290)) && allOk;
	allOk = compare_i8vec2(ivec2(blockE.h[1]), ivec2(4294967288, 4294967288)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (ivec2(8, -4));
	blockC.c = (mat4x2(1.0, -4.0, -7.0, 7.0, 6.0, -9.0, -2.0, 1.0));
	blockC.d = (uvec4(3u, 5u, 7u, 1u));
	blockC.e = (mat4x3(-1.0, 4.0, -6.0, -5.0, -7.0, 3.0, -5.0, 3.0, -5.0, -9.0, -6.0, -3.0));
	blockC.f[0] = (vec3(2.0, 7.0, 5.0));
	blockC.f[1] = (vec3(3.0, 4.0, -1.0));
	blockC.f[2] = (vec3(-3.0, -7.0, -6.0));
	blockC.f[3] = (vec3(6.0, 6.0, 2.0));
	blockC.f[4] = (vec3(-7.0, 7.0, 8.0));
	blockC.f[5] = (vec3(8.0, -5.0, 9.0));
	blockC.f[6] = (vec3(3.0, -7.0, 1.0));
	blockC.f[7] = (vec3(-7.0, 8.0, -9.0));
	g[0] = (mat3x2(-9.0, 3.0, -9.0, -7.0, 6.0, 9.0));
	g[1] = (mat3x2(-8.0, 9.0, -7.0, 1.0, -5.0, 5.0));
	g[2] = (mat3x2(5.0, 2.0, 5.0, -6.0, 3.0, 2.0));
	blockE.h[0] = i8vec2(ivec2(4294967289, 4294967287));
	blockE.h[1] = i8vec2(ivec2(2, 4));
}
#version 450
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
	layout(offset = 0) lowp ivec4 a;
	layout(offset = 16) bvec2 b;
	layout(offset = 24) lowp int c;
	layout(offset = 28) int8_t d;
	layout(offset = 32) bvec4 e;
} blockB[2];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) highp uvec2 f;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB[0].b), bvec2(false, true)) && allOk;
	allOk = compare_int((blockB[0].c), 6) && allOk;
	allOk = compare_int8_t(int(blockB[0].d), 4294967295) && allOk;
	allOk = compare_bvec4((blockB[0].e), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec2((blockB[1].b), bvec2(false, false)) && allOk;
	allOk = compare_int((blockB[1].c), -5) && allOk;
	allOk = compare_int8_t(int(blockB[1].d), 2) && allOk;
	allOk = compare_bvec4((blockB[1].e), bvec4(true, true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (ivec4(0, -7, 3, -2));
	blockB[0].b = (bvec2(true, true));
	blockB[0].c = (-8);
	blockB[0].d = int8_t(8);
	blockB[0].e = (bvec4(true, false, true, true));
	blockB[1].a = (ivec4(-6, -1, -2, 2));
	blockB[1].b = (bvec2(true, true));
	blockB[1].c = (5);
	blockB[1].d = int8_t(4294967291);
	blockB[1].e = (bvec4(true, true, true, true));
	f = (uvec2(0u, 4u));
}
#version 450
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
	layout(offset = 0) highp ivec2 a;
	layout(offset = 8) u8vec2 b;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump ivec4 c;
	layout(offset = 16) bvec3 d[1];
} blockC[1];

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockC[0].c), ivec4(0, -2, -6, 9)) && allOk;
	allOk = compare_bvec3((blockC[0].d[0]), bvec3(true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec2(5, -4));
	blockB.b = u8vec2(uvec2(5u, 4u));
	blockC[0].c = (ivec4(0, 9, -5, -3));
	blockC[0].d[0] = (bvec3(false, false, false));
}
#version 450
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
	layout(offset = 0) mediump vec4 a;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) highp vec3 b;
	layout(offset = 12) lowp int c;
	layout(offset = 16) u8vec4 d;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((a), vec4(-9.0, 2.0, 9.0, 1.0)) && allOk;
	allOk = compare_vec3((blockC.b), vec3(-3.0, -3.0, 0.0)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC.d), uvec4(7u, 9u, 6u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (vec3(0.0, 6.0, -1.0));
	blockC.c = (1);
	blockC.d = u8vec4(uvec4(6u, 8u, 7u, 3u));
}
#version 450
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
	highp mat3 mA;
};
struct sB
{
	highp uint mA;
	u8vec4 mB;
	highp mat3x2 mC;
	mediump mat4 mD;
};
struct sC
{
	sB mA;
};
struct sD
{
	highp mat3x2 mA;
};
layout(scalar, row_major, binding = 1) buffer BlockB
{
	u8vec4 a;
	lowp vec3 b;
} blockB[1];
layout(scalar, column_major, binding = 2) buffer BlockC
{
	mediump mat2 c;
	sA d;
	u8vec2 e;
	mediump ivec3 f;
} blockC[2];
layout(scalar, column_major, binding = 3) buffer BlockD
{
	i8vec2 g[];
} blockD[2];
layout(scalar, column_major, binding = 4) buffer BlockE
{
	sC h;
	highp mat4x3 i;
	sD j;
	uint8_t k;
	lowp vec4 l[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockC[0].c, mat2(-8.0, -6.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat3(blockC[0].d.mA, mat3(6.0, -6.0, 1.0, 8.0, 1.0, -7.0, 7.0, 5.0, 8.0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC[0].e), uvec2(8u, 4u)) && allOk;
	allOk = compare_ivec3((blockC[0].f), ivec3(-8, 6, 2)) && allOk;
	allOk = compare_mat2(blockC[1].c, mat2(3.0, -7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3(blockC[1].d.mA, mat3(-9.0, 1.0, 1.0, 3.0, 6.0, -3.0, 8.0, 6.0, -4.0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC[1].e), uvec2(2u, 8u)) && allOk;
	allOk = compare_ivec3((blockC[1].f), ivec3(5, 8, -9)) && allOk;
	allOk = compare_uint((blockE.h.mA.mA), 3u) && allOk;
	allOk = compare_u8vec4(uvec4(blockE.h.mA.mB), uvec4(5u, 5u, 0u, 4u)) && allOk;
	allOk = compare_mat3x2(blockE.h.mA.mC, mat3x2(-3.0, -1.0, -9.0, 5.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat4(blockE.h.mA.mD, mat4(-4.0, 3.0, 2.0, -2.0, 8.0, 6.0, -2.0, 2.0, 3.0, 7.0, 5.0, 9.0, -1.0, 7.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockE.j.mA, mat3x2(5.0, -7.0, 7.0, 0.0, 0.0, 0.0)) && allOk;
	allOk = compare_vec4((blockE.l[0]), vec4(3.0, -8.0, 6.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = u8vec4(uvec4(9u, 4u, 4u, 5u));
	blockC[0].c = (mat2(5.0, 4.0, 8.0, 6.0));
	blockC[0].d.mA = (mat3(7.0, -5.0, 5.0, -2.0, 7.0, 4.0, 7.0, 0.0, 9.0));
	blockC[0].f = (ivec3(4, 9, -7));
	blockC[1].c = (mat2(-6.0, -2.0, -4.0, 8.0));
	blockC[1].d.mA = (mat3(-6.0, -4.0, 6.0, -3.0, -6.0, 8.0, -6.0, -7.0, -1.0));
	blockC[1].f = (ivec3(2, -1, 4));
	blockD[0].g[0] = i8vec2(ivec2(4294967290, 5));
	blockD[0].g[1] = i8vec2(ivec2(4294967291, 4294967295));
	blockD[0].g[2] = i8vec2(ivec2(4294967294, 4294967293));
	blockD[1].g[0] = i8vec2(ivec2(4294967289, 8));
	blockD[1].g[1] = i8vec2(ivec2(4294967290, 7));
	blockD[1].g[2] = i8vec2(ivec2(9, 8));
	blockD[1].g[3] = i8vec2(ivec2(4294967293, 4294967292));
	blockD[1].g[4] = i8vec2(ivec2(4, 9));
	blockD[1].g[5] = i8vec2(ivec2(0, 1));
	blockD[1].g[6] = i8vec2(ivec2(2, 4294967293));
	blockD[1].g[7] = i8vec2(ivec2(4294967287, 4294967287));
	blockE.h.mA.mA = (5u);
	blockE.h.mA.mB = u8vec4(uvec4(3u, 5u, 4u, 0u));
	blockE.h.mA.mC = (mat3x2(-8.0, -9.0, 0.0, 0.0, 9.0, -9.0));
	blockE.h.mA.mD = (mat4(4.0, 7.0, 6.0, 6.0, -5.0, -4.0, 3.0, -5.0, -2.0, 0.0, -5.0, 2.0, 9.0, -4.0, 4.0, -2.0));
	blockE.i = (mat4x3(-5.0, 4.0, -1.0, 3.0, 8.0, -9.0, -7.0, -2.0, -2.0, -1.0, -6.0, 8.0));
	blockE.j.mA = (mat3x2(-5.0, -3.0, 5.0, 9.0, -5.0, -8.0));
	blockE.k = uint8_t(4u);
	blockE.l[0] = (vec4(9.0, 5.0, 1.0, -7.0));
}
#version 450
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
	lowp mat2x3 mB;
	mediump mat3x2 mC;
	lowp uvec2 mD;
};
struct sB
{
	mediump uvec4 mA;
	lowp mat2x3 mB;
	sA mC;
	uint8_t mD;
};
layout(scalar, row_major, binding = 1) buffer BlockB
{
	highp mat4x3 a;
	mediump ivec4 b;
	bool c[];
} blockB;
layout(scalar, column_major, binding = 2) readonly buffer BlockC
{
	u8vec2 d[];
};
layout(scalar, row_major, binding = 3) buffer BlockD
{
	highp uint e;
	sB f;
	lowp float g;
	bvec2 h;
	lowp uvec4 i[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.a, mat4x3(6.0, -7.0, -8.0, -3.0, 2.0, -7.0, 6.0, -1.0, -4.0, 1.0, -2.0, -1.0)) && allOk;
	allOk = compare_ivec4((blockB.b), ivec4(-5, -5, 4, -8)) && allOk;
	allOk = compare_bool((blockB.c[0]), false) && allOk;
	allOk = compare_bool((blockB.c[1]), false) && allOk;
	allOk = compare_bool((blockB.c[2]), false) && allOk;
	allOk = compare_uint((blockD.e), 3u) && allOk;
	allOk = compare_float((blockD.g), 1.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x3(6.0, 5.0, -3.0, 9.0, 2.0, 5.0, -9.0, 5.0, -6.0, -1.0, -8.0, 3.0));
	blockB.b = (ivec4(7, 3, -3, 2));
	blockB.c[0] = (false);
	blockB.c[1] = (false);
	blockB.c[2] = (false);
	blockD.e = (2u);
	blockD.f.mA = (uvec4(8u, 2u, 7u, 2u));
	blockD.f.mB = (mat2x3(-4.0, 6.0, -6.0, 1.0, -5.0, 2.0));
	blockD.f.mC.mA = (bvec2(true, false));
	blockD.f.mC.mB = (mat2x3(-1.0, -8.0, -1.0, 7.0, 4.0, -6.0));
	blockD.f.mC.mC = (mat3x2(2.0, -5.0, 7.0, 3.0, 4.0, 9.0));
	blockD.f.mC.mD = (uvec2(5u, 0u));
	blockD.f.mD = uint8_t(9u);
	blockD.g = (2.0);
}
#version 450
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
	mediump ivec3 a;
	lowp mat4x3 b;
	bvec2 c[];
} blockB;
layout(scalar, binding = 2) buffer BlockC
{
	lowp mat4x2 d[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a), ivec3(6, -4, 5)) && allOk;
	allOk = compare_mat4x3(blockB.b, mat4x3(2.0, 5.0, -2.0, -2.0, -6.0, 6.0, -6.0, 3.0, -8.0, 3.0, -1.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec3(8, -7, -6));
	d[0] = (mat4x2(-9.0, -3.0, -2.0, -5.0, -7.0, -6.0, -7.0, -6.0));
	d[1] = (mat4x2(-1.0, 1.0, 7.0, 9.0, 0.0, 4.0, -5.0, -8.0));
	d[2] = (mat4x2(8.0, -4.0, -9.0, 2.0, -1.0, -2.0, -3.0, 0.0));
	d[3] = (mat4x2(4.0, 4.0, -1.0, -8.0, -8.0, 2.0, 1.0, 3.0));
}
#version 450
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
	highp float a;
};
layout(scalar, binding = 2) buffer BlockC
{
	mediump mat4 b;
	highp uvec3 c;
	highp vec4 d[];
} blockC;
layout(scalar, column_major, binding = 3) buffer BlockD
{
	u8vec3 e;
	uint8_t f;
	highp vec3 g;
	mediump uvec3 h;
	bvec2 i[];
};
layout(scalar, row_major, binding = 4) buffer BlockE
{
	i8vec4 j[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((a), -9.0) && allOk;
	allOk = compare_uvec3((blockC.c), uvec3(3u, 4u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(e), uvec3(4u, 9u, 6u)) && allOk;
	allOk = compare_uint8_t(uint(f), 5u) && allOk;
	allOk = compare_vec3((g), vec3(7.0, -7.0, -7.0)) && allOk;
	allOk = compare_uvec3((h), uvec3(6u, 0u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (-4.0);
	blockC.b = (mat4(7.0, 8.0, 2.0, 0.0, -4.0, -9.0, 1.0, 6.0, -8.0, -5.0, 9.0, 6.0, 8.0, 3.0, -4.0, -7.0));
	blockC.d[0] = (vec4(4.0, -6.0, -2.0, 3.0));
	blockC.d[1] = (vec4(9.0, -9.0, 3.0, 0.0));
	blockC.d[2] = (vec4(-9.0, 3.0, -5.0, 4.0));
	blockC.d[3] = (vec4(5.0, -6.0, 3.0, -9.0));
	e = u8vec3(uvec3(3u, 7u, 0u));
	f = uint8_t(3u);
	g = (vec3(1.0, 8.0, -1.0));
	h = (uvec3(7u, 1u, 2u));
	i[0] = (bvec2(true, false));
	blockE.j[0] = i8vec4(ivec4(4294967288, 7, 4294967288, 6));
	blockE.j[1] = i8vec4(ivec4(4294967293, 9, 4, 9));
	blockE.j[2] = i8vec4(ivec4(0, 4294967289, 0, 4));
	blockE.j[3] = i8vec4(ivec4(4294967292, 4294967290, 5, 0));
	blockE.j[4] = i8vec4(ivec4(4294967292, 4294967294, 4294967290, 4294967287));
	blockE.j[5] = i8vec4(ivec4(4294967289, 9, 4294967290, 6));
	blockE.j[6] = i8vec4(ivec4(1, 4294967288, 4294967292, 4294967292));
	blockE.j[7] = i8vec4(ivec4(4294967293, 4, 8, 3));
}
#version 450
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
	highp mat4 a;
	highp uint b;
	highp ivec3 c;
	highp mat3x4 d;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB[nonuniformEXT(0)].a, mat4(0.0, 2.0, -8.0, 6.0, 7.0, 5.0, -6.0, 1.0, 9.0, -4.0, -3.0, 4.0, 4.0, 9.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3x4(blockB[nonuniformEXT(0)].d, mat3x4(-4.0, 7.0, 2.0, -1.0, 7.0, -5.0, -4.0, 3.0, -5.0, -3.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4(blockB[nonuniformEXT(1)].a, mat4(0.0, -3.0, 1.0, 3.0, -9.0, -4.0, 3.0, 9.0, 1.0, 3.0, -9.0, -5.0, 9.0, -7.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat3x4(blockB[nonuniformEXT(1)].d, mat3x4(-7.0, -1.0, 5.0, -3.0, 0.0, -8.0, 1.0, -9.0, -9.0, -9.0, -7.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (mat4(6.0, -1.0, 0.0, 3.0, -7.0, 6.0, -7.0, 6.0, -8.0, -4.0, -6.0, 3.0, -2.0, 5.0, -2.0, 6.0));
	blockB[nonuniformEXT(0)].c = (ivec3(-5, -5, -2));
	blockB[nonuniformEXT(0)].d = (mat3x4(-2.0, 7.0, -2.0, 1.0, 3.0, -9.0, -2.0, -7.0, 9.0, -9.0, 4.0, -1.0));
	blockB[nonuniformEXT(1)].a = (mat4(8.0, 4.0, -4.0, 0.0, 7.0, 6.0, 5.0, 3.0, 3.0, -4.0, -6.0, 4.0, 2.0, -6.0, 7.0, -8.0));
	blockB[nonuniformEXT(1)].c = (ivec3(6, 8, 9));
	blockB[nonuniformEXT(1)].d = (mat3x4(0.0, -7.0, -6.0, -3.0, 8.0, 1.0, -3.0, 0.0, 7.0, -5.0, -5.0, 7.0));
}
#version 450
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
	mediump vec2 a;
	mediump mat4 b;
	i8vec4 c;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB[nonuniformEXT(0)].a), vec2(-8.0, -8.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[nonuniformEXT(0)].c), ivec4(5, 4294967290, 5, 4294967287)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(1)].a), vec2(-2.0, 4.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[nonuniformEXT(1)].c), ivec4(4294967295, 5, 4294967287, 2)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(2)].a), vec2(3.0, 2.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[nonuniformEXT(2)].c), ivec4(2, 9, 4294967292, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (vec2(-2.0, -9.0));
	blockB[nonuniformEXT(0)].b = (mat4(-3.0, -1.0, -2.0, 7.0, -7.0, -6.0, -5.0, -9.0, 4.0, -6.0, 2.0, 6.0, 4.0, 6.0, -5.0, 2.0));
	blockB[nonuniformEXT(0)].c = i8vec4(ivec4(4294967287, 4294967288, 3, 6));
	blockB[nonuniformEXT(1)].a = (vec2(-6.0, 5.0));
	blockB[nonuniformEXT(1)].b = (mat4(6.0, -6.0, 3.0, 7.0, -8.0, -2.0, -6.0, -3.0, 0.0, 7.0, -1.0, -5.0, -8.0, 9.0, 7.0, -9.0));
	blockB[nonuniformEXT(1)].c = i8vec4(ivec4(4294967288, 4294967292, 0, 4294967293));
	blockB[nonuniformEXT(2)].a = (vec2(9.0, 9.0));
	blockB[nonuniformEXT(2)].b = (mat4(-2.0, 2.0, -6.0, 0.0, -6.0, -6.0, -4.0, -9.0, 4.0, -5.0, 8.0, 8.0, -3.0, -1.0, 2.0, -2.0));
	blockB[nonuniformEXT(2)].c = i8vec4(ivec4(2, 4294967295, 7, 4294967295));
}
#version 450
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
	lowp vec3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((var), vec3(3.0, 4.0, -9.0)) && allOk;
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
	highp mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var, mat2(0.0, -4.0, 9.0, -2.0)) && allOk;
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
	lowp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var, mat4(2.0, 7.0, 4.0, -4.0, -1.0, -9.0, -2.0, 4.0, -5.0, -5.0, -7.0, -8.0, 5.0, 2.0, -1.0, 0.0)) && allOk;
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
	highp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var, mat4(7.0, -6.0, 3.0, 6.0, 7.0, -2.0, -2.0, 0.0, 5.0, -3.0, -7.0, -1.0, 9.0, 7.0, -8.0, 7.0)) && allOk;
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

}
#version 450
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

}
#version 450
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
	lowp mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -5.0) && allOk;
	allOk = compare_float(var[0][1], -7.0) && allOk;
	allOk = compare_float(var[0][2], -6.0) && allOk;
	allOk = compare_float(var[1][0], 9.0) && allOk;
	allOk = compare_float(var[1][1], 3.0) && allOk;
	allOk = compare_float(var[1][2], -4.0) && allOk;
	allOk = compare_float(var[2][0], 9.0) && allOk;
	allOk = compare_float(var[2][1], 6.0) && allOk;
	allOk = compare_float(var[2][2], -6.0) && allOk;
	allOk = compare_float(var[3][0], 1.0) && allOk;
	allOk = compare_float(var[3][1], 8.0) && allOk;
	allOk = compare_float(var[3][2], 1.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-5.0, -7.0, -6.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(9.0, 3.0, -4.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(9.0, 6.0, -6.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(1.0, 8.0, 1.0)) && allOk;
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

layout(std430, column_major, binding = 1) readonly buffer Block
{
	mediump mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var, mat2(8.0, -6.0, -2.0, 7.0)) && allOk;
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

layout(std430, column_major, binding = 1) readonly buffer Block
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

layout(std430, column_major, binding = 1) readonly buffer Block
{
	lowp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -7.0) && allOk;
	allOk = compare_float(var[0][1], 5.0) && allOk;
	allOk = compare_float(var[0][2], -8.0) && allOk;
	allOk = compare_float(var[0][3], -5.0) && allOk;
	allOk = compare_float(var[1][0], 6.0) && allOk;
	allOk = compare_float(var[1][1], -3.0) && allOk;
	allOk = compare_float(var[1][2], -2.0) && allOk;
	allOk = compare_float(var[1][3], 1.0) && allOk;
	allOk = compare_float(var[2][0], -6.0) && allOk;
	allOk = compare_float(var[2][1], 2.0) && allOk;
	allOk = compare_float(var[2][2], -7.0) && allOk;
	allOk = compare_float(var[2][3], -4.0) && allOk;
	allOk = compare_float(var[3][0], 2.0) && allOk;
	allOk = compare_float(var[3][1], -6.0) && allOk;
	allOk = compare_float(var[3][2], -4.0) && allOk;
	allOk = compare_float(var[3][3], -7.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-7.0, 5.0, -8.0, -5.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(6.0, -3.0, -2.0, 1.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-6.0, 2.0, -7.0, -4.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(2.0, -6.0, -4.0, -7.0)) && allOk;
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

}
#version 450
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

}
#version 450
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
	highp mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 0.0) && allOk;
	allOk = compare_float(var[0][1], 0.0) && allOk;
	allOk = compare_float(var[0][2], -7.0) && allOk;
	allOk = compare_float(var[0][3], -7.0) && allOk;
	allOk = compare_float(var[1][0], -7.0) && allOk;
	allOk = compare_float(var[1][1], -1.0) && allOk;
	allOk = compare_float(var[1][2], 5.0) && allOk;
	allOk = compare_float(var[1][3], 0.0) && allOk;
	allOk = compare_float(var[2][0], -6.0) && allOk;
	allOk = compare_float(var[2][1], 1.0) && allOk;
	allOk = compare_float(var[2][2], -2.0) && allOk;
	allOk = compare_float(var[2][3], -9.0) && allOk;
	allOk = compare_vec4(var[0], vec4(0.0, 0.0, -7.0, -7.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-7.0, -1.0, 5.0, 0.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-6.0, 1.0, -2.0, -9.0)) && allOk;
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
	highp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -3.0) && allOk;
	allOk = compare_float(var[0][1], -6.0) && allOk;
	allOk = compare_float(var[1][0], 1.0) && allOk;
	allOk = compare_float(var[1][1], 7.0) && allOk;
	allOk = compare_float(var[2][0], 5.0) && allOk;
	allOk = compare_float(var[2][1], -7.0) && allOk;
	allOk = compare_float(var[3][0], 1.0) && allOk;
	allOk = compare_float(var[3][1], -5.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-3.0, -6.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(1.0, 7.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(5.0, -7.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(1.0, -5.0)) && allOk;
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
	highp mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], 2.0) && allOk;
	allOk = compare_float(var[0][2], -6.0) && allOk;
	allOk = compare_float(var[1][0], -2.0) && allOk;
	allOk = compare_float(var[1][1], 6.0) && allOk;
	allOk = compare_float(var[1][2], 2.0) && allOk;
	allOk = compare_float(var[2][0], 6.0) && allOk;
	allOk = compare_float(var[2][1], -8.0) && allOk;
	allOk = compare_float(var[2][2], 2.0) && allOk;
	allOk = compare_float(var[3][0], 0.0) && allOk;
	allOk = compare_float(var[3][1], -4.0) && allOk;
	allOk = compare_float(var[3][2], 8.0) && allOk;
	allOk = compare_vec3(var[0], vec3(1.0, 2.0, -6.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-2.0, 6.0, 2.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(6.0, -8.0, 2.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(0.0, -4.0, 8.0)) && allOk;
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
	highp vec3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_vec3((var), vec3(-3.0, -9.0, 4.0)) && allOk;
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
	lowp vec4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_vec4((var), vec4(4.0, 3.0, 0.0, -1.0)) && allOk;
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
	mediump mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -9.0) && allOk;
	allOk = compare_mat4(var, mat4(2.0, 5.0, 5.0, 7.0, -4.0, 0.0, 3.0, 4.0, -6.0, -8.0, 5.0, 5.0, 1.0, 4.0, 5.0, -7.0)) && allOk;
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
	highp mat3x4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0], mat3x4(6.0, 7.0, 2.0, -5.0, -4.0, 6.0, 5.0, 2.0, 9.0, -7.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(5.0, -9.0, 0.0, -9.0, -4.0, 7.0, -1.0, -8.0, -5.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(-1.0, -5.0, -7.0, -9.0, 6.0, -8.0, -6.0, -8.0, 5.0, 1.0, 9.0, 3.0)) && allOk;
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
	highp vec4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((var[0]), vec4(-5.0, 4.0, -4.0, 6.0)) && allOk;
	allOk = compare_vec4((var[1]), vec4(1.0, 4.0, 8.0, 7.0)) && allOk;
	allOk = compare_vec4((var[2]), vec4(2.0, -4.0, 3.0, -8.0)) && allOk;
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

}
#version 450
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
	highp mat3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -6.0) && allOk;
	allOk = compare_mat3(var[0], mat3(-8.0, -3.0, -9.0, -1.0, 8.0, 8.0, 3.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(1.0, 3.0, 0.0, -1.0, -1.0, -1.0, 5.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(1.0, -7.0, 1.0, 3.0, 1.0, 1.0, 4.0, 0.0, -2.0)) && allOk;
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

}
#version 450
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

}
#version 450
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
	highp ivec2 var[];
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((var[0]), ivec2(6, -1)) && allOk;
	allOk = compare_ivec2((var[1]), ivec2(7, -5)) && allOk;
	allOk = compare_ivec2((var[2]), ivec2(-8, 8)) && allOk;
	allOk = compare_ivec2((var[3]), ivec2(-2, -6)) && allOk;
	allOk = compare_ivec2((var[4]), ivec2(6, 2)) && allOk;
	allOk = compare_ivec2((var[5]), ivec2(-2, 7)) && allOk;
	allOk = compare_ivec2((var[6]), ivec2(-1, -1)) && allOk;
	allOk = compare_ivec2((var[7]), ivec2(0, 8)) && allOk;
	allOk = compare_ivec2((var[8]), ivec2(-9, -5)) && allOk;
	allOk = compare_ivec2((var[9]), ivec2(6, 4)) && allOk;
	allOk = compare_ivec2((var[10]), ivec2(-8, 3)) && allOk;
	allOk = compare_ivec2((var[11]), ivec2(7, -6)) && allOk;
	allOk = compare_ivec2((var[12]), ivec2(-4, 1)) && allOk;
	allOk = compare_ivec2((var[13]), ivec2(-3, -1)) && allOk;
	allOk = compare_ivec2((var[14]), ivec2(2, 1)) && allOk;
	allOk = compare_ivec2((var[15]), ivec2(-4, -3)) && allOk;
	allOk = compare_ivec2((var[16]), ivec2(-9, 0)) && allOk;
	allOk = compare_ivec2((var[17]), ivec2(9, 8)) && allOk;
	allOk = compare_ivec2((var[18]), ivec2(6, 3)) && allOk;
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

layout(std430, row_major, binding = 1) readonly buffer Block
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

}
#version 450
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
	highp mat2 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0], mat2(-4.0, 3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(5.0, 5.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(-2.0, 2.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2(var[3], mat2(-7.0, 9.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2(var[4], mat2(9.0, -6.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat2(var[5], mat2(-7.0, 3.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2(var[6], mat2(5.0, 6.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2(var[7], mat2(3.0, -4.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2(var[8], mat2(-8.0, -4.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2(var[9], mat2(2.0, 7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat2(var[10], mat2(2.0, 4.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2(var[11], mat2(9.0, 6.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat2(var[12], mat2(-8.0, 5.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2(var[13], mat2(3.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat2(var[14], mat2(6.0, 6.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat2(var[15], mat2(0.0, -7.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat2(var[16], mat2(-9.0, 1.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(var[17], mat2(4.0, -2.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat2(var[18], mat2(9.0, -5.0, -8.0, 5.0)) && allOk;
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
	allOk = compare_float(block.var[0][1], -8.0) && allOk;
	allOk = compare_float(block.var[0][2], 8.0) && allOk;
	allOk = compare_float(block.var[1][0], 1.0) && allOk;
	allOk = compare_float(block.var[1][1], -6.0) && allOk;
	allOk = compare_float(block.var[1][2], 9.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-2.0, -8.0, 8.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(1.0, -6.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(9.0, 8.0, -4.0));
	block.var[1] = (vec3(-4.0, 3.0, 2.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var, mat3x4(0.0, -1.0, -5.0, -6.0, 6.0, 0.0, -7.0, 9.0, -6.0, 0.0, 3.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(-3.0, 9.0, -6.0, 8.0));
	block.var[1] = (vec4(-2.0, 6.0, 9.0, -3.0));
	block.var[2] = (vec4(9.0, 2.0, -9.0, -9.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(block.var, mat4x3(3.0, 8.0, -1.0, 9.0, 0.0, 0.0, 0.0, -4.0, 3.0, 0.0, 0.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(-8.0, 1.0, -9.0));
	block.var[1] = (vec3(8.0, 5.0, -4.0));
	block.var[2] = (vec3(7.0, -3.0, -3.0));
	block.var[3] = (vec3(2.0, -7.0, 4.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var, mat4x3(1.0, 3.0, -8.0, 6.0, -6.0, -5.0, -8.0, 8.0, 3.0, 4.0, -2.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x3(8.0, -8.0, 6.0, 8.0, 3.0, -3.0, 9.0, 7.0, 3.0, -6.0, 6.0, 0.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 1.0) && allOk;
	allOk = compare_float(block.var[0][1], -4.0) && allOk;
	allOk = compare_float(block.var[0][2], -8.0) && allOk;
	allOk = compare_float(block.var[1][0], 6.0) && allOk;
	allOk = compare_float(block.var[1][1], 7.0) && allOk;
	allOk = compare_float(block.var[1][2], 7.0) && allOk;
	allOk = compare_float(block.var[2][0], -4.0) && allOk;
	allOk = compare_float(block.var[2][1], -1.0) && allOk;
	allOk = compare_float(block.var[2][2], 6.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(1.0, -4.0, -8.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(6.0, 7.0, 7.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(-4.0, -1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(-1.0, 3.0, -1.0));
	block.var[1] = (vec3(-2.0, -4.0, 1.0));
	block.var[2] = (vec3(2.0, 9.0, -2.0));
}
#version 450
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
	allOk = compare_mat4(block.var, mat4(-3.0, 2.0, 9.0, -4.0, -9.0, -4.0, -5.0, -8.0, 0.0, -8.0, 6.0, -4.0, -6.0, -7.0, -3.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4(2.0, 5.0, 1.0, -7.0, -8.0, 5.0, 6.0, 2.0, -2.0, 6.0, 3.0, -3.0, 5.0, -8.0, 1.0, 1.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var, mat2x4(-7.0, -7.0, 7.0, -4.0, -5.0, -3.0, 1.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x4(-4.0, 9.0, -1.0, 0.0, 4.0, -8.0, 1.0, 9.0));
}
#version 450
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
	allOk = compare_float((block.padding), -1.0) && allOk;
	allOk = compare_float(block.var[0][0], 0.0) && allOk;
	allOk = compare_float(block.var[0][1], 7.0) && allOk;
	allOk = compare_float(block.var[0][2], -6.0) && allOk;
	allOk = compare_float(block.var[0][3], 5.0) && allOk;
	allOk = compare_float(block.var[1][0], 5.0) && allOk;
	allOk = compare_float(block.var[1][1], 0.0) && allOk;
	allOk = compare_float(block.var[1][2], 1.0) && allOk;
	allOk = compare_float(block.var[1][3], -6.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(0.0, 7.0, -6.0, 5.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(5.0, 0.0, 1.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (1.0);
	block.var[0] = (vec4(-3.0, 7.0, -9.0, 5.0));
	block.var[1] = (vec4(8.0, -8.0, 9.0, -7.0));
}
#version 450
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
	allOk = compare_float((block.padding), -3.0) && allOk;
	allOk = compare_float(block.var[0][0], 1.0) && allOk;
	allOk = compare_float(block.var[0][1], 7.0) && allOk;
	allOk = compare_float(block.var[1][0], 5.0) && allOk;
	allOk = compare_float(block.var[1][1], -7.0) && allOk;
	allOk = compare_float(block.var[2][0], 1.0) && allOk;
	allOk = compare_float(block.var[2][1], -5.0) && allOk;
	allOk = compare_float(block.var[3][0], -6.0) && allOk;
	allOk = compare_float(block.var[3][1], -2.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(1.0, 7.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(5.0, -7.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(1.0, -5.0)) && allOk;
	allOk = compare_vec2(block.var[3], vec2(-6.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-5.0);
	block.var = (mat4x2(7.0, -1.0, -3.0, 6.0, 9.0, -7.0, 5.0, 8.0));
}
#version 450
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
	i8vec2 var;
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
	allOk = compare_i8vec2(ivec2(block.var), ivec2(4294967293, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = int8_t(0);
	block.var = i8vec2(ivec2(8, 4294967292));
}
#version 450
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
	allOk = compare_mat3(block.var[0], mat3(-7.0, -8.0, -9.0, -8.0, 8.0, 6.0, 6.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(9.0, 5.0, -2.0, 9.0, -8.0, 6.0, -3.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(-1.0, -5.0, -7.0, -6.0, 8.0, 8.0, -2.0, -7.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3(-6.0, 9.0, 1.0, 4.0, -8.0, 5.0, 7.0, 2.0, 2.0));
	block.var[1] = (mat3(8.0, -8.0, -2.0, 2.0, 8.0, 4.0, 2.0, 1.0, 7.0));
	block.var[2] = (mat3(-2.0, 5.0, 7.0, 4.0, 7.0, -3.0, 9.0, 1.0, 9.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0], mat2(8.0, -8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(0.0, -4.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(-7.0, -4.0, 6.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec2(-3.0, 3.0));
	block.var[0][1] = (vec2(4.0, 4.0));
	block.var[1][0] = (vec2(9.0, -9.0));
	block.var[1][1] = (vec2(-5.0, 8.0));
	block.var[2][0] = (vec2(0.0, 4.0));
	block.var[2][1] = (vec2(2.0, -4.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0], mat3x2(-2.0, -4.0, -6.0, 5.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[1], mat3x2(2.0, 5.0, 9.0, -1.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[2], mat3x2(-6.0, -2.0, -3.0, 2.0, 7.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3x2(2.0, -1.0, 2.0, -8.0, -4.0, 9.0));
	block.var[1] = (mat3x2(6.0, 8.0, 5.0, -7.0, -7.0, 0.0));
	block.var[2] = (mat3x2(5.0, 8.0, 1.0, -4.0, 1.0, 3.0));
}
#version 450
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
	highp mat3x4 var[3];
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
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_mat3x4(block.var[0], mat3x4(-7.0, 8.0, -7.0, -5.0, 5.0, -2.0, -5.0, -5.0, 8.0, -6.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[1], mat3x4(-1.0, -9.0, 0.0, -5.0, -1.0, -2.0, -3.0, -8.0, -3.0, -5.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[2], mat3x4(-1.0, -1.0, 2.0, 5.0, -7.0, -3.0, 8.0, -6.0, -8.0, 6.0, 3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-2.0);
	block.var[0][0] = (vec4(-8.0, -4.0, 1.0, -8.0));
	block.var[0][1] = (vec4(-4.0, 3.0, 6.0, -4.0));
	block.var[0][2] = (vec4(-8.0, -5.0, 9.0, -4.0));
	block.var[1][0] = (vec4(0.0, 7.0, -9.0, 4.0));
	block.var[1][1] = (vec4(-4.0, -4.0, -8.0, 9.0));
	block.var[1][2] = (vec4(-7.0, 6.0, -4.0, 2.0));
	block.var[2][0] = (vec4(-1.0, -7.0, 7.0, 1.0));
	block.var[2][1] = (vec4(0.0, 4.0, 1.0, -9.0));
	block.var[2][2] = (vec4(-7.0, 2.0, -6.0, 3.0));
}
#version 450
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
	highp mat3x4 var[];
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
	allOk = compare_mat3x4(block.var[0], mat3x4(2.0, 9.0, 7.0, -5.0, 2.0, 3.0, 6.0, 6.0, 9.0, -9.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1], mat3x4(-4.0, 6.0, 9.0, 4.0, 9.0, 3.0, 2.0, -4.0, -7.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2], mat3x4(3.0, -5.0, 6.0, -3.0, 3.0, 2.0, 7.0, -3.0, -7.0, 0.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[3], mat3x4(-9.0, 6.0, 1.0, 3.0, -1.0, 8.0, -8.0, 6.0, -4.0, 9.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[4], mat3x4(6.0, 2.0, 4.0, -4.0, -1.0, -1.0, 6.0, 3.0, 5.0, -7.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[5], mat3x4(6.0, 4.0, -9.0, 9.0, 0.0, -6.0, -5.0, 8.0, 5.0, -9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[6], mat3x4(8.0, 9.0, -9.0, -3.0, 9.0, -7.0, 7.0, 3.0, 7.0, -5.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[7], mat3x4(-7.0, 2.0, 6.0, -9.0, -3.0, -3.0, 7.0, -4.0, 6.0, -9.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[8], mat3x4(-3.0, -4.0, 1.0, -5.0, 9.0, -1.0, 0.0, 0.0, 1.0, 9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[9], mat3x4(4.0, 7.0, 7.0, -7.0, -1.0, 1.0, 0.0, 6.0, 5.0, -6.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[10], mat3x4(9.0, -4.0, 1.0, -5.0, 8.0, -9.0, -6.0, 4.0, 2.0, -7.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[11], mat3x4(-7.0, -3.0, -6.0, 4.0, 5.0, -8.0, -6.0, 9.0, -3.0, 9.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[12], mat3x4(-7.0, -9.0, 9.0, 4.0, 9.0, 5.0, -2.0, -3.0, 8.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[13], mat3x4(1.0, 1.0, -3.0, 0.0, -6.0, -1.0, -5.0, -8.0, -9.0, -1.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[14], mat3x4(9.0, 0.0, -8.0, 0.0, -8.0, 1.0, -3.0, 3.0, -4.0, -9.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[15], mat3x4(-4.0, -3.0, 7.0, 1.0, -8.0, -8.0, -5.0, 8.0, -6.0, 9.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[16], mat3x4(-9.0, -2.0, 7.0, -7.0, 5.0, -9.0, 2.0, 8.0, 1.0, 1.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[17], mat3x4(-1.0, -3.0, 3.0, -5.0, 9.0, -5.0, 3.0, 9.0, 7.0, 0.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[18], mat3x4(8.0, -7.0, 0.0, 6.0, 2.0, -6.0, 7.0, -8.0, -5.0, 4.0, -3.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec4(8.0, 8.0, -2.0, 8.0));
	block.var[0][1] = (vec4(8.0, 3.0, 5.0, -5.0));
	block.var[0][2] = (vec4(7.0, 6.0, -9.0, 3.0));
	block.var[1][0] = (vec4(0.0, -3.0, 1.0, -9.0));
	block.var[1][1] = (vec4(-9.0, -6.0, -5.0, 1.0));
	block.var[1][2] = (vec4(9.0, 0.0, -9.0, -2.0));
	block.var[2][0] = (vec4(-4.0, -3.0, -1.0, -6.0));
	block.var[2][1] = (vec4(1.0, -2.0, -2.0, -1.0));
	block.var[2][2] = (vec4(-7.0, 8.0, 0.0, -6.0));
	block.var[3][0] = (vec4(-1.0, 7.0, -6.0, -1.0));
	block.var[3][1] = (vec4(-7.0, -8.0, 7.0, -8.0));
	block.var[3][2] = (vec4(6.0, -8.0, 2.0, -5.0));
	block.var[4][0] = (vec4(9.0, -7.0, 4.0, -1.0));
	block.var[4][1] = (vec4(-3.0, -8.0, -1.0, 1.0));
	block.var[4][2] = (vec4(-6.0, -4.0, -8.0, 4.0));
	block.var[5][0] = (vec4(5.0, 0.0, -6.0, 5.0));
	block.var[5][1] = (vec4(-1.0, 4.0, 3.0, -6.0));
	block.var[5][2] = (vec4(1.0, 8.0, -2.0, 3.0));
	block.var[6][0] = (vec4(-1.0, -9.0, 4.0, 9.0));
	block.var[6][1] = (vec4(0.0, 2.0, -7.0, -7.0));
	block.var[6][2] = (vec4(-1.0, 8.0, -9.0, -3.0));
	block.var[7][0] = (vec4(5.0, 7.0, -8.0, 1.0));
	block.var[7][1] = (vec4(-5.0, 0.0, -7.0, -3.0));
	block.var[7][2] = (vec4(-5.0, -4.0, 3.0, -5.0));
	block.var[8][0] = (vec4(4.0, 5.0, -9.0, -6.0));
	block.var[8][1] = (vec4(5.0, 3.0, -6.0, -7.0));
	block.var[8][2] = (vec4(-3.0, 9.0, 3.0, -7.0));
	block.var[9][0] = (vec4(-9.0, -9.0, 6.0, -9.0));
	block.var[9][1] = (vec4(6.0, -1.0, -1.0, -4.0));
	block.var[9][2] = (vec4(5.0, 2.0, -6.0, 8.0));
	block.var[10][0] = (vec4(4.0, 2.0, 4.0, -3.0));
	block.var[10][1] = (vec4(9.0, 8.0, 5.0, -3.0));
	block.var[10][2] = (vec4(7.0, -4.0, 6.0, 4.0));
	block.var[11][0] = (vec4(0.0, -2.0, 1.0, 8.0));
	block.var[11][1] = (vec4(1.0, 4.0, 6.0, 4.0));
	block.var[11][2] = (vec4(-2.0, 9.0, 9.0, 7.0));
	block.var[12][0] = (vec4(4.0, -1.0, 2.0, -8.0));
	block.var[12][1] = (vec4(-6.0, 4.0, -8.0, 9.0));
	block.var[12][2] = (vec4(0.0, 7.0, -2.0, 2.0));
	block.var[13][0] = (vec4(2.0, 9.0, -9.0, 2.0));
	block.var[13][1] = (vec4(1.0, 5.0, 5.0, 5.0));
	block.var[13][2] = (vec4(0.0, 9.0, 8.0, 7.0));
	block.var[14][0] = (vec4(7.0, 5.0, -7.0, -6.0));
	block.var[14][1] = (vec4(-4.0, 4.0, -5.0, -7.0));
	block.var[14][2] = (vec4(2.0, 2.0, 1.0, -7.0));
	block.var[15][0] = (vec4(1.0, -1.0, 9.0, -4.0));
	block.var[15][1] = (vec4(4.0, 1.0, 7.0, -4.0));
	block.var[15][2] = (vec4(1.0, 9.0, -7.0, 4.0));
	block.var[16][0] = (vec4(-2.0, 5.0, -1.0, 9.0));
	block.var[16][1] = (vec4(-9.0, -6.0, 3.0, 7.0));
	block.var[16][2] = (vec4(-1.0, -6.0, 3.0, -3.0));
	block.var[17][0] = (vec4(1.0, 7.0, 2.0, -9.0));
	block.var[17][1] = (vec4(0.0, -8.0, -8.0, 4.0));
	block.var[17][2] = (vec4(7.0, 6.0, 8.0, -2.0));
	block.var[18][0] = (vec4(8.0, 9.0, -2.0, -1.0));
	block.var[18][1] = (vec4(7.0, -4.0, -8.0, 9.0));
	block.var[18][2] = (vec4(-5.0, 7.0, 9.0, -6.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0], mat4x2(-2.0, 6.0, 5.0, 7.0, 1.0, -5.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1], mat4x2(4.0, -5.0, -7.0, -4.0, 7.0, 7.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2], mat4x2(-1.0, 7.0, -9.0, -7.0, -1.0, 8.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0], mat4x2(-4.0, 7.0, -5.0, -3.0, 4.0, 7.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1], mat4x2(9.0, -5.0, 9.0, 2.0, -1.0, -1.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2], mat4x2(-6.0, -7.0, 4.0, 4.0, 9.0, -9.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0], mat4x2(-1.0, -8.0, 5.0, -8.0, 2.0, 3.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1], mat4x2(0.0, 4.0, -8.0, -3.0, -1.0, 4.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2], mat4x2(4.0, 5.0, -7.0, 1.0, 0.0, -9.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0], mat4x2(-2.0, 4.0, -8.0, 5.0, -3.0, 8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1], mat4x2(5.0, -9.0, 5.0, -2.0, -8.0, -1.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][2], mat4x2(3.0, 5.0, 1.0, 5.0, -3.0, -4.0, 7.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec2(6.0, 9.0));
	block.var[0][0][1] = (vec2(-4.0, -4.0));
	block.var[0][0][2] = (vec2(2.0, 0.0));
	block.var[0][0][3] = (vec2(-7.0, 3.0));
	block.var[0][1][0] = (vec2(9.0, -6.0));
	block.var[0][1][1] = (vec2(8.0, -9.0));
	block.var[0][1][2] = (vec2(-9.0, -6.0));
	block.var[0][1][3] = (vec2(-4.0, -6.0));
	block.var[0][2][0] = (vec2(-8.0, 5.0));
	block.var[0][2][1] = (vec2(6.0, -8.0));
	block.var[0][2][2] = (vec2(-8.0, 3.0));
	block.var[0][2][3] = (vec2(2.0, 8.0));
	block.var[1][0][0] = (vec2(-8.0, -1.0));
	block.var[1][0][1] = (vec2(-3.0, 0.0));
	block.var[1][0][2] = (vec2(7.0, 5.0));
	block.var[1][0][3] = (vec2(-8.0, 5.0));
	block.var[1][1][0] = (vec2(7.0, 8.0));
	block.var[1][1][1] = (vec2(4.0, -2.0));
	block.var[1][1][2] = (vec2(4.0, -2.0));
	block.var[1][1][3] = (vec2(-2.0, 9.0));
	block.var[1][2][0] = (vec2(4.0, -4.0));
	block.var[1][2][1] = (vec2(-5.0, -5.0));
	block.var[1][2][2] = (vec2(-6.0, 8.0));
	block.var[1][2][3] = (vec2(9.0, -5.0));
	block.var[2][0][0] = (vec2(-2.0, 1.0));
	block.var[2][0][1] = (vec2(6.0, -2.0));
	block.var[2][0][2] = (vec2(2.0, -5.0));
	block.var[2][0][3] = (vec2(3.0, -3.0));
	block.var[2][1][0] = (vec2(-6.0, -4.0));
	block.var[2][1][1] = (vec2(-6.0, -7.0));
	block.var[2][1][2] = (vec2(9.0, 1.0));
	block.var[2][1][3] = (vec2(-4.0, 3.0));
	block.var[2][2][0] = (vec2(7.0, -9.0));
	block.var[2][2][1] = (vec2(7.0, -4.0));
	block.var[2][2][2] = (vec2(8.0, -2.0));
	block.var[2][2][3] = (vec2(9.0, 0.0));
	block.var[3][0][0] = (vec2(-9.0, 7.0));
	block.var[3][0][1] = (vec2(1.0, 4.0));
	block.var[3][0][2] = (vec2(-7.0, 9.0));
	block.var[3][0][3] = (vec2(-5.0, 2.0));
	block.var[3][1][0] = (vec2(-9.0, -3.0));
	block.var[3][1][1] = (vec2(-8.0, 5.0));
	block.var[3][1][2] = (vec2(-2.0, -8.0));
	block.var[3][1][3] = (vec2(7.0, -6.0));
	block.var[3][2][0] = (vec2(-7.0, 1.0));
	block.var[3][2][1] = (vec2(-3.0, 7.0));
	block.var[3][2][2] = (vec2(6.0, -5.0));
	block.var[3][2][3] = (vec2(9.0, -2.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0][0][0], mat4(1.0, 6.0, 7.0, 5.0, 2.0, -4.0, 0.0, 8.0, 3.0, 3.0, 9.0, 8.0, -2.0, 7.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][1], mat4(-1.0, 1.0, 9.0, 1.0, -2.0, -7.0, 3.0, 5.0, 2.0, -8.0, 8.0, -1.0, -4.0, -5.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][2], mat4(-9.0, 1.0, 1.0, -6.0, 5.0, -8.0, -6.0, -3.0, -4.0, 8.0, 9.0, -9.0, -4.0, -2.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][0], mat4(-3.0, 4.0, 8.0, 3.0, 4.0, -3.0, -4.0, -1.0, -4.0, 5.0, -4.0, 7.0, -7.0, 3.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][1], mat4(-6.0, -2.0, 6.0, 9.0, 8.0, -2.0, 0.0, 5.0, -9.0, 5.0, -1.0, 4.0, -3.0, 8.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][2], mat4(0.0, -2.0, 6.0, -1.0, 9.0, 9.0, -9.0, 0.0, 4.0, -3.0, 4.0, 1.0, -1.0, 3.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][0], mat4(-7.0, -7.0, 7.0, -7.0, 4.0, 1.0, -4.0, -7.0, 6.0, -4.0, -3.0, -1.0, -2.0, -9.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][1], mat4(0.0, -8.0, 2.0, 0.0, -4.0, 1.0, 6.0, 1.0, 2.0, -1.0, -8.0, -9.0, -1.0, -9.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][2], mat4(-8.0, -3.0, -4.0, -8.0, 3.0, 1.0, 4.0, -4.0, -2.0, 6.0, -8.0, 3.0, 7.0, 5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][0], mat4(-2.0, -2.0, 2.0, -3.0, 4.0, -1.0, 6.0, -4.0, 3.0, 0.0, 8.0, 1.0, -9.0, 8.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][1], mat4(1.0, -7.0, -9.0, 0.0, -1.0, -2.0, -1.0, 9.0, -9.0, 0.0, -4.0, -1.0, -6.0, 2.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][2], mat4(-2.0, -9.0, -3.0, 9.0, -7.0, -2.0, 7.0, 7.0, 1.0, 9.0, -4.0, 7.0, 0.0, 3.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][0], mat4(-3.0, 8.0, 3.0, 5.0, 3.0, 4.0, 5.0, 4.0, -2.0, -6.0, -8.0, -4.0, -5.0, -1.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][1], mat4(3.0, -1.0, -2.0, -6.0, -8.0, 2.0, 9.0, -9.0, 2.0, -3.0, 5.0, -1.0, -5.0, -4.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][2], mat4(9.0, 9.0, 2.0, -3.0, -5.0, 5.0, 4.0, -6.0, -7.0, -1.0, -4.0, 6.0, -7.0, -9.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][0], mat4(1.0, 6.0, -9.0, -8.0, -5.0, -5.0, 8.0, 1.0, 7.0, -6.0, -8.0, 7.0, -7.0, -3.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][1], mat4(-3.0, -8.0, 9.0, 1.0, 3.0, -9.0, 9.0, -2.0, -7.0, 2.0, 9.0, -7.0, -5.0, 5.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][2], mat4(-6.0, -4.0, -8.0, -3.0, -3.0, 0.0, 3.0, 9.0, 7.0, 2.0, 4.0, 6.0, -9.0, 8.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][0], mat4(-5.0, -1.0, 3.0, -4.0, 5.0, -7.0, -2.0, 3.0, 0.0, -1.0, 7.0, 5.0, -6.0, -1.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][1], mat4(1.0, -9.0, -6.0, 7.0, 6.0, 4.0, -5.0, 0.0, 8.0, -4.0, -3.0, -6.0, -7.0, 4.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][2], mat4(-2.0, 4.0, -8.0, 7.0, -3.0, 2.0, -9.0, -8.0, 8.0, 9.0, -5.0, 0.0, 4.0, 3.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][0], mat4(-5.0, -2.0, 1.0, -4.0, 8.0, -8.0, -5.0, -7.0, 8.0, -9.0, 4.0, 3.0, 2.0, 9.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][1], mat4(4.0, -4.0, 9.0, 3.0, -5.0, -7.0, 0.0, 3.0, -3.0, 6.0, -9.0, 9.0, 9.0, 8.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][2], mat4(9.0, 7.0, -7.0, -6.0, 0.0, -3.0, -2.0, 5.0, 2.0, -1.0, 0.0, -8.0, 1.0, -4.0, -7.0, 9.0)) && allOk;
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
	block.var[0][0][2][0] = (vec4(7.0, -2.0, -1.0, -4.0));
	block.var[0][0][2][1] = (vec4(-3.0, 3.0, -8.0, 7.0));
	block.var[0][0][2][2] = (vec4(-8.0, -5.0, -9.0, -1.0));
	block.var[0][0][2][3] = (vec4(0.0, -7.0, 7.0, 8.0));
	block.var[0][1][0][0] = (vec4(8.0, -9.0, 9.0, 7.0));
	block.var[0][1][0][1] = (vec4(-9.0, 5.0, 1.0, -4.0));
	block.var[0][1][0][2] = (vec4(-1.0, -2.0, 1.0, 5.0));
	block.var[0][1][0][3] = (vec4(-1.0, -5.0, 7.0, -6.0));
	block.var[0][1][1][0] = (vec4(1.0, 0.0, 9.0, -3.0));
	block.var[0][1][1][1] = (vec4(7.0, 0.0, -6.0, -7.0));
	block.var[0][1][1][2] = (vec4(-8.0, 1.0, -2.0, 9.0));
	block.var[0][1][1][3] = (vec4(0.0, -2.0, 6.0, -1.0));
	block.var[0][1][2][0] = (vec4(-5.0, -1.0, -3.0, 5.0));
	block.var[0][1][2][1] = (vec4(-7.0, 4.0, 5.0, -9.0));
	block.var[0][1][2][2] = (vec4(-1.0, 0.0, 8.0, 8.0));
	block.var[0][1][2][3] = (vec4(-3.0, 4.0, -4.0, -4.0));
	block.var[1][0][0][0] = (vec4(-6.0, -6.0, -1.0, 6.0));
	block.var[1][0][0][1] = (vec4(3.0, 5.0, -8.0, 3.0));
	block.var[1][0][0][2] = (vec4(1.0, -1.0, 3.0, -5.0));
	block.var[1][0][0][3] = (vec4(4.0, -4.0, 3.0, 4.0));
	block.var[1][0][1][0] = (vec4(-4.0, -8.0, 4.0, 5.0));
	block.var[1][0][1][1] = (vec4(-5.0, 0.0, -3.0, -4.0));
	block.var[1][0][1][2] = (vec4(5.0, -4.0, -7.0, 4.0));
	block.var[1][0][1][3] = (vec4(-3.0, 9.0, 3.0, -4.0));
	block.var[1][0][2][0] = (vec4(-3.0, -9.0, 6.0, -3.0));
	block.var[1][0][2][1] = (vec4(-6.0, -1.0, 8.0, 3.0));
	block.var[1][0][2][2] = (vec4(-2.0, 9.0, -2.0, -3.0));
	block.var[1][0][2][3] = (vec4(-8.0, 3.0, -8.0, 5.0));
	block.var[1][1][0][0] = (vec4(5.0, 8.0, -8.0, -1.0));
	block.var[1][1][0][1] = (vec4(-7.0, 8.0, 4.0, -1.0));
	block.var[1][1][0][2] = (vec4(-1.0, -9.0, 3.0, 2.0));
	block.var[1][1][0][3] = (vec4(4.0, -2.0, 7.0, 5.0));
	block.var[1][1][1][0] = (vec4(0.0, -5.0, 2.0, 2.0));
	block.var[1][1][1][1] = (vec4(4.0, 4.0, -9.0, 3.0));
	block.var[1][1][1][2] = (vec4(1.0, 0.0, 5.0, -8.0));
	block.var[1][1][1][3] = (vec4(-3.0, -3.0, 3.0, -6.0));
	block.var[1][1][2][0] = (vec4(-5.0, 9.0, 0.0, -6.0));
	block.var[1][1][2][1] = (vec4(-2.0, -4.0, 3.0, 1.0));
	block.var[1][1][2][2] = (vec4(4.0, 1.0, -3.0, 6.0));
	block.var[1][1][2][3] = (vec4(-2.0, -7.0, -7.0, 9.0));
	block.var[2][0][0][0] = (vec4(7.0, -2.0, -7.0, 3.0));
	block.var[2][0][0][1] = (vec4(8.0, -7.0, -6.0, 4.0));
	block.var[2][0][0][2] = (vec4(-4.0, 6.0, -2.0, -7.0));
	block.var[2][0][0][3] = (vec4(7.0, 8.0, -8.0, -2.0));
	block.var[2][0][1][0] = (vec4(-8.0, 3.0, 9.0, 3.0));
	block.var[2][0][1][1] = (vec4(1.0, -3.0, -5.0, -8.0));
	block.var[2][0][1][2] = (vec4(-7.0, 5.0, -1.0, -6.0));
	block.var[2][0][1][3] = (vec4(8.0, -8.0, 4.0, 8.0));
	block.var[2][0][2][0] = (vec4(6.0, -5.0, 4.0, -3.0));
	block.var[2][0][2][1] = (vec4(-1.0, -8.0, 3.0, 5.0));
	block.var[2][0][2][2] = (vec4(0.0, 7.0, 6.0, -4.0));
	block.var[2][0][2][3] = (vec4(1.0, 4.0, 3.0, 6.0));
	block.var[2][1][0][0] = (vec4(-2.0, -6.0, -2.0, -5.0));
	block.var[2][1][0][1] = (vec4(-9.0, 4.0, 4.0, -5.0));
	block.var[2][1][0][2] = (vec4(-1.0, -1.0, 0.0, -7.0));
	block.var[2][1][0][3] = (vec4(5.0, 7.0, -3.0, -7.0));
	block.var[2][1][1][0] = (vec4(9.0, -7.0, 5.0, 1.0));
	block.var[2][1][1][1] = (vec4(-7.0, 4.0, 8.0, -9.0));
	block.var[2][1][1][2] = (vec4(6.0, 2.0, -8.0, 8.0));
	block.var[2][1][1][3] = (vec4(3.0, 6.0, 9.0, 6.0));
	block.var[2][1][2][0] = (vec4(-4.0, -8.0, -1.0, 1.0));
	block.var[2][1][2][1] = (vec4(0.0, 5.0, 8.0, 6.0));
	block.var[2][1][2][2] = (vec4(3.0, 8.0, -7.0, -1.0));
	block.var[2][1][2][3] = (vec4(2.0, 3.0, 7.0, 3.0));
	block.var[3][0][0][0] = (vec4(-3.0, -8.0, -6.0, 5.0));
	block.var[3][0][0][1] = (vec4(-9.0, -3.0, 0.0, -1.0));
	block.var[3][0][0][2] = (vec4(-5.0, 9.0, -8.0, -9.0));
	block.var[3][0][0][3] = (vec4(-1.0, 2.0, 5.0, 6.0));
	block.var[3][0][1][0] = (vec4(2.0, 3.0, 8.0, 8.0));
	block.var[3][0][1][1] = (vec4(-7.0, -1.0, 5.0, -3.0));
	block.var[3][0][1][2] = (vec4(5.0, -3.0, -4.0, 6.0));
	block.var[3][0][1][3] = (vec4(-6.0, -5.0, 7.0, -6.0));
	block.var[3][0][2][0] = (vec4(7.0, -3.0, -8.0, 1.0));
	block.var[3][0][2][1] = (vec4(1.0, 2.0, 3.0, 1.0));
	block.var[3][0][2][2] = (vec4(5.0, -2.0, 2.0, -2.0));
	block.var[3][0][2][3] = (vec4(-9.0, -1.0, 2.0, -1.0));
	block.var[3][1][0][0] = (vec4(-2.0, -1.0, 0.0, -2.0));
	block.var[3][1][0][1] = (vec4(7.0, -6.0, 5.0, 5.0));
	block.var[3][1][0][2] = (vec4(-9.0, -8.0, -5.0, 0.0));
	block.var[3][1][0][3] = (vec4(-2.0, 3.0, 8.0, 4.0));
	block.var[3][1][1][0] = (vec4(-2.0, -3.0, -9.0, 9.0));
	block.var[3][1][1][1] = (vec4(-6.0, -1.0, -3.0, 3.0));
	block.var[3][1][1][2] = (vec4(-7.0, 5.0, -6.0, 8.0));
	block.var[3][1][1][3] = (vec4(0.0, -5.0, 0.0, 4.0));
	block.var[3][1][2][0] = (vec4(-2.0, -9.0, -1.0, -2.0));
	block.var[3][1][2][1] = (vec4(2.0, -4.0, -6.0, -5.0));
	block.var[3][1][2][2] = (vec4(4.0, -4.0, 7.0, 2.0));
	block.var[3][1][2][3] = (vec4(3.0, 2.0, -2.0, -5.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0][0][0], mat3x4(6.0, 7.0, 2.0, -5.0, -4.0, 6.0, 5.0, 2.0, 9.0, -7.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][1], mat3x4(5.0, -9.0, 0.0, -9.0, -4.0, 7.0, -1.0, -8.0, -5.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][2], mat3x4(-1.0, -5.0, -7.0, -9.0, 6.0, -8.0, -6.0, -8.0, 5.0, 1.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(8.0, 5.0, 9.0, 6.0, -3.0, 4.0, 6.0, -8.0, -9.0, -2.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(1.0, 7.0, -6.0, 3.0, 2.0, 9.0, -9.0, 1.0, 0.0, -1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][2], mat3x4(1.0, 0.0, 9.0, -2.0, -2.0, 1.0, 8.0, 0.0, 0.0, -4.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(-5.0, 7.0, -8.0, 7.0, -8.0, 4.0, 8.0, 0.0, 9.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(-9.0, 6.0, -3.0, 4.0, -1.0, 1.0, 6.0, 2.0, 4.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][2], mat3x4(-9.0, 7.0, -1.0, 8.0, -6.0, 4.0, -2.0, 6.0, 9.0, -4.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(9.0, -5.0, 2.0, 8.0, -5.0, -3.0, -6.0, 9.0, -7.0, -7.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(2.0, 0.0, -2.0, -7.0, 6.0, -9.0, 9.0, -6.0, 3.0, -2.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][2], mat3x4(-5.0, 4.0, 0.0, 2.0, 9.0, 7.0, -3.0, 3.0, 5.0, 2.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(-8.0, 1.0, -8.0, -8.0, 5.0, -8.0, 1.0, 0.0, -6.0, 3.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(-9.0, 9.0, -5.0, 3.0, 0.0, 0.0, -5.0, -9.0, -9.0, 7.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][2], mat3x4(-5.0, -8.0, -1.0, -1.0, -2.0, 1.0, 5.0, 7.0, 6.0, 6.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(-8.0, -4.0, 5.0, -8.0, -2.0, -1.0, -3.0, 5.0, 7.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(0.0, 0.0, -6.0, 6.0, -6.0, -9.0, 8.0, 2.0, 6.0, 0.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][2], mat3x4(-2.0, 4.0, -9.0, -3.0, -4.0, 1.0, -6.0, -1.0, -7.0, -6.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][0], mat3x4(8.0, 4.0, 7.0, 2.0, -3.0, -4.0, 8.0, 3.0, 2.0, -5.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][1], mat3x4(7.0, -3.0, -3.0, 1.0, 8.0, 3.0, 5.0, 6.0, 8.0, 1.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][2], mat3x4(9.0, 2.0, 5.0, 7.0, -4.0, 2.0, 1.0, 6.0, -3.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][0], mat3x4(-5.0, -5.0, 3.0, 2.0, 1.0, -9.0, 5.0, -2.0, -9.0, 4.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][1], mat3x4(-2.0, 4.0, -7.0, -4.0, 3.0, 6.0, 0.0, -2.0, -7.0, 2.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][2], mat3x4(-8.0, 6.0, -6.0, 2.0, 7.0, 0.0, 4.0, -6.0, 5.0, 3.0, -8.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(-3.0, -5.0, 2.0, 5.0));
	block.var[0][0][0][1] = (vec4(-2.0, -3.0, 9.0, -2.0));
	block.var[0][0][0][2] = (vec4(-6.0, 7.0, 4.0, -6.0));
	block.var[0][0][1][0] = (vec4(2.0, 6.0, 9.0, -2.0));
	block.var[0][0][1][1] = (vec4(7.0, 9.0, 0.0, 0.0));
	block.var[0][0][1][2] = (vec4(8.0, -3.0, 0.0, 3.0));
	block.var[0][0][2][0] = (vec4(-6.0, 1.0, 9.0, 6.0));
	block.var[0][0][2][1] = (vec4(-9.0, -9.0, 2.0, -4.0));
	block.var[0][0][2][2] = (vec4(-8.0, 5.0, -1.0, 9.0));
	block.var[0][1][0][0] = (vec4(0.0, 7.0, 3.0, -7.0));
	block.var[0][1][0][1] = (vec4(-7.0, 7.0, -4.0, -5.0));
	block.var[0][1][0][2] = (vec4(-8.0, -8.0, -7.0, 4.0));
	block.var[0][1][1][0] = (vec4(6.0, -3.0, 8.0, -1.0));
	block.var[0][1][1][1] = (vec4(-4.0, 8.0, 8.0, 1.0));
	block.var[0][1][1][2] = (vec4(-8.0, -7.0, 5.0, -9.0));
	block.var[0][1][2][0] = (vec4(1.0, -8.0, 2.0, -2.0));
	block.var[0][1][2][1] = (vec4(-8.0, -9.0, 1.0, -3.0));
	block.var[0][1][2][2] = (vec4(-4.0, 3.0, -9.0, 6.0));
	block.var[1][0][0][0] = (vec4(8.0, -2.0, 1.0, 1.0));
	block.var[1][0][0][1] = (vec4(-6.0, -1.0, -9.0, 6.0));
	block.var[1][0][0][2] = (vec4(7.0, -1.0, 1.0, -8.0));
	block.var[1][0][1][0] = (vec4(6.0, 8.0, -2.0, 7.0));
	block.var[1][0][1][1] = (vec4(1.0, -6.0, -3.0, 9.0));
	block.var[1][0][1][2] = (vec4(1.0, -6.0, 1.0, -6.0));
	block.var[1][0][2][0] = (vec4(3.0, -1.0, 5.0, -2.0));
	block.var[1][0][2][1] = (vec4(7.0, -1.0, -2.0, -3.0));
	block.var[1][0][2][2] = (vec4(-6.0, 4.0, -4.0, -1.0));
	block.var[1][1][0][0] = (vec4(-8.0, 3.0, -5.0, 6.0));
	block.var[1][1][0][1] = (vec4(9.0, 2.0, -1.0, 8.0));
	block.var[1][1][0][2] = (vec4(-2.0, 5.0, -2.0, 6.0));
	block.var[1][1][1][0] = (vec4(1.0, 2.0, 8.0, -3.0));
	block.var[1][1][1][1] = (vec4(6.0, -3.0, -8.0, 2.0));
	block.var[1][1][1][2] = (vec4(-6.0, -8.0, 3.0, 3.0));
	block.var[1][1][2][0] = (vec4(0.0, 9.0, 4.0, -8.0));
	block.var[1][1][2][1] = (vec4(-7.0, 6.0, -4.0, -8.0));
	block.var[1][1][2][2] = (vec4(2.0, 9.0, 1.0, 0.0));
	block.var[2][0][0][0] = (vec4(-3.0, -3.0, 3.0, -7.0));
	block.var[2][0][0][1] = (vec4(2.0, 8.0, -4.0, 1.0));
	block.var[2][0][0][2] = (vec4(-1.0, 6.0, -4.0, 7.0));
	block.var[2][0][1][0] = (vec4(5.0, -8.0, -2.0, 6.0));
	block.var[2][0][1][1] = (vec4(-2.0, 8.0, -2.0, 2.0));
	block.var[2][0][1][2] = (vec4(3.0, 7.0, 0.0, 2.0));
	block.var[2][0][2][0] = (vec4(3.0, 9.0, 8.0, 5.0));
	block.var[2][0][2][1] = (vec4(2.0, -3.0, -7.0, 2.0));
	block.var[2][0][2][2] = (vec4(-1.0, 1.0, -4.0, -1.0));
	block.var[2][1][0][0] = (vec4(3.0, 0.0, -5.0, -4.0));
	block.var[2][1][0][1] = (vec4(-9.0, -4.0, 0.0, -5.0));
	block.var[2][1][0][2] = (vec4(-9.0, -9.0, 6.0, -4.0));
	block.var[2][1][1][0] = (vec4(-7.0, 0.0, 8.0, -6.0));
	block.var[2][1][1][1] = (vec4(-3.0, 8.0, 9.0, 3.0));
	block.var[2][1][1][2] = (vec4(7.0, -2.0, -6.0, -6.0));
	block.var[2][1][2][0] = (vec4(6.0, -9.0, 2.0, 0.0));
	block.var[2][1][2][1] = (vec4(9.0, 5.0, 5.0, 7.0));
	block.var[2][1][2][2] = (vec4(8.0, 2.0, 1.0, -1.0));
	block.var[3][0][0][0] = (vec4(-6.0, -4.0, -1.0, -3.0));
	block.var[3][0][0][1] = (vec4(-8.0, 5.0, -4.0, -9.0));
	block.var[3][0][0][2] = (vec4(8.0, 3.0, -8.0, 0.0));
	block.var[3][0][1][0] = (vec4(7.0, -2.0, 0.0, 8.0));
	block.var[3][0][1][1] = (vec4(-9.0, 2.0, -3.0, -7.0));
	block.var[3][0][1][2] = (vec4(-5.0, 3.0, 9.0, -6.0));
	block.var[3][0][2][0] = (vec4(-7.0, -8.0, -8.0, -7.0));
	block.var[3][0][2][1] = (vec4(-9.0, 2.0, 4.0, -7.0));
	block.var[3][0][2][2] = (vec4(8.0, -7.0, 4.0, -8.0));
	block.var[3][1][0][0] = (vec4(-4.0, 6.0, -3.0, 4.0));
	block.var[3][1][0][1] = (vec4(9.0, 0.0, -2.0, -7.0));
	block.var[3][1][0][2] = (vec4(4.0, 7.0, 8.0, 6.0));
	block.var[3][1][1][0] = (vec4(-1.0, -3.0, 7.0, 5.0));
	block.var[3][1][1][1] = (vec4(-4.0, -6.0, 0.0, -2.0));
	block.var[3][1][1][2] = (vec4(-6.0, 2.0, 3.0, 4.0));
	block.var[3][1][2][0] = (vec4(-6.0, -1.0, 1.0, -2.0));
	block.var[3][1][2][1] = (vec4(2.0, -6.0, -2.0, 3.0));
	block.var[3][1][2][2] = (vec4(-8.0, 4.0, -4.0, 7.0));
}
#version 450
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
	i8vec2 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(block.var[0][0][0]), ivec2(4294967288, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[0][0][1]), ivec2(1, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[0][0][2]), ivec2(0, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[0][1][0]), ivec2(9, 3)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[0][1][1]), ivec2(2, 6)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[0][1][2]), ivec2(4294967290, 4294967289)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][0][0]), ivec2(4294967288, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][0][1]), ivec2(4294967290, 4294967287)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][0][2]), ivec2(4294967289, 2)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][1][0]), ivec2(5, 4294967289)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][1][1]), ivec2(8, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][1][2]), ivec2(4294967294, 4294967288)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][0][0]), ivec2(4294967287, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][0][1]), ivec2(6, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][0][2]), ivec2(3, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][1][0]), ivec2(7, 4294967292)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][1][1]), ivec2(1, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][1][2]), ivec2(2, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[3][0][0]), ivec2(1, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[3][0][1]), ivec2(6, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[3][0][2]), ivec2(3, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[3][1][0]), ivec2(0, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[3][1][1]), ivec2(4294967289, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[3][1][2]), ivec2(7, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = i8vec2(ivec2(0, 8));
	block.var[0][0][1] = i8vec2(ivec2(4294967292, 9));
	block.var[0][0][2] = i8vec2(ivec2(4294967294, 4294967295));
	block.var[0][1][0] = i8vec2(ivec2(4294967293, 0));
	block.var[0][1][1] = i8vec2(ivec2(3, 4294967291));
	block.var[0][1][2] = i8vec2(ivec2(4294967295, 4294967292));
	block.var[1][0][0] = i8vec2(ivec2(8, 4294967290));
	block.var[1][0][1] = i8vec2(ivec2(8, 4294967289));
	block.var[1][0][2] = i8vec2(ivec2(7, 4294967294));
	block.var[1][1][0] = i8vec2(ivec2(5, 4294967292));
	block.var[1][1][1] = i8vec2(ivec2(4294967291, 4));
	block.var[1][1][2] = i8vec2(ivec2(0, 4294967293));
	block.var[2][0][0] = i8vec2(ivec2(4294967293, 4294967293));
	block.var[2][0][1] = i8vec2(ivec2(4294967290, 3));
	block.var[2][0][2] = i8vec2(ivec2(4294967295, 8));
	block.var[2][1][0] = i8vec2(ivec2(4294967292, 4294967292));
	block.var[2][1][1] = i8vec2(ivec2(3, 4294967294));
	block.var[2][1][2] = i8vec2(ivec2(8, 4));
	block.var[3][0][0] = i8vec2(ivec2(5, 8));
	block.var[3][0][1] = i8vec2(ivec2(4294967293, 4294967292));
	block.var[3][0][2] = i8vec2(ivec2(4294967287, 6));
	block.var[3][1][0] = i8vec2(ivec2(8, 6));
	block.var[3][1][1] = i8vec2(ivec2(5, 4294967294));
	block.var[3][1][2] = i8vec2(ivec2(4294967288, 4294967292));
}
#version 450
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
	allOk = compare_mat3(block.var[0][0][0], mat3(6.0, -4.0, 9.0, -9.0, 3.0, 9.0, 6.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(8.0, 5.0, -8.0, -6.0, -8.0, -7.0, -4.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][2], mat3(-4.0, -2.0, -2.0, -8.0, -8.0, -5.0, -4.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(1.0, 8.0, -5.0, -5.0, -8.0, -4.0, -7.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(-5.0, -8.0, 6.0, 4.0, -3.0, 9.0, -2.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][2], mat3(-2.0, 7.0, -4.0, 4.0, -4.0, 1.0, 6.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(3.0, 7.0, 0.0, 6.0, 5.0, 0.0, -5.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(4.0, 9.0, 9.0, -6.0, 9.0, -6.0, 9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][2], mat3(-9.0, -9.0, -2.0, -6.0, 7.0, 7.0, 8.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(2.0, -6.0, 4.0, -6.0, 8.0, 1.0, -7.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(6.0, 5.0, 5.0, -1.0, -9.0, -7.0, 7.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][2], mat3(0.0, -7.0, 0.0, -4.0, 1.0, -7.0, 1.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(-2.0, -1.0, -3.0, 3.0, -5.0, -1.0, 1.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(-4.0, 9.0, 6.0, -9.0, 2.0, 8.0, -5.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][2], mat3(6.0, -4.0, -2.0, 3.0, 0.0, -7.0, -5.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(2.0, -4.0, -2.0, -7.0, 2.0, -2.0, 9.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(3.0, -2.0, 5.0, -3.0, 7.0, -5.0, 2.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][2], mat3(2.0, 2.0, 8.0, -3.0, -7.0, -9.0, -7.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][0], mat3(0.0, 5.0, 6.0, -6.0, -7.0, 9.0, 0.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][1], mat3(-3.0, -7.0, -7.0, -5.0, 8.0, 3.0, 7.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][2], mat3(8.0, 4.0, -6.0, 0.0, 6.0, 5.0, -3.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][0], mat3(-6.0, 7.0, -4.0, 4.0, 5.0, 3.0, 0.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][1], mat3(5.0, -9.0, 6.0, -4.0, -2.0, -4.0, 3.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][2], mat3(0.0, -9.0, 2.0, -6.0, 6.0, 7.0, 8.0, -2.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec3(2.0, -4.0, 9.0));
	block.var[0][0][0][1] = (vec3(-4.0, 2.0, 5.0));
	block.var[0][0][0][2] = (vec3(5.0, -9.0, -5.0));
	block.var[0][0][1][0] = (vec3(3.0, 1.0, 8.0));
	block.var[0][0][1][1] = (vec3(6.0, 9.0, -8.0));
	block.var[0][0][1][2] = (vec3(-1.0, 5.0, 1.0));
	block.var[0][0][2][0] = (vec3(6.0, -5.0, -4.0));
	block.var[0][0][2][1] = (vec3(-8.0, -8.0, -2.0));
	block.var[0][0][2][2] = (vec3(9.0, -4.0, 4.0));
	block.var[0][1][0][0] = (vec3(-9.0, -8.0, 2.0));
	block.var[0][1][0][1] = (vec3(-6.0, 9.0, -7.0));
	block.var[0][1][0][2] = (vec3(9.0, 6.0, 1.0));
	block.var[0][1][1][0] = (vec3(-4.0, 8.0, -7.0));
	block.var[0][1][1][1] = (vec3(1.0, 0.0, 4.0));
	block.var[0][1][1][2] = (vec3(-6.0, -3.0, 3.0));
	block.var[0][1][2][0] = (vec3(-5.0, -6.0, 5.0));
	block.var[0][1][2][1] = (vec3(4.0, 3.0, -2.0));
	block.var[0][1][2][2] = (vec3(-6.0, -4.0, -1.0));
	block.var[1][0][0][0] = (vec3(4.0, -1.0, 5.0));
	block.var[1][0][0][1] = (vec3(-1.0, 0.0, 9.0));
	block.var[1][0][0][2] = (vec3(7.0, 7.0, 5.0));
	block.var[1][0][1][0] = (vec3(8.0, -6.0, -1.0));
	block.var[1][0][1][1] = (vec3(-1.0, -2.0, -5.0));
	block.var[1][0][1][2] = (vec3(-5.0, 6.0, -3.0));
	block.var[1][0][2][0] = (vec3(-4.0, -6.0, 2.0));
	block.var[1][0][2][1] = (vec3(3.0, -1.0, 2.0));
	block.var[1][0][2][2] = (vec3(-3.0, 4.0, 1.0));
	block.var[1][1][0][0] = (vec3(4.0, 4.0, -6.0));
	block.var[1][1][0][1] = (vec3(0.0, 2.0, -5.0));
	block.var[1][1][0][2] = (vec3(5.0, 8.0, -2.0));
	block.var[1][1][1][0] = (vec3(3.0, -1.0, 7.0));
	block.var[1][1][1][1] = (vec3(-9.0, -9.0, -8.0));
	block.var[1][1][1][2] = (vec3(9.0, -9.0, -5.0));
	block.var[1][1][2][0] = (vec3(1.0, -2.0, 1.0));
	block.var[1][1][2][1] = (vec3(-8.0, -4.0, -3.0));
	block.var[1][1][2][2] = (vec3(3.0, -4.0, -3.0));
	block.var[2][0][0][0] = (vec3(9.0, -3.0, -9.0));
	block.var[2][0][0][1] = (vec3(6.0, -1.0, -6.0));
	block.var[2][0][0][2] = (vec3(6.0, 2.0, -5.0));
	block.var[2][0][1][0] = (vec3(-1.0, -2.0, 2.0));
	block.var[2][0][1][1] = (vec3(9.0, 1.0, -8.0));
	block.var[2][0][1][2] = (vec3(6.0, -1.0, 7.0));
	block.var[2][0][2][0] = (vec3(4.0, 2.0, -8.0));
	block.var[2][0][2][1] = (vec3(0.0, 3.0, 9.0));
	block.var[2][0][2][2] = (vec3(9.0, -8.0, -4.0));
	block.var[2][1][0][0] = (vec3(-5.0, 7.0, 5.0));
	block.var[2][1][0][1] = (vec3(-2.0, -2.0, 8.0));
	block.var[2][1][0][2] = (vec3(-3.0, 1.0, 7.0));
	block.var[2][1][1][0] = (vec3(-9.0, 8.0, 7.0));
	block.var[2][1][1][1] = (vec3(2.0, 2.0, -5.0));
	block.var[2][1][1][2] = (vec3(-8.0, -5.0, 6.0));
	block.var[2][1][2][0] = (vec3(4.0, 1.0, 9.0));
	block.var[2][1][2][1] = (vec3(5.0, -6.0, 7.0));
	block.var[2][1][2][2] = (vec3(-7.0, -2.0, -6.0));
	block.var[3][0][0][0] = (vec3(-8.0, 3.0, 4.0));
	block.var[3][0][0][1] = (vec3(-4.0, 4.0, 1.0));
	block.var[3][0][0][2] = (vec3(0.0, 4.0, 5.0));
	block.var[3][0][1][0] = (vec3(-9.0, -4.0, 2.0));
	block.var[3][0][1][1] = (vec3(-6.0, 8.0, 3.0));
	block.var[3][0][1][2] = (vec3(2.0, 0.0, -1.0));
	block.var[3][0][2][0] = (vec3(7.0, 1.0, 3.0));
	block.var[3][0][2][1] = (vec3(5.0, 1.0, -6.0));
	block.var[3][0][2][2] = (vec3(2.0, -5.0, 4.0));
	block.var[3][1][0][0] = (vec3(0.0, -9.0, 7.0));
	block.var[3][1][0][1] = (vec3(-2.0, 0.0, 5.0));
	block.var[3][1][0][2] = (vec3(8.0, 8.0, -1.0));
	block.var[3][1][1][0] = (vec3(-4.0, 3.0, 5.0));
	block.var[3][1][1][1] = (vec3(-9.0, 8.0, -7.0));
	block.var[3][1][1][2] = (vec3(7.0, -3.0, 4.0));
	block.var[3][1][2][0] = (vec3(-6.0, 3.0, 6.0));
	block.var[3][1][2][1] = (vec3(-9.0, 9.0, 3.0));
	block.var[3][1][2][2] = (vec3(8.0, 8.0, -2.0));
}
#version 450
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
	highp uvec2 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((block.padding), 6u) && allOk;
	allOk = compare_uvec2((block.var[0][0][0]), uvec2(0u, 6u)) && allOk;
	allOk = compare_uvec2((block.var[0][0][1]), uvec2(7u, 1u)) && allOk;
	allOk = compare_uvec2((block.var[0][0][2]), uvec2(7u, 9u)) && allOk;
	allOk = compare_uvec2((block.var[0][1][0]), uvec2(7u, 4u)) && allOk;
	allOk = compare_uvec2((block.var[0][1][1]), uvec2(6u, 5u)) && allOk;
	allOk = compare_uvec2((block.var[0][1][2]), uvec2(8u, 9u)) && allOk;
	allOk = compare_uvec2((block.var[1][0][0]), uvec2(0u, 6u)) && allOk;
	allOk = compare_uvec2((block.var[1][0][1]), uvec2(9u, 8u)) && allOk;
	allOk = compare_uvec2((block.var[1][0][2]), uvec2(4u, 0u)) && allOk;
	allOk = compare_uvec2((block.var[1][1][0]), uvec2(9u, 2u)) && allOk;
	allOk = compare_uvec2((block.var[1][1][1]), uvec2(1u, 0u)) && allOk;
	allOk = compare_uvec2((block.var[1][1][2]), uvec2(7u, 8u)) && allOk;
	allOk = compare_uvec2((block.var[2][0][0]), uvec2(2u, 2u)) && allOk;
	allOk = compare_uvec2((block.var[2][0][1]), uvec2(9u, 8u)) && allOk;
	allOk = compare_uvec2((block.var[2][0][2]), uvec2(4u, 1u)) && allOk;
	allOk = compare_uvec2((block.var[2][1][0]), uvec2(6u, 7u)) && allOk;
	allOk = compare_uvec2((block.var[2][1][1]), uvec2(3u, 4u)) && allOk;
	allOk = compare_uvec2((block.var[2][1][2]), uvec2(9u, 3u)) && allOk;
	allOk = compare_uvec2((block.var[3][0][0]), uvec2(4u, 7u)) && allOk;
	allOk = compare_uvec2((block.var[3][0][1]), uvec2(1u, 8u)) && allOk;
	allOk = compare_uvec2((block.var[3][0][2]), uvec2(8u, 7u)) && allOk;
	allOk = compare_uvec2((block.var[3][1][0]), uvec2(2u, 4u)) && allOk;
	allOk = compare_uvec2((block.var[3][1][1]), uvec2(8u, 8u)) && allOk;
	allOk = compare_uvec2((block.var[3][1][2]), uvec2(8u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (6u);
	block.var[0][0][0] = (uvec2(1u, 8u));
	block.var[0][0][1] = (uvec2(1u, 7u));
	block.var[0][0][2] = (uvec2(4u, 6u));
	block.var[0][1][0] = (uvec2(2u, 6u));
	block.var[0][1][1] = (uvec2(0u, 3u));
	block.var[0][1][2] = (uvec2(2u, 5u));
	block.var[1][0][0] = (uvec2(6u, 5u));
	block.var[1][0][1] = (uvec2(8u, 4u));
	block.var[1][0][2] = (uvec2(7u, 8u));
	block.var[1][1][0] = (uvec2(1u, 7u));
	block.var[1][1][1] = (uvec2(2u, 3u));
	block.var[1][1][2] = (uvec2(6u, 0u));
	block.var[2][0][0] = (uvec2(4u, 6u));
	block.var[2][0][1] = (uvec2(3u, 6u));
	block.var[2][0][2] = (uvec2(0u, 3u));
	block.var[2][1][0] = (uvec2(1u, 2u));
	block.var[2][1][1] = (uvec2(6u, 9u));
	block.var[2][1][2] = (uvec2(1u, 4u));
	block.var[3][0][0] = (uvec2(5u, 2u));
	block.var[3][0][1] = (uvec2(4u, 7u));
	block.var[3][0][2] = (uvec2(8u, 6u));
	block.var[3][1][0] = (uvec2(6u, 4u));
	block.var[3][1][1] = (uvec2(2u, 7u));
	block.var[3][1][2] = (uvec2(5u, 1u));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(-8.0, -3.0, 6.0, -5.0, 2.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(-2.0, 8.0, 0.0, 5.0, -6.0, 9.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(0.0, 8.0, -1.0, 5.0, -1.0, 4.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(5.0, 3.0, 2.0, 2.0, 0.0, -9.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2][0], mat2x4(1.0, 3.0, -2.0, -3.0, -6.0, 5.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2][1], mat2x4(8.0, -1.0, 5.0, 7.0, -6.0, 1.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][3][0], mat2x4(-4.0, 9.0, 9.0, 0.0, 9.0, -4.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][3][1], mat2x4(-9.0, 6.0, 5.0, 1.0, 2.0, 1.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(1.0, -1.0, -5.0, 4.0, -7.0, -3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(-3.0, -4.0, 0.0, 0.0, 9.0, -6.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(8.0, 0.0, -7.0, -9.0, -2.0, 5.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(9.0, -1.0, 4.0, -4.0, 9.0, 6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2][0], mat2x4(-6.0, 4.0, 9.0, -5.0, -9.0, 7.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2][1], mat2x4(-9.0, 8.0, -3.0, 8.0, -9.0, -6.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][3][0], mat2x4(-1.0, 0.0, -9.0, 6.0, 9.0, 2.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][3][1], mat2x4(9.0, -3.0, -8.0, 7.0, 2.0, -5.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(4.0, 5.0, 3.0, 4.0, 0.0, -1.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(1.0, 5.0, -8.0, -9.0, -5.0, -6.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(0.0, 4.0, 7.0, 0.0, 5.0, 3.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(4.0, -4.0, -8.0, -7.0, 7.0, -8.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2][0], mat2x4(-6.0, -1.0, -6.0, -5.0, -3.0, -1.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2][1], mat2x4(-1.0, -8.0, -4.0, 8.0, -6.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][3][0], mat2x4(0.0, 5.0, 8.0, -5.0, 9.0, 4.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][3][1], mat2x4(1.0, 5.0, 6.0, -2.0, 0.0, -8.0, 1.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2x4(-2.0, 3.0, 2.0, -4.0, 2.0, -2.0, 9.0, -4.0));
	block.var[0][0][1] = (mat2x4(0.0, 7.0, 4.0, -8.0, 6.0, 0.0, -1.0, -8.0));
	block.var[0][1][0] = (mat2x4(-7.0, 0.0, -8.0, 2.0, -6.0, -5.0, 9.0, 2.0));
	block.var[0][1][1] = (mat2x4(2.0, 3.0, 4.0, 6.0, -7.0, -3.0, 5.0, 2.0));
	block.var[0][2][0] = (mat2x4(1.0, -7.0, -5.0, 8.0, 7.0, 5.0, -9.0, 8.0));
	block.var[0][2][1] = (mat2x4(-9.0, -3.0, 4.0, 1.0, 7.0, 5.0, -2.0, 7.0));
	block.var[0][3][0] = (mat2x4(8.0, 2.0, 5.0, 5.0, 6.0, -6.0, 6.0, -3.0));
	block.var[0][3][1] = (mat2x4(1.0, 8.0, 2.0, 3.0, 2.0, -5.0, 3.0, 3.0));
	block.var[1][0][0] = (mat2x4(2.0, 8.0, 2.0, 4.0, 5.0, 4.0, -3.0, 4.0));
	block.var[1][0][1] = (mat2x4(-6.0, 1.0, 7.0, -9.0, 7.0, -5.0, -1.0, -8.0));
	block.var[1][1][0] = (mat2x4(4.0, 2.0, 8.0, -5.0, -9.0, -1.0, 6.0, -2.0));
	block.var[1][1][1] = (mat2x4(4.0, 1.0, -1.0, -1.0, 7.0, 0.0, 6.0, 9.0));
	block.var[1][2][0] = (mat2x4(5.0, 2.0, 3.0, -3.0, -1.0, 8.0, 4.0, -9.0));
	block.var[1][2][1] = (mat2x4(2.0, 5.0, 5.0, -9.0, -7.0, 9.0, 4.0, -1.0));
	block.var[1][3][0] = (mat2x4(-4.0, -9.0, -5.0, -3.0, 6.0, 8.0, 8.0, 7.0));
	block.var[1][3][1] = (mat2x4(-3.0, -4.0, -9.0, -1.0, -5.0, -2.0, 3.0, 1.0));
	block.var[2][0][0] = (mat2x4(-2.0, -6.0, -6.0, 6.0, 6.0, -7.0, 6.0, 9.0));
	block.var[2][0][1] = (mat2x4(3.0, 9.0, 4.0, -6.0, 7.0, -1.0, 9.0, 5.0));
	block.var[2][1][0] = (mat2x4(5.0, 9.0, -6.0, -6.0, -2.0, -9.0, 9.0, 3.0));
	block.var[2][1][1] = (mat2x4(2.0, 4.0, -3.0, 6.0, 6.0, 9.0, 1.0, 5.0));
	block.var[2][2][0] = (mat2x4(7.0, 7.0, -4.0, 6.0, 0.0, -9.0, 5.0, -7.0));
	block.var[2][2][1] = (mat2x4(-4.0, 5.0, -1.0, 5.0, 8.0, -2.0, -5.0, 5.0));
	block.var[2][3][0] = (mat2x4(-1.0, 9.0, -7.0, 4.0, -9.0, 0.0, -7.0, 1.0));
	block.var[2][3][1] = (mat2x4(9.0, -7.0, -5.0, 9.0, -5.0, 3.0, -8.0, 6.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0][0][0], mat2(-6.0, 3.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(3.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(-1.0, -4.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(0.0, -4.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[0][2][0], mat2(-8.0, 3.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[0][2][1], mat2(0.0, -5.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[0][3][0], mat2(3.0, 2.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[0][3][1], mat2(-9.0, -2.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(9.0, -5.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(0.0, 8.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(8.0, -3.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(5.0, -6.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[1][2][0], mat2(-1.0, 2.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[1][2][1], mat2(-8.0, 0.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[1][3][0], mat2(-9.0, -2.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[1][3][1], mat2(-8.0, -2.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(-8.0, -4.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(8.0, 1.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(0.0, 1.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(4.0, 3.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[2][2][0], mat2(-4.0, 3.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[2][2][1], mat2(-3.0, 4.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[2][3][0], mat2(-1.0, 2.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[2][3][1], mat2(-6.0, -9.0, 0.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(-2.0, 1.0));
	block.var[0][0][0][1] = (vec2(-7.0, -1.0));
	block.var[0][0][1][0] = (vec2(5.0, -3.0));
	block.var[0][0][1][1] = (vec2(4.0, 8.0));
	block.var[0][1][0][0] = (vec2(-4.0, 2.0));
	block.var[0][1][0][1] = (vec2(-1.0, -4.0));
	block.var[0][1][1][0] = (vec2(-5.0, -8.0));
	block.var[0][1][1][1] = (vec2(3.0, -7.0));
	block.var[0][2][0][0] = (vec2(-7.0, 2.0));
	block.var[0][2][0][1] = (vec2(-9.0, 3.0));
	block.var[0][2][1][0] = (vec2(7.0, 9.0));
	block.var[0][2][1][1] = (vec2(-8.0, 3.0));
	block.var[0][3][0][0] = (vec2(-4.0, 7.0));
	block.var[0][3][0][1] = (vec2(4.0, 1.0));
	block.var[0][3][1][0] = (vec2(-1.0, -7.0));
	block.var[0][3][1][1] = (vec2(-5.0, 1.0));
	block.var[1][0][0][0] = (vec2(-2.0, -6.0));
	block.var[1][0][0][1] = (vec2(-5.0, -1.0));
	block.var[1][0][1][0] = (vec2(3.0, 4.0));
	block.var[1][0][1][1] = (vec2(-8.0, 6.0));
	block.var[1][1][0][0] = (vec2(5.0, 0.0));
	block.var[1][1][0][1] = (vec2(-4.0, -9.0));
	block.var[1][1][1][0] = (vec2(9.0, 1.0));
	block.var[1][1][1][1] = (vec2(7.0, 9.0));
	block.var[1][2][0][0] = (vec2(-8.0, -9.0));
	block.var[1][2][0][1] = (vec2(3.0, -5.0));
	block.var[1][2][1][0] = (vec2(7.0, 8.0));
	block.var[1][2][1][1] = (vec2(-8.0, 4.0));
	block.var[1][3][0][0] = (vec2(-1.0, 7.0));
	block.var[1][3][0][1] = (vec2(0.0, 9.0));
	block.var[1][3][1][0] = (vec2(-6.0, 1.0));
	block.var[1][3][1][1] = (vec2(-3.0, 1.0));
	block.var[2][0][0][0] = (vec2(6.0, -2.0));
	block.var[2][0][0][1] = (vec2(1.0, 3.0));
	block.var[2][0][1][0] = (vec2(2.0, 1.0));
	block.var[2][0][1][1] = (vec2(7.0, -2.0));
	block.var[2][1][0][0] = (vec2(1.0, 3.0));
	block.var[2][1][0][1] = (vec2(-3.0, 7.0));
	block.var[2][1][1][0] = (vec2(1.0, 5.0));
	block.var[2][1][1][1] = (vec2(4.0, 1.0));
	block.var[2][2][0][0] = (vec2(-4.0, 7.0));
	block.var[2][2][0][1] = (vec2(-4.0, -8.0));
	block.var[2][2][1][0] = (vec2(1.0, 0.0));
	block.var[2][2][1][1] = (vec2(0.0, -9.0));
	block.var[2][3][0][0] = (vec2(2.0, -1.0));
	block.var[2][3][0][1] = (vec2(-3.0, 3.0));
	block.var[2][3][1][0] = (vec2(-3.0, -6.0));
	block.var[2][3][1][1] = (vec2(3.0, 2.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(0.0, -1.0, 5.0, 2.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(-2.0, -3.0, -9.0, 0.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(6.0, 6.0, -8.0, 5.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(-9.0, -8.0, -5.0, -4.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][0], mat3x2(2.0, -3.0, -1.0, -7.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][1], mat3x2(1.0, -2.0, -2.0, -2.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][0], mat3x2(7.0, 5.0, -6.0, -4.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][1], mat3x2(-5.0, -3.0, -9.0, 2.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(6.0, -9.0, -2.0, 6.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(8.0, -7.0, 1.0, -5.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(-7.0, -9.0, 9.0, -7.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(8.0, -7.0, 7.0, 6.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][0], mat3x2(0.0, -1.0, 1.0, 9.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][1], mat3x2(-9.0, 7.0, -7.0, 8.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][0], mat3x2(5.0, 2.0, 7.0, -1.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][1], mat3x2(9.0, 7.0, -8.0, 9.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(4.0, -3.0, -4.0, -9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(8.0, 4.0, 1.0, 2.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(2.0, -1.0, 5.0, 6.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(-7.0, -5.0, 7.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][0], mat3x2(7.0, 4.0, 0.0, -5.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][1], mat3x2(-3.0, 3.0, -7.0, -9.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][0], mat3x2(-9.0, -8.0, 9.0, -2.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][1], mat3x2(7.0, -7.0, -2.0, 2.0, -1.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(-2.0, 8.0));
	block.var[0][0][0][1] = (vec2(1.0, 8.0));
	block.var[0][0][0][2] = (vec2(-7.0, 5.0));
	block.var[0][0][1][0] = (vec2(2.0, 0.0));
	block.var[0][0][1][1] = (vec2(-3.0, 1.0));
	block.var[0][0][1][2] = (vec2(2.0, -5.0));
	block.var[0][1][0][0] = (vec2(9.0, -9.0));
	block.var[0][1][0][1] = (vec2(0.0, -6.0));
	block.var[0][1][0][2] = (vec2(-7.0, 7.0));
	block.var[0][1][1][0] = (vec2(-8.0, 7.0));
	block.var[0][1][1][1] = (vec2(9.0, 6.0));
	block.var[0][1][1][2] = (vec2(-1.0, 0.0));
	block.var[0][2][0][0] = (vec2(2.0, -2.0));
	block.var[0][2][0][1] = (vec2(-2.0, -8.0));
	block.var[0][2][0][2] = (vec2(7.0, -7.0));
	block.var[0][2][1][0] = (vec2(-1.0, 6.0));
	block.var[0][2][1][1] = (vec2(-8.0, 4.0));
	block.var[0][2][1][2] = (vec2(-5.0, 3.0));
	block.var[0][3][0][0] = (vec2(4.0, -9.0));
	block.var[0][3][0][1] = (vec2(-4.0, 4.0));
	block.var[0][3][0][2] = (vec2(5.0, 3.0));
	block.var[0][3][1][0] = (vec2(-3.0, -5.0));
	block.var[0][3][1][1] = (vec2(5.0, 1.0));
	block.var[0][3][1][2] = (vec2(3.0, -3.0));
	block.var[1][0][0][0] = (vec2(6.0, 3.0));
	block.var[1][0][0][1] = (vec2(6.0, 5.0));
	block.var[1][0][0][2] = (vec2(-5.0, 9.0));
	block.var[1][0][1][0] = (vec2(-8.0, 9.0));
	block.var[1][0][1][1] = (vec2(3.0, -3.0));
	block.var[1][0][1][2] = (vec2(3.0, -5.0));
	block.var[1][1][0][0] = (vec2(-3.0, 6.0));
	block.var[1][1][0][1] = (vec2(-1.0, -6.0));
	block.var[1][1][0][2] = (vec2(-1.0, -3.0));
	block.var[1][1][1][0] = (vec2(0.0, -1.0));
	block.var[1][1][1][1] = (vec2(4.0, -9.0));
	block.var[1][1][1][2] = (vec2(1.0, 1.0));
	block.var[1][2][0][0] = (vec2(-9.0, -8.0));
	block.var[1][2][0][1] = (vec2(8.0, -9.0));
	block.var[1][2][0][2] = (vec2(-1.0, 1.0));
	block.var[1][2][1][0] = (vec2(0.0, 2.0));
	block.var[1][2][1][1] = (vec2(-1.0, -9.0));
	block.var[1][2][1][2] = (vec2(3.0, 4.0));
	block.var[1][3][0][0] = (vec2(-1.0, -6.0));
	block.var[1][3][0][1] = (vec2(-6.0, 8.0));
	block.var[1][3][0][2] = (vec2(-3.0, 7.0));
	block.var[1][3][1][0] = (vec2(-6.0, 6.0));
	block.var[1][3][1][1] = (vec2(6.0, 7.0));
	block.var[1][3][1][2] = (vec2(3.0, -9.0));
	block.var[2][0][0][0] = (vec2(7.0, -8.0));
	block.var[2][0][0][1] = (vec2(3.0, 1.0));
	block.var[2][0][0][2] = (vec2(-2.0, 1.0));
	block.var[2][0][1][0] = (vec2(4.0, -9.0));
	block.var[2][0][1][1] = (vec2(3.0, 6.0));
	block.var[2][0][1][2] = (vec2(7.0, 1.0));
	block.var[2][1][0][0] = (vec2(-9.0, 7.0));
	block.var[2][1][0][1] = (vec2(0.0, 4.0));
	block.var[2][1][0][2] = (vec2(-3.0, -3.0));
	block.var[2][1][1][0] = (vec2(6.0, 8.0));
	block.var[2][1][1][1] = (vec2(-7.0, 5.0));
	block.var[2][1][1][2] = (vec2(-6.0, -5.0));
	block.var[2][2][0][0] = (vec2(6.0, -1.0));
	block.var[2][2][0][1] = (vec2(-4.0, -4.0));
	block.var[2][2][0][2] = (vec2(0.0, -6.0));
	block.var[2][2][1][0] = (vec2(5.0, -8.0));
	block.var[2][2][1][1] = (vec2(6.0, -8.0));
	block.var[2][2][1][2] = (vec2(-5.0, -8.0));
	block.var[2][3][0][0] = (vec2(-4.0, -6.0));
	block.var[2][3][0][1] = (vec2(-6.0, 2.0));
	block.var[2][3][0][2] = (vec2(6.0, -3.0));
	block.var[2][3][1][0] = (vec2(-1.0, -9.0));
	block.var[2][3][1][1] = (vec2(8.0, -4.0));
	block.var[2][3][1][2] = (vec2(-9.0, -4.0));
}
#version 450
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
	u16vec4 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(block.var[0][0][0]), uvec4(6u, 0u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[0][0][1]), uvec4(8u, 7u, 5u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[0][1][0]), uvec4(9u, 2u, 2u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[0][1][1]), uvec4(9u, 9u, 3u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[0][2][0]), uvec4(0u, 2u, 0u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[0][2][1]), uvec4(9u, 8u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[0][3][0]), uvec4(2u, 6u, 2u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[0][3][1]), uvec4(3u, 7u, 0u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][0][0]), uvec4(8u, 7u, 1u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][0][1]), uvec4(5u, 0u, 5u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][1][0]), uvec4(0u, 0u, 4u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][1][1]), uvec4(1u, 7u, 1u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][2][0]), uvec4(5u, 2u, 3u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][2][1]), uvec4(5u, 9u, 1u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][3][0]), uvec4(6u, 4u, 5u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][3][1]), uvec4(6u, 4u, 0u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][0][0]), uvec4(9u, 4u, 6u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][0][1]), uvec4(5u, 3u, 6u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][1][0]), uvec4(8u, 7u, 4u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][1][1]), uvec4(7u, 0u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][2][0]), uvec4(6u, 2u, 0u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][2][1]), uvec4(5u, 5u, 6u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][3][0]), uvec4(2u, 9u, 7u, 6u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][3][1]), uvec4(8u, 1u, 6u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = u16vec4(uvec4(0u, 6u, 9u, 4u));
	block.var[0][0][1] = u16vec4(uvec4(5u, 0u, 1u, 0u));
	block.var[0][1][0] = u16vec4(uvec4(9u, 3u, 0u, 2u));
	block.var[0][1][1] = u16vec4(uvec4(3u, 5u, 0u, 2u));
	block.var[0][2][0] = u16vec4(uvec4(6u, 9u, 4u, 2u));
	block.var[0][2][1] = u16vec4(uvec4(9u, 7u, 6u, 2u));
	block.var[0][3][0] = u16vec4(uvec4(7u, 8u, 2u, 8u));
	block.var[0][3][1] = u16vec4(uvec4(0u, 3u, 6u, 3u));
	block.var[1][0][0] = u16vec4(uvec4(7u, 6u, 5u, 9u));
	block.var[1][0][1] = u16vec4(uvec4(8u, 3u, 6u, 1u));
	block.var[1][1][0] = u16vec4(uvec4(5u, 1u, 5u, 5u));
	block.var[1][1][1] = u16vec4(uvec4(4u, 0u, 8u, 4u));
	block.var[1][2][0] = u16vec4(uvec4(8u, 4u, 6u, 2u));
	block.var[1][2][1] = u16vec4(uvec4(2u, 1u, 0u, 1u));
	block.var[1][3][0] = u16vec4(uvec4(4u, 0u, 8u, 2u));
	block.var[1][3][1] = u16vec4(uvec4(3u, 0u, 4u, 2u));
	block.var[2][0][0] = u16vec4(uvec4(7u, 9u, 3u, 8u));
	block.var[2][0][1] = u16vec4(uvec4(1u, 4u, 3u, 9u));
	block.var[2][1][0] = u16vec4(uvec4(0u, 3u, 7u, 1u));
	block.var[2][1][1] = u16vec4(uvec4(1u, 8u, 4u, 7u));
	block.var[2][2][0] = u16vec4(uvec4(9u, 9u, 4u, 6u));
	block.var[2][2][1] = u16vec4(uvec4(4u, 4u, 2u, 8u));
	block.var[2][3][0] = u16vec4(uvec4(4u, 7u, 1u, 9u));
	block.var[2][3][1] = u16vec4(uvec4(5u, 6u, 9u, 9u));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(-2.0, 6.0, 5.0, 7.0, 1.0, -5.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(4.0, -5.0, -7.0, -4.0, 7.0, 7.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(-1.0, -8.0, 5.0, -8.0, 2.0, 3.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(0.0, 4.0, -8.0, -3.0, -1.0, 4.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][0], mat4x2(-1.0, 3.0, -9.0, 4.0, -2.0, 2.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][1], mat4x2(-3.0, 7.0, -5.0, 3.0, 2.0, -1.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][0], mat4x2(-4.0, 1.0, -2.0, 4.0, 1.0, -8.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][1], mat4x2(-3.0, 8.0, -5.0, 6.0, -2.0, -2.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(-1.0, 7.0, -9.0, -7.0, -1.0, 8.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(-4.0, 7.0, -5.0, -3.0, 4.0, 7.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(4.0, 5.0, -7.0, 1.0, 0.0, -9.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(-2.0, 4.0, -8.0, 5.0, -3.0, 8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][0], mat4x2(6.0, 9.0, -5.0, 0.0, 7.0, 6.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][1], mat4x2(-7.0, -3.0, -5.0, 2.0, 3.0, -3.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][0], mat4x2(0.0, 0.0, 7.0, -1.0, 5.0, 0.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][1], mat4x2(-4.0, 8.0, -2.0, -8.0, 3.0, -3.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(9.0, -5.0, 9.0, 2.0, -1.0, -1.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(-6.0, -7.0, 4.0, 4.0, 9.0, -9.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(5.0, -9.0, 5.0, -2.0, -8.0, -1.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(3.0, 5.0, 1.0, 5.0, -3.0, -4.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][0], mat4x2(5.0, -7.0, -9.0, 8.0, 8.0, -7.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][1], mat4x2(-6.0, 8.0, -1.0, 0.0, 6.0, -2.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][0], mat4x2(-7.0, -6.0, -2.0, 5.0, -6.0, 7.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][1], mat4x2(8.0, -4.0, 0.0, -7.0, 2.0, -2.0, 6.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(6.0, 9.0));
	block.var[0][0][0][1] = (vec2(-4.0, -4.0));
	block.var[0][0][0][2] = (vec2(2.0, 0.0));
	block.var[0][0][0][3] = (vec2(-7.0, 3.0));
	block.var[0][0][1][0] = (vec2(9.0, -6.0));
	block.var[0][0][1][1] = (vec2(8.0, -9.0));
	block.var[0][0][1][2] = (vec2(-9.0, -6.0));
	block.var[0][0][1][3] = (vec2(-4.0, -6.0));
	block.var[0][1][0][0] = (vec2(-2.0, 1.0));
	block.var[0][1][0][1] = (vec2(6.0, -2.0));
	block.var[0][1][0][2] = (vec2(2.0, -5.0));
	block.var[0][1][0][3] = (vec2(3.0, -3.0));
	block.var[0][1][1][0] = (vec2(-6.0, -4.0));
	block.var[0][1][1][1] = (vec2(-6.0, -7.0));
	block.var[0][1][1][2] = (vec2(9.0, 1.0));
	block.var[0][1][1][3] = (vec2(-4.0, 3.0));
	block.var[0][2][0][0] = (vec2(-9.0, -3.0));
	block.var[0][2][0][1] = (vec2(5.0, -5.0));
	block.var[0][2][0][2] = (vec2(3.0, 4.0));
	block.var[0][2][0][3] = (vec2(-9.0, 1.0));
	block.var[0][2][1][0] = (vec2(0.0, 8.0));
	block.var[0][2][1][1] = (vec2(-8.0, 3.0));
	block.var[0][2][1][2] = (vec2(-7.0, 9.0));
	block.var[0][2][1][3] = (vec2(-8.0, -7.0));
	block.var[0][3][0][0] = (vec2(3.0, 7.0));
	block.var[0][3][0][1] = (vec2(-6.0, -7.0));
	block.var[0][3][0][2] = (vec2(-7.0, 5.0));
	block.var[0][3][0][3] = (vec2(-8.0, 4.0));
	block.var[0][3][1][0] = (vec2(4.0, -5.0));
	block.var[0][3][1][1] = (vec2(-6.0, -9.0));
	block.var[0][3][1][2] = (vec2(7.0, 7.0));
	block.var[0][3][1][3] = (vec2(-2.0, 6.0));
	block.var[1][0][0][0] = (vec2(-8.0, 5.0));
	block.var[1][0][0][1] = (vec2(6.0, -8.0));
	block.var[1][0][0][2] = (vec2(-8.0, 3.0));
	block.var[1][0][0][3] = (vec2(2.0, 8.0));
	block.var[1][0][1][0] = (vec2(-8.0, -1.0));
	block.var[1][0][1][1] = (vec2(-3.0, 0.0));
	block.var[1][0][1][2] = (vec2(7.0, 5.0));
	block.var[1][0][1][3] = (vec2(-8.0, 5.0));
	block.var[1][1][0][0] = (vec2(7.0, -9.0));
	block.var[1][1][0][1] = (vec2(7.0, -4.0));
	block.var[1][1][0][2] = (vec2(8.0, -2.0));
	block.var[1][1][0][3] = (vec2(9.0, 0.0));
	block.var[1][1][1][0] = (vec2(-9.0, 7.0));
	block.var[1][1][1][1] = (vec2(1.0, 4.0));
	block.var[1][1][1][2] = (vec2(-7.0, 9.0));
	block.var[1][1][1][3] = (vec2(-5.0, 2.0));
	block.var[1][2][0][0] = (vec2(7.0, 1.0));
	block.var[1][2][0][1] = (vec2(-1.0, -2.0));
	block.var[1][2][0][2] = (vec2(-8.0, -3.0));
	block.var[1][2][0][3] = (vec2(9.0, -1.0));
	block.var[1][2][1][0] = (vec2(-2.0, 1.0));
	block.var[1][2][1][1] = (vec2(-8.0, -7.0));
	block.var[1][2][1][2] = (vec2(-5.0, 7.0));
	block.var[1][2][1][3] = (vec2(-5.0, -7.0));
	block.var[1][3][0][0] = (vec2(1.0, -9.0));
	block.var[1][3][0][1] = (vec2(7.0, 6.0));
	block.var[1][3][0][2] = (vec2(-4.0, 2.0));
	block.var[1][3][0][3] = (vec2(1.0, 5.0));
	block.var[1][3][1][0] = (vec2(-8.0, -6.0));
	block.var[1][3][1][1] = (vec2(-6.0, 4.0));
	block.var[1][3][1][2] = (vec2(4.0, 7.0));
	block.var[1][3][1][3] = (vec2(-7.0, -9.0));
	block.var[2][0][0][0] = (vec2(7.0, 8.0));
	block.var[2][0][0][1] = (vec2(4.0, -2.0));
	block.var[2][0][0][2] = (vec2(4.0, -2.0));
	block.var[2][0][0][3] = (vec2(-2.0, 9.0));
	block.var[2][0][1][0] = (vec2(4.0, -4.0));
	block.var[2][0][1][1] = (vec2(-5.0, -5.0));
	block.var[2][0][1][2] = (vec2(-6.0, 8.0));
	block.var[2][0][1][3] = (vec2(9.0, -5.0));
	block.var[2][1][0][0] = (vec2(-9.0, -3.0));
	block.var[2][1][0][1] = (vec2(-8.0, 5.0));
	block.var[2][1][0][2] = (vec2(-2.0, -8.0));
	block.var[2][1][0][3] = (vec2(7.0, -6.0));
	block.var[2][1][1][0] = (vec2(-7.0, 1.0));
	block.var[2][1][1][1] = (vec2(-3.0, 7.0));
	block.var[2][1][1][2] = (vec2(6.0, -5.0));
	block.var[2][1][1][3] = (vec2(9.0, -2.0));
	block.var[2][2][0][0] = (vec2(-5.0, 2.0));
	block.var[2][2][0][1] = (vec2(-4.0, 8.0));
	block.var[2][2][0][2] = (vec2(-7.0, 6.0));
	block.var[2][2][0][3] = (vec2(5.0, 2.0));
	block.var[2][2][1][0] = (vec2(-5.0, 3.0));
	block.var[2][2][1][1] = (vec2(-9.0, 7.0));
	block.var[2][2][1][2] = (vec2(-3.0, -3.0));
	block.var[2][2][1][3] = (vec2(-7.0, -4.0));
	block.var[2][3][0][0] = (vec2(7.0, -6.0));
	block.var[2][3][0][1] = (vec2(8.0, -8.0));
	block.var[2][3][0][2] = (vec2(-6.0, -7.0));
	block.var[2][3][0][3] = (vec2(-4.0, -2.0));
	block.var[2][3][1][0] = (vec2(-9.0, 9.0));
	block.var[2][3][1][1] = (vec2(4.0, -6.0));
	block.var[2][3][1][2] = (vec2(2.0, 3.0));
	block.var[2][3][1][3] = (vec2(6.0, 8.0));
}
#version 450
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
	allOk = compare_ivec3((block.s.a), ivec3(-3, -3, 3)) && allOk;
	allOk = compare_mat3(block.s.b[0], mat3(1.0, 1.0, -8.0, -2.0, -7.0, -1.0, 8.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3(block.s.b[1], mat3(-8.0, -2.0, 8.0, -3.0, 3.0, 8.0, 4.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3(block.s.b[2], mat3(-7.0, -4.0, 7.0, 5.0, 5.0, -8.0, -6.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat3(block.s.b[3], mat3(3.0, -1.0, -9.0, 7.0, 1.0, 1.0, 9.0, 2.0, -5.0)) && allOk;
	allOk = compare_vec4((block.s.c), vec4(5.0, -6.0, 0.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s.a = (ivec3(4, 1, 5));
	block.s.b[0] = (mat3(-4.0, 6.0, -4.0, -7.0, -1.0, -7.0, 1.0, -9.0, -4.0));
	block.s.b[1] = (mat3(-7.0, -5.0, -4.0, -3.0, -9.0, 3.0, 5.0, -9.0, 5.0));
	block.s.b[2] = (mat3(2.0, 5.0, -2.0, -1.0, 3.0, -7.0, -9.0, 4.0, 4.0));
	block.s.b[3] = (mat3(-6.0, 1.0, -9.0, -5.0, -7.0, 0.0, 0.0, -4.0, 2.0));
	block.s.c = (vec4(-8.0, -5.0, 2.0, 4.0));
}
#version 450
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
layout(scalar, buffer_reference) buffer Block
{
	lowp uint u;
	S s[3];
	mediump vec4 v;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((block.s[0].a), ivec3(6, -5, -9)) && allOk;
	allOk = compare_mat3(block.s[0].b[0], mat3(-3.0, -9.0, 9.0, 4.0, 3.0, -7.0, 4.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3(block.s[0].b[1], mat3(8.0, -4.0, 6.0, -2.0, -9.0, -2.0, 8.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3(block.s[0].b[2], mat3(-2.0, -1.0, 7.0, 2.0, 6.0, 0.0, 9.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3(block.s[0].b[3], mat3(9.0, 8.0, -7.0, -3.0, -8.0, 8.0, 4.0, 0.0, 0.0)) && allOk;
	allOk = compare_vec4((block.s[0].c), vec4(-5.0, -5.0, -4.0, 9.0)) && allOk;
	allOk = compare_ivec3((block.s[1].a), ivec3(-4, 2, -6)) && allOk;
	allOk = compare_mat3(block.s[1].b[0], mat3(5.0, -2.0, 8.0, 4.0, -7.0, 5.0, 1.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3(block.s[1].b[1], mat3(-8.0, 5.0, -2.0, 8.0, 6.0, -9.0, 9.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat3(block.s[1].b[2], mat3(-1.0, 2.0, -9.0, 4.0, 2.0, -3.0, -2.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3(block.s[1].b[3], mat3(9.0, -8.0, 5.0, -6.0, 8.0, -9.0, 0.0, 6.0, 9.0)) && allOk;
	allOk = compare_vec4((block.s[1].c), vec4(4.0, 7.0, -5.0, -4.0)) && allOk;
	allOk = compare_ivec3((block.s[2].a), ivec3(5, -9, -6)) && allOk;
	allOk = compare_mat3(block.s[2].b[0], mat3(5.0, -6.0, -8.0, -3.0, -7.0, 3.0, 4.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3(block.s[2].b[1], mat3(0.0, -4.0, 3.0, 7.0, -3.0, -7.0, -6.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat3(block.s[2].b[2], mat3(-8.0, 5.0, -1.0, 8.0, 5.0, -2.0, -1.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat3(block.s[2].b[3], mat3(8.0, -6.0, -9.0, -6.0, -3.0, -1.0, 3.0, -4.0, -1.0)) && allOk;
	allOk = compare_vec4((block.s[2].c), vec4(-5.0, 3.0, 4.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s[0].a = (ivec3(-3, 7, 0));
	block.s[0].b[0][0] = (vec3(5.0, 4.0, -2.0));
	block.s[0].b[0][1] = (vec3(-8.0, 3.0, 7.0));
	block.s[0].b[0][2] = (vec3(-4.0, -3.0, -3.0));
	block.s[0].b[1][0] = (vec3(-4.0, 2.0, -2.0));
	block.s[0].b[1][1] = (vec3(-8.0, -5.0, 6.0));
	block.s[0].b[1][2] = (vec3(-2.0, -5.0, -2.0));
	block.s[0].b[2][0] = (vec3(3.0, -7.0, 5.0));
	block.s[0].b[2][1] = (vec3(8.0, 0.0, 4.0));
	block.s[0].b[2][2] = (vec3(-4.0, -7.0, -7.0));
	block.s[0].b[3][0] = (vec3(1.0, 5.0, 2.0));
	block.s[0].b[3][1] = (vec3(0.0, -9.0, -6.0));
	block.s[0].b[3][2] = (vec3(-7.0, -7.0, 9.0));
	block.s[0].c = (vec4(-5.0, -2.0, -8.0, -2.0));
	block.s[1].a = (ivec3(-9, 6, 1));
	block.s[1].b[0][0] = (vec3(-1.0, -4.0, 4.0));
	block.s[1].b[0][1] = (vec3(-7.0, 5.0, 5.0));
	block.s[1].b[0][2] = (vec3(-7.0, 4.0, -7.0));
	block.s[1].b[1][0] = (vec3(1.0, 6.0, 8.0));
	block.s[1].b[1][1] = (vec3(9.0, 5.0, 6.0));
	block.s[1].b[1][2] = (vec3(-7.0, -9.0, 1.0));
	block.s[1].b[2][0] = (vec3(2.0, 5.0, 0.0));
	block.s[1].b[2][1] = (vec3(0.0, -1.0, 9.0));
	block.s[1].b[2][2] = (vec3(-1.0, -2.0, 1.0));
	block.s[1].b[3][0] = (vec3(-2.0, -4.0, -7.0));
	block.s[1].b[3][1] = (vec3(-9.0, -8.0, -3.0));
	block.s[1].b[3][2] = (vec3(-1.0, 7.0, -7.0));
	block.s[1].c = (vec4(-3.0, -5.0, 0.0, -2.0));
	block.s[2].a = (ivec3(-9, -8, -6));
	block.s[2].b[0][0] = (vec3(-1.0, -6.0, -5.0));
	block.s[2].b[0][1] = (vec3(9.0, 2.0, -8.0));
	block.s[2].b[0][2] = (vec3(-5.0, -7.0, -6.0));
	block.s[2].b[1][0] = (vec3(3.0, -4.0, -9.0));
	block.s[2].b[1][1] = (vec3(8.0, 1.0, 4.0));
	block.s[2].b[1][2] = (vec3(-5.0, -4.0, 7.0));
	block.s[2].b[2][0] = (vec3(0.0, -1.0, 7.0));
	block.s[2].b[2][1] = (vec3(4.0, -5.0, -8.0));
	block.s[2].b[2][2] = (vec3(-9.0, 7.0, -5.0));
	block.s[2].b[3][0] = (vec3(-4.0, -6.0, -9.0));
	block.s[2].b[3][1] = (vec3(-3.0, -4.0, 0.0));
	block.s[2].b[3][2] = (vec3(8.0, 9.0, -5.0));
	block.s[2].c = (vec4(-8.0, 0.0, 2.0, 3.0));
	block.v = (vec4(6.0, 7.0, 5.0, 9.0));
}
#version 450
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
layout(std430, buffer_reference) buffer Block
{
	S s;
	lowp vec2 v;
	highp uint u;
	T t[];
};
layout (push_constant, std430) uniform PC {
    Block block[3];
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
	allOk = compare_uint((block.u), 2u) && allOk;
	allOk = compare_mat4x3(block.t[0].a, mat4x3(-7.0, 8.0, -4.0, 6.0, -2.0, -9.0, -2.0, 8.0, 4.0, -2.0, -2.0, -1.0)) && allOk;
	allOk = compare_uvec3((block.t[0].b[0].a), uvec3(7u, 6u, 0u)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[0]), vec2(-9.0, 0.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[1]), vec2(6.0, 9.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[2]), vec2(5.0, -6.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[3]), vec2(-8.0, -3.0)) && allOk;
	allOk = compare_vec4((block.t[0].b[0].c), vec4(-6.0, -9.0, -6.0, -3.0)) && allOk;
	allOk = compare_uvec3((block.t[0].b[1].a), uvec3(9u, 8u, 2u)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[0]), vec2(4.0, 7.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[1]), vec2(-3.0, 7.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[2]), vec2(-5.0, 3.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[3]), vec2(5.0, 9.0)) && allOk;
	allOk = compare_vec4((block.t[0].b[1].c), vec4(-5.0, -7.0, -9.0, 0.0)) && allOk;
	allOk = compare_uvec3((block.t[0].b[2].a), uvec3(5u, 3u, 1u)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[0]), vec2(-1.0, -2.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[1]), vec2(-5.0, 3.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[2]), vec2(2.0, -4.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[3]), vec2(-1.0, 7.0)) && allOk;
	allOk = compare_vec4((block.t[0].b[2].c), vec4(-7.0, -1.0, 7.0, 7.0)) && allOk;
	allOk = compare_int((block.t[0].c), 6) && allOk;
	allOk = compare_mat4x3(block.t[1].a, mat4x3(7.0, 2.0, 6.0, 0.0, 9.0, 8.0, -7.0, 9.0, 8.0, -7.0, -3.0, -8.0)) && allOk;
	allOk = compare_uvec3((block.t[1].b[0].a), uvec3(4u, 4u, 4u)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[0]), vec2(-7.0, 3.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[1]), vec2(4.0, -6.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[2]), vec2(-6.0, 0.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[3]), vec2(-4.0, 3.0)) && allOk;
	allOk = compare_vec4((block.t[1].b[0].c), vec4(-1.0, 3.0, -4.0, -1.0)) && allOk;
	allOk = compare_uvec3((block.t[1].b[1].a), uvec3(3u, 9u, 4u)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[0]), vec2(0.0, 2.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[1]), vec2(-3.0, -3.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[2]), vec2(5.0, 2.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[3]), vec2(3.0, 7.0)) && allOk;
	allOk = compare_vec4((block.t[1].b[1].c), vec4(-3.0, 1.0, 0.0, 8.0)) && allOk;
	allOk = compare_uvec3((block.t[1].b[2].a), uvec3(4u, 6u, 5u)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[0]), vec2(-9.0, 9.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[1]), vec2(-3.0, 7.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[2]), vec2(-2.0, -5.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[3]), vec2(-6.0, -7.0)) && allOk;
	allOk = compare_vec4((block.t[1].b[2].c), vec4(1.0, 3.0, -8.0, -6.0)) && allOk;
	allOk = compare_int((block.t[1].c), -4) && allOk;
	allOk = compare_mat4x3(block.t[2].a, mat4x3(8.0, 4.0, 0.0, 0.0, 5.0, -2.0, 8.0, 4.0, -7.0, 5.0, 1.0, 4.0)) && allOk;
	allOk = compare_uvec3((block.t[2].b[0].a), uvec3(3u, 6u, 8u)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[0]), vec2(7.0, -3.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[1]), vec2(-7.0, -6.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[2]), vec2(9.0, -9.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[3]), vec2(-8.0, 5.0)) && allOk;
	allOk = compare_vec4((block.t[2].b[0].c), vec4(-5.0, -5.0, -4.0, 9.0)) && allOk;
	allOk = compare_uvec3((block.t[2].b[1].a), uvec3(5u, 6u, 5u)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[0]), vec2(9.0, -8.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[1]), vec2(9.0, 9.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[2]), vec2(3.0, 3.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[3]), vec2(0.0, 2.0)) && allOk;
	allOk = compare_vec4((block.t[2].b[1].c), vec4(1.0, 0.0, 3.0, -7.0)) && allOk;
	allOk = compare_uvec3((block.t[2].b[2].a), uvec3(6u, 9u, 9u)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[0]), vec2(-3.0, -1.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[1]), vec2(-4.0, 5.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[2]), vec2(-9.0, -4.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[3]), vec2(-5.0, 4.0)) && allOk;
	allOk = compare_vec4((block.t[2].b[2].c), vec4(-2.0, -9.0, -9.0, -8.0)) && allOk;
	allOk = compare_int((block.t[2].c), 9) && allOk;
	allOk = compare_mat4x3(block.t[3].a, mat4x3(0.0, -8.0, 5.0, -2.0, 8.0, 6.0, -9.0, 9.0, -7.0, -6.0, -1.0, 2.0)) && allOk;
	allOk = compare_uvec3((block.t[3].b[0].a), uvec3(6u, 6u, 9u)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[0]), vec2(-1.0, 8.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[1]), vec2(5.0, -2.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[2]), vec2(-1.0, 8.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[3]), vec2(1.0, 8.0)) && allOk;
	allOk = compare_vec4((block.t[3].b[0].c), vec4(4.0, 7.0, -5.0, -4.0)) && allOk;
	allOk = compare_uvec3((block.t[3].b[1].a), uvec3(3u, 8u, 5u)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[0]), vec2(3.0, -9.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[1]), vec2(4.0, -9.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[2]), vec2(8.0, 7.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[3]), vec2(-4.0, 3.0)) && allOk;
	allOk = compare_vec4((block.t[3].b[1].c), vec4(5.0, -5.0, -7.0, -3.0)) && allOk;
	allOk = compare_uvec3((block.t[3].b[2].a), uvec3(0u, 0u, 7u)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[0]), vec2(2.0, 7.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[1]), vec2(8.0, -1.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[2]), vec2(8.0, -8.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[3]), vec2(-3.0, 0.0)) && allOk;
	allOk = compare_vec4((block.t[3].b[2].c), vec4(-8.0, -2.0, -5.0, -2.0)) && allOk;
	allOk = compare_int((block.t[3].c), -5) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s.a = (uvec3(0u, 3u, 2u));
	block.s.b[0] = (vec2(0.0, -9.0));
	block.s.b[1] = (vec2(6.0, 1.0));
	block.s.b[2] = (vec2(-9.0, -8.0));
	block.s.b[3] = (vec2(-6.0, 5.0));
	block.s.c = (vec4(4.0, -2.0, -8.0, 3.0));
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

layout(std140, column_major, buffer_reference) buffer Block
{
	highp mat3x4 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block[0].var[0][0], -6.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 2.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 7.0) && allOk;
	allOk = compare_float(block[0].var[0][3], -8.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 9.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -6.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 1.0) && allOk;
	allOk = compare_float(block[0].var[1][3], 9.0) && allOk;
	allOk = compare_float(block[0].var[2][0], -9.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 1.0) && allOk;
	allOk = compare_float(block[0].var[2][2], -3.0) && allOk;
	allOk = compare_float(block[0].var[2][3], 2.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(-6.0, 2.0, 7.0, -8.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(9.0, -6.0, 1.0, 9.0)) && allOk;
	allOk = compare_vec4(block[0].var[2], vec4(-9.0, 1.0, -3.0, 2.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], -8.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -5.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -5.0) && allOk;
	allOk = compare_float(block[1].var[0][3], 5.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -5.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -3.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 2.0) && allOk;
	allOk = compare_float(block[1].var[1][3], 1.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 2.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 8.0) && allOk;
	allOk = compare_float(block[1].var[2][2], -3.0) && allOk;
	allOk = compare_float(block[1].var[2][3], 0.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(-8.0, -5.0, -5.0, 5.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(-5.0, -3.0, 2.0, 1.0)) && allOk;
	allOk = compare_vec4(block[1].var[2], vec4(2.0, 8.0, -3.0, 0.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 3.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 7.0) && allOk;
	allOk = compare_float(block[2].var[0][2], -5.0) && allOk;
	allOk = compare_float(block[2].var[0][3], 5.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 6.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -3.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 8.0) && allOk;
	allOk = compare_float(block[2].var[1][3], -1.0) && allOk;
	allOk = compare_float(block[2].var[2][0], -1.0) && allOk;
	allOk = compare_float(block[2].var[2][1], -1.0) && allOk;
	allOk = compare_float(block[2].var[2][2], -9.0) && allOk;
	allOk = compare_float(block[2].var[2][3], 8.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(3.0, 7.0, -5.0, 5.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(6.0, -3.0, 8.0, -1.0)) && allOk;
	allOk = compare_vec4(block[2].var[2], vec4(-1.0, -1.0, -9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat3x4(0.0, 0.0, -5.0, -3.0, -2.0, -8.0, -3.0, 0.0, -6.0, -6.0, 8.0, 5.0));
	block[1].var = (mat3x4(8.0, 1.0, 7.0, 4.0, -7.0, -3.0, -4.0, 0.0, 6.0, 9.0, -2.0, 5.0));
	block[2].var = (mat3x4(8.0, -2.0, 7.0, 3.0, -8.0, -8.0, 5.0, -7.0, -9.0, 1.0, 9.0, -3.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), -9.0) && allOk;
	allOk = compare_mat3(block[0].var, mat3(-4.0, 2.0, 9.0, 6.0, -2.0, 1.0, 4.0, 8.0, 6.0)) && allOk;
	allOk = compare_float((block[1].padding), 3.0) && allOk;
	allOk = compare_mat3(block[1].var, mat3(2.0, 7.0, 4.0, 2.0, 3.0, -1.0, 5.0, 6.0, 3.0)) && allOk;
	allOk = compare_float((block[2].padding), 7.0) && allOk;
	allOk = compare_mat3(block[2].var, mat3(-4.0, -2.0, -7.0, -6.0, -3.0, -9.0, 8.0, -8.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-1.0);
	block[0].var = (mat3(-8.0, 7.0, -5.0, 5.0, 6.0, 0.0, -8.0, -6.0, -4.0));
	block[1].padding = (3.0);
	block[1].var = (mat3(7.0, 1.0, -1.0, 9.0, 6.0, 2.0, 9.0, -6.0, 8.0));
	block[2].padding = (0.0);
	block[2].var = (mat3(1.0, 4.0, 6.0, -9.0, -9.0, 2.0, 8.0, -1.0, 9.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), 5.0) && allOk;
	allOk = compare_float(block[0].var[0][0], 8.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -8.0) && allOk;
	allOk = compare_float(block[0].var[0][2], -2.0) && allOk;
	allOk = compare_float(block[0].var[0][3], 6.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -4.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 3.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -1.0) && allOk;
	allOk = compare_float(block[0].var[1][3], 6.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 4.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -8.0) && allOk;
	allOk = compare_float(block[0].var[2][2], -3.0) && allOk;
	allOk = compare_float(block[0].var[2][3], 9.0) && allOk;
	allOk = compare_float(block[0].var[3][0], 9.0) && allOk;
	allOk = compare_float(block[0].var[3][1], 4.0) && allOk;
	allOk = compare_float(block[0].var[3][2], -8.0) && allOk;
	allOk = compare_float(block[0].var[3][3], -6.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(8.0, -8.0, -2.0, 6.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(-4.0, 3.0, -1.0, 6.0)) && allOk;
	allOk = compare_vec4(block[0].var[2], vec4(4.0, -8.0, -3.0, 9.0)) && allOk;
	allOk = compare_vec4(block[0].var[3], vec4(9.0, 4.0, -8.0, -6.0)) && allOk;
	allOk = compare_float((block[1].padding), -5.0) && allOk;
	allOk = compare_float(block[1].var[0][0], 1.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 2.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 1.0) && allOk;
	allOk = compare_float(block[1].var[0][3], 8.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 6.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 2.0) && allOk;
	allOk = compare_float(block[1].var[1][2], -2.0) && allOk;
	allOk = compare_float(block[1].var[1][3], -9.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -8.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -8.0) && allOk;
	allOk = compare_float(block[1].var[2][2], -3.0) && allOk;
	allOk = compare_float(block[1].var[2][3], -9.0) && allOk;
	allOk = compare_float(block[1].var[3][0], -4.0) && allOk;
	allOk = compare_float(block[1].var[3][1], -9.0) && allOk;
	allOk = compare_float(block[1].var[3][2], -1.0) && allOk;
	allOk = compare_float(block[1].var[3][3], -6.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(1.0, 2.0, 1.0, 8.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(6.0, 2.0, -2.0, -9.0)) && allOk;
	allOk = compare_vec4(block[1].var[2], vec4(-8.0, -8.0, -3.0, -9.0)) && allOk;
	allOk = compare_vec4(block[1].var[3], vec4(-4.0, -9.0, -1.0, -6.0)) && allOk;
	allOk = compare_float((block[2].padding), 8.0) && allOk;
	allOk = compare_float(block[2].var[0][0], -9.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -2.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 9.0) && allOk;
	allOk = compare_float(block[2].var[0][3], 7.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 3.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 4.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -1.0) && allOk;
	allOk = compare_float(block[2].var[1][3], -8.0) && allOk;
	allOk = compare_float(block[2].var[2][0], -8.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 9.0) && allOk;
	allOk = compare_float(block[2].var[2][2], -4.0) && allOk;
	allOk = compare_float(block[2].var[2][3], 1.0) && allOk;
	allOk = compare_float(block[2].var[3][0], -6.0) && allOk;
	allOk = compare_float(block[2].var[3][1], -9.0) && allOk;
	allOk = compare_float(block[2].var[3][2], -1.0) && allOk;
	allOk = compare_float(block[2].var[3][3], -9.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(-9.0, -2.0, 9.0, 7.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(3.0, 4.0, -1.0, -8.0)) && allOk;
	allOk = compare_vec4(block[2].var[2], vec4(-8.0, 9.0, -4.0, 1.0)) && allOk;
	allOk = compare_vec4(block[2].var[3], vec4(-6.0, -9.0, -1.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (6.0);
	block[0].var = (mat4(-8.0, 2.0, -8.0, 1.0, -5.0, -7.0, -8.0, -9.0, 3.0, -9.0, -1.0, 7.0, -6.0, -5.0, 2.0, 4.0));
	block[1].padding = (3.0);
	block[1].var = (mat4(-5.0, 6.0, 5.0, -1.0, -1.0, 7.0, -1.0, 5.0, -8.0, -3.0, 2.0, -6.0, -9.0, -5.0, 1.0, -5.0));
	block[2].padding = (-9.0);
	block[2].var = (mat4(9.0, -7.0, -1.0, 6.0, -6.0, 6.0, -9.0, -8.0, -3.0, -3.0, 4.0, -5.0, -1.0, -3.0, -9.0, -6.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), -5.0) && allOk;
	allOk = compare_mat3x2(block[0].var, mat3x2(-4.0, 7.0, 2.0, 0.0, -8.0, -7.0)) && allOk;
	allOk = compare_float((block[1].padding), 3.0) && allOk;
	allOk = compare_mat3x2(block[1].var, mat3x2(3.0, -5.0, 4.0, -6.0, -1.0, -8.0)) && allOk;
	allOk = compare_float((block[2].padding), -4.0) && allOk;
	allOk = compare_mat3x2(block[2].var, mat3x2(-3.0, 2.0, 5.0, -1.0, 8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-3.0);
	block[0].var = (mat3x2(-3.0, -4.0, 2.0, -7.0, 7.0, -2.0));
	block[1].padding = (-8.0);
	block[1].var = (mat3x2(3.0, 4.0, 9.0, 4.0, -2.0, -7.0));
	block[2].padding = (9.0);
	block[2].var = (mat3x2(1.0, -9.0, 9.0, 0.0, -1.0, -3.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), 0.0) && allOk;
	allOk = compare_mat4x2(block[0].var, mat4x2(6.0, -3.0, 7.0, 1.0, -8.0, 8.0, 8.0, 2.0)) && allOk;
	allOk = compare_float((block[1].padding), -3.0) && allOk;
	allOk = compare_mat4x2(block[1].var, mat4x2(-5.0, 5.0, 5.0, 1.0, -7.0, 4.0, 1.0, 1.0)) && allOk;
	allOk = compare_float((block[2].padding), -2.0) && allOk;
	allOk = compare_mat4x2(block[2].var, mat4x2(-3.0, -9.0, 3.0, 9.0, -7.0, 6.0, -2.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (8.0);
	block[0].var = (mat4x2(-5.0, 3.0, 0.0, -9.0, 4.0, -5.0, 3.0, 6.0));
	block[1].padding = (3.0);
	block[1].var = (mat4x2(6.0, -6.0, 0.0, -3.0, -2.0, -4.0, 5.0, 4.0));
	block[2].padding = (1.0);
	block[2].var = (mat4x2(0.0, 7.0, -9.0, -4.0, 5.0, 6.0, 1.0, 0.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), 7.0) && allOk;
	allOk = compare_float(block[0].var[0][0], 3.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 1.0) && allOk;
	allOk = compare_float(block[0].var[0][2], -7.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 1.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -4.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 0.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 9.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 9.0) && allOk;
	allOk = compare_float(block[0].var[2][2], -4.0) && allOk;
	allOk = compare_float(block[0].var[3][0], -2.0) && allOk;
	allOk = compare_float(block[0].var[3][1], 6.0) && allOk;
	allOk = compare_float(block[0].var[3][2], 3.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(3.0, 1.0, -7.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(1.0, -4.0, 0.0)) && allOk;
	allOk = compare_vec3(block[0].var[2], vec3(9.0, 9.0, -4.0)) && allOk;
	allOk = compare_vec3(block[0].var[3], vec3(-2.0, 6.0, 3.0)) && allOk;
	allOk = compare_float((block[1].padding), 6.0) && allOk;
	allOk = compare_float(block[1].var[0][0], 3.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 6.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -4.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 8.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 5.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 4.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 2.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 2.0) && allOk;
	allOk = compare_float(block[1].var[2][2], -6.0) && allOk;
	allOk = compare_float(block[1].var[3][0], 6.0) && allOk;
	allOk = compare_float(block[1].var[3][1], 0.0) && allOk;
	allOk = compare_float(block[1].var[3][2], -4.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(3.0, 6.0, -4.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(8.0, 5.0, 4.0)) && allOk;
	allOk = compare_vec3(block[1].var[2], vec3(2.0, 2.0, -6.0)) && allOk;
	allOk = compare_vec3(block[1].var[3], vec3(6.0, 0.0, -4.0)) && allOk;
	allOk = compare_float((block[2].padding), -5.0) && allOk;
	allOk = compare_float(block[2].var[0][0], -2.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -5.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 8.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -5.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 4.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -7.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 1.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 2.0) && allOk;
	allOk = compare_float(block[2].var[2][2], 8.0) && allOk;
	allOk = compare_float(block[2].var[3][0], 9.0) && allOk;
	allOk = compare_float(block[2].var[3][1], -7.0) && allOk;
	allOk = compare_float(block[2].var[3][2], 0.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(-2.0, -5.0, 8.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(-5.0, 4.0, -7.0)) && allOk;
	allOk = compare_vec3(block[2].var[2], vec3(1.0, 2.0, 8.0)) && allOk;
	allOk = compare_vec3(block[2].var[3], vec3(9.0, -7.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (7.0);
	block[0].var[0] = (vec3(-6.0, 3.0, -3.0));
	block[0].var[1] = (vec3(9.0, -2.0, 3.0));
	block[0].var[2] = (vec3(9.0, -9.0, 7.0));
	block[0].var[3] = (vec3(4.0, -4.0, 5.0));
	block[1].padding = (-1.0);
	block[1].var[0] = (vec3(-4.0, 6.0, 4.0));
	block[1].var[1] = (vec3(-8.0, 7.0, 3.0));
	block[1].var[2] = (vec3(1.0, -9.0, -4.0));
	block[1].var[3] = (vec3(-2.0, 6.0, 9.0));
	block[2].padding = (9.0);
	block[2].var[0] = (vec3(8.0, 2.0, 4.0));
	block[2].var[1] = (vec3(-9.0, 8.0, 2.0));
	block[2].var[2] = (vec3(2.0, 2.0, -8.0));
	block[2].var[3] = (vec3(-7.0, 3.0, 0.0));
}
#version 450
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
layout(std430, buffer_reference) buffer BlockA
{
	highp float a;
	S b;
	lowp uvec3 c;
};
layout(std430, buffer_reference) buffer BlockB
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
	allOk = compare_float((blockA.a), 8.0) && allOk;
	allOk = compare_uint((blockB.b.a), 4u) && allOk;
	allOk = compare_mat3(blockB.b.b.a, mat3(8.0, -2.0, -6.0, -6.0, -8.0, 6.0, 9.0, 9.0, 9.0)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[0]), ivec2(-7, -1)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[1]), ivec2(5, -4)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[2]), ivec2(1, 5)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[3]), ivec2(-1, -5)) && allOk;
	allOk = compare_vec4((blockB.b.b.c), vec4(-4.0, 9.0, 5.0, 0.0)) && allOk;
	allOk = compare_bvec4((blockB.b.c), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bool((blockB.d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (-1.0);
	blockA.b.a[0] = (vec3(0.0, 1.0, 6.0));
	blockA.b.a[1] = (vec3(-6.0, 5.0, 6.0));
	blockA.b.a[2] = (vec3(-9.0, 8.0, 1.0));
	blockA.b.b[0] = (ivec2(4, -5));
	blockA.b.b[1] = (ivec2(1, 8));
	blockA.b.b[2] = (ivec2(-2, -1));
	blockA.b.b[3] = (ivec2(-5, -4));
	blockA.b.c = (vec4(-2.0, 0.0, 2.0, 6.0));
	blockB.a[0] = (vec2(9.0, 9.0));
	blockB.a[1] = (vec2(-4.0, 4.0));
	blockB.b.a = (8u);
	blockB.b.b.a[0] = (vec3(-8.0, 7.0, 3.0));
	blockB.b.b.a[1] = (vec3(-6.0, 4.0, -9.0));
	blockB.b.b.a[2] = (vec3(-1.0, 8.0, 7.0));
	blockB.b.b.b[0] = (ivec2(2, 7));
	blockB.b.b.b[1] = (ivec2(-5, 3));
	blockB.b.b.b[2] = (ivec2(-9, 7));
	blockB.b.b.b[3] = (ivec2(-2, -2));
	blockB.b.b.c = (vec4(9.0, 3.0, -8.0, -5.0));
	blockB.b.c = (bvec4(false, true, true, true));
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

layout(std140, buffer_reference) buffer BlockB
{
	mediump ivec4 a;
	highp vec4 b[1];
	mediump uvec2 c;
	mediump uint d;
};
layout(std140, buffer_reference) buffer BlockC
{
	mediump uvec3 e;
	bool f;
	bool g;
	highp uvec4 h;
};
layout(std430, buffer_reference) buffer BlockD
{
	bvec3 i;
	bvec3 j;
};
layout(std430, buffer_reference) buffer BlockE
{
	mediump float k;
	mediump uint l;
	bvec2 m;
	lowp int n;
	lowp uint o;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.b[0]), vec4(-1.0, -9.0, 5.0, -7.0)) && allOk;
	allOk = compare_uvec3((blockC.e), uvec3(1u, 4u, 1u)) && allOk;
	allOk = compare_bool((blockC.f), false) && allOk;
	allOk = compare_bool((blockC.g), true) && allOk;
	allOk = compare_uvec4((blockC.h), uvec4(9u, 6u, 8u, 1u)) && allOk;
	allOk = compare_bvec3((blockD.i), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockD.j), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec2((blockE.m), bvec2(false, true)) && allOk;
	allOk = compare_uint((blockE.o), 1u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (uvec2(4u, 5u));
	blockB.d = (4u);
	blockC.e = (uvec3(9u, 7u, 2u));
	blockC.g = (false);
	blockC.h = (uvec4(6u, 7u, 8u, 0u));
	blockD.i = (bvec3(true, true, true));
	blockD.j = (bvec3(false, true, false));
	blockE.l = (5u);
	blockE.m = (bvec2(true, false));
	blockE.n = (2);
	blockE.o = (8u);
}
#version 450
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
	lowp vec2 a;
	mediump mat4 b;
	highp uint c;
	lowp vec4 d;
	lowp vec2 e[1];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	lowp int f;
	highp vec3 g;
	mediump mat3 h;
	mediump mat2x3 i;
	mediump mat2 j;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(0.0, -6.0)) && allOk;
	allOk = compare_mat4(blockB.b, mat4(9.0, -5.0, 0.0, 3.0, 7.0, -1.0, -8.0, 2.0, 8.0, -2.0, -2.0, 4.0, -7.0, -2.0, -1.0, 1.0)) && allOk;
	allOk = compare_int((blockC.f), -7) && allOk;
	allOk = compare_mat3(blockC.h, mat3(8.0, 2.0, -6.0, 0.0, -2.0, 7.0, 2.0, 3.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat4(-9.0, 0.0, 9.0, 2.0, -6.0, 6.0, -6.0, 3.0, 5.0, -8.0, -7.0, -8.0, 3.0, -6.0, -9.0, 9.0));
	blockB.e[0] = (vec2(0.0, -4.0));
	blockC.f = (2);
	blockC.g = (vec3(1.0, 2.0, 9.0));
	blockC.i = (mat2x3(2.0, -5.0, -3.0, -8.0, -3.0, 0.0));
	blockC.j = (mat2(8.0, 2.0, -9.0, -4.0));
}
#version 450
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
	lowp float a;
	bvec4 b;
	bvec2 c;
	bvec2 d;
	highp mat3x2 e;
};
layout(std140, column_major, buffer_reference) readonly buffer BlockC
{
	mediump mat3x4 f;
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	mediump vec2 g;
	highp vec2 h;
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
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.b), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec2((blockB.c), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockB.d), bvec2(true, true)) && allOk;
	allOk = compare_mat3x4(blockC.f, mat3x4(5.0, -7.0, -4.0, -7.0, -7.0, 0.0, 6.0, -7.0, 5.0, -9.0, 3.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (-5.0);
	blockB.d = (bvec2(true, true));
	blockB.e = (mat3x2(0.0, 9.0, 3.0, 1.0, -6.0, 4.0));
	blockD.h = (vec2(5.0, 4.0));
}
#version 450
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
	lowp vec2 a;
	lowp mat3 b;
	mediump uint c[1];
	mediump uvec3 d;
	lowp ivec4 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB.b, mat3(0.0, -9.0, -1.0, 4.0, -4.0, 0.0, -2.0, -5.0, 1.0)) && allOk;
	allOk = compare_uvec3((blockB.d), uvec3(6u, 8u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat3(-3.0, -1.0, -2.0, 7.0, -7.0, -6.0, -5.0, -9.0, 4.0));
	blockB.c[0] = (6u);
	blockB.d = (uvec3(2u, 5u, 0u));
	blockB.e[0] = (ivec4(6, -5, 2, -9));
	blockB.e[1] = (ivec4(-8, 3, 6, -6));
	blockB.e[2] = (ivec4(5, 6, -6, 3));
	blockB.e[3] = (ivec4(7, -8, -2, -6));
	blockB.e[4] = (ivec4(-3, 0, 7, -1));
	blockB.e[5] = (ivec4(-5, -8, 9, 7));
	blockB.e[6] = (ivec4(-9, -8, -4, 0));
	blockB.e[7] = (ivec4(-3, 9, 9, -2));
}
#version 450
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
	mediump vec3 a[];
};
layout(std140, row_major, buffer_reference) readonly buffer BlockC
{
	lowp ivec2 b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockC.b[0]), ivec2(6, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (vec3(5.0, 7.0, -9.0));
}
#version 450
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
	highp uint a[];
};
layout(std430, buffer_reference) buffer BlockC
{
	mediump mat4x2 b[];
};
layout(std430, buffer_reference) buffer BlockD
{
	mediump mat4x3 c;
	lowp uvec4 d;
	highp float e;
	lowp mat2x3 f;
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
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockC.b[0], mat4x2(-5.0, -2.0, -9.0, 1.0, -6.0, -8.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(blockC.b[1], mat4x2(7.0, -8.0, 1.0, 5.0, -5.0, -8.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat4x3(blockD.c, mat4x3(-5.0, 8.0, -5.0, 7.0, -8.0, -4.0, -3.0, 5.0, 0.0, -2.0, 3.0, 0.0)) && allOk;
	allOk = compare_uvec4((blockD.d), uvec4(4u, 2u, 0u, 5u)) && allOk;
	allOk = compare_float((blockD.e), -7.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (8u);
	blockB.a[1] = (3u);
	blockB.a[2] = (1u);
	blockB.a[3] = (4u);
	blockB.a[4] = (8u);
	blockB.a[5] = (7u);
	blockB.a[6] = (2u);
	blockC.b[0] = (mat4x2(2.0, 1.0, 8.0, 6.0, 2.0, 9.0, 8.0, 5.0));
	blockC.b[1] = (mat4x2(-5.0, 8.0, -1.0, 7.0, -9.0, -3.0, -1.0, 6.0));
	blockD.d = (uvec4(1u, 7u, 9u, 9u));
	blockD.e = (6.0);
	blockD.f = (mat2x3(2.0, -1.0, 0.0, 2.0, -2.0, -1.0));
	blockD.g[0] = (uvec3(5u, 5u, 5u));
	blockD.g[1] = (uvec3(0u, 9u, 3u));
	blockD.g[2] = (uvec3(0u, 0u, 9u));
}
#version 450
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
	highp mat4x3 a;
	mediump mat2 b[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	lowp vec3 c;
	mediump mat4 d[];
};
layout(std430, row_major, buffer_reference) readonly buffer BlockD
{
	mediump float e;
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB.b[0], mat2(2.0, 8.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat2(blockB.b[1], mat2(-8.0, 7.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat2(blockB.b[2], mat2(2.0, 6.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat2(blockB.b[3], mat2(1.0, 6.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat2(blockB.b[4], mat2(0.0, -1.0, -1.0, 5.0)) && allOk;
	allOk = compare_vec3((blockC.c), vec3(4.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat4(blockC.d[0], mat4(-2.0, -9.0, 1.0, 0.0, 8.0, 0.0, 5.0, -7.0, 6.0, 6.0, 7.0, -7.0, 6.0, -8.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat4(blockC.d[1], mat4(-4.0, 0.0, 4.0, -4.0, 0.0, 0.0, 8.0, -5.0, -1.0, -9.0, -9.0, -1.0, -4.0, 5.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4(blockC.d[2], mat4(8.0, 9.0, -6.0, -3.0, -4.0, 9.0, 9.0, 1.0, 5.0, 9.0, 5.0, -7.0, -3.0, -9.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4(blockC.d[3], mat4(2.0, 3.0, 3.0, 2.0, -8.0, 1.0, 7.0, 3.0, 2.0, 2.0, 3.0, -8.0, -6.0, 3.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4(blockC.d[4], mat4(3.0, -5.0, 8.0, 3.0, 5.0, -6.0, 6.0, -1.0, -7.0, -8.0, 8.0, -2.0, 8.0, 8.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat4(blockC.d[5], mat4(-1.0, -8.0, -1.0, -4.0, -6.0, -9.0, -9.0, -1.0, -4.0, -7.0, -8.0, -4.0, 1.0, -3.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4(blockC.d[6], mat4(6.0, -5.0, 2.0, -1.0, 7.0, -7.0, 8.0, 2.0, -6.0, -8.0, 8.0, 1.0, -4.0, 1.0, -9.0, -7.0)) && allOk;
	allOk = compare_float((blockD.e), 2.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x3(9.0, -2.0, -3.0, -7.0, 6.0, 2.0, -8.0, 7.0, 6.0, -4.0, 5.0, 7.0));
	blockB.b[0] = (mat2(9.0, -2.0, 6.0, 4.0));
	blockB.b[1] = (mat2(0.0, 7.0, 5.0, -3.0));
	blockB.b[2] = (mat2(1.0, 0.0, -8.0, -8.0));
	blockB.b[3] = (mat2(5.0, 2.0, 6.0, 6.0));
	blockB.b[4] = (mat2(-9.0, 7.0, 6.0, 3.0));
	blockC.d[0] = (mat4(4.0, -5.0, 0.0, -7.0, -1.0, 7.0, 9.0, 5.0, -4.0, -6.0, 0.0, -8.0, -2.0, 5.0, -8.0, 0.0));
	blockC.d[1] = (mat4(-6.0, 9.0, 3.0, -2.0, 9.0, -1.0, 8.0, 4.0, 9.0, -5.0, 8.0, 0.0, 3.0, 8.0, 9.0, 3.0));
	blockC.d[2] = (mat4(-9.0, 6.0, 7.0, 3.0, 2.0, -5.0, 6.0, 3.0, -9.0, 6.0, 8.0, 1.0, -3.0, -2.0, -8.0, 1.0));
	blockC.d[3] = (mat4(-4.0, -7.0, 7.0, 9.0, 9.0, -1.0, -1.0, 0.0, -6.0, -6.0, 7.0, 9.0, 0.0, -6.0, 7.0, 4.0));
	blockC.d[4] = (mat4(-6.0, -6.0, 1.0, -1.0, -9.0, 7.0, -5.0, 0.0, -4.0, 7.0, 2.0, -2.0, 7.0, -4.0, 7.0, 2.0));
	blockC.d[5] = (mat4(8.0, -9.0, -2.0, -8.0, 9.0, -3.0, -1.0, -4.0, 8.0, 1.0, 0.0, -1.0, 3.0, 6.0, 8.0, 6.0));
	blockC.d[6] = (mat4(-7.0, -6.0, 6.0, -3.0, 1.0, -6.0, -9.0, 9.0, 3.0, 5.0, 7.0, -2.0, 3.0, 6.0, 1.0, -9.0));
}
#version 450
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
	mediump vec4 a;
	highp mat2x3 b[];
};
layout(std430, buffer_reference) buffer BlockC
{
	lowp mat4x2 c;
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	lowp mat4 d;
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

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.a), vec4(4.0, -1.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat4x2(blockC.c, mat4x2(6.0, 8.0, -9.0, -6.0, -5.0, -8.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4(blockD.d, mat4(-1.0, -1.0, -2.0, -7.0, 4.0, 6.0, -4.0, -1.0, 8.0, 3.0, 9.0, -7.0, 9.0, 7.0, -5.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec4(5.0, 7.0, -9.0, -6.0));
	blockB.b[0] = (mat2x3(1.0, -1.0, -9.0, -2.0, -3.0, -9.0));
	blockC.c = (mat4x2(-2.0, -4.0, -4.0, 3.0, 4.0, 9.0, 1.0, 2.0));
	blockD.d = (mat4(-6.0, 5.0, 9.0, 2.0, -1.0, -7.0, 3.0, -7.0, -5.0, 7.0, 5.0, 5.0, 7.0, -3.0, 2.0, -2.0));
}
#version 450
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
	lowp mat2 mA;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	mediump mat4x2 a;
	sA b;
	mediump mat3 c;
	mediump uvec2 d;
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	lowp mat3 e;
	lowp mat4x2 f;
	highp mat4x2 g;
	bool h[][2];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	mediump uint i;
	highp mat4x2 j;
	bool k[4];
	lowp mat2x3 l[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB.a, mat4x2(-8.0, -1.0, -8.0, 4.0, 0.0, -4.0, -9.0, 0.0)) && allOk;
	allOk = compare_uvec2((blockB.d), uvec2(4u, 6u)) && allOk;
	allOk = compare_mat4x2(blockC.f, mat4x2(-7.0, 8.0, -2.0, -1.0, 2.0, 5.0, 7.0, 9.0)) && allOk;
	allOk = compare_uint((blockD.i), 6u) && allOk;
	allOk = compare_bool((blockD.k[0]), false) && allOk;
	allOk = compare_bool((blockD.k[1]), true) && allOk;
	allOk = compare_bool((blockD.k[2]), false) && allOk;
	allOk = compare_bool((blockD.k[3]), true) && allOk;
	allOk = compare_mat2x3(blockD.l[0], mat2x3(-9.0, 2.0, 1.0, 2.0, 5.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x2(-2.0, -2.0, -9.0, 7.0, -3.0, -7.0, -1.0, -6.0));
	blockB.c = (mat3(2.0, 6.0, -9.0, 6.0, -5.0, -8.0, 4.0, 2.0, 3.0));
	blockC.e = (mat3(5.0, 3.0, -2.0, 6.0, 7.0, -6.0, -6.0, -8.0, -3.0));
	blockC.h[0][0] = (true);
	blockC.h[0][1] = (true);
	blockC.h[1][0] = (true);
	blockC.h[1][1] = (false);
	blockC.h[2][0] = (false);
	blockC.h[2][1] = (false);
	blockC.h[3][0] = (false);
	blockC.h[3][1] = (false);
	blockC.h[4][0] = (false);
	blockC.h[4][1] = (true);
	blockC.h[5][0] = (true);
	blockC.h[5][1] = (false);
	blockD.i = (0u);
	blockD.j = (mat4x2(3.0, -3.0, 2.0, 8.0, -8.0, -7.0, 9.0, -9.0));
	blockD.k[0] = (false);
	blockD.k[1] = (false);
	blockD.k[2] = (false);
	blockD.k[3] = (false);
}
#version 450
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
	mediump ivec4 mA;
	highp uint mB;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	mediump mat3x2 a;
	bvec4 b;
	sA c;
	lowp ivec4 d[];
};
layout(std430, buffer_reference) buffer BlockC
{
	highp mat4x3 e;
	mediump vec3 f;
	lowp mat4x3 g[][6];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.b), bvec4(true, true, true, true)) && allOk;
	allOk = compare_mat4x3(blockC[0].e, mat4x3(-3.0, 6.0, -4.0, 6.0, -4.0, 2.0, -6.0, -2.0, -4.0, -5.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(blockC[1].e, mat4x3(8.0, -9.0, -2.0, 1.0, 1.0, 3.0, 2.0, -8.0, 4.0, 1.0, -2.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (bvec4(true, false, true, true));
	blockB.c.mA = (ivec4(3, 9, -4, 1));
	blockB.c.mB = (3u);
	blockB.d[0] = (ivec4(4, 6, 9, 8));
	blockB.d[1] = (ivec4(-8, -8, -4, 9));
	blockB.d[2] = (ivec4(-2, -5, 3, -8));
	blockC[0].e = (mat4x3(1.0, 2.0, 9.0, -1.0, -6.0, 4.0, -2.0, -1.0, 3.0, 3.0, -9.0, 7.0));
	blockC[1].e = (mat4x3(5.0, -8.0, -7.0, -1.0, 2.0, 1.0, 6.0, 6.0, 4.0, 4.0, 1.0, -7.0));
}
#version 450
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
	lowp uvec4 mB;
};
struct sB
{
	mediump vec3 mA;
	lowp vec4 mB;
};
layout(scalar, column_major, buffer_reference) buffer BlockB
{
	lowp mat3 a;
	highp vec2 b;
	highp mat3 c;
	lowp ivec2 d[];
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	highp ivec2 e[];
};
layout(scalar, buffer_reference) buffer BlockD
{
	lowp uvec2 f;
	sA g;
	sB h;
	mediump mat3 i;
	mediump uint j[];
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
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB.a, mat3(6.0, -5.0, 3.0, 0.0, -5.0, -3.0, 9.0, 4.0, 6.0)) && allOk;
	allOk = compare_ivec2((blockB.d[0]), ivec2(-3, -1)) && allOk;
	allOk = compare_ivec2((blockB.d[1]), ivec2(2, 5)) && allOk;
	allOk = compare_mat2(blockD.g.mA, mat2(-4.0, 7.0, 8.0, 2.0)) && allOk;
	allOk = compare_uvec4((blockD.g.mB), uvec4(1u, 1u, 5u, 6u)) && allOk;
	allOk = compare_mat3(blockD.i, mat3(2.0, -5.0, -9.0, -4.0, 5.0, 3.0, 7.0, 4.0, 8.0)) && allOk;
	allOk = compare_uint((blockD.j[0]), 2u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3(-2.0, -4.0, -9.0, -4.0, 6.0, 4.0, 8.0, -8.0, 0.0));
	blockB.b = (vec2(4.0, -9.0));
	blockB.c = (mat3(0.0, 0.0, -1.0, -8.0, -1.0, -9.0, -8.0, -9.0, -5.0));
	blockB.d[0] = (ivec2(3, -8));
	blockB.d[1] = (ivec2(-3, -2));
	blockC.e[0] = (ivec2(-4, -1));
	blockD.f = (uvec2(9u, 6u));
	blockD.g.mA = (mat2(8.0, 7.0, -1.0, -3.0));
	blockD.g.mB = (uvec4(6u, 3u, 9u, 3u));
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

layout(std430, buffer_reference) buffer BlockB
{
	lowp ivec4 a;
	highp mat4x2 b[1];
	lowp mat3x4 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b[0] = (mat4x2(-1.0, -2.0, 7.0, -5.0, -5.0, -4.0, 1.0, -7.0));
	blockB[nonuniformEXT(1)].b[0] = (mat4x2(9.0, -9.0, 4.0, 4.0, -4.0, -4.0, 0.0, 3.0));
}
#version 450
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
	bvec4 a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB[nonuniformEXT(0)].a), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(1)].a), bvec4(true, true, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (bvec4(true, false, true, false));
	blockB[nonuniformEXT(1)].a = (bvec4(true, true, false, true));
}
#version 450
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
	mediump vec2 a[1];
	i16vec4 b;
	mediump int c;
	mediump ivec4 d;
	bvec3 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a[0]), vec2(0.0, 2.0)) && allOk;
	allOk = compare_int((blockB.c), -6) && allOk;
	allOk = compare_ivec4((blockB.d), ivec4(1, 9, -4, -3)) && allOk;
	allOk = compare_bvec3((blockB.e), bvec3(false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (vec2(6.0, -1.0));
	blockB.b = i16vec4(ivec4(0, 3, -7, 6));
	blockB.c = (-7);
	blockB.d = (ivec4(6, -8, -4, -6));
	blockB.e = (bvec3(true, false, true));
}
#version 450
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
	i16vec4 a;
	bool b;
	mediump mat4 c;
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	f16vec4 d;
	f16vec2 e[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	lowp uvec4 f[];
};
layout(std430, row_major, buffer_reference) buffer BlockE
{
	mediump uvec2 g;
	i16vec4 h[6];
	u16vec4 i[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(blockB.a), ivec4(2, 5, 9, -9)) && allOk;
	allOk = compare_mat4(blockB.c, mat4(-4.0, 4.0, 5.0, 3.0, 7.0, 5.0, 1.0, -2.0, 6.0, 3.0, -6.0, -9.0, -9.0, 3.0, 8.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.e[0]), vec2(9.0, -9.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.e[1]), vec2(8.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.e[2]), vec2(-5.0, -9.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockE.h[0]), ivec4(-9, -4, 1, 1)) && allOk;
	allOk = compare_i16vec4(ivec4(blockE.h[1]), ivec4(-4, -5, -1, 2)) && allOk;
	allOk = compare_i16vec4(ivec4(blockE.h[2]), ivec4(4, -2, 2, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(blockE.h[3]), ivec4(8, -8, 9, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(blockE.h[4]), ivec4(8, -1, -8, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(blockE.h[5]), ivec4(4, -5, 4, 7)) && allOk;
	allOk = compare_u16vec4(uvec4(blockE.i[0]), uvec4(8u, 2u, 8u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockE.i[1]), uvec4(4u, 1u, 6u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockE.i[2]), uvec4(6u, 1u, 1u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockE.i[3]), uvec4(2u, 0u, 1u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockE.i[4]), uvec4(3u, 9u, 1u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i16vec4(ivec4(-1, -4, 2, -1));
	blockB.b = (true);
	blockB.c = (mat4(-5.0, 7.0, -5.0, 5.0, -3.0, 4.0, -8.0, 9.0, -2.0, 5.0, -1.0, 9.0, 2.0, 3.0, -2.0, 9.0));
	blockC.d = f16vec4(vec4(-6.0, 3.0, 5.0, 5.0));
	blockC.e[0] = f16vec2(vec2(9.0, 3.0));
	blockC.e[1] = f16vec2(vec2(-9.0, -1.0));
	blockC.e[2] = f16vec2(vec2(-5.0, -8.0));
	blockD.f[0] = (uvec4(4u, 3u, 9u, 5u));
	blockE.h[0] = i16vec4(ivec4(2, -4, 6, 9));
	blockE.h[1] = i16vec4(ivec4(9, -1, -2, 8));
	blockE.h[2] = i16vec4(ivec4(7, -5, -2, -3));
	blockE.h[3] = i16vec4(ivec4(-4, 3, 1, -2));
	blockE.h[4] = i16vec4(ivec4(-3, -9, 9, -1));
	blockE.h[5] = i16vec4(ivec4(-3, -4, -3, 1));
}
#version 450
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
	highp uvec2 a;
	uint16_t b;
	lowp uvec4 c;
	lowp ivec2 d;
	i16vec4 e[];
};
layout(std140, buffer_reference) buffer BlockC
{
	float16_t f;
	highp mat2 g[];
};
layout(std140, buffer_reference) buffer BlockD
{
	highp mat2 h;
	highp ivec3 i;
	bvec2 j[1];
	mediump ivec4 k[];
};
layout(std430, column_major, buffer_reference) buffer BlockE
{
	f16vec4 l;
	highp ivec3 m;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[1];
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a), uvec2(4u, 9u)) && allOk;
	allOk = compare_uint16_t(uint(blockB.b), 6u) && allOk;
	allOk = compare_i16vec4(ivec4(blockB.e[0]), ivec4(-7, 3, 6, 2)) && allOk;
	allOk = compare_float16_t(float(blockC.f), 3.0) && allOk;
	allOk = compare_f16vec4(vec4(blockE.l), vec4(-1.0, 6.0, -9.0, -2.0)) && allOk;
	allOk = compare_ivec3((blockE.m), ivec3(-2, 1, 7)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec2(8u, 6u));
	blockB.e[0] = i16vec4(ivec4(2, -4, -8, -4));
	blockC.f = float16_t(8.0);
	blockD[0].i = (ivec3(9, -1, 1));
	blockD[0].k[0] = (ivec4(-6, 4, 8, -8));
	blockE.m = (ivec3(6, 1, 3));
}
#version 450
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
};
struct sB
{
	sA mA;
	mediump uvec3 mB;
	int16_t mC[3];
	lowp uvec4 mD;
};
layout(std430, buffer_reference) buffer BlockB
{
	mediump mat2 a;
	sB b;
	highp mat2 c;
	f16vec4 d[7][4];
	u16vec4 e[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	bool f[6];
	mediump mat2x3 g;
	lowp int h;
	f16vec3 i;
	float16_t j[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	highp mat3x4 k[1];
	highp mat4x2 l;
	f16vec2 m;
	i16vec4 n[];
};
layout(std140, buffer_reference) buffer BlockE
{
	lowp mat4x3 o;
	highp ivec3 p;
	highp uvec2 q[];
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(blockB.b.mA.mA), uvec2(5u, 7u)) && allOk;
	allOk = compare_uvec3((blockB.b.mB), uvec3(9u, 2u, 0u)) && allOk;
	allOk = compare_int16_t(int(blockB.b.mC[0]), -1) && allOk;
	allOk = compare_int16_t(int(blockB.b.mC[1]), 4) && allOk;
	allOk = compare_int16_t(int(blockB.b.mC[2]), -7) && allOk;
	allOk = compare_uvec4((blockB.b.mD), uvec4(0u, 2u, 4u, 2u)) && allOk;
	allOk = compare_mat2(blockB.c, mat2(5.0, -4.0, 1.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.d[0][0]), vec4(-4.0, -3.0, 1.0, 5.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.d[0][1]), vec4(6.0, 9.0, 0.0, 1.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.d[0][2]), vec4(-3.0, 1.0, 6.0, 6.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.d[0][3]), vec4(6.0, -8.0, 6.0, 6.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.d[1][0]), vec4(5.0, 1.0, 4.0, 6.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.d[1][1]), vec4(-4.0, 0.0, 1.0, 2.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.d[1][2]), vec4(-1.0, 9.0, -9.0, 9.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.d[1][3]), vec4(3.0, -9.0, 3.0, 5.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.d[2][0]), vec4(2.0, 3.0, 1.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.d[2][1]), vec4(-5.0, 9.0, 1.0, 5.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.d[2][2]), vec4(-7.0, 6.0, -1.0, -9.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.d[2][3]), vec4(-5.0, 8.0, 5.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.d[3][0]), vec4(-1.0, -8.0, 4.0, -7.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.d[3][1]), vec4(1.0, 4.0, -2.0, 0.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.d[3][2]), vec4(-1.0, -3.0, -7.0, 2.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.d[3][3]), vec4(3.0, 2.0, 6.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.d[4][0]), vec4(8.0, 2.0, -5.0, 9.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.d[4][1]), vec4(-2.0, 9.0, 9.0, 2.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.d[4][2]), vec4(1.0, -5.0, 8.0, -5.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.d[4][3]), vec4(3.0, 9.0, 6.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.d[5][0]), vec4(6.0, 4.0, 4.0, -7.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.d[5][1]), vec4(-3.0, 7.0, -3.0, 9.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.d[5][2]), vec4(-7.0, -5.0, -7.0, 0.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.d[5][3]), vec4(-2.0, 3.0, 2.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.d[6][0]), vec4(-2.0, 1.0, 6.0, -3.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.d[6][1]), vec4(1.0, -6.0, 5.0, -1.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.d[6][2]), vec4(-2.0, -6.0, -9.0, 1.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.d[6][3]), vec4(9.0, 4.0, 1.0, 6.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.e[0]), uvec4(7u, 0u, 5u, 5u)) && allOk;
	allOk = compare_bool((blockC.f[0]), true) && allOk;
	allOk = compare_bool((blockC.f[1]), true) && allOk;
	allOk = compare_bool((blockC.f[2]), false) && allOk;
	allOk = compare_bool((blockC.f[3]), false) && allOk;
	allOk = compare_bool((blockC.f[4]), false) && allOk;
	allOk = compare_bool((blockC.f[5]), false) && allOk;
	allOk = compare_int((blockC.h), 2) && allOk;
	allOk = compare_float16_t(float(blockC.j[0]), 9.0) && allOk;
	allOk = compare_float16_t(float(blockC.j[1]), 0.0) && allOk;
	allOk = compare_float16_t(float(blockC.j[2]), -6.0) && allOk;
	allOk = compare_mat3x4(blockD.k[0], mat3x4(-4.0, -3.0, 2.0, 7.0, -4.0, -5.0, -9.0, -8.0, 3.0, -3.0, 2.0, 3.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockD.m), vec2(-5.0, 5.0)) && allOk;
	allOk = compare_mat4x3(blockE.o, mat4x3(-1.0, 2.0, -3.0, 5.0, 1.0, 7.0, 4.0, 3.0, 8.0, -8.0, -1.0, 4.0)) && allOk;
	allOk = compare_ivec3((blockE.p), ivec3(4, 6, 3)) && allOk;
	allOk = compare_uvec2((blockE.q[0]), uvec2(5u, 7u)) && allOk;
	allOk = compare_uvec2((blockE.q[1]), uvec2(4u, 3u)) && allOk;
	allOk = compare_uvec2((blockE.q[2]), uvec2(7u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.d[0][0] = f16vec4(vec4(-4.0, -4.0, 1.0, -6.0));
	blockB.d[0][1] = f16vec4(vec4(2.0, -1.0, 4.0, -4.0));
	blockB.d[0][2] = f16vec4(vec4(-7.0, 8.0, -8.0, 1.0));
	blockB.d[0][3] = f16vec4(vec4(-1.0, -6.0, -3.0, 2.0));
	blockB.d[1][0] = f16vec4(vec4(0.0, -6.0, -5.0, -6.0));
	blockB.d[1][1] = f16vec4(vec4(6.0, -7.0, 0.0, -9.0));
	blockB.d[1][2] = f16vec4(vec4(-1.0, -1.0, 4.0, -2.0));
	blockB.d[1][3] = f16vec4(vec4(-5.0, 5.0, 3.0, 0.0));
	blockB.d[2][0] = f16vec4(vec4(9.0, -5.0, -3.0, 3.0));
	blockB.d[2][1] = f16vec4(vec4(-7.0, 0.0, -2.0, -2.0));
	blockB.d[2][2] = f16vec4(vec4(7.0, -9.0, -8.0, 3.0));
	blockB.d[2][3] = f16vec4(vec4(5.0, 5.0, -1.0, 7.0));
	blockB.d[3][0] = f16vec4(vec4(-1.0, -8.0, 0.0, -8.0));
	blockB.d[3][1] = f16vec4(vec4(4.0, -3.0, -4.0, 9.0));
	blockB.d[3][2] = f16vec4(vec4(-9.0, -8.0, 8.0, 1.0));
	blockB.d[3][3] = f16vec4(vec4(2.0, -6.0, 8.0, -9.0));
	blockB.d[4][0] = f16vec4(vec4(7.0, -1.0, 3.0, -8.0));
	blockB.d[4][1] = f16vec4(vec4(3.0, 9.0, 6.0, -4.0));
	blockB.d[4][2] = f16vec4(vec4(0.0, -9.0, 3.0, 5.0));
	blockB.d[4][3] = f16vec4(vec4(0.0, -7.0, 1.0, 0.0));
	blockB.d[5][0] = f16vec4(vec4(0.0, -4.0, 5.0, -3.0));
	blockB.d[5][1] = f16vec4(vec4(2.0, 1.0, 8.0, -6.0));
	blockB.d[5][2] = f16vec4(vec4(2.0, -5.0, 6.0, 2.0));
	blockB.d[5][3] = f16vec4(vec4(0.0, -4.0, 7.0, -3.0));
	blockB.d[6][0] = f16vec4(vec4(3.0, -9.0, 4.0, 8.0));
	blockB.d[6][1] = f16vec4(vec4(3.0, -6.0, -5.0, 9.0));
	blockB.d[6][2] = f16vec4(vec4(-6.0, -9.0, -2.0, -4.0));
	blockB.d[6][3] = f16vec4(vec4(-9.0, -8.0, 6.0, 3.0));
	blockB.e[0] = u16vec4(uvec4(8u, 9u, 2u, 2u));
	blockC.f[0] = (true);
	blockC.f[1] = (false);
	blockC.f[2] = (true);
	blockC.f[3] = (false);
	blockC.f[4] = (false);
	blockC.f[5] = (true);
	blockC.g = (mat2x3(5.0, 7.0, -4.0, -2.0, 5.0, 4.0));
	blockC.h = (2);
	blockC.i = f16vec3(vec3(9.0, -5.0, 6.0));
	blockD.l = (mat4x2(-5.0, 2.0, -6.0, 2.0, 6.0, 8.0, 1.0, 0.0));
	blockD.m = f16vec2(vec2(-6.0, -9.0));
	blockD.n[0] = i16vec4(ivec4(2, -2, 4, 1));
	blockD.n[1] = i16vec4(ivec4(-3, 0, -6, -4));
	blockD.n[2] = i16vec4(ivec4(4, 2, -1, -4));
	blockE.o = (mat4x3(2.0, 7.0, 5.0, -3.0, 8.0, -3.0, 7.0, 6.0, -9.0, 7.0, -7.0, 4.0));
	blockE.p = (ivec3(-8, 1, 5));
}
#version 450
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
	mediump mat4 a[1];
	i16vec3 b;
	mediump mat4x3 c;
	u16vec2 d;
	mediump mat3x4 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB[0].a[0], mat4(0.0, -6.0, 9.0, -5.0, 0.0, 3.0, 7.0, -1.0, -8.0, 2.0, 8.0, -2.0, -2.0, 4.0, -7.0, -2.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB[0].b), ivec3(-1, 1, -1)) && allOk;
	allOk = compare_mat4x3(blockB[0].c, mat4x3(-6.0, 3.0, -7.0, 4.0, 1.0, -6.0, -7.0, 2.0, 8.0, -2.0, 8.0, 0.0)) && allOk;
	allOk = compare_u16vec2(uvec2(blockB[0].d), uvec2(3u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (mat4(6.0, 3.0, -9.0, 0.0, 9.0, 2.0, -6.0, 6.0, -6.0, 3.0, 5.0, -8.0, -7.0, -8.0, 3.0, -6.0));
	blockB[0].b = i16vec3(ivec3(-9, 9, -9));
	blockB[0].c = (mat4x3(9.0, 8.0, -1.0, -4.0, 0.0, -4.0, 2.0, 1.0, 2.0, 9.0, -3.0, -2.0));
	blockB[0].e = (mat3x4(5.0, -3.0, 2.0, 0.0, 0.0, 2.0, -8.0, -5.0, -3.0, -3.0, 0.0, 8.0));
}
#version 450
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
	lowp ivec2 a[2];
	uint16_t b;
	i16vec3 c;
	mediump mat2x3 d;
	bool e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB[0].a[0]), ivec2(-5, -9)) && allOk;
	allOk = compare_ivec2((blockB[0].a[1]), ivec2(-7, 9)) && allOk;
	allOk = compare_uint16_t(uint(blockB[0].b), 6u) && allOk;
	allOk = compare_i16vec3(ivec3(blockB[0].c), ivec3(0, -3, 9)) && allOk;
	allOk = compare_mat2x3(blockB[0].d, mat2x3(-2.0, 0.0, 3.0, -3.0, 2.0, -3.0)) && allOk;
	allOk = compare_bool((blockB[0].e[0]), false) && allOk;
	allOk = compare_bool((blockB[0].e[1]), true) && allOk;
	allOk = compare_bool((blockB[0].e[2]), true) && allOk;
	allOk = compare_bool((blockB[0].e[3]), false) && allOk;
	allOk = compare_bool((blockB[0].e[4]), false) && allOk;
	allOk = compare_bool((blockB[0].e[5]), false) && allOk;
	allOk = compare_bool((blockB[0].e[6]), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (ivec2(-7, 4));
	blockB[0].a[1] = (ivec2(-4, -7));
	blockB[0].b = uint16_t(6u);
	blockB[0].c = i16vec3(ivec3(-9, 1, 2));
	blockB[0].d = (mat2x3(8.0, -2.0, 5.0, -7.0, -5.0, -9.0));
}
#version 450
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
	mediump float b[2];
	u16vec4 c;
	bool d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB[0].b[0]), 7.0) && allOk;
	allOk = compare_float((blockB[0].b[1]), 5.0) && allOk;
	allOk = compare_bool((blockB[0].d[0]), false) && allOk;
	allOk = compare_bool((blockB[0].d[1]), true) && allOk;
	allOk = compare_bool((blockB[0].d[2]), true) && allOk;
	allOk = compare_float((blockB[1].b[0]), -5.0) && allOk;
	allOk = compare_float((blockB[1].b[1]), -9.0) && allOk;
	allOk = compare_bool((blockB[1].d[0]), true) && allOk;
	allOk = compare_bool((blockB[1].d[1]), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b[0] = (5.0);
	blockB[0].b[1] = (-3.0);
	blockB[0].c = u16vec4(uvec4(1u, 9u, 0u, 9u));
	blockB[0].d[0] = (true);
	blockB[0].d[1] = (false);
	blockB[0].d[2] = (true);
	blockB[1].b[0] = (-1.0);
	blockB[1].b[1] = (-5.0);
	blockB[1].c = u16vec4(uvec4(0u, 4u, 3u, 9u));
	blockB[1].d[0] = (false);
	blockB[1].d[1] = (false);
}
#version 450
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
	bvec3 a;
	lowp mat4x3 b[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	highp mat4 c;
	lowp int d[];
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	bvec2 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC[3];
    BlockD blockD[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB[0].a), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockB[1].a), bvec3(false, false, false)) && allOk;
	allOk = compare_mat4(blockC[0].c, mat4(-3.0, 7.0, 9.0, -4.0, 6.0, -7.0, 0.0, -8.0, -2.0, 5.0, 5.0, -2.0, 5.0, 8.0, -4.0, -6.0)) && allOk;
	allOk = compare_int((blockC[0].d[0]), -4) && allOk;
	allOk = compare_int((blockC[0].d[1]), -3) && allOk;
	allOk = compare_int((blockC[0].d[2]), -4) && allOk;
	allOk = compare_int((blockC[0].d[3]), -2) && allOk;
	allOk = compare_mat4(blockC[1].c, mat4(-5.0, 1.0, 8.0, -7.0, -9.0, 9.0, -2.0, -6.0, 3.0, 7.0, 3.0, -7.0, -5.0, 3.0, 4.0, 7.0)) && allOk;
	allOk = compare_int((blockC[1].d[0]), -2) && allOk;
	allOk = compare_int((blockC[1].d[1]), 7) && allOk;
	allOk = compare_int((blockC[1].d[2]), -8) && allOk;
	allOk = compare_int((blockC[1].d[3]), -3) && allOk;
	allOk = compare_int((blockC[1].d[4]), 9) && allOk;
	allOk = compare_int((blockC[1].d[5]), 4) && allOk;
	allOk = compare_int((blockC[1].d[6]), -2) && allOk;
	allOk = compare_int((blockC[1].d[7]), 5) && allOk;
	allOk = compare_mat4(blockC[2].c, mat4(-9.0, -9.0, 5.0, 5.0, -7.0, 5.0, 2.0, -5.0, 8.0, -9.0, 8.0, 0.0, -5.0, 7.0, 6.0, -2.0)) && allOk;
	allOk = compare_int((blockC[2].d[0]), 4) && allOk;
	allOk = compare_bvec2((blockD[0].e[0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockD[0].e[1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockD[1].e[0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockD[2].e[0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockD[2].e[1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockD[2].e[2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockD[2].e[3]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockD[2].e[4]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockD[2].e[5]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockD[2].e[6]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockD[2].e[7]), bvec2(false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b[0] = (mat4x3(-5.0, -8.0, 3.0, -9.0, 2.0, 6.0, 1.0, 9.0, -5.0, 9.0, -3.0, 6.0));
	blockB[0].b[1] = (mat4x3(7.0, -9.0, -6.0, -1.0, 3.0, 5.0, 3.0, 9.0, 8.0, -4.0, -8.0, -5.0));
	blockB[0].b[2] = (mat4x3(-1.0, 2.0, 0.0, 5.0, 3.0, -3.0, 2.0, 4.0, 4.0, -6.0, 4.0, -5.0));
	blockB[0].b[3] = (mat4x3(-2.0, -4.0, -5.0, 7.0, 6.0, -9.0, 0.0, -7.0, 2.0, 1.0, 9.0, 2.0));
	blockB[0].b[4] = (mat4x3(-9.0, -2.0, -7.0, 8.0, 8.0, 8.0, 7.0, 9.0, -6.0, -3.0, -1.0, 3.0));
	blockB[0].b[5] = (mat4x3(7.0, -2.0, -7.0, -7.0, -5.0, 3.0, 8.0, 6.0, -1.0, -8.0, -7.0, 3.0));
	blockB[1].b[0] = (mat4x3(-7.0, -3.0, 7.0, 0.0, -9.0, 0.0, -8.0, 2.0, -1.0, 4.0, -7.0, 7.0));
	blockB[1].b[1] = (mat4x3(8.0, -3.0, 5.0, -2.0, 6.0, 7.0, -8.0, -1.0, 4.0, 4.0, -2.0, 3.0));
	blockB[1].b[2] = (mat4x3(-2.0, -4.0, 1.0, -1.0, -6.0, -4.0, 9.0, -2.0, 3.0, 4.0, 8.0, -6.0));
	blockB[1].b[3] = (mat4x3(-3.0, 6.0, 8.0, -8.0, -6.0, -3.0, 2.0, -3.0, -5.0, -2.0, 9.0, 5.0));
	blockC[0].c = (mat4(5.0, 3.0, 6.0, -4.0, -9.0, 1.0, 3.0, -8.0, -2.0, 0.0, 6.0, 2.0, -8.0, -6.0, 1.0, -6.0));
	blockC[1].c = (mat4(-2.0, 0.0, 5.0, 9.0, 2.0, -7.0, 6.0, 9.0, 3.0, 1.0, -3.0, -1.0, 7.0, -5.0, 7.0, 9.0));
	blockC[2].c = (mat4(-9.0, -8.0, -2.0, 9.0, 1.0, 4.0, 4.0, 6.0, 4.0, -7.0, -8.0, 0.0, 9.0, -4.0, 6.0, 1.0));
	blockD[0].e[0] = (bvec2(true, false));
	blockD[0].e[1] = (bvec2(false, false));
	blockD[1].e[0] = (bvec2(true, false));
	blockD[2].e[0] = (bvec2(true, false));
	blockD[2].e[1] = (bvec2(false, true));
	blockD[2].e[2] = (bvec2(true, false));
	blockD[2].e[3] = (bvec2(false, true));
	blockD[2].e[4] = (bvec2(true, true));
	blockD[2].e[5] = (bvec2(false, false));
	blockD[2].e[6] = (bvec2(true, true));
	blockD[2].e[7] = (bvec2(true, true));
}
#version 450
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
	layout(offset = 0) lowp uvec2 a;
	layout(offset = 8) u16vec2 b;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) bool c;
	layout(offset = 16) lowp uvec4 d;
	layout(offset = 32) f16vec4 e;
};
layout(buffer_reference) readonly buffer BlockD
{
	layout(offset = 0) i16vec2 f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a), uvec2(5u, 0u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockB.b), uvec2(2u, 9u)) && allOk;
	allOk = compare_bool((blockC.c), false) && allOk;
	allOk = compare_uvec4((blockC.d), uvec4(6u, 1u, 9u, 0u)) && allOk;
	allOk = compare_f16vec4(vec4(blockC.e), vec4(9.0, 7.0, 0.0, 4.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD.f), ivec2(-6, -1)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = u16vec2(uvec2(6u, 6u));
	blockC.c = (true);
}
#version 450
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
	layout(offset = 0) u16vec4 a;
	layout(offset = 16) highp ivec3 b;
	layout(offset = 32) mediump uvec2 c;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump uint d;
	layout(offset = 4) u16vec3 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(blockB.a), uvec4(0u, 7u, 0u, 2u)) && allOk;
	allOk = compare_ivec3((blockB.b), ivec3(5, -2, -2)) && allOk;
	allOk = compare_uvec2((blockB.c), uvec2(7u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (uvec2(4u, 2u));
	blockC.d = (1u);
	blockC.e = u16vec3(uvec3(1u, 3u, 7u));
}
#version 450
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
	layout(offset = 0) mediump vec2 a;
	layout(offset = 8) mediump int b;
	layout(offset = 12) uint16_t c;
	layout(offset = 16) f16vec2 d;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) lowp vec2 e;
	layout(offset = 8) u16vec4 f;
	layout(offset = 16) u16vec3 g;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) u16vec2 h;
	layout(offset = 4) i16vec2 i;
	layout(offset = 8) i16vec3 j[1];
	layout(offset = 16) i16vec4 k;
	layout(offset = 32) lowp vec3 l;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(2.0, 5.0)) && allOk;
	allOk = compare_uint16_t(uint(blockB.c), 3u) && allOk;
	allOk = compare_vec2((blockC.e), vec2(-8.0, -1.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.g), uvec3(1u, 8u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockD.h), uvec2(8u, 5u)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k), ivec4(-9, -5, -1, 9)) && allOk;
	allOk = compare_vec3((blockD.l), vec3(-8.0, -5.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec2(8.0, 3.0));
	blockB.b = (6);
	blockB.c = uint16_t(6u);
	blockB.d = f16vec2(vec2(-4.0, 6.0));
	blockC.e = (vec2(-5.0, 8.0));
	blockC.f = u16vec4(uvec4(4u, 1u, 3u, 6u));
	blockD.h = u16vec2(uvec2(5u, 6u));
	blockD.i = i16vec2(ivec2(2, -9));
	blockD.j[0] = i16vec3(ivec3(9, 7, -1));
	blockD.k = i16vec4(ivec4(6, -5, -8, 2));
	blockD.l = (vec3(5.0, -4.0, -3.0));
}
#version 450
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
	highp mat2 mB;
	uint16_t mC;
};
struct sB
{
	sA mA;
};
layout(scalar, row_major, buffer_reference) readonly buffer BlockB
{
	highp float a;
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	bvec4 b;
	bvec2 c;
	i16vec3 d[];
};
layout(scalar, buffer_reference) buffer BlockD
{
	int16_t e;
	sB f[][4];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockC.b), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec2((blockC.c), bvec2(false, false)) && allOk;
	allOk = compare_i16vec3(ivec3(blockC.d[0]), ivec3(-3, 6, -6)) && allOk;
	allOk = compare_i16vec3(ivec3(blockC.d[1]), ivec3(9, -2, 5)) && allOk;
	allOk = compare_i16vec3(ivec3(blockC.d[2]), ivec3(-6, -3, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockC.d[3]), ivec3(-6, 1, 2)) && allOk;
	allOk = compare_i16vec3(ivec3(blockC.d[4]), ivec3(4, 8, 8)) && allOk;
	allOk = compare_i16vec3(ivec3(blockC.d[5]), ivec3(0, 1, 4)) && allOk;
	allOk = compare_i16vec3(ivec3(blockC.d[6]), ivec3(-9, 9, 7)) && allOk;
	allOk = compare_i16vec3(ivec3(blockC.d[7]), ivec3(2, -8, 7)) && allOk;
	allOk = compare_int16_t(int(blockD.e), 5) && allOk;
	allOk = compare_f16vec3(vec3(blockD.f[0][0].mA.mA), vec3(-7.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat2(blockD.f[0][0].mA.mB, mat2(4.0, 0.0, 9.0, -5.0)) && allOk;
	allOk = compare_uint16_t(uint(blockD.f[0][0].mA.mC), 4u) && allOk;
	allOk = compare_f16vec3(vec3(blockD.f[0][1].mA.mA), vec3(-7.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat2(blockD.f[0][1].mA.mB, mat2(-1.0, 3.0, -4.0, -9.0)) && allOk;
	allOk = compare_uint16_t(uint(blockD.f[0][1].mA.mC), 8u) && allOk;
	allOk = compare_f16vec3(vec3(blockD.f[0][2].mA.mA), vec3(-4.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat2(blockD.f[0][2].mA.mB, mat2(-1.0, 8.0, -8.0, 2.0)) && allOk;
	allOk = compare_uint16_t(uint(blockD.f[0][2].mA.mC), 9u) && allOk;
	allOk = compare_f16vec3(vec3(blockD.f[0][3].mA.mA), vec3(6.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2(blockD.f[0][3].mA.mB, mat2(9.0, 4.0, -5.0, 9.0)) && allOk;
	allOk = compare_uint16_t(uint(blockD.f[0][3].mA.mC), 8u) && allOk;
	allOk = compare_f16vec3(vec3(blockD.f[1][0].mA.mA), vec3(3.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat2(blockD.f[1][0].mA.mB, mat2(7.0, -4.0, 5.0, 7.0)) && allOk;
	allOk = compare_uint16_t(uint(blockD.f[1][0].mA.mC), 8u) && allOk;
	allOk = compare_f16vec3(vec3(blockD.f[1][1].mA.mA), vec3(6.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat2(blockD.f[1][1].mA.mB, mat2(4.0, -7.0, -3.0, 2.0)) && allOk;
	allOk = compare_uint16_t(uint(blockD.f[1][1].mA.mC), 1u) && allOk;
	allOk = compare_f16vec3(vec3(blockD.f[1][2].mA.mA), vec3(-8.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2(blockD.f[1][2].mA.mB, mat2(2.0, -6.0, 1.0, 9.0)) && allOk;
	allOk = compare_uint16_t(uint(blockD.f[1][2].mA.mC), 8u) && allOk;
	allOk = compare_f16vec3(vec3(blockD.f[1][3].mA.mA), vec3(3.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2(blockD.f[1][3].mA.mB, mat2(-3.0, 8.0, 9.0, -4.0)) && allOk;
	allOk = compare_uint16_t(uint(blockD.f[1][3].mA.mC), 5u) && allOk;
	allOk = compare_f16vec3(vec3(blockD.f[2][0].mA.mA), vec3(-3.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat2(blockD.f[2][0].mA.mB, mat2(-8.0, -1.0, 8.0, 8.0)) && allOk;
	allOk = compare_uint16_t(uint(blockD.f[2][0].mA.mC), 4u) && allOk;
	allOk = compare_f16vec3(vec3(blockD.f[2][1].mA.mA), vec3(7.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2(blockD.f[2][1].mA.mB, mat2(5.0, 1.0, -9.0, -8.0)) && allOk;
	allOk = compare_uint16_t(uint(blockD.f[2][1].mA.mC), 2u) && allOk;
	allOk = compare_f16vec3(vec3(blockD.f[2][2].mA.mA), vec3(3.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat2(blockD.f[2][2].mA.mB, mat2(-2.0, -2.0, 6.0, -5.0)) && allOk;
	allOk = compare_uint16_t(uint(blockD.f[2][2].mA.mC), 1u) && allOk;
	allOk = compare_f16vec3(vec3(blockD.f[2][3].mA.mA), vec3(6.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat2(blockD.f[2][3].mA.mB, mat2(0.0, -1.0, 9.0, 1.0)) && allOk;
	allOk = compare_uint16_t(uint(blockD.f[2][3].mA.mC), 8u) && allOk;
	allOk = compare_f16vec3(vec3(blockD.f[3][0].mA.mA), vec3(6.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat2(blockD.f[3][0].mA.mB, mat2(7.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_uint16_t(uint(blockD.f[3][0].mA.mC), 3u) && allOk;
	allOk = compare_f16vec3(vec3(blockD.f[3][1].mA.mA), vec3(-4.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2(blockD.f[3][1].mA.mB, mat2(-9.0, -3.0, 3.0, -7.0)) && allOk;
	allOk = compare_uint16_t(uint(blockD.f[3][1].mA.mC), 0u) && allOk;
	allOk = compare_f16vec3(vec3(blockD.f[3][2].mA.mA), vec3(6.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2(blockD.f[3][2].mA.mB, mat2(-2.0, -5.0, -3.0, 4.0)) && allOk;
	allOk = compare_uint16_t(uint(blockD.f[3][2].mA.mC), 5u) && allOk;
	allOk = compare_f16vec3(vec3(blockD.f[3][3].mA.mA), vec3(0.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat2(blockD.f[3][3].mA.mB, mat2(9.0, 8.0, 8.0, 4.0)) && allOk;
	allOk = compare_uint16_t(uint(blockD.f[3][3].mA.mC), 4u) && allOk;
	allOk = compare_f16vec3(vec3(blockD.f[4][0].mA.mA), vec3(-9.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat2(blockD.f[4][0].mA.mB, mat2(-6.0, -1.0, 5.0, 8.0)) && allOk;
	allOk = compare_uint16_t(uint(blockD.f[4][0].mA.mC), 0u) && allOk;
	allOk = compare_f16vec3(vec3(blockD.f[4][1].mA.mA), vec3(4.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat2(blockD.f[4][1].mA.mB, mat2(-6.0, -3.0, 3.0, -1.0)) && allOk;
	allOk = compare_uint16_t(uint(blockD.f[4][1].mA.mC), 5u) && allOk;
	allOk = compare_f16vec3(vec3(blockD.f[4][2].mA.mA), vec3(-1.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat2(blockD.f[4][2].mA.mB, mat2(3.0, 2.0, 9.0, -3.0)) && allOk;
	allOk = compare_uint16_t(uint(blockD.f[4][2].mA.mC), 0u) && allOk;
	allOk = compare_f16vec3(vec3(blockD.f[4][3].mA.mA), vec3(-3.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat2(blockD.f[4][3].mA.mB, mat2(-9.0, 6.0, 6.0, -7.0)) && allOk;
	allOk = compare_uint16_t(uint(blockD.f[4][3].mA.mC), 1u) && allOk;
	allOk = compare_f16vec3(vec3(blockD.f[5][0].mA.mA), vec3(-3.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2(blockD.f[5][0].mA.mB, mat2(-9.0, -6.0, 2.0, -8.0)) && allOk;
	allOk = compare_uint16_t(uint(blockD.f[5][0].mA.mC), 3u) && allOk;
	allOk = compare_f16vec3(vec3(blockD.f[5][1].mA.mA), vec3(-5.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2(blockD.f[5][1].mA.mB, mat2(0.0, -2.0, -4.0, 6.0)) && allOk;
	allOk = compare_uint16_t(uint(blockD.f[5][1].mA.mC), 9u) && allOk;
	allOk = compare_f16vec3(vec3(blockD.f[5][2].mA.mA), vec3(-5.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat2(blockD.f[5][2].mA.mB, mat2(4.0, -9.0, 7.0, -2.0)) && allOk;
	allOk = compare_uint16_t(uint(blockD.f[5][2].mA.mC), 1u) && allOk;
	allOk = compare_f16vec3(vec3(blockD.f[5][3].mA.mA), vec3(-2.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat2(blockD.f[5][3].mA.mB, mat2(7.0, 9.0, 9.0, 1.0)) && allOk;
	allOk = compare_uint16_t(uint(blockD.f[5][3].mA.mC), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (bvec4(false, false, true, true));
	blockC.c = (bvec2(false, true));
	blockD.e = int16_t(9);
	blockD.f[0][0].mA.mA = f16vec3(vec3(-6.0, 8.0, 5.0));
	blockD.f[0][0].mA.mB = (mat2(1.0, 1.0, -2.0, -3.0));
	blockD.f[0][0].mA.mC = uint16_t(7u);
	blockD.f[0][1].mA.mA = f16vec3(vec3(-6.0, 7.0, -7.0));
	blockD.f[0][1].mA.mB = (mat2(-1.0, -1.0, -9.0, -8.0));
	blockD.f[0][1].mA.mC = uint16_t(6u);
	blockD.f[0][2].mA.mA = f16vec3(vec3(2.0, -4.0, -1.0));
	blockD.f[0][2].mA.mB = (mat2(-1.0, 0.0, 4.0, 9.0));
	blockD.f[0][2].mA.mC = uint16_t(9u);
	blockD.f[0][3].mA.mA = f16vec3(vec3(7.0, 0.0, -4.0));
	blockD.f[0][3].mA.mB = (mat2(8.0, -9.0, 9.0, -8.0));
	blockD.f[0][3].mA.mC = uint16_t(9u);
	blockD.f[1][0].mA.mA = f16vec3(vec3(3.0, -3.0, 6.0));
	blockD.f[1][0].mA.mB = (mat2(8.0, 2.0, -1.0, -8.0));
	blockD.f[1][0].mA.mC = uint16_t(9u);
	blockD.f[1][1].mA.mA = f16vec3(vec3(7.0, -2.0, 2.0));
	blockD.f[1][1].mA.mB = (mat2(1.0, 9.0, -2.0, 2.0));
	blockD.f[1][1].mA.mC = uint16_t(5u);
	blockD.f[1][2].mA.mA = f16vec3(vec3(-8.0, -3.0, 3.0));
	blockD.f[1][2].mA.mB = (mat2(-2.0, 0.0, 9.0, 9.0));
	blockD.f[1][2].mA.mC = uint16_t(1u);
	blockD.f[1][3].mA.mA = f16vec3(vec3(-4.0, -6.0, 4.0));
	blockD.f[1][3].mA.mB = (mat2(8.0, -8.0, 5.0, 8.0));
	blockD.f[1][3].mA.mC = uint16_t(9u);
	blockD.f[2][0].mA.mA = f16vec3(vec3(-2.0, 2.0, -5.0));
	blockD.f[2][0].mA.mB = (mat2(9.0, -7.0, 5.0, 1.0));
	blockD.f[2][0].mA.mC = uint16_t(9u);
	blockD.f[2][1].mA.mA = f16vec3(vec3(2.0, 4.0, -9.0));
	blockD.f[2][1].mA.mB = (mat2(1.0, 2.0, -8.0, 0.0));
	blockD.f[2][1].mA.mC = uint16_t(3u);
	blockD.f[2][2].mA.mA = f16vec3(vec3(3.0, 8.0, 2.0));
	blockD.f[2][2].mA.mB = (mat2(-2.0, -5.0, 9.0, -8.0));
	blockD.f[2][2].mA.mC = uint16_t(2u);
	blockD.f[2][3].mA.mA = f16vec3(vec3(8.0, -1.0, -6.0));
	blockD.f[2][3].mA.mB = (mat2(-6.0, 9.0, -3.0, -2.0));
	blockD.f[2][3].mA.mC = uint16_t(0u);
	blockD.f[3][0].mA.mA = f16vec3(vec3(5.0, 5.0, 3.0));
	blockD.f[3][0].mA.mB = (mat2(3.0, 6.0, -8.0, -8.0));
	blockD.f[3][0].mA.mC = uint16_t(9u);
	blockD.f[3][1].mA.mA = f16vec3(vec3(9.0, -2.0, -4.0));
	blockD.f[3][1].mA.mB = (mat2(6.0, -1.0, 1.0, -3.0));
	blockD.f[3][1].mA.mC = uint16_t(8u);
	blockD.f[3][2].mA.mA = f16vec3(vec3(-9.0, -2.0, -3.0));
	blockD.f[3][2].mA.mB = (mat2(8.0, -5.0, 5.0, -7.0));
	blockD.f[3][2].mA.mC = uint16_t(9u);
	blockD.f[3][3].mA.mA = f16vec3(vec3(4.0, 3.0, 2.0));
	blockD.f[3][3].mA.mB = (mat2(-4.0, 8.0, 7.0, 6.0));
	blockD.f[3][3].mA.mC = uint16_t(7u);
	blockD.f[4][0].mA.mA = f16vec3(vec3(8.0, 5.0, 5.0));
	blockD.f[4][0].mA.mB = (mat2(-6.0, 7.0, 6.0, -5.0));
	blockD.f[4][0].mA.mC = uint16_t(1u);
	blockD.f[4][1].mA.mA = f16vec3(vec3(-3.0, 7.0, 8.0));
	blockD.f[4][1].mA.mB = (mat2(7.0, -9.0, 3.0, -1.0));
	blockD.f[4][1].mA.mC = uint16_t(8u);
	blockD.f[4][2].mA.mA = f16vec3(vec3(4.0, -7.0, -6.0));
	blockD.f[4][2].mA.mB = (mat2(-4.0, 3.0, 4.0, -1.0));
	blockD.f[4][2].mA.mC = uint16_t(0u);
	blockD.f[4][3].mA.mA = f16vec3(vec3(3.0, 6.0, -1.0));
	blockD.f[4][3].mA.mB = (mat2(3.0, 4.0, 0.0, 9.0));
	blockD.f[4][3].mA.mC = uint16_t(5u);
	blockD.f[5][0].mA.mA = f16vec3(vec3(3.0, 6.0, 5.0));
	blockD.f[5][0].mA.mB = (mat2(7.0, 6.0, -6.0, 0.0));
	blockD.f[5][0].mA.mC = uint16_t(9u);
	blockD.f[5][1].mA.mA = f16vec3(vec3(-4.0, -5.0, -8.0));
	blockD.f[5][1].mA.mB = (mat2(0.0, 8.0, -9.0, -5.0));
	blockD.f[5][1].mA.mC = uint16_t(2u);
	blockD.f[5][2].mA.mA = f16vec3(vec3(8.0, 5.0, 2.0));
	blockD.f[5][2].mA.mB = (mat2(6.0, 1.0, 9.0, -3.0));
	blockD.f[5][2].mA.mC = uint16_t(4u);
	blockD.f[5][3].mA.mA = f16vec3(vec3(-4.0, -2.0, 5.0));
	blockD.f[5][3].mA.mB = (mat2(6.0, 0.0, 3.0, -6.0));
	blockD.f[5][3].mA.mC = uint16_t(9u);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, buffer_reference) readonly buffer BlockB
{
	lowp mat2x3 a;
	i16vec2 b;
	highp mat2x3 c;
	f16vec2 d;
};
layout(scalar, buffer_reference) readonly buffer BlockC
{
	f16vec4 e[];
};
layout(scalar, column_major, buffer_reference) readonly buffer BlockD
{
	lowp uvec3 f;
	highp vec4 g;
	int16_t h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC[3];
    BlockD blockD[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB[0].a, mat2x3(-8.0, -9.0, -9.0, 3.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2x3(blockB[0].c, mat2x3(3.0, 4.0, 1.0, 4.0, 6.0, 9.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[0].e[0]), vec4(5.0, 1.0, 5.0, -7.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[0].e[1]), vec4(4.0, 7.0, 2.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[0].e[2]), vec4(8.0, -3.0, -6.0, -5.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[0].e[3]), vec4(-2.0, -4.0, 6.0, 5.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[1].e[0]), vec4(0.0, -6.0, -7.0, 2.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[1].e[1]), vec4(8.0, 4.0, 6.0, 8.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[1].e[2]), vec4(1.0, 6.0, 6.0, -1.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[1].e[3]), vec4(-7.0, -6.0, -6.0, 9.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[1].e[4]), vec4(6.0, -5.0, 4.0, 8.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[1].e[5]), vec4(5.0, -6.0, -7.0, -3.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[1].e[6]), vec4(-3.0, -3.0, -2.0, 9.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[1].e[7]), vec4(-7.0, -9.0, 8.0, 7.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[2].e[0]), vec4(9.0, 6.0, -4.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[2].e[1]), vec4(-4.0, 5.0, 2.0, 3.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[2].e[2]), vec4(-9.0, 8.0, 5.0, 2.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[2].e[3]), vec4(-7.0, 2.0, 8.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[2].e[4]), vec4(7.0, 3.0, 7.0, 1.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[2].e[5]), vec4(2.0, -7.0, 7.0, 8.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[2].e[6]), vec4(8.0, 6.0, -2.0, -2.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[2].e[7]), vec4(-1.0, -4.0, -9.0, 2.0)) && allOk;
	allOk = compare_uvec3((blockD[0].f), uvec3(6u, 2u, 1u)) && allOk;
	allOk = compare_vec4((blockD[0].g), vec4(-3.0, 5.0, 7.0, 2.0)) && allOk;
	allOk = compare_uvec3((blockD[1].f), uvec3(6u, 5u, 7u)) && allOk;
	allOk = compare_vec4((blockD[1].g), vec4(0.0, -4.0, 4.0, -2.0)) && allOk;
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
	lowp mat4x2 mA;
};
layout(scalar, buffer_reference) buffer BlockB
{
	lowp ivec4 a;
	lowp mat4 b;
	highp mat3x4 c[5];
	highp vec3 d[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	sA e;
	f16vec4 f;
	mediump mat2 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.a), ivec4(9, -2, -1, 7)) && allOk;
	allOk = compare_mat4(blockB.b, mat4(-1.0, 0.0, -7.0, -4.0, 2.0, 8.0, -9.0, 1.0, 7.0, 6.0, 2.0, -1.0, 2.0, 8.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat3x4(blockB.c[0], mat3x4(-7.0, -2.0, 4.0, -8.0, 0.0, -2.0, 8.0, -4.0, 1.0, 9.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat3x4(blockB.c[1], mat3x4(0.0, 7.0, 3.0, -1.0, -3.0, 2.0, 9.0, 7.0, -8.0, 1.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat3x4(blockB.c[2], mat3x4(1.0, 9.0, 0.0, 3.0, -9.0, -4.0, -3.0, 8.0, 5.0, 4.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat3x4(blockB.c[3], mat3x4(-2.0, 9.0, 2.0, 7.0, 4.0, -6.0, 2.0, 9.0, 3.0, 2.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3x4(blockB.c[4], mat3x4(3.0, 0.0, 4.0, -1.0, -7.0, 9.0, 0.0, -4.0, 8.0, 4.0, 3.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[0].f), vec4(4.0, 9.0, -2.0, -3.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[1].f), vec4(3.0, -7.0, -5.0, -9.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[2].f), vec4(5.0, -6.0, -8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec4(1, -6, -2, 5));
	blockB.d[0] = (vec3(-2.0, 5.0, -6.0));
	blockB.d[1] = (vec3(-8.0, -5.0, 0.0));
	blockB.d[2] = (vec3(4.0, 3.0, -1.0));
	blockB.d[3] = (vec3(9.0, -6.0, -4.0));
	blockB.d[4] = (vec3(3.0, -3.0, -1.0));
	blockB.d[5] = (vec3(6.0, -6.0, -4.0));
	blockB.d[6] = (vec3(3.0, 2.0, 9.0));
	blockB.d[7] = (vec3(5.0, 2.0, -3.0));
	blockC[0].e.mA = (mat4x2(-7.0, 3.0, 0.0, 7.0, -4.0, 4.0, -4.0, 3.0));
	blockC[0].f = f16vec4(vec4(-4.0, -1.0, 0.0, -6.0));
	blockC[0].g[0] = (mat2(4.0, -6.0, -2.0, 6.0));
	blockC[0].g[1] = (mat2(-9.0, -9.0, -2.0, -7.0));
	blockC[0].g[2] = (mat2(4.0, -4.0, -2.0, 5.0));
	blockC[0].g[3] = (mat2(-9.0, -1.0, -1.0, 8.0));
	blockC[1].e.mA = (mat4x2(-8.0, -8.0, 8.0, -7.0, 5.0, -5.0, -4.0, 4.0));
	blockC[1].f = f16vec4(vec4(-6.0, -8.0, 8.0, 7.0));
	blockC[1].g[0] = (mat2(4.0, 1.0, 5.0, 1.0));
	blockC[1].g[1] = (mat2(5.0, 7.0, -5.0, -1.0));
	blockC[1].g[2] = (mat2(-1.0, 7.0, 4.0, 2.0));
	blockC[1].g[3] = (mat2(-2.0, -4.0, -6.0, -2.0));
	blockC[1].g[4] = (mat2(1.0, -7.0, -6.0, 1.0));
	blockC[1].g[5] = (mat2(9.0, 9.0, -6.0, 6.0));
	blockC[1].g[6] = (mat2(-9.0, 2.0, 5.0, 7.0));
	blockC[1].g[7] = (mat2(5.0, 8.0, 3.0, 2.0));
	blockC[2].e.mA = (mat4x2(-6.0, -9.0, -2.0, 9.0, -6.0, -1.0, -3.0, 5.0));
	blockC[2].f = f16vec4(vec4(5.0, -7.0, 6.0, 8.0));
	blockC[2].g[0] = (mat2(-6.0, 8.0, 5.0, 0.0));
	blockC[2].g[1] = (mat2(-2.0, 3.0, 7.0, 3.0));
	blockC[2].g[2] = (mat2(-9.0, 7.0, -2.0, 8.0));
	blockC[2].g[3] = (mat2(3.0, 2.0, -5.0, 6.0));
}
#version 450
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
	mediump vec2 a;
	mediump float b;
	i16vec3 c[];
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	bvec2 d;
	highp vec4 e[2];
	f16vec3 f;
	bool g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(2.0, 0.0)) && allOk;
	allOk = compare_vec4((blockC.e[0]), vec4(-4.0, -8.0, -8.0, -7.0)) && allOk;
	allOk = compare_vec4((blockC.e[1]), vec4(-6.0, -2.0, 4.0, 7.0)) && allOk;
	allOk = compare_bool((blockC.g[0]), true) && allOk;
	allOk = compare_bool((blockC.g[1]), true) && allOk;
	allOk = compare_bool((blockC.g[2]), true) && allOk;
	allOk = compare_bool((blockC.g[3]), true) && allOk;
	allOk = compare_bool((blockC.g[4]), false) && allOk;
	allOk = compare_bool((blockC.g[5]), false) && allOk;
	allOk = compare_bool((blockC.g[6]), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec2(2.0, -8.0));
	blockB.b = (-2.0);
	blockC.e[0] = (vec4(-8.0, -3.0, 2.0, -3.0));
	blockC.e[1] = (vec4(1.0, -2.0, 5.0, -7.0));
	blockC.f = f16vec3(vec3(-4.0, -5.0, 0.0));
	blockC.g[0] = (false);
	blockC.g[1] = (false);
	blockC.g[2] = (false);
	blockC.g[3] = (false);
	blockC.g[4] = (false);
	blockC.g[5] = (false);
	blockC.g[6] = (true);
}
#version 450
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
	i16vec4 mB[5];
};
struct sB
{
	highp int mA;
	sA mB;
};
layout(scalar, column_major, buffer_reference) buffer BlockB
{
	lowp vec2 a;
	f16vec4 b[2];
	lowp float c;
	bvec4 d[];
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	i16vec4 e;
	sB f[];
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	highp ivec4 g;
	highp mat4x3 h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.d[0]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((blockB.d[1]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((blockB.d[2]), bvec4(false, true, false, false)) && allOk;
	allOk = compare_bvec4((blockB.d[3]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((blockB.d[4]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_int((blockC.f[0].mA), 8) && allOk;
	allOk = compare_ivec2((blockC.f[0].mB.mA), ivec2(5, -8)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.f[0].mB.mB[0]), ivec4(9, -5, 5, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.f[0].mB.mB[1]), ivec4(-9, 9, -3, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.f[0].mB.mB[2]), ivec4(8, -5, -9, -9)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.f[0].mB.mB[3]), ivec4(3, -3, 8, 1)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.f[0].mB.mB[4]), ivec4(7, 3, -1, 4)) && allOk;
	allOk = compare_int((blockC.f[1].mA), -3) && allOk;
	allOk = compare_ivec2((blockC.f[1].mB.mA), ivec2(1, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.f[1].mB.mB[0]), ivec4(-3, 8, -8, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.f[1].mB.mB[1]), ivec4(-3, 7, 6, -5)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.f[1].mB.mB[2]), ivec4(0, -4, 2, -4)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.f[1].mB.mB[3]), ivec4(-3, -3, -9, -4)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.f[1].mB.mB[4]), ivec4(-4, 0, -1, 6)) && allOk;
	allOk = compare_ivec4((blockD.g), ivec4(-5, 2, -8, 0)) && allOk;
	allOk = compare_mat4x3(blockD.h[0], mat4x3(9.0, -8.0, -2.0, -7.0, -4.0, 1.0, -7.0, 2.0, 5.0, 9.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat4x3(blockD.h[1], mat4x3(-7.0, 8.0, -2.0, 5.0, 3.0, -4.0, -6.0, -8.0, 2.0, 7.0, -3.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec2(8.0, 3.0));
	blockC.f[0].mA = (-3);
	blockC.f[0].mB.mA = (ivec2(6, -2));
	blockC.f[0].mB.mB[0] = i16vec4(ivec4(8, 7, -8, 0));
	blockC.f[0].mB.mB[1] = i16vec4(ivec4(8, 7, -9, 1));
	blockC.f[0].mB.mB[2] = i16vec4(ivec4(-9, -8, -4, 1));
	blockC.f[0].mB.mB[3] = i16vec4(ivec4(4, 9, -6, -5));
	blockC.f[0].mB.mB[4] = i16vec4(ivec4(9, 3, 2, -3));
	blockC.f[1].mA = (5);
	blockC.f[1].mB.mA = (ivec2(2, 8));
	blockC.f[1].mB.mB[0] = i16vec4(ivec4(5, -6, -3, 3));
	blockC.f[1].mB.mB[1] = i16vec4(ivec4(7, 6, -7, 3));
	blockC.f[1].mB.mB[2] = i16vec4(ivec4(5, 4, -1, 1));
	blockC.f[1].mB.mB[3] = i16vec4(ivec4(-7, -7, 6, 3));
	blockC.f[1].mB.mB[4] = i16vec4(ivec4(9, 5, 9, 2));
	blockD.g = (ivec4(2, -7, 2, 7));
	blockD.h[0] = (mat4x3(-8.0, 3.0, -4.0, -3.0, 4.0, 8.0, 3.0, -3.0, 0.0, -2.0, 6.0, -2.0));
	blockD.h[1] = (mat4x3(6.0, 5.0, 0.0, -3.0, -1.0, -7.0, 0.0, -5.0, 4.0, 7.0, -3.0, 6.0));
}
#version 450
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
	i8vec2 a;
	highp ivec4 b;
	i8vec4 c;
	mediump vec4 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(blockB.a), ivec2(0, 4294967290)) && allOk;
	allOk = compare_ivec4((blockB.b), ivec4(9, -5, 0, 3)) && allOk;
	allOk = compare_vec4((blockB.d), vec4(8.0, -2.0, -2.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i8vec2(ivec2(6, 3));
	blockB.b = (ivec4(-9, 0, 9, 2));
	blockB.d = (vec4(5.0, -8.0, -7.0, -8.0));
}
#version 450
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
	highp ivec3 a;
	mediump int b;
	highp uvec4 c;
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	mediump float d[1];
	lowp mat4x2 e;
	highp ivec4 f;
	highp uint g;
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	mediump uvec2 h;
	mediump mat4x3 i;
	u8vec3 j[2];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a), ivec3(-2, 4, 3)) && allOk;
	allOk = compare_uvec4((blockB.c), uvec4(9u, 2u, 4u, 3u)) && allOk;
	allOk = compare_float((blockC.d[0]), -3.0) && allOk;
	allOk = compare_uvec2((blockD.h), uvec2(1u, 0u)) && allOk;
	allOk = compare_mat4x3(blockD.i, mat4x3(8.0, -9.0, -8.0, 0.0, 9.0, 7.0, 1.0, 7.0, 5.0, 4.0, 2.0, -7.0)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD.j[0]), uvec3(2u, 6u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD.j[1]), uvec3(7u, 6u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (uvec4(9u, 4u, 3u, 0u));
	blockC.d[0] = (-4.0);
	blockC.f = (ivec4(-7, 2, -5, -9));
	blockC.g = (5u);
	blockD.h = (uvec2(4u, 0u));
	blockD.j[0] = u8vec3(uvec3(9u, 9u, 6u));
	blockD.j[1] = u8vec3(uvec3(4u, 6u, 6u));
}
#version 450
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
	mediump mat4x3 a;
	bool b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.a, mat4x3(2.0, 4.0, -3.0, -3.0, 6.0, -3.0, 2.0, -2.0, 1.0, -4.0, -5.0, -3.0)) && allOk;
	allOk = compare_bool((blockB.b[0]), false) && allOk;
	allOk = compare_bool((blockB.b[1]), true) && allOk;
	allOk = compare_bool((blockB.b[2]), true) && allOk;
	allOk = compare_bool((blockB.b[3]), false) && allOk;
	allOk = compare_bool((blockB.b[4]), true) && allOk;
	allOk = compare_bool((blockB.b[5]), false) && allOk;
	allOk = compare_bool((blockB.b[6]), true) && allOk;
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

layout(std430, column_major, buffer_reference) readonly buffer BlockB
{
	i8vec4 a[1];
	highp mat2 b[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	highp uvec4 c;
	highp vec3 d;
	highp mat3x4 e;
	int8_t f;
	highp vec2 g[];
};
layout(std430, buffer_reference) readonly buffer BlockD
{
	u8vec2 h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
    BlockD blockD[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(blockB[0].a[0]), ivec4(4294967289, 3, 4294967294, 9)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[1].a[0]), ivec4(4294967288, 6, 4294967291, 4294967288)) && allOk;
	allOk = compare_uvec4((blockC.c), uvec4(4u, 0u, 6u, 4u)) && allOk;
	allOk = compare_vec3((blockC.d), vec3(0.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(blockC.e, mat3x4(-5.0, -5.0, 0.0, -2.0, 2.0, 4.0, -9.0, 0.0, 7.0, -7.0, -3.0, -6.0)) && allOk;
	allOk = compare_int8_t(int(blockC.f), 4294967293) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.c = (uvec4(2u, 2u, 3u, 0u));
	blockC.d = (vec3(2.0, -7.0, 4.0));
	blockC.e = (mat3x4(9.0, 3.0, 1.0, -1.0, -8.0, -1.0, -8.0, -5.0, -1.0, 4.0, -8.0, 7.0));
	blockC.g[0] = (vec2(-3.0, -8.0));
}
#version 450
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
};
layout(std140, buffer_reference) buffer BlockB
{
	sA a[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB.a[0].mA = (uvec4(5u, 2u, 5u, 7u));
}
#version 450
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
	mediump mat2 mA;
	i8vec2 mB;
	uint8_t mC;
	mediump mat4x3 mD;
};
layout(std430, buffer_reference) buffer BlockB
{
	sA a[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB.a[0].mA, mat2(-9.0, 9.0, 2.0, 0.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.a[0].mB), ivec2(5, 5)) && allOk;
	allOk = compare_uint8_t(uint(blockB.a[0].mC), 8u) && allOk;
	allOk = compare_mat4x3(blockB.a[0].mD, mat4x3(-5.0, -2.0, -9.0, 1.0, -6.0, -8.0, -5.0, 9.0, 7.0, -8.0, 1.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0].mA = (mat2(-9.0, -3.0, 8.0, 0.0));
	blockB.a[0].mB = i8vec2(ivec2(4294967293, 9));
	blockB.a[0].mC = uint8_t(2u);
	blockB.a[0].mD = (mat4x3(2.0, 1.0, 8.0, 6.0, 2.0, 9.0, 8.0, 5.0, -5.0, 8.0, -1.0, 7.0));
}
#version 450
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
	i8vec2 mA;
};
struct sB
{
	uint8_t mA;
	highp uint mB;
};
struct sC
{
	lowp uvec2 mA;
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	i8vec3 a;
	sA b;
	highp vec4 c[];
};
layout(std140, buffer_reference) buffer BlockC
{
	u8vec2 d;
	bvec3 e;
	uint8_t f;
};
layout(std140, buffer_reference) buffer BlockD
{
	sB g;
	sC h;
	uint8_t i;
	u8vec4 j[];
};
layout(std140, column_major, buffer_reference) buffer BlockE
{
	mediump ivec2 k;
	int8_t l;
	highp mat3x2 m;
	mediump mat3x2 n;
	mediump float o[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(blockB.a), ivec3(4294967288, 4294967294, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.b.mA), ivec2(4294967291, 5)) && allOk;
	allOk = compare_vec4((blockB.c[0]), vec4(6.0, -1.0, 9.0, -1.0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.d), uvec2(8u, 3u)) && allOk;
	allOk = compare_bvec3((blockC.e), bvec3(true, true, true)) && allOk;
	allOk = compare_uint8_t(uint(blockD.g.mA), 8u) && allOk;
	allOk = compare_uint((blockD.g.mB), 6u) && allOk;
	allOk = compare_uvec2((blockD.h.mA), uvec2(8u, 1u)) && allOk;
	allOk = compare_uint8_t(uint(blockD.i), 2u) && allOk;
	allOk = compare_u8vec4(uvec4(blockD.j[0]), uvec4(1u, 7u, 3u, 1u)) && allOk;
	allOk = compare_ivec2((blockE[0].k), ivec2(-8, -1)) && allOk;
	allOk = compare_int8_t(int(blockE[0].l), 4294967290) && allOk;
	allOk = compare_mat3x2(blockE[0].m, mat3x2(5.0, 3.0, 3.0, -9.0, 4.0, 8.0)) && allOk;
	allOk = compare_float((blockE[0].o[0]), -5.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i8vec3(ivec3(1, 1, 4294967292));
	blockB.c[0] = (vec4(-4.0, 1.0, -9.0, 3.0));
	blockC.d = u8vec2(uvec2(7u, 8u));
	blockC.e = (bvec3(true, true, true));
	blockC.f = uint8_t(3u);
	blockD.h.mA = (uvec2(8u, 5u));
	blockD.j[0] = u8vec4(uvec4(7u, 5u, 6u, 6u));
	blockE[0].n = (mat3x2(3.0, 9.0, 8.0, 1.0, 7.0, -9.0));
	blockE[0].o[0] = (2.0);
}
#version 450
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
	highp mat4x2 a;
	highp mat4 b;
	lowp float c;
	highp mat4x3 d[];
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

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.b, mat4(3.0, 9.0, 1.0, -5.0, -2.0, 0.0, 9.0, -1.0, -9.0, -6.0, -9.0, 6.0, 1.0, -6.0, 0.0, 2.0)) && allOk;
	allOk = compare_float((blockB.c), 5.0) && allOk;
	allOk = compare_mat4x3(blockB.d[0], mat4x3(6.0, 4.0, 1.0, -7.0, -5.0, 1.0, 2.0, -7.0, 5.0, -6.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4x3(blockB.d[1], mat4x3(8.0, -5.0, 9.0, -9.0, -2.0, 6.0, -7.0, 8.0, 3.0, 9.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4x3(blockB.d[2], mat4x3(7.0, 3.0, -3.0, 8.0, 1.0, -8.0, -3.0, -3.0, -3.0, 3.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat4x3(blockB.d[3], mat4x3(3.0, 1.0, 9.0, -4.0, 4.0, 8.0, 2.0, 3.0, 0.0, -1.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4x3(blockB.d[4], mat4x3(-2.0, 1.0, 1.0, -7.0, -9.0, -6.0, 4.0, 0.0, -3.0, -3.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat4x3(blockB.d[5], mat4x3(-8.0, -9.0, -7.0, -2.0, -6.0, 0.0, 5.0, 8.0, 5.0, 5.0, 3.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x2(8.0, 9.0, -5.0, 5.0, -4.0, 2.0, -1.0, 9.0));
	blockB.b = (mat4(-3.0, 5.0, -8.0, -2.0, 4.0, 1.0, -2.0, -8.0, -6.0, 9.0, 4.0, -5.0, 5.0, -1.0, 4.0, -7.0));
	blockB.c = (5.0);
	blockB.d[0] = (mat4x3(-6.0, 4.0, -3.0, 9.0, 0.0, -8.0, 6.0, -8.0, -7.0, -2.0, 5.0, 1.0));
	blockB.d[1] = (mat4x3(3.0, -3.0, -1.0, 1.0, -6.0, -5.0, -4.0, -2.0, 8.0, -7.0, 4.0, 0.0));
	blockB.d[2] = (mat4x3(7.0, 2.0, -4.0, 1.0, 6.0, -2.0, 5.0, 7.0, -9.0, -4.0, 7.0, -9.0));
	blockB.d[3] = (mat4x3(7.0, 7.0, -8.0, 5.0, -2.0, -3.0, -9.0, 7.0, -4.0, -6.0, 3.0, -7.0));
	blockB.d[4] = (mat4x3(-4.0, 2.0, -4.0, -3.0, 3.0, 2.0, 0.0, 8.0, 8.0, -2.0, -6.0, 7.0));
	blockB.d[5] = (mat4x3(1.0, 9.0, -1.0, -8.0, 1.0, 0.0, -2.0, -8.0, 7.0, -6.0, -5.0, -6.0));
}
#version 450
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
	i8vec2 mB;
	u8vec2 mC[2];
	mediump vec2 mD;
};
layout(std140, buffer_reference) buffer BlockB
{
	highp ivec3 a;
	sA b;
	lowp uvec4 c;
	bvec2 d;
	mediump vec3 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a), ivec3(-5, -2, 3)) && allOk;
	allOk = compare_mat4x2(blockB.b.mA, mat4x2(7.0, -6.0, 8.0, -6.0, -1.0, -6.0, 3.0, -7.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.b.mB), ivec2(9, 3)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB.b.mC[0]), uvec2(8u, 5u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB.b.mC[1]), uvec2(0u, 4u)) && allOk;
	allOk = compare_vec2((blockB.b.mD), vec2(-5.0, -4.0)) && allOk;
	allOk = compare_uvec4((blockB.c), uvec4(3u, 1u, 7u, 9u)) && allOk;
	allOk = compare_bvec2((blockB.d), bvec2(true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec3(6, -5, -1));
	blockB.b.mA = (mat4x2(-3.0, -1.0, -2.0, 7.0, -5.0, -5.0, -4.0, 1.0));
	blockB.b.mB = i8vec2(ivec2(4294967289, 1));
	blockB.b.mC[0] = u8vec2(uvec2(1u, 5u));
	blockB.b.mC[1] = u8vec2(uvec2(2u, 7u));
	blockB.b.mD = (vec2(6.0, 5.0));
	blockB.c = (uvec4(3u, 3u, 6u, 7u));
	blockB.d = (bvec2(false, false));
}
#version 450
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
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	mediump mat4 a;
	u8vec4 b[];
};
layout(std430, buffer_reference) buffer BlockC
{
	highp mat4x2 c;
	highp mat4x3 d;
	highp mat3x4 e;
	lowp mat3x2 f[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	bvec4 g;
	highp mat4x3 h;
	highp mat4x3 i;
};
layout(std140, row_major, buffer_reference) buffer BlockE
{
	sA j;
	mediump mat4 k;
	highp mat3x2 l[5];
	mediump vec2 m[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[2];
    BlockD blockD;
    BlockE blockE[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(blockB.b[0]), uvec4(7u, 5u, 9u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB.b[1]), uvec4(1u, 6u, 1u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB.b[2]), uvec4(0u, 0u, 7u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB.b[3]), uvec4(1u, 5u, 8u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB.b[4]), uvec4(3u, 9u, 6u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB.b[5]), uvec4(2u, 6u, 1u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB.b[6]), uvec4(6u, 3u, 1u, 4u)) && allOk;
	allOk = compare_mat4x2(blockC[0].c, mat4x2(6.0, 0.0, 1.0, -9.0, 2.0, -2.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat4x3(blockC[0].d, mat4x3(-4.0, 4.0, 0.0, 9.0, -5.0, 7.0, -4.0, 5.0, 7.0, -8.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat3x4(blockC[0].e, mat3x4(8.0, 7.0, -4.0, -7.0, 2.0, -6.0, -1.0, 5.0, 8.0, -9.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat3x2(blockC[0].f[0], mat3x2(-8.0, -9.0, 4.0, -8.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat3x2(blockC[0].f[1], mat3x2(-9.0, -7.0, 4.0, 3.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x2(blockC[1].c, mat4x2(5.0, 7.0, 6.0, 8.0, -4.0, -8.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat4x3(blockC[1].d, mat4x3(7.0, 5.0, -5.0, -1.0, 6.0, -1.0, 3.0, -4.0, -9.0, 4.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3x4(blockC[1].e, mat3x4(2.0, 5.0, 1.0, -9.0, -8.0, -9.0, -3.0, 3.0, -7.0, -6.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockC[1].f[0], mat3x2(-1.0, 0.0, -2.0, -4.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3x2(blockC[1].f[1], mat3x2(-7.0, -1.0, 4.0, -2.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3x2(blockC[1].f[2], mat3x2(8.0, 3.0, -8.0, 5.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockC[1].f[3], mat3x2(9.0, 1.0, 6.0, -5.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat3x2(blockC[1].f[4], mat3x2(-1.0, 8.0, -5.0, 8.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat3x2(blockC[1].f[5], mat3x2(8.0, -8.0, 2.0, 2.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(blockD.h, mat4x3(-3.0, 9.0, 7.0, 4.0, -3.0, -2.0, 3.0, 4.0, 6.0, 2.0, -9.0, 0.0)) && allOk;
	allOk = compare_bvec3((blockE[0].j.mA), bvec3(true, false, true)) && allOk;
	allOk = compare_mat3x2(blockE[0].l[0], mat3x2(1.0, 8.0, 9.0, 4.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].l[1], mat3x2(6.0, 7.0, 6.0, 9.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].l[2], mat3x2(1.0, -8.0, 6.0, 2.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].l[3], mat3x2(-3.0, 8.0, 0.0, 9.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].l[4], mat3x2(9.0, 2.0, 0.0, -8.0, -5.0, 4.0)) && allOk;
	allOk = compare_bvec3((blockE[1].j.mA), bvec3(false, false, false)) && allOk;
	allOk = compare_mat3x2(blockE[1].l[0], mat3x2(4.0, -5.0, -6.0, -4.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].l[1], mat3x2(3.0, -2.0, -1.0, -9.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].l[2], mat3x2(-5.0, 7.0, -1.0, 4.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].l[3], mat3x2(-8.0, 3.0, 8.0, 8.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].l[4], mat3x2(-1.0, -8.0, -9.0, -1.0, 8.0, -8.0)) && allOk;
	allOk = compare_bvec3((blockE[2].j.mA), bvec3(false, true, false)) && allOk;
	allOk = compare_mat3x2(blockE[2].l[0], mat3x2(-8.0, 7.0, 3.0, 2.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockE[2].l[1], mat3x2(-3.0, -9.0, -5.0, -5.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockE[2].l[2], mat3x2(7.0, 1.0, 8.0, 6.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockE[2].l[3], mat3x2(-7.0, 6.0, -9.0, -4.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(blockE[2].l[4], mat3x2(-4.0, 6.0, -6.0, -3.0, 5.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4(-7.0, -4.0, -4.0, 0.0, 3.0, -1.0, 3.0, -7.0, -9.0, 9.0, -7.0, -9.0, -7.0, -4.0, -4.0, -8.0));
	blockB.b[0] = u8vec4(uvec4(5u, 3u, 4u, 1u));
	blockB.b[1] = u8vec4(uvec4(8u, 5u, 4u, 0u));
	blockB.b[2] = u8vec4(uvec4(3u, 6u, 3u, 2u));
	blockB.b[3] = u8vec4(uvec4(6u, 2u, 9u, 2u));
	blockB.b[4] = u8vec4(uvec4(7u, 3u, 2u, 6u));
	blockB.b[5] = u8vec4(uvec4(9u, 9u, 6u, 4u));
	blockB.b[6] = u8vec4(uvec4(6u, 6u, 4u, 6u));
	blockC[0].c = (mat4x2(5.0, 5.0, 3.0, 8.0, 5.0, 5.0, 3.0, 6.0));
	blockC[0].f[0] = (mat3x2(0.0, 7.0, -7.0, 4.0, -4.0, -8.0));
	blockC[0].f[1] = (mat3x2(1.0, -6.0, 7.0, -7.0, 7.0, -2.0));
	blockC[1].c = (mat4x2(2.0, 2.0, 4.0, -9.0, 9.0, -2.0, -4.0, -3.0));
	blockC[1].f[0] = (mat3x2(-1.0, 0.0, 8.0, -9.0, -5.0, 5.0));
	blockC[1].f[1] = (mat3x2(1.0, -1.0, -9.0, -5.0, -1.0, 2.0));
	blockC[1].f[2] = (mat3x2(-4.0, -1.0, -8.0, -3.0, 3.0, 3.0));
	blockC[1].f[3] = (mat3x2(8.0, 2.0, -9.0, -2.0, -3.0, 4.0));
	blockC[1].f[4] = (mat3x2(-7.0, -6.0, 8.0, 5.0, 2.0, -1.0));
	blockC[1].f[5] = (mat3x2(0.0, 4.0, 9.0, -2.0, 0.0, 9.0));
	blockD.g = (bvec4(true, true, true, true));
	blockD.h = (mat4x3(-7.0, -1.0, -3.0, -4.0, 6.0, -8.0, 3.0, 1.0, 0.0, 4.0, 9.0, -7.0));
	blockD.i = (mat4x3(-9.0, 0.0, 4.0, 4.0, -4.0, 8.0, 3.0, -4.0, -1.0, 7.0, -6.0, -6.0));
	blockE[0].j.mA = (bvec3(false, true, false));
	blockE[0].k = (mat4(6.0, 5.0, -8.0, 8.0, -1.0, 8.0, 8.0, -6.0, -4.0, -9.0, -8.0, 9.0, -2.0, 9.0, 5.0, -3.0));
	blockE[0].l[0] = (mat3x2(-2.0, 7.0, -4.0, 6.0, 8.0, 3.0));
	blockE[0].l[1] = (mat3x2(4.0, 6.0, 0.0, 0.0, 9.0, 3.0));
	blockE[0].l[2] = (mat3x2(-6.0, -9.0, 0.0, -7.0, 3.0, -8.0));
	blockE[0].l[3] = (mat3x2(-9.0, -1.0, 7.0, -9.0, 0.0, -5.0));
	blockE[0].l[4] = (mat3x2(-1.0, -2.0, 7.0, 8.0, 3.0, -1.0));
	blockE[0].m[0] = (vec2(1.0, 5.0));
	blockE[0].m[1] = (vec2(8.0, 1.0));
	blockE[0].m[2] = (vec2(4.0, 8.0));
	blockE[0].m[3] = (vec2(0.0, 0.0));
	blockE[0].m[4] = (vec2(5.0, -3.0));
	blockE[1].j.mA = (bvec3(false, false, true));
	blockE[1].k = (mat4(-8.0, -5.0, 0.0, -1.0, 7.0, -8.0, -2.0, 4.0, -8.0, -3.0, -5.0, -2.0, -9.0, -5.0, -3.0, -5.0));
	blockE[1].l[0] = (mat3x2(0.0, 3.0, 8.0, 2.0, -8.0, -1.0));
	blockE[1].l[1] = (mat3x2(7.0, 4.0, 5.0, 2.0, 3.0, -5.0));
	blockE[1].l[2] = (mat3x2(-8.0, -7.0, -9.0, -1.0, 8.0, -2.0));
	blockE[1].l[3] = (mat3x2(-5.0, 0.0, 9.0, 8.0, -8.0, -6.0));
	blockE[1].l[4] = (mat3x2(-2.0, -5.0, 2.0, -8.0, 3.0, 8.0));
	blockE[1].m[0] = (vec2(-2.0, 5.0));
	blockE[1].m[1] = (vec2(-6.0, 7.0));
	blockE[1].m[2] = (vec2(2.0, 5.0));
	blockE[1].m[3] = (vec2(-5.0, -7.0));
	blockE[1].m[4] = (vec2(4.0, -3.0));
	blockE[1].m[5] = (vec2(-8.0, 0.0));
	blockE[1].m[6] = (vec2(1.0, -7.0));
	blockE[2].j.mA = (bvec3(true, false, false));
	blockE[2].k = (mat4(5.0, -3.0, -2.0, 7.0, 7.0, 5.0, 6.0, 8.0, -9.0, 7.0, 2.0, -8.0, -3.0, 9.0, 4.0, 3.0));
	blockE[2].l[0] = (mat3x2(-2.0, 0.0, -5.0, 5.0, -3.0, 9.0));
	blockE[2].l[1] = (mat3x2(9.0, 2.0, 3.0, -7.0, 6.0, 7.0));
	blockE[2].l[2] = (mat3x2(-3.0, 5.0, 1.0, 4.0, 8.0, -3.0));
	blockE[2].l[3] = (mat3x2(8.0, 3.0, 4.0, -8.0, -8.0, -8.0));
	blockE[2].l[4] = (mat3x2(-7.0, 0.0, 3.0, -6.0, 2.0, 7.0));
	blockE[2].m[0] = (vec2(2.0, 0.0));
	blockE[2].m[1] = (vec2(-3.0, 4.0));
	blockE[2].m[2] = (vec2(4.0, 8.0));
}
#version 450
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
	layout(offset = 16) lowp float b;
	layout(offset = 20) bool c[1];
	layout(offset = 24) mediump vec2 d[1];
	layout(offset = 32) int8_t e;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) highp uvec2 f;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) uint8_t g;
	layout(offset = 4) highp float h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.a), vec4(0.0, 3.0, 3.0, 2.0)) && allOk;
	allOk = compare_bool((blockB.c[0]), true) && allOk;
	allOk = compare_int8_t(int(blockB.e), 4294967289) && allOk;
	allOk = compare_uvec2((blockC.f), uvec2(1u, 6u)) && allOk;
	allOk = compare_uint8_t(uint(blockD.g), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec4(5.0, -5.0, 3.0, 9.0));
	blockB.b = (-5.0);
	blockB.c[0] = (true);
	blockB.d[0] = (vec2(-1.0, -9.0));
	blockB.e = int8_t(2);
	blockC.f = (uvec2(7u, 1u));
	blockD.g = uint8_t(7u);
	blockD.h = (8.0);
}
#version 450
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
	layout(offset = 0) mediump uvec3 a;
	layout(offset = 12) i8vec4 b;
	layout(offset = 16) lowp float c;
	layout(offset = 32) bvec4 d;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump ivec4 e;
	layout(offset = 16) i8vec2 f;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) bvec4 g;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC[1];
    BlockD blockD[3];
};

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

struct sA
{
	lowp ivec4 mA;
};
struct sB
{
	lowp uvec4 mA;
	mediump ivec2 mB;
};
struct sC
{
	lowp mat3x4 mA;
};
struct sD
{
	u8vec3 mA;
	uint8_t mB;
	highp ivec3 mC;
};
layout(scalar, column_major, buffer_reference) buffer BlockB
{
	lowp mat3 a;
	u8vec4 b[2];
	sA c;
	mediump mat3x4 d;
	lowp mat4 e[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	sB f;
	highp uint g;
	u8vec3 h[2];
	sC i[];
};
layout(scalar, buffer_reference) buffer BlockD
{
	sD j;
	mediump uvec3 k;
	lowp mat2 l;
	lowp ivec4 m[];
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
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(blockB.b[0]), uvec4(3u, 9u, 5u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB.b[1]), uvec4(3u, 9u, 0u, 2u)) && allOk;
	allOk = compare_ivec4((blockB.c.mA), ivec4(-4, 9, -3, 2)) && allOk;
	allOk = compare_mat4(blockB.e[0], mat4(8.0, -4.0, -8.0, -6.0, 5.0, 2.0, 9.0, 1.0, 5.0, 4.0, -2.0, 6.0, -4.0, 8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat4(blockB.e[1], mat4(1.0, -2.0, 5.0, -9.0, 2.0, -7.0, -4.0, 8.0, 9.0, 1.0, -2.0, -6.0, -5.0, -3.0, 8.0, 9.0)) && allOk;
	allOk = compare_uint((blockC.g), 8u) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.h[0]), uvec3(9u, 9u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.h[1]), uvec3(1u, 6u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD.j.mA), uvec3(4u, 4u, 7u)) && allOk;
	allOk = compare_uint8_t(uint(blockD.j.mB), 5u) && allOk;
	allOk = compare_ivec3((blockD.j.mC), ivec3(2, 8, 6)) && allOk;
	allOk = compare_ivec4((blockD.m[0]), ivec4(2, -7, 0, 2)) && allOk;
	allOk = compare_ivec4((blockD.m[1]), ivec4(-9, 0, -5, -2)) && allOk;
	allOk = compare_ivec4((blockD.m[2]), ivec4(-9, 1, 6, 3)) && allOk;
	allOk = compare_ivec4((blockD.m[3]), ivec4(7, 9, -1, -6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3(1.0, 8.0, 5.0, 5.0, 1.0, 5.0, 1.0, 3.0, -9.0));
	blockB.b[0] = u8vec4(uvec4(5u, 8u, 9u, 4u));
	blockB.b[1] = u8vec4(uvec4(9u, 3u, 9u, 1u));
	blockB.c.mA = (ivec4(9, -7, 6, 5));
	blockB.d = (mat3x4(3.0, 9.0, 1.0, -1.0, -8.0, -8.0, -2.0, 2.0, 8.0, -7.0, -9.0, -4.0));
	blockB.e[0] = (mat4(-1.0, -2.0, 4.0, 0.0, -2.0, -9.0, 1.0, 9.0, -1.0, -1.0, -2.0, -4.0, -2.0, -2.0, 4.0, 5.0));
	blockB.e[1] = (mat4(-6.0, -1.0, -7.0, -6.0, 9.0, 5.0, 4.0, -9.0, -2.0, -7.0, -9.0, -9.0, -5.0, -3.0, -8.0, -6.0));
	blockC.f.mA = (uvec4(3u, 8u, 7u, 6u));
	blockC.f.mB = (ivec2(2, 5));
	blockC.h[0] = u8vec3(uvec3(0u, 5u, 8u));
	blockC.h[1] = u8vec3(uvec3(1u, 5u, 7u));
	blockC.i[0].mA = (mat3x4(6.0, 0.0, -5.0, -8.0, -8.0, -4.0, 6.0, -1.0, 1.0, 9.0, -7.0, 8.0));
	blockC.i[1].mA = (mat3x4(1.0, -3.0, 6.0, 6.0, -9.0, 1.0, -1.0, -9.0, 7.0, -7.0, 4.0, 5.0));
	blockC.i[2].mA = (mat3x4(6.0, -6.0, 4.0, -5.0, 2.0, -8.0, -2.0, -6.0, 9.0, -1.0, 0.0, -7.0));
	blockD.k = (uvec3(8u, 2u, 3u));
	blockD.l = (mat2(-3.0, 4.0, -7.0, 4.0));
	blockD.m[0] = (ivec4(-4, 4, 9, 3));
	blockD.m[1] = (ivec4(0, 9, 6, -7));
	blockD.m[2] = (ivec4(-1, -1, -5, -4));
	blockD.m[3] = (ivec4(0, 9, 3, 1));
}
#version 450
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
	mediump ivec2 a;
	lowp uint b;
	highp ivec3 c;
	mediump ivec2 d;
	bvec4 e[][5];
};
layout(scalar, buffer_reference) buffer BlockC
{
	bool f;
	mediump float g;
	lowp mat2x3 h[5][2];
	lowp vec2 i;
	lowp int j;
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	highp float k;
	bvec3 l;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
    BlockD blockD[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB[0].a), ivec2(3, -6)) && allOk;
	allOk = compare_ivec3((blockB[0].c), ivec3(6, -6, -9)) && allOk;
	allOk = compare_ivec2((blockB[1].a), ivec2(3, -4)) && allOk;
	allOk = compare_ivec3((blockB[1].c), ivec3(-9, -7, 2)) && allOk;
	allOk = compare_float((blockC.g), -9.0) && allOk;
	allOk = compare_vec2((blockC.i), vec2(-9.0, 5.0)) && allOk;
	allOk = compare_int((blockC.j), -6) && allOk;
	allOk = compare_float((blockD[0].k), -8.0) && allOk;
	allOk = compare_float((blockD[1].k), -3.0) && allOk;
	allOk = compare_float((blockD[2].k), -9.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (ivec2(-5, 8));
	blockB[0].b = (2u);
	blockB[0].c = (ivec3(-3, -3, 1));
	blockB[0].e[0][0] = (bvec4(false, true, true, false));
	blockB[0].e[0][1] = (bvec4(false, false, true, true));
	blockB[0].e[0][2] = (bvec4(false, false, false, false));
	blockB[0].e[0][3] = (bvec4(false, true, false, true));
	blockB[0].e[0][4] = (bvec4(false, false, false, true));
	blockB[0].e[1][0] = (bvec4(true, true, false, true));
	blockB[0].e[1][1] = (bvec4(false, true, false, true));
	blockB[0].e[1][2] = (bvec4(true, true, true, true));
	blockB[0].e[1][3] = (bvec4(false, false, true, false));
	blockB[0].e[1][4] = (bvec4(false, true, true, true));
	blockB[0].e[2][0] = (bvec4(false, true, true, false));
	blockB[0].e[2][1] = (bvec4(false, false, false, true));
	blockB[0].e[2][2] = (bvec4(true, true, false, true));
	blockB[0].e[2][3] = (bvec4(false, true, false, false));
	blockB[0].e[2][4] = (bvec4(true, true, false, true));
	blockB[0].e[3][0] = (bvec4(true, true, false, false));
	blockB[0].e[3][1] = (bvec4(true, true, true, false));
	blockB[0].e[3][2] = (bvec4(false, true, false, false));
	blockB[0].e[3][3] = (bvec4(false, false, true, false));
	blockB[0].e[3][4] = (bvec4(true, false, false, false));
	blockB[0].e[4][0] = (bvec4(true, false, true, true));
	blockB[0].e[4][1] = (bvec4(false, true, true, true));
	blockB[0].e[4][2] = (bvec4(false, false, true, false));
	blockB[0].e[4][3] = (bvec4(false, true, true, false));
	blockB[0].e[4][4] = (bvec4(true, true, true, true));
	blockB[0].e[5][0] = (bvec4(true, false, false, true));
	blockB[0].e[5][1] = (bvec4(false, false, true, true));
	blockB[0].e[5][2] = (bvec4(true, true, true, true));
	blockB[0].e[5][3] = (bvec4(false, false, false, true));
	blockB[0].e[5][4] = (bvec4(true, true, true, true));
	blockB[0].e[6][0] = (bvec4(false, false, false, true));
	blockB[0].e[6][1] = (bvec4(true, false, false, true));
	blockB[0].e[6][2] = (bvec4(true, false, false, true));
	blockB[0].e[6][3] = (bvec4(true, true, false, true));
	blockB[0].e[6][4] = (bvec4(true, true, false, true));
	blockB[0].e[7][0] = (bvec4(false, false, false, false));
	blockB[0].e[7][1] = (bvec4(true, true, false, false));
	blockB[0].e[7][2] = (bvec4(false, true, true, false));
	blockB[0].e[7][3] = (bvec4(true, false, true, true));
	blockB[0].e[7][4] = (bvec4(false, false, false, false));
	blockB[1].a = (ivec2(0, 2));
	blockB[1].b = (1u);
	blockB[1].c = (ivec3(3, -7, -9));
	blockB[1].e[0][0] = (bvec4(false, true, false, false));
	blockB[1].e[0][1] = (bvec4(false, false, true, true));
	blockB[1].e[0][2] = (bvec4(false, true, false, false));
	blockB[1].e[0][3] = (bvec4(true, false, false, false));
	blockB[1].e[0][4] = (bvec4(false, false, false, false));
	blockC.g = (5.0);
	blockC.j = (4);
	blockD[0].k = (-3.0);
	blockD[1].k = (8.0);
	blockD[2].k = (-7.0);
}
#version 450
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
	bvec2 a;
	u8vec3 b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

}
