#version 450
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
	allOk = compare_float(var[0][0], 7.0) && allOk;
	allOk = compare_float(var[0][1], -2.0) && allOk;
	allOk = compare_float(var[1][0], -3.0) && allOk;
	allOk = compare_float(var[1][1], 8.0) && allOk;
	allOk = compare_vec2(var[0], vec2(7.0, -2.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-3.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec2(2.0, -7.0));
	var[1] = (vec2(-5.0, 4.0));
}
#version 450
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
	allOk = compare_float(var[0][0], 6.0) && allOk;
	allOk = compare_float(var[0][1], -4.0) && allOk;
	allOk = compare_float(var[0][2], 4.0) && allOk;
	allOk = compare_float(var[1][0], -4.0) && allOk;
	allOk = compare_float(var[1][1], -3.0) && allOk;
	allOk = compare_float(var[1][2], 8.0) && allOk;
	allOk = compare_float(var[2][0], -3.0) && allOk;
	allOk = compare_float(var[2][1], 9.0) && allOk;
	allOk = compare_float(var[2][2], 7.0) && allOk;
	allOk = compare_vec3(var[0], vec3(6.0, -4.0, 4.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-4.0, -3.0, 8.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-3.0, 9.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3(-8.0, 5.0, -9.0, 5.0, 0.0, -3.0, 9.0, 2.0, -3.0));
}
#version 450
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
	uint8_t var;
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(var), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	var = uint8_t(9u);
}
#version 450
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
	f16vec3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(var), vec3(4.0, 1.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = f16vec3(vec3(3.0, 3.0, 7.0));
}
#version 450
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
	allOk = compare_mat3(var, mat3(8.0, -9.0, -3.0, 9.0, -7.0, 0.0, -4.0, -9.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(7.0, 2.0, 0.0));
	var[1] = (vec3(-9.0, -8.0, 0.0));
	var[2] = (vec3(3.0, 2.0, 6.0));
}
#version 450
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
	mediump mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var, mat3(3.0, 5.0, -3.0, -2.0, -9.0, -9.0, 4.0, -4.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(-6.0, -3.0, 9.0));
	var[1] = (vec3(-2.0, -6.0, -6.0));
	var[2] = (vec3(3.0, -9.0, 7.0));
}
#version 450
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
	lowp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var, mat2x3(9.0, 1.0, -4.0, 3.0, 3.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(8.0, 9.0, 9.0));
	var[1] = (vec3(2.0, -6.0, 2.0));
}
#version 450
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
	lowp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var, mat3x2(8.0, 9.0, 7.0, 1.0, -5.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec2(7.0, 7.0));
	var[1] = (vec2(5.0, 7.0));
	var[2] = (vec2(4.0, 8.0));
}
#version 450
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
	mediump mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -7.0) && allOk;
	allOk = compare_float(var[0][1], 5.0) && allOk;
	allOk = compare_float(var[1][0], 5.0) && allOk;
	allOk = compare_float(var[1][1], -5.0) && allOk;
	allOk = compare_float(var[2][0], -2.0) && allOk;
	allOk = compare_float(var[2][1], 2.0) && allOk;
	allOk = compare_float(var[3][0], -4.0) && allOk;
	allOk = compare_float(var[3][1], 3.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-7.0, 5.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(5.0, -5.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-2.0, 2.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(-4.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x2(4.0, 4.0, -5.0, -6.0, 0.0, 4.0, 2.0, 9.0));
}
#version 450
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
	allOk = compare_mat4x3(var, mat4x3(8.0, -4.0, -2.0, 8.0, 8.0, 0.0, -3.0, -1.0, -2.0, 0.0, 6.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(-9.0, 2.0, -2.0));
	var[1] = (vec3(0.0, -7.0, 0.0));
	var[2] = (vec3(1.0, -1.0, 6.0));
	var[3] = (vec3(-7.0, 7.0, 9.0));
}
#version 450
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
	allOk = compare_float((padding), -4.0) && allOk;
	allOk = compare_mat3(var, mat3(6.0, -1.0, -6.0, -5.0, -8.0, 5.0, 6.0, 7.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-9.0);
	var = (mat3(3.0, -5.0, 8.0, 0.0, 9.0, -8.0, 1.0, -5.0, -7.0));
}
#version 450
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
	highp mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 5.0) && allOk;
	allOk = compare_float(var[0][0], -8.0) && allOk;
	allOk = compare_float(var[0][1], 1.0) && allOk;
	allOk = compare_float(var[0][2], 8.0) && allOk;
	allOk = compare_float(var[0][3], -7.0) && allOk;
	allOk = compare_float(var[1][0], -7.0) && allOk;
	allOk = compare_float(var[1][1], 5.0) && allOk;
	allOk = compare_float(var[1][2], -5.0) && allOk;
	allOk = compare_float(var[1][3], -6.0) && allOk;
	allOk = compare_float(var[2][0], -3.0) && allOk;
	allOk = compare_float(var[2][1], 3.0) && allOk;
	allOk = compare_float(var[2][2], 1.0) && allOk;
	allOk = compare_float(var[2][3], -1.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-8.0, 1.0, 8.0, -7.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-7.0, 5.0, -5.0, -6.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-3.0, 3.0, 1.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-3.0);
	var = (mat3x4(0.0, -2.0, -2.0, -2.0, 6.0, 2.0, 9.0, -5.0, -2.0, -8.0, -8.0, -1.0));
}
#version 450
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
	mediump mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 9.0) && allOk;
	allOk = compare_float(var[0][0], -1.0) && allOk;
	allOk = compare_float(var[0][1], -8.0) && allOk;
	allOk = compare_float(var[1][0], 6.0) && allOk;
	allOk = compare_float(var[1][1], -4.0) && allOk;
	allOk = compare_float(var[2][0], -8.0) && allOk;
	allOk = compare_float(var[2][1], -3.0) && allOk;
	allOk = compare_float(var[3][0], -8.0) && allOk;
	allOk = compare_float(var[3][1], 7.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-1.0, -8.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(6.0, -4.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-8.0, -3.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(-8.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-6.0);
	var = (mat4x2(-9.0, 0.0, 8.0, -9.0, 9.0, 4.0, -9.0, 6.0));
}
#version 450
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
	u16vec4 var;
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(padding), 6u) && allOk;
	allOk = compare_u16vec4(uvec4(var), uvec4(0u, 8u, 3u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = uint16_t(0u);
	var = u16vec4(uvec4(6u, 9u, 4u, 5u));
}
#version 450
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

layout(std140, binding = 1) buffer Block
{
	highp int var[3];
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((var[0]), 6) && allOk;
	allOk = compare_int((var[1]), 0) && allOk;
	allOk = compare_int((var[2]), 9) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (8);
	var[1] = (2);
	var[2] = (-5);
}
#version 450
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

layout(std430, row_major, binding = 1) buffer Block
{
	highp mat2x3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0], mat2x3(1.0, -3.0, 8.0, -6.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(4.0, -9.0, -8.0, -2.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(-7.0, -2.0, 0.0, -6.0, 5.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec3(-7.0, -8.0, 7.0));
	var[0][1] = (vec3(-6.0, -3.0, -4.0));
	var[1][0] = (vec3(3.0, -8.0, -9.0));
	var[1][1] = (vec3(-2.0, 5.0, 6.0));
	var[2][0] = (vec3(6.0, -5.0, -7.0));
	var[2][1] = (vec3(1.0, 1.0, -3.0));
}
#version 450
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
	highp mat3x2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0], mat3x2(-8.0, -5.0, -1.0, 5.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(7.0, -5.0, -1.0, -7.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(3.0, 7.0, 0.0, 5.0, 0.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec2(-4.0, -6.0));
	var[0][1] = (vec2(1.0, -3.0));
	var[0][2] = (vec2(-1.0, -9.0));
	var[1][0] = (vec2(3.0, -2.0));
	var[1][1] = (vec2(5.0, -8.0));
	var[1][2] = (vec2(2.0, -9.0));
	var[2][0] = (vec2(1.0, -5.0));
	var[2][1] = (vec2(0.0, -2.0));
	var[2][2] = (vec2(2.0, -1.0));
}
#version 450
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

layout(scalar, column_major, binding = 1) buffer Block
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
	allOk = compare_float((padding), 2.0) && allOk;
	allOk = compare_mat2x3(var[0], mat2x3(-7.0, 8.0, 7.0, -6.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(-2.0, 1.0, -7.0, -8.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(7.0, 2.0, -2.0, -3.0, -8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (0.0);
	var[0] = (mat2x3(6.0, 9.0, 9.0, -8.0, 7.0, 5.0));
	var[1] = (mat2x3(-1.0, -9.0, 0.0, 8.0, 1.0, -7.0));
	var[2] = (mat2x3(2.0, 4.0, -8.0, 4.0, 4.0, -4.0));
}
#version 450
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
	u8vec2 var[3];
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(padding), 3u) && allOk;
	allOk = compare_u8vec2(uvec2(var[0]), uvec2(0u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1]), uvec2(2u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2]), uvec2(2u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = uint8_t(7u);
	var[0] = u8vec2(uvec2(7u, 9u));
	var[1] = u8vec2(uvec2(6u, 0u));
	var[2] = u8vec2(uvec2(2u, 1u));
}
#version 450
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

	var[0] = (mat2x3(-1.0, -2.0, -5.0, 0.0, 7.0, -2.0));
	var[1] = (mat2x3(0.0, 9.0, 9.0, 8.0, -6.0, 3.0));
	var[2] = (mat2x3(-9.0, 0.0, 1.0, 1.0, 7.0, -8.0));
	var[3] = (mat2x3(7.0, -4.0, 4.0, -5.0, -1.0, 0.0));
	var[4] = (mat2x3(2.0, -5.0, 6.0, 7.0, -2.0, 4.0));
	var[5] = (mat2x3(-3.0, 7.0, 6.0, -3.0, -2.0, -6.0));
	var[6] = (mat2x3(7.0, -3.0, 2.0, 8.0, -1.0, 2.0));
	var[7] = (mat2x3(2.0, -9.0, 3.0, 1.0, -7.0, -7.0));
	var[8] = (mat2x3(3.0, -3.0, -5.0, 4.0, -6.0, 8.0));
	var[9] = (mat2x3(7.0, -9.0, 2.0, -8.0, 9.0, 9.0));
	var[10] = (mat2x3(3.0, 5.0, 8.0, 5.0, -7.0, 6.0));
	var[11] = (mat2x3(3.0, 6.0, 6.0, 1.0, 2.0, -7.0));
	var[12] = (mat2x3(-9.0, 1.0, 2.0, -3.0, 0.0, -3.0));
	var[13] = (mat2x3(-2.0, 3.0, -2.0, 5.0, -6.0, -7.0));
	var[14] = (mat2x3(-7.0, 3.0, -4.0, -6.0, -2.0, 6.0));
	var[15] = (mat2x3(-7.0, -3.0, 3.0, -9.0, 3.0, 8.0));
	var[16] = (mat2x3(-1.0, 7.0, 4.0, -9.0, -7.0, 2.0));
	var[17] = (mat2x3(1.0, -7.0, -2.0, 5.0, -6.0, -6.0));
	var[18] = (mat2x3(-1.0, -2.0, 6.0, 9.0, 1.0, -6.0));
}
#version 450
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

	var[0] = uint8_t(9u);
	var[1] = uint8_t(5u);
	var[2] = uint8_t(2u);
	var[3] = uint8_t(6u);
	var[4] = uint8_t(7u);
	var[5] = uint8_t(5u);
	var[6] = uint8_t(8u);
	var[7] = uint8_t(4u);
	var[8] = uint8_t(2u);
	var[9] = uint8_t(6u);
	var[10] = uint8_t(0u);
	var[11] = uint8_t(1u);
	var[12] = uint8_t(6u);
	var[13] = uint8_t(0u);
	var[14] = uint8_t(5u);
	var[15] = uint8_t(4u);
	var[16] = uint8_t(1u);
	var[17] = uint8_t(3u);
	var[18] = uint8_t(0u);
}
#version 450
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
	highp ivec4 var[];
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((var[0]), ivec4(-7, 9, -5, 6)) && allOk;
	allOk = compare_ivec4((var[1]), ivec4(3, 4, 2, -3)) && allOk;
	allOk = compare_ivec4((var[2]), ivec4(-3, -3, -5, -5)) && allOk;
	allOk = compare_ivec4((var[3]), ivec4(3, -5, -9, -7)) && allOk;
	allOk = compare_ivec4((var[4]), ivec4(1, 5, 9, 7)) && allOk;
	allOk = compare_ivec4((var[5]), ivec4(-4, -1, 8, -1)) && allOk;
	allOk = compare_ivec4((var[6]), ivec4(4, 3, 6, -6)) && allOk;
	allOk = compare_ivec4((var[7]), ivec4(1, -3, 0, 0)) && allOk;
	allOk = compare_ivec4((var[8]), ivec4(1, -6, 0, -7)) && allOk;
	allOk = compare_ivec4((var[9]), ivec4(6, -4, -4, 0)) && allOk;
	allOk = compare_ivec4((var[10]), ivec4(8, -3, 3, 3)) && allOk;
	allOk = compare_ivec4((var[11]), ivec4(-3, 1, 3, 1)) && allOk;
	allOk = compare_ivec4((var[12]), ivec4(-7, 2, 6, -5)) && allOk;
	allOk = compare_ivec4((var[13]), ivec4(1, 5, 7, 9)) && allOk;
	allOk = compare_ivec4((var[14]), ivec4(-6, 4, 0, 9)) && allOk;
	allOk = compare_ivec4((var[15]), ivec4(-3, 6, -6, -6)) && allOk;
	allOk = compare_ivec4((var[16]), ivec4(1, -6, -3, 5)) && allOk;
	allOk = compare_ivec4((var[17]), ivec4(9, -7, -1, -9)) && allOk;
	allOk = compare_ivec4((var[18]), ivec4(8, -5, 1, -2)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (ivec4(5, -9, 5, -6));
	var[1] = (ivec4(-2, -4, 1, -9));
	var[2] = (ivec4(7, 3, 6, 8));
	var[3] = (ivec4(6, -4, 6, -7));
	var[4] = (ivec4(9, -8, -9, 0));
	var[5] = (ivec4(5, -7, 2, 9));
	var[6] = (ivec4(6, 5, 4, 0));
	var[7] = (ivec4(5, 9, 0, 0));
	var[8] = (ivec4(-6, 4, 4, 2));
	var[9] = (ivec4(9, 7, 5, 5));
	var[10] = (ivec4(3, -3, -9, -8));
	var[11] = (ivec4(-6, 3, 2, 0));
	var[12] = (ivec4(7, 1, -4, 4));
	var[13] = (ivec4(-2, 5, -8, 0));
	var[14] = (ivec4(8, -9, -8, -3));
	var[15] = (ivec4(3, -9, -5, -4));
	var[16] = (ivec4(-8, 8, -3, 2));
	var[17] = (ivec4(-2, -6, 4, -5));
	var[18] = (ivec4(6, 8, -7, -2));
}
#version 450
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

layout(scalar, row_major, binding = 1) buffer Block
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

	var[0][0] = (vec4(-2.0, -8.0, -5.0, 9.0));
	var[0][1] = (vec4(-8.0, -4.0, 1.0, -8.0));
	var[0][2] = (vec4(-4.0, 3.0, 6.0, -4.0));
	var[1][0] = (vec4(-4.0, -7.0, 6.0, -4.0));
	var[1][1] = (vec4(0.0, 7.0, -9.0, 4.0));
	var[1][2] = (vec4(-4.0, -4.0, -8.0, 9.0));
	var[2][0] = (vec4(2.0, -7.0, 2.0, -6.0));
	var[2][1] = (vec4(-1.0, -7.0, 7.0, 1.0));
	var[2][2] = (vec4(0.0, 4.0, 1.0, -9.0));
	var[3][0] = (vec4(3.0, -3.0, 5.0, 9.0));
	var[3][1] = (vec4(4.0, -2.0, -3.0, -6.0));
	var[3][2] = (vec4(8.0, 9.0, -9.0, -5.0));
	var[4][0] = (vec4(3.0, 4.0, -1.0, -5.0));
	var[4][1] = (vec4(9.0, -2.0, 4.0, -9.0));
	var[4][2] = (vec4(1.0, -8.0, -2.0, 1.0));
	var[5][0] = (vec4(-8.0, -2.0, 9.0, 8.0));
	var[5][1] = (vec4(-5.0, -8.0, -2.0, 7.0));
	var[5][2] = (vec4(-3.0, -9.0, 0.0, -9.0));
	var[6][0] = (vec4(7.0, 4.0, -2.0, -4.0));
	var[6][1] = (vec4(6.0, -9.0, -7.0, 3.0));
	var[6][2] = (vec4(-3.0, -6.0, -1.0, 0.0));
	var[7][0] = (vec4(2.0, 3.0, -1.0, 9.0));
	var[7][1] = (vec4(-3.0, -9.0, -1.0, 0.0));
	var[7][2] = (vec4(-9.0, 1.0, 6.0, 5.0));
	var[8][0] = (vec4(-8.0, 4.0, -8.0, 5.0));
	var[8][1] = (vec4(4.0, 3.0, -7.0, 5.0));
	var[8][2] = (vec4(-4.0, 7.0, 2.0, -6.0));
	var[9][0] = (vec4(-2.0, 4.0, -9.0, -3.0));
	var[9][1] = (vec4(7.0, 5.0, -1.0, 1.0));
	var[9][2] = (vec4(6.0, -2.0, -5.0, 9.0));
	var[10][0] = (vec4(-6.0, 2.0, 5.0, -5.0));
	var[10][1] = (vec4(2.0, 4.0, -3.0, 1.0));
	var[10][2] = (vec4(9.0, -1.0, -1.0, -1.0));
	var[11][0] = (vec4(7.0, -4.0, -7.0, -3.0));
	var[11][1] = (vec4(9.0, -7.0, -5.0, -9.0));
	var[11][2] = (vec4(3.0, 9.0, 2.0, -5.0));
	var[12][0] = (vec4(7.0, 5.0, 1.0, 8.0));
	var[12][1] = (vec4(-4.0, 6.0, -3.0, -6.0));
	var[12][2] = (vec4(2.0, -9.0, -8.0, 6.0));
	var[13][0] = (vec4(-7.0, 0.0, 5.0, 8.0));
	var[13][1] = (vec4(9.0, 8.0, -6.0, -2.0));
	var[13][2] = (vec4(9.0, -5.0, 4.0, -4.0));
	var[14][0] = (vec4(-5.0, -1.0, -2.0, -8.0));
	var[14][1] = (vec4(-2.0, 5.0, -5.0, 9.0));
	var[14][2] = (vec4(7.0, -5.0, -3.0, 0.0));
	var[15][0] = (vec4(-5.0, -6.0, 7.0, 0.0));
	var[15][1] = (vec4(7.0, -8.0, -6.0, 0.0));
	var[15][2] = (vec4(7.0, -9.0, 2.0, 3.0));
	var[16][0] = (vec4(6.0, -9.0, -7.0, 6.0));
	var[16][1] = (vec4(0.0, 2.0, 9.0, -1.0));
	var[16][2] = (vec4(3.0, -4.0, 9.0, -2.0));
	var[17][0] = (vec4(-4.0, 6.0, 1.0, -2.0));
	var[17][1] = (vec4(-4.0, 3.0, 1.0, -1.0));
	var[17][2] = (vec4(9.0, -4.0, -1.0, 3.0));
	var[18][0] = (vec4(-1.0, -1.0, -9.0, -5.0));
	var[18][1] = (vec4(6.0, 2.0, -2.0, 8.0));
	var[18][2] = (vec4(9.0, 2.0, -4.0, 7.0));
}
#version 450
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
	bvec4 var[4][3];
};

bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((var[0][0]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((var[0][1]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((var[0][2]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((var[1][0]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((var[1][1]), bvec4(false, false, true, true)) && allOk;
	allOk = compare_bvec4((var[1][2]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec4((var[2][0]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((var[2][1]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((var[2][2]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((var[3][0]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((var[3][1]), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec4((var[3][2]), bvec4(false, true, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (bvec4(true, true, true, false));
	var[0][1] = (bvec4(true, false, false, false));
	var[0][2] = (bvec4(false, true, true, true));
	var[1][0] = (bvec4(true, true, true, false));
	var[1][1] = (bvec4(true, false, true, false));
	var[1][2] = (bvec4(true, false, false, true));
	var[2][0] = (bvec4(false, true, true, false));
	var[2][1] = (bvec4(true, true, true, false));
	var[2][2] = (bvec4(false, false, true, true));
	var[3][0] = (bvec4(true, false, true, false));
	var[3][1] = (bvec4(true, true, true, true));
	var[3][2] = (bvec4(false, true, false, true));
}
#version 450
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

layout(scalar, column_major, binding = 1) buffer Block
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
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat2x4(var[0][0], mat2x4(-4.0, 9.0, -7.0, -8.0, 2.0, 5.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[0][1], mat2x4(8.0, -9.0, 4.0, 4.0, -9.0, -1.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[0][2], mat2x4(-5.0, -4.0, -8.0, -6.0, -2.0, 3.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[1][0], mat2x4(-8.0, -7.0, 8.0, 5.0, 9.0, -9.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[1][1], mat2x4(4.0, -4.0, -1.0, 0.0, 1.0, -3.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[1][2], mat2x4(4.0, -2.0, 5.0, 0.0, -2.0, 1.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[2][0], mat2x4(5.0, -7.0, -1.0, 7.0, 6.0, 9.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[2][1], mat2x4(-7.0, 2.0, 8.0, -5.0, -1.0, -4.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[2][2], mat2x4(-4.0, -4.0, 5.0, -5.0, 5.0, -2.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[3][0], mat2x4(2.0, 9.0, -6.0, -9.0, -5.0, -8.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[3][1], mat2x4(2.0, -4.0, 4.0, 3.0, -4.0, -6.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[3][2], mat2x4(1.0, 5.0, -1.0, -5.0, 0.0, 2.0, -9.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (5.0);
	var[0][0] = (mat2x4(-1.0, 5.0, 1.0, 1.0, -4.0, 0.0, -8.0, -3.0));
	var[0][1] = (mat2x4(9.0, -8.0, -9.0, 1.0, 9.0, 1.0, -2.0, -6.0));
	var[0][2] = (mat2x4(3.0, -3.0, -7.0, -6.0, 0.0, 9.0, -7.0, -3.0));
	var[1][0] = (mat2x4(-9.0, -8.0, 2.0, 1.0, -9.0, 2.0, -1.0, -3.0));
	var[1][1] = (mat2x4(-3.0, -6.0, -9.0, 2.0, -8.0, -1.0, 3.0, 4.0));
	var[1][2] = (mat2x4(9.0, -6.0, -4.0, 7.0, 7.0, -4.0, -4.0, -6.0));
	var[2][0] = (mat2x4(9.0, -3.0, 5.0, -4.0, 8.0, 0.0, 1.0, 8.0));
	var[2][1] = (mat2x4(-6.0, 9.0, 7.0, -4.0, -8.0, 6.0, 2.0, -1.0));
	var[2][2] = (mat2x4(2.0, 9.0, -2.0, 4.0, -9.0, -7.0, 4.0, 2.0));
	var[3][0] = (mat2x4(0.0, -8.0, -1.0, -5.0, 5.0, 6.0, 0.0, 5.0));
	var[3][1] = (mat2x4(-8.0, 8.0, 1.0, -4.0, -3.0, 5.0, 6.0, 4.0));
	var[3][2] = (mat2x4(9.0, -7.0, -4.0, -4.0, -7.0, 9.0, 4.0, 4.0));
}
#version 450
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
	f16vec2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(padding), -6.0) && allOk;
	allOk = compare_f16vec2(vec2(var[0][0]), vec2(-3.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[0][1]), vec2(-5.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[0][2]), vec2(3.0, 2.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1][0]), vec2(-1.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1][1]), vec2(-5.0, -7.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1][2]), vec2(-2.0, 4.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2][0]), vec2(6.0, 3.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2][1]), vec2(-3.0, 0.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2][2]), vec2(-8.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[3][0]), vec2(8.0, 7.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[3][1]), vec2(1.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[3][2]), vec2(-3.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = float16_t(-2.0);
	var[0][0] = f16vec2(vec2(4.0, -2.0));
	var[0][1] = f16vec2(vec2(4.0, -1.0));
	var[0][2] = f16vec2(vec2(1.0, 9.0));
	var[1][0] = f16vec2(vec2(4.0, 8.0));
	var[1][1] = f16vec2(vec2(-8.0, 1.0));
	var[1][2] = f16vec2(vec2(-3.0, 2.0));
	var[2][0] = f16vec2(vec2(2.0, -6.0));
	var[2][1] = f16vec2(vec2(5.0, 5.0));
	var[2][2] = f16vec2(vec2(-7.0, 3.0));
	var[3][0] = f16vec2(vec2(0.0, -2.0));
	var[3][1] = f16vec2(vec2(3.0, -6.0));
	var[3][2] = f16vec2(vec2(5.0, 6.0));
}
#version 450
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
	highp mat3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0][0][0], mat3(-8.0, -9.0, -7.0, -7.0, 8.0, 7.0, 4.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(5.0, -4.0, 7.0, -4.0, -3.0, 8.0, 7.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3(var[0][0][2], mat3(1.0, 6.0, 8.0, -9.0, -1.0, 8.0, 8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(-7.0, 8.0, -6.0, -9.0, -8.0, 8.0, 0.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(-6.0, 0.0, -3.0, 9.0, 7.0, -8.0, -9.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3(var[0][1][2], mat3(-8.0, 9.0, 0.0, -7.0, 1.0, -2.0, 3.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(-6.0, 4.0, -3.0, -2.0, 3.0, 7.0, 0.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(-1.0, 1.0, -9.0, 4.0, 6.0, 8.0, 8.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat3(var[1][0][2], mat3(3.0, 0.0, -4.0, 8.0, 3.0, 9.0, 3.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(6.0, 6.0, -4.0, 4.0, -2.0, 6.0, 2.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(2.0, 9.0, 6.0, -8.0, -6.0, -3.0, -4.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3(var[1][1][2], mat3(-5.0, -8.0, 6.0, 2.0, 5.0, -6.0, 7.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(-8.0, 7.0, 2.0, -7.0, 4.0, -2.0, -5.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(-1.0, 2.0, 0.0, -9.0, -9.0, 6.0, -6.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(var[2][0][2], mat3(-4.0, -3.0, -3.0, 4.0, -6.0, -6.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(3.0, 4.0, -4.0, -1.0, -7.0, -1.0, 4.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(1.0, 1.0, 3.0, -6.0, -4.0, -2.0, -6.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3(var[2][1][2], mat3(2.0, 3.0, 1.0, 8.0, 9.0, -4.0, -2.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3(var[3][0][0], mat3(4.0, 6.0, -3.0, 5.0, -4.0, -6.0, -5.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3(var[3][0][1], mat3(8.0, -1.0, -4.0, -2.0, 4.0, -8.0, 0.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3(var[3][0][2], mat3(9.0, 6.0, 8.0, -7.0, 4.0, -8.0, 4.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat3(var[3][1][0], mat3(4.0, -9.0, 6.0, -1.0, 0.0, -2.0, 4.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3(var[3][1][1], mat3(-8.0, 3.0, -2.0, 1.0, 3.0, -1.0, -8.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3(var[3][1][2], mat3(-2.0, -4.0, -1.0, 1.0, -1.0, -8.0, -9.0, -9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3(5.0, 2.0, 8.0, 8.0, 3.0, -2.0, 2.0, -8.0, -5.0));
	var[0][0][1] = (mat3(-6.0, -1.0, 7.0, -5.0, -5.0, 8.0, -2.0, -5.0, 5.0));
	var[0][0][2] = (mat3(3.0, 9.0, -7.0, -2.0, 3.0, 5.0, 5.0, 1.0, -6.0));
	var[0][1][0] = (mat3(-9.0, 2.0, -8.0, 1.0, -5.0, 5.0, 8.0, -6.0, 7.0));
	var[0][1][1] = (mat3(-1.0, 7.0, -7.0, 7.0, 5.0, -9.0, 5.0, 3.0, -1.0));
	var[0][1][2] = (mat3(6.0, -3.0, 9.0, 7.0, 0.0, 2.0, 8.0, -5.0, -9.0));
	var[1][0][0] = (mat3(-5.0, 4.0, 9.0, -2.0, -6.0, 2.0, -1.0, 0.0, 2.0));
	var[1][0][1] = (mat3(9.0, -5.0, 7.0, 6.0, 8.0, 4.0, 5.0, -2.0, -5.0));
	var[1][0][2] = (mat3(7.0, -1.0, 1.0, -3.0, -8.0, 1.0, -4.0, 7.0, 1.0));
	var[1][1][0] = (mat3(-3.0, 0.0, 7.0, -7.0, 1.0, -6.0, -4.0, 1.0, -9.0));
	var[1][1][1] = (mat3(6.0, 9.0, 8.0, 5.0, 8.0, 1.0, 6.0, 4.0, -4.0));
	var[1][1][2] = (mat3(9.0, -4.0, 1.0, -5.0, 8.0, -3.0, 4.0, -9.0, -8.0));
	var[2][0][0] = (mat3(5.0, 8.0, -1.0, 8.0, 9.0, 6.0, -1.0, 5.0, -2.0));
	var[2][0][1] = (mat3(1.0, 4.0, -8.0, 8.0, 1.0, 2.0, 4.0, -7.0, 3.0));
	var[2][0][2] = (mat3(-1.0, -5.0, 2.0, 2.0, -1.0, -7.0, 7.0, -8.0, -6.0));
	var[2][1][0] = (mat3(-7.0, 7.0, -5.0, 5.0, 0.0, 7.0, -8.0, -5.0, 8.0));
	var[2][1][1] = (mat3(4.0, -8.0, -8.0, 3.0, -2.0, 4.0, 8.0, -1.0, -5.0));
	var[2][1][2] = (mat3(-5.0, -1.0, -1.0, 4.0, 9.0, 2.0, -2.0, -7.0, 2.0));
	var[3][0][0] = (mat3(5.0, -9.0, 2.0, 2.0, -9.0, -9.0, -2.0, 1.0, 8.0));
	var[3][0][1] = (mat3(-4.0, 8.0, -5.0, 5.0, -2.0, 2.0, 3.0, 3.0, -8.0));
	var[3][0][2] = (mat3(0.0, 2.0, 6.0, 2.0, -5.0, -9.0, 4.0, 6.0, -3.0));
	var[3][1][0] = (mat3(-5.0, -3.0, -3.0, 1.0, -3.0, -9.0, 5.0, 7.0, 7.0));
	var[3][1][1] = (mat3(6.0, 3.0, -3.0, 2.0, 0.0, 2.0, -1.0, 4.0, 2.0));
	var[3][1][2] = (mat3(2.0, 3.0, 2.0, -9.0, 3.0, 4.0, -6.0, -3.0, -9.0));
}
#version 450
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
	u8vec4 var[4][2][3];
};

bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(var[0][0][0]), uvec4(3u, 4u, 6u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[0][0][1]), uvec4(1u, 5u, 7u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[0][0][2]), uvec4(1u, 4u, 6u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[0][1][0]), uvec4(6u, 5u, 4u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[0][1][1]), uvec4(8u, 7u, 8u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[0][1][2]), uvec4(9u, 5u, 6u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[1][0][0]), uvec4(7u, 7u, 6u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[1][0][1]), uvec4(3u, 3u, 3u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[1][0][2]), uvec4(7u, 2u, 2u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[1][1][0]), uvec4(7u, 5u, 4u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[1][1][1]), uvec4(1u, 0u, 6u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[1][1][2]), uvec4(1u, 3u, 8u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[2][0][0]), uvec4(6u, 9u, 5u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[2][0][1]), uvec4(5u, 2u, 0u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[2][0][2]), uvec4(8u, 3u, 7u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[2][1][0]), uvec4(1u, 4u, 1u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[2][1][1]), uvec4(5u, 8u, 2u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[2][1][2]), uvec4(0u, 3u, 4u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[3][0][0]), uvec4(5u, 7u, 4u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[3][0][1]), uvec4(5u, 8u, 5u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[3][0][2]), uvec4(8u, 6u, 3u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[3][1][0]), uvec4(1u, 9u, 9u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[3][1][1]), uvec4(4u, 8u, 0u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[3][1][2]), uvec4(6u, 3u, 9u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = u8vec4(uvec4(9u, 5u, 9u, 4u));
	var[0][0][1] = u8vec4(uvec4(6u, 8u, 7u, 3u));
	var[0][0][2] = u8vec4(uvec4(6u, 7u, 1u, 9u));
	var[0][1][0] = u8vec4(uvec4(5u, 2u, 7u, 4u));
	var[0][1][1] = u8vec4(uvec4(8u, 9u, 1u, 4u));
	var[0][1][2] = u8vec4(uvec4(7u, 0u, 8u, 1u));
	var[1][0][0] = u8vec4(uvec4(8u, 9u, 3u, 3u));
	var[1][0][1] = u8vec4(uvec4(3u, 9u, 0u, 6u));
	var[1][0][2] = u8vec4(uvec4(8u, 7u, 6u, 7u));
	var[1][1][0] = u8vec4(uvec4(0u, 4u, 9u, 9u));
	var[1][1][1] = u8vec4(uvec4(9u, 3u, 5u, 3u));
	var[1][1][2] = u8vec4(uvec4(1u, 4u, 3u, 3u));
	var[2][0][0] = u8vec4(uvec4(7u, 7u, 4u, 8u));
	var[2][0][1] = u8vec4(uvec4(8u, 5u, 3u, 1u));
	var[2][0][2] = u8vec4(uvec4(1u, 4u, 7u, 1u));
	var[2][1][0] = u8vec4(uvec4(8u, 9u, 4u, 7u));
	var[2][1][1] = u8vec4(uvec4(0u, 4u, 6u, 7u));
	var[2][1][2] = u8vec4(uvec4(4u, 2u, 8u, 9u));
	var[3][0][0] = u8vec4(uvec4(3u, 6u, 3u, 3u));
	var[3][0][1] = u8vec4(uvec4(4u, 7u, 8u, 8u));
	var[3][0][2] = u8vec4(uvec4(1u, 7u, 7u, 2u));
	var[3][1][0] = u8vec4(uvec4(9u, 8u, 8u, 1u));
	var[3][1][1] = u8vec4(uvec4(2u, 6u, 8u, 6u));
	var[3][1][2] = u8vec4(uvec4(9u, 6u, 5u, 0u));
}
#version 450
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
	u16vec2 var[4][2][3];
};

bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(var[0][0][0]), uvec2(8u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[0][0][1]), uvec2(2u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[0][0][2]), uvec2(6u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[0][1][0]), uvec2(7u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[0][1][1]), uvec2(7u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[0][1][2]), uvec2(3u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][0][0]), uvec2(7u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][0][1]), uvec2(0u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][0][2]), uvec2(1u, 3u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][1][0]), uvec2(4u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][1][1]), uvec2(3u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][1][2]), uvec2(1u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][0][0]), uvec2(8u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][0][1]), uvec2(7u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][0][2]), uvec2(2u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][1][0]), uvec2(1u, 0u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][1][1]), uvec2(0u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][1][2]), uvec2(9u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[3][0][0]), uvec2(5u, 5u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[3][0][1]), uvec2(4u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[3][0][2]), uvec2(6u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[3][1][0]), uvec2(7u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[3][1][1]), uvec2(3u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[3][1][2]), uvec2(2u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = u16vec2(uvec2(8u, 0u));
	var[0][0][1] = u16vec2(uvec2(6u, 0u));
	var[0][0][2] = u16vec2(uvec2(6u, 9u));
	var[0][1][0] = u16vec2(uvec2(7u, 0u));
	var[0][1][1] = u16vec2(uvec2(3u, 9u));
	var[0][1][2] = u16vec2(uvec2(8u, 9u));
	var[1][0][0] = u16vec2(uvec2(3u, 2u));
	var[1][0][1] = u16vec2(uvec2(9u, 2u));
	var[1][0][2] = u16vec2(uvec2(4u, 5u));
	var[1][1][0] = u16vec2(uvec2(1u, 2u));
	var[1][1][1] = u16vec2(uvec2(5u, 7u));
	var[1][1][2] = u16vec2(uvec2(9u, 9u));
	var[2][0][0] = u16vec2(uvec2(1u, 1u));
	var[2][0][1] = u16vec2(uvec2(2u, 8u));
	var[2][0][2] = u16vec2(uvec2(1u, 5u));
	var[2][1][0] = u16vec2(uvec2(7u, 6u));
	var[2][1][1] = u16vec2(uvec2(4u, 4u));
	var[2][1][2] = u16vec2(uvec2(6u, 4u));
	var[3][0][0] = u16vec2(uvec2(0u, 2u));
	var[3][0][1] = u16vec2(uvec2(3u, 8u));
	var[3][0][2] = u16vec2(uvec2(1u, 8u));
	var[3][1][0] = u16vec2(uvec2(5u, 7u));
	var[3][1][1] = u16vec2(uvec2(9u, 3u));
	var[3][1][2] = u16vec2(uvec2(3u, 2u));
}
#version 450
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
	bool var[4][2][3];
};

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((var[0][0][0]), false) && allOk;
	allOk = compare_bool((var[0][0][1]), true) && allOk;
	allOk = compare_bool((var[0][0][2]), true) && allOk;
	allOk = compare_bool((var[0][1][0]), true) && allOk;
	allOk = compare_bool((var[0][1][1]), false) && allOk;
	allOk = compare_bool((var[0][1][2]), true) && allOk;
	allOk = compare_bool((var[1][0][0]), false) && allOk;
	allOk = compare_bool((var[1][0][1]), false) && allOk;
	allOk = compare_bool((var[1][0][2]), true) && allOk;
	allOk = compare_bool((var[1][1][0]), true) && allOk;
	allOk = compare_bool((var[1][1][1]), false) && allOk;
	allOk = compare_bool((var[1][1][2]), true) && allOk;
	allOk = compare_bool((var[2][0][0]), true) && allOk;
	allOk = compare_bool((var[2][0][1]), false) && allOk;
	allOk = compare_bool((var[2][0][2]), false) && allOk;
	allOk = compare_bool((var[2][1][0]), false) && allOk;
	allOk = compare_bool((var[2][1][1]), false) && allOk;
	allOk = compare_bool((var[2][1][2]), false) && allOk;
	allOk = compare_bool((var[3][0][0]), false) && allOk;
	allOk = compare_bool((var[3][0][1]), false) && allOk;
	allOk = compare_bool((var[3][0][2]), true) && allOk;
	allOk = compare_bool((var[3][1][0]), true) && allOk;
	allOk = compare_bool((var[3][1][1]), false) && allOk;
	allOk = compare_bool((var[3][1][2]), false) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (false);
	var[0][0][1] = (false);
	var[0][0][2] = (true);
	var[0][1][0] = (false);
	var[0][1][1] = (false);
	var[0][1][2] = (true);
	var[1][0][0] = (true);
	var[1][0][1] = (false);
	var[1][0][2] = (false);
	var[1][1][0] = (false);
	var[1][1][1] = (true);
	var[1][1][2] = (false);
	var[2][0][0] = (true);
	var[2][0][1] = (true);
	var[2][0][2] = (true);
	var[2][1][0] = (true);
	var[2][1][1] = (true);
	var[2][1][2] = (true);
	var[3][0][0] = (true);
	var[3][0][1] = (false);
	var[3][0][2] = (false);
	var[3][1][0] = (true);
	var[3][1][1] = (true);
	var[3][1][2] = (false);
}
#version 450
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
	allOk = compare_mat4x2(var[0][0][0], mat4x2(0.0, 6.0, -3.0, 7.0, 1.0, -8.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][1], mat4x2(2.0, -3.0, -5.0, 5.0, 5.0, 1.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][2], mat4x2(1.0, 1.0, -2.0, -3.0, -9.0, 3.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][0], mat4x2(-2.0, -6.0, 4.0, 4.0, 5.0, -9.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][1], mat4x2(-3.0, 4.0, 3.0, -2.0, -5.0, 0.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][2], mat4x2(-3.0, 4.0, -5.0, -8.0, 5.0, -3.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][0], mat4x2(6.0, -2.0, -9.0, 5.0, -5.0, -6.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][1], mat4x2(5.0, -3.0, 5.0, 6.0, -4.0, -8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][2], mat4x2(-5.0, 4.0, -9.0, 6.0, 8.0, -3.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][0], mat4x2(3.0, 4.0, -7.0, 4.0, -9.0, 4.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][1], mat4x2(-7.0, 4.0, -9.0, -9.0, -6.0, 2.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][2], mat4x2(-6.0, 6.0, -7.0, -6.0, -7.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][0], mat4x2(9.0, 5.0, 0.0, -5.0, 6.0, -8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][1], mat4x2(2.0, 6.0, -5.0, 2.0, -8.0, -2.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][2], mat4x2(6.0, -1.0, 6.0, -3.0, 4.0, 0.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][0], mat4x2(1.0, -7.0, -5.0, 9.0, -9.0, -1.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][1], mat4x2(-7.0, 7.0, 2.0, 7.0, -3.0, -8.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][2], mat4x2(-4.0, -2.0, 8.0, 3.0, -2.0, 8.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][0], mat4x2(-5.0, 8.0, 8.0, -7.0, 4.0, 6.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][1], mat4x2(-9.0, -8.0, 9.0, -2.0, -7.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][2], mat4x2(-5.0, 0.0, 3.0, 9.0, -8.0, -1.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][0], mat4x2(1.0, -7.0, -1.0, 4.0, 4.0, -5.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][1], mat4x2(-2.0, 0.0, -5.0, -8.0, -4.0, -9.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][2], mat4x2(1.0, 9.0, -1.0, 7.0, -9.0, -1.0, -4.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4x2(8.0, -5.0, 3.0, 0.0, -9.0, 4.0, -5.0, 3.0));
	var[0][0][1] = (mat4x2(6.0, 3.0, 6.0, -6.0, 0.0, -3.0, -2.0, -4.0));
	var[0][0][2] = (mat4x2(5.0, 4.0, 1.0, 0.0, 7.0, -9.0, -4.0, 5.0));
	var[0][1][0] = (mat4x2(4.0, 9.0, -8.0, 5.0, 3.0, 3.0, -4.0, 8.0));
	var[0][1][1] = (mat4x2(-7.0, 2.0, 2.0, -4.0, 6.0, -1.0, 1.0, 1.0));
	var[0][1][2] = (mat4x2(-9.0, 7.0, 9.0, -1.0, 3.0, -9.0, 2.0, -2.0));
	var[1][0][0] = (mat4x2(6.0, 1.0, 0.0, 3.0, 2.0, -5.0, -4.0, 5.0));
	var[1][0][1] = (mat4x2(5.0, -4.0, -7.0, -8.0, 9.0, -4.0, 5.0, 5.0));
	var[1][0][2] = (mat4x2(-1.0, 6.0, -6.0, 5.0, 4.0, -3.0, 1.0, -4.0));
	var[1][1][0] = (mat4x2(4.0, 1.0, 2.0, 3.0, 5.0, -3.0, -8.0, -1.0));
	var[1][1][1] = (mat4x2(2.0, 6.0, -3.0, 8.0, 3.0, -4.0, 8.0, 5.0));
	var[1][1][2] = (mat4x2(-4.0, 6.0, 7.0, -3.0, 1.0, 9.0, 7.0, 4.0));
	var[2][0][0] = (mat4x2(1.0, -6.0, 2.0, 4.0, 7.0, 1.0, 9.0, 5.0));
	var[2][0][1] = (mat4x2(8.0, -7.0, 6.0, -7.0, -4.0, 5.0, 3.0, -2.0));
	var[2][0][2] = (mat4x2(-2.0, -5.0, -1.0, 1.0, -8.0, 4.0, 9.0, 2.0));
	var[2][1][0] = (mat4x2(8.0, -7.0, 4.0, 5.0, -8.0, -6.0, -7.0, 1.0));
	var[2][1][1] = (mat4x2(1.0, 6.0, -8.0, -5.0, -6.0, 2.0, -9.0, 0.0));
	var[2][1][2] = (mat4x2(-6.0, 4.0, 2.0, 8.0, 2.0, 4.0, -9.0, 9.0));
	var[3][0][0] = (mat4x2(-5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 1.0, 1.0));
	var[3][0][1] = (mat4x2(1.0, -9.0, -1.0, 6.0, -9.0, -7.0, -8.0, 8.0));
	var[3][0][2] = (mat4x2(-2.0, 7.0, 8.0, -9.0, 4.0, -3.0, 0.0, -7.0));
	var[3][1][0] = (mat4x2(5.0, -4.0, 5.0, 4.0, -8.0, -6.0, 4.0, 0.0));
	var[3][1][1] = (mat4x2(7.0, -2.0, 3.0, -5.0, -4.0, 1.0, -3.0, 6.0));
	var[3][1][2] = (mat4x2(-3.0, -1.0, 4.0, -1.0, -1.0, -7.0, -7.0, 6.0));
}
#version 450
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
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat4x3(var[0][0][0], mat4x3(9.0, -7.0, -7.0, 8.0, 2.0, 7.0, 3.0, -1.0, -1.0, 8.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(-8.0, -6.0, 3.0, -8.0, -8.0, -4.0, 5.0, -9.0, 2.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][2], mat4x3(4.0, -4.0, -7.0, 9.0, -3.0, -7.0, 9.0, 2.0, 9.0, 1.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(-1.0, -1.0, 6.0, 4.0, -5.0, 5.0, 4.0, 2.0, -9.0, 3.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(-7.0, -5.0, 7.0, 0.0, 0.0, -1.0, -5.0, -7.0, -7.0, -4.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][2], mat4x3(2.0, 6.0, 1.0, -3.0, 0.0, 1.0, -6.0, -3.0, 5.0, 9.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(6.0, 0.0, 2.0, 2.0, 3.0, -9.0, 4.0, 5.0, -5.0, 7.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(-8.0, 0.0, 5.0, -5.0, 7.0, 9.0, -8.0, 3.0, -6.0, 4.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][2], mat4x3(-3.0, 0.0, -2.0, 5.0, 1.0, 1.0, 6.0, 5.0, -4.0, 3.0, 0.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(-6.0, 8.0, 9.0, 3.0, -5.0, -8.0, 4.0, 9.0, -8.0, 9.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(-2.0, 6.0, 7.0, 5.0, -4.0, 3.0, 1.0, 5.0, -7.0, -4.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][2], mat4x3(5.0, 6.0, 2.0, 5.0, 5.0, 4.0, 6.0, -4.0, -2.0, -5.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(-6.0, -9.0, 6.0, 7.0, -3.0, -3.0, 9.0, 4.0, -8.0, -7.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(0.0, 9.0, -8.0, -2.0, -2.0, -1.0, -2.0, -1.0, 2.0, 5.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][2], mat4x3(-2.0, 8.0, -3.0, -7.0, 1.0, -6.0, 8.0, 4.0, -6.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(-6.0, -1.0, -4.0, 1.0, 5.0, -2.0, 2.0, -5.0, 0.0, -2.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(9.0, -7.0, -9.0, -7.0, -1.0, 9.0, -4.0, 0.0, 4.0, 4.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][2], mat4x3(1.0, -6.0, 3.0, 7.0, -1.0, 0.0, 8.0, 9.0, 7.0, -3.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][0], mat4x3(3.0, 7.0, 9.0, 7.0, 9.0, -2.0, -4.0, -9.0, 4.0, -8.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][1], mat4x3(6.0, -5.0, -7.0, 3.0, -9.0, -5.0, -8.0, 8.0, -2.0, 2.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][2], mat4x3(2.0, 8.0, -1.0, 5.0, 2.0, 7.0, 1.0, 4.0, -8.0, 4.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][0], mat4x3(3.0, 7.0, 2.0, 9.0, 2.0, 9.0, 2.0, 9.0, 4.0, -9.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][1], mat4x3(4.0, 1.0, 2.0, 5.0, -9.0, -7.0, 3.0, -2.0, 3.0, 3.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][2], mat4x3(2.0, -4.0, 4.0, -8.0, -3.0, 4.0, 4.0, 0.0, -8.0, 3.0, 3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (1.0);
	var[0][0][0][0] = (vec3(-7.0, 2.0, 3.0));
	var[0][0][0][1] = (vec3(1.0, -2.0, -1.0));
	var[0][0][0][2] = (vec3(-5.0, -1.0, 9.0));
	var[0][0][0][3] = (vec3(3.0, -7.0, 8.0));
	var[0][0][1][0] = (vec3(4.0, 9.0, -6.0));
	var[0][0][1][1] = (vec3(7.0, 6.0, -5.0));
	var[0][0][1][2] = (vec3(2.0, 6.0, 3.0));
	var[0][0][1][3] = (vec3(-4.0, 3.0, 2.0));
	var[0][0][2][0] = (vec3(-3.0, -3.0, -7.0));
	var[0][0][2][1] = (vec3(-5.0, 3.0, 4.0));
	var[0][0][2][2] = (vec3(-4.0, -2.0, 8.0));
	var[0][0][2][3] = (vec3(7.0, -1.0, -1.0));
	var[0][1][0][0] = (vec3(1.0, -7.0, -9.0));
	var[0][1][0][1] = (vec3(4.0, -9.0, 8.0));
	var[0][1][0][2] = (vec3(2.0, 5.0, -4.0));
	var[0][1][0][3] = (vec3(5.0, -2.0, -9.0));
	var[0][1][1][0] = (vec3(-3.0, 6.0, -3.0));
	var[0][1][1][1] = (vec3(7.0, -9.0, -4.0));
	var[0][1][1][2] = (vec3(9.0, 6.0, 2.0));
	var[0][1][1][3] = (vec3(-9.0, 5.0, -3.0));
	var[0][1][2][0] = (vec3(-9.0, 5.0, -6.0));
	var[0][1][2][1] = (vec3(5.0, -7.0, -9.0));
	var[0][1][2][2] = (vec3(0.0, 9.0, 9.0));
	var[0][1][2][3] = (vec3(-5.0, 2.0, -9.0));
	var[1][0][0][0] = (vec3(-4.0, -7.0, -7.0));
	var[1][0][0][1] = (vec3(8.0, 4.0, -6.0));
	var[1][0][0][2] = (vec3(6.0, 0.0, 1.0));
	var[1][0][0][3] = (vec3(-8.0, 8.0, 7.0));
	var[1][0][1][0] = (vec3(9.0, 9.0, -6.0));
	var[1][0][1][1] = (vec3(0.0, 1.0, 1.0));
	var[1][0][1][2] = (vec3(2.0, 7.0, 2.0));
	var[1][0][1][3] = (vec3(-1.0, -8.0, -3.0));
	var[1][0][2][0] = (vec3(3.0, -1.0, -1.0));
	var[1][0][2][1] = (vec3(-2.0, 9.0, -5.0));
	var[1][0][2][2] = (vec3(8.0, -6.0, -5.0));
	var[1][0][2][3] = (vec3(-6.0, 5.0, -9.0));
	var[1][1][0][0] = (vec3(-2.0, 7.0, 7.0));
	var[1][1][0][1] = (vec3(-2.0, 7.0, -9.0));
	var[1][1][0][2] = (vec3(5.0, 5.0, -4.0));
	var[1][1][0][3] = (vec3(5.0, 5.0, 6.0));
	var[1][1][1][0] = (vec3(-3.0, 1.0, -7.0));
	var[1][1][1][1] = (vec3(-1.0, 0.0, -9.0));
	var[1][1][1][2] = (vec3(0.0, -4.0, 9.0));
	var[1][1][1][3] = (vec3(-3.0, 7.0, -6.0));
	var[1][1][2][0] = (vec3(6.0, 1.0, -2.0));
	var[1][1][2][1] = (vec3(2.0, 8.0, 9.0));
	var[1][1][2][2] = (vec3(2.0, -8.0, -9.0));
	var[1][1][2][3] = (vec3(-5.0, 7.0, -1.0));
	var[2][0][0][0] = (vec3(5.0, 6.0, -7.0));
	var[2][0][0][1] = (vec3(-8.0, 1.0, 8.0));
	var[2][0][0][2] = (vec3(1.0, 6.0, -1.0));
	var[2][0][0][3] = (vec3(3.0, -2.0, -5.0));
	var[2][0][1][0] = (vec3(5.0, -3.0, 2.0));
	var[2][0][1][1] = (vec3(-5.0, 2.0, -2.0));
	var[2][0][1][2] = (vec3(-7.0, -9.0, -1.0));
	var[2][0][1][3] = (vec3(0.0, -6.0, -2.0));
	var[2][0][2][0] = (vec3(-9.0, -4.0, 9.0));
	var[2][0][2][1] = (vec3(4.0, -4.0, 5.0));
	var[2][0][2][2] = (vec3(7.0, 1.0, 7.0));
	var[2][0][2][3] = (vec3(-3.0, -7.0, -9.0));
	var[2][1][0][0] = (vec3(4.0, 7.0, -4.0));
	var[2][1][0][1] = (vec3(6.0, 2.0, -4.0));
	var[2][1][0][2] = (vec3(8.0, -8.0, -1.0));
	var[2][1][0][3] = (vec3(-5.0, 2.0, -8.0));
	var[2][1][1][0] = (vec3(-8.0, -2.0, -1.0));
	var[2][1][1][1] = (vec3(-4.0, 5.0, 4.0));
	var[2][1][1][2] = (vec3(-6.0, -1.0, 7.0));
	var[2][1][1][3] = (vec3(-9.0, 2.0, 1.0));
	var[2][1][2][0] = (vec3(-9.0, 4.0, 7.0));
	var[2][1][2][1] = (vec3(-5.0, -9.0, 1.0));
	var[2][1][2][2] = (vec3(-1.0, 2.0, -5.0));
	var[2][1][2][3] = (vec3(-1.0, 9.0, 3.0));
	var[3][0][0][0] = (vec3(4.0, 0.0, 0.0));
	var[3][0][0][1] = (vec3(0.0, -3.0, 3.0));
	var[3][0][0][2] = (vec3(1.0, 8.0, 0.0));
	var[3][0][0][3] = (vec3(5.0, 4.0, -2.0));
	var[3][0][1][0] = (vec3(-8.0, 7.0, -9.0));
	var[3][0][1][1] = (vec3(3.0, -2.0, -3.0));
	var[3][0][1][2] = (vec3(-5.0, 1.0, -4.0));
	var[3][0][1][3] = (vec3(9.0, -8.0, 5.0));
	var[3][0][2][0] = (vec3(3.0, 7.0, -3.0));
	var[3][0][2][1] = (vec3(-2.0, 2.0, -9.0));
	var[3][0][2][2] = (vec3(0.0, 9.0, 5.0));
	var[3][0][2][3] = (vec3(5.0, 8.0, -5.0));
	var[3][1][0][0] = (vec3(4.0, -5.0, 8.0));
	var[3][1][0][1] = (vec3(4.0, 6.0, 1.0));
	var[3][1][0][2] = (vec3(-4.0, 5.0, -7.0));
	var[3][1][0][3] = (vec3(6.0, 7.0, -2.0));
	var[3][1][1][0] = (vec3(5.0, -8.0, -5.0));
	var[3][1][1][1] = (vec3(-7.0, -4.0, -3.0));
	var[3][1][1][2] = (vec3(-1.0, 8.0, -8.0));
	var[3][1][1][3] = (vec3(-3.0, -9.0, -2.0));
	var[3][1][2][0] = (vec3(-3.0, -2.0, -8.0));
	var[3][1][2][1] = (vec3(-3.0, -2.0, -2.0));
	var[3][1][2][2] = (vec3(-9.0, 4.0, 7.0));
	var[3][1][2][3] = (vec3(-6.0, 6.0, 6.0));
}
#version 450
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
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat4x3(var[0][0][0], mat4x3(1.0, 0.0, 0.0, -7.0, 2.0, 5.0, 0.0, 3.0, 2.0, 4.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(-5.0, 2.0, 0.0, -1.0, -5.0, 5.0, 5.0, 9.0, -7.0, 5.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][2], mat4x3(6.0, -7.0, 7.0, 8.0, 6.0, -7.0, -8.0, -5.0, -9.0, -4.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(-2.0, 5.0, 8.0, 5.0, -1.0, 2.0, -4.0, -9.0, -5.0, -7.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(7.0, -4.0, 9.0, 4.0, -1.0, -2.0, -8.0, 7.0, 9.0, 8.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][2], mat4x3(1.0, 9.0, 3.0, -6.0, -4.0, 9.0, 3.0, -7.0, -3.0, 3.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(-7.0, 7.0, 2.0, -5.0, 3.0, 2.0, 0.0, 8.0, -1.0, -5.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(6.0, 2.0, -5.0, -7.0, -7.0, -4.0, -9.0, 7.0, 3.0, 1.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][2], mat4x3(7.0, 6.0, 3.0, 4.0, 5.0, -2.0, 3.0, 8.0, -7.0, 1.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(-4.0, -5.0, 2.0, -6.0, -3.0, -7.0, 2.0, 6.0, 4.0, -4.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(2.0, -9.0, -6.0, -7.0, -2.0, -2.0, 6.0, -5.0, -9.0, -4.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][2], mat4x3(1.0, -3.0, -3.0, -1.0, -5.0, -5.0, 7.0, -9.0, 6.0, 4.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(7.0, 1.0, -2.0, 9.0, -5.0, -3.0, 1.0, -6.0, 6.0, -1.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(8.0, 5.0, 4.0, 7.0, -1.0, 6.0, -6.0, 2.0, 8.0, 7.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][2], mat4x3(6.0, -8.0, -4.0, -8.0, 8.0, -5.0, 7.0, 3.0, 9.0, -3.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(-3.0, 5.0, 4.0, -3.0, 7.0, -7.0, -8.0, -9.0, 2.0, 6.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(3.0, -1.0, -6.0, 2.0, 2.0, -2.0, -9.0, -7.0, -1.0, -3.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][2], mat4x3(-5.0, 6.0, -8.0, 6.0, 3.0, 6.0, -5.0, 9.0, -1.0, 5.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][0], mat4x3(-3.0, 0.0, -3.0, 2.0, -8.0, 6.0, 5.0, -2.0, 2.0, 7.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][1], mat4x3(4.0, 5.0, -8.0, -1.0, -2.0, -8.0, -4.0, 2.0, 8.0, 5.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][2], mat4x3(-1.0, 3.0, 3.0, -3.0, 4.0, -6.0, -5.0, 1.0, 4.0, -4.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][0], mat4x3(3.0, -8.0, -6.0, -6.0, 0.0, 4.0, -1.0, 4.0, -5.0, -9.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][1], mat4x3(9.0, -3.0, 5.0, 2.0, -6.0, -7.0, -3.0, -2.0, -8.0, 6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][2], mat4x3(7.0, 5.0, -4.0, 6.0, 1.0, -7.0, 9.0, 2.0, -1.0, -4.0, 8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (7.0);
	var[0][0][0] = (mat4x3(8.0, 8.0, -3.0, -9.0, 2.0, -6.0, 0.0, -4.0, -3.0, 4.0, -8.0, 4.0));
	var[0][0][1] = (mat4x3(-2.0, 2.0, 8.0, 4.0, -1.0, -8.0, -6.0, -4.0, 9.0, -2.0, 1.0, -7.0));
	var[0][0][2] = (mat4x3(-4.0, -4.0, -1.0, 7.0, -6.0, 4.0, 6.0, 7.0, -9.0, -8.0, 3.0, -6.0));
	var[0][1][0] = (mat4x3(3.0, 9.0, 9.0, -7.0, 4.0, 4.0, 8.0, 7.0, -7.0, 2.0, 2.0, -2.0));
	var[0][1][1] = (mat4x3(-1.0, -7.0, 6.0, 7.0, -7.0, 6.0, 0.0, 2.0, -3.0, -6.0, -4.0, 5.0));
	var[0][1][2] = (mat4x3(-5.0, 1.0, 9.0, 0.0, 3.0, 6.0, -8.0, 7.0, -6.0, 0.0, -2.0, 3.0));
	var[1][0][0] = (mat4x3(-5.0, 6.0, -2.0, -7.0, 5.0, 4.0, -6.0, -4.0, -7.0, 2.0, -7.0, -6.0));
	var[1][0][1] = (mat4x3(5.0, -6.0, 9.0, -8.0, -5.0, -2.0, -8.0, -9.0, -8.0, -1.0, 2.0, -7.0));
	var[1][0][2] = (mat4x3(-2.0, 1.0, 0.0, 8.0, -7.0, 0.0, 0.0, 7.0, 0.0, -4.0, -7.0, -9.0));
	var[1][1][0] = (mat4x3(0.0, 5.0, 8.0, 6.0, -4.0, 7.0, 1.0, 1.0, 5.0, -3.0, -3.0, 5.0));
	var[1][1][1] = (mat4x3(-3.0, -4.0, -9.0, 2.0, 9.0, -3.0, 1.0, -8.0, -8.0, 0.0, 9.0, -8.0));
	var[1][1][2] = (mat4x3(9.0, -9.0, 4.0, -4.0, 3.0, -4.0, -1.0, -6.0, -7.0, 7.0, 6.0, -6.0));
	var[2][0][0] = (mat4x3(-7.0, 2.0, 2.0, 6.0, 9.0, 9.0, 5.0, -3.0, -4.0, -1.0, -5.0, -8.0));
	var[2][0][1] = (mat4x3(-4.0, -2.0, 7.0, 3.0, -9.0, 8.0, 1.0, -1.0, -7.0, -6.0, 2.0, -3.0));
	var[2][0][2] = (mat4x3(-7.0, 7.0, -5.0, 5.0, -8.0, 4.0, 8.0, -9.0, 6.0, -3.0, 2.0, 3.0));
	var[2][1][0] = (mat4x3(5.0, 8.0, 3.0, -8.0, 8.0, -6.0, -2.0, 5.0, 6.0, 4.0, 8.0, -9.0));
	var[2][1][1] = (mat4x3(0.0, -2.0, -2.0, 9.0, 5.0, 0.0, -8.0, -1.0, 0.0, -6.0, 6.0, -4.0));
	var[2][1][2] = (mat4x3(1.0, -2.0, -8.0, -6.0, 8.0, 0.0, 0.0, -5.0, 8.0, -1.0, -7.0, -2.0));
	var[3][0][0] = (mat4x3(-8.0, 6.0, -2.0, 8.0, -2.0, -2.0, -5.0, -1.0, -7.0, -9.0, 3.0, -6.0));
	var[3][0][1] = (mat4x3(-9.0, -4.0, -6.0, -1.0, -8.0, 9.0, 6.0, -8.0, -6.0, -5.0, 1.0, -1.0));
	var[3][0][2] = (mat4x3(-9.0, 4.0, 0.0, 9.0, 3.0, 5.0, 7.0, -4.0, -7.0, 3.0, 9.0, -2.0));
	var[3][1][0] = (mat4x3(-2.0, 5.0, -5.0, -4.0, -9.0, -9.0, 1.0, -1.0, -8.0, 2.0, -9.0, -2.0));
	var[3][1][1] = (mat4x3(3.0, 5.0, -9.0, -2.0, -6.0, 8.0, 6.0, 6.0, -9.0, 2.0, 5.0, -7.0));
	var[3][1][2] = (mat4x3(-4.0, -5.0, -3.0, 0.0, 4.0, 0.0, -4.0, -9.0, -5.0, -6.0, -2.0, 7.0));
}
#version 450
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
	u8vec3 var[][4][2];
};

bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(var[0][0][0]), uvec3(4u, 3u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[0][0][1]), uvec3(1u, 4u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[0][1][0]), uvec3(3u, 8u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[0][1][1]), uvec3(6u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[0][2][0]), uvec3(8u, 6u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[0][2][1]), uvec3(6u, 7u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[0][3][0]), uvec3(5u, 0u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[0][3][1]), uvec3(1u, 1u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][0][0]), uvec3(8u, 6u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][0][1]), uvec3(6u, 4u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][1][0]), uvec3(4u, 0u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][1][1]), uvec3(9u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][2][0]), uvec3(3u, 9u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][2][1]), uvec3(1u, 1u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][3][0]), uvec3(7u, 6u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][3][1]), uvec3(4u, 9u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][0][0]), uvec3(5u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][0][1]), uvec3(1u, 4u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][1][0]), uvec3(0u, 2u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][1][1]), uvec3(9u, 0u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][2][0]), uvec3(1u, 9u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][2][1]), uvec3(9u, 3u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][3][0]), uvec3(3u, 8u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][3][1]), uvec3(7u, 5u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = u8vec3(uvec3(4u, 5u, 9u));
	var[0][0][1] = u8vec3(uvec3(6u, 9u, 4u));
	var[0][1][0] = u8vec3(uvec3(5u, 4u, 7u));
	var[0][1][1] = u8vec3(uvec3(0u, 0u, 5u));
	var[0][2][0] = u8vec3(uvec3(5u, 7u, 3u));
	var[0][2][1] = u8vec3(uvec3(9u, 8u, 1u));
	var[0][3][0] = u8vec3(uvec3(3u, 6u, 6u));
	var[0][3][1] = u8vec3(uvec3(2u, 7u, 9u));
	var[1][0][0] = u8vec3(uvec3(7u, 1u, 5u));
	var[1][0][1] = u8vec3(uvec3(1u, 7u, 9u));
	var[1][1][0] = u8vec3(uvec3(2u, 5u, 5u));
	var[1][1][1] = u8vec3(uvec3(5u, 9u, 6u));
	var[1][2][0] = u8vec3(uvec3(6u, 2u, 7u));
	var[1][2][1] = u8vec3(uvec3(0u, 2u, 7u));
	var[1][3][0] = u8vec3(uvec3(4u, 0u, 2u));
	var[1][3][1] = u8vec3(uvec3(1u, 5u, 4u));
	var[2][0][0] = u8vec3(uvec3(3u, 4u, 3u));
	var[2][0][1] = u8vec3(uvec3(5u, 7u, 4u));
	var[2][1][0] = u8vec3(uvec3(9u, 7u, 3u));
	var[2][1][1] = u8vec3(uvec3(9u, 4u, 9u));
	var[2][2][0] = u8vec3(uvec3(4u, 8u, 8u));
	var[2][2][1] = u8vec3(uvec3(6u, 1u, 2u));
	var[2][3][0] = u8vec3(uvec3(3u, 7u, 7u));
	var[2][3][1] = u8vec3(uvec3(3u, 8u, 8u));
}
#version 450
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
	highp float var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((var[0][0][0]), 7.0) && allOk;
	allOk = compare_float((var[0][0][1]), -1.0) && allOk;
	allOk = compare_float((var[0][1][0]), 4.0) && allOk;
	allOk = compare_float((var[0][1][1]), 2.0) && allOk;
	allOk = compare_float((var[0][2][0]), 1.0) && allOk;
	allOk = compare_float((var[0][2][1]), -3.0) && allOk;
	allOk = compare_float((var[0][3][0]), -4.0) && allOk;
	allOk = compare_float((var[0][3][1]), -5.0) && allOk;
	allOk = compare_float((var[1][0][0]), -6.0) && allOk;
	allOk = compare_float((var[1][0][1]), 0.0) && allOk;
	allOk = compare_float((var[1][1][0]), -1.0) && allOk;
	allOk = compare_float((var[1][1][1]), -6.0) && allOk;
	allOk = compare_float((var[1][2][0]), -7.0) && allOk;
	allOk = compare_float((var[1][2][1]), 8.0) && allOk;
	allOk = compare_float((var[1][3][0]), 9.0) && allOk;
	allOk = compare_float((var[1][3][1]), 7.0) && allOk;
	allOk = compare_float((var[2][0][0]), -7.0) && allOk;
	allOk = compare_float((var[2][0][1]), 5.0) && allOk;
	allOk = compare_float((var[2][1][0]), -2.0) && allOk;
	allOk = compare_float((var[2][1][1]), -1.0) && allOk;
	allOk = compare_float((var[2][2][0]), -9.0) && allOk;
	allOk = compare_float((var[2][2][1]), -4.0) && allOk;
	allOk = compare_float((var[2][3][0]), -7.0) && allOk;
	allOk = compare_float((var[2][3][1]), 8.0) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (-2.0);
	var[0][0][1] = (4.0);
	var[0][1][0] = (-8.0);
	var[0][1][1] = (9.0);
	var[0][2][0] = (-6.0);
	var[0][2][1] = (-9.0);
	var[0][3][0] = (5.0);
	var[0][3][1] = (4.0);
	var[1][0][0] = (6.0);
	var[1][0][1] = (7.0);
	var[1][1][0] = (-5.0);
	var[1][1][1] = (8.0);
	var[1][2][0] = (-4.0);
	var[1][2][1] = (3.0);
	var[1][3][0] = (-8.0);
	var[1][3][1] = (5.0);
	var[2][0][0] = (-4.0);
	var[2][0][1] = (5.0);
	var[2][1][0] = (-5.0);
	var[2][1][1] = (6.0);
	var[2][2][0] = (7.0);
	var[2][2][1] = (6.0);
	var[2][3][0] = (8.0);
	var[2][3][1] = (9.0);
}
#version 450
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
	highp mat4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0][0][0], mat4(1.0, 6.0, 7.0, 5.0, 2.0, -4.0, 0.0, 8.0, 3.0, 3.0, 9.0, 8.0, -2.0, 7.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(-1.0, 1.0, 9.0, 1.0, -2.0, -7.0, 3.0, 5.0, 2.0, -8.0, 8.0, -1.0, -4.0, -5.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(-3.0, 8.0, 3.0, 5.0, 3.0, 4.0, 5.0, 4.0, -2.0, -6.0, -8.0, -4.0, -5.0, -1.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(3.0, -1.0, -2.0, -6.0, -8.0, 2.0, 9.0, -9.0, 2.0, -3.0, 5.0, -1.0, -5.0, -4.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4(var[0][2][0], mat4(-3.0, 4.0, 8.0, 3.0, 4.0, -3.0, -4.0, -1.0, -4.0, 5.0, -4.0, 7.0, -7.0, 3.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat4(var[0][2][1], mat4(-6.0, -2.0, 6.0, 9.0, 8.0, -2.0, 0.0, 5.0, -9.0, 5.0, -1.0, 4.0, -3.0, 8.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat4(var[0][3][0], mat4(1.0, 6.0, -9.0, -8.0, -5.0, -5.0, 8.0, 1.0, 7.0, -6.0, -8.0, 7.0, -7.0, -3.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4(var[0][3][1], mat4(-3.0, -8.0, 9.0, 1.0, 3.0, -9.0, 9.0, -2.0, -7.0, 2.0, 9.0, -7.0, -5.0, 5.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(-9.0, 1.0, 1.0, -6.0, 5.0, -8.0, -6.0, -3.0, -4.0, 8.0, 9.0, -9.0, -4.0, -2.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(-7.0, -7.0, 7.0, -7.0, 4.0, 1.0, -4.0, -7.0, 6.0, -4.0, -3.0, -1.0, -2.0, -9.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(9.0, 9.0, 2.0, -3.0, -5.0, 5.0, 4.0, -6.0, -7.0, -1.0, -4.0, 6.0, -7.0, -9.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(-5.0, -1.0, 3.0, -4.0, 5.0, -7.0, -2.0, 3.0, 0.0, -1.0, 7.0, 5.0, -6.0, -1.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4(var[1][2][0], mat4(0.0, -2.0, 6.0, -1.0, 9.0, 9.0, -9.0, 0.0, 4.0, -3.0, 4.0, 1.0, -1.0, 3.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat4(var[1][2][1], mat4(-2.0, -2.0, 2.0, -3.0, 4.0, -1.0, 6.0, -4.0, 3.0, 0.0, 8.0, 1.0, -9.0, 8.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4(var[1][3][0], mat4(-6.0, -4.0, -8.0, -3.0, -3.0, 0.0, 3.0, 9.0, 7.0, 2.0, 4.0, 6.0, -9.0, 8.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat4(var[1][3][1], mat4(-5.0, -2.0, 1.0, -4.0, 8.0, -8.0, -5.0, -7.0, 8.0, -9.0, 4.0, 3.0, 2.0, 9.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(0.0, -8.0, 2.0, 0.0, -4.0, 1.0, 6.0, 1.0, 2.0, -1.0, -8.0, -9.0, -1.0, -9.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(-8.0, -3.0, -4.0, -8.0, 3.0, 1.0, 4.0, -4.0, -2.0, 6.0, -8.0, 3.0, 7.0, 5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(1.0, -9.0, -6.0, 7.0, 6.0, 4.0, -5.0, 0.0, 8.0, -4.0, -3.0, -6.0, -7.0, 4.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(-2.0, 4.0, -8.0, 7.0, -3.0, 2.0, -9.0, -8.0, 8.0, 9.0, -5.0, 0.0, 4.0, 3.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat4(var[2][2][0], mat4(1.0, -7.0, -9.0, 0.0, -1.0, -2.0, -1.0, 9.0, -9.0, 0.0, -4.0, -1.0, -6.0, 2.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat4(var[2][2][1], mat4(-2.0, -9.0, -3.0, 9.0, -7.0, -2.0, 7.0, 7.0, 1.0, 9.0, -4.0, 7.0, 0.0, 3.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat4(var[2][3][0], mat4(4.0, -4.0, 9.0, 3.0, -5.0, -7.0, 0.0, 3.0, -3.0, 6.0, -9.0, 9.0, 9.0, 8.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat4(var[2][3][1], mat4(9.0, 7.0, -7.0, -6.0, 0.0, -3.0, -2.0, 5.0, 2.0, -1.0, 0.0, -8.0, 1.0, -4.0, -7.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(-3.0, -6.0, 8.0, 7.0));
	var[0][0][0][1] = (vec4(-8.0, 6.0, 1.0, -6.0));
	var[0][0][0][2] = (vec4(6.0, 0.0, -6.0, 3.0));
	var[0][0][0][3] = (vec4(3.0, 3.0, -3.0, 2.0));
	var[0][0][1][0] = (vec4(-8.0, 9.0, -6.0, 6.0));
	var[0][0][1][1] = (vec4(1.0, 9.0, -7.0, 4.0));
	var[0][0][1][2] = (vec4(-5.0, 5.0, -6.0, 5.0));
	var[0][0][1][3] = (vec4(7.0, 7.0, -5.0, -9.0));
	var[0][1][0][0] = (vec4(7.0, -2.0, -7.0, 3.0));
	var[0][1][0][1] = (vec4(8.0, -7.0, -6.0, 4.0));
	var[0][1][0][2] = (vec4(-4.0, 6.0, -2.0, -7.0));
	var[0][1][0][3] = (vec4(7.0, 8.0, -8.0, -2.0));
	var[0][1][1][0] = (vec4(-8.0, 3.0, 9.0, 3.0));
	var[0][1][1][1] = (vec4(1.0, -3.0, -5.0, -8.0));
	var[0][1][1][2] = (vec4(-7.0, 5.0, -1.0, -6.0));
	var[0][1][1][3] = (vec4(8.0, -8.0, 4.0, 8.0));
	var[0][2][0][0] = (vec4(8.0, -9.0, 9.0, 7.0));
	var[0][2][0][1] = (vec4(-9.0, 5.0, 1.0, -4.0));
	var[0][2][0][2] = (vec4(-1.0, -2.0, 1.0, 5.0));
	var[0][2][0][3] = (vec4(-1.0, -5.0, 7.0, -6.0));
	var[0][2][1][0] = (vec4(1.0, 0.0, 9.0, -3.0));
	var[0][2][1][1] = (vec4(7.0, 0.0, -6.0, -7.0));
	var[0][2][1][2] = (vec4(-8.0, 1.0, -2.0, 9.0));
	var[0][2][1][3] = (vec4(0.0, -2.0, 6.0, -1.0));
	var[0][3][0][0] = (vec4(-2.0, -6.0, -2.0, -5.0));
	var[0][3][0][1] = (vec4(-9.0, 4.0, 4.0, -5.0));
	var[0][3][0][2] = (vec4(-1.0, -1.0, 0.0, -7.0));
	var[0][3][0][3] = (vec4(5.0, 7.0, -3.0, -7.0));
	var[0][3][1][0] = (vec4(9.0, -7.0, 5.0, 1.0));
	var[0][3][1][1] = (vec4(-7.0, 4.0, 8.0, -9.0));
	var[0][3][1][2] = (vec4(6.0, 2.0, -8.0, 8.0));
	var[0][3][1][3] = (vec4(3.0, 6.0, 9.0, 6.0));
	var[1][0][0][0] = (vec4(7.0, -2.0, -1.0, -4.0));
	var[1][0][0][1] = (vec4(-3.0, 3.0, -8.0, 7.0));
	var[1][0][0][2] = (vec4(-8.0, -5.0, -9.0, -1.0));
	var[1][0][0][3] = (vec4(0.0, -7.0, 7.0, 8.0));
	var[1][0][1][0] = (vec4(-6.0, -6.0, -1.0, 6.0));
	var[1][0][1][1] = (vec4(3.0, 5.0, -8.0, 3.0));
	var[1][0][1][2] = (vec4(1.0, -1.0, 3.0, -5.0));
	var[1][0][1][3] = (vec4(4.0, -4.0, 3.0, 4.0));
	var[1][1][0][0] = (vec4(6.0, -5.0, 4.0, -3.0));
	var[1][1][0][1] = (vec4(-1.0, -8.0, 3.0, 5.0));
	var[1][1][0][2] = (vec4(0.0, 7.0, 6.0, -4.0));
	var[1][1][0][3] = (vec4(1.0, 4.0, 3.0, 6.0));
	var[1][1][1][0] = (vec4(-3.0, -8.0, -6.0, 5.0));
	var[1][1][1][1] = (vec4(-9.0, -3.0, 0.0, -1.0));
	var[1][1][1][2] = (vec4(-5.0, 9.0, -8.0, -9.0));
	var[1][1][1][3] = (vec4(-1.0, 2.0, 5.0, 6.0));
	var[1][2][0][0] = (vec4(-5.0, -1.0, -3.0, 5.0));
	var[1][2][0][1] = (vec4(-7.0, 4.0, 5.0, -9.0));
	var[1][2][0][2] = (vec4(-1.0, 0.0, 8.0, 8.0));
	var[1][2][0][3] = (vec4(-3.0, 4.0, -4.0, -4.0));
	var[1][2][1][0] = (vec4(5.0, 8.0, -8.0, -1.0));
	var[1][2][1][1] = (vec4(-7.0, 8.0, 4.0, -1.0));
	var[1][2][1][2] = (vec4(-1.0, -9.0, 3.0, 2.0));
	var[1][2][1][3] = (vec4(4.0, -2.0, 7.0, 5.0));
	var[1][3][0][0] = (vec4(-4.0, -8.0, -1.0, 1.0));
	var[1][3][0][1] = (vec4(0.0, 5.0, 8.0, 6.0));
	var[1][3][0][2] = (vec4(3.0, 8.0, -7.0, -1.0));
	var[1][3][0][3] = (vec4(2.0, 3.0, 7.0, 3.0));
	var[1][3][1][0] = (vec4(-2.0, -1.0, 0.0, -2.0));
	var[1][3][1][1] = (vec4(7.0, -6.0, 5.0, 5.0));
	var[1][3][1][2] = (vec4(-9.0, -8.0, -5.0, 0.0));
	var[1][3][1][3] = (vec4(-2.0, 3.0, 8.0, 4.0));
	var[2][0][0][0] = (vec4(-4.0, -8.0, 4.0, 5.0));
	var[2][0][0][1] = (vec4(-5.0, 0.0, -3.0, -4.0));
	var[2][0][0][2] = (vec4(5.0, -4.0, -7.0, 4.0));
	var[2][0][0][3] = (vec4(-3.0, 9.0, 3.0, -4.0));
	var[2][0][1][0] = (vec4(-3.0, -9.0, 6.0, -3.0));
	var[2][0][1][1] = (vec4(-6.0, -1.0, 8.0, 3.0));
	var[2][0][1][2] = (vec4(-2.0, 9.0, -2.0, -3.0));
	var[2][0][1][3] = (vec4(-8.0, 3.0, -8.0, 5.0));
	var[2][1][0][0] = (vec4(2.0, 3.0, 8.0, 8.0));
	var[2][1][0][1] = (vec4(-7.0, -1.0, 5.0, -3.0));
	var[2][1][0][2] = (vec4(5.0, -3.0, -4.0, 6.0));
	var[2][1][0][3] = (vec4(-6.0, -5.0, 7.0, -6.0));
	var[2][1][1][0] = (vec4(7.0, -3.0, -8.0, 1.0));
	var[2][1][1][1] = (vec4(1.0, 2.0, 3.0, 1.0));
	var[2][1][1][2] = (vec4(5.0, -2.0, 2.0, -2.0));
	var[2][1][1][3] = (vec4(-9.0, -1.0, 2.0, -1.0));
	var[2][2][0][0] = (vec4(0.0, -5.0, 2.0, 2.0));
	var[2][2][0][1] = (vec4(4.0, 4.0, -9.0, 3.0));
	var[2][2][0][2] = (vec4(1.0, 0.0, 5.0, -8.0));
	var[2][2][0][3] = (vec4(-3.0, -3.0, 3.0, -6.0));
	var[2][2][1][0] = (vec4(-5.0, 9.0, 0.0, -6.0));
	var[2][2][1][1] = (vec4(-2.0, -4.0, 3.0, 1.0));
	var[2][2][1][2] = (vec4(4.0, 1.0, -3.0, 6.0));
	var[2][2][1][3] = (vec4(-2.0, -7.0, -7.0, 9.0));
	var[2][3][0][0] = (vec4(-2.0, -3.0, -9.0, 9.0));
	var[2][3][0][1] = (vec4(-6.0, -1.0, -3.0, 3.0));
	var[2][3][0][2] = (vec4(-7.0, 5.0, -6.0, 8.0));
	var[2][3][0][3] = (vec4(0.0, -5.0, 0.0, 4.0));
	var[2][3][1][0] = (vec4(-2.0, -9.0, -1.0, -2.0));
	var[2][3][1][1] = (vec4(2.0, -4.0, -6.0, -5.0));
	var[2][3][1][2] = (vec4(4.0, -4.0, 7.0, 2.0));
	var[2][3][1][3] = (vec4(3.0, 2.0, -2.0, -5.0));
}
#version 450
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
	highp mat2x3 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0][0][0], mat2x3(2.0, 5.0, 1.0, 7.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][1], mat2x3(3.0, 6.0, -3.0, 8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][0], mat2x3(-9.0, 5.0, -2.0, -8.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][1], mat2x3(-4.0, 0.0, 4.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[0][2][0], mat2x3(3.0, 9.0, -7.0, 8.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[0][2][1], mat2x3(6.0, 5.0, -8.0, -1.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[0][3][0], mat2x3(9.0, -9.0, -8.0, -9.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[0][3][1], mat2x3(-5.0, -6.0, -2.0, -1.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][0], mat2x3(-5.0, -2.0, 6.0, -5.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][1], mat2x3(3.0, 6.0, 4.0, 8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][0], mat2x3(1.0, -6.0, -1.0, -2.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][1], mat2x3(3.0, -1.0, 1.0, 5.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[1][2][0], mat2x3(-2.0, -2.0, 2.0, 9.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[1][2][1], mat2x3(-5.0, -3.0, -1.0, 9.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[1][3][0], mat2x3(-4.0, -4.0, 3.0, 5.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[1][3][1], mat2x3(-6.0, -8.0, 0.0, -1.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][0], mat2x3(-7.0, 3.0, -5.0, 2.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][1], mat2x3(2.0, 6.0, -6.0, -7.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][0], mat2x3(-9.0, 3.0, -4.0, 4.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][1], mat2x3(6.0, -9.0, -8.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[2][2][0], mat2x3(9.0, 2.0, -2.0, 6.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[2][2][1], mat2x3(9.0, -1.0, -8.0, 7.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[2][3][0], mat2x3(-4.0, 8.0, 6.0, -2.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[2][3][1], mat2x3(-8.0, 8.0, 5.0, -5.0, 4.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec3(1.0, -1.0, 1.0));
	var[0][0][0][1] = (vec3(-3.0, 9.0, -8.0));
	var[0][0][1][0] = (vec3(-5.0, 6.0, 6.0));
	var[0][0][1][1] = (vec3(3.0, -3.0, 7.0));
	var[0][1][0][0] = (vec3(6.0, -2.0, 0.0));
	var[0][1][0][1] = (vec3(3.0, 4.0, -6.0));
	var[0][1][1][0] = (vec3(3.0, -6.0, 2.0));
	var[0][1][1][1] = (vec3(4.0, -8.0, 0.0));
	var[0][2][0][0] = (vec3(0.0, 9.0, -7.0));
	var[0][2][0][1] = (vec3(5.0, 6.0, -3.0));
	var[0][2][1][0] = (vec3(-6.0, 0.0, -3.0));
	var[0][2][1][1] = (vec3(7.0, 9.0, -2.0));
	var[0][3][0][0] = (vec3(5.0, -2.0, -1.0));
	var[0][3][0][1] = (vec3(7.0, -7.0, 5.0));
	var[0][3][1][0] = (vec3(-3.0, 6.0, 7.0));
	var[0][3][1][1] = (vec3(6.0, -5.0, -2.0));
	var[1][0][0][0] = (vec3(-9.0, -2.0, -7.0));
	var[1][0][0][1] = (vec3(7.0, 0.0, -8.0));
	var[1][0][1][0] = (vec3(0.0, -5.0, 5.0));
	var[1][0][1][1] = (vec3(-2.0, 4.0, -8.0));
	var[1][1][0][0] = (vec3(-3.0, 3.0, 5.0));
	var[1][1][0][1] = (vec3(-6.0, -8.0, 8.0));
	var[1][1][1][0] = (vec3(4.0, -9.0, -1.0));
	var[1][1][1][1] = (vec3(-6.0, 7.0, -3.0));
	var[1][2][0][0] = (vec3(-7.0, 6.0, -7.0));
	var[1][2][0][1] = (vec3(8.0, -6.0, 8.0));
	var[1][2][1][0] = (vec3(4.0, -8.0, 4.0));
	var[1][2][1][1] = (vec3(4.0, 5.0, 5.0));
	var[1][3][0][0] = (vec3(2.0, -1.0, 2.0));
	var[1][3][0][1] = (vec3(-3.0, 6.0, -3.0));
	var[1][3][1][0] = (vec3(-2.0, 0.0, -6.0));
	var[1][3][1][1] = (vec3(2.0, -7.0, -2.0));
	var[2][0][0][0] = (vec3(-3.0, -4.0, 7.0));
	var[2][0][0][1] = (vec3(-3.0, -1.0, -9.0));
	var[2][0][1][0] = (vec3(2.0, -3.0, 6.0));
	var[2][0][1][1] = (vec3(-4.0, 8.0, 2.0));
	var[2][1][0][0] = (vec3(2.0, -2.0, 4.0));
	var[2][1][0][1] = (vec3(-3.0, -5.0, 9.0));
	var[2][1][1][0] = (vec3(-8.0, -1.0, 7.0));
	var[2][1][1][1] = (vec3(2.0, 0.0, 5.0));
	var[2][2][0][0] = (vec3(2.0, 3.0, 6.0));
	var[2][2][0][1] = (vec3(-4.0, -4.0, -1.0));
	var[2][2][1][0] = (vec3(-3.0, -1.0, -1.0));
	var[2][2][1][1] = (vec3(6.0, 2.0, 2.0));
	var[2][3][0][0] = (vec3(1.0, -8.0, -3.0));
	var[2][3][0][1] = (vec3(7.0, 3.0, 1.0));
	var[2][3][1][0] = (vec3(2.0, -8.0, 6.0));
	var[2][3][1][1] = (vec3(-8.0, -7.0, 0.0));
}
#version 450
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
	highp mat4x2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0][0][0], mat4x2(-5.0, -2.0, -4.0, 7.0, -9.0, -9.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][1], mat4x2(-6.0, -1.0, -5.0, -9.0, -2.0, -2.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][0], mat4x2(4.0, -8.0, 7.0, 0.0, 5.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][1], mat4x2(-9.0, -5.0, -3.0, 3.0, -3.0, 8.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[0][2][0], mat4x2(4.0, -4.0, -2.0, 1.0, 2.0, 6.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[0][2][1], mat4x2(8.0, 8.0, -3.0, -7.0, 8.0, -1.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[0][3][0], mat4x2(6.0, 8.0, 5.0, -7.0, -9.0, 6.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[0][3][1], mat4x2(1.0, -1.0, 8.0, 0.0, -2.0, -2.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][0], mat4x2(-3.0, -8.0, -8.0, 1.0, 3.0, 0.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][1], mat4x2(0.0, -7.0, -1.0, 4.0, -3.0, -1.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][0], mat4x2(-2.0, 0.0, 3.0, 5.0, 9.0, -9.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][1], mat4x2(9.0, -1.0, 3.0, 6.0, 8.0, -8.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][2][0], mat4x2(-4.0, 5.0, -6.0, 5.0, -9.0, -3.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[1][2][1], mat4x2(-9.0, -9.0, 0.0, -2.0, 7.0, 4.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[1][3][0], mat4x2(0.0, 1.0, -7.0, 0.0, -4.0, 9.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[1][3][1], mat4x2(-3.0, 5.0, 6.0, 1.0, -2.0, 9.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][0], mat4x2(0.0, 8.0, -9.0, -4.0, 3.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][1], mat4x2(-8.0, -6.0, 1.0, -7.0, 1.0, -4.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][0], mat4x2(-3.0, -9.0, -2.0, 8.0, -2.0, 7.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][1], mat4x2(-5.0, 8.0, -6.0, -6.0, -3.0, -1.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[2][2][0], mat4x2(0.0, -7.0, -8.0, 5.0, 7.0, -1.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[2][2][1], mat4x2(4.0, 3.0, 5.0, -4.0, 8.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[2][3][0], mat4x2(2.0, 8.0, -2.0, -7.0, 4.0, -5.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[2][3][1], mat4x2(-1.0, 2.0, 3.0, -6.0, 2.0, 8.0, 6.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4x2(0.0, -3.0, -2.0, 2.0, -2.0, -3.0, 5.0, -5.0));
	var[0][0][1] = (mat4x2(5.0, -6.0, -4.0, -1.0, 4.0, 7.0, -8.0, -2.0));
	var[0][1][0] = (mat4x2(6.0, -3.0, -5.0, -7.0, -7.0, 4.0, -9.0, 7.0));
	var[0][1][1] = (mat4x2(2.0, 2.0, 9.0, 3.0, -1.0, -8.0, 1.0, -5.0));
	var[0][2][0] = (mat4x2(2.0, -6.0, -9.0, 6.0, 2.0, -2.0, 9.0, 8.0));
	var[0][2][1] = (mat4x2(8.0, 3.0, -2.0, -8.0, 8.0, 4.0, -3.0, 4.0));
	var[0][3][0] = (mat4x2(-1.0, 2.0, 5.0, -9.0, 3.0, 2.0, -5.0, 4.0));
	var[0][3][1] = (mat4x2(-2.0, 3.0, -1.0, -4.0, -7.0, 3.0, 1.0, -1.0));
	var[1][0][0] = (mat4x2(-5.0, -1.0, -3.0, 6.0, -2.0, 0.0, -7.0, -7.0));
	var[1][0][1] = (mat4x2(2.0, 0.0, -6.0, 9.0, 1.0, -7.0, 4.0, -6.0));
	var[1][1][0] = (mat4x2(6.0, 2.0, -6.0, 4.0, -3.0, -6.0, -7.0, -8.0));
	var[1][1][1] = (mat4x2(-1.0, -4.0, -5.0, 2.0, -7.0, -1.0, 7.0, 1.0));
	var[1][2][0] = (mat4x2(-5.0, 5.0, 9.0, -8.0, -8.0, -5.0, -4.0, -1.0));
	var[1][2][1] = (mat4x2(-1.0, -6.0, 6.0, -3.0, -5.0, 2.0, 6.0, 1.0));
	var[1][3][0] = (mat4x2(3.0, 6.0, -6.0, -2.0, -8.0, 0.0, -9.0, -5.0));
	var[1][3][1] = (mat4x2(-9.0, 5.0, -9.0, 2.0, -2.0, -5.0, -3.0, 5.0));
	var[2][0][0] = (mat4x2(5.0, -4.0, -3.0, 8.0, -6.0, -1.0, -6.0, 7.0));
	var[2][0][1] = (mat4x2(4.0, 7.0, -6.0, 5.0, -4.0, -7.0, 2.0, 1.0));
	var[2][1][0] = (mat4x2(9.0, -3.0, -8.0, 4.0, 5.0, -9.0, 9.0, -3.0));
	var[2][1][1] = (mat4x2(5.0, 6.0, -5.0, 1.0, 0.0, 8.0, -9.0, -4.0));
	var[2][2][0] = (mat4x2(-9.0, 0.0, -5.0, -9.0, 9.0, 8.0, -6.0, -4.0));
	var[2][2][1] = (mat4x2(-4.0, -8.0, 9.0, 7.0, -5.0, -3.0, 3.0, 7.0));
	var[2][3][0] = (mat4x2(-8.0, -1.0, 9.0, 1.0, -6.0, 5.0, -5.0, -9.0));
	var[2][3][1] = (mat4x2(7.0, 1.0, 0.0, 3.0, 4.0, 8.0, 8.0, -2.0));
}
#version 450
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
	highp mat4x3 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0][0][0], mat4x3(5.0, 0.0, 3.0, -5.0, 9.0, -6.0, 8.0, -6.0, 6.0, 2.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(1.0, 7.0, 3.0, 4.0, 6.0, 2.0, -7.0, -9.0, -6.0, 1.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(-6.0, 1.0, 5.0, 9.0, -2.0, 8.0, 4.0, 6.0, -1.0, -2.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(5.0, -5.0, -3.0, 4.0, -3.0, -5.0, 8.0, 4.0, -8.0, -2.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[0][2][0], mat4x3(6.0, -5.0, -6.0, 6.0, 3.0, -1.0, 3.0, 3.0, 7.0, 3.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[0][2][1], mat4x3(-8.0, 2.0, 5.0, -7.0, 6.0, -6.0, -4.0, 3.0, 5.0, 1.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[0][3][0], mat4x3(9.0, 7.0, 1.0, 2.0, 8.0, 4.0, 2.0, -2.0, 1.0, 2.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[0][3][1], mat4x3(-3.0, -8.0, 7.0, -1.0, 8.0, -8.0, 6.0, -2.0, 2.0, -2.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(4.0, -7.0, -2.0, 5.0, -7.0, 6.0, 7.0, 1.0, -4.0, -7.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(8.0, 0.0, -3.0, -3.0, 9.0, 2.0, -6.0, 4.0, 1.0, -1.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(-6.0, -4.0, 6.0, -4.0, -8.0, 2.0, 3.0, -2.0, 0.0, -4.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(7.0, 4.0, -7.0, 3.0, 5.0, 4.0, 0.0, -1.0, 2.0, 6.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[1][2][0], mat4x3(-3.0, 2.0, 2.0, -2.0, -2.0, 2.0, 5.0, 6.0, 3.0, -8.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[1][2][1], mat4x3(-8.0, -7.0, 6.0, 1.0, 0.0, -2.0, -9.0, 5.0, 0.0, 5.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[1][3][0], mat4x3(9.0, 4.0, -9.0, -2.0, -3.0, -2.0, 2.0, 1.0, -8.0, 7.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[1][3][1], mat4x3(0.0, 4.0, 9.0, -3.0, 3.0, 5.0, 8.0, 3.0, 0.0, -3.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(7.0, -3.0, -4.0, 9.0, 3.0, 6.0, -1.0, -1.0, 6.0, -7.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(7.0, -9.0, -5.0, 9.0, 7.0, -1.0, -2.0, 7.0, -2.0, 0.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(-8.0, -7.0, -4.0, 9.0, 4.0, -9.0, -4.0, 2.0, -6.0, -4.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(-2.0, 3.0, 5.0, 2.0, -4.0, -5.0, -2.0, 4.0, 4.0, -3.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[2][2][0], mat4x3(9.0, 5.0, 6.0, 9.0, -3.0, -5.0, -4.0, -2.0, 3.0, -9.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[2][2][1], mat4x3(5.0, -9.0, -3.0, 8.0, -8.0, 6.0, 6.0, 8.0, -6.0, 5.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[2][3][0], mat4x3(5.0, -8.0, 5.0, 4.0, -4.0, 5.0, -2.0, 0.0, -4.0, 1.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[2][3][1], mat4x3(2.0, -5.0, -4.0, -7.0, 7.0, -3.0, 9.0, -4.0, -8.0, 1.0, -3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4x3(6.0, -7.0, 0.0, 3.0, -1.0, -9.0, -7.0, -5.0, 8.0, 0.0, 1.0, 5.0));
	var[0][0][1] = (mat4x3(7.0, 1.0, 5.0, 7.0, -8.0, 4.0, 2.0, -8.0, -8.0, 3.0, -6.0, -5.0));
	var[0][1][0] = (mat4x3(-6.0, 0.0, 1.0, -1.0, 4.0, 2.0, 0.0, -8.0, 7.0, -3.0, 1.0, -7.0));
	var[0][1][1] = (mat4x3(3.0, 8.0, 6.0, 5.0, 6.0, -2.0, -7.0, -5.0, 0.0, -4.0, -8.0, 5.0));
	var[0][2][0] = (mat4x3(-6.0, 9.0, 3.0, 4.0, 2.0, -2.0, -4.0, 3.0, 0.0, 4.0, -2.0, 0.0));
	var[0][2][1] = (mat4x3(6.0, -8.0, 4.0, 9.0, 3.0, 0.0, -8.0, -3.0, 5.0, 5.0, 7.0, 7.0));
	var[0][3][0] = (mat4x3(-9.0, -6.0, -4.0, -8.0, 0.0, 1.0, -9.0, -8.0, 1.0, 6.0, 3.0, -7.0));
	var[0][3][1] = (mat4x3(-8.0, -3.0, 4.0, -2.0, 5.0, -2.0, 4.0, 4.0, -7.0, 0.0, 0.0, -9.0));
	var[1][0][0] = (mat4x3(5.0, -7.0, 8.0, -7.0, -3.0, -4.0, -9.0, -9.0, -6.0, 5.0, -8.0, 1.0));
	var[1][0][1] = (mat4x3(-2.0, 3.0, -2.0, -9.0, 2.0, 9.0, -2.0, 8.0, -8.0, -8.0, -7.0, -5.0));
	var[1][1][0] = (mat4x3(3.0, -9.0, -8.0, -7.0, 3.0, 3.0, 3.0, -7.0, -5.0, -9.0, -1.0, -8.0));
	var[1][1][1] = (mat4x3(6.0, -5.0, 6.0, -8.0, -2.0, -6.0, 9.0, 0.0, 8.0, -9.0, -7.0, 1.0));
	var[1][2][0] = (mat4x3(-1.0, -4.0, -7.0, -7.0, 7.0, 9.0, -7.0, 3.0, 7.0, -6.0, -6.0, 8.0));
	var[1][2][1] = (mat4x3(7.0, -7.0, -8.0, -3.0, 8.0, -1.0, -8.0, 2.0, -9.0, 9.0, 0.0, -7.0));
	var[1][3][0] = (mat4x3(-5.0, -9.0, -7.0, 2.0, 1.0, 6.0, -3.0, 4.0, 2.0, 4.0, 3.0, -6.0));
	var[1][3][1] = (mat4x3(3.0, 5.0, 5.0, 8.0, -4.0, -5.0, 6.0, 5.0, -2.0, -2.0, -1.0, -1.0));
	var[2][0][0] = (mat4x3(7.0, -4.0, -6.0, -5.0, 0.0, 0.0, -6.0, -5.0, 1.0, 9.0, -4.0, -9.0));
	var[2][0][1] = (mat4x3(-5.0, 7.0, 2.0, 6.0, -1.0, -7.0, -9.0, -4.0, 5.0, -4.0, -3.0, 3.0));
	var[2][1][0] = (mat4x3(8.0, -5.0, 0.0, -7.0, -6.0, 2.0, 0.0, -8.0, 1.0, -5.0, -9.0, -2.0));
	var[2][1][1] = (mat4x3(1.0, 0.0, 8.0, -8.0, 6.0, 7.0, 6.0, 2.0, 0.0, 3.0, -4.0, -6.0));
	var[2][2][0] = (mat4x3(-4.0, -2.0, 9.0, 2.0, -9.0, 7.0, 0.0, -4.0, 0.0, -3.0, 4.0, -6.0));
	var[2][2][1] = (mat4x3(9.0, -7.0, 9.0, 4.0, -8.0, 9.0, 0.0, -6.0, -6.0, 4.0, 4.0, 3.0));
	var[2][3][0] = (mat4x3(-2.0, 6.0, 8.0, 5.0, 5.0, 5.0, 4.0, 1.0, 7.0, -4.0, 8.0, -2.0));
	var[2][3][1] = (mat4x3(4.0, 7.0, 3.0, 7.0, 5.0, 9.0, -9.0, -5.0, 0.0, 1.0, -1.0, -2.0));
}
#version 450
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
	allOk = compare_mat2x3(var[0][0][0], mat2x3(2.0, 5.0, 1.0, 7.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][1], mat2x3(3.0, 6.0, -3.0, 8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][0], mat2x3(-9.0, 5.0, -2.0, -8.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][1], mat2x3(-4.0, 0.0, 4.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[0][2][0], mat2x3(3.0, 9.0, -7.0, 8.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[0][2][1], mat2x3(6.0, 5.0, -8.0, -1.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[0][3][0], mat2x3(9.0, -9.0, -8.0, -9.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[0][3][1], mat2x3(-5.0, -6.0, -2.0, -1.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][0], mat2x3(-5.0, -2.0, 6.0, -5.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][1], mat2x3(3.0, 6.0, 4.0, 8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][0], mat2x3(1.0, -6.0, -1.0, -2.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][1], mat2x3(3.0, -1.0, 1.0, 5.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[1][2][0], mat2x3(-2.0, -2.0, 2.0, 9.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[1][2][1], mat2x3(-5.0, -3.0, -1.0, 9.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[1][3][0], mat2x3(-4.0, -4.0, 3.0, 5.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[1][3][1], mat2x3(-6.0, -8.0, 0.0, -1.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][0], mat2x3(-7.0, 3.0, -5.0, 2.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][1], mat2x3(2.0, 6.0, -6.0, -7.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][0], mat2x3(-9.0, 3.0, -4.0, 4.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][1], mat2x3(6.0, -9.0, -8.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[2][2][0], mat2x3(9.0, 2.0, -2.0, 6.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[2][2][1], mat2x3(9.0, -1.0, -8.0, 7.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[2][3][0], mat2x3(-4.0, 8.0, 6.0, -2.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[2][3][1], mat2x3(-8.0, 8.0, 5.0, -5.0, 4.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec3(1.0, -1.0, 1.0));
	var[0][0][0][1] = (vec3(-3.0, 9.0, -8.0));
	var[0][0][1][0] = (vec3(-5.0, 6.0, 6.0));
	var[0][0][1][1] = (vec3(3.0, -3.0, 7.0));
	var[0][1][0][0] = (vec3(6.0, -2.0, 0.0));
	var[0][1][0][1] = (vec3(3.0, 4.0, -6.0));
	var[0][1][1][0] = (vec3(3.0, -6.0, 2.0));
	var[0][1][1][1] = (vec3(4.0, -8.0, 0.0));
	var[0][2][0][0] = (vec3(0.0, 9.0, -7.0));
	var[0][2][0][1] = (vec3(5.0, 6.0, -3.0));
	var[0][2][1][0] = (vec3(-6.0, 0.0, -3.0));
	var[0][2][1][1] = (vec3(7.0, 9.0, -2.0));
	var[0][3][0][0] = (vec3(5.0, -2.0, -1.0));
	var[0][3][0][1] = (vec3(7.0, -7.0, 5.0));
	var[0][3][1][0] = (vec3(-3.0, 6.0, 7.0));
	var[0][3][1][1] = (vec3(6.0, -5.0, -2.0));
	var[1][0][0][0] = (vec3(-9.0, -2.0, -7.0));
	var[1][0][0][1] = (vec3(7.0, 0.0, -8.0));
	var[1][0][1][0] = (vec3(0.0, -5.0, 5.0));
	var[1][0][1][1] = (vec3(-2.0, 4.0, -8.0));
	var[1][1][0][0] = (vec3(-3.0, 3.0, 5.0));
	var[1][1][0][1] = (vec3(-6.0, -8.0, 8.0));
	var[1][1][1][0] = (vec3(4.0, -9.0, -1.0));
	var[1][1][1][1] = (vec3(-6.0, 7.0, -3.0));
	var[1][2][0][0] = (vec3(-7.0, 6.0, -7.0));
	var[1][2][0][1] = (vec3(8.0, -6.0, 8.0));
	var[1][2][1][0] = (vec3(4.0, -8.0, 4.0));
	var[1][2][1][1] = (vec3(4.0, 5.0, 5.0));
	var[1][3][0][0] = (vec3(2.0, -1.0, 2.0));
	var[1][3][0][1] = (vec3(-3.0, 6.0, -3.0));
	var[1][3][1][0] = (vec3(-2.0, 0.0, -6.0));
	var[1][3][1][1] = (vec3(2.0, -7.0, -2.0));
	var[2][0][0][0] = (vec3(-3.0, -4.0, 7.0));
	var[2][0][0][1] = (vec3(-3.0, -1.0, -9.0));
	var[2][0][1][0] = (vec3(2.0, -3.0, 6.0));
	var[2][0][1][1] = (vec3(-4.0, 8.0, 2.0));
	var[2][1][0][0] = (vec3(2.0, -2.0, 4.0));
	var[2][1][0][1] = (vec3(-3.0, -5.0, 9.0));
	var[2][1][1][0] = (vec3(-8.0, -1.0, 7.0));
	var[2][1][1][1] = (vec3(2.0, 0.0, 5.0));
	var[2][2][0][0] = (vec3(2.0, 3.0, 6.0));
	var[2][2][0][1] = (vec3(-4.0, -4.0, -1.0));
	var[2][2][1][0] = (vec3(-3.0, -1.0, -1.0));
	var[2][2][1][1] = (vec3(6.0, 2.0, 2.0));
	var[2][3][0][0] = (vec3(1.0, -8.0, -3.0));
	var[2][3][0][1] = (vec3(7.0, 3.0, 1.0));
	var[2][3][1][0] = (vec3(2.0, -8.0, 6.0));
	var[2][3][1][1] = (vec3(-8.0, -7.0, 0.0));
}
#version 450
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
	highp mat2x4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0][0][0], mat2x4(-9.0, -2.0, -2.0, -1.0, -8.0, -3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(-4.0, 1.0, 0.0, -7.0, 3.0, -6.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(-3.0, 2.0, -6.0, -2.0, -7.0, -5.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(-8.0, 4.0, -2.0, 8.0, 5.0, -2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[0][2][0], mat2x4(-4.0, -8.0, 6.0, -4.0, 4.0, 5.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[0][2][1], mat2x4(6.0, -2.0, 3.0, -8.0, 9.0, 7.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[0][3][0], mat2x4(-6.0, -3.0, 8.0, -9.0, 1.0, 9.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[0][3][1], mat2x4(-8.0, 7.0, -3.0, -1.0, 4.0, -4.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(5.0, 4.0, -2.0, 4.0, 2.0, -4.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(2.0, -7.0, -6.0, -5.0, 6.0, 3.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(-1.0, -5.0, -5.0, 6.0, -9.0, 1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(3.0, 8.0, -1.0, 5.0, -1.0, 8.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[1][2][0], mat2x4(-1.0, -8.0, 3.0, -4.0, -5.0, -8.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[1][2][1], mat2x4(1.0, 3.0, -7.0, 0.0, 9.0, 7.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[1][3][0], mat2x4(3.0, 4.0, -2.0, -2.0, -6.0, -4.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[1][3][1], mat2x4(8.0, -1.0, 6.0, -1.0, 5.0, -5.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(0.0, -7.0, 0.0, 0.0, 6.0, -7.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(-4.0, -2.0, -3.0, 7.0, -4.0, 6.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(3.0, -9.0, -2.0, 3.0, -1.0, -9.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(-2.0, 8.0, -1.0, 6.0, -7.0, 7.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[2][2][0], mat2x4(5.0, 2.0, -3.0, -6.0, 1.0, 7.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[2][2][1], mat2x4(2.0, 8.0, -1.0, -2.0, 7.0, 2.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[2][3][0], mat2x4(-1.0, 7.0, 4.0, 1.0, 8.0, -1.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[2][3][1], mat2x4(7.0, 3.0, -4.0, 5.0, 4.0, 8.0, -5.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(-3.0, 4.0, -6.0, 2.0));
	var[0][0][0][1] = (vec4(-4.0, -6.0, -3.0, 6.0));
	var[0][0][1][0] = (vec4(-5.0, 1.0, 6.0, 1.0));
	var[0][0][1][1] = (vec4(1.0, 7.0, 0.0, 9.0));
	var[0][1][0][0] = (vec4(-3.0, -1.0, -6.0, -2.0));
	var[0][1][0][1] = (vec4(-8.0, 6.0, 0.0, 4.0));
	var[0][1][1][0] = (vec4(0.0, -8.0, -6.0, 7.0));
	var[0][1][1][1] = (vec4(3.0, -7.0, -4.0, 3.0));
	var[0][2][0][0] = (vec4(5.0, 0.0, -1.0, 5.0));
	var[0][2][0][1] = (vec4(7.0, 6.0, 4.0, 7.0));
	var[0][2][1][0] = (vec4(-6.0, 5.0, -9.0, 9.0));
	var[0][2][1][1] = (vec4(-5.0, -5.0, -6.0, 8.0));
	var[0][3][0][0] = (vec4(1.0, 4.0, 2.0, 8.0));
	var[0][3][0][1] = (vec4(1.0, -2.0, 4.0, 5.0));
	var[0][3][1][0] = (vec4(0.0, 7.0, 8.0, 6.0));
	var[0][3][1][1] = (vec4(-7.0, -6.0, -1.0, 7.0));
	var[1][0][0][0] = (vec4(8.0, 6.0, -7.0, -4.0));
	var[1][0][0][1] = (vec4(-6.0, 5.0, 5.0, -6.0));
	var[1][0][1][0] = (vec4(5.0, -4.0, 0.0, 2.0));
	var[1][0][1][1] = (vec4(-8.0, 6.0, 9.0, 4.0));
	var[1][1][0][0] = (vec4(-8.0, 2.0, 8.0, -7.0));
	var[1][1][0][1] = (vec4(5.0, -9.0, 7.0, 7.0));
	var[1][1][1][0] = (vec4(6.0, 7.0, -7.0, 4.0));
	var[1][1][1][1] = (vec4(0.0, 8.0, -1.0, -1.0));
	var[1][2][0][0] = (vec4(2.0, 4.0, 8.0, 5.0));
	var[1][2][0][1] = (vec4(3.0, 5.0, 5.0, 8.0));
	var[1][2][1][0] = (vec4(2.0, 7.0, -5.0, -9.0));
	var[1][2][1][1] = (vec4(-3.0, 0.0, 2.0, -7.0));
	var[1][3][0][0] = (vec4(-1.0, -9.0, 8.0, 3.0));
	var[1][3][0][1] = (vec4(-6.0, 4.0, 0.0, 8.0));
	var[1][3][1][0] = (vec4(0.0, 9.0, 6.0, 5.0));
	var[1][3][1][1] = (vec4(-1.0, 1.0, 1.0, 7.0));
	var[2][0][0][0] = (vec4(-8.0, 0.0, -2.0, -3.0));
	var[2][0][0][1] = (vec4(-7.0, 4.0, 2.0, -2.0));
	var[2][0][1][0] = (vec4(2.0, 3.0, 8.0, -9.0));
	var[2][0][1][1] = (vec4(-7.0, 3.0, -4.0, -7.0));
	var[2][1][0][0] = (vec4(4.0, -5.0, 4.0, 6.0));
	var[2][1][0][1] = (vec4(9.0, 0.0, 5.0, -9.0));
	var[2][1][1][0] = (vec4(2.0, 0.0, -8.0, 6.0));
	var[2][1][1][1] = (vec4(1.0, 2.0, 2.0, -6.0));
	var[2][2][0][0] = (vec4(4.0, -2.0, 4.0, 5.0));
	var[2][2][0][1] = (vec4(-6.0, 1.0, -4.0, -8.0));
	var[2][2][1][0] = (vec4(5.0, 2.0, 2.0, 4.0));
	var[2][2][1][1] = (vec4(2.0, 1.0, -2.0, 2.0));
	var[2][3][0][0] = (vec4(6.0, -6.0, -7.0, 9.0));
	var[2][3][0][1] = (vec4(-7.0, -4.0, -9.0, 7.0));
	var[2][3][1][0] = (vec4(-2.0, 4.0, -8.0, -3.0));
	var[2][3][1][1] = (vec4(1.0, 7.0, 7.0, -3.0));
}
#version 450
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
	i16vec3 var[][4][2];
};

bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(var[0][0][0]), ivec3(3, 4, 8)) && allOk;
	allOk = compare_i16vec3(ivec3(var[0][0][1]), ivec3(7, -4, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(var[0][1][0]), ivec3(-1, -4, -8)) && allOk;
	allOk = compare_i16vec3(ivec3(var[0][1][1]), ivec3(2, -8, 6)) && allOk;
	allOk = compare_i16vec3(ivec3(var[0][2][0]), ivec3(6, -2, -7)) && allOk;
	allOk = compare_i16vec3(ivec3(var[0][2][1]), ivec3(-6, 6, -1)) && allOk;
	allOk = compare_i16vec3(ivec3(var[0][3][0]), ivec3(-6, 2, 1)) && allOk;
	allOk = compare_i16vec3(ivec3(var[0][3][1]), ivec3(-4, 3, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][0][0]), ivec3(6, -5, -9)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][0][1]), ivec3(9, 4, 2)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][1][0]), ivec3(0, -3, 3)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][1][1]), ivec3(-6, 0, -1)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][2][0]), ivec3(-4, -6, -9)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][2][1]), ivec3(-5, -9, -4)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][3][0]), ivec3(-1, 4, -7)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][3][1]), ivec3(2, 8, -9)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][0][0]), ivec3(-6, 6, -2)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][0][1]), ivec3(2, -1, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][1][0]), ivec3(5, 1, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][1][1]), ivec3(8, 5, 1)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][2][0]), ivec3(7, -7, -2)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][2][1]), ivec3(2, 6, 2)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][3][0]), ivec3(-8, -6, -7)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][3][1]), ivec3(7, -5, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = i16vec3(ivec3(6, 1, -2));
	var[0][0][1] = i16vec3(ivec3(-3, -1, -4));
	var[0][1][0] = i16vec3(ivec3(-5, -4, -8));
	var[0][1][1] = i16vec3(ivec3(0, 9, 6));
	var[0][2][0] = i16vec3(ivec3(-6, 7, -4));
	var[0][2][1] = i16vec3(ivec3(-8, 4, 1));
	var[0][3][0] = i16vec3(ivec3(-6, 9, -3));
	var[0][3][1] = i16vec3(ivec3(6, 8, 2));
	var[1][0][0] = i16vec3(ivec3(-2, -2, 2));
	var[1][0][1] = i16vec3(ivec3(0, -6, -2));
	var[1][1][0] = i16vec3(ivec3(5, -3, 4));
	var[1][1][1] = i16vec3(ivec3(-3, 9, 0));
	var[1][2][0] = i16vec3(ivec3(5, -4, -6));
	var[1][2][1] = i16vec3(ivec3(-6, 2, -7));
	var[1][3][0] = i16vec3(ivec3(7, -2, 2));
	var[1][3][1] = i16vec3(ivec3(5, -9, -7));
	var[2][0][0] = i16vec3(ivec3(0, -9, 2));
	var[2][0][1] = i16vec3(ivec3(-8, 6, 2));
	var[2][1][0] = i16vec3(ivec3(1, -5, 8));
	var[2][1][1] = i16vec3(ivec3(-5, 0, 7));
	var[2][2][0] = i16vec3(ivec3(-2, 2, -5));
	var[2][2][1] = i16vec3(ivec3(-3, -1, 0));
	var[2][3][0] = i16vec3(ivec3(4, -3, -4));
	var[2][3][1] = i16vec3(ivec3(-6, -4, -6));
}
#version 450
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
	allOk = compare_ivec3((block[0].s[0].a), ivec3(2, 5, 1)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[0], mat3(1.0, 1.0, -8.0, -9.0, -8.0, -2.0, -9.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[1], mat3(-7.0, 3.0, 0.0, -2.0, 3.0, 5.0, -1.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[2], mat3(5.0, -4.0, -8.0, 1.0, 5.0, 3.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[3], mat3(-1.0, 9.0, -1.0, 6.0, -6.0, -8.0, 5.0, 2.0, 0.0)) && allOk;
	allOk = compare_vec4((block[0].s[0].c), vec4(-6.0, 0.0, 6.0, -3.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1].a), ivec3(5, 0, -2)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[0], mat3(8.0, -8.0, -8.0, 8.0, 4.0, 2.0, -7.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[1], mat3(-7.0, -4.0, 5.0, -5.0, 8.0, -4.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[2], mat3(5.0, -3.0, -9.0, 7.0, 0.0, 0.0, 2.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[3], mat3(-9.0, -1.0, 9.0, -9.0, -1.0, 2.0, -7.0, -8.0, -2.0)) && allOk;
	allOk = compare_vec4((block[0].s[1].c), vec4(-6.0, 8.0, -2.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2].a), ivec3(-5, -5, -1)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[0], mat3(-4.0, -2.0, -3.0, -9.0, -3.0, -9.0, 1.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[1], mat3(3.0, -4.0, -5.0, 3.0, -1.0, -3.0, -3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[2], mat3(3.0, 5.0, -1.0, -2.0, -6.0, -4.0, -8.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[3], mat3(3.0, 0.0, -9.0, 2.0, -9.0, 2.0, 8.0, -4.0, 0.0)) && allOk;
	allOk = compare_vec4((block[0].s[2].c), vec4(2.0, 1.0, -4.0, -2.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0].a), ivec3(7, -5, 0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[0], mat3(-5.0, 5.0, -3.0, -2.0, -9.0, 9.0, -1.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[1], mat3(-3.0, 9.0, 6.0, -7.0, 0.0, 2.0, 5.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[2], mat3(-4.0, 8.0, 0.0, -1.0, 1.0, 3.0, 7.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[3], mat3(5.0, -9.0, -3.0, -3.0, 5.0, 2.0, 1.0, -1.0, -5.0)) && allOk;
	allOk = compare_vec4((block[1].s[0].c), vec4(1.0, 5.0, 5.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1].a), ivec3(3, 8, -5)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[0], mat3(-2.0, 4.0, -7.0, 5.0, 0.0, 7.0, 5.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[1], mat3(2.0, -6.0, 7.0, -7.0, 1.0, -6.0, -4.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[2], mat3(-1.0, -2.0, -2.0, -7.0, 1.0, -2.0, -9.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[3], mat3(1.0, 1.0, 6.0, -2.0, 9.0, 8.0, -9.0, -4.0, -5.0)) && allOk;
	allOk = compare_vec4((block[1].s[1].c), vec4(1.0, -3.0, -8.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[1].s[2].a), ivec3(6, -7, 5)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[0], mat3(-3.0, 5.0, 6.0, 2.0, -2.0, -6.0, 1.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[1], mat3(3.0, -3.0, -4.0, -7.0, -7.0, 1.0, -1.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[2], mat3(-8.0, -7.0, 7.0, -4.0, 9.0, -1.0, -6.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[3], mat3(2.0, -3.0, 4.0, -7.0, -3.0, 9.0, -7.0, -7.0, 7.0)) && allOk;
	allOk = compare_vec4((block[1].s[2].c), vec4(3.0, -7.0, 8.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0].a), ivec3(3, -4, -8)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[0], mat3(-5.0, 4.0, -2.0, 1.0, -1.0, 6.0, 2.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[1], mat3(7.0, 1.0, 1.0, -2.0, -2.0, 6.0, 3.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[2], mat3(6.0, 0.0, 5.0, 7.0, -8.0, 0.0, 8.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[3], mat3(-8.0, -8.0, -6.0, -6.0, -6.0, -3.0, 8.0, 9.0, 5.0)) && allOk;
	allOk = compare_vec4((block[2].s[0].c), vec4(-6.0, -4.0, 5.0, 2.0)) && allOk;
	allOk = compare_ivec3((block[2].s[1].a), ivec3(-6, -6, 5)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[0], mat3(-6.0, -8.0, 4.0, -6.0, 6.0, -7.0, 0.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[1], mat3(-9.0, 8.0, 1.0, -9.0, -9.0, 4.0, -7.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[2], mat3(2.0, 0.0, -9.0, 8.0, -1.0, -4.0, -6.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[3], mat3(4.0, 8.0, -9.0, 8.0, -8.0, 7.0, 1.0, -9.0, -2.0)) && allOk;
	allOk = compare_vec4((block[2].s[1].c), vec4(3.0, 4.0, 2.0, -7.0)) && allOk;
	allOk = compare_ivec3((block[2].s[2].a), ivec3(8, 4, 6)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[0], mat3(7.0, 3.0, -1.0, 6.0, 1.0, -5.0, 2.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[1], mat3(1.0, -9.0, 2.0, 7.0, 5.0, -1.0, 3.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[2], mat3(4.0, 0.0, -8.0, 9.0, 9.0, -7.0, -9.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[3], mat3(-4.0, -8.0, -5.0, -3.0, 3.0, 8.0, -4.0, 9.0, -6.0)) && allOk;
	allOk = compare_vec4((block[2].s[2].c), vec4(2.0, 6.0, -5.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s[0].a = (ivec3(-4, 7, 5));
	block[0].s[0].b[0] = (mat3(5.0, 7.0, -1.0, -8.0, -6.0, -1.0, 4.0, 9.0, -7.0));
	block[0].s[0].b[1] = (mat3(-5.0, -1.0, 5.0, 9.0, -8.0, 6.0, -9.0, 8.0, 2.0));
	block[0].s[0].b[2] = (mat3(-2.0, -9.0, -2.0, 1.0, 2.0, -1.0, 5.0, -4.0, 6.0));
	block[0].s[0].b[3] = (mat3(8.0, -8.0, 4.0, 0.0, 5.0, 3.0, 3.0, 7.0, -2.0));
	block[0].s[0].c = (vec4(-8.0, 6.0, 0.0, 9.0));
	block[0].s[1].a = (ivec3(3, -9, -1));
	block[0].s[1].b[0] = (mat3(-3.0, -5.0, -8.0, 9.0, 4.0, -6.0, 1.0, -4.0, -2.0));
	block[0].s[1].b[1] = (mat3(9.0, 6.0, -3.0, -7.0, 7.0, 5.0, 2.0, -7.0, 6.0));
	block[0].s[1].b[2] = (mat3(1.0, 3.0, 6.0, -6.0, 5.0, -6.0, 3.0, 5.0, 5.0));
	block[0].s[1].b[3] = (mat3(4.0, -7.0, -5.0, 6.0, -2.0, 8.0, -4.0, 1.0, 7.0));
	block[0].s[1].c = (vec4(-5.0, -6.0, 8.0, -2.0));
	block[0].s[2].a = (ivec3(5, 9, -5));
	block[0].s[2].b[0] = (mat3(-9.0, 9.0, 8.0, -9.0, 6.0, 0.0, 0.0, 7.0, 1.0));
	block[0].s[2].b[1] = (mat3(-9.0, -1.0, -3.0, 1.0, 9.0, 0.0, 9.0, 7.0, -1.0));
	block[0].s[2].b[2] = (mat3(0.0, -2.0, -1.0, -5.0, -8.0, 2.0, -2.0, 2.0, 3.0));
	block[0].s[2].b[3] = (mat3(6.0, 0.0, 5.0, -8.0, -1.0, 8.0, 5.0, -2.0, -1.0));
	block[0].s[2].c = (vec4(4.0, -6.0, -4.0, 9.0));
	block[0].v = (vec4(1.0, 0.0, 7.0, -2.0));
	block[1].s[0].a = (ivec3(-6, 2, 6));
	block[1].s[0].b[0] = (mat3(-6.0, 5.0, 4.0, 1.0, -5.0, -2.0, -5.0, -9.0, -6.0));
	block[1].s[0].b[1] = (mat3(2.0, 7.0, 3.0, -2.0, 4.0, -5.0, 9.0, -1.0, 1.0));
	block[1].s[0].b[2] = (mat3(5.0, -4.0, 9.0, 7.0, -9.0, -9.0, 1.0, 5.0, 5.0));
	block[1].s[0].b[3] = (mat3(-8.0, 8.0, 7.0, 4.0, -3.0, -7.0, 4.0, 9.0, 9.0));
	block[1].s[0].c = (vec4(-6.0, 1.0, -8.0, -2.0));
	block[1].s[1].a = (ivec3(-8, 4, -9));
	block[1].s[1].b[0] = (mat3(4.0, -6.0, -6.0, -7.0, 8.0, -4.0, 7.0, 7.0, 7.0));
	block[1].s[1].b[1] = (mat3(-1.0, 3.0, 4.0, -7.0, -6.0, 8.0, -2.0, -5.0, 1.0));
	block[1].s[1].b[2] = (mat3(-1.0, -6.0, 2.0, -5.0, 0.0, 0.0, -1.0, -8.0, 1.0));
	block[1].s[1].b[3] = (mat3(-7.0, 9.0, -8.0, -1.0, -5.0, 7.0, 8.0, -2.0, 6.0));
	block[1].s[1].c = (vec4(-7.0, 5.0, 6.0, -6.0));
	block[1].s[2].a = (ivec3(-8, -1, 7));
	block[1].s[2].b[0] = (mat3(-3.0, 9.0, 7.0, 5.0, -1.0, 0.0, 6.0, -9.0, 5.0));
	block[1].s[2].b[1] = (mat3(-6.0, 8.0, 0.0, -4.0, -3.0, -8.0, 6.0, -1.0, 2.0));
	block[1].s[2].b[2] = (mat3(-3.0, 2.0, 5.0, -2.0, -6.0, -7.0, -8.0, -1.0, -2.0));
	block[1].s[2].b[3] = (mat3(-5.0, 3.0, -8.0, -5.0, 0.0, 2.0, -8.0, -9.0, -3.0));
	block[1].s[2].c = (vec4(5.0, -1.0, 7.0, -4.0));
	block[1].v = (vec4(4.0, 9.0, 8.0, 4.0));
	block[2].s[0].a = (ivec3(7, -7, 9));
	block[2].s[0].b[0] = (mat3(-5.0, 5.0, -2.0, 4.0, -4.0, -9.0, -2.0, 1.0, -2.0));
	block[2].s[0].b[1] = (mat3(6.0, 2.0, -9.0, 7.0, -1.0, 8.0, -9.0, 7.0, -1.0));
	block[2].s[0].b[2] = (mat3(-5.0, 0.0, 1.0, 7.0, -6.0, -8.0, 6.0, 3.0, -9.0));
	block[2].s[0].b[3] = (mat3(0.0, 4.0, 0.0, 4.0, 1.0, -3.0, -1.0, 2.0, -7.0));
	block[2].s[0].c = (vec4(-1.0, -3.0, -1.0, 0.0));
	block[2].s[1].a = (ivec3(8, 5, -9));
	block[2].s[1].b[0] = (mat3(-7.0, 2.0, 5.0, -9.0, 4.0, -5.0, 7.0, -5.0, -2.0));
	block[2].s[1].b[1] = (mat3(7.0, -5.0, -1.0, -6.0, -5.0, 6.0, 2.0, -3.0, -1.0));
	block[2].s[1].b[2] = (mat3(-1.0, -5.0, -7.0, -2.0, 1.0, -8.0, 0.0, 4.0, 8.0));
	block[2].s[1].b[3] = (mat3(6.0, 8.0, -3.0, 7.0, -8.0, -1.0, -7.0, -6.0, -9.0));
	block[2].s[1].c = (vec4(-8.0, 7.0, -9.0, -9.0));
	block[2].s[2].a = (ivec3(-1, -7, -3));
	block[2].s[2].b[0] = (mat3(-8.0, 8.0, 4.0, 9.0, 1.0, 8.0, 6.0, -8.0, 1.0));
	block[2].s[2].b[1] = (mat3(-7.0, 1.0, -1.0, -5.0, -2.0, 3.0, -7.0, 8.0, -4.0));
	block[2].s[2].b[2] = (mat3(-2.0, 7.0, -9.0, 9.0, 5.0, -3.0, -6.0, -4.0, 1.0));
	block[2].s[2].b[3] = (mat3(-4.0, -8.0, -6.0, 9.0, 3.0, -5.0, -2.0, -3.0, 1.0));
	block[2].s[2].c = (vec4(-5.0, -8.0, 6.0, -7.0));
	block[2].v = (vec4(-9.0, 4.0, 0.0, 8.0));
}
#version 450
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
	allOk = compare_uint((u), 3u) && allOk;
	allOk = compare_mat4x3(t[0].a, mat4x3(0.0, 6.0, 0.0, 9.0, 6.0, 1.0, 8.0, 2.0, -8.0, -9.0, -1.0, 5.0)) && allOk;
	allOk = compare_uvec3((t[0].b[0].a), uvec3(7u, 7u, 9u)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[0]), vec2(4.0, -3.0)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[1]), vec2(-2.0, -5.0)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[2]), vec2(7.0, -7.0)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[3]), vec2(0.0, 1.0)) && allOk;
	allOk = compare_vec4((t[0].b[0].c), vec4(1.0, -8.0, 0.0, 5.0)) && allOk;
	allOk = compare_uvec3((t[0].b[1].a), uvec3(9u, 7u, 4u)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[0]), vec2(4.0, -8.0)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[1]), vec2(-2.0, -4.0)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[2]), vec2(-6.0, -8.0)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[3]), vec2(7.0, -8.0)) && allOk;
	allOk = compare_vec4((t[0].b[1].c), vec4(1.0, 3.0, 7.0, -3.0)) && allOk;
	allOk = compare_uvec3((t[0].b[2].a), uvec3(9u, 0u, 1u)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[0]), vec2(-3.0, 8.0)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[1]), vec2(-3.0, 4.0)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[2]), vec2(6.0, -7.0)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[3]), vec2(-8.0, 1.0)) && allOk;
	allOk = compare_vec4((t[0].b[2].c), vec4(-3.0, -7.0, 5.0, 0.0)) && allOk;
	allOk = compare_int((t[0].c), 6) && allOk;
	allOk = compare_mat4x3(t[1].a, mat4x3(6.0, 6.0, 0.0, -9.0, -5.0, -5.0, -9.0, -5.0, -2.0, 8.0, -4.0, 0.0)) && allOk;
	allOk = compare_uvec3((t[1].b[0].a), uvec3(7u, 2u, 4u)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[0]), vec2(9.0, -3.0)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[1]), vec2(-2.0, -3.0)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[2]), vec2(8.0, -3.0)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[3]), vec2(4.0, -1.0)) && allOk;
	allOk = compare_vec4((t[1].b[0].c), vec4(-3.0, -1.0, -7.0, -6.0)) && allOk;
	allOk = compare_uvec3((t[1].b[1].a), uvec3(4u, 1u, 4u)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[0]), vec2(6.0, -5.0)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[1]), vec2(7.0, 3.0)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[2]), vec2(-7.0, -6.0)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[3]), vec2(-4.0, -8.0)) && allOk;
	allOk = compare_vec4((t[1].b[1].c), vec4(2.0, 4.0, 6.0, 9.0)) && allOk;
	allOk = compare_uvec3((t[1].b[2].a), uvec3(9u, 6u, 9u)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[0]), vec2(-2.0, -3.0)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[1]), vec2(6.0, 6.0)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[2]), vec2(0.0, 8.0)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[3]), vec2(-3.0, 7.0)) && allOk;
	allOk = compare_vec4((t[1].b[2].c), vec4(8.0, -7.0, 5.0, 6.0)) && allOk;
	allOk = compare_int((t[1].c), -6) && allOk;
	allOk = compare_mat4x3(t[2].a, mat4x3(-9.0, -5.0, 9.0, 3.0, 7.0, 8.0, 6.0, 9.0, -6.0, 1.0, 1.0, 8.0)) && allOk;
	allOk = compare_uvec3((t[2].b[0].a), uvec3(4u, 8u, 6u)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[0]), vec2(5.0, -6.0)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[1]), vec2(-3.0, -5.0)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[2]), vec2(7.0, -1.0)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[3]), vec2(4.0, -6.0)) && allOk;
	allOk = compare_vec4((t[2].b[0].c), vec4(-2.0, 1.0, -8.0, 2.0)) && allOk;
	allOk = compare_uvec3((t[2].b[1].a), uvec3(1u, 3u, 4u)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[0]), vec2(-9.0, -9.0)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[1]), vec2(-3.0, 4.0)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[2]), vec2(9.0, 7.0)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[3]), vec2(-9.0, -9.0)) && allOk;
	allOk = compare_vec4((t[2].b[1].c), vec4(-5.0, -8.0, -9.0, -9.0)) && allOk;
	allOk = compare_uvec3((t[2].b[2].a), uvec3(6u, 7u, 2u)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[0]), vec2(-3.0, 4.0)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[1]), vec2(9.0, -3.0)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[2]), vec2(5.0, 6.0)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[3]), vec2(-4.0, 3.0)) && allOk;
	allOk = compare_vec4((t[2].b[2].c), vec4(2.0, 4.0, -7.0, 0.0)) && allOk;
	allOk = compare_int((t[2].c), -9) && allOk;
	allOk = compare_mat4x3(t[3].a, mat4x3(-9.0, -2.0, 8.0, 0.0, 8.0, 4.0, 0.0, -9.0, 5.0, 8.0, 6.0, 8.0)) && allOk;
	allOk = compare_uvec3((t[3].b[0].a), uvec3(3u, 5u, 2u)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[0]), vec2(-2.0, 8.0)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[1]), vec2(0.0, 1.0)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[2]), vec2(-2.0, 8.0)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[3]), vec2(-1.0, 7.0)) && allOk;
	allOk = compare_vec4((t[3].b[0].c), vec4(-9.0, -9.0, -8.0, -1.0)) && allOk;
	allOk = compare_uvec3((t[3].b[1].a), uvec3(0u, 2u, 8u)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[0]), vec2(0.0, 7.0)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[1]), vec2(8.0, 5.0)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[2]), vec2(5.0, -1.0)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[3]), vec2(5.0, 9.0)) && allOk;
	allOk = compare_vec4((t[3].b[1].c), vec4(0.0, -6.0, 2.0, -6.0)) && allOk;
	allOk = compare_uvec3((t[3].b[2].a), uvec3(3u, 2u, 8u)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[0]), vec2(-2.0, -4.0)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[1]), vec2(-9.0, -6.0)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[2]), vec2(-5.0, 9.0)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[3]), vec2(-3.0, 3.0)) && allOk;
	allOk = compare_vec4((t[3].b[2].c), vec4(9.0, -6.0, 8.0, 6.0)) && allOk;
	allOk = compare_int((t[3].c), 6) && allOk;
    if (allOk)
        ac_numPassed++;

	s.a = (uvec3(1u, 8u, 3u));
	s.b[0] = (vec2(1.0, -7.0));
	s.b[1] = (vec2(5.0, -7.0));
	s.b[2] = (vec2(2.0, -2.0));
	s.b[3] = (vec2(-1.0, -6.0));
	s.c = (vec4(-6.0, 7.0, 1.0, 8.0));
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

layout(std140, binding = 1) buffer Block
{
	bvec3 var;
} block[3];

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

layout(std140, binding = 1) buffer Block
{
	uint16_t var;
} block[3];

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(block[0].var), 9u) && allOk;
	allOk = compare_uint16_t(uint(block[1].var), 5u) && allOk;
	allOk = compare_uint16_t(uint(block[2].var), 4u) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = uint16_t(9u);
	block[1].var = uint16_t(1u);
	block[2].var = uint16_t(1u);
}
#version 450
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
	bvec2 var;
} block[3];

bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((block[0].var), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block[1].var), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block[2].var), bvec2(false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (bvec2(true, false));
	block[1].var = (bvec2(true, true));
	block[2].var = (bvec2(false, false));
}
#version 450
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

layout(scalar, row_major, binding = 1) buffer Block
{
	float padding;
	highp mat2 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), 3.0) && allOk;
	allOk = compare_mat2(block[0].var, mat2(-4.0, -1.0, 8.0, -3.0)) && allOk;
	allOk = compare_float((block[1].padding), -6.0) && allOk;
	allOk = compare_mat2(block[1].var, mat2(1.0, -5.0, -6.0, -5.0)) && allOk;
	allOk = compare_float((block[2].padding), -3.0) && allOk;
	allOk = compare_mat2(block[2].var, mat2(-8.0, 4.0, -4.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (3.0);
	block[0].var = (mat2(2.0, -8.0, -6.0, 2.0));
	block[1].padding = (-3.0);
	block[1].var = (mat2(-5.0, 4.0, 9.0, -2.0));
	block[2].padding = (-9.0);
	block[2].var = (mat2(-6.0, -5.0, -2.0, 4.0));
}
#version 450
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
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), -8.0) && allOk;
	allOk = compare_float(block[0].var[0][0], 2.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -3.0) && allOk;
	allOk = compare_float(block[0].var[0][2], -5.0) && allOk;
	allOk = compare_float(block[0].var[0][3], -8.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -3.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 6.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -5.0) && allOk;
	allOk = compare_float(block[0].var[1][3], -2.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(2.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(-3.0, 6.0, -5.0, -2.0)) && allOk;
	allOk = compare_float((block[1].padding), -6.0) && allOk;
	allOk = compare_float(block[1].var[0][0], 8.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 0.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 5.0) && allOk;
	allOk = compare_float(block[1].var[0][3], 1.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 9.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 2.0) && allOk;
	allOk = compare_float(block[1].var[1][2], -1.0) && allOk;
	allOk = compare_float(block[1].var[1][3], -7.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(8.0, 0.0, 5.0, 1.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(9.0, 2.0, -1.0, -7.0)) && allOk;
	allOk = compare_float((block[2].padding), -1.0) && allOk;
	allOk = compare_float(block[2].var[0][0], -3.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 8.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 0.0) && allOk;
	allOk = compare_float(block[2].var[0][3], 9.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -5.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 4.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -3.0) && allOk;
	allOk = compare_float(block[2].var[1][3], -4.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(-3.0, 8.0, 0.0, 9.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(-5.0, 4.0, -3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-2.0);
	block[0].var = (mat2x4(2.0, -2.0, 9.0, -4.0, 3.0, 2.0, -4.0, 0.0));
	block[1].padding = (6.0);
	block[1].var = (mat2x4(7.0, 4.0, -8.0, 2.0, 0.0, -1.0, -8.0, 5.0));
	block[2].padding = (8.0);
	block[2].var = (mat2x4(4.0, -3.0, 4.0, 7.0, 2.0, 4.0, -6.0, 1.0));
}
#version 450
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
	int8_t padding;
	i8vec2 var;
} block[3];

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(block[0].padding), 4294967288) && allOk;
	allOk = compare_i8vec2(ivec2(block[0].var), ivec2(4294967293, 1)) && allOk;
	allOk = compare_int8_t(int(block[1].padding), 9) && allOk;
	allOk = compare_i8vec2(ivec2(block[1].var), ivec2(0, 1)) && allOk;
	allOk = compare_int8_t(int(block[2].padding), 4294967288) && allOk;
	allOk = compare_i8vec2(ivec2(block[2].var), ivec2(4294967293, 4294967290)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = int8_t(0);
	block[0].var = i8vec2(ivec2(8, 4294967292));
	block[1].padding = int8_t(9);
	block[1].var = i8vec2(ivec2(4294967294, 4294967295));
	block[2].padding = int8_t(8);
	block[2].var = i8vec2(ivec2(4294967290, 8));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, binding = 1) buffer BlockA
{
	highp float a;
	lowp uvec3 b;
	mediump mat2 c;
} blockA;
layout(scalar, binding = 2) buffer BlockB
{
	mediump mat3 a;
	lowp ivec2 b;
	highp vec4 c;
	bool d;
} blockB;

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

layout(std140, binding = 1) buffer BlockB
{
	mediump uint a[1];
	lowp int b;
};
layout(std430, binding = 2) buffer BlockC
{
	highp uint c;
	lowp uint d;
	lowp uint e[1];
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	highp int f[1];
	mediump int g;
	lowp int h[1];
	bool i;
	lowp int j[1];
} blockD;

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((b), -2) && allOk;
	allOk = compare_uint((blockC.d), 6u) && allOk;
	allOk = compare_int((blockD.g), -1) && allOk;
	allOk = compare_int((blockD.h[0]), 9) && allOk;
	allOk = compare_bool((blockD.i), false) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (5u);
	b = (1);
	blockC.c = (3u);
	blockC.d = (2u);
	blockC.e[0] = (1u);
	blockD.f[0] = (-4);
	blockD.g = (1);
	blockD.i = (false);
	blockD.j[0] = (0);
}
#version 450
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
	mediump mat2x3 a;
	mediump mat4x3 b[8];
	lowp ivec2 c[];
};
layout(std140, binding = 2) buffer BlockC
{
	bvec2 d[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(a, mat2x3(-5.0, 5.0, -6.0, -9.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4x3(b[0], mat4x3(7.0, 7.0, 0.0, 5.0, -7.0, -5.0, -2.0, -1.0, 5.0, 2.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(b[1], mat4x3(7.0, -1.0, 3.0, -2.0, -1.0, -5.0, 5.0, 3.0, 9.0, -5.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat4x3(b[2], mat4x3(-8.0, 4.0, -8.0, -3.0, -1.0, 4.0, -9.0, 7.0, 1.0, -4.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat4x3(b[3], mat4x3(0.0, 6.0, 8.0, 5.0, 9.0, -3.0, 2.0, 2.0, 3.0, 3.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat4x3(b[4], mat4x3(-3.0, -3.0, 8.0, 3.0, -1.0, 0.0, -6.0, -5.0, -3.0, -5.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x3(b[5], mat4x3(0.0, 5.0, -4.0, 4.0, -4.0, -1.0, -4.0, -1.0, -1.0, -1.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(b[6], mat4x3(-4.0, -8.0, 9.0, -5.0, 7.0, -8.0, -2.0, -1.0, 4.0, 5.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat4x3(b[7], mat4x3(-9.0, 8.0, 9.0, -3.0, 8.0, 2.0, 7.0, -5.0, -3.0, 3.0, 4.0, -7.0)) && allOk;
	allOk = compare_ivec2((c[0]), ivec2(0, 2)) && allOk;
	allOk = compare_ivec2((c[1]), ivec2(-2, 2)) && allOk;
	allOk = compare_ivec2((c[2]), ivec2(3, 2)) && allOk;
	allOk = compare_ivec2((c[3]), ivec2(0, 9)) && allOk;
	allOk = compare_ivec2((c[4]), ivec2(3, 4)) && allOk;
	allOk = compare_bvec2((d[0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((d[1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((d[2]), bvec2(false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat2x3(3.0, -4.0, 2.0, 2.0, 4.0, 9.0));
	b[0] = (mat4x3(-2.0, -4.0, -9.0, -2.0, 0.0, 9.0, 8.0, -5.0, 4.0, -6.0, -8.0, -5.0));
	b[1] = (mat4x3(0.0, 4.0, 7.0, 3.0, -2.0, 9.0, 0.0, 6.0, -5.0, 5.0, 5.0, -5.0));
	b[2] = (mat4x3(-2.0, -4.0, -4.0, -9.0, -5.0, 4.0, -3.0, -8.0, -8.0, 9.0, 4.0, 4.0));
	b[3] = (mat4x3(-3.0, 8.0, -6.0, -2.0, -6.0, -9.0, 2.0, 6.0, -9.0, -4.0, 6.0, 0.0));
	b[4] = (mat4x3(-2.0, -5.0, -5.0, -4.0, -9.0, 7.0, -1.0, -8.0, 9.0, 2.0, 5.0, -2.0));
	b[5] = (mat4x3(-5.0, 0.0, -4.0, 9.0, 0.0, -5.0, 8.0, -4.0, 6.0, -6.0, 2.0, 7.0));
	b[6] = (mat4x3(8.0, 7.0, -6.0, -2.0, 8.0, 6.0, -6.0, 1.0, -8.0, 1.0, -8.0, 6.0));
	b[7] = (mat4x3(-7.0, 0.0, 1.0, -9.0, -4.0, 1.0, 6.0, 0.0, 2.0, 3.0, 6.0, -6.0));
	d[0] = (bvec2(false, false));
	d[1] = (bvec2(true, false));
	d[2] = (bvec2(false, true));
}
#version 450
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
	highp mat2x3 mA;
};
layout(std140, binding = 1) buffer BlockB
{
	lowp mat2x3 a;
	highp uvec2 b;
	lowp mat2 c;
	sA d;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB.a, mat2x3(-4.0, 4.0, -6.0, -2.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat2(blockB.c, mat2(2.0, 3.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat2x3(blockB.d.mA, mat2x3(-6.0, -3.0, -1.0, 4.0, 8.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2x3(6.0, 0.0, 5.0, 1.0, -7.0, -3.0));
	blockB.b = (uvec2(9u, 3u));
	blockB.d.mA = (mat2x3(-9.0, 5.0, 4.0, -2.0, -5.0, 5.0));
}
#version 450
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
	mediump uvec4 a;
	highp vec3 b;
	bvec4 c;
	mediump uvec2 d[];
};
layout(std430, binding = 2) buffer BlockC
{
	lowp ivec4 e[3];
	bvec4 f;
	bool g[];
} blockC;
layout(std140, row_major, binding = 3) buffer BlockD
{
	bvec4 h[];
};
layout(std430, binding = 4) buffer BlockE
{
	highp uvec4 i;
	bvec4 j;
	mediump uint k[8];
	bvec3 l;
} blockE[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((a), uvec4(5u, 0u, 2u, 9u)) && allOk;
	allOk = compare_vec3((b), vec3(6.0, 2.0, -2.0)) && allOk;
	allOk = compare_ivec4((blockC.e[0]), ivec4(7, -9, 1, 5)) && allOk;
	allOk = compare_ivec4((blockC.e[1]), ivec4(9, -3, 2, 2)) && allOk;
	allOk = compare_ivec4((blockC.e[2]), ivec4(8, 9, -6, 7)) && allOk;
	allOk = compare_uint((blockE[0].k[0]), 9u) && allOk;
	allOk = compare_uint((blockE[0].k[1]), 8u) && allOk;
	allOk = compare_uint((blockE[0].k[2]), 4u) && allOk;
	allOk = compare_uint((blockE[0].k[3]), 5u) && allOk;
	allOk = compare_uint((blockE[0].k[4]), 0u) && allOk;
	allOk = compare_uint((blockE[0].k[5]), 3u) && allOk;
	allOk = compare_uint((blockE[0].k[6]), 8u) && allOk;
	allOk = compare_uint((blockE[0].k[7]), 7u) && allOk;
	allOk = compare_bvec3((blockE[0].l), bvec3(true, true, true)) && allOk;
	allOk = compare_uint((blockE[1].k[0]), 5u) && allOk;
	allOk = compare_uint((blockE[1].k[1]), 5u) && allOk;
	allOk = compare_uint((blockE[1].k[2]), 7u) && allOk;
	allOk = compare_uint((blockE[1].k[3]), 9u) && allOk;
	allOk = compare_uint((blockE[1].k[4]), 5u) && allOk;
	allOk = compare_uint((blockE[1].k[5]), 7u) && allOk;
	allOk = compare_uint((blockE[1].k[6]), 8u) && allOk;
	allOk = compare_uint((blockE[1].k[7]), 0u) && allOk;
	allOk = compare_bvec3((blockE[1].l), bvec3(true, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (uvec4(7u, 2u, 6u, 6u));
	b = (vec3(5.0, -9.0, 8.0));
	blockC.e[0] = (ivec4(6, -3, 8, 7));
	blockC.e[1] = (ivec4(-8, 2, -5, 3));
	blockC.e[2] = (ivec4(-3, 5, -3, 8));
	blockC.f = (bvec4(false, false, false, true));
	blockC.g[0] = (false);
	h[0] = (bvec4(false, false, false, false));
	h[1] = (bvec4(false, false, true, true));
	blockE[0].j = (bvec4(true, true, false, true));
	blockE[0].k[0] = (6u);
	blockE[0].k[1] = (1u);
	blockE[0].k[2] = (9u);
	blockE[0].k[3] = (2u);
	blockE[0].k[4] = (3u);
	blockE[0].k[5] = (3u);
	blockE[0].k[6] = (8u);
	blockE[0].k[7] = (9u);
	blockE[1].j = (bvec4(false, true, true, false));
	blockE[1].k[0] = (3u);
	blockE[1].k[1] = (1u);
	blockE[1].k[2] = (2u);
	blockE[1].k[3] = (5u);
	blockE[1].k[4] = (6u);
	blockE[1].k[5] = (6u);
	blockE[1].k[6] = (9u);
	blockE[1].k[7] = (7u);
}
#version 450
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
	mediump mat4x2 mA[2];
	highp vec3 mB;
	bvec4 mC;
};
struct sB
{
	highp vec4 mA;
	mediump int mB;
	highp ivec2 mC;
	sA mD;
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	highp mat2 a;
	mediump vec4 b;
	highp mat3x2 c[];
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	mediump vec2 d;
	bvec3 e;
	mediump ivec4 f;
	bvec4 g;
	sB h;
} blockC[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB.a, mat2(8.0, -5.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[0], mat3x2(8.0, -1.0, -8.0, 4.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[1], mat3x2(3.0, -9.0, -5.0, -9.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[2], mat3x2(2.0, 1.0, -8.0, -1.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[3], mat3x2(9.0, 8.0, 8.0, 8.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[4], mat3x2(3.0, 4.0, -7.0, -6.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[5], mat3x2(-5.0, 4.0, -1.0, 6.0, 8.0, 4.0)) && allOk;
	allOk = compare_bvec3((blockC[0].e), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec4((blockC[0].g), bvec4(false, false, true, false)) && allOk;
	allOk = compare_vec4((blockC[0].h.mA), vec4(0.0, 9.0, 1.0, -2.0)) && allOk;
	allOk = compare_int((blockC[0].h.mB), -2) && allOk;
	allOk = compare_ivec2((blockC[0].h.mC), ivec2(8, -5)) && allOk;
	allOk = compare_mat4x2(blockC[0].h.mD.mA[0], mat4x2(3.0, 6.0, 0.0, -6.0, -3.0, 8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].h.mD.mA[1], mat4x2(-7.0, 5.0, 5.0, 7.0, 6.0, 6.0, -8.0, 7.0)) && allOk;
	allOk = compare_vec3((blockC[0].h.mD.mB), vec3(2.0, -2.0, 7.0)) && allOk;
	allOk = compare_bvec4((blockC[0].h.mD.mC), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec3((blockC[1].e), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec4((blockC[1].g), bvec4(true, true, true, true)) && allOk;
	allOk = compare_vec4((blockC[1].h.mA), vec4(1.0, -5.0, -8.0, 1.0)) && allOk;
	allOk = compare_int((blockC[1].h.mB), -2) && allOk;
	allOk = compare_ivec2((blockC[1].h.mC), ivec2(9, 0)) && allOk;
	allOk = compare_mat4x2(blockC[1].h.mD.mA[0], mat4x2(-4.0, 4.0, -5.0, 5.0, 0.0, -2.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat4x2(blockC[1].h.mD.mA[1], mat4x2(2.0, -1.0, 3.0, -3.0, -4.0, -8.0, 9.0, -2.0)) && allOk;
	allOk = compare_vec3((blockC[1].h.mD.mB), vec3(4.0, -1.0, -8.0)) && allOk;
	allOk = compare_bvec4((blockC[1].h.mD.mC), bvec4(false, false, false, true)) && allOk;
	allOk = compare_bvec3((blockC[2].e), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec4((blockC[2].g), bvec4(true, true, false, false)) && allOk;
	allOk = compare_vec4((blockC[2].h.mA), vec4(-4.0, 3.0, 0.0, -8.0)) && allOk;
	allOk = compare_int((blockC[2].h.mB), 8) && allOk;
	allOk = compare_ivec2((blockC[2].h.mC), ivec2(8, 6)) && allOk;
	allOk = compare_mat4x2(blockC[2].h.mD.mA[0], mat4x2(-9.0, 8.0, -1.0, 8.0, -3.0, -8.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat4x2(blockC[2].h.mD.mA[1], mat4x2(8.0, 8.0, 8.0, -1.0, -7.0, -7.0, 4.0, -5.0)) && allOk;
	allOk = compare_vec3((blockC[2].h.mD.mB), vec3(0.0, -1.0, 6.0)) && allOk;
	allOk = compare_bvec4((blockC[2].h.mD.mC), bvec4(false, true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2(8.0, 2.0, -4.0, 3.0));
	blockB.b = (vec4(-3.0, 7.0, -3.0, 4.0));
	blockC[0].e = (bvec3(true, false, false));
	blockC[0].g = (bvec4(true, false, false, true));
	blockC[0].h.mA = (vec4(-9.0, 5.0, -1.0, -9.0));
	blockC[0].h.mB = (7);
	blockC[0].h.mC = (ivec2(-4, 9));
	blockC[0].h.mD.mA[0] = (mat4x2(-5.0, -3.0, 4.0, 7.0, -6.0, -4.0, 6.0, 1.0));
	blockC[0].h.mD.mA[1] = (mat4x2(-8.0, -2.0, 3.0, 9.0, -6.0, -7.0, 9.0, -9.0));
	blockC[0].h.mD.mB = (vec3(9.0, 0.0, 5.0));
	blockC[0].h.mD.mC = (bvec4(true, true, true, false));
	blockC[1].e = (bvec3(false, true, false));
	blockC[1].g = (bvec4(true, true, true, true));
	blockC[1].h.mA = (vec4(-5.0, 6.0, 2.0, 3.0));
	blockC[1].h.mB = (8);
	blockC[1].h.mC = (ivec2(-2, 3));
	blockC[1].h.mD.mA[0] = (mat4x2(7.0, 6.0, 0.0, -8.0, 4.0, 3.0, 6.0, 5.0));
	blockC[1].h.mD.mA[1] = (mat4x2(6.0, 7.0, 6.0, -4.0, 5.0, -3.0, 3.0, 1.0));
	blockC[1].h.mD.mB = (vec3(2.0, 3.0, 9.0));
	blockC[1].h.mD.mC = (bvec4(false, true, true, true));
	blockC[2].e = (bvec3(true, false, true));
	blockC[2].g = (bvec4(true, true, false, false));
	blockC[2].h.mA = (vec4(-2.0, 8.0, -4.0, 2.0));
	blockC[2].h.mB = (3);
	blockC[2].h.mC = (ivec2(9, -5));
	blockC[2].h.mD.mA[0] = (mat4x2(0.0, -4.0, -1.0, -3.0, -3.0, 1.0, 7.0, -3.0));
	blockC[2].h.mD.mA[1] = (mat4x2(-7.0, -8.0, -3.0, 3.0, 4.0, -1.0, 6.0, -1.0));
	blockC[2].h.mD.mB = (vec3(-5.0, -1.0, -8.0));
	blockC[2].h.mD.mC = (bvec4(false, false, true, false));
}
#version 450
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
	layout(offset = 0) bool a;
	layout(offset = 4) mediump float b;
	layout(offset = 16) lowp ivec3 c;
	layout(offset = 32) highp ivec4 d;
	layout(offset = 48) mediump ivec4 e;
} blockB[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB[0].a), true) && allOk;
	allOk = compare_float((blockB[0].b), 4.0) && allOk;
	allOk = compare_ivec4((blockB[0].d), ivec4(1, 0, 5, 7)) && allOk;
	allOk = compare_ivec4((blockB[0].e), ivec4(-2, -5, -1, -9)) && allOk;
	allOk = compare_bool((blockB[1].a), false) && allOk;
	allOk = compare_float((blockB[1].b), -4.0) && allOk;
	allOk = compare_ivec4((blockB[1].d), ivec4(-6, 7, 5, 4)) && allOk;
	allOk = compare_ivec4((blockB[1].e), ivec4(0, 0, 9, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (-5.0);
	blockB[0].c = (ivec3(-5, 8, -6));
	blockB[0].d = (ivec4(-1, -8, -8, -6));
	blockB[0].e = (ivec4(1, -2, 4, 9));
	blockB[1].b = (-5.0);
	blockB[1].c = (ivec3(8, 3, -1));
	blockB[1].d = (ivec4(7, -2, -7, -4));
	blockB[1].e = (ivec4(-2, 0, -2, -6));
}
#version 450
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
	layout(offset = 16) bvec4 b[1];
	layout(offset = 32) highp ivec4 c[1];
	layout(offset = 48) mediump vec2 d;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) lowp vec3 e;
	layout(offset = 16) mediump uvec4 f;
	layout(offset = 32) lowp ivec3 g;
	layout(offset = 44) highp float h[1];
	layout(offset = 48) bvec3 i;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) lowp uvec4 j;
	layout(offset = 16) bvec3 k;
	layout(offset = 32) highp vec3 l;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((b[0]), bvec4(true, false, false, false)) && allOk;
	allOk = compare_ivec4((c[0]), ivec4(6, -7, 3, -8)) && allOk;
	allOk = compare_uvec4((f), uvec4(4u, 2u, 4u, 9u)) && allOk;
	allOk = compare_float((h[0]), 7.0) && allOk;
	allOk = compare_uvec4((j), uvec4(7u, 3u, 1u, 0u)) && allOk;
	allOk = compare_bvec3((k), bvec3(true, false, true)) && allOk;
	allOk = compare_vec3((l), vec3(0.0, -8.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (1u);
	b[0] = (bvec4(true, false, false, false));
	c[0] = (ivec4(7, -9, -2, 5));
	d = (vec2(-9.0, 2.0));
	e = (vec3(6.0, -1.0, 9.0));
	f = (uvec4(8u, 7u, 5u, 9u));
	g = (ivec3(2, -3, -6));
	h[0] = (0.0);
	i = (bvec3(false, true, false));
	j = (uvec4(5u, 2u, 1u, 3u));
	l = (vec3(-7.0, 6.0, 6.0));
}
#version 450
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
	lowp uint c;
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	int16_t d;
	uint16_t e;
	float16_t f;
	bool g;
};
layout(std140, binding = 3) buffer BlockD
{
	uint16_t h;
	mediump uint i;
	int16_t j[1];
	highp int k;
	mediump float l;
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
	allOk = compare_float((blockB.b), -6.0) && allOk;
	allOk = compare_uint((blockB.c), 0u) && allOk;
	allOk = compare_int16_t(int(d), -1) && allOk;
	allOk = compare_uint16_t(uint(e), 5u) && allOk;
	allOk = compare_uint16_t(uint(h), 6u) && allOk;
	allOk = compare_uint((i), 9u) && allOk;
	allOk = compare_float((l), -8.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
	blockB.c = (8u);
	d = int16_t(-3);
	e = uint16_t(4u);
	f = float16_t(-8.0);
	i = (5u);
	j[0] = int16_t(6);
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

layout(std140, binding = 1) buffer BlockB
{
	float16_t a[1];
	float16_t b;
	int16_t c;
} blockB;
layout(std430, binding = 2) readonly buffer BlockC
{
	highp float d;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockB.a[0]), 1.0) && allOk;
	allOk = compare_float16_t(float(blockB.b), -6.0) && allOk;
	allOk = compare_int16_t(int(blockB.c), -5) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = float16_t(7.0);
}
#version 450
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
	u16vec2 a;
	highp mat4x3 b;
	highp mat4x3 c;
};
layout(std430, column_major, binding = 2) buffer BlockC
{
	highp ivec4 d;
	lowp ivec3 e[7];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(a), uvec2(6u, 7u)) && allOk;
	allOk = compare_mat4x3(b, mat4x3(-6.0, 6.0, -6.0, -2.0, 3.0, -4.0, -1.0, 2.0, -6.0, -2.0, 3.0, -3.0)) && allOk;
	allOk = compare_ivec3((e[0]), ivec3(-9, -4, 3)) && allOk;
	allOk = compare_ivec3((e[1]), ivec3(0, -2, -5)) && allOk;
	allOk = compare_ivec3((e[2]), ivec3(0, 1, -8)) && allOk;
	allOk = compare_ivec3((e[3]), ivec3(1, -1, 0)) && allOk;
	allOk = compare_ivec3((e[4]), ivec3(-2, 5, -4)) && allOk;
	allOk = compare_ivec3((e[5]), ivec3(-6, 7, 0)) && allOk;
	allOk = compare_ivec3((e[6]), ivec3(3, 4, -7)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (mat4x3(5.0, -7.0, 0.0, 1.0, 9.0, -8.0, -7.0, -9.0, -9.0, -3.0, 8.0, 5.0));
	c = (mat4x3(4.0, -6.0, -9.0, -2.0, 3.0, 3.0, -5.0, -5.0, -9.0, 5.0, 0.0, -1.0));
	d = (ivec4(6, 2, 7, -1));
}
#version 450
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
	bvec2 a;
	mediump vec4 b[4];
	highp vec3 c;
	lowp vec2 d;
	lowp mat4 e[];
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	mediump uint f;
	lowp mat4x2 g;
	highp ivec2 h;
	mediump vec2 i[];
};
layout(std430, column_major, binding = 3) buffer BlockD
{
	bvec3 j;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a), bvec2(true, false)) && allOk;
	allOk = compare_vec4((blockB.b[0]), vec4(6.0, 7.0, 5.0, -6.0)) && allOk;
	allOk = compare_vec4((blockB.b[1]), vec4(1.0, 9.0, -4.0, -3.0)) && allOk;
	allOk = compare_vec4((blockB.b[2]), vec4(4.0, 4.0, 9.0, -9.0)) && allOk;
	allOk = compare_vec4((blockB.b[3]), vec4(-8.0, -9.0, 8.0, 0.0)) && allOk;
	allOk = compare_vec3((blockB.c), vec3(4.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat4(blockB.e[0], mat4(7.0, -5.0, -4.0, 3.0, -5.0, -3.0, -1.0, 1.0, 0.0, -3.0, 1.0, 3.0, -9.0, -4.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4(blockB.e[1], mat4(1.0, 3.0, -9.0, -5.0, 9.0, -7.0, -8.0, 1.0, 6.0, 0.0, -3.0, 4.0, -7.0, -1.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat4(blockB.e[2], mat4(0.0, -8.0, 1.0, -9.0, -9.0, -9.0, -7.0, 7.0, -2.0, 2.0, -4.0, 4.0, -8.0, 4.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat4(blockB.e[3], mat4(-7.0, -8.0, -5.0, 0.0, 1.0, -4.0, -9.0, 2.0, -4.0, -5.0, 1.0, 5.0, 4.0, -7.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat4(blockB.e[4], mat4(0.0, -7.0, -8.0, -7.0, -3.0, 3.0, 2.0, -8.0, -1.0, -7.0, 0.0, 6.0, -5.0, 4.0, -3.0, 7.0)) && allOk;
	allOk = compare_ivec2((h), ivec2(8, 8)) && allOk;
	allOk = compare_vec2((i[0]), vec2(-5.0, 4.0)) && allOk;
	allOk = compare_vec2((i[1]), vec2(9.0, -1.0)) && allOk;
	allOk = compare_vec2((i[2]), vec2(-4.0, 2.0)) && allOk;
	allOk = compare_bvec3((blockD.j), bvec3(false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (vec4(-7.0, 6.0, -7.0, 6.0));
	blockB.b[1] = (vec4(-8.0, -4.0, -6.0, 3.0));
	blockB.b[2] = (vec4(-2.0, 5.0, -2.0, 6.0));
	blockB.b[3] = (vec4(7.0, -5.0, -5.0, -2.0));
	blockB.c = (vec3(-2.0, 7.0, -2.0));
	blockB.e[0] = (mat4(-9.0, -2.0, -7.0, 9.0, -9.0, 4.0, -1.0, 8.0, 4.0, -4.0, 0.0, 7.0, 6.0, 5.0, 3.0, 3.0));
	blockB.e[1] = (mat4(-4.0, -6.0, 4.0, 2.0, -6.0, 7.0, -8.0, 5.0, 6.0, 8.0, 9.0, 0.0, -7.0, -6.0, -3.0, 8.0));
	blockB.e[2] = (mat4(1.0, -3.0, 0.0, 7.0, -5.0, -5.0, 7.0, 8.0, -6.0, 1.0, 8.0, -5.0, 4.0, 8.0, 5.0, -5.0));
	blockB.e[3] = (mat4(-7.0, -3.0, -6.0, 4.0, -9.0, 5.0, 1.0, -9.0, 6.0, -7.0, -8.0, -2.0, 6.0, 4.0, -3.0, 4.0));
	blockB.e[4] = (mat4(9.0, -8.0, -8.0, 5.0, -9.0, -3.0, -3.0, -3.0, -1.0, -6.0, 6.0, 4.0, -3.0, 8.0, 5.0, -7.0));
	f = (3u);
	g = (mat4x2(0.0, -8.0, -5.0, -7.0, -7.0, -7.0, 4.0, -5.0));
	h = (ivec2(-3, -7));
	i[0] = (vec2(-5.0, 3.0));
	i[1] = (vec2(-1.0, -5.0));
	i[2] = (vec2(-9.0, -2.0));
	blockD.j = (bvec3(true, false, true));
}
#version 450
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
layout(std430, column_major, binding = 1) buffer BlockB
{
	uint16_t a;
	mediump vec4 b;
	sA c;
	mediump ivec4 d[];
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	bvec3 e;
	mediump ivec3 f;
	highp mat4x2 g[];
};
layout(std430, row_major, binding = 3) buffer BlockD
{
	f16vec2 h;
	bvec2 i;
	highp vec4 j[4];
} blockD;
layout(std430, column_major, binding = 4) buffer BlockE
{
	mediump uint k;
	mediump uint l;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((b), vec4(-9.0, -7.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat3(c.mA, mat3(0.0, -3.0, 9.0, -2.0, 0.0, 3.0, -3.0, 2.0, -3.0)) && allOk;
	allOk = compare_uvec4((c.mB), uvec4(4u, 7u, 4u, 6u)) && allOk;
	allOk = compare_vec3((c.mC), vec3(5.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(c.mD, mat3x2(-9.0, 5.0, -9.0, 7.0, 4.0, 6.0)) && allOk;
	allOk = compare_bvec3((e), bvec3(false, false, false)) && allOk;
	allOk = compare_mat4x2(g[0], mat4x2(7.0, -2.0, -8.0, -1.0, -7.0, 6.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat4x2(g[1], mat4x2(-1.0, 6.0, -7.0, 1.0, -2.0, 5.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(g[2], mat4x2(-2.0, -3.0, 8.0, 4.0, -5.0, 2.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat4x2(g[3], mat4x2(5.0, 1.0, -9.0, 8.0, 5.0, 1.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(g[4], mat4x2(-9.0, 4.0, -4.0, -8.0, -3.0, -4.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat4x2(g[5], mat4x2(-5.0, -6.0, 6.0, 8.0, -2.0, -2.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat4x2(g[6], mat4x2(-1.0, 6.0, 7.0, -2.0, -9.0, -7.0, -3.0, 4.0)) && allOk;
	allOk = compare_vec4((blockD.j[0]), vec4(-8.0, -3.0, -2.0, 4.0)) && allOk;
	allOk = compare_vec4((blockD.j[1]), vec4(3.0, 1.0, -2.0, 7.0)) && allOk;
	allOk = compare_vec4((blockD.j[2]), vec4(-8.0, 8.0, 1.0, 0.0)) && allOk;
	allOk = compare_vec4((blockD.j[3]), vec4(-9.0, 6.0, -6.0, 7.0)) && allOk;
	allOk = compare_uint((blockE.k), 0u) && allOk;
	allOk = compare_uint((blockE.l), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	a = uint16_t(7u);
	b = (vec4(4.0, -4.0, -7.0, -3.0));
	c.mA = (mat3(-9.0, 1.0, 2.0, 8.0, -2.0, 5.0, -7.0, -5.0, -9.0));
	c.mB = (uvec4(9u, 5u, 2u, 7u));
	c.mC = (vec3(2.0, -4.0, -6.0));
	c.mD = (mat3x2(7.0, 1.0, 9.0, 1.0, 3.0, 9.0));
	d[0] = (ivec4(6, 4, -5, -6));
	d[1] = (ivec4(2, 8, 0, 6));
	d[2] = (ivec4(5, 6, -3, -8));
	d[3] = (ivec4(8, -8, -6, -5));
	d[4] = (ivec4(0, 0, 2, -1));
	d[5] = (ivec4(-4, -3, 0, 5));
	d[6] = (ivec4(-3, 7, 4, 0));
	d[7] = (ivec4(-3, -8, -4, -1));
	e = (bvec3(true, true, false));
	f = (ivec3(1, -2, -8));
	g[0] = (mat4x2(3.0, -7.0, -7.0, 1.0, -4.0, -7.0, 3.0, -5.0));
	g[1] = (mat4x2(5.0, -6.0, -5.0, -3.0, -6.0, 2.0, -6.0, 9.0));
	g[2] = (mat4x2(-3.0, 6.0, -7.0, -1.0, -9.0, 6.0, 8.0, -9.0));
	g[3] = (mat4x2(0.0, -2.0, 8.0, -4.0, -1.0, 2.0, 0.0, 9.0));
	g[4] = (mat4x2(6.0, -5.0, -2.0, -2.0, 6.0, 0.0, -4.0, -2.0));
	g[5] = (mat4x2(-4.0, 7.0, 8.0, -3.0, 8.0, -5.0, 9.0, -7.0));
	g[6] = (mat4x2(-8.0, 6.0, -8.0, -6.0, 1.0, -4.0, 6.0, -7.0));
	blockD.h = f16vec2(vec2(-9.0, -2.0));
	blockD.i = (bvec2(false, false));
	blockE.l = (3u);
}
#version 450
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
};
struct sB
{
	bvec3 mA;
	sA mB;
	i16vec2 mC[3][2];
};
struct sC
{
	f16vec2 mA;
	lowp vec3 mB;
	lowp mat4x2 mC;
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	sB a;
	bvec2 b[];
};
layout(std140, binding = 2) buffer BlockC
{
	u16vec2 c;
	highp mat4x3 d;
	sC e[];
};
layout(std140, column_major, binding = 3) buffer BlockD
{
	lowp int f[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((a.mA), bvec3(true, false, false)) && allOk;
	allOk = compare_uint((a.mB.mA), 9u) && allOk;
	allOk = compare_i16vec2(ivec2(a.mC[0][0]), ivec2(-5, -4)) && allOk;
	allOk = compare_i16vec2(ivec2(a.mC[0][1]), ivec2(-5, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(a.mC[1][0]), ivec2(-2, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(a.mC[1][1]), ivec2(6, -6)) && allOk;
	allOk = compare_i16vec2(ivec2(a.mC[2][0]), ivec2(9, -2)) && allOk;
	allOk = compare_i16vec2(ivec2(a.mC[2][1]), ivec2(5, -6)) && allOk;
	allOk = compare_bvec2((b[0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((b[1]), bvec2(false, false)) && allOk;
	allOk = compare_u16vec2(uvec2(c), uvec2(6u, 1u)) && allOk;
	allOk = compare_mat4x3(d, mat4x3(8.0, 8.0, 0.0, 1.0, 4.0, -9.0, 9.0, 7.0, 2.0, -8.0, 7.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b[0] = (bvec2(true, true));
	b[1] = (bvec2(false, true));
	c = u16vec2(uvec2(6u, 3u));
	d = (mat4x3(-2.0, -5.0, -9.0, -7.0, 0.0, 7.0, -2.0, 9.0, -6.0, 8.0, 5.0, 3.0));
	e[0].mA = f16vec2(vec2(-3.0, 6.0));
	e[0].mB = (vec3(-2.0, -3.0, 8.0));
	e[0].mC = (mat4x2(4.0, -4.0, -8.0, 1.0, -6.0, 7.0, -7.0, 7.0));
	e[1].mA = f16vec2(vec2(-2.0, 2.0));
	e[1].mB = (vec3(2.0, -1.0, -8.0));
	e[1].mC = (mat4x2(-2.0, 2.0, 2.0, 4.0, -9.0, 9.0, -2.0, -4.0));
	e[2].mA = f16vec2(vec2(-5.0, 5.0));
	e[2].mB = (vec3(9.0, -7.0, 5.0));
	e[2].mC = (mat4x2(-3.0, 7.0, 8.0, -4.0, -5.0, -8.0, -1.0, -1.0));
	e[3].mA = f16vec2(vec2(5.0, 3.0));
	e[3].mB = (vec3(1.0, 3.0, 6.0));
	e[3].mC = (mat4x2(-9.0, -8.0, 1.0, 9.0, -2.0, 2.0, 1.0, 2.0));
	e[4].mA = f16vec2(vec2(8.0, 5.0));
	e[4].mB = (vec3(-8.0, -8.0, -6.0));
	e[4].mC = (mat4x2(-8.0, 0.0, 6.0, -1.0, 1.0, -3.0, 7.0, -9.0));
	e[5].mA = f16vec2(vec2(5.0, 3.0));
	e[5].mB = (vec3(7.0, 6.0, -5.0));
	e[5].mC = (mat4x2(3.0, -1.0, 0.0, 8.0, -9.0, -5.0, 5.0, 1.0));
	e[6].mA = f16vec2(vec2(6.0, 5.0));
	e[6].mB = (vec3(7.0, 6.0, -6.0));
	e[6].mC = (mat4x2(-1.0, -9.0, -5.0, -1.0, 2.0, -4.0, -1.0, -8.0));
	e[7].mA = f16vec2(vec2(1.0, 1.0));
	e[7].mB = (vec3(0.0, 7.0, -7.0));
	e[7].mC = (mat4x2(-3.0, 3.0, 3.0, 8.0, 2.0, -9.0, -2.0, -3.0));
	blockD.f[0] = (4);
	blockD.f[1] = (-7);
}
#version 450
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
	i16vec4 mB;
};
layout(std430, row_major, binding = 1) buffer BlockB
{
	mediump mat4x3 a[];
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	lowp uvec2 b;
	u16vec2 c[1];
	sA d;
	f16vec4 e[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((b), uvec2(9u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(c[0]), uvec2(2u, 6u)) && allOk;
	allOk = compare_f16vec4(vec4(e[0]), vec4(-8.0, 7.0, -3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat4x3(5.0, -5.0, -9.0, -5.0, -5.0, 2.0, 3.0, 0.0, -4.0, 9.0, -1.0, -8.0));
	b = (uvec2(7u, 8u));
	c[0] = u16vec2(uvec2(3u, 0u));
}
#version 450
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
	lowp mat3x2 a[2][6][6];
	bvec2 b;
	f16vec4 c;
	int16_t d;
	i16vec2 e[];
} blockB;
layout(std140, row_major, binding = 2) buffer BlockC
{
	bool f[];
} blockC[1];
layout(std140, column_major, binding = 3) buffer BlockD
{
	mediump ivec2 g;
	mediump mat2 h[4];
	int16_t i;
	i16vec4 j[5];
	bool k;
} blockD[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.a[0][0][0], mat3x2(2.0, -3.0, 2.0, -4.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[0][0][1], mat3x2(-2.0, -5.0, -3.0, -3.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[0][0][2], mat3x2(8.0, 7.0, 3.0, 3.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[0][0][3], mat3x2(-7.0, -9.0, -3.0, 4.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[0][0][4], mat3x2(-7.0, -1.0, 9.0, -6.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[0][0][5], mat3x2(4.0, 1.0, -6.0, -2.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[0][1][0], mat3x2(-2.0, -9.0, -7.0, -2.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[0][1][1], mat3x2(-9.0, 6.0, 9.0, -7.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[0][1][2], mat3x2(9.0, -3.0, -4.0, -8.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[0][1][3], mat3x2(6.0, -3.0, 7.0, 7.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[0][1][4], mat3x2(-9.0, 3.0, -2.0, 0.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[0][1][5], mat3x2(-6.0, -2.0, 8.0, -9.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[0][2][0], mat3x2(1.0, -5.0, -2.0, 7.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[0][2][1], mat3x2(2.0, 9.0, -2.0, -6.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[0][2][2], mat3x2(-6.0, -6.0, 0.0, 1.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[0][2][3], mat3x2(5.0, 8.0, -3.0, 3.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[0][2][4], mat3x2(7.0, -4.0, 4.0, 7.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[0][2][5], mat3x2(5.0, 3.0, 7.0, 3.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[0][3][0], mat3x2(6.0, -4.0, 6.0, -2.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[0][3][1], mat3x2(3.0, -2.0, 3.0, 4.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[0][3][2], mat3x2(8.0, 5.0, -2.0, 0.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[0][3][3], mat3x2(-1.0, -1.0, 9.0, -8.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[0][3][4], mat3x2(8.0, 1.0, 2.0, 6.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[0][3][5], mat3x2(-3.0, 1.0, -1.0, -4.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[0][4][0], mat3x2(3.0, -7.0, 7.0, -9.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[0][4][1], mat3x2(-9.0, 1.0, -5.0, -7.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[0][4][2], mat3x2(2.0, -8.0, -8.0, 0.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[0][4][3], mat3x2(5.0, 8.0, -7.0, -3.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[0][4][4], mat3x2(-5.0, -6.0, 8.0, -8.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[0][4][5], mat3x2(-9.0, 6.0, 4.0, 3.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[0][5][0], mat3x2(-9.0, 9.0, 5.0, -1.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[0][5][1], mat3x2(-9.0, 7.0, 9.0, -3.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[0][5][2], mat3x2(9.0, -4.0, -1.0, -4.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[0][5][3], mat3x2(-5.0, -5.0, -3.0, 1.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[0][5][4], mat3x2(-6.0, 7.0, -7.0, 1.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[0][5][5], mat3x2(5.0, -9.0, -1.0, 6.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[1][0][0], mat3x2(4.0, 3.0, 0.0, 6.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[1][0][1], mat3x2(-3.0, -6.0, 1.0, 7.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[1][0][2], mat3x2(-9.0, 2.0, 9.0, 7.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[1][0][3], mat3x2(2.0, 0.0, -1.0, 1.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[1][0][4], mat3x2(9.0, -2.0, -1.0, -4.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[1][0][5], mat3x2(6.0, -5.0, -2.0, -7.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[1][1][0], mat3x2(7.0, 4.0, 7.0, 9.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[1][1][1], mat3x2(2.0, 3.0, 1.0, 6.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[1][1][2], mat3x2(-3.0, 5.0, 0.0, -8.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[1][1][3], mat3x2(1.0, -3.0, 9.0, -6.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[1][1][4], mat3x2(2.0, 6.0, -6.0, 9.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[1][1][5], mat3x2(-4.0, -3.0, 5.0, 3.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[1][2][0], mat3x2(0.0, -4.0, 8.0, -8.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[1][2][1], mat3x2(-4.0, -4.0, 9.0, -5.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[1][2][2], mat3x2(-8.0, 9.0, 8.0, 0.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[1][2][3], mat3x2(-1.0, 1.0, 0.0, -7.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[1][2][4], mat3x2(3.0, -9.0, 1.0, 5.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[1][2][5], mat3x2(-7.0, 3.0, 8.0, -5.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[1][3][0], mat3x2(-6.0, -3.0, 8.0, -6.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[1][3][1], mat3x2(4.0, -5.0, 7.0, -9.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[1][3][2], mat3x2(-1.0, -4.0, 6.0, -6.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[1][3][3], mat3x2(-2.0, 6.0, -1.0, 4.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[1][3][4], mat3x2(5.0, -8.0, 6.0, -4.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[1][3][5], mat3x2(0.0, 3.0, -6.0, -6.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[1][4][0], mat3x2(-6.0, -9.0, -5.0, -4.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[1][4][1], mat3x2(7.0, -8.0, -7.0, 4.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[1][4][2], mat3x2(4.0, -8.0, 8.0, 7.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[1][4][3], mat3x2(7.0, -3.0, 3.0, -3.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[1][4][4], mat3x2(5.0, -4.0, -1.0, -6.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[1][4][5], mat3x2(1.0, 8.0, 3.0, -6.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[1][5][0], mat3x2(-1.0, -7.0, 4.0, -6.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[1][5][1], mat3x2(-3.0, -3.0, 2.0, 0.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[1][5][2], mat3x2(-5.0, 8.0, -6.0, 2.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[1][5][3], mat3x2(-4.0, -5.0, 9.0, -5.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[1][5][4], mat3x2(7.0, 5.0, 7.0, 6.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[1][5][5], mat3x2(8.0, -3.0, 0.0, 0.0, 2.0, 0.0)) && allOk;
	allOk = compare_bvec2((blockB.b), bvec2(true, true)) && allOk;
	allOk = compare_int16_t(int(blockB.d), -1) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.e[0]), ivec2(4, 8)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.e[1]), ivec2(-7, -9)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.e[2]), ivec2(-3, -2)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.e[3]), ivec2(5, -2)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.e[4]), ivec2(-3, -5)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.e[5]), ivec2(-6, -6)) && allOk;
	allOk = compare_bool((blockC[0].f[0]), false) && allOk;
	allOk = compare_bool((blockC[0].f[1]), false) && allOk;
	allOk = compare_ivec2((blockD[0].g), ivec2(7, 6)) && allOk;
	allOk = compare_mat2(blockD[0].h[0], mat2(7.0, -4.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2(blockD[0].h[1], mat2(2.0, 5.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat2(blockD[0].h[2], mat2(-4.0, 6.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(blockD[0].h[3], mat2(-1.0, 6.0, -2.0, 8.0)) && allOk;
	allOk = compare_int16_t(int(blockD[0].i), 6) && allOk;
	allOk = compare_i16vec4(ivec4(blockD[0].j[0]), ivec4(1, -2, -5, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD[0].j[1]), ivec4(6, -6, 0, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD[0].j[2]), ivec4(1, 2, -9, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD[0].j[3]), ivec4(-4, 9, -6, -5)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD[0].j[4]), ivec4(-9, 2, 4, 6)) && allOk;
	allOk = compare_bool((blockD[0].k), false) && allOk;
	allOk = compare_ivec2((blockD[1].g), ivec2(-1, -7)) && allOk;
	allOk = compare_mat2(blockD[1].h[0], mat2(8.0, 5.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2(blockD[1].h[1], mat2(0.0, -9.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(blockD[1].h[2], mat2(2.0, 2.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat2(blockD[1].h[3], mat2(4.0, 5.0, -9.0, 3.0)) && allOk;
	allOk = compare_int16_t(int(blockD[1].i), 0) && allOk;
	allOk = compare_i16vec4(ivec4(blockD[1].j[0]), ivec4(6, -9, -5, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD[1].j[1]), ivec4(-7, 4, -7, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD[1].j[2]), ivec4(-4, 3, -7, -8)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD[1].j[3]), ivec4(-8, 9, 8, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD[1].j[4]), ivec4(3, 3, -7, 0)) && allOk;
	allOk = compare_bool((blockD[1].k), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0][0][0] = (mat3x2(8.0, 7.0, -2.0, 6.0, 0.0, 5.0));
	blockB.a[0][0][1] = (mat3x2(9.0, -5.0, 4.0, 7.0, -1.0, 6.0));
	blockB.a[0][0][2] = (mat3x2(5.0, 8.0, 6.0, 2.0, -7.0, -2.0));
	blockB.a[0][0][3] = (mat3x2(-4.0, -2.0, 4.0, -2.0, 3.0, 0.0));
	blockB.a[0][0][4] = (mat3x2(-8.0, 6.0, -7.0, 4.0, 6.0, -2.0));
	blockB.a[0][0][5] = (mat3x2(-5.0, 3.0, 0.0, 9.0, -2.0, 3.0));
	blockB.a[0][1][0] = (mat3x2(-4.0, 2.0, -8.0, -6.0, 2.0, -5.0));
	blockB.a[0][1][1] = (mat3x2(-6.0, -3.0, -2.0, 7.0, -4.0, -1.0));
	blockB.a[0][1][2] = (mat3x2(-5.0, -8.0, 5.0, 8.0, -8.0, -5.0));
	blockB.a[0][1][3] = (mat3x2(2.0, -9.0, -3.0, -9.0, -2.0, 5.0));
	blockB.a[0][1][4] = (mat3x2(4.0, 2.0, -8.0, -8.0, 2.0, 2.0));
	blockB.a[0][1][5] = (mat3x2(6.0, 5.0, 2.0, -4.0, -9.0, -7.0));
	blockB.a[0][2][0] = (mat3x2(7.0, 8.0, 7.0, 6.0, 9.0, -9.0));
	blockB.a[0][2][1] = (mat3x2(7.0, -9.0, -3.0, 4.0, -2.0, 6.0));
	blockB.a[0][2][2] = (mat3x2(-1.0, 8.0, -9.0, 5.0, -9.0, 5.0));
	blockB.a[0][2][3] = (mat3x2(-5.0, -7.0, -2.0, -7.0, -1.0, -3.0));
	blockB.a[0][2][4] = (mat3x2(-4.0, -3.0, -7.0, -3.0, 7.0, 7.0));
	blockB.a[0][2][5] = (mat3x2(-1.0, 9.0, -1.0, -3.0, 8.0, 9.0));
	blockB.a[0][3][0] = (mat3x2(-6.0, -3.0, -4.0, 5.0, -8.0, 6.0));
	blockB.a[0][3][1] = (mat3x2(-2.0, 4.0, 9.0, -7.0, 4.0, -6.0));
	blockB.a[0][3][2] = (mat3x2(-4.0, -5.0, 3.0, -8.0, 8.0, 9.0));
	blockB.a[0][3][3] = (mat3x2(6.0, 7.0, 5.0, -3.0, 7.0, -7.0));
	blockB.a[0][3][4] = (mat3x2(7.0, 2.0, -6.0, 1.0, 0.0, 9.0));
	blockB.a[0][3][5] = (mat3x2(6.0, 1.0, 5.0, -2.0, 4.0, 4.0));
	blockB.a[0][4][0] = (mat3x2(2.0, -6.0, 7.0, 3.0, -7.0, 7.0));
	blockB.a[0][4][1] = (mat3x2(2.0, 7.0, 8.0, -6.0, 2.0, 6.0));
	blockB.a[0][4][2] = (mat3x2(3.0, -8.0, 9.0, 2.0, -5.0, -1.0));
	blockB.a[0][4][3] = (mat3x2(-4.0, 1.0, 9.0, 0.0, -1.0, 0.0));
	blockB.a[0][4][4] = (mat3x2(9.0, 1.0, 2.0, 5.0, 5.0, 2.0));
	blockB.a[0][4][5] = (mat3x2(8.0, -9.0, 3.0, 9.0, -2.0, 2.0));
	blockB.a[0][5][0] = (mat3x2(7.0, -3.0, 5.0, -8.0, -2.0, -1.0));
	blockB.a[0][5][1] = (mat3x2(1.0, 2.0, -4.0, 5.0, 0.0, 6.0));
	blockB.a[0][5][2] = (mat3x2(5.0, -7.0, -7.0, -7.0, -2.0, 4.0));
	blockB.a[0][5][3] = (mat3x2(9.0, -9.0, -7.0, 4.0, 7.0, -3.0));
	blockB.a[0][5][4] = (mat3x2(8.0, -8.0, 9.0, 6.0, -1.0, -6.0));
	blockB.a[0][5][5] = (mat3x2(-6.0, -9.0, -6.0, 5.0, 6.0, 5.0));
	blockB.a[1][0][0] = (mat3x2(-3.0, 3.0, 2.0, 2.0, -6.0, -8.0));
	blockB.a[1][0][1] = (mat3x2(-6.0, 4.0, -7.0, -9.0, 7.0, -3.0));
	blockB.a[1][0][2] = (mat3x2(-1.0, -2.0, -4.0, 3.0, -1.0, 4.0));
	blockB.a[1][0][3] = (mat3x2(-2.0, 9.0, -2.0, 8.0, -5.0, -8.0));
	blockB.a[1][0][4] = (mat3x2(9.0, 2.0, -2.0, -2.0, 7.0, 3.0));
	blockB.a[1][0][5] = (mat3x2(7.0, 3.0, -1.0, -2.0, 1.0, 2.0));
	blockB.a[1][1][0] = (mat3x2(4.0, 0.0, 6.0, -6.0, 0.0, 5.0));
	blockB.a[1][1][1] = (mat3x2(-3.0, 3.0, -2.0, -9.0, -5.0, -3.0));
	blockB.a[1][1][2] = (mat3x2(-9.0, 7.0, 9.0, 8.0, 2.0, 9.0));
	blockB.a[1][1][3] = (mat3x2(7.0, -2.0, -3.0, -2.0, -5.0, 8.0));
	blockB.a[1][1][4] = (mat3x2(-4.0, -3.0, -6.0, -1.0, -2.0, -3.0));
	blockB.a[1][1][5] = (mat3x2(8.0, 1.0, -5.0, -4.0, -8.0, 1.0));
	blockB.a[1][2][0] = (mat3x2(-5.0, 1.0, -9.0, -7.0, 6.0, 2.0));
	blockB.a[1][2][1] = (mat3x2(-4.0, -4.0, -2.0, -6.0, 3.0, -9.0));
	blockB.a[1][2][2] = (mat3x2(-5.0, 9.0, -3.0, 3.0, -1.0, -7.0));
	blockB.a[1][2][3] = (mat3x2(-1.0, 7.0, -7.0, -3.0, 8.0, -1.0));
	blockB.a[1][2][4] = (mat3x2(9.0, -3.0, 8.0, 1.0, 0.0, 6.0));
	blockB.a[1][2][5] = (mat3x2(9.0, 7.0, 0.0, -5.0, 1.0, -8.0));
	blockB.a[1][3][0] = (mat3x2(-9.0, -9.0, 8.0, -9.0, 1.0, -1.0));
	blockB.a[1][3][1] = (mat3x2(2.0, 6.0, 8.0, 4.0, -9.0, -9.0));
	blockB.a[1][3][2] = (mat3x2(2.0, 8.0, -8.0, 3.0, 7.0, -6.0));
	blockB.a[1][3][3] = (mat3x2(-8.0, -5.0, 4.0, 1.0, -6.0, -1.0));
	blockB.a[1][3][4] = (mat3x2(-8.0, -5.0, 0.0, 2.0, -2.0, -1.0));
	blockB.a[1][3][5] = (mat3x2(-1.0, -4.0, -3.0, -3.0, 4.0, 8.0));
	blockB.a[1][4][0] = (mat3x2(6.0, -9.0, -3.0, -3.0, -5.0, 9.0));
	blockB.a[1][4][1] = (mat3x2(-1.0, 0.0, 0.0, 1.0, 6.0, 4.0));
	blockB.a[1][4][2] = (mat3x2(-6.0, 1.0, 7.0, 1.0, -6.0, -8.0));
	blockB.a[1][4][3] = (mat3x2(7.0, -5.0, 7.0, 0.0, 0.0, -1.0));
	blockB.a[1][4][4] = (mat3x2(-2.0, -8.0, 2.0, 0.0, 3.0, -1.0));
	blockB.a[1][4][5] = (mat3x2(7.0, 9.0, 4.0, 4.0, 1.0, -1.0));
	blockB.a[1][5][0] = (mat3x2(2.0, -8.0, 6.0, 0.0, -8.0, -3.0));
	blockB.a[1][5][1] = (mat3x2(-5.0, 2.0, 8.0, -8.0, 9.0, 5.0));
	blockB.a[1][5][2] = (mat3x2(3.0, -4.0, -9.0, -4.0, -3.0, -1.0));
	blockB.a[1][5][3] = (mat3x2(-6.0, 1.0, -1.0, 2.0, 8.0, 1.0));
	blockB.a[1][5][4] = (mat3x2(9.0, -5.0, -9.0, -3.0, 7.0, -3.0));
	blockB.a[1][5][5] = (mat3x2(2.0, -2.0, 9.0, 7.0, -4.0, 2.0));
	blockB.b = (bvec2(true, false));
	blockB.c = f16vec4(vec4(9.0, 2.0, 7.0, -8.0));
	blockB.e[0] = i16vec2(ivec2(-4, 7));
	blockB.e[1] = i16vec2(ivec2(-3, 5));
	blockB.e[2] = i16vec2(ivec2(6, -7));
	blockB.e[3] = i16vec2(ivec2(-7, -7));
	blockB.e[4] = i16vec2(ivec2(-1, -1));
	blockB.e[5] = i16vec2(ivec2(-9, 5));
	blockC[0].f[0] = (true);
	blockC[0].f[1] = (true);
	blockD[0].g = (ivec2(9, -9));
	blockD[0].i = int16_t(-8);
	blockD[0].j[0] = i16vec4(ivec4(-8, -3, -3, 0));
	blockD[0].j[1] = i16vec4(ivec4(6, -1, -1, -9));
	blockD[0].j[2] = i16vec4(ivec4(-8, -4, -1, -8));
	blockD[0].j[3] = i16vec4(ivec4(-3, 3, 0, -4));
	blockD[0].j[4] = i16vec4(ivec4(7, -8, -7, 8));
	blockD[0].k = (false);
	blockD[1].g = (ivec2(-5, -2));
	blockD[1].i = int16_t(8);
	blockD[1].j[0] = i16vec4(ivec4(9, 4, -4, 5));
	blockD[1].j[1] = i16vec4(ivec4(-3, -9, 7, 0));
	blockD[1].j[2] = i16vec4(ivec4(6, -8, -9, 9));
	blockD[1].j[3] = i16vec4(ivec4(4, -4, 0, -6));
	blockD[1].j[4] = i16vec4(ivec4(-8, -8, 9, -3));
	blockD[1].k = (false);
}
#version 450
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
	float16_t mB;
};
layout(std430, binding = 1) buffer BlockB
{
	mediump mat3x2 a;
	mediump mat4x3 b;
	i16vec3 c[6];
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	i16vec4 d;
	float16_t e;
	f16vec4 f;
	mediump ivec3 g[];
} blockC[3];
layout(std430, column_major, binding = 3) buffer BlockD
{
	lowp ivec4 h;
	lowp mat2 i;
	float16_t j;
	highp mat3x4 k[];
} blockD[1];
layout(std140, row_major, binding = 4) buffer BlockE
{
	u16vec4 l;
	sA m;
	u16vec2 n;
	bvec4 o;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(a, mat3x2(0.0, 6.0, 5.0, 9.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat4x3(b, mat4x3(-8.0, 2.0, 1.0, -9.0, 4.0, -4.0, -2.0, 7.0, 2.0, -4.0, 7.0, 1.0)) && allOk;
	allOk = compare_float16_t(float(blockC[0].e), 8.0) && allOk;
	allOk = compare_f16vec4(vec4(blockC[0].f), vec4(-8.0, -3.0, -7.0, -9.0)) && allOk;
	allOk = compare_float16_t(float(blockC[1].e), 9.0) && allOk;
	allOk = compare_f16vec4(vec4(blockC[1].f), vec4(2.0, -9.0, -5.0, -2.0)) && allOk;
	allOk = compare_float16_t(float(blockC[2].e), 2.0) && allOk;
	allOk = compare_f16vec4(vec4(blockC[2].f), vec4(0.0, 9.0, -9.0, -5.0)) && allOk;
	allOk = compare_ivec4((blockD[0].h), ivec4(0, 0, 1, -8)) && allOk;
	allOk = compare_mat2(blockD[0].i, mat2(-3.0, -9.0, 9.0, -3.0)) && allOk;
	allOk = compare_float16_t(float(blockD[0].j), -8.0) && allOk;
	allOk = compare_mat3x4(blockD[0].k[0], mat3x4(6.0, -6.0, 1.0, 7.0, -7.0, -8.0, 4.0, -7.0, -4.0, -7.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].k[1], mat3x4(2.0, 8.0, 9.0, 5.0, 3.0, 4.0, -1.0, 3.0, -6.0, 9.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].k[2], mat3x4(7.0, 6.0, 4.0, -2.0, 0.0, 4.0, -1.0, 9.0, 1.0, 7.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].k[3], mat3x4(-2.0, 3.0, -9.0, 3.0, 7.0, -2.0, 6.0, 0.0, -1.0, 4.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].k[4], mat3x4(9.0, 7.0, -7.0, -3.0, 6.0, -6.0, -4.0, -5.0, -9.0, -4.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].k[5], mat3x4(-9.0, 0.0, -9.0, 2.0, -4.0, -9.0, 3.0, 0.0, -6.0, -7.0, 7.0, -3.0)) && allOk;
	allOk = compare_u16vec4(uvec4(l), uvec4(6u, 6u, 9u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	c[0] = i16vec3(ivec3(-4, 7, 1));
	c[1] = i16vec3(ivec3(-2, -2, -8));
	c[2] = i16vec3(ivec3(-2, 0, -1));
	c[3] = i16vec3(ivec3(2, 2, -6));
	c[4] = i16vec3(ivec3(6, -3, -4));
	c[5] = i16vec3(ivec3(-7, 4, 7));
	blockC[0].d = i16vec4(ivec4(1, 4, -5, -6));
	blockC[0].e = float16_t(-4.0);
	blockC[0].g[0] = (ivec3(5, -1, 7));
	blockC[0].g[1] = (ivec3(2, -2, -9));
	blockC[0].g[2] = (ivec3(-2, 1, -2));
	blockC[0].g[3] = (ivec3(-8, -2, -3));
	blockC[0].g[4] = (ivec3(-5, -1, -7));
	blockC[1].d = i16vec4(ivec4(3, -2, -1, -9));
	blockC[1].e = float16_t(-3.0);
	blockC[1].g[0] = (ivec3(-3, -7, -4));
	blockC[1].g[1] = (ivec3(8, -2, 3));
	blockC[1].g[2] = (ivec3(-2, 3, 9));
	blockC[1].g[3] = (ivec3(-9, 8, 0));
	blockC[1].g[4] = (ivec3(8, -7, -4));
	blockC[2].d = i16vec4(ivec4(4, 5, -3, 8));
	blockC[2].e = float16_t(-3.0);
	blockC[2].g[0] = (ivec3(8, -4, -1));
	blockC[2].g[1] = (ivec3(-5, 6, 5));
	blockC[2].g[2] = (ivec3(6, -1, -3));
	blockC[2].g[3] = (ivec3(-4, 0, -7));
	blockC[2].g[4] = (ivec3(0, -3, -6));
	blockC[2].g[5] = (ivec3(-6, 0, 2));
	blockD[0].h = (ivec4(0, 5, 0, 3));
	blockD[0].j = float16_t(-2.0);
	l = u16vec4(uvec4(8u, 5u, 2u, 9u));
	m.mA = (vec3(2.0, -2.0, -7.0));
	m.mB = float16_t(6.0);
	n = u16vec2(uvec2(2u, 7u));
	o = (bvec4(true, true, true, false));
}
#version 450
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
	int16_t a;
	int16_t b[];
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	mediump uvec4 c;
	f16vec4 d;
	highp mat4 e;
	u16vec2 f[];
} blockC[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(blockB.b[0]), -1) && allOk;
	allOk = compare_int16_t(int(blockB.b[1]), 1) && allOk;
	allOk = compare_int16_t(int(blockB.b[2]), 6) && allOk;
	allOk = compare_int16_t(int(blockB.b[3]), 1) && allOk;
	allOk = compare_int16_t(int(blockB.b[4]), 9) && allOk;
	allOk = compare_int16_t(int(blockB.b[5]), -6) && allOk;
	allOk = compare_int16_t(int(blockB.b[6]), -4) && allOk;
	allOk = compare_uvec4((blockC[0].c), uvec4(5u, 7u, 0u, 7u)) && allOk;
	allOk = compare_mat4(blockC[0].e, mat4(7.0, -7.0, -1.0, -1.0, -2.0, -7.0, 4.0, 6.0, -4.0, -1.0, 8.0, 3.0, 9.0, -7.0, 9.0, 7.0)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[0].f[0]), uvec2(1u, 5u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[0].f[1]), uvec2(5u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[0].f[2]), uvec2(8u, 3u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[0].f[3]), uvec2(5u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[0].f[4]), uvec2(7u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[0].f[5]), uvec2(2u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[0].f[6]), uvec2(2u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = int16_t(7);
	blockB.b[1] = int16_t(-9);
	blockB.b[2] = int16_t(-6);
	blockB.b[3] = int16_t(1);
	blockB.b[4] = int16_t(-2);
	blockB.b[5] = int16_t(-1);
	blockB.b[6] = int16_t(-3);
	blockC[0].c = (uvec4(9u, 4u, 8u, 6u));
	blockC[0].e = (mat4(1.0, 2.0, -6.0, 5.0, 9.0, 2.0, -1.0, -7.0, 3.0, -7.0, -5.0, 7.0, 5.0, 5.0, 7.0, -3.0));
	blockC[0].f[0] = u16vec2(uvec2(5u, 5u));
	blockC[0].f[1] = u16vec2(uvec2(3u, 6u));
	blockC[0].f[2] = u16vec2(uvec2(6u, 5u));
	blockC[0].f[3] = u16vec2(uvec2(7u, 8u));
	blockC[0].f[4] = u16vec2(uvec2(4u, 7u));
	blockC[0].f[5] = u16vec2(uvec2(7u, 1u));
	blockC[0].f[6] = u16vec2(uvec2(2u, 7u));
}
#version 450
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
layout(scalar, column_major, binding = 1) buffer BlockB
{
	highp uvec2 a;
	sA b;
	uint16_t c[][1];
} blockB;
layout(scalar, row_major, binding = 2) buffer BlockC
{
	u16vec3 d;
	i16vec2 e;
	bvec2 f[5];
	highp uvec3 g;
	bvec2 h;
} blockC[1];
layout(scalar, column_major, binding = 3) buffer BlockD
{
	mediump int i;
	int16_t j;
	bvec3 k[];
} blockD[3];
layout(scalar, binding = 4) readonly buffer BlockE
{
	f16vec3 l[];
} blockE[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a), uvec2(5u, 5u)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b.mA), vec4(9.0, -5.0, 0.0, 3.0)) && allOk;
	allOk = compare_bvec2((blockC[0].h), bvec2(true, false)) && allOk;
	allOk = compare_int16_t(int(blockD[0].j), 3) && allOk;
	allOk = compare_bvec3((blockD[0].k[0]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((blockD[0].k[1]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((blockD[0].k[2]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((blockD[0].k[3]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((blockD[0].k[4]), bvec3(false, true, false)) && allOk;
	allOk = compare_int16_t(int(blockD[1].j), 8) && allOk;
	allOk = compare_bvec3((blockD[1].k[0]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockD[1].k[1]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((blockD[1].k[2]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((blockD[1].k[3]), bvec3(false, true, true)) && allOk;
	allOk = compare_int16_t(int(blockD[2].j), 9) && allOk;
	allOk = compare_bvec3((blockD[2].k[0]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockD[2].k[1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((blockD[2].k[2]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockD[2].k[3]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((blockD[2].k[4]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockD[2].k[5]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockD[2].k[6]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockD[2].k[7]), bvec3(true, true, false)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[0].l[0]), vec3(-6.0, -8.0, 8.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[0].l[1]), vec3(4.0, 5.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[0].l[2]), vec3(6.0, -9.0, -8.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[0].l[3]), vec3(-9.0, 6.0, 8.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[0].l[4]), vec3(-4.0, -1.0, -5.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[0].l[5]), vec3(4.0, -3.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[0].l[6]), vec3(-3.0, 9.0, 8.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[1].l[0]), vec3(6.0, 4.0, -3.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[1].l[1]), vec3(3.0, -4.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec2(5u, 5u));
	blockB.b.mA = f16vec4(vec4(-9.0, 0.0, 9.0, 2.0));
	blockC[0].e = i16vec2(ivec2(-7, -8));
	blockD[0].i = (5);
	blockD[0].j = int16_t(-3);
	blockD[0].k[0] = (bvec3(false, true, false));
	blockD[0].k[1] = (bvec3(true, true, false));
	blockD[0].k[2] = (bvec3(false, true, false));
	blockD[0].k[3] = (bvec3(true, true, true));
	blockD[0].k[4] = (bvec3(false, true, false));
	blockD[1].i = (2);
	blockD[1].j = int16_t(4);
	blockD[1].k[0] = (bvec3(true, true, true));
	blockD[1].k[1] = (bvec3(true, true, true));
	blockD[1].k[2] = (bvec3(false, true, true));
	blockD[1].k[3] = (bvec3(false, false, true));
	blockD[2].i = (9);
	blockD[2].j = int16_t(-4);
	blockD[2].k[0] = (bvec3(false, false, true));
	blockD[2].k[1] = (bvec3(true, true, false));
	blockD[2].k[2] = (bvec3(false, true, true));
	blockD[2].k[3] = (bvec3(false, false, true));
	blockD[2].k[4] = (bvec3(true, true, true));
	blockD[2].k[5] = (bvec3(true, false, true));
	blockD[2].k[6] = (bvec3(true, false, false));
	blockD[2].k[7] = (bvec3(false, false, true));
}
#version 450
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
	lowp mat2x3 a;
	i16vec2 b;
	highp mat2x3 c;
	f16vec2 d;
} blockB[1];
layout(scalar, binding = 2) readonly buffer BlockC
{
	f16vec4 e[];
} blockC[3];
layout(scalar, column_major, binding = 3) readonly buffer BlockD
{
	lowp uvec3 f;
	highp vec4 g;
	int16_t h[];
} blockD[2];

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
	uint16_t mA;
	bool mB;
	u16vec3 mC;
	bool mD;
};
struct sB
{
	mediump mat3x4 mA;
	lowp vec3 mB;
	highp mat3x4 mC;
	u16vec2 mD[1];
};
struct sC
{
	lowp mat4x3 mA;
	mediump mat4 mB;
	f16vec4 mC;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	u16vec2 a;
	highp mat4x3 b;
	bool c;
	u16vec4 d;
} blockB;
layout(scalar, row_major, binding = 2) buffer BlockC
{
	sA e;
	int16_t f;
	int16_t g;
	sB h;
};
layout(scalar, column_major, binding = 3) buffer BlockD
{
	mediump uvec3 i[7];
	lowp vec3 j;
	f16vec4 k;
	lowp mat2x3 l;
	sC m[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.b, mat4x3(3.0, 0.0, -5.0, -3.0, 9.0, 4.0, 6.0, 2.0, 7.0, 1.0, -4.0, 2.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.d), uvec4(7u, 3u, 2u, 5u)) && allOk;
	allOk = compare_int16_t(int(f), 8) && allOk;
	allOk = compare_int16_t(int(g), -4) && allOk;
	allOk = compare_mat3x4(h.mA, mat3x4(7.0, 3.0, -8.0, -9.0, 8.0, 4.0, -7.0, 3.0, 2.0, -2.0, 4.0, -9.0)) && allOk;
	allOk = compare_vec3((h.mB), vec3(4.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat3x4(h.mC, mat3x4(-5.0, 5.0, 4.0, -6.0, -9.0, 3.0, 8.0, -3.0, -4.0, 7.0, -8.0, 7.0)) && allOk;
	allOk = compare_u16vec2(uvec2(h.mD[0]), uvec2(1u, 9u)) && allOk;
	allOk = compare_uvec3((blockD.i[0]), uvec3(2u, 1u, 0u)) && allOk;
	allOk = compare_uvec3((blockD.i[1]), uvec3(8u, 4u, 8u)) && allOk;
	allOk = compare_uvec3((blockD.i[2]), uvec3(2u, 1u, 6u)) && allOk;
	allOk = compare_uvec3((blockD.i[3]), uvec3(6u, 5u, 8u)) && allOk;
	allOk = compare_uvec3((blockD.i[4]), uvec3(9u, 2u, 9u)) && allOk;
	allOk = compare_uvec3((blockD.i[5]), uvec3(8u, 5u, 1u)) && allOk;
	allOk = compare_uvec3((blockD.i[6]), uvec3(8u, 1u, 3u)) && allOk;
	allOk = compare_f16vec4(vec4(blockD.k), vec4(0.0, -5.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(blockD.l, mat2x3(1.0, -9.0, 8.0, -4.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(blockD.m[0].mA, mat4x3(7.0, 6.0, 3.0, -6.0, 1.0, 5.0, 5.0, -1.0, -4.0, 0.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4(blockD.m[0].mB, mat4(-6.0, -3.0, 6.0, 4.0, -3.0, -6.0, 1.0, 3.0, 9.0, -2.0, 3.0, -4.0, 3.0, -4.0, -9.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockD.m[0].mC), vec4(9.0, -7.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat4x3(blockD.m[1].mA, mat4x3(-9.0, 8.0, -3.0, 5.0, 9.0, -5.0, -3.0, 1.0, -3.0, 9.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat4(blockD.m[1].mB, mat4(-7.0, 2.0, -1.0, -7.0, -4.0, 2.0, 4.0, 0.0, 4.0, 5.0, 2.0, 0.0, -1.0, 5.0, -2.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockD.m[1].mC), vec4(8.0, -6.0, 9.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec2(uvec2(6u, 1u));
	blockB.b = (mat4x3(-9.0, -4.0, 6.0, 4.0, 8.0, -8.0, 0.0, 4.0, -9.0, 0.0, 0.0, -1.0));
	e.mA = uint16_t(9u);
	e.mB = (true);
	e.mC = u16vec3(uvec3(8u, 0u, 8u));
	e.mD = (false);
	f = int16_t(8);
	g = int16_t(8);
	h.mA = (mat3x4(7.0, 1.0, 9.0, 4.0, -1.0, 7.0, 0.0, 4.0, -3.0, 1.0, -1.0, 5.0));
	h.mB = (vec3(-3.0, 0.0, -6.0));
	h.mC = (mat3x4(9.0, 5.0, -6.0, -1.0, 2.0, 6.0, -8.0, -5.0, -9.0, 0.0, 4.0, 1.0));
	h.mD[0] = u16vec2(uvec2(4u, 9u));
	blockD.i[0] = (uvec3(8u, 8u, 9u));
	blockD.i[1] = (uvec3(9u, 0u, 0u));
	blockD.i[2] = (uvec3(0u, 0u, 6u));
	blockD.i[3] = (uvec3(2u, 1u, 6u));
	blockD.i[4] = (uvec3(5u, 3u, 1u));
	blockD.i[5] = (uvec3(4u, 5u, 4u));
	blockD.i[6] = (uvec3(3u, 6u, 5u));
	blockD.j = (vec3(-6.0, 4.0, 1.0));
	blockD.l = (mat2x3(5.0, 7.0, -5.0, 9.0, -3.0, -5.0));
	blockD.m[0].mA = (mat4x3(-2.0, -7.0, 0.0, 0.0, -3.0, -1.0, -8.0, -8.0, 5.0, -4.0, -5.0, 6.0));
	blockD.m[0].mB = (mat4(-2.0, 3.0, 1.0, 5.0, 0.0, 1.0, 7.0, -8.0, 7.0, -8.0, -4.0, -2.0, -9.0, 2.0, 4.0, -7.0));
	blockD.m[0].mC = f16vec4(vec4(-7.0, -5.0, 2.0, -6.0));
	blockD.m[1].mA = (mat4x3(-1.0, 8.0, 7.0, 0.0, -1.0, 2.0, -5.0, 0.0, 2.0, -8.0, 1.0, 4.0));
	blockD.m[1].mB = (mat4(2.0, 0.0, -5.0, -1.0, -5.0, -4.0, 8.0, 0.0, -1.0, -4.0, 3.0, -8.0, -7.0, 6.0, 3.0, 1.0));
	blockD.m[1].mC = f16vec4(vec4(7.0, -1.0, -9.0, 9.0));
}
#version 450
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
	lowp uint a[1];
	highp float b[1];
};
layout(std140, binding = 2) buffer BlockC
{
	highp uint c;
	highp int d;
	int8_t e;
};
layout(std140, binding = 3) buffer BlockD
{
	bool f;
	lowp float g[1];
	bool h;
	mediump float i;
	int8_t j;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((b[0]), -2.0) && allOk;
	allOk = compare_uint((c), 0u) && allOk;
	allOk = compare_int((d), -5) && allOk;
	allOk = compare_float((blockD.g[0]), 9.0) && allOk;
	allOk = compare_bool((blockD.h), false) && allOk;
	allOk = compare_int8_t(int(blockD.j), 0) && allOk;
    if (allOk)
        ac_numPassed++;

	b[0] = (1.0);
	c = (3u);
	e = int8_t(8);
	blockD.f = (true);
	blockD.h = (false);
	blockD.i = (0.0);
	blockD.j = int8_t(4294967287);
}
#version 450
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
	lowp float a;
	mediump int b;
	highp uvec4 c[];
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	highp mat4x2 d[];
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	bvec3 e;
	lowp ivec3 f;
	highp ivec4 g[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.c[0]), uvec4(2u, 2u, 9u, 2u)) && allOk;
	allOk = compare_uvec4((blockB.c[1]), uvec4(4u, 3u, 4u, 3u)) && allOk;
	allOk = compare_uvec4((blockB.c[2]), uvec4(4u, 7u, 9u, 4u)) && allOk;
	allOk = compare_uvec4((blockB.c[3]), uvec4(7u, 7u, 7u, 5u)) && allOk;
	allOk = compare_uvec4((blockB.c[4]), uvec4(9u, 1u, 1u, 6u)) && allOk;
	allOk = compare_uvec4((blockB.c[5]), uvec4(1u, 0u, 0u, 0u)) && allOk;
	allOk = compare_uvec4((blockB.c[6]), uvec4(7u, 8u, 1u, 5u)) && allOk;
	allOk = compare_mat4x2(blockC.d[0], mat4x2(7.0, 2.0, -8.0, 7.0, 5.0, -7.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat4x2(blockC.d[1], mat4x2(3.0, 5.0, 9.0, -3.0, -6.0, 6.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4x2(blockC.d[2], mat4x2(1.0, -9.0, 2.0, -2.0, -3.0, 0.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(blockC.d[3], mat4x2(0.0, 9.0, -5.0, 7.0, -4.0, 5.0, 7.0, -8.0)) && allOk;
	allOk = compare_bvec3((e), bvec3(true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (-7.0);
	blockB.c[0] = (uvec4(0u, 4u, 9u, 4u));
	blockB.c[1] = (uvec4(3u, 0u, 6u, 4u));
	blockB.c[2] = (uvec4(5u, 2u, 2u, 0u));
	blockB.c[3] = (uvec4(6u, 3u, 5u, 3u));
	blockB.c[4] = (uvec4(4u, 1u, 8u, 5u));
	blockB.c[5] = (uvec4(4u, 0u, 3u, 6u));
	blockB.c[6] = (uvec4(3u, 2u, 6u, 2u));
	blockC.d[0] = (mat4x2(-7.0, 0.0, 7.0, -2.0, 9.0, -6.0, 8.0, 5.0));
	blockC.d[1] = (mat4x2(3.0, -3.0, 6.0, -2.0, 2.0, -5.0, 5.0, 5.0));
	blockC.d[2] = (mat4x2(3.0, 8.0, 5.0, 5.0, 3.0, 6.0, 5.0, 1.0));
	blockC.d[3] = (mat4x2(1.0, -2.0, -3.0, 8.0, 2.0, -1.0, -8.0, 9.0));
	f = (ivec3(-8, -8, -6));
	g[0] = (ivec4(7, 6, -5, 7));
	g[1] = (ivec4(6, -6, 0, 7));
	g[2] = (ivec4(-7, 4, -4, -8));
}
#version 450
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
	highp uvec3 a;
	bvec3 b;
	uint8_t c[3];
	u8vec4 d;
	mediump ivec2 e[];
} blockB;

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB.b = (bvec3(false, true, true));
	blockB.d = u8vec4(uvec4(7u, 9u, 6u, 0u));
	blockB.e[0] = (ivec2(9, 5));
	blockB.e[1] = (ivec2(-6, -1));
	blockB.e[2] = (ivec2(-2, 2));
}
#version 450
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
	u8vec2 mB[8];
	int8_t mC;
};
struct sB
{
	highp vec2 mA;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	u8vec2 a;
	mediump mat2x3 b;
	sA c;
	sB d;
	i8vec4 e;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(a), uvec2(5u, 0u)) && allOk;
	allOk = compare_mat2x3(b, mat2x3(-7.0, 6.0, -2.0, 7.0, 2.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = u8vec2(uvec2(7u, 2u));
	b = (mat2x3(1.0, 5.0, 8.0, 3.0, -9.0, 2.0));
	c.mA = (vec3(-7.0, 3.0, 6.0));
	c.mB[0] = u8vec2(uvec2(5u, 0u));
	c.mB[1] = u8vec2(uvec2(5u, 1u));
	c.mB[2] = u8vec2(uvec2(0u, 0u));
	c.mB[3] = u8vec2(uvec2(5u, 8u));
	c.mB[4] = u8vec2(uvec2(8u, 0u));
	c.mB[5] = u8vec2(uvec2(7u, 7u));
	c.mB[6] = u8vec2(uvec2(1u, 4u));
	c.mB[7] = u8vec2(uvec2(2u, 6u));
	c.mC = int8_t(7);
}
#version 450
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
	lowp ivec4 mB;
	mediump ivec4 mC;
};
struct sB
{
	bvec4 mA;
	bvec2 mB[5];
	bool mC;
	highp mat3x2 mD;
};
struct sC
{
	sA mA;
	sB mB;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	highp mat4x2 a;
	lowp mat3 b[1];
	mediump mat2 c[];
};
layout(std140, binding = 2) buffer BlockC
{
	bvec4 d;
	mediump float e[];
} blockC;
layout(std430, column_major, binding = 3) readonly buffer BlockD
{
	sC f[1];
	mediump uvec4 g[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(c[0], mat2(3.0, 7.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat2(c[1], mat2(-6.0, -9.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat2(c[2], mat2(-5.0, -3.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat2(c[3], mat2(9.0, 3.0, 6.0, 5.0)) && allOk;
	allOk = compare_vec3((blockD.f[0].mA.mA), vec3(-7.0, -3.0, -5.0)) && allOk;
	allOk = compare_ivec4((blockD.f[0].mA.mB), ivec4(5, -2, 2, 1)) && allOk;
	allOk = compare_ivec4((blockD.f[0].mA.mC), ivec4(-3, -4, -5, 9)) && allOk;
	allOk = compare_bvec4((blockD.f[0].mB.mA), bvec4(false, true, false, false)) && allOk;
	allOk = compare_bvec2((blockD.f[0].mB.mB[0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockD.f[0].mB.mB[1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockD.f[0].mB.mB[2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockD.f[0].mB.mB[3]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockD.f[0].mB.mB[4]), bvec2(false, false)) && allOk;
	allOk = compare_bool((blockD.f[0].mB.mC), true) && allOk;
	allOk = compare_mat3x2(blockD.f[0].mB.mD, mat3x2(7.0, -1.0, 7.0, 2.0, 2.0, -3.0)) && allOk;
	allOk = compare_uvec4((blockD.g[0]), uvec4(6u, 7u, 5u, 2u)) && allOk;
	allOk = compare_uvec4((blockD.g[1]), uvec4(0u, 5u, 1u, 7u)) && allOk;
	allOk = compare_uvec4((blockD.g[2]), uvec4(4u, 6u, 6u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	b[0] = (mat3(-6.0, 1.0, -9.0, 5.0, 9.0, -8.0, -7.0, -4.0, 5.0));
	blockC.e[0] = (0.0);
	blockC.e[1] = (-7.0);
	blockC.e[2] = (9.0);
	blockC.e[3] = (1.0);
}
#version 450
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
	lowp mat4x3 mB;
	lowp vec2 mC;
};
layout(std430, binding = 1) buffer BlockB
{
	highp mat4x3 a;
	u8vec3 b;
	highp mat4x3 c[];
};
layout(std430, column_major, binding = 2) buffer BlockC
{
	lowp uint d[];
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	bvec3 e;
	highp ivec4 f[];
};
layout(std430, column_major, binding = 4) buffer BlockE
{
	sA g[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(b), uvec3(3u, 8u, 7u)) && allOk;
	allOk = compare_bvec3((e), bvec3(false, false, true)) && allOk;
	allOk = compare_ivec4((f[0]), ivec4(2, 3, 3, -3)) && allOk;
	allOk = compare_ivec4((f[1]), ivec4(-4, 8, -2, 5)) && allOk;
	allOk = compare_ivec4((f[2]), ivec4(-7, 5, 8, -5)) && allOk;
	allOk = compare_ivec4((f[3]), ivec4(6, 6, -6, 8)) && allOk;
	allOk = compare_ivec4((f[4]), ivec4(-7, -1, -1, 9)) && allOk;
	allOk = compare_mat4(blockE.g[0].mA, mat4(2.0, -9.0, -5.0, -2.0, 1.0, -9.0, -1.0, -3.0, -1.0, 1.0, 9.0, -1.0, 5.0, 6.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat4x3(blockE.g[0].mB, mat4x3(-4.0, -7.0, -7.0, -9.0, 0.0, -9.0, 2.0, -4.0, -9.0, 3.0, 0.0, -6.0)) && allOk;
	allOk = compare_vec2((blockE.g[0].mC), vec2(7.0, 0.0)) && allOk;
	allOk = compare_mat4(blockE.g[1].mA, mat4(-1.0, 0.0, -5.0, 8.0, -9.0, 1.0, 8.0, 2.0, 0.0, 9.0, -9.0, -5.0, 3.0, -9.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat4x3(blockE.g[1].mB, mat4x3(-7.0, 7.0, -3.0, -5.0, 2.0, 9.0, -3.0, -1.0, 5.0, 5.0, -5.0, 7.0)) && allOk;
	allOk = compare_vec2((blockE.g[1].mC), vec2(2.0, -3.0)) && allOk;
	allOk = compare_mat4(blockE.g[2].mA, mat4(1.0, -9.0, -4.0, 6.0, -1.0, 7.0, 9.0, 5.0, -2.0, 0.0, -7.0, 0.0, -1.0, -5.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat4x3(blockE.g[2].mB, mat4x3(2.0, -8.0, -2.0, -6.0, 7.0, 3.0, 3.0, 1.0, 0.0, 2.0, 6.0, 2.0)) && allOk;
	allOk = compare_vec2((blockE.g[2].mC), vec2(9.0, -7.0)) && allOk;
	allOk = compare_mat4(blockE.g[3].mA, mat4(1.0, -8.0, -3.0, -9.0, 9.0, -3.0, -8.0, 6.0, -6.0, 1.0, 7.0, -7.0, -8.0, 4.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat4x3(blockE.g[3].mB, mat4x3(4.0, -8.0, 6.0, -3.0, 4.0, 8.0, 6.0, 3.0, -4.0, -5.0, 0.0, 6.0)) && allOk;
	allOk = compare_vec2((blockE.g[3].mC), vec2(-6.0, 8.0)) && allOk;
	allOk = compare_mat4(blockE.g[4].mA, mat4(-7.0, 4.0, -3.0, 2.0, 8.0, 9.0, 5.0, 3.0, 4.0, -1.0, 3.0, -6.0, 9.0, 6.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4x3(blockE.g[4].mB, mat4x3(7.0, 2.0, -6.0, -4.0, 9.0, -5.0, -3.0, -3.0, 1.0, 3.0, 1.0, 3.0)) && allOk;
	allOk = compare_vec2((blockE.g[4].mC), vec2(9.0, 5.0)) && allOk;
	allOk = compare_mat4(blockE.g[5].mA, mat4(6.0, 4.0, -2.0, 0.0, 4.0, -1.0, 9.0, 1.0, 7.0, -1.0, 6.0, -2.0, 3.0, -9.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat4x3(blockE.g[5].mB, mat4x3(-3.0, 6.0, -3.0, 7.0, 0.0, 3.0, -3.0, 2.0, -2.0, -7.0, 2.0, -5.0)) && allOk;
	allOk = compare_vec2((blockE.g[5].mC), vec2(9.0, 2.0)) && allOk;
	allOk = compare_mat4(blockE.g[6].mA, mat4(-2.0, 6.0, 0.0, -1.0, 4.0, 3.0, 8.0, 9.0, 7.0, -7.0, -3.0, 6.0, -6.0, -4.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat4x3(blockE.g[6].mB, mat4x3(0.0, 1.0, 2.0, -8.0, 9.0, -9.0, 9.0, -4.0, 2.0, -2.0, -4.0, 5.0)) && allOk;
	allOk = compare_vec2((blockE.g[6].mC), vec2(-3.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = u8vec3(uvec3(5u, 9u, 0u));
	blockC.d[0] = (8u);
	blockC.d[1] = (2u);
	e = (bvec3(true, false, false));
	blockE.g[0].mA = (mat4(5.0, -8.0, -5.0, 3.0, -3.0, -7.0, -4.0, 8.0, -2.0, 3.0, -2.0, 3.0, 9.0, -9.0, 8.0, 0.0));
	blockE.g[0].mB = (mat4x3(-1.0, -5.0, 3.0, 1.0, 7.0, 8.0, -1.0, 8.0, 6.0, 2.0, 6.0, -6.0));
	blockE.g[0].mC = (vec2(3.0, -8.0));
	blockE.g[1].mA = (mat4(8.0, -7.0, -4.0, 4.0, 5.0, -3.0, 8.0, -3.0, 3.0, -1.0, 5.0, -3.0, 8.0, -4.0, -1.0, -5.0));
	blockE.g[1].mB = (mat4x3(-3.0, 2.0, 8.0, -5.0, -4.0, 4.0, -8.0, 2.0, -2.0, -7.0, 6.0, 5.0));
	blockE.g[1].mC = (vec2(-9.0, 6.0));
	blockE.g[2].mA = (mat4(6.0, 5.0, 6.0, -1.0, -3.0, -4.0, 0.0, -7.0, 0.0, -3.0, -6.0, -6.0, 0.0, 2.0, 0.0, 5.0));
	blockE.g[2].mB = (mat4x3(-8.0, 3.0, -6.0, 6.0, -9.0, -2.0, 2.0, -3.0, -7.0, 7.0, 6.0, -6.0));
	blockE.g[2].mC = (vec2(9.0, 0.0));
	blockE.g[3].mA = (mat4(0.0, 3.0, 5.0, 9.0, -4.0, -7.0, -2.0, 1.0, 4.0, 7.0, 2.0, -3.0, 9.0, -8.0, -7.0, 2.0));
	blockE.g[3].mB = (mat4x3(5.0, -3.0, 9.0, 1.0, -5.0, 7.0, -2.0, 8.0, 1.0, 8.0, 6.0, 6.0));
	blockE.g[3].mC = (vec2(5.0, -6.0));
	blockE.g[4].mA = (mat4(-7.0, 1.0, -1.0, 1.0, -3.0, 6.0, 3.0, -1.0, 7.0, 0.0, -7.0, 5.0, -9.0, 9.0, 4.0, 4.0));
	blockE.g[4].mB = (mat4x3(-3.0, 7.0, -5.0, 0.0, -2.0, 2.0, 6.0, -9.0, -1.0, 7.0, 8.0, -1.0));
	blockE.g[4].mC = (vec2(-2.0, 7.0));
	blockE.g[5].mA = (mat4(-9.0, 5.0, -5.0, 1.0, 5.0, -8.0, 7.0, -8.0, -6.0, -2.0, -5.0, 9.0, 4.0, -7.0, -1.0, 1.0));
	blockE.g[5].mB = (mat4x3(6.0, 6.0, 1.0, -3.0, -2.0, 7.0, -8.0, 4.0, -6.0, 7.0, 9.0, -7.0));
	blockE.g[5].mC = (vec2(-5.0, -8.0));
	blockE.g[6].mA = (mat4(8.0, -2.0, 5.0, -1.0, -3.0, 6.0, -9.0, 9.0, -9.0, 7.0, 0.0, 2.0, 8.0, 1.0, 5.0, 0.0));
	blockE.g[6].mB = (mat4x3(-1.0, 2.0, 9.0, 5.0, 3.0, 8.0, 6.0, -3.0, -4.0, -2.0, -7.0, -6.0));
	blockE.g[6].mC = (vec2(5.0, -6.0));
}
#version 450
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
	bvec4 a[];
} blockB;
layout(std140, row_major, binding = 2) buffer BlockC
{
	bool b;
};
layout(std430, row_major, binding = 3) buffer BlockD
{
	lowp mat3x2 c;
	highp vec4 d;
	i8vec3 e;
	lowp mat3 f[];
} blockD[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a[0]), bvec4(true, true, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (false);
	blockD[0].c = (mat3x2(8.0, -3.0, -3.0, -1.0, 3.0, 6.0));
	blockD[0].d = (vec4(9.0, 5.0, -6.0, -1.0));
	blockD[0].e = i8vec3(ivec3(4294967294, 2, 4294967293));
	blockD[0].f[0] = (mat3(-9.0, 5.0, -2.0, -5.0, -5.0, 8.0, 3.0, -2.0, -3.0));
	blockD[0].f[1] = (mat3(-3.0, -3.0, 7.0, -8.0, -1.0, -4.0, 1.0, 3.0, -5.0));
	blockD[0].f[2] = (mat3(-1.0, -9.0, -8.0, -3.0, 8.0, -8.0, 1.0, 9.0, 3.0));
	blockD[0].f[3] = (mat3(-3.0, 6.0, 6.0, 0.0, 1.0, 0.0, 4.0, -4.0, -2.0));
	blockD[0].f[4] = (mat3(-1.0, -7.0, -6.0, 5.0, -6.0, 9.0, 2.0, -2.0, 9.0));
	blockD[0].f[5] = (mat3(-9.0, 9.0, 6.0, 5.0, -9.0, 9.0, -3.0, -7.0, 0.0));
	blockD[1].c = (mat3x2(4.0, 0.0, 5.0, 5.0, -3.0, 0.0));
	blockD[1].d = (vec4(1.0, -1.0, 0.0, -7.0));
	blockD[1].e = i8vec3(ivec3(4294967290, 7, 4294967294));
	blockD[1].f[0] = (mat3(-1.0, -6.0, 9.0, -5.0, 2.0, -4.0, -6.0, 5.0, -6.0));
	blockD[1].f[1] = (mat3(-4.0, 0.0, -8.0, 3.0, 3.0, -4.0, 5.0, 2.0, -3.0));
	blockD[1].f[2] = (mat3(-7.0, 6.0, -9.0, 3.0, 1.0, 0.0, 1.0, -9.0, -8.0));
	blockD[2].c = (mat3x2(-1.0, -5.0, -3.0, 3.0, 8.0, 5.0));
	blockD[2].d = (vec4(-7.0, 9.0, 7.0, -3.0));
	blockD[2].e = i8vec3(ivec3(2, 1, 4));
	blockD[2].f[0] = (mat3(-3.0, -2.0, 5.0, 5.0, 1.0, 9.0, -3.0, -3.0, 7.0));
	blockD[2].f[1] = (mat3(3.0, -1.0, 9.0, 5.0, -4.0, 5.0, 0.0, 4.0, -4.0));
}
#version 450
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

}
#version 450
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
	allOk = compare_mat4x2(var, mat4x2(4.0, 9.0, -1.0, 1.0, 7.0, -8.0, 9.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp uvec3 var;
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((var), uvec3(5u, 4u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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

}
#version 450
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

}
#version 450
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
	highp float var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((var), 7.0) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std140, binding = 1) readonly buffer Block
{
	highp uvec2 var[];
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((var[0]), uvec2(6u, 0u)) && allOk;
	allOk = compare_uvec2((var[1]), uvec2(6u, 7u)) && allOk;
	allOk = compare_uvec2((var[2]), uvec2(1u, 7u)) && allOk;
	allOk = compare_uvec2((var[3]), uvec2(9u, 0u)) && allOk;
	allOk = compare_uvec2((var[4]), uvec2(6u, 9u)) && allOk;
	allOk = compare_uvec2((var[5]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((var[6]), uvec2(0u, 2u)) && allOk;
	allOk = compare_uvec2((var[7]), uvec2(2u, 9u)) && allOk;
	allOk = compare_uvec2((var[8]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((var[9]), uvec2(1u, 4u)) && allOk;
	allOk = compare_uvec2((var[10]), uvec2(7u, 1u)) && allOk;
	allOk = compare_uvec2((var[11]), uvec2(8u, 8u)) && allOk;
	allOk = compare_uvec2((var[12]), uvec2(7u, 7u)) && allOk;
	allOk = compare_uvec2((var[13]), uvec2(4u, 6u)) && allOk;
	allOk = compare_uvec2((var[14]), uvec2(5u, 8u)) && allOk;
	allOk = compare_uvec2((var[15]), uvec2(9u, 9u)) && allOk;
	allOk = compare_uvec2((var[16]), uvec2(2u, 1u)) && allOk;
	allOk = compare_uvec2((var[17]), uvec2(0u, 7u)) && allOk;
	allOk = compare_uvec2((var[18]), uvec2(8u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4x3 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0], mat4x3(-7.0, 1.0, 0.0, 0.0, -7.0, 2.0, 5.0, 0.0, 3.0, 2.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(-7.0, -5.0, 2.0, 0.0, -1.0, -5.0, 5.0, 5.0, 9.0, -7.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(3.0, 6.0, -7.0, 7.0, 8.0, 6.0, -7.0, -8.0, -5.0, -9.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[3], mat4x3(-7.0, -7.0, 7.0, 2.0, -5.0, 3.0, 2.0, 0.0, 8.0, -1.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[4], mat4x3(-8.0, 6.0, 2.0, -5.0, -7.0, -7.0, -4.0, -9.0, 7.0, 3.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[5], mat4x3(-7.0, 7.0, 6.0, 3.0, 4.0, 5.0, -2.0, 3.0, 8.0, -7.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[6], mat4x3(0.0, 7.0, 1.0, -2.0, 9.0, -5.0, -3.0, 1.0, -6.0, 6.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[7], mat4x3(9.0, 8.0, 5.0, 4.0, 7.0, -1.0, 6.0, -6.0, 2.0, 8.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[8], mat4x3(0.0, 6.0, -8.0, -4.0, -8.0, 8.0, -5.0, 7.0, 3.0, 9.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[9], mat4x3(6.0, -3.0, 0.0, -3.0, 2.0, -8.0, 6.0, 5.0, -2.0, 2.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[10], mat4x3(-7.0, 4.0, 5.0, -8.0, -1.0, -2.0, -8.0, -4.0, 2.0, 8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[11], mat4x3(4.0, -1.0, 3.0, 3.0, -3.0, 4.0, -6.0, -5.0, 1.0, 4.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[12], mat4x3(8.0, -2.0, 5.0, 8.0, 5.0, -1.0, 2.0, -4.0, -9.0, -5.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[13], mat4x3(-2.0, 7.0, -4.0, 9.0, 4.0, -1.0, -2.0, -8.0, 7.0, 9.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[14], mat4x3(6.0, 1.0, 9.0, 3.0, -6.0, -4.0, 9.0, 3.0, -7.0, -3.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[15], mat4x3(2.0, -4.0, -5.0, 2.0, -6.0, -3.0, -7.0, 2.0, 6.0, 4.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[16], mat4x3(7.0, 2.0, -9.0, -6.0, -7.0, -2.0, -2.0, 6.0, -5.0, -9.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[17], mat4x3(-4.0, 1.0, -3.0, -3.0, -1.0, -5.0, -5.0, 7.0, -9.0, 6.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[18], mat4x3(8.0, -3.0, 5.0, 4.0, -3.0, 7.0, -7.0, -8.0, -9.0, 2.0, 6.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4 var[];
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
	allOk = compare_mat4(var[3], mat4(-7.0, -7.0, 7.0, -7.0, 4.0, 1.0, -4.0, -7.0, 6.0, -4.0, -3.0, -1.0, -2.0, -9.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4(var[4], mat4(0.0, -8.0, 2.0, 0.0, -4.0, 1.0, 6.0, 1.0, 2.0, -1.0, -8.0, -9.0, -1.0, -9.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat4(var[5], mat4(-8.0, -3.0, -4.0, -8.0, 3.0, 1.0, 4.0, -4.0, -2.0, 6.0, -8.0, 3.0, 7.0, 5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4(var[6], mat4(-3.0, 8.0, 3.0, 5.0, 3.0, 4.0, 5.0, 4.0, -2.0, -6.0, -8.0, -4.0, -5.0, -1.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4(var[7], mat4(3.0, -1.0, -2.0, -6.0, -8.0, 2.0, 9.0, -9.0, 2.0, -3.0, 5.0, -1.0, -5.0, -4.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4(var[8], mat4(9.0, 9.0, 2.0, -3.0, -5.0, 5.0, 4.0, -6.0, -7.0, -1.0, -4.0, 6.0, -7.0, -9.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat4(var[9], mat4(-5.0, -1.0, 3.0, -4.0, 5.0, -7.0, -2.0, 3.0, 0.0, -1.0, 7.0, 5.0, -6.0, -1.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4(var[10], mat4(1.0, -9.0, -6.0, 7.0, 6.0, 4.0, -5.0, 0.0, 8.0, -4.0, -3.0, -6.0, -7.0, 4.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4(var[11], mat4(-2.0, 4.0, -8.0, 7.0, -3.0, 2.0, -9.0, -8.0, 8.0, 9.0, -5.0, 0.0, 4.0, 3.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat4(var[12], mat4(-3.0, 4.0, 8.0, 3.0, 4.0, -3.0, -4.0, -1.0, -4.0, 5.0, -4.0, 7.0, -7.0, 3.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat4(var[13], mat4(-6.0, -2.0, 6.0, 9.0, 8.0, -2.0, 0.0, 5.0, -9.0, 5.0, -1.0, 4.0, -3.0, 8.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat4(var[14], mat4(0.0, -2.0, 6.0, -1.0, 9.0, 9.0, -9.0, 0.0, 4.0, -3.0, 4.0, 1.0, -1.0, 3.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat4(var[15], mat4(-2.0, -2.0, 2.0, -3.0, 4.0, -1.0, 6.0, -4.0, 3.0, 0.0, 8.0, 1.0, -9.0, 8.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4(var[16], mat4(1.0, -7.0, -9.0, 0.0, -1.0, -2.0, -1.0, 9.0, -9.0, 0.0, -4.0, -1.0, -6.0, 2.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat4(var[17], mat4(-2.0, -9.0, -3.0, 9.0, -7.0, -2.0, 7.0, 7.0, 1.0, 9.0, -4.0, 7.0, 0.0, 3.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat4(var[18], mat4(1.0, 6.0, -9.0, -8.0, -5.0, -5.0, 8.0, 1.0, 7.0, -6.0, -8.0, 7.0, -7.0, -3.0, -2.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	bool var[];
};

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((var[0]), false) && allOk;
	allOk = compare_bool((var[1]), true) && allOk;
	allOk = compare_bool((var[2]), true) && allOk;
	allOk = compare_bool((var[3]), false) && allOk;
	allOk = compare_bool((var[4]), false) && allOk;
	allOk = compare_bool((var[5]), true) && allOk;
	allOk = compare_bool((var[6]), true) && allOk;
	allOk = compare_bool((var[7]), false) && allOk;
	allOk = compare_bool((var[8]), false) && allOk;
	allOk = compare_bool((var[9]), false) && allOk;
	allOk = compare_bool((var[10]), false) && allOk;
	allOk = compare_bool((var[11]), true) && allOk;
	allOk = compare_bool((var[12]), true) && allOk;
	allOk = compare_bool((var[13]), false) && allOk;
	allOk = compare_bool((var[14]), true) && allOk;
	allOk = compare_bool((var[15]), true) && allOk;
	allOk = compare_bool((var[16]), false) && allOk;
	allOk = compare_bool((var[17]), true) && allOk;
	allOk = compare_bool((var[18]), false) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3 var[];
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
	allOk = compare_mat3(var[3], mat3(2.0, 8.0, 1.0, -3.0, -4.0, 7.0, -1.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(var[4], mat3(-6.0, -6.0, -5.0, 5.0, -2.0, 0.0, 7.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3(var[5], mat3(-3.0, 9.0, 7.0, 8.0, -9.0, -1.0, -4.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3(var[6], mat3(-1.0, 8.0, 3.0, 2.0, -6.0, -2.0, -2.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3(var[7], mat3(-9.0, 0.0, 6.0, -9.0, -5.0, 8.0, -7.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3(var[8], mat3(-7.0, 6.0, 2.0, 5.0, 4.0, 9.0, 7.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3(var[9], mat3(1.0, -6.0, -3.0, -1.0, 6.0, 0.0, -2.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[10], mat3(2.0, 1.0, 9.0, -4.0, -9.0, 2.0, 5.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[11], mat3(0.0, 9.0, 5.0, 1.0, 2.0, 2.0, -5.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[12], mat3(5.0, 9.0, 9.0, 5.0, -5.0, 9.0, 1.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat3(var[13], mat3(8.0, 8.0, -6.0, 5.0, 4.0, 8.0, -9.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3(var[14], mat3(2.0, 8.0, -1.0, -2.0, -4.0, 3.0, 5.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat3(var[15], mat3(8.0, 0.0, -9.0, -4.0, -9.0, 0.0, 9.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3(var[16], mat3(-2.0, -2.0, -5.0, -6.0, -1.0, -4.0, 8.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3(var[17], mat3(5.0, 2.0, 4.0, -8.0, 2.0, -4.0, -7.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3(var[18], mat3(2.0, 2.0, 9.0, -8.0, -2.0, -1.0, 8.0, 3.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(scalar, column_major, binding = 1) readonly buffer Block
{
	highp mat4 var[];
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
	allOk = compare_mat4(var[3], mat4(-7.0, -7.0, 7.0, -7.0, 4.0, 1.0, -4.0, -7.0, 6.0, -4.0, -3.0, -1.0, -2.0, -9.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4(var[4], mat4(0.0, -8.0, 2.0, 0.0, -4.0, 1.0, 6.0, 1.0, 2.0, -1.0, -8.0, -9.0, -1.0, -9.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat4(var[5], mat4(-8.0, -3.0, -4.0, -8.0, 3.0, 1.0, 4.0, -4.0, -2.0, 6.0, -8.0, 3.0, 7.0, 5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4(var[6], mat4(-3.0, 8.0, 3.0, 5.0, 3.0, 4.0, 5.0, 4.0, -2.0, -6.0, -8.0, -4.0, -5.0, -1.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4(var[7], mat4(3.0, -1.0, -2.0, -6.0, -8.0, 2.0, 9.0, -9.0, 2.0, -3.0, 5.0, -1.0, -5.0, -4.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4(var[8], mat4(9.0, 9.0, 2.0, -3.0, -5.0, 5.0, 4.0, -6.0, -7.0, -1.0, -4.0, 6.0, -7.0, -9.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat4(var[9], mat4(-5.0, -1.0, 3.0, -4.0, 5.0, -7.0, -2.0, 3.0, 0.0, -1.0, 7.0, 5.0, -6.0, -1.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4(var[10], mat4(1.0, -9.0, -6.0, 7.0, 6.0, 4.0, -5.0, 0.0, 8.0, -4.0, -3.0, -6.0, -7.0, 4.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4(var[11], mat4(-2.0, 4.0, -8.0, 7.0, -3.0, 2.0, -9.0, -8.0, 8.0, 9.0, -5.0, 0.0, 4.0, 3.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat4(var[12], mat4(-3.0, 4.0, 8.0, 3.0, 4.0, -3.0, -4.0, -1.0, -4.0, 5.0, -4.0, 7.0, -7.0, 3.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat4(var[13], mat4(-6.0, -2.0, 6.0, 9.0, 8.0, -2.0, 0.0, 5.0, -9.0, 5.0, -1.0, 4.0, -3.0, 8.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat4(var[14], mat4(0.0, -2.0, 6.0, -1.0, 9.0, 9.0, -9.0, 0.0, 4.0, -3.0, 4.0, 1.0, -1.0, 3.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat4(var[15], mat4(-2.0, -2.0, 2.0, -3.0, 4.0, -1.0, 6.0, -4.0, 3.0, 0.0, 8.0, 1.0, -9.0, 8.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4(var[16], mat4(1.0, -7.0, -9.0, 0.0, -1.0, -2.0, -1.0, 9.0, -9.0, 0.0, -4.0, -1.0, -6.0, 2.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat4(var[17], mat4(-2.0, -9.0, -3.0, 9.0, -7.0, -2.0, 7.0, 7.0, 1.0, 9.0, -4.0, 7.0, 0.0, 3.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat4(var[18], mat4(1.0, 6.0, -9.0, -8.0, -5.0, -5.0, 8.0, 1.0, 7.0, -6.0, -8.0, 7.0, -7.0, -3.0, -2.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	allOk = compare_float(block.var[0][0], -6.0) && allOk;
	allOk = compare_float(block.var[0][1], -3.0) && allOk;
	allOk = compare_float(block.var[1][0], -5.0) && allOk;
	allOk = compare_float(block.var[1][1], -3.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(-6.0, -3.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-5.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2(8.0, 2.0, 1.0, 1.0));
}
#version 450
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

layout(std140, row_major, buffer_reference) buffer Block
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
	allOk = compare_mat3(block.var, mat3(-4.0, 6.0, 7.0, 6.0, -1.0, -6.0, -5.0, -8.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3(-9.0, 1.0, -5.0, 3.0, -5.0, 8.0, 0.0, 9.0, -8.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var, mat2x4(-7.0, -6.0, -6.0, -9.0, -6.0, -9.0, 1.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(7.0, 2.0, 0.0, 0.0));
	block.var[1] = (vec4(8.0, -3.0, -2.0, 7.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -1.0) && allOk;
	allOk = compare_float(block.var[0][1], -9.0) && allOk;
	allOk = compare_float(block.var[1][0], 4.0) && allOk;
	allOk = compare_float(block.var[1][1], 5.0) && allOk;
	allOk = compare_float(block.var[2][0], 3.0) && allOk;
	allOk = compare_float(block.var[2][1], -5.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(-1.0, -9.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(4.0, 5.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x2(-2.0, 9.0, -5.0, -5.0, -7.0, -2.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -7.0) && allOk;
	allOk = compare_float(block.var[0][1], -9.0) && allOk;
	allOk = compare_float(block.var[0][2], 9.0) && allOk;
	allOk = compare_float(block.var[0][3], 8.0) && allOk;
	allOk = compare_float(block.var[1][0], -4.0) && allOk;
	allOk = compare_float(block.var[1][1], 7.0) && allOk;
	allOk = compare_float(block.var[1][2], -2.0) && allOk;
	allOk = compare_float(block.var[1][3], -5.0) && allOk;
	allOk = compare_float(block.var[2][0], -7.0) && allOk;
	allOk = compare_float(block.var[2][1], 0.0) && allOk;
	allOk = compare_float(block.var[2][2], -9.0) && allOk;
	allOk = compare_float(block.var[2][3], -4.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-7.0, -9.0, 9.0, 8.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-4.0, 7.0, -2.0, -5.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(-7.0, 0.0, -9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x4(5.0, 7.0, -4.0, 0.0, 4.0, -1.0, 9.0, -2.0, 3.0, 2.0, -7.0, 7.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 9.0) && allOk;
	allOk = compare_float(block.var[0][1], -1.0) && allOk;
	allOk = compare_float(block.var[1][0], -8.0) && allOk;
	allOk = compare_float(block.var[1][1], 6.0) && allOk;
	allOk = compare_float(block.var[2][0], -4.0) && allOk;
	allOk = compare_float(block.var[2][1], -8.0) && allOk;
	allOk = compare_float(block.var[3][0], -3.0) && allOk;
	allOk = compare_float(block.var[3][1], -8.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(9.0, -1.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-8.0, 6.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(-4.0, -8.0)) && allOk;
	allOk = compare_vec2(block.var[3], vec2(-3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x2(-6.0, -9.0, 0.0, 8.0, -9.0, 9.0, 4.0, -9.0));
}
#version 450
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
	u8vec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(block.var), uvec2(3u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = u8vec2(uvec2(7u, 7u));
}
#version 450
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
	mediump int var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((block.var), -2) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (2);
}
#version 450
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
	allOk = compare_float((block.padding), 0.0) && allOk;
	allOk = compare_mat2x3(block.var, mat2x3(2.0, -5.0, -4.0, 3.0, -7.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-6.0);
	block.var[0] = (vec3(-2.0, 5.0, 0.0));
	block.var[1] = (vec3(0.0, 6.0, -6.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0], mat4x2(-4.0, 6.0, 0.0, -5.0, 0.0, -1.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(-6.0, -1.0, 4.0, 0.0, 2.0, -3.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(-8.0, -1.0, 5.0, 4.0, 9.0, -2.0, -3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4x2(1.0, 8.0, -9.0, 4.0, 1.0, -5.0, 2.0, -5.0));
	block.var[1] = (mat4x2(8.0, -8.0, 8.0, 3.0, 2.0, -6.0, 3.0, 8.0));
	block.var[2] = (mat4x2(8.0, 9.0, -3.0, -9.0, -2.0, 6.0, -1.0, 6.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0], mat2x4(-8.0, -3.0, 6.0, -5.0, 2.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(-2.0, 8.0, 0.0, 5.0, -6.0, 9.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(1.0, -1.0, -5.0, 4.0, -7.0, -3.0, 8.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2x4(-2.0, 3.0, 2.0, -4.0, 2.0, -2.0, 9.0, -4.0));
	block.var[1] = (mat2x4(0.0, 7.0, 4.0, -8.0, 6.0, 0.0, -1.0, -8.0));
	block.var[2] = (mat2x4(2.0, 8.0, 2.0, 4.0, 5.0, 4.0, -3.0, 4.0));
}
#version 450
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
	u8vec3 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(block.var[0]), uvec3(4u, 3u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[1]), uvec3(1u, 4u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[2]), uvec3(8u, 6u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = u8vec3(uvec3(4u, 5u, 9u));
	block.var[1] = u8vec3(uvec3(6u, 9u, 4u));
	block.var[2] = u8vec3(uvec3(7u, 1u, 5u));
}
#version 450
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
	int8_t var[3];
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
    if (allOk)
        ac_numPassed++;

	block.var[0] = int8_t(4294967290);
	block.var[1] = int8_t(4294967294);
	block.var[2] = int8_t(3);
}
#version 450
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
	highp vec2 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.padding), 5.0) && allOk;
	allOk = compare_vec2((block.var[0]), vec2(4.0, -8.0)) && allOk;
	allOk = compare_vec2((block.var[1]), vec2(-7.0, -7.0)) && allOk;
	allOk = compare_vec2((block.var[2]), vec2(-5.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (3.0);
	block.var[0] = (vec2(8.0, 7.0));
	block.var[1] = (vec2(-1.0, -4.0));
	block.var[2] = (vec2(8.0, -2.0));
}
#version 450
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
	allOk = compare_float((block.padding), -8.0) && allOk;
	allOk = compare_mat4(block.var[0], mat4(-5.0, 8.0, 6.0, 7.0, 4.0, 5.0, 7.0, -3.0, 0.0, 2.0, 5.0, 8.0, 3.0, 4.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[1], mat4(-9.0, -9.0, -6.0, 5.0, 6.0, 7.0, 6.0, 1.0, -8.0, -3.0, -3.0, 7.0, -2.0, -3.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[2], mat4(-1.0, -6.0, -1.0, 6.0, 1.0, -1.0, 3.0, -1.0, 6.0, 4.0, -2.0, -9.0, 0.0, 5.0, -6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-9.0);
	block.var[0][0] = (vec4(-9.0, -4.0, -9.0, -5.0));
	block.var[0][1] = (vec4(-2.0, 9.0, 0.0, -8.0));
	block.var[0][2] = (vec4(-6.0, -3.0, -8.0, 3.0));
	block.var[0][3] = (vec4(0.0, -1.0, -4.0, 4.0));
	block.var[1][0] = (vec4(7.0, -9.0, 6.0, 5.0));
	block.var[1][1] = (vec4(6.0, -1.0, -3.0, -3.0));
	block.var[1][2] = (vec4(-9.0, 3.0, -9.0, 0.0));
	block.var[1][3] = (vec4(9.0, 4.0, -3.0, 1.0));
	block.var[2][0] = (vec4(2.0, 1.0, 9.0, -4.0));
	block.var[2][1] = (vec4(-7.0, 7.0, 0.0, 7.0));
	block.var[2][2] = (vec4(9.0, 9.0, -5.0, -7.0));
	block.var[2][3] = (vec4(-4.0, -6.0, 5.0, -9.0));
}
#version 450
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
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_mat2x3(block.var[0], mat2x3(3.0, -3.0, 8.0, 7.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1], mat2x3(-6.0, -3.0, -8.0, 6.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2], mat2x3(-5.0, 8.0, -3.0, 0.0, -4.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (0.0);
	block.var[0] = (mat2x3(4.0, 4.0, 5.0, -5.0, 2.0, 8.0));
	block.var[1] = (mat2x3(-1.0, -2.0, -7.0, -8.0, -2.0, 2.0));
	block.var[2] = (mat2x3(-2.0, 7.0, -9.0, 7.0, -7.0, -5.0));
}
#version 450
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
	allOk = compare_float((block.padding), -9.0) && allOk;
	allOk = compare_mat2x4(block.var[0], mat2x4(-8.0, -3.0, -8.0, 8.0, -2.0, -2.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(3.0, -6.0, 9.0, -3.0, 1.0, 0.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(2.0, -4.0, 5.0, -1.0, 4.0, -2.0, 4.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-3.0);
	block.var[0][0] = (vec4(-4.0, -6.0, -3.0, 6.0));
	block.var[0][1] = (vec4(4.0, -6.0, 2.0, -5.0));
	block.var[1][0] = (vec4(1.0, 7.0, 0.0, 9.0));
	block.var[1][1] = (vec4(1.0, 6.0, 1.0, 8.0));
	block.var[2][0] = (vec4(-6.0, 5.0, 5.0, -6.0));
	block.var[2][1] = (vec4(6.0, -7.0, -4.0, 5.0));
}
#version 450
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

layout(std430, column_major, buffer_reference) buffer Block
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
	allOk = compare_mat2(block.var[0], mat2(-2.0, 3.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(8.0, 2.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(3.0, 2.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[3], mat2(5.0, 8.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[4], mat2(-7.0, 8.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[5], mat2(-6.0, 2.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[6], mat2(9.0, -3.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[7], mat2(-2.0, 8.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[8], mat2(3.0, 5.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[9], mat2(-8.0, -1.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[10], mat2(-6.0, 9.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[11], mat2(-7.0, 1.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[12], mat2(6.0, -3.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[13], mat2(3.0, 6.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[14], mat2(3.0, -9.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[15], mat2(6.0, -4.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[16], mat2(0.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[17], mat2(-4.0, 8.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[18], mat2(6.0, -8.0, -1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec2(5.0, -4.0));
	block.var[0][1] = (vec2(5.0, 1.0));
	block.var[1][0] = (vec2(-8.0, -1.0));
	block.var[1][1] = (vec2(9.0, -8.0));
	block.var[2][0] = (vec2(5.0, -4.0));
	block.var[2][1] = (vec2(5.0, -2.0));
	block.var[3][0] = (vec2(9.0, -9.0));
	block.var[3][1] = (vec2(-1.0, 6.0));
	block.var[4][0] = (vec2(-4.0, 7.0));
	block.var[4][1] = (vec2(-8.0, 1.0));
	block.var[5][0] = (vec2(4.0, -4.0));
	block.var[5][1] = (vec2(6.0, -5.0));
	block.var[6][0] = (vec2(4.0, -3.0));
	block.var[6][1] = (vec2(6.0, 7.0));
	block.var[7][0] = (vec2(-7.0, -9.0));
	block.var[7][1] = (vec2(5.0, 0.0));
	block.var[8][0] = (vec2(9.0, 2.0));
	block.var[8][1] = (vec2(1.0, -6.0));
	block.var[9][0] = (vec2(8.0, -8.0));
	block.var[9][1] = (vec2(5.0, -5.0));
	block.var[10][0] = (vec2(-5.0, 4.0));
	block.var[10][1] = (vec2(5.0, 0.0));
	block.var[11][0] = (vec2(6.0, 9.0));
	block.var[11][1] = (vec2(5.0, -8.0));
	block.var[12][0] = (vec2(7.0, 7.0));
	block.var[12][1] = (vec2(0.0, 2.0));
	block.var[13][0] = (vec2(4.0, -7.0));
	block.var[13][1] = (vec2(-5.0, -7.0));
	block.var[14][0] = (vec2(8.0, 2.0));
	block.var[14][1] = (vec2(1.0, -1.0));
	block.var[15][0] = (vec2(9.0, 0.0));
	block.var[15][1] = (vec2(-8.0, -9.0));
	block.var[16][0] = (vec2(-2.0, 7.0));
	block.var[16][1] = (vec2(8.0, 2.0));
	block.var[17][0] = (vec2(-3.0, -3.0));
	block.var[17][1] = (vec2(7.0, -2.0));
	block.var[18][0] = (vec2(4.0, -2.0));
	block.var[18][1] = (vec2(6.0, 1.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0], mat4x2(8.0, 1.0, 9.0, 3.0, -8.0, 3.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(8.0, -6.0, -5.0, 7.0, -8.0, -2.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(9.0, 4.0, 4.0, 4.0, 3.0, -6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[3], mat4x2(3.0, -2.0, -4.0, 6.0, -1.0, 6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[4], mat4x2(-1.0, 0.0, -1.0, -3.0, 6.0, -8.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[5], mat4x2(2.0, -2.0, 9.0, -1.0, 8.0, -1.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[6], mat4x2(0.0, 7.0, 4.0, 1.0, -9.0, -2.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[7], mat4x2(8.0, 8.0, -1.0, -5.0, -4.0, 4.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[8], mat4x2(7.0, 4.0, 2.0, -2.0, -2.0, 5.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[9], mat4x2(8.0, -7.0, 6.0, -9.0, -2.0, -4.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[10], mat4x2(-4.0, 1.0, -6.0, 5.0, -7.0, -4.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[11], mat4x2(2.0, -3.0, -2.0, -6.0, 9.0, -8.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[12], mat4x2(3.0, -3.0, -9.0, 4.0, -4.0, -4.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[13], mat4x2(-1.0, -6.0, -9.0, 0.0, 2.0, -7.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[14], mat4x2(4.0, -4.0, -5.0, -5.0, 1.0, -5.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[15], mat4x2(-4.0, 2.0, -1.0, -3.0, -7.0, -8.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[16], mat4x2(4.0, 9.0, -6.0, -7.0, 1.0, 2.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[17], mat4x2(2.0, -5.0, -5.0, -2.0, 5.0, 3.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[18], mat4x2(1.0, -1.0, 1.0, -8.0, -7.0, -2.0, 3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4x2(-9.0, -8.0, -8.0, 3.0, 8.0, 7.0, 0.0, 5.0));
	block.var[1] = (mat4x2(5.0, 8.0, 8.0, 8.0, 6.0, -3.0, -6.0, -4.0));
	block.var[2] = (mat4x2(-6.0, -9.0, 1.0, -1.0, 8.0, -7.0, 5.0, -3.0));
	block.var[3] = (mat4x2(8.0, 7.0, 6.0, 9.0, 0.0, -1.0, 7.0, 0.0));
	block.var[4] = (mat4x2(1.0, 6.0, 8.0, 3.0, 9.0, 0.0, -5.0, -5.0));
	block.var[5] = (mat4x2(3.0, -5.0, 8.0, 2.0, -9.0, 0.0, 7.0, 6.0));
	block.var[6] = (mat4x2(-4.0, 4.0, -6.0, 9.0, 5.0, 8.0, -2.0, -7.0));
	block.var[7] = (mat4x2(8.0, -4.0, 6.0, -7.0, 8.0, -5.0, 8.0, 4.0));
	block.var[8] = (mat4x2(-4.0, -8.0, 4.0, 9.0, 5.0, 6.0, 9.0, 3.0));
	block.var[9] = (mat4x2(-5.0, 7.0, -9.0, 1.0, 1.0, -3.0, 9.0, -2.0));
	block.var[10] = (mat4x2(6.0, -7.0, 7.0, -9.0, 7.0, -6.0, -9.0, -4.0));
	block.var[11] = (mat4x2(3.0, -8.0, 2.0, -9.0, 6.0, 2.0, -6.0, 3.0));
	block.var[12] = (mat4x2(8.0, 9.0, 4.0, -2.0, -8.0, -5.0, -3.0, 9.0));
	block.var[13] = (mat4x2(9.0, -3.0, 8.0, 2.0, -9.0, 2.0, 1.0, -2.0));
	block.var[14] = (mat4x2(6.0, 7.0, -3.0, 4.0, 8.0, -4.0, -9.0, -6.0));
	block.var[15] = (mat4x2(-8.0, 1.0, 6.0, -6.0, 6.0, -2.0, -8.0, 8.0));
	block.var[16] = (mat4x2(0.0, 7.0, -6.0, 0.0, -7.0, 3.0, -3.0, 1.0));
	block.var[17] = (mat4x2(-4.0, -6.0, -8.0, -9.0, 1.0, 4.0, 2.0, -5.0));
	block.var[18] = (mat4x2(-4.0, 0.0, 5.0, 8.0, 4.0, -1.0, 1.0, 4.0));
}
#version 450
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

layout(scalar, buffer_reference) buffer Block
{
	f16vec3 var[];
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
	allOk = compare_f16vec3(vec3(block.var[3]), vec3(4.0, 4.0, 5.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[4]), vec3(2.0, 1.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[5]), vec3(8.0, 2.0, -3.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[6]), vec3(1.0, -2.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[7]), vec3(-7.0, -7.0, -7.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[8]), vec3(-8.0, -2.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[9]), vec3(6.0, 6.0, -1.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[10]), vec3(-4.0, -4.0, 6.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[11]), vec3(-8.0, 6.0, 4.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[12]), vec3(-1.0, -7.0, -9.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[13]), vec3(2.0, 6.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[14]), vec3(-5.0, 1.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[15]), vec3(5.0, 4.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[16]), vec3(6.0, -7.0, -8.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[17]), vec3(6.0, -8.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[18]), vec3(8.0, 2.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = f16vec3(vec3(3.0, 3.0, 7.0));
	block.var[1] = f16vec3(vec3(-3.0, -5.0, -9.0));
	block.var[2] = f16vec3(vec3(-1.0, 0.0, 6.0));
	block.var[3] = f16vec3(vec3(5.0, -7.0, 2.0));
	block.var[4] = f16vec3(vec3(9.0, 1.0, -5.0));
	block.var[5] = f16vec3(vec3(-5.0, 5.0, 2.0));
	block.var[6] = f16vec3(vec3(-5.0, -4.0, 6.0));
	block.var[7] = f16vec3(vec3(-3.0, -7.0, -4.0));
	block.var[8] = f16vec3(vec3(-4.0, 5.0, 0.0));
	block.var[9] = f16vec3(vec3(-6.0, 4.0, -1.0));
	block.var[10] = f16vec3(vec3(-2.0, 3.0, -8.0));
	block.var[11] = f16vec3(vec3(-4.0, -2.0, 4.0));
	block.var[12] = f16vec3(vec3(6.0, 6.0, -6.0));
	block.var[13] = f16vec3(vec3(-3.0, 1.0, -5.0));
	block.var[14] = f16vec3(vec3(6.0, 9.0, 7.0));
	block.var[15] = f16vec3(vec3(2.0, 5.0, 3.0));
	block.var[16] = f16vec3(vec3(9.0, -8.0, 2.0));
	block.var[17] = f16vec3(vec3(-7.0, -8.0, -3.0));
	block.var[18] = f16vec3(vec3(2.0, -5.0, -9.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0][0], mat2(-7.0, -2.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[0][1], mat2(0.0, 4.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[0][2], mat2(-2.0, -1.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[1][0], mat2(6.0, -4.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[1][1], mat2(3.0, 2.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[1][2], mat2(8.0, -3.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[2][0], mat2(2.0, -7.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[2][1], mat2(-7.0, 8.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[2][2], mat2(3.0, -1.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[3][0], mat2(2.0, -7.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[3][1], mat2(1.0, 7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[3][2], mat2(-5.0, -4.0, -3.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat2(1.0, 2.0, 6.0, -6.0));
	block.var[0][1] = (mat2(2.0, 4.0, 4.0, 7.0));
	block.var[0][2] = (mat2(0.0, 8.0, 0.0, -1.0));
	block.var[1][0] = (mat2(8.0, -4.0, -5.0, 7.0));
	block.var[1][1] = (mat2(-3.0, -1.0, 0.0, 6.0));
	block.var[1][2] = (mat2(-6.0, 7.0, 4.0, -7.0));
	block.var[2][0] = (mat2(1.0, -8.0, -9.0, -7.0));
	block.var[2][1] = (mat2(1.0, -2.0, -6.0, -8.0));
	block.var[2][2] = (mat2(-6.0, -6.0, 2.0, -9.0));
	block.var[3][0] = (mat2(9.0, 0.0, -3.0, -7.0));
	block.var[3][1] = (mat2(8.0, 8.0, 7.0, -3.0));
	block.var[3][2] = (mat2(7.0, 2.0, -8.0, -7.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0][0], mat4(3.0, 8.0, 5.0, -7.0, -4.0, 0.0, -1.0, -9.0, 2.0, 9.0, 5.0, 5.0, 6.0, 9.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[0][1], mat4(8.0, 1.0, -3.0, 1.0, 0.0, -7.0, -4.0, 0.0, 1.0, -6.0, -7.0, 5.0, 2.0, 0.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[0][2], mat4(-5.0, 8.0, 2.0, 3.0, 8.0, -6.0, 7.0, 9.0, -3.0, 7.0, -8.0, -5.0, 6.0, 4.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[1][0], mat4(7.0, 0.0, -6.0, -1.0, 5.0, 0.0, -3.0, -3.0, 6.0, -5.0, 1.0, 4.0, -5.0, -7.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[1][1], mat4(-2.0, -3.0, 2.0, -9.0, 6.0, -8.0, 8.0, 2.0, -3.0, -9.0, 8.0, 1.0, -4.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[1][2], mat4(9.0, -2.0, -1.0, -7.0, 6.0, -6.0, -3.0, -9.0, -3.0, -7.0, -2.0, 2.0, -9.0, -2.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[2][0], mat4(2.0, -3.0, 7.0, 9.0, 7.0, -1.0, 3.0, 6.0, -3.0, 2.0, -2.0, 7.0, -9.0, 0.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[2][1], mat4(-2.0, -1.0, -6.0, -6.0, 5.0, -8.0, 7.0, 3.0, -6.0, 4.0, -8.0, -1.0, 1.0, 4.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[2][2], mat4(-7.0, -2.0, -4.0, -6.0, -6.0, 8.0, 5.0, -4.0, -7.0, 7.0, -4.0, -9.0, -7.0, -1.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[3][0], mat4(5.0, -4.0, -1.0, -3.0, 3.0, 2.0, 1.0, -6.0, 3.0, 5.0, -4.0, 0.0, 2.0, -4.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[3][1], mat4(-6.0, -9.0, -6.0, -9.0, -4.0, 2.0, 5.0, 4.0, -6.0, -2.0, -5.0, 7.0, 9.0, -4.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[3][2], mat4(-2.0, 1.0, -2.0, 0.0, -7.0, 2.0, -6.0, -5.0, 2.0, -1.0, -8.0, 8.0, 2.0, -9.0, -3.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec4(-7.0, -2.0, 7.0, -7.0));
	block.var[0][0][1] = (vec4(2.0, -4.0, 3.0, -5.0));
	block.var[0][0][2] = (vec4(2.0, 3.0, 8.0, 8.0));
	block.var[0][0][3] = (vec4(3.0, 0.0, -4.0, -1.0));
	block.var[0][1][0] = (vec4(-3.0, 0.0, 8.0, 1.0));
	block.var[0][1][1] = (vec4(-8.0, 9.0, 2.0, 7.0));
	block.var[0][1][2] = (vec4(-2.0, -7.0, -9.0, 1.0));
	block.var[0][1][3] = (vec4(6.0, -9.0, -1.0, -5.0));
	block.var[0][2][0] = (vec4(-6.0, -3.0, 7.0, -1.0));
	block.var[0][2][1] = (vec4(0.0, -1.0, -2.0, 1.0));
	block.var[0][2][2] = (vec4(-3.0, -1.0, -4.0, 7.0));
	block.var[0][2][3] = (vec4(-3.0, 1.0, 1.0, -9.0));
	block.var[1][0][0] = (vec4(-3.0, 2.0, 9.0, -4.0));
	block.var[1][0][1] = (vec4(2.0, 9.0, -9.0, -2.0));
	block.var[1][0][2] = (vec4(-1.0, 1.0, -9.0, 0.0));
	block.var[1][0][3] = (vec4(-7.0, 7.0, -3.0, -9.0));
	block.var[1][1][0] = (vec4(-1.0, 0.0, 7.0, 7.0));
	block.var[1][1][1] = (vec4(-5.0, -2.0, -6.0, 0.0));
	block.var[1][1][2] = (vec4(-2.0, 1.0, -2.0, 4.0));
	block.var[1][1][3] = (vec4(4.0, 0.0, 0.0, -2.0));
	block.var[1][2][0] = (vec4(4.0, 7.0, -5.0, -3.0));
	block.var[1][2][1] = (vec4(9.0, 1.0, 5.0, 5.0));
	block.var[1][2][2] = (vec4(9.0, -4.0, -6.0, 8.0));
	block.var[1][2][3] = (vec4(1.0, -5.0, 5.0, -3.0));
	block.var[2][0][0] = (vec4(-4.0, -3.0, 4.0, -8.0));
	block.var[2][0][1] = (vec4(-2.0, 0.0, -8.0, 2.0));
	block.var[2][0][2] = (vec4(-3.0, -5.0, 3.0, -2.0));
	block.var[2][0][3] = (vec4(-9.0, -8.0, -3.0, 5.0));
	block.var[2][1][0] = (vec4(-9.0, 6.0, -6.0, 7.0));
	block.var[2][1][1] = (vec4(-8.0, 2.0, 7.0, -5.0));
	block.var[2][1][2] = (vec4(0.0, -4.0, -7.0, 6.0));
	block.var[2][1][3] = (vec4(0.0, 0.0, 4.0, -5.0));
	block.var[2][2][0] = (vec4(-1.0, -9.0, -7.0, 5.0));
	block.var[2][2][1] = (vec4(3.0, 9.0, -8.0, -6.0));
	block.var[2][2][2] = (vec4(-3.0, 6.0, -9.0, 4.0));
	block.var[2][2][3] = (vec4(6.0, -6.0, -6.0, -2.0));
	block.var[3][0][0] = (vec4(-8.0, -3.0, -8.0, 5.0));
	block.var[3][0][1] = (vec4(6.0, -9.0, -7.0, -7.0));
	block.var[3][0][2] = (vec4(6.0, 1.0, 0.0, -3.0));
	block.var[3][0][3] = (vec4(4.0, 1.0, -7.0, 4.0));
	block.var[3][1][0] = (vec4(6.0, 4.0, 3.0, -5.0));
	block.var[3][1][1] = (vec4(-8.0, 0.0, -2.0, 7.0));
	block.var[3][1][2] = (vec4(5.0, -1.0, -3.0, -2.0));
	block.var[3][1][3] = (vec4(-6.0, -9.0, -3.0, 5.0));
	block.var[3][2][0] = (vec4(8.0, 7.0, -4.0, 1.0));
	block.var[3][2][1] = (vec4(6.0, -9.0, 8.0, 3.0));
	block.var[3][2][2] = (vec4(-6.0, -7.0, 7.0, -1.0));
	block.var[3][2][3] = (vec4(-7.0, 6.0, -5.0, 9.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0][0], mat3x4(-6.0, 2.0, 7.0, -8.0, 9.0, -6.0, 1.0, 9.0, -9.0, 1.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1], mat3x4(-8.0, -5.0, -5.0, 5.0, -5.0, -3.0, 2.0, 1.0, 2.0, 8.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2], mat3x4(3.0, 7.0, -5.0, 5.0, 6.0, -3.0, 8.0, -1.0, -1.0, -1.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0], mat3x4(3.0, 2.0, 8.0, 7.0, 5.0, 9.0, -1.0, -1.0, -5.0, -3.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1], mat3x4(4.0, -6.0, -8.0, 7.0, 0.0, -7.0, -9.0, 1.0, 0.0, -4.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2], mat3x4(7.0, 9.0, 6.0, 6.0, 5.0, -9.0, 3.0, -1.0, -1.0, 4.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0], mat3x4(2.0, 6.0, -1.0, 0.0, 8.0, 9.0, 6.0, 2.0, 2.0, 5.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1], mat3x4(2.0, 6.0, 8.0, 7.0, -7.0, 9.0, 5.0, 7.0, 1.0, 1.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2], mat3x4(1.0, 9.0, -1.0, -4.0, 9.0, -9.0, 9.0, 3.0, -1.0, -5.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0], mat3x4(-1.0, 0.0, -4.0, -5.0, -8.0, 9.0, 5.0, -7.0, 6.0, -6.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1], mat3x4(-8.0, -3.0, -4.0, -7.0, 2.0, 4.0, 4.0, -8.0, 0.0, -9.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][2], mat3x4(-5.0, -2.0, 0.0, -8.0, -7.0, -1.0, -3.0, 0.0, 4.0, 9.0, 0.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat3x4(0.0, 0.0, -5.0, -3.0, -2.0, -8.0, -3.0, 0.0, -6.0, -6.0, 8.0, 5.0));
	block.var[0][1] = (mat3x4(8.0, 1.0, 7.0, 4.0, -7.0, -3.0, -4.0, 0.0, 6.0, 9.0, -2.0, 5.0));
	block.var[0][2] = (mat3x4(8.0, -2.0, 7.0, 3.0, -8.0, -8.0, 5.0, -7.0, -9.0, 1.0, 9.0, -3.0));
	block.var[1][0] = (mat3x4(-9.0, 4.0, -1.0, 0.0, 4.0, -3.0, -5.0, -7.0, 1.0, 2.0, -2.0, -6.0));
	block.var[1][1] = (mat3x4(3.0, 1.0, -1.0, -3.0, 5.0, 8.0, 1.0, 3.0, -9.0, 1.0, -2.0, 9.0));
	block.var[1][2] = (mat3x4(1.0, 5.0, 2.0, 4.0, 6.0, 3.0, 7.0, 0.0, 8.0, 8.0, -2.0, 7.0));
	block.var[2][0] = (mat3x4(-2.0, -7.0, -5.0, -7.0, -6.0, 8.0, 4.0, -6.0, 5.0, 6.0, -5.0, 8.0));
	block.var[2][1] = (mat3x4(-8.0, 8.0, -7.0, -4.0, -6.0, -9.0, 3.0, -6.0, -1.0, -2.0, -2.0, 2.0));
	block.var[2][2] = (mat3x4(6.0, -1.0, -9.0, -5.0, -4.0, 3.0, -7.0, 1.0, 2.0, 1.0, -1.0, 6.0));
	block.var[3][0] = (mat3x4(5.0, 5.0, -9.0, -4.0, 9.0, -4.0, 7.0, -6.0, 2.0, 1.0, -6.0, 1.0));
	block.var[3][1] = (mat3x4(-4.0, 7.0, -5.0, 0.0, 4.0, 0.0, 0.0, 0.0, 4.0, 0.0, -1.0, -9.0));
	block.var[3][2] = (mat3x4(-1.0, 3.0, -6.0, 6.0, 3.0, 8.0, 4.0, 4.0, 7.0, 8.0, 1.0, 7.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(3.0, -4.0, 9.0, -7.0, -8.0, 2.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(-7.0, 8.0, -9.0, 4.0, 4.0, -9.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][2], mat2x4(9.0, -5.0, -4.0, -8.0, -6.0, -2.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(-8.0, 0.0, 0.0, 1.0, 3.0, -4.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(0.0, -3.0, 4.0, -6.0, 4.0, 7.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][2], mat2x4(1.0, -8.0, 0.0, 1.0, -3.0, 4.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(-5.0, -8.0, -7.0, 8.0, 5.0, 9.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(1.0, 4.0, -4.0, -1.0, 0.0, 1.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][2], mat2x4(4.0, 4.0, -2.0, 5.0, 0.0, -2.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(8.0, -3.0, 0.0, -2.0, -4.0, 5.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(0.0, -9.0, 7.0, 0.0, -5.0, 7.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][2], mat2x4(-7.0, -9.0, -7.0, 4.0, -9.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(-2.0, 5.0, -7.0, -1.0, 7.0, 6.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(-9.0, -7.0, 2.0, 8.0, -5.0, -1.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][2], mat2x4(-5.0, -4.0, -4.0, 5.0, -5.0, 5.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(5.0, -4.0, -9.0, 2.0, -4.0, 7.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(4.0, -6.0, 7.0, 5.0, 5.0, -1.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][2], mat2x4(0.0, -2.0, -6.0, 8.0, -4.0, -8.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][0], mat2x4(-9.0, 2.0, 9.0, -6.0, -9.0, -5.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][1], mat2x4(-5.0, 2.0, -4.0, 4.0, 3.0, -4.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][2], mat2x4(6.0, 1.0, 5.0, -1.0, -5.0, 0.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][0], mat2x4(8.0, 6.0, 0.0, -2.0, -7.0, -9.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][1], mat2x4(-7.0, -4.0, 9.0, 0.0, 7.0, 9.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][2], mat2x4(-3.0, -7.0, -1.0, -5.0, 1.0, 5.0, 9.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2x4(5.0, -1.0, 5.0, 1.0, 1.0, -4.0, 0.0, -8.0));
	block.var[0][0][1] = (mat2x4(-3.0, 9.0, -8.0, -9.0, 1.0, 9.0, 1.0, -2.0));
	block.var[0][0][2] = (mat2x4(-6.0, 3.0, -3.0, -7.0, -6.0, 0.0, 9.0, -7.0));
	block.var[0][1][0] = (mat2x4(4.0, 9.0, -8.0, 5.0, 6.0, -1.0, 4.0, -3.0));
	block.var[0][1][1] = (mat2x4(3.0, -1.0, -8.0, 3.0, 0.0, 1.0, -4.0, -1.0));
	block.var[0][1][2] = (mat2x4(-3.0, 4.0, 1.0, 2.0, 2.0, 0.0, 7.0, 2.0));
	block.var[1][0][0] = (mat2x4(-3.0, -9.0, -8.0, 2.0, 1.0, -9.0, 2.0, -1.0));
	block.var[1][0][1] = (mat2x4(-3.0, -3.0, -6.0, -9.0, 2.0, -8.0, -1.0, 3.0));
	block.var[1][0][2] = (mat2x4(4.0, 9.0, -6.0, -4.0, 7.0, 7.0, -4.0, -4.0));
	block.var[1][1][0] = (mat2x4(6.0, 1.0, -2.0, 4.0, 9.0, -2.0, -7.0, 5.0));
	block.var[1][1][1] = (mat2x4(-8.0, 2.0, -4.0, 4.0, -8.0, 1.0, -7.0, -7.0));
	block.var[1][1][2] = (mat2x4(1.0, 7.0, 2.0, 3.0, -2.0, 1.0, 0.0, 7.0));
	block.var[2][0][0] = (mat2x4(-6.0, 9.0, -3.0, 5.0, -4.0, 8.0, 0.0, 1.0));
	block.var[2][0][1] = (mat2x4(8.0, -6.0, 9.0, 7.0, -4.0, -8.0, 6.0, 2.0));
	block.var[2][0][2] = (mat2x4(-1.0, 2.0, 9.0, -2.0, 4.0, -9.0, -7.0, 4.0));
	block.var[2][1][0] = (mat2x4(-5.0, 6.0, 0.0, 7.0, -5.0, 2.0, 0.0, -5.0));
	block.var[2][1][1] = (mat2x4(-7.0, 4.0, 4.0, 2.0, -9.0, 5.0, -7.0, -7.0));
	block.var[2][1][2] = (mat2x4(0.0, -2.0, -7.0, -5.0, 1.0, 4.0, 6.0, -3.0));
	block.var[3][0][0] = (mat2x4(2.0, 0.0, -8.0, -1.0, -5.0, 5.0, 6.0, 0.0));
	block.var[3][0][1] = (mat2x4(5.0, -8.0, 8.0, 1.0, -4.0, -3.0, 5.0, 6.0));
	block.var[3][0][2] = (mat2x4(4.0, 9.0, -7.0, -4.0, -4.0, -7.0, 9.0, 4.0));
	block.var[3][1][0] = (mat2x4(4.0, 7.0, -8.0, -8.0, -4.0, -9.0, 3.0, -5.0));
	block.var[3][1][1] = (mat2x4(-7.0, -3.0, -1.0, -4.0, 2.0, -8.0, -5.0, -3.0));
	block.var[3][1][2] = (mat2x4(-7.0, 7.0, -5.0, 8.0, -1.0, 1.0, 7.0, 5.0));
}
#version 450
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
	int8_t var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(block.var[0][0][0]), 4294967292) && allOk;
	allOk = compare_int8_t(int(block.var[0][0][1]), 3) && allOk;
	allOk = compare_int8_t(int(block.var[0][0][2]), 3) && allOk;
	allOk = compare_int8_t(int(block.var[0][1][0]), 4294967292) && allOk;
	allOk = compare_int8_t(int(block.var[0][1][1]), 4294967291) && allOk;
	allOk = compare_int8_t(int(block.var[0][1][2]), 7) && allOk;
	allOk = compare_int8_t(int(block.var[1][0][0]), 1) && allOk;
	allOk = compare_int8_t(int(block.var[1][0][1]), 6) && allOk;
	allOk = compare_int8_t(int(block.var[1][0][2]), 8) && allOk;
	allOk = compare_int8_t(int(block.var[1][1][0]), 4294967293) && allOk;
	allOk = compare_int8_t(int(block.var[1][1][1]), 8) && allOk;
	allOk = compare_int8_t(int(block.var[1][1][2]), 4294967292) && allOk;
	allOk = compare_int8_t(int(block.var[2][0][0]), 5) && allOk;
	allOk = compare_int8_t(int(block.var[2][0][1]), 2) && allOk;
	allOk = compare_int8_t(int(block.var[2][0][2]), 0) && allOk;
	allOk = compare_int8_t(int(block.var[2][1][0]), 4294967291) && allOk;
	allOk = compare_int8_t(int(block.var[2][1][1]), 9) && allOk;
	allOk = compare_int8_t(int(block.var[2][1][2]), 4294967289) && allOk;
	allOk = compare_int8_t(int(block.var[3][0][0]), 4294967292) && allOk;
	allOk = compare_int8_t(int(block.var[3][0][1]), 4294967287) && allOk;
	allOk = compare_int8_t(int(block.var[3][0][2]), 4294967289) && allOk;
	allOk = compare_int8_t(int(block.var[3][1][0]), 6) && allOk;
	allOk = compare_int8_t(int(block.var[3][1][1]), 7) && allOk;
	allOk = compare_int8_t(int(block.var[3][1][2]), 8) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = int8_t(4294967290);
	block.var[0][0][1] = int8_t(4294967294);
	block.var[0][0][2] = int8_t(3);
	block.var[0][1][0] = int8_t(0);
	block.var[0][1][1] = int8_t(4294967289);
	block.var[0][1][2] = int8_t(1);
	block.var[1][0][0] = int8_t(4294967288);
	block.var[1][0][1] = int8_t(1);
	block.var[1][0][2] = int8_t(2);
	block.var[1][1][0] = int8_t(7);
	block.var[1][1][1] = int8_t(4294967287);
	block.var[1][1][2] = int8_t(4294967289);
	block.var[2][0][0] = int8_t(4294967288);
	block.var[2][0][1] = int8_t(4294967294);
	block.var[2][0][2] = int8_t(7);
	block.var[2][1][0] = int8_t(6);
	block.var[2][1][1] = int8_t(1);
	block.var[2][1][2] = int8_t(4294967293);
	block.var[3][0][0] = int8_t(9);
	block.var[3][0][1] = int8_t(0);
	block.var[3][0][2] = int8_t(4294967292);
	block.var[3][1][0] = int8_t(2);
	block.var[3][1][1] = int8_t(5);
	block.var[3][1][2] = int8_t(4294967289);
}
#version 450
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
	allOk = compare_mat3x4(block.var[0][0][0], mat3x4(-3.0, -9.0, 3.0, -6.0, -7.0, 8.0, -8.0, -5.0, 9.0, -8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][1], mat3x4(8.0, -4.0, 9.0, 7.0, -8.0, 9.0, -1.0, 0.0, 9.0, 7.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][2], mat3x4(-3.0, -6.0, -7.0, 8.0, 1.0, 5.0, 1.0, -1.0, 8.0, -9.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(6.0, 7.0, 9.0, 7.0, 0.0, 8.0, -1.0, 0.0, 6.0, -3.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(7.0, -7.0, 1.0, 0.0, -9.0, 2.0, -3.0, 7.0, 8.0, -6.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][2], mat3x4(0.0, 8.0, -8.0, -9.0, 5.0, -4.0, -5.0, 3.0, 4.0, 3.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(-4.0, -4.0, 2.0, -2.0, 1.0, 3.0, -5.0, -4.0, 9.0, 6.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(9.0, 3.0, 9.0, -8.0, 9.0, -4.0, -4.0, 7.0, -1.0, -7.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][2], mat3x4(-5.0, -4.0, -9.0, 1.0, 6.0, 6.0, 2.0, 1.0, 0.0, 1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(9.0, -4.0, -6.0, 0.0, 0.0, -9.0, 6.0, 4.0, -6.0, -3.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(5.0, 2.0, -1.0, 1.0, 1.0, 7.0, 0.0, 8.0, 9.0, 0.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][2], mat3x4(-5.0, 1.0, 4.0, 5.0, 5.0, 0.0, 7.0, -5.0, 6.0, -2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(6.0, 0.0, -7.0, 9.0, -8.0, 6.0, 0.0, 9.0, -1.0, -9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(1.0, 9.0, -9.0, -8.0, 0.0, 2.0, 9.0, 6.0, 3.0, 9.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][2], mat3x4(-7.0, -2.0, -1.0, -9.0, -9.0, 6.0, -6.0, -9.0, -4.0, -4.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(-2.0, -2.0, 7.0, -9.0, 3.0, 6.0, -5.0, -8.0, -3.0, -3.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(-9.0, 0.0, -2.0, -3.0, 4.0, -7.0, 8.0, -2.0, -7.0, -1.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][2], mat3x4(6.0, 7.0, 1.0, 5.0, 4.0, 9.0, 5.0, 4.0, 9.0, -4.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][0], mat3x4(9.0, 1.0, -6.0, 9.0, -3.0, -9.0, -2.0, -9.0, -7.0, -4.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][1], mat3x4(-3.0, 5.0, 0.0, -7.0, 9.0, -8.0, -9.0, -4.0, -6.0, 7.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][2], mat3x4(4.0, 4.0, 1.0, -1.0, 9.0, -6.0, -6.0, -4.0, 4.0, 8.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][0], mat3x4(1.0, 0.0, -7.0, -4.0, -3.0, 3.0, -7.0, 4.0, 1.0, 0.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][1], mat3x4(-1.0, 9.0, 4.0, -7.0, -2.0, 8.0, 8.0, 5.0, 3.0, -7.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][2], mat3x4(-8.0, -3.0, 1.0, -8.0, -6.0, 9.0, 2.0, 4.0, 4.0, 1.0, -1.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(-6.0, -4.0, 2.0, -3.0));
	block.var[0][0][0][1] = (vec4(-2.0, 4.0, -5.0, 8.0));
	block.var[0][0][0][2] = (vec4(-4.0, 6.0, -9.0, -9.0));
	block.var[0][0][1][0] = (vec4(0.0, 6.0, 0.0, 6.0));
	block.var[0][0][1][1] = (vec4(5.0, 2.0, 6.0, 6.0));
	block.var[0][0][1][2] = (vec4(-7.0, -6.0, -8.0, 0.0));
	block.var[0][0][2][0] = (vec4(3.0, -3.0, 6.0, -2.0));
	block.var[0][0][2][1] = (vec4(-8.0, -5.0, -5.0, 1.0));
	block.var[0][0][2][2] = (vec4(7.0, -8.0, -3.0, -2.0));
	block.var[0][1][0][0] = (vec4(6.0, 2.0, 8.0, -5.0));
	block.var[0][1][0][1] = (vec4(9.0, 5.0, 9.0, -1.0));
	block.var[0][1][0][2] = (vec4(-2.0, -5.0, -6.0, -8.0));
	block.var[0][1][1][0] = (vec4(0.0, -4.0, 7.0, 1.0));
	block.var[0][1][1][1] = (vec4(4.0, 1.0, 9.0, 9.0));
	block.var[0][1][1][2] = (vec4(-9.0, -5.0, 3.0, 8.0));
	block.var[0][1][2][0] = (vec4(4.0, -1.0, -2.0, 2.0));
	block.var[0][1][2][1] = (vec4(-5.0, 4.0, -2.0, -4.0));
	block.var[0][1][2][2] = (vec4(8.0, -7.0, -1.0, -9.0));
	block.var[1][0][0][0] = (vec4(6.0, 4.0, -5.0, 8.0));
	block.var[1][0][0][1] = (vec4(-5.0, -8.0, -9.0, -8.0));
	block.var[1][0][0][2] = (vec4(9.0, 0.0, 3.0, -4.0));
	block.var[1][0][1][0] = (vec4(0.0, -6.0, 5.0, 1.0));
	block.var[1][0][1][1] = (vec4(9.0, -8.0, -1.0, -7.0));
	block.var[1][0][1][2] = (vec4(1.0, 2.0, 0.0, -9.0));
	block.var[1][0][2][0] = (vec4(2.0, 0.0, 5.0, -4.0));
	block.var[1][0][2][1] = (vec4(-7.0, 0.0, 3.0, 4.0));
	block.var[1][0][2][2] = (vec4(4.0, 5.0, 2.0, -3.0));
	block.var[1][1][0][0] = (vec4(8.0, 5.0, 3.0, 6.0));
	block.var[1][1][0][1] = (vec4(0.0, 6.0, 0.0, 2.0));
	block.var[1][1][0][2] = (vec4(-1.0, -5.0, -6.0, -4.0));
	block.var[1][1][1][0] = (vec4(-3.0, -5.0, -4.0, -4.0));
	block.var[1][1][1][1] = (vec4(-8.0, -8.0, 1.0, 7.0));
	block.var[1][1][1][2] = (vec4(-6.0, -3.0, -7.0, 1.0));
	block.var[1][1][2][0] = (vec4(-5.0, 5.0, 0.0, 1.0));
	block.var[1][1][2][1] = (vec4(6.0, 2.0, 5.0, 5.0));
	block.var[1][1][2][2] = (vec4(5.0, -1.0, -7.0, -1.0));
	block.var[2][0][0][0] = (vec4(0.0, -7.0, 3.0, -8.0));
	block.var[2][0][0][1] = (vec4(3.0, -2.0, -3.0, 1.0));
	block.var[2][0][0][2] = (vec4(-5.0, -9.0, -7.0, -7.0));
	block.var[2][0][1][0] = (vec4(-2.0, -9.0, -7.0, -8.0));
	block.var[2][0][1][1] = (vec4(7.0, -6.0, -4.0, 6.0));
	block.var[2][0][1][2] = (vec4(-5.0, -4.0, -8.0, -4.0));
	block.var[2][0][2][0] = (vec4(9.0, -2.0, 7.0, -9.0));
	block.var[2][0][2][1] = (vec4(-6.0, -4.0, 5.0, -5.0));
	block.var[2][0][2][2] = (vec4(-5.0, 7.0, 6.0, 6.0));
	block.var[2][1][0][0] = (vec4(1.0, -1.0, -4.0, 2.0));
	block.var[2][1][0][1] = (vec4(5.0, 8.0, 5.0, -9.0));
	block.var[2][1][0][2] = (vec4(7.0, -9.0, 0.0, -3.0));
	block.var[2][1][1][0] = (vec4(-6.0, 6.0, -6.0, -5.0));
	block.var[2][1][1][1] = (vec4(5.0, 3.0, 4.0, 8.0));
	block.var[2][1][1][2] = (vec4(7.0, 0.0, -5.0, -6.0));
	block.var[2][1][2][0] = (vec4(5.0, 0.0, 8.0, 4.0));
	block.var[2][1][2][1] = (vec4(3.0, -1.0, -7.0, 0.0));
	block.var[2][1][2][2] = (vec4(-1.0, 6.0, -6.0, 1.0));
	block.var[3][0][0][0] = (vec4(0.0, 9.0, -3.0, -9.0));
	block.var[3][0][0][1] = (vec4(-7.0, 6.0, -7.0, -1.0));
	block.var[3][0][0][2] = (vec4(-6.0, -6.0, 2.0, 8.0));
	block.var[3][0][1][0] = (vec4(-6.0, 6.0, -8.0, -3.0));
	block.var[3][0][1][1] = (vec4(2.0, 0.0, 0.0, -2.0));
	block.var[3][0][1][2] = (vec4(-9.0, -3.0, 2.0, 2.0));
	block.var[3][0][2][0] = (vec4(-7.0, -4.0, 9.0, 7.0));
	block.var[3][0][2][1] = (vec4(-3.0, 1.0, -7.0, 9.0));
	block.var[3][0][2][2] = (vec4(-9.0, -8.0, 0.0, 8.0));
	block.var[3][1][0][0] = (vec4(0.0, 8.0, 0.0, 9.0));
	block.var[3][1][0][1] = (vec4(-6.0, 8.0, -5.0, -1.0));
	block.var[3][1][0][2] = (vec4(0.0, 6.0, -9.0, 9.0));
	block.var[3][1][1][0] = (vec4(8.0, -2.0, -5.0, 0.0));
	block.var[3][1][1][1] = (vec4(1.0, 4.0, -3.0, -6.0));
	block.var[3][1][1][2] = (vec4(2.0, -2.0, -2.0, 3.0));
	block.var[3][1][2][0] = (vec4(-5.0, -4.0, -6.0, 2.0));
	block.var[3][1][2][1] = (vec4(-6.0, 0.0, 1.0, 9.0));
	block.var[3][1][2][2] = (vec4(2.0, 5.0, -8.0, 5.0));
}
#version 450
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
	u8vec3 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(block.var[0][0][0]), uvec3(4u, 3u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[0][0][1]), uvec3(1u, 4u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[0][0][2]), uvec3(8u, 6u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[0][1][0]), uvec3(8u, 6u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[0][1][1]), uvec3(6u, 7u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[0][1][2]), uvec3(3u, 9u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[1][0][0]), uvec3(6u, 4u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[1][0][1]), uvec3(5u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[1][0][2]), uvec3(1u, 4u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[1][1][0]), uvec3(1u, 1u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[1][1][1]), uvec3(1u, 9u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[1][1][2]), uvec3(9u, 3u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[2][0][0]), uvec3(3u, 8u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[2][0][1]), uvec3(6u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[2][0][2]), uvec3(4u, 0u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[2][1][0]), uvec3(5u, 0u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[2][1][1]), uvec3(1u, 1u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[2][1][2]), uvec3(7u, 6u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[3][0][0]), uvec3(9u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[3][0][1]), uvec3(0u, 2u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[3][0][2]), uvec3(9u, 0u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[3][1][0]), uvec3(4u, 9u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[3][1][1]), uvec3(3u, 8u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[3][1][2]), uvec3(7u, 5u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = u8vec3(uvec3(4u, 5u, 9u));
	block.var[0][0][1] = u8vec3(uvec3(6u, 9u, 4u));
	block.var[0][0][2] = u8vec3(uvec3(7u, 1u, 5u));
	block.var[0][1][0] = u8vec3(uvec3(5u, 7u, 3u));
	block.var[0][1][1] = u8vec3(uvec3(9u, 8u, 1u));
	block.var[0][1][2] = u8vec3(uvec3(6u, 2u, 7u));
	block.var[1][0][0] = u8vec3(uvec3(1u, 7u, 9u));
	block.var[1][0][1] = u8vec3(uvec3(3u, 4u, 3u));
	block.var[1][0][2] = u8vec3(uvec3(5u, 7u, 4u));
	block.var[1][1][0] = u8vec3(uvec3(0u, 2u, 7u));
	block.var[1][1][1] = u8vec3(uvec3(4u, 8u, 8u));
	block.var[1][1][2] = u8vec3(uvec3(6u, 1u, 2u));
	block.var[2][0][0] = u8vec3(uvec3(5u, 4u, 7u));
	block.var[2][0][1] = u8vec3(uvec3(0u, 0u, 5u));
	block.var[2][0][2] = u8vec3(uvec3(2u, 5u, 5u));
	block.var[2][1][0] = u8vec3(uvec3(3u, 6u, 6u));
	block.var[2][1][1] = u8vec3(uvec3(2u, 7u, 9u));
	block.var[2][1][2] = u8vec3(uvec3(4u, 0u, 2u));
	block.var[3][0][0] = u8vec3(uvec3(5u, 9u, 6u));
	block.var[3][0][1] = u8vec3(uvec3(9u, 7u, 3u));
	block.var[3][0][2] = u8vec3(uvec3(9u, 4u, 9u));
	block.var[3][1][0] = u8vec3(uvec3(1u, 5u, 4u));
	block.var[3][1][1] = u8vec3(uvec3(3u, 7u, 7u));
	block.var[3][1][2] = u8vec3(uvec3(3u, 8u, 8u));
}
#version 450
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
	bool var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((block.padding), false) && allOk;
	allOk = compare_bool((block.var[0][0][0]), true) && allOk;
	allOk = compare_bool((block.var[0][0][1]), true) && allOk;
	allOk = compare_bool((block.var[0][0][2]), false) && allOk;
	allOk = compare_bool((block.var[0][1][0]), false) && allOk;
	allOk = compare_bool((block.var[0][1][1]), true) && allOk;
	allOk = compare_bool((block.var[0][1][2]), true) && allOk;
	allOk = compare_bool((block.var[1][0][0]), false) && allOk;
	allOk = compare_bool((block.var[1][0][1]), true) && allOk;
	allOk = compare_bool((block.var[1][0][2]), true) && allOk;
	allOk = compare_bool((block.var[1][1][0]), false) && allOk;
	allOk = compare_bool((block.var[1][1][1]), true) && allOk;
	allOk = compare_bool((block.var[1][1][2]), false) && allOk;
	allOk = compare_bool((block.var[2][0][0]), false) && allOk;
	allOk = compare_bool((block.var[2][0][1]), false) && allOk;
	allOk = compare_bool((block.var[2][0][2]), false) && allOk;
	allOk = compare_bool((block.var[2][1][0]), false) && allOk;
	allOk = compare_bool((block.var[2][1][1]), false) && allOk;
	allOk = compare_bool((block.var[2][1][2]), true) && allOk;
	allOk = compare_bool((block.var[3][0][0]), false) && allOk;
	allOk = compare_bool((block.var[3][0][1]), true) && allOk;
	allOk = compare_bool((block.var[3][0][2]), true) && allOk;
	allOk = compare_bool((block.var[3][1][0]), false) && allOk;
	allOk = compare_bool((block.var[3][1][1]), false) && allOk;
	allOk = compare_bool((block.var[3][1][2]), true) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (false);
	block.var[0][0][0] = (false);
	block.var[0][0][1] = (true);
	block.var[0][0][2] = (true);
	block.var[0][1][0] = (false);
	block.var[0][1][1] = (true);
	block.var[0][1][2] = (false);
	block.var[1][0][0] = (false);
	block.var[1][0][1] = (false);
	block.var[1][0][2] = (true);
	block.var[1][1][0] = (true);
	block.var[1][1][1] = (false);
	block.var[1][1][2] = (true);
	block.var[2][0][0] = (true);
	block.var[2][0][1] = (true);
	block.var[2][0][2] = (true);
	block.var[2][1][0] = (true);
	block.var[2][1][1] = (true);
	block.var[2][1][2] = (true);
	block.var[3][0][0] = (false);
	block.var[3][0][1] = (false);
	block.var[3][0][2] = (false);
	block.var[3][1][0] = (true);
	block.var[3][1][1] = (false);
	block.var[3][1][2] = (true);
}
#version 450
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

struct S
{
	highp ivec3 a;
	mediump mat3 b[4];
	highp vec4 c;
};
layout(std430, buffer_reference) buffer Block
{
	S s;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((block[0].s.a), ivec3(-9, 2, 5)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(1.0, 5.0, 0.0, -2.0, -5.0, -5.0, -1.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(-8.0, -9.0, -8.0, -2.0, -9.0, 5.0, 0.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(0.0, -2.0, 3.0, 5.0, -1.0, -2.0, -1.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(-8.0, 1.0, 5.0, 3.0, -1.0, -3.0, 5.0, -1.0, 9.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(-1.0, 6.0, -6.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(5, 2, 0)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(8.0, -8.0, -8.0, 8.0, 4.0, 2.0, -7.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(-7.0, -4.0, 5.0, -5.0, 8.0, -4.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(5.0, -3.0, -9.0, 7.0, 0.0, 0.0, 2.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(-9.0, -1.0, 9.0, -9.0, -1.0, 2.0, -7.0, -8.0, -2.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(-4.0, -2.0, -3.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(-3, -9, 1)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(2.0, 6.0, 3.0, -4.0, -5.0, 3.0, -1.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(0.0, 3.0, 3.0, 5.0, -1.0, -2.0, -6.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(8.0, -6.0, 3.0, 0.0, -9.0, 2.0, -9.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(-4.0, 0.0, -6.0, 0.0, 6.0, -3.0, -6.0, 8.0, -2.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(-6.0, 2.0, 1.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (ivec3(-3, -4, 7));
	block[0].s.b[0] = (mat3(5.0, 3.0, -9.0, -1.0, 5.0, 9.0, -5.0, 5.0, 7.0));
	block[0].s.b[1] = (mat3(-1.0, -8.0, -6.0, -1.0, 4.0, 9.0, -7.0, -5.0, -1.0));
	block[0].s.b[2] = (mat3(5.0, 9.0, -8.0, 6.0, -9.0, 8.0, 2.0, -2.0, -9.0));
	block[0].s.b[3] = (mat3(-2.0, 1.0, 2.0, -1.0, 5.0, -4.0, 6.0, 8.0, -8.0));
	block[0].s.c = (vec4(4.0, 0.0, 5.0, 3.0));
	block[1].s.a = (ivec3(3, 7, -2));
	block[1].s.b[0] = (mat3(-3.0, -5.0, -8.0, 9.0, 4.0, -6.0, 1.0, -4.0, -2.0));
	block[1].s.b[1] = (mat3(9.0, 6.0, -3.0, -7.0, 7.0, 5.0, 2.0, -7.0, 6.0));
	block[1].s.b[2] = (mat3(1.0, 3.0, 6.0, -6.0, 5.0, -6.0, 3.0, 5.0, 5.0));
	block[1].s.b[3] = (mat3(4.0, -7.0, -5.0, 6.0, -2.0, 8.0, -4.0, 1.0, 7.0));
	block[1].s.c = (vec4(-9.0, 9.0, 8.0, -9.0));
	block[2].s.a = (ivec3(6, 0, 0));
	block[2].s.b[0] = (mat3(7.0, 1.0, -9.0, -1.0, -3.0, 1.0, 9.0, 0.0, 9.0));
	block[2].s.b[1] = (mat3(7.0, -1.0, 0.0, -2.0, -1.0, -5.0, -8.0, 2.0, -2.0));
	block[2].s.b[2] = (mat3(2.0, 3.0, 6.0, 0.0, 5.0, -8.0, -1.0, 8.0, 5.0));
	block[2].s.b[3] = (mat3(-2.0, -1.0, -8.0, 6.0, 0.0, 9.0, -5.0, -6.0, 8.0));
	block[2].s.c = (vec4(-2.0, 4.0, -6.0, -4.0));
}
#version 450
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
	allOk = compare_ivec3((block.s.a), ivec3(6, -9, 8)) && allOk;
	allOk = compare_mat3(block.s.b[0], mat3(-1.0, -3.0, 2.0, -9.0, 4.0, -3.0, 9.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3(block.s.b[1], mat3(2.0, -8.0, -6.0, -3.0, 6.0, 2.0, 4.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat3(block.s.b[2], mat3(0.0, -9.0, 1.0, -2.0, 4.0, -9.0, 9.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat3(block.s.b[3], mat3(9.0, 7.0, 3.0, -4.0, -7.0, 8.0, -3.0, 3.0, 0.0)) && allOk;
	allOk = compare_vec4((block.s.c), vec4(1.0, -6.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3(block.t.a, mat3(-9.0, -3.0, 1.0, 2.0, 4.0, 1.0, -6.0, 6.0, 1.0)) && allOk;
	allOk = compare_ivec3((block.t.b.a), ivec3(0, -2, -9)) && allOk;
	allOk = compare_mat3(block.t.b.b[0], mat3(-8.0, -2.0, 3.0, 1.0, -5.0, -3.0, -2.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3(block.t.b.b[1], mat3(0.0, 7.0, 0.0, -4.0, 8.0, -5.0, 5.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat3(block.t.b.b[2], mat3(-3.0, -6.0, 1.0, 1.0, 1.0, 8.0, 2.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat3(block.t.b.b[3], mat3(-1.0, 7.0, -3.0, -2.0, 1.0, -3.0, 1.0, 9.0, -6.0)) && allOk;
	allOk = compare_vec4((block.t.b.c), vec4(-9.0, -2.0, -9.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.t.a = (mat3(7.0, -8.0, 5.0, 2.0, -1.0, -3.0, -6.0, 0.0, -5.0));
	block.t.b.a = (ivec3(8, 2, -3));
	block.t.b.b[0] = (mat3(-7.0, 0.0, 2.0, 8.0, 7.0, -6.0, -7.0, 2.0, -1.0));
	block.t.b.b[1] = (mat3(5.0, 3.0, -4.0, 0.0, 8.0, -7.0, -2.0, -4.0, 0.0));
	block.t.b.b[2] = (mat3(5.0, -6.0, -4.0, 4.0, 9.0, 4.0, 1.0, -7.0, -5.0));
	block.t.b.b[3] = (mat3(9.0, -9.0, 8.0, -8.0, 3.0, 9.0, 2.0, 2.0, 6.0));
	block.t.b.c = (vec4(0.0, -4.0, 4.0, 9.0));
	block.u = (4u);
}
#version 450
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
layout(std430, buffer_reference) buffer Block
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
	allOk = compare_ivec3((block.s[0][0].a), ivec3(6, -3, 7)) && allOk;
	allOk = compare_vec4((block.s[0][0].c), vec4(-2.0, -2.0, -2.0, 1.0)) && allOk;
	allOk = compare_ivec3((block.s[0][1].a), ivec3(9, 1, -6)) && allOk;
	allOk = compare_vec4((block.s[0][1].c), vec4(-1.0, 6.0, -1.0, -3.0)) && allOk;
	allOk = compare_ivec3((block.s[1][0].a), ivec3(5, -8, 9)) && allOk;
	allOk = compare_vec4((block.s[1][0].c), vec4(-4.0, 7.0, 5.0, -8.0)) && allOk;
	allOk = compare_ivec3((block.s[1][1].a), ivec3(4, -9, 3)) && allOk;
	allOk = compare_vec4((block.s[1][1].c), vec4(-4.0, -8.0, -7.0, -8.0)) && allOk;
	allOk = compare_ivec3((block.s[2][0].a), ivec3(8, 2, -7)) && allOk;
	allOk = compare_vec4((block.s[2][0].c), vec4(-8.0, -3.0, 0.0, -4.0)) && allOk;
	allOk = compare_ivec3((block.s[2][1].a), ivec3(-7, -4, -4)) && allOk;
	allOk = compare_vec4((block.s[2][1].c), vec4(-6.0, 3.0, -4.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.v = (vec4(-9.0, 6.0, -6.0, -2.0));
	block.s[0][0].a = (ivec3(4, -5, -9));
	block.s[0][0].c = (vec4(-7.0, 9.0, 9.0, -1.0));
	block.s[0][1].a = (ivec3(-1, -1, -7));
	block.s[0][1].c = (vec4(-6.0, 1.0, -5.0, 9.0));
	block.s[1][0].a = (ivec3(-7, -1, 2));
	block.s[1][0].c = (vec4(-4.0, 4.0, -4.0, 9.0));
	block.s[1][1].a = (ivec3(-3, 6, -5));
	block.s[1][1].c = (vec4(1.0, 4.0, -5.0, -1.0));
	block.s[2][0].a = (ivec3(2, -5, 0));
	block.s[2][0].c = (vec4(8.0, 0.0, -8.0, -7.0));
	block.s[2][1].a = (ivec3(4, -9, 3));
	block.s[2][1].c = (vec4(8.0, -9.0, 7.0, -4.0));
}
#version 450
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
	allOk = compare_uint((block.u), 0u) && allOk;
	allOk = compare_mat4x3(block.t[0].a, mat4x3(4.0, -6.0, -1.0, -7.0, -4.0, 7.0, 5.0, 5.0, -8.0, -6.0, 2.0, 6.0)) && allOk;
	allOk = compare_uvec3((block.t[0].b[0].a), uvec3(6u, 3u, 8u)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[0]), vec2(9.0, -4.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[1]), vec2(3.0, 7.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[2]), vec2(4.0, 3.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[3]), vec2(4.0, -5.0)) && allOk;
	allOk = compare_vec4((block.t[0].b[0].c), vec4(6.0, -3.0, 9.0, 7.0)) && allOk;
	allOk = compare_uvec3((block.t[0].b[1].a), uvec3(1u, 1u, 9u)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[0]), vec2(7.0, 2.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[1]), vec2(5.0, -6.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[2]), vec2(-1.0, 4.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[3]), vec2(-4.0, -9.0)) && allOk;
	allOk = compare_vec4((block.t[0].b[1].c), vec4(5.0, 6.0, -3.0, -9.0)) && allOk;
	allOk = compare_uvec3((block.t[0].b[2].a), uvec3(5u, 4u, 9u)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[0]), vec2(9.0, -7.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[1]), vec2(3.0, 3.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[2]), vec2(1.0, -7.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[3]), vec2(1.0, 1.0)) && allOk;
	allOk = compare_vec4((block.t[0].b[2].c), vec4(2.0, 9.0, -3.0, -5.0)) && allOk;
	allOk = compare_int((block.t[0].c), 7) && allOk;
	allOk = compare_mat4x3(block.t[1].a, mat4x3(3.0, -1.0, -9.0, 7.0, 1.0, 1.0, 9.0, 2.0, -5.0, 5.0, -6.0, 0.0)) && allOk;
	allOk = compare_uvec3((block.t[1].b[0].a), uvec3(8u, 4u, 5u)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[0]), vec2(7.0, 4.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[1]), vec2(-3.0, -8.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[2]), vec2(1.0, 3.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[3]), vec2(-8.0, 7.0)) && allOk;
	allOk = compare_vec4((block.t[1].b[0].c), vec4(-4.0, -3.0, -8.0, 4.0)) && allOk;
	allOk = compare_uvec3((block.t[1].b[1].a), uvec3(4u, 6u, 6u)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[0]), vec2(8.0, 0.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[1]), vec2(-4.0, -5.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[2]), vec2(5.0, 7.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[3]), vec2(-7.0, 6.0)) && allOk;
	allOk = compare_vec4((block.t[1].b[1].c), vec4(0.0, -6.0, 3.0, -6.0)) && allOk;
	allOk = compare_uvec3((block.t[1].b[2].a), uvec3(3u, 7u, 2u)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[0]), vec2(8.0, 4.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[1]), vec2(-2.0, -6.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[2]), vec2(7.0, -4.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[3]), vec2(-4.0, -1.0)) && allOk;
	allOk = compare_vec4((block.t[1].b[2].c), vec4(8.0, -5.0, -6.0, -4.0)) && allOk;
	allOk = compare_int((block.t[1].c), 5) && allOk;
	allOk = compare_mat4x3(block.t[2].a, mat4x3(-4.0, -7.0, 0.0, 2.0, -5.0, -2.0, 1.0, 2.0, -5.0, -8.0, 1.0, 7.0)) && allOk;
	allOk = compare_uvec3((block.t[2].b[0].a), uvec3(1u, 2u, 7u)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[0]), vec2(3.0, -2.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[1]), vec2(0.0, -7.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[2]), vec2(8.0, -5.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[3]), vec2(2.0, 3.0)) && allOk;
	allOk = compare_vec4((block.t[2].b[0].c), vec4(6.0, 3.0, 7.0, 2.0)) && allOk;
	allOk = compare_uvec3((block.t[2].b[1].a), uvec3(3u, 4u, 5u)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[0]), vec2(-1.0, 2.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[1]), vec2(-6.0, -5.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[2]), vec2(-4.0, 2.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[3]), vec2(7.0, -7.0)) && allOk;
	allOk = compare_vec4((block.t[2].b[1].c), vec4(7.0, -6.0, 4.0, 8.0)) && allOk;
	allOk = compare_uvec3((block.t[2].b[2].a), uvec3(7u, 2u, 9u)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[0]), vec2(9.0, 6.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[1]), vec2(5.0, -8.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[2]), vec2(-7.0, -4.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[3]), vec2(7.0, 1.0)) && allOk;
	allOk = compare_vec4((block.t[2].b[2].c), vec4(0.0, 6.0, 1.0, -9.0)) && allOk;
	allOk = compare_int((block.t[2].c), 5) && allOk;
	allOk = compare_mat4x3(block.t[3].a, mat4x3(8.0, -8.0, -6.0, -5.0, 2.0, 5.0, -6.0, 9.0, 7.0, -3.0, -8.0, 4.0)) && allOk;
	allOk = compare_uvec3((block.t[3].b[0].a), uvec3(0u, 7u, 4u)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[0]), vec2(-3.0, 1.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[1]), vec2(-1.0, 0.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[2]), vec2(6.0, -1.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[3]), vec2(9.0, 7.0)) && allOk;
	allOk = compare_vec4((block.t[3].b[0].c), vec4(-2.0, -9.0, -1.0, -6.0)) && allOk;
	allOk = compare_uvec3((block.t[3].b[1].a), uvec3(5u, 5u, 4u)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[0]), vec2(8.0, -1.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[1]), vec2(-3.0, -8.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[2]), vec2(4.0, -7.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[3]), vec2(0.0, -1.0)) && allOk;
	allOk = compare_vec4((block.t[3].b[1].c), vec4(-4.0, 2.0, 3.0, -7.0)) && allOk;
	allOk = compare_uvec3((block.t[3].b[2].a), uvec3(8u, 5u, 0u)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[0]), vec2(7.0, -4.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[1]), vec2(4.0, -7.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[2]), vec2(6.0, -5.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[3]), vec2(7.0, -4.0)) && allOk;
	allOk = compare_vec4((block.t[3].b[2].c), vec4(7.0, 5.0, 1.0, -8.0)) && allOk;
	allOk = compare_int((block.t[3].c), 9) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s.a = (uvec3(2u, 9u, 7u));
	block.s.b[0] = (vec2(-4.0, 6.0));
	block.s.b[1] = (vec2(-4.0, -7.0));
	block.s.b[2] = (vec2(-1.0, -7.0));
	block.s.b[3] = (vec2(1.0, -9.0));
	block.s.c = (vec4(-4.0, -7.0, -5.0, -4.0));
	block.u = (9u);
}
#version 450
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
	allOk = compare_float((blockA.a), 0.0) && allOk;
	allOk = compare_uint((blockB.b.a), 9u) && allOk;
	allOk = compare_mat3(blockB.b.b.a, mat3(9.0, -8.0, -7.0, -4.0, 4.0, 0.0, 9.0, 9.0, -8.0)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[0]), ivec2(1, 3)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[1]), ivec2(-5, 3)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[2]), ivec2(2, -9)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[3]), ivec2(7, -4)) && allOk;
	allOk = compare_vec4((blockB.b.b.c), vec4(-9.0, 1.0, -7.0, 7.0)) && allOk;
	allOk = compare_bvec4((blockB.b.c), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bool((blockB.d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (9.0);
	blockA.b.a[0] = (vec3(-3.0, -2.0, -3.0));
	blockA.b.a[1] = (vec3(0.0, 2.0, -7.0));
	blockA.b.a[2] = (vec3(0.0, -8.0, 0.0));
	blockA.b.b[0] = (ivec2(-4, -7));
	blockA.b.b[1] = (ivec2(9, -3));
	blockA.b.b[2] = (ivec2(9, 8));
	blockA.b.b[3] = (ivec2(4, 0));
	blockA.b.c = (vec4(-6.0, -4.0, -6.0, 7.0));
	blockB.a[0] = (vec2(4.0, -1.0));
	blockB.a[1] = (vec2(-1.0, 6.0));
	blockB.b.a = (4u);
	blockB.b.b.a[0] = (vec3(-5.0, -5.0, 3.0));
	blockB.b.b.a[1] = (vec3(-6.0, 5.0, 2.0));
	blockB.b.b.a[2] = (vec3(2.0, -9.0, -5.0));
	blockB.b.b.b[0] = (ivec2(-5, 1));
	blockB.b.b.b[1] = (ivec2(-2, 9));
	blockB.b.b.b[2] = (ivec2(-9, 4));
	blockB.b.b.b[3] = (ivec2(1, 6));
	blockB.b.b.c = (vec4(5.0, 4.0, 1.0, -8.0));
	blockB.b.c = (bvec4(false, false, false, false));
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

layout(std140, column_major, buffer_reference) buffer BlockB
{
	highp uvec4 a;
	mediump ivec3 b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec4(8u, 6u, 1u, 3u));
	blockB.b = (ivec3(-5, -5, 0));
}
#version 450
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
	bvec4 mA;
	highp mat3 mB;
	sA mC;
	highp vec2 mD;
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	bvec2 a;
	lowp mat3 b[7][5];
	bvec4 c;
	lowp mat2x3 d;
	sB e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a), bvec2(true, false)) && allOk;
	allOk = compare_mat3(blockB.b[0][0], mat3(6.0, 1.0, 9.0, -6.0, -4.0, 2.0, -9.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat3(blockB.b[0][1], mat3(-9.0, -6.0, -5.0, -8.0, 7.0, -7.0, -1.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3(blockB.b[0][2], mat3(-7.0, 4.0, 6.0, -4.0, -1.0, 8.0, 3.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(blockB.b[0][3], mat3(9.0, 7.0, -5.0, -9.0, 7.0, 3.0, -6.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat3(blockB.b[0][4], mat3(-4.0, -5.0, 8.0, -3.0, 6.0, -1.0, -3.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat3(blockB.b[1][0], mat3(6.0, -7.0, 2.0, -2.0, 3.0, 3.0, 1.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3(blockB.b[1][1], mat3(7.0, -7.0, 6.0, -6.0, -6.0, 8.0, 5.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3(blockB.b[1][2], mat3(4.0, 1.0, 0.0, 2.0, -7.0, -7.0, 9.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(blockB.b[1][3], mat3(5.0, -5.0, 6.0, -1.0, 8.0, -2.0, 7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3(blockB.b[1][4], mat3(3.0, 2.0, 9.0, -4.0, 1.0, 0.0, 3.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(blockB.b[2][0], mat3(-8.0, 6.0, 9.0, -1.0, 0.0, -6.0, -1.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat3(blockB.b[2][1], mat3(2.0, -7.0, 5.0, -7.0, -7.0, -1.0, -9.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3(blockB.b[2][2], mat3(-8.0, 6.0, -8.0, -6.0, -5.0, 8.0, 6.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3(blockB.b[2][3], mat3(7.0, -7.0, -9.0, 6.0, -1.0, -6.0, -9.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3(blockB.b[2][4], mat3(-9.0, 9.0, 0.0, -8.0, 6.0, -6.0, 8.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat3(blockB.b[3][0], mat3(0.0, 5.0, -6.0, -9.0, -6.0, -7.0, -2.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat3(blockB.b[3][1], mat3(3.0, -9.0, -7.0, -1.0, 6.0, 9.0, -4.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat3(blockB.b[3][2], mat3(6.0, -7.0, -3.0, -9.0, -1.0, -2.0, 4.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat3(blockB.b[3][3], mat3(-6.0, -2.0, -4.0, 5.0, 9.0, -7.0, -1.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat3(blockB.b[3][4], mat3(-6.0, -8.0, -8.0, -3.0, 5.0, -6.0, -1.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat3(blockB.b[4][0], mat3(-8.0, 2.0, -8.0, -6.0, -8.0, 1.0, 9.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat3(blockB.b[4][1], mat3(0.0, 7.0, 8.0, -7.0, -4.0, 6.0, 0.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3(blockB.b[4][2], mat3(2.0, -4.0, 9.0, 5.0, 1.0, -6.0, -6.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat3(blockB.b[4][3], mat3(3.0, 1.0, -2.0, 6.0, 5.0, 3.0, -2.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat3(blockB.b[4][4], mat3(1.0, 1.0, -5.0, 6.0, 9.0, 8.0, -2.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3(blockB.b[5][0], mat3(5.0, 3.0, 0.0, 1.0, 8.0, 2.0, -7.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3(blockB.b[5][1], mat3(7.0, 1.0, -9.0, 4.0, -8.0, 3.0, 1.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat3(blockB.b[5][2], mat3(1.0, -9.0, -2.0, 9.0, 7.0, 6.0, 6.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3(blockB.b[5][3], mat3(-6.0, -2.0, 3.0, -9.0, 8.0, 9.0, -7.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat3(blockB.b[5][4], mat3(-6.0, 6.0, 2.0, 8.0, 5.0, 9.0, -2.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3(blockB.b[6][0], mat3(-2.0, 0.0, 7.0, 4.0, -9.0, 2.0, -2.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat3(blockB.b[6][1], mat3(-8.0, -7.0, 7.0, -6.0, -4.0, -7.0, -9.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3(blockB.b[6][2], mat3(-7.0, 1.0, -5.0, 1.0, 0.0, 6.0, -7.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(blockB.b[6][3], mat3(-5.0, -9.0, -8.0, 1.0, 6.0, -7.0, -4.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat3(blockB.b[6][4], mat3(7.0, 2.0, -2.0, 6.0, -5.0, 2.0, -4.0, -8.0, 2.0)) && allOk;
	allOk = compare_bvec4((blockB.c), bvec4(false, true, true, true)) && allOk;
	allOk = compare_mat2x3(blockB.d, mat2x3(-1.0, 0.0, 0.0, -8.0, 5.0, 1.0)) && allOk;
	allOk = compare_bvec4((blockB.e[0].mA), bvec4(true, false, false, true)) && allOk;
	allOk = compare_mat3(blockB.e[0].mB, mat3(6.0, 4.0, 2.0, 4.0, -6.0, -1.0, -9.0, 4.0, -9.0)) && allOk;
	allOk = compare_bvec4((blockB.e[0].mC.mA), bvec4(true, false, true, true)) && allOk;
	allOk = compare_vec2((blockB.e[0].mD), vec2(9.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, true));
	blockB.b[0][0] = (mat3(1.0, -2.0, -1.0, -3.0, -9.0, -9.0, -2.0, -4.0, -4.0));
	blockB.b[0][1] = (mat3(3.0, 4.0, 9.0, 1.0, 2.0, -6.0, 5.0, 9.0, 2.0));
	blockB.b[0][2] = (mat3(-1.0, -7.0, 3.0, -7.0, -5.0, 7.0, 5.0, 5.0, 7.0));
	blockB.b[0][3] = (mat3(-3.0, 2.0, -2.0, 9.0, 5.0, 7.0, -5.0, 9.0, -3.0));
	blockB.b[0][4] = (mat3(8.0, -3.0, 7.0, -4.0, -9.0, -2.0, 9.0, 7.0, 8.0));
	blockB.b[1][0] = (mat3(-1.0, 5.0, -4.0, 9.0, -2.0, -5.0, -8.0, -4.0, 0.0));
	blockB.b[1][1] = (mat3(8.0, 2.0, 6.0, 3.0, -7.0, -9.0, -2.0, -9.0, 9.0));
	blockB.b[1][2] = (mat3(7.0, 0.0, 2.0, 3.0, -4.0, -9.0, -5.0, 4.0, -2.0));
	blockB.b[1][3] = (mat3(-3.0, 3.0, 6.0, -6.0, 9.0, -8.0, 4.0, 4.0, 7.0));
	blockB.b[1][4] = (mat3(-6.0, 7.0, -9.0, -2.0, 3.0, -8.0, -8.0, 9.0, 5.0));
	blockB.b[2][0] = (mat3(1.0, -5.0, 8.0, -4.0, 5.0, 0.0, 6.0, 3.0, 8.0));
	blockB.b[2][1] = (mat3(-7.0, 2.0, 8.0, -4.0, 1.0, -7.0, 6.0, -2.0, -4.0));
	blockB.b[2][2] = (mat3(7.0, -9.0, 1.0, -9.0, -7.0, -7.0, -7.0, -1.0, -5.0));
	blockB.b[2][3] = (mat3(-5.0, -9.0, 4.0, -7.0, 3.0, -6.0, -6.0, 3.0, -5.0));
	blockB.b[2][4] = (mat3(-3.0, 2.0, 7.0, 5.0, 3.0, 4.0, -1.0, -3.0, -7.0));
	blockB.b[3][0] = (mat3(-6.0, 6.0, 6.0, 2.0, -7.0, 7.0, 8.0, 8.0, -5.0));
	blockB.b[3][1] = (mat3(9.0, 3.0, -7.0, 1.0, -7.0, 8.0, -9.0, -9.0, 3.0));
	blockB.b[3][2] = (mat3(-9.0, -7.0, 6.0, 9.0, -8.0, 9.0, -7.0, 1.0, -5.0));
	blockB.b[3][3] = (mat3(5.0, 5.0, 2.0, 5.0, -6.0, 3.0, 2.0, -7.0, -9.0));
	blockB.b[3][4] = (mat3(2.0, 4.0, 9.0, 1.0, 0.0, 6.0, 9.0, -1.0, 7.0));
	blockB.b[4][0] = (mat3(2.0, 8.0, -2.0, -8.0, -4.0, -4.0, -3.0, 5.0, 2.0));
	blockB.b[4][1] = (mat3(7.0, -7.0, 4.0, -6.0, 6.0, 7.0, 7.0, 6.0, -4.0));
	blockB.b[4][2] = (mat3(7.0, 2.0, 4.0, -4.0, -3.0, 2.0, 1.0, 6.0, 5.0));
	blockB.b[4][3] = (mat3(-3.0, 7.0, 3.0, 0.0, 5.0, -3.0, 2.0, -6.0, -5.0));
	blockB.b[4][4] = (mat3(6.0, 3.0, -6.0, 5.0, 4.0, 9.0, 2.0, -6.0, 7.0));
	blockB.b[5][0] = (mat3(5.0, 7.0, -8.0, 2.0, -9.0, -8.0, 1.0, -5.0, -2.0));
	blockB.b[5][1] = (mat3(-3.0, 5.0, -4.0, -3.0, -3.0, -8.0, 9.0, -8.0, 6.0));
	blockB.b[5][2] = (mat3(7.0, 7.0, -8.0, -4.0, -5.0, 6.0, 1.0, -7.0, 5.0));
	blockB.b[5][3] = (mat3(3.0, 5.0, -6.0, -5.0, 8.0, 8.0, 0.0, 3.0, -3.0));
	blockB.b[5][4] = (mat3(8.0, -8.0, -6.0, 5.0, -9.0, -3.0, -6.0, -4.0, 3.0));
	blockB.b[6][0] = (mat3(1.0, -9.0, -6.0, 7.0, -4.0, -8.0, -7.0, 2.0, -1.0));
	blockB.b[6][1] = (mat3(-8.0, -1.0, 2.0, -4.0, -4.0, -5.0, -5.0, -4.0, 3.0));
	blockB.b[6][2] = (mat3(-1.0, -5.0, -2.0, 6.0, 3.0, -6.0, 1.0, -5.0, -1.0));
	blockB.b[6][3] = (mat3(-5.0, -8.0, -3.0, 5.0, 1.0, -9.0, -3.0, -7.0, -9.0));
	blockB.b[6][4] = (mat3(-8.0, -7.0, 7.0, -4.0, -5.0, -4.0, 1.0, 6.0, 4.0));
	blockB.c = (bvec4(false, false, false, false));
	blockB.d = (mat2x3(-5.0, 4.0, 6.0, -5.0, 2.0, -6.0));
}
#version 450
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
};
struct sB
{
	mediump mat3 mA;
	highp float mB;
	lowp mat4x3 mC;
	mediump uint mD;
};
struct sC
{
	sB mA;
};
layout(std430, column_major, buffer_reference) buffer BlockB
{
	lowp mat4x3 a;
	sA b;
	mediump uvec2 c;
	mediump mat4x3 d;
	sC e[];
};
layout(std140, buffer_reference) buffer BlockC
{
	highp mat3x4 f;
	lowp uvec3 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.a, mat4x3(1.0, -3.0, 9.0, 7.0, -5.0, 2.0, -1.0, -8.0, 2.0, -6.0, 5.0, -7.0)) && allOk;
	allOk = compare_uvec2((blockB.c), uvec2(6u, 1u)) && allOk;
	allOk = compare_mat4x3(blockB.d, mat4x3(1.0, 1.0, 6.0, -8.0, -9.0, 0.0, -1.0, -1.0, 5.0, 4.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat3x4(blockC.f, mat3x4(5.0, 4.0, 2.0, 3.0, 3.0, 2.0, -8.0, 1.0, 7.0, 3.0, 2.0, 2.0)) && allOk;
	allOk = compare_uvec3((blockC.g[0]), uvec3(3u, 1u, 3u)) && allOk;
	allOk = compare_uvec3((blockC.g[1]), uvec3(2u, 3u, 0u)) && allOk;
	allOk = compare_uvec3((blockC.g[2]), uvec3(5u, 8u, 2u)) && allOk;
	allOk = compare_uvec3((blockC.g[3]), uvec3(6u, 5u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b.mA = (mat3(9.0, -2.0, 6.0, 4.0, 0.0, 7.0, 5.0, -3.0, 1.0));
	blockB.c = (uvec2(7u, 8u));
	blockB.d = (mat4x3(-8.0, 5.0, 2.0, 6.0, 6.0, -9.0, 7.0, 6.0, 3.0, 9.0, -8.0, 1.0));
	blockC.f = (mat3x4(-8.0, 1.0, -4.0, -7.0, 7.0, 9.0, 9.0, -1.0, -1.0, 0.0, -6.0, -6.0));
}
#version 450
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
	layout(offset = 0) lowp float a;
	layout(offset = 4) lowp float b;
	layout(offset = 8) highp ivec2 c;
	layout(offset = 16) lowp vec4 d[1];
	layout(offset = 32) bvec2 e[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.b), -8.0) && allOk;
	allOk = compare_ivec2((blockB.c), ivec2(0, -9)) && allOk;
	allOk = compare_vec4((blockB.d[0]), vec4(-1.0, 4.0, -4.0, 0.0)) && allOk;
	allOk = compare_bvec2((blockB.e[0]), bvec2(false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (-2.0);
	blockB.b = (-9.0);
	blockB.c = (ivec2(-3, -1));
	blockB.d[0] = (vec4(-2.0, 7.0, -7.0, -6.0));
	blockB.e[0] = (bvec2(true, false));
}
#version 450
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
	layout(offset = 0) highp vec2 a;
	layout(offset = 16) mediump uvec4 b;
	layout(offset = 32) highp ivec3 c;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) lowp uvec4 d;
	layout(offset = 16) highp uvec3 e;
	layout(offset = 28) bool f;
	layout(offset = 32) lowp ivec2 g;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) mediump uvec3 h[1];
	layout(offset = 16) lowp ivec2 i;
	layout(offset = 24) bool j;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) highp int k;
	layout(offset = 4) highp uvec2 l;
	layout(offset = 16) mediump ivec3 m;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
    BlockD blockD;
    BlockE blockE[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB[0].b), uvec4(9u, 8u, 8u, 1u)) && allOk;
	allOk = compare_uvec4((blockB[1].b), uvec4(9u, 6u, 3u, 6u)) && allOk;
	allOk = compare_uvec4((blockC.d), uvec4(6u, 8u, 7u, 2u)) && allOk;
	allOk = compare_bool((blockC.f), true) && allOk;
	allOk = compare_ivec2((blockC.g), ivec2(1, 0)) && allOk;
	allOk = compare_ivec2((blockD.i), ivec2(-6, 9)) && allOk;
	allOk = compare_bool((blockD.j), false) && allOk;
	allOk = compare_int((blockE[0].k), -7) && allOk;
	allOk = compare_ivec3((blockE[0].m), ivec3(-6, -5, -8)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (vec2(-1.0, -2.0));
	blockB[0].b = (uvec4(9u, 2u, 8u, 5u));
	blockB[0].c = (ivec3(7, -6, 5));
	blockB[1].a = (vec2(2.0, 1.0));
	blockB[1].b = (uvec4(1u, 4u, 6u, 6u));
	blockB[1].c = (ivec3(-5, 1, -3));
	blockC.d = (uvec4(5u, 0u, 8u, 3u));
	blockC.e = (uvec3(5u, 3u, 2u));
	blockC.g = (ivec2(9, 1));
	blockD.h[0] = (uvec3(1u, 0u, 5u));
	blockD.i = (ivec2(8, 9));
	blockD.j = (true);
	blockE[0].k = (-8);
	blockE[0].l = (uvec2(4u, 9u));
}
#version 450
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
	layout(offset = 16) mediump uvec3 b[1];
	layout(offset = 32) mediump uvec2 c;
	layout(offset = 48) lowp uvec4 d;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) lowp float e;
	layout(offset = 4) lowp int f;
	layout(offset = 16) mediump vec4 g;
	layout(offset = 32) highp ivec3 h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, true, true, true)) && allOk;
	allOk = compare_uvec3((blockB.b[0]), uvec3(8u, 7u, 7u)) && allOk;
	allOk = compare_uvec2((blockB.c), uvec2(3u, 9u)) && allOk;
	allOk = compare_int((blockC.f), -2) && allOk;
	allOk = compare_ivec3((blockC.h), ivec3(0, -2, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec4(true, true, false, true));
	blockB.c = (uvec2(9u, 7u));
	blockB.d = (uvec4(9u, 0u, 4u, 0u));
	blockC.e = (-1.0);
	blockC.f = (9);
	blockC.g = (vec4(3.0, -2.0, -6.0, -4.0));
	blockC.h = (ivec3(-4, 8, -4));
}
#version 450
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
	layout(offset = 0) highp uvec4 a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a), uvec4(3u, 9u, 9u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp vec4 a;
	bvec2 b;
	i16vec3 c;
	mediump ivec3 d[1];
};
layout(std140, buffer_reference) buffer BlockC
{
	u16vec2 e;
	f16vec3 f;
	highp ivec4 g;
	mediump int h;
};
layout(std430, buffer_reference) buffer BlockD
{
	f16vec2 i;
	f16vec2 j;
};
layout(std430, buffer_reference) buffer BlockE
{
	i16vec2 k;
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
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.a), vec4(6.0, 6.0, -6.0, -3.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB.c), ivec3(-7, -9, 8)) && allOk;
	allOk = compare_ivec3((blockB.d[0]), ivec3(-4, -8, 8)) && allOk;
	allOk = compare_int((blockC.h), -1) && allOk;
	allOk = compare_f16vec2(vec2(blockD.j), vec2(8.0, 4.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockE.k), ivec2(-9, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec4(-5.0, 9.0, 5.0, 5.0));
	blockB.c = i16vec3(ivec3(-8, 3, -9));
	blockB.d[0] = (ivec3(2, 6, 1));
	blockC.e = u16vec2(uvec2(7u, 2u));
	blockD.j = f16vec2(vec2(9.0, 8.0));
	blockE.k = i16vec2(ivec2(-4, -8));
}
#version 450
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
	lowp ivec3 a;
	lowp uvec2 b;
	lowp ivec2 c[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (uvec2(8u, 6u));
	blockB[1].b = (uvec2(6u, 7u));
}
#version 450
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
	highp mat2x3 a;
	lowp vec2 b;
	highp mat4x3 c;
	highp mat2 d;
	highp uvec4 e[];
};
layout(std430, buffer_reference) readonly buffer BlockC
{
	mediump float f;
};
layout(std140, buffer_reference) buffer BlockD
{
	bool g[];
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB.a, mat2x3(4.0, 1.0, 1.0, -1.0, 6.0, 9.0)) && allOk;
	allOk = compare_vec2((blockB.b), vec2(-6.0, -4.0)) && allOk;
	allOk = compare_mat2(blockB.d, mat2(-2.0, 4.0, -7.0, 6.0)) && allOk;
	allOk = compare_uvec4((blockB.e[0]), uvec4(8u, 6u, 0u, 5u)) && allOk;
	allOk = compare_float((blockC.f), 9.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2x3(5.0, -9.0, 1.0, 7.0, -6.0, -2.0));
	blockB.b = (vec2(-1.0, -3.0));
	blockB.d = (mat2(9.0, -1.0, 2.0, -7.0));
	blockD.g[0] = (false);
}
#version 450
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
	u16vec3 a;
	u16vec3 b;
	mediump mat4x2 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(blockB.b), uvec3(1u, 4u, 0u)) && allOk;
	allOk = compare_mat4x2(blockB.c[0], mat4x2(2.0, -1.0, 9.0, -8.0, 0.0, 1.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat4x2(blockB.c[1], mat4x2(-3.0, -6.0, 0.0, -1.0, 2.0, 9.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4x2(blockB.c[2], mat4x2(-5.0, -6.0, -1.0, 1.0, 3.0, -2.0, -1.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec3(uvec3(6u, 1u, 1u));
	blockB.b = u16vec3(uvec3(0u, 9u, 7u));
	blockB.c[0] = (mat4x2(3.0, 3.0, 9.0, -4.0, 3.0, -8.0, -8.0, -8.0));
	blockB.c[1] = (mat4x2(-4.0, 2.0, -8.0, -2.0, 1.0, 7.0, 6.0, -3.0));
	blockB.c[2] = (mat4x2(-9.0, 6.0, 6.0, -6.0, -5.0, -4.0, -2.0, -5.0));
}
#version 450
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
	f16vec3 a[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	bvec4 b;
	u16vec3 c;
	highp mat4x2 d[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	mediump mat3x2 e;
	u16vec3 f;
	mediump mat4x3 g[];
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(blockB.a[0]), vec3(-7.0, 8.0, 8.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.a[1]), vec3(2.0, 4.0, 0.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.a[2]), vec3(-2.0, 6.0, -1.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.a[3]), vec3(5.0, -9.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.a[4]), vec3(-2.0, -9.0, 2.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.a[5]), vec3(0.0, -9.0, 0.0)) && allOk;
	allOk = compare_bvec4((blockC.b), bvec4(false, false, false, false)) && allOk;
	allOk = compare_mat3x2(blockD.e, mat3x2(5.0, -6.0, 1.0, -5.0, -9.0, -8.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockD.f), uvec3(1u, 5u, 1u)) && allOk;
	allOk = compare_mat4x3(blockD.g[0], mat4x3(0.0, 1.0, 4.0, -1.0, 5.0, 6.0, 7.0, -1.0, 5.0, 0.0, 3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (bvec4(false, false, false, true));
	blockC.c = u16vec3(uvec3(4u, 2u, 0u));
	blockC.d[0] = (mat4x2(-5.0, -2.0, -2.0, 8.0, -3.0, -3.0, -8.0, 1.0));
	blockC.d[1] = (mat4x2(-3.0, -1.0, 3.0, 7.0, -4.0, -5.0, -1.0, -3.0));
	blockC.d[2] = (mat4x2(1.0, -9.0, 8.0, 9.0, -8.0, -8.0, 3.0, -3.0));
	blockC.d[3] = (mat4x2(0.0, 4.0, 6.0, 1.0, -4.0, 6.0, 0.0, -2.0));
	blockC.d[4] = (mat4x2(-1.0, 5.0, 2.0, -7.0, -6.0, -2.0, -6.0, 9.0));
	blockD.e = (mat3x2(9.0, -3.0, -9.0, 9.0, 5.0, -9.0));
	blockD.f = u16vec3(uvec3(0u, 7u, 1u));
	blockD.g[0] = (mat4x3(0.0, 0.0, -1.0, 4.0, 5.0, 0.0, 5.0, 0.0, -7.0, -3.0, 1.0, -6.0));
}
#version 450
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
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) bvec4 b;
	layout(offset = 16) mediump uint c;
	layout(offset = 20) f16vec4 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockB.a), -9.0) && allOk;
	allOk = compare_bvec4((blockC.b), bvec4(false, true, false, false)) && allOk;
	allOk = compare_uint((blockC.c), 6u) && allOk;
	allOk = compare_f16vec4(vec4(blockC.d), vec4(1.0, -8.0, -6.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = float16_t(2.0);
	blockC.b = (bvec4(true, false, true, true));
	blockC.c = (1u);
	blockC.d = f16vec4(vec4(-1.0, -3.0, -1.0, 9.0));
}
#version 450
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
	i16vec2 a[];
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	uint16_t b[4];
	lowp vec3 c[];
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	u16vec4 d;
	mediump ivec2 e;
	u16vec4 f[];
};
layout(scalar, buffer_reference) buffer BlockE
{
	mediump float g;
	u16vec2 h;
	highp mat3 i;
	u16vec4 j[];
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
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(blockB.a[0]), ivec2(-4, 6)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.a[1]), ivec2(6, -7)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.a[2]), ivec2(-9, 5)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.a[3]), ivec2(-4, -9)) && allOk;
	allOk = compare_vec3((blockC.c[0]), vec3(4.0, -6.0, -3.0)) && allOk;
	allOk = compare_vec3((blockC.c[1]), vec3(2.0, -9.0, -7.0)) && allOk;
	allOk = compare_vec3((blockC.c[2]), vec3(-5.0, -7.0, 3.0)) && allOk;
	allOk = compare_vec3((blockC.c[3]), vec3(5.0, 2.0, -9.0)) && allOk;
	allOk = compare_vec3((blockC.c[4]), vec3(0.0, -5.0, 0.0)) && allOk;
	allOk = compare_vec3((blockC.c[5]), vec3(1.0, -8.0, 0.0)) && allOk;
	allOk = compare_vec3((blockC.c[6]), vec3(3.0, -5.0, 5.0)) && allOk;
	allOk = compare_vec3((blockC.c[7]), vec3(-7.0, 1.0, -8.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockD.d), uvec4(8u, 8u, 0u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockD.f[0]), uvec4(9u, 1u, 6u, 2u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockD.f[1]), uvec4(2u, 3u, 4u, 6u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockD.f[2]), uvec4(2u, 9u, 2u, 6u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockD.f[3]), uvec4(1u, 4u, 6u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockD.f[4]), uvec4(3u, 2u, 3u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockD.f[5]), uvec4(8u, 9u, 7u, 2u)) && allOk;
	allOk = compare_float((blockE.g), -8.0) && allOk;
	allOk = compare_u16vec2(uvec2(blockE.h), uvec2(6u, 7u)) && allOk;
	allOk = compare_mat3(blockE.i, mat3(7.0, -9.0, -3.0, 0.0, 4.0, -7.0, -1.0, 1.0, 1.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockE.j[0]), uvec4(2u, 2u, 8u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockE.j[1]), uvec4(6u, 6u, 4u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockE.j[2]), uvec4(1u, 6u, 7u, 7u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockE.j[3]), uvec4(6u, 6u, 7u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockE.j[4]), uvec4(2u, 9u, 0u, 7u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockE.j[5]), uvec4(2u, 5u, 5u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockE.j[6]), uvec4(0u, 0u, 0u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = i16vec2(ivec2(9, -7));
	blockB.a[1] = i16vec2(ivec2(-5, -9));
	blockB.a[2] = i16vec2(ivec2(-8, 0));
	blockB.a[3] = i16vec2(ivec2(8, 0));
	blockC.b[0] = uint16_t(1u);
	blockC.b[1] = uint16_t(2u);
	blockC.b[2] = uint16_t(0u);
	blockC.b[3] = uint16_t(9u);
	blockD.d = u16vec4(uvec4(0u, 3u, 3u, 7u));
	blockD.f[0] = u16vec4(uvec4(1u, 4u, 8u, 4u));
	blockD.f[1] = u16vec4(uvec4(3u, 1u, 2u, 1u));
	blockD.f[2] = u16vec4(uvec4(2u, 7u, 4u, 7u));
	blockD.f[3] = u16vec4(uvec4(0u, 2u, 2u, 6u));
	blockD.f[4] = u16vec4(uvec4(1u, 0u, 1u, 1u));
	blockD.f[5] = u16vec4(uvec4(5u, 5u, 3u, 2u));
	blockE.g = (-1.0);
	blockE.h = u16vec2(uvec2(1u, 1u));
	blockE.i = (mat3(-1.0, -2.0, 2.0, -3.0, -1.0, -6.0, -4.0, 3.0, -8.0));
	blockE.j[0] = u16vec4(uvec4(1u, 5u, 4u, 5u));
	blockE.j[1] = u16vec4(uvec4(0u, 1u, 8u, 7u));
	blockE.j[2] = u16vec4(uvec4(9u, 8u, 3u, 6u));
	blockE.j[3] = u16vec4(uvec4(0u, 4u, 2u, 1u));
	blockE.j[4] = u16vec4(uvec4(3u, 3u, 9u, 0u));
	blockE.j[5] = u16vec4(uvec4(0u, 2u, 4u, 7u));
	blockE.j[6] = u16vec4(uvec4(3u, 1u, 7u, 7u));
}
#version 450
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
	mediump mat3 mB[3];
	mediump mat2 mC;
	mediump ivec3 mD;
};
layout(scalar, row_major, buffer_reference) buffer BlockB
{
	u16vec4 a;
	f16vec2 b;
	i16vec2 c[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	i16vec4 d;
	u16vec3 e;
	mediump mat2x3 f;
	bvec4 g[];
};
layout(scalar, row_major, buffer_reference) buffer BlockD
{
	sA h;
	lowp float i;
	u16vec2 j;
	f16vec4 k[];
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
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(blockB.a), uvec4(0u, 5u, 7u, 7u)) && allOk;
	allOk = compare_f16vec2(vec2(blockB.b), vec2(-7.0, 2.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.e), uvec3(7u, 5u, 1u)) && allOk;
	allOk = compare_bvec4((blockC.g[0]), bvec4(false, false, false, true)) && allOk;
	allOk = compare_u16vec2(uvec2(blockD.j), uvec2(5u, 1u)) && allOk;
	allOk = compare_f16vec4(vec4(blockD.k[0]), vec4(4.0, 7.0, -8.0, 2.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockD.k[1]), vec4(8.0, 7.0, 8.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockD.k[2]), vec4(-2.0, -2.0, 8.0, -5.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockD.k[3]), vec4(-3.0, 8.0, -5.0, -1.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockD.k[4]), vec4(2.0, -6.0, -9.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockD.k[5]), vec4(2.0, 9.0, 1.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec4(uvec4(4u, 4u, 8u, 9u));
	blockB.b = f16vec2(vec2(5.0, 2.0));
	blockC.d = i16vec4(ivec4(-3, 2, -9, -4));
	blockC.e = u16vec3(uvec3(4u, 9u, 0u));
	blockC.f = (mat2x3(5.0, 1.0, 7.0, 9.0, -3.0, 7.0));
	blockC.g[0] = (bvec4(true, false, true, true));
	blockD.h.mA = (mat2x3(6.0, -6.0, 3.0, -5.0, 2.0, -1.0));
	blockD.h.mB[0] = (mat3(-3.0, -8.0, -6.0, -1.0, 4.0, 2.0, 7.0, -1.0, 7.0));
	blockD.h.mB[1] = (mat3(4.0, 9.0, -2.0, -5.0, 1.0, 2.0, 3.0, -4.0, -6.0));
	blockD.h.mB[2] = (mat3(2.0, -2.0, -7.0, -7.0, -8.0, 6.0, 9.0, -8.0, 6.0));
	blockD.h.mC = (mat2(-1.0, -9.0, -4.0, 9.0));
	blockD.h.mD = (ivec3(-6, -3, 7));
	blockD.k[0] = f16vec4(vec4(-6.0, -9.0, 7.0, -4.0));
	blockD.k[1] = f16vec4(vec4(-1.0, -3.0, -5.0, -8.0));
	blockD.k[2] = f16vec4(vec4(-7.0, 7.0, -1.0, 8.0));
	blockD.k[3] = f16vec4(vec4(-8.0, 1.0, -3.0, 5.0));
	blockD.k[4] = f16vec4(vec4(-1.0, -4.0, 7.0, 0.0));
	blockD.k[5] = f16vec4(vec4(6.0, 9.0, -7.0, -3.0));
}
#version 450
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
	i8vec4 a;
	lowp uvec3 b;
	uint8_t c[];
};
layout(std430, row_major, buffer_reference) readonly buffer BlockC
{
	lowp mat3x2 d;
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	highp uvec3 e;
	bvec3 f;
	mediump mat4x2 g;
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
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(blockB.c[0]), 6u) && allOk;
	allOk = compare_uint8_t(uint(blockB.c[1]), 1u) && allOk;
	allOk = compare_uint8_t(uint(blockB.c[2]), 8u) && allOk;
	allOk = compare_uint8_t(uint(blockB.c[3]), 9u) && allOk;
	allOk = compare_uint8_t(uint(blockB.c[4]), 3u) && allOk;
	allOk = compare_uint8_t(uint(blockB.c[5]), 2u) && allOk;
	allOk = compare_mat3x2(blockC.d, mat3x2(-3.0, 8.0, -1.0, -1.0, 4.0, 6.0)) && allOk;
	allOk = compare_uvec3((blockD.e), uvec3(5u, 1u, 2u)) && allOk;
	allOk = compare_mat4x2(blockD.g, mat4x2(-8.0, -4.0, 7.0, 3.0, -4.0, 0.0, -9.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i8vec4(ivec4(6, 0, 5, 1));
	blockB.b = (uvec3(8u, 2u, 9u));
	blockB.c[0] = uint8_t(3u);
	blockB.c[1] = uint8_t(3u);
	blockB.c[2] = uint8_t(1u);
	blockB.c[3] = uint8_t(6u);
	blockB.c[4] = uint8_t(3u);
	blockB.c[5] = uint8_t(9u);
	blockD.e = (uvec3(4u, 1u, 4u));
	blockD.g = (mat4x2(2.0, 3.0, 7.0, 1.0, -1.0, -4.0, -6.0, -9.0));
}
#version 450
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
	u8vec3 a;
	int8_t b;
	mediump mat3x2 c;
	bvec2 d[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	u8vec2 e[5];
	mediump float f;
	bvec3 g;
	mediump mat3x2 h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(blockB.a), uvec3(9u, 7u, 8u)) && allOk;
	allOk = compare_int8_t(int(blockB.b), 7) && allOk;
	allOk = compare_mat3x2(blockB.c, mat3x2(4.0, 0.0, -5.0, -8.0, -6.0, 4.0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.e[0]), uvec2(2u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.e[1]), uvec2(0u, 1u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.e[2]), uvec2(4u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.e[3]), uvec2(4u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.e[4]), uvec2(1u, 1u)) && allOk;
	allOk = compare_bvec3((blockC.g), bvec3(false, false, true)) && allOk;
	allOk = compare_mat3x2(blockC.h[0], mat3x2(1.0, 1.0, 3.0, 6.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockC.h[1], mat3x2(6.0, -4.0, 6.0, 7.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockC.h[2], mat3x2(-9.0, -5.0, -1.0, -8.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockC.h[3], mat3x2(-8.0, 5.0, -1.0, 1.0, 7.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.d[0] = (bvec2(true, false));
	blockB.d[1] = (bvec2(false, true));
	blockC.f = (-2.0);
	blockC.g = (bvec3(false, true, false));
	blockC.h[0] = (mat3x2(6.0, -3.0, -6.0, 8.0, -6.0, -7.0));
	blockC.h[1] = (mat3x2(-1.0, 4.0, -7.0, 2.0, -1.0, 4.0));
	blockC.h[2] = (mat3x2(-6.0, 5.0, -5.0, -1.0, -2.0, -3.0));
	blockC.h[3] = (mat3x2(-7.0, 8.0, -6.0, 7.0, 9.0, 8.0));
}
#version 450
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
	mediump uint a;
	highp mat4x3 b;
	mediump ivec3 c;
	bvec3 d[6];
	mediump vec2 e[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	lowp uvec2 f;
	lowp ivec3 g;
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	mediump uvec3 h;
	u8vec4 i;
	highp int j[];
};
layout(std430, column_major, buffer_reference) buffer BlockE
{
	lowp vec3 k;
	u8vec4 l[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[1];
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 4u) && allOk;
	allOk = compare_ivec3((blockB.c), ivec3(3, 3, 3)) && allOk;
	allOk = compare_bvec3((blockB.d[0]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockB.d[1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((blockB.d[2]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((blockB.d[3]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((blockB.d[4]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockB.d[5]), bvec3(false, true, false)) && allOk;
	allOk = compare_vec2((blockB.e[0]), vec2(1.0, 9.0)) && allOk;
	allOk = compare_vec2((blockB.e[1]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((blockB.e[2]), vec2(-6.0, -3.0)) && allOk;
	allOk = compare_vec2((blockB.e[3]), vec2(6.0, 6.0)) && allOk;
	allOk = compare_vec2((blockB.e[4]), vec2(1.0, 3.0)) && allOk;
	allOk = compare_vec2((blockB.e[5]), vec2(4.0, 1.0)) && allOk;
	allOk = compare_uvec2((blockC[0].f), uvec2(2u, 6u)) && allOk;
	allOk = compare_uvec3((blockD.h), uvec3(6u, 4u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD.i), uvec4(5u, 5u, 9u, 0u)) && allOk;
	allOk = compare_int((blockD.j[0]), 8) && allOk;
	allOk = compare_int((blockD.j[1]), 9) && allOk;
	allOk = compare_int((blockD.j[2]), 2) && allOk;
	allOk = compare_int((blockD.j[3]), 0) && allOk;
	allOk = compare_u8vec4(uvec4(blockE.l[0]), uvec4(5u, 7u, 2u, 3u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockE.l[1]), uvec4(0u, 4u, 7u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockE.l[2]), uvec4(0u, 0u, 6u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockE.l[3]), uvec4(7u, 4u, 0u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockE.l[4]), uvec4(3u, 7u, 1u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockE.l[5]), uvec4(1u, 8u, 6u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockE.l[6]), uvec4(3u, 4u, 6u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (8u);
	blockB.b = (mat4x3(-5.0, 3.0, 9.0, -5.0, -5.0, 0.0, -1.0, -9.0, 2.0, -4.0, -8.0, -4.0));
	blockB.c = (ivec3(8, 6, -3));
	blockB.d[0] = (bvec3(true, false, false));
	blockB.d[1] = (bvec3(false, false, true));
	blockB.d[2] = (bvec3(false, true, false));
	blockB.d[3] = (bvec3(true, false, false));
	blockB.d[4] = (bvec3(false, false, false));
	blockB.d[5] = (bvec3(false, true, false));
	blockB.e[0] = (vec2(0.0, -1.0));
	blockB.e[1] = (vec2(-3.0, -8.0));
	blockB.e[2] = (vec2(-6.0, 3.0));
	blockB.e[3] = (vec2(2.0, 7.0));
	blockB.e[4] = (vec2(2.0, -9.0));
	blockB.e[5] = (vec2(1.0, -9.0));
	blockC[0].f = (uvec2(5u, 7u));
	blockC[0].g = (ivec3(-1, 2, -5));
	blockD.h = (uvec3(5u, 9u, 0u));
	blockD.i = u8vec4(uvec4(0u, 3u, 6u, 1u));
	blockD.j[0] = (-7);
	blockD.j[1] = (2);
	blockD.j[2] = (0);
	blockD.j[3] = (4);
	blockE.k = (vec3(-1.0, -7.0, -2.0));
}
#version 450
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
	layout(offset = 0) mediump float a;
	layout(offset = 4) highp ivec2 b;
	layout(offset = 12) u8vec4 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a), -6.0) && allOk;
	allOk = compare_ivec2((blockB.b), ivec2(5, 3)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB.c), uvec4(8u, 9u, 8u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (4.0);
	blockB.b = (ivec2(8, 8));
	blockB.c = u8vec4(uvec4(6u, 7u, 4u, 8u));
}
#version 450
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
	u8vec2 mA;
	lowp mat3x4 mB;
	bvec4 mC;
	mediump vec2 mD;
};
struct sB
{
	lowp ivec4 mA;
	sA mB;
	mediump ivec3 mC;
	u8vec4 mD;
};
layout(scalar, buffer_reference) buffer BlockB
{
	highp ivec2 a;
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	bvec2 b;
	uint8_t c;
	mediump mat4x3 d[];
};
layout(scalar, row_major, buffer_reference) buffer BlockD
{
	i8vec2 e;
	sB f;
	lowp float g;
	lowp mat2x3 h[];
};
layout(scalar, buffer_reference) buffer BlockE
{
	lowp int i;
	u8vec2 j;
	bvec4 k[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a), ivec2(-9, 1)) && allOk;
	allOk = compare_bvec2((blockC[0].b), bvec2(true, true)) && allOk;
	allOk = compare_mat4x3(blockC[0].d[0], mat4x3(2.0, 4.0, -2.0, -1.0, -2.0, 4.0, 1.0, -4.0, 3.0, -9.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat4x3(blockC[0].d[1], mat4x3(6.0, 7.0, -8.0, -7.0, 7.0, 6.0, -4.0, 4.0, 6.0, 6.0, -6.0, -1.0)) && allOk;
	allOk = compare_bvec2((blockC[1].b), bvec2(false, true)) && allOk;
	allOk = compare_mat4x3(blockC[1].d[0], mat4x3(4.0, 4.0, -7.0, 9.0, 7.0, -4.0, 2.0, -7.0, -6.0, -3.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat4x3(blockC[1].d[1], mat4x3(-9.0, -8.0, -5.0, -6.0, 7.0, 6.0, -4.0, 8.0, 1.0, 6.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat4x3(blockC[1].d[2], mat4x3(-6.0, 7.0, -2.0, -1.0, -1.0, -9.0, 7.0, 6.0, 2.0, 8.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat4x3(blockC[1].d[3], mat4x3(4.0, 3.0, -3.0, 0.0, 4.0, 5.0, 4.0, 7.0, 0.0, 2.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat4x3(blockC[1].d[4], mat4x3(-5.0, 5.0, -5.0, -2.0, -2.0, -3.0, -1.0, -7.0, -1.0, -2.0, 4.0, -2.0)) && allOk;
	allOk = compare_bvec2((blockC[2].b), bvec2(true, false)) && allOk;
	allOk = compare_mat4x3(blockC[2].d[0], mat4x3(9.0, 0.0, -3.0, -4.0, 8.0, -5.0, 5.0, 9.0, -1.0, 8.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat4x3(blockC[2].d[1], mat4x3(-8.0, 7.0, -9.0, -6.0, 6.0, 3.0, -6.0, 4.0, 5.0, 5.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat4x3(blockC[2].d[2], mat4x3(-6.0, 8.0, 2.0, 0.0, -3.0, 2.0, -7.0, 2.0, 1.0, 0.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat4x3(blockC[2].d[3], mat4x3(5.0, -6.0, -2.0, 9.0, 3.0, -6.0, 1.0, 4.0, -1.0, -1.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat4x3(blockC[2].d[4], mat4x3(-9.0, -6.0, 9.0, 4.0, -8.0, -5.0, -7.0, -6.0, 1.0, 8.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat4x3(blockC[2].d[5], mat4x3(5.0, -5.0, 3.0, 2.0, 7.0, -7.0, 8.0, -2.0, 4.0, 3.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat4x3(blockC[2].d[6], mat4x3(-1.0, -6.0, 8.0, -8.0, 3.0, 7.0, 5.0, -5.0, 3.0, -5.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat4x3(blockC[2].d[7], mat4x3(4.0, 9.0, -1.0, 0.0, 6.0, -5.0, 0.0, 1.0, -4.0, -4.0, 3.0, 5.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.e), ivec2(4294967292, 9)) && allOk;
	allOk = compare_float((blockD.g), 5.0) && allOk;
	allOk = compare_int((blockE.i), -5) && allOk;
	allOk = compare_bvec4((blockE.k[0]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((blockE.k[1]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((blockE.k[2]), bvec4(false, true, false, false)) && allOk;
	allOk = compare_bvec4((blockE.k[3]), bvec4(true, false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec2(-4, 7));
	blockC[0].b = (bvec2(true, false));
	blockC[0].c = uint8_t(7u);
	blockC[1].b = (bvec2(false, true));
	blockC[1].c = uint8_t(0u);
	blockC[2].b = (bvec2(true, false));
	blockC[2].c = uint8_t(9u);
	blockD.f.mA = (ivec4(7, 4, 2, 8));
	blockD.f.mB.mA = u8vec2(uvec2(0u, 9u));
	blockD.f.mB.mB = (mat3x4(-7.0, -2.0, -3.0, -9.0, 8.0, -1.0, 4.0, -4.0, 3.0, 5.0, -9.0, 0.0));
	blockD.f.mB.mC = (bvec4(true, false, false, true));
	blockD.f.mB.mD = (vec2(3.0, 0.0));
	blockD.f.mC = (ivec3(-3, -2, -5));
	blockD.f.mD = u8vec4(uvec4(3u, 2u, 5u, 0u));
	blockD.g = (5.0);
	blockE.i = (4);
	blockE.j = u8vec2(uvec2(1u, 3u));
	blockE.k[0] = (bvec4(false, true, false, true));
	blockE.k[1] = (bvec4(false, false, false, false));
	blockE.k[2] = (bvec4(false, true, false, false));
	blockE.k[3] = (bvec4(false, false, true, false));
}
