#version 450
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
	lowp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -1.0) && allOk;
	allOk = compare_float(var[0][1], -3.0) && allOk;
	allOk = compare_float(var[1][0], 2.0) && allOk;
	allOk = compare_float(var[1][1], 1.0) && allOk;
	allOk = compare_float(var[2][0], -4.0) && allOk;
	allOk = compare_float(var[2][1], 1.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-1.0, -3.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(2.0, 1.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-4.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec2(6.0, -6.0));
	var[1] = (vec2(6.0, 5.0));
	var[2] = (vec2(9.0, -1.0));
}
#version 450
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
	mediump mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var, mat3x4(3.0, -9.0, -9.0, 1.0, -8.0, 0.0, 1.0, -9.0, 4.0, -4.0, -2.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3x4(-5.0, 8.0, 7.0, 9.0, 5.0, -9.0, -3.0, -7.0, 1.0, -6.0, -2.0, -4.0));
}
#version 450
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
	mediump mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var, mat2x4(-3.0, -3.0, 1.0, -9.0, 3.0, -3.0, -9.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2x4(-4.0, -7.0, 5.0, -2.0, 2.0, -1.0, -3.0, -3.0));
}
#version 450
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
	mediump mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], -7.0) && allOk;
	allOk = compare_float(var[0][2], 8.0) && allOk;
	allOk = compare_float(var[0][3], 6.0) && allOk;
	allOk = compare_float(var[1][0], -6.0) && allOk;
	allOk = compare_float(var[1][1], -7.0) && allOk;
	allOk = compare_float(var[1][2], 8.0) && allOk;
	allOk = compare_float(var[1][3], -2.0) && allOk;
	allOk = compare_vec4(var[0], vec4(1.0, -7.0, 8.0, 6.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-6.0, -7.0, 8.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(-6.0, 0.0, 1.0, 2.0));
	var[1] = (vec4(6.0, -4.0, 2.0, -7.0));
}
#version 450
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
	mediump mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -9.0) && allOk;
	allOk = compare_float(var[0][1], 5.0) && allOk;
	allOk = compare_float(var[1][0], 6.0) && allOk;
	allOk = compare_float(var[1][1], -1.0) && allOk;
	allOk = compare_float(var[2][0], 8.0) && allOk;
	allOk = compare_float(var[2][1], 2.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-9.0, 5.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(6.0, -1.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3x2(1.0, 2.0, 7.0, -2.0, 0.0, 7.0));
}
#version 450
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
	mediump mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var, mat3x4(-4.0, 8.0, 9.0, 9.0, 9.0, 9.0, -1.0, -9.0, 9.0, 7.0, 9.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3x4(4.0, 9.0, 2.0, 7.0, -6.0, -9.0, 2.0, -3.0, 1.0, 4.0, 3.0, 2.0));
}
#version 450
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

	var = (mat4x2(-6.0, -9.0, 0.0, 8.0, -9.0, 9.0, 4.0, -9.0));
}
#version 450
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
	allOk = compare_float(var[0][0], -3.0) && allOk;
	allOk = compare_float(var[0][1], 0.0) && allOk;
	allOk = compare_float(var[0][2], -9.0) && allOk;
	allOk = compare_float(var[1][0], -9.0) && allOk;
	allOk = compare_float(var[1][1], -2.0) && allOk;
	allOk = compare_float(var[1][2], 5.0) && allOk;
	allOk = compare_float(var[2][0], 3.0) && allOk;
	allOk = compare_float(var[2][1], -9.0) && allOk;
	allOk = compare_float(var[2][2], -4.0) && allOk;
	allOk = compare_float(var[3][0], -8.0) && allOk;
	allOk = compare_float(var[3][1], -7.0) && allOk;
	allOk = compare_float(var[3][2], 2.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-3.0, 0.0, -9.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-9.0, -2.0, 5.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(3.0, -9.0, -4.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(-8.0, -7.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(-1.0, 0.0, 6.0));
	var[1] = (vec3(-6.0, -6.0, -2.0));
	var[2] = (vec3(5.0, 4.0, -9.0));
	var[3] = (vec3(-4.0, -2.0, 2.0));
}
#version 450
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
	f16vec4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(var), vec4(-8.0, -9.0, 9.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = f16vec4(vec4(9.0, -6.0, 2.0, -8.0));
}
#version 450
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
	lowp uvec2 var;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((padding), 2u) && allOk;
	allOk = compare_uvec2((var), uvec2(3u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (6u);
	var = (uvec2(3u, 6u));
}
#version 450
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
	mediump mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 2.0) && allOk;
	allOk = compare_float(var[0][0], 9.0) && allOk;
	allOk = compare_float(var[0][1], 8.0) && allOk;
	allOk = compare_float(var[1][0], 2.0) && allOk;
	allOk = compare_float(var[1][1], -1.0) && allOk;
	allOk = compare_vec2(var[0], vec2(9.0, 8.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (2.0);
	var = (mat2(3.0, 0.0, -5.0, 4.0));
}
#version 450
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
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_float(var[0][0], 6.0) && allOk;
	allOk = compare_float(var[0][1], 7.0) && allOk;
	allOk = compare_float(var[0][2], 7.0) && allOk;
	allOk = compare_float(var[1][0], -4.0) && allOk;
	allOk = compare_float(var[1][1], -1.0) && allOk;
	allOk = compare_float(var[1][2], 6.0) && allOk;
	allOk = compare_float(var[2][0], -4.0) && allOk;
	allOk = compare_float(var[2][1], -8.0) && allOk;
	allOk = compare_float(var[2][2], -3.0) && allOk;
	allOk = compare_vec3(var[0], vec3(6.0, 7.0, 7.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-4.0, -1.0, 6.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-4.0, -8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-1.0);
	var[0] = (vec3(-2.0, -4.0, 1.0));
	var[1] = (vec3(2.0, 9.0, -2.0));
	var[2] = (vec3(3.0, -1.0, -1.0));
}
#version 450
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
	allOk = compare_mat3(var, mat3(3.0, -5.0, 1.0, 4.0, 5.0, -2.0, 1.0, 6.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-9.0);
	var = (mat3(5.0, 1.0, 3.0, 2.0, -5.0, 9.0, -3.0, -7.0, -1.0));
}
#version 450
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
	lowp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 7.0) && allOk;
	allOk = compare_mat4(var, mat4(-3.0, -9.0, -7.0, 4.0, 5.0, 2.0, -6.0, -8.0, -1.0, -2.0, -5.0, -8.0, -7.0, 0.0, -4.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (3.0);
	var[0] = (vec4(9.0, 2.0, 1.0, -5.0));
	var[1] = (vec4(-7.0, 8.0, -8.0, 7.0));
	var[2] = (vec4(0.0, -3.0, 1.0, -5.0));
	var[3] = (vec4(0.0, 5.0, -8.0, -7.0));
}
#version 450
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
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_mat4x2(var, mat4x2(3.0, -2.0, -4.0, 2.0, -1.0, 0.0, 1.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-8.0);
	var[0] = (vec2(3.0, 2.0));
	var[1] = (vec2(3.0, -1.0));
	var[2] = (vec2(-9.0, -8.0));
	var[3] = (vec2(9.0, -4.0));
}
#version 450
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
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat4x3(var, mat4x3(1.0, 2.0, 1.0, -6.0, -9.0, 7.0, 0.0, -3.0, -2.0, -3.0, -5.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (2.0);
	var = (mat4x3(-6.0, -3.0, 1.0, -1.0, 0.0, 4.0, -4.0, -6.0, 0.0, 2.0, -7.0, 1.0));
}
#version 450
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

	var[0] = (vec4(-5.0, 8.0, 3.0, -4.0));
	var[1] = (vec4(-6.0, -1.0, -3.0, 6.0));
	var[2] = (vec4(5.0, -9.0, 4.0, -1.0));
}
#version 450
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
	highp mat2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0], mat2(-2.0, -7.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(3.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(2.0, 8.0, -9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat2(3.0, 1.0, -4.0, -2.0));
	var[1] = (mat2(1.0, -4.0, -1.0, -3.0));
	var[2] = (mat2(-8.0, 5.0, -6.0, -2.0));
}
#version 450
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

	var[0] = (mat2x4(1.0, 9.0, -7.0, -1.0, 7.0, -5.0, 3.0, -4.0));
	var[1] = (mat2x4(-1.0, -4.0, -6.0, -7.0, 3.0, 5.0, 1.0, -1.0));
	var[2] = (mat2x4(9.0, -9.0, -3.0, -7.0, 3.0, 9.0, -5.0, -9.0));
}
#version 450
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
	highp mat2x4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0], mat2x4(-9.0, -2.0, -2.0, -1.0, -8.0, -3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(-4.0, 1.0, 0.0, -7.0, 3.0, -6.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(5.0, 4.0, -2.0, 4.0, 2.0, -4.0, 5.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec4(-3.0, 4.0, -6.0, 2.0));
	var[0][1] = (vec4(-4.0, -6.0, -3.0, 6.0));
	var[1][0] = (vec4(-5.0, 1.0, 6.0, 1.0));
	var[1][1] = (vec4(1.0, 7.0, 0.0, 9.0));
	var[2][0] = (vec4(8.0, 6.0, -7.0, -4.0));
	var[2][1] = (vec4(-6.0, 5.0, 5.0, -6.0));
}
#version 450
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
	highp vec3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((var[0]), vec3(7.0, 9.0, -6.0)) && allOk;
	allOk = compare_vec3((var[1]), vec3(-9.0, 5.0, -8.0)) && allOk;
	allOk = compare_vec3((var[2]), vec3(1.0, -1.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(5.0, 4.0, 7.0));
	var[1] = (vec3(8.0, -2.0, 7.0));
	var[2] = (vec3(-5.0, -7.0, 9.0));
}
#version 450
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
	i16vec3 var[3];
};

bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(var[0]), ivec3(3, 4, 8)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1]), ivec3(7, -4, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2]), ivec3(6, -5, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = i16vec3(ivec3(6, 1, -2));
	var[1] = i16vec3(ivec3(-3, -1, -4));
	var[2] = i16vec3(ivec3(-2, -2, 2));
}
#version 450
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
	highp mat4x2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 4.0) && allOk;
	allOk = compare_mat4x2(var[0], mat4x2(-5.0, -2.0, 7.0, 3.0, 2.0, -3.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(-1.0, -9.0, 4.0, -9.0, -4.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(-7.0, 4.0, 6.0, 6.0, -6.0, -1.0, -5.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (2.0);
	var[0][0] = (vec2(-4.0, -5.0));
	var[0][1] = (vec2(3.0, 7.0));
	var[0][2] = (vec2(1.0, 8.0));
	var[0][3] = (vec2(-5.0, 7.0));
	var[1][0] = (vec2(-3.0, 1.0));
	var[1][1] = (vec2(-6.0, 9.0));
	var[1][2] = (vec2(-3.0, 1.0));
	var[1][3] = (vec2(-5.0, -8.0));
	var[2][0] = (vec2(4.0, 5.0));
	var[2][1] = (vec2(-9.0, 1.0));
	var[2][2] = (vec2(-5.0, -4.0));
	var[2][3] = (vec2(-2.0, 6.0));
}
#version 450
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
	uint8_t var[3];
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(padding), 7u) && allOk;
	allOk = compare_uint8_t(uint(var[0]), 1u) && allOk;
	allOk = compare_uint8_t(uint(var[1]), 3u) && allOk;
	allOk = compare_uint8_t(uint(var[2]), 1u) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = uint8_t(9u);
	var[0] = uint8_t(5u);
	var[1] = uint8_t(2u);
	var[2] = uint8_t(6u);
}
#version 450
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
	allOk = compare_mat4(var[0], mat4(0.0, 6.0, -9.0, 9.0, -2.0, -7.0, -4.0, -6.0, 1.0, -5.0, 2.0, -7.0, 8.0, 2.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(2.0, 8.0, 1.0, 7.0, -1.0, -6.0, 8.0, -2.0, -2.0, 6.0, -7.0, 7.0, 9.0, -7.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(-9.0, -4.0, -7.0, -3.0, -5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 6.0, 1.0, -8.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4(var[3], mat4(-5.0, 6.0, 6.0, 7.0, -2.0, -4.0, -7.0, 5.0, 9.0, -9.0, -9.0, -7.0, 6.0, 7.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat4(var[4], mat4(-9.0, -5.0, -8.0, -7.0, -2.0, -1.0, -6.0, 6.0, -7.0, 5.0, -9.0, -3.0, 0.0, 4.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4(var[5], mat4(-1.0, -8.0, -9.0, 2.0, 0.0, -8.0, -5.0, -1.0, -9.0, -4.0, 9.0, 0.0, -8.0, 4.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat4(var[6], mat4(8.0, 1.0, -9.0, 5.0, -9.0, 5.0, -9.0, -6.0, 2.0, 0.0, -8.0, -6.0, -7.0, 7.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4(var[7], mat4(-9.0, 9.0, -6.0, -5.0, 7.0, -9.0, 5.0, -1.0, 7.0, -9.0, -6.0, 6.0, -2.0, -9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat4(var[8], mat4(9.0, 3.0, -9.0, 0.0, -6.0, -3.0, -3.0, -7.0, -5.0, 3.0, -6.0, 8.0, -4.0, 8.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4(var[9], mat4(0.0, -3.0, -3.0, 1.0, -4.0, 9.0, 7.0, -1.0, -7.0, 0.0, 5.0, -9.0, 7.0, 3.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat4(var[10], mat4(8.0, 7.0, -4.0, 9.0, -4.0, -7.0, 2.0, -7.0, 1.0, 0.0, 2.0, 2.0, -5.0, 2.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4(var[11], mat4(6.0, -1.0, 8.0, -1.0, 3.0, 8.0, -1.0, 9.0, 0.0, -8.0, 6.0, -8.0, 9.0, -3.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4(var[12], mat4(4.0, 9.0, -7.0, -4.0, 6.0, 6.0, 9.0, 9.0, 7.0, 3.0, 6.0, 1.0, 5.0, 1.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4(var[13], mat4(6.0, 7.0, 4.0, 7.0, 0.0, 3.0, -7.0, -8.0, -9.0, 1.0, 4.0, 2.0, 0.0, -6.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4(var[14], mat4(-7.0, 7.0, -7.0, 6.0, 6.0, -7.0, 3.0, -2.0, -8.0, 6.0, 5.0, 8.0, 5.0, 1.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4(var[15], mat4(1.0, -3.0, -5.0, -3.0, 4.0, 2.0, -1.0, 8.0, -6.0, 2.0, 6.0, 6.0, 5.0, 4.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat4(var[16], mat4(6.0, -2.0, -6.0, 6.0, -1.0, 9.0, 7.0, 9.0, 5.0, -5.0, -5.0, 8.0, -5.0, 7.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4(var[17], mat4(-8.0, -6.0, 5.0, -5.0, 7.0, -6.0, -4.0, 7.0, 5.0, -4.0, -1.0, 2.0, 6.0, 9.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4(var[18], mat4(-1.0, 4.0, -8.0, -2.0, 4.0, 0.0, -4.0, -1.0, 4.0, -5.0, -8.0, 0.0, 8.0, 4.0, 5.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4(-6.0, 6.0, -9.0, 9.0, 5.0, -1.0, 2.0, -9.0, 1.0, -5.0, -2.0, -8.0, 8.0, 8.0, 1.0, -8.0));
	var[1] = (mat4(-6.0, 3.0, -2.0, 2.0, -2.0, 6.0, -2.0, -6.0, 9.0, 1.0, 3.0, -1.0, -2.0, 1.0, 7.0, 0.0));
	var[2] = (mat4(-7.0, -7.0, 8.0, 1.0, -4.0, 7.0, 8.0, -3.0, 3.0, -4.0, 7.0, -3.0, -2.0, 9.0, -2.0, 6.0));
	var[3] = (mat4(6.0, -6.0, 8.0, 6.0, 6.0, 3.0, 3.0, 2.0, -4.0, 4.0, 2.0, -3.0, -7.0, -8.0, -6.0, 1.0));
	var[4] = (mat4(-4.0, -6.0, -2.0, -5.0, -2.0, -9.0, 0.0, 3.0, 9.0, 2.0, -5.0, 5.0, 1.0, 9.0, -1.0, 0.0));
	var[5] = (mat4(-4.0, 8.0, 6.0, -2.0, 1.0, -1.0, -7.0, -1.0, -1.0, 3.0, -8.0, 4.0, 8.0, 4.0, -3.0, -8.0));
	var[6] = (mat4(3.0, -8.0, 9.0, 8.0, 0.0, 3.0, 7.0, 6.0, 4.0, 6.0, 8.0, -9.0, 5.0, 9.0, -4.0, -4.0));
	var[7] = (mat4(1.0, 0.0, -1.0, 1.0, 7.0, 1.0, -7.0, -6.0, -9.0, 6.0, -5.0, -8.0, 1.0, -3.0, 3.0, 4.0));
	var[8] = (mat4(-4.0, 2.0, 6.0, -8.0, 2.0, -4.0, 9.0, -7.0, -6.0, 4.0, 4.0, -2.0, -6.0, 1.0, 2.0, -7.0));
	var[9] = (mat4(-2.0, 7.0, 4.0, 1.0, 4.0, -4.0, 2.0, 4.0, 2.0, -1.0, -8.0, 0.0, -9.0, 2.0, 8.0, 9.0));
	var[10] = (mat4(-1.0, -7.0, -2.0, -1.0, 7.0, 1.0, -8.0, -8.0, -3.0, -2.0, 5.0, 7.0, -2.0, -8.0, 8.0, -6.0));
	var[11] = (mat4(4.0, 3.0, -2.0, -4.0, -1.0, -3.0, -8.0, 3.0, -3.0, 8.0, 1.0, -4.0, -9.0, -7.0, 3.0, 6.0));
	var[12] = (mat4(-8.0, 4.0, 7.0, 8.0, 2.0, -8.0, -3.0, 3.0, -4.0, 1.0, 2.0, 3.0, -1.0, 1.0, 8.0, -3.0));
	var[13] = (mat4(0.0, 5.0, -3.0, -5.0, 2.0, 8.0, 7.0, 5.0, 3.0, 8.0, 4.0, -1.0, 5.0, -1.0, -3.0, 5.0));
	var[14] = (mat4(-7.0, 1.0, 5.0, -4.0, 9.0, -1.0, 0.0, 8.0, -3.0, 4.0, 5.0, -5.0, 1.0, -8.0, -1.0, 3.0));
	var[15] = (mat4(9.0, -4.0, -2.0, 7.0, 1.0, -8.0, 4.0, 2.0, 8.0, 3.0, -2.0, -6.0, 2.0, -7.0, 1.0, 0.0));
	var[16] = (mat4(5.0, 9.0, 8.0, 8.0, -3.0, 9.0, 9.0, 8.0, 9.0, 7.0, 5.0, 1.0, -6.0, -4.0, -4.0, 4.0));
	var[17] = (mat4(1.0, 4.0, 7.0, 6.0, -1.0, 2.0, 2.0, 4.0, -1.0, -9.0, 4.0, 4.0, 1.0, -7.0, 7.0, -7.0));
	var[18] = (mat4(-6.0, 6.0, 8.0, 4.0, 1.0, 3.0, 4.0, -7.0, -9.0, -3.0, 3.0, -1.0, 8.0, 6.0, 3.0, 3.0));
}
#version 450
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

layout(std140, column_major, binding = 1) buffer Block
{
	highp mat4x3 var[];
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
	allOk = compare_mat4x3(var[3], mat4x3(-9.0, 3.0, 0.0, 1.0, -4.0, 8.0, 3.0, -7.0, 8.0, -3.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[4], mat4x3(9.0, -8.0, -2.0, 4.0, -2.0, -5.0, -8.0, -4.0, -1.0, -9.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[5], mat4x3(-3.0, -2.0, 9.0, -5.0, -8.0, 1.0, -7.0, 6.0, -4.0, -6.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[6], mat4x3(1.0, -2.0, 6.0, 7.0, -5.0, 9.0, -9.0, 6.0, -8.0, -3.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[7], mat4x3(5.0, -9.0, 6.0, 3.0, 3.0, 0.0, 0.0, -6.0, 9.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[8], mat4x3(-1.0, -2.0, 2.0, -7.0, -8.0, -5.0, 3.0, -4.0, 5.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[9], mat4x3(5.0, 4.0, 1.0, -4.0, -7.0, 2.0, 0.0, 9.0, 7.0, -2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[10], mat4x3(-1.0, 6.0, -7.0, -6.0, 3.0, -7.0, -6.0, 4.0, 7.0, 5.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[11], mat4x3(1.0, 6.0, 2.0, 0.0, -4.0, 0.0, 8.0, -8.0, 7.0, 6.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[12], mat4x3(3.0, -6.0, 9.0, 8.0, -1.0, 8.0, -4.0, 2.0, 6.0, -9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[13], mat4x3(5.0, -1.0, 4.0, 2.0, -4.0, -2.0, -1.0, -4.0, 5.0, 9.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[14], mat4x3(2.0, -6.0, -1.0, 6.0, 9.0, -3.0, -8.0, 7.0, -5.0, 0.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[15], mat4x3(7.0, -5.0, -4.0, -3.0, 5.0, 8.0, 9.0, -5.0, -5.0, -3.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[16], mat4x3(9.0, -2.0, 0.0, 1.0, -8.0, -4.0, -9.0, 3.0, -1.0, 1.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[17], mat4x3(-5.0, 1.0, 6.0, 5.0, 6.0, -1.0, -1.0, 1.0, -6.0, -5.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[18], mat4x3(0.0, 1.0, 5.0, -8.0, -8.0, 0.0, -9.0, 5.0, 2.0, -6.0, -5.0, -7.0)) && allOk;
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
	var[3][0] = (vec3(-9.0, -2.0, -2.0));
	var[3][1] = (vec3(7.0, 9.0, -4.0));
	var[3][2] = (vec3(3.0, 1.0, 0.0));
	var[3][3] = (vec3(-9.0, -2.0, -7.0));
	var[4][0] = (vec3(-5.0, -6.0, 5.0));
	var[4][1] = (vec3(-2.0, -7.0, 5.0));
	var[4][2] = (vec3(-2.0, -6.0, 4.0));
	var[4][3] = (vec3(9.0, 5.0, -9.0));
	var[5][0] = (vec3(-3.0, 3.0, 7.0));
	var[5][1] = (vec3(3.0, -4.0, -8.0));
	var[5][2] = (vec3(-2.0, 2.0, -1.0));
	var[5][3] = (vec3(1.0, -9.0, 9.0));
	var[6][0] = (vec3(-7.0, -7.0, -7.0));
	var[6][1] = (vec3(6.0, -9.0, 3.0));
	var[6][2] = (vec3(-5.0, 2.0, 4.0));
	var[6][3] = (vec3(-2.0, -4.0, -6.0));
	var[7][0] = (vec3(-1.0, 5.0, 5.0));
	var[7][1] = (vec3(-9.0, -3.0, -9.0));
	var[7][2] = (vec3(3.0, 2.0, 0.0));
	var[7][3] = (vec3(0.0, -9.0, 7.0));
	var[8][0] = (vec3(5.0, -5.0, -2.0));
	var[8][1] = (vec3(6.0, 5.0, -4.0));
	var[8][2] = (vec3(-2.0, 9.0, -3.0));
	var[8][3] = (vec3(2.0, 5.0, -4.0));
	var[9][0] = (vec3(6.0, 4.0, 7.0));
	var[9][1] = (vec3(1.0, -4.0, -6.0));
	var[9][2] = (vec3(4.0, -6.0, -5.0));
	var[9][3] = (vec3(5.0, 6.0, -1.0));
	var[10][0] = (vec3(6.0, 3.0, -9.0));
	var[10][1] = (vec3(-7.0, 3.0, -4.0));
	var[10][2] = (vec3(1.0, 2.0, 6.0));
	var[10][3] = (vec3(-2.0, 3.0, 7.0));
	var[11][0] = (vec3(-5.0, 8.0, -9.0));
	var[11][1] = (vec3(-4.0, -1.0, -9.0));
	var[11][2] = (vec3(5.0, 5.0, 6.0));
	var[11][3] = (vec3(-8.0, 1.0, -7.0));
	var[12][0] = (vec3(-5.0, -6.0, -3.0));
	var[12][1] = (vec3(-2.0, 5.0, 8.0));
	var[12][2] = (vec3(2.0, -9.0, 7.0));
	var[12][3] = (vec3(7.0, -3.0, 4.0));
	var[13][0] = (vec3(9.0, 4.0, 1.0));
	var[13][1] = (vec3(5.0, -9.0, 2.0));
	var[13][2] = (vec3(-7.0, -3.0, -9.0));
	var[13][3] = (vec3(9.0, -6.0, 3.0));
	var[14][0] = (vec3(-9.0, -4.0, 0.0));
	var[14][1] = (vec3(5.0, 8.0, 9.0));
	var[14][2] = (vec3(-7.0, -9.0, -5.0));
	var[14][3] = (vec3(0.0, -1.0, -6.0));
	var[15][0] = (vec3(-9.0, -9.0, 9.0));
	var[15][1] = (vec3(9.0, -1.0, 8.0));
	var[15][2] = (vec3(8.0, -8.0, 4.0));
	var[15][3] = (vec3(9.0, -8.0, 8.0));
	var[16][0] = (vec3(4.0, 6.0, 1.0));
	var[16][1] = (vec3(-9.0, 7.0, 3.0));
	var[16][2] = (vec3(-4.0, -3.0, 8.0));
	var[16][3] = (vec3(-9.0, -9.0, 2.0));
	var[17][0] = (vec3(0.0, -2.0, 5.0));
	var[17][1] = (vec3(8.0, 4.0, -4.0));
	var[17][2] = (vec3(5.0, 4.0, -5.0));
	var[17][3] = (vec3(0.0, -3.0, 9.0));
	var[18][0] = (vec3(-4.0, -7.0, 3.0));
	var[18][1] = (vec3(6.0, 4.0, 1.0));
	var[18][2] = (vec3(-3.0, 3.0, 8.0));
	var[18][3] = (vec3(-6.0, 5.0, -6.0));
}
#version 450
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
	int16_t var[];
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(var[0]), -5) && allOk;
	allOk = compare_int16_t(int(var[1]), 1) && allOk;
	allOk = compare_int16_t(int(var[2]), 8) && allOk;
	allOk = compare_int16_t(int(var[3]), -2) && allOk;
	allOk = compare_int16_t(int(var[4]), 9) && allOk;
	allOk = compare_int16_t(int(var[5]), -5) && allOk;
	allOk = compare_int16_t(int(var[6]), -8) && allOk;
	allOk = compare_int16_t(int(var[7]), 6) && allOk;
	allOk = compare_int16_t(int(var[8]), 3) && allOk;
	allOk = compare_int16_t(int(var[9]), -8) && allOk;
	allOk = compare_int16_t(int(var[10]), 6) && allOk;
	allOk = compare_int16_t(int(var[11]), -7) && allOk;
	allOk = compare_int16_t(int(var[12]), 9) && allOk;
	allOk = compare_int16_t(int(var[13]), 5) && allOk;
	allOk = compare_int16_t(int(var[14]), 9) && allOk;
	allOk = compare_int16_t(int(var[15]), -3) && allOk;
	allOk = compare_int16_t(int(var[16]), -1) && allOk;
	allOk = compare_int16_t(int(var[17]), -2) && allOk;
	allOk = compare_int16_t(int(var[18]), 1) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = int16_t(6);
	var[1] = int16_t(8);
	var[2] = int16_t(-2);
	var[3] = int16_t(-4);
	var[4] = int16_t(-3);
	var[5] = int16_t(9);
	var[6] = int16_t(-5);
	var[7] = int16_t(-8);
	var[8] = int16_t(-3);
	var[9] = int16_t(2);
	var[10] = int16_t(-1);
	var[11] = int16_t(4);
	var[12] = int16_t(3);
	var[13] = int16_t(9);
	var[14] = int16_t(6);
	var[15] = int16_t(2);
	var[16] = int16_t(3);
	var[17] = int16_t(7);
	var[18] = int16_t(7);
}
#version 450
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
	bool var[4][3];
};

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((var[0][0]), false) && allOk;
	allOk = compare_bool((var[0][1]), true) && allOk;
	allOk = compare_bool((var[0][2]), true) && allOk;
	allOk = compare_bool((var[1][0]), false) && allOk;
	allOk = compare_bool((var[1][1]), false) && allOk;
	allOk = compare_bool((var[1][2]), true) && allOk;
	allOk = compare_bool((var[2][0]), true) && allOk;
	allOk = compare_bool((var[2][1]), false) && allOk;
	allOk = compare_bool((var[2][2]), false) && allOk;
	allOk = compare_bool((var[3][0]), false) && allOk;
	allOk = compare_bool((var[3][1]), false) && allOk;
	allOk = compare_bool((var[3][2]), true) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (false);
	var[0][1] = (false);
	var[0][2] = (true);
	var[1][0] = (true);
	var[1][1] = (false);
	var[1][2] = (false);
	var[2][0] = (true);
	var[2][1] = (true);
	var[2][2] = (true);
	var[3][0] = (true);
	var[3][1] = (false);
	var[3][2] = (false);
}
#version 450
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
	highp mat2x3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0][0], mat2x3(-3.0, 6.0, -6.0, -6.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[0][1], mat2x3(8.0, 3.0, 1.0, 4.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[0][2], mat2x3(-7.0, -5.0, -8.0, -7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[1][0], mat2x3(3.0, 6.0, -5.0, 3.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[1][1], mat2x3(9.0, 2.0, 6.0, 8.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[1][2], mat2x3(-7.0, -2.0, -4.0, -2.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[2][0], mat2x3(6.0, 8.0, -4.0, -5.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[2][1], mat2x3(6.0, 6.0, -9.0, -2.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[2][2], mat2x3(5.0, -3.0, 6.0, 3.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[3][0], mat2x3(-9.0, -2.0, -3.0, -1.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[3][1], mat2x3(0.0, 2.0, -1.0, -4.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[3][2], mat2x3(-9.0, -7.0, 7.0, 0.0, 7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat2x3(-1.0, -2.0, -5.0, 0.0, 7.0, -2.0));
	var[0][1] = (mat2x3(0.0, 9.0, 9.0, 8.0, -6.0, 3.0));
	var[0][2] = (mat2x3(-9.0, 0.0, 1.0, 1.0, 7.0, -8.0));
	var[1][0] = (mat2x3(7.0, -4.0, 4.0, -5.0, -1.0, 0.0));
	var[1][1] = (mat2x3(2.0, -5.0, 6.0, 7.0, -2.0, 4.0));
	var[1][2] = (mat2x3(-3.0, 7.0, 6.0, -3.0, -2.0, -6.0));
	var[2][0] = (mat2x3(7.0, -3.0, 2.0, 8.0, -1.0, 2.0));
	var[2][1] = (mat2x3(2.0, -9.0, 3.0, 1.0, -7.0, -7.0));
	var[2][2] = (mat2x3(3.0, -3.0, -5.0, 4.0, -6.0, 8.0));
	var[3][0] = (mat2x3(7.0, -9.0, 2.0, -8.0, 9.0, 9.0));
	var[3][1] = (mat2x3(3.0, 5.0, 8.0, 5.0, -7.0, 6.0));
	var[3][2] = (mat2x3(3.0, 6.0, 6.0, 1.0, 2.0, -7.0));
}
#version 450
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
	i16vec3 var[4][3];
};

bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(var[0][0]), ivec3(3, 4, 8)) && allOk;
	allOk = compare_i16vec3(ivec3(var[0][1]), ivec3(7, -4, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(var[0][2]), ivec3(6, -5, -9)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][0]), ivec3(9, 4, 2)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][1]), ivec3(-6, 6, -2)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][2]), ivec3(2, -1, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][0]), ivec3(-1, -4, -8)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][1]), ivec3(2, -8, 6)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][2]), ivec3(0, -3, 3)) && allOk;
	allOk = compare_i16vec3(ivec3(var[3][0]), ivec3(-6, 0, -1)) && allOk;
	allOk = compare_i16vec3(ivec3(var[3][1]), ivec3(5, 1, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(var[3][2]), ivec3(8, 5, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = i16vec3(ivec3(6, 1, -2));
	var[0][1] = i16vec3(ivec3(-3, -1, -4));
	var[0][2] = i16vec3(ivec3(-2, -2, 2));
	var[1][0] = i16vec3(ivec3(0, -6, -2));
	var[1][1] = i16vec3(ivec3(0, -9, 2));
	var[1][2] = i16vec3(ivec3(-8, 6, 2));
	var[2][0] = i16vec3(ivec3(-5, -4, -8));
	var[2][1] = i16vec3(ivec3(0, 9, 6));
	var[2][2] = i16vec3(ivec3(5, -3, 4));
	var[3][0] = i16vec3(ivec3(-3, 9, 0));
	var[3][1] = i16vec3(ivec3(1, -5, 8));
	var[3][2] = i16vec3(ivec3(-5, 0, 7));
}
#version 450
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
	highp mat3x4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0][0], mat3x4(-3.0, -9.0, 3.0, -6.0, -7.0, 8.0, -8.0, -5.0, 9.0, -8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[0][1], mat3x4(8.0, -4.0, 9.0, 7.0, -8.0, 9.0, -1.0, 0.0, 9.0, 7.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[0][2], mat3x4(-3.0, -6.0, -7.0, 8.0, 1.0, 5.0, 1.0, -1.0, 8.0, -9.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[1][0], mat3x4(-4.0, -4.0, 2.0, -2.0, 1.0, 3.0, -5.0, -4.0, 9.0, 6.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[1][1], mat3x4(9.0, 3.0, 9.0, -8.0, 9.0, -4.0, -4.0, 7.0, -1.0, -7.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1][2], mat3x4(-5.0, -4.0, -9.0, 1.0, 6.0, 6.0, 2.0, 1.0, 0.0, 1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[2][0], mat3x4(6.0, 0.0, -7.0, 9.0, -8.0, 6.0, 0.0, 9.0, -1.0, -9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[2][1], mat3x4(1.0, 9.0, -9.0, -8.0, 0.0, 2.0, 9.0, 6.0, 3.0, 9.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[2][2], mat3x4(-7.0, -2.0, -1.0, -9.0, -9.0, 6.0, -6.0, -9.0, -4.0, -4.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[3][0], mat3x4(9.0, 1.0, -6.0, 9.0, -3.0, -9.0, -2.0, -9.0, -7.0, -4.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[3][1], mat3x4(-3.0, 5.0, 0.0, -7.0, 9.0, -8.0, -9.0, -4.0, -6.0, 7.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[3][2], mat3x4(4.0, 4.0, 1.0, -1.0, 9.0, -6.0, -6.0, -4.0, 4.0, 8.0, 8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec4(-6.0, -4.0, 2.0, -3.0));
	var[0][0][1] = (vec4(-2.0, 4.0, -5.0, 8.0));
	var[0][0][2] = (vec4(-4.0, 6.0, -9.0, -9.0));
	var[0][1][0] = (vec4(0.0, 6.0, 0.0, 6.0));
	var[0][1][1] = (vec4(5.0, 2.0, 6.0, 6.0));
	var[0][1][2] = (vec4(-7.0, -6.0, -8.0, 0.0));
	var[0][2][0] = (vec4(3.0, -3.0, 6.0, -2.0));
	var[0][2][1] = (vec4(-8.0, -5.0, -5.0, 1.0));
	var[0][2][2] = (vec4(7.0, -8.0, -3.0, -2.0));
	var[1][0][0] = (vec4(6.0, 4.0, -5.0, 8.0));
	var[1][0][1] = (vec4(-5.0, -8.0, -9.0, -8.0));
	var[1][0][2] = (vec4(9.0, 0.0, 3.0, -4.0));
	var[1][1][0] = (vec4(0.0, -6.0, 5.0, 1.0));
	var[1][1][1] = (vec4(9.0, -8.0, -1.0, -7.0));
	var[1][1][2] = (vec4(1.0, 2.0, 0.0, -9.0));
	var[1][2][0] = (vec4(2.0, 0.0, 5.0, -4.0));
	var[1][2][1] = (vec4(-7.0, 0.0, 3.0, 4.0));
	var[1][2][2] = (vec4(4.0, 5.0, 2.0, -3.0));
	var[2][0][0] = (vec4(0.0, -7.0, 3.0, -8.0));
	var[2][0][1] = (vec4(3.0, -2.0, -3.0, 1.0));
	var[2][0][2] = (vec4(-5.0, -9.0, -7.0, -7.0));
	var[2][1][0] = (vec4(-2.0, -9.0, -7.0, -8.0));
	var[2][1][1] = (vec4(7.0, -6.0, -4.0, 6.0));
	var[2][1][2] = (vec4(-5.0, -4.0, -8.0, -4.0));
	var[2][2][0] = (vec4(9.0, -2.0, 7.0, -9.0));
	var[2][2][1] = (vec4(-6.0, -4.0, 5.0, -5.0));
	var[2][2][2] = (vec4(-5.0, 7.0, 6.0, 6.0));
	var[3][0][0] = (vec4(0.0, 9.0, -3.0, -9.0));
	var[3][0][1] = (vec4(-7.0, 6.0, -7.0, -1.0));
	var[3][0][2] = (vec4(-6.0, -6.0, 2.0, 8.0));
	var[3][1][0] = (vec4(-6.0, 6.0, -8.0, -3.0));
	var[3][1][1] = (vec4(2.0, 0.0, 0.0, -2.0));
	var[3][1][2] = (vec4(-9.0, -3.0, 2.0, 2.0));
	var[3][2][0] = (vec4(-7.0, -4.0, 9.0, 7.0));
	var[3][2][1] = (vec4(-3.0, 1.0, -7.0, 9.0));
	var[3][2][2] = (vec4(-9.0, -8.0, 0.0, 8.0));
}
#version 450
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
	highp vec4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_vec4((var[0][0]), vec4(4.0, -4.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec4((var[0][1]), vec4(4.0, 8.0, 7.0, 2.0)) && allOk;
	allOk = compare_vec4((var[0][2]), vec4(-4.0, 3.0, -8.0, -3.0)) && allOk;
	allOk = compare_vec4((var[1][0]), vec4(-3.0, -6.0, -4.0, -1.0)) && allOk;
	allOk = compare_vec4((var[1][1]), vec4(0.0, -8.0, -8.0, 7.0)) && allOk;
	allOk = compare_vec4((var[1][2]), vec4(1.0, 8.0, -8.0, 6.0)) && allOk;
	allOk = compare_vec4((var[2][0]), vec4(9.0, -5.0, -1.0, 8.0)) && allOk;
	allOk = compare_vec4((var[2][1]), vec4(-5.0, -7.0, 0.0, -7.0)) && allOk;
	allOk = compare_vec4((var[2][2]), vec4(2.0, -6.0, 6.0, -1.0)) && allOk;
	allOk = compare_vec4((var[3][0]), vec4(6.0, -6.0, 8.0, 8.0)) && allOk;
	allOk = compare_vec4((var[3][1]), vec4(1.0, 8.0, 2.0, 3.0)) && allOk;
	allOk = compare_vec4((var[3][2]), vec4(-4.0, 2.0, 1.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-5.0);
	var[0][0] = (vec4(8.0, 3.0, -4.0, -6.0));
	var[0][1] = (vec4(-1.0, -3.0, 6.0, 5.0));
	var[0][2] = (vec4(-9.0, 4.0, -1.0, -7.0));
	var[1][0] = (vec4(-6.0, -2.0, -8.0, 8.0));
	var[1][1] = (vec4(7.0, 5.0, 1.0, -6.0));
	var[1][2] = (vec4(-5.0, -8.0, 8.0, 0.0));
	var[2][0] = (vec4(8.0, 4.0, -4.0, -8.0));
	var[2][1] = (vec4(-3.0, 9.0, -7.0, -9.0));
	var[2][2] = (vec4(2.0, -6.0, 6.0, 6.0));
	var[3][0] = (vec4(2.0, -3.0, 0.0, -9.0));
	var[3][1] = (vec4(8.0, -8.0, 0.0, 2.0));
	var[3][2] = (vec4(6.0, 6.0, 1.0, 1.0));
}
#version 450
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
	highp ivec4 var[4][2][3];
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((var[0][0][0]), ivec4(-7, 9, -5, 6)) && allOk;
	allOk = compare_ivec4((var[0][0][1]), ivec4(3, 4, 2, -3)) && allOk;
	allOk = compare_ivec4((var[0][0][2]), ivec4(-3, -3, -5, -5)) && allOk;
	allOk = compare_ivec4((var[0][1][0]), ivec4(-7, 2, 6, -5)) && allOk;
	allOk = compare_ivec4((var[0][1][1]), ivec4(1, 5, 7, 9)) && allOk;
	allOk = compare_ivec4((var[0][1][2]), ivec4(-6, 4, 0, 9)) && allOk;
	allOk = compare_ivec4((var[1][0][0]), ivec4(3, -5, -9, -7)) && allOk;
	allOk = compare_ivec4((var[1][0][1]), ivec4(1, 5, 9, 7)) && allOk;
	allOk = compare_ivec4((var[1][0][2]), ivec4(-4, -1, 8, -1)) && allOk;
	allOk = compare_ivec4((var[1][1][0]), ivec4(-3, 6, -6, -6)) && allOk;
	allOk = compare_ivec4((var[1][1][1]), ivec4(1, -6, -3, 5)) && allOk;
	allOk = compare_ivec4((var[1][1][2]), ivec4(9, -7, -1, -9)) && allOk;
	allOk = compare_ivec4((var[2][0][0]), ivec4(4, 3, 6, -6)) && allOk;
	allOk = compare_ivec4((var[2][0][1]), ivec4(1, -3, 0, 0)) && allOk;
	allOk = compare_ivec4((var[2][0][2]), ivec4(1, -6, 0, -7)) && allOk;
	allOk = compare_ivec4((var[2][1][0]), ivec4(8, -5, 1, -2)) && allOk;
	allOk = compare_ivec4((var[2][1][1]), ivec4(2, 9, -9, -7)) && allOk;
	allOk = compare_ivec4((var[2][1][2]), ivec4(-5, -2, 6, 4)) && allOk;
	allOk = compare_ivec4((var[3][0][0]), ivec4(6, -4, -4, 0)) && allOk;
	allOk = compare_ivec4((var[3][0][1]), ivec4(8, -3, 3, 3)) && allOk;
	allOk = compare_ivec4((var[3][0][2]), ivec4(-3, 1, 3, 1)) && allOk;
	allOk = compare_ivec4((var[3][1][0]), ivec4(-1, 1, 1, 5)) && allOk;
	allOk = compare_ivec4((var[3][1][1]), ivec4(1, -9, 2, -2)) && allOk;
	allOk = compare_ivec4((var[3][1][2]), ivec4(-5, -8, 8, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (ivec4(5, -9, 5, -6));
	var[0][0][1] = (ivec4(-2, -4, 1, -9));
	var[0][0][2] = (ivec4(7, 3, 6, 8));
	var[0][1][0] = (ivec4(7, 1, -4, 4));
	var[0][1][1] = (ivec4(-2, 5, -8, 0));
	var[0][1][2] = (ivec4(8, -9, -8, -3));
	var[1][0][0] = (ivec4(6, -4, 6, -7));
	var[1][0][1] = (ivec4(9, -8, -9, 0));
	var[1][0][2] = (ivec4(5, -7, 2, 9));
	var[1][1][0] = (ivec4(3, -9, -5, -4));
	var[1][1][1] = (ivec4(-8, 8, -3, 2));
	var[1][1][2] = (ivec4(-2, -6, 4, -5));
	var[2][0][0] = (ivec4(6, 5, 4, 0));
	var[2][0][1] = (ivec4(5, 9, 0, 0));
	var[2][0][2] = (ivec4(-6, 4, 4, 2));
	var[2][1][0] = (ivec4(6, 8, -7, -2));
	var[2][1][1] = (ivec4(9, -9, -5, -6));
	var[2][1][2] = (ivec4(-5, -7, -9, -3));
	var[3][0][0] = (ivec4(9, 7, 5, 5));
	var[3][0][1] = (ivec4(3, -3, -9, -8));
	var[3][0][2] = (ivec4(-6, 3, 2, 0));
	var[3][1][0] = (ivec4(-2, -1, -9, 9));
	var[3][1][1] = (ivec4(-5, 1, 9, -8));
	var[3][1][2] = (ivec4(0, 5, -8, -8));
}
#version 450
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
	highp mat2x4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0][0][0], mat2x4(-9.0, -2.0, -2.0, -1.0, -8.0, -3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(-4.0, 1.0, 0.0, -7.0, 3.0, -6.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][2], mat2x4(5.0, 4.0, -2.0, 4.0, 2.0, -4.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(-4.0, -8.0, 6.0, -4.0, 4.0, 5.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(6.0, -2.0, 3.0, -8.0, 9.0, 7.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][2], mat2x4(-1.0, -8.0, 3.0, -4.0, -5.0, -8.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(2.0, -7.0, -6.0, -5.0, 6.0, 3.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(0.0, -7.0, 0.0, 0.0, 6.0, -7.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][2], mat2x4(-4.0, -2.0, -3.0, 7.0, -4.0, 6.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(1.0, 3.0, -7.0, 0.0, 9.0, 7.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(5.0, 2.0, -3.0, -6.0, 1.0, 7.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][2], mat2x4(2.0, 8.0, -1.0, -2.0, 7.0, 2.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(-3.0, 2.0, -6.0, -2.0, -7.0, -5.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(-8.0, 4.0, -2.0, 8.0, 5.0, -2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][2], mat2x4(-1.0, -5.0, -5.0, 6.0, -9.0, 1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(-6.0, -3.0, 8.0, -9.0, 1.0, 9.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(-8.0, 7.0, -3.0, -1.0, 4.0, -4.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][2], mat2x4(3.0, 4.0, -2.0, -2.0, -6.0, -4.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][0], mat2x4(3.0, 8.0, -1.0, 5.0, -1.0, 8.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][1], mat2x4(3.0, -9.0, -2.0, 3.0, -1.0, -9.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][2], mat2x4(-2.0, 8.0, -1.0, 6.0, -7.0, 7.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][0], mat2x4(8.0, -1.0, 6.0, -1.0, 5.0, -5.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][1], mat2x4(-1.0, 7.0, 4.0, 1.0, 8.0, -1.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][2], mat2x4(7.0, 3.0, -4.0, 5.0, 4.0, 8.0, -5.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(-3.0, 4.0, -6.0, 2.0));
	var[0][0][0][1] = (vec4(-4.0, -6.0, -3.0, 6.0));
	var[0][0][1][0] = (vec4(-5.0, 1.0, 6.0, 1.0));
	var[0][0][1][1] = (vec4(1.0, 7.0, 0.0, 9.0));
	var[0][0][2][0] = (vec4(8.0, 6.0, -7.0, -4.0));
	var[0][0][2][1] = (vec4(-6.0, 5.0, 5.0, -6.0));
	var[0][1][0][0] = (vec4(5.0, 0.0, -1.0, 5.0));
	var[0][1][0][1] = (vec4(7.0, 6.0, 4.0, 7.0));
	var[0][1][1][0] = (vec4(-6.0, 5.0, -9.0, 9.0));
	var[0][1][1][1] = (vec4(-5.0, -5.0, -6.0, 8.0));
	var[0][1][2][0] = (vec4(2.0, 4.0, 8.0, 5.0));
	var[0][1][2][1] = (vec4(3.0, 5.0, 5.0, 8.0));
	var[1][0][0][0] = (vec4(5.0, -4.0, 0.0, 2.0));
	var[1][0][0][1] = (vec4(-8.0, 6.0, 9.0, 4.0));
	var[1][0][1][0] = (vec4(-8.0, 0.0, -2.0, -3.0));
	var[1][0][1][1] = (vec4(-7.0, 4.0, 2.0, -2.0));
	var[1][0][2][0] = (vec4(2.0, 3.0, 8.0, -9.0));
	var[1][0][2][1] = (vec4(-7.0, 3.0, -4.0, -7.0));
	var[1][1][0][0] = (vec4(2.0, 7.0, -5.0, -9.0));
	var[1][1][0][1] = (vec4(-3.0, 0.0, 2.0, -7.0));
	var[1][1][1][0] = (vec4(4.0, -2.0, 4.0, 5.0));
	var[1][1][1][1] = (vec4(-6.0, 1.0, -4.0, -8.0));
	var[1][1][2][0] = (vec4(5.0, 2.0, 2.0, 4.0));
	var[1][1][2][1] = (vec4(2.0, 1.0, -2.0, 2.0));
	var[2][0][0][0] = (vec4(-3.0, -1.0, -6.0, -2.0));
	var[2][0][0][1] = (vec4(-8.0, 6.0, 0.0, 4.0));
	var[2][0][1][0] = (vec4(0.0, -8.0, -6.0, 7.0));
	var[2][0][1][1] = (vec4(3.0, -7.0, -4.0, 3.0));
	var[2][0][2][0] = (vec4(-8.0, 2.0, 8.0, -7.0));
	var[2][0][2][1] = (vec4(5.0, -9.0, 7.0, 7.0));
	var[2][1][0][0] = (vec4(1.0, 4.0, 2.0, 8.0));
	var[2][1][0][1] = (vec4(1.0, -2.0, 4.0, 5.0));
	var[2][1][1][0] = (vec4(0.0, 7.0, 8.0, 6.0));
	var[2][1][1][1] = (vec4(-7.0, -6.0, -1.0, 7.0));
	var[2][1][2][0] = (vec4(-1.0, -9.0, 8.0, 3.0));
	var[2][1][2][1] = (vec4(-6.0, 4.0, 0.0, 8.0));
	var[3][0][0][0] = (vec4(6.0, 7.0, -7.0, 4.0));
	var[3][0][0][1] = (vec4(0.0, 8.0, -1.0, -1.0));
	var[3][0][1][0] = (vec4(4.0, -5.0, 4.0, 6.0));
	var[3][0][1][1] = (vec4(9.0, 0.0, 5.0, -9.0));
	var[3][0][2][0] = (vec4(2.0, 0.0, -8.0, 6.0));
	var[3][0][2][1] = (vec4(1.0, 2.0, 2.0, -6.0));
	var[3][1][0][0] = (vec4(0.0, 9.0, 6.0, 5.0));
	var[3][1][0][1] = (vec4(-1.0, 1.0, 1.0, 7.0));
	var[3][1][1][0] = (vec4(6.0, -6.0, -7.0, 9.0));
	var[3][1][1][1] = (vec4(-7.0, -4.0, -9.0, 7.0));
	var[3][1][2][0] = (vec4(-2.0, 4.0, -8.0, -3.0));
	var[3][1][2][1] = (vec4(1.0, 7.0, 7.0, -3.0));
}
#version 450
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
	highp ivec3 var[4][2][3];
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((var[0][0][0]), ivec3(7, -4, 3)) && allOk;
	allOk = compare_ivec3((var[0][0][1]), ivec3(-4, -6, -8)) && allOk;
	allOk = compare_ivec3((var[0][0][2]), ivec3(3, -1, -7)) && allOk;
	allOk = compare_ivec3((var[0][1][0]), ivec3(2, -2, 7)) && allOk;
	allOk = compare_ivec3((var[0][1][1]), ivec3(5, 2, 0)) && allOk;
	allOk = compare_ivec3((var[0][1][2]), ivec3(9, 6, 7)) && allOk;
	allOk = compare_ivec3((var[1][0][0]), ivec3(-1, 2, 9)) && allOk;
	allOk = compare_ivec3((var[1][0][1]), ivec3(-8, 4, 9)) && allOk;
	allOk = compare_ivec3((var[1][0][2]), ivec3(-3, -3, -9)) && allOk;
	allOk = compare_ivec3((var[1][1][0]), ivec3(0, 4, -6)) && allOk;
	allOk = compare_ivec3((var[1][1][1]), ivec3(1, 7, 4)) && allOk;
	allOk = compare_ivec3((var[1][1][2]), ivec3(-6, 9, 3)) && allOk;
	allOk = compare_ivec3((var[2][0][0]), ivec3(9, 3, -6)) && allOk;
	allOk = compare_ivec3((var[2][0][1]), ivec3(-6, 7, 3)) && allOk;
	allOk = compare_ivec3((var[2][0][2]), ivec3(6, 9, 0)) && allOk;
	allOk = compare_ivec3((var[2][1][0]), ivec3(1, 5, -6)) && allOk;
	allOk = compare_ivec3((var[2][1][1]), ivec3(-1, 8, 8)) && allOk;
	allOk = compare_ivec3((var[2][1][2]), ivec3(3, 3, -7)) && allOk;
	allOk = compare_ivec3((var[3][0][0]), ivec3(5, 8, 2)) && allOk;
	allOk = compare_ivec3((var[3][0][1]), ivec3(7, -7, 2)) && allOk;
	allOk = compare_ivec3((var[3][0][2]), ivec3(1, -4, 0)) && allOk;
	allOk = compare_ivec3((var[3][1][0]), ivec3(5, 7, 6)) && allOk;
	allOk = compare_ivec3((var[3][1][1]), ivec3(2, 0, 3)) && allOk;
	allOk = compare_ivec3((var[3][1][2]), ivec3(-5, -9, 4)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (ivec3(-5, 0, -9));
	var[0][0][1] = (ivec3(2, 4, 1));
	var[0][0][2] = (ivec3(6, 6, 2));
	var[0][1][0] = (ivec3(6, -8, 1));
	var[0][1][1] = (ivec3(-5, -4, 9));
	var[0][1][2] = (ivec3(-2, 6, -6));
	var[1][0][0] = (ivec3(4, 4, 2));
	var[1][0][1] = (ivec3(-4, -1, -7));
	var[1][0][2] = (ivec3(8, -4, 1));
	var[1][1][0] = (ivec3(-7, 3, 0));
	var[1][1][1] = (ivec3(-7, -5, -7));
	var[1][1][2] = (ivec3(-7, -2, -9));
	var[2][0][0] = (ivec3(-4, -1, 5));
	var[2][0][1] = (ivec3(-4, 2, -2));
	var[2][0][2] = (ivec3(6, 7, -1));
	var[2][1][0] = (ivec3(6, 7, -4));
	var[2][1][1] = (ivec3(-8, 7, 7));
	var[2][1][2] = (ivec3(-7, -8, 6));
	var[3][0][0] = (ivec3(-1, -3, -1));
	var[3][0][1] = (ivec3(-4, -1, -3));
	var[3][0][2] = (ivec3(6, -3, 8));
	var[3][1][0] = (ivec3(4, 2, 3));
	var[3][1][1] = (ivec3(4, -3, -7));
	var[3][1][2] = (ivec3(1, -3, -9));
}
#version 450
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
	highp mat2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat2(var[0][0][0], mat2(-4.0, -1.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(-6.0, -6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2(var[0][0][2], mat2(-5.0, -8.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(-2.0, -9.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(4.0, -8.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat2(var[0][1][2], mat2(2.0, 9.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(4.0, 5.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(-1.0, 0.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat2(var[1][0][2], mat2(2.0, -8.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(4.0, 1.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(-9.0, -9.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat2(var[1][1][2], mat2(-9.0, -7.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(0.0, 7.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(-7.0, 8.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat2(var[2][0][2], mat2(-5.0, 0.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(-1.0, 6.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(0.0, -9.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat2(var[2][1][2], mat2(-5.0, 3.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat2(var[3][0][0], mat2(-9.0, -1.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat2(var[3][0][1], mat2(4.0, -9.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat2(var[3][0][2], mat2(6.0, 3.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat2(var[3][1][0], mat2(-1.0, 7.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2(var[3][1][1], mat2(-5.0, 0.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat2(var[3][1][2], mat2(-8.0, 7.0, -9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (3.0);
	var[0][0][0] = (mat2(2.0, -8.0, -6.0, 2.0));
	var[0][0][1] = (mat2(-3.0, 9.0, -5.0, 4.0));
	var[0][0][2] = (mat2(-2.0, -6.0, -9.0, -2.0));
	var[0][1][0] = (mat2(-9.0, -7.0, -2.0, 2.0));
	var[0][1][1] = (mat2(5.0, -3.0, 7.0, -2.0));
	var[0][1][2] = (mat2(3.0, -1.0, -3.0, -2.0));
	var[1][0][0] = (mat2(-5.0, -1.0, 4.0, 3.0));
	var[1][0][1] = (mat2(6.0, 0.0, 1.0, -2.0));
	var[1][0][2] = (mat2(2.0, 8.0, -5.0, -2.0));
	var[1][1][0] = (mat2(1.0, -1.0, -8.0, 9.0));
	var[1][1][1] = (mat2(-3.0, 6.0, -2.0, 2.0));
	var[1][1][2] = (mat2(-4.0, -6.0, 6.0, 5.0));
	var[2][0][0] = (mat2(-8.0, 6.0, -7.0, 2.0));
	var[2][0][1] = (mat2(-8.0, 4.0, 3.0, 7.0));
	var[2][0][2] = (mat2(8.0, -1.0, -3.0, 7.0));
	var[2][1][0] = (mat2(1.0, 5.0, -6.0, -4.0));
	var[2][1][1] = (mat2(1.0, 6.0, -2.0, -6.0));
	var[2][1][2] = (mat2(3.0, -6.0, -2.0, -9.0));
	var[3][0][0] = (mat2(5.0, -2.0, -8.0, -5.0));
	var[3][0][1] = (mat2(-2.0, 1.0, -2.0, 6.0));
	var[3][0][2] = (mat2(1.0, 8.0, 0.0, 1.0));
	var[3][1][0] = (mat2(0.0, -1.0, -4.0, 0.0));
	var[3][1][1] = (mat2(4.0, 1.0, 7.0, 5.0));
	var[3][1][2] = (mat2(5.0, -4.0, -6.0, 2.0));
}
#version 450
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
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat3(var[0][0][0], mat3(1.0, -5.0, -1.0, 3.0, 7.0, 4.0, 7.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(7.0, -6.0, -4.0, 7.0, -1.0, -5.0, -8.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3(var[0][0][2], mat3(-3.0, 1.0, -3.0, -8.0, 8.0, 8.0, 2.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(8.0, 1.0, 1.0, 0.0, 9.0, 1.0, 7.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(-1.0, 5.0, 1.0, 5.0, -6.0, 3.0, -4.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat3(var[0][1][2], mat3(5.0, 9.0, 1.0, -5.0, -2.0, -1.0, -8.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(5.0, 5.0, -8.0, -1.0, 3.0, 1.0, -6.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(0.0, 5.0, 8.0, -9.0, -8.0, -9.0, 3.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3(var[1][0][2], mat3(9.0, 2.0, 5.0, 5.0, 5.0, -4.0, 4.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(-8.0, -5.0, 4.0, -8.0, 6.0, 8.0, 6.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(-4.0, -5.0, 7.0, -7.0, -5.0, 8.0, -8.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat3(var[1][1][2], mat3(7.0, 2.0, 8.0, 6.0, 9.0, -7.0, -3.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(8.0, -1.0, -9.0, -1.0, 0.0, 2.0, -6.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(-7.0, 6.0, -6.0, 9.0, 2.0, 4.0, 8.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3(var[2][0][2], mat3(-4.0, -4.0, 9.0, 6.0, 6.0, 4.0, -1.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(-2.0, 0.0, 9.0, 3.0, -1.0, -5.0, 2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(2.0, -3.0, 1.0, 2.0, -8.0, -3.0, -4.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3(var[2][1][2], mat3(-4.0, -1.0, -9.0, -6.0, 4.0, 3.0, 0.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat3(var[3][0][0], mat3(7.0, -8.0, 2.0, 4.0, -2.0, -7.0, -5.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat3(var[3][0][1], mat3(2.0, 8.0, 1.0, -9.0, 8.0, 6.0, 7.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3(var[3][0][2], mat3(7.0, 3.0, 2.0, -6.0, 6.0, 0.0, -6.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat3(var[3][1][0], mat3(4.0, 3.0, 4.0, -1.0, 9.0, 1.0, 7.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3(var[3][1][1], mat3(-1.0, 5.0, -5.0, 9.0, -6.0, -2.0, 3.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat3(var[3][1][2], mat3(-3.0, -9.0, 2.0, 5.0, 0.0, 9.0, 8.0, -8.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-2.0);
	var[0][0][0] = (mat3(7.0, 5.0, 2.0, 9.0, -1.0, -9.0, -7.0, 1.0, 6.0));
	var[0][0][1] = (mat3(-1.0, -8.0, -8.0, 0.0, 9.0, 1.0, -5.0, 8.0, 1.0));
	var[0][0][2] = (mat3(-6.0, -1.0, 9.0, -6.0, 0.0, 5.0, -4.0, 5.0, -4.0));
	var[0][1][0] = (mat3(0.0, -7.0, 5.0, -5.0, -2.0, -9.0, 0.0, -7.0, 6.0));
	var[0][1][1] = (mat3(2.0, 5.0, -8.0, 2.0, -9.0, -7.0, 5.0, 8.0, -8.0));
	var[0][1][2] = (mat3(9.0, 2.0, 0.0, -3.0, -6.0, 4.0, 3.0, -4.0, 6.0));
	var[1][0][0] = (mat3(-9.0, 9.0, -7.0, -1.0, -9.0, -9.0, 3.0, -8.0, -2.0));
	var[1][0][1] = (mat3(2.0, -6.0, -7.0, 4.0, 8.0, -8.0, 7.0, -3.0, 6.0));
	var[1][0][2] = (mat3(7.0, -9.0, 5.0, -9.0, 9.0, 1.0, 1.0, 9.0, 8.0));
	var[1][1][0] = (mat3(-5.0, -5.0, -9.0, -4.0, -5.0, 7.0, -6.0, 5.0, -7.0));
	var[1][1][1] = (mat3(0.0, -7.0, 7.0, 9.0, 9.0, 9.0, 5.0, 9.0, 7.0));
	var[1][1][2] = (mat3(-4.0, 1.0, -3.0, 8.0, 0.0, 4.0, -1.0, 7.0, -1.0));
	var[2][0][0] = (mat3(-4.0, 7.0, -5.0, 8.0, 3.0, -4.0, 7.0, -7.0, -5.0));
	var[2][0][1] = (mat3(6.0, -8.0, 1.0, 7.0, 5.0, 7.0, 6.0, -1.0, 1.0));
	var[2][0][2] = (mat3(-8.0, 9.0, -2.0, 7.0, 9.0, -5.0, 7.0, -1.0, 8.0));
	var[2][1][0] = (mat3(9.0, 5.0, -2.0, -6.0, -8.0, -3.0, 1.0, 8.0, -7.0));
	var[2][1][1] = (mat3(-8.0, -8.0, -9.0, -8.0, -9.0, 0.0, 4.0, 8.0, 5.0));
	var[2][1][2] = (mat3(-1.0, 0.0, -6.0, -7.0, -9.0, -2.0, 9.0, 0.0, 7.0));
	var[3][0][0] = (mat3(-6.0, -1.0, -2.0, 9.0, 6.0, 0.0, 7.0, 6.0, -4.0));
	var[3][0][1] = (mat3(-5.0, -8.0, -6.0, 5.0, -5.0, 2.0, -3.0, -6.0, 7.0));
	var[3][0][2] = (mat3(7.0, 9.0, -8.0, -9.0, 8.0, -9.0, 5.0, -4.0, 8.0));
	var[3][1][0] = (mat3(3.0, -7.0, 4.0, 9.0, 3.0, -8.0, 9.0, -3.0, -1.0));
	var[3][1][1] = (mat3(0.0, -8.0, -5.0, 6.0, 2.0, 6.0, 2.0, 8.0, -5.0));
	var[3][1][2] = (mat3(8.0, 9.0, -2.0, 3.0, 4.0, 1.0, 0.0, 1.0, -8.0));
}
#version 450
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
	highp mat4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 5.0) && allOk;
	allOk = compare_mat4(var[0][0][0], mat4(8.0, -8.0, -2.0, 6.0, -4.0, 3.0, -1.0, 6.0, 4.0, -8.0, -3.0, 9.0, 9.0, 4.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(-5.0, 1.0, 2.0, 1.0, 8.0, 6.0, 2.0, -2.0, -9.0, -8.0, -8.0, -3.0, -9.0, -4.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat4(var[0][0][2], mat4(-6.0, 8.0, -9.0, -2.0, 9.0, 7.0, 3.0, 4.0, -1.0, -8.0, -8.0, 9.0, -4.0, 1.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(-6.0, 0.0, -6.0, -4.0, 0.0, 7.0, 0.0, 7.0, 0.0, 8.0, 2.0, -6.0, -3.0, -9.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(-2.0, 1.0, -9.0, -6.0, -1.0, -4.0, 6.0, 8.0, -7.0, 1.0, 3.0, -9.0, 5.0, 1.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat4(var[0][1][2], mat4(4.0, 5.0, 9.0, 0.0, 0.0, 9.0, 3.0, -9.0, -4.0, 5.0, -2.0, 7.0, 9.0, 4.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(-1.0, -9.0, 8.0, 9.0, -9.0, -7.0, -2.0, 3.0, -9.0, -3.0, -9.0, 4.0, -4.0, -1.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(7.0, -4.0, -4.0, 1.0, 2.0, -1.0, -3.0, 8.0, 1.0, -3.0, -1.0, -4.0, -6.0, 8.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4(var[1][0][2], mat4(9.0, 8.0, 7.0, 8.0, -2.0, -2.0, -5.0, -9.0, -8.0, -9.0, -4.0, -9.0, 6.0, 8.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(0.0, -2.0, -7.0, -8.0, 0.0, 3.0, -1.0, -9.0, 1.0, 9.0, -1.0, 5.0, -9.0, -6.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(-5.0, -9.0, 5.0, 4.0, 7.0, 0.0, -6.0, -5.0, -9.0, 6.0, 9.0, 4.0, 6.0, 4.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat4(var[1][1][2], mat4(5.0, 9.0, -6.0, 4.0, 6.0, -4.0, 1.0, 6.0, 1.0, 3.0, 4.0, 3.0, 8.0, 2.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(8.0, -3.0, -5.0, -4.0, -9.0, -2.0, -6.0, -3.0, -9.0, -9.0, -7.0, 7.0, -9.0, 2.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(-6.0, -4.0, 8.0, 0.0, -1.0, 3.0, -5.0, 6.0, -8.0, 9.0, 7.0, 3.0, 0.0, -7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4(var[2][0][2], mat4(-9.0, 9.0, 2.0, -2.0, -2.0, 3.0, -9.0, 4.0, -1.0, -1.0, -7.0, -4.0, 0.0, 7.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(-4.0, 3.0, -3.0, 5.0, 1.0, -7.0, 8.0, 7.0, -9.0, -3.0, 7.0, 9.0, -9.0, -5.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(-2.0, 4.0, -4.0, 1.0, 7.0, 6.0, 9.0, 8.0, -8.0, -3.0, -4.0, -7.0, 4.0, 9.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat4(var[2][1][2], mat4(-5.0, 2.0, 3.0, -9.0, -7.0, 3.0, -6.0, 4.0, 1.0, -7.0, 9.0, 2.0, 6.0, -5.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat4(var[3][0][0], mat4(1.0, 6.0, 5.0, 7.0, -7.0, -8.0, 7.0, -2.0, -3.0, 4.0, 3.0, 2.0, -8.0, 4.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4(var[3][0][1], mat4(2.0, -4.0, 7.0, -4.0, 1.0, -9.0, 8.0, 4.0, -8.0, 5.0, 3.0, 7.0, 5.0, 8.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat4(var[3][0][2], mat4(-3.0, -3.0, -4.0, -9.0, 8.0, 9.0, 0.0, 4.0, 6.0, -9.0, -8.0, 5.0, 3.0, -1.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4(var[3][1][0], mat4(-7.0, -4.0, 1.0, 4.0, 3.0, 9.0, -8.0, -6.0, -7.0, -1.0, -7.0, -7.0, 7.0, 3.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat4(var[3][1][1], mat4(2.0, 5.0, 3.0, 5.0, -7.0, 3.0, -6.0, -7.0, 6.0, 1.0, -5.0, -6.0, 9.0, -8.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat4(var[3][1][2], mat4(-7.0, -4.0, -2.0, -7.0, 1.0, -1.0, 4.0, -9.0, 4.0, 9.0, -9.0, 0.0, -9.0, -2.0, -4.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (6.0);
	var[0][0][0] = (mat4(-8.0, 2.0, -8.0, 1.0, -5.0, -7.0, -8.0, -9.0, 3.0, -9.0, -1.0, 7.0, -6.0, -5.0, 2.0, 4.0));
	var[0][0][1] = (mat4(3.0, -5.0, 6.0, 5.0, -1.0, -1.0, 7.0, -1.0, 5.0, -8.0, -3.0, 2.0, -6.0, -9.0, -5.0, 1.0));
	var[0][0][2] = (mat4(-5.0, -9.0, 9.0, -7.0, -1.0, 6.0, -6.0, 6.0, -9.0, -8.0, -3.0, -3.0, 4.0, -5.0, -1.0, -3.0));
	var[0][1][0] = (mat4(-9.0, -7.0, -9.0, -9.0, -3.0, -8.0, 0.0, -1.0, -4.0, -1.0, -8.0, 5.0, -8.0, -3.0, 1.0, -1.0));
	var[0][1][1] = (mat4(-6.0, -1.0, 0.0, -8.0, 6.0, 6.0, -5.0, -6.0, 9.0, 2.0, 6.0, 6.0, -5.0, -7.0, 0.0, 2.0));
	var[0][1][2] = (mat4(6.0, 3.0, 6.0, 1.0, -3.0, -6.0, 0.0, -2.0, 0.0, -9.0, 1.0, 6.0, 9.0, -9.0, 0.0, -9.0));
	var[1][0][0] = (mat4(-9.0, -6.0, 5.0, 0.0, 6.0, -5.0, -7.0, -6.0, -5.0, 8.0, -6.0, -2.0, -8.0, -4.0, -8.0, 1.0));
	var[1][0][1] = (mat4(5.0, 6.0, -2.0, -7.0, -3.0, -4.0, 6.0, -8.0, -5.0, 2.0, 8.0, 4.0, 3.0, 6.0, -6.0, -7.0));
	var[1][0][2] = (mat4(5.0, 7.0, -7.0, -6.0, 6.0, -2.0, 5.0, 1.0, -3.0, -2.0, 4.0, 6.0, -6.0, -5.0, -5.0, 6.0));
	var[1][1][0] = (mat4(4.0, 1.0, 5.0, 0.0, 9.0, 3.0, -2.0, -8.0, 9.0, -9.0, 2.0, -8.0, 0.0, 7.0, 7.0, 6.0));
	var[1][1][1] = (mat4(-5.0, 5.0, 3.0, -2.0, -8.0, 6.0, 2.0, 7.0, -1.0, -2.0, 8.0, -9.0, 1.0, -4.0, 1.0, -5.0));
	var[1][1][2] = (mat4(-8.0, 1.0, 9.0, -7.0, -4.0, 0.0, -3.0, 6.0, 2.0, 2.0, -2.0, -8.0, 4.0, 1.0, 7.0, 4.0));
	var[2][0][0] = (mat4(-8.0, -5.0, -4.0, 5.0, -3.0, 4.0, 6.0, 2.0, -2.0, -7.0, 5.0, -9.0, -3.0, 9.0, 5.0, 6.0));
	var[2][0][1] = (mat4(9.0, 2.0, 1.0, -6.0, -8.0, 8.0, -2.0, 1.0, 6.0, -5.0, 5.0, -7.0, -8.0, 9.0, 3.0, 6.0));
	var[2][0][2] = (mat4(-6.0, -4.0, 0.0, 8.0, -9.0, -6.0, 2.0, 6.0, 7.0, 5.0, 9.0, -6.0, -9.0, -5.0, 5.0, -5.0));
	var[2][1][0] = (mat4(-5.0, 2.0, -2.0, -1.0, 1.0, 4.0, 0.0, -1.0, -4.0, -1.0, 2.0, -4.0, 7.0, -7.0, -7.0, 1.0));
	var[2][1][1] = (mat4(-8.0, 7.0, -2.0, 3.0, 6.0, -2.0, -7.0, -7.0, -8.0, 7.0, 1.0, -1.0, -5.0, 6.0, -5.0, 6.0));
	var[2][1][2] = (mat4(-7.0, -1.0, -1.0, -1.0, -3.0, -6.0, 3.0, -9.0, -8.0, -5.0, 6.0, -3.0, 3.0, 8.0, -8.0, 5.0));
	var[3][0][0] = (mat4(3.0, 0.0, -2.0, -1.0, -6.0, -7.0, 9.0, -9.0, 8.0, 2.0, -7.0, -7.0, 9.0, 8.0, 7.0, -9.0));
	var[3][0][1] = (mat4(5.0, -4.0, -4.0, 9.0, -1.0, 3.0, -1.0, 7.0, 2.0, 8.0, -2.0, 2.0, -3.0, 0.0, -9.0, 5.0));
	var[3][0][2] = (mat4(-1.0, 6.0, 9.0, 1.0, -7.0, -5.0, -3.0, 4.0, 8.0, -9.0, -2.0, -2.0, -1.0, -1.0, 0.0, -4.0));
	var[3][1][0] = (mat4(-4.0, 6.0, 7.0, 5.0, 0.0, 0.0, -5.0, 4.0, -8.0, -9.0, -1.0, -8.0, 5.0, 0.0, -4.0, 2.0));
	var[3][1][1] = (mat4(7.0, -3.0, 8.0, -6.0, 0.0, 1.0, 7.0, 8.0, -8.0, -8.0, -9.0, -3.0, -1.0, -7.0, 0.0, 6.0));
	var[3][1][2] = (mat4(-2.0, -5.0, -4.0, -6.0, 9.0, -4.0, -9.0, 8.0, -7.0, -5.0, -3.0, 3.0, 5.0, 4.0, -2.0, -9.0));
}
#version 450
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
	highp mat3x4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -3.0) && allOk;
	allOk = compare_mat3x4(var[0][0][0], mat3x4(3.0, -8.0, 8.0, 6.0, -9.0, -3.0, -1.0, 6.0, 3.0, -1.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][1], mat3x4(-8.0, 1.0, 2.0, -6.0, 8.0, -8.0, -3.0, 2.0, 5.0, 2.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][2], mat3x4(-3.0, 5.0, 7.0, 3.0, -1.0, -9.0, -1.0, 5.0, 0.0, 1.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][0], mat3x4(8.0, 5.0, 9.0, 4.0, 6.0, 7.0, 0.0, 4.0, 7.0, 5.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][1], mat3x4(-7.0, -1.0, 4.0, -8.0, -5.0, 3.0, 6.0, 4.0, -1.0, -8.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][2], mat3x4(-2.0, -4.0, 2.0, -1.0, -5.0, -1.0, -2.0, 9.0, 8.0, 3.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][0], mat3x4(-1.0, -7.0, 5.0, -9.0, 3.0, -2.0, -3.0, 3.0, -3.0, 7.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][1], mat3x4(-9.0, -1.0, -5.0, -4.0, -4.0, -6.0, 0.0, -3.0, -5.0, 2.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][2], mat3x4(-4.0, 8.0, 3.0, -8.0, -8.0, 6.0, -5.0, -9.0, -1.0, 3.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][0], mat3x4(3.0, 2.0, 5.0, -9.0, -1.0, -7.0, 5.0, -3.0, -9.0, -9.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][1], mat3x4(3.0, 5.0, 9.0, -3.0, -2.0, -1.0, 5.0, -5.0, -7.0, -5.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][2], mat3x4(0.0, -7.0, 6.0, 9.0, -6.0, -1.0, 6.0, 6.0, 4.0, -6.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][0], mat3x4(-4.0, -3.0, -7.0, 2.0, -1.0, 8.0, -1.0, 3.0, -7.0, -9.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][1], mat3x4(9.0, 2.0, 4.0, 6.0, -7.0, -6.0, 4.0, -4.0, 5.0, -4.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][2], mat3x4(2.0, 0.0, 4.0, 8.0, 7.0, -4.0, -1.0, -4.0, -9.0, -2.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][0], mat3x4(9.0, 2.0, 2.0, 6.0, -3.0, 4.0, -7.0, 0.0, 1.0, 6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][1], mat3x4(-7.0, -8.0, -4.0, 8.0, 2.0, 3.0, 0.0, -9.0, -9.0, 3.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][2], mat3x4(-4.0, -8.0, 9.0, -6.0, -5.0, 4.0, -7.0, 8.0, -7.0, 5.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][0], mat3x4(2.0, -8.0, 5.0, -6.0, 3.0, 1.0, -5.0, -3.0, -6.0, -4.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][1], mat3x4(1.0, 9.0, 2.0, -4.0, -7.0, 1.0, 3.0, 1.0, -2.0, -4.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][2], mat3x4(-5.0, -5.0, 4.0, 9.0, 5.0, -5.0, -3.0, 9.0, 0.0, -4.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][0], mat3x4(1.0, 3.0, 3.0, 6.0, 0.0, -6.0, 2.0, -5.0, 9.0, -5.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][1], mat3x4(4.0, 2.0, -6.0, 2.0, 3.0, -5.0, 6.0, 7.0, 7.0, 2.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][2], mat3x4(-2.0, -5.0, 2.0, -9.0, -4.0, 9.0, -9.0, -8.0, 1.0, -5.0, 7.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-8.0);
	var[0][0][0] = (mat3x4(-6.0, 4.0, -9.0, 7.0, -4.0, -7.0, 0.0, -6.0, -6.0, -3.0, 4.0, 3.0));
	var[0][0][1] = (mat3x4(-2.0, -3.0, 4.0, 2.0, 8.0, 2.0, -4.0, 9.0, -1.0, 9.0, 7.0, 1.0));
	var[0][0][2] = (mat3x4(-1.0, 1.0, 5.0, 5.0, -4.0, -7.0, -4.0, 0.0, 6.0, 2.0, 0.0, -6.0));
	var[0][1][0] = (mat3x4(-2.0, 8.0, -4.0, 8.0, 4.0, 3.0, -3.0, 3.0, -5.0, 7.0, -8.0, 5.0));
	var[0][1][1] = (mat3x4(-3.0, 8.0, 6.0, 1.0, 6.0, -2.0, -6.0, 0.0, 1.0, 3.0, 3.0, -3.0));
	var[0][1][2] = (mat3x4(0.0, -3.0, 5.0, -4.0, -5.0, 1.0, -5.0, -5.0, 0.0, 0.0, -6.0, 4.0));
	var[1][0][0] = (mat3x4(7.0, -1.0, 6.0, 4.0, -9.0, -9.0, -1.0, -8.0, 4.0, -6.0, 6.0, 7.0));
	var[1][0][1] = (mat3x4(-8.0, -5.0, -9.0, -9.0, -2.0, 4.0, 1.0, -3.0, 3.0, -2.0, 2.0, -1.0));
	var[1][0][2] = (mat3x4(2.0, -4.0, -7.0, 9.0, 2.0, -7.0, -8.0, -2.0, -3.0, 3.0, -4.0, 6.0));
	var[1][1][0] = (mat3x4(6.0, -7.0, 7.0, 3.0, 6.0, 4.0, -7.0, 8.0, -1.0, 3.0, 3.0, -1.0));
	var[1][1][1] = (mat3x4(0.0, -1.0, 5.0, 3.0, -9.0, 6.0, 8.0, -9.0, -5.0, -1.0, 1.0, -1.0));
	var[1][1][2] = (mat3x4(-4.0, 7.0, 7.0, 5.0, -7.0, 1.0, 3.0, 6.0, 3.0, -3.0, -9.0, 3.0));
	var[2][0][0] = (mat3x4(6.0, -8.0, 6.0, 2.0, 8.0, -6.0, 2.0, -8.0, 2.0, 6.0, 9.0, 3.0));
	var[2][0][1] = (mat3x4(-3.0, 9.0, -1.0, 6.0, 2.0, -8.0, 0.0, 1.0, 1.0, -3.0, 0.0, 9.0));
	var[2][0][2] = (mat3x4(4.0, -6.0, 6.0, 2.0, 1.0, 9.0, -3.0, -3.0, -6.0, -6.0, -8.0, 5.0));
	var[2][1][0] = (mat3x4(-7.0, -1.0, 2.0, -7.0, -9.0, 4.0, 1.0, -9.0, 4.0, 5.0, -1.0, -3.0));
	var[2][1][1] = (mat3x4(-8.0, 4.0, 4.0, -5.0, 6.0, 7.0, 6.0, 5.0, 2.0, 2.0, -5.0, 8.0));
	var[2][1][2] = (mat3x4(-2.0, -8.0, -1.0, -5.0, -1.0, -6.0, 3.0, 7.0, -8.0, -6.0, -9.0, -5.0));
	var[3][0][0] = (mat3x4(0.0, -6.0, 3.0, 0.0, -8.0, 3.0, 9.0, -6.0, -2.0, 5.0, -8.0, 0.0));
	var[3][0][1] = (mat3x4(-3.0, -8.0, 2.0, 8.0, 8.0, -1.0, 4.0, -6.0, 8.0, 9.0, 8.0, 5.0));
	var[3][0][2] = (mat3x4(7.0, 3.0, 7.0, 9.0, 9.0, 6.0, 5.0, 3.0, 5.0, 2.0, -8.0, 9.0));
	var[3][1][0] = (mat3x4(-1.0, 4.0, 9.0, -9.0, -3.0, -8.0, -1.0, 5.0, 9.0, -6.0, 2.0, -6.0));
	var[3][1][1] = (mat3x4(6.0, -6.0, 7.0, 6.0, -6.0, 8.0, 9.0, 6.0, 0.0, 7.0, 8.0, 7.0));
	var[3][1][2] = (mat3x4(-9.0, -9.0, -4.0, 2.0, 7.0, 9.0, -8.0, -5.0, 6.0, 2.0, -3.0, -2.0));
}
#version 450
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
	f16vec3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(padding), 4.0) && allOk;
	allOk = compare_f16vec3(vec3(var[0][0][0]), vec3(1.0, 9.0, -8.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[0][0][1]), vec3(7.0, -5.0, 4.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[0][0][2]), vec3(2.0, -4.0, 4.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[0][1][0]), vec3(-7.0, -9.0, 2.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[0][1][1]), vec3(6.0, -2.0, -5.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[0][1][2]), vec3(1.0, 9.0, 5.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][0][0]), vec3(4.0, 5.0, 2.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][0][1]), vec3(1.0, 1.0, 8.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][0][2]), vec3(2.0, -3.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][1][0]), vec3(4.0, -4.0, 6.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][1][1]), vec3(-7.0, -8.0, 6.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][1][2]), vec3(-8.0, 1.0, 8.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][0][0]), vec3(-2.0, -4.0, -7.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][0][1]), vec3(-7.0, -7.0, -8.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][0][2]), vec3(-2.0, -2.0, 6.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][1][0]), vec3(2.0, 0.0, -1.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][1][1]), vec3(2.0, 2.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][1][2]), vec3(-8.0, 7.0, 5.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[3][0][0]), vec3(6.0, -1.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[3][0][1]), vec3(-4.0, 6.0, -8.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[3][0][2]), vec3(6.0, 4.0, -1.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[3][1][0]), vec3(7.0, 5.0, 6.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[3][1][1]), vec3(-9.0, -6.0, 0.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[3][1][2]), vec3(-3.0, 2.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = float16_t(3.0);
	var[0][0][0] = f16vec3(vec3(3.0, 7.0, -3.0));
	var[0][0][1] = f16vec3(vec3(-5.0, -9.0, -1.0));
	var[0][0][2] = f16vec3(vec3(0.0, 6.0, 5.0));
	var[0][1][0] = f16vec3(vec3(6.0, -6.0, -3.0));
	var[0][1][1] = f16vec3(vec3(1.0, -5.0, 6.0));
	var[0][1][2] = f16vec3(vec3(9.0, 7.0, 2.0));
	var[1][0][0] = f16vec3(vec3(-7.0, 2.0, 9.0));
	var[1][0][1] = f16vec3(vec3(1.0, -5.0, -5.0));
	var[1][0][2] = f16vec3(vec3(5.0, 2.0, -5.0));
	var[1][1][0] = f16vec3(vec3(5.0, 3.0, 9.0));
	var[1][1][1] = f16vec3(vec3(-8.0, 2.0, -7.0));
	var[1][1][2] = f16vec3(vec3(-8.0, -3.0, 2.0));
	var[2][0][0] = f16vec3(vec3(-4.0, 6.0, -3.0));
	var[2][0][1] = f16vec3(vec3(-7.0, -4.0, -4.0));
	var[2][0][2] = f16vec3(vec3(5.0, 0.0, -6.0));
	var[2][1][0] = f16vec3(vec3(-5.0, -9.0, -8.0));
	var[2][1][1] = f16vec3(vec3(4.0, 1.0, -9.0));
	var[2][1][2] = f16vec3(vec3(-5.0, 5.0, -3.0));
	var[3][0][0] = f16vec3(vec3(4.0, -1.0, -2.0));
	var[3][0][1] = f16vec3(vec3(3.0, -8.0, -4.0));
	var[3][0][2] = f16vec3(vec3(-2.0, 4.0, 6.0));
	var[3][1][0] = f16vec3(vec3(-6.0, 0.0, -3.0));
	var[3][1][1] = f16vec3(vec3(9.0, -1.0, -9.0));
	var[3][1][2] = f16vec3(vec3(0.0, -5.0, -2.0));
}
#version 450
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
	u16vec4 var[][4][2];
};

bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(var[0][0][0]), uvec4(6u, 0u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[0][0][1]), uvec4(8u, 7u, 5u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[0][1][0]), uvec4(9u, 2u, 2u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[0][1][1]), uvec4(9u, 9u, 3u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[0][2][0]), uvec4(0u, 2u, 0u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[0][2][1]), uvec4(9u, 8u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[0][3][0]), uvec4(2u, 6u, 2u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[0][3][1]), uvec4(3u, 7u, 0u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][0][0]), uvec4(8u, 7u, 1u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][0][1]), uvec4(5u, 0u, 5u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][1][0]), uvec4(0u, 0u, 4u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][1][1]), uvec4(1u, 7u, 1u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][2][0]), uvec4(5u, 2u, 3u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][2][1]), uvec4(5u, 9u, 1u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][3][0]), uvec4(6u, 4u, 5u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][3][1]), uvec4(6u, 4u, 0u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][0][0]), uvec4(9u, 4u, 6u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][0][1]), uvec4(5u, 3u, 6u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][1][0]), uvec4(8u, 7u, 4u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][1][1]), uvec4(7u, 0u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][2][0]), uvec4(6u, 2u, 0u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][2][1]), uvec4(5u, 5u, 6u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][3][0]), uvec4(2u, 9u, 7u, 6u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][3][1]), uvec4(8u, 1u, 6u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = u16vec4(uvec4(0u, 6u, 9u, 4u));
	var[0][0][1] = u16vec4(uvec4(5u, 0u, 1u, 0u));
	var[0][1][0] = u16vec4(uvec4(9u, 3u, 0u, 2u));
	var[0][1][1] = u16vec4(uvec4(3u, 5u, 0u, 2u));
	var[0][2][0] = u16vec4(uvec4(6u, 9u, 4u, 2u));
	var[0][2][1] = u16vec4(uvec4(9u, 7u, 6u, 2u));
	var[0][3][0] = u16vec4(uvec4(7u, 8u, 2u, 8u));
	var[0][3][1] = u16vec4(uvec4(0u, 3u, 6u, 3u));
	var[1][0][0] = u16vec4(uvec4(7u, 6u, 5u, 9u));
	var[1][0][1] = u16vec4(uvec4(8u, 3u, 6u, 1u));
	var[1][1][0] = u16vec4(uvec4(5u, 1u, 5u, 5u));
	var[1][1][1] = u16vec4(uvec4(4u, 0u, 8u, 4u));
	var[1][2][0] = u16vec4(uvec4(8u, 4u, 6u, 2u));
	var[1][2][1] = u16vec4(uvec4(2u, 1u, 0u, 1u));
	var[1][3][0] = u16vec4(uvec4(4u, 0u, 8u, 2u));
	var[1][3][1] = u16vec4(uvec4(3u, 0u, 4u, 2u));
	var[2][0][0] = u16vec4(uvec4(7u, 9u, 3u, 8u));
	var[2][0][1] = u16vec4(uvec4(1u, 4u, 3u, 9u));
	var[2][1][0] = u16vec4(uvec4(0u, 3u, 7u, 1u));
	var[2][1][1] = u16vec4(uvec4(1u, 8u, 4u, 7u));
	var[2][2][0] = u16vec4(uvec4(9u, 9u, 4u, 6u));
	var[2][2][1] = u16vec4(uvec4(4u, 4u, 2u, 8u));
	var[2][3][0] = u16vec4(uvec4(4u, 7u, 1u, 9u));
	var[2][3][1] = u16vec4(uvec4(5u, 6u, 9u, 9u));
}
#version 450
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
	highp mat3 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0][0][0], mat3(-8.0, -9.0, -7.0, -7.0, 8.0, 7.0, 4.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(5.0, -4.0, 7.0, -4.0, -3.0, 8.0, 7.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(-8.0, 7.0, 2.0, -7.0, 4.0, -2.0, -5.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(-1.0, 2.0, 0.0, -9.0, -9.0, 6.0, -6.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(var[0][2][0], mat3(-7.0, 8.0, -6.0, -9.0, -8.0, 8.0, 0.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3(var[0][2][1], mat3(-6.0, 0.0, -3.0, 9.0, 7.0, -8.0, -9.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3(var[0][3][0], mat3(3.0, 4.0, -4.0, -1.0, -7.0, -1.0, 4.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(var[0][3][1], mat3(1.0, 1.0, 3.0, -6.0, -4.0, -2.0, -6.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(1.0, 6.0, 8.0, -9.0, -1.0, 8.0, 8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(-6.0, 4.0, -3.0, -2.0, 3.0, 7.0, 0.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(-4.0, -3.0, -3.0, 4.0, -6.0, -6.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(4.0, 6.0, -3.0, 5.0, -4.0, -6.0, -5.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3(var[1][2][0], mat3(-8.0, 9.0, 0.0, -7.0, 1.0, -2.0, 3.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3(var[1][2][1], mat3(6.0, 6.0, -4.0, 4.0, -2.0, 6.0, 2.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat3(var[1][3][0], mat3(2.0, 3.0, 1.0, 8.0, 9.0, -4.0, -2.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3(var[1][3][1], mat3(4.0, -9.0, 6.0, -1.0, 0.0, -2.0, 4.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(-1.0, 1.0, -9.0, 4.0, 6.0, 8.0, 8.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(3.0, 0.0, -4.0, 8.0, 3.0, 9.0, 3.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(8.0, -1.0, -4.0, -2.0, 4.0, -8.0, 0.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(9.0, 6.0, 8.0, -7.0, 4.0, -8.0, 4.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat3(var[2][2][0], mat3(2.0, 9.0, 6.0, -8.0, -6.0, -3.0, -4.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3(var[2][2][1], mat3(-5.0, -8.0, 6.0, 2.0, 5.0, -6.0, 7.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3(var[2][3][0], mat3(-8.0, 3.0, -2.0, 1.0, 3.0, -1.0, -8.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3(var[2][3][1], mat3(-2.0, -4.0, -1.0, 1.0, -1.0, -8.0, -9.0, -9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3(5.0, 2.0, 8.0, 8.0, 3.0, -2.0, 2.0, -8.0, -5.0));
	var[0][0][1] = (mat3(-6.0, -1.0, 7.0, -5.0, -5.0, 8.0, -2.0, -5.0, 5.0));
	var[0][1][0] = (mat3(5.0, 8.0, -1.0, 8.0, 9.0, 6.0, -1.0, 5.0, -2.0));
	var[0][1][1] = (mat3(1.0, 4.0, -8.0, 8.0, 1.0, 2.0, 4.0, -7.0, 3.0));
	var[0][2][0] = (mat3(-9.0, 2.0, -8.0, 1.0, -5.0, 5.0, 8.0, -6.0, 7.0));
	var[0][2][1] = (mat3(-1.0, 7.0, -7.0, 7.0, 5.0, -9.0, 5.0, 3.0, -1.0));
	var[0][3][0] = (mat3(-7.0, 7.0, -5.0, 5.0, 0.0, 7.0, -8.0, -5.0, 8.0));
	var[0][3][1] = (mat3(4.0, -8.0, -8.0, 3.0, -2.0, 4.0, 8.0, -1.0, -5.0));
	var[1][0][0] = (mat3(3.0, 9.0, -7.0, -2.0, 3.0, 5.0, 5.0, 1.0, -6.0));
	var[1][0][1] = (mat3(-5.0, 4.0, 9.0, -2.0, -6.0, 2.0, -1.0, 0.0, 2.0));
	var[1][1][0] = (mat3(-1.0, -5.0, 2.0, 2.0, -1.0, -7.0, 7.0, -8.0, -6.0));
	var[1][1][1] = (mat3(5.0, -9.0, 2.0, 2.0, -9.0, -9.0, -2.0, 1.0, 8.0));
	var[1][2][0] = (mat3(6.0, -3.0, 9.0, 7.0, 0.0, 2.0, 8.0, -5.0, -9.0));
	var[1][2][1] = (mat3(-3.0, 0.0, 7.0, -7.0, 1.0, -6.0, -4.0, 1.0, -9.0));
	var[1][3][0] = (mat3(-5.0, -1.0, -1.0, 4.0, 9.0, 2.0, -2.0, -7.0, 2.0));
	var[1][3][1] = (mat3(-5.0, -3.0, -3.0, 1.0, -3.0, -9.0, 5.0, 7.0, 7.0));
	var[2][0][0] = (mat3(9.0, -5.0, 7.0, 6.0, 8.0, 4.0, 5.0, -2.0, -5.0));
	var[2][0][1] = (mat3(7.0, -1.0, 1.0, -3.0, -8.0, 1.0, -4.0, 7.0, 1.0));
	var[2][1][0] = (mat3(-4.0, 8.0, -5.0, 5.0, -2.0, 2.0, 3.0, 3.0, -8.0));
	var[2][1][1] = (mat3(0.0, 2.0, 6.0, 2.0, -5.0, -9.0, 4.0, 6.0, -3.0));
	var[2][2][0] = (mat3(6.0, 9.0, 8.0, 5.0, 8.0, 1.0, 6.0, 4.0, -4.0));
	var[2][2][1] = (mat3(9.0, -4.0, 1.0, -5.0, 8.0, -3.0, 4.0, -9.0, -8.0));
	var[2][3][0] = (mat3(6.0, 3.0, -3.0, 2.0, 0.0, 2.0, -1.0, 4.0, 2.0));
	var[2][3][1] = (mat3(2.0, 3.0, 2.0, -9.0, 3.0, 4.0, -6.0, -3.0, -9.0));
}
#version 450
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
	highp uvec2 a;
	mediump mat2x4 b[4];
	highp vec3 c;
};
layout(std140, binding = 1) buffer Block
{
	lowp vec2 u;
	mediump uint v;
	S s[];
} block[3];

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
	allOk = compare_uvec2((block[0].s[0].a), uvec2(9u, 9u)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[0], mat2x4(-7.0, 1.0, 8.0, 3.0, 7.0, -3.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[1], mat2x4(-3.0, 3.0, -9.0, -1.0, 3.0, 8.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[2], mat2x4(9.0, 6.0, 2.0, -9.0, 6.0, -1.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[3], mat2x4(-4.0, -1.0, -6.0, -6.0, 3.0, -3.0, 0.0, 1.0)) && allOk;
	allOk = compare_vec3((block[0].s[0].c), vec3(4.0, -8.0, 9.0)) && allOk;
	allOk = compare_uvec2((block[0].s[1].a), uvec2(6u, 1u)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[0], mat2x4(-7.0, 4.0, -9.0, -6.0, -2.0, 7.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[1], mat2x4(9.0, -2.0, -4.0, 7.0, -9.0, -2.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[2], mat2x4(5.0, 4.0, 9.0, 2.0, -2.0, -3.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[3], mat2x4(2.0, -8.0, 2.0, -7.0, -6.0, 3.0, 6.0, 4.0)) && allOk;
	allOk = compare_vec3((block[0].s[1].c), vec3(8.0, -4.0, 2.0)) && allOk;
	allOk = compare_uvec2((block[0].s[2].a), uvec2(5u, 3u)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[0], mat2x4(1.0, -4.0, -1.0, -5.0, 6.0, -2.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[1], mat2x4(-4.0, -8.0, 7.0, -4.0, -7.0, -1.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[2], mat2x4(8.0, 9.0, 1.0, -6.0, 1.0, -1.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[3], mat2x4(3.0, 3.0, -3.0, -2.0, 4.0, 1.0, 0.0, -8.0)) && allOk;
	allOk = compare_vec3((block[0].s[2].c), vec3(6.0, 7.0, 4.0)) && allOk;
	allOk = compare_uvec2((block[0].s[3].a), uvec2(6u, 4u)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[0], mat2x4(3.0, 8.0, 0.0, -6.0, 3.0, -8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[1], mat2x4(-1.0, -4.0, -1.0, -3.0, -7.0, -8.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[2], mat2x4(0.0, 7.0, 5.0, -1.0, -9.0, -3.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[3], mat2x4(9.0, 5.0, 3.0, -1.0, 8.0, -2.0, -9.0, -3.0)) && allOk;
	allOk = compare_vec3((block[0].s[3].c), vec3(-5.0, 6.0, -5.0)) && allOk;
	allOk = compare_uvec2((block[1].s[0].a), uvec2(1u, 3u)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[0], mat2x4(-2.0, 6.0, 6.0, -2.0, 7.0, 9.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[1], mat2x4(-7.0, 0.0, -7.0, 4.0, -1.0, 6.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[2], mat2x4(5.0, 0.0, 3.0, -1.0, 9.0, 1.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[3], mat2x4(-3.0, -8.0, -7.0, 7.0, -5.0, -9.0, 8.0, -2.0)) && allOk;
	allOk = compare_vec3((block[1].s[0].c), vec3(-4.0, 0.0, 4.0)) && allOk;
	allOk = compare_uvec2((block[1].s[1].a), uvec2(9u, 0u)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[0], mat2x4(-1.0, 8.0, -2.0, 9.0, -5.0, 0.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[1], mat2x4(3.0, -4.0, 5.0, 9.0, -3.0, -7.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[2], mat2x4(-9.0, 0.0, 6.0, 9.0, -1.0, 0.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[3], mat2x4(1.0, 5.0, 9.0, -7.0, -1.0, -8.0, 3.0, -3.0)) && allOk;
	allOk = compare_vec3((block[1].s[1].c), vec3(-3.0, 8.0, 0.0)) && allOk;
	allOk = compare_uvec2((block[1].s[2].a), uvec2(8u, 7u)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[0], mat2x4(-9.0, 6.0, -3.0, -5.0, -2.0, -4.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[1], mat2x4(3.0, 3.0, 2.0, -9.0, -9.0, -1.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[2], mat2x4(9.0, 1.0, 1.0, -5.0, -3.0, 8.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[3], mat2x4(-1.0, 2.0, 3.0, -5.0, -4.0, 5.0, -8.0, -5.0)) && allOk;
	allOk = compare_vec3((block[1].s[2].c), vec3(6.0, 7.0, -6.0)) && allOk;
	allOk = compare_uvec2((block[1].s[3].a), uvec2(3u, 8u)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[0], mat2x4(-7.0, -2.0, -5.0, -6.0, -9.0, 1.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[1], mat2x4(1.0, -7.0, 4.0, 1.0, -3.0, 9.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[2], mat2x4(-8.0, -9.0, 3.0, -2.0, -9.0, 4.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[3], mat2x4(-5.0, 4.0, 9.0, 1.0, 4.0, -2.0, -3.0, 7.0)) && allOk;
	allOk = compare_vec3((block[1].s[3].c), vec3(6.0, 0.0, -2.0)) && allOk;
	allOk = compare_uvec2((block[2].s[0].a), uvec2(1u, 7u)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[0], mat2x4(5.0, -8.0, 2.0, 1.0, 7.0, 9.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[1], mat2x4(3.0, 6.0, -1.0, -4.0, -1.0, 3.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[2], mat2x4(-7.0, -7.0, 2.0, 5.0, 9.0, 6.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[3], mat2x4(-7.0, -7.0, 3.0, 2.0, 8.0, -2.0, 3.0, -4.0)) && allOk;
	allOk = compare_vec3((block[2].s[0].c), vec3(2.0, -1.0, -5.0)) && allOk;
	allOk = compare_uvec2((block[2].s[1].a), uvec2(0u, 8u)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[0], mat2x4(4.0, 5.0, -1.0, -8.0, -6.0, 7.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[1], mat2x4(1.0, 4.0, 2.0, 8.0, 2.0, -9.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[2], mat2x4(8.0, 8.0, 7.0, 0.0, 1.0, 7.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[3], mat2x4(-3.0, 7.0, 7.0, -1.0, 0.0, 8.0, 2.0, -5.0)) && allOk;
	allOk = compare_vec3((block[2].s[1].c), vec3(5.0, -5.0, 9.0)) && allOk;
	allOk = compare_uvec2((block[2].s[2].a), uvec2(1u, 2u)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[0], mat2x4(4.0, -9.0, 8.0, -5.0, -9.0, 7.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[1], mat2x4(-2.0, -3.0, 3.0, -6.0, 8.0, 8.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[2], mat2x4(0.0, -7.0, 5.0, -5.0, -4.0, -6.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[3], mat2x4(-5.0, -3.0, 1.0, 1.0, -6.0, 6.0, 7.0, -4.0)) && allOk;
	allOk = compare_vec3((block[2].s[2].c), vec3(2.0, -5.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].v = (1u);
	block[0].s[0].a = (uvec2(9u, 7u));
	block[0].s[0].b[0] = (mat2x4(9.0, 0.0, 5.0, 7.0, 9.0, 3.0, -5.0, -5.0));
	block[0].s[0].b[1] = (mat2x4(4.0, 3.0, -2.0, -3.0, -4.0, 1.0, 2.0, 1.0));
	block[0].s[0].b[2] = (mat2x4(-8.0, -8.0, -4.0, 4.0, 0.0, -5.0, 2.0, 0.0));
	block[0].s[0].b[3] = (mat2x4(7.0, 9.0, -3.0, -5.0, 3.0, 6.0, 3.0, 5.0));
	block[0].s[0].c = (vec3(-1.0, 4.0, 0.0));
	block[0].s[1].a = (uvec2(7u, 7u));
	block[0].s[1].b[0] = (mat2x4(4.0, 3.0, -6.0, 8.0, 4.0, -6.0, 1.0, 8.0));
	block[0].s[1].b[1] = (mat2x4(-6.0, -3.0, -8.0, 9.0, -8.0, 6.0, 2.0, -2.0));
	block[0].s[1].b[2] = (mat2x4(4.0, -6.0, 6.0, -4.0, -1.0, 3.0, 0.0, -7.0));
	block[0].s[1].b[3] = (mat2x4(-3.0, 7.0, -6.0, 8.0, -3.0, -5.0, 7.0, -5.0));
	block[0].s[1].c = (vec3(6.0, 6.0, 4.0));
	block[0].s[2].a = (uvec2(1u, 1u));
	block[0].s[2].b[0] = (mat2x4(3.0, 2.0, -9.0, -5.0, 9.0, -3.0, -1.0, -2.0));
	block[0].s[2].b[1] = (mat2x4(5.0, -1.0, 0.0, -2.0, -1.0, 4.0, 8.0, -2.0));
	block[0].s[2].b[2] = (mat2x4(-4.0, 9.0, -5.0, -5.0, -5.0, 4.0, -7.0, 5.0));
	block[0].s[2].b[3] = (mat2x4(6.0, 7.0, -9.0, -6.0, -7.0, -8.0, -7.0, -8.0));
	block[0].s[2].c = (vec3(-4.0, -2.0, 0.0));
	block[0].s[3].a = (uvec2(4u, 0u));
	block[0].s[3].b[0] = (mat2x4(0.0, -8.0, 5.0, 5.0, -3.0, 6.0, 4.0, -1.0));
	block[0].s[3].b[1] = (mat2x4(-8.0, 8.0, -5.0, 4.0, -2.0, -1.0, 2.0, -6.0));
	block[0].s[3].b[2] = (mat2x4(6.0, -1.0, 3.0, 6.0, 2.0, 0.0, 8.0, 3.0));
	block[0].s[3].b[3] = (mat2x4(0.0, 3.0, -6.0, 5.0, 3.0, -6.0, -4.0, -7.0));
	block[0].s[3].c = (vec3(3.0, 2.0, -5.0));
	block[1].v = (2u);
	block[1].s[0].a = (uvec2(3u, 2u));
	block[1].s[0].b[0] = (mat2x4(2.0, 1.0, 4.0, -8.0, -3.0, -1.0, -4.0, 5.0));
	block[1].s[0].b[1] = (mat2x4(6.0, 0.0, 4.0, 9.0, 2.0, -9.0, 6.0, 7.0));
	block[1].s[0].b[2] = (mat2x4(1.0, 3.0, 5.0, 5.0, -8.0, 6.0, 1.0, -5.0));
	block[1].s[0].b[3] = (mat2x4(4.0, 0.0, -1.0, -4.0, -1.0, 4.0, 4.0, -4.0));
	block[1].s[0].c = (vec3(-4.0, 3.0, -9.0));
	block[1].s[1].a = (uvec2(1u, 9u));
	block[1].s[1].b[0] = (mat2x4(3.0, -7.0, 8.0, 4.0, 0.0, -4.0, -3.0, 5.0));
	block[1].s[1].b[1] = (mat2x4(0.0, -8.0, -7.0, 6.0, 9.0, 5.0, 6.0, -7.0));
	block[1].s[1].b[2] = (mat2x4(8.0, -7.0, 1.0, 4.0, 4.0, 5.0, -4.0, 2.0));
	block[1].s[1].b[3] = (mat2x4(6.0, -8.0, 2.0, -1.0, -2.0, 2.0, -4.0, -3.0));
	block[1].s[1].c = (vec3(-4.0, 9.0, -7.0));
	block[1].s[2].a = (uvec2(9u, 8u));
	block[1].s[2].b[0] = (mat2x4(-5.0, -7.0, -9.0, 7.0, -8.0, -9.0, 1.0, 3.0));
	block[1].s[2].b[1] = (mat2x4(-5.0, -5.0, -7.0, 7.0, -3.0, -5.0, 4.0, 1.0));
	block[1].s[2].b[2] = (mat2x4(9.0, 9.0, 4.0, 2.0, -2.0, -9.0, 2.0, -8.0));
	block[1].s[2].b[3] = (mat2x4(-9.0, 2.0, 7.0, 7.0, 6.0, 9.0, 6.0, -3.0));
	block[1].s[2].c = (vec3(-8.0, 6.0, -2.0));
	block[1].s[3].a = (uvec2(3u, 8u));
	block[1].s[3].b[0] = (mat2x4(-8.0, 2.0, 5.0, -5.0, -6.0, 1.0, 4.0, -1.0));
	block[1].s[3].b[1] = (mat2x4(-8.0, -2.0, -6.0, -1.0, -9.0, 8.0, -9.0, -8.0));
	block[1].s[3].b[2] = (mat2x4(5.0, -6.0, 3.0, -8.0, -2.0, 1.0, 8.0, -5.0));
	block[1].s[3].b[3] = (mat2x4(-8.0, 8.0, -8.0, -5.0, 2.0, -2.0, 9.0, 3.0));
	block[1].s[3].c = (vec3(-9.0, 3.0, -1.0));
	block[2].v = (3u);
	block[2].s[0].a = (uvec2(1u, 5u));
	block[2].s[0].b[0] = (mat2x4(4.0, -5.0, 7.0, -7.0, 8.0, -3.0, 5.0, -7.0));
	block[2].s[0].b[1] = (mat2x4(3.0, -9.0, 0.0, 2.0, -4.0, 7.0, 5.0, -9.0));
	block[2].s[0].b[2] = (mat2x4(-8.0, -1.0, -2.0, -4.0, 8.0, 7.0, -5.0, 8.0));
	block[2].s[0].b[3] = (mat2x4(-5.0, -9.0, -1.0, -5.0, -4.0, -4.0, -7.0, 5.0));
	block[2].s[0].c = (vec3(-6.0, 5.0, -8.0));
	block[2].s[1].a = (uvec2(5u, 0u));
	block[2].s[1].b[0] = (mat2x4(-5.0, -6.0, -5.0, 1.0, 1.0, 4.0, 5.0, 5.0));
	block[2].s[1].b[1] = (mat2x4(-8.0, 3.0, 8.0, 1.0, -5.0, 7.0, 9.0, 3.0));
	block[2].s[1].b[2] = (mat2x4(-4.0, 7.0, 1.0, 0.0, -9.0, 0.0, 3.0, 0.0));
	block[2].s[1].b[3] = (mat2x4(-7.0, 9.0, -6.0, -5.0, 9.0, 9.0, 3.0, -8.0));
	block[2].s[1].c = (vec3(0.0, 8.0, 6.0));
	block[2].s[2].a = (uvec2(0u, 9u));
	block[2].s[2].b[0] = (mat2x4(-8.0, -3.0, -2.0, 8.0, -3.0, -9.0, -9.0, -9.0));
	block[2].s[2].b[1] = (mat2x4(-4.0, -7.0, 8.0, -7.0, 6.0, 3.0, -6.0, 7.0));
	block[2].s[2].b[2] = (mat2x4(-3.0, -4.0, 1.0, -2.0, 8.0, 9.0, 6.0, 7.0));
	block[2].s[2].b[3] = (mat2x4(7.0, 9.0, -2.0, 3.0, -1.0, -6.0, 2.0, 1.0));
	block[2].s[2].c = (vec3(4.0, -4.0, 2.0));
}
#version 450
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
layout(std140, binding = 1) buffer Block
{
	lowp vec2 u;
	mediump uint v;
	S s[];
} block[3];

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
	allOk = compare_uvec2((block[0].s[0].a), uvec2(3u, 9u)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[0], mat2x4(-7.0, 2.0, 3.0, 1.0, -1.0, -5.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[1], mat2x4(9.0, -9.0, -8.0, -6.0, -4.0, 6.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[2], mat2x4(1.0, -9.0, -8.0, 5.0, -7.0, -9.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[3], mat2x4(3.0, -7.0, 2.0, -7.0, -5.0, 1.0, -6.0, 4.0)) && allOk;
	allOk = compare_vec3((block[0].s[0].c), vec3(2.0, -7.0, 6.0)) && allOk;
	allOk = compare_uvec2((block[0].s[1].a), uvec2(4u, 0u)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[0], mat2x4(-5.0, 8.0, -2.0, 4.0, -4.0, -3.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[1], mat2x4(8.0, 7.0, 5.0, 9.0, -2.0, 5.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[2], mat2x4(9.0, 1.0, 8.0, -8.0, -8.0, 1.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[3], mat2x4(2.0, 6.0, 2.0, 5.0, -6.0, -4.0, 8.0, -2.0)) && allOk;
	allOk = compare_vec3((block[0].s[1].c), vec3(4.0, -1.0, -4.0)) && allOk;
	allOk = compare_uvec2((block[0].s[2].a), uvec2(3u, 5u)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[0], mat2x4(3.0, -5.0, 5.0, 5.0, -1.0, -3.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[1], mat2x4(-8.0, -1.0, 5.0, -4.0, 4.0, 6.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[2], mat2x4(6.0, 1.0, -6.0, 7.0, 7.0, -9.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[3], mat2x4(-1.0, -5.0, -7.0, -2.0, 0.0, -8.0, 8.0, -7.0)) && allOk;
	allOk = compare_vec3((block[0].s[2].c), vec3(-2.0, -9.0, 8.0)) && allOk;
	allOk = compare_uvec2((block[0].s[3].a), uvec2(9u, 2u)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[0], mat2x4(-1.0, 9.0, 9.0, -3.0, -9.0, -3.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[1], mat2x4(3.0, 2.0, 1.0, 2.0, -5.0, 9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[2], mat2x4(1.0, -4.0, 1.0, 9.0, 2.0, -2.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[3], mat2x4(2.0, 5.0, 0.0, -1.0, 3.0, -9.0, -7.0, -8.0)) && allOk;
	allOk = compare_vec3((block[0].s[3].c), vec3(-9.0, 0.0, -9.0)) && allOk;
	allOk = compare_uvec2((block[1].s[0].a), uvec2(7u, 4u)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[0], mat2x4(-6.0, 9.0, -2.0, 8.0, -1.0, -5.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[1], mat2x4(-3.0, -9.0, -2.0, -9.0, 4.0, -3.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[2], mat2x4(-8.0, 3.0, -6.0, -9.0, -7.0, -6.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[3], mat2x4(5.0, 0.0, -5.0, -8.0, 4.0, -3.0, 4.0, 8.0)) && allOk;
	allOk = compare_vec3((block[1].s[0].c), vec3(7.0, 8.0, 7.0)) && allOk;
	allOk = compare_uvec2((block[1].s[1].a), uvec2(3u, 9u)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[0], mat2x4(6.0, -5.0, -1.0, 9.0, 5.0, 9.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[1], mat2x4(-9.0, 5.0, 9.0, -3.0, -1.0, 9.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[2], mat2x4(-5.0, 6.0, 7.0, 3.0, 5.0, -9.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[3], mat2x4(-1.0, 0.0, -5.0, 8.0, -2.0, 2.0, 4.0, -2.0)) && allOk;
	allOk = compare_vec3((block[1].s[1].c), vec3(0.0, -3.0, 9.0)) && allOk;
	allOk = compare_uvec2((block[1].s[2].a), uvec2(6u, 3u)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[0], mat2x4(9.0, 7.0, -4.0, -1.0, -8.0, 6.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[1], mat2x4(9.0, 1.0, 0.0, 9.0, -1.0, -6.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[2], mat2x4(9.0, -7.0, 6.0, 1.0, 3.0, -7.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[3], mat2x4(-9.0, -2.0, -3.0, -7.0, -2.0, 5.0, 3.0, -6.0)) && allOk;
	allOk = compare_vec3((block[1].s[2].c), vec3(7.0, -4.0, 5.0)) && allOk;
	allOk = compare_uvec2((block[1].s[3].a), uvec2(9u, 9u)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[0], mat2x4(-9.0, 3.0, 3.0, 7.0, 6.0, -3.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[1], mat2x4(-4.0, -1.0, -8.0, 0.0, -2.0, 4.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[2], mat2x4(-5.0, 3.0, -5.0, 4.0, 5.0, -7.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[3], mat2x4(-6.0, 3.0, -5.0, -7.0, 9.0, -6.0, 9.0, 4.0)) && allOk;
	allOk = compare_vec3((block[1].s[3].c), vec3(-2.0, 1.0, -9.0)) && allOk;
	allOk = compare_uvec2((block[2].s[0].a), uvec2(6u, 6u)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[0], mat2x4(7.0, -7.0, 5.0, 1.0, 7.0, -4.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[1], mat2x4(8.0, -4.0, 3.0, 9.0, -5.0, 4.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[2], mat2x4(-4.0, -1.0, 0.0, -4.0, 8.0, 6.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[3], mat2x4(-1.0, 7.0, -2.0, 1.0, 1.0, 9.0, 5.0, -7.0)) && allOk;
	allOk = compare_vec3((block[2].s[0].c), vec3(7.0, -3.0, -2.0)) && allOk;
	allOk = compare_uvec2((block[2].s[1].a), uvec2(5u, 5u)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[0], mat2x4(2.0, -8.0, -7.0, -8.0, 0.0, -8.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[1], mat2x4(-8.0, 1.0, 3.0, -4.0, 2.0, 7.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[2], mat2x4(-5.0, -5.0, 5.0, -2.0, 6.0, -5.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[3], mat2x4(-4.0, -6.0, -1.0, -7.0, 0.0, 2.0, 3.0, 9.0)) && allOk;
	allOk = compare_vec3((block[2].s[1].c), vec3(6.0, 7.0, 1.0)) && allOk;
	allOk = compare_uvec2((block[2].s[2].a), uvec2(0u, 3u)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[0], mat2x4(-9.0, 2.0, -8.0, -5.0, 1.0, -3.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[1], mat2x4(2.0, 2.0, 5.0, -8.0, 7.0, -1.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[2], mat2x4(-5.0, 5.0, -7.0, -1.0, 6.0, 5.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[3], mat2x4(8.0, -7.0, 4.0, 7.0, -5.0, 3.0, 2.0, -9.0)) && allOk;
	allOk = compare_vec3((block[2].s[2].c), vec3(4.0, 6.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].v = (5u);
	block[0].s[0].a = (uvec2(5u, 5u));
	block[0].s[0].b[0][0] = (vec4(-4.0, -1.0, -5.0, -1.0));
	block[0].s[0].b[0][1] = (vec4(8.0, 2.0, -1.0, 0.0));
	block[0].s[0].b[1][0] = (vec4(-9.0, -5.0, -1.0, 7.0));
	block[0].s[0].b[1][1] = (vec4(-2.0, -1.0, 0.0, 7.0));
	block[0].s[0].b[2][0] = (vec4(1.0, -1.0, -4.0, 9.0));
	block[0].s[0].b[2][1] = (vec4(-6.0, -6.0, 6.0, 9.0));
	block[0].s[0].b[3][0] = (vec4(7.0, 0.0, -4.0, -2.0));
	block[0].s[0].b[3][1] = (vec4(-4.0, 6.0, -2.0, 5.0));
	block[0].s[0].c = (vec3(6.0, 5.0, 6.0));
	block[0].s[1].a = (uvec2(0u, 9u));
	block[0].s[1].b[0][0] = (vec4(-6.0, 9.0, -5.0, 4.0));
	block[0].s[1].b[0][1] = (vec4(2.0, 8.0, -2.0, -2.0));
	block[0].s[1].b[1][0] = (vec4(-2.0, -7.0, -4.0, 9.0));
	block[0].s[1].b[1][1] = (vec4(-8.0, -1.0, 9.0, -5.0));
	block[0].s[1].b[2][0] = (vec4(2.0, 4.0, -7.0, 7.0));
	block[0].s[1].b[2][1] = (vec4(3.0, 9.0, 6.0, -3.0));
	block[0].s[1].b[3][0] = (vec4(-2.0, 2.0, 6.0, -8.0));
	block[0].s[1].b[3][1] = (vec4(9.0, 1.0, -8.0, -4.0));
	block[0].s[1].c = (vec3(3.0, -6.0, 2.0));
	block[0].s[2].a = (uvec2(6u, 2u));
	block[0].s[2].b[0][0] = (vec4(8.0, 1.0, 7.0, -4.0));
	block[0].s[2].b[0][1] = (vec4(-2.0, 0.0, 8.0, -3.0));
	block[0].s[2].b[1][0] = (vec4(8.0, 0.0, 7.0, -8.0));
	block[0].s[2].b[1][1] = (vec4(1.0, -9.0, 8.0, -1.0));
	block[0].s[2].b[2][0] = (vec4(-2.0, -7.0, -5.0, 4.0));
	block[0].s[2].b[2][1] = (vec4(9.0, 6.0, -4.0, 0.0));
	block[0].s[2].b[3][0] = (vec4(4.0, 2.0, -4.0, 9.0));
	block[0].s[2].b[3][1] = (vec4(-6.0, 3.0, -1.0, 5.0));
	block[0].s[2].c = (vec3(3.0, 6.0, 3.0));
	block[0].s[3].a = (uvec2(0u, 4u));
	block[0].s[3].b[0][0] = (vec4(7.0, -4.0, 3.0, 9.0));
	block[0].s[3].b[0][1] = (vec4(-2.0, -6.0, 6.0, -4.0));
	block[0].s[3].b[1][0] = (vec4(-9.0, 2.0, 0.0, 0.0));
	block[0].s[3].b[1][1] = (vec4(-5.0, 6.0, 3.0, -7.0));
	block[0].s[3].b[2][0] = (vec4(-3.0, -7.0, 3.0, -6.0));
	block[0].s[3].b[2][1] = (vec4(-6.0, -6.0, 3.0, 5.0));
	block[0].s[3].b[3][0] = (vec4(-7.0, -2.0, 0.0, -4.0));
	block[0].s[3].b[3][1] = (vec4(3.0, 2.0, 3.0, 3.0));
	block[0].s[3].c = (vec3(-2.0, 0.0, -1.0));
	block[1].v = (8u);
	block[1].s[0].a = (uvec2(5u, 3u));
	block[1].s[0].b[0][0] = (vec4(-3.0, -5.0, -2.0, -5.0));
	block[1].s[0].b[0][1] = (vec4(4.0, -5.0, 2.0, -7.0));
	block[1].s[0].b[1][0] = (vec4(4.0, 8.0, 5.0, 4.0));
	block[1].s[0].b[1][1] = (vec4(-3.0, -4.0, -4.0, 1.0));
	block[1].s[0].b[2][0] = (vec4(2.0, 6.0, 6.0, -3.0));
	block[1].s[0].b[2][1] = (vec4(-4.0, -9.0, -3.0, -2.0));
	block[1].s[0].b[3][0] = (vec4(-1.0, 6.0, 7.0, -7.0));
	block[1].s[0].b[3][1] = (vec4(9.0, 4.0, -2.0, -9.0));
	block[1].s[0].c = (vec3(2.0, -3.0, 1.0));
	block[1].s[1].a = (uvec2(0u, 0u));
	block[1].s[1].b[0][0] = (vec4(-4.0, 6.0, 1.0, 3.0));
	block[1].s[1].b[0][1] = (vec4(-5.0, 4.0, -7.0, 3.0));
	block[1].s[1].b[1][0] = (vec4(3.0, -9.0, 8.0, 3.0));
	block[1].s[1].b[1][1] = (vec4(-3.0, -9.0, -7.0, 0.0));
	block[1].s[1].b[2][0] = (vec4(-9.0, 2.0, -7.0, -6.0));
	block[1].s[1].b[2][1] = (vec4(-5.0, -9.0, 3.0, 8.0));
	block[1].s[1].b[3][0] = (vec4(-4.0, 1.0, -8.0, 1.0));
	block[1].s[1].b[3][1] = (vec4(-9.0, -8.0, 0.0, -8.0));
	block[1].s[1].c = (vec3(4.0, -7.0, 4.0));
	block[1].s[2].a = (uvec2(6u, 1u));
	block[1].s[2].b[0][0] = (vec4(-1.0, 0.0, -1.0, -6.0));
	block[1].s[2].b[0][1] = (vec4(1.0, 4.0, -8.0, -4.0));
	block[1].s[2].b[1][0] = (vec4(-8.0, -6.0, -8.0, -6.0));
	block[1].s[2].b[1][1] = (vec4(-2.0, 7.0, 5.0, 2.0));
	block[1].s[2].b[2][0] = (vec4(3.0, -5.0, -7.0, 8.0));
	block[1].s[2].b[2][1] = (vec4(5.0, 9.0, 8.0, -1.0));
	block[1].s[2].b[3][0] = (vec4(2.0, -4.0, 1.0, 1.0));
	block[1].s[2].b[3][1] = (vec4(-3.0, 8.0, 1.0, -3.0));
	block[1].s[2].c = (vec3(3.0, 5.0, 6.0));
	block[1].s[3].a = (uvec2(7u, 7u));
	block[1].s[3].b[0][0] = (vec4(3.0, 3.0, 1.0, 5.0));
	block[1].s[3].b[0][1] = (vec4(-9.0, 7.0, 8.0, -3.0));
	block[1].s[3].b[1][0] = (vec4(7.0, 8.0, -7.0, 8.0));
	block[1].s[3].b[1][1] = (vec4(-9.0, 2.0, 3.0, -8.0));
	block[1].s[3].b[2][0] = (vec4(3.0, 5.0, 8.0, -9.0));
	block[1].s[3].b[2][1] = (vec4(3.0, -7.0, -8.0, -1.0));
	block[1].s[3].b[3][0] = (vec4(1.0, 2.0, 9.0, 6.0));
	block[1].s[3].b[3][1] = (vec4(-6.0, 8.0, 3.0, -3.0));
	block[1].s[3].c = (vec3(-8.0, 5.0, 2.0));
	block[2].v = (0u);
	block[2].s[0].a = (uvec2(0u, 6u));
	block[2].s[0].b[0][0] = (vec4(-1.0, -2.0, 8.0, 3.0));
	block[2].s[0].b[0][1] = (vec4(-8.0, 2.0, -4.0, -9.0));
	block[2].s[0].b[1][0] = (vec4(-8.0, 4.0, 6.0, 2.0));
	block[2].s[0].b[1][1] = (vec4(-8.0, 0.0, -3.0, 4.0));
	block[2].s[0].b[2][0] = (vec4(9.0, 6.0, -2.0, 8.0));
	block[2].s[0].b[2][1] = (vec4(-7.0, -6.0, 7.0, 0.0));
	block[2].s[0].b[3][0] = (vec4(7.0, 3.0, 1.0, -5.0));
	block[2].s[0].b[3][1] = (vec4(-5.0, 3.0, -4.0, 8.0));
	block[2].s[0].c = (vec3(1.0, 0.0, 5.0));
	block[2].s[1].a = (uvec2(9u, 0u));
	block[2].s[1].b[0][0] = (vec4(6.0, 9.0, -3.0, 7.0));
	block[2].s[1].b[0][1] = (vec4(-4.0, -2.0, 4.0, 7.0));
	block[2].s[1].b[1][0] = (vec4(6.0, 1.0, 2.0, 6.0));
	block[2].s[1].b[1][1] = (vec4(-3.0, -9.0, 9.0, -1.0));
	block[2].s[1].b[2][0] = (vec4(-8.0, 0.0, 3.0, 9.0));
	block[2].s[1].b[2][1] = (vec4(2.0, 7.0, -5.0, -9.0));
	block[2].s[1].b[3][0] = (vec4(3.0, -8.0, -2.0, 9.0));
	block[2].s[1].b[3][1] = (vec4(-3.0, -3.0, -9.0, 6.0));
	block[2].s[1].c = (vec3(-4.0, 1.0, 6.0));
	block[2].s[2].a = (uvec2(4u, 2u));
	block[2].s[2].b[0][0] = (vec4(8.0, 7.0, 9.0, -8.0));
	block[2].s[2].b[0][1] = (vec4(2.0, -6.0, 3.0, 2.0));
	block[2].s[2].b[1][0] = (vec4(-8.0, 3.0, -5.0, 9.0));
	block[2].s[2].b[1][1] = (vec4(9.0, -3.0, -6.0, -1.0));
	block[2].s[2].b[2][0] = (vec4(9.0, 1.0, -7.0, 9.0));
	block[2].s[2].b[2][1] = (vec4(-1.0, -5.0, -6.0, -9.0));
	block[2].s[2].b[3][0] = (vec4(5.0, 2.0, 5.0, 1.0));
	block[2].s[2].b[3][1] = (vec4(-5.0, 2.0, 2.0, 8.0));
	block[2].s[2].c = (vec3(-9.0, 9.0, 0.0));
}
#version 450
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
	allOk = compare_uvec2((s[0].a), uvec2(8u, 2u)) && allOk;
	allOk = compare_mat2x4(s[0].b[0], mat2x4(5.0, -3.0, -2.0, -3.0, -7.0, 7.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat2x4(s[0].b[1], mat2x4(8.0, 8.0, 1.0, -5.0, -8.0, -8.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat2x4(s[0].b[2], mat2x4(8.0, -8.0, -7.0, 8.0, -2.0, -6.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat2x4(s[0].b[3], mat2x4(6.0, 9.0, 9.0, 9.0, -7.0, -1.0, 5.0, -4.0)) && allOk;
	allOk = compare_vec3((s[0].c), vec3(9.0, -9.0, -9.0)) && allOk;
	allOk = compare_uvec2((s[1].a), uvec2(3u, 6u)) && allOk;
	allOk = compare_mat2x4(s[1].b[0], mat2x4(1.0, 5.0, -1.0, -5.0, -4.0, 9.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat2x4(s[1].b[1], mat2x4(4.0, -5.0, -7.0, -7.0, -6.0, -8.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x4(s[1].b[2], mat2x4(7.0, -1.0, -5.0, 4.0, 0.0, 6.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat2x4(s[1].b[3], mat2x4(6.0, 0.0, 4.0, 5.0, 9.0, 8.0, 8.0, 2.0)) && allOk;
	allOk = compare_vec3((s[1].c), vec3(-5.0, 8.0, 3.0)) && allOk;
	allOk = compare_uvec2((s[2].a), uvec2(2u, 5u)) && allOk;
	allOk = compare_mat2x4(s[2].b[0], mat2x4(8.0, -7.0, -2.0, 4.0, -2.0, 9.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat2x4(s[2].b[1], mat2x4(-8.0, 5.0, 4.0, 9.0, -3.0, 5.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat2x4(s[2].b[2], mat2x4(0.0, -6.0, 6.0, -2.0, -8.0, 9.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2x4(s[2].b[3], mat2x4(9.0, 5.0, 6.0, 1.0, 9.0, -1.0, 7.0, -4.0)) && allOk;
	allOk = compare_vec3((s[2].c), vec3(3.0, -8.0, 6.0)) && allOk;
	allOk = compare_uvec2((s[3].a), uvec2(6u, 4u)) && allOk;
	allOk = compare_mat2x4(s[3].b[0], mat2x4(-1.0, 9.0, -4.0, -9.0, -3.0, -3.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(s[3].b[1], mat2x4(-4.0, 3.0, 8.0, 1.0, 6.0, 1.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat2x4(s[3].b[2], mat2x4(9.0, -2.0, -3.0, -3.0, -2.0, 8.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat2x4(s[3].b[3], mat2x4(6.0, -6.0, -3.0, -6.0, 0.0, -3.0, -1.0, 8.0)) && allOk;
	allOk = compare_vec3((s[3].c), vec3(5.0, 5.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	v = (5u);
	s[0].a = (uvec2(8u, 1u));
	s[0].b[0][0] = (vec4(-5.0, 1.0, 8.0, -2.0));
	s[0].b[0][1] = (vec4(-1.0, -5.0, -4.0, -2.0));
	s[0].b[1][0] = (vec4(0.0, 2.0, 6.0, 8.0));
	s[0].b[1][1] = (vec4(8.0, 8.0, 9.0, 9.0));
	s[0].b[2][0] = (vec4(-4.0, 4.0, -1.0, -8.0));
	s[0].b[2][1] = (vec4(7.0, 3.0, -6.0, 4.0));
	s[0].b[3][0] = (vec4(-9.0, -1.0, 8.0, 7.0));
	s[0].b[3][1] = (vec4(2.0, 7.0, -5.0, 3.0));
	s[0].c = (vec3(5.0, 9.0, -2.0));
	s[1].a = (uvec2(3u, 2u));
	s[1].b[0][0] = (vec4(-9.0, 7.0, -2.0, -2.0));
	s[1].b[0][1] = (vec4(9.0, 3.0, -8.0, -5.0));
	s[1].b[1][0] = (vec4(2.0, 9.0, 4.0, -2.0));
	s[1].b[1][1] = (vec4(-1.0, -6.0, -1.0, 1.0));
	s[1].b[2][0] = (vec4(-4.0, 6.0, 5.0, -4.0));
	s[1].b[2][1] = (vec4(4.0, -1.0, 1.0, -5.0));
	s[1].b[3][0] = (vec4(-4.0, -9.0, 1.0, -3.0));
	s[1].b[3][1] = (vec4(-1.0, 1.0, 2.0, -7.0));
	s[1].c = (vec3(-2.0, -3.0, -7.0));
	s[2].a = (uvec2(9u, 3u));
	s[2].b[0][0] = (vec4(-3.0, -9.0, -3.0, 0.0));
	s[2].b[0][1] = (vec4(4.0, 5.0, -8.0, 6.0));
	s[2].b[1][0] = (vec4(5.0, -3.0, 2.0, 0.0));
	s[2].b[1][1] = (vec4(1.0, 6.0, -2.0, -7.0));
	s[2].b[2][0] = (vec4(3.0, -6.0, -2.0, 2.0));
	s[2].b[2][1] = (vec4(5.0, -9.0, 3.0, -7.0));
	s[2].b[3][0] = (vec4(8.0, 5.0, -6.0, 4.0));
	s[2].b[3][1] = (vec4(1.0, -9.0, 6.0, 5.0));
	s[2].c = (vec3(-3.0, -6.0, -7.0));
	s[3].a = (uvec2(2u, 6u));
	s[3].b[0][0] = (vec4(-1.0, -5.0, 4.0, 8.0));
	s[3].b[0][1] = (vec4(2.0, 1.0, 2.0, -9.0));
	s[3].b[1][0] = (vec4(-5.0, -6.0, 1.0, 7.0));
	s[3].b[1][1] = (vec4(-8.0, 3.0, 0.0, -9.0));
	s[3].b[2][0] = (vec4(-8.0, -7.0, 5.0, -7.0));
	s[3].b[2][1] = (vec4(1.0, 3.0, -9.0, 8.0));
	s[3].b[3][0] = (vec4(5.0, -6.0, -7.0, 6.0));
	s[3].b[3][1] = (vec4(-7.0, 1.0, 8.0, -8.0));
	s[3].c = (vec3(-6.0, 8.0, 8.0));
}
#version 450
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
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((block[0].s[0][0].a), ivec3(4, 1, -8)) && allOk;
	allOk = compare_vec4((block[0].s[0][0].c), vec4(3.0, 7.0, -3.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[0].s[0][1].a), ivec3(-6, 9, 6)) && allOk;
	allOk = compare_vec4((block[0].s[0][1].c), vec4(-4.0, -1.0, -6.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1][0].a), ivec3(-7, -5, 1)) && allOk;
	allOk = compare_vec4((block[0].s[1][0].c), vec4(-8.0, -3.0, 3.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1][1].a), ivec3(2, -9, 6)) && allOk;
	allOk = compare_vec4((block[0].s[1][1].c), vec4(3.0, -3.0, 0.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2][0].a), ivec3(-7, 1, 8)) && allOk;
	allOk = compare_vec4((block[0].s[2][0].c), vec4(-1.0, 3.0, 8.0, -7.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2][1].a), ivec3(-1, -7, 0)) && allOk;
	allOk = compare_vec4((block[0].s[2][1].c), vec4(-7.0, 4.0, -9.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0][0].a), ivec3(-2, -4, 7)) && allOk;
	allOk = compare_vec4((block[1].s[0][0].c), vec4(-3.0, 5.0, 4.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0][1].a), ivec3(0, 2, -8)) && allOk;
	allOk = compare_vec4((block[1].s[0][1].c), vec4(3.0, 6.0, 4.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1][0].a), ivec3(-9, -2, 2)) && allOk;
	allOk = compare_vec4((block[1].s[1][0].c), vec4(2.0, -2.0, -3.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1][1].a), ivec3(2, -7, -6)) && allOk;
	allOk = compare_vec4((block[1].s[1][1].c), vec4(-4.0, -1.0, -5.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0][0].a), ivec3(7, -4, -7)) && allOk;
	allOk = compare_vec4((block[2].s[0][0].c), vec4(-1.0, 9.0, 7.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0][1].a), ivec3(9, 1, -6)) && allOk;
	allOk = compare_vec4((block[2].s[0][1].c), vec4(1.0, -1.0, 0.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].v = (vec4(-7.0, -8.0, 3.0, 7.0));
	block[0].s[0][0].a = (ivec3(5, 6, 5));
	block[0].s[0][0].c = (vec4(7.0, 9.0, 3.0, -5.0));
	block[0].s[0][1].a = (ivec3(1, -8, -8));
	block[0].s[0][1].c = (vec4(7.0, 9.0, -3.0, -5.0));
	block[0].s[1][0].a = (ivec3(4, 6, -7));
	block[0].s[1][0].c = (vec4(-5.0, 4.0, 3.0, -2.0));
	block[0].s[1][1].a = (ivec3(-4, 4, 0));
	block[0].s[1][1].c = (vec4(3.0, 6.0, 3.0, 5.0));
	block[0].s[2][0].a = (ivec3(9, 0, 5));
	block[0].s[2][0].c = (vec4(-3.0, -4.0, 1.0, 2.0));
	block[0].s[2][1].a = (ivec3(-5, 2, 0));
	block[0].s[2][1].c = (vec4(4.0, 3.0, -6.0, 8.0));
	block[1].v = (vec4(-6.0, 1.0, 8.0, -6.0));
	block[1].s[0][0].a = (ivec3(-3, -8, 9));
	block[1].s[0][0].c = (vec4(-2.0, 4.0, -6.0, 6.0));
	block[1].s[0][1].a = (ivec3(-7, -3, 7));
	block[1].s[0][1].c = (vec4(-5.0, 7.0, -5.0, 3.0));
	block[1].s[1][0].a = (ivec3(-8, 6, 2));
	block[1].s[1][0].c = (vec4(-4.0, -1.0, 3.0, 0.0));
	block[1].s[1][1].a = (ivec3(-6, 8, -3));
	block[1].s[1][1].c = (vec4(2.0, -9.0, -5.0, 9.0));
	block[2].v = (vec4(-1.0, -2.0, 5.0, -1.0));
	block[2].s[0][0].a = (ivec3(0, -2, -1));
	block[2].s[0][0].c = (vec4(4.0, 8.0, -2.0, -4.0));
	block[2].s[0][1].a = (ivec3(9, -5, -5));
	block[2].s[0][1].c = (vec4(-5.0, 4.0, -7.0, 5.0));
}
#version 450
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
	allOk = compare_ivec3((s[0][0].a), ivec3(6, 2, 2)) && allOk;
	allOk = compare_vec4((s[0][0].c), vec4(-8.0, 8.0, 0.0, 1.0)) && allOk;
	allOk = compare_ivec3((s[0][1].a), ivec3(6, 2, -1)) && allOk;
	allOk = compare_vec4((s[0][1].c), vec4(-9.0, -3.0, -8.0, -4.0)) && allOk;
	allOk = compare_ivec3((s[1][0].a), ivec3(-9, -7, -4)) && allOk;
	allOk = compare_vec4((s[1][0].c), vec4(2.0, 0.0, -7.0, 7.0)) && allOk;
	allOk = compare_ivec3((s[1][1].a), ivec3(4, 1, -3)) && allOk;
	allOk = compare_vec4((s[1][1].c), vec4(-3.0, 6.0, 1.0, 1.0)) && allOk;
	allOk = compare_ivec3((s[2][0].a), ivec3(-9, 4, -1)) && allOk;
	allOk = compare_vec4((s[2][0].c), vec4(-5.0, 1.0, -5.0, 1.0)) && allOk;
	allOk = compare_ivec3((s[2][1].a), ivec3(5, -5, -7)) && allOk;
	allOk = compare_vec4((s[2][1].c), vec4(0.0, 6.0, -9.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	v = (vec4(8.0, -7.0, -9.0, 5.0));
	s[0][0].a = (ivec3(2, 9, -9));
	s[0][0].c = (vec4(-2.0, 5.0, 1.0, 6.0));
	s[0][1].a = (ivec3(-9, 9, 9));
	s[0][1].c = (vec4(-6.0, -8.0, 4.0, -6.0));
	s[1][0].a = (ivec3(-9, 0, -3));
	s[1][0].c = (vec4(4.0, -5.0, -1.0, -2.0));
	s[1][1].a = (ivec3(-6, -5, 0));
	s[1][1].c = (vec4(-1.0, 8.0, -1.0, 6.0));
	s[2][0].a = (ivec3(7, -9, 8));
	s[2][0].c = (vec4(5.0, 3.0, -3.0, -2.0));
	s[2][1].a = (ivec3(4, 6, 5));
	s[2][1].c = (vec4(-2.0, 7.0, -9.0, -6.0));
}
#version 450
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

layout(std140, binding = 1) buffer Block
{
	u16vec4 var;
} block[3];

bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(block[0].var), uvec4(6u, 0u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block[1].var), uvec4(8u, 7u, 5u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(block[2].var), uvec4(8u, 7u, 1u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = u16vec4(uvec4(0u, 6u, 9u, 4u));
	block[1].var = u16vec4(uvec4(5u, 0u, 1u, 0u));
	block[2].var = u16vec4(uvec4(7u, 6u, 5u, 9u));
}
#version 450
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
	i16vec2 var;
} block[3];

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

layout(std430, binding = 1) buffer Block
{
	highp ivec2 var;
} block[3];

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((block[0].var), ivec2(6, -1)) && allOk;
	allOk = compare_ivec2((block[1].var), ivec2(7, -5)) && allOk;
	allOk = compare_ivec2((block[2].var), ivec2(-8, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (ivec2(-6, 8));
	block[1].var = (ivec2(3, -1));
	block[2].var = (ivec2(-5, -2));
}
#version 450
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
	allOk = compare_float(block[0].var[0][0], 2.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 9.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 7.0) && allOk;
	allOk = compare_float(block[0].var[0][3], -5.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 2.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 3.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 6.0) && allOk;
	allOk = compare_float(block[0].var[1][3], 6.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 9.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -9.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 1.0) && allOk;
	allOk = compare_float(block[0].var[2][3], -6.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(2.0, 9.0, 7.0, -5.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(2.0, 3.0, 6.0, 6.0)) && allOk;
	allOk = compare_vec4(block[0].var[2], vec4(9.0, -9.0, 1.0, -6.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], -4.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 6.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 9.0) && allOk;
	allOk = compare_float(block[1].var[0][3], 4.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 9.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 3.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 2.0) && allOk;
	allOk = compare_float(block[1].var[1][3], -4.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -7.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 0.0) && allOk;
	allOk = compare_float(block[1].var[2][2], 3.0) && allOk;
	allOk = compare_float(block[1].var[2][3], -9.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(-4.0, 6.0, 9.0, 4.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(9.0, 3.0, 2.0, -4.0)) && allOk;
	allOk = compare_vec4(block[1].var[2], vec4(-7.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 3.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -5.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 6.0) && allOk;
	allOk = compare_float(block[2].var[0][3], -3.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 3.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 2.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 7.0) && allOk;
	allOk = compare_float(block[2].var[1][3], -3.0) && allOk;
	allOk = compare_float(block[2].var[2][0], -7.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 0.0) && allOk;
	allOk = compare_float(block[2].var[2][2], 1.0) && allOk;
	allOk = compare_float(block[2].var[2][3], -9.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(3.0, -5.0, 6.0, -3.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(3.0, 2.0, 7.0, -3.0)) && allOk;
	allOk = compare_vec4(block[2].var[2], vec4(-7.0, 0.0, 1.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec4(8.0, 8.0, -2.0, 8.0));
	block[0].var[1] = (vec4(8.0, 3.0, 5.0, -5.0));
	block[0].var[2] = (vec4(7.0, 6.0, -9.0, 3.0));
	block[1].var[0] = (vec4(0.0, -3.0, 1.0, -9.0));
	block[1].var[1] = (vec4(-9.0, -6.0, -5.0, 1.0));
	block[1].var[2] = (vec4(9.0, 0.0, -9.0, -2.0));
	block[2].var[0] = (vec4(-4.0, -3.0, -1.0, -6.0));
	block[2].var[1] = (vec4(1.0, -2.0, -2.0, -1.0));
	block[2].var[2] = (vec4(-7.0, 8.0, 0.0, -6.0));
}
#version 450
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
	highp mat4x2 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(block[0].var, mat4x2(8.0, 1.0, 9.0, 3.0, -8.0, 3.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block[1].var, mat4x2(8.0, -6.0, -5.0, 7.0, -8.0, -2.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block[2].var, mat4x2(9.0, 4.0, 4.0, 4.0, 3.0, -6.0, -6.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat4x2(-9.0, -8.0, -8.0, 3.0, 8.0, 7.0, 0.0, 5.0));
	block[1].var = (mat4x2(5.0, 8.0, 8.0, 8.0, 6.0, -3.0, -6.0, -4.0));
	block[2].var = (mat4x2(-6.0, -9.0, 1.0, -1.0, 8.0, -7.0, 5.0, -3.0));
}
#version 450
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
	bool b[1];
	bool c;
} blockB;

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.b[0]), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
	blockB.b[0] = (false);
	blockB.c = (true);
}
#version 450
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
	highp vec4 a[1];
	lowp int b[1];
	lowp mat2 c;
	mediump uvec3 d;
	mediump ivec3 e;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((b[0]), 0) && allOk;
	allOk = compare_mat2(c, mat2(-7.0, -2.0, 7.0, 3.0)) && allOk;
	allOk = compare_uvec3((d), uvec3(8u, 5u, 1u)) && allOk;
	allOk = compare_ivec3((e), ivec3(-2, 0, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (vec4(8.0, 9.0, -5.0, 5.0));
	c = (mat2(2.0, 9.0, -1.0, -3.0));
	d = (uvec3(6u, 5u, 3u));
}
#version 450
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
struct sB
{
	highp mat4x3 mA;
	sA mB;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	highp ivec2 a[];
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	lowp mat4 b;
	mediump mat4 c;
	mediump mat3x2 d[1];
	sB e[];
};
layout(std430, binding = 3) buffer BlockD
{
	highp uvec3 f;
	bvec4 g;
	lowp float h;
	highp uint i[1];
	lowp int j[];
} blockD;
layout(std140, row_major, binding = 4) buffer BlockE
{
	bvec3 k;
	lowp uvec2 l;
	mediump mat2x3 m[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a[0]), ivec2(2, -8)) && allOk;
	allOk = compare_mat3x2(d[0], mat3x2(-3.0, 8.0, 6.0, -4.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(e[0].mA, mat4x3(5.0, 8.0, -9.0, -5.0, -1.0, -8.0, 9.0, 7.0, -8.0, 5.0, -1.0, 1.0)) && allOk;
	allOk = compare_uvec4((e[0].mB.mA), uvec4(3u, 3u, 8u, 5u)) && allOk;
	allOk = compare_uint((blockD.i[0]), 5u) && allOk;
	allOk = compare_int((blockD.j[0]), 1) && allOk;
	allOk = compare_bvec3((k), bvec3(false, true, false)) && allOk;
	allOk = compare_uvec2((l), uvec2(9u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (ivec2(8, -2));
	b = (mat4(-1.0, -6.0, 6.0, 0.0, 9.0, 5.0, 4.0, 8.0, 6.0, 7.0, -5.0, 5.0, -2.0, 7.0, 4.0, 7.0));
	d[0] = (mat3x2(8.0, -6.0, -7.0, -1.0, 4.0, -7.0));
	e[0].mA = (mat4x3(2.0, -1.0, 4.0, -6.0, 5.0, -5.0, -1.0, -2.0, -3.0, -7.0, 8.0, -6.0));
	e[0].mB.mA = (uvec4(7u, 1u, 0u, 4u));
	blockD.f = (uvec3(8u, 5u, 7u));
	blockD.h = (-6.0);
	blockD.i[0] = (5u);
	k = (bvec3(true, true, false));
	l = (uvec2(7u, 3u));
}
#version 450
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
	mediump mat3x4 mA[3];
	lowp mat2 mB;
};
struct sB
{
	lowp mat2x3 mA;
	lowp uvec2 mB;
};
layout(std430, row_major, binding = 1) buffer BlockB
{
	highp uint a;
	mediump mat2 b;
	mediump mat2x3 c;
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	lowp mat3x2 d;
} blockC;
layout(std140, row_major, binding = 3) buffer BlockD
{
	highp ivec4 e;
	sA f;
	highp ivec2 g;
	sB h[];
};
layout(std430, binding = 4) buffer BlockE
{
	lowp mat3x4 i;
	mediump mat3x4 j;
	lowp uvec2 k;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 5u) && allOk;
	allOk = compare_mat3x2(blockC.d, mat3x2(9.0, 2.0, -2.0, 0.0, -9.0, -9.0)) && allOk;
	allOk = compare_ivec2((g), ivec2(6, -9)) && allOk;
	allOk = compare_mat2x3(h[0].mA, mat2x3(-1.0, 5.0, -9.0, -3.0, 1.0, -6.0)) && allOk;
	allOk = compare_uvec2((h[0].mB), uvec2(1u, 9u)) && allOk;
	allOk = compare_mat2x3(h[1].mA, mat2x3(-5.0, -6.0, -6.0, -8.0, -8.0, 0.0)) && allOk;
	allOk = compare_uvec2((h[1].mB), uvec2(8u, 5u)) && allOk;
	allOk = compare_mat2x3(h[2].mA, mat2x3(-1.0, 0.0, 5.0, 7.0, 1.0, -1.0)) && allOk;
	allOk = compare_uvec2((h[2].mB), uvec2(6u, 5u)) && allOk;
	allOk = compare_mat3x4(blockE.j, mat3x4(8.0, -6.0, 6.0, 0.0, -1.0, 0.0, -2.0, -4.0, -9.0, 8.0, -1.0, -9.0)) && allOk;
	allOk = compare_uvec2((blockE.k), uvec2(4u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (3u);
	blockB.b = (mat2(-7.0, -2.0, 3.0, 2.0));
	blockB.c = (mat2x3(-7.0, 6.0, 8.0, 4.0, -8.0, -3.0));
	blockC.d = (mat3x2(3.0, 6.0, -3.0, 9.0, -1.0, 5.0));
	g = (ivec2(-7, -6));
	h[0].mA = (mat2x3(-2.0, 9.0, -9.0, -6.0, 9.0, 5.0));
	h[0].mB = (uvec2(2u, 1u));
	h[1].mA = (mat2x3(-3.0, -9.0, 6.0, 9.0, -7.0, 9.0));
	h[1].mB = (uvec2(1u, 5u));
	h[2].mA = (mat2x3(0.0, 5.0, 0.0, 4.0, -3.0, 5.0));
	h[2].mB = (uvec2(1u, 6u));
	blockE.i = (mat3x4(7.0, -2.0, -1.0, -5.0, -6.0, -6.0, 2.0, 5.0, 9.0, -4.0, -6.0, -4.0));
	blockE.k = (uvec2(2u, 5u));
}
#version 450
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
	lowp vec3 mB;
	lowp ivec3 mC;
	highp ivec4 mD[8];
};
layout(std140, binding = 1) buffer BlockB
{
	mediump ivec2 a[8];
	mediump int b;
	sA c;
	mediump ivec2 d[];
};
layout(std140, binding = 2) buffer BlockC
{
	mediump mat2 e[];
};
layout(std140, row_major, binding = 3) buffer BlockD
{
	mediump uvec2 f;
	bool g;
	mediump mat2x3 h[];
} blockD;
layout(std430, binding = 4) buffer BlockE
{
	highp ivec4 i;
	mediump uint j[7];
	mediump mat4x3 k;
	lowp int l;
	lowp mat3x4 m[];
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
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((a[0]), ivec2(2, 5)) && allOk;
	allOk = compare_ivec2((a[1]), ivec2(9, -9)) && allOk;
	allOk = compare_ivec2((a[2]), ivec2(-9, -4)) && allOk;
	allOk = compare_ivec2((a[3]), ivec2(4, 5)) && allOk;
	allOk = compare_ivec2((a[4]), ivec2(3, 7)) && allOk;
	allOk = compare_ivec2((a[5]), ivec2(5, 1)) && allOk;
	allOk = compare_ivec2((a[6]), ivec2(-2, 6)) && allOk;
	allOk = compare_ivec2((a[7]), ivec2(3, -6)) && allOk;
	allOk = compare_ivec3((c.mA), ivec3(-9, 3, 8)) && allOk;
	allOk = compare_vec3((c.mB), vec3(8.0, -6.0, 2.0)) && allOk;
	allOk = compare_ivec3((c.mC), ivec3(-6, -8, 9)) && allOk;
	allOk = compare_ivec4((c.mD[0]), ivec4(-9, 8, -6, -5)) && allOk;
	allOk = compare_ivec4((c.mD[1]), ivec4(-9, -3, -5, 3)) && allOk;
	allOk = compare_ivec4((c.mD[2]), ivec4(0, 7, 8, -9)) && allOk;
	allOk = compare_ivec4((c.mD[3]), ivec4(-4, 1, 1, -4)) && allOk;
	allOk = compare_ivec4((c.mD[4]), ivec4(-5, -1, 2, 4)) && allOk;
	allOk = compare_ivec4((c.mD[5]), ivec4(-2, 2, -1, 8)) && allOk;
	allOk = compare_ivec4((c.mD[6]), ivec4(-8, 9, -3, 8)) && allOk;
	allOk = compare_ivec4((c.mD[7]), ivec4(-1, -8, -7, 4)) && allOk;
	allOk = compare_mat2(e[0], mat2(-8.0, 8.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat2(e[1], mat2(1.0, -6.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat2(e[2], mat2(9.0, -5.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat2(e[3], mat2(-6.0, 1.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat2(e[4], mat2(1.0, -6.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat2(e[5], mat2(-8.0, 0.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat2(e[6], mat2(-8.0, -1.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat2(e[7], mat2(-8.0, -2.0, 8.0, 7.0)) && allOk;
	allOk = compare_uvec2((blockD.f), uvec2(1u, 1u)) && allOk;
	allOk = compare_mat2x3(blockD.h[0], mat2x3(4.0, 6.0, -7.0, -9.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(blockD.h[1], mat2x3(9.0, -8.0, 3.0, -7.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat2x3(blockD.h[2], mat2x3(9.0, -7.0, -3.0, -8.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2x3(blockD.h[3], mat2x3(-6.0, 8.0, -7.0, 0.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat2x3(blockD.h[4], mat2x3(-3.0, 8.0, -6.0, -8.0, 4.0, 2.0)) && allOk;
	allOk = compare_ivec4((i), ivec4(8, 2, -1, 0)) && allOk;
	allOk = compare_mat3x4(m[0], mat3x4(0.0, 2.0, 6.0, -4.0, -4.0, 0.0, -5.0, 5.0, -2.0, 5.0, -3.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (-1);
	c.mA = (ivec3(9, 2, 3));
	c.mB = (vec3(-2.0, 9.0, -6.0));
	c.mC = (ivec3(3, 5, 5));
	c.mD[0] = (ivec4(9, 3, -9, -1));
	c.mD[1] = (ivec4(-5, -8, 3, 0));
	c.mD[2] = (ivec4(-6, -8, -3, 8));
	c.mD[3] = (ivec4(2, -4, 6, 9));
	c.mD[4] = (ivec4(9, -1, -2, 8));
	c.mD[5] = (ivec4(7, -5, -2, -3));
	c.mD[6] = (ivec4(-4, 3, 1, -2));
	c.mD[7] = (ivec4(-3, -9, 9, -1));
	e[0] = (mat2(8.0, -3.0, 8.0, 5.0));
	e[1] = (mat2(0.0, 1.0, 2.0, 6.0));
	e[2] = (mat2(8.0, 2.0, -3.0, -3.0));
	e[3] = (mat2(-6.0, -5.0, 3.0, 3.0));
	e[4] = (mat2(0.0, -4.0, -9.0, 0.0));
	e[5] = (mat2(-3.0, -8.0, 8.0, -7.0));
	e[6] = (mat2(-7.0, 8.0, -9.0, 4.0));
	e[7] = (mat2(-4.0, -1.0, 6.0, -7.0));
	blockD.f = (uvec2(4u, 1u));
	blockD.g = (false);
	blockD.h[0] = (mat2x3(-5.0, -4.0, 4.0, 1.0, 8.0, -7.0));
	blockD.h[1] = (mat2x3(-8.0, -8.0, -9.0, 6.0, 6.0, 0.0));
	blockD.h[2] = (mat2x3(-6.0, -5.0, 5.0, -3.0, 3.0, -5.0));
	blockD.h[3] = (mat2x3(7.0, -9.0, -8.0, 0.0, -9.0, 9.0));
	blockD.h[4] = (mat2x3(3.0, 7.0, -9.0, 7.0, -1.0, -3.0));
	i = (ivec4(-2, -4, 2, 0));
	j[0] = (4u);
	j[1] = (7u);
	j[2] = (2u);
	j[3] = (4u);
	j[4] = (3u);
	j[5] = (2u);
	j[6] = (4u);
	l = (-6);
}
#version 450
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
	mediump mat3 mB;
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	mediump int a[];
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	sA b;
	mediump float c[1];
	highp vec4 d;
	lowp ivec4 e[];
};
layout(std430, column_major, binding = 3) buffer BlockD
{
	highp mat3x2 f;
	highp ivec3 g[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.a[0]), 2) && allOk;
	allOk = compare_uvec4((b.mA), uvec4(3u, 5u, 9u, 3u)) && allOk;
	allOk = compare_mat3(b.mB, mat3(-7.0, 7.0, -2.0, 3.0, 9.0, 1.0, -5.0, -2.0, 0.0)) && allOk;
	allOk = compare_float((c[0]), 9.0) && allOk;
	allOk = compare_ivec4((e[0]), ivec4(6, 1, -6, 0)) && allOk;
	allOk = compare_mat3x2(blockD.f, mat3x2(2.0, 5.0, 6.0, 4.0, 1.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (8);
	c[0] = (-2.0);
	d = (vec4(-8.0, -6.0, 9.0, 4.0));
	e[0] = (ivec4(-5, 5, -1, 4));
	blockD.f = (mat3x2(-7.0, 5.0, -6.0, 4.0, -3.0, 9.0));
}
#version 450
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
	highp vec2 mB;
	lowp mat2x3 mC;
	lowp uvec3 mD;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	bvec2 a;
	mediump ivec4 b;
	sA c;
	lowp uvec2 d;
	highp uvec2 e[];
};
layout(std430, binding = 2) buffer BlockC
{
	bool f;
	highp vec2 g;
	lowp vec4 h[];
} blockC[3];
layout(std140, column_major, binding = 3) buffer BlockD
{
	bvec2 i;
	mediump ivec4 j;
	bool k[5];
	highp ivec3 l[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((b), ivec4(-5, 0, 3, 7)) && allOk;
	allOk = compare_uvec2((d), uvec2(7u, 8u)) && allOk;
	allOk = compare_vec4((blockC[0].h[0]), vec4(-6.0, 7.0, -7.0, 9.0)) && allOk;
	allOk = compare_vec4((blockC[0].h[1]), vec4(-2.0, 7.0, 6.0, 3.0)) && allOk;
	allOk = compare_vec4((blockC[0].h[2]), vec4(-8.0, -8.0, 0.0, 6.0)) && allOk;
	allOk = compare_vec4((blockC[0].h[3]), vec4(7.0, 2.0, -4.0, -9.0)) && allOk;
	allOk = compare_vec4((blockC[0].h[4]), vec4(-8.0, 2.0, -3.0, 6.0)) && allOk;
	allOk = compare_vec4((blockC[0].h[5]), vec4(1.0, 7.0, 8.0, -4.0)) && allOk;
	allOk = compare_vec4((blockC[0].h[6]), vec4(-7.0, 9.0, 8.0, 4.0)) && allOk;
	allOk = compare_vec4((blockC[0].h[7]), vec4(-3.0, 0.0, -9.0, 7.0)) && allOk;
	allOk = compare_vec4((blockC[1].h[0]), vec4(0.0, -1.0, 4.0, -9.0)) && allOk;
	allOk = compare_vec4((blockC[1].h[1]), vec4(3.0, -6.0, 5.0, 9.0)) && allOk;
	allOk = compare_vec4((blockC[1].h[2]), vec4(7.0, 7.0, -4.0, 1.0)) && allOk;
	allOk = compare_vec4((blockC[1].h[3]), vec4(1.0, -2.0, -5.0, -6.0)) && allOk;
	allOk = compare_vec4((blockC[1].h[4]), vec4(-9.0, 1.0, 2.0, 2.0)) && allOk;
	allOk = compare_vec4((blockC[1].h[5]), vec4(1.0, -5.0, 9.0, -6.0)) && allOk;
	allOk = compare_vec4((blockC[2].h[0]), vec4(9.0, 4.0, 7.0, 7.0)) && allOk;
	allOk = compare_vec4((blockC[2].h[1]), vec4(1.0, 5.0, -6.0, -1.0)) && allOk;
	allOk = compare_bvec2((i), bvec2(false, true)) && allOk;
	allOk = compare_ivec3((l[0]), ivec3(5, -2, 6)) && allOk;
	allOk = compare_ivec3((l[1]), ivec3(-9, -8, -9)) && allOk;
	allOk = compare_ivec3((l[2]), ivec3(6, 8, -4)) && allOk;
	allOk = compare_ivec3((l[3]), ivec3(-1, -5, 4)) && allOk;
	allOk = compare_ivec3((l[4]), ivec3(-3, -2, -3)) && allOk;
	allOk = compare_ivec3((l[5]), ivec3(9, 8, 6)) && allOk;
	allOk = compare_ivec3((l[6]), ivec3(4, -3, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

	c.mA = (vec2(-6.0, 3.0));
	c.mB = (vec2(5.0, -8.0));
	c.mC = (mat2x3(-7.0, 3.0, -9.0, -8.0, -6.0, 9.0));
	c.mD = (uvec3(3u, 7u, 3u));
	d = (uvec2(5u, 5u));
	e[0] = (uvec2(6u, 7u));
	e[1] = (uvec2(2u, 5u));
	e[2] = (uvec2(6u, 5u));
	e[3] = (uvec2(7u, 8u));
	e[4] = (uvec2(3u, 0u));
	blockC[0].g = (vec2(-3.0, 2.0));
	blockC[1].g = (vec2(-4.0, 9.0));
	blockC[2].g = (vec2(7.0, -8.0));
	i = (bvec2(true, true));
	j = (ivec4(7, 8, -1, -8));
	k[0] = (false);
	k[1] = (false);
	k[2] = (true);
	k[3] = (false);
	k[4] = (false);
	l[0] = (ivec3(-3, -5, -3));
	l[1] = (ivec3(-7, -7, -7));
	l[2] = (ivec3(0, 7, 2));
	l[3] = (ivec3(3, 9, 9));
	l[4] = (ivec3(2, -9, -8));
	l[5] = (ivec3(-1, 1, -8));
	l[6] = (ivec3(1, -6, 1));
}
#version 450
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
	mediump float mA;
	lowp mat4x2 mB;
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	lowp uvec4 a;
	highp mat3x2 b;
	sA c[4];
	highp mat3x4 d;
	bvec4 e;
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	mediump mat4x2 f;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a), uvec4(8u, 5u, 4u, 9u)) && allOk;
	allOk = compare_float((blockB.c[0].mA), 1.0) && allOk;
	allOk = compare_mat4x2(blockB.c[0].mB, mat4x2(9.0, 8.0, 3.0, 7.0, 5.0, -6.0, 5.0, -9.0)) && allOk;
	allOk = compare_float((blockB.c[1].mA), 5.0) && allOk;
	allOk = compare_mat4x2(blockB.c[1].mB, mat4x2(-2.0, 4.0, -1.0, -1.0, -5.0, 2.0, -6.0, 8.0)) && allOk;
	allOk = compare_float((blockB.c[2].mA), 1.0) && allOk;
	allOk = compare_mat4x2(blockB.c[2].mB, mat4x2(-7.0, -4.0, -7.0, -2.0, 2.0, 7.0, 8.0, -1.0)) && allOk;
	allOk = compare_float((blockB.c[3].mA), -6.0) && allOk;
	allOk = compare_mat4x2(blockB.c[3].mB, mat4x2(5.0, 9.0, -1.0, 5.0, -9.0, 2.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x4(blockB.d, mat3x4(-3.0, -9.0, -2.0, 5.0, -8.0, -9.0, -5.0, -1.0, 5.0, 8.0, -5.0, 7.0)) && allOk;
	allOk = compare_bvec4((blockB.e), bvec4(true, false, false, true)) && allOk;
	allOk = compare_mat4x2(f, mat4x2(-4.0, 8.0, -2.0, -4.0, -8.0, -4.0, 7.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec4(8u, 5u, 4u, 8u));
	blockB.b = (mat3x2(-2.0, 7.0, -7.0, -6.0, -5.0, -9.0));
	blockB.d = (mat3x4(-2.0, 2.0, -6.0, 0.0, -6.0, -6.0, -4.0, -9.0, 4.0, -5.0, 8.0, 8.0));
	blockB.e = (bvec4(false, false, true, true));
	f = (mat4x2(7.0, -1.0, 3.0, 2.0, -8.0, 9.0, -3.0, 8.0));
}
#version 450
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
	layout(offset = 0) mediump ivec2 a;
	layout(offset = 16) lowp vec3 b;
	layout(offset = 32) highp vec2 c[1];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a), ivec2(-2, 4)) && allOk;
	allOk = compare_vec3((blockB.b), vec3(8.0, -9.0, 4.0)) && allOk;
	allOk = compare_vec2((blockB.c[0]), vec2(7.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec2(7, -6));
}
#version 450
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
	layout(offset = 0) mediump uint a[1];
	layout(offset = 4) lowp float b;
} blockB[2];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) lowp uvec3 c;
	layout(offset = 12) lowp uint d;
} blockC[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB[0].a[0]), 3u) && allOk;
	allOk = compare_float((blockB[0].b), -7.0) && allOk;
	allOk = compare_uint((blockB[1].a[0]), 1u) && allOk;
	allOk = compare_float((blockB[1].b), 4.0) && allOk;
	allOk = compare_uvec3((blockC[0].c), uvec3(6u, 1u, 8u)) && allOk;
	allOk = compare_uint((blockC[0].d), 4u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (5u);
	blockB[1].a[0] = (0u);
	blockC[0].c = (uvec3(1u, 7u, 4u));
	blockC[0].d = (1u);
}
#version 450
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
	highp uint a;
	lowp mat2x3 b;
	bvec4 c;
	mediump vec3 d[];
} blockB;
layout(scalar, column_major, binding = 2) buffer BlockC
{
	mediump vec4 e;
	highp ivec2 f;
	mediump vec2 g[];
} blockC;
layout(scalar, binding = 3) buffer BlockD
{
	bvec3 h[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB.b, mat2x3(-5.0, -9.0, -5.0, 1.0, -7.0, 1.0)) && allOk;
	allOk = compare_vec3((blockB.d[0]), vec3(6.0, -5.0, 7.0)) && allOk;
	allOk = compare_vec3((blockB.d[1]), vec3(3.0, -3.0, 7.0)) && allOk;
	allOk = compare_vec3((blockB.d[2]), vec3(4.0, -2.0, 9.0)) && allOk;
	allOk = compare_vec3((blockB.d[3]), vec3(2.0, -5.0, 1.0)) && allOk;
	allOk = compare_vec3((blockB.d[4]), vec3(-6.0, 8.0, 5.0)) && allOk;
	allOk = compare_vec3((blockB.d[5]), vec3(5.0, -3.0, 3.0)) && allOk;
	allOk = compare_vec3((blockB.d[6]), vec3(1.0, -9.0, 7.0)) && allOk;
	allOk = compare_vec4((blockC.e), vec4(-2.0, 2.0, 9.0, -3.0)) && allOk;
	allOk = compare_ivec2((blockC.f), ivec2(3, 1)) && allOk;
	allOk = compare_vec2((blockC.g[0]), vec2(1.0, -9.0)) && allOk;
	allOk = compare_vec2((blockC.g[1]), vec2(-3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (5u);
	blockB.b = (mat2x3(7.0, -5.0, -4.0, -8.0, -5.0, 0.0));
	blockB.c = (bvec4(true, true, true, false));
	blockB.d[0] = (vec3(3.0, 8.0, 8.0));
	blockB.d[1] = (vec3(0.0, 8.0, -6.0));
	blockB.d[2] = (vec3(5.0, 1.0, 7.0));
	blockB.d[3] = (vec3(-1.0, -9.0, -2.0));
	blockB.d[4] = (vec3(-7.0, -5.0, 7.0));
	blockB.d[5] = (vec3(-9.0, -5.0, 5.0));
	blockB.d[6] = (vec3(3.0, 7.0, -7.0));
	blockC.e = (vec4(-6.0, 1.0, 8.0, 8.0));
	blockC.f = (ivec2(-9, -8));
	blockC.g[0] = (vec2(4.0, 8.0));
	blockC.g[1] = (vec2(5.0, 3.0));
	blockD.h[0] = (bvec3(true, false, false));
	blockD.h[1] = (bvec3(false, true, false));
}
#version 450
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
	mediump mat4 mA;
	highp int mB;
	bool mC;
	lowp ivec4 mD;
};
struct sB
{
	highp uvec2 mA;
};
struct sC
{
	sA mA;
	mediump mat3 mB;
	sB mC;
	lowp mat2x3 mD;
};
struct sD
{
	bvec2 mA;
	lowp mat4 mB;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	highp float a;
};
layout(scalar, column_major, binding = 2) buffer BlockC
{
	sC b;
	lowp vec3 c;
	mediump mat3x4 d;
	lowp vec3 e;
	lowp int f[];
} blockC;
layout(scalar, row_major, binding = 3) buffer BlockD
{
	highp vec2 g;
	mediump mat3x4 h;
	mediump int i[];
} blockD;
layout(scalar, column_major, binding = 4) buffer BlockE
{
	lowp uvec3 j;
	mediump vec3 k;
	sD l;
	highp uvec4 m;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((a), -9.0) && allOk;
	allOk = compare_mat4(blockC.b.mA.mA, mat4(1.0, 0.0, -9.0, 6.0, 8.0, -2.0, 2.0, -1.0, 1.0, -9.0, 4.0, -2.0, -4.0, -1.0, -2.0, 4.0)) && allOk;
	allOk = compare_int((blockC.b.mA.mB), 3) && allOk;
	allOk = compare_bool((blockC.b.mA.mC), false) && allOk;
	allOk = compare_ivec4((blockC.b.mA.mD), ivec4(6, -7, -4, 6)) && allOk;
	allOk = compare_mat3(blockC.b.mB, mat3(7.0, 7.0, 4.0, -6.0, -8.0, 6.0, 6.0, -1.0, 0.0)) && allOk;
	allOk = compare_uvec2((blockC.b.mC.mA), uvec2(0u, 1u)) && allOk;
	allOk = compare_mat2x3(blockC.b.mD, mat2x3(3.0, 4.0, 9.0, 2.0, -3.0, 4.0)) && allOk;
	allOk = compare_vec3((blockC.c), vec3(7.0, -7.0, -7.0)) && allOk;
	allOk = compare_vec2((blockD.g), vec2(8.0, 7.0)) && allOk;
	allOk = compare_uvec3((blockE.j), uvec3(4u, 8u, 4u)) && allOk;
	allOk = compare_bvec2((blockE.l.mA), bvec2(true, true)) && allOk;
	allOk = compare_mat4(blockE.l.mB, mat4(-3.0, -1.0, -2.0, 1.0, 0.0, -7.0, 8.0, 9.0, -4.0, 5.0, 8.0, 0.0, 8.0, 9.0, -2.0, -3.0)) && allOk;
	allOk = compare_uvec4((blockE.m), uvec4(2u, 0u, 3u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (-4.0);
	blockC.c = (vec3(1.0, 8.0, -1.0));
	blockC.d = (mat3x4(7.0, 6.0, 5.0, 2.0, 9.0, -9.0, -8.0, 7.0, -8.0, 6.0, -3.0, 9.0));
	blockC.e = (vec3(4.0, 9.0, 0.0));
	blockC.f[0] = (-7);
	blockC.f[1] = (0);
	blockC.f[2] = (4);
	blockC.f[3] = (-4);
	blockD.g = (vec2(-6.0, 5.0));
	blockD.h = (mat3x4(0.0, -6.0, 9.0, 1.0, -4.0, -9.0, -6.0, -8.0, -2.0, -7.0, 6.0, -4.0));
	blockE.j = (uvec3(2u, 2u, 9u));
	blockE.k = (vec3(7.0, 9.0, 1.0));
}
#version 450
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
	bvec4 mA[1];
	highp uint mB;
	lowp mat2x3 mC;
};
layout(scalar, row_major, binding = 1) buffer BlockB
{
	lowp ivec2 a;
	bvec4 b[];
} blockB;
layout(scalar, row_major, binding = 2) buffer BlockC
{
	sA c;
	highp vec4 d;
	bvec2 e[][5];
} blockC[2];
layout(scalar, row_major, binding = 3) buffer BlockD
{
	highp mat4 f;
	highp uvec4 g;
	highp ivec3 h;
	bvec2 i[];
} blockD[3];
layout(scalar, binding = 4) buffer BlockE
{
	highp vec3 j;
	bool k;
	mediump uvec3 l[];
} blockE[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a), ivec2(9, -9)) && allOk;
	allOk = compare_bvec4((blockC[0].c.mA[0]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_uint((blockC[0].c.mB), 8u) && allOk;
	allOk = compare_mat2x3(blockC[0].c.mC, mat2x3(-4.0, -5.0, 8.0, -6.0, -7.0, -3.0)) && allOk;
	allOk = compare_vec4((blockC[0].d), vec4(3.0, 6.0, 5.0, -7.0)) && allOk;
	allOk = compare_bvec4((blockC[1].c.mA[0]), bvec4(false, false, true, true)) && allOk;
	allOk = compare_uint((blockC[1].c.mB), 8u) && allOk;
	allOk = compare_mat2x3(blockC[1].c.mC, mat2x3(8.0, -6.0, -1.0, 1.0, 8.0, -5.0)) && allOk;
	allOk = compare_vec4((blockC[1].d), vec4(7.0, -3.0, -1.0, -7.0)) && allOk;
	allOk = compare_uvec4((blockD[0].g), uvec4(1u, 1u, 6u, 2u)) && allOk;
	allOk = compare_ivec3((blockD[0].h), ivec3(2, -9, 8)) && allOk;
	allOk = compare_bvec2((blockD[0].i[0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockD[0].i[1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockD[0].i[2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockD[0].i[3]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockD[0].i[4]), bvec2(false, true)) && allOk;
	allOk = compare_uvec4((blockD[1].g), uvec4(2u, 8u, 9u, 1u)) && allOk;
	allOk = compare_ivec3((blockD[1].h), ivec3(-2, -7, -2)) && allOk;
	allOk = compare_bvec2((blockD[1].i[0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockD[1].i[1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockD[1].i[2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockD[1].i[3]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockD[1].i[4]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockD[1].i[5]), bvec2(true, false)) && allOk;
	allOk = compare_uvec4((blockD[2].g), uvec4(5u, 9u, 0u, 9u)) && allOk;
	allOk = compare_ivec3((blockD[2].h), ivec3(-9, 0, 3)) && allOk;
	allOk = compare_bvec2((blockD[2].i[0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockD[2].i[1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockD[2].i[2]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockD[2].i[3]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockD[2].i[4]), bvec2(false, true)) && allOk;
	allOk = compare_vec3((blockE[0].j), vec3(-6.0, -6.0, -4.0)) && allOk;
	allOk = compare_uvec3((blockE[0].l[0]), uvec3(9u, 1u, 3u)) && allOk;
	allOk = compare_uvec3((blockE[0].l[1]), uvec3(6u, 9u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (bvec4(true, true, true, false));
	blockB.b[1] = (bvec4(true, true, false, false));
	blockB.b[2] = (bvec4(false, false, true, false));
	blockB.b[3] = (bvec4(true, false, false, false));
	blockB.b[4] = (bvec4(true, true, false, false));
	blockB.b[5] = (bvec4(false, false, false, true));
	blockB.b[6] = (bvec4(true, false, false, false));
	blockB.b[7] = (bvec4(false, false, false, true));
	blockC[0].c.mA[0] = (bvec4(false, true, true, false));
	blockC[0].c.mB = (1u);
	blockC[0].c.mC = (mat2x3(-3.0, -3.0, 8.0, 8.0, 5.0, 6.0));
	blockC[0].e[0][0] = (bvec2(true, true));
	blockC[0].e[0][1] = (bvec2(true, true));
	blockC[0].e[0][2] = (bvec2(false, false));
	blockC[0].e[0][3] = (bvec2(false, true));
	blockC[0].e[0][4] = (bvec2(true, false));
	blockC[0].e[1][0] = (bvec2(true, true));
	blockC[0].e[1][1] = (bvec2(false, true));
	blockC[0].e[1][2] = (bvec2(true, true));
	blockC[0].e[1][3] = (bvec2(true, false));
	blockC[0].e[1][4] = (bvec2(true, true));
	blockC[0].e[2][0] = (bvec2(true, true));
	blockC[0].e[2][1] = (bvec2(false, false));
	blockC[0].e[2][2] = (bvec2(true, false));
	blockC[0].e[2][3] = (bvec2(false, true));
	blockC[0].e[2][4] = (bvec2(true, true));
	blockC[0].e[3][0] = (bvec2(true, false));
	blockC[0].e[3][1] = (bvec2(false, true));
	blockC[0].e[3][2] = (bvec2(true, true));
	blockC[0].e[3][3] = (bvec2(true, true));
	blockC[0].e[3][4] = (bvec2(true, false));
	blockC[1].c.mA[0] = (bvec4(false, false, true, true));
	blockC[1].c.mB = (5u);
	blockC[1].c.mC = (mat2x3(5.0, -5.0, 9.0, 9.0, 0.0, -3.0));
	blockC[1].e[0][0] = (bvec2(false, true));
	blockC[1].e[0][1] = (bvec2(true, false));
	blockC[1].e[0][2] = (bvec2(false, true));
	blockC[1].e[0][3] = (bvec2(true, true));
	blockC[1].e[0][4] = (bvec2(true, true));
	blockC[1].e[1][0] = (bvec2(true, false));
	blockC[1].e[1][1] = (bvec2(false, false));
	blockC[1].e[1][2] = (bvec2(true, false));
	blockC[1].e[1][3] = (bvec2(true, true));
	blockC[1].e[1][4] = (bvec2(false, false));
	blockC[1].e[2][0] = (bvec2(true, false));
	blockC[1].e[2][1] = (bvec2(true, false));
	blockC[1].e[2][2] = (bvec2(false, true));
	blockC[1].e[2][3] = (bvec2(true, false));
	blockC[1].e[2][4] = (bvec2(false, true));
	blockC[1].e[3][0] = (bvec2(false, true));
	blockC[1].e[3][1] = (bvec2(false, true));
	blockC[1].e[3][2] = (bvec2(true, false));
	blockC[1].e[3][3] = (bvec2(true, false));
	blockC[1].e[3][4] = (bvec2(false, true));
	blockC[1].e[4][0] = (bvec2(true, false));
	blockC[1].e[4][1] = (bvec2(false, true));
	blockC[1].e[4][2] = (bvec2(false, true));
	blockC[1].e[4][3] = (bvec2(false, false));
	blockC[1].e[4][4] = (bvec2(false, false));
	blockC[1].e[5][0] = (bvec2(true, true));
	blockC[1].e[5][1] = (bvec2(true, false));
	blockC[1].e[5][2] = (bvec2(false, false));
	blockC[1].e[5][3] = (bvec2(false, false));
	blockC[1].e[5][4] = (bvec2(true, true));
	blockD[0].g = (uvec4(9u, 6u, 6u, 8u));
	blockD[0].h = (ivec3(0, 7, 1));
	blockD[1].g = (uvec4(7u, 9u, 9u, 7u));
	blockD[1].h = (ivec3(-4, -6, 3));
	blockD[2].g = (uvec4(6u, 2u, 6u, 4u));
	blockD[2].h = (ivec3(5, 8, -8));
	blockE[0].j = (vec3(-1.0, -8.0, 0.0));
}
#version 450
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
	mediump mat3x2 a[];
};
layout(scalar, row_major, binding = 2) buffer BlockC
{
	highp mat4x2 b;
	lowp mat4x2 c;
} blockC;
layout(scalar, row_major, binding = 3) buffer BlockD
{
	lowp float d;
	mediump mat3x2 e;
	lowp mat2x3 f[];
} blockD;
layout(scalar, binding = 4) buffer BlockE
{
	mediump ivec4 g;
	bvec2 h;
	lowp mat3x2 i[6];
	lowp ivec4 j[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockC.c, mat4x2(1.0, -1.0, 5.0, 3.0, -1.0, -6.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2x3(blockD.f[0], mat2x3(-2.0, 9.0, -3.0, -4.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x3(blockD.f[1], mat2x3(-4.0, 1.0, -8.0, 5.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat2x3(blockD.f[2], mat2x3(5.0, -9.0, -9.0, 2.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2x3(blockD.f[3], mat2x3(-8.0, -9.0, -7.0, 5.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2x3(blockD.f[4], mat2x3(6.0, 6.0, 2.0, -8.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat2x3(blockD.f[5], mat2x3(-8.0, -8.0, 4.0, -2.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat2x3(blockD.f[6], mat2x3(-1.0, 8.0, -5.0, 8.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat2x3(blockD.f[7], mat2x3(-2.0, -5.0, 4.0, -4.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(i[0], mat3x2(0.0, -5.0, -5.0, 4.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3x2(i[1], mat3x2(9.0, -3.0, -9.0, -6.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3x2(i[2], mat3x2(7.0, -8.0, -6.0, -8.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat3x2(i[3], mat3x2(5.0, -3.0, 0.0, 2.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat3x2(i[4], mat3x2(0.0, 9.0, 3.0, -8.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(i[5], mat3x2(-1.0, -8.0, 7.0, 0.0, -9.0, 9.0)) && allOk;
	allOk = compare_ivec4((j[0]), ivec4(0, -6, -3, 2)) && allOk;
	allOk = compare_ivec4((j[1]), ivec4(-2, -5, -2, 0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (mat4x2(1.0, 0.0, -5.0, -1.0, -6.0, 3.0, -9.0, -5.0));
	blockC.c = (mat4x2(0.0, -1.0, -3.0, -7.0, 0.0, 8.0, 6.0, -1.0));
	blockD.d = (-5.0);
	blockD.e = (mat3x2(8.0, -6.0, -1.0, -1.0, 0.0, 7.0));
	g = (ivec4(0, 9, -7, -5));
	h = (bvec2(true, false));
	i[0] = (mat3x2(-8.0, -1.0, 2.0, -1.0, 9.0, 7.0));
	i[1] = (mat3x2(-9.0, 5.0, 4.0, 7.0, -1.0, 3.0));
	i[2] = (mat3x2(-5.0, -1.0, -2.0, -1.0, 6.0, -7.0));
	i[3] = (mat3x2(-5.0, 0.0, 3.0, 7.0, 1.0, 4.0));
	i[4] = (mat3x2(6.0, -8.0, -3.0, 6.0, 8.0, -2.0));
	i[5] = (mat3x2(2.0, -3.0, -3.0, -3.0, 7.0, -4.0));
	j[0] = (ivec4(2, -7, 2, 8));
	j[1] = (ivec4(-4, -4, 9, -1));
}
#version 450
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
	float16_t a;
	lowp uint b;
	uint16_t c[1];
	uint16_t d[1];
	float16_t e;
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	float16_t f;
} blockC;

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockB.e), 0.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = float16_t(8.0);
	blockB.c[0] = uint16_t(9u);
	blockB.d[0] = uint16_t(1u);
	blockB.e = float16_t(-4.0);
	blockC.f = float16_t(2.0);
}
#version 450
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
	f16vec3 a;
	mediump mat4x3 b;
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	lowp mat4 c;
	lowp uvec3 d;
	bvec3 e;
	mediump uvec3 f;
	lowp mat2x3 g;
};
layout(std430, row_major, binding = 3) buffer BlockD
{
	bool h;
	highp mat3 i;
	f16vec2 j;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(a), vec3(1.0, -5.0, -9.0)) && allOk;
	allOk = compare_bool((h), true) && allOk;
	allOk = compare_mat3(i, mat3(1.0, -4.0, -3.0, 3.0, 0.0, -9.0, -4.0, 1.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(j), vec2(6.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = f16vec3(vec3(2.0, 7.0, -5.0));
	b = (mat4x3(-4.0, 0.0, 4.0, -8.0, -7.0, 7.0, -5.0, 5.0, 8.0, 0.0, 3.0, 3.0));
	c = (mat4(8.0, 8.0, 0.0, 8.0, -6.0, 5.0, 1.0, 7.0, -1.0, -9.0, -2.0, -7.0, -5.0, 7.0, -9.0, -5.0));
	d = (uvec3(5u, 8u, 0u));
	e = (bvec3(true, false, true));
	g = (mat2x3(8.0, 5.0, 3.0, 5.0, -4.0, 8.0));
	h = (false);
	i = (mat3(0.0, -8.0, -2.0, -8.0, 2.0, 2.0, 1.0, -7.0, -5.0));
}
#version 450
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
	f16vec3 a[4];
	mediump ivec4 b;
	mediump vec3 c;
	lowp mat3 d[];
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	highp uvec2 e;
	mediump mat4x3 f;
	uint16_t g[];
};
layout(std140, row_major, binding = 3) buffer BlockD
{
	f16vec2 h;
	highp vec2 i;
	highp mat2 j;
	lowp vec4 k;
	uint16_t l[];
};
layout(std140, row_major, binding = 4) readonly buffer BlockE
{
	bvec2 m;
	lowp uint n[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.b), ivec4(1, 8, 1, -2)) && allOk;
	allOk = compare_vec3((blockB.c), vec3(-8.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3(blockB.d[0], mat3(-8.0, -7.0, 7.0, 0.0, 9.0, -6.0, 5.0, -2.0, -8.0)) && allOk;
	allOk = compare_uint16_t(uint(g[0]), 1u) && allOk;
	allOk = compare_uint16_t(uint(g[1]), 7u) && allOk;
	allOk = compare_uint16_t(uint(g[2]), 1u) && allOk;
	allOk = compare_uint16_t(uint(g[3]), 0u) && allOk;
	allOk = compare_uint16_t(uint(g[4]), 9u) && allOk;
	allOk = compare_uint16_t(uint(g[5]), 9u) && allOk;
	allOk = compare_uint16_t(uint(g[6]), 9u) && allOk;
	allOk = compare_uint16_t(uint(g[7]), 9u) && allOk;
	allOk = compare_f16vec2(vec2(h), vec2(-3.0, 4.0)) && allOk;
	allOk = compare_vec2((i), vec2(0.0, -4.0)) && allOk;
	allOk = compare_mat2(j, mat2(-7.0, -1.0, 5.0, 6.0)) && allOk;
	allOk = compare_vec4((k), vec4(8.0, -2.0, 6.0, 1.0)) && allOk;
	allOk = compare_uint((blockE.n[0]), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (ivec4(3, 4, -1, -4));
	e = (uvec2(1u, 2u));
	f = (mat4x3(-9.0, -2.0, 0.0, 2.0, 6.0, -7.0, 3.0, 9.0, 8.0, 1.0, 7.0, -9.0));
	h = f16vec2(vec2(0.0, -4.0));
	i = (vec2(-4.0, -9.0));
	j = (mat2(1.0, -8.0, 5.0, -8.0));
	k = (vec4(9.0, -4.0, 9.0, -7.0));
	l[0] = uint16_t(7u);
	l[1] = uint16_t(5u);
	l[2] = uint16_t(2u);
}
#version 450
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
	highp mat4x3 a;
	lowp ivec3 b[];
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	bvec2 c;
	mediump mat4x2 d[];
} blockC;

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
	allOk = compare_mat4x3(blockB.a, mat4x3(-8.0, 5.0, -1.0, -2.0, 6.0, 6.0, 9.0, -1.0, 0.0, -5.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat4x2(blockC.d[0], mat4x2(-1.0, -8.0, -7.0, 7.0, 0.0, 9.0, -6.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x3(1.0, 8.0, 3.0, 1.0, -4.0, 0.0, -4.0, 1.0, -9.0, 1.0, -9.0, -6.0));
	blockC.c = (bvec2(true, false));
	blockC.d[0] = (mat4x2(-3.0, 6.0, 5.0, -2.0, -1.0, -4.0, -8.0, 2.0));
}
#version 450
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
	highp vec4 b;
	uint16_t c;
	mediump uvec4 d;
	bool e[][6];
} blockB[2];
layout(std430, row_major, binding = 2) buffer BlockC
{
	float16_t f;
	int16_t g[];
};
layout(std430, column_major, binding = 3) buffer BlockD
{
	mediump vec4 h;
	highp mat3x4 i;
	highp vec3 j;
	float16_t k[];
} blockD[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(blockB[0].a), vec3(2.0, -8.0, -4.0)) && allOk;
	allOk = compare_uint16_t(uint(blockB[0].c), 0u) && allOk;
	allOk = compare_f16vec3(vec3(blockB[1].a), vec3(2.0, 9.0, 1.0)) && allOk;
	allOk = compare_uint16_t(uint(blockB[1].c), 3u) && allOk;
	allOk = compare_int16_t(int(g[0]), 0) && allOk;
	allOk = compare_int16_t(int(g[1]), 0) && allOk;
	allOk = compare_int16_t(int(g[2]), 0) && allOk;
	allOk = compare_int16_t(int(g[3]), -5) && allOk;
	allOk = compare_int16_t(int(g[4]), 3) && allOk;
	allOk = compare_int16_t(int(g[5]), -8) && allOk;
	allOk = compare_mat3x4(blockD[0].i, mat3x4(-4.0, 2.0, 4.0, 4.0, 1.0, -4.0, 4.0, 5.0, 6.0, -5.0, 7.0, 6.0)) && allOk;
	allOk = compare_float16_t(float(blockD[0].k[0]), 4.0) && allOk;
	allOk = compare_float16_t(float(blockD[0].k[1]), -3.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = f16vec3(vec3(8.0, -2.0, -1.0));
	blockB[0].b = (vec4(-6.0, 6.0, 0.0, 9.0));
	blockB[0].c = uint16_t(8u);
	blockB[0].d = (uvec4(3u, 7u, 7u, 5u));
	blockB[0].e[0][0] = (false);
	blockB[0].e[0][1] = (false);
	blockB[0].e[0][2] = (true);
	blockB[0].e[0][3] = (true);
	blockB[0].e[0][4] = (true);
	blockB[0].e[0][5] = (true);
	blockB[0].e[1][0] = (false);
	blockB[0].e[1][1] = (false);
	blockB[0].e[1][2] = (false);
	blockB[0].e[1][3] = (true);
	blockB[0].e[1][4] = (false);
	blockB[0].e[1][5] = (true);
	blockB[0].e[2][0] = (false);
	blockB[0].e[2][1] = (true);
	blockB[0].e[2][2] = (true);
	blockB[0].e[2][3] = (true);
	blockB[0].e[2][4] = (false);
	blockB[0].e[2][5] = (false);
	blockB[0].e[3][0] = (false);
	blockB[0].e[3][1] = (false);
	blockB[0].e[3][2] = (true);
	blockB[0].e[3][3] = (true);
	blockB[0].e[3][4] = (true);
	blockB[0].e[3][5] = (false);
	blockB[0].e[4][0] = (false);
	blockB[0].e[4][1] = (false);
	blockB[0].e[4][2] = (false);
	blockB[0].e[4][3] = (false);
	blockB[0].e[4][4] = (true);
	blockB[0].e[4][5] = (false);
	blockB[1].a = f16vec3(vec3(-3.0, -4.0, 4.0));
	blockB[1].b = (vec4(9.0, 0.0, 1.0, 2.0));
	blockB[1].c = uint16_t(5u);
	blockB[1].d = (uvec4(1u, 5u, 5u, 3u));
	blockB[1].e[0][0] = (false);
	blockB[1].e[0][1] = (true);
	blockB[1].e[0][2] = (true);
	blockB[1].e[0][3] = (true);
	blockB[1].e[0][4] = (true);
	blockB[1].e[0][5] = (true);
	blockB[1].e[1][0] = (false);
	blockB[1].e[1][1] = (true);
	blockB[1].e[1][2] = (false);
	blockB[1].e[1][3] = (true);
	blockB[1].e[1][4] = (false);
	blockB[1].e[1][5] = (true);
	blockB[1].e[2][0] = (false);
	blockB[1].e[2][1] = (false);
	blockB[1].e[2][2] = (true);
	blockB[1].e[2][3] = (false);
	blockB[1].e[2][4] = (true);
	blockB[1].e[2][5] = (true);
	blockB[1].e[3][0] = (true);
	blockB[1].e[3][1] = (false);
	blockB[1].e[3][2] = (true);
	blockB[1].e[3][3] = (false);
	blockB[1].e[3][4] = (false);
	blockB[1].e[3][5] = (true);
	g[0] = int16_t(5);
	g[1] = int16_t(9);
	g[2] = int16_t(-5);
	g[3] = int16_t(-8);
	g[4] = int16_t(-9);
	g[5] = int16_t(9);
	blockD[0].h = (vec4(5.0, 1.0, -7.0, 3.0));
	blockD[0].k[0] = float16_t(1.0);
	blockD[0].k[1] = float16_t(6.0);
}
#version 450
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
	lowp mat4 a[8];
	int16_t b;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(blockB.b), 6) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = int16_t(7);
}
#version 450
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
	lowp mat3x2 a;
	f16vec4 b;
	u16vec3 c[6];
	float16_t d;
	uint16_t e[];
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	lowp mat4x2 f;
	u16vec2 g;
	highp mat2x3 h;
	float16_t i[];
};
layout(std430, column_major, binding = 3) buffer BlockD
{
	highp uvec4 j;
};
layout(std430, row_major, binding = 4) buffer BlockE
{
	mediump uint k;
	bool l[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(b), vec4(-5.0, -2.0, 3.0, 4.0)) && allOk;
	allOk = compare_u16vec2(uvec2(g), uvec2(0u, 9u)) && allOk;
	allOk = compare_float16_t(float(i[0]), -5.0) && allOk;
	allOk = compare_float16_t(float(i[1]), 4.0) && allOk;
	allOk = compare_float16_t(float(i[2]), 8.0) && allOk;
	allOk = compare_float16_t(float(i[3]), 5.0) && allOk;
	allOk = compare_float16_t(float(i[4]), -6.0) && allOk;
	allOk = compare_uvec4((j), uvec4(5u, 7u, 5u, 0u)) && allOk;
	allOk = compare_uint((k), 4u) && allOk;
	allOk = compare_bool((l[0]), false) && allOk;
	allOk = compare_bool((l[1]), true) && allOk;
	allOk = compare_bool((l[2]), false) && allOk;
	allOk = compare_bool((l[3]), false) && allOk;
	allOk = compare_bool((l[4]), true) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat3x2(7.0, -8.0, -6.0, -6.0, 3.0, 5.0));
	c[0] = u16vec3(uvec3(7u, 0u, 1u));
	c[1] = u16vec3(uvec3(5u, 5u, 7u));
	c[2] = u16vec3(uvec3(3u, 1u, 6u));
	c[3] = u16vec3(uvec3(1u, 2u, 8u));
	c[4] = u16vec3(uvec3(8u, 9u, 6u));
	c[5] = u16vec3(uvec3(7u, 3u, 2u));
	f = (mat4x2(-8.0, -6.0, 5.0, -2.0, -9.0, 6.0, 6.0, -5.0));
	g = u16vec2(uvec2(5u, 5u));
	h = (mat2x3(-3.0, -3.0, 5.0, 7.0, -2.0, -2.0));
	i[0] = float16_t(7.0);
	i[1] = float16_t(-9.0);
	i[2] = float16_t(-9.0);
	i[3] = float16_t(6.0);
	i[4] = float16_t(3.0);
	j = (uvec4(4u, 1u, 0u, 8u));
	k = (9u);
	l[0] = (false);
	l[1] = (true);
	l[2] = (false);
	l[3] = (true);
	l[4] = (true);
}
#version 450
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
	float16_t a[1];
	u16vec2 b;
	highp int c;
} blockB[];

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB[nonuniformEXT(0)].c), -7) && allOk;
	allOk = compare_int((blockB[nonuniformEXT(1)].c), -2) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = u16vec2(uvec2(2u, 1u));
	blockB[nonuniformEXT(1)].b = u16vec2(uvec2(6u, 3u));
}
#version 450
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
	i16vec2 a;
	bool b;
	lowp mat3x4 c;
	lowp ivec4 d;
	i16vec3 e;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(blockB[nonuniformEXT(0)].a), ivec2(6, 8)) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(0)].b), true) && allOk;
	allOk = compare_mat3x4(blockB[nonuniformEXT(0)].c, mat3x4(-4.0, 4.0, 0.0, 7.0, 2.0, -8.0, 2.0, -3.0, -1.0, -5.0, -5.0, 3.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB[nonuniformEXT(1)].a), ivec2(-4, 5)) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(1)].b), false) && allOk;
	allOk = compare_mat3x4(blockB[nonuniformEXT(1)].c, mat3x4(-5.0, -1.0, 6.0, -6.0, 5.0, -3.0, 0.0, 4.0, 2.0, 4.0, -1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = i16vec2(ivec2(7, 7));
	blockB[nonuniformEXT(0)].b = (true);
	blockB[nonuniformEXT(0)].c = (mat3x4(-1.0, 9.0, 3.0, -5.0, -9.0, -8.0, 3.0, -3.0, -6.0, 0.0, -8.0, -3.0));
	blockB[nonuniformEXT(0)].e = i16vec3(ivec3(-4, 2, -7));
	blockB[nonuniformEXT(1)].a = i16vec2(ivec2(-7, -3));
	blockB[nonuniformEXT(1)].b = (false);
	blockB[nonuniformEXT(1)].c = (mat3x4(-5.0, 5.0, 9.0, 9.0, 6.0, 9.0, -5.0, 2.0, -5.0, -6.0, 0.0, -5.0));
	blockB[nonuniformEXT(1)].e = i16vec3(ivec3(-1, 3, -7));
}
#version 450
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
	int8_t b;
	highp uvec4 c;
	mediump float d[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(blockB.b), 8) && allOk;
	allOk = compare_uvec4((blockB.c), uvec4(0u, 4u, 4u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (4u);
	blockB.c = (uvec4(0u, 6u, 8u, 2u));
	blockB.d[0] = (-6.0);
	blockB.d[1] = (3.0);
	blockB.d[2] = (-7.0);
	blockB.d[3] = (8.0);
	blockB.d[4] = (5.0);
	blockB.d[5] = (-6.0);
}
#version 450
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
	highp mat3x2 a;
	mediump float b;
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	i8vec2 c;
	lowp mat4x3 d;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockC.d, mat4x3(-9.0, 1.0, -6.0, -8.0, -5.0, 9.0, 7.0, -8.0, 1.0, 5.0, -5.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x2(-9.0, 0.0, -3.0, -3.0, 8.0, 9.0));
	blockC.c = i8vec2(ivec2(2, 1));
	blockC.d = (mat4x3(8.0, 6.0, 2.0, 9.0, 8.0, 5.0, -5.0, 8.0, -1.0, 7.0, -9.0, -3.0));
}
#version 450
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
	mediump float a;
	lowp mat4x2 b[];
};
layout(std430, column_major, binding = 2) buffer BlockC
{
	mediump int c;
	uint8_t d;
	bvec2 e;
	u8vec2 f[];
} blockC[2];
layout(std430, column_major, binding = 3) buffer BlockD
{
	lowp vec2 g;
	bool h;
	lowp uvec2 i[];
} blockD[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((a), 0.0) && allOk;
	allOk = compare_mat4x2(b[0], mat4x2(-6.0, 9.0, -5.0, 0.0, 3.0, 7.0, -1.0, -8.0)) && allOk;
	allOk = compare_uint8_t(uint(blockC[0].d), 2u) && allOk;
	allOk = compare_u8vec2(uvec2(blockC[0].f[0]), uvec2(3u, 4u)) && allOk;
	allOk = compare_uint8_t(uint(blockC[1].d), 0u) && allOk;
	allOk = compare_u8vec2(uvec2(blockC[1].f[0]), uvec2(8u, 7u)) && allOk;
	allOk = compare_vec2((blockD[0].g), vec2(1.0, -6.0)) && allOk;
	allOk = compare_bool((blockD[0].h), false) && allOk;
	allOk = compare_vec2((blockD[1].g), vec2(-2.0, 8.0)) && allOk;
	allOk = compare_bool((blockD[1].h), true) && allOk;
	allOk = compare_vec2((blockD[2].g), vec2(3.0, -6.0)) && allOk;
	allOk = compare_bool((blockD[2].h), true) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (6.0);
	b[0] = (mat4x2(3.0, -9.0, 0.0, 9.0, 2.0, -6.0, 6.0, -6.0));
	blockC[0].c = (3);
	blockC[0].f[0] = u8vec2(uvec2(2u, 6u));
	blockC[1].c = (-6);
	blockC[1].f[0] = u8vec2(uvec2(3u, 5u));
	blockD[0].g = (vec2(-4.0, 0.0));
	blockD[0].h = (true);
	blockD[1].g = (vec2(9.0, -3.0));
	blockD[1].h = (true);
	blockD[2].g = (vec2(-3.0, 2.0));
	blockD[2].h = (true);
}
#version 450
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
layout(std140, column_major, binding = 1) buffer BlockB
{
	bvec3 a;
	i8vec2 b;
	lowp uvec2 c;
	lowp ivec4 d[];
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	highp mat3 e;
	uint8_t f;
	sA g;
	i8vec3 h;
	lowp mat3x4 i[][2];
};
layout(std430, binding = 3) buffer BlockD
{
	bvec4 j;
	u8vec4 k;
	mediump mat2x3 l;
	highp mat4 m;
	i8vec4 n[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.a), bvec3(true, false, false)) && allOk;
	allOk = compare_ivec4((blockB.d[0]), ivec4(-5, -8, -6, 0)) && allOk;
	allOk = compare_ivec4((blockB.d[1]), ivec4(7, -1, -1, 6)) && allOk;
	allOk = compare_ivec4((blockB.d[2]), ivec4(-5, 5, -6, 5)) && allOk;
	allOk = compare_ivec4((blockB.d[3]), ivec4(-7, -4, -7, -7)) && allOk;
	allOk = compare_ivec4((blockB.d[4]), ivec4(0, 6, -7, 5)) && allOk;
	allOk = compare_bool((g.mA), false) && allOk;
	allOk = compare_i8vec3(ivec3(h), ivec3(1, 4294967288, 1)) && allOk;
	allOk = compare_bvec4((j), bvec4(false, true, false, false)) && allOk;
	allOk = compare_mat2x3(l, mat2x3(-3.0, -7.0, 2.0, -4.0, 8.0, 6.0)) && allOk;
	allOk = compare_i8vec4(ivec4(n[0]), ivec4(8, 1, 4294967293, 6)) && allOk;
	allOk = compare_i8vec4(ivec4(n[1]), ivec4(3, 2, 7, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(n[2]), ivec4(4294967291, 5, 4294967294, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(n[3]), ivec4(4294967295, 3, 6, 9)) && allOk;
	allOk = compare_i8vec4(ivec4(n[4]), ivec4(4294967292, 4, 4, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(n[5]), ivec4(9, 5, 9, 4294967294)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.d[0] = (ivec4(-5, -7, 5, 2));
	blockB.d[1] = (ivec4(-4, -8, 0, 9));
	blockB.d[2] = (ivec4(3, 1, -6, 4));
	blockB.d[3] = (ivec4(-4, -6, 9, 3));
	blockB.d[4] = (ivec4(7, 7, -8, 5));
	e = (mat3(-2.0, 5.0, 5.0, -7.0, 0.0, 4.0, -2.0, -1.0, -9.0));
	f = uint8_t(1u);
	g.mA = (true);
	h = i8vec3(ivec3(4294967295, 4294967289, 7));
	i[0][0] = (mat3x4(4.0, 6.0, 5.0, -1.0, -3.0, 5.0, -1.0, 2.0, 1.0, 8.0, -1.0, -8.0));
	i[0][1] = (mat3x4(-1.0, 1.0, 3.0, -1.0, -2.0, -7.0, -6.0, -1.0, -8.0, -3.0, 1.0, 1.0));
	i[1][0] = (mat3x4(2.0, 4.0, 8.0, 2.0, -5.0, 7.0, -5.0, 3.0, -4.0, -2.0, -9.0, 1.0));
	i[1][1] = (mat3x4(-5.0, -1.0, 2.0, -7.0, -2.0, 0.0, -7.0, 9.0, 5.0, -2.0, -7.0, -6.0));
	i[2][0] = (mat3x4(-8.0, 3.0, -9.0, 6.0, 6.0, 2.0, 9.0, -8.0, 5.0, 4.0, 1.0, -6.0));
	i[2][1] = (mat3x4(-8.0, 7.0, -5.0, 6.0, -6.0, 3.0, 1.0, 4.0, -8.0, -6.0, 6.0, 8.0));
	i[3][0] = (mat3x4(0.0, -1.0, 9.0, 1.0, -8.0, -7.0, 0.0, 5.0, 1.0, 5.0, -2.0, -6.0));
	i[3][1] = (mat3x4(4.0, -5.0, -7.0, 9.0, -2.0, 6.0, 6.0, 4.0, 5.0, -3.0, 8.0, -7.0));
	i[4][0] = (mat3x4(4.0, 3.0, -9.0, 9.0, -5.0, -6.0, -4.0, -7.0, 4.0, 9.0, -9.0, 5.0));
	i[4][1] = (mat3x4(-3.0, -9.0, -6.0, -8.0, 1.0, 1.0, 8.0, -3.0, 1.0, 0.0, -7.0, 7.0));
	i[5][0] = (mat3x4(5.0, -7.0, 6.0, 8.0, 4.0, 6.0, -2.0, 4.0, 5.0, 7.0, 5.0, -7.0));
	i[5][1] = (mat3x4(-6.0, 4.0, 8.0, -2.0, 9.0, -3.0, 9.0, 7.0, 7.0, -3.0, -5.0, 5.0));
	i[6][0] = (mat3x4(4.0, -1.0, -5.0, -5.0, -4.0, 2.0, -2.0, 0.0, 2.0, 0.0, 2.0, -7.0));
	i[6][1] = (mat3x4(4.0, -5.0, 3.0, 5.0, 8.0, -8.0, -8.0, 8.0, -4.0, -1.0, -4.0, -5.0));
	i[7][0] = (mat3x4(-3.0, -6.0, 9.0, 2.0, 6.0, 1.0, -2.0, 2.0, -9.0, 3.0, -5.0, 8.0));
	i[7][1] = (mat3x4(4.0, -8.0, -2.0, -2.0, -3.0, -7.0, -9.0, 0.0, 4.0, -9.0, -3.0, 6.0));
	j = (bvec4(true, false, false, true));
	k = u8vec4(uvec4(8u, 8u, 1u, 4u));
	m = (mat4(-3.0, -8.0, 7.0, 0.0, -3.0, 1.0, -1.0, 0.0, 0.0, -5.0, -5.0, 5.0, 1.0, -6.0, -9.0, -5.0));
	n[0] = i8vec4(ivec4(6, 1, 3, 9));
	n[1] = i8vec4(ivec4(4294967295, 4294967293, 9, 6));
	n[2] = i8vec4(ivec4(4294967287, 4294967288, 4294967292, 4294967294));
	n[3] = i8vec4(ivec4(4294967291, 4294967293, 6, 5));
	n[4] = i8vec4(ivec4(4294967287, 4294967290, 4, 2));
	n[5] = i8vec4(ivec4(0, 4294967292, 2, 3));
}
#version 450
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
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	highp vec3 a;
	int8_t b[];
};
layout(std140, column_major, binding = 2) readonly buffer BlockC
{
	mediump mat2x3 c;
	lowp vec4 d;
} blockC;
layout(std140, column_major, binding = 3) buffer BlockD
{
	highp uvec4 e;
	lowp mat4x2 f;
	u8vec3 g;
	lowp mat4 h[];
} blockD[2];
layout(std140, row_major, binding = 4) buffer BlockE
{
	sA i;
	highp ivec2 j;
	lowp uvec3 k[];
} blockE[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockC.c, mat2x3(-1.0, 4.0, -4.0, 0.0, -2.0, -5.0)) && allOk;
	allOk = compare_vec4((blockC.d), vec4(1.0, 5.0, 1.0, -6.0)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD[0].g), uvec3(4u, 6u, 8u)) && allOk;
	allOk = compare_mat4(blockD[0].h[0], mat4(8.0, -7.0, -4.0, -7.0, -2.0, 2.0, 7.0, 8.0, -1.0, 5.0, 9.0, -1.0, 5.0, -9.0, 2.0, 3.0)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD[1].g), uvec3(4u, 0u, 2u)) && allOk;
	allOk = compare_mat4(blockD[1].h[0], mat4(-2.0, 2.0, 2.0, 9.0, -4.0, 8.0, -2.0, -4.0, -8.0, -4.0, 7.0, -2.0, -6.0, 6.0, -2.0, -1.0)) && allOk;
	allOk = compare_ivec2((blockE[0].j), ivec2(0, -9)) && allOk;
	allOk = compare_uvec3((blockE[0].k[0]), uvec3(2u, 6u, 4u)) && allOk;
	allOk = compare_ivec2((blockE[1].j), ivec2(-2, -4)) && allOk;
	allOk = compare_uvec3((blockE[1].k[0]), uvec3(1u, 7u, 7u)) && allOk;
	allOk = compare_ivec2((blockE[2].j), ivec2(-9, 7)) && allOk;
	allOk = compare_uvec3((blockE[2].k[0]), uvec3(5u, 7u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec3(-2.0, -9.0, -3.0));
	b[0] = int8_t(4294967295);
	blockD[0].g = u8vec3(uvec3(7u, 4u, 8u));
	blockD[0].h[0] = (mat4(-2.0, -6.0, -3.0, 0.0, 7.0, -1.0, -5.0, -8.0, 9.0, 7.0, -9.0, -8.0, -4.0, 0.0, -3.0, 9.0));
	blockD[1].g = u8vec3(uvec3(8u, 2u, 5u));
	blockD[1].h[0] = (mat4(2.0, -2.0, 2.0, -1.0, 7.0, -1.0, 3.0, 2.0, -8.0, 9.0, -3.0, 8.0, -7.0, -9.0, -5.0, 9.0));
	blockE[0].i.mA = (uvec3(6u, 4u, 9u));
	blockE[0].i.mB = (bvec3(false, false, true));
	blockE[0].j = (ivec2(5, -1));
	blockE[0].k[0] = (uvec3(2u, 1u, 2u));
	blockE[1].i.mA = (uvec3(5u, 3u, 3u));
	blockE[1].i.mB = (bvec3(false, true, false));
	blockE[1].j = (ivec2(7, -5));
	blockE[1].k[0] = (uvec3(5u, 2u, 0u));
	blockE[2].i.mA = (uvec3(0u, 5u, 6u));
	blockE[2].i.mB = (bvec3(true, true, true));
	blockE[2].j = (ivec2(9, 3));
	blockE[2].k[0] = (uvec3(5u, 0u, 7u));
}
#version 450
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
	mediump mat3x2 mB;
};
struct sB
{
	lowp vec2 mA;
	i8vec3 mB;
	sA mC;
};
layout(std430, column_major, binding = 1) readonly buffer BlockB
{
	bool a;
	sB b;
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	mediump uvec4 c;
	mediump ivec2 d[];
} blockC[2];
layout(std430, row_major, binding = 3) buffer BlockD
{
	highp vec4 e;
	highp vec2 f;
	i8vec2 g[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.b.mA), vec2(9.0, -9.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.b.mB), ivec3(4294967287, 4294967292, 4)) && allOk;
	allOk = compare_bvec2((blockB.b.mC.mA), bvec2(true, false)) && allOk;
	allOk = compare_mat3x2(blockB.b.mC.mB, mat3x2(5.0, 1.0, -2.0, 6.0, 3.0, -6.0)) && allOk;
	allOk = compare_uvec4((blockC[0].c), uvec4(5u, 7u, 4u, 5u)) && allOk;
	allOk = compare_ivec2((blockC[0].d[0]), ivec2(8, -6)) && allOk;
	allOk = compare_ivec2((blockC[0].d[1]), ivec2(2, -6)) && allOk;
	allOk = compare_ivec2((blockC[0].d[2]), ivec2(-8, 9)) && allOk;
	allOk = compare_ivec2((blockC[0].d[3]), ivec2(-9, 8)) && allOk;
	allOk = compare_ivec2((blockC[0].d[4]), ivec2(-6, -5)) && allOk;
	allOk = compare_ivec2((blockC[0].d[5]), ivec2(-9, -3)) && allOk;
	allOk = compare_ivec2((blockC[0].d[6]), ivec2(-5, 3)) && allOk;
	allOk = compare_ivec2((blockC[0].d[7]), ivec2(0, 7)) && allOk;
	allOk = compare_uvec4((blockC[1].c), uvec4(0u, 4u, 4u, 8u)) && allOk;
	allOk = compare_ivec2((blockC[1].d[0]), ivec2(1, -4)) && allOk;
	allOk = compare_ivec2((blockC[1].d[1]), ivec2(-5, -1)) && allOk;
	allOk = compare_vec4((blockD.e), vec4(2.0, 4.0, -2.0, 2.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.g[0]), ivec2(4294967288, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.g[1]), ivec2(4294967293, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC[0].c = (uvec4(8u, 7u, 5u, 8u));
	blockC[0].d[0] = (ivec2(-2, 9));
	blockC[0].d[1] = (ivec2(-6, 3));
	blockC[0].d[2] = (ivec2(5, 5));
	blockC[0].d[3] = (ivec2(9, 3));
	blockC[0].d[4] = (ivec2(-9, -1));
	blockC[0].d[5] = (ivec2(-5, -8));
	blockC[0].d[6] = (ivec2(3, 0));
	blockC[0].d[7] = (ivec2(-6, -8));
	blockC[1].c = (uvec4(3u, 0u, 2u, 4u));
	blockC[1].d[0] = (ivec2(6, 9));
	blockC[1].d[1] = (ivec2(9, -1));
	blockD.e = (vec4(-2.0, 8.0, 7.0, -5.0));
	blockD.f = (vec2(-2.0, -3.0));
	blockD.g[0] = i8vec2(ivec2(4294967292, 3));
	blockD.g[1] = i8vec2(ivec2(1, 4294967294));
}
#version 450
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
	mediump mat4x3 a;
	highp ivec4 b;
	lowp vec3 c;
	lowp vec4 d;
	mediump mat4x2 e[];
} blockB[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB[0].a, mat4x3(7.0, -7.0, 0.0, -3.0, 7.0, 2.0, 3.0, 9.0, 5.0, 7.0, 0.0, -9.0)) && allOk;
	allOk = compare_ivec4((blockB[0].b), ivec4(8, 7, -8, -8)) && allOk;
	allOk = compare_vec3((blockB[0].c), vec3(-4.0, 8.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (mat4x3(5.0, 6.0, 1.0, -5.0, 7.0, -4.0, 4.0, -2.0, 4.0, 5.0, -5.0, 7.0));
	blockB[0].b = (ivec4(4, 5, 9, -3));
	blockB[0].c = (vec3(1.0, 7.0, -2.0));
}
#version 450
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
	layout(offset = 0) lowp uint a[1];
} blockB;

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a[0]), 7u) && allOk;
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

layout(scalar, binding = 1) buffer BlockB
{
	i8vec3 a;
	u8vec3 b;
	mediump mat3x2 c[];
} blockB[2];
layout(scalar, row_major, binding = 2) buffer BlockC
{
	mediump ivec4 d[];
};
layout(scalar, binding = 3) buffer BlockD
{
	i8vec2 e;
	bool f[6][7][8];
	highp mat3x4 g[][7];
};
layout(scalar, row_major, binding = 4) readonly buffer BlockE
{
	lowp vec4 h[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(blockB[0].a), ivec3(3, 4294967287, 4294967294)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB[1].a), ivec3(4294967293, 2, 4294967290)) && allOk;
	allOk = compare_i8vec2(ivec2(e), ivec2(1, 5)) && allOk;
	allOk = compare_bool((f[0][0][0]), false) && allOk;
	allOk = compare_bool((f[0][0][1]), false) && allOk;
	allOk = compare_bool((f[0][0][2]), false) && allOk;
	allOk = compare_bool((f[0][0][3]), true) && allOk;
	allOk = compare_bool((f[0][0][4]), true) && allOk;
	allOk = compare_bool((f[0][0][5]), false) && allOk;
	allOk = compare_bool((f[0][0][6]), true) && allOk;
	allOk = compare_bool((f[0][0][7]), true) && allOk;
	allOk = compare_bool((f[0][1][0]), true) && allOk;
	allOk = compare_bool((f[0][1][1]), false) && allOk;
	allOk = compare_bool((f[0][1][2]), false) && allOk;
	allOk = compare_bool((f[0][1][3]), false) && allOk;
	allOk = compare_bool((f[0][1][4]), true) && allOk;
	allOk = compare_bool((f[0][1][5]), true) && allOk;
	allOk = compare_bool((f[0][1][6]), true) && allOk;
	allOk = compare_bool((f[0][1][7]), true) && allOk;
	allOk = compare_bool((f[0][2][0]), false) && allOk;
	allOk = compare_bool((f[0][2][1]), false) && allOk;
	allOk = compare_bool((f[0][2][2]), false) && allOk;
	allOk = compare_bool((f[0][2][3]), false) && allOk;
	allOk = compare_bool((f[0][2][4]), false) && allOk;
	allOk = compare_bool((f[0][2][5]), true) && allOk;
	allOk = compare_bool((f[0][2][6]), false) && allOk;
	allOk = compare_bool((f[0][2][7]), false) && allOk;
	allOk = compare_bool((f[0][3][0]), true) && allOk;
	allOk = compare_bool((f[0][3][1]), true) && allOk;
	allOk = compare_bool((f[0][3][2]), true) && allOk;
	allOk = compare_bool((f[0][3][3]), true) && allOk;
	allOk = compare_bool((f[0][3][4]), true) && allOk;
	allOk = compare_bool((f[0][3][5]), false) && allOk;
	allOk = compare_bool((f[0][3][6]), false) && allOk;
	allOk = compare_bool((f[0][3][7]), true) && allOk;
	allOk = compare_bool((f[0][4][0]), false) && allOk;
	allOk = compare_bool((f[0][4][1]), true) && allOk;
	allOk = compare_bool((f[0][4][2]), false) && allOk;
	allOk = compare_bool((f[0][4][3]), true) && allOk;
	allOk = compare_bool((f[0][4][4]), true) && allOk;
	allOk = compare_bool((f[0][4][5]), false) && allOk;
	allOk = compare_bool((f[0][4][6]), false) && allOk;
	allOk = compare_bool((f[0][4][7]), false) && allOk;
	allOk = compare_bool((f[0][5][0]), true) && allOk;
	allOk = compare_bool((f[0][5][1]), true) && allOk;
	allOk = compare_bool((f[0][5][2]), false) && allOk;
	allOk = compare_bool((f[0][5][3]), false) && allOk;
	allOk = compare_bool((f[0][5][4]), false) && allOk;
	allOk = compare_bool((f[0][5][5]), true) && allOk;
	allOk = compare_bool((f[0][5][6]), false) && allOk;
	allOk = compare_bool((f[0][5][7]), false) && allOk;
	allOk = compare_bool((f[0][6][0]), false) && allOk;
	allOk = compare_bool((f[0][6][1]), true) && allOk;
	allOk = compare_bool((f[0][6][2]), false) && allOk;
	allOk = compare_bool((f[0][6][3]), false) && allOk;
	allOk = compare_bool((f[0][6][4]), false) && allOk;
	allOk = compare_bool((f[0][6][5]), false) && allOk;
	allOk = compare_bool((f[0][6][6]), true) && allOk;
	allOk = compare_bool((f[0][6][7]), false) && allOk;
	allOk = compare_bool((f[1][0][0]), false) && allOk;
	allOk = compare_bool((f[1][0][1]), true) && allOk;
	allOk = compare_bool((f[1][0][2]), false) && allOk;
	allOk = compare_bool((f[1][0][3]), true) && allOk;
	allOk = compare_bool((f[1][0][4]), false) && allOk;
	allOk = compare_bool((f[1][0][5]), false) && allOk;
	allOk = compare_bool((f[1][0][6]), false) && allOk;
	allOk = compare_bool((f[1][0][7]), true) && allOk;
	allOk = compare_bool((f[1][1][0]), true) && allOk;
	allOk = compare_bool((f[1][1][1]), true) && allOk;
	allOk = compare_bool((f[1][1][2]), true) && allOk;
	allOk = compare_bool((f[1][1][3]), false) && allOk;
	allOk = compare_bool((f[1][1][4]), true) && allOk;
	allOk = compare_bool((f[1][1][5]), false) && allOk;
	allOk = compare_bool((f[1][1][6]), false) && allOk;
	allOk = compare_bool((f[1][1][7]), false) && allOk;
	allOk = compare_bool((f[1][2][0]), true) && allOk;
	allOk = compare_bool((f[1][2][1]), true) && allOk;
	allOk = compare_bool((f[1][2][2]), false) && allOk;
	allOk = compare_bool((f[1][2][3]), false) && allOk;
	allOk = compare_bool((f[1][2][4]), true) && allOk;
	allOk = compare_bool((f[1][2][5]), false) && allOk;
	allOk = compare_bool((f[1][2][6]), true) && allOk;
	allOk = compare_bool((f[1][2][7]), false) && allOk;
	allOk = compare_bool((f[1][3][0]), true) && allOk;
	allOk = compare_bool((f[1][3][1]), true) && allOk;
	allOk = compare_bool((f[1][3][2]), false) && allOk;
	allOk = compare_bool((f[1][3][3]), true) && allOk;
	allOk = compare_bool((f[1][3][4]), true) && allOk;
	allOk = compare_bool((f[1][3][5]), false) && allOk;
	allOk = compare_bool((f[1][3][6]), true) && allOk;
	allOk = compare_bool((f[1][3][7]), true) && allOk;
	allOk = compare_bool((f[1][4][0]), true) && allOk;
	allOk = compare_bool((f[1][4][1]), false) && allOk;
	allOk = compare_bool((f[1][4][2]), false) && allOk;
	allOk = compare_bool((f[1][4][3]), true) && allOk;
	allOk = compare_bool((f[1][4][4]), true) && allOk;
	allOk = compare_bool((f[1][4][5]), true) && allOk;
	allOk = compare_bool((f[1][4][6]), true) && allOk;
	allOk = compare_bool((f[1][4][7]), true) && allOk;
	allOk = compare_bool((f[1][5][0]), true) && allOk;
	allOk = compare_bool((f[1][5][1]), false) && allOk;
	allOk = compare_bool((f[1][5][2]), true) && allOk;
	allOk = compare_bool((f[1][5][3]), false) && allOk;
	allOk = compare_bool((f[1][5][4]), true) && allOk;
	allOk = compare_bool((f[1][5][5]), true) && allOk;
	allOk = compare_bool((f[1][5][6]), false) && allOk;
	allOk = compare_bool((f[1][5][7]), true) && allOk;
	allOk = compare_bool((f[1][6][0]), true) && allOk;
	allOk = compare_bool((f[1][6][1]), false) && allOk;
	allOk = compare_bool((f[1][6][2]), true) && allOk;
	allOk = compare_bool((f[1][6][3]), true) && allOk;
	allOk = compare_bool((f[1][6][4]), false) && allOk;
	allOk = compare_bool((f[1][6][5]), true) && allOk;
	allOk = compare_bool((f[1][6][6]), false) && allOk;
	allOk = compare_bool((f[1][6][7]), true) && allOk;
	allOk = compare_bool((f[2][0][0]), false) && allOk;
	allOk = compare_bool((f[2][0][1]), false) && allOk;
	allOk = compare_bool((f[2][0][2]), false) && allOk;
	allOk = compare_bool((f[2][0][3]), false) && allOk;
	allOk = compare_bool((f[2][0][4]), false) && allOk;
	allOk = compare_bool((f[2][0][5]), true) && allOk;
	allOk = compare_bool((f[2][0][6]), false) && allOk;
	allOk = compare_bool((f[2][0][7]), true) && allOk;
	allOk = compare_bool((f[2][1][0]), true) && allOk;
	allOk = compare_bool((f[2][1][1]), false) && allOk;
	allOk = compare_bool((f[2][1][2]), false) && allOk;
	allOk = compare_bool((f[2][1][3]), true) && allOk;
	allOk = compare_bool((f[2][1][4]), true) && allOk;
	allOk = compare_bool((f[2][1][5]), false) && allOk;
	allOk = compare_bool((f[2][1][6]), true) && allOk;
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
	d[0] = (ivec4(6, 9, -6, 2));
	d[1] = (ivec4(0, -5, 7, -8));
	d[2] = (ivec4(7, -3, -4, -3));
	e = i8vec2(ivec2(8, 1));
	f[0][0][0] = (false);
	f[0][0][1] = (true);
	f[0][0][2] = (true);
	f[0][0][3] = (false);
	f[0][0][4] = (true);
	f[0][0][5] = (true);
	f[0][0][6] = (true);
	f[0][0][7] = (false);
	f[0][1][0] = (false);
	f[0][1][1] = (true);
	f[0][1][2] = (false);
	f[0][1][3] = (true);
	f[0][1][4] = (true);
	f[0][1][5] = (false);
	f[0][1][6] = (false);
	f[0][1][7] = (true);
	f[0][2][0] = (true);
	f[0][2][1] = (false);
	f[0][2][2] = (true);
	f[0][2][3] = (true);
	f[0][2][4] = (false);
	f[0][2][5] = (true);
	f[0][2][6] = (false);
	f[0][2][7] = (true);
	f[0][3][0] = (false);
	f[0][3][1] = (false);
	f[0][3][2] = (false);
	f[0][3][3] = (false);
	f[0][3][4] = (true);
	f[0][3][5] = (true);
	f[0][3][6] = (false);
	f[0][3][7] = (false);
	f[0][4][0] = (false);
	f[0][4][1] = (false);
	f[0][4][2] = (false);
	f[0][4][3] = (true);
	f[0][4][4] = (false);
	f[0][4][5] = (false);
	f[0][4][6] = (true);
	f[0][4][7] = (false);
	f[0][5][0] = (false);
	f[0][5][1] = (false);
	f[0][5][2] = (true);
	f[0][5][3] = (false);
	f[0][5][4] = (true);
	f[0][5][5] = (false);
	f[0][5][6] = (true);
	f[0][5][7] = (true);
	f[0][6][0] = (true);
	f[0][6][1] = (true);
	f[0][6][2] = (true);
	f[0][6][3] = (false);
	f[0][6][4] = (false);
	f[0][6][5] = (false);
	f[0][6][6] = (false);
	f[0][6][7] = (false);
	f[1][0][0] = (true);
	f[1][0][1] = (false);
	f[1][0][2] = (false);
	f[1][0][3] = (false);
	f[1][0][4] = (true);
	f[1][0][5] = (true);
	f[1][0][6] = (true);
	f[1][0][7] = (true);
	f[1][1][0] = (true);
	f[1][1][1] = (true);
	f[1][1][2] = (true);
	f[1][1][3] = (false);
	f[1][1][4] = (true);
	f[1][1][5] = (true);
	f[1][1][6] = (true);
	f[1][1][7] = (true);
	f[1][2][0] = (false);
	f[1][2][1] = (true);
	f[1][2][2] = (false);
	f[1][2][3] = (false);
	f[1][2][4] = (true);
	f[1][2][5] = (false);
	f[1][2][6] = (false);
	f[1][2][7] = (false);
	f[1][3][0] = (true);
	f[1][3][1] = (false);
	f[1][3][2] = (false);
	f[1][3][3] = (false);
	f[1][3][4] = (true);
	f[1][3][5] = (true);
	f[1][3][6] = (false);
	f[1][3][7] = (true);
	f[1][4][0] = (false);
	f[1][4][1] = (true);
	f[1][4][2] = (false);
	f[1][4][3] = (true);
	f[1][4][4] = (true);
	f[1][4][5] = (true);
	f[1][4][6] = (true);
	f[1][4][7] = (true);
	f[1][5][0] = (false);
	f[1][5][1] = (false);
	f[1][5][2] = (false);
	f[1][5][3] = (false);
	f[1][5][4] = (false);
	f[1][5][5] = (true);
	f[1][5][6] = (false);
	f[1][5][7] = (false);
	f[1][6][0] = (true);
	f[1][6][1] = (false);
	f[1][6][2] = (true);
	f[1][6][3] = (true);
	f[1][6][4] = (true);
	f[1][6][5] = (true);
	f[1][6][6] = (false);
	f[1][6][7] = (true);
	f[2][0][0] = (true);
	f[2][0][1] = (false);
	f[2][0][2] = (true);
	f[2][0][3] = (false);
	f[2][0][4] = (false);
	f[2][0][5] = (true);
	f[2][0][6] = (false);
	f[2][0][7] = (false);
	f[2][1][0] = (false);
	f[2][1][1] = (true);
	f[2][1][2] = (false);
	f[2][1][3] = (true);
	f[2][1][4] = (false);
	f[2][1][5] = (true);
	f[2][1][6] = (false);
	f[2][1][7] = (true);
	f[2][2][0] = (true);
	f[2][2][1] = (false);
	f[2][2][2] = (false);
	f[2][2][3] = (true);
	f[2][2][4] = (true);
	f[2][2][5] = (false);
	f[2][2][6] = (true);
	f[2][2][7] = (false);
	f[2][3][0] = (true);
	f[2][3][1] = (true);
	f[2][3][2] = (true);
	f[2][3][3] = (false);
	f[2][3][4] = (false);
	f[2][3][5] = (false);
	f[2][3][6] = (false);
	f[2][3][7] = (false);
	f[2][4][0] = (false);
	f[2][4][1] = (false);
	f[2][4][2] = (false);
	f[2][4][3] = (false);
	f[2][4][4] = (false);
	f[2][4][5] = (true);
	f[2][4][6] = (true);
	f[2][4][7] = (false);
	f[2][5][0] = (true);
	f[2][5][1] = (false);
	f[2][5][2] = (false);
	f[2][5][3] = (false);
	f[2][5][4] = (true);
	f[2][5][5] = (false);
	f[2][5][6] = (true);
	f[2][5][7] = (false);
	f[2][6][0] = (true);
	f[2][6][1] = (true);
	f[2][6][2] = (false);
	f[2][6][3] = (true);
	f[2][6][4] = (true);
	f[2][6][5] = (false);
	f[2][6][6] = (true);
	f[2][6][7] = (false);
	f[3][0][0] = (false);
	f[3][0][1] = (true);
	f[3][0][2] = (false);
	f[3][0][3] = (false);
	f[3][0][4] = (false);
	f[3][0][5] = (false);
	f[3][0][6] = (true);
	f[3][0][7] = (false);
	f[3][1][0] = (false);
	f[3][1][1] = (false);
	f[3][1][2] = (false);
	f[3][1][3] = (false);
	f[3][1][4] = (true);
	f[3][1][5] = (true);
	f[3][1][6] = (false);
	f[3][1][7] = (false);
	f[3][2][0] = (true);
	f[3][2][1] = (false);
	f[3][2][2] = (true);
	f[3][2][3] = (true);
	f[3][2][4] = (false);
	f[3][2][5] = (false);
	f[3][2][6] = (true);
	f[3][2][7] = (true);
	f[3][3][0] = (false);
	f[3][3][1] = (false);
	f[3][3][2] = (true);
	f[3][3][3] = (true);
	f[3][3][4] = (false);
	f[3][3][5] = (true);
	f[3][3][6] = (true);
	f[3][3][7] = (false);
	f[3][4][0] = (false);
	f[3][4][1] = (false);
	f[3][4][2] = (false);
	f[3][4][3] = (false);
	f[3][4][4] = (false);
	f[3][4][5] = (false);
	f[3][4][6] = (true);
	f[3][4][7] = (true);
	f[3][5][0] = (false);
	f[3][5][1] = (false);
	f[3][5][2] = (true);
	f[3][5][3] = (true);
	f[3][5][4] = (true);
	f[3][5][5] = (true);
	f[3][5][6] = (true);
	f[3][5][7] = (true);
	f[3][6][0] = (false);
	f[3][6][1] = (true);
	f[3][6][2] = (true);
	f[3][6][3] = (false);
	f[3][6][4] = (true);
	f[3][6][5] = (true);
	f[3][6][6] = (true);
	f[3][6][7] = (true);
	f[4][0][0] = (true);
	f[4][0][1] = (false);
	f[4][0][2] = (true);
	f[4][0][3] = (false);
	f[4][0][4] = (false);
	f[4][0][5] = (false);
	f[4][0][6] = (false);
	f[4][0][7] = (true);
	f[4][1][0] = (true);
	f[4][1][1] = (true);
	f[4][1][2] = (true);
	f[4][1][3] = (false);
	f[4][1][4] = (true);
	f[4][1][5] = (true);
	f[4][1][6] = (false);
	f[4][1][7] = (false);
	f[4][2][0] = (false);
	f[4][2][1] = (true);
	f[4][2][2] = (true);
	f[4][2][3] = (false);
	f[4][2][4] = (false);
	f[4][2][5] = (false);
	f[4][2][6] = (true);
	f[4][2][7] = (false);
	f[4][3][0] = (true);
	f[4][3][1] = (false);
	f[4][3][2] = (true);
	f[4][3][3] = (true);
	f[4][3][4] = (true);
	f[4][3][5] = (false);
	f[4][3][6] = (true);
	f[4][3][7] = (true);
	f[4][4][0] = (true);
	f[4][4][1] = (true);
	f[4][4][2] = (true);
	f[4][4][3] = (false);
	f[4][4][4] = (false);
	f[4][4][5] = (true);
	f[4][4][6] = (false);
	f[4][4][7] = (true);
	f[4][5][0] = (false);
	f[4][5][1] = (false);
	f[4][5][2] = (false);
	f[4][5][3] = (true);
	f[4][5][4] = (false);
	f[4][5][5] = (true);
	f[4][5][6] = (false);
	f[4][5][7] = (false);
	f[4][6][0] = (false);
	f[4][6][1] = (true);
	f[4][6][2] = (true);
	f[4][6][3] = (true);
	f[4][6][4] = (false);
	f[4][6][5] = (true);
	f[4][6][6] = (false);
	f[4][6][7] = (false);
	f[5][0][0] = (false);
	f[5][0][1] = (false);
	f[5][0][2] = (true);
	f[5][0][3] = (true);
	f[5][0][4] = (false);
	f[5][0][5] = (true);
	f[5][0][6] = (true);
	f[5][0][7] = (true);
	f[5][1][0] = (false);
	f[5][1][1] = (true);
	f[5][1][2] = (false);
	f[5][1][3] = (false);
	f[5][1][4] = (true);
	f[5][1][5] = (true);
	f[5][1][6] = (true);
	f[5][1][7] = (false);
	f[5][2][0] = (true);
	f[5][2][1] = (false);
	f[5][2][2] = (false);
	f[5][2][3] = (true);
	f[5][2][4] = (false);
	f[5][2][5] = (false);
	f[5][2][6] = (true);
	f[5][2][7] = (false);
	f[5][3][0] = (false);
	f[5][3][1] = (false);
	f[5][3][2] = (true);
	f[5][3][3] = (true);
	f[5][3][4] = (false);
	f[5][3][5] = (false);
	f[5][3][6] = (true);
	f[5][3][7] = (false);
	f[5][4][0] = (false);
	f[5][4][1] = (false);
	f[5][4][2] = (false);
	f[5][4][3] = (false);
	f[5][4][4] = (true);
	f[5][4][5] = (false);
	f[5][4][6] = (true);
	f[5][4][7] = (false);
	f[5][5][0] = (false);
	f[5][5][1] = (false);
	f[5][5][2] = (false);
	f[5][5][3] = (true);
	f[5][5][4] = (false);
	f[5][5][5] = (true);
	f[5][5][6] = (true);
	f[5][5][7] = (true);
	f[5][6][0] = (true);
	f[5][6][1] = (true);
	f[5][6][2] = (true);
	f[5][6][3] = (true);
	f[5][6][4] = (false);
	f[5][6][5] = (true);
	f[5][6][6] = (false);
	f[5][6][7] = (true);
	g[0][0] = (mat3x4(-1.0, -6.0, 3.0, -7.0, -5.0, -2.0, -1.0, 6.0, -3.0, 2.0, 0.0, -2.0));
	g[0][1] = (mat3x4(0.0, 6.0, -9.0, 0.0, 8.0, 0.0, 2.0, 6.0, 7.0, 9.0, -4.0, -1.0));
	g[0][2] = (mat3x4(0.0, 3.0, -9.0, -8.0, 1.0, 4.0, -9.0, -5.0, 3.0, 8.0, -6.0, 3.0));
	g[0][3] = (mat3x4(-5.0, 5.0, -8.0, -8.0, 9.0, 4.0, 8.0, -9.0, -3.0, 7.0, 7.0, 3.0));
	g[0][4] = (mat3x4(8.0, -4.0, -6.0, 6.0, -7.0, 1.0, 1.0, 2.0, 6.0, -3.0, -3.0, 8.0));
	g[0][5] = (mat3x4(2.0, 8.0, 9.0, 7.0, 1.0, -8.0, 8.0, 2.0, 5.0, -8.0, -6.0, 4.0));
	g[0][6] = (mat3x4(-4.0, 2.0, 2.0, 9.0, 6.0, -5.0, -3.0, 3.0, -3.0, 3.0, 9.0, -1.0));
}
#version 450
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
	bvec4 a;
} blockB[];

bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB[nonuniformEXT(0)].a), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(1)].a), bvec4(false, false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (bvec4(true, true, true, true));
	blockB[nonuniformEXT(1)].a = (bvec4(false, true, false, false));
}
#version 450
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
	highp ivec2 var;
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((var), ivec2(-4, -6)) && allOk;
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
	highp mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var, mat2(6.0, 4.0, 9.0, 8.0)) && allOk;
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

}
#version 450
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

layout(std140, column_major, binding = 1) readonly buffer Block
{
	mediump mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], -7.0) && allOk;
	allOk = compare_float(var[0][2], 8.0) && allOk;
	allOk = compare_float(var[0][3], 6.0) && allOk;
	allOk = compare_float(var[1][0], -6.0) && allOk;
	allOk = compare_float(var[1][1], -7.0) && allOk;
	allOk = compare_float(var[1][2], 8.0) && allOk;
	allOk = compare_float(var[1][3], -2.0) && allOk;
	allOk = compare_vec4(var[0], vec4(1.0, -7.0, 8.0, 6.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-6.0, -7.0, 8.0, -2.0)) && allOk;
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
	mediump mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var, mat3x2(-4.0, 7.0, 7.0, -6.0, -4.0, 0.0)) && allOk;
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
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], 7.0) && allOk;
	allOk = compare_float(var[0][2], -7.0) && allOk;
	allOk = compare_float(var[1][0], 3.0) && allOk;
	allOk = compare_float(var[1][1], -1.0) && allOk;
	allOk = compare_float(var[1][2], -1.0) && allOk;
	allOk = compare_float(var[2][0], -1.0) && allOk;
	allOk = compare_float(var[2][1], -6.0) && allOk;
	allOk = compare_float(var[2][2], 6.0) && allOk;
	allOk = compare_float(var[3][0], 0.0) && allOk;
	allOk = compare_float(var[3][1], -3.0) && allOk;
	allOk = compare_float(var[3][2], 7.0) && allOk;
	allOk = compare_vec3(var[0], vec3(1.0, 7.0, -7.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(3.0, -1.0, -1.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-1.0, -6.0, 6.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(0.0, -3.0, 7.0)) && allOk;
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
	highp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -2.0) && allOk;
	allOk = compare_float(var[0][1], 6.0) && allOk;
	allOk = compare_float(var[0][2], -2.0) && allOk;
	allOk = compare_float(var[1][0], 8.0) && allOk;
	allOk = compare_float(var[1][1], 7.0) && allOk;
	allOk = compare_float(var[1][2], -2.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-2.0, 6.0, -2.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(8.0, 7.0, -2.0)) && allOk;
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
	mediump mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var, mat3x4(3.0, -9.0, -9.0, 1.0, -8.0, 0.0, 1.0, -9.0, 4.0, -4.0, -2.0, -5.0)) && allOk;
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

layout(scalar, row_major, binding = 1) readonly buffer Block
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
	allOk = compare_float((padding), 0.0) && allOk;
	allOk = compare_float(var[0][0], -4.0) && allOk;
	allOk = compare_float(var[0][1], -8.0) && allOk;
	allOk = compare_float(var[0][2], 0.0) && allOk;
	allOk = compare_float(var[1][0], -1.0) && allOk;
	allOk = compare_float(var[1][1], -6.0) && allOk;
	allOk = compare_float(var[1][2], -7.0) && allOk;
	allOk = compare_float(var[2][0], 4.0) && allOk;
	allOk = compare_float(var[2][1], -6.0) && allOk;
	allOk = compare_float(var[2][2], -6.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-4.0, -8.0, 0.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-1.0, -6.0, -7.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(4.0, -6.0, -6.0)) && allOk;
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

}
#version 450
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
	mediump mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_mat2x4(var, mat2x4(-3.0, -8.0, 0.0, 2.0, 7.0, -2.0, 7.0, -7.0)) && allOk;
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

}
#version 450
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
	highp mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_float(var[0][0], 2.0) && allOk;
	allOk = compare_float(var[0][1], -6.0) && allOk;
	allOk = compare_float(var[0][2], -2.0) && allOk;
	allOk = compare_float(var[1][0], 6.0) && allOk;
	allOk = compare_float(var[1][1], 2.0) && allOk;
	allOk = compare_float(var[1][2], 6.0) && allOk;
	allOk = compare_float(var[2][0], -8.0) && allOk;
	allOk = compare_float(var[2][1], 2.0) && allOk;
	allOk = compare_float(var[2][2], 0.0) && allOk;
	allOk = compare_float(var[3][0], -4.0) && allOk;
	allOk = compare_float(var[3][1], 8.0) && allOk;
	allOk = compare_float(var[3][2], 0.0) && allOk;
	allOk = compare_vec3(var[0], vec3(2.0, -6.0, -2.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(6.0, 2.0, 6.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-8.0, 2.0, 0.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(-4.0, 8.0, 0.0)) && allOk;
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
	allOk = compare_mat4(var[0], mat4(1.0, 6.0, 7.0, 5.0, 2.0, -4.0, 0.0, 8.0, 3.0, 3.0, 9.0, 8.0, -2.0, 7.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(-1.0, 1.0, 9.0, 1.0, -2.0, -7.0, 3.0, 5.0, 2.0, -8.0, 8.0, -1.0, -4.0, -5.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(-9.0, 1.0, 1.0, -6.0, 5.0, -8.0, -6.0, -3.0, -4.0, 8.0, 9.0, -9.0, -4.0, -2.0, -8.0, 8.0)) && allOk;
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
	highp mat3x4 var[3];
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
	allOk = compare_mat2x3(var[0], mat2x3(3.0, -1.0, 4.0, -3.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(7.0, 0.0, -3.0, 7.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(-3.0, -5.0, -4.0, -9.0, 1.0, -7.0)) && allOk;
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
	allOk = compare_mat4x2(var[0], mat4x2(9.0, 2.0, -3.0, -5.0, -5.0, -4.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(7.0, 7.0, -8.0, 9.0, -7.0, -5.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(-9.0, 8.0, 3.0, -7.0, 5.0, 3.0, 9.0, -8.0)) && allOk;
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
	highp mat3x2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -9.0) && allOk;
	allOk = compare_mat3x2(var[0], mat3x2(-4.0, -4.0, -7.0, 2.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(-9.0, -1.0, 0.0, -3.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(-5.0, 3.0, -3.0, 6.0, -8.0, -7.0)) && allOk;
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
	highp mat3x2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -1.0) && allOk;
	allOk = compare_mat3x2(var[0], mat3x2(4.0, -9.0, -1.0, -8.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(6.0, 3.0, 1.0, 8.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(-3.0, 3.0, -3.0, -4.0, 8.0, 1.0)) && allOk;
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
	highp mat4x2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_mat4x2(var[0], mat4x2(-2.0, -4.0, 7.0, -9.0, -9.0, -9.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(-1.0, -5.0, -9.0, -2.0, -2.0, 2.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(-8.0, -8.0, 1.0, 3.0, 0.0, -3.0, -9.0, 0.0)) && allOk;
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
	highp mat3 var[];
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
	allOk = compare_mat3(var[3], mat3(2.0, -8.0, 1.0, -2.0, 6.0, 7.0, 4.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat3(var[4], mat3(-9.0, -6.0, -4.0, -1.0, -5.0, 3.0, 3.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3(var[5], mat3(-2.0, 1.0, 6.0, -7.0, 4.0, -7.0, -8.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3(var[6], mat3(2.0, -3.0, 5.0, 3.0, -7.0, -5.0, 0.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3(var[7], mat3(8.0, 0.0, -4.0, 2.0, 4.0, -3.0, 6.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3(var[8], mat3(-2.0, -2.0, 5.0, 9.0, 8.0, -3.0, -5.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat3(var[9], mat3(7.0, 0.0, 8.0, -3.0, 5.0, -5.0, 0.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3(var[10], mat3(-9.0, -3.0, -8.0, -6.0, -2.0, -4.0, -5.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3(var[11], mat3(2.0, -1.0, 4.0, 7.0, -7.0, 4.0, -7.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3(var[12], mat3(9.0, 0.0, 6.0, 4.0, -2.0, 0.0, 6.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3(var[13], mat3(8.0, -5.0, -1.0, -6.0, 1.0, -4.0, 2.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(var[14], mat3(-1.0, -9.0, 3.0, -9.0, 7.0, -5.0, 5.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat3(var[15], mat3(-6.0, -7.0, 1.0, 6.0, -5.0, 2.0, -5.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3(var[16], mat3(-4.0, 8.0, -8.0, 1.0, -3.0, -3.0, -6.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(var[17], mat3(-2.0, 3.0, -9.0, -4.0, 3.0, -4.0, 8.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3(var[18], mat3(-4.0, 8.0, 5.0, -4.0, 1.0, 8.0, -7.0, -4.0, -7.0)) && allOk;
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

}
#version 450
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
	allOk = compare_mat2(block.var, mat2(3.0, 2.0, 7.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2(9.0, 6.0, -9.0, -4.0));
}
#version 450
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

layout(std430, column_major, buffer_reference) buffer Block
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
	allOk = compare_float(block.var[0][0], -9.0) && allOk;
	allOk = compare_float(block.var[0][1], 3.0) && allOk;
	allOk = compare_float(block.var[0][2], -6.0) && allOk;
	allOk = compare_float(block.var[0][3], -8.0) && allOk;
	allOk = compare_float(block.var[1][0], 2.0) && allOk;
	allOk = compare_float(block.var[1][1], 0.0) && allOk;
	allOk = compare_float(block.var[1][2], 8.0) && allOk;
	allOk = compare_float(block.var[1][3], 9.0) && allOk;
	allOk = compare_float(block.var[2][0], -9.0) && allOk;
	allOk = compare_float(block.var[2][1], -6.0) && allOk;
	allOk = compare_float(block.var[2][2], 3.0) && allOk;
	allOk = compare_float(block.var[2][3], 6.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-9.0, 3.0, -6.0, -8.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(2.0, 0.0, 8.0, 9.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(-9.0, -6.0, 3.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(-8.0, -3.0, 3.0, -7.0));
	block.var[1] = (vec4(7.0, 6.0, 3.0, -2.0));
	block.var[2] = (vec4(7.0, 7.0, -9.0, -7.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var, mat4x3(4.0, 1.0, 0.0, 3.0, 8.0, -3.0, -1.0, 2.0, -9.0, 8.0, -7.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x3(2.0, 9.0, 9.0, -3.0, 6.0, 1.0, 1.0, -1.0, -1.0, -5.0, -7.0, -2.0));
}
#version 450
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

layout(scalar, buffer_reference) buffer Block
{
	int padding;
	mediump ivec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((block.padding), -1) && allOk;
	allOk = compare_ivec4((block.var), ivec4(-2, -7, -7, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (3);
	block.var = (ivec4(4, -3, -6, -6));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.padding), -7.0) && allOk;
	allOk = compare_float(block.var[0][0], -4.0) && allOk;
	allOk = compare_float(block.var[0][1], 1.0) && allOk;
	allOk = compare_float(block.var[0][2], -5.0) && allOk;
	allOk = compare_float(block.var[0][3], 2.0) && allOk;
	allOk = compare_float(block.var[1][0], 8.0) && allOk;
	allOk = compare_float(block.var[1][1], 3.0) && allOk;
	allOk = compare_float(block.var[1][2], -8.0) && allOk;
	allOk = compare_float(block.var[1][3], 2.0) && allOk;
	allOk = compare_float(block.var[2][0], 8.0) && allOk;
	allOk = compare_float(block.var[2][1], 3.0) && allOk;
	allOk = compare_float(block.var[2][2], -6.0) && allOk;
	allOk = compare_float(block.var[2][3], -5.0) && allOk;
	allOk = compare_float(block.var[3][0], -5.0) && allOk;
	allOk = compare_float(block.var[3][1], -8.0) && allOk;
	allOk = compare_float(block.var[3][2], -8.0) && allOk;
	allOk = compare_float(block.var[3][3], 5.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-4.0, 1.0, -5.0, 2.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(8.0, 3.0, -8.0, 2.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(8.0, 3.0, -6.0, -5.0)) && allOk;
	allOk = compare_vec4(block.var[3], vec4(-5.0, -8.0, -8.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-5.0);
	block.var = (mat4(1.0, -7.0, 4.0, 0.0, 8.0, 8.0, 0.0, 6.0, 7.0, 7.0, -5.0, 7.0, -7.0, 8.0, -5.0, 3.0));
}
#version 450
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
	allOk = compare_float((block.padding), -1.0) && allOk;
	allOk = compare_mat2x3(block.var, mat2x3(-1.0, 3.0, 5.0, 6.0, 9.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-9.0);
	block.var = (mat2x3(-1.0, -7.0, 6.0, 0.0, -8.0, -2.0));
}
#version 450
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
    Block block;
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(block.padding), 3) && allOk;
	allOk = compare_i16vec2(ivec2(block.var), ivec2(-1, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = int16_t(6);
	block.var = i16vec2(ivec2(-2, -2));
}
#version 450
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
	allOk = compare_mat4(block.var[0], mat4(9.0, -2.0, -9.0, 2.0, -3.0, 8.0, -1.0, 2.0, 2.0, -5.0, -8.0, -6.0, -6.0, -3.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[1], mat4(0.0, 0.0, 8.0, -6.0, 7.0, -9.0, 0.0, 5.0, -6.0, -4.0, -7.0, 7.0, -3.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[2], mat4(4.0, 4.0, 2.0, -6.0, 2.0, 0.0, -9.0, -1.0, -3.0, 4.0, -3.0, 0.0, -2.0, -5.0, -7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4(7.0, 8.0, 6.0, 5.0, 7.0, 7.0, -1.0, -6.0, -2.0, -6.0, 5.0, 9.0, 8.0, -6.0, 9.0, -8.0));
	block.var[1] = (mat4(-7.0, -6.0, -1.0, 8.0, 2.0, -9.0, 8.0, -8.0, -3.0, 6.0, -8.0, 3.0, 0.0, -9.0, 1.0, 4.0));
	block.var[2] = (mat4(8.0, -2.0, 0.0, -2.0, 9.0, 2.0, -3.0, 0.0, 4.0, -8.0, 3.0, 2.0, 2.0, 2.0, 3.0, -6.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0], mat2(-7.0, -9.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(8.0, 9.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(8.0, -6.0, -3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec2(7.0, -3.0));
	block.var[0][1] = (vec2(-2.0, 4.0));
	block.var[1][0] = (vec2(1.0, -3.0));
	block.var[1][1] = (vec2(2.0, -4.0));
	block.var[2][0] = (vec2(-1.0, 1.0));
	block.var[2][1] = (vec2(-4.0, 3.0));
}
#version 450
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

layout(scalar, row_major, buffer_reference) buffer Block
{
	float padding;
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
	allOk = compare_float((block.padding), -6.0) && allOk;
	allOk = compare_mat3(block.var[0], mat3(-8.0, -3.0, -9.0, -1.0, 8.0, 8.0, 3.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(1.0, 3.0, 0.0, -1.0, -1.0, -1.0, 5.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(1.0, -7.0, 1.0, 3.0, 1.0, 1.0, 4.0, 0.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (8.0);
	block.var[0][0] = (vec3(6.0, 2.0, -9.0));
	block.var[0][1] = (vec3(-8.0, 5.0, 2.0));
	block.var[0][2] = (vec3(3.0, 9.0, 3.0));
	block.var[1][0] = (vec3(2.0, -9.0, -5.0));
	block.var[1][1] = (vec3(5.0, 8.0, 8.0));
	block.var[1][2] = (vec3(-3.0, -4.0, -5.0));
	block.var[2][0] = (vec3(3.0, -5.0, -4.0));
	block.var[2][1] = (vec3(-7.0, 5.0, 3.0));
	block.var[2][2] = (vec3(-3.0, -3.0, -8.0));
}
#version 450
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
	allOk = compare_float((block.padding), 5.0) && allOk;
	allOk = compare_mat2x3(block.var[0], mat2x3(-6.0, 5.0, -5.0, 8.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[1], mat2x3(3.0, 9.0, -4.0, 0.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[2], mat2x3(5.0, 5.0, -9.0, 2.0, -1.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-9.0);
	block.var[0] = (mat2x3(-1.0, 8.0, -5.0, -3.0, 4.0, -4.0));
	block.var[1] = (mat2x3(1.0, -5.0, 6.0, -8.0, -3.0, 0.0));
	block.var[2] = (mat2x3(2.0, -1.0, -7.0, 4.0, 6.0, 6.0));
}
#version 450
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
	allOk = compare_float((block.padding), 9.0) && allOk;
	allOk = compare_mat3x4(block.var[0], mat3x4(-4.0, -6.0, 2.0, -9.0, -8.0, 7.0, 0.0, 5.0, 3.0, 9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1], mat3x4(-7.0, 0.0, 6.0, -3.0, 8.0, 6.0, -6.0, -6.0, -4.0, 6.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2], mat3x4(5.0, -6.0, 7.0, -4.0, -9.0, -9.0, -4.0, -8.0, -8.0, 3.0, -1.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (3.0);
	block.var[0] = (mat3x4(-9.0, -6.0, 7.0, 6.0, -8.0, -1.0, 1.0, -9.0, 7.0, 6.0, 6.0, -5.0));
	block.var[1] = (mat3x4(-1.0, -8.0, 3.0, 9.0, 9.0, -8.0, 0.0, 0.0, -9.0, -6.0, -7.0, -3.0));
	block.var[2] = (mat3x4(-3.0, 9.0, -7.0, 4.0, 2.0, -8.0, 4.0, -6.0, -1.0, -9.0, 5.0, -5.0));
}
#version 450
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
	u16vec3 var[3];
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
	allOk = compare_u16vec3(uvec3(block.var[0]), uvec3(0u, 5u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1]), uvec3(0u, 0u, 7u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2]), uvec3(1u, 1u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = uint16_t(1u);
	block.var[0] = u16vec3(uvec3(2u, 6u, 8u));
	block.var[1] = u16vec3(uvec3(3u, 3u, 4u));
	block.var[2] = u16vec3(uvec3(4u, 9u, 7u));
}
#version 450
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
	allOk = compare_mat2(block.var[0], mat2(-6.0, 3.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(3.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(9.0, -5.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[3], mat2(0.0, 8.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[4], mat2(-8.0, -4.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[5], mat2(8.0, 1.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[6], mat2(-1.0, -4.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[7], mat2(0.0, -4.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[8], mat2(8.0, -3.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[9], mat2(5.0, -6.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[10], mat2(0.0, 1.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[11], mat2(4.0, 3.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[12], mat2(-8.0, 3.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[13], mat2(0.0, -5.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[14], mat2(-1.0, 2.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[15], mat2(-8.0, 0.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[16], mat2(-4.0, 3.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[17], mat2(-3.0, 4.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[18], mat2(3.0, 2.0, 3.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec2(-2.0, 1.0));
	block.var[0][1] = (vec2(-7.0, -1.0));
	block.var[1][0] = (vec2(5.0, -3.0));
	block.var[1][1] = (vec2(4.0, 8.0));
	block.var[2][0] = (vec2(-2.0, -6.0));
	block.var[2][1] = (vec2(-5.0, -1.0));
	block.var[3][0] = (vec2(3.0, 4.0));
	block.var[3][1] = (vec2(-8.0, 6.0));
	block.var[4][0] = (vec2(6.0, -2.0));
	block.var[4][1] = (vec2(1.0, 3.0));
	block.var[5][0] = (vec2(2.0, 1.0));
	block.var[5][1] = (vec2(7.0, -2.0));
	block.var[6][0] = (vec2(-4.0, 2.0));
	block.var[6][1] = (vec2(-1.0, -4.0));
	block.var[7][0] = (vec2(-5.0, -8.0));
	block.var[7][1] = (vec2(3.0, -7.0));
	block.var[8][0] = (vec2(5.0, 0.0));
	block.var[8][1] = (vec2(-4.0, -9.0));
	block.var[9][0] = (vec2(9.0, 1.0));
	block.var[9][1] = (vec2(7.0, 9.0));
	block.var[10][0] = (vec2(1.0, 3.0));
	block.var[10][1] = (vec2(-3.0, 7.0));
	block.var[11][0] = (vec2(1.0, 5.0));
	block.var[11][1] = (vec2(4.0, 1.0));
	block.var[12][0] = (vec2(-7.0, 2.0));
	block.var[12][1] = (vec2(-9.0, 3.0));
	block.var[13][0] = (vec2(7.0, 9.0));
	block.var[13][1] = (vec2(-8.0, 3.0));
	block.var[14][0] = (vec2(-8.0, -9.0));
	block.var[14][1] = (vec2(3.0, -5.0));
	block.var[15][0] = (vec2(7.0, 8.0));
	block.var[15][1] = (vec2(-8.0, 4.0));
	block.var[16][0] = (vec2(-4.0, 7.0));
	block.var[16][1] = (vec2(-4.0, -8.0));
	block.var[17][0] = (vec2(1.0, 0.0));
	block.var[17][1] = (vec2(0.0, -9.0));
	block.var[18][0] = (vec2(-4.0, 7.0));
	block.var[18][1] = (vec2(4.0, 1.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0], mat3x4(-6.0, 2.0, 7.0, -8.0, 9.0, -6.0, 1.0, 9.0, -9.0, 1.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1], mat3x4(-8.0, -5.0, -5.0, 5.0, -5.0, -3.0, 2.0, 1.0, 2.0, 8.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[2], mat3x4(3.0, 7.0, -5.0, 5.0, 6.0, -3.0, 8.0, -1.0, -1.0, -1.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[3], mat3x4(3.0, 2.0, 8.0, 7.0, 5.0, 9.0, -1.0, -1.0, -5.0, -3.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[4], mat3x4(4.0, -6.0, -8.0, 7.0, 0.0, -7.0, -9.0, 1.0, 0.0, -4.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[5], mat3x4(7.0, 9.0, 6.0, 6.0, 5.0, -9.0, 3.0, -1.0, -1.0, 4.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[6], mat3x4(2.0, 6.0, -1.0, 0.0, 8.0, 9.0, 6.0, 2.0, 2.0, 5.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[7], mat3x4(2.0, 6.0, 8.0, 7.0, -7.0, 9.0, 5.0, 7.0, 1.0, 1.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[8], mat3x4(1.0, 9.0, -1.0, -4.0, 9.0, -9.0, 9.0, 3.0, -1.0, -5.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat3x4(block.var[9], mat3x4(-1.0, 0.0, -4.0, -5.0, -8.0, 9.0, 5.0, -7.0, 6.0, -6.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[10], mat3x4(-8.0, -3.0, -4.0, -7.0, 2.0, 4.0, 4.0, -8.0, 0.0, -9.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[11], mat3x4(-5.0, -2.0, 0.0, -8.0, -7.0, -1.0, -3.0, 0.0, 4.0, 9.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[12], mat3x4(5.0, 2.0, -1.0, 6.0, -6.0, 4.0, 2.0, 5.0, 9.0, 7.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[13], mat3x4(-2.0, -5.0, 0.0, 0.0, 2.0, 5.0, 8.0, -5.0, 7.0, 5.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[14], mat3x4(-7.0, -9.0, 9.0, 1.0, -6.0, 3.0, 9.0, 6.0, -4.0, -6.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[15], mat3x4(0.0, -4.0, 4.0, -6.0, 0.0, -7.0, -2.0, 2.0, 1.0, 2.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[16], mat3x4(-4.0, -6.0, -6.0, 3.0, -4.0, 7.0, -9.0, 0.0, 4.0, 0.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[17], mat3x4(-7.0, -8.0, -8.0, -8.0, 9.0, 7.0, -9.0, -6.0, -2.0, 3.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[18], mat3x4(-2.0, -9.0, 2.0, -8.0, -3.0, 1.0, -5.0, 1.0, 3.0, 1.0, 5.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3x4(0.0, 0.0, -5.0, -3.0, -2.0, -8.0, -3.0, 0.0, -6.0, -6.0, 8.0, 5.0));
	block.var[1] = (mat3x4(8.0, 1.0, 7.0, 4.0, -7.0, -3.0, -4.0, 0.0, 6.0, 9.0, -2.0, 5.0));
	block.var[2] = (mat3x4(8.0, -2.0, 7.0, 3.0, -8.0, -8.0, 5.0, -7.0, -9.0, 1.0, 9.0, -3.0));
	block.var[3] = (mat3x4(-9.0, 4.0, -1.0, 0.0, 4.0, -3.0, -5.0, -7.0, 1.0, 2.0, -2.0, -6.0));
	block.var[4] = (mat3x4(3.0, 1.0, -1.0, -3.0, 5.0, 8.0, 1.0, 3.0, -9.0, 1.0, -2.0, 9.0));
	block.var[5] = (mat3x4(1.0, 5.0, 2.0, 4.0, 6.0, 3.0, 7.0, 0.0, 8.0, 8.0, -2.0, 7.0));
	block.var[6] = (mat3x4(-2.0, -7.0, -5.0, -7.0, -6.0, 8.0, 4.0, -6.0, 5.0, 6.0, -5.0, 8.0));
	block.var[7] = (mat3x4(-8.0, 8.0, -7.0, -4.0, -6.0, -9.0, 3.0, -6.0, -1.0, -2.0, -2.0, 2.0));
	block.var[8] = (mat3x4(6.0, -1.0, -9.0, -5.0, -4.0, 3.0, -7.0, 1.0, 2.0, 1.0, -1.0, 6.0));
	block.var[9] = (mat3x4(5.0, 5.0, -9.0, -4.0, 9.0, -4.0, 7.0, -6.0, 2.0, 1.0, -6.0, 1.0));
	block.var[10] = (mat3x4(-4.0, 7.0, -5.0, 0.0, 4.0, 0.0, 0.0, 0.0, 4.0, 0.0, -1.0, -9.0));
	block.var[11] = (mat3x4(-1.0, 3.0, -6.0, 6.0, 3.0, 8.0, 4.0, 4.0, 7.0, 8.0, 1.0, 7.0));
	block.var[12] = (mat3x4(-7.0, 8.0, 5.0, -1.0, 0.0, 6.0, 7.0, -1.0, 3.0, 5.0, -7.0, 2.0));
	block.var[13] = (mat3x4(9.0, -2.0, -7.0, -4.0, 7.0, 9.0, 9.0, -2.0, -7.0, -3.0, 9.0, 9.0));
	block.var[14] = (mat3x4(4.0, -7.0, 5.0, -1.0, -8.0, -1.0, -1.0, 1.0, -1.0, 6.0, 6.0, 9.0));
	block.var[15] = (mat3x4(3.0, 1.0, 7.0, 6.0, 8.0, 1.0, 8.0, -5.0, -5.0, -9.0, -1.0, -9.0));
	block.var[16] = (mat3x4(-1.0, 6.0, 3.0, -9.0, -4.0, -5.0, 2.0, -2.0, -2.0, -2.0, -2.0, 2.0));
	block.var[17] = (mat3x4(-7.0, -4.0, 6.0, -9.0, 6.0, -3.0, -9.0, 6.0, 3.0, 2.0, -5.0, -9.0));
	block.var[18] = (mat3x4(-5.0, 9.0, -5.0, 5.0, -4.0, 7.0, 7.0, -1.0, -9.0, 8.0, 2.0, -5.0));
}
#version 450
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
	f16vec4 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(block.var[0]), vec4(-8.0, -9.0, 9.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[1]), vec4(4.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[2]), vec4(-8.0, 6.0, 1.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[3]), vec4(4.0, 7.0, 5.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[4]), vec4(7.0, -4.0, -8.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[5]), vec4(-3.0, 6.0, -4.0, 5.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[6]), vec4(2.0, 3.0, -3.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[7]), vec4(9.0, -9.0, 0.0, 3.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[8]), vec4(2.0, -2.0, -4.0, -2.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[9]), vec4(-6.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[10]), vec4(7.0, 5.0, -9.0, 9.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[11]), vec4(8.0, 7.0, 9.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[12]), vec4(7.0, -7.0, -3.0, 1.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[13]), vec4(7.0, 0.0, -2.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[14]), vec4(-6.0, -5.0, 8.0, 0.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[15]), vec4(-9.0, 7.0, -3.0, -1.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[16]), vec4(2.0, 7.0, 0.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[17]), vec4(-7.0, 6.0, 0.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[18]), vec4(1.0, 0.0, -7.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = f16vec4(vec4(9.0, -6.0, 2.0, -8.0));
	block.var[1] = f16vec4(vec4(-7.0, -4.0, 2.0, -5.0));
	block.var[2] = f16vec4(vec4(9.0, 1.0, -6.0, 3.0));
	block.var[3] = f16vec4(vec4(-1.0, 4.0, -1.0, -8.0));
	block.var[4] = f16vec4(vec4(5.0, 8.0, 7.0, 0.0));
	block.var[5] = f16vec4(vec4(4.0, -5.0, -6.0, -8.0));
	block.var[6] = f16vec4(vec4(-6.0, 2.0, -4.0, 8.0));
	block.var[7] = f16vec4(vec4(-4.0, -1.0, 8.0, 9.0));
	block.var[8] = f16vec4(vec4(0.0, 0.0, -5.0, 5.0));
	block.var[9] = f16vec4(vec4(7.0, -6.0, -7.0, -8.0));
	block.var[10] = f16vec4(vec4(-3.0, -4.0, -7.0, 0.0));
	block.var[11] = f16vec4(vec4(-7.0, -2.0, 7.0, -1.0));
	block.var[12] = f16vec4(vec4(8.0, 3.0, -7.0, -9.0));
	block.var[13] = f16vec4(vec4(6.0, -8.0, -8.0, 3.0));
	block.var[14] = f16vec4(vec4(1.0, -6.0, -6.0, 9.0));
	block.var[15] = f16vec4(vec4(9.0, -7.0, 7.0, -4.0));
	block.var[16] = f16vec4(vec4(-3.0, 0.0, -5.0, -5.0));
	block.var[17] = f16vec4(vec4(-6.0, -7.0, -2.0, -8.0));
	block.var[18] = f16vec4(vec4(-3.0, -6.0, 7.0, 3.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0], mat3x4(9.0, -4.0, -6.0, 2.0, -9.0, -8.0, 7.0, 0.0, 5.0, 3.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1], mat3x4(9.0, -7.0, 0.0, 6.0, -3.0, 8.0, 6.0, -6.0, -6.0, -4.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[2], mat3x4(-7.0, 5.0, -6.0, 7.0, -4.0, -9.0, -9.0, -4.0, -8.0, -8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3x4(block.var[3], mat3x4(-5.0, 6.0, 2.0, -2.0, -3.0, 2.0, 4.0, -3.0, 5.0, 5.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[4], mat3x4(-6.0, 9.0, 8.0, 1.0, -2.0, 9.0, 1.0, -5.0, -9.0, 9.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[5], mat3x4(-4.0, 0.0, 9.0, -6.0, -9.0, -7.0, -7.0, 1.0, 1.0, 2.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[6], mat3x4(4.0, 6.0, -1.0, -2.0, -4.0, 0.0, 4.0, -8.0, 3.0, 4.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[7], mat3x4(8.0, 7.0, 4.0, -4.0, 0.0, 2.0, -5.0, 4.0, 0.0, 7.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[8], mat3x4(7.0, -8.0, 6.0, -8.0, -3.0, -8.0, 4.0, 7.0, 5.0, -2.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[9], mat3x4(-3.0, -4.0, 8.0, 5.0, -1.0, -5.0, -2.0, 2.0, -8.0, -8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[10], mat3x4(6.0, -3.0, -1.0, -3.0, -7.0, -6.0, 1.0, -7.0, -1.0, 8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[11], mat3x4(-1.0, -8.0, 0.0, 1.0, 7.0, -5.0, -6.0, 7.0, 5.0, -3.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[12], mat3x4(0.0, 6.0, 3.0, 9.0, -3.0, 9.0, 3.0, -5.0, -1.0, 6.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[13], mat3x4(-7.0, 6.0, 5.0, -7.0, -2.0, -4.0, 0.0, -8.0, 8.0, 9.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[14], mat3x4(4.0, 4.0, -6.0, -2.0, 7.0, 1.0, -3.0, -2.0, -6.0, -2.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[15], mat3x4(-6.0, -4.0, 8.0, -5.0, -5.0, 7.0, 3.0, -1.0, 7.0, -4.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[16], mat3x4(5.0, -1.0, 4.0, -5.0, -8.0, -7.0, 7.0, -6.0, -4.0, 6.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[17], mat3x4(-5.0, 3.0, 9.0, 0.0, 1.0, 3.0, -8.0, -9.0, 5.0, 8.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[18], mat3x4(-2.0, 9.0, -5.0, -3.0, 3.0, 5.0, 4.0, -7.0, -1.0, 4.0, -9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3x4(3.0, -9.0, -6.0, 7.0, 6.0, -8.0, -1.0, 1.0, -9.0, 7.0, 6.0, 6.0));
	block.var[1] = (mat3x4(-5.0, -1.0, -8.0, 3.0, 9.0, 9.0, -8.0, 0.0, 0.0, -9.0, -6.0, -7.0));
	block.var[2] = (mat3x4(-3.0, -3.0, 9.0, -7.0, 4.0, 2.0, -8.0, 4.0, -6.0, -1.0, -9.0, 5.0));
	block.var[3] = (mat3x4(-5.0, -5.0, -9.0, -1.0, -9.0, -3.0, 0.0, 2.0, 8.0, -5.0, 1.0, 4.0));
	block.var[4] = (mat3x4(-5.0, 5.0, -5.0, 2.0, -8.0, -3.0, 6.0, 1.0, 0.0, 1.0, 4.0, 6.0));
	block.var[5] = (mat3x4(-9.0, -1.0, -9.0, -6.0, 8.0, -9.0, -4.0, -6.0, -6.0, -1.0, -3.0, -7.0));
	block.var[6] = (mat3x4(-4.0, 2.0, -8.0, -7.0, -3.0, 6.0, 6.0, 8.0, -4.0, -1.0, 1.0, -9.0));
	block.var[7] = (mat3x4(9.0, -2.0, 4.0, 3.0, -2.0, 8.0, -4.0, 5.0, -8.0, 8.0, -2.0, 7.0));
	block.var[8] = (mat3x4(-6.0, 5.0, -8.0, -5.0, -7.0, -8.0, 3.0, 4.0, -7.0, 2.0, 3.0, 2.0));
	block.var[9] = (mat3x4(9.0, 2.0, -6.0, 4.0, 9.0, 6.0, 2.0, 0.0, 1.0, 0.0, -3.0, 2.0));
	block.var[10] = (mat3x4(-1.0, 4.0, -6.0, 4.0, -1.0, 3.0, 1.0, 3.0, 6.0, -6.0, -9.0, -9.0));
	block.var[11] = (mat3x4(-9.0, 1.0, -6.0, 4.0, 0.0, -2.0, -8.0, 9.0, 6.0, -9.0, 6.0, 7.0));
	block.var[12] = (mat3x4(-6.0, 0.0, 1.0, -2.0, 1.0, -4.0, -2.0, -6.0, -7.0, -8.0, 0.0, -8.0));
	block.var[13] = (mat3x4(0.0, 2.0, 9.0, -5.0, 9.0, -5.0, -4.0, 0.0, 4.0, 1.0, 0.0, -9.0));
	block.var[14] = (mat3x4(1.0, -1.0, -4.0, 9.0, 7.0, 3.0, 5.0, 1.0, 6.0, 6.0, 2.0, 2.0));
	block.var[15] = (mat3x4(8.0, -5.0, -9.0, 8.0, -3.0, -3.0, 9.0, -9.0, 6.0, -4.0, 9.0, 4.0));
	block.var[16] = (mat3x4(-8.0, 4.0, 7.0, 3.0, -1.0, -1.0, 9.0, -9.0, 8.0, -3.0, 9.0, -6.0));
	block.var[17] = (mat3x4(-4.0, 6.0, 2.0, 5.0, 3.0, 7.0, 3.0, 4.0, -4.0, 2.0, 0.0, 8.0));
	block.var[18] = (mat3x4(-8.0, 0.0, 8.0, -6.0, -2.0, -3.0, 6.0, 4.0, 9.0, -2.0, 4.0, 1.0));
}
#version 450
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

layout(scalar, row_major, buffer_reference) buffer Block
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
	allOk = compare_mat2(block.var[0], mat2(-2.0, -7.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(3.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(2.0, 8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[3], mat2(8.0, -4.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[4], mat2(-4.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[5], mat2(-6.0, 5.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[6], mat2(5.0, -4.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[7], mat2(1.0, 9.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[8], mat2(5.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[9], mat2(-6.0, -8.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[10], mat2(6.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[11], mat2(2.0, 1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[12], mat2(-9.0, 4.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[13], mat2(-8.0, 5.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[14], mat2(-9.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[15], mat2(-5.0, -4.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[16], mat2(1.0, 0.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[17], mat2(-9.0, 9.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[18], mat2(2.0, -4.0, -2.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2(3.0, 1.0, -4.0, -2.0));
	block.var[1] = (mat2(1.0, -4.0, -1.0, -3.0));
	block.var[2] = (mat2(-8.0, 5.0, -6.0, -2.0));
	block.var[3] = (mat2(8.0, -5.0, 0.0, -2.0));
	block.var[4] = (mat2(-1.0, -6.0, 4.0, -4.0));
	block.var[5] = (mat2(9.0, 7.0, -9.0, 0.0));
	block.var[6] = (mat2(2.0, -5.0, 9.0, 6.0));
	block.var[7] = (mat2(5.0, 8.0, -5.0, -7.0));
	block.var[8] = (mat2(-2.0, -9.0, -1.0, 8.0));
	block.var[9] = (mat2(-7.0, 5.0, -9.0, 3.0));
	block.var[10] = (mat2(-3.0, -1.0, -2.0, -9.0));
	block.var[11] = (mat2(5.0, 8.0, -2.0, 4.0));
	block.var[12] = (mat2(8.0, -7.0, 0.0, -7.0));
	block.var[13] = (mat2(-6.0, 8.0, 5.0, 2.0));
	block.var[14] = (mat2(5.0, -4.0, 3.0, 8.0));
	block.var[15] = (mat2(0.0, -2.0, 7.0, 4.0));
	block.var[16] = (mat2(4.0, -4.0, 0.0, 7.0));
	block.var[17] = (mat2(-7.0, 7.0, -1.0, 4.0));
	block.var[18] = (mat2(6.0, 1.0, 8.0, -1.0));
}
#version 450
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

layout(std140, buffer_reference) buffer Block
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
	allOk = compare_mat3x4(block.var[0][0], mat3x4(-3.0, 3.0, -8.0, 8.0, 6.0, -9.0, -3.0, -1.0, 6.0, 3.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1], mat3x4(2.0, -8.0, 1.0, 2.0, -6.0, 8.0, -8.0, -3.0, 2.0, 5.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2], mat3x4(-6.0, -3.0, 5.0, 7.0, 3.0, -1.0, -9.0, -1.0, 5.0, 0.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0], mat3x4(8.0, -1.0, -7.0, 5.0, -9.0, 3.0, -2.0, -3.0, 3.0, -3.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1], mat3x4(-3.0, -9.0, -1.0, -5.0, -4.0, -4.0, -6.0, 0.0, -3.0, -5.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2], mat3x4(-2.0, -4.0, 8.0, 3.0, -8.0, -8.0, 6.0, -5.0, -9.0, -1.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0], mat3x4(-9.0, -4.0, -3.0, -7.0, 2.0, -1.0, 8.0, -1.0, 3.0, -7.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1], mat3x4(-1.0, 9.0, 2.0, 4.0, 6.0, -7.0, -6.0, 4.0, -4.0, 5.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2], mat3x4(-2.0, 2.0, 0.0, 4.0, 8.0, 7.0, -4.0, -1.0, -4.0, -9.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0], mat3x4(0.0, 2.0, -8.0, 5.0, -6.0, 3.0, 1.0, -5.0, -3.0, -6.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1], mat3x4(4.0, 1.0, 9.0, 2.0, -4.0, -7.0, 1.0, 3.0, 1.0, -2.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][2], mat3x4(8.0, -5.0, -5.0, 4.0, 9.0, 5.0, -5.0, -3.0, 9.0, 0.0, -4.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat3x4(-8.0, -6.0, 4.0, -9.0, 7.0, -4.0, -7.0, 0.0, -6.0, -6.0, -3.0, 4.0));
	block.var[0][1] = (mat3x4(3.0, -2.0, -3.0, 4.0, 2.0, 8.0, 2.0, -4.0, 9.0, -1.0, 9.0, 7.0));
	block.var[0][2] = (mat3x4(1.0, -1.0, 1.0, 5.0, 5.0, -4.0, -7.0, -4.0, 0.0, 6.0, 2.0, 0.0));
	block.var[1][0] = (mat3x4(-6.0, 7.0, -1.0, 6.0, 4.0, -9.0, -9.0, -1.0, -8.0, 4.0, -6.0, 6.0));
	block.var[1][1] = (mat3x4(7.0, -8.0, -5.0, -9.0, -9.0, -2.0, 4.0, 1.0, -3.0, 3.0, -2.0, 2.0));
	block.var[1][2] = (mat3x4(-1.0, 2.0, -4.0, -7.0, 9.0, 2.0, -7.0, -8.0, -2.0, -3.0, 3.0, -4.0));
	block.var[2][0] = (mat3x4(6.0, 6.0, -8.0, 6.0, 2.0, 8.0, -6.0, 2.0, -8.0, 2.0, 6.0, 9.0));
	block.var[2][1] = (mat3x4(3.0, -3.0, 9.0, -1.0, 6.0, 2.0, -8.0, 0.0, 1.0, 1.0, -3.0, 0.0));
	block.var[2][2] = (mat3x4(9.0, 4.0, -6.0, 6.0, 2.0, 1.0, 9.0, -3.0, -3.0, -6.0, -6.0, -8.0));
	block.var[3][0] = (mat3x4(5.0, 0.0, -6.0, 3.0, 0.0, -8.0, 3.0, 9.0, -6.0, -2.0, 5.0, -8.0));
	block.var[3][1] = (mat3x4(0.0, -3.0, -8.0, 2.0, 8.0, 8.0, -1.0, 4.0, -6.0, 8.0, 9.0, 8.0));
	block.var[3][2] = (mat3x4(5.0, 7.0, 3.0, 7.0, 9.0, 9.0, 6.0, 5.0, 3.0, 5.0, 2.0, -8.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0], mat4x2(-5.0, -2.0, -4.0, 7.0, -9.0, -9.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1], mat4x2(-6.0, -1.0, -5.0, -9.0, -2.0, -2.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2], mat4x2(-3.0, -8.0, -8.0, 1.0, 3.0, 0.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0], mat4x2(0.0, -7.0, -1.0, 4.0, -3.0, -1.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1], mat4x2(0.0, 8.0, -9.0, -4.0, 3.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2], mat4x2(-8.0, -6.0, 1.0, -7.0, 1.0, -4.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0], mat4x2(4.0, -8.0, 7.0, 0.0, 5.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1], mat4x2(-9.0, -5.0, -3.0, 3.0, -3.0, 8.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2], mat4x2(-2.0, 0.0, 3.0, 5.0, 9.0, -9.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0], mat4x2(9.0, -1.0, 3.0, 6.0, 8.0, -8.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1], mat4x2(-3.0, -9.0, -2.0, 8.0, -2.0, 7.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][2], mat4x2(-5.0, 8.0, -6.0, -6.0, -3.0, -1.0, -8.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat4x2(0.0, -3.0, -2.0, 2.0, -2.0, -3.0, 5.0, -5.0));
	block.var[0][1] = (mat4x2(5.0, -6.0, -4.0, -1.0, 4.0, 7.0, -8.0, -2.0));
	block.var[0][2] = (mat4x2(-5.0, -1.0, -3.0, 6.0, -2.0, 0.0, -7.0, -7.0));
	block.var[1][0] = (mat4x2(2.0, 0.0, -6.0, 9.0, 1.0, -7.0, 4.0, -6.0));
	block.var[1][1] = (mat4x2(5.0, -4.0, -3.0, 8.0, -6.0, -1.0, -6.0, 7.0));
	block.var[1][2] = (mat4x2(4.0, 7.0, -6.0, 5.0, -4.0, -7.0, 2.0, 1.0));
	block.var[2][0] = (mat4x2(6.0, -3.0, -5.0, -7.0, -7.0, 4.0, -9.0, 7.0));
	block.var[2][1] = (mat4x2(2.0, 2.0, 9.0, 3.0, -1.0, -8.0, 1.0, -5.0));
	block.var[2][2] = (mat4x2(6.0, 2.0, -6.0, 4.0, -3.0, -6.0, -7.0, -8.0));
	block.var[3][0] = (mat4x2(-1.0, -4.0, -5.0, 2.0, -7.0, -1.0, 7.0, 1.0));
	block.var[3][1] = (mat4x2(9.0, -3.0, -8.0, 4.0, 5.0, -9.0, 9.0, -3.0));
	block.var[3][2] = (mat4x2(5.0, 6.0, -5.0, 1.0, 0.0, 8.0, -9.0, -4.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0], mat4x3(-2.0, 8.0, 0.0, 9.0, -7.0, -7.0, 8.0, 2.0, 7.0, 3.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1], mat4x3(9.0, -7.0, -6.0, -8.0, -6.0, 3.0, -8.0, -8.0, -4.0, 5.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2], mat4x3(-6.0, 1.0, 9.0, 4.0, -4.0, -7.0, 9.0, -3.0, -7.0, 9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0], mat4x3(1.0, 7.0, -4.0, 6.0, 0.0, 2.0, 2.0, 3.0, -9.0, 4.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1], mat4x3(5.0, 4.0, 8.0, -8.0, 0.0, 5.0, -5.0, 7.0, 9.0, -8.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2], mat4x3(6.0, 3.0, 0.0, -3.0, 0.0, -2.0, 5.0, 1.0, 1.0, 6.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0], mat4x3(5.0, -7.0, -7.0, -6.0, -9.0, 6.0, 7.0, -3.0, -3.0, 9.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1], mat4x3(2.0, 5.0, 2.0, 0.0, 9.0, -8.0, -2.0, -2.0, -1.0, -2.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2], mat4x3(-9.0, -1.0, -2.0, -2.0, 8.0, -3.0, -7.0, 1.0, -6.0, 8.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0], mat4x3(-5.0, -8.0, 7.0, 3.0, 7.0, 9.0, 7.0, 9.0, -2.0, -4.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1], mat4x3(5.0, 2.0, 7.0, 6.0, -5.0, -7.0, 3.0, -9.0, -5.0, -8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][2], mat4x3(-7.0, 4.0, 6.0, 2.0, 8.0, -1.0, 5.0, 2.0, 7.0, 1.0, 4.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec3(1.0, 3.0, -7.0));
	block.var[0][0][1] = (vec3(-7.0, 2.0, 3.0));
	block.var[0][0][2] = (vec3(1.0, -2.0, -1.0));
	block.var[0][0][3] = (vec3(-5.0, -1.0, 9.0));
	block.var[0][1][0] = (vec3(8.0, -4.0, 3.0));
	block.var[0][1][1] = (vec3(4.0, 9.0, -6.0));
	block.var[0][1][2] = (vec3(7.0, 6.0, -5.0));
	block.var[0][1][3] = (vec3(2.0, 6.0, 3.0));
	block.var[0][2][0] = (vec3(2.0, 7.0, -1.0));
	block.var[0][2][1] = (vec3(-3.0, -3.0, -7.0));
	block.var[0][2][2] = (vec3(-5.0, 3.0, 4.0));
	block.var[0][2][3] = (vec3(-4.0, -2.0, 8.0));
	block.var[1][0][0] = (vec3(-1.0, -8.0, 8.0));
	block.var[1][0][1] = (vec3(-4.0, -7.0, -7.0));
	block.var[1][0][2] = (vec3(8.0, 4.0, -6.0));
	block.var[1][0][3] = (vec3(6.0, 0.0, 1.0));
	block.var[1][1][0] = (vec3(7.0, -1.0, -8.0));
	block.var[1][1][1] = (vec3(9.0, 9.0, -6.0));
	block.var[1][1][2] = (vec3(0.0, 1.0, 1.0));
	block.var[1][1][3] = (vec3(2.0, 7.0, 2.0));
	block.var[1][2][0] = (vec3(-3.0, -6.0, 5.0));
	block.var[1][2][1] = (vec3(3.0, -1.0, -1.0));
	block.var[1][2][2] = (vec3(-2.0, 9.0, -5.0));
	block.var[1][2][3] = (vec3(8.0, -6.0, -5.0));
	block.var[2][0][0] = (vec3(-9.0, 3.0, -2.0));
	block.var[2][0][1] = (vec3(5.0, 6.0, -7.0));
	block.var[2][0][2] = (vec3(-8.0, 1.0, 8.0));
	block.var[2][0][3] = (vec3(1.0, 6.0, -1.0));
	block.var[2][1][0] = (vec3(-5.0, 0.0, -6.0));
	block.var[2][1][1] = (vec3(5.0, -3.0, 2.0));
	block.var[2][1][2] = (vec3(-5.0, 2.0, -2.0));
	block.var[2][1][3] = (vec3(-7.0, -9.0, -1.0));
	block.var[2][2][0] = (vec3(-2.0, -3.0, -7.0));
	block.var[2][2][1] = (vec3(-9.0, -4.0, 9.0));
	block.var[2][2][2] = (vec3(4.0, -4.0, 5.0));
	block.var[2][2][3] = (vec3(7.0, 1.0, 7.0));
	block.var[3][0][0] = (vec3(-9.0, 5.0, 4.0));
	block.var[3][0][1] = (vec3(4.0, 0.0, 0.0));
	block.var[3][0][2] = (vec3(0.0, -3.0, 3.0));
	block.var[3][0][3] = (vec3(1.0, 8.0, 0.0));
	block.var[3][1][0] = (vec3(-2.0, 9.0, -8.0));
	block.var[3][1][1] = (vec3(-8.0, 7.0, -9.0));
	block.var[3][1][2] = (vec3(3.0, -2.0, -3.0));
	block.var[3][1][3] = (vec3(-5.0, 1.0, -4.0));
	block.var[3][2][0] = (vec3(5.0, 5.0, 8.0));
	block.var[3][2][1] = (vec3(3.0, 7.0, -3.0));
	block.var[3][2][2] = (vec3(-2.0, 2.0, -9.0));
	block.var[3][2][3] = (vec3(0.0, 9.0, 5.0));
}
#version 450
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
	u8vec2 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(block.var[0][0]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[0][1]), uvec2(7u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[0][2]), uvec2(4u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][0]), uvec2(7u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][1]), uvec2(9u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][2]), uvec2(7u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][0]), uvec2(8u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][1]), uvec2(6u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][2]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[3][0]), uvec2(1u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[3][1]), uvec2(2u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[3][2]), uvec2(3u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = u8vec2(uvec2(7u, 7u));
	block.var[0][1] = u8vec2(uvec2(9u, 6u));
	block.var[0][2] = u8vec2(uvec2(0u, 2u));
	block.var[1][0] = u8vec2(uvec2(1u, 1u));
	block.var[1][1] = u8vec2(uvec2(0u, 8u));
	block.var[1][2] = u8vec2(uvec2(8u, 5u));
	block.var[2][0] = u8vec2(uvec2(2u, 7u));
	block.var[2][1] = u8vec2(uvec2(4u, 4u));
	block.var[2][2] = u8vec2(uvec2(7u, 2u));
	block.var[3][0] = u8vec2(uvec2(4u, 5u));
	block.var[3][1] = u8vec2(uvec2(0u, 2u));
	block.var[3][2] = u8vec2(uvec2(1u, 8u));
}
#version 450
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
	float16_t var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(block.var[0][0]), -7.0) && allOk;
	allOk = compare_float16_t(float(block.var[0][1]), 4.0) && allOk;
	allOk = compare_float16_t(float(block.var[0][2]), 2.0) && allOk;
	allOk = compare_float16_t(float(block.var[1][0]), 0.0) && allOk;
	allOk = compare_float16_t(float(block.var[1][1]), 5.0) && allOk;
	allOk = compare_float16_t(float(block.var[1][2]), 9.0) && allOk;
	allOk = compare_float16_t(float(block.var[2][0]), 5.0) && allOk;
	allOk = compare_float16_t(float(block.var[2][1]), 4.0) && allOk;
	allOk = compare_float16_t(float(block.var[2][2]), 7.0) && allOk;
	allOk = compare_float16_t(float(block.var[3][0]), 5.0) && allOk;
	allOk = compare_float16_t(float(block.var[3][1]), 1.0) && allOk;
	allOk = compare_float16_t(float(block.var[3][2]), -3.0) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = float16_t(-8.0);
	block.var[0][1] = float16_t(9.0);
	block.var[0][2] = float16_t(-2.0);
	block.var[1][0] = float16_t(7.0);
	block.var[1][1] = float16_t(8.0);
	block.var[1][2] = float16_t(-9.0);
	block.var[2][0] = float16_t(2.0);
	block.var[2][1] = float16_t(-8.0);
	block.var[2][2] = float16_t(-1.0);
	block.var[3][0] = float16_t(6.0);
	block.var[3][1] = float16_t(-7.0);
	block.var[3][2] = float16_t(-5.0);
}
#version 450
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
	highp uint var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((block.var[0][0]), 3u) && allOk;
	allOk = compare_uint((block.var[0][1]), 6u) && allOk;
	allOk = compare_uint((block.var[0][2]), 9u) && allOk;
	allOk = compare_uint((block.var[1][0]), 0u) && allOk;
	allOk = compare_uint((block.var[1][1]), 3u) && allOk;
	allOk = compare_uint((block.var[1][2]), 7u) && allOk;
	allOk = compare_uint((block.var[2][0]), 6u) && allOk;
	allOk = compare_uint((block.var[2][1]), 4u) && allOk;
	allOk = compare_uint((block.var[2][2]), 2u) && allOk;
	allOk = compare_uint((block.var[3][0]), 5u) && allOk;
	allOk = compare_uint((block.var[3][1]), 7u) && allOk;
	allOk = compare_uint((block.var[3][2]), 5u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (7u);
	block.var[0][1] = (9u);
	block.var[0][2] = (1u);
	block.var[1][0] = (0u);
	block.var[1][1] = (7u);
	block.var[1][2] = (7u);
	block.var[2][0] = (4u);
	block.var[2][1] = (8u);
	block.var[2][2] = (7u);
	block.var[3][0] = (5u);
	block.var[3][1] = (7u);
	block.var[3][2] = (2u);
}
#version 450
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
	allOk = compare_mat4(block.var[0][0], mat4(6.0, 9.0, -9.0, 2.0, -1.0, -3.0, 3.0, 6.0, 5.0, 1.0, -3.0, -2.0, 3.0, -6.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[0][1], mat4(8.0, 2.0, 9.0, 5.0, 5.0, 3.0, -9.0, -5.0, -8.0, 6.0, -6.0, -7.0, -6.0, 0.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[0][2], mat4(-3.0, 5.0, 8.0, -1.0, -4.0, 4.0, 3.0, -8.0, 1.0, -1.0, 7.0, 4.0, -2.0, 1.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[1][0], mat4(4.0, 1.0, -4.0, 3.0, 4.0, -1.0, -9.0, 8.0, 1.0, -9.0, -9.0, -8.0, 1.0, 0.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[1][1], mat4(1.0, -4.0, 9.0, -7.0, -6.0, -2.0, -7.0, -4.0, 1.0, 2.0, 6.0, -8.0, 3.0, -2.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[1][2], mat4(-9.0, 7.0, -4.0, -2.0, 4.0, 5.0, 5.0, -2.0, 4.0, -6.0, 1.0, -3.0, -4.0, 6.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[2][0], mat4(-7.0, -5.0, -1.0, -9.0, -5.0, 6.0, -9.0, 5.0, 2.0, -2.0, -8.0, 4.0, -3.0, 7.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[2][1], mat4(8.0, 4.0, 5.0, 8.0, -5.0, 9.0, 7.0, 1.0, -8.0, -2.0, -1.0, -2.0, -8.0, -2.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[2][2], mat4(3.0, 0.0, -4.0, -2.0, -4.0, 0.0, -6.0, 4.0, 0.0, 1.0, -6.0, -3.0, 6.0, -1.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[3][0], mat4(-3.0, 5.0, -5.0, 7.0, -3.0, -5.0, 5.0, 9.0, 1.0, 8.0, -5.0, 8.0, 9.0, 0.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[3][1], mat4(3.0, 1.0, 2.0, -2.0, -6.0, 0.0, 3.0, 9.0, 3.0, 0.0, 2.0, 8.0, 7.0, -6.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[3][2], mat4(-3.0, 8.0, 8.0, 7.0, 0.0, 0.0, 3.0, 0.0, -3.0, -4.0, 5.0, -6.0, 4.0, -4.0, 5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec4(0.0, -7.0, -8.0, 3.0));
	block.var[0][0][1] = (vec4(-4.0, 2.0, 2.0, 9.0));
	block.var[0][0][2] = (vec4(0.0, 4.0, -1.0, -5.0));
	block.var[0][0][3] = (vec4(4.0, 0.0, -6.0, -6.0));
	block.var[0][1][0] = (vec4(-6.0, 3.0, 9.0, -6.0));
	block.var[0][1][1] = (vec4(2.0, 5.0, 4.0, -7.0));
	block.var[0][1][2] = (vec4(1.0, -4.0, 3.0, 5.0));
	block.var[0][1][3] = (vec4(-6.0, 0.0, -6.0, -4.0));
	block.var[0][2][0] = (vec4(1.0, 6.0, 0.0, 8.0));
	block.var[0][2][1] = (vec4(-9.0, 0.0, 8.0, 4.0));
	block.var[0][2][2] = (vec4(-2.0, -5.0, -6.0, -8.0));
	block.var[0][2][3] = (vec4(-5.0, 8.0, 8.0, -7.0));
	block.var[1][0][0] = (vec4(4.0, -5.0, 7.0, 9.0));
	block.var[1][0][1] = (vec4(4.0, -5.0, 4.0, -7.0));
	block.var[1][0][2] = (vec4(6.0, -1.0, 4.0, 5.0));
	block.var[1][0][3] = (vec4(-7.0, 7.0, 7.0, -6.0));
	block.var[1][1][0] = (vec4(-8.0, 9.0, -5.0, 0.0));
	block.var[1][1][1] = (vec4(5.0, -7.0, 8.0, -7.0));
	block.var[1][1][2] = (vec4(2.0, -8.0, 8.0, -7.0));
	block.var[1][1][3] = (vec4(6.0, -4.0, -6.0, -2.0));
	block.var[1][2][0] = (vec4(7.0, -2.0, -9.0, 2.0));
	block.var[1][2][1] = (vec4(7.0, -4.0, -9.0, 0.0));
	block.var[1][2][2] = (vec4(6.0, -3.0, 3.0, 6.0));
	block.var[1][2][3] = (vec4(3.0, -4.0, 8.0, -2.0));
	block.var[2][0][0] = (vec4(-7.0, 3.0, -4.0, -1.0));
	block.var[2][0][1] = (vec4(-6.0, -7.0, -3.0, -9.0));
	block.var[2][0][2] = (vec4(9.0, -1.0, -3.0, -5.0));
	block.var[2][0][3] = (vec4(8.0, 1.0, -1.0, -3.0));
	block.var[2][1][0] = (vec4(-4.0, -2.0, -3.0, 5.0));
	block.var[2][1][1] = (vec4(-9.0, -3.0, 8.0, 4.0));
	block.var[2][1][2] = (vec4(2.0, 2.0, 2.0, -1.0));
	block.var[2][1][3] = (vec4(0.0, -1.0, -1.0, 4.0));
	block.var[2][2][0] = (vec4(1.0, 1.0, 4.0, -2.0));
	block.var[2][2][1] = (vec4(5.0, -5.0, 9.0, 2.0));
	block.var[2][2][2] = (vec4(6.0, -2.0, 5.0, 3.0));
	block.var[2][2][3] = (vec4(-7.0, 0.0, 4.0, 3.0));
	block.var[3][0][0] = (vec4(2.0, -7.0, 5.0, 7.0));
	block.var[3][0][1] = (vec4(-5.0, 0.0, -9.0, -7.0));
	block.var[3][0][2] = (vec4(2.0, 7.0, -9.0, 7.0));
	block.var[3][0][3] = (vec4(-2.0, -5.0, 4.0, 3.0));
	block.var[3][1][0] = (vec4(6.0, 3.0, 8.0, 9.0));
	block.var[3][1][1] = (vec4(8.0, -4.0, -4.0, 4.0));
	block.var[3][1][2] = (vec4(-9.0, -3.0, 0.0, -3.0));
	block.var[3][1][3] = (vec4(0.0, 8.0, -3.0, 6.0));
	block.var[3][2][0] = (vec4(-8.0, -5.0, 6.0, -7.0));
	block.var[3][2][1] = (vec4(-6.0, -5.0, 7.0, -6.0));
	block.var[3][2][2] = (vec4(-1.0, 8.0, 9.0, 6.0));
	block.var[3][2][3] = (vec4(8.0, -7.0, 0.0, -8.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0], mat3x2(0.0, -1.0, 5.0, 2.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1], mat3x2(-2.0, -3.0, -9.0, 0.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2], mat3x2(6.0, -9.0, -2.0, 6.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0], mat3x2(8.0, -7.0, 1.0, -5.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1], mat3x2(4.0, -3.0, -4.0, -9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2], mat3x2(8.0, 4.0, 1.0, 2.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0], mat3x2(6.0, 6.0, -8.0, 5.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1], mat3x2(-9.0, -8.0, -5.0, -4.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2], mat3x2(-7.0, -9.0, 9.0, -7.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0], mat3x2(8.0, -7.0, 7.0, 6.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1], mat3x2(2.0, -1.0, 5.0, 6.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][2], mat3x2(-7.0, -5.0, 7.0, 1.0, 5.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec2(-2.0, 8.0));
	block.var[0][0][1] = (vec2(1.0, 8.0));
	block.var[0][0][2] = (vec2(-7.0, 5.0));
	block.var[0][1][0] = (vec2(2.0, 0.0));
	block.var[0][1][1] = (vec2(-3.0, 1.0));
	block.var[0][1][2] = (vec2(2.0, -5.0));
	block.var[0][2][0] = (vec2(6.0, 3.0));
	block.var[0][2][1] = (vec2(6.0, 5.0));
	block.var[0][2][2] = (vec2(-5.0, 9.0));
	block.var[1][0][0] = (vec2(-8.0, 9.0));
	block.var[1][0][1] = (vec2(3.0, -3.0));
	block.var[1][0][2] = (vec2(3.0, -5.0));
	block.var[1][1][0] = (vec2(7.0, -8.0));
	block.var[1][1][1] = (vec2(3.0, 1.0));
	block.var[1][1][2] = (vec2(-2.0, 1.0));
	block.var[1][2][0] = (vec2(4.0, -9.0));
	block.var[1][2][1] = (vec2(3.0, 6.0));
	block.var[1][2][2] = (vec2(7.0, 1.0));
	block.var[2][0][0] = (vec2(9.0, -9.0));
	block.var[2][0][1] = (vec2(0.0, -6.0));
	block.var[2][0][2] = (vec2(-7.0, 7.0));
	block.var[2][1][0] = (vec2(-8.0, 7.0));
	block.var[2][1][1] = (vec2(9.0, 6.0));
	block.var[2][1][2] = (vec2(-1.0, 0.0));
	block.var[2][2][0] = (vec2(-3.0, 6.0));
	block.var[2][2][1] = (vec2(-1.0, -6.0));
	block.var[2][2][2] = (vec2(-1.0, -3.0));
	block.var[3][0][0] = (vec2(0.0, -1.0));
	block.var[3][0][1] = (vec2(4.0, -9.0));
	block.var[3][0][2] = (vec2(1.0, 1.0));
	block.var[3][1][0] = (vec2(-9.0, 7.0));
	block.var[3][1][1] = (vec2(0.0, 4.0));
	block.var[3][1][2] = (vec2(-3.0, -3.0));
	block.var[3][2][0] = (vec2(6.0, 8.0));
	block.var[3][2][1] = (vec2(-7.0, 5.0));
	block.var[3][2][2] = (vec2(-6.0, -5.0));
}
#version 450
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
	u8vec3 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(block.var[0][0]), uvec3(4u, 3u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[0][1]), uvec3(1u, 4u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[0][2]), uvec3(8u, 6u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[1][0]), uvec3(6u, 4u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[1][1]), uvec3(5u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[1][2]), uvec3(1u, 4u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[2][0]), uvec3(3u, 8u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[2][1]), uvec3(6u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[2][2]), uvec3(4u, 0u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[3][0]), uvec3(9u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[3][1]), uvec3(0u, 2u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[3][2]), uvec3(9u, 0u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = u8vec3(uvec3(4u, 5u, 9u));
	block.var[0][1] = u8vec3(uvec3(6u, 9u, 4u));
	block.var[0][2] = u8vec3(uvec3(7u, 1u, 5u));
	block.var[1][0] = u8vec3(uvec3(1u, 7u, 9u));
	block.var[1][1] = u8vec3(uvec3(3u, 4u, 3u));
	block.var[1][2] = u8vec3(uvec3(5u, 7u, 4u));
	block.var[2][0] = u8vec3(uvec3(5u, 4u, 7u));
	block.var[2][1] = u8vec3(uvec3(0u, 0u, 5u));
	block.var[2][2] = u8vec3(uvec3(2u, 5u, 5u));
	block.var[3][0] = u8vec3(uvec3(5u, 9u, 6u));
	block.var[3][1] = u8vec3(uvec3(9u, 7u, 3u));
	block.var[3][2] = u8vec3(uvec3(9u, 4u, 9u));
}
#version 450
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
	allOk = compare_float((block.padding), 5.0) && allOk;
	allOk = compare_mat2x3(block.var[0][0], mat2x3(-6.0, 5.0, -5.0, 8.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1], mat2x3(3.0, 9.0, -4.0, 0.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2], mat2x3(5.0, 5.0, -9.0, 2.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0], mat2x3(4.0, 4.0, -4.0, -1.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1], mat2x3(-7.0, -1.0, 6.0, 8.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2], mat2x3(-8.0, 9.0, 5.0, 9.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0], mat2x3(-2.0, 6.0, 6.0, 9.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1], mat2x3(3.0, 0.0, 3.0, -6.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2], mat2x3(-8.0, 9.0, -3.0, -9.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0], mat2x3(-8.0, 9.0, 2.0, -9.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1], mat2x3(-9.0, -4.0, -1.0, -1.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][2], mat2x3(-5.0, 9.0, -8.0, -1.0, 7.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-9.0);
	block.var[0][0] = (mat2x3(-1.0, 8.0, -5.0, -3.0, 4.0, -4.0));
	block.var[0][1] = (mat2x3(1.0, -5.0, 6.0, -8.0, -3.0, 0.0));
	block.var[0][2] = (mat2x3(2.0, -1.0, -7.0, 4.0, 6.0, 6.0));
	block.var[1][0] = (mat2x3(-3.0, 0.0, 5.0, 9.0, 2.0, -9.0));
	block.var[1][1] = (mat2x3(9.0, -7.0, 2.0, 6.0, -3.0, 8.0));
	block.var[1][2] = (mat2x3(-9.0, 7.0, -1.0, -3.0, 7.0, -4.0));
	block.var[2][0] = (mat2x3(-1.0, -5.0, 7.0, -3.0, -6.0, 1.0));
	block.var[2][1] = (mat2x3(3.0, 3.0, 1.0, 9.0, -7.0, -4.0));
	block.var[2][2] = (mat2x3(-1.0, -4.0, 1.0, -9.0, 4.0, -7.0));
	block.var[3][0] = (mat2x3(-6.0, -1.0, -1.0, 0.0, -4.0, 5.0));
	block.var[3][1] = (mat2x3(-6.0, -9.0, -6.0, -5.0, 0.0, -2.0));
	block.var[3][2] = (mat2x3(-6.0, 3.0, -3.0, -1.0, -6.0, -1.0));
}
#version 450
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
	i8vec3 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(block.padding), 4294967295) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[0][0]), ivec3(4294967290, 1, 4294967293)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[0][1]), ivec3(4294967289, 3, 7)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[0][2]), ivec3(9, 4294967292, 5)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[1][0]), ivec3(4294967288, 6, 9)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[1][1]), ivec3(0, 4294967291, 4294967290)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[1][2]), ivec3(4294967292, 1, 4294967289)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[2][0]), ivec3(4294967293, 4294967295, 8)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[2][1]), ivec3(6, 4294967295, 2)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[2][2]), ivec3(3, 5, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[3][0]), ivec3(4294967288, 6, 9)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[3][1]), ivec3(7, 4294967290, 2)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[3][2]), ivec3(4294967294, 0, 7)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = int8_t(4294967292);
	block.var[0][0] = i8vec3(ivec3(0, 0, 7));
	block.var[0][1] = i8vec3(ivec3(9, 4294967290, 4294967288));
	block.var[0][2] = i8vec3(ivec3(9, 4294967288, 4294967293));
	block.var[1][0] = i8vec3(ivec3(3, 4294967295, 9));
	block.var[1][1] = i8vec3(ivec3(7, 5, 5));
	block.var[1][2] = i8vec3(ivec3(4294967293, 6, 4294967293));
	block.var[2][0] = i8vec3(ivec3(4294967295, 3, 5));
	block.var[2][1] = i8vec3(ivec3(4294967292, 4294967295, 4294967293));
	block.var[2][2] = i8vec3(ivec3(8, 4294967290, 3));
	block.var[3][0] = i8vec3(ivec3(7, 4, 4294967292));
	block.var[3][1] = i8vec3(ivec3(8, 8, 4294967294));
	block.var[3][2] = i8vec3(ivec3(8, 1, 7));
}
#version 450
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
	u16vec3 var[4][3];
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
	allOk = compare_u16vec3(uvec3(block.var[0][0]), uvec3(0u, 5u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[0][1]), uvec3(0u, 0u, 7u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[0][2]), uvec3(1u, 1u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][0]), uvec3(4u, 3u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][1]), uvec3(7u, 2u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][2]), uvec3(0u, 8u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][0]), uvec3(8u, 6u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][1]), uvec3(6u, 1u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][2]), uvec3(3u, 9u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[3][0]), uvec3(0u, 9u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[3][1]), uvec3(3u, 3u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[3][2]), uvec3(6u, 3u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = uint16_t(1u);
	block.var[0][0] = u16vec3(uvec3(2u, 6u, 8u));
	block.var[0][1] = u16vec3(uvec3(3u, 3u, 4u));
	block.var[0][2] = u16vec3(uvec3(4u, 9u, 7u));
	block.var[1][0] = u16vec3(uvec3(5u, 4u, 5u));
	block.var[1][1] = u16vec3(uvec3(6u, 5u, 7u));
	block.var[1][2] = u16vec3(uvec3(0u, 6u, 4u));
	block.var[2][0] = u16vec3(uvec3(7u, 0u, 4u));
	block.var[2][1] = u16vec3(uvec3(2u, 1u, 0u));
	block.var[2][2] = u16vec3(uvec3(2u, 8u, 0u));
	block.var[3][0] = u16vec3(uvec3(7u, 0u, 2u));
	block.var[3][1] = u16vec3(uvec3(8u, 7u, 1u));
	block.var[3][2] = u16vec3(uvec3(2u, 8u, 1u));
}
#version 450
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
	f16vec2 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(block.padding), -6.0) && allOk;
	allOk = compare_f16vec2(vec2(block.var[0][0]), vec2(-3.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[0][1]), vec2(-5.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[0][2]), vec2(3.0, 2.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][0]), vec2(-1.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][1]), vec2(-5.0, -7.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][2]), vec2(-2.0, 4.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][0]), vec2(6.0, 3.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][1]), vec2(-3.0, 0.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][2]), vec2(-8.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[3][0]), vec2(8.0, 7.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[3][1]), vec2(1.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[3][2]), vec2(-3.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = float16_t(-2.0);
	block.var[0][0] = f16vec2(vec2(4.0, -2.0));
	block.var[0][1] = f16vec2(vec2(4.0, -1.0));
	block.var[0][2] = f16vec2(vec2(1.0, 9.0));
	block.var[1][0] = f16vec2(vec2(4.0, 8.0));
	block.var[1][1] = f16vec2(vec2(-8.0, 1.0));
	block.var[1][2] = f16vec2(vec2(-3.0, 2.0));
	block.var[2][0] = f16vec2(vec2(2.0, -6.0));
	block.var[2][1] = f16vec2(vec2(5.0, 5.0));
	block.var[2][2] = f16vec2(vec2(-7.0, 3.0));
	block.var[3][0] = f16vec2(vec2(0.0, -2.0));
	block.var[3][1] = f16vec2(vec2(3.0, -6.0));
	block.var[3][2] = f16vec2(vec2(5.0, 6.0));
}
#version 450
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

layout(scalar, buffer_reference) buffer Block
{
	float padding;
	highp vec3 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.padding), 7.0) && allOk;
	allOk = compare_vec3((block.var[0][0][0]), vec3(9.0, -6.0, -9.0)) && allOk;
	allOk = compare_vec3((block.var[0][0][1]), vec3(5.0, -8.0, 1.0)) && allOk;
	allOk = compare_vec3((block.var[0][0][2]), vec3(-1.0, 7.0, -1.0)) && allOk;
	allOk = compare_vec3((block.var[0][1][0]), vec3(5.0, 8.0, 2.0)) && allOk;
	allOk = compare_vec3((block.var[0][1][1]), vec3(6.0, 1.0, 8.0)) && allOk;
	allOk = compare_vec3((block.var[0][1][2]), vec3(9.0, 6.0, 6.0)) && allOk;
	allOk = compare_vec3((block.var[1][0][0]), vec3(-9.0, 3.0, -7.0)) && allOk;
	allOk = compare_vec3((block.var[1][0][1]), vec3(-2.0, -4.0, 3.0)) && allOk;
	allOk = compare_vec3((block.var[1][0][2]), vec3(3.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec3((block.var[1][1][0]), vec3(-8.0, 0.0, -6.0)) && allOk;
	allOk = compare_vec3((block.var[1][1][1]), vec3(-1.0, 2.0, 2.0)) && allOk;
	allOk = compare_vec3((block.var[1][1][2]), vec3(7.0, -9.0, -8.0)) && allOk;
	allOk = compare_vec3((block.var[2][0][0]), vec3(-4.0, 0.0, 5.0)) && allOk;
	allOk = compare_vec3((block.var[2][0][1]), vec3(6.0, 5.0, -3.0)) && allOk;
	allOk = compare_vec3((block.var[2][0][2]), vec3(5.0, 7.0, 8.0)) && allOk;
	allOk = compare_vec3((block.var[2][1][0]), vec3(-2.0, 6.0, 8.0)) && allOk;
	allOk = compare_vec3((block.var[2][1][1]), vec3(7.0, -2.0, 9.0)) && allOk;
	allOk = compare_vec3((block.var[2][1][2]), vec3(2.0, 9.0, 9.0)) && allOk;
	allOk = compare_vec3((block.var[3][0][0]), vec3(5.0, 8.0, 5.0)) && allOk;
	allOk = compare_vec3((block.var[3][0][1]), vec3(-8.0, -5.0, -7.0)) && allOk;
	allOk = compare_vec3((block.var[3][0][2]), vec3(-3.0, 7.0, -1.0)) && allOk;
	allOk = compare_vec3((block.var[3][1][0]), vec3(4.0, 9.0, -5.0)) && allOk;
	allOk = compare_vec3((block.var[3][1][1]), vec3(0.0, -8.0, -2.0)) && allOk;
	allOk = compare_vec3((block.var[3][1][2]), vec3(-4.0, 3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (5.0);
	block.var[0][0][0] = (vec3(4.0, 7.0, 8.0));
	block.var[0][0][1] = (vec3(-2.0, 7.0, -5.0));
	block.var[0][0][2] = (vec3(-7.0, 9.0, 6.0));
	block.var[0][1][0] = (vec3(5.0, 1.0, -9.0));
	block.var[0][1][1] = (vec3(6.0, -2.0, -8.0));
	block.var[0][1][2] = (vec3(-9.0, 3.0, 4.0));
	block.var[1][0][0] = (vec3(6.0, 0.0, -5.0));
	block.var[1][0][1] = (vec3(2.0, -8.0, 5.0));
	block.var[1][0][2] = (vec3(0.0, 2.0, 0.0));
	block.var[1][1][0] = (vec3(-2.0, -9.0, -2.0));
	block.var[1][1][1] = (vec3(6.0, -7.0, 6.0));
	block.var[1][1][2] = (vec3(-4.0, 3.0, 3.0));
	block.var[2][0][0] = (vec3(5.0, 1.0, -5.0));
	block.var[2][0][1] = (vec3(0.0, 1.0, 0.0));
	block.var[2][0][2] = (vec3(7.0, -2.0, -2.0));
	block.var[2][1][0] = (vec3(3.0, -7.0, 2.0));
	block.var[2][1][1] = (vec3(9.0, 0.0, 5.0));
	block.var[2][1][2] = (vec3(9.0, 4.0, -1.0));
	block.var[3][0][0] = (vec3(8.0, -1.0, -1.0));
	block.var[3][0][1] = (vec3(5.0, 1.0, -1.0));
	block.var[3][0][2] = (vec3(-3.0, 8.0, -4.0));
	block.var[3][1][0] = (vec3(6.0, -1.0, 4.0));
	block.var[3][1][1] = (vec3(2.0, -8.0, -3.0));
	block.var[3][1][2] = (vec3(2.0, -9.0, -5.0));
}
#version 450
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
	allOk = compare_float((block.padding), -8.0) && allOk;
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(-5.0, -1.0, 5.0, 3.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(-5.0, -1.0, -7.0, 3.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][2], mat3x2(7.0, 0.0, 5.0, 0.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(-1.0, -9.0, 4.0, 2.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(6.0, 2.0, 9.0, 9.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][2], mat3x2(7.0, 5.0, -3.0, -1.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(-5.0, -4.0, 5.0, 8.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(-6.0, -8.0, -7.0, 9.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][2], mat3x2(3.0, 6.0, 9.0, 1.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(-8.0, 5.0, 4.0, -3.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(-9.0, 0.0, 9.0, -6.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][2], mat3x2(-7.0, -7.0, -4.0, -7.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(-8.0, -9.0, 9.0, -1.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(8.0, -1.0, -4.0, -2.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][2], mat3x2(8.0, 8.0, -5.0, -5.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(8.0, 5.0, 5.0, -7.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(5.0, 8.0, 9.0, 1.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][2], mat3x2(4.0, 6.0, 3.0, -5.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][0], mat3x2(8.0, -3.0, -8.0, -5.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][1], mat3x2(7.0, 5.0, -3.0, 8.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][2], mat3x2(-3.0, -1.0, -1.0, -3.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][0], mat3x2(-9.0, -1.0, 8.0, 0.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][1], mat3x2(-8.0, -1.0, 6.0, 5.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][2], mat3x2(-6.0, 1.0, -9.0, 2.0, 1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-4.0);
	block.var[0][0][0][0] = (vec2(-6.0, 1.0));
	block.var[0][0][0][1] = (vec2(-3.0, -1.0));
	block.var[0][0][0][2] = (vec2(-9.0, 3.0));
	block.var[0][0][1][0] = (vec2(-2.0, 5.0));
	block.var[0][0][1][1] = (vec2(-8.0, 2.0));
	block.var[0][0][1][2] = (vec2(-9.0, 1.0));
	block.var[0][0][2][0] = (vec2(-5.0, 0.0));
	block.var[0][0][2][1] = (vec2(-2.0, 2.0));
	block.var[0][0][2][2] = (vec2(-1.0, -7.0));
	block.var[0][1][0][0] = (vec2(-9.0, -8.0));
	block.var[0][1][0][1] = (vec2(9.0, -1.0));
	block.var[0][1][0][2] = (vec2(-6.0, -5.0));
	block.var[0][1][1][0] = (vec2(7.0, -8.0));
	block.var[0][1][1][1] = (vec2(-6.0, 1.0));
	block.var[0][1][1][2] = (vec2(-5.0, -3.0));
	block.var[0][1][2][0] = (vec2(8.0, -2.0));
	block.var[0][1][2][1] = (vec2(3.0, -2.0));
	block.var[0][1][2][2] = (vec2(5.0, 7.0));
	block.var[1][0][0][0] = (vec2(9.0, -8.0));
	block.var[1][0][0][1] = (vec2(7.0, 1.0));
	block.var[1][0][0][2] = (vec2(-9.0, -5.0));
	block.var[1][0][1][0] = (vec2(-5.0, 9.0));
	block.var[1][0][1][1] = (vec2(3.0, -3.0));
	block.var[1][0][1][2] = (vec2(-6.0, 1.0));
	block.var[1][0][2][0] = (vec2(3.0, -3.0));
	block.var[1][0][2][1] = (vec2(-4.0, -9.0));
	block.var[1][0][2][2] = (vec2(4.0, -2.0));
	block.var[1][1][0][0] = (vec2(-3.0, 4.0));
	block.var[1][1][0][1] = (vec2(5.0, -9.0));
	block.var[1][1][0][2] = (vec2(3.0, 6.0));
	block.var[1][1][1][0] = (vec2(-1.0, -6.0));
	block.var[1][1][1][1] = (vec2(-5.0, 7.0));
	block.var[1][1][1][2] = (vec2(-6.0, 1.0));
	block.var[1][1][2][0] = (vec2(8.0, 7.0));
	block.var[1][1][2][1] = (vec2(-1.0, 2.0));
	block.var[1][1][2][2] = (vec2(6.0, -6.0));
	block.var[2][0][0][0] = (vec2(-3.0, -5.0));
	block.var[2][0][0][1] = (vec2(1.0, -5.0));
	block.var[2][0][0][2] = (vec2(8.0, 7.0));
	block.var[2][0][1][0] = (vec2(8.0, -1.0));
	block.var[2][0][1][1] = (vec2(-3.0, -8.0));
	block.var[2][0][1][2] = (vec2(5.0, 6.0));
	block.var[2][0][2][0] = (vec2(6.0, 0.0));
	block.var[2][0][2][1] = (vec2(-8.0, -6.0));
	block.var[2][0][2][2] = (vec2(-4.0, -6.0));
	block.var[2][1][0][0] = (vec2(5.0, 6.0));
	block.var[2][1][0][1] = (vec2(-8.0, -2.0));
	block.var[2][1][0][2] = (vec2(-1.0, -3.0));
	block.var[2][1][1][0] = (vec2(-3.0, -5.0));
	block.var[2][1][1][1] = (vec2(8.0, 8.0));
	block.var[2][1][1][2] = (vec2(-7.0, -6.0));
	block.var[2][1][2][0] = (vec2(6.0, -9.0));
	block.var[2][1][2][1] = (vec2(5.0, -5.0));
	block.var[2][1][2][2] = (vec2(8.0, 4.0));
	block.var[3][0][0][0] = (vec2(-5.0, 8.0));
	block.var[3][0][0][1] = (vec2(5.0, -9.0));
	block.var[3][0][0][2] = (vec2(0.0, 6.0));
	block.var[3][0][1][0] = (vec2(-3.0, 6.0));
	block.var[3][0][1][1] = (vec2(0.0, 1.0));
	block.var[3][0][1][2] = (vec2(6.0, 4.0));
	block.var[3][0][2][0] = (vec2(4.0, 0.0));
	block.var[3][0][2][1] = (vec2(-1.0, -2.0));
	block.var[3][0][2][2] = (vec2(2.0, -1.0));
	block.var[3][1][0][0] = (vec2(-5.0, 1.0));
	block.var[3][1][0][1] = (vec2(4.0, 8.0));
	block.var[3][1][0][2] = (vec2(1.0, 8.0));
	block.var[3][1][1][0] = (vec2(-4.0, -6.0));
	block.var[3][1][1][1] = (vec2(2.0, -5.0));
	block.var[3][1][1][2] = (vec2(-5.0, -4.0));
	block.var[3][1][2][0] = (vec2(1.0, 2.0));
	block.var[3][1][2][1] = (vec2(4.0, -6.0));
	block.var[3][1][2][2] = (vec2(8.0, -6.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0][0][0], mat2x3(-2.0, 3.0, -3.0, 8.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][1], mat2x3(-4.0, -6.0, -3.0, -8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][0], mat2x3(-5.0, 0.0, 2.0, -8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][1], mat2x3(-7.0, 0.0, -6.0, -3.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2][0], mat2x3(-2.0, -9.0, 4.0, -4.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2][1], mat2x3(2.0, -4.0, 4.0, -9.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][3][0], mat2x3(-9.0, 5.0, -1.0, 6.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][3][1], mat2x3(-5.0, 6.0, -5.0, 8.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][0], mat2x3(1.0, -5.0, 8.0, -3.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][1], mat2x3(6.0, -1.0, -8.0, 3.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][0], mat2x3(2.0, 2.0, 8.0, 8.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][1], mat2x3(5.0, -5.0, 7.0, 3.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2][0], mat2x3(-7.0, 4.0, -6.0, 9.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2][1], mat2x3(-7.0, -3.0, 0.0, 1.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][3][0], mat2x3(-5.0, -6.0, -1.0, -9.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][3][1], mat2x3(-7.0, -3.0, -9.0, 9.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][0], mat2x3(4.0, 7.0, 2.0, -2.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][1], mat2x3(0.0, 3.0, 1.0, 1.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][0], mat2x3(-4.0, 4.0, -6.0, -4.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][1], mat2x3(-1.0, 2.0, 6.0, 0.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2][0], mat2x3(-3.0, -2.0, -4.0, -6.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2][1], mat2x3(-2.0, -6.0, -4.0, 5.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][3][0], mat2x3(-9.0, -2.0, 1.0, 4.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][3][1], mat2x3(-5.0, -4.0, 9.0, 7.0, -4.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2x3(0.0, 4.0, 4.0, 5.0, -5.0, 2.0));
	block.var[0][0][1] = (mat2x3(8.0, -1.0, -2.0, -7.0, -8.0, -2.0));
	block.var[0][1][0] = (mat2x3(9.0, 0.0, 7.0, 7.0, 9.0, -8.0));
	block.var[0][1][1] = (mat2x3(5.0, 5.0, 1.0, 6.0, 3.0, -6.0));
	block.var[0][2][0] = (mat2x3(3.0, -4.0, -5.0, -4.0, -9.0, 4.0));
	block.var[0][2][1] = (mat2x3(6.0, 3.0, -4.0, 1.0, -8.0, 2.0));
	block.var[0][3][0] = (mat2x3(-1.0, 7.0, -6.0, -6.0, -1.0, 0.0));
	block.var[0][3][1] = (mat2x3(-1.0, 2.0, 7.0, 6.0, -8.0, 6.0));
	block.var[1][0][0] = (mat2x3(2.0, -2.0, 7.0, -9.0, 7.0, -7.0));
	block.var[1][0][1] = (mat2x3(-5.0, 6.0, 8.0, -8.0, 0.0, 2.0));
	block.var[1][1][0] = (mat2x3(8.0, 9.0, 6.0, 7.0, 0.0, -6.0));
	block.var[1][1][1] = (mat2x3(-7.0, 6.0, 4.0, 8.0, 5.0, -1.0));
	block.var[1][2][0] = (mat2x3(-4.0, 6.0, 9.0, 8.0, -3.0, 4.0));
	block.var[1][2][1] = (mat2x3(-7.0, -8.0, 0.0, -7.0, 6.0, 7.0));
	block.var[1][3][0] = (mat2x3(7.0, -3.0, -1.0, 9.0, -1.0, -7.0));
	block.var[1][3][1] = (mat2x3(-2.0, 1.0, 4.0, -5.0, -8.0, -5.0));
	block.var[2][0][0] = (mat2x3(7.0, -9.0, -2.0, -9.0, -1.0, -1.0));
	block.var[2][0][1] = (mat2x3(-4.0, -3.0, 7.0, 9.0, 0.0, -4.0));
	block.var[2][1][0] = (mat2x3(4.0, 4.0, 9.0, 9.0, -8.0, 6.0));
	block.var[2][1][1] = (mat2x3(6.0, 3.0, 8.0, 3.0, 4.0, 4.0));
	block.var[2][2][0] = (mat2x3(8.0, 2.0, 8.0, 2.0, 1.0, 6.0));
	block.var[2][2][1] = (mat2x3(-1.0, 8.0, 1.0, -8.0, -1.0, 2.0));
	block.var[2][3][0] = (mat2x3(2.0, 1.0, 2.0, 5.0, -4.0, -5.0));
	block.var[2][3][1] = (mat2x3(-6.0, 9.0, -2.0, 0.0, 5.0, -9.0));
}
#version 450
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
	allOk = compare_ivec3((block.s[0].a), ivec3(-9, 8, -1)) && allOk;
	allOk = compare_mat3(block.s[0].b[0], mat3(8.0, -5.0, 2.0, -8.0, -6.0, -3.0, 6.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3(block.s[0].b[1], mat3(-1.0, 9.0, 0.0, -9.0, 1.0, -2.0, 4.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat3(block.s[0].b[2], mat3(-4.0, 2.0, 9.0, 7.0, 3.0, -4.0, -7.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat3(block.s[0].b[3], mat3(3.0, 0.0, 1.0, -6.0, -7.0, -3.0, 4.0, 4.0, -9.0)) && allOk;
	allOk = compare_vec4((block.s[0].c), vec4(4.0, 4.0, 3.0, 1.0)) && allOk;
	allOk = compare_ivec3((block.s[1].a), ivec3(-3, 2, -9)) && allOk;
	allOk = compare_mat3(block.s[1].b[0], mat3(-3.0, 1.0, 2.0, 4.0, 1.0, -6.0, 6.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3(block.s[1].b[1], mat3(-2.0, -9.0, -8.0, -2.0, 3.0, 1.0, -5.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat3(block.s[1].b[2], mat3(-2.0, 2.0, 0.0, 7.0, 0.0, -4.0, 8.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat3(block.s[1].b[3], mat3(9.0, 4.0, -3.0, -6.0, 1.0, 1.0, 1.0, 8.0, 2.0)) && allOk;
	allOk = compare_vec4((block.s[1].c), vec4(-4.0, 2.0, -2.0, 4.0)) && allOk;
	allOk = compare_ivec3((block.s[2].a), ivec3(4, -3, 9)) && allOk;
	allOk = compare_mat3(block.s[2].b[0], mat3(-1.0, 1.0, -1.0, 7.0, -3.0, -2.0, 1.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3(block.s[2].b[1], mat3(9.0, -6.0, -9.0, -2.0, -9.0, -1.0, -1.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat3(block.s[2].b[2], mat3(2.0, -2.0, -3.0, 4.0, -9.0, 4.0, 6.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat3(block.s[2].b[3], mat3(-8.0, 7.0, -9.0, 1.0, 1.0, -2.0, 9.0, 3.0, -3.0)) && allOk;
	allOk = compare_vec4((block.s[2].c), vec4(-8.0, 0.0, 3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s[0].a = (ivec3(-5, -8, 6));
	block.s[0].b[0] = (mat3(2.0, -5.0, 6.0, -6.0, -5.0, -4.0, -9.0, 4.0, 6.0));
	block.s[0].b[1] = (mat3(-9.0, 6.0, 7.0, -3.0, 2.0, -8.0, 1.0, 5.0, 1.0));
	block.s[0].b[2] = (mat3(7.0, -8.0, -3.0, -4.0, 9.0, -3.0, -3.0, -4.0, 4.0));
	block.s[0].b[3] = (mat3(-8.0, -1.0, -1.0, -8.0, 4.0, -9.0, -6.0, -5.0, 7.0));
	block.s[0].c = (vec4(-9.0, 6.0, 7.0, 0.0));
	block.s[1].a = (ivec3(-9, -9, -8));
	block.s[1].b[0] = (mat3(-8.0, 5.0, 2.0, -1.0, -3.0, -6.0, 0.0, -5.0, 8.0));
	block.s[1].b[1] = (mat3(2.0, -3.0, -7.0, 0.0, 2.0, 8.0, 7.0, -6.0, -7.0));
	block.s[1].b[2] = (mat3(2.0, -1.0, 5.0, 3.0, -4.0, 0.0, 8.0, -7.0, -2.0));
	block.s[1].b[3] = (mat3(-4.0, 0.0, 5.0, -6.0, -4.0, 4.0, 9.0, 4.0, 1.0));
	block.s[1].c = (vec4(8.0, 2.0, -2.0, 2.0));
	block.s[2].a = (ivec3(0, -1, -9));
	block.s[2].b[0] = (mat3(-7.0, -5.0, 9.0, -9.0, 8.0, -8.0, 3.0, 9.0, 2.0));
	block.s[2].b[1] = (mat3(2.0, 6.0, 0.0, -4.0, 4.0, 9.0, -1.0, 9.0, -8.0));
	block.s[2].b[2] = (mat3(-5.0, -3.0, 3.0, 6.0, -6.0, 9.0, -9.0, -8.0, -8.0));
	block.s[2].b[3] = (mat3(7.0, 2.0, 5.0, -5.0, -4.0, 5.0, -1.0, -8.0, -1.0));
	block.s[2].c = (vec4(7.0, -1.0, -8.0, -7.0));
	block.v = (vec4(3.0, -3.0, 4.0, 2.0));
}
#version 450
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
layout(std430, buffer_reference) buffer Block
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
	allOk = compare_ivec3((block.s[0].a), ivec3(2, -1, -2)) && allOk;
	allOk = compare_mat3(block.s[0].b[0], mat3(2.0, 5.0, -3.0, -2.0, -3.0, -7.0, 7.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3(block.s[0].b[1], mat3(8.0, 8.0, 1.0, -5.0, -8.0, -8.0, -8.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat3(block.s[0].b[2], mat3(-8.0, -7.0, 8.0, -2.0, -6.0, -6.0, -8.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat3(block.s[0].b[3], mat3(9.0, 9.0, -7.0, -1.0, 5.0, -4.0, 1.0, 5.0, -1.0)) && allOk;
	allOk = compare_vec4((block.s[0].c), vec4(1.0, 6.0, 1.0, 4.0)) && allOk;
	allOk = compare_ivec3((block.s[1].a), ivec3(7, 2, 9)) && allOk;
	allOk = compare_mat3(block.s[1].b[0], mat3(-5.0, -4.0, 9.0, 5.0, 0.0, 4.0, -5.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat3(block.s[1].b[1], mat3(-6.0, -8.0, -7.0, 2.0, 7.0, -1.0, -5.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3(block.s[1].b[2], mat3(6.0, 8.0, -5.0, 6.0, 0.0, 4.0, 5.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat3(block.s[1].b[3], mat3(8.0, 2.0, 8.0, -7.0, -2.0, 4.0, -2.0, 9.0, -8.0)) && allOk;
	allOk = compare_vec4((block.s[1].c), vec4(3.0, 9.0, -2.0, -3.0)) && allOk;
	allOk = compare_ivec3((block.s[2].a), ivec3(0, 5, 4)) && allOk;
	allOk = compare_mat3(block.s[2].b[0], mat3(4.0, -8.0, 5.0, 4.0, 9.0, -3.0, 5.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat3(block.s[2].b[1], mat3(0.0, -6.0, 6.0, -2.0, -8.0, 9.0, -8.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3(block.s[2].b[2], mat3(5.0, 6.0, 1.0, 9.0, -1.0, 7.0, -4.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat3(block.s[2].b[3], mat3(-4.0, -9.0, -3.0, -3.0, 6.0, 1.0, -4.0, 3.0, 8.0)) && allOk;
	allOk = compare_vec4((block.s[2].c), vec4(-3.0, -2.0, 8.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s[0].a = (ivec3(0, 1, 6));
	block.s[0].b[0][0] = (vec3(4.0, -5.0, 1.0));
	block.s[0].b[0][1] = (vec3(8.0, -2.0, -1.0));
	block.s[0].b[0][2] = (vec3(-5.0, -4.0, -2.0));
	block.s[0].b[1][0] = (vec3(0.0, 2.0, 6.0));
	block.s[0].b[1][1] = (vec3(8.0, 8.0, 8.0));
	block.s[0].b[1][2] = (vec3(9.0, 9.0, -4.0));
	block.s[0].b[2][0] = (vec3(4.0, -1.0, -8.0));
	block.s[0].b[2][1] = (vec3(7.0, 3.0, -6.0));
	block.s[0].b[2][2] = (vec3(4.0, -9.0, -1.0));
	block.s[0].b[3][0] = (vec3(8.0, 7.0, 2.0));
	block.s[0].b[3][1] = (vec3(7.0, -5.0, 3.0));
	block.s[0].b[3][2] = (vec3(-9.0, 7.0, -2.0));
	block.s[0].c = (vec4(7.0, -8.0, 3.0, 0.0));
	block.s[1].a = (ivec3(-6, 5, 6));
	block.s[1].b[0][0] = (vec3(-2.0, 9.0, 3.0));
	block.s[1].b[0][1] = (vec3(-8.0, -5.0, 2.0));
	block.s[1].b[0][2] = (vec3(9.0, 4.0, -2.0));
	block.s[1].b[1][0] = (vec3(-1.0, -6.0, -1.0));
	block.s[1].b[1][1] = (vec3(1.0, -4.0, 6.0));
	block.s[1].b[1][2] = (vec3(5.0, -4.0, 4.0));
	block.s[1].b[2][0] = (vec3(-1.0, 1.0, -5.0));
	block.s[1].b[2][1] = (vec3(-4.0, -9.0, 1.0));
	block.s[1].b[2][2] = (vec3(-3.0, -1.0, 1.0));
	block.s[1].b[3][0] = (vec3(2.0, -7.0, -3.0));
	block.s[1].b[3][1] = (vec3(-9.0, -3.0, 0.0));
	block.s[1].b[3][2] = (vec3(4.0, 5.0, -8.0));
	block.s[1].c = (vec4(-9.0, -8.0, -7.0, 5.0));
	block.s[2].a = (ivec3(-9, 8, 1));
	block.s[2].b[0][0] = (vec3(6.0, 5.0, -3.0));
	block.s[2].b[0][1] = (vec3(2.0, 0.0, 1.0));
	block.s[2].b[0][2] = (vec3(6.0, -2.0, -7.0));
	block.s[2].b[1][0] = (vec3(3.0, -6.0, -2.0));
	block.s[2].b[1][1] = (vec3(2.0, 5.0, -9.0));
	block.s[2].b[1][2] = (vec3(3.0, -7.0, 8.0));
	block.s[2].b[2][0] = (vec3(5.0, -6.0, 4.0));
	block.s[2].b[2][1] = (vec3(1.0, -9.0, 6.0));
	block.s[2].b[2][2] = (vec3(5.0, -1.0, -5.0));
	block.s[2].b[3][0] = (vec3(4.0, 8.0, 2.0));
	block.s[2].b[3][1] = (vec3(1.0, 2.0, -9.0));
	block.s[2].b[3][2] = (vec3(-5.0, -6.0, 1.0));
	block.s[2].c = (vec4(-7.0, 1.0, 3.0, -9.0));
	block.v = (vec4(8.0, 5.0, -6.0, -7.0));
}
#version 450
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
layout(std430, buffer_reference) buffer Block
{
	lowp uint u;
	S s[3];
	mediump vec4 v;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
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
	allOk = compare_ivec3((block[0].s[0].a), ivec3(6, -9, 7)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[0], mat3(-3.0, 7.0, 0.0, -9.0, -6.0, -1.0, 8.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[1], mat3(-4.0, 3.0, 4.0, 2.0, -4.0, 4.0, 7.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[2], mat3(6.0, -1.0, 2.0, 8.0, 8.0, -9.0, 0.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[3], mat3(5.0, 1.0, 1.0, -9.0, 2.0, -5.0, 7.0, -5.0, -1.0)) && allOk;
	allOk = compare_vec4((block[0].s[0].c), vec4(4.0, 6.0, 7.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1].a), ivec3(0, -9, 5)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[0], mat3(-7.0, -7.0, 5.0, -5.0, -2.0, -2.0, -3.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[1], mat3(-1.0, -7.0, 9.0, -2.0, -1.0, -1.0, 7.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[2], mat3(-9.0, -8.0, 3.0, 0.0, 3.0, -1.0, 1.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[3], mat3(6.0, 3.0, -4.0, -6.0, 6.0, -6.0, -1.0, 3.0, -7.0)) && allOk;
	allOk = compare_vec4((block[0].s[1].c), vec4(-1.0, 3.0, -3.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2].a), ivec3(4, -3, -2)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[0], mat3(0.0, 5.0, -3.0, 6.0, -6.0, -7.0, -5.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[1], mat3(7.0, -3.0, -7.0, 0.0, 6.0, -5.0, -9.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[2], mat3(-1.0, -5.0, 0.0, 8.0, -2.0, -4.0, 5.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[3], mat3(4.0, 1.0, 5.0, -1.0, 9.0, -3.0, 2.0, -9.0, 0.0)) && allOk;
	allOk = compare_vec4((block[0].s[2].c), vec4(-8.0, 0.0, -7.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0].a), ivec3(-4, 5, 9)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[0], mat3(4.0, 7.0, 1.0, -9.0, -1.0, -3.0, 6.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[1], mat3(9.0, -2.0, 6.0, 4.0, 9.0, -4.0, 8.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[2], mat3(-5.0, 0.0, 8.0, -5.0, 1.0, 0.0, -4.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[3], mat3(3.0, 5.0, 6.0, -7.0, 2.0, 2.0, 1.0, -5.0, -9.0)) && allOk;
	allOk = compare_vec4((block[1].s[0].c), vec4(5.0, 2.0, -2.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1].a), ivec3(4, -2, -6)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[0], mat3(1.0, 5.0, -7.0, -8.0, 1.0, -6.0, 6.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[1], mat3(-2.0, -1.0, -5.0, 4.0, 7.0, -9.0, 9.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[2], mat3(8.0, -2.0, 0.0, -7.0, -2.0, 5.0, -4.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[3], mat3(-8.0, -2.0, -4.0, -5.0, -8.0, 6.0, 3.0, -8.0, -4.0)) && allOk;
	allOk = compare_vec4((block[1].s[1].c), vec4(9.0, -3.0, -8.0, 7.0)) && allOk;
	allOk = compare_ivec3((block[1].s[2].a), ivec3(5, 6, -3)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[0], mat3(0.0, -5.0, 5.0, 4.0, 3.0, 1.0, -2.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[1], mat3(2.0, 0.0, -1.0, 6.0, -6.0, -8.0, 0.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[2], mat3(-8.0, -9.0, -9.0, -1.0, 5.0, 9.0, -3.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[3], mat3(4.0, 8.0, 6.0, -1.0, -7.0, -4.0, 5.0, 4.0, -3.0)) && allOk;
	allOk = compare_vec4((block[1].s[2].c), vec4(2.0, -3.0, 7.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0].a), ivec3(8, 7, -3)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[0], mat3(1.0, -6.0, -2.0, 5.0, 0.0, -2.0, 5.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[1], mat3(4.0, 5.0, 2.0, 6.0, 9.0, -7.0, -5.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[2], mat3(3.0, 8.0, -9.0, -6.0, -9.0, 9.0, 1.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[3], mat3(8.0, -1.0, -9.0, 3.0, 7.0, -8.0, 3.0, -9.0, -5.0)) && allOk;
	allOk = compare_vec4((block[2].s[0].c), vec4(-8.0, 1.0, 8.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[2].s[1].a), ivec3(-4, -8, 8)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[0], mat3(-2.0, 0.0, 5.0, -4.0, 9.0, 0.0, -8.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[1], mat3(-8.0, 4.0, -9.0, -9.0, -6.0, 4.0, -4.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[2], mat3(2.0, -4.0, 0.0, 1.0, -5.0, -5.0, -9.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[3], mat3(-3.0, 3.0, -5.0, -8.0, 5.0, 7.0, -6.0, 0.0, 6.0)) && allOk;
	allOk = compare_vec4((block[2].s[1].c), vec4(1.0, -3.0, 7.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[2].s[2].a), ivec3(-9, -3, -7)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[0], mat3(6.0, -3.0, 9.0, -6.0, -1.0, 5.0, 5.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[1], mat3(-2.0, 0.0, 7.0, 9.0, 3.0, 7.0, -6.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[2], mat3(-3.0, 4.0, 2.0, -7.0, 1.0, -4.0, 0.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[3], mat3(4.0, -2.0, -4.0, 9.0, -9.0, -2.0, 5.0, 8.0, -1.0)) && allOk;
	allOk = compare_vec4((block[2].s[2].c), vec4(7.0, -8.0, -9.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s[0].a = (ivec3(-4, 1, 7));
	block[0].s[0].b[0][0] = (vec3(-9.0, 7.0, 5.0));
	block[0].s[0].b[0][1] = (vec3(-5.0, 3.0, 0.0));
	block[0].s[0].b[0][2] = (vec3(-9.0, 3.0, 8.0));
	block[0].s[0].b[1][0] = (vec3(8.0, -7.0, -3.0));
	block[0].s[0].b[1][1] = (vec3(2.0, -6.0, 3.0));
	block[0].s[0].b[1][2] = (vec3(0.0, -1.0, -5.0));
	block[0].s[0].b[2][0] = (vec3(7.0, 3.0, 2.0));
	block[0].s[0].b[2][1] = (vec3(-6.0, 8.0, 7.0));
	block[0].s[0].b[2][2] = (vec3(8.0, -7.0, 8.0));
	block[0].s[0].b[3][0] = (vec3(-1.0, 0.0, 7.0));
	block[0].s[0].b[3][1] = (vec3(2.0, 2.0, -3.0));
	block[0].s[0].b[3][2] = (vec3(-7.0, 7.0, 3.0));
	block[0].s[0].c = (vec4(8.0, -4.0, 9.0, -4.0));
	block[0].s[1].a = (ivec3(-2, 8, -4));
	block[0].s[1].b[0][0] = (vec3(8.0, 1.0, 8.0));
	block[0].s[1].b[0][1] = (vec3(-1.0, -6.0, -7.0));
	block[0].s[1].b[0][2] = (vec3(7.0, 5.0, -6.0));
	block[0].s[1].b[1][0] = (vec3(7.0, -3.0, 6.0));
	block[0].s[1].b[1][1] = (vec3(0.0, -6.0, -3.0));
	block[0].s[1].b[1][2] = (vec3(-3.0, 7.0, -4.0));
	block[0].s[1].b[2][0] = (vec3(5.0, -2.0, 3.0));
	block[0].s[1].b[2][1] = (vec3(-3.0, 7.0, 2.0));
	block[0].s[1].b[2][2] = (vec3(-4.0, 4.0, 4.0));
	block[0].s[1].b[3][0] = (vec3(-4.0, 2.0, -4.0));
	block[0].s[1].b[3][1] = (vec3(9.0, 0.0, -7.0));
	block[0].s[1].b[3][2] = (vec3(-5.0, 0.0, 7.0));
	block[0].s[1].c = (vec4(4.0, -7.0, 2.0, -6.0));
	block[0].s[2].a = (ivec3(-3, 2, -3));
	block[0].s[2].b[0][0] = (vec3(-6.0, 5.0, -5.0));
	block[0].s[2].b[0][1] = (vec3(4.0, -5.0, -5.0));
	block[0].s[2].b[0][2] = (vec3(7.0, 5.0, -1.0));
	block[0].s[2].b[1][0] = (vec3(3.0, -9.0, 0.0));
	block[0].s[2].b[1][1] = (vec3(7.0, -3.0, 8.0));
	block[0].s[2].b[1][2] = (vec3(-3.0, -9.0, -2.0));
	block[0].s[2].b[2][0] = (vec3(1.0, -8.0, 3.0));
	block[0].s[2].b[2][1] = (vec3(6.0, -9.0, -9.0));
	block[0].s[2].b[2][2] = (vec3(-9.0, -7.0, 0.0));
	block[0].s[2].b[3][0] = (vec3(1.0, -5.0, -6.0));
	block[0].s[2].b[3][1] = (vec3(4.0, -9.0, 8.0));
	block[0].s[2].b[3][2] = (vec3(5.0, 9.0, 4.0));
	block[0].s[2].c = (vec4(9.0, 6.0, -1.0, -9.0));
	block[0].v = (vec4(-4.0, 8.0, 3.0, 6.0));
	block[1].s[0].a = (ivec3(-5, -8, 7));
	block[1].s[0].b[0][0] = (vec3(5.0, -2.0, 8.0));
	block[1].s[0].b[0][1] = (vec3(-1.0, -5.0, 8.0));
	block[1].s[0].b[0][2] = (vec3(-7.0, 7.0, -6.0));
	block[1].s[0].b[1][0] = (vec3(-9.0, -1.0, 2.0));
	block[1].s[0].b[1][1] = (vec3(2.0, 4.0, 9.0));
	block[1].s[0].b[1][2] = (vec3(-9.0, 1.0, 1.0));
	block[1].s[0].b[2][0] = (vec3(7.0, 5.0, -8.0));
	block[1].s[0].b[2][1] = (vec3(-7.0, -8.0, 6.0));
	block[1].s[0].b[2][2] = (vec3(6.0, 5.0, 7.0));
	block[1].s[0].b[3][0] = (vec3(5.0, 5.0, 3.0));
	block[1].s[0].b[3][1] = (vec3(3.0, 3.0, 8.0));
	block[1].s[0].b[3][2] = (vec3(4.0, -6.0, -3.0));
	block[1].s[0].c = (vec4(3.0, -6.0, 6.0, -2.0));
	block[1].s[1].a = (ivec3(-7, 5, 5));
	block[1].s[1].b[0][0] = (vec3(-9.0, -2.0, 8.0));
	block[1].s[1].b[0][1] = (vec3(-7.0, -8.0, 3.0));
	block[1].s[1].b[0][2] = (vec3(-9.0, 7.0, 3.0));
	block[1].s[1].b[1][0] = (vec3(-3.0, -6.0, 2.0));
	block[1].s[1].b[1][1] = (vec3(4.0, -4.0, -5.0));
	block[1].s[1].b[1][2] = (vec3(-3.0, -5.0, -6.0));
	block[1].s[1].b[2][0] = (vec3(9.0, -6.0, -3.0));
	block[1].s[1].b[2][1] = (vec3(-1.0, -6.0, 6.0));
	block[1].s[1].b[2][2] = (vec3(8.0, 3.0, 0.0));
	block[1].s[1].b[3][0] = (vec3(3.0, 7.0, 0.0));
	block[1].s[1].b[3][1] = (vec3(-7.0, 8.0, 1.0));
	block[1].s[1].b[3][2] = (vec3(5.0, -6.0, -8.0));
	block[1].s[1].c = (vec4(-3.0, -9.0, -8.0, -2.0));
	block[1].s[2].a = (ivec3(5, 4, 5));
	block[1].s[2].b[0][0] = (vec3(7.0, 2.0, -2.0));
	block[1].s[2].b[0][1] = (vec3(-8.0, -9.0, -1.0));
	block[1].s[2].b[0][2] = (vec3(9.0, -2.0, 8.0));
	block[1].s[2].b[1][0] = (vec3(9.0, 6.0, -8.0));
	block[1].s[2].b[1][1] = (vec3(-6.0, -3.0, 9.0));
	block[1].s[2].b[1][2] = (vec3(1.0, 0.0, 3.0));
	block[1].s[2].b[2][0] = (vec3(6.0, 5.0, 0.0));
	block[1].s[2].b[2][1] = (vec3(-3.0, -3.0, 0.0));
	block[1].s[2].b[2][2] = (vec3(6.0, 0.0, -4.0));
	block[1].s[2].b[3][0] = (vec3(-4.0, -6.0, -4.0));
	block[1].s[2].b[3][1] = (vec3(-1.0, 2.0, -3.0));
	block[1].s[2].b[3][2] = (vec3(6.0, 8.0, -1.0));
	block[1].s[2].c = (vec4(5.0, 6.0, 9.0, 0.0));
	block[1].v = (vec4(3.0, 0.0, 0.0, 4.0));
	block[2].s[0].a = (ivec3(6, 1, 3));
	block[2].s[0].b[0][0] = (vec3(-1.0, -4.0, 6.0));
	block[2].s[0].b[0][1] = (vec3(-1.0, 4.0, 6.0));
	block[2].s[0].b[0][2] = (vec3(5.0, -4.0, -9.0));
	block[2].s[0].b[1][0] = (vec3(1.0, 5.0, 9.0));
	block[2].s[0].b[1][1] = (vec3(-2.0, -2.0, -1.0));
	block[2].s[0].b[1][2] = (vec3(4.0, -5.0, 5.0));
	block[2].s[0].b[2][0] = (vec3(2.0, -7.0, -8.0));
	block[2].s[0].b[2][1] = (vec3(-7.0, -4.0, 7.0));
	block[2].s[0].b[2][2] = (vec3(-2.0, -4.0, -2.0));
	block[2].s[0].b[3][0] = (vec3(-1.0, 7.0, -5.0));
	block[2].s[0].b[3][1] = (vec3(7.0, 5.0, 2.0));
	block[2].s[0].b[3][2] = (vec3(3.0, 9.0, -2.0));
	block[2].s[0].c = (vec4(-2.0, 0.0, -5.0, -1.0));
	block[2].s[1].a = (ivec3(-3, -4, 5));
	block[2].s[1].b[0][0] = (vec3(-5.0, -1.0, -9.0));
	block[2].s[1].b[0][1] = (vec3(-8.0, 0.0, 1.0));
	block[2].s[1].b[0][2] = (vec3(6.0, 1.0, 8.0));
	block[2].s[1].b[1][0] = (vec3(3.0, 1.0, -7.0));
	block[2].s[1].b[1][1] = (vec3(5.0, 5.0, -8.0));
	block[2].s[1].b[1][2] = (vec3(-9.0, -7.0, 9.0));
	block[2].s[1].b[2][0] = (vec3(-9.0, -2.0, 2.0));
	block[2].s[1].b[2][1] = (vec3(-8.0, 5.0, -4.0));
	block[2].s[1].b[2][2] = (vec3(3.0, 8.0, -5.0));
	block[2].s[1].b[3][0] = (vec3(6.0, -7.0, 3.0));
	block[2].s[1].b[3][1] = (vec3(-6.0, 4.0, -7.0));
	block[2].s[1].b[3][2] = (vec3(-8.0, -5.0, 5.0));
	block[2].s[1].c = (vec4(2.0, 1.0, -2.0, -6.0));
	block[2].s[2].a = (ivec3(1, 0, -4));
	block[2].s[2].b[0][0] = (vec3(9.0, 6.0, 7.0));
	block[2].s[2].b[0][1] = (vec3(-7.0, -7.0, 9.0));
	block[2].s[2].b[0][2] = (vec3(-5.0, -4.0, 7.0));
	block[2].s[2].b[1][0] = (vec3(-2.0, 4.0, 1.0));
	block[2].s[2].b[1][1] = (vec3(-8.0, -8.0, -7.0));
	block[2].s[2].b[1][2] = (vec3(2.0, -1.0, 2.0));
	block[2].s[2].b[2][0] = (vec3(6.0, 1.0, 7.0));
	block[2].s[2].b[2][1] = (vec3(3.0, -6.0, -3.0));
	block[2].s[2].b[2][2] = (vec3(2.0, 1.0, -7.0));
	block[2].s[2].b[3][0] = (vec3(-2.0, 6.0, 8.0));
	block[2].s[2].b[3][1] = (vec3(3.0, -4.0, -1.0));
	block[2].s[2].b[3][2] = (vec3(2.0, 4.0, 1.0));
	block[2].s[2].c = (vec4(-4.0, 3.0, -4.0, -2.0));
	block[2].v = (vec4(-1.0, 2.0, 9.0, 5.0));
}
#version 450
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
layout(std430, buffer_reference) buffer Block
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
	allOk = compare_uvec2((block[0].s[0].a), uvec2(7u, 8u)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[0], mat2x4(1.0, -8.0, -9.0, -8.0, -2.0, -9.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[1], mat2x4(-7.0, 3.0, 0.0, -2.0, 3.0, 5.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[2], mat2x4(-1.0, 5.0, -4.0, -8.0, 1.0, 5.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[3], mat2x4(-3.0, 5.0, -1.0, 9.0, -1.0, 6.0, -6.0, -8.0)) && allOk;
	allOk = compare_vec3((block[0].s[0].c), vec3(8.0, -5.0, 6.0)) && allOk;
	allOk = compare_uvec2((block[0].s[1].a), uvec2(6u, 8u)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[0], mat2x4(5.0, 2.0, 0.0, 8.0, -8.0, -8.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[1], mat2x4(2.0, -7.0, 8.0, -1.0, -7.0, -4.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[2], mat2x4(8.0, -4.0, 4.0, -2.0, -7.0, 5.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[3], mat2x4(7.0, 0.0, 0.0, 2.0, 7.0, 1.0, -9.0, -1.0)) && allOk;
	allOk = compare_vec3((block[0].s[1].c), vec3(-7.0, 5.0, -5.0)) && allOk;
	allOk = compare_uvec2((block[0].s[2].a), uvec2(5u, 8u)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[0], mat2x4(9.0, -9.0, -1.0, 2.0, -7.0, -8.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[1], mat2x4(-2.0, -3.0, -9.0, -3.0, -9.0, 1.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[2], mat2x4(3.0, -4.0, -5.0, 3.0, -1.0, -3.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[3], mat2x4(3.0, 3.0, 5.0, -1.0, -2.0, -6.0, -4.0, -8.0)) && allOk;
	allOk = compare_vec3((block[0].s[2].c), vec3(5.0, -3.0, -2.0)) && allOk;
	allOk = compare_uvec2((block[0].s[3].a), uvec2(4u, 6u)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[0], mat2x4(8.0, -6.0, 3.0, 0.0, -9.0, 2.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[1], mat2x4(8.0, -4.0, 0.0, -6.0, 0.0, 6.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[2], mat2x4(8.0, -2.0, -6.0, 2.0, 1.0, -4.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[3], mat2x4(-3.0, 9.0, -4.0, -8.0, 7.0, -5.0, 0.0, 3.0)) && allOk;
	allOk = compare_vec3((block[0].s[3].c), vec3(-9.0, 9.0, -1.0)) && allOk;
	allOk = compare_uvec2((block[1].s[0].a), uvec2(6u, 4u)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[0], mat2x4(-4.0, 8.0, 0.0, -1.0, 1.0, 3.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[1], mat2x4(1.0, 5.0, -9.0, -3.0, -3.0, 5.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[2], mat2x4(-1.0, -5.0, -2.0, 4.0, -7.0, 5.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[3], mat2x4(5.0, 0.0, -1.0, 2.0, -6.0, 7.0, -7.0, 1.0)) && allOk;
	allOk = compare_vec3((block[1].s[0].c), vec3(-2.0, -2.0, 6.0)) && allOk;
	allOk = compare_uvec2((block[1].s[1].a), uvec2(6u, 4u)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[0], mat2x4(-6.0, -4.0, 8.0, -3.0, -1.0, -2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[1], mat2x4(1.0, -2.0, -9.0, -5.0, 3.0, 1.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[2], mat2x4(-2.0, 9.0, 8.0, -9.0, -4.0, -5.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[3], mat2x4(6.0, 2.0, -2.0, -6.0, 1.0, -7.0, 9.0, 3.0)) && allOk;
	allOk = compare_vec3((block[1].s[1].c), vec3(3.0, 8.0, -2.0)) && allOk;
	allOk = compare_uvec2((block[1].s[2].a), uvec2(4u, 4u)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[0], mat2x4(-3.0, -4.0, -7.0, -7.0, 1.0, -1.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[1], mat2x4(-8.0, -7.0, 7.0, -4.0, 9.0, -1.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[2], mat2x4(-8.0, 2.0, -3.0, 4.0, -7.0, -3.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[3], mat2x4(-7.0, 7.0, 1.0, 5.0, 5.0, 1.0, 1.0, -3.0)) && allOk;
	allOk = compare_vec3((block[1].s[2].c), vec3(6.0, 0.0, 5.0)) && allOk;
	allOk = compare_uvec2((block[1].s[3].a), uvec2(4u, 5u)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[0], mat2x4(-8.0, -4.0, 3.0, -7.0, 8.0, -5.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[1], mat2x4(-2.0, -9.0, -5.0, 3.0, -4.0, -8.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[2], mat2x4(5.0, 8.0, 4.0, 6.0, -5.0, 4.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[3], mat2x4(-1.0, 6.0, 2.0, -7.0, 6.0, 7.0, 1.0, 1.0)) && allOk;
	allOk = compare_vec3((block[1].s[3].c), vec3(7.0, -8.0, 0.0)) && allOk;
	allOk = compare_uvec2((block[2].s[0].a), uvec2(1u, 5u)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[0], mat2x4(8.0, 9.0, 5.0, -6.0, -8.0, 4.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[1], mat2x4(-7.0, 0.0, 9.0, -3.0, -9.0, 8.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[2], mat2x4(-9.0, 4.0, -7.0, -1.0, 7.0, 2.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[3], mat2x4(8.0, -1.0, -4.0, -6.0, 5.0, -8.0, 4.0, 8.0)) && allOk;
	allOk = compare_vec3((block[2].s[0].c), vec3(1.0, 2.0, 0.0)) && allOk;
	allOk = compare_uvec2((block[2].s[1].a), uvec2(2u, 4u)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[0], mat2x4(-9.0, 8.0, -8.0, 7.0, 1.0, -9.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[1], mat2x4(3.0, -1.0, 6.0, 1.0, -5.0, 2.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[2], mat2x4(1.0, -9.0, 2.0, 7.0, 5.0, -1.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[3], mat2x4(-5.0, 4.0, 0.0, -8.0, 9.0, 9.0, -7.0, -9.0)) && allOk;
	allOk = compare_vec3((block[2].s[1].c), vec3(-8.0, 8.0, -1.0)) && allOk;
	allOk = compare_uvec2((block[2].s[2].a), uvec2(6u, 1u)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[0], mat2x4(-3.0, 1.0, -4.0, -8.0, -5.0, -3.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[1], mat2x4(-4.0, 9.0, -6.0, -6.0, -4.0, 5.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[2], mat2x4(4.0, 2.0, -7.0, 2.0, 6.0, -5.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[3], mat2x4(6.0, 4.0, 5.0, 3.0, -5.0, -5.0, -9.0, 6.0)) && allOk;
	allOk = compare_vec3((block[2].s[2].c), vec3(-1.0, 5.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].v = (0u);
	block[0].s[0].a = (uvec2(7u, 4u));
	block[0].s[0].b[0] = (mat2x4(7.0, -1.0, -8.0, -6.0, -1.0, 4.0, 9.0, -7.0));
	block[0].s[0].b[1] = (mat2x4(-5.0, -1.0, 5.0, 9.0, -8.0, 6.0, -9.0, 8.0));
	block[0].s[0].b[2] = (mat2x4(2.0, -2.0, -9.0, -2.0, 1.0, 2.0, -1.0, 5.0));
	block[0].s[0].b[3] = (mat2x4(-4.0, 6.0, 8.0, -8.0, 4.0, 0.0, 5.0, 3.0));
	block[0].s[0].c = (vec3(4.0, -9.0, -8.0));
	block[0].s[1].a = (uvec2(1u, 7u));
	block[0].s[1].b[0] = (mat2x4(3.0, 7.0, -2.0, -3.0, -5.0, -8.0, 9.0, 4.0));
	block[0].s[1].b[1] = (mat2x4(-6.0, 1.0, -4.0, -2.0, 9.0, 6.0, -3.0, -7.0));
	block[0].s[1].b[2] = (mat2x4(7.0, 5.0, 2.0, -7.0, 6.0, 1.0, 3.0, 6.0));
	block[0].s[1].b[3] = (mat2x4(-6.0, 5.0, -6.0, 3.0, 5.0, 5.0, 4.0, -7.0));
	block[0].s[1].c = (vec3(-1.0, 7.0, -6.0));
	block[0].s[2].a = (uvec2(9u, 6u));
	block[0].s[2].b[0] = (mat2x4(-5.0, 6.0, -2.0, 8.0, -4.0, 1.0, 7.0, -9.0));
	block[0].s[2].b[1] = (mat2x4(9.0, 8.0, -9.0, 6.0, 0.0, 0.0, 7.0, 1.0));
	block[0].s[2].b[2] = (mat2x4(-9.0, -1.0, -3.0, 1.0, 9.0, 0.0, 9.0, 7.0));
	block[0].s[2].b[3] = (mat2x4(-1.0, 0.0, -2.0, -1.0, -5.0, -8.0, 2.0, -2.0));
	block[0].s[2].c = (vec3(5.0, 4.0, 1.0));
	block[0].s[3].a = (uvec2(3u, 4u));
	block[0].s[3].b[0] = (mat2x4(2.0, 3.0, 6.0, 0.0, 5.0, -8.0, -1.0, 8.0));
	block[0].s[3].b[1] = (mat2x4(5.0, -2.0, -1.0, -8.0, 6.0, 0.0, 9.0, -5.0));
	block[0].s[3].b[2] = (mat2x4(-6.0, 8.0, -2.0, 4.0, -6.0, -4.0, 9.0, 1.0));
	block[0].s[3].b[3] = (mat2x4(0.0, 7.0, -2.0, 1.0, -6.0, 2.0, 6.0, -8.0));
	block[0].s[3].c = (vec3(-5.0, -2.0, -5.0));
	block[1].v = (8u);
	block[1].s[0].a = (uvec2(4u, 5u));
	block[1].s[0].b[0] = (mat2x4(5.0, -4.0, 9.0, 7.0, -9.0, -9.0, 1.0, 5.0));
	block[1].s[0].b[1] = (mat2x4(5.0, -8.0, 8.0, 7.0, 4.0, -3.0, -7.0, 4.0));
	block[1].s[0].b[2] = (mat2x4(9.0, 9.0, 4.0, -6.0, -6.0, -7.0, 8.0, -4.0));
	block[1].s[0].b[3] = (mat2x4(7.0, 7.0, 7.0, -1.0, 3.0, 4.0, -7.0, -6.0));
	block[1].s[0].c = (vec3(7.0, -1.0, 8.0));
	block[1].s[1].a = (uvec2(7u, 0u));
	block[1].s[1].b[0] = (mat2x4(8.0, -2.0, -5.0, 1.0, -1.0, -6.0, 2.0, -5.0));
	block[1].s[1].b[1] = (mat2x4(0.0, 0.0, -1.0, -8.0, 1.0, -7.0, 9.0, -8.0));
	block[1].s[1].b[2] = (mat2x4(-1.0, -5.0, 7.0, 8.0, -2.0, 6.0, -3.0, 9.0));
	block[1].s[1].b[3] = (mat2x4(7.0, 5.0, -1.0, 0.0, 6.0, -9.0, 5.0, -6.0));
	block[1].s[1].c = (vec3(-9.0, 7.0, -1.0));
	block[1].s[2].a = (uvec2(8u, 3u));
	block[1].s[2].b[0] = (mat2x4(8.0, 0.0, -4.0, -3.0, -8.0, 6.0, -1.0, 2.0));
	block[1].s[2].b[1] = (mat2x4(-3.0, 2.0, 5.0, -2.0, -6.0, -7.0, -8.0, -1.0));
	block[1].s[2].b[2] = (mat2x4(-2.0, -5.0, 3.0, -8.0, -5.0, 0.0, 2.0, -8.0));
	block[1].s[2].b[3] = (mat2x4(-9.0, -3.0, -6.0, 1.0, -8.0, -2.0, -7.0, 5.0));
	block[1].s[2].c = (vec3(-5.0, 0.0, 1.0));
	block[1].s[3].a = (uvec2(6u, 4u));
	block[1].s[3].b[0] = (mat2x4(6.0, -6.0, 5.0, -1.0, 7.0, -4.0, 4.0, 9.0));
	block[1].s[3].b[1] = (mat2x4(8.0, 4.0, 6.0, 7.0, -7.0, 9.0, 8.0, 5.0));
	block[1].s[3].b[2] = (mat2x4(-9.0, -1.0, -7.0, -3.0, -5.0, 5.0, -2.0, 4.0));
	block[1].s[3].b[3] = (mat2x4(-4.0, -9.0, -2.0, 1.0, -2.0, 6.0, 2.0, -9.0));
	block[1].s[3].c = (vec3(7.0, -6.0, -8.0));
	block[2].v = (2u);
	block[2].s[0].a = (uvec2(6u, 2u));
	block[2].s[0].b[0] = (mat2x4(-1.0, 2.0, -7.0, -7.0, 2.0, 5.0, -9.0, 4.0));
	block[2].s[0].b[1] = (mat2x4(-5.0, 7.0, -5.0, -2.0, 7.0, -5.0, -1.0, -6.0));
	block[2].s[0].b[2] = (mat2x4(-5.0, 6.0, 2.0, -3.0, -1.0, -1.0, -5.0, -7.0));
	block[2].s[0].b[3] = (mat2x4(-2.0, 1.0, -8.0, 0.0, 4.0, 8.0, 6.0, 8.0));
	block[2].s[0].c = (vec3(-7.0, 5.0, -2.0));
	block[2].s[1].a = (uvec2(2u, 8u));
	block[2].s[1].b[0] = (mat2x4(-3.0, 7.0, -8.0, -1.0, -7.0, -6.0, -9.0, -8.0));
	block[2].s[1].b[1] = (mat2x4(8.0, 4.0, 9.0, 1.0, 8.0, 6.0, -8.0, 1.0));
	block[2].s[1].b[2] = (mat2x4(-7.0, 1.0, -1.0, -5.0, -2.0, 3.0, -7.0, 8.0));
	block[2].s[1].b[3] = (mat2x4(-4.0, -2.0, 7.0, -9.0, 9.0, 5.0, -3.0, -6.0));
	block[2].s[1].c = (vec3(1.0, 4.0, -9.0));
	block[2].s[2].a = (uvec2(8u, 1u));
	block[2].s[2].b[0] = (mat2x4(-4.0, 1.0, -4.0, -8.0, -6.0, 9.0, 3.0, -5.0));
	block[2].s[2].b[1] = (mat2x4(-2.0, -3.0, 1.0, -1.0, -3.0, -1.0, 0.0, -8.0));
	block[2].s[2].b[2] = (mat2x4(7.0, -9.0, -9.0, -5.0, -8.0, 6.0, -7.0, -9.0));
	block[2].s[2].b[3] = (mat2x4(4.0, 0.0, 8.0, 5.0, 2.0, -6.0, -1.0, -2.0));
	block[2].s[2].c = (vec3(3.0, 5.0, 2.0));
}
#version 450
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
	allOk = compare_float(block[0].var[0][0], -4.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 6.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 0.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -5.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 0.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -1.0) && allOk;
	allOk = compare_float(block[0].var[3][0], -4.0) && allOk;
	allOk = compare_float(block[0].var[3][1], 4.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(-4.0, 6.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(0.0, -5.0)) && allOk;
	allOk = compare_vec2(block[0].var[2], vec2(0.0, -1.0)) && allOk;
	allOk = compare_vec2(block[0].var[3], vec2(-4.0, 4.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], -6.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -1.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 4.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 0.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 2.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -3.0) && allOk;
	allOk = compare_float(block[1].var[3][0], -1.0) && allOk;
	allOk = compare_float(block[1].var[3][1], 1.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(-6.0, -1.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(4.0, 0.0)) && allOk;
	allOk = compare_vec2(block[1].var[2], vec2(2.0, -3.0)) && allOk;
	allOk = compare_vec2(block[1].var[3], vec2(-1.0, 1.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], -8.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -1.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 5.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 4.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 9.0) && allOk;
	allOk = compare_float(block[2].var[2][1], -2.0) && allOk;
	allOk = compare_float(block[2].var[3][0], -3.0) && allOk;
	allOk = compare_float(block[2].var[3][1], -4.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(-8.0, -1.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(5.0, 4.0)) && allOk;
	allOk = compare_vec2(block[2].var[2], vec2(9.0, -2.0)) && allOk;
	allOk = compare_vec2(block[2].var[3], vec2(-3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat4x2(1.0, 8.0, -9.0, 4.0, 1.0, -5.0, 2.0, -5.0));
	block[1].var = (mat4x2(8.0, -8.0, 8.0, 3.0, 2.0, -6.0, 3.0, 8.0));
	block[2].var = (mat4x2(8.0, 9.0, -3.0, -9.0, -2.0, 6.0, -1.0, 6.0));
}
#version 450
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
	allOk = compare_float(block[0].var[0][0], -1.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -7.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 8.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 5.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -5.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 7.0) && allOk;
	allOk = compare_float(block[0].var[2][0], -9.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 5.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 0.0) && allOk;
	allOk = compare_float(block[0].var[3][0], 8.0) && allOk;
	allOk = compare_float(block[0].var[3][1], 6.0) && allOk;
	allOk = compare_float(block[0].var[3][2], 1.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(-1.0, -7.0, 8.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(5.0, -5.0, 7.0)) && allOk;
	allOk = compare_vec3(block[0].var[2], vec3(-9.0, 5.0, 0.0)) && allOk;
	allOk = compare_vec3(block[0].var[3], vec3(8.0, 6.0, 1.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 7.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -9.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 6.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 0.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -8.0) && allOk;
	allOk = compare_float(block[1].var[1][2], -3.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -6.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 8.0) && allOk;
	allOk = compare_float(block[1].var[2][2], 8.0) && allOk;
	allOk = compare_float(block[1].var[3][0], -7.0) && allOk;
	allOk = compare_float(block[1].var[3][1], 8.0) && allOk;
	allOk = compare_float(block[1].var[3][2], 7.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(7.0, -9.0, 6.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(0.0, -8.0, -3.0)) && allOk;
	allOk = compare_vec3(block[1].var[2], vec3(-6.0, 8.0, 8.0)) && allOk;
	allOk = compare_vec3(block[1].var[3], vec3(-7.0, 8.0, 7.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 1.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 0.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 7.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -2.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 4.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 9.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 9.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 8.0) && allOk;
	allOk = compare_float(block[2].var[2][2], -2.0) && allOk;
	allOk = compare_float(block[2].var[3][0], -2.0) && allOk;
	allOk = compare_float(block[2].var[3][1], -4.0) && allOk;
	allOk = compare_float(block[2].var[3][2], 5.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(1.0, 0.0, 7.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(-2.0, 4.0, 9.0)) && allOk;
	allOk = compare_vec3(block[2].var[2], vec3(9.0, 8.0, -2.0)) && allOk;
	allOk = compare_vec3(block[2].var[3], vec3(-2.0, -4.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat4x3(-2.0, 9.0, 6.0, 4.0, 4.0, 3.0, 2.0, 4.0, 6.0, 7.0, -2.0, 2.0));
	block[1].var = (mat4x3(-8.0, -2.0, 9.0, 9.0, 6.0, -2.0, 4.0, -7.0, 6.0, -7.0, 9.0, 6.0));
	block[2].var = (mat4x3(6.0, 8.0, 8.0, 9.0, -6.0, 5.0, -3.0, 9.0, -5.0, 9.0, 9.0, -3.0));
}
#version 450
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
	highp vec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((block[0].var), vec3(7.0, 9.0, -6.0)) && allOk;
	allOk = compare_vec3((block[1].var), vec3(-9.0, 5.0, -8.0)) && allOk;
	allOk = compare_vec3((block[2].var), vec3(1.0, -1.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (vec3(5.0, 4.0, 7.0));
	block[1].var = (vec3(8.0, -2.0, 7.0));
	block[2].var = (vec3(-5.0, -7.0, 9.0));
}
#version 450
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

layout(scalar, column_major, buffer_reference) buffer Block
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
	allOk = compare_float((block[0].padding), -2.0) && allOk;
	allOk = compare_mat2x3(block[0].var, mat2x3(0.0, -9.0, 8.0, -4.0, 1.0, -3.0)) && allOk;
	allOk = compare_float((block[1].padding), -1.0) && allOk;
	allOk = compare_mat2x3(block[1].var, mat2x3(-3.0, -1.0, 7.0, 0.0, 9.0, 9.0)) && allOk;
	allOk = compare_float((block[2].padding), 0.0) && allOk;
	allOk = compare_mat2x3(block[2].var, mat2x3(0.0, -2.0, -7.0, -6.0, 8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (0.0);
	block[0].var[0] = (vec3(5.0, 5.0, 0.0));
	block[0].var[1] = (vec3(-7.0, 8.0, -7.0));
	block[1].padding = (-4.0);
	block[1].var[0] = (vec3(6.0, 1.0, 3.0));
	block[1].var[1] = (vec3(2.0, -6.0, 5.0));
	block[2].padding = (2.0);
	block[2].var[0] = (vec3(1.0, 8.0, -8.0));
	block[2].var[1] = (vec3(2.0, -7.0, 5.0));
}
#version 450
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
	allOk = compare_float((blockA.a), -8.0) && allOk;
	allOk = compare_mat2(blockA.c, mat2(-4.0, 2.0, -6.0, 5.0)) && allOk;
	allOk = compare_ivec2((blockB.b), ivec2(0, -7)) && allOk;
	allOk = compare_bool((blockB.d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (2.0);
	blockB.a[0] = (vec3(-8.0, -6.0, 5.0));
	blockB.a[1] = (vec3(4.0, -2.0, -8.0));
	blockB.a[2] = (vec3(3.0, 7.0, -4.0));
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

layout(std430, buffer_reference) buffer BlockB
{
	lowp int a;
	lowp uint b;
	lowp float c;
	bool d;
	lowp uint e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.a), 1) && allOk;
	allOk = compare_bool((blockB.d), false) && allOk;
	allOk = compare_uint((blockB.e), 3u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (2);
	blockB.b = (2u);
	blockB.c = (-5.0);
	blockB.e = (0u);
}
#version 450
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
	bvec4 a;
	mediump uvec2 b;
	mediump uvec2 c[1];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	lowp uvec2 d;
	highp int e;
	highp ivec3 f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, false, false, false)) && allOk;
	allOk = compare_uvec2((blockB.b), uvec2(5u, 7u)) && allOk;
	allOk = compare_uvec2((blockB.c[0]), uvec2(6u, 1u)) && allOk;
	allOk = compare_uvec2((blockC.d), uvec2(8u, 9u)) && allOk;
	allOk = compare_ivec3((blockC.f), ivec3(-6, -3, -1)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (uvec2(3u, 3u));
	blockC.d = (uvec2(3u, 9u));
}
#version 450
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
	lowp mat4 a;
};
layout(std140, buffer_reference) buffer BlockC
{
	mediump uvec4 b[5];
	lowp vec2 c;
	bvec3 d;
	highp vec2 e;
	mediump mat3x2 f;
};
layout(std430, column_major, buffer_reference) readonly buffer BlockD
{
	mediump vec4 g;
};
layout(std140, row_major, buffer_reference) buffer BlockE
{
	mediump vec4 h[1];
	mediump mat3x2 i;
	mediump uvec3 j;
	bvec3 k;
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
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.a, mat4(-7.0, 8.0, 8.0, 2.0, 4.0, 0.0, -2.0, 6.0, -1.0, 5.0, -9.0, 9.0, -2.0, -9.0, 2.0, 0.0)) && allOk;
	allOk = compare_vec2((blockC.c), vec2(9.0, -3.0)) && allOk;
	allOk = compare_bvec3((blockC.d), bvec3(true, true, false)) && allOk;
	allOk = compare_vec4((blockE.h[0]), vec4(0.0, 4.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(blockE.i, mat3x2(-5.0, -9.0, 7.0, -1.0, 6.0, -3.0)) && allOk;
	allOk = compare_uvec3((blockE.j), uvec3(1u, 8u, 7u)) && allOk;
	allOk = compare_bvec3((blockE.k), bvec3(true, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4(0.0, -7.0, 3.0, -2.0, 2.0, -7.0, 4.0, 6.0, -8.0, 8.0, -3.0, 3.0, -3.0, -1.0, 6.0, 9.0));
	blockC.b[0] = (uvec4(3u, 6u, 3u, 4u));
	blockC.b[1] = (uvec4(3u, 8u, 6u, 4u));
	blockC.b[2] = (uvec4(2u, 0u, 3u, 6u));
	blockC.b[3] = (uvec4(9u, 7u, 1u, 3u));
	blockC.b[4] = (uvec4(2u, 9u, 0u, 0u));
	blockC.c = (vec2(3.0, 7.0));
	blockC.e = (vec2(-9.0, 8.0));
	blockC.f = (mat3x2(9.0, -8.0, -8.0, 3.0, -3.0, 0.0));
	blockE.h[0] = (vec4(6.0, 0.0, -2.0, -1.0));
	blockE.i = (mat3x2(5.0, -6.0, 2.0, -2.0, -7.0, -6.0));
	blockE.j = (uvec3(8u, 8u, 9u));
}
#version 450
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
	highp mat3x4 a;
	highp int b;
	highp vec4 c[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	highp vec2 d;
	mediump uvec4 e;
	lowp mat3x2 f;
	lowp mat4 g[5];
	lowp ivec2 h[];
};
layout(std140, buffer_reference) buffer BlockD
{
	mediump mat3x4 i[];
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
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB.a, mat3x4(-4.0, 4.0, -6.0, -2.0, -1.0, -2.0, 6.0, 3.0, 2.0, 3.0, -6.0, -4.0)) && allOk;
	allOk = compare_int((blockB.b), -6) && allOk;
	allOk = compare_vec4((blockB.c[0]), vec4(-3.0, -1.0, 4.0, 8.0)) && allOk;
	allOk = compare_vec4((blockB.c[1]), vec4(-1.0, 6.0, 5.0, -8.0)) && allOk;
	allOk = compare_vec4((blockB.c[2]), vec4(-6.0, 5.0, -1.0, -5.0)) && allOk;
	allOk = compare_ivec2((blockC.h[0]), ivec2(-3, -3)) && allOk;
	allOk = compare_ivec2((blockC.h[1]), ivec2(2, -3)) && allOk;
	allOk = compare_ivec2((blockC.h[2]), ivec2(-9, -5)) && allOk;
	allOk = compare_ivec2((blockC.h[3]), ivec2(8, 2)) && allOk;
	allOk = compare_mat3x4(blockD.i[0], mat3x4(-7.0, -9.0, -1.0, -5.0, 4.0, 1.0, -2.0, 6.0, 3.0, 7.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(blockD.i[1], mat3x4(3.0, 6.0, 4.0, -2.0, 9.0, -9.0, -1.0, 7.0, -5.0, 7.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat3x4(blockD.i[2], mat3x4(4.0, 4.0, -1.0, -2.0, 9.0, -6.0, -6.0, -5.0, 6.0, 4.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat3x4(blockD.i[3], mat3x4(-9.0, 2.0, -5.0, -2.0, 4.0, -8.0, -2.0, 4.0, 0.0, -1.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3x4(blockD.i[4], mat3x4(7.0, -5.0, 0.0, 3.0, 4.0, -9.0, -9.0, 2.0, 0.0, 1.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3x4(blockD.i[5], mat3x4(9.0, 2.0, 9.0, -2.0, 0.0, -5.0, -5.0, 8.0, -8.0, 1.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat3x4(blockD.i[6], mat3x4(-8.0, -5.0, 7.0, -2.0, -7.0, 9.0, -1.0, 0.0, 5.0, -5.0, -8.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x4(6.0, 0.0, 5.0, 1.0, -7.0, -3.0, -7.0, 9.0, -9.0, 8.0, 0.0, -8.0));
	blockB.c[0] = (vec4(5.0, 4.0, -2.0, -5.0));
	blockB.c[1] = (vec4(5.0, -6.0, 3.0, -5.0));
	blockB.c[2] = (vec4(0.0, -9.0, 3.0, -9.0));
	blockC.d = (vec2(-1.0, 6.0));
	blockC.e = (uvec4(3u, 6u, 5u, 5u));
	blockC.f = (mat3x2(3.0, -9.0, 1.0, 8.0, -4.0, -7.0));
	blockC.h[0] = (ivec2(7, 3));
	blockC.h[1] = (ivec2(-9, 3));
	blockC.h[2] = (ivec2(4, 5));
	blockC.h[3] = (ivec2(8, 6));
	blockD.i[0] = (mat3x4(-3.0, 9.0, 4.0, -1.0, -2.0, -2.0, -3.0, -6.0, -5.0, -8.0, 0.0, 4.0));
	blockD.i[1] = (mat3x4(1.0, 3.0, -9.0, 9.0, 1.0, 6.0, 8.0, 3.0, -1.0, 9.0, 6.0, 6.0));
	blockD.i[2] = (mat3x4(-3.0, 1.0, -7.0, -2.0, -2.0, -1.0, 2.0, 1.0, -8.0, 8.0, -9.0, -8.0));
	blockD.i[3] = (mat3x4(-1.0, 2.0, -8.0, -1.0, -1.0, 7.0, -6.0, -1.0, 7.0, -1.0, 3.0, 7.0));
	blockD.i[4] = (mat3x4(0.0, 0.0, -6.0, -9.0, 8.0, 4.0, -5.0, 7.0, 7.0, -5.0, -8.0, 2.0));
	blockD.i[5] = (mat3x4(4.0, -6.0, 5.0, -3.0, -9.0, -3.0, -8.0, 9.0, -3.0, 6.0, 3.0, 3.0));
	blockD.i[6] = (mat3x4(-3.0, -2.0, -4.0, -9.0, -1.0, -9.0, -2.0, 5.0, 9.0, 8.0, -2.0, -8.0));
}
#version 450
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
	mediump mat2x3 a[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	highp ivec3 b;
	mediump mat4x3 c;
	highp ivec3 d;
	mediump mat3x4 e;
	highp mat3x2 f;
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	bvec3 g;
	mediump ivec3 h;
};
layout(std430, row_major, buffer_reference) buffer BlockE
{
	mediump mat3x2 i;
	lowp mat4x2 j[];
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB.a[0], mat2x3(-9.0, 2.0, 5.0, 9.0, 0.0, 5.0)) && allOk;
	allOk = compare_mat4x3(blockC.c, mat4x3(-9.0, 1.0, -6.0, -8.0, -5.0, 9.0, 7.0, -8.0, 1.0, 5.0, -5.0, -8.0)) && allOk;
	allOk = compare_ivec3((blockC.d), ivec3(-7, 7, -5)) && allOk;
	allOk = compare_mat3x4(blockC.e, mat3x4(8.0, -5.0, 7.0, -8.0, -4.0, -3.0, 5.0, 0.0, -2.0, 3.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockC.f, mat3x2(-4.0, -1.0, 6.0, -7.0, -9.0, 8.0)) && allOk;
	allOk = compare_bvec3((blockD.g), bvec3(false, true, false)) && allOk;
	allOk = compare_ivec3((blockD.h), ivec3(5, 1, -5)) && allOk;
	allOk = compare_mat4x2(blockE.j[0], mat4x2(-6.0, -3.0, -3.0, -1.0, 6.0, -1.0, -3.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.c = (mat4x3(8.0, 6.0, 2.0, 9.0, 8.0, 5.0, -5.0, 8.0, -1.0, 7.0, -9.0, -3.0));
	blockC.d = (ivec3(-1, 6, -2));
	blockC.e = (mat3x4(-4.0, 9.0, -4.0, 2.0, -4.0, 4.0, -8.0, -4.0, 1.0, -4.0, -4.0, -7.0));
	blockC.f = (mat3x2(-1.0, 9.0, -8.0, 6.0, 2.0, -1.0));
	blockD.g = (bvec3(false, false, true));
	blockE.i = (mat3x2(9.0, -2.0, 2.0, -3.0, 1.0, -1.0));
}
#version 450
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
	lowp mat3x4 a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB.a, mat3x4(-8.0, -5.0, -1.0, 6.0, -2.0, 5.0, 9.0, 0.0, 9.0, 6.0, -1.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x4(1.0, 1.0, 1.0, 0.0, 1.0, 8.0, -9.0, -9.0, -4.0, -4.0, 3.0, -6.0));
}
#version 450
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
	mediump vec3 a;
	highp ivec3 b;
	lowp ivec4 c[];
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp uvec3 d[];
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	lowp uint e;
	highp ivec2 f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.a), vec3(-7.0, 3.0, -2.0)) && allOk;
	allOk = compare_ivec2((blockD[0].f[0]), ivec2(-9, -3)) && allOk;
	allOk = compare_ivec2((blockD[1].f[0]), ivec2(0, -6)) && allOk;
	allOk = compare_ivec2((blockD[1].f[1]), ivec2(-3, 1)) && allOk;
	allOk = compare_ivec2((blockD[1].f[2]), ivec2(8, -5)) && allOk;
	allOk = compare_ivec2((blockD[1].f[3]), ivec2(8, 8)) && allOk;
	allOk = compare_ivec2((blockD[1].f[4]), ivec2(9, 6)) && allOk;
	allOk = compare_ivec2((blockD[1].f[5]), ivec2(-2, -4)) && allOk;
	allOk = compare_ivec2((blockD[2].f[0]), ivec2(6, -4)) && allOk;
	allOk = compare_ivec2((blockD[2].f[1]), ivec2(8, -4)) && allOk;
	allOk = compare_ivec2((blockD[2].f[2]), ivec2(-1, -9)) && allOk;
	allOk = compare_ivec2((blockD[2].f[3]), ivec2(-5, 5)) && allOk;
	allOk = compare_ivec2((blockD[2].f[4]), ivec2(-5, -4)) && allOk;
	allOk = compare_ivec2((blockD[2].f[5]), ivec2(-6, -4)) && allOk;
	allOk = compare_ivec2((blockD[2].f[6]), ivec2(8, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec3(-6.0, -2.0, 3.0));
	blockC.d[0] = (uvec3(5u, 1u, 2u));
	blockD[0].f[0] = (ivec2(-8, -8));
	blockD[1].f[0] = (ivec2(-5, 7));
	blockD[1].f[1] = (ivec2(-5, -3));
	blockD[1].f[2] = (ivec2(-8, 6));
	blockD[1].f[3] = (ivec2(-4, -9));
	blockD[1].f[4] = (ivec2(8, -8));
	blockD[1].f[5] = (ivec2(-5, 1));
	blockD[2].f[0] = (ivec2(3, -9));
	blockD[2].f[1] = (ivec2(-3, 8));
	blockD[2].f[2] = (ivec2(5, 8));
	blockD[2].f[3] = (ivec2(1, 8));
	blockD[2].f[4] = (ivec2(9, 2));
	blockD[2].f[5] = (ivec2(7, -2));
	blockD[2].f[6] = (ivec2(-9, -9));
}
#version 450
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
	highp uvec2 mB[6];
	lowp mat3 mC;
	lowp mat3x2 mD;
};
struct sB
{
	bvec2 mA;
};
layout(std430, buffer_reference) buffer BlockB
{
	highp uvec4 a;
	mediump float b[][1];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	sA c;
	sB d;
	lowp float e;
	bvec3 f;
	mediump mat3x2 g[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	highp uvec2 h;
	lowp mat3x2 i;
	mediump uint j;
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
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a), uvec4(5u, 3u, 6u, 4u)) && allOk;
	allOk = compare_mat4x2(blockC.c.mA, mat4x2(-3.0, 5.0, 6.0, 8.0, -8.0, 9.0, -4.0, 9.0)) && allOk;
	allOk = compare_uvec2((blockC.c.mB[0]), uvec2(6u, 7u)) && allOk;
	allOk = compare_uvec2((blockC.c.mB[1]), uvec2(1u, 7u)) && allOk;
	allOk = compare_uvec2((blockC.c.mB[2]), uvec2(0u, 0u)) && allOk;
	allOk = compare_uvec2((blockC.c.mB[3]), uvec2(3u, 2u)) && allOk;
	allOk = compare_uvec2((blockC.c.mB[4]), uvec2(3u, 0u)) && allOk;
	allOk = compare_uvec2((blockC.c.mB[5]), uvec2(8u, 0u)) && allOk;
	allOk = compare_mat3(blockC.c.mC, mat3(-3.0, 9.0, -4.0, -3.0, 6.0, -4.0, 6.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat3x2(blockC.c.mD, mat3x2(-6.0, -2.0, -4.0, -5.0, 1.0, -9.0)) && allOk;
	allOk = compare_float((blockC.e), -1.0) && allOk;
	allOk = compare_bvec3((blockC.f), bvec3(true, false, false)) && allOk;
	allOk = compare_mat3x2(blockC.g[0], mat3x2(6.0, 0.0, -3.0, 7.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(blockC.g[1], mat3x2(3.0, -6.0, -5.0, -5.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3x2(blockC.g[2], mat3x2(2.0, 3.0, 8.0, -5.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockC.g[3], mat3x2(-1.0, 5.0, 6.0, -4.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3x2(blockC.g[4], mat3x2(-5.0, -2.0, -7.0, 0.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockC.g[5], mat3x2(-1.0, 4.0, -2.0, -3.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3x2(blockC.g[6], mat3x2(9.0, -4.0, -5.0, -6.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockC.g[7], mat3x2(-6.0, 9.0, -9.0, 5.0, -9.0, -5.0)) && allOk;
	allOk = compare_uvec2((blockD.h), uvec2(8u, 4u)) && allOk;
	allOk = compare_mat3x2(blockD.i, mat3x2(3.0, 3.0, 6.0, -5.0, 5.0, -5.0)) && allOk;
	allOk = compare_uint((blockD.j), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0][0] = (6.0);
	blockB.b[1][0] = (-9.0);
	blockB.b[2][0] = (4.0);
	blockB.b[3][0] = (0.0);
	blockC.d.mA = (bvec2(false, false));
	blockC.e = (3.0);
	blockC.f = (bvec3(false, true, true));
	blockC.g[0] = (mat3x2(-9.0, 1.0, -5.0, 0.0, 1.0, -9.0));
	blockC.g[1] = (mat3x2(1.0, 0.0, 9.0, -8.0, -4.0, 2.0));
	blockC.g[2] = (mat3x2(1.0, 2.0, 3.0, -9.0, 6.0, 1.0));
	blockC.g[3] = (mat3x2(7.0, -1.0, 1.0, 1.0, 6.0, 7.0));
	blockC.g[4] = (mat3x2(-8.0, 9.0, 4.0, -4.0, 7.0, -5.0));
	blockC.g[5] = (mat3x2(-4.0, 1.0, 7.0, -3.0, 9.0, 5.0));
	blockC.g[6] = (mat3x2(5.0, -7.0, 1.0, -3.0, -5.0, 2.0));
	blockC.g[7] = (mat3x2(-2.0, -8.0, 3.0, 8.0, -9.0, -5.0));
	blockD.h = (uvec2(6u, 1u));
	blockD.i = (mat3x2(-2.0, -3.0, -4.0, 1.0, 0.0, 2.0));
}
#version 450
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
	highp mat2x3 mB;
	highp vec2 mC;
};
struct sB
{
	mediump mat4x3 mA;
	mediump mat4 mB;
	highp int mC[2];
};
struct sC
{
	lowp mat4x3 mA;
	mediump vec4 mB;
	lowp uvec3 mC;
	lowp uvec3 mD;
};
struct sD
{
	sB mA;
	highp ivec4 mB;
	sC mC[2];
	highp uvec2 mD;
};
layout(scalar, buffer_reference) buffer BlockB
{
	highp mat4x2 a;
	lowp mat2x3 b;
	bvec4 c;
	mediump vec3 d[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	mediump vec2 e;
	bool f;
	bvec2 g;
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	sA h;
	mediump vec2 i;
	mediump mat2x3 j;
	sD k[];
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB.a, mat4x2(1.0, -5.0, -9.0, -5.0, 1.0, -7.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat2x3(blockB.b, mat2x3(8.0, 7.0, 9.0, -8.0, 2.0, 9.0)) && allOk;
	allOk = compare_vec3((blockB.d[0]), vec3(4.0, -2.0, 9.0)) && allOk;
	allOk = compare_vec3((blockB.d[1]), vec3(2.0, -5.0, 1.0)) && allOk;
	allOk = compare_vec3((blockB.d[2]), vec3(-6.0, 8.0, 5.0)) && allOk;
	allOk = compare_vec3((blockB.d[3]), vec3(5.0, -3.0, 3.0)) && allOk;
	allOk = compare_vec3((blockB.d[4]), vec3(1.0, -9.0, 7.0)) && allOk;
	allOk = compare_vec3((blockB.d[5]), vec3(-2.0, 2.0, 9.0)) && allOk;
	allOk = compare_vec3((blockB.d[6]), vec3(-3.0, 3.0, 1.0)) && allOk;
	allOk = compare_vec2((blockC.e), vec2(1.0, -9.0)) && allOk;
	allOk = compare_bvec2((blockC.g), bvec2(true, true)) && allOk;
	allOk = compare_vec2((blockD.i), vec2(9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(blockD.j, mat2x3(5.0, -2.0, -4.0, 7.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat4x3(blockD.k[0].mA.mA, mat4x3(-9.0, 5.0, 1.0, -5.0, 5.0, -3.0, 6.0, 6.0, 2.0, 4.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat4(blockD.k[0].mA.mB, mat4(6.0, 6.0, 2.0, 9.0, 7.0, -8.0, -5.0, 8.0, -3.0, -5.0, 7.0, -3.0, -5.0, 7.0, -2.0, 1.0)) && allOk;
	allOk = compare_int((blockD.k[0].mA.mC[0]), -2) && allOk;
	allOk = compare_int((blockD.k[0].mA.mC[1]), -6) && allOk;
	allOk = compare_ivec4((blockD.k[0].mB), ivec4(2, 3, -6, 3)) && allOk;
	allOk = compare_mat4x3(blockD.k[0].mC[0].mA, mat4x3(0.0, -8.0, -6.0, 6.0, -3.0, 4.0, -5.0, 7.0, 4.0, 4.0, -7.0, 1.0)) && allOk;
	allOk = compare_vec4((blockD.k[0].mC[0].mB), vec4(3.0, -4.0, 2.0, 4.0)) && allOk;
	allOk = compare_uvec3((blockD.k[0].mC[0].mC), uvec3(6u, 1u, 7u)) && allOk;
	allOk = compare_uvec3((blockD.k[0].mC[0].mD), uvec3(5u, 8u, 5u)) && allOk;
	allOk = compare_mat4x3(blockD.k[0].mC[1].mA, mat4x3(-6.0, 9.0, -7.0, 4.0, 9.0, 7.0, -4.0, 7.0, -9.0, 5.0, 8.0, -7.0)) && allOk;
	allOk = compare_vec4((blockD.k[0].mC[1].mB), vec4(6.0, -1.0, 6.0, 2.0)) && allOk;
	allOk = compare_uvec3((blockD.k[0].mC[1].mC), uvec3(8u, 5u, 8u)) && allOk;
	allOk = compare_uvec3((blockD.k[0].mC[1].mD), uvec3(0u, 3u, 8u)) && allOk;
	allOk = compare_uvec2((blockD.k[0].mD), uvec2(3u, 9u)) && allOk;
	allOk = compare_mat4x3(blockD.k[1].mA.mA, mat4x3(3.0, 8.0, 6.0, -3.0, 4.0, -7.0, 1.0, -5.0, -9.0, 7.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat4(blockD.k[1].mA.mB, mat4(-9.0, 5.0, 9.0, 6.0, -8.0, -2.0, -1.0, -1.0, -7.0, -9.0, 2.0, -2.0, -9.0, 7.0, 7.0, 1.0)) && allOk;
	allOk = compare_int((blockD.k[1].mA.mC[0]), 6) && allOk;
	allOk = compare_int((blockD.k[1].mA.mC[1]), -4) && allOk;
	allOk = compare_ivec4((blockD.k[1].mB), ivec4(-3, -5, 0, 7)) && allOk;
	allOk = compare_mat4x3(blockD.k[1].mC[0].mA, mat4x3(1.0, -1.0, 6.0, -2.0, -3.0, -6.0, 9.0, 6.0, -9.0, -9.0, 9.0, 0.0)) && allOk;
	allOk = compare_vec4((blockD.k[1].mC[0].mB), vec4(5.0, -9.0, 5.0, -6.0)) && allOk;
	allOk = compare_uvec3((blockD.k[1].mC[0].mC), uvec3(0u, 8u, 4u)) && allOk;
	allOk = compare_uvec3((blockD.k[1].mC[0].mD), uvec3(3u, 6u, 4u)) && allOk;
	allOk = compare_mat4x3(blockD.k[1].mC[1].mA, mat4x3(0.0, 1.0, 9.0, -7.0, -9.0, -8.0, -4.0, 1.0, -7.0, 5.0, 8.0, 1.0)) && allOk;
	allOk = compare_vec4((blockD.k[1].mC[1].mB), vec4(-5.0, 5.0, 9.0, -5.0)) && allOk;
	allOk = compare_uvec3((blockD.k[1].mC[1].mC), uvec3(6u, 3u, 8u)) && allOk;
	allOk = compare_uvec3((blockD.k[1].mC[1].mD), uvec3(0u, 7u, 1u)) && allOk;
	allOk = compare_uvec2((blockD.k[1].mD), uvec2(3u, 4u)) && allOk;
	allOk = compare_mat4x3(blockD.k[2].mA.mA, mat4x3(-3.0, -4.0, 5.0, -9.0, 6.0, 2.0, -2.0, -6.0, 4.0, -8.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat4(blockD.k[2].mA.mB, mat4(-8.0, 7.0, 1.0, 1.0, -3.0, -1.0, 9.0, 0.0, -1.0, 7.0, 5.0, -2.0, 0.0, -2.0, 2.0, -5.0)) && allOk;
	allOk = compare_int((blockD.k[2].mA.mC[0]), -8) && allOk;
	allOk = compare_int((blockD.k[2].mA.mC[1]), 9) && allOk;
	allOk = compare_ivec4((blockD.k[2].mB), ivec4(4, -9, 5, 5)) && allOk;
	allOk = compare_mat4x3(blockD.k[2].mC[0].mA, mat4x3(-4.0, 6.0, 6.0, -9.0, -2.0, 9.0, 4.0, -7.0, 3.0, -6.0, 9.0, -8.0)) && allOk;
	allOk = compare_vec4((blockD.k[2].mC[0].mB), vec4(0.0, 0.0, -3.0, -9.0)) && allOk;
	allOk = compare_uvec3((blockD.k[2].mC[0].mC), uvec3(5u, 7u, 6u)) && allOk;
	allOk = compare_uvec3((blockD.k[2].mC[0].mD), uvec3(7u, 8u, 6u)) && allOk;
	allOk = compare_mat4x3(blockD.k[2].mC[1].mA, mat4x3(-8.0, -5.0, 8.0, -9.0, -7.0, 4.0, 7.0, 8.0, 8.0, 0.0, -1.0, 0.0)) && allOk;
	allOk = compare_vec4((blockD.k[2].mC[1].mB), vec4(-1.0, -1.0, 7.0, 5.0)) && allOk;
	allOk = compare_uvec3((blockD.k[2].mC[1].mC), uvec3(9u, 0u, 7u)) && allOk;
	allOk = compare_uvec3((blockD.k[2].mC[1].mD), uvec3(2u, 3u, 5u)) && allOk;
	allOk = compare_uvec2((blockD.k[2].mD), uvec2(3u, 7u)) && allOk;
	allOk = compare_mat4x3(blockD.k[3].mA.mA, mat4x3(-6.0, 8.0, 4.0, -4.0, 6.0, -7.0, 7.0, -2.0, -7.0, 4.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4(blockD.k[3].mA.mB, mat4(2.0, -9.0, 4.0, 2.0, 6.0, 2.0, -1.0, -8.0, 8.0, 0.0, -7.0, -1.0, -4.0, 3.0, 6.0, 3.0)) && allOk;
	allOk = compare_int((blockD.k[3].mA.mC[0]), -4) && allOk;
	allOk = compare_int((blockD.k[3].mA.mC[1]), 8) && allOk;
	allOk = compare_ivec4((blockD.k[3].mB), ivec4(-2, -4, 5, -9)) && allOk;
	allOk = compare_mat4x3(blockD.k[3].mC[0].mA, mat4x3(8.0, -1.0, -8.0, 6.0, 4.0, 2.0, -2.0, 1.0, -8.0, -3.0, 0.0, 6.0)) && allOk;
	allOk = compare_vec4((blockD.k[3].mC[0].mB), vec4(-7.0, -4.0, 5.0, 6.0)) && allOk;
	allOk = compare_uvec3((blockD.k[3].mC[0].mC), uvec3(3u, 8u, 2u)) && allOk;
	allOk = compare_uvec3((blockD.k[3].mC[0].mD), uvec3(8u, 4u, 0u)) && allOk;
	allOk = compare_mat4x3(blockD.k[3].mC[1].mA, mat4x3(-2.0, 3.0, -3.0, 2.0, 2.0, -6.0, -4.0, -3.0, 6.0, 4.0, -3.0, 5.0)) && allOk;
	allOk = compare_vec4((blockD.k[3].mC[1].mB), vec4(-1.0, 6.0, -1.0, 4.0)) && allOk;
	allOk = compare_uvec3((blockD.k[3].mC[1].mC), uvec3(7u, 7u, 4u)) && allOk;
	allOk = compare_uvec3((blockD.k[3].mC[1].mD), uvec3(4u, 7u, 9u)) && allOk;
	allOk = compare_uvec2((blockD.k[3].mD), uvec2(7u, 9u)) && allOk;
	allOk = compare_mat4x3(blockD.k[4].mA.mA, mat4x3(4.0, -3.0, 6.0, 1.0, -2.0, 5.0, 2.0, -8.0, -6.0, -5.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat4(blockD.k[4].mA.mB, mat4(-3.0, -2.0, 0.0, 4.0, 4.0, -2.0, 8.0, 6.0, 9.0, -2.0, 0.0, -5.0, 4.0, 9.0, -6.0, -1.0)) && allOk;
	allOk = compare_int((blockD.k[4].mA.mC[0]), 8) && allOk;
	allOk = compare_int((blockD.k[4].mA.mC[1]), -9) && allOk;
	allOk = compare_ivec4((blockD.k[4].mB), ivec4(-7, 4, -7, 9)) && allOk;
	allOk = compare_mat4x3(blockD.k[4].mC[0].mA, mat4x3(-6.0, 6.0, 7.0, -1.0, -8.0, -5.0, -2.0, -3.0, -3.0, 1.0, -4.0, -2.0)) && allOk;
	allOk = compare_vec4((blockD.k[4].mC[0].mB), vec4(6.0, 0.0, 0.0, 6.0)) && allOk;
	allOk = compare_uvec3((blockD.k[4].mC[0].mC), uvec3(0u, 7u, 3u)) && allOk;
	allOk = compare_uvec3((blockD.k[4].mC[0].mD), uvec3(1u, 7u, 6u)) && allOk;
	allOk = compare_mat4x3(blockD.k[4].mC[1].mA, mat4x3(7.0, 5.0, 3.0, -7.0, -6.0, 4.0, -2.0, 0.0, -5.0, 1.0, 8.0, 0.0)) && allOk;
	allOk = compare_vec4((blockD.k[4].mC[1].mB), vec4(3.0, 2.0, 0.0, -5.0)) && allOk;
	allOk = compare_uvec3((blockD.k[4].mC[1].mC), uvec3(3u, 0u, 9u)) && allOk;
	allOk = compare_uvec3((blockD.k[4].mC[1].mD), uvec3(1u, 5u, 8u)) && allOk;
	allOk = compare_uvec2((blockD.k[4].mD), uvec2(3u, 4u)) && allOk;
	allOk = compare_mat4x3(blockD.k[5].mA.mA, mat4x3(-6.0, 5.0, -5.0, 3.0, -8.0, 6.0, 5.0, -9.0, 7.0, 5.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4(blockD.k[5].mA.mB, mat4(8.0, 5.0, 0.0, 2.0, -3.0, 5.0, 1.0, 7.0, -3.0, -8.0, -5.0, 6.0, -9.0, 6.0, -4.0, -7.0)) && allOk;
	allOk = compare_int((blockD.k[5].mA.mC[0]), -8) && allOk;
	allOk = compare_int((blockD.k[5].mA.mC[1]), -4) && allOk;
	allOk = compare_ivec4((blockD.k[5].mB), ivec4(9, -7, -6, 1)) && allOk;
	allOk = compare_mat4x3(blockD.k[5].mC[0].mA, mat4x3(-8.0, -3.0, 4.0, 4.0, 9.0, 9.0, -1.0, -4.0, 8.0, 1.0, 1.0, -1.0)) && allOk;
	allOk = compare_vec4((blockD.k[5].mC[0].mB), vec4(-5.0, -8.0, 7.0, -5.0)) && allOk;
	allOk = compare_uvec3((blockD.k[5].mC[0].mC), uvec3(7u, 6u, 7u)) && allOk;
	allOk = compare_uvec3((blockD.k[5].mC[0].mD), uvec3(2u, 4u, 9u)) && allOk;
	allOk = compare_mat4x3(blockD.k[5].mC[1].mA, mat4x3(-3.0, 1.0, 1.0, 7.0, -3.0, 2.0, 8.0, 7.0, 6.0, 6.0, 3.0, -2.0)) && allOk;
	allOk = compare_vec4((blockD.k[5].mC[1].mB), vec4(0.0, 0.0, 3.0, -3.0)) && allOk;
	allOk = compare_uvec3((blockD.k[5].mC[1].mC), uvec3(3u, 0u, 1u)) && allOk;
	allOk = compare_uvec3((blockD.k[5].mC[1].mD), uvec3(9u, 5u, 3u)) && allOk;
	allOk = compare_uvec2((blockD.k[5].mD), uvec2(5u, 9u)) && allOk;
	allOk = compare_mat4x3(blockD.k[6].mA.mA, mat4x3(-8.0, -7.0, 9.0, -9.0, 2.0, 8.0, -1.0, -1.0, 7.0, -7.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat4(blockD.k[6].mA.mB, mat4(-4.0, 2.0, 9.0, 2.0, -5.0, 8.0, -6.0, 3.0, -9.0, 4.0, -4.0, 9.0, 6.0, 4.0, 0.0, 4.0)) && allOk;
	allOk = compare_int((blockD.k[6].mA.mC[0]), 1) && allOk;
	allOk = compare_int((blockD.k[6].mA.mC[1]), -8) && allOk;
	allOk = compare_ivec4((blockD.k[6].mB), ivec4(8, -2, 5, 6)) && allOk;
	allOk = compare_mat4x3(blockD.k[6].mC[0].mA, mat4x3(-2.0, 6.0, 7.0, -4.0, -4.0, 3.0, 8.0, 8.0, 2.0, -4.0, 9.0, 9.0)) && allOk;
	allOk = compare_vec4((blockD.k[6].mC[0].mB), vec4(-6.0, 6.0, 5.0, -8.0)) && allOk;
	allOk = compare_uvec3((blockD.k[6].mC[0].mC), uvec3(4u, 5u, 6u)) && allOk;
	allOk = compare_uvec3((blockD.k[6].mC[0].mD), uvec3(5u, 0u, 1u)) && allOk;
	allOk = compare_mat4x3(blockD.k[6].mC[1].mA, mat4x3(-7.0, -4.0, 7.0, -3.0, 6.0, -1.0, 1.0, 2.0, 1.0, -4.0, 7.0, 4.0)) && allOk;
	allOk = compare_vec4((blockD.k[6].mC[1].mB), vec4(-5.0, 0.0, 7.0, -4.0)) && allOk;
	allOk = compare_uvec3((blockD.k[6].mC[1].mC), uvec3(4u, 9u, 9u)) && allOk;
	allOk = compare_uvec3((blockD.k[6].mC[1].mD), uvec3(5u, 6u, 6u)) && allOk;
	allOk = compare_uvec2((blockD.k[6].mD), uvec2(5u, 4u)) && allOk;
	allOk = compare_mat4x3(blockD.k[7].mA.mA, mat4x3(7.0, 7.0, -6.0, 9.0, -4.0, 0.0, 6.0, 4.0, 1.0, -6.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat4(blockD.k[7].mA.mB, mat4(5.0, -7.0, 7.0, 6.0, 4.0, -7.0, -9.0, -1.0, 7.0, -5.0, -2.0, 2.0, -3.0, 7.0, 7.0, -3.0)) && allOk;
	allOk = compare_int((blockD.k[7].mA.mC[0]), 1) && allOk;
	allOk = compare_int((blockD.k[7].mA.mC[1]), 7) && allOk;
	allOk = compare_ivec4((blockD.k[7].mB), ivec4(1, -3, -1, 8)) && allOk;
	allOk = compare_mat4x3(blockD.k[7].mC[0].mA, mat4x3(-6.0, 3.0, -8.0, 8.0, 3.0, 5.0, 1.0, -5.0, -3.0, 2.0, -8.0, 2.0)) && allOk;
	allOk = compare_vec4((blockD.k[7].mC[0].mB), vec4(-3.0, -1.0, 0.0, -5.0)) && allOk;
	allOk = compare_uvec3((blockD.k[7].mC[0].mC), uvec3(0u, 5u, 4u)) && allOk;
	allOk = compare_uvec3((blockD.k[7].mC[0].mD), uvec3(8u, 4u, 5u)) && allOk;
	allOk = compare_mat4x3(blockD.k[7].mC[1].mA, mat4x3(7.0, -4.0, -6.0, -5.0, 7.0, 7.0, -2.0, 7.0, -8.0, -1.0, -8.0, 5.0)) && allOk;
	allOk = compare_vec4((blockD.k[7].mC[1].mB), vec4(-8.0, -5.0, 3.0, -6.0)) && allOk;
	allOk = compare_uvec3((blockD.k[7].mC[1].mC), uvec3(7u, 4u, 3u)) && allOk;
	allOk = compare_uvec3((blockD.k[7].mC[1].mD), uvec3(0u, 6u, 0u)) && allOk;
	allOk = compare_uvec2((blockD.k[7].mD), uvec2(3u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat2x3(-7.0, 5.0, 3.0, 4.0, 7.0, 8.0));
	blockB.c = (bvec4(false, true, true, false));
	blockB.d[0] = (vec3(5.0, 1.0, 7.0));
	blockB.d[1] = (vec3(-1.0, -9.0, -2.0));
	blockB.d[2] = (vec3(-7.0, -5.0, 7.0));
	blockB.d[3] = (vec3(-9.0, -5.0, 5.0));
	blockB.d[4] = (vec3(3.0, 7.0, -7.0));
	blockB.d[5] = (vec3(-6.0, 1.0, 8.0));
	blockB.d[6] = (vec3(8.0, -9.0, -8.0));
	blockC.e = (vec2(4.0, 8.0));
	blockC.f = (false);
	blockD.h.mA = (mat2x3(8.0, 8.0, 0.0, -8.0, 1.0, -8.0));
	blockD.h.mB = (mat2x3(2.0, -7.0, -2.0, 2.0, -5.0, -5.0));
	blockD.h.mC = (vec2(-8.0, -6.0));
	blockD.i = (vec2(-3.0, -6.0));
	blockD.j = (mat2x3(-4.0, -7.0, 7.0, 6.0, 9.0, -9.0));
}
#version 450
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
	highp vec2 a[2];
	mediump uint b[];
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	bvec3 c;
	highp mat3x2 d;
	lowp mat4x2 e;
	highp mat4x2 f;
	mediump mat3x2 g[];
};
layout(scalar, column_major, buffer_reference) readonly buffer BlockD
{
	bool h[8];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a[0]), vec2(2.0, -4.0)) && allOk;
	allOk = compare_vec2((blockB.a[1]), vec2(-7.0, 7.0)) && allOk;
	allOk = compare_bvec3((blockC.c), bvec3(true, false, false)) && allOk;
	allOk = compare_mat3x2(blockC.d, mat3x2(9.0, 7.0, 0.0, 4.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat4x2(blockC.f, mat4x2(-9.0, 1.0, 5.0, 9.0, -3.0, 2.0, 2.0, 8.0)) && allOk;
	allOk = compare_bool((blockD.h[0]), true) && allOk;
	allOk = compare_bool((blockD.h[1]), false) && allOk;
	allOk = compare_bool((blockD.h[2]), false) && allOk;
	allOk = compare_bool((blockD.h[3]), true) && allOk;
	allOk = compare_bool((blockD.h[4]), true) && allOk;
	allOk = compare_bool((blockD.h[5]), true) && allOk;
	allOk = compare_bool((blockD.h[6]), true) && allOk;
	allOk = compare_bool((blockD.h[7]), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (vec2(-1.0, 9.0));
	blockB.a[1] = (vec2(1.0, 3.0));
	blockB.b[0] = (7u);
	blockC.f = (mat4x2(-2.0, -2.0, 6.0, -3.0, 8.0, 7.0, -8.0, 2.0));
}
#version 450
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
	lowp ivec2 b[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

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

layout(std430, row_major, buffer_reference) buffer BlockB
{
	highp mat4x2 a;
	mediump vec3 b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

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

layout(buffer_reference) buffer BlockB
{
	layout(offset = 0) bvec4 a[1];
	layout(offset = 16) lowp ivec3 b[1];
	layout(offset = 32) mediump mat4x3 c;
	layout(offset = 96) lowp uvec4 d;
	layout(offset = 112) mediump vec3 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB[nonuniformEXT(0)].a[0]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_mat4x3(blockB[nonuniformEXT(0)].c, mat4x3(-2.0, -4.0, -5.0, -1.0, 2.0, -2.0, -4.0, 7.0, -1.0, -1.0, -9.0, 4.0)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(1)].a[0]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_mat4x3(blockB[nonuniformEXT(1)].c, mat4x3(-2.0, 1.0, 7.0, 6.0, 6.0, 2.0, 7.0, 0.0, -1.0, 7.0, 5.0, -2.0)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(2)].a[0]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_mat4x3(blockB[nonuniformEXT(2)].c, mat4x3(-3.0, 2.0, -9.0, -1.0, 2.0, 9.0, 7.0, -3.0, -3.0, 3.0, 9.0, 2.0)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(3)].a[0]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_mat4x3(blockB[nonuniformEXT(3)].c, mat4x3(6.0, 7.0, 0.0, -4.0, -5.0, 0.0, -5.0, 7.0, -9.0, -6.0, -9.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a[0] = (bvec4(true, false, true, false));
	blockB[nonuniformEXT(0)].c = (mat4x3(-5.0, 9.0, 0.0, 6.0, 2.0, 7.0, 9.0, -4.0, -5.0, -1.0, -4.0, -4.0));
	blockB[nonuniformEXT(0)].e = (vec3(-9.0, 3.0, 7.0));
	blockB[nonuniformEXT(1)].a[0] = (bvec4(true, true, false, true));
	blockB[nonuniformEXT(1)].c = (mat4x3(1.0, -8.0, 3.0, -8.0, 0.0, 2.0, 4.0, 2.0, -3.0, -1.0, 5.0, -5.0));
	blockB[nonuniformEXT(1)].e = (vec3(-6.0, 8.0, 1.0));
	blockB[nonuniformEXT(2)].a[0] = (bvec4(true, true, false, true));
	blockB[nonuniformEXT(2)].c = (mat4x3(0.0, 7.0, 2.0, 0.0, -4.0, 0.0, 6.0, -5.0, -7.0, -1.0, -3.0, -9.0));
	blockB[nonuniformEXT(2)].e = (vec3(3.0, -3.0, 9.0));
	blockB[nonuniformEXT(3)].a[0] = (bvec4(true, false, false, true));
	blockB[nonuniformEXT(3)].c = (mat4x3(2.0, -3.0, -6.0, 1.0, 5.0, -4.0, -2.0, -9.0, 9.0, 9.0, -1.0, 8.0));
	blockB[nonuniformEXT(3)].e = (vec3(5.0, -4.0, -3.0));
}
#version 450
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
	u16vec4 a;
	f16vec4 b;
	mediump ivec3 c;
	i16vec4 d;
};
layout(std140, buffer_reference) buffer BlockC
{
	highp ivec4 e;
	lowp int f;
	i16vec3 g;
};
layout(std140, buffer_reference) buffer BlockD
{
	lowp vec4 h;
	lowp uvec2 i;
	u16vec3 j;
	float16_t k;
	f16vec2 l;
};
layout(std140, buffer_reference) buffer BlockE
{
	bvec2 m;
	f16vec3 n;
	mediump float o;
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
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(blockB.d), ivec4(5, 1, -6, 9)) && allOk;
	allOk = compare_ivec4((blockC.e), ivec4(8, 3, 7, 5)) && allOk;
	allOk = compare_int((blockC.f), -6) && allOk;
	allOk = compare_i16vec3(ivec3(blockC.g), ivec3(5, -9, -2)) && allOk;
	allOk = compare_vec4((blockD.h), vec4(4.0, -1.0, -1.0, -5.0)) && allOk;
	allOk = compare_uvec2((blockD.i), uvec2(6u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockD.j), uvec3(4u, 1u, 3u)) && allOk;
	allOk = compare_float16_t(float(blockD.k), -7.0) && allOk;
	allOk = compare_bvec2((blockE.m), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec4(uvec4(8u, 5u, 4u, 8u));
	blockB.b = f16vec4(vec4(-2.0, 7.0, -7.0, -6.0));
	blockB.d = i16vec4(ivec4(-6, 2, 6, 4));
	blockC.e = (ivec4(6, -5, 2, -9));
	blockC.f = (-8);
	blockC.g = i16vec3(ivec3(3, 6, -6));
	blockD.h = (vec4(5.0, 6.0, -6.0, 3.0));
	blockD.j = u16vec3(uvec3(6u, 0u, 5u));
	blockD.k = float16_t(0.0);
	blockD.l = f16vec2(vec2(7.0, -1.0));
	blockE.o = (-4.0);
}
#version 450
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
	highp mat3x4 a[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	i16vec4 b;
	f16vec2 c;
	f16vec2 d[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	float16_t e;
	mediump mat4 f;
	mediump mat2x3 g;
	mediump mat3x4 h;
	highp ivec2 i[];
};
layout(std140, row_major, buffer_reference) buffer BlockE
{
	i16vec4 j;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB.a[0], mat3x4(1.0, -6.0, -5.0, 7.0, 2.0, -1.0, 4.0, 1.0, -8.0, -1.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[1], mat3x4(3.0, 8.0, 1.0, 9.0, 5.0, -4.0, 1.0, -4.0, -4.0, -3.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[2], mat3x4(6.0, 9.0, 0.0, 1.0, -3.0, 1.0, 6.0, 6.0, 6.0, -8.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[3], mat3x4(5.0, 1.0, 4.0, 6.0, -4.0, 0.0, 1.0, 2.0, -1.0, 9.0, -9.0, 9.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.b), ivec4(3, -9, 3, 5)) && allOk;
	allOk = compare_mat3x4(blockD.h, mat3x4(-5.0, 8.0, -5.0, 3.0, 9.0, 6.0, -8.0, 6.0, 4.0, 4.0, -7.0, -3.0)) && allOk;
	allOk = compare_ivec2((blockD.i[0]), ivec2(7, -3)) && allOk;
	allOk = compare_ivec2((blockD.i[1]), ivec2(9, -7)) && allOk;
	allOk = compare_ivec2((blockD.i[2]), ivec2(-5, -7)) && allOk;
	allOk = compare_ivec2((blockD.i[3]), ivec2(0, -2)) && allOk;
	allOk = compare_ivec2((blockD.i[4]), ivec2(3, 2)) && allOk;
	allOk = compare_ivec2((blockD.i[5]), ivec2(-6, -2)) && allOk;
	allOk = compare_ivec2((blockD.i[6]), ivec2(1, 6)) && allOk;
	allOk = compare_ivec2((blockD.i[7]), ivec2(-3, 1)) && allOk;
	allOk = compare_i16vec4(ivec4(blockE.j), ivec4(-6, 5, -1, -2)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat3x4(9.0, 7.0, 5.0, -2.0, 9.0, -6.0, 1.0, 2.0, -4.0, -1.0, -9.0, 0.0));
	blockB.a[1] = (mat3x4(0.0, 6.0, -6.0, -5.0, 2.0, 3.0, 0.0, 4.0, -4.0, -4.0, 1.0, -6.0));
	blockB.a[2] = (mat3x4(2.0, -1.0, 4.0, -4.0, -7.0, 8.0, -8.0, 1.0, -1.0, -6.0, -3.0, 2.0));
	blockB.a[3] = (mat3x4(0.0, -6.0, -5.0, -6.0, 6.0, -7.0, 0.0, -9.0, -1.0, -1.0, 4.0, -2.0));
	blockC.c = f16vec2(vec2(9.0, -5.0));
	blockC.d[0] = f16vec2(vec2(-3.0, 3.0));
	blockC.d[1] = f16vec2(vec2(-7.0, 0.0));
	blockC.d[2] = f16vec2(vec2(-2.0, -2.0));
	blockC.d[3] = f16vec2(vec2(7.0, -9.0));
	blockC.d[4] = f16vec2(vec2(-8.0, 3.0));
	blockC.d[5] = f16vec2(vec2(5.0, 5.0));
	blockC.d[6] = f16vec2(vec2(-1.0, 7.0));
	blockC.d[7] = f16vec2(vec2(-1.0, -8.0));
	blockD.h = (mat3x4(-9.0, 3.0, 5.0, 0.0, -7.0, 1.0, 0.0, 0.0, -4.0, 5.0, -3.0, 2.0));
	blockD.i[0] = (ivec2(1, 8));
	blockD.i[1] = (ivec2(-6, 2));
	blockD.i[2] = (ivec2(-5, 6));
	blockD.i[3] = (ivec2(2, 0));
	blockD.i[4] = (ivec2(-4, 7));
	blockD.i[5] = (ivec2(-3, 3));
	blockD.i[6] = (ivec2(-9, 4));
	blockD.i[7] = (ivec2(8, 3));
	blockE.j = i16vec4(ivec4(-6, -5, 9, -6));
}
#version 450
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
	f16vec4 a;
	highp vec4 b[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	lowp ivec4 c;
	u16vec3 d[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	u16vec3 e;
	bvec4 f;
	highp mat3x4 g[];
};
layout(std140, row_major, buffer_reference) buffer BlockE
{
	bvec2 h;
	mediump mat3 i;
	lowp uint j;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(blockB.a), vec4(6.0, 6.0, -6.0, -3.0)) && allOk;
	allOk = compare_ivec4((blockC.c), ivec4(8, -8, -6, -2)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.d[0]), uvec3(4u, 9u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.d[1]), uvec3(8u, 1u, 6u)) && allOk;
	allOk = compare_bvec4((blockD.f), bvec4(false, false, true, true)) && allOk;
	allOk = compare_mat3x4(blockD.g[0], mat3x4(2.0, -5.0, 9.0, 3.0, -5.0, -3.0, 0.0, -2.0, -4.0, 4.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat3x4(blockD.g[1], mat3x4(5.0, -2.0, 4.0, -4.0, 8.0, -5.0, -4.0, -6.0, -3.0, 0.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat3x4(blockD.g[2], mat3x4(8.0, -5.0, 8.0, -4.0, -9.0, 6.0, 6.0, 8.0, -1.0, 2.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat3x4(blockD.g[3], mat3x4(6.0, 7.0, -7.0, 0.0, -3.0, 7.0, 5.0, -5.0, 4.0, -8.0, -1.0, 2.0)) && allOk;
	allOk = compare_uint((blockE.j), 5u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.c = (ivec4(9, -5, 9, -3));
	blockC.d[0] = u16vec3(uvec3(6u, 7u, 8u));
	blockC.d[1] = u16vec3(uvec3(0u, 1u, 8u));
	blockD.e = u16vec3(uvec3(6u, 0u, 3u));
	blockD.f = (bvec4(false, false, true, false));
	blockD.g[0] = (mat3x4(2.0, 0.0, 5.0, 3.0, -3.0, 2.0, 4.0, 4.0, -6.0, 4.0, -5.0, -2.0));
	blockD.g[1] = (mat3x4(-4.0, -5.0, 7.0, 6.0, -9.0, 0.0, -7.0, 2.0, 1.0, 9.0, 2.0, -9.0));
	blockD.g[2] = (mat3x4(-2.0, -7.0, 8.0, 8.0, 8.0, 7.0, 9.0, -6.0, -3.0, -1.0, 3.0, 7.0));
	blockD.g[3] = (mat3x4(-2.0, -7.0, -7.0, -5.0, 3.0, 8.0, 6.0, -1.0, -8.0, -7.0, 3.0, 8.0));
	blockE.h = (bvec2(false, false));
	blockE.i = (mat3(-7.0, 0.0, -8.0, -3.0, -9.0, 2.0, 7.0, 0.0, -1.0));
	blockE.j = (9u);
}
#version 450
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
	bvec3 a[];
};
layout(std430, buffer_reference) buffer BlockC
{
	highp mat2x3 b;
	bvec3 c;
	bvec4 d[1];
	highp mat2x3 e[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	mediump ivec2 f[];
};
layout(std430, column_major, buffer_reference) buffer BlockE
{
	f16vec4 g;
	float16_t h;
	highp ivec3 i[1];
	highp uvec4 j[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.a[0]), bvec3(true, false, false)) && allOk;
	allOk = compare_mat2x3(blockC.b, mat2x3(5.0, 5.0, 5.0, -5.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat2x3(blockC.e[0], mat2x3(-8.0, -7.0, 7.0, -5.0, 8.0, -5.0)) && allOk;
	allOk = compare_ivec2((blockD.f[0]), ivec2(7, -8)) && allOk;
	allOk = compare_float16_t(float(blockE.h), -2.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (bvec3(true, false, true));
	blockC.e[0] = (mat2x3(-1.0, 6.0, -2.0, -4.0, 9.0, -4.0));
	blockD.f[0] = (ivec2(2, -4));
	blockE.g = f16vec4(vec4(4.0, -8.0, -4.0, 1.0));
	blockE.h = float16_t(-4.0);
	blockE.i[0] = (ivec3(-4, -7, -1));
	blockE.j[0] = (uvec4(9u, 9u, 0u, 0u));
}
#version 450
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
	int16_t a[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	lowp mat4x2 b;
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	lowp mat2x3 c;
	f16vec3 d;
	highp mat3 e;
	f16vec2 f[];
};
layout(std430, column_major, buffer_reference) buffer BlockE
{
	mediump uvec4 g[1];
	f16vec4 h;
	lowp mat4x2 i;
	uint16_t j[];
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
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockD.c, mat2x3(6.0, -8.0, 7.0, -5.0, 2.0, -7.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockD.d), vec3(7.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3(blockD.e, mat3(-1.0, 1.0, 2.0, 2.0, 6.0, 7.0, 0.0, -5.0, -5.0)) && allOk;
	allOk = compare_uvec4((blockE.g[0]), uvec4(6u, 6u, 0u, 2u)) && allOk;
	allOk = compare_f16vec4(vec4(blockE.h), vec4(0.0, -6.0, -3.0, 1.0)) && allOk;
	allOk = compare_uint16_t(uint(blockE.j[0]), 2u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = int16_t(-6);
	blockC.b = (mat4x2(-2.0, 3.0, -5.0, -4.0, 5.0, -9.0, 8.0, 1.0));
	blockD.d = f16vec3(vec3(3.0, 2.0, -7.0));
	blockD.e = (mat3(1.0, -7.0, -8.0, 3.0, 4.0, -1.0, 2.0, 9.0, 3.0));
	blockD.f[0] = f16vec2(vec2(-1.0, 4.0));
	blockE.h = f16vec4(vec4(-5.0, 7.0, -5.0, -3.0));
	blockE.i = (mat4x2(-8.0, 6.0, -4.0, -9.0, 8.0, -8.0, -5.0, 1.0));
	blockE.j[0] = uint16_t(0u);
}
#version 450
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
	mediump uvec4 mB;
	mediump vec3 mC;
	highp mat3x2 mD;
};
layout(std430, buffer_reference) buffer BlockB
{
	lowp vec3 a;
	int16_t b;
	sA c;
	mediump ivec4 d[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	i16vec3 e;
	highp ivec4 f;
	lowp uint g[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	mediump uvec3 h;
	bvec2 i;
};
layout(std430, column_major, buffer_reference) readonly buffer BlockE
{
	highp vec4 j;
	f16vec4 k;
	highp mat4x2 l;
	f16vec3 m[];
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.a), vec3(-5.0, -9.0, -7.0)) && allOk;
	allOk = compare_int16_t(int(blockB.b), 9) && allOk;
	allOk = compare_mat3(blockB.c.mA, mat3(-1.0, 0.0, -3.0, 9.0, -2.0, 0.0, 3.0, -3.0, 2.0)) && allOk;
	allOk = compare_uvec4((blockB.c.mB), uvec4(3u, 4u, 7u, 4u)) && allOk;
	allOk = compare_vec3((blockB.c.mC), vec3(8.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(blockB.c.mD, mat3x2(-3.0, -9.0, 5.0, -9.0, 7.0, 4.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockC.e), ivec3(9, 7, 8)) && allOk;
	allOk = compare_uvec3((blockD.h), uvec3(7u, 1u, 0u)) && allOk;
	allOk = compare_vec4((blockE.j), vec4(5.0, -5.0, -2.0, 8.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockE.k), vec4(-5.0, 0.0, -3.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec3(-7.0, 4.0, -4.0));
	blockB.b = int16_t(-7);
	blockB.c.mA = (mat3(-3.0, -9.0, 1.0, 2.0, 8.0, -2.0, 5.0, -7.0, -5.0));
	blockB.c.mB = (uvec4(1u, 9u, 5u, 2u));
	blockB.c.mC = (vec3(1.0, 2.0, -4.0));
	blockB.c.mD = (mat3x2(-6.0, 7.0, 1.0, 9.0, 1.0, 3.0));
	blockB.d[0] = (ivec4(9, 6, 4, -5));
	blockB.d[1] = (ivec4(-6, 2, 8, 0));
	blockB.d[2] = (ivec4(6, 5, 6, -3));
	blockB.d[3] = (ivec4(-8, 8, -8, -6));
	blockB.d[4] = (ivec4(-5, 0, 0, 2));
	blockB.d[5] = (ivec4(-1, -4, -3, 0));
	blockB.d[6] = (ivec4(5, -3, 7, 4));
	blockB.d[7] = (ivec4(0, -3, -8, -4));
	blockC.e = i16vec3(ivec3(-1, -5, 1));
	blockC.g[0] = (6u);
	blockC.g[1] = (0u);
	blockC.g[2] = (2u);
	blockC.g[3] = (3u);
	blockC.g[4] = (7u);
	blockC.g[5] = (5u);
	blockC.g[6] = (0u);
	blockC.g[7] = (9u);
	blockD.h = (uvec3(0u, 2u, 8u));
	blockD.i = (bvec2(false, false));
}
#version 450
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
	mediump vec3 a;
	mediump vec4 b;
	mediump mat3x4 c[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	lowp vec4 d;
	highp int e;
	mediump mat4x3 f[];
};
layout(std140, buffer_reference) buffer BlockD
{
	mediump float g;
	highp uint h;
	highp ivec4 i;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[2];
    BlockD blockD[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB.c[0], mat3x4(-9.0, -2.0, -6.0, -9.0, 8.0, -6.0, -3.0, -7.0, 6.0, 4.0, 2.0, -5.0)) && allOk;
	allOk = compare_vec4((blockC[0].d), vec4(-7.0, 3.0, 5.0, 2.0)) && allOk;
	allOk = compare_int((blockC[0].e), -9) && allOk;
	allOk = compare_mat4x3(blockC[0].f[0], mat4x3(0.0, -8.0, 5.0, -5.0, 0.0, -7.0, 0.0, 3.0, 1.0, 1.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat4x3(blockC[0].f[1], mat4x3(2.0, -3.0, -5.0, 0.0, 7.0, 6.0, 1.0, -6.0, -8.0, 8.0, -9.0, -8.0)) && allOk;
	allOk = compare_vec4((blockC[1].d), vec4(3.0, 3.0, 8.0, 4.0)) && allOk;
	allOk = compare_int((blockC[1].e), -1) && allOk;
	allOk = compare_mat4x3(blockC[1].f[0], mat4x3(3.0, 2.0, 5.0, -6.0, -4.0, -2.0, 8.0, 9.0, 4.0, -6.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat4x3(blockC[1].f[1], mat4x3(-7.0, 7.0, 4.0, -8.0, -9.0, -7.0, 2.0, -3.0, -1.0, 4.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(blockC[1].f[2], mat4x3(1.0, 6.0, -2.0, -7.0, -8.0, -5.0, 1.0, -5.0, 9.0, -5.0, 5.0, 4.0)) && allOk;
	allOk = compare_float((blockD[0].g), 7.0) && allOk;
	allOk = compare_ivec4((blockD[0].i), ivec4(-6, 2, 0, -9)) && allOk;
	allOk = compare_float((blockD[1].g), 8.0) && allOk;
	allOk = compare_ivec4((blockD[1].i), ivec4(-7, -1, 0, -2)) && allOk;
	allOk = compare_float((blockD[2].g), -9.0) && allOk;
	allOk = compare_ivec4((blockD[2].i), ivec4(1, -3, -4, 0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec3(9.0, -7.0, -5.0));
	blockB.c[0] = (mat3x4(0.0, 1.0, 9.0, 9.0, 8.0, 2.0, -6.0, 4.0, 7.0, -5.0, -3.0, 0.0));
	blockC[0].d = (vec4(4.0, 5.0, -2.0, 4.0));
	blockC[0].e = (-6);
	blockC[0].f[0] = (mat4x3(5.0, 4.0, 4.0, -4.0, -5.0, -9.0, 9.0, 8.0, -1.0, 1.0, -5.0, -6.0));
	blockC[0].f[1] = (mat4x3(9.0, 9.0, -6.0, -8.0, -2.0, -2.0, -4.0, 3.0, 5.0, -9.0, 1.0, -3.0));
	blockC[1].d = (vec4(4.0, 7.0, -1.0, -2.0));
	blockC[1].e = (2);
	blockC[1].f[0] = (mat4x3(-2.0, -9.0, -5.0, 1.0, 0.0, 8.0, 0.0, 7.0, 2.0, 2.0, -3.0, 2.0));
	blockC[1].f[1] = (mat4x3(-2.0, -1.0, -1.0, -1.0, -2.0, -6.0, 4.0, 2.0, -4.0, -3.0, -3.0, 3.0));
	blockC[1].f[2] = (mat4x3(-8.0, -2.0, 3.0, 6.0, -3.0, -1.0, 7.0, 0.0, -9.0, -3.0, 7.0, 0.0));
	blockD[0].g = (3.0);
	blockD[0].h = (0u);
	blockD[0].i = (ivec4(-5, 0, 2, -2));
	blockD[1].g = (-7.0);
	blockD[1].h = (9u);
	blockD[1].i = (ivec4(-2, -8, 1, 1));
	blockD[2].g = (-6.0);
	blockD[2].h = (3u);
	blockD[2].i = (ivec4(-1, 5, -2, 8));
}
#version 450
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

}
#version 450
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
	bvec3 mB;
};
struct sB
{
	f16vec3 mA;
	highp mat2 mB;
};
layout(scalar, column_major, buffer_reference) buffer BlockB
{
	highp mat4x3 a;
	f16vec3 b;
	f16vec4 c;
	lowp mat3x4 d;
	i16vec2 e[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	highp mat3 f[];
};
layout(scalar, row_major, buffer_reference) buffer BlockD
{
	u16vec3 g;
	bool h[8];
	sA i;
	sB j;
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.a, mat4x3(0.0, 3.0, 3.0, 2.0, 0.0, -3.0, 1.0, -5.0, -2.0, -7.0, 3.0, 6.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.b), vec3(2.0, 3.0, 3.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.c), vec4(3.0, 5.0, -5.0, -2.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockD.g), uvec3(4u, 7u, 1u)) && allOk;
	allOk = compare_bool((blockD.h[0]), true) && allOk;
	allOk = compare_bool((blockD.h[1]), true) && allOk;
	allOk = compare_bool((blockD.h[2]), false) && allOk;
	allOk = compare_bool((blockD.h[3]), false) && allOk;
	allOk = compare_bool((blockD.h[4]), true) && allOk;
	allOk = compare_bool((blockD.h[5]), false) && allOk;
	allOk = compare_bool((blockD.h[6]), false) && allOk;
	allOk = compare_bool((blockD.h[7]), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x3(5.0, -5.0, 3.0, 9.0, -5.0, -5.0, 0.0, -1.0, -9.0, 2.0, -4.0, -8.0));
	blockB.b = f16vec3(vec3(-4.0, 8.0, 6.0));
	blockB.e[0] = i16vec2(ivec2(-8, 4));
	blockB.e[1] = i16vec2(ivec2(6, -9));
	blockC.f[0] = (mat3(5.0, 3.0, -3.0, 6.0, 0.0, -8.0, 1.0, -1.0, -6.0));
	blockC.f[1] = (mat3(3.0, 2.0, -9.0, 2.0, -9.0, 6.0, 7.0, 1.0, 2.0));
	blockC.f[2] = (mat3(-1.0, -8.0, -9.0, 2.0, -7.0, 2.0, -5.0, 8.0, -2.0));
	blockC.f[3] = (mat3(3.0, 0.0, -7.0, -7.0, 4.0, -2.0, 2.0, -1.0, -2.0));
	blockD.h[0] = (true);
	blockD.h[1] = (true);
	blockD.h[2] = (true);
	blockD.h[3] = (true);
	blockD.h[4] = (true);
	blockD.h[5] = (false);
	blockD.h[6] = (true);
	blockD.h[7] = (true);
	blockD.i.mA = f16vec4(vec4(-5.0, 0.0, -3.0, 0.0));
	blockD.i.mB = (bvec3(false, false, true));
	blockD.j.mA = f16vec3(vec3(-7.0, -6.0, 7.0));
	blockD.j.mB = (mat2(-6.0, 3.0, -5.0, 9.0));
}
#version 450
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
	lowp float mB;
	highp mat2 mC;
	lowp ivec2 mD;
};
layout(scalar, column_major, buffer_reference) buffer BlockB
{
	sA a[][5];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a[0][0].mA), ivec2(4, -1)) && allOk;
	allOk = compare_float((blockB.a[0][0].mB), -5.0) && allOk;
	allOk = compare_mat2(blockB.a[0][0].mC, mat2(-7.0, 4.0, 6.0, -4.0)) && allOk;
	allOk = compare_ivec2((blockB.a[0][0].mD), ivec2(-7, 2)) && allOk;
	allOk = compare_ivec2((blockB.a[0][1].mA), ivec2(5, 4)) && allOk;
	allOk = compare_float((blockB.a[0][1].mB), 6.0) && allOk;
	allOk = compare_mat2(blockB.a[0][1].mC, mat2(3.0, 2.0, 9.0, -4.0)) && allOk;
	allOk = compare_ivec2((blockB.a[0][1].mD), ivec2(6, -8)) && allOk;
	allOk = compare_ivec2((blockB.a[0][2].mA), ivec2(-9, 9)) && allOk;
	allOk = compare_float((blockB.a[0][2].mB), -6.0) && allOk;
	allOk = compare_mat2(blockB.a[0][2].mC, mat2(3.0, -9.0, -7.0, -1.0)) && allOk;
	allOk = compare_ivec2((blockB.a[0][2].mD), ivec2(-8, -8)) && allOk;
	allOk = compare_ivec2((blockB.a[0][3].mA), ivec2(9, -2)) && allOk;
	allOk = compare_float((blockB.a[0][3].mB), 9.0) && allOk;
	allOk = compare_mat2(blockB.a[0][3].mC, mat2(3.0, 1.0, -2.0, 6.0)) && allOk;
	allOk = compare_ivec2((blockB.a[0][3].mD), ivec2(1, -9)) && allOk;
	allOk = compare_ivec2((blockB.a[0][4].mA), ivec2(6, 4)) && allOk;
	allOk = compare_float((blockB.a[0][4].mB), 2.0) && allOk;
	allOk = compare_mat2(blockB.a[0][4].mC, mat2(-2.0, 0.0, 7.0, 4.0)) && allOk;
	allOk = compare_ivec2((blockB.a[0][4].mD), ivec2(-9, -8)) && allOk;
	allOk = compare_ivec2((blockB.a[1][0].mA), ivec2(1, 6)) && allOk;
	allOk = compare_float((blockB.a[1][0].mB), -8.0) && allOk;
	allOk = compare_mat2(blockB.a[1][0].mC, mat2(-1.0, 8.0, 3.0, 9.0)) && allOk;
	allOk = compare_ivec2((blockB.a[1][0].mD), ivec2(-2, 3)) && allOk;
	allOk = compare_ivec2((blockB.a[1][1].mA), ivec2(7, 4)) && allOk;
	allOk = compare_float((blockB.a[1][1].mB), -1.0) && allOk;
	allOk = compare_mat2(blockB.a[1][1].mC, mat2(1.0, 0.0, 3.0, 9.0)) && allOk;
	allOk = compare_ivec2((blockB.a[1][1].mD), ivec2(-6, -5)) && allOk;
	allOk = compare_ivec2((blockB.a[1][2].mA), ivec2(-8, -9)) && allOk;
	allOk = compare_float((blockB.a[1][2].mB), -9.0) && allOk;
	allOk = compare_mat2(blockB.a[1][2].mC, mat2(6.0, 9.0, -4.0, -2.0)) && allOk;
	allOk = compare_ivec2((blockB.a[1][2].mD), ivec2(-3, 5)) && allOk;
	allOk = compare_ivec2((blockB.a[1][3].mA), ivec2(1, 0)) && allOk;
	allOk = compare_float((blockB.a[1][3].mB), 5.0) && allOk;
	allOk = compare_mat2(blockB.a[1][3].mC, mat2(5.0, 3.0, -2.0, -8.0)) && allOk;
	allOk = compare_ivec2((blockB.a[1][3].mD), ivec2(4, -8)) && allOk;
	allOk = compare_ivec2((blockB.a[1][4].mA), ivec2(0, -6)) && allOk;
	allOk = compare_float((blockB.a[1][4].mB), 8.0) && allOk;
	allOk = compare_mat2(blockB.a[1][4].mC, mat2(-9.0, 2.0, -2.0, -7.0)) && allOk;
	allOk = compare_ivec2((blockB.a[1][4].mD), ivec2(1, 6)) && allOk;
	allOk = compare_ivec2((blockB.a[2][0].mA), ivec2(1, 9)) && allOk;
	allOk = compare_float((blockB.a[2][0].mB), 7.0) && allOk;
	allOk = compare_mat2(blockB.a[2][0].mC, mat2(-7.0, 9.0, 7.0, -5.0)) && allOk;
	allOk = compare_ivec2((blockB.a[2][0].mD), ivec2(3, 1)) && allOk;
	allOk = compare_ivec2((blockB.a[2][1].mA), ivec2(1, 0)) && allOk;
	allOk = compare_float((blockB.a[2][1].mB), 8.0) && allOk;
	allOk = compare_mat2(blockB.a[2][1].mC, mat2(-7.0, -8.0, 6.0, 9.0)) && allOk;
	allOk = compare_ivec2((blockB.a[2][1].mD), ivec2(8, 6)) && allOk;
	allOk = compare_ivec2((blockB.a[2][2].mA), ivec2(9, 0)) && allOk;
	allOk = compare_float((blockB.a[2][2].mB), -6.0) && allOk;
	allOk = compare_mat2(blockB.a[2][2].mC, mat2(8.0, 6.0, -7.0, -3.0)) && allOk;
	allOk = compare_ivec2((blockB.a[2][2].mD), ivec2(-6, -1)) && allOk;
	allOk = compare_ivec2((blockB.a[2][3].mA), ivec2(7, 8)) && allOk;
	allOk = compare_float((blockB.a[2][3].mB), 1.0) && allOk;
	allOk = compare_mat2(blockB.a[2][3].mC, mat2(4.0, 1.0, 1.0, -5.0)) && allOk;
	allOk = compare_ivec2((blockB.a[2][3].mD), ivec2(3, 1)) && allOk;
	allOk = compare_ivec2((blockB.a[2][4].mA), ivec2(-2, 3)) && allOk;
	allOk = compare_float((blockB.a[2][4].mB), 5.0) && allOk;
	allOk = compare_mat2(blockB.a[2][4].mC, mat2(-8.0, -8.0, -7.0, 7.0)) && allOk;
	allOk = compare_ivec2((blockB.a[2][4].mD), ivec2(-7, -4)) && allOk;
	allOk = compare_ivec2((blockB.a[3][0].mA), ivec2(-6, -4)) && allOk;
	allOk = compare_float((blockB.a[3][0].mB), -7.0) && allOk;
	allOk = compare_mat2(blockB.a[3][0].mC, mat2(-9.0, 7.0, 3.0, -6.0)) && allOk;
	allOk = compare_ivec2((blockB.a[3][0].mD), ivec2(5, 8)) && allOk;
	allOk = compare_ivec2((blockB.a[3][1].mA), ivec2(2, -7)) && allOk;
	allOk = compare_float((blockB.a[3][1].mB), -2.0) && allOk;
	allOk = compare_mat2(blockB.a[3][1].mC, mat2(-1.0, 0.0, -6.0, -1.0)) && allOk;
	allOk = compare_ivec2((blockB.a[3][1].mD), ivec2(4, 0)) && allOk;
	allOk = compare_ivec2((blockB.a[3][2].mA), ivec2(-8, 6)) && allOk;
	allOk = compare_float((blockB.a[3][2].mB), -7.0) && allOk;
	allOk = compare_mat2(blockB.a[3][2].mC, mat2(-9.0, -1.0, -2.0, 4.0)) && allOk;
	allOk = compare_ivec2((blockB.a[3][2].mD), ivec2(-5, -3)) && allOk;
	allOk = compare_ivec2((blockB.a[3][3].mA), ivec2(-7, -4)) && allOk;
	allOk = compare_float((blockB.a[3][3].mB), -6.0) && allOk;
	allOk = compare_mat2(blockB.a[3][3].mC, mat2(6.0, 9.0, 8.0, -2.0)) && allOk;
	allOk = compare_ivec2((blockB.a[3][3].mD), ivec2(4, -7)) && allOk;
	allOk = compare_ivec2((blockB.a[3][4].mA), ivec2(-9, 8)) && allOk;
	allOk = compare_float((blockB.a[3][4].mB), 9.0) && allOk;
	allOk = compare_mat2(blockB.a[3][4].mC, mat2(-6.0, -4.0, -7.0, -9.0)) && allOk;
	allOk = compare_ivec2((blockB.a[3][4].mD), ivec2(-6, 2)) && allOk;
	allOk = compare_ivec2((blockB.a[4][0].mA), ivec2(2, -9)) && allOk;
	allOk = compare_float((blockB.a[4][0].mB), -1.0) && allOk;
	allOk = compare_mat2(blockB.a[4][0].mC, mat2(-5.0, -3.0, -4.0, -5.0)) && allOk;
	allOk = compare_ivec2((blockB.a[4][0].mD), ivec2(7, -7)) && allOk;
	allOk = compare_ivec2((blockB.a[4][1].mA), ivec2(-7, 9)) && allOk;
	allOk = compare_float((blockB.a[4][1].mB), 7.0) && allOk;
	allOk = compare_mat2(blockB.a[4][1].mC, mat2(6.0, 6.0, 2.0, -7.0)) && allOk;
	allOk = compare_ivec2((blockB.a[4][1].mD), ivec2(7, -7)) && allOk;
	allOk = compare_ivec2((blockB.a[4][2].mA), ivec2(-6, 8)) && allOk;
	allOk = compare_float((blockB.a[4][2].mB), -2.0) && allOk;
	allOk = compare_mat2(blockB.a[4][2].mC, mat2(-2.0, -8.0, -6.0, -2.0)) && allOk;
	allOk = compare_ivec2((blockB.a[4][2].mD), ivec2(-8, 2)) && allOk;
	allOk = compare_ivec2((blockB.a[4][3].mA), ivec2(6, 0)) && allOk;
	allOk = compare_float((blockB.a[4][3].mB), -6.0) && allOk;
	allOk = compare_mat2(blockB.a[4][3].mC, mat2(4.0, -2.0, 5.0, 3.0)) && allOk;
	allOk = compare_ivec2((blockB.a[4][3].mD), ivec2(1, -9)) && allOk;
	allOk = compare_ivec2((blockB.a[4][4].mA), ivec2(9, -7)) && allOk;
	allOk = compare_float((blockB.a[4][4].mB), -2.0) && allOk;
	allOk = compare_mat2(blockB.a[4][4].mC, mat2(-4.0, -3.0, -7.0, 1.0)) && allOk;
	allOk = compare_ivec2((blockB.a[4][4].mD), ivec2(7, 2)) && allOk;
	allOk = compare_ivec2((blockB.a[5][0].mA), ivec2(6, 8)) && allOk;
	allOk = compare_float((blockB.a[5][0].mB), -1.0) && allOk;
	allOk = compare_mat2(blockB.a[5][0].mC, mat2(8.0, -3.0, 6.0, -1.0)) && allOk;
	allOk = compare_ivec2((blockB.a[5][0].mD), ivec2(6, -6)) && allOk;
	allOk = compare_ivec2((blockB.a[5][1].mA), ivec2(-6, -9)) && allOk;
	allOk = compare_float((blockB.a[5][1].mB), -6.0) && allOk;
	allOk = compare_mat2(blockB.a[5][1].mC, mat2(5.0, -7.0, -7.0, -1.0)) && allOk;
	allOk = compare_ivec2((blockB.a[5][1].mD), ivec2(-9, 6)) && allOk;
	allOk = compare_ivec2((blockB.a[5][2].mA), ivec2(-9, 5)) && allOk;
	allOk = compare_float((blockB.a[5][2].mB), 0.0) && allOk;
	allOk = compare_mat2(blockB.a[5][2].mC, mat2(-4.0, 5.0, 9.0, -7.0)) && allOk;
	allOk = compare_ivec2((blockB.a[5][2].mD), ivec2(-8, -6)) && allOk;
	allOk = compare_ivec2((blockB.a[5][3].mA), ivec2(2, -3)) && allOk;
	allOk = compare_float((blockB.a[5][3].mB), 1.0) && allOk;
	allOk = compare_mat2(blockB.a[5][3].mC, mat2(0.0, 1.0, 8.0, 2.0)) && allOk;
	allOk = compare_ivec2((blockB.a[5][3].mD), ivec2(-2, 9)) && allOk;
	allOk = compare_ivec2((blockB.a[5][4].mA), ivec2(7, 9)) && allOk;
	allOk = compare_float((blockB.a[5][4].mB), -3.0) && allOk;
	allOk = compare_mat2(blockB.a[5][4].mC, mat2(-5.0, 1.0, 0.0, 6.0)) && allOk;
	allOk = compare_ivec2((blockB.a[5][4].mD), ivec2(-2, 6)) && allOk;
	allOk = compare_ivec2((blockB.a[6][0].mA), ivec2(-9, -6)) && allOk;
	allOk = compare_float((blockB.a[6][0].mB), -2.0) && allOk;
	allOk = compare_mat2(blockB.a[6][0].mC, mat2(-3.0, -6.0, 7.0, 6.0)) && allOk;
	allOk = compare_ivec2((blockB.a[6][0].mD), ivec2(-6, 8)) && allOk;
	allOk = compare_ivec2((blockB.a[6][1].mA), ivec2(5, -5)) && allOk;
	allOk = compare_float((blockB.a[6][1].mB), -6.0) && allOk;
	allOk = compare_mat2(blockB.a[6][1].mC, mat2(-9.0, -2.0, 6.0, -8.0)) && allOk;
	allOk = compare_ivec2((blockB.a[6][1].mD), ivec2(-1, -6)) && allOk;
	allOk = compare_ivec2((blockB.a[6][2].mA), ivec2(0, 5)) && allOk;
	allOk = compare_float((blockB.a[6][2].mB), -8.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0][0].mA = (ivec2(5, 7));
	blockB.a[0][0].mB = (4.0);
	blockB.a[0][0].mC = (mat2(2.0, -1.0, -7.0, 3.0));
	blockB.a[0][0].mD = (ivec2(-1, 5));
	blockB.a[0][1].mA = (ivec2(-9, -2));
	blockB.a[0][1].mB = (3.0);
	blockB.a[0][1].mC = (mat2(7.0, -6.0, 7.0, -9.0));
	blockB.a[0][1].mD = (ivec2(7, -9));
	blockB.a[0][2].mA = (ivec2(-6, -6));
	blockB.a[0][2].mB = (6.0);
	blockB.a[0][2].mC = (mat2(-5.0, 9.0, 3.0, -7.0));
	blockB.a[0][2].mD = (ivec2(2, 4));
	blockB.a[0][3].mA = (ivec2(-4, -3));
	blockB.a[0][3].mB = (2.0);
	blockB.a[0][3].mC = (mat2(5.0, -3.0, 7.0, 3.0));
	blockB.a[0][3].mD = (ivec2(-3, 5));
	blockB.a[0][4].mA = (ivec2(6, 1));
	blockB.a[0][4].mB = (-8.0);
	blockB.a[0][4].mC = (mat2(3.0, 1.0, -9.0, -6.0));
	blockB.a[0][4].mD = (ivec2(-5, -8));
	blockB.a[1][0].mA = (ivec2(-9, -6));
	blockB.a[1][0].mB = (9.0);
	blockB.a[1][0].mC = (mat2(-7.0, -5.0, 7.0, 5.0));
	blockB.a[1][0].mD = (ivec2(-4, 9));
	blockB.a[1][1].mA = (ivec2(-9, 9));
	blockB.a[1][1].mB = (6.0);
	blockB.a[1][1].mC = (mat2(-2.0, 3.0, -8.0, -8.0));
	blockB.a[1][1].mD = (ivec2(1, -9));
	blockB.a[1][2].mA = (ivec2(3, -5));
	blockB.a[1][2].mB = (6.0);
	blockB.a[1][2].mC = (mat2(1.0, -7.0, 8.0, -9.0));
	blockB.a[1][2].mD = (ivec2(9, 1));
	blockB.a[1][3].mA = (ivec2(5, 2));
	blockB.a[1][3].mB = (4.0);
	blockB.a[1][3].mC = (mat2(0.0, 5.0, -3.0, 2.0));
	blockB.a[1][3].mD = (ivec2(-4, -3));
	blockB.a[1][4].mA = (ivec2(-7, 5));
	blockB.a[1][4].mB = (-6.0);
	blockB.a[1][4].mC = (mat2(7.0, -4.0, -8.0, -7.0));
	blockB.a[1][4].mD = (ivec2(-3, 5));
	blockB.a[2][0].mA = (ivec2(1, -2));
	blockB.a[2][0].mB = (1.0);
	blockB.a[2][0].mC = (mat2(5.0, 7.0, -3.0, 2.0));
	blockB.a[2][0].mD = (ivec2(-2, -5));
	blockB.a[2][1].mA = (ivec2(7, 0));
	blockB.a[2][1].mB = (-6.0);
	blockB.a[2][1].mC = (mat2(9.0, 5.0, 1.0, -5.0));
	blockB.a[2][1].mD = (ivec2(-7, -7));
	blockB.a[2][2].mA = (ivec2(-3, 2));
	blockB.a[2][2].mB = (2.0);
	blockB.a[2][2].mC = (mat2(-9.0, 3.0, -9.0, -7.0));
	blockB.a[2][2].mD = (ivec2(0, 6));
	blockB.a[2][3].mA = (ivec2(7, -7));
	blockB.a[2][3].mB = (-4.0);
	blockB.a[2][3].mC = (mat2(-6.0, -5.0, 6.0, 3.0));
	blockB.a[2][3].mD = (ivec2(-3, -8));
	blockB.a[2][4].mA = (ivec2(3, 5));
	blockB.a[2][4].mB = (5.0);
	blockB.a[2][4].mC = (mat2(2.0, -1.0, -8.0, -1.0));
	blockB.a[2][4].mD = (ivec2(1, -9));
	blockB.a[3][0].mA = (ivec2(-1, -3));
	blockB.a[3][0].mB = (2.0);
	blockB.a[3][0].mC = (mat2(-2.0, 9.0, 5.0, 7.0));
	blockB.a[3][0].mD = (ivec2(-8, -4));
	blockB.a[3][1].mA = (ivec2(2, 3));
	blockB.a[3][1].mB = (9.0);
	blockB.a[3][1].mC = (mat2(8.0, -4.0, 5.0, 0.0));
	blockB.a[3][1].mD = (ivec2(-7, -1));
	blockB.a[3][2].mA = (ivec2(7, 5));
	blockB.a[3][2].mB = (-7.0);
	blockB.a[3][2].mC = (mat2(6.0, 9.0, -8.0, 9.0));
	blockB.a[3][2].mD = (ivec2(9, -1));
	blockB.a[3][3].mA = (ivec2(4, -6));
	blockB.a[3][3].mB = (-3.0);
	blockB.a[3][3].mC = (mat2(-6.0, 5.0, 4.0, 9.0));
	blockB.a[3][3].mD = (ivec2(9, -8));
	blockB.a[3][4].mA = (ivec2(-6, -5));
	blockB.a[3][4].mB = (-9.0);
	blockB.a[3][4].mC = (mat2(2.0, -4.0, -4.0, -5.0));
	blockB.a[3][4].mD = (ivec2(-3, -7));
	blockB.a[4][0].mA = (ivec2(-9, -9));
	blockB.a[4][0].mB = (-6.0);
	blockB.a[4][0].mC = (mat2(-5.0, 9.0, -3.0, 8.0));
	blockB.a[4][0].mD = (ivec2(0, 8));
	blockB.a[4][1].mA = (ivec2(-4, -9));
	blockB.a[4][1].mB = (-8.0);
	blockB.a[4][1].mC = (mat2(6.0, 3.0, 8.0, -7.0));
	blockB.a[4][1].mD = (ivec2(-5, -5));
	blockB.a[4][2].mA = (ivec2(3, 4));
	blockB.a[4][2].mB = (7.0);
	blockB.a[4][2].mC = (mat2(-7.0, 1.0, -5.0, 5.0));
	blockB.a[4][2].mD = (ivec2(7, 2));
	blockB.a[4][3].mA = (ivec2(6, 7));
	blockB.a[4][3].mB = (2.0);
	blockB.a[4][3].mC = (mat2(2.0, -6.0, 7.0, 5.0));
	blockB.a[4][3].mD = (ivec2(6, 7));
	blockB.a[4][4].mA = (ivec2(8, 8));
	blockB.a[4][4].mB = (-3.0);
	blockB.a[4][4].mC = (mat2(-5.0, -4.0, 3.0, -1.0));
	blockB.a[4][4].mD = (ivec2(-9, -8));
	blockB.a[5][0].mA = (ivec2(-2, -4));
	blockB.a[5][0].mB = (5.0);
	blockB.a[5][0].mC = (mat2(-3.0, 7.0, -4.0, -9.0));
	blockB.a[5][0].mD = (ivec2(2, 6));
	blockB.a[5][1].mA = (ivec2(-5, 4));
	blockB.a[5][1].mB = (4.0);
	blockB.a[5][1].mC = (mat2(2.0, 8.0, -4.0, 1.0));
	blockB.a[5][1].mD = (ivec2(-9, 4));
	blockB.a[5][2].mA = (ivec2(-1, -3));
	blockB.a[5][2].mB = (8.0);
	blockB.a[5][2].mC = (mat2(5.0, 2.0, 5.0, -6.0));
	blockB.a[5][2].mD = (ivec2(8, -2));
	blockB.a[5][3].mA = (ivec2(7, 6));
	blockB.a[5][3].mB = (1.0);
	blockB.a[5][3].mC = (mat2(7.0, -8.0, 2.0, -9.0));
	blockB.a[5][3].mD = (ivec2(7, -8));
	blockB.a[5][4].mA = (ivec2(0, 3));
	blockB.a[5][4].mB = (-6.0);
	blockB.a[5][4].mC = (mat2(-5.0, -2.0, 6.0, 3.0));
	blockB.a[5][4].mD = (ivec2(-7, 7));
	blockB.a[6][0].mA = (ivec2(-4, 3));
	blockB.a[6][0].mB = (9.0);
	blockB.a[6][0].mC = (mat2(-2.0, 9.0, 7.0, 8.0));
	blockB.a[6][0].mD = (ivec2(3, -7));
	blockB.a[6][1].mA = (ivec2(-2, -3));
	blockB.a[6][1].mB = (4.0);
	blockB.a[6][1].mC = (mat2(-7.0, 6.0, -2.0, -4.0));
	blockB.a[6][1].mD = (ivec2(-7, 3));
	blockB.a[6][2].mA = (ivec2(-7, -6));
	blockB.a[6][2].mB = (8.0);
	blockB.a[6][2].mC = (mat2(3.0, 2.0, -7.0, -9.0));
	blockB.a[6][2].mD = (ivec2(-8, -4));
	blockB.a[6][3].mA = (ivec2(-4, 7));
	blockB.a[6][3].mB = (6.0);
	blockB.a[6][3].mC = (mat2(-8.0, 1.0, -5.0, -2.0));
	blockB.a[6][3].mD = (ivec2(-4, -5));
	blockB.a[6][4].mA = (ivec2(-3, 8));
	blockB.a[6][4].mB = (-4.0);
	blockB.a[6][4].mC = (mat2(-6.0, 1.0, -5.0, -1.0));
	blockB.a[6][4].mD = (ivec2(-4, -5));
}
#version 450
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
	mediump mat4x2 a;
	lowp vec4 b;
	lowp mat4x2 c;
	u16vec2 d;
	lowp mat3x4 e[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	lowp mat3x4 f[2];
	mediump mat2x3 g;
	bvec4 h[];
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.b), vec4(2.0, -8.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat4x2(blockB.c, mat4x2(-1.0, -5.0, -5.0, 3.0, -8.0, 1.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3x4(blockC.f[0], mat3x4(2.0, 6.0, 3.0, -2.0, 4.0, 1.0, 3.0, -3.0, -1.0, -9.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(blockC.f[1], mat3x4(0.0, 1.0, 3.0, 2.0, -4.0, -3.0, -3.0, -4.0, 0.0, 1.0, 2.0, 5.0)) && allOk;
	allOk = compare_bvec4((blockC.h[0]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((blockC.h[1]), bvec4(false, false, true, true)) && allOk;
	allOk = compare_bvec4((blockC.h[2]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((blockC.h[3]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((blockC.h[4]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((blockC.h[5]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((blockC.h[6]), bvec4(false, false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x2(7.0, 7.0, 1.0, -6.0, -1.0, 9.0, 3.0, -5.0));
	blockC.f[0] = (mat3x4(-5.0, -5.0, -1.0, 3.0, -6.0, 7.0, -2.0, -7.0, 0.0, 4.0, -1.0, -2.0));
	blockC.f[1] = (mat3x4(6.0, -3.0, -3.0, 3.0, 9.0, -4.0, -2.0, -1.0, -8.0, 5.0, 9.0, 3.0));
	blockC.g = (mat2x3(-7.0, 5.0, 4.0, 3.0, -5.0, -8.0));
	blockC.h[0] = (bvec4(true, false, true, false));
	blockC.h[1] = (bvec4(true, true, false, false));
	blockC.h[2] = (bvec4(false, true, true, false));
	blockC.h[3] = (bvec4(false, false, false, true));
	blockC.h[4] = (bvec4(true, true, true, false));
	blockC.h[5] = (bvec4(true, false, true, true));
	blockC.h[6] = (bvec4(true, true, false, true));
}
#version 450
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
	float16_t a;
	i16vec3 b;
	highp mat3x4 c[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	u16vec4 d;
	highp int e;
	float16_t f;
	uint16_t g[];
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	highp ivec4 h[2];
	i16vec4 i[3];
	u16vec4 j;
	mediump mat4 k[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[1];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockB.a), -8.0) && allOk;
	allOk = compare_i16vec3(ivec3(blockB.b), ivec3(4, -4, -9)) && allOk;
	allOk = compare_mat3x4(blockB.c[0], mat3x4(0.0, 6.0, 0.0, 6.0, 4.0, -1.0, 2.0, -5.0, -4.0, 2.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat3x4(blockB.c[1], mat3x4(9.0, -2.0, 6.0, 8.0, 0.0, 1.0, 3.0, -1.0, 0.0, 2.0, 1.0, 3.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[0].d), uvec4(5u, 6u, 0u, 4u)) && allOk;
	allOk = compare_float16_t(float(blockC[0].f), 2.0) && allOk;
	allOk = compare_uint16_t(uint(blockC[0].g[0]), 4u) && allOk;
	allOk = compare_uint16_t(uint(blockC[0].g[1]), 5u) && allOk;
	allOk = compare_uint16_t(uint(blockC[0].g[2]), 2u) && allOk;
	allOk = compare_uint16_t(uint(blockC[0].g[3]), 4u) && allOk;
	allOk = compare_uint16_t(uint(blockC[0].g[4]), 9u) && allOk;
	allOk = compare_uint16_t(uint(blockC[0].g[5]), 9u) && allOk;
	allOk = compare_u16vec4(uvec4(blockD.j), uvec4(2u, 4u, 1u, 0u)) && allOk;
	allOk = compare_mat4(blockD.k[0], mat4(0.0, 3.0, -1.0, -5.0, -5.0, 2.0, -5.0, -5.0, 4.0, 2.0, 9.0, 3.0, 6.0, -1.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat4(blockD.k[1], mat4(9.0, -9.0, 7.0, 4.0, 0.0, -2.0, 0.0, -5.0, 5.0, 0.0, 0.0, 9.0, -5.0, -7.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat4(blockD.k[2], mat4(0.0, 5.0, 9.0, -1.0, -9.0, -2.0, -8.0, 6.0, 5.0, 0.0, -4.0, -9.0, 0.0, -4.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat4(blockD.k[3], mat4(8.0, -3.0, -4.0, -8.0, -9.0, -2.0, -9.0, 7.0, 0.0, 2.0, 1.0, -8.0, -4.0, -6.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4(blockD.k[4], mat4(-9.0, 8.0, -3.0, 3.0, 2.0, 0.0, -1.0, 9.0, 3.0, 3.0, -8.0, -1.0, 8.0, -8.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat4(blockD.k[5], mat4(-2.0, 2.0, -6.0, -7.0, 7.0, 1.0, 9.0, -2.0, 3.0, 3.0, 4.0, -9.0, 0.0, 5.0, 6.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = float16_t(-9.0);
	blockB.b = i16vec3(ivec3(-9, 8, -8));
	blockC[0].e = (7);
	blockC[0].f = float16_t(9.0);
	blockC[0].g[0] = uint16_t(5u);
	blockC[0].g[1] = uint16_t(8u);
	blockC[0].g[2] = uint16_t(6u);
	blockC[0].g[3] = uint16_t(4u);
	blockC[0].g[4] = uint16_t(5u);
	blockC[0].g[5] = uint16_t(5u);
	blockD.h[0] = (ivec4(-7, 7, 8, -9));
	blockD.h[1] = (ivec4(-1, -4, 3, 5));
	blockD.j = u16vec4(uvec4(1u, 3u, 1u, 7u));
	blockD.k[0] = (mat4(-7.0, 4.0, -7.0, -9.0, 8.0, 4.0, -5.0, -5.0, 2.0, 3.0, -6.0, 7.0, -1.0, 8.0, 3.0, 2.0));
	blockD.k[1] = (mat4(-4.0, -1.0, -9.0, 4.0, -9.0, -3.0, -6.0, 6.0, -7.0, 1.0, 3.0, 8.0, -3.0, -9.0, 7.0, 3.0));
	blockD.k[2] = (mat4(2.0, 0.0, 6.0, -7.0, 0.0, -6.0, -4.0, -7.0, 5.0, 3.0, 4.0, -4.0, -5.0, -1.0, 3.0, -5.0));
	blockD.k[3] = (mat4(-7.0, -1.0, 4.0, -8.0, 9.0, -9.0, 1.0, 9.0, 3.0, -5.0, -7.0, -4.0, 7.0, -7.0, 3.0, -3.0));
	blockD.k[4] = (mat4(-1.0, 9.0, 1.0, -9.0, 4.0, 7.0, -7.0, -1.0, -9.0, 5.0, 3.0, 0.0, -6.0, -5.0, -4.0, 3.0));
	blockD.k[5] = (mat4(1.0, 5.0, 3.0, -6.0, -3.0, 0.0, -8.0, 4.0, 7.0, -5.0, 7.0, 3.0, -7.0, 9.0, -2.0, 8.0));
}
#version 450
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
	uint16_t a[1];
	float16_t b;
	mediump mat4x3 c;
	lowp mat3x4 d;
	highp mat4x2 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(blockB[nonuniformEXT(0)].a[0]), 5u) && allOk;
	allOk = compare_float16_t(float(blockB[nonuniformEXT(0)].b), 8.0) && allOk;
	allOk = compare_mat4x3(blockB[nonuniformEXT(0)].c, mat4x3(8.0, -2.0, -9.0, 2.0, 6.0, 9.0, 4.0, -1.0, -2.0, 0.0, 5.0, -9.0)) && allOk;
	allOk = compare_uint16_t(uint(blockB[nonuniformEXT(1)].a[0]), 5u) && allOk;
	allOk = compare_float16_t(float(blockB[nonuniformEXT(1)].b), 7.0) && allOk;
	allOk = compare_mat4x3(blockB[nonuniformEXT(1)].c, mat4x3(9.0, -9.0, -3.0, -3.0, 2.0, 5.0, 1.0, 7.0, 0.0, 4.0, -1.0, 2.0)) && allOk;
	allOk = compare_uint16_t(uint(blockB[nonuniformEXT(2)].a[0]), 3u) && allOk;
	allOk = compare_float16_t(float(blockB[nonuniformEXT(2)].b), -5.0) && allOk;
	allOk = compare_mat4x3(blockB[nonuniformEXT(2)].c, mat4x3(-8.0, 0.0, 1.0, -6.0, -1.0, 5.0, -8.0, 7.0, -1.0, -6.0, 0.0, 3.0)) && allOk;
	allOk = compare_uint16_t(uint(blockB[nonuniformEXT(3)].a[0]), 7u) && allOk;
	allOk = compare_float16_t(float(blockB[nonuniformEXT(3)].b), -1.0) && allOk;
	allOk = compare_mat4x3(blockB[nonuniformEXT(3)].c, mat4x3(0.0, 8.0, -2.0, -2.0, -1.0, 4.0, -4.0, -9.0, 8.0, -9.0, -4.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = float16_t(-7.0);
	blockB[nonuniformEXT(0)].c = (mat4x3(3.0, 4.0, -3.0, -2.0, 6.0, 3.0, 2.0, -8.0, -3.0, -7.0, 8.0, -1.0));
	blockB[nonuniformEXT(0)].e = (mat4x2(-5.0, -3.0, -2.0, -3.0, -2.0, -8.0, 8.0, 1.0));
	blockB[nonuniformEXT(1)].b = float16_t(-1.0);
	blockB[nonuniformEXT(1)].c = (mat4x3(3.0, -1.0, 8.0, 7.0, -3.0, 9.0, -4.0, 1.0, -8.0, -5.0, -9.0, -8.0));
	blockB[nonuniformEXT(1)].e = (mat4x2(2.0, -6.0, -7.0, 9.0, -6.0, 9.0, -2.0, -9.0));
	blockB[nonuniformEXT(2)].b = float16_t(-3.0);
	blockB[nonuniformEXT(2)].c = (mat4x3(9.0, 9.0, -3.0, -9.0, 0.0, 0.0, -7.0, 4.0, 5.0, 6.0, 5.0, 0.0));
	blockB[nonuniformEXT(2)].e = (mat4x2(5.0, -4.0, 9.0, 3.0, -4.0, 5.0, -6.0, 0.0));
	blockB[nonuniformEXT(3)].b = float16_t(2.0);
	blockB[nonuniformEXT(3)].c = (mat4x3(-8.0, 3.0, -9.0, -4.0, 1.0, -9.0, -3.0, 6.0, 0.0, -7.0, 1.0, -8.0));
	blockB[nonuniformEXT(3)].e = (mat4x2(4.0, -2.0, -3.0, 1.0, 5.0, -3.0, -3.0, 5.0));
}
#version 450
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
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a), -4.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (9.0);
}
#version 450
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
	mediump mat4x2 a;
	mediump mat3x2 b;
	uint8_t c[];
};
layout(std140, buffer_reference) buffer BlockC
{
	mediump uvec3 d;
	bvec3 e;
	mediump float f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB.a, mat4x2(-5.0, 9.0, 5.0, -5.0, -6.0, 7.0, -9.0, 7.0)) && allOk;
	allOk = compare_uint8_t(uint(blockB.c[0]), 8u) && allOk;
	allOk = compare_uint8_t(uint(blockB.c[1]), 4u) && allOk;
	allOk = compare_uint8_t(uint(blockB.c[2]), 5u) && allOk;
	allOk = compare_uint8_t(uint(blockB.c[3]), 0u) && allOk;
	allOk = compare_uint8_t(uint(blockB.c[4]), 8u) && allOk;
	allOk = compare_uint8_t(uint(blockB.c[5]), 1u) && allOk;
	allOk = compare_uint8_t(uint(blockB.c[6]), 4u) && allOk;
	allOk = compare_uvec3((blockC.d), uvec3(8u, 1u, 0u)) && allOk;
	allOk = compare_bvec3((blockC.e), bvec3(false, true, true)) && allOk;
	allOk = compare_float((blockC.f[0]), 8.0) && allOk;
	allOk = compare_float((blockC.f[1]), -8.0) && allOk;
	allOk = compare_float((blockC.f[2]), 4.0) && allOk;
	allOk = compare_float((blockC.f[3]), -8.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x2(3.0, 4.0, -4.0, 9.0, 2.0, -2.0, 2.0, -4.0));
	blockB.b = (mat3x2(-9.0, 9.0, -2.0, 8.0, 0.0, -5.0));
	blockB.c[0] = uint8_t(7u);
	blockB.c[1] = uint8_t(5u);
	blockB.c[2] = uint8_t(4u);
	blockB.c[3] = uint8_t(4u);
	blockB.c[4] = uint8_t(2u);
	blockB.c[5] = uint8_t(5u);
	blockB.c[6] = uint8_t(8u);
	blockC.e = (bvec3(true, true, false));
	blockC.f[0] = (-5.0);
	blockC.f[1] = (-2.0);
	blockC.f[2] = (-4.0);
	blockC.f[3] = (-4.0);
}
#version 450
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
layout(std430, buffer_reference) buffer BlockB
{
	mediump vec4 a;
	sA b;
	bvec3 c;
	bool d;
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	lowp int e;
	bvec3 f[];
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	lowp vec4 g;
	u8vec4 h;
	mediump ivec4 i;
};
layout(std430, column_major, buffer_reference) buffer BlockE
{
	mediump uint j[];
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
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.b.mA), bvec4(true, true, false, false)) && allOk;
	allOk = compare_int((blockC.e), 8) && allOk;
	allOk = compare_bvec3((blockC.f[0]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockC.f[1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((blockC.f[2]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((blockC.f[3]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((blockC.f[4]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((blockC.f[5]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((blockC.f[6]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockC.f[7]), bvec3(true, false, true)) && allOk;
	allOk = compare_vec4((blockD.g), vec4(-9.0, 6.0, -3.0, 9.0)) && allOk;
	allOk = compare_ivec4((blockD.i), ivec4(7, -7, 7, -8)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec4(-7.0, 4.0, -4.0, -7.0));
	blockB.b.mA = (bvec4(false, true, true, true));
	blockB.d = (true);
	blockC.e = (2);
	blockC.f[0] = (bvec3(false, true, false));
	blockC.f[1] = (bvec3(false, false, true));
	blockC.f[2] = (bvec3(false, false, false));
	blockC.f[3] = (bvec3(true, true, false));
	blockC.f[4] = (bvec3(true, false, false));
	blockC.f[5] = (bvec3(true, true, true));
	blockC.f[6] = (bvec3(true, true, false));
	blockC.f[7] = (bvec3(false, false, false));
	blockD.g = (vec4(4.0, 0.0, -3.0, -8.0));
	blockE.j[0] = (6u);
	blockE.j[1] = (0u);
	blockE.j[2] = (2u);
	blockE.j[3] = (3u);
	blockE.j[4] = (7u);
	blockE.j[5] = (5u);
}
#version 450
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
	lowp int b;
	lowp mat4 c;
	lowp mat3x2 d[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	mediump uvec4 e;
	lowp mat3 f;
	mediump vec3 g[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	bvec3 h;
	mediump uint i[1];
	bvec3 j;
	bvec2 k;
	bvec2 l[];
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
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 2u) && allOk;
	allOk = compare_mat4(blockB.c, mat4(-5.0, 4.0, 4.0, 1.0, 7.0, 1.0, -7.0, 9.0, 2.0, -8.0, 3.0, 5.0, -1.0, -1.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[0], mat3x2(1.0, -3.0, -4.0, 1.0, -4.0, 5.0)) && allOk;
	allOk = compare_uvec4((blockC[0].e), uvec4(5u, 8u, 9u, 5u)) && allOk;
	allOk = compare_uvec4((blockC[1].e), uvec4(8u, 2u, 2u, 5u)) && allOk;
	allOk = compare_uvec4((blockC[2].e), uvec4(6u, 8u, 4u, 3u)) && allOk;
	allOk = compare_bvec3((blockD.h), bvec3(true, true, true)) && allOk;
	allOk = compare_uint((blockD.i[0]), 2u) && allOk;
	allOk = compare_bvec3((blockD.j), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec2((blockD.k), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockD.l[0]), bvec2(false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (6u);
	blockB.b = (7);
	blockC[0].e = (uvec4(5u, 7u, 7u, 7u));
	blockC[0].g[0] = (vec3(-6.0, -5.0, -6.0));
	blockC[1].e = (uvec4(8u, 0u, 8u, 4u));
	blockC[1].g[0] = (vec3(-5.0, -3.0, 3.0));
	blockC[2].e = (uvec4(7u, 9u, 1u, 1u));
	blockC[2].g[0] = (vec3(-8.0, 0.0, -8.0));
	blockD.i[0] = (9u);
}
#version 450
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
	highp mat3x4 a[2];
	lowp mat4x2 b[][3];
};
layout(scalar, buffer_reference) buffer BlockC
{
	i8vec3 c[];
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	highp int d;
	mediump ivec3 e;
	mediump mat3 f;
	mediump mat4 g[];
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockD.d), -7) && allOk;
	allOk = compare_ivec3((blockD.e), ivec3(7, 4, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat3x4(-1.0, 9.0, 1.0, 3.0, 5.0, -9.0, 8.0, 2.0, -7.0, 3.0, 6.0, 3.0));
	blockB.a[1] = (mat3x4(-6.0, -3.0, 8.0, 4.0, 9.0, 1.0, 0.0, -1.0, 4.0, -4.0, -2.0, -2.0));
	blockB.b[0][0] = (mat4x2(6.0, -3.0, 8.0, 7.0, -8.0, 2.0, -5.0, 3.0));
	blockB.b[0][1] = (mat4x2(-3.0, 5.0, -3.0, 8.0, -5.0, -1.0, 0.0, 2.0));
	blockB.b[0][2] = (mat4x2(7.0, -3.0, 2.0, 9.0, -6.0, -1.0, 7.0, 9.0));
	blockB.b[1][0] = (mat4x2(-2.0, 4.0, 1.0, -6.0, 5.0, -9.0, -1.0, 8.0));
	blockB.b[1][1] = (mat4x2(6.0, -1.0, 8.0, 9.0, 8.0, -4.0, 9.0, -7.0));
	blockB.b[1][2] = (mat4x2(-6.0, 9.0, -3.0, -6.0, 9.0, 3.0, -1.0, -1.0));
	blockB.b[2][0] = (mat4x2(9.0, -3.0, 4.0, -5.0, -1.0, 7.0, 5.0, 2.0));
	blockB.b[2][1] = (mat4x2(5.0, -7.0, -6.0, -6.0, -9.0, 7.0, 4.0, 2.0));
	blockB.b[2][2] = (mat4x2(-9.0, -8.0, 1.0, -3.0, 2.0, 2.0, 0.0, -7.0));
	blockC.c[0] = i8vec3(ivec3(4294967287, 4294967294, 4294967288));
	blockC.c[1] = i8vec3(ivec3(8, 4, 4294967293));
	blockC.c[2] = i8vec3(ivec3(4294967291, 4294967295, 8));
	blockC.c[3] = i8vec3(ivec3(8, 7, 6));
	blockD.d = (-1);
	blockD.g[0] = (mat4(-5.0, 0.0, -3.0, 5.0, 7.0, -7.0, -5.0, -2.0, 4.0, -3.0, 7.0, -4.0, 0.0, -5.0, 7.0, 0.0));
	blockD.g[1] = (mat4(9.0, -4.0, -3.0, -9.0, -5.0, -1.0, -3.0, 3.0, 2.0, -9.0, -3.0, 2.0, -4.0, -5.0, -4.0, 1.0));
	blockD.g[2] = (mat4(8.0, 3.0, -7.0, 3.0, -3.0, -6.0, 4.0, 5.0, 9.0, 5.0, -1.0, -4.0, -4.0, 0.0, -4.0, -7.0));
}
#version 450
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
	lowp mat2 mA[2];
};
layout(scalar, row_major, buffer_reference) readonly buffer BlockB
{
	sA a[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

}
