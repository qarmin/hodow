#version 450
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
	u16vec3 var;
};

bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(var), uvec3(1u, 0u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = u16vec3(uvec3(1u, 2u, 6u));
}
#version 450
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

	var = (mat2(0.0, -6.0, -1.0, 7.0));
}
#version 450
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
	mediump mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 3.0) && allOk;
	allOk = compare_float(var[0][1], 7.0) && allOk;
	allOk = compare_float(var[1][0], 3.0) && allOk;
	allOk = compare_float(var[1][1], -8.0) && allOk;
	allOk = compare_vec2(var[0], vec2(3.0, 7.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec2(1.0, 2.0));
	var[1] = (vec2(-8.0, -5.0));
}
#version 450
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

	var = (mat2x4(2.0, 5.0, -9.0, 2.0, -2.0, 3.0, 7.0, -3.0));
}
#version 450
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

	var[0] = (vec4(8.0, -9.0, 0.0, -6.0));
	var[1] = (vec4(7.0, 8.0, 6.0, -6.0));
}
#version 450
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

layout(std430, binding = 1) buffer Block
{
	mediump mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var, mat4x3(-1.0, -9.0, -8.0, 7.0, 8.0, 8.0, -3.0, 3.0, -4.0, -1.0, 5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x3(4.0, -5.0, 2.0, 8.0, -5.0, -9.0, -5.0, 9.0, 3.0, -6.0, 0.0, 3.0));
}
#version 450
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

	var = (mat4x3(3.0, 8.0, 0.0, 6.0, 1.0, 4.0, -1.0, 4.0, 5.0, 9.0, 6.0, 5.0));
}
#version 450
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
	mediump mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 9.0) && allOk;
	allOk = compare_float(var[0][0], 0.0) && allOk;
	allOk = compare_float(var[0][1], -3.0) && allOk;
	allOk = compare_float(var[0][2], -8.0) && allOk;
	allOk = compare_float(var[1][0], 3.0) && allOk;
	allOk = compare_float(var[1][1], -2.0) && allOk;
	allOk = compare_float(var[1][2], 3.0) && allOk;
	allOk = compare_float(var[2][0], 4.0) && allOk;
	allOk = compare_float(var[2][1], 1.0) && allOk;
	allOk = compare_float(var[2][2], 2.0) && allOk;
	allOk = compare_vec3(var[0], vec3(0.0, -3.0, -8.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(3.0, -2.0, 3.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(4.0, 1.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (7.0);
	var[0] = (vec3(-5.0, -9.0, 6.0));
	var[1] = (vec3(6.0, -2.0, 6.0));
	var[2] = (vec3(0.0, -8.0, 3.0));
}
#version 450
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
	mediump mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 0.0) && allOk;
	allOk = compare_float(var[0][0], -1.0) && allOk;
	allOk = compare_float(var[0][1], 7.0) && allOk;
	allOk = compare_float(var[0][2], 9.0) && allOk;
	allOk = compare_float(var[0][3], -3.0) && allOk;
	allOk = compare_float(var[1][0], -5.0) && allOk;
	allOk = compare_float(var[1][1], 7.0) && allOk;
	allOk = compare_float(var[1][2], -1.0) && allOk;
	allOk = compare_float(var[1][3], 4.0) && allOk;
	allOk = compare_float(var[2][0], -2.0) && allOk;
	allOk = compare_float(var[2][1], 9.0) && allOk;
	allOk = compare_float(var[2][2], 9.0) && allOk;
	allOk = compare_float(var[2][3], 7.0) && allOk;
	allOk = compare_float(var[3][0], -5.0) && allOk;
	allOk = compare_float(var[3][1], 0.0) && allOk;
	allOk = compare_float(var[3][2], -6.0) && allOk;
	allOk = compare_float(var[3][3], -3.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-1.0, 7.0, 9.0, -3.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-5.0, 7.0, -1.0, 4.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-2.0, 9.0, 9.0, 7.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(-5.0, 0.0, -6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (1.0);
	var = (mat4(-3.0, -8.0, 1.0, 3.0, -4.0, -4.0, -4.0, -6.0, -6.0, 9.0, 1.0, 1.0, 3.0, 2.0, -6.0, -1.0));
}
#version 450
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
	lowp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 2.0) && allOk;
	allOk = compare_mat3x2(var, mat3x2(-9.0, -3.0, 3.0, -5.0, -2.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-9.0);
	var = (mat3x2(0.0, 7.0, 6.0, 0.0, 3.0, 6.0));
}
#version 450
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
	allOk = compare_float((padding), 2.0) && allOk;
	allOk = compare_float(var[0][0], -3.0) && allOk;
	allOk = compare_float(var[0][1], -3.0) && allOk;
	allOk = compare_float(var[1][0], -5.0) && allOk;
	allOk = compare_float(var[1][1], -9.0) && allOk;
	allOk = compare_float(var[2][0], 0.0) && allOk;
	allOk = compare_float(var[2][1], -8.0) && allOk;
	allOk = compare_float(var[3][0], -5.0) && allOk;
	allOk = compare_float(var[3][1], -9.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-3.0, -3.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-5.0, -9.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(0.0, -8.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(-5.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (6.0);
	var[0] = (vec2(-4.0, -2.0));
	var[1] = (vec2(-1.0, -7.0));
	var[2] = (vec2(8.0, -4.0));
	var[3] = (vec2(6.0, -1.0));
}
#version 450
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
	u16vec3 var;
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(padding), 1u) && allOk;
	allOk = compare_u16vec3(uvec3(var), uvec3(0u, 5u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = uint16_t(1u);
	var = u16vec3(uvec3(2u, 6u, 8u));
}
#version 450
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
	highp uvec3 var[3];
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((var[0]), uvec3(9u, 6u, 4u)) && allOk;
	allOk = compare_uvec3((var[1]), uvec3(7u, 2u, 7u)) && allOk;
	allOk = compare_uvec3((var[2]), uvec3(5u, 0u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (uvec3(3u, 5u, 6u));
	var[1] = (uvec3(5u, 4u, 5u));
	var[2] = (uvec3(4u, 9u, 4u));
}
#version 450
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
	highp mat2 var[3];
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
    if (allOk)
        ac_numPassed++;

	var[0] = (mat2(-2.0, -8.0, -7.0, 9.0));
	var[1] = (mat2(2.0, 2.0, -4.0, -5.0));
	var[2] = (mat2(-1.0, -4.0, 0.0, -1.0));
}
#version 450
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
	highp mat3 var[3];
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
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec3(8.0, 3.0, 9.0));
	var[0][1] = (vec3(6.0, 2.0, -9.0));
	var[0][2] = (vec3(-8.0, 5.0, 2.0));
	var[1][0] = (vec3(3.0, -3.0, -4.0));
	var[1][1] = (vec3(2.0, -9.0, -5.0));
	var[1][2] = (vec3(5.0, 8.0, 8.0));
	var[2][0] = (vec3(-5.0, -3.0, -3.0));
	var[2][1] = (vec3(3.0, -5.0, -4.0));
	var[2][2] = (vec3(-7.0, 5.0, 3.0));
}
#version 450
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

	var[0][0] = (vec3(-3.0, -6.0, 6.0));
	var[0][1] = (vec3(1.0, -4.0, -3.0));
	var[0][2] = (vec3(-3.0, 3.0, -2.0));
	var[0][3] = (vec3(-7.0, 1.0, -5.0));
	var[1][0] = (vec3(-1.0, -5.0, 7.0));
	var[1][1] = (vec3(1.0, -2.0, -4.0));
	var[1][2] = (vec3(-4.0, -6.0, 5.0));
	var[1][3] = (vec3(-2.0, 6.0, -9.0));
	var[2][0] = (vec3(5.0, -5.0, 7.0));
	var[2][1] = (vec3(-4.0, 8.0, -3.0));
	var[2][2] = (vec3(-2.0, 0.0, 8.0));
	var[2][3] = (vec3(-2.0, 6.0, -3.0));
}
#version 450
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
	highp mat2x4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat2x4(var[0], mat2x4(-1.0, -3.0, -6.0, -2.0, 4.0, -8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(9.0, -2.0, -3.0, 3.0, 3.0, 3.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(2.0, -4.0, 1.0, -2.0, -8.0, -7.0, -9.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (4.0);
	var[0][0] = (vec4(-6.0, -9.0, -3.0, 5.0));
	var[0][1] = (vec4(1.0, -7.0, 1.0, -7.0));
	var[1][0] = (vec4(-4.0, 1.0, 9.0, -1.0));
	var[1][1] = (vec4(-2.0, 2.0, 4.0, -1.0));
	var[2][0] = (vec4(-9.0, -6.0, 6.0, -7.0));
	var[2][1] = (vec4(5.0, 8.0, 4.0, -8.0));
}
#version 450
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
	u8vec4 var[3];
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(padding), 3u) && allOk;
	allOk = compare_u8vec4(uvec4(var[0]), uvec4(4u, 6u, 8u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[1]), uvec4(5u, 7u, 0u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[2]), uvec4(4u, 6u, 1u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = uint8_t(9u);
	var[0] = u8vec4(uvec4(5u, 9u, 4u, 6u));
	var[1] = u8vec4(uvec4(8u, 7u, 3u, 6u));
	var[2] = u8vec4(uvec4(7u, 1u, 9u, 8u));
}
#version 450
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

	var[0][0] = (vec4(-9.0, 0.0, -1.0, -4.0));
	var[0][1] = (vec4(-9.0, -4.0, -9.0, -5.0));
	var[0][2] = (vec4(-2.0, 9.0, 0.0, -8.0));
	var[0][3] = (vec4(-6.0, -3.0, -8.0, 3.0));
	var[1][0] = (vec4(4.0, 9.0, 4.0, -3.0));
	var[1][1] = (vec4(7.0, -9.0, 6.0, 5.0));
	var[1][2] = (vec4(6.0, -1.0, -3.0, -3.0));
	var[1][3] = (vec4(-9.0, 3.0, -9.0, 0.0));
	var[2][0] = (vec4(1.0, -4.0, -6.0, 5.0));
	var[2][1] = (vec4(2.0, 1.0, 9.0, -4.0));
	var[2][2] = (vec4(-7.0, 7.0, 0.0, 7.0));
	var[2][3] = (vec4(9.0, 9.0, -5.0, -7.0));
	var[3][0] = (vec4(-9.0, 5.0, 8.0, 6.0));
	var[3][1] = (vec4(4.0, 6.0, -1.0, -7.0));
	var[3][2] = (vec4(7.0, 8.0, 5.0, -1.0));
	var[3][3] = (vec4(8.0, 2.0, -8.0, 0.0));
	var[4][0] = (vec4(-9.0, -1.0, -5.0, 7.0));
	var[4][1] = (vec4(3.0, 1.0, 2.0, 2.0));
	var[4][2] = (vec4(-3.0, -7.0, 1.0, 0.0));
	var[4][3] = (vec4(9.0, 5.0, -2.0, 6.0));
	var[5][0] = (vec4(-9.0, 1.0, 2.0, -3.0));
	var[5][1] = (vec4(-2.0, -2.0, -8.0, -4.0));
	var[5][2] = (vec4(7.0, -4.0, -1.0, 2.0));
	var[5][3] = (vec4(7.0, 7.0, 2.0, 8.0));
	var[6][0] = (vec4(-5.0, 9.0, 9.0, 4.0));
	var[6][1] = (vec4(6.0, -2.0, -1.0, -2.0));
	var[6][2] = (vec4(0.0, 5.0, -4.0, 5.0));
	var[6][3] = (vec4(8.0, -8.0, 9.0, -3.0));
	var[7][0] = (vec4(4.0, -8.0, -1.0, 0.0));
	var[7][1] = (vec4(-3.0, -4.0, -7.0, 1.0));
	var[7][2] = (vec4(4.0, -2.0, 1.0, -8.0));
	var[7][3] = (vec4(-8.0, 5.0, 4.0, 7.0));
	var[8][0] = (vec4(7.0, -2.0, -6.0, 9.0));
	var[8][1] = (vec4(-7.0, -5.0, 2.0, 2.0));
	var[8][2] = (vec4(4.0, 8.0, 4.0, -9.0));
	var[8][3] = (vec4(0.0, -9.0, 0.0, 0.0));
	var[9][0] = (vec4(9.0, -1.0, -1.0, -3.0));
	var[9][1] = (vec4(-9.0, -6.0, -8.0, 4.0));
	var[9][2] = (vec4(-6.0, 9.0, -8.0, 3.0));
	var[9][3] = (vec4(0.0, 1.0, -1.0, -7.0));
	var[10][0] = (vec4(-9.0, -4.0, 4.0, 6.0));
	var[10][1] = (vec4(4.0, 9.0, 4.0, -4.0));
	var[10][2] = (vec4(3.0, -1.0, 2.0, 8.0));
	var[10][3] = (vec4(-3.0, -6.0, -4.0, 0.0));
	var[11][0] = (vec4(2.0, -1.0, 1.0, -1.0));
	var[11][1] = (vec4(8.0, 5.0, 3.0, 0.0));
	var[11][2] = (vec4(-2.0, 0.0, 7.0, -5.0));
	var[11][3] = (vec4(6.0, 0.0, 6.0, -6.0));
	var[12][0] = (vec4(-1.0, -6.0, -8.0, -9.0));
	var[12][1] = (vec4(0.0, 3.0, 6.0, -1.0));
	var[12][2] = (vec4(4.0, 6.0, 8.0, 1.0));
	var[12][3] = (vec4(9.0, -4.0, 7.0, 7.0));
	var[13][0] = (vec4(2.0, -1.0, -8.0, 9.0));
	var[13][1] = (vec4(-1.0, 7.0, -4.0, 2.0));
	var[13][2] = (vec4(9.0, 2.0, -2.0, -1.0));
	var[13][3] = (vec4(7.0, 3.0, -6.0, 0.0));
	var[14][0] = (vec4(-7.0, -8.0, -7.0, 8.0));
	var[14][1] = (vec4(5.0, 7.0, -3.0, -2.0));
	var[14][2] = (vec4(9.0, -5.0, -2.0, -2.0));
	var[14][3] = (vec4(2.0, 4.0, -1.0, 9.0));
	var[15][0] = (vec4(3.0, 3.0, 4.0, -8.0));
	var[15][1] = (vec4(-3.0, -9.0, 9.0, -7.0));
	var[15][2] = (vec4(-7.0, 9.0, -4.0, 0.0));
	var[15][3] = (vec4(-4.0, -3.0, 0.0, 6.0));
	var[16][0] = (vec4(-5.0, -7.0, 3.0, -9.0));
	var[16][1] = (vec4(4.0, 5.0, 0.0, -6.0));
	var[16][2] = (vec4(7.0, 4.0, 1.0, 9.0));
	var[16][3] = (vec4(-8.0, 8.0, 7.0, 4.0));
	var[17][0] = (vec4(-1.0, 5.0, 9.0, -2.0));
	var[17][1] = (vec4(-5.0, -8.0, 2.0, -5.0));
	var[17][2] = (vec4(3.0, -8.0, -1.0, -5.0));
	var[17][3] = (vec4(-6.0, -2.0, 3.0, 0.0));
	var[18][0] = (vec4(1.0, -3.0, -1.0, 9.0));
	var[18][1] = (vec4(-4.0, -5.0, 6.0, 9.0));
	var[18][2] = (vec4(-5.0, -7.0, 1.0, 2.0));
	var[18][3] = (vec4(-7.0, 2.0, -8.0, 9.0));
}
#version 450
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
	highp mat3x2 var[];
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
	allOk = compare_mat3x2(var[3], mat3x2(1.0, 1.0, -3.0, -8.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[4], mat3x2(2.0, 8.0, 7.0, 7.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[5], mat3x2(-4.0, -7.0, 1.0, -1.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[6], mat3x2(8.0, -8.0, -7.0, 7.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[7], mat3x2(3.0, 9.0, -2.0, 2.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[8], mat3x2(-3.0, 9.0, 6.0, 2.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[9], mat3x2(7.0, 1.0, 1.0, 8.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[10], mat3x2(2.0, 7.0, -2.0, -4.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[11], mat3x2(-8.0, -1.0, -7.0, 9.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[12], mat3x2(-7.0, 3.0, -2.0, 8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[13], mat3x2(0.0, 9.0, -3.0, 8.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[14], mat3x2(8.0, -3.0, 6.0, 0.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[15], mat3x2(6.0, -8.0, 1.0, -6.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[16], mat3x2(8.0, 9.0, 4.0, 6.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[17], mat3x2(1.0, -7.0, 6.0, 0.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[18], mat3x2(-9.0, 9.0, 5.0, -2.0, -4.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3x2(-2.0, -2.0, -8.0, 0.0, -9.0, 9.0));
	var[1] = (mat3x2(0.0, 1.0, -3.0, -6.0, -5.0, -7.0));
	var[2] = (mat3x2(5.0, -4.0, 8.0, -1.0, -8.0, 1.0));
	var[3] = (mat3x2(2.0, 1.0, -5.0, 0.0, -3.0, 1.0));
	var[4] = (mat3x2(-4.0, 4.0, 5.0, -5.0, -6.0, 3.0));
	var[5] = (mat3x2(1.0, -2.0, 3.0, -8.0, -6.0, 2.0));
	var[6] = (mat3x2(-5.0, -4.0, -8.0, 9.0, -9.0, -8.0));
	var[7] = (mat3x2(8.0, -4.0, 1.0, -1.0, 7.0, 0.0));
	var[8] = (mat3x2(1.0, -3.0, 6.0, -4.0, -6.0, -5.0));
	var[9] = (mat3x2(-6.0, -4.0, 6.0, 4.0, 2.0, -8.0));
	var[10] = (mat3x2(2.0, 1.0, -3.0, -3.0, -5.0, -1.0));
	var[11] = (mat3x2(6.0, 9.0, 9.0, 9.0, -4.0, 8.0));
	var[12] = (mat3x2(-7.0, -7.0, -1.0, 1.0, -5.0, 2.0));
	var[13] = (mat3x2(5.0, 5.0, 3.0, -9.0, 7.0, -4.0));
	var[14] = (mat3x2(-1.0, -7.0, -6.0, -4.0, -4.0, 8.0));
	var[15] = (mat3x2(3.0, -5.0, 8.0, 6.0, 0.0, -2.0));
	var[16] = (mat3x2(9.0, -9.0, -7.0, -9.0, -9.0, 4.0));
	var[17] = (mat3x2(5.0, 9.0, 6.0, -1.0, 0.0, -2.0));
	var[18] = (mat3x2(-2.0, -4.0, 7.0, -2.0, 0.0, 0.0));
}
#version 450
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
	highp mat4x2 var[];
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
	allOk = compare_mat4x2(var[3], mat4x2(6.0, -2.0, -9.0, 5.0, -5.0, -6.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[4], mat4x2(5.0, -3.0, 5.0, 6.0, -4.0, -8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[5], mat4x2(-5.0, 4.0, -9.0, 6.0, 8.0, -3.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[6], mat4x2(9.0, 5.0, 0.0, -5.0, 6.0, -8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[7], mat4x2(2.0, 6.0, -5.0, 2.0, -8.0, -2.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[8], mat4x2(6.0, -1.0, 6.0, -3.0, 4.0, 0.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[9], mat4x2(-5.0, 8.0, 8.0, -7.0, 4.0, 6.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[10], mat4x2(-9.0, -8.0, 9.0, -2.0, -7.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[11], mat4x2(-5.0, 0.0, 3.0, 9.0, -8.0, -1.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[12], mat4x2(-2.0, -6.0, 4.0, 4.0, 5.0, -9.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[13], mat4x2(-3.0, 4.0, 3.0, -2.0, -5.0, 0.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[14], mat4x2(-3.0, 4.0, -5.0, -8.0, 5.0, -3.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[15], mat4x2(3.0, 4.0, -7.0, 4.0, -9.0, 4.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[16], mat4x2(-7.0, 4.0, -9.0, -9.0, -6.0, 2.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[17], mat4x2(-6.0, 6.0, -7.0, -6.0, -7.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[18], mat4x2(1.0, -7.0, -5.0, 9.0, -9.0, -1.0, 6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4x2(8.0, -5.0, 3.0, 0.0, -9.0, 4.0, -5.0, 3.0));
	var[1] = (mat4x2(6.0, 3.0, 6.0, -6.0, 0.0, -3.0, -2.0, -4.0));
	var[2] = (mat4x2(5.0, 4.0, 1.0, 0.0, 7.0, -9.0, -4.0, 5.0));
	var[3] = (mat4x2(6.0, 1.0, 0.0, 3.0, 2.0, -5.0, -4.0, 5.0));
	var[4] = (mat4x2(5.0, -4.0, -7.0, -8.0, 9.0, -4.0, 5.0, 5.0));
	var[5] = (mat4x2(-1.0, 6.0, -6.0, 5.0, 4.0, -3.0, 1.0, -4.0));
	var[6] = (mat4x2(1.0, -6.0, 2.0, 4.0, 7.0, 1.0, 9.0, 5.0));
	var[7] = (mat4x2(8.0, -7.0, 6.0, -7.0, -4.0, 5.0, 3.0, -2.0));
	var[8] = (mat4x2(-2.0, -5.0, -1.0, 1.0, -8.0, 4.0, 9.0, 2.0));
	var[9] = (mat4x2(-5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 1.0, 1.0));
	var[10] = (mat4x2(1.0, -9.0, -1.0, 6.0, -9.0, -7.0, -8.0, 8.0));
	var[11] = (mat4x2(-2.0, 7.0, 8.0, -9.0, 4.0, -3.0, 0.0, -7.0));
	var[12] = (mat4x2(4.0, 9.0, -8.0, 5.0, 3.0, 3.0, -4.0, 8.0));
	var[13] = (mat4x2(-7.0, 2.0, 2.0, -4.0, 6.0, -1.0, 1.0, 1.0));
	var[14] = (mat4x2(-9.0, 7.0, 9.0, -1.0, 3.0, -9.0, 2.0, -2.0));
	var[15] = (mat4x2(4.0, 1.0, 2.0, 3.0, 5.0, -3.0, -8.0, -1.0));
	var[16] = (mat4x2(2.0, 6.0, -3.0, 8.0, 3.0, -4.0, 8.0, 5.0));
	var[17] = (mat4x2(-4.0, 6.0, 7.0, -3.0, 1.0, 9.0, 7.0, 4.0));
	var[18] = (mat4x2(8.0, -7.0, 4.0, 5.0, -8.0, -6.0, -7.0, 1.0));
}
#version 450
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

	var[0] = int8_t(4294967290);
	var[1] = int8_t(4294967294);
	var[2] = int8_t(3);
	var[3] = int8_t(4294967288);
	var[4] = int8_t(1);
	var[5] = int8_t(2);
	var[6] = int8_t(4294967288);
	var[7] = int8_t(4294967294);
	var[8] = int8_t(7);
	var[9] = int8_t(9);
	var[10] = int8_t(0);
	var[11] = int8_t(4294967292);
	var[12] = int8_t(0);
	var[13] = int8_t(4294967289);
	var[14] = int8_t(1);
	var[15] = int8_t(7);
	var[16] = int8_t(4294967287);
	var[17] = int8_t(4294967289);
	var[18] = int8_t(6);
}
#version 450
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

layout(scalar, binding = 1) buffer Block
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

	var[0] = (mat2(1.0, 2.0, 6.0, -6.0));
	var[1] = (mat2(2.0, 4.0, 4.0, 7.0));
	var[2] = (mat2(0.0, 8.0, 0.0, -1.0));
	var[3] = (mat2(8.0, -4.0, -5.0, 7.0));
	var[4] = (mat2(-3.0, -1.0, 0.0, 6.0));
	var[5] = (mat2(-6.0, 7.0, 4.0, -7.0));
	var[6] = (mat2(1.0, -8.0, -9.0, -7.0));
	var[7] = (mat2(1.0, -2.0, -6.0, -8.0));
	var[8] = (mat2(-6.0, -6.0, 2.0, -9.0));
	var[9] = (mat2(9.0, 0.0, -3.0, -7.0));
	var[10] = (mat2(8.0, 8.0, 7.0, -3.0));
	var[11] = (mat2(7.0, 2.0, -8.0, -7.0));
	var[12] = (mat2(5.0, 1.0, -7.0, -2.0));
	var[13] = (mat2(-8.0, -9.0, 4.0, -4.0));
	var[14] = (mat2(-7.0, -9.0, -5.0, 3.0));
	var[15] = (mat2(-1.0, -1.0, -6.0, -3.0));
	var[16] = (mat2(-9.0, -4.0, -8.0, -1.0));
	var[17] = (mat2(-8.0, 1.0, -2.0, 9.0));
	var[18] = (mat2(9.0, 4.0, -3.0, -3.0));
}
#version 450
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
	highp mat4x2 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0], mat4x2(-4.0, 6.0, 0.0, -5.0, 0.0, -1.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(-6.0, -1.0, 4.0, 0.0, 2.0, -3.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(-8.0, -1.0, 5.0, 4.0, 9.0, -2.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[3], mat4x2(-5.0, -4.0, 3.0, 6.0, 4.0, 3.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[4], mat4x2(-1.0, -1.0, 3.0, -6.0, 6.0, 2.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[5], mat4x2(2.0, -2.0, -4.0, 7.0, -1.0, -9.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[6], mat4x2(-5.0, 5.0, 5.0, 7.0, 5.0, 2.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[7], mat4x2(9.0, -6.0, 5.0, -9.0, 6.0, 0.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[8], mat4x2(-8.0, 7.0, -6.0, -1.0, -9.0, -7.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[9], mat4x2(5.0, 9.0, 3.0, 7.0, 1.0, -3.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[10], mat4x2(4.0, 5.0, 5.0, 6.0, 2.0, 0.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[11], mat4x2(5.0, -2.0, 4.0, 7.0, -2.0, 4.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[12], mat4x2(8.0, -5.0, -3.0, -5.0, 3.0, -9.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[13], mat4x2(-3.0, 9.0, 0.0, 7.0, 9.0, -6.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[14], mat4x2(-9.0, 3.0, -7.0, -8.0, 7.0, -1.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[15], mat4x2(-7.0, 0.0, -1.0, -5.0, 7.0, -7.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[16], mat4x2(-2.0, 4.0, 6.0, -4.0, 1.0, 5.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[17], mat4x2(9.0, 0.0, 1.0, -9.0, -5.0, 0.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[18], mat4x2(6.0, 1.0, -3.0, -1.0, -3.0, -9.0, -7.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4x2(1.0, 8.0, -9.0, 4.0, 1.0, -5.0, 2.0, -5.0));
	var[1] = (mat4x2(8.0, -8.0, 8.0, 3.0, 2.0, -6.0, 3.0, 8.0));
	var[2] = (mat4x2(8.0, 9.0, -3.0, -9.0, -2.0, 6.0, -1.0, 6.0));
	var[3] = (mat4x2(-5.0, -9.0, -1.0, -9.0, 0.0, -4.0, 2.0, -7.0));
	var[4] = (mat4x2(-3.0, -5.0, 1.0, -5.0, -1.0, 7.0, 4.0, 4.0));
	var[5] = (mat4x2(-5.0, 2.0, -4.0, -3.0, 0.0, 4.0, -7.0, 5.0));
	var[6] = (mat4x2(1.0, -9.0, 0.0, -4.0, 2.0, 9.0, -5.0, -3.0));
	var[7] = (mat4x2(6.0, -4.0, -9.0, 5.0, -5.0, -6.0, 8.0, -5.0));
	var[8] = (mat4x2(-4.0, -5.0, 6.0, 9.0, -3.0, -4.0, 3.0, -7.0));
	var[9] = (mat4x2(-8.0, 8.0, -4.0, -6.0, 0.0, -3.0, -6.0, -4.0));
	var[10] = (mat4x2(5.0, 4.0, 5.0, 7.0, 2.0, -7.0, 8.0, -3.0));
	var[11] = (mat4x2(8.0, 7.0, 0.0, -5.0, 4.0, 5.0, -6.0, -8.0));
	var[12] = (mat4x2(-7.0, 4.0, -8.0, -6.0, -3.0, -4.0, 8.0, -4.0));
	var[13] = (mat4x2(6.0, -9.0, -7.0, -3.0, -9.0, -6.0, -3.0, -8.0));
	var[14] = (mat4x2(8.0, -4.0, -8.0, 4.0, 0.0, 4.0, -3.0, 8.0));
	var[15] = (mat4x2(0.0, 7.0, -2.0, -3.0, -5.0, 6.0, -2.0, 7.0));
	var[16] = (mat4x2(4.0, -1.0, 6.0, -2.0, 0.0, 7.0, 0.0, 2.0));
	var[17] = (mat4x2(-7.0, -7.0, -6.0, 8.0, -7.0, -4.0, 9.0, 9.0));
	var[18] = (mat4x2(4.0, -8.0, -6.0, -3.0, 8.0, -1.0, -5.0, 5.0));
}
#version 450
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
	highp mat4x2 var[];
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
	allOk = compare_mat4x2(var[3], mat4x2(6.0, -2.0, -9.0, 5.0, -5.0, -6.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[4], mat4x2(5.0, -3.0, 5.0, 6.0, -4.0, -8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[5], mat4x2(-5.0, 4.0, -9.0, 6.0, 8.0, -3.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[6], mat4x2(9.0, 5.0, 0.0, -5.0, 6.0, -8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[7], mat4x2(2.0, 6.0, -5.0, 2.0, -8.0, -2.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[8], mat4x2(6.0, -1.0, 6.0, -3.0, 4.0, 0.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[9], mat4x2(-5.0, 8.0, 8.0, -7.0, 4.0, 6.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[10], mat4x2(-9.0, -8.0, 9.0, -2.0, -7.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[11], mat4x2(-5.0, 0.0, 3.0, 9.0, -8.0, -1.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[12], mat4x2(-2.0, -6.0, 4.0, 4.0, 5.0, -9.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[13], mat4x2(-3.0, 4.0, 3.0, -2.0, -5.0, 0.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[14], mat4x2(-3.0, 4.0, -5.0, -8.0, 5.0, -3.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[15], mat4x2(3.0, 4.0, -7.0, 4.0, -9.0, 4.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[16], mat4x2(-7.0, 4.0, -9.0, -9.0, -6.0, 2.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[17], mat4x2(-6.0, 6.0, -7.0, -6.0, -7.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[18], mat4x2(1.0, -7.0, -5.0, 9.0, -9.0, -1.0, 6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4x2(8.0, -5.0, 3.0, 0.0, -9.0, 4.0, -5.0, 3.0));
	var[1] = (mat4x2(6.0, 3.0, 6.0, -6.0, 0.0, -3.0, -2.0, -4.0));
	var[2] = (mat4x2(5.0, 4.0, 1.0, 0.0, 7.0, -9.0, -4.0, 5.0));
	var[3] = (mat4x2(6.0, 1.0, 0.0, 3.0, 2.0, -5.0, -4.0, 5.0));
	var[4] = (mat4x2(5.0, -4.0, -7.0, -8.0, 9.0, -4.0, 5.0, 5.0));
	var[5] = (mat4x2(-1.0, 6.0, -6.0, 5.0, 4.0, -3.0, 1.0, -4.0));
	var[6] = (mat4x2(1.0, -6.0, 2.0, 4.0, 7.0, 1.0, 9.0, 5.0));
	var[7] = (mat4x2(8.0, -7.0, 6.0, -7.0, -4.0, 5.0, 3.0, -2.0));
	var[8] = (mat4x2(-2.0, -5.0, -1.0, 1.0, -8.0, 4.0, 9.0, 2.0));
	var[9] = (mat4x2(-5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 1.0, 1.0));
	var[10] = (mat4x2(1.0, -9.0, -1.0, 6.0, -9.0, -7.0, -8.0, 8.0));
	var[11] = (mat4x2(-2.0, 7.0, 8.0, -9.0, 4.0, -3.0, 0.0, -7.0));
	var[12] = (mat4x2(4.0, 9.0, -8.0, 5.0, 3.0, 3.0, -4.0, 8.0));
	var[13] = (mat4x2(-7.0, 2.0, 2.0, -4.0, 6.0, -1.0, 1.0, 1.0));
	var[14] = (mat4x2(-9.0, 7.0, 9.0, -1.0, 3.0, -9.0, 2.0, -2.0));
	var[15] = (mat4x2(4.0, 1.0, 2.0, 3.0, 5.0, -3.0, -8.0, -1.0));
	var[16] = (mat4x2(2.0, 6.0, -3.0, 8.0, 3.0, -4.0, 8.0, 5.0));
	var[17] = (mat4x2(-4.0, 6.0, 7.0, -3.0, 1.0, 9.0, 7.0, 4.0));
	var[18] = (mat4x2(8.0, -7.0, 4.0, 5.0, -8.0, -6.0, -7.0, 1.0));
}
#version 450
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
	highp mat2x4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0][0], mat2x4(5.0, -9.0, 4.0, 8.0, -1.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[0][1], mat2x4(-7.0, 1.0, 3.0, -8.0, 0.0, -7.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[0][2], mat2x4(8.0, 3.0, 1.0, -5.0, 2.0, 6.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[1][0], mat2x4(-7.0, 0.0, -7.0, -6.0, -8.0, -6.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[1][1], mat2x4(-9.0, 7.0, 5.0, 2.0, -3.0, -8.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[1][2], mat2x4(-5.0, 4.0, 5.0, -3.0, -7.0, -9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[2][0], mat2x4(-2.0, -5.0, 5.0, -9.0, -6.0, 9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[2][1], mat2x4(-3.0, 4.0, -4.0, -3.0, 7.0, 7.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[2][2], mat2x4(-5.0, -3.0, -3.0, -4.0, -9.0, 2.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[3][0], mat2x4(-4.0, 0.0, -1.0, 2.0, 8.0, 9.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[3][1], mat2x4(5.0, 1.0, 5.0, 8.0, -4.0, -5.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[3][2], mat2x4(1.0, 9.0, -1.0, 1.0, -2.0, -4.0, -1.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec4(-7.0, -1.0, 8.0, 2.0));
	var[0][0][1] = (vec4(-1.0, 2.0, 7.0, -9.0));
	var[0][1][0] = (vec4(-9.0, -5.0, 4.0, 7.0));
	var[0][1][1] = (vec4(5.0, 8.0, -8.0, -8.0));
	var[0][2][0] = (vec4(6.0, -3.0, 7.0, 0.0));
	var[0][2][1] = (vec4(4.0, 6.0, -4.0, 0.0));
	var[1][0][0] = (vec4(-5.0, 8.0, -9.0, -8.0));
	var[1][0][1] = (vec4(7.0, -7.0, -8.0, -6.0));
	var[1][1][0] = (vec4(-9.0, -8.0, 1.0, -2.0));
	var[1][1][1] = (vec4(7.0, -6.0, -9.0, 9.0));
	var[1][2][0] = (vec4(4.0, -6.0, 0.0, -3.0));
	var[1][2][1] = (vec4(-7.0, -7.0, 2.0, -1.0));
	var[2][0][0] = (vec4(6.0, -1.0, -5.0, 1.0));
	var[2][0][1] = (vec4(-1.0, 8.0, 7.0, 6.0));
	var[2][1][0] = (vec4(-9.0, 8.0, 2.0, 1.0));
	var[2][1][1] = (vec4(9.0, -7.0, 6.0, -8.0));
	var[2][2][0] = (vec4(-2.0, -8.0, 6.0, 9.0));
	var[2][2][1] = (vec4(5.0, 5.0, -1.0, -1.0));
	var[3][0][0] = (vec4(4.0, -3.0, 7.0, -9.0));
	var[3][0][1] = (vec4(-3.0, 9.0, 2.0, 6.0));
	var[3][1][0] = (vec4(6.0, 1.0, 5.0, -4.0));
	var[3][1][1] = (vec4(1.0, -6.0, 2.0, 6.0));
	var[3][2][0] = (vec4(-8.0, 7.0, 7.0, -5.0));
	var[3][2][1] = (vec4(-8.0, 0.0, -6.0, -4.0));
}
#version 450
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
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_mat3(var[0][0], mat3(-4.0, 9.0, -9.0, 3.0, 9.0, 6.0, -9.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat3(var[0][1], mat3(5.0, -8.0, -6.0, -8.0, -7.0, -4.0, 6.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat3(var[0][2], mat3(-2.0, -2.0, -8.0, -8.0, -5.0, -4.0, -6.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3(var[1][0], mat3(7.0, 0.0, 6.0, 5.0, 0.0, -5.0, -4.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3(var[1][1], mat3(9.0, 9.0, -6.0, 9.0, -6.0, 9.0, 6.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat3(var[1][2], mat3(-9.0, -2.0, -6.0, 7.0, 7.0, 8.0, 3.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat3(var[2][0], mat3(-1.0, -3.0, 3.0, -5.0, -1.0, 1.0, -8.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat3(var[2][1], mat3(9.0, 6.0, -9.0, 2.0, 8.0, -5.0, 5.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat3(var[2][2], mat3(-4.0, -2.0, 3.0, 0.0, -7.0, -5.0, 7.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3(var[3][0], mat3(5.0, 6.0, -6.0, -7.0, 9.0, 0.0, -5.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3(var[3][1], mat3(-7.0, -7.0, -5.0, 8.0, 3.0, 7.0, 6.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat3(var[3][2], mat3(4.0, -6.0, 0.0, 6.0, 5.0, -3.0, 1.0, 6.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (2.0);
	var[0][0][0] = (vec3(-4.0, 9.0, -4.0));
	var[0][0][1] = (vec3(2.0, 5.0, 5.0));
	var[0][0][2] = (vec3(-9.0, -5.0, 3.0));
	var[0][1][0] = (vec3(1.0, 8.0, 6.0));
	var[0][1][1] = (vec3(9.0, -8.0, -1.0));
	var[0][1][2] = (vec3(5.0, 1.0, 6.0));
	var[0][2][0] = (vec3(-5.0, -4.0, -8.0));
	var[0][2][1] = (vec3(-8.0, -2.0, 9.0));
	var[0][2][2] = (vec3(-4.0, 4.0, 4.0));
	var[1][0][0] = (vec3(-1.0, 5.0, -1.0));
	var[1][0][1] = (vec3(0.0, 9.0, 7.0));
	var[1][0][2] = (vec3(7.0, 5.0, 8.0));
	var[1][1][0] = (vec3(-6.0, -1.0, -1.0));
	var[1][1][1] = (vec3(-2.0, -5.0, -5.0));
	var[1][1][2] = (vec3(6.0, -3.0, -4.0));
	var[1][2][0] = (vec3(-6.0, 2.0, 3.0));
	var[1][2][1] = (vec3(-1.0, 2.0, -3.0));
	var[1][2][2] = (vec3(4.0, 1.0, 9.0));
	var[2][0][0] = (vec3(-3.0, -9.0, 6.0));
	var[2][0][1] = (vec3(-1.0, -6.0, 6.0));
	var[2][0][2] = (vec3(2.0, -5.0, -1.0));
	var[2][1][0] = (vec3(-2.0, 2.0, 9.0));
	var[2][1][1] = (vec3(1.0, -8.0, 6.0));
	var[2][1][2] = (vec3(-1.0, 7.0, 4.0));
	var[2][2][0] = (vec3(2.0, -8.0, 0.0));
	var[2][2][1] = (vec3(3.0, 9.0, 9.0));
	var[2][2][2] = (vec3(-8.0, -4.0, -8.0));
	var[3][0][0] = (vec3(3.0, 4.0, -4.0));
	var[3][0][1] = (vec3(4.0, 1.0, 0.0));
	var[3][0][2] = (vec3(4.0, 5.0, -9.0));
	var[3][1][0] = (vec3(-4.0, 2.0, -6.0));
	var[3][1][1] = (vec3(8.0, 3.0, 2.0));
	var[3][1][2] = (vec3(0.0, -1.0, 7.0));
	var[3][2][0] = (vec3(1.0, 3.0, 5.0));
	var[3][2][1] = (vec3(1.0, -6.0, 2.0));
	var[3][2][2] = (vec3(-5.0, 4.0, -9.0));
}
#version 450
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
	highp mat2x3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -3.0) && allOk;
	allOk = compare_mat2x3(var[0][0], mat2x3(6.0, -6.0, -6.0, -7.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[0][1], mat2x3(3.0, 1.0, 4.0, -2.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[0][2], mat2x3(-5.0, -8.0, -7.0, 1.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[1][0], mat2x3(6.0, -5.0, 3.0, 7.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[1][1], mat2x3(2.0, 6.0, 8.0, 4.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[1][2], mat2x3(-2.0, -4.0, -2.0, -7.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[2][0], mat2x3(8.0, -4.0, -5.0, -4.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[2][1], mat2x3(6.0, -9.0, -2.0, 8.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[2][2], mat2x3(-3.0, 6.0, 3.0, 2.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[3][0], mat2x3(-2.0, -3.0, -1.0, -4.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[3][1], mat2x3(2.0, -1.0, -4.0, 5.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[3][2], mat2x3(-7.0, 7.0, 0.0, 7.0, -1.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-1.0);
	var[0][0] = (mat2x3(-2.0, -5.0, 0.0, 7.0, -2.0, 0.0));
	var[0][1] = (mat2x3(9.0, 9.0, 8.0, -6.0, 3.0, -9.0));
	var[0][2] = (mat2x3(0.0, 1.0, 1.0, 7.0, -8.0, 7.0));
	var[1][0] = (mat2x3(-4.0, 4.0, -5.0, -1.0, 0.0, 2.0));
	var[1][1] = (mat2x3(-5.0, 6.0, 7.0, -2.0, 4.0, -3.0));
	var[1][2] = (mat2x3(7.0, 6.0, -3.0, -2.0, -6.0, 7.0));
	var[2][0] = (mat2x3(-3.0, 2.0, 8.0, -1.0, 2.0, 2.0));
	var[2][1] = (mat2x3(-9.0, 3.0, 1.0, -7.0, -7.0, 3.0));
	var[2][2] = (mat2x3(-3.0, -5.0, 4.0, -6.0, 8.0, 7.0));
	var[3][0] = (mat2x3(-9.0, 2.0, -8.0, 9.0, 9.0, 3.0));
	var[3][1] = (mat2x3(5.0, 8.0, 5.0, -7.0, 6.0, 3.0));
	var[3][2] = (mat2x3(6.0, 6.0, 1.0, 2.0, -7.0, -9.0));
}
#version 450
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
	highp mat3x4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0][0][0], mat3x4(-3.0, -9.0, 3.0, -6.0, -7.0, 8.0, -8.0, -5.0, 9.0, -8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][1], mat3x4(8.0, -4.0, 9.0, 7.0, -8.0, 9.0, -1.0, 0.0, 9.0, 7.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][2], mat3x4(-3.0, -6.0, -7.0, 8.0, 1.0, 5.0, 1.0, -1.0, 8.0, -9.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][0], mat3x4(6.0, 7.0, 9.0, 7.0, 0.0, 8.0, -1.0, 0.0, 6.0, -3.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][1], mat3x4(7.0, -7.0, 1.0, 0.0, -9.0, 2.0, -3.0, 7.0, 8.0, -6.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][2], mat3x4(0.0, 8.0, -8.0, -9.0, 5.0, -4.0, -5.0, 3.0, 4.0, 3.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][0], mat3x4(-4.0, -4.0, 2.0, -2.0, 1.0, 3.0, -5.0, -4.0, 9.0, 6.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][1], mat3x4(9.0, 3.0, 9.0, -8.0, 9.0, -4.0, -4.0, 7.0, -1.0, -7.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][2], mat3x4(-5.0, -4.0, -9.0, 1.0, 6.0, 6.0, 2.0, 1.0, 0.0, 1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][0], mat3x4(9.0, -4.0, -6.0, 0.0, 0.0, -9.0, 6.0, 4.0, -6.0, -3.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][1], mat3x4(5.0, 2.0, -1.0, 1.0, 1.0, 7.0, 0.0, 8.0, 9.0, 0.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][2], mat3x4(-5.0, 1.0, 4.0, 5.0, 5.0, 0.0, 7.0, -5.0, 6.0, -2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][0], mat3x4(6.0, 0.0, -7.0, 9.0, -8.0, 6.0, 0.0, 9.0, -1.0, -9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][1], mat3x4(1.0, 9.0, -9.0, -8.0, 0.0, 2.0, 9.0, 6.0, 3.0, 9.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][2], mat3x4(-7.0, -2.0, -1.0, -9.0, -9.0, 6.0, -6.0, -9.0, -4.0, -4.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][0], mat3x4(-2.0, -2.0, 7.0, -9.0, 3.0, 6.0, -5.0, -8.0, -3.0, -3.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][1], mat3x4(-9.0, 0.0, -2.0, -3.0, 4.0, -7.0, 8.0, -2.0, -7.0, -1.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][2], mat3x4(6.0, 7.0, 1.0, 5.0, 4.0, 9.0, 5.0, 4.0, 9.0, -4.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][0], mat3x4(9.0, 1.0, -6.0, 9.0, -3.0, -9.0, -2.0, -9.0, -7.0, -4.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][1], mat3x4(-3.0, 5.0, 0.0, -7.0, 9.0, -8.0, -9.0, -4.0, -6.0, 7.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][2], mat3x4(4.0, 4.0, 1.0, -1.0, 9.0, -6.0, -6.0, -4.0, 4.0, 8.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][0], mat3x4(1.0, 0.0, -7.0, -4.0, -3.0, 3.0, -7.0, 4.0, 1.0, 0.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][1], mat3x4(-1.0, 9.0, 4.0, -7.0, -2.0, 8.0, 8.0, 5.0, 3.0, -7.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][2], mat3x4(-8.0, -3.0, 1.0, -8.0, -6.0, 9.0, 2.0, 4.0, 4.0, 1.0, -1.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(-6.0, -4.0, 2.0, -3.0));
	var[0][0][0][1] = (vec4(-2.0, 4.0, -5.0, 8.0));
	var[0][0][0][2] = (vec4(-4.0, 6.0, -9.0, -9.0));
	var[0][0][1][0] = (vec4(0.0, 6.0, 0.0, 6.0));
	var[0][0][1][1] = (vec4(5.0, 2.0, 6.0, 6.0));
	var[0][0][1][2] = (vec4(-7.0, -6.0, -8.0, 0.0));
	var[0][0][2][0] = (vec4(3.0, -3.0, 6.0, -2.0));
	var[0][0][2][1] = (vec4(-8.0, -5.0, -5.0, 1.0));
	var[0][0][2][2] = (vec4(7.0, -8.0, -3.0, -2.0));
	var[0][1][0][0] = (vec4(6.0, 2.0, 8.0, -5.0));
	var[0][1][0][1] = (vec4(9.0, 5.0, 9.0, -1.0));
	var[0][1][0][2] = (vec4(-2.0, -5.0, -6.0, -8.0));
	var[0][1][1][0] = (vec4(0.0, -4.0, 7.0, 1.0));
	var[0][1][1][1] = (vec4(4.0, 1.0, 9.0, 9.0));
	var[0][1][1][2] = (vec4(-9.0, -5.0, 3.0, 8.0));
	var[0][1][2][0] = (vec4(4.0, -1.0, -2.0, 2.0));
	var[0][1][2][1] = (vec4(-5.0, 4.0, -2.0, -4.0));
	var[0][1][2][2] = (vec4(8.0, -7.0, -1.0, -9.0));
	var[1][0][0][0] = (vec4(6.0, 4.0, -5.0, 8.0));
	var[1][0][0][1] = (vec4(-5.0, -8.0, -9.0, -8.0));
	var[1][0][0][2] = (vec4(9.0, 0.0, 3.0, -4.0));
	var[1][0][1][0] = (vec4(0.0, -6.0, 5.0, 1.0));
	var[1][0][1][1] = (vec4(9.0, -8.0, -1.0, -7.0));
	var[1][0][1][2] = (vec4(1.0, 2.0, 0.0, -9.0));
	var[1][0][2][0] = (vec4(2.0, 0.0, 5.0, -4.0));
	var[1][0][2][1] = (vec4(-7.0, 0.0, 3.0, 4.0));
	var[1][0][2][2] = (vec4(4.0, 5.0, 2.0, -3.0));
	var[1][1][0][0] = (vec4(8.0, 5.0, 3.0, 6.0));
	var[1][1][0][1] = (vec4(0.0, 6.0, 0.0, 2.0));
	var[1][1][0][2] = (vec4(-1.0, -5.0, -6.0, -4.0));
	var[1][1][1][0] = (vec4(-3.0, -5.0, -4.0, -4.0));
	var[1][1][1][1] = (vec4(-8.0, -8.0, 1.0, 7.0));
	var[1][1][1][2] = (vec4(-6.0, -3.0, -7.0, 1.0));
	var[1][1][2][0] = (vec4(-5.0, 5.0, 0.0, 1.0));
	var[1][1][2][1] = (vec4(6.0, 2.0, 5.0, 5.0));
	var[1][1][2][2] = (vec4(5.0, -1.0, -7.0, -1.0));
	var[2][0][0][0] = (vec4(0.0, -7.0, 3.0, -8.0));
	var[2][0][0][1] = (vec4(3.0, -2.0, -3.0, 1.0));
	var[2][0][0][2] = (vec4(-5.0, -9.0, -7.0, -7.0));
	var[2][0][1][0] = (vec4(-2.0, -9.0, -7.0, -8.0));
	var[2][0][1][1] = (vec4(7.0, -6.0, -4.0, 6.0));
	var[2][0][1][2] = (vec4(-5.0, -4.0, -8.0, -4.0));
	var[2][0][2][0] = (vec4(9.0, -2.0, 7.0, -9.0));
	var[2][0][2][1] = (vec4(-6.0, -4.0, 5.0, -5.0));
	var[2][0][2][2] = (vec4(-5.0, 7.0, 6.0, 6.0));
	var[2][1][0][0] = (vec4(1.0, -1.0, -4.0, 2.0));
	var[2][1][0][1] = (vec4(5.0, 8.0, 5.0, -9.0));
	var[2][1][0][2] = (vec4(7.0, -9.0, 0.0, -3.0));
	var[2][1][1][0] = (vec4(-6.0, 6.0, -6.0, -5.0));
	var[2][1][1][1] = (vec4(5.0, 3.0, 4.0, 8.0));
	var[2][1][1][2] = (vec4(7.0, 0.0, -5.0, -6.0));
	var[2][1][2][0] = (vec4(5.0, 0.0, 8.0, 4.0));
	var[2][1][2][1] = (vec4(3.0, -1.0, -7.0, 0.0));
	var[2][1][2][2] = (vec4(-1.0, 6.0, -6.0, 1.0));
	var[3][0][0][0] = (vec4(0.0, 9.0, -3.0, -9.0));
	var[3][0][0][1] = (vec4(-7.0, 6.0, -7.0, -1.0));
	var[3][0][0][2] = (vec4(-6.0, -6.0, 2.0, 8.0));
	var[3][0][1][0] = (vec4(-6.0, 6.0, -8.0, -3.0));
	var[3][0][1][1] = (vec4(2.0, 0.0, 0.0, -2.0));
	var[3][0][1][2] = (vec4(-9.0, -3.0, 2.0, 2.0));
	var[3][0][2][0] = (vec4(-7.0, -4.0, 9.0, 7.0));
	var[3][0][2][1] = (vec4(-3.0, 1.0, -7.0, 9.0));
	var[3][0][2][2] = (vec4(-9.0, -8.0, 0.0, 8.0));
	var[3][1][0][0] = (vec4(0.0, 8.0, 0.0, 9.0));
	var[3][1][0][1] = (vec4(-6.0, 8.0, -5.0, -1.0));
	var[3][1][0][2] = (vec4(0.0, 6.0, -9.0, 9.0));
	var[3][1][1][0] = (vec4(8.0, -2.0, -5.0, 0.0));
	var[3][1][1][1] = (vec4(1.0, 4.0, -3.0, -6.0));
	var[3][1][1][2] = (vec4(2.0, -2.0, -2.0, 3.0));
	var[3][1][2][0] = (vec4(-5.0, -4.0, -6.0, 2.0));
	var[3][1][2][1] = (vec4(-6.0, 0.0, 1.0, 9.0));
	var[3][1][2][2] = (vec4(2.0, 5.0, -8.0, 5.0));
}
#version 450
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
	highp mat4x2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0][0][0], mat4x2(9.0, 2.0, -3.0, -5.0, -5.0, -4.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][1], mat4x2(7.0, 7.0, -8.0, 9.0, -7.0, -5.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][2], mat4x2(-9.0, 8.0, 3.0, -7.0, 5.0, 3.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][0], mat4x2(7.0, -5.0, 4.0, -9.0, 5.0, 5.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][1], mat4x2(2.0, 9.0, -6.0, -6.0, 2.0, 8.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][2], mat4x2(-6.0, 9.0, -3.0, -1.0, 3.0, 8.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][0], mat4x2(7.0, -4.0, -4.0, -6.0, 9.0, -3.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][1], mat4x2(-2.0, 5.0, 6.0, 4.0, -6.0, -2.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][2], mat4x2(-5.0, 9.0, -4.0, -6.0, 4.0, -5.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][0], mat4x2(-7.0, -7.0, -6.0, 2.0, 3.0, -7.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][1], mat4x2(8.0, -4.0, 1.0, 3.0, 4.0, -2.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][2], mat4x2(6.0, -4.0, -6.0, 6.0, -8.0, 8.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][0], mat4x2(-4.0, 9.0, -1.0, -6.0, 5.0, 3.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][1], mat4x2(-7.0, -7.0, -9.0, 9.0, 5.0, 8.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][2], mat4x2(-6.0, -5.0, -7.0, -3.0, 6.0, -7.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][0], mat4x2(1.0, 0.0, 3.0, -4.0, -6.0, 5.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][1], mat4x2(1.0, -5.0, -1.0, -2.0, 2.0, 1.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][2], mat4x2(-3.0, 1.0, 1.0, 4.0, 2.0, -8.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][0], mat4x2(7.0, -9.0, -5.0, -3.0, -6.0, -9.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][1], mat4x2(-4.0, -9.0, 9.0, -7.0, -6.0, -8.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][2], mat4x2(8.0, 6.0, 7.0, -6.0, 0.0, 0.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][0], mat4x2(-4.0, 8.0, 3.0, 1.0, -5.0, 5.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][1], mat4x2(0.0, 1.0, 4.0, 1.0, -3.0, 2.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][2], mat4x2(-8.0, 6.0, 2.0, 2.0, -4.0, -7.0, -5.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4x2(-9.0, 9.0, 1.0, 5.0, 0.0, 6.0, 3.0, 6.0));
	var[0][0][1] = (mat4x2(-5.0, -7.0, 8.0, -6.0, 1.0, -3.0, 2.0, 4.0));
	var[0][0][2] = (mat4x2(8.0, -2.0, 6.0, 6.0, 1.0, -9.0, 9.0, -3.0));
	var[0][1][0] = (mat4x2(9.0, -8.0, 1.0, 3.0, 1.0, -5.0, -5.0, -5.0));
	var[0][1][1] = (mat4x2(2.0, -5.0, 1.0, 5.0, -5.0, 1.0, -2.0, -4.0));
	var[0][1][2] = (mat4x2(0.0, -1.0, -2.0, 7.0, 1.0, -5.0, -2.0, -9.0));
	var[1][0][0] = (mat4x2(2.0, 0.0, -9.0, -3.0, -1.0, 1.0, 8.0, 1.0));
	var[1][0][1] = (mat4x2(-3.0, 6.0, -3.0, -6.0, -7.0, 2.0, 2.0, 7.0));
	var[1][0][2] = (mat4x2(3.0, -6.0, -7.0, -9.0, 6.0, 3.0, 6.0, 3.0));
	var[1][1][0] = (mat4x2(-1.0, -5.0, -2.0, 4.0, 6.0, 1.0, -4.0, 9.0));
	var[1][1][1] = (mat4x2(3.0, -5.0, -9.0, -6.0, -1.0, 2.0, -9.0, 3.0));
	var[1][1][2] = (mat4x2(-9.0, 2.0, -3.0, -1.0, -3.0, -6.0, -9.0, 9.0));
	var[2][0][0] = (mat4x2(-8.0, 5.0, -9.0, -8.0, -8.0, -4.0, -5.0, -5.0));
	var[2][0][1] = (mat4x2(-6.0, 1.0, 7.0, 7.0, -9.0, 6.0, -8.0, -3.0));
	var[2][0][2] = (mat4x2(4.0, -4.0, 8.0, -6.0, 5.0, 3.0, 3.0, 2.0));
	var[2][1][0] = (mat4x2(1.0, -8.0, 1.0, -6.0, 0.0, -2.0, 2.0, -8.0));
	var[2][1][1] = (mat4x2(2.0, -7.0, -3.0, 7.0, 5.0, 6.0, 5.0, -4.0));
	var[2][1][2] = (mat4x2(-1.0, -8.0, -3.0, -1.0, 7.0, -2.0, -4.0, 2.0));
	var[3][0][0] = (mat4x2(2.0, -3.0, 9.0, 9.0, -2.0, 0.0, -5.0, -2.0));
	var[3][0][1] = (mat4x2(3.0, 5.0, 8.0, 9.0, -2.0, -1.0, 3.0, -2.0));
	var[3][0][2] = (mat4x2(7.0, 5.0, 1.0, -1.0, 2.0, 8.0, 7.0, 7.0));
	var[3][1][0] = (mat4x2(7.0, 2.0, 0.0, -8.0, 0.0, 2.0, -9.0, 5.0));
	var[3][1][1] = (mat4x2(-8.0, -1.0, -4.0, 4.0, -3.0, -5.0, -3.0, 8.0));
	var[3][1][2] = (mat4x2(-4.0, -1.0, -1.0, 0.0, -9.0, 4.0, -2.0, -6.0));
}
#version 450
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
	allOk = compare_float((padding), 9.0) && allOk;
	allOk = compare_mat4(var[0][0][0], mat4(-3.0, 8.0, -1.0, 2.0, 2.0, -5.0, -8.0, -6.0, -6.0, -3.0, 4.0, -9.0, -2.0, -9.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(7.0, -9.0, 0.0, 5.0, -6.0, -4.0, -7.0, 7.0, -3.0, 8.0, 6.0, 1.0, 0.0, 8.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat4(var[0][0][2], mat4(2.0, 0.0, -9.0, -1.0, -3.0, 4.0, -3.0, 0.0, -2.0, -5.0, -7.0, -1.0, 4.0, 2.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(-3.0, -1.0, -8.0, -7.0, -8.0, 4.0, 2.0, -4.0, -5.0, 1.0, 5.0, 2.0, -9.0, 8.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(7.0, 8.0, -4.0, -9.0, -8.0, -4.0, 6.0, 7.0, -4.0, -5.0, -1.0, 4.0, -2.0, -2.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat4(var[0][1][2], mat4(-8.0, 9.0, 4.0, -3.0, -1.0, -3.0, 5.0, -1.0, 3.0, 9.0, 6.0, -5.0, 8.0, 3.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(0.0, 8.0, 8.0, 8.0, -3.0, -1.0, -9.0, 9.0, 2.0, 2.0, 2.0, 1.0, -1.0, 7.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(0.0, -2.0, -9.0, 7.0, -6.0, 0.0, 8.0, -8.0, -2.0, -8.0, -1.0, -3.0, 0.0, 8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat4(var[1][0][2], mat4(4.0, -6.0, 5.0, 2.0, -1.0, -6.0, -7.0, -9.0, 7.0, 4.0, 7.0, 4.0, -3.0, -4.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(-5.0, 5.0, 6.0, 9.0, -7.0, -2.0, 5.0, 7.0, -2.0, 8.0, 1.0, -1.0, 9.0, -8.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(8.0, 6.0, 9.0, 5.0, 3.0, 4.0, -8.0, -4.0, -5.0, 0.0, -6.0, 3.0, 7.0, 1.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat4(var[1][1][2], mat4(8.0, -4.0, -7.0, 1.0, -3.0, 9.0, -9.0, -1.0, 7.0, -1.0, 9.0, 9.0, 9.0, 7.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(-2.0, -1.0, -8.0, 2.0, 6.0, 2.0, 1.0, 4.0, -3.0, -2.0, -7.0, -4.0, -6.0, 6.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(8.0, 4.0, -5.0, 9.0, -4.0, -5.0, 2.0, 2.0, -3.0, 2.0, 5.0, 3.0, -3.0, -8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][0][2], mat4(-1.0, 7.0, -6.0, -9.0, -8.0, -3.0, -5.0, 0.0, -2.0, -1.0, 4.0, -9.0, -1.0, 6.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(7.0, 9.0, 6.0, -6.0, 2.0, 8.0, 2.0, 3.0, -8.0, 7.0, 6.0, 0.0, 1.0, -4.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(-9.0, 4.0, -7.0, 5.0, 5.0, 3.0, 8.0, -1.0, 6.0, 3.0, 1.0, -9.0, 3.0, -1.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat4(var[2][1][2], mat4(0.0, -7.0, -5.0, -8.0, 2.0, 0.0, 4.0, 9.0, -3.0, 8.0, -7.0, 7.0, 5.0, 1.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat4(var[3][0][0], mat4(5.0, -7.0, 2.0, 5.0, -6.0, 2.0, -9.0, -9.0, 8.0, 4.0, -2.0, -7.0, -4.0, 0.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat4(var[3][0][1], mat4(0.0, 8.0, -5.0, -9.0, -4.0, 7.0, -4.0, -9.0, 7.0, 9.0, -7.0, -9.0, 2.0, 5.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat4(var[3][0][2], mat4(-6.0, 7.0, -1.0, -2.0, -5.0, 4.0, -6.0, -7.0, -7.0, -4.0, -1.0, 0.0, -5.0, 3.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4(var[3][1][0], mat4(-1.0, -9.0, 1.0, -2.0, 4.0, -2.0, 2.0, -5.0, 6.0, -6.0, -8.0, -1.0, -3.0, -9.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat4(var[3][1][1], mat4(-1.0, 8.0, 9.0, 8.0, 5.0, 6.0, -9.0, 1.0, 9.0, 8.0, 6.0, 0.0, 4.0, 9.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4(var[3][1][2], mat4(6.0, -4.0, -5.0, -4.0, -9.0, -8.0, 9.0, 4.0, 2.0, 5.0, -8.0, 3.0, 7.0, -9.0, -5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (7.0);
	var[0][0][0] = (mat4(7.0, 7.0, -1.0, -6.0, -2.0, -6.0, 5.0, 9.0, 8.0, -6.0, 9.0, -8.0, 8.0, 6.0, 5.0, -7.0));
	var[0][0][1] = (mat4(2.0, -9.0, 8.0, -8.0, -3.0, 6.0, -8.0, 3.0, 0.0, -9.0, 1.0, 4.0, -6.0, -1.0, 8.0, 8.0));
	var[0][0][2] = (mat4(9.0, 2.0, -3.0, 0.0, 4.0, -8.0, 3.0, 2.0, 2.0, 2.0, 3.0, -6.0, -2.0, 0.0, -2.0, -3.0));
	var[0][1][0] = (mat4(5.0, 6.0, -9.0, 8.0, -2.0, -3.0, -2.0, -2.0, -4.0, -1.0, -7.0, -8.0, -5.0, 0.0, -7.0, 6.0));
	var[0][1][1] = (mat4(2.0, 4.0, -8.0, -9.0, -9.0, -5.0, -7.0, 1.0, 9.0, 1.0, 5.0, -3.0, 2.0, 6.0, -7.0, 7.0));
	var[0][1][2] = (mat4(0.0, -2.0, -3.0, -6.0, -6.0, -6.0, 6.0, -6.0, -6.0, 9.0, 8.0, -5.0, 8.0, 7.0, -3.0, 4.0));
	var[1][0][0] = (mat4(-1.0, 7.0, 4.0, 1.0, 6.0, 3.0, -6.0, 4.0, -9.0, 6.0, 0.0, -1.0, 1.0, -5.0, 0.0, 4.0));
	var[1][0][1] = (mat4(5.0, 1.0, -4.0, 2.0, -5.0, 1.0, -7.0, 5.0, -2.0, -1.0, -2.0, -5.0, 7.0, 2.0, 2.0, -6.0));
	var[1][0][2] = (mat4(-1.0, 0.0, -4.0, 3.0, -9.0, 1.0, -5.0, -9.0, 3.0, -4.0, 2.0, -9.0, 0.0, -6.0, 3.0, 7.0));
	var[1][1][0] = (mat4(-4.0, 5.0, -8.0, 5.0, -8.0, 9.0, 3.0, 9.0, 3.0, -3.0, -8.0, -6.0, -4.0, 4.0, 7.0, 2.0));
	var[1][1][1] = (mat4(4.0, -1.0, 2.0, 1.0, 2.0, 6.0, -9.0, -1.0, -5.0, -1.0, -7.0, 9.0, 4.0, -9.0, 6.0, 6.0));
	var[1][1][2] = (mat4(6.0, 8.0, -3.0, -9.0, 7.0, 6.0, -5.0, 9.0, -5.0, 0.0, -9.0, 3.0, -6.0, -2.0, -7.0, -6.0));
	var[2][0][0] = (mat4(3.0, 8.0, -8.0, 7.0, 5.0, 8.0, -5.0, 7.0, 4.0, 4.0, 6.0, -3.0, 9.0, -3.0, -6.0, 3.0));
	var[2][0][1] = (mat4(-1.0, -3.0, -7.0, -8.0, 3.0, 2.0, -9.0, 5.0, 0.0, -6.0, -6.0, -8.0, -3.0, 1.0, 4.0, -6.0));
	var[2][0][2] = (mat4(-4.0, 7.0, -5.0, -2.0, -2.0, 4.0, -8.0, 2.0, 6.0, -4.0, 5.0, -8.0, -5.0, 3.0, -8.0, -5.0));
	var[2][1][0] = (mat4(6.0, 8.0, -4.0, 1.0, -6.0, 4.0, -2.0, 2.0, -3.0, -4.0, 3.0, -5.0, -4.0, 9.0, 8.0, 2.0));
	var[2][1][1] = (mat4(2.0, -1.0, 9.0, 2.0, 9.0, -4.0, 4.0, -1.0, -3.0, -4.0, 0.0, -3.0, 9.0, -7.0, -6.0, 8.0));
	var[2][1][2] = (mat4(9.0, -8.0, -2.0, -9.0, -5.0, -3.0, 0.0, 0.0, 1.0, 1.0, -4.0, 4.0, -4.0, -1.0, -5.0, -9.0));
	var[3][0][0] = (mat4(-7.0, 4.0, 6.0, -2.0, -3.0, -4.0, -9.0, 8.0, 2.0, -3.0, 1.0, 3.0, 2.0, 1.0, 1.0, -4.0));
	var[3][0][1] = (mat4(4.0, 5.0, -7.0, 9.0, -7.0, 9.0, 2.0, -1.0, -6.0, 0.0, 3.0, 5.0, -3.0, 2.0, -2.0, 6.0));
	var[3][0][2] = (mat4(-1.0, -6.0, -8.0, -8.0, 2.0, -8.0, -1.0, -1.0, -8.0, 3.0, 3.0, -9.0, -9.0, 7.0, 7.0, 4.0));
	var[3][1][0] = (mat4(2.0, -6.0, -1.0, 5.0, -4.0, -6.0, -8.0, 7.0, 4.0, -2.0, -4.0, -1.0, -9.0, 4.0, 8.0, 1.0));
	var[3][1][1] = (mat4(5.0, 9.0, 3.0, -9.0, -6.0, -4.0, 4.0, 7.0, 6.0, -1.0, -7.0, -5.0, 7.0, 5.0, 2.0, 0.0));
	var[3][1][2] = (mat4(3.0, -1.0, 9.0, -1.0, 3.0, 3.0, 5.0, 7.0, 7.0, -8.0, -9.0, -5.0, 9.0, 4.0, 7.0, 4.0));
}
#version 450
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
	allOk = compare_float((padding), 5.0) && allOk;
	allOk = compare_mat2x3(var[0][0][0], mat2x3(-6.0, 5.0, -5.0, 8.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][1], mat2x3(3.0, 9.0, -4.0, 0.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][2], mat2x3(5.0, 5.0, -9.0, 2.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][0], mat2x3(-9.0, 2.0, -9.0, -7.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][1], mat2x3(-1.0, 0.0, -6.0, 8.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][2], mat2x3(0.0, 4.0, 4.0, -5.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][0], mat2x3(4.0, 4.0, -4.0, -1.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][1], mat2x3(-7.0, -1.0, 6.0, 8.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][2], mat2x3(-8.0, 9.0, 5.0, 9.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][0], mat2x3(-7.0, -4.0, 1.0, -1.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][1], mat2x3(-5.0, -8.0, 1.0, 6.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][2], mat2x3(2.0, -2.0, -7.0, 1.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][0], mat2x3(-2.0, 6.0, 6.0, 9.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][1], mat2x3(3.0, 0.0, 3.0, -6.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][2], mat2x3(-8.0, 9.0, -3.0, -9.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][0], mat2x3(6.0, 6.0, 0.0, -9.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][1], mat2x3(7.0, 3.0, 6.0, 1.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][2], mat2x3(9.0, -9.0, 4.0, 2.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][0], mat2x3(-8.0, 9.0, 2.0, -9.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][1], mat2x3(-9.0, -4.0, -1.0, -1.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][2], mat2x3(-5.0, 9.0, -8.0, -1.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][0], mat2x3(0.0, 0.0, -5.0, -5.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][1], mat2x3(5.0, 9.0, 4.0, 8.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][2], mat2x3(3.0, -2.0, 2.0, -1.0, -9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-9.0);
	var[0][0][0] = (mat2x3(-1.0, 8.0, -5.0, -3.0, 4.0, -4.0));
	var[0][0][1] = (mat2x3(1.0, -5.0, 6.0, -8.0, -3.0, 0.0));
	var[0][0][2] = (mat2x3(2.0, -1.0, -7.0, 4.0, 6.0, 6.0));
	var[0][1][0] = (mat2x3(3.0, 8.0, -7.0, -7.0, 4.0, -1.0));
	var[0][1][1] = (mat2x3(6.0, -5.0, 4.0, -2.0, 2.0, -8.0));
	var[0][1][2] = (mat2x3(7.0, -5.0, -1.0, 0.0, -4.0, 4.0));
	var[1][0][0] = (mat2x3(-3.0, 0.0, 5.0, 9.0, 2.0, -9.0));
	var[1][0][1] = (mat2x3(9.0, -7.0, 2.0, 6.0, -3.0, 8.0));
	var[1][0][2] = (mat2x3(-9.0, 7.0, -1.0, -3.0, 7.0, -4.0));
	var[1][1][0] = (mat2x3(-4.0, 7.0, 8.0, -6.0, -1.0, -1.0));
	var[1][1][1] = (mat2x3(-3.0, -5.0, 8.0, 4.0, -9.0, 5.0));
	var[1][1][2] = (mat2x3(8.0, 6.0, 4.0, -4.0, -4.0, -9.0));
	var[2][0][0] = (mat2x3(-1.0, -5.0, 7.0, -3.0, -6.0, 1.0));
	var[2][0][1] = (mat2x3(3.0, 3.0, 1.0, 9.0, -7.0, -4.0));
	var[2][0][2] = (mat2x3(-1.0, -4.0, 1.0, -9.0, 4.0, -7.0));
	var[2][1][0] = (mat2x3(3.0, 6.0, -8.0, -9.0, 0.0, -7.0));
	var[2][1][1] = (mat2x3(-6.0, -7.0, -9.0, -4.0, 3.0, -9.0));
	var[2][1][2] = (mat2x3(7.0, 8.0, -9.0, 8.0, -8.0, 0.0));
	var[3][0][0] = (mat2x3(-6.0, -1.0, -1.0, 0.0, -4.0, 5.0));
	var[3][0][1] = (mat2x3(-6.0, -9.0, -6.0, -5.0, 0.0, -2.0));
	var[3][0][2] = (mat2x3(-6.0, 3.0, -3.0, -1.0, -6.0, -1.0));
	var[3][1][0] = (mat2x3(3.0, 8.0, -4.0, -8.0, -9.0, 6.0));
	var[3][1][1] = (mat2x3(5.0, 7.0, -4.0, -9.0, -1.0, 0.0));
	var[3][1][2] = (mat2x3(-2.0, -6.0, -1.0, -7.0, -9.0, 7.0));
}
#version 450
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
	uint16_t var[4][2][3];
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(padding), 9u) && allOk;
	allOk = compare_uint16_t(uint(var[0][0][0]), 5u) && allOk;
	allOk = compare_uint16_t(uint(var[0][0][1]), 4u) && allOk;
	allOk = compare_uint16_t(uint(var[0][0][2]), 1u) && allOk;
	allOk = compare_uint16_t(uint(var[0][1][0]), 8u) && allOk;
	allOk = compare_uint16_t(uint(var[0][1][1]), 2u) && allOk;
	allOk = compare_uint16_t(uint(var[0][1][2]), 7u) && allOk;
	allOk = compare_uint16_t(uint(var[1][0][0]), 0u) && allOk;
	allOk = compare_uint16_t(uint(var[1][0][1]), 9u) && allOk;
	allOk = compare_uint16_t(uint(var[1][0][2]), 2u) && allOk;
	allOk = compare_uint16_t(uint(var[1][1][0]), 1u) && allOk;
	allOk = compare_uint16_t(uint(var[1][1][1]), 0u) && allOk;
	allOk = compare_uint16_t(uint(var[1][1][2]), 8u) && allOk;
	allOk = compare_uint16_t(uint(var[2][0][0]), 0u) && allOk;
	allOk = compare_uint16_t(uint(var[2][0][1]), 6u) && allOk;
	allOk = compare_uint16_t(uint(var[2][0][2]), 9u) && allOk;
	allOk = compare_uint16_t(uint(var[2][1][0]), 6u) && allOk;
	allOk = compare_uint16_t(uint(var[2][1][1]), 6u) && allOk;
	allOk = compare_uint16_t(uint(var[2][1][2]), 4u) && allOk;
	allOk = compare_uint16_t(uint(var[3][0][0]), 8u) && allOk;
	allOk = compare_uint16_t(uint(var[3][0][1]), 1u) && allOk;
	allOk = compare_uint16_t(uint(var[3][0][2]), 7u) && allOk;
	allOk = compare_uint16_t(uint(var[3][1][0]), 6u) && allOk;
	allOk = compare_uint16_t(uint(var[3][1][1]), 0u) && allOk;
	allOk = compare_uint16_t(uint(var[3][1][2]), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = uint16_t(9u);
	var[0][0][0] = uint16_t(1u);
	var[0][0][1] = uint16_t(1u);
	var[0][0][2] = uint16_t(0u);
	var[0][1][0] = uint16_t(1u);
	var[0][1][1] = uint16_t(0u);
	var[0][1][2] = uint16_t(2u);
	var[1][0][0] = uint16_t(7u);
	var[1][0][1] = uint16_t(5u);
	var[1][0][2] = uint16_t(8u);
	var[1][1][0] = uint16_t(1u);
	var[1][1][1] = uint16_t(1u);
	var[1][1][2] = uint16_t(2u);
	var[2][0][0] = uint16_t(1u);
	var[2][0][1] = uint16_t(9u);
	var[2][0][2] = uint16_t(7u);
	var[2][1][0] = uint16_t(9u);
	var[2][1][1] = uint16_t(3u);
	var[2][1][2] = uint16_t(0u);
	var[3][0][0] = uint16_t(2u);
	var[3][0][1] = uint16_t(6u);
	var[3][0][2] = uint16_t(3u);
	var[3][1][0] = uint16_t(8u);
	var[3][1][1] = uint16_t(4u);
	var[3][1][2] = uint16_t(6u);
}
#version 450
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

layout(std430, row_major, binding = 1) buffer Block
{
	highp mat3 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0][0][0], mat3(-2.0, 7.0, 9.0, 1.0, -5.0, -1.0, 3.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(-8.0, -8.0, 2.0, 7.0, -6.0, -4.0, 7.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(1.0, -6.0, -4.0, 8.0, -1.0, -9.0, -1.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(3.0, 8.0, -3.0, -7.0, 6.0, -6.0, 9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3(var[0][2][0], mat3(6.0, 7.0, -1.0, 8.0, 1.0, 1.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3(var[0][2][1], mat3(-5.0, -4.0, -5.0, -1.0, 5.0, 1.0, 5.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat3(var[0][3][0], mat3(8.0, 2.0, -2.0, -2.0, 0.0, 9.0, 3.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3(var[0][3][1], mat3(-7.0, -4.0, -3.0, 2.0, -3.0, 1.0, 2.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(-2.0, 2.0, -3.0, -3.0, 1.0, -3.0, -8.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(3.0, -6.0, -6.0, 5.0, 5.0, -8.0, -1.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(-9.0, -1.0, -4.0, -4.0, -4.0, 9.0, 6.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(4.0, -5.0, 6.0, 7.0, -8.0, 2.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3(var[1][2][0], mat3(4.0, -8.0, -9.0, 5.0, 9.0, 1.0, -5.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3(var[1][2][1], mat3(7.0, 6.0, -5.0, -8.0, -5.0, 4.0, -8.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat3(var[1][3][0], mat3(0.0, 0.0, 7.0, -4.0, -1.0, -9.0, -6.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat3(var[1][3][1], mat3(1.0, 7.0, -3.0, 4.0, 3.0, 4.0, -1.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(-6.0, 3.0, -5.0, 0.0, 5.0, 8.0, -9.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(-1.0, 4.0, -4.0, 9.0, 2.0, 5.0, 5.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(9.0, 7.0, 4.0, 2.0, 8.0, 1.0, -9.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(0.0, -6.0, 9.0, 7.0, 3.0, 2.0, -6.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3(var[2][2][0], mat3(0.0, -8.0, 3.0, -4.0, -5.0, 7.0, -7.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat3(var[2][2][1], mat3(5.0, -3.0, 3.0, 7.0, 2.0, 8.0, 6.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(var[2][3][0], mat3(5.0, 3.0, -7.0, -1.0, 5.0, -5.0, 9.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat3(var[2][3][1], mat3(-4.0, 8.0, -8.0, -3.0, -9.0, 2.0, 5.0, 0.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3(-2.0, -7.0, 1.0, 7.0, 5.0, 2.0, 9.0, -1.0, -9.0));
	var[0][0][1] = (mat3(6.0, -5.0, 8.0, -1.0, -8.0, -8.0, 0.0, 9.0, 1.0));
	var[0][1][0] = (mat3(8.0, 7.0, -7.0, -4.0, 7.0, -5.0, 8.0, 3.0, -4.0));
	var[0][1][1] = (mat3(-5.0, 6.0, -1.0, 6.0, -8.0, 1.0, 7.0, 5.0, 7.0));
	var[0][2][0] = (mat3(8.0, 0.0, -7.0, 0.0, -7.0, 5.0, -5.0, -2.0, -9.0));
	var[0][2][1] = (mat3(6.0, 5.0, 8.0, 2.0, 5.0, -8.0, 2.0, -9.0, -7.0));
	var[0][3][0] = (mat3(-1.0, 1.0, 8.0, 9.0, 5.0, -2.0, -6.0, -8.0, -3.0));
	var[0][3][1] = (mat3(-7.0, 4.0, 8.0, -8.0, -8.0, -9.0, -8.0, -9.0, 0.0));
	var[1][0][0] = (mat3(1.0, -4.0, 5.0, -6.0, -1.0, 9.0, -6.0, 0.0, 5.0));
	var[1][0][1] = (mat3(-4.0, 3.0, -8.0, -9.0, 9.0, -7.0, -1.0, -9.0, -9.0));
	var[1][1][0] = (mat3(1.0, 7.0, -1.0, -8.0, 9.0, -2.0, 7.0, 9.0, -5.0));
	var[1][1][1] = (mat3(8.0, 7.0, 6.0, -6.0, -1.0, -2.0, 9.0, 6.0, 0.0));
	var[1][2][0] = (mat3(-8.0, 3.0, -4.0, 9.0, 2.0, 0.0, -3.0, -6.0, 4.0));
	var[1][2][1] = (mat3(6.0, -6.0, 5.0, -5.0, -5.0, -9.0, -4.0, -5.0, 7.0));
	var[1][3][0] = (mat3(5.0, 9.0, 0.0, -1.0, 0.0, -6.0, -7.0, -9.0, -2.0));
	var[1][3][1] = (mat3(7.0, 9.0, -3.0, 3.0, -7.0, 4.0, 9.0, 3.0, -8.0));
	var[2][0][0] = (mat3(-2.0, 7.0, -3.0, 2.0, -6.0, -7.0, 4.0, 8.0, -8.0));
	var[2][0][1] = (mat3(6.0, 1.0, 9.0, 7.0, -9.0, 5.0, -9.0, 9.0, 1.0));
	var[2][1][0] = (mat3(-4.0, -3.0, -6.0, -5.0, -8.0, -6.0, 5.0, -5.0, 2.0));
	var[2][1][1] = (mat3(7.0, 5.0, -4.0, 7.0, 9.0, -8.0, -9.0, 8.0, -9.0));
	var[2][2][0] = (mat3(-7.0, 5.0, 9.0, 0.0, -7.0, 7.0, 9.0, 9.0, 9.0));
	var[2][2][1] = (mat3(7.0, -1.0, 7.0, -4.0, 1.0, -3.0, 8.0, 0.0, 4.0));
	var[2][3][0] = (mat3(-1.0, 2.0, 8.0, 0.0, -8.0, -5.0, 6.0, 2.0, 6.0));
	var[2][3][1] = (mat3(-5.0, 0.0, 1.0, 8.0, 9.0, -2.0, 3.0, 4.0, 1.0));
}
#version 450
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
	highp mat3 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0][0][0], mat3(-7.0, -8.0, -9.0, -8.0, 8.0, 6.0, 6.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(9.0, 5.0, -2.0, 9.0, -8.0, 6.0, -3.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(5.0, -8.0, -9.0, 7.0, 9.0, -5.0, -5.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(1.0, -3.0, -2.0, -9.0, 8.0, 9.0, -8.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat3(var[0][2][0], mat3(5.0, 9.0, -5.0, -4.0, 8.0, 3.0, -4.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat3(var[0][2][1], mat3(5.0, 6.0, -6.0, -5.0, 4.0, 8.0, -4.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3(var[0][3][0], mat3(2.0, -7.0, 1.0, -7.0, -9.0, 5.0, 3.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3(var[0][3][1], mat3(4.0, -6.0, -5.0, -8.0, 3.0, -6.0, 3.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(-1.0, -5.0, -7.0, -6.0, 8.0, 8.0, -2.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(-7.0, -7.0, 9.0, 5.0, -5.0, 1.0, -2.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(-3.0, -2.0, 9.0, 5.0, -3.0, 9.0, 7.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(8.0, 8.0, -8.0, -2.0, -9.0, -6.0, -6.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3(var[1][2][0], mat3(-6.0, 8.0, 9.0, 6.0, -6.0, -2.0, -9.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat3(var[1][2][1], mat3(-4.0, -8.0, -2.0, -5.0, -4.0, 2.0, 1.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3(var[1][3][0], mat3(-6.0, 0.0, 3.0, 6.0, -8.0, 1.0, -6.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3(var[1][3][1], mat3(3.0, -6.0, -3.0, -4.0, 8.0, 1.0, -8.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(8.0, 3.0, 7.0, -8.0, -1.0, -2.0, -9.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(4.0, -4.0, -9.0, 1.0, 5.0, 8.0, -8.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(9.0, -8.0, 7.0, -7.0, 7.0, 1.0, 7.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(-3.0, 3.0, 3.0, -7.0, -7.0, -7.0, 4.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3(var[2][2][0], mat3(-3.0, 9.0, 1.0, -4.0, -5.0, -5.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3(var[2][2][1], mat3(6.0, -5.0, -2.0, 1.0, -4.0, 8.0, 3.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat3(var[2][3][0], mat3(-3.0, 1.0, -5.0, 4.0, -6.0, 6.0, 1.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3(var[2][3][1], mat3(5.0, 0.0, 0.0, -4.0, 5.0, -5.0, 4.0, 3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3(-6.0, 9.0, 1.0, 4.0, -8.0, 5.0, 7.0, 2.0, 2.0));
	var[0][0][1] = (mat3(8.0, -8.0, -2.0, 2.0, 8.0, 4.0, 2.0, 1.0, 7.0));
	var[0][1][0] = (mat3(3.0, 5.0, -9.0, 5.0, -8.0, -3.0, -5.0, -7.0, -7.0));
	var[0][1][1] = (mat3(0.0, -4.0, 7.0, 4.0, -5.0, 4.0, 7.0, -1.0, -1.0));
	var[0][2][0] = (mat3(-1.0, -3.0, 0.0, -4.0, -7.0, -5.0, 9.0, -1.0, -7.0));
	var[0][2][1] = (mat3(5.0, -8.0, 9.0, -7.0, 9.0, -8.0, -5.0, 9.0, 2.0));
	var[0][3][0] = (mat3(-6.0, -1.0, 0.0, -3.0, 8.0, -1.0, 6.0, 0.0, -6.0));
	var[0][3][1] = (mat3(9.0, 2.0, 4.0, 2.0, 8.0, -1.0, 0.0, -8.0, -9.0));
	var[1][0][0] = (mat3(-2.0, 5.0, 7.0, 4.0, 7.0, -3.0, 9.0, 1.0, 9.0));
	var[1][0][1] = (mat3(2.0, 1.0, 2.0, -5.0, 4.0, 1.0, 4.0, 3.0, -1.0));
	var[1][1][0] = (mat3(9.0, 7.0, -8.0, -9.0, 3.0, 9.0, 5.0, -5.0, -7.0));
	var[1][1][1] = (mat3(-6.0, -7.0, -2.0, 3.0, 2.0, -9.0, 1.0, -7.0, 3.0));
	var[1][2][0] = (mat3(1.0, 9.0, -9.0, -1.0, 3.0, -5.0, -4.0, -9.0, -8.0));
	var[1][2][1] = (mat3(-9.0, 2.0, -4.0, -6.0, -2.0, 6.0, 4.0, 3.0, 0.0));
	var[1][3][0] = (mat3(-3.0, -9.0, 2.0, -3.0, 0.0, -5.0, -7.0, 7.0, -2.0));
	var[1][3][1] = (mat3(-8.0, 6.0, -6.0, 7.0, -9.0, -1.0, -7.0, 3.0, -2.0));
	var[2][0][0] = (mat3(-6.0, -8.0, 4.0, 3.0, -3.0, 0.0, -1.0, -8.0, -9.0));
	var[2][0][1] = (mat3(2.0, -3.0, 9.0, -8.0, -3.0, -5.0, 1.0, -9.0, 1.0));
	var[2][1][0] = (mat3(2.0, 4.0, 1.0, 6.0, -2.0, 6.0, 2.0, 0.0, 3.0));
	var[2][1][1] = (mat3(-8.0, 3.0, 6.0, -4.0, -9.0, -9.0, 5.0, -9.0, -1.0));
	var[2][2][0] = (mat3(-1.0, -8.0, -2.0, -5.0, 5.0, -8.0, -3.0, 4.0, -4.0));
	var[2][2][1] = (mat3(-5.0, 2.0, 5.0, 6.0, 7.0, 9.0, 1.0, -2.0, -9.0));
	var[2][3][0] = (mat3(6.0, -4.0, 4.0, 1.0, -6.0, -5.0, 0.0, 0.0, -2.0));
	var[2][3][1] = (mat3(2.0, -2.0, 2.0, 5.0, 1.0, -4.0, 3.0, 5.0, -2.0));
}
#version 450
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
	highp mat2x4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0][0][0], mat2x4(5.0, -9.0, 4.0, 8.0, -1.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(-7.0, 1.0, 3.0, -8.0, 0.0, -7.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(-2.0, -5.0, 5.0, -9.0, -6.0, 9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(-3.0, 4.0, -4.0, -3.0, 7.0, 7.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[0][2][0], mat2x4(-7.0, -3.0, 7.0, -3.0, 8.0, 3.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[0][2][1], mat2x4(8.0, 0.0, -1.0, 2.0, 2.0, -8.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[0][3][0], mat2x4(5.0, -7.0, 7.0, 2.0, 1.0, -3.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[0][3][1], mat2x4(5.0, -1.0, 6.0, -9.0, -1.0, 6.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(8.0, 3.0, 1.0, -5.0, 2.0, 6.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(-7.0, 0.0, -7.0, -6.0, -8.0, -6.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(-5.0, -3.0, -3.0, -4.0, -9.0, 2.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(-4.0, 0.0, -1.0, 2.0, 8.0, 9.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[1][2][0], mat2x4(-5.0, 6.0, 6.0, 8.0, -9.0, 0.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[1][2][1], mat2x4(-5.0, 5.0, -1.0, 2.0, -3.0, -1.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[1][3][0], mat2x4(-8.0, -2.0, -9.0, 0.0, 5.0, -8.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[1][3][1], mat2x4(-3.0, 3.0, -7.0, 1.0, 1.0, 1.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(-9.0, 7.0, 5.0, 2.0, -3.0, -8.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(-5.0, 4.0, 5.0, -3.0, -7.0, -9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(5.0, 1.0, 5.0, 8.0, -4.0, -5.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(1.0, 9.0, -1.0, 1.0, -2.0, -4.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[2][2][0], mat2x4(-5.0, 8.0, 6.0, 1.0, 3.0, 9.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[2][2][1], mat2x4(-8.0, -3.0, 1.0, -2.0, 5.0, 3.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[2][3][0], mat2x4(4.0, -5.0, 0.0, -6.0, 4.0, -3.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[2][3][1], mat2x4(-9.0, 1.0, 6.0, -4.0, 3.0, -3.0, 8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(-7.0, -1.0, 8.0, 2.0));
	var[0][0][0][1] = (vec4(-1.0, 2.0, 7.0, -9.0));
	var[0][0][1][0] = (vec4(-9.0, -5.0, 4.0, 7.0));
	var[0][0][1][1] = (vec4(5.0, 8.0, -8.0, -8.0));
	var[0][1][0][0] = (vec4(6.0, -1.0, -5.0, 1.0));
	var[0][1][0][1] = (vec4(-1.0, 8.0, 7.0, 6.0));
	var[0][1][1][0] = (vec4(-9.0, 8.0, 2.0, 1.0));
	var[0][1][1][1] = (vec4(9.0, -7.0, 6.0, -8.0));
	var[0][2][0][0] = (vec4(5.0, 0.0, 0.0, -1.0));
	var[0][2][0][1] = (vec4(9.0, 1.0, -4.0, 7.0));
	var[0][2][1][0] = (vec4(8.0, 0.0, -5.0, -4.0));
	var[0][2][1][1] = (vec4(2.0, 1.0, -9.0, 5.0));
	var[0][3][0][0] = (vec4(-8.0, 3.0, -6.0, 6.0));
	var[0][3][0][1] = (vec4(2.0, 1.0, 3.0, -6.0));
	var[0][3][1][0] = (vec4(-1.0, -4.0, -2.0, 6.0));
	var[0][3][1][1] = (vec4(6.0, 2.0, 1.0, 2.0));
	var[1][0][0][0] = (vec4(6.0, -3.0, 7.0, 0.0));
	var[1][0][0][1] = (vec4(4.0, 6.0, -4.0, 0.0));
	var[1][0][1][0] = (vec4(-5.0, 8.0, -9.0, -8.0));
	var[1][0][1][1] = (vec4(7.0, -7.0, -8.0, -6.0));
	var[1][1][0][0] = (vec4(-2.0, -8.0, 6.0, 9.0));
	var[1][1][0][1] = (vec4(5.0, 5.0, -1.0, -1.0));
	var[1][1][1][0] = (vec4(4.0, -3.0, 7.0, -9.0));
	var[1][1][1][1] = (vec4(-3.0, 9.0, 2.0, 6.0));
	var[1][2][0][0] = (vec4(-5.0, 0.0, 5.0, 7.0));
	var[1][2][0][1] = (vec4(8.0, -8.0, 8.0, 1.0));
	var[1][2][1][0] = (vec4(6.0, -3.0, -3.0, -4.0));
	var[1][2][1][1] = (vec4(-9.0, 1.0, 6.0, -4.0));
	var[1][3][0][0] = (vec4(8.0, 9.0, 4.0, -4.0));
	var[1][3][0][1] = (vec4(5.0, -4.0, 9.0, 9.0));
	var[1][3][1][0] = (vec4(-8.0, 6.0, 2.0, 3.0));
	var[1][3][1][1] = (vec4(-1.0, 2.0, 2.0, -7.0));
	var[2][0][0][0] = (vec4(-9.0, -8.0, 1.0, -2.0));
	var[2][0][0][1] = (vec4(7.0, -6.0, -9.0, 9.0));
	var[2][0][1][0] = (vec4(4.0, -6.0, 0.0, -3.0));
	var[2][0][1][1] = (vec4(-7.0, -7.0, 2.0, -1.0));
	var[2][1][0][0] = (vec4(6.0, 1.0, 5.0, -4.0));
	var[2][1][0][1] = (vec4(1.0, -6.0, 2.0, 6.0));
	var[2][1][1][0] = (vec4(-8.0, 7.0, 7.0, -5.0));
	var[2][1][1][1] = (vec4(-8.0, 0.0, -6.0, -4.0));
	var[2][2][0][0] = (vec4(-8.0, -4.0, -9.0, -8.0));
	var[2][2][0][1] = (vec4(-1.0, -1.0, 1.0, -7.0));
	var[2][2][1][0] = (vec4(7.0, -4.0, -6.0, -8.0));
	var[2][2][1][1] = (vec4(-8.0, -1.0, -2.0, 1.0));
	var[2][3][0][0] = (vec4(9.0, 2.0, -3.0, 1.0));
	var[2][3][0][1] = (vec4(5.0, 2.0, -3.0, 3.0));
	var[2][3][1][0] = (vec4(-9.0, -1.0, -7.0, 1.0));
	var[2][3][1][1] = (vec4(1.0, 5.0, -1.0, -3.0));
}
#version 450
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

layout(scalar, binding = 1) buffer Block
{
	bvec4 var[][4][2];
};

bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((var[0][0][0]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((var[0][0][1]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((var[0][1][0]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((var[0][1][1]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((var[0][2][0]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((var[0][2][1]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((var[0][3][0]), bvec4(false, true, false, false)) && allOk;
	allOk = compare_bvec4((var[0][3][1]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((var[1][0][0]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((var[1][0][1]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((var[1][1][0]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((var[1][1][1]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((var[1][2][0]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((var[1][2][1]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((var[1][3][0]), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bvec4((var[1][3][1]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec4((var[2][0][0]), bvec4(false, false, true, true)) && allOk;
	allOk = compare_bvec4((var[2][0][1]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec4((var[2][1][0]), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec4((var[2][1][1]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((var[2][2][0]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((var[2][2][1]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((var[2][3][0]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((var[2][3][1]), bvec4(true, true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (bvec4(true, true, true, false));
	var[0][0][1] = (bvec4(true, false, false, false));
	var[0][1][0] = (bvec4(false, true, true, false));
	var[0][1][1] = (bvec4(true, true, true, false));
	var[0][2][0] = (bvec4(false, true, false, true));
	var[0][2][1] = (bvec4(true, true, true, false));
	var[0][3][0] = (bvec4(false, false, true, true));
	var[0][3][1] = (bvec4(false, false, true, false));
	var[1][0][0] = (bvec4(false, true, true, true));
	var[1][0][1] = (bvec4(true, true, true, false));
	var[1][1][0] = (bvec4(false, false, true, true));
	var[1][1][1] = (bvec4(true, false, true, false));
	var[1][2][0] = (bvec4(false, true, false, false));
	var[1][2][1] = (bvec4(true, false, false, true));
	var[1][3][0] = (bvec4(true, false, false, true));
	var[1][3][1] = (bvec4(true, false, true, false));
	var[2][0][0] = (bvec4(true, false, true, false));
	var[2][0][1] = (bvec4(true, false, false, true));
	var[2][1][0] = (bvec4(true, true, true, true));
	var[2][1][1] = (bvec4(false, true, false, true));
	var[2][2][0] = (bvec4(true, true, true, false));
	var[2][2][1] = (bvec4(true, false, false, false));
	var[2][3][0] = (bvec4(false, true, false, true));
	var[2][3][1] = (bvec4(false, true, true, true));
}
#version 450
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
	highp mat4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0][0][0], mat4(3.0, 0.0, 6.0, 0.0, -6.0, 5.0, 3.0, -4.0, -9.0, -8.0, 9.0, 3.0, 2.0, -9.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(-8.0, 0.0, 1.0, -5.0, -2.0, 1.0, -6.0, -8.0, -1.0, 5.0, -8.0, 0.0, -6.0, 3.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(-4.0, 1.0, 3.0, -2.0, -8.0, -3.0, 0.0, 4.0, -3.0, -4.0, 6.0, -7.0, 5.0, 4.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(5.0, 5.0, 7.0, -7.0, 1.0, -4.0, 9.0, 7.0, 9.0, -2.0, -8.0, 8.0, -2.0, -7.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat4(var[0][2][0], mat4(4.0, 9.0, 6.0, -4.0, -3.0, 3.0, -3.0, 5.0, -3.0, 6.0, -9.0, 2.0, 5.0, 7.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4(var[0][2][1], mat4(-5.0, -3.0, 7.0, -5.0, -5.0, -7.0, -9.0, 5.0, 3.0, -1.0, 9.0, -3.0, 4.0, 8.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[0][3][0], mat4(-9.0, 0.0, -3.0, -3.0, -4.0, -6.0, -9.0, 9.0, 8.0, 6.0, 3.0, -2.0, 1.0, 5.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4(var[0][3][1], mat4(5.0, -4.0, -6.0, -5.0, 7.0, -3.0, 5.0, -5.0, -8.0, 2.0, -5.0, 8.0, 2.0, -1.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(-9.0, -3.0, 4.0, 6.0, 2.0, 3.0, 0.0, 7.0, 9.0, -9.0, -6.0, 8.0, 0.0, -9.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(4.0, -7.0, 1.0, -7.0, -1.0, 5.0, 9.0, -8.0, 2.0, -6.0, 1.0, 7.0, 4.0, 1.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(5.0, 9.0, 4.0, -3.0, 1.0, 9.0, 1.0, 8.0, 6.0, -1.0, -3.0, -2.0, 5.0, -3.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(-5.0, -8.0, 8.0, -5.0, -4.0, -4.0, -8.0, 9.0, -5.0, 5.0, 8.0, -9.0, 2.0, 8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat4(var[1][2][0], mat4(-6.0, -7.0, -9.0, 4.0, 6.0, -4.0, 2.0, -1.0, 9.0, 3.0, -3.0, 3.0, -6.0, 5.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat4(var[1][2][1], mat4(-8.0, -6.0, 5.0, 0.0, -1.0, -7.0, 4.0, 2.0, -1.0, -9.0, 6.0, 4.0, -9.0, -7.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat4(var[1][3][0], mat4(6.0, -2.0, 6.0, -6.0, 6.0, 4.0, 7.0, 9.0, -7.0, -3.0, -4.0, 9.0, 5.0, -8.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat4(var[1][3][1], mat4(-8.0, 1.0, 4.0, -5.0, 3.0, 6.0, -6.0, 7.0, -1.0, -4.0, 7.0, 1.0, -6.0, 5.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(-3.0, 5.0, -7.0, -5.0, -9.0, 3.0, 0.0, 0.0, 3.0, 2.0, -5.0, -8.0, 9.0, 3.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(9.0, -1.0, 6.0, 9.0, 0.0, -6.0, 0.0, 1.0, -1.0, 5.0, -7.0, -8.0, 1.0, -3.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(3.0, 5.0, -4.0, -4.0, -3.0, -5.0, -8.0, -3.0, -6.0, -5.0, 0.0, -6.0, -9.0, -2.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(-1.0, 8.0, 5.0, 0.0, -7.0, -4.0, 7.0, -7.0, 2.0, -4.0, -2.0, -8.0, 5.0, -4.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat4(var[2][2][0], mat4(-3.0, 8.0, -5.0, 2.0, -2.0, -2.0, 9.0, 4.0, 0.0, 3.0, -5.0, 4.0, 0.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat4(var[2][2][1], mat4(7.0, -4.0, 0.0, -2.0, -9.0, -9.0, 0.0, -9.0, 7.0, 9.0, -9.0, -9.0, -8.0, 3.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat4(var[2][3][0], mat4(8.0, 6.0, 6.0, 7.0, 8.0, 4.0, 5.0, 0.0, 6.0, -6.0, 6.0, 7.0, 9.0, -2.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4(var[2][3][1], mat4(4.0, -6.0, -6.0, -8.0, 9.0, 3.0, 8.0, -6.0, -4.0, -5.0, -7.0, -4.0, -7.0, -4.0, 3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4(4.0, 7.0, -2.0, -5.0, 3.0, -6.0, 0.0, -4.0, 2.0, -9.0, -1.0, 6.0, 8.0, 9.0, 5.0, -6.0));
	var[0][0][1] = (mat4(1.0, 3.0, -7.0, -5.0, 5.0, -5.0, -2.0, -4.0, 9.0, 5.0, 2.0, -3.0, -8.0, 2.0, 1.0, 5.0));
	var[0][1][0] = (mat4(4.0, -8.0, -4.0, -7.0, -9.0, 6.0, 9.0, 1.0, 2.0, -8.0, 2.0, 5.0, -6.0, -1.0, -7.0, 3.0));
	var[0][1][1] = (mat4(-9.0, -2.0, 3.0, -9.0, -1.0, -2.0, 6.0, 4.0, 7.0, -4.0, 1.0, -8.0, 4.0, 9.0, -7.0, -6.0));
	var[0][2][0] = (mat4(5.0, 4.0, 4.0, 1.0, 7.0, -5.0, 1.0, 7.0, 8.0, 8.0, 5.0, 4.0, 9.0, -4.0, 9.0, 7.0));
	var[0][2][1] = (mat4(8.0, 7.0, -8.0, 1.0, -7.0, 7.0, 0.0, -2.0, 1.0, -8.0, -2.0, 8.0, -8.0, 9.0, -6.0, -1.0));
	var[0][3][0] = (mat4(4.0, 2.0, -9.0, 1.0, 5.0, -7.0, -4.0, -2.0, -7.0, -5.0, 1.0, -6.0, -8.0, 6.0, -2.0, 4.0));
	var[0][3][1] = (mat4(-4.0, 2.0, -7.0, -3.0, -2.0, 4.0, -5.0, 8.0, -3.0, 2.0, -8.0, -9.0, 0.0, 8.0, 5.0, -5.0));
	var[1][0][0] = (mat4(5.0, 2.0, -1.0, -1.0, 5.0, -5.0, 0.0, 3.0, -6.0, -5.0, -1.0, 3.0, -6.0, -5.0, -7.0, -8.0));
	var[1][0][1] = (mat4(-1.0, 9.0, 8.0, 0.0, -5.0, 0.0, -3.0, -7.0, 8.0, -9.0, -9.0, 0.0, 9.0, -8.0, -8.0, -5.0));
	var[1][1][0] = (mat4(5.0, -2.0, 0.0, 3.0, 4.0, -3.0, 8.0, -1.0, -3.0, 2.0, 7.0, -7.0, 1.0, -2.0, 8.0, -1.0));
	var[1][1][1] = (mat4(-2.0, -6.0, -4.0, 5.0, 6.0, -2.0, 8.0, 8.0, 5.0, -6.0, -4.0, -6.0, -1.0, -3.0, -6.0, 0.0));
	var[1][2][0] = (mat4(-3.0, -5.0, -4.0, -7.0, -9.0, -6.0, -8.0, 6.0, -1.0, 8.0, 0.0, -8.0, -4.0, 4.0, 8.0, -5.0));
	var[1][2][1] = (mat4(-4.0, -9.0, 6.0, 9.0, -4.0, -2.0, -8.0, -8.0, 4.0, 7.0, 3.0, 6.0, -4.0, -3.0, -4.0, 6.0));
	var[1][3][0] = (mat4(-1.0, -9.0, -7.0, 0.0, -9.0, -9.0, 7.0, -8.0, -5.0, -2.0, -2.0, -8.0, 5.0, 1.0, 7.0, -6.0));
	var[1][3][1] = (mat4(-8.0, -1.0, 9.0, 1.0, -8.0, -1.0, -6.0, 2.0, -8.0, -8.0, -9.0, -1.0, -8.0, 1.0, -1.0, 0.0));
	var[2][0][0] = (mat4(5.0, 6.0, -1.0, 7.0, -2.0, 2.0, -7.0, 1.0, 8.0, 0.0, 7.0, 1.0, 2.0, 7.0, 5.0, 0.0));
	var[2][0][1] = (mat4(7.0, -1.0, 8.0, 4.0, -9.0, -9.0, -4.0, 6.0, 9.0, -3.0, 3.0, -9.0, 5.0, -1.0, -2.0, -9.0));
	var[2][1][0] = (mat4(-9.0, -3.0, -7.0, 7.0, 2.0, -7.0, -7.0, 0.0, -5.0, -9.0, 6.0, -3.0, -5.0, -4.0, -4.0, -5.0));
	var[2][1][1] = (mat4(6.0, 9.0, 3.0, -8.0, -3.0, 0.0, -9.0, 2.0, 6.0, 0.0, -4.0, 1.0, 0.0, 2.0, 2.0, 5.0));
	var[2][2][0] = (mat4(7.0, 4.0, 4.0, 3.0, -8.0, -4.0, -4.0, 7.0, -3.0, -4.0, 4.0, -6.0, 2.0, 8.0, 4.0, -7.0));
	var[2][2][1] = (mat4(1.0, 1.0, 6.0, 3.0, 8.0, 2.0, -7.0, 7.0, 9.0, -8.0, 9.0, 0.0, 8.0, 4.0, 8.0, 2.0));
	var[2][3][0] = (mat4(4.0, 8.0, 5.0, 7.0, -8.0, -2.0, 3.0, -9.0, 5.0, -1.0, -6.0, -3.0, -9.0, 9.0, -8.0, 9.0));
	var[2][3][1] = (mat4(2.0, 0.0, 2.0, 2.0, 9.0, -4.0, -4.0, 8.0, -8.0, -2.0, -7.0, 4.0, -1.0, 2.0, -6.0, 1.0));
}
#version 450
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
	highp mat4x3 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0][0][0], mat4x3(7.0, -2.0, 6.0, 3.0, 1.0, -7.0, 1.0, -4.0, 0.0, 9.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(3.0, 2.0, 2.0, 6.0, 6.0, 0.0, 3.0, 6.0, -4.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(-9.0, 0.0, 6.0, -9.0, -9.0, 9.0, 6.0, 9.0, -2.0, 8.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(-8.0, 6.0, 8.0, 4.0, -3.0, -9.0, 9.0, 1.0, 2.0, 8.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[0][2][0], mat4x3(1.0, 8.0, 9.0, 7.0, 0.0, -2.0, -4.0, 7.0, 0.0, -9.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[0][2][1], mat4x3(-9.0, -9.0, -7.0, -5.0, 2.0, 5.0, 0.0, -2.0, -3.0, -6.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[0][3][0], mat4x3(-2.0, 8.0, 2.0, 7.0, 9.0, 8.0, -3.0, 8.0, -9.0, -3.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[0][3][1], mat4x3(0.0, 8.0, 9.0, -9.0, -9.0, 4.0, 1.0, -1.0, 9.0, 0.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(-6.0, -5.0, 4.0, -4.0, 1.0, 2.0, -5.0, 9.0, -7.0, -2.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(-7.0, 1.0, -9.0, 8.0, 8.0, 5.0, 0.0, 5.0, -1.0, 2.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(-4.0, -3.0, 7.0, 7.0, 0.0, -3.0, 5.0, -5.0, -9.0, -3.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(8.0, -2.0, 1.0, 2.0, -3.0, 9.0, 6.0, -5.0, 8.0, -1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[1][2][0], mat4x3(-8.0, -7.0, 9.0, 6.0, 6.0, -5.0, -3.0, 9.0, -4.0, -3.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[1][2][1], mat4x3(-5.0, -8.0, -6.0, 4.0, -5.0, 6.0, 5.0, -8.0, 5.0, -9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[1][3][0], mat4x3(-2.0, -8.0, 7.0, 1.0, 5.0, 7.0, 8.0, -2.0, 4.0, -4.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[1][3][1], mat4x3(6.0, 3.0, 4.0, -2.0, 5.0, 6.0, -9.0, 4.0, 7.0, 7.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(4.0, -2.0, -8.0, -5.0, -8.0, -5.0, -4.0, -1.0, -1.0, -5.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(3.0, 8.0, 5.0, 3.0, -2.0, 8.0, -6.0, -2.0, -8.0, -1.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(-5.0, -7.0, 4.0, 5.0, 7.0, 5.0, 9.0, 4.0, 8.0, 2.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(-8.0, -9.0, -8.0, 2.0, -2.0, 8.0, 4.0, 4.0, -3.0, 2.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[2][2][0], mat4x3(-5.0, -1.0, 5.0, 4.0, -3.0, -3.0, -5.0, 1.0, -4.0, 6.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[2][2][1], mat4x3(0.0, -6.0, -8.0, -7.0, 6.0, -3.0, 0.0, 2.0, -9.0, -7.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[2][3][0], mat4x3(9.0, 9.0, -6.0, -7.0, -9.0, -9.0, 5.0, 9.0, 5.0, 4.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[2][3][1], mat4x3(3.0, 6.0, -3.0, -8.0, -1.0, 5.0, -8.0, -5.0, 3.0, -4.0, -9.0, 6.0)) && allOk;
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
	var[0][1][0][0] = (vec3(9.0, 1.0, -1.0));
	var[0][1][0][1] = (vec3(-1.0, 2.0, 4.0));
	var[0][1][0][2] = (vec3(4.0, 2.0, 0.0));
	var[0][1][0][3] = (vec3(5.0, 6.0, -6.0));
	var[0][1][1][0] = (vec3(-3.0, 7.0, -6.0));
	var[0][1][1][1] = (vec3(7.0, 9.0, 8.0));
	var[0][1][1][2] = (vec3(-9.0, -9.0, -9.0));
	var[0][1][1][3] = (vec3(6.0, -7.0, -3.0));
	var[0][2][0][0] = (vec3(-5.0, 2.0, -4.0));
	var[0][2][0][1] = (vec3(-7.0, -3.0, -4.0));
	var[0][2][0][2] = (vec3(4.0, -3.0, -8.0));
	var[0][2][0][3] = (vec3(-5.0, -1.0, 1.0));
	var[0][2][1][0] = (vec3(6.0, -2.0, 8.0));
	var[0][2][1][1] = (vec3(-7.0, 1.0, 4.0));
	var[0][2][1][2] = (vec3(6.0, 8.0, -5.0));
	var[0][2][1][3] = (vec3(1.0, -6.0, 4.0));
	var[0][3][0][0] = (vec3(-1.0, 7.0, 7.0));
	var[0][3][0][1] = (vec3(3.0, -4.0, -1.0));
	var[0][3][0][2] = (vec3(-4.0, 5.0, 7.0));
	var[0][3][0][3] = (vec3(-5.0, 7.0, 5.0));
	var[0][3][1][0] = (vec3(-1.0, -1.0, 5.0));
	var[0][3][1][1] = (vec3(9.0, 7.0, -5.0));
	var[0][3][1][2] = (vec3(3.0, -1.0, 3.0));
	var[0][3][1][3] = (vec3(8.0, -5.0, 3.0));
	var[1][0][0][0] = (vec3(-4.0, -9.0, 8.0));
	var[1][0][0][1] = (vec3(9.0, 2.0, 2.0));
	var[1][0][0][2] = (vec3(9.0, -7.0, 3.0));
	var[1][0][0][3] = (vec3(8.0, 2.0, 4.0));
	var[1][0][1][0] = (vec3(2.0, 4.0, -3.0));
	var[1][0][1][1] = (vec3(-8.0, 7.0, 3.0));
	var[1][0][1][2] = (vec3(0.0, -8.0, 0.0));
	var[1][0][1][3] = (vec3(6.0, -9.0, 0.0));
	var[1][1][0][0] = (vec3(7.0, -1.0, -4.0));
	var[1][1][0][1] = (vec3(-9.0, 0.0, -1.0));
	var[1][1][0][2] = (vec3(-7.0, -2.0, -3.0));
	var[1][1][0][3] = (vec3(1.0, 4.0, 5.0));
	var[1][1][1][0] = (vec3(9.0, 8.0, 7.0));
	var[1][1][1][1] = (vec3(5.0, 4.0, 7.0));
	var[1][1][1][2] = (vec3(3.0, -3.0, 4.0));
	var[1][1][1][3] = (vec3(3.0, -6.0, 5.0));
	var[1][2][0][0] = (vec3(-9.0, 3.0, -3.0));
	var[1][2][0][1] = (vec3(0.0, -5.0, -3.0));
	var[1][2][0][2] = (vec3(-5.0, -8.0, 3.0));
	var[1][2][0][3] = (vec3(3.0, -6.0, 8.0));
	var[1][2][1][0] = (vec3(-3.0, 5.0, 6.0));
	var[1][2][1][1] = (vec3(5.0, -1.0, 6.0));
	var[1][2][1][2] = (vec3(8.0, 7.0, 1.0));
	var[1][2][1][3] = (vec3(-5.0, 6.0, -6.0));
	var[1][3][0][0] = (vec3(-6.0, 1.0, 0.0));
	var[1][3][0][1] = (vec3(8.0, -8.0, 5.0));
	var[1][3][0][2] = (vec3(-3.0, 5.0, -4.0));
	var[1][3][0][3] = (vec3(-3.0, -2.0, 2.0));
	var[1][3][1][0] = (vec3(-5.0, 3.0, -6.0));
	var[1][3][1][1] = (vec3(-6.0, -4.0, -2.0));
	var[1][3][1][2] = (vec3(-5.0, -2.0, -2.0));
	var[1][3][1][3] = (vec3(-8.0, 2.0, 4.0));
	var[2][0][0][0] = (vec3(-4.0, 5.0, 5.0));
	var[2][0][0][1] = (vec3(-7.0, -8.0, -1.0));
	var[2][0][0][2] = (vec3(6.0, -3.0, -5.0));
	var[2][0][0][3] = (vec3(0.0, 8.0, -8.0));
	var[2][0][1][0] = (vec3(-4.0, 4.0, 8.0));
	var[2][0][1][1] = (vec3(-4.0, -4.0, -3.0));
	var[2][0][1][2] = (vec3(3.0, 3.0, 2.0));
	var[2][0][1][3] = (vec3(8.0, -8.0, -6.0));
	var[2][1][0][0] = (vec3(-8.0, -4.0, -9.0));
	var[2][1][0][1] = (vec3(4.0, 8.0, -3.0));
	var[2][1][0][2] = (vec3(-9.0, 7.0, -2.0));
	var[2][1][0][3] = (vec3(0.0, -3.0, -3.0));
	var[2][1][1][0] = (vec3(4.0, -2.0, -4.0));
	var[2][1][1][1] = (vec3(-5.0, -7.0, 1.0));
	var[2][1][1][2] = (vec3(-8.0, 1.0, 9.0));
	var[2][1][1][3] = (vec3(-8.0, 0.0, -2.0));
	var[2][2][0][0] = (vec3(-3.0, -7.0, 7.0));
	var[2][2][0][1] = (vec3(-9.0, -3.0, 6.0));
	var[2][2][0][2] = (vec3(0.0, -7.0, 3.0));
	var[2][2][0][3] = (vec3(2.0, -7.0, 1.0));
	var[2][2][1][0] = (vec3(8.0, -1.0, -9.0));
	var[2][2][1][1] = (vec3(8.0, 8.0, 2.0));
	var[2][2][1][2] = (vec3(7.0, -5.0, -2.0));
	var[2][2][1][3] = (vec3(-9.0, 6.0, 2.0));
	var[2][3][0][0] = (vec3(-1.0, -1.0, 1.0));
	var[2][3][0][1] = (vec3(-9.0, -7.0, -8.0));
	var[2][3][0][2] = (vec3(-8.0, -5.0, -1.0));
	var[2][3][0][3] = (vec3(2.0, 0.0, -4.0));
	var[2][3][1][0] = (vec3(7.0, 6.0, 4.0));
	var[2][3][1][1] = (vec3(-5.0, -5.0, 8.0));
	var[2][3][1][2] = (vec3(-3.0, 4.0, -5.0));
	var[2][3][1][3] = (vec3(-8.0, 5.0, -2.0));
}
#version 450
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
layout(std430, binding = 1) buffer Block
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
	allOk = compare_uvec2((s[0].a), uvec2(0u, 6u)) && allOk;
	allOk = compare_mat2x4(s[0].b[0], mat2x4(8.0, 2.0, -7.0, -2.0, -2.0, -2.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2x4(s[0].b[1], mat2x4(7.0, 5.0, -8.0, -8.0, -3.0, 0.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat2x4(s[0].b[2], mat2x4(1.0, -6.0, 4.0, -9.0, 3.0, -7.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat2x4(s[0].b[3], mat2x4(-1.0, 6.0, -1.0, -3.0, -4.0, -8.0, -7.0, -8.0)) && allOk;
	allOk = compare_vec3((s[0].c), vec3(7.0, 1.0, 0.0)) && allOk;
	allOk = compare_uvec2((s[1].a), uvec2(5u, 2u)) && allOk;
	allOk = compare_mat2x4(s[1].b[0], mat2x4(-6.0, 3.0, -4.0, 1.0, 1.0, -7.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat2x4(s[1].b[1], mat2x4(5.0, 5.0, -9.0, 3.0, -1.0, -5.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x4(s[1].b[2], mat2x4(-7.0, 8.0, -3.0, 1.0, -5.0, 8.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat2x4(s[1].b[3], mat2x4(-6.0, 3.0, 0.0, -6.0, 8.0, -5.0, -8.0, 1.0)) && allOk;
	allOk = compare_vec3((s[1].c), vec3(-2.0, -5.0, 9.0)) && allOk;
	allOk = compare_uvec2((s[2].a), uvec2(8u, 0u)) && allOk;
	allOk = compare_mat2x4(s[2].b[0], mat2x4(-6.0, -6.0, -4.0, 9.0, 2.0, -1.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat2x4(s[2].b[1], mat2x4(7.0, -5.0, -5.0, -6.0, 2.0, -4.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat2x4(s[2].b[2], mat2x4(-5.0, 7.0, -1.0, 6.0, 7.0, 5.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(s[2].b[3], mat2x4(-6.0, 4.0, 1.0, -6.0, 4.0, -1.0, -9.0, -3.0)) && allOk;
	allOk = compare_vec3((s[2].c), vec3(-7.0, 5.0, 3.0)) && allOk;
	allOk = compare_uvec2((s[3].a), uvec2(4u, 1u)) && allOk;
	allOk = compare_mat2x4(s[3].b[0], mat2x4(1.0, 4.0, -6.0, -9.0, -1.0, 1.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat2x4(s[3].b[1], mat2x4(-6.0, -3.0, -6.0, -4.0, -3.0, -8.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat2x4(s[3].b[2], mat2x4(6.0, -9.0, 9.0, 7.0, -1.0, 6.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat2x4(s[3].b[3], mat2x4(0.0, 0.0, -1.0, 5.0, 8.0, 9.0, 8.0, 4.0)) && allOk;
	allOk = compare_vec3((s[3].c), vec3(2.0, -5.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	v = (3u);
	s[0].a = (uvec2(0u, 6u));
	s[0].b[0][0] = (vec4(2.0, -5.0, 0.0, -7.0));
	s[0].b[0][1] = (vec4(9.0, 9.0, -1.0, -4.0));
	s[0].b[1][0] = (vec4(4.0, -4.0, 9.0, 8.0));
	s[0].b[1][1] = (vec4(0.0, -8.0, -7.0, -1.0));
	s[0].b[2][0] = (vec4(-1.0, -7.0, -3.0, 6.0));
	s[0].b[2][1] = (vec4(-5.0, 4.0, -9.0, 3.0));
	s[0].b[3][0] = (vec4(-6.0, 1.0, -5.0, 9.0));
	s[0].b[3][1] = (vec4(1.0, 4.0, -5.0, -1.0));
	s[0].c = (vec3(6.0, 5.0, -9.0));
	s[1].a = (uvec2(1u, 2u));
	s[1].b[0][0] = (vec4(8.0, -9.0, 7.0, -4.0));
	s[1].b[0][1] = (vec4(3.0, 9.0, 8.0, 5.0));
	s[1].b[1][0] = (vec4(-9.0, 2.0, -5.0, 0.0));
	s[1].b[1][1] = (vec4(2.0, -3.0, -6.0, -9.0));
	s[1].b[2][0] = (vec4(-6.0, 6.0, -3.0, -5.0));
	s[1].b[2][1] = (vec4(5.0, -2.0, -5.0, 7.0));
	s[1].b[3][0] = (vec4(-7.0, 5.0, -1.0, 3.0));
	s[1].b[3][1] = (vec4(-5.0, 1.0, -5.0, -7.0));
	s[1].c = (vec3(-1.0, 5.0, -6.0));
	s[2].a = (uvec2(7u, 8u));
	s[2].b[0][0] = (vec4(-4.0, -7.0, -4.0, -3.0));
	s[2].b[0][1] = (vec4(-4.0, 7.0, 2.0, -3.0));
	s[2].b[1][0] = (vec4(2.0, 2.0, 1.0, 2.0));
	s[2].b[1][1] = (vec4(-7.0, -6.0, -8.0, 6.0));
	s[2].b[2][0] = (vec4(3.0, 0.0, 5.0, -9.0));
	s[2].b[2][1] = (vec4(2.0, -3.0, -7.0, -2.0));
	s[2].b[3][0] = (vec4(8.0, 6.0, -2.0, -3.0));
	s[2].b[3][1] = (vec4(2.0, 4.0, -7.0, 7.0));
	s[2].c = (vec3(-2.0, -1.0, 6.0));
	s[3].a = (uvec2(9u, 9u));
	s[3].b[0][0] = (vec4(-7.0, -7.0, -8.0, 5.0));
	s[3].b[0][1] = (vec4(5.0, -1.0, -2.0, -1.0));
	s[3].b[1][0] = (vec4(-8.0, -9.0, 2.0, -2.0));
	s[3].b[1][1] = (vec4(6.0, 4.0, -2.0, -6.0));
	s[3].b[2][0] = (vec4(7.0, -1.0, 7.0, 0.0));
	s[3].b[2][1] = (vec4(-6.0, -8.0, 8.0, 9.0));
	s[3].b[3][0] = (vec4(-6.0, -9.0, -9.0, 1.0));
	s[3].b[3][1] = (vec4(-9.0, -8.0, -2.0, 5.0));
	s[3].c = (vec3(-4.0, -4.0, -7.0));
}
#version 450
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
layout(std140, binding = 1) buffer Block
{
	lowp uint u;
	mediump vec4 v;
	S s[][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((s[0][0].a), ivec3(2, -3, -1)) && allOk;
	allOk = compare_vec4((s[0][0].c), vec4(4.0, 9.0, -9.0, 8.0)) && allOk;
	allOk = compare_ivec3((s[0][1].a), ivec3(-8, -3, 2)) && allOk;
	allOk = compare_vec4((s[0][1].c), vec4(0.0, 9.0, 9.0, -8.0)) && allOk;
	allOk = compare_ivec3((s[1][0].a), ivec3(-8, 8, 3)) && allOk;
	allOk = compare_vec4((s[1][0].c), vec4(0.0, 7.0, 8.0, -1.0)) && allOk;
	allOk = compare_ivec3((s[1][1].a), ivec3(8, 9, -8)) && allOk;
	allOk = compare_vec4((s[1][1].c), vec4(1.0, 3.0, -5.0, 3.0)) && allOk;
	allOk = compare_ivec3((s[2][0].a), ivec3(-2, -7, -1)) && allOk;
	allOk = compare_vec4((s[2][0].c), vec4(-2.0, -1.0, -6.0, 9.0)) && allOk;
	allOk = compare_ivec3((s[2][1].a), ivec3(-7, -4, 4)) && allOk;
	allOk = compare_vec4((s[2][1].c), vec4(2.0, -9.0, 7.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	v = (vec4(-3.0, -2.0, -3.0, 0.0));
	s[0][0].a = (ivec3(2, -7, 0));
	s[0][0].c = (vec4(9.0, 8.0, 4.0, 0.0));
	s[0][1].a = (ivec3(-1, -1, 6));
	s[0][1].c = (vec4(2.0, 2.0, -9.0, -5.0));
	s[1][0].a = (ivec3(-8, 0, -4));
	s[1][0].c = (vec4(-6.0, -4.0, -6.0, 7.0));
	s[1][1].a = (ivec3(6, -5, -5));
	s[1][1].c = (vec4(-5.0, 1.0, -2.0, 9.0));
	s[2][0].a = (ivec3(-7, 9, -3));
	s[2][0].c = (vec4(-5.0, 4.0, -2.0, 4.0));
	s[2][1].a = (ivec3(3, -6, 5));
	s[2][1].c = (vec4(-9.0, 4.0, 1.0, 6.0));
}
#version 450
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
	allOk = compare_uint((block[0].u), 7u) && allOk;
	allOk = compare_mat4x3(block[0].t[0].a, mat4x3(1.0, 4.0, 9.0, 2.0, -8.0, 4.0, 8.0, 5.0, 8.0, 7.0, -6.0, 1.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[0].a), uvec3(8u, 6u, 4u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[0]), vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[1]), vec2(-7.0, 1.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[2]), vec2(7.0, 4.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[3]), vec2(6.0, 4.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[0].c), vec4(-3.0, -2.0, -2.0, -1.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[1].a), uvec3(2u, 4u, 0u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[0]), vec2(-5.0, 7.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[1]), vec2(5.0, 6.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[2]), vec2(-8.0, 2.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[3]), vec2(-8.0, -5.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[1].c), vec4(-1.0, 9.0, 6.0, 0.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[2].a), uvec3(8u, 2u, 3u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[0]), vec2(-6.0, -8.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[1]), vec2(-5.0, -5.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[2]), vec2(-6.0, -4.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[3]), vec2(8.0, 2.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[2].c), vec4(-2.0, -7.0, -3.0, -3.0)) && allOk;
	allOk = compare_int((block[0].t[0].c), -6) && allOk;
	allOk = compare_mat4x3(block[0].t[1].a, mat4x3(1.0, -3.0, -2.0, 0.0, 6.0, -9.0, 9.0, 3.0, -1.0, 4.0, -3.0, -2.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[0].a), uvec3(7u, 8u, 2u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[0]), vec2(-7.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[1]), vec2(8.0, 5.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[2]), vec2(5.0, -4.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[3]), vec2(8.0, 0.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[0].c), vec4(-7.0, -5.0, -7.0, 6.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[1].a), uvec3(9u, 8u, 7u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[0]), vec2(2.0, 5.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[1]), vec2(-8.0, -3.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[2]), vec2(-9.0, 6.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[3]), vec2(9.0, -6.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[1].c), vec4(-4.0, 9.0, -2.0, 8.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[2].a), uvec3(3u, 4u, 6u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[0]), vec2(5.0, -7.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[1]), vec2(3.0, 1.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[2]), vec2(0.0, 3.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[3]), vec2(6.0, -1.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[2].c), vec4(0.0, 4.0, -2.0, 9.0)) && allOk;
	allOk = compare_int((block[0].t[1].c), 5) && allOk;
	allOk = compare_mat4x3(block[0].t[2].a, mat4x3(-9.0, 4.0, -4.0, 7.0, -4.0, 7.0, 6.0, -2.0, -3.0, 6.0, -6.0, 0.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[0].a), uvec3(9u, 9u, 5u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[0]), vec2(8.0, -6.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[1]), vec2(7.0, 3.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[2]), vec2(-3.0, 5.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[3]), vec2(9.0, 4.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[0].c), vec4(-9.0, 0.0, 9.0, 3.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[1].a), uvec3(5u, 9u, 6u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[0]), vec2(-8.0, 9.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[1]), vec2(8.0, -8.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[2]), vec2(-7.0, -6.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[3]), vec2(-9.0, 1.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[1].c), vec4(-1.0, -9.0, 7.0, 8.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[2].a), uvec3(1u, 8u, 2u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[0]), vec2(-5.0, 5.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[1]), vec2(-9.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[2]), vec2(4.0, 3.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[3]), vec2(2.0, 5.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[2].c), vec4(-8.0, -1.0, -7.0, 6.0)) && allOk;
	allOk = compare_int((block[0].t[2].c), 6) && allOk;
	allOk = compare_mat4x3(block[0].t[3].a, mat4x3(6.0, -3.0, -1.0, 4.0, -2.0, 1.0, -5.0, -9.0, 3.0, -9.0, 3.0, 0.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[0].a), uvec3(1u, 6u, 5u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[0]), vec2(1.0, 3.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[1]), vec2(4.0, -9.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[2]), vec2(-8.0, 1.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[3]), vec2(-2.0, -6.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[0].c), vec4(7.0, -7.0, -7.0, 5.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[1].a), uvec3(8u, 0u, 0u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[0]), vec2(1.0, -4.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[1]), vec2(-3.0, 5.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[2]), vec2(-8.0, 0.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[3]), vec2(0.0, 6.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[1].c), vec4(-3.0, -2.0, 4.0, 5.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[2].a), uvec3(6u, 7u, 2u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[0]), vec2(-8.0, -3.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[1]), vec2(-6.0, 7.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[2]), vec2(-9.0, 1.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[3]), vec2(-3.0, -2.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[2].c), vec4(5.0, -2.0, -1.0, 5.0)) && allOk;
	allOk = compare_int((block[0].t[3].c), 6) && allOk;
	allOk = compare_uint((block[1].u), 3u) && allOk;
	allOk = compare_mat4x3(block[1].t[0].a, mat4x3(2.0, -2.0, 4.0, 1.0, -1.0, -1.0, -4.0, 7.0, -8.0, -2.0, -3.0, 4.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[0].a), uvec3(6u, 2u, 2u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[0]), vec2(-3.0, 0.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[1]), vec2(4.0, 0.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[2]), vec2(-6.0, 4.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[3]), vec2(-1.0, -9.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[0].c), vec4(5.0, -2.0, -9.0, 0.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[1].a), uvec3(9u, 5u, 5u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[0]), vec2(5.0, -8.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[1]), vec2(-2.0, -9.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[2]), vec2(1.0, 8.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[3]), vec2(3.0, 1.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[1].c), vec4(-3.0, 6.0, -1.0, 8.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[2].a), uvec3(7u, 8u, 1u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[0]), vec2(-9.0, 2.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[1]), vec2(3.0, -6.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[2]), vec2(-1.0, -6.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[3]), vec2(-9.0, -2.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[2].c), vec4(-8.0, -3.0, 1.0, 3.0)) && allOk;
	allOk = compare_int((block[1].t[0].c), -3) && allOk;
	allOk = compare_uint((block[2].u), 1u) && allOk;
	allOk = compare_mat4x3(block[2].t[0].a, mat4x3(-3.0, -4.0, 9.0, 4.0, 6.0, -6.0, -5.0, 8.0, 7.0, 1.0, 9.0, -7.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[0].a), uvec3(3u, 9u, 5u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[0]), vec2(-6.0, -2.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[1]), vec2(-6.0, -9.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[2]), vec2(-7.0, 8.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[3]), vec2(4.0, 4.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[0].c), vec4(9.0, -8.0, 6.0, -5.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[1].a), uvec3(1u, 0u, 0u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[0]), vec2(-8.0, -9.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[1]), vec2(0.0, 2.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[2]), vec2(2.0, 4.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[3]), vec2(1.0, 4.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[1].c), vec4(-5.0, -5.0, -7.0, -7.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[2].a), uvec3(2u, 2u, 7u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[0]), vec2(-9.0, 1.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[1]), vec2(0.0, 6.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[2]), vec2(6.0, 5.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[3]), vec2(7.0, 2.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[2].c), vec4(-1.0, 9.0, 4.0, 1.0)) && allOk;
	allOk = compare_int((block[2].t[0].c), 8) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (uvec3(4u, 6u, 9u));
	block[0].s.b[0] = (vec2(1.0, 8.0));
	block[0].s.b[1] = (vec2(-1.0, 4.0));
	block[0].s.b[2] = (vec2(-7.0, 5.0));
	block[0].s.b[3] = (vec2(5.0, 1.0));
	block[0].s.c = (vec4(-2.0, 7.0, 4.0, 3.0));
	block[0].u = (4u);
	block[1].s.a = (uvec3(9u, 2u, 0u));
	block[1].s.b[0] = (vec2(8.0, 9.0));
	block[1].s.b[1] = (vec2(8.0, -7.0));
	block[1].s.b[2] = (vec2(-1.0, -1.0));
	block[1].s.b[3] = (vec2(-8.0, 7.0));
	block[1].s.c = (vec4(-6.0, -9.0, -9.0, 2.0));
	block[1].u = (2u);
	block[2].s.a = (uvec3(5u, 7u, 6u));
	block[2].s.b[0] = (vec2(-9.0, 8.0));
	block[2].s.b[1] = (vec2(-5.0, 3.0));
	block[2].s.b[2] = (vec2(1.0, -1.0));
	block[2].s.b[3] = (vec2(3.0, 5.0));
	block[2].s.c = (vec4(-2.0, 1.0, -3.0, -4.0));
	block[2].u = (4u);
}
#version 450
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
	allOk = compare_float(block[0].var[0][0], -5.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 7.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -1.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -4.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 8.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -1.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(-5.0, 7.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(-1.0, -4.0)) && allOk;
	allOk = compare_vec2(block[0].var[2], vec2(8.0, -1.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], -5.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 7.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -4.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -3.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 4.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 2.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(-5.0, 7.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(-4.0, -3.0)) && allOk;
	allOk = compare_vec2(block[1].var[2], vec2(4.0, 2.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 8.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -3.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 3.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -5.0) && allOk;
	allOk = compare_float(block[2].var[2][0], -3.0) && allOk;
	allOk = compare_float(block[2].var[2][1], -6.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(8.0, -3.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(3.0, -5.0)) && allOk;
	allOk = compare_vec2(block[2].var[2], vec2(-3.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec2(-8.0, -4.0));
	block[0].var[1] = (vec2(-3.0, 5.0));
	block[0].var[2] = (vec2(-9.0, 4.0));
	block[1].var[0] = (vec2(-2.0, -1.0));
	block[1].var[1] = (vec2(8.0, 3.0));
	block[1].var[2] = (vec2(7.0, 2.0));
	block[2].var[0] = (vec2(-4.0, 4.0));
	block[2].var[1] = (vec2(3.0, -6.0));
	block[2].var[2] = (vec2(-4.0, 3.0));
}
#version 450
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
	bvec2 a;
	highp mat3x4 b;
	bvec4 c[];
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	lowp vec4 d[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.c[0]), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bvec4((blockB.c[1]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((blockB.c[2]), bvec4(false, false, false, false)) && allOk;
	allOk = compare_bvec4((blockB.c[3]), bvec4(false, false, true, true)) && allOk;
	allOk = compare_bvec4((blockB.c[4]), bvec4(false, true, false, false)) && allOk;
	allOk = compare_vec4((blockC.d[0]), vec4(1.0, 6.0, -4.0, 8.0)) && allOk;
	allOk = compare_vec4((blockC.d[1]), vec4(-4.0, -1.0, -9.0, -5.0)) && allOk;
	allOk = compare_vec4((blockC.d[2]), vec4(5.0, -5.0, -4.0, -6.0)) && allOk;
	allOk = compare_vec4((blockC.d[3]), vec4(-4.0, 8.0, 9.0, -8.0)) && allOk;
	allOk = compare_vec4((blockC.d[4]), vec4(2.0, 9.0, 1.0, 6.0)) && allOk;
	allOk = compare_vec4((blockC.d[5]), vec4(8.0, 0.0, -6.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, false));
	blockB.b = (mat3x4(-5.0, -4.0, 5.0, -9.0, 8.0, 1.0, 9.0, 5.0, -4.0, -9.0, -3.0, 7.0));
	blockB.c[0] = (bvec4(true, true, false, false));
	blockB.c[1] = (bvec4(false, false, true, false));
	blockB.c[2] = (bvec4(true, false, true, false));
	blockB.c[3] = (bvec4(false, false, true, false));
	blockB.c[4] = (bvec4(true, true, false, true));
	blockC.d[0] = (vec4(1.0, 4.0, 3.0, -9.0));
	blockC.d[1] = (vec4(-3.0, 8.0, 5.0, 8.0));
	blockC.d[2] = (vec4(1.0, 8.0, 9.0, 2.0));
	blockC.d[3] = (vec4(7.0, -2.0, -9.0, -9.0));
	blockC.d[4] = (vec4(7.0, 3.0, -9.0, 1.0));
	blockC.d[5] = (vec4(-8.0, -6.0, -7.0, 3.0));
}
#version 450
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
	bvec4 a;
	highp uvec2 b[];
};
layout(std430, column_major, binding = 2) buffer BlockC
{
	mediump vec4 c;
	bvec2 d;
	mediump float e[];
} blockC;
layout(std430, column_major, binding = 3) buffer BlockD
{
	mediump mat3 f;
	lowp ivec4 g;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockC.c), vec4(9.0, 7.0, -8.0, 1.0)) && allOk;
	allOk = compare_float((blockC.e[0]), -7.0) && allOk;
	allOk = compare_float((blockC.e[1]), 7.0) && allOk;
	allOk = compare_float((blockC.e[2]), -5.0) && allOk;
	allOk = compare_float((blockC.e[3]), 8.0) && allOk;
	allOk = compare_float((blockC.e[4]), -5.0) && allOk;
	allOk = compare_float((blockC.e[5]), 7.0) && allOk;
	allOk = compare_mat3(blockD.f, mat3(-8.0, -4.0, -3.0, 5.0, 0.0, -2.0, 3.0, 0.0, 8.0)) && allOk;
	allOk = compare_ivec4((blockD.g), ivec4(-4, -1, 6, -7)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec4(true, false, true, true));
	b[0] = (uvec2(2u, 9u));
	b[1] = (uvec2(4u, 3u));
	b[2] = (uvec2(9u, 4u));
	b[3] = (uvec2(7u, 9u));
	blockC.d = (bvec2(false, false));
	blockD.g = (ivec4(-1, 9, -8, 6));
}
#version 450
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
	mediump vec4 a;
	highp uvec4 b;
	highp mat3 c;
	mediump vec3 d;
	bvec2 e[];
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	lowp uvec3 f;
	mediump vec4 g;
	lowp vec2 h;
	mediump uvec4 i[1][8];
	bvec4 j[];
};
layout(std430, row_major, binding = 3) buffer BlockD
{
	mediump mat3x2 k;
	bool l;
	bool m;
	lowp mat3x4 n;
	mediump vec4 o[];
} blockD;
layout(std430, column_major, binding = 4) buffer BlockE
{
	lowp uint p;
	lowp mat2x3 q;
	highp int r;
	highp ivec4 s[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((a), vec4(-8.0, -8.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3(c, mat3(-2.0, -5.0, 1.0, 5.0, 1.0, -6.0, 9.0, 8.0, 3.0)) && allOk;
	allOk = compare_vec3((d), vec3(7.0, 5.0, -6.0)) && allOk;
	allOk = compare_bvec2((e[0]), bvec2(true, true)) && allOk;
	allOk = compare_uvec3((f), uvec3(1u, 6u, 4u)) && allOk;
	allOk = compare_uvec4((i[0][0]), uvec4(5u, 3u, 8u, 6u)) && allOk;
	allOk = compare_uvec4((i[0][1]), uvec4(8u, 2u, 0u, 9u)) && allOk;
	allOk = compare_uvec4((i[0][2]), uvec4(9u, 7u, 5u, 1u)) && allOk;
	allOk = compare_uvec4((i[0][3]), uvec4(9u, 6u, 1u, 3u)) && allOk;
	allOk = compare_uvec4((i[0][4]), uvec4(9u, 6u, 5u, 7u)) && allOk;
	allOk = compare_uvec4((i[0][5]), uvec4(2u, 3u, 0u, 8u)) && allOk;
	allOk = compare_uvec4((i[0][6]), uvec4(4u, 0u, 2u, 9u)) && allOk;
	allOk = compare_uvec4((i[0][7]), uvec4(8u, 6u, 6u, 2u)) && allOk;
	allOk = compare_bvec4((j[0]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((j[1]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((j[2]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((j[3]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((j[4]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec4((j[5]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec4((j[6]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((j[7]), bvec4(false, false, true, true)) && allOk;
	allOk = compare_bool((blockD.l), true) && allOk;
	allOk = compare_vec4((blockD.o[0]), vec4(-7.0, 0.0, 4.0, 4.0)) && allOk;
	allOk = compare_vec4((blockD.o[1]), vec4(-9.0, -9.0, -3.0, 1.0)) && allOk;
	allOk = compare_vec4((blockD.o[2]), vec4(9.0, 0.0, -1.0, 1.0)) && allOk;
	allOk = compare_vec4((blockD.o[3]), vec4(5.0, 6.0, -4.0, 8.0)) && allOk;
	allOk = compare_uint((blockE.p), 3u) && allOk;
	allOk = compare_int((blockE.r), -9) && allOk;
	allOk = compare_ivec4((blockE.s[0]), ivec4(-2, 2, -8, 0)) && allOk;
	allOk = compare_ivec4((blockE.s[1]), ivec4(-1, 9, 1, 0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec4(-2.0, -9.0, -3.0, -1.0));
	b = (uvec4(5u, 6u, 5u, 8u));
	c = (mat3(-5.0, -9.0, 4.0, -6.0, 2.0, 6.0, 4.0, 6.0, -5.0));
	d = (vec3(2.0, -9.0, -8.0));
	f = (uvec3(8u, 3u, 9u));
	g = (vec4(3.0, 7.0, -8.0, -2.0));
	blockD.k = (mat3x2(4.0, -7.0, 8.0, -3.0, -9.0, -7.0));
	blockD.l = (false);
	blockD.m = (true);
	blockD.o[0] = (vec4(-3.0, 2.0, 4.0, 3.0));
	blockD.o[1] = (vec4(-1.0, -4.0, 9.0, 3.0));
	blockD.o[2] = (vec4(8.0, -2.0, 5.0, 7.0));
	blockD.o[3] = (vec4(9.0, 0.0, -1.0, 1.0));
	blockE.p = (1u);
	blockE.q = (mat2x3(7.0, -5.0, 7.0, 7.0, 8.0, 7.0));
	blockE.r = (4);
}
#version 450
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
	lowp mat3x4 a[1];
	highp vec2 b;
	highp ivec4 c[];
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	highp mat2x3 d;
	mediump mat2x3 e;
	bool f;
	bvec4 g[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(a[0], mat3x4(1.0, -6.0, -5.0, 7.0, 2.0, -1.0, 4.0, 1.0, -8.0, -1.0, 4.0, -7.0)) && allOk;
	allOk = compare_vec2((b), vec2(3.0, 8.0)) && allOk;
	allOk = compare_ivec4((c[0]), ivec4(1, 9, 5, -4)) && allOk;
	allOk = compare_mat2x3(blockC.d, mat2x3(1.0, -4.0, 1.0, -4.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat2x3(blockC.e, mat2x3(6.0, 0.0, -3.0, 9.0, 1.0, 1.0)) && allOk;
	allOk = compare_bool((blockC.f), false) && allOk;
	allOk = compare_bvec4((blockC.g[0]), bvec4(false, false, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (vec2(0.0, 6.0));
	c[0] = (ivec4(-6, -5, 2, 3));
	blockC.e = (mat2x3(2.0, 4.0, -7.0, -1.0, -4.0, 8.0));
	blockC.f = (true);
	blockC.g[0] = (bvec4(true, true, false, false));
}
#version 450
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
	highp mat3x2 a[1];
	highp int b;
	highp mat3x2 c;
	mediump uvec3 d[];
} blockB[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB[0].a[0], mat3x2(2.0, 7.0, -8.0, 4.0, -4.0, 0.0)) && allOk;
	allOk = compare_int((blockB[0].b), -5) && allOk;
	allOk = compare_uvec3((blockB[0].d[0]), uvec3(6u, 9u, 2u)) && allOk;
	allOk = compare_mat3x2(blockB[1].a[0], mat3x2(-7.0, 8.0, 7.0, 5.0, 5.0, -9.0)) && allOk;
	allOk = compare_int((blockB[1].b), -8) && allOk;
	allOk = compare_uvec3((blockB[1].d[0]), uvec3(3u, 7u, 9u)) && allOk;
	allOk = compare_mat3x2(blockB[2].a[0], mat3x2(3.0, 8.0, 6.0, 6.0, -3.0, -4.0)) && allOk;
	allOk = compare_int((blockB[2].b), 6) && allOk;
	allOk = compare_uvec3((blockB[2].d[0]), uvec3(0u, 1u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (mat3x2(8.0, -6.0, -2.0, 6.0, -1.0, 0.0));
	blockB[0].b = (9);
	blockB[0].c = (mat3x2(5.0, 6.0, 4.0, 7.0, 8.0, -5.0));
	blockB[0].d[0] = (uvec3(3u, 0u, 7u));
	blockB[1].a[0] = (mat3x2(4.0, 9.0, 7.0, -4.0, 0.0, -5.0));
	blockB[1].b = (4);
	blockB[1].c = (mat3x2(9.0, -2.0, -7.0, -4.0, -6.0, 8.0));
	blockB[1].d[0] = (uvec3(5u, 4u, 6u));
	blockB[2].a[0] = (mat3x2(-3.0, -6.0, -6.0, -7.0, 8.0, -1.0));
	blockB[2].b = (4);
	blockB[2].c = (mat3x2(-7.0, 4.0, 2.0, -6.0, -1.0, 5.0));
	blockB[2].d[0] = (uvec3(2u, 0u, 0u));
}
#version 450
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
	mediump vec4 a;
	highp vec2 b;
	highp float c;
	highp int d[1];
	lowp mat3x2 e;
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	highp mat2 f;
	mediump mat4x3 g;
	lowp uint h[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.a), vec4(-9.0, 9.0, 2.0, 0.0)) && allOk;
	allOk = compare_vec2((blockB.b), vec2(5.0, 5.0)) && allOk;
	allOk = compare_float((blockB.c), 5.0) && allOk;
	allOk = compare_mat3x2(blockB.e, mat3x2(-2.0, -9.0, 1.0, -6.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat2(f, mat2(9.0, 7.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat4x3(g, mat4x3(5.0, -5.0, -8.0, -7.0, 7.0, -5.0, 8.0, -5.0, 7.0, -8.0, -4.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec4(-9.0, -3.0, 8.0, 0.0));
	blockB.b = (vec2(-3.0, 9.0));
	blockB.c = (-5.0);
	blockB.d[0] = (2);
	blockB.e = (mat3x2(1.0, 8.0, 6.0, 2.0, 9.0, 8.0));
	f = (mat2(5.0, -5.0, 8.0, -1.0));
	g = (mat4x3(7.0, -9.0, -3.0, -1.0, 6.0, -2.0, -4.0, 9.0, -4.0, 2.0, -4.0, 4.0));
}
#version 450
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
	lowp vec3 mB;
};
layout(std430, binding = 1) buffer BlockB
{
	mediump mat4 a[];
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	sA b;
	mediump mat4 c;
	highp uint d;
	lowp vec2 e;
	lowp mat3x2 f[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(a[0], mat4(0.0, 2.0, -8.0, 6.0, 7.0, 5.0, -6.0, 1.0, 9.0, -4.0, -3.0, 4.0, 4.0, 9.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4(a[1], mat4(-9.0, 8.0, 0.0, 4.0, -4.0, 7.0, 2.0, -1.0, 7.0, -5.0, -4.0, 3.0, -5.0, -3.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4(a[2], mat4(0.0, -3.0, 1.0, 3.0, -9.0, -4.0, 3.0, 9.0, 1.0, 3.0, -9.0, -5.0, 9.0, -7.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat4(a[3], mat4(6.0, 0.0, -3.0, 4.0, -7.0, -1.0, 5.0, -3.0, 0.0, -8.0, 1.0, -9.0, -9.0, -9.0, -7.0, 7.0)) && allOk;
	allOk = compare_vec4((b.mA), vec4(-2.0, 2.0, -4.0, 4.0)) && allOk;
	allOk = compare_vec3((b.mB), vec3(-8.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat4(c, mat4(5.0, 0.0, 2.0, 5.0, -7.0, 1.0, -4.0, 4.0, -8.0, -4.0, -5.0, -7.0, -5.0, -9.0, 1.0, 6.0)) && allOk;
	allOk = compare_vec2((e), vec2(0.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (mat4(6.0, -1.0, 0.0, 3.0, -7.0, 6.0, -7.0, 6.0, -8.0, -4.0, -6.0, 3.0, -2.0, 5.0, -2.0, 6.0));
	a[1] = (mat4(7.0, -5.0, -5.0, -2.0, -2.0, 7.0, -2.0, 1.0, 3.0, -9.0, -2.0, -7.0, 9.0, -9.0, 4.0, -1.0));
	a[2] = (mat4(8.0, 4.0, -4.0, 0.0, 7.0, 6.0, 5.0, 3.0, 3.0, -4.0, -6.0, 4.0, 2.0, -6.0, 7.0, -8.0));
	a[3] = (mat4(5.0, 6.0, 8.0, 9.0, 0.0, -7.0, -6.0, -3.0, 8.0, 1.0, -3.0, 0.0, 7.0, -5.0, -5.0, 7.0));
	b.mA = (vec4(8.0, -6.0, 1.0, 8.0));
	b.mB = (vec3(-5.0, 4.0, 8.0));
	c = (mat4(5.0, -6.0, 1.0, -8.0, -5.0, 4.0, -9.0, -2.0, -7.0, -9.0, 6.0, 6.0, -3.0, 5.0, -7.0, 4.0));
	e = (vec2(4.0, 9.0));
}
#version 450
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
	layout(offset = 16) highp float b;
	layout(offset = 32) lowp vec4 c;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) lowp uvec2 d;
	layout(offset = 8) bool e;
	layout(offset = 16) lowp ivec3 f;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) mediump ivec3 g;
	layout(offset = 16) bvec4 h;
	layout(offset = 32) lowp uvec3 i;
	layout(offset = 44) lowp uint j;
	layout(offset = 48) bvec4 k;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, false, false, true)) && allOk;
	allOk = compare_vec4((blockB.c), vec4(-2.0, -8.0, -7.0, -4.0)) && allOk;
	allOk = compare_uvec2((blockC.d), uvec2(5u, 1u)) && allOk;
	allOk = compare_ivec3((blockC.f), ivec3(4, -8, -3)) && allOk;
	allOk = compare_ivec3((g), ivec3(-5, 7, -8)) && allOk;
	allOk = compare_bvec4((h), bvec4(false, false, true, false)) && allOk;
	allOk = compare_uvec3((i), uvec3(8u, 7u, 3u)) && allOk;
	allOk = compare_uint((j), 3u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (-8.0);
	blockB.c = (vec4(-3.0, 5.0, -6.0, 3.0));
	blockC.d = (uvec2(8u, 3u));
	blockC.e = (true);
	blockC.f = (ivec3(-9, -4, 8));
	g = (ivec3(-3, -3, 5));
	h = (bvec4(false, true, true, true));
	i = (uvec3(2u, 7u, 2u));
	j = (8u);
	k = (bvec4(false, true, true, true));
}
#version 450
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
	mediump mat2 a;
	bvec4 b;
	lowp mat4x2 c;
	lowp uvec4 d;
} blockB[];

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

layout(std140, binding = 1) buffer BlockB
{
	mediump uint a[1];
	int16_t b;
};
layout(std430, binding = 2) buffer BlockC
{
	int16_t c;
	lowp int d;
	int16_t e;
	uint16_t f;
	float16_t g;
};
layout(std430, binding = 3) buffer BlockD
{
	mediump float h;
	lowp float i;
	float16_t j;
	int16_t k;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((a[0]), 3u) && allOk;
	allOk = compare_int16_t(int(b), -2) && allOk;
	allOk = compare_int16_t(int(c), 9) && allOk;
	allOk = compare_float16_t(float(g), -1.0) && allOk;
	allOk = compare_float((h), 9.0) && allOk;
	allOk = compare_float((i), -1.0) && allOk;
	allOk = compare_float16_t(float(j), 6.0) && allOk;
	allOk = compare_int16_t(int(k), 0) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (5u);
	b = int16_t(1);
	c = int16_t(-4);
	d = (1);
	f = uint16_t(8u);
	g = float16_t(1.0);
	h = (-9.0);
	i = (3.0);
	j = float16_t(0.0);
	k = int16_t(-9);
}
#version 450
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
	highp uvec4 a[];
};
layout(std430, column_major, binding = 2) buffer BlockC
{
	highp ivec4 b;
	f16vec4 c[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((a[0]), uvec4(8u, 0u, 0u, 0u)) && allOk;
	allOk = compare_uvec4((a[1]), uvec4(2u, 5u, 5u, 2u)) && allOk;
	allOk = compare_uvec4((a[2]), uvec4(5u, 1u, 5u, 2u)) && allOk;
	allOk = compare_uvec4((a[3]), uvec4(0u, 0u, 3u, 0u)) && allOk;
	allOk = compare_uvec4((a[4]), uvec4(7u, 4u, 8u, 9u)) && allOk;
	allOk = compare_f16vec4(vec4(c[0]), vec4(7.0, -5.0, -4.0, 3.0)) && allOk;
	allOk = compare_f16vec4(vec4(c[1]), vec4(-5.0, -3.0, -1.0, 1.0)) && allOk;
	allOk = compare_f16vec4(vec4(c[2]), vec4(0.0, -3.0, 1.0, 3.0)) && allOk;
	allOk = compare_f16vec4(vec4(c[3]), vec4(-9.0, -4.0, 3.0, 9.0)) && allOk;
	allOk = compare_f16vec4(vec4(c[4]), vec4(1.0, 3.0, -9.0, -5.0)) && allOk;
	allOk = compare_f16vec4(vec4(c[5]), vec4(9.0, -7.0, -8.0, 1.0)) && allOk;
	allOk = compare_f16vec4(vec4(c[6]), vec4(6.0, 0.0, -3.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (ivec4(-2, 7, -2, 1));
	c[0] = f16vec4(vec4(3.0, -9.0, -2.0, -7.0));
	c[1] = f16vec4(vec4(9.0, -9.0, 4.0, -1.0));
	c[2] = f16vec4(vec4(8.0, 4.0, -4.0, 0.0));
	c[3] = f16vec4(vec4(7.0, 6.0, 5.0, 3.0));
	c[4] = f16vec4(vec4(3.0, -4.0, -6.0, 4.0));
	c[5] = f16vec4(vec4(2.0, -6.0, 7.0, -8.0));
	c[6] = f16vec4(vec4(5.0, 6.0, 8.0, 9.0));
}
#version 450
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
	uint16_t mA;
	lowp uvec2 mB[7];
	mediump float mC;
};
layout(std430, row_major, binding = 1) buffer BlockB
{
	u16vec3 a;
	lowp mat4x3 b[];
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	bvec2 c[5];
	i16vec2 d;
	sA e;
	lowp uvec4 f[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.b[0], mat4x3(6.0, 1.0, 4.0, 7.0, 9.0, 4.0, 5.0, -4.0, 9.0, -6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4x3(blockB.b[1], mat4x3(-8.0, 4.0, -1.0, -9.0, -4.0, 7.0, 8.0, 7.0, -5.0, 0.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4x3(blockB.b[2], mat4x3(3.0, 1.0, 3.0, -5.0, 0.0, -9.0, -3.0, -3.0, -4.0, -1.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(blockB.b[3], mat4x3(9.0, -5.0, 1.0, 1.0, 9.0, 6.0, 3.0, -7.0, 0.0, -9.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat4x3(blockB.b[4], mat4x3(4.0, -3.0, -9.0, -7.0, 0.0, -9.0, -1.0, -8.0, -9.0, 5.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat4x3(blockB.b[5], mat4x3(7.0, 4.0, 5.0, -2.0, -8.0, -7.0, 2.0, 4.0, -8.0, -4.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat4x3(blockB.b[6], mat4x3(0.0, 2.0, 5.0, 1.0, -4.0, 4.0, -4.0, -5.0, -7.0, -9.0, 1.0, 6.0)) && allOk;
	allOk = compare_bvec2((c[0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((c[1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((c[2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((c[3]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((c[4]), bvec2(true, true)) && allOk;
	allOk = compare_i16vec2(ivec2(d), ivec2(7, -5)) && allOk;
	allOk = compare_uint16_t(uint(e.mA), 4u) && allOk;
	allOk = compare_uvec2((e.mB[0]), uvec2(7u, 9u)) && allOk;
	allOk = compare_uvec2((e.mB[1]), uvec2(4u, 5u)) && allOk;
	allOk = compare_uvec2((e.mB[2]), uvec2(3u, 2u)) && allOk;
	allOk = compare_uvec2((e.mB[3]), uvec2(9u, 7u)) && allOk;
	allOk = compare_uvec2((e.mB[4]), uvec2(2u, 6u)) && allOk;
	allOk = compare_uvec2((e.mB[5]), uvec2(9u, 3u)) && allOk;
	allOk = compare_uvec2((e.mB[6]), uvec2(7u, 8u)) && allOk;
	allOk = compare_float((e.mC), 2.0) && allOk;
	allOk = compare_uvec4((f[0]), uvec4(7u, 2u, 1u, 3u)) && allOk;
	allOk = compare_uvec4((f[1]), uvec4(6u, 9u, 6u, 7u)) && allOk;
	allOk = compare_uvec4((f[2]), uvec4(3u, 2u, 8u, 1u)) && allOk;
	allOk = compare_uvec4((f[3]), uvec4(9u, 0u, 3u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec3(uvec3(0u, 7u, 5u));
	blockB.b[0] = (mat4x3(3.0, 6.0, 3.0, -7.0, -8.0, -2.0, 6.0, -4.0, 5.0, -7.0, -6.0, -2.0));
	blockB.b[1] = (mat4x3(6.0, -2.0, 1.0, 7.0, -2.0, 3.0, -5.0, 7.0, -9.0, -5.0, -2.0, -2.0));
	blockB.b[2] = (mat4x3(-7.0, -1.0, 0.0, 9.0, 8.0, 7.0, -9.0, 4.0, 6.0, 4.0, -4.0, 5.0));
	blockB.b[3] = (mat4x3(3.0, 4.0, -8.0, 3.0, 2.0, 5.0, -4.0, -6.0, 6.0, -6.0, 7.0, 8.0));
	blockB.b[4] = (mat4x3(9.0, -3.0, 0.0, 0.0, 8.0, 7.0, -7.0, 1.0, -5.0, -6.0, -3.0, -5.0));
	blockB.b[5] = (mat4x3(7.0, 8.0, 5.0, 8.0, -5.0, -5.0, -6.0, 4.0, -7.0, 1.0, 8.0, -3.0));
	blockB.b[6] = (mat4x3(-6.0, 1.0, -8.0, 4.0, -9.0, -2.0, -9.0, 6.0, 6.0, 5.0, -7.0, 4.0));
	c[0] = (bvec2(true, true));
	c[1] = (bvec2(true, true));
	c[2] = (bvec2(true, false));
	c[3] = (bvec2(false, false));
	c[4] = (bvec2(false, true));
	d = i16vec2(ivec2(5, -7));
	e.mA = uint16_t(3u);
	e.mB[0] = (uvec2(5u, 1u));
	e.mB[1] = (uvec2(6u, 6u));
	e.mB[2] = (uvec2(1u, 2u));
	e.mB[3] = (uvec2(9u, 1u));
	e.mB[4] = (uvec2(8u, 6u));
	e.mB[5] = (uvec2(9u, 3u));
	e.mB[6] = (uvec2(8u, 8u));
	e.mC = (-9.0);
	f[0] = (uvec4(9u, 0u, 0u, 3u));
	f[1] = (uvec4(8u, 3u, 1u, 1u));
	f[2] = (uvec4(6u, 6u, 4u, 6u));
	f[3] = (uvec4(3u, 4u, 9u, 0u));
}
#version 450
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
	mediump mat4 a[1];
	i16vec3 b;
	mediump mat4x3 c;
	u16vec2 d;
	mediump mat3x4 e;
} blockB[1];

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

layout(std430, row_major, binding = 1) buffer BlockB
{
	lowp mat3x2 a;
	mediump mat4x2 b;
	lowp uint c;
	lowp vec3 d[];
} blockB[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB[0].a, mat3x2(3.0, -9.0, -9.0, 6.0, -2.0, -5.0)) && allOk;
	allOk = compare_uint((blockB[0].c), 6u) && allOk;
	allOk = compare_vec3((blockB[0].d[0]), vec3(-6.0, 0.0, 8.0)) && allOk;
	allOk = compare_vec3((blockB[0].d[1]), vec3(3.0, 4.0, -8.0)) && allOk;
	allOk = compare_vec3((blockB[0].d[2]), vec3(8.0, 4.0, -2.0)) && allOk;
	allOk = compare_vec3((blockB[0].d[3]), vec3(-7.0, -6.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (mat3x2(-1.0, -9.0, -2.0, -6.0, 8.0, 0.0));
	blockB[0].c = (6u);
	blockB[0].d[0] = (vec3(-5.0, 1.0, -3.0));
	blockB[0].d[1] = (vec3(9.0, 1.0, 8.0));
	blockB[0].d[2] = (vec3(-1.0, -7.0, 2.0));
	blockB[0].d[3] = (vec3(2.0, -2.0, 9.0));
}
#version 450
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
layout(std140, binding = 1) buffer BlockB
{
	mediump mat3x2 a;
	sB b;
	mediump vec2 c;
	lowp uvec3 d;
	highp mat2 e;
} blockB[1];

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

layout(binding = 1) buffer BlockB
{
	layout(offset = 0) bvec2 a;
	layout(offset = 8) highp uvec2 b;
	layout(offset = 16) u16vec4 c[1];
	layout(offset = 24) i16vec2 d;
	layout(offset = 32) f16vec4 e[1];
} blockB[2];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump float f;
	layout(offset = 4) mediump ivec3 g;
	layout(offset = 16) bool h[1];
	layout(offset = 20) i16vec4 i;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) lowp float j;
	layout(offset = 4) mediump vec2 k;
	layout(offset = 16) lowp ivec4 l;
	layout(offset = 32) i16vec4 m[1];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB[0].b), uvec2(6u, 8u)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB[0].d), ivec2(9, 0)) && allOk;
	allOk = compare_uvec2((blockB[1].b), uvec2(8u, 0u)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB[1].d), ivec2(8, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(i), ivec4(0, 1, -5, -7)) && allOk;
	allOk = compare_vec2((blockD.k), vec2(-5.0, -7.0)) && allOk;
	allOk = compare_ivec4((blockD.l), ivec4(-8, -8, 5, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.m[0]), ivec4(2, -3, -9, -1)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (bvec2(true, true));
	blockB[0].c[0] = u16vec4(uvec4(6u, 5u, 2u, 8u));
	blockB[0].d = i16vec2(ivec2(-7, -5));
	blockB[0].e[0] = f16vec4(vec4(-1.0, -4.0, -4.0, 4.0));
	blockB[1].a = (bvec2(true, true));
	blockB[1].c[0] = u16vec4(uvec4(5u, 2u, 7u, 9u));
	blockB[1].d = i16vec2(ivec2(-7, -1));
	blockB[1].e[0] = f16vec4(vec4(0.0, -2.0, -1.0, 0.0));
	f = (-6.0);
	g = (ivec3(4, -1, -2));
	h[0] = (false);
	i = i16vec4(ivec4(6, -4, -3, -1));
	blockD.j = (-3.0);
	blockD.k = (vec2(8.0, 9.0));
}
#version 450
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
	u16vec2 a;
	int16_t b[8];
	mediump mat3x2 c;
	mediump float d[];
} blockB;
layout(scalar, binding = 2) buffer BlockC
{
	lowp mat2 e;
	lowp uint f;
	highp mat3x2 g;
	mediump vec4 h;
	mediump float i[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.d[0]), -8.0) && allOk;
	allOk = compare_float((blockB.d[1]), 6.0) && allOk;
	allOk = compare_float((blockB.d[2]), 0.0) && allOk;
	allOk = compare_float((blockB.d[3]), -1.0) && allOk;
	allOk = compare_float((blockB.d[4]), -3.0) && allOk;
	allOk = compare_float((blockB.d[5]), 0.0) && allOk;
	allOk = compare_float((blockB.d[6]), -1.0) && allOk;
	allOk = compare_uint((blockC.f), 4u) && allOk;
	allOk = compare_mat3x2(blockC.g, mat3x2(-1.0, 6.0, 1.0, 1.0, 7.0, 2.0)) && allOk;
	allOk = compare_float((blockC.i[0]), 0.0) && allOk;
	allOk = compare_float((blockC.i[1]), -1.0) && allOk;
	allOk = compare_float((blockC.i[2]), 1.0) && allOk;
	allOk = compare_float((blockC.i[3]), -8.0) && allOk;
	allOk = compare_float((blockC.i[4]), -9.0) && allOk;
	allOk = compare_float((blockC.i[5]), 5.0) && allOk;
	allOk = compare_float((blockC.i[6]), 0.0) && allOk;
	allOk = compare_float((blockC.i[7]), -3.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = int16_t(9);
	blockB.b[1] = int16_t(4);
	blockB.b[2] = int16_t(1);
	blockB.b[3] = int16_t(-7);
	blockB.b[4] = int16_t(-4);
	blockB.b[5] = int16_t(-4);
	blockB.b[6] = int16_t(-6);
	blockB.b[7] = int16_t(-5);
	blockB.c = (mat3x2(-2.0, 5.0, 4.0, -9.0, -2.0, -3.0));
	blockB.d[0] = (-1.0);
	blockB.d[1] = (-9.0);
	blockB.d[2] = (1.0);
	blockB.d[3] = (1.0);
	blockB.d[4] = (7.0);
	blockB.d[5] = (8.0);
	blockB.d[6] = (9.0);
	blockC.e = (mat2(-7.0, -1.0, -6.0, 5.0));
	blockC.f = (8u);
	blockC.g = (mat3x2(5.0, 6.0, -6.0, -9.0, 3.0, -7.0));
	blockC.i[0] = (-9.0);
	blockC.i[1] = (-6.0);
	blockC.i[2] = (-3.0);
	blockC.i[3] = (-7.0);
	blockC.i[4] = (-1.0);
	blockC.i[5] = (-5.0);
	blockC.i[6] = (6.0);
	blockC.i[7] = (-5.0);
}
#version 450
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
	i16vec4 a;
	mediump mat3x2 b;
	mediump uvec2 c;
	highp uvec4 d;
} blockB[3];
layout(scalar, binding = 2) buffer BlockC
{
	lowp mat4x3 e;
	f16vec3 f[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(blockB[0].a), ivec4(-7, -1, -7, 4)) && allOk;
	allOk = compare_mat3x2(blockB[0].b, mat3x2(-8.0, 3.0, -3.0, 6.0, -7.0, -5.0)) && allOk;
	allOk = compare_uvec4((blockB[0].d), uvec4(5u, 5u, 8u, 7u)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[1].a), ivec4(6, -1, 3, 0)) && allOk;
	allOk = compare_mat3x2(blockB[1].b, mat3x2(-6.0, -9.0, -8.0, 1.0, 2.0, 9.0)) && allOk;
	allOk = compare_uvec4((blockB[1].d), uvec4(4u, 2u, 2u, 8u)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[2].a), ivec4(4, 6, -7, -6)) && allOk;
	allOk = compare_mat3x2(blockB[2].b, mat3x2(-5.0, 6.0, 8.0, -8.0, 2.0, 7.0)) && allOk;
	allOk = compare_uvec4((blockB[2].d), uvec4(2u, 3u, 9u, 9u)) && allOk;
	allOk = compare_f16vec3(vec3(f[0]), vec3(3.0, 7.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(f[1]), vec3(-9.0, -8.0, 6.0)) && allOk;
	allOk = compare_f16vec3(vec3(f[2]), vec3(3.0, -4.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(f[3]), vec3(-9.0, 3.0, 8.0)) && allOk;
	allOk = compare_f16vec3(vec3(f[4]), vec3(-6.0, 1.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = i16vec4(ivec4(-3, 7, 8, -4));
	blockB[0].b = (mat3x2(-7.0, -4.0, 8.0, 3.0, -1.0, 5.0));
	blockB[0].c = (uvec2(7u, 4u));
	blockB[0].d = (uvec4(9u, 6u, 1u, 5u));
	blockB[1].a = i16vec4(ivec4(0, 7, 3, 5));
	blockB[1].b = (mat3x2(-7.0, 4.0, -9.0, 6.0, 7.0, -2.0));
	blockB[1].c = (uvec2(2u, 3u));
	blockB[1].d = (uvec4(7u, 6u, 1u, 4u));
	blockB[2].a = i16vec4(ivec4(-5, -7, 2, -1));
	blockB[2].b = (mat3x2(3.0, -3.0, 7.0, 0.0, 3.0, 7.0));
	blockB[2].c = (uvec2(6u, 7u));
	blockB[2].d = (uvec4(5u, 0u, 9u, 0u));
	f[0] = f16vec3(vec3(-6.0, -5.0, -9.0));
	f[1] = f16vec3(vec3(-7.0, 6.0, 5.0));
	f[2] = f16vec3(vec3(-2.0, -1.0, 6.0));
	f[3] = f16vec3(vec3(7.0, -6.0, 9.0));
	f[4] = f16vec3(vec3(-9.0, 3.0, 4.0));
}
#version 450
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
	i16vec4 a[1];
	i16vec3 b;
} blockB[];

bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

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

layout(std430, row_major, binding = 1) buffer BlockB
{
	highp mat3x4 a;
	bvec2 b;
	uint8_t c;
	highp float d;
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	mediump mat3x4 e;
	i8vec3 f;
	mediump float g;
	u8vec4 h;
	lowp mat2 i[];
} blockC;
layout(std430, column_major, binding = 3) buffer BlockD
{
	i8vec2 j;
	mediump vec3 k;
	i8vec2 l;
	lowp mat3 m[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((b), bvec2(true, false)) && allOk;
	allOk = compare_uint8_t(uint(c), 6u) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.f), ivec3(4294967292, 4294967292, 1)) && allOk;
	allOk = compare_float((blockC.g), 9.0) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.j), ivec2(6, 6)) && allOk;
	allOk = compare_vec3((blockD.k), vec3(1.0, 3.0, 4.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.l), ivec2(1, 0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat3x4(5.0, 9.0, 0.0, 2.0, -5.0, -5.0, -1.0, -4.0, 3.0, -5.0, -9.0, -8.0));
	c = uint8_t(3u);
	d = (-3.0);
	blockC.e = (mat3x4(-7.0, -9.0, 9.0, 7.0, -4.0, -8.0, -1.0, 9.0, -2.0, -5.0, 1.0, -8.0));
	blockC.f = i8vec3(ivec3(4294967290, 4, 8));
	blockC.g = (-8.0);
	blockC.h = u8vec4(uvec4(4u, 6u, 0u, 8u));
	blockC.i[0] = (mat2(6.0, 3.0, 1.0, 0.0));
	blockC.i[1] = (mat2(-1.0, -8.0, -3.0, -6.0));
	blockC.i[2] = (mat2(3.0, 7.0, 2.0, 2.0));
	blockD.l = i8vec2(ivec2(4294967295, 2));
	blockD.m[0] = (mat3(-5.0, -8.0, -7.0, 8.0, -9.0, 2.0, -2.0, 3.0, -7.0));
	blockD.m[1] = (mat3(2.0, 0.0, 4.0, -1.0, -7.0, -2.0, -2.0, -7.0, -8.0));
	blockD.m[2] = (mat3(-9.0, -2.0, 6.0, 0.0, -7.0, 3.0, -7.0, -1.0, -5.0));
	blockD.m[3] = (mat3(1.0, 4.0, -3.0, 4.0, 5.0, 0.0, 7.0, -5.0, 0.0));
}
#version 450
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
	u8vec2 a;
	i8vec2 b;
	bvec4 c[1];
	lowp uvec3 d;
	i8vec4 e[];
} blockB;

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(blockB.a), uvec2(8u, 0u)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.b), ivec2(4294967288, 6)) && allOk;
	allOk = compare_bvec4((blockB.c[0]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_uvec3((blockB.d), uvec3(1u, 5u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = i8vec2(ivec2(0, 3));
	blockB.c[0] = (bvec4(false, false, true, false));
	blockB.d = (uvec3(4u, 4u, 4u));
}
#version 450
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
	mediump mat3 mA[8];
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	lowp ivec4 a;
	mediump ivec4 b;
	highp mat3 c;
	lowp mat2 d;
};
layout(std430, binding = 2) buffer BlockC
{
	highp vec4 e;
	lowp mat4x3 f;
	u8vec2 g;
	bool h[];
};
layout(std430, binding = 3) buffer BlockD
{
	u8vec4 i;
	highp ivec3 j[];
};
layout(std140, row_major, binding = 4) buffer BlockE
{
	i8vec3 k;
	bvec4 l;
	mediump int m;
	sA n;
} blockE[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((a), ivec4(2, 7, -9, 3)) && allOk;
	allOk = compare_ivec4((b), ivec4(0, -7, 7, -2)) && allOk;
	allOk = compare_mat3(c, mat3(3.0, -5.0, 9.0, 9.0, -2.0, -1.0, 1.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat2(d, mat2(-6.0, 6.0, -9.0, 1.0)) && allOk;
	allOk = compare_vec4((e), vec4(-6.0, 0.0, 2.0, 5.0)) && allOk;
	allOk = compare_u8vec2(uvec2(g), uvec2(0u, 2u)) && allOk;
	allOk = compare_bool((h[0]), false) && allOk;
	allOk = compare_ivec3((j[0]), ivec3(8, 3, 9)) && allOk;
	allOk = compare_ivec3((j[1]), ivec3(7, 9, 7)) && allOk;
	allOk = compare_ivec3((j[2]), ivec3(3, -3, 8)) && allOk;
	allOk = compare_ivec3((j[3]), ivec3(1, -8, -3)) && allOk;
	allOk = compare_ivec3((j[4]), ivec3(-3, -3, 3)) && allOk;
	allOk = compare_ivec3((j[5]), ivec3(3, 2, 3)) && allOk;
	allOk = compare_ivec3((j[6]), ivec3(1, 9, -4)) && allOk;
	allOk = compare_ivec3((j[7]), ivec3(4, 8, 2)) && allOk;
	allOk = compare_int((blockE[0].m), -9) && allOk;
	allOk = compare_int((blockE[1].m), 3) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (ivec4(-4, 2, -1, 9));
	d = (mat2(9.0, -5.0, 4.0, 5.0));
	e = (vec4(-1.0, 4.0, -7.0, 5.0));
	f = (mat4x3(-6.0, 4.0, -3.0, 9.0, 0.0, -8.0, 6.0, -8.0, -7.0, -2.0, 5.0, 1.0));
	g = u8vec2(uvec2(8u, 9u));
	h[0] = (true);
	i = u8vec4(uvec4(8u, 6u, 9u, 8u));
	j[0] = (ivec3(8, -7, 4));
	j[1] = (ivec3(0, 7, 2));
	j[2] = (ivec3(-4, 1, 6));
	j[3] = (ivec3(-2, 5, 7));
	j[4] = (ivec3(-9, -4, 7));
	j[5] = (ivec3(-9, 7, 7));
	j[6] = (ivec3(-8, 5, -2));
	j[7] = (ivec3(-3, -9, 7));
	blockE[0].k = i8vec3(ivec3(4294967292, 4294967290, 3));
	blockE[0].l = (bvec4(false, true, true, true));
	blockE[0].m = (0);
	blockE[0].n.mA[0] = (mat3(8.0, -6.0, 9.0, 8.0, 7.0, -1.0, -2.0, 1.0, -8.0));
	blockE[0].n.mA[1] = (mat3(1.0, -8.0, -5.0, 0.0, 7.0, -6.0, -2.0, -6.0, -7.0));
	blockE[0].n.mA[2] = (mat3(-5.0, 8.0, 0.0, 9.0, 0.0, -7.0, 6.0, 1.0, 8.0));
	blockE[0].n.mA[3] = (mat3(5.0, -2.0, 9.0, -1.0, -5.0, -9.0, 3.0, -7.0, 7.0));
	blockE[0].n.mA[4] = (mat3(-4.0, -2.0, -5.0, 0.0, -4.0, 4.0, -6.0, -7.0, -3.0));
	blockE[0].n.mA[5] = (mat3(-2.0, -6.0, -4.0, -3.0, -4.0, -7.0, 7.0, -8.0, -2.0));
	blockE[0].n.mA[6] = (mat3(-8.0, -8.0, -7.0, 0.0, -4.0, 1.0, 6.0, -6.0, -2.0));
	blockE[0].n.mA[7] = (mat3(-3.0, -3.0, 0.0, 3.0, -4.0, 3.0, -3.0, 3.0, -5.0));
	blockE[1].k = i8vec3(ivec3(8, 9, 2));
	blockE[1].l = (bvec4(true, false, true, true));
	blockE[1].m = (0);
	blockE[1].n.mA[0] = (mat3(-9.0, -5.0, 6.0, 7.0, -1.0, -7.0, 8.0, -5.0, -4.0));
	blockE[1].n.mA[1] = (mat3(-1.0, 3.0, -8.0, 6.0, -7.0, 6.0, -4.0, 4.0, 7.0));
	blockE[1].n.mA[2] = (mat3(5.0, 7.0, -5.0, -3.0, -9.0, 5.0, 9.0, 6.0, -1.0));
	blockE[1].n.mA[3] = (mat3(0.0, 5.0, 3.0, -6.0, 1.0, -2.0, -1.0, -2.0, -2.0));
	blockE[1].n.mA[4] = (mat3(-1.0, -6.0, -1.0, -2.0, 0.0, 3.0, 0.0, 2.0, 1.0));
	blockE[1].n.mA[5] = (mat3(6.0, 3.0, 3.0, 4.0, 3.0, 6.0, 9.0, -9.0, -8.0));
	blockE[1].n.mA[6] = (mat3(9.0, 7.0, -2.0, -8.0, 3.0, 5.0, 3.0, -8.0, -4.0));
	blockE[1].n.mA[7] = (mat3(-1.0, -8.0, 1.0, 2.0, 8.0, 8.0, -8.0, 0.0, -8.0));
}
#version 450
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
	mediump ivec2 mB;
	lowp vec3 mC;
	lowp uvec4 mD;
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	bvec3 a;
	uint8_t b;
	u8vec2 c[];
} blockB;
layout(std140, column_major, binding = 2) readonly buffer BlockC
{
	sA d[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.a), bvec3(true, true, false)) && allOk;
	allOk = compare_uint8_t(uint(blockB.b), 7u) && allOk;
	allOk = compare_u8vec2(uvec2(blockB.c[0]), uvec2(8u, 1u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB.c[1]), uvec2(9u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB.c[2]), uvec2(3u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB.c[3]), uvec2(5u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec3(true, false, true));
	blockB.b = uint8_t(7u);
	blockB.c[0] = u8vec2(uvec2(5u, 6u));
	blockB.c[1] = u8vec2(uvec2(4u, 3u));
	blockB.c[2] = u8vec2(uvec2(0u, 6u));
	blockB.c[3] = u8vec2(uvec2(8u, 5u));
}
#version 450
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
	layout(offset = 0) i8vec3 a;
	layout(offset = 4) highp uint b[1];
	layout(offset = 8) u8vec4 c;
	layout(offset = 16) highp vec4 d;
	layout(offset = 32) bvec3 e;
} blockB;
layout(binding = 2) readonly buffer BlockC
{
	layout(offset = 0) lowp int f;
	layout(offset = 4) highp ivec3 g;
	layout(offset = 16) i8vec2 h;
} blockC[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(blockB.a), ivec3(6, 8, 4)) && allOk;
	allOk = compare_uint((blockB.b[0]), 8u) && allOk;
	allOk = compare_u8vec4(uvec4(blockB.c), uvec4(4u, 0u, 0u, 1u)) && allOk;
	allOk = compare_vec4((blockB.d), vec4(2.0, -8.0, 2.0, -3.0)) && allOk;
	allOk = compare_bvec3((blockB.e), bvec3(true, true, true)) && allOk;
	allOk = compare_int((blockC[0].f), 6) && allOk;
	allOk = compare_ivec3((blockC[0].g), ivec3(4, -5, 5)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC[0].h), ivec2(4294967291, 4294967292)) && allOk;
	allOk = compare_int((blockC[1].f), 5) && allOk;
	allOk = compare_ivec3((blockC[1].g), ivec3(-1, -5, -1)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC[1].h), ivec2(6, 4294967290)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i8vec3(ivec3(7, 7, 1));
	blockB.b[0] = (8u);
	blockB.d = (vec4(-9.0, -8.0, 3.0, -3.0));
	blockB.e = (bvec3(false, true, false));
}
#version 450
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
	lowp mat4 mA;
	bool mB;
	mediump uvec4 mC;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	bvec2 a;
	mediump uint b[];
} blockB;
layout(scalar, binding = 2) buffer BlockC
{
	sA c;
	mediump mat3 d;
	mediump uint e;
	lowp mat4x2 f;
	mediump int g[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a), bvec2(true, true)) && allOk;
	allOk = compare_uint((blockB.b[0]), 8u) && allOk;
	allOk = compare_uint((blockB.b[1]), 1u) && allOk;
	allOk = compare_uint((blockB.b[2]), 7u) && allOk;
	allOk = compare_uint((blockB.b[3]), 8u) && allOk;
	allOk = compare_uint((e), 2u) && allOk;
	allOk = compare_int((g[0]), -5) && allOk;
	allOk = compare_int((g[1]), -5) && allOk;
	allOk = compare_int((g[2]), 1) && allOk;
	allOk = compare_int((g[3]), 2) && allOk;
	allOk = compare_int((g[4]), 4) && allOk;
	allOk = compare_int((g[5]), -8) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, true));
	d = (mat3(3.0, 4.0, 2.0, 9.0, -4.0, 6.0, -6.0, -2.0, 0.0));
	f = (mat4x2(9.0, -2.0, -3.0, 1.0, -5.0, 8.0, -3.0, 5.0));
	g[0] = (-7);
	g[1] = (3);
	g[2] = (9);
	g[3] = (-5);
	g[4] = (6);
	g[5] = (1);
}
#version 450
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
	i8vec2 a[];
} blockB[1];
layout(scalar, column_major, binding = 2) buffer BlockC
{
	highp vec3 b;
	i8vec4 c;
	lowp mat3x2 d[][6];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(blockB[0].a[0]), ivec2(4294967293, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB[0].a[1]), ivec2(4294967288, 4294967287)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB[0].a[2]), ivec2(5, 5)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB[0].a[3]), ivec2(4294967292, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB[0].a[4]), ivec2(4294967292, 4294967295)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB[0].a[5]), ivec2(3, 4294967289)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = i8vec2(ivec2(4294967291, 5));
	blockB[0].a[1] = i8vec2(ivec2(4294967293, 3));
	blockB[0].a[2] = i8vec2(ivec2(2, 7));
	blockB[0].a[3] = i8vec2(ivec2(5, 9));
	blockB[0].a[4] = i8vec2(ivec2(4294967288, 4294967293));
	blockB[0].a[5] = i8vec2(ivec2(9, 6));
	d[0][0] = (mat3x2(-3.0, -9.0, -2.0, 5.0, 4.0, -6.0));
	d[0][1] = (mat3x2(2.0, 7.0, 8.0, 2.0, 2.0, -8.0));
	d[0][2] = (mat3x2(-5.0, 4.0, 2.0, 2.0, -3.0, -1.0));
	d[0][3] = (mat3x2(-7.0, -3.0, 8.0, -9.0, -3.0, 0.0));
	d[0][4] = (mat3x2(6.0, -5.0, 3.0, 4.0, -9.0, -5.0));
	d[0][5] = (mat3x2(1.0, 8.0, -6.0, 9.0, 4.0, -8.0));
	d[1][0] = (mat3x2(-9.0, 4.0, -8.0, 3.0, -4.0, 6.0));
	d[1][1] = (mat3x2(1.0, 9.0, -2.0, -2.0, -5.0, 9.0));
	d[1][2] = (mat3x2(3.0, 9.0, -9.0, 6.0, -8.0, 1.0));
	d[1][3] = (mat3x2(0.0, -8.0, 3.0, -4.0, -6.0, 9.0));
	d[1][4] = (mat3x2(-2.0, 7.0, 5.0, -3.0, -9.0, 2.0));
	d[1][5] = (mat3x2(7.0, 9.0, -8.0, 7.0, -8.0, -6.0));
	d[2][0] = (mat3x2(-6.0, 3.0, 5.0, 3.0, 6.0, -4.0));
	d[2][1] = (mat3x2(4.0, 0.0, -2.0, -4.0, 5.0, -2.0));
	d[2][2] = (mat3x2(-9.0, 0.0, -4.0, 3.0, -8.0, -4.0));
	d[2][3] = (mat3x2(6.0, 8.0, 5.0, -3.0, -2.0, 8.0));
	d[2][4] = (mat3x2(-3.0, -2.0, -5.0, -2.0, 4.0, -8.0));
	d[2][5] = (mat3x2(0.0, -8.0, -6.0, 9.0, 0.0, 9.0));
}
#version 450
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
	u8vec3 a;
	u8vec3 b;
} blockB[];

bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(blockB[nonuniformEXT(0)].a), uvec3(5u, 3u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB[nonuniformEXT(0)].b), uvec3(4u, 6u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB[nonuniformEXT(1)].a), uvec3(6u, 3u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB[nonuniformEXT(1)].b), uvec3(1u, 0u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB[nonuniformEXT(2)].a), uvec3(1u, 6u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB[nonuniformEXT(2)].b), uvec3(0u, 6u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = u8vec3(uvec3(9u, 2u, 2u));
	blockB[nonuniformEXT(0)].b = u8vec3(uvec3(6u, 2u, 2u));
	blockB[nonuniformEXT(1)].a = u8vec3(uvec3(2u, 2u, 0u));
	blockB[nonuniformEXT(1)].b = u8vec3(uvec3(7u, 9u, 2u));
	blockB[nonuniformEXT(2)].a = u8vec3(uvec3(1u, 2u, 9u));
	blockB[nonuniformEXT(2)].b = u8vec3(uvec3(6u, 7u, 3u));
}
#version 450
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
	mediump vec2 a[1];
	lowp vec3 b;
	bool c;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB[nonuniformEXT(0)].a[0]), vec2(1.0, 2.0)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(1)].a[0]), vec2(2.0, -3.0)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(2)].a[0]), vec2(-9.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a[0] = (vec2(-8.0, -4.0));
	blockB[nonuniformEXT(0)].b = (vec3(-7.0, 2.0, -2.0));
	blockB[nonuniformEXT(0)].c = (true);
	blockB[nonuniformEXT(1)].a[0] = (vec2(-8.0, 6.0));
	blockB[nonuniformEXT(1)].b = (vec3(-1.0, -9.0, 3.0));
	blockB[nonuniformEXT(1)].c = (true);
	blockB[nonuniformEXT(2)].a[0] = (vec2(-7.0, 6.0));
	blockB[nonuniformEXT(2)].b = (vec3(-5.0, -4.0, 8.0));
	blockB[nonuniformEXT(2)].c = (true);
}
#version 450
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
	mediump uvec2 var;
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((var), uvec2(3u, 3u)) && allOk;
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
	lowp mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 7.0) && allOk;
	allOk = compare_float(var[0][1], -5.0) && allOk;
	allOk = compare_float(var[1][0], 2.0) && allOk;
	allOk = compare_float(var[1][1], -9.0) && allOk;
	allOk = compare_vec2(var[0], vec2(7.0, -5.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(2.0, -9.0)) && allOk;
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
	highp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -3.0) && allOk;
	allOk = compare_float(var[0][1], 1.0) && allOk;
	allOk = compare_float(var[0][2], -5.0) && allOk;
	allOk = compare_float(var[0][3], 8.0) && allOk;
	allOk = compare_float(var[1][0], 3.0) && allOk;
	allOk = compare_float(var[1][1], -9.0) && allOk;
	allOk = compare_float(var[1][2], 2.0) && allOk;
	allOk = compare_float(var[1][3], 2.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-3.0, 1.0, -5.0, 8.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(3.0, -9.0, 2.0, 2.0)) && allOk;
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

layout(std430, binding = 1) readonly buffer Block
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

layout(std430, row_major, binding = 1) readonly buffer Block
{
	lowp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var, mat3(8.0, -9.0, -3.0, 9.0, -7.0, 0.0, -4.0, -9.0, 1.0)) && allOk;
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
	highp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], -7.0) && allOk;
	allOk = compare_float(var[1][0], -5.0) && allOk;
	allOk = compare_float(var[1][1], 1.0) && allOk;
	allOk = compare_float(var[2][0], -4.0) && allOk;
	allOk = compare_float(var[2][1], 6.0) && allOk;
	allOk = compare_vec2(var[0], vec2(1.0, -7.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-5.0, 1.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-4.0, 6.0)) && allOk;
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
	highp ivec2 var;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((padding), -4) && allOk;
	allOk = compare_ivec2((var), ivec2(-6, 5)) && allOk;
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
	highp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_float(var[0][0], 3.0) && allOk;
	allOk = compare_float(var[0][1], -8.0) && allOk;
	allOk = compare_float(var[0][2], -2.0) && allOk;
	allOk = compare_float(var[0][3], 4.0) && allOk;
	allOk = compare_float(var[1][0], 8.0) && allOk;
	allOk = compare_float(var[1][1], -9.0) && allOk;
	allOk = compare_float(var[1][2], -1.0) && allOk;
	allOk = compare_float(var[1][3], -5.0) && allOk;
	allOk = compare_vec4(var[0], vec4(3.0, -8.0, -2.0, 4.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(8.0, -9.0, -1.0, -5.0)) && allOk;
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

}
#version 450
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
	lowp mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_mat3x4(var, mat3x4(-7.0, -3.0, 8.0, 1.0, 2.0, 8.0, -1.0, -4.0, 7.0, 5.0, -7.0, -1.0)) && allOk;
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
	mediump mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -6.0) && allOk;
	allOk = compare_float(var[0][0], -5.0) && allOk;
	allOk = compare_float(var[0][1], -6.0) && allOk;
	allOk = compare_float(var[1][0], -5.0) && allOk;
	allOk = compare_float(var[1][1], -4.0) && allOk;
	allOk = compare_float(var[2][0], -7.0) && allOk;
	allOk = compare_float(var[2][1], 5.0) && allOk;
	allOk = compare_float(var[3][0], -5.0) && allOk;
	allOk = compare_float(var[3][1], 9.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-5.0, -4.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-7.0, 5.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(-5.0, 9.0)) && allOk;
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
	lowp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 2.0) && allOk;
	allOk = compare_float(var[0][0], 9.0) && allOk;
	allOk = compare_float(var[0][1], 8.0) && allOk;
	allOk = compare_float(var[1][0], -2.0) && allOk;
	allOk = compare_float(var[1][1], 6.0) && allOk;
	allOk = compare_float(var[2][0], -2.0) && allOk;
	allOk = compare_float(var[2][1], -8.0) && allOk;
	allOk = compare_float(var[3][0], 1.0) && allOk;
	allOk = compare_float(var[3][1], -4.0) && allOk;
	allOk = compare_vec2(var[0], vec2(9.0, 8.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-2.0, 6.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-2.0, -8.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(1.0, -4.0)) && allOk;
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

}
#version 450
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
	highp mat4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0], mat4(5.0, 8.0, -8.0, -2.0, 6.0, -4.0, 3.0, -1.0, 6.0, 4.0, -8.0, -3.0, 9.0, 9.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(-6.0, -5.0, 1.0, 2.0, 1.0, 8.0, 6.0, 2.0, -2.0, -9.0, -8.0, -8.0, -3.0, -9.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(-1.0, -6.0, 8.0, -9.0, -2.0, 9.0, 7.0, 3.0, 4.0, -1.0, -8.0, -8.0, 9.0, -4.0, 1.0, -6.0)) && allOk;
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
	highp mat2x4 var[3];
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
	allOk = compare_mat4x3(var[0], mat4x3(7.0, -2.0, 6.0, 3.0, 1.0, -7.0, 1.0, -4.0, 0.0, 9.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(3.0, 2.0, 2.0, 6.0, 6.0, 0.0, 3.0, 6.0, -4.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(-6.0, -5.0, 4.0, -4.0, 1.0, 2.0, -5.0, 9.0, -7.0, -2.0, -5.0, 8.0)) && allOk;
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

}
#version 450
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
	highp ivec3 var[3];
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((padding), 7) && allOk;
	allOk = compare_ivec3((var[0]), ivec3(-4, 3, -4)) && allOk;
	allOk = compare_ivec3((var[1]), ivec3(-6, -8, 3)) && allOk;
	allOk = compare_ivec3((var[2]), ivec3(-1, -7, -1)) && allOk;
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
	highp mat4x3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat4x3(var[0], mat4x3(6.0, 1.0, -6.0, -9.0, -8.0, 6.0, 4.0, 5.0, -6.0, -1.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(1.0, 2.0, 9.0, 3.0, 1.0, 1.0, 7.0, -1.0, 8.0, 1.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(4.0, 5.0, -9.0, 2.0, 0.0, -9.0, -2.0, 1.0, -7.0, -4.0, 0.0, -5.0)) && allOk;
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
	allOk = compare_mat3(var[0], mat3(-8.0, -9.0, -7.0, -7.0, 8.0, 7.0, 4.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(5.0, -4.0, 7.0, -4.0, -3.0, 8.0, 7.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(1.0, 6.0, 8.0, -9.0, -1.0, 8.0, 8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3(var[3], mat3(-6.0, 4.0, -3.0, -2.0, 3.0, 7.0, 0.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3(var[4], mat3(-1.0, 1.0, -9.0, 4.0, 6.0, 8.0, 8.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat3(var[5], mat3(3.0, 0.0, -4.0, 8.0, 3.0, 9.0, 3.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3(var[6], mat3(-8.0, 7.0, 2.0, -7.0, 4.0, -2.0, -5.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3(var[7], mat3(-1.0, 2.0, 0.0, -9.0, -9.0, 6.0, -6.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(var[8], mat3(-4.0, -3.0, -3.0, 4.0, -6.0, -6.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3(var[9], mat3(4.0, 6.0, -3.0, 5.0, -4.0, -6.0, -5.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3(var[10], mat3(8.0, -1.0, -4.0, -2.0, 4.0, -8.0, 0.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3(var[11], mat3(9.0, 6.0, 8.0, -7.0, 4.0, -8.0, 4.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat3(var[12], mat3(-7.0, 8.0, -6.0, -9.0, -8.0, 8.0, 0.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3(var[13], mat3(-6.0, 0.0, -3.0, 9.0, 7.0, -8.0, -9.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3(var[14], mat3(-8.0, 9.0, 0.0, -7.0, 1.0, -2.0, 3.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3(var[15], mat3(6.0, 6.0, -4.0, 4.0, -2.0, 6.0, 2.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat3(var[16], mat3(2.0, 9.0, 6.0, -8.0, -6.0, -3.0, -4.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3(var[17], mat3(-5.0, -8.0, 6.0, 2.0, 5.0, -6.0, 7.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3(var[18], mat3(3.0, 4.0, -4.0, -1.0, -7.0, -1.0, 4.0, -4.0, -7.0)) && allOk;
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
	highp mat2x3 var[];
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
	allOk = compare_mat2x3(var[3], mat2x3(6.0, -1.0, -8.0, 3.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[4], mat2x3(4.0, 7.0, 2.0, -2.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[5], mat2x3(0.0, 3.0, 1.0, 1.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[6], mat2x3(-5.0, 0.0, 2.0, -8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[7], mat2x3(-7.0, 0.0, -6.0, -3.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[8], mat2x3(2.0, 2.0, 8.0, 8.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[9], mat2x3(5.0, -5.0, 7.0, 3.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[10], mat2x3(-4.0, 4.0, -6.0, -4.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[11], mat2x3(-1.0, 2.0, 6.0, 0.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[12], mat2x3(-2.0, -9.0, 4.0, -4.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[13], mat2x3(2.0, -4.0, 4.0, -9.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[14], mat2x3(-7.0, 4.0, -6.0, 9.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[15], mat2x3(-7.0, -3.0, 0.0, 1.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[16], mat2x3(-3.0, -2.0, -4.0, -6.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[17], mat2x3(-2.0, -6.0, -4.0, 5.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[18], mat2x3(-9.0, 5.0, -1.0, 6.0, 6.0, 4.0)) && allOk;
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
	allOk = compare_mat2x3(var[0], mat2x3(2.0, 5.0, 1.0, 7.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(3.0, 6.0, -3.0, 8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(-5.0, -2.0, 6.0, -5.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[3], mat2x3(3.0, 6.0, 4.0, 8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[4], mat2x3(-7.0, 3.0, -5.0, 2.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[5], mat2x3(2.0, 6.0, -6.0, -7.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[6], mat2x3(-9.0, 5.0, -2.0, -8.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[7], mat2x3(-4.0, 0.0, 4.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[8], mat2x3(1.0, -6.0, -1.0, -2.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[9], mat2x3(3.0, -1.0, 1.0, 5.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[10], mat2x3(-9.0, 3.0, -4.0, 4.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[11], mat2x3(6.0, -9.0, -8.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[12], mat2x3(3.0, 9.0, -7.0, 8.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[13], mat2x3(6.0, 5.0, -8.0, -1.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[14], mat2x3(-2.0, -2.0, 2.0, 9.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[15], mat2x3(-5.0, -3.0, -1.0, 9.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[16], mat2x3(9.0, 2.0, -2.0, 6.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[17], mat2x3(9.0, -1.0, -8.0, 7.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[18], mat2x3(9.0, -9.0, -8.0, -9.0, -7.0, -3.0)) && allOk;
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
	allOk = compare_float(block.var[0][0], 9.0) && allOk;
	allOk = compare_float(block.var[0][1], 7.0) && allOk;
	allOk = compare_float(block.var[0][2], 8.0) && allOk;
	allOk = compare_float(block.var[0][3], -7.0) && allOk;
	allOk = compare_float(block.var[1][0], 6.0) && allOk;
	allOk = compare_float(block.var[1][1], 0.0) && allOk;
	allOk = compare_float(block.var[1][2], -7.0) && allOk;
	allOk = compare_float(block.var[1][3], -4.0) && allOk;
	allOk = compare_float(block.var[2][0], -9.0) && allOk;
	allOk = compare_float(block.var[2][1], -9.0) && allOk;
	allOk = compare_float(block.var[2][2], -8.0) && allOk;
	allOk = compare_float(block.var[2][3], 6.0) && allOk;
	allOk = compare_float(block.var[3][0], 7.0) && allOk;
	allOk = compare_float(block.var[3][1], 0.0) && allOk;
	allOk = compare_float(block.var[3][2], 3.0) && allOk;
	allOk = compare_float(block.var[3][3], 1.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(9.0, 7.0, 8.0, -7.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(6.0, 0.0, -7.0, -4.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(-9.0, -9.0, -8.0, 6.0)) && allOk;
	allOk = compare_vec4(block.var[3], vec4(7.0, 0.0, 3.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4(9.0, 1.0, -6.0, 1.0, 1.0, 8.0, -8.0, -6.0, 2.0, -9.0, 7.0, -2.0, 8.0, 7.0, 2.0, -8.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 0.0) && allOk;
	allOk = compare_float(block.var[0][1], 7.0) && allOk;
	allOk = compare_float(block.var[0][2], -1.0) && allOk;
	allOk = compare_float(block.var[0][3], 4.0) && allOk;
	allOk = compare_float(block.var[1][0], -3.0) && allOk;
	allOk = compare_float(block.var[1][1], 5.0) && allOk;
	allOk = compare_float(block.var[1][2], -4.0) && allOk;
	allOk = compare_float(block.var[1][3], -3.0) && allOk;
	allOk = compare_float(block.var[2][0], 2.0) && allOk;
	allOk = compare_float(block.var[2][1], -6.0) && allOk;
	allOk = compare_float(block.var[2][2], -1.0) && allOk;
	allOk = compare_float(block.var[2][3], -7.0) && allOk;
	allOk = compare_float(block.var[3][0], -4.0) && allOk;
	allOk = compare_float(block.var[3][1], 5.0) && allOk;
	allOk = compare_float(block.var[3][2], -7.0) && allOk;
	allOk = compare_float(block.var[3][3], 1.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(0.0, 7.0, -1.0, 4.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-3.0, 5.0, -4.0, -3.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(2.0, -6.0, -1.0, -7.0)) && allOk;
	allOk = compare_vec4(block.var[3], vec4(-4.0, 5.0, -7.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(2.0, 6.0, -8.0, 9.0));
	block.var[1] = (vec4(-8.0, 4.0, -8.0, 7.0));
	block.var[2] = (vec4(9.0, -7.0, -2.0, -7.0));
	block.var[3] = (vec4(0.0, -7.0, 7.0, -8.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 6.0) && allOk;
	allOk = compare_float(block.var[0][1], -5.0) && allOk;
	allOk = compare_float(block.var[0][2], 5.0) && allOk;
	allOk = compare_float(block.var[0][3], 2.0) && allOk;
	allOk = compare_float(block.var[1][0], -5.0) && allOk;
	allOk = compare_float(block.var[1][1], -9.0) && allOk;
	allOk = compare_float(block.var[1][2], -2.0) && allOk;
	allOk = compare_float(block.var[1][3], 2.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(6.0, -5.0, 5.0, 2.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-5.0, -9.0, -2.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(-5.0, 0.0, 6.0, -3.0));
	block.var[1] = (vec4(-7.0, -8.0, 7.0, -1.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var, mat2x4(6.0, -3.0, -8.0, 0.0, 2.0, 7.0, -2.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x4(-7.0, 6.0, 2.0, -6.0, 9.0, 7.0, 1.0, -6.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -4.0) && allOk;
	allOk = compare_float(block.var[0][1], -6.0) && allOk;
	allOk = compare_float(block.var[0][2], -1.0) && allOk;
	allOk = compare_float(block.var[1][0], 3.0) && allOk;
	allOk = compare_float(block.var[1][1], 4.0) && allOk;
	allOk = compare_float(block.var[1][2], -7.0) && allOk;
	allOk = compare_float(block.var[2][0], 1.0) && allOk;
	allOk = compare_float(block.var[2][1], -6.0) && allOk;
	allOk = compare_float(block.var[2][2], -2.0) && allOk;
	allOk = compare_float(block.var[3][0], 7.0) && allOk;
	allOk = compare_float(block.var[3][1], 2.0) && allOk;
	allOk = compare_float(block.var[3][2], -6.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-4.0, -6.0, -1.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(3.0, 4.0, -7.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(1.0, -6.0, -2.0)) && allOk;
	allOk = compare_vec3(block.var[3], vec3(7.0, 2.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x3(-9.0, -4.0, -9.0, -4.0, 5.0, -3.0, -8.0, 5.0, -3.0, -8.0, 2.0, -9.0));
}
#version 450
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
	allOk = compare_mat2(block.var, mat2(0.0, -4.0, 9.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2(-2.0, -4.0, -8.0, -2.0));
}
#version 450
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
	allOk = compare_mat3(block.var, mat3(8.0, -9.0, -3.0, 9.0, -7.0, 0.0, -4.0, -9.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(7.0, 2.0, 0.0));
	block.var[1] = (vec3(-9.0, -8.0, 0.0));
	block.var[2] = (vec3(3.0, 2.0, 6.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 6.0) && allOk;
	allOk = compare_float(block.var[0][1], 9.0) && allOk;
	allOk = compare_float(block.var[0][2], -7.0) && allOk;
	allOk = compare_float(block.var[1][0], 8.0) && allOk;
	allOk = compare_float(block.var[1][1], 9.0) && allOk;
	allOk = compare_float(block.var[1][2], -1.0) && allOk;
	allOk = compare_float(block.var[2][0], -7.0) && allOk;
	allOk = compare_float(block.var[2][1], 5.0) && allOk;
	allOk = compare_float(block.var[2][2], 9.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(6.0, 9.0, -7.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(8.0, 9.0, -1.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(-7.0, 5.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(9.0, 3.0, 2.0));
	block.var[1] = (vec3(5.0, 0.0, -9.0));
	block.var[2] = (vec3(-5.0, -3.0, 2.0));
}
#version 450
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
	allOk = compare_mat4(block.var, mat4(5.0, 3.0, 1.0, 5.0, -4.0, 3.0, -7.0, 3.0, -7.0, -6.0, 6.0, -4.0, 1.0, 8.0, -5.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(-2.0, 8.0, -3.0, -1.0));
	block.var[1] = (vec4(6.0, -9.0, -1.0, -9.0));
	block.var[2] = (vec4(-4.0, -3.0, 5.0, 3.0));
	block.var[3] = (vec4(7.0, 6.0, 9.0, 0.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block.var[0][0], 1.0) && allOk;
	allOk = compare_float(block.var[0][1], -6.0) && allOk;
	allOk = compare_float(block.var[0][2], -4.0) && allOk;
	allOk = compare_float(block.var[1][0], 5.0) && allOk;
	allOk = compare_float(block.var[1][1], 0.0) && allOk;
	allOk = compare_float(block.var[1][2], -1.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(1.0, -6.0, -4.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(5.0, 0.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x3(3.0, 0.0, 3.0, 5.0, 3.0, -5.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var, mat4x2(-7.0, 8.0, 6.0, 0.0, 0.0, 2.0, -4.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x2(-1.0, -4.0, 5.0, 9.0, -4.0, -2.0, 6.0, -6.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var, mat4x2(1.0, 9.0, -9.0, 3.0, 0.0, 7.0, -1.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x2(6.0, -6.0, 7.0, 3.0, 8.0, 3.0, -6.0, 3.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 2.0) && allOk;
	allOk = compare_float(block.var[0][1], 9.0) && allOk;
	allOk = compare_float(block.var[1][0], 8.0) && allOk;
	allOk = compare_float(block.var[1][1], -2.0) && allOk;
	allOk = compare_float(block.var[2][0], 6.0) && allOk;
	allOk = compare_float(block.var[2][1], -2.0) && allOk;
	allOk = compare_float(block.var[3][0], -8.0) && allOk;
	allOk = compare_float(block.var[3][1], 1.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(2.0, 9.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(8.0, -2.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(6.0, -2.0)) && allOk;
	allOk = compare_vec2(block.var[3], vec2(-8.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x2(-7.0, 1.0, 7.0, -9.0, 8.0, -3.0, -3.0, 4.0));
}
#version 450
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
	i16vec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(block.var), ivec3(3, 4, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = i16vec3(ivec3(6, 1, -2));
}
#version 450
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
	allOk = compare_float((block.padding), 5.0) && allOk;
	allOk = compare_float(block.var[0][0], -6.0) && allOk;
	allOk = compare_float(block.var[0][1], -4.0) && allOk;
	allOk = compare_float(block.var[0][2], -4.0) && allOk;
	allOk = compare_float(block.var[0][3], -4.0) && allOk;
	allOk = compare_float(block.var[1][0], 9.0) && allOk;
	allOk = compare_float(block.var[1][1], -1.0) && allOk;
	allOk = compare_float(block.var[1][2], -9.0) && allOk;
	allOk = compare_float(block.var[1][3], -4.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-6.0, -4.0, -4.0, -4.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(9.0, -1.0, -9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (1.0);
	block.var = (mat2x4(9.0, 1.0, -5.0, 4.0, -8.0, -5.0, -2.0, 7.0));
}
#version 450
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
	allOk = compare_float((block.padding), 3.0) && allOk;
	allOk = compare_mat3x2(block.var, mat3x2(-5.0, -7.0, -2.0, 6.0, -3.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-5.0);
	block.var = (mat3x2(7.0, 6.0, -7.0, 5.0, 0.0, -8.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.padding), 3.0) && allOk;
	allOk = compare_mat4x3(block.var, mat4x3(9.0, 0.0, 0.0, 0.0, -4.0, 3.0, 0.0, 0.0, -6.0, 8.0, -1.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-8.0);
	block.var[0] = (vec3(8.0, 5.0, -4.0));
	block.var[1] = (vec3(7.0, -3.0, -3.0));
	block.var[2] = (vec3(2.0, -7.0, 4.0));
	block.var[3] = (vec3(1.0, -9.0, -7.0));
}
#version 450
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
	allOk = compare_float((block.padding), -5.0) && allOk;
	allOk = compare_float(block.var[0][0], -7.0) && allOk;
	allOk = compare_float(block.var[0][1], -6.0) && allOk;
	allOk = compare_float(block.var[0][2], 9.0) && allOk;
	allOk = compare_float(block.var[1][0], 3.0) && allOk;
	allOk = compare_float(block.var[1][1], -4.0) && allOk;
	allOk = compare_float(block.var[1][2], 9.0) && allOk;
	allOk = compare_float(block.var[2][0], 6.0) && allOk;
	allOk = compare_float(block.var[2][1], -6.0) && allOk;
	allOk = compare_float(block.var[2][2], 1.0) && allOk;
	allOk = compare_float(block.var[3][0], 8.0) && allOk;
	allOk = compare_float(block.var[3][1], 1.0) && allOk;
	allOk = compare_float(block.var[3][2], 2.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-7.0, -6.0, 9.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(3.0, -4.0, 9.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(6.0, -6.0, 1.0)) && allOk;
	allOk = compare_vec3(block.var[3], vec3(8.0, 1.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (0.0);
	block.var = (mat4x3(7.0, -1.0, 6.0, -7.0, 7.0, -9.0, -9.0, 4.0, 1.0, 2.0, -2.0, -1.0));
}
#version 450
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
	highp uvec4 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((block.var[0]), uvec4(4u, 1u, 8u, 2u)) && allOk;
	allOk = compare_uvec4((block.var[1]), uvec4(1u, 9u, 5u, 9u)) && allOk;
	allOk = compare_uvec4((block.var[2]), uvec4(3u, 6u, 5u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (uvec4(2u, 7u, 2u, 9u));
	block.var[1] = (uvec4(7u, 9u, 5u, 1u));
	block.var[2] = (uvec4(3u, 4u, 4u, 2u));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0], mat2x3(-2.0, 3.0, -3.0, 8.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1], mat2x3(-4.0, -6.0, -3.0, -8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[2], mat2x3(1.0, -5.0, 8.0, -3.0, 0.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2x3(0.0, 4.0, 4.0, 5.0, -5.0, 2.0));
	block.var[1] = (mat2x3(8.0, -1.0, -2.0, -7.0, -8.0, -2.0));
	block.var[2] = (mat2x3(2.0, -2.0, 7.0, -9.0, 7.0, -7.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0], mat2x4(-3.0, 3.0, 6.0, 0.0, -2.0, 1.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(0.0, -1.0, 3.0, 9.0, 1.0, 1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(6.0, 1.0, -8.0, 2.0, 2.0, -6.0, 0.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec4(2.0, 1.0, 7.0, 1.0));
	block.var[0][1] = (vec4(-1.0, -8.0, 7.0, 5.0));
	block.var[1][0] = (vec4(-7.0, 2.0, -1.0, 4.0));
	block.var[1][1] = (vec4(7.0, -4.0, 8.0, -2.0));
	block.var[2][0] = (vec4(2.0, 5.0, -2.0, 1.0));
	block.var[2][1] = (vec4(1.0, 0.0, -4.0, 1.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0], mat3x2(-4.0, 6.0, 0.0, 6.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1], mat3x2(5.0, -1.0, 1.0, 7.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[2], mat3x2(4.0, -5.0, -2.0, -4.0, 6.0, 2.0)) && allOk;
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
}
#version 450
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
	allOk = compare_mat3x4(block.var[0], mat3x4(9.0, -4.0, -6.0, 2.0, -9.0, -8.0, 7.0, 0.0, 5.0, 3.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1], mat3x4(9.0, -7.0, 0.0, 6.0, -3.0, 8.0, 6.0, -6.0, -6.0, -4.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[2], mat3x4(-7.0, 5.0, -6.0, 7.0, -4.0, -9.0, -9.0, -4.0, -8.0, -8.0, 3.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3x4(3.0, -9.0, -6.0, 7.0, 6.0, -8.0, -1.0, 1.0, -9.0, 7.0, 6.0, 6.0));
	block.var[1] = (mat3x4(-5.0, -1.0, -8.0, 3.0, 9.0, 9.0, -8.0, 0.0, 0.0, -9.0, -6.0, -7.0));
	block.var[2] = (mat3x4(-3.0, -3.0, 9.0, -7.0, 4.0, 2.0, -8.0, 4.0, -6.0, -1.0, -9.0, 5.0));
}
#version 450
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
	allOk = compare_float((block.padding), -4.0) && allOk;
	allOk = compare_mat3x2(block.var[0], mat3x2(0.0, 6.0, 4.0, 7.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1], mat3x2(1.0, 7.0, -4.0, 9.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[2], mat3x2(-2.0, -4.0, 6.0, 2.0, -5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (9.0);
	block.var[0][0] = (vec2(-7.0, 8.0));
	block.var[0][1] = (vec2(-2.0, -9.0));
	block.var[0][2] = (vec2(-4.0, -1.0));
	block.var[1][0] = (vec2(-3.0, -3.0));
	block.var[1][1] = (vec2(-8.0, 2.0));
	block.var[1][2] = (vec2(7.0, -2.0));
	block.var[2][0] = (vec2(-3.0, -3.0));
	block.var[2][1] = (vec2(-4.0, 5.0));
	block.var[2][2] = (vec2(-1.0, 9.0));
}
#version 450
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
	bvec2 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((block.var[0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[3]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[4]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[5]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((block.var[6]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[7]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[8]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[9]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[10]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[11]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[12]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[13]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[14]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[15]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[16]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((block.var[17]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((block.var[18]), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (bvec2(true, false));
	block.var[1] = (bvec2(true, true));
	block.var[2] = (bvec2(false, false));
	block.var[3] = (bvec2(false, false));
	block.var[4] = (bvec2(false, true));
	block.var[5] = (bvec2(true, true));
	block.var[6] = (bvec2(false, false));
	block.var[7] = (bvec2(false, true));
	block.var[8] = (bvec2(true, true));
	block.var[9] = (bvec2(false, false));
	block.var[10] = (bvec2(true, false));
	block.var[11] = (bvec2(true, false));
	block.var[12] = (bvec2(false, true));
	block.var[13] = (bvec2(true, true));
	block.var[14] = (bvec2(false, false));
	block.var[15] = (bvec2(true, true));
	block.var[16] = (bvec2(true, false));
	block.var[17] = (bvec2(false, false));
	block.var[18] = (bvec2(true, false));
}
#version 450
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
	allOk = compare_mat3(block.var[0], mat3(2.0, 0.0, -4.0, -3.0, 4.0, 5.0, -1.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(-1.0, 4.0, -4.0, -3.0, 0.0, -1.0, -5.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(2.0, 4.0, -3.0, 8.0, 3.0, -2.0, -1.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[3], mat3(2.0, 8.0, 1.0, -3.0, -4.0, 7.0, -1.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[4], mat3(-6.0, -6.0, -5.0, 5.0, -2.0, 0.0, 7.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[5], mat3(-3.0, 9.0, 7.0, 8.0, -9.0, -1.0, -4.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[6], mat3(-1.0, 8.0, 3.0, 2.0, -6.0, -2.0, -2.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[7], mat3(-9.0, 0.0, 6.0, -9.0, -5.0, 8.0, -7.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[8], mat3(-7.0, 6.0, 2.0, 5.0, 4.0, 9.0, 7.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[9], mat3(1.0, -6.0, -3.0, -1.0, 6.0, 0.0, -2.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[10], mat3(2.0, 1.0, 9.0, -4.0, -9.0, 2.0, 5.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[11], mat3(0.0, 9.0, 5.0, 1.0, 2.0, 2.0, -5.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[12], mat3(5.0, 9.0, 9.0, 5.0, -5.0, 9.0, 1.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[13], mat3(8.0, 8.0, -6.0, 5.0, 4.0, 8.0, -9.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[14], mat3(2.0, 8.0, -1.0, -2.0, -4.0, 3.0, 5.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[15], mat3(8.0, 0.0, -9.0, -4.0, -9.0, 0.0, 9.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[16], mat3(-2.0, -2.0, -5.0, -6.0, -1.0, -4.0, 8.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[17], mat3(5.0, 2.0, 4.0, -8.0, 2.0, -4.0, -7.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[18], mat3(2.0, 2.0, 9.0, -8.0, -2.0, -1.0, 8.0, 3.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec3(3.0, -9.0, 3.0));
	block.var[0][1] = (vec3(2.0, 4.0, 6.0));
	block.var[0][2] = (vec3(2.0, -9.0, 0.0));
	block.var[1][0] = (vec3(-7.0, 3.0, -3.0));
	block.var[1][1] = (vec3(-4.0, -4.0, 5.0));
	block.var[1][2] = (vec3(-4.0, 1.0, -7.0));
	block.var[2][0] = (vec3(7.0, 9.0, -7.0));
	block.var[2][1] = (vec3(8.0, 2.0, 5.0));
	block.var[2][2] = (vec3(-9.0, 7.0, -2.0));
	block.var[3][0] = (vec3(-7.0, 3.0, 4.0));
	block.var[3][1] = (vec3(-1.0, 1.0, 0.0));
	block.var[3][2] = (vec3(7.0, 7.0, 9.0));
	block.var[4][0] = (vec3(4.0, 4.0, -3.0));
	block.var[4][1] = (vec3(9.0, 1.0, -6.0));
	block.var[4][2] = (vec3(7.0, -6.0, -1.0));
	block.var[5][0] = (vec3(-5.0, -2.0, -7.0));
	block.var[5][1] = (vec3(-8.0, -9.0, 6.0));
	block.var[5][2] = (vec3(2.0, -2.0, -7.0));
	block.var[6][0] = (vec3(6.0, -2.0, -1.0));
	block.var[6][1] = (vec3(9.0, 2.0, -4.0));
	block.var[6][2] = (vec3(-9.0, -5.0, 4.0));
	block.var[7][0] = (vec3(-1.0, -6.0, 9.0));
	block.var[7][1] = (vec3(-1.0, 3.0, 0.0));
	block.var[7][2] = (vec3(-7.0, 1.0, -6.0));
	block.var[8][0] = (vec3(0.0, -6.0, 0.0));
	block.var[8][1] = (vec3(8.0, 6.0, 4.0));
	block.var[8][2] = (vec3(7.0, -4.0, 4.0));
	block.var[9][0] = (vec3(-6.0, 3.0, -3.0));
	block.var[9][1] = (vec3(0.0, -8.0, 6.0));
	block.var[9][2] = (vec3(-7.0, -2.0, 7.0));
	block.var[10][0] = (vec3(4.0, -8.0, 1.0));
	block.var[10][1] = (vec3(-6.0, 7.0, 1.0));
	block.var[10][2] = (vec3(6.0, 3.0, 0.0));
	block.var[11][0] = (vec3(-2.0, -9.0, 9.0));
	block.var[11][1] = (vec3(1.0, 3.0, 4.0));
	block.var[11][2] = (vec3(5.0, -3.0, -6.0));
	block.var[12][0] = (vec3(-7.0, 1.0, -4.0));
	block.var[12][1] = (vec3(8.0, -5.0, 4.0));
	block.var[12][2] = (vec3(1.0, -7.0, 3.0));
	block.var[13][0] = (vec3(-3.0, -3.0, 6.0));
	block.var[13][1] = (vec3(8.0, 1.0, -8.0));
	block.var[13][2] = (vec3(5.0, 9.0, -2.0));
	block.var[14][0] = (vec3(4.0, -7.0, 4.0));
	block.var[14][1] = (vec3(-6.0, 5.0, -4.0));
	block.var[14][2] = (vec3(5.0, -3.0, 3.0));
	block.var[15][0] = (vec3(8.0, 6.0, 1.0));
	block.var[15][1] = (vec3(6.0, 5.0, 1.0));
	block.var[15][2] = (vec3(7.0, 9.0, 0.0));
	block.var[16][0] = (vec3(-7.0, 8.0, 6.0));
	block.var[16][1] = (vec3(4.0, -8.0, -8.0));
	block.var[16][2] = (vec3(8.0, 9.0, -9.0));
	block.var[17][0] = (vec3(-8.0, -3.0, -7.0));
	block.var[17][1] = (vec3(4.0, -6.0, -4.0));
	block.var[17][2] = (vec3(-6.0, 0.0, 0.0));
	block.var[18][0] = (vec3(-3.0, -9.0, 1.0));
	block.var[18][1] = (vec3(-2.0, 3.0, -3.0));
	block.var[18][2] = (vec3(-1.0, 5.0, -8.0));
}
#version 450
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
	highp mat2 var[];
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
	allOk = compare_mat2(block.var[0], mat2(-7.0, -2.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(0.0, 4.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(-2.0, -1.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[3], mat2(6.0, -4.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[4], mat2(3.0, 2.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[5], mat2(8.0, -3.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[6], mat2(2.0, -7.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[7], mat2(-7.0, 8.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[8], mat2(3.0, -1.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[9], mat2(2.0, -7.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[10], mat2(1.0, 7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[11], mat2(-5.0, -4.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[12], mat2(-8.0, 7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[13], mat2(-8.0, 1.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[14], mat2(-3.0, -8.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[15], mat2(5.0, -3.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[16], mat2(-9.0, 0.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[17], mat2(9.0, 6.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[18], mat2(4.0, 4.0, -9.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2(1.0, 2.0, 6.0, -6.0));
	block.var[1] = (mat2(2.0, 4.0, 4.0, 7.0));
	block.var[2] = (mat2(0.0, 8.0, 0.0, -1.0));
	block.var[3] = (mat2(8.0, -4.0, -5.0, 7.0));
	block.var[4] = (mat2(-3.0, -1.0, 0.0, 6.0));
	block.var[5] = (mat2(-6.0, 7.0, 4.0, -7.0));
	block.var[6] = (mat2(1.0, -8.0, -9.0, -7.0));
	block.var[7] = (mat2(1.0, -2.0, -6.0, -8.0));
	block.var[8] = (mat2(-6.0, -6.0, 2.0, -9.0));
	block.var[9] = (mat2(9.0, 0.0, -3.0, -7.0));
	block.var[10] = (mat2(8.0, 8.0, 7.0, -3.0));
	block.var[11] = (mat2(7.0, 2.0, -8.0, -7.0));
	block.var[12] = (mat2(5.0, 1.0, -7.0, -2.0));
	block.var[13] = (mat2(-8.0, -9.0, 4.0, -4.0));
	block.var[14] = (mat2(-7.0, -9.0, -5.0, 3.0));
	block.var[15] = (mat2(-1.0, -1.0, -6.0, -3.0));
	block.var[16] = (mat2(-9.0, -4.0, -8.0, -1.0));
	block.var[17] = (mat2(-8.0, 1.0, -2.0, 9.0));
	block.var[18] = (mat2(9.0, 4.0, -3.0, -3.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0], mat3x4(5.0, -7.0, -9.0, 4.0, 5.0, 3.0, -7.0, -3.0, 7.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1], mat3x4(-9.0, 7.0, -4.0, 5.0, -9.0, -5.0, 2.0, 6.0, -3.0, -5.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[2], mat3x4(4.0, 1.0, 3.0, -1.0, -3.0, -2.0, 2.0, 7.0, 5.0, -1.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[3], mat3x4(5.0, 1.0, -8.0, -9.0, -6.0, 4.0, 0.0, -9.0, 0.0, -1.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[4], mat3x4(-3.0, 6.0, 3.0, 0.0, -4.0, 2.0, 4.0, 3.0, -4.0, 9.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[5], mat3x4(-1.0, 6.0, 5.0, -4.0, -5.0, 7.0, -4.0, -5.0, 8.0, -9.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[6], mat3x4(2.0, 3.0, 2.0, 5.0, -4.0, -4.0, 2.0, 8.0, 5.0, -5.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[7], mat3x4(-3.0, 3.0, -2.0, 6.0, 9.0, -7.0, 8.0, 8.0, 1.0, 9.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[8], mat3x4(1.0, -2.0, 4.0, 2.0, 7.0, -2.0, -9.0, 6.0, -4.0, 0.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[9], mat3x4(6.0, -8.0, 1.0, 3.0, 2.0, -7.0, 4.0, -9.0, -7.0, 0.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[10], mat3x4(-8.0, 4.0, 3.0, 2.0, 2.0, 0.0, -5.0, -4.0, 7.0, 3.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[11], mat3x4(2.0, 0.0, -3.0, 3.0, -7.0, 7.0, -8.0, 9.0, -2.0, 5.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[12], mat3x4(-3.0, -7.0, 5.0, 2.0, -5.0, 9.0, -1.0, -1.0, 1.0, -7.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[13], mat3x4(2.0, 0.0, 8.0, -9.0, 5.0, -4.0, 5.0, -7.0, 0.0, 5.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[14], mat3x4(3.0, 6.0, -3.0, 3.0, 9.0, -1.0, -3.0, 6.0, -9.0, 9.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[15], mat3x4(-2.0, 8.0, 5.0, -9.0, 0.0, -8.0, 8.0, -8.0, 6.0, -2.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[16], mat3x4(-5.0, -3.0, 9.0, 7.0, 1.0, -1.0, -8.0, -6.0, 5.0, 0.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[17], mat3x4(5.0, -7.0, -3.0, -7.0, 3.0, 9.0, -6.0, -7.0, -4.0, 4.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[18], mat3x4(3.0, 5.0, -2.0, -6.0, -7.0, -4.0, 6.0, 5.0, -9.0, 2.0, 7.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3x4(0.0, 2.0, -8.0, -3.0, 5.0, -1.0, 3.0, -5.0, -9.0, -7.0, 8.0, -9.0));
	block.var[1] = (mat3x4(0.0, -5.0, 1.0, -9.0, -1.0, 4.0, 7.0, 4.0, -4.0, -6.0, 0.0, -5.0));
	block.var[2] = (mat3x4(-7.0, 5.0, -9.0, -3.0, -7.0, 7.0, 1.0, -4.0, 7.0, -8.0, -2.0, -9.0));
	block.var[3] = (mat3x4(0.0, -2.0, -8.0, -5.0, 0.0, 5.0, -2.0, -1.0, 5.0, 8.0, -3.0, 1.0));
	block.var[4] = (mat3x4(-1.0, 7.0, 7.0, 7.0, 2.0, -7.0, 8.0, -3.0, -8.0, -2.0, -5.0, -6.0));
	block.var[5] = (mat3x4(5.0, 8.0, 9.0, 8.0, 7.0, 0.0, 9.0, 7.0, -3.0, -7.0, -6.0, -5.0));
	block.var[6] = (mat3x4(-7.0, -8.0, -2.0, 9.0, -8.0, 3.0, 9.0, 9.0, 5.0, -8.0, -1.0, 2.0));
	block.var[7] = (mat3x4(1.0, 5.0, 7.0, 5.0, -4.0, -7.0, -5.0, -9.0, -1.0, 6.0, 2.0, 4.0));
	block.var[8] = (mat3x4(-1.0, 2.0, 3.0, -5.0, -6.0, -4.0, 4.0, -7.0, -1.0, 8.0, -9.0, 2.0));
	block.var[9] = (mat3x4(-2.0, 9.0, -8.0, 3.0, -5.0, 6.0, -8.0, 3.0, -8.0, 6.0, 6.0, -8.0));
	block.var[10] = (mat3x4(-3.0, 2.0, 8.0, 3.0, -1.0, 0.0, -7.0, 5.0, 3.0, 2.0, 9.0, -2.0));
	block.var[11] = (mat3x4(-7.0, -5.0, -3.0, 6.0, -7.0, -8.0, -4.0, 1.0, 0.0, 0.0, 1.0, 9.0));
	block.var[12] = (mat3x4(-3.0, -3.0, -1.0, -2.0, 7.0, 1.0, 7.0, 0.0, -9.0, 2.0, -2.0, -6.0));
	block.var[13] = (mat3x4(4.0, -5.0, -8.0, -9.0, 4.0, 2.0, -1.0, -3.0, 9.0, -6.0, -9.0, -8.0));
	block.var[14] = (mat3x4(7.0, 6.0, -3.0, -6.0, -1.0, 2.0, 7.0, -9.0, -3.0, -4.0, -1.0, 0.0));
	block.var[15] = (mat3x4(-7.0, 4.0, 3.0, -4.0, 4.0, 2.0, -4.0, -3.0, 8.0, 9.0, 9.0, 8.0));
	block.var[16] = (mat3x4(1.0, 2.0, 5.0, 6.0, 8.0, 4.0, 6.0, -3.0, 6.0, -7.0, 9.0, -9.0));
	block.var[17] = (mat3x4(-9.0, -8.0, 4.0, 0.0, -8.0, 2.0, 2.0, -2.0, -7.0, 9.0, 5.0, -9.0));
	block.var[18] = (mat3x4(-9.0, -9.0, 8.0, -1.0, 9.0, 2.0, -9.0, -3.0, -9.0, -1.0, 3.0, -2.0));
}
#version 450
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
	highp float var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.var[0]), 7.0) && allOk;
	allOk = compare_float((block.var[1]), -1.0) && allOk;
	allOk = compare_float((block.var[2]), -6.0) && allOk;
	allOk = compare_float((block.var[3]), 0.0) && allOk;
	allOk = compare_float((block.var[4]), -7.0) && allOk;
	allOk = compare_float((block.var[5]), 5.0) && allOk;
	allOk = compare_float((block.var[6]), 4.0) && allOk;
	allOk = compare_float((block.var[7]), 2.0) && allOk;
	allOk = compare_float((block.var[8]), -1.0) && allOk;
	allOk = compare_float((block.var[9]), -6.0) && allOk;
	allOk = compare_float((block.var[10]), -2.0) && allOk;
	allOk = compare_float((block.var[11]), -1.0) && allOk;
	allOk = compare_float((block.var[12]), 1.0) && allOk;
	allOk = compare_float((block.var[13]), -3.0) && allOk;
	allOk = compare_float((block.var[14]), -7.0) && allOk;
	allOk = compare_float((block.var[15]), 8.0) && allOk;
	allOk = compare_float((block.var[16]), -9.0) && allOk;
	allOk = compare_float((block.var[17]), -4.0) && allOk;
	allOk = compare_float((block.var[18]), -4.0) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (-2.0);
	block.var[1] = (4.0);
	block.var[2] = (6.0);
	block.var[3] = (7.0);
	block.var[4] = (-4.0);
	block.var[5] = (5.0);
	block.var[6] = (-8.0);
	block.var[7] = (9.0);
	block.var[8] = (-5.0);
	block.var[9] = (8.0);
	block.var[10] = (-5.0);
	block.var[11] = (6.0);
	block.var[12] = (-6.0);
	block.var[13] = (-9.0);
	block.var[14] = (-4.0);
	block.var[15] = (3.0);
	block.var[16] = (7.0);
	block.var[17] = (6.0);
	block.var[18] = (5.0);
}
#version 450
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
	allOk = compare_float((block.padding), -5.0) && allOk;
	allOk = compare_mat2(block.var[0][0], mat2(-2.0, -2.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[0][1], mat2(-4.0, 8.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[0][2], mat2(9.0, 7.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[1][0], mat2(-3.0, -9.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[1][1], mat2(-8.0, -8.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[1][2], mat2(-2.0, -9.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[2][0], mat2(8.0, -4.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[2][1], mat2(-8.0, -4.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[2][2], mat2(-4.0, -4.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[3][0], mat2(3.0, -4.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[3][1], mat2(-3.0, 4.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[3][2], mat2(-5.0, 0.0, -4.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-2.0);
	block.var[0][0] = (mat2(-8.0, -7.0, 9.0, 2.0));
	block.var[0][1] = (mat2(2.0, -4.0, -5.0, -1.0));
	block.var[0][2] = (mat2(-4.0, 0.0, -1.0, 0.0));
	block.var[1][0] = (mat2(4.0, -3.0, -4.0, -6.0));
	block.var[1][1] = (mat2(0.0, 5.0, 1.0, -6.0));
	block.var[1][2] = (mat2(9.0, 5.0, 9.0, 5.0));
	block.var[2][0] = (mat2(-3.0, -3.0, 6.0, -4.0));
	block.var[2][1] = (mat2(-6.0, -2.0, -6.0, -3.0));
	block.var[2][2] = (mat2(-4.0, -7.0, -9.0, 8.0));
	block.var[3][0] = (mat2(2.0, -6.0, 9.0, -5.0));
	block.var[3][1] = (mat2(-2.0, 4.0, 9.0, 4.0));
	block.var[3][2] = (mat2(7.0, 4.0, -8.0, 5.0));
}
#version 450
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
	allOk = compare_float((block.padding), -8.0) && allOk;
	allOk = compare_mat3x2(block.var[0][0], mat3x2(-5.0, -1.0, 5.0, 3.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1], mat3x2(-5.0, -1.0, -7.0, 3.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2], mat3x2(7.0, 0.0, 5.0, 0.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0], mat3x2(-5.0, -4.0, 5.0, 8.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1], mat3x2(-6.0, -8.0, -7.0, 9.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2], mat3x2(3.0, 6.0, 9.0, 1.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0], mat3x2(-8.0, -9.0, 9.0, -1.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1], mat3x2(8.0, -1.0, -4.0, -2.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2], mat3x2(8.0, 8.0, -5.0, -5.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0], mat3x2(8.0, -3.0, -8.0, -5.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1], mat3x2(7.0, 5.0, -3.0, 8.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][2], mat3x2(-3.0, -1.0, -1.0, -3.0, -3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-4.0);
	block.var[0][0][0] = (vec2(-6.0, 1.0));
	block.var[0][0][1] = (vec2(-3.0, -1.0));
	block.var[0][0][2] = (vec2(-9.0, 3.0));
	block.var[0][1][0] = (vec2(-2.0, 5.0));
	block.var[0][1][1] = (vec2(-8.0, 2.0));
	block.var[0][1][2] = (vec2(-9.0, 1.0));
	block.var[0][2][0] = (vec2(-5.0, 0.0));
	block.var[0][2][1] = (vec2(-2.0, 2.0));
	block.var[0][2][2] = (vec2(-1.0, -7.0));
	block.var[1][0][0] = (vec2(9.0, -8.0));
	block.var[1][0][1] = (vec2(7.0, 1.0));
	block.var[1][0][2] = (vec2(-9.0, -5.0));
	block.var[1][1][0] = (vec2(-5.0, 9.0));
	block.var[1][1][1] = (vec2(3.0, -3.0));
	block.var[1][1][2] = (vec2(-6.0, 1.0));
	block.var[1][2][0] = (vec2(3.0, -3.0));
	block.var[1][2][1] = (vec2(-4.0, -9.0));
	block.var[1][2][2] = (vec2(4.0, -2.0));
	block.var[2][0][0] = (vec2(-3.0, -5.0));
	block.var[2][0][1] = (vec2(1.0, -5.0));
	block.var[2][0][2] = (vec2(8.0, 7.0));
	block.var[2][1][0] = (vec2(8.0, -1.0));
	block.var[2][1][1] = (vec2(-3.0, -8.0));
	block.var[2][1][2] = (vec2(5.0, 6.0));
	block.var[2][2][0] = (vec2(6.0, 0.0));
	block.var[2][2][1] = (vec2(-8.0, -6.0));
	block.var[2][2][2] = (vec2(-4.0, -6.0));
	block.var[3][0][0] = (vec2(-5.0, 8.0));
	block.var[3][0][1] = (vec2(5.0, -9.0));
	block.var[3][0][2] = (vec2(0.0, 6.0));
	block.var[3][1][0] = (vec2(-3.0, 6.0));
	block.var[3][1][1] = (vec2(0.0, 1.0));
	block.var[3][1][2] = (vec2(6.0, 4.0));
	block.var[3][2][0] = (vec2(4.0, 0.0));
	block.var[3][2][1] = (vec2(-1.0, -2.0));
	block.var[3][2][2] = (vec2(2.0, -1.0));
}
#version 450
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
	allOk = compare_float((block.padding), 9.0) && allOk;
	allOk = compare_mat3x4(block.var[0][0], mat3x4(-4.0, -6.0, 2.0, -9.0, -8.0, 7.0, 0.0, 5.0, 3.0, 9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1], mat3x4(-7.0, 0.0, 6.0, -3.0, 8.0, 6.0, -6.0, -6.0, -4.0, 6.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2], mat3x4(5.0, -6.0, 7.0, -4.0, -9.0, -9.0, -4.0, -8.0, -8.0, 3.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0], mat3x4(6.0, 2.0, -2.0, -3.0, 2.0, 4.0, -3.0, 5.0, 5.0, -5.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1], mat3x4(9.0, 8.0, 1.0, -2.0, 9.0, 1.0, -5.0, -9.0, 9.0, -4.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2], mat3x4(0.0, 9.0, -6.0, -9.0, -7.0, -7.0, 1.0, 1.0, 2.0, 3.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0], mat3x4(6.0, -1.0, -2.0, -4.0, 0.0, 4.0, -8.0, 3.0, 4.0, -7.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1], mat3x4(7.0, 4.0, -4.0, 0.0, 2.0, -5.0, 4.0, 0.0, 7.0, 2.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2], mat3x4(-8.0, 6.0, -8.0, -3.0, -8.0, 4.0, 7.0, 5.0, -2.0, 1.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0], mat3x4(-4.0, 8.0, 5.0, -1.0, -5.0, -2.0, 2.0, -8.0, -8.0, -5.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1], mat3x4(-3.0, -1.0, -3.0, -7.0, -6.0, 1.0, -7.0, -1.0, 8.0, -3.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][2], mat3x4(-8.0, 0.0, 1.0, 7.0, -5.0, -6.0, 7.0, 5.0, -3.0, 8.0, 3.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (3.0);
	block.var[0][0] = (mat3x4(-9.0, -6.0, 7.0, 6.0, -8.0, -1.0, 1.0, -9.0, 7.0, 6.0, 6.0, -5.0));
	block.var[0][1] = (mat3x4(-1.0, -8.0, 3.0, 9.0, 9.0, -8.0, 0.0, 0.0, -9.0, -6.0, -7.0, -3.0));
	block.var[0][2] = (mat3x4(-3.0, 9.0, -7.0, 4.0, 2.0, -8.0, 4.0, -6.0, -1.0, -9.0, 5.0, -5.0));
	block.var[1][0] = (mat3x4(-5.0, -9.0, -1.0, -9.0, -3.0, 0.0, 2.0, 8.0, -5.0, 1.0, 4.0, -5.0));
	block.var[1][1] = (mat3x4(5.0, -5.0, 2.0, -8.0, -3.0, 6.0, 1.0, 0.0, 1.0, 4.0, 6.0, -9.0));
	block.var[1][2] = (mat3x4(-1.0, -9.0, -6.0, 8.0, -9.0, -4.0, -6.0, -6.0, -1.0, -3.0, -7.0, -4.0));
	block.var[2][0] = (mat3x4(2.0, -8.0, -7.0, -3.0, 6.0, 6.0, 8.0, -4.0, -1.0, 1.0, -9.0, 9.0));
	block.var[2][1] = (mat3x4(-2.0, 4.0, 3.0, -2.0, 8.0, -4.0, 5.0, -8.0, 8.0, -2.0, 7.0, -6.0));
	block.var[2][2] = (mat3x4(5.0, -8.0, -5.0, -7.0, -8.0, 3.0, 4.0, -7.0, 2.0, 3.0, 2.0, 9.0));
	block.var[3][0] = (mat3x4(2.0, -6.0, 4.0, 9.0, 6.0, 2.0, 0.0, 1.0, 0.0, -3.0, 2.0, -1.0));
	block.var[3][1] = (mat3x4(4.0, -6.0, 4.0, -1.0, 3.0, 1.0, 3.0, 6.0, -6.0, -9.0, -9.0, -9.0));
	block.var[3][2] = (mat3x4(1.0, -6.0, 4.0, 0.0, -2.0, -8.0, 9.0, 6.0, -9.0, 6.0, 7.0, -6.0));
}
#version 450
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
	allOk = compare_float((block.padding), -5.0) && allOk;
	allOk = compare_mat4x2(block.var[0][0], mat4x2(-2.0, -4.0, 7.0, -9.0, -9.0, -9.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1], mat4x2(-1.0, -5.0, -9.0, -2.0, -2.0, 2.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2], mat4x2(-8.0, -8.0, 1.0, 3.0, 0.0, -3.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0], mat4x2(-7.0, -1.0, 4.0, -3.0, -1.0, 6.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1], mat4x2(8.0, -9.0, -4.0, 3.0, -1.0, -4.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2], mat4x2(-6.0, 1.0, -7.0, 1.0, -4.0, 2.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0], mat4x2(-8.0, 7.0, 0.0, 5.0, 0.0, 9.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1], mat4x2(-5.0, -3.0, 3.0, -3.0, 8.0, -4.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2], mat4x2(0.0, 3.0, 5.0, 9.0, -9.0, 5.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0], mat4x2(-1.0, 3.0, 6.0, 8.0, -8.0, -2.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1], mat4x2(-9.0, -2.0, 8.0, -2.0, 7.0, 5.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][2], mat4x2(8.0, -6.0, -6.0, -3.0, -1.0, -8.0, -4.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (0.0);
	block.var[0][0] = (mat4x2(-3.0, -2.0, 2.0, -2.0, -3.0, 5.0, -5.0, 5.0));
	block.var[0][1] = (mat4x2(-6.0, -4.0, -1.0, 4.0, 7.0, -8.0, -2.0, -5.0));
	block.var[0][2] = (mat4x2(-1.0, -3.0, 6.0, -2.0, 0.0, -7.0, -7.0, 2.0));
	block.var[1][0] = (mat4x2(0.0, -6.0, 9.0, 1.0, -7.0, 4.0, -6.0, 5.0));
	block.var[1][1] = (mat4x2(-4.0, -3.0, 8.0, -6.0, -1.0, -6.0, 7.0, 4.0));
	block.var[1][2] = (mat4x2(7.0, -6.0, 5.0, -4.0, -7.0, 2.0, 1.0, 6.0));
	block.var[2][0] = (mat4x2(-3.0, -5.0, -7.0, -7.0, 4.0, -9.0, 7.0, 2.0));
	block.var[2][1] = (mat4x2(2.0, 9.0, 3.0, -1.0, -8.0, 1.0, -5.0, 6.0));
	block.var[2][2] = (mat4x2(2.0, -6.0, 4.0, -3.0, -6.0, -7.0, -8.0, -1.0));
	block.var[3][0] = (mat4x2(-4.0, -5.0, 2.0, -7.0, -1.0, 7.0, 1.0, 9.0));
	block.var[3][1] = (mat4x2(-3.0, -8.0, 4.0, 5.0, -9.0, 9.0, -3.0, 5.0));
	block.var[3][2] = (mat4x2(6.0, -5.0, 1.0, 0.0, 8.0, -9.0, -4.0, 2.0));
}
#version 450
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
	f16vec4 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(block.padding), -8.0) && allOk;
	allOk = compare_f16vec4(vec4(block.var[0][0]), vec4(-9.0, 9.0, -6.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[0][1]), vec4(-8.0, -8.0, -3.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[0][2]), vec4(6.0, 1.0, -8.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[1][0]), vec4(7.0, 5.0, -6.0, 7.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[1][1]), vec4(-4.0, -8.0, -4.0, -3.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[1][2]), vec4(6.0, -4.0, 5.0, 2.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[2][0]), vec4(3.0, -3.0, 4.0, 9.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[2][1]), vec4(-9.0, 0.0, 3.0, 2.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[2][2]), vec4(-2.0, -4.0, -2.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[3][0]), vec4(-9.0, -6.0, 4.0, 7.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[3][1]), vec4(5.0, -9.0, 9.0, 8.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[3][2]), vec4(7.0, 9.0, -4.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = float16_t(9.0);
	block.var[0][0] = f16vec4(vec4(-6.0, 2.0, -8.0, -7.0));
	block.var[0][1] = f16vec4(vec4(-4.0, 2.0, -5.0, 9.0));
	block.var[0][2] = f16vec4(vec4(1.0, -6.0, 3.0, -1.0));
	block.var[1][0] = f16vec4(vec4(4.0, -1.0, -8.0, 5.0));
	block.var[1][1] = f16vec4(vec4(8.0, 7.0, 0.0, 4.0));
	block.var[1][2] = f16vec4(vec4(-5.0, -6.0, -8.0, -6.0));
	block.var[2][0] = f16vec4(vec4(2.0, -4.0, 8.0, -4.0));
	block.var[2][1] = f16vec4(vec4(-1.0, 8.0, 9.0, 0.0));
	block.var[2][2] = f16vec4(vec4(0.0, -5.0, 5.0, 7.0));
	block.var[3][0] = f16vec4(vec4(-6.0, -7.0, -8.0, -3.0));
	block.var[3][1] = f16vec4(vec4(-4.0, -7.0, 0.0, -7.0));
	block.var[3][2] = f16vec4(vec4(-2.0, 7.0, -1.0, 8.0));
}
#version 450
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
	allOk = compare_mat3(block.var[0][0][0], mat3(-2.0, 7.0, 9.0, 1.0, -5.0, -1.0, 3.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(-8.0, -8.0, 2.0, 7.0, -6.0, -4.0, 7.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][2], mat3(-2.0, 2.0, -3.0, -3.0, 1.0, -3.0, -8.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(6.0, 7.0, -1.0, 8.0, 1.0, 1.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(-5.0, -4.0, -5.0, -1.0, 5.0, 1.0, 5.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][2], mat3(4.0, -8.0, -9.0, 5.0, 9.0, 1.0, -5.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(3.0, -6.0, -6.0, 5.0, 5.0, -8.0, -1.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(-6.0, 3.0, -5.0, 0.0, 5.0, 8.0, -9.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][2], mat3(-1.0, 4.0, -4.0, 9.0, 2.0, 5.0, 5.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(7.0, 6.0, -5.0, -8.0, -5.0, 4.0, -8.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(0.0, -8.0, 3.0, -4.0, -5.0, 7.0, -7.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][2], mat3(5.0, -3.0, 3.0, 7.0, 2.0, 8.0, 6.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(1.0, -6.0, -4.0, 8.0, -1.0, -9.0, -1.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(3.0, 8.0, -3.0, -7.0, 6.0, -6.0, 9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][2], mat3(-9.0, -1.0, -4.0, -4.0, -4.0, 9.0, 6.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(8.0, 2.0, -2.0, -2.0, 0.0, 9.0, 3.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(-7.0, -4.0, -3.0, 2.0, -3.0, 1.0, 2.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][2], mat3(0.0, 0.0, 7.0, -4.0, -1.0, -9.0, -6.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][0], mat3(4.0, -5.0, 6.0, 7.0, -8.0, 2.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][1], mat3(9.0, 7.0, 4.0, 2.0, 8.0, 1.0, -9.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][2], mat3(0.0, -6.0, 9.0, 7.0, 3.0, 2.0, -6.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][0], mat3(1.0, 7.0, -3.0, 4.0, 3.0, 4.0, -1.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][1], mat3(5.0, 3.0, -7.0, -1.0, 5.0, -5.0, 9.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][2], mat3(-4.0, 8.0, -8.0, -3.0, -9.0, 2.0, 5.0, 0.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3(-2.0, -7.0, 1.0, 7.0, 5.0, 2.0, 9.0, -1.0, -9.0));
	block.var[0][0][1] = (mat3(6.0, -5.0, 8.0, -1.0, -8.0, -8.0, 0.0, 9.0, 1.0));
	block.var[0][0][2] = (mat3(1.0, -4.0, 5.0, -6.0, -1.0, 9.0, -6.0, 0.0, 5.0));
	block.var[0][1][0] = (mat3(8.0, 0.0, -7.0, 0.0, -7.0, 5.0, -5.0, -2.0, -9.0));
	block.var[0][1][1] = (mat3(6.0, 5.0, 8.0, 2.0, 5.0, -8.0, 2.0, -9.0, -7.0));
	block.var[0][1][2] = (mat3(-8.0, 3.0, -4.0, 9.0, 2.0, 0.0, -3.0, -6.0, 4.0));
	block.var[1][0][0] = (mat3(-4.0, 3.0, -8.0, -9.0, 9.0, -7.0, -1.0, -9.0, -9.0));
	block.var[1][0][1] = (mat3(-2.0, 7.0, -3.0, 2.0, -6.0, -7.0, 4.0, 8.0, -8.0));
	block.var[1][0][2] = (mat3(6.0, 1.0, 9.0, 7.0, -9.0, 5.0, -9.0, 9.0, 1.0));
	block.var[1][1][0] = (mat3(6.0, -6.0, 5.0, -5.0, -5.0, -9.0, -4.0, -5.0, 7.0));
	block.var[1][1][1] = (mat3(-7.0, 5.0, 9.0, 0.0, -7.0, 7.0, 9.0, 9.0, 9.0));
	block.var[1][1][2] = (mat3(7.0, -1.0, 7.0, -4.0, 1.0, -3.0, 8.0, 0.0, 4.0));
	block.var[2][0][0] = (mat3(8.0, 7.0, -7.0, -4.0, 7.0, -5.0, 8.0, 3.0, -4.0));
	block.var[2][0][1] = (mat3(-5.0, 6.0, -1.0, 6.0, -8.0, 1.0, 7.0, 5.0, 7.0));
	block.var[2][0][2] = (mat3(1.0, 7.0, -1.0, -8.0, 9.0, -2.0, 7.0, 9.0, -5.0));
	block.var[2][1][0] = (mat3(-1.0, 1.0, 8.0, 9.0, 5.0, -2.0, -6.0, -8.0, -3.0));
	block.var[2][1][1] = (mat3(-7.0, 4.0, 8.0, -8.0, -8.0, -9.0, -8.0, -9.0, 0.0));
	block.var[2][1][2] = (mat3(5.0, 9.0, 0.0, -1.0, 0.0, -6.0, -7.0, -9.0, -2.0));
	block.var[3][0][0] = (mat3(8.0, 7.0, 6.0, -6.0, -1.0, -2.0, 9.0, 6.0, 0.0));
	block.var[3][0][1] = (mat3(-4.0, -3.0, -6.0, -5.0, -8.0, -6.0, 5.0, -5.0, 2.0));
	block.var[3][0][2] = (mat3(7.0, 5.0, -4.0, 7.0, 9.0, -8.0, -9.0, 8.0, -9.0));
	block.var[3][1][0] = (mat3(7.0, 9.0, -3.0, 3.0, -7.0, 4.0, 9.0, 3.0, -8.0));
	block.var[3][1][1] = (mat3(-1.0, 2.0, 8.0, 0.0, -8.0, -5.0, 6.0, 2.0, 6.0));
	block.var[3][1][2] = (mat3(-5.0, 0.0, 1.0, 8.0, 9.0, -2.0, 3.0, 4.0, 1.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(-3.0, 3.0, 6.0, 0.0, -2.0, 1.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(0.0, -1.0, 3.0, 9.0, 1.0, 1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][2], mat2x4(6.0, 1.0, -8.0, 2.0, 2.0, -6.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(9.0, 0.0, -3.0, 4.0, 4.0, -5.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(-8.0, -3.0, 1.0, 8.0, -8.0, 0.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][2], mat2x4(-5.0, 5.0, 8.0, -8.0, 4.0, 7.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(1.0, -3.0, -7.0, -4.0, 0.0, -9.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(-2.0, 4.0, -8.0, 4.0, 9.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][2], mat2x4(8.0, 0.0, -3.0, 9.0, 5.0, -3.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(5.0, 9.0, 3.0, -3.0, -8.0, 3.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(4.0, -7.0, 1.0, -4.0, 7.0, 0.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][2], mat2x4(8.0, -6.0, 1.0, 8.0, 5.0, 8.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(-6.0, -5.0, 8.0, 2.0, -2.0, 9.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(-1.0, 5.0, 0.0, -4.0, 2.0, 3.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][2], mat2x4(2.0, 1.0, 0.0, -1.0, -5.0, 2.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(1.0, 9.0, -9.0, -8.0, 5.0, -5.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(1.0, -8.0, 8.0, 4.0, 5.0, -7.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][2], mat2x4(0.0, 8.0, 4.0, 8.0, -5.0, -2.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][0], mat2x4(3.0, 3.0, 4.0, 8.0, 4.0, -5.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][1], mat2x4(-1.0, 0.0, 0.0, -2.0, -1.0, 1.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][2], mat2x4(-9.0, 2.0, -8.0, 1.0, 3.0, -7.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][0], mat2x4(-5.0, 9.0, -7.0, 7.0, 1.0, -9.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][1], mat2x4(8.0, 0.0, -5.0, 3.0, 2.0, -6.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][2], mat2x4(0.0, -5.0, -5.0, 9.0, -4.0, 2.0, -3.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(2.0, 1.0, 7.0, 1.0));
	block.var[0][0][0][1] = (vec4(-1.0, -8.0, 7.0, 5.0));
	block.var[0][0][1][0] = (vec4(-7.0, 2.0, -1.0, 4.0));
	block.var[0][0][1][1] = (vec4(7.0, -4.0, 8.0, -2.0));
	block.var[0][0][2][0] = (vec4(2.0, 5.0, -2.0, 1.0));
	block.var[0][0][2][1] = (vec4(1.0, 0.0, -4.0, 1.0));
	block.var[0][1][0][0] = (vec4(-4.0, 8.0, 5.0, 5.0));
	block.var[0][1][0][1] = (vec4(6.0, 7.0, 9.0, 5.0));
	block.var[0][1][1][0] = (vec4(9.0, 9.0, 2.0, -5.0));
	block.var[0][1][1][1] = (vec4(5.0, 9.0, -6.0, -8.0));
	block.var[0][1][2][0] = (vec4(-2.0, 0.0, 7.0, 4.0));
	block.var[0][1][2][1] = (vec4(8.0, -3.0, -7.0, -6.0));
	block.var[1][0][0][0] = (vec4(0.0, 5.0, -3.0, 3.0));
	block.var[1][0][0][1] = (vec4(9.0, -1.0, -7.0, -7.0));
	block.var[1][0][1][0] = (vec4(1.0, 9.0, -1.0, 8.0));
	block.var[1][0][1][1] = (vec4(7.0, 6.0, 7.0, -4.0));
	block.var[1][0][2][0] = (vec4(-4.0, 2.0, -4.0, 6.0));
	block.var[1][0][2][1] = (vec4(4.0, -1.0, -9.0, 3.0));
	block.var[1][1][0][0] = (vec4(-6.0, -1.0, 5.0, -7.0));
	block.var[1][1][0][1] = (vec4(-8.0, -6.0, 3.0, -3.0));
	block.var[1][1][1][0] = (vec4(-4.0, -4.0, 5.0, -9.0));
	block.var[1][1][1][1] = (vec4(-3.0, 0.0, -2.0, 7.0));
	block.var[1][1][2][0] = (vec4(3.0, 3.0, -3.0, 9.0));
	block.var[1][1][2][1] = (vec4(-2.0, 1.0, -8.0, -2.0));
	block.var[2][0][0][0] = (vec4(0.0, -3.0, -2.0, 3.0));
	block.var[2][0][0][1] = (vec4(-6.0, 8.0, -9.0, -3.0));
	block.var[2][0][1][0] = (vec4(-9.0, 3.0, -2.0, 6.0));
	block.var[2][0][1][1] = (vec4(4.0, 7.0, -7.0, 7.0));
	block.var[2][0][2][0] = (vec4(5.0, 2.0, 7.0, -9.0));
	block.var[2][0][2][1] = (vec4(-4.0, -3.0, -2.0, 4.0));
	block.var[2][1][0][0] = (vec4(6.0, -5.0, 0.0, 4.0));
	block.var[2][1][0][1] = (vec4(8.0, -6.0, 8.0, -7.0));
	block.var[2][1][1][0] = (vec4(8.0, 0.0, 1.0, -6.0));
	block.var[2][1][1][1] = (vec4(0.0, 1.0, 1.0, -9.0));
	block.var[2][1][2][0] = (vec4(-6.0, 9.0, 2.0, -5.0));
	block.var[2][1][2][1] = (vec4(-7.0, -6.0, 3.0, -2.0));
	block.var[3][0][0][0] = (vec4(-3.0, -8.0, -4.0, 6.0));
	block.var[3][0][0][1] = (vec4(-1.0, -1.0, 6.0, -8.0));
	block.var[3][0][1][0] = (vec4(-4.0, -2.0, -8.0, 4.0));
	block.var[3][0][1][1] = (vec4(-2.0, 4.0, -8.0, 6.0));
	block.var[3][0][2][0] = (vec4(4.0, -8.0, 8.0, -8.0));
	block.var[3][0][2][1] = (vec4(4.0, 0.0, -9.0, 1.0));
	block.var[3][1][0][0] = (vec4(1.0, -8.0, 4.0, -7.0));
	block.var[3][1][0][1] = (vec4(-3.0, 9.0, 4.0, -6.0));
	block.var[3][1][1][0] = (vec4(-7.0, -3.0, 9.0, -8.0));
	block.var[3][1][1][1] = (vec4(1.0, -6.0, 7.0, 1.0));
	block.var[3][1][2][0] = (vec4(5.0, -9.0, 3.0, -2.0));
	block.var[3][1][2][1] = (vec4(-1.0, 1.0, -7.0, 8.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0][0][0], mat2(3.0, 8.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(-3.0, 1.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][2], mat2(-5.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(4.0, -7.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(3.0, -5.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][2], mat2(-5.0, 8.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(-4.0, 5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(6.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][2], mat2(4.0, 8.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(-4.0, 2.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(5.0, -6.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][2], mat2(1.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(9.0, 8.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(5.0, 0.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][2], mat2(-9.0, 7.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(2.0, -1.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(3.0, -2.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][2], mat2(-9.0, 2.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][0], mat2(3.0, 9.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][1], mat2(8.0, 8.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][2], mat2(-5.0, -3.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][0], mat2(-3.0, 2.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][1], mat2(-9.0, 4.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][2], mat2(-5.0, -9.0, -8.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2(3.0, -6.0, 2.0, -8.0));
	block.var[0][0][1] = (mat2(2.0, -5.0, -3.0, 9.0));
	block.var[0][0][2] = (mat2(4.0, -9.0, -2.0, -6.0));
	block.var[0][1][0] = (mat2(1.0, -2.0, -9.0, -7.0));
	block.var[0][1][1] = (mat2(2.0, 7.0, 5.0, -3.0));
	block.var[0][1][2] = (mat2(-2.0, -3.0, 3.0, -1.0));
	block.var[1][0][0] = (mat2(-2.0, 4.0, -5.0, -1.0));
	block.var[1][0][1] = (mat2(3.0, 1.0, 6.0, 0.0));
	block.var[1][0][2] = (mat2(-2.0, -5.0, 2.0, 8.0));
	block.var[1][1][0] = (mat2(-2.0, -8.0, 1.0, -1.0));
	block.var[1][1][1] = (mat2(9.0, -2.0, -3.0, 6.0));
	block.var[1][1][2] = (mat2(2.0, 6.0, -4.0, -6.0));
	block.var[2][0][0] = (mat2(-2.0, -7.0, -8.0, 6.0));
	block.var[2][0][1] = (mat2(2.0, 3.0, -8.0, 4.0));
	block.var[2][0][2] = (mat2(7.0, -3.0, 8.0, -1.0));
	block.var[2][1][0] = (mat2(5.0, -6.0, 1.0, 5.0));
	block.var[2][1][1] = (mat2(-4.0, -2.0, 1.0, 6.0));
	block.var[2][1][2] = (mat2(-6.0, -2.0, 3.0, -6.0));
	block.var[3][0][0] = (mat2(7.0, -8.0, 5.0, -2.0));
	block.var[3][0][1] = (mat2(-5.0, -2.0, -2.0, 1.0));
	block.var[3][0][2] = (mat2(6.0, 0.0, 1.0, 8.0));
	block.var[3][1][0] = (mat2(-9.0, -4.0, 0.0, -1.0));
	block.var[3][1][1] = (mat2(0.0, 7.0, 4.0, 1.0));
	block.var[3][1][2] = (mat2(5.0, -6.0, 5.0, -4.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0][0][0], mat4(6.0, 9.0, -9.0, 2.0, -1.0, -3.0, 3.0, 6.0, 5.0, 1.0, -3.0, -2.0, 3.0, -6.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][1], mat4(8.0, 2.0, 9.0, 5.0, 5.0, 3.0, -9.0, -5.0, -8.0, 6.0, -6.0, -7.0, -6.0, 0.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][2], mat4(-3.0, 5.0, 8.0, -1.0, -4.0, 4.0, 3.0, -8.0, 1.0, -1.0, 7.0, 4.0, -2.0, 1.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][0], mat4(7.0, 2.0, -1.0, 1.0, 5.0, -3.0, 1.0, 4.0, -4.0, 9.0, -1.0, 3.0, -1.0, -6.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][1], mat4(-9.0, 5.0, -4.0, 9.0, 0.0, -8.0, 3.0, -9.0, -3.0, -7.0, -2.0, -9.0, -9.0, 5.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][2], mat4(-8.0, 2.0, -5.0, 2.0, -4.0, 3.0, -8.0, 7.0, 2.0, -8.0, 3.0, -9.0, 2.0, -1.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][0], mat4(4.0, 1.0, -4.0, 3.0, 4.0, -1.0, -9.0, 8.0, 1.0, -9.0, -9.0, -8.0, 1.0, 0.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][1], mat4(1.0, -4.0, 9.0, -7.0, -6.0, -2.0, -7.0, -4.0, 1.0, 2.0, 6.0, -8.0, 3.0, -2.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][2], mat4(-9.0, 7.0, -4.0, -2.0, 4.0, 5.0, 5.0, -2.0, 4.0, -6.0, 1.0, -3.0, -4.0, 6.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][0], mat4(3.0, 1.0, 0.0, 3.0, -2.0, -4.0, 2.0, 4.0, 9.0, -4.0, 0.0, -2.0, -9.0, 6.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][1], mat4(-9.0, 1.0, 0.0, -6.0, 2.0, -3.0, 5.0, -9.0, -7.0, -4.0, -1.0, -8.0, 7.0, -3.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][2], mat4(1.0, 3.0, -1.0, 1.0, 2.0, -3.0, 6.0, -8.0, 2.0, 7.0, -8.0, 5.0, -3.0, 2.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][0], mat4(-7.0, -5.0, -1.0, -9.0, -5.0, 6.0, -9.0, 5.0, 2.0, -2.0, -8.0, 4.0, -3.0, 7.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][1], mat4(8.0, 4.0, 5.0, 8.0, -5.0, 9.0, 7.0, 1.0, -8.0, -2.0, -1.0, -2.0, -8.0, -2.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][2], mat4(3.0, 0.0, -4.0, -2.0, -4.0, 0.0, -6.0, 4.0, 0.0, 1.0, -6.0, -3.0, 6.0, -1.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][0], mat4(5.0, -1.0, 9.0, -9.0, -4.0, 1.0, -2.0, 0.0, -1.0, -4.0, -4.0, -4.0, 1.0, 3.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][1], mat4(8.0, 5.0, 5.0, -4.0, 8.0, 4.0, -3.0, 1.0, -4.0, -2.0, 1.0, 5.0, 1.0, -4.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][2], mat4(0.0, -1.0, -7.0, -6.0, 1.0, 2.0, -8.0, -5.0, -7.0, 2.0, -5.0, 6.0, 9.0, -4.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][0], mat4(-3.0, 5.0, -5.0, 7.0, -3.0, -5.0, 5.0, 9.0, 1.0, 8.0, -5.0, 8.0, 9.0, 0.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][1], mat4(3.0, 1.0, 2.0, -2.0, -6.0, 0.0, 3.0, 9.0, 3.0, 0.0, 2.0, 8.0, 7.0, -6.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][2], mat4(-3.0, 8.0, 8.0, 7.0, 0.0, 0.0, 3.0, 0.0, -3.0, -4.0, 5.0, -6.0, 4.0, -4.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][0], mat4(-9.0, 1.0, 0.0, -7.0, 1.0, 4.0, -8.0, 4.0, 5.0, 9.0, -2.0, -4.0, 9.0, 1.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][1], mat4(-9.0, -6.0, -4.0, -6.0, 4.0, 6.0, 9.0, 9.0, -5.0, -1.0, -4.0, 6.0, 2.0, 5.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][2], mat4(7.0, 0.0, 2.0, 6.0, 2.0, -3.0, 4.0, 2.0, 4.0, -4.0, 9.0, 3.0, -8.0, 4.0, 5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(0.0, -7.0, -8.0, 3.0));
	block.var[0][0][0][1] = (vec4(-4.0, 2.0, 2.0, 9.0));
	block.var[0][0][0][2] = (vec4(0.0, 4.0, -1.0, -5.0));
	block.var[0][0][0][3] = (vec4(4.0, 0.0, -6.0, -6.0));
	block.var[0][0][1][0] = (vec4(-6.0, 3.0, 9.0, -6.0));
	block.var[0][0][1][1] = (vec4(2.0, 5.0, 4.0, -7.0));
	block.var[0][0][1][2] = (vec4(1.0, -4.0, 3.0, 5.0));
	block.var[0][0][1][3] = (vec4(-6.0, 0.0, -6.0, -4.0));
	block.var[0][0][2][0] = (vec4(1.0, 6.0, 0.0, 8.0));
	block.var[0][0][2][1] = (vec4(-9.0, 0.0, 8.0, 4.0));
	block.var[0][0][2][2] = (vec4(-2.0, -5.0, -6.0, -8.0));
	block.var[0][0][2][3] = (vec4(-5.0, 8.0, 8.0, -7.0));
	block.var[0][1][0][0] = (vec4(4.0, 9.0, -9.0, 1.0));
	block.var[0][1][0][1] = (vec4(-5.0, 7.0, 2.0, -4.0));
	block.var[0][1][0][2] = (vec4(-7.0, -5.0, -4.0, -9.0));
	block.var[0][1][0][3] = (vec4(6.0, -7.0, 7.0, -2.0));
	block.var[0][1][1][0] = (vec4(-3.0, -6.0, 6.0, -4.0));
	block.var[0][1][1][1] = (vec4(-2.0, 1.0, 1.0, 9.0));
	block.var[0][1][1][2] = (vec4(-3.0, 5.0, 1.0, 7.0));
	block.var[0][1][1][3] = (vec4(-2.0, 9.0, -6.0, -6.0));
	block.var[0][1][2][0] = (vec4(-8.0, 2.0, 1.0, -8.0));
	block.var[0][1][2][1] = (vec4(5.0, -3.0, 8.0, 1.0));
	block.var[0][1][2][2] = (vec4(7.0, -4.0, 8.0, -5.0));
	block.var[0][1][2][3] = (vec4(-6.0, -1.0, 9.0, -9.0));
	block.var[1][0][0][0] = (vec4(4.0, -5.0, 7.0, 9.0));
	block.var[1][0][0][1] = (vec4(4.0, -5.0, 4.0, -7.0));
	block.var[1][0][0][2] = (vec4(6.0, -1.0, 4.0, 5.0));
	block.var[1][0][0][3] = (vec4(-7.0, 7.0, 7.0, -6.0));
	block.var[1][0][1][0] = (vec4(-8.0, 9.0, -5.0, 0.0));
	block.var[1][0][1][1] = (vec4(5.0, -7.0, 8.0, -7.0));
	block.var[1][0][1][2] = (vec4(2.0, -8.0, 8.0, -7.0));
	block.var[1][0][1][3] = (vec4(6.0, -4.0, -6.0, -2.0));
	block.var[1][0][2][0] = (vec4(7.0, -2.0, -9.0, 2.0));
	block.var[1][0][2][1] = (vec4(7.0, -4.0, -9.0, 0.0));
	block.var[1][0][2][2] = (vec4(6.0, -3.0, 3.0, 6.0));
	block.var[1][0][2][3] = (vec4(3.0, -4.0, 8.0, -2.0));
	block.var[1][1][0][0] = (vec4(3.0, -3.0, 3.0, -8.0));
	block.var[1][1][0][1] = (vec4(2.0, -3.0, -6.0, -2.0));
	block.var[1][1][0][2] = (vec4(-3.0, -9.0, -6.0, -3.0));
	block.var[1][1][0][3] = (vec4(8.0, 4.0, 6.0, 7.0));
	block.var[1][1][1][0] = (vec4(7.0, -9.0, 8.0, -1.0));
	block.var[1][1][1][1] = (vec4(9.0, 5.0, 8.0, -4.0));
	block.var[1][1][1][2] = (vec4(-8.0, -2.0, -3.0, 3.0));
	block.var[1][1][1][3] = (vec4(6.0, 4.0, 0.0, -1.0));
	block.var[1][1][2][0] = (vec4(6.0, 3.0, 4.0, -9.0));
	block.var[1][1][2][1] = (vec4(5.0, 5.0, 8.0, -6.0));
	block.var[1][1][2][2] = (vec4(8.0, 3.0, -1.0, -4.0));
	block.var[1][1][2][3] = (vec4(-4.0, 1.0, 4.0, -4.0));
	block.var[2][0][0][0] = (vec4(-7.0, 3.0, -4.0, -1.0));
	block.var[2][0][0][1] = (vec4(-6.0, -7.0, -3.0, -9.0));
	block.var[2][0][0][2] = (vec4(9.0, -1.0, -3.0, -5.0));
	block.var[2][0][0][3] = (vec4(8.0, 1.0, -1.0, -3.0));
	block.var[2][0][1][0] = (vec4(-4.0, -2.0, -3.0, 5.0));
	block.var[2][0][1][1] = (vec4(-9.0, -3.0, 8.0, 4.0));
	block.var[2][0][1][2] = (vec4(2.0, 2.0, 2.0, -1.0));
	block.var[2][0][1][3] = (vec4(0.0, -1.0, -1.0, 4.0));
	block.var[2][0][2][0] = (vec4(1.0, 1.0, 4.0, -2.0));
	block.var[2][0][2][1] = (vec4(5.0, -5.0, 9.0, 2.0));
	block.var[2][0][2][2] = (vec4(6.0, -2.0, 5.0, 3.0));
	block.var[2][0][2][3] = (vec4(-7.0, 0.0, 4.0, 3.0));
	block.var[2][1][0][0] = (vec4(-5.0, 7.0, -6.0, -2.0));
	block.var[2][1][0][1] = (vec4(-1.0, -6.0, 6.0, 7.0));
	block.var[2][1][0][2] = (vec4(-6.0, 2.0, 9.0, -1.0));
	block.var[2][1][0][3] = (vec4(-1.0, 0.0, -7.0, 8.0));
	block.var[2][1][1][0] = (vec4(5.0, -1.0, -2.0, 8.0));
	block.var[2][1][1][1] = (vec4(3.0, 3.0, -7.0, 4.0));
	block.var[2][1][1][2] = (vec4(-5.0, 6.0, -8.0, -6.0));
	block.var[2][1][1][3] = (vec4(-1.0, 0.0, -2.0, -7.0));
	block.var[2][1][2][0] = (vec4(-4.0, -1.0, 3.0, 9.0));
	block.var[2][1][2][1] = (vec4(-6.0, -3.0, 8.0, 4.0));
	block.var[2][1][2][2] = (vec4(7.0, -4.0, 3.0, -5.0));
	block.var[2][1][2][3] = (vec4(-8.0, 0.0, -4.0, -3.0));
	block.var[3][0][0][0] = (vec4(2.0, -7.0, 5.0, 7.0));
	block.var[3][0][0][1] = (vec4(-5.0, 0.0, -9.0, -7.0));
	block.var[3][0][0][2] = (vec4(2.0, 7.0, -9.0, 7.0));
	block.var[3][0][0][3] = (vec4(-2.0, -5.0, 4.0, 3.0));
	block.var[3][0][1][0] = (vec4(6.0, 3.0, 8.0, 9.0));
	block.var[3][0][1][1] = (vec4(8.0, -4.0, -4.0, 4.0));
	block.var[3][0][1][2] = (vec4(-9.0, -3.0, 0.0, -3.0));
	block.var[3][0][1][3] = (vec4(0.0, 8.0, -3.0, 6.0));
	block.var[3][0][2][0] = (vec4(-8.0, -5.0, 6.0, -7.0));
	block.var[3][0][2][1] = (vec4(-6.0, -5.0, 7.0, -6.0));
	block.var[3][0][2][2] = (vec4(-1.0, 8.0, 9.0, 6.0));
	block.var[3][0][2][3] = (vec4(8.0, -7.0, 0.0, -8.0));
	block.var[3][1][0][0] = (vec4(7.0, -8.0, -4.0, -8.0));
	block.var[3][1][0][1] = (vec4(4.0, 4.0, -7.0, -2.0));
	block.var[3][1][0][2] = (vec4(9.0, -6.0, 6.0, 2.0));
	block.var[3][1][0][3] = (vec4(-2.0, -8.0, -8.0, -9.0));
	block.var[3][1][1][0] = (vec4(5.0, -7.0, -8.0, 4.0));
	block.var[3][1][1][1] = (vec4(7.0, 2.0, 7.0, -8.0));
	block.var[3][1][1][2] = (vec4(-8.0, -4.0, -4.0, -1.0));
	block.var[3][1][1][3] = (vec4(-8.0, 3.0, 5.0, 3.0));
	block.var[3][1][2][0] = (vec4(-9.0, 4.0, 6.0, -2.0));
	block.var[3][1][2][1] = (vec4(6.0, -6.0, 7.0, -7.0));
	block.var[3][1][2][2] = (vec4(-5.0, -8.0, -2.0, -7.0));
	block.var[3][1][2][3] = (vec4(7.0, -4.0, -8.0, -1.0));
}
#version 450
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
	i16vec2 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(block.var[0][0][0]), ivec2(3, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[0][0][1]), ivec2(8, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[0][0][2]), ivec2(-4, 2)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[0][1][0]), ivec2(-1, 2)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[0][1][1]), ivec2(0, -4)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[0][1][2]), ivec2(-2, -2)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][0][0]), ivec2(-1, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][0][1]), ivec2(-1, -9)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][0][2]), ivec2(-1, -7)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][1][0]), ivec2(1, 0)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][1][1]), ivec2(-5, -5)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][1][2]), ivec2(-8, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][0][0]), ivec2(-6, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][0][1]), ivec2(-5, 6)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][0][2]), ivec2(-1, 8)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][1][0]), ivec2(-2, -8)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][1][1]), ivec2(-6, 7)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][1][2]), ivec2(8, -4)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[3][0][0]), ivec2(1, 1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[3][0][1]), ivec2(6, -6)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[3][0][2]), ivec2(1, 1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[3][1][0]), ivec2(0, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[3][1][1]), ivec2(-2, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[3][1][2]), ivec2(-6, 6)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = i16vec2(ivec2(6, -2));
	block.var[0][0][1] = i16vec2(ivec2(-2, -8));
	block.var[0][0][2] = i16vec2(ivec2(3, 5));
	block.var[0][1][0] = i16vec2(ivec2(6, 9));
	block.var[0][1][1] = i16vec2(ivec2(0, 9));
	block.var[0][1][2] = i16vec2(ivec2(0, 5));
	block.var[1][0][0] = i16vec2(ivec2(-9, -9));
	block.var[1][0][1] = i16vec2(ivec2(-4, -3));
	block.var[1][0][2] = i16vec2(ivec2(-2, 6));
	block.var[1][1][0] = i16vec2(ivec2(9, -8));
	block.var[1][1][1] = i16vec2(ivec2(4, 6));
	block.var[1][1][2] = i16vec2(ivec2(-9, -9));
	block.var[2][0][0] = i16vec2(ivec2(0, -1));
	block.var[2][0][1] = i16vec2(ivec2(3, -9));
	block.var[2][0][2] = i16vec2(ivec2(9, -6));
	block.var[2][1][0] = i16vec2(ivec2(4, 1));
	block.var[2][1][1] = i16vec2(ivec2(-5, -1));
	block.var[2][1][2] = i16vec2(ivec2(4, -5));
	block.var[3][0][0] = i16vec2(ivec2(-1, -7));
	block.var[3][0][1] = i16vec2(ivec2(-1, -6));
	block.var[3][0][2] = i16vec2(ivec2(6, 5));
	block.var[3][1][0] = i16vec2(ivec2(-6, 1));
	block.var[3][1][1] = i16vec2(ivec2(-8, 4));
	block.var[3][1][2] = i16vec2(ivec2(-6, 1));
}
#version 450
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
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(5.0, 7.0, 1.0, -5.0, 5.0, 9.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(-7.0, -4.0, 7.0, 7.0, 5.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][2], mat4x2(-9.0, -7.0, -1.0, 8.0, 0.0, 4.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(-9.0, 4.0, -2.0, 2.0, 8.0, -8.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(-5.0, 3.0, 2.0, -1.0, 2.0, 1.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][2], mat4x2(-5.0, 0.0, 7.0, 6.0, 9.0, -7.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(-5.0, -3.0, 4.0, 7.0, -4.0, -5.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(9.0, 2.0, -1.0, -1.0, 7.0, 2.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][2], mat4x2(4.0, 4.0, 9.0, -9.0, -2.0, -4.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(-5.0, 2.0, 3.0, -3.0, -6.0, -3.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(-9.0, 8.0, 8.0, -7.0, 8.0, -9.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][2], mat4x2(-1.0, 0.0, 6.0, -2.0, -3.0, -2.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(5.0, -8.0, 2.0, 3.0, 3.0, 2.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(-8.0, -3.0, -1.0, 4.0, -8.0, -4.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][2], mat4x2(-7.0, 1.0, 0.0, -9.0, -6.0, 6.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(-2.0, 4.0, 1.0, -8.0, 8.0, -1.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(-5.0, 6.0, -2.0, -2.0, -9.0, -1.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][2], mat4x2(7.0, -1.0, 5.0, 0.0, -1.0, 5.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][0], mat4x2(-8.0, 5.0, -3.0, 8.0, 6.0, -4.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][1], mat4x2(5.0, -2.0, -8.0, -1.0, 4.0, -7.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][2], mat4x2(1.0, 5.0, -3.0, -4.0, 7.0, -7.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][0], mat4x2(-2.0, -8.0, 3.0, -3.0, 5.0, 9.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][1], mat4x2(-2.0, 5.0, -6.0, 7.0, -7.0, -8.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][2], mat4x2(0.0, -7.0, 2.0, -2.0, 6.0, -2.0, -4.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (6.0);
	block.var[0][0][0][0] = (vec2(-4.0, -4.0));
	block.var[0][0][0][1] = (vec2(2.0, 0.0));
	block.var[0][0][0][2] = (vec2(-7.0, 3.0));
	block.var[0][0][0][3] = (vec2(9.0, 9.0));
	block.var[0][0][1][0] = (vec2(8.0, -9.0));
	block.var[0][0][1][1] = (vec2(-9.0, -6.0));
	block.var[0][0][1][2] = (vec2(-4.0, -6.0));
	block.var[0][0][1][3] = (vec2(-6.0, -8.0));
	block.var[0][0][2][0] = (vec2(6.0, -8.0));
	block.var[0][0][2][1] = (vec2(-8.0, 3.0));
	block.var[0][0][2][2] = (vec2(2.0, 8.0));
	block.var[0][0][2][3] = (vec2(5.0, -8.0));
	block.var[0][1][0][0] = (vec2(5.0, -5.0));
	block.var[0][1][0][1] = (vec2(3.0, 4.0));
	block.var[0][1][0][2] = (vec2(-9.0, 1.0));
	block.var[0][1][0][3] = (vec2(-3.0, 0.0));
	block.var[0][1][1][0] = (vec2(-8.0, 3.0));
	block.var[0][1][1][1] = (vec2(-7.0, 9.0));
	block.var[0][1][1][2] = (vec2(-8.0, -7.0));
	block.var[0][1][1][3] = (vec2(8.0, 7.0));
	block.var[0][1][2][0] = (vec2(-1.0, -2.0));
	block.var[0][1][2][1] = (vec2(-8.0, -3.0));
	block.var[0][1][2][2] = (vec2(9.0, -1.0));
	block.var[0][1][2][3] = (vec2(1.0, -2.0));
	block.var[1][0][0][0] = (vec2(-3.0, 0.0));
	block.var[1][0][0][1] = (vec2(7.0, 5.0));
	block.var[1][0][0][2] = (vec2(-8.0, 5.0));
	block.var[1][0][0][3] = (vec2(-1.0, 7.0));
	block.var[1][0][1][0] = (vec2(4.0, -2.0));
	block.var[1][0][1][1] = (vec2(4.0, -2.0));
	block.var[1][0][1][2] = (vec2(-2.0, 9.0));
	block.var[1][0][1][3] = (vec2(8.0, 4.0));
	block.var[1][0][2][0] = (vec2(-5.0, -5.0));
	block.var[1][0][2][1] = (vec2(-6.0, 8.0));
	block.var[1][0][2][2] = (vec2(9.0, -5.0));
	block.var[1][0][2][3] = (vec2(-4.0, -2.0));
	block.var[1][1][0][0] = (vec2(-8.0, -7.0));
	block.var[1][1][0][1] = (vec2(-5.0, 7.0));
	block.var[1][1][0][2] = (vec2(-5.0, -7.0));
	block.var[1][1][0][3] = (vec2(1.0, -5.0));
	block.var[1][1][1][0] = (vec2(-4.0, 8.0));
	block.var[1][1][1][1] = (vec2(-7.0, 6.0));
	block.var[1][1][1][2] = (vec2(5.0, 2.0));
	block.var[1][1][1][3] = (vec2(2.0, -5.0));
	block.var[1][1][2][0] = (vec2(-9.0, 7.0));
	block.var[1][1][2][1] = (vec2(-3.0, -3.0));
	block.var[1][1][2][2] = (vec2(-7.0, -4.0));
	block.var[1][1][2][3] = (vec2(3.0, 3.0));
	block.var[2][0][0][0] = (vec2(6.0, -2.0));
	block.var[2][0][0][1] = (vec2(2.0, -5.0));
	block.var[2][0][0][2] = (vec2(3.0, -3.0));
	block.var[2][0][0][3] = (vec2(1.0, -6.0));
	block.var[2][0][1][0] = (vec2(-6.0, -7.0));
	block.var[2][0][1][1] = (vec2(9.0, 1.0));
	block.var[2][0][1][2] = (vec2(-4.0, 3.0));
	block.var[2][0][1][3] = (vec2(-4.0, 7.0));
	block.var[2][0][2][0] = (vec2(7.0, -4.0));
	block.var[2][0][2][1] = (vec2(8.0, -2.0));
	block.var[2][0][2][2] = (vec2(9.0, 0.0));
	block.var[2][0][2][3] = (vec2(-9.0, -9.0));
	block.var[2][1][0][0] = (vec2(-6.0, -7.0));
	block.var[2][1][0][1] = (vec2(-7.0, 5.0));
	block.var[2][1][0][2] = (vec2(-8.0, 4.0));
	block.var[2][1][0][3] = (vec2(7.0, 4.0));
	block.var[2][1][1][0] = (vec2(-6.0, -9.0));
	block.var[2][1][1][1] = (vec2(7.0, 7.0));
	block.var[2][1][1][2] = (vec2(-2.0, 6.0));
	block.var[2][1][1][3] = (vec2(-5.0, 1.0));
	block.var[2][1][2][0] = (vec2(7.0, 6.0));
	block.var[2][1][2][1] = (vec2(-4.0, 2.0));
	block.var[2][1][2][2] = (vec2(1.0, 5.0));
	block.var[2][1][2][3] = (vec2(-9.0, -8.0));
	block.var[3][0][0][0] = (vec2(1.0, 4.0));
	block.var[3][0][0][1] = (vec2(-7.0, 9.0));
	block.var[3][0][0][2] = (vec2(-5.0, 2.0));
	block.var[3][0][0][3] = (vec2(7.0, -9.0));
	block.var[3][0][1][0] = (vec2(-8.0, 5.0));
	block.var[3][0][1][1] = (vec2(-2.0, -8.0));
	block.var[3][0][1][2] = (vec2(7.0, -6.0));
	block.var[3][0][1][3] = (vec2(-3.0, -7.0));
	block.var[3][0][2][0] = (vec2(-3.0, 7.0));
	block.var[3][0][2][1] = (vec2(6.0, -5.0));
	block.var[3][0][2][2] = (vec2(9.0, -2.0));
	block.var[3][0][2][3] = (vec2(1.0, -9.0));
	block.var[3][1][0][0] = (vec2(-6.0, 4.0));
	block.var[3][1][0][1] = (vec2(4.0, 7.0));
	block.var[3][1][0][2] = (vec2(-7.0, -9.0));
	block.var[3][1][0][3] = (vec2(-6.0, 7.0));
	block.var[3][1][1][0] = (vec2(8.0, -8.0));
	block.var[3][1][1][1] = (vec2(-6.0, -7.0));
	block.var[3][1][1][2] = (vec2(-4.0, -2.0));
	block.var[3][1][1][3] = (vec2(-6.0, -9.0));
	block.var[3][1][2][0] = (vec2(4.0, -6.0));
	block.var[3][1][2][1] = (vec2(2.0, 3.0));
	block.var[3][1][2][2] = (vec2(6.0, 8.0));
	block.var[3][1][2][3] = (vec2(9.0, -8.0));
}
#version 450
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
	bool var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((block.var[0][0][0]), false) && allOk;
	allOk = compare_bool((block.var[0][0][1]), true) && allOk;
	allOk = compare_bool((block.var[0][1][0]), true) && allOk;
	allOk = compare_bool((block.var[0][1][1]), false) && allOk;
	allOk = compare_bool((block.var[0][2][0]), true) && allOk;
	allOk = compare_bool((block.var[0][2][1]), false) && allOk;
	allOk = compare_bool((block.var[0][3][0]), false) && allOk;
	allOk = compare_bool((block.var[0][3][1]), false) && allOk;
	allOk = compare_bool((block.var[1][0][0]), true) && allOk;
	allOk = compare_bool((block.var[1][0][1]), false) && allOk;
	allOk = compare_bool((block.var[1][1][0]), false) && allOk;
	allOk = compare_bool((block.var[1][1][1]), false) && allOk;
	allOk = compare_bool((block.var[1][2][0]), true) && allOk;
	allOk = compare_bool((block.var[1][2][1]), true) && allOk;
	allOk = compare_bool((block.var[1][3][0]), false) && allOk;
	allOk = compare_bool((block.var[1][3][1]), true) && allOk;
	allOk = compare_bool((block.var[2][0][0]), false) && allOk;
	allOk = compare_bool((block.var[2][0][1]), true) && allOk;
	allOk = compare_bool((block.var[2][1][0]), false) && allOk;
	allOk = compare_bool((block.var[2][1][1]), true) && allOk;
	allOk = compare_bool((block.var[2][2][0]), false) && allOk;
	allOk = compare_bool((block.var[2][2][1]), true) && allOk;
	allOk = compare_bool((block.var[2][3][0]), false) && allOk;
	allOk = compare_bool((block.var[2][3][1]), false) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (false);
	block.var[0][0][1] = (false);
	block.var[0][1][0] = (true);
	block.var[0][1][1] = (true);
	block.var[0][2][0] = (false);
	block.var[0][2][1] = (false);
	block.var[0][3][0] = (true);
	block.var[0][3][1] = (true);
	block.var[1][0][0] = (true);
	block.var[1][0][1] = (true);
	block.var[1][1][0] = (true);
	block.var[1][1][1] = (true);
	block.var[1][2][0] = (true);
	block.var[1][2][1] = (false);
	block.var[1][3][0] = (true);
	block.var[1][3][1] = (true);
	block.var[2][0][0] = (false);
	block.var[2][0][1] = (false);
	block.var[2][1][0] = (false);
	block.var[2][1][1] = (false);
	block.var[2][2][0] = (true);
	block.var[2][2][1] = (false);
	block.var[2][3][0] = (true);
	block.var[2][3][1] = (false);
}
#version 450
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
	allOk = compare_mat4(block.var[0][0][0], mat4(3.0, 8.0, 5.0, -7.0, -4.0, 0.0, -1.0, -9.0, 2.0, 9.0, 5.0, 5.0, 6.0, 9.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][1], mat4(8.0, 1.0, -3.0, 1.0, 0.0, -7.0, -4.0, 0.0, 1.0, -6.0, -7.0, 5.0, 2.0, 0.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][0], mat4(2.0, -3.0, 7.0, 9.0, 7.0, -1.0, 3.0, 6.0, -3.0, 2.0, -2.0, 7.0, -9.0, 0.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][1], mat4(-2.0, -1.0, -6.0, -6.0, 5.0, -8.0, 7.0, 3.0, -6.0, 4.0, -8.0, -1.0, 1.0, 4.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[0][2][0], mat4(4.0, 4.0, 9.0, -7.0, 9.0, 2.0, 3.0, 7.0, 0.0, -9.0, 2.0, -1.0, -8.0, -7.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[0][2][1], mat4(0.0, -3.0, -1.0, -1.0, -6.0, 1.0, -8.0, 1.0, 5.0, 0.0, 2.0, -1.0, -1.0, -6.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[0][3][0], mat4(0.0, 0.0, -1.0, 0.0, -9.0, 5.0, 4.0, 0.0, -6.0, -7.0, 1.0, -9.0, -4.0, -4.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[0][3][1], mat4(0.0, 5.0, -7.0, -5.0, 9.0, 2.0, -2.0, 5.0, 8.0, -7.0, 9.0, 9.0, -8.0, 3.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][0], mat4(-5.0, 8.0, 2.0, 3.0, 8.0, -6.0, 7.0, 9.0, -3.0, 7.0, -8.0, -5.0, 6.0, 4.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][1], mat4(7.0, 0.0, -6.0, -1.0, 5.0, 0.0, -3.0, -3.0, 6.0, -5.0, 1.0, 4.0, -5.0, -7.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][0], mat4(-7.0, -2.0, -4.0, -6.0, -6.0, 8.0, 5.0, -4.0, -7.0, 7.0, -4.0, -9.0, -7.0, -1.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][1], mat4(5.0, -4.0, -1.0, -3.0, 3.0, 2.0, 1.0, -6.0, 3.0, 5.0, -4.0, 0.0, 2.0, -4.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[1][2][0], mat4(7.0, 5.0, -2.0, -4.0, 0.0, 1.0, -6.0, -3.0, -1.0, -7.0, -7.0, -6.0, 1.0, -4.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[1][2][1], mat4(8.0, -3.0, 9.0, 6.0, -2.0, -9.0, 4.0, 5.0, 6.0, 4.0, -3.0, -8.0, 6.0, 5.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[1][3][0], mat4(5.0, 3.0, 5.0, -5.0, 6.0, 3.0, 0.0, -9.0, -1.0, 0.0, -8.0, 3.0, 4.0, -1.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[1][3][1], mat4(-6.0, -9.0, -8.0, -2.0, -6.0, -8.0, 8.0, 4.0, 4.0, 1.0, 5.0, 0.0, -1.0, 4.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][0], mat4(-2.0, -3.0, 2.0, -9.0, 6.0, -8.0, 8.0, 2.0, -3.0, -9.0, 8.0, 1.0, -4.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][1], mat4(9.0, -2.0, -1.0, -7.0, 6.0, -6.0, -3.0, -9.0, -3.0, -7.0, -2.0, 2.0, -9.0, -2.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][0], mat4(-6.0, -9.0, -6.0, -9.0, -4.0, 2.0, 5.0, 4.0, -6.0, -2.0, -5.0, 7.0, 9.0, -4.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][1], mat4(-2.0, 1.0, -2.0, 0.0, -7.0, 2.0, -6.0, -5.0, 2.0, -1.0, -8.0, 8.0, 2.0, -9.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[2][2][0], mat4(-2.0, 5.0, 8.0, 4.0, -4.0, 9.0, 3.0, -5.0, 1.0, -6.0, 1.0, -5.0, 8.0, 7.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[2][2][1], mat4(3.0, 0.0, -3.0, 3.0, 2.0, -8.0, -7.0, 8.0, -3.0, 2.0, -9.0, -7.0, 1.0, -5.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[2][3][0], mat4(-2.0, 2.0, 9.0, 7.0, -2.0, -6.0, -3.0, -7.0, 1.0, 2.0, -3.0, 0.0, -5.0, 5.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[2][3][1], mat4(3.0, 5.0, 2.0, -6.0, 9.0, 7.0, 4.0, 4.0, 5.0, 8.0, 4.0, -9.0, 3.0, -7.0, 7.0, -9.0)) && allOk;
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
	block.var[0][1][0][0] = (vec4(-4.0, -3.0, 4.0, -8.0));
	block.var[0][1][0][1] = (vec4(-2.0, 0.0, -8.0, 2.0));
	block.var[0][1][0][2] = (vec4(-3.0, -5.0, 3.0, -2.0));
	block.var[0][1][0][3] = (vec4(-9.0, -8.0, -3.0, 5.0));
	block.var[0][1][1][0] = (vec4(-9.0, 6.0, -6.0, 7.0));
	block.var[0][1][1][1] = (vec4(-8.0, 2.0, 7.0, -5.0));
	block.var[0][1][1][2] = (vec4(0.0, -4.0, -7.0, 6.0));
	block.var[0][1][1][3] = (vec4(0.0, 0.0, 4.0, -5.0));
	block.var[0][2][0][0] = (vec4(-3.0, 9.0, 5.0, -2.0));
	block.var[0][2][0][1] = (vec4(-7.0, 3.0, 3.0, 1.0));
	block.var[0][2][0][2] = (vec4(-7.0, -9.0, -5.0, -7.0));
	block.var[0][2][0][3] = (vec4(-7.0, -8.0, -2.0, -8.0));
	block.var[0][2][1][0] = (vec4(3.0, 7.0, 3.0, 7.0));
	block.var[0][2][1][1] = (vec4(-8.0, 9.0, -9.0, -9.0));
	block.var[0][2][1][2] = (vec4(3.0, -4.0, -8.0, 3.0));
	block.var[0][2][1][3] = (vec4(9.0, -7.0, -5.0, -5.0));
	block.var[0][3][0][0] = (vec4(-2.0, -9.0, -3.0, -3.0));
	block.var[0][3][0][1] = (vec4(-3.0, 0.0, -7.0, 1.0));
	block.var[0][3][0][2] = (vec4(6.0, -1.0, 3.0, 4.0));
	block.var[0][3][0][3] = (vec4(8.0, 7.0, 7.0, -9.0));
	block.var[0][3][1][0] = (vec4(-9.0, 3.0, 5.0, 7.0));
	block.var[0][3][1][1] = (vec4(3.0, -6.0, -1.0, -5.0));
	block.var[0][3][1][2] = (vec4(9.0, -7.0, 9.0, -7.0));
	block.var[0][3][1][3] = (vec4(7.0, 5.0, -8.0, 6.0));
	block.var[1][0][0][0] = (vec4(-6.0, -3.0, 7.0, -1.0));
	block.var[1][0][0][1] = (vec4(0.0, -1.0, -2.0, 1.0));
	block.var[1][0][0][2] = (vec4(-3.0, -1.0, -4.0, 7.0));
	block.var[1][0][0][3] = (vec4(-3.0, 1.0, 1.0, -9.0));
	block.var[1][0][1][0] = (vec4(-3.0, 2.0, 9.0, -4.0));
	block.var[1][0][1][1] = (vec4(2.0, 9.0, -9.0, -2.0));
	block.var[1][0][1][2] = (vec4(-1.0, 1.0, -9.0, 0.0));
	block.var[1][0][1][3] = (vec4(-7.0, 7.0, -3.0, -9.0));
	block.var[1][1][0][0] = (vec4(-1.0, -9.0, -7.0, 5.0));
	block.var[1][1][0][1] = (vec4(3.0, 9.0, -8.0, -6.0));
	block.var[1][1][0][2] = (vec4(-3.0, 6.0, -9.0, 4.0));
	block.var[1][1][0][3] = (vec4(6.0, -6.0, -6.0, -2.0));
	block.var[1][1][1][0] = (vec4(-8.0, -3.0, -8.0, 5.0));
	block.var[1][1][1][1] = (vec4(6.0, -9.0, -7.0, -7.0));
	block.var[1][1][1][2] = (vec4(6.0, 1.0, 0.0, -3.0));
	block.var[1][1][1][3] = (vec4(4.0, 1.0, -7.0, 4.0));
	block.var[1][2][0][0] = (vec4(2.0, 2.0, -3.0, 9.0));
	block.var[1][2][0][1] = (vec4(0.0, -6.0, 7.0, 1.0));
	block.var[1][2][0][2] = (vec4(-1.0, 2.0, -7.0, 2.0));
	block.var[1][2][0][3] = (vec4(-1.0, -6.0, -8.0, 1.0));
	block.var[1][2][1][0] = (vec4(1.0, -4.0, -6.0, -4.0));
	block.var[1][2][1][1] = (vec4(-9.0, 0.0, -2.0, 6.0));
	block.var[1][2][1][2] = (vec4(3.0, 3.0, 4.0, -6.0));
	block.var[1][2][1][3] = (vec4(-7.0, 9.0, -1.0, 6.0));
	block.var[1][3][0][0] = (vec4(1.0, 7.0, -7.0, -7.0));
	block.var[1][3][0][1] = (vec4(-9.0, -7.0, -8.0, 7.0));
	block.var[1][3][0][2] = (vec4(5.0, -2.0, 5.0, -4.0));
	block.var[1][3][0][3] = (vec4(-8.0, 0.0, 0.0, 7.0));
	block.var[1][3][1][0] = (vec4(-9.0, 2.0, -4.0, 0.0));
	block.var[1][3][1][1] = (vec4(-5.0, -8.0, -8.0, 2.0));
	block.var[1][3][1][2] = (vec4(9.0, -9.0, -6.0, 5.0));
	block.var[1][3][1][3] = (vec4(0.0, 9.0, 6.0, 5.0));
	block.var[2][0][0][0] = (vec4(-1.0, 0.0, 7.0, 7.0));
	block.var[2][0][0][1] = (vec4(-5.0, -2.0, -6.0, 0.0));
	block.var[2][0][0][2] = (vec4(-2.0, 1.0, -2.0, 4.0));
	block.var[2][0][0][3] = (vec4(4.0, 0.0, 0.0, -2.0));
	block.var[2][0][1][0] = (vec4(4.0, 7.0, -5.0, -3.0));
	block.var[2][0][1][1] = (vec4(9.0, 1.0, 5.0, 5.0));
	block.var[2][0][1][2] = (vec4(9.0, -4.0, -6.0, 8.0));
	block.var[2][0][1][3] = (vec4(1.0, -5.0, 5.0, -3.0));
	block.var[2][1][0][0] = (vec4(6.0, 4.0, 3.0, -5.0));
	block.var[2][1][0][1] = (vec4(-8.0, 0.0, -2.0, 7.0));
	block.var[2][1][0][2] = (vec4(5.0, -1.0, -3.0, -2.0));
	block.var[2][1][0][3] = (vec4(-6.0, -9.0, -3.0, 5.0));
	block.var[2][1][1][0] = (vec4(8.0, 7.0, -4.0, 1.0));
	block.var[2][1][1][1] = (vec4(6.0, -9.0, 8.0, 3.0));
	block.var[2][1][1][2] = (vec4(-6.0, -7.0, 7.0, -1.0));
	block.var[2][1][1][3] = (vec4(-7.0, 6.0, -5.0, 9.0));
	block.var[2][2][0][0] = (vec4(-8.0, -1.0, 0.0, -8.0));
	block.var[2][2][0][1] = (vec4(3.0, -1.0, 9.0, -7.0));
	block.var[2][2][0][2] = (vec4(-4.0, 7.0, 9.0, -5.0));
	block.var[2][2][0][3] = (vec4(2.0, -8.0, 7.0, 8.0));
	block.var[2][2][1][0] = (vec4(1.0, -8.0, -3.0, -8.0));
	block.var[2][2][1][1] = (vec4(-8.0, -6.0, -2.0, -9.0));
	block.var[2][2][1][2] = (vec4(-4.0, 4.0, -9.0, -5.0));
	block.var[2][2][1][3] = (vec4(-2.0, 9.0, -7.0, -6.0));
	block.var[2][3][0][0] = (vec4(-2.0, -9.0, 6.0, -7.0));
	block.var[2][3][0][1] = (vec4(5.0, 4.0, 2.0, -6.0));
	block.var[2][3][0][2] = (vec4(-8.0, -7.0, 4.0, 1.0));
	block.var[2][3][0][3] = (vec4(1.0, 1.0, 6.0, 2.0));
	block.var[2][3][1][0] = (vec4(-7.0, 8.0, -8.0, 4.0));
	block.var[2][3][1][1] = (vec4(2.0, 3.0, -3.0, -2.0));
	block.var[2][3][1][2] = (vec4(9.0, 1.0, -8.0, 2.0));
	block.var[2][3][1][3] = (vec4(2.0, -1.0, -9.0, 9.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0][0][0], mat2x3(-3.0, -7.0, 5.0, 4.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][1], mat2x3(1.0, -3.0, 5.0, -8.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][0], mat2x3(7.0, -5.0, -3.0, -6.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][1], mat2x3(-9.0, -6.0, 5.0, -2.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2][0], mat2x3(1.0, -6.0, 5.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2][1], mat2x3(-3.0, 6.0, -4.0, -1.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][3][0], mat2x3(0.0, 0.0, 5.0, 6.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][3][1], mat2x3(3.0, -2.0, -1.0, 5.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][0], mat2x3(-3.0, 3.0, -9.0, 1.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][1], mat2x3(0.0, 9.0, 5.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][0], mat2x3(8.0, 1.0, 8.0, -7.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][1], mat2x3(-1.0, -2.0, -9.0, -1.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2][0], mat2x3(2.0, -1.0, -8.0, 7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2][1], mat2x3(-7.0, 5.0, -9.0, -5.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][3][0], mat2x3(-5.0, -2.0, 9.0, 2.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][3][1], mat2x3(4.0, -4.0, -3.0, -5.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][0], mat2x3(-8.0, 3.0, 8.0, -7.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][1], mat2x3(8.0, 4.0, -2.0, -2.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][0], mat2x3(-5.0, -6.0, -3.0, 6.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][1], mat2x3(-3.0, -8.0, -9.0, -8.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2][0], mat2x3(3.0, -4.0, 0.0, -3.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2][1], mat2x3(-4.0, -2.0, 6.0, 0.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][3][0], mat2x3(-2.0, 0.0, 3.0, 7.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][3][1], mat2x3(7.0, 7.0, -2.0, -8.0, 8.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec3(4.0, 5.0, -6.0));
	block.var[0][0][0][1] = (vec3(0.0, -8.0, -2.0));
	block.var[0][0][1][0] = (vec3(8.0, 8.0, 0.0));
	block.var[0][0][1][1] = (vec3(3.0, -6.0, -6.0));
	block.var[0][1][0][0] = (vec3(-1.0, -3.0, 0.0));
	block.var[0][1][0][1] = (vec3(3.0, 3.0, 5.0));
	block.var[0][1][1][0] = (vec3(-1.0, -1.0, 3.0));
	block.var[0][1][1][1] = (vec3(-1.0, -7.0, 7.0));
	block.var[0][2][0][0] = (vec3(-7.0, 8.0, -3.0));
	block.var[0][2][0][1] = (vec3(3.0, 8.0, 1.0));
	block.var[0][2][1][0] = (vec3(3.0, 6.0, 2.0));
	block.var[0][2][1][1] = (vec3(9.0, -2.0, -9.0));
	block.var[0][3][0][0] = (vec3(-4.0, 0.0, -1.0));
	block.var[0][3][0][1] = (vec3(8.0, 9.0, -4.0));
	block.var[0][3][1][0] = (vec3(6.0, 5.0, -2.0));
	block.var[0][3][1][1] = (vec3(0.0, 6.0, 6.0));
	block.var[1][0][0][0] = (vec3(-1.0, 2.0, -9.0));
	block.var[1][0][0][1] = (vec3(1.0, 3.0, 2.0));
	block.var[1][0][1][0] = (vec3(1.0, 5.0, -6.0));
	block.var[1][0][1][1] = (vec3(-8.0, -6.0, -5.0));
	block.var[1][1][0][0] = (vec3(-6.0, -6.0, -8.0));
	block.var[1][1][0][1] = (vec3(2.0, -4.0, -3.0));
	block.var[1][1][1][0] = (vec3(-3.0, 4.0, 8.0));
	block.var[1][1][1][1] = (vec3(7.0, -2.0, -7.0));
	block.var[1][2][0][0] = (vec3(-9.0, 6.0, -2.0));
	block.var[1][2][0][1] = (vec3(-3.0, -8.0, -5.0));
	block.var[1][2][1][0] = (vec3(-2.0, -5.0, 0.0));
	block.var[1][2][1][1] = (vec3(-9.0, -9.0, -9.0));
	block.var[1][3][0][0] = (vec3(3.0, 8.0, 3.0));
	block.var[1][3][0][1] = (vec3(2.0, 2.0, -8.0));
	block.var[1][3][1][0] = (vec3(0.0, -1.0, 2.0));
	block.var[1][3][1][1] = (vec3(7.0, 7.0, 4.0));
	block.var[2][0][0][0] = (vec3(-9.0, 6.0, -9.0));
	block.var[2][0][0][1] = (vec3(0.0, -1.0, -3.0));
	block.var[2][0][1][0] = (vec3(-6.0, 9.0, 7.0));
	block.var[2][0][1][1] = (vec3(-5.0, -7.0, -2.0));
	block.var[2][1][0][0] = (vec3(-5.0, 5.0, -5.0));
	block.var[2][1][0][1] = (vec3(1.0, -1.0, 7.0));
	block.var[2][1][1][0] = (vec3(-5.0, 8.0, -7.0));
	block.var[2][1][1][1] = (vec3(-2.0, 4.0, 3.0));
	block.var[2][2][0][0] = (vec3(-9.0, -3.0, -1.0));
	block.var[2][2][0][1] = (vec3(7.0, 1.0, 1.0));
	block.var[2][2][1][0] = (vec3(4.0, -2.0, 7.0));
	block.var[2][2][1][1] = (vec3(0.0, 1.0, 9.0));
	block.var[2][3][0][0] = (vec3(-1.0, -5.0, -6.0));
	block.var[2][3][0][1] = (vec3(-9.0, 7.0, 3.0));
	block.var[2][3][1][0] = (vec3(7.0, 3.0, -9.0));
	block.var[2][3][1][1] = (vec3(1.0, -3.0, 5.0));
}
#version 450
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
	bool var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((block.var[0][0][0]), false) && allOk;
	allOk = compare_bool((block.var[0][0][1]), true) && allOk;
	allOk = compare_bool((block.var[0][1][0]), true) && allOk;
	allOk = compare_bool((block.var[0][1][1]), false) && allOk;
	allOk = compare_bool((block.var[0][2][0]), true) && allOk;
	allOk = compare_bool((block.var[0][2][1]), false) && allOk;
	allOk = compare_bool((block.var[0][3][0]), false) && allOk;
	allOk = compare_bool((block.var[0][3][1]), false) && allOk;
	allOk = compare_bool((block.var[1][0][0]), true) && allOk;
	allOk = compare_bool((block.var[1][0][1]), false) && allOk;
	allOk = compare_bool((block.var[1][1][0]), false) && allOk;
	allOk = compare_bool((block.var[1][1][1]), false) && allOk;
	allOk = compare_bool((block.var[1][2][0]), true) && allOk;
	allOk = compare_bool((block.var[1][2][1]), true) && allOk;
	allOk = compare_bool((block.var[1][3][0]), false) && allOk;
	allOk = compare_bool((block.var[1][3][1]), true) && allOk;
	allOk = compare_bool((block.var[2][0][0]), false) && allOk;
	allOk = compare_bool((block.var[2][0][1]), true) && allOk;
	allOk = compare_bool((block.var[2][1][0]), false) && allOk;
	allOk = compare_bool((block.var[2][1][1]), true) && allOk;
	allOk = compare_bool((block.var[2][2][0]), false) && allOk;
	allOk = compare_bool((block.var[2][2][1]), true) && allOk;
	allOk = compare_bool((block.var[2][3][0]), false) && allOk;
	allOk = compare_bool((block.var[2][3][1]), false) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (false);
	block.var[0][0][1] = (false);
	block.var[0][1][0] = (true);
	block.var[0][1][1] = (true);
	block.var[0][2][0] = (false);
	block.var[0][2][1] = (false);
	block.var[0][3][0] = (true);
	block.var[0][3][1] = (true);
	block.var[1][0][0] = (true);
	block.var[1][0][1] = (true);
	block.var[1][1][0] = (true);
	block.var[1][1][1] = (true);
	block.var[1][2][0] = (true);
	block.var[1][2][1] = (false);
	block.var[1][3][0] = (true);
	block.var[1][3][1] = (true);
	block.var[2][0][0] = (false);
	block.var[2][0][1] = (false);
	block.var[2][1][0] = (false);
	block.var[2][1][1] = (false);
	block.var[2][2][0] = (true);
	block.var[2][2][1] = (false);
	block.var[2][3][0] = (true);
	block.var[2][3][1] = (false);
}
#version 450
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
	allOk = compare_mat2(block.var[0][0][0], mat2(-7.0, -9.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(8.0, 9.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(0.0, 9.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(-6.0, 5.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[0][2][0], mat2(-4.0, -7.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[0][2][1], mat2(-4.0, -8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[0][3][0], mat2(4.0, 3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[0][3][1], mat2(-7.0, 6.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(8.0, -6.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(-1.0, -5.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(-9.0, -1.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(-9.0, 8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[1][2][0], mat2(-2.0, -6.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[1][2][1], mat2(3.0, 4.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[1][3][0], mat2(-4.0, 9.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[1][3][1], mat2(9.0, -2.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(4.0, 1.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(7.0, -5.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(4.0, -8.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(8.0, -1.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[2][2][0], mat2(-5.0, -9.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[2][2][1], mat2(-2.0, -8.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[2][3][0], mat2(-3.0, 0.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[2][3][1], mat2(0.0, 1.0, -2.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(7.0, -3.0));
	block.var[0][0][0][1] = (vec2(-2.0, 4.0));
	block.var[0][0][1][0] = (vec2(1.0, -3.0));
	block.var[0][0][1][1] = (vec2(2.0, -4.0));
	block.var[0][1][0][0] = (vec2(1.0, 5.0));
	block.var[0][1][0][1] = (vec2(9.0, -6.0));
	block.var[0][1][1][0] = (vec2(-7.0, 5.0));
	block.var[0][1][1][1] = (vec2(7.0, 4.0));
	block.var[0][2][0][0] = (vec2(-5.0, 8.0));
	block.var[0][2][0][1] = (vec2(3.0, 1.0));
	block.var[0][2][1][0] = (vec2(-9.0, 7.0));
	block.var[0][2][1][1] = (vec2(7.0, 1.0));
	block.var[0][3][0][0] = (vec2(-8.0, 7.0));
	block.var[0][3][0][1] = (vec2(0.0, 2.0));
	block.var[0][3][1][0] = (vec2(-7.0, -7.0));
	block.var[0][3][1][1] = (vec2(5.0, -3.0));
	block.var[1][0][0][0] = (vec2(-1.0, 1.0));
	block.var[1][0][0][1] = (vec2(-4.0, 3.0));
	block.var[1][0][1][0] = (vec2(7.0, -7.0));
	block.var[1][0][1][1] = (vec2(2.0, 5.0));
	block.var[1][1][0][0] = (vec2(7.0, -9.0));
	block.var[1][1][0][1] = (vec2(0.0, 6.0));
	block.var[1][1][1][0] = (vec2(-1.0, -7.0));
	block.var[1][1][1][1] = (vec2(-8.0, 4.0));
	block.var[1][2][0][0] = (vec2(-3.0, -9.0));
	block.var[1][2][0][1] = (vec2(-7.0, 1.0));
	block.var[1][2][1][0] = (vec2(-7.0, 6.0));
	block.var[1][2][1][1] = (vec2(2.0, -5.0));
	block.var[1][3][0][0] = (vec2(-1.0, -1.0));
	block.var[1][3][0][1] = (vec2(1.0, 1.0));
	block.var[1][3][1][0] = (vec2(7.0, 1.0));
	block.var[1][3][1][1] = (vec2(2.0, -8.0));
	block.var[2][0][0][0] = (vec2(-8.0, 4.0));
	block.var[2][0][0][1] = (vec2(8.0, 1.0));
	block.var[2][0][1][0] = (vec2(4.0, 6.0));
	block.var[2][0][1][1] = (vec2(-9.0, 9.0));
	block.var[2][1][0][0] = (vec2(5.0, 6.0));
	block.var[2][1][0][1] = (vec2(-7.0, 7.0));
	block.var[2][1][1][0] = (vec2(-1.0, -5.0));
	block.var[2][1][1][1] = (vec2(9.0, -7.0));
	block.var[2][2][0][0] = (vec2(6.0, -3.0));
	block.var[2][2][0][1] = (vec2(-5.0, -6.0));
	block.var[2][2][1][0] = (vec2(-3.0, 7.0));
	block.var[2][2][1][1] = (vec2(9.0, 6.0));
	block.var[2][3][0][0] = (vec2(-1.0, 1.0));
	block.var[2][3][0][1] = (vec2(2.0, -4.0));
	block.var[2][3][1][0] = (vec2(-9.0, -4.0));
	block.var[2][3][1][1] = (vec2(7.0, 0.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(-7.0, -1.0, -3.0, -6.0, -2.0, 4.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(4.0, 9.0, -2.0, -3.0, 3.0, 3.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(-7.0, 8.0, 3.0, 6.0, 7.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(9.0, -4.0, -9.0, 5.0, -4.0, 9.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2][0], mat2x4(4.0, 7.0, -6.0, -6.0, -4.0, -1.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2][1], mat2x4(-6.0, 0.0, -1.0, 1.0, -2.0, -5.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][3][0], mat2x4(-2.0, -2.0, -2.0, 9.0, -2.0, 3.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][3][1], mat2x4(-1.0, -1.0, -5.0, 9.0, -1.0, -8.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(9.0, 2.0, -4.0, 1.0, -2.0, -8.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(9.0, 4.0, 2.0, -6.0, -7.0, -3.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(-5.0, 9.0, 8.0, 9.0, -6.0, 0.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(0.0, 4.0, 4.0, 1.0, 6.0, -8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2][0], mat2x4(-1.0, 7.0, 8.0, 8.0, -5.0, -8.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2][1], mat2x4(-7.0, 9.0, -1.0, -6.0, 3.0, 9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][3][0], mat2x4(7.0, 6.0, 2.0, -6.0, 9.0, -8.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][3][1], mat2x4(9.0, 4.0, -9.0, -9.0, -7.0, -2.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(7.0, 2.0, -5.0, -2.0, -1.0, 5.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(-1.0, -6.0, 3.0, -5.0, -6.0, 5.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(1.0, 1.0, -9.0, -7.0, 3.0, 9.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(4.0, 7.0, -6.0, 2.0, 0.0, -3.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2][0], mat2x4(6.0, -8.0, -5.0, 4.0, -4.0, -5.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2][1], mat2x4(-1.0, -3.0, -8.0, 8.0, 8.0, -2.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][3][0], mat2x4(3.0, -5.0, -6.0, 1.0, 6.0, -7.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][3][1], mat2x4(4.0, -4.0, -5.0, -1.0, -7.0, 6.0, -3.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(4.0, -6.0, -9.0, -3.0));
	block.var[0][0][0][1] = (vec4(5.0, 1.0, -7.0, 1.0));
	block.var[0][0][1][0] = (vec4(-7.0, -4.0, 1.0, 9.0));
	block.var[0][0][1][1] = (vec4(-1.0, -2.0, 2.0, 4.0));
	block.var[0][1][0][0] = (vec4(1.0, -8.0, 7.0, 2.0));
	block.var[0][1][0][1] = (vec4(5.0, -8.0, 3.0, 8.0));
	block.var[0][1][1][0] = (vec4(1.0, 5.0, 3.0, -5.0));
	block.var[0][1][1][1] = (vec4(5.0, -8.0, 3.0, 1.0));
	block.var[0][2][0][0] = (vec4(-7.0, 4.0, -9.0, 1.0));
	block.var[0][2][0][1] = (vec4(0.0, -5.0, 6.0, -3.0));
	block.var[0][2][1][0] = (vec4(-9.0, -4.0, 8.0, -1.0));
	block.var[0][2][1][1] = (vec4(7.0, -1.0, -9.0, -2.0));
	block.var[0][3][0][0] = (vec4(-2.0, 4.0, 0.0, -2.0));
	block.var[0][3][0][1] = (vec4(9.0, -8.0, 7.0, 0.0));
	block.var[0][3][1][0] = (vec4(-8.0, 7.0, 0.0, 3.0));
	block.var[0][3][1][1] = (vec4(1.0, -9.0, -3.0, -8.0));
	block.var[1][0][0][0] = (vec4(-1.0, -9.0, -6.0, 6.0));
	block.var[1][0][0][1] = (vec4(-7.0, 5.0, 8.0, 4.0));
	block.var[1][0][1][0] = (vec4(-8.0, 1.0, 8.0, -9.0));
	block.var[1][0][1][1] = (vec4(-7.0, -8.0, 4.0, -2.0));
	block.var[1][1][0][0] = (vec4(3.0, 9.0, -9.0, -1.0));
	block.var[1][1][0][1] = (vec4(5.0, 7.0, 6.0, 7.0));
	block.var[1][1][1][0] = (vec4(7.0, -3.0, 4.0, 4.0));
	block.var[1][1][1][1] = (vec4(-9.0, -1.0, -2.0, -1.0));
	block.var[1][2][0][0] = (vec4(-9.0, -6.0, -1.0, -3.0));
	block.var[1][2][0][1] = (vec4(6.0, -6.0, 2.0, 1.0));
	block.var[1][2][1][0] = (vec4(-3.0, -3.0, -5.0, -1.0));
	block.var[1][2][1][1] = (vec4(4.0, 0.0, -9.0, -1.0));
	block.var[1][3][0][0] = (vec4(1.0, 2.0, -4.0, -3.0));
	block.var[1][3][0][1] = (vec4(6.0, -7.0, 1.0, 0.0));
	block.var[1][3][1][0] = (vec4(-8.0, 1.0, -9.0, 2.0));
	block.var[1][3][1][1] = (vec4(9.0, 1.0, 2.0, -7.0));
	block.var[2][0][0][0] = (vec4(5.0, 5.0, -2.0, 2.0));
	block.var[2][0][0][1] = (vec4(-6.0, 0.0, 8.0, 8.0));
	block.var[2][0][1][0] = (vec4(-6.0, -5.0, 0.0, 5.0));
	block.var[2][0][1][1] = (vec4(-1.0, 2.0, 3.0, 0.0));
	block.var[2][1][0][0] = (vec4(-1.0, 7.0, -2.0, 3.0));
	block.var[2][1][0][1] = (vec4(7.0, -2.0, -4.0, -8.0));
	block.var[2][1][1][0] = (vec4(2.0, 7.0, 2.0, -9.0));
	block.var[2][1][1][1] = (vec4(-2.0, -1.0, 1.0, -4.0));
	block.var[2][2][0][0] = (vec4(1.0, -2.0, 4.0, -4.0));
	block.var[2][2][0][1] = (vec4(3.0, -9.0, 0.0, -4.0));
	block.var[2][2][1][0] = (vec4(-7.0, 7.0, 9.0, -2.0));
	block.var[2][2][1][1] = (vec4(5.0, -3.0, -5.0, 5.0));
	block.var[2][3][0][0] = (vec4(9.0, -9.0, -9.0, -8.0));
	block.var[2][3][0][1] = (vec4(-5.0, 8.0, 3.0, -6.0));
	block.var[2][3][1][0] = (vec4(-2.0, -3.0, 3.0, -1.0));
	block.var[2][3][1][1] = (vec4(8.0, 7.0, -4.0, -8.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(-5.0, -8.0, -4.0, 7.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(-7.0, 4.0, 3.0, -1.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(9.0, 7.0, 4.0, -7.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(-3.0, 1.0, 1.0, -4.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][0], mat3x2(-5.0, -6.0, -9.0, -3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][1], mat3x2(1.0, 6.0, 2.0, 2.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][0], mat3x2(9.0, 7.0, 3.0, 7.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][1], mat3x2(-5.0, -7.0, 8.0, 4.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(-6.0, -3.0, -8.0, 5.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(2.0, 6.0, -1.0, -9.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(-7.0, 4.0, 1.0, 0.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(3.0, -5.0, 6.0, 8.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][0], mat3x2(-4.0, -2.0, -2.0, 0.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][1], mat3x2(5.0, -5.0, 9.0, 8.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][0], mat3x2(2.0, -4.0, -7.0, 4.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][1], mat3x2(-8.0, 0.0, -2.0, 1.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(-8.0, 3.0, 1.0, -2.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(0.0, 4.0, 0.0, 1.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(-6.0, 3.0, -6.0, 0.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(-1.0, 0.0, -5.0, -6.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][0], mat3x2(7.0, -4.0, -4.0, 5.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][1], mat3x2(-8.0, 6.0, 4.0, 2.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][0], mat3x2(-6.0, 1.0, 9.0, 1.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][1], mat3x2(3.0, -3.0, 9.0, -6.0, 5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3x2(-3.0, 7.0, -3.0, -4.0, 2.0, -7.0));
	block.var[0][0][1] = (mat3x2(-2.0, 9.0, -8.0, -2.0, 3.0, 4.0));
	block.var[0][1][0] = (mat3x2(9.0, 7.0, 7.0, -2.0, 8.0, 3.0));
	block.var[0][1][1] = (mat3x2(-9.0, 8.0, 4.0, -5.0, 3.0, -6.0));
	block.var[0][2][0] = (mat3x2(7.0, -4.0, 6.0, -9.0, -2.0, -7.0));
	block.var[0][2][1] = (mat3x2(-2.0, -2.0, -1.0, 7.0, 3.0, -9.0));
	block.var[0][3][0] = (mat3x2(-3.0, 2.0, -3.0, -9.0, 1.0, -7.0));
	block.var[0][3][1] = (mat3x2(6.0, -2.0, 9.0, -6.0, 7.0, 1.0));
	block.var[1][0][0] = (mat3x2(4.0, 1.0, -7.0, 9.0, 9.0, -1.0));
	block.var[1][0][1] = (mat3x2(-9.0, 3.0, 0.0, -8.0, -3.0, 8.0));
	block.var[1][1][0] = (mat3x2(7.0, 2.0, 6.0, 3.0, 5.0, 1.0));
	block.var[1][1][1] = (mat3x2(0.0, 8.0, -4.0, 0.0, -9.0, 0.0));
	block.var[1][2][0] = (mat3x2(6.0, -8.0, 1.0, -2.0, -2.0, 3.0));
	block.var[1][2][1] = (mat3x2(-9.0, 8.0, 3.0, 2.0, 3.0, 7.0));
	block.var[1][3][0] = (mat3x2(9.0, 6.0, -3.0, 1.0, -1.0, 0.0));
	block.var[1][3][1] = (mat3x2(3.0, -9.0, 6.0, 0.0, -2.0, 4.0));
	block.var[2][0][0] = (mat3x2(5.0, 0.0, 9.0, 0.0, 9.0, 8.0));
	block.var[2][0][1] = (mat3x2(2.0, 6.0, 0.0, 7.0, 6.0, 4.0));
	block.var[2][1][0] = (mat3x2(7.0, 3.0, 5.0, -1.0, 3.0, -3.0));
	block.var[2][1][1] = (mat3x2(-2.0, 1.0, 0.0, -5.0, -9.0, -4.0));
	block.var[2][2][0] = (mat3x2(-9.0, 3.0, -6.0, -9.0, -4.0, -8.0));
	block.var[2][2][1] = (mat3x2(5.0, 8.0, 8.0, -6.0, -8.0, -4.0));
	block.var[2][3][0] = (mat3x2(9.0, 1.0, 5.0, -7.0, 2.0, 1.0));
	block.var[2][3][1] = (mat3x2(8.0, 8.0, 9.0, 6.0, -1.0, 4.0));
}
#version 450
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
	allOk = compare_mat3(block.t[0].a, mat3(8.0, 4.0, -6.0, -1.0, -7.0, -4.0, 7.0, 5.0, 5.0)) && allOk;
	allOk = compare_ivec3((block.t[0].b[0].a), ivec3(1, 9, 2)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[0]), ivec2(0, -4)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[1]), ivec2(-7, 0)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[2]), ivec2(2, -5)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[3]), ivec2(-2, 1)) && allOk;
	allOk = compare_vec4((block.t[0].b[0].c), vec4(-5.0, 2.0, 5.0, -6.0)) && allOk;
	allOk = compare_ivec3((block.t[0].b[1].a), ivec3(4, 5, 6)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[0]), ivec2(3, 6)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[1]), ivec2(-2, 5)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[2]), ivec2(4, -2)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[3]), ivec2(-5, 9)) && allOk;
	allOk = compare_vec4((block.t[0].b[1].c), vec4(4.0, -3.0, -8.0, 1.0)) && allOk;
	allOk = compare_ivec3((block.t[0].b[2].a), ivec3(-2, 0, -7)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[0]), ivec2(3, -3)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[1]), ivec2(1, -1)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[2]), ivec2(0, 6)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[3]), ivec2(-1, 9)) && allOk;
	allOk = compare_vec4((block.t[0].b[2].c), vec4(4.0, 6.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3(block.t[1].a, mat3(-8.0, -6.0, 2.0, 6.0, 3.0, -1.0, -9.0, 7.0, 1.0)) && allOk;
	allOk = compare_ivec3((block.t[1].b[0].a), ivec3(-5, 5, -6)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[0]), ivec2(2, -5)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[1]), ivec2(-8, 1)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[2]), ivec2(7, 8)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[3]), ivec2(-8, -6)) && allOk;
	allOk = compare_vec4((block.t[1].b[0].c), vec4(9.0, 7.0, -3.0, -8.0)) && allOk;
	allOk = compare_ivec3((block.t[1].b[1].a), ivec3(-7, -7, -5)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[0]), ivec2(-4, 3)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[1]), ivec2(7, 4)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[2]), ivec2(3, 4)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[3]), ivec2(-5, 7)) && allOk;
	allOk = compare_vec4((block.t[1].b[1].c), vec4(3.0, -8.0, 7.0, 3.0)) && allOk;
	allOk = compare_ivec3((block.t[1].b[2].a), ivec3(8, -5, 2)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[0]), ivec2(7, 6)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[1]), ivec2(-3, 9)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[2]), ivec2(7, -4)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[3]), ivec2(-3, -8)) && allOk;
	allOk = compare_vec4((block.t[1].b[2].c), vec4(2.0, -2.0, -9.0, -1.0)) && allOk;
	allOk = compare_uint((block.u), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s.a = (ivec3(4, 1, 5));
	block.s.b[0] = (ivec2(-4, 6));
	block.s.b[1] = (ivec2(-4, -7));
	block.s.b[2] = (ivec2(-1, -7));
	block.s.b[3] = (ivec2(1, -9));
	block.s.c = (vec4(-4.0, -7.0, -5.0, -4.0));
	block.u = (6u);
}
#version 450
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
	allOk = compare_mat4x3(block.t[0].a, mat4x3(2.0, 0.0, -7.0, 7.0, -5.0, 1.0, -5.0, 1.0, 6.0, 2.0, -1.0, 4.0)) && allOk;
	allOk = compare_uvec3((block.t[0].b[0].a), uvec3(9u, 0u, 6u)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[0]), vec2(-4.0, 9.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[1]), vec2(-7.0, 0.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[2]), vec2(-2.0, 4.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[3]), vec2(5.0, 5.0)) && allOk;
	allOk = compare_vec4((block.t[0].b[0].c), vec4(-6.0, -7.0, 4.0, -1.0)) && allOk;
	allOk = compare_uvec3((block.t[0].b[1].a), uvec3(2u, 1u, 7u)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[0]), vec2(6.0, -8.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[1]), vec2(4.0, 6.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[2]), vec2(4.0, -6.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[3]), vec2(1.0, 9.0)) && allOk;
	allOk = compare_vec4((block.t[0].b[1].c), vec4(-9.0, -3.0, 8.0, -9.0)) && allOk;
	allOk = compare_uvec3((block.t[0].b[2].a), uvec3(8u, 0u, 9u)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[0]), vec2(7.0, 1.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[1]), vec2(0.0, 7.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[2]), vec2(-8.0, 1.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[3]), vec2(-2.0, 2.0)) && allOk;
	allOk = compare_vec4((block.t[0].b[2].c), vec4(2.0, -5.0, 2.0, -7.0)) && allOk;
	allOk = compare_int((block.t[0].c), 1) && allOk;
	allOk = compare_mat4x3(block.t[1].a, mat4x3(1.0, -3.0, 5.0, -5.0, -7.0, -9.0, -3.0, -8.0, -4.0, -3.0, 6.0, 1.0)) && allOk;
	allOk = compare_uvec3((block.t[1].b[0].a), uvec3(8u, 7u, 7u)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[0]), vec2(-3.0, 9.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[1]), vec2(-1.0, -6.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[2]), vec2(5.0, 6.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[3]), vec2(1.0, -4.0)) && allOk;
	allOk = compare_vec4((block.t[1].b[0].c), vec4(4.0, 8.0, -8.0, -4.0)) && allOk;
	allOk = compare_uvec3((block.t[1].b[1].a), uvec3(2u, 8u, 3u)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[0]), vec2(-5.0, 2.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[1]), vec2(-7.0, 2.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[2]), vec2(-5.0, -1.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[3]), vec2(8.0, -2.0)) && allOk;
	allOk = compare_vec4((block.t[1].b[1].c), vec4(4.0, 7.0, 1.0, 9.0)) && allOk;
	allOk = compare_uvec3((block.t[1].b[2].a), uvec3(7u, 1u, 8u)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[0]), vec2(9.0, 8.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[1]), vec2(4.0, 9.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[2]), vec2(-1.0, 9.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[3]), vec2(6.0, -6.0)) && allOk;
	allOk = compare_vec4((block.t[1].b[2].c), vec4(-4.0, 2.0, 9.0, -3.0)) && allOk;
	allOk = compare_int((block.t[1].c), -4) && allOk;
	allOk = compare_mat4x3(block.t[2].a, mat4x3(1.0, 0.0, 6.0, -9.0, -3.0, 2.0, 5.0, -4.0, -1.0, 9.0, 4.0, -3.0)) && allOk;
	allOk = compare_uvec3((block.t[2].b[0].a), uvec3(4u, 1u, 1u)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[0]), vec2(6.0, 4.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[1]), vec2(-4.0, -2.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[2]), vec2(2.0, -2.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[3]), vec2(-8.0, -2.0)) && allOk;
	allOk = compare_vec4((block.t[2].b[0].c), vec4(6.0, 3.0, -2.0, -8.0)) && allOk;
	allOk = compare_uvec3((block.t[2].b[1].a), uvec3(0u, 3u, 9u)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[0]), vec2(3.0, -6.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[1]), vec2(-5.0, -4.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[2]), vec2(-8.0, 8.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[3]), vec2(0.0, -4.0)) && allOk;
	allOk = compare_vec4((block.t[2].b[1].c), vec4(0.0, 3.0, 4.0, 4.0)) && allOk;
	allOk = compare_uvec3((block.t[2].b[2].a), uvec3(5u, 7u, 4u)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[0]), vec2(3.0, -7.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[1]), vec2(-5.0, -1.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[2]), vec2(-6.0, 3.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[3]), vec2(-9.0, 2.0)) && allOk;
	allOk = compare_vec4((block.t[2].b[2].c), vec4(3.0, 7.0, 1.0, -4.0)) && allOk;
	allOk = compare_int((block.t[2].c), 8) && allOk;
	allOk = compare_mat4x3(block.t[3].a, mat4x3(-3.0, 2.0, 4.0, 9.0, -7.0, -5.0, -9.0, -6.0, 8.0, -6.0, 7.0, 0.0)) && allOk;
	allOk = compare_uvec3((block.t[3].b[0].a), uvec3(2u, 7u, 0u)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[0]), vec2(-9.0, 9.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[1]), vec2(9.0, -2.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[2]), vec2(3.0, 6.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[3]), vec2(-3.0, -9.0)) && allOk;
	allOk = compare_vec4((block.t[3].b[0].c), vec4(3.0, -3.0, 8.0, -1.0)) && allOk;
	allOk = compare_uvec3((block.t[3].b[1].a), uvec3(4u, 9u, 9u)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[0]), vec2(0.0, 5.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[1]), vec2(9.0, -7.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[2]), vec2(4.0, 4.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[3]), vec2(9.0, -5.0)) && allOk;
	allOk = compare_vec4((block.t[3].b[1].c), vec4(8.0, 9.0, -8.0, 9.0)) && allOk;
	allOk = compare_uvec3((block.t[3].b[2].a), uvec3(3u, 5u, 1u)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[0]), vec2(-4.0, 8.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[1]), vec2(-4.0, -2.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[2]), vec2(-3.0, -5.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[3]), vec2(3.0, -5.0)) && allOk;
	allOk = compare_vec4((block.t[3].b[2].c), vec4(-4.0, -7.0, 5.0, 9.0)) && allOk;
	allOk = compare_int((block.t[3].c), -2) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s.a = (uvec3(7u, 4u, 2u));
	block.s.b[0] = (vec2(-9.0, 5.0));
	block.s.b[1] = (vec2(2.0, 9.0));
	block.s.b[2] = (vec2(-9.0, -9.0));
	block.s.b[3] = (vec2(0.0, -3.0));
	block.s.c = (vec4(7.0, -9.0, 8.0, -2.0));
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

layout(std140, buffer_reference) buffer Block
{
	highp vec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((block[0].var), vec2(5.0, 4.0)) && allOk;
	allOk = compare_vec2((block[1].var), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((block[2].var), vec2(-7.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (vec2(3.0, 8.0));
	block[1].var = (vec2(7.0, -1.0));
	block[2].var = (vec2(-4.0, 8.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), -2.0) && allOk;
	allOk = compare_float(block[0].var[0][0], 1.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -5.0) && allOk;
	allOk = compare_float(block[0].var[0][2], -1.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 3.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 7.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 4.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 7.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 9.0) && allOk;
	allOk = compare_float(block[0].var[2][2], -8.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(1.0, -5.0, -1.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(3.0, 7.0, 4.0)) && allOk;
	allOk = compare_vec3(block[0].var[2], vec3(7.0, 9.0, -8.0)) && allOk;
	allOk = compare_float((block[1].padding), 7.0) && allOk;
	allOk = compare_float(block[1].var[0][0], 7.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -1.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -5.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -8.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 2.0) && allOk;
	allOk = compare_float(block[1].var[1][2], -2.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -6.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -4.0) && allOk;
	allOk = compare_float(block[1].var[2][2], -3.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(7.0, -1.0, -5.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(-8.0, 2.0, -2.0)) && allOk;
	allOk = compare_vec3(block[1].var[2], vec3(-6.0, -4.0, -3.0)) && allOk;
	allOk = compare_float((block[2].padding), -8.0) && allOk;
	allOk = compare_float(block[2].var[0][0], 2.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -3.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 3.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 1.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -3.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 5.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 8.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 8.0) && allOk;
	allOk = compare_float(block[2].var[2][2], -1.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(2.0, -3.0, 3.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(1.0, -3.0, 5.0)) && allOk;
	allOk = compare_vec3(block[2].var[2], vec3(8.0, 8.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-2.0);
	block[0].var = (mat3(7.0, 5.0, 2.0, 9.0, -1.0, -9.0, -7.0, 1.0, 6.0));
	block[1].padding = (-1.0);
	block[1].var = (mat3(0.0, 9.0, 1.0, -5.0, 8.0, 1.0, -8.0, -8.0, -6.0));
	block[2].padding = (-6.0);
	block[2].var = (mat3(-4.0, 5.0, -4.0, -1.0, 9.0, -9.0, 0.0, 5.0, -1.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), 3.0) && allOk;
	allOk = compare_mat2x4(block[0].var, mat2x4(-4.0, 9.0, -7.0, -8.0, 2.0, 5.0, -4.0, -7.0)) && allOk;
	allOk = compare_float((block[1].padding), 8.0) && allOk;
	allOk = compare_mat2x4(block[1].var, mat2x4(-9.0, 4.0, 4.0, -9.0, -1.0, -5.0, 9.0, -5.0)) && allOk;
	allOk = compare_float((block[2].padding), -4.0) && allOk;
	allOk = compare_mat2x4(block[2].var, mat2x4(-8.0, -6.0, -2.0, 3.0, 0.0, -5.0, -8.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (5.0);
	block[0].var = (mat2x4(-1.0, 5.0, 1.0, 1.0, -4.0, 0.0, -8.0, -3.0));
	block[1].padding = (9.0);
	block[1].var = (mat2x4(-8.0, -9.0, 1.0, 9.0, 1.0, -2.0, -6.0, 3.0));
	block[2].padding = (-3.0);
	block[2].var = (mat2x4(-7.0, -6.0, 0.0, 9.0, -7.0, -3.0, -9.0, -8.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), 5.0) && allOk;
	allOk = compare_float(block[0].var[0][0], -9.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 4.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 8.0) && allOk;
	allOk = compare_float(block[0].var[0][3], -1.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 3.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 0.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 9.0) && allOk;
	allOk = compare_float(block[0].var[1][3], -7.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(-9.0, 4.0, 8.0, -1.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(3.0, 0.0, 9.0, -7.0)) && allOk;
	allOk = compare_float((block[1].padding), 1.0) && allOk;
	allOk = compare_float(block[1].var[0][0], 3.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -8.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 0.0) && allOk;
	allOk = compare_float(block[1].var[0][3], -7.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 0.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 1.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 8.0) && allOk;
	allOk = compare_float(block[1].var[1][3], 3.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(3.0, -8.0, 0.0, -7.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(0.0, 1.0, 8.0, 3.0)) && allOk;
	allOk = compare_float((block[2].padding), 1.0) && allOk;
	allOk = compare_float(block[2].var[0][0], -5.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 2.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 6.0) && allOk;
	allOk = compare_float(block[2].var[0][3], -6.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -6.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -7.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 0.0) && allOk;
	allOk = compare_float(block[2].var[1][3], -7.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(-5.0, 2.0, 6.0, -6.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(-6.0, -7.0, 0.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-7.0);
	block[0].var[0] = (vec4(-1.0, 8.0, 2.0, -1.0));
	block[0].var[1] = (vec4(2.0, 7.0, -9.0, -9.0));
	block[1].padding = (-5.0);
	block[1].var[0] = (vec4(4.0, 7.0, 5.0, 8.0));
	block[1].var[1] = (vec4(-8.0, -8.0, 6.0, -3.0));
	block[2].padding = (7.0);
	block[2].var[0] = (vec4(0.0, 4.0, 6.0, -4.0));
	block[2].var[1] = (vec4(0.0, -5.0, 8.0, -9.0));
}
#version 450
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
	allOk = compare_float((blockA[0].a), 5.0) && allOk;
	allOk = compare_float(blockA[0].c[0][0], 9.0) && allOk;
	allOk = compare_float(blockA[0].c[0][1], 7.0) && allOk;
	allOk = compare_float(blockA[0].c[1][0], 0.0) && allOk;
	allOk = compare_float(blockA[0].c[1][1], 8.0) && allOk;
	allOk = compare_vec2(blockA[0].c[0], vec2(9.0, 7.0)) && allOk;
	allOk = compare_vec2(blockA[0].c[1], vec2(0.0, 8.0)) && allOk;
	allOk = compare_float((blockA[1].a), -5.0) && allOk;
	allOk = compare_float(blockA[1].c[0][0], 8.0) && allOk;
	allOk = compare_float(blockA[1].c[0][1], 0.0) && allOk;
	allOk = compare_float(blockA[1].c[1][0], 8.0) && allOk;
	allOk = compare_float(blockA[1].c[1][1], 8.0) && allOk;
	allOk = compare_vec2(blockA[1].c[0], vec2(8.0, 0.0)) && allOk;
	allOk = compare_vec2(blockA[1].c[1], vec2(8.0, 8.0)) && allOk;
	allOk = compare_float((blockA[2].a), -4.0) && allOk;
	allOk = compare_float(blockA[2].c[0][0], 0.0) && allOk;
	allOk = compare_float(blockA[2].c[0][1], -2.0) && allOk;
	allOk = compare_float(blockA[2].c[1][0], -3.0) && allOk;
	allOk = compare_float(blockA[2].c[1][1], -7.0) && allOk;
	allOk = compare_vec2(blockA[2].c[0], vec2(0.0, -2.0)) && allOk;
	allOk = compare_vec2(blockA[2].c[1], vec2(-3.0, -7.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b), ivec2(1, 5)) && allOk;
	allOk = compare_bool((blockB[0].d), false) && allOk;
	allOk = compare_ivec2((blockB[1].b), ivec2(-3, -8)) && allOk;
	allOk = compare_bool((blockB[1].d), false) && allOk;
	allOk = compare_ivec2((blockB[2].b), ivec2(1, -7)) && allOk;
	allOk = compare_bool((blockB[2].d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (-3.0);
	blockA[1].a = (0.0);
	blockA[2].a = (-6.0);
	blockB[0].a[0] = (vec3(5.0, 0.0, 5.0));
	blockB[0].a[1] = (vec3(-3.0, 0.0, 5.0));
	blockB[0].a[2] = (vec3(-1.0, 1.0, -7.0));
	blockB[0].d = (true);
	blockB[1].a[0] = (vec3(-4.0, 6.0, -3.0));
	blockB[1].a[1] = (vec3(7.0, 5.0, -4.0));
	blockB[1].a[2] = (vec3(7.0, -2.0, 8.0));
	blockB[1].d = (true);
	blockB[2].a[0] = (vec3(-7.0, 2.0, 0.0));
	blockB[2].a[1] = (vec3(0.0, 0.0, 1.0));
	blockB[2].a[2] = (vec3(-9.0, 0.0, 7.0));
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

layout(buffer_reference) buffer BlockA
{
	layout(offset = 0) highp float a;
	layout(offset = 4) lowp uvec3 b;
	layout(offset = 16) mediump mat2 c;
};
layout(buffer_reference) buffer BlockB
{
	layout(offset = 0) mediump mat3 a;
	layout(offset = 48) lowp ivec2 b;
	layout(offset = 64) highp vec4 c;
	layout(offset = 80) bool d;
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
	allOk = compare_float((blockA[0].a), -2.0) && allOk;
	allOk = compare_mat2(blockA[0].c, mat2(-6.0, -1.0, -1.0, 0.0)) && allOk;
	allOk = compare_float((blockA[1].a), 9.0) && allOk;
	allOk = compare_mat2(blockA[1].c, mat2(-4.0, -4.0, -2.0, 0.0)) && allOk;
	allOk = compare_float((blockA[2].a), 5.0) && allOk;
	allOk = compare_mat2(blockA[2].c, mat2(2.0, 1.0, -2.0, 1.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b), ivec2(0, 0)) && allOk;
	allOk = compare_bool((blockB[0].d), false) && allOk;
	allOk = compare_ivec2((blockB[1].b), ivec2(-9, -1)) && allOk;
	allOk = compare_bool((blockB[1].d), true) && allOk;
	allOk = compare_ivec2((blockB[2].b), ivec2(-1, 3)) && allOk;
	allOk = compare_bool((blockB[2].d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (4.0);
	blockA[1].a = (-6.0);
	blockA[2].a = (2.0);
	blockB[0].a = (mat3(6.0, 1.0, 8.0, -8.0, 9.0, -5.0, -5.0, -3.0, -3.0));
	blockB[0].d = (false);
	blockB[1].a = (mat3(-2.0, 3.0, 3.0, -4.0, -1.0, 6.0, -1.0, 0.0, -5.0));
	blockB[1].d = (true);
	blockB[2].a = (mat3(-7.0, 7.0, -7.0, 1.0, -5.0, -4.0, 8.0, 3.0, 8.0));
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

layout(std430, buffer_reference) buffer BlockB
{
	bvec2 a;
	bvec3 b;
	bvec4 c;
	mediump uvec2 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a), bvec2(true, true)) && allOk;
	allOk = compare_bvec4((blockB.c), bvec4(true, false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, true));
	blockB.c = (bvec4(false, false, true, true));
}
#version 450
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
	highp vec4 a;
	bvec2 b[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	highp vec3 c[3];
	mediump mat4 d;
	lowp mat4 e;
	bvec4 f;
	highp uint g[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	lowp ivec4 h;
	bvec4 i[];
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
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.a), vec4(1.0, -5.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat4(blockC.e, mat4(3.0, -3.0, -4.0, -4.0, 1.0, -9.0, -6.0, -4.0, 1.0, -7.0, 1.0, 0.0, -9.0, -4.0, 3.0, 1.0)) && allOk;
	allOk = compare_uint((blockC.g[0]), 3u) && allOk;
	allOk = compare_uint((blockC.g[1]), 5u) && allOk;
	allOk = compare_uint((blockC.g[2]), 9u) && allOk;
	allOk = compare_uint((blockC.g[3]), 0u) && allOk;
	allOk = compare_uint((blockC.g[4]), 6u) && allOk;
	allOk = compare_bvec4((blockD.i[0]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((blockD.i[1]), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bvec4((blockD.i[2]), bvec4(false, false, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (bvec2(false, false));
	blockB.b[1] = (bvec2(false, true));
	blockB.b[2] = (bvec2(true, true));
	blockC.c[0] = (vec3(8.0, 3.0, 8.0));
	blockC.c[1] = (vec3(8.0, 0.0, 8.0));
	blockC.c[2] = (vec3(-6.0, 5.0, 1.0));
	blockC.e = (mat4(8.0, 8.0, -4.0, -8.0, -9.0, 5.0, 8.0, 1.0, -8.0, 3.0, 8.0, -8.0, 4.0, 5.0, 0.0, 2.0));
	blockC.g[0] = (9u);
	blockC.g[1] = (3u);
	blockC.g[2] = (9u);
	blockC.g[3] = (8u);
	blockC.g[4] = (4u);
	blockD.h = (ivec4(6, 9, -9, 3));
}
#version 450
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
	lowp mat4 a[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	lowp uint b[4];
	bool c;
	mediump mat2x3 d;
	lowp mat4 e[];
};
layout(std430, row_major, buffer_reference) readonly buffer BlockD
{
	lowp ivec4 f;
	mediump vec4 g[];
};
layout(std140, column_major, buffer_reference) buffer BlockE
{
	mediump vec4 h;
	mediump mat3x2 i;
	mediump uvec3 j[];
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
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.a[0], mat4(-7.0, 8.0, 8.0, 2.0, 4.0, 0.0, -2.0, 6.0, -1.0, 5.0, -9.0, 9.0, -2.0, -9.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat4(blockB.a[1], mat4(-9.0, 0.0, -9.0, 7.0, 0.0, -2.0, -5.0, 2.0, 4.0, -7.0, -2.0, 9.0, 8.0, 9.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat4(blockB.a[2], mat4(2.0, 3.0, 8.0, 7.0, 9.0, -3.0, 1.0, 4.0, -9.0, 2.0, 7.0, -1.0, -3.0, 5.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat4(blockC.e[0], mat4(-5.0, 7.0, 6.0, -9.0, -1.0, -3.0, 5.0, 1.0, -9.0, -6.0, -5.0, -8.0, -6.0, -8.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat4(blockC.e[1], mat4(-1.0, 7.0, 0.0, 1.0, 5.0, -1.0, 3.0, 4.0, 6.0, 5.0, -9.0, 3.0, -1.0, -2.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat4(blockC.e[2], mat4(-1.0, -8.0, -1.0, -1.0, -1.0, -9.0, 4.0, -8.0, 8.0, -6.0, 6.0, 0.0, -1.0, 0.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat4(blockC.e[3], mat4(-9.0, 8.0, -1.0, -9.0, -4.0, -2.0, 4.0, 8.0, -4.0, 5.0, 7.0, 7.0, 8.0, 3.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4(blockC.e[4], mat4(6.0, 9.0, -8.0, 2.0, -1.0, -8.0, -2.0, -9.0, 5.0, 9.0, -7.0, -6.0, 5.0, -1.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat4(blockC.e[5], mat4(5.0, -4.0, 5.0, 0.0, -7.0, -3.0, 0.0, 8.0, 5.0, 1.0, -8.0, 4.0, 4.0, -4.0, 1.0, 7.0)) && allOk;
	allOk = compare_ivec4((blockD.f), ivec4(4, 6, 9, 8)) && allOk;
	allOk = compare_vec4((blockE.h), vec4(9.0, -9.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat3x2(blockE.i, mat3x2(-1.0, -6.0, 8.0, -6.0, -9.0, 2.0)) && allOk;
	allOk = compare_uvec3((blockE.j[0]), uvec3(5u, 8u, 9u)) && allOk;
	allOk = compare_uvec3((blockE.j[1]), uvec3(5u, 8u, 2u)) && allOk;
	allOk = compare_uvec3((blockE.j[2]), uvec3(7u, 8u, 8u)) && allOk;
	allOk = compare_uvec3((blockE.j[3]), uvec3(0u, 1u, 5u)) && allOk;
	allOk = compare_uvec3((blockE.j[4]), uvec3(0u, 9u, 0u)) && allOk;
	allOk = compare_uvec3((blockE.j[5]), uvec3(0u, 9u, 6u)) && allOk;
	allOk = compare_uvec3((blockE.j[6]), uvec3(9u, 4u, 1u)) && allOk;
	allOk = compare_uvec3((blockE.j[7]), uvec3(1u, 0u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat4(0.0, -7.0, 3.0, -2.0, 2.0, -7.0, 4.0, 6.0, -8.0, 8.0, -3.0, 3.0, -3.0, -1.0, 6.0, 9.0));
	blockB.a[1] = (mat4(5.0, -6.0, -1.0, -2.0, 2.0, -3.0, -9.0, -5.0, 3.0, 5.0, -5.0, -2.0, -2.0, 8.0, -3.0, -3.0));
	blockB.a[2] = (mat4(-8.0, 1.0, -3.0, -1.0, 3.0, 7.0, -4.0, -5.0, -1.0, -3.0, 1.0, -9.0, 8.0, 9.0, -8.0, -8.0));
	blockC.b[0] = (2u);
	blockC.b[1] = (3u);
	blockC.b[2] = (1u);
	blockC.b[3] = (8u);
	blockE.h = (vec4(9.0, 9.0, -4.0, 2.0));
	blockE.i = (mat3x2(4.0, -8.0, -8.0, -5.0, 0.0, -4.0));
	blockE.j[0] = (uvec3(3u, 8u, 5u));
	blockE.j[1] = (uvec3(7u, 4u, 2u));
	blockE.j[2] = (uvec3(2u, 5u, 9u));
	blockE.j[3] = (uvec3(5u, 0u, 1u));
	blockE.j[4] = (uvec3(3u, 0u, 8u));
	blockE.j[5] = (uvec3(1u, 2u, 1u));
	blockE.j[6] = (uvec3(5u, 1u, 6u));
	blockE.j[7] = (uvec3(3u, 4u, 8u));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, buffer_reference) readonly buffer BlockB
{
	highp uvec2 a;
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	lowp vec4 b[];
};
layout(std140, column_major, buffer_reference) readonly buffer BlockD
{
	lowp uvec3 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockC.b[0]), vec4(9.0, -5.0, 0.0, 3.0)) && allOk;
	allOk = compare_vec4((blockC.b[1]), vec4(7.0, -1.0, -8.0, 2.0)) && allOk;
	allOk = compare_vec4((blockC.b[2]), vec4(8.0, -2.0, -2.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b[0] = (vec4(-9.0, 0.0, 9.0, 2.0));
	blockC.b[1] = (vec4(-6.0, 6.0, -6.0, 3.0));
	blockC.b[2] = (vec4(5.0, -8.0, -7.0, -8.0));
}
#version 450
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
	highp mat3x4 mB;
	lowp uvec2 mC;
};
struct sB
{
	sA mA;
};
layout(std140, row_major, buffer_reference) readonly buffer BlockB
{
	highp mat3 a;
	bvec2 b;
	mediump int c[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	mediump mat3x4 d;
	sB e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockC[0].d, mat3x4(-2.0, -1.0, 5.0, 2.0, -4.0, 7.0, 7.0, -1.0, 3.0, -2.0, -1.0, -5.0)) && allOk;
	allOk = compare_bool((blockC[0].e[0].mA.mA), false) && allOk;
	allOk = compare_mat3x4(blockC[0].e[0].mA.mB, mat3x4(3.0, 9.0, -5.0, 1.0, 8.0, -8.0, 4.0, -8.0, -3.0, -1.0, 4.0, -9.0)) && allOk;
	allOk = compare_uvec2((blockC[0].e[0].mA.mC), uvec2(6u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC[0].d = (mat3x4(8.0, -5.0, 4.0, -6.0, -8.0, -5.0, 0.0, 4.0, 7.0, 3.0, -2.0, 9.0));
	blockC[0].e[0].mA.mA = (true);
	blockC[0].e[0].mA.mB = (mat3x4(-5.0, 5.0, 5.0, -5.0, -2.0, -4.0, -4.0, -9.0, -5.0, 4.0, -3.0, -8.0));
	blockC[0].e[0].mA.mC = (uvec2(3u, 6u));
}
#version 450
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
};
layout(std430, buffer_reference) buffer BlockB
{
	bvec3 a;
	lowp vec2 b[];
};
layout(std430, buffer_reference) buffer BlockC
{
	bvec4 c;
	lowp vec3 d;
	mediump uvec3 e;
	lowp mat3x2 f[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	lowp float g;
	bvec3 h;
	sA i[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.a), bvec3(true, true, false)) && allOk;
	allOk = compare_vec3((blockC[0].d), vec3(2.0, 0.0, -9.0)) && allOk;
	allOk = compare_uvec3((blockC[0].e), uvec3(2u, 9u, 1u)) && allOk;
	allOk = compare_vec3((blockC[1].d), vec3(8.0, 7.0, 9.0)) && allOk;
	allOk = compare_uvec3((blockC[1].e), uvec3(1u, 6u, 6u)) && allOk;
	allOk = compare_vec3((blockC[2].d), vec3(8.0, 0.0, 0.0)) && allOk;
	allOk = compare_uvec3((blockC[2].e), uvec3(7u, 1u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec3(true, true, true));
	blockB.b[0] = (vec2(4.0, 6.0));
	blockC[0].e = (uvec3(3u, 6u, 3u));
	blockC[1].e = (uvec3(0u, 0u, 4u));
	blockC[2].e = (uvec3(8u, 2u, 3u));
	blockD.g = (-7.0);
	blockD.i[0].mA = (vec4(5.0, -3.0, 9.0, -9.0));
}
#version 450
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
	mediump float a;
	highp mat4x3 b;
	bvec4 c[];
};
layout(std430, buffer_reference) buffer BlockC
{
	lowp mat3x2 d;
	highp vec2 e;
	lowp mat4x2 f[1];
	highp mat3x2 g;
	bvec3 h;
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	highp uvec2 i;
	highp uvec4 j[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB[0].a), -5.0) && allOk;
	allOk = compare_mat4x3(blockB[0].b, mat4x3(-9.0, -7.0, 9.0, -1.0, 0.0, -3.0, 9.0, -2.0, 0.0, 3.0, -3.0, 2.0)) && allOk;
	allOk = compare_bvec4((blockB[0].c[0]), bvec4(true, true, true, false)) && allOk;
	allOk = compare_mat3x2(blockC.d, mat3x2(-3.0, -9.0, 5.0, -9.0, 7.0, 4.0)) && allOk;
	allOk = compare_vec2((blockC.e), vec2(6.0, 7.0)) && allOk;
	allOk = compare_uvec2((blockD.i), uvec2(8u, 7u)) && allOk;
	allOk = compare_uvec4((blockD.j[0]), uvec4(2u, 4u, 8u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].c[0] = (bvec4(false, true, true, false));
	blockC.d = (mat3x2(-4.0, -6.0, 7.0, 1.0, 9.0, 1.0));
	blockC.e = (vec2(3.0, 9.0));
	blockC.f[0] = (mat4x2(6.0, 4.0, -5.0, -6.0, 2.0, 8.0, 0.0, 6.0));
	blockC.g = (mat3x2(5.0, 6.0, -3.0, -8.0, 8.0, -8.0));
	blockD.i = (uvec2(2u, 5u));
	blockD.j[0] = (uvec4(9u, 0u, 1u, 4u));
}
#version 450
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
	highp uvec3 mA[1];
};
struct sB
{
	lowp float mA;
};
struct sC
{
	mediump mat3 mA;
	lowp vec3 mB;
	mediump vec4 mC;
};
struct sD
{
	mediump mat2 mA;
	highp mat3x2 mB;
	highp mat3x2 mC;
	sC mD[7];
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	bvec4 a;
	lowp mat2 b;
	mediump mat3x4 c[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	bool d[];
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	mediump mat4x3 e;
	bvec2 f;
	lowp uint g;
	sA h;
	bvec4 i[];
};
layout(std430, column_major, buffer_reference) buffer BlockE
{
	highp mat3x4 j;
	sB k;
	highp mat2x3 l;
	lowp mat3 m;
	sD n;
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
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, false, false, false)) && allOk;
	allOk = compare_mat2(blockB.b, mat2(-7.0, 2.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat3x4(blockB.c[0], mat3x4(7.0, 2.0, -5.0, -3.0, 9.0, 9.0, 7.0, 7.0, -8.0, 6.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat3x4(blockB.c[1], mat3x4(-2.0, -5.0, 8.0, -3.0, 9.0, 1.0, 5.0, 3.0, 2.0, -6.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat3x4(blockB.c[2], mat3x4(-9.0, 2.0, 3.0, -9.0, 7.0, 9.0, 1.0, -3.0, -2.0, -3.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat3x4(blockB.c[3], mat3x4(-7.0, -6.0, -4.0, 1.0, -4.0, 1.0, -4.0, -3.0, -4.0, 3.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3x4(blockB.c[4], mat3x4(-6.0, -5.0, 9.0, -2.0, 6.0, 2.0, 2.0, -4.0, 5.0, 4.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat3x4(blockB.c[5], mat3x4(1.0, 5.0, 5.0, 6.0, -8.0, 1.0, -3.0, 2.0, -9.0, -5.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3x4(blockB.c[6], mat3x4(4.0, 8.0, 4.0, -5.0, -3.0, 6.0, -7.0, -9.0, 3.0, -3.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x4(blockB.c[7], mat3x4(-6.0, -4.0, 6.0, -6.0, 6.0, 5.0, 2.0, 4.0, -3.0, -9.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat4x3(blockD.e, mat4x3(1.0, 6.0, 2.0, -2.0, 1.0, -8.0, 4.0, -2.0, -6.0, -3.0, 5.0, -5.0)) && allOk;
	allOk = compare_bvec4((blockD.i[0]), bvec4(false, false, true, true)) && allOk;
	allOk = compare_bvec4((blockD.i[1]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec4((blockD.i[2]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec4((blockD.i[3]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((blockD.i[4]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((blockD.i[5]), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bvec4((blockD.i[6]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((blockD.i[7]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_float((blockE[0].k.mA), 7.0) && allOk;
	allOk = compare_mat2x3(blockE[0].l, mat2x3(1.0, 1.0, -3.0, -1.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3(blockE[0].m, mat3(-1.0, 7.0, 5.0, -2.0, 0.0, -2.0, 2.0, -5.0, 2.0)) && allOk;
	allOk = compare_float((blockE[1].k.mA), -1.0) && allOk;
	allOk = compare_mat2x3(blockE[1].l, mat2x3(6.0, -2.0, -3.0, -6.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat3(blockE[1].m, mat3(-9.0, -9.0, 9.0, 0.0, -4.0, 6.0, 6.0, -9.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec4(true, true, false, false));
	blockB.b = (mat2(0.0, -7.0, 0.0, 5.0));
	blockB.c[0] = (mat3x4(3.0, 8.0, 8.0, -6.0, 4.0, 3.0, 0.0, 5.0, 7.0, 8.0, 8.0, 1.0));
	blockB.c[1] = (mat3x4(7.0, -2.0, 7.0, 5.0, -1.0, -7.0, -9.0, 3.0, -9.0, -5.0, -5.0, 7.0));
	blockB.c[2] = (mat3x4(-7.0, 8.0, -8.0, 5.0, -6.0, 8.0, 4.0, 3.0, 1.0, -9.0, 8.0, 5.0));
	blockB.c[3] = (mat3x4(-4.0, 0.0, -8.0, -2.0, 8.0, -8.0, 2.0, 2.0, 8.0, 1.0, -7.0, -5.0));
	blockB.c[4] = (mat3x4(-5.0, -3.0, -7.0, 9.0, -8.0, -6.0, 7.0, -9.0, -6.0, -4.0, 6.0, 3.0));
	blockB.c[5] = (mat3x4(4.0, 4.0, -8.0, 3.0, 2.0, -6.0, 6.0, -9.0, -6.0, -4.0, -6.0, -6.0));
	blockB.c[6] = (mat3x4(1.0, 2.0, 3.0, 4.0, 9.0, 5.0, -4.0, 5.0, -7.0, 9.0, 6.0, 5.0));
	blockB.c[7] = (mat3x4(6.0, -8.0, 5.0, 5.0, 8.0, 3.0, -8.0, 0.0, 1.0, -9.0, 0.0, -7.0));
	blockC.d[0] = (true);
	blockC.d[1] = (true);
	blockC.d[2] = (true);
	blockC.d[3] = (false);
	blockC.d[4] = (false);
	blockC.d[5] = (false);
	blockC.d[6] = (true);
	blockC.d[7] = (true);
	blockD.e = (mat4x3(-4.0, 3.0, -4.0, 7.0, -8.0, 1.0, -1.0, 4.0, 6.0, 5.0, 2.0, -8.0));
	blockD.f = (bvec2(false, true));
	blockD.g = (0u);
	blockD.h.mA[0] = (uvec3(6u, 2u, 2u));
	blockD.i[0] = (bvec4(false, false, true, false));
	blockD.i[1] = (bvec4(false, false, false, false));
	blockD.i[2] = (bvec4(true, true, true, false));
	blockD.i[3] = (bvec4(false, true, true, true));
	blockD.i[4] = (bvec4(true, false, true, true));
	blockD.i[5] = (bvec4(false, true, false, true));
	blockD.i[6] = (bvec4(false, true, false, false));
	blockD.i[7] = (bvec4(true, true, true, false));
	blockE[0].l = (mat2x3(-4.0, -7.0, 5.0, 6.0, 3.0, 7.0));
	blockE[0].m = (mat3(-6.0, -5.0, -4.0, -5.0, -6.0, 5.0, 0.0, 5.0, -3.0));
	blockE[0].n.mA = (mat2(9.0, -7.0, 9.0, 9.0));
	blockE[0].n.mB = (mat3x2(-3.0, -7.0, -3.0, 8.0, -1.0, -1.0));
	blockE[0].n.mC = (mat3x2(-1.0, 1.0, 7.0, -6.0, -2.0, -8.0));
	blockE[0].n.mD[0].mA = (mat3(-1.0, -6.0, 2.0, 1.0, 4.0, 1.0, 8.0, 1.0, 6.0));
	blockE[0].n.mD[0].mB = (vec3(6.0, -8.0, -5.0));
	blockE[0].n.mD[0].mC = (vec4(1.0, -5.0, -4.0, 5.0));
	blockE[0].n.mD[1].mA = (mat3(-7.0, 7.0, 2.0, -3.0, 5.0, 1.0, 8.0, 6.0, 4.0));
	blockE[0].n.mD[1].mB = (vec3(-3.0, 0.0, -6.0));
	blockE[0].n.mD[1].mC = (vec4(-6.0, 3.0, -8.0, 8.0));
	blockE[0].n.mD[2].mA = (mat3(-6.0, -4.0, 6.0, 4.0, 5.0, 2.0, -1.0, -3.0, 4.0));
	blockE[0].n.mD[2].mB = (vec3(5.0, 3.0, -8.0));
	blockE[0].n.mD[2].mC = (vec4(5.0, 1.0, 2.0, -1.0));
	blockE[0].n.mD[3].mA = (mat3(4.0, -8.0, -9.0, -2.0, -6.0, -2.0, -6.0, 3.0, 6.0));
	blockE[0].n.mD[3].mB = (vec3(-9.0, 0.0, -7.0));
	blockE[0].n.mD[3].mC = (vec4(-5.0, -5.0, -1.0, 2.0));
	blockE[0].n.mD[4].mA = (mat3(2.0, -5.0, 3.0, 9.0, -4.0, -8.0, 6.0, 4.0, 6.0));
	blockE[0].n.mD[4].mB = (vec3(-5.0, 2.0, 5.0));
	blockE[0].n.mD[4].mC = (vec4(-1.0, -8.0, -9.0, 6.0));
	blockE[0].n.mD[5].mA = (mat3(-4.0, 8.0, -9.0, -6.0, -6.0, 2.0, 8.0, 8.0, -4.0));
	blockE[0].n.mD[5].mB = (vec3(-5.0, 4.0, 5.0));
	blockE[0].n.mD[5].mC = (vec4(2.0, -6.0, 3.0, -5.0));
	blockE[0].n.mD[6].mA = (mat3(-9.0, -6.0, -2.0, -5.0, 4.0, -2.0, -9.0, 2.0, 9.0));
	blockE[0].n.mD[6].mB = (vec3(-8.0, 1.0, -7.0));
	blockE[0].n.mD[6].mC = (vec4(-4.0, 1.0, -5.0, -4.0));
	blockE[1].l = (mat2x3(-7.0, 7.0, 3.0, -7.0, -5.0, -3.0));
	blockE[1].m = (mat3(-6.0, -6.0, 2.0, 5.0, 3.0, -2.0, 5.0, 9.0, 8.0));
	blockE[1].n.mA = (mat2(-9.0, 7.0, 0.0, 8.0));
	blockE[1].n.mB = (mat3x2(-9.0, -9.0, 7.0, -6.0, 2.0, 9.0));
	blockE[1].n.mC = (mat3x2(-4.0, -5.0, -1.0, -4.0, -5.0, 8.0));
	blockE[1].n.mD[0].mA = (mat3(4.0, -7.0, 0.0, -4.0, 0.0, -7.0, 7.0, 4.0, -2.0));
	blockE[1].n.mD[0].mB = (vec3(9.0, 7.0, 8.0));
	blockE[1].n.mD[0].mC = (vec4(3.0, -9.0, 4.0, -3.0));
	blockE[1].n.mD[1].mA = (mat3(3.0, 4.0, 4.0, 8.0, -6.0, -2.0, 1.0, 0.0, 6.0));
	blockE[1].n.mD[1].mB = (vec3(2.0, 1.0, 3.0));
	blockE[1].n.mD[1].mC = (vec4(3.0, 2.0, 8.0, -3.0));
	blockE[1].n.mD[2].mA = (mat3(-6.0, -6.0, -2.0, -7.0, -5.0, -7.0, 5.0, 8.0, -8.0));
	blockE[1].n.mD[2].mB = (vec3(-9.0, -9.0, -8.0));
	blockE[1].n.mD[2].mC = (vec4(-9.0, -1.0, 7.0, 1.0));
	blockE[1].n.mD[3].mA = (mat3(-8.0, -1.0, -7.0, 9.0, 6.0, 3.0, -4.0, 3.0, 4.0));
	blockE[1].n.mD[3].mB = (vec3(-3.0, 6.0, -4.0));
	blockE[1].n.mD[3].mC = (vec4(-4.0, 0.0, 2.0, -8.0));
	blockE[1].n.mD[4].mA = (mat3(-4.0, -1.0, 8.0, 4.0, -5.0, 8.0, 1.0, -3.0, 4.0));
	blockE[1].n.mD[4].mB = (vec3(9.0, 7.0, -8.0));
	blockE[1].n.mD[4].mC = (vec4(0.0, 9.0, -3.0, -3.0));
	blockE[1].n.mD[5].mA = (mat3(8.0, 9.0, 3.0, -9.0, -7.0, -2.0, -8.0, -4.0, 4.0));
	blockE[1].n.mD[5].mB = (vec3(3.0, -7.0, -8.0));
	blockE[1].n.mD[5].mC = (vec4(0.0, -7.0, 6.0, 0.0));
	blockE[1].n.mD[6].mA = (mat3(-2.0, -8.0, 4.0, -6.0, 8.0, -2.0, -4.0, -7.0, 7.0));
	blockE[1].n.mD[6].mB = (vec3(7.0, -7.0, -9.0));
	blockE[1].n.mD[6].mC = (vec4(-1.0, 5.0, 6.0, 1.0));
}
#version 450
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
layout(std430, row_major, buffer_reference) buffer BlockB
{
	highp mat4 a;
	mediump vec3 b;
	bvec4 c;
	bvec3 d[];
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp uint e[];
};
layout(std140, buffer_reference) buffer BlockD
{
	bvec2 f[7][6];
	lowp mat2 g;
	sA h[];
};
layout(std140, buffer_reference) buffer BlockE
{
	bool i;
	highp float j;
	lowp uint k;
	highp mat2 l;
	lowp mat4 m[];
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
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.b), vec3(-6.0, -3.0, 0.0)) && allOk;
	allOk = compare_bvec4((blockB.c), bvec4(false, false, false, true)) && allOk;
	allOk = compare_bvec3((blockB.d[0]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((blockB.d[1]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((blockB.d[2]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((blockB.d[3]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((blockB.d[4]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockB.d[5]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((blockB.d[6]), bvec3(false, true, false)) && allOk;
	allOk = compare_uint((blockC.e[0]), 6u) && allOk;
	allOk = compare_uint((blockC.e[1]), 9u) && allOk;
	allOk = compare_uint((blockC.e[2]), 1u) && allOk;
	allOk = compare_mat2(blockD.g, mat2(6.0, -4.0, 7.0, 3.0)) && allOk;
	allOk = compare_bvec4((blockD.h[0].mA), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((blockD.h[1].mA), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bool((blockE.i), false) && allOk;
	allOk = compare_uint((blockE.k), 0u) && allOk;
	allOk = compare_mat2(blockE.l, mat2(4.0, -5.0, 9.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4(-7.0, -4.0, -4.0, 0.0, 3.0, -1.0, 3.0, -7.0, -9.0, 9.0, -7.0, -9.0, -7.0, -4.0, -4.0, -8.0));
	blockB.c = (bvec4(false, true, false, true));
	blockB.d[0] = (bvec3(true, false, false));
	blockB.d[1] = (bvec3(true, true, true));
	blockB.d[2] = (bvec3(true, false, false));
	blockB.d[3] = (bvec3(true, true, false));
	blockB.d[4] = (bvec3(true, true, false));
	blockB.d[5] = (bvec3(false, false, false));
	blockB.d[6] = (bvec3(true, false, true));
	blockC.e[0] = (0u);
	blockC.e[1] = (3u);
	blockC.e[2] = (9u);
	blockD.f[0][0] = (bvec2(true, true));
	blockD.f[0][1] = (bvec2(true, false));
	blockD.f[0][2] = (bvec2(false, false));
	blockD.f[0][3] = (bvec2(true, false));
	blockD.f[0][4] = (bvec2(false, false));
	blockD.f[0][5] = (bvec2(false, false));
	blockD.f[1][0] = (bvec2(true, true));
	blockD.f[1][1] = (bvec2(false, true));
	blockD.f[1][2] = (bvec2(false, true));
	blockD.f[1][3] = (bvec2(true, true));
	blockD.f[1][4] = (bvec2(false, true));
	blockD.f[1][5] = (bvec2(true, false));
	blockD.f[2][0] = (bvec2(false, true));
	blockD.f[2][1] = (bvec2(false, false));
	blockD.f[2][2] = (bvec2(true, true));
	blockD.f[2][3] = (bvec2(true, true));
	blockD.f[2][4] = (bvec2(false, false));
	blockD.f[2][5] = (bvec2(true, true));
	blockD.f[3][0] = (bvec2(true, true));
	blockD.f[3][1] = (bvec2(true, false));
	blockD.f[3][2] = (bvec2(false, true));
	blockD.f[3][3] = (bvec2(false, false));
	blockD.f[3][4] = (bvec2(false, false));
	blockD.f[3][5] = (bvec2(true, false));
	blockD.f[4][0] = (bvec2(true, false));
	blockD.f[4][1] = (bvec2(false, true));
	blockD.f[4][2] = (bvec2(false, false));
	blockD.f[4][3] = (bvec2(true, true));
	blockD.f[4][4] = (bvec2(false, true));
	blockD.f[4][5] = (bvec2(false, true));
	blockD.f[5][0] = (bvec2(false, false));
	blockD.f[5][1] = (bvec2(false, false));
	blockD.f[5][2] = (bvec2(true, true));
	blockD.f[5][3] = (bvec2(true, true));
	blockD.f[5][4] = (bvec2(true, true));
	blockD.f[5][5] = (bvec2(false, false));
	blockD.f[6][0] = (bvec2(false, false));
	blockD.f[6][1] = (bvec2(false, true));
	blockD.f[6][2] = (bvec2(false, true));
	blockD.f[6][3] = (bvec2(true, false));
	blockD.f[6][4] = (bvec2(true, false));
	blockD.f[6][5] = (bvec2(true, false));
	blockD.g = (mat2(8.0, -1.0, -6.0, 4.0));
	blockE.i = (true);
	blockE.j = (5.0);
	blockE.l = (mat2(-6.0, 9.0, -3.0, -2.0));
}
#version 450
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
	layout(offset = 0) bool a;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump ivec3 b;
	layout(offset = 16) highp ivec2 c[1];
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) bvec2 d;
	layout(offset = 16) bvec4 e;
	layout(offset = 32) highp ivec3 f;
	layout(offset = 44) highp uint g;
	layout(offset = 48) bvec4 h[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[2];
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a), true) && allOk;
	allOk = compare_ivec3((blockC.b), ivec3(3, -8, 3)) && allOk;
	allOk = compare_bvec2((blockD[0].d), bvec2(true, false)) && allOk;
	allOk = compare_bvec4((blockD[0].h[0]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec2((blockD[1].d), bvec2(true, false)) && allOk;
	allOk = compare_bvec4((blockD[1].h[0]), bvec4(false, true, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (ivec3(-9, -7, -4));
	blockC.c[0] = (ivec2(-1, 9));
	blockD[0].d = (bvec2(false, true));
	blockD[0].e = (bvec4(true, true, false, false));
	blockD[0].f = (ivec3(-4, -7, 2));
	blockD[0].g = (1u);
	blockD[1].d = (bvec2(false, false));
	blockD[1].e = (bvec4(true, true, true, true));
	blockD[1].f = (ivec3(5, 3, -3));
	blockD[1].g = (6u);
}
#version 450
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
	lowp mat4x3 mB;
	lowp vec3 mC;
};
struct sB
{
	bvec4 mA;
	lowp uvec3 mB;
	bool mC;
	lowp float mD;
};
layout(scalar, buffer_reference) buffer BlockB
{
	sA a;
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	bvec3 b;
	bvec2 c;
	highp vec2 d;
	sB e[];
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	lowp vec4 f;
	mediump mat4x2 g;
	lowp vec2 h;
	mediump float i[];
};
layout(scalar, buffer_reference) buffer BlockE
{
	mediump mat3 j;
	mediump vec4 k;
	lowp int l;
	lowp mat4x3 m;
	mediump vec2 n[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB[0].a.mA, mat4x2(-7.0, 3.0, -2.0, 9.0, -9.0, -1.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x3(blockB[0].a.mB, mat4x3(-8.0, 6.0, -5.0, -8.0, 2.0, 7.0, -7.0, 7.0, -4.0, 8.0, -1.0, 2.0)) && allOk;
	allOk = compare_vec3((blockB[0].a.mC), vec3(0.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat4x2(blockB[1].a.mA, mat4x2(-5.0, 2.0, 7.0, -5.0, 4.0, -7.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat4x3(blockB[1].a.mB, mat4x3(-3.0, -2.0, 0.0, -6.0, -3.0, 1.0, 8.0, -5.0, 8.0, 8.0, 9.0, 6.0)) && allOk;
	allOk = compare_vec3((blockB[1].a.mC), vec3(-2.0, -4.0, 1.0)) && allOk;
	allOk = compare_bvec3((blockC.b), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec2((blockC.c), bvec2(false, true)) && allOk;
	allOk = compare_vec2((blockC.d), vec2(-5.0, -4.0)) && allOk;
	allOk = compare_bvec4((blockC.e[0].mA), bvec4(false, true, true, true)) && allOk;
	allOk = compare_uvec3((blockC.e[0].mB), uvec3(5u, 1u, 0u)) && allOk;
	allOk = compare_bool((blockC.e[0].mC), false) && allOk;
	allOk = compare_float((blockC.e[0].mD), -4.0) && allOk;
	allOk = compare_bvec4((blockC.e[1].mA), bvec4(true, false, false, false)) && allOk;
	allOk = compare_uvec3((blockC.e[1].mB), uvec3(2u, 7u, 1u)) && allOk;
	allOk = compare_bool((blockC.e[1].mC), false) && allOk;
	allOk = compare_float((blockC.e[1].mD), -3.0) && allOk;
	allOk = compare_vec4((blockD.f), vec4(-7.0, 9.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(blockD.g, mat4x2(-7.0, -1.0, 8.0, -4.0, 1.0, 8.0, 4.0, 2.0)) && allOk;
	allOk = compare_float((blockD.i[0]), 5.0) && allOk;
	allOk = compare_float((blockD.i[1]), -4.0) && allOk;
	allOk = compare_mat3(blockE.j, mat3(7.0, 0.0, -7.0, -7.0, -1.0, 3.0, -2.0, -4.0, -5.0)) && allOk;
	allOk = compare_vec4((blockE.k), vec4(6.0, -6.0, 5.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a.mA = (mat4x2(-6.0, -2.0, 3.0, -5.0, -4.0, 5.0, -9.0, 8.0));
	blockB[0].a.mB = (mat4x3(1.0, 9.0, 5.0, -4.0, -9.0, -3.0, 7.0, 3.0, 2.0, -7.0, 1.0, 3.0));
	blockB[0].a.mC = (vec3(2.0, -7.0, 4.0));
	blockB[1].a.mA = (mat4x2(9.0, -8.0, -1.0, 3.0, -1.0, 4.0, 1.0, -8.0));
	blockB[1].a.mB = (mat4x3(-8.0, -1.0, -5.0, 7.0, -5.0, -3.0, -8.0, 6.0, -4.0, -9.0, 8.0, -8.0));
	blockB[1].a.mC = (vec3(-5.0, 1.0, 4.0));
	blockC.b = (bvec3(false, false, true));
	blockC.d = (vec2(8.0, 9.0));
	blockC.e[0].mA = (bvec4(true, false, true, true));
	blockC.e[0].mB = (uvec3(5u, 0u, 4u));
	blockC.e[0].mC = (false);
	blockC.e[0].mD = (-9.0);
	blockC.e[1].mA = (bvec4(true, false, true, false));
	blockC.e[1].mB = (uvec3(7u, 1u, 4u));
	blockC.e[1].mC = (false);
	blockC.e[1].mD = (-7.0);
	blockD.f = (vec4(9.0, -7.0, -8.0, 7.0));
	blockD.g = (mat4x2(4.0, -4.0, 4.0, -1.0, 7.0, -1.0, 4.0, -8.0));
	blockD.h = (vec2(-7.0, -7.0));
	blockE.j = (mat3(-1.0, -7.0, 1.0, 2.0, -3.0, -4.0, -6.0, -3.0, 1.0));
	blockE.k = (vec4(8.0, 2.0, 1.0, -9.0));
	blockE.l = (9);
}
#version 450
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
	lowp uvec4 a;
	bvec2 b;
	highp vec3 c[6];
	lowp float d[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	mediump vec3 e;
	mediump uvec2 f;
	highp uvec4 g;
	mediump ivec2 h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a), uvec4(4u, 9u, 0u, 0u)) && allOk;
	allOk = compare_bvec2((blockB.b), bvec2(true, false)) && allOk;
	allOk = compare_float((blockB.d[0]), -2.0) && allOk;
	allOk = compare_float((blockB.d[1]), 8.0) && allOk;
	allOk = compare_float((blockB.d[2]), -4.0) && allOk;
	allOk = compare_float((blockB.d[3]), 1.0) && allOk;
	allOk = compare_vec3((blockC.e), vec3(9.0, 4.0, 1.0)) && allOk;
	allOk = compare_uvec2((blockC.f), uvec2(3u, 6u)) && allOk;
	allOk = compare_ivec2((blockC.h), ivec2(9, 7)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec4(0u, 3u, 1u, 1u));
	blockB.b = (bvec2(true, true));
	blockB.c[0] = (vec3(4.0, -7.0, -3.0));
	blockB.c[1] = (vec3(-5.0, 7.0, -3.0));
	blockB.c[2] = (vec3(-4.0, 3.0, -5.0));
	blockB.c[3] = (vec3(-1.0, -5.0, -6.0));
	blockB.c[4] = (vec3(6.0, 5.0, -1.0));
	blockB.c[5] = (vec3(2.0, 8.0, 8.0));
	blockC.e = (vec3(-2.0, -2.0, 6.0));
	blockC.g = (uvec4(1u, 2u, 0u, 9u));
	blockC.h = (ivec2(-5, 3));
}
#version 450
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
	lowp uint a;
	lowp mat4x2 b;
	mediump vec3 c;
	mediump mat4x2 d[4];
	bvec3 e[];
};
layout(scalar, column_major, buffer_reference) readonly buffer BlockC
{
	bvec3 f;
	highp ivec4 g;
	mediump mat4x2 h[];
};
layout(scalar, row_major, buffer_reference) buffer BlockD
{
	highp vec3 i;
	bool j;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 2u) && allOk;
	allOk = compare_mat4x2(blockB.b, mat4x2(4.0, -4.0, -3.0, 8.0, 6.0, 1.0, -1.0, 8.0)) && allOk;
	allOk = compare_vec3((blockB.c), vec3(-7.0, 9.0, 9.0)) && allOk;
	allOk = compare_bvec3((blockC.f), bvec3(false, false, false)) && allOk;
	allOk = compare_vec3((blockD[0].i), vec3(6.0, 1.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (6u);
	blockB.b = (mat4x2(-9.0, -8.0, 1.0, 2.0, -1.0, 1.0, -7.0, 3.0));
	blockB.c = (vec3(5.0, -2.0, 1.0));
	blockB.d[0] = (mat4x2(-2.0, 3.0, 3.0, -4.0, 1.0, 1.0, -2.0, -1.0));
	blockB.d[1] = (mat4x2(3.0, -8.0, 2.0, 9.0, -3.0, 2.0, -8.0, -5.0));
	blockB.d[2] = (mat4x2(1.0, 8.0, 6.0, -3.0, 9.0, -8.0, 4.0, 4.0));
	blockB.d[3] = (mat4x2(6.0, -5.0, -8.0, -3.0, 1.0, -9.0, 0.0, 4.0));
	blockB.e[0] = (bvec3(true, true, false));
	blockB.e[1] = (bvec3(false, true, false));
	blockD[0].i = (vec3(6.0, -6.0, -3.0));
}
#version 450
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
	lowp vec3 a;
	highp vec3 b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB[nonuniformEXT(0)].b), vec3(-9.0, 0.0, -2.0)) && allOk;
	allOk = compare_vec3((blockB[nonuniformEXT(1)].b), vec3(-1.0, 0.0, 5.0)) && allOk;
	allOk = compare_vec3((blockB[nonuniformEXT(2)].b), vec3(-5.0, 6.0, 0.0)) && allOk;
	allOk = compare_vec3((blockB[nonuniformEXT(3)].b), vec3(4.0, 2.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (vec3(5.0, -4.0, 7.0));
	blockB[nonuniformEXT(0)].b = (vec3(9.0, 0.0, 9.0));
	blockB[nonuniformEXT(1)].a = (vec3(-5.0, -3.0, 3.0));
	blockB[nonuniformEXT(1)].b = (vec3(5.0, -9.0, 5.0));
	blockB[nonuniformEXT(2)].a = (vec3(5.0, 2.0, 6.0));
	blockB[nonuniformEXT(2)].b = (vec3(-5.0, -8.0, -8.0));
	blockB[nonuniformEXT(3)].a = (vec3(-6.0, 9.0, 7.0));
	blockB[nonuniformEXT(3)].b = (vec3(0.0, 1.0, -3.0));
}
#version 450
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
	lowp ivec2 c[7];
	highp mat3x4 d;
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	lowp uvec3 e;
	mediump mat2 f[2];
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
	allOk = compare_ivec2((blockB.c[1]), ivec2(4, -4)) && allOk;
	allOk = compare_ivec2((blockB.c[2]), ivec2(-9, -9)) && allOk;
	allOk = compare_ivec2((blockB.c[3]), ivec2(-7, 9)) && allOk;
	allOk = compare_ivec2((blockB.c[4]), ivec2(-3, -8)) && allOk;
	allOk = compare_ivec2((blockB.c[5]), ivec2(6, 0)) && allOk;
	allOk = compare_ivec2((blockB.c[6]), ivec2(-1, -3)) && allOk;
	allOk = compare_uvec3((blockC.e), uvec3(5u, 0u, 7u)) && allOk;
	allOk = compare_mat2(blockC.f[0], mat2(-2.0, 4.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat2(blockC.f[1], mat2(1.0, -8.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4(blockC.g, mat4(0.0, -3.0, 9.0, 1.0, -6.0, 1.0, 0.0, -5.0, -7.0, -9.0, 6.0, -4.0, -1.0, 5.0, 3.0, 8.0)) && allOk;
	allOk = compare_bvec3((blockD.h), bvec3(true, false, true)) && allOk;
	allOk = compare_int16_t(int(blockD.i), 0) && allOk;
	allOk = compare_ivec4((blockD.j), ivec4(-7, -9, 6, 4)) && allOk;
	allOk = compare_mat3(blockE.k, mat3(5.0, 1.0, 8.0, 3.0, 1.0, 8.0, -1.0, -7.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec4(uvec4(9u, 2u, 1u, 0u));
	blockB.b = i16vec3(ivec3(1, -7, -4));
	blockB.c[0] = (ivec2(-4, -6));
	blockB.c[1] = (ivec2(-5, -2));
	blockB.c[2] = (ivec2(4, -2));
	blockB.c[3] = (ivec2(5, -9));
	blockB.c[4] = (ivec2(-3, -1));
	blockB.c[5] = (ivec2(-9, 1));
	blockB.c[6] = (ivec2(1, 7));
	blockB.d = (mat3x4(8.0, 9.0, -7.0, -1.0, -6.0, 5.0, 6.0, 5.0, 6.0, -6.0, -9.0, 3.0));
	blockC.e = (uvec3(7u, 3u, 2u));
	blockC.f[0] = (mat2(-5.0, 3.0, -9.0, -6.0));
	blockC.f[1] = (mat2(-3.0, -7.0, -1.0, -5.0));
	blockD.h = (bvec3(true, true, true));
	blockE.k = (mat3(5.0, 1.0, -4.0, -5.0, 8.0, -5.0, -2.0, -2.0, 8.0));
}
#version 450
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
};
layout(std430, column_major, buffer_reference) buffer BlockB
{
	float16_t a[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	sA b;
	mediump mat3x2 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockB.a[0]), 0.0) && allOk;
	allOk = compare_bool((blockC.b.mA), false) && allOk;
	allOk = compare_mat3x2(blockC.c[0], mat3x2(3.0, -3.0, 2.0, 1.0, 0.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = float16_t(5.0);
	blockC.b.mA = (true);
	blockC.c[0] = (mat3x2(9.0, 0.0, -5.0, -1.0, -5.0, -9.0));
}
#version 450
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
	i16vec3 a[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(blockB.a[0]), ivec3(1, -6, -5)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB.a[1]), ivec3(7, 2, -1)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = i16vec3(ivec3(9, 7, 5));
	blockB.a[1] = i16vec3(ivec3(-2, 9, -6));
}
#version 450
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
	highp mat4 mB;
};
layout(std430, column_major, buffer_reference) buffer BlockB
{
	f16vec4 a;
	highp vec3 b;
	f16vec2 c;
	sA d;
	mediump mat3x4 e[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	uint16_t f;
	lowp mat2x3 g;
	i16vec3 h;
	lowp uvec3 i[7];
	u16vec3 j[2];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(blockB.a), vec4(4.0, -1.0, 1.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockB.c), vec2(-4.0, 2.0)) && allOk;
	allOk = compare_mat3x4(blockB.e[0], mat3x4(-7.0, 9.0, 7.0, -5.0, -9.0, 7.0, 3.0, -6.0, -5.0, -3.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x4(blockB.e[1], mat3x4(8.0, -3.0, 6.0, -1.0, -3.0, -6.0, 7.0, 6.0, -7.0, 2.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(blockB.e[2], mat3x4(3.0, 1.0, 5.0, 8.0, 7.0, -7.0, 6.0, -6.0, -6.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat3x4(blockB.e[3], mat3x4(7.0, 4.0, 1.0, 0.0, 2.0, -7.0, -7.0, 9.0, -6.0, -9.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(blockB.e[4], mat3x4(6.0, -1.0, 8.0, -2.0, 7.0, -6.0, -6.0, 3.0, 2.0, 9.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x4(blockB.e[5], mat3x4(0.0, 3.0, 9.0, -7.0, -8.0, 6.0, 9.0, -1.0, 0.0, -6.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(blockB.e[6], mat3x4(6.0, 2.0, -7.0, 5.0, -7.0, -7.0, -1.0, -9.0, -2.0, 6.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2x3(blockC.g, mat2x3(-6.0, -5.0, 8.0, 6.0, 4.0, 0.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockC.h), ivec3(7, -7, -9)) && allOk;
	allOk = compare_uvec3((blockC.i[0]), uvec3(7u, 9u, 3u)) && allOk;
	allOk = compare_uvec3((blockC.i[1]), uvec3(2u, 7u, 1u)) && allOk;
	allOk = compare_uvec3((blockC.i[2]), uvec3(5u, 2u, 8u)) && allOk;
	allOk = compare_uvec3((blockC.i[3]), uvec3(6u, 8u, 3u)) && allOk;
	allOk = compare_uvec3((blockC.i[4]), uvec3(2u, 3u, 1u)) && allOk;
	allOk = compare_uvec3((blockC.i[5]), uvec3(6u, 1u, 1u)) && allOk;
	allOk = compare_uvec3((blockC.i[6]), uvec3(6u, 4u, 4u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.j[0]), uvec3(9u, 9u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.j[1]), uvec3(2u, 4u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = f16vec4(vec4(5.0, 7.0, -9.0, -6.0));
	blockB.b = (vec3(1.0, -2.0, -1.0));
	blockB.d.mA = f16vec4(vec4(-9.0, -2.0, -4.0, -4.0));
	blockB.d.mB = (mat4(3.0, 4.0, 9.0, 1.0, 2.0, -6.0, 5.0, 9.0, 2.0, -1.0, -7.0, 3.0, -7.0, -5.0, 7.0, 5.0));
	blockB.e[0] = (mat3x4(5.0, 7.0, -3.0, 2.0, -2.0, 9.0, 5.0, 7.0, -5.0, 9.0, -3.0, 8.0));
	blockB.e[1] = (mat3x4(-3.0, 7.0, -4.0, -9.0, -2.0, 9.0, 7.0, 8.0, -1.0, 5.0, -4.0, 9.0));
	blockB.e[2] = (mat3x4(-2.0, -5.0, -8.0, -4.0, 0.0, 8.0, 2.0, 6.0, 3.0, -7.0, -9.0, -2.0));
	blockB.e[3] = (mat3x4(-9.0, 9.0, 7.0, 0.0, 2.0, 3.0, -4.0, -9.0, -5.0, 4.0, -2.0, -3.0));
	blockB.e[4] = (mat3x4(3.0, 6.0, -6.0, 9.0, -8.0, 4.0, 4.0, 7.0, -6.0, 7.0, -9.0, -2.0));
	blockB.e[5] = (mat3x4(3.0, -8.0, -8.0, 9.0, 5.0, 1.0, -5.0, 8.0, -4.0, 5.0, 0.0, 6.0));
	blockB.e[6] = (mat3x4(3.0, 8.0, -7.0, 2.0, 8.0, -4.0, 1.0, -7.0, 6.0, -2.0, -4.0, 7.0));
	blockC.f = uint16_t(0u);
	blockC.i[0] = (uvec3(9u, 1u, 1u));
	blockC.i[1] = (uvec3(0u, 4u, 9u));
	blockC.i[2] = (uvec3(1u, 2u, 8u));
	blockC.i[3] = (uvec3(1u, 4u, 5u));
	blockC.i[4] = (uvec3(8u, 7u, 1u));
	blockC.i[5] = (uvec3(5u, 6u, 8u));
	blockC.i[6] = (uvec3(0u, 3u, 1u));
	blockC.j[0] = u16vec3(uvec3(7u, 7u, 7u));
	blockC.j[1] = u16vec3(uvec3(7u, 2u, 1u));
}
#version 450
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
	layout(offset = 0) f16vec3 a;
	layout(offset = 6) uint16_t b;
	layout(offset = 8) highp int c;
	layout(offset = 16) lowp uvec4 d[1];
	layout(offset = 32) uint16_t e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(blockB.a), vec3(-6.0, -1.0, -4.0)) && allOk;
	allOk = compare_uint16_t(uint(blockB.b), 4u) && allOk;
	allOk = compare_int((blockB.c), -1) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = uint16_t(6u);
	blockB.d[0] = (uvec4(2u, 2u, 2u, 0u));
	blockB.e = uint16_t(7u);
}
#version 450
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
	f16vec2 a[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	int16_t b;
	lowp vec3 c[];
};
layout(scalar, row_major, buffer_reference) buffer BlockD
{
	f16vec4 d;
	lowp uvec3 e;
	bvec4 f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
    BlockD blockD[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(blockC[0].b), -6) && allOk;
	allOk = compare_int16_t(int(blockC[1].b), 9) && allOk;
	allOk = compare_int16_t(int(blockC[2].b), 8) && allOk;
	allOk = compare_uvec3((blockD[0].e), uvec3(5u, 0u, 4u)) && allOk;
	allOk = compare_uvec3((blockD[1].e), uvec3(5u, 9u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC[0].b = int16_t(7);
	blockC[0].c[0] = (vec3(-5.0, -5.0, -4.0));
	blockC[0].c[1] = (vec3(1.0, -7.0, 1.0));
	blockC[0].c[2] = (vec3(1.0, -9.0, -7.0));
	blockC[0].c[3] = (vec3(-8.0, 6.0, 5.0));
	blockC[0].c[4] = (vec3(0.0, 1.0, -1.0));
	blockC[0].c[5] = (vec3(6.0, 3.0, 6.0));
	blockC[0].c[6] = (vec3(-6.0, 2.0, 6.0));
	blockC[0].c[7] = (vec3(9.0, -9.0, 4.0));
	blockC[1].b = int16_t(4);
	blockC[1].c[0] = (vec3(-4.0, -4.0, 0.0));
	blockC[2].b = int16_t(3);
	blockC[2].c[0] = (vec3(-8.0, 1.0, 0.0));
	blockC[2].c[1] = (vec3(0.0, -5.0, -3.0));
	blockC[2].c[2] = (vec3(-7.0, -6.0, -8.0));
	blockC[2].c[3] = (vec3(0.0, 1.0, 6.0));
	blockC[2].c[4] = (vec3(-6.0, 9.0, 6.0));
	blockD[0].d = f16vec4(vec4(-7.0, -3.0, 3.0, 1.0));
	blockD[0].f[0] = (bvec4(true, true, true, false));
	blockD[0].f[1] = (bvec4(true, true, true, false));
	blockD[0].f[2] = (bvec4(false, false, true, true));
	blockD[0].f[3] = (bvec4(false, true, false, false));
	blockD[0].f[4] = (bvec4(true, true, true, false));
	blockD[0].f[5] = (bvec4(true, true, false, false));
	blockD[1].d = f16vec4(vec4(4.0, -7.0, 0.0, -5.0));
	blockD[1].f[0] = (bvec4(false, true, true, false));
	blockD[1].f[1] = (bvec4(false, false, false, true));
	blockD[1].f[2] = (bvec4(true, false, true, true));
	blockD[1].f[3] = (bvec4(false, false, false, true));
	blockD[1].f[4] = (bvec4(true, true, false, true));
	blockD[1].f[5] = (bvec4(true, true, true, false));
	blockD[1].f[6] = (bvec4(false, true, true, false));
	blockD[1].f[7] = (bvec4(true, true, true, false));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(row_major, buffer_reference) buffer BlockB
{
	layout(offset = 0) lowp uvec2 a;
	layout(offset = 16) highp ivec3 b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB[nonuniformEXT(0)].a), uvec2(7u, 1u)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(1)].a), uvec2(4u, 3u)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(2)].a), uvec2(9u, 6u)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(3)].a), uvec2(8u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (uvec2(7u, 8u));
	blockB[nonuniformEXT(0)].b = (ivec3(-2, 6, 0));
	blockB[nonuniformEXT(1)].a = (uvec2(7u, 3u));
	blockB[nonuniformEXT(1)].b = (ivec3(-5, 4, 7));
	blockB[nonuniformEXT(2)].a = (uvec2(0u, 3u));
	blockB[nonuniformEXT(2)].b = (ivec3(5, 8, 6));
	blockB[nonuniformEXT(3)].a = (uvec2(6u, 0u));
	blockB[nonuniformEXT(3)].b = (ivec3(-2, -4, -2));
}
#version 450
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
	int16_t a;
	mediump mat3 b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

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

layout(std430, row_major, buffer_reference) buffer BlockB
{
	highp uvec4 a;
	mediump mat3x4 b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB[nonuniformEXT(0)].a), uvec4(1u, 2u, 9u, 2u)) && allOk;
	allOk = compare_uvec4((blockB[nonuniformEXT(1)].a), uvec4(1u, 6u, 2u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (uvec4(7u, 1u, 6u, 4u));
	blockB[nonuniformEXT(1)].a = (uvec4(1u, 4u, 9u, 6u));
}
#version 450
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
	mediump int a;
	uint8_t b;
	bool c;
	uint8_t d;
	int8_t e;
};
layout(std140, buffer_reference) readonly buffer BlockC
{
	uint8_t f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.a), -8) && allOk;
	allOk = compare_uint8_t(uint(blockB.b), 2u) && allOk;
	allOk = compare_uint8_t(uint(blockB.d), 6u) && allOk;
	allOk = compare_int8_t(int(blockB.e), 4294967292) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (4);
	blockB.b = uint8_t(2u);
	blockB.c = (true);
	blockB.d = uint8_t(9u);
	blockB.e = int8_t(4294967289);
}
#version 450
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
	bvec4 a;
	highp vec3 b;
	lowp uint c;
	mediump ivec4 d;
	i8vec4 e;
};
layout(std140, buffer_reference) buffer BlockC
{
	int8_t f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.b), vec3(-7.0, 1.0, 2.0)) && allOk;
	allOk = compare_ivec4((blockB.d), ivec4(7, 9, -8, 2)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.e), ivec4(9, 6, 4294967291, 7)) && allOk;
	allOk = compare_int8_t(int(blockC.f), 3) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (vec3(0.0, 0.0, -7.0));
	blockB.c = (8u);
	blockB.d = (ivec4(3, 4, 7, 8));
	blockB.e = i8vec4(ivec4(3, 8, 8, 0));
	blockC.f = int8_t(8);
}
#version 450
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
	u8vec2 a;
	mediump mat4 b;
	mediump uint c;
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	highp float d;
	highp float e[1];
	u8vec3 f;
	u8vec4 g;
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	lowp mat3x2 h[1];
	lowp mat4 i;
};
layout(std140, row_major, buffer_reference) readonly buffer BlockE
{
	lowp uvec4 j;
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
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(blockB.a), uvec2(7u, 9u)) && allOk;
	allOk = compare_mat4(blockB.b, mat4(-7.0, -3.0, 3.0, 8.0, 9.0, 9.0, -3.0, 8.0, -1.0, -2.0, 2.0, -3.0, 0.0, 0.0, -3.0, 8.0)) && allOk;
	allOk = compare_uint((blockB.c), 4u) && allOk;
	allOk = compare_float((blockC.e[0]), -3.0) && allOk;
	allOk = compare_u8vec4(uvec4(blockC.g), uvec4(2u, 4u, 3u, 0u)) && allOk;
	allOk = compare_mat3x2(blockD.h[0], mat3x2(-8.0, 9.0, 7.0, -2.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat4(blockD.i, mat4(-3.0, -8.0, -7.0, -2.0, -8.0, -1.0, -9.0, 1.0, 3.0, -6.0, -8.0, 0.0, 3.0, -8.0, -3.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (8u);
	blockC.d = (-4.0);
	blockC.e[0] = (-6.0);
	blockD.h[0] = (mat3x2(4.0, -5.0, -6.0, 2.0, 8.0, 0.0));
}
#version 450
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
	lowp mat2x3 a;
	u8vec2 b;
	bvec4 c;
	lowp ivec4 d;
	highp mat4x3 e[];
};
layout(std140, buffer_reference) buffer BlockC
{
	highp mat4 f;
	mediump float g[];
};
layout(std140, buffer_reference) buffer BlockD
{
	i8vec3 h;
	mediump mat4 i;
	highp mat4x3 j[];
};
layout(std140, buffer_reference) buffer BlockE
{
	highp mat4 k;
	highp mat3 l;
	lowp mat4x2 m;
	mediump mat4x3 n[];
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
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.d), ivec4(7, -2, -4, -9)) && allOk;
	allOk = compare_mat4x3(blockB.e[0], mat4x3(8.0, 1.0, -1.0, 3.0, 8.0, -1.0, 0.0, 0.0, -7.0, 2.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat4x3(blockB.e[1], mat4x3(-4.0, -9.0, 2.0, -3.0, 1.0, 0.0, 1.0, -4.0, 6.0, -4.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat4x3(blockB.e[2], mat4x3(3.0, -1.0, -8.0, -5.0, -9.0, 6.0, -1.0, -6.0, -2.0, -5.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat4x3(blockB.e[3], mat4x3(7.0, -5.0, -8.0, 2.0, 4.0, -2.0, -7.0, 8.0, -8.0, -2.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat4x3(blockB.e[4], mat4x3(-9.0, 8.0, 2.0, 0.0, -7.0, 4.0, -8.0, 9.0, 7.0, -3.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(blockB.e[5], mat4x3(-6.0, 8.0, -9.0, -8.0, -2.0, -5.0, 5.0, 6.0, 4.0, -7.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat4x3(blockB.e[6], mat4x3(-7.0, 6.0, 8.0, -4.0, 9.0, 4.0, -9.0, 8.0, 4.0, 7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x3(blockB.e[7], mat4x3(-9.0, -4.0, 3.0, -6.0, 7.0, 3.0, 7.0, -1.0, 0.0, 6.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat4(blockC.f, mat4(-7.0, 7.0, 6.0, 5.0, -5.0, -9.0, -7.0, -3.0, 7.0, -9.0, -8.0, 6.0, 3.0, 6.0, 2.0, -3.0)) && allOk;
	allOk = compare_float((blockC.g[0]), -1.0) && allOk;
	allOk = compare_float((blockC.g[1]), 4.0) && allOk;
	allOk = compare_float((blockC.g[2]), -6.0) && allOk;
	allOk = compare_float((blockC.g[3]), 3.0) && allOk;
	allOk = compare_float((blockC.g[4]), 0.0) && allOk;
	allOk = compare_mat4(blockD.i, mat4(0.0, 6.0, -9.0, -1.0, -6.0, 8.0, 2.0, -1.0, -3.0, 4.0, -7.0, -7.0, -9.0, -3.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4x3(blockD.j[0], mat4x3(-3.0, 8.0, -7.0, -6.0, 2.0, 1.0, -5.0, -7.0, 2.0, 3.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat4(blockE.k, mat4(1.0, -2.0, -4.0, 2.0, 4.0, 3.0, -8.0, -4.0, 7.0, -5.0, 0.0, -2.0, 3.0, -2.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat4x2(blockE.m, mat4x2(9.0, -9.0, 5.0, 1.0, 7.0, -6.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat4x3(blockE.n[0], mat4x3(6.0, -9.0, -5.0, -4.0, -3.0, -9.0, -6.0, -9.0, -7.0, -8.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat4x3(blockE.n[1], mat4x3(-1.0, -6.0, 7.0, -6.0, 3.0, -7.0, 5.0, 8.0, -8.0, -5.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockE.n[2], mat4x3(-7.0, 3.0, -2.0, 5.0, -8.0, -9.0, 9.0, 9.0, 5.0, -7.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat4x3(blockE.n[3], mat4x3(-9.0, 3.0, -9.0, -9.0, 0.0, -2.0, 1.0, 1.0, -7.0, 3.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(blockE.n[4], mat4x3(8.0, 4.0, 3.0, 5.0, 2.0, 1.0, 4.0, -9.0, 9.0, -7.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat4x3(blockE.n[5], mat4x3(1.0, 0.0, 7.0, 4.0, -8.0, 0.0, -8.0, -3.0, 1.0, 4.0, 9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2x3(-5.0, -2.0, -6.0, -3.0, 0.0, 6.0));
	blockB.b = u8vec2(uvec2(2u, 8u));
	blockB.d = (ivec4(-2, 2, 3, -1));
	blockB.e[0] = (mat4x3(4.0, -7.0, -9.0, -4.0, -4.0, 0.0, -6.0, 8.0, 4.0, -7.0, 2.0, 3.0));
	blockB.e[1] = (mat4x3(-1.0, 3.0, -2.0, -6.0, -5.0, -8.0, -4.0, 6.0, 5.0, -5.0, -6.0, -4.0));
	blockB.e[2] = (mat4x3(8.0, 8.0, 7.0, -5.0, -1.0, 8.0, 2.0, -1.0, 7.0, -2.0, 1.0, 0.0));
	blockB.e[3] = (mat4x3(-5.0, -6.0, 3.0, 6.0, 6.0, 2.0, 5.0, 6.0, -4.0, -6.0, -6.0, 5.0));
	blockB.e[4] = (mat4x3(-9.0, -1.0, 2.0, 5.0, -8.0, 8.0, -9.0, -7.0, -1.0, -5.0, 8.0, -1.0));
	blockB.e[5] = (mat4x3(3.0, -9.0, 5.0, -6.0, 7.0, -3.0, 6.0, 5.0, -4.0, -1.0, -7.0, -1.0));
	blockB.e[6] = (mat4x3(7.0, 1.0, 3.0, -9.0, -9.0, -2.0, 2.0, -7.0, 8.0, -7.0, 3.0, 2.0));
	blockB.e[7] = (mat4x3(-1.0, 7.0, 0.0, 7.0, -7.0, 1.0, -4.0, -1.0, 0.0, -2.0, 8.0, 0.0));
	blockC.f = (mat4(4.0, 4.0, 2.0, 7.0, 2.0, 5.0, 2.0, -5.0, 0.0, -8.0, -3.0, -2.0, -4.0, -1.0, -6.0, 2.0));
	blockC.g[0] = (5.0);
	blockC.g[1] = (-8.0);
	blockC.g[2] = (-3.0);
	blockC.g[3] = (-6.0);
	blockC.g[4] = (-2.0);
	blockD.h = i8vec3(ivec3(5, 2, 9));
	blockD.j[0] = (mat4x3(7.0, 4.0, 6.0, -7.0, 4.0, -9.0, 3.0, -4.0, 8.0, 1.0, -4.0, 4.0));
	blockE.k = (mat4(1.0, 8.0, -6.0, -5.0, -3.0, -7.0, 4.0, -9.0, 4.0, -2.0, -1.0, -3.0, 4.0, 6.0, 8.0, 1.0));
	blockE.l = (mat3(9.0, 7.0, 9.0, 9.0, -5.0, -8.0, -1.0, 6.0, 9.0));
	blockE.m = (mat4x2(-1.0, -7.0, -2.0, -4.0, 4.0, 7.0, 0.0, 6.0));
	blockE.n[0] = (mat4x3(-8.0, 8.0, -8.0, -5.0, 6.0, -1.0, 1.0, -3.0, 9.0, -1.0, 3.0, 1.0));
	blockE.n[1] = (mat4x3(-1.0, 4.0, 2.0, 6.0, -3.0, -3.0, 2.0, 3.0, -4.0, -7.0, 8.0, 8.0));
	blockE.n[2] = (mat4x3(5.0, -6.0, 0.0, 0.0, -1.0, 3.0, -3.0, -2.0, -3.0, -5.0, 0.0, -9.0));
	blockE.n[3] = (mat4x3(-6.0, 5.0, 1.0, 4.0, -6.0, 0.0, -9.0, -3.0, 8.0, 1.0, -3.0, -5.0));
	blockE.n[4] = (mat4x3(0.0, -4.0, -7.0, 3.0, 8.0, -5.0, 0.0, -1.0, 7.0, 2.0, -7.0, 0.0));
	blockE.n[5] = (mat4x3(-9.0, 1.0, -8.0, -5.0, -5.0, 0.0, 3.0, 3.0, -3.0, -6.0, -5.0, 5.0));
}
#version 450
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
	mediump mat2 a;
	bvec2 b;
	uint8_t c;
	highp float d;
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp vec2 e;
	i8vec3 f;
	mediump float g;
	u8vec4 h;
	lowp mat2 i[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	i8vec2 j;
	u8vec4 k;
	bvec4 l[3];
	i8vec3 m[];
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
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB.a, mat2(0.0, 3.0, 3.0, 2.0)) && allOk;
	allOk = compare_bvec2((blockB.b), bvec2(false, true)) && allOk;
	allOk = compare_uint8_t(uint(blockB.c), 0u) && allOk;
	allOk = compare_vec2((blockC.e), vec2(-7.0, 3.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.f), ivec3(6, 2, 3)) && allOk;
	allOk = compare_float((blockC.g), 3.0) && allOk;
	allOk = compare_u8vec4(uvec4(blockD.k), uvec4(3u, 1u, 6u, 6u)) && allOk;
	allOk = compare_bvec4((blockD.l[0]), bvec4(false, false, false, true)) && allOk;
	allOk = compare_bvec4((blockD.l[1]), bvec4(false, false, false, true)) && allOk;
	allOk = compare_bvec4((blockD.l[2]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_i8vec3(ivec3(blockD.m[0]), ivec3(1, 0, 9)) && allOk;
	allOk = compare_i8vec3(ivec3(blockD.m[1]), ivec3(4294967291, 4294967294, 4294967293)) && allOk;
	allOk = compare_i8vec3(ivec3(blockD.m[2]), ivec3(4294967292, 4294967295, 4294967290)) && allOk;
	allOk = compare_i8vec3(ivec3(blockD.m[3]), ivec3(7, 4294967290, 4294967288)) && allOk;
	allOk = compare_i8vec3(ivec3(blockD.m[4]), ivec3(6, 8, 9)) && allOk;
	allOk = compare_i8vec3(ivec3(blockD.m[5]), ivec3(2, 0, 4294967289)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = uint8_t(0u);
	blockB.d = (2.0);
	blockC.f = i8vec3(ivec3(4294967292, 8, 6));
	blockC.g = (-3.0);
	blockC.h = u8vec4(uvec4(5u, 5u, 3u, 5u));
	blockC.i[0] = (mat2(-8.0, -5.0, 9.0, -1.0));
	blockC.i[1] = (mat2(1.0, 7.0, 9.0, -8.0));
	blockC.i[2] = (mat2(-6.0, 4.0, 8.0, -8.0));
	blockD.j = i8vec2(ivec2(4, 6));
	blockD.k = u8vec4(uvec4(0u, 8u, 1u, 4u));
	blockD.l[0] = (bvec4(false, true, true, false));
	blockD.l[1] = (bvec4(true, true, true, false));
	blockD.l[2] = (bvec4(false, true, true, false));
}
#version 450
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
	u8vec4 a;
	int8_t b;
	bvec4 c;
	highp mat3x2 d[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	mediump mat3x4 e[];
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
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(blockB.a), uvec4(3u, 1u, 9u, 8u)) && allOk;
	allOk = compare_bvec4((blockB.c), bvec4(false, false, true, true)) && allOk;
	allOk = compare_mat3x2(blockB.d[0], mat3x2(0.0, 7.0, -1.0, -1.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[1], mat3x2(5.0, -6.0, 5.0, -7.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[2], mat3x2(-7.0, 0.0, 6.0, -7.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[3], mat3x2(3.0, -2.0, 6.0, -2.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[4], mat3x2(0.0, -1.0, 7.0, 9.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[5], mat3x2(1.0, 6.0, -5.0, 3.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[6], mat3x2(9.0, -1.0, -5.0, -3.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[7], mat3x2(1.0, -2.0, 4.0, 2.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x4(blockC.e[0], mat3x4(9.0, -4.0, 9.0, 8.0, 9.0, 1.0, -6.0, -7.0, -7.0, 1.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat3x4(blockC.e[1], mat3x4(2.0, -1.0, 1.0, -1.0, -8.0, -9.0, 2.0, -6.0, 9.0, -5.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3x4(blockC.e[2], mat3x4(2.0, 7.0, -4.0, 3.0, -3.0, 5.0, -9.0, 6.0, 6.0, -7.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3x4(blockC.e[3], mat3x4(0.0, -6.0, 2.0, -8.0, 6.0, 2.0, -6.0, 7.0, -7.0, -2.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat3x4(blockC.e[4], mat3x4(-2.0, -9.0, 3.0, -6.0, 8.0, -1.0, -3.0, -9.0, -4.0, -2.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(blockC.e[5], mat3x4(-8.0, -5.0, -5.0, 9.0, 0.0, 0.0, -8.0, 5.0, -6.0, 0.0, -1.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u8vec4(uvec4(3u, 2u, 9u, 0u));
	blockB.c = (bvec4(true, true, true, true));
	blockB.d[0] = (mat3x2(-4.0, -8.0, 0.0, 9.0, 3.0, 1.0));
	blockB.d[1] = (mat3x2(-6.0, 4.0, -4.0, -6.0, 9.0, 3.0));
	blockB.d[2] = (mat3x2(7.0, 7.0, -8.0, 5.0, -2.0, -7.0));
	blockB.d[3] = (mat3x2(-2.0, 5.0, 0.0, -1.0, 5.0, 4.0));
	blockB.d[4] = (mat3x2(-9.0, -1.0, -1.0, 7.0, -1.0, -7.0));
	blockB.d[5] = (mat3x2(7.0, 4.0, -3.0, 1.0, 6.0, 5.0));
	blockB.d[6] = (mat3x2(8.0, 5.0, -1.0, -1.0, -1.0, 2.0));
	blockB.d[7] = (mat3x2(-8.0, -1.0, -2.0, -8.0, 1.0, -7.0));
	blockC.e[0] = (mat3x4(-3.0, 3.0, -6.0, 1.0, -1.0, -1.0, 1.0, 2.0, -5.0, -4.0, 4.0, 7.0));
	blockC.e[1] = (mat3x4(-2.0, 8.0, -5.0, -9.0, 2.0, 3.0, 1.0, -5.0, -2.0, 5.0, -1.0, 0.0));
	blockC.e[2] = (mat3x4(-2.0, 2.0, -7.0, -7.0, -7.0, 9.0, -6.0, -8.0, 6.0, 5.0, 3.0, 2.0));
	blockC.e[3] = (mat3x4(4.0, -9.0, 9.0, 1.0, 6.0, -8.0, -6.0, -8.0, -6.0, -8.0, 7.0, 3.0));
	blockC.e[4] = (mat3x4(-6.0, -5.0, 1.0, 6.0, 6.0, 4.0, 8.0, 0.0, -8.0, 1.0, -1.0, -7.0));
	blockC.e[5] = (mat3x4(5.0, 9.0, 0.0, -2.0, 1.0, 5.0, -6.0, 4.0, -2.0, 5.0, -5.0, 6.0));
}
#version 450
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
	bvec4 mB;
	highp mat3 mC;
};
struct sB
{
	sA mA;
};
struct sC
{
	highp uint mA;
	highp uvec2 mB;
	highp float mC;
};
struct sD
{
	bvec2 mA;
	highp vec2 mB;
};
struct sE
{
	lowp ivec3 mA;
	sD mB;
	bvec3 mC;
};
layout(std430, column_major, buffer_reference) readonly buffer BlockB
{
	int8_t a;
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	sB b;
	highp int c[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	sC d;
	mediump mat4x2 e[1];
	sE f;
	highp mat2x3 g[];
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
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockC.b.mA.mA), true) && allOk;
	allOk = compare_bvec4((blockC.b.mA.mB), bvec4(false, true, false, true)) && allOk;
	allOk = compare_mat3(blockC.b.mA.mC, mat3(6.0, 1.0, -2.0, 0.0, 8.0, -8.0, -9.0, 1.0, -6.0)) && allOk;
	allOk = compare_uint((blockD.d.mA), 6u) && allOk;
	allOk = compare_uvec2((blockD.d.mB), uvec2(8u, 1u)) && allOk;
	allOk = compare_float((blockD.d.mC), 0.0) && allOk;
	allOk = compare_mat4x2(blockD.e[0], mat4x2(9.0, -6.0, 5.0, -2.0, -8.0, -1.0, -6.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b.mA.mA = (true);
	blockC.b.mA.mB = (bvec4(false, true, true, false));
	blockC.b.mA.mC = (mat3(0.0, 3.0, -4.0, -9.0, 4.0, -7.0, -6.0, -1.0, -8.0));
	blockC.c[0] = (-3);
	blockD.d.mA = (4u);
	blockD.d.mB = (uvec2(8u, 5u));
	blockD.d.mC = (-1.0);
	blockD.f.mA = (ivec3(-2, 0, 2));
	blockD.f.mB.mA = (bvec2(true, true));
	blockD.f.mB.mB = (vec2(8.0, 1.0));
	blockD.f.mC = (bvec3(true, true, false));
	blockD.g[0] = (mat2x3(-8.0, -4.0, -2.0, -6.0, -2.0, 0.0));
}
#version 450
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
	bvec4 a[];
};
layout(std430, buffer_reference) buffer BlockC
{
	highp uvec2 b;
	highp mat2 c;
	lowp mat2x3 d;
	lowp uvec2 e[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	lowp vec3 f;
	highp vec3 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[1];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a[0]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_mat2(blockC[0].c, mat2(8.0, 4.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat2x3(blockC[0].d, mat2x3(-9.0, -7.0, 9.0, -3.0, -8.0, 6.0)) && allOk;
	allOk = compare_uvec2((blockC[0].e[0]), uvec2(5u, 4u)) && allOk;
	allOk = compare_vec3((blockD.f), vec3(-3.0, 0.0, -1.0)) && allOk;
	allOk = compare_vec3((blockD.g[0]), vec3(-7.0, -7.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (bvec4(true, true, true, true));
	blockC[0].b = (uvec2(2u, 9u));
	blockC[0].d = (mat2x3(-9.0, -3.0, -1.0, -9.0, 1.0, 1.0));
	blockC[0].e[0] = (uvec2(5u, 6u));
	blockD.f = (vec3(9.0, -7.0, -1.0));
}
#version 450
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
	mediump uvec2 a;
	lowp ivec4 b;
	bool c;
	highp mat3x4 d[];
};
layout(std430, buffer_reference) buffer BlockC
{
	bool e;
	highp uvec4 f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a), uvec2(3u, 0u)) && allOk;
	allOk = compare_ivec4((blockB.b), ivec4(-6, -3, -1, -9)) && allOk;
	allOk = compare_bool((blockB.c), false) && allOk;
	allOk = compare_mat3x4(blockB.d[0], mat3x4(-7.0, -9.0, 8.0, -4.0, -8.0, 8.0, -8.0, -6.0, -2.0, 9.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat3x4(blockB.d[1], mat3x4(1.0, 1.0, 7.0, -1.0, 9.0, -5.0, 8.0, 4.0, -9.0, 8.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3x4(blockB.d[2], mat3x4(2.0, -5.0, 9.0, 3.0, -5.0, -3.0, 0.0, -2.0, -4.0, 4.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat3x4(blockB.d[3], mat3x4(5.0, -2.0, 4.0, -4.0, 8.0, -5.0, -4.0, -6.0, -3.0, 0.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat3x4(blockB.d[4], mat3x4(8.0, -5.0, 8.0, -4.0, -9.0, 6.0, 6.0, 8.0, -1.0, 2.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat3x4(blockB.d[5], mat3x4(6.0, 7.0, -7.0, 0.0, -3.0, 7.0, 5.0, -5.0, 4.0, -8.0, -1.0, 2.0)) && allOk;
	allOk = compare_uvec4((blockC.f[0]), uvec4(2u, 2u, 2u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (ivec4(5, 5, -3, -5));
	blockB.c = (true);
	blockB.d[0] = (mat3x4(-9.0, 2.0, 6.0, 1.0, 9.0, -5.0, 9.0, -3.0, 6.0, 7.0, -9.0, -6.0));
	blockB.d[1] = (mat3x4(-1.0, 3.0, 5.0, 3.0, 9.0, 8.0, -4.0, -8.0, -5.0, -1.0, 2.0, 0.0));
	blockB.d[2] = (mat3x4(5.0, 3.0, -3.0, 2.0, 4.0, 4.0, -6.0, 4.0, -5.0, -2.0, -4.0, -5.0));
	blockB.d[3] = (mat3x4(7.0, 6.0, -9.0, 0.0, -7.0, 2.0, 1.0, 9.0, 2.0, -9.0, -2.0, -7.0));
	blockB.d[4] = (mat3x4(8.0, 8.0, 8.0, 7.0, 9.0, -6.0, -3.0, -1.0, 3.0, 7.0, -2.0, -7.0));
	blockB.d[5] = (mat3x4(-7.0, -5.0, 3.0, 8.0, 6.0, -1.0, -8.0, -7.0, 3.0, 8.0, 1.0, 4.0));
	blockC.e = (false);
	blockC.f[0] = (uvec4(6u, 2u, 7u, 0u));
}
#version 450
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
	u8vec2 a;
	highp uvec4 b;
	int8_t c[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	mediump uvec3 d;
	highp ivec2 e;
	i8vec3 f;
	highp mat4x2 g;
	u8vec2 h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(blockB.a), uvec2(8u, 5u)) && allOk;
	allOk = compare_uvec4((blockB.b), uvec4(4u, 9u, 3u, 7u)) && allOk;
	allOk = compare_ivec2((blockC.e), ivec2(-6, 9)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.f), ivec3(8, 3, 7)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.h[0]), uvec2(4u, 6u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.h[1]), uvec2(8u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.h[2]), uvec2(1u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.h[3]), uvec2(9u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u8vec2(uvec2(8u, 5u));
	blockB.b = (uvec4(4u, 8u, 5u, 6u));
	blockB.c[0] = int8_t(4294967289);
	blockB.c[1] = int8_t(4294967290);
	blockB.c[2] = int8_t(4294967291);
	blockB.c[3] = int8_t(4294967287);
	blockC.d = (uvec3(6u, 6u, 2u));
	blockC.e = (ivec2(6, 4));
	blockC.f = i8vec3(ivec3(6, 4294967291, 2));
	blockC.g = (mat4x2(-9.0, -6.0, -8.0, 5.0, 3.0, 6.0, 6.0, -6.0));
}
#version 450
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
	bvec3 a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.a), bvec3(true, false, false)) && allOk;
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

layout(std140, buffer_reference) buffer BlockB
{
	lowp uvec2 a;
	highp uvec3 b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.b), uvec3(3u, 7u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (uvec3(8u, 3u, 2u));
}
#version 450
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
	bvec3 a;
	mediump vec4 b;
	u8vec3 c[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	mediump int d;
	i8vec2 e[5];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	mediump vec4 f;
	mediump vec4 g;
	highp float h;
	mediump uvec4 i[];
};
layout(std140, buffer_reference) buffer BlockE
{
	u8vec4 j[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[2];
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(blockB.c[0]), uvec3(3u, 3u, 4u)) && allOk;
	allOk = compare_int((blockC.d), -1) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.e[0]), ivec2(4294967291, 4294967291)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.e[1]), ivec2(4, 4294967288)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.e[2]), ivec2(4294967293, 4294967291)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.e[3]), ivec2(7, 4294967288)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.e[4]), ivec2(0, 5)) && allOk;
	allOk = compare_vec4((blockD[0].f), vec4(4.0, -3.0, 7.0, 6.0)) && allOk;
	allOk = compare_vec4((blockD[0].g), vec4(-5.0, -9.0, 9.0, -7.0)) && allOk;
	allOk = compare_float((blockD[0].h), -7.0) && allOk;
	allOk = compare_vec4((blockD[1].f), vec4(5.0, 9.0, -4.0, -5.0)) && allOk;
	allOk = compare_vec4((blockD[1].g), vec4(7.0, -5.0, 1.0, -5.0)) && allOk;
	allOk = compare_float((blockD[1].h), 4.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec3(true, false, true));
	blockC.d = (7);
	blockD[0].f = (vec4(7.0, 9.0, -3.0, 7.0));
	blockD[0].g = (vec4(7.0, -9.0, 8.0, 5.0));
	blockD[0].h = (9.0);
	blockD[0].i[0] = (uvec4(8u, 4u, 8u, 5u));
	blockD[1].f = (vec4(-6.0, 2.0, 3.0, -1.0));
	blockD[1].g = (vec4(-3.0, -1.0, 7.0, -8.0));
	blockD[1].h = (4.0);
	blockD[1].i[0] = (uvec4(7u, 9u, 1u, 6u));
	blockD[1].i[1] = (uvec4(4u, 9u, 3u, 4u));
	blockD[1].i[2] = (uvec4(5u, 0u, 9u, 5u));
	blockE.j[0] = u8vec4(uvec4(0u, 0u, 9u, 2u));
	blockE.j[1] = u8vec4(uvec4(2u, 0u, 4u, 7u));
}
#version 450
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
	layout(offset = 0) bvec2 a;
	layout(offset = 8) int8_t b;
};
layout(buffer_reference) readonly buffer BlockC
{
	layout(offset = 0) i8vec2 c;
	layout(offset = 4) lowp float d;
	layout(offset = 16) mediump ivec4 e;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) int8_t f;
	layout(offset = 4) lowp ivec3 g;
	layout(offset = 16) u8vec2 h;
	layout(offset = 18) int8_t i;
	layout(offset = 19) i8vec2 j;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) u8vec2 k;
	layout(offset = 4) bvec2 l;
	layout(offset = 16) lowp ivec3 m;
	layout(offset = 28) lowp int n;
	layout(offset = 32) mediump uvec3 o;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB[0].a), bvec2(true, false)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.c), ivec2(4, 4294967289)) && allOk;
	allOk = compare_float((blockC.d), -1.0) && allOk;
	allOk = compare_ivec4((blockC.e), ivec4(-2, 2, -9, -1)) && allOk;
	allOk = compare_int8_t(int(blockD.f), 4294967292) && allOk;
	allOk = compare_ivec3((blockD.g), ivec3(-8, 7, -8)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD.h), uvec2(8u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockE.k), uvec2(0u, 9u)) && allOk;
	allOk = compare_bvec2((blockE.l), bvec2(true, true)) && allOk;
	allOk = compare_ivec3((blockE.m), ivec3(1, 6, 2)) && allOk;
	allOk = compare_int((blockE.n), 3) && allOk;
	allOk = compare_uvec3((blockE.o), uvec3(7u, 0u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (bvec2(true, true));
	blockB[0].b = int8_t(4294967287);
	blockD.f = int8_t(6);
	blockD.h = u8vec2(uvec2(1u, 6u));
	blockD.i = int8_t(4294967294);
	blockD.j = i8vec2(ivec2(4294967293, 4294967291));
	blockE.k = u8vec2(uvec2(0u, 1u));
	blockE.l = (bvec2(true, false));
	blockE.m = (ivec3(-2, 3, -8));
	blockE.o = (uvec3(6u, 4u, 0u));
}
#version 450
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
	layout(offset = 0) i8vec3 a;
	layout(offset = 3) u8vec3 b;
	layout(offset = 16) mediump ivec4 c;
	layout(offset = 32) lowp uint d[1];
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) u8vec3 e;
	layout(offset = 3) u8vec2 f;
	layout(offset = 8) bvec2 g;
	layout(offset = 16) i8vec3 h;
	layout(offset = 32) mediump vec4 i;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(blockB[0].a), ivec3(4294967289, 4294967295, 4294967289)) && allOk;
	allOk = compare_ivec4((blockB[0].c), ivec4(-3, 6, -7, -5)) && allOk;
	allOk = compare_uint((blockB[0].d[0]), 1u) && allOk;
	allOk = compare_i8vec3(ivec3(blockB[1].a), ivec3(4294967291, 4294967295, 5)) && allOk;
	allOk = compare_ivec4((blockB[1].c), ivec4(-1, 3, 0, -6)) && allOk;
	allOk = compare_uint((blockB[1].d[0]), 5u) && allOk;
	allOk = compare_i8vec3(ivec3(blockB[2].a), ivec3(4294967288, 1, 2)) && allOk;
	allOk = compare_ivec4((blockB[2].c), ivec4(-6, -5, 1, 7)) && allOk;
	allOk = compare_uint((blockB[2].d[0]), 8u) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.e), uvec3(6u, 3u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.f), uvec2(2u, 4u)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.h), ivec3(7, 9, 3)) && allOk;
	allOk = compare_vec4((blockC.i), vec4(-2.0, 0.0, 6.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = i8vec3(ivec3(4294967293, 7, 8));
	blockB[0].b = u8vec3(uvec3(4u, 1u, 8u));
	blockB[0].d[0] = (7u);
	blockB[1].a = i8vec3(ivec3(4294967292, 7, 8));
	blockB[1].b = u8vec3(uvec3(1u, 5u, 0u));
	blockB[1].d[0] = (1u);
	blockB[2].a = i8vec3(ivec3(4294967287, 6, 7));
	blockB[2].b = u8vec3(uvec3(4u, 2u, 3u));
	blockB[2].d[0] = (1u);
	blockC.e = u8vec3(uvec3(4u, 5u, 1u));
	blockC.g = (bvec2(true, false));
}
#version 450
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
	mediump vec2 mA;
	mediump ivec3 mB;
	mediump mat3 mC;
};
struct sB
{
	highp float mA;
};
layout(scalar, row_major, buffer_reference) buffer BlockB
{
	highp mat4 a;
	sA b;
	highp int c;
	sB d;
	highp ivec3 e[];
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	lowp mat4 f;
	mediump float g;
	uint8_t h;
	mediump mat4 i;
	bvec4 j[];
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	bvec3 k;
	lowp mat4x2 l;
	i8vec4 m;
	lowp uvec4 n[][8];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
    BlockD blockD[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.b.mA), vec2(9.0, 6.0)) && allOk;
	allOk = compare_ivec3((blockB.b.mB), ivec3(-4, -9, -2)) && allOk;
	allOk = compare_mat3(blockB.b.mC, mat3(2.0, -1.0, -4.0, -8.0, 3.0, 0.0, 4.0, 5.0, 4.0)) && allOk;
	allOk = compare_int((blockB.c), 0) && allOk;
	allOk = compare_float((blockB.d.mA), -1.0) && allOk;
	allOk = compare_ivec3((blockB.e[0]), ivec3(-4, 2, 0)) && allOk;
	allOk = compare_ivec3((blockB.e[1]), ivec3(4, -5, -1)) && allOk;
	allOk = compare_ivec3((blockB.e[2]), ivec3(0, 6, -3)) && allOk;
	allOk = compare_ivec3((blockB.e[3]), ivec3(-2, 4, 1)) && allOk;
	allOk = compare_mat4(blockC[0].f, mat4(9.0, -2.0, 8.0, -4.0, 9.0, -6.0, -5.0, -5.0, -6.0, 4.0, -7.0, 3.0, -2.0, -8.0, 4.0, 4.0)) && allOk;
	allOk = compare_float((blockC[0].g), 4.0) && allOk;
	allOk = compare_mat4(blockC[0].i, mat4(-9.0, 8.0, 3.0, 7.0, -1.0, 8.0, 1.0, 9.0, -8.0, -9.0, 4.0, -4.0, 8.0, 4.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat4(blockC[1].f, mat4(0.0, 0.0, 4.0, -5.0, -8.0, 4.0, 5.0, 7.0, 4.0, 6.0, -2.0, -6.0, 4.0, 6.0, 6.0, 1.0)) && allOk;
	allOk = compare_float((blockC[1].g), -7.0) && allOk;
	allOk = compare_mat4(blockC[1].i, mat4(8.0, 7.0, 9.0, -4.0, 8.0, 1.0, 7.0, 9.0, 6.0, -3.0, -2.0, -1.0, -9.0, -4.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat4(blockC[2].f, mat4(-4.0, -5.0, 3.0, 0.0, 9.0, -6.0, 4.0, 4.0, 5.0, 6.0, -5.0, 8.0, -7.0, -5.0, 7.0, -7.0)) && allOk;
	allOk = compare_float((blockC[2].g), 8.0) && allOk;
	allOk = compare_mat4(blockC[2].i, mat4(-7.0, 4.0, 6.0, 6.0, -9.0, -3.0, 9.0, 2.0, 5.0, -9.0, -4.0, -6.0, 5.0, -8.0, -7.0, -2.0)) && allOk;
	allOk = compare_bvec3((blockD[0].k), bvec3(false, true, false)) && allOk;
	allOk = compare_mat4x2(blockD[0].l, mat4x2(7.0, -3.0, -5.0, -4.0, -7.0, 2.0, -7.0, -6.0)) && allOk;
	allOk = compare_uvec4((blockD[0].n[0][0]), uvec4(3u, 4u, 3u, 6u)) && allOk;
	allOk = compare_uvec4((blockD[0].n[0][1]), uvec4(4u, 0u, 5u, 9u)) && allOk;
	allOk = compare_uvec4((blockD[0].n[0][2]), uvec4(8u, 0u, 6u, 9u)) && allOk;
	allOk = compare_uvec4((blockD[0].n[0][3]), uvec4(7u, 0u, 3u, 9u)) && allOk;
	allOk = compare_uvec4((blockD[0].n[0][4]), uvec4(7u, 1u, 1u, 2u)) && allOk;
	allOk = compare_uvec4((blockD[0].n[0][5]), uvec4(1u, 8u, 9u, 9u)) && allOk;
	allOk = compare_uvec4((blockD[0].n[0][6]), uvec4(0u, 7u, 1u, 1u)) && allOk;
	allOk = compare_uvec4((blockD[0].n[0][7]), uvec4(5u, 7u, 5u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4(3.0, -7.0, 3.0, -2.0, -9.0, -8.0, 5.0, 3.0, 1.0, 2.0, -2.0, 1.0, -1.0, 1.0, 1.0, -2.0));
	blockB.b.mA = (vec2(3.0, -4.0));
	blockB.b.mB = (ivec3(1, -1, 3));
	blockB.b.mC = (mat3(2.0, -8.0, -5.0, -3.0, 9.0, 1.0, -8.0, 2.0, 6.0));
	blockB.c = (9);
	blockB.e[0] = (ivec3(8, -3, -8));
	blockB.e[1] = (ivec3(4, 6, -8));
	blockB.e[2] = (ivec3(1, 0, -5));
	blockB.e[3] = (ivec3(-3, -9, 4));
	blockC[0].g = (-1.0);
	blockC[0].h = uint8_t(4u);
	blockC[0].j[0] = (bvec4(true, true, false, true));
	blockC[0].j[1] = (bvec4(true, false, false, true));
	blockC[0].j[2] = (bvec4(false, false, true, false));
	blockC[1].g = (-5.0);
	blockC[1].h = uint8_t(5u);
	blockC[1].j[0] = (bvec4(false, true, false, false));
	blockC[1].j[1] = (bvec4(true, true, false, false));
	blockC[1].j[2] = (bvec4(false, false, false, false));
	blockC[1].j[3] = (bvec4(true, false, true, true));
	blockC[1].j[4] = (bvec4(true, true, false, false));
	blockC[1].j[5] = (bvec4(false, true, false, false));
	blockC[2].g = (-1.0);
	blockC[2].h = uint8_t(3u);
	blockC[2].j[0] = (bvec4(false, true, false, true));
	blockC[2].j[1] = (bvec4(false, false, true, false));
	blockC[2].j[2] = (bvec4(true, true, true, false));
	blockC[2].j[3] = (bvec4(true, false, false, true));
	blockC[2].j[4] = (bvec4(false, false, false, true));
	blockC[2].j[5] = (bvec4(false, true, true, false));
	blockC[2].j[6] = (bvec4(true, true, true, true));
	blockC[2].j[7] = (bvec4(true, true, true, true));
	blockD[0].k = (bvec3(true, true, true));
	blockD[0].l = (mat4x2(4.0, -6.0, 6.0, 4.0, -8.0, 7.0, -7.0, -2.0));
	blockD[0].m = i8vec4(ivec4(5, 5, 3, 7));
	blockD[0].n[0][0] = (uvec4(0u, 0u, 7u, 7u));
	blockD[0].n[0][1] = (uvec4(7u, 1u, 4u, 2u));
	blockD[0].n[0][2] = (uvec4(2u, 9u, 5u, 2u));
	blockD[0].n[0][3] = (uvec4(4u, 8u, 2u, 4u));
	blockD[0].n[0][4] = (uvec4(0u, 5u, 9u, 2u));
	blockD[0].n[0][5] = (uvec4(9u, 4u, 3u, 5u));
	blockD[0].n[0][6] = (uvec4(3u, 2u, 3u, 4u));
	blockD[0].n[0][7] = (uvec4(8u, 8u, 9u, 4u));
}
#version 450
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
	highp uint a;
	i8vec2 b;
	lowp vec2 c;
	uint8_t d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB[nonuniformEXT(0)].a), 9u) && allOk;
	allOk = compare_i8vec2(ivec2(blockB[nonuniformEXT(0)].b), ivec2(4294967288, 4294967292)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(0)].c), vec2(7.0, 4.0)) && allOk;
	allOk = compare_uint8_t(uint(blockB[nonuniformEXT(0)].d), 0u) && allOk;
	allOk = compare_uint((blockB[nonuniformEXT(1)].a), 6u) && allOk;
	allOk = compare_i8vec2(ivec2(blockB[nonuniformEXT(1)].b), ivec2(4294967288, 4294967290)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(1)].c), vec2(4.0, 5.0)) && allOk;
	allOk = compare_uint8_t(uint(blockB[nonuniformEXT(1)].d), 4u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (9u);
	blockB[nonuniformEXT(0)].b = i8vec2(ivec2(4294967294, 4294967295));
	blockB[nonuniformEXT(0)].c = (vec2(-6.0, 6.0));
	blockB[nonuniformEXT(0)].d = uint8_t(5u);
	blockB[nonuniformEXT(1)].a = (3u);
	blockB[nonuniformEXT(1)].b = i8vec2(ivec2(5, 4));
	blockB[nonuniformEXT(1)].c = (vec2(8.0, 6.0));
	blockB[nonuniformEXT(1)].d = uint8_t(5u);
}
