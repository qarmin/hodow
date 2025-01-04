#version 450
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
	allOk = compare_mat3(var, mat3(6.0, -1.0, 3.0, 8.0, -4.0, 9.0, 0.0, 8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(-6.0, -9.0, 5.0));
	var[1] = (vec3(8.0, -2.0, 3.0));
	var[2] = (vec3(2.0, -2.0, 4.0));
}
#version 450
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
	mediump mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -2.0) && allOk;
	allOk = compare_float(var[0][1], -5.0) && allOk;
	allOk = compare_float(var[0][2], 0.0) && allOk;
	allOk = compare_float(var[0][3], 1.0) && allOk;
	allOk = compare_float(var[1][0], -2.0) && allOk;
	allOk = compare_float(var[1][1], 8.0) && allOk;
	allOk = compare_float(var[1][2], -8.0) && allOk;
	allOk = compare_float(var[1][3], -4.0) && allOk;
	allOk = compare_float(var[2][0], 5.0) && allOk;
	allOk = compare_float(var[2][1], 8.0) && allOk;
	allOk = compare_float(var[2][2], -5.0) && allOk;
	allOk = compare_float(var[2][3], -2.0) && allOk;
	allOk = compare_float(var[3][0], -9.0) && allOk;
	allOk = compare_float(var[3][1], 3.0) && allOk;
	allOk = compare_float(var[3][2], -9.0) && allOk;
	allOk = compare_float(var[3][3], -2.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-2.0, -5.0, 0.0, 1.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-2.0, 8.0, -8.0, -4.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(5.0, 8.0, -5.0, -2.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(-9.0, 3.0, -9.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(-4.0, -3.0, -1.0, -1.0));
	var[1] = (vec4(6.0, -6.0, 8.0, -4.0));
	var[2] = (vec4(-5.0, 6.0, 5.0, 5.0));
	var[3] = (vec4(3.0, 2.0, -5.0, -7.0));
}
#version 450
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
	u8vec3 var;
};

bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(var), uvec3(4u, 3u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = u8vec3(uvec3(4u, 5u, 9u));
}
#version 450
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
	uint16_t var;
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(var), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

	var = uint16_t(9u);
}
#version 450
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
};

bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(var), ivec4(-6, -9, 9, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = i16vec4(ivec4(-4, -8, -4, 9));
}
#version 450
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
	lowp mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -6.0) && allOk;
	allOk = compare_float(var[0][1], 3.0) && allOk;
	allOk = compare_float(var[1][0], -2.0) && allOk;
	allOk = compare_float(var[1][1], 9.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-6.0, 3.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-2.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec2(1.0, -9.0));
	var[1] = (vec2(-7.0, 2.0));
}
#version 450
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

layout(std430, row_major, binding = 1) buffer Block
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

	var[0] = (vec3(1.0, 5.0, -2.0));
	var[1] = (vec3(7.0, 8.0, -1.0));
}
#version 450
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
	mediump vec3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_vec3((var), vec3(0.0, 2.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (6.0);
	var = (vec3(8.0, -1.0, 9.0));
}
#version 450
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

layout(scalar, column_major, binding = 1) buffer Block
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

	padding = (2.0);
	var[0] = (vec3(-8.0, -5.0, -6.0));
	var[1] = (vec3(3.0, -9.0, 7.0));
	var[2] = (vec3(-3.0, 6.0, -4.0));
}
#version 450
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
	lowp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_float(var[0][0], 9.0) && allOk;
	allOk = compare_float(var[0][1], -8.0) && allOk;
	allOk = compare_float(var[0][2], 5.0) && allOk;
	allOk = compare_float(var[1][0], 9.0) && allOk;
	allOk = compare_float(var[1][1], 8.0) && allOk;
	allOk = compare_float(var[1][2], 7.0) && allOk;
	allOk = compare_vec3(var[0], vec3(9.0, -8.0, 5.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(9.0, 8.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-7.0);
	var[0] = (vec3(2.0, 1.0, 8.0));
	var[1] = (vec3(3.0, 9.0, -8.0));
}
#version 450
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

	padding = (6.0);
	var = (mat3x4(7.0, -9.0, -7.0, 8.0, 0.0, -5.0, -6.0, 0.0, -3.0, -8.0, 3.0, -9.0));
}
#version 450
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
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_mat4x2(var, mat4x2(9.0, 3.0, -7.0, 8.0, 0.0, 9.0, -8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (6.0);
	var[0] = (vec2(0.0, -6.0));
	var[1] = (vec2(-8.0, -6.0));
	var[2] = (vec2(-7.0, -7.0));
	var[3] = (vec2(1.0, 5.0));
}
#version 450
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
	u16vec2 var;
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(padding), 8u) && allOk;
	allOk = compare_u16vec2(uvec2(var), uvec2(4u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = uint16_t(8u);
	var = u16vec2(uvec2(0u, 6u));
}
#version 450
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

layout(std140, row_major, binding = 1) buffer Block
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

	var[0] = (mat2x3(-9.0, -3.0, 4.0, -1.0, 8.0, -5.0));
	var[1] = (mat2x3(-4.0, -8.0, -3.0, 1.0, -5.0, 6.0));
	var[2] = (mat2x3(0.0, 4.0, 6.0, 2.0, -1.0, -7.0));
}
#version 450
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
	highp mat4x2 var[3];
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
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4x2(0.0, -3.0, -2.0, 2.0, -2.0, -3.0, 5.0, -5.0));
	var[1] = (mat4x2(5.0, -6.0, -4.0, -1.0, 4.0, 7.0, -8.0, -2.0));
	var[2] = (mat4x2(-5.0, -1.0, -3.0, 6.0, -2.0, 0.0, -7.0, -7.0));
}
#version 450
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

	var[0] = (ivec3(-5, 0, -9));
	var[1] = (ivec3(2, 4, 1));
	var[2] = (ivec3(6, 6, 2));
}
#version 450
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
	highp mat2x3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0], mat2x3(2.0, -7.0, 8.0, 7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(5.0, -2.0, 1.0, -7.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(6.0, 7.0, 2.0, -2.0, -3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat2x3(0.0, 6.0, 9.0, 9.0, -8.0, 7.0));
	var[1] = (mat2x3(5.0, -1.0, -9.0, 0.0, 8.0, 1.0));
	var[2] = (mat2x3(-7.0, 2.0, 4.0, -8.0, 4.0, 4.0));
}
#version 450
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
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat3(var[0], mat3(1.0, -5.0, -1.0, 3.0, 7.0, 4.0, 7.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(7.0, -6.0, -4.0, 7.0, -1.0, -5.0, -8.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(-3.0, 1.0, -3.0, -8.0, 8.0, 8.0, 2.0, -3.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-2.0);
	var[0] = (mat3(7.0, 5.0, 2.0, 9.0, -1.0, -9.0, -7.0, 1.0, 6.0));
	var[1] = (mat3(-1.0, -8.0, -8.0, 0.0, 9.0, 1.0, -5.0, 8.0, 1.0));
	var[2] = (mat3(-6.0, -1.0, 9.0, -6.0, 0.0, 5.0, -4.0, 5.0, -4.0));
}
#version 450
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
	allOk = compare_float((padding), 0.0) && allOk;
	allOk = compare_mat4x2(var[0], mat4x2(6.0, -3.0, 7.0, 1.0, -8.0, 8.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(-3.0, -5.0, 5.0, 5.0, 1.0, -7.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(1.0, -2.0, -3.0, -9.0, 3.0, 9.0, -7.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (8.0);
	var[0] = (mat4x2(-5.0, 3.0, 0.0, -9.0, 4.0, -5.0, 3.0, 6.0));
	var[1] = (mat4x2(3.0, 6.0, -6.0, 0.0, -3.0, -2.0, -4.0, 5.0));
	var[2] = (mat4x2(4.0, 1.0, 0.0, 7.0, -9.0, -4.0, 5.0, 6.0));
}
#version 450
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
	highp mat2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0][0], mat2(-7.0, -2.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat2(var[0][1], mat2(0.0, 4.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2(var[0][2], mat2(-2.0, -1.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat2(var[1][0], mat2(6.0, -4.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat2(var[1][1], mat2(3.0, 2.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(var[1][2], mat2(8.0, -3.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat2(var[2][0], mat2(2.0, -7.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2(var[2][1], mat2(-7.0, 8.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2(var[2][2], mat2(3.0, -1.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat2(var[3][0], mat2(2.0, -7.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat2(var[3][1], mat2(1.0, 7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(var[3][2], mat2(-5.0, -4.0, -3.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat2(1.0, 2.0, 6.0, -6.0));
	var[0][1] = (mat2(2.0, 4.0, 4.0, 7.0));
	var[0][2] = (mat2(0.0, 8.0, 0.0, -1.0));
	var[1][0] = (mat2(8.0, -4.0, -5.0, 7.0));
	var[1][1] = (mat2(-3.0, -1.0, 0.0, 6.0));
	var[1][2] = (mat2(-6.0, 7.0, 4.0, -7.0));
	var[2][0] = (mat2(1.0, -8.0, -9.0, -7.0));
	var[2][1] = (mat2(1.0, -2.0, -6.0, -8.0));
	var[2][2] = (mat2(-6.0, -6.0, 2.0, -9.0));
	var[3][0] = (mat2(9.0, 0.0, -3.0, -7.0));
	var[3][1] = (mat2(8.0, 8.0, 7.0, -3.0));
	var[3][2] = (mat2(7.0, 2.0, -8.0, -7.0));
}
#version 450
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
	highp mat2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0][0], mat2(-5.0, -2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2(var[0][1], mat2(-2.0, -4.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat2(var[0][2], mat2(-9.0, 9.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat2(var[1][0], mat2(8.0, -3.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1][1], mat2(9.0, -8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2(var[1][2], mat2(8.0, -2.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat2(var[2][0], mat2(9.0, 8.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2(var[2][1], mat2(-1.0, -8.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2(var[2][2], mat2(8.0, -4.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2(var[3][0], mat2(3.0, 3.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2(var[3][1], mat2(0.0, -3.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2(var[3][2], mat2(8.0, -5.0, 0.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat2(-2.0, -8.0, -7.0, 9.0));
	var[0][1] = (mat2(2.0, 2.0, -4.0, -5.0));
	var[0][2] = (mat2(-1.0, -4.0, 0.0, -1.0));
	var[1][0] = (mat2(0.0, 4.0, -3.0, -4.0));
	var[1][1] = (mat2(-6.0, 0.0, 5.0, 1.0));
	var[1][2] = (mat2(-6.0, 9.0, 5.0, 9.0));
	var[2][0] = (mat2(5.0, -3.0, -3.0, 6.0));
	var[2][1] = (mat2(-4.0, -6.0, -2.0, -6.0));
	var[2][2] = (mat2(-3.0, -4.0, -7.0, -9.0));
	var[3][0] = (mat2(8.0, 2.0, -6.0, 9.0));
	var[3][1] = (mat2(-5.0, -2.0, 4.0, 9.0));
	var[3][2] = (mat2(4.0, 7.0, 4.0, -8.0));
}
#version 450
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
	highp mat4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0][0], mat4(1.0, 6.0, 7.0, 5.0, 2.0, -4.0, 0.0, 8.0, 3.0, 3.0, 9.0, 8.0, -2.0, 7.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat4(var[0][1], mat4(-1.0, 1.0, 9.0, 1.0, -2.0, -7.0, 3.0, 5.0, 2.0, -8.0, 8.0, -1.0, -4.0, -5.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat4(var[0][2], mat4(-9.0, 1.0, 1.0, -6.0, 5.0, -8.0, -6.0, -3.0, -4.0, 8.0, 9.0, -9.0, -4.0, -2.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(var[1][0], mat4(-7.0, -7.0, 7.0, -7.0, 4.0, 1.0, -4.0, -7.0, 6.0, -4.0, -3.0, -1.0, -2.0, -9.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4(var[1][1], mat4(0.0, -8.0, 2.0, 0.0, -4.0, 1.0, 6.0, 1.0, 2.0, -1.0, -8.0, -9.0, -1.0, -9.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat4(var[1][2], mat4(-8.0, -3.0, -4.0, -8.0, 3.0, 1.0, 4.0, -4.0, -2.0, 6.0, -8.0, 3.0, 7.0, 5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][0], mat4(-3.0, 8.0, 3.0, 5.0, 3.0, 4.0, 5.0, 4.0, -2.0, -6.0, -8.0, -4.0, -5.0, -1.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4(var[2][1], mat4(3.0, -1.0, -2.0, -6.0, -8.0, 2.0, 9.0, -9.0, 2.0, -3.0, 5.0, -1.0, -5.0, -4.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4(var[2][2], mat4(9.0, 9.0, 2.0, -3.0, -5.0, 5.0, 4.0, -6.0, -7.0, -1.0, -4.0, 6.0, -7.0, -9.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat4(var[3][0], mat4(-5.0, -1.0, 3.0, -4.0, 5.0, -7.0, -2.0, 3.0, 0.0, -1.0, 7.0, 5.0, -6.0, -1.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4(var[3][1], mat4(1.0, -9.0, -6.0, 7.0, 6.0, 4.0, -5.0, 0.0, 8.0, -4.0, -3.0, -6.0, -7.0, 4.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4(var[3][2], mat4(-2.0, 4.0, -8.0, 7.0, -3.0, 2.0, -9.0, -8.0, 8.0, 9.0, -5.0, 0.0, 4.0, 3.0, -9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec4(-3.0, -6.0, 8.0, 7.0));
	var[0][0][1] = (vec4(-8.0, 6.0, 1.0, -6.0));
	var[0][0][2] = (vec4(6.0, 0.0, -6.0, 3.0));
	var[0][0][3] = (vec4(3.0, 3.0, -3.0, 2.0));
	var[0][1][0] = (vec4(-8.0, 9.0, -6.0, 6.0));
	var[0][1][1] = (vec4(1.0, 9.0, -7.0, 4.0));
	var[0][1][2] = (vec4(-5.0, 5.0, -6.0, 5.0));
	var[0][1][3] = (vec4(7.0, 7.0, -5.0, -9.0));
	var[0][2][0] = (vec4(7.0, -2.0, -1.0, -4.0));
	var[0][2][1] = (vec4(-3.0, 3.0, -8.0, 7.0));
	var[0][2][2] = (vec4(-8.0, -5.0, -9.0, -1.0));
	var[0][2][3] = (vec4(0.0, -7.0, 7.0, 8.0));
	var[1][0][0] = (vec4(-6.0, -6.0, -1.0, 6.0));
	var[1][0][1] = (vec4(3.0, 5.0, -8.0, 3.0));
	var[1][0][2] = (vec4(1.0, -1.0, 3.0, -5.0));
	var[1][0][3] = (vec4(4.0, -4.0, 3.0, 4.0));
	var[1][1][0] = (vec4(-4.0, -8.0, 4.0, 5.0));
	var[1][1][1] = (vec4(-5.0, 0.0, -3.0, -4.0));
	var[1][1][2] = (vec4(5.0, -4.0, -7.0, 4.0));
	var[1][1][3] = (vec4(-3.0, 9.0, 3.0, -4.0));
	var[1][2][0] = (vec4(-3.0, -9.0, 6.0, -3.0));
	var[1][2][1] = (vec4(-6.0, -1.0, 8.0, 3.0));
	var[1][2][2] = (vec4(-2.0, 9.0, -2.0, -3.0));
	var[1][2][3] = (vec4(-8.0, 3.0, -8.0, 5.0));
	var[2][0][0] = (vec4(7.0, -2.0, -7.0, 3.0));
	var[2][0][1] = (vec4(8.0, -7.0, -6.0, 4.0));
	var[2][0][2] = (vec4(-4.0, 6.0, -2.0, -7.0));
	var[2][0][3] = (vec4(7.0, 8.0, -8.0, -2.0));
	var[2][1][0] = (vec4(-8.0, 3.0, 9.0, 3.0));
	var[2][1][1] = (vec4(1.0, -3.0, -5.0, -8.0));
	var[2][1][2] = (vec4(-7.0, 5.0, -1.0, -6.0));
	var[2][1][3] = (vec4(8.0, -8.0, 4.0, 8.0));
	var[2][2][0] = (vec4(6.0, -5.0, 4.0, -3.0));
	var[2][2][1] = (vec4(-1.0, -8.0, 3.0, 5.0));
	var[2][2][2] = (vec4(0.0, 7.0, 6.0, -4.0));
	var[2][2][3] = (vec4(1.0, 4.0, 3.0, 6.0));
	var[3][0][0] = (vec4(-3.0, -8.0, -6.0, 5.0));
	var[3][0][1] = (vec4(-9.0, -3.0, 0.0, -1.0));
	var[3][0][2] = (vec4(-5.0, 9.0, -8.0, -9.0));
	var[3][0][3] = (vec4(-1.0, 2.0, 5.0, 6.0));
	var[3][1][0] = (vec4(2.0, 3.0, 8.0, 8.0));
	var[3][1][1] = (vec4(-7.0, -1.0, 5.0, -3.0));
	var[3][1][2] = (vec4(5.0, -3.0, -4.0, 6.0));
	var[3][1][3] = (vec4(-6.0, -5.0, 7.0, -6.0));
	var[3][2][0] = (vec4(7.0, -3.0, -8.0, 1.0));
	var[3][2][1] = (vec4(1.0, 2.0, 3.0, 1.0));
	var[3][2][2] = (vec4(5.0, -2.0, 2.0, -2.0));
	var[3][2][3] = (vec4(-9.0, -1.0, 2.0, -1.0));
}
#version 450
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
	allOk = compare_mat4x2(var[0][0], mat4x2(-4.0, 6.0, 0.0, -5.0, 0.0, -1.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[0][1], mat4x2(-6.0, -1.0, 4.0, 0.0, 2.0, -3.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[0][2], mat4x2(-8.0, -1.0, 5.0, 4.0, 9.0, -2.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[1][0], mat4x2(-5.0, -4.0, 3.0, 6.0, 4.0, 3.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[1][1], mat4x2(-1.0, -1.0, 3.0, -6.0, 6.0, 2.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[1][2], mat4x2(2.0, -2.0, -4.0, 7.0, -1.0, -9.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[2][0], mat4x2(-5.0, 5.0, 5.0, 7.0, 5.0, 2.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[2][1], mat4x2(9.0, -6.0, 5.0, -9.0, 6.0, 0.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[2][2], mat4x2(-8.0, 7.0, -6.0, -1.0, -9.0, -7.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[3][0], mat4x2(5.0, 9.0, 3.0, 7.0, 1.0, -3.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[3][1], mat4x2(4.0, 5.0, 5.0, 6.0, 2.0, 0.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[3][2], mat4x2(5.0, -2.0, 4.0, 7.0, -2.0, 4.0, 5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat4x2(1.0, 8.0, -9.0, 4.0, 1.0, -5.0, 2.0, -5.0));
	var[0][1] = (mat4x2(8.0, -8.0, 8.0, 3.0, 2.0, -6.0, 3.0, 8.0));
	var[0][2] = (mat4x2(8.0, 9.0, -3.0, -9.0, -2.0, 6.0, -1.0, 6.0));
	var[1][0] = (mat4x2(-5.0, -9.0, -1.0, -9.0, 0.0, -4.0, 2.0, -7.0));
	var[1][1] = (mat4x2(-3.0, -5.0, 1.0, -5.0, -1.0, 7.0, 4.0, 4.0));
	var[1][2] = (mat4x2(-5.0, 2.0, -4.0, -3.0, 0.0, 4.0, -7.0, 5.0));
	var[2][0] = (mat4x2(1.0, -9.0, 0.0, -4.0, 2.0, 9.0, -5.0, -3.0));
	var[2][1] = (mat4x2(6.0, -4.0, -9.0, 5.0, -5.0, -6.0, 8.0, -5.0));
	var[2][2] = (mat4x2(-4.0, -5.0, 6.0, 9.0, -3.0, -4.0, 3.0, -7.0));
	var[3][0] = (mat4x2(-8.0, 8.0, -4.0, -6.0, 0.0, -3.0, -6.0, -4.0));
	var[3][1] = (mat4x2(5.0, 4.0, 5.0, 7.0, 2.0, -7.0, 8.0, -3.0));
	var[3][2] = (mat4x2(8.0, 7.0, 0.0, -5.0, 4.0, 5.0, -6.0, -8.0));
}
#version 450
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
	i8vec3 var[4][3];
};

bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(var[0][0]), ivec3(4294967295, 4294967290, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(var[0][1]), ivec3(4294967293, 4294967289, 3)) && allOk;
	allOk = compare_i8vec3(ivec3(var[0][2]), ivec3(7, 9, 4294967292)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][0]), ivec3(5, 4294967288, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][1]), ivec3(9, 0, 4294967291)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][2]), ivec3(4294967290, 4294967292, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][0]), ivec3(4294967289, 4294967293, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][1]), ivec3(8, 6, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][2]), ivec3(2, 3, 5)) && allOk;
	allOk = compare_i8vec3(ivec3(var[3][0]), ivec3(1, 4294967288, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(var[3][1]), ivec3(9, 7, 4294967290)) && allOk;
	allOk = compare_i8vec3(ivec3(var[3][2]), ivec3(2, 4294967294, 0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = i8vec3(ivec3(4294967292, 0, 0));
	var[0][1] = i8vec3(ivec3(7, 9, 4294967290));
	var[0][2] = i8vec3(ivec3(4294967288, 9, 4294967288));
	var[1][0] = i8vec3(ivec3(4294967293, 3, 4294967295));
	var[1][1] = i8vec3(ivec3(9, 7, 5));
	var[1][2] = i8vec3(ivec3(5, 4294967293, 6));
	var[2][0] = i8vec3(ivec3(4294967293, 4294967295, 3));
	var[2][1] = i8vec3(ivec3(5, 4294967292, 4294967295));
	var[2][2] = i8vec3(ivec3(4294967293, 8, 4294967290));
	var[3][0] = i8vec3(ivec3(3, 7, 4));
	var[3][1] = i8vec3(ivec3(4294967292, 8, 8));
	var[3][2] = i8vec3(ivec3(4294967294, 8, 1));
}
#version 450
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
	highp mat3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -8.0) && allOk;
	allOk = compare_mat3(var[0][0], mat3(-7.0, 8.0, 7.0, 4.0, 4.0, -1.0, -9.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat3(var[0][1], mat3(-4.0, -3.0, 8.0, 7.0, -3.0, -7.0, -4.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat3(var[0][2], mat3(-9.0, -1.0, 8.0, 8.0, 3.0, -1.0, 6.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3(var[1][0], mat3(-2.0, 3.0, 7.0, 0.0, 0.0, 1.0, 4.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat3(var[1][1], mat3(4.0, 6.0, 8.0, 8.0, 6.0, 3.0, 1.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3(var[1][2], mat3(8.0, 3.0, 9.0, 3.0, 8.0, -8.0, 0.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3(var[2][0], mat3(-7.0, 4.0, -2.0, -5.0, -4.0, 5.0, 7.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat3(var[2][1], mat3(-9.0, -9.0, 6.0, -6.0, -9.0, -8.0, 2.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat3(var[2][2], mat3(4.0, -6.0, -6.0, -7.0, -6.0, -6.0, -3.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3(var[3][0], mat3(5.0, -4.0, -6.0, -5.0, -8.0, -3.0, 6.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3(var[3][1], mat3(-2.0, 4.0, -8.0, 0.0, -3.0, -6.0, -1.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3(var[3][2], mat3(-7.0, 4.0, -8.0, 4.0, -8.0, -5.0, 6.0, 8.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (5.0);
	var[0][0] = (mat3(8.0, 3.0, -2.0, 2.0, -8.0, -5.0, 2.0, 8.0, -6.0));
	var[0][1] = (mat3(-5.0, -5.0, 8.0, -2.0, -5.0, 5.0, -1.0, 7.0, 3.0));
	var[0][2] = (mat3(-2.0, 3.0, 5.0, 5.0, 1.0, -6.0, 9.0, -7.0, -5.0));
	var[1][0] = (mat3(-2.0, -6.0, 2.0, -1.0, 0.0, 2.0, 4.0, 9.0, 9.0));
	var[1][1] = (mat3(6.0, 8.0, 4.0, 5.0, -2.0, -5.0, -5.0, 7.0, 7.0));
	var[1][2] = (mat3(-3.0, -8.0, 1.0, -4.0, 7.0, 1.0, -1.0, 1.0, 5.0));
	var[2][0] = (mat3(8.0, 9.0, 6.0, -1.0, 5.0, -2.0, 8.0, -1.0, 1.0));
	var[2][1] = (mat3(8.0, 1.0, 2.0, 4.0, -7.0, 3.0, 4.0, -8.0, -1.0));
	var[2][2] = (mat3(2.0, -1.0, -7.0, 7.0, -8.0, -6.0, -5.0, 2.0, 5.0));
	var[3][0] = (mat3(2.0, -9.0, -9.0, -2.0, 1.0, 8.0, -9.0, 2.0, -4.0));
	var[3][1] = (mat3(5.0, -2.0, 2.0, 3.0, 3.0, -8.0, 8.0, -5.0, 0.0));
	var[3][2] = (mat3(2.0, -5.0, -9.0, 4.0, 6.0, -3.0, 2.0, 6.0, -9.0));
}
#version 450
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
	highp mat2x4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat2x4(var[0][0], mat2x4(-7.0, -8.0, 1.0, -7.0, 8.0, 3.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[0][1], mat2x4(3.0, -9.0, -2.0, -1.0, 3.0, -5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[0][2], mat2x4(-2.0, 8.0, -6.0, 4.0, 6.0, -4.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[1][0], mat2x4(2.0, -7.0, -5.0, 3.0, -1.0, -1.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[1][1], mat2x4(8.0, -7.0, 1.0, -3.0, -9.0, 1.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[1][2], mat2x4(2.0, 5.0, 6.0, -5.0, -1.0, 0.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[2][0], mat2x4(0.0, -1.0, -8.0, 6.0, 2.0, -8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[2][1], mat2x4(-3.0, -4.0, -5.0, 2.0, -2.0, -4.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[2][2], mat2x4(2.0, 3.0, 5.0, 4.0, -7.0, 8.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[3][0], mat2x4(-7.0, 7.0, 2.0, -8.0, 0.0, -4.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[3][1], mat2x4(-1.0, -7.0, 8.0, 8.0, -7.0, -5.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[3][2], mat2x4(9.0, -7.0, -6.0, 1.0, 0.0, -6.0, -2.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (4.0);
	var[0][0] = (mat2x4(5.0, -4.0, -9.0, -9.0, 9.0, 1.0, 2.0, 5.0));
	var[0][1] = (mat2x4(5.0, -1.0, -3.0, -2.0, -4.0, -4.0, 8.0, 8.0));
	var[0][2] = (mat2x4(3.0, 1.0, -6.0, 2.0, 2.0, 5.0, 4.0, -3.0));
	var[1][0] = (mat2x4(-6.0, -3.0, -2.0, -9.0, 4.0, 7.0, -8.0, -6.0));
	var[1][1] = (mat2x4(2.0, 7.0, 4.0, -7.0, 7.0, 6.0, -2.0, -8.0));
	var[1][2] = (mat2x4(-9.0, -3.0, 5.0, -6.0, 4.0, 3.0, -6.0, -5.0));
	var[2][0] = (mat2x4(-9.0, 1.0, -2.0, -6.0, 8.0, 2.0, 0.0, 0.0));
	var[2][1] = (mat2x4(-1.0, -3.0, -3.0, -9.0, 6.0, 7.0, -2.0, 7.0));
	var[2][2] = (mat2x4(-1.0, 9.0, 0.0, 7.0, -5.0, 9.0, -1.0, 6.0));
	var[3][0] = (mat2x4(1.0, -8.0, -4.0, -9.0, -8.0, -2.0, 3.0, -7.0));
	var[3][1] = (mat2x4(5.0, 7.0, 7.0, -3.0, 0.0, -8.0, -1.0, 1.0));
	var[3][2] = (mat2x4(-3.0, 0.0, -4.0, 5.0, -9.0, 2.0, -9.0, 8.0));
}
#version 450
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
	allOk = compare_float((padding), 4.0) && allOk;
	allOk = compare_mat4x2(var[0][0], mat4x2(-5.0, -2.0, 7.0, 3.0, 2.0, -3.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[0][1], mat4x2(-1.0, -9.0, 4.0, -9.0, -4.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[0][2], mat4x2(-7.0, 4.0, 6.0, 6.0, -6.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[1][0], mat4x2(1.0, 8.0, 3.0, 5.0, -2.0, 2.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[1][1], mat4x2(8.0, -6.0, 7.0, 4.0, -6.0, 1.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][2], mat4x2(-6.0, 1.0, 5.0, 0.0, -2.0, -5.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[2][0], mat4x2(-9.0, 6.0, -5.0, 3.0, -2.0, -3.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[2][1], mat4x2(0.0, 8.0, 5.0, -1.0, 3.0, -2.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[2][2], mat4x2(-7.0, 7.0, 1.0, 2.0, -1.0, -5.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[3][0], mat4x2(4.0, 5.0, -1.0, -2.0, 5.0, -3.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[3][1], mat4x2(2.0, 1.0, -4.0, 1.0, -1.0, 2.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[3][2], mat4x2(2.0, -1.0, 8.0, 2.0, 1.0, -4.0, -6.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (2.0);
	var[0][0][0] = (vec2(-4.0, -5.0));
	var[0][0][1] = (vec2(3.0, 7.0));
	var[0][0][2] = (vec2(1.0, 8.0));
	var[0][0][3] = (vec2(-5.0, 7.0));
	var[0][1][0] = (vec2(-3.0, 1.0));
	var[0][1][1] = (vec2(-6.0, 9.0));
	var[0][1][2] = (vec2(-3.0, 1.0));
	var[0][1][3] = (vec2(-5.0, -8.0));
	var[0][2][0] = (vec2(4.0, 5.0));
	var[0][2][1] = (vec2(-9.0, 1.0));
	var[0][2][2] = (vec2(-5.0, -4.0));
	var[0][2][3] = (vec2(-2.0, 6.0));
	var[1][0][0] = (vec2(-1.0, -7.0));
	var[1][0][1] = (vec2(-5.0, -2.0));
	var[1][0][2] = (vec2(-8.0, 1.0));
	var[1][0][3] = (vec2(3.0, 4.0));
	var[1][1][0] = (vec2(2.0, -9.0));
	var[1][1][1] = (vec2(2.0, -3.0));
	var[1][1][2] = (vec2(3.0, 0.0));
	var[1][1][3] = (vec2(1.0, -5.0));
	var[1][2][0] = (vec2(-9.0, 2.0));
	var[1][2][1] = (vec2(-2.0, -3.0));
	var[1][2][2] = (vec2(0.0, 9.0));
	var[1][2][3] = (vec2(6.0, 3.0));
	var[2][0][0] = (vec2(-4.0, 2.0));
	var[2][0][1] = (vec2(-3.0, 6.0));
	var[2][0][2] = (vec2(5.0, 0.0));
	var[2][0][3] = (vec2(-2.0, -3.0));
	var[2][1][0] = (vec2(-2.0, -7.0));
	var[2][1][1] = (vec2(3.0, -6.0));
	var[2][1][2] = (vec2(2.0, 9.0));
	var[2][1][3] = (vec2(6.0, -4.0));
	var[2][2][0] = (vec2(4.0, 0.0));
	var[2][2][1] = (vec2(-3.0, -7.0));
	var[2][2][2] = (vec2(0.0, -9.0));
	var[2][2][3] = (vec2(1.0, 7.0));
	var[3][0][0] = (vec2(2.0, 1.0));
	var[3][0][1] = (vec2(9.0, -3.0));
	var[3][0][2] = (vec2(3.0, -7.0));
	var[3][0][3] = (vec2(9.0, -4.0));
	var[3][1][0] = (vec2(-1.0, 3.0));
	var[3][1][1] = (vec2(6.0, 8.0));
	var[3][1][2] = (vec2(3.0, 1.0));
	var[3][1][3] = (vec2(5.0, 7.0));
	var[3][2][0] = (vec2(0.0, 0.0));
	var[3][2][1] = (vec2(-2.0, 3.0));
	var[3][2][2] = (vec2(-7.0, -3.0));
	var[3][2][3] = (vec2(1.0, 4.0));
}
#version 450
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
	highp mat4x3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 0.0) && allOk;
	allOk = compare_mat4x3(var[0][0], mat4x3(1.0, -8.0, -1.0, 2.0, 8.0, 7.0, -7.0, 9.0, -3.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[0][1], mat4x3(2.0, 4.0, -2.0, -9.0, -6.0, 8.0, 9.0, 2.0, -2.0, 3.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[0][2], mat4x3(9.0, 2.0, -3.0, 3.0, 6.0, 6.0, 3.0, -3.0, -9.0, 4.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[1][0], mat4x3(4.0, -6.0, 7.0, -5.0, 8.0, -1.0, 8.0, 1.0, 9.0, -4.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[1][1], mat4x3(-6.0, 8.0, -9.0, -1.0, -2.0, 1.0, 7.0, 9.0, -5.0, 9.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[1][2], mat4x3(4.0, -7.0, 8.0, -1.0, -7.0, -3.0, 2.0, -7.0, 0.0, -3.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[2][0], mat4x3(4.0, -8.0, 9.0, 2.0, 4.0, 5.0, -1.0, -4.0, -5.0, -7.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[2][1], mat4x3(-3.0, 4.0, -4.0, -8.0, 6.0, 7.0, 7.0, -6.0, -3.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[2][2], mat4x3(-9.0, -8.0, -4.0, -3.0, 6.0, 5.0, 4.0, 2.0, 3.0, 4.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[3][0], mat4x3(-8.0, -6.0, 5.0, -7.0, 2.0, -2.0, 1.0, 6.0, 5.0, 5.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[3][1], mat4x3(1.0, 7.0, -6.0, -8.0, 9.0, 6.0, 2.0, -4.0, 4.0, 1.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[3][2], mat4x3(2.0, -5.0, -3.0, -3.0, 2.0, -4.0, -8.0, -1.0, 5.0, -7.0, 2.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (2.0);
	var[0][0] = (mat4x3(4.0, 9.0, -7.0, 5.0, -8.0, 9.0, 1.0, 9.0, -6.0, -6.0, 1.0, 6.0));
	var[0][1] = (mat4x3(-2.0, -2.0, 5.0, 3.0, -6.0, -8.0, -5.0, 9.0, 8.0, -2.0, -1.0, 1.0));
	var[0][2] = (mat4x3(7.0, 0.0, 5.0, 9.0, -6.0, 5.0, 6.0, 2.0, 3.0, -8.0, 7.0, 3.0));
	var[1][0] = (mat4x3(1.0, -4.0, 0.0, -7.0, 0.0, 1.0, 6.0, -5.0, -5.0, -2.0, 5.0, 0.0));
	var[1][1] = (mat4x3(7.0, 3.0, -7.0, -6.0, -5.0, -6.0, 2.0, -9.0, -1.0, 1.0, 6.0, 0.0));
	var[1][2] = (mat4x3(8.0, -4.0, -6.0, -7.0, -1.0, 3.0, -1.0, -6.0, 2.0, 2.0, -2.0, -3.0));
	var[2][0] = (mat4x3(7.0, -5.0, -3.0, 0.0, -1.0, 8.0, -1.0, 8.0, -9.0, -7.0, 7.0, 8.0));
	var[2][1] = (mat4x3(2.0, 0.0, -8.0, -5.0, -8.0, -4.0, 9.0, -6.0, 6.0, -9.0, 9.0, -4.0));
	var[2][2] = (mat4x3(-2.0, -1.0, -9.0, 0.0, -2.0, 2.0, -1.0, 9.0, 6.0, 5.0, -6.0, 9.0));
	var[3][0] = (mat4x3(-4.0, 0.0, 0.0, -6.0, -4.0, 1.0, -9.0, -9.0, -6.0, 2.0, 1.0, -9.0));
	var[3][1] = (mat4x3(6.0, -7.0, 6.0, 5.0, 4.0, -7.0, -3.0, 6.0, 5.0, 8.0, -2.0, 3.0));
	var[3][2] = (mat4x3(0.0, 7.0, -9.0, -2.0, 7.0, -3.0, 4.0, -5.0, -5.0, -2.0, -3.0, -2.0));
}
#version 450
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
	u8vec2 var[4][3];
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(padding), 3u) && allOk;
	allOk = compare_u8vec2(uvec2(var[0][0]), uvec2(0u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[0][1]), uvec2(2u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[0][2]), uvec2(2u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1][0]), uvec2(3u, 9u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1][1]), uvec2(7u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1][2]), uvec2(4u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2][0]), uvec2(0u, 6u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2][1]), uvec2(8u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2][2]), uvec2(0u, 1u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[3][0]), uvec2(0u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[3][1]), uvec2(8u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[3][2]), uvec2(0u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = uint8_t(7u);
	var[0][0] = u8vec2(uvec2(7u, 9u));
	var[0][1] = u8vec2(uvec2(6u, 0u));
	var[0][2] = u8vec2(uvec2(2u, 1u));
	var[1][0] = u8vec2(uvec2(1u, 0u));
	var[1][1] = u8vec2(uvec2(8u, 8u));
	var[1][2] = u8vec2(uvec2(5u, 2u));
	var[2][0] = u8vec2(uvec2(7u, 4u));
	var[2][1] = u8vec2(uvec2(4u, 7u));
	var[2][2] = u8vec2(uvec2(2u, 4u));
	var[3][0] = u8vec2(uvec2(5u, 0u));
	var[3][1] = u8vec2(uvec2(2u, 1u));
	var[3][2] = u8vec2(uvec2(8u, 1u));
}
#version 450
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
	highp ivec2 var[4][2][3];
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((var[0][0][0]), ivec2(6, -1)) && allOk;
	allOk = compare_ivec2((var[0][0][1]), ivec2(7, -5)) && allOk;
	allOk = compare_ivec2((var[0][0][2]), ivec2(-8, 8)) && allOk;
	allOk = compare_ivec2((var[0][1][0]), ivec2(-4, 1)) && allOk;
	allOk = compare_ivec2((var[0][1][1]), ivec2(-3, -1)) && allOk;
	allOk = compare_ivec2((var[0][1][2]), ivec2(2, 1)) && allOk;
	allOk = compare_ivec2((var[1][0][0]), ivec2(-2, -6)) && allOk;
	allOk = compare_ivec2((var[1][0][1]), ivec2(6, 2)) && allOk;
	allOk = compare_ivec2((var[1][0][2]), ivec2(-2, 7)) && allOk;
	allOk = compare_ivec2((var[1][1][0]), ivec2(-4, -3)) && allOk;
	allOk = compare_ivec2((var[1][1][1]), ivec2(-9, 0)) && allOk;
	allOk = compare_ivec2((var[1][1][2]), ivec2(9, 8)) && allOk;
	allOk = compare_ivec2((var[2][0][0]), ivec2(-1, -1)) && allOk;
	allOk = compare_ivec2((var[2][0][1]), ivec2(0, 8)) && allOk;
	allOk = compare_ivec2((var[2][0][2]), ivec2(-9, -5)) && allOk;
	allOk = compare_ivec2((var[2][1][0]), ivec2(6, 3)) && allOk;
	allOk = compare_ivec2((var[2][1][1]), ivec2(-5, -3)) && allOk;
	allOk = compare_ivec2((var[2][1][2]), ivec2(-4, 7)) && allOk;
	allOk = compare_ivec2((var[3][0][0]), ivec2(6, 4)) && allOk;
	allOk = compare_ivec2((var[3][0][1]), ivec2(-8, 3)) && allOk;
	allOk = compare_ivec2((var[3][0][2]), ivec2(7, -6)) && allOk;
	allOk = compare_ivec2((var[3][1][0]), ivec2(-3, -4)) && allOk;
	allOk = compare_ivec2((var[3][1][1]), ivec2(8, -5)) && allOk;
	allOk = compare_ivec2((var[3][1][2]), ivec2(-2, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (ivec2(-6, 8));
	var[0][0][1] = (ivec2(3, -1));
	var[0][0][2] = (ivec2(-5, -2));
	var[0][1][0] = (ivec2(4, 1));
	var[0][1][1] = (ivec2(1, 9));
	var[0][1][2] = (ivec2(-2, -9));
	var[1][0][0] = (ivec2(0, -2));
	var[1][0][1] = (ivec2(5, 2));
	var[1][0][2] = (ivec2(-8, 4));
	var[1][1][0] = (ivec2(9, 6));
	var[1][1][1] = (ivec2(-8, 1));
	var[1][1][2] = (ivec2(-3, 2));
	var[2][0][0] = (ivec2(-6, -4));
	var[2][0][1] = (ivec2(3, -2));
	var[2][0][2] = (ivec2(5, -7));
	var[2][1][0] = (ivec2(-3, -1));
	var[2][1][1] = (ivec2(-4, 6));
	var[2][1][2] = (ivec2(-4, -7));
	var[3][0][0] = (ivec2(-3, 4));
	var[3][0][1] = (ivec2(1, 6));
	var[3][0][2] = (ivec2(8, 7));
	var[3][1][0] = (ivec2(-9, 1));
	var[3][1][1] = (ivec2(8, 1));
	var[3][1][2] = (ivec2(-8, 3));
}
#version 450
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

layout(std430, binding = 1) buffer Block
{
	bvec4 var[4][2][3];
};

bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((var[0][0][0]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((var[0][0][1]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((var[0][0][2]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((var[0][1][0]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((var[0][1][1]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((var[0][1][2]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((var[1][0][0]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((var[1][0][1]), bvec4(false, false, true, true)) && allOk;
	allOk = compare_bvec4((var[1][0][2]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec4((var[1][1][0]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((var[1][1][1]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((var[1][1][2]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((var[2][0][0]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((var[2][0][1]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((var[2][0][2]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((var[2][1][0]), bvec4(false, true, false, false)) && allOk;
	allOk = compare_bvec4((var[2][1][1]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((var[2][1][2]), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bvec4((var[3][0][0]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((var[3][0][1]), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec4((var[3][0][2]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((var[3][1][0]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec4((var[3][1][1]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((var[3][1][2]), bvec4(true, true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (bvec4(true, true, true, false));
	var[0][0][1] = (bvec4(true, false, false, false));
	var[0][0][2] = (bvec4(false, true, true, true));
	var[0][1][0] = (bvec4(false, true, false, true));
	var[0][1][1] = (bvec4(true, true, true, false));
	var[0][1][2] = (bvec4(false, true, false, false));
	var[1][0][0] = (bvec4(true, true, true, false));
	var[1][0][1] = (bvec4(true, false, true, false));
	var[1][0][2] = (bvec4(true, false, false, true));
	var[1][1][0] = (bvec4(true, false, false, true));
	var[1][1][1] = (bvec4(true, true, true, false));
	var[1][1][2] = (bvec4(true, false, false, false));
	var[2][0][0] = (bvec4(false, true, true, false));
	var[2][0][1] = (bvec4(true, true, true, false));
	var[2][0][2] = (bvec4(false, false, true, true));
	var[2][1][0] = (bvec4(false, false, true, true));
	var[2][1][1] = (bvec4(false, false, true, false));
	var[2][1][2] = (bvec4(true, false, false, true));
	var[3][0][0] = (bvec4(true, false, true, false));
	var[3][0][1] = (bvec4(true, true, true, true));
	var[3][0][2] = (bvec4(false, true, false, true));
	var[3][1][0] = (bvec4(true, false, true, false));
	var[3][1][1] = (bvec4(false, true, false, true));
	var[3][1][2] = (bvec4(false, true, true, true));
}
#version 450
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
	allOk = compare_mat4(var[0][0][0], mat4(3.0, 8.0, 5.0, -7.0, -4.0, 0.0, -1.0, -9.0, 2.0, 9.0, 5.0, 5.0, 6.0, 9.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(8.0, 1.0, -3.0, 1.0, 0.0, -7.0, -4.0, 0.0, 1.0, -6.0, -7.0, 5.0, 2.0, 0.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4(var[0][0][2], mat4(-5.0, 8.0, 2.0, 3.0, 8.0, -6.0, 7.0, 9.0, -3.0, 7.0, -8.0, -5.0, 6.0, 4.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(4.0, 4.0, 9.0, -7.0, 9.0, 2.0, 3.0, 7.0, 0.0, -9.0, 2.0, -1.0, -8.0, -7.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(0.0, -3.0, -1.0, -1.0, -6.0, 1.0, -8.0, 1.0, 5.0, 0.0, 2.0, -1.0, -1.0, -6.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4(var[0][1][2], mat4(7.0, 5.0, -2.0, -4.0, 0.0, 1.0, -6.0, -3.0, -1.0, -7.0, -7.0, -6.0, 1.0, -4.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(7.0, 0.0, -6.0, -1.0, 5.0, 0.0, -3.0, -3.0, 6.0, -5.0, 1.0, 4.0, -5.0, -7.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(-2.0, -3.0, 2.0, -9.0, 6.0, -8.0, 8.0, 2.0, -3.0, -9.0, 8.0, 1.0, -4.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4(var[1][0][2], mat4(9.0, -2.0, -1.0, -7.0, 6.0, -6.0, -3.0, -9.0, -3.0, -7.0, -2.0, 2.0, -9.0, -2.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(8.0, -3.0, 9.0, 6.0, -2.0, -9.0, 4.0, 5.0, 6.0, 4.0, -3.0, -8.0, 6.0, 5.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(-2.0, 5.0, 8.0, 4.0, -4.0, 9.0, 3.0, -5.0, 1.0, -6.0, 1.0, -5.0, 8.0, 7.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4(var[1][1][2], mat4(3.0, 0.0, -3.0, 3.0, 2.0, -8.0, -7.0, 8.0, -3.0, 2.0, -9.0, -7.0, 1.0, -5.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(2.0, -3.0, 7.0, 9.0, 7.0, -1.0, 3.0, 6.0, -3.0, 2.0, -2.0, 7.0, -9.0, 0.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(-2.0, -1.0, -6.0, -6.0, 5.0, -8.0, 7.0, 3.0, -6.0, 4.0, -8.0, -1.0, 1.0, 4.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4(var[2][0][2], mat4(-7.0, -2.0, -4.0, -6.0, -6.0, 8.0, 5.0, -4.0, -7.0, 7.0, -4.0, -9.0, -7.0, -1.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(0.0, 0.0, -1.0, 0.0, -9.0, 5.0, 4.0, 0.0, -6.0, -7.0, 1.0, -9.0, -4.0, -4.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(0.0, 5.0, -7.0, -5.0, 9.0, 2.0, -2.0, 5.0, 8.0, -7.0, 9.0, 9.0, -8.0, 3.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat4(var[2][1][2], mat4(5.0, 3.0, 5.0, -5.0, 6.0, 3.0, 0.0, -9.0, -1.0, 0.0, -8.0, 3.0, 4.0, -1.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4(var[3][0][0], mat4(5.0, -4.0, -1.0, -3.0, 3.0, 2.0, 1.0, -6.0, 3.0, 5.0, -4.0, 0.0, 2.0, -4.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4(var[3][0][1], mat4(-6.0, -9.0, -6.0, -9.0, -4.0, 2.0, 5.0, 4.0, -6.0, -2.0, -5.0, 7.0, 9.0, -4.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4(var[3][0][2], mat4(-2.0, 1.0, -2.0, 0.0, -7.0, 2.0, -6.0, -5.0, 2.0, -1.0, -8.0, 8.0, 2.0, -9.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4(var[3][1][0], mat4(-6.0, -9.0, -8.0, -2.0, -6.0, -8.0, 8.0, 4.0, 4.0, 1.0, 5.0, 0.0, -1.0, 4.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat4(var[3][1][1], mat4(-2.0, 2.0, 9.0, 7.0, -2.0, -6.0, -3.0, -7.0, 1.0, 2.0, -3.0, 0.0, -5.0, 5.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat4(var[3][1][2], mat4(3.0, 5.0, 2.0, -6.0, 9.0, 7.0, 4.0, 4.0, 5.0, 8.0, 4.0, -9.0, 3.0, -7.0, 7.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(-7.0, -2.0, 7.0, -7.0));
	var[0][0][0][1] = (vec4(2.0, -4.0, 3.0, -5.0));
	var[0][0][0][2] = (vec4(2.0, 3.0, 8.0, 8.0));
	var[0][0][0][3] = (vec4(3.0, 0.0, -4.0, -1.0));
	var[0][0][1][0] = (vec4(-3.0, 0.0, 8.0, 1.0));
	var[0][0][1][1] = (vec4(-8.0, 9.0, 2.0, 7.0));
	var[0][0][1][2] = (vec4(-2.0, -7.0, -9.0, 1.0));
	var[0][0][1][3] = (vec4(6.0, -9.0, -1.0, -5.0));
	var[0][0][2][0] = (vec4(-6.0, -3.0, 7.0, -1.0));
	var[0][0][2][1] = (vec4(0.0, -1.0, -2.0, 1.0));
	var[0][0][2][2] = (vec4(-3.0, -1.0, -4.0, 7.0));
	var[0][0][2][3] = (vec4(-3.0, 1.0, 1.0, -9.0));
	var[0][1][0][0] = (vec4(-3.0, 9.0, 5.0, -2.0));
	var[0][1][0][1] = (vec4(-7.0, 3.0, 3.0, 1.0));
	var[0][1][0][2] = (vec4(-7.0, -9.0, -5.0, -7.0));
	var[0][1][0][3] = (vec4(-7.0, -8.0, -2.0, -8.0));
	var[0][1][1][0] = (vec4(3.0, 7.0, 3.0, 7.0));
	var[0][1][1][1] = (vec4(-8.0, 9.0, -9.0, -9.0));
	var[0][1][1][2] = (vec4(3.0, -4.0, -8.0, 3.0));
	var[0][1][1][3] = (vec4(9.0, -7.0, -5.0, -5.0));
	var[0][1][2][0] = (vec4(2.0, 2.0, -3.0, 9.0));
	var[0][1][2][1] = (vec4(0.0, -6.0, 7.0, 1.0));
	var[0][1][2][2] = (vec4(-1.0, 2.0, -7.0, 2.0));
	var[0][1][2][3] = (vec4(-1.0, -6.0, -8.0, 1.0));
	var[1][0][0][0] = (vec4(-3.0, 2.0, 9.0, -4.0));
	var[1][0][0][1] = (vec4(2.0, 9.0, -9.0, -2.0));
	var[1][0][0][2] = (vec4(-1.0, 1.0, -9.0, 0.0));
	var[1][0][0][3] = (vec4(-7.0, 7.0, -3.0, -9.0));
	var[1][0][1][0] = (vec4(-1.0, 0.0, 7.0, 7.0));
	var[1][0][1][1] = (vec4(-5.0, -2.0, -6.0, 0.0));
	var[1][0][1][2] = (vec4(-2.0, 1.0, -2.0, 4.0));
	var[1][0][1][3] = (vec4(4.0, 0.0, 0.0, -2.0));
	var[1][0][2][0] = (vec4(4.0, 7.0, -5.0, -3.0));
	var[1][0][2][1] = (vec4(9.0, 1.0, 5.0, 5.0));
	var[1][0][2][2] = (vec4(9.0, -4.0, -6.0, 8.0));
	var[1][0][2][3] = (vec4(1.0, -5.0, 5.0, -3.0));
	var[1][1][0][0] = (vec4(1.0, -4.0, -6.0, -4.0));
	var[1][1][0][1] = (vec4(-9.0, 0.0, -2.0, 6.0));
	var[1][1][0][2] = (vec4(3.0, 3.0, 4.0, -6.0));
	var[1][1][0][3] = (vec4(-7.0, 9.0, -1.0, 6.0));
	var[1][1][1][0] = (vec4(-8.0, -1.0, 0.0, -8.0));
	var[1][1][1][1] = (vec4(3.0, -1.0, 9.0, -7.0));
	var[1][1][1][2] = (vec4(-4.0, 7.0, 9.0, -5.0));
	var[1][1][1][3] = (vec4(2.0, -8.0, 7.0, 8.0));
	var[1][1][2][0] = (vec4(1.0, -8.0, -3.0, -8.0));
	var[1][1][2][1] = (vec4(-8.0, -6.0, -2.0, -9.0));
	var[1][1][2][2] = (vec4(-4.0, 4.0, -9.0, -5.0));
	var[1][1][2][3] = (vec4(-2.0, 9.0, -7.0, -6.0));
	var[2][0][0][0] = (vec4(-4.0, -3.0, 4.0, -8.0));
	var[2][0][0][1] = (vec4(-2.0, 0.0, -8.0, 2.0));
	var[2][0][0][2] = (vec4(-3.0, -5.0, 3.0, -2.0));
	var[2][0][0][3] = (vec4(-9.0, -8.0, -3.0, 5.0));
	var[2][0][1][0] = (vec4(-9.0, 6.0, -6.0, 7.0));
	var[2][0][1][1] = (vec4(-8.0, 2.0, 7.0, -5.0));
	var[2][0][1][2] = (vec4(0.0, -4.0, -7.0, 6.0));
	var[2][0][1][3] = (vec4(0.0, 0.0, 4.0, -5.0));
	var[2][0][2][0] = (vec4(-1.0, -9.0, -7.0, 5.0));
	var[2][0][2][1] = (vec4(3.0, 9.0, -8.0, -6.0));
	var[2][0][2][2] = (vec4(-3.0, 6.0, -9.0, 4.0));
	var[2][0][2][3] = (vec4(6.0, -6.0, -6.0, -2.0));
	var[2][1][0][0] = (vec4(-2.0, -9.0, -3.0, -3.0));
	var[2][1][0][1] = (vec4(-3.0, 0.0, -7.0, 1.0));
	var[2][1][0][2] = (vec4(6.0, -1.0, 3.0, 4.0));
	var[2][1][0][3] = (vec4(8.0, 7.0, 7.0, -9.0));
	var[2][1][1][0] = (vec4(-9.0, 3.0, 5.0, 7.0));
	var[2][1][1][1] = (vec4(3.0, -6.0, -1.0, -5.0));
	var[2][1][1][2] = (vec4(9.0, -7.0, 9.0, -7.0));
	var[2][1][1][3] = (vec4(7.0, 5.0, -8.0, 6.0));
	var[2][1][2][0] = (vec4(1.0, 7.0, -7.0, -7.0));
	var[2][1][2][1] = (vec4(-9.0, -7.0, -8.0, 7.0));
	var[2][1][2][2] = (vec4(5.0, -2.0, 5.0, -4.0));
	var[2][1][2][3] = (vec4(-8.0, 0.0, 0.0, 7.0));
	var[3][0][0][0] = (vec4(-8.0, -3.0, -8.0, 5.0));
	var[3][0][0][1] = (vec4(6.0, -9.0, -7.0, -7.0));
	var[3][0][0][2] = (vec4(6.0, 1.0, 0.0, -3.0));
	var[3][0][0][3] = (vec4(4.0, 1.0, -7.0, 4.0));
	var[3][0][1][0] = (vec4(6.0, 4.0, 3.0, -5.0));
	var[3][0][1][1] = (vec4(-8.0, 0.0, -2.0, 7.0));
	var[3][0][1][2] = (vec4(5.0, -1.0, -3.0, -2.0));
	var[3][0][1][3] = (vec4(-6.0, -9.0, -3.0, 5.0));
	var[3][0][2][0] = (vec4(8.0, 7.0, -4.0, 1.0));
	var[3][0][2][1] = (vec4(6.0, -9.0, 8.0, 3.0));
	var[3][0][2][2] = (vec4(-6.0, -7.0, 7.0, -1.0));
	var[3][0][2][3] = (vec4(-7.0, 6.0, -5.0, 9.0));
	var[3][1][0][0] = (vec4(-9.0, 2.0, -4.0, 0.0));
	var[3][1][0][1] = (vec4(-5.0, -8.0, -8.0, 2.0));
	var[3][1][0][2] = (vec4(9.0, -9.0, -6.0, 5.0));
	var[3][1][0][3] = (vec4(0.0, 9.0, 6.0, 5.0));
	var[3][1][1][0] = (vec4(-2.0, -9.0, 6.0, -7.0));
	var[3][1][1][1] = (vec4(5.0, 4.0, 2.0, -6.0));
	var[3][1][1][2] = (vec4(-8.0, -7.0, 4.0, 1.0));
	var[3][1][1][3] = (vec4(1.0, 1.0, 6.0, 2.0));
	var[3][1][2][0] = (vec4(-7.0, 8.0, -8.0, 4.0));
	var[3][1][2][1] = (vec4(2.0, 3.0, -3.0, -2.0));
	var[3][1][2][2] = (vec4(9.0, 1.0, -8.0, 2.0));
	var[3][1][2][3] = (vec4(2.0, -1.0, -9.0, 9.0));
}
#version 450
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
	highp mat3x2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0][0][0], mat3x2(-5.0, 7.0, -1.0, -4.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][1], mat3x2(-5.0, 7.0, -4.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][2], mat3x2(8.0, -3.0, 3.0, -5.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][0], mat3x2(-1.0, -4.0, 1.0, 0.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][1], mat3x2(-1.0, 6.0, -9.0, -3.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][2], mat3x2(5.0, 2.0, -7.0, -9.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][0], mat3x2(-8.0, -4.0, 7.0, 3.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][1], mat3x2(0.0, 9.0, -4.0, -9.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][2], mat3x2(0.0, 9.0, 2.0, -2.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][0], mat3x2(-6.0, -4.0, 0.0, -4.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][1], mat3x2(-8.0, -6.0, -9.0, 9.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][2], mat3x2(-7.0, 4.0, -5.0, -9.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][0], mat3x2(0.0, 6.0, -2.0, 6.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][1], mat3x2(1.0, 5.0, 8.0, 3.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][2], mat3x2(0.0, 9.0, -2.0, 3.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][0], mat3x2(5.0, 0.0, 7.0, -1.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][1], mat3x2(4.0, 9.0, 4.0, 8.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][2], mat3x2(2.0, -5.0, 6.0, -8.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][0], mat3x2(-3.0, 4.0, 1.0, -5.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][1], mat3x2(1.0, -8.0, -7.0, -8.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][2], mat3x2(-5.0, -4.0, 7.0, 3.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][0], mat3x2(1.0, 4.0, -7.0, -4.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][1], mat3x2(-7.0, 8.0, -8.0, -9.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][2], mat3x2(0.0, -4.0, 9.0, -5.0, -3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec2(-8.0, -4.0));
	var[0][0][0][1] = (vec2(-3.0, 5.0));
	var[0][0][0][2] = (vec2(-9.0, 4.0));
	var[0][0][1][0] = (vec2(-2.0, -1.0));
	var[0][0][1][1] = (vec2(8.0, 3.0));
	var[0][0][1][2] = (vec2(7.0, 2.0));
	var[0][0][2][0] = (vec2(-4.0, 4.0));
	var[0][0][2][1] = (vec2(3.0, -6.0));
	var[0][0][2][2] = (vec2(-4.0, 3.0));
	var[0][1][0][0] = (vec2(2.0, 6.0));
	var[0][1][0][1] = (vec2(6.0, 1.0));
	var[0][1][0][2] = (vec2(4.0, -8.0));
	var[0][1][1][0] = (vec2(2.0, -5.0));
	var[0][1][1][1] = (vec2(-5.0, 5.0));
	var[0][1][1][2] = (vec2(2.0, -1.0));
	var[0][1][2][0] = (vec2(-9.0, 3.0));
	var[0][1][2][1] = (vec2(6.0, 5.0));
	var[0][1][2][2] = (vec2(-1.0, -8.0));
	var[1][0][0][0] = (vec2(4.0, 6.0));
	var[1][0][0][1] = (vec2(3.0, 6.0));
	var[1][0][0][2] = (vec2(-2.0, -9.0));
	var[1][0][1][0] = (vec2(-9.0, 0.0));
	var[1][0][1][1] = (vec2(-4.0, 9.0));
	var[1][0][1][2] = (vec2(-1.0, -1.0));
	var[1][0][2][0] = (vec2(-8.0, 6.0));
	var[1][0][2][1] = (vec2(5.0, -2.0));
	var[1][0][2][2] = (vec2(1.0, 4.0));
	var[1][1][0][0] = (vec2(2.0, -1.0));
	var[1][1][0][1] = (vec2(0.0, -2.0));
	var[1][1][0][2] = (vec2(-4.0, 6.0));
	var[1][1][1][0] = (vec2(2.0, -3.0));
	var[1][1][1][1] = (vec2(-2.0, 1.0));
	var[1][1][1][2] = (vec2(-3.0, 8.0));
	var[1][1][2][0] = (vec2(5.0, -1.0));
	var[1][1][2][1] = (vec2(-4.0, -4.0));
	var[1][1][2][2] = (vec2(7.0, -6.0));
	var[2][0][0][0] = (vec2(2.0, -5.0));
	var[2][0][0][1] = (vec2(-5.0, -9.0));
	var[2][0][0][2] = (vec2(-7.0, 3.0));
	var[2][0][1][0] = (vec2(-1.0, 0.0));
	var[2][0][1][1] = (vec2(-1.0, 4.0));
	var[2][0][1][2] = (vec2(-1.0, -6.0));
	var[2][0][2][0] = (vec2(-8.0, -6.0));
	var[2][0][2][1] = (vec2(8.0, 7.0));
	var[2][0][2][2] = (vec2(4.0, -9.0));
	var[2][1][0][0] = (vec2(-2.0, -8.0));
	var[2][1][0][1] = (vec2(0.0, -2.0));
	var[2][1][0][2] = (vec2(8.0, -2.0));
	var[2][1][1][0] = (vec2(3.0, 7.0));
	var[2][1][1][1] = (vec2(-9.0, -1.0));
	var[2][1][1][2] = (vec2(5.0, 7.0));
	var[2][1][2][0] = (vec2(-5.0, 7.0));
	var[2][1][2][1] = (vec2(6.0, 2.0));
	var[2][1][2][2] = (vec2(-4.0, -3.0));
	var[3][0][0][0] = (vec2(-4.0, -1.0));
	var[3][0][0][1] = (vec2(-3.0, -2.0));
	var[3][0][0][2] = (vec2(-5.0, -2.0));
	var[3][0][1][0] = (vec2(-7.0, -3.0));
	var[3][0][1][1] = (vec2(5.0, 4.0));
	var[3][0][1][2] = (vec2(4.0, 1.0));
	var[3][0][2][0] = (vec2(-3.0, -6.0));
	var[3][0][2][1] = (vec2(-4.0, -2.0));
	var[3][0][2][2] = (vec2(-5.0, -7.0));
	var[3][1][0][0] = (vec2(-5.0, 2.0));
	var[3][1][0][1] = (vec2(-7.0, 8.0));
	var[3][1][0][2] = (vec2(-6.0, 3.0));
	var[3][1][1][0] = (vec2(-3.0, -4.0));
	var[3][1][1][1] = (vec2(-5.0, -9.0));
	var[3][1][1][2] = (vec2(-8.0, -7.0));
	var[3][1][2][0] = (vec2(8.0, -8.0));
	var[3][1][2][1] = (vec2(-2.0, 7.0));
	var[3][1][2][2] = (vec2(5.0, -5.0));
}
#version 450
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

layout(std430, binding = 1) buffer Block
{
	highp mat4x2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0][0][0], mat4x2(8.0, 1.0, 9.0, 3.0, -8.0, 3.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][1], mat4x2(8.0, -6.0, -5.0, 7.0, -8.0, -2.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][2], mat4x2(9.0, 4.0, 4.0, 4.0, 3.0, -6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][0], mat4x2(3.0, -3.0, -9.0, 4.0, -4.0, -4.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][1], mat4x2(-1.0, -6.0, -9.0, 0.0, 2.0, -7.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][2], mat4x2(4.0, -4.0, -5.0, -5.0, 1.0, -5.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][0], mat4x2(3.0, -2.0, -4.0, 6.0, -1.0, 6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][1], mat4x2(-1.0, 0.0, -1.0, -3.0, 6.0, -8.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][2], mat4x2(2.0, -2.0, 9.0, -1.0, 8.0, -1.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][0], mat4x2(-4.0, 2.0, -1.0, -3.0, -7.0, -8.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][1], mat4x2(4.0, 9.0, -6.0, -7.0, 1.0, 2.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][2], mat4x2(2.0, -5.0, -5.0, -2.0, 5.0, 3.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][0], mat4x2(0.0, 7.0, 4.0, 1.0, -9.0, -2.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][1], mat4x2(8.0, 8.0, -1.0, -5.0, -4.0, 4.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][2], mat4x2(7.0, 4.0, 2.0, -2.0, -2.0, 5.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][0], mat4x2(1.0, -1.0, 1.0, -8.0, -7.0, -2.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][1], mat4x2(-6.0, -7.0, -6.0, 9.0, -2.0, 0.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][2], mat4x2(2.0, 0.0, 6.0, 6.0, -2.0, -2.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][0], mat4x2(8.0, -7.0, 6.0, -9.0, -2.0, -4.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][1], mat4x2(-4.0, 1.0, -6.0, 5.0, -7.0, -4.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][2], mat4x2(2.0, -3.0, -2.0, -6.0, 9.0, -8.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][0], mat4x2(-7.0, 8.0, 7.0, 7.0, 3.0, -3.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][1], mat4x2(-9.0, 3.0, 2.0, 9.0, 1.0, -1.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][2], mat4x2(-5.0, 0.0, 5.0, 8.0, 6.0, 2.0, -3.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4x2(-9.0, -8.0, -8.0, 3.0, 8.0, 7.0, 0.0, 5.0));
	var[0][0][1] = (mat4x2(5.0, 8.0, 8.0, 8.0, 6.0, -3.0, -6.0, -4.0));
	var[0][0][2] = (mat4x2(-6.0, -9.0, 1.0, -1.0, 8.0, -7.0, 5.0, -3.0));
	var[0][1][0] = (mat4x2(8.0, 9.0, 4.0, -2.0, -8.0, -5.0, -3.0, 9.0));
	var[0][1][1] = (mat4x2(9.0, -3.0, 8.0, 2.0, -9.0, 2.0, 1.0, -2.0));
	var[0][1][2] = (mat4x2(6.0, 7.0, -3.0, 4.0, 8.0, -4.0, -9.0, -6.0));
	var[1][0][0] = (mat4x2(8.0, 7.0, 6.0, 9.0, 0.0, -1.0, 7.0, 0.0));
	var[1][0][1] = (mat4x2(1.0, 6.0, 8.0, 3.0, 9.0, 0.0, -5.0, -5.0));
	var[1][0][2] = (mat4x2(3.0, -5.0, 8.0, 2.0, -9.0, 0.0, 7.0, 6.0));
	var[1][1][0] = (mat4x2(-8.0, 1.0, 6.0, -6.0, 6.0, -2.0, -8.0, 8.0));
	var[1][1][1] = (mat4x2(0.0, 7.0, -6.0, 0.0, -7.0, 3.0, -3.0, 1.0));
	var[1][1][2] = (mat4x2(-4.0, -6.0, -8.0, -9.0, 1.0, 4.0, 2.0, -5.0));
	var[2][0][0] = (mat4x2(-4.0, 4.0, -6.0, 9.0, 5.0, 8.0, -2.0, -7.0));
	var[2][0][1] = (mat4x2(8.0, -4.0, 6.0, -7.0, 8.0, -5.0, 8.0, 4.0));
	var[2][0][2] = (mat4x2(-4.0, -8.0, 4.0, 9.0, 5.0, 6.0, 9.0, 3.0));
	var[2][1][0] = (mat4x2(-4.0, 0.0, 5.0, 8.0, 4.0, -1.0, 1.0, 4.0));
	var[2][1][1] = (mat4x2(-1.0, -3.0, -1.0, 1.0, 3.0, 4.0, -6.0, -8.0));
	var[2][1][2] = (mat4x2(-3.0, 8.0, -7.0, -8.0, 3.0, 0.0, -2.0, 7.0));
	var[3][0][0] = (mat4x2(-5.0, 7.0, -9.0, 1.0, 1.0, -3.0, 9.0, -2.0));
	var[3][0][1] = (mat4x2(6.0, -7.0, 7.0, -9.0, 7.0, -6.0, -9.0, -4.0));
	var[3][0][2] = (mat4x2(3.0, -8.0, 2.0, -9.0, 6.0, 2.0, -6.0, 3.0));
	var[3][1][0] = (mat4x2(-2.0, 7.0, -8.0, -6.0, 4.0, -9.0, 3.0, -6.0));
	var[3][1][1] = (mat4x2(-7.0, 5.0, 0.0, -5.0, 7.0, 3.0, -1.0, -3.0));
	var[3][1][2] = (mat4x2(5.0, -8.0, 1.0, -3.0, 7.0, -8.0, 1.0, -4.0));
}
#version 450
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
	highp uvec2 var[4][2][3];
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((padding), 6u) && allOk;
	allOk = compare_uvec2((var[0][0][0]), uvec2(0u, 6u)) && allOk;
	allOk = compare_uvec2((var[0][0][1]), uvec2(7u, 1u)) && allOk;
	allOk = compare_uvec2((var[0][0][2]), uvec2(7u, 9u)) && allOk;
	allOk = compare_uvec2((var[0][1][0]), uvec2(7u, 4u)) && allOk;
	allOk = compare_uvec2((var[0][1][1]), uvec2(6u, 5u)) && allOk;
	allOk = compare_uvec2((var[0][1][2]), uvec2(8u, 9u)) && allOk;
	allOk = compare_uvec2((var[1][0][0]), uvec2(0u, 6u)) && allOk;
	allOk = compare_uvec2((var[1][0][1]), uvec2(9u, 8u)) && allOk;
	allOk = compare_uvec2((var[1][0][2]), uvec2(4u, 0u)) && allOk;
	allOk = compare_uvec2((var[1][1][0]), uvec2(9u, 2u)) && allOk;
	allOk = compare_uvec2((var[1][1][1]), uvec2(1u, 0u)) && allOk;
	allOk = compare_uvec2((var[1][1][2]), uvec2(7u, 8u)) && allOk;
	allOk = compare_uvec2((var[2][0][0]), uvec2(2u, 2u)) && allOk;
	allOk = compare_uvec2((var[2][0][1]), uvec2(9u, 8u)) && allOk;
	allOk = compare_uvec2((var[2][0][2]), uvec2(4u, 1u)) && allOk;
	allOk = compare_uvec2((var[2][1][0]), uvec2(6u, 7u)) && allOk;
	allOk = compare_uvec2((var[2][1][1]), uvec2(3u, 4u)) && allOk;
	allOk = compare_uvec2((var[2][1][2]), uvec2(9u, 3u)) && allOk;
	allOk = compare_uvec2((var[3][0][0]), uvec2(4u, 7u)) && allOk;
	allOk = compare_uvec2((var[3][0][1]), uvec2(1u, 8u)) && allOk;
	allOk = compare_uvec2((var[3][0][2]), uvec2(8u, 7u)) && allOk;
	allOk = compare_uvec2((var[3][1][0]), uvec2(2u, 4u)) && allOk;
	allOk = compare_uvec2((var[3][1][1]), uvec2(8u, 8u)) && allOk;
	allOk = compare_uvec2((var[3][1][2]), uvec2(8u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (6u);
	var[0][0][0] = (uvec2(1u, 8u));
	var[0][0][1] = (uvec2(1u, 7u));
	var[0][0][2] = (uvec2(4u, 6u));
	var[0][1][0] = (uvec2(2u, 6u));
	var[0][1][1] = (uvec2(0u, 3u));
	var[0][1][2] = (uvec2(2u, 5u));
	var[1][0][0] = (uvec2(6u, 5u));
	var[1][0][1] = (uvec2(8u, 4u));
	var[1][0][2] = (uvec2(7u, 8u));
	var[1][1][0] = (uvec2(1u, 7u));
	var[1][1][1] = (uvec2(2u, 3u));
	var[1][1][2] = (uvec2(6u, 0u));
	var[2][0][0] = (uvec2(4u, 6u));
	var[2][0][1] = (uvec2(3u, 6u));
	var[2][0][2] = (uvec2(0u, 3u));
	var[2][1][0] = (uvec2(1u, 2u));
	var[2][1][1] = (uvec2(6u, 9u));
	var[2][1][2] = (uvec2(1u, 4u));
	var[3][0][0] = (uvec2(5u, 2u));
	var[3][0][1] = (uvec2(4u, 7u));
	var[3][0][2] = (uvec2(8u, 6u));
	var[3][1][0] = (uvec2(6u, 4u));
	var[3][1][1] = (uvec2(2u, 7u));
	var[3][1][2] = (uvec2(5u, 1u));
}
#version 450
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
	highp mat2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_mat2(var[0][0][0], mat2(-2.0, -2.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(-4.0, 8.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat2(var[0][0][2], mat2(9.0, 7.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(8.0, 7.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(8.0, 8.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat2(var[0][1][2], mat2(3.0, -6.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(-3.0, -9.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(-8.0, -8.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2(var[1][0][2], mat2(-2.0, -9.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(-8.0, 2.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(3.0, -1.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat2(var[1][1][2], mat2(-9.0, 7.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(8.0, -4.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(-8.0, -4.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat2(var[2][0][2], mat2(-4.0, -4.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(-9.0, 2.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(9.0, 0.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat2(var[2][1][2], mat2(3.0, 5.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2(var[3][0][0], mat2(3.0, -4.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat2(var[3][0][1], mat2(-3.0, 4.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat2(var[3][0][2], mat2(-5.0, 0.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2(var[3][1][0], mat2(-4.0, 8.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat2(var[3][1][1], mat2(9.0, 0.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat2(var[3][1][2], mat2(2.0, 3.0, 0.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-2.0);
	var[0][0][0] = (mat2(-8.0, -7.0, 9.0, 2.0));
	var[0][0][1] = (mat2(2.0, -4.0, -5.0, -1.0));
	var[0][0][2] = (mat2(-4.0, 0.0, -1.0, 0.0));
	var[0][1][0] = (mat2(7.0, 7.0, -8.0, 7.0));
	var[0][1][1] = (mat2(-9.0, -2.0, 4.0, 3.0));
	var[0][1][2] = (mat2(3.0, 3.0, -6.0, -4.0));
	var[1][0][0] = (mat2(4.0, -3.0, -4.0, -6.0));
	var[1][0][1] = (mat2(0.0, 5.0, 1.0, -6.0));
	var[1][0][2] = (mat2(9.0, 5.0, 9.0, 5.0));
	var[1][1][0] = (mat2(-8.0, -2.0, 5.0, -3.0));
	var[1][1][1] = (mat2(5.0, 0.0, -2.0, -3.0));
	var[1][1][2] = (mat2(0.0, -9.0, 1.0, -8.0));
	var[2][0][0] = (mat2(-3.0, -3.0, 6.0, -4.0));
	var[2][0][1] = (mat2(-6.0, -2.0, -6.0, -3.0));
	var[2][0][2] = (mat2(-4.0, -7.0, -9.0, 8.0));
	var[2][1][0] = (mat2(1.0, -1.0, -3.0, 6.0));
	var[2][1][1] = (mat2(-9.0, -7.0, 6.0, -6.0));
	var[2][1][2] = (mat2(-2.0, 6.0, 0.0, -4.0));
	var[3][0][0] = (mat2(2.0, -6.0, 9.0, -5.0));
	var[3][0][1] = (mat2(-2.0, 4.0, 9.0, 4.0));
	var[3][0][2] = (mat2(7.0, 4.0, -8.0, 5.0));
	var[3][1][0] = (mat2(-4.0, -6.0, -7.0, 1.0));
	var[3][1][1] = (mat2(6.0, -7.0, 7.0, 9.0));
	var[3][1][2] = (mat2(-8.0, 3.0, -7.0, -3.0));
}
#version 450
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
	allOk = compare_float((padding), 2.0) && allOk;
	allOk = compare_mat3(var[0][0][0], mat3(-3.0, 4.0, 5.0, -1.0, 7.0, 7.0, 0.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(-3.0, 0.0, -1.0, -5.0, 6.0, 9.0, 4.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat3(var[0][0][2], mat3(8.0, 3.0, -2.0, -1.0, 8.0, -2.0, 4.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(5.0, -5.0, 9.0, 1.0, 1.0, 5.0, 9.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(5.0, 4.0, 8.0, -9.0, 9.0, 2.0, 8.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat3(var[0][1][2], mat3(-2.0, -4.0, 3.0, 5.0, -9.0, 0.0, 8.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(-3.0, -4.0, 7.0, -1.0, 9.0, -7.0, 8.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(5.0, -2.0, 0.0, 7.0, -3.0, 1.0, -6.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat3(var[1][0][2], mat3(8.0, -9.0, -1.0, -4.0, 4.0, -3.0, 9.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(-4.0, -9.0, 0.0, 9.0, -3.0, 0.0, 0.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(-6.0, -1.0, -4.0, 8.0, -3.0, 3.0, -2.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat3(var[1][1][2], mat3(-8.0, 2.0, -4.0, -7.0, 7.0, 3.0, 2.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(2.0, -6.0, -2.0, -2.0, 3.0, -5.0, 8.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(-9.0, -5.0, 8.0, -7.0, 2.0, -9.0, 0.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3(var[2][0][2], mat3(5.0, 4.0, 9.0, 7.0, 8.0, -2.0, 6.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(-8.0, -2.0, -1.0, 8.0, 3.0, 0.0, 2.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(1.0, -4.0, 4.0, 2.0, -7.0, 2.0, 4.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat3(var[2][1][2], mat3(8.0, 7.0, 0.0, 8.0, -5.0, -5.0, -1.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat3(var[3][0][0], mat3(-1.0, 6.0, 0.0, -2.0, -1.0, -1.0, -6.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3(var[3][0][1], mat3(-4.0, -9.0, 2.0, 5.0, 1.0, -1.0, 1.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3(var[3][0][2], mat3(1.0, 2.0, 2.0, -5.0, 1.0, -1.0, 9.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat3(var[3][1][0], mat3(8.0, -8.0, 8.0, -5.0, -1.0, -1.0, -1.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat3(var[3][1][1], mat3(6.0, -6.0, -5.0, 2.0, 5.0, 7.0, -3.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat3(var[3][1][2], mat3(1.0, 5.0, 9.0, 2.0, -4.0, -8.0, 5.0, 6.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (3.0);
	var[0][0][0][0] = (vec3(2.0, 4.0, 6.0));
	var[0][0][0][1] = (vec3(2.0, -9.0, 0.0));
	var[0][0][0][2] = (vec3(-9.0, 3.0, -7.0));
	var[0][0][1][0] = (vec3(-4.0, -4.0, 5.0));
	var[0][0][1][1] = (vec3(-4.0, 1.0, -7.0));
	var[0][0][1][2] = (vec3(3.0, -3.0, 7.0));
	var[0][0][2][0] = (vec3(8.0, 2.0, 5.0));
	var[0][0][2][1] = (vec3(-9.0, 7.0, -2.0));
	var[0][0][2][2] = (vec3(9.0, -7.0, -7.0));
	var[0][1][0][0] = (vec3(8.0, -5.0, 4.0));
	var[0][1][0][1] = (vec3(1.0, -7.0, 3.0));
	var[0][1][0][2] = (vec3(1.0, -4.0, -3.0));
	var[0][1][1][0] = (vec3(8.0, 1.0, -8.0));
	var[0][1][1][1] = (vec3(5.0, 9.0, -2.0));
	var[0][1][1][2] = (vec3(-3.0, 6.0, 4.0));
	var[0][1][2][0] = (vec3(-6.0, 5.0, -4.0));
	var[0][1][2][1] = (vec3(5.0, -3.0, 3.0));
	var[0][1][2][2] = (vec3(-7.0, 4.0, 8.0));
	var[1][0][0][0] = (vec3(-1.0, 1.0, 0.0));
	var[1][0][0][1] = (vec3(7.0, 7.0, 9.0));
	var[1][0][0][2] = (vec3(3.0, 4.0, 4.0));
	var[1][0][1][0] = (vec3(9.0, 1.0, -6.0));
	var[1][0][1][1] = (vec3(7.0, -6.0, -1.0));
	var[1][0][1][2] = (vec3(4.0, -3.0, -5.0));
	var[1][0][2][0] = (vec3(-8.0, -9.0, 6.0));
	var[1][0][2][1] = (vec3(2.0, -2.0, -7.0));
	var[1][0][2][2] = (vec3(-2.0, -7.0, 6.0));
	var[1][1][0][0] = (vec3(6.0, 5.0, 1.0));
	var[1][1][0][1] = (vec3(7.0, 9.0, 0.0));
	var[1][1][0][2] = (vec3(6.0, 1.0, -7.0));
	var[1][1][1][0] = (vec3(4.0, -8.0, -8.0));
	var[1][1][1][1] = (vec3(8.0, 9.0, -9.0));
	var[1][1][1][2] = (vec3(8.0, 6.0, -8.0));
	var[1][1][2][0] = (vec3(4.0, -6.0, -4.0));
	var[1][1][2][1] = (vec3(-6.0, 0.0, 0.0));
	var[1][1][2][2] = (vec3(-3.0, -7.0, -3.0));
	var[2][0][0][0] = (vec3(9.0, 2.0, -4.0));
	var[2][0][0][1] = (vec3(-9.0, -5.0, 4.0));
	var[2][0][0][2] = (vec3(-2.0, -1.0, -1.0));
	var[2][0][1][0] = (vec3(-1.0, 3.0, 0.0));
	var[2][0][1][1] = (vec3(-7.0, 1.0, -6.0));
	var[2][0][1][2] = (vec3(-6.0, 9.0, 0.0));
	var[2][0][2][0] = (vec3(8.0, 6.0, 4.0));
	var[2][0][2][1] = (vec3(7.0, -4.0, 4.0));
	var[2][0][2][2] = (vec3(-6.0, 0.0, -6.0));
	var[2][1][0][0] = (vec3(-2.0, 3.0, -3.0));
	var[2][1][0][1] = (vec3(-1.0, 5.0, -8.0));
	var[2][1][0][2] = (vec3(-9.0, 1.0, 3.0));
	var[2][1][1][0] = (vec3(-7.0, -8.0, -8.0));
	var[2][1][1][1] = (vec3(-6.0, 2.0, -1.0));
	var[2][1][1][2] = (vec3(-4.0, 8.0, 5.0));
	var[2][1][2][0] = (vec3(-4.0, -5.0, 5.0));
	var[2][1][2][1] = (vec3(-6.0, 8.0, -7.0));
	var[2][1][2][2] = (vec3(1.0, 3.0, 0.0));
	var[3][0][0][0] = (vec3(0.0, -8.0, 6.0));
	var[3][0][0][1] = (vec3(-7.0, -2.0, 7.0));
	var[3][0][0][2] = (vec3(3.0, -3.0, 4.0));
	var[3][0][1][0] = (vec3(-6.0, 7.0, 1.0));
	var[3][0][1][1] = (vec3(6.0, 3.0, 0.0));
	var[3][0][1][2] = (vec3(-8.0, 1.0, -2.0));
	var[3][0][2][0] = (vec3(1.0, 3.0, 4.0));
	var[3][0][2][1] = (vec3(5.0, -3.0, -6.0));
	var[3][0][2][2] = (vec3(-9.0, 9.0, -7.0));
	var[3][1][0][0] = (vec3(-3.0, -5.0, 3.0));
	var[3][1][0][1] = (vec3(-3.0, -4.0, -7.0));
	var[3][1][0][2] = (vec3(-1.0, -9.0, -5.0));
	var[3][1][1][0] = (vec3(-3.0, -1.0, -3.0));
	var[3][1][1][1] = (vec3(3.0, 3.0, 9.0));
	var[3][1][1][2] = (vec3(4.0, -6.0, -6.0));
	var[3][1][2][0] = (vec3(5.0, 6.0, 7.0));
	var[3][1][2][1] = (vec3(-1.0, -3.0, -3.0));
	var[3][1][2][2] = (vec3(-4.0, -5.0, -1.0));
}
#version 450
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
	allOk = compare_float((padding), -1.0) && allOk;
	allOk = compare_mat4x3(var[0][0][0], mat4x3(5.0, -5.0, 7.0, -9.0, 5.0, 0.0, 8.0, 6.0, 1.0, -7.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(0.0, -8.0, -3.0, -6.0, 8.0, 8.0, -7.0, 8.0, 7.0, -9.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][2], mat4x3(-2.0, 4.0, 9.0, 9.0, 8.0, -2.0, -2.0, -4.0, 5.0, 0.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(-7.0, -3.0, -9.0, 0.0, 4.0, 2.0, -2.0, 4.0, 3.0, -3.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(-8.0, 3.0, -8.0, 3.0, 6.0, 3.0, 7.0, -8.0, -3.0, -3.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][2], mat4x3(-4.0, -7.0, 3.0, -9.0, 6.0, -1.0, 1.0, 4.0, -8.0, -9.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(-5.0, 7.0, 2.0, -7.0, 7.0, -9.0, -2.0, -7.0, -6.0, -4.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(5.0, -7.0, -5.0, 3.0, -9.0, 2.0, -7.0, 3.0, 8.0, 7.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][2], mat4x3(-1.0, -5.0, 4.0, -4.0, -9.0, 6.0, 6.0, 2.0, 5.0, -7.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(-3.0, 4.0, 9.0, 4.0, -3.0, -3.0, 0.0, -1.0, 9.0, 8.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(9.0, -9.0, 7.0, -7.0, -8.0, 2.0, -8.0, -9.0, -6.0, -2.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][2], mat4x3(-4.0, 9.0, 3.0, -2.0, 9.0, 0.0, -3.0, -7.0, -3.0, -3.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(4.0, -3.0, -1.0, 0.0, -4.0, 3.0, 9.0, 8.0, -4.0, 7.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(1.0, 5.0, -8.0, -3.0, -1.0, 1.0, -8.0, 1.0, 8.0, -6.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][2], mat4x3(-8.0, 4.0, -1.0, -3.0, 8.0, -6.0, 9.0, -3.0, -3.0, 1.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(-2.0, -5.0, 9.0, -1.0, -2.0, 6.0, -5.0, -6.0, 2.0, 2.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(-6.0, -9.0, 1.0, 7.0, -9.0, 1.0, 3.0, 3.0, -7.0, 6.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][2], mat4x3(4.0, -6.0, 5.0, 3.0, -4.0, 0.0, -3.0, -6.0, 7.0, 4.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][0], mat4x3(-3.0, -5.0, 5.0, -4.0, -7.0, 2.0, 2.0, -1.0, -9.0, -6.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][1], mat4x3(6.0, 8.0, 5.0, -3.0, -3.0, 3.0, 3.0, 1.0, 7.0, 3.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][2], mat4x3(-3.0, 2.0, 9.0, 0.0, -7.0, 3.0, -1.0, 0.0, 1.0, -1.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][0], mat4x3(-6.0, -3.0, 7.0, 0.0, 0.0, 0.0, -8.0, 5.0, -2.0, -5.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][1], mat4x3(-9.0, -9.0, 1.0, -3.0, -7.0, 9.0, -8.0, -7.0, 1.0, -4.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][2], mat4x3(-5.0, 6.0, -7.0, -8.0, -1.0, 7.0, -2.0, 1.0, -2.0, 2.0, -6.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-2.0);
	var[0][0][0] = (mat4x3(4.0, 4.0, 3.0, 2.0, 4.0, 6.0, 7.0, -2.0, 2.0, 9.0, 6.0, -8.0));
	var[0][0][1] = (mat4x3(9.0, 6.0, -2.0, 4.0, -7.0, 6.0, -7.0, 9.0, 6.0, -2.0, 9.0, 6.0));
	var[0][0][2] = (mat4x3(9.0, -6.0, 5.0, -3.0, 9.0, -5.0, 9.0, 9.0, -3.0, 8.0, 8.0, -7.0));
	var[0][1][0] = (mat4x3(6.0, 0.0, 6.0, -2.0, 0.0, 4.0, -2.0, -4.0, 0.0, -6.0, 6.0, 0.0));
	var[0][1][1] = (mat4x3(0.0, 5.0, -8.0, -7.0, 0.0, 2.0, 1.0, 6.0, -6.0, 0.0, 8.0, -9.0));
	var[0][1][2] = (mat4x3(9.0, -9.0, 5.0, -2.0, 2.0, -2.0, 2.0, -6.0, -1.0, 8.0, 6.0, 1.0));
	var[1][0][0] = (mat4x3(-9.0, 7.0, 8.0, 8.0, 3.0, -3.0, -1.0, -5.0, 5.0, 2.0, -4.0, 0.0));
	var[1][0][1] = (mat4x3(-6.0, -2.0, 6.0, -4.0, -8.0, -9.0, 2.0, -1.0, 3.0, 1.0, -1.0, -9.0));
	var[1][0][2] = (mat4x3(-9.0, 1.0, -1.0, -6.0, 4.0, -3.0, 4.0, -4.0, 4.0, -1.0, -4.0, 0.0));
	var[1][1][0] = (mat4x3(9.0, -4.0, -7.0, -9.0, 7.0, -4.0, 9.0, -3.0, 3.0, -7.0, -5.0, 7.0));
	var[1][1][1] = (mat4x3(-5.0, 7.0, 7.0, -1.0, 6.0, -1.0, 6.0, -9.0, 8.0, -7.0, -2.0, 8.0));
	var[1][1][2] = (mat4x3(1.0, 9.0, -1.0, -8.0, -3.0, 7.0, 9.0, -5.0, 8.0, 7.0, -8.0, -3.0));
	var[2][0][0] = (mat4x3(-3.0, 9.0, 3.0, -4.0, 3.0, -6.0, -2.0, -6.0, 8.0, 5.0, -1.0, 2.0));
	var[2][0][1] = (mat4x3(5.0, 8.0, -3.0, 1.0, 2.0, -1.0, 3.0, -5.0, -5.0, 9.0, -6.0, 8.0));
	var[2][0][2] = (mat4x3(1.0, 3.0, 4.0, 4.0, 7.0, -1.0, 4.0, 0.0, 6.0, 9.0, 0.0, 2.0));
	var[2][1][0] = (mat4x3(5.0, -4.0, 6.0, 4.0, -2.0, 9.0, 0.0, -7.0, 3.0, -3.0, 9.0, 5.0));
	var[2][1][1] = (mat4x3(8.0, 3.0, -1.0, 5.0, -3.0, 7.0, 3.0, -2.0, 5.0, 0.0, 3.0, 6.0));
	var[2][1][2] = (mat4x3(-9.0, 6.0, 1.0, 0.0, 5.0, 1.0, -6.0, 1.0, 8.0, -8.0, -9.0, 5.0));
	var[3][0][0] = (mat4x3(1.0, 4.0, -1.0, -2.0, -5.0, -9.0, -2.0, -1.0, -6.0, 7.0, 3.0, -1.0));
	var[3][0][1] = (mat4x3(4.0, 3.0, -2.0, -1.0, -2.0, -3.0, -4.0, 4.0, -6.0, 7.0, 7.0, 9.0));
	var[3][0][2] = (mat4x3(-2.0, 6.0, 5.0, -8.0, 9.0, 8.0, -5.0, 6.0, 0.0, 4.0, 1.0, 7.0));
	var[3][1][0] = (mat4x3(-9.0, -9.0, 7.0, -3.0, 4.0, -7.0, -4.0, -8.0, -6.0, 2.0, 7.0, -1.0));
	var[3][1][1] = (mat4x3(4.0, -5.0, -2.0, 5.0, -3.0, -9.0, 0.0, 8.0, 3.0, 7.0, 7.0, 7.0));
	var[3][1][2] = (mat4x3(1.0, 4.0, -8.0, 6.0, 1.0, 4.0, -6.0, -1.0, 0.0, -1.0, -2.0, -8.0));
}
#version 450
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
	highp mat2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0][0][0], mat2(3.0, 8.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(-3.0, 1.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(9.0, 8.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(5.0, 0.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2(var[0][2][0], mat2(4.0, -7.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat2(var[0][2][1], mat2(3.0, -5.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat2(var[0][3][0], mat2(2.0, -1.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2(var[0][3][1], mat2(3.0, -2.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(-5.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(-4.0, 5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(-9.0, 7.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(3.0, 9.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1][2][0], mat2(-5.0, 8.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2(var[1][2][1], mat2(-4.0, 2.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(var[1][3][0], mat2(-9.0, 2.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat2(var[1][3][1], mat2(-3.0, 2.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(6.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(4.0, 8.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(8.0, 8.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(-5.0, -3.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat2(var[2][2][0], mat2(5.0, -6.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat2(var[2][2][1], mat2(1.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(var[2][3][0], mat2(-9.0, 4.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(var[2][3][1], mat2(-5.0, -9.0, -8.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2(3.0, -6.0, 2.0, -8.0));
	var[0][0][1] = (mat2(2.0, -5.0, -3.0, 9.0));
	var[0][1][0] = (mat2(-2.0, -7.0, -8.0, 6.0));
	var[0][1][1] = (mat2(2.0, 3.0, -8.0, 4.0));
	var[0][2][0] = (mat2(1.0, -2.0, -9.0, -7.0));
	var[0][2][1] = (mat2(2.0, 7.0, 5.0, -3.0));
	var[0][3][0] = (mat2(5.0, -6.0, 1.0, 5.0));
	var[0][3][1] = (mat2(-4.0, -2.0, 1.0, 6.0));
	var[1][0][0] = (mat2(4.0, -9.0, -2.0, -6.0));
	var[1][0][1] = (mat2(-2.0, 4.0, -5.0, -1.0));
	var[1][1][0] = (mat2(7.0, -3.0, 8.0, -1.0));
	var[1][1][1] = (mat2(7.0, -8.0, 5.0, -2.0));
	var[1][2][0] = (mat2(-2.0, -3.0, 3.0, -1.0));
	var[1][2][1] = (mat2(-2.0, -8.0, 1.0, -1.0));
	var[1][3][0] = (mat2(-6.0, -2.0, 3.0, -6.0));
	var[1][3][1] = (mat2(-9.0, -4.0, 0.0, -1.0));
	var[2][0][0] = (mat2(3.0, 1.0, 6.0, 0.0));
	var[2][0][1] = (mat2(-2.0, -5.0, 2.0, 8.0));
	var[2][1][0] = (mat2(-5.0, -2.0, -2.0, 1.0));
	var[2][1][1] = (mat2(6.0, 0.0, 1.0, 8.0));
	var[2][2][0] = (mat2(9.0, -2.0, -3.0, 6.0));
	var[2][2][1] = (mat2(2.0, 6.0, -4.0, -6.0));
	var[2][3][0] = (mat2(0.0, 7.0, 4.0, 1.0));
	var[2][3][1] = (mat2(5.0, -6.0, 5.0, -4.0));
}
#version 450
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
	highp mat3x2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0][0][0], mat3x2(-5.0, 7.0, -1.0, -4.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][1], mat3x2(-5.0, 7.0, -4.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][0], mat3x2(0.0, 6.0, -2.0, 6.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][1], mat3x2(1.0, 5.0, 8.0, 3.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[0][2][0], mat3x2(-1.0, -4.0, 1.0, 0.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[0][2][1], mat3x2(-1.0, 6.0, -9.0, -3.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[0][3][0], mat3x2(5.0, 0.0, 7.0, -1.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[0][3][1], mat3x2(4.0, 9.0, 4.0, 8.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][0], mat3x2(8.0, -3.0, 3.0, -5.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][1], mat3x2(-8.0, -4.0, 7.0, 3.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][0], mat3x2(0.0, 9.0, -2.0, 3.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][1], mat3x2(-3.0, 4.0, 1.0, -5.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[1][2][0], mat3x2(5.0, 2.0, -7.0, -9.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[1][2][1], mat3x2(-6.0, -4.0, 0.0, -4.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[1][3][0], mat3x2(2.0, -5.0, 6.0, -8.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[1][3][1], mat3x2(1.0, 4.0, -7.0, -4.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][0], mat3x2(0.0, 9.0, -4.0, -9.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][1], mat3x2(0.0, 9.0, 2.0, -2.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][0], mat3x2(1.0, -8.0, -7.0, -8.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][1], mat3x2(-5.0, -4.0, 7.0, 3.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[2][2][0], mat3x2(-8.0, -6.0, -9.0, 9.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[2][2][1], mat3x2(-7.0, 4.0, -5.0, -9.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[2][3][0], mat3x2(-7.0, 8.0, -8.0, -9.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[2][3][1], mat3x2(0.0, -4.0, 9.0, -5.0, -3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec2(-8.0, -4.0));
	var[0][0][0][1] = (vec2(-3.0, 5.0));
	var[0][0][0][2] = (vec2(-9.0, 4.0));
	var[0][0][1][0] = (vec2(-2.0, -1.0));
	var[0][0][1][1] = (vec2(8.0, 3.0));
	var[0][0][1][2] = (vec2(7.0, 2.0));
	var[0][1][0][0] = (vec2(2.0, -5.0));
	var[0][1][0][1] = (vec2(-5.0, -9.0));
	var[0][1][0][2] = (vec2(-7.0, 3.0));
	var[0][1][1][0] = (vec2(-1.0, 0.0));
	var[0][1][1][1] = (vec2(-1.0, 4.0));
	var[0][1][1][2] = (vec2(-1.0, -6.0));
	var[0][2][0][0] = (vec2(2.0, 6.0));
	var[0][2][0][1] = (vec2(6.0, 1.0));
	var[0][2][0][2] = (vec2(4.0, -8.0));
	var[0][2][1][0] = (vec2(2.0, -5.0));
	var[0][2][1][1] = (vec2(-5.0, 5.0));
	var[0][2][1][2] = (vec2(2.0, -1.0));
	var[0][3][0][0] = (vec2(-2.0, -8.0));
	var[0][3][0][1] = (vec2(0.0, -2.0));
	var[0][3][0][2] = (vec2(8.0, -2.0));
	var[0][3][1][0] = (vec2(3.0, 7.0));
	var[0][3][1][1] = (vec2(-9.0, -1.0));
	var[0][3][1][2] = (vec2(5.0, 7.0));
	var[1][0][0][0] = (vec2(-4.0, 4.0));
	var[1][0][0][1] = (vec2(3.0, -6.0));
	var[1][0][0][2] = (vec2(-4.0, 3.0));
	var[1][0][1][0] = (vec2(4.0, 6.0));
	var[1][0][1][1] = (vec2(3.0, 6.0));
	var[1][0][1][2] = (vec2(-2.0, -9.0));
	var[1][1][0][0] = (vec2(-8.0, -6.0));
	var[1][1][0][1] = (vec2(8.0, 7.0));
	var[1][1][0][2] = (vec2(4.0, -9.0));
	var[1][1][1][0] = (vec2(-4.0, -1.0));
	var[1][1][1][1] = (vec2(-3.0, -2.0));
	var[1][1][1][2] = (vec2(-5.0, -2.0));
	var[1][2][0][0] = (vec2(-9.0, 3.0));
	var[1][2][0][1] = (vec2(6.0, 5.0));
	var[1][2][0][2] = (vec2(-1.0, -8.0));
	var[1][2][1][0] = (vec2(2.0, -1.0));
	var[1][2][1][1] = (vec2(0.0, -2.0));
	var[1][2][1][2] = (vec2(-4.0, 6.0));
	var[1][3][0][0] = (vec2(-5.0, 7.0));
	var[1][3][0][1] = (vec2(6.0, 2.0));
	var[1][3][0][2] = (vec2(-4.0, -3.0));
	var[1][3][1][0] = (vec2(-5.0, 2.0));
	var[1][3][1][1] = (vec2(-7.0, 8.0));
	var[1][3][1][2] = (vec2(-6.0, 3.0));
	var[2][0][0][0] = (vec2(-9.0, 0.0));
	var[2][0][0][1] = (vec2(-4.0, 9.0));
	var[2][0][0][2] = (vec2(-1.0, -1.0));
	var[2][0][1][0] = (vec2(-8.0, 6.0));
	var[2][0][1][1] = (vec2(5.0, -2.0));
	var[2][0][1][2] = (vec2(1.0, 4.0));
	var[2][1][0][0] = (vec2(-7.0, -3.0));
	var[2][1][0][1] = (vec2(5.0, 4.0));
	var[2][1][0][2] = (vec2(4.0, 1.0));
	var[2][1][1][0] = (vec2(-3.0, -6.0));
	var[2][1][1][1] = (vec2(-4.0, -2.0));
	var[2][1][1][2] = (vec2(-5.0, -7.0));
	var[2][2][0][0] = (vec2(2.0, -3.0));
	var[2][2][0][1] = (vec2(-2.0, 1.0));
	var[2][2][0][2] = (vec2(-3.0, 8.0));
	var[2][2][1][0] = (vec2(5.0, -1.0));
	var[2][2][1][1] = (vec2(-4.0, -4.0));
	var[2][2][1][2] = (vec2(7.0, -6.0));
	var[2][3][0][0] = (vec2(-3.0, -4.0));
	var[2][3][0][1] = (vec2(-5.0, -9.0));
	var[2][3][0][2] = (vec2(-8.0, -7.0));
	var[2][3][1][0] = (vec2(8.0, -8.0));
	var[2][3][1][1] = (vec2(-2.0, 7.0));
	var[2][3][1][2] = (vec2(5.0, -5.0));
}
#version 450
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

layout(scalar, row_major, binding = 1) buffer Block
{
	highp mat2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0][0][0], mat2(3.0, 8.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(-3.0, 1.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(9.0, 8.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(5.0, 0.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2(var[0][2][0], mat2(4.0, -7.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat2(var[0][2][1], mat2(3.0, -5.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat2(var[0][3][0], mat2(2.0, -1.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2(var[0][3][1], mat2(3.0, -2.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(-5.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(-4.0, 5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(-9.0, 7.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(3.0, 9.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1][2][0], mat2(-5.0, 8.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2(var[1][2][1], mat2(-4.0, 2.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(var[1][3][0], mat2(-9.0, 2.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat2(var[1][3][1], mat2(-3.0, 2.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(6.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(4.0, 8.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(8.0, 8.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(-5.0, -3.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat2(var[2][2][0], mat2(5.0, -6.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat2(var[2][2][1], mat2(1.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(var[2][3][0], mat2(-9.0, 4.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(var[2][3][1], mat2(-5.0, -9.0, -8.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2(3.0, -6.0, 2.0, -8.0));
	var[0][0][1] = (mat2(2.0, -5.0, -3.0, 9.0));
	var[0][1][0] = (mat2(-2.0, -7.0, -8.0, 6.0));
	var[0][1][1] = (mat2(2.0, 3.0, -8.0, 4.0));
	var[0][2][0] = (mat2(1.0, -2.0, -9.0, -7.0));
	var[0][2][1] = (mat2(2.0, 7.0, 5.0, -3.0));
	var[0][3][0] = (mat2(5.0, -6.0, 1.0, 5.0));
	var[0][3][1] = (mat2(-4.0, -2.0, 1.0, 6.0));
	var[1][0][0] = (mat2(4.0, -9.0, -2.0, -6.0));
	var[1][0][1] = (mat2(-2.0, 4.0, -5.0, -1.0));
	var[1][1][0] = (mat2(7.0, -3.0, 8.0, -1.0));
	var[1][1][1] = (mat2(7.0, -8.0, 5.0, -2.0));
	var[1][2][0] = (mat2(-2.0, -3.0, 3.0, -1.0));
	var[1][2][1] = (mat2(-2.0, -8.0, 1.0, -1.0));
	var[1][3][0] = (mat2(-6.0, -2.0, 3.0, -6.0));
	var[1][3][1] = (mat2(-9.0, -4.0, 0.0, -1.0));
	var[2][0][0] = (mat2(3.0, 1.0, 6.0, 0.0));
	var[2][0][1] = (mat2(-2.0, -5.0, 2.0, 8.0));
	var[2][1][0] = (mat2(-5.0, -2.0, -2.0, 1.0));
	var[2][1][1] = (mat2(6.0, 0.0, 1.0, 8.0));
	var[2][2][0] = (mat2(9.0, -2.0, -3.0, 6.0));
	var[2][2][1] = (mat2(2.0, 6.0, -4.0, -6.0));
	var[2][3][0] = (mat2(0.0, 7.0, 4.0, 1.0));
	var[2][3][1] = (mat2(5.0, -6.0, 5.0, -4.0));
}
#version 450
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
	allOk = compare_mat2x3(var[0][0][0], mat2x3(2.0, -7.0, 8.0, 7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][1], mat2x3(5.0, -2.0, 1.0, -7.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][0], mat2x3(-9.0, 9.0, 8.0, -5.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][1], mat2x3(9.0, -3.0, -8.0, 0.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[0][2][0], mat2x3(7.0, -5.0, -4.0, 2.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[0][2][1], mat2x3(0.0, 2.0, 2.0, 4.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[0][3][0], mat2x3(-7.0, -4.0, 0.0, -8.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[0][3][1], mat2x3(-6.0, 3.0, 6.0, 5.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][0], mat2x3(6.0, 7.0, 2.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][1], mat2x3(-5.0, 5.0, 9.0, -2.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][0], mat2x3(-8.0, 9.0, 4.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][1], mat2x3(-4.0, -8.0, 0.0, -2.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[1][2][0], mat2x3(-7.0, -4.0, -2.0, -2.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[1][2][1], mat2x3(4.0, -2.0, -1.0, 3.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[1][3][0], mat2x3(-3.0, 3.0, -2.0, 7.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[1][3][1], mat2x3(0.0, 7.0, 6.0, 0.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][0], mat2x3(9.0, 7.0, 9.0, 5.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][1], mat2x3(1.0, 4.0, -6.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][0], mat2x3(-3.0, 2.0, 2.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][1], mat2x3(-3.0, 9.0, -3.0, -8.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[2][2][0], mat2x3(6.0, -7.0, -9.0, -5.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[2][2][1], mat2x3(-1.0, 5.0, 6.0, -4.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat2x3(var[2][3][0], mat2x3(-3.0, -8.0, 4.0, -4.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[2][3][1], mat2x3(-8.0, -6.0, 5.0, -2.0, -8.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2x3(0.0, 6.0, 9.0, 9.0, -8.0, 7.0));
	var[0][0][1] = (mat2x3(5.0, -1.0, -9.0, 0.0, 8.0, 1.0));
	var[0][1][0] = (mat2x3(4.0, -7.0, -7.0, 6.0, -8.0, -8.0));
	var[0][1][1] = (mat2x3(7.0, -8.0, 4.0, 7.0, 0.0, 3.0));
	var[0][2][0] = (mat2x3(-1.0, 0.0, -8.0, 1.0, -2.0, -5.0));
	var[0][2][1] = (mat2x3(6.0, 6.0, 2.0, 0.0, 4.0, -7.0));
	var[0][3][0] = (mat2x3(-1.0, 6.0, -1.0, 2.0, -2.0, -5.0));
	var[0][3][1] = (mat2x3(-9.0, 4.0, -7.0, -5.0, -1.0, -3.0));
	var[1][0][0] = (mat2x3(-7.0, 2.0, 4.0, -8.0, 4.0, 4.0));
	var[1][0][1] = (mat2x3(-4.0, 3.0, 7.0, -5.0, -6.0, 7.0));
	var[1][1][0] = (mat2x3(9.0, 4.0, 7.0, 4.0, -7.0, 6.0));
	var[1][1][1] = (mat2x3(1.0, 3.0, 2.0, -1.0, -8.0, -8.0));
	var[1][2][0] = (mat2x3(1.0, -6.0, 8.0, 1.0, -5.0, 1.0));
	var[1][2][1] = (mat2x3(-7.0, -4.0, -4.0, -5.0, 3.0, 3.0));
	var[1][3][0] = (mat2x3(-4.0, 1.0, -4.0, 7.0, 3.0, 7.0));
	var[1][3][1] = (mat2x3(2.0, -9.0, -2.0, -7.0, 2.0, -7.0));
	var[2][0][0] = (mat2x3(3.0, 8.0, -7.0, -7.0, -6.0, 2.0));
	var[2][0][1] = (mat2x3(-8.0, 8.0, -7.0, -2.0, 5.0, 7.0));
	var[2][1][0] = (mat2x3(2.0, 9.0, -3.0, -1.0, -2.0, -1.0));
	var[2][1][1] = (mat2x3(-1.0, 8.0, 1.0, -6.0, -9.0, -3.0));
	var[2][2][0] = (mat2x3(1.0, 0.0, 9.0, 1.0, -8.0, -1.0));
	var[2][2][1] = (mat2x3(9.0, 5.0, -3.0, -9.0, -8.0, 3.0));
	var[2][3][0] = (mat2x3(-4.0, -8.0, 9.0, 3.0, -1.0, 7.0));
	var[2][3][1] = (mat2x3(-9.0, 4.0, -2.0, -8.0, 3.0, 0.0));
}
#version 450
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

struct S
{
	highp ivec3 a;
	mediump mat3 b[4];
	highp vec4 c;
};
layout(std140, binding = 1) buffer Block
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
	allOk = compare_ivec3((block[0].s[0].a), ivec3(-5, -6, 8)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[0], mat3(3.0, -1.0, 2.0, -8.0, 0.0, 6.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[1], mat3(4.0, 9.0, 2.0, -8.0, 4.0, 8.0, 5.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[2], mat3(-6.0, 1.0, 1.0, -3.0, -2.0, 0.0, 6.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[3], mat3(3.0, -1.0, 4.0, -3.0, -2.0, -9.0, 4.0, -4.0, 7.0)) && allOk;
	allOk = compare_vec4((block[0].s[0].c), vec4(-9.0, 0.0, 9.0, 3.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1].a), ivec3(-8, 8, 0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[0], mat3(-4.0, 7.0, 6.0, -2.0, -3.0, 6.0, -6.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[1], mat3(-3.0, -1.0, 4.0, -2.0, 1.0, -5.0, -9.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[2], mat3(3.0, 0.0, 8.0, -3.0, -5.0, -3.0, -5.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[3], mat3(-9.0, -2.0, -4.0, -2.0, -9.0, -5.0, -6.0, -7.0, 1.0)) && allOk;
	allOk = compare_vec4((block[0].s[1].c), vec4(7.0, -7.0, -7.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2].a), ivec3(4, 5, 3)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[0], mat3(7.0, 4.0, 6.0, 4.0, -7.0, -1.0, 8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[1], mat3(-4.0, 8.0, 0.0, 8.0, -6.0, 7.0, 3.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[2], mat3(9.0, 4.0, 1.0, 3.0, 4.0, -9.0, -8.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[3], mat3(-6.0, -3.0, -2.0, -2.0, -1.0, -7.0, -5.0, -7.0, 6.0)) && allOk;
	allOk = compare_vec4((block[0].s[2].c), vec4(5.0, -4.0, -4.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0].a), ivec3(-6, 7, 8)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[0], mat3(-8.0, -5.0, 2.0, 5.0, -8.0, -3.0, -9.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[1], mat3(-6.0, -8.0, 9.0, 8.0, -8.0, -7.0, -6.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[2], mat3(1.0, -4.0, -3.0, 5.0, -8.0, 0.0, 0.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[3], mat3(9.0, 6.0, 0.0, -4.0, 9.0, -2.0, 8.0, -1.0, -9.0)) && allOk;
	allOk = compare_vec4((block[1].s[0].c), vec4(0.0, -1.0, 4.0, -2.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1].a), ivec3(-5, 7, 5)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[0], mat3(7.0, 8.0, -3.0, -2.0, 4.0, 5.0, 7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[1], mat3(7.0, 2.0, -9.0, -9.0, 2.0, -7.0, -5.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[2], mat3(-6.0, -8.0, -5.0, -5.0, -6.0, -4.0, 8.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[3], mat3(-7.0, 3.0, 1.0, 0.0, 3.0, 6.0, -1.0, -5.0, 5.0)) && allOk;
	allOk = compare_vec4((block[1].s[1].c), vec4(-2.0, 3.0, -8.0, -7.0)) && allOk;
	allOk = compare_ivec3((block[1].s[2].a), ivec3(6, -8, 2)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[0], mat3(-9.0, -1.0, 4.0, 3.0, 2.0, 5.0, -8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[1], mat3(7.0, -9.0, 1.0, -3.0, -2.0, -2.0, -7.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[2], mat3(0.0, 4.0, -2.0, 9.0, -8.0, -1.0, -7.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[3], mat3(-2.0, -1.0, 5.0, -6.0, 5.0, 6.0, 6.0, 0.0, 8.0)) && allOk;
	allOk = compare_vec4((block[1].s[2].c), vec4(0.0, 7.0, 1.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0].a), ivec3(-2, 4, 1)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[0], mat3(-3.0, 4.0, -4.0, 6.0, -3.0, -3.0, 0.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[1], mat3(-6.0, 4.0, -1.0, -9.0, 5.0, -2.0, -9.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[2], mat3(-4.0, 4.0, 5.0, -8.0, -2.0, -9.0, 1.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[3], mat3(1.0, -3.0, 6.0, -1.0, 8.0, -4.0, 0.0, 0.0, -9.0)) && allOk;
	allOk = compare_vec4((block[2].s[0].c), vec4(-7.0, -5.0, 6.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[2].s[1].a), ivec3(-1, -1, -4)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[0], mat3(2.0, 3.0, -6.0, -1.0, -6.0, -9.0, -2.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[1], mat3(1.0, 3.0, -3.0, 8.0, -4.0, -4.0, 7.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[2], mat3(6.0, -8.0, -7.0, -2.0, 8.0, 6.0, 4.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[3], mat3(5.0, -9.0, -8.0, -3.0, -4.0, 9.0, 4.0, 6.0, -6.0)) && allOk;
	allOk = compare_vec4((block[2].s[1].c), vec4(1.0, 0.0, 6.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[2].s[2].a), ivec3(7, -8, -2)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[0], mat3(-5.0, 8.0, 7.0, 1.0, 9.0, -7.0, 1.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[1], mat3(-6.0, -2.0, -6.0, -9.0, -7.0, 8.0, 4.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[2], mat3(-8.0, 6.0, -5.0, 2.0, 8.0, 9.0, -8.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[3], mat3(2.0, 2.0, 4.0, 1.0, 4.0, -5.0, -5.0, -7.0, -7.0)) && allOk;
	allOk = compare_vec4((block[2].s[2].c), vec4(5.0, 7.0, 2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s[0].a = (ivec3(-9, -8, 1));
	block[0].s[0].b[0][0] = (vec3(1.0, -2.0, 7.0));
	block[0].s[0].b[0][1] = (vec3(4.0, 3.0, -4.0));
	block[0].s[0].b[0][2] = (vec3(2.0, 4.0, 9.0));
	block[0].s[0].b[1][0] = (vec3(2.0, -3.0, 1.0));
	block[0].s[0].b[1][1] = (vec3(9.0, 4.0, 9.0));
	block[0].s[0].b[1][2] = (vec3(2.0, -4.0, 4.0));
	block[0].s[0].b[2][0] = (vec3(3.0, -1.0, 4.0));
	block[0].s[0].b[2][1] = (vec3(-3.0, 1.0, 2.0));
	block[0].s[0].b[2][2] = (vec3(2.0, -9.0, -2.0));
	block[0].s[0].b[3][0] = (vec3(-8.0, -7.0, 6.0));
	block[0].s[0].b[3][1] = (vec3(8.0, -1.0, 8.0));
	block[0].s[0].b[3][2] = (vec3(-2.0, -4.0, 0.0));
	block[0].s[0].c = (vec4(2.0, 2.0, 2.0, 4.0));
	block[0].s[1].a = (ivec3(8, -1, 4));
	block[0].s[1].b[0][0] = (vec3(7.0, -3.0, -1.0));
	block[0].s[1].b[0][1] = (vec3(-7.0, -2.0, 5.0));
	block[0].s[1].b[0][2] = (vec3(-1.0, 8.0, 0.0));
	block[0].s[1].b[1][0] = (vec3(1.0, 9.0, -4.0));
	block[0].s[1].b[1][1] = (vec3(3.0, -2.0, -5.0));
	block[0].s[1].b[1][2] = (vec3(6.0, -9.0, -8.0));
	block[0].s[1].b[2][0] = (vec3(4.0, -6.0, -8.0));
	block[0].s[1].b[2][1] = (vec3(-5.0, -2.0, 8.0));
	block[0].s[1].b[2][2] = (vec3(8.0, -2.0, 4.0));
	block[0].s[1].b[3][0] = (vec3(7.0, 2.0, -8.0));
	block[0].s[1].b[3][1] = (vec3(-6.0, -4.0, 0.0));
	block[0].s[1].b[3][2] = (vec3(2.0, 9.0, -8.0));
	block[0].s[1].c = (vec4(2.0, -3.0, -8.0, -4.0));
	block[0].s[2].a = (ivec3(-7, 5, 5));
	block[0].s[2].b[0][0] = (vec3(2.0, 2.0, 1.0));
	block[0].s[2].b[0][1] = (vec3(-4.0, -7.0, -3.0));
	block[0].s[2].b[0][2] = (vec3(1.0, 2.0, 9.0));
	block[0].s[2].b[1][0] = (vec3(1.0, 5.0, 1.0));
	block[0].s[2].b[1][1] = (vec3(-5.0, 8.0, -2.0));
	block[0].s[2].b[1][2] = (vec3(-7.0, 6.0, 2.0));
	block[0].s[2].b[2][0] = (vec3(-8.0, -1.0, -9.0));
	block[0].s[2].b[2][1] = (vec3(-8.0, -2.0, 5.0));
	block[0].s[2].b[2][2] = (vec3(7.0, 3.0, 2.0));
	block[0].s[2].b[3][0] = (vec3(-9.0, -2.0, 0.0));
	block[0].s[2].b[3][1] = (vec3(6.0, 4.0, -3.0));
	block[0].s[2].b[3][2] = (vec3(3.0, -7.0, 0.0));
	block[0].s[2].c = (vec4(4.0, -2.0, -3.0, -9.0));
	block[0].v = (vec4(5.0, -2.0, -5.0, 6.0));
	block[1].s[0].a = (ivec3(-3, -6, -7));
	block[1].s[0].b[0][0] = (vec3(-7.0, -2.0, 7.0));
	block[1].s[0].b[0][1] = (vec3(-3.0, 6.0, -5.0));
	block[1].s[0].b[0][2] = (vec3(-1.0, 7.0, 4.0));
	block[1].s[0].b[1][0] = (vec3(-2.0, 7.0, 6.0));
	block[1].s[0].b[1][1] = (vec3(-3.0, -9.0, 9.0));
	block[1].s[0].b[1][2] = (vec3(-3.0, 8.0, -9.0));
	block[1].s[0].b[2][0] = (vec3(6.0, 8.0, 5.0));
	block[1].s[0].b[2][1] = (vec3(1.0, -8.0, 4.0));
	block[1].s[0].b[2][2] = (vec3(-8.0, -5.0, 5.0));
	block[1].s[0].b[3][0] = (vec3(-2.0, -7.0, 7.0));
	block[1].s[0].b[3][1] = (vec3(4.0, -2.0, -4.0));
	block[1].s[0].b[3][2] = (vec3(4.0, 5.0, -8.0));
	block[1].s[0].c = (vec4(-5.0, 8.0, 9.0, 8.0));
	block[1].s[1].a = (ivec3(3, -4, 8));
	block[1].s[1].b[0][0] = (vec3(5.0, -9.0, -6.0));
	block[1].s[1].b[0][1] = (vec3(-9.0, -5.0, 1.0));
	block[1].s[1].b[0][2] = (vec3(5.0, 2.0, 1.0));
	block[1].s[1].b[1][0] = (vec3(0.0, 6.0, 4.0));
	block[1].s[1].b[1][1] = (vec3(-8.0, -1.0, 6.0));
	block[1].s[1].b[1][2] = (vec3(-5.0, -3.0, -5.0));
	block[1].s[1].b[2][0] = (vec3(1.0, -7.0, 9.0));
	block[1].s[1].b[2][1] = (vec3(-3.0, 0.0, -2.0));
	block[1].s[1].b[2][2] = (vec3(0.0, -1.0, -8.0));
	block[1].s[1].b[3][0] = (vec3(4.0, 2.0, -1.0));
	block[1].s[1].b[3][1] = (vec3(-9.0, 2.0, 3.0));
	block[1].s[1].b[3][2] = (vec3(9.0, -1.0, 0.0));
	block[1].s[1].c = (vec4(-7.0, -1.0, -1.0, -8.0));
	block[1].s[2].a = (ivec3(2, -9, 8));
	block[1].s[2].b[0][0] = (vec3(-7.0, 9.0, -2.0));
	block[1].s[2].b[0][1] = (vec3(0.0, 8.0, -7.0));
	block[1].s[2].b[0][2] = (vec3(-2.0, 6.0, -6.0));
	block[1].s[2].b[1][0] = (vec3(2.0, -9.0, -8.0));
	block[1].s[2].b[1][1] = (vec3(5.0, -2.0, 7.0));
	block[1].s[2].b[1][2] = (vec3(9.0, -3.0, 4.0));
	block[1].s[2].b[2][0] = (vec3(9.0, -1.0, -7.0));
	block[1].s[2].b[2][1] = (vec3(-3.0, 4.0, -8.0));
	block[1].s[2].b[2][2] = (vec3(1.0, -1.0, -9.0));
	block[1].s[2].b[3][0] = (vec3(-9.0, -9.0, -9.0));
	block[1].s[2].b[3][1] = (vec3(4.0, -5.0, -2.0));
	block[1].s[2].b[3][2] = (vec3(2.0, -7.0, -3.0));
	block[1].s[2].c = (vec4(7.0, -6.0, -9.0, -9.0));
	block[1].v = (vec4(2.0, -5.0, -4.0, -2.0));
	block[2].s[0].a = (ivec3(1, 1, 3));
	block[2].s[0].b[0][0] = (vec3(1.0, 6.0, -1.0));
	block[2].s[0].b[0][1] = (vec3(2.0, 7.0, -4.0));
	block[2].s[0].b[0][2] = (vec3(6.0, 3.0, 1.0));
	block[2].s[0].b[1][0] = (vec3(8.0, 9.0, 7.0));
	block[2].s[0].b[1][1] = (vec3(-9.0, 2.0, -8.0));
	block[2].s[0].b[1][2] = (vec3(-1.0, 3.0, -7.0));
	block[2].s[0].b[2][0] = (vec3(3.0, -3.0, -2.0));
	block[2].s[0].b[2][1] = (vec3(9.0, -2.0, 2.0));
	block[2].s[0].b[2][2] = (vec3(9.0, -8.0, -4.0));
	block[2].s[0].b[3][0] = (vec3(-2.0, 4.0, 3.0));
	block[2].s[0].b[3][1] = (vec3(-6.0, 8.0, -2.0));
	block[2].s[0].b[3][2] = (vec3(8.0, 5.0, 2.0));
	block[2].s[0].c = (vec4(-8.0, -4.0, 8.0, 7.0));
	block[2].s[1].a = (ivec3(-7, 1, -3));
	block[2].s[1].b[0][0] = (vec3(-8.0, -5.0, 2.0));
	block[2].s[1].b[0][1] = (vec3(8.0, 6.0, 5.0));
	block[2].s[1].b[0][2] = (vec3(-5.0, 7.0, -6.0));
	block[2].s[1].b[1][0] = (vec3(1.0, -7.0, -6.0));
	block[2].s[1].b[1][1] = (vec3(2.0, 0.0, -1.0));
	block[2].s[1].b[1][2] = (vec3(-9.0, 8.0, -5.0));
	block[2].s[1].b[2][0] = (vec3(3.0, 1.0, -1.0));
	block[2].s[1].b[2][1] = (vec3(3.0, 5.0, -2.0));
	block[2].s[1].b[2][2] = (vec3(1.0, -3.0, -4.0));
	block[2].s[1].b[3][0] = (vec3(0.0, 5.0, 5.0));
	block[2].s[1].b[3][1] = (vec3(1.0, 0.0, -6.0));
	block[2].s[1].b[3][2] = (vec3(9.0, 1.0, -7.0));
	block[2].s[1].c = (vec4(2.0, 9.0, 4.0, -9.0));
	block[2].s[2].a = (ivec3(-8, -7, -5));
	block[2].s[2].b[0][0] = (vec3(5.0, -9.0, 3.0));
	block[2].s[2].b[0][1] = (vec3(4.0, 4.0, 5.0));
	block[2].s[2].b[0][2] = (vec3(-1.0, -2.0, -2.0));
	block[2].s[2].b[1][0] = (vec3(4.0, 2.0, -8.0));
	block[2].s[2].b[1][1] = (vec3(1.0, 0.0, -8.0));
	block[2].s[2].b[1][2] = (vec3(1.0, 6.0, 7.0));
	block[2].s[2].b[2][0] = (vec3(-3.0, -1.0, 1.0));
	block[2].s[2].b[2][1] = (vec3(6.0, -3.0, -7.0));
	block[2].s[2].b[2][2] = (vec3(8.0, 8.0, -9.0));
	block[2].s[2].b[3][0] = (vec3(5.0, -4.0, -1.0));
	block[2].s[2].b[3][1] = (vec3(-4.0, -5.0, -5.0));
	block[2].s[2].b[3][2] = (vec3(-5.0, 9.0, -8.0));
	block[2].s[2].c = (vec4(2.0, -1.0, -1.0, 2.0));
	block[2].v = (vec4(-5.0, 1.0, -9.0, -9.0));
}
#version 450
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
	allOk = compare_uvec2((block[0].s[0].a), uvec2(6u, 4u)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[0], mat2x4(-1.0, 2.0, -8.0, 0.0, 6.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[1], mat2x4(4.0, 9.0, 2.0, -8.0, 4.0, 8.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[2], mat2x4(7.0, -6.0, 1.0, 1.0, -3.0, -2.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[3], mat2x4(-9.0, 9.0, 3.0, -1.0, 4.0, -3.0, -2.0, -9.0)) && allOk;
	allOk = compare_vec3((block[0].s[0].c), vec3(7.0, 5.0, 6.0)) && allOk;
	allOk = compare_uvec2((block[0].s[1].a), uvec2(2u, 7u)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[0], mat2x4(4.0, -4.0, 7.0, -4.0, 7.0, 6.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[1], mat2x4(6.0, -6.0, 0.0, 6.0, -3.0, -1.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[2], mat2x4(1.0, -5.0, -9.0, 3.0, -9.0, 3.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[3], mat2x4(-3.0, -5.0, -3.0, -5.0, 4.0, 0.0, -9.0, -2.0)) && allOk;
	allOk = compare_vec3((block[0].s[1].c), vec3(-8.0, 2.0, -8.0)) && allOk;
	allOk = compare_uvec2((block[0].s[2].a), uvec2(6u, 1u)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[0], mat2x4(-4.0, -2.0, -9.0, -5.0, -6.0, -7.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[1], mat2x4(4.0, 6.0, 4.0, -7.0, -1.0, 8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[2], mat2x4(-4.0, 8.0, 0.0, 8.0, -6.0, 7.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[3], mat2x4(5.0, 9.0, 4.0, 1.0, 3.0, 4.0, -9.0, -8.0)) && allOk;
	allOk = compare_vec3((block[0].s[2].c), vec3(-5.0, 2.0, 5.0)) && allOk;
	allOk = compare_uvec2((block[0].s[3].a), uvec2(4u, 8u)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[0], mat2x4(1.0, -2.0, -6.0, -3.0, -2.0, -2.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[1], mat2x4(-5.0, -7.0, 6.0, -9.0, 0.0, 9.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[2], mat2x4(-7.0, -7.0, 5.0, 5.0, -4.0, -4.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[3], mat2x4(1.0, 8.0, 1.0, 9.0, -6.0, 7.0, 8.0, -5.0)) && allOk;
	allOk = compare_vec3((block[0].s[3].c), vec3(-8.0, -3.0, -9.0)) && allOk;
	allOk = compare_uvec2((block[1].s[0].a), uvec2(2u, 9u)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[0], mat2x4(1.0, -4.0, -3.0, 5.0, -8.0, 0.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[1], mat2x4(-1.0, 9.0, 6.0, 0.0, -4.0, 9.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[2], mat2x4(-1.0, -9.0, 7.0, 8.0, -3.0, -2.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[3], mat2x4(7.0, -6.0, -6.0, 7.0, 2.0, -9.0, -9.0, 2.0)) && allOk;
	allOk = compare_vec3((block[1].s[0].c), vec3(-9.0, 5.0, -2.0)) && allOk;
	allOk = compare_uvec2((block[1].s[1].a), uvec2(2u, 1u)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[0], mat2x4(-7.0, -5.0, 6.0, 8.0, -6.0, -8.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[1], mat2x4(-6.0, -4.0, 8.0, 2.0, 5.0, -7.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[2], mat2x4(0.0, 3.0, 6.0, -1.0, -5.0, 5.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[3], mat2x4(4.0, 3.0, 2.0, 5.0, -8.0, -3.0, -6.0, 7.0)) && allOk;
	allOk = compare_vec3((block[1].s[1].c), vec3(-9.0, 0.0, 1.0)) && allOk;
	allOk = compare_uvec2((block[1].s[2].a), uvec2(2u, 2u)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[0], mat2x4(-9.0, 1.0, -3.0, -2.0, -2.0, -7.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[1], mat2x4(0.0, 4.0, -2.0, 9.0, -8.0, -1.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[2], mat2x4(5.0, -2.0, -1.0, 5.0, -6.0, 5.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[3], mat2x4(0.0, 8.0, 0.0, -1.0, 4.0, -2.0, -2.0, 3.0)) && allOk;
	allOk = compare_vec3((block[1].s[2].c), vec3(-4.0, 4.0, 5.0)) && allOk;
	allOk = compare_uvec2((block[1].s[3].a), uvec2(7u, 3u)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[0], mat2x4(-8.0, -7.0, 0.0, 7.0, 1.0, -6.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[1], mat2x4(9.0, 8.0, 2.0, -2.0, 4.0, 1.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[2], mat2x4(-4.0, 7.0, -8.0, -2.0, -3.0, 4.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[3], mat2x4(-3.0, -3.0, 0.0, 4.0, 0.0, -6.0, 4.0, -1.0)) && allOk;
	allOk = compare_vec3((block[1].s[3].c), vec3(-8.0, -2.0, -9.0)) && allOk;
	allOk = compare_uvec2((block[2].s[0].a), uvec2(6u, 3u)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[0], mat2x4(0.0, 0.0, -9.0, 2.0, 3.0, -6.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[1], mat2x4(-9.0, -2.0, -8.0, -3.0, 1.0, 3.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[2], mat2x4(-4.0, -4.0, 7.0, -5.0, 9.0, 6.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[3], mat2x4(-2.0, 8.0, 6.0, 4.0, 1.0, 7.0, 5.0, -9.0)) && allOk;
	allOk = compare_vec3((block[2].s[0].c), vec3(-8.0, 1.0, 9.0)) && allOk;
	allOk = compare_uvec2((block[2].s[1].a), uvec2(2u, 7u)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[0], mat2x4(-8.0, -3.0, -4.0, 9.0, 4.0, 6.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[1], mat2x4(8.0, 7.0, 1.0, 9.0, -7.0, 1.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[2], mat2x4(-6.0, -2.0, -6.0, -9.0, -7.0, 8.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[3], mat2x4(9.0, -8.0, 6.0, -5.0, 2.0, 8.0, 9.0, -8.0)) && allOk;
	allOk = compare_vec3((block[2].s[1].c), vec3(-5.0, -5.0, -4.0)) && allOk;
	allOk = compare_uvec2((block[2].s[2].a), uvec2(0u, 7u)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[0], mat2x4(-9.0, 0.0, 2.0, 2.0, 4.0, 1.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[1], mat2x4(-5.0, -7.0, -7.0, -7.0, -5.0, 6.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[2], mat2x4(0.0, 6.0, 6.0, 5.0, 7.0, 2.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[3], mat2x4(4.0, 1.0, 8.0, 2.0, -9.0, 8.0, 1.0, -1.0)) && allOk;
	allOk = compare_vec3((block[2].s[2].c), vec3(4.0, 5.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].v = (9u);
	block[0].s[0].a = (uvec2(8u, 7u));
	block[0].s[0].b[0][0] = (vec4(-2.0, 7.0, 4.0, 3.0));
	block[0].s[0].b[0][1] = (vec4(-4.0, 2.0, 4.0, 9.0));
	block[0].s[0].b[1][0] = (vec4(2.0, -3.0, 1.0, 9.0));
	block[0].s[0].b[1][1] = (vec4(4.0, 9.0, 2.0, -4.0));
	block[0].s[0].b[2][0] = (vec4(4.0, 3.0, -1.0, 4.0));
	block[0].s[0].b[2][1] = (vec4(-3.0, 1.0, 2.0, 2.0));
	block[0].s[0].b[3][0] = (vec4(-9.0, -2.0, -8.0, -7.0));
	block[0].s[0].b[3][1] = (vec4(6.0, 8.0, -1.0, 8.0));
	block[0].s[0].c = (vec3(-4.0, 8.0, 2.0));
	block[0].s[1].a = (uvec2(4u, 6u));
	block[0].s[1].b[0][0] = (vec4(-2.0, -4.0, 0.0, 7.0));
	block[0].s[1].b[0][1] = (vec4(-3.0, -1.0, -7.0, -2.0));
	block[0].s[1].b[1][0] = (vec4(5.0, -1.0, 8.0, 0.0));
	block[0].s[1].b[1][1] = (vec4(1.0, 9.0, -4.0, 3.0));
	block[0].s[1].b[2][0] = (vec4(-2.0, -5.0, 6.0, -9.0));
	block[0].s[1].b[2][1] = (vec4(-8.0, 4.0, -6.0, -8.0));
	block[0].s[1].b[3][0] = (vec4(-5.0, -2.0, 8.0, 8.0));
	block[0].s[1].b[3][1] = (vec4(-2.0, 4.0, 7.0, 2.0));
	block[0].s[1].c = (vec3(-9.0, 8.0, -7.0));
	block[0].s[2].a = (uvec2(1u, 6u));
	block[0].s[2].b[0][0] = (vec4(-8.0, -6.0, -4.0, 0.0));
	block[0].s[2].b[0][1] = (vec4(2.0, 9.0, -8.0, 2.0));
	block[0].s[2].b[1][0] = (vec4(2.0, 1.0, -4.0, -7.0));
	block[0].s[2].b[1][1] = (vec4(-3.0, 1.0, 2.0, 9.0));
	block[0].s[2].b[2][0] = (vec4(1.0, 5.0, 1.0, -5.0));
	block[0].s[2].b[2][1] = (vec4(8.0, -2.0, -7.0, 6.0));
	block[0].s[2].b[3][0] = (vec4(2.0, -8.0, -1.0, -9.0));
	block[0].s[2].b[3][1] = (vec4(-8.0, -2.0, 5.0, 7.0));
	block[0].s[2].c = (vec3(-2.0, 7.0, -3.0));
	block[0].s[3].a = (uvec2(4u, 3u));
	block[0].s[3].b[0][0] = (vec4(3.0, 2.0, -9.0, -2.0));
	block[0].s[3].b[0][1] = (vec4(0.0, 6.0, 4.0, -3.0));
	block[0].s[3].b[1][0] = (vec4(3.0, -7.0, 0.0, 2.0));
	block[0].s[3].b[1][1] = (vec4(2.0, 2.0, 4.0, 2.0));
	block[0].s[3].b[2][0] = (vec4(-3.0, -8.0, -4.0, 4.0));
	block[0].s[3].b[2][1] = (vec4(-2.0, -3.0, -9.0, 5.0));
	block[0].s[3].b[3][0] = (vec4(-2.0, -5.0, 6.0, -9.0));
	block[0].s[3].b[3][1] = (vec4(-3.0, -6.0, -7.0, 3.0));
	block[0].s[3].c = (vec3(6.0, -5.0, -1.0));
	block[1].v = (6u);
	block[1].s[0].a = (uvec2(0u, 3u));
	block[1].s[0].b[0][0] = (vec4(6.0, 8.0, 5.0, 1.0));
	block[1].s[0].b[0][1] = (vec4(-8.0, 4.0, -8.0, -5.0));
	block[1].s[0].b[1][0] = (vec4(5.0, -2.0, -7.0, 7.0));
	block[1].s[0].b[1][1] = (vec4(4.0, -2.0, -4.0, 4.0));
	block[1].s[0].b[2][0] = (vec4(5.0, -8.0, 5.0, -9.0));
	block[1].s[0].b[2][1] = (vec4(-6.0, -9.0, -5.0, 1.0));
	block[1].s[0].b[3][0] = (vec4(5.0, 2.0, 1.0, 0.0));
	block[1].s[0].b[3][1] = (vec4(6.0, 4.0, -8.0, -1.0));
	block[1].s[0].c = (vec3(-9.0, 2.0, -8.0));
	block[1].s[1].a = (uvec2(9u, 9u));
	block[1].s[1].b[0][0] = (vec4(6.0, -5.0, -3.0, -5.0));
	block[1].s[1].b[0][1] = (vec4(1.0, -7.0, 9.0, -3.0));
	block[1].s[1].b[1][0] = (vec4(0.0, -2.0, 0.0, -1.0));
	block[1].s[1].b[1][1] = (vec4(-8.0, 4.0, 2.0, -1.0));
	block[1].s[1].b[2][0] = (vec4(-9.0, 2.0, 3.0, 9.0));
	block[1].s[1].b[2][1] = (vec4(-1.0, 0.0, -7.0, 9.0));
	block[1].s[1].b[3][0] = (vec4(-2.0, 0.0, 8.0, -7.0));
	block[1].s[1].b[3][1] = (vec4(-2.0, 6.0, -6.0, 2.0));
	block[1].s[1].c = (vec3(-1.0, 3.0, -7.0));
	block[1].s[2].a = (uvec2(0u, 1u));
	block[1].s[2].b[0][0] = (vec4(-9.0, -8.0, 5.0, -2.0));
	block[1].s[2].b[0][1] = (vec4(7.0, 9.0, -3.0, 4.0));
	block[1].s[2].b[1][0] = (vec4(9.0, -1.0, -7.0, -3.0));
	block[1].s[2].b[1][1] = (vec4(4.0, -8.0, 1.0, -1.0));
	block[1].s[2].b[2][0] = (vec4(-9.0, -9.0, -9.0, -9.0));
	block[1].s[2].b[2][1] = (vec4(4.0, -5.0, -2.0, 2.0));
	block[1].s[2].b[3][0] = (vec4(-7.0, -3.0, -5.0, 8.0));
	block[1].s[2].b[3][1] = (vec4(9.0, 8.0, -7.0, -1.0));
	block[1].s[2].c = (vec3(3.0, -3.0, -2.0));
	block[1].s[3].a = (uvec2(6u, 7u));
	block[1].s[3].b[0][0] = (vec4(-1.0, -8.0, 7.0, -6.0));
	block[1].s[3].b[0][1] = (vec4(-9.0, -9.0, 2.0, -5.0));
	block[1].s[3].b[1][0] = (vec4(-4.0, -2.0, 7.0, 1.0));
	block[1].s[3].b[1][1] = (vec4(1.0, 3.0, -7.0, 1.0));
	block[1].s[3].b[2][0] = (vec4(-3.0, -8.0, -7.0, -5.0));
	block[1].s[3].b[2][1] = (vec4(1.0, 6.0, -1.0, 2.0));
	block[1].s[3].b[3][0] = (vec4(7.0, -4.0, 6.0, 3.0));
	block[1].s[3].b[3][1] = (vec4(1.0, 8.0, 9.0, 7.0));
	block[1].s[3].c = (vec3(9.0, -2.0, 2.0));
	block[2].v = (8u);
	block[2].s[0].a = (uvec2(5u, 8u));
	block[2].s[0].b[0][0] = (vec4(8.0, 5.0, 2.0, -8.0));
	block[2].s[0].b[0][1] = (vec4(-5.0, 2.0, 8.0, 6.0));
	block[2].s[0].b[1][0] = (vec4(5.0, -5.0, 7.0, -6.0));
	block[2].s[0].b[1][1] = (vec4(1.0, -7.0, -6.0, 2.0));
	block[2].s[0].b[2][0] = (vec4(0.0, -1.0, -9.0, 8.0));
	block[2].s[0].b[2][1] = (vec4(-5.0, 3.0, 1.0, -1.0));
	block[2].s[0].b[3][0] = (vec4(3.0, 5.0, -2.0, 1.0));
	block[2].s[0].b[3][1] = (vec4(-3.0, -4.0, 0.0, 5.0));
	block[2].s[0].c = (vec3(0.0, -2.0, 9.0));
	block[2].s[1].a = (uvec2(4u, 7u));
	block[2].s[1].b[0][0] = (vec4(5.0, 1.0, 0.0, -6.0));
	block[2].s[1].b[0][1] = (vec4(9.0, 1.0, -7.0, 5.0));
	block[2].s[1].b[1][0] = (vec4(-9.0, 3.0, 4.0, 4.0));
	block[2].s[1].b[1][1] = (vec4(5.0, -1.0, -2.0, -2.0));
	block[2].s[1].b[2][0] = (vec4(4.0, 2.0, -8.0, 1.0));
	block[2].s[1].b[2][1] = (vec4(0.0, -8.0, 1.0, 6.0));
	block[2].s[1].b[3][0] = (vec4(7.0, -3.0, -1.0, 1.0));
	block[2].s[1].b[3][1] = (vec4(6.0, -3.0, -7.0, 8.0));
	block[2].s[1].c = (vec3(1.0, -1.0, 5.0));
	block[2].s[2].a = (uvec2(7u, 0u));
	block[2].s[2].b[0][0] = (vec4(8.0, -9.0, 5.0, -4.0));
	block[2].s[2].b[0][1] = (vec4(-1.0, -4.0, -5.0, -5.0));
	block[2].s[2].b[1][0] = (vec4(-5.0, 9.0, -8.0, -8.0));
	block[2].s[2].b[1][1] = (vec4(-4.0, 8.0, 7.0, 2.0));
	block[2].s[2].b[2][0] = (vec4(9.0, 4.0, -9.0, 2.0));
	block[2].s[2].b[2][1] = (vec4(-1.0, -1.0, 2.0, -5.0));
	block[2].s[2].b[3][0] = (vec4(1.0, -9.0, -9.0, 2.0));
	block[2].s[2].b[3][1] = (vec4(1.0, -3.0, -7.0, -3.0));
	block[2].s[2].c = (vec3(7.0, 9.0, -2.0));
}
#version 450
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
	allOk = compare_uint((u), 7u) && allOk;
	allOk = compare_mat4x3(t[0].a, mat4x3(0.0, 7.0, 8.0, -1.0, -2.0, -1.0, -6.0, 9.0, -8.0, -3.0, 2.0, 8.0)) && allOk;
	allOk = compare_uvec3((t[0].b[0].a), uvec3(1u, 8u, 8u)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[0]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[1]), vec2(-3.0, 0.0)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[2]), vec2(-5.0, 8.0)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[3]), vec2(3.0, -7.0)) && allOk;
	allOk = compare_vec4((t[0].b[0].c), vec4(-8.0, -4.0, 1.0, -8.0)) && allOk;
	allOk = compare_uvec3((t[0].b[1].a), uvec3(6u, 0u, 1u)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[0]), vec2(5.0, -2.0)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[1]), vec2(0.0, -1.0)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[2]), vec2(-2.0, -6.0)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[3]), vec2(-6.0, 7.0)) && allOk;
	allOk = compare_vec4((t[0].b[1].c), vec4(-8.0, 6.0, -8.0, -1.0)) && allOk;
	allOk = compare_uvec3((t[0].b[2].a), uvec3(4u, 6u, 7u)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[0]), vec2(-2.0, -2.0)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[1]), vec2(-6.0, -4.0)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[2]), vec2(-3.0, -7.0)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[3]), vec2(-1.0, -7.0)) && allOk;
	allOk = compare_vec4((t[0].b[2].c), vec4(6.0, 2.0, 8.0, -3.0)) && allOk;
	allOk = compare_int((t[0].c), 5) && allOk;
	allOk = compare_mat4x3(t[1].a, mat4x3(9.0, -8.0, -7.0, -4.0, 4.0, 0.0, 9.0, 9.0, -8.0, 1.0, 3.0, -5.0)) && allOk;
	allOk = compare_uvec3((t[1].b[0].a), uvec3(1u, 5u, 9u)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[0]), vec2(6.0, 0.0)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[1]), vec2(-7.0, -2.0)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[2]), vec2(-2.0, -6.0)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[3]), vec2(8.0, 1.0)) && allOk;
	allOk = compare_vec4((t[1].b[0].c), vec4(-6.0, -4.0, -5.0, 4.0)) && allOk;
	allOk = compare_uvec3((t[1].b[1].a), uvec3(0u, 4u, 8u)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[0]), vec2(4.0, 5.0)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[1]), vec2(6.0, 4.0)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[2]), vec2(9.0, 9.0)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[3]), vec2(-7.0, 4.0)) && allOk;
	allOk = compare_vec4((t[1].b[1].c), vec4(3.0, 0.0, 7.0, -7.0)) && allOk;
	allOk = compare_uvec3((t[1].b[2].a), uvec3(2u, 1u, 7u)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[0]), vec2(5.0, -2.0)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[1]), vec2(5.0, -9.0)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[2]), vec2(-6.0, -3.0)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[3]), vec2(-7.0, -9.0)) && allOk;
	allOk = compare_vec4((t[1].b[2].c), vec4(-2.0, 6.0, -3.0, -2.0)) && allOk;
	allOk = compare_int((t[1].c), 9) && allOk;
	allOk = compare_mat4x3(t[2].a, mat4x3(3.0, 2.0, -9.0, 7.0, -4.0, -9.0, 1.0, -7.0, 7.0, 2.0, 2.0, -7.0)) && allOk;
	allOk = compare_uvec3((t[2].b[0].a), uvec3(6u, 3u, 3u)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[0]), vec2(-8.0, -3.0)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[1]), vec2(-2.0, 8.0)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[2]), vec2(8.0, -4.0)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[3]), vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec4((t[2].b[0].c), vec4(2.0, 8.0, -8.0, 4.0)) && allOk;
	allOk = compare_uvec3((t[2].b[1].a), uvec3(8u, 8u, 7u)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[0]), vec2(1.0, -3.0)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[1]), vec2(-5.0, 2.0)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[2]), vec2(9.0, 6.0)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[3]), vec2(3.0, 8.0)) && allOk;
	allOk = compare_vec4((t[2].b[1].c), vec4(-5.0, 8.0, 0.0, -8.0)) && allOk;
	allOk = compare_uvec3((t[2].b[2].a), uvec3(4u, 2u, 9u)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[0]), vec2(-5.0, 8.0)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[1]), vec2(-3.0, 6.0)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[2]), vec2(-6.0, 3.0)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[3]), vec2(-8.0, 4.0)) && allOk;
	allOk = compare_vec4((t[2].b[2].c), vec4(-3.0, -3.0, -9.0, 4.0)) && allOk;
	allOk = compare_int((t[2].c), -9) && allOk;
	allOk = compare_mat4x3(t[3].a, mat4x3(-7.0, -6.0, -7.0, -7.0, -3.0, 6.0, -3.0, 5.0, 2.0, -4.0, 7.0, 9.0)) && allOk;
	allOk = compare_uvec3((t[3].b[0].a), uvec3(0u, 0u, 5u)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[0]), vec2(2.0, -2.0)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[1]), vec2(3.0, -9.0)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[2]), vec2(8.0, -1.0)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[3]), vec2(5.0, 4.0)) && allOk;
	allOk = compare_vec4((t[3].b[0].c), vec4(-9.0, 6.0, -7.0, -8.0)) && allOk;
	allOk = compare_uvec3((t[3].b[1].a), uvec3(6u, 0u, 6u)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[0]), vec2(8.0, -5.0)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[1]), vec2(-2.0, 3.0)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[2]), vec2(2.0, 1.0)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[3]), vec2(2.0, -6.0)) && allOk;
	allOk = compare_vec4((t[3].b[1].c), vec4(1.0, 0.0, 0.0, -4.0)) && allOk;
	allOk = compare_uvec3((t[3].b[2].a), uvec3(4u, 6u, 4u)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[0]), vec2(2.0, -1.0)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[1]), vec2(-4.0, 6.0)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[2]), vec2(-8.0, 7.0)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[3]), vec2(-7.0, 5.0)) && allOk;
	allOk = compare_vec4((t[3].b[2].c), vec4(-5.0, 7.0, 7.0, -7.0)) && allOk;
	allOk = compare_int((t[3].c), -7) && allOk;
    if (allOk)
        ac_numPassed++;

	s.a = (uvec3(5u, 0u, 9u));
	s.b[0] = (vec2(-3.0, 0.0));
	s.b[1] = (vec2(2.0, -7.0));
	s.b[2] = (vec2(0.0, -8.0));
	s.b[3] = (vec2(0.0, -4.0));
	s.c = (vec4(-7.0, 9.0, -3.0, 9.0));
	u = (8u);
}
#version 450
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
	allOk = compare_uint((block[0].u), 1u) && allOk;
	allOk = compare_mat4x3(block[0].t[0].a, mat4x3(-7.0, -4.0, -2.0, 5.0, 0.0, 0.0, -6.0, 7.0, 3.0, 1.0, -4.0, 0.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[0].a), uvec3(5u, 6u, 0u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[0]), vec2(6.0, -7.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[1]), vec2(-5.0, 6.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[2]), vec2(6.0, 3.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[3]), vec2(-7.0, 9.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[0].c), vec4(2.0, 1.0, -6.0, 7.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[1].a), uvec3(3u, 1u, 2u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[0]), vec2(1.0, -7.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[1]), vec2(6.0, -7.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[2]), vec2(3.0, 5.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[3]), vec2(-4.0, 1.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[1].c), vec4(-8.0, 1.0, -1.0, 1.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[2].a), uvec3(7u, 2u, 5u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[0]), vec2(8.0, -8.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[1]), vec2(-7.0, 7.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[2]), vec2(-1.0, -7.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[3]), vec2(-9.0, -2.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[2].c), vec4(-1.0, 7.0, 1.0, 0.0)) && allOk;
	allOk = compare_int((block[0].t[0].c), -6) && allOk;
	allOk = compare_mat4x3(block[0].t[1].a, mat4x3(-4.0, -8.0, 7.0, 8.0, 3.0, 9.0, 8.0, 6.0, -9.0, 7.0, 8.0, 9.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[0].a), uvec3(7u, 0u, 4u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[0]), vec2(2.0, 5.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[1]), vec2(9.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[2]), vec2(-4.0, 3.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[3]), vec2(9.0, 3.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[0].c), vec4(0.0, -8.0, 7.0, 0.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[1].a), uvec3(1u, 8u, 0u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[0]), vec2(6.0, 3.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[1]), vec2(9.0, -4.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[2]), vec2(6.0, -8.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[3]), vec2(4.0, -2.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[1].c), vec4(0.0, 9.0, -8.0, 9.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[2].a), uvec3(1u, 6u, 9u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[0]), vec2(-6.0, -7.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[1]), vec2(-1.0, -6.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[2]), vec2(-6.0, 8.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[3]), vec2(2.0, 9.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[2].c), vec4(7.0, 8.0, -7.0, -5.0)) && allOk;
	allOk = compare_int((block[0].t[1].c), -8) && allOk;
	allOk = compare_mat4x3(block[0].t[2].a, mat4x3(-3.0, 5.0, -7.0, 2.0, 8.0, -1.0, 6.0, 0.0, 4.0, 9.0, 0.0, 9.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[0].a), uvec3(8u, 2u, 8u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[0]), vec2(-6.0, 0.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[1]), vec2(6.0, -9.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[2]), vec2(2.0, 5.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[3]), vec2(-5.0, -5.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[0].c), vec4(-7.0, 7.0, -1.0, 1.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[1].a), uvec3(4u, 5u, 7u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[0]), vec2(7.0, -6.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[1]), vec2(1.0, -4.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[2]), vec2(-1.0, 6.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[3]), vec2(0.0, -5.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[1].c), vec4(2.0, -2.0, -7.0, 9.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[2].a), uvec3(8u, 9u, 7u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[0]), vec2(5.0, 4.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[1]), vec2(-1.0, 4.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[2]), vec2(-5.0, 2.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[3]), vec2(-4.0, -9.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[2].c), vec4(2.0, -2.0, 4.0, -1.0)) && allOk;
	allOk = compare_int((block[0].t[2].c), -1) && allOk;
	allOk = compare_mat4x3(block[0].t[3].a, mat4x3(5.0, -1.0, 8.0, 4.0, -3.0, -6.0, 6.0, 0.0, 9.0, -7.0, -8.0, -7.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[0].a), uvec3(7u, 9u, 7u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[0]), vec2(5.0, 2.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[1]), vec2(-2.0, 9.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[2]), vec2(7.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[3]), vec2(-4.0, 5.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[0].c), vec4(-4.0, -2.0, 3.0, 6.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[1].a), uvec3(0u, 0u, 1u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[0]), vec2(4.0, -6.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[1]), vec2(-6.0, 1.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[2]), vec2(7.0, -6.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[3]), vec2(1.0, -5.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[1].c), vec4(-3.0, 5.0, -5.0, -4.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[2].a), uvec3(7u, 2u, 2u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[0]), vec2(5.0, -7.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[1]), vec2(2.0, -7.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[2]), vec2(1.0, 2.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[3]), vec2(-3.0, -3.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[2].c), vec4(0.0, -3.0, 8.0, 2.0)) && allOk;
	allOk = compare_int((block[0].t[3].c), -4) && allOk;
	allOk = compare_uint((block[1].u), 4u) && allOk;
	allOk = compare_mat4x3(block[1].t[0].a, mat4x3(-8.0, 1.0, 3.0, -2.0, -1.0, -4.0, 8.0, -4.0, 8.0, 0.0, -9.0, -6.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[0].a), uvec3(0u, 6u, 8u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[0]), vec2(9.0, -6.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[1]), vec2(2.0, 6.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[2]), vec2(-5.0, 8.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[3]), vec2(9.0, -4.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[0].c), vec4(-5.0, 5.0, 6.0, -9.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[1].a), uvec3(2u, 9u, 5u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[0]), vec2(7.0, 5.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[1]), vec2(0.0, -6.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[2]), vec2(-8.0, 4.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[3]), vec2(-6.0, -9.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[1].c), vec4(-7.0, -3.0, -3.0, 1.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[2].a), uvec3(5u, 8u, 9u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[0]), vec2(7.0, 8.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[1]), vec2(-2.0, -1.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[2]), vec2(0.0, -4.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[3]), vec2(3.0, -5.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[2].c), vec4(9.0, -4.0, 2.0, -6.0)) && allOk;
	allOk = compare_int((block[1].t[0].c), 5) && allOk;
	allOk = compare_uint((block[2].u), 6u) && allOk;
	allOk = compare_mat4x3(block[2].t[0].a, mat4x3(-3.0, 0.0, 3.0, -6.0, 1.0, 2.0, -2.0, -5.0, 9.0, 7.0, -6.0, -3.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[0].a), uvec3(7u, 2u, 3u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[0]), vec2(7.0, 0.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[1]), vec2(3.0, 8.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[2]), vec2(-5.0, 9.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[3]), vec2(-5.0, -5.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[0].c), vec4(1.0, 7.0, 1.0, 5.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[1].a), uvec3(0u, 8u, 9u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[0]), vec2(-9.0, 9.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[1]), vec2(1.0, -8.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[2]), vec2(5.0, 4.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[3]), vec2(-8.0, 3.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[1].c), vec4(-6.0, -2.0, 6.0, 7.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[2].a), uvec3(4u, 6u, 2u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[0]), vec2(2.0, 7.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[1]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[2]), vec2(-4.0, -8.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[3]), vec2(8.0, 0.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[2].c), vec4(7.0, 6.0, -6.0, 7.0)) && allOk;
	allOk = compare_int((block[2].t[0].c), 2) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (uvec3(8u, 5u, 2u));
	block[0].s.b[0] = (vec2(4.0, 8.0));
	block[0].s.b[1] = (vec2(-9.0, -3.0));
	block[0].s.b[2] = (vec2(-2.0, -7.0));
	block[0].s.b[3] = (vec2(1.0, -3.0));
	block[0].s.c = (vec4(-8.0, 9.0, 5.0, 0.0));
	block[0].u = (7u);
	block[1].s.a = (uvec3(5u, 5u, 7u));
	block[1].s.b[0] = (vec2(-9.0, -4.0));
	block[1].s.b[1] = (vec2(-6.0, 2.0));
	block[1].s.b[2] = (vec2(3.0, -4.0));
	block[1].s.b[3] = (vec2(6.0, 4.0));
	block[1].s.c = (vec4(-4.0, -9.0, -2.0, 3.0));
	block[1].u = (9u);
	block[2].s.a = (uvec3(1u, 2u, 7u));
	block[2].s.b[0] = (vec2(-1.0, -6.0));
	block[2].s.b[1] = (vec2(7.0, 3.0));
	block[2].s.b[2] = (vec2(3.0, -5.0));
	block[2].s.b[3] = (vec2(5.0, 2.0));
	block[2].s.c = (vec4(4.0, 1.0, 5.0, -5.0));
	block[2].u = (2u);
}
#version 450
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
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), -8.0) && allOk;
	allOk = compare_mat3x2(block[0].var, mat3x2(-5.0, -1.0, 5.0, 3.0, 2.0, 7.0)) && allOk;
	allOk = compare_float((block[1].padding), -5.0) && allOk;
	allOk = compare_mat3x2(block[1].var, mat3x2(-1.0, -7.0, 3.0, -8.0, 3.0, 7.0)) && allOk;
	allOk = compare_float((block[2].padding), 0.0) && allOk;
	allOk = compare_mat3x2(block[2].var, mat3x2(5.0, 0.0, -5.0, 5.0, -5.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-4.0);
	block[0].var[0] = (vec2(-6.0, 1.0));
	block[0].var[1] = (vec2(-3.0, -1.0));
	block[0].var[2] = (vec2(-9.0, 3.0));
	block[1].padding = (-2.0);
	block[1].var[0] = (vec2(5.0, -8.0));
	block[1].var[1] = (vec2(2.0, -9.0));
	block[1].var[2] = (vec2(1.0, -5.0));
	block[2].padding = (0.0);
	block[2].var[0] = (vec2(-2.0, 2.0));
	block[2].var[1] = (vec2(-1.0, -7.0));
	block[2].var[2] = (vec2(9.0, -8.0));
}
#version 450
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
	i16vec4 var;
} block[3];

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(block[0].padding), -6) && allOk;
	allOk = compare_i16vec4(ivec4(block[0].var), ivec4(-9, 9, 8, -1)) && allOk;
	allOk = compare_int16_t(int(block[1].padding), -8) && allOk;
	allOk = compare_i16vec4(ivec4(block[1].var), ivec4(8, 9, 3, 4)) && allOk;
	allOk = compare_int16_t(int(block[2].padding), 0) && allOk;
	allOk = compare_i16vec4(ivec4(block[2].var), ivec4(9, -2, -4, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = int16_t(-4);
	block[0].var = i16vec4(ivec4(-8, -4, 9, 2));
	block[1].padding = int16_t(7);
	block[1].var = i16vec4(ivec4(-4, 4, 8, 9));
	block[2].padding = int16_t(5);
	block[2].var = i16vec4(ivec4(1, -3, 3, 8));
}
#version 450
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
} blockA[3];
layout(std140, binding = 2) buffer BlockB
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
	allOk = compare_float((blockA[0].a), -6.0) && allOk;
	allOk = compare_float((blockA[1].a), 2.0) && allOk;
	allOk = compare_float((blockA[2].a), 4.0) && allOk;
	allOk = compare_uint((blockB[0].b.a), 6u) && allOk;
	allOk = compare_mat3(blockB[0].b.b.a, mat3(-7.0, 2.0, -8.0, 3.0, 7.0, 3.0, 9.0, 6.0, -6.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[0]), ivec2(2, -4)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[1]), ivec2(7, -6)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[2]), ivec2(-7, 2)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[3]), ivec2(-5, -8)) && allOk;
	allOk = compare_vec4((blockB[0].b.b.c), vec4(-3.0, 5.0, -9.0, 1.0)) && allOk;
	allOk = compare_bvec4((blockB[0].b.c), bvec4(false, false, false, true)) && allOk;
	allOk = compare_bool((blockB[0].d), true) && allOk;
	allOk = compare_uint((blockB[1].b.a), 8u) && allOk;
	allOk = compare_mat3(blockB[1].b.b.a, mat3(-8.0, 8.0, -5.0, -6.0, -4.0, -7.0, -4.0, 9.0, 7.0)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[0]), ivec2(1, -4)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[1]), ivec2(-3, -2)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[2]), ivec2(2, 1)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[3]), ivec2(2, 8)) && allOk;
	allOk = compare_vec4((blockB[1].b.b.c), vec4(-2.0, 4.0, 2.0, 3.0)) && allOk;
	allOk = compare_bvec4((blockB[1].b.c), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bool((blockB[1].d), false) && allOk;
	allOk = compare_uint((blockB[2].b.a), 0u) && allOk;
	allOk = compare_mat3(blockB[2].b.b.a, mat3(-5.0, 3.0, 6.0, 3.0, 9.0, 0.0, 1.0, 1.0, 3.0)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[0]), ivec2(-1, 6)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[1]), ivec2(1, 5)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[2]), ivec2(1, 0)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[3]), ivec2(4, -8)) && allOk;
	allOk = compare_vec4((blockB[2].b.b.c), vec4(4.0, -8.0, -2.0, -3.0)) && allOk;
	allOk = compare_bvec4((blockB[2].b.c), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bool((blockB[2].d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (-2.0);
	blockA[0].b.a = (mat3(-2.0, 5.0, 6.0, -1.0, -7.0, 3.0, 2.0, -9.0, -5.0));
	blockA[0].b.b[0] = (ivec2(6, -7));
	blockA[0].b.b[1] = (ivec2(7, 4));
	blockA[0].b.b[2] = (ivec2(-9, -4));
	blockA[0].b.b[3] = (ivec2(2, -4));
	blockA[0].b.c = (vec4(-6.0, -7.0, -6.0, -8.0));
	blockA[1].a = (3.0);
	blockA[1].b.a = (mat3(1.0, 8.0, -4.0, 1.0, -2.0, -2.0, 0.0, -3.0, -5.0));
	blockA[1].b.b[0] = (ivec2(-6, 4));
	blockA[1].b.b[1] = (ivec2(4, 0));
	blockA[1].b.b[2] = (ivec2(6, -4));
	blockA[1].b.b[3] = (ivec2(-1, -2));
	blockA[1].b.c = (vec4(3.0, 0.0, -5.0, -5.0));
	blockA[2].a = (1.0);
	blockA[2].b.a = (mat3(-5.0, 1.0, -5.0, 6.0, -3.0, 0.0, 6.0, -2.0, -6.0));
	blockA[2].b.b[0] = (ivec2(-5, -6));
	blockA[2].b.b[1] = (ivec2(-1, 6));
	blockA[2].b.b[2] = (ivec2(8, -7));
	blockA[2].b.b[3] = (ivec2(-9, 0));
	blockA[2].b.c = (vec4(2.0, 1.0, 9.0, -3.0));
	blockB[0].a = (mat2(3.0, 0.0, 7.0, 6.0));
	blockB[0].b.a = (6u);
	blockB[0].b.b.a = (mat3(7.0, -4.0, -5.0, -9.0, -2.0, 1.0, 3.0, -3.0, -3.0));
	blockB[0].b.b.b[0] = (ivec2(1, -4));
	blockB[0].b.b.b[1] = (ivec2(0, 5));
	blockB[0].b.b.b[2] = (ivec2(-9, 1));
	blockB[0].b.b.b[3] = (ivec2(-4, -7));
	blockB[0].b.b.c = (vec4(6.0, 7.0, 0.0, -8.0));
	blockB[0].b.c = (bvec4(false, true, true, false));
	blockB[0].d = (false);
	blockB[1].a = (mat2(4.0, 0.0, 3.0, -2.0));
	blockB[1].b.a = (2u);
	blockB[1].b.b.a = (mat3(-7.0, -1.0, 9.0, -8.0, -2.0, -8.0, -6.0, 7.0, 4.0));
	blockB[1].b.b.b[0] = (ivec2(4, 9));
	blockB[1].b.b.b[1] = (ivec2(-3, 1));
	blockB[1].b.b.b[2] = (ivec2(9, -9));
	blockB[1].b.b.b[3] = (ivec2(-4, -9));
	blockB[1].b.b.c = (vec4(-5.0, 1.0, 4.0, -6.0));
	blockB[1].b.c = (bvec4(true, true, false, true));
	blockB[1].d = (true);
	blockB[2].a = (mat2(-9.0, 1.0, -4.0, -8.0));
	blockB[2].b.a = (4u);
	blockB[2].b.b.a = (mat3(7.0, 1.0, 5.0, 4.0, -2.0, -9.0, 2.0, -6.0, -2.0));
	blockB[2].b.b.b[0] = (ivec2(-8, 0));
	blockB[2].b.b.b[1] = (ivec2(-1, -4));
	blockB[2].b.b.b[2] = (ivec2(-9, 3));
	blockB[2].b.b.b[3] = (ivec2(7, -8));
	blockB[2].b.b.c = (vec4(-9.0, -1.0, -3.0, 5.0));
	blockB[2].b.c = (bvec4(true, true, true, true));
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
layout(scalar, binding = 1) buffer BlockA
{
	highp float a;
	S b;
	lowp uvec3 c;
} blockA[3];
layout(scalar, binding = 2) buffer BlockB
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
	allOk = compare_float((blockA[0].a), 1.0) && allOk;
	allOk = compare_float((blockA[1].a), 9.0) && allOk;
	allOk = compare_float((blockA[2].a), -1.0) && allOk;
	allOk = compare_uint((blockB[0].b.a), 0u) && allOk;
	allOk = compare_mat3(blockB[0].b.b.a, mat3(2.0, 6.0, 1.0, 6.0, -9.0, 3.0, 7.0, -4.0, 1.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[0]), ivec2(1, -4)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[1]), ivec2(0, -4)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[2]), ivec2(-7, -8)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[3]), ivec2(-8, 6)) && allOk;
	allOk = compare_vec4((blockB[0].b.b.c), vec4(7.0, 2.0, -8.0, -7.0)) && allOk;
	allOk = compare_bvec4((blockB[0].b.c), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bool((blockB[0].d), false) && allOk;
	allOk = compare_uint((blockB[1].b.a), 1u) && allOk;
	allOk = compare_mat3(blockB[1].b.b.a, mat3(-6.0, 7.0, 1.0, 0.0, 6.0, -2.0, -2.0, -3.0, 4.0)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[0]), ivec2(3, 6)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[1]), ivec2(1, -7)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[2]), ivec2(-5, 6)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[3]), ivec2(1, 1)) && allOk;
	allOk = compare_vec4((blockB[1].b.b.c), vec4(-1.0, -5.0, -4.0, 0.0)) && allOk;
	allOk = compare_bvec4((blockB[1].b.c), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bool((blockB[1].d), false) && allOk;
	allOk = compare_uint((blockB[2].b.a), 2u) && allOk;
	allOk = compare_mat3(blockB[2].b.b.a, mat3(6.0, 5.0, -3.0, 1.0, -4.0, 4.0, -1.0, 9.0, 4.0)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[0]), ivec2(-6, -2)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[1]), ivec2(2, 6)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[2]), ivec2(2, -3)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[3]), ivec2(2, -4)) && allOk;
	allOk = compare_vec4((blockB[2].b.b.c), vec4(-9.0, 5.0, -6.0, 4.0)) && allOk;
	allOk = compare_bvec4((blockB[2].b.c), bvec4(false, true, false, false)) && allOk;
	allOk = compare_bool((blockB[2].d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (-3.0);
	blockA[0].b.a[0] = (vec3(1.0, 0.0, -9.0));
	blockA[0].b.a[1] = (vec3(-4.0, -7.0, 3.0));
	blockA[0].b.a[2] = (vec3(-8.0, 0.0, -3.0));
	blockA[0].b.b[0] = (ivec2(-8, 9));
	blockA[0].b.b[1] = (ivec2(4, -7));
	blockA[0].b.b[2] = (ivec2(-4, -4));
	blockA[0].b.b[3] = (ivec2(-1, 1));
	blockA[0].b.c = (vec4(6.0, 1.0, -8.0, -5.0));
	blockA[1].a = (5.0);
	blockA[1].b.a[0] = (vec3(6.0, 9.0, -6.0));
	blockA[1].b.a[1] = (vec3(-4.0, 0.0, -8.0));
	blockA[1].b.a[2] = (vec3(5.0, 8.0, 9.0));
	blockA[1].b.b[0] = (ivec2(-4, -7));
	blockA[1].b.b[1] = (ivec2(-8, -5));
	blockA[1].b.b[2] = (ivec2(-4, -9));
	blockA[1].b.b[3] = (ivec2(8, -1));
	blockA[1].b.c = (vec4(-6.0, 9.0, 2.0, -1.0));
	blockA[2].a = (-8.0);
	blockA[2].b.a[0] = (vec3(-3.0, -6.0, -8.0));
	blockA[2].b.a[1] = (vec3(5.0, 5.0, 5.0));
	blockA[2].b.a[2] = (vec3(0.0, 9.0, -9.0));
	blockA[2].b.b[0] = (ivec2(-5, 7));
	blockA[2].b.b[1] = (ivec2(-7, 8));
	blockA[2].b.b[2] = (ivec2(0, -1));
	blockA[2].b.b[3] = (ivec2(3, 9));
	blockA[2].b.c = (vec4(1.0, 1.0, -8.0, 7.0));
	blockB[0].a[0] = (vec2(7.0, 5.0));
	blockB[0].a[1] = (vec2(6.0, 4.0));
	blockB[0].b.a = (6u);
	blockB[0].b.b.a[0] = (vec3(-1.0, -2.0, -7.0));
	blockB[0].b.b.a[1] = (vec3(-8.0, 7.0, -9.0));
	blockB[0].b.b.a[2] = (vec3(4.0, 6.0, 3.0));
	blockB[0].b.b.b[0] = (ivec2(7, -6));
	blockB[0].b.b.b[1] = (ivec2(1, -5));
	blockB[0].b.b.b[2] = (ivec2(-4, 0));
	blockB[0].b.b.b[3] = (ivec2(-6, 9));
	blockB[0].b.b.c = (vec4(1.0, 7.0, 6.0, 8.0));
	blockB[0].b.c = (bvec4(true, true, false, false));
	blockB[0].d = (false);
	blockB[1].a[0] = (vec2(0.0, -4.0));
	blockB[1].a[1] = (vec2(2.0, -7.0));
	blockB[1].b.a = (2u);
	blockB[1].b.b.a[0] = (vec3(2.0, -2.0, 7.0));
	blockB[1].b.b.a[1] = (vec3(-7.0, 7.0, 3.0));
	blockB[1].b.b.a[2] = (vec3(-8.0, -8.0, 2.0));
	blockB[1].b.b.b[0] = (ivec2(2, 0));
	blockB[1].b.b.b[1] = (ivec2(-4, -7));
	blockB[1].b.b.b[2] = (ivec2(6, 5));
	blockB[1].b.b.b[3] = (ivec2(2, -9));
	blockB[1].b.b.c = (vec4(5.0, -5.0, 0.0, -3.0));
	blockB[1].b.c = (bvec4(false, false, true, false));
	blockB[1].d = (false);
	blockB[2].a[0] = (vec2(-9.0, 9.0));
	blockB[2].a[1] = (vec2(-2.0, 1.0));
	blockB[2].b.a = (7u);
	blockB[2].b.b.a[0] = (vec3(0.0, 7.0, -2.0));
	blockB[2].b.b.a[1] = (vec3(-7.0, -7.0, 5.0));
	blockB[2].b.b.a[2] = (vec3(-3.0, -2.0, -6.0));
	blockB[2].b.b.b[0] = (ivec2(3, -8));
	blockB[2].b.b.b[1] = (ivec2(4, 2));
	blockB[2].b.b.b[2] = (ivec2(-9, 3));
	blockB[2].b.b.b[3] = (ivec2(2, -2));
	blockB[2].b.b.c = (vec4(9.0, -8.0, -5.0, -8.0));
	blockB[2].b.c = (bvec4(true, true, false, false));
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

layout(std140, binding = 1) buffer BlockB
{
	mediump int a;
	mediump int b;
	highp int c;
	lowp uint d;
};
layout(std140, binding = 2) readonly buffer BlockC
{
	mediump uint e;
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	highp float f[1];
	lowp int g;
	highp int h;
	highp float i;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((c), 8) && allOk;
	allOk = compare_uint((d), 4u) && allOk;
	allOk = compare_float((blockD.i), -6.0) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (-3);
	blockD.f[0] = (6.0);
	blockD.g = (-6);
	blockD.i = (-7.0);
}
#version 450
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
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	lowp ivec3 b;
	mediump mat3x2 c;
	bool d;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((a), bvec4(true, false, false, false)) && allOk;
	allOk = compare_ivec3((blockC.b), ivec3(5, -6, 1)) && allOk;
	allOk = compare_bool((blockC.d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec4(true, true, false, false));
	blockC.c = (mat3x2(-4.0, -2.0, -6.0, 5.0, 3.0, -2.0));
}
#version 450
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
	lowp uint c;
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	lowp uvec3 d;
} blockC;
layout(std140, column_major, binding = 3) buffer BlockD
{
	lowp vec3 e;
	highp uint f;
	mediump vec3 g;
};
layout(std430, column_major, binding = 4) buffer BlockE
{
	highp uvec2 h;
	highp uint i;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((c), 7u) && allOk;
	allOk = compare_uvec3((blockC.d), uvec3(4u, 7u, 2u)) && allOk;
	allOk = compare_vec3((e), vec3(3.0, -3.0, 2.0)) && allOk;
	allOk = compare_uint((f), 3u) && allOk;
	allOk = compare_vec3((g), vec3(8.0, 8.0, -3.0)) && allOk;
	allOk = compare_uvec2((blockE.h), uvec2(6u, 4u)) && allOk;
	allOk = compare_uint((blockE.i), 8u) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (false);
	c = (5u);
	blockC.d = (uvec3(3u, 5u, 1u));
	f = (4u);
	g = (vec3(-9.0, -9.0, -7.0));
	blockE.h = (uvec2(2u, 7u));
}
#version 450
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
	highp vec3 b;
	lowp ivec4 c;
	lowp uint d;
	lowp mat4x2 e;
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	highp mat3 f[7];
	mediump vec2 g;
	highp mat4 h;
	highp mat2x3 i;
	highp float j;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(a, mat3x2(-4.0, -7.0, 6.0, -9.0, 6.0, 5.0)) && allOk;
	allOk = compare_ivec4((c), ivec4(6, -2, -6, 4)) && allOk;
	allOk = compare_mat4x2(e, mat4x2(-3.0, -5.0, 2.0, -7.0, -9.0, 3.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat4(blockC.h, mat4(9.0, 4.0, 7.0, -1.0, -6.0, 2.0, 0.0, -9.0, 8.0, 3.0, -7.0, -1.0, 0.0, -2.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2x3(blockC.i, mat2x3(1.0, -3.0, -4.0, 0.0, -9.0, -3.0)) && allOk;
	allOk = compare_float((blockC.j), 9.0) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat3x2(9.0, -9.0, -7.0, -8.0, -5.0, 0.0));
	blockC.f[0] = (mat3(4.0, -6.0, 5.0, -4.0, 9.0, 1.0, 4.0, -5.0, 8.0));
	blockC.f[1] = (mat3(-5.0, 4.0, -9.0, -1.0, -6.0, 9.0, -8.0, -4.0, -9.0));
	blockC.f[2] = (mat3(9.0, -2.0, 3.0, 1.0, -6.0, -2.0, 5.0, -3.0, 4.0));
	blockC.f[3] = (mat3(7.0, -1.0, -2.0, 2.0, -2.0, 1.0, 0.0, 2.0, -9.0));
	blockC.f[4] = (mat3(0.0, 7.0, -3.0, -5.0, 8.0, 2.0, 2.0, -2.0, -1.0));
	blockC.f[5] = (mat3(4.0, -3.0, -1.0, -2.0, 2.0, -3.0, -1.0, -6.0, -4.0));
	blockC.f[6] = (mat3(3.0, -8.0, 6.0, 7.0, -3.0, -2.0, -3.0, 0.0, 7.0));
	blockC.h = (mat4(-9.0, 0.0, 3.0, -4.0, -5.0, 0.0, 2.0, -2.0, -7.0, -2.0, -2.0, -8.0, 1.0, 1.0, -6.0, -1.0));
	blockC.i = (mat2x3(-1.0, 5.0, -2.0, 8.0, -2.0, -6.0));
	blockC.j = (-6.0);
}
#version 450
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
	lowp ivec3 a;
	mediump vec3 b;
	mediump mat4x2 c[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((a), ivec3(4, -1, 1)) && allOk;
	allOk = compare_vec3((b), vec3(6.0, 1.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (vec3(-6.0, 1.0, -2.0));
}
#version 450
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
	bvec3 a[];
} blockB[2];

bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

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

layout(std140, row_major, binding = 1) readonly buffer BlockB
{
	mediump mat4x3 a[];
} blockB;
layout(std140, row_major, binding = 2) buffer BlockC
{
	highp mat4x3 b[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	b[0] = (mat4x3(-4.0, 1.0, 9.0, 3.0, 2.0, 2.0, 4.0, -6.0, -1.0, 9.0, 5.0, -7.0));
}
#version 450
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
	mediump uvec3 a;
	lowp vec3 b[];
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	lowp int c;
	highp mat4x3 d;
	mediump mat2x3 e;
	lowp ivec2 f[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.b[0]), vec3(-7.0, -4.0, -4.0)) && allOk;
	allOk = compare_int((blockC.c), -6) && allOk;
	allOk = compare_mat4x3(blockC.d, mat4x3(-2.0, 8.0, 4.0, -4.0, -9.0, -9.0, -7.0, 9.0, -3.0, -8.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(blockC.e, mat2x3(-1.0, -3.0, 0.0, -1.0, -7.0, -7.0)) && allOk;
	allOk = compare_ivec2((blockC.f[0]), ivec2(6, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec3(9u, 2u, 1u));
	blockC.d = (mat4x3(-4.0, -6.0, -5.0, -2.0, 4.0, -2.0, 5.0, -9.0, -3.0, -1.0, -9.0, 1.0));
	blockC.e = (mat2x3(1.0, 7.0, 8.0, 9.0, -7.0, -1.0));
	blockC.f[0] = (ivec2(-6, 5));
}
#version 450
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
	lowp mat3 mA[5];
	lowp float mB;
	lowp ivec4 mC;
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	bvec3 a;
	sA b;
	bool c;
	bvec2 d;
	bvec3 e[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((a), bvec3(true, false, false)) && allOk;
	allOk = compare_mat3(b.mA[0], mat3(1.0, 9.0, -6.0, -4.0, 2.0, -9.0, 6.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3(b.mA[1], mat3(-6.0, -5.0, -8.0, 7.0, -7.0, -1.0, -1.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3(b.mA[2], mat3(4.0, 6.0, -4.0, -1.0, 8.0, 3.0, 9.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat3(b.mA[3], mat3(7.0, -5.0, -9.0, 7.0, 3.0, -6.0, -5.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3(b.mA[4], mat3(-5.0, 8.0, -3.0, 6.0, -1.0, -3.0, -6.0, 7.0, 6.0)) && allOk;
	allOk = compare_float((b.mB), -7.0) && allOk;
	allOk = compare_ivec4((b.mC), ivec4(2, -2, 3, 3)) && allOk;
	allOk = compare_bool((c), false) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec3(true, true, false));
	b.mA[0] = (mat3(-2.0, -1.0, -3.0, -9.0, -9.0, -2.0, -4.0, -4.0, 3.0));
	b.mA[1] = (mat3(4.0, 9.0, 1.0, 2.0, -6.0, 5.0, 9.0, 2.0, -1.0));
	b.mA[2] = (mat3(-7.0, 3.0, -7.0, -5.0, 7.0, 5.0, 5.0, 7.0, -3.0));
	b.mA[3] = (mat3(2.0, -2.0, 9.0, 5.0, 7.0, -5.0, 9.0, -3.0, 8.0));
	b.mA[4] = (mat3(-3.0, 7.0, -4.0, -9.0, -2.0, 9.0, 7.0, 8.0, -1.0));
	b.mB = (5.0);
	b.mC = (ivec4(-4, 9, -2, -5));
	c = (false);
}
#version 450
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
	bool mA;
	sA mB;
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	bvec2 a;
	highp uvec2 b;
	mediump vec2 c;
	highp mat2 d[];
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	mediump mat3x2 e;
	highp mat2x3 f;
} blockC;
layout(std140, column_major, binding = 3) buffer BlockD
{
	highp mat3 g;
	highp uvec3 h;
	sB i[7];
} blockD[2];
layout(std140, row_major, binding = 4) buffer BlockE
{
	highp float j;
	highp ivec2 k[2];
	highp uint l[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a), bvec2(true, false)) && allOk;
	allOk = compare_uvec2((blockB.b), uvec2(5u, 3u)) && allOk;
	allOk = compare_vec2((blockB.c), vec2(5.0, -4.0)) && allOk;
	allOk = compare_mat3x2(blockC.e, mat3x2(2.0, -5.0, -9.0, -7.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat2x3(blockC.f, mat2x3(5.0, -9.0, -5.0, 2.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3(blockD[0].g, mat3(1.0, -8.0, 0.0, 3.0, -5.0, 5.0, -7.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3(blockD[1].g, mat3(7.0, -1.0, -6.0, 2.0, 0.0, -9.0, 8.0, 3.0, -7.0)) && allOk;
	allOk = compare_ivec2((k[0]), ivec2(-9, 3)) && allOk;
	allOk = compare_ivec2((k[1]), ivec2(-9, 7)) && allOk;
	allOk = compare_uint((l[0]), 8u) && allOk;
	allOk = compare_uint((l[1]), 4u) && allOk;
	allOk = compare_uint((l[2]), 7u) && allOk;
	allOk = compare_uint((l[3]), 2u) && allOk;
	allOk = compare_uint((l[4]), 2u) && allOk;
	allOk = compare_uint((l[5]), 3u) && allOk;
	allOk = compare_uint((l[6]), 5u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, false));
	blockB.d[0] = (mat2(0.0, 8.0, 7.0, 1.0));
	blockB.d[1] = (mat2(2.0, -5.0, 9.0, -6.0));
	blockC.e = (mat3x2(-3.0, 0.0, 9.0, 4.0, 4.0, 5.0));
	blockC.f = (mat2x3(-2.0, -6.0, -4.0, 4.0, 5.0, 9.0));
	blockD[0].g = (mat3(1.0, 4.0, -5.0, 8.0, -5.0, 4.0, -9.0, -1.0, -6.0));
	blockD[0].i[0].mA = (true);
	blockD[0].i[0].mB.mA = (bvec4(false, true, true, true));
	blockD[0].i[1].mA = (true);
	blockD[0].i[1].mB.mA = (bvec4(true, true, false, false));
	blockD[0].i[2].mA = (true);
	blockD[0].i[2].mB.mA = (bvec4(false, false, true, true));
	blockD[0].i[3].mA = (true);
	blockD[0].i[3].mB.mA = (bvec4(true, false, false, false));
	blockD[0].i[4].mA = (true);
	blockD[0].i[4].mB.mA = (bvec4(true, true, true, false));
	blockD[0].i[5].mA = (true);
	blockD[0].i[5].mB.mA = (bvec4(false, true, false, true));
	blockD[0].i[6].mA = (false);
	blockD[0].i[6].mB.mA = (bvec4(false, true, false, true));
	blockD[1].g = (mat3(-7.0, -2.0, -2.0, -8.0, 1.0, 1.0, -6.0, -1.0, -1.0));
	blockD[1].i[0].mA = (true);
	blockD[1].i[0].mB.mA = (bvec4(true, true, false, true));
	blockD[1].i[1].mA = (false);
	blockD[1].i[1].mB.mA = (bvec4(false, true, false, false));
	blockD[1].i[2].mA = (true);
	blockD[1].i[2].mB.mA = (bvec4(false, false, true, true));
	blockD[1].i[3].mA = (false);
	blockD[1].i[3].mB.mA = (bvec4(true, true, false, true));
	blockD[1].i[4].mA = (false);
	blockD[1].i[4].mB.mA = (bvec4(true, false, false, true));
	blockD[1].i[5].mA = (false);
	blockD[1].i[5].mB.mA = (bvec4(true, true, true, false));
	blockD[1].i[6].mA = (true);
	blockD[1].i[6].mB.mA = (bvec4(true, true, false, true));
	j = (-6.0);
	k[0] = (ivec2(-8, 7));
	k[1] = (ivec2(5, 9));
	l[0] = (8u);
	l[1] = (6u);
	l[2] = (6u);
	l[3] = (8u);
	l[4] = (9u);
	l[5] = (9u);
	l[6] = (7u);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, row_major, binding = 1) readonly buffer BlockB
{
	mediump mat2x3 a[];
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	bvec4 b;
	mediump mat4x3 c;
	mediump mat2 d[];
} blockC;
layout(std140, column_major, binding = 3) readonly buffer BlockD
{
	highp vec2 e;
	lowp mat3x4 f;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB.a[0], mat2x3(-7.0, 8.0, 4.0, 8.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[1], mat2x3(-2.0, -1.0, -9.0, 6.0, 5.0, 9.0)) && allOk;
	allOk = compare_bvec4((blockC.b), bvec4(true, true, false, false)) && allOk;
	allOk = compare_mat4x3(blockC.c, mat4x3(-9.0, 7.0, 0.0, -2.0, -5.0, 2.0, 4.0, -7.0, -2.0, 9.0, 8.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (bvec4(false, true, true, false));
	blockC.c = (mat4x3(-1.0, -2.0, 2.0, -3.0, -9.0, -5.0, 3.0, 5.0, -5.0, -2.0, -2.0, 8.0));
}
#version 450
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
	lowp int mB;
	lowp uvec4 mC[5][5][1];
	mediump mat2 mD[5];
};
struct sB
{
	highp mat4x3 mA;
	lowp uvec4 mB;
};
struct sC
{
	highp mat3x4 mA;
};
struct sD
{
	lowp vec4 mA;
	highp uint mB;
	bvec3 mC;
	bvec3 mD;
};
layout(scalar, binding = 1) buffer BlockB
{
	sA a;
	sB b;
	sC c;
	highp int d;
} blockB;
layout(scalar, column_major, binding = 2) buffer BlockC
{
	highp vec4 e;
	lowp mat4x3 f;
	highp ivec2 g;
	lowp vec4 h;
	sD i;
} blockC;

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
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.b.mA, mat4x3(1.0, 9.0, 4.0, 1.0, 6.0, 1.0, 6.0, -8.0, 5.0, -6.0, 2.0, -9.0)) && allOk;
	allOk = compare_uvec4((blockB.b.mB), uvec4(5u, 4u, 5u, 5u)) && allOk;
	allOk = compare_int((blockB.d), 0) && allOk;
	allOk = compare_vec4((blockC.e), vec4(-6.0, -4.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat4x3(blockC.f, mat4x3(7.0, -4.0, -5.0, -9.0, -8.0, 3.0, -3.0, 2.0, 3.0, 4.0, 0.0, -2.0)) && allOk;
	allOk = compare_vec4((blockC.i.mA), vec4(5.0, -4.0, 3.0, -1.0)) && allOk;
	allOk = compare_uint((blockC.i.mB), 3u) && allOk;
	allOk = compare_bvec3((blockC.i.mC), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((blockC.i.mD), bvec3(true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA = (mat2x3(9.0, 7.0, 5.0, -2.0, 9.0, -6.0));
	blockB.a.mB = (1);
	blockB.a.mC[0][0][0] = (uvec4(7u, 8u, 6u, 6u));
	blockB.a.mC[0][1][0] = (uvec4(8u, 4u, 2u, 4u));
	blockB.a.mC[0][2][0] = (uvec4(9u, 2u, 5u, 6u));
	blockB.a.mC[0][3][0] = (uvec4(6u, 9u, 3u, 0u));
	blockB.a.mC[0][4][0] = (uvec4(9u, 5u, 7u, 7u));
	blockB.a.mC[1][0][0] = (uvec4(7u, 1u, 7u, 0u));
	blockB.a.mC[1][1][0] = (uvec4(2u, 6u, 7u, 8u));
	blockB.a.mC[1][2][0] = (uvec4(1u, 4u, 3u, 5u));
	blockB.a.mC[1][3][0] = (uvec4(9u, 8u, 0u, 8u));
	blockB.a.mC[1][4][0] = (uvec4(4u, 3u, 6u, 2u));
	blockB.a.mC[2][0][0] = (uvec4(8u, 6u, 5u, 8u));
	blockB.a.mC[2][1][0] = (uvec4(0u, 6u, 1u, 7u));
	blockB.a.mC[2][2][0] = (uvec4(9u, 7u, 9u, 1u));
	blockB.a.mC[2][3][0] = (uvec4(1u, 7u, 6u, 3u));
	blockB.a.mC[2][4][0] = (uvec4(1u, 4u, 6u, 9u));
	blockB.a.mC[3][0][0] = (uvec4(5u, 9u, 7u, 4u));
	blockB.a.mC[3][1][0] = (uvec4(8u, 9u, 0u, 5u));
	blockB.a.mC[3][2][0] = (uvec4(9u, 5u, 7u, 9u));
	blockB.a.mC[3][3][0] = (uvec4(8u, 1u, 8u, 9u));
	blockB.a.mC[3][4][0] = (uvec4(0u, 8u, 1u, 5u));
	blockB.a.mC[4][0][0] = (uvec4(5u, 5u, 9u, 4u));
	blockB.a.mC[4][1][0] = (uvec4(5u, 7u, 8u, 4u));
	blockB.a.mC[4][2][0] = (uvec4(8u, 8u, 1u, 7u));
	blockB.a.mC[4][3][0] = (uvec4(9u, 3u, 0u, 3u));
	blockB.a.mC[4][4][0] = (uvec4(4u, 2u, 7u, 2u));
	blockB.a.mD[0] = (mat2(-6.0, 2.0, -5.0, 6.0));
	blockB.a.mD[1] = (mat2(2.0, 0.0, -4.0, 7.0));
	blockB.a.mD[2] = (mat2(-3.0, 3.0, -9.0, 4.0));
	blockB.a.mD[3] = (mat2(8.0, 3.0, -6.0, -5.0));
	blockB.a.mD[4] = (mat2(9.0, -6.0, -9.0, -2.0));
	blockB.b.mA = (mat4x3(-4.0, -9.0, -8.0, 6.0, 3.0, -1.0, -7.0, 7.0, -1.0, 0.0, 5.0, 5.0));
	blockB.b.mB = (uvec4(6u, 1u, 2u, 3u));
	blockB.c.mA = (mat3x4(-4.0, -9.0, 5.0, 7.0, -4.0, -2.0, 5.0, 4.0, 2.0, 9.0, -5.0, 6.0));
	blockC.e = (vec4(-1.0, 3.0, -4.0, -9.0));
	blockC.f = (mat4x3(9.0, -8.0, 1.0, -2.0, -8.0, 3.0, 4.0, 6.0, 7.0, 5.0, -5.0, 2.0));
	blockC.g = (ivec2(-6, 2));
	blockC.h = (vec4(6.0, 8.0, 1.0, 0.0));
	blockC.i.mA = (vec4(-6.0, -9.0, 2.0, -2.0));
	blockC.i.mB = (0u);
	blockC.i.mC = (bvec3(true, true, true));
	blockC.i.mD = (bvec3(false, true, false));
}
#version 450
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
	mediump mat3x2 a;
	highp ivec4 b;
	bool c;
	mediump uint d;
	mediump uvec2 e[];
} blockB;
layout(scalar, binding = 2) buffer BlockC
{
	lowp mat4x2 f;
	mediump ivec4 g;
	mediump mat2x3 h[6];
	highp mat3 i[];
} blockC[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.b), ivec4(4, 5, 3, 7)) && allOk;
	allOk = compare_uint((blockB.d), 4u) && allOk;
	allOk = compare_uvec2((blockB.e[0]), uvec2(7u, 2u)) && allOk;
	allOk = compare_uvec2((blockB.e[1]), uvec2(6u, 5u)) && allOk;
	allOk = compare_uvec2((blockB.e[2]), uvec2(7u, 4u)) && allOk;
	allOk = compare_mat4x2(blockC[0].f, mat4x2(8.0, 8.0, -6.0, 2.0, -6.0, -8.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat2x3(blockC[0].h[0], mat2x3(-3.0, -5.0, 3.0, 0.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat2x3(blockC[0].h[1], mat2x3(-9.0, -4.0, 1.0, 1.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2x3(blockC[0].h[2], mat2x3(-1.0, 2.0, 4.0, -2.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x3(blockC[0].h[3], mat2x3(8.0, -8.0, 9.0, -3.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat2x3(blockC[0].h[4], mat2x3(-8.0, -7.0, 4.0, -5.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2x3(blockC[0].h[5], mat2x3(-4.0, 1.0, -1.0, -8.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat4x2(blockC[1].f, mat4x2(8.0, 2.0, -1.0, 0.0, 5.0, -2.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(blockC[1].h[0], mat2x3(2.0, -9.0, -1.0, -7.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(blockC[1].h[1], mat2x3(-5.0, -2.0, -7.0, -3.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x3(blockC[1].h[2], mat2x3(0.0, 2.0, 6.0, -4.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat2x3(blockC[1].h[3], mat2x3(-5.0, 5.0, -2.0, 5.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat2x3(blockC[1].h[4], mat2x3(-3.0, -9.0, -6.0, -7.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat2x3(blockC[1].h[5], mat2x3(1.0, 2.0, 8.0, 1.0, -4.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x2(-1.0, -4.0, 2.0, -1.0, 2.0, 2.0));
	blockB.b = (ivec4(-5, 7, -5, 5));
	blockB.d = (9u);
	blockC[0].f = (mat4x2(3.0, -2.0, 9.0, -6.0, 3.0, 5.0, 5.0, 9.0));
	blockC[0].h[0] = (mat2x3(-8.0, 3.0, 0.0, -6.0, -8.0, -3.0));
	blockC[0].h[1] = (mat2x3(8.0, 2.0, -4.0, 6.0, 9.0, 9.0));
	blockC[0].h[2] = (mat2x3(-1.0, -2.0, 8.0, 7.0, -5.0, -2.0));
	blockC[0].h[3] = (mat2x3(-3.0, -4.0, 3.0, 1.0, -2.0, -3.0));
	blockC[0].h[4] = (mat2x3(-9.0, 9.0, -1.0, -3.0, -4.0, -3.0));
	blockC[0].h[5] = (mat2x3(1.0, 0.0, -5.0, 8.0, -3.0, 8.0));
	blockC[0].i[0] = (mat3(5.0, 0.0, 1.0, 2.0, 6.0, 8.0, 2.0, -3.0, -3.0));
	blockC[0].i[1] = (mat3(-6.0, -5.0, 3.0, 3.0, 0.0, -4.0, -9.0, 0.0, -3.0));
	blockC[0].i[2] = (mat3(-8.0, 8.0, -7.0, -7.0, 8.0, -9.0, 4.0, -4.0, -1.0));
	blockC[0].i[3] = (mat3(6.0, -7.0, -1.0, -7.0, 7.0, -5.0, 1.0, -4.0, 8.0));
	blockC[0].i[4] = (mat3(4.0, -7.0, -8.0, 6.0, -8.0, 6.0, -9.0, 0.0, -6.0));
	blockC[0].i[5] = (mat3(-3.0, -5.0, 3.0, 5.0, -5.0, 7.0, 0.0, -9.0, -9.0));
	blockC[0].i[6] = (mat3(-8.0, 9.0, 3.0, 7.0, 7.0, -1.0, -9.0, -3.0, -2.0));
	blockC[1].f = (mat4x2(-4.0, 2.0, 0.0, -8.0, -8.0, 0.0, 3.0, 7.0));
	blockC[1].h[0] = (mat2x3(-3.0, 1.0, -6.0, -6.0, 4.0, 6.0));
	blockC[1].h[1] = (mat2x3(-2.0, -7.0, 8.0, 1.0, -6.0, 7.0));
	blockC[1].h[2] = (mat2x3(3.0, -8.0, -8.0, -9.0, 8.0, 5.0));
	blockC[1].h[3] = (mat2x3(9.0, 8.0, 7.0, -2.0, 7.0, -1.0));
	blockC[1].h[4] = (mat2x3(-3.0, 6.0, 0.0, 1.0, 0.0, -9.0));
	blockC[1].h[5] = (mat2x3(-1.0, -6.0, 6.0, -3.0, -1.0, 5.0));
	blockC[1].i[0] = (mat3(5.0, -9.0, -5.0, -7.0, -1.0, 0.0, -1.0, 6.0, 6.0));
	blockC[1].i[1] = (mat3(1.0, 0.0, -9.0, 6.0, -3.0, 3.0, 7.0, -4.0, 9.0));
	blockC[1].i[2] = (mat3(-9.0, -2.0, -6.0, -7.0, 9.0, -3.0, -7.0, 3.0, 0.0));
	blockC[1].i[3] = (mat3(9.0, 2.0, -1.0, -2.0, -4.0, -4.0, 0.0, 7.0, -3.0));
	blockC[1].i[4] = (mat3(3.0, -8.0, -6.0, -7.0, -5.0, -2.0, 0.0, 1.0, -8.0));
	blockC[1].i[5] = (mat3(7.0, -8.0, 6.0, 4.0, 1.0, -2.0, 4.0, -6.0, 6.0));
	blockC[1].i[6] = (mat3(-5.0, 5.0, 2.0, 6.0, -9.0, 9.0, 1.0, 6.0, -4.0));
	blockC[1].i[7] = (mat3(-7.0, -3.0, -4.0, 4.0, -4.0, -7.0, -1.0, -6.0, 5.0));
}
#version 450
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
	mediump uvec2 a[];
} blockB;

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a[0]), uvec2(7u, 0u)) && allOk;
	allOk = compare_uvec2((blockB.a[1]), uvec2(1u, 9u)) && allOk;
	allOk = compare_uvec2((blockB.a[2]), uvec2(0u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat3x2 a;
	mediump uvec4 b;
	highp mat3 c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((b), uvec4(3u, 3u, 6u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat3x2(-4.0, -1.0, -8.0, -2.0, 1.0, 0.0));
	b = (uvec4(6u, 1u, 7u, 0u));
}
#version 450
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
	bvec2 mB;
};
layout(scalar, binding = 1) buffer BlockB
{
	highp mat4 a;
	mediump ivec4 b;
	highp uint c[];
} blockB;
layout(scalar, column_major, binding = 2) buffer BlockC
{
	mediump mat3 d;
	highp float e;
	lowp uvec3 f;
	sA g;
	highp mat4x2 h;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.c[0]), 7u) && allOk;
	allOk = compare_uint((blockB.c[1]), 5u) && allOk;
	allOk = compare_uint((blockB.c[2]), 9u) && allOk;
	allOk = compare_uint((blockB.c[3]), 3u) && allOk;
	allOk = compare_uint((blockB.c[4]), 4u) && allOk;
	allOk = compare_uint((blockB.c[5]), 7u) && allOk;
	allOk = compare_uint((blockB.c[6]), 7u) && allOk;
	allOk = compare_uint((blockB.c[7]), 1u) && allOk;
	allOk = compare_mat3(blockC.d, mat3(1.0, -3.0, -1.0, 4.0, 8.0, -1.0, 7.0, -8.0, -7.0)) && allOk;
	allOk = compare_float((blockC.e), -8.0) && allOk;
	allOk = compare_bool((blockC.g.mA), false) && allOk;
	allOk = compare_bvec2((blockC.g.mB), bvec2(false, false)) && allOk;
	allOk = compare_mat4x2(blockC.h, mat4x2(-7.0, 2.0, -8.0, -2.0, 6.0, 1.0, -5.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c[0] = (2u);
	blockB.c[1] = (1u);
	blockB.c[2] = (5u);
	blockB.c[3] = (9u);
	blockB.c[4] = (8u);
	blockB.c[5] = (3u);
	blockB.c[6] = (6u);
	blockB.c[7] = (5u);
	blockC.f = (uvec3(2u, 4u, 9u));
	blockC.h = (mat4x2(2.0, 1.0, 7.0, -1.0, -9.0, 9.0, -1.0, -7.0));
}
#version 450
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
	highp mat3 a;
	highp vec2 b[6];
	i16vec4 c[6];
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	lowp ivec4 d;
	lowp ivec2 e;
	mediump vec3 f;
	f16vec2 g;
} blockC;
layout(std140, row_major, binding = 3) buffer BlockD
{
	bool h;
	f16vec3 i;
	f16vec2 j;
	f16vec4 k;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.b[0]), vec2(5.0, -7.0)) && allOk;
	allOk = compare_vec2((blockB.b[1]), vec2(-5.0, -2.0)) && allOk;
	allOk = compare_vec2((blockB.b[2]), vec2(-1.0, 5.0)) && allOk;
	allOk = compare_vec2((blockB.b[3]), vec2(2.0, -4.0)) && allOk;
	allOk = compare_vec2((blockB.b[4]), vec2(7.0, 7.0)) && allOk;
	allOk = compare_vec2((blockB.b[5]), vec2(-1.0, 3.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB.c[0]), ivec4(-2, -1, -5, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB.c[1]), ivec4(3, 9, -5, 1)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB.c[2]), ivec4(8, -8, 4, -8)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB.c[3]), ivec4(-3, -1, 4, -9)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB.c[4]), ivec4(7, 1, -4, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB.c[5]), ivec4(-6, 0, 6, 8)) && allOk;
	allOk = compare_vec3((blockC.f), vec3(3.0, -7.0, 7.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.g), vec2(-3.0, -3.0)) && allOk;
	allOk = compare_f16vec3(vec3(i), vec3(3.0, -1.0, 0.0)) && allOk;
	allOk = compare_f16vec4(vec4(k), vec4(-3.0, -5.0, 2.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3(3.0, -4.0, 2.0, 2.0, 4.0, 9.0, -2.0, -4.0, -9.0));
	blockC.f = (vec3(-4.0, 6.0, 0.0));
	blockC.g = f16vec2(vec2(-2.0, -5.0));
	h = (true);
	j = f16vec2(vec2(-8.0, 9.0));
	k = f16vec4(vec4(2.0, 5.0, -2.0, -5.0));
}
#version 450
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
	lowp uvec2 a;
	u16vec2 b;
	f16vec4 c;
	f16vec4 d[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(blockB.c), vec4(-1.0, -9.0, 5.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	int16_t a;
	lowp int b;
};
layout(std430, row_major, binding = 2) readonly buffer BlockC
{
	u16vec2 c;
	u16vec3 d[1];
	highp vec2 e;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(a), 0) && allOk;
	allOk = compare_int((b), 3) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.c), uvec2(6u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.d[0]), uvec3(9u, 2u, 2u)) && allOk;
	allOk = compare_vec2((blockC.e), vec2(-5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = int16_t(5);
}
#version 450
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
	mediump mat4x3 mB;
};
layout(std430, binding = 1) buffer BlockB
{
	sA a[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(a[0].mA, mat3x2(1.0, -5.0, -9.0, -5.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat4x3(a[0].mB, mat4x3(1.0, 2.0, 8.0, 7.0, 9.0, -8.0, 2.0, 9.0, 6.0, -5.0, 7.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0].mA = (mat3x2(2.0, 7.0, -5.0, -4.0, -8.0, -5.0));
	a[0].mB = (mat4x3(0.0, 0.0, -7.0, 5.0, 3.0, 4.0, 7.0, 8.0, 3.0, 8.0, 8.0, 0.0));
}
#version 450
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
	lowp ivec3 mB;
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	i16vec3 a;
	i16vec2 b;
	sA c[];
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	highp mat2 d;
	bvec2 e;
	float16_t f;
	mediump uvec2 g;
	float16_t h[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(blockB.a), ivec3(-4, 6, 6)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.b), ivec2(-7, -9)) && allOk;
	allOk = compare_uint((blockB.c[0].mA), 2u) && allOk;
	allOk = compare_ivec3((blockB.c[0].mB), ivec3(-6, 4, -6)) && allOk;
	allOk = compare_uint((blockB.c[1].mA), 4u) && allOk;
	allOk = compare_ivec3((blockB.c[1].mB), ivec3(-3, 2, -9)) && allOk;
	allOk = compare_uint((blockB.c[2].mA), 7u) && allOk;
	allOk = compare_ivec3((blockB.c[2].mB), ivec3(-7, -5, -7)) && allOk;
	allOk = compare_uint((blockB.c[3].mA), 0u) && allOk;
	allOk = compare_ivec3((blockB.c[3].mB), ivec3(3, 5, 2)) && allOk;
	allOk = compare_uint((blockB.c[4].mA), 3u) && allOk;
	allOk = compare_ivec3((blockB.c[4].mB), ivec3(-9, 0, -5)) && allOk;
	allOk = compare_uint((blockB.c[5].mA), 2u) && allOk;
	allOk = compare_ivec3((blockB.c[5].mB), ivec3(0, 1, -8)) && allOk;
	allOk = compare_bvec2((blockC.e), bvec2(true, false)) && allOk;
	allOk = compare_float16_t(float(blockC.f), 2.0) && allOk;
	allOk = compare_uvec2((blockC.g), uvec2(8u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i16vec3(ivec3(9, -7, -5));
	blockB.b = i16vec2(ivec2(-9, -8));
	blockB.c[0].mA = (5u);
	blockB.c[0].mB = (ivec3(2, -5, 9));
	blockB.c[1].mA = (2u);
	blockB.c[1].mB = (ivec3(-6, -3, 9));
	blockB.c[2].mA = (5u);
	blockB.c[2].mB = (ivec3(4, 0, 4));
	blockB.c[3].mA = (1u);
	blockB.c[3].mB = (ivec3(5, -2, 4));
	blockB.c[4].mA = (2u);
	blockB.c[4].mB = (ivec3(-6, 5, -4));
	blockB.c[5].mA = (0u);
	blockB.c[5].mB = (ivec3(9, 1, 4));
	blockC.d = (mat2(-5.0, 8.0, -5.0, 4.0));
	blockC.e = (bvec2(true, false));
	blockC.h[0] = float16_t(-9.0);
	blockC.h[1] = float16_t(9.0);
}
#version 450
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
layout(std140, binding = 1) buffer BlockB
{
	u16vec2 a;
	highp ivec2 b[1];
	uint16_t c;
	lowp int d;
	highp mat4x3 e[];
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	sA f[][7];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(a), uvec2(2u, 0u)) && allOk;
	allOk = compare_uint16_t(uint(c), 8u) && allOk;
	allOk = compare_int((d), 9) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f[0][0].mA), uvec2(6u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f[0][1].mA), uvec2(1u, 0u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f[0][2].mA), uvec2(2u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f[0][3].mA), uvec2(8u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f[0][4].mA), uvec2(7u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f[0][5].mA), uvec2(2u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f[0][6].mA), uvec2(6u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f[1][0].mA), uvec2(8u, 3u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f[1][1].mA), uvec2(3u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f[1][2].mA), uvec2(0u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f[1][3].mA), uvec2(5u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f[1][4].mA), uvec2(7u, 3u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f[1][5].mA), uvec2(1u, 5u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f[1][6].mA), uvec2(1u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f[2][0].mA), uvec2(2u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f[2][1].mA), uvec2(3u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f[2][2].mA), uvec2(5u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f[2][3].mA), uvec2(3u, 5u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f[2][4].mA), uvec2(1u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f[2][5].mA), uvec2(2u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f[2][6].mA), uvec2(4u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f[3][0].mA), uvec2(2u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f[3][1].mA), uvec2(5u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f[3][2].mA), uvec2(3u, 0u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f[3][3].mA), uvec2(2u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f[3][4].mA), uvec2(1u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f[3][5].mA), uvec2(6u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f[3][6].mA), uvec2(9u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f[4][0].mA), uvec2(7u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f[4][1].mA), uvec2(5u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f[4][2].mA), uvec2(2u, 5u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f[4][3].mA), uvec2(7u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f[4][4].mA), uvec2(9u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f[4][5].mA), uvec2(3u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f[4][6].mA), uvec2(9u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f[5][0].mA), uvec2(0u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f[5][1].mA), uvec2(3u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f[5][2].mA), uvec2(1u, 5u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f[5][3].mA), uvec2(0u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f[5][4].mA), uvec2(9u, 3u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f[5][5].mA), uvec2(3u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f[5][6].mA), uvec2(4u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = u16vec2(uvec2(4u, 9u));
	b[0] = (ivec2(-9, -6));
	c = uint16_t(5u);
	blockC.f[0][0].mA = u16vec2(uvec2(9u, 2u));
	blockC.f[0][1].mA = u16vec2(uvec2(9u, 5u));
	blockC.f[0][2].mA = u16vec2(uvec2(3u, 0u));
	blockC.f[0][3].mA = u16vec2(uvec2(0u, 2u));
	blockC.f[0][4].mA = u16vec2(uvec2(4u, 3u));
	blockC.f[0][5].mA = u16vec2(uvec2(0u, 4u));
	blockC.f[0][6].mA = u16vec2(uvec2(5u, 6u));
	blockC.f[1][0].mA = u16vec2(uvec2(5u, 7u));
	blockC.f[1][1].mA = u16vec2(uvec2(5u, 7u));
	blockC.f[1][2].mA = u16vec2(uvec2(5u, 2u));
	blockC.f[1][3].mA = u16vec2(uvec2(3u, 3u));
	blockC.f[1][4].mA = u16vec2(uvec2(5u, 7u));
	blockC.f[1][5].mA = u16vec2(uvec2(9u, 1u));
	blockC.f[1][6].mA = u16vec2(uvec2(8u, 0u));
	blockC.f[2][0].mA = u16vec2(uvec2(2u, 7u));
	blockC.f[2][1].mA = u16vec2(uvec2(8u, 8u));
	blockC.f[2][2].mA = u16vec2(uvec2(2u, 6u));
	blockC.f[2][3].mA = u16vec2(uvec2(7u, 9u));
	blockC.f[2][4].mA = u16vec2(uvec2(1u, 9u));
	blockC.f[2][5].mA = u16vec2(uvec2(2u, 8u));
	blockC.f[2][6].mA = u16vec2(uvec2(3u, 1u));
	blockC.f[3][0].mA = u16vec2(uvec2(4u, 0u));
	blockC.f[3][1].mA = u16vec2(uvec2(7u, 0u));
	blockC.f[3][2].mA = u16vec2(uvec2(9u, 5u));
	blockC.f[3][3].mA = u16vec2(uvec2(4u, 4u));
	blockC.f[3][4].mA = u16vec2(uvec2(1u, 7u));
	blockC.f[3][5].mA = u16vec2(uvec2(1u, 4u));
	blockC.f[3][6].mA = u16vec2(uvec2(7u, 7u));
	blockC.f[4][0].mA = u16vec2(uvec2(6u, 6u));
	blockC.f[4][1].mA = u16vec2(uvec2(5u, 3u));
	blockC.f[4][2].mA = u16vec2(uvec2(5u, 2u));
	blockC.f[4][3].mA = u16vec2(uvec2(0u, 9u));
	blockC.f[4][4].mA = u16vec2(uvec2(1u, 9u));
	blockC.f[4][5].mA = u16vec2(uvec2(5u, 8u));
	blockC.f[4][6].mA = u16vec2(uvec2(7u, 7u));
	blockC.f[5][0].mA = u16vec2(uvec2(3u, 2u));
	blockC.f[5][1].mA = u16vec2(uvec2(0u, 3u));
	blockC.f[5][2].mA = u16vec2(uvec2(3u, 3u));
	blockC.f[5][3].mA = u16vec2(uvec2(4u, 0u));
	blockC.f[5][4].mA = u16vec2(uvec2(1u, 1u));
	blockC.f[5][5].mA = u16vec2(uvec2(7u, 1u));
	blockC.f[5][6].mA = u16vec2(uvec2(2u, 1u));
}
#version 450
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
	layout(offset = 0) lowp vec3 a;
	layout(offset = 12) float16_t b;
	layout(offset = 16) i16vec2 c;
	layout(offset = 20) float16_t d;
} blockB[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB[0].a), vec3(2.0, -3.0, 2.0)) && allOk;
	allOk = compare_float16_t(float(blockB[0].b), -4.0) && allOk;
	allOk = compare_float16_t(float(blockB[0].d), -2.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (vec3(8.0, 7.0, -2.0));
	blockB[0].b = float16_t(6.0);
	blockB[0].c = i16vec2(ivec2(0, 5));
	blockB[0].d = float16_t(9.0);
}
#version 450
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
layout(scalar, row_major, binding = 1) buffer BlockB
{
	f16vec3 a;
	sA b[][1][3];
} blockB[3];

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

layout(std430, row_major, binding = 1) buffer BlockB
{
	highp float a;
} blockB[];

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

layout(std430, row_major, binding = 1) buffer BlockB
{
	int16_t a;
	i16vec2 b;
} blockB[];

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(blockB[nonuniformEXT(0)].b), ivec2(0, -7)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB[nonuniformEXT(1)].b), ivec2(0, -2)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB[nonuniformEXT(2)].b), ivec2(9, 7)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB[nonuniformEXT(3)].b), ivec2(0, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = int16_t(5);
	blockB[nonuniformEXT(1)].a = int16_t(9);
	blockB[nonuniformEXT(2)].a = int16_t(-5);
	blockB[nonuniformEXT(3)].a = int16_t(5);
}
#version 450
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
	mediump int a;
	mediump uint b;
	uint8_t c[1];
	uint8_t d;
	lowp uint e[1];
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	mediump float f;
	mediump float g;
	highp int h[1];
	mediump float i;
	mediump float j;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.e[0]), 3u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (4u);
	blockB.d = uint8_t(1u);
	blockB.e[0] = (5u);
	blockC.g = (-1.0);
	blockC.h[0] = (9);
	blockC.i = (-3.0);
	blockC.j = (5.0);
}
#version 450
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
	highp vec4 a;
	u8vec2 b;
	lowp ivec2 c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((a), vec4(4.0, -1.0, 1.0, 6.0)) && allOk;
	allOk = compare_u8vec2(uvec2(b), uvec2(8u, 2u)) && allOk;
	allOk = compare_ivec2((c), ivec2(-6, -4)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec4(5.0, 7.0, -9.0, -6.0));
	b = u8vec2(uvec2(5u, 7u));
	c = (ivec2(-1, -3));
}
#version 450
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
	mediump vec2 a;
	lowp int b;
	mediump mat4x2 c;
} blockB;
layout(std430, column_major, binding = 2) readonly buffer BlockC
{
	mediump mat4 d;
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	mediump ivec4 e;
	highp mat4 f;
	lowp mat2x3 g;
	highp int h;
	mediump mat3 i;
};
layout(std140, row_major, binding = 4) buffer BlockE
{
	bvec3 j;
	highp ivec4 k;
	i8vec3 l;
	highp mat3x2 m;
	mediump uvec2 n;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(2.0, 5.0)) && allOk;
	allOk = compare_ivec4((e), ivec4(8, -6, -5, -9)) && allOk;
	allOk = compare_mat4(f, mat4(-3.0, -5.0, 3.0, 0.0, 7.0, 8.0, -9.0, -4.0, 1.0, 1.0, -4.0, -5.0, -1.0, 2.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat2x3(g, mat2x3(2.0, -1.0, 8.0, -8.0, 9.0, -3.0)) && allOk;
	allOk = compare_int((h), 8) && allOk;
	allOk = compare_mat3(i, mat3(-1.0, -8.0, -7.0, 4.0, -5.0, 4.0, 7.0, -4.0, 1.0)) && allOk;
	allOk = compare_bvec3((blockE.j), bvec3(true, false, false)) && allOk;
	allOk = compare_ivec4((blockE.k), ivec4(-3, 1, -6, 9)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE.l), ivec3(0, 9, 4294967291)) && allOk;
	allOk = compare_mat3x2(blockE.m, mat3x2(-9.0, 1.0, 7.0, -3.0, -6.0, -7.0)) && allOk;
	allOk = compare_uvec2((blockE.n), uvec2(4u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec2(-1.0, -4.0));
	blockB.b = (2);
	blockB.c = (mat4x2(-1.0, 2.0, 2.0, -5.0, 7.0, -5.0, 5.0, -3.0));
	e = (ivec4(3, -9, -1, -5));
	f = (mat4(-8.0, 3.0, 0.0, -6.0, -8.0, -3.0, 8.0, 2.0, -4.0, 6.0, 9.0, 9.0, -1.0, -2.0, 8.0, 7.0));
	i = (mat3(-3.0, -9.0, 9.0, -1.0, -3.0, -4.0, -3.0, 1.0, 0.0));
	blockE.k = (ivec4(5, 0, 1, 2));
	blockE.m = (mat3x2(-3.0, -5.0, -3.0, 3.0, -6.0, 3.0));
	blockE.n = (uvec2(1u, 4u));
}
#version 450
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
	i8vec2 a;
	highp mat3x2 b;
	bvec3 c;
	bvec2 d;
	lowp ivec2 e;
};
layout(std430, column_major, binding = 2) buffer BlockC
{
	highp vec4 f;
	int8_t g[5];
	u8vec2 h;
	u8vec3 i[3];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(b, mat3x2(6.0, 5.0, -7.0, -4.0, -9.0, -9.0)) && allOk;
	allOk = compare_bvec3((c), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec2((d), bvec2(true, false)) && allOk;
	allOk = compare_int8_t(int(blockC.g[0]), 2) && allOk;
	allOk = compare_int8_t(int(blockC.g[1]), 4294967287) && allOk;
	allOk = compare_int8_t(int(blockC.g[2]), 0) && allOk;
	allOk = compare_int8_t(int(blockC.g[3]), 4294967291) && allOk;
	allOk = compare_int8_t(int(blockC.g[4]), 0) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.h), uvec2(1u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = i8vec2(ivec2(9, 4294967289));
	e = (ivec2(4, 0));
	blockC.f = (vec4(4.0, 5.0, -2.0, 4.0));
	blockC.h = u8vec2(uvec2(2u, 5u));
}
#version 450
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
	highp uvec3 b;
	bvec2 c[];
};
layout(std140, binding = 2) buffer BlockC
{
	highp mat4x2 d;
	lowp vec4 e;
	mediump float f[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((a), bvec4(true, true, true, true)) && allOk;
	allOk = compare_mat4x2(blockC.d, mat4x2(-1.0, 4.0, -9.0, 7.0, 1.0, -4.0, 7.0, -6.0)) && allOk;
	allOk = compare_vec4((blockC.e), vec4(0.0, 6.0, 8.0, 5.0)) && allOk;
	allOk = compare_float((blockC.f[0]), 9.0) && allOk;
	allOk = compare_float((blockC.f[1]), -3.0) && allOk;
	allOk = compare_float((blockC.f[2]), 2.0) && allOk;
	allOk = compare_float((blockC.f[3]), 2.0) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec4(true, false, true, false));
	c[0] = (bvec2(false, false));
	c[1] = (bvec2(false, true));
	c[2] = (bvec2(false, false));
	c[3] = (bvec2(false, true));
	c[4] = (bvec2(false, true));
	c[5] = (bvec2(false, false));
	c[6] = (bvec2(true, true));
	c[7] = (bvec2(false, true));
	blockC.d = (mat4x2(-4.0, -4.0, -9.0, -5.0, 4.0, -3.0, -8.0, -8.0));
	blockC.e = (vec4(9.0, 4.0, 4.0, -3.0));
	blockC.f[0] = (8.0);
	blockC.f[1] = (-6.0);
	blockC.f[2] = (-2.0);
	blockC.f[3] = (-6.0);
}
#version 450
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
	highp mat4 a;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.a, mat4(2.0, -3.0, 2.0, -4.0, 4.0, 6.0, -2.0, -5.0, -3.0, -3.0, 1.0, -3.0, 8.0, 7.0, 3.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump uvec4 a[];
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	highp ivec3 b;
	mediump uvec3 c;
	highp mat2x3 d;
	mediump mat3x2 e;
	mediump vec4 f[];
};
layout(std430, binding = 3) buffer BlockD
{
	mediump mat4x3 g;
	mediump uvec4 h[];
} blockD[2];
layout(std430, column_major, binding = 4) buffer BlockE
{
	mediump mat2 i[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((c), uvec3(1u, 5u, 7u)) && allOk;
	allOk = compare_mat2x3(d, mat2x3(6.0, 8.0, -9.0, -6.0, -5.0, -8.0)) && allOk;
	allOk = compare_vec4((f[0]), vec4(4.0, 6.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat4x3(blockD[0].g, mat4x3(8.0, 3.0, 9.0, -7.0, 9.0, 7.0, -5.0, -9.0, 7.0, 3.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat4x3(blockD[1].g, mat4x3(-3.0, 6.0, -1.0, -3.0, -6.0, 7.0, 6.0, -7.0, 2.0, -2.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat2(i[0], mat2(-7.0, 6.0, -6.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (uvec4(4u, 9u, 2u, 4u));
	b = (ivec3(1, -2, -1));
	c = (uvec3(5u, 9u, 4u));
	e = (mat3x2(1.0, 2.0, -6.0, 5.0, 9.0, 2.0));
	blockD[0].g = (mat4x3(-5.0, 7.0, 5.0, 5.0, 7.0, -3.0, 2.0, -2.0, 9.0, 5.0, 7.0, -5.0));
	blockD[0].h[0] = (uvec4(7u, 8u, 4u, 7u));
	blockD[1].g = (mat4x3(7.0, -4.0, -9.0, -2.0, 9.0, 7.0, 8.0, -1.0, 5.0, -4.0, 9.0, -2.0));
	blockD[1].h[0] = (uvec4(6u, 7u, 6u, 5u));
	i[0] = (mat2(8.0, 2.0, 6.0, 3.0));
}
#version 450
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
	lowp uvec2 mB;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	mediump ivec4 a;
	mediump vec4 b;
	bvec3 c;
	sA d;
	highp mat2 e[][3];
} blockB;
layout(std140, row_major, binding = 2) buffer BlockC
{
	i8vec3 f;
	bool g;
	lowp mat4x2 h;
	highp mat2x3 i[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.b), vec4(-4.0, 4.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2x3(blockC.i[0], mat2x3(0.0, -7.0, -4.0, 7.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2x3(blockC.i[1], mat2x3(-4.0, 9.0, 7.0, -7.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat2x3(blockC.i[2], mat2x3(6.0, 7.0, -2.0, 9.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat2x3(blockC.i[3], mat2x3(-2.0, -3.0, 8.0, 2.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat2x3(blockC.i[4], mat2x3(-4.0, -4.0, -8.0, 8.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x3(blockC.i[5], mat2x3(3.0, 7.0, -1.0, -5.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2x3(blockC.i[6], mat2x3(7.0, 9.0, 4.0, -9.0, -1.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (vec4(-1.0, 9.0, 3.0, -5.0));
	blockB.c = (bvec3(false, false, true));
	blockB.d.mA = (-6.0);
	blockB.d.mB = (uvec2(8u, 6u));
	blockC.f = i8vec3(ivec3(9, 4294967294, 4294967287));
	blockC.g = (false);
	blockC.h = (mat4x2(4.0, 3.0, 0.0, 4.0, 8.0, 7.0, 1.0, 6.0));
}
#version 450
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
	layout(offset = 0) uint8_t a;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) bvec3 b;
	layout(offset = 16) bvec3 c;
	layout(offset = 28) uint8_t d;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) u8vec2 e;
	layout(offset = 2) uint8_t f;
} blockD;
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) i8vec2 g;
	layout(offset = 2) i8vec4 h;
	layout(offset = 16) lowp uvec4 i;
} blockE[2];

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(a), 2u) && allOk;
	allOk = compare_bvec3((blockC.b), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((blockC.c), bvec3(false, false, true)) && allOk;
	allOk = compare_uint8_t(uint(blockC.d), 0u) && allOk;
	allOk = compare_i8vec2(ivec2(blockE[0].g), ivec2(4, 4294967290)) && allOk;
	allOk = compare_i8vec4(ivec4(blockE[0].h), ivec4(4294967293, 2, 4294967287, 4294967289)) && allOk;
	allOk = compare_uvec4((blockE[0].i), uvec4(1u, 4u, 1u, 1u)) && allOk;
	allOk = compare_i8vec2(ivec2(blockE[1].g), ivec2(2, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(blockE[1].h), ivec4(0, 4294967291, 0, 1)) && allOk;
	allOk = compare_uvec4((blockE[1].i), uvec4(7u, 1u, 5u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = uint8_t(2u);
	blockC.b = (bvec3(true, true, true));
	blockC.d = uint8_t(1u);
	blockD.e = u8vec2(uvec2(6u, 4u));
	blockD.f = uint8_t(0u);
	blockE[0].g = i8vec2(ivec2(4, 0));
	blockE[0].h = i8vec4(ivec4(4, 5, 4294967294, 4));
	blockE[0].i = (uvec4(1u, 9u, 6u, 9u));
	blockE[1].g = i8vec2(ivec2(1, 4));
	blockE[1].h = i8vec4(ivec4(4294967291, 8, 4294967291, 4));
	blockE[1].i = (uvec4(4u, 4u, 3u, 0u));
}
#version 450
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
	layout(offset = 0) u8vec2 a;
	layout(offset = 4) bvec2 b;
	layout(offset = 16) lowp uvec4 c;
	layout(offset = 32) int8_t d;
} blockB;

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.b), bvec2(false, false)) && allOk;
	allOk = compare_int8_t(int(blockB.d), 5) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u8vec2(uvec2(5u, 7u));
	blockB.b = (bvec2(true, false));
	blockB.c = (uvec4(1u, 3u, 3u, 3u));
	blockB.d = int8_t(4294967294);
}
#version 450
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
	layout(offset = 3) u8vec3 b;
	layout(offset = 16) mediump ivec4 c;
	layout(offset = 32) lowp uint d[1];
} blockB[3];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) u8vec4 e;
	layout(offset = 16) bvec4 f;
	layout(offset = 32) bvec2 g;
	layout(offset = 40) i8vec3 h;
	layout(offset = 48) mediump vec4 i;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
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
	allOk = compare_u8vec4(uvec4(blockC.e), uvec4(6u, 3u, 8u, 2u)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.h), ivec3(0, 6, 3)) && allOk;
	allOk = compare_vec4((blockC.i), vec4(8.0, 3.0, -8.0, 0.0)) && allOk;
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
	blockC.e = u8vec4(uvec4(4u, 5u, 1u, 8u));
	blockC.f = (bvec4(true, false, false, true));
	blockC.g = (bvec2(true, true));
}
#version 450
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

layout(std140, binding = 1) readonly buffer Block
{
	lowp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var, mat2x3(6.0, 0.0, 4.0, -7.0, -8.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var, mat2x4(4.0, -4.0, 8.0, -4.0, -3.0, -1.0, -9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float(var[0][0], -4.0) && allOk;
	allOk = compare_float(var[0][1], -4.0) && allOk;
	allOk = compare_float(var[0][2], -6.0) && allOk;
	allOk = compare_float(var[0][3], -7.0) && allOk;
	allOk = compare_float(var[1][0], -2.0) && allOk;
	allOk = compare_float(var[1][1], -7.0) && allOk;
	allOk = compare_float(var[1][2], 1.0) && allOk;
	allOk = compare_float(var[1][3], 7.0) && allOk;
	allOk = compare_float(var[2][0], 9.0) && allOk;
	allOk = compare_float(var[2][1], 2.0) && allOk;
	allOk = compare_float(var[2][2], 6.0) && allOk;
	allOk = compare_float(var[2][3], -8.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-4.0, -4.0, -6.0, -7.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-2.0, -7.0, 1.0, 7.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(9.0, 2.0, 6.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	bvec3 var;
};

bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((var), bvec3(true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std430, row_major, binding = 1) readonly buffer Block
{
	highp mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var, mat2(-4.0, 0.0, 8.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 0.0) && allOk;
	allOk = compare_float(var[0][1], -1.0) && allOk;
	allOk = compare_float(var[0][2], 7.0) && allOk;
	allOk = compare_float(var[0][3], 9.0) && allOk;
	allOk = compare_float(var[1][0], -3.0) && allOk;
	allOk = compare_float(var[1][1], -5.0) && allOk;
	allOk = compare_float(var[1][2], 7.0) && allOk;
	allOk = compare_float(var[1][3], -1.0) && allOk;
	allOk = compare_float(var[2][0], 4.0) && allOk;
	allOk = compare_float(var[2][1], -2.0) && allOk;
	allOk = compare_float(var[2][2], 9.0) && allOk;
	allOk = compare_float(var[2][3], 9.0) && allOk;
	allOk = compare_float(var[3][0], 7.0) && allOk;
	allOk = compare_float(var[3][1], -5.0) && allOk;
	allOk = compare_float(var[3][2], 0.0) && allOk;
	allOk = compare_float(var[3][3], -6.0) && allOk;
	allOk = compare_vec4(var[0], vec4(0.0, -1.0, 7.0, 9.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-3.0, -5.0, 7.0, -1.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(4.0, -2.0, 9.0, 9.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(7.0, -5.0, 0.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	allOk = compare_float(var[0][0], 8.0) && allOk;
	allOk = compare_float(var[0][1], -2.0) && allOk;
	allOk = compare_float(var[0][2], 9.0) && allOk;
	allOk = compare_float(var[0][3], 0.0) && allOk;
	allOk = compare_float(var[1][0], 5.0) && allOk;
	allOk = compare_float(var[1][1], -8.0) && allOk;
	allOk = compare_float(var[1][2], -5.0) && allOk;
	allOk = compare_float(var[1][3], -1.0) && allOk;
	allOk = compare_float(var[2][0], -3.0) && allOk;
	allOk = compare_float(var[2][1], 5.0) && allOk;
	allOk = compare_float(var[2][2], 6.0) && allOk;
	allOk = compare_float(var[2][3], 3.0) && allOk;
	allOk = compare_vec4(var[0], vec4(8.0, -2.0, 9.0, 0.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(5.0, -8.0, -5.0, -1.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-3.0, 5.0, 6.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -5.0) && allOk;
	allOk = compare_float(var[0][1], 5.0) && allOk;
	allOk = compare_float(var[0][2], -5.0) && allOk;
	allOk = compare_float(var[0][3], -1.0) && allOk;
	allOk = compare_float(var[1][0], -6.0) && allOk;
	allOk = compare_float(var[1][1], -1.0) && allOk;
	allOk = compare_float(var[1][2], 3.0) && allOk;
	allOk = compare_float(var[1][3], -6.0) && allOk;
	allOk = compare_float(var[2][0], -3.0) && allOk;
	allOk = compare_float(var[2][1], 7.0) && allOk;
	allOk = compare_float(var[2][2], -8.0) && allOk;
	allOk = compare_float(var[2][3], 4.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-5.0, 5.0, -5.0, -1.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-6.0, -1.0, 3.0, -6.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-3.0, 7.0, -8.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat3x4(var, mat3x4(0.0, -1.0, -5.0, -6.0, 6.0, 0.0, -7.0, 9.0, -6.0, 0.0, 3.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	mediump float var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((var), -6.0) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -4.0) && allOk;
	allOk = compare_float(var[0][0], -4.0) && allOk;
	allOk = compare_float(var[0][1], 6.0) && allOk;
	allOk = compare_float(var[0][2], -8.0) && allOk;
	allOk = compare_float(var[1][0], 4.0) && allOk;
	allOk = compare_float(var[1][1], -7.0) && allOk;
	allOk = compare_float(var[1][2], -5.0) && allOk;
	allOk = compare_float(var[2][0], -6.0) && allOk;
	allOk = compare_float(var[2][1], 7.0) && allOk;
	allOk = compare_float(var[2][2], 5.0) && allOk;
	allOk = compare_float(var[3][0], 7.0) && allOk;
	allOk = compare_float(var[3][1], -3.0) && allOk;
	allOk = compare_float(var[3][2], -9.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-4.0, 6.0, -8.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(4.0, -7.0, -5.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-6.0, 7.0, 5.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(7.0, -3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat4x3(var, mat4x3(-2.0, 9.0, 1.0, 7.0, 8.0, 6.0, -6.0, -1.0, 4.0, -6.0, 2.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	u16vec2 var;
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(padding), 8u) && allOk;
	allOk = compare_u16vec2(uvec2(var), uvec2(4u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat2x4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0], mat2x4(-2.0, 4.0, 3.0, 6.0, 3.0, -7.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(6.0, 4.0, 0.0, 9.0, -2.0, 9.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(1.0, -7.0, 0.0, 6.0, -6.0, 9.0, 0.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4x2 var[3];
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
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat4x3(var[0], mat4x3(5.0, 0.0, 3.0, -5.0, 9.0, -6.0, 8.0, -6.0, 6.0, 2.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(1.0, 7.0, 3.0, 4.0, 6.0, 2.0, -7.0, -9.0, -6.0, 1.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(4.0, -7.0, -2.0, 5.0, -7.0, 6.0, 7.0, 1.0, -4.0, -7.0, -6.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	highp mat2x4 var[3];
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
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	uint16_t var[3];
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(var[0]), 9u) && allOk;
	allOk = compare_uint16_t(uint(var[1]), 5u) && allOk;
	allOk = compare_uint16_t(uint(var[2]), 4u) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
layout(scalar, binding = 1) readonly buffer Block
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

}
#version 450
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

layout(std140, row_major, buffer_reference) buffer Block
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

layout(std140, column_major, buffer_reference) buffer Block
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
	allOk = compare_mat3x4(block.var, mat3x4(-4.0, -4.0, -9.0, 3.0, 1.0, 3.0, -7.0, 3.0, 6.0, 1.0, 2.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(2.0, -6.0, -2.0, -1.0));
	block.var[1] = (vec4(8.0, 9.0, 3.0, -1.0));
	block.var[2] = (vec4(5.0, -9.0, -9.0, 6.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 9.0) && allOk;
	allOk = compare_float(block.var[0][1], -1.0) && allOk;
	allOk = compare_float(block.var[1][0], 3.0) && allOk;
	allOk = compare_float(block.var[1][1], 0.0) && allOk;
	allOk = compare_float(block.var[2][0], -6.0) && allOk;
	allOk = compare_float(block.var[2][1], -7.0) && allOk;
	allOk = compare_float(block.var[3][0], 9.0) && allOk;
	allOk = compare_float(block.var[3][1], 7.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(9.0, -1.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(3.0, 0.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(-6.0, -7.0)) && allOk;
	allOk = compare_vec2(block.var[3], vec2(9.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x2(-7.0, 3.0, -5.0, 1.0, -6.0, -1.0, -4.0, -5.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var, mat4x3(8.0, -4.0, -2.0, 8.0, 8.0, 0.0, -3.0, -1.0, -2.0, 0.0, 6.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(-9.0, 2.0, -2.0));
	block.var[1] = (vec3(0.0, -7.0, 0.0));
	block.var[2] = (vec3(1.0, -1.0, 6.0));
	block.var[3] = (vec3(-7.0, 7.0, 9.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(block.var, mat4x3(-5.0, -4.0, 6.0, 4.0, 7.0, 4.0, 0.0, 1.0, 2.0, -3.0, 0.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x3(-7.0, -4.0, 6.0, 8.0, -2.0, 2.0, -3.0, 9.0, 4.0, -4.0, 9.0, 0.0));
}
#version 450
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
	i8vec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(block.var), ivec3(4294967295, 4294967290, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = i8vec3(ivec3(4294967292, 0, 0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -4.0) && allOk;
	allOk = compare_float(block.var[0][1], -4.0) && allOk;
	allOk = compare_float(block.var[0][2], 5.0) && allOk;
	allOk = compare_float(block.var[0][3], 9.0) && allOk;
	allOk = compare_float(block.var[1][0], -7.0) && allOk;
	allOk = compare_float(block.var[1][1], -9.0) && allOk;
	allOk = compare_float(block.var[1][2], -2.0) && allOk;
	allOk = compare_float(block.var[1][3], -1.0) && allOk;
	allOk = compare_float(block.var[2][0], 8.0) && allOk;
	allOk = compare_float(block.var[2][1], 4.0) && allOk;
	allOk = compare_float(block.var[2][2], -5.0) && allOk;
	allOk = compare_float(block.var[2][3], 2.0) && allOk;
	allOk = compare_float(block.var[3][0], 8.0) && allOk;
	allOk = compare_float(block.var[3][1], -3.0) && allOk;
	allOk = compare_float(block.var[3][2], 7.0) && allOk;
	allOk = compare_float(block.var[3][3], -1.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-4.0, -4.0, 5.0, 9.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-7.0, -9.0, -2.0, -1.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(8.0, 4.0, -5.0, 2.0)) && allOk;
	allOk = compare_vec4(block.var[3], vec4(8.0, -3.0, 7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4(-6.0, -3.0, -6.0, -5.0, -2.0, 8.0, -6.0, -2.0, -6.0, 7.0, 0.0, -1.0, 4.0, -8.0, 7.0, -1.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var, mat2x3(-6.0, -1.0, -7.0, -3.0, -8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(7.0, -6.0, -6.0));
	block.var[1] = (vec3(-9.0, 5.0, 7.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var, mat3x2(-4.0, 7.0, 7.0, -6.0, -4.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x2(-5.0, 7.0, 6.0, 9.0, -6.0, 8.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var, mat3x2(-9.0, 2.0, 5.0, 9.0, -2.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(5.0, 6.0));
	block.var[1] = (vec2(9.0, -8.0));
	block.var[2] = (vec2(2.0, 3.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var, mat3x4(-4.0, -4.0, -9.0, 3.0, 1.0, 3.0, -7.0, 3.0, 6.0, 1.0, 2.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(2.0, -6.0, -2.0, -1.0));
	block.var[1] = (vec4(8.0, 9.0, 3.0, -1.0));
	block.var[2] = (vec4(5.0, -9.0, -9.0, 6.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 4.0) && allOk;
	allOk = compare_float(block.var[0][1], 4.0) && allOk;
	allOk = compare_float(block.var[1][0], 2.0) && allOk;
	allOk = compare_float(block.var[1][1], 4.0) && allOk;
	allOk = compare_float(block.var[2][0], 6.0) && allOk;
	allOk = compare_float(block.var[2][1], -4.0) && allOk;
	allOk = compare_float(block.var[3][0], -5.0) && allOk;
	allOk = compare_float(block.var[3][1], 0.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(4.0, 4.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(2.0, 4.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(6.0, -4.0)) && allOk;
	allOk = compare_vec2(block.var[3], vec2(-5.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(3.0, 5.0));
	block.var[1] = (vec2(-2.0, 7.0));
	block.var[2] = (vec2(-7.0, 3.0));
	block.var[3] = (vec2(4.0, -1.0));
}
#version 450
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
	allOk = compare_float((block.padding), 4.0) && allOk;
	allOk = compare_mat3x4(block.var, mat3x4(5.0, -8.0, -9.0, -9.0, 3.0, 9.0, 1.0, 7.0, 0.0, -9.0, -9.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (4.0);
	block.var = (mat3x4(-9.0, -4.0, -7.0, 1.0, -2.0, 9.0, 9.0, -9.0, 4.0, 4.0, -7.0, -7.0));
}
#version 450
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
	uint8_t var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(block.var), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = uint8_t(9u);
}
#version 450
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
	u16vec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(block.padding), 8u) && allOk;
	allOk = compare_u16vec2(uvec2(block.var), uvec2(4u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = uint16_t(8u);
	block.var = u16vec2(uvec2(0u, 6u));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0], mat2x3(5.0, 8.0, 4.0, -6.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[1], mat2x3(0.0, 0.0, 4.0, 3.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[2], mat2x3(-7.0, 2.0, -1.0, 5.0, 5.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2x3(-9.0, -3.0, 4.0, -1.0, 8.0, -5.0));
	block.var[1] = (mat2x3(-4.0, -8.0, -3.0, 1.0, -5.0, 6.0));
	block.var[2] = (mat2x3(0.0, 4.0, 6.0, 2.0, -1.0, -7.0));
}
#version 450
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
	u16vec4 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(block.var[0]), uvec4(6u, 0u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1]), uvec4(8u, 7u, 5u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2]), uvec4(8u, 7u, 1u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = u16vec4(uvec4(0u, 6u, 9u, 4u));
	block.var[1] = u16vec4(uvec4(5u, 0u, 1u, 0u));
	block.var[2] = u16vec4(uvec4(7u, 6u, 5u, 9u));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0], mat3x4(2.0, 9.0, 7.0, -5.0, 2.0, 3.0, 6.0, 6.0, 9.0, -9.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1], mat3x4(-4.0, 6.0, 9.0, 4.0, 9.0, 3.0, 2.0, -4.0, -7.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2], mat3x4(3.0, -5.0, 6.0, -3.0, 3.0, 2.0, 7.0, -3.0, -7.0, 0.0, 1.0, -9.0)) && allOk;
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
}
#version 450
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
	uint8_t var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(block.var[0]), 7u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1]), 1u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2]), 3u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = uint8_t(9u);
	block.var[1] = uint8_t(5u);
	block.var[2] = uint8_t(2u);
}
#version 450
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
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_mat2(block.var[0], mat2(7.0, 0.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(-3.0, 5.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(-9.0, -4.0, 8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (3.0);
	block.var[0] = (mat2(-4.0, -2.0, 1.0, 1.0));
	block.var[1] = (mat2(-1.0, -3.0, -4.0, -8.0));
	block.var[2] = (mat2(-6.0, -2.0, 5.0, 8.0));
}
#version 450
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
	allOk = compare_float((block.padding), -6.0) && allOk;
	allOk = compare_mat3x4(block.var[0], mat3x4(2.0, 7.0, -8.0, 9.0, -6.0, 1.0, 9.0, -9.0, 1.0, -3.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[1], mat3x4(-5.0, -5.0, 5.0, -5.0, -3.0, 2.0, 1.0, 2.0, 8.0, -3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2], mat3x4(7.0, -5.0, 5.0, 6.0, -3.0, 8.0, -1.0, -1.0, -1.0, -9.0, 8.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (0.0);
	block.var[0] = (mat3x4(0.0, -5.0, -3.0, -2.0, -8.0, -3.0, 0.0, -6.0, -6.0, 8.0, 5.0, 8.0));
	block.var[1] = (mat3x4(1.0, 7.0, 4.0, -7.0, -3.0, -4.0, 0.0, 6.0, 9.0, -2.0, 5.0, 8.0));
	block.var[2] = (mat3x4(-2.0, 7.0, 3.0, -8.0, -8.0, 5.0, -7.0, -9.0, 1.0, 9.0, -3.0, -9.0));
}
#version 450
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
	allOk = compare_float((block.padding), 0.0) && allOk;
	allOk = compare_mat4x3(block.var[0], mat4x3(1.0, -8.0, -1.0, 2.0, 8.0, 7.0, -7.0, 9.0, -3.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[1], mat4x3(2.0, 4.0, -2.0, -9.0, -6.0, 8.0, 9.0, 2.0, -2.0, 3.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[2], mat4x3(9.0, 2.0, -3.0, 3.0, 6.0, 6.0, 3.0, -3.0, -9.0, 4.0, 8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2.0);
	block.var[0] = (mat4x3(4.0, 9.0, -7.0, 5.0, -8.0, 9.0, 1.0, 9.0, -6.0, -6.0, 1.0, 6.0));
	block.var[1] = (mat4x3(-2.0, -2.0, 5.0, 3.0, -6.0, -8.0, -5.0, 9.0, 8.0, -2.0, -1.0, 1.0));
	block.var[2] = (mat4x3(7.0, 0.0, 5.0, 9.0, -6.0, 5.0, 6.0, 2.0, 3.0, -8.0, 7.0, 3.0));
}
#version 450
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
	i8vec4 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(block.var[0]), ivec4(4294967293, 4294967289, 4294967295, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1]), ivec4(5, 4294967288, 4294967292, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2]), ivec4(3, 3, 4294967290, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[3]), ivec4(4294967289, 4294967292, 4294967291, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[4]), ivec4(1, 4294967288, 8, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[5]), ivec4(0, 3, 4294967294, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[6]), ivec4(1, 4294967295, 4294967292, 6)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[7]), ivec4(4294967291, 5, 4294967289, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[8]), ivec4(7, 2, 2, 4)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[9]), ivec4(4294967295, 9, 4294967287, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[10]), ivec4(8, 4294967290, 4294967289, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[11]), ivec4(4294967293, 4294967288, 9, 2)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[12]), ivec4(4294967293, 4294967294, 4, 2)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[13]), ivec4(4294967289, 6, 8, 5)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[14]), ivec4(4294967290, 4294967289, 4294967295, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[15]), ivec4(4294967293, 4294967287, 4294967292, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[16]), ivec4(5, 4294967290, 4294967294, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[17]), ivec4(9, 3, 7, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[18]), ivec4(4294967287, 4294967291, 5, 4294967294)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = i8vec4(ivec4(4294967294, 4294967292, 4294967290, 4294967289));
	block.var[1] = i8vec4(ivec4(4294967291, 4294967291, 4, 4294967290));
	block.var[2] = i8vec4(ivec4(4294967295, 4294967287, 4294967293, 8));
	block.var[3] = i8vec4(ivec4(6, 4, 9, 4294967287));
	block.var[4] = i8vec4(ivec4(4294967295, 4294967292, 4294967287, 3));
	block.var[5] = i8vec4(ivec4(9, 4294967288, 4294967290, 4294967287));
	block.var[6] = i8vec4(ivec4(8, 5, 4, 5));
	block.var[7] = i8vec4(ivec4(5, 4294967289, 4294967287, 4294967294));
	block.var[8] = i8vec4(ivec4(4294967291, 4294967291, 4, 5));
	block.var[9] = i8vec4(ivec4(4294967293, 4294967294, 4294967289, 4294967291));
	block.var[10] = i8vec4(ivec4(2, 5, 4, 6));
	block.var[11] = i8vec4(ivec4(4294967292, 7, 8, 9));
	block.var[12] = i8vec4(ivec4(3, 4294967293, 4294967290, 4294967290));
	block.var[13] = i8vec4(ivec4(8, 4294967289, 4294967292, 2));
	block.var[14] = i8vec4(ivec4(4294967295, 9, 4294967295, 6));
	block.var[15] = i8vec4(ivec4(6, 4294967289, 4294967293, 4294967289));
	block.var[16] = i8vec4(ivec4(6, 7, 5, 5));
	block.var[17] = i8vec4(ivec4(4294967291, 4, 3, 4294967290));
	block.var[18] = i8vec4(ivec4(1, 0, 5, 0));
}
#version 450
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
	allOk = compare_mat2(block.var[0], mat2(3.0, 8.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(-3.0, 1.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(-5.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[3], mat2(-4.0, 5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[4], mat2(6.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[5], mat2(4.0, 8.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[6], mat2(9.0, 8.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[7], mat2(5.0, 0.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[8], mat2(-9.0, 7.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[9], mat2(3.0, 9.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[10], mat2(8.0, 8.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[11], mat2(-5.0, -3.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[12], mat2(4.0, -7.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[13], mat2(3.0, -5.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[14], mat2(-5.0, 8.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[15], mat2(-4.0, 2.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[16], mat2(5.0, -6.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[17], mat2(1.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[18], mat2(2.0, -1.0, -1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2(3.0, -6.0, 2.0, -8.0));
	block.var[1] = (mat2(2.0, -5.0, -3.0, 9.0));
	block.var[2] = (mat2(4.0, -9.0, -2.0, -6.0));
	block.var[3] = (mat2(-2.0, 4.0, -5.0, -1.0));
	block.var[4] = (mat2(3.0, 1.0, 6.0, 0.0));
	block.var[5] = (mat2(-2.0, -5.0, 2.0, 8.0));
	block.var[6] = (mat2(-2.0, -7.0, -8.0, 6.0));
	block.var[7] = (mat2(2.0, 3.0, -8.0, 4.0));
	block.var[8] = (mat2(7.0, -3.0, 8.0, -1.0));
	block.var[9] = (mat2(7.0, -8.0, 5.0, -2.0));
	block.var[10] = (mat2(-5.0, -2.0, -2.0, 1.0));
	block.var[11] = (mat2(6.0, 0.0, 1.0, 8.0));
	block.var[12] = (mat2(1.0, -2.0, -9.0, -7.0));
	block.var[13] = (mat2(2.0, 7.0, 5.0, -3.0));
	block.var[14] = (mat2(-2.0, -3.0, 3.0, -1.0));
	block.var[15] = (mat2(-2.0, -8.0, 1.0, -1.0));
	block.var[16] = (mat2(9.0, -2.0, -3.0, 6.0));
	block.var[17] = (mat2(2.0, 6.0, -4.0, -6.0));
	block.var[18] = (mat2(5.0, -6.0, 1.0, 5.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0], mat2x4(-7.0, 8.0, 3.0, -7.0, -7.0, -8.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(7.0, 3.0, -5.0, -7.0, 3.0, -9.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(3.0, 6.0, -4.0, 4.0, -2.0, 8.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[3], mat2x4(-8.0, -1.0, -1.0, -6.0, 2.0, -7.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[4], mat2x4(3.0, -9.0, 1.0, -9.0, 8.0, -7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[5], mat2x4(1.0, -1.0, 0.0, 7.0, 2.0, 5.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[6], mat2x4(2.0, 2.0, -8.0, 6.0, 0.0, -1.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[7], mat2x4(-4.0, -2.0, -4.0, -6.0, -3.0, -4.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[8], mat2x4(8.0, -7.0, 8.0, 8.0, 2.0, 3.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[9], mat2x4(9.0, 0.0, -4.0, -7.0, -7.0, 7.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[10], mat2x4(-3.0, -7.0, -5.0, -4.0, -1.0, -7.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[11], mat2x4(7.0, 0.0, -6.0, -2.0, 9.0, -7.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[12], mat2x4(9.0, -3.0, 5.0, -7.0, 2.0, -7.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[13], mat2x4(5.0, -1.0, 2.0, -6.0, -6.0, -7.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[14], mat2x4(-7.0, -8.0, -7.0, -5.0, 1.0, 3.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[15], mat2x4(-9.0, -4.0, 8.0, 5.0, 6.0, -3.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[16], mat2x4(-8.0, 2.0, 8.0, 5.0, -8.0, 1.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[17], mat2x4(-5.0, 2.0, 7.0, -3.0, 3.0, 9.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[18], mat2x4(6.0, 6.0, 2.0, -4.0, -3.0, 8.0, -4.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2x4(4.0, 9.0, 1.0, 2.0, 5.0, -4.0, -9.0, -9.0));
	block.var[1] = (mat2x4(5.0, -4.0, -4.0, 8.0, 5.0, -1.0, -3.0, -2.0));
	block.var[2] = (mat2x4(8.0, 2.0, 5.0, 4.0, 3.0, 1.0, -6.0, 2.0));
	block.var[3] = (mat2x4(-3.0, 4.0, 7.0, -8.0, -6.0, -3.0, -2.0, -9.0));
	block.var[4] = (mat2x4(-6.0, 7.0, 6.0, -2.0, 2.0, 7.0, 4.0, -7.0));
	block.var[5] = (mat2x4(-8.0, 4.0, 3.0, -6.0, -9.0, -3.0, 5.0, -6.0));
	block.var[6] = (mat2x4(-5.0, 8.0, 2.0, 0.0, -9.0, 1.0, -2.0, -6.0));
	block.var[7] = (mat2x4(0.0, 6.0, 7.0, -2.0, -1.0, -3.0, -3.0, -9.0));
	block.var[8] = (mat2x4(7.0, -5.0, 9.0, -1.0, -1.0, 9.0, 0.0, 7.0));
	block.var[9] = (mat2x4(6.0, -8.0, -2.0, 3.0, 1.0, -8.0, -4.0, -9.0));
	block.var[10] = (mat2x4(-7.0, 0.0, -8.0, -1.0, 5.0, 7.0, 7.0, -3.0));
	block.var[11] = (mat2x4(1.0, -9.0, 2.0, -9.0, -3.0, 0.0, -4.0, 5.0));
	block.var[12] = (mat2x4(8.0, -2.0, 7.0, -7.0, -4.0, 2.0, -4.0, 0.0));
	block.var[13] = (mat2x4(7.0, -5.0, 6.0, -6.0, -2.0, 2.0, -8.0, 5.0));
	block.var[14] = (mat2x4(6.0, 8.0, -2.0, 0.0, 7.0, 9.0, 1.0, -3.0));
	block.var[15] = (mat2x4(5.0, 2.0, 9.0, 1.0, -1.0, -6.0, -3.0, -3.0));
	block.var[16] = (mat2x4(7.0, 4.0, 1.0, -9.0, -9.0, 4.0, 0.0, 1.0));
	block.var[17] = (mat2x4(-8.0, 4.0, 7.0, -7.0, -4.0, -4.0, -4.0, 1.0));
	block.var[18] = (mat2x4(-9.0, 3.0, 6.0, -5.0, 6.0, 4.0, 8.0, -7.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0], mat2x4(-8.0, -3.0, 6.0, -5.0, 2.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(-2.0, 8.0, 0.0, 5.0, -6.0, 9.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(1.0, -1.0, -5.0, 4.0, -7.0, -3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[3], mat2x4(-3.0, -4.0, 0.0, 0.0, 9.0, -6.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[4], mat2x4(4.0, 5.0, 3.0, 4.0, 0.0, -1.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[5], mat2x4(1.0, 5.0, -8.0, -9.0, -5.0, -6.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[6], mat2x4(0.0, 8.0, -1.0, 5.0, -1.0, 4.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[7], mat2x4(5.0, 3.0, 2.0, 2.0, 0.0, -9.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[8], mat2x4(8.0, 0.0, -7.0, -9.0, -2.0, 5.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[9], mat2x4(9.0, -1.0, 4.0, -4.0, 9.0, 6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[10], mat2x4(0.0, 4.0, 7.0, 0.0, 5.0, 3.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[11], mat2x4(4.0, -4.0, -8.0, -7.0, 7.0, -8.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[12], mat2x4(1.0, 3.0, -2.0, -3.0, -6.0, 5.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[13], mat2x4(8.0, -1.0, 5.0, 7.0, -6.0, 1.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[14], mat2x4(-6.0, 4.0, 9.0, -5.0, -9.0, 7.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[15], mat2x4(-9.0, 8.0, -3.0, 8.0, -9.0, -6.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[16], mat2x4(-6.0, -1.0, -6.0, -5.0, -3.0, -1.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[17], mat2x4(-1.0, -8.0, -4.0, 8.0, -6.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[18], mat2x4(-4.0, 9.0, 9.0, 0.0, 9.0, -4.0, -1.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2x4(-2.0, 3.0, 2.0, -4.0, 2.0, -2.0, 9.0, -4.0));
	block.var[1] = (mat2x4(0.0, 7.0, 4.0, -8.0, 6.0, 0.0, -1.0, -8.0));
	block.var[2] = (mat2x4(2.0, 8.0, 2.0, 4.0, 5.0, 4.0, -3.0, 4.0));
	block.var[3] = (mat2x4(-6.0, 1.0, 7.0, -9.0, 7.0, -5.0, -1.0, -8.0));
	block.var[4] = (mat2x4(-2.0, -6.0, -6.0, 6.0, 6.0, -7.0, 6.0, 9.0));
	block.var[5] = (mat2x4(3.0, 9.0, 4.0, -6.0, 7.0, -1.0, 9.0, 5.0));
	block.var[6] = (mat2x4(-7.0, 0.0, -8.0, 2.0, -6.0, -5.0, 9.0, 2.0));
	block.var[7] = (mat2x4(2.0, 3.0, 4.0, 6.0, -7.0, -3.0, 5.0, 2.0));
	block.var[8] = (mat2x4(4.0, 2.0, 8.0, -5.0, -9.0, -1.0, 6.0, -2.0));
	block.var[9] = (mat2x4(4.0, 1.0, -1.0, -1.0, 7.0, 0.0, 6.0, 9.0));
	block.var[10] = (mat2x4(5.0, 9.0, -6.0, -6.0, -2.0, -9.0, 9.0, 3.0));
	block.var[11] = (mat2x4(2.0, 4.0, -3.0, 6.0, 6.0, 9.0, 1.0, 5.0));
	block.var[12] = (mat2x4(1.0, -7.0, -5.0, 8.0, 7.0, 5.0, -9.0, 8.0));
	block.var[13] = (mat2x4(-9.0, -3.0, 4.0, 1.0, 7.0, 5.0, -2.0, 7.0));
	block.var[14] = (mat2x4(5.0, 2.0, 3.0, -3.0, -1.0, 8.0, 4.0, -9.0));
	block.var[15] = (mat2x4(2.0, 5.0, 5.0, -9.0, -7.0, 9.0, 4.0, -1.0));
	block.var[16] = (mat2x4(7.0, 7.0, -4.0, 6.0, 0.0, -9.0, 5.0, -7.0));
	block.var[17] = (mat2x4(-4.0, 5.0, -1.0, 5.0, 8.0, -2.0, -5.0, 5.0));
	block.var[18] = (mat2x4(8.0, 2.0, 5.0, 5.0, 6.0, -6.0, 6.0, -3.0));
}
#version 450
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
	highp vec2 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((block.var[0][0]), vec2(5.0, 4.0)) && allOk;
	allOk = compare_vec2((block.var[0][1]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((block.var[0][2]), vec2(-7.0, -5.0)) && allOk;
	allOk = compare_vec2((block.var[1][0]), vec2(-9.0, 7.0)) && allOk;
	allOk = compare_vec2((block.var[1][1]), vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec2((block.var[1][2]), vec2(-8.0, 2.0)) && allOk;
	allOk = compare_vec2((block.var[2][0]), vec2(4.0, -2.0)) && allOk;
	allOk = compare_vec2((block.var[2][1]), vec2(2.0, 2.0)) && allOk;
	allOk = compare_vec2((block.var[2][2]), vec2(-8.0, 3.0)) && allOk;
	allOk = compare_vec2((block.var[3][0]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((block.var[3][1]), vec2(7.0, 5.0)) && allOk;
	allOk = compare_vec2((block.var[3][2]), vec2(-6.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec2(3.0, 8.0));
	block.var[0][1] = (vec2(7.0, -1.0));
	block.var[0][2] = (vec2(-4.0, 8.0));
	block.var[1][0] = (vec2(-2.0, -5.0));
	block.var[1][1] = (vec2(-2.0, 5.0));
	block.var[1][2] = (vec2(6.0, -2.0));
	block.var[2][0] = (vec2(-6.0, -6.0));
	block.var[2][1] = (vec2(1.0, 6.0));
	block.var[2][2] = (vec2(-7.0, 6.0));
	block.var[3][0] = (vec2(1.0, -6.0));
	block.var[3][1] = (vec2(-9.0, 0.0));
	block.var[3][2] = (vec2(-8.0, -4.0));
}
#version 450
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
	bvec2 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((block.var[0][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[0][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[0][2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[1][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[1][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[1][2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((block.var[2][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[2][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[2][2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[3][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[3][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[3][2]), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (bvec2(true, false));
	block.var[0][1] = (bvec2(true, true));
	block.var[0][2] = (bvec2(false, false));
	block.var[1][0] = (bvec2(false, false));
	block.var[1][1] = (bvec2(false, true));
	block.var[1][2] = (bvec2(true, true));
	block.var[2][0] = (bvec2(false, false));
	block.var[2][1] = (bvec2(false, true));
	block.var[2][2] = (bvec2(true, true));
	block.var[3][0] = (bvec2(false, false));
	block.var[3][1] = (bvec2(true, false));
	block.var[3][2] = (bvec2(true, false));
}
#version 450
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
	allOk = compare_mat3(block.var[0][0], mat3(-6.0, 3.0, -6.0, -8.0, -3.0, -9.0, -1.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[0][1], mat3(-4.0, 5.0, 8.0, 1.0, 3.0, 0.0, -1.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[0][2], mat3(9.0, 4.0, 0.0, 1.0, -7.0, 1.0, 3.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[1][0], mat3(-2.0, -2.0, 5.0, 7.0, -9.0, -1.0, 5.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[1][1], mat3(7.0, 3.0, -6.0, 3.0, 0.0, 1.0, 6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[1][2], mat3(-7.0, 6.0, -6.0, 9.0, -3.0, 2.0, 4.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[2][0], mat3(6.0, 3.0, 3.0, 5.0, 7.0, -9.0, 3.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[2][1], mat3(7.0, 3.0, 7.0, 3.0, 4.0, -7.0, 5.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[2][2], mat3(-5.0, 0.0, 3.0, -9.0, -4.0, 5.0, 3.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[3][0], mat3(0.0, 7.0, 7.0, 1.0, -5.0, 4.0, 2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[3][1], mat3(-5.0, -9.0, 2.0, 7.0, 8.0, 5.0, 7.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[3][2], mat3(8.0, -3.0, 8.0, 9.0, -5.0, 8.0, -5.0, -9.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec3(8.0, 3.0, 9.0));
	block.var[0][0][1] = (vec3(6.0, 2.0, -9.0));
	block.var[0][0][2] = (vec3(-8.0, 5.0, 2.0));
	block.var[0][1][0] = (vec3(3.0, -3.0, -4.0));
	block.var[0][1][1] = (vec3(2.0, -9.0, -5.0));
	block.var[0][1][2] = (vec3(5.0, 8.0, 8.0));
	block.var[0][2][0] = (vec3(-5.0, -3.0, -3.0));
	block.var[0][2][1] = (vec3(3.0, -5.0, -4.0));
	block.var[0][2][2] = (vec3(-7.0, 5.0, 3.0));
	block.var[1][0][0] = (vec3(-8.0, 7.0, 8.0));
	block.var[1][0][1] = (vec3(8.0, 2.0, -9.0));
	block.var[1][0][2] = (vec3(-3.0, 6.0, -3.0));
	block.var[1][1][0] = (vec3(7.0, -3.0, 6.0));
	block.var[1][1][1] = (vec3(-7.0, 6.0, -7.0));
	block.var[1][1][2] = (vec3(2.0, 3.0, -3.0));
	block.var[1][2][0] = (vec3(-1.0, -5.0, -1.0));
	block.var[1][2][1] = (vec3(8.0, 4.0, -3.0));
	block.var[1][2][2] = (vec3(8.0, -6.0, 4.0));
	block.var[2][0][0] = (vec3(5.0, 9.0, -7.0));
	block.var[2][0][1] = (vec3(1.0, -3.0, -7.0));
	block.var[2][0][2] = (vec3(-5.0, 4.0, 1.0));
	block.var[2][1][0] = (vec3(-3.0, -5.0, -8.0));
	block.var[2][1][1] = (vec3(-5.0, 6.0, 2.0));
	block.var[2][1][2] = (vec3(-9.0, -9.0, -1.0));
	block.var[2][2][0] = (vec3(2.0, 8.0, -8.0));
	block.var[2][2][1] = (vec3(-6.0, 0.0, 3.0));
	block.var[2][2][2] = (vec3(9.0, -8.0, 3.0));
	block.var[3][0][0] = (vec3(-9.0, 9.0, 2.0));
	block.var[3][0][1] = (vec3(6.0, -4.0, -8.0));
	block.var[3][0][2] = (vec3(3.0, 8.0, 1.0));
	block.var[3][1][0] = (vec3(-9.0, -5.0, -7.0));
	block.var[3][1][1] = (vec3(-4.0, -1.0, -4.0));
	block.var[3][1][2] = (vec3(-6.0, 4.0, 9.0));
	block.var[3][2][0] = (vec3(-3.0, -9.0, 0.0));
	block.var[3][2][1] = (vec3(-9.0, -5.0, -9.0));
	block.var[3][2][2] = (vec3(-1.0, -9.0, 7.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0], mat4x2(-7.0, 1.0, 9.0, 3.0, -9.0, -1.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1], mat4x2(-9.0, 6.0, 5.0, -8.0, 8.0, 9.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2], mat4x2(4.0, 1.0, -1.0, -5.0, 5.0, -9.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0], mat4x2(-2.0, -2.0, -9.0, -2.0, -2.0, 8.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1], mat4x2(-8.0, 6.0, -4.0, 7.0, 2.0, 3.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2], mat4x2(7.0, 3.0, 5.0, -2.0, 7.0, 1.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0], mat4x2(-5.0, -9.0, 1.0, -6.0, 3.0, -3.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1], mat4x2(4.0, -4.0, -1.0, 4.0, 0.0, -4.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2], mat4x2(-7.0, 4.0, 5.0, 4.0, -5.0, 8.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0], mat4x2(-7.0, 5.0, -2.0, -3.0, 7.0, 4.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1], mat4x2(-4.0, 7.0, 2.0, 3.0, -7.0, -8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][2], mat4x2(-1.0, -8.0, -8.0, 4.0, 6.0, 8.0, -2.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec2(6.0, -2.0));
	block.var[0][0][1] = (vec2(2.0, 8.0));
	block.var[0][0][2] = (vec2(-5.0, 3.0));
	block.var[0][0][3] = (vec2(-1.0, -7.0));
	block.var[0][1][0] = (vec2(4.0, 2.0));
	block.var[0][1][1] = (vec2(-4.0, 8.0));
	block.var[0][1][2] = (vec2(3.0, 8.0));
	block.var[0][1][3] = (vec2(-1.0, 6.0));
	block.var[0][2][0] = (vec2(-8.0, 2.0));
	block.var[0][2][1] = (vec2(-5.0, 5.0));
	block.var[0][2][2] = (vec2(-4.0, -9.0));
	block.var[0][2][3] = (vec2(0.0, 4.0));
	block.var[1][0][0] = (vec2(8.0, 2.0));
	block.var[1][0][1] = (vec2(-3.0, 2.0));
	block.var[1][0][2] = (vec2(-4.0, -4.0));
	block.var[1][0][3] = (vec2(2.0, -8.0));
	block.var[1][1][0] = (vec2(-4.0, 8.0));
	block.var[1][1][1] = (vec2(5.0, 7.0));
	block.var[1][1][2] = (vec2(-4.0, 6.0));
	block.var[1][1][3] = (vec2(8.0, 4.0));
	block.var[1][2][0] = (vec2(-9.0, -7.0));
	block.var[1][2][1] = (vec2(7.0, -5.0));
	block.var[1][2][2] = (vec2(1.0, -9.0));
	block.var[1][2][3] = (vec2(9.0, 5.0));
	block.var[2][0][0] = (vec2(7.0, 3.0));
	block.var[2][0][1] = (vec2(3.0, 3.0));
	block.var[2][0][2] = (vec2(-5.0, -9.0));
	block.var[2][0][3] = (vec2(2.0, 9.0));
	block.var[2][1][0] = (vec2(3.0, 8.0));
	block.var[2][1][1] = (vec2(3.0, -4.0));
	block.var[2][1][2] = (vec2(6.0, 1.0));
	block.var[2][1][3] = (vec2(-3.0, 1.0));
	block.var[2][2][0] = (vec2(-5.0, -2.0));
	block.var[2][2][1] = (vec2(7.0, 8.0));
	block.var[2][2][2] = (vec2(4.0, 7.0));
	block.var[2][2][3] = (vec2(-1.0, -8.0));
	block.var[3][0][0] = (vec2(-6.0, -6.0));
	block.var[3][0][1] = (vec2(-4.0, -2.0));
	block.var[3][0][2] = (vec2(3.0, 8.0));
	block.var[3][0][3] = (vec2(4.0, 4.0));
	block.var[3][1][0] = (vec2(-7.0, -6.0));
	block.var[3][1][1] = (vec2(8.0, -6.0));
	block.var[3][1][2] = (vec2(8.0, -3.0));
	block.var[3][1][3] = (vec2(-7.0, 0.0));
	block.var[3][2][0] = (vec2(-9.0, 2.0));
	block.var[3][2][1] = (vec2(-9.0, 7.0));
	block.var[3][2][2] = (vec2(-2.0, 2.0));
	block.var[3][2][3] = (vec2(-6.0, -1.0));
}
#version 450
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
	float16_t var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(block.padding), -7.0) && allOk;
	allOk = compare_float16_t(float(block.var[0][0]), 4.0) && allOk;
	allOk = compare_float16_t(float(block.var[0][1]), 2.0) && allOk;
	allOk = compare_float16_t(float(block.var[0][2]), 0.0) && allOk;
	allOk = compare_float16_t(float(block.var[1][0]), 5.0) && allOk;
	allOk = compare_float16_t(float(block.var[1][1]), 9.0) && allOk;
	allOk = compare_float16_t(float(block.var[1][2]), 5.0) && allOk;
	allOk = compare_float16_t(float(block.var[2][0]), 4.0) && allOk;
	allOk = compare_float16_t(float(block.var[2][1]), 7.0) && allOk;
	allOk = compare_float16_t(float(block.var[2][2]), 5.0) && allOk;
	allOk = compare_float16_t(float(block.var[3][0]), 1.0) && allOk;
	allOk = compare_float16_t(float(block.var[3][1]), -3.0) && allOk;
	allOk = compare_float16_t(float(block.var[3][2]), 2.0) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = float16_t(-8.0);
	block.var[0][0] = float16_t(9.0);
	block.var[0][1] = float16_t(-2.0);
	block.var[0][2] = float16_t(7.0);
	block.var[1][0] = float16_t(8.0);
	block.var[1][1] = float16_t(-9.0);
	block.var[1][2] = float16_t(2.0);
	block.var[2][0] = float16_t(-8.0);
	block.var[2][1] = float16_t(-1.0);
	block.var[2][2] = float16_t(6.0);
	block.var[3][0] = float16_t(-7.0);
	block.var[3][1] = float16_t(-5.0);
	block.var[3][2] = float16_t(8.0);
}
#version 450
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
	highp mat2x3 var[4][2][3];
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
	allOk = compare_mat2x3(block.var[0][0][0], mat2x3(-2.0, 0.0, -9.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][1], mat2x3(-3.0, -1.0, -3.0, -1.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][2], mat2x3(9.0, 9.0, 0.0, 0.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][0], mat2x3(1.0, -3.0, -1.0, -4.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][1], mat2x3(-2.0, 8.0, 1.0, 6.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][2], mat2x3(2.0, 5.0, 0.0, -6.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][0], mat2x3(-6.0, 8.0, -3.0, 7.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][1], mat2x3(6.0, -2.0, -7.0, -8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][2], mat2x3(7.0, -3.0, 2.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][0], mat2x3(9.0, 7.0, -7.0, 4.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][1], mat2x3(3.0, 7.0, 0.0, -3.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][2], mat2x3(9.0, 5.0, -9.0, 3.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][0], mat2x3(7.0, -9.0, 0.0, -9.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][1], mat2x3(5.0, 3.0, 9.0, 1.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][2], mat2x3(5.0, -3.0, 6.0, 8.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][0], mat2x3(-3.0, -8.0, -3.0, 7.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][1], mat2x3(9.0, 0.0, 2.0, 6.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][2], mat2x3(4.0, 6.0, 0.0, 9.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][0], mat2x3(9.0, 5.0, 6.0, 7.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][1], mat2x3(1.0, 9.0, 5.0, 1.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][2], mat2x3(1.0, 6.0, -5.0, 7.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][0], mat2x3(9.0, 6.0, -6.0, -7.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][1], mat2x3(9.0, 2.0, -4.0, -6.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][2], mat2x3(7.0, -7.0, 9.0, 2.0, -8.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec3(0.0, 5.0, 5.0));
	block.var[0][0][0][1] = (vec3(0.0, -7.0, 8.0));
	block.var[0][0][1][0] = (vec3(-7.0, -4.0, 6.0));
	block.var[0][0][1][1] = (vec3(1.0, 3.0, 2.0));
	block.var[0][0][2][0] = (vec3(-6.0, 5.0, 2.0));
	block.var[0][0][2][1] = (vec3(1.0, 8.0, -8.0));
	block.var[0][1][0][0] = (vec3(8.0, 7.0, -1.0));
	block.var[0][1][0][1] = (vec3(-6.0, 1.0, -2.0));
	block.var[0][1][1][0] = (vec3(8.0, -6.0, -8.0));
	block.var[0][1][1][1] = (vec3(9.0, -5.0, 5.0));
	block.var[0][1][2][0] = (vec3(-8.0, 1.0, -3.0));
	block.var[0][1][2][1] = (vec3(-4.0, -5.0, 1.0));
	block.var[1][0][0][0] = (vec3(2.0, -7.0, 5.0));
	block.var[1][0][0][1] = (vec3(-4.0, -6.0, -9.0));
	block.var[1][0][1][0] = (vec3(3.0, 0.0, -7.0));
	block.var[1][0][1][1] = (vec3(2.0, -4.0, 1.0));
	block.var[1][0][2][0] = (vec3(-2.0, -2.0, -5.0));
	block.var[1][0][2][1] = (vec3(2.0, 5.0, 4.0));
	block.var[1][1][0][0] = (vec3(4.0, -2.0, -5.0));
	block.var[1][1][0][1] = (vec3(-9.0, -8.0, -5.0));
	block.var[1][1][1][0] = (vec3(5.0, 9.0, 6.0));
	block.var[1][1][1][1] = (vec3(7.0, 5.0, 7.0));
	block.var[1][1][2][0] = (vec3(0.0, 9.0, -4.0));
	block.var[1][1][2][1] = (vec3(7.0, -3.0, 7.0));
	block.var[2][0][0][0] = (vec3(4.0, -1.0, 7.0));
	block.var[2][0][0][1] = (vec3(9.0, -2.0, -4.0));
	block.var[2][0][1][0] = (vec3(8.0, -4.0, 2.0));
	block.var[2][0][1][1] = (vec3(5.0, -1.0, -3.0));
	block.var[2][0][2][0] = (vec3(3.0, -2.0, -8.0));
	block.var[2][0][2][1] = (vec3(6.0, 0.0, 9.0));
	block.var[2][1][0][0] = (vec3(5.0, -5.0, 1.0));
	block.var[2][1][0][1] = (vec3(9.0, 2.0, -6.0));
	block.var[2][1][1][0] = (vec3(-1.0, -6.0, 5.0));
	block.var[2][1][1][1] = (vec3(8.0, -5.0, -8.0));
	block.var[2][1][2][0] = (vec3(-6.0, -6.0, 5.0));
	block.var[2][1][2][1] = (vec3(-4.0, 8.0, -9.0));
	block.var[3][0][0][0] = (vec3(1.0, -5.0, -1.0));
	block.var[3][0][0][1] = (vec3(-6.0, -6.0, 3.0));
	block.var[3][0][1][0] = (vec3(1.0, -8.0, -5.0));
	block.var[3][0][1][1] = (vec3(8.0, 5.0, 8.0));
	block.var[3][0][2][0] = (vec3(5.0, 5.0, 7.0));
	block.var[3][0][2][1] = (vec3(-9.0, 8.0, 0.0));
	block.var[3][1][0][0] = (vec3(0.0, 5.0, -4.0));
	block.var[3][1][0][1] = (vec3(5.0, 2.0, 5.0));
	block.var[3][1][1][0] = (vec3(-4.0, 5.0, 5.0));
	block.var[3][1][1][1] = (vec3(-4.0, 4.0, 8.0));
	block.var[3][1][2][0] = (vec3(2.0, 8.0, 3.0));
	block.var[3][1][2][1] = (vec3(-1.0, -1.0, 6.0));
}
#version 450
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
	bvec4 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((block.padding), true) && allOk;
	allOk = compare_bvec4((block.var[0][0][0]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((block.var[0][0][1]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec4((block.var[0][0][2]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((block.var[0][1][0]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((block.var[0][1][1]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((block.var[0][1][2]), bvec4(false, true, false, false)) && allOk;
	allOk = compare_bvec4((block.var[1][0][0]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((block.var[1][0][1]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((block.var[1][0][2]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((block.var[1][1][0]), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec4((block.var[1][1][1]), bvec4(false, true, false, false)) && allOk;
	allOk = compare_bvec4((block.var[1][1][2]), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bvec4((block.var[2][0][0]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((block.var[2][0][1]), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bvec4((block.var[2][0][2]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((block.var[2][1][0]), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec4((block.var[2][1][1]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((block.var[2][1][2]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec4((block.var[3][0][0]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec4((block.var[3][0][1]), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bvec4((block.var[3][0][2]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec4((block.var[3][1][0]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((block.var[3][1][1]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((block.var[3][1][2]), bvec4(true, true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (true);
	block.var[0][0][0] = (bvec4(true, true, false, true));
	block.var[0][0][1] = (bvec4(false, false, false, false));
	block.var[0][0][2] = (bvec4(true, true, true, true));
	block.var[0][1][0] = (bvec4(true, false, true, true));
	block.var[0][1][1] = (bvec4(true, true, false, false));
	block.var[0][1][2] = (bvec4(true, false, false, true));
	block.var[1][0][0] = (bvec4(true, true, false, true));
	block.var[1][0][1] = (bvec4(false, true, false, true));
	block.var[1][0][2] = (bvec4(false, false, true, false));
	block.var[1][1][0] = (bvec4(false, false, true, true));
	block.var[1][1][1] = (bvec4(true, true, false, true));
	block.var[1][1][2] = (bvec4(false, false, false, false));
	block.var[2][0][0] = (bvec4(true, true, false, true));
	block.var[2][0][1] = (bvec4(true, true, false, false));
	block.var[2][0][2] = (bvec4(false, true, true, true));
	block.var[2][1][0] = (bvec4(false, true, true, false));
	block.var[2][1][1] = (bvec4(false, true, false, true));
	block.var[2][1][2] = (bvec4(false, false, true, true));
	block.var[3][0][0] = (bvec4(false, true, false, true));
	block.var[3][0][1] = (bvec4(true, true, true, false));
	block.var[3][0][2] = (bvec4(true, false, true, false));
	block.var[3][1][0] = (bvec4(false, true, false, false));
	block.var[3][1][1] = (bvec4(true, false, true, false));
	block.var[3][1][2] = (bvec4(true, true, true, true));
}
#version 450
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
	i16vec3 var[4][2][3];
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
	allOk = compare_i16vec3(ivec3(block.var[0][0][0]), ivec3(4, 8, 7)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[0][0][1]), ivec3(-4, 0, 6)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[0][0][2]), ivec3(-5, -9, 9)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[0][1][0]), ivec3(-2, -7, -6)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[0][1][1]), ivec3(6, -1, -4)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[0][1][2]), ivec3(-6, -9, -5)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[1][0][0]), ivec3(4, 2, -6)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[1][0][1]), ivec3(6, -2, 2)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[1][0][2]), ivec3(-1, 0, -1)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[1][1][0]), ivec3(-9, -4, 7)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[1][1][1]), ivec3(-7, -2, 2)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[1][1][2]), ivec3(6, 2, -6)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[2][0][0]), ivec3(-4, -8, 2)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[2][0][1]), ivec3(-8, 6, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[2][0][2]), ivec3(-3, 3, -6)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[2][1][0]), ivec3(2, 1, -4)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[2][1][1]), ivec3(3, 0, -1)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[2][1][2]), ivec3(4, -7, 2)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[3][0][0]), ivec3(0, -1, 5)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[3][0][1]), ivec3(1, 0, 8)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[3][0][2]), ivec3(5, 1, 6)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[3][1][0]), ivec3(8, -9, -8)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[3][1][1]), ivec3(-6, -7, 7)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[3][1][2]), ivec3(-5, 5, -3)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = int16_t(6);
	block.var[0][0][0] = i16vec3(ivec3(1, -2, -3));
	block.var[0][0][1] = i16vec3(ivec3(-1, -4, -2));
	block.var[0][0][2] = i16vec3(ivec3(-2, 2, 0));
	block.var[0][1][0] = i16vec3(ivec3(7, -4, -8));
	block.var[0][1][1] = i16vec3(ivec3(4, 1, 5));
	block.var[0][1][2] = i16vec3(ivec3(-4, -6, -6));
	block.var[1][0][0] = i16vec3(ivec3(-6, -2, 0));
	block.var[1][0][1] = i16vec3(ivec3(-9, 2, -8));
	block.var[1][0][2] = i16vec3(ivec3(6, 2, -5));
	block.var[1][1][0] = i16vec3(ivec3(2, -7, -2));
	block.var[1][1][1] = i16vec3(ivec3(2, -5, -3));
	block.var[1][1][2] = i16vec3(ivec3(-1, 0, -6));
	block.var[2][0][0] = i16vec3(ivec3(-4, -8, 0));
	block.var[2][0][1] = i16vec3(ivec3(9, 6, 5));
	block.var[2][0][2] = i16vec3(ivec3(-3, 4, -3));
	block.var[2][1][0] = i16vec3(ivec3(9, -3, 6));
	block.var[2][1][1] = i16vec3(ivec3(8, 2, 7));
	block.var[2][1][2] = i16vec3(ivec3(-2, 2, 5));
	block.var[3][0][0] = i16vec3(ivec3(9, 0, 1));
	block.var[3][0][1] = i16vec3(ivec3(-5, 8, -5));
	block.var[3][0][2] = i16vec3(ivec3(0, 7, -6));
	block.var[3][1][0] = i16vec3(ivec3(-9, -7, 4));
	block.var[3][1][1] = i16vec3(ivec3(-3, -4, -6));
	block.var[3][1][2] = i16vec3(ivec3(-4, -6, -4));
}
#version 450
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
	int16_t var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(block.var[0][0][0]), -5) && allOk;
	allOk = compare_int16_t(int(block.var[0][0][1]), 1) && allOk;
	allOk = compare_int16_t(int(block.var[0][1][0]), -8) && allOk;
	allOk = compare_int16_t(int(block.var[0][1][1]), 6) && allOk;
	allOk = compare_int16_t(int(block.var[0][2][0]), 9) && allOk;
	allOk = compare_int16_t(int(block.var[0][2][1]), 5) && allOk;
	allOk = compare_int16_t(int(block.var[0][3][0]), 1) && allOk;
	allOk = compare_int16_t(int(block.var[0][3][1]), -9) && allOk;
	allOk = compare_int16_t(int(block.var[1][0][0]), 8) && allOk;
	allOk = compare_int16_t(int(block.var[1][0][1]), -2) && allOk;
	allOk = compare_int16_t(int(block.var[1][1][0]), 3) && allOk;
	allOk = compare_int16_t(int(block.var[1][1][1]), -8) && allOk;
	allOk = compare_int16_t(int(block.var[1][2][0]), 9) && allOk;
	allOk = compare_int16_t(int(block.var[1][2][1]), -3) && allOk;
	allOk = compare_int16_t(int(block.var[1][3][0]), -7) && allOk;
	allOk = compare_int16_t(int(block.var[1][3][1]), 8) && allOk;
	allOk = compare_int16_t(int(block.var[2][0][0]), 9) && allOk;
	allOk = compare_int16_t(int(block.var[2][0][1]), -5) && allOk;
	allOk = compare_int16_t(int(block.var[2][1][0]), 6) && allOk;
	allOk = compare_int16_t(int(block.var[2][1][1]), -7) && allOk;
	allOk = compare_int16_t(int(block.var[2][2][0]), -1) && allOk;
	allOk = compare_int16_t(int(block.var[2][2][1]), -2) && allOk;
	allOk = compare_int16_t(int(block.var[2][3][0]), 8) && allOk;
	allOk = compare_int16_t(int(block.var[2][3][1]), 0) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = int16_t(6);
	block.var[0][0][1] = int16_t(8);
	block.var[0][1][0] = int16_t(-5);
	block.var[0][1][1] = int16_t(-8);
	block.var[0][2][0] = int16_t(3);
	block.var[0][2][1] = int16_t(9);
	block.var[0][3][0] = int16_t(7);
	block.var[0][3][1] = int16_t(7);
	block.var[1][0][0] = int16_t(-2);
	block.var[1][0][1] = int16_t(-4);
	block.var[1][1][0] = int16_t(-3);
	block.var[1][1][1] = int16_t(2);
	block.var[1][2][0] = int16_t(6);
	block.var[1][2][1] = int16_t(2);
	block.var[1][3][0] = int16_t(1);
	block.var[1][3][1] = int16_t(-9);
	block.var[2][0][0] = int16_t(-3);
	block.var[2][0][1] = int16_t(9);
	block.var[2][1][0] = int16_t(-1);
	block.var[2][1][1] = int16_t(4);
	block.var[2][2][0] = int16_t(3);
	block.var[2][2][1] = int16_t(7);
	block.var[2][3][0] = int16_t(-3);
	block.var[2][3][1] = int16_t(0);
}
#version 450
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
	bvec4 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((block.var[0][0][0]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((block.var[0][0][1]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((block.var[0][1][0]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((block.var[0][1][1]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((block.var[0][2][0]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((block.var[0][2][1]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((block.var[0][3][0]), bvec4(false, true, false, false)) && allOk;
	allOk = compare_bvec4((block.var[0][3][1]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((block.var[1][0][0]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((block.var[1][0][1]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((block.var[1][1][0]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((block.var[1][1][1]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((block.var[1][2][0]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((block.var[1][2][1]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((block.var[1][3][0]), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bvec4((block.var[1][3][1]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec4((block.var[2][0][0]), bvec4(false, false, true, true)) && allOk;
	allOk = compare_bvec4((block.var[2][0][1]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec4((block.var[2][1][0]), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec4((block.var[2][1][1]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((block.var[2][2][0]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((block.var[2][2][1]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((block.var[2][3][0]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((block.var[2][3][1]), bvec4(true, true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (bvec4(true, true, true, false));
	block.var[0][0][1] = (bvec4(true, false, false, false));
	block.var[0][1][0] = (bvec4(false, true, true, false));
	block.var[0][1][1] = (bvec4(true, true, true, false));
	block.var[0][2][0] = (bvec4(false, true, false, true));
	block.var[0][2][1] = (bvec4(true, true, true, false));
	block.var[0][3][0] = (bvec4(false, false, true, true));
	block.var[0][3][1] = (bvec4(false, false, true, false));
	block.var[1][0][0] = (bvec4(false, true, true, true));
	block.var[1][0][1] = (bvec4(true, true, true, false));
	block.var[1][1][0] = (bvec4(false, false, true, true));
	block.var[1][1][1] = (bvec4(true, false, true, false));
	block.var[1][2][0] = (bvec4(false, true, false, false));
	block.var[1][2][1] = (bvec4(true, false, false, true));
	block.var[1][3][0] = (bvec4(true, false, false, true));
	block.var[1][3][1] = (bvec4(true, false, true, false));
	block.var[2][0][0] = (bvec4(true, false, true, false));
	block.var[2][0][1] = (bvec4(true, false, false, true));
	block.var[2][1][0] = (bvec4(true, true, true, true));
	block.var[2][1][1] = (bvec4(false, true, false, true));
	block.var[2][2][0] = (bvec4(true, true, true, false));
	block.var[2][2][1] = (bvec4(true, false, false, false));
	block.var[2][3][0] = (bvec4(false, true, false, true));
	block.var[2][3][1] = (bvec4(false, true, true, true));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(-2.0, 4.0, 3.0, 6.0, 3.0, -7.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(6.0, 4.0, 0.0, 9.0, -2.0, 9.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(-9.0, -1.0, 5.0, -7.0, -9.0, -6.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(1.0, 2.0, -6.0, 1.0, -5.0, 3.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2][0], mat2x4(6.0, 0.0, 6.0, 8.0, -9.0, 4.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2][1], mat2x4(-9.0, -1.0, 7.0, 9.0, 0.0, -2.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][3][0], mat2x4(9.0, -3.0, -7.0, 2.0, -4.0, -3.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][3][1], mat2x4(1.0, -8.0, -2.0, 6.0, 8.0, 9.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(1.0, -7.0, 0.0, 6.0, -6.0, 9.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(9.0, -9.0, 3.0, -1.0, -8.0, -5.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(-8.0, 1.0, -5.0, 0.0, 7.0, 5.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(-7.0, -6.0, 2.0, 4.0, -8.0, 4.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2][0], mat2x4(-8.0, 4.0, 8.0, 3.0, -3.0, -8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2][1], mat2x4(-9.0, 6.0, -4.0, -8.0, -5.0, -4.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][3][0], mat2x4(-7.0, 3.0, 5.0, -3.0, -6.0, 8.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][3][1], mat2x4(-6.0, -9.0, 7.0, 2.0, -1.0, 5.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(6.0, -4.0, -5.0, -3.0, -7.0, 1.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(0.0, -5.0, 1.0, 2.0, 7.0, 2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(-5.0, -2.0, -6.0, -2.0, -6.0, 1.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(2.0, -3.0, -2.0, 4.0, 6.0, -7.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2][0], mat2x4(-8.0, 0.0, 4.0, -6.0, 5.0, 2.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2][1], mat2x4(-1.0, -2.0, 0.0, -7.0, 8.0, -2.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][3][0], mat2x4(4.0, 2.0, 9.0, -9.0, -1.0, 9.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][3][1], mat2x4(7.0, 8.0, 4.0, -3.0, 7.0, 5.0, 2.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2x4(-5.0, -7.0, -7.0, 0.0, -1.0, -9.0, 5.0, -5.0));
	block.var[0][0][1] = (mat2x4(0.0, 1.0, 8.0, 9.0, 2.0, 4.0, 5.0, 5.0));
	block.var[0][1][0] = (mat2x4(0.0, -6.0, -6.0, 6.0, -1.0, 8.0, 4.0, 1.0));
	block.var[0][1][1] = (mat2x4(-5.0, 4.0, -3.0, 3.0, 1.0, -9.0, -1.0, -2.0));
	block.var[0][2][0] = (mat2x4(8.0, 3.0, 0.0, -3.0, 5.0, -4.0, 8.0, -3.0));
	block.var[0][2][1] = (mat2x4(7.0, -1.0, 5.0, 0.0, -5.0, 2.0, -3.0, -8.0));
	block.var[0][3][0] = (mat2x4(-3.0, -9.0, -7.0, -5.0, -2.0, 8.0, -8.0, -8.0));
	block.var[0][3][1] = (mat2x4(-5.0, 1.0, -1.0, 8.0, 3.0, 3.0, -4.0, 8.0));
	block.var[1][0][0] = (mat2x4(3.0, 6.0, 2.0, 7.0, -1.0, -8.0, 7.0, -7.0));
	block.var[1][0][1] = (mat2x4(-8.0, -9.0, 5.0, -5.0, 5.0, -9.0, -7.0, -2.0));
	block.var[1][1][0] = (mat2x4(-4.0, -7.0, -9.0, 5.0, -3.0, -7.0, 8.0, 3.0));
	block.var[1][1][1] = (mat2x4(-1.0, 7.0, 6.0, -6.0, -8.0, -8.0, -4.0, 6.0));
	block.var[1][2][0] = (mat2x4(-9.0, 5.0, -6.0, -2.0, 0.0, 0.0, -2.0, -9.0));
	block.var[1][2][1] = (mat2x4(3.0, -5.0, -5.0, -6.0, 3.0, 0.0, -2.0, 5.0));
	block.var[1][3][0] = (mat2x4(2.0, 5.0, -9.0, 0.0, -3.0, 2.0, -2.0, 9.0));
	block.var[1][3][1] = (mat2x4(-7.0, -3.0, 5.0, -4.0, -2.0, 0.0, 2.0, -6.0));
	block.var[2][0][0] = (mat2x4(-5.0, 8.0, -8.0, -8.0, 5.0, 4.0, -2.0, -7.0));
	block.var[2][0][1] = (mat2x4(-6.0, -7.0, 4.0, -6.0, 9.0, 7.0, 1.0, 7.0));
	block.var[2][1][0] = (mat2x4(-5.0, 3.0, -1.0, -5.0, 7.0, -3.0, -2.0, -2.0));
	block.var[2][1][1] = (mat2x4(5.0, 7.0, -6.0, -5.0, -9.0, 3.0, 7.0, 0.0));
	block.var[2][2][0] = (mat2x4(-9.0, -9.0, 4.0, -7.0, -9.0, -2.0, 5.0, 9.0));
	block.var[2][2][1] = (mat2x4(0.0, 6.0, -3.0, -4.0, 0.0, -2.0, 8.0, 1.0));
	block.var[2][3][0] = (mat2x4(2.0, 3.0, 1.0, 6.0, -7.0, -8.0, -7.0, 9.0));
	block.var[2][3][1] = (mat2x4(-6.0, -2.0, -6.0, -8.0, -5.0, 7.0, 9.0, -5.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0][0], mat4x3(0.0, 1.0, -8.0, -1.0, 2.0, 8.0, 7.0, -7.0, 9.0, -3.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][1], mat4x3(4.0, 2.0, 4.0, -2.0, -9.0, -6.0, 8.0, 9.0, 2.0, -2.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][0], mat4x3(4.0, 4.0, -8.0, 9.0, 2.0, 4.0, 5.0, -1.0, -4.0, -5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][1], mat4x3(9.0, -3.0, 4.0, -4.0, -8.0, 6.0, 7.0, 7.0, -6.0, -3.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2][0], mat4x3(6.0, -1.0, 2.0, 6.0, -2.0, 2.0, 1.0, 6.0, 6.0, -6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2][1], mat4x3(-5.0, -9.0, 2.0, 5.0, -7.0, 6.0, 6.0, 8.0, -4.0, -3.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][3][0], mat4x3(6.0, -3.0, -6.0, -3.0, -5.0, -8.0, 3.0, -5.0, -9.0, 4.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][3][1], mat4x3(7.0, 8.0, 7.0, 3.0, 8.0, -3.0, -9.0, -6.0, 2.0, 0.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][0], mat4x3(-7.0, 9.0, 2.0, -3.0, 3.0, 6.0, 6.0, 3.0, -3.0, -9.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][1], mat4x3(-5.0, 4.0, -6.0, 7.0, -5.0, 8.0, -1.0, 8.0, 1.0, 9.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][0], mat4x3(7.0, -9.0, -8.0, -4.0, -3.0, 6.0, 5.0, 4.0, 2.0, 3.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][1], mat4x3(-3.0, -8.0, -6.0, 5.0, -7.0, 2.0, -2.0, 1.0, 6.0, 5.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2][0], mat4x3(2.0, -1.0, -5.0, -1.0, 3.0, -4.0, 2.0, 0.0, 7.0, -6.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2][1], mat4x3(7.0, 1.0, -8.0, -6.0, 5.0, 7.0, -3.0, 7.0, -1.0, -7.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][3][0], mat4x3(4.0, -8.0, 4.0, 1.0, 8.0, -2.0, 5.0, -4.0, -7.0, -4.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][3][1], mat4x3(-9.0, 7.0, -5.0, 5.0, -6.0, -9.0, -8.0, 4.0, 1.0, 0.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][0], mat4x3(4.0, -6.0, 8.0, -9.0, -1.0, -2.0, 1.0, 7.0, 9.0, -5.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][1], mat4x3(2.0, 4.0, -7.0, 8.0, -1.0, -7.0, -3.0, 2.0, -7.0, 0.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][0], mat4x3(6.0, 1.0, 7.0, -6.0, -8.0, 9.0, 6.0, 2.0, -4.0, 4.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][1], mat4x3(7.0, 2.0, -5.0, -3.0, -3.0, 2.0, -4.0, -8.0, -1.0, 5.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2][0], mat4x3(2.0, 9.0, -3.0, 7.0, -8.0, -1.0, 1.0, -2.0, 2.0, -3.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2][1], mat4x3(9.0, 6.0, 5.0, -3.0, 2.0, -5.0, -7.0, 0.0, 6.0, -1.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][3][0], mat4x3(-5.0, 3.0, -9.0, 7.0, -8.0, -8.0, 4.0, -3.0, -8.0, -9.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][3][1], mat4x3(2.0, -3.0, 2.0, -8.0, 3.0, -8.0, 3.0, 0.0, -9.0, 0.0, -8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4x3(2.0, 4.0, 9.0, -7.0, 5.0, -8.0, 9.0, 1.0, 9.0, -6.0, -6.0, 1.0));
	block.var[0][0][1] = (mat4x3(6.0, -2.0, -2.0, 5.0, 3.0, -6.0, -8.0, -5.0, 9.0, 8.0, -2.0, -1.0));
	block.var[0][1][0] = (mat4x3(-3.0, 7.0, -5.0, -3.0, 0.0, -1.0, 8.0, -1.0, 8.0, -9.0, -7.0, 7.0));
	block.var[0][1][1] = (mat4x3(8.0, 2.0, 0.0, -8.0, -5.0, -8.0, -4.0, 9.0, -6.0, 6.0, -9.0, 9.0));
	block.var[0][2][0] = (mat4x3(-2.0, 7.0, -6.0, -4.0, -2.0, 0.0, 4.0, -2.0, 6.0, -6.0, -5.0, -8.0));
	block.var[0][2][1] = (mat4x3(-1.0, 2.0, 4.0, 2.0, -2.0, 9.0, 0.0, -4.0, 6.0, -7.0, -4.0, 2.0));
	block.var[0][3][0] = (mat4x3(2.0, 6.0, 9.0, -5.0, -9.0, -9.0, 5.0, 6.0, 4.0, 6.0, -3.0, 1.0));
	block.var[0][3][1] = (mat4x3(3.0, -1.0, 9.0, -2.0, 9.0, 6.0, -9.0, 4.0, 3.0, -7.0, -3.0, 3.0));
	block.var[1][0][0] = (mat4x3(1.0, 7.0, 0.0, 5.0, 9.0, -6.0, 5.0, 6.0, 2.0, 3.0, -8.0, 7.0));
	block.var[1][0][1] = (mat4x3(3.0, 1.0, -4.0, 0.0, -7.0, 0.0, 1.0, 6.0, -5.0, -5.0, -2.0, 5.0));
	block.var[1][1][0] = (mat4x3(-4.0, -2.0, -1.0, -9.0, 0.0, -2.0, 2.0, -1.0, 9.0, 6.0, 5.0, -6.0));
	block.var[1][1][1] = (mat4x3(9.0, -4.0, 0.0, 0.0, -6.0, -4.0, 1.0, -9.0, -9.0, -6.0, 2.0, 1.0));
	block.var[1][2][0] = (mat4x3(1.0, 2.0, -9.0, -3.0, 6.0, -9.0, 8.0, 2.0, 1.0, -8.0, 3.0, 2.0));
	block.var[1][2][1] = (mat4x3(1.0, 4.0, 9.0, -7.0, -5.0, 2.0, -8.0, 0.0, 0.0, -4.0, 9.0, 5.0));
	block.var[1][3][0] = (mat4x3(-7.0, 9.0, 6.0, -6.0, 1.0, 1.0, -3.0, -1.0, 8.0, -2.0, 3.0, -3.0));
	block.var[1][3][1] = (mat4x3(-5.0, 4.0, 0.0, -9.0, 9.0, -1.0, 0.0, -9.0, -3.0, 6.0, -2.0, 0.0));
	block.var[2][0][0] = (mat4x3(0.0, 7.0, 3.0, -7.0, -6.0, -5.0, -6.0, 2.0, -9.0, -1.0, 1.0, 6.0));
	block.var[2][0][1] = (mat4x3(0.0, 8.0, -4.0, -6.0, -7.0, -1.0, 3.0, -1.0, -6.0, 2.0, 2.0, -2.0));
	block.var[2][1][0] = (mat4x3(-9.0, 6.0, -7.0, 6.0, 5.0, 4.0, -7.0, -3.0, 6.0, 5.0, 8.0, -2.0));
	block.var[2][1][1] = (mat4x3(3.0, 0.0, 7.0, -9.0, -2.0, 7.0, -3.0, 4.0, -5.0, -5.0, -2.0, -3.0));
	block.var[2][2][0] = (mat4x3(-2.0, -9.0, 6.0, -9.0, -4.0, -7.0, 9.0, -5.0, 3.0, 5.0, -1.0, -4.0));
	block.var[2][2][1] = (mat4x3(1.0, -1.0, -8.0, 4.0, 4.0, 4.0, -3.0, 4.0, 0.0, 0.0, -7.0, -1.0));
	block.var[2][3][0] = (mat4x3(-5.0, -9.0, 2.0, -1.0, 4.0, 0.0, -4.0, 1.0, 3.0, -9.0, -5.0, -6.0));
	block.var[2][3][1] = (mat4x3(7.0, -4.0, 3.0, 0.0, -2.0, -5.0, -8.0, 3.0, 5.0, -1.0, 3.0, 5.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0][0][0], mat4(9.0, -2.0, -9.0, 2.0, -3.0, 8.0, -1.0, 2.0, 2.0, -5.0, -8.0, -6.0, -6.0, -3.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][1], mat4(0.0, 0.0, 8.0, -6.0, 7.0, -9.0, 0.0, 5.0, -6.0, -4.0, -7.0, 7.0, -3.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][0], mat4(9.0, -6.0, 6.0, 6.0, -2.0, -1.0, -8.0, 2.0, 6.0, 2.0, 1.0, 4.0, -3.0, -2.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][1], mat4(-4.0, -3.0, -8.0, 5.0, 8.0, 4.0, -5.0, 9.0, -4.0, -5.0, 2.0, 2.0, -3.0, 2.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[0][2][0], mat4(2.0, -9.0, 8.0, -3.0, -3.0, -1.0, -8.0, -7.0, -8.0, 4.0, 2.0, -4.0, -5.0, 1.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[0][2][1], mat4(6.0, -2.0, -2.0, -9.0, 7.0, 8.0, -4.0, -9.0, -8.0, -4.0, 6.0, 7.0, -4.0, -5.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[0][3][0], mat4(8.0, 1.0, -4.0, 3.0, 7.0, 9.0, 6.0, -6.0, 2.0, 8.0, 2.0, 3.0, -8.0, 7.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[0][3][1], mat4(-5.0, 3.0, -1.0, -1.0, -9.0, 4.0, -7.0, 5.0, 5.0, 3.0, 8.0, -1.0, 6.0, 3.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][0], mat4(4.0, 4.0, 2.0, -6.0, 2.0, 0.0, -9.0, -1.0, -3.0, 4.0, -3.0, 0.0, -2.0, -5.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][1], mat4(-4.0, -1.0, 7.0, 7.0, 0.0, 8.0, 8.0, 8.0, -3.0, -1.0, -9.0, 9.0, 2.0, 2.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][0], mat4(5.0, -1.0, 6.0, 0.0, -1.0, 7.0, -6.0, -9.0, -8.0, -3.0, -5.0, 0.0, -2.0, -1.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][1], mat4(0.0, -4.0, 0.0, 2.0, 5.0, -7.0, 2.0, 5.0, -6.0, 2.0, -9.0, -9.0, 8.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[1][2][0], mat4(3.0, 8.0, 3.0, 9.0, -8.0, 9.0, 4.0, -3.0, -1.0, -3.0, 5.0, -1.0, 3.0, 9.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[1][2][1], mat4(-7.0, 9.0, -8.0, -7.0, -5.0, 5.0, 6.0, 9.0, -7.0, -2.0, 5.0, 7.0, -2.0, 8.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[1][3][0], mat4(-5.0, 5.0, 1.0, 6.0, 0.0, -7.0, -5.0, -8.0, 2.0, 0.0, 4.0, 9.0, -3.0, 8.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[1][3][1], mat4(5.0, -3.0, -9.0, 6.0, -1.0, -9.0, 1.0, -2.0, 4.0, -2.0, 2.0, -5.0, 6.0, -6.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][0], mat4(5.0, 0.0, 8.0, -9.0, 0.0, -2.0, -9.0, 7.0, -6.0, 0.0, 8.0, -8.0, -2.0, -8.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][1], mat4(-4.0, -3.0, -4.0, -7.0, 4.0, -6.0, 5.0, 2.0, -1.0, -6.0, -7.0, -9.0, 7.0, 4.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][0], mat4(9.0, 2.0, 5.0, -7.0, 0.0, 8.0, -5.0, -9.0, -4.0, 7.0, -4.0, -9.0, 7.0, 9.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][1], mat4(-9.0, -5.0, 3.0, -4.0, -6.0, 7.0, -1.0, -2.0, -5.0, 4.0, -6.0, -7.0, -7.0, -4.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[2][2][0], mat4(3.0, 7.0, 1.0, -2.0, 8.0, 6.0, 9.0, 5.0, 3.0, 4.0, -8.0, -4.0, -5.0, 0.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[2][2][1], mat4(-3.0, 9.0, 7.0, -3.0, 8.0, -4.0, -7.0, 1.0, -3.0, 9.0, -9.0, -1.0, 7.0, -1.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[2][3][0], mat4(4.0, 4.0, 9.0, -5.0, -1.0, 8.0, 9.0, 8.0, 5.0, 6.0, -9.0, 1.0, 9.0, 8.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[2][3][1], mat4(-5.0, 7.0, -9.0, -5.0, 6.0, -4.0, -5.0, -4.0, -9.0, -8.0, 9.0, 4.0, 2.0, 5.0, -8.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4(7.0, 8.0, 6.0, 5.0, 7.0, 7.0, -1.0, -6.0, -2.0, -6.0, 5.0, 9.0, 8.0, -6.0, 9.0, -8.0));
	block.var[0][0][1] = (mat4(-7.0, -6.0, -1.0, 8.0, 2.0, -9.0, 8.0, -8.0, -3.0, 6.0, -8.0, 3.0, 0.0, -9.0, 1.0, 4.0));
	block.var[0][1][0] = (mat4(7.0, 9.0, -3.0, -6.0, 3.0, 8.0, -8.0, 7.0, 5.0, 8.0, -5.0, 7.0, 4.0, 4.0, 6.0, -3.0));
	block.var[0][1][1] = (mat4(3.0, -3.0, 1.0, 4.0, -1.0, -3.0, -7.0, -8.0, 3.0, 2.0, -9.0, 5.0, 0.0, -6.0, -6.0, -8.0));
	block.var[0][2][0] = (mat4(4.0, -5.0, 0.0, -7.0, 5.0, 6.0, -9.0, 8.0, -2.0, -3.0, -2.0, -2.0, -4.0, -1.0, -7.0, -8.0));
	block.var[0][2][1] = (mat4(6.0, 2.0, 6.0, -7.0, 2.0, 4.0, -8.0, -9.0, -9.0, -5.0, -7.0, 1.0, 9.0, 1.0, 5.0, -3.0));
	block.var[0][3][0] = (mat4(-6.0, -4.0, 9.0, 8.0, 6.0, 8.0, -4.0, 1.0, -6.0, 4.0, -2.0, 2.0, -3.0, -4.0, 3.0, -5.0));
	block.var[0][3][1] = (mat4(2.0, 9.0, -7.0, -6.0, 2.0, -1.0, 9.0, 2.0, 9.0, -4.0, 4.0, -1.0, -3.0, -4.0, 0.0, -3.0));
	block.var[1][0][0] = (mat4(8.0, -2.0, 0.0, -2.0, 9.0, 2.0, -3.0, 0.0, 4.0, -8.0, 3.0, 2.0, 2.0, 2.0, 3.0, -6.0));
	block.var[1][0][1] = (mat4(-3.0, 1.0, -5.0, 0.0, -1.0, 7.0, 4.0, 1.0, 6.0, 3.0, -6.0, 4.0, -9.0, 6.0, 0.0, -1.0));
	block.var[1][1][0] = (mat4(-6.0, -5.0, 3.0, -8.0, -4.0, 7.0, -5.0, -2.0, -2.0, 4.0, -8.0, 2.0, 6.0, -4.0, 5.0, -8.0));
	block.var[1][1][1] = (mat4(-5.0, 2.0, 1.0, 1.0, -7.0, 4.0, 6.0, -2.0, -3.0, -4.0, -9.0, 8.0, 2.0, -3.0, 1.0, 3.0));
	block.var[1][2][0] = (mat4(7.0, 8.0, 7.0, -3.0, 0.0, -2.0, -3.0, -6.0, -6.0, -6.0, 6.0, -6.0, -6.0, 9.0, 8.0, -5.0));
	block.var[1][2][1] = (mat4(4.0, -4.0, 4.0, 7.0, -4.0, 5.0, -8.0, 5.0, -8.0, 9.0, 3.0, 9.0, 3.0, -3.0, -8.0, -6.0));
	block.var[1][3][0] = (mat4(8.0, -4.0, -1.0, -5.0, 9.0, -8.0, -2.0, -9.0, -5.0, -3.0, 0.0, 0.0, 1.0, 1.0, -4.0, 4.0));
	block.var[1][3][1] = (mat4(-9.0, -9.0, 4.0, 8.0, 2.0, -6.0, -1.0, 5.0, -4.0, -6.0, -8.0, 7.0, 4.0, -2.0, -4.0, -1.0));
	block.var[2][0][0] = (mat4(4.0, 7.0, 2.0, 2.0, 5.0, 1.0, -4.0, 2.0, -5.0, 1.0, -7.0, 5.0, -2.0, -1.0, -2.0, -5.0));
	block.var[2][0][1] = (mat4(-6.0, 0.0, -6.0, 3.0, -1.0, 0.0, -4.0, 3.0, -9.0, 1.0, -5.0, -9.0, 3.0, -4.0, 2.0, -9.0));
	block.var[2][1][0] = (mat4(-4.0, -3.0, 2.0, -2.0, 4.0, 5.0, -7.0, 9.0, -7.0, 9.0, 2.0, -1.0, -6.0, 0.0, 3.0, 5.0));
	block.var[2][1][1] = (mat4(6.0, -9.0, 7.0, 7.0, -1.0, -6.0, -8.0, -8.0, 2.0, -8.0, -1.0, -1.0, -8.0, 3.0, 3.0, -9.0));
	block.var[2][2][0] = (mat4(2.0, 4.0, -9.0, 6.0, 4.0, -1.0, 2.0, 1.0, 2.0, 6.0, -9.0, -1.0, -5.0, -1.0, -7.0, 9.0));
	block.var[2][2][1] = (mat4(6.0, -6.0, -2.0, -7.0, 6.0, 8.0, -3.0, -9.0, 7.0, 6.0, -5.0, 9.0, -5.0, 0.0, -9.0, 3.0));
	block.var[2][3][0] = (mat4(1.0, 7.0, 5.0, 2.0, 5.0, 9.0, 3.0, -9.0, -6.0, -4.0, 4.0, 7.0, 6.0, -1.0, -7.0, -5.0));
	block.var[2][3][1] = (mat4(0.0, 9.0, 4.0, 7.0, 3.0, -1.0, 9.0, -1.0, 3.0, 3.0, 5.0, 7.0, 7.0, -8.0, -9.0, -5.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(5.0, -6.0, -5.0, 5.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(-5.0, -6.0, -8.0, 6.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(-1.0, 7.0, -4.0, 3.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(-5.0, -2.0, 0.0, -2.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][0], mat3x2(-1.0, 7.0, 3.0, 8.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][1], mat3x2(6.0, -7.0, 7.0, 5.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][0], mat3x2(1.0, -2.0, -2.0, -9.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][1], mat3x2(8.0, 2.0, -1.0, -3.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(2.0, -8.0, 9.0, -8.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(5.0, 0.0, 4.0, 3.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(-7.0, -4.0, 1.0, -1.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(-8.0, -7.0, -1.0, -4.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][0], mat3x2(9.0, 0.0, 2.0, -5.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][1], mat3x2(-5.0, 6.0, -3.0, 2.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][0], mat3x2(-6.0, 0.0, 6.0, 9.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][1], mat3x2(1.0, 8.0, 6.0, 6.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(-1.0, -1.0, -2.0, -8.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(-8.0, -6.0, 0.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(7.0, 9.0, 8.0, 2.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(8.0, -3.0, 8.0, -5.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][0], mat3x2(9.0, -6.0, -8.0, -7.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][1], mat3x2(-2.0, -1.0, 1.0, 6.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][0], mat3x2(2.0, 5.0, 4.0, 5.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][1], mat3x2(-7.0, -1.0, -1.0, -7.0, 8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3x2(-1.0, -5.0, -1.0, -8.0, 7.0, 8.0));
	block.var[0][0][1] = (mat3x2(-4.0, -8.0, 1.0, 5.0, -2.0, 7.0));
	block.var[0][1][0] = (mat3x2(7.0, 9.0, -5.0, 9.0, -1.0, 4.0));
	block.var[0][1][1] = (mat3x2(6.0, -4.0, -6.0, 0.0, 7.0, -2.0));
	block.var[0][2][0] = (mat3x2(4.0, -9.0, -8.0, 7.0, -5.0, -1.0));
	block.var[0][2][1] = (mat3x2(-7.0, 4.0, -2.0, -6.0, -5.0, 6.0));
	block.var[0][3][0] = (mat3x2(-3.0, -4.0, -7.0, 0.0, 8.0, 4.0));
	block.var[0][3][1] = (mat3x2(-8.0, -5.0, -1.0, -5.0, 2.0, -6.0));
	block.var[1][0][0] = (mat3x2(4.0, -6.0, 7.0, -6.0, 2.0, 5.0));
	block.var[1][0][1] = (mat3x2(0.0, 6.0, -5.0, 4.0, -2.0, 0.0));
	block.var[1][1][0] = (mat3x2(-1.0, -9.0, 8.0, -6.0, -9.0, 5.0));
	block.var[1][1][1] = (mat3x2(2.0, -9.0, 9.0, 4.0, -4.0, 9.0));
	block.var[1][2][0] = (mat3x2(-3.0, -7.0, 9.0, 9.0, -8.0, 0.0));
	block.var[1][2][1] = (mat3x2(6.0, -3.0, 9.0, -2.0, -5.0, -4.0));
	block.var[1][3][0] = (mat3x2(3.0, 4.0, 5.0, 1.0, -7.0, 1.0));
	block.var[1][3][1] = (mat3x2(2.0, -7.0, -1.0, -4.0, 8.0, 1.0));
	block.var[2][0][0] = (mat3x2(-3.0, -3.0, -2.0, 9.0, -2.0, -7.0));
	block.var[2][0][1] = (mat3x2(-9.0, -2.0, -8.0, 4.0, 3.0, 8.0));
	block.var[2][1][0] = (mat3x2(3.0, 3.0, 1.0, -4.0, 0.0, -7.0));
	block.var[2][1][1] = (mat3x2(-4.0, 7.0, 7.0, -1.0, -2.0, 6.0));
	block.var[2][2][0] = (mat3x2(-4.0, 6.0, -7.0, 5.0, -1.0, 5.0));
	block.var[2][2][1] = (mat3x2(4.0, -7.0, -3.0, 6.0, -8.0, 2.0));
	block.var[2][3][0] = (mat3x2(-8.0, 2.0, 7.0, 8.0, -5.0, -3.0));
	block.var[2][3][1] = (mat3x2(8.0, -6.0, 3.0, -2.0, 7.0, -4.0));
}
#version 450
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
layout(scalar, buffer_reference) buffer Block
{
	S s;
	lowp vec2 v;
	T t;
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

layout(std140, buffer_reference) buffer Block
{
	highp uvec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((block[0].var), uvec2(6u, 0u)) && allOk;
	allOk = compare_uvec2((block[1].var), uvec2(6u, 7u)) && allOk;
	allOk = compare_uvec2((block[2].var), uvec2(1u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (uvec2(6u, 1u));
	block[1].var = (uvec2(8u, 1u));
	block[2].var = (uvec2(7u, 4u));
}
#version 450
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
	u8vec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(block[0].var), uvec3(4u, 3u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(block[1].var), uvec3(1u, 4u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(block[2].var), uvec3(8u, 6u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = u8vec3(uvec3(4u, 5u, 9u));
	block[1].var = u8vec3(uvec3(6u, 9u, 4u));
	block[2].var = u8vec3(uvec3(7u, 1u, 5u));
}
#version 450
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
	allOk = compare_float((block[0].padding), -7.0) && allOk;
	allOk = compare_mat4x3(block[0].var, mat4x3(1.0, 0.0, 0.0, -7.0, 2.0, 5.0, 0.0, 3.0, 2.0, 4.0, 7.0, -7.0)) && allOk;
	allOk = compare_float((block[1].padding), -5.0) && allOk;
	allOk = compare_mat4x3(block[1].var, mat4x3(2.0, 0.0, -1.0, -5.0, 5.0, 5.0, 9.0, -7.0, 5.0, 6.0, 3.0, 6.0)) && allOk;
	allOk = compare_float((block[2].padding), -7.0) && allOk;
	allOk = compare_mat4x3(block[2].var, mat4x3(7.0, 8.0, 6.0, -7.0, -8.0, -5.0, -9.0, -4.0, -9.0, -7.0, -7.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (7.0);
	block[0].var = (mat4x3(8.0, 8.0, -3.0, -9.0, 2.0, -6.0, 0.0, -4.0, -3.0, 4.0, -8.0, 4.0));
	block[1].padding = (-2.0);
	block[1].var = (mat4x3(2.0, 8.0, 4.0, -1.0, -8.0, -6.0, -4.0, 9.0, -2.0, 1.0, -7.0, -4.0));
	block[2].padding = (-4.0);
	block[2].var = (mat4x3(-1.0, 7.0, -6.0, 4.0, 6.0, 7.0, -9.0, -8.0, 3.0, -6.0, -5.0, 6.0));
}
#version 450
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
	mediump mat4x2 a[1];
	mediump uint b;
	mediump uvec2 c;
	highp ivec3 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB[0].b), 0u) && allOk;
	allOk = compare_uvec2((blockB[0].c), uvec2(4u, 5u)) && allOk;
	allOk = compare_ivec3((blockB[0].d[0]), ivec3(-7, 3, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (mat4x2(9.0, 9.0, 7.0, -6.0, 5.0, 1.0, -2.0, 2.0));
	blockB[0].b = (8u);
	blockB[0].c = (uvec2(6u, 6u));
}
#version 450
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
	mediump vec2 a;
	mediump uvec2 b;
	mediump uvec4 c[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	lowp uint d;
	highp ivec4 e;
	mediump float f;
	lowp vec3 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(-5.0, -9.0)) && allOk;
	allOk = compare_uvec2((blockB.b), uvec2(0u, 1u)) && allOk;
	allOk = compare_uint((blockC.d), 7u) && allOk;
	allOk = compare_float((blockC.f), -3.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec2(-7.0, 4.0));
	blockB.b = (uvec2(2u, 4u));
	blockC.d = (1u);
	blockC.g[0] = (vec3(-9.0, -7.0, 3.0));
}
#version 450
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
	bvec2 a;
	highp mat3 b;
	lowp uvec3 c;
};
layout(std430, buffer_reference) buffer BlockC
{
	bvec2 d;
	highp uvec2 e[];
};
layout(std140, buffer_reference) buffer BlockD
{
	highp mat4 f;
	bvec4 g;
};
layout(std140, column_major, buffer_reference) buffer BlockE
{
	bool h;
	mediump ivec4 i[5];
	mediump mat3 j;
	mediump uvec2 k;
	bool l[];
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
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a), bvec2(true, true)) && allOk;
	allOk = compare_uvec3((blockB.c), uvec3(3u, 6u, 2u)) && allOk;
	allOk = compare_bvec2((blockC.d), bvec2(false, true)) && allOk;
	allOk = compare_uvec2((blockC.e[0]), uvec2(8u, 7u)) && allOk;
	allOk = compare_uvec2((blockC.e[1]), uvec2(2u, 5u)) && allOk;
	allOk = compare_uvec2((blockC.e[2]), uvec2(4u, 6u)) && allOk;
	allOk = compare_uvec2((blockC.e[3]), uvec2(0u, 0u)) && allOk;
	allOk = compare_uvec2((blockC.e[4]), uvec2(8u, 5u)) && allOk;
	allOk = compare_uvec2((blockC.e[5]), uvec2(8u, 2u)) && allOk;
	allOk = compare_uvec2((blockC.e[6]), uvec2(7u, 4u)) && allOk;
	allOk = compare_mat4(blockD.f, mat4(9.0, -8.0, -7.0, -4.0, -5.0, -6.0, -5.0, -8.0, -4.0, 8.0, 1.0, -9.0, -4.0, 5.0, -3.0, -5.0)) && allOk;
	allOk = compare_bvec4((blockD.g), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bool((blockE.h), true) && allOk;
	allOk = compare_ivec4((blockE.i[0]), ivec4(-3, 8, 5, 1)) && allOk;
	allOk = compare_ivec4((blockE.i[1]), ivec4(5, -9, -7, 7)) && allOk;
	allOk = compare_ivec4((blockE.i[2]), ivec4(2, 5, 1, 2)) && allOk;
	allOk = compare_ivec4((blockE.i[3]), ivec4(9, 0, -6, -9)) && allOk;
	allOk = compare_ivec4((blockE.i[4]), ivec4(5, -3, -6, 2)) && allOk;
	allOk = compare_mat3(blockE.j, mat3(-3.0, -5.0, 2.0, 8.0, 0.0, 6.0, -9.0, 2.0, 9.0)) && allOk;
	allOk = compare_uvec2((blockE.k), uvec2(2u, 0u)) && allOk;
	allOk = compare_bool((blockE.l[0]), false) && allOk;
	allOk = compare_bool((blockE.l[1]), false) && allOk;
	allOk = compare_bool((blockE.l[2]), true) && allOk;
	allOk = compare_bool((blockE.l[3]), false) && allOk;
	allOk = compare_bool((blockE.l[4]), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat3(-6.0, 0.0, 7.0, -6.0, 5.0, 2.0, 1.0, -1.0, -7.0));
	blockB.c = (uvec3(6u, 6u, 5u));
	blockC.d = (bvec2(false, false));
	blockC.e[0] = (uvec2(5u, 0u));
	blockC.e[1] = (uvec2(8u, 3u));
	blockC.e[2] = (uvec2(5u, 3u));
	blockC.e[3] = (uvec2(2u, 5u));
	blockC.e[4] = (uvec2(7u, 7u));
	blockC.e[5] = (uvec2(1u, 0u));
	blockC.e[6] = (uvec2(5u, 4u));
	blockD.f = (mat4(9.0, 6.0, -4.0, -8.0, 7.0, 4.0, -7.0, 4.0, 9.0, 3.0, -7.0, 0.0, -3.0, 7.0, 4.0, 9.0));
	blockE.h = (false);
	blockE.j = (mat3(-4.0, 5.0, 7.0, -9.0, -8.0, -5.0, -3.0, -7.0, -1.0));
	blockE.k = (uvec2(5u, 2u));
	blockE.l[0] = (false);
	blockE.l[1] = (true);
	blockE.l[2] = (true);
	blockE.l[3] = (false);
	blockE.l[4] = (true);
}
#version 450
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
	layout(offset = 16) highp ivec3 b;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) lowp uvec2 c;
	layout(offset = 16) bvec4 d;
	layout(offset = 32) lowp ivec4 e;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) bvec3 f[1];
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
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.a), vec4(-5.0, 5.0, -6.0, -9.0)) && allOk;
	allOk = compare_ivec3((blockB.b), ivec3(9, -5, 7)) && allOk;
	allOk = compare_uvec2((blockC.c), uvec2(0u, 5u)) && allOk;
	allOk = compare_ivec4((blockC.e), ivec4(2, -4, 7, 7)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec4(3.0, -4.0, 2.0, 2.0));
	blockB.b = (ivec3(4, 9, -2));
	blockC.c = (uvec2(0u, 8u));
	blockC.d = (bvec4(false, false, false, true));
	blockC.e = (ivec4(4, -6, -8, -5));
	blockD.f[0] = (bvec3(false, false, true));
}
#version 450
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
	layout(offset = 16) highp uvec4 b;
	layout(offset = 32) lowp uint c;
	layout(offset = 36) lowp uint d;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump vec3 e;
	layout(offset = 12) highp uint f;
	layout(offset = 16) highp vec4 g;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.c), 6u) && allOk;
	allOk = compare_uint((blockB.d), 9u) && allOk;
	allOk = compare_vec3((blockC.e), vec3(8.0, 4.0, -4.0)) && allOk;
	allOk = compare_uint((blockC.f), 2u) && allOk;
	allOk = compare_vec4((blockC.g), vec4(-9.0, -7.0, 9.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
	blockB.b = (uvec4(1u, 0u, 9u, 6u));
	blockB.c = (3u);
	blockB.d = (2u);
	blockC.e = (vec3(-6.0, -5.0, -2.0));
	blockC.f = (8u);
}
#version 450
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
	layout(offset = 12) lowp float b;
	layout(offset = 16) mediump ivec2 c;
	layout(offset = 24) highp uint d;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) bvec4 e;
	layout(offset = 16) bvec4 f;
	layout(offset = 32) lowp ivec4 g;
	layout(offset = 48) lowp vec4 h;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) lowp int i;
	layout(offset = 4) mediump uvec2 j;
	layout(offset = 16) mediump uvec3 k;
};
layout(buffer_reference) readonly buffer BlockE
{
	layout(offset = 0) bvec2 l[1];
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
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a), ivec3(-8, 7, -3)) && allOk;
	allOk = compare_float((blockB.b), 6.0) && allOk;
	allOk = compare_uint((blockB.d), 4u) && allOk;
	allOk = compare_bvec4((blockC.e), bvec4(false, false, false, true)) && allOk;
	allOk = compare_bvec4((blockC.f), bvec4(false, true, false, false)) && allOk;
	allOk = compare_int((blockD.i), -1) && allOk;
	allOk = compare_uvec3((blockD.k), uvec3(9u, 2u, 5u)) && allOk;
	allOk = compare_bvec2((blockE.l[0]), bvec2(false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec3(2, 7, 2));
	blockB.b = (3.0);
	blockB.c = (ivec2(4, 4));
	blockB.d = (8u);
	blockC.e = (bvec4(false, false, true, true));
	blockC.f = (bvec4(false, false, true, false));
	blockC.g = (ivec4(-3, 8, -7, 5));
	blockC.h = (vec4(-4.0, -4.0, -6.0, -1.0));
	blockD.i = (4);
	blockD.j = (uvec2(5u, 6u));
	blockD.k = (uvec3(9u, 5u, 4u));
}
#version 450
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
	layout(offset = 0) bvec2 a[1];
	layout(offset = 16) highp vec4 b;
	layout(offset = 32) highp vec4 c[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB[0].a[0]), bvec2(true, false)) && allOk;
	allOk = compare_vec4((blockB[0].b), vec4(2.0, 5.0, 9.0, -2.0)) && allOk;
	allOk = compare_vec4((blockB[0].c[0]), vec4(-7.0, -4.0, 1.0, -2.0)) && allOk;
	allOk = compare_bvec2((blockB[1].a[0]), bvec2(true, false)) && allOk;
	allOk = compare_vec4((blockB[1].b), vec4(-2.0, -4.0, 7.0, -1.0)) && allOk;
	allOk = compare_vec4((blockB[1].c[0]), vec4(6.0, -1.0, 3.0, 2.0)) && allOk;
	allOk = compare_bvec2((blockB[2].a[0]), bvec2(false, true)) && allOk;
	allOk = compare_vec4((blockB[2].b), vec4(-6.0, 4.0, 1.0, -4.0)) && allOk;
	allOk = compare_vec4((blockB[2].c[0]), vec4(-2.0, -2.0, -1.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (bvec2(true, false));
	blockB[0].c[0] = (vec4(8.0, 1.0, 6.0, 6.0));
	blockB[1].a[0] = (bvec2(true, true));
	blockB[1].c[0] = (vec4(-5.0, -3.0, 9.0, -1.0));
	blockB[2].a[0] = (bvec2(false, true));
	blockB[2].c[0] = (vec4(1.0, -9.0, -8.0, -8.0));
}
#version 450
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
	mediump uint a;
	highp mat2 b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 3u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (7u);
}
#version 450
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
	lowp ivec4 a[1];
};
layout(std140, buffer_reference) buffer BlockC
{
	mediump float b;
	highp float c;
	mediump uvec3 d;
	bvec4 e;
	lowp vec4 f;
};
layout(std430, buffer_reference) buffer BlockD
{
	i16vec3 g;
	i16vec2 h;
	float16_t i;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockC.e), bvec4(true, false, true, true)) && allOk;
	allOk = compare_vec4((blockC.f), vec4(-9.0, -6.0, -9.0, 6.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD.h), ivec2(2, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (ivec4(8, 9, -5, 5));
	blockC.c = (2.0);
	blockC.d = (uvec3(9u, 4u, 7u));
	blockC.e = (bvec4(true, true, false, true));
	blockC.f = (vec4(-6.0, 9.0, 4.0, -5.0));
	blockD.g = i16vec3(ivec3(5, -1, 4));
	blockD.h = i16vec2(ivec2(-7, 5));
	blockD.i = float16_t(-6.0);
}
#version 450
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
	bool b[];
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp uvec2 c;
	f16vec4 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockC.c), uvec2(4u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (false);
	blockC.c = (uvec2(9u, 4u));
	blockC.d[0] = f16vec4(vec4(4.0, -2.0, 5.0, -9.0));
}
#version 450
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
	f16vec3 a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(blockB.a), vec3(-8.0, -2.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump uint a[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	lowp uint b;
	mediump uvec3 c[];
};
layout(std430, buffer_reference) buffer BlockD
{
	mediump mat4x3 d;
	mediump uvec3 e;
	i16vec4 f;
};
layout(std430, row_major, buffer_reference) readonly buffer BlockE
{
	highp float g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a[0]), 0u) && allOk;
	allOk = compare_uint((blockB.a[1]), 2u) && allOk;
	allOk = compare_uint((blockB.a[2]), 0u) && allOk;
	allOk = compare_uint((blockB.a[3]), 4u) && allOk;
	allOk = compare_uint((blockB.a[4]), 4u) && allOk;
	allOk = compare_uint((blockB.a[5]), 0u) && allOk;
	allOk = compare_uvec3((blockC.c[0]), uvec3(3u, 5u, 6u)) && allOk;
	allOk = compare_uvec3((blockC.c[1]), uvec3(7u, 4u, 1u)) && allOk;
	allOk = compare_mat4x3(blockD.d, mat4x3(6.0, 5.0, 7.0, -2.0, -4.0, -9.0, 8.0, 3.0, 0.0, 2.0, 1.0, 8.0)) && allOk;
	allOk = compare_uvec3((blockD.e), uvec3(8u, 0u, 9u)) && allOk;
	allOk = compare_float((blockE.g[0]), -3.0) && allOk;
	allOk = compare_float((blockE.g[1]), 1.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (4u);
	blockB.a[1] = (1u);
	blockB.a[2] = (0u);
	blockB.a[3] = (6u);
	blockB.a[4] = (8u);
	blockB.a[5] = (2u);
	blockC.b = (2u);
	blockC.c[0] = (uvec3(8u, 6u, 5u));
	blockC.c[1] = (uvec3(9u, 9u, 4u));
	blockD.d = (mat4x3(-2.0, 2.0, 3.0, -1.0, 4.0, -4.0, -6.0, -7.0, -7.0, -4.0, 8.0, 2.0));
	blockD.f = i16vec4(ivec4(3, -1, -6, -4));
}
#version 450
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
	highp vec3 mB;
	highp ivec2 mC;
	mediump vec2 mD;
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	highp ivec4 a;
	highp int b;
	lowp mat2 c;
	float16_t d[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	f16vec4 e;
	int16_t f;
	i16vec2 g[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	lowp mat3x2 h;
	sA i;
	bvec2 j;
	uint16_t k;
	lowp mat2x3 l[];
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
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.a), ivec4(-5, -9, -7, 9)) && allOk;
	allOk = compare_mat2(blockB.c, mat2(0.0, 9.0, -3.0, -2.0)) && allOk;
	allOk = compare_float16_t(float(blockB.d[0]), 0.0) && allOk;
	allOk = compare_float16_t(float(blockB.d[1]), 3.0) && allOk;
	allOk = compare_float16_t(float(blockB.d[2]), -3.0) && allOk;
	allOk = compare_float16_t(float(blockB.d[3]), 2.0) && allOk;
	allOk = compare_float16_t(float(blockB.d[4]), -3.0) && allOk;
	allOk = compare_float16_t(float(blockB.d[5]), 8.0) && allOk;
	allOk = compare_float16_t(float(blockB.d[6]), 8.0) && allOk;
	allOk = compare_f16vec4(vec4(blockC.e), vec4(-3.0, 8.0, 5.0, -7.0)) && allOk;
	allOk = compare_int16_t(int(blockC.f), -3) && allOk;
	allOk = compare_i16vec2(ivec2(blockC.g[0]), ivec2(-9, 5)) && allOk;
	allOk = compare_i16vec2(ivec2(blockC.g[1]), ivec2(-9, 7)) && allOk;
	allOk = compare_i16vec2(ivec2(blockC.g[2]), ivec2(4, 6)) && allOk;
	allOk = compare_i16vec2(ivec2(blockC.g[3]), ivec2(7, -8)) && allOk;
	allOk = compare_mat3x2(blockD[0].h, mat3x2(9.0, 7.0, -2.0, -8.0, 6.0, -3.0)) && allOk;
	allOk = compare_float((blockD[0].i.mA), -8.0) && allOk;
	allOk = compare_vec3((blockD[0].i.mB), vec3(-7.0, -2.0, -8.0)) && allOk;
	allOk = compare_ivec2((blockD[0].i.mC), ivec2(-1, -9)) && allOk;
	allOk = compare_vec2((blockD[0].i.mD), vec2(1.0, 3.0)) && allOk;
	allOk = compare_bvec2((blockD[0].j), bvec2(true, false)) && allOk;
	allOk = compare_uint16_t(uint(blockD[0].k), 8u) && allOk;
	allOk = compare_mat2x3(blockD[0].l[0], mat2x3(-8.0, -3.0, -6.0, -9.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat2x3(blockD[0].l[1], mat2x3(0.0, -4.0, -9.0, 6.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockD[1].h, mat3x2(7.0, 8.0, 8.0, 9.0, 7.0, -7.0)) && allOk;
	allOk = compare_float((blockD[1].i.mA), 7.0) && allOk;
	allOk = compare_vec3((blockD[1].i.mB), vec3(-8.0, -7.0, -8.0)) && allOk;
	allOk = compare_ivec2((blockD[1].i.mC), ivec2(-2, -1)) && allOk;
	allOk = compare_vec2((blockD[1].i.mD), vec2(6.0, 4.0)) && allOk;
	allOk = compare_bvec2((blockD[1].j), bvec2(true, true)) && allOk;
	allOk = compare_uint16_t(uint(blockD[1].k), 1u) && allOk;
	allOk = compare_mat2x3(blockD[1].l[0], mat2x3(1.0, 5.0, -5.0, -2.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat2x3(blockD[1].l[1], mat2x3(0.0, -3.0, 4.0, 2.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2x3(blockD[1].l[2], mat2x3(-9.0, 5.0, -7.0, 1.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat2x3(blockD[1].l[3], mat2x3(0.0, -9.0, -4.0, -3.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat3x2(blockD[2].h, mat3x2(-8.0, -4.0, 4.0, -5.0, 6.0, -2.0)) && allOk;
	allOk = compare_float((blockD[2].i.mA), 3.0) && allOk;
	allOk = compare_vec3((blockD[2].i.mB), vec3(-6.0, 8.0, -2.0)) && allOk;
	allOk = compare_ivec2((blockD[2].i.mC), ivec2(-8, -1)) && allOk;
	allOk = compare_vec2((blockD[2].i.mD), vec2(7.0, -9.0)) && allOk;
	allOk = compare_bvec2((blockD[2].j), bvec2(true, false)) && allOk;
	allOk = compare_uint16_t(uint(blockD[2].k), 6u) && allOk;
	allOk = compare_mat2x3(blockD[2].l[0], mat2x3(4.0, 5.0, -8.0, -4.0, -4.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec4(-7, 4, -4, -7));
	blockB.b = (-3);
	blockB.c = (mat2(-9.0, 2.0, 1.0, 8.0));
	blockB.d[0] = float16_t(-2.0);
	blockB.d[1] = float16_t(5.0);
	blockB.d[2] = float16_t(-7.0);
	blockB.d[3] = float16_t(-5.0);
	blockB.d[4] = float16_t(-9.0);
	blockB.d[5] = float16_t(-9.0);
	blockB.d[6] = float16_t(-7.0);
	blockC.e = f16vec4(vec4(3.0, 1.0, 2.0, -4.0));
	blockC.g[0] = i16vec2(ivec2(7, 1));
	blockC.g[1] = i16vec2(ivec2(9, 1));
	blockC.g[2] = i16vec2(ivec2(3, 9));
	blockC.g[3] = i16vec2(ivec2(6, 4));
	blockD[0].h = (mat3x2(-5.0, -6.0, 2.0, 8.0, 0.0, 6.0));
	blockD[0].j = (bvec2(true, true));
	blockD[1].h = (mat3x2(1.0, -7.0, 2.0, -4.0, 1.0, -2.0));
	blockD[1].j = (bvec2(false, false));
	blockD[2].h = (mat3x2(6.0, -4.0, -5.0, -2.0, 0.0, -2.0));
	blockD[2].j = (bvec2(false, true));
}
#version 450
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
	f16vec2 mB;
	i16vec3 mC;
	mediump mat3x4 mD;
};
struct sB
{
	mediump ivec4 mA;
	highp mat2 mB;
	mediump mat4x3 mC;
	f16vec4 mD;
};
struct sC
{
	mediump float mA;
	highp mat4x2 mB;
	highp vec3 mC;
};
layout(std430, column_major, buffer_reference) buffer BlockB
{
	i16vec4 a;
	sA b;
	highp mat3 c;
	highp ivec3 d;
	mediump vec2 e;
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	sB f;
	lowp mat4x2 g;
	lowp ivec3 h[];
};
layout(std430, buffer_reference) buffer BlockD
{
	highp mat4x2 i;
	i16vec3 j[];
};
layout(std140, buffer_reference) buffer BlockE
{
	lowp mat3x4 k[3][4];
	sC l;
	mediump vec3 m[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[1];
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB.b.mA, mat2(7.0, -3.0, 2.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockB.b.mB), vec2(9.0, -8.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB.b.mC), ivec3(0, 1, 6)) && allOk;
	allOk = compare_mat3x4(blockB.b.mD, mat3x4(-6.0, -3.0, -6.0, 0.0, -1.0, 2.0, 9.0, 1.0, -6.0, -5.0, -6.0, -1.0)) && allOk;
	allOk = compare_vec2((blockB.e), vec2(-5.0, 3.0)) && allOk;
	allOk = compare_ivec4((blockC.f.mA), ivec4(-4, -8, -5, -6)) && allOk;
	allOk = compare_mat2(blockC.f.mB, mat2(-9.0, -9.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat4x3(blockC.f.mC, mat4x3(7.0, -8.0, -3.0, -1.0, 1.0, -8.0, -2.0, 8.0, 3.0, 8.0, 4.0, -7.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC.f.mD), vec4(-3.0, -2.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat4x2(blockD[0].i, mat4x2(8.0, -4.0, 4.0, 2.0, -9.0, 8.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(blockE.k[0][0], mat3x4(8.0, -3.0, 0.0, 5.0, 5.0, -8.0, 1.0, -7.0, 3.0, 2.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat3x4(blockE.k[0][1], mat3x4(1.0, -4.0, -8.0, -2.0, 7.0, 3.0, 3.0, 1.0, -8.0, 7.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat3x4(blockE.k[0][2], mat3x4(1.0, 6.0, 2.0, 7.0, 6.0, 1.0, 1.0, -2.0, 4.0, 6.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat3x4(blockE.k[0][3], mat3x4(0.0, -3.0, 0.0, 9.0, -7.0, 0.0, -6.0, -5.0, 4.0, -6.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3x4(blockE.k[1][0], mat3x4(-7.0, -4.0, 5.0, -8.0, 8.0, -4.0, 8.0, 5.0, 8.0, -1.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat3x4(blockE.k[1][1], mat3x4(-4.0, -2.0, 4.0, 6.0, 3.0, -1.0, -6.0, 6.0, -5.0, -2.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3x4(blockE.k[1][2], mat3x4(-7.0, 4.0, 1.0, 9.0, 5.0, -2.0, 5.0, -7.0, 0.0, 2.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat3x4(blockE.k[1][3], mat3x4(-7.0, 0.0, 0.0, -3.0, 0.0, -2.0, 5.0, -4.0, -5.0, -8.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3x4(blockE.k[2][0], mat3x4(2.0, -6.0, -4.0, 6.0, 6.0, 3.0, 9.0, 7.0, 5.0, 3.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(blockE.k[2][1], mat3x4(9.0, -3.0, 9.0, -8.0, 0.0, -4.0, 4.0, 9.0, -1.0, -5.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3x4(blockE.k[2][2], mat3x4(1.0, 1.0, 0.0, -6.0, -5.0, -9.0, -5.0, -4.0, -3.0, -4.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3x4(blockE.k[2][3], mat3x4(-5.0, 2.0, 7.0, -5.0, 2.0, -7.0, 8.0, 3.0, -5.0, 0.0, 6.0, 8.0)) && allOk;
	allOk = compare_float((blockE.l.mA), 2.0) && allOk;
	allOk = compare_mat4x2(blockE.l.mB, mat4x2(-5.0, 3.0, 1.0, -6.0, -9.0, -4.0, 5.0, -3.0)) && allOk;
	allOk = compare_vec3((blockE.l.mC), vec3(3.0, -6.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i16vec4(ivec4(-7, -2, 8, -4));
	blockB.b.mA = (mat2(-8.0, 5.0, 3.0, 3.0));
	blockB.b.mB = f16vec2(vec2(9.0, -4.0));
	blockB.b.mC = i16vec3(ivec3(3, -8, -8));
	blockB.b.mD = (mat3x4(-8.0, -4.0, 2.0, -8.0, -2.0, 1.0, 7.0, 6.0, -3.0, -9.0, 6.0, 6.0));
	blockB.d = (ivec3(-6, 4, -7));
	blockB.e = (vec2(9.0, 5.0));
	blockC.g = (mat4x2(-1.0, -4.0, 7.0, -5.0, 1.0, 9.0, -6.0, -5.0));
	blockD[0].i = (mat4x2(3.0, -4.0, -2.0, -8.0, 0.0, -2.0, 1.0, 5.0));
	blockE.k[0][0] = (mat3x4(-1.0, 2.0, -5.0, 3.0, 0.0, 1.0, 8.0, -8.0, 1.0, -4.0, 7.0, 0.0));
	blockE.k[0][1] = (mat3x4(2.0, -9.0, -1.0, 9.0, 9.0, 6.0, 0.0, 3.0, 5.0, 8.0, 2.0, 3.0));
	blockE.k[0][2] = (mat3x4(-8.0, 1.0, 2.0, -3.0, -8.0, -2.0, 0.0, 3.0, 8.0, -5.0, 8.0, -9.0));
	blockE.k[0][3] = (mat3x4(4.0, 1.0, 7.0, 7.0, 5.0, 8.0, -6.0, 8.0, 8.0, 8.0, 5.0, -9.0));
	blockE.k[1][0] = (mat3x4(-3.0, 4.0, -4.0, 5.0, 6.0, -6.0, 8.0, 8.0, 9.0, -5.0, 8.0, -1.0));
	blockE.k[1][1] = (mat3x4(9.0, -4.0, 2.0, 0.0, 3.0, -6.0, 1.0, 3.0, -4.0, -3.0, -9.0, 3.0));
	blockE.k[1][2] = (mat3x4(-5.0, -6.0, 4.0, -8.0, -9.0, 6.0, 7.0, -3.0, -6.0, 7.0, -3.0, 7.0));
	blockE.k[1][3] = (mat3x4(-4.0, 3.0, 4.0, 9.0, -5.0, -6.0, 9.0, 7.0, 1.0, -1.0, -5.0, -7.0));
	blockE.k[2][0] = (mat3x4(0.0, -4.0, -6.0, 4.0, -6.0, -7.0, -9.0, 7.0, -3.0, 6.0, -3.0, -2.0));
	blockE.k[2][1] = (mat3x4(-8.0, -4.0, 9.0, -9.0, -9.0, -9.0, 3.0, -2.0, -9.0, -8.0, 6.0, 7.0));
	blockE.k[2][2] = (mat3x4(-5.0, -1.0, 3.0, -4.0, 1.0, 5.0, -5.0, 9.0, 8.0, 2.0, 6.0, -6.0));
	blockE.k[2][3] = (mat3x4(5.0, -2.0, -2.0, 8.0, 7.0, -3.0, -5.0, 7.0, 1.0, -7.0, -5.0, 2.0));
	blockE.l.mA = (-2.0);
	blockE.l.mB = (mat4x2(6.0, 8.0, 3.0, 6.0, 7.0, 3.0, 9.0, -5.0));
	blockE.l.mC = (vec3(-8.0, 3.0, -4.0));
}
#version 450
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
	float16_t a;
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	lowp ivec2 b;
	bvec4 c;
	f16vec4 d;
	mediump mat4x2 e;
	uint16_t f;
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	i16vec4 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[1];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockB.a), -1.0) && allOk;
	allOk = compare_mat4x2(blockC[0].e, mat4x2(3.0, -2.0, 8.0, -8.0, -2.0, 6.0, -9.0, -8.0)) && allOk;
	allOk = compare_uint16_t(uint(blockC[0].f), 3u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC[0].b = (ivec2(-7, 3));
	blockC[0].c = (bvec4(false, false, true, false));
	blockC[0].e = (mat4x2(-2.0, -5.0, -3.0, -5.0, -1.0, 9.0, 3.0, -2.0));
	blockC[0].f = uint16_t(9u);
	blockD.g[0] = i16vec4(ivec4(-4, -4, 8, -4));
	blockD.g[1] = i16vec4(ivec4(-8, 9, 2, -7));
	blockD.g[2] = i16vec4(ivec4(-3, 6, 3, 2));
	blockD.g[3] = i16vec4(ivec4(3, 6, 8, 5));
	blockD.g[4] = i16vec4(ivec4(-5, -8, -3, -8));
	blockD.g[5] = i16vec4(ivec4(6, -1, -5, -7));
	blockD.g[6] = i16vec4(ivec4(0, 5, -9, -3));
	blockD.g[7] = i16vec4(ivec4(-1, 0, -3, 0));
}
#version 450
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
	layout(offset = 0) f16vec2 a[1];
	layout(offset = 4) mediump uint b;
	layout(offset = 16) highp vec3 c;
	layout(offset = 28) mediump float d;
	layout(offset = 32) float16_t e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(blockB[0].a[0]), vec2(-7.0, -6.0)) && allOk;
	allOk = compare_uint((blockB[0].b), 0u) && allOk;
	allOk = compare_vec3((blockB[0].c), vec3(-9.0, 3.0, 3.0)) && allOk;
	allOk = compare_float((blockB[0].d), -4.0) && allOk;
	allOk = compare_float16_t(float(blockB[0].e), -2.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (9u);
	blockB[0].d = (4.0);
}
#version 450
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
	layout(offset = 0) highp int a;
	layout(offset = 4) highp float b;
	layout(offset = 8) int16_t c;
	layout(offset = 16) lowp ivec3 d;
	layout(offset = 28) u16vec2 e;
};
layout(buffer_reference) readonly buffer BlockC
{
	layout(offset = 0) mediump ivec2 f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.b), 8.0) && allOk;
	allOk = compare_ivec3((blockB.d), ivec3(-3, -3, 3)) && allOk;
	allOk = compare_u16vec2(uvec2(blockB.e), uvec2(7u, 5u)) && allOk;
	allOk = compare_ivec2((blockC.f), ivec2(-6, 7)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (-5);
	blockB.b = (-4.0);
	blockB.c = int16_t(8);
	blockB.d = (ivec3(-4, 1, -5));
	blockB.e = u16vec2(uvec2(2u, 8u));
}
#version 450
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
	highp mat4 mA;
	bvec2 mB;
};
layout(scalar, buffer_reference) buffer BlockB
{
	f16vec2 a;
	f16vec4 b;
	i16vec3 c;
	lowp int d;
	lowp float e[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	i16vec4 f;
	u16vec4 g;
	sA h;
	lowp mat3 i[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(blockB[0].a), vec2(-7.0, 8.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB[0].b), vec4(8.0, 2.0, 4.0, 0.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB[0].c), ivec3(-2, 6, -1)) && allOk;
	allOk = compare_float((blockB[0].e[0]), -9.0) && allOk;
	allOk = compare_float((blockB[0].e[1]), 9.0) && allOk;
	allOk = compare_float((blockB[0].e[2]), -2.0) && allOk;
	allOk = compare_float((blockB[0].e[3]), -9.0) && allOk;
	allOk = compare_float((blockB[0].e[4]), 2.0) && allOk;
	allOk = compare_float((blockB[0].e[5]), 0.0) && allOk;
	allOk = compare_float((blockB[0].e[6]), -9.0) && allOk;
	allOk = compare_f16vec2(vec2(blockB[1].a), vec2(0.0, -9.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB[1].b), vec4(7.0, 0.0, -2.0, -5.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB[1].c), ivec3(2, 4, -7)) && allOk;
	allOk = compare_float((blockB[1].e[0]), 9.0) && allOk;
	allOk = compare_float((blockB[1].e[1]), 8.0) && allOk;
	allOk = compare_float((blockB[1].e[2]), 9.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = f16vec2(vec2(0.0, -7.0));
	blockB[0].c = i16vec3(ivec3(4, 6, -8));
	blockB[0].d = (8);
	blockB[1].a = f16vec2(vec2(-6.0, -1.0));
	blockB[1].c = i16vec3(ivec3(-5, 3, 5));
	blockB[1].d = (-5);
	blockC[0].g = u16vec4(uvec4(0u, 0u, 4u, 9u));
	blockC[0].h.mA = (mat4(-4.0, 1.0, -8.0, 0.0, -5.0, -9.0, -8.0, 4.0, -1.0, 8.0, 3.0, 6.0, -3.0, 9.0, -3.0, 1.0));
	blockC[0].h.mB = (bvec2(false, false));
	blockC[0].i[0] = (mat3(0.0, 5.0, -6.0, -2.0, 2.0, -2.0, -1.0, -7.0, -6.0));
	blockC[0].i[1] = (mat3(9.0, 5.0, -9.0, 9.0, -3.0, -7.0, -9.0, 9.0, 6.0));
	blockC[0].i[2] = (mat3(9.0, 5.0, 5.0, 0.0, -3.0, 0.0, 4.0, 0.0, 1.0));
	blockC[0].i[3] = (mat3(-1.0, -6.0, -1.0, 0.0, 7.0, -5.0, -7.0, -2.0, -6.0));
	blockC[0].i[4] = (mat3(-6.0, 9.0, -4.0, 2.0, -4.0, 3.0, 5.0, -6.0, 5.0));
	blockC[0].i[5] = (mat3(0.0, -8.0, -7.0, 3.0, -4.0, 3.0, 2.0, -3.0, 1.0));
	blockC[0].i[6] = (mat3(6.0, -9.0, -1.0, 1.0, 0.0, -3.0, -9.0, -8.0, 8.0));
	blockC[1].g = u16vec4(uvec4(2u, 9u, 1u, 5u));
	blockC[1].h.mA = (mat4(1.0, -3.0, 5.0, 5.0, 4.0, -2.0, 9.0, 0.0, -3.0, 1.0, 7.0, -1.0, 5.0, -3.0, 3.0, -4.0));
	blockC[1].h.mB = (bvec2(false, true));
	blockC[1].i[0] = (mat3(-4.0, -6.0, 1.0, 0.0, -6.0, 8.0, 9.0, -4.0, -7.0));
	blockC[1].i[1] = (mat3(-3.0, 7.0, -2.0, 7.0, -9.0, -8.0, -6.0, -6.0, 2.0));
	blockC[1].i[2] = (mat3(-9.0, -6.0, 1.0, 4.0, -2.0, 2.0, -3.0, 7.0, -3.0));
	blockC[1].i[3] = (mat3(-7.0, 9.0, 2.0, 1.0, 9.0, 4.0, 8.0, -4.0, -8.0));
	blockC[1].i[4] = (mat3(-8.0, -4.0, -5.0, -5.0, 3.0, -1.0, 0.0, 1.0, -5.0));
	blockC[1].i[5] = (mat3(9.0, 8.0, -6.0, 1.0, 8.0, -6.0, 3.0, 8.0, -4.0));
	blockC[1].i[6] = (mat3(-1.0, 0.0, -7.0, -2.0, -4.0, 9.0, -8.0, 7.0, 9.0));
	blockC[1].i[7] = (mat3(7.0, -1.0, 0.0, 5.0, 4.0, -8.0, 0.0, -8.0, 6.0));
}
#version 450
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
	u16vec2 mB;
};
struct sB
{
	f16vec2 mA;
	i16vec2 mB;
	uint16_t mC;
	f16vec2 mD;
};
layout(scalar, column_major, buffer_reference) buffer BlockB
{
	f16vec4 a[8];
	sA b[3];
	sB c;
	lowp mat4x2 d[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	lowp ivec2 e;
	mediump mat4x3 f;
	highp mat4x2 g;
	highp mat4x2 h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(blockB.a[0]), vec4(-6.0, -5.0, 3.0, -9.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.a[1]), vec4(-7.0, 9.0, -5.0, 0.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.a[2]), vec4(-5.0, -1.0, 2.0, -2.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.a[3]), vec4(4.0, 6.0, 8.0, 2.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.a[4]), vec4(-6.0, -8.0, 6.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.a[5]), vec4(2.0, -2.0, 5.0, 0.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.a[6]), vec4(9.0, -5.0, 1.0, 2.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.a[7]), vec4(7.0, -5.0, 6.0, 7.0)) && allOk;
	allOk = compare_ivec2((blockC.e), ivec2(6, -5)) && allOk;
	allOk = compare_mat4x3(blockC.f, mat4x3(-5.0, -4.0, 4.0, 1.0, -8.0, 4.0, -3.0, -4.0, -2.0, 4.0, 8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = f16vec4(vec4(0.0, 9.0, 5.0, -7.0));
	blockB.a[1] = f16vec4(vec4(-6.0, 9.0, -5.0, 2.0));
	blockB.a[2] = f16vec4(vec4(-5.0, 0.0, 0.0, 7.0));
	blockB.a[3] = f16vec4(vec4(4.0, -9.0, 1.0, 4.0));
	blockB.a[4] = f16vec4(vec4(-5.0, -3.0, -4.0, 6.0));
	blockB.a[5] = f16vec4(vec4(5.0, 7.0, -4.0, 8.0));
	blockB.a[6] = f16vec4(vec4(-5.0, -3.0, -2.0, -1.0));
	blockB.a[7] = f16vec4(vec4(1.0, 3.0, 0.0, -9.0));
	blockB.b[0].mA = (0.0);
	blockB.b[0].mB = u16vec2(uvec2(9u, 9u));
	blockB.b[1].mA = (-9.0);
	blockB.b[1].mB = u16vec2(uvec2(6u, 5u));
	blockB.b[2].mA = (9.0);
	blockB.b[2].mB = u16vec2(uvec2(6u, 9u));
	blockC.e = (ivec2(-1, -8));
	blockC.f = (mat4x3(-8.0, 4.0, 7.0, 8.0, -5.0, 5.0, 0.0, 1.0, -4.0, 0.0, -8.0, -9.0));
	blockC.g = (mat4x2(5.0, -9.0, 4.0, 1.0, 8.0, 9.0, 7.0, 5.0));
	blockC.h[0] = (mat4x2(-5.0, -5.0, 6.0, 7.0, -6.0, 4.0, -4.0, 7.0));
	blockC.h[1] = (mat4x2(8.0, -6.0, 7.0, -3.0, 7.0, -6.0, -1.0, -6.0));
	blockC.h[2] = (mat4x2(-6.0, -2.0, 0.0, 8.0, -9.0, -6.0, 3.0, 1.0));
	blockC.h[3] = (mat4x2(-2.0, 6.0, -6.0, -7.0, -8.0, -8.0, -7.0, -3.0));
	blockC.h[4] = (mat4x2(-3.0, 5.0, 4.0, -8.0, 5.0, -2.0, -5.0, 0.0));
}
#version 450
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
	lowp mat4 a;
	lowp vec3 b;
	bvec4 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.a, mat4(5.0, 7.0, -8.0, 7.0, -2.0, -4.0, 0.0, -7.0, 0.0, 7.0, -7.0, -1.0, -5.0, 3.0, -3.0, -9.0)) && allOk;
	allOk = compare_bvec4((blockB.c), bvec4(false, false, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4(-4.0, -8.0, 1.0, -1.0, -2.0, 0.0, 8.0, 0.0, -4.0, -8.0, 9.0, 5.0, -7.0, -1.0, 8.0, -6.0));
}
#version 450
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
	highp vec4 a;
	i8vec4 b;
	bvec3 c;
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	i8vec3 d;
	highp float e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(blockC.d), ivec3(7, 4294967289, 7)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec4(-6.0, -2.0, 3.0, -5.0));
	blockB.b = i8vec4(ivec4(4294967292, 5, 4294967287, 8));
	blockC.d = i8vec3(ivec3(4294967293, 7, 3));
	blockC.e = (2.0);
}
#version 450
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
	highp uvec4 a;
	lowp mat2x3 b[];
};
layout(std140, buffer_reference) buffer BlockC
{
	highp mat4x3 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a), uvec4(1u, 9u, 8u, 5u)) && allOk;
	allOk = compare_mat2x3(blockB.b[0], mat2x3(1.0, -7.0, 1.0, 2.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat2x3(blockB.b[1], mat2x3(9.0, -8.0, 2.0, 9.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x3(blockB.b[2], mat2x3(7.0, 3.0, -3.0, 7.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat2x3(blockB.b[3], mat2x3(9.0, 2.0, -5.0, 1.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockC.c[0], mat4x3(5.0, 5.0, -3.0, 3.0, 1.0, -9.0, 7.0, -2.0, 2.0, 9.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat4x3(blockC.c[1], mat4x3(1.0, 1.0, -9.0, -3.0, -9.0, -7.0, -4.0, -4.0, -6.0, 1.0, 3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec4(5u, 2u, 5u, 7u));
	blockB.b[0] = (mat2x3(-8.0, -5.0, 0.0, 0.0, -7.0, 5.0));
	blockB.b[1] = (mat2x3(3.0, 4.0, 7.0, 8.0, 3.0, 8.0));
	blockB.b[2] = (mat2x3(8.0, 0.0, 8.0, -6.0, 5.0, 1.0));
	blockB.b[3] = (mat2x3(7.0, -1.0, -9.0, -2.0, -7.0, -5.0));
	blockC.c[0] = (mat4x3(7.0, -9.0, -5.0, 5.0, 3.0, 7.0, -7.0, -6.0, 1.0, 8.0, 8.0, -9.0));
	blockC.c[1] = (mat4x3(-8.0, 4.0, 8.0, 5.0, 3.0, 5.0, -4.0, 8.0, 8.0, 0.0, -8.0, 1.0));
}
#version 450
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
	lowp ivec4 a;
	lowp ivec4 b;
	lowp mat4x3 c[];
};
layout(std430, buffer_reference) buffer BlockC
{
	highp mat2x3 d;
	bool e;
};
layout(std140, buffer_reference) buffer BlockD
{
	lowp uint f;
	bvec2 g;
	i8vec2 h;
	u8vec4 i[];
};
layout(std430, buffer_reference) buffer BlockE
{
	bvec4 j;
	u8vec2 k;
	int8_t l;
	mediump mat4x3 m[];
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.a), ivec4(1, -5, -9, -5)) && allOk;
	allOk = compare_ivec4((blockB.b), ivec4(1, -7, 1, 2)) && allOk;
	allOk = compare_bool((blockC.e), false) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.h), ivec2(1, 4294967287)) && allOk;
	allOk = compare_u8vec2(uvec2(blockE.k), uvec2(0u, 6u)) && allOk;
	allOk = compare_int8_t(int(blockE.l), 4294967289) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (ivec4(-8, -5, 0, 0));
	blockC.d = (mat2x3(5.0, 1.0, 7.0, -1.0, -9.0, -2.0));
	blockC.e = (true);
	blockD.f = (4u);
	blockE.k = u8vec2(uvec2(4u, 6u));
	blockE.l = int8_t(4294967292);
	blockE.m[0] = (mat4x3(8.0, 8.0, 0.0, -8.0, 1.0, -8.0, 2.0, -7.0, -2.0, 2.0, -5.0, -5.0));
}
#version 450
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
	highp mat2x3 b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(blockB.a), 2) && allOk;
	allOk = compare_mat2x3(blockB.b[0], mat2x3(5.0, 9.0, -9.0, -9.0, -4.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (mat2x3(-4.0, 2.0, -1.0, 2.0, 2.0, -5.0));
}
#version 450
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
	mediump mat4x3 b[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	mediump mat4x3 c;
	lowp mat2x3 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.b[0], mat4x3(9.0, -7.0, -4.0, -4.0, -6.0, -2.0, 8.0, 4.0, -4.0, -9.0, -9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i8vec2(ivec2(4, 0));
	blockB.b[0] = (mat4x3(9.0, 4.0, 1.0, -7.0, -4.0, -4.0, -6.0, -5.0, -2.0, 4.0, -2.0, 5.0));
	blockC.c = (mat4x3(-9.0, -3.0, -1.0, -9.0, 1.0, 1.0, 7.0, 8.0, 9.0, -7.0, -1.0, -6.0));
	blockC.d[0] = (mat2x3(5.0, 6.0, 5.0, 6.0, -6.0, -9.0));
}
#version 450
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
	mediump mat4x3 mA;
};
struct sB
{
	sA mA;
	lowp mat4 mB;
	i8vec2 mC;
	highp mat3x4 mD;
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	lowp vec2 a;
	i8vec3 b;
	u8vec3 c;
	lowp int d[];
};
layout(std140, buffer_reference) buffer BlockC
{
	u8vec2 e;
	mediump mat4x2 f;
	bool g;
	sB h;
	i8vec2 i[];
};
layout(std430, buffer_reference) buffer BlockD
{
	lowp ivec2 j;
	lowp mat4x2 k;
	bvec4 l;
	mediump mat4x2 m;
	highp mat2 n;
};
layout(std430, row_major, buffer_reference) buffer BlockE
{
	u8vec3 o;
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(-4.0, 6.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.b), ivec3(6, 4294967289, 4294967287)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.c), uvec3(2u, 4u, 7u)) && allOk;
	allOk = compare_mat4x2(blockC.f, mat4x2(4.0, -6.0, -3.0, 2.0, -9.0, -7.0, -5.0, -7.0)) && allOk;
	allOk = compare_bool((blockC.g), true) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.i[0]), ivec2(0, 4294967289)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.i[1]), ivec2(4294967288, 2)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.i[2]), ivec2(4, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.i[3]), ivec2(4294967287, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.i[4]), ivec2(0, 4)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.i[5]), ivec2(4294967289, 4294967295)) && allOk;
	allOk = compare_mat4x2(blockD.k, mat4x2(-7.0, 1.0, -5.0, 6.0, -8.0, -5.0, 5.0, -2.0)) && allOk;
	allOk = compare_bvec4((blockD.l), bvec4(false, true, true, true)) && allOk;
	allOk = compare_mat4x2(blockD.m, mat4x2(0.0, -9.0, 8.0, 3.0, -7.0, -1.0, 0.0, -2.0)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE.o), uvec3(5u, 4u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec2(9.0, -7.0));
	blockB.b = i8vec3(ivec3(4294967291, 4294967287, 4294967288));
	blockB.d[0] = (8);
	blockB.d[1] = (7);
	blockC.e = u8vec2(uvec2(0u, 9u));
	blockC.h.mA.mA = (mat4x3(-2.0, 4.0, -6.0, 5.0, -4.0, 9.0, 1.0, 4.0, -5.0, 8.0, -5.0, 4.0));
	blockC.h.mB = (mat4(-9.0, -1.0, -6.0, 9.0, -8.0, -4.0, -9.0, 9.0, -2.0, 3.0, 1.0, -6.0, -2.0, 5.0, -3.0, 4.0));
	blockC.h.mC = i8vec2(ivec2(7, 4294967295));
	blockC.h.mD = (mat3x4(-2.0, 2.0, -2.0, 1.0, 0.0, 2.0, -9.0, 0.0, 7.0, -3.0, -5.0, 8.0));
	blockC.i[0] = i8vec2(ivec2(2, 2));
	blockC.i[1] = i8vec2(ivec2(4294967294, 4294967295));
	blockC.i[2] = i8vec2(ivec2(4, 4294967293));
	blockC.i[3] = i8vec2(ivec2(4294967295, 4294967294));
	blockC.i[4] = i8vec2(ivec2(2, 4294967293));
	blockC.i[5] = i8vec2(ivec2(4294967295, 4294967290));
	blockD.k = (mat4x2(-8.0, 6.0, 7.0, -3.0, -2.0, -3.0, 0.0, 7.0));
	blockD.n = (mat2(-8.0, 1.0, 1.0, -6.0));
	blockE.o = u8vec3(uvec3(3u, 1u, 7u));
}
#version 450
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
	mediump uvec3 mB;
};
struct sB
{
	lowp mat4x3 mA;
	mediump ivec2 mB;
	bvec3 mC;
	lowp ivec2 mD;
};
layout(std140, buffer_reference) buffer BlockB
{
	sA a;
	highp uvec3 b;
	mediump uint c;
	mediump uvec2 d;
	sB e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB[0].a.mA), uvec2(3u, 0u)) && allOk;
	allOk = compare_uvec3((blockB[0].a.mB), uvec3(3u, 0u, 4u)) && allOk;
	allOk = compare_uvec3((blockB[0].b), uvec3(5u, 4u, 3u)) && allOk;
	allOk = compare_uint((blockB[0].c), 2u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].c = (4u);
	blockB[0].d = (uvec2(5u, 4u));
	blockB[0].e.mA = (mat4x3(1.0, 9.0, -5.0, 9.0, -3.0, 6.0, 7.0, -9.0, -6.0, -1.0, 3.0, 5.0));
	blockB[0].e.mB = (ivec2(3, 9));
	blockB[0].e.mC = (bvec3(false, false, true));
	blockB[0].e.mD = (ivec2(-1, 2));
}
#version 450
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
struct sB
{
	lowp uvec4 mA;
	mediump ivec2 mB;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	lowp mat3x2 a;
	lowp ivec2 b[1];
	highp vec2 c;
	sA d[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	lowp ivec2 e;
	sB f;
	mediump uvec4 g;
	uint8_t h;
	uint8_t i[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.a, mat3x2(-7.0, -9.0, -6.0, 3.0, -2.0, 3.0)) && allOk;
	allOk = compare_ivec2((blockB.b[0]), ivec2(-4, -2)) && allOk;
	allOk = compare_vec2((blockB.c), vec2(-2.0, -4.0)) && allOk;
	allOk = compare_bool((blockB.d[0].mA), true) && allOk;
	allOk = compare_bool((blockB.d[1].mA), true) && allOk;
	allOk = compare_bool((blockB.d[2].mA), true) && allOk;
	allOk = compare_ivec2((blockC.e), ivec2(-9, 3)) && allOk;
	allOk = compare_uvec4((blockC.f.mA), uvec4(0u, 3u, 3u, 2u)) && allOk;
	allOk = compare_ivec2((blockC.f.mB), ivec2(-1, -9)) && allOk;
	allOk = compare_uvec4((blockC.g), uvec4(1u, 1u, 6u, 9u)) && allOk;
	allOk = compare_uint8_t(uint(blockC.h), 8u) && allOk;
	allOk = compare_uint8_t(uint(blockC.i[0]), 5u) && allOk;
	allOk = compare_uint8_t(uint(blockC.i[1]), 5u) && allOk;
	allOk = compare_uint8_t(uint(blockC.i[2]), 7u) && allOk;
	allOk = compare_uint8_t(uint(blockC.i[3]), 3u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x2(-6.0, -4.0, -1.0, 7.0, 8.0, 7.0));
	blockB.b[0] = (ivec2(4, -9));
	blockB.c = (vec2(-6.0, 5.0));
	blockB.d[0].mA = (true);
	blockB.d[1].mA = (false);
	blockB.d[2].mA = (false);
	blockC.e = (ivec2(-9, -8));
	blockC.f.mA = (uvec4(9u, 0u, 2u, 3u));
	blockC.f.mB = (ivec2(-6, 9));
	blockC.g = (uvec4(5u, 7u, 4u, 2u));
	blockC.h = uint8_t(3u);
	blockC.i[0] = uint8_t(8u);
	blockC.i[1] = uint8_t(7u);
	blockC.i[2] = uint8_t(9u);
	blockC.i[3] = uint8_t(4u);
}
#version 450
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
	layout(offset = 0) i8vec2 a;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) i8vec4 b;
	layout(offset = 4) highp ivec3 c;
	layout(offset = 16) highp uint d;
	layout(offset = 20) mediump uvec2 e;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) mediump int f;
	layout(offset = 16) lowp vec4 g;
	layout(offset = 32) i8vec2 h;
	layout(offset = 36) lowp vec3 i;
	layout(offset = 48) i8vec3 j;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(blockC.b), ivec4(9, 4294967288, 4294967287, 4294967288)) && allOk;
	allOk = compare_ivec3((blockC.c), ivec3(1, 7, -1)) && allOk;
	allOk = compare_uint((blockC.d), 3u) && allOk;
	allOk = compare_uvec2((blockC.e), uvec2(0u, 5u)) && allOk;
	allOk = compare_vec4((blockD.g), vec4(4.0, 3.0, -5.0, -4.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.h), ivec2(9, 2)) && allOk;
	allOk = compare_vec3((blockD.i), vec3(-4.0, 0.0, 7.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockD.j), ivec3(4294967294, 9, 4294967290)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i8vec2(ivec2(4294967293, 9));
	blockC.e = (uvec2(3u, 7u));
	blockD.f = (-2);
	blockD.g = (vec4(7.0, 7.0, 1.0, -9.0));
	blockD.h = i8vec2(ivec2(4, 5));
	blockD.i = (vec3(9.0, -5.0, -9.0));
}
#version 450
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
	lowp mat4 a;
	i8vec2 b;
	u8vec2 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.a, mat4(5.0, 7.0, -8.0, 7.0, -2.0, -4.0, 0.0, -7.0, 0.0, 7.0, -7.0, -1.0, -5.0, 3.0, -3.0, -9.0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB.c[0]), uvec2(2u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB.c[1]), uvec2(8u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB.c[2]), uvec2(5u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB.c[3]), uvec2(6u, 1u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB.c[4]), uvec2(6u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4(-4.0, -8.0, 1.0, -1.0, -2.0, 0.0, 8.0, 0.0, -4.0, -8.0, 9.0, 5.0, -7.0, -1.0, 8.0, -6.0));
	blockB.b = i8vec2(ivec2(4294967294, 4294967287));
	blockB.c[0] = u8vec2(uvec2(2u, 5u));
	blockB.c[1] = u8vec2(uvec2(0u, 4u));
	blockB.c[2] = u8vec2(uvec2(3u, 4u));
	blockB.c[3] = u8vec2(uvec2(9u, 1u));
	blockB.c[4] = u8vec2(uvec2(6u, 9u));
}
#version 450
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
	mediump float a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB[nonuniformEXT(0)].a), 1.0) && allOk;
	allOk = compare_float((blockB[nonuniformEXT(1)].a), -3.0) && allOk;
	allOk = compare_float((blockB[nonuniformEXT(2)].a), 9.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (9.0);
	blockB[nonuniformEXT(1)].a = (-2.0);
	blockB[nonuniformEXT(2)].a = (-3.0);
}
