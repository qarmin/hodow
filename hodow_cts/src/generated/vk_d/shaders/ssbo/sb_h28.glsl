#version 450
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
	allOk = compare_mat4(var, mat4(7.0, -6.0, 3.0, 6.0, 7.0, -2.0, -2.0, 0.0, 5.0, -3.0, -7.0, -1.0, 9.0, 7.0, -8.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(-2.0, 5.0, 7.0, -2.0));
	var[1] = (vec4(-7.0, -4.0, 0.0, 8.0));
	var[2] = (vec4(-8.0, 9.0, 5.0, 8.0));
	var[3] = (vec4(0.0, 8.0, -5.0, 4.0));
}
#version 450
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
	highp uvec2 var;
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((var), uvec2(2u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (uvec2(2u, 7u));
}
#version 450
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

layout(std430, binding = 1) buffer Block
{
	lowp mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var, mat3x4(-7.0, -5.0, -3.0, 4.0, 0.0, 4.0, -6.0, 9.0, 3.0, 2.0, 0.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3x4(2.0, 6.0, -2.0, -9.0, -5.0, 6.0, -9.0, -5.0, 5.0, -4.0, 9.0, -7.0));
}
#version 450
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

	var = (mat4x3(-9.0, -4.0, -9.0, -4.0, 5.0, -3.0, -8.0, 5.0, -3.0, -8.0, 2.0, -9.0));
}
#version 450
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
	mediump ivec3 var;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((padding), -9) && allOk;
	allOk = compare_ivec3((var), ivec3(4, -3, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-7);
	var = (ivec3(5, -6, 2));
}
#version 450
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
	allOk = compare_float((padding), 9.0) && allOk;
	allOk = compare_float(var[0][0], -8.0) && allOk;
	allOk = compare_float(var[0][1], -6.0) && allOk;
	allOk = compare_float(var[0][2], 1.0) && allOk;
	allOk = compare_float(var[0][3], -9.0) && allOk;
	allOk = compare_float(var[1][0], -1.0) && allOk;
	allOk = compare_float(var[1][1], -1.0) && allOk;
	allOk = compare_float(var[1][2], 4.0) && allOk;
	allOk = compare_float(var[1][3], -1.0) && allOk;
	allOk = compare_float(var[2][0], 8.0) && allOk;
	allOk = compare_float(var[2][1], 6.0) && allOk;
	allOk = compare_float(var[2][2], -6.0) && allOk;
	allOk = compare_float(var[2][3], 3.0) && allOk;
	allOk = compare_float(var[3][0], 5.0) && allOk;
	allOk = compare_float(var[3][1], -9.0) && allOk;
	allOk = compare_float(var[3][2], -5.0) && allOk;
	allOk = compare_float(var[3][3], 1.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-8.0, -6.0, 1.0, -9.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-1.0, -1.0, 4.0, -1.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(8.0, 6.0, -6.0, 3.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(5.0, -9.0, -5.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (0.0);
	var = (mat4(6.0, 6.0, 6.0, 1.0, -1.0, 2.0, 3.0, 8.0, 3.0, 1.0, 2.0, -2.0, 9.0, -7.0, 3.0, 1.0));
}
#version 450
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
	lowp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_mat2x3(var, mat2x3(0.0, 4.0, -7.0, -8.0, -6.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-3.0);
	var = (mat2x3(-5.0, -2.0, -1.0, -6.0, 1.0, -4.0));
}
#version 450
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
	highp ivec2 var[3];
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((var[0]), ivec2(6, -1)) && allOk;
	allOk = compare_ivec2((var[1]), ivec2(7, -5)) && allOk;
	allOk = compare_ivec2((var[2]), ivec2(-8, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (ivec2(-6, 8));
	var[1] = (ivec2(3, -1));
	var[2] = (ivec2(-5, -2));
}
#version 450
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
	highp uint var[3];
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((var[0]), 3u) && allOk;
	allOk = compare_uint((var[1]), 6u) && allOk;
	allOk = compare_uint((var[2]), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (7u);
	var[1] = (9u);
	var[2] = (1u);
}
#version 450
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
	allOk = compare_mat3(var[0], mat3(2.0, 0.0, -4.0, -3.0, 4.0, 5.0, -1.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(-1.0, 4.0, -4.0, -3.0, 0.0, -1.0, -5.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(2.0, 4.0, -3.0, 8.0, 3.0, -2.0, -1.0, 8.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec3(3.0, -9.0, 3.0));
	var[0][1] = (vec3(2.0, 4.0, 6.0));
	var[0][2] = (vec3(2.0, -9.0, 0.0));
	var[1][0] = (vec3(-7.0, 3.0, -3.0));
	var[1][1] = (vec3(-4.0, -4.0, 5.0));
	var[1][2] = (vec3(-4.0, 1.0, -7.0));
	var[2][0] = (vec3(7.0, 9.0, -7.0));
	var[2][1] = (vec3(8.0, 2.0, 5.0));
	var[2][2] = (vec3(-9.0, 7.0, -2.0));
}
#version 450
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

	var[0][0] = (vec3(-1.0, 1.0, 4.0));
	var[0][1] = (vec3(6.0, -5.0, -5.0));
	var[0][2] = (vec3(9.0, -6.0, 5.0));
	var[1][0] = (vec3(7.0, 7.0, -2.0));
	var[1][1] = (vec3(-4.0, 1.0, -5.0));
	var[1][2] = (vec3(8.0, -1.0, -8.0));
	var[2][0] = (vec3(-6.0, -4.0, 5.0));
	var[2][1] = (vec3(3.0, 9.0, -8.0));
	var[2][2] = (vec3(-4.0, 8.0, 0.0));
}
#version 450
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

	var[0] = (mat2x4(-2.0, 3.0, 2.0, -4.0, 2.0, -2.0, 9.0, -4.0));
	var[1] = (mat2x4(0.0, 7.0, 4.0, -8.0, 6.0, 0.0, -1.0, -8.0));
	var[2] = (mat2x4(2.0, 8.0, 2.0, 4.0, 5.0, 4.0, -3.0, 4.0));
}
#version 450
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
	highp mat4x2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0], mat4x2(4.0, -5.0, -2.0, 7.0, 3.0, 2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(-7.0, -1.0, -9.0, 4.0, -9.0, -4.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(-7.0, -7.0, 4.0, 6.0, 6.0, -6.0, -1.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec2(2.0, -4.0));
	var[0][1] = (vec2(-5.0, 3.0));
	var[0][2] = (vec2(7.0, 1.0));
	var[0][3] = (vec2(8.0, -5.0));
	var[1][0] = (vec2(7.0, -3.0));
	var[1][1] = (vec2(1.0, -6.0));
	var[1][2] = (vec2(9.0, -3.0));
	var[1][3] = (vec2(1.0, -5.0));
	var[2][0] = (vec2(-8.0, 4.0));
	var[2][1] = (vec2(5.0, -9.0));
	var[2][2] = (vec2(1.0, -5.0));
	var[2][3] = (vec2(-4.0, -2.0));
}
#version 450
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
	i16vec2 var[3];
};

bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(var[0]), ivec2(3, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(var[1]), ivec2(8, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(var[2]), ivec2(-4, 2)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = i16vec2(ivec2(6, -2));
	var[1] = i16vec2(ivec2(-2, -8));
	var[2] = i16vec2(ivec2(3, 5));
}
#version 450
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
	highp mat3x2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 0.0) && allOk;
	allOk = compare_mat3x2(var[0], mat3x2(5.0, 2.0, -5.0, 9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(-9.0, 0.0, -5.0, 3.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(-2.0, 6.0, -3.0, -4.0, -9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-2.0);
	var[0][0] = (vec2(1.0, 8.0));
	var[0][1] = (vec2(-7.0, 5.0));
	var[0][2] = (vec2(8.0, 2.0));
	var[1][0] = (vec2(-3.0, 1.0));
	var[1][1] = (vec2(2.0, -5.0));
	var[1][2] = (vec2(0.0, 6.0));
	var[2][0] = (vec2(6.0, 5.0));
	var[2][1] = (vec2(-5.0, 9.0));
	var[2][2] = (vec2(3.0, -8.0));
}
#version 450
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
	highp mat4 var[];
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
	allOk = compare_mat4(var[3], mat4(-9.0, -1.0, -9.0, 8.0, 9.0, -9.0, -7.0, -2.0, 3.0, -9.0, -3.0, -9.0, 4.0, -4.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat4(var[4], mat4(-2.0, 7.0, -4.0, -4.0, 1.0, 2.0, -1.0, -3.0, 8.0, 1.0, -3.0, -1.0, -4.0, -6.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat4(var[5], mat4(-9.0, 9.0, 8.0, 7.0, 8.0, -2.0, -2.0, -5.0, -9.0, -8.0, -9.0, -4.0, -9.0, 6.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4(var[6], mat4(1.0, 8.0, -3.0, -5.0, -4.0, -9.0, -2.0, -6.0, -3.0, -9.0, -9.0, -7.0, 7.0, -9.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4(var[7], mat4(4.0, -6.0, -4.0, 8.0, 0.0, -1.0, 3.0, -5.0, 6.0, -8.0, 9.0, 7.0, 3.0, 0.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4(var[8], mat4(9.0, -9.0, 9.0, 2.0, -2.0, -2.0, 3.0, -9.0, 4.0, -1.0, -1.0, -7.0, -4.0, 0.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4(var[9], mat4(6.0, 1.0, 6.0, 5.0, 7.0, -7.0, -8.0, 7.0, -2.0, -3.0, 4.0, 3.0, 2.0, -8.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4(var[10], mat4(-3.0, 2.0, -4.0, 7.0, -4.0, 1.0, -9.0, 8.0, 4.0, -8.0, 5.0, 3.0, 7.0, 5.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4(var[11], mat4(-1.0, -3.0, -3.0, -4.0, -9.0, 8.0, 9.0, 0.0, 4.0, 6.0, -9.0, -8.0, 5.0, 3.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4(var[12], mat4(9.0, -6.0, 0.0, -6.0, -4.0, 0.0, 7.0, 0.0, 7.0, 0.0, 8.0, 2.0, -6.0, -3.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4(var[13], mat4(9.0, -2.0, 1.0, -9.0, -6.0, -1.0, -4.0, 6.0, 8.0, -7.0, 1.0, 3.0, -9.0, 5.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4(var[14], mat4(-2.0, 4.0, 5.0, 9.0, 0.0, 0.0, 9.0, 3.0, -9.0, -4.0, 5.0, -2.0, 7.0, 9.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[15], mat4(9.0, 0.0, -2.0, -7.0, -8.0, 0.0, 3.0, -1.0, -9.0, 1.0, 9.0, -1.0, 5.0, -9.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat4(var[16], mat4(4.0, -5.0, -9.0, 5.0, 4.0, 7.0, 0.0, -6.0, -5.0, -9.0, 6.0, 9.0, 4.0, 6.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4(var[17], mat4(2.0, 5.0, 9.0, -6.0, 4.0, 6.0, -4.0, 1.0, 6.0, 1.0, 3.0, 4.0, 3.0, 8.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat4(var[18], mat4(-2.0, -4.0, 3.0, -3.0, 5.0, 1.0, -7.0, 8.0, 7.0, -9.0, -3.0, 7.0, 9.0, -9.0, -5.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4(6.0, -8.0, 2.0, -8.0, 1.0, -5.0, -7.0, -8.0, -9.0, 3.0, -9.0, -1.0, 7.0, -6.0, -5.0, 2.0));
	var[1] = (mat4(4.0, 3.0, -5.0, 6.0, 5.0, -1.0, -1.0, 7.0, -1.0, 5.0, -8.0, -3.0, 2.0, -6.0, -9.0, -5.0));
	var[2] = (mat4(1.0, -5.0, -9.0, 9.0, -7.0, -1.0, 6.0, -6.0, 6.0, -9.0, -8.0, -3.0, -3.0, 4.0, -5.0, -1.0));
	var[3] = (mat4(-3.0, -9.0, -6.0, 5.0, 0.0, 6.0, -5.0, -7.0, -6.0, -5.0, 8.0, -6.0, -2.0, -8.0, -4.0, -8.0));
	var[4] = (mat4(1.0, 5.0, 6.0, -2.0, -7.0, -3.0, -4.0, 6.0, -8.0, -5.0, 2.0, 8.0, 4.0, 3.0, 6.0, -6.0));
	var[5] = (mat4(-7.0, 5.0, 7.0, -7.0, -6.0, 6.0, -2.0, 5.0, 1.0, -3.0, -2.0, 4.0, 6.0, -6.0, -5.0, -5.0));
	var[6] = (mat4(6.0, -8.0, -5.0, -4.0, 5.0, -3.0, 4.0, 6.0, 2.0, -2.0, -7.0, 5.0, -9.0, -3.0, 9.0, 5.0));
	var[7] = (mat4(6.0, 9.0, 2.0, 1.0, -6.0, -8.0, 8.0, -2.0, 1.0, 6.0, -5.0, 5.0, -7.0, -8.0, 9.0, 3.0));
	var[8] = (mat4(6.0, -6.0, -4.0, 0.0, 8.0, -9.0, -6.0, 2.0, 6.0, 7.0, 5.0, 9.0, -6.0, -9.0, -5.0, 5.0));
	var[9] = (mat4(-5.0, 3.0, 0.0, -2.0, -1.0, -6.0, -7.0, 9.0, -9.0, 8.0, 2.0, -7.0, -7.0, 9.0, 8.0, 7.0));
	var[10] = (mat4(-9.0, 5.0, -4.0, -4.0, 9.0, -1.0, 3.0, -1.0, 7.0, 2.0, 8.0, -2.0, 2.0, -3.0, 0.0, -9.0));
	var[11] = (mat4(5.0, -1.0, 6.0, 9.0, 1.0, -7.0, -5.0, -3.0, 4.0, 8.0, -9.0, -2.0, -2.0, -1.0, -1.0, 0.0));
	var[12] = (mat4(-4.0, -9.0, -7.0, -9.0, -9.0, -3.0, -8.0, 0.0, -1.0, -4.0, -1.0, -8.0, 5.0, -8.0, -3.0, 1.0));
	var[13] = (mat4(-1.0, -6.0, -1.0, 0.0, -8.0, 6.0, 6.0, -5.0, -6.0, 9.0, 2.0, 6.0, 6.0, -5.0, -7.0, 0.0));
	var[14] = (mat4(2.0, 6.0, 3.0, 6.0, 1.0, -3.0, -6.0, 0.0, -2.0, 0.0, -9.0, 1.0, 6.0, 9.0, -9.0, 0.0));
	var[15] = (mat4(-9.0, 4.0, 1.0, 5.0, 0.0, 9.0, 3.0, -2.0, -8.0, 9.0, -9.0, 2.0, -8.0, 0.0, 7.0, 7.0));
	var[16] = (mat4(6.0, -5.0, 5.0, 3.0, -2.0, -8.0, 6.0, 2.0, 7.0, -1.0, -2.0, 8.0, -9.0, 1.0, -4.0, 1.0));
	var[17] = (mat4(-5.0, -8.0, 1.0, 9.0, -7.0, -4.0, 0.0, -3.0, 6.0, 2.0, 2.0, -2.0, -8.0, 4.0, 1.0, 7.0));
	var[18] = (mat4(4.0, -5.0, 2.0, -2.0, -1.0, 1.0, 4.0, 0.0, -1.0, -4.0, -1.0, 2.0, -4.0, 7.0, -7.0, -7.0));
}
#version 450
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
	highp mat4x2 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0], mat4x2(-2.0, 6.0, 5.0, 7.0, 1.0, -5.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(4.0, -5.0, -7.0, -4.0, 7.0, 7.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(-1.0, 7.0, -9.0, -7.0, -1.0, 8.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[3], mat4x2(-4.0, 7.0, -5.0, -3.0, 4.0, 7.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[4], mat4x2(9.0, -5.0, 9.0, 2.0, -1.0, -1.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[5], mat4x2(-6.0, -7.0, 4.0, 4.0, 9.0, -9.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[6], mat4x2(-1.0, -8.0, 5.0, -8.0, 2.0, 3.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[7], mat4x2(0.0, 4.0, -8.0, -3.0, -1.0, 4.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[8], mat4x2(4.0, 5.0, -7.0, 1.0, 0.0, -9.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[9], mat4x2(-2.0, 4.0, -8.0, 5.0, -3.0, 8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[10], mat4x2(5.0, -9.0, 5.0, -2.0, -8.0, -1.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[11], mat4x2(3.0, 5.0, 1.0, 5.0, -3.0, -4.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[12], mat4x2(-1.0, 3.0, -9.0, 4.0, -2.0, 2.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[13], mat4x2(-3.0, 7.0, -5.0, 3.0, 2.0, -1.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[14], mat4x2(6.0, 9.0, -5.0, 0.0, 7.0, 6.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[15], mat4x2(-7.0, -3.0, -5.0, 2.0, 3.0, -3.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[16], mat4x2(5.0, -7.0, -9.0, 8.0, 8.0, -7.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[17], mat4x2(-6.0, 8.0, -1.0, 0.0, 6.0, -2.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[18], mat4x2(-4.0, 1.0, -2.0, 4.0, 1.0, -8.0, 8.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec2(6.0, 9.0));
	var[0][1] = (vec2(-4.0, -4.0));
	var[0][2] = (vec2(2.0, 0.0));
	var[0][3] = (vec2(-7.0, 3.0));
	var[1][0] = (vec2(9.0, -6.0));
	var[1][1] = (vec2(8.0, -9.0));
	var[1][2] = (vec2(-9.0, -6.0));
	var[1][3] = (vec2(-4.0, -6.0));
	var[2][0] = (vec2(-8.0, 5.0));
	var[2][1] = (vec2(6.0, -8.0));
	var[2][2] = (vec2(-8.0, 3.0));
	var[2][3] = (vec2(2.0, 8.0));
	var[3][0] = (vec2(-8.0, -1.0));
	var[3][1] = (vec2(-3.0, 0.0));
	var[3][2] = (vec2(7.0, 5.0));
	var[3][3] = (vec2(-8.0, 5.0));
	var[4][0] = (vec2(7.0, 8.0));
	var[4][1] = (vec2(4.0, -2.0));
	var[4][2] = (vec2(4.0, -2.0));
	var[4][3] = (vec2(-2.0, 9.0));
	var[5][0] = (vec2(4.0, -4.0));
	var[5][1] = (vec2(-5.0, -5.0));
	var[5][2] = (vec2(-6.0, 8.0));
	var[5][3] = (vec2(9.0, -5.0));
	var[6][0] = (vec2(-2.0, 1.0));
	var[6][1] = (vec2(6.0, -2.0));
	var[6][2] = (vec2(2.0, -5.0));
	var[6][3] = (vec2(3.0, -3.0));
	var[7][0] = (vec2(-6.0, -4.0));
	var[7][1] = (vec2(-6.0, -7.0));
	var[7][2] = (vec2(9.0, 1.0));
	var[7][3] = (vec2(-4.0, 3.0));
	var[8][0] = (vec2(7.0, -9.0));
	var[8][1] = (vec2(7.0, -4.0));
	var[8][2] = (vec2(8.0, -2.0));
	var[8][3] = (vec2(9.0, 0.0));
	var[9][0] = (vec2(-9.0, 7.0));
	var[9][1] = (vec2(1.0, 4.0));
	var[9][2] = (vec2(-7.0, 9.0));
	var[9][3] = (vec2(-5.0, 2.0));
	var[10][0] = (vec2(-9.0, -3.0));
	var[10][1] = (vec2(-8.0, 5.0));
	var[10][2] = (vec2(-2.0, -8.0));
	var[10][3] = (vec2(7.0, -6.0));
	var[11][0] = (vec2(-7.0, 1.0));
	var[11][1] = (vec2(-3.0, 7.0));
	var[11][2] = (vec2(6.0, -5.0));
	var[11][3] = (vec2(9.0, -2.0));
	var[12][0] = (vec2(-9.0, -3.0));
	var[12][1] = (vec2(5.0, -5.0));
	var[12][2] = (vec2(3.0, 4.0));
	var[12][3] = (vec2(-9.0, 1.0));
	var[13][0] = (vec2(0.0, 8.0));
	var[13][1] = (vec2(-8.0, 3.0));
	var[13][2] = (vec2(-7.0, 9.0));
	var[13][3] = (vec2(-8.0, -7.0));
	var[14][0] = (vec2(7.0, 1.0));
	var[14][1] = (vec2(-1.0, -2.0));
	var[14][2] = (vec2(-8.0, -3.0));
	var[14][3] = (vec2(9.0, -1.0));
	var[15][0] = (vec2(-2.0, 1.0));
	var[15][1] = (vec2(-8.0, -7.0));
	var[15][2] = (vec2(-5.0, 7.0));
	var[15][3] = (vec2(-5.0, -7.0));
	var[16][0] = (vec2(-5.0, 2.0));
	var[16][1] = (vec2(-4.0, 8.0));
	var[16][2] = (vec2(-7.0, 6.0));
	var[16][3] = (vec2(5.0, 2.0));
	var[17][0] = (vec2(-5.0, 3.0));
	var[17][1] = (vec2(-9.0, 7.0));
	var[17][2] = (vec2(-3.0, -3.0));
	var[17][3] = (vec2(-7.0, -4.0));
	var[18][0] = (vec2(3.0, 7.0));
	var[18][1] = (vec2(-6.0, -7.0));
	var[18][2] = (vec2(-7.0, 5.0));
	var[18][3] = (vec2(-8.0, 4.0));
}
#version 450
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

	var[0] = (mat2(3.0, -6.0, 2.0, -8.0));
	var[1] = (mat2(2.0, -5.0, -3.0, 9.0));
	var[2] = (mat2(4.0, -9.0, -2.0, -6.0));
	var[3] = (mat2(-2.0, 4.0, -5.0, -1.0));
	var[4] = (mat2(3.0, 1.0, 6.0, 0.0));
	var[5] = (mat2(-2.0, -5.0, 2.0, 8.0));
	var[6] = (mat2(-2.0, -7.0, -8.0, 6.0));
	var[7] = (mat2(2.0, 3.0, -8.0, 4.0));
	var[8] = (mat2(7.0, -3.0, 8.0, -1.0));
	var[9] = (mat2(7.0, -8.0, 5.0, -2.0));
	var[10] = (mat2(-5.0, -2.0, -2.0, 1.0));
	var[11] = (mat2(6.0, 0.0, 1.0, 8.0));
	var[12] = (mat2(1.0, -2.0, -9.0, -7.0));
	var[13] = (mat2(2.0, 7.0, 5.0, -3.0));
	var[14] = (mat2(-2.0, -3.0, 3.0, -1.0));
	var[15] = (mat2(-2.0, -8.0, 1.0, -1.0));
	var[16] = (mat2(9.0, -2.0, -3.0, 6.0));
	var[17] = (mat2(2.0, 6.0, -4.0, -6.0));
	var[18] = (mat2(5.0, -6.0, 1.0, 5.0));
}
#version 450
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
	highp mat2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0][0], mat2(-7.0, -9.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(var[0][1], mat2(8.0, 9.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2(var[0][2], mat2(8.0, -6.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2(var[1][0], mat2(-1.0, -5.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2(var[1][1], mat2(4.0, 1.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat2(var[1][2], mat2(7.0, -5.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat2(var[2][0], mat2(0.0, 9.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat2(var[2][1], mat2(-6.0, 5.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2(var[2][2], mat2(-9.0, -1.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat2(var[3][0], mat2(-9.0, 8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2(var[3][1], mat2(4.0, -8.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat2(var[3][2], mat2(8.0, -1.0, -6.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec2(7.0, -3.0));
	var[0][0][1] = (vec2(-2.0, 4.0));
	var[0][1][0] = (vec2(1.0, -3.0));
	var[0][1][1] = (vec2(2.0, -4.0));
	var[0][2][0] = (vec2(-1.0, 1.0));
	var[0][2][1] = (vec2(-4.0, 3.0));
	var[1][0][0] = (vec2(7.0, -7.0));
	var[1][0][1] = (vec2(2.0, 5.0));
	var[1][1][0] = (vec2(-8.0, 4.0));
	var[1][1][1] = (vec2(8.0, 1.0));
	var[1][2][0] = (vec2(4.0, 6.0));
	var[1][2][1] = (vec2(-9.0, 9.0));
	var[2][0][0] = (vec2(1.0, 5.0));
	var[2][0][1] = (vec2(9.0, -6.0));
	var[2][1][0] = (vec2(-7.0, 5.0));
	var[2][1][1] = (vec2(7.0, 4.0));
	var[2][2][0] = (vec2(7.0, -9.0));
	var[2][2][1] = (vec2(0.0, 6.0));
	var[3][0][0] = (vec2(-1.0, -7.0));
	var[3][0][1] = (vec2(-8.0, 4.0));
	var[3][1][0] = (vec2(5.0, 6.0));
	var[3][1][1] = (vec2(-7.0, 7.0));
	var[3][2][0] = (vec2(-1.0, -5.0));
	var[3][2][1] = (vec2(9.0, -7.0));
}
#version 450
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
	int16_t var[4][3];
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(var[0][0]), -5) && allOk;
	allOk = compare_int16_t(int(var[0][1]), 1) && allOk;
	allOk = compare_int16_t(int(var[0][2]), 8) && allOk;
	allOk = compare_int16_t(int(var[1][0]), -2) && allOk;
	allOk = compare_int16_t(int(var[1][1]), 9) && allOk;
	allOk = compare_int16_t(int(var[1][2]), -5) && allOk;
	allOk = compare_int16_t(int(var[2][0]), -8) && allOk;
	allOk = compare_int16_t(int(var[2][1]), 6) && allOk;
	allOk = compare_int16_t(int(var[2][2]), 3) && allOk;
	allOk = compare_int16_t(int(var[3][0]), -8) && allOk;
	allOk = compare_int16_t(int(var[3][1]), 6) && allOk;
	allOk = compare_int16_t(int(var[3][2]), -7) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = int16_t(6);
	var[0][1] = int16_t(8);
	var[0][2] = int16_t(-2);
	var[1][0] = int16_t(-4);
	var[1][1] = int16_t(-3);
	var[1][2] = int16_t(9);
	var[2][0] = int16_t(-5);
	var[2][1] = int16_t(-8);
	var[2][2] = int16_t(-3);
	var[3][0] = int16_t(2);
	var[3][1] = int16_t(-1);
	var[3][2] = int16_t(4);
}
#version 450
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
	highp mat2x3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0][0], mat2x3(-3.0, -7.0, 5.0, 4.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[0][1], mat2x3(1.0, -3.0, 5.0, -8.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[0][2], mat2x3(-3.0, 3.0, -9.0, 1.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[1][0], mat2x3(0.0, 9.0, 5.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[1][1], mat2x3(-8.0, 3.0, 8.0, -7.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[1][2], mat2x3(8.0, 4.0, -2.0, -2.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[2][0], mat2x3(7.0, -5.0, -3.0, -6.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[2][1], mat2x3(-9.0, -6.0, 5.0, -2.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[2][2], mat2x3(8.0, 1.0, 8.0, -7.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[3][0], mat2x3(-1.0, -2.0, -9.0, -1.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[3][1], mat2x3(-5.0, -6.0, -3.0, 6.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[3][2], mat2x3(-3.0, -8.0, -9.0, -8.0, -7.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec3(4.0, 5.0, -6.0));
	var[0][0][1] = (vec3(0.0, -8.0, -2.0));
	var[0][1][0] = (vec3(8.0, 8.0, 0.0));
	var[0][1][1] = (vec3(3.0, -6.0, -6.0));
	var[0][2][0] = (vec3(-1.0, 2.0, -9.0));
	var[0][2][1] = (vec3(1.0, 3.0, 2.0));
	var[1][0][0] = (vec3(1.0, 5.0, -6.0));
	var[1][0][1] = (vec3(-8.0, -6.0, -5.0));
	var[1][1][0] = (vec3(-9.0, 6.0, -9.0));
	var[1][1][1] = (vec3(0.0, -1.0, -3.0));
	var[1][2][0] = (vec3(-6.0, 9.0, 7.0));
	var[1][2][1] = (vec3(-5.0, -7.0, -2.0));
	var[2][0][0] = (vec3(-1.0, -3.0, 0.0));
	var[2][0][1] = (vec3(3.0, 3.0, 5.0));
	var[2][1][0] = (vec3(-1.0, -1.0, 3.0));
	var[2][1][1] = (vec3(-1.0, -7.0, 7.0));
	var[2][2][0] = (vec3(-6.0, -6.0, -8.0));
	var[2][2][1] = (vec3(2.0, -4.0, -3.0));
	var[3][0][0] = (vec3(-3.0, 4.0, 8.0));
	var[3][0][1] = (vec3(7.0, -2.0, -7.0));
	var[3][1][0] = (vec3(-5.0, 5.0, -5.0));
	var[3][1][1] = (vec3(1.0, -1.0, 7.0));
	var[3][2][0] = (vec3(-5.0, 8.0, -7.0));
	var[3][2][1] = (vec3(-2.0, 4.0, 3.0));
}
#version 450
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
	allOk = compare_mat4x2(var[0][0], mat4x2(8.0, -9.0, 9.0, -6.0, -8.0, -7.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[0][1], mat4x2(3.0, 6.0, -4.0, 1.0, 5.0, 2.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[0][2], mat4x2(2.0, -9.0, 8.0, 9.0, 2.0, -7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[1][0], mat4x2(-6.0, 7.0, 6.0, 4.0, 1.0, -8.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][1], mat4x2(7.0, 6.0, -2.0, -3.0, 3.0, 9.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[1][2], mat4x2(3.0, -3.0, 6.0, -6.0, -5.0, -5.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[2][0], mat4x2(0.0, 7.0, -8.0, 7.0, 2.0, -1.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[2][1], mat4x2(5.0, -3.0, 1.0, -3.0, -2.0, 3.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[2][2], mat4x2(-6.0, 2.0, 4.0, 7.0, -8.0, 0.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[3][0], mat4x2(-4.0, 3.0, 2.0, -4.0, -2.0, 1.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[3][1], mat4x2(-7.0, 1.0, 1.0, 6.0, -5.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[3][2], mat4x2(0.0, 8.0, -2.0, 7.0, 8.0, -1.0, -1.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec2(4.0, -9.0));
	var[0][0][1] = (vec2(-2.0, 8.0));
	var[0][0][2] = (vec2(-4.0, 4.0));
	var[0][0][3] = (vec2(9.0, 5.0));
	var[0][1][0] = (vec2(-2.0, 4.0));
	var[0][1][1] = (vec2(6.0, -8.0));
	var[0][1][2] = (vec2(-5.0, -1.0));
	var[0][1][3] = (vec2(9.0, 0.0));
	var[0][2][0] = (vec2(5.0, -2.0));
	var[0][2][1] = (vec2(4.0, -5.0));
	var[0][2][2] = (vec2(-2.0, -4.0));
	var[0][2][3] = (vec2(6.0, 4.0));
	var[1][0][0] = (vec2(5.0, 5.0));
	var[1][0][1] = (vec2(-6.0, -5.0));
	var[1][0][2] = (vec2(7.0, -6.0));
	var[1][0][3] = (vec2(8.0, 5.0));
	var[1][1][0] = (vec2(5.0, -5.0));
	var[1][1][1] = (vec2(-6.0, -3.0));
	var[1][1][2] = (vec2(-1.0, -1.0));
	var[1][1][3] = (vec2(-2.0, 6.0));
	var[1][2][0] = (vec2(-1.0, -8.0));
	var[1][2][1] = (vec2(-5.0, 5.0));
	var[1][2][2] = (vec2(5.0, 9.0));
	var[1][2][3] = (vec2(-7.0, 0.0));
	var[2][0][0] = (vec2(6.0, 4.0));
	var[2][0][1] = (vec2(5.0, 2.0));
	var[2][0][2] = (vec2(6.0, -4.0));
	var[2][0][3] = (vec2(-4.0, 8.0));
	var[2][1][0] = (vec2(5.0, -1.0));
	var[2][1][1] = (vec2(7.0, 0.0));
	var[2][1][2] = (vec2(-7.0, -4.0));
	var[2][1][3] = (vec2(1.0, -1.0));
	var[2][2][0] = (vec2(7.0, -6.0));
	var[2][2][1] = (vec2(9.0, -9.0));
	var[2][2][2] = (vec2(7.0, -8.0));
	var[2][2][3] = (vec2(5.0, -4.0));
	var[3][0][0] = (vec2(4.0, 3.0));
	var[3][0][1] = (vec2(9.0, 1.0));
	var[3][0][2] = (vec2(-6.0, -3.0));
	var[3][0][3] = (vec2(-7.0, 9.0));
	var[3][1][0] = (vec2(3.0, 5.0));
	var[3][1][1] = (vec2(3.0, -7.0));
	var[3][1][2] = (vec2(0.0, 6.0));
	var[3][1][3] = (vec2(-8.0, -2.0));
	var[3][2][0] = (vec2(7.0, -6.0));
	var[3][2][1] = (vec2(2.0, -2.0));
	var[3][2][2] = (vec2(8.0, 8.0));
	var[3][2][3] = (vec2(1.0, -3.0));
}
#version 450
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
	highp mat4x3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -4.0) && allOk;
	allOk = compare_mat4x3(var[0][0][0], mat4x3(6.0, 7.0, -6.0, 2.0, -5.0, 0.0, -2.0, 8.0, -7.0, 6.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(-5.0, -7.0, 0.0, -7.0, -8.0, -3.0, 1.0, 3.0, 7.0, 7.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][2], mat4x3(5.0, 2.0, -9.0, 9.0, 2.0, 8.0, -7.0, -4.0, 8.0, 6.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(-6.0, 9.0, 8.0, -1.0, 8.0, -4.0, 2.0, 6.0, -9.0, 5.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(-1.0, 4.0, 2.0, -4.0, -2.0, -1.0, -4.0, 5.0, 9.0, 1.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][2], mat4x3(-6.0, -1.0, 6.0, 9.0, -3.0, -8.0, 7.0, -5.0, 0.0, -8.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(3.0, 0.0, 1.0, -4.0, 8.0, 3.0, -7.0, 8.0, -3.0, 8.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(-8.0, -2.0, 4.0, -2.0, -5.0, -8.0, -4.0, -1.0, -9.0, -3.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][2], mat4x3(-2.0, 9.0, -5.0, -8.0, 1.0, -7.0, 6.0, -4.0, -6.0, -2.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(-5.0, -4.0, -3.0, 5.0, 8.0, 9.0, -5.0, -5.0, -3.0, 1.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(-2.0, 0.0, 1.0, -8.0, -4.0, -9.0, 3.0, -1.0, 1.0, -6.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][2], mat4x3(1.0, 6.0, 5.0, 6.0, -1.0, -1.0, 1.0, -6.0, -5.0, 0.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(-2.0, 6.0, 7.0, -5.0, 9.0, -9.0, 6.0, -8.0, -3.0, 1.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(-9.0, 6.0, 3.0, 3.0, 0.0, 0.0, -6.0, 9.0, -1.0, -2.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][2], mat4x3(-2.0, 2.0, -7.0, -8.0, -5.0, 3.0, -4.0, 5.0, -7.0, -6.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(1.0, 5.0, -8.0, -8.0, 0.0, -9.0, 5.0, 2.0, -6.0, -5.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(-4.0, 3.0, -9.0, 3.0, 4.0, -2.0, 4.0, 4.0, 2.0, 8.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][2], mat4x3(0.0, 6.0, 2.0, -9.0, 3.0, 3.0, -4.0, 5.0, -3.0, -2.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][0], mat4x3(4.0, 1.0, -4.0, -7.0, 2.0, 0.0, 9.0, 7.0, -2.0, -3.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][1], mat4x3(6.0, -7.0, -6.0, 3.0, -7.0, -6.0, 4.0, 7.0, 5.0, -4.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][2], mat4x3(6.0, 2.0, 0.0, -4.0, 0.0, 8.0, -8.0, 7.0, 6.0, 3.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][0], mat4x3(-9.0, -9.0, -6.0, 7.0, -8.0, 3.0, 0.0, -3.0, 3.0, -8.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][1], mat4x3(1.0, 6.0, -1.0, 3.0, -4.0, 7.0, -7.0, -6.0, -3.0, 0.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][2], mat4x3(-1.0, 9.0, -6.0, 8.0, -4.0, -1.0, 0.0, -5.0, 0.0, -6.0, -2.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-3.0);
	var[0][0][0][0] = (vec3(-6.0, 6.0, 1.0));
	var[0][0][0][1] = (vec3(-4.0, -3.0, -3.0));
	var[0][0][0][2] = (vec3(3.0, -2.0, -7.0));
	var[0][0][0][3] = (vec3(1.0, -5.0, -1.0));
	var[0][0][1][0] = (vec3(-5.0, 7.0, 1.0));
	var[0][0][1][1] = (vec3(-2.0, -4.0, -4.0));
	var[0][0][1][2] = (vec3(-6.0, 5.0, -2.0));
	var[0][0][1][3] = (vec3(6.0, -9.0, 5.0));
	var[0][0][2][0] = (vec3(-5.0, 7.0, -4.0));
	var[0][0][2][1] = (vec3(8.0, -3.0, -2.0));
	var[0][0][2][2] = (vec3(0.0, 8.0, -2.0));
	var[0][0][2][3] = (vec3(6.0, -3.0, -9.0));
	var[0][1][0][0] = (vec3(-6.0, -3.0, -2.0));
	var[0][1][0][1] = (vec3(5.0, 8.0, 2.0));
	var[0][1][0][2] = (vec3(-9.0, 7.0, 7.0));
	var[0][1][0][3] = (vec3(-3.0, 4.0, 9.0));
	var[0][1][1][0] = (vec3(4.0, 1.0, 5.0));
	var[0][1][1][1] = (vec3(-9.0, 2.0, -7.0));
	var[0][1][1][2] = (vec3(-3.0, -9.0, 9.0));
	var[0][1][1][3] = (vec3(-6.0, 3.0, -9.0));
	var[0][1][2][0] = (vec3(-4.0, 0.0, 5.0));
	var[0][1][2][1] = (vec3(8.0, 9.0, -7.0));
	var[0][1][2][2] = (vec3(-9.0, -5.0, 0.0));
	var[0][1][2][3] = (vec3(-1.0, -6.0, -9.0));
	var[1][0][0][0] = (vec3(-2.0, -2.0, 7.0));
	var[1][0][0][1] = (vec3(9.0, -4.0, 3.0));
	var[1][0][0][2] = (vec3(1.0, 0.0, -9.0));
	var[1][0][0][3] = (vec3(-2.0, -7.0, -5.0));
	var[1][0][1][0] = (vec3(-6.0, 5.0, -2.0));
	var[1][0][1][1] = (vec3(-7.0, 5.0, -2.0));
	var[1][0][1][2] = (vec3(-6.0, 4.0, 9.0));
	var[1][0][1][3] = (vec3(5.0, -9.0, -3.0));
	var[1][0][2][0] = (vec3(3.0, 7.0, 3.0));
	var[1][0][2][1] = (vec3(-4.0, -8.0, -2.0));
	var[1][0][2][2] = (vec3(2.0, -1.0, 1.0));
	var[1][0][2][3] = (vec3(-9.0, 9.0, -7.0));
	var[1][1][0][0] = (vec3(-9.0, 9.0, 9.0));
	var[1][1][0][1] = (vec3(-1.0, 8.0, 8.0));
	var[1][1][0][2] = (vec3(-8.0, 4.0, 9.0));
	var[1][1][0][3] = (vec3(-8.0, 8.0, 4.0));
	var[1][1][1][0] = (vec3(6.0, 1.0, -9.0));
	var[1][1][1][1] = (vec3(7.0, 3.0, -4.0));
	var[1][1][1][2] = (vec3(-3.0, 8.0, -9.0));
	var[1][1][1][3] = (vec3(-9.0, 2.0, 0.0));
	var[1][1][2][0] = (vec3(-2.0, 5.0, 8.0));
	var[1][1][2][1] = (vec3(4.0, -4.0, 5.0));
	var[1][1][2][2] = (vec3(4.0, -5.0, 0.0));
	var[1][1][2][3] = (vec3(-3.0, 9.0, -4.0));
	var[2][0][0][0] = (vec3(-7.0, -7.0, 6.0));
	var[2][0][0][1] = (vec3(-9.0, 3.0, -5.0));
	var[2][0][0][2] = (vec3(2.0, 4.0, -2.0));
	var[2][0][0][3] = (vec3(-4.0, -6.0, -1.0));
	var[2][0][1][0] = (vec3(5.0, 5.0, -9.0));
	var[2][0][1][1] = (vec3(-3.0, -9.0, 3.0));
	var[2][0][1][2] = (vec3(2.0, 0.0, 0.0));
	var[2][0][1][3] = (vec3(-9.0, 7.0, 5.0));
	var[2][0][2][0] = (vec3(-5.0, -2.0, 6.0));
	var[2][0][2][1] = (vec3(5.0, -4.0, -2.0));
	var[2][0][2][2] = (vec3(9.0, -3.0, 2.0));
	var[2][0][2][3] = (vec3(5.0, -4.0, 6.0));
	var[2][1][0][0] = (vec3(-7.0, 3.0, 6.0));
	var[2][1][0][1] = (vec3(4.0, 1.0, -3.0));
	var[2][1][0][2] = (vec3(3.0, 8.0, -6.0));
	var[2][1][0][3] = (vec3(5.0, -6.0, 3.0));
	var[2][1][1][0] = (vec3(2.0, 3.0, 1.0));
	var[2][1][1][1] = (vec3(-7.0, 3.0, 6.0));
	var[2][1][1][2] = (vec3(-3.0, -2.0, 3.0));
	var[2][1][1][3] = (vec3(1.0, -1.0, 0.0));
	var[2][1][2][0] = (vec3(9.0, -4.0, 6.0));
	var[2][1][2][1] = (vec3(-5.0, 0.0, -2.0));
	var[2][1][2][2] = (vec3(4.0, 6.0, -5.0));
	var[2][1][2][3] = (vec3(2.0, 4.0, -4.0));
	var[3][0][0][0] = (vec3(4.0, 7.0, 1.0));
	var[3][0][0][1] = (vec3(-4.0, -6.0, 4.0));
	var[3][0][0][2] = (vec3(-6.0, -5.0, 5.0));
	var[3][0][0][3] = (vec3(6.0, -1.0, 6.0));
	var[3][0][1][0] = (vec3(3.0, -9.0, -7.0));
	var[3][0][1][1] = (vec3(3.0, -4.0, 1.0));
	var[3][0][1][2] = (vec3(2.0, 6.0, -2.0));
	var[3][0][1][3] = (vec3(3.0, 7.0, -5.0));
	var[3][0][2][0] = (vec3(8.0, -9.0, -4.0));
	var[3][0][2][1] = (vec3(-1.0, -9.0, 5.0));
	var[3][0][2][2] = (vec3(5.0, 6.0, -8.0));
	var[3][0][2][3] = (vec3(1.0, -7.0, -5.0));
	var[3][1][0][0] = (vec3(-4.0, 0.0, -2.0));
	var[3][1][0][1] = (vec3(5.0, 7.0, 8.0));
	var[3][1][0][2] = (vec3(8.0, -3.0, -9.0));
	var[3][1][0][3] = (vec3(-7.0, 5.0, 6.0));
	var[3][1][1][0] = (vec3(-7.0, -2.0, 0.0));
	var[3][1][1][1] = (vec3(3.0, -5.0, -6.0));
	var[3][1][1][2] = (vec3(-7.0, -4.0, -8.0));
	var[3][1][1][3] = (vec3(1.0, -7.0, 2.0));
	var[3][1][2][0] = (vec3(-4.0, -7.0, -3.0));
	var[3][1][2][1] = (vec3(-4.0, 0.0, -8.0));
	var[3][1][2][2] = (vec3(-2.0, 6.0, -7.0));
	var[3][1][2][3] = (vec3(-7.0, 2.0, 3.0));
}
#version 450
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
	highp ivec4 var[][4][2];
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((var[0][0][0]), ivec4(-7, 9, -5, 6)) && allOk;
	allOk = compare_ivec4((var[0][0][1]), ivec4(3, 4, 2, -3)) && allOk;
	allOk = compare_ivec4((var[0][1][0]), ivec4(4, 3, 6, -6)) && allOk;
	allOk = compare_ivec4((var[0][1][1]), ivec4(1, -3, 0, 0)) && allOk;
	allOk = compare_ivec4((var[0][2][0]), ivec4(-7, 2, 6, -5)) && allOk;
	allOk = compare_ivec4((var[0][2][1]), ivec4(1, 5, 7, 9)) && allOk;
	allOk = compare_ivec4((var[0][3][0]), ivec4(8, -5, 1, -2)) && allOk;
	allOk = compare_ivec4((var[0][3][1]), ivec4(2, 9, -9, -7)) && allOk;
	allOk = compare_ivec4((var[1][0][0]), ivec4(-3, -3, -5, -5)) && allOk;
	allOk = compare_ivec4((var[1][0][1]), ivec4(3, -5, -9, -7)) && allOk;
	allOk = compare_ivec4((var[1][1][0]), ivec4(1, -6, 0, -7)) && allOk;
	allOk = compare_ivec4((var[1][1][1]), ivec4(6, -4, -4, 0)) && allOk;
	allOk = compare_ivec4((var[1][2][0]), ivec4(-6, 4, 0, 9)) && allOk;
	allOk = compare_ivec4((var[1][2][1]), ivec4(-3, 6, -6, -6)) && allOk;
	allOk = compare_ivec4((var[1][3][0]), ivec4(-5, -2, 6, 4)) && allOk;
	allOk = compare_ivec4((var[1][3][1]), ivec4(-1, 1, 1, 5)) && allOk;
	allOk = compare_ivec4((var[2][0][0]), ivec4(1, 5, 9, 7)) && allOk;
	allOk = compare_ivec4((var[2][0][1]), ivec4(-4, -1, 8, -1)) && allOk;
	allOk = compare_ivec4((var[2][1][0]), ivec4(8, -3, 3, 3)) && allOk;
	allOk = compare_ivec4((var[2][1][1]), ivec4(-3, 1, 3, 1)) && allOk;
	allOk = compare_ivec4((var[2][2][0]), ivec4(1, -6, -3, 5)) && allOk;
	allOk = compare_ivec4((var[2][2][1]), ivec4(9, -7, -1, -9)) && allOk;
	allOk = compare_ivec4((var[2][3][0]), ivec4(1, -9, 2, -2)) && allOk;
	allOk = compare_ivec4((var[2][3][1]), ivec4(-5, -8, 8, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (ivec4(5, -9, 5, -6));
	var[0][0][1] = (ivec4(-2, -4, 1, -9));
	var[0][1][0] = (ivec4(6, 5, 4, 0));
	var[0][1][1] = (ivec4(5, 9, 0, 0));
	var[0][2][0] = (ivec4(7, 1, -4, 4));
	var[0][2][1] = (ivec4(-2, 5, -8, 0));
	var[0][3][0] = (ivec4(6, 8, -7, -2));
	var[0][3][1] = (ivec4(9, -9, -5, -6));
	var[1][0][0] = (ivec4(7, 3, 6, 8));
	var[1][0][1] = (ivec4(6, -4, 6, -7));
	var[1][1][0] = (ivec4(-6, 4, 4, 2));
	var[1][1][1] = (ivec4(9, 7, 5, 5));
	var[1][2][0] = (ivec4(8, -9, -8, -3));
	var[1][2][1] = (ivec4(3, -9, -5, -4));
	var[1][3][0] = (ivec4(-5, -7, -9, -3));
	var[1][3][1] = (ivec4(-2, -1, -9, 9));
	var[2][0][0] = (ivec4(9, -8, -9, 0));
	var[2][0][1] = (ivec4(5, -7, 2, 9));
	var[2][1][0] = (ivec4(3, -3, -9, -8));
	var[2][1][1] = (ivec4(-6, 3, 2, 0));
	var[2][2][0] = (ivec4(-8, 8, -3, 2));
	var[2][2][1] = (ivec4(-2, -6, 4, -5));
	var[2][3][0] = (ivec4(-5, 1, 9, -8));
	var[2][3][1] = (ivec4(0, 5, -8, -8));
}
#version 450
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
	highp mat2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0][0][0], mat2(-5.0, -2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(-2.0, -4.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(9.0, 8.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(-1.0, -8.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2(var[0][2][0], mat2(7.0, 8.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat2(var[0][2][1], mat2(9.0, 8.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat2(var[0][3][0], mat2(4.0, -9.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2(var[0][3][1], mat2(-1.0, 9.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(-9.0, 9.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(8.0, -3.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(8.0, -4.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(3.0, 3.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2(var[1][2][0], mat2(3.0, 3.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat2(var[1][2][1], mat2(-3.0, -8.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat2(var[1][3][0], mat2(5.0, 3.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2(var[1][3][1], mat2(7.0, -4.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(9.0, -8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(8.0, -2.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(0.0, -3.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(8.0, -5.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2(var[2][2][0], mat2(6.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2(var[2][2][1], mat2(-2.0, -9.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat2(var[2][3][0], mat2(-5.0, 9.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat2(var[2][3][1], mat2(9.0, 2.0, 3.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2(-2.0, -8.0, -7.0, 9.0));
	var[0][0][1] = (mat2(2.0, 2.0, -4.0, -5.0));
	var[0][1][0] = (mat2(5.0, -3.0, -3.0, 6.0));
	var[0][1][1] = (mat2(-4.0, -6.0, -2.0, -6.0));
	var[0][2][0] = (mat2(5.0, 7.0, 7.0, -8.0));
	var[0][2][1] = (mat2(7.0, -9.0, -2.0, 4.0));
	var[0][3][0] = (mat2(-8.0, 1.0, -1.0, -3.0));
	var[0][3][1] = (mat2(6.0, -9.0, -7.0, 6.0));
	var[1][0][0] = (mat2(-1.0, -4.0, 0.0, -1.0));
	var[1][0][1] = (mat2(0.0, 4.0, -3.0, -4.0));
	var[1][1][0] = (mat2(-3.0, -4.0, -7.0, -9.0));
	var[1][1][1] = (mat2(8.0, 2.0, -6.0, 9.0));
	var[1][2][0] = (mat2(3.0, 3.0, 3.0, -6.0));
	var[1][2][1] = (mat2(-4.0, -8.0, -2.0, 5.0));
	var[1][3][0] = (mat2(-6.0, -2.0, 6.0, 0.0));
	var[1][3][1] = (mat2(-4.0, -4.0, -6.0, -7.0));
	var[2][0][0] = (mat2(-6.0, 0.0, 5.0, 1.0));
	var[2][0][1] = (mat2(-6.0, 9.0, 5.0, 9.0));
	var[2][1][0] = (mat2(-5.0, -2.0, 4.0, 9.0));
	var[2][1][1] = (mat2(4.0, 7.0, 4.0, -8.0));
	var[2][2][0] = (mat2(-3.0, 5.0, 0.0, -2.0));
	var[2][2][1] = (mat2(-3.0, 0.0, -9.0, 1.0));
	var[2][3][0] = (mat2(1.0, 6.0, -7.0, 7.0));
	var[2][3][1] = (mat2(9.0, -8.0, 3.0, -7.0));
}
#version 450
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
	allOk = compare_mat4x3(var[0][0][0], mat4x3(-2.0, 8.0, 0.0, 9.0, -7.0, -7.0, 8.0, 2.0, 7.0, 3.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(9.0, -7.0, -6.0, -8.0, -6.0, 3.0, -8.0, -8.0, -4.0, 5.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(5.0, -7.0, -7.0, -6.0, -9.0, 6.0, 7.0, -3.0, -3.0, 9.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(2.0, 5.0, 2.0, 0.0, 9.0, -8.0, -2.0, -2.0, -1.0, -2.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[0][2][0], mat4x3(8.0, 3.0, -4.0, -1.0, -1.0, 6.0, 4.0, -5.0, 5.0, 4.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[0][2][1], mat4x3(-2.0, -4.0, 7.0, -7.0, -5.0, 7.0, 0.0, 0.0, -1.0, -5.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[0][3][0], mat4x3(-4.0, -2.0, -6.0, -6.0, -1.0, -4.0, 1.0, 5.0, -2.0, 2.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[0][3][1], mat4x3(-7.0, 4.0, -9.0, 9.0, -7.0, -9.0, -7.0, -1.0, 9.0, -4.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(-6.0, 1.0, 9.0, 4.0, -4.0, -7.0, 9.0, -3.0, -7.0, 9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(1.0, 7.0, -4.0, 6.0, 0.0, 2.0, 2.0, 3.0, -9.0, 4.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(-9.0, -1.0, -2.0, -2.0, 8.0, -3.0, -7.0, 1.0, -6.0, 8.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(-5.0, -8.0, 7.0, 3.0, 7.0, 9.0, 7.0, 9.0, -2.0, -4.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[1][2][0], mat4x3(8.0, 9.0, 4.0, 2.0, 6.0, 1.0, -3.0, 0.0, 1.0, -6.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[1][2][1], mat4x3(0.0, 9.0, 4.0, -6.0, 8.0, 9.0, 3.0, -5.0, -8.0, 4.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[1][3][0], mat4x3(4.0, -3.0, 2.0, 1.0, -6.0, 3.0, 7.0, -1.0, 0.0, 8.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[1][3][1], mat4x3(-9.0, -9.0, -9.0, 3.0, 7.0, 2.0, 9.0, 2.0, 9.0, 2.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(5.0, 4.0, 8.0, -8.0, 0.0, 5.0, -5.0, 7.0, 9.0, -8.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(6.0, 3.0, 0.0, -3.0, 0.0, -2.0, 5.0, 1.0, 1.0, 6.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(5.0, 2.0, 7.0, 6.0, -5.0, -7.0, 3.0, -9.0, -5.0, -8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(-7.0, 4.0, 6.0, 2.0, 8.0, -1.0, 5.0, 2.0, 7.0, 1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[2][2][0], mat4x3(7.0, -4.0, -1.0, -2.0, 6.0, 7.0, 5.0, -4.0, 3.0, 1.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[2][2][1], mat4x3(4.0, -5.0, 9.0, 5.0, 6.0, 2.0, 5.0, 5.0, 4.0, 6.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[2][3][0], mat4x3(1.0, 3.0, -2.0, 4.0, 1.0, 2.0, 5.0, -9.0, -7.0, 3.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[2][3][1], mat4x3(-5.0, 3.0, 3.0, 2.0, -4.0, 4.0, -8.0, -3.0, 4.0, 4.0, 0.0, -8.0)) && allOk;
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
	var[0][1][0][0] = (vec3(-9.0, 3.0, -2.0));
	var[0][1][0][1] = (vec3(5.0, 6.0, -7.0));
	var[0][1][0][2] = (vec3(-8.0, 1.0, 8.0));
	var[0][1][0][3] = (vec3(1.0, 6.0, -1.0));
	var[0][1][1][0] = (vec3(-5.0, 0.0, -6.0));
	var[0][1][1][1] = (vec3(5.0, -3.0, 2.0));
	var[0][1][1][2] = (vec3(-5.0, 2.0, -2.0));
	var[0][1][1][3] = (vec3(-7.0, -9.0, -1.0));
	var[0][2][0][0] = (vec3(-5.0, 5.0, -2.0));
	var[0][2][0][1] = (vec3(1.0, -7.0, -9.0));
	var[0][2][0][2] = (vec3(4.0, -9.0, 8.0));
	var[0][2][0][3] = (vec3(2.0, 5.0, -4.0));
	var[0][2][1][0] = (vec3(-9.0, -9.0, 5.0));
	var[0][2][1][1] = (vec3(-3.0, 6.0, -3.0));
	var[0][2][1][2] = (vec3(7.0, -9.0, -4.0));
	var[0][2][1][3] = (vec3(9.0, 6.0, 2.0));
	var[0][3][0][0] = (vec3(-1.0, -5.0, 2.0));
	var[0][3][0][1] = (vec3(4.0, 7.0, -4.0));
	var[0][3][0][2] = (vec3(6.0, 2.0, -4.0));
	var[0][3][0][3] = (vec3(8.0, -8.0, -1.0));
	var[0][3][1][0] = (vec3(-8.0, -9.0, 2.0));
	var[0][3][1][1] = (vec3(-8.0, -2.0, -1.0));
	var[0][3][1][2] = (vec3(-4.0, 5.0, 4.0));
	var[0][3][1][3] = (vec3(-6.0, -1.0, 7.0));
	var[1][0][0][0] = (vec3(2.0, 7.0, -1.0));
	var[1][0][0][1] = (vec3(-3.0, -3.0, -7.0));
	var[1][0][0][2] = (vec3(-5.0, 3.0, 4.0));
	var[1][0][0][3] = (vec3(-4.0, -2.0, 8.0));
	var[1][0][1][0] = (vec3(-1.0, -8.0, 8.0));
	var[1][0][1][1] = (vec3(-4.0, -7.0, -7.0));
	var[1][0][1][2] = (vec3(8.0, 4.0, -6.0));
	var[1][0][1][3] = (vec3(6.0, 0.0, 1.0));
	var[1][1][0][0] = (vec3(-2.0, -3.0, -7.0));
	var[1][1][0][1] = (vec3(-9.0, -4.0, 9.0));
	var[1][1][0][2] = (vec3(4.0, -4.0, 5.0));
	var[1][1][0][3] = (vec3(7.0, 1.0, 7.0));
	var[1][1][1][0] = (vec3(-9.0, 5.0, 4.0));
	var[1][1][1][1] = (vec3(4.0, 0.0, 0.0));
	var[1][1][1][2] = (vec3(0.0, -3.0, 3.0));
	var[1][1][1][3] = (vec3(1.0, 8.0, 0.0));
	var[1][2][0][0] = (vec3(-3.0, -5.0, 2.0));
	var[1][2][0][1] = (vec3(-9.0, 5.0, -6.0));
	var[1][2][0][2] = (vec3(5.0, -7.0, -9.0));
	var[1][2][0][3] = (vec3(0.0, 9.0, 9.0));
	var[1][2][1][0] = (vec3(-9.0, 5.0, 5.0));
	var[1][2][1][1] = (vec3(-2.0, 7.0, 7.0));
	var[1][2][1][2] = (vec3(-2.0, 7.0, -9.0));
	var[1][2][1][3] = (vec3(5.0, 5.0, -4.0));
	var[1][3][0][0] = (vec3(1.0, -1.0, 9.0));
	var[1][3][0][1] = (vec3(-9.0, 4.0, 7.0));
	var[1][3][0][2] = (vec3(-5.0, -9.0, 1.0));
	var[1][3][0][3] = (vec3(-1.0, 2.0, -5.0));
	var[1][3][1][0] = (vec3(3.0, 6.0, 7.0));
	var[1][3][1][1] = (vec3(4.0, -5.0, 8.0));
	var[1][3][1][2] = (vec3(4.0, 6.0, 1.0));
	var[1][3][1][3] = (vec3(-4.0, 5.0, -7.0));
	var[2][0][0][0] = (vec3(7.0, -1.0, -8.0));
	var[2][0][0][1] = (vec3(9.0, 9.0, -6.0));
	var[2][0][0][2] = (vec3(0.0, 1.0, 1.0));
	var[2][0][0][3] = (vec3(2.0, 7.0, 2.0));
	var[2][0][1][0] = (vec3(-3.0, -6.0, 5.0));
	var[2][0][1][1] = (vec3(3.0, -1.0, -1.0));
	var[2][0][1][2] = (vec3(-2.0, 9.0, -5.0));
	var[2][0][1][3] = (vec3(8.0, -6.0, -5.0));
	var[2][1][0][0] = (vec3(-2.0, 9.0, -8.0));
	var[2][1][0][1] = (vec3(-8.0, 7.0, -9.0));
	var[2][1][0][2] = (vec3(3.0, -2.0, -3.0));
	var[2][1][0][3] = (vec3(-5.0, 1.0, -4.0));
	var[2][1][1][0] = (vec3(5.0, 5.0, 8.0));
	var[2][1][1][1] = (vec3(3.0, 7.0, -3.0));
	var[2][1][1][2] = (vec3(-2.0, 2.0, -9.0));
	var[2][1][1][3] = (vec3(0.0, 9.0, 5.0));
	var[2][2][0][0] = (vec3(6.0, -3.0, 7.0));
	var[2][2][0][1] = (vec3(-3.0, 1.0, -7.0));
	var[2][2][0][2] = (vec3(-1.0, 0.0, -9.0));
	var[2][2][0][3] = (vec3(0.0, -4.0, 9.0));
	var[2][2][1][0] = (vec3(-6.0, -5.0, 7.0));
	var[2][2][1][1] = (vec3(6.0, 1.0, -2.0));
	var[2][2][1][2] = (vec3(2.0, 8.0, 9.0));
	var[2][2][1][3] = (vec3(2.0, -8.0, -9.0));
	var[2][3][0][0] = (vec3(-2.0, -3.0, -9.0));
	var[2][3][0][1] = (vec3(5.0, -8.0, -5.0));
	var[2][3][0][2] = (vec3(-7.0, -4.0, -3.0));
	var[2][3][0][3] = (vec3(-1.0, 8.0, -8.0));
	var[2][3][1][0] = (vec3(-2.0, -6.0, 6.0));
	var[2][3][1][1] = (vec3(-3.0, -2.0, -8.0));
	var[2][3][1][2] = (vec3(-3.0, -2.0, -2.0));
	var[2][3][1][3] = (vec3(-9.0, 4.0, 7.0));
}
#version 450
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
	allOk = compare_ivec3((s.a), ivec3(2, 2, -2)) && allOk;
	allOk = compare_mat3(s.b[0], mat3(0.0, -3.0, -4.0, 0.0, -5.0, 5.0, 1.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3(s.b[1], mat3(2.0, 7.0, 3.0, -7.0, -2.0, -2.0, 0.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3(s.b[2], mat3(9.0, 6.0, 1.0, 8.0, 2.0, -8.0, -9.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(s.b[3], mat3(6.0, 6.0, 0.0, -9.0, -5.0, -5.0, -9.0, -5.0, -2.0)) && allOk;
	allOk = compare_vec4((s.c), vec4(8.0, -4.0, 0.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	s.a = (ivec3(-3, 6, 8));
	s.b[0] = (mat3(1.0, -7.0, 5.0, -7.0, 2.0, -2.0, -1.0, -6.0, -6.0));
	s.b[1] = (mat3(7.0, 1.0, 8.0, 8.0, 9.0, -7.0, -4.0, 0.0, -9.0));
	s.b[2] = (mat3(-2.0, 7.0, 2.0, 3.0, -7.0, -4.0, 2.0, -2.0, -7.0));
	s.b[3] = (mat3(3.0, 5.0, 3.0, 1.0, -6.0, -6.0, -6.0, 0.0, -7.0));
	s.c = (vec4(4.0, 5.0, -6.0, -8.0));
}
#version 450
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
layout(std140, binding = 1) buffer Block
{
	S s;
	lowp vec2 v;
	T t;
	highp uint u;
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
	allOk = compare_ivec3((s.a), ivec3(4, -9, 2)) && allOk;
	allOk = compare_mat3(s.b[0], mat3(-4.0, 1.0, 2.0, 9.0, -7.0, -8.0, -6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3(s.b[1], mat3(5.0, 2.0, 9.0, 9.0, 7.0, -7.0, 5.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat3(s.b[2], mat3(3.0, 0.0, -3.0, 5.0, -2.0, -5.0, -5.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3(s.b[3], mat3(7.0, -4.0, -9.0, 3.0, -7.0, -7.0, -9.0, 2.0, -1.0)) && allOk;
	allOk = compare_vec4((s.c), vec4(9.0, 0.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3(t.a, mat3(-7.0, 3.0, 4.0, 6.0, -9.0, 1.0, 1.0, -7.0, 6.0)) && allOk;
	allOk = compare_ivec3((t.b.a), ivec3(1, 6, -2)) && allOk;
	allOk = compare_mat3(t.b.b[0], mat3(-8.0, 3.0, -3.0, -9.0, -3.0, 8.0, -4.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3(t.b.b[1], mat3(4.0, -1.0, -1.0, -3.0, 4.0, 4.0, -8.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat3(t.b.b[2], mat3(0.0, 5.0, 0.0, 7.0, -7.0, 9.0, 2.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat3(t.b.b[3], mat3(-7.0, -4.0, -9.0, 2.0, -7.0, 2.0, -3.0, -6.0, -8.0)) && allOk;
	allOk = compare_vec4((t.b.c), vec4(2.0, -2.0, -4.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	t.a[0] = (vec3(7.0, 8.0, -8.0));
	t.a[1] = (vec3(-1.0, -2.0, 9.0));
	t.a[2] = (vec3(3.0, 2.0, 1.0));
	t.b.a = (ivec3(6, 6, 6));
	t.b.b[0][0] = (vec3(8.0, -2.0, -2.0));
	t.b.b[0][1] = (vec3(-7.0, 0.0, -8.0));
	t.b.b[0][2] = (vec3(8.0, -5.0, 7.0));
	t.b.b[1][0] = (vec3(-9.0, -7.0, -2.0));
	t.b.b[1][1] = (vec3(4.0, -3.0, -1.0));
	t.b.b[1][2] = (vec3(-4.0, -1.0, 0.0));
	t.b.b[2][0] = (vec3(-1.0, 1.0, 1.0));
	t.b.b[2][1] = (vec3(-7.0, 6.0, -1.0));
	t.b.b[2][2] = (vec3(7.0, 8.0, 3.0));
	t.b.b[3][0] = (vec3(-2.0, -1.0, -9.0));
	t.b.b[3][1] = (vec3(4.0, -5.0, -4.0));
	t.b.b[3][2] = (vec3(9.0, -5.0, 9.0));
	t.b.c = (vec4(4.0, -5.0, 2.0, -8.0));
	u = (7u);
}
#version 450
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
layout(std430, binding = 1) buffer Block
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
	allOk = compare_ivec3((s[0][0].a), ivec3(3, -3, -7)) && allOk;
	allOk = compare_vec4((s[0][0].c), vec4(8.0, -7.0, -3.0, -2.0)) && allOk;
	allOk = compare_ivec3((s[0][1].a), ivec3(-8, 1, 7)) && allOk;
	allOk = compare_vec4((s[0][1].c), vec4(-2.0, -1.0, 8.0, -9.0)) && allOk;
	allOk = compare_ivec3((s[1][0].a), ivec3(8, -8, 2)) && allOk;
	allOk = compare_vec4((s[1][0].c), vec4(-8.0, -9.0, 2.0, -8.0)) && allOk;
	allOk = compare_ivec3((s[1][1].a), ivec3(6, -9, 1)) && allOk;
	allOk = compare_vec4((s[1][1].c), vec4(2.0, -2.0, 6.0, 7.0)) && allOk;
	allOk = compare_ivec3((s[2][0].a), ivec3(8, -2, 4)) && allOk;
	allOk = compare_vec4((s[2][0].c), vec4(9.0, 0.0, 9.0, 7.0)) && allOk;
	allOk = compare_ivec3((s[2][1].a), ivec3(-4, -5, -5)) && allOk;
	allOk = compare_vec4((s[2][1].c), vec4(-3.0, -2.0, 6.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	v = (vec4(-2.0, 8.0, 8.0, -7.0));
	s[0][0].a = (ivec3(8, -2, -2));
	s[0][0].c = (vec4(-6.0, -4.0, -4.0, -3.0));
	s[0][1].a = (ivec3(-6, 9, -2));
	s[0][1].c = (vec4(9.0, -5.0, -4.0, 1.0));
	s[1][0].a = (ivec3(-6, 6, 0));
	s[1][0].c = (vec4(-6.0, 0.0, -2.0, -1.0));
	s[1][1].a = (ivec3(-5, 7, -9));
	s[1][1].c = (vec4(-6.0, 7.0, 8.0, -2.0));
	s[2][0].a = (ivec3(-6, -4, 3));
	s[2][0].c = (vec4(-2.0, -2.0, -8.0, 7.0));
	s[2][1].a = (ivec3(-9, 8, 1));
	s[2][1].c = (vec4(0.0, 7.0, 6.0, -5.0));
}
#version 450
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
layout(scalar, binding = 1) buffer Block
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
	allOk = compare_uint((u), 2u) && allOk;
	allOk = compare_mat4x3(t[0].a, mat4x3(-7.0, 8.0, -4.0, 6.0, -2.0, -9.0, -2.0, 8.0, 4.0, -2.0, -2.0, -1.0)) && allOk;
	allOk = compare_uvec3((t[0].b[0].a), uvec3(7u, 6u, 0u)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[0]), vec2(-9.0, 0.0)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[1]), vec2(6.0, 9.0)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[2]), vec2(5.0, -6.0)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[3]), vec2(-8.0, -3.0)) && allOk;
	allOk = compare_vec4((t[0].b[0].c), vec4(-6.0, -9.0, -6.0, -3.0)) && allOk;
	allOk = compare_uvec3((t[0].b[1].a), uvec3(9u, 8u, 2u)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[0]), vec2(4.0, 7.0)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[1]), vec2(-3.0, 7.0)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[2]), vec2(-5.0, 3.0)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[3]), vec2(5.0, 9.0)) && allOk;
	allOk = compare_vec4((t[0].b[1].c), vec4(-5.0, -7.0, -9.0, 0.0)) && allOk;
	allOk = compare_uvec3((t[0].b[2].a), uvec3(5u, 3u, 1u)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[0]), vec2(-1.0, -2.0)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[1]), vec2(-5.0, 3.0)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[2]), vec2(2.0, -4.0)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[3]), vec2(-1.0, 7.0)) && allOk;
	allOk = compare_vec4((t[0].b[2].c), vec4(-7.0, -1.0, 7.0, 7.0)) && allOk;
	allOk = compare_int((t[0].c), 6) && allOk;
	allOk = compare_mat4x3(t[1].a, mat4x3(7.0, 2.0, 6.0, 0.0, 9.0, 8.0, -7.0, 9.0, 8.0, -7.0, -3.0, -8.0)) && allOk;
	allOk = compare_uvec3((t[1].b[0].a), uvec3(4u, 4u, 4u)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[0]), vec2(-7.0, 3.0)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[1]), vec2(4.0, -6.0)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[2]), vec2(-6.0, 0.0)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[3]), vec2(-4.0, 3.0)) && allOk;
	allOk = compare_vec4((t[1].b[0].c), vec4(-1.0, 3.0, -4.0, -1.0)) && allOk;
	allOk = compare_uvec3((t[1].b[1].a), uvec3(3u, 9u, 4u)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[0]), vec2(0.0, 2.0)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[1]), vec2(-3.0, -3.0)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[2]), vec2(5.0, 2.0)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[3]), vec2(3.0, 7.0)) && allOk;
	allOk = compare_vec4((t[1].b[1].c), vec4(-3.0, 1.0, 0.0, 8.0)) && allOk;
	allOk = compare_uvec3((t[1].b[2].a), uvec3(4u, 6u, 5u)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[0]), vec2(-9.0, 9.0)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[1]), vec2(-3.0, 7.0)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[2]), vec2(-2.0, -5.0)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[3]), vec2(-6.0, -7.0)) && allOk;
	allOk = compare_vec4((t[1].b[2].c), vec4(1.0, 3.0, -8.0, -6.0)) && allOk;
	allOk = compare_int((t[1].c), -4) && allOk;
	allOk = compare_mat4x3(t[2].a, mat4x3(8.0, 4.0, 0.0, 0.0, 5.0, -2.0, 8.0, 4.0, -7.0, 5.0, 1.0, 4.0)) && allOk;
	allOk = compare_uvec3((t[2].b[0].a), uvec3(3u, 6u, 8u)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[0]), vec2(7.0, -3.0)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[1]), vec2(-7.0, -6.0)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[2]), vec2(9.0, -9.0)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[3]), vec2(-8.0, 5.0)) && allOk;
	allOk = compare_vec4((t[2].b[0].c), vec4(-5.0, -5.0, -4.0, 9.0)) && allOk;
	allOk = compare_uvec3((t[2].b[1].a), uvec3(5u, 6u, 5u)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[0]), vec2(9.0, -8.0)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[1]), vec2(9.0, 9.0)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[2]), vec2(3.0, 3.0)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[3]), vec2(0.0, 2.0)) && allOk;
	allOk = compare_vec4((t[2].b[1].c), vec4(1.0, 0.0, 3.0, -7.0)) && allOk;
	allOk = compare_uvec3((t[2].b[2].a), uvec3(6u, 9u, 9u)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[0]), vec2(-3.0, -1.0)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[1]), vec2(-4.0, 5.0)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[2]), vec2(-9.0, -4.0)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[3]), vec2(-5.0, 4.0)) && allOk;
	allOk = compare_vec4((t[2].b[2].c), vec4(-2.0, -9.0, -9.0, -8.0)) && allOk;
	allOk = compare_int((t[2].c), 9) && allOk;
	allOk = compare_mat4x3(t[3].a, mat4x3(0.0, -8.0, 5.0, -2.0, 8.0, 6.0, -9.0, 9.0, -7.0, -6.0, -1.0, 2.0)) && allOk;
	allOk = compare_uvec3((t[3].b[0].a), uvec3(6u, 6u, 9u)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[0]), vec2(-1.0, 8.0)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[1]), vec2(5.0, -2.0)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[2]), vec2(-1.0, 8.0)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[3]), vec2(1.0, 8.0)) && allOk;
	allOk = compare_vec4((t[3].b[0].c), vec4(4.0, 7.0, -5.0, -4.0)) && allOk;
	allOk = compare_uvec3((t[3].b[1].a), uvec3(3u, 8u, 5u)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[0]), vec2(3.0, -9.0)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[1]), vec2(4.0, -9.0)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[2]), vec2(8.0, 7.0)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[3]), vec2(-4.0, 3.0)) && allOk;
	allOk = compare_vec4((t[3].b[1].c), vec4(5.0, -5.0, -7.0, -3.0)) && allOk;
	allOk = compare_uvec3((t[3].b[2].a), uvec3(0u, 0u, 7u)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[0]), vec2(2.0, 7.0)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[1]), vec2(8.0, -1.0)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[2]), vec2(8.0, -8.0)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[3]), vec2(-3.0, 0.0)) && allOk;
	allOk = compare_vec4((t[3].b[2].c), vec4(-8.0, -2.0, -5.0, -2.0)) && allOk;
	allOk = compare_int((t[3].c), -5) && allOk;
    if (allOk)
        ac_numPassed++;

	s.a = (uvec3(0u, 3u, 2u));
	s.b[0] = (vec2(0.0, -9.0));
	s.b[1] = (vec2(6.0, 1.0));
	s.b[2] = (vec2(-9.0, -8.0));
	s.b[3] = (vec2(-6.0, 5.0));
	s.c = (vec4(4.0, -2.0, -8.0, 3.0));
	u = (3u);
}
#version 450
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
	highp mat2 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block[0].var[0][0], -2.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 3.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 2.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -3.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(-2.0, 3.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(2.0, -3.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 8.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 2.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 1.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 7.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(8.0, 2.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(1.0, 7.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 3.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 2.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 4.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 1.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(3.0, 2.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(4.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec2(5.0, -4.0));
	block[0].var[1] = (vec2(5.0, 1.0));
	block[1].var[0] = (vec2(-8.0, -1.0));
	block[1].var[1] = (vec2(9.0, -8.0));
	block[2].var[0] = (vec2(5.0, -4.0));
	block[2].var[1] = (vec2(5.0, -2.0));
}
#version 450
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
	allOk = compare_mat4(block[0].var, mat4(9.0, 0.0, -9.0, -9.0, 5.0, -4.0, 8.0, 7.0, 8.0, -4.0, -5.0, -7.0, 8.0, 9.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4(block[1].var, mat4(3.0, 4.0, 1.0, -3.0, 3.0, -2.0, -9.0, 6.0, -5.0, 3.0, 1.0, 3.0, -4.0, -9.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4(block[2].var, mat4(6.0, -8.0, 2.0, 0.0, -3.0, -8.0, 3.0, -7.0, 8.0, -5.0, -6.0, -1.0, -7.0, 5.0, -3.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat4(-3.0, -8.0, 5.0, -8.0, 8.0, -2.0, 8.0, 1.0, -9.0, 5.0, -7.0, -7.0, -5.0, -8.0, 9.0, -1.0));
	block[1].var = (mat4(1.0, 6.0, -3.0, 2.0, -1.0, -8.0, -2.0, 0.0, -9.0, 3.0, 5.0, -5.0, -1.0, 1.0, -5.0, -2.0));
	block[2].var = (mat4(1.0, -7.0, 1.0, 9.0, -4.0, 9.0, 7.0, 0.0, -4.0, -7.0, -9.0, -6.0, 0.0, -9.0, -8.0, -5.0));
}
#version 450
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
	f16vec2 var;
} block[3];

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

layout(std430, row_major, binding = 1) buffer Block
{
	highp mat3x4 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block[0].var[0][0], -3.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -9.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 3.0) && allOk;
	allOk = compare_float(block[0].var[0][3], -6.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -7.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 8.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -8.0) && allOk;
	allOk = compare_float(block[0].var[1][3], -5.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 9.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -8.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 2.0) && allOk;
	allOk = compare_float(block[0].var[2][3], 4.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(-3.0, -9.0, 3.0, -6.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(-7.0, 8.0, -8.0, -5.0)) && allOk;
	allOk = compare_vec4(block[0].var[2], vec4(9.0, -8.0, 2.0, 4.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 8.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -4.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 9.0) && allOk;
	allOk = compare_float(block[1].var[0][3], 7.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -8.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 9.0) && allOk;
	allOk = compare_float(block[1].var[1][2], -1.0) && allOk;
	allOk = compare_float(block[1].var[1][3], 0.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 9.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 7.0) && allOk;
	allOk = compare_float(block[1].var[2][2], 4.0) && allOk;
	allOk = compare_float(block[1].var[2][3], -6.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(8.0, -4.0, 9.0, 7.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(-8.0, 9.0, -1.0, 0.0)) && allOk;
	allOk = compare_vec4(block[1].var[2], vec4(9.0, 7.0, 4.0, -6.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], -3.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -6.0) && allOk;
	allOk = compare_float(block[2].var[0][2], -7.0) && allOk;
	allOk = compare_float(block[2].var[0][3], 8.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 1.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 5.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 1.0) && allOk;
	allOk = compare_float(block[2].var[1][3], -1.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 8.0) && allOk;
	allOk = compare_float(block[2].var[2][1], -9.0) && allOk;
	allOk = compare_float(block[2].var[2][2], 7.0) && allOk;
	allOk = compare_float(block[2].var[2][3], 3.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(-3.0, -6.0, -7.0, 8.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(1.0, 5.0, 1.0, -1.0)) && allOk;
	allOk = compare_vec4(block[2].var[2], vec4(8.0, -9.0, 7.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec4(-6.0, -4.0, 2.0, -3.0));
	block[0].var[1] = (vec4(-2.0, 4.0, -5.0, 8.0));
	block[0].var[2] = (vec4(-4.0, 6.0, -9.0, -9.0));
	block[1].var[0] = (vec4(0.0, 6.0, 0.0, 6.0));
	block[1].var[1] = (vec4(5.0, 2.0, 6.0, 6.0));
	block[1].var[2] = (vec4(-7.0, -6.0, -8.0, 0.0));
	block[2].var[0] = (vec4(3.0, -3.0, 6.0, -2.0));
	block[2].var[1] = (vec4(-8.0, -5.0, -5.0, 1.0));
	block[2].var[2] = (vec4(7.0, -8.0, -3.0, -2.0));
}
#version 450
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
	bool padding;
	bvec3 var;
} block[3];

bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((block[0].padding), true) && allOk;
	allOk = compare_bvec3((block[0].var), bvec3(true, true, false)) && allOk;
	allOk = compare_bool((block[1].padding), true) && allOk;
	allOk = compare_bvec3((block[1].var), bvec3(true, false, true)) && allOk;
	allOk = compare_bool((block[2].padding), false) && allOk;
	allOk = compare_bvec3((block[2].var), bvec3(false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (true);
	block[0].var = (bvec3(true, false, false));
	block[1].padding = (true);
	block[1].var = (bvec3(true, false, false));
	block[2].padding = (false);
	block[2].var = (bvec3(true, false, false));
}
#version 450
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
	allOk = compare_float((block[0].padding), 9.0) && allOk;
	allOk = compare_mat4(block[0].var, mat4(0.0, -9.0, -9.0, 5.0, -4.0, 8.0, 7.0, 8.0, -4.0, -5.0, -7.0, 8.0, 9.0, -2.0, 1.0, 3.0)) && allOk;
	allOk = compare_float((block[1].padding), 4.0) && allOk;
	allOk = compare_mat4(block[1].var, mat4(1.0, -3.0, 3.0, -2.0, -9.0, 6.0, -5.0, 3.0, 1.0, 3.0, -4.0, -9.0, 1.0, -2.0, 6.0, -8.0)) && allOk;
	allOk = compare_float((block[2].padding), 2.0) && allOk;
	allOk = compare_mat4(block[2].var, mat4(0.0, -3.0, -8.0, 3.0, -7.0, 8.0, -5.0, -6.0, -1.0, -7.0, 5.0, -3.0, 3.0, 8.0, -5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-3.0);
	block[0].var = (mat4(-8.0, 5.0, -8.0, 8.0, -2.0, 8.0, 1.0, -9.0, 5.0, -7.0, -7.0, -5.0, -8.0, 9.0, -1.0, 1.0));
	block[1].padding = (6.0);
	block[1].var = (mat4(-3.0, 2.0, -1.0, -8.0, -2.0, 0.0, -9.0, 3.0, 5.0, -5.0, -1.0, 1.0, -5.0, -2.0, 1.0, -7.0));
	block[2].padding = (1.0);
	block[2].var = (mat4(9.0, -4.0, 9.0, 7.0, 0.0, -4.0, -7.0, -9.0, -6.0, 0.0, -9.0, -8.0, -5.0, 2.0, 3.0, 0.0));
}
#version 450
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
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), -5.0) && allOk;
	allOk = compare_float(block[0].var[0][0], -2.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -4.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 7.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -9.0) && allOk;
	allOk = compare_float(block[0].var[2][0], -9.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -9.0) && allOk;
	allOk = compare_float(block[0].var[3][0], 1.0) && allOk;
	allOk = compare_float(block[0].var[3][1], -6.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(-2.0, -4.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(7.0, -9.0)) && allOk;
	allOk = compare_vec2(block[0].var[2], vec2(-9.0, -9.0)) && allOk;
	allOk = compare_vec2(block[0].var[3], vec2(1.0, -6.0)) && allOk;
	allOk = compare_float((block[1].padding), -1.0) && allOk;
	allOk = compare_float(block[1].var[0][0], -5.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -9.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -2.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -2.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 2.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -5.0) && allOk;
	allOk = compare_float(block[1].var[3][0], -3.0) && allOk;
	allOk = compare_float(block[1].var[3][1], -8.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(-5.0, -9.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(-2.0, -2.0)) && allOk;
	allOk = compare_vec2(block[1].var[2], vec2(2.0, -5.0)) && allOk;
	allOk = compare_vec2(block[1].var[3], vec2(-3.0, -8.0)) && allOk;
	allOk = compare_float((block[2].padding), -8.0) && allOk;
	allOk = compare_float(block[2].var[0][0], 1.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 3.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 0.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -3.0) && allOk;
	allOk = compare_float(block[2].var[2][0], -9.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 0.0) && allOk;
	allOk = compare_float(block[2].var[3][0], -7.0) && allOk;
	allOk = compare_float(block[2].var[3][1], -1.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(1.0, 3.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(0.0, -3.0)) && allOk;
	allOk = compare_vec2(block[2].var[2], vec2(-9.0, 0.0)) && allOk;
	allOk = compare_vec2(block[2].var[3], vec2(-7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (0.0);
	block[0].var = (mat4x2(-3.0, -2.0, 2.0, -2.0, -3.0, 5.0, -5.0, 5.0));
	block[1].padding = (-6.0);
	block[1].var = (mat4x2(-4.0, -1.0, 4.0, 7.0, -8.0, -2.0, -5.0, -1.0));
	block[2].padding = (-3.0);
	block[2].var = (mat4x2(6.0, -2.0, 0.0, -7.0, -7.0, 2.0, 0.0, -6.0));
}
#version 450
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
	highp float b;
	lowp int c[1];
	mediump uint d;
	mediump int e;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.c[0]), -8) && allOk;
	allOk = compare_uint((blockB.d), 9u) && allOk;
	allOk = compare_int((blockB.e), -5) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (-9.0);
	blockB.c[0] = (-7);
	blockB.d = (9u);
	blockB.e = (-1);
}
#version 450
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
	mediump uvec3 a[];
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	a[0] = (uvec3(5u, 2u, 5u));
	a[1] = (uvec3(7u, 0u, 4u));
	a[2] = (uvec3(9u, 0u, 5u));
	a[3] = (uvec3(8u, 1u, 5u));
	a[4] = (uvec3(2u, 0u, 2u));
	a[5] = (uvec3(7u, 3u, 6u));
	a[6] = (uvec3(7u, 5u, 3u));
	a[7] = (uvec3(1u, 2u, 9u));
}
#version 450
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
	lowp vec2 a[];
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	lowp mat2 b;
	mediump uvec2 c;
	bvec2 d;
	bvec2 e;
	bvec2 f;
} blockC;
layout(std140, row_major, binding = 3) buffer BlockD
{
	lowp mat4 g;
	bvec2 h;
	mediump mat4 i[];
};
layout(std430, row_major, binding = 4) buffer BlockE
{
	mediump uint j;
	lowp float k[];
} blockE[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a[0]), vec2(2.0, -8.0)) && allOk;
	allOk = compare_vec2((blockB.a[1]), vec2(-4.0, 7.0)) && allOk;
	allOk = compare_vec2((blockB.a[2]), vec2(4.0, 0.0)) && allOk;
	allOk = compare_vec2((blockB.a[3]), vec2(-5.0, -8.0)) && allOk;
	allOk = compare_vec2((blockB.a[4]), vec2(-6.0, 4.0)) && allOk;
	allOk = compare_vec2((blockB.a[5]), vec2(5.0, 6.0)) && allOk;
	allOk = compare_vec2((blockB.a[6]), vec2(-6.0, 1.0)) && allOk;
	allOk = compare_uvec2((blockC.c), uvec2(1u, 4u)) && allOk;
	allOk = compare_bvec2((blockC.d), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockC.e), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockC.f), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((h), bvec2(true, false)) && allOk;
	allOk = compare_mat4(i[0], mat4(5.0, -7.0, 7.0, 5.0, -1.0, -7.0, 2.0, 3.0, 1.0, 7.0, 9.0, -6.0, 7.0, 6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4(i[1], mat4(6.0, -3.0, 5.0, 3.0, 9.0, -3.0, -2.0, 2.0, -5.0, -1.0, -1.0, -2.0, 1.0, -9.0, -4.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (vec2(8.0, -2.0));
	blockB.a[1] = (vec2(-1.0, -6.0));
	blockB.a[2] = (vec2(6.0, 0.0));
	blockB.a[3] = (vec2(9.0, 5.0));
	blockB.a[4] = (vec2(4.0, 8.0));
	blockB.a[5] = (vec2(6.0, 7.0));
	blockB.a[6] = (vec2(-5.0, 5.0));
	blockC.b = (mat2(-2.0, 4.0, 7.0, 7.0));
	blockC.c = (uvec2(9u, 6u));
	blockC.d = (bvec2(true, false));
	blockC.e = (bvec2(false, false));
	blockC.f = (bvec2(true, false));
	h = (bvec2(true, false));
	blockE[0].k[0] = (-5.0);
	blockE[0].k[1] = (-4.0);
	blockE[0].k[2] = (3.0);
	blockE[1].k[0] = (-2.0);
	blockE[1].k[1] = (0.0);
	blockE[1].k[2] = (-5.0);
	blockE[1].k[3] = (2.0);
}
#version 450
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
	lowp vec2 mA;
	highp vec3 mB;
	highp float mC;
	mediump mat3 mD;
};
struct sB
{
	mediump uvec3 mA;
	mediump mat2x3 mB;
	bool mC;
};
layout(std140, binding = 1) buffer BlockB
{
	sA a;
	mediump mat3 b;
	mediump mat2 c;
	bvec2 d;
	highp mat3 e[];
} blockB[3];
layout(std430, row_major, binding = 2) buffer BlockC
{
	mediump ivec2 f;
};
layout(std430, column_major, binding = 3) buffer BlockD
{
	lowp ivec3 g;
	sB h;
	highp mat4 i;
	highp ivec3 j[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB[0].a.mA), vec2(0.0, 7.0)) && allOk;
	allOk = compare_vec3((blockB[0].a.mB), vec3(4.0, -8.0, -2.0)) && allOk;
	allOk = compare_float((blockB[0].a.mC), -7.0) && allOk;
	allOk = compare_mat3(blockB[0].a.mD, mat3(1.0, 0.0, 5.0, 7.0, -2.0, -5.0, -1.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat2(blockB[0].c, mat2(0.0, 9.0, 1.0, -3.0)) && allOk;
	allOk = compare_bvec2((blockB[0].d), bvec2(true, false)) && allOk;
	allOk = compare_mat3(blockB[0].e[0], mat3(9.0, 3.0, 1.0, -2.0, 9.0, 6.0, -3.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3(blockB[0].e[1], mat3(6.0, -3.0, -6.0, -4.0, 2.0, -7.0, 7.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3(blockB[0].e[2], mat3(6.0, -3.0, -3.0, 9.0, 3.0, 2.0, -8.0, -7.0, -6.0)) && allOk;
	allOk = compare_vec2((blockB[1].a.mA), vec2(-6.0, -3.0)) && allOk;
	allOk = compare_vec3((blockB[1].a.mB), vec3(4.0, -2.0, -6.0)) && allOk;
	allOk = compare_float((blockB[1].a.mC), -8.0) && allOk;
	allOk = compare_mat3(blockB[1].a.mD, mat3(-6.0, -2.0, 2.0, -1.0, 8.0, -8.0, -2.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(blockB[1].c, mat2(-5.0, 5.0, 9.0, -8.0)) && allOk;
	allOk = compare_bvec2((blockB[1].d), bvec2(true, false)) && allOk;
	allOk = compare_mat3(blockB[1].e[0], mat3(-2.0, 9.0, 3.0, -3.0, -8.0, -5.0, -1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat3(blockB[1].e[1], mat3(-4.0, 2.0, -8.0, 2.0, -3.0, 1.0, 2.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3(blockB[1].e[2], mat3(-2.0, 9.0, 2.0, 4.0, 8.0, -8.0, 3.0, -8.0, -7.0)) && allOk;
	allOk = compare_vec2((blockB[2].a.mA), vec2(3.0, -3.0)) && allOk;
	allOk = compare_vec3((blockB[2].a.mB), vec3(3.0, -6.0, -4.0)) && allOk;
	allOk = compare_float((blockB[2].a.mC), -8.0) && allOk;
	allOk = compare_mat3(blockB[2].a.mD, mat3(-7.0, 6.0, -5.0, 9.0, 6.0, 4.0, -4.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat2(blockB[2].c, mat2(4.0, 3.0, 1.0, -3.0)) && allOk;
	allOk = compare_bvec2((blockB[2].d), bvec2(true, true)) && allOk;
	allOk = compare_mat3(blockB[2].e[0], mat3(-1.0, -8.0, 5.0, 7.0, 6.0, 6.0, 6.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3(blockB[2].e[1], mat3(-5.0, 0.0, 1.0, -8.0, 9.0, 4.0, 8.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat3(blockB[2].e[2], mat3(4.0, 5.0, -9.0, -7.0, -2.0, 0.0, 8.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3(blockB[2].e[3], mat3(1.0, 7.0, 7.0, 8.0, -6.0, 7.0, 8.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat3(blockB[2].e[4], mat3(-6.0, 0.0, -7.0, 9.0, 6.0, -1.0, 8.0, -2.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a.mA = (vec2(6.0, -8.0));
	blockB[0].a.mB = (vec3(-5.0, -5.0, 8.0));
	blockB[0].a.mC = (-6.0);
	blockB[0].a.mD = (mat3(-1.0, -8.0, -8.0, -6.0, 1.0, -2.0, 4.0, 9.0, -9.0));
	blockB[0].b = (mat3(-5.0, 8.0, 3.0, -1.0, 7.0, -2.0, -7.0, -4.0, -2.0));
	blockB[0].c = (mat2(0.0, -2.0, -6.0, 1.0));
	blockB[0].d = (bvec2(false, true));
	blockB[0].e[0] = (mat3(-5.0, -8.0, -3.0, -5.0, 0.0, -9.0, -5.0, -5.0, 3.0));
	blockB[0].e[1] = (mat3(8.0, 3.0, 1.0, 2.0, -5.0, 2.0, 9.0, 3.0, -6.0));
	blockB[0].e[2] = (mat3(-6.0, -8.0, 5.0, -8.0, 4.0, -1.0, -9.0, -7.0, 3.0));
	blockB[1].a.mA = (vec2(7.0, -2.0));
	blockB[1].a.mB = (vec3(-8.0, 9.0, 0.0));
	blockB[1].a.mC = (-8.0);
	blockB[1].a.mD = (mat3(-2.0, -5.0, -7.0, 8.0, 0.0, 8.0, 6.0, 1.0, 1.0));
	blockB[1].b = (mat3(9.0, 8.0, 4.0, 3.0, 8.0, -2.0, -2.0, -9.0, -8.0));
	blockB[1].c = (mat2(5.0, 0.0, -9.0, 5.0));
	blockB[1].d = (bvec2(false, true));
	blockB[1].e[0] = (mat3(7.0, 7.0, 9.0, -4.0, 7.0, 9.0, 7.0, 7.0, 5.0));
	blockB[1].e[1] = (mat3(2.0, -7.0, 8.0, 4.0, -2.0, -4.0, 1.0, 7.0, -2.0));
	blockB[1].e[2] = (mat3(0.0, 5.0, -7.0, 4.0, -1.0, 7.0, -5.0, -9.0, 3.0));
	blockB[2].a.mA = (vec2(9.0, -1.0));
	blockB[2].a.mB = (vec3(-6.0, 2.0, 9.0));
	blockB[2].a.mC = (-5.0);
	blockB[2].a.mD = (mat3(6.0, 0.0, -3.0, 2.0, -7.0, 9.0, -8.0, 3.0, -1.0));
	blockB[2].b = (mat3(-4.0, -2.0, -8.0, 0.0, -1.0, -6.0, -8.0, -9.0, 0.0));
	blockB[2].c = (mat2(-4.0, 9.0, 6.0, -2.0));
	blockB[2].d = (bvec2(false, true));
	blockB[2].e[0] = (mat3(5.0, 0.0, -3.0, -1.0, 0.0, -5.0, 3.0, -2.0, -9.0));
	blockB[2].e[1] = (mat3(2.0, -4.0, 4.0, -1.0, 6.0, -2.0, 2.0, 4.0, 5.0));
	blockB[2].e[2] = (mat3(5.0, 6.0, -1.0, 2.0, 3.0, 9.0, 1.0, -1.0, 2.0));
	blockB[2].e[3] = (mat3(4.0, 3.0, 9.0, 8.0, 9.0, 4.0, -4.0, -8.0, 4.0));
	blockB[2].e[4] = (mat3(1.0, 5.0, -4.0, -8.0, 7.0, -6.0, 7.0, 6.0, 4.0));
	f = (ivec2(-1, 7));
	blockD.g = (ivec3(9, 7, -4));
	blockD.i = (mat4(2.0, -3.0, -7.0, -1.0, 4.0, 3.0, -9.0, -4.0, 3.0, 5.0, -5.0, 4.0, -4.0, -4.0, 9.0, -2.0));
}
#version 450
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
	layout(offset = 0) lowp uvec3 a;
	layout(offset = 16) lowp vec4 b;
	layout(offset = 32) highp ivec4 c;
	layout(offset = 48) bvec2 d;
	layout(offset = 64) mediump uvec3 e;
} blockB[2];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump int f;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB[0].a), uvec3(5u, 4u, 9u)) && allOk;
	allOk = compare_ivec4((blockB[0].c), ivec4(6, -1, 5, -9)) && allOk;
	allOk = compare_bvec2((blockB[0].d), bvec2(true, true)) && allOk;
	allOk = compare_uvec3((blockB[0].e), uvec3(6u, 7u, 2u)) && allOk;
	allOk = compare_uvec3((blockB[1].a), uvec3(9u, 1u, 2u)) && allOk;
	allOk = compare_ivec4((blockB[1].c), ivec4(-7, -2, 9, 8)) && allOk;
	allOk = compare_bvec2((blockB[1].d), bvec2(true, false)) && allOk;
	allOk = compare_uvec3((blockB[1].e), uvec3(9u, 6u, 5u)) && allOk;
	allOk = compare_int((blockC.f), 7) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (uvec3(3u, 1u, 6u));
	blockB[0].b = (vec4(-2.0, 2.0, -7.0, 4.0));
	blockB[0].c = (ivec4(6, -8, 8, -3));
	blockB[0].d = (bvec2(false, false));
	blockB[0].e = (uvec3(6u, 0u, 2u));
	blockB[1].a = (uvec3(3u, 6u, 3u));
	blockB[1].b = (vec4(-2.0, 2.0, -3.0, -9.0));
	blockB[1].c = (ivec4(-5, 3, 5, -5));
	blockB[1].d = (bvec2(true, true));
	blockB[1].e = (uvec3(3u, 2u, 9u));
	blockC.f = (-3);
}
#version 450
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
	layout(offset = 0) highp vec3 a[1];
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) lowp uint b;
	layout(offset = 16) lowp ivec4 c[1];
} blockC[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockC[0].b), 0u) && allOk;
	allOk = compare_ivec4((blockC[0].c[0]), ivec4(-1, -5, 5, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (vec3(2.0, -9.0, 2.0));
	blockC[0].c[0] = (ivec4(3, 5, -9, -4));
}
#version 450
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
	layout(offset = 16) lowp vec3 b;
	layout(offset = 32) highp vec2 c;
	layout(offset = 40) highp uint d[1];
} blockB[3];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) highp int e;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB[0].b), vec3(4.0, 6.0, 6.0)) && allOk;
	allOk = compare_vec3((blockB[1].b), vec3(9.0, -8.0, 5.0)) && allOk;
	allOk = compare_vec3((blockB[2].b), vec3(2.0, -4.0, -2.0)) && allOk;
	allOk = compare_int((e), -5) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (bvec3(true, false, true));
	blockB[0].c = (vec2(6.0, 9.0));
	blockB[0].d[0] = (2u);
	blockB[1].a = (bvec3(true, false, false));
	blockB[1].c = (vec2(8.0, -4.0));
	blockB[1].d[0] = (1u);
	blockB[2].a = (bvec3(true, true, false));
	blockB[2].c = (vec2(-3.0, -8.0));
	blockB[2].d[0] = (4u);
	e = (-8);
}
#version 450
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
	layout(offset = 0) lowp uint a;
	layout(offset = 4) lowp ivec3 b;
	layout(offset = 16) mediump int c;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) highp vec3 d;
	layout(offset = 16) mediump ivec2 e;
	layout(offset = 24) bool f;
	layout(offset = 28) lowp int g;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 7u) && allOk;
	allOk = compare_vec3((d), vec3(-7.0, 7.0, 6.0)) && allOk;
	allOk = compare_ivec2((e), ivec2(-3, 5)) && allOk;
	allOk = compare_bool((f), true) && allOk;
	allOk = compare_int((g), -5) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (7u);
	blockB.b = (ivec3(0, 2, 0));
	blockB.c = (8);
	e = (ivec2(8, -6));
	f = (false);
	g = (-1);
}
#version 450
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
	bvec3 mB;
};
struct sB
{
	mediump mat4x3 mA;
	bool mB;
	lowp mat2 mC;
	lowp vec3 mD;
};
struct sC
{
	bvec3 mA;
	mediump mat2x3 mB;
	lowp mat4x3 mC;
	lowp mat3x2 mD;
};
struct sD
{
	lowp mat4x2 mA;
	sC mB;
};
layout(scalar, row_major, binding = 1) buffer BlockB
{
	mediump mat2 a[8];
	highp uvec2 b;
	mediump mat2x3 c;
	lowp float d;
	sA e[];
};
layout(scalar, binding = 2) buffer BlockC
{
	bvec4 f;
	mediump uvec3 g[];
};
layout(scalar, row_major, binding = 3) buffer BlockD
{
	sB h;
	mediump mat4 i;
	sD j;
	mediump mat4 k;
	lowp mat3 l;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(a[0], mat2(0.0, 3.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat2(a[1], mat2(0.0, 1.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat2(a[2], mat2(-2.0, 3.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2(a[3], mat2(2.0, 3.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat2(a[4], mat2(5.0, -2.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat2(a[5], mat2(6.0, 7.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat2(a[6], mat2(-9.0, 8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2(a[7], mat2(4.0, -4.0, -4.0, 1.0)) && allOk;
	allOk = compare_uvec2((b), uvec2(1u, 3u)) && allOk;
	allOk = compare_mat2x3(c, mat2x3(6.0, -2.0, 1.0, -9.0, -2.0, 7.0)) && allOk;
	allOk = compare_float((d), -4.0) && allOk;
	allOk = compare_uvec3((g[0]), uvec3(6u, 4u, 1u)) && allOk;
	allOk = compare_uvec3((g[1]), uvec3(5u, 5u, 9u)) && allOk;
	allOk = compare_uvec3((g[2]), uvec3(0u, 8u, 8u)) && allOk;
	allOk = compare_uvec3((g[3]), uvec3(1u, 5u, 4u)) && allOk;
	allOk = compare_uvec3((g[4]), uvec3(7u, 1u, 5u)) && allOk;
	allOk = compare_uvec3((g[5]), uvec3(7u, 2u, 3u)) && allOk;
	allOk = compare_mat4(blockD.i, mat4(3.0, 6.0, -4.0, 7.0, -7.0, 6.0, 3.0, 7.0, -5.0, -2.0, -5.0, 1.0, 9.0, 2.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat4x2(blockD.j.mA, mat4x2(9.0, 8.0, -4.0, 8.0, -8.0, 0.0, 4.0, -8.0)) && allOk;
	allOk = compare_bvec3((blockD.j.mB.mA), bvec3(true, false, false)) && allOk;
	allOk = compare_mat2x3(blockD.j.mB.mB, mat2x3(9.0, 2.0, -1.0, 6.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat4x3(blockD.j.mB.mC, mat4x3(4.0, -4.0, 9.0, -5.0, 2.0, 0.0, 7.0, 8.0, -6.0, 7.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3x2(blockD.j.mB.mD, mat3x2(-3.0, -7.0, 8.0, -2.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4(blockD.k, mat4(2.0, -1.0, 7.0, 5.0, 6.0, 1.0, 8.0, 5.0, -1.0, 4.0, 4.0, 5.0, 3.0, -4.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3(blockD.l, mat3(-3.0, -2.0, 9.0, 9.0, 4.0, -1.0, 4.0, -6.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (mat2(5.0, 3.0, -5.0, 9.0));
	a[1] = (mat2(-5.0, 0.0, -5.0, -1.0));
	a[2] = (mat2(-9.0, -4.0, 2.0, -8.0));
	a[3] = (mat2(-4.0, 6.0, 8.0, -3.0));
	a[4] = (mat2(-7.0, -2.0, -4.0, -9.0));
	a[5] = (mat2(-8.0, 9.0, -5.0, -1.0));
	a[6] = (mat2(1.0, 9.0, 7.0, -8.0));
	a[7] = (mat2(-6.0, 8.0, 4.0, -8.0));
	c = (mat2x3(-9.0, 6.0, 3.0, 5.0, 1.0, 0.0));
	e[0].mA = (uvec2(1u, 6u));
	e[0].mB = (bvec3(false, true, true));
	e[1].mA = (uvec2(0u, 9u));
	e[1].mB = (bvec3(false, false, true));
	f = (bvec4(true, false, true, true));
	g[0] = (uvec3(6u, 1u, 0u));
	g[1] = (uvec3(8u, 8u, 3u));
	g[2] = (uvec3(1u, 9u, 2u));
	g[3] = (uvec3(0u, 3u, 5u));
	g[4] = (uvec3(3u, 2u, 6u));
	g[5] = (uvec3(6u, 6u, 1u));
	blockD.l = (mat3(3.0, 4.0, 3.0, 0.0, -1.0, -4.0, 4.0, 6.0, 0.0));
}
#version 450
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
	mediump uvec2 a;
	mediump uvec3 b;
	highp mat4x2 c;
	highp mat2 d;
};
layout(scalar, row_major, binding = 2) buffer BlockC
{
	bvec2 e[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(c, mat4x2(-8.0, 5.0, 2.0, -7.0, -9.0, 4.0, 4.0, 0.0)) && allOk;
	allOk = compare_bvec2((blockC.e[0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockC.e[1]), bvec2(true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (uvec2(5u, 2u));
	c = (mat4x2(3.0, 0.0, -7.0, 6.0, -7.0, -9.0, 6.0, -2.0));
	d = (mat2(-5.0, -5.0, -3.0, -1.0));
	blockC.e[0] = (bvec2(true, true));
	blockC.e[1] = (bvec2(false, true));
}
#version 450
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
	mediump uvec3 a[8];
	highp uvec3 b[];
} blockB[2];
layout(scalar, binding = 2) buffer BlockC
{
	lowp uvec3 c;
	lowp vec4 d[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB[0].a[0]), uvec3(3u, 1u, 1u)) && allOk;
	allOk = compare_uvec3((blockB[0].a[1]), uvec3(9u, 6u, 1u)) && allOk;
	allOk = compare_uvec3((blockB[0].a[2]), uvec3(8u, 4u, 6u)) && allOk;
	allOk = compare_uvec3((blockB[0].a[3]), uvec3(4u, 8u, 2u)) && allOk;
	allOk = compare_uvec3((blockB[0].a[4]), uvec3(6u, 1u, 7u)) && allOk;
	allOk = compare_uvec3((blockB[0].a[5]), uvec3(3u, 2u, 6u)) && allOk;
	allOk = compare_uvec3((blockB[0].a[6]), uvec3(0u, 0u, 7u)) && allOk;
	allOk = compare_uvec3((blockB[0].a[7]), uvec3(6u, 7u, 0u)) && allOk;
	allOk = compare_uvec3((blockB[1].a[0]), uvec3(2u, 5u, 6u)) && allOk;
	allOk = compare_uvec3((blockB[1].a[1]), uvec3(2u, 8u, 3u)) && allOk;
	allOk = compare_uvec3((blockB[1].a[2]), uvec3(1u, 9u, 1u)) && allOk;
	allOk = compare_uvec3((blockB[1].a[3]), uvec3(3u, 9u, 2u)) && allOk;
	allOk = compare_uvec3((blockB[1].a[4]), uvec3(8u, 1u, 6u)) && allOk;
	allOk = compare_uvec3((blockB[1].a[5]), uvec3(4u, 5u, 4u)) && allOk;
	allOk = compare_uvec3((blockB[1].a[6]), uvec3(2u, 8u, 5u)) && allOk;
	allOk = compare_uvec3((blockB[1].a[7]), uvec3(3u, 2u, 4u)) && allOk;
	allOk = compare_vec4((d[0]), vec4(0.0, 9.0, -8.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b[0] = (uvec3(8u, 6u, 1u));
	blockB[0].b[1] = (uvec3(8u, 0u, 0u));
	blockB[0].b[2] = (uvec3(0u, 0u, 3u));
	blockB[0].b[3] = (uvec3(4u, 5u, 7u));
	blockB[0].b[4] = (uvec3(3u, 8u, 1u));
	blockB[0].b[5] = (uvec3(8u, 7u, 6u));
	blockB[0].b[6] = (uvec3(1u, 3u, 3u));
	blockB[0].b[7] = (uvec3(0u, 3u, 6u));
	blockB[1].b[0] = (uvec3(8u, 3u, 8u));
	c = (uvec3(2u, 5u, 8u));
	d[0] = (vec4(3.0, 3.0, 6.0, 2.0));
}
#version 450
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
	bvec3 mB;
	lowp mat2 mC;
	mediump uvec4 mD;
};
layout(scalar, binding = 1) buffer BlockB
{
	lowp mat3x2 a;
	sA b;
	mediump ivec2 c;
	highp mat3 d;
	mediump mat4x3 e;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.a, mat3x2(9.0, -1.0, -5.0, -3.0, 2.0, 0.0)) && allOk;
	allOk = compare_ivec2((blockB.c), ivec2(-9, -5)) && allOk;
	allOk = compare_mat3(blockB.d, mat3(2.0, -2.0, -4.0, -2.0, -7.0, 3.0, 8.0, -5.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (ivec2(2, 4));
	blockB.d = (mat3(-9.0, -3.0, 8.0, 8.0, -4.0, -8.0, -1.0, -7.0, 4.0));
	blockB.e = (mat4x3(8.0, 5.0, 2.0, -7.0, 3.0, -9.0, -3.0, -9.0, 8.0, -3.0, 4.0, -9.0));
}
#version 450
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
	highp ivec4 mA;
};
struct sB
{
	highp mat3 mA;
	highp mat2 mB;
	mediump uvec3 mC;
};
struct sC
{
	highp vec2 mA;
	mediump uvec2 mB;
};
struct sD
{
	mediump ivec4 mA;
	mediump mat3 mB[8];
	lowp mat3x2 mC;
	sC mD;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	bool a;
	sA b;
	sB c;
	mediump ivec4 d[];
} blockB;
layout(scalar, row_major, binding = 2) buffer BlockC
{
	mediump uvec4 e;
	lowp mat3x2 f;
	highp ivec3 g;
	lowp vec4 h[];
};
layout(scalar, binding = 3) buffer BlockD
{
	mediump mat2x3 i;
	mediump vec3 j;
	mediump float k;
	sD l;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a), true) && allOk;
	allOk = compare_ivec4((blockB.b.mA), ivec4(3, 0, -5, -3)) && allOk;
	allOk = compare_mat3(blockB.c.mA, mat3(9.0, 4.0, 6.0, 2.0, 7.0, 1.0, -4.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2(blockB.c.mB, mat2(-6.0, 0.0, 3.0, 0.0)) && allOk;
	allOk = compare_uvec3((blockB.c.mC), uvec3(1u, 6u, 4u)) && allOk;
	allOk = compare_ivec4((blockB.d[0]), ivec4(2, 5, 7, 2)) && allOk;
	allOk = compare_ivec4((blockB.d[1]), ivec4(9, 8, -4, 7)) && allOk;
	allOk = compare_ivec4((blockB.d[2]), ivec4(8, 2, 3, 4)) && allOk;
	allOk = compare_ivec4((blockB.d[3]), ivec4(-2, -8, -7, 4)) && allOk;
	allOk = compare_ivec4((blockB.d[4]), ivec4(-9, 3, -9, 4)) && allOk;
	allOk = compare_ivec4((blockB.d[5]), ivec4(2, 2, -5, -9)) && allOk;
	allOk = compare_ivec4((blockB.d[6]), ivec4(-4, 5, 3, 7)) && allOk;
	allOk = compare_ivec4((blockB.d[7]), ivec4(4, 8, -8, -6)) && allOk;
	allOk = compare_uvec4((e), uvec4(4u, 0u, 1u, 9u)) && allOk;
	allOk = compare_mat3x2(f, mat3x2(-4.0, 7.0, -4.0, 5.0, -5.0, 6.0)) && allOk;
	allOk = compare_ivec3((g), ivec3(0, -2, 0)) && allOk;
	allOk = compare_mat2x3(blockD.i, mat2x3(-6.0, 1.0, 5.0, 5.0, -1.0, -4.0)) && allOk;
	allOk = compare_float((blockD.k), -9.0) && allOk;
	allOk = compare_ivec4((blockD.l.mA), ivec4(8, -3, 5, 9)) && allOk;
	allOk = compare_mat3(blockD.l.mB[0], mat3(-5.0, -3.0, 1.0, -3.0, 9.0, 8.0, -8.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat3(blockD.l.mB[1], mat3(6.0, 4.0, -3.0, -6.0, 1.0, 3.0, 9.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat3(blockD.l.mB[2], mat3(-4.0, 3.0, -4.0, -9.0, -4.0, -7.0, 2.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat3(blockD.l.mB[3], mat3(-4.0, 2.0, 4.0, 0.0, 4.0, 5.0, 2.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat3(blockD.l.mB[4], mat3(5.0, -2.0, -4.0, 9.0, -7.0, -7.0, -5.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3(blockD.l.mB[5], mat3(9.0, -6.0, 6.0, -6.0, -3.0, 9.0, 0.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3(blockD.l.mB[6], mat3(3.0, -7.0, 2.0, 9.0, 0.0, 7.0, 8.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3(blockD.l.mB[7], mat3(-9.0, 2.0, 8.0, 3.0, 2.0, -4.0, -1.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat3x2(blockD.l.mC, mat3x2(-5.0, 7.0, -2.0, 2.0, -4.0, -4.0)) && allOk;
	allOk = compare_vec2((blockD.l.mD.mA), vec2(-5.0, 6.0)) && allOk;
	allOk = compare_uvec2((blockD.l.mD.mB), uvec2(8u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
	blockB.b.mA = (ivec4(-9, -4, 6, 4));
	blockB.d[0] = (ivec4(-3, -2, -4, -1));
	blockB.d[1] = (ivec4(4, 8, 8, 7));
	blockB.d[2] = (ivec4(-1, -3, 1, 7));
	blockB.d[3] = (ivec4(1, 9, 0, -1));
	blockB.d[4] = (ivec4(4, 4, 5, -3));
	blockB.d[5] = (ivec4(0, -6, 9, 2));
	blockB.d[6] = (ivec4(-9, 5, 6, 0));
	blockB.d[7] = (ivec4(-6, -8, 4, -1));
	g = (ivec3(4, 0, 5));
	h[0] = (vec4(-5.0, -5.0, 9.0, 5.0));
	h[1] = (vec4(-1.0, 7.0, -7.0, -3.0));
	h[2] = (vec4(8.0, -9.0, 9.0, 3.0));
	h[3] = (vec4(-6.0, 4.0, 1.0, 6.0));
	h[4] = (vec4(-8.0, 8.0, 3.0, 5.0));
	h[5] = (vec4(7.0, -5.0, 9.0, -3.0));
	h[6] = (vec4(-5.0, -2.0, -7.0, 0.0));
	blockD.i = (mat2x3(0.0, -3.0, -1.0, -8.0, -8.0, 5.0));
	blockD.k = (-1.0);
	blockD.l.mA = (ivec4(8, 7, 0, -1));
	blockD.l.mB[0] = (mat3(2.0, -5.0, 0.0, 2.0, -8.0, 1.0, 4.0, -2.0, 3.0));
	blockD.l.mB[1] = (mat3(1.0, 5.0, 0.0, 1.0, 7.0, -8.0, 7.0, -8.0, -4.0));
	blockD.l.mB[2] = (mat3(-2.0, -9.0, 2.0, 4.0, -7.0, 2.0, 0.0, -5.0, -1.0));
	blockD.l.mB[3] = (mat3(-5.0, -4.0, 8.0, 0.0, -1.0, -4.0, 3.0, -8.0, -7.0));
	blockD.l.mB[4] = (mat3(6.0, 3.0, 1.0, -7.0, -5.0, 2.0, -6.0, 7.0, -1.0));
	blockD.l.mB[5] = (mat3(-9.0, 9.0, 8.0, -9.0, 6.0, 0.0, 6.0, -4.0, 3.0));
	blockD.l.mB[6] = (mat3(-9.0, 5.0, -2.0, 9.0, 5.0, -5.0, -6.0, -2.0, 0.0));
	blockD.l.mB[7] = (mat3(8.0, -3.0, -5.0, 9.0, 5.0, -1.0, 7.0, 6.0, 5.0));
	blockD.l.mC = (mat3x2(-8.0, -3.0, 6.0, -4.0, -5.0, -1.0));
	blockD.l.mD.mA = (vec2(6.0, -5.0));
	blockD.l.mD.mB = (uvec2(4u, 0u));
}
#version 450
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
	highp vec3 mA;
	bvec4 mB;
	lowp mat4x2 mC;
};
struct sB
{
	highp mat3x2 mA;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	bvec4 a;
	lowp mat2x3 b;
	highp uvec2 c[];
} blockB;
layout(scalar, binding = 2) buffer BlockC
{
	highp mat2 d;
	highp ivec2 e;
	mediump ivec3 f;
	highp uvec4 g;
} blockC[3];
layout(scalar, row_major, binding = 3) buffer BlockD
{
	sA h[7];
	lowp vec4 i;
	lowp mat2x3 j;
};
layout(scalar, row_major, binding = 4) buffer BlockE
{
	mediump uvec3 k;
	sB l[6][4][2];
	mediump uint m;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, false, false, false)) && allOk;
	allOk = compare_mat2x3(blockB.b, mat2x3(-5.0, 5.0, 8.0, -2.0, -7.0, -1.0)) && allOk;
	allOk = compare_uvec2((blockB.c[0]), uvec2(1u, 5u)) && allOk;
	allOk = compare_uvec2((blockB.c[1]), uvec2(0u, 2u)) && allOk;
	allOk = compare_uvec2((blockB.c[2]), uvec2(7u, 2u)) && allOk;
	allOk = compare_ivec2((blockC[0].e), ivec2(-6, -6)) && allOk;
	allOk = compare_ivec3((blockC[0].f), ivec3(7, 2, 1)) && allOk;
	allOk = compare_uvec4((blockC[0].g), uvec4(0u, 5u, 7u, 9u)) && allOk;
	allOk = compare_ivec2((blockC[1].e), ivec2(-8, 5)) && allOk;
	allOk = compare_ivec3((blockC[1].f), ivec3(-3, -3, -9)) && allOk;
	allOk = compare_uvec4((blockC[1].g), uvec4(5u, 2u, 2u, 3u)) && allOk;
	allOk = compare_ivec2((blockC[2].e), ivec2(-6, 4)) && allOk;
	allOk = compare_ivec3((blockC[2].f), ivec3(1, -4, -1)) && allOk;
	allOk = compare_uvec4((blockC[2].g), uvec4(7u, 4u, 9u, 3u)) && allOk;
	allOk = compare_vec4((i), vec4(2.0, 2.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat2x3(j, mat2x3(8.0, -3.0, -5.0, -1.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(l[0][0][0].mA, mat3x2(-2.0, -2.0, 4.0, -2.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3x2(l[0][0][1].mA, mat3x2(5.0, -5.0, 6.0, 2.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat3x2(l[0][1][0].mA, mat3x2(-8.0, -4.0, -9.0, 0.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat3x2(l[0][1][1].mA, mat3x2(9.0, -8.0, -5.0, 7.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3x2(l[0][2][0].mA, mat3x2(-3.0, 9.0, 4.0, -5.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat3x2(l[0][2][1].mA, mat3x2(-5.0, -8.0, 7.0, -7.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(l[0][3][0].mA, mat3x2(-2.0, -8.0, 9.0, -9.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3x2(l[0][3][1].mA, mat3x2(4.0, -6.0, -5.0, -8.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(l[1][0][0].mA, mat3x2(-2.0, -6.0, -6.0, 1.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat3x2(l[1][0][1].mA, mat3x2(-7.0, -9.0, -5.0, -7.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat3x2(l[1][1][0].mA, mat3x2(-8.0, -6.0, 4.0, -2.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3x2(l[1][1][1].mA, mat3x2(-3.0, -7.0, 2.0, 1.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(l[1][2][0].mA, mat3x2(6.0, -4.0, -1.0, 5.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat3x2(l[1][2][1].mA, mat3x2(-6.0, 8.0, -6.0, 6.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat3x2(l[1][3][0].mA, mat3x2(-1.0, 2.0, 8.0, 2.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(l[1][3][1].mA, mat3x2(-1.0, 5.0, 2.0, 0.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat3x2(l[2][0][0].mA, mat3x2(7.0, -6.0, -5.0, -1.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3x2(l[2][0][1].mA, mat3x2(1.0, -4.0, 5.0, -8.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat3x2(l[2][1][0].mA, mat3x2(1.0, -1.0, 6.0, -4.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3x2(l[2][1][1].mA, mat3x2(-7.0, 1.0, 0.0, 8.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3x2(l[2][2][0].mA, mat3x2(-5.0, 6.0, 5.0, 2.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat3x2(l[2][2][1].mA, mat3x2(-5.0, -2.0, -5.0, -8.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3x2(l[2][3][0].mA, mat3x2(-1.0, -7.0, 4.0, 8.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat3x2(l[2][3][1].mA, mat3x2(-7.0, -4.0, 9.0, 9.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat3x2(l[3][0][0].mA, mat3x2(-4.0, -2.0, -2.0, -3.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat3x2(l[3][0][1].mA, mat3x2(-9.0, 0.0, 1.0, -6.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat3x2(l[3][1][0].mA, mat3x2(-2.0, 3.0, 4.0, -2.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat3x2(l[3][1][1].mA, mat3x2(-4.0, -3.0, -2.0, -2.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3x2(l[3][2][0].mA, mat3x2(7.0, -3.0, -1.0, 4.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x2(l[3][2][1].mA, mat3x2(8.0, 7.0, -2.0, 9.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat3x2(l[3][3][0].mA, mat3x2(-2.0, 8.0, -8.0, -9.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3x2(l[3][3][1].mA, mat3x2(-5.0, 1.0, 4.0, -2.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat3x2(l[4][0][0].mA, mat3x2(6.0, -2.0, 2.0, 6.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(l[4][0][1].mA, mat3x2(-9.0, -1.0, -7.0, -4.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3x2(l[4][1][0].mA, mat3x2(-6.0, 8.0, 4.0, 6.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(l[4][1][1].mA, mat3x2(-7.0, 3.0, 3.0, -9.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(l[4][2][0].mA, mat3x2(7.0, 1.0, 2.0, 3.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat3x2(l[4][2][1].mA, mat3x2(7.0, 8.0, 8.0, -6.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x2(l[4][3][0].mA, mat3x2(-9.0, 0.0, 1.0, -6.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(l[4][3][1].mA, mat3x2(9.0, 8.0, 7.0, 7.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat3x2(l[5][0][0].mA, mat3x2(-6.0, 0.0, 0.0, 2.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat3x2(l[5][0][1].mA, mat3x2(5.0, -2.0, 2.0, -8.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x2(l[5][1][0].mA, mat3x2(7.0, -3.0, -5.0, 7.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat3x2(l[5][1][1].mA, mat3x2(-3.0, -4.0, 3.0, 2.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat3x2(l[5][2][0].mA, mat3x2(3.0, -4.0, -9.0, -9.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x2(l[5][2][1].mA, mat3x2(-6.0, 6.0, -1.0, 1.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat3x2(l[5][3][0].mA, mat3x2(-6.0, 0.0, -1.0, 9.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x2(l[5][3][1].mA, mat3x2(-3.0, -2.0, -5.0, 2.0, 0.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat2x3(-5.0, 4.0, 9.0, -1.0, -7.0, 5.0));
	blockB.c[0] = (uvec2(1u, 9u));
	blockB.c[1] = (uvec2(8u, 0u));
	blockB.c[2] = (uvec2(1u, 3u));
	blockC[0].d = (mat2(-3.0, 6.0, 9.0, -9.0));
	blockC[0].e = (ivec2(2, -4));
	blockC[0].f = (ivec3(-7, 9, 2));
	blockC[0].g = (uvec4(7u, 5u, 7u, 1u));
	blockC[1].d = (mat2(-4.0, 6.0, 2.0, -4.0));
	blockC[1].e = (ivec2(-9, -5));
	blockC[1].f = (ivec3(-9, -6, -3));
	blockC[1].g = (uvec4(0u, 1u, 7u, 1u));
	blockC[2].d = (mat2(-9.0, 9.0, 5.0, 8.0));
	blockC[2].e = (ivec2(4, 8));
	blockC[2].f = (ivec3(5, -7, 7));
	blockC[2].g = (uvec4(2u, 0u, 6u, 1u));
	h[0].mA = (vec3(-6.0, 4.0, -8.0));
	h[0].mB = (bvec4(false, true, false, false));
	h[0].mC = (mat4x2(2.0, -8.0, 0.0, 2.0, 0.0, -3.0, -3.0, -3.0));
	h[1].mA = (vec3(-5.0, -8.0, 4.0));
	h[1].mB = (bvec4(false, false, false, false));
	h[1].mC = (mat4x2(-1.0, -1.0, -5.0, -1.0, 8.0, 4.0, 1.0, 3.0));
	h[2].mA = (vec3(7.0, 6.0, -9.0));
	h[2].mB = (bvec4(false, true, false, false));
	h[2].mC = (mat4x2(5.0, -2.0, -4.0, -2.0, -6.0, -5.0, 9.0, -2.0));
	h[3].mA = (vec3(8.0, 8.0, -4.0));
	h[3].mB = (bvec4(false, true, true, true));
	h[3].mC = (mat4x2(4.0, 0.0, 0.0, 3.0, 9.0, 1.0, 1.0, -7.0));
	h[4].mA = (vec3(-5.0, -1.0, 2.0));
	h[4].mB = (bvec4(false, false, true, true));
	h[4].mC = (mat4x2(7.0, 2.0, 4.0, 8.0, -5.0, -6.0, 9.0, -5.0));
	h[5].mA = (vec3(6.0, -3.0, -9.0));
	h[5].mB = (bvec4(true, true, true, false));
	h[5].mC = (mat4x2(-4.0, -3.0, -7.0, -1.0, 3.0, -7.0, -1.0, 4.0));
	h[6].mA = (vec3(-2.0, 2.0, 0.0));
	h[6].mB = (bvec4(true, false, true, false));
	h[6].mC = (mat4x2(2.0, 2.0, 7.0, -8.0, -6.0, -6.0, 0.0, 8.0));
	i = (vec4(-2.0, 5.0, 5.0, 8.0));
	j = (mat2x3(-3.0, -6.0, -2.0, 1.0, 8.0, -5.0));
	m = (1u);
}
#version 450
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
	highp mat4x2 a;
	mediump vec3 b;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB[nonuniformEXT(0)].a, mat4x2(-2.0, 4.0, 4.0, 7.0, 8.0, 2.0, -9.0, -2.0)) && allOk;
	allOk = compare_vec3((blockB[nonuniformEXT(0)].b), vec3(2.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x2(blockB[nonuniformEXT(1)].a, mat4x2(-2.0, -5.0, -7.0, 1.0, -5.0, 0.0, -2.0, 3.0)) && allOk;
	allOk = compare_vec3((blockB[nonuniformEXT(1)].b), vec3(5.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x2(blockB[nonuniformEXT(2)].a, mat4x2(0.0, 3.0, 3.0, 8.0, -8.0, -8.0, 4.0, -5.0)) && allOk;
	allOk = compare_vec3((blockB[nonuniformEXT(2)].b), vec3(3.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat4x2(blockB[nonuniformEXT(3)].a, mat4x2(1.0, 6.0, -3.0, -4.0, 6.0, 8.0, 8.0, 6.0)) && allOk;
	allOk = compare_vec3((blockB[nonuniformEXT(3)].b), vec3(5.0, 4.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (mat4x2(7.0, -3.0, -6.0, 9.0, 8.0, 8.0, 6.0, 1.0));
	blockB[nonuniformEXT(0)].b = (vec3(-6.0, 0.0, -8.0));
	blockB[nonuniformEXT(1)].a = (mat4x2(3.0, -9.0, -3.0, 8.0, 9.0, 3.0, -2.0, 4.0));
	blockB[nonuniformEXT(1)].b = (vec3(9.0, -6.0, -6.0));
	blockB[nonuniformEXT(2)].a = (mat4x2(1.0, 7.0, 9.0, 2.0, -6.0, -1.0, -6.0, -6.0));
	blockB[nonuniformEXT(2)].b = (vec3(-2.0, 6.0, -9.0));
	blockB[nonuniformEXT(3)].a = (mat4x2(-9.0, 9.0, -1.0, -9.0, 8.0, 4.0, -9.0, 0.0));
	blockB[nonuniformEXT(3)].b = (vec3(1.0, -2.0, 6.0));
}
#version 450
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
	lowp vec3 a;
	highp vec3 b;
} blockB[];

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

struct sA
{
	u16vec3 mA;
	bvec2 mB;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	mediump uvec2 a;
	lowp vec3 b;
	mediump ivec3 c;
	bvec2 d[];
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	f16vec2 e;
	bvec2 f[6];
	mediump uvec4 g;
	sA h[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a), uvec2(2u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.h[0].mA), uvec3(2u, 6u, 1u)) && allOk;
	allOk = compare_bvec2((blockC.h[0].mB), bvec2(false, false)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.h[1].mA), uvec3(4u, 6u, 0u)) && allOk;
	allOk = compare_bvec2((blockC.h[1].mB), bvec2(false, false)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.h[2].mA), uvec3(3u, 2u, 3u)) && allOk;
	allOk = compare_bvec2((blockC.h[2].mB), bvec2(false, true)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.h[3].mA), uvec3(3u, 8u, 9u)) && allOk;
	allOk = compare_bvec2((blockC.h[3].mB), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec2(2u, 0u));
	blockB.b = (vec3(-5.0, -9.0, -8.0));
	blockB.c = (ivec3(0, 8, 0));
	blockB.d[0] = (bvec2(true, false));
	blockB.d[1] = (bvec2(true, true));
	blockB.d[2] = (bvec2(true, true));
	blockB.d[3] = (bvec2(false, false));
	blockB.d[4] = (bvec2(true, false));
	blockB.d[5] = (bvec2(false, true));
	blockB.d[6] = (bvec2(true, false));
	blockC.e = f16vec2(vec2(8.0, -5.0));
	blockC.f[0] = (bvec2(false, true));
	blockC.f[1] = (bvec2(false, false));
	blockC.f[2] = (bvec2(false, false));
	blockC.f[3] = (bvec2(true, true));
	blockC.f[4] = (bvec2(true, true));
	blockC.f[5] = (bvec2(true, true));
	blockC.g = (uvec4(7u, 4u, 7u, 0u));
	blockC.h[0].mA = u16vec3(uvec3(2u, 2u, 6u));
	blockC.h[0].mB = (bvec2(true, true));
	blockC.h[1].mA = u16vec3(uvec3(1u, 0u, 1u));
	blockC.h[1].mB = (bvec2(true, false));
	blockC.h[2].mA = u16vec3(uvec3(1u, 5u, 5u));
	blockC.h[2].mB = (bvec2(false, false));
	blockC.h[3].mA = u16vec3(uvec3(3u, 2u, 5u));
	blockC.h[3].mB = (bvec2(true, true));
}
#version 450
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
	layout(offset = 0) highp vec3 a;
};
layout(binding = 2) readonly buffer BlockC
{
	layout(offset = 0) float16_t b;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((a), vec3(-9.0, 2.0, 9.0)) && allOk;
	allOk = compare_float16_t(float(b), 1.0) && allOk;
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
	layout(offset = 0) f16vec4 a;
} blockB[1];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) lowp uvec4 b;
	layout(offset = 16) i16vec2 c;
	layout(offset = 32) lowp ivec4 d;
	layout(offset = 48) lowp ivec2 e;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(blockB[0].a), vec4(-3.0, 7.0, -8.0, -9.0)) && allOk;
	allOk = compare_i16vec2(ivec2(c), ivec2(-4, -1)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = f16vec4(vec4(-5.0, 5.0, -3.0, 3.0));
	b = (uvec4(5u, 0u, 2u, 1u));
	c = i16vec2(ivec2(-8, -3));
	d = (ivec4(9, 6, 7, 3));
	e = (ivec2(-7, 0));
}
#version 450
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
	f16vec4 b;
	uint16_t c;
	bvec3 d;
	mediump vec3 e;
} blockB[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB[0].a), true) && allOk;
	allOk = compare_f16vec4(vec4(blockB[0].b), vec4(4.0, -8.0, -2.0, -7.0)) && allOk;
	allOk = compare_uint16_t(uint(blockB[0].c), 1u) && allOk;
	allOk = compare_bvec3((blockB[0].d), bvec3(false, true, true)) && allOk;
	allOk = compare_vec3((blockB[0].e), vec3(-1.0, -9.0, -3.0)) && allOk;
	allOk = compare_bool((blockB[1].a), true) && allOk;
	allOk = compare_f16vec4(vec4(blockB[1].b), vec4(-9.0, -1.0, -6.0, 7.0)) && allOk;
	allOk = compare_uint16_t(uint(blockB[1].c), 9u) && allOk;
	allOk = compare_bvec3((blockB[1].d), bvec3(false, true, false)) && allOk;
	allOk = compare_vec3((blockB[1].e), vec3(1.0, -3.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (true);
	blockB[0].b = f16vec4(vec4(-5.0, -5.0, 8.0, -6.0));
	blockB[0].c = uint16_t(2u);
	blockB[0].d = (bvec3(false, true, true));
	blockB[0].e = (vec3(4.0, 9.0, -9.0));
	blockB[1].a = (true);
	blockB[1].b = f16vec4(vec4(3.0, -1.0, 7.0, -2.0));
	blockB[1].c = uint16_t(0u);
	blockB[1].d = (bvec3(true, true, true));
	blockB[1].e = (vec3(-1.0, -5.0, 4.0));
}
#version 450
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
};
layout(scalar, binding = 1) readonly buffer BlockB
{
	highp mat2x3 a;
	f16vec4 b[2];
	lowp float c;
	bvec4 d[];
} blockB;
layout(scalar, binding = 2) buffer BlockC
{
	lowp uint e;
	lowp vec3 f;
} blockC;
layout(scalar, binding = 3) buffer BlockD
{
	sA g;
	lowp mat3 h;
	mediump uvec4 i;
	lowp vec4 j;
	u16vec4 k[];
} blockD[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.d[0]), bvec4(false, false, false, true)) && allOk;
	allOk = compare_bvec4((blockB.d[1]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((blockB.d[2]), bvec4(false, false, true, true)) && allOk;
	allOk = compare_bvec4((blockB.d[3]), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bvec4((blockB.d[4]), bvec4(true, false, false, false)) && allOk;
	allOk = compare_f16vec4(vec4(blockD[0].g.mA), vec4(-8.0, 1.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat3(blockD[0].h, mat3(-5.0, 5.0, -7.0, -9.0, 9.0, -3.0, 8.0, 8.0, -5.0)) && allOk;
	allOk = compare_uvec4((blockD[0].i), uvec4(2u, 5u, 9u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.e = (2u);
	blockD[0].h = (mat3(-8.0, 0.0, 8.0, 7.0, -9.0, 1.0, -9.0, -8.0, -4.0));
	blockD[0].i = (uvec4(5u, 4u, 5u, 9u));
	blockD[0].j = (vec4(-5.0, 9.0, 3.0, 2.0));
}
#version 450
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
	int8_t a;
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(a), 4294967287) && allOk;
    if (allOk)
        ac_numPassed++;

	a = int8_t(4294967287);
}
#version 450
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
	mediump int a;
	u8vec2 b;
};
layout(std140, binding = 2) buffer BlockC
{
	lowp vec4 c;
	int8_t d;
	u8vec4 e;
	i8vec3 f;
	highp float g[1];
};
layout(std140, binding = 3) buffer BlockD
{
	mediump float h;
	uint8_t i;
	lowp uvec3 j[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((a), -5) && allOk;
	allOk = compare_u8vec2(uvec2(b), uvec2(9u, 0u)) && allOk;
	allOk = compare_vec4((c), vec4(9.0, -1.0, 0.0, -3.0)) && allOk;
	allOk = compare_u8vec4(uvec4(e), uvec4(7u, 2u, 8u, 4u)) && allOk;
	allOk = compare_float((g[0]), 8.0) && allOk;
	allOk = compare_uvec3((j[0]), uvec3(4u, 8u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (-7);
	b = u8vec2(uvec2(5u, 2u));
	c = (vec4(-7.0, -3.0, -9.0, 1.0));
	e = u8vec4(uvec4(1u, 6u, 6u, 4u));
	f = i8vec3(ivec3(4294967291, 4294967287, 4294967287));
	g[0] = (-7.0);
	h = (3.0);
	i = uint8_t(7u);
}
#version 450
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
	lowp ivec2 a;
	u8vec3 b;
	mediump mat4 c;
	u8vec3 d;
	mediump mat2 e[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((a), ivec2(-8, -8)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (ivec2(-2, -9));
	b = u8vec3(uvec3(4u, 8u, 5u));
	c = (mat4(7.0, -9.0, 6.0, 2.0, -7.0, 4.0, 4.0, -9.0, -6.0, -6.0, 6.0, -8.0, -5.0, 2.0, -5.0, 3.0));
	d = u8vec3(uvec3(8u, 2u, 8u));
}
#version 450
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
	highp ivec3 mA;
	u8vec4 mB;
	highp ivec2 mC;
	mediump int mD;
};
struct sC
{
	lowp mat3x4 mA;
	lowp mat3x4 mB;
	i8vec2 mC;
	sB mD;
};
struct sD
{
	highp uvec4 mA;
	i8vec4 mB;
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	uint8_t a;
	sA b;
	bvec3 c;
	bool d;
};
layout(std140, binding = 2) buffer BlockC
{
	lowp uvec2 e;
	highp ivec2 f[];
} blockC;
layout(std430, row_major, binding = 3) buffer BlockD
{
	sC g;
	mediump ivec3 h;
	sD i[];
};
layout(std140, binding = 4) buffer BlockE
{
	lowp uint j;
	u8vec2 k;
	int8_t l;
	lowp float m[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(a), 7u) && allOk;
	allOk = compare_bvec4((b.mA), bvec4(true, false, true, true)) && allOk;
	allOk = compare_uvec2((blockC.e), uvec2(3u, 4u)) && allOk;
	allOk = compare_ivec2((blockC.f[0]), ivec2(8, -3)) && allOk;
	allOk = compare_ivec2((blockC.f[1]), ivec2(8, 5)) && allOk;
	allOk = compare_ivec2((blockC.f[2]), ivec2(-7, -3)) && allOk;
	allOk = compare_uvec4((i[0].mA), uvec4(6u, 5u, 3u, 1u)) && allOk;
	allOk = compare_i8vec4(ivec4(i[0].mB), ivec4(4294967294, 5, 4294967287, 5)) && allOk;
	allOk = compare_uvec4((i[1].mA), uvec4(6u, 0u, 4u, 3u)) && allOk;
	allOk = compare_i8vec4(ivec4(i[1].mB), ivec4(4294967289, 1, 8, 1)) && allOk;
	allOk = compare_uvec4((i[2].mA), uvec4(5u, 8u, 6u, 3u)) && allOk;
	allOk = compare_i8vec4(ivec4(i[2].mB), ivec4(0, 4294967287, 4294967292, 4294967293)) && allOk;
	allOk = compare_uvec4((i[3].mA), uvec4(2u, 7u, 1u, 0u)) && allOk;
	allOk = compare_i8vec4(ivec4(i[3].mB), ivec4(4294967294, 4, 4294967288, 4294967292)) && allOk;
	allOk = compare_uvec4((i[4].mA), uvec4(7u, 1u, 8u, 6u)) && allOk;
	allOk = compare_i8vec4(ivec4(i[4].mB), ivec4(4, 4294967291, 6, 4294967294)) && allOk;
	allOk = compare_uvec4((i[5].mA), uvec4(3u, 4u, 6u, 3u)) && allOk;
	allOk = compare_i8vec4(ivec4(i[5].mB), ivec4(3, 4294967290, 8, 4294967294)) && allOk;
	allOk = compare_uvec4((i[6].mA), uvec4(8u, 0u, 1u, 4u)) && allOk;
	allOk = compare_i8vec4(ivec4(i[6].mB), ivec4(4294967288, 4294967295, 7, 4294967287)) && allOk;
	allOk = compare_uint((j), 1u) && allOk;
	allOk = compare_u8vec2(uvec2(k), uvec2(2u, 9u)) && allOk;
	allOk = compare_int8_t(int(l), 4294967289) && allOk;
    if (allOk)
        ac_numPassed++;

	b.mA = (bvec4(false, false, true, true));
	d = (false);
	blockC.e = (uvec2(9u, 5u));
	g.mA = (mat3x4(1.0, 3.0, 4.0, 2.0, 9.0, 9.0, -5.0, 8.0, 1.0, 6.0, -6.0, 0.0));
	g.mB = (mat3x4(6.0, -3.0, -8.0, 0.0, 5.0, -8.0, -6.0, 0.0, 6.0, 8.0, -5.0, 2.0));
	g.mC = i8vec2(ivec2(4294967295, 4294967292));
	g.mD.mA = (ivec3(-3, 0, 5));
	g.mD.mB = u8vec4(uvec4(1u, 4u, 6u, 4u));
	g.mD.mC = (ivec2(-3, -8));
	g.mD.mD = (-4);
	h = (ivec3(-1, -5, 1));
	i[0].mA = (uvec4(0u, 8u, 2u, 6u));
	i[0].mB = i8vec4(ivec4(6, 4294967287, 0, 8));
	i[1].mA = (uvec4(6u, 0u, 2u, 3u));
	i[1].mB = i8vec4(ivec4(4294967295, 0, 4294967294, 4294967292));
	i[2].mA = (uvec4(7u, 5u, 0u, 9u));
	i[2].mB = i8vec4(ivec4(2, 9, 6, 4294967294));
	i[3].mA = (uvec4(0u, 2u, 8u, 1u));
	i[3].mB = i8vec4(ivec4(6, 4294967292, 4294967291, 4294967294));
	i[4].mA = (uvec4(6u, 7u, 2u, 4u));
	i[4].mB = i8vec4(ivec4(0, 4294967294, 4294967292, 8));
	i[5].mA = (uvec4(4u, 8u, 8u, 2u));
	i[5].mB = i8vec4(ivec4(8, 9, 7, 4294967293));
	i[6].mA = (uvec4(2u, 1u, 2u, 9u));
	i[6].mB = i8vec4(ivec4(4294967291, 4294967289, 4294967288, 4294967288));
	j = (9u);
	l = int8_t(4294967290);
}
#version 450
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
	i8vec3 mB;
};
struct sB
{
	lowp mat2 mA;
	sA mB;
};
struct sC
{
	i8vec4 mA;
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	i8vec2 a;
	bvec2 b;
} blockB[1];
layout(std140, row_major, binding = 2) buffer BlockC
{
	bool c[];
};
layout(std430, row_major, binding = 3) buffer BlockD
{
	mediump mat4x2 d[2];
	sB e[];
};
layout(std140, row_major, binding = 4) buffer BlockE
{
	highp uvec4 f[2];
	sC g[];
} blockE[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(blockB[0].a), ivec2(4294967292, 4)) && allOk;
	allOk = compare_bvec2((blockB[0].b), bvec2(false, false)) && allOk;
	allOk = compare_mat4x2(d[0], mat4x2(3.0, -3.0, -6.0, -1.0, -4.0, 4.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat4x2(d[1], mat4x2(-1.0, -6.0, 6.0, 5.0, 5.0, -1.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat2(e[0].mA, mat2(-3.0, -8.0, 4.0, 7.0)) && allOk;
	allOk = compare_bvec2((e[0].mB.mA), bvec2(false, false)) && allOk;
	allOk = compare_i8vec3(ivec3(e[0].mB.mB), ivec3(3, 4294967292, 4294967294)) && allOk;
	allOk = compare_mat2(e[1].mA, mat2(-4.0, -4.0, -9.0, 3.0)) && allOk;
	allOk = compare_bvec2((e[1].mB.mA), bvec2(true, true)) && allOk;
	allOk = compare_i8vec3(ivec3(e[1].mB.mB), ivec3(4294967292, 4294967291, 4294967292)) && allOk;
	allOk = compare_mat2(e[2].mA, mat2(0.0, -5.0, -2.0, 0.0)) && allOk;
	allOk = compare_bvec2((e[2].mB.mA), bvec2(false, false)) && allOk;
	allOk = compare_i8vec3(ivec3(e[2].mB.mB), ivec3(2, 5, 9)) && allOk;
	allOk = compare_mat2(e[3].mA, mat2(1.0, 1.0, -8.0, -1.0)) && allOk;
	allOk = compare_bvec2((e[3].mB.mA), bvec2(true, false)) && allOk;
	allOk = compare_i8vec3(ivec3(e[3].mB.mB), ivec3(4294967291, 8, 4)) && allOk;
	allOk = compare_mat2(e[4].mA, mat2(0.0, 5.0, -2.0, -4.0)) && allOk;
	allOk = compare_bvec2((e[4].mB.mA), bvec2(false, true)) && allOk;
	allOk = compare_i8vec3(ivec3(e[4].mB.mB), ivec3(4294967295, 1, 5)) && allOk;
	allOk = compare_mat2(e[5].mA, mat2(-6.0, 0.0, 7.0, 3.0)) && allOk;
	allOk = compare_bvec2((e[5].mB.mA), bvec2(false, true)) && allOk;
	allOk = compare_i8vec3(ivec3(e[5].mB.mB), ivec3(6, 0, 1)) && allOk;
	allOk = compare_mat2(e[6].mA, mat2(4.0, 3.0, -7.0, 6.0)) && allOk;
	allOk = compare_bvec2((e[6].mB.mA), bvec2(false, true)) && allOk;
	allOk = compare_i8vec3(ivec3(e[6].mB.mB), ivec3(4294967287, 6, 5)) && allOk;
	allOk = compare_uvec4((blockE[0].f[0]), uvec4(7u, 8u, 2u, 3u)) && allOk;
	allOk = compare_uvec4((blockE[0].f[1]), uvec4(1u, 8u, 2u, 2u)) && allOk;
	allOk = compare_uvec4((blockE[1].f[0]), uvec4(9u, 2u, 9u, 3u)) && allOk;
	allOk = compare_uvec4((blockE[1].f[1]), uvec4(0u, 6u, 8u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (bvec2(false, true));
	c[0] = (true);
	c[1] = (false);
	c[2] = (true);
	c[3] = (true);
	d[0] = (mat4x2(-9.0, -5.0, 5.0, 5.0, 4.0, -6.0, -2.0, 3.0));
	d[1] = (mat4x2(-5.0, -9.0, 0.0, -1.0, -9.0, 6.0, 3.0, 2.0));
	blockE[0].f[0] = (uvec4(9u, 2u, 8u, 9u));
	blockE[0].f[1] = (uvec4(0u, 0u, 3u, 5u));
	blockE[0].g[0].mA = i8vec4(ivec4(4294967291, 6, 4294967293, 4294967290));
	blockE[0].g[1].mA = i8vec4(ivec4(8, 4, 5, 4294967291));
	blockE[0].g[2].mA = i8vec4(ivec4(2, 9, 7, 3));
	blockE[1].f[0] = (uvec4(8u, 5u, 1u, 3u));
	blockE[1].f[1] = (uvec4(8u, 6u, 5u, 6u));
	blockE[1].g[0].mA = i8vec4(ivec4(4, 4294967295, 4294967294, 4294967294));
	blockE[1].g[1].mA = i8vec4(ivec4(4294967293, 4294967290, 4294967291, 4294967288));
	blockE[1].g[2].mA = i8vec4(ivec4(0, 4, 1, 3));
}
#version 450
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
	highp ivec4 a;
	bool b;
	uint8_t c;
	lowp mat2 d[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(d[0], mat2(-2.0, -7.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat2(d[1], mat2(-1.0, -5.0, -5.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (ivec4(6, 9, -9, -1));
	c = uint8_t(0u);
}
#version 450
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
	layout(offset = 16) highp uvec4 b;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) bvec3 c[1];
	layout(offset = 16) u8vec4 d;
	layout(offset = 32) lowp vec4 e;
} blockC[2];
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) highp ivec2 f;
	layout(offset = 8) highp ivec2 g;
	layout(offset = 16) mediump uvec2 h;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((b), uvec4(3u, 0u, 5u, 9u)) && allOk;
	allOk = compare_bvec3((blockC[0].c[0]), bvec3(false, true, true)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].d), uvec4(4u, 5u, 0u, 8u)) && allOk;
	allOk = compare_vec4((blockC[0].e), vec4(-1.0, 3.0, -2.0, -1.0)) && allOk;
	allOk = compare_bvec3((blockC[1].c[0]), bvec3(false, false, true)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[1].d), uvec4(1u, 3u, 3u, 2u)) && allOk;
	allOk = compare_vec4((blockC[1].e), vec4(4.0, -8.0, -3.0, -1.0)) && allOk;
	allOk = compare_ivec2((blockD.f), ivec2(4, -9)) && allOk;
	allOk = compare_ivec2((blockD.g), ivec2(7, 1)) && allOk;
	allOk = compare_uvec2((blockD.h), uvec2(1u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec3(true, false, true));
	b = (uvec4(9u, 2u, 0u, 8u));
	blockC[0].c[0] = (bvec3(false, false, false));
	blockC[1].c[0] = (bvec3(true, false, false));
	blockD.h = (uvec2(8u, 8u));
}
#version 450
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
	layout(offset = 0) highp uint a[1];
	layout(offset = 4) i8vec3 b;
	layout(offset = 16) bvec3 c;
	layout(offset = 28) i8vec2 d;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) lowp uvec3 e[1];
	layout(offset = 16) mediump uint f;
	layout(offset = 32) mediump vec4 g;
} blockC[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a[0]), 8u) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.b), ivec3(9, 9, 4294967289)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.d), ivec2(8, 4)) && allOk;
	allOk = compare_uint((blockC[0].f), 6u) && allOk;
	allOk = compare_vec4((blockC[0].g), vec4(9.0, -3.0, -8.0, 6.0)) && allOk;
	allOk = compare_uint((blockC[1].f), 9u) && allOk;
	allOk = compare_vec4((blockC[1].g), vec4(-1.0, -7.0, -7.0, 6.0)) && allOk;
	allOk = compare_uint((blockC[2].f), 3u) && allOk;
	allOk = compare_vec4((blockC[2].g), vec4(1.0, 1.0, 7.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (9u);
	blockB.b = i8vec3(ivec3(0, 9, 4));
	blockB.c = (bvec3(true, true, false));
	blockB.d = i8vec2(ivec2(4294967291, 4294967294));
	blockC[0].e[0] = (uvec3(8u, 4u, 6u));
	blockC[0].f = (2u);
	blockC[1].e[0] = (uvec3(1u, 5u, 6u));
	blockC[1].f = (7u);
	blockC[2].e[0] = (uvec3(8u, 5u, 8u));
	blockC[2].f = (1u);
}
#version 450
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
	layout(offset = 0) mediump uvec3 a[1];
	layout(offset = 16) uint8_t b;
	layout(offset = 20) mediump uvec3 c;
} blockB[3];

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(blockB[0].b), 8u) && allOk;
	allOk = compare_uvec3((blockB[0].c), uvec3(1u, 2u, 5u)) && allOk;
	allOk = compare_uint8_t(uint(blockB[1].b), 8u) && allOk;
	allOk = compare_uvec3((blockB[1].c), uvec3(0u, 9u, 7u)) && allOk;
	allOk = compare_uint8_t(uint(blockB[2].b), 8u) && allOk;
	allOk = compare_uvec3((blockB[2].c), uvec3(8u, 5u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (uvec3(8u, 2u, 6u));
	blockB[0].b = uint8_t(9u);
	blockB[0].c = (uvec3(2u, 1u, 0u));
	blockB[1].a[0] = (uvec3(4u, 0u, 7u));
	blockB[1].b = uint8_t(4u);
	blockB[1].c = (uvec3(2u, 9u, 9u));
	blockB[2].a[0] = (uvec3(5u, 0u, 1u));
	blockB[2].b = uint8_t(9u);
	blockB[2].c = (uvec3(9u, 8u, 1u));
}
#version 450
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
	layout(offset = 8) u8vec3 b;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) i8vec3 c;
	layout(offset = 4) mediump uint d;
	layout(offset = 8) u8vec3 e;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) highp ivec4 f;
	layout(offset = 16) lowp vec3 g;
	layout(offset = 28) highp uint h;
	layout(offset = 32) lowp ivec2 i;
	layout(offset = 48) bvec4 j[1];
} blockD;
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) mediump uvec3 k;
	layout(offset = 16) lowp vec3 l;
	layout(offset = 32) highp ivec3 m;
	layout(offset = 48) highp ivec4 n[1];
	layout(offset = 64) lowp uint o[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((a), bvec2(true, true)) && allOk;
	allOk = compare_u8vec3(uvec3(b), uvec3(2u, 5u, 1u)) && allOk;
	allOk = compare_ivec4((blockD.f), ivec4(-4, -1, -7, -3)) && allOk;
	allOk = compare_ivec2((blockD.i), ivec2(-5, 5)) && allOk;
	allOk = compare_bvec4((blockD.j[0]), bvec4(false, true, false, false)) && allOk;
	allOk = compare_uvec3((k), uvec3(5u, 5u, 4u)) && allOk;
	allOk = compare_ivec3((m), ivec3(-8, 0, -5)) && allOk;
	allOk = compare_ivec4((n[0]), ivec4(-3, -8, 2, 9)) && allOk;
	allOk = compare_uint((o[0]), 3u) && allOk;
    if (allOk)
        ac_numPassed++;

	b = u8vec3(uvec3(0u, 3u, 2u));
	c = i8vec3(ivec3(4294967292, 4294967289, 9));
	d = (9u);
	e = u8vec3(uvec3(5u, 1u, 6u));
	blockD.f = (ivec4(0, 8, -1, 4));
	blockD.g = (vec3(-1.0, -6.0, 6.0));
	blockD.h = (3u);
	blockD.i = (ivec2(8, 9));
	blockD.j[0] = (bvec4(true, false, true, true));
	l = (vec3(0.0, 7.0, -2.0));
	m = (ivec3(-9, 9, -9));
	n[0] = (ivec4(-4, -8, 0, 8));
	o[0] = (4u);
}
#version 450
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
	highp mat3x2 a;
	bool b;
	mediump mat4x3 c;
	bvec3 d;
	lowp mat4 e[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(a, mat3x2(-6.0, -1.0, -4.0, -3.0, -1.0, 8.0)) && allOk;
	allOk = compare_bool((b), true) && allOk;
	allOk = compare_mat4x3(c, mat4x3(-3.0, 5.0, 6.0, 8.0, -8.0, 9.0, -4.0, 9.0, 3.0, -5.0, -8.0, 3.0)) && allOk;
	allOk = compare_bvec3((d), bvec3(true, false, false)) && allOk;
	allOk = compare_mat4(e[0], mat4(-6.0, 3.0, -1.0, 9.0, -3.0, 9.0, -4.0, -3.0, 6.0, -4.0, 6.0, -4.0, 2.0, -6.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat4(e[1], mat4(-5.0, 1.0, -9.0, -9.0, 1.0, 7.0, -1.0, -6.0, 9.0, -9.0, -8.0, 6.0, 0.0, -3.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat4(e[2], mat4(-7.0, 3.0, -6.0, -5.0, -5.0, 9.0, 1.0, 2.0, 3.0, 8.0, -5.0, -7.0, 8.0, -1.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat4(e[3], mat4(-4.0, 9.0, 0.0, -5.0, -2.0, -7.0, 0.0, 6.0, 8.0, -1.0, 4.0, -2.0, -3.0, -4.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4(e[4], mat4(-4.0, -5.0, -6.0, -7.0, 8.0, -6.0, 9.0, -9.0, 5.0, -9.0, -5.0, -6.0, 2.0, 3.0, 3.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat3x2(-6.0, -9.0, 9.0, 5.0, 6.0, -9.0));
	b = (true);
	d = (bvec3(false, false, true));
}
#version 450
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
	highp ivec4 mA[3];
	i8vec3 mB;
};
struct sB
{
	mediump uvec3 mA[2];
	highp mat2 mB;
	mediump mat3x4 mC;
	lowp uint mD;
};
layout(scalar, row_major, binding = 1) buffer BlockB
{
	lowp vec4 a;
	lowp ivec2 b;
	highp mat4 c;
	highp vec3 d;
	sA e[];
};
layout(scalar, column_major, binding = 2) buffer BlockC
{
	uint8_t f;
	mediump vec3 g;
	sB h;
	highp mat3 i[8];
};
layout(scalar, column_major, binding = 3) buffer BlockD
{
	mediump mat4 j;
	mediump mat4 k;
	lowp ivec4 l[];
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
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((a), vec4(-3.0, 6.0, 7.0, 8.0)) && allOk;
	allOk = compare_ivec2((b), ivec2(-8, 7)) && allOk;
	allOk = compare_vec3((g), vec3(5.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3(i[0], mat3(2.0, -9.0, 9.0, 7.0, 6.0, 8.0, -8.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat3(i[1], mat3(-1.0, 9.0, -8.0, 0.0, 5.0, -5.0, 9.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3(i[2], mat3(3.0, -3.0, 6.0, -8.0, -1.0, -7.0, -5.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat3(i[3], mat3(-8.0, 2.0, -9.0, 6.0, -7.0, 4.0, 3.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3(i[4], mat3(-3.0, 6.0, 8.0, 8.0, 7.0, -6.0, -3.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat3(i[5], mat3(-1.0, -4.0, -5.0, -7.0, -2.0, -4.0, 2.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3(i[6], mat3(5.0, -5.0, 8.0, 8.0, 9.0, -3.0, 7.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3(i[7], mat3(0.0, 2.0, -9.0, 0.0, -5.0, -2.0, -9.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat4(j, mat4(3.0, 7.0, 9.0, -1.0, -6.0, -4.0, 2.0, -6.0, -6.0, 8.0, -8.0, 2.0, 9.0, 4.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat4(k, mat4(-2.0, 4.0, -7.0, -3.0, 3.0, -3.0, -2.0, -9.0, -7.0, -7.0, -5.0, 0.0, 9.0, 2.0, 7.0, 6.0)) && allOk;
	allOk = compare_ivec4((l[0]), ivec4(2, -5, -7, 6)) && allOk;
	allOk = compare_ivec4((l[1]), ivec4(-8, 2, 0, 9)) && allOk;
	allOk = compare_ivec4((l[2]), ivec4(-6, -8, 9, -2)) && allOk;
	allOk = compare_ivec4((l[3]), ivec4(5, -5, -6, -4)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec4(1.0, 8.0, 5.0, 5.0));
	b = (ivec2(1, 5));
	e[0].mA[0] = (ivec4(-8, -8, -2, 2));
	e[0].mA[1] = (ivec4(8, -7, -9, -4));
	e[0].mA[2] = (ivec4(-1, -2, 4, 0));
	e[0].mB = i8vec3(ivec3(4294967294, 4294967287, 1));
	h.mA[0] = (uvec3(5u, 7u, 9u));
	h.mA[1] = (uvec3(2u, 1u, 7u));
	h.mB = (mat2(-1.0, -7.0, -6.0, 9.0));
	h.mC = (mat3x4(5.0, 4.0, -9.0, -2.0, -7.0, -9.0, -9.0, -5.0, -3.0, -8.0, -6.0, -4.0));
	h.mD = (8u);
	i[0] = (mat3(-6.0, 3.0, 2.0, 5.0, -9.0, 5.0, 0.0, -3.0, -4.0));
	i[1] = (mat3(-8.0, -3.0, 6.0, 0.0, -5.0, -8.0, -8.0, -4.0, 6.0));
	i[2] = (mat3(-1.0, 1.0, 9.0, -7.0, 8.0, 1.0, -3.0, 6.0, 6.0));
	i[3] = (mat3(-9.0, 1.0, -1.0, -9.0, 7.0, -7.0, 4.0, 5.0, 6.0));
	i[4] = (mat3(-6.0, 4.0, -5.0, 2.0, -8.0, -2.0, -6.0, 9.0, -1.0));
	i[5] = (mat3(0.0, -7.0, -9.0, 6.0, 4.0, 9.0, 6.0, -8.0, 0.0));
	i[6] = (mat3(-5.0, -9.0, 0.0, -3.0, 4.0, -7.0, 4.0, -4.0, 4.0));
	i[7] = (mat3(9.0, 3.0, 0.0, 9.0, 6.0, -7.0, -1.0, -1.0, -5.0));
	j = (mat4(-4.0, 0.0, 9.0, 3.0, 1.0, -6.0, -8.0, -8.0, 5.0, 3.0, 9.0, 2.0, 6.0, 0.0, 6.0, -8.0));
	l[0] = (ivec4(1, 8, -1, -5));
	l[1] = (ivec4(4, -4, 0, -6));
	l[2] = (ivec4(2, 0, -9, -1));
	l[3] = (ivec4(1, 5, -9, 9));
}
#version 450
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
	highp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var, mat2x3(-2.0, -3.0, -4.0, 2.0, 7.0, 0.0)) && allOk;
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
	allOk = compare_float(var[0][0], 9.0) && allOk;
	allOk = compare_float(var[0][1], -1.0) && allOk;
	allOk = compare_float(var[1][0], -8.0) && allOk;
	allOk = compare_float(var[1][1], 6.0) && allOk;
	allOk = compare_float(var[2][0], -4.0) && allOk;
	allOk = compare_float(var[2][1], -8.0) && allOk;
	allOk = compare_float(var[3][0], -3.0) && allOk;
	allOk = compare_float(var[3][1], -8.0) && allOk;
	allOk = compare_vec2(var[0], vec2(9.0, -1.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-8.0, 6.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-4.0, -8.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(-3.0, -8.0)) && allOk;
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
	int16_t var;
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(var), -5) && allOk;
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
	lowp float var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((var), -9.0) && allOk;
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
	lowp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var, mat3(6.0, 3.0, -1.0, -6.0, 2.0, 1.0, -4.0, 6.0, -5.0)) && allOk;
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
	lowp mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -6.0) && allOk;
	allOk = compare_float(var[0][1], 3.0) && allOk;
	allOk = compare_float(var[0][2], 6.0) && allOk;
	allOk = compare_float(var[0][3], -9.0) && allOk;
	allOk = compare_float(var[1][0], -1.0) && allOk;
	allOk = compare_float(var[1][1], 8.0) && allOk;
	allOk = compare_float(var[1][2], 5.0) && allOk;
	allOk = compare_float(var[1][3], 5.0) && allOk;
	allOk = compare_float(var[2][0], -5.0) && allOk;
	allOk = compare_float(var[2][1], 5.0) && allOk;
	allOk = compare_float(var[2][2], -7.0) && allOk;
	allOk = compare_float(var[2][3], 5.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-6.0, 3.0, 6.0, -9.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-1.0, 8.0, 5.0, 5.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-5.0, 5.0, -7.0, 5.0)) && allOk;
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
	int8_t var;
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(var), 4294967292) && allOk;
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
	mediump vec4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_vec4((var), vec4(4.0, -7.0, -8.0, 8.0)) && allOk;
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
	highp mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_mat3x4(var, mat3x4(-1.0, -3.0, -3.0, -7.0, 2.0, 4.0, 3.0, -7.0, 9.0, 7.0, 9.0, 6.0)) && allOk;
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
	highp mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -3.0) && allOk;
	allOk = compare_float(var[0][0], 6.0) && allOk;
	allOk = compare_float(var[0][1], 2.0) && allOk;
	allOk = compare_float(var[0][2], 8.0) && allOk;
	allOk = compare_float(var[0][3], -5.0) && allOk;
	allOk = compare_float(var[1][0], 6.0) && allOk;
	allOk = compare_float(var[1][1], -4.0) && allOk;
	allOk = compare_float(var[1][2], 2.0) && allOk;
	allOk = compare_float(var[1][3], 5.0) && allOk;
	allOk = compare_float(var[2][0], -1.0) && allOk;
	allOk = compare_float(var[2][1], -2.0) && allOk;
	allOk = compare_float(var[2][2], -7.0) && allOk;
	allOk = compare_float(var[2][3], -7.0) && allOk;
	allOk = compare_vec4(var[0], vec4(6.0, 2.0, 8.0, -5.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(6.0, -4.0, 2.0, 5.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-1.0, -2.0, -7.0, -7.0)) && allOk;
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
	mediump mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -3.0) && allOk;
	allOk = compare_float(var[0][0], 0.0) && allOk;
	allOk = compare_float(var[0][1], -9.0) && allOk;
	allOk = compare_float(var[0][2], -9.0) && allOk;
	allOk = compare_float(var[1][0], -2.0) && allOk;
	allOk = compare_float(var[1][1], 5.0) && allOk;
	allOk = compare_float(var[1][2], 3.0) && allOk;
	allOk = compare_float(var[2][0], -9.0) && allOk;
	allOk = compare_float(var[2][1], -4.0) && allOk;
	allOk = compare_float(var[2][2], -8.0) && allOk;
	allOk = compare_float(var[3][0], -7.0) && allOk;
	allOk = compare_float(var[3][1], 2.0) && allOk;
	allOk = compare_float(var[3][2], -9.0) && allOk;
	allOk = compare_vec3(var[0], vec3(0.0, -9.0, -9.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-2.0, 5.0, 3.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-9.0, -4.0, -8.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(-7.0, 2.0, -9.0)) && allOk;
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
	highp float var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((var[0]), 7.0) && allOk;
	allOk = compare_float((var[1]), -1.0) && allOk;
	allOk = compare_float((var[2]), -6.0) && allOk;
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
	allOk = compare_mat4x2(var[0], mat4x2(-4.0, 6.0, 0.0, -5.0, 0.0, -1.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(-6.0, -1.0, 4.0, 0.0, 2.0, -3.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(-8.0, -1.0, 5.0, 4.0, 9.0, -2.0, -3.0, -4.0)) && allOk;
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
	int16_t var[3];
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(padding), -5) && allOk;
	allOk = compare_int16_t(int(var[0]), 1) && allOk;
	allOk = compare_int16_t(int(var[1]), 8) && allOk;
	allOk = compare_int16_t(int(var[2]), -2) && allOk;
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
	allOk = compare_mat2(var[0], mat2(-6.0, 3.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(3.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(9.0, -5.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2(var[3], mat2(0.0, 8.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2(var[4], mat2(-8.0, -4.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2(var[5], mat2(8.0, 1.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2(var[6], mat2(-1.0, -4.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat2(var[7], mat2(0.0, -4.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2(var[8], mat2(8.0, -3.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat2(var[9], mat2(5.0, -6.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2(var[10], mat2(0.0, 1.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(var[11], mat2(4.0, 3.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat2(var[12], mat2(-8.0, 3.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2(var[13], mat2(0.0, -5.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat2(var[14], mat2(-1.0, 2.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2(var[15], mat2(-8.0, 0.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2(var[16], mat2(-4.0, 3.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(var[17], mat2(-3.0, 4.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat2(var[18], mat2(3.0, 2.0, 3.0, 4.0)) && allOk;
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
	highp mat2x4 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0], mat2x4(-7.0, -1.0, -3.0, -6.0, -2.0, 4.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(4.0, 9.0, -2.0, -3.0, 3.0, 3.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(9.0, 2.0, -4.0, 1.0, -2.0, -8.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[3], mat2x4(9.0, 4.0, 2.0, -6.0, -7.0, -3.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[4], mat2x4(7.0, 2.0, -5.0, -2.0, -1.0, 5.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[5], mat2x4(-1.0, -6.0, 3.0, -5.0, -6.0, 5.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[6], mat2x4(-7.0, 8.0, 3.0, 6.0, 7.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[7], mat2x4(9.0, -4.0, -9.0, 5.0, -4.0, 9.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[8], mat2x4(-5.0, 9.0, 8.0, 9.0, -6.0, 0.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[9], mat2x4(0.0, 4.0, 4.0, 1.0, 6.0, -8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[10], mat2x4(1.0, 1.0, -9.0, -7.0, 3.0, 9.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[11], mat2x4(4.0, 7.0, -6.0, 2.0, 0.0, -3.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[12], mat2x4(4.0, 7.0, -6.0, -6.0, -4.0, -1.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[13], mat2x4(-6.0, 0.0, -1.0, 1.0, -2.0, -5.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[14], mat2x4(-1.0, 7.0, 8.0, 8.0, -5.0, -8.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[15], mat2x4(-7.0, 9.0, -1.0, -6.0, 3.0, 9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[16], mat2x4(6.0, -8.0, -5.0, 4.0, -4.0, -5.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[17], mat2x4(-1.0, -3.0, -8.0, 8.0, 8.0, -2.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[18], mat2x4(-2.0, -2.0, -2.0, 9.0, -2.0, 3.0, 7.0, 2.0)) && allOk;
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
	highp mat3x4 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0], mat3x4(-6.0, 2.0, 7.0, -8.0, 9.0, -6.0, 1.0, 9.0, -9.0, 1.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(-8.0, -5.0, -5.0, 5.0, -5.0, -3.0, 2.0, 1.0, 2.0, 8.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(3.0, 7.0, -5.0, 5.0, 6.0, -3.0, 8.0, -1.0, -1.0, -1.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[3], mat3x4(3.0, 2.0, 8.0, 7.0, 5.0, 9.0, -1.0, -1.0, -5.0, -3.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[4], mat3x4(4.0, -6.0, -8.0, 7.0, 0.0, -7.0, -9.0, 1.0, 0.0, -4.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[5], mat3x4(7.0, 9.0, 6.0, 6.0, 5.0, -9.0, 3.0, -1.0, -1.0, 4.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[6], mat3x4(2.0, 6.0, -1.0, 0.0, 8.0, 9.0, 6.0, 2.0, 2.0, 5.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[7], mat3x4(2.0, 6.0, 8.0, 7.0, -7.0, 9.0, 5.0, 7.0, 1.0, 1.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[8], mat3x4(1.0, 9.0, -1.0, -4.0, 9.0, -9.0, 9.0, 3.0, -1.0, -5.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat3x4(var[9], mat3x4(-1.0, 0.0, -4.0, -5.0, -8.0, 9.0, 5.0, -7.0, 6.0, -6.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[10], mat3x4(-8.0, -3.0, -4.0, -7.0, 2.0, 4.0, 4.0, -8.0, 0.0, -9.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[11], mat3x4(-5.0, -2.0, 0.0, -8.0, -7.0, -1.0, -3.0, 0.0, 4.0, 9.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[12], mat3x4(5.0, 2.0, -1.0, 6.0, -6.0, 4.0, 2.0, 5.0, 9.0, 7.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[13], mat3x4(-2.0, -5.0, 0.0, 0.0, 2.0, 5.0, 8.0, -5.0, 7.0, 5.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[14], mat3x4(-7.0, -9.0, 9.0, 1.0, -6.0, 3.0, 9.0, 6.0, -4.0, -6.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[15], mat3x4(0.0, -4.0, 4.0, -6.0, 0.0, -7.0, -2.0, 2.0, 1.0, 2.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[16], mat3x4(-4.0, -6.0, -6.0, 3.0, -4.0, 7.0, -9.0, 0.0, 4.0, 0.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[17], mat3x4(-7.0, -8.0, -8.0, -8.0, 9.0, 7.0, -9.0, -6.0, -2.0, 3.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[18], mat3x4(-2.0, -9.0, 2.0, -8.0, -3.0, 1.0, -5.0, 1.0, 3.0, 1.0, 5.0, -5.0)) && allOk;
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

}
#version 450
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

}
#version 450
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
	bvec4 var[];
};

bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((var[0]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((var[1]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((var[2]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((var[3]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((var[4]), bvec4(false, false, true, true)) && allOk;
	allOk = compare_bvec4((var[5]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec4((var[6]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((var[7]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((var[8]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((var[9]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((var[10]), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec4((var[11]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((var[12]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((var[13]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((var[14]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((var[15]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((var[16]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((var[17]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((var[18]), bvec4(false, true, false, false)) && allOk;
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
	highp mat3x4 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0], mat3x4(-2.0, 8.0, -6.0, -5.0, -7.0, 8.0, -7.0, -5.0, 5.0, -2.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(-7.0, -3.0, -5.0, 8.0, -1.0, -9.0, 0.0, -5.0, -1.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(2.0, -8.0, 6.0, 3.0, -1.0, -1.0, 2.0, 5.0, -7.0, -3.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[3], mat3x4(-4.0, 5.0, -5.0, 2.0, -9.0, 2.0, -4.0, -7.0, -3.0, 1.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[4], mat3x4(3.0, -2.0, 3.0, -8.0, -1.0, -1.0, 0.0, 9.0, 3.0, 9.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[5], mat3x4(-1.0, -3.0, 1.0, -7.0, 6.0, -9.0, 9.0, 4.0, 1.0, -5.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[6], mat3x4(-1.0, 6.0, -8.0, 3.0, 8.0, -8.0, 2.0, 8.0, -6.0, -7.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[7], mat3x4(-6.0, 8.0, -9.0, -3.0, 9.0, -9.0, -2.0, -8.0, 8.0, -5.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[8], mat3x4(4.0, -3.0, -4.0, 3.0, 7.0, 7.0, 1.0, 8.0, -2.0, 0.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[9], mat3x4(5.0, -5.0, 7.0, 4.0, 2.0, 1.0, -1.0, 0.0, -7.0, -6.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[10], mat3x4(9.0, 4.0, 1.0, 5.0, 8.0, -4.0, -6.0, -8.0, 8.0, 1.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[11], mat3x4(1.0, 1.0, 8.0, -1.0, 0.0, 9.0, 7.0, -5.0, 1.0, -6.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[12], mat3x4(0.0, -5.0, 8.0, -6.0, -1.0, -7.0, 0.0, 3.0, -2.0, -4.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[13], mat3x4(-4.0, -5.0, 4.0, 2.0, -5.0, -5.0, -9.0, 2.0, -7.0, 9.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[14], mat3x4(2.0, 0.0, -4.0, 6.0, 3.0, -2.0, -9.0, 8.0, -8.0, 8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[15], mat3x4(-7.0, -2.0, 9.0, -3.0, 9.0, -8.0, 1.0, -7.0, -8.0, -9.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[16], mat3x4(-2.0, 9.0, -3.0, -1.0, -8.0, 5.0, 9.0, -3.0, 7.0, 2.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[17], mat3x4(0.0, 7.0, -2.0, 1.0, 7.0, 1.0, -5.0, 4.0, 4.0, -5.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[18], mat3x4(0.0, -3.0, -6.0, 4.0, -8.0, -1.0, 9.0, 9.0, 2.0, 9.0, -6.0, -8.0)) && allOk;
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

}
#version 450
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
	lowp uvec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((block.var), uvec3(9u, 0u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (uvec3(7u, 4u, 8u));
}
#version 450
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
	allOk = compare_mat2(block.var, mat2(-9.0, 9.0, 2.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2(-9.0, 9.0, -6.0, -6.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 0.0) && allOk;
	allOk = compare_float(block.var[0][1], 4.0) && allOk;
	allOk = compare_float(block.var[0][2], -6.0) && allOk;
	allOk = compare_float(block.var[1][0], -4.0) && allOk;
	allOk = compare_float(block.var[1][1], -8.0) && allOk;
	allOk = compare_float(block.var[1][2], 0.0) && allOk;
	allOk = compare_float(block.var[2][0], -1.0) && allOk;
	allOk = compare_float(block.var[2][1], -6.0) && allOk;
	allOk = compare_float(block.var[2][2], -7.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(0.0, 4.0, -6.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-4.0, -8.0, 0.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(-1.0, -6.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(-8.0, 5.0, -6.0));
	block.var[1] = (vec3(3.0, -6.0, 8.0));
	block.var[2] = (vec3(-7.0, 4.0, -4.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -2.0) && allOk;
	allOk = compare_float(block.var[0][1], -4.0) && allOk;
	allOk = compare_float(block.var[0][2], -7.0) && allOk;
	allOk = compare_float(block.var[1][0], -1.0) && allOk;
	allOk = compare_float(block.var[1][1], 3.0) && allOk;
	allOk = compare_float(block.var[1][2], -3.0) && allOk;
	allOk = compare_float(block.var[2][0], -2.0) && allOk;
	allOk = compare_float(block.var[2][1], 9.0) && allOk;
	allOk = compare_float(block.var[2][2], 9.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-2.0, -4.0, -7.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-1.0, 3.0, -3.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(-2.0, 9.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3(-9.0, 4.0, -5.0, 5.0, 0.0, 3.0, -6.0, 8.0, -3.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -7.0) && allOk;
	allOk = compare_float(block.var[0][1], -4.0) && allOk;
	allOk = compare_float(block.var[0][2], 1.0) && allOk;
	allOk = compare_float(block.var[0][3], -5.0) && allOk;
	allOk = compare_float(block.var[1][0], 2.0) && allOk;
	allOk = compare_float(block.var[1][1], 8.0) && allOk;
	allOk = compare_float(block.var[1][2], 3.0) && allOk;
	allOk = compare_float(block.var[1][3], -8.0) && allOk;
	allOk = compare_float(block.var[2][0], 2.0) && allOk;
	allOk = compare_float(block.var[2][1], 8.0) && allOk;
	allOk = compare_float(block.var[2][2], 3.0) && allOk;
	allOk = compare_float(block.var[2][3], -6.0) && allOk;
	allOk = compare_float(block.var[3][0], -5.0) && allOk;
	allOk = compare_float(block.var[3][1], -5.0) && allOk;
	allOk = compare_float(block.var[3][2], -8.0) && allOk;
	allOk = compare_float(block.var[3][3], -8.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-7.0, -4.0, 1.0, -5.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(2.0, 8.0, 3.0, -8.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(2.0, 8.0, 3.0, -6.0)) && allOk;
	allOk = compare_vec4(block.var[3], vec4(-5.0, -5.0, -8.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4(-5.0, 1.0, -7.0, 4.0, 0.0, 8.0, 8.0, 0.0, 6.0, 7.0, 7.0, -5.0, 7.0, -7.0, 8.0, -5.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 1.0) && allOk;
	allOk = compare_float(block.var[0][1], 2.0) && allOk;
	allOk = compare_float(block.var[0][2], -5.0) && allOk;
	allOk = compare_float(block.var[1][0], -4.0) && allOk;
	allOk = compare_float(block.var[1][1], 8.0) && allOk;
	allOk = compare_float(block.var[1][2], 3.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(1.0, 2.0, -5.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-4.0, 8.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x3(6.0, 8.0, 5.0, 2.0, -2.0, -1.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var, mat2x4(6.0, 0.0, 4.0, 4.0, -2.0, 5.0, -5.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x4(-1.0, 4.0, -9.0, -4.0, 5.0, -3.0, 6.0, -2.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var, mat3x2(2.0, -9.0, -3.0, 3.0, -5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x2(-9.0, 0.0, 7.0, 6.0, 0.0, 3.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 1.0) && allOk;
	allOk = compare_float(block.var[0][1], 3.0) && allOk;
	allOk = compare_float(block.var[1][0], 9.0) && allOk;
	allOk = compare_float(block.var[1][1], -5.0) && allOk;
	allOk = compare_float(block.var[2][0], -6.0) && allOk;
	allOk = compare_float(block.var[2][1], 3.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(1.0, 3.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(9.0, -5.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(-6.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(-6.0, -9.0));
	block.var[1] = (vec2(-3.0, 1.0));
	block.var[2] = (vec2(7.0, -8.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var, mat4x2(3.0, 8.0, -6.0, -8.0, -3.0, 7.0, -7.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(-7.0, 5.0));
	block.var[1] = (vec2(-3.0, 5.0));
	block.var[2] = (vec2(-2.0, -4.0));
	block.var[3] = (vec2(1.0, -8.0));
}
#version 450
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
	highp vec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((block.var), vec2(6.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (vec2(7.0, -3.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var, mat2x3(-1.0, -1.0, 3.0, 5.0, 6.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x3(-9.0, -1.0, -7.0, 6.0, 0.0, -8.0));
}
#version 450
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

layout(std430, column_major, buffer_reference) buffer Block
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
	allOk = compare_float(block.var[0][0], -7.0) && allOk;
	allOk = compare_float(block.var[0][1], -4.0) && allOk;
	allOk = compare_float(block.var[0][2], 2.0) && allOk;
	allOk = compare_float(block.var[0][3], 2.0) && allOk;
	allOk = compare_float(block.var[1][0], 3.0) && allOk;
	allOk = compare_float(block.var[1][1], -9.0) && allOk;
	allOk = compare_float(block.var[1][2], -5.0) && allOk;
	allOk = compare_float(block.var[1][3], -1.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-7.0, -4.0, 2.0, 2.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(3.0, -9.0, -5.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x4(0.0, 9.0, 8.0, 6.0, 6.0, 7.0, -3.0, 2.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var, mat4x2(-9.0, -6.0, 0.0, 3.0, -8.0, 9.0, -8.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(-8.0, -2.0));
	block.var[1] = (vec2(-8.0, -4.0));
	block.var[2] = (vec2(5.0, 6.0));
	block.var[3] = (vec2(-2.0, 5.0));
}
#version 450
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
	u16vec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(block.var), uvec2(8u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = u16vec2(uvec2(8u, 0u));
}
#version 450
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
	highp uvec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((block.padding), 0u) && allOk;
	allOk = compare_uvec4((block.var), uvec4(2u, 6u, 7u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2u);
	block.var = (uvec4(1u, 9u, 1u, 8u));
}
#version 450
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
	allOk = compare_mat3x4(block.var, mat3x4(-5.0, -3.0, 4.0, 0.0, 4.0, -6.0, 9.0, 3.0, 2.0, 0.0, -9.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2.0);
	block.var = (mat3x4(6.0, -2.0, -9.0, -5.0, 6.0, -9.0, -5.0, 5.0, -4.0, 9.0, -7.0, 3.0));
}
#version 450
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
	allOk = compare_float((block.padding), -6.0) && allOk;
	allOk = compare_float(block.var[0][0], 3.0) && allOk;
	allOk = compare_float(block.var[0][1], 6.0) && allOk;
	allOk = compare_float(block.var[0][2], -9.0) && allOk;
	allOk = compare_float(block.var[0][3], -1.0) && allOk;
	allOk = compare_float(block.var[1][0], 8.0) && allOk;
	allOk = compare_float(block.var[1][1], 5.0) && allOk;
	allOk = compare_float(block.var[1][2], 5.0) && allOk;
	allOk = compare_float(block.var[1][3], -5.0) && allOk;
	allOk = compare_float(block.var[2][0], 5.0) && allOk;
	allOk = compare_float(block.var[2][1], -7.0) && allOk;
	allOk = compare_float(block.var[2][2], 5.0) && allOk;
	allOk = compare_float(block.var[2][3], -7.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(3.0, 6.0, -9.0, -1.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(8.0, 5.0, 5.0, -5.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(5.0, -7.0, 5.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-6.0);
	block.var = (mat3x4(-1.0, 0.0, -8.0, 5.0, 7.0, -2.0, -2.0, -1.0, -7.0, -3.0, -4.0, 5.0));
}
#version 450
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
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_mat4x3(block.var, mat4x3(-2.0, 7.0, 7.0, 9.0, -5.0, -1.0, 8.0, 2.0, 7.0, 4.0, -1.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (4.0);
	block.var = (mat4x3(6.0, -8.0, 8.0, -7.0, 4.0, -4.0, -7.0, -4.0, 0.0, -8.0, 3.0, 6.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var, mat4x3(3.0, -8.0, 6.0, -6.0, -5.0, -8.0, 8.0, 3.0, 4.0, -2.0, 2.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (8.0);
	block.var = (mat4x3(-8.0, 6.0, 8.0, 3.0, -3.0, 9.0, 7.0, 3.0, -6.0, 6.0, 0.0, -9.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0], mat4x2(0.0, 6.0, -3.0, 7.0, 1.0, -8.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(2.0, -3.0, -5.0, 5.0, 5.0, 1.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(1.0, 1.0, -2.0, -3.0, -9.0, 3.0, 9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4x2(8.0, -5.0, 3.0, 0.0, -9.0, 4.0, -5.0, 3.0));
	block.var[1] = (mat4x2(6.0, 3.0, 6.0, -6.0, 0.0, -3.0, -2.0, -4.0));
	block.var[2] = (mat4x2(5.0, 4.0, 1.0, 0.0, 7.0, -9.0, -4.0, 5.0));
}
#version 450
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
	allOk = compare_float((block.padding), 9.0) && allOk;
	allOk = compare_mat4(block.var[0], mat4(0.0, -9.0, -9.0, 5.0, -4.0, 8.0, 7.0, 8.0, -4.0, -5.0, -7.0, 8.0, 9.0, -2.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[1], mat4(4.0, 1.0, -3.0, 3.0, -2.0, -9.0, 6.0, -5.0, 3.0, 1.0, 3.0, -4.0, -9.0, 1.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[2], mat4(-8.0, 2.0, 0.0, -3.0, -8.0, 3.0, -7.0, 8.0, -5.0, -6.0, -1.0, -7.0, 5.0, -3.0, 3.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-3.0);
	block.var[0] = (mat4(-8.0, 5.0, -8.0, 8.0, -2.0, 8.0, 1.0, -9.0, 5.0, -7.0, -7.0, -5.0, -8.0, 9.0, -1.0, 1.0));
	block.var[1] = (mat4(6.0, -3.0, 2.0, -1.0, -8.0, -2.0, 0.0, -9.0, 3.0, 5.0, -5.0, -1.0, 1.0, -5.0, -2.0, 1.0));
	block.var[2] = (mat4(-7.0, 1.0, 9.0, -4.0, 9.0, 7.0, 0.0, -4.0, -7.0, -9.0, -6.0, 0.0, -9.0, -8.0, -5.0, 2.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0], mat4(6.0, 9.0, -9.0, 2.0, -1.0, -3.0, 3.0, 6.0, 5.0, 1.0, -3.0, -2.0, 3.0, -6.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[1], mat4(8.0, 2.0, 9.0, 5.0, 5.0, 3.0, -9.0, -5.0, -8.0, 6.0, -6.0, -7.0, -6.0, 0.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[2], mat4(-3.0, 5.0, 8.0, -1.0, -4.0, 4.0, 3.0, -8.0, 1.0, -1.0, 7.0, 4.0, -2.0, 1.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[3], mat4(4.0, 1.0, -4.0, 3.0, 4.0, -1.0, -9.0, 8.0, 1.0, -9.0, -9.0, -8.0, 1.0, 0.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[4], mat4(1.0, -4.0, 9.0, -7.0, -6.0, -2.0, -7.0, -4.0, 1.0, 2.0, 6.0, -8.0, 3.0, -2.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[5], mat4(-9.0, 7.0, -4.0, -2.0, 4.0, 5.0, 5.0, -2.0, 4.0, -6.0, 1.0, -3.0, -4.0, 6.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[6], mat4(-7.0, -5.0, -1.0, -9.0, -5.0, 6.0, -9.0, 5.0, 2.0, -2.0, -8.0, 4.0, -3.0, 7.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[7], mat4(8.0, 4.0, 5.0, 8.0, -5.0, 9.0, 7.0, 1.0, -8.0, -2.0, -1.0, -2.0, -8.0, -2.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[8], mat4(3.0, 0.0, -4.0, -2.0, -4.0, 0.0, -6.0, 4.0, 0.0, 1.0, -6.0, -3.0, 6.0, -1.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[9], mat4(-3.0, 5.0, -5.0, 7.0, -3.0, -5.0, 5.0, 9.0, 1.0, 8.0, -5.0, 8.0, 9.0, 0.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[10], mat4(3.0, 1.0, 2.0, -2.0, -6.0, 0.0, 3.0, 9.0, 3.0, 0.0, 2.0, 8.0, 7.0, -6.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[11], mat4(-3.0, 8.0, 8.0, 7.0, 0.0, 0.0, 3.0, 0.0, -3.0, -4.0, 5.0, -6.0, 4.0, -4.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[12], mat4(7.0, 2.0, -1.0, 1.0, 5.0, -3.0, 1.0, 4.0, -4.0, 9.0, -1.0, 3.0, -1.0, -6.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[13], mat4(-9.0, 5.0, -4.0, 9.0, 0.0, -8.0, 3.0, -9.0, -3.0, -7.0, -2.0, -9.0, -9.0, 5.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[14], mat4(-8.0, 2.0, -5.0, 2.0, -4.0, 3.0, -8.0, 7.0, 2.0, -8.0, 3.0, -9.0, 2.0, -1.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[15], mat4(3.0, 1.0, 0.0, 3.0, -2.0, -4.0, 2.0, 4.0, 9.0, -4.0, 0.0, -2.0, -9.0, 6.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[16], mat4(-9.0, 1.0, 0.0, -6.0, 2.0, -3.0, 5.0, -9.0, -7.0, -4.0, -1.0, -8.0, 7.0, -3.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[17], mat4(1.0, 3.0, -1.0, 1.0, 2.0, -3.0, 6.0, -8.0, 2.0, 7.0, -8.0, 5.0, -3.0, 2.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[18], mat4(5.0, -1.0, 9.0, -9.0, -4.0, 1.0, -2.0, 0.0, -1.0, -4.0, -4.0, -4.0, 1.0, 3.0, -9.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec4(0.0, -7.0, -8.0, 3.0));
	block.var[0][1] = (vec4(-4.0, 2.0, 2.0, 9.0));
	block.var[0][2] = (vec4(0.0, 4.0, -1.0, -5.0));
	block.var[0][3] = (vec4(4.0, 0.0, -6.0, -6.0));
	block.var[1][0] = (vec4(-6.0, 3.0, 9.0, -6.0));
	block.var[1][1] = (vec4(2.0, 5.0, 4.0, -7.0));
	block.var[1][2] = (vec4(1.0, -4.0, 3.0, 5.0));
	block.var[1][3] = (vec4(-6.0, 0.0, -6.0, -4.0));
	block.var[2][0] = (vec4(1.0, 6.0, 0.0, 8.0));
	block.var[2][1] = (vec4(-9.0, 0.0, 8.0, 4.0));
	block.var[2][2] = (vec4(-2.0, -5.0, -6.0, -8.0));
	block.var[2][3] = (vec4(-5.0, 8.0, 8.0, -7.0));
	block.var[3][0] = (vec4(4.0, -5.0, 7.0, 9.0));
	block.var[3][1] = (vec4(4.0, -5.0, 4.0, -7.0));
	block.var[3][2] = (vec4(6.0, -1.0, 4.0, 5.0));
	block.var[3][3] = (vec4(-7.0, 7.0, 7.0, -6.0));
	block.var[4][0] = (vec4(-8.0, 9.0, -5.0, 0.0));
	block.var[4][1] = (vec4(5.0, -7.0, 8.0, -7.0));
	block.var[4][2] = (vec4(2.0, -8.0, 8.0, -7.0));
	block.var[4][3] = (vec4(6.0, -4.0, -6.0, -2.0));
	block.var[5][0] = (vec4(7.0, -2.0, -9.0, 2.0));
	block.var[5][1] = (vec4(7.0, -4.0, -9.0, 0.0));
	block.var[5][2] = (vec4(6.0, -3.0, 3.0, 6.0));
	block.var[5][3] = (vec4(3.0, -4.0, 8.0, -2.0));
	block.var[6][0] = (vec4(-7.0, 3.0, -4.0, -1.0));
	block.var[6][1] = (vec4(-6.0, -7.0, -3.0, -9.0));
	block.var[6][2] = (vec4(9.0, -1.0, -3.0, -5.0));
	block.var[6][3] = (vec4(8.0, 1.0, -1.0, -3.0));
	block.var[7][0] = (vec4(-4.0, -2.0, -3.0, 5.0));
	block.var[7][1] = (vec4(-9.0, -3.0, 8.0, 4.0));
	block.var[7][2] = (vec4(2.0, 2.0, 2.0, -1.0));
	block.var[7][3] = (vec4(0.0, -1.0, -1.0, 4.0));
	block.var[8][0] = (vec4(1.0, 1.0, 4.0, -2.0));
	block.var[8][1] = (vec4(5.0, -5.0, 9.0, 2.0));
	block.var[8][2] = (vec4(6.0, -2.0, 5.0, 3.0));
	block.var[8][3] = (vec4(-7.0, 0.0, 4.0, 3.0));
	block.var[9][0] = (vec4(2.0, -7.0, 5.0, 7.0));
	block.var[9][1] = (vec4(-5.0, 0.0, -9.0, -7.0));
	block.var[9][2] = (vec4(2.0, 7.0, -9.0, 7.0));
	block.var[9][3] = (vec4(-2.0, -5.0, 4.0, 3.0));
	block.var[10][0] = (vec4(6.0, 3.0, 8.0, 9.0));
	block.var[10][1] = (vec4(8.0, -4.0, -4.0, 4.0));
	block.var[10][2] = (vec4(-9.0, -3.0, 0.0, -3.0));
	block.var[10][3] = (vec4(0.0, 8.0, -3.0, 6.0));
	block.var[11][0] = (vec4(-8.0, -5.0, 6.0, -7.0));
	block.var[11][1] = (vec4(-6.0, -5.0, 7.0, -6.0));
	block.var[11][2] = (vec4(-1.0, 8.0, 9.0, 6.0));
	block.var[11][3] = (vec4(8.0, -7.0, 0.0, -8.0));
	block.var[12][0] = (vec4(4.0, 9.0, -9.0, 1.0));
	block.var[12][1] = (vec4(-5.0, 7.0, 2.0, -4.0));
	block.var[12][2] = (vec4(-7.0, -5.0, -4.0, -9.0));
	block.var[12][3] = (vec4(6.0, -7.0, 7.0, -2.0));
	block.var[13][0] = (vec4(-3.0, -6.0, 6.0, -4.0));
	block.var[13][1] = (vec4(-2.0, 1.0, 1.0, 9.0));
	block.var[13][2] = (vec4(-3.0, 5.0, 1.0, 7.0));
	block.var[13][3] = (vec4(-2.0, 9.0, -6.0, -6.0));
	block.var[14][0] = (vec4(-8.0, 2.0, 1.0, -8.0));
	block.var[14][1] = (vec4(5.0, -3.0, 8.0, 1.0));
	block.var[14][2] = (vec4(7.0, -4.0, 8.0, -5.0));
	block.var[14][3] = (vec4(-6.0, -1.0, 9.0, -9.0));
	block.var[15][0] = (vec4(3.0, -3.0, 3.0, -8.0));
	block.var[15][1] = (vec4(2.0, -3.0, -6.0, -2.0));
	block.var[15][2] = (vec4(-3.0, -9.0, -6.0, -3.0));
	block.var[15][3] = (vec4(8.0, 4.0, 6.0, 7.0));
	block.var[16][0] = (vec4(7.0, -9.0, 8.0, -1.0));
	block.var[16][1] = (vec4(9.0, 5.0, 8.0, -4.0));
	block.var[16][2] = (vec4(-8.0, -2.0, -3.0, 3.0));
	block.var[16][3] = (vec4(6.0, 4.0, 0.0, -1.0));
	block.var[17][0] = (vec4(6.0, 3.0, 4.0, -9.0));
	block.var[17][1] = (vec4(5.0, 5.0, 8.0, -6.0));
	block.var[17][2] = (vec4(8.0, 3.0, -1.0, -4.0));
	block.var[17][3] = (vec4(-4.0, 1.0, 4.0, -4.0));
	block.var[18][0] = (vec4(-5.0, 7.0, -6.0, -2.0));
	block.var[18][1] = (vec4(-1.0, -6.0, 6.0, 7.0));
	block.var[18][2] = (vec4(-6.0, 2.0, 9.0, -1.0));
	block.var[18][3] = (vec4(-1.0, 0.0, -7.0, 8.0));
}
#version 450
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
	u8vec4 var[];
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
	allOk = compare_u8vec4(uvec4(block.var[3]), uvec4(7u, 7u, 6u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[4]), uvec4(3u, 3u, 3u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[5]), uvec4(7u, 2u, 2u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[6]), uvec4(6u, 9u, 5u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[7]), uvec4(5u, 2u, 0u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[8]), uvec4(8u, 3u, 7u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[9]), uvec4(5u, 7u, 4u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[10]), uvec4(5u, 8u, 5u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[11]), uvec4(8u, 6u, 3u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[12]), uvec4(6u, 5u, 4u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[13]), uvec4(8u, 7u, 8u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[14]), uvec4(9u, 5u, 6u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[15]), uvec4(7u, 5u, 4u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[16]), uvec4(1u, 0u, 6u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[17]), uvec4(1u, 3u, 8u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[18]), uvec4(1u, 4u, 1u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = u8vec4(uvec4(9u, 5u, 9u, 4u));
	block.var[1] = u8vec4(uvec4(6u, 8u, 7u, 3u));
	block.var[2] = u8vec4(uvec4(6u, 7u, 1u, 9u));
	block.var[3] = u8vec4(uvec4(8u, 9u, 3u, 3u));
	block.var[4] = u8vec4(uvec4(3u, 9u, 0u, 6u));
	block.var[5] = u8vec4(uvec4(8u, 7u, 6u, 7u));
	block.var[6] = u8vec4(uvec4(7u, 7u, 4u, 8u));
	block.var[7] = u8vec4(uvec4(8u, 5u, 3u, 1u));
	block.var[8] = u8vec4(uvec4(1u, 4u, 7u, 1u));
	block.var[9] = u8vec4(uvec4(3u, 6u, 3u, 3u));
	block.var[10] = u8vec4(uvec4(4u, 7u, 8u, 8u));
	block.var[11] = u8vec4(uvec4(1u, 7u, 7u, 2u));
	block.var[12] = u8vec4(uvec4(5u, 2u, 7u, 4u));
	block.var[13] = u8vec4(uvec4(8u, 9u, 1u, 4u));
	block.var[14] = u8vec4(uvec4(7u, 0u, 8u, 1u));
	block.var[15] = u8vec4(uvec4(0u, 4u, 9u, 9u));
	block.var[16] = u8vec4(uvec4(9u, 3u, 5u, 3u));
	block.var[17] = u8vec4(uvec4(1u, 4u, 3u, 3u));
	block.var[18] = u8vec4(uvec4(8u, 9u, 4u, 7u));
}
#version 450
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
	i16vec2 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(block.var[0]), ivec2(3, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1]), ivec2(8, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2]), ivec2(-4, 2)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[3]), ivec2(-1, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[4]), ivec2(-1, -9)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[5]), ivec2(-1, -7)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[6]), ivec2(-6, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[7]), ivec2(-5, 6)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[8]), ivec2(-1, 8)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[9]), ivec2(1, 1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[10]), ivec2(6, -6)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[11]), ivec2(1, 1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[12]), ivec2(-1, 2)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[13]), ivec2(0, -4)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[14]), ivec2(-2, -2)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[15]), ivec2(1, 0)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[16]), ivec2(-5, -5)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[17]), ivec2(-8, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[18]), ivec2(-2, -8)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = i16vec2(ivec2(6, -2));
	block.var[1] = i16vec2(ivec2(-2, -8));
	block.var[2] = i16vec2(ivec2(3, 5));
	block.var[3] = i16vec2(ivec2(-9, -9));
	block.var[4] = i16vec2(ivec2(-4, -3));
	block.var[5] = i16vec2(ivec2(-2, 6));
	block.var[6] = i16vec2(ivec2(0, -1));
	block.var[7] = i16vec2(ivec2(3, -9));
	block.var[8] = i16vec2(ivec2(9, -6));
	block.var[9] = i16vec2(ivec2(-1, -7));
	block.var[10] = i16vec2(ivec2(-1, -6));
	block.var[11] = i16vec2(ivec2(6, 5));
	block.var[12] = i16vec2(ivec2(6, 9));
	block.var[13] = i16vec2(ivec2(0, 9));
	block.var[14] = i16vec2(ivec2(0, 5));
	block.var[15] = i16vec2(ivec2(9, -8));
	block.var[16] = i16vec2(ivec2(4, 6));
	block.var[17] = i16vec2(ivec2(-9, -9));
	block.var[18] = i16vec2(ivec2(4, 1));
}
#version 450
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
	highp uvec4 var[];
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
	allOk = compare_uvec4((block.var[3]), uvec4(2u, 3u, 3u, 6u)) && allOk;
	allOk = compare_uvec4((block.var[4]), uvec4(0u, 7u, 0u, 0u)) && allOk;
	allOk = compare_uvec4((block.var[5]), uvec4(2u, 8u, 5u, 1u)) && allOk;
	allOk = compare_uvec4((block.var[6]), uvec4(7u, 3u, 1u, 5u)) && allOk;
	allOk = compare_uvec4((block.var[7]), uvec4(8u, 7u, 6u, 2u)) && allOk;
	allOk = compare_uvec4((block.var[8]), uvec4(5u, 9u, 5u, 9u)) && allOk;
	allOk = compare_uvec4((block.var[9]), uvec4(1u, 6u, 2u, 1u)) && allOk;
	allOk = compare_uvec4((block.var[10]), uvec4(7u, 9u, 5u, 3u)) && allOk;
	allOk = compare_uvec4((block.var[11]), uvec4(5u, 7u, 4u, 7u)) && allOk;
	allOk = compare_uvec4((block.var[12]), uvec4(8u, 5u, 8u, 5u)) && allOk;
	allOk = compare_uvec4((block.var[13]), uvec4(3u, 6u, 1u, 2u)) && allOk;
	allOk = compare_uvec4((block.var[14]), uvec4(4u, 0u, 8u, 0u)) && allOk;
	allOk = compare_uvec4((block.var[15]), uvec4(6u, 2u, 8u, 7u)) && allOk;
	allOk = compare_uvec4((block.var[16]), uvec4(5u, 8u, 6u, 1u)) && allOk;
	allOk = compare_uvec4((block.var[17]), uvec4(9u, 8u, 2u, 8u)) && allOk;
	allOk = compare_uvec4((block.var[18]), uvec4(9u, 6u, 7u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (uvec4(2u, 7u, 2u, 9u));
	block.var[1] = (uvec4(7u, 9u, 5u, 1u));
	block.var[2] = (uvec4(3u, 4u, 4u, 2u));
	block.var[3] = (uvec4(0u, 5u, 6u, 2u));
	block.var[4] = (uvec4(9u, 5u, 7u, 7u));
	block.var[5] = (uvec4(0u, 3u, 8u, 1u));
	block.var[6] = (uvec4(4u, 9u, 1u, 3u));
	block.var[7] = (uvec4(8u, 8u, 8u, 1u));
	block.var[8] = (uvec4(7u, 5u, 4u, 8u));
	block.var[9] = (uvec4(6u, 6u, 0u, 9u));
	block.var[10] = (uvec4(7u, 2u, 3u, 0u));
	block.var[11] = (uvec4(4u, 4u, 8u, 5u));
	block.var[12] = (uvec4(6u, 1u, 9u, 4u));
	block.var[13] = (uvec4(5u, 7u, 7u, 0u));
	block.var[14] = (uvec4(2u, 5u, 1u, 3u));
	block.var[15] = (uvec4(9u, 6u, 1u, 2u));
	block.var[16] = (uvec4(0u, 0u, 8u, 4u));
	block.var[17] = (uvec4(9u, 5u, 7u, 1u));
	block.var[18] = (uvec4(2u, 0u, 0u, 4u));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0], mat3x2(5.0, -6.0, -5.0, 5.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1], mat3x2(-5.0, -6.0, -8.0, 6.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2], mat3x2(2.0, -8.0, 9.0, -8.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[3], mat3x2(5.0, 0.0, 4.0, 3.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[4], mat3x2(-1.0, -1.0, -2.0, -8.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[5], mat3x2(-8.0, -6.0, 0.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[6], mat3x2(-1.0, 7.0, -4.0, 3.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[7], mat3x2(-5.0, -2.0, 0.0, -2.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[8], mat3x2(-7.0, -4.0, 1.0, -1.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[9], mat3x2(-8.0, -7.0, -1.0, -4.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[10], mat3x2(7.0, 9.0, 8.0, 2.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[11], mat3x2(8.0, -3.0, 8.0, -5.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[12], mat3x2(-1.0, 7.0, 3.0, 8.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[13], mat3x2(6.0, -7.0, 7.0, 5.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[14], mat3x2(9.0, 0.0, 2.0, -5.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[15], mat3x2(-5.0, 6.0, -3.0, 2.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[16], mat3x2(9.0, -6.0, -8.0, -7.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[17], mat3x2(-2.0, -1.0, 1.0, 6.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[18], mat3x2(1.0, -2.0, -2.0, -9.0, 8.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3x2(-1.0, -5.0, -1.0, -8.0, 7.0, 8.0));
	block.var[1] = (mat3x2(-4.0, -8.0, 1.0, 5.0, -2.0, 7.0));
	block.var[2] = (mat3x2(4.0, -6.0, 7.0, -6.0, 2.0, 5.0));
	block.var[3] = (mat3x2(0.0, 6.0, -5.0, 4.0, -2.0, 0.0));
	block.var[4] = (mat3x2(-3.0, -3.0, -2.0, 9.0, -2.0, -7.0));
	block.var[5] = (mat3x2(-9.0, -2.0, -8.0, 4.0, 3.0, 8.0));
	block.var[6] = (mat3x2(7.0, 9.0, -5.0, 9.0, -1.0, 4.0));
	block.var[7] = (mat3x2(6.0, -4.0, -6.0, 0.0, 7.0, -2.0));
	block.var[8] = (mat3x2(-1.0, -9.0, 8.0, -6.0, -9.0, 5.0));
	block.var[9] = (mat3x2(2.0, -9.0, 9.0, 4.0, -4.0, 9.0));
	block.var[10] = (mat3x2(3.0, 3.0, 1.0, -4.0, 0.0, -7.0));
	block.var[11] = (mat3x2(-4.0, 7.0, 7.0, -1.0, -2.0, 6.0));
	block.var[12] = (mat3x2(4.0, -9.0, -8.0, 7.0, -5.0, -1.0));
	block.var[13] = (mat3x2(-7.0, 4.0, -2.0, -6.0, -5.0, 6.0));
	block.var[14] = (mat3x2(-3.0, -7.0, 9.0, 9.0, -8.0, 0.0));
	block.var[15] = (mat3x2(6.0, -3.0, 9.0, -2.0, -5.0, -4.0));
	block.var[16] = (mat3x2(-4.0, 6.0, -7.0, 5.0, -1.0, 5.0));
	block.var[17] = (mat3x2(4.0, -7.0, -3.0, 6.0, -8.0, 2.0));
	block.var[18] = (mat3x2(-3.0, -4.0, -7.0, 0.0, 8.0, 4.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0], mat3x2(-5.0, -8.0, -4.0, 7.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1], mat3x2(-7.0, 4.0, 3.0, -1.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2], mat3x2(-6.0, -3.0, -8.0, 5.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0], mat3x2(2.0, 6.0, -1.0, -9.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1], mat3x2(-8.0, 3.0, 1.0, -2.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2], mat3x2(0.0, 4.0, 0.0, 1.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0], mat3x2(9.0, 7.0, 4.0, -7.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1], mat3x2(-3.0, 1.0, 1.0, -4.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2], mat3x2(-7.0, 4.0, 1.0, 0.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0], mat3x2(3.0, -5.0, 6.0, 8.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1], mat3x2(-6.0, 3.0, -6.0, 0.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][2], mat3x2(-1.0, 0.0, -5.0, -6.0, 5.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat3x2(-3.0, 7.0, -3.0, -4.0, 2.0, -7.0));
	block.var[0][1] = (mat3x2(-2.0, 9.0, -8.0, -2.0, 3.0, 4.0));
	block.var[0][2] = (mat3x2(4.0, 1.0, -7.0, 9.0, 9.0, -1.0));
	block.var[1][0] = (mat3x2(-9.0, 3.0, 0.0, -8.0, -3.0, 8.0));
	block.var[1][1] = (mat3x2(5.0, 0.0, 9.0, 0.0, 9.0, 8.0));
	block.var[1][2] = (mat3x2(2.0, 6.0, 0.0, 7.0, 6.0, 4.0));
	block.var[2][0] = (mat3x2(9.0, 7.0, 7.0, -2.0, 8.0, 3.0));
	block.var[2][1] = (mat3x2(-9.0, 8.0, 4.0, -5.0, 3.0, -6.0));
	block.var[2][2] = (mat3x2(7.0, 2.0, 6.0, 3.0, 5.0, 1.0));
	block.var[3][0] = (mat3x2(0.0, 8.0, -4.0, 0.0, -9.0, 0.0));
	block.var[3][1] = (mat3x2(7.0, 3.0, 5.0, -1.0, 3.0, -3.0));
	block.var[3][2] = (mat3x2(-2.0, 1.0, 0.0, -5.0, -9.0, -4.0));
}
#version 450
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
	f16vec4 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(block.var[0][0]), vec4(-8.0, -9.0, 9.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[0][1]), vec4(4.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[0][2]), vec4(-8.0, 6.0, 1.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[1][0]), vec4(4.0, 7.0, 5.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[1][1]), vec4(7.0, -4.0, -8.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[1][2]), vec4(-3.0, 6.0, -4.0, 5.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[2][0]), vec4(2.0, 3.0, -3.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[2][1]), vec4(9.0, -9.0, 0.0, 3.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[2][2]), vec4(2.0, -2.0, -4.0, -2.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[3][0]), vec4(-6.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[3][1]), vec4(7.0, 5.0, -9.0, 9.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[3][2]), vec4(8.0, 7.0, 9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = f16vec4(vec4(9.0, -6.0, 2.0, -8.0));
	block.var[0][1] = f16vec4(vec4(-7.0, -4.0, 2.0, -5.0));
	block.var[0][2] = f16vec4(vec4(9.0, 1.0, -6.0, 3.0));
	block.var[1][0] = f16vec4(vec4(-1.0, 4.0, -1.0, -8.0));
	block.var[1][1] = f16vec4(vec4(5.0, 8.0, 7.0, 0.0));
	block.var[1][2] = f16vec4(vec4(4.0, -5.0, -6.0, -8.0));
	block.var[2][0] = f16vec4(vec4(-6.0, 2.0, -4.0, 8.0));
	block.var[2][1] = f16vec4(vec4(-4.0, -1.0, 8.0, 9.0));
	block.var[2][2] = f16vec4(vec4(0.0, 0.0, -5.0, 5.0));
	block.var[3][0] = f16vec4(vec4(7.0, -6.0, -7.0, -8.0));
	block.var[3][1] = f16vec4(vec4(-3.0, -4.0, -7.0, 0.0));
	block.var[3][2] = f16vec4(vec4(-7.0, -2.0, 7.0, -1.0));
}
#version 450
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

layout(std430, column_major, buffer_reference) buffer Block
{
	highp mat4x3 var[4][3];
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
	allOk = compare_mat4x3(block.var[0][0], mat4x3(-7.0, 1.0, 0.0, 0.0, -7.0, 2.0, 5.0, 0.0, 3.0, 2.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1], mat4x3(-7.0, -5.0, 2.0, 0.0, -1.0, -5.0, 5.0, 5.0, 9.0, -7.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2], mat4x3(3.0, 6.0, -7.0, 7.0, 8.0, 6.0, -7.0, -8.0, -5.0, -9.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0], mat4x3(-7.0, -7.0, 7.0, 2.0, -5.0, 3.0, 2.0, 0.0, 8.0, -1.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1], mat4x3(-8.0, 6.0, 2.0, -5.0, -7.0, -7.0, -4.0, -9.0, 7.0, 3.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2], mat4x3(-7.0, 7.0, 6.0, 3.0, 4.0, 5.0, -2.0, 3.0, 8.0, -7.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0], mat4x3(0.0, 7.0, 1.0, -2.0, 9.0, -5.0, -3.0, 1.0, -6.0, 6.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1], mat4x3(9.0, 8.0, 5.0, 4.0, 7.0, -1.0, 6.0, -6.0, 2.0, 8.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2], mat4x3(0.0, 6.0, -8.0, -4.0, -8.0, 8.0, -5.0, 7.0, 3.0, 9.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0], mat4x3(6.0, -3.0, 0.0, -3.0, 2.0, -8.0, 6.0, 5.0, -2.0, 2.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1], mat4x3(-7.0, 4.0, 5.0, -8.0, -1.0, -2.0, -8.0, -4.0, 2.0, 8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][2], mat4x3(4.0, -1.0, 3.0, 3.0, -3.0, 4.0, -6.0, -5.0, 1.0, 4.0, -4.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat4x3(7.0, 8.0, 8.0, -3.0, -9.0, 2.0, -6.0, 0.0, -4.0, -3.0, 4.0, -8.0));
	block.var[0][1] = (mat4x3(4.0, -2.0, 2.0, 8.0, 4.0, -1.0, -8.0, -6.0, -4.0, 9.0, -2.0, 1.0));
	block.var[0][2] = (mat4x3(-7.0, -4.0, -4.0, -1.0, 7.0, -6.0, 4.0, 6.0, 7.0, -9.0, -8.0, 3.0));
	block.var[1][0] = (mat4x3(-6.0, -5.0, 6.0, -2.0, -7.0, 5.0, 4.0, -6.0, -4.0, -7.0, 2.0, -7.0));
	block.var[1][1] = (mat4x3(-6.0, 5.0, -6.0, 9.0, -8.0, -5.0, -2.0, -8.0, -9.0, -8.0, -1.0, 2.0));
	block.var[1][2] = (mat4x3(-7.0, -2.0, 1.0, 0.0, 8.0, -7.0, 0.0, 0.0, 7.0, 0.0, -4.0, -7.0));
	block.var[2][0] = (mat4x3(-9.0, -7.0, 2.0, 2.0, 6.0, 9.0, 9.0, 5.0, -3.0, -4.0, -1.0, -5.0));
	block.var[2][1] = (mat4x3(-8.0, -4.0, -2.0, 7.0, 3.0, -9.0, 8.0, 1.0, -1.0, -7.0, -6.0, 2.0));
	block.var[2][2] = (mat4x3(-3.0, -7.0, 7.0, -5.0, 5.0, -8.0, 4.0, 8.0, -9.0, 6.0, -3.0, 2.0));
	block.var[3][0] = (mat4x3(3.0, -8.0, 6.0, -2.0, 8.0, -2.0, -2.0, -5.0, -1.0, -7.0, -9.0, 3.0));
	block.var[3][1] = (mat4x3(-6.0, -9.0, -4.0, -6.0, -1.0, -8.0, 9.0, 6.0, -8.0, -6.0, -5.0, 1.0));
	block.var[3][2] = (mat4x3(-1.0, -9.0, 4.0, 0.0, 9.0, 3.0, 5.0, 7.0, -4.0, -7.0, 3.0, 9.0));
}
#version 450
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
	u8vec4 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(block.var[0][0]), uvec4(3u, 4u, 6u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[0][1]), uvec4(1u, 5u, 7u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[0][2]), uvec4(1u, 4u, 6u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[1][0]), uvec4(7u, 7u, 6u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[1][1]), uvec4(3u, 3u, 3u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[1][2]), uvec4(7u, 2u, 2u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[2][0]), uvec4(6u, 9u, 5u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[2][1]), uvec4(5u, 2u, 0u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[2][2]), uvec4(8u, 3u, 7u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[3][0]), uvec4(5u, 7u, 4u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[3][1]), uvec4(5u, 8u, 5u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[3][2]), uvec4(8u, 6u, 3u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = u8vec4(uvec4(9u, 5u, 9u, 4u));
	block.var[0][1] = u8vec4(uvec4(6u, 8u, 7u, 3u));
	block.var[0][2] = u8vec4(uvec4(6u, 7u, 1u, 9u));
	block.var[1][0] = u8vec4(uvec4(8u, 9u, 3u, 3u));
	block.var[1][1] = u8vec4(uvec4(3u, 9u, 0u, 6u));
	block.var[1][2] = u8vec4(uvec4(8u, 7u, 6u, 7u));
	block.var[2][0] = u8vec4(uvec4(7u, 7u, 4u, 8u));
	block.var[2][1] = u8vec4(uvec4(8u, 5u, 3u, 1u));
	block.var[2][2] = u8vec4(uvec4(1u, 4u, 7u, 1u));
	block.var[3][0] = u8vec4(uvec4(3u, 6u, 3u, 3u));
	block.var[3][1] = u8vec4(uvec4(4u, 7u, 8u, 8u));
	block.var[3][2] = u8vec4(uvec4(1u, 7u, 7u, 2u));
}
#version 450
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
	allOk = compare_float((block.padding), 3.0) && allOk;
	allOk = compare_mat3(block.var[0][0], mat3(-9.0, 7.0, 0.0, -1.0, -8.0, 0.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[0][1], mat3(8.0, -4.0, -1.0, 5.0, -5.0, -9.0, -6.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[0][2], mat3(-9.0, 4.0, 5.0, -4.0, -4.0, 6.0, 2.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[1][0], mat3(-8.0, 1.0, -2.0, 6.0, 7.0, 4.0, -7.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[1][1], mat3(-6.0, -4.0, -1.0, -5.0, 3.0, 3.0, -3.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[1][2], mat3(1.0, 6.0, -7.0, 4.0, -7.0, -8.0, -1.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[2][0], mat3(-3.0, 5.0, 3.0, -7.0, -5.0, 0.0, -3.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[2][1], mat3(0.0, -4.0, 2.0, 4.0, -3.0, 6.0, 4.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[2][2], mat3(-2.0, 5.0, 9.0, 8.0, -3.0, -5.0, -5.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[3][0], mat3(0.0, 8.0, -3.0, 5.0, -5.0, 0.0, 8.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[3][1], mat3(-3.0, -8.0, -6.0, -2.0, -4.0, -5.0, 3.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[3][2], mat3(-1.0, 4.0, 7.0, -7.0, 4.0, -7.0, 2.0, 4.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (7.0);
	block.var[0][0] = (mat3(-8.0, -8.0, -4.0, -3.0, 5.0, -3.0, -3.0, -1.0, 5.0));
	block.var[0][1] = (mat3(1.0, -3.0, 9.0, 1.0, 5.0, 0.0, 5.0, -1.0, -7.0));
	block.var[0][2] = (mat3(4.0, 1.0, -6.0, 3.0, 6.0, 1.0, 9.0, 3.0, -9.0));
	block.var[1][0] = (mat3(3.0, -7.0, 6.0, -9.0, 3.0, -9.0, 3.0, -6.0, 4.0));
	block.var[1][1] = (mat3(7.0, -6.0, -7.0, 1.0, -3.0, -6.0, -2.0, 5.0, 7.0));
	block.var[1][2] = (mat3(-6.0, -2.0, -8.0, 7.0, 1.0, 3.0, 4.0, 0.0, 5.0));
	block.var[2][0] = (mat3(4.0, -6.0, -9.0, -4.0, 6.0, -1.0, 8.0, -6.0, -3.0));
	block.var[2][1] = (mat3(6.0, -9.0, 2.0, -5.0, 0.0, -7.0, -5.0, -3.0, -4.0));
	block.var[2][2] = (mat3(-4.0, 8.0, -8.0, -7.0, 7.0, -4.0, -7.0, 8.0, -8.0));
	block.var[3][0] = (mat3(-8.0, -8.0, 1.0, -5.0, -6.0, 8.0, -1.0, 2.0, -3.0));
	block.var[3][1] = (mat3(-8.0, 4.0, 8.0, -2.0, 3.0, -5.0, -9.0, -3.0, 3.0));
	block.var[3][2] = (mat3(-2.0, -2.0, -3.0, 9.0, -6.0, 3.0, 5.0, 5.0, -2.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0][0], mat4(8.0, 5.0, -7.0, -4.0, 0.0, -1.0, -9.0, 2.0, 9.0, 5.0, 5.0, 6.0, 9.0, 8.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[0][1], mat4(1.0, -3.0, 1.0, 0.0, -7.0, -4.0, 0.0, 1.0, -6.0, -7.0, 5.0, 2.0, 0.0, 7.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[0][2], mat4(8.0, 2.0, 3.0, 8.0, -6.0, 7.0, 9.0, -3.0, 7.0, -8.0, -5.0, 6.0, 4.0, -9.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[1][0], mat4(0.0, -6.0, -1.0, 5.0, 0.0, -3.0, -3.0, 6.0, -5.0, 1.0, 4.0, -5.0, -7.0, -2.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[1][1], mat4(-3.0, 2.0, -9.0, 6.0, -8.0, 8.0, 2.0, -3.0, -9.0, 8.0, 1.0, -4.0, -1.0, -5.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[1][2], mat4(-2.0, -1.0, -7.0, 6.0, -6.0, -3.0, -9.0, -3.0, -7.0, -2.0, 2.0, -9.0, -2.0, 0.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[2][0], mat4(-3.0, 7.0, 9.0, 7.0, -1.0, 3.0, 6.0, -3.0, 2.0, -2.0, 7.0, -9.0, 0.0, 0.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[2][1], mat4(-1.0, -6.0, -6.0, 5.0, -8.0, 7.0, 3.0, -6.0, 4.0, -8.0, -1.0, 1.0, 4.0, 2.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[2][2], mat4(-2.0, -4.0, -6.0, -6.0, 8.0, 5.0, -4.0, -7.0, 7.0, -4.0, -9.0, -7.0, -1.0, -3.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[3][0], mat4(-4.0, -1.0, -3.0, 3.0, 2.0, 1.0, -6.0, 3.0, 5.0, -4.0, 0.0, 2.0, -4.0, 5.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[3][1], mat4(-9.0, -6.0, -9.0, -4.0, 2.0, 5.0, 4.0, -6.0, -2.0, -5.0, 7.0, 9.0, -4.0, 1.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[3][2], mat4(1.0, -2.0, 0.0, -7.0, 2.0, -6.0, -5.0, 2.0, -1.0, -8.0, 8.0, 2.0, -9.0, -3.0, -3.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-7.0);
	block.var[0][0][0] = (vec4(-2.0, 7.0, -7.0, 2.0));
	block.var[0][0][1] = (vec4(-4.0, 3.0, -5.0, 2.0));
	block.var[0][0][2] = (vec4(3.0, 8.0, 8.0, 3.0));
	block.var[0][0][3] = (vec4(0.0, -4.0, -1.0, -3.0));
	block.var[0][1][0] = (vec4(0.0, 8.0, 1.0, -8.0));
	block.var[0][1][1] = (vec4(9.0, 2.0, 7.0, -2.0));
	block.var[0][1][2] = (vec4(-7.0, -9.0, 1.0, 6.0));
	block.var[0][1][3] = (vec4(-9.0, -1.0, -5.0, -6.0));
	block.var[0][2][0] = (vec4(-3.0, 7.0, -1.0, 0.0));
	block.var[0][2][1] = (vec4(-1.0, -2.0, 1.0, -3.0));
	block.var[0][2][2] = (vec4(-1.0, -4.0, 7.0, -3.0));
	block.var[0][2][3] = (vec4(1.0, 1.0, -9.0, -3.0));
	block.var[1][0][0] = (vec4(2.0, 9.0, -4.0, 2.0));
	block.var[1][0][1] = (vec4(9.0, -9.0, -2.0, -1.0));
	block.var[1][0][2] = (vec4(1.0, -9.0, 0.0, -7.0));
	block.var[1][0][3] = (vec4(7.0, -3.0, -9.0, -1.0));
	block.var[1][1][0] = (vec4(0.0, 7.0, 7.0, -5.0));
	block.var[1][1][1] = (vec4(-2.0, -6.0, 0.0, -2.0));
	block.var[1][1][2] = (vec4(1.0, -2.0, 4.0, 4.0));
	block.var[1][1][3] = (vec4(0.0, 0.0, -2.0, 4.0));
	block.var[1][2][0] = (vec4(7.0, -5.0, -3.0, 9.0));
	block.var[1][2][1] = (vec4(1.0, 5.0, 5.0, 9.0));
	block.var[1][2][2] = (vec4(-4.0, -6.0, 8.0, 1.0));
	block.var[1][2][3] = (vec4(-5.0, 5.0, -3.0, -4.0));
	block.var[2][0][0] = (vec4(-3.0, 4.0, -8.0, -2.0));
	block.var[2][0][1] = (vec4(0.0, -8.0, 2.0, -3.0));
	block.var[2][0][2] = (vec4(-5.0, 3.0, -2.0, -9.0));
	block.var[2][0][3] = (vec4(-8.0, -3.0, 5.0, -9.0));
	block.var[2][1][0] = (vec4(6.0, -6.0, 7.0, -8.0));
	block.var[2][1][1] = (vec4(2.0, 7.0, -5.0, 0.0));
	block.var[2][1][2] = (vec4(-4.0, -7.0, 6.0, 0.0));
	block.var[2][1][3] = (vec4(0.0, 4.0, -5.0, -1.0));
	block.var[2][2][0] = (vec4(-9.0, -7.0, 5.0, 3.0));
	block.var[2][2][1] = (vec4(9.0, -8.0, -6.0, -3.0));
	block.var[2][2][2] = (vec4(6.0, -9.0, 4.0, 6.0));
	block.var[2][2][3] = (vec4(-6.0, -6.0, -2.0, -8.0));
	block.var[3][0][0] = (vec4(-3.0, -8.0, 5.0, 6.0));
	block.var[3][0][1] = (vec4(-9.0, -7.0, -7.0, 6.0));
	block.var[3][0][2] = (vec4(1.0, 0.0, -3.0, 4.0));
	block.var[3][0][3] = (vec4(1.0, -7.0, 4.0, 6.0));
	block.var[3][1][0] = (vec4(4.0, 3.0, -5.0, -8.0));
	block.var[3][1][1] = (vec4(0.0, -2.0, 7.0, 5.0));
	block.var[3][1][2] = (vec4(-1.0, -3.0, -2.0, -6.0));
	block.var[3][1][3] = (vec4(-9.0, -3.0, 5.0, 8.0));
	block.var[3][2][0] = (vec4(7.0, -4.0, 1.0, 6.0));
	block.var[3][2][1] = (vec4(-9.0, 8.0, 3.0, -6.0));
	block.var[3][2][2] = (vec4(-7.0, 7.0, -1.0, -7.0));
	block.var[3][2][3] = (vec4(6.0, -5.0, 9.0, -3.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(-9.0, 2.0, -4.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(3.0, 1.0, -9.0, -1.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][2], mat3x2(-2.0, -8.0, -5.0, 3.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(-2.0, -1.0, 1.0, 0.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(-1.0, -3.0, 9.0, 9.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][2], mat3x2(6.0, -9.0, 0.0, -7.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(-7.0, 6.0, -9.0, 5.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(8.0, -3.0, -5.0, -8.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][2], mat3x2(-1.0, 3.0, 2.0, -6.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(-9.0, 7.0, 0.0, -9.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(-7.0, -4.0, -4.0, 2.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][2], mat3x2(-7.0, -7.0, -2.0, -7.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(8.0, -3.0, 9.0, 8.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(2.0, 4.0, 5.0, -2.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][2], mat3x2(0.0, 1.0, 8.0, 6.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(1.0, -7.0, 3.0, -9.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(-9.0, 8.0, -7.0, 5.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][2], mat3x2(8.0, -4.0, 2.0, 5.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][0], mat3x2(-4.0, 8.0, 6.0, -9.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][1], mat3x2(-5.0, -5.0, 2.0, 5.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][2], mat3x2(-7.0, -1.0, -4.0, 8.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][0], mat3x2(-2.0, -3.0, -5.0, 2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][1], mat3x2(-4.0, 8.0, -4.0, -9.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][2], mat3x2(-7.0, -8.0, -2.0, -7.0, 5.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3x2(-4.0, 6.0, -6.0, 1.0, -8.0, 7.0));
	block.var[0][0][1] = (mat3x2(-1.0, 0.0, -6.0, 7.0, -4.0, -7.0));
	block.var[0][0][2] = (mat3x2(-7.0, -5.0, -2.0, -6.0, -6.0, -4.0));
	block.var[0][1][0] = (mat3x2(9.0, 9.0, -7.0, 5.0, 9.0, -1.0));
	block.var[0][1][1] = (mat3x2(1.0, 7.0, 8.0, 8.0, -1.0, 5.0));
	block.var[0][1][2] = (mat3x2(-7.0, -7.0, 7.0, -7.0, -4.0, 0.0));
	block.var[1][0][0] = (mat3x2(-4.0, -9.0, 4.0, 7.0, 9.0, 7.0));
	block.var[1][0][1] = (mat3x2(9.0, -1.0, -5.0, 6.0, -2.0, 6.0));
	block.var[1][0][2] = (mat3x2(-6.0, -8.0, 1.0, 5.0, 7.0, 1.0));
	block.var[1][1][0] = (mat3x2(-4.0, -8.0, -1.0, 6.0, -9.0, 7.0));
	block.var[1][1][1] = (mat3x2(-9.0, 2.0, 5.0, -2.0, 2.0, -7.0));
	block.var[1][1][2] = (mat3x2(-7.0, 2.0, 5.0, 0.0, 1.0, -6.0));
	block.var[2][0][0] = (mat3x2(0.0, 0.0, 2.0, -7.0, 5.0, 1.0));
	block.var[2][0][1] = (mat3x2(6.0, 0.0, -1.0, -4.0, -5.0, -3.0));
	block.var[2][0][2] = (mat3x2(-8.0, 4.0, -1.0, 9.0, -1.0, 7.0));
	block.var[2][1][0] = (mat3x2(1.0, -2.0, -7.0, 8.0, -1.0, 1.0));
	block.var[2][1][1] = (mat3x2(2.0, -3.0, 1.0, -9.0, -8.0, 9.0));
	block.var[2][1][2] = (mat3x2(-7.0, 8.0, -6.0, -5.0, -8.0, 8.0));
	block.var[3][0][0] = (mat3x2(-8.0, -3.0, 6.0, 0.0, 4.0, 4.0));
	block.var[3][0][1] = (mat3x2(-8.0, 8.0, -9.0, -4.0, 5.0, 5.0));
	block.var[3][0][2] = (mat3x2(4.0, 7.0, -3.0, 2.0, 8.0, 5.0));
	block.var[3][1][0] = (mat3x2(-5.0, 1.0, 4.0, -7.0, -6.0, -8.0));
	block.var[3][1][1] = (mat3x2(5.0, -9.0, 2.0, 0.0, -8.0, -6.0));
	block.var[3][1][2] = (mat3x2(8.0, 7.0, 3.0, 8.0, -8.0, 5.0));
}
#version 450
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
	i8vec4 var[4][2][3];
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
	allOk = compare_i8vec4(ivec4(block.var[0][0][2]), ivec4(3, 3, 4294967290, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[0][1][0]), ivec4(4294967293, 4294967294, 4, 2)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[0][1][1]), ivec4(4294967289, 6, 8, 5)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[0][1][2]), ivec4(4294967290, 4294967289, 4294967295, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][0][0]), ivec4(4294967289, 4294967292, 4294967291, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][0][1]), ivec4(1, 4294967288, 8, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][0][2]), ivec4(0, 3, 4294967294, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][1][0]), ivec4(4294967293, 4294967287, 4294967292, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][1][1]), ivec4(5, 4294967290, 4294967294, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][1][2]), ivec4(9, 3, 7, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][0][0]), ivec4(1, 4294967295, 4294967292, 6)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][0][1]), ivec4(4294967291, 5, 4294967289, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][0][2]), ivec4(7, 2, 2, 4)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][1][0]), ivec4(4294967287, 4294967291, 5, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][1][1]), ivec4(3, 4294967287, 4294967291, 4294967292)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][1][2]), ivec4(4294967291, 8, 0, 7)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[3][0][0]), ivec4(4294967295, 9, 4294967287, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[3][0][1]), ivec4(8, 4294967290, 4294967289, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[3][0][2]), ivec4(4294967293, 4294967288, 9, 2)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[3][1][0]), ivec4(6, 4294967288, 3, 4294967292)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[3][1][1]), ivec4(4, 4294967290, 7, 4294967290)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[3][1][2]), ivec4(0, 5, 8, 4294967289)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = i8vec4(ivec4(4294967294, 4294967292, 4294967290, 4294967289));
	block.var[0][0][1] = i8vec4(ivec4(4294967291, 4294967291, 4, 4294967290));
	block.var[0][0][2] = i8vec4(ivec4(4294967295, 4294967287, 4294967293, 8));
	block.var[0][1][0] = i8vec4(ivec4(3, 4294967293, 4294967290, 4294967290));
	block.var[0][1][1] = i8vec4(ivec4(8, 4294967289, 4294967292, 2));
	block.var[0][1][2] = i8vec4(ivec4(4294967295, 9, 4294967295, 6));
	block.var[1][0][0] = i8vec4(ivec4(6, 4, 9, 4294967287));
	block.var[1][0][1] = i8vec4(ivec4(4294967295, 4294967292, 4294967287, 3));
	block.var[1][0][2] = i8vec4(ivec4(9, 4294967288, 4294967290, 4294967287));
	block.var[1][1][0] = i8vec4(ivec4(6, 4294967289, 4294967293, 4294967289));
	block.var[1][1][1] = i8vec4(ivec4(6, 7, 5, 5));
	block.var[1][1][2] = i8vec4(ivec4(4294967291, 4, 3, 4294967290));
	block.var[2][0][0] = i8vec4(ivec4(8, 5, 4, 5));
	block.var[2][0][1] = i8vec4(ivec4(5, 4294967289, 4294967287, 4294967294));
	block.var[2][0][2] = i8vec4(ivec4(4294967291, 4294967291, 4, 5));
	block.var[2][1][0] = i8vec4(ivec4(1, 0, 5, 0));
	block.var[2][1][1] = i8vec4(ivec4(4294967293, 0, 4294967294, 6));
	block.var[2][1][2] = i8vec4(ivec4(6, 1, 0, 2));
	block.var[3][0][0] = i8vec4(ivec4(4294967293, 4294967294, 4294967289, 4294967291));
	block.var[3][0][1] = i8vec4(ivec4(2, 5, 4, 6));
	block.var[3][0][2] = i8vec4(ivec4(4294967292, 7, 8, 9));
	block.var[3][1][0] = i8vec4(ivec4(6, 1, 9, 4294967291));
	block.var[3][1][1] = i8vec4(ivec4(4294967295, 0, 3, 9));
	block.var[3][1][2] = i8vec4(ivec4(2, 7, 7, 4294967293));
}
#version 450
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
	allOk = compare_mat2(block.var[0][0][0], mat2(-2.0, -7.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(3.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][2], mat2(2.0, 8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(-9.0, 4.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(-8.0, 5.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][2], mat2(-9.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(8.0, -4.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(-4.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][2], mat2(-6.0, 5.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(-5.0, -4.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(1.0, 0.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][2], mat2(-9.0, 9.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(5.0, -4.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(1.0, 9.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][2], mat2(5.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(2.0, -4.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(9.0, 3.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][2], mat2(-8.0, -9.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][0], mat2(-6.0, -8.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][1], mat2(6.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][2], mat2(2.0, 1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][0], mat2(1.0, -2.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][1], mat2(4.0, -3.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][2], mat2(4.0, -6.0, 7.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2(3.0, 1.0, -4.0, -2.0));
	block.var[0][0][1] = (mat2(1.0, -4.0, -1.0, -3.0));
	block.var[0][0][2] = (mat2(-8.0, 5.0, -6.0, -2.0));
	block.var[0][1][0] = (mat2(8.0, -7.0, 0.0, -7.0));
	block.var[0][1][1] = (mat2(-6.0, 8.0, 5.0, 2.0));
	block.var[0][1][2] = (mat2(5.0, -4.0, 3.0, 8.0));
	block.var[1][0][0] = (mat2(8.0, -5.0, 0.0, -2.0));
	block.var[1][0][1] = (mat2(-1.0, -6.0, 4.0, -4.0));
	block.var[1][0][2] = (mat2(9.0, 7.0, -9.0, 0.0));
	block.var[1][1][0] = (mat2(0.0, -2.0, 7.0, 4.0));
	block.var[1][1][1] = (mat2(4.0, -4.0, 0.0, 7.0));
	block.var[1][1][2] = (mat2(-7.0, 7.0, -1.0, 4.0));
	block.var[2][0][0] = (mat2(2.0, -5.0, 9.0, 6.0));
	block.var[2][0][1] = (mat2(5.0, 8.0, -5.0, -7.0));
	block.var[2][0][2] = (mat2(-2.0, -9.0, -1.0, 8.0));
	block.var[2][1][0] = (mat2(6.0, 1.0, 8.0, -1.0));
	block.var[2][1][1] = (mat2(9.0, 1.0, -2.0, -9.0));
	block.var[2][1][2] = (mat2(1.0, -5.0, -9.0, -7.0));
	block.var[3][0][0] = (mat2(-7.0, 5.0, -9.0, 3.0));
	block.var[3][0][1] = (mat2(-3.0, -1.0, -2.0, -9.0));
	block.var[3][0][2] = (mat2(5.0, 8.0, -2.0, 4.0));
	block.var[3][1][0] = (mat2(-6.0, 7.0, 4.0, 1.0));
	block.var[3][1][1] = (mat2(-8.0, 7.0, -5.0, -1.0));
	block.var[3][1][2] = (mat2(-1.0, -7.0, -4.0, 0.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(-7.0, 8.0, 3.0, -7.0, -7.0, -8.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(7.0, 3.0, -5.0, -7.0, 3.0, -9.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][2], mat2x4(3.0, 6.0, -4.0, 4.0, -2.0, 8.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(9.0, -3.0, 5.0, -7.0, 2.0, -7.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(5.0, -1.0, 2.0, -6.0, -6.0, -7.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][2], mat2x4(-7.0, -8.0, -7.0, -5.0, 1.0, 3.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(-8.0, -1.0, -1.0, -6.0, 2.0, -7.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(3.0, -9.0, 1.0, -9.0, 8.0, -7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][2], mat2x4(1.0, -1.0, 0.0, 7.0, 2.0, 5.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(-9.0, -4.0, 8.0, 5.0, 6.0, -3.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(-8.0, 2.0, 8.0, 5.0, -8.0, 1.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][2], mat2x4(-5.0, 2.0, 7.0, -3.0, 3.0, 9.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(2.0, 2.0, -8.0, 6.0, 0.0, -1.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(-4.0, -2.0, -4.0, -6.0, -3.0, -4.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][2], mat2x4(8.0, -7.0, 8.0, 8.0, 2.0, 3.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(6.0, 6.0, 2.0, -4.0, -3.0, 8.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(9.0, -6.0, -3.0, -7.0, 7.0, -7.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][2], mat2x4(0.0, 5.0, 0.0, -9.0, 3.0, -8.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][0], mat2x4(9.0, 0.0, -4.0, -7.0, -7.0, 7.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][1], mat2x4(-3.0, -7.0, -5.0, -4.0, -1.0, -7.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][2], mat2x4(7.0, 0.0, -6.0, -2.0, 9.0, -7.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][0], mat2x4(-2.0, -5.0, -2.0, -5.0, -8.0, -4.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][1], mat2x4(9.0, 0.0, 3.0, -7.0, -2.0, 6.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][2], mat2x4(2.0, -9.0, -8.0, 5.0, 3.0, -5.0, 5.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2x4(4.0, 9.0, 1.0, 2.0, 5.0, -4.0, -9.0, -9.0));
	block.var[0][0][1] = (mat2x4(5.0, -4.0, -4.0, 8.0, 5.0, -1.0, -3.0, -2.0));
	block.var[0][0][2] = (mat2x4(8.0, 2.0, 5.0, 4.0, 3.0, 1.0, -6.0, 2.0));
	block.var[0][1][0] = (mat2x4(8.0, -2.0, 7.0, -7.0, -4.0, 2.0, -4.0, 0.0));
	block.var[0][1][1] = (mat2x4(7.0, -5.0, 6.0, -6.0, -2.0, 2.0, -8.0, 5.0));
	block.var[0][1][2] = (mat2x4(6.0, 8.0, -2.0, 0.0, 7.0, 9.0, 1.0, -3.0));
	block.var[1][0][0] = (mat2x4(-3.0, 4.0, 7.0, -8.0, -6.0, -3.0, -2.0, -9.0));
	block.var[1][0][1] = (mat2x4(-6.0, 7.0, 6.0, -2.0, 2.0, 7.0, 4.0, -7.0));
	block.var[1][0][2] = (mat2x4(-8.0, 4.0, 3.0, -6.0, -9.0, -3.0, 5.0, -6.0));
	block.var[1][1][0] = (mat2x4(5.0, 2.0, 9.0, 1.0, -1.0, -6.0, -3.0, -3.0));
	block.var[1][1][1] = (mat2x4(7.0, 4.0, 1.0, -9.0, -9.0, 4.0, 0.0, 1.0));
	block.var[1][1][2] = (mat2x4(-8.0, 4.0, 7.0, -7.0, -4.0, -4.0, -4.0, 1.0));
	block.var[2][0][0] = (mat2x4(-5.0, 8.0, 2.0, 0.0, -9.0, 1.0, -2.0, -6.0));
	block.var[2][0][1] = (mat2x4(0.0, 6.0, 7.0, -2.0, -1.0, -3.0, -3.0, -9.0));
	block.var[2][0][2] = (mat2x4(7.0, -5.0, 9.0, -1.0, -1.0, 9.0, 0.0, 7.0));
	block.var[2][1][0] = (mat2x4(-9.0, 3.0, 6.0, -5.0, 6.0, 4.0, 8.0, -7.0));
	block.var[2][1][1] = (mat2x4(-4.0, -8.0, -2.0, 8.0, -5.0, 5.0, -9.0, 9.0));
	block.var[2][1][2] = (mat2x4(5.0, 0.0, -8.0, -5.0, 5.0, -6.0, 9.0, 8.0));
	block.var[3][0][0] = (mat2x4(6.0, -8.0, -2.0, 3.0, 1.0, -8.0, -4.0, -9.0));
	block.var[3][0][1] = (mat2x4(-7.0, 0.0, -8.0, -1.0, 5.0, 7.0, 7.0, -3.0));
	block.var[3][0][2] = (mat2x4(1.0, -9.0, 2.0, -9.0, -3.0, 0.0, -4.0, 5.0));
	block.var[3][1][0] = (mat2x4(-9.0, -9.0, -2.0, -6.0, 7.0, 3.0, 3.0, -2.0));
	block.var[3][1][1] = (mat2x4(4.0, -3.0, -6.0, 4.0, -3.0, 9.0, -3.0, 0.0));
	block.var[3][1][2] = (mat2x4(4.0, 4.0, -6.0, 7.0, -8.0, 7.0, -1.0, -7.0));
}
#version 450
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
	highp uint var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((block.padding), 3u) && allOk;
	allOk = compare_uint((block.var[0][0][0]), 6u) && allOk;
	allOk = compare_uint((block.var[0][0][1]), 9u) && allOk;
	allOk = compare_uint((block.var[0][0][2]), 0u) && allOk;
	allOk = compare_uint((block.var[0][1][0]), 8u) && allOk;
	allOk = compare_uint((block.var[0][1][1]), 6u) && allOk;
	allOk = compare_uint((block.var[0][1][2]), 9u) && allOk;
	allOk = compare_uint((block.var[1][0][0]), 3u) && allOk;
	allOk = compare_uint((block.var[1][0][1]), 7u) && allOk;
	allOk = compare_uint((block.var[1][0][2]), 6u) && allOk;
	allOk = compare_uint((block.var[1][1][0]), 0u) && allOk;
	allOk = compare_uint((block.var[1][1][1]), 1u) && allOk;
	allOk = compare_uint((block.var[1][1][2]), 4u) && allOk;
	allOk = compare_uint((block.var[2][0][0]), 4u) && allOk;
	allOk = compare_uint((block.var[2][0][1]), 2u) && allOk;
	allOk = compare_uint((block.var[2][0][2]), 5u) && allOk;
	allOk = compare_uint((block.var[2][1][0]), 8u) && allOk;
	allOk = compare_uint((block.var[2][1][1]), 7u) && allOk;
	allOk = compare_uint((block.var[2][1][2]), 9u) && allOk;
	allOk = compare_uint((block.var[3][0][0]), 7u) && allOk;
	allOk = compare_uint((block.var[3][0][1]), 5u) && allOk;
	allOk = compare_uint((block.var[3][0][2]), 7u) && allOk;
	allOk = compare_uint((block.var[3][1][0]), 7u) && allOk;
	allOk = compare_uint((block.var[3][1][1]), 7u) && allOk;
	allOk = compare_uint((block.var[3][1][2]), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (7u);
	block.var[0][0][0] = (9u);
	block.var[0][0][1] = (1u);
	block.var[0][0][2] = (0u);
	block.var[0][1][0] = (8u);
	block.var[0][1][1] = (6u);
	block.var[0][1][2] = (1u);
	block.var[1][0][0] = (7u);
	block.var[1][0][1] = (7u);
	block.var[1][0][2] = (4u);
	block.var[1][1][0] = (9u);
	block.var[1][1][1] = (8u);
	block.var[1][1][2] = (6u);
	block.var[2][0][0] = (8u);
	block.var[2][0][1] = (7u);
	block.var[2][0][2] = (5u);
	block.var[2][1][0] = (8u);
	block.var[2][1][1] = (6u);
	block.var[2][1][2] = (2u);
	block.var[3][0][0] = (7u);
	block.var[3][0][1] = (2u);
	block.var[3][0][2] = (7u);
	block.var[3][1][0] = (5u);
	block.var[3][1][1] = (3u);
	block.var[3][1][2] = (3u);
}
#version 450
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
	highp vec4 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((block.var[0][0][0]), vec4(-5.0, 4.0, -4.0, 6.0)) && allOk;
	allOk = compare_vec4((block.var[0][0][1]), vec4(1.0, 4.0, 8.0, 7.0)) && allOk;
	allOk = compare_vec4((block.var[0][1][0]), vec4(6.0, 9.0, -5.0, -1.0)) && allOk;
	allOk = compare_vec4((block.var[0][1][1]), vec4(8.0, -5.0, -7.0, 0.0)) && allOk;
	allOk = compare_vec4((block.var[0][2][0]), vec4(-1.0, 3.0, 2.0, -5.0)) && allOk;
	allOk = compare_vec4((block.var[0][2][1]), vec4(9.0, 1.0, -6.0, 3.0)) && allOk;
	allOk = compare_vec4((block.var[0][3][0]), vec4(6.0, -4.0, -2.0, -7.0)) && allOk;
	allOk = compare_vec4((block.var[0][3][1]), vec4(-2.0, 7.0, -3.0, -4.0)) && allOk;
	allOk = compare_vec4((block.var[1][0][0]), vec4(2.0, -4.0, 3.0, -8.0)) && allOk;
	allOk = compare_vec4((block.var[1][0][1]), vec4(-3.0, -3.0, -6.0, -4.0)) && allOk;
	allOk = compare_vec4((block.var[1][1][0]), vec4(-7.0, 2.0, -6.0, 6.0)) && allOk;
	allOk = compare_vec4((block.var[1][1][1]), vec4(-1.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_vec4((block.var[1][2][0]), vec4(0.0, 6.0, 1.0, -9.0)) && allOk;
	allOk = compare_vec4((block.var[1][2][1]), vec4(6.0, -7.0, 0.0, 0.0)) && allOk;
	allOk = compare_vec4((block.var[1][3][0]), vec4(-2.0, -5.0, 1.0, 8.0)) && allOk;
	allOk = compare_vec4((block.var[1][3][1]), vec4(3.0, -9.0, 9.0, 9.0)) && allOk;
	allOk = compare_vec4((block.var[2][0][0]), vec4(-1.0, 0.0, -8.0, -8.0)) && allOk;
	allOk = compare_vec4((block.var[2][0][1]), vec4(7.0, 1.0, 8.0, -8.0)) && allOk;
	allOk = compare_vec4((block.var[2][1][0]), vec4(8.0, 1.0, 8.0, 2.0)) && allOk;
	allOk = compare_vec4((block.var[2][1][1]), vec4(3.0, -4.0, 2.0, 1.0)) && allOk;
	allOk = compare_vec4((block.var[2][2][0]), vec4(8.0, -6.0, 5.0, -4.0)) && allOk;
	allOk = compare_vec4((block.var[2][2][1]), vec4(5.0, -5.0, -2.0, -4.0)) && allOk;
	allOk = compare_vec4((block.var[2][3][0]), vec4(5.0, -9.0, -7.0, -7.0)) && allOk;
	allOk = compare_vec4((block.var[2][3][1]), vec4(-6.0, -9.0, 4.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec4(-5.0, 8.0, 3.0, -4.0));
	block.var[0][0][1] = (vec4(-6.0, -1.0, -3.0, 6.0));
	block.var[0][1][0] = (vec4(0.0, 8.0, 4.0, -4.0));
	block.var[0][1][1] = (vec4(-8.0, -3.0, 9.0, -7.0));
	block.var[0][2][0] = (vec4(1.0, 7.0, 1.0, 1.0));
	block.var[0][2][1] = (vec4(-7.0, -6.0, -7.0, -4.0));
	block.var[0][3][0] = (vec4(5.0, -4.0, -5.0, 6.0));
	block.var[0][3][1] = (vec4(0.0, -2.0, -8.0, 7.0));
	block.var[1][0][0] = (vec4(5.0, -9.0, 4.0, -1.0));
	block.var[1][0][1] = (vec4(-7.0, -6.0, -2.0, -8.0));
	block.var[1][1][0] = (vec4(-9.0, 2.0, -6.0, 6.0));
	block.var[1][1][1] = (vec4(6.0, 2.0, -3.0, 0.0));
	block.var[1][2][0] = (vec4(8.0, -1.0, -6.0, -8.0));
	block.var[1][2][1] = (vec4(9.0, 7.0, -3.0, -8.0));
	block.var[1][3][0] = (vec4(0.0, -7.0, -2.0, -7.0));
	block.var[1][3][1] = (vec4(3.0, -8.0, 1.0, 6.0));
	block.var[2][0][0] = (vec4(8.0, 7.0, 5.0, 1.0));
	block.var[2][0][1] = (vec4(-6.0, -5.0, -8.0, 8.0));
	block.var[2][1][0] = (vec4(-9.0, 8.0, -8.0, 0.0));
	block.var[2][1][1] = (vec4(2.0, 6.0, 6.0, 1.0));
	block.var[2][2][0] = (vec4(-3.0, -9.0, 2.0, 1.0));
	block.var[2][2][1] = (vec4(-7.0, 3.0, -5.0, 8.0));
	block.var[2][3][0] = (vec4(0.0, 5.0, -3.0, -2.0));
	block.var[2][3][1] = (vec4(-9.0, -7.0, 2.0, -7.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(-4.0, 6.0, 0.0, -5.0, 0.0, -1.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(-6.0, -1.0, 4.0, 0.0, 2.0, -3.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(-5.0, 5.0, 5.0, 7.0, 5.0, 2.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(9.0, -6.0, 5.0, -9.0, 6.0, 0.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][0], mat4x2(8.0, -5.0, -3.0, -5.0, 3.0, -9.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][1], mat4x2(-3.0, 9.0, 0.0, 7.0, 9.0, -6.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][0], mat4x2(6.0, 1.0, -3.0, -1.0, -3.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][1], mat4x2(2.0, 4.0, -4.0, 9.0, 9.0, 7.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(-8.0, -1.0, 5.0, 4.0, 9.0, -2.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(-5.0, -4.0, 3.0, 6.0, 4.0, 3.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(-8.0, 7.0, -6.0, -1.0, -9.0, -7.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(5.0, 9.0, 3.0, 7.0, 1.0, -3.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][0], mat4x2(-9.0, 3.0, -7.0, -8.0, 7.0, -1.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][1], mat4x2(-7.0, 0.0, -1.0, -5.0, 7.0, -7.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][0], mat4x2(5.0, -9.0, -2.0, 8.0, 7.0, 0.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][1], mat4x2(8.0, -9.0, -2.0, -7.0, 6.0, -6.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(-1.0, -1.0, 3.0, -6.0, 6.0, 2.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(2.0, -2.0, -4.0, 7.0, -1.0, -9.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(4.0, 5.0, 5.0, 6.0, 2.0, 0.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(5.0, -2.0, 4.0, 7.0, -2.0, 4.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][0], mat4x2(-2.0, 4.0, 6.0, -4.0, 1.0, 5.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][1], mat4x2(9.0, 0.0, 1.0, -9.0, -5.0, 0.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][0], mat4x2(4.0, -2.0, -9.0, 4.0, 9.0, 1.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][1], mat4x2(6.0, 9.0, 2.0, 5.0, -9.0, -3.0, 9.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4x2(1.0, 8.0, -9.0, 4.0, 1.0, -5.0, 2.0, -5.0));
	block.var[0][0][1] = (mat4x2(8.0, -8.0, 8.0, 3.0, 2.0, -6.0, 3.0, 8.0));
	block.var[0][1][0] = (mat4x2(1.0, -9.0, 0.0, -4.0, 2.0, 9.0, -5.0, -3.0));
	block.var[0][1][1] = (mat4x2(6.0, -4.0, -9.0, 5.0, -5.0, -6.0, 8.0, -5.0));
	block.var[0][2][0] = (mat4x2(-7.0, 4.0, -8.0, -6.0, -3.0, -4.0, 8.0, -4.0));
	block.var[0][2][1] = (mat4x2(6.0, -9.0, -7.0, -3.0, -9.0, -6.0, -3.0, -8.0));
	block.var[0][3][0] = (mat4x2(4.0, -8.0, -6.0, -3.0, 8.0, -1.0, -5.0, 5.0));
	block.var[0][3][1] = (mat4x2(1.0, 9.0, -4.0, -5.0, 1.0, -2.0, 7.0, 1.0));
	block.var[1][0][0] = (mat4x2(8.0, 9.0, -3.0, -9.0, -2.0, 6.0, -1.0, 6.0));
	block.var[1][0][1] = (mat4x2(-5.0, -9.0, -1.0, -9.0, 0.0, -4.0, 2.0, -7.0));
	block.var[1][1][0] = (mat4x2(-4.0, -5.0, 6.0, 9.0, -3.0, -4.0, 3.0, -7.0));
	block.var[1][1][1] = (mat4x2(-8.0, 8.0, -4.0, -6.0, 0.0, -3.0, -6.0, -4.0));
	block.var[1][2][0] = (mat4x2(8.0, -4.0, -8.0, 4.0, 0.0, 4.0, -3.0, 8.0));
	block.var[1][2][1] = (mat4x2(0.0, 7.0, -2.0, -3.0, -5.0, 6.0, -2.0, 7.0));
	block.var[1][3][0] = (mat4x2(-3.0, -1.0, 4.0, 9.0, 6.0, 3.0, -9.0, 2.0));
	block.var[1][3][1] = (mat4x2(-3.0, 9.0, 7.0, -5.0, -4.0, 0.0, -9.0, 9.0));
	block.var[2][0][0] = (mat4x2(-3.0, -5.0, 1.0, -5.0, -1.0, 7.0, 4.0, 4.0));
	block.var[2][0][1] = (mat4x2(-5.0, 2.0, -4.0, -3.0, 0.0, 4.0, -7.0, 5.0));
	block.var[2][1][0] = (mat4x2(5.0, 4.0, 5.0, 7.0, 2.0, -7.0, 8.0, -3.0));
	block.var[2][1][1] = (mat4x2(8.0, 7.0, 0.0, -5.0, 4.0, 5.0, -6.0, -8.0));
	block.var[2][2][0] = (mat4x2(4.0, -1.0, 6.0, -2.0, 0.0, 7.0, 0.0, 2.0));
	block.var[2][2][1] = (mat4x2(-7.0, -7.0, -6.0, 8.0, -7.0, -4.0, 9.0, 9.0));
	block.var[2][3][0] = (mat4x2(6.0, 8.0, -4.0, -2.0, -7.0, -7.0, -4.0, 9.0));
	block.var[2][3][1] = (mat4x2(6.0, 7.0, -4.0, 6.0, -5.0, -4.0, 7.0, -1.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0][0], mat4x3(3.0, 9.0, 5.0, 5.0, 8.0, -9.0, 1.0, -3.0, 3.0, 6.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][1], mat4x3(-9.0, -2.0, -1.0, 6.0, 6.0, 9.0, 0.0, 3.0, -4.0, 2.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][0], mat4x3(-9.0, -5.0, -9.0, 1.0, -9.0, 3.0, 4.0, 0.0, -8.0, -3.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][1], mat4x3(-7.0, -4.0, 0.0, 2.0, 3.0, -9.0, -3.0, 0.0, -7.0, 8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2][0], mat4x3(-1.0, 1.0, 9.0, 7.0, 0.0, 9.0, -1.0, -1.0, -7.0, 0.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2][1], mat4x3(5.0, 7.0, -6.0, -7.0, 6.0, -5.0, -4.0, -1.0, 8.0, 7.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][3][0], mat4x3(6.0, -3.0, 0.0, -6.0, -3.0, -6.0, 8.0, 4.0, 2.0, 4.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][3][1], mat4x3(-1.0, -7.0, 6.0, -3.0, -8.0, -4.0, 6.0, 4.0, 6.0, 3.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][0], mat4x3(6.0, 8.0, 7.0, 6.0, 1.0, 3.0, 8.0, -4.0, 7.0, -9.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][1], mat4x3(-4.0, -7.0, 7.0, -5.0, 2.0, 4.0, 9.0, 2.0, 6.0, -3.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][0], mat4x3(-7.0, 4.0, 9.0, 8.0, -5.0, -5.0, 6.0, 8.0, -7.0, 1.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][1], mat4x3(0.0, -9.0, -1.0, 9.0, 2.0, -9.0, 8.0, 0.0, 1.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2][0], mat4x3(-2.0, -5.0, -2.0, -2.0, 9.0, 9.0, -6.0, 0.0, -5.0, 6.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2][1], mat4x3(8.0, -9.0, 6.0, -7.0, 6.0, 5.0, -5.0, -1.0, 5.0, -7.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][3][0], mat4x3(2.0, -8.0, 4.0, 7.0, -9.0, -4.0, 2.0, -4.0, -9.0, 4.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][3][1], mat4x3(-7.0, -3.0, 9.0, -6.0, 0.0, -2.0, -4.0, 8.0, 3.0, -4.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][0], mat4x3(3.0, -3.0, 0.0, 8.0, 6.0, -1.0, 9.0, 6.0, 0.0, 4.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][1], mat4x3(6.0, 2.0, -1.0, -6.0, -9.0, 7.0, -9.0, -9.0, 8.0, 6.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][0], mat4x3(5.0, -5.0, -1.0, -9.0, 7.0, 5.0, 0.0, 7.0, -3.0, -7.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][1], mat4x3(-3.0, 1.0, 7.0, -9.0, 6.0, 7.0, -5.0, 8.0, -2.0, -6.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2][0], mat4x3(8.0, 3.0, -1.0, 2.0, 5.0, -8.0, 0.0, -6.0, 4.0, 6.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2][1], mat4x3(8.0, 4.0, -1.0, -5.0, 0.0, -6.0, 3.0, 7.0, -8.0, -4.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][3][0], mat4x3(-5.0, -4.0, -7.0, 2.0, -5.0, -5.0, 2.0, 4.0, -5.0, 4.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][3][1], mat4x3(2.0, 3.0, -9.0, -6.0, -1.0, -7.0, 8.0, -6.0, 1.0, 7.0, -2.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4x3(-5.0, 9.0, 2.0, -5.0, 1.0, 6.0, 4.0, 3.0, 9.0, -4.0, 3.0, 1.0));
	block.var[0][0][1] = (mat4x3(-5.0, 2.0, 4.0, -6.0, 1.0, 3.0, -6.0, -1.0, -4.0, 3.0, 9.0, -1.0));
	block.var[0][1][0] = (mat4x3(-8.0, -3.0, -8.0, -5.0, 2.0, -9.0, 2.0, 9.0, 8.0, 7.0, 9.0, -6.0));
	block.var[0][1][1] = (mat4x3(8.0, -8.0, -9.0, 9.0, 8.0, -3.0, 4.0, 8.0, 2.0, -9.0, -8.0, 5.0));
	block.var[0][2][0] = (mat4x3(4.0, 9.0, 7.0, 5.0, 7.0, -2.0, -4.0, -2.0, 3.0, -6.0, 0.0, -7.0));
	block.var[0][2][1] = (mat4x3(9.0, -6.0, -9.0, 5.0, -1.0, -2.0, 4.0, 7.0, 2.0, 8.0, -7.0, 9.0));
	block.var[0][3][0] = (mat4x3(5.0, -9.0, 3.0, -6.0, -1.0, 2.0, 6.0, -2.0, 0.0, 5.0, -5.0, -5.0));
	block.var[0][3][1] = (mat4x3(-3.0, -7.0, -1.0, -5.0, 2.0, -7.0, 9.0, 1.0, 1.0, -5.0, 8.0, -6.0));
	block.var[1][0][0] = (mat4x3(4.0, 2.0, 8.0, -9.0, -8.0, -5.0, -9.0, -6.0, -7.0, 6.0, -5.0, -5.0));
	block.var[1][0][1] = (mat4x3(9.0, -7.0, -4.0, -3.0, -2.0, 6.0, 2.0, 3.0, -8.0, -7.0, 9.0, -1.0));
	block.var[1][1][0] = (mat4x3(-8.0, 9.0, 8.0, -9.0, 8.0, -3.0, -9.0, -6.0, 1.0, -1.0, -2.0, -1.0));
	block.var[1][1][1] = (mat4x3(8.0, -3.0, -6.0, 2.0, -2.0, 0.0, -4.0, -5.0, 8.0, 2.0, 9.0, -1.0));
	block.var[1][2][0] = (mat4x3(7.0, 3.0, 4.0, 9.0, 8.0, -1.0, -6.0, -4.0, 5.0, -8.0, -4.0, 1.0));
	block.var[1][2][1] = (mat4x3(-1.0, 6.0, 7.0, -9.0, 0.0, 8.0, -4.0, 2.0, 0.0, 3.0, -3.0, 1.0));
	block.var[1][3][0] = (mat4x3(-7.0, -1.0, 4.0, 4.0, -4.0, -4.0, -1.0, -2.0, 0.0, -3.0, 8.0, 7.0));
	block.var[1][3][1] = (mat4x3(-8.0, -4.0, -4.0, 2.0, 3.0, -9.0, 2.0, -1.0, -4.0, 3.0, 5.0, 1.0));
	block.var[2][0][0] = (mat4x3(9.0, 0.0, 0.0, 7.0, 7.0, 9.0, -7.0, -4.0, 7.0, -5.0, 0.0, -1.0));
	block.var[2][0][1] = (mat4x3(-4.0, 1.0, 3.0, -5.0, -2.0, -6.0, -8.0, -7.0, -9.0, -2.0, 2.0, 9.0));
	block.var[2][1][0] = (mat4x3(1.0, -6.0, -5.0, -5.0, 6.0, 8.0, 7.0, 0.0, 7.0, 1.0, 4.0, 9.0));
	block.var[2][1][1] = (mat4x3(-4.0, 8.0, 5.0, -4.0, -9.0, -1.0, 0.0, 5.0, -4.0, -1.0, -3.0, -5.0));
	block.var[2][2][0] = (mat4x3(7.0, 7.0, -6.0, 0.0, 1.0, 7.0, 2.0, 8.0, -2.0, -5.0, 8.0, 3.0));
	block.var[2][2][1] = (mat4x3(-1.0, -5.0, -8.0, 1.0, 4.0, 0.0, 2.0, -3.0, 8.0, -5.0, -9.0, 4.0));
	block.var[2][3][0] = (mat4x3(1.0, -2.0, 8.0, -8.0, -5.0, -8.0, -8.0, -7.0, 7.0, -9.0, 8.0, -2.0));
	block.var[2][3][1] = (mat4x3(-7.0, -4.0, 2.0, 2.0, 5.0, 7.0, -5.0, 5.0, 2.0, -2.0, 9.0, -6.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0][0][0], mat2(-4.0, 3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(5.0, 5.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(5.0, 6.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(3.0, -4.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[0][2][0], mat2(-8.0, 5.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[0][2][1], mat2(3.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[0][3][0], mat2(9.0, -5.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[0][3][1], mat2(5.0, 3.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(-2.0, 2.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(-7.0, 9.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(-8.0, -4.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(2.0, 7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[1][2][0], mat2(6.0, 6.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[1][2][1], mat2(0.0, -7.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[1][3][0], mat2(-5.0, -2.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[1][3][1], mat2(-1.0, 9.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(9.0, -6.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(-7.0, 3.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(2.0, 4.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(9.0, 6.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[2][2][0], mat2(-9.0, 1.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[2][2][1], mat2(4.0, -2.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[2][3][0], mat2(-5.0, -2.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[2][3][1], mat2(-7.0, -3.0, 7.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2(2.0, 4.0, 4.0, -1.0));
	block.var[0][0][1] = (mat2(2.0, -5.0, 1.0, -1.0));
	block.var[0][1][0] = (mat2(-1.0, -3.0, -7.0, 2.0));
	block.var[0][1][1] = (mat2(-3.0, -6.0, 2.0, 7.0));
	block.var[0][2][0] = (mat2(-5.0, 7.0, -8.0, 6.0));
	block.var[0][2][1] = (mat2(1.0, 0.0, 7.0, -3.0));
	block.var[0][3][0] = (mat2(-2.0, 2.0, 3.0, -3.0));
	block.var[0][3][1] = (mat2(3.0, 2.0, -9.0, -5.0));
	block.var[1][0][0] = (mat2(-2.0, -9.0, -3.0, -8.0));
	block.var[1][0][1] = (mat2(-6.0, -7.0, 1.0, -1.0));
	block.var[1][1][0] = (mat2(4.0, -2.0, -7.0, 4.0));
	block.var[1][1][1] = (mat2(-7.0, -5.0, -7.0, -5.0));
	block.var[1][2][0] = (mat2(9.0, -8.0, -6.0, -9.0));
	block.var[1][2][1] = (mat2(-6.0, 8.0, 1.0, -2.0));
	block.var[1][3][0] = (mat2(-9.0, 7.0, -7.0, 5.0));
	block.var[1][3][1] = (mat2(-9.0, -6.0, -9.0, 3.0));
	block.var[2][0][0] = (mat2(6.0, 2.0, -7.0, 8.0));
	block.var[2][0][1] = (mat2(-3.0, -2.0, 2.0, -7.0));
	block.var[2][1][0] = (mat2(-6.0, 4.0, 6.0, 4.0));
	block.var[2][1][1] = (mat2(2.0, -1.0, 9.0, 6.0));
	block.var[2][2][0] = (mat2(-4.0, -5.0, -4.0, 2.0));
	block.var[2][2][1] = (mat2(4.0, -9.0, 8.0, -9.0));
	block.var[2][3][0] = (mat2(4.0, -2.0, 0.0, -7.0));
	block.var[2][3][1] = (mat2(4.0, -2.0, -8.0, 0.0));
}
#version 450
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
	allOk = compare_mat3(block.t[0].a, mat3(8.0, 0.0, 7.0, 8.0, -1.0, -2.0, -1.0, -6.0, 9.0)) && allOk;
	allOk = compare_ivec3((block.t[0].b[0].a), ivec3(0, 9, 9)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[0]), ivec2(-5, 3)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[1]), ivec2(2, -9)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[2]), ivec2(7, -4)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[3]), ivec2(-9, 1)) && allOk;
	allOk = compare_vec4((block.t[0].b[0].c), vec4(-7.0, -3.0, 6.0, -3.0)) && allOk;
	allOk = compare_ivec3((block.t[0].b[1].a), ivec3(9, 6, -4)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[0]), ivec2(5, 5)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[1]), ivec2(-3, 0)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[2]), ivec2(1, -9)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[3]), ivec2(-3, -8)) && allOk;
	allOk = compare_vec4((block.t[0].b[1].c), vec4(0.0, -7.0, -2.0, -2.0)) && allOk;
	allOk = compare_ivec3((block.t[0].b[2].a), ivec3(-3, -2, 8)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[0]), ivec2(-6, 2)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[1]), ivec2(-2, 3)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[2]), ivec2(-9, 8)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[3]), ivec2(-1, 5)) && allOk;
	allOk = compare_vec4((block.t[0].b[2].c), vec4(4.0, 2.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3(block.t[1].a, mat3(-8.0, -3.0, 2.0, 8.0, 9.0, -8.0, -7.0, -4.0, 4.0)) && allOk;
	allOk = compare_ivec3((block.t[1].b[0].a), ivec3(-8, 1, 3)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[0]), ivec2(-7, 7)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[1]), ivec2(2, 2)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[2]), ivec2(-7, -7)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[3]), ivec2(-6, -7)) && allOk;
	allOk = compare_vec4((block.t[1].b[0].c), vec4(5.0, 2.0, -4.0, 7.0)) && allOk;
	allOk = compare_ivec3((block.t[1].b[1].a), ivec3(5, -3, 5)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[0]), ivec2(-7, -3)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[1]), ivec2(0, -5)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[2]), ivec2(8, 3)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[3]), ivec2(-7, 6)) && allOk;
	allOk = compare_vec4((block.t[1].b[1].c), vec4(-6.0, 8.0, 1.0, -8.0)) && allOk;
	allOk = compare_ivec3((block.t[1].b[2].a), ivec3(8, -4, -5)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[0]), ivec2(4, -8)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[1]), ivec2(-4, 1)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[2]), ivec2(-8, -6)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[3]), ivec2(-4, -5)) && allOk;
	allOk = compare_vec4((block.t[1].b[2].c), vec4(4.0, -9.0, 6.0, -7.0)) && allOk;
	allOk = compare_uint((block.u), 3u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s.a = (ivec3(9, -3, -2));
	block.s.b[0] = (ivec2(-3, 0));
	block.s.b[1] = (ivec2(2, -7));
	block.s.b[2] = (ivec2(0, -8));
	block.s.b[3] = (ivec2(0, -4));
	block.s.c = (vec4(-7.0, 9.0, -3.0, 9.0));
	block.u = (7u);
}
#version 450
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
	allOk = compare_mat3(block[0].t[0].a, mat3(-1.0, 8.0, 2.0, -1.0, 5.0, -5.0, 5.0, -9.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[0].a), ivec3(-8, 2, -4)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[0]), ivec2(-4, 4)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[1]), ivec2(1, 3)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[2]), ivec2(-6, -6)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[3]), ivec2(2, 3)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[0].c), vec4(8.0, 1.0, 4.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[1].a), ivec3(-4, -2, 9)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[0]), ivec2(2, 9)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[1]), ivec2(-5, -1)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[2]), ivec2(-9, -3)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[3]), ivec2(7, 1)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[1].c), vec4(8.0, 9.0, -1.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[2].a), ivec3(0, -2, -2)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[0]), ivec2(7, 6)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[1]), ivec2(3, -9)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[2]), ivec2(-4, 9)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[3]), ivec2(1, 3)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[2].c), vec4(-4.0, -6.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat3(block[0].t[1].a, mat3(-1.0, 7.0, -7.0, -4.0, -3.0, 2.0, -1.0, -9.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[0].a), ivec3(7, 3, -2)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[0]), ivec2(-2, -4)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[1]), ivec2(-8, -4)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[2]), ivec2(5, 1)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[3]), ivec2(-2, 2)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[0].c), vec4(1.0, 7.0, 0.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[1].a), ivec3(-2, 4, 9)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[0]), ivec2(9, 8)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[1]), ivec2(-5, -2)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[2]), ivec2(5, -4)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[3]), ivec2(-9, -2)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[1].c), vec4(-5.0, 4.0, -8.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[2].a), ivec3(-6, -2, 1)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[0]), ivec2(-8, -8)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[1]), ivec2(-4, 5)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[2]), ivec2(0, -5)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[3]), ivec2(2, 0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[2].c), vec4(-4.0, 0.0, 0.0, -4.0)) && allOk;
	allOk = compare_uint((block[0].u), 3u) && allOk;
	allOk = compare_mat3(block[1].t[0].a, mat3(-3.0, -2.0, 2.0, 0.0, 9.0, 3.0, -1.0, -1.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[0].a), ivec3(4, 5, 9)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[0]), ivec2(-5, 1)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[1]), ivec2(0, -6)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[2]), ivec2(0, -1)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[3]), ivec2(-1, 3)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[0].c), vec4(2.0, -1.0, -6.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[1].a), ivec3(0, 2, -6)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[0]), ivec2(4, -8)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[1]), ivec2(-4, -2)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[2]), ivec2(-2, 4)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[3]), ivec2(6, -2)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[1].c), vec4(3.0, 7.0, -9.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[2].a), ivec3(7, -9, -8)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[0]), ivec2(-5, 6)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[1]), ivec2(-5, 0)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[2]), ivec2(4, 5)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[3]), ivec2(-5, -6)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[2].c), vec4(-3.0, 6.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3(block[1].t[1].a, mat3(0.0, 6.0, 4.0, 7.0, -7.0, -8.0, 7.0, 5.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[0].a), ivec3(9, 0, 0)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[0]), ivec2(2, -3)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[1]), ivec2(2, -2)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[2]), ivec2(7, -4)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[3]), ivec2(-7, 4)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[0].c), vec4(2.0, -8.0, -4.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[1].a), ivec3(6, 8, -3)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[0]), ivec2(8, -8)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[1]), ivec2(2, -6)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[2]), ivec2(7, -6)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[3]), ivec2(-2, 1)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[1].c), vec4(-7.0, -5.0, 2.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[2].a), ivec3(-4, -5, -8)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[0]), ivec2(4, 1)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[1]), ivec2(-8, 2)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[2]), ivec2(-5, -7)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[3]), ivec2(1, -6)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[2].c), vec4(-6.0, -2.0, 6.0, 3.0)) && allOk;
	allOk = compare_uint((block[1].u), 2u) && allOk;
	allOk = compare_mat3(block[2].t[0].a, mat3(-9.0, -1.0, 8.0, -9.0, -9.0, 8.0, -5.0, -4.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[0].a), ivec3(-7, -4, 2)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[0]), ivec2(1, 8)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[1]), ivec2(3, -7)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[2]), ivec2(3, 7)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[3]), ivec2(-7, 6)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[0].c), vec4(9.0, 9.0, -7.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[1].a), ivec3(1, 1, 3)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[0]), ivec2(-5, -7)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[1]), ivec2(0, -2)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[2]), ivec2(-8, -7)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[3]), ivec2(-3, 5)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[1].c), vec4(-4.0, -9.0, 7.0, 2.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[2].a), ivec3(6, -5, -4)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[0]), ivec2(4, -7)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[1]), ivec2(-3, 8)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[2]), ivec2(-6, -3)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[3]), ivec2(-9, -3)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[2].c), vec4(-7.0, 7.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat3(block[2].t[1].a, mat3(9.0, -8.0, -4.0, 7.0, 5.0, -2.0, 4.0, -5.0, 2.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[0].a), ivec3(-4, 5, -8)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[0]), ivec2(-8, -4)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[1]), ivec2(-7, 2)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[2]), ivec2(3, 2)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[3]), ivec2(6, -2)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[0].c), vec4(-9.0, -6.0, -6.0, -3.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[1].a), ivec3(0, -4, 6)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[0]), ivec2(4, -2)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[1]), ivec2(-2, -7)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[2]), ivec2(-8, -6)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[3]), ivec2(-8, -8)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[1].c), vec4(1.0, 0.0, 0.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[2].a), ivec3(7, 5, 1)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[0]), ivec2(-6, 1)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[1]), ivec2(2, 5)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[2]), ivec2(6, -4)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[3]), ivec2(-2, -5)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[2].c), vec4(-5.0, -7.0, -1.0, 5.0)) && allOk;
	allOk = compare_uint((block[2].u), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (ivec3(6, 6, -3));
	block[0].s.b[0] = (ivec2(-9, 3));
	block[0].s.b[1] = (ivec2(-7, -7));
	block[0].s.b[2] = (ivec2(9, -9));
	block[0].s.b[3] = (ivec2(-7, 6));
	block[0].s.c = (vec4(9.0, 4.0, -9.0, 3.0));
	block[0].u = (7u);
	block[1].s.a = (ivec3(8, -1, -5));
	block[1].s.b[0] = (ivec2(5, -5));
	block[1].s.b[1] = (ivec2(7, 8));
	block[1].s.b[2] = (ivec2(-4, 0));
	block[1].s.b[3] = (ivec2(2, 1));
	block[1].s.c = (vec4(6.0, 5.0, -6.0, -7.0));
	block[1].u = (9u);
	block[2].s.a = (ivec3(-1, -9, 3));
	block[2].s.b[0] = (ivec2(8, 9));
	block[2].s.b[1] = (ivec2(1, -7));
	block[2].s.b[2] = (ivec2(9, -4));
	block[2].s.b[3] = (ivec2(5, -6));
	block[2].s.c = (vec4(-6.0, -5.0, -6.0, 6.0));
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

struct S
{
	highp ivec3 a;
	highp vec4 c;
};
layout(std140, buffer_reference) buffer Block
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
	allOk = compare_ivec3((block.s[0][0].a), ivec3(2, -9, 4)) && allOk;
	allOk = compare_vec4((block.s[0][0].c), vec4(-6.0, -3.0, 6.0, 2.0)) && allOk;
	allOk = compare_ivec3((block.s[0][1].a), ivec3(-9, 9, -4)) && allOk;
	allOk = compare_vec4((block.s[0][1].c), vec4(8.0, -3.0, 3.0, 0.0)) && allOk;
	allOk = compare_ivec3((block.s[1][0].a), ivec3(-3, 9, 8)) && allOk;
	allOk = compare_vec4((block.s[1][0].c), vec4(4.0, -1.0, 9.0, 0.0)) && allOk;
	allOk = compare_ivec3((block.s[1][1].a), ivec3(2, 9, 7)) && allOk;
	allOk = compare_vec4((block.s[1][1].c), vec4(1.0, -6.0, -7.0, -3.0)) && allOk;
	allOk = compare_ivec3((block.s[2][0].a), ivec3(-5, 2, -8)) && allOk;
	allOk = compare_vec4((block.s[2][0].c), vec4(-9.0, 1.0, -2.0, 4.0)) && allOk;
	allOk = compare_ivec3((block.s[2][1].a), ivec3(3, -4, -7)) && allOk;
	allOk = compare_vec4((block.s[2][1].c), vec4(4.0, 4.0, -9.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.v = (vec4(-5.0, -8.0, 6.0, -9.0));
	block.s[0][0].a = (ivec3(-9, -8, 0));
	block.s[0][0].c = (vec4(-5.0, -4.0, -9.0, 4.0));
	block.s[0][1].a = (ivec3(5, 1, 7));
	block.s[0][1].c = (vec4(-4.0, 4.0, -8.0, -1.0));
	block.s[1][0].a = (ivec3(-1, -9, 2));
	block.s[1][0].c = (vec4(6.0, -9.0, 6.0, 7.0));
	block.s[1][1].a = (ivec3(-8, -3, -4));
	block.s[1][1].c = (vec4(-1.0, -8.0, 4.0, -9.0));
	block.s[2][0].a = (ivec3(-5, 6, -6));
	block.s[2][0].c = (vec4(-3.0, 2.0, -8.0, 1.0));
	block.s[2][1].a = (ivec3(9, -3, -3));
	block.s[2][1].c = (vec4(-6.0, -5.0, 7.0, -8.0));
}
#version 450
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

layout(std140, buffer_reference) buffer Block
{
	uint8_t var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(block[0].var), 7u) && allOk;
	allOk = compare_uint8_t(uint(block[1].var), 1u) && allOk;
	allOk = compare_uint8_t(uint(block[2].var), 3u) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = uint8_t(9u);
	block[1].var = uint8_t(5u);
	block[2].var = uint8_t(2u);
}
#version 450
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
	allOk = compare_float(block[0].var[0][0], 7.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -2.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 6.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 3.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 1.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -7.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 1.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -4.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 0.0) && allOk;
	allOk = compare_float(block[0].var[3][0], 9.0) && allOk;
	allOk = compare_float(block[0].var[3][1], 9.0) && allOk;
	allOk = compare_float(block[0].var[3][2], -4.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(7.0, -2.0, 6.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(3.0, 1.0, -7.0)) && allOk;
	allOk = compare_vec3(block[0].var[2], vec3(1.0, -4.0, 0.0)) && allOk;
	allOk = compare_vec3(block[0].var[3], vec3(9.0, 9.0, -4.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 3.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 2.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 2.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 6.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 6.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 0.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 3.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 6.0) && allOk;
	allOk = compare_float(block[1].var[2][2], -4.0) && allOk;
	allOk = compare_float(block[1].var[3][0], 8.0) && allOk;
	allOk = compare_float(block[1].var[3][1], 5.0) && allOk;
	allOk = compare_float(block[1].var[3][2], 4.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(3.0, 2.0, 2.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(6.0, 6.0, 0.0)) && allOk;
	allOk = compare_vec3(block[1].var[2], vec3(3.0, 6.0, -4.0)) && allOk;
	allOk = compare_vec3(block[1].var[3], vec3(8.0, 5.0, 4.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], -6.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -5.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 4.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -4.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 1.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 2.0) && allOk;
	allOk = compare_float(block[2].var[2][0], -5.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 9.0) && allOk;
	allOk = compare_float(block[2].var[2][2], -7.0) && allOk;
	allOk = compare_float(block[2].var[3][0], -2.0) && allOk;
	allOk = compare_float(block[2].var[3][1], -5.0) && allOk;
	allOk = compare_float(block[2].var[3][2], 8.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(-6.0, -5.0, 4.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(-4.0, 1.0, 2.0)) && allOk;
	allOk = compare_vec3(block[2].var[2], vec3(-5.0, 9.0, -7.0)) && allOk;
	allOk = compare_vec3(block[2].var[3], vec3(-2.0, -5.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec3(7.0, 4.0, -4.0));
	block[0].var[1] = (vec3(-6.0, 3.0, -3.0));
	block[0].var[2] = (vec3(9.0, -2.0, 3.0));
	block[0].var[3] = (vec3(9.0, -9.0, 7.0));
	block[1].var[0] = (vec3(5.0, 1.0, -9.0));
	block[1].var[1] = (vec3(-1.0, -2.0, 6.0));
	block[1].var[2] = (vec3(-4.0, 6.0, 4.0));
	block[1].var[3] = (vec3(-8.0, 7.0, 3.0));
	block[2].var[0] = (vec3(-4.0, -9.0, 8.0));
	block[2].var[1] = (vec3(9.0, 2.0, 2.0));
	block[2].var[2] = (vec3(9.0, -7.0, 3.0));
	block[2].var[3] = (vec3(8.0, 2.0, 4.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), 2.0) && allOk;
	allOk = compare_float(block[0].var[0][0], 7.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -5.0) && allOk;
	allOk = compare_float(block[0].var[0][2], -9.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 5.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 1.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 3.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(7.0, -5.0, -9.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(5.0, 1.0, 3.0)) && allOk;
	allOk = compare_float((block[1].padding), 8.0) && allOk;
	allOk = compare_float(block[1].var[0][0], 6.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -3.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -5.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 9.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 2.0) && allOk;
	allOk = compare_float(block[1].var[1][2], -5.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(6.0, -3.0, -5.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(9.0, 2.0, -5.0)) && allOk;
	allOk = compare_float((block[2].padding), -2.0) && allOk;
	allOk = compare_float(block[2].var[0][0], -8.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 2.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 8.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 6.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 3.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 6.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(-8.0, 2.0, 8.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(6.0, 3.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (1.0);
	block[0].var[0] = (vec3(-3.0, 9.0, -8.0));
	block[0].var[1] = (vec3(-1.0, 1.0, -5.0));
	block[1].padding = (3.0);
	block[1].var[0] = (vec3(6.0, 6.0, -9.0));
	block[1].var[1] = (vec3(-3.0, 7.0, 7.0));
	block[2].padding = (-2.0);
	block[2].var[0] = (vec3(0.0, -8.0, -2.0));
	block[2].var[1] = (vec3(-7.0, 0.0, -5.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), -5.0) && allOk;
	allOk = compare_float(block[0].var[0][0], -2.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -4.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 7.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -9.0) && allOk;
	allOk = compare_float(block[0].var[2][0], -9.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -9.0) && allOk;
	allOk = compare_float(block[0].var[3][0], 1.0) && allOk;
	allOk = compare_float(block[0].var[3][1], -6.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(-2.0, -4.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(7.0, -9.0)) && allOk;
	allOk = compare_vec2(block[0].var[2], vec2(-9.0, -9.0)) && allOk;
	allOk = compare_vec2(block[0].var[3], vec2(1.0, -6.0)) && allOk;
	allOk = compare_float((block[1].padding), -1.0) && allOk;
	allOk = compare_float(block[1].var[0][0], -5.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -9.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -2.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -2.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 2.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -5.0) && allOk;
	allOk = compare_float(block[1].var[3][0], -3.0) && allOk;
	allOk = compare_float(block[1].var[3][1], -8.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(-5.0, -9.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(-2.0, -2.0)) && allOk;
	allOk = compare_vec2(block[1].var[2], vec2(2.0, -5.0)) && allOk;
	allOk = compare_vec2(block[1].var[3], vec2(-3.0, -8.0)) && allOk;
	allOk = compare_float((block[2].padding), -8.0) && allOk;
	allOk = compare_float(block[2].var[0][0], 1.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 3.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 0.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -3.0) && allOk;
	allOk = compare_float(block[2].var[2][0], -9.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 0.0) && allOk;
	allOk = compare_float(block[2].var[3][0], -7.0) && allOk;
	allOk = compare_float(block[2].var[3][1], -1.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(1.0, 3.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(0.0, -3.0)) && allOk;
	allOk = compare_vec2(block[2].var[2], vec2(-9.0, 0.0)) && allOk;
	allOk = compare_vec2(block[2].var[3], vec2(-7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (0.0);
	block[0].var = (mat4x2(-3.0, -2.0, 2.0, -2.0, -3.0, 5.0, -5.0, 5.0));
	block[1].padding = (-6.0);
	block[1].var = (mat4x2(-4.0, -1.0, 4.0, 7.0, -8.0, -2.0, -5.0, -1.0));
	block[2].padding = (-3.0);
	block[2].var = (mat4x2(6.0, -2.0, 0.0, -7.0, -7.0, 2.0, 0.0, -6.0));
}
#version 450
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
	u8vec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(block[0].padding), 3u) && allOk;
	allOk = compare_u8vec2(uvec2(block[0].var), uvec2(0u, 7u)) && allOk;
	allOk = compare_uint8_t(uint(block[1].padding), 2u) && allOk;
	allOk = compare_u8vec2(uvec2(block[1].var), uvec2(4u, 2u)) && allOk;
	allOk = compare_uint8_t(uint(block[2].padding), 7u) && allOk;
	allOk = compare_u8vec2(uvec2(block[2].var), uvec2(3u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = uint8_t(7u);
	block[0].var = u8vec2(uvec2(7u, 9u));
	block[1].padding = uint8_t(6u);
	block[1].var = u8vec2(uvec2(0u, 2u));
	block[2].padding = uint8_t(1u);
	block[2].var = u8vec2(uvec2(1u, 0u));
}
#version 450
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
	u8vec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(block[0].padding), 4u) && allOk;
	allOk = compare_u8vec3(uvec3(block[0].var), uvec3(3u, 0u, 1u)) && allOk;
	allOk = compare_uint8_t(uint(block[1].padding), 4u) && allOk;
	allOk = compare_u8vec3(uvec3(block[1].var), uvec3(3u, 8u, 6u)) && allOk;
	allOk = compare_uint8_t(uint(block[2].padding), 0u) && allOk;
	allOk = compare_u8vec3(uvec3(block[2].var), uvec3(6u, 4u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = uint8_t(4u);
	block[0].var = u8vec3(uvec3(5u, 9u, 6u));
	block[1].padding = uint8_t(9u);
	block[1].var = u8vec3(uvec3(4u, 7u, 1u));
	block[2].padding = uint8_t(5u);
	block[2].var = u8vec3(uvec3(1u, 7u, 9u));
}
#version 450
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
	i16vec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(block[0].padding), 3) && allOk;
	allOk = compare_i16vec2(ivec2(block[0].var), ivec2(-1, 8)) && allOk;
	allOk = compare_int16_t(int(block[1].padding), -3) && allOk;
	allOk = compare_i16vec2(ivec2(block[1].var), ivec2(-4, 2)) && allOk;
	allOk = compare_int16_t(int(block[2].padding), -1) && allOk;
	allOk = compare_i16vec2(ivec2(block[2].var), ivec2(-3, -1)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = int16_t(6);
	block[0].var = i16vec2(ivec2(-2, -2));
	block[1].padding = int16_t(-8);
	block[1].var = i16vec2(ivec2(3, 5));
	block[2].padding = int16_t(-9);
	block[2].var = i16vec2(ivec2(-9, -4));
}
#version 450
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
	lowp ivec2 a;
	highp mat3x4 b[1];
	mediump mat3x4 c;
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	highp mat2x3 d;
	bvec2 e;
	lowp vec3 f;
	mediump mat4 g;
	mediump mat4 h;
};
layout(std140, buffer_reference) buffer BlockD
{
	mediump mat4x3 i;
	bvec3 j;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a), ivec2(-5, 5)) && allOk;
	allOk = compare_mat3x4(blockB.b[0], mat3x4(-6.0, -9.0, 9.0, -5.0, 7.0, 7.0, 0.0, 5.0, -7.0, -5.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3x4(blockB.c, mat3x4(5.0, 2.0, -4.0, 7.0, 7.0, -1.0, 3.0, -2.0, -1.0, -5.0, 5.0, 3.0)) && allOk;
	allOk = compare_vec3((blockC.f), vec3(4.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat4(blockC.g, mat4(1.0, 0.0, 9.0, 3.0, -4.0, 6.0, -3.0, 3.0, 7.0, 8.0, 2.0, -7.0, -6.0, 5.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4(blockC.h, mat4(-3.0, -1.0, -3.0, 0.0, -3.0, 0.0, -5.0, 5.0, 8.0, -6.0, 2.0, -4.0, 3.0, -5.0, -9.0, 4.0)) && allOk;
	allOk = compare_bvec3((blockD.j), bvec3(true, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec2(3, -4));
	blockB.b[0] = (mat3x4(2.0, 2.0, 4.0, 9.0, -2.0, -4.0, -9.0, -2.0, 0.0, 9.0, 8.0, -5.0));
	blockB.c = (mat3x4(4.0, -6.0, -8.0, -5.0, 0.0, 4.0, 7.0, 3.0, -2.0, 9.0, 0.0, 6.0));
	blockC.e = (bvec2(false, true));
	blockC.h = (mat4(-2.0, -9.0, 9.0, -5.0, -5.0, 7.0, 2.0, 0.0, -5.0, -1.0, 5.0, -4.0, -4.0, -8.0, -2.0, 9.0));
	blockD.j = (bvec3(true, false, false));
}
#version 450
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
	mediump vec4 a[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.a[0]), vec4(-8.0, -2.0, 9.0, -5.0)) && allOk;
	allOk = compare_vec4((blockB.a[1]), vec4(5.0, 6.0, -1.0, 9.0)) && allOk;
	allOk = compare_vec4((blockB.a[2]), vec4(-1.0, 6.0, 0.0, -9.0)) && allOk;
	allOk = compare_vec4((blockB.a[3]), vec4(1.0, 8.0, 1.0, -2.0)) && allOk;
	allOk = compare_vec4((blockB.a[4]), vec4(-8.0, -6.0, -1.0, -8.0)) && allOk;
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
	lowp mat2x3 a[7];
	lowp vec3 b[];
};
layout(std430, buffer_reference) buffer BlockC
{
	lowp vec3 c[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	highp uint d;
	highp mat4x2 e;
	mediump mat4x2 f;
	mediump uvec4 g[6];
	lowp ivec4 h[][5];
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
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB.a[0], mat2x3(-2.0, 4.0, 3.0, -8.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[1], mat2x3(-4.0, -5.0, -3.0, -2.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[2], mat2x3(-6.0, 9.0, -2.0, 5.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[3], mat2x3(0.0, -6.0, 1.0, 2.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[4], mat2x3(8.0, 0.0, 1.0, 4.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[5], mat2x3(7.0, 2.0, -8.0, 7.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[6], mat2x3(-5.0, -4.0, 3.0, 5.0, 9.0, -3.0)) && allOk;
	allOk = compare_vec3((blockB.b[0]), vec3(-6.0, 6.0, 6.0)) && allOk;
	allOk = compare_vec3((blockB.b[1]), vec3(0.0, 1.0, -9.0)) && allOk;
	allOk = compare_vec3((blockB.b[2]), vec3(2.0, -2.0, -3.0)) && allOk;
	allOk = compare_vec3((blockB.b[3]), vec3(0.0, -4.0, 4.0)) && allOk;
	allOk = compare_vec3((blockB.b[4]), vec3(0.0, 9.0, -5.0)) && allOk;
	allOk = compare_vec3((blockC.c[0]), vec3(7.0, -4.0, 5.0)) && allOk;
	allOk = compare_vec3((blockC.c[1]), vec3(7.0, -8.0, -1.0)) && allOk;
	allOk = compare_vec3((blockC.c[2]), vec3(8.0, 8.0, 7.0)) && allOk;
	allOk = compare_vec3((blockC.c[3]), vec3(-4.0, -7.0, 2.0)) && allOk;
	allOk = compare_vec3((blockC.c[4]), vec3(-6.0, -1.0, 5.0)) && allOk;
	allOk = compare_vec3((blockC.c[5]), vec3(8.0, -9.0, -6.0)) && allOk;
	allOk = compare_vec3((blockC.c[6]), vec3(2.0, -8.0, -9.0)) && allOk;
	allOk = compare_vec3((blockC.c[7]), vec3(4.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat4x2(blockD.e, mat4x2(-9.0, -7.0, 4.0, 3.0, 6.0, 7.0, 5.0, 7.0)) && allOk;
	allOk = compare_ivec4((blockD.h[0][0]), ivec4(-2, -4, 6, 4)) && allOk;
	allOk = compare_ivec4((blockD.h[0][1]), ivec4(-7, -1, 4, -2)) && allOk;
	allOk = compare_ivec4((blockD.h[0][2]), ivec4(8, -4, 8, 3)) && allOk;
	allOk = compare_ivec4((blockD.h[0][3]), ivec4(-8, 5, -9, 3)) && allOk;
	allOk = compare_ivec4((blockD.h[0][4]), ivec4(9, 1, 6, -5)) && allOk;
	allOk = compare_ivec4((blockD.h[1][0]), ivec4(-9, -1, -1, 8)) && allOk;
	allOk = compare_ivec4((blockD.h[1][1]), ivec4(-5, 8, 2, -1)) && allOk;
	allOk = compare_ivec4((blockD.h[1][2]), ivec4(8, -8, 2, 2)) && allOk;
	allOk = compare_ivec4((blockD.h[1][3]), ivec4(-6, 1, 9, -2)) && allOk;
	allOk = compare_ivec4((blockD.h[1][4]), ivec4(-2, 6, -5, -2)) && allOk;
	allOk = compare_ivec4((blockD.h[2][0]), ivec4(-5, -3, 4, 3)) && allOk;
	allOk = compare_ivec4((blockD.h[2][1]), ivec4(2, 9, -3, 4)) && allOk;
	allOk = compare_ivec4((blockD.h[2][2]), ivec4(-9, 7, -2, 6)) && allOk;
	allOk = compare_ivec4((blockD.h[2][3]), ivec4(0, 5, 5, 3)) && allOk;
	allOk = compare_ivec4((blockD.h[2][4]), ivec4(-9, 6, -4, 7)) && allOk;
	allOk = compare_ivec4((blockD.h[3][0]), ivec4(3, -2, -5, 6)) && allOk;
	allOk = compare_ivec4((blockD.h[3][1]), ivec4(-1, -3, 0, 0)) && allOk;
	allOk = compare_ivec4((blockD.h[3][2]), ivec4(8, -3, 3, -2)) && allOk;
	allOk = compare_ivec4((blockD.h[3][3]), ivec4(-2, -1, -8, 9)) && allOk;
	allOk = compare_ivec4((blockD.h[3][4]), ivec4(4, -5, 9, -3)) && allOk;
	allOk = compare_ivec4((blockD.h[4][0]), ivec4(8, 9, -4, 0)) && allOk;
	allOk = compare_ivec4((blockD.h[4][1]), ivec4(-1, 9, 1, 9)) && allOk;
	allOk = compare_ivec4((blockD.h[4][2]), ivec4(8, 8, 4, -9)) && allOk;
	allOk = compare_ivec4((blockD.h[4][3]), ivec4(6, 6, -7, 7)) && allOk;
	allOk = compare_ivec4((blockD.h[4][4]), ivec4(9, 9, 1, 6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat2x3(-7.0, 3.0, -9.0, -7.0, -4.0, -1.0));
	blockB.a[1] = (mat2x3(9.0, -4.0, -4.0, 3.0, -7.0, -4.0));
	blockB.a[2] = (mat2x3(0.0, -7.0, -9.0, -8.0, -4.0, -7.0));
	blockB.a[3] = (mat2x3(2.0, -5.0, -9.0, 9.0, -1.0, 9.0));
	blockB.a[4] = (mat2x3(4.0, 1.0, -8.0, -2.0, -5.0, -9.0));
	blockB.a[5] = (mat2x3(-7.0, 0.0, 7.0, -2.0, 9.0, -6.0));
	blockB.a[6] = (mat2x3(8.0, 5.0, 3.0, -3.0, 6.0, -2.0));
	blockB.b[0] = (vec3(2.0, -5.0, 5.0));
	blockB.b[1] = (vec3(5.0, 3.0, 8.0));
	blockB.b[2] = (vec3(5.0, 5.0, 3.0));
	blockB.b[3] = (vec3(6.0, 5.0, 1.0));
	blockB.b[4] = (vec3(1.0, -2.0, -3.0));
	blockC.c[0] = (vec3(8.0, 2.0, -1.0));
	blockC.c[1] = (vec3(-8.0, 9.0, -7.0));
	blockC.c[2] = (vec3(5.0, 1.0, 3.0));
	blockC.c[3] = (vec3(6.0, -8.0, -8.0));
	blockC.c[4] = (vec3(-6.0, 7.0, 6.0));
	blockC.c[5] = (vec3(-5.0, 7.0, 6.0));
	blockC.c[6] = (vec3(-6.0, 0.0, 7.0));
	blockC.c[7] = (vec3(-7.0, 4.0, -4.0));
	blockD.d = (1u);
	blockD.e = (mat4x2(1.0, -6.0, 7.0, -7.0, 7.0, -2.0, 2.0, 2.0));
	blockD.f = (mat4x2(4.0, -9.0, 9.0, -2.0, -4.0, -3.0, 7.0, 8.0));
	blockD.g[0] = (uvec4(5u, 7u, 7u, 0u));
	blockD.g[1] = (uvec4(2u, 1u, 5u, 3u));
	blockD.g[2] = (uvec4(4u, 9u, 1u, 1u));
	blockD.g[3] = (uvec4(1u, 5u, 7u, 5u));
	blockD.g[4] = (uvec4(6u, 5u, 3u, 6u));
	blockD.g[5] = (uvec4(0u, 3u, 9u, 8u));
	blockD.h[0][0] = (ivec4(8, -9, -5, 5));
	blockD.h[0][1] = (ivec4(1, -1, -9, -5));
	blockD.h[0][2] = (ivec4(-1, 2, -4, -1));
	blockD.h[0][3] = (ivec4(-8, -3, 3, 3));
	blockD.h[0][4] = (ivec4(8, 2, -9, -2));
	blockD.h[1][0] = (ivec4(-3, 4, -7, -6));
	blockD.h[1][1] = (ivec4(8, 5, 2, -1));
	blockD.h[1][2] = (ivec4(0, 4, 9, -2));
	blockD.h[1][3] = (ivec4(0, 9, 9, -2));
	blockD.h[1][4] = (ivec4(-5, 9, -8, 8));
	blockD.h[2][0] = (ivec4(-5, 5, -7, -4));
	blockD.h[2][1] = (ivec4(3, 4, -1, 6));
	blockD.h[2][2] = (ivec4(1, 9, -3, -8));
	blockD.h[2][3] = (ivec4(0, -7, -9, 4));
	blockD.h[2][4] = (ivec4(3, 7, 0, -4));
	blockD.h[3][0] = (ivec4(-4, -6, 4, 8));
	blockD.h[3][1] = (ivec4(-1, -6, 4, 3));
	blockD.h[3][2] = (ivec4(2, 3, 6, -1));
	blockD.h[3][3] = (ivec4(-4, -2, 5, 8));
	blockD.h[3][4] = (ivec4(-9, 9, -8, 8));
	blockD.h[4][0] = (ivec4(-8, 5, 8, -6));
	blockD.h[4][1] = (ivec4(9, -3, -2, -4));
	blockD.h[4][2] = (ivec4(8, 7, 6, 3));
	blockD.h[4][3] = (ivec4(4, 0, 9, 6));
	blockD.h[4][4] = (ivec4(0, 3, -6, 0));
}
#version 450
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
	lowp mat4x2 mB[4];
	lowp mat4x2 mC;
};
layout(std140, buffer_reference) buffer BlockB
{
	highp uvec2 a;
	sA b;
	mediump uvec4 c;
	lowp uint d[6];
	bvec4 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.e), bvec4(false, true, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (uvec4(0u, 0u, 1u, 8u));
	blockB.e = (bvec4(false, true, true, true));
}
#version 450
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
	highp uvec2 mB;
	highp vec2 mC[8];
	highp vec2 mD;
};
struct sB
{
	highp uint mA;
	bvec2 mB;
	sA mC;
	highp mat3 mD[3];
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	mediump uvec2 a;
	mediump float b;
	mediump ivec4 c;
	bvec2 d;
	mediump mat3 e;
};
layout(std430, buffer_reference) buffer BlockC
{
	highp float f;
	highp ivec2 g;
	mediump float h;
	highp ivec4 i[];
};
layout(std430, buffer_reference) readonly buffer BlockD
{
	sB j[];
};
layout(std140, buffer_reference) buffer BlockE
{
	highp mat3 k;
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
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a), uvec2(2u, 6u)) && allOk;
	allOk = compare_float((blockB.b), 0.0) && allOk;
	allOk = compare_ivec4((blockB.c), ivec4(-3, 7, 2, 3)) && allOk;
	allOk = compare_bvec2((blockB.d), bvec2(true, true)) && allOk;
	allOk = compare_float((blockC.f), -1.0) && allOk;
	allOk = compare_ivec2((blockC.g), ivec2(-3, 9)) && allOk;
	allOk = compare_float((blockC.h), 4.0) && allOk;
	allOk = compare_ivec4((blockC.i[0]), ivec4(6, 0, 6, -3)) && allOk;
	allOk = compare_ivec4((blockC.i[1]), ivec4(7, -3, -2, 4)) && allOk;
	allOk = compare_ivec4((blockC.i[2]), ivec4(8, 6, 9, -6)) && allOk;
	allOk = compare_ivec4((blockC.i[3]), ivec4(-5, -7, 5, 1)) && allOk;
	allOk = compare_ivec4((blockC.i[4]), ivec4(-2, -7, 8, -3)) && allOk;
	allOk = compare_ivec4((blockC.i[5]), ivec4(5, -1, -3, 9)) && allOk;
	allOk = compare_ivec4((blockC.i[6]), ivec4(2, 0, 2, 1)) && allOk;
	allOk = compare_mat3(blockE.k, mat3(-1.0, 5.0, 7.0, 3.0, 8.0, 8.0, -4.0, 7.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (1.0);
	blockB.c = (ivec4(-5, 7, -4, 4));
	blockB.e = (mat3(-5.0, 5.0, 1.0, 7.0, 9.0, 7.0, 4.0, -3.0, -2.0));
	blockC.f = (-2.0);
	blockC.g = (ivec2(-2, 1));
	blockC.h = (4.0);
	blockC.i[0] = (ivec4(9, 0, 5, 1));
	blockC.i[1] = (ivec4(-9, 4, -3, -8));
	blockC.i[2] = (ivec4(-9, 7, -5, 7));
	blockC.i[3] = (ivec4(1, 2, -4, -5));
	blockC.i[4] = (ivec4(-1, 0, -4, 3));
	blockC.i[5] = (ivec4(-2, -4, -6, 6));
	blockC.i[6] = (ivec4(-3, -6, 2, -6));
	blockE.k = (mat3(2.0, -7.0, 1.0, -4.0, 8.0, 8.0, -6.0, -3.0, 2.0));
}
#version 450
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
	lowp uvec4 a;
	highp ivec3 b;
	mediump float c;
	highp uint d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB[nonuniformEXT(0)].a), uvec4(7u, 0u, 1u, 9u)) && allOk;
	allOk = compare_float((blockB[nonuniformEXT(0)].c), 4.0) && allOk;
	allOk = compare_uvec4((blockB[nonuniformEXT(1)].a), uvec4(8u, 3u, 4u, 5u)) && allOk;
	allOk = compare_float((blockB[nonuniformEXT(1)].c), -5.0) && allOk;
	allOk = compare_uvec4((blockB[nonuniformEXT(2)].a), uvec4(4u, 8u, 3u, 0u)) && allOk;
	allOk = compare_float((blockB[nonuniformEXT(2)].c), -7.0) && allOk;
	allOk = compare_uvec4((blockB[nonuniformEXT(3)].a), uvec4(2u, 3u, 7u, 6u)) && allOk;
	allOk = compare_float((blockB[nonuniformEXT(3)].c), -7.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = (ivec3(-3, 7, -3));
	blockB[nonuniformEXT(0)].c = (4.0);
	blockB[nonuniformEXT(1)].b = (ivec3(4, 2, -9));
	blockB[nonuniformEXT(1)].c = (-8.0);
	blockB[nonuniformEXT(2)].b = (ivec3(-6, -4, -2));
	blockB[nonuniformEXT(2)].c = (-8.0);
	blockB[nonuniformEXT(3)].b = (ivec3(8, 0, -1));
	blockB[nonuniformEXT(3)].c = (1.0);
}
#version 450
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
	highp mat4x3 a;
	mediump mat4x3 b[1];
	highp mat3x2 c;
	highp uvec3 d;
	bool e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

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

layout(std430, buffer_reference) buffer BlockB
{
	lowp float a;
	float16_t b;
	uint16_t c;
	float16_t d;
};
layout(std140, buffer_reference) buffer BlockC
{
	uint16_t e;
};
layout(std140, buffer_reference) buffer BlockD
{
	mediump float f;
	int16_t g;
	bool h;
};
layout(std430, buffer_reference) buffer BlockE
{
	int16_t i;
	highp int j;
	lowp int k;
	float16_t l;
	uint16_t m;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
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
	allOk = compare_float16_t(float(blockB.b), -8.0) && allOk;
	allOk = compare_float16_t(float(blockB.d), 7.0) && allOk;
	allOk = compare_bool((blockD.h), false) && allOk;
	allOk = compare_int16_t(int(blockE.i), -6) && allOk;
	allOk = compare_int((blockE.j), 4) && allOk;
	allOk = compare_float16_t(float(blockE.l), 6.0) && allOk;
	allOk = compare_uint16_t(uint(blockE.m), 2u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (8.0);
	blockB.c = uint16_t(4u);
	blockB.d = float16_t(-6.0);
	blockC.e = uint16_t(8u);
	blockD.f = (0.0);
	blockD.g = int16_t(9);
	blockD.h = (false);
	blockE.i = int16_t(4);
	blockE.j = (8);
	blockE.k = (6);
	blockE.l = float16_t(7.0);
}
#version 450
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
	highp mat3x2 a;
	highp int b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.b[0]), -2) && allOk;
	allOk = compare_int((blockB.b[1]), -5) && allOk;
	allOk = compare_int((blockB.b[2]), -3) && allOk;
	allOk = compare_int((blockB.b[3]), -3) && allOk;
	allOk = compare_int((blockB.b[4]), 1) && allOk;
	allOk = compare_int((blockB.b[5]), -3) && allOk;
	allOk = compare_int((blockB.b[6]), 8) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x2(8.0, 6.0, 7.0, 0.0, -2.0, 5.0));
}
#version 450
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
	lowp uvec4 a;
	uint16_t b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(blockB.b[0]), 4u) && allOk;
	allOk = compare_uint16_t(uint(blockB.b[1]), 5u) && allOk;
	allOk = compare_uint16_t(uint(blockB.b[2]), 4u) && allOk;
	allOk = compare_uint16_t(uint(blockB.b[3]), 3u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec4(7u, 9u, 4u, 8u));
}
#version 450
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
layout(std430, buffer_reference) buffer BlockB
{
	mediump mat3x2 a;
	sA b;
	u16vec4 c;
	bvec4 d;
	float16_t e[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	i16vec3 f;
	lowp mat2x3 g;
	f16vec4 h;
	highp mat2x3 i[][8][3];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	lowp mat3x2 j;
	i16vec3 k[][8];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC[1];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
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
	allOk = compare_mat3x2(blockD.j, mat3x2(1.0, -2.0, -8.0, 8.0, -1.0, -8.0)) && allOk;
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
	blockD.j = (mat3x2(-3.0, -2.0, 5.0, 9.0, -3.0, -3.0));
	blockD.k[0][0] = i16vec3(ivec3(-9, 9, -9));
	blockD.k[0][1] = i16vec3(ivec3(-8, -2, 4));
	blockD.k[0][2] = i16vec3(ivec3(-9, 4, -5));
	blockD.k[0][3] = i16vec3(ivec3(-3, -2, 4));
	blockD.k[0][4] = i16vec3(ivec3(0, 8, -4));
	blockD.k[0][5] = i16vec3(ivec3(-3, 9, -3));
	blockD.k[0][6] = i16vec3(ivec3(6, 8, 5));
	blockD.k[0][7] = i16vec3(ivec3(8, 7, -6));
	blockD.k[1][0] = i16vec3(ivec3(8, -8, 8));
	blockD.k[1][1] = i16vec3(ivec3(4, 5, 3));
	blockD.k[1][2] = i16vec3(ivec3(-2, 5, 2));
	blockD.k[1][3] = i16vec3(ivec3(2, 6, 6));
	blockD.k[1][4] = i16vec3(ivec3(-6, 5, 9));
	blockD.k[1][5] = i16vec3(ivec3(-5, 6, 7));
	blockD.k[1][6] = i16vec3(ivec3(-4, 3, -9));
	blockD.k[1][7] = i16vec3(ivec3(-6, -6, -5));
	blockD.k[2][0] = i16vec3(ivec3(5, -4, -8));
	blockD.k[2][1] = i16vec3(ivec3(5, 5, 1));
	blockD.k[2][2] = i16vec3(ivec3(-4, 4, -7));
	blockD.k[2][3] = i16vec3(ivec3(1, 0, -5));
	blockD.k[2][4] = i16vec3(ivec3(-4, 0, -3));
	blockD.k[2][5] = i16vec3(ivec3(-8, -9, -3));
	blockD.k[2][6] = i16vec3(ivec3(-4, 4, 5));
	blockD.k[2][7] = i16vec3(ivec3(-7, 3, 1));
}
#version 450
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
layout(scalar, row_major, buffer_reference) buffer BlockB
{
	f16vec3 a;
	sA b[][1][3];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(blockB[0].a), vec3(6.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat4x3(blockB[0].b[0][0][0].mA, mat4x3(7.0, 0.0, -6.0, 8.0, -4.0, 0.0, 4.0, -1.0, 6.0, 0.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat4x3(blockB[0].b[0][0][1].mA, mat4x3(0.0, 0.0, -5.0, 7.0, -1.0, -5.0, 8.0, 2.0, -3.0, -7.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat4x3(blockB[0].b[0][0][2].mA, mat4x3(-3.0, 7.0, -4.0, 0.0, -2.0, 9.0, -7.0, -8.0, -4.0, 7.0, -4.0, -6.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB[1].a), vec3(-6.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(blockB[1].b[0][0][0].mA, mat4x3(2.0, 8.0, 6.0, 3.0, -6.0, -5.0, -1.0, 7.0, 2.0, -6.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat4x3(blockB[1].b[0][0][1].mA, mat4x3(-5.0, -1.0, 1.0, -9.0, -3.0, 6.0, 4.0, 5.0, 5.0, -3.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat4x3(blockB[1].b[0][0][2].mA, mat4x3(0.0, -8.0, 4.0, 2.0, 5.0, 4.0, -6.0, 9.0, -9.0, -4.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat4x3(blockB[1].b[1][0][0].mA, mat4x3(-7.0, -1.0, 3.0, -5.0, -9.0, 7.0, 7.0, 0.0, -7.0, -1.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(blockB[1].b[1][0][1].mA, mat4x3(1.0, 1.0, -5.0, 3.0, 9.0, -7.0, -8.0, 5.0, 8.0, -7.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4x3(blockB[1].b[1][0][2].mA, mat4x3(2.0, -4.0, -7.0, -4.0, 1.0, 1.0, 7.0, 5.0, -4.0, -9.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat4x3(blockB[1].b[2][0][0].mA, mat4x3(-2.0, 8.0, -4.0, -8.0, -5.0, -9.0, -5.0, 4.0, 9.0, -2.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(blockB[1].b[2][0][1].mA, mat4x3(-6.0, 8.0, 3.0, -2.0, 2.0, -1.0, 6.0, 8.0, 2.0, 6.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat4x3(blockB[1].b[2][0][2].mA, mat4x3(-8.0, 8.0, 8.0, -2.0, 6.0, 3.0, 8.0, -8.0, 2.0, 8.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat4x3(blockB[1].b[3][0][0].mA, mat4x3(0.0, -5.0, -6.0, -4.0, -2.0, -5.0, 7.0, -5.0, -8.0, 7.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4x3(blockB[1].b[3][0][1].mA, mat4x3(-2.0, 6.0, 6.0, -7.0, 6.0, 4.0, -7.0, -3.0, 8.0, 4.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat4x3(blockB[1].b[3][0][2].mA, mat4x3(0.0, 3.0, 1.0, 8.0, 3.0, 1.0, 8.0, 5.0, 8.0, -8.0, -7.0, 6.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB[2].a), vec3(0.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat4x3(blockB[2].b[0][0][0].mA, mat4x3(-2.0, -7.0, 5.0, 7.0, -1.0, -2.0, -3.0, 6.0, 9.0, 7.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(blockB[2].b[0][0][1].mA, mat4x3(0.0, 7.0, -3.0, -6.0, -2.0, 3.0, -3.0, 0.0, 4.0, 3.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat4x3(blockB[2].b[0][0][2].mA, mat4x3(-2.0, 9.0, 9.0, -8.0, 2.0, -1.0, 8.0, 3.0, -2.0, 3.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat4x3(blockB[2].b[1][0][0].mA, mat4x3(-7.0, -7.0, 4.0, 8.0, -7.0, 1.0, -9.0, -2.0, -8.0, 4.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat4x3(blockB[2].b[1][0][1].mA, mat4x3(-9.0, -4.0, 7.0, -5.0, 6.0, 0.0, -1.0, -3.0, -8.0, -4.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x3(blockB[2].b[1][0][2].mA, mat4x3(4.0, 7.0, -5.0, -4.0, -2.0, 2.0, 7.0, -8.0, -7.0, -7.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4x3(blockB[2].b[2][0][0].mA, mat4x3(-7.0, -1.0, -1.0, -3.0, 3.0, -3.0, -9.0, -5.0, -9.0, 2.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat4x3(blockB[2].b[2][0][1].mA, mat4x3(8.0, -2.0, -7.0, -9.0, 4.0, 2.0, 4.0, 5.0, 4.0, 4.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockB[2].b[2][0][2].mA, mat4x3(-4.0, -4.0, 6.0, 3.0, 7.0, 1.0, 2.0, 9.0, 1.0, 5.0, -1.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b[0][0][0].mA = (mat4x3(3.0, 5.0, -4.0, -4.0, -4.0, -6.0, 2.0, 0.0, -7.0, -4.0, 0.0, -4.0));
	blockB[0].b[0][0][1].mA = (mat4x3(-1.0, 6.0, -9.0, 6.0, -8.0, 7.0, 7.0, 7.0, 1.0, 7.0, 7.0, 5.0));
	blockB[0].b[0][0][2].mA = (mat4x3(5.0, -9.0, -1.0, -6.0, 3.0, -9.0, 9.0, 7.0, -1.0, 9.0, 6.0, -7.0));
	blockB[1].b[0][0][0].mA = (mat4x3(0.0, 4.0, 7.0, -5.0, -8.0, 3.0, 5.0, -1.0, 7.0, 7.0, -1.0, -7.0));
	blockB[1].b[0][0][1].mA = (mat4x3(4.0, -4.0, -9.0, -1.0, 9.0, 4.0, -2.0, 4.0, 7.0, 0.0, -3.0, -9.0));
	blockB[1].b[0][0][2].mA = (mat4x3(0.0, 0.0, 6.0, -7.0, -2.0, -8.0, 6.0, 2.0, -8.0, -4.0, 3.0, 1.0));
	blockB[1].b[1][0][0].mA = (mat4x3(-4.0, -4.0, 2.0, 1.0, 8.0, 8.0, -7.0, 3.0, 5.0, -2.0, 6.0, 0.0));
	blockB[1].b[1][0][1].mA = (mat4x3(3.0, 4.0, -8.0, -7.0, 3.0, 6.0, 7.0, -8.0, 1.0, -1.0, 3.0, -7.0));
	blockB[1].b[1][0][2].mA = (mat4x3(6.0, -2.0, 9.0, 8.0, 3.0, -6.0, -1.0, 1.0, -9.0, -3.0, -7.0, -1.0));
	blockB[1].b[2][0][0].mA = (mat4x3(-5.0, -4.0, 9.0, -9.0, 2.0, 4.0, -7.0, 9.0, 1.0, 7.0, 0.0, 9.0));
	blockB[1].b[2][0][1].mA = (mat4x3(-1.0, -2.0, 1.0, 9.0, 1.0, -6.0, 9.0, 3.0, -9.0, 6.0, -3.0, -5.0));
	blockB[1].b[2][0][2].mA = (mat4x3(3.0, -5.0, -3.0, 4.0, 2.0, -1.0, 3.0, 0.0, 3.0, -4.0, 4.0, 3.0));
	blockB[1].b[3][0][0].mA = (mat4x3(-8.0, -4.0, -4.0, -8.0, 7.0, -7.0, -4.0, 0.0, 6.0, -5.0, 4.0, -4.0));
	blockB[1].b[3][0][1].mA = (mat4x3(9.0, -3.0, 0.0, -2.0, 4.0, 6.0, -1.0, -7.0, -4.0, -9.0, -9.0, -7.0));
	blockB[1].b[3][0][2].mA = (mat4x3(-9.0, 8.0, 8.0, 5.0, -5.0, 5.0, 8.0, 0.0, 2.0, -9.0, 9.0, -9.0));
	blockB[2].b[0][0][0].mA = (mat4x3(-6.0, 5.0, 6.0, 7.0, 0.0, 6.0, -6.0, 6.0, 9.0, -1.0, 7.0, -2.0));
	blockB[2].b[0][0][1].mA = (mat4x3(-7.0, 5.0, -1.0, -4.0, -5.0, 3.0, -2.0, 7.0, -9.0, -5.0, 5.0, -6.0));
	blockB[2].b[0][0][2].mA = (mat4x3(4.0, -6.0, 4.0, 0.0, 0.0, 8.0, -8.0, -5.0, -2.0, -4.0, -9.0, -5.0));
	blockB[2].b[1][0][0].mA = (mat4x3(3.0, -4.0, -6.0, -7.0, -1.0, 5.0, -2.0, 8.0, 8.0, 8.0, -7.0, -7.0));
	blockB[2].b[1][0][1].mA = (mat4x3(-6.0, 1.0, 8.0, -9.0, 5.0, -5.0, -9.0, 3.0, -7.0, 0.0, -7.0, -2.0));
	blockB[2].b[1][0][2].mA = (mat4x3(-5.0, 5.0, -3.0, 5.0, 7.0, -7.0, -8.0, -3.0, -4.0, -6.0, 6.0, 8.0));
	blockB[2].b[2][0][0].mA = (mat4x3(7.0, 4.0, 3.0, 8.0, 9.0, 9.0, 0.0, -3.0, 7.0, -6.0, 9.0, 3.0));
	blockB[2].b[2][0][1].mA = (mat4x3(6.0, -7.0, 2.0, 0.0, 4.0, -9.0, 3.0, -7.0, 2.0, -3.0, 6.0, -5.0));
	blockB[2].b[2][0][2].mA = (mat4x3(3.0, -4.0, -4.0, 0.0, -4.0, 5.0, -7.0, 8.0, 7.0, 5.0, -4.0, -2.0));
}
#version 450
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
	highp float a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (6.0);
	blockB[nonuniformEXT(1)].a = (3.0);
}
#version 450
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
	mediump uvec4 a;
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	bvec2 b;
	u8vec2 c[1];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	lowp mat3 d;
	i8vec2 e;
	bool f;
	bvec4 g;
	highp uvec4 h;
};
layout(std140, buffer_reference) buffer BlockE
{
	mediump uvec2 i;
	highp float j;
	u8vec4 k;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a), uvec4(2u, 5u, 1u, 9u)) && allOk;
	allOk = compare_bvec2((blockC.b), bvec2(true, true)) && allOk;
	allOk = compare_mat3(blockD.d, mat3(4.0, -7.0, 3.0, 8.0, 1.0, 9.0, 5.0, -4.0, 1.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.e), ivec2(4294967292, 4294967292)) && allOk;
	allOk = compare_bool((blockD.f), false) && allOk;
	allOk = compare_bvec4((blockD.g), bvec4(false, true, false, false)) && allOk;
	allOk = compare_uvec4((blockD.h), uvec4(5u, 7u, 1u, 6u)) && allOk;
	allOk = compare_uvec2((blockE.i), uvec2(7u, 2u)) && allOk;
	allOk = compare_float((blockE.j), -8.0) && allOk;
	allOk = compare_u8vec4(uvec4(blockE.k), uvec4(6u, 6u, 8u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec4(6u, 8u, 4u, 7u));
	blockC.b = (bvec2(true, false));
	blockC.c[0] = u8vec2(uvec2(7u, 8u));
	blockD.d = (mat3(-1.0, -9.0, 0.0, 0.0, 6.0, -6.0, -5.0, 2.0, 3.0));
	blockD.e = i8vec2(ivec2(0, 4));
	blockD.f = (true);
	blockD.g = (bvec4(true, true, false, false));
	blockE.k = u8vec4(uvec4(1u, 4u, 3u, 5u));
}
#version 450
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
	mediump vec2 a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(-8.0, -2.0)) && allOk;
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
	highp mat3x2 b;
	bvec3 c;
	bvec2 d;
	lowp ivec2 e;
};
layout(std430, buffer_reference) buffer BlockC
{
	lowp int f;
	int8_t g[5];
	u8vec2 h;
	u8vec3 i[3];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.b, mat3x2(-7.0, -9.0, 5.0, -4.0, -9.0, 8.0)) && allOk;
	allOk = compare_bvec3((blockB.c), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec2((blockB.d), bvec2(false, false)) && allOk;
	allOk = compare_int((blockC.f), -7) && allOk;
	allOk = compare_int8_t(int(blockC.g[0]), 3) && allOk;
	allOk = compare_int8_t(int(blockC.g[1]), 5) && allOk;
	allOk = compare_int8_t(int(blockC.g[2]), 2) && allOk;
	allOk = compare_int8_t(int(blockC.g[3]), 4294967287) && allOk;
	allOk = compare_int8_t(int(blockC.g[4]), 0) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.h), uvec2(0u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.e = (ivec2(4, 5));
	blockC.h = u8vec2(uvec2(7u, 2u));
}
#version 450
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
	layout(offset = 0) lowp uint a[1];
	layout(offset = 4) u8vec2 b;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump ivec4 c;
	layout(offset = 16) highp ivec2 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB[0].a[0]), 3u) && allOk;
	allOk = compare_u8vec2(uvec2(blockB[0].b), uvec2(1u, 1u)) && allOk;
	allOk = compare_uint((blockB[1].a[0]), 9u) && allOk;
	allOk = compare_u8vec2(uvec2(blockB[1].b), uvec2(6u, 1u)) && allOk;
	allOk = compare_ivec4((blockC.c), ivec4(-9, -6, 8, -1)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = u8vec2(uvec2(0u, 0u));
	blockB[1].b = u8vec2(uvec2(1u, 7u));
	blockC.d = (ivec2(-2, -4));
}
#version 450
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
	layout(offset = 0) highp uvec3 a;
	layout(offset = 16) mediump ivec2 b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB[nonuniformEXT(0)].a), uvec3(7u, 1u, 2u)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(0)].b), ivec2(-4, 4)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(1)].a), uvec3(4u, 3u, 1u)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(1)].b), ivec2(-3, -3)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(2)].a), uvec3(9u, 6u, 8u)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(2)].b), ivec2(7, 3)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(3)].a), uvec3(8u, 9u, 9u)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(3)].b), ivec2(-7, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (uvec3(7u, 8u, 1u));
	blockB[nonuniformEXT(0)].b = (ivec2(6, 0));
	blockB[nonuniformEXT(1)].a = (uvec3(7u, 3u, 5u));
	blockB[nonuniformEXT(1)].b = (ivec2(4, 7));
	blockB[nonuniformEXT(2)].a = (uvec3(0u, 3u, 5u));
	blockB[nonuniformEXT(2)].b = (ivec2(8, 6));
	blockB[nonuniformEXT(3)].a = (uvec3(6u, 0u, 8u));
	blockB[nonuniformEXT(3)].b = (ivec2(-4, -2));
}
#version 450
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
	mediump ivec2 a;
	lowp vec2 b;
	highp mat4x3 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB[nonuniformEXT(0)].a), ivec2(-5, -2)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(0)].b), vec2(3.0, 7.0)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(1)].a), ivec2(7, -5)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(1)].b), vec2(-4.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = (vec2(-1.0, -3.0));
	blockB[nonuniformEXT(1)].b = (vec2(5.0, 0.0));
}
