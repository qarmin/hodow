#version 450
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

layout(std140, column_major, binding = 1) buffer Block
{
	mediump mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var, mat4x3(-7.0, -2.0, 9.0, 1.0, 7.0, 8.0, 6.0, -6.0, -1.0, 4.0, -6.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x3(1.0, 4.0, 5.0, -8.0, -8.0, 2.0, 7.0, 9.0, 8.0, 4.0, -9.0, 9.0));
}
#version 450
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
	u8vec4 var;
};

bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(var), uvec4(3u, 4u, 6u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = u8vec4(uvec4(9u, 5u, 9u, 4u));
}
#version 450
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
	i8vec2 var;
};

bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(var), ivec2(4294967288, 4294967293)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = i8vec2(ivec2(0, 8));
}
#version 450
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
	lowp ivec2 var;
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((var), ivec2(-1, -7)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (ivec2(5, -9));
}
#version 450
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
	mediump uvec2 var;
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((var), uvec2(3u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (uvec2(5u, 3u));
}
#version 450
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
	highp mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var, mat2(-9.0, 9.0, 2.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2(-9.0, 9.0, -6.0, -6.0));
}
#version 450
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
	allOk = compare_float(var[0][0], -7.0) && allOk;
	allOk = compare_float(var[0][1], -4.0) && allOk;
	allOk = compare_float(var[0][2], 1.0) && allOk;
	allOk = compare_float(var[0][3], -5.0) && allOk;
	allOk = compare_float(var[1][0], 2.0) && allOk;
	allOk = compare_float(var[1][1], 8.0) && allOk;
	allOk = compare_float(var[1][2], 3.0) && allOk;
	allOk = compare_float(var[1][3], -8.0) && allOk;
	allOk = compare_float(var[2][0], 2.0) && allOk;
	allOk = compare_float(var[2][1], 8.0) && allOk;
	allOk = compare_float(var[2][2], 3.0) && allOk;
	allOk = compare_float(var[2][3], -6.0) && allOk;
	allOk = compare_float(var[3][0], -5.0) && allOk;
	allOk = compare_float(var[3][1], -5.0) && allOk;
	allOk = compare_float(var[3][2], -8.0) && allOk;
	allOk = compare_float(var[3][3], -8.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-7.0, -4.0, 1.0, -5.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(2.0, 8.0, 3.0, -8.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(2.0, 8.0, 3.0, -6.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(-5.0, -5.0, -8.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4(-5.0, 1.0, -7.0, 4.0, 0.0, 8.0, 8.0, 0.0, 6.0, 7.0, 7.0, -5.0, 7.0, -7.0, 8.0, -5.0));
}
#version 450
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
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], 3.0) && allOk;
	allOk = compare_float(var[1][0], 9.0) && allOk;
	allOk = compare_float(var[1][1], -5.0) && allOk;
	allOk = compare_float(var[2][0], -6.0) && allOk;
	allOk = compare_float(var[2][1], 3.0) && allOk;
	allOk = compare_vec2(var[0], vec2(1.0, 3.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(9.0, -5.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-6.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec2(-6.0, -9.0));
	var[1] = (vec2(-3.0, 1.0));
	var[2] = (vec2(7.0, -8.0));
}
#version 450
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
	allOk = compare_mat4x3(var, mat4x3(-3.0, 3.0, 8.0, -5.0, 5.0, 3.0, -1.0, -9.0, -4.0, 8.0, -4.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x3(-7.0, -4.0, 6.0, 7.0, -4.0, 4.0, 2.0, -9.0, -3.0, 8.0, -4.0, -5.0));
}
#version 450
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

	padding = (5);
	var = (ivec2(-1, -2));
}
#version 450
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
	mediump uint var;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((var), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (0u);
}
#version 450
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
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_float(var[0][0], -4.0) && allOk;
	allOk = compare_float(var[0][1], -3.0) && allOk;
	allOk = compare_float(var[0][2], 8.0) && allOk;
	allOk = compare_float(var[1][0], -3.0) && allOk;
	allOk = compare_float(var[1][1], 9.0) && allOk;
	allOk = compare_float(var[1][2], 7.0) && allOk;
	allOk = compare_float(var[2][0], -4.0) && allOk;
	allOk = compare_float(var[2][1], 4.0) && allOk;
	allOk = compare_float(var[2][2], 7.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-4.0, -3.0, 8.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-3.0, 9.0, 7.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-4.0, 4.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-8.0);
	var = (mat3(5.0, 0.0, -3.0, 9.0, 2.0, -3.0, 5.0, -9.0, 1.0));
}
#version 450
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
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_float(var[0][0], 3.0) && allOk;
	allOk = compare_float(var[0][1], 9.0) && allOk;
	allOk = compare_float(var[1][0], -5.0) && allOk;
	allOk = compare_float(var[1][1], -6.0) && allOk;
	allOk = compare_float(var[2][0], 3.0) && allOk;
	allOk = compare_float(var[2][1], -9.0) && allOk;
	allOk = compare_vec2(var[0], vec2(3.0, 9.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-6.0);
	var[0] = (vec2(-9.0, -3.0));
	var[1] = (vec2(1.0, 7.0));
	var[2] = (vec2(-8.0, -9.0));
}
#version 450
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
	u8vec2 var;
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(padding), 3u) && allOk;
	allOk = compare_u8vec2(uvec2(var), uvec2(0u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = uint8_t(7u);
	var = u8vec2(uvec2(7u, 9u));
}
#version 450
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
	int16_t var;
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(var), -5) && allOk;
    if (allOk)
        ac_numPassed++;

	var = int16_t(6);
}
#version 450
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
	f16vec4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(padding), -8.0) && allOk;
	allOk = compare_f16vec4(vec4(var), vec4(-9.0, 9.0, -6.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = float16_t(9.0);
	var = f16vec4(vec4(-6.0, 2.0, -8.0, -7.0));
}
#version 450
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
	highp mat4x3 var[3];
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
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4x3(6.0, -7.0, 0.0, 3.0, -1.0, -9.0, -7.0, -5.0, 8.0, 0.0, 1.0, 5.0));
	var[1] = (mat4x3(7.0, 1.0, 5.0, 7.0, -8.0, 4.0, 2.0, -8.0, -8.0, 3.0, -6.0, -5.0));
	var[2] = (mat4x3(5.0, -7.0, 8.0, -7.0, -3.0, -4.0, -9.0, -9.0, -6.0, 5.0, -8.0, 1.0));
}
#version 450
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
	allOk = compare_mat2(var[0], mat2(-2.0, 3.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(8.0, 2.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(3.0, 2.0, 4.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec2(5.0, -4.0));
	var[0][1] = (vec2(5.0, 1.0));
	var[1][0] = (vec2(-8.0, -1.0));
	var[1][1] = (vec2(9.0, -8.0));
	var[2][0] = (vec2(5.0, -4.0));
	var[2][1] = (vec2(5.0, -2.0));
}
#version 450
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
	allOk = compare_mat3(var[0], mat3(-7.0, -8.0, -9.0, -8.0, 8.0, 6.0, 6.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(9.0, 5.0, -2.0, 9.0, -8.0, 6.0, -3.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(-1.0, -5.0, -7.0, -6.0, 8.0, 8.0, -2.0, -7.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3(-6.0, 9.0, 1.0, 4.0, -8.0, 5.0, 7.0, 2.0, 2.0));
	var[1] = (mat3(8.0, -8.0, -2.0, 2.0, 8.0, 4.0, 2.0, 1.0, 7.0));
	var[2] = (mat3(-2.0, 5.0, 7.0, 4.0, 7.0, -3.0, 9.0, 1.0, 9.0));
}
#version 450
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
	allOk = compare_mat4(var[0], mat4(3.0, 8.0, 5.0, -7.0, -4.0, 0.0, -1.0, -9.0, 2.0, 9.0, 5.0, 5.0, 6.0, 9.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(8.0, 1.0, -3.0, 1.0, 0.0, -7.0, -4.0, 0.0, 1.0, -6.0, -7.0, 5.0, 2.0, 0.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(-5.0, 8.0, 2.0, 3.0, 8.0, -6.0, 7.0, 9.0, -3.0, 7.0, -8.0, -5.0, 6.0, 4.0, -9.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec4(-7.0, -2.0, 7.0, -7.0));
	var[0][1] = (vec4(2.0, -4.0, 3.0, -5.0));
	var[0][2] = (vec4(2.0, 3.0, 8.0, 8.0));
	var[0][3] = (vec4(3.0, 0.0, -4.0, -1.0));
	var[1][0] = (vec4(-3.0, 0.0, 8.0, 1.0));
	var[1][1] = (vec4(-8.0, 9.0, 2.0, 7.0));
	var[1][2] = (vec4(-2.0, -7.0, -9.0, 1.0));
	var[1][3] = (vec4(6.0, -9.0, -1.0, -5.0));
	var[2][0] = (vec4(-6.0, -3.0, 7.0, -1.0));
	var[2][1] = (vec4(0.0, -1.0, -2.0, 1.0));
	var[2][2] = (vec4(-3.0, -1.0, -4.0, 7.0));
	var[2][3] = (vec4(-3.0, 1.0, 1.0, -9.0));
}
#version 450
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
	f16vec3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(var[0]), vec3(4.0, 1.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1]), vec3(-8.0, 7.0, -5.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2]), vec3(4.0, 2.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = f16vec3(vec3(3.0, 3.0, 7.0));
	var[1] = f16vec3(vec3(-3.0, -5.0, -9.0));
	var[2] = f16vec3(vec3(-1.0, 0.0, 6.0));
}
#version 450
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

	padding = (6u);
	var[0] = (uvec2(1u, 8u));
	var[1] = (uvec2(1u, 7u));
	var[2] = (uvec2(4u, 6u));
}
#version 450
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
	allOk = compare_float((padding), -4.0) && allOk;
	allOk = compare_mat4x3(var[0], mat4x3(6.0, 7.0, -6.0, 2.0, -5.0, 0.0, -2.0, 8.0, -7.0, 6.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(-5.0, -7.0, 0.0, -7.0, -8.0, -3.0, 1.0, 3.0, 7.0, 7.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(5.0, 2.0, -9.0, 9.0, 2.0, 8.0, -7.0, -4.0, 8.0, 6.0, -6.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-3.0);
	var[0][0] = (vec3(-6.0, 6.0, 1.0));
	var[0][1] = (vec3(-4.0, -3.0, -3.0));
	var[0][2] = (vec3(3.0, -2.0, -7.0));
	var[0][3] = (vec3(1.0, -5.0, -1.0));
	var[1][0] = (vec3(-5.0, 7.0, 1.0));
	var[1][1] = (vec3(-2.0, -4.0, -4.0));
	var[1][2] = (vec3(-6.0, 5.0, -2.0));
	var[1][3] = (vec3(6.0, -9.0, 5.0));
	var[2][0] = (vec3(-5.0, 7.0, -4.0));
	var[2][1] = (vec3(8.0, -3.0, -2.0));
	var[2][2] = (vec3(0.0, 8.0, -2.0));
	var[2][3] = (vec3(6.0, -3.0, -9.0));
}
#version 450
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

	var[0] = (mat3(5.0, 2.0, 8.0, 8.0, 3.0, -2.0, 2.0, -8.0, -5.0));
	var[1] = (mat3(-6.0, -1.0, 7.0, -5.0, -5.0, 8.0, -2.0, -5.0, 5.0));
	var[2] = (mat3(3.0, 9.0, -7.0, -2.0, 3.0, 5.0, 5.0, 1.0, -6.0));
	var[3] = (mat3(-5.0, 4.0, 9.0, -2.0, -6.0, 2.0, -1.0, 0.0, 2.0));
	var[4] = (mat3(9.0, -5.0, 7.0, 6.0, 8.0, 4.0, 5.0, -2.0, -5.0));
	var[5] = (mat3(7.0, -1.0, 1.0, -3.0, -8.0, 1.0, -4.0, 7.0, 1.0));
	var[6] = (mat3(5.0, 8.0, -1.0, 8.0, 9.0, 6.0, -1.0, 5.0, -2.0));
	var[7] = (mat3(1.0, 4.0, -8.0, 8.0, 1.0, 2.0, 4.0, -7.0, 3.0));
	var[8] = (mat3(-1.0, -5.0, 2.0, 2.0, -1.0, -7.0, 7.0, -8.0, -6.0));
	var[9] = (mat3(5.0, -9.0, 2.0, 2.0, -9.0, -9.0, -2.0, 1.0, 8.0));
	var[10] = (mat3(-4.0, 8.0, -5.0, 5.0, -2.0, 2.0, 3.0, 3.0, -8.0));
	var[11] = (mat3(0.0, 2.0, 6.0, 2.0, -5.0, -9.0, 4.0, 6.0, -3.0));
	var[12] = (mat3(-9.0, 2.0, -8.0, 1.0, -5.0, 5.0, 8.0, -6.0, 7.0));
	var[13] = (mat3(-1.0, 7.0, -7.0, 7.0, 5.0, -9.0, 5.0, 3.0, -1.0));
	var[14] = (mat3(6.0, -3.0, 9.0, 7.0, 0.0, 2.0, 8.0, -5.0, -9.0));
	var[15] = (mat3(-3.0, 0.0, 7.0, -7.0, 1.0, -6.0, -4.0, 1.0, -9.0));
	var[16] = (mat3(6.0, 9.0, 8.0, 5.0, 8.0, 1.0, 6.0, 4.0, -4.0));
	var[17] = (mat3(9.0, -4.0, 1.0, -5.0, 8.0, -3.0, 4.0, -9.0, -8.0));
	var[18] = (mat3(-7.0, 7.0, -5.0, 5.0, 0.0, 7.0, -8.0, -5.0, 8.0));
}
#version 450
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
	highp mat2x4 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0], mat2x4(5.0, -9.0, 4.0, 8.0, -1.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(-7.0, 1.0, 3.0, -8.0, 0.0, -7.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(8.0, 3.0, 1.0, -5.0, 2.0, 6.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[3], mat2x4(-7.0, 0.0, -7.0, -6.0, -8.0, -6.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[4], mat2x4(-9.0, 7.0, 5.0, 2.0, -3.0, -8.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[5], mat2x4(-5.0, 4.0, 5.0, -3.0, -7.0, -9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[6], mat2x4(-2.0, -5.0, 5.0, -9.0, -6.0, 9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[7], mat2x4(-3.0, 4.0, -4.0, -3.0, 7.0, 7.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[8], mat2x4(-5.0, -3.0, -3.0, -4.0, -9.0, 2.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[9], mat2x4(-4.0, 0.0, -1.0, 2.0, 8.0, 9.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[10], mat2x4(5.0, 1.0, 5.0, 8.0, -4.0, -5.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[11], mat2x4(1.0, 9.0, -1.0, 1.0, -2.0, -4.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[12], mat2x4(-7.0, -3.0, 7.0, -3.0, 8.0, 3.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[13], mat2x4(8.0, 0.0, -1.0, 2.0, 2.0, -8.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[14], mat2x4(-5.0, 6.0, 6.0, 8.0, -9.0, 0.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[15], mat2x4(-5.0, 5.0, -1.0, 2.0, -3.0, -1.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[16], mat2x4(-5.0, 8.0, 6.0, 1.0, 3.0, 9.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[17], mat2x4(-8.0, -3.0, 1.0, -2.0, 5.0, 3.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[18], mat2x4(5.0, -7.0, 7.0, 2.0, 1.0, -3.0, -3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec4(-7.0, -1.0, 8.0, 2.0));
	var[0][1] = (vec4(-1.0, 2.0, 7.0, -9.0));
	var[1][0] = (vec4(-9.0, -5.0, 4.0, 7.0));
	var[1][1] = (vec4(5.0, 8.0, -8.0, -8.0));
	var[2][0] = (vec4(6.0, -3.0, 7.0, 0.0));
	var[2][1] = (vec4(4.0, 6.0, -4.0, 0.0));
	var[3][0] = (vec4(-5.0, 8.0, -9.0, -8.0));
	var[3][1] = (vec4(7.0, -7.0, -8.0, -6.0));
	var[4][0] = (vec4(-9.0, -8.0, 1.0, -2.0));
	var[4][1] = (vec4(7.0, -6.0, -9.0, 9.0));
	var[5][0] = (vec4(4.0, -6.0, 0.0, -3.0));
	var[5][1] = (vec4(-7.0, -7.0, 2.0, -1.0));
	var[6][0] = (vec4(6.0, -1.0, -5.0, 1.0));
	var[6][1] = (vec4(-1.0, 8.0, 7.0, 6.0));
	var[7][0] = (vec4(-9.0, 8.0, 2.0, 1.0));
	var[7][1] = (vec4(9.0, -7.0, 6.0, -8.0));
	var[8][0] = (vec4(-2.0, -8.0, 6.0, 9.0));
	var[8][1] = (vec4(5.0, 5.0, -1.0, -1.0));
	var[9][0] = (vec4(4.0, -3.0, 7.0, -9.0));
	var[9][1] = (vec4(-3.0, 9.0, 2.0, 6.0));
	var[10][0] = (vec4(6.0, 1.0, 5.0, -4.0));
	var[10][1] = (vec4(1.0, -6.0, 2.0, 6.0));
	var[11][0] = (vec4(-8.0, 7.0, 7.0, -5.0));
	var[11][1] = (vec4(-8.0, 0.0, -6.0, -4.0));
	var[12][0] = (vec4(5.0, 0.0, 0.0, -1.0));
	var[12][1] = (vec4(9.0, 1.0, -4.0, 7.0));
	var[13][0] = (vec4(8.0, 0.0, -5.0, -4.0));
	var[13][1] = (vec4(2.0, 1.0, -9.0, 5.0));
	var[14][0] = (vec4(-5.0, 0.0, 5.0, 7.0));
	var[14][1] = (vec4(8.0, -8.0, 8.0, 1.0));
	var[15][0] = (vec4(6.0, -3.0, -3.0, -4.0));
	var[15][1] = (vec4(-9.0, 1.0, 6.0, -4.0));
	var[16][0] = (vec4(-8.0, -4.0, -9.0, -8.0));
	var[16][1] = (vec4(-1.0, -1.0, 1.0, -7.0));
	var[17][0] = (vec4(7.0, -4.0, -6.0, -8.0));
	var[17][1] = (vec4(-8.0, -1.0, -2.0, 1.0));
	var[18][0] = (vec4(-8.0, 3.0, -6.0, 6.0));
	var[18][1] = (vec4(2.0, 1.0, 3.0, -6.0));
}
#version 450
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

layout(std140, binding = 1) buffer Block
{
	highp int var[4][3];
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((var[0][0]), 6) && allOk;
	allOk = compare_int((var[0][1]), 0) && allOk;
	allOk = compare_int((var[0][2]), 9) && allOk;
	allOk = compare_int((var[1][0]), -6) && allOk;
	allOk = compare_int((var[1][1]), -9) && allOk;
	allOk = compare_int((var[1][2]), -8) && allOk;
	allOk = compare_int((var[2][0]), 8) && allOk;
	allOk = compare_int((var[2][1]), -9) && allOk;
	allOk = compare_int((var[2][2]), -1) && allOk;
	allOk = compare_int((var[3][0]), 0) && allOk;
	allOk = compare_int((var[3][1]), -9) && allOk;
	allOk = compare_int((var[3][2]), 5) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (8);
	var[0][1] = (2);
	var[0][2] = (-5);
	var[1][0] = (0);
	var[1][1] = (-7);
	var[1][2] = (-7);
	var[2][0] = (-8);
	var[2][1] = (6);
	var[2][2] = (-6);
	var[3][0] = (6);
	var[3][1] = (-5);
	var[3][2] = (5);
}
#version 450
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
	highp mat4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0][0], mat4(5.0, 8.0, -8.0, -2.0, 6.0, -4.0, 3.0, -1.0, 6.0, 4.0, -8.0, -3.0, 9.0, 9.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4(var[0][1], mat4(-6.0, -5.0, 1.0, 2.0, 1.0, 8.0, 6.0, 2.0, -2.0, -9.0, -8.0, -8.0, -3.0, -9.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[0][2], mat4(-1.0, -6.0, 8.0, -9.0, -2.0, 9.0, 7.0, 3.0, 4.0, -1.0, -8.0, -8.0, 9.0, -4.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4(var[1][0], mat4(-9.0, -1.0, -9.0, 8.0, 9.0, -9.0, -7.0, -2.0, 3.0, -9.0, -3.0, -9.0, 4.0, -4.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat4(var[1][1], mat4(-2.0, 7.0, -4.0, -4.0, 1.0, 2.0, -1.0, -3.0, 8.0, 1.0, -3.0, -1.0, -4.0, -6.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat4(var[1][2], mat4(-9.0, 9.0, 8.0, 7.0, 8.0, -2.0, -2.0, -5.0, -9.0, -8.0, -9.0, -4.0, -9.0, 6.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4(var[2][0], mat4(1.0, 8.0, -3.0, -5.0, -4.0, -9.0, -2.0, -6.0, -3.0, -9.0, -9.0, -7.0, 7.0, -9.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4(var[2][1], mat4(4.0, -6.0, -4.0, 8.0, 0.0, -1.0, 3.0, -5.0, 6.0, -8.0, 9.0, 7.0, 3.0, 0.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4(var[2][2], mat4(9.0, -9.0, 9.0, 2.0, -2.0, -2.0, 3.0, -9.0, 4.0, -1.0, -1.0, -7.0, -4.0, 0.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4(var[3][0], mat4(6.0, 1.0, 6.0, 5.0, 7.0, -7.0, -8.0, 7.0, -2.0, -3.0, 4.0, 3.0, 2.0, -8.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4(var[3][1], mat4(-3.0, 2.0, -4.0, 7.0, -4.0, 1.0, -9.0, 8.0, 4.0, -8.0, 5.0, 3.0, 7.0, 5.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4(var[3][2], mat4(-1.0, -3.0, -3.0, -4.0, -9.0, 8.0, 9.0, 0.0, 4.0, 6.0, -9.0, -8.0, 5.0, 3.0, -1.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat4(6.0, -8.0, 2.0, -8.0, 1.0, -5.0, -7.0, -8.0, -9.0, 3.0, -9.0, -1.0, 7.0, -6.0, -5.0, 2.0));
	var[0][1] = (mat4(4.0, 3.0, -5.0, 6.0, 5.0, -1.0, -1.0, 7.0, -1.0, 5.0, -8.0, -3.0, 2.0, -6.0, -9.0, -5.0));
	var[0][2] = (mat4(1.0, -5.0, -9.0, 9.0, -7.0, -1.0, 6.0, -6.0, 6.0, -9.0, -8.0, -3.0, -3.0, 4.0, -5.0, -1.0));
	var[1][0] = (mat4(-3.0, -9.0, -6.0, 5.0, 0.0, 6.0, -5.0, -7.0, -6.0, -5.0, 8.0, -6.0, -2.0, -8.0, -4.0, -8.0));
	var[1][1] = (mat4(1.0, 5.0, 6.0, -2.0, -7.0, -3.0, -4.0, 6.0, -8.0, -5.0, 2.0, 8.0, 4.0, 3.0, 6.0, -6.0));
	var[1][2] = (mat4(-7.0, 5.0, 7.0, -7.0, -6.0, 6.0, -2.0, 5.0, 1.0, -3.0, -2.0, 4.0, 6.0, -6.0, -5.0, -5.0));
	var[2][0] = (mat4(6.0, -8.0, -5.0, -4.0, 5.0, -3.0, 4.0, 6.0, 2.0, -2.0, -7.0, 5.0, -9.0, -3.0, 9.0, 5.0));
	var[2][1] = (mat4(6.0, 9.0, 2.0, 1.0, -6.0, -8.0, 8.0, -2.0, 1.0, 6.0, -5.0, 5.0, -7.0, -8.0, 9.0, 3.0));
	var[2][2] = (mat4(6.0, -6.0, -4.0, 0.0, 8.0, -9.0, -6.0, 2.0, 6.0, 7.0, 5.0, 9.0, -6.0, -9.0, -5.0, 5.0));
	var[3][0] = (mat4(-5.0, 3.0, 0.0, -2.0, -1.0, -6.0, -7.0, 9.0, -9.0, 8.0, 2.0, -7.0, -7.0, 9.0, 8.0, 7.0));
	var[3][1] = (mat4(-9.0, 5.0, -4.0, -4.0, 9.0, -1.0, 3.0, -1.0, 7.0, 2.0, 8.0, -2.0, 2.0, -3.0, 0.0, -9.0));
	var[3][2] = (mat4(5.0, -1.0, 6.0, 9.0, 1.0, -7.0, -5.0, -3.0, 4.0, 8.0, -9.0, -2.0, -2.0, -1.0, -1.0, 0.0));
}
#version 450
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
	highp mat4x3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0][0], mat4x3(-7.0, 1.0, 0.0, 0.0, -7.0, 2.0, 5.0, 0.0, 3.0, 2.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[0][1], mat4x3(-7.0, -5.0, 2.0, 0.0, -1.0, -5.0, 5.0, 5.0, 9.0, -7.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[0][2], mat4x3(3.0, 6.0, -7.0, 7.0, 8.0, 6.0, -7.0, -8.0, -5.0, -9.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[1][0], mat4x3(-7.0, -7.0, 7.0, 2.0, -5.0, 3.0, 2.0, 0.0, 8.0, -1.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[1][1], mat4x3(-8.0, 6.0, 2.0, -5.0, -7.0, -7.0, -4.0, -9.0, 7.0, 3.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[1][2], mat4x3(-7.0, 7.0, 6.0, 3.0, 4.0, 5.0, -2.0, 3.0, 8.0, -7.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[2][0], mat4x3(0.0, 7.0, 1.0, -2.0, 9.0, -5.0, -3.0, 1.0, -6.0, 6.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[2][1], mat4x3(9.0, 8.0, 5.0, 4.0, 7.0, -1.0, 6.0, -6.0, 2.0, 8.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[2][2], mat4x3(0.0, 6.0, -8.0, -4.0, -8.0, 8.0, -5.0, 7.0, 3.0, 9.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[3][0], mat4x3(6.0, -3.0, 0.0, -3.0, 2.0, -8.0, 6.0, 5.0, -2.0, 2.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[3][1], mat4x3(-7.0, 4.0, 5.0, -8.0, -1.0, -2.0, -8.0, -4.0, 2.0, 8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[3][2], mat4x3(4.0, -1.0, 3.0, 3.0, -3.0, 4.0, -6.0, -5.0, 1.0, 4.0, -4.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat4x3(7.0, 8.0, 8.0, -3.0, -9.0, 2.0, -6.0, 0.0, -4.0, -3.0, 4.0, -8.0));
	var[0][1] = (mat4x3(4.0, -2.0, 2.0, 8.0, 4.0, -1.0, -8.0, -6.0, -4.0, 9.0, -2.0, 1.0));
	var[0][2] = (mat4x3(-7.0, -4.0, -4.0, -1.0, 7.0, -6.0, 4.0, 6.0, 7.0, -9.0, -8.0, 3.0));
	var[1][0] = (mat4x3(-6.0, -5.0, 6.0, -2.0, -7.0, 5.0, 4.0, -6.0, -4.0, -7.0, 2.0, -7.0));
	var[1][1] = (mat4x3(-6.0, 5.0, -6.0, 9.0, -8.0, -5.0, -2.0, -8.0, -9.0, -8.0, -1.0, 2.0));
	var[1][2] = (mat4x3(-7.0, -2.0, 1.0, 0.0, 8.0, -7.0, 0.0, 0.0, 7.0, 0.0, -4.0, -7.0));
	var[2][0] = (mat4x3(-9.0, -7.0, 2.0, 2.0, 6.0, 9.0, 9.0, 5.0, -3.0, -4.0, -1.0, -5.0));
	var[2][1] = (mat4x3(-8.0, -4.0, -2.0, 7.0, 3.0, -9.0, 8.0, 1.0, -1.0, -7.0, -6.0, 2.0));
	var[2][2] = (mat4x3(-3.0, -7.0, 7.0, -5.0, 5.0, -8.0, 4.0, 8.0, -9.0, 6.0, -3.0, 2.0));
	var[3][0] = (mat4x3(3.0, -8.0, 6.0, -2.0, 8.0, -2.0, -2.0, -5.0, -1.0, -7.0, -9.0, 3.0));
	var[3][1] = (mat4x3(-6.0, -9.0, -4.0, -6.0, -1.0, -8.0, 9.0, 6.0, -8.0, -6.0, -5.0, 1.0));
	var[3][2] = (mat4x3(-1.0, -9.0, 4.0, 0.0, 9.0, 3.0, 5.0, 7.0, -4.0, -7.0, 3.0, 9.0));
}
#version 450
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

layout(scalar, row_major, binding = 1) buffer Block
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
	allOk = compare_float((padding), 8.0) && allOk;
	allOk = compare_mat2(var[0][0], mat2(-9.0, -4.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat2(var[0][1], mat2(-8.0, -5.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat2(var[0][2], mat2(6.0, 2.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat2(var[1][0], mat2(-3.0, -9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2(var[1][1], mat2(5.0, -3.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1][2], mat2(7.0, 6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat2(var[2][0], mat2(-9.0, 5.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat2(var[2][1], mat2(-8.0, 5.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat2(var[2][2], mat2(7.0, -4.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2(var[3][0], mat2(-8.0, -2.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat2(var[3][1], mat2(4.0, -9.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat2(var[3][2], mat2(-7.0, 2.0, 2.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-3.0);
	var[0][0][0] = (vec2(4.0, 4.0));
	var[0][0][1] = (vec2(3.0, 9.0));
	var[0][1][0] = (vec2(-5.0, 8.0));
	var[0][1][1] = (vec2(-9.0, 0.0));
	var[0][2][0] = (vec2(2.0, -4.0));
	var[0][2][1] = (vec2(4.0, -3.0));
	var[1][0][0] = (vec2(-8.0, -7.0));
	var[1][0][1] = (vec2(3.0, -7.0));
	var[1][1][0] = (vec2(-2.0, 1.0));
	var[1][1][1] = (vec2(-6.0, -4.0));
	var[1][2][0] = (vec2(0.0, 7.0));
	var[1][2][1] = (vec2(3.0, -7.0));
	var[2][0][0] = (vec2(6.0, -6.0));
	var[2][0][1] = (vec2(-5.0, -4.0));
	var[2][1][0] = (vec2(2.0, 3.0));
	var[2][1][1] = (vec2(0.0, -2.0));
	var[2][2][0] = (vec2(-1.0, 1.0));
	var[2][2][1] = (vec2(-4.0, 8.0));
	var[3][0][0] = (vec2(8.0, -6.0));
	var[3][0][1] = (vec2(-9.0, 7.0));
	var[3][1][0] = (vec2(1.0, -2.0));
	var[3][1][1] = (vec2(-2.0, -7.0));
	var[3][2][0] = (vec2(8.0, -4.0));
	var[3][2][1] = (vec2(-6.0, -3.0));
}
#version 450
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
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat2(var[0][0], mat2(3.0, 2.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(var[0][1], mat2(2.0, 1.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat2(var[0][2], mat2(2.0, 4.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2(var[1][0], mat2(8.0, -1.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2(var[1][1], mat2(8.0, 1.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat2(var[1][2], mat2(2.0, -8.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat2(var[2][0], mat2(-3.0, 4.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2(var[2][1], mat2(8.0, 7.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2(var[2][2], mat2(5.0, 2.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat2(var[3][0], mat2(-1.0, -6.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2(var[3][1], mat2(9.0, -7.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2(var[3][2], mat2(1.0, 5.0, -8.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (5.0);
	var[0][0][0] = (vec2(-4.0, 5.0));
	var[0][0][1] = (vec2(1.0, -8.0));
	var[0][1][0] = (vec2(-1.0, 9.0));
	var[0][1][1] = (vec2(-8.0, 5.0));
	var[0][2][0] = (vec2(-4.0, 5.0));
	var[0][2][1] = (vec2(-2.0, 9.0));
	var[1][0][0] = (vec2(-9.0, -1.0));
	var[1][0][1] = (vec2(6.0, -4.0));
	var[1][1][0] = (vec2(7.0, -8.0));
	var[1][1][1] = (vec2(1.0, 4.0));
	var[1][2][0] = (vec2(-4.0, 6.0));
	var[1][2][1] = (vec2(-5.0, 4.0));
	var[2][0][0] = (vec2(-3.0, 6.0));
	var[2][0][1] = (vec2(7.0, -7.0));
	var[2][1][0] = (vec2(-9.0, 5.0));
	var[2][1][1] = (vec2(0.0, 9.0));
	var[2][2][0] = (vec2(2.0, 1.0));
	var[2][2][1] = (vec2(-6.0, 8.0));
	var[3][0][0] = (vec2(-8.0, 5.0));
	var[3][0][1] = (vec2(-5.0, -5.0));
	var[3][1][0] = (vec2(4.0, 5.0));
	var[3][1][1] = (vec2(0.0, 6.0));
	var[3][2][0] = (vec2(9.0, 5.0));
	var[3][2][1] = (vec2(-8.0, 7.0));
}
#version 450
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
	float16_t var[4][3];
};

bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(padding), -7.0) && allOk;
	allOk = compare_float16_t(float(var[0][0]), 4.0) && allOk;
	allOk = compare_float16_t(float(var[0][1]), 2.0) && allOk;
	allOk = compare_float16_t(float(var[0][2]), 0.0) && allOk;
	allOk = compare_float16_t(float(var[1][0]), 5.0) && allOk;
	allOk = compare_float16_t(float(var[1][1]), 9.0) && allOk;
	allOk = compare_float16_t(float(var[1][2]), 5.0) && allOk;
	allOk = compare_float16_t(float(var[2][0]), 4.0) && allOk;
	allOk = compare_float16_t(float(var[2][1]), 7.0) && allOk;
	allOk = compare_float16_t(float(var[2][2]), 5.0) && allOk;
	allOk = compare_float16_t(float(var[3][0]), 1.0) && allOk;
	allOk = compare_float16_t(float(var[3][1]), -3.0) && allOk;
	allOk = compare_float16_t(float(var[3][2]), 2.0) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = float16_t(-8.0);
	var[0][0] = float16_t(9.0);
	var[0][1] = float16_t(-2.0);
	var[0][2] = float16_t(7.0);
	var[1][0] = float16_t(8.0);
	var[1][1] = float16_t(-9.0);
	var[1][2] = float16_t(2.0);
	var[2][0] = float16_t(-8.0);
	var[2][1] = float16_t(-1.0);
	var[2][2] = float16_t(6.0);
	var[3][0] = float16_t(-7.0);
	var[3][1] = float16_t(-5.0);
	var[3][2] = float16_t(8.0);
}
#version 450
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

layout(std430, column_major, binding = 1) buffer Block
{
	highp mat3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0][0][0], mat3(-1.0, 2.0, -7.0, -6.0, 0.0, 4.0, -7.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(-9.0, -8.0, 6.0, 6.0, 6.0, -3.0, -6.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(var[0][0][2], mat3(3.0, 8.0, 0.0, -4.0, -4.0, 3.0, 9.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(-1.0, 5.0, -1.0, 7.0, -2.0, -7.0, 2.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(-3.0, -8.0, 0.0, -2.0, 6.0, -7.0, -6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(var[0][1][2], mat3(1.0, 7.0, 9.0, -8.0, 7.0, -3.0, -9.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(-4.0, -2.0, 2.0, 2.0, -7.0, 5.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(-2.0, 1.0, -3.0, -2.0, -1.0, -1.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat3(var[1][0][2], mat3(3.0, 0.0, 8.0, 2.0, -7.0, 8.0, -8.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(-9.0, 2.0, -9.0, 9.0, 5.0, 3.0, 1.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(2.0, -4.0, -3.0, 6.0, -4.0, -3.0, -8.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3(var[1][1][2], mat3(-1.0, 5.0, -7.0, -9.0, 2.0, 9.0, -3.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(0.0, 1.0, -8.0, 2.0, 9.0, -7.0, -1.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(-5.0, -7.0, 5.0, 0.0, -8.0, 3.0, -1.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[2][0][2], mat3(4.0, -4.0, 0.0, 6.0, 9.0, 9.0, 1.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(0.0, 0.0, 9.0, -5.0, 2.0, 9.0, -4.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(4.0, -6.0, 6.0, -1.0, 7.0, 1.0, -1.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3(var[2][1][2], mat3(5.0, -1.0, -5.0, -9.0, -2.0, -5.0, 0.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat3(var[3][0][0], mat3(0.0, -5.0, 5.0, -4.0, 5.0, 1.0, 4.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3(var[3][0][1], mat3(-1.0, 3.0, 0.0, 3.0, -9.0, -7.0, -8.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat3(var[3][0][2], mat3(-4.0, 7.0, -3.0, 0.0, -4.0, 7.0, 9.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat3(var[3][1][0], mat3(-8.0, 4.0, 0.0, 6.0, -4.0, -5.0, 8.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat3(var[3][1][1], mat3(-2.0, -3.0, -8.0, 5.0, 6.0, 7.0, -3.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat3(var[3][1][2], mat3(7.0, -5.0, -7.0, -8.0, 4.0, 4.0, 0.0, -2.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec3(-1.0, 1.0, 4.0));
	var[0][0][0][1] = (vec3(6.0, -5.0, -5.0));
	var[0][0][0][2] = (vec3(9.0, -6.0, 5.0));
	var[0][0][1][0] = (vec3(7.0, 7.0, -2.0));
	var[0][0][1][1] = (vec3(-4.0, 1.0, -5.0));
	var[0][0][1][2] = (vec3(8.0, -1.0, -8.0));
	var[0][0][2][0] = (vec3(-6.0, -4.0, 5.0));
	var[0][0][2][1] = (vec3(3.0, 9.0, -8.0));
	var[0][0][2][2] = (vec3(-4.0, 8.0, 0.0));
	var[0][1][0][0] = (vec3(4.0, 2.0, 9.0));
	var[0][1][0][1] = (vec3(-7.0, 2.0, 0.0));
	var[0][1][0][2] = (vec3(0.0, -4.0, 3.0));
	var[0][1][1][0] = (vec3(-7.0, -7.0, 1.0));
	var[0][1][1][1] = (vec3(1.0, -5.0, 0.0));
	var[0][1][1][2] = (vec3(5.0, -6.0, 7.0));
	var[0][1][2][0] = (vec3(-2.0, 8.0, -5.0));
	var[0][1][2][1] = (vec3(4.0, -8.0, 2.0));
	var[0][1][2][2] = (vec3(4.0, 2.0, -7.0));
	var[1][0][0][0] = (vec3(5.0, -1.0, 2.0));
	var[1][0][0][1] = (vec3(3.0, 0.0, 8.0));
	var[1][0][0][2] = (vec3(-8.0, -9.0, -1.0));
	var[1][0][1][0] = (vec3(-9.0, 4.0, -9.0));
	var[1][0][1][1] = (vec3(7.0, 3.0, 7.0));
	var[1][0][1][2] = (vec3(5.0, -4.0, 3.0));
	var[1][0][2][0] = (vec3(-9.0, 9.0, 4.0));
	var[1][0][2][1] = (vec3(7.0, -1.0, 2.0));
	var[1][0][2][2] = (vec3(-5.0, 2.0, -9.0));
	var[1][1][0][0] = (vec3(-5.0, 2.0, -4.0));
	var[1][1][0][1] = (vec3(0.0, 5.0, -5.0));
	var[1][1][0][2] = (vec3(3.0, 3.0, -8.0));
	var[1][1][1][0] = (vec3(0.0, -7.0, -2.0));
	var[1][1][1][1] = (vec3(-8.0, 3.0, -2.0));
	var[1][1][1][2] = (vec3(9.0, -7.0, -7.0));
	var[1][1][2][0] = (vec3(4.0, -6.0, -3.0));
	var[1][1][2][1] = (vec3(-9.0, -3.0, 8.0));
	var[1][1][2][2] = (vec3(-8.0, -1.0, -6.0));
	var[2][0][0][0] = (vec3(9.0, -7.0, -5.0));
	var[2][0][0][1] = (vec3(-4.0, -8.0, -6.0));
	var[2][0][0][2] = (vec3(-9.0, -6.0, -5.0));
	var[2][0][1][0] = (vec3(7.0, -5.0, 1.0));
	var[2][0][1][1] = (vec3(-7.0, 6.0, -4.0));
	var[2][0][1][2] = (vec3(-3.0, -4.0, -2.0));
	var[2][0][2][0] = (vec3(-4.0, -4.0, 3.0));
	var[2][0][2][1] = (vec3(-9.0, -7.0, 0.0));
	var[2][0][2][2] = (vec3(3.0, 0.0, -1.0));
	var[2][1][0][0] = (vec3(0.0, 5.0, 9.0));
	var[2][1][0][1] = (vec3(-2.0, -2.0, 3.0));
	var[2][1][0][2] = (vec3(-5.0, 3.0, -7.0));
	var[2][1][1][0] = (vec3(-2.0, -3.0, 0.0));
	var[2][1][1][1] = (vec3(-8.0, -8.0, 6.0));
	var[2][1][1][2] = (vec3(2.0, -2.0, -4.0));
	var[2][1][2][0] = (vec3(7.0, 1.0, 7.0));
	var[2][1][2][1] = (vec3(-6.0, 7.0, -3.0));
	var[2][1][2][2] = (vec3(4.0, -6.0, -5.0));
	var[3][0][0][0] = (vec3(-5.0, -6.0, 8.0));
	var[3][0][0][1] = (vec3(3.0, 3.0, -1.0));
	var[3][0][0][2] = (vec3(-7.0, 5.0, 7.0));
	var[3][0][1][0] = (vec3(7.0, 4.0, -7.0));
	var[3][0][1][1] = (vec3(7.0, 7.0, -4.0));
	var[3][0][1][2] = (vec3(-5.0, 9.0, -8.0));
	var[3][0][2][0] = (vec3(-6.0, -7.0, -1.0));
	var[3][0][2][1] = (vec3(8.0, 9.0, 3.0));
	var[3][0][2][2] = (vec3(0.0, -5.0, -7.0));
	var[3][1][0][0] = (vec3(-6.0, -9.0, -9.0));
	var[3][1][0][1] = (vec3(-3.0, 9.0, -8.0));
	var[3][1][0][2] = (vec3(7.0, 7.0, -2.0));
	var[3][1][1][0] = (vec3(-3.0, 4.0, 1.0));
	var[3][1][1][1] = (vec3(-6.0, 4.0, 7.0));
	var[3][1][1][2] = (vec3(-2.0, -4.0, -3.0));
	var[3][1][2][0] = (vec3(-3.0, -5.0, 1.0));
	var[3][1][2][1] = (vec3(4.0, 9.0, -7.0));
	var[3][1][2][2] = (vec3(-1.0, -7.0, -9.0));
}
#version 450
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
	highp ivec4 var[4][2][3];
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((padding), -7) && allOk;
	allOk = compare_ivec4((var[0][0][0]), ivec4(9, -5, 6, 3)) && allOk;
	allOk = compare_ivec4((var[0][0][1]), ivec4(4, 2, -3, -3)) && allOk;
	allOk = compare_ivec4((var[0][0][2]), ivec4(-3, -5, -5, 3)) && allOk;
	allOk = compare_ivec4((var[0][1][0]), ivec4(2, 6, -5, 1)) && allOk;
	allOk = compare_ivec4((var[0][1][1]), ivec4(5, 7, 9, -6)) && allOk;
	allOk = compare_ivec4((var[0][1][2]), ivec4(4, 0, 9, -3)) && allOk;
	allOk = compare_ivec4((var[1][0][0]), ivec4(-5, -9, -7, 1)) && allOk;
	allOk = compare_ivec4((var[1][0][1]), ivec4(5, 9, 7, -4)) && allOk;
	allOk = compare_ivec4((var[1][0][2]), ivec4(-1, 8, -1, 4)) && allOk;
	allOk = compare_ivec4((var[1][1][0]), ivec4(6, -6, -6, 1)) && allOk;
	allOk = compare_ivec4((var[1][1][1]), ivec4(-6, -3, 5, 9)) && allOk;
	allOk = compare_ivec4((var[1][1][2]), ivec4(-7, -1, -9, 8)) && allOk;
	allOk = compare_ivec4((var[2][0][0]), ivec4(3, 6, -6, 1)) && allOk;
	allOk = compare_ivec4((var[2][0][1]), ivec4(-3, 0, 0, 1)) && allOk;
	allOk = compare_ivec4((var[2][0][2]), ivec4(-6, 0, -7, 6)) && allOk;
	allOk = compare_ivec4((var[2][1][0]), ivec4(-5, 1, -2, 2)) && allOk;
	allOk = compare_ivec4((var[2][1][1]), ivec4(9, -9, -7, -5)) && allOk;
	allOk = compare_ivec4((var[2][1][2]), ivec4(-2, 6, 4, -1)) && allOk;
	allOk = compare_ivec4((var[3][0][0]), ivec4(-4, -4, 0, 8)) && allOk;
	allOk = compare_ivec4((var[3][0][1]), ivec4(-3, 3, 3, -3)) && allOk;
	allOk = compare_ivec4((var[3][0][2]), ivec4(1, 3, 1, -7)) && allOk;
	allOk = compare_ivec4((var[3][1][0]), ivec4(1, 1, 5, 1)) && allOk;
	allOk = compare_ivec4((var[3][1][1]), ivec4(-9, 2, -2, -5)) && allOk;
	allOk = compare_ivec4((var[3][1][2]), ivec4(-8, 8, -9, -8)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (5);
	var[0][0][0] = (ivec4(-9, 5, -6, -2));
	var[0][0][1] = (ivec4(-4, 1, -9, 7));
	var[0][0][2] = (ivec4(3, 6, 8, 6));
	var[0][1][0] = (ivec4(1, -4, 4, -2));
	var[0][1][1] = (ivec4(5, -8, 0, 8));
	var[0][1][2] = (ivec4(-9, -8, -3, 3));
	var[1][0][0] = (ivec4(-4, 6, -7, 9));
	var[1][0][1] = (ivec4(-8, -9, 0, 5));
	var[1][0][2] = (ivec4(-7, 2, 9, 6));
	var[1][1][0] = (ivec4(-9, -5, -4, -8));
	var[1][1][1] = (ivec4(8, -3, 2, -2));
	var[1][1][2] = (ivec4(-6, 4, -5, 6));
	var[2][0][0] = (ivec4(5, 4, 0, 5));
	var[2][0][1] = (ivec4(9, 0, 0, -6));
	var[2][0][2] = (ivec4(4, 4, 2, 9));
	var[2][1][0] = (ivec4(8, -7, -2, 9));
	var[2][1][1] = (ivec4(-9, -5, -6, -5));
	var[2][1][2] = (ivec4(-7, -9, -3, -2));
	var[3][0][0] = (ivec4(7, 5, 5, 3));
	var[3][0][1] = (ivec4(-3, -9, -8, -6));
	var[3][0][2] = (ivec4(3, 2, 0, 7));
	var[3][1][0] = (ivec4(-1, -9, 9, -5));
	var[3][1][1] = (ivec4(1, 9, -8, 0));
	var[3][1][2] = (ivec4(5, -8, -8, 0));
}
#version 450
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
	highp mat3x2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0][0][0], mat3x2(-1.0, 4.0, -9.0, -1.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][1], mat3x2(-8.0, 6.0, 3.0, 1.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][0], mat3x2(8.0, -8.0, -7.0, 7.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][1], mat3x2(3.0, 9.0, -2.0, 2.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[0][2][0], mat3x2(-7.0, 3.0, -2.0, 8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[0][2][1], mat3x2(0.0, 9.0, -3.0, 8.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[0][3][0], mat3x2(-9.0, 9.0, 5.0, -2.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[0][3][1], mat3x2(-3.0, 6.0, 4.0, 5.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][0], mat3x2(-8.0, -3.0, 3.0, -3.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][1], mat3x2(1.0, 1.0, -3.0, -8.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][0], mat3x2(-3.0, 9.0, 6.0, 2.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][1], mat3x2(7.0, 1.0, 1.0, 8.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[1][2][0], mat3x2(8.0, -3.0, 6.0, 0.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[1][2][1], mat3x2(6.0, -8.0, 1.0, -6.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[1][3][0], mat3x2(2.0, -9.0, -7.0, 3.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[1][3][1], mat3x2(-3.0, 9.0, 2.0, -2.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][0], mat3x2(2.0, 8.0, 7.0, 7.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][1], mat3x2(-4.0, -7.0, 1.0, -1.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][0], mat3x2(2.0, 7.0, -2.0, -4.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][1], mat3x2(-8.0, -1.0, -7.0, 9.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[2][2][0], mat3x2(8.0, 9.0, 4.0, 6.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[2][2][1], mat3x2(1.0, -7.0, 6.0, 0.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[2][3][0], mat3x2(-3.0, 1.0, 6.0, 9.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[2][3][1], mat3x2(2.0, -2.0, -9.0, -3.0, -9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3x2(-2.0, -2.0, -8.0, 0.0, -9.0, 9.0));
	var[0][0][1] = (mat3x2(0.0, 1.0, -3.0, -6.0, -5.0, -7.0));
	var[0][1][0] = (mat3x2(-5.0, -4.0, -8.0, 9.0, -9.0, -8.0));
	var[0][1][1] = (mat3x2(8.0, -4.0, 1.0, -1.0, 7.0, 0.0));
	var[0][2][0] = (mat3x2(-7.0, -7.0, -1.0, 1.0, -5.0, 2.0));
	var[0][2][1] = (mat3x2(5.0, 5.0, 3.0, -9.0, 7.0, -4.0));
	var[0][3][0] = (mat3x2(-2.0, -4.0, 7.0, -2.0, 0.0, 0.0));
	var[0][3][1] = (mat3x2(-4.0, 1.0, -6.0, -5.0, -1.0, 0.0));
	var[1][0][0] = (mat3x2(5.0, -4.0, 8.0, -1.0, -8.0, 1.0));
	var[1][0][1] = (mat3x2(2.0, 1.0, -5.0, 0.0, -3.0, 1.0));
	var[1][1][0] = (mat3x2(1.0, -3.0, 6.0, -4.0, -6.0, -5.0));
	var[1][1][1] = (mat3x2(-6.0, -4.0, 6.0, 4.0, 2.0, -8.0));
	var[1][2][0] = (mat3x2(-1.0, -7.0, -6.0, -4.0, -4.0, 8.0));
	var[1][2][1] = (mat3x2(3.0, -5.0, 8.0, 6.0, 0.0, -2.0));
	var[1][3][0] = (mat3x2(-7.0, -3.0, -5.0, -9.0, 7.0, -3.0));
	var[1][3][1] = (mat3x2(4.0, 1.0, 0.0, 2.0, -6.0, -1.0));
	var[2][0][0] = (mat3x2(-4.0, 4.0, 5.0, -5.0, -6.0, 3.0));
	var[2][0][1] = (mat3x2(1.0, -2.0, 3.0, -8.0, -6.0, 2.0));
	var[2][1][0] = (mat3x2(2.0, 1.0, -3.0, -3.0, -5.0, -1.0));
	var[2][1][1] = (mat3x2(6.0, 9.0, 9.0, 9.0, -4.0, 8.0));
	var[2][2][0] = (mat3x2(9.0, -9.0, -7.0, -9.0, -9.0, 4.0));
	var[2][2][1] = (mat3x2(5.0, 9.0, 6.0, -1.0, 0.0, -2.0));
	var[2][3][0] = (mat3x2(-4.0, 4.0, 0.0, -1.0, -4.0, -4.0));
	var[2][3][1] = (mat3x2(-2.0, 9.0, 8.0, 9.0, -3.0, -7.0));
}
#version 450
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
	allOk = compare_mat4(var[0][0][0], mat4(6.0, 9.0, -9.0, 2.0, -1.0, -3.0, 3.0, 6.0, 5.0, 1.0, -3.0, -2.0, 3.0, -6.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(8.0, 2.0, 9.0, 5.0, 5.0, 3.0, -9.0, -5.0, -8.0, 6.0, -6.0, -7.0, -6.0, 0.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(-7.0, -5.0, -1.0, -9.0, -5.0, 6.0, -9.0, 5.0, 2.0, -2.0, -8.0, 4.0, -3.0, 7.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(8.0, 4.0, 5.0, 8.0, -5.0, 9.0, 7.0, 1.0, -8.0, -2.0, -1.0, -2.0, -8.0, -2.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4(var[0][2][0], mat4(7.0, 2.0, -1.0, 1.0, 5.0, -3.0, 1.0, 4.0, -4.0, 9.0, -1.0, 3.0, -1.0, -6.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat4(var[0][2][1], mat4(-9.0, 5.0, -4.0, 9.0, 0.0, -8.0, 3.0, -9.0, -3.0, -7.0, -2.0, -9.0, -9.0, 5.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat4(var[0][3][0], mat4(5.0, -1.0, 9.0, -9.0, -4.0, 1.0, -2.0, 0.0, -1.0, -4.0, -4.0, -4.0, 1.0, 3.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat4(var[0][3][1], mat4(8.0, 5.0, 5.0, -4.0, 8.0, 4.0, -3.0, 1.0, -4.0, -2.0, 1.0, 5.0, 1.0, -4.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(-3.0, 5.0, 8.0, -1.0, -4.0, 4.0, 3.0, -8.0, 1.0, -1.0, 7.0, 4.0, -2.0, 1.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(4.0, 1.0, -4.0, 3.0, 4.0, -1.0, -9.0, 8.0, 1.0, -9.0, -9.0, -8.0, 1.0, 0.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(3.0, 0.0, -4.0, -2.0, -4.0, 0.0, -6.0, 4.0, 0.0, 1.0, -6.0, -3.0, 6.0, -1.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(-3.0, 5.0, -5.0, 7.0, -3.0, -5.0, 5.0, 9.0, 1.0, 8.0, -5.0, 8.0, 9.0, 0.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4(var[1][2][0], mat4(-8.0, 2.0, -5.0, 2.0, -4.0, 3.0, -8.0, 7.0, 2.0, -8.0, 3.0, -9.0, 2.0, -1.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat4(var[1][2][1], mat4(3.0, 1.0, 0.0, 3.0, -2.0, -4.0, 2.0, 4.0, 9.0, -4.0, 0.0, -2.0, -9.0, 6.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat4(var[1][3][0], mat4(0.0, -1.0, -7.0, -6.0, 1.0, 2.0, -8.0, -5.0, -7.0, 2.0, -5.0, 6.0, 9.0, -4.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1][3][1], mat4(-9.0, 1.0, 0.0, -7.0, 1.0, 4.0, -8.0, 4.0, 5.0, 9.0, -2.0, -4.0, 9.0, 1.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(1.0, -4.0, 9.0, -7.0, -6.0, -2.0, -7.0, -4.0, 1.0, 2.0, 6.0, -8.0, 3.0, -2.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(-9.0, 7.0, -4.0, -2.0, 4.0, 5.0, 5.0, -2.0, 4.0, -6.0, 1.0, -3.0, -4.0, 6.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(3.0, 1.0, 2.0, -2.0, -6.0, 0.0, 3.0, 9.0, 3.0, 0.0, 2.0, 8.0, 7.0, -6.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(-3.0, 8.0, 8.0, 7.0, 0.0, 0.0, 3.0, 0.0, -3.0, -4.0, 5.0, -6.0, 4.0, -4.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][2][0], mat4(-9.0, 1.0, 0.0, -6.0, 2.0, -3.0, 5.0, -9.0, -7.0, -4.0, -1.0, -8.0, 7.0, -3.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4(var[2][2][1], mat4(1.0, 3.0, -1.0, 1.0, 2.0, -3.0, 6.0, -8.0, 2.0, 7.0, -8.0, 5.0, -3.0, 2.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4(var[2][3][0], mat4(-9.0, -6.0, -4.0, -6.0, 4.0, 6.0, 9.0, 9.0, -5.0, -1.0, -4.0, 6.0, 2.0, 5.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat4(var[2][3][1], mat4(7.0, 0.0, 2.0, 6.0, 2.0, -3.0, 4.0, 2.0, 4.0, -4.0, 9.0, 3.0, -8.0, 4.0, 5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(0.0, -7.0, -8.0, 3.0));
	var[0][0][0][1] = (vec4(-4.0, 2.0, 2.0, 9.0));
	var[0][0][0][2] = (vec4(0.0, 4.0, -1.0, -5.0));
	var[0][0][0][3] = (vec4(4.0, 0.0, -6.0, -6.0));
	var[0][0][1][0] = (vec4(-6.0, 3.0, 9.0, -6.0));
	var[0][0][1][1] = (vec4(2.0, 5.0, 4.0, -7.0));
	var[0][0][1][2] = (vec4(1.0, -4.0, 3.0, 5.0));
	var[0][0][1][3] = (vec4(-6.0, 0.0, -6.0, -4.0));
	var[0][1][0][0] = (vec4(-7.0, 3.0, -4.0, -1.0));
	var[0][1][0][1] = (vec4(-6.0, -7.0, -3.0, -9.0));
	var[0][1][0][2] = (vec4(9.0, -1.0, -3.0, -5.0));
	var[0][1][0][3] = (vec4(8.0, 1.0, -1.0, -3.0));
	var[0][1][1][0] = (vec4(-4.0, -2.0, -3.0, 5.0));
	var[0][1][1][1] = (vec4(-9.0, -3.0, 8.0, 4.0));
	var[0][1][1][2] = (vec4(2.0, 2.0, 2.0, -1.0));
	var[0][1][1][3] = (vec4(0.0, -1.0, -1.0, 4.0));
	var[0][2][0][0] = (vec4(4.0, 9.0, -9.0, 1.0));
	var[0][2][0][1] = (vec4(-5.0, 7.0, 2.0, -4.0));
	var[0][2][0][2] = (vec4(-7.0, -5.0, -4.0, -9.0));
	var[0][2][0][3] = (vec4(6.0, -7.0, 7.0, -2.0));
	var[0][2][1][0] = (vec4(-3.0, -6.0, 6.0, -4.0));
	var[0][2][1][1] = (vec4(-2.0, 1.0, 1.0, 9.0));
	var[0][2][1][2] = (vec4(-3.0, 5.0, 1.0, 7.0));
	var[0][2][1][3] = (vec4(-2.0, 9.0, -6.0, -6.0));
	var[0][3][0][0] = (vec4(-5.0, 7.0, -6.0, -2.0));
	var[0][3][0][1] = (vec4(-1.0, -6.0, 6.0, 7.0));
	var[0][3][0][2] = (vec4(-6.0, 2.0, 9.0, -1.0));
	var[0][3][0][3] = (vec4(-1.0, 0.0, -7.0, 8.0));
	var[0][3][1][0] = (vec4(5.0, -1.0, -2.0, 8.0));
	var[0][3][1][1] = (vec4(3.0, 3.0, -7.0, 4.0));
	var[0][3][1][2] = (vec4(-5.0, 6.0, -8.0, -6.0));
	var[0][3][1][3] = (vec4(-1.0, 0.0, -2.0, -7.0));
	var[1][0][0][0] = (vec4(1.0, 6.0, 0.0, 8.0));
	var[1][0][0][1] = (vec4(-9.0, 0.0, 8.0, 4.0));
	var[1][0][0][2] = (vec4(-2.0, -5.0, -6.0, -8.0));
	var[1][0][0][3] = (vec4(-5.0, 8.0, 8.0, -7.0));
	var[1][0][1][0] = (vec4(4.0, -5.0, 7.0, 9.0));
	var[1][0][1][1] = (vec4(4.0, -5.0, 4.0, -7.0));
	var[1][0][1][2] = (vec4(6.0, -1.0, 4.0, 5.0));
	var[1][0][1][3] = (vec4(-7.0, 7.0, 7.0, -6.0));
	var[1][1][0][0] = (vec4(1.0, 1.0, 4.0, -2.0));
	var[1][1][0][1] = (vec4(5.0, -5.0, 9.0, 2.0));
	var[1][1][0][2] = (vec4(6.0, -2.0, 5.0, 3.0));
	var[1][1][0][3] = (vec4(-7.0, 0.0, 4.0, 3.0));
	var[1][1][1][0] = (vec4(2.0, -7.0, 5.0, 7.0));
	var[1][1][1][1] = (vec4(-5.0, 0.0, -9.0, -7.0));
	var[1][1][1][2] = (vec4(2.0, 7.0, -9.0, 7.0));
	var[1][1][1][3] = (vec4(-2.0, -5.0, 4.0, 3.0));
	var[1][2][0][0] = (vec4(-8.0, 2.0, 1.0, -8.0));
	var[1][2][0][1] = (vec4(5.0, -3.0, 8.0, 1.0));
	var[1][2][0][2] = (vec4(7.0, -4.0, 8.0, -5.0));
	var[1][2][0][3] = (vec4(-6.0, -1.0, 9.0, -9.0));
	var[1][2][1][0] = (vec4(3.0, -3.0, 3.0, -8.0));
	var[1][2][1][1] = (vec4(2.0, -3.0, -6.0, -2.0));
	var[1][2][1][2] = (vec4(-3.0, -9.0, -6.0, -3.0));
	var[1][2][1][3] = (vec4(8.0, 4.0, 6.0, 7.0));
	var[1][3][0][0] = (vec4(-4.0, -1.0, 3.0, 9.0));
	var[1][3][0][1] = (vec4(-6.0, -3.0, 8.0, 4.0));
	var[1][3][0][2] = (vec4(7.0, -4.0, 3.0, -5.0));
	var[1][3][0][3] = (vec4(-8.0, 0.0, -4.0, -3.0));
	var[1][3][1][0] = (vec4(7.0, -8.0, -4.0, -8.0));
	var[1][3][1][1] = (vec4(4.0, 4.0, -7.0, -2.0));
	var[1][3][1][2] = (vec4(9.0, -6.0, 6.0, 2.0));
	var[1][3][1][3] = (vec4(-2.0, -8.0, -8.0, -9.0));
	var[2][0][0][0] = (vec4(-8.0, 9.0, -5.0, 0.0));
	var[2][0][0][1] = (vec4(5.0, -7.0, 8.0, -7.0));
	var[2][0][0][2] = (vec4(2.0, -8.0, 8.0, -7.0));
	var[2][0][0][3] = (vec4(6.0, -4.0, -6.0, -2.0));
	var[2][0][1][0] = (vec4(7.0, -2.0, -9.0, 2.0));
	var[2][0][1][1] = (vec4(7.0, -4.0, -9.0, 0.0));
	var[2][0][1][2] = (vec4(6.0, -3.0, 3.0, 6.0));
	var[2][0][1][3] = (vec4(3.0, -4.0, 8.0, -2.0));
	var[2][1][0][0] = (vec4(6.0, 3.0, 8.0, 9.0));
	var[2][1][0][1] = (vec4(8.0, -4.0, -4.0, 4.0));
	var[2][1][0][2] = (vec4(-9.0, -3.0, 0.0, -3.0));
	var[2][1][0][3] = (vec4(0.0, 8.0, -3.0, 6.0));
	var[2][1][1][0] = (vec4(-8.0, -5.0, 6.0, -7.0));
	var[2][1][1][1] = (vec4(-6.0, -5.0, 7.0, -6.0));
	var[2][1][1][2] = (vec4(-1.0, 8.0, 9.0, 6.0));
	var[2][1][1][3] = (vec4(8.0, -7.0, 0.0, -8.0));
	var[2][2][0][0] = (vec4(7.0, -9.0, 8.0, -1.0));
	var[2][2][0][1] = (vec4(9.0, 5.0, 8.0, -4.0));
	var[2][2][0][2] = (vec4(-8.0, -2.0, -3.0, 3.0));
	var[2][2][0][3] = (vec4(6.0, 4.0, 0.0, -1.0));
	var[2][2][1][0] = (vec4(6.0, 3.0, 4.0, -9.0));
	var[2][2][1][1] = (vec4(5.0, 5.0, 8.0, -6.0));
	var[2][2][1][2] = (vec4(8.0, 3.0, -1.0, -4.0));
	var[2][2][1][3] = (vec4(-4.0, 1.0, 4.0, -4.0));
	var[2][3][0][0] = (vec4(5.0, -7.0, -8.0, 4.0));
	var[2][3][0][1] = (vec4(7.0, 2.0, 7.0, -8.0));
	var[2][3][0][2] = (vec4(-8.0, -4.0, -4.0, -1.0));
	var[2][3][0][3] = (vec4(-8.0, 3.0, 5.0, 3.0));
	var[2][3][1][0] = (vec4(-9.0, 4.0, 6.0, -2.0));
	var[2][3][1][1] = (vec4(6.0, -6.0, 7.0, -7.0));
	var[2][3][1][2] = (vec4(-5.0, -8.0, -2.0, -7.0));
	var[2][3][1][3] = (vec4(7.0, -4.0, -8.0, -1.0));
}
#version 450
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
	allOk = compare_mat3x4(var[0][0][0], mat3x4(-1.0, -2.0, -5.0, -5.0, -8.0, 2.0, -9.0, 8.0, -1.0, -4.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][1], mat3x4(2.0, 9.0, -2.0, 5.0, 1.0, 4.0, -5.0, 3.0, -6.0, 9.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][0], mat3x4(-9.0, -9.0, 1.0, 6.0, -2.0, -2.0, -2.0, 1.0, 3.0, 5.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][1], mat3x4(-6.0, 1.0, -4.0, 2.0, 9.0, -9.0, -2.0, 6.0, 1.0, 4.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[0][2][0], mat3x4(-7.0, -8.0, -1.0, 5.0, 6.0, -6.0, -4.0, 9.0, -5.0, 3.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3x4(var[0][2][1], mat3x4(-9.0, 3.0, 1.0, 8.0, 7.0, 0.0, 7.0, 9.0, -1.0, 9.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[0][3][0], mat3x4(-5.0, -7.0, 0.0, -4.0, 1.0, 2.0, -2.0, -3.0, -4.0, 2.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[0][3][1], mat3x4(6.0, -3.0, 9.0, 7.0, -4.0, -2.0, 6.0, 5.0, 2.0, -2.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][0], mat3x4(-2.0, 8.0, -3.0, 3.0, 5.0, 1.0, -8.0, 4.0, 7.0, 5.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][1], mat3x4(-3.0, 1.0, 4.0, 2.0, -2.0, -6.0, -4.0, 8.0, -8.0, -1.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][0], mat3x4(-6.0, 5.0, 3.0, -1.0, 6.0, 5.0, 6.0, -4.0, 6.0, -9.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][1], mat3x4(-8.0, 6.0, 7.0, -3.0, -3.0, 5.0, 9.0, 6.0, 7.0, 2.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[1][2][0], mat3x4(3.0, 8.0, 0.0, -6.0, -6.0, -1.0, -2.0, 5.0, 1.0, -3.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[1][2][1], mat3x4(0.0, 8.0, -9.0, 6.0, -5.0, 3.0, -8.0, -1.0, -9.0, 3.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[1][3][0], mat3x4(0.0, -8.0, -2.0, 7.0, 5.0, -6.0, 9.0, 6.0, 4.0, -4.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[1][3][1], mat3x4(-2.0, 8.0, -4.0, 7.0, 4.0, 5.0, 1.0, -1.0, 3.0, 0.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][0], mat3x4(6.0, -6.0, -8.0, 8.0, 4.0, 9.0, 6.0, -6.0, 9.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][1], mat3x4(2.0, 8.0, -9.0, 0.0, 3.0, 2.0, 4.0, -9.0, -1.0, 1.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][0], mat3x4(-9.0, 1.0, 2.0, 0.0, -3.0, -3.0, 0.0, -7.0, 9.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][1], mat3x4(4.0, 8.0, -1.0, 7.0, 0.0, 2.0, 3.0, 3.0, 7.0, 8.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[2][2][0], mat3x4(-8.0, 8.0, -1.0, 9.0, 1.0, -5.0, -4.0, 3.0, 5.0, 7.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[2][2][1], mat3x4(-2.0, 6.0, 5.0, 9.0, 2.0, -3.0, 3.0, 8.0, 8.0, 6.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[2][3][0], mat3x4(-6.0, 1.0, -9.0, 0.0, -5.0, 8.0, -9.0, 1.0, -2.0, -2.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[2][3][1], mat3x4(-7.0, -6.0, -7.0, 6.0, 0.0, -6.0, 7.0, 3.0, 0.0, -7.0, 7.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3x4(-1.0, 6.0, 4.0, -6.0, -6.0, 0.0, -6.0, 9.0, -5.0, 3.0, -3.0, -2.0));
	var[0][0][1] = (mat3x4(-9.0, 9.0, -2.0, 3.0, -4.0, 2.0, -4.0, -4.0, 2.0, 1.0, 3.0, -2.0));
	var[0][1][0] = (mat3x4(3.0, 1.0, -4.0, -8.0, -9.0, -6.0, -2.0, -8.0, 0.0, 0.0, 1.0, 5.0));
	var[0][1][1] = (mat3x4(1.0, -1.0, -1.0, -7.0, -9.0, -5.0, 6.0, -4.0, -3.0, -9.0, -2.0, 8.0));
	var[0][2][0] = (mat3x4(-5.0, -6.0, -9.0, -2.0, 3.0, 0.0, 8.0, 5.0, 9.0, 8.0, 5.0, -4.0));
	var[0][2][1] = (mat3x4(5.0, 8.0, 3.0, -2.0, -6.0, -3.0, 3.0, 3.0, 0.0, 9.0, -9.0, 4.0));
	var[0][3][0] = (mat3x4(2.0, -3.0, -5.0, 8.0, -5.0, 3.0, 2.0, 1.0, 4.0, -5.0, -7.0, -9.0));
	var[0][3][1] = (mat3x4(5.0, 1.0, 4.0, 9.0, -7.0, -7.0, -7.0, 9.0, -4.0, 1.0, 3.0, 5.0));
	var[1][0][0] = (mat3x4(-7.0, 6.0, 0.0, 4.0, -1.0, -2.0, 4.0, -1.0, 4.0, 1.0, -9.0, 5.0));
	var[1][0][1] = (mat3x4(-9.0, 1.0, -3.0, -5.0, -5.0, 8.0, 4.0, -4.0, -5.0, 7.0, 3.0, -5.0));
	var[1][1][0] = (mat3x4(9.0, 2.0, -4.0, -9.0, -7.0, 4.0, -5.0, -9.0, 2.0, -9.0, 4.0, 6.0));
	var[1][1][1] = (mat3x4(4.0, -5.0, 0.0, -5.0, -7.0, 5.0, 0.0, 7.0, -3.0, -3.0, 9.0, -4.0));
	var[1][2][0] = (mat3x4(-8.0, -7.0, 4.0, -2.0, -9.0, -4.0, -3.0, -8.0, 7.0, 8.0, -1.0, -7.0));
	var[1][2][1] = (mat3x4(0.0, -4.0, 5.0, 2.0, 2.0, -3.0, 7.0, -3.0, 7.0, 0.0, -2.0, 0.0));
	var[1][3][0] = (mat3x4(-6.0, 6.0, 7.0, 7.0, -3.0, -3.0, -7.0, -3.0, 5.0, -8.0, 3.0, 3.0));
	var[1][3][1] = (mat3x4(-9.0, 1.0, 5.0, 5.0, -5.0, 8.0, 4.0, -4.0, 9.0, -2.0, 1.0, -8.0));
	var[2][0][0] = (mat3x4(-4.0, 4.0, 3.0, 8.0, -8.0, 9.0, -3.0, -2.0, -4.0, 3.0, -3.0, 7.0));
	var[2][0][1] = (mat3x4(-9.0, -3.0, 7.0, -7.0, -6.0, 5.0, -4.0, -8.0, 2.0, -3.0, -9.0, -5.0));
	var[2][1][0] = (mat3x4(-9.0, 0.0, 8.0, 4.0, -9.0, 6.0, 9.0, 3.0, -8.0, -4.0, -4.0, -2.0));
	var[2][1][1] = (mat3x4(6.0, -3.0, -7.0, -8.0, 6.0, -1.0, -8.0, 6.0, -1.0, 6.0, -3.0, 2.0));
	var[2][2][0] = (mat3x4(-3.0, 7.0, -2.0, 4.0, -6.0, -3.0, 4.0, -8.0, 7.0, -3.0, -5.0, -5.0));
	var[2][2][1] = (mat3x4(-6.0, -2.0, 3.0, 6.0, 7.0, 1.0, -6.0, 7.0, -9.0, 5.0, 5.0, 3.0));
	var[2][3][0] = (mat3x4(-2.0, 9.0, 3.0, 9.0, 9.0, -1.0, -9.0, 3.0, -9.0, 2.0, 2.0, -6.0));
	var[2][3][1] = (mat3x4(-9.0, 4.0, 0.0, 2.0, 4.0, -2.0, 9.0, -7.0, 4.0, -5.0, 3.0, -2.0));
}
#version 450
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
	allOk = compare_uint((block[0].u), 6u) && allOk;
	allOk = compare_mat4x3(block[0].t[0].a, mat4x3(0.0, -7.0, 3.0, 0.0, -2.0, 3.0, 5.0, -1.0, -2.0, -1.0, 5.0, -4.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[0].a), uvec3(5u, 7u, 9u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[0]), vec2(2.0, -7.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[1]), vec2(-8.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[2]), vec2(-4.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[3]), vec2(-3.0, -9.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[0].c), vec4(0.0, -9.0, 2.0, -9.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[1].a), uvec3(6u, 8u, 7u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[0]), vec2(3.0, 8.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[1]), vec2(-5.0, 6.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[2]), vec2(-7.0, 5.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[3]), vec2(-5.0, 5.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[1].c), vec4(1.0, 5.0, -9.0, -3.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[2].a), uvec3(5u, 6u, 7u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[0]), vec2(-1.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[1]), vec2(-2.0, -7.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[2]), vec2(1.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[3]), vec2(-9.0, -5.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[2].c), vec4(1.0, -1.0, 4.0, 8.0)) && allOk;
	allOk = compare_int((block[0].t[0].c), -7) && allOk;
	allOk = compare_mat4x3(block[0].t[1].a, mat4x3(-8.0, 1.0, 5.0, 3.0, -1.0, -3.0, 5.0, -1.0, 9.0, -1.0, 6.0, -6.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[0].a), uvec3(2u, 1u, 0u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[0]), vec2(-3.0, -9.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[1]), vec2(1.0, 2.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[2]), vec2(6.0, 3.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[3]), vec2(-4.0, -5.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[0].c), vec4(2.0, 8.0, -4.0, 0.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[1].a), uvec3(9u, 6u, 9u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[0]), vec2(-3.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[1]), vec2(-9.0, 9.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[2]), vec2(-1.0, 1.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[3]), vec2(3.0, -3.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[1].c), vec4(-3.0, 5.0, 2.0, 1.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[2].a), uvec3(1u, 9u, 0u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[0]), vec2(3.0, 1.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[1]), vec2(1.0, 6.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[2]), vec2(-2.0, 9.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[3]), vec2(8.0, -9.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[2].c), vec4(-8.0, -7.0, 7.0, -4.0)) && allOk;
	allOk = compare_int((block[0].t[1].c), -3) && allOk;
	allOk = compare_mat4x3(block[0].t[2].a, mat4x3(-8.0, 5.0, 2.0, 0.0, 8.0, -8.0, -8.0, 8.0, 4.0, 2.0, -7.0, 8.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[0].a), uvec3(7u, 5u, 6u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[0]), vec2(3.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[1]), vec2(-3.0, -3.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[2]), vec2(0.0, 3.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[3]), vec2(3.0, 5.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[0].c), vec4(-6.0, 0.0, 6.0, -3.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[1].a), uvec3(4u, 4u, 7u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[0]), vec2(9.0, 6.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[1]), vec2(-7.0, 0.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[2]), vec2(2.0, 5.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[3]), vec2(4.0, 9.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[1].c), vec4(-1.0, -5.0, -2.0, 4.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[2].a), uvec3(8u, 2u, 1u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[0]), vec2(-4.0, -5.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[1]), vec2(-3.0, 5.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[2]), vec2(6.0, 2.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[3]), vec2(-2.0, -6.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[2].c), vec4(9.0, -1.0, -6.0, 0.0)) && allOk;
	allOk = compare_int((block[0].t[2].c), 9) && allOk;
	allOk = compare_mat4x3(block[0].t[3].a, mat4x3(-1.0, -7.0, -4.0, 5.0, -5.0, 8.0, -4.0, 4.0, -2.0, -7.0, 5.0, -3.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[0].a), uvec3(8u, 8u, 9u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[0]), vec2(-1.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[1]), vec2(-6.0, -4.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[2]), vec2(-8.0, 8.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[3]), vec2(-6.0, 3.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[0].c), vec4(-6.0, 8.0, -2.0, -6.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[1].a), uvec3(6u, 3u, 9u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[0]), vec2(-4.0, 8.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[1]), vec2(0.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[2]), vec2(1.0, 3.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[3]), vec2(7.0, -4.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[1].c), vec4(-7.0, 5.0, 0.0, 7.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[2].a), uvec3(5u, 5u, 7u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[0]), vec2(1.0, -7.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[1]), vec2(9.0, 3.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[2]), vec2(-3.0, -4.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[3]), vec2(-7.0, -7.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[2].c), vec4(-8.0, 2.0, -3.0, 4.0)) && allOk;
	allOk = compare_int((block[0].t[3].c), -7) && allOk;
	allOk = compare_uint((block[1].u), 5u) && allOk;
	allOk = compare_mat4x3(block[1].t[0].a, mat4x3(-5.0, 3.0, -4.0, -8.0, -6.0, -6.0, 5.0, 8.0, 4.0, 6.0, -5.0, 4.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[0].a), uvec3(3u, 4u, 1u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[0]), vec2(6.0, 2.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[1]), vec2(-7.0, 6.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[2]), vec2(7.0, 1.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[3]), vec2(1.0, -2.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[0].c), vec4(-2.0, 6.0, 3.0, 8.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[1].a), uvec3(4u, 4u, 1u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[0]), vec2(5.0, 7.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[1]), vec2(-8.0, 0.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[2]), vec2(8.0, 5.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[3]), vec2(2.0, -8.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[1].c), vec4(-8.0, -6.0, -6.0, -6.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[2].a), uvec3(1u, 9u, 3u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[0]), vec2(5.0, -6.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[1]), vec2(-8.0, 4.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[2]), vec2(-6.0, 6.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[3]), vec2(-7.0, 0.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[2].c), vec4(9.0, -3.0, -9.0, 8.0)) && allOk;
	allOk = compare_int((block[1].t[0].c), 1) && allOk;
	allOk = compare_uint((block[2].u), 0u) && allOk;
	allOk = compare_mat4x3(block[2].t[0].a, mat4x3(8.0, -8.0, 7.0, 1.0, -9.0, -2.0, 7.0, 3.0, -1.0, 6.0, 1.0, -5.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[0].a), uvec3(5u, 6u, 9u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[0]), vec2(1.0, -9.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[1]), vec2(2.0, 7.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[2]), vec2(5.0, -1.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[3]), vec2(3.0, -4.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[0].c), vec4(-5.0, 4.0, 0.0, -8.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[1].a), uvec3(7u, 8u, 0u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[0]), vec2(-9.0, -3.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[1]), vec2(1.0, -4.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[2]), vec2(-8.0, -5.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[3]), vec2(-3.0, 3.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[1].c), vec4(8.0, -4.0, 9.0, -6.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[2].a), uvec3(0u, 8u, 9u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[0]), vec2(2.0, 3.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[1]), vec2(4.0, 2.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[2]), vec2(-7.0, 2.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[3]), vec2(6.0, -5.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[2].c), vec4(-1.0, -2.0, 6.0, 4.0)) && allOk;
	allOk = compare_int((block[2].t[0].c), 5) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (uvec3(3u, 0u, 0u));
	block[0].s.b[0] = (vec2(5.0, 3.0));
	block[0].s.b[1] = (vec2(-9.0, -1.0));
	block[0].s.b[2] = (vec2(5.0, 9.0));
	block[0].s.b[3] = (vec2(-5.0, 5.0));
	block[0].s.c = (vec4(7.0, -1.0, -8.0, -6.0));
	block[0].u = (6u);
	block[1].s.a = (uvec3(3u, 9u, 9u));
	block[1].s.b[0] = (vec2(1.0, -8.0));
	block[1].s.b[1] = (vec2(-2.0, -7.0));
	block[1].s.b[2] = (vec2(5.0, 6.0));
	block[1].s.b[3] = (vec2(-6.0, 5.0));
	block[1].s.c = (vec4(-1.0, 7.0, -4.0, 4.0));
	block[1].u = (7u);
	block[2].s.a = (uvec3(0u, 6u, 8u));
	block[2].s.b[0] = (vec2(2.0, -3.0));
	block[2].s.b[1] = (vec2(-1.0, -1.0));
	block[2].s.b[2] = (vec2(-5.0, -7.0));
	block[2].s.b[3] = (vec2(-2.0, 1.0));
	block[2].s.c = (vec4(-8.0, 0.0, 4.0, 8.0));
	block[2].u = (8u);
}
#version 450
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

layout(std430, row_major, binding = 1) buffer Block
{
	highp mat2x4 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block[0].var[0][0], -8.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -3.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 6.0) && allOk;
	allOk = compare_float(block[0].var[0][3], -5.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 2.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -3.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -5.0) && allOk;
	allOk = compare_float(block[0].var[1][3], -8.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(-8.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(2.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], -2.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 8.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 0.0) && allOk;
	allOk = compare_float(block[1].var[0][3], 5.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -6.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 9.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 2.0) && allOk;
	allOk = compare_float(block[1].var[1][3], -1.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(-2.0, 8.0, 0.0, 5.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(-6.0, 9.0, 2.0, -1.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 1.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -1.0) && allOk;
	allOk = compare_float(block[2].var[0][2], -5.0) && allOk;
	allOk = compare_float(block[2].var[0][3], 4.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -7.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -3.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 8.0) && allOk;
	allOk = compare_float(block[2].var[1][3], 0.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(1.0, -1.0, -5.0, 4.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(-7.0, -3.0, 8.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat2x4(-2.0, 3.0, 2.0, -4.0, 2.0, -2.0, 9.0, -4.0));
	block[1].var = (mat2x4(0.0, 7.0, 4.0, -8.0, 6.0, 0.0, -1.0, -8.0));
	block[2].var = (mat2x4(2.0, 8.0, 2.0, 4.0, 5.0, 4.0, -3.0, 4.0));
}
#version 450
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
	highp ivec4 var;
} block[3];

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((block[0].padding), -7) && allOk;
	allOk = compare_ivec4((block[0].var), ivec4(9, -5, 6, 3)) && allOk;
	allOk = compare_int((block[1].padding), 4) && allOk;
	allOk = compare_ivec4((block[1].var), ivec4(2, -3, -3, -3)) && allOk;
	allOk = compare_int((block[2].padding), -5) && allOk;
	allOk = compare_ivec4((block[2].var), ivec4(-5, 3, -5, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (5);
	block[0].var = (ivec4(-9, 5, -6, -2));
	block[1].padding = (-4);
	block[1].var = (ivec4(1, -9, 7, 3));
	block[2].padding = (6);
	block[2].var = (ivec4(8, 6, -4, 6));
}
#version 450
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
	highp mat4x3 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), 5.0) && allOk;
	allOk = compare_float(block[0].var[0][0], 0.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 3.0) && allOk;
	allOk = compare_float(block[0].var[0][2], -5.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 9.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -6.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 8.0) && allOk;
	allOk = compare_float(block[0].var[2][0], -6.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 6.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 2.0) && allOk;
	allOk = compare_float(block[0].var[3][0], 6.0) && allOk;
	allOk = compare_float(block[0].var[3][1], 7.0) && allOk;
	allOk = compare_float(block[0].var[3][2], 1.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(0.0, 3.0, -5.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(9.0, -6.0, 8.0)) && allOk;
	allOk = compare_vec3(block[0].var[2], vec3(-6.0, 6.0, 2.0)) && allOk;
	allOk = compare_vec3(block[0].var[3], vec3(6.0, 7.0, 1.0)) && allOk;
	allOk = compare_float((block[1].padding), 7.0) && allOk;
	allOk = compare_float(block[1].var[0][0], 3.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 4.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 6.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 2.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -7.0) && allOk;
	allOk = compare_float(block[1].var[1][2], -9.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -6.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 1.0) && allOk;
	allOk = compare_float(block[1].var[2][2], 4.0) && allOk;
	allOk = compare_float(block[1].var[3][0], -5.0) && allOk;
	allOk = compare_float(block[1].var[3][1], 4.0) && allOk;
	allOk = compare_float(block[1].var[3][2], -7.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(3.0, 4.0, 6.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(2.0, -7.0, -9.0)) && allOk;
	allOk = compare_vec3(block[1].var[2], vec3(-6.0, 1.0, 4.0)) && allOk;
	allOk = compare_vec3(block[1].var[3], vec3(-5.0, 4.0, -7.0)) && allOk;
	allOk = compare_float((block[2].padding), -2.0) && allOk;
	allOk = compare_float(block[2].var[0][0], 5.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -7.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 6.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 7.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 1.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -4.0) && allOk;
	allOk = compare_float(block[2].var[2][0], -7.0) && allOk;
	allOk = compare_float(block[2].var[2][1], -6.0) && allOk;
	allOk = compare_float(block[2].var[2][2], 2.0) && allOk;
	allOk = compare_float(block[2].var[3][0], 8.0) && allOk;
	allOk = compare_float(block[2].var[3][1], 0.0) && allOk;
	allOk = compare_float(block[2].var[3][2], -3.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(5.0, -7.0, 6.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(7.0, 1.0, -4.0)) && allOk;
	allOk = compare_vec3(block[2].var[2], vec3(-7.0, -6.0, 2.0)) && allOk;
	allOk = compare_vec3(block[2].var[3], vec3(8.0, 0.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (6.0);
	block[0].var = (mat4x3(-7.0, 0.0, 3.0, -1.0, -9.0, -7.0, -5.0, 8.0, 0.0, 1.0, 5.0, 7.0));
	block[1].padding = (1.0);
	block[1].var = (mat4x3(5.0, 7.0, -8.0, 4.0, 2.0, -8.0, -8.0, 3.0, -6.0, -5.0, 5.0, -7.0));
	block[2].padding = (8.0);
	block[2].var = (mat4x3(-7.0, -3.0, -4.0, -9.0, -9.0, -6.0, 5.0, -8.0, 1.0, -2.0, 3.0, -2.0));
}
#version 450
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
	allOk = compare_float((blockA[0].a), -5.0) && allOk;
	allOk = compare_float((blockA[1].a), 7.0) && allOk;
	allOk = compare_float((blockA[2].a), -2.0) && allOk;
	allOk = compare_uint((blockB[0].b.a), 8u) && allOk;
	allOk = compare_mat3(blockB[0].b.b.a, mat3(3.0, -7.0, 0.0, 5.0, -3.0, 6.0, -6.0, -7.0, -5.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[0]), ivec2(-8, 6)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[1]), ivec2(7, -3)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[2]), ivec2(-7, 0)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[3]), ivec2(6, -5)) && allOk;
	allOk = compare_vec4((blockB[0].b.b.c), vec4(-9.0, 0.0, -8.0, -1.0)) && allOk;
	allOk = compare_bvec4((blockB[0].b.c), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bool((blockB[0].d), true) && allOk;
	allOk = compare_uint((blockB[1].b.a), 0u) && allOk;
	allOk = compare_mat3(blockB[1].b.b.a, mat3(6.0, 7.0, -9.0, -1.0, 3.0, -3.0, -9.0, -8.0, 0.0)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[0]), ivec2(-7, 4)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[1]), ivec2(0, 1)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[2]), ivec2(7, -3)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[3]), ivec2(-2, -4)) && allOk;
	allOk = compare_vec4((blockB[1].b.b.c), vec4(5.0, 9.0, 4.0, -2.0)) && allOk;
	allOk = compare_bvec4((blockB[1].b.c), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bool((blockB[1].d), true) && allOk;
	allOk = compare_uint((blockB[2].b.a), 5u) && allOk;
	allOk = compare_mat3(blockB[2].b.b.a, mat3(-2.0, -2.0, -5.0, 0.0, 8.0, -5.0, 1.0, 0.0, -4.0)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[0]), ivec2(5, -9)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[1]), ivec2(3, 5)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[2]), ivec2(6, -7)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[3]), ivec2(2, 2)) && allOk;
	allOk = compare_vec4((blockB[2].b.b.c), vec4(1.0, -5.0, -9.0, 1.0)) && allOk;
	allOk = compare_bvec4((blockB[2].b.c), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bool((blockB[2].d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (3.0);
	blockA[0].b.a[0] = (vec3(-4.0, 1.0, 7.0));
	blockA[0].b.a[1] = (vec3(-2.0, 8.0, -4.0));
	blockA[0].b.a[2] = (vec3(-3.0, 2.0, -3.0));
	blockA[0].b.b[0] = (ivec2(-9, 7));
	blockA[0].b.b[1] = (ivec2(5, -5));
	blockA[0].b.b[2] = (ivec2(3, 0));
	blockA[0].b.b[3] = (ivec2(-9, 3));
	blockA[0].b.c = (vec4(8.0, 8.0, -7.0, -3.0));
	blockA[1].a = (0.0);
	blockA[1].b.a[0] = (vec3(-1.0, -5.0, 7.0));
	blockA[1].b.a[1] = (vec3(3.0, 2.0, -6.0));
	blockA[1].b.a[2] = (vec3(8.0, 7.0, 8.0));
	blockA[1].b.b[0] = (ivec2(-7, 8));
	blockA[1].b.b[1] = (ivec2(-1, 0));
	blockA[1].b.b[2] = (ivec2(7, 2));
	blockA[1].b.b[3] = (ivec2(2, -3));
	blockA[1].b.c = (vec4(-7.0, 7.0, 3.0, 8.0));
	blockA[2].a = (-6.0);
	blockA[2].b.a[0] = (vec3(-7.0, 7.0, 5.0));
	blockA[2].b.a[1] = (vec3(-6.0, 7.0, -3.0));
	blockA[2].b.a[2] = (vec3(6.0, 0.0, -6.0));
	blockA[2].b.b[0] = (ivec2(-3, -3));
	blockA[2].b.b[1] = (ivec2(7, -4));
	blockA[2].b.b[2] = (ivec2(5, -2));
	blockA[2].b.b[3] = (ivec2(3, -3));
	blockA[2].b.c = (vec4(7.0, 2.0, -4.0, 4.0));
	blockB[0].a[0] = (vec2(-4.0, 9.0));
	blockB[0].a[1] = (vec2(0.0, -7.0));
	blockB[0].b.a = (0u);
	blockB[0].b.b.a[0] = (vec3(0.0, 7.0, -6.0));
	blockB[0].b.b.a[1] = (vec3(5.0, -5.0, 4.0));
	blockB[0].b.b.a[2] = (vec3(-5.0, -5.0, 7.0));
	blockB[0].b.b.b[0] = (ivec2(5, -1));
	blockB[0].b.b.b[1] = (ivec2(3, -9));
	blockB[0].b.b.b[2] = (ivec2(0, 7));
	blockB[0].b.b.b[3] = (ivec2(-3, 8));
	blockB[0].b.b.c = (vec4(-3.0, -9.0, -2.0, 1.0));
	blockB[0].b.c = (bvec4(false, true, false, true));
	blockB[0].d = (false);
	blockB[1].a[0] = (vec2(8.0, 5.0));
	blockB[1].a[1] = (vec2(9.0, 4.0));
	blockB[1].b.a = (7u);
	blockB[1].b.b.a[0] = (vec3(-4.0, 9.0, -4.0));
	blockB[1].b.b.a[1] = (vec3(4.0, -7.0, 2.0));
	blockB[1].b.b.a[2] = (vec3(-6.0, 9.0, 6.0));
	blockB[1].b.b.b[0] = (ivec2(-1, -9));
	blockB[1].b.b.b[1] = (ivec2(-4, 8));
	blockB[1].b.b.b[2] = (ivec2(3, 6));
	blockB[1].b.b.b[3] = (ivec2(-7, -5));
	blockB[1].b.b.c = (vec4(-8.0, 7.0, -7.0, 5.0));
	blockB[1].b.c = (bvec4(false, false, false, false));
	blockB[1].d = (false);
	blockB[2].a[0] = (vec2(8.0, -7.0));
	blockB[2].a[1] = (vec2(7.0, -6.0));
	blockB[2].b.a = (0u);
	blockB[2].b.b.a[0] = (vec3(-1.0, 2.0, 2.0));
	blockB[2].b.b.a[1] = (vec3(4.0, 9.0, -9.0));
	blockB[2].b.b.a[2] = (vec3(1.0, 1.0, 7.0));
	blockB[2].b.b.b[0] = (ivec2(5, -8));
	blockB[2].b.b.b[1] = (ivec2(-7, -8));
	blockB[2].b.b.b[2] = (ivec2(6, 6));
	blockB[2].b.b.b[3] = (ivec2(5, 7));
	blockB[2].b.b.c = (vec4(5.0, 5.0, 3.0, 3.0));
	blockB[2].b.c = (bvec4(false, true, false, false));
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

struct sA
{
	mediump vec3 mA;
	highp vec3 mB;
};
struct sB
{
	highp mat4 mA;
	highp int mB;
};
layout(std430, binding = 1) buffer BlockB
{
	sA a;
	sB b;
	mediump uvec4 c;
	lowp ivec3 d[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((a.mA), vec3(4.0, 4.0, -4.0)) && allOk;
	allOk = compare_vec3((a.mB), vec3(7.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat4(b.mA, mat4(9.0, 3.0, -5.0, -8.0, -6.0, 0.0, 7.0, -1.0, -1.0, 6.0, -5.0, 5.0, -6.0, 5.0, -7.0, -4.0)) && allOk;
	allOk = compare_int((b.mB), -7) && allOk;
	allOk = compare_uvec4((c), uvec4(0u, 6u, 6u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	b.mA = (mat4(4.0, 6.0, -5.0, -5.0, -7.0, 5.0, 2.0, -4.0, -8.0, 0.0, 9.0, 3.0, 1.0, -6.0, 4.0, -4.0));
	b.mB = (-6);
}
#version 450
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
	highp ivec4 a;
	bool b;
	mediump mat3x2 c;
	lowp mat4x3 d;
	lowp uvec3 e[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((a), ivec4(-4, 4, -6, -2)) && allOk;
	allOk = compare_mat3x2(c, mat3x2(-2.0, 6.0, 3.0, 2.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4x3(d, mat4x3(-4.0, -6.0, -3.0, -1.0, 4.0, 8.0, -1.0, 6.0, 5.0, -8.0, -6.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	c = (mat3x2(-7.0, 9.0, -9.0, 8.0, 0.0, -8.0));
	d = (mat4x3(-9.0, 5.0, 4.0, -2.0, -5.0, 5.0, -6.0, 3.0, -5.0, 0.0, -9.0, 3.0));
	e[0] = (uvec3(9u, 1u, 6u));
	e[1] = (uvec3(3u, 6u, 5u));
	e[2] = (uvec3(5u, 6u, 5u));
	e[3] = (uvec3(2u, 3u, 4u));
}
#version 450
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
	highp float a;
	highp int b;
	bool c;
	uint16_t d;
	float16_t e;
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	bool f;
	lowp uint g;
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	float16_t h;
	float16_t i;
} blockD;
layout(std430, binding = 4) buffer BlockE
{
	bool j;
	float16_t k;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a), 0.0) && allOk;
	allOk = compare_int((blockB.b), 2) && allOk;
	allOk = compare_bool((blockB.c), false) && allOk;
	allOk = compare_uint((blockC.g), 5u) && allOk;
	allOk = compare_float16_t(float(blockD.h), 1.0) && allOk;
	allOk = compare_float16_t(float(blockE.k), 4.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (6.0);
	blockB.b = (-1);
	blockB.d = uint16_t(7u);
	blockB.e = float16_t(6.0);
	blockC.g = (2u);
	blockD.h = float16_t(-4.0);
	blockD.i = float16_t(-6.0);
	blockE.k = float16_t(5.0);
}
#version 450
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
	lowp ivec3 a[1];
	f16vec3 b;
	lowp uvec4 c;
	lowp ivec2 d;
	i16vec4 e[];
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	lowp uvec2 f;
	float16_t g[];
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	lowp uvec4 h;
	highp uvec4 i;
	lowp uvec3 j;
	f16vec4 k;
	lowp mat2x3 l[];
};
layout(std430, column_major, binding = 4) buffer BlockE
{
	int16_t m;
	mediump mat2x3 n[1];
	bvec2 o[1];
	lowp mat3x4 p;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(e[0]), ivec4(2, 3, 3, 3)) && allOk;
	allOk = compare_uvec2((blockC.f), uvec2(4u, 5u)) && allOk;
	allOk = compare_float16_t(float(blockC.g[0]), -2.0) && allOk;
	allOk = compare_uvec4((i), uvec4(3u, 6u, 1u, 9u)) && allOk;
	allOk = compare_uvec3((j), uvec3(6u, 2u, 6u)) && allOk;
	allOk = compare_mat2x3(l[0], mat2x3(6.0, -9.0, -2.0, -2.0, 1.0, 7.0)) && allOk;
	allOk = compare_bvec2((blockE.o[0]), bvec2(true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (ivec3(5, -5, 3));
	b = f16vec3(vec3(9.0, -5.0, -5.0));
	e[0] = i16vec4(ivec4(-4, 8, 6, -3));
	blockC.g[0] = float16_t(-2.0);
	i = (uvec4(4u, 1u, 2u, 3u));
	j = (uvec3(9u, 4u, 2u));
	k = f16vec4(vec4(8.0, -8.0, 4.0, 6.0));
	blockE.m = int16_t(-1);
	blockE.n[0] = (mat2x3(-3.0, -8.0, -6.0, 3.0, 2.0, 7.0));
	blockE.p = (mat3x4(-9.0, 6.0, 2.0, -1.0, 2.0, -5.0, -8.0, -7.0, 8.0, -9.0, 2.0, -2.0));
}
#version 450
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
	bvec4 a[4];
	lowp mat2x3 b;
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	mediump uint c;
	highp mat3x2 d;
	mediump int e;
	mediump mat3 f;
	lowp mat4x2 g[];
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	lowp mat2 h;
	i16vec3 i;
	highp mat4x2 j;
	u16vec4 k;
	highp mat4x2 l[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB.b, mat2x3(1.0, 6.0, -9.0, 1.0, -8.0, 0.0)) && allOk;
	allOk = compare_uint((blockC.c), 4u) && allOk;
	allOk = compare_mat3(blockC.f, mat3(1.0, 0.0, 8.0, 0.0, 5.0, -7.0, 6.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x2(blockC.g[0], mat4x2(-7.0, 6.0, -8.0, 5.0, 1.0, -4.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4x2(blockC.g[1], mat4x2(-4.0, 0.0, 0.0, 8.0, -5.0, -1.0, -9.0, -9.0)) && allOk;
	allOk = compare_i16vec3(ivec3(i), ivec3(-9, 8, 9)) && allOk;
	allOk = compare_mat4x2(j, mat4x2(-6.0, -3.0, -4.0, 9.0, 9.0, 1.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(l[0], mat4x2(5.0, 4.0, 2.0, 3.0, 3.0, 2.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat4x2(l[1], mat4x2(7.0, 3.0, 2.0, 2.0, 3.0, -8.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4x2(l[2], mat4x2(-4.0, -6.0, 3.0, -5.0, 8.0, 3.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat4x2(l[3], mat4x2(6.0, -1.0, -7.0, -8.0, 8.0, -2.0, 8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (bvec4(true, true, true, false));
	blockB.a[1] = (bvec4(true, true, true, true));
	blockB.a[2] = (bvec4(true, false, true, true));
	blockB.a[3] = (bvec4(true, true, true, false));
	blockB.b = (mat2x3(7.0, 3.0, -8.0, 6.0, 9.0, 1.0));
	blockC.e = (5);
	blockC.f = (mat3(-4.0, -6.0, 0.0, -8.0, -2.0, 5.0, -8.0, 0.0, -6.0));
	blockC.g[0] = (mat4x2(9.0, 3.0, -2.0, 9.0, -1.0, 8.0, 4.0, 9.0));
	blockC.g[1] = (mat4x2(-5.0, 8.0, 0.0, 3.0, 8.0, 9.0, 3.0, -9.0));
	i = i16vec3(ivec3(-5, 6, 3));
	j = (mat4x2(-9.0, 6.0, 8.0, 1.0, -3.0, -2.0, -8.0, 1.0));
}
#version 450
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
	mediump vec3 mA;
};
struct sB
{
	sA mA;
	float16_t mB;
	bool mC;
	i16vec2 mD;
};
struct sC
{
	lowp mat2x3 mA;
};
struct sD
{
	sC mA;
	mediump mat3x2 mB;
};
layout(std430, binding = 1) buffer BlockB
{
	highp int a;
	bool b;
	lowp mat3 c;
	mediump vec4 d;
	lowp ivec3 e[];
} blockB[3];
layout(std140, row_major, binding = 2) buffer BlockC
{
	mediump mat4 f;
	u16vec3 g;
	sB h;
	mediump ivec2 i[][3];
};
layout(std140, column_major, binding = 3) buffer BlockD
{
	sD j;
	highp vec4 k;
	i16vec2 l;
	bool m[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB[0].b), false) && allOk;
	allOk = compare_bool((blockB[1].b), true) && allOk;
	allOk = compare_bool((blockB[2].b), false) && allOk;
	allOk = compare_vec3((h.mA.mA), vec3(2.0, -3.0, 8.0)) && allOk;
	allOk = compare_float16_t(float(h.mB), 0.0) && allOk;
	allOk = compare_bool((h.mC), false) && allOk;
	allOk = compare_i16vec2(ivec2(h.mD), ivec2(-2, -3)) && allOk;
	allOk = compare_ivec2((i[0][0]), ivec2(5, -9)) && allOk;
	allOk = compare_ivec2((i[0][1]), ivec2(-8, -9)) && allOk;
	allOk = compare_ivec2((i[0][2]), ivec2(6, -8)) && allOk;
	allOk = compare_ivec2((i[1][0]), ivec2(5, -6)) && allOk;
	allOk = compare_ivec2((i[1][1]), ivec2(-6, -2)) && allOk;
	allOk = compare_ivec2((i[1][2]), ivec2(-9, 9)) && allOk;
	allOk = compare_ivec2((i[2][0]), ivec2(1, -1)) && allOk;
	allOk = compare_ivec2((i[2][1]), ivec2(-5, -8)) && allOk;
	allOk = compare_ivec2((i[2][2]), ivec2(8, 7)) && allOk;
	allOk = compare_vec4((blockD.k), vec4(-3.0, 3.0, -7.0, -6.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD.l), ivec2(9, -2)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (false);
	blockB[0].d = (vec4(5.0, -1.0, -9.0, -4.0));
	blockB[1].b = (false);
	blockB[1].d = (vec4(1.0, 6.0, 7.0, -7.0));
	blockB[2].b = (false);
	blockB[2].d = (vec4(6.0, -8.0, -8.0, 8.0));
	f = (mat4(-6.0, 2.0, 6.0, -9.0, -9.0, 3.0, -1.0, 7.0, -7.0, -7.0, 7.0, -8.0, 1.0, -5.0, 5.0, -1.0));
	g = u16vec3(uvec3(1u, 6u, 6u));
	h.mA.mA = (vec3(-7.0, -4.0, 6.0));
	h.mB = float16_t(-2.0);
	h.mC = (false);
	h.mD = i16vec2(ivec2(7, 5));
	blockD.j.mA.mA = (mat2x3(-3.0, -6.0, 2.0, -7.0, 9.0, 5.0));
	blockD.j.mB = (mat3x2(-3.0, -2.0, 7.0, 4.0, -1.0, 9.0));
	blockD.k = (vec4(-5.0, 7.0, 7.0, -7.0));
	blockD.l = i16vec2(ivec2(-6, 4));
	blockD.m[0] = (false);
	blockD.m[1] = (true);
	blockD.m[2] = (false);
	blockD.m[3] = (false);
	blockD.m[4] = (true);
}
#version 450
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
	lowp mat2x3 a[6];
	bool b[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((b[0]), false) && allOk;
	allOk = compare_bool((b[1]), false) && allOk;
	allOk = compare_bool((b[2]), true) && allOk;
	allOk = compare_bool((b[3]), true) && allOk;
	allOk = compare_bool((b[4]), false) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (mat2x3(-3.0, -1.0, -1.0, -9.0, -1.0, -7.0));
	a[1] = (mat2x3(2.0, -3.0, 2.0, -3.0, 5.0, 2.0));
	a[2] = (mat2x3(4.0, 3.0, -7.0, 9.0, -6.0, -9.0));
	a[3] = (mat2x3(-4.0, 1.0, -2.0, 7.0, -2.0, -8.0));
	a[4] = (mat2x3(-2.0, -1.0, 2.0, 0.0, 2.0, -6.0));
	a[5] = (mat2x3(6.0, -4.0, 4.0, -3.0, -7.0, 7.0));
	b[0] = (false);
	b[1] = (false);
	b[2] = (false);
	b[3] = (true);
	b[4] = (true);
}
#version 450
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
	highp int b[];
};
layout(std430, column_major, binding = 2) buffer BlockC
{
	i16vec4 c;
	f16vec2 d;
	lowp uvec4 e;
	lowp ivec2 f[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((a), bvec2(true, true)) && allOk;
	allOk = compare_uvec4((blockC.e), uvec4(1u, 3u, 4u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec2(true, true));
	b[0] = (0);
	b[1] = (4);
	b[2] = (-5);
	blockC.d = f16vec2(vec2(1.0, -6.0));
}
#version 450
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
	layout(offset = 4) highp vec2 b;
	layout(offset = 16) bvec2 c;
	layout(offset = 24) i16vec4 d;
	layout(offset = 32) i16vec2 e;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) highp uvec3 f;
	layout(offset = 12) mediump uint g;
	layout(offset = 16) lowp ivec3 h;
	layout(offset = 28) lowp float i[1];
	layout(offset = 32) i16vec2 j;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) mediump int k;
	layout(offset = 4) u16vec2 l;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((b), vec2(6.0, 7.0)) && allOk;
	allOk = compare_i16vec4(ivec4(d), ivec4(-9, -4, 4, -5)) && allOk;
	allOk = compare_uint((blockC.g), 2u) && allOk;
	allOk = compare_ivec3((blockC.h), ivec3(-4, 9, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(blockC.j), ivec2(-5, 8)) && allOk;
	allOk = compare_int((k), 3) && allOk;
	allOk = compare_u16vec2(uvec2(l), uvec2(9u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = int16_t(1);
	b = (vec2(8.0, 5.0));
	c = (bvec2(true, true));
	e = i16vec2(ivec2(-8, 5));
	blockC.f = (uvec3(9u, 3u, 9u));
	blockC.g = (1u);
	blockC.h = (ivec3(9, -7, 6));
	blockC.i[0] = (5.0);
	blockC.j = i16vec2(ivec2(3, 9));
	k = (1);
}
#version 450
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
	layout(offset = 0) highp uvec4 a;
	layout(offset = 16) highp ivec4 b[1];
	layout(offset = 32) bvec2 c;
	layout(offset = 40) f16vec4 d;
	layout(offset = 48) uint16_t e;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a), uvec4(8u, 8u, 8u, 2u)) && allOk;
	allOk = compare_ivec4((blockB.b[0]), ivec4(2, 0, -3, 1)) && allOk;
	allOk = compare_bvec2((blockB.c), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.d = f16vec4(vec4(8.0, 9.0, 7.0, 5.0));
	blockB.e = uint16_t(3u);
}
#version 450
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
	layout(offset = 0) i16vec3 a;
} blockB[1];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) u16vec3 b;
	layout(offset = 16) lowp uvec4 c;
	layout(offset = 32) bvec4 d;
	layout(offset = 48) float16_t e;
	layout(offset = 52) f16vec2 f[1];
} blockC[3];
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) mediump uvec4 g;
	layout(offset = 16) highp vec4 h;
	layout(offset = 32) lowp int i;
	layout(offset = 36) u16vec4 j;
	layout(offset = 48) highp vec4 k;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(blockC[0].b), uvec3(6u, 8u, 5u)) && allOk;
	allOk = compare_uvec4((blockC[0].c), uvec4(2u, 2u, 5u, 6u)) && allOk;
	allOk = compare_bvec4((blockC[0].d), bvec4(false, true, true, false)) && allOk;
	allOk = compare_f16vec2(vec2(blockC[0].f[0]), vec2(-8.0, 4.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC[1].b), uvec3(6u, 1u, 7u)) && allOk;
	allOk = compare_uvec4((blockC[1].c), uvec4(9u, 5u, 5u, 0u)) && allOk;
	allOk = compare_bvec4((blockC[1].d), bvec4(true, false, true, true)) && allOk;
	allOk = compare_f16vec2(vec2(blockC[1].f[0]), vec2(-8.0, 6.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC[2].b), uvec3(5u, 8u, 8u)) && allOk;
	allOk = compare_uvec4((blockC[2].c), uvec4(5u, 5u, 2u, 8u)) && allOk;
	allOk = compare_bvec4((blockC[2].d), bvec4(true, false, false, true)) && allOk;
	allOk = compare_f16vec2(vec2(blockC[2].f[0]), vec2(6.0, -9.0)) && allOk;
	allOk = compare_uvec4((blockD.g), uvec4(0u, 4u, 0u, 5u)) && allOk;
	allOk = compare_vec4((blockD.h), vec4(1.0, -1.0, 7.0, 9.0)) && allOk;
	allOk = compare_int((blockD.i), 7) && allOk;
	allOk = compare_u16vec4(uvec4(blockD.j), uvec4(4u, 4u, 9u, 6u)) && allOk;
	allOk = compare_vec4((blockD.k), vec4(-5.0, -1.0, -2.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = i16vec3(ivec3(1, 7, -6));
	blockC[0].b = u16vec3(uvec3(0u, 5u, 8u));
	blockC[0].c = (uvec4(3u, 4u, 3u, 2u));
	blockC[0].d = (bvec4(true, false, true, true));
	blockC[0].e = float16_t(-7.0);
	blockC[0].f[0] = f16vec2(vec2(4.0, -5.0));
	blockC[1].b = u16vec3(uvec3(5u, 2u, 5u));
	blockC[1].c = (uvec4(4u, 4u, 5u, 3u));
	blockC[1].d = (bvec4(true, false, true, false));
	blockC[1].e = float16_t(7.0);
	blockC[1].f[0] = f16vec2(vec2(-8.0, 3.0));
	blockC[2].b = u16vec3(uvec3(4u, 4u, 6u));
	blockC[2].c = (uvec4(6u, 1u, 4u, 3u));
	blockC[2].d = (bvec4(false, true, false, true));
	blockC[2].e = float16_t(-1.0);
	blockC[2].f[0] = f16vec2(vec2(5.0, 7.0));
	blockD.g = (uvec4(4u, 4u, 7u, 5u));
	blockD.h = (vec4(-6.0, 4.0, -1.0, -8.0));
	blockD.i = (-3);
	blockD.j = u16vec4(uvec4(6u, 8u, 7u, 3u));
	blockD.k = (vec4(6.0, -9.0, 1.0, 9.0));
}
#version 450
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
	lowp mat3x2 mA;
	highp uvec3 mB;
	lowp uvec4 mC;
};
struct sB
{
	float16_t mA;
	u16vec2 mB;
};
struct sC
{
	float16_t mA;
	i16vec4 mB;
	mediump mat2 mC;
	sB mD;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	u16vec4 a;
	highp float b;
	sA c;
	lowp mat3 d[];
} blockB;
layout(scalar, row_major, binding = 2) readonly buffer BlockC
{
	highp uvec3 e[];
} blockC;
layout(scalar, row_major, binding = 3) buffer BlockD
{
	lowp mat3 f;
	f16vec3 g;
	sC h;
	u16vec4 i;
	mediump uvec4 j[][5];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.c.mA, mat3x2(-7.0, 1.0, 2.0, 8.0, 7.0, 9.0)) && allOk;
	allOk = compare_uvec3((blockB.c.mB), uvec3(0u, 7u, 2u)) && allOk;
	allOk = compare_uvec4((blockB.c.mC), uvec4(5u, 6u, 4u, 1u)) && allOk;
	allOk = compare_mat3(blockB.d[0], mat3(-3.0, 7.0, 4.0, -2.0, 9.0, 2.0, -5.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3(blockB.d[1], mat3(8.0, 5.0, 5.0, -3.0, 3.0, 1.0, -9.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat3(blockB.d[2], mat3(2.0, 9.0, -3.0, 3.0, 1.0, 1.0, -9.0, -3.0, -9.0)) && allOk;
	allOk = compare_uvec3((blockC.e[0]), uvec3(6u, 1u, 6u)) && allOk;
	allOk = compare_uvec3((blockC.e[1]), uvec3(7u, 9u, 8u)) && allOk;
	allOk = compare_uvec3((blockC.e[2]), uvec3(7u, 3u, 0u)) && allOk;
	allOk = compare_uvec3((blockC.e[3]), uvec3(4u, 6u, 7u)) && allOk;
	allOk = compare_f16vec3(vec3(g), vec3(-2.0, -4.0, 7.0)) && allOk;
	allOk = compare_u16vec4(uvec4(i), uvec4(4u, 5u, 2u, 3u)) && allOk;
	allOk = compare_uvec4((j[0][0]), uvec4(4u, 3u, 7u, 5u)) && allOk;
	allOk = compare_uvec4((j[0][1]), uvec4(4u, 1u, 5u, 2u)) && allOk;
	allOk = compare_uvec4((j[0][2]), uvec4(0u, 9u, 1u, 4u)) && allOk;
	allOk = compare_uvec4((j[0][3]), uvec4(9u, 2u, 8u, 9u)) && allOk;
	allOk = compare_uvec4((j[0][4]), uvec4(5u, 4u, 9u, 0u)) && allOk;
	allOk = compare_uvec4((j[1][0]), uvec4(3u, 7u, 5u, 4u)) && allOk;
	allOk = compare_uvec4((j[1][1]), uvec4(3u, 5u, 7u, 8u)) && allOk;
	allOk = compare_uvec4((j[1][2]), uvec4(6u, 9u, 9u, 5u)) && allOk;
	allOk = compare_uvec4((j[1][3]), uvec4(9u, 1u, 3u, 7u)) && allOk;
	allOk = compare_uvec4((j[1][4]), uvec4(2u, 5u, 0u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec4(uvec4(5u, 2u, 5u, 7u));
	blockB.b = (-8.0);
	blockB.c.mA = (mat3x2(-5.0, 0.0, 0.0, -7.0, 5.0, 3.0));
	blockB.c.mB = (uvec3(5u, 2u, 0u));
	blockB.c.mC = (uvec4(2u, 7u, 3u, 6u));
	blockB.d[0] = (mat3(8.0, -6.0, 5.0, 1.0, 7.0, -1.0, -9.0, -2.0, -7.0));
	blockB.d[1] = (mat3(-5.0, 7.0, -9.0, -5.0, 5.0, 3.0, 7.0, -7.0, -6.0));
	blockB.d[2] = (mat3(1.0, 8.0, 8.0, -9.0, -8.0, 4.0, 8.0, 5.0, 3.0));
	f = (mat3(-5.0, -6.0, -4.0, -5.0, -3.0, -7.0, -8.0, -6.0, 7.0));
	g = f16vec3(vec3(6.0, 9.0, -9.0));
	i = u16vec4(uvec4(3u, 6u, 9u, 1u));
}
#version 450
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
	highp float mA;
	bvec4 mB;
	lowp ivec3 mC;
	mediump uvec2 mD;
};
struct sB
{
	u16vec2 mA;
	mediump ivec3 mB;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	u16vec4 a;
	sA b[];
};
layout(scalar, binding = 2) readonly buffer BlockC
{
	mediump uint c[];
};
layout(scalar, binding = 3) buffer BlockD
{
	f16vec4 d;
	mediump mat3 e[3];
	uint16_t f[][5];
};
layout(scalar, column_major, binding = 4) buffer BlockE
{
	f16vec4 g[3];
	f16vec2 h;
	f16vec4 i;
	sB j;
	f16vec2 k[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((b[0].mA), -6.0) && allOk;
	allOk = compare_bvec4((b[0].mB), bvec4(false, true, true, false)) && allOk;
	allOk = compare_ivec3((b[0].mC), ivec3(8, -7, 5)) && allOk;
	allOk = compare_uvec2((b[0].mD), uvec2(4u, 4u)) && allOk;
	allOk = compare_uint((c[0]), 6u) && allOk;
	allOk = compare_uint((c[1]), 7u) && allOk;
	allOk = compare_uint((c[2]), 6u) && allOk;
	allOk = compare_uint((c[3]), 9u) && allOk;
	allOk = compare_uint((c[4]), 0u) && allOk;
	allOk = compare_uint((c[5]), 1u) && allOk;
	allOk = compare_uint((c[6]), 4u) && allOk;
	allOk = compare_uint((c[7]), 5u) && allOk;
	allOk = compare_f16vec4(vec4(d), vec4(2.0, 1.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat3(e[0], mat3(-6.0, -5.0, 9.0, -4.0, -1.0, -6.0, 3.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat3(e[1], mat3(-5.0, -3.0, -8.0, 2.0, 9.0, 4.0, 7.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat3(e[2], mat3(4.0, 1.0, -5.0, -6.0, 8.0, -2.0, -5.0, 6.0, -7.0)) && allOk;
	allOk = compare_uint16_t(uint(f[0][0]), 7u) && allOk;
	allOk = compare_uint16_t(uint(f[0][1]), 0u) && allOk;
	allOk = compare_uint16_t(uint(f[0][2]), 4u) && allOk;
	allOk = compare_uint16_t(uint(f[0][3]), 5u) && allOk;
	allOk = compare_uint16_t(uint(f[0][4]), 3u) && allOk;
	allOk = compare_uint16_t(uint(f[1][0]), 6u) && allOk;
	allOk = compare_uint16_t(uint(f[1][1]), 7u) && allOk;
	allOk = compare_uint16_t(uint(f[1][2]), 0u) && allOk;
	allOk = compare_uint16_t(uint(f[1][3]), 5u) && allOk;
	allOk = compare_uint16_t(uint(f[1][4]), 5u) && allOk;
	allOk = compare_f16vec4(vec4(g[0]), vec4(6.0, -5.0, -8.0, -5.0)) && allOk;
	allOk = compare_f16vec4(vec4(g[1]), vec4(4.0, -9.0, -6.0, -1.0)) && allOk;
	allOk = compare_f16vec4(vec4(g[2]), vec4(-4.0, -8.0, 5.0, -2.0)) && allOk;
	allOk = compare_f16vec2(vec2(h), vec2(-9.0, 1.0)) && allOk;
	allOk = compare_f16vec4(vec4(i), vec4(1.0, 6.0, -9.0, 5.0)) && allOk;
	allOk = compare_f16vec2(vec2(k[0]), vec2(9.0, 2.0)) && allOk;
	allOk = compare_f16vec2(vec2(k[1]), vec2(-8.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = u16vec4(uvec4(3u, 6u, 9u, 9u));
	b[0].mA = (8.0);
	b[0].mB = (bvec4(true, true, true, true));
	b[0].mC = (ivec3(-5, 0, 8));
	b[0].mD = (uvec2(3u, 8u));
	d = f16vec4(vec4(-2.0, -1.0, 9.0, 1.0));
	e[0] = (mat3(2.0, -2.0, 3.0, 2.0, 0.0, 7.0, -2.0, -9.0, 9.0));
	e[1] = (mat3(-9.0, -4.0, -8.0, 0.0, 8.0, -9.0, -5.0, 2.0, -3.0));
	e[2] = (mat3(4.0, -2.0, -6.0, -3.0, -2.0, -6.0, -3.0, -9.0, 7.0));
	f[0][0] = uint16_t(1u);
	f[0][1] = uint16_t(2u);
	f[0][2] = uint16_t(9u);
	f[0][3] = uint16_t(2u);
	f[0][4] = uint16_t(5u);
	f[1][0] = uint16_t(6u);
	f[1][1] = uint16_t(8u);
	f[1][2] = uint16_t(0u);
	f[1][3] = uint16_t(7u);
	f[1][4] = uint16_t(7u);
	g[0] = f16vec4(vec4(1.0, 4.0, -9.0, -5.0));
	g[1] = f16vec4(vec4(7.0, 9.0, 4.0, -8.0));
	g[2] = f16vec4(vec4(2.0, -5.0, 4.0, -6.0));
	i = f16vec4(vec4(7.0, -2.0, -7.0, 7.0));
	j.mA = u16vec2(uvec2(0u, 6u));
	j.mB = (ivec3(-3, 3, -8));
}
#version 450
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
	lowp mat3x4 a;
	bool b;
	bvec3 c;
} blockB;
layout(std430, binding = 2) readonly buffer BlockC
{
	mediump mat4x3 d;
	uint8_t e;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(e), 2u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x4(-6.0, -2.0, 3.0, -5.0, -4.0, 5.0, -9.0, 8.0, 1.0, 9.0, 5.0, -4.0));
}
#version 450
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
	highp int b[1];
	mediump mat4 c;
	highp mat3x2 d;
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	u8vec2 e[1];
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
	allOk = compare_mat3x2(blockB.d, mat3x2(0.0, -1.0, -3.0, 0.0, -1.0, -7.0)) && allOk;
	allOk = compare_i8vec4(ivec4(f), ivec4(9, 4294967295, 4294967295, 6)) && allOk;
	allOk = compare_u8vec3(uvec3(g), uvec3(4u, 0u, 2u)) && allOk;
	allOk = compare_bvec4((h), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bvec3((l), bvec3(true, true, false)) && allOk;
	allOk = compare_i8vec4(ivec4(m), ivec4(4294967287, 6, 4294967292, 4294967295)) && allOk;
	allOk = compare_vec2((o), vec2(4.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = uint8_t(9u);
	blockB.b[0] = (0);
	blockB.c = (mat4(9.0, 4.0, 1.0, -7.0, -4.0, -4.0, -6.0, -5.0, -2.0, 4.0, -2.0, 5.0, -9.0, -3.0, -1.0, -9.0));
	blockB.d = (mat3x2(1.0, 1.0, 7.0, 8.0, 9.0, -7.0));
	e[0] = u8vec2(uvec2(5u, 9u));
	f = i8vec4(ivec4(5, 6, 5, 6));
	g = u8vec3(uvec3(1u, 8u, 3u));
	h = (bvec4(true, true, false, false));
	i = (bvec4(true, true, true, false));
	blockD.j = int8_t(4294967290);
	k = (uvec2(5u, 4u));
	n = (mat3x4(-9.0, -1.0, 8.0, 3.0, -6.0, 7.0, 0.0, 5.0, -9.0, 0.0, -2.0, -6.0));
	o = (vec2(-3.0, -7.0));
}
#version 450
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
	uint8_t c;
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	u8vec3 d;
	bool e;
	lowp uvec2 f;
	mediump mat4 g[];
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	highp mat2 h[4];
	int8_t i[];
};
layout(std430, binding = 4) buffer BlockE
{
	highp mat4x3 j;
	highp mat3x4 k;
	highp ivec3 l;
	i8vec4 m[];
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
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(blockC.d), uvec3(1u, 1u, 7u)) && allOk;
	allOk = compare_mat2(h[0], mat2(3.0, -3.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat2(h[1], mat2(-8.0, -3.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(h[2], mat2(3.0, 3.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat2(h[3], mat2(1.0, 9.0, -4.0, 4.0)) && allOk;
	allOk = compare_int8_t(int(i[0]), 8) && allOk;
	allOk = compare_int8_t(int(i[1]), 2) && allOk;
	allOk = compare_int8_t(int(i[2]), 3) && allOk;
	allOk = compare_int8_t(int(i[3]), 0) && allOk;
	allOk = compare_int8_t(int(i[4]), 4294967295) && allOk;
	allOk = compare_mat4x3(j, mat4x3(-9.0, -8.0, -2.0, 1.0, 1.0, -7.0, -9.0, -6.0, 4.0, 0.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat3x4(k, mat3x4(9.0, -1.0, -8.0, -9.0, -7.0, -2.0, -6.0, 0.0, 5.0, 8.0, 5.0, 5.0)) && allOk;
	allOk = compare_ivec3((l), ivec3(3, 2, -8)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (bvec2(true, false));
	blockC.d = u8vec3(uvec3(5u, 3u, 9u));
	blockC.e = (false);
	blockC.g[0] = (mat4(-6.0, 9.0, 4.0, -5.0, 5.0, -1.0, 4.0, -7.0, 5.0, -6.0, 4.0, -3.0, 9.0, 0.0, -8.0, 6.0));
	blockC.g[1] = (mat4(-8.0, -7.0, -2.0, 5.0, 1.0, 3.0, -3.0, -1.0, 1.0, -6.0, -5.0, -4.0, -2.0, 8.0, -7.0, 4.0));
	h[0] = (mat2(0.0, 7.0, 2.0, -4.0));
	h[1] = (mat2(1.0, 6.0, -2.0, 5.0));
	h[2] = (mat2(7.0, -9.0, -4.0, 7.0));
	h[3] = (mat2(-9.0, 7.0, 7.0, -8.0));
	i[0] = int8_t(5);
	i[1] = int8_t(4294967294);
	i[2] = int8_t(4294967293);
	i[3] = int8_t(4294967287);
	i[4] = int8_t(7);
	k = (mat3x4(8.0, -2.0, -6.0, 7.0, 1.0, 9.0, -1.0, -8.0, 1.0, 0.0, -2.0, -8.0));
	l = (ivec3(7, -6, -5));
	m[0] = i8vec4(ivec4(4294967290, 4294967289, 4294967291, 9));
	m[1] = i8vec4(ivec4(6, 8, 0, 1));
	m[2] = i8vec4(ivec4(0, 4294967289, 8, 5));
}
#version 450
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
	highp mat4x2 a;
	lowp mat4 b;
	mediump mat4x3 c;
	bvec3 d;
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	mediump vec2 e;
	lowp int f;
	mediump uvec2 g;
	u8vec4 h[];
};
layout(std140, row_major, binding = 3) buffer BlockD
{
	mediump mat3 i;
	i8vec2 j;
	bvec2 k;
} blockD[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.c, mat4x3(-1.0, -1.0, -5.0, 2.0, -6.0, 8.0, -7.0, -4.0, -7.0, -2.0, 2.0, 7.0)) && allOk;
	allOk = compare_vec2((e), vec2(-1.0, 5.0)) && allOk;
	allOk = compare_int((f), -9) && allOk;
	allOk = compare_u8vec4(uvec4(h[0]), uvec4(9u, 6u, 1u, 3u)) && allOk;
	allOk = compare_u8vec4(uvec4(h[1]), uvec4(9u, 6u, 5u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(h[2]), uvec4(2u, 3u, 0u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(h[3]), uvec4(4u, 0u, 2u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(h[4]), uvec4(8u, 6u, 6u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(h[5]), uvec4(4u, 0u, 2u, 3u)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD[0].j), ivec2(2, 2)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x2(-2.0, -9.0, -3.0, -1.0, -2.0, 7.0, -7.0, -6.0));
	blockB.b = (mat4(-5.0, -9.0, 4.0, -6.0, 2.0, 6.0, 4.0, 6.0, -5.0, 2.0, -9.0, -8.0, 3.0, 6.0, -6.0, 5.0));
	blockB.d = (bvec3(true, false, true));
	f = (-3);
	h[0] = u8vec4(uvec4(5u, 0u, 4u, 9u));
	h[1] = u8vec4(uvec4(7u, 3u, 4u, 1u));
	h[2] = u8vec4(uvec4(6u, 3u, 5u, 8u));
	h[3] = u8vec4(uvec4(2u, 5u, 5u, 2u));
	h[4] = u8vec4(uvec4(8u, 1u, 8u, 0u));
	h[5] = u8vec4(uvec4(5u, 4u, 0u, 6u));
	blockD[0].k = (bvec2(true, true));
}
#version 450
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
	highp mat3x2 a;
	lowp mat2x3 b;
	mediump vec4 c[6];
	highp vec4 d[];
} blockB[1];
layout(std430, binding = 2) buffer BlockC
{
	u8vec3 e;
	mediump mat2x3 f;
	lowp uint g;
	lowp uint h[2];
	lowp mat2 i[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

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
	allOk = compare_u8vec3(uvec3(blockC.e), uvec3(0u, 3u, 2u)) && allOk;
	allOk = compare_uint((blockC.h[0]), 8u) && allOk;
	allOk = compare_uint((blockC.h[1]), 6u) && allOk;
	allOk = compare_mat2(blockC.i[0], mat2(-5.0, -7.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat2(blockC.i[1], mat2(-6.0, 5.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat2(blockC.i[2], mat2(-5.0, 8.0, -6.0, -4.0)) && allOk;
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
	blockC.e = u8vec3(uvec3(1u, 3u, 9u));
	blockC.f = (mat2x3(5.0, -5.0, -2.0, 1.0, 8.0, -2.0));
	blockC.h[0] = (1u);
	blockC.h[1] = (8u);
	blockC.i[0] = (mat2(-8.0, -8.0, 6.0, 4.0));
	blockC.i[1] = (mat2(5.0, 8.0, 3.0, -1.0));
	blockC.i[2] = (mat2(1.0, 0.0, -9.0, -4.0));
}
#version 450
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
	highp uvec3 mA;
};
struct sB
{
	uint8_t mA[3];
	bvec2 mB;
	sA mC;
};
layout(std430, binding = 1) buffer BlockB
{
	highp uvec2 a;
	highp mat2x3 b;
	lowp mat3x4 c;
	bvec2 d;
};
layout(std140, row_major, binding = 2) readonly buffer BlockC
{
	mediump uvec3 e;
};
layout(std430, row_major, binding = 3) buffer BlockD
{
	mediump uvec3 f;
	highp uvec2 g;
	mediump vec3 h;
	lowp uvec2 i;
	highp mat3 j[];
} blockD[3];
layout(std430, column_major, binding = 4) buffer BlockE
{
	uint8_t k;
	highp mat2x3 l;
	sB m[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((a), uvec2(5u, 0u)) && allOk;
	allOk = compare_mat2x3(b, mat2x3(-7.0, 7.0, 6.0, 2.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(c, mat3x4(-4.0, 9.0, 7.0, 0.0, 4.0, -6.0, -1.0, -8.0, -8.0, 1.0, -5.0, 0.0)) && allOk;
	allOk = compare_uvec3((e), uvec3(7u, 9u, 3u)) && allOk;
	allOk = compare_vec3((blockD[0].h), vec3(8.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat3(blockD[0].j[0], mat3(6.0, 8.0, -1.0, -8.0, 8.0, 7.0, -7.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3(blockD[0].j[1], mat3(9.0, 1.0, 6.0, 4.0, -3.0, -5.0, -5.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3(blockD[0].j[2], mat3(-9.0, 8.0, 2.0, -1.0, -4.0, 6.0, 0.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3(blockD[0].j[3], mat3(7.0, -7.0, 3.0, -6.0, -2.0, 9.0, 4.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3(blockD[0].j[4], mat3(9.0, -3.0, 8.0, 0.0, 1.0, 9.0, -7.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat3(blockD[0].j[5], mat3(9.0, -5.0, 0.0, 9.0, -3.0, -2.0, 6.0, 4.0, 3.0)) && allOk;
	allOk = compare_vec3((blockD[1].h), vec3(-1.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3(blockD[1].j[0], mat3(-1.0, 9.0, 0.0, 8.0, 5.0, 8.0, 8.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3(blockD[1].j[1], mat3(-7.0, 3.0, 3.0, 7.0, 1.0, -6.0, 4.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat3(blockD[1].j[2], mat3(-4.0, 9.0, -8.0, 9.0, -9.0, -2.0, -1.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat3(blockD[1].j[3], mat3(2.0, 3.0, 9.0, -6.0, -9.0, 8.0, 4.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat3(blockD[1].j[4], mat3(8.0, 9.0, -7.0, 1.0, 5.0, 0.0, 3.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat3(blockD[1].j[5], mat3(5.0, -7.0, 4.0, 6.0, 9.0, -5.0, -7.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat3(blockD[1].j[6], mat3(-4.0, -9.0, 8.0, 9.0, -9.0, 8.0, 4.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3(blockD[1].j[7], mat3(3.0, 7.0, -2.0, -8.0, 1.0, -3.0, -2.0, 2.0, -3.0)) && allOk;
	allOk = compare_vec3((blockD[2].h), vec3(0.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat3(blockD[2].j[0], mat3(1.0, -1.0, -8.0, 6.0, 2.0, -2.0, -3.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat3(blockD[2].j[1], mat3(-6.0, -6.0, 2.0, 5.0, -3.0, -5.0, 7.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat3(blockD[2].j[2], mat3(3.0, -5.0, -2.0, -7.0, -2.0, -9.0, 8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat3(blockD[2].j[3], mat3(9.0, 8.0, -1.0, 2.0, -7.0, -5.0, -6.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat3(blockD[2].j[4], mat3(-9.0, -7.0, -1.0, 1.0, -2.0, -5.0, 8.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat3(blockD[2].j[5], mat3(-4.0, -5.0, -9.0, -9.0, 5.0, -8.0, 7.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3(blockD[2].j[6], mat3(-1.0, 1.0, -7.0, -8.0, -6.0, -5.0, 3.0, -5.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (uvec2(7u, 2u));
	b = (mat2x3(1.0, 3.0, 5.0, -9.0, 8.0, 2.0));
	d = (bvec2(true, true));
	blockD[0].g = (uvec2(3u, 8u));
	blockD[0].h = (vec3(-3.0, 5.0, -3.0));
	blockD[1].g = (uvec2(7u, 6u));
	blockD[1].h = (vec3(-9.0, -2.0, -8.0));
	blockD[2].g = (uvec2(0u, 7u));
	blockD[2].h = (vec3(2.0, 9.0, 4.0));
	blockE.k = uint8_t(3u);
}
#version 450
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
	i8vec2 mB[2];
	mediump vec2 mC;
	bvec3 mD;
};
struct sB
{
	sA mA;
};
layout(scalar, row_major, binding = 1) buffer BlockB
{
	sB a[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a[0].mA.mA), ivec3(4, -1, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.a[0].mA.mB[0]), ivec2(4294967289, 4)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.a[0].mA.mB[1]), ivec2(6, 4294967292)) && allOk;
	allOk = compare_vec2((blockB.a[0].mA.mC), vec2(-7.0, 2.0)) && allOk;
	allOk = compare_bvec3((blockB.a[0].mA.mD), bvec3(false, true, false)) && allOk;
	allOk = compare_ivec3((blockB.a[1].mA.mA), ivec3(6, 1, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.a[1].mA.mB[0]), ivec2(4294967295, 8)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.a[1].mA.mB[1]), ivec2(3, 9)) && allOk;
	allOk = compare_vec2((blockB.a[1].mA.mC), vec2(-2.0, 3.0)) && allOk;
	allOk = compare_bvec3((blockB.a[1].mA.mD), bvec3(false, false, true)) && allOk;
	allOk = compare_ivec3((blockB.a[2].mA.mA), ivec3(-6, -4, 2)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.a[2].mA.mB[0]), ivec2(4294967289, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.a[2].mA.mB[1]), ivec2(7, 4294967291)) && allOk;
	allOk = compare_vec2((blockB.a[2].mA.mC), vec2(3.0, 1.0)) && allOk;
	allOk = compare_bvec3((blockB.a[2].mA.mD), bvec3(true, true, true)) && allOk;
	allOk = compare_ivec3((blockB.a[3].mA.mA), ivec3(-9, 6, 8)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.a[3].mA.mB[0]), ivec2(4294967287, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.a[3].mA.mB[1]), ivec2(3, 4294967290)) && allOk;
	allOk = compare_vec2((blockB.a[3].mA.mC), vec2(5.0, 8.0)) && allOk;
	allOk = compare_bvec3((blockB.a[3].mA.mD), bvec3(false, true, false)) && allOk;
	allOk = compare_ivec3((blockB.a[4].mA.mA), ivec3(-9, -6, -5)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.a[4].mA.mB[0]), ivec2(4294967291, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.a[4].mA.mB[1]), ivec2(4294967292, 4294967291)) && allOk;
	allOk = compare_vec2((blockB.a[4].mA.mC), vec2(7.0, -7.0)) && allOk;
	allOk = compare_bvec3((blockB.a[4].mA.mD), bvec3(true, false, false)) && allOk;
	allOk = compare_ivec3((blockB.a[5].mA.mA), ivec3(-8, 7, -7)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.a[5].mA.mB[0]), ivec2(8, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.a[5].mA.mB[1]), ivec2(6, 4294967295)) && allOk;
	allOk = compare_vec2((blockB.a[5].mA.mC), vec2(6.0, -6.0)) && allOk;
	allOk = compare_bvec3((blockB.a[5].mA.mD), bvec3(true, false, false)) && allOk;
	allOk = compare_ivec3((blockB.a[6].mA.mA), ivec3(-1, -1, -2)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.a[6].mA.mB[0]), ivec2(4294967293, 4294967290)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.a[6].mA.mB[1]), ivec2(7, 6)) && allOk;
	allOk = compare_vec2((blockB.a[6].mA.mC), vec2(-6.0, 8.0)) && allOk;
	allOk = compare_bvec3((blockB.a[6].mA.mD), bvec3(false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0].mA.mA = (ivec3(5, 7, -9));
	blockB.a[0].mA.mB[0] = i8vec2(ivec2(2, 4294967295));
	blockB.a[0].mA.mB[1] = i8vec2(ivec2(4294967289, 3));
	blockB.a[0].mA.mC = (vec2(-1.0, 5.0));
	blockB.a[0].mA.mD = (bvec3(false, true, true));
	blockB.a[1].mA.mA = (ivec3(-6, 1, -2));
	blockB.a[1].mA.mB[0] = i8vec2(ivec2(4294967289, 4294967291));
	blockB.a[1].mA.mB[1] = i8vec2(ivec2(7, 5));
	blockB.a[1].mA.mC = (vec2(-4.0, 9.0));
	blockB.a[1].mA.mD = (bvec3(true, false, true));
	blockB.a[2].mA.mA = (ivec3(-1, -3, -9));
	blockB.a[2].mA.mB[0] = i8vec2(ivec2(5, 7));
	blockB.a[2].mA.mB[1] = i8vec2(ivec2(4294967293, 2));
	blockB.a[2].mA.mC = (vec2(-2.0, -5.0));
	blockB.a[2].mA.mD = (bvec3(false, false, false));
	blockB.a[3].mA.mA = (ivec3(-9, -2, -4));
	blockB.a[3].mA.mB[0] = i8vec2(ivec2(4294967294, 9));
	blockB.a[3].mA.mB[1] = i8vec2(ivec2(5, 7));
	blockB.a[3].mA.mC = (vec2(-8.0, -4.0));
	blockB.a[3].mA.mD = (bvec3(false, false, true));
	blockB.a[4].mA.mA = (ivec3(-4, 3, 4));
	blockB.a[4].mA.mB[0] = i8vec2(ivec2(4294967291, 9));
	blockB.a[4].mA.mB[1] = i8vec2(ivec2(4294967293, 8));
	blockB.a[4].mA.mC = (vec2(0.0, 8.0));
	blockB.a[4].mA.mD = (bvec3(false, false, false));
	blockB.a[5].mA.mA = (ivec3(9, 1, 2));
	blockB.a[5].mA.mB[0] = i8vec2(ivec2(4294967293, 7));
	blockB.a[5].mA.mB[1] = i8vec2(ivec2(4294967292, 4294967287));
	blockB.a[5].mA.mC = (vec2(2.0, 6.0));
	blockB.a[5].mA.mD = (bvec3(false, true, true));
	blockB.a[6].mA.mA = (ivec3(-6, 5, 9));
	blockB.a[6].mA.mB[0] = i8vec2(ivec2(4294967294, 9));
	blockB.a[6].mA.mB[1] = i8vec2(ivec2(7, 8));
	blockB.a[6].mA.mC = (vec2(3.0, -7.0));
	blockB.a[6].mA.mD = (bvec3(false, true, true));
}
#version 450
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
	mediump ivec2 var;
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((var), ivec2(-2, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp uvec3 var;
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((var), uvec3(9u, 0u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 7.0) && allOk;
	allOk = compare_float(var[0][1], -2.0) && allOk;
	allOk = compare_float(var[1][0], -3.0) && allOk;
	allOk = compare_float(var[1][1], 8.0) && allOk;
	allOk = compare_vec2(var[0], vec2(7.0, -2.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-3.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	allOk = compare_mat3x2(var, mat3x2(3.0, -5.0, -7.0, -2.0, 6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var, mat4x2(-7.0, 8.0, 6.0, 0.0, 0.0, 2.0, -4.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	highp mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var, mat4x3(-5.0, -4.0, 6.0, 4.0, 7.0, 4.0, 0.0, 1.0, 2.0, -3.0, 0.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp uvec4 var;
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((var), uvec4(0u, 2u, 6u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -2.0) && allOk;
	allOk = compare_float(var[0][1], -6.0) && allOk;
	allOk = compare_float(var[0][2], -3.0) && allOk;
	allOk = compare_float(var[1][0], -5.0) && allOk;
	allOk = compare_float(var[1][1], 2.0) && allOk;
	allOk = compare_float(var[1][2], 9.0) && allOk;
	allOk = compare_float(var[2][0], 4.0) && allOk;
	allOk = compare_float(var[2][1], 6.0) && allOk;
	allOk = compare_float(var[2][2], -8.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-2.0, -6.0, -3.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-5.0, 2.0, 9.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(4.0, 6.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float(var[0][0], 6.0) && allOk;
	allOk = compare_float(var[0][1], -5.0) && allOk;
	allOk = compare_float(var[0][2], 5.0) && allOk;
	allOk = compare_float(var[0][3], 2.0) && allOk;
	allOk = compare_float(var[1][0], -5.0) && allOk;
	allOk = compare_float(var[1][1], -9.0) && allOk;
	allOk = compare_float(var[1][2], -2.0) && allOk;
	allOk = compare_float(var[1][3], 2.0) && allOk;
	allOk = compare_vec4(var[0], vec4(6.0, -5.0, 5.0, 2.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-5.0, -9.0, -2.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat4x2(var, mat4x2(1.0, 1.0, 3.0, -2.0, -4.0, 2.0, -1.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat2x4(var, mat2x4(-7.0, 7.0, -4.0, -5.0, -3.0, 1.0, 0.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 8.0) && allOk;
	allOk = compare_mat3x2(var, mat3x2(-9.0, -5.0, 4.0, 9.0, -8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	float16_t padding;
	f16vec4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(padding), -8.0) && allOk;
	allOk = compare_f16vec4(vec4(var), vec4(-9.0, 9.0, -6.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std140, row_major, binding = 1) readonly buffer Block
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
	bvec2 var[3];
};

bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((var[0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[2]), bvec2(false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std430, row_major, binding = 1) readonly buffer Block
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

}
#version 450
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
	allOk = compare_mat4x2(var[0], mat4x2(4.0, -5.0, -2.0, 7.0, 3.0, 2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(-7.0, -1.0, -9.0, 4.0, -9.0, -4.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(-7.0, -7.0, 4.0, 6.0, 6.0, -6.0, -1.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat2x3 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0], mat2x3(-3.0, 6.0, -6.0, -6.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(8.0, 3.0, 1.0, 4.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(-7.0, -5.0, -8.0, -7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[3], mat2x3(3.0, 6.0, -5.0, 3.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[4], mat2x3(9.0, 2.0, 6.0, 8.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[5], mat2x3(-7.0, -2.0, -4.0, -2.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[6], mat2x3(6.0, 8.0, -4.0, -5.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[7], mat2x3(6.0, 6.0, -9.0, -2.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[8], mat2x3(5.0, -3.0, 6.0, 3.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[9], mat2x3(-9.0, -2.0, -3.0, -1.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[10], mat2x3(0.0, 2.0, -1.0, -4.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[11], mat2x3(-9.0, -7.0, 7.0, 0.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[12], mat2x3(-5.0, 3.0, -2.0, -8.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[13], mat2x3(1.0, -5.0, -5.0, -2.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[14], mat2x3(-2.0, 0.0, 7.0, 6.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[15], mat2x3(3.0, 9.0, 1.0, 3.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[16], mat2x3(-9.0, -2.0, 6.0, 8.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[17], mat2x3(5.0, -2.0, 0.0, 0.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[18], mat2x3(-2.0, -7.0, 9.0, 9.0, -5.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	uint8_t var[];
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(var[0]), 7u) && allOk;
	allOk = compare_uint8_t(uint(var[1]), 1u) && allOk;
	allOk = compare_uint8_t(uint(var[2]), 3u) && allOk;
	allOk = compare_uint8_t(uint(var[3]), 1u) && allOk;
	allOk = compare_uint8_t(uint(var[4]), 2u) && allOk;
	allOk = compare_uint8_t(uint(var[5]), 4u) && allOk;
	allOk = compare_uint8_t(uint(var[6]), 9u) && allOk;
	allOk = compare_uint8_t(uint(var[7]), 2u) && allOk;
	allOk = compare_uint8_t(uint(var[8]), 1u) && allOk;
	allOk = compare_uint8_t(uint(var[9]), 4u) && allOk;
	allOk = compare_uint8_t(uint(var[10]), 2u) && allOk;
	allOk = compare_uint8_t(uint(var[11]), 7u) && allOk;
	allOk = compare_uint8_t(uint(var[12]), 6u) && allOk;
	allOk = compare_uint8_t(uint(var[13]), 2u) && allOk;
	allOk = compare_uint8_t(uint(var[14]), 5u) && allOk;
	allOk = compare_uint8_t(uint(var[15]), 9u) && allOk;
	allOk = compare_uint8_t(uint(var[16]), 8u) && allOk;
	allOk = compare_uint8_t(uint(var[17]), 1u) && allOk;
	allOk = compare_uint8_t(uint(var[18]), 3u) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp int var[];
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((var[0]), 6) && allOk;
	allOk = compare_int((var[1]), 0) && allOk;
	allOk = compare_int((var[2]), 9) && allOk;
	allOk = compare_int((var[3]), -6) && allOk;
	allOk = compare_int((var[4]), -9) && allOk;
	allOk = compare_int((var[5]), -8) && allOk;
	allOk = compare_int((var[6]), 8) && allOk;
	allOk = compare_int((var[7]), -9) && allOk;
	allOk = compare_int((var[8]), -1) && allOk;
	allOk = compare_int((var[9]), 0) && allOk;
	allOk = compare_int((var[10]), -9) && allOk;
	allOk = compare_int((var[11]), 5) && allOk;
	allOk = compare_int((var[12]), 5) && allOk;
	allOk = compare_int((var[13]), -3) && allOk;
	allOk = compare_int((var[14]), 4) && allOk;
	allOk = compare_int((var[15]), 4) && allOk;
	allOk = compare_int((var[16]), -9) && allOk;
	allOk = compare_int((var[17]), -9) && allOk;
	allOk = compare_int((var[18]), 3) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3x2 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0], mat3x2(5.0, -6.0, -5.0, 5.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(-5.0, -6.0, -8.0, 6.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(2.0, -8.0, 9.0, -8.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[3], mat3x2(5.0, 0.0, 4.0, 3.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[4], mat3x2(-1.0, -1.0, -2.0, -8.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[5], mat3x2(-8.0, -6.0, 0.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[6], mat3x2(-1.0, 7.0, -4.0, 3.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[7], mat3x2(-5.0, -2.0, 0.0, -2.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[8], mat3x2(-7.0, -4.0, 1.0, -1.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[9], mat3x2(-8.0, -7.0, -1.0, -4.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[10], mat3x2(7.0, 9.0, 8.0, 2.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[11], mat3x2(8.0, -3.0, 8.0, -5.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[12], mat3x2(-1.0, 7.0, 3.0, 8.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[13], mat3x2(6.0, -7.0, 7.0, 5.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[14], mat3x2(9.0, 0.0, 2.0, -5.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[15], mat3x2(-5.0, 6.0, -3.0, 2.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[16], mat3x2(9.0, -6.0, -8.0, -7.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[17], mat3x2(-2.0, -1.0, 1.0, 6.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[18], mat3x2(1.0, -2.0, -2.0, -9.0, 8.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	allOk = compare_mat4x3(var[0], mat4x3(7.0, -2.0, 6.0, 3.0, 1.0, -7.0, 1.0, -4.0, 0.0, 9.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(3.0, 2.0, 2.0, 6.0, 6.0, 0.0, 3.0, 6.0, -4.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(-6.0, -5.0, 4.0, -4.0, 1.0, 2.0, -5.0, 9.0, -7.0, -2.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[3], mat4x3(-7.0, 1.0, -9.0, 8.0, 8.0, 5.0, 0.0, 5.0, -1.0, 2.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[4], mat4x3(4.0, -2.0, -8.0, -5.0, -8.0, -5.0, -4.0, -1.0, -1.0, -5.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[5], mat4x3(3.0, 8.0, 5.0, 3.0, -2.0, 8.0, -6.0, -2.0, -8.0, -1.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[6], mat4x3(-9.0, 0.0, 6.0, -9.0, -9.0, 9.0, 6.0, 9.0, -2.0, 8.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[7], mat4x3(-8.0, 6.0, 8.0, 4.0, -3.0, -9.0, 9.0, 1.0, 2.0, 8.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[8], mat4x3(-4.0, -3.0, 7.0, 7.0, 0.0, -3.0, 5.0, -5.0, -9.0, -3.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[9], mat4x3(8.0, -2.0, 1.0, 2.0, -3.0, 9.0, 6.0, -5.0, 8.0, -1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[10], mat4x3(-5.0, -7.0, 4.0, 5.0, 7.0, 5.0, 9.0, 4.0, 8.0, 2.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[11], mat4x3(-8.0, -9.0, -8.0, 2.0, -2.0, 8.0, 4.0, 4.0, -3.0, 2.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[12], mat4x3(1.0, 8.0, 9.0, 7.0, 0.0, -2.0, -4.0, 7.0, 0.0, -9.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[13], mat4x3(-9.0, -9.0, -7.0, -5.0, 2.0, 5.0, 0.0, -2.0, -3.0, -6.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[14], mat4x3(-8.0, -7.0, 9.0, 6.0, 6.0, -5.0, -3.0, 9.0, -4.0, -3.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[15], mat4x3(-5.0, -8.0, -6.0, 4.0, -5.0, 6.0, 5.0, -8.0, 5.0, -9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[16], mat4x3(-5.0, -1.0, 5.0, 4.0, -3.0, -3.0, -5.0, 1.0, -4.0, 6.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[17], mat4x3(0.0, -6.0, -8.0, -7.0, 6.0, -3.0, 0.0, 2.0, -9.0, -7.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[18], mat4x3(-2.0, 8.0, 2.0, 7.0, 9.0, 8.0, -3.0, 8.0, -9.0, -3.0, -1.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump vec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((block.var), vec2(7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (vec2(-7.0, 3.0));
}
#version 450
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
	allOk = compare_mat3(block.var, mat3(4.0, -3.0, 1.0, -7.0, 7.0, -7.0, -5.0, 6.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3(-5.0, -3.0, -5.0, -2.0, 2.0, -5.0, 6.0, 3.0, -8.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -2.0) && allOk;
	allOk = compare_float(block.var[0][1], -8.0) && allOk;
	allOk = compare_float(block.var[0][2], -1.0) && allOk;
	allOk = compare_float(block.var[1][0], 3.0) && allOk;
	allOk = compare_float(block.var[1][1], 4.0) && allOk;
	allOk = compare_float(block.var[1][2], 5.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-2.0, -8.0, -1.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(3.0, 4.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x3(-6.0, 8.0, -1.0, -4.0, -5.0, 4.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var, mat4x3(-3.0, 3.0, 8.0, -5.0, 5.0, 3.0, -1.0, -9.0, -4.0, 8.0, -4.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x3(-7.0, -4.0, 6.0, 7.0, -4.0, 4.0, 2.0, -9.0, -3.0, 8.0, -4.0, -5.0));
}
#version 450
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
	highp int var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((block.var), 7) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (-5);
}
#version 450
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
	lowp uint var;
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

	block.var = (6u);
}
#version 450
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
	allOk = compare_mat2(block.var, mat2(6.0, 1.0, -4.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(1.0, -9.0));
	block.var[1] = (vec2(-1.0, -7.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var, mat2x3(9.0, 1.0, -4.0, 3.0, 3.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(8.0, 9.0, 9.0));
	block.var[1] = (vec3(2.0, -6.0, 2.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var, mat3x2(-2.0, 4.0, 1.0, -8.0, 7.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(9.0, 0.0));
	block.var[1] = (vec2(-3.0, -2.0));
	block.var[2] = (vec2(-8.0, -6.0));
}
#version 450
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

layout(std430, column_major, buffer_reference) buffer Block
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
	allOk = compare_mat3x2(block.var, mat3x2(-7.0, 3.0, -6.0, -6.0, 2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x2(-1.0, -6.0, -1.0, 7.0, -5.0, -1.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var, mat3x4(3.0, -9.0, -9.0, 1.0, -8.0, 0.0, 1.0, -9.0, 4.0, -4.0, -2.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x4(-5.0, 8.0, 7.0, 9.0, 5.0, -9.0, -3.0, -7.0, 1.0, -6.0, -2.0, -4.0));
}
#version 450
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
	allOk = compare_float((block.padding), 0.0) && allOk;
	allOk = compare_mat2(block.var, mat2(-4.0, 9.0, -2.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-2.0);
	block.var = (mat2(-4.0, -8.0, -2.0, -2.0));
}
#version 450
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
	allOk = compare_float((block.padding), 7.0) && allOk;
	allOk = compare_float(block.var[0][0], -3.0) && allOk;
	allOk = compare_float(block.var[0][1], 8.0) && allOk;
	allOk = compare_float(block.var[1][0], -2.0) && allOk;
	allOk = compare_float(block.var[1][1], 3.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(-3.0, 8.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-2.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2.0);
	block.var[0] = (vec2(-5.0, 4.0));
	block.var[1] = (vec2(-7.0, -9.0));
}
#version 450
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
	allOk = compare_float((block.padding), -8.0) && allOk;
	allOk = compare_mat2(block.var, mat2(4.0, -2.0, -6.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-1.0);
	block.var[0] = (vec2(-9.0, 0.0));
	block.var[1] = (vec2(-5.0, -5.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.padding), 8.0) && allOk;
	allOk = compare_mat3(block.var, mat3(-6.0, 1.0, -4.0, -9.0, 1.0, -3.0, 6.0, -1.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2.0);
	block.var = (mat3(-8.0, 1.0, 7.0, 4.0, -1.0, 8.0, -3.0, 9.0, 9.0));
}
#version 450
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
	allOk = compare_float((block.padding), 9.0) && allOk;
	allOk = compare_float(block.var[0][0], 0.0) && allOk;
	allOk = compare_float(block.var[0][1], -3.0) && allOk;
	allOk = compare_float(block.var[0][2], -8.0) && allOk;
	allOk = compare_float(block.var[1][0], 3.0) && allOk;
	allOk = compare_float(block.var[1][1], -2.0) && allOk;
	allOk = compare_float(block.var[1][2], 3.0) && allOk;
	allOk = compare_float(block.var[2][0], 4.0) && allOk;
	allOk = compare_float(block.var[2][1], 1.0) && allOk;
	allOk = compare_float(block.var[2][2], 2.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(0.0, -3.0, -8.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(3.0, -2.0, 3.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(4.0, 1.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (7.0);
	block.var[0] = (vec3(-5.0, -9.0, 6.0));
	block.var[1] = (vec3(6.0, -2.0, 6.0));
	block.var[2] = (vec3(0.0, -8.0, 3.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.padding), -9.0) && allOk;
	allOk = compare_mat3(block.var, mat3(3.0, -5.0, 1.0, 4.0, 5.0, -2.0, 1.0, 6.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-9.0);
	block.var = (mat3(5.0, 1.0, 3.0, 2.0, -5.0, 9.0, -3.0, -7.0, -1.0));
}
#version 450
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
	allOk = compare_float((block.padding), 8.0) && allOk;
	allOk = compare_float(block.var[0][0], -9.0) && allOk;
	allOk = compare_float(block.var[0][1], -6.0) && allOk;
	allOk = compare_float(block.var[0][2], -9.0) && allOk;
	allOk = compare_float(block.var[0][3], -3.0) && allOk;
	allOk = compare_float(block.var[1][0], -7.0) && allOk;
	allOk = compare_float(block.var[1][1], 6.0) && allOk;
	allOk = compare_float(block.var[1][2], -6.0) && allOk;
	allOk = compare_float(block.var[1][3], -2.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-9.0, -6.0, -9.0, -3.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-7.0, 6.0, -6.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (8.0);
	block.var = (mat2x4(7.0, 9.0, -5.0, 2.0, 9.0, -8.0, -9.0, -5.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.padding), 9.0) && allOk;
	allOk = compare_mat3x2(block.var, mat3x2(4.0, 5.0, 6.0, 8.0, -5.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (4.0);
	block.var[0] = (vec2(5.0, 3.0));
	block.var[1] = (vec2(-1.0, -8.0));
	block.var[2] = (vec2(3.0, -8.0));
}
#version 450
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
	allOk = compare_float((block.padding), -3.0) && allOk;
	allOk = compare_float(block.var[0][0], 6.0) && allOk;
	allOk = compare_float(block.var[0][1], 2.0) && allOk;
	allOk = compare_float(block.var[0][2], 8.0) && allOk;
	allOk = compare_float(block.var[0][3], -5.0) && allOk;
	allOk = compare_float(block.var[1][0], 6.0) && allOk;
	allOk = compare_float(block.var[1][1], -4.0) && allOk;
	allOk = compare_float(block.var[1][2], 2.0) && allOk;
	allOk = compare_float(block.var[1][3], 5.0) && allOk;
	allOk = compare_float(block.var[2][0], -1.0) && allOk;
	allOk = compare_float(block.var[2][1], -2.0) && allOk;
	allOk = compare_float(block.var[2][2], -7.0) && allOk;
	allOk = compare_float(block.var[2][3], -7.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(6.0, 2.0, 8.0, -5.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(6.0, -4.0, 2.0, 5.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(-1.0, -2.0, -7.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-5.0);
	block.var = (mat3x4(-4.0, -9.0, 1.0, 4.0, 3.0, 8.0, 8.0, -7.0, 8.0, 7.0, 1.0, -2.0));
}
#version 450
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
	highp float var[3];
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
    if (allOk)
        ac_numPassed++;

	block.var[0] = (-2.0);
	block.var[1] = (4.0);
	block.var[2] = (6.0);
}
#version 450
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
	allOk = compare_float((block.padding), 6.0) && allOk;
	allOk = compare_mat3(block.var[0], mat3(-4.0, 9.0, -9.0, 3.0, 9.0, 6.0, -9.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(5.0, -8.0, -6.0, -8.0, -7.0, -4.0, 6.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(-2.0, -2.0, -8.0, -8.0, -5.0, -4.0, -6.0, 8.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2.0);
	block.var[0][0] = (vec3(-4.0, 9.0, -4.0));
	block.var[0][1] = (vec3(2.0, 5.0, 5.0));
	block.var[0][2] = (vec3(-9.0, -5.0, 3.0));
	block.var[1][0] = (vec3(1.0, 8.0, 6.0));
	block.var[1][1] = (vec3(9.0, -8.0, -1.0));
	block.var[1][2] = (vec3(5.0, 1.0, 6.0));
	block.var[2][0] = (vec3(-5.0, -4.0, -8.0));
	block.var[2][1] = (vec3(-8.0, -2.0, 9.0));
	block.var[2][2] = (vec3(-4.0, 4.0, 4.0));
}
#version 450
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
	allOk = compare_float((block.padding), -4.0) && allOk;
	allOk = compare_mat4x2(block.var[0], mat4x2(0.0, -5.0, 0.0, -1.0, -4.0, 4.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(4.0, 0.0, 2.0, -3.0, -1.0, 1.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(5.0, 4.0, 9.0, -2.0, -3.0, -4.0, -1.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (1.0);
	block.var[0] = (mat4x2(-9.0, 4.0, 1.0, -5.0, 2.0, -5.0, 8.0, 8.0));
	block.var[1] = (mat4x2(8.0, 3.0, 2.0, -6.0, 3.0, 8.0, -8.0, 8.0));
	block.var[2] = (mat4x2(-3.0, -9.0, -2.0, 6.0, -1.0, 6.0, 9.0, -5.0));
}
#version 450
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
	highp mat2x3 var[];
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
	allOk = compare_mat2x3(block.var[3], mat2x3(6.0, -1.0, -8.0, 3.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[4], mat2x3(4.0, 7.0, 2.0, -2.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[5], mat2x3(0.0, 3.0, 1.0, 1.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[6], mat2x3(-5.0, 0.0, 2.0, -8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[7], mat2x3(-7.0, 0.0, -6.0, -3.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[8], mat2x3(2.0, 2.0, 8.0, 8.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[9], mat2x3(5.0, -5.0, 7.0, 3.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[10], mat2x3(-4.0, 4.0, -6.0, -4.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[11], mat2x3(-1.0, 2.0, 6.0, 0.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[12], mat2x3(-2.0, -9.0, 4.0, -4.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[13], mat2x3(2.0, -4.0, 4.0, -9.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[14], mat2x3(-7.0, 4.0, -6.0, 9.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[15], mat2x3(-7.0, -3.0, 0.0, 1.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[16], mat2x3(-3.0, -2.0, -4.0, -6.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[17], mat2x3(-2.0, -6.0, -4.0, 5.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[18], mat2x3(-9.0, 5.0, -1.0, 6.0, 6.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2x3(0.0, 4.0, 4.0, 5.0, -5.0, 2.0));
	block.var[1] = (mat2x3(8.0, -1.0, -2.0, -7.0, -8.0, -2.0));
	block.var[2] = (mat2x3(2.0, -2.0, 7.0, -9.0, 7.0, -7.0));
	block.var[3] = (mat2x3(-5.0, 6.0, 8.0, -8.0, 0.0, 2.0));
	block.var[4] = (mat2x3(7.0, -9.0, -2.0, -9.0, -1.0, -1.0));
	block.var[5] = (mat2x3(-4.0, -3.0, 7.0, 9.0, 0.0, -4.0));
	block.var[6] = (mat2x3(9.0, 0.0, 7.0, 7.0, 9.0, -8.0));
	block.var[7] = (mat2x3(5.0, 5.0, 1.0, 6.0, 3.0, -6.0));
	block.var[8] = (mat2x3(8.0, 9.0, 6.0, 7.0, 0.0, -6.0));
	block.var[9] = (mat2x3(-7.0, 6.0, 4.0, 8.0, 5.0, -1.0));
	block.var[10] = (mat2x3(4.0, 4.0, 9.0, 9.0, -8.0, 6.0));
	block.var[11] = (mat2x3(6.0, 3.0, 8.0, 3.0, 4.0, 4.0));
	block.var[12] = (mat2x3(3.0, -4.0, -5.0, -4.0, -9.0, 4.0));
	block.var[13] = (mat2x3(6.0, 3.0, -4.0, 1.0, -8.0, 2.0));
	block.var[14] = (mat2x3(-4.0, 6.0, 9.0, 8.0, -3.0, 4.0));
	block.var[15] = (mat2x3(-7.0, -8.0, 0.0, -7.0, 6.0, 7.0));
	block.var[16] = (mat2x3(8.0, 2.0, 8.0, 2.0, 1.0, 6.0));
	block.var[17] = (mat2x3(-1.0, 8.0, 1.0, -8.0, -1.0, 2.0));
	block.var[18] = (mat2x3(-1.0, 7.0, -6.0, -6.0, -1.0, 0.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0], mat2x4(-8.0, -3.0, 6.0, -5.0, 2.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1], mat2x4(-2.0, 8.0, 0.0, 5.0, -6.0, 9.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2], mat2x4(1.0, -1.0, -5.0, 4.0, -7.0, -3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0], mat2x4(-3.0, -4.0, 0.0, 0.0, 9.0, -6.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1], mat2x4(4.0, 5.0, 3.0, 4.0, 0.0, -1.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2], mat2x4(1.0, 5.0, -8.0, -9.0, -5.0, -6.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0], mat2x4(0.0, 8.0, -1.0, 5.0, -1.0, 4.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1], mat2x4(5.0, 3.0, 2.0, 2.0, 0.0, -9.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2], mat2x4(8.0, 0.0, -7.0, -9.0, -2.0, 5.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0], mat2x4(9.0, -1.0, 4.0, -4.0, 9.0, 6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1], mat2x4(0.0, 4.0, 7.0, 0.0, 5.0, 3.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][2], mat2x4(4.0, -4.0, -8.0, -7.0, 7.0, -8.0, -2.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat2x4(-2.0, 3.0, 2.0, -4.0, 2.0, -2.0, 9.0, -4.0));
	block.var[0][1] = (mat2x4(0.0, 7.0, 4.0, -8.0, 6.0, 0.0, -1.0, -8.0));
	block.var[0][2] = (mat2x4(2.0, 8.0, 2.0, 4.0, 5.0, 4.0, -3.0, 4.0));
	block.var[1][0] = (mat2x4(-6.0, 1.0, 7.0, -9.0, 7.0, -5.0, -1.0, -8.0));
	block.var[1][1] = (mat2x4(-2.0, -6.0, -6.0, 6.0, 6.0, -7.0, 6.0, 9.0));
	block.var[1][2] = (mat2x4(3.0, 9.0, 4.0, -6.0, 7.0, -1.0, 9.0, 5.0));
	block.var[2][0] = (mat2x4(-7.0, 0.0, -8.0, 2.0, -6.0, -5.0, 9.0, 2.0));
	block.var[2][1] = (mat2x4(2.0, 3.0, 4.0, 6.0, -7.0, -3.0, 5.0, 2.0));
	block.var[2][2] = (mat2x4(4.0, 2.0, 8.0, -5.0, -9.0, -1.0, 6.0, -2.0));
	block.var[3][0] = (mat2x4(4.0, 1.0, -1.0, -1.0, 7.0, 0.0, 6.0, 9.0));
	block.var[3][1] = (mat2x4(5.0, 9.0, -6.0, -6.0, -2.0, -9.0, 9.0, 3.0));
	block.var[3][2] = (mat2x4(2.0, 4.0, -3.0, 6.0, 6.0, 9.0, 1.0, 5.0));
}
#version 450
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
	highp ivec4 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((block.padding), -7) && allOk;
	allOk = compare_ivec4((block.var[0][0]), ivec4(9, -5, 6, 3)) && allOk;
	allOk = compare_ivec4((block.var[0][1]), ivec4(4, 2, -3, -3)) && allOk;
	allOk = compare_ivec4((block.var[0][2]), ivec4(-3, -5, -5, 3)) && allOk;
	allOk = compare_ivec4((block.var[1][0]), ivec4(-5, -9, -7, 1)) && allOk;
	allOk = compare_ivec4((block.var[1][1]), ivec4(5, 9, 7, -4)) && allOk;
	allOk = compare_ivec4((block.var[1][2]), ivec4(-1, 8, -1, 4)) && allOk;
	allOk = compare_ivec4((block.var[2][0]), ivec4(3, 6, -6, 1)) && allOk;
	allOk = compare_ivec4((block.var[2][1]), ivec4(-3, 0, 0, 1)) && allOk;
	allOk = compare_ivec4((block.var[2][2]), ivec4(-6, 0, -7, 6)) && allOk;
	allOk = compare_ivec4((block.var[3][0]), ivec4(-4, -4, 0, 8)) && allOk;
	allOk = compare_ivec4((block.var[3][1]), ivec4(-3, 3, 3, -3)) && allOk;
	allOk = compare_ivec4((block.var[3][2]), ivec4(1, 3, 1, -7)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (5);
	block.var[0][0] = (ivec4(-9, 5, -6, -2));
	block.var[0][1] = (ivec4(-4, 1, -9, 7));
	block.var[0][2] = (ivec4(3, 6, 8, 6));
	block.var[1][0] = (ivec4(-4, 6, -7, 9));
	block.var[1][1] = (ivec4(-8, -9, 0, 5));
	block.var[1][2] = (ivec4(-7, 2, 9, 6));
	block.var[2][0] = (ivec4(5, 4, 0, 5));
	block.var[2][1] = (ivec4(9, 0, 0, -6));
	block.var[2][2] = (ivec4(4, 4, 2, 9));
	block.var[3][0] = (ivec4(7, 5, 5, 3));
	block.var[3][1] = (ivec4(-3, -9, -8, -6));
	block.var[3][2] = (ivec4(3, 2, 0, 7));
}
#version 450
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
	u8vec2 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(block.padding), 3u) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[0][0]), uvec2(0u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[0][1]), uvec2(2u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[0][2]), uvec2(2u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][0]), uvec2(3u, 9u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][1]), uvec2(7u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][2]), uvec2(4u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][0]), uvec2(0u, 6u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][1]), uvec2(8u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][2]), uvec2(0u, 1u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[3][0]), uvec2(0u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[3][1]), uvec2(8u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[3][2]), uvec2(0u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = uint8_t(7u);
	block.var[0][0] = u8vec2(uvec2(7u, 9u));
	block.var[0][1] = u8vec2(uvec2(6u, 0u));
	block.var[0][2] = u8vec2(uvec2(2u, 1u));
	block.var[1][0] = u8vec2(uvec2(1u, 0u));
	block.var[1][1] = u8vec2(uvec2(8u, 8u));
	block.var[1][2] = u8vec2(uvec2(5u, 2u));
	block.var[2][0] = u8vec2(uvec2(7u, 4u));
	block.var[2][1] = u8vec2(uvec2(4u, 7u));
	block.var[2][2] = u8vec2(uvec2(2u, 4u));
	block.var[3][0] = u8vec2(uvec2(5u, 0u));
	block.var[3][1] = u8vec2(uvec2(2u, 1u));
	block.var[3][2] = u8vec2(uvec2(8u, 1u));
}
#version 450
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
	allOk = compare_mat3(block.var[0][0][0], mat3(-9.0, -4.0, 2.0, 9.0, 6.0, -2.0, 1.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(6.0, 3.0, 2.0, 7.0, 4.0, 2.0, 3.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][2], mat3(6.0, 3.0, 7.0, -4.0, -2.0, -7.0, -6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(6.0, 2.0, -2.0, -8.0, 6.0, -8.0, 9.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(2.0, -5.0, -3.0, 8.0, -9.0, -7.0, 1.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][2], mat3(4.0, 7.0, -9.0, 5.0, 0.0, -7.0, -9.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(8.0, -8.0, 9.0, -5.0, 1.0, 4.0, -5.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(3.0, -6.0, -5.0, 8.0, -7.0, -1.0, 7.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][2], mat3(-3.0, 9.0, -3.0, -6.0, -2.0, -9.0, 4.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(-1.0, -3.0, 9.0, -3.0, 4.0, 3.0, 3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(6.0, 8.0, -8.0, 7.0, -1.0, 4.0, 0.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][2], mat3(2.0, 8.0, 8.0, -5.0, 4.0, -5.0, 8.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(-9.0, -7.0, 6.0, 9.0, 7.0, 9.0, -3.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(9.0, -2.0, 1.0, 4.0, 4.0, 6.0, -1.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][2], mat3(-5.0, 6.0, 1.0, -6.0, -3.0, -8.0, -9.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(8.0, 6.0, -5.0, 8.0, 3.0, 2.0, -2.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(3.0, 6.0, -1.0, 9.0, 5.0, -8.0, 3.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][2], mat3(-9.0, -6.0, -1.0, -8.0, 7.0, -5.0, 7.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][0], mat3(-7.0, 8.0, -9.0, 5.0, -3.0, 6.0, 5.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][1], mat3(-4.0, 7.0, -7.0, -7.0, -4.0, 4.0, -5.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][2], mat3(2.0, 6.0, -4.0, -8.0, -5.0, -4.0, -7.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][0], mat3(8.0, -5.0, 6.0, -9.0, -8.0, 9.0, -2.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][1], mat3(1.0, -4.0, -4.0, 1.0, -5.0, -1.0, -9.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][2], mat3(-7.0, -8.0, -7.0, -4.0, -7.0, 6.0, -9.0, 7.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3(-1.0, -8.0, 7.0, -5.0, 5.0, 6.0, 0.0, -8.0, -6.0));
	block.var[0][0][1] = (mat3(-4.0, 3.0, 7.0, 1.0, -1.0, 9.0, 6.0, 2.0, 9.0));
	block.var[0][0][2] = (mat3(-6.0, 8.0, 0.0, 1.0, 4.0, 6.0, -9.0, -9.0, 2.0));
	block.var[0][1][0] = (mat3(1.0, -8.0, 4.0, 5.0, 7.0, 9.0, 5.0, 8.0, -6.0));
	block.var[0][1][1] = (mat3(-9.0, -5.0, 9.0, 8.0, -9.0, -8.0, -5.0, 6.0, -7.0));
	block.var[0][1][2] = (mat3(2.0, 4.0, 5.0, -8.0, -2.0, 8.0, 6.0, 2.0, -9.0));
	block.var[1][0][0] = (mat3(8.0, -1.0, 9.0, 9.0, 7.0, -5.0, -5.0, -8.0, 8.0));
	block.var[1][0][1] = (mat3(-2.0, 9.0, 8.0, -9.0, 3.0, 2.0, 9.0, 1.0, 2.0));
	block.var[1][0][2] = (mat3(-9.0, -7.0, -5.0, -3.0, 7.0, 2.0, -1.0, 1.0, 2.0));
	block.var[1][1][0] = (mat3(-8.0, 1.0, -1.0, 7.0, -2.0, -3.0, 5.0, 3.0, 0.0));
	block.var[1][1][1] = (mat3(-1.0, -2.0, -3.0, 3.0, -9.0, -3.0, -4.0, -7.0, -5.0));
	block.var[1][1][2] = (mat3(-8.0, 9.0, 8.0, 8.0, 4.0, 5.0, 1.0, 8.0, 7.0));
	block.var[2][0][0] = (mat3(-2.0, 9.0, 0.0, 0.0, -3.0, -9.0, -6.0, 5.0, 0.0));
	block.var[2][0][1] = (mat3(-5.0, 6.0, 3.0, -2.0, 5.0, 6.0, 9.0, -9.0, 8.0));
	block.var[2][0][2] = (mat3(6.0, 6.0, -9.0, -8.0, -3.0, -7.0, 6.0, -1.0, -6.0));
	block.var[2][1][0] = (mat3(2.0, 2.0, -3.0, 0.0, 0.0, 9.0, 3.0, 9.0, 2.0));
	block.var[2][1][1] = (mat3(1.0, -8.0, 5.0, -8.0, -4.0, 5.0, -4.0, 5.0, 3.0));
	block.var[2][1][2] = (mat3(2.0, 4.0, 4.0, -7.0, -3.0, 4.0, -2.0, -2.0, 9.0));
	block.var[3][0][0] = (mat3(-1.0, 6.0, -1.0, 1.0, -5.0, -8.0, 2.0, -7.0, -4.0));
	block.var[3][0][1] = (mat3(3.0, -9.0, 2.0, -1.0, 4.0, 3.0, -2.0, 9.0, -3.0));
	block.var[3][0][2] = (mat3(-6.0, -9.0, 6.0, 9.0, 0.0, 3.0, 8.0, -4.0, -4.0));
	block.var[3][1][0] = (mat3(-1.0, -5.0, -7.0, -6.0, -6.0, 4.0, 0.0, -9.0, 8.0));
	block.var[3][1][1] = (mat3(-2.0, 1.0, -3.0, 1.0, -3.0, -7.0, -3.0, 6.0, -6.0));
	block.var[3][1][2] = (mat3(3.0, 9.0, 2.0, 3.0, 9.0, -1.0, -7.0, 4.0, 2.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(-7.0, 1.0, 9.0, 3.0, -9.0, -1.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(-9.0, 6.0, 5.0, -8.0, 8.0, 9.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][2], mat4x2(4.0, 1.0, -1.0, -5.0, 5.0, -9.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(3.0, -1.0, -8.0, -1.0, -7.0, -8.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(0.0, -8.0, -7.0, 7.0, 3.0, 7.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][2], mat4x2(-7.0, 7.0, -7.0, -4.0, -2.0, -5.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(-2.0, -2.0, -9.0, -2.0, -2.0, 8.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(-8.0, 6.0, -4.0, 7.0, 2.0, 3.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][2], mat4x2(7.0, 3.0, 5.0, -2.0, 7.0, 1.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(3.0, -9.0, 6.0, -8.0, 0.0, 5.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(-2.0, 0.0, 9.0, -8.0, 0.0, 5.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][2], mat4x2(9.0, 1.0, 2.0, -6.0, -9.0, -9.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(-5.0, -9.0, 1.0, -6.0, 3.0, -3.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(4.0, -4.0, -1.0, 4.0, 0.0, -4.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][2], mat4x2(-7.0, 4.0, 5.0, 4.0, -5.0, 8.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(-8.0, 9.0, -5.0, -6.0, -1.0, 1.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(8.0, -1.0, -7.0, -7.0, -9.0, -4.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][2], mat4x2(-6.0, -7.0, -8.0, 6.0, -7.0, -6.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][0], mat4x2(-7.0, 5.0, -2.0, -3.0, 7.0, 4.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][1], mat4x2(-4.0, 7.0, 2.0, 3.0, -7.0, -8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][2], mat4x2(-1.0, -8.0, -8.0, 4.0, 6.0, 8.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][0], mat4x2(8.0, -2.0, 9.0, -6.0, 5.0, -1.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][1], mat4x2(-3.0, -3.0, 0.0, -2.0, -5.0, 8.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][2], mat4x2(-5.0, -9.0, 3.0, 5.0, 2.0, -2.0, -7.0, 6.0)) && allOk;
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
	block.var[0][0][2][0] = (vec2(-8.0, 2.0));
	block.var[0][0][2][1] = (vec2(-5.0, 5.0));
	block.var[0][0][2][2] = (vec2(-4.0, -9.0));
	block.var[0][0][2][3] = (vec2(0.0, 4.0));
	block.var[0][1][0][0] = (vec2(1.0, 7.0));
	block.var[0][1][0][1] = (vec2(0.0, -4.0));
	block.var[0][1][0][2] = (vec2(-1.0, 5.0));
	block.var[0][1][0][3] = (vec2(9.0, -8.0));
	block.var[0][1][1][0] = (vec2(-3.0, 8.0));
	block.var[0][1][1][1] = (vec2(-1.0, 7.0));
	block.var[0][1][1][2] = (vec2(5.0, -7.0));
	block.var[0][1][1][3] = (vec2(8.0, 0.0));
	block.var[0][1][2][0] = (vec2(-5.0, 7.0));
	block.var[0][1][2][1] = (vec2(8.0, 9.0));
	block.var[0][1][2][2] = (vec2(8.0, 9.0));
	block.var[0][1][2][3] = (vec2(1.0, 9.0));
	block.var[1][0][0][0] = (vec2(8.0, 2.0));
	block.var[1][0][0][1] = (vec2(-3.0, 2.0));
	block.var[1][0][0][2] = (vec2(-4.0, -4.0));
	block.var[1][0][0][3] = (vec2(2.0, -8.0));
	block.var[1][0][1][0] = (vec2(-4.0, 8.0));
	block.var[1][0][1][1] = (vec2(5.0, 7.0));
	block.var[1][0][1][2] = (vec2(-4.0, 6.0));
	block.var[1][0][1][3] = (vec2(8.0, 4.0));
	block.var[1][0][2][0] = (vec2(-9.0, -7.0));
	block.var[1][0][2][1] = (vec2(7.0, -5.0));
	block.var[1][0][2][2] = (vec2(1.0, -9.0));
	block.var[1][0][2][3] = (vec2(9.0, 5.0));
	block.var[1][1][0][0] = (vec2(-9.0, 8.0));
	block.var[1][1][0][1] = (vec2(-2.0, 9.0));
	block.var[1][1][0][2] = (vec2(6.0, 6.0));
	block.var[1][1][0][3] = (vec2(3.0, -5.0));
	block.var[1][1][1][0] = (vec2(1.0, -4.0));
	block.var[1][1][1][1] = (vec2(-5.0, 7.0));
	block.var[1][1][1][2] = (vec2(-8.0, 7.0));
	block.var[1][1][1][3] = (vec2(-1.0, -1.0));
	block.var[1][1][2][0] = (vec2(-2.0, -7.0));
	block.var[1][1][2][1] = (vec2(4.0, -8.0));
	block.var[1][1][2][2] = (vec2(2.0, 4.0));
	block.var[1][1][2][3] = (vec2(3.0, 1.0));
	block.var[2][0][0][0] = (vec2(7.0, 3.0));
	block.var[2][0][0][1] = (vec2(3.0, 3.0));
	block.var[2][0][0][2] = (vec2(-5.0, -9.0));
	block.var[2][0][0][3] = (vec2(2.0, 9.0));
	block.var[2][0][1][0] = (vec2(3.0, 8.0));
	block.var[2][0][1][1] = (vec2(3.0, -4.0));
	block.var[2][0][1][2] = (vec2(6.0, 1.0));
	block.var[2][0][1][3] = (vec2(-3.0, 1.0));
	block.var[2][0][2][0] = (vec2(-5.0, -2.0));
	block.var[2][0][2][1] = (vec2(7.0, 8.0));
	block.var[2][0][2][2] = (vec2(4.0, 7.0));
	block.var[2][0][2][3] = (vec2(-1.0, -8.0));
	block.var[2][1][0][0] = (vec2(7.0, 8.0));
	block.var[2][1][0][1] = (vec2(2.0, -9.0));
	block.var[2][1][0][2] = (vec2(-8.0, -9.0));
	block.var[2][1][0][3] = (vec2(-1.0, -3.0));
	block.var[2][1][1][0] = (vec2(-2.0, -1.0));
	block.var[2][1][1][1] = (vec2(1.0, -1.0));
	block.var[2][1][1][2] = (vec2(-5.0, -6.0));
	block.var[2][1][1][3] = (vec2(-8.0, 7.0));
	block.var[2][1][2][0] = (vec2(2.0, 0.0));
	block.var[2][1][2][1] = (vec2(-7.0, -6.0));
	block.var[2][1][2][2] = (vec2(6.0, 1.0));
	block.var[2][1][2][3] = (vec2(8.0, 9.0));
	block.var[3][0][0][0] = (vec2(-6.0, -6.0));
	block.var[3][0][0][1] = (vec2(-4.0, -2.0));
	block.var[3][0][0][2] = (vec2(3.0, 8.0));
	block.var[3][0][0][3] = (vec2(4.0, 4.0));
	block.var[3][0][1][0] = (vec2(-7.0, -6.0));
	block.var[3][0][1][1] = (vec2(8.0, -6.0));
	block.var[3][0][1][2] = (vec2(8.0, -3.0));
	block.var[3][0][1][3] = (vec2(-7.0, 0.0));
	block.var[3][0][2][0] = (vec2(-9.0, 2.0));
	block.var[3][0][2][1] = (vec2(-9.0, 7.0));
	block.var[3][0][2][2] = (vec2(-2.0, 2.0));
	block.var[3][0][2][3] = (vec2(-6.0, -1.0));
	block.var[3][1][0][0] = (vec2(9.0, -8.0));
	block.var[3][1][0][1] = (vec2(-6.0, -7.0));
	block.var[3][1][0][2] = (vec2(-5.0, 0.0));
	block.var[3][1][0][3] = (vec2(-3.0, 1.0));
	block.var[3][1][1][0] = (vec2(-1.0, -6.0));
	block.var[3][1][1][1] = (vec2(1.0, 1.0));
	block.var[3][1][1][2] = (vec2(-7.0, -8.0));
	block.var[3][1][1][3] = (vec2(-5.0, 5.0));
	block.var[3][1][2][0] = (vec2(4.0, -9.0));
	block.var[3][1][2][1] = (vec2(-6.0, -7.0));
	block.var[3][1][2][2] = (vec2(-8.0, 8.0));
	block.var[3][1][2][3] = (vec2(-3.0, 6.0));
}
#version 450
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
	u16vec4 var[4][2][3];
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
	allOk = compare_u16vec4(uvec4(block.var[0][0][2]), uvec4(8u, 7u, 1u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[0][1][0]), uvec4(0u, 2u, 0u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[0][1][1]), uvec4(9u, 8u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[0][1][2]), uvec4(5u, 2u, 3u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][0][0]), uvec4(5u, 0u, 5u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][0][1]), uvec4(9u, 4u, 6u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][0][2]), uvec4(5u, 3u, 6u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][1][0]), uvec4(5u, 9u, 1u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][1][1]), uvec4(6u, 2u, 0u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][1][2]), uvec4(5u, 5u, 6u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][0][0]), uvec4(9u, 2u, 2u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][0][1]), uvec4(9u, 9u, 3u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][0][2]), uvec4(0u, 0u, 4u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][1][0]), uvec4(2u, 6u, 2u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][1][1]), uvec4(3u, 7u, 0u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][1][2]), uvec4(6u, 4u, 5u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[3][0][0]), uvec4(1u, 7u, 1u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[3][0][1]), uvec4(8u, 7u, 4u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[3][0][2]), uvec4(7u, 0u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[3][1][0]), uvec4(6u, 4u, 0u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[3][1][1]), uvec4(2u, 9u, 7u, 6u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[3][1][2]), uvec4(8u, 1u, 6u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = u16vec4(uvec4(0u, 6u, 9u, 4u));
	block.var[0][0][1] = u16vec4(uvec4(5u, 0u, 1u, 0u));
	block.var[0][0][2] = u16vec4(uvec4(7u, 6u, 5u, 9u));
	block.var[0][1][0] = u16vec4(uvec4(6u, 9u, 4u, 2u));
	block.var[0][1][1] = u16vec4(uvec4(9u, 7u, 6u, 2u));
	block.var[0][1][2] = u16vec4(uvec4(8u, 4u, 6u, 2u));
	block.var[1][0][0] = u16vec4(uvec4(8u, 3u, 6u, 1u));
	block.var[1][0][1] = u16vec4(uvec4(7u, 9u, 3u, 8u));
	block.var[1][0][2] = u16vec4(uvec4(1u, 4u, 3u, 9u));
	block.var[1][1][0] = u16vec4(uvec4(2u, 1u, 0u, 1u));
	block.var[1][1][1] = u16vec4(uvec4(9u, 9u, 4u, 6u));
	block.var[1][1][2] = u16vec4(uvec4(4u, 4u, 2u, 8u));
	block.var[2][0][0] = u16vec4(uvec4(9u, 3u, 0u, 2u));
	block.var[2][0][1] = u16vec4(uvec4(3u, 5u, 0u, 2u));
	block.var[2][0][2] = u16vec4(uvec4(5u, 1u, 5u, 5u));
	block.var[2][1][0] = u16vec4(uvec4(7u, 8u, 2u, 8u));
	block.var[2][1][1] = u16vec4(uvec4(0u, 3u, 6u, 3u));
	block.var[2][1][2] = u16vec4(uvec4(4u, 0u, 8u, 2u));
	block.var[3][0][0] = u16vec4(uvec4(4u, 0u, 8u, 4u));
	block.var[3][0][1] = u16vec4(uvec4(0u, 3u, 7u, 1u));
	block.var[3][0][2] = u16vec4(uvec4(1u, 8u, 4u, 7u));
	block.var[3][1][0] = u16vec4(uvec4(3u, 0u, 4u, 2u));
	block.var[3][1][1] = u16vec4(uvec4(4u, 7u, 1u, 9u));
	block.var[3][1][2] = u16vec4(uvec4(5u, 6u, 9u, 9u));
}
#version 450
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
	allOk = compare_float((block.padding), 5.0) && allOk;
	allOk = compare_mat4(block.var[0][0][0], mat4(8.0, -8.0, -2.0, 6.0, -4.0, 3.0, -1.0, 6.0, 4.0, -8.0, -3.0, 9.0, 9.0, 4.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][1], mat4(-5.0, 1.0, 2.0, 1.0, 8.0, 6.0, 2.0, -2.0, -9.0, -8.0, -8.0, -3.0, -9.0, -4.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][2], mat4(-6.0, 8.0, -9.0, -2.0, 9.0, 7.0, 3.0, 4.0, -1.0, -8.0, -8.0, 9.0, -4.0, 1.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][0], mat4(-6.0, 0.0, -6.0, -4.0, 0.0, 7.0, 0.0, 7.0, 0.0, 8.0, 2.0, -6.0, -3.0, -9.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][1], mat4(-2.0, 1.0, -9.0, -6.0, -1.0, -4.0, 6.0, 8.0, -7.0, 1.0, 3.0, -9.0, 5.0, 1.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][2], mat4(4.0, 5.0, 9.0, 0.0, 0.0, 9.0, 3.0, -9.0, -4.0, 5.0, -2.0, 7.0, 9.0, 4.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][0], mat4(-1.0, -9.0, 8.0, 9.0, -9.0, -7.0, -2.0, 3.0, -9.0, -3.0, -9.0, 4.0, -4.0, -1.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][1], mat4(7.0, -4.0, -4.0, 1.0, 2.0, -1.0, -3.0, 8.0, 1.0, -3.0, -1.0, -4.0, -6.0, 8.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][2], mat4(9.0, 8.0, 7.0, 8.0, -2.0, -2.0, -5.0, -9.0, -8.0, -9.0, -4.0, -9.0, 6.0, 8.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][0], mat4(0.0, -2.0, -7.0, -8.0, 0.0, 3.0, -1.0, -9.0, 1.0, 9.0, -1.0, 5.0, -9.0, -6.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][1], mat4(-5.0, -9.0, 5.0, 4.0, 7.0, 0.0, -6.0, -5.0, -9.0, 6.0, 9.0, 4.0, 6.0, 4.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][2], mat4(5.0, 9.0, -6.0, 4.0, 6.0, -4.0, 1.0, 6.0, 1.0, 3.0, 4.0, 3.0, 8.0, 2.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][0], mat4(8.0, -3.0, -5.0, -4.0, -9.0, -2.0, -6.0, -3.0, -9.0, -9.0, -7.0, 7.0, -9.0, 2.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][1], mat4(-6.0, -4.0, 8.0, 0.0, -1.0, 3.0, -5.0, 6.0, -8.0, 9.0, 7.0, 3.0, 0.0, -7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][2], mat4(-9.0, 9.0, 2.0, -2.0, -2.0, 3.0, -9.0, 4.0, -1.0, -1.0, -7.0, -4.0, 0.0, 7.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][0], mat4(-4.0, 3.0, -3.0, 5.0, 1.0, -7.0, 8.0, 7.0, -9.0, -3.0, 7.0, 9.0, -9.0, -5.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][1], mat4(-2.0, 4.0, -4.0, 1.0, 7.0, 6.0, 9.0, 8.0, -8.0, -3.0, -4.0, -7.0, 4.0, 9.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][2], mat4(-5.0, 2.0, 3.0, -9.0, -7.0, 3.0, -6.0, 4.0, 1.0, -7.0, 9.0, 2.0, 6.0, -5.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][0], mat4(1.0, 6.0, 5.0, 7.0, -7.0, -8.0, 7.0, -2.0, -3.0, 4.0, 3.0, 2.0, -8.0, 4.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][1], mat4(2.0, -4.0, 7.0, -4.0, 1.0, -9.0, 8.0, 4.0, -8.0, 5.0, 3.0, 7.0, 5.0, 8.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][2], mat4(-3.0, -3.0, -4.0, -9.0, 8.0, 9.0, 0.0, 4.0, 6.0, -9.0, -8.0, 5.0, 3.0, -1.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][0], mat4(-7.0, -4.0, 1.0, 4.0, 3.0, 9.0, -8.0, -6.0, -7.0, -1.0, -7.0, -7.0, 7.0, 3.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][1], mat4(2.0, 5.0, 3.0, 5.0, -7.0, 3.0, -6.0, -7.0, 6.0, 1.0, -5.0, -6.0, 9.0, -8.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][2], mat4(-7.0, -4.0, -2.0, -7.0, 1.0, -1.0, 4.0, -9.0, 4.0, 9.0, -9.0, 0.0, -9.0, -2.0, -4.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (6.0);
	block.var[0][0][0] = (mat4(-8.0, 2.0, -8.0, 1.0, -5.0, -7.0, -8.0, -9.0, 3.0, -9.0, -1.0, 7.0, -6.0, -5.0, 2.0, 4.0));
	block.var[0][0][1] = (mat4(3.0, -5.0, 6.0, 5.0, -1.0, -1.0, 7.0, -1.0, 5.0, -8.0, -3.0, 2.0, -6.0, -9.0, -5.0, 1.0));
	block.var[0][0][2] = (mat4(-5.0, -9.0, 9.0, -7.0, -1.0, 6.0, -6.0, 6.0, -9.0, -8.0, -3.0, -3.0, 4.0, -5.0, -1.0, -3.0));
	block.var[0][1][0] = (mat4(-9.0, -7.0, -9.0, -9.0, -3.0, -8.0, 0.0, -1.0, -4.0, -1.0, -8.0, 5.0, -8.0, -3.0, 1.0, -1.0));
	block.var[0][1][1] = (mat4(-6.0, -1.0, 0.0, -8.0, 6.0, 6.0, -5.0, -6.0, 9.0, 2.0, 6.0, 6.0, -5.0, -7.0, 0.0, 2.0));
	block.var[0][1][2] = (mat4(6.0, 3.0, 6.0, 1.0, -3.0, -6.0, 0.0, -2.0, 0.0, -9.0, 1.0, 6.0, 9.0, -9.0, 0.0, -9.0));
	block.var[1][0][0] = (mat4(-9.0, -6.0, 5.0, 0.0, 6.0, -5.0, -7.0, -6.0, -5.0, 8.0, -6.0, -2.0, -8.0, -4.0, -8.0, 1.0));
	block.var[1][0][1] = (mat4(5.0, 6.0, -2.0, -7.0, -3.0, -4.0, 6.0, -8.0, -5.0, 2.0, 8.0, 4.0, 3.0, 6.0, -6.0, -7.0));
	block.var[1][0][2] = (mat4(5.0, 7.0, -7.0, -6.0, 6.0, -2.0, 5.0, 1.0, -3.0, -2.0, 4.0, 6.0, -6.0, -5.0, -5.0, 6.0));
	block.var[1][1][0] = (mat4(4.0, 1.0, 5.0, 0.0, 9.0, 3.0, -2.0, -8.0, 9.0, -9.0, 2.0, -8.0, 0.0, 7.0, 7.0, 6.0));
	block.var[1][1][1] = (mat4(-5.0, 5.0, 3.0, -2.0, -8.0, 6.0, 2.0, 7.0, -1.0, -2.0, 8.0, -9.0, 1.0, -4.0, 1.0, -5.0));
	block.var[1][1][2] = (mat4(-8.0, 1.0, 9.0, -7.0, -4.0, 0.0, -3.0, 6.0, 2.0, 2.0, -2.0, -8.0, 4.0, 1.0, 7.0, 4.0));
	block.var[2][0][0] = (mat4(-8.0, -5.0, -4.0, 5.0, -3.0, 4.0, 6.0, 2.0, -2.0, -7.0, 5.0, -9.0, -3.0, 9.0, 5.0, 6.0));
	block.var[2][0][1] = (mat4(9.0, 2.0, 1.0, -6.0, -8.0, 8.0, -2.0, 1.0, 6.0, -5.0, 5.0, -7.0, -8.0, 9.0, 3.0, 6.0));
	block.var[2][0][2] = (mat4(-6.0, -4.0, 0.0, 8.0, -9.0, -6.0, 2.0, 6.0, 7.0, 5.0, 9.0, -6.0, -9.0, -5.0, 5.0, -5.0));
	block.var[2][1][0] = (mat4(-5.0, 2.0, -2.0, -1.0, 1.0, 4.0, 0.0, -1.0, -4.0, -1.0, 2.0, -4.0, 7.0, -7.0, -7.0, 1.0));
	block.var[2][1][1] = (mat4(-8.0, 7.0, -2.0, 3.0, 6.0, -2.0, -7.0, -7.0, -8.0, 7.0, 1.0, -1.0, -5.0, 6.0, -5.0, 6.0));
	block.var[2][1][2] = (mat4(-7.0, -1.0, -1.0, -1.0, -3.0, -6.0, 3.0, -9.0, -8.0, -5.0, 6.0, -3.0, 3.0, 8.0, -8.0, 5.0));
	block.var[3][0][0] = (mat4(3.0, 0.0, -2.0, -1.0, -6.0, -7.0, 9.0, -9.0, 8.0, 2.0, -7.0, -7.0, 9.0, 8.0, 7.0, -9.0));
	block.var[3][0][1] = (mat4(5.0, -4.0, -4.0, 9.0, -1.0, 3.0, -1.0, 7.0, 2.0, 8.0, -2.0, 2.0, -3.0, 0.0, -9.0, 5.0));
	block.var[3][0][2] = (mat4(-1.0, 6.0, 9.0, 1.0, -7.0, -5.0, -3.0, 4.0, 8.0, -9.0, -2.0, -2.0, -1.0, -1.0, 0.0, -4.0));
	block.var[3][1][0] = (mat4(-4.0, 6.0, 7.0, 5.0, 0.0, 0.0, -5.0, 4.0, -8.0, -9.0, -1.0, -8.0, 5.0, 0.0, -4.0, 2.0));
	block.var[3][1][1] = (mat4(7.0, -3.0, 8.0, -6.0, 0.0, 1.0, 7.0, 8.0, -8.0, -8.0, -9.0, -3.0, -1.0, -7.0, 0.0, 6.0));
	block.var[3][1][2] = (mat4(-2.0, -5.0, -4.0, -6.0, 9.0, -4.0, -9.0, 8.0, -7.0, -5.0, -3.0, 3.0, 5.0, 4.0, -2.0, -9.0));
}
#version 450
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
	i16vec2 var[4][2][3];
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
	allOk = compare_i16vec2(ivec2(block.var[0][0][0]), ivec2(-1, 8)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[0][0][1]), ivec2(-3, -4)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[0][0][2]), ivec2(2, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[0][1][0]), ivec2(2, 0)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[0][1][1]), ivec2(-4, -2)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[0][1][2]), ivec2(-2, 1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][0][0]), ivec2(-3, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][0][1]), ivec2(-9, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][0][2]), ivec2(-7, -6)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][1][0]), ivec2(0, -5)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][1][1]), ivec2(-5, -8)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][1][2]), ivec2(-1, -2)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][0][0]), ivec2(-3, -5)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][0][1]), ivec2(6, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][0][2]), ivec2(8, 1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][1][0]), ivec2(-8, -6)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][1][1]), ivec2(7, 8)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][1][2]), ivec2(-4, 0)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[3][0][0]), ivec2(1, 6)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[3][0][1]), ivec2(-6, 1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[3][0][2]), ivec2(1, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[3][1][0]), ivec2(-1, -2)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[3][1][1]), ivec2(-3, -6)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[3][1][2]), ivec2(6, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = int16_t(6);
	block.var[0][0][0] = i16vec2(ivec2(-2, -2));
	block.var[0][0][1] = i16vec2(ivec2(-8, 3));
	block.var[0][0][2] = i16vec2(ivec2(5, -9));
	block.var[0][1][0] = i16vec2(ivec2(9, 0));
	block.var[0][1][1] = i16vec2(ivec2(9, 0));
	block.var[0][1][2] = i16vec2(ivec2(5, 9));
	block.var[1][0][0] = i16vec2(ivec2(-9, -4));
	block.var[1][0][1] = i16vec2(ivec2(-3, -2));
	block.var[1][0][2] = i16vec2(ivec2(6, 0));
	block.var[1][1][0] = i16vec2(ivec2(-8, 4));
	block.var[1][1][1] = i16vec2(ivec2(6, -9));
	block.var[1][1][2] = i16vec2(ivec2(-9, 4));
	block.var[2][0][0] = i16vec2(ivec2(-1, 3));
	block.var[2][0][1] = i16vec2(ivec2(-9, 9));
	block.var[2][0][2] = i16vec2(ivec2(-6, -1));
	block.var[2][1][0] = i16vec2(ivec2(1, -5));
	block.var[2][1][1] = i16vec2(ivec2(-1, 4));
	block.var[2][1][2] = i16vec2(ivec2(-5, -6));
	block.var[3][0][0] = i16vec2(ivec2(-7, -1));
	block.var[3][0][1] = i16vec2(ivec2(-6, 6));
	block.var[3][0][2] = i16vec2(ivec2(5, 6));
	block.var[3][1][0] = i16vec2(ivec2(1, -8));
	block.var[3][1][1] = i16vec2(ivec2(4, -6));
	block.var[3][1][2] = i16vec2(ivec2(1, 8));
}
#version 450
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
	highp vec2 var[][4][2];
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
	allOk = compare_vec2((block.var[0][1][0]), vec2(4.0, -2.0)) && allOk;
	allOk = compare_vec2((block.var[0][1][1]), vec2(2.0, 2.0)) && allOk;
	allOk = compare_vec2((block.var[0][2][0]), vec2(-1.0, -4.0)) && allOk;
	allOk = compare_vec2((block.var[0][2][1]), vec2(6.0, -7.0)) && allOk;
	allOk = compare_vec2((block.var[0][3][0]), vec2(-5.0, 7.0)) && allOk;
	allOk = compare_vec2((block.var[0][3][1]), vec2(1.0, -2.0)) && allOk;
	allOk = compare_vec2((block.var[1][0][0]), vec2(-7.0, -5.0)) && allOk;
	allOk = compare_vec2((block.var[1][0][1]), vec2(-9.0, 7.0)) && allOk;
	allOk = compare_vec2((block.var[1][1][0]), vec2(-8.0, 3.0)) && allOk;
	allOk = compare_vec2((block.var[1][1][1]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((block.var[1][2][0]), vec2(-8.0, 7.0)) && allOk;
	allOk = compare_vec2((block.var[1][2][1]), vec2(2.0, -3.0)) && allOk;
	allOk = compare_vec2((block.var[1][3][0]), vec2(-3.0, -5.0)) && allOk;
	allOk = compare_vec2((block.var[1][3][1]), vec2(5.0, -8.0)) && allOk;
	allOk = compare_vec2((block.var[2][0][0]), vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec2((block.var[2][0][1]), vec2(-8.0, 2.0)) && allOk;
	allOk = compare_vec2((block.var[2][1][0]), vec2(7.0, 5.0)) && allOk;
	allOk = compare_vec2((block.var[2][1][1]), vec2(-6.0, -1.0)) && allOk;
	allOk = compare_vec2((block.var[2][2][0]), vec2(4.0, -5.0)) && allOk;
	allOk = compare_vec2((block.var[2][2][1]), vec2(-6.0, -4.0)) && allOk;
	allOk = compare_vec2((block.var[2][3][0]), vec2(-1.0, -7.0)) && allOk;
	allOk = compare_vec2((block.var[2][3][1]), vec2(-7.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec2(3.0, 8.0));
	block.var[0][0][1] = (vec2(7.0, -1.0));
	block.var[0][1][0] = (vec2(-6.0, -6.0));
	block.var[0][1][1] = (vec2(1.0, 6.0));
	block.var[0][2][0] = (vec2(-6.0, -2.0));
	block.var[0][2][1] = (vec2(5.0, 4.0));
	block.var[0][3][0] = (vec2(-4.0, -4.0));
	block.var[0][3][1] = (vec2(-2.0, -8.0));
	block.var[1][0][0] = (vec2(-4.0, 8.0));
	block.var[1][0][1] = (vec2(-2.0, -5.0));
	block.var[1][1][0] = (vec2(-7.0, 6.0));
	block.var[1][1][1] = (vec2(1.0, -6.0));
	block.var[1][2][0] = (vec2(0.0, 0.0));
	block.var[1][2][1] = (vec2(-4.0, -9.0));
	block.var[1][3][0] = (vec2(2.0, 9.0));
	block.var[1][3][1] = (vec2(-8.0, 9.0));
	block.var[2][0][0] = (vec2(-2.0, 5.0));
	block.var[2][0][1] = (vec2(6.0, -2.0));
	block.var[2][1][0] = (vec2(-9.0, 0.0));
	block.var[2][1][1] = (vec2(-8.0, -4.0));
	block.var[2][2][0] = (vec2(-2.0, 2.0));
	block.var[2][2][1] = (vec2(-2.0, 8.0));
	block.var[2][3][0] = (vec2(0.0, -8.0));
	block.var[2][3][1] = (vec2(1.0, 5.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0][0][0], mat2(-2.0, 3.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(8.0, 2.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(9.0, -3.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(-2.0, 8.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[0][2][0], mat2(6.0, -3.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[0][2][1], mat2(3.0, 6.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[0][3][0], mat2(6.0, -8.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[0][3][1], mat2(8.0, 4.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(3.0, 2.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(5.0, 8.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(3.0, 5.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(-8.0, -1.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[1][2][0], mat2(3.0, -9.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[1][2][1], mat2(6.0, -4.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[1][3][0], mat2(6.0, 4.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[1][3][1], mat2(5.0, -3.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(-7.0, 8.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(-6.0, 2.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(-6.0, 9.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(-7.0, 1.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[2][2][0], mat2(0.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[2][2][1], mat2(-4.0, 8.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[2][3][0], mat2(-6.0, -7.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[2][3][1], mat2(-8.0, -2.0, -3.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(5.0, -4.0));
	block.var[0][0][0][1] = (vec2(5.0, 1.0));
	block.var[0][0][1][0] = (vec2(-8.0, -1.0));
	block.var[0][0][1][1] = (vec2(9.0, -8.0));
	block.var[0][1][0][0] = (vec2(4.0, -3.0));
	block.var[0][1][0][1] = (vec2(6.0, 7.0));
	block.var[0][1][1][0] = (vec2(-7.0, -9.0));
	block.var[0][1][1][1] = (vec2(5.0, 0.0));
	block.var[0][2][0][0] = (vec2(7.0, 7.0));
	block.var[0][2][0][1] = (vec2(0.0, 2.0));
	block.var[0][2][1][0] = (vec2(4.0, -7.0));
	block.var[0][2][1][1] = (vec2(-5.0, -7.0));
	block.var[0][3][0][0] = (vec2(4.0, -2.0));
	block.var[0][3][0][1] = (vec2(6.0, 1.0));
	block.var[0][3][1][0] = (vec2(-2.0, -8.0));
	block.var[0][3][1][1] = (vec2(9.0, 1.0));
	block.var[1][0][0][0] = (vec2(5.0, -4.0));
	block.var[1][0][0][1] = (vec2(5.0, -2.0));
	block.var[1][0][1][0] = (vec2(9.0, -9.0));
	block.var[1][0][1][1] = (vec2(-1.0, 6.0));
	block.var[1][1][0][0] = (vec2(9.0, 2.0));
	block.var[1][1][0][1] = (vec2(1.0, -6.0));
	block.var[1][1][1][0] = (vec2(8.0, -8.0));
	block.var[1][1][1][1] = (vec2(5.0, -5.0));
	block.var[1][2][0][0] = (vec2(8.0, 2.0));
	block.var[1][2][0][1] = (vec2(1.0, -1.0));
	block.var[1][2][1][0] = (vec2(9.0, 0.0));
	block.var[1][2][1][1] = (vec2(-8.0, -9.0));
	block.var[1][3][0][0] = (vec2(3.0, 4.0));
	block.var[1][3][0][1] = (vec2(-1.0, 5.0));
	block.var[1][3][1][0] = (vec2(2.0, -6.0));
	block.var[1][3][1][1] = (vec2(7.0, -4.0));
	block.var[2][0][0][0] = (vec2(-4.0, 7.0));
	block.var[2][0][0][1] = (vec2(-8.0, 1.0));
	block.var[2][0][1][0] = (vec2(4.0, -4.0));
	block.var[2][0][1][1] = (vec2(6.0, -5.0));
	block.var[2][1][0][0] = (vec2(-5.0, 4.0));
	block.var[2][1][0][1] = (vec2(5.0, 0.0));
	block.var[2][1][1][0] = (vec2(6.0, 9.0));
	block.var[2][1][1][1] = (vec2(5.0, -8.0));
	block.var[2][2][0][0] = (vec2(-2.0, 7.0));
	block.var[2][2][0][1] = (vec2(8.0, 2.0));
	block.var[2][2][1][0] = (vec2(-3.0, -3.0));
	block.var[2][2][1][1] = (vec2(7.0, -2.0));
	block.var[2][3][0][0] = (vec2(5.0, 3.0));
	block.var[2][3][0][1] = (vec2(9.0, -9.0));
	block.var[2][3][1][0] = (vec2(7.0, 1.0));
	block.var[2][3][1][1] = (vec2(-5.0, -7.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0][0], mat4x3(5.0, 0.0, 3.0, -5.0, 9.0, -6.0, 8.0, -6.0, 6.0, 2.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][1], mat4x3(1.0, 7.0, 3.0, 4.0, 6.0, 2.0, -7.0, -9.0, -6.0, 1.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][0], mat4x3(-6.0, 1.0, 5.0, 9.0, -2.0, 8.0, 4.0, 6.0, -1.0, -2.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][1], mat4x3(5.0, -5.0, -3.0, 4.0, -3.0, -5.0, 8.0, 4.0, -8.0, -2.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2][0], mat4x3(6.0, -5.0, -6.0, 6.0, 3.0, -1.0, 3.0, 3.0, 7.0, 3.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2][1], mat4x3(-8.0, 2.0, 5.0, -7.0, 6.0, -6.0, -4.0, 3.0, 5.0, 1.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][3][0], mat4x3(9.0, 7.0, 1.0, 2.0, 8.0, 4.0, 2.0, -2.0, 1.0, 2.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][3][1], mat4x3(-3.0, -8.0, 7.0, -1.0, 8.0, -8.0, 6.0, -2.0, 2.0, -2.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][0], mat4x3(4.0, -7.0, -2.0, 5.0, -7.0, 6.0, 7.0, 1.0, -4.0, -7.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][1], mat4x3(8.0, 0.0, -3.0, -3.0, 9.0, 2.0, -6.0, 4.0, 1.0, -1.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][0], mat4x3(-6.0, -4.0, 6.0, -4.0, -8.0, 2.0, 3.0, -2.0, 0.0, -4.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][1], mat4x3(7.0, 4.0, -7.0, 3.0, 5.0, 4.0, 0.0, -1.0, 2.0, 6.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2][0], mat4x3(-3.0, 2.0, 2.0, -2.0, -2.0, 2.0, 5.0, 6.0, 3.0, -8.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2][1], mat4x3(-8.0, -7.0, 6.0, 1.0, 0.0, -2.0, -9.0, 5.0, 0.0, 5.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][3][0], mat4x3(9.0, 4.0, -9.0, -2.0, -3.0, -2.0, 2.0, 1.0, -8.0, 7.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][3][1], mat4x3(0.0, 4.0, 9.0, -3.0, 3.0, 5.0, 8.0, 3.0, 0.0, -3.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][0], mat4x3(7.0, -3.0, -4.0, 9.0, 3.0, 6.0, -1.0, -1.0, 6.0, -7.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][1], mat4x3(7.0, -9.0, -5.0, 9.0, 7.0, -1.0, -2.0, 7.0, -2.0, 0.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][0], mat4x3(-8.0, -7.0, -4.0, 9.0, 4.0, -9.0, -4.0, 2.0, -6.0, -4.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][1], mat4x3(-2.0, 3.0, 5.0, 2.0, -4.0, -5.0, -2.0, 4.0, 4.0, -3.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2][0], mat4x3(9.0, 5.0, 6.0, 9.0, -3.0, -5.0, -4.0, -2.0, 3.0, -9.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2][1], mat4x3(5.0, -9.0, -3.0, 8.0, -8.0, 6.0, 6.0, 8.0, -6.0, 5.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][3][0], mat4x3(5.0, -8.0, 5.0, 4.0, -4.0, 5.0, -2.0, 0.0, -4.0, 1.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][3][1], mat4x3(2.0, -5.0, -4.0, -7.0, 7.0, -3.0, 9.0, -4.0, -8.0, 1.0, -3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4x3(6.0, -7.0, 0.0, 3.0, -1.0, -9.0, -7.0, -5.0, 8.0, 0.0, 1.0, 5.0));
	block.var[0][0][1] = (mat4x3(7.0, 1.0, 5.0, 7.0, -8.0, 4.0, 2.0, -8.0, -8.0, 3.0, -6.0, -5.0));
	block.var[0][1][0] = (mat4x3(-6.0, 0.0, 1.0, -1.0, 4.0, 2.0, 0.0, -8.0, 7.0, -3.0, 1.0, -7.0));
	block.var[0][1][1] = (mat4x3(3.0, 8.0, 6.0, 5.0, 6.0, -2.0, -7.0, -5.0, 0.0, -4.0, -8.0, 5.0));
	block.var[0][2][0] = (mat4x3(-6.0, 9.0, 3.0, 4.0, 2.0, -2.0, -4.0, 3.0, 0.0, 4.0, -2.0, 0.0));
	block.var[0][2][1] = (mat4x3(6.0, -8.0, 4.0, 9.0, 3.0, 0.0, -8.0, -3.0, 5.0, 5.0, 7.0, 7.0));
	block.var[0][3][0] = (mat4x3(-9.0, -6.0, -4.0, -8.0, 0.0, 1.0, -9.0, -8.0, 1.0, 6.0, 3.0, -7.0));
	block.var[0][3][1] = (mat4x3(-8.0, -3.0, 4.0, -2.0, 5.0, -2.0, 4.0, 4.0, -7.0, 0.0, 0.0, -9.0));
	block.var[1][0][0] = (mat4x3(5.0, -7.0, 8.0, -7.0, -3.0, -4.0, -9.0, -9.0, -6.0, 5.0, -8.0, 1.0));
	block.var[1][0][1] = (mat4x3(-2.0, 3.0, -2.0, -9.0, 2.0, 9.0, -2.0, 8.0, -8.0, -8.0, -7.0, -5.0));
	block.var[1][1][0] = (mat4x3(3.0, -9.0, -8.0, -7.0, 3.0, 3.0, 3.0, -7.0, -5.0, -9.0, -1.0, -8.0));
	block.var[1][1][1] = (mat4x3(6.0, -5.0, 6.0, -8.0, -2.0, -6.0, 9.0, 0.0, 8.0, -9.0, -7.0, 1.0));
	block.var[1][2][0] = (mat4x3(-1.0, -4.0, -7.0, -7.0, 7.0, 9.0, -7.0, 3.0, 7.0, -6.0, -6.0, 8.0));
	block.var[1][2][1] = (mat4x3(7.0, -7.0, -8.0, -3.0, 8.0, -1.0, -8.0, 2.0, -9.0, 9.0, 0.0, -7.0));
	block.var[1][3][0] = (mat4x3(-5.0, -9.0, -7.0, 2.0, 1.0, 6.0, -3.0, 4.0, 2.0, 4.0, 3.0, -6.0));
	block.var[1][3][1] = (mat4x3(3.0, 5.0, 5.0, 8.0, -4.0, -5.0, 6.0, 5.0, -2.0, -2.0, -1.0, -1.0));
	block.var[2][0][0] = (mat4x3(7.0, -4.0, -6.0, -5.0, 0.0, 0.0, -6.0, -5.0, 1.0, 9.0, -4.0, -9.0));
	block.var[2][0][1] = (mat4x3(-5.0, 7.0, 2.0, 6.0, -1.0, -7.0, -9.0, -4.0, 5.0, -4.0, -3.0, 3.0));
	block.var[2][1][0] = (mat4x3(8.0, -5.0, 0.0, -7.0, -6.0, 2.0, 0.0, -8.0, 1.0, -5.0, -9.0, -2.0));
	block.var[2][1][1] = (mat4x3(1.0, 0.0, 8.0, -8.0, 6.0, 7.0, 6.0, 2.0, 0.0, 3.0, -4.0, -6.0));
	block.var[2][2][0] = (mat4x3(-4.0, -2.0, 9.0, 2.0, -9.0, 7.0, 0.0, -4.0, 0.0, -3.0, 4.0, -6.0));
	block.var[2][2][1] = (mat4x3(9.0, -7.0, 9.0, 4.0, -8.0, 9.0, 0.0, -6.0, -6.0, 4.0, 4.0, 3.0));
	block.var[2][3][0] = (mat4x3(-2.0, 6.0, 8.0, 5.0, 5.0, 5.0, 4.0, 1.0, 7.0, -4.0, 8.0, -2.0));
	block.var[2][3][1] = (mat4x3(4.0, 7.0, 3.0, 7.0, 5.0, 9.0, -9.0, -5.0, 0.0, 1.0, -1.0, -2.0));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
{
	highp ivec2 var[][4][2];
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
	allOk = compare_ivec2((block.var[0][1][0]), ivec2(-1, -1)) && allOk;
	allOk = compare_ivec2((block.var[0][1][1]), ivec2(0, 8)) && allOk;
	allOk = compare_ivec2((block.var[0][2][0]), ivec2(-4, 1)) && allOk;
	allOk = compare_ivec2((block.var[0][2][1]), ivec2(-3, -1)) && allOk;
	allOk = compare_ivec2((block.var[0][3][0]), ivec2(6, 3)) && allOk;
	allOk = compare_ivec2((block.var[0][3][1]), ivec2(-5, -3)) && allOk;
	allOk = compare_ivec2((block.var[1][0][0]), ivec2(-8, 8)) && allOk;
	allOk = compare_ivec2((block.var[1][0][1]), ivec2(-2, -6)) && allOk;
	allOk = compare_ivec2((block.var[1][1][0]), ivec2(-9, -5)) && allOk;
	allOk = compare_ivec2((block.var[1][1][1]), ivec2(6, 4)) && allOk;
	allOk = compare_ivec2((block.var[1][2][0]), ivec2(2, 1)) && allOk;
	allOk = compare_ivec2((block.var[1][2][1]), ivec2(-4, -3)) && allOk;
	allOk = compare_ivec2((block.var[1][3][0]), ivec2(-4, 7)) && allOk;
	allOk = compare_ivec2((block.var[1][3][1]), ivec2(-3, -4)) && allOk;
	allOk = compare_ivec2((block.var[2][0][0]), ivec2(6, 2)) && allOk;
	allOk = compare_ivec2((block.var[2][0][1]), ivec2(-2, 7)) && allOk;
	allOk = compare_ivec2((block.var[2][1][0]), ivec2(-8, 3)) && allOk;
	allOk = compare_ivec2((block.var[2][1][1]), ivec2(7, -6)) && allOk;
	allOk = compare_ivec2((block.var[2][2][0]), ivec2(-9, 0)) && allOk;
	allOk = compare_ivec2((block.var[2][2][1]), ivec2(9, 8)) && allOk;
	allOk = compare_ivec2((block.var[2][3][0]), ivec2(8, -5)) && allOk;
	allOk = compare_ivec2((block.var[2][3][1]), ivec2(-2, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (ivec2(-6, 8));
	block.var[0][0][1] = (ivec2(3, -1));
	block.var[0][1][0] = (ivec2(-6, -4));
	block.var[0][1][1] = (ivec2(3, -2));
	block.var[0][2][0] = (ivec2(4, 1));
	block.var[0][2][1] = (ivec2(1, 9));
	block.var[0][3][0] = (ivec2(-3, -1));
	block.var[0][3][1] = (ivec2(-4, 6));
	block.var[1][0][0] = (ivec2(-5, -2));
	block.var[1][0][1] = (ivec2(0, -2));
	block.var[1][1][0] = (ivec2(5, -7));
	block.var[1][1][1] = (ivec2(-3, 4));
	block.var[1][2][0] = (ivec2(-2, -9));
	block.var[1][2][1] = (ivec2(9, 6));
	block.var[1][3][0] = (ivec2(-4, -7));
	block.var[1][3][1] = (ivec2(-9, 1));
	block.var[2][0][0] = (ivec2(5, 2));
	block.var[2][0][1] = (ivec2(-8, 4));
	block.var[2][1][0] = (ivec2(1, 6));
	block.var[2][1][1] = (ivec2(8, 7));
	block.var[2][2][0] = (ivec2(-8, 1));
	block.var[2][2][1] = (ivec2(-3, 2));
	block.var[2][3][0] = (ivec2(8, 1));
	block.var[2][3][1] = (ivec2(-8, 3));
}
#version 450
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
	highp uvec2 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((block.var[0][0][0]), uvec2(6u, 0u)) && allOk;
	allOk = compare_uvec2((block.var[0][0][1]), uvec2(6u, 7u)) && allOk;
	allOk = compare_uvec2((block.var[0][1][0]), uvec2(0u, 2u)) && allOk;
	allOk = compare_uvec2((block.var[0][1][1]), uvec2(2u, 9u)) && allOk;
	allOk = compare_uvec2((block.var[0][2][0]), uvec2(7u, 7u)) && allOk;
	allOk = compare_uvec2((block.var[0][2][1]), uvec2(4u, 6u)) && allOk;
	allOk = compare_uvec2((block.var[0][3][0]), uvec2(8u, 6u)) && allOk;
	allOk = compare_uvec2((block.var[0][3][1]), uvec2(7u, 3u)) && allOk;
	allOk = compare_uvec2((block.var[1][0][0]), uvec2(1u, 7u)) && allOk;
	allOk = compare_uvec2((block.var[1][0][1]), uvec2(9u, 0u)) && allOk;
	allOk = compare_uvec2((block.var[1][1][0]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((block.var[1][1][1]), uvec2(1u, 4u)) && allOk;
	allOk = compare_uvec2((block.var[1][2][0]), uvec2(5u, 8u)) && allOk;
	allOk = compare_uvec2((block.var[1][2][1]), uvec2(9u, 9u)) && allOk;
	allOk = compare_uvec2((block.var[1][3][0]), uvec2(4u, 9u)) && allOk;
	allOk = compare_uvec2((block.var[1][3][1]), uvec2(3u, 2u)) && allOk;
	allOk = compare_uvec2((block.var[2][0][0]), uvec2(6u, 9u)) && allOk;
	allOk = compare_uvec2((block.var[2][0][1]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((block.var[2][1][0]), uvec2(7u, 1u)) && allOk;
	allOk = compare_uvec2((block.var[2][1][1]), uvec2(8u, 8u)) && allOk;
	allOk = compare_uvec2((block.var[2][2][0]), uvec2(2u, 1u)) && allOk;
	allOk = compare_uvec2((block.var[2][2][1]), uvec2(0u, 7u)) && allOk;
	allOk = compare_uvec2((block.var[2][3][0]), uvec2(4u, 8u)) && allOk;
	allOk = compare_uvec2((block.var[2][3][1]), uvec2(8u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (uvec2(6u, 1u));
	block.var[0][0][1] = (uvec2(8u, 1u));
	block.var[0][1][0] = (uvec2(8u, 4u));
	block.var[0][1][1] = (uvec2(6u, 3u));
	block.var[0][2][0] = (uvec2(6u, 2u));
	block.var[0][2][1] = (uvec2(6u, 0u));
	block.var[0][3][0] = (uvec2(0u, 1u));
	block.var[0][3][1] = (uvec2(2u, 6u));
	block.var[1][0][0] = (uvec2(7u, 4u));
	block.var[1][0][1] = (uvec2(6u, 6u));
	block.var[1][1][0] = (uvec2(6u, 0u));
	block.var[1][1][1] = (uvec2(3u, 5u));
	block.var[1][2][0] = (uvec2(3u, 2u));
	block.var[1][2][1] = (uvec2(5u, 1u));
	block.var[1][3][0] = (uvec2(9u, 1u));
	block.var[1][3][1] = (uvec2(4u, 6u));
	block.var[2][0][0] = (uvec2(5u, 8u));
	block.var[2][0][1] = (uvec2(4u, 7u));
	block.var[2][1][0] = (uvec2(2u, 4u));
	block.var[2][1][1] = (uvec2(7u, 8u));
	block.var[2][2][0] = (uvec2(7u, 2u));
	block.var[2][2][1] = (uvec2(3u, 6u));
	block.var[2][3][0] = (uvec2(4u, 2u));
	block.var[2][3][1] = (uvec2(7u, 5u));
}
#version 450
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
	allOk = compare_ivec3((block.s.a), ivec3(-3, -3, 3)) && allOk;
	allOk = compare_mat3(block.s.b[0], mat3(1.0, 1.0, -8.0, -2.0, -7.0, -1.0, 8.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3(block.s.b[1], mat3(-8.0, -2.0, 8.0, -3.0, 3.0, 8.0, 4.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3(block.s.b[2], mat3(-7.0, -4.0, 7.0, 5.0, 5.0, -8.0, -6.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat3(block.s.b[3], mat3(3.0, -1.0, -9.0, 7.0, 1.0, 1.0, 9.0, 2.0, -5.0)) && allOk;
	allOk = compare_vec4((block.s.c), vec4(5.0, -6.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat3(block.t.a, mat3(2.0, -5.0, -2.0, 1.0, 2.0, -5.0, -8.0, 1.0, 7.0)) && allOk;
	allOk = compare_ivec3((block.t.b.a), ivec3(8, -8, -6)) && allOk;
	allOk = compare_mat3(block.t.b.b[0], mat3(-5.0, 2.0, 5.0, -6.0, 9.0, 7.0, -3.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat3(block.t.b.b[1], mat3(5.0, 6.0, -7.0, -7.0, -5.0, 3.0, 6.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3(block.t.b.b[2], mat3(4.0, -2.0, -5.0, 9.0, -4.0, 3.0, 7.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat3(block.t.b.b[3], mat3(4.0, -5.0, 7.0, 4.0, -3.0, -8.0, 1.0, 3.0, -8.0)) && allOk;
	allOk = compare_vec4((block.t.b.c), vec4(7.0, 3.0, -2.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.t.a = (mat3(-8.0, 7.0, 9.0, 1.0, 5.0, -2.0, -6.0, -3.0, -1.0));
	block.t.b.a = (ivec3(-5, -1, 0));
	block.t.b.b[0] = (mat3(-3.0, 0.0, 5.0, -6.0, 2.0, 5.0, 1.0, -9.0, -2.0));
	block.t.b.b[1] = (mat3(9.0, -4.0, -9.0, -1.0, -3.0, -5.0, 9.0, 5.0, -9.0));
	block.t.b.b[2] = (mat3(4.0, 1.0, 1.0, -3.0, 3.0, 0.0, -8.0, -6.0, -5.0));
	block.t.b.b[3] = (mat3(0.0, 4.0, -2.0, -9.0, -4.0, 5.0, 3.0, 5.0, 9.0));
	block.t.b.c = (vec4(5.0, -8.0, 7.0, 0.0));
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
	allOk = compare_float((blockA.a), -5.0) && allOk;
	allOk = compare_float(blockA.c[0][0], 6.0) && allOk;
	allOk = compare_float(blockA.c[0][1], -3.0) && allOk;
	allOk = compare_float(blockA.c[1][0], -6.0) && allOk;
	allOk = compare_float(blockA.c[1][1], -2.0) && allOk;
	allOk = compare_vec2(blockA.c[0], vec2(6.0, -3.0)) && allOk;
	allOk = compare_vec2(blockA.c[1], vec2(-6.0, -2.0)) && allOk;
	allOk = compare_ivec2((blockB.b), ivec2(3, 6)) && allOk;
	allOk = compare_bool((blockB.d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (-9.0);
	blockB.a[0] = (vec3(1.0, -7.0, 9.0));
	blockB.a[1] = (vec3(9.0, -7.0, -8.0));
	blockB.a[2] = (vec3(3.0, -7.0, 8.0));
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

layout(std140, row_major, buffer_reference) buffer BlockB
{
	mediump mat4x2 a;
	bool b;
	lowp uint c;
};
layout(std140, buffer_reference) buffer BlockC
{
	mediump uvec4 d;
};
layout(std430, buffer_reference) buffer BlockD
{
	lowp mat3 e;
	mediump float f[1];
};
layout(std430, buffer_reference) buffer BlockE
{
	lowp ivec2 g;
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.c), 2u) && allOk;
	allOk = compare_uvec4((blockC.d), uvec4(8u, 4u, 0u, 3u)) && allOk;
	allOk = compare_mat3(blockD.e, mat3(8.0, 8.0, -3.0, 8.0, 5.0, -7.0, -3.0, -9.0, 5.0)) && allOk;
	allOk = compare_float((blockD.f[0]), -9.0) && allOk;
	allOk = compare_ivec2((blockE.g), ivec2(7, 4)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x2(-7.0, -3.0, 4.0, -9.0, -4.0, 1.0, -7.0, 2.0));
	blockB.b = (true);
	blockB.c = (6u);
	blockC.d = (uvec4(4u, 4u, 1u, 9u));
	blockD.f[0] = (1.0);
	blockE.g = (ivec2(3, 9));
}
#version 450
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
	lowp vec4 a;
	mediump vec3 b;
	lowp mat4x3 c;
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	bvec3 d;
	lowp float e;
	mediump uvec2 f;
	bvec2 g;
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	mediump float h;
	lowp mat2x3 i;
	bvec4 j;
};
layout(std430, column_major, buffer_reference) buffer BlockE
{
	bool k;
	highp uvec3 l;
	lowp uvec4 m;
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.b), vec3(-9.0, -4.0, 4.0)) && allOk;
	allOk = compare_float((blockC.e), -6.0) && allOk;
	allOk = compare_uvec2((blockC.f), uvec2(5u, 0u)) && allOk;
	allOk = compare_bvec2((blockC.g), bvec2(false, false)) && allOk;
	allOk = compare_mat2x3(blockD.i, mat2x3(-5.0, -9.0, -3.0, -5.0, 3.0, 0.0)) && allOk;
	allOk = compare_bvec4((blockD.j), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bool((blockE.k), true) && allOk;
	allOk = compare_uvec3((blockE.l), uvec3(1u, 6u, 7u)) && allOk;
	allOk = compare_uvec4((blockE.m), uvec4(2u, 2u, 6u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec4(-1.0, -4.0, 2.0, -1.0));
	blockB.b = (vec3(2.0, 2.0, -5.0));
	blockB.c = (mat4x3(7.0, -5.0, 5.0, -3.0, 4.0, -8.0, 9.0, -2.0, 5.0, -1.0, 9.0, 2.0));
	blockC.d = (bvec3(true, false, true));
	blockC.e = (5.0);
	blockC.f = (uvec2(6u, 4u));
	blockC.g = (bvec2(false, true));
	blockD.j = (bvec4(false, true, true, true));
	blockE.k = (true);
	blockE.l = (uvec3(9u, 7u, 1u));
}
#version 450
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
	highp ivec3 a;
	bvec3 b;
	bvec4 c[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	mediump ivec4 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a), ivec3(-7, 3, -2)) && allOk;
	allOk = compare_bvec4((blockB.c[0]), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec4((blockB.c[1]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((blockB.c[2]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((blockB.c[3]), bvec4(false, false, false, false)) && allOk;
	allOk = compare_bvec4((blockB.c[4]), bvec4(false, false, true, true)) && allOk;
	allOk = compare_ivec4((blockC.d[0]), ivec4(8, 9, 6, -2)) && allOk;
	allOk = compare_ivec4((blockC.d[1]), ivec4(-4, 1, 6, -4)) && allOk;
	allOk = compare_ivec4((blockC.d[2]), ivec4(8, -4, -1, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec3(-6, -2, 3));
	blockB.b = (bvec3(true, true, true));
	blockB.c[0] = (bvec4(false, false, true, false));
	blockB.c[1] = (bvec4(true, false, true, false));
	blockB.c[2] = (bvec4(false, false, false, true));
	blockB.c[3] = (bvec4(false, true, false, true));
	blockB.c[4] = (bvec4(false, false, false, true));
	blockC.d[0] = (ivec4(-3, -8, 6, -4));
	blockC.d[1] = (ivec4(-9, 8, -8, -5));
	blockC.d[2] = (ivec4(1, 4, 3, -9));
}
#version 450
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
	bool a;
	highp uvec2 b[];
};
layout(std430, buffer_reference) buffer BlockC
{
	mediump mat4x3 c;
	bvec2 d;
	mediump float e[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	lowp vec3 f;
	bvec2 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a), true) && allOk;
	allOk = compare_mat4x3(blockC.c, mat4x3(1.0, -6.0, -8.0, -5.0, 9.0, 7.0, -8.0, 1.0, 5.0, -5.0, -8.0, -7.0)) && allOk;
	allOk = compare_bvec2((blockC.d), bvec2(true, false)) && allOk;
	allOk = compare_float((blockC.e[0]), -5.0) && allOk;
	allOk = compare_float((blockC.e[1]), 7.0) && allOk;
	allOk = compare_float((blockC.e[2]), -8.0) && allOk;
	allOk = compare_float((blockC.e[3]), -4.0) && allOk;
	allOk = compare_float((blockC.e[4]), -3.0) && allOk;
	allOk = compare_float((blockC.e[5]), 5.0) && allOk;
	allOk = compare_bvec2((blockD.g[0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockD.g[1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockD.g[2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockD.g[3]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockD.g[4]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockD.g[5]), bvec2(false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (uvec2(1u, 4u));
	blockB.b[1] = (uvec2(8u, 7u));
	blockB.b[2] = (uvec2(2u, 2u));
	blockB.b[3] = (uvec2(9u, 4u));
	blockC.c = (mat4x3(6.0, 2.0, 9.0, 8.0, 5.0, -5.0, 8.0, -1.0, 7.0, -9.0, -3.0, -1.0));
	blockD.g[0] = (bvec2(true, false));
	blockD.g[1] = (bvec2(false, false));
	blockD.g[2] = (bvec2(false, true));
	blockD.g[3] = (bvec2(true, false));
	blockD.g[4] = (bvec2(true, true));
	blockD.g[5] = (bvec2(true, false));
}
#version 450
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
	highp vec3 mB;
	highp mat2 mC;
	mediump mat3x2 mD;
};
layout(std140, buffer_reference) buffer BlockB
{
	highp mat3x4 a;
	highp mat4x2 b[1];
	highp uint c;
	highp uvec3 d;
	bvec3 e[];
};
layout(std430, buffer_reference) buffer BlockC
{
	highp uvec2 f;
};
layout(std140, buffer_reference) buffer BlockD
{
	lowp mat3x2 g;
	mediump ivec3 h[];
};
layout(std430, buffer_reference) buffer BlockE
{
	lowp mat4x2 i;
	sA j[];
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
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB.a, mat3x4(0.0, -6.0, 9.0, -5.0, 0.0, 3.0, 7.0, -1.0, -8.0, 2.0, 8.0, -2.0)) && allOk;
	allOk = compare_uint((blockB.c), 7u) && allOk;
	allOk = compare_uvec3((blockB.d), uvec3(8u, 7u, 9u)) && allOk;
	allOk = compare_bvec3((blockB.e[0]), bvec3(false, false, false)) && allOk;
	allOk = compare_uvec2((blockC.f), uvec2(2u, 5u)) && allOk;
	allOk = compare_mat3x2(blockD.g, mat3x2(8.0, 0.0, 2.0, 2.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat4x2(blockE.i, mat4x2(9.0, -2.0, 7.0, 6.0, 3.0, -8.0, -8.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (mat4x2(-7.0, -8.0, 3.0, -6.0, -9.0, 9.0, -9.0, 9.0));
	blockB.c = (3u);
	blockB.d = (uvec3(5u, 5u, 6u));
	blockB.e[0] = (bvec3(true, false, false));
	blockC.f = (uvec2(5u, 7u));
	blockD.g = (mat3x2(-2.0, -6.0, -2.0, 5.0, -3.0, 2.0));
	blockE.i = (mat4x2(-8.0, -5.0, -3.0, -3.0, 0.0, 8.0, -9.0, 2.0));
}
#version 450
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
layout(std140, buffer_reference) buffer BlockB
{
	mediump uvec2 a[1];
	bvec4 b;
	sA c;
	lowp uvec3 d[];
};
layout(std140, buffer_reference) buffer BlockC
{
	mediump vec4 e;
	mediump mat3x2 f;
};
layout(std430, buffer_reference) buffer BlockD
{
	highp vec4 g;
	mediump vec4 h;
	highp vec4 i;
	mediump uvec3 j[][7];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[2];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.d[0]), uvec3(1u, 5u, 2u)) && allOk;
	allOk = compare_uvec3((blockB.d[1]), uvec3(0u, 0u, 3u)) && allOk;
	allOk = compare_uvec3((blockB.d[2]), uvec3(0u, 7u, 4u)) && allOk;
	allOk = compare_uvec3((blockB.d[3]), uvec3(8u, 9u, 8u)) && allOk;
	allOk = compare_uvec3((blockB.d[4]), uvec3(9u, 7u, 4u)) && allOk;
	allOk = compare_uvec3((blockB.d[5]), uvec3(2u, 9u, 7u)) && allOk;
	allOk = compare_uvec3((blockB.d[6]), uvec3(9u, 0u, 5u)) && allOk;
	allOk = compare_uvec3((blockB.d[7]), uvec3(6u, 5u, 7u)) && allOk;
	allOk = compare_vec4((blockC[0].e), vec4(-3.0, 1.0, 3.0, -9.0)) && allOk;
	allOk = compare_vec4((blockC[1].e), vec4(-5.0, 9.0, -7.0, -8.0)) && allOk;
	allOk = compare_vec4((blockD.g), vec4(-1.0, 5.0, -3.0, 0.0)) && allOk;
	allOk = compare_vec4((blockD.h), vec4(-8.0, 1.0, -9.0, -9.0)) && allOk;
	allOk = compare_vec4((blockD.i), vec4(-9.0, -7.0, 7.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c.mA = (ivec3(-8, -4, -6));
	blockC[0].e = (vec4(0.0, 7.0, 6.0, 5.0));
	blockC[0].f = (mat3x2(3.0, 3.0, -4.0, -6.0, 4.0, 2.0));
	blockC[1].e = (vec4(-6.0, 7.0, -8.0, 5.0));
	blockC[1].f = (mat3x2(6.0, 8.0, 9.0, 0.0, -7.0, -6.0));
	blockD.g = (vec4(-3.0, 8.0, 1.0, -3.0));
	blockD.i = (vec4(7.0, 8.0, -6.0, 1.0));
	blockD.j[0][0] = (uvec3(0u, 0u, 3u));
	blockD.j[0][1] = (uvec3(8u, 3u, 0u));
	blockD.j[0][2] = (uvec3(8u, 7u, 7u));
	blockD.j[0][3] = (uvec3(2u, 8u, 4u));
	blockD.j[0][4] = (uvec3(9u, 4u, 9u));
	blockD.j[0][5] = (uvec3(4u, 0u, 1u));
	blockD.j[0][6] = (uvec3(8u, 4u, 8u));
	blockD.j[1][0] = (uvec3(5u, 0u, 5u));
	blockD.j[1][1] = (uvec3(6u, 2u, 7u));
	blockD.j[1][2] = (uvec3(0u, 9u, 0u));
	blockD.j[1][3] = (uvec3(7u, 3u, 0u));
	blockD.j[1][4] = (uvec3(5u, 9u, 4u));
	blockD.j[1][5] = (uvec3(4u, 5u, 3u));
	blockD.j[1][6] = (uvec3(5u, 1u, 6u));
	blockD.j[2][0] = (uvec3(6u, 1u, 2u));
	blockD.j[2][1] = (uvec3(9u, 1u, 8u));
	blockD.j[2][2] = (uvec3(6u, 9u, 3u));
	blockD.j[2][3] = (uvec3(8u, 8u, 3u));
	blockD.j[2][4] = (uvec3(9u, 0u, 0u));
	blockD.j[2][5] = (uvec3(3u, 8u, 3u));
	blockD.j[2][6] = (uvec3(1u, 1u, 6u));
	blockD.j[3][0] = (uvec3(6u, 4u, 6u));
	blockD.j[3][1] = (uvec3(3u, 4u, 9u));
	blockD.j[3][2] = (uvec3(0u, 3u, 4u));
	blockD.j[3][3] = (uvec3(3u, 1u, 5u));
	blockD.j[3][4] = (uvec3(8u, 3u, 3u));
	blockD.j[3][5] = (uvec3(9u, 6u, 5u));
	blockD.j[3][6] = (uvec3(0u, 5u, 8u));
	blockD.j[4][0] = (uvec3(2u, 3u, 2u));
	blockD.j[4][1] = (uvec3(7u, 0u, 5u));
	blockD.j[4][2] = (uvec3(5u, 1u, 4u));
	blockD.j[4][3] = (uvec3(0u, 7u, 0u));
	blockD.j[4][4] = (uvec3(2u, 6u, 3u));
	blockD.j[4][5] = (uvec3(6u, 3u, 9u));
	blockD.j[4][6] = (uvec3(5u, 8u, 1u));
	blockD.j[5][0] = (uvec3(5u, 7u, 8u));
	blockD.j[5][1] = (uvec3(0u, 3u, 6u));
	blockD.j[5][2] = (uvec3(3u, 9u, 3u));
	blockD.j[5][3] = (uvec3(7u, 6u, 5u));
	blockD.j[5][4] = (uvec3(8u, 3u, 1u));
	blockD.j[5][5] = (uvec3(1u, 1u, 5u));
	blockD.j[5][6] = (uvec3(9u, 5u, 9u));
	blockD.j[6][0] = (uvec3(4u, 3u, 1u));
	blockD.j[6][1] = (uvec3(2u, 0u, 4u));
	blockD.j[6][2] = (uvec3(4u, 9u, 4u));
	blockD.j[6][3] = (uvec3(5u, 9u, 4u));
	blockD.j[6][4] = (uvec3(0u, 8u, 9u));
	blockD.j[6][5] = (uvec3(6u, 1u, 6u));
	blockD.j[6][6] = (uvec3(9u, 5u, 6u));
}
#version 450
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
	highp vec4 b;
	bvec2 c[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	bool d;
	lowp mat3x2 e[2];
	bvec2 f;
	bvec2 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB[0].c[0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockB[0].c[1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockB[0].c[2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockB[0].c[3]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockB[1].c[0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockB[1].c[1]), bvec2(true, true)) && allOk;
	allOk = compare_bool((blockC.d), true) && allOk;
	allOk = compare_mat3x2(blockC.e[0], mat3x2(-1.0, 6.0, -4.0, -2.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat3x2(blockC.e[1], mat3x2(-1.0, -6.0, -8.0, 7.0, -4.0, -1.0)) && allOk;
	allOk = compare_bvec2((blockC.f), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockC.g[0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockC.g[1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockC.g[2]), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (vec3(-7.0, 9.0, 6.0));
	blockB[0].b = (vec4(-4.0, -9.0, -3.0, 2.0));
	blockB[0].c[0] = (bvec2(true, false));
	blockB[0].c[1] = (bvec2(false, true));
	blockB[0].c[2] = (bvec2(false, true));
	blockB[0].c[3] = (bvec2(true, true));
	blockB[1].a = (vec3(-3.0, 5.0, 6.0));
	blockB[1].b = (vec4(0.0, 6.0, 1.0, 8.0));
	blockB[1].c[0] = (bvec2(true, false));
	blockB[1].c[1] = (bvec2(true, true));
	blockC.d = (false);
	blockC.e[0] = (mat3x2(6.0, -6.0, 3.0, -1.0, 7.0, -3.0));
	blockC.e[1] = (mat3x2(-2.0, 1.0, 9.0, 6.0, -6.0, 7.0));
	blockC.g[0] = (bvec2(true, true));
	blockC.g[1] = (bvec2(false, false));
	blockC.g[2] = (bvec2(true, false));
}
#version 450
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
	layout(offset = 16) bvec4 c;
	layout(offset = 32) bvec3 d;
	layout(offset = 44) highp int e;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) bvec3 f[1];
	layout(offset = 16) mediump uvec4 g;
	layout(offset = 32) bool h;
	layout(offset = 48) bvec4 i[1];
	layout(offset = 64) mediump vec4 j;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec3((blockC.d), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((blockD[0].f[0]), bvec3(true, false, false)) && allOk;
	allOk = compare_uvec4((blockD[0].g), uvec4(6u, 1u, 3u, 1u)) && allOk;
	allOk = compare_bool((blockD[0].h), true) && allOk;
	allOk = compare_bvec4((blockD[0].i[0]), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec3((blockD[1].f[0]), bvec3(true, true, true)) && allOk;
	allOk = compare_uvec4((blockD[1].g), uvec4(7u, 6u, 0u, 9u)) && allOk;
	allOk = compare_bool((blockD[1].h), true) && allOk;
	allOk = compare_bvec4((blockD[1].i[0]), bvec4(false, false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec4(true, false, true, true));
	blockC.b = (bvec2(false, false));
	blockC.c = (bvec4(false, false, false, false));
	blockC.d = (bvec3(true, false, true));
	blockC.e = (-6);
	blockD[0].f[0] = (bvec3(true, true, true));
	blockD[0].g = (uvec4(2u, 7u, 2u, 4u));
	blockD[0].h = (false);
	blockD[0].j = (vec4(-1.0, 2.0, 2.0, -8.0));
	blockD[1].f[0] = (bvec3(false, false, false));
	blockD[1].g = (uvec4(5u, 1u, 3u, 5u));
	blockD[1].h = (false);
	blockD[1].j = (vec4(-2.0, -2.0, -5.0, 6.0));
}
#version 450
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
	highp mat3 a[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	lowp mat4x2 b;
	lowp mat2 c[];
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	mediump mat3x4 d;
	highp uint e;
	lowp uvec4 f[3];
	mediump uvec4 g;
	mediump vec4 h[][6];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB.a[0], mat3(-5.0, -2.0, 3.0, 7.0, -6.0, 8.0, -6.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3(blockB.a[1], mat3(3.0, -7.0, 9.0, 3.0, -3.0, 3.0, 1.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3(blockB.a[2], mat3(-4.0, -9.0, 3.0, -4.0, 1.0, 9.0, -1.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(blockB.a[3], mat3(-3.0, 3.0, 2.0, -6.0, 9.0, 2.0, -6.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3(blockB.a[4], mat3(-6.0, -7.0, 2.0, 2.0, 6.0, 4.0, -9.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3(blockB.a[5], mat3(-2.0, 4.0, 6.0, -2.0, 1.0, 3.0, -7.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat3(blockB.a[6], mat3(-4.0, 0.0, -7.0, 0.0, 4.0, -1.0, -8.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat4x2(blockC.b, mat4x2(4.0, 7.0, 5.0, 0.0, 6.0, 3.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat2(blockC.c[0], mat2(-3.0, 7.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2(blockC.c[1], mat2(0.0, 1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].d, mat3x4(-3.0, 4.0, 5.0, -4.0, 8.0, -7.0, 3.0, 6.0, -7.0, 1.0, 3.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (mat4x2(-2.0, 4.0, 8.0, 7.0, -8.0, -2.0, 7.0, 6.0));
	blockD[0].d = (mat3x4(3.0, 6.0, -9.0, 8.0, 9.0, 6.0, -2.0, -9.0, -6.0, -8.0, 3.0, 4.0));
	blockD[0].e = (8u);
	blockD[0].g = (uvec4(4u, 8u, 2u, 4u));
	blockD[0].h[0][0] = (vec4(2.0, 2.0, -1.0, 0.0));
	blockD[0].h[0][1] = (vec4(0.0, -6.0, -3.0, 0.0));
	blockD[0].h[0][2] = (vec4(-8.0, -3.0, 6.0, -2.0));
	blockD[0].h[0][3] = (vec4(-2.0, -7.0, 2.0, 8.0));
	blockD[0].h[0][4] = (vec4(5.0, 3.0, -8.0, 3.0));
	blockD[0].h[0][5] = (vec4(7.0, -6.0, 4.0, -9.0));
	blockD[0].h[1][0] = (vec4(6.0, -5.0, 2.0, -8.0));
	blockD[0].h[1][1] = (vec4(-5.0, 0.0, -5.0, 3.0));
	blockD[0].h[1][2] = (vec4(0.0, 3.0, -7.0, -6.0));
	blockD[0].h[1][3] = (vec4(6.0, -1.0, 8.0, -3.0));
	blockD[0].h[1][4] = (vec4(-8.0, 1.0, 1.0, -5.0));
	blockD[0].h[1][5] = (vec4(-9.0, 0.0, -3.0, -1.0));
	blockD[0].h[2][0] = (vec4(-4.0, -8.0, 3.0, 9.0));
	blockD[0].h[2][1] = (vec4(-2.0, 0.0, 1.0, -6.0));
	blockD[0].h[2][2] = (vec4(-7.0, -9.0, -2.0, -1.0));
	blockD[0].h[2][3] = (vec4(2.0, 7.0, 4.0, 3.0));
	blockD[0].h[2][4] = (vec4(3.0, 4.0, 8.0, 0.0));
	blockD[0].h[2][5] = (vec4(9.0, 7.0, 0.0, -3.0));
	blockD[0].h[3][0] = (vec4(3.0, -1.0, -5.0, -8.0));
	blockD[0].h[3][1] = (vec4(-3.0, 0.0, 1.0, 8.0));
	blockD[0].h[3][2] = (vec4(-5.0, 8.0, -5.0, 3.0));
	blockD[0].h[3][3] = (vec4(4.0, -9.0, -4.0, 3.0));
	blockD[0].h[3][4] = (vec4(6.0, -4.0, -6.0, 7.0));
	blockD[0].h[3][5] = (vec4(-7.0, 9.0, 0.0, 5.0));
	blockD[0].h[4][0] = (vec4(-5.0, 7.0, -2.0, 3.0));
	blockD[0].h[4][1] = (vec4(1.0, -1.0, 8.0, 9.0));
	blockD[0].h[4][2] = (vec4(7.0, -1.0, -4.0, 9.0));
	blockD[0].h[4][3] = (vec4(-5.0, 6.0, -8.0, -5.0));
	blockD[0].h[4][4] = (vec4(8.0, 9.0, -4.0, 2.0));
	blockD[0].h[4][5] = (vec4(-2.0, -9.0, -5.0, -8.0));
	blockD[0].h[5][0] = (vec4(1.0, -9.0, -1.0, 5.0));
	blockD[0].h[5][1] = (vec4(3.0, -8.0, 9.0, -3.0));
	blockD[0].h[5][2] = (vec4(1.0, 6.0, 3.0, 6.0));
	blockD[0].h[5][3] = (vec4(-3.0, 4.0, -7.0, -6.0));
	blockD[0].h[5][4] = (vec4(-5.0, -9.0, -4.0, -7.0));
	blockD[0].h[5][5] = (vec4(-3.0, 3.0, -9.0, -1.0));
}
#version 450
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
	highp mat2x3 a[1];
	mediump uvec2 b;
	highp uvec4 c;
	bvec4 d;
	mediump uvec3 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB[nonuniformEXT(0)].a[0], mat2x3(2.0, -7.0, 6.0, -4.0, 7.0, 2.0)) && allOk;
	allOk = compare_uvec4((blockB[nonuniformEXT(0)].c), uvec4(0u, 0u, 4u, 9u)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(0)].d), bvec4(false, true, false, true)) && allOk;
	allOk = compare_mat2x3(blockB[nonuniformEXT(1)].a[0], mat2x3(3.0, -9.0, 5.0, 7.0, 1.0, 9.0)) && allOk;
	allOk = compare_uvec4((blockB[nonuniformEXT(1)].c), uvec4(0u, 7u, 1u, 9u)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(1)].d), bvec4(true, true, false, false)) && allOk;
	allOk = compare_mat2x3(blockB[nonuniformEXT(2)].a[0], mat2x3(7.0, 9.0, -5.0, -8.0, 4.0, 1.0)) && allOk;
	allOk = compare_uvec4((blockB[nonuniformEXT(2)].c), uvec4(8u, 6u, 5u, 6u)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(2)].d), bvec4(false, false, true, false)) && allOk;
	allOk = compare_mat2x3(blockB[nonuniformEXT(3)].a[0], mat2x3(7.0, 4.0, -2.0, -6.0, -7.0, 3.0)) && allOk;
	allOk = compare_uvec4((blockB[nonuniformEXT(3)].c), uvec4(7u, 0u, 5u, 1u)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(3)].d), bvec4(true, true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = (uvec2(0u, 9u));
	blockB[nonuniformEXT(0)].c = (uvec4(9u, 1u, 9u, 5u));
	blockB[nonuniformEXT(0)].d = (bvec4(true, false, true, true));
	blockB[nonuniformEXT(0)].e = (uvec3(8u, 0u, 7u));
	blockB[nonuniformEXT(1)].b = (uvec2(3u, 1u));
	blockB[nonuniformEXT(1)].c = (uvec4(3u, 8u, 0u, 1u));
	blockB[nonuniformEXT(1)].d = (bvec4(false, true, false, false));
	blockB[nonuniformEXT(1)].e = (uvec3(6u, 5u, 8u));
	blockB[nonuniformEXT(2)].b = (uvec2(8u, 0u));
	blockB[nonuniformEXT(2)].c = (uvec4(0u, 8u, 7u, 1u));
	blockB[nonuniformEXT(2)].d = (bvec4(true, true, true, false));
	blockB[nonuniformEXT(2)].e = (uvec3(2u, 6u, 6u));
	blockB[nonuniformEXT(3)].b = (uvec2(9u, 8u));
	blockB[nonuniformEXT(3)].c = (uvec4(3u, 4u, 6u, 2u));
	blockB[nonuniformEXT(3)].d = (bvec4(true, false, true, true));
	blockB[nonuniformEXT(3)].e = (uvec3(9u, 5u, 1u));
}
#version 450
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
	highp uvec3 a;
	f16vec2 b;
};
layout(std430, buffer_reference) buffer BlockC
{
	bvec3 c;
};
layout(std430, buffer_reference) readonly buffer BlockD
{
	mediump int d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockC.c), bvec3(true, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = f16vec2(vec2(-2.0, 9.0));
	blockC.c = (bvec3(true, true, false));
}
#version 450
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
	i16vec3 mB;
	mediump float mC;
	lowp uvec3 mD;
};
struct sB
{
	bool mA;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	lowp uint a;
	lowp mat2 b;
	highp uvec3 c;
	lowp ivec4 d[];
};
layout(std430, buffer_reference) buffer BlockC
{
	highp ivec4 e;
	sA f;
	mediump vec3 g;
	i16vec3 h[];
};
layout(std140, buffer_reference) buffer BlockD
{
	bvec3 i;
	sB j;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB.b, mat2(-6.0, 7.0, -5.0, 2.0)) && allOk;
	allOk = compare_uvec3((blockB.c), uvec3(7u, 9u, 2u)) && allOk;
	allOk = compare_ivec4((blockC.e), ivec4(3, 8, 1, 9)) && allOk;
	allOk = compare_vec3((blockC.g), vec3(0.0, 1.0, -3.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockC.h[0]), ivec3(1, 6, 6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat2(7.0, -2.0, 5.0, 9.0));
	blockB.c = (uvec3(8u, 4u, 7u));
	blockB.d[0] = (ivec4(-4, -1, -9, 0));
	blockC.e = (ivec4(0, 6, -6, -5));
	blockC.f.mA = (ivec3(2, 3, 0));
	blockC.f.mB = i16vec3(ivec3(4, -4, -4));
	blockC.f.mC = (1.0);
	blockC.f.mD = (uvec3(9u, 5u, 7u));
	blockC.g = (vec3(4.0, -4.0, -7.0));
	blockC.h[0] = i16vec3(ivec3(8, -8, 1));
	blockD[0].i = (bvec3(true, true, false));
	blockD[0].j.mA = (false);
	blockD[1].i = (bvec3(true, false, false));
	blockD[1].j.mA = (true);
	blockD[2].i = (bvec3(true, true, true));
	blockD[2].j.mA = (true);
}
#version 450
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
	mediump vec4 a;
	i16vec3 b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(blockB.b[0]), ivec3(9, -5, 7)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB.b[1]), ivec3(7, 0, 5)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB.b[2]), ivec3(-7, -5, -2)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB.b[3]), ivec3(-1, 5, 2)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB.b[4]), ivec3(-4, 7, 7)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB.b[5]), ivec3(-1, 3, -2)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec4(3.0, -4.0, 2.0, 2.0));
}
#version 450
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
	layout(offset = 0) highp uint a;
	layout(offset = 16) highp uvec4 b;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) i16vec3 c;
	layout(offset = 6) f16vec2 d;
	layout(offset = 12) mediump uint e;
	layout(offset = 16) f16vec3 f;
	layout(offset = 22) u16vec3 g;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) lowp uvec4 h;
	layout(offset = 16) highp ivec4 i;
	layout(offset = 32) uint16_t j;
	layout(offset = 34) i16vec4 k;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) float16_t l;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 5u) && allOk;
	allOk = compare_i16vec3(ivec3(blockC.c), ivec3(7, 6, -9)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d), vec2(6.0, -2.0)) && allOk;
	allOk = compare_uint((blockC.e), 5u) && allOk;
	allOk = compare_f16vec3(vec3(blockC.f), vec3(-1.0, 2.0, 9.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.g), uvec3(9u, 1u, 2u)) && allOk;
	allOk = compare_uvec4((blockD.h), uvec4(1u, 8u, 7u, 5u)) && allOk;
	allOk = compare_ivec4((blockD.i), ivec4(6, -8, 7, 8)) && allOk;
	allOk = compare_uint16_t(uint(blockD.j), 2u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (3u);
	blockB.b = (uvec4(1u, 0u, 0u, 3u));
	blockC.d = f16vec2(vec2(-7.0, 2.0));
	blockC.e = (8u);
	blockC.g = u16vec3(uvec3(8u, 9u, 5u));
	blockD.h = (uvec4(5u, 0u, 1u, 5u));
	blockD.i = (ivec4(-4, 5, 4, 5));
	blockD.j = uint16_t(9u);
	blockD.k = i16vec4(ivec4(2, 5, 2, -7));
	blockE.l = float16_t(1.0);
}
#version 450
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
	highp mat3x2 d;
};
layout(std140, buffer_reference) buffer BlockC
{
	highp mat3x2 e;
	i8vec4 f;
	u8vec3 g;
	bvec4 h;
	bvec4 i;
};
layout(std140, buffer_reference) buffer BlockD
{
	int8_t j[2];
};
layout(std140, buffer_reference) buffer BlockE
{
	u8vec3 k;
	u8vec3 l;
	lowp vec4 m[4];
	lowp mat3x4 n;
	highp vec2 o;
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB.a, mat3(-8.0, 9.0, 9.0, -7.0, -4.0, -4.0, -6.0, -2.0, 8.0)) && allOk;
	allOk = compare_int((blockB.b), 4) && allOk;
	allOk = compare_mat3x2(blockB.d, mat3x2(9.0, -1.0, -1.0, 6.0, 1.0, 1.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.f), ivec4(0, 4294967295, 1, 4294967288)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.g), uvec3(3u, 5u, 0u)) && allOk;
	allOk = compare_bvec4((blockC.h), bvec4(false, false, true, false)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE.l), uvec3(0u, 5u, 7u)) && allOk;
	allOk = compare_vec4((blockE.m[0]), vec4(0.0, -7.0, -9.0, 6.0)) && allOk;
	allOk = compare_vec4((blockE.m[1]), vec4(4.0, 5.0, 3.0, -1.0)) && allOk;
	allOk = compare_vec4((blockE.m[2]), vec4(1.0, 1.0, -7.0, 8.0)) && allOk;
	allOk = compare_vec4((blockE.m[3]), vec4(8.0, 0.0, -2.0, -5.0)) && allOk;
	allOk = compare_vec2((blockE.o), vec2(-7.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3(4.0, 0.0, 9.0, 4.0, 1.0, -7.0, -4.0, -4.0, -6.0));
	blockB.b = (-5);
	blockB.c = (mat4(-2.0, 4.0, -2.0, 5.0, -9.0, -3.0, -1.0, -9.0, 1.0, 1.0, 7.0, 8.0, 9.0, -7.0, -1.0, -6.0));
	blockB.d = (mat3x2(5.0, 6.0, 5.0, 6.0, -6.0, -9.0));
	blockC.e = (mat3x2(3.0, -7.0, -4.0, -6.0, -5.0, 3.0));
	blockC.f = i8vec4(ivec4(4294967287, 4294967290, 4294967293, 4294967289));
	blockC.g = u8vec3(uvec3(5u, 1u, 5u));
	blockC.h = (bvec4(false, false, false, false));
	blockC.i = (bvec4(false, false, false, false));
	blockD.j[0] = int8_t(4294967293);
	blockD.j[1] = int8_t(0);
	blockE.k = u8vec3(uvec3(1u, 5u, 3u));
	blockE.l = u8vec3(uvec3(4u, 7u, 5u));
	blockE.n = (mat3x4(-4.0, -5.0, 8.0, -8.0, -8.0, 6.0, 4.0, 5.0, 8.0, 3.0, -1.0, 1.0));
	blockE.o = (vec2(0.0, -9.0));
}
#version 450
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
	u8vec4 b;
	highp uint c;
	highp mat3 d;
	highp int e[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	lowp float f;
	bvec4 g;
	u8vec2 h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(blockB.a), uvec2(2u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB.b), uvec4(3u, 0u, 8u, 2u)) && allOk;
	allOk = compare_uint((blockB.c), 7u) && allOk;
	allOk = compare_int((blockB.e[0]), 7) && allOk;
	allOk = compare_int((blockB.e[1]), -7) && allOk;
	allOk = compare_bvec4((blockC.g), bvec4(false, false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u8vec2(uvec2(4u, 9u));
	blockB.b = u8vec4(uvec4(2u, 4u, 5u, 7u));
	blockB.c = (9u);
	blockC.f = (-6.0);
	blockC.g = (bvec4(false, false, true, false));
	blockC.h[0] = u8vec2(uvec2(0u, 0u));
	blockC.h[1] = u8vec2(uvec2(5u, 9u));
	blockC.h[2] = u8vec2(uvec2(1u, 7u));
	blockC.h[3] = u8vec2(uvec2(0u, 5u));
	blockC.h[4] = u8vec2(uvec2(5u, 5u));
	blockC.h[5] = u8vec2(uvec2(3u, 6u));
	blockC.h[6] = u8vec2(uvec2(6u, 5u));
}
#version 450
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
	mediump uint a[3];
	highp uint b;
	i8vec2 c;
	highp mat2 d[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	highp ivec3 e;
	mediump mat2 f;
	highp ivec4 g[];
};
layout(std140, buffer_reference) buffer BlockD
{
	lowp mat3 h;
	lowp mat2 i;
	u8vec4 j;
	mediump float k[];
};
layout(std140, column_major, buffer_reference) readonly buffer BlockE
{
	u8vec3 l;
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
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.b), 6u) && allOk;
	allOk = compare_ivec3((blockC.e), ivec3(5, -5, -8)) && allOk;
	allOk = compare_ivec4((blockC.g[0]), ivec4(-5, 7, -8, -4)) && allOk;
	allOk = compare_mat3(blockD.h, mat3(-3.0, 5.0, 0.0, -2.0, 3.0, 0.0, 8.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2(blockD.i, mat2(6.0, -7.0, -9.0, 8.0)) && allOk;
	allOk = compare_float((blockD.k[0]), 5.0) && allOk;
	allOk = compare_float((blockD.k[1]), 1.0) && allOk;
	allOk = compare_float((blockD.k[2]), -5.0) && allOk;
	allOk = compare_float((blockD.k[3]), -8.0) && allOk;
	allOk = compare_float((blockD.k[4]), -6.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (8u);
	blockB.a[1] = (3u);
	blockB.a[2] = (1u);
	blockB.b = (4u);
	blockB.c = i8vec2(ivec2(4294967293, 9));
	blockC.e = (ivec3(7, -9, -3));
	blockC.g[0] = (ivec4(9, -4, 2, -4));
	blockD.i = (mat2(-8.0, 6.0, 2.0, -1.0));
}
#version 450
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
layout(std140, row_major, buffer_reference) buffer BlockB
{
	mediump ivec3 a;
	mediump uvec4 b;
	u8vec3 c;
	lowp mat4x3 d;
	sA e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a), ivec3(-4, 4, -6)) && allOk;
	allOk = compare_uvec4((blockB.b), uvec4(4u, 9u, 5u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (uvec4(8u, 8u, 2u, 9u));
	blockB.d = (mat4x3(0.0, 4.0, -6.0, -8.0, -2.0, 3.0, -9.0, -5.0, -5.0, 5.0, 5.0, 0.0));
	blockB.e.mA[0] = i8vec4(ivec4(4294967287, 3, 4294967287, 4294967295));
	blockB.e.mA[1] = i8vec4(ivec4(6, 2, 7, 4294967295));
}
#version 450
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
	i8vec4 mB;
};
struct sB
{
	u8vec3 mA;
	lowp mat3 mB;
	sA mC;
	u8vec3 mD;
};
layout(std430, row_major, buffer_reference) readonly buffer BlockB
{
	mediump mat4x3 a;
	highp vec2 b;
	sB c;
	lowp mat4 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(blockB[0].c.mA), uvec3(6u, 2u, 9u)) && allOk;
	allOk = compare_mat3(blockB[0].c.mB, mat3(8.0, -8.0, -2.0, 3.0, 8.0, -7.0, 4.0, 4.0, -6.0)) && allOk;
	allOk = compare_uvec4((blockB[0].c.mC.mA), uvec4(0u, 8u, 5u, 8u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[0].c.mC.mB), ivec4(4294967293, 2, 4294967290, 9)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB[0].c.mD), uvec3(1u, 1u, 1u)) && allOk;
	allOk = compare_mat4(blockB[0].d[0], mat4(-5.0, -4.0, -4.0, 5.0, -6.0, 8.0, 5.0, 3.0, -5.0, 1.0, -3.0, -7.0, -8.0, -9.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4(blockB[0].d[1], mat4(-4.0, -3.0, 5.0, 2.0, -7.0, 8.0, -9.0, 5.0, 2.0, 5.0, -7.0, 1.0, 5.0, 1.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4(blockB[0].d[2], mat4(9.0, 5.0, -3.0, 0.0, 0.0, -3.0, -5.0, 6.0, -6.0, -6.0, 2.0, -9.0, -9.0, 2.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat4(blockB[0].d[3], mat4(9.0, -3.0, -6.0, -7.0, -3.0, 7.0, -6.0, -9.0, 8.0, -7.0, -6.0, -7.0, 2.0, -6.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat4(blockB[0].d[4], mat4(-7.0, 1.0, 4.0, -8.0, 3.0, 9.0, 3.0, -2.0, 7.0, -5.0, 0.0, -8.0, 4.0, 2.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4(blockB[0].d[5], mat4(1.0, 6.0, -3.0, 5.0, 5.0, 4.0, -2.0, 1.0, 3.0, 8.0, -9.0, -4.0, 1.0, 3.0, 2.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(blockB.a), uvec3(0u, 6u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u8vec3(uvec3(0u, 7u, 8u));
}
#version 450
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
	layout(offset = 4) mediump float b;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) i8vec3 c;
	layout(offset = 4) mediump uint d;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) u8vec4 e;
	layout(offset = 16) highp ivec4 f;
	layout(offset = 32) lowp vec3 g;
	layout(offset = 44) highp uint h;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) mediump uvec4 i;
	layout(offset = 16) mediump uint j;
	layout(offset = 20) mediump uvec3 k;
	layout(offset = 32) lowp vec3 l;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(blockB.a), uvec2(9u, 2u)) && allOk;
	allOk = compare_float((blockB.b), 3.0) && allOk;
	allOk = compare_u8vec4(uvec4(blockD.e), uvec4(4u, 8u, 1u, 5u)) && allOk;
	allOk = compare_ivec4((blockD.f), ivec4(8, -7, 5, -4)) && allOk;
	allOk = compare_uvec4((blockE.i), uvec4(9u, 0u, 1u, 4u)) && allOk;
	allOk = compare_uint((blockE.j), 5u) && allOk;
	allOk = compare_uvec3((blockE.k), uvec3(7u, 1u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u8vec2(uvec2(3u, 6u));
	blockB.b = (-8.0);
	blockC.c = i8vec3(ivec3(4294967293, 8, 4294967290));
	blockC.d = (2u);
	blockD.f = (ivec4(6, -1, -5, 0));
	blockD.g = (vec3(8.0, -1.0, 4.0));
	blockD.h = (2u);
	blockE.i = (uvec4(8u, 3u, 3u, 8u));
	blockE.j = (7u);
	blockE.l = (vec3(-1.0, 9.0, 1.0));
}
