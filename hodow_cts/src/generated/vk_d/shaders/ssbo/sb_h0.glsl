#version 450
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
	lowp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 6.0) && allOk;
	allOk = compare_float(var[0][1], 4.0) && allOk;
	allOk = compare_float(var[1][0], -1.0) && allOk;
	allOk = compare_float(var[1][1], -1.0) && allOk;
	allOk = compare_float(var[2][0], -5.0) && allOk;
	allOk = compare_float(var[2][1], -9.0) && allOk;
	allOk = compare_vec2(var[0], vec2(6.0, 4.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-1.0, -1.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-5.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3x2(1.0, -6.0, 0.0, -8.0, -3.0, 3.0));
}
#version 450
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

	var[0] = (vec2(-4.0, 3.0));
	var[1] = (vec2(-8.0, -8.0));
	var[2] = (vec2(-6.0, 2.0));
}
#version 450
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

layout(std430, binding = 1) buffer Block
{
	bvec4 var;
};

bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((var), bvec4(true, false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (bvec4(true, true, true, false));
}
#version 450
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

	var = (mat2x4(0.0, 1.0, 1.0, 2.0, -2.0, -8.0, -1.0, 8.0));
}
#version 450
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

	var[0] = (vec2(-5.0, 6.0));
	var[1] = (vec2(4.0, 3.0));
	var[2] = (vec2(-5.0, -6.0));
	var[3] = (vec2(-8.0, -8.0));
}
#version 450
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
	float padding;
	mediump mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 4.0) && allOk;
	allOk = compare_mat2(var, mat2(-8.0, -5.0, -3.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (7.0);
	var = (mat2(-1.0, -6.0, 9.0, 2.0));
}
#version 450
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
	mediump mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -3.0) && allOk;
	allOk = compare_float(var[0][0], -7.0) && allOk;
	allOk = compare_float(var[0][1], -2.0) && allOk;
	allOk = compare_float(var[0][2], -1.0) && allOk;
	allOk = compare_float(var[1][0], -7.0) && allOk;
	allOk = compare_float(var[1][1], 4.0) && allOk;
	allOk = compare_float(var[1][2], 4.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-7.0, -2.0, -1.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-7.0, 4.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (2.0);
	var[0] = (vec3(5.0, 6.0, -7.0));
	var[1] = (vec3(5.0, 4.0, 0.0));
}
#version 450
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

	padding = (1.0);
	var = (mat4x3(4.0, 5.0, -8.0, -8.0, 2.0, 7.0, 9.0, 8.0, 4.0, -9.0, 9.0, 9.0));
}
#version 450
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

	var[0] = uint16_t(9u);
	var[1] = uint16_t(1u);
	var[2] = uint16_t(1u);
}
#version 450
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
	highp mat2 var[3];
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
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec2(7.0, -3.0));
	var[0][1] = (vec2(-2.0, 4.0));
	var[1][0] = (vec2(1.0, -3.0));
	var[1][1] = (vec2(2.0, -4.0));
	var[2][0] = (vec2(-1.0, 1.0));
	var[2][1] = (vec2(-4.0, 3.0));
}
#version 450
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

	var[0] = (vec4(-5.0, 8.0, 3.0, -4.0));
	var[1] = (vec4(-6.0, -1.0, -3.0, 6.0));
	var[2] = (vec4(5.0, -9.0, 4.0, -1.0));
	var[3] = (vec4(-7.0, -6.0, -2.0, -8.0));
	var[4] = (vec4(8.0, 7.0, 5.0, 1.0));
	var[5] = (vec4(-6.0, -5.0, -8.0, 8.0));
	var[6] = (vec4(0.0, 8.0, 4.0, -4.0));
	var[7] = (vec4(-8.0, -3.0, 9.0, -7.0));
	var[8] = (vec4(-9.0, 2.0, -6.0, 6.0));
	var[9] = (vec4(6.0, 2.0, -3.0, 0.0));
	var[10] = (vec4(-9.0, 8.0, -8.0, 0.0));
	var[11] = (vec4(2.0, 6.0, 6.0, 1.0));
	var[12] = (vec4(1.0, 7.0, 1.0, 1.0));
	var[13] = (vec4(-7.0, -6.0, -7.0, -4.0));
	var[14] = (vec4(8.0, -1.0, -6.0, -8.0));
	var[15] = (vec4(9.0, 7.0, -3.0, -8.0));
	var[16] = (vec4(-3.0, -9.0, 2.0, 1.0));
	var[17] = (vec4(-7.0, 3.0, -5.0, 8.0));
	var[18] = (vec4(5.0, -4.0, -5.0, 6.0));
}
#version 450
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

	var[0] = (mat4x3(7.0, 8.0, 8.0, -3.0, -9.0, 2.0, -6.0, 0.0, -4.0, -3.0, 4.0, -8.0));
	var[1] = (mat4x3(4.0, -2.0, 2.0, 8.0, 4.0, -1.0, -8.0, -6.0, -4.0, 9.0, -2.0, 1.0));
	var[2] = (mat4x3(-7.0, -4.0, -4.0, -1.0, 7.0, -6.0, 4.0, 6.0, 7.0, -9.0, -8.0, 3.0));
	var[3] = (mat4x3(-6.0, -5.0, 6.0, -2.0, -7.0, 5.0, 4.0, -6.0, -4.0, -7.0, 2.0, -7.0));
	var[4] = (mat4x3(-6.0, 5.0, -6.0, 9.0, -8.0, -5.0, -2.0, -8.0, -9.0, -8.0, -1.0, 2.0));
	var[5] = (mat4x3(-7.0, -2.0, 1.0, 0.0, 8.0, -7.0, 0.0, 0.0, 7.0, 0.0, -4.0, -7.0));
	var[6] = (mat4x3(-9.0, -7.0, 2.0, 2.0, 6.0, 9.0, 9.0, 5.0, -3.0, -4.0, -1.0, -5.0));
	var[7] = (mat4x3(-8.0, -4.0, -2.0, 7.0, 3.0, -9.0, 8.0, 1.0, -1.0, -7.0, -6.0, 2.0));
	var[8] = (mat4x3(-3.0, -7.0, 7.0, -5.0, 5.0, -8.0, 4.0, 8.0, -9.0, 6.0, -3.0, 2.0));
	var[9] = (mat4x3(3.0, -8.0, 6.0, -2.0, 8.0, -2.0, -2.0, -5.0, -1.0, -7.0, -9.0, 3.0));
	var[10] = (mat4x3(-6.0, -9.0, -4.0, -6.0, -1.0, -8.0, 9.0, 6.0, -8.0, -6.0, -5.0, 1.0));
	var[11] = (mat4x3(-1.0, -9.0, 4.0, 0.0, 9.0, 3.0, 5.0, 7.0, -4.0, -7.0, 3.0, 9.0));
	var[12] = (mat4x3(-2.0, 3.0, 9.0, 9.0, -7.0, 4.0, 4.0, 8.0, 7.0, -7.0, 2.0, 2.0));
	var[13] = (mat4x3(-2.0, -1.0, -7.0, 6.0, 7.0, -7.0, 6.0, 0.0, 2.0, -3.0, -6.0, -4.0));
	var[14] = (mat4x3(5.0, -5.0, 1.0, 9.0, 0.0, 3.0, 6.0, -8.0, 7.0, -6.0, 0.0, -2.0));
	var[15] = (mat4x3(3.0, 0.0, 5.0, 8.0, 6.0, -4.0, 7.0, 1.0, 1.0, 5.0, -3.0, -3.0));
	var[16] = (mat4x3(5.0, -3.0, -4.0, -9.0, 2.0, 9.0, -3.0, 1.0, -8.0, -8.0, 0.0, 9.0));
	var[17] = (mat4x3(-8.0, 9.0, -9.0, 4.0, -4.0, 3.0, -4.0, -1.0, -6.0, -7.0, 7.0, 6.0));
	var[18] = (mat4x3(-6.0, 5.0, 8.0, 3.0, -8.0, 8.0, -6.0, -2.0, 5.0, 6.0, 4.0, 8.0));
}
#version 450
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

	var[0] = (false);
	var[1] = (false);
	var[2] = (true);
	var[3] = (true);
	var[4] = (false);
	var[5] = (false);
	var[6] = (true);
	var[7] = (true);
	var[8] = (true);
	var[9] = (true);
	var[10] = (false);
	var[11] = (false);
	var[12] = (false);
	var[13] = (false);
	var[14] = (true);
	var[15] = (false);
	var[16] = (true);
	var[17] = (false);
	var[18] = (true);
}
#version 450
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

layout(scalar, column_major, binding = 1) buffer Block
{
	highp mat3x2 var[];
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
	allOk = compare_mat3x2(var[3], mat3x2(-8.0, -4.0, 7.0, 3.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[4], mat3x2(0.0, 9.0, -4.0, -9.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[5], mat3x2(0.0, 9.0, 2.0, -2.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[6], mat3x2(0.0, 6.0, -2.0, 6.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[7], mat3x2(1.0, 5.0, 8.0, 3.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[8], mat3x2(0.0, 9.0, -2.0, 3.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[9], mat3x2(-3.0, 4.0, 1.0, -5.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[10], mat3x2(1.0, -8.0, -7.0, -8.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[11], mat3x2(-5.0, -4.0, 7.0, 3.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[12], mat3x2(-1.0, -4.0, 1.0, 0.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[13], mat3x2(-1.0, 6.0, -9.0, -3.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[14], mat3x2(5.0, 2.0, -7.0, -9.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[15], mat3x2(-6.0, -4.0, 0.0, -4.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[16], mat3x2(-8.0, -6.0, -9.0, 9.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[17], mat3x2(-7.0, 4.0, -5.0, -9.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[18], mat3x2(5.0, 0.0, 7.0, -1.0, 9.0, 9.0)) && allOk;
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
	var[3][0] = (vec2(4.0, 6.0));
	var[3][1] = (vec2(3.0, 6.0));
	var[3][2] = (vec2(-2.0, -9.0));
	var[4][0] = (vec2(-9.0, 0.0));
	var[4][1] = (vec2(-4.0, 9.0));
	var[4][2] = (vec2(-1.0, -1.0));
	var[5][0] = (vec2(-8.0, 6.0));
	var[5][1] = (vec2(5.0, -2.0));
	var[5][2] = (vec2(1.0, 4.0));
	var[6][0] = (vec2(2.0, -5.0));
	var[6][1] = (vec2(-5.0, -9.0));
	var[6][2] = (vec2(-7.0, 3.0));
	var[7][0] = (vec2(-1.0, 0.0));
	var[7][1] = (vec2(-1.0, 4.0));
	var[7][2] = (vec2(-1.0, -6.0));
	var[8][0] = (vec2(-8.0, -6.0));
	var[8][1] = (vec2(8.0, 7.0));
	var[8][2] = (vec2(4.0, -9.0));
	var[9][0] = (vec2(-4.0, -1.0));
	var[9][1] = (vec2(-3.0, -2.0));
	var[9][2] = (vec2(-5.0, -2.0));
	var[10][0] = (vec2(-7.0, -3.0));
	var[10][1] = (vec2(5.0, 4.0));
	var[10][2] = (vec2(4.0, 1.0));
	var[11][0] = (vec2(-3.0, -6.0));
	var[11][1] = (vec2(-4.0, -2.0));
	var[11][2] = (vec2(-5.0, -7.0));
	var[12][0] = (vec2(2.0, 6.0));
	var[12][1] = (vec2(6.0, 1.0));
	var[12][2] = (vec2(4.0, -8.0));
	var[13][0] = (vec2(2.0, -5.0));
	var[13][1] = (vec2(-5.0, 5.0));
	var[13][2] = (vec2(2.0, -1.0));
	var[14][0] = (vec2(-9.0, 3.0));
	var[14][1] = (vec2(6.0, 5.0));
	var[14][2] = (vec2(-1.0, -8.0));
	var[15][0] = (vec2(2.0, -1.0));
	var[15][1] = (vec2(0.0, -2.0));
	var[15][2] = (vec2(-4.0, 6.0));
	var[16][0] = (vec2(2.0, -3.0));
	var[16][1] = (vec2(-2.0, 1.0));
	var[16][2] = (vec2(-3.0, 8.0));
	var[17][0] = (vec2(5.0, -1.0));
	var[17][1] = (vec2(-4.0, -4.0));
	var[17][2] = (vec2(7.0, -6.0));
	var[18][0] = (vec2(-2.0, -8.0));
	var[18][1] = (vec2(0.0, -2.0));
	var[18][2] = (vec2(8.0, -2.0));
}
#version 450
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
	u8vec4 var[4][3];
};

bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(var[0][0]), uvec4(3u, 4u, 6u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[0][1]), uvec4(1u, 5u, 7u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[0][2]), uvec4(1u, 4u, 6u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[1][0]), uvec4(7u, 7u, 6u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[1][1]), uvec4(3u, 3u, 3u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[1][2]), uvec4(7u, 2u, 2u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[2][0]), uvec4(6u, 9u, 5u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[2][1]), uvec4(5u, 2u, 0u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[2][2]), uvec4(8u, 3u, 7u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[3][0]), uvec4(5u, 7u, 4u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[3][1]), uvec4(5u, 8u, 5u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[3][2]), uvec4(8u, 6u, 3u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = u8vec4(uvec4(9u, 5u, 9u, 4u));
	var[0][1] = u8vec4(uvec4(6u, 8u, 7u, 3u));
	var[0][2] = u8vec4(uvec4(6u, 7u, 1u, 9u));
	var[1][0] = u8vec4(uvec4(8u, 9u, 3u, 3u));
	var[1][1] = u8vec4(uvec4(3u, 9u, 0u, 6u));
	var[1][2] = u8vec4(uvec4(8u, 7u, 6u, 7u));
	var[2][0] = u8vec4(uvec4(7u, 7u, 4u, 8u));
	var[2][1] = u8vec4(uvec4(8u, 5u, 3u, 1u));
	var[2][2] = u8vec4(uvec4(1u, 4u, 7u, 1u));
	var[3][0] = u8vec4(uvec4(3u, 6u, 3u, 3u));
	var[3][1] = u8vec4(uvec4(4u, 7u, 8u, 8u));
	var[3][2] = u8vec4(uvec4(1u, 7u, 7u, 2u));
}
#version 450
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
	int8_t var[4][3];
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(var[0][0]), 4294967292) && allOk;
	allOk = compare_int8_t(int(var[0][1]), 3) && allOk;
	allOk = compare_int8_t(int(var[0][2]), 3) && allOk;
	allOk = compare_int8_t(int(var[1][0]), 1) && allOk;
	allOk = compare_int8_t(int(var[1][1]), 6) && allOk;
	allOk = compare_int8_t(int(var[1][2]), 8) && allOk;
	allOk = compare_int8_t(int(var[2][0]), 5) && allOk;
	allOk = compare_int8_t(int(var[2][1]), 2) && allOk;
	allOk = compare_int8_t(int(var[2][2]), 0) && allOk;
	allOk = compare_int8_t(int(var[3][0]), 4294967292) && allOk;
	allOk = compare_int8_t(int(var[3][1]), 4294967287) && allOk;
	allOk = compare_int8_t(int(var[3][2]), 4294967289) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = int8_t(4294967290);
	var[0][1] = int8_t(4294967294);
	var[0][2] = int8_t(3);
	var[1][0] = int8_t(4294967288);
	var[1][1] = int8_t(1);
	var[1][2] = int8_t(2);
	var[2][0] = int8_t(4294967288);
	var[2][1] = int8_t(4294967294);
	var[2][2] = int8_t(7);
	var[3][0] = int8_t(9);
	var[3][1] = int8_t(0);
	var[3][2] = int8_t(4294967292);
}
#version 450
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
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_mat2x3(var[0][0], mat2x3(-6.0, 2.0, 1.0, -3.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[0][1], mat2x3(-2.0, 7.0, -9.0, -9.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[0][2], mat2x3(-6.0, 5.0, -6.0, -2.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[1][0], mat2x3(-2.0, 9.0, -1.0, -5.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[1][1], mat2x3(-8.0, 1.0, -5.0, 5.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[1][2], mat2x3(-3.0, 2.0, 9.0, -2.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[2][0], mat2x3(-2.0, 9.0, -4.0, 7.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[2][1], mat2x3(7.0, 6.0, 8.0, -9.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[2][2], mat2x3(2.0, 3.0, -1.0, -5.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[3][0], mat2x3(4.0, 9.0, 6.0, 0.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[3][1], mat2x3(3.0, -6.0, 0.0, -9.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[3][2], mat2x3(4.0, 1.0, -6.0, 5.0, -6.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-7.0);
	var[0][0][0] = (vec3(-6.0, -3.0, -4.0));
	var[0][0][1] = (vec3(-8.0, 7.0, 3.0));
	var[0][1][0] = (vec3(-2.0, 5.0, 6.0));
	var[0][1][1] = (vec3(-8.0, -9.0, 6.0));
	var[0][2][0] = (vec3(1.0, 1.0, -3.0));
	var[0][2][1] = (vec3(-5.0, -7.0, 9.0));
	var[1][0][0] = (vec3(5.0, -4.0, 6.0));
	var[1][0][1] = (vec3(-7.0, 2.0, -3.0));
	var[1][1][0] = (vec3(8.0, 2.0, 4.0));
	var[1][1][1] = (vec3(-8.0, 6.0, 0.0));
	var[1][2][0] = (vec3(-2.0, 1.0, -3.0));
	var[1][2][1] = (vec3(8.0, 0.0, -6.0));
	var[2][0][0] = (vec3(3.0, -2.0, -9.0));
	var[2][0][1] = (vec3(3.0, 9.0, -7.0));
	var[2][1][0] = (vec3(-7.0, 2.0, -3.0));
	var[2][1][1] = (vec3(-8.0, -6.0, 1.0));
	var[2][2][0] = (vec3(7.0, -2.0, -6.0));
	var[2][2][1] = (vec3(-1.0, 8.0, -1.0));
	var[3][0][0] = (vec3(-1.0, 1.0, -1.0));
	var[3][0][1] = (vec3(-1.0, -5.0, 5.0));
	var[3][1][0] = (vec3(6.0, 7.0, -2.0));
	var[3][1][1] = (vec3(5.0, -6.0, -5.0));
	var[3][2][0] = (vec3(4.0, -3.0, -7.0));
	var[3][2][1] = (vec3(-7.0, -1.0, 5.0));
}
#version 450
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
	highp vec2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((var[0][0][0]), vec2(5.0, 4.0)) && allOk;
	allOk = compare_vec2((var[0][0][1]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((var[0][0][2]), vec2(-7.0, -5.0)) && allOk;
	allOk = compare_vec2((var[0][1][0]), vec2(-1.0, -4.0)) && allOk;
	allOk = compare_vec2((var[0][1][1]), vec2(6.0, -7.0)) && allOk;
	allOk = compare_vec2((var[0][1][2]), vec2(-8.0, 7.0)) && allOk;
	allOk = compare_vec2((var[1][0][0]), vec2(-9.0, 7.0)) && allOk;
	allOk = compare_vec2((var[1][0][1]), vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec2((var[1][0][2]), vec2(-8.0, 2.0)) && allOk;
	allOk = compare_vec2((var[1][1][0]), vec2(2.0, -3.0)) && allOk;
	allOk = compare_vec2((var[1][1][1]), vec2(4.0, -5.0)) && allOk;
	allOk = compare_vec2((var[1][1][2]), vec2(-6.0, -4.0)) && allOk;
	allOk = compare_vec2((var[2][0][0]), vec2(4.0, -2.0)) && allOk;
	allOk = compare_vec2((var[2][0][1]), vec2(2.0, 2.0)) && allOk;
	allOk = compare_vec2((var[2][0][2]), vec2(-8.0, 3.0)) && allOk;
	allOk = compare_vec2((var[2][1][0]), vec2(-5.0, 7.0)) && allOk;
	allOk = compare_vec2((var[2][1][1]), vec2(1.0, -2.0)) && allOk;
	allOk = compare_vec2((var[2][1][2]), vec2(-3.0, -5.0)) && allOk;
	allOk = compare_vec2((var[3][0][0]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((var[3][0][1]), vec2(7.0, 5.0)) && allOk;
	allOk = compare_vec2((var[3][0][2]), vec2(-6.0, -1.0)) && allOk;
	allOk = compare_vec2((var[3][1][0]), vec2(5.0, -8.0)) && allOk;
	allOk = compare_vec2((var[3][1][1]), vec2(-1.0, -7.0)) && allOk;
	allOk = compare_vec2((var[3][1][2]), vec2(-7.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec2(3.0, 8.0));
	var[0][0][1] = (vec2(7.0, -1.0));
	var[0][0][2] = (vec2(-4.0, 8.0));
	var[0][1][0] = (vec2(-6.0, -2.0));
	var[0][1][1] = (vec2(5.0, 4.0));
	var[0][1][2] = (vec2(0.0, 0.0));
	var[1][0][0] = (vec2(-2.0, -5.0));
	var[1][0][1] = (vec2(-2.0, 5.0));
	var[1][0][2] = (vec2(6.0, -2.0));
	var[1][1][0] = (vec2(-4.0, -9.0));
	var[1][1][1] = (vec2(-2.0, 2.0));
	var[1][1][2] = (vec2(-2.0, 8.0));
	var[2][0][0] = (vec2(-6.0, -6.0));
	var[2][0][1] = (vec2(1.0, 6.0));
	var[2][0][2] = (vec2(-7.0, 6.0));
	var[2][1][0] = (vec2(-4.0, -4.0));
	var[2][1][1] = (vec2(-2.0, -8.0));
	var[2][1][2] = (vec2(2.0, 9.0));
	var[3][0][0] = (vec2(1.0, -6.0));
	var[3][0][1] = (vec2(-9.0, 0.0));
	var[3][0][2] = (vec2(-8.0, -4.0));
	var[3][1][0] = (vec2(-8.0, 9.0));
	var[3][1][1] = (vec2(0.0, -8.0));
	var[3][1][2] = (vec2(1.0, 5.0));
}
#version 450
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
	highp mat3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0][0][0], mat3(6.0, -4.0, 9.0, -9.0, 3.0, 9.0, 6.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(8.0, 5.0, -8.0, -6.0, -8.0, -7.0, -4.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3(var[0][0][2], mat3(-4.0, -2.0, -2.0, -8.0, -8.0, -5.0, -4.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(1.0, 8.0, -5.0, -5.0, -8.0, -4.0, -7.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(-5.0, -8.0, 6.0, 4.0, -3.0, 9.0, -2.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3(var[0][1][2], mat3(-2.0, 7.0, -4.0, 4.0, -4.0, 1.0, 6.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(3.0, 7.0, 0.0, 6.0, 5.0, 0.0, -5.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(4.0, 9.0, 9.0, -6.0, 9.0, -6.0, 9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3(var[1][0][2], mat3(-9.0, -9.0, -2.0, -6.0, 7.0, 7.0, 8.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(2.0, -6.0, 4.0, -6.0, 8.0, 1.0, -7.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(6.0, 5.0, 5.0, -1.0, -9.0, -7.0, 7.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3(var[1][1][2], mat3(0.0, -7.0, 0.0, -4.0, 1.0, -7.0, 1.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(-2.0, -1.0, -3.0, 3.0, -5.0, -1.0, 1.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(-4.0, 9.0, 6.0, -9.0, 2.0, 8.0, -5.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3(var[2][0][2], mat3(6.0, -4.0, -2.0, 3.0, 0.0, -7.0, -5.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(2.0, -4.0, -2.0, -7.0, 2.0, -2.0, 9.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(3.0, -2.0, 5.0, -3.0, 7.0, -5.0, 2.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3(var[2][1][2], mat3(2.0, 2.0, 8.0, -3.0, -7.0, -9.0, -7.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat3(var[3][0][0], mat3(0.0, 5.0, 6.0, -6.0, -7.0, 9.0, 0.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3(var[3][0][1], mat3(-3.0, -7.0, -7.0, -5.0, 8.0, 3.0, 7.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3(var[3][0][2], mat3(8.0, 4.0, -6.0, 0.0, 6.0, 5.0, -3.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3(var[3][1][0], mat3(-6.0, 7.0, -4.0, 4.0, 5.0, 3.0, 0.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(var[3][1][1], mat3(5.0, -9.0, 6.0, -4.0, -2.0, -4.0, 3.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3(var[3][1][2], mat3(0.0, -9.0, 2.0, -6.0, 6.0, 7.0, 8.0, -2.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec3(2.0, -4.0, 9.0));
	var[0][0][0][1] = (vec3(-4.0, 2.0, 5.0));
	var[0][0][0][2] = (vec3(5.0, -9.0, -5.0));
	var[0][0][1][0] = (vec3(3.0, 1.0, 8.0));
	var[0][0][1][1] = (vec3(6.0, 9.0, -8.0));
	var[0][0][1][2] = (vec3(-1.0, 5.0, 1.0));
	var[0][0][2][0] = (vec3(6.0, -5.0, -4.0));
	var[0][0][2][1] = (vec3(-8.0, -8.0, -2.0));
	var[0][0][2][2] = (vec3(9.0, -4.0, 4.0));
	var[0][1][0][0] = (vec3(-9.0, -8.0, 2.0));
	var[0][1][0][1] = (vec3(-6.0, 9.0, -7.0));
	var[0][1][0][2] = (vec3(9.0, 6.0, 1.0));
	var[0][1][1][0] = (vec3(-4.0, 8.0, -7.0));
	var[0][1][1][1] = (vec3(1.0, 0.0, 4.0));
	var[0][1][1][2] = (vec3(-6.0, -3.0, 3.0));
	var[0][1][2][0] = (vec3(-5.0, -6.0, 5.0));
	var[0][1][2][1] = (vec3(4.0, 3.0, -2.0));
	var[0][1][2][2] = (vec3(-6.0, -4.0, -1.0));
	var[1][0][0][0] = (vec3(4.0, -1.0, 5.0));
	var[1][0][0][1] = (vec3(-1.0, 0.0, 9.0));
	var[1][0][0][2] = (vec3(7.0, 7.0, 5.0));
	var[1][0][1][0] = (vec3(8.0, -6.0, -1.0));
	var[1][0][1][1] = (vec3(-1.0, -2.0, -5.0));
	var[1][0][1][2] = (vec3(-5.0, 6.0, -3.0));
	var[1][0][2][0] = (vec3(-4.0, -6.0, 2.0));
	var[1][0][2][1] = (vec3(3.0, -1.0, 2.0));
	var[1][0][2][2] = (vec3(-3.0, 4.0, 1.0));
	var[1][1][0][0] = (vec3(4.0, 4.0, -6.0));
	var[1][1][0][1] = (vec3(0.0, 2.0, -5.0));
	var[1][1][0][2] = (vec3(5.0, 8.0, -2.0));
	var[1][1][1][0] = (vec3(3.0, -1.0, 7.0));
	var[1][1][1][1] = (vec3(-9.0, -9.0, -8.0));
	var[1][1][1][2] = (vec3(9.0, -9.0, -5.0));
	var[1][1][2][0] = (vec3(1.0, -2.0, 1.0));
	var[1][1][2][1] = (vec3(-8.0, -4.0, -3.0));
	var[1][1][2][2] = (vec3(3.0, -4.0, -3.0));
	var[2][0][0][0] = (vec3(9.0, -3.0, -9.0));
	var[2][0][0][1] = (vec3(6.0, -1.0, -6.0));
	var[2][0][0][2] = (vec3(6.0, 2.0, -5.0));
	var[2][0][1][0] = (vec3(-1.0, -2.0, 2.0));
	var[2][0][1][1] = (vec3(9.0, 1.0, -8.0));
	var[2][0][1][2] = (vec3(6.0, -1.0, 7.0));
	var[2][0][2][0] = (vec3(4.0, 2.0, -8.0));
	var[2][0][2][1] = (vec3(0.0, 3.0, 9.0));
	var[2][0][2][2] = (vec3(9.0, -8.0, -4.0));
	var[2][1][0][0] = (vec3(-5.0, 7.0, 5.0));
	var[2][1][0][1] = (vec3(-2.0, -2.0, 8.0));
	var[2][1][0][2] = (vec3(-3.0, 1.0, 7.0));
	var[2][1][1][0] = (vec3(-9.0, 8.0, 7.0));
	var[2][1][1][1] = (vec3(2.0, 2.0, -5.0));
	var[2][1][1][2] = (vec3(-8.0, -5.0, 6.0));
	var[2][1][2][0] = (vec3(4.0, 1.0, 9.0));
	var[2][1][2][1] = (vec3(5.0, -6.0, 7.0));
	var[2][1][2][2] = (vec3(-7.0, -2.0, -6.0));
	var[3][0][0][0] = (vec3(-8.0, 3.0, 4.0));
	var[3][0][0][1] = (vec3(-4.0, 4.0, 1.0));
	var[3][0][0][2] = (vec3(0.0, 4.0, 5.0));
	var[3][0][1][0] = (vec3(-9.0, -4.0, 2.0));
	var[3][0][1][1] = (vec3(-6.0, 8.0, 3.0));
	var[3][0][1][2] = (vec3(2.0, 0.0, -1.0));
	var[3][0][2][0] = (vec3(7.0, 1.0, 3.0));
	var[3][0][2][1] = (vec3(5.0, 1.0, -6.0));
	var[3][0][2][2] = (vec3(2.0, -5.0, 4.0));
	var[3][1][0][0] = (vec3(0.0, -9.0, 7.0));
	var[3][1][0][1] = (vec3(-2.0, 0.0, 5.0));
	var[3][1][0][2] = (vec3(8.0, 8.0, -1.0));
	var[3][1][1][0] = (vec3(-4.0, 3.0, 5.0));
	var[3][1][1][1] = (vec3(-9.0, 8.0, -7.0));
	var[3][1][1][2] = (vec3(7.0, -3.0, 4.0));
	var[3][1][2][0] = (vec3(-6.0, 3.0, 6.0));
	var[3][1][2][1] = (vec3(-9.0, 9.0, 3.0));
	var[3][1][2][2] = (vec3(8.0, 8.0, -2.0));
}
#version 450
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

layout(std140, column_major, binding = 1) buffer Block
{
	highp mat4x3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0][0][0], mat4x3(-7.0, 1.0, 0.0, 0.0, -7.0, 2.0, 5.0, 0.0, 3.0, 2.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(-7.0, -5.0, 2.0, 0.0, -1.0, -5.0, 5.0, 5.0, 9.0, -7.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][2], mat4x3(3.0, 6.0, -7.0, 7.0, 8.0, 6.0, -7.0, -8.0, -5.0, -9.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(8.0, -2.0, 5.0, 8.0, 5.0, -1.0, 2.0, -4.0, -9.0, -5.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(-2.0, 7.0, -4.0, 9.0, 4.0, -1.0, -2.0, -8.0, 7.0, 9.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][2], mat4x3(6.0, 1.0, 9.0, 3.0, -6.0, -4.0, 9.0, 3.0, -7.0, -3.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(-7.0, -7.0, 7.0, 2.0, -5.0, 3.0, 2.0, 0.0, 8.0, -1.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(-8.0, 6.0, 2.0, -5.0, -7.0, -7.0, -4.0, -9.0, 7.0, 3.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][2], mat4x3(-7.0, 7.0, 6.0, 3.0, 4.0, 5.0, -2.0, 3.0, 8.0, -7.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(2.0, -4.0, -5.0, 2.0, -6.0, -3.0, -7.0, 2.0, 6.0, 4.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(7.0, 2.0, -9.0, -6.0, -7.0, -2.0, -2.0, 6.0, -5.0, -9.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][2], mat4x3(-4.0, 1.0, -3.0, -3.0, -1.0, -5.0, -5.0, 7.0, -9.0, 6.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(0.0, 7.0, 1.0, -2.0, 9.0, -5.0, -3.0, 1.0, -6.0, 6.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(9.0, 8.0, 5.0, 4.0, 7.0, -1.0, 6.0, -6.0, 2.0, 8.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][2], mat4x3(0.0, 6.0, -8.0, -4.0, -8.0, 8.0, -5.0, 7.0, 3.0, 9.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(8.0, -3.0, 5.0, 4.0, -3.0, 7.0, -7.0, -8.0, -9.0, 2.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(7.0, 3.0, -1.0, -6.0, 2.0, 2.0, -2.0, -9.0, -7.0, -1.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][2], mat4x3(8.0, -5.0, 6.0, -8.0, 6.0, 3.0, 6.0, -5.0, 9.0, -1.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][0], mat4x3(6.0, -3.0, 0.0, -3.0, 2.0, -8.0, 6.0, 5.0, -2.0, 2.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][1], mat4x3(-7.0, 4.0, 5.0, -8.0, -1.0, -2.0, -8.0, -4.0, 2.0, 8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][2], mat4x3(4.0, -1.0, 3.0, 3.0, -3.0, 4.0, -6.0, -5.0, 1.0, 4.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][0], mat4x3(6.0, 3.0, -8.0, -6.0, -6.0, 0.0, 4.0, -1.0, 4.0, -5.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][1], mat4x3(6.0, 9.0, -3.0, 5.0, 2.0, -6.0, -7.0, -3.0, -2.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][2], mat4x3(-5.0, 7.0, 5.0, -4.0, 6.0, 1.0, -7.0, 9.0, 2.0, -1.0, -4.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4x3(7.0, 8.0, 8.0, -3.0, -9.0, 2.0, -6.0, 0.0, -4.0, -3.0, 4.0, -8.0));
	var[0][0][1] = (mat4x3(4.0, -2.0, 2.0, 8.0, 4.0, -1.0, -8.0, -6.0, -4.0, 9.0, -2.0, 1.0));
	var[0][0][2] = (mat4x3(-7.0, -4.0, -4.0, -1.0, 7.0, -6.0, 4.0, 6.0, 7.0, -9.0, -8.0, 3.0));
	var[0][1][0] = (mat4x3(-2.0, 3.0, 9.0, 9.0, -7.0, 4.0, 4.0, 8.0, 7.0, -7.0, 2.0, 2.0));
	var[0][1][1] = (mat4x3(-2.0, -1.0, -7.0, 6.0, 7.0, -7.0, 6.0, 0.0, 2.0, -3.0, -6.0, -4.0));
	var[0][1][2] = (mat4x3(5.0, -5.0, 1.0, 9.0, 0.0, 3.0, 6.0, -8.0, 7.0, -6.0, 0.0, -2.0));
	var[1][0][0] = (mat4x3(-6.0, -5.0, 6.0, -2.0, -7.0, 5.0, 4.0, -6.0, -4.0, -7.0, 2.0, -7.0));
	var[1][0][1] = (mat4x3(-6.0, 5.0, -6.0, 9.0, -8.0, -5.0, -2.0, -8.0, -9.0, -8.0, -1.0, 2.0));
	var[1][0][2] = (mat4x3(-7.0, -2.0, 1.0, 0.0, 8.0, -7.0, 0.0, 0.0, 7.0, 0.0, -4.0, -7.0));
	var[1][1][0] = (mat4x3(3.0, 0.0, 5.0, 8.0, 6.0, -4.0, 7.0, 1.0, 1.0, 5.0, -3.0, -3.0));
	var[1][1][1] = (mat4x3(5.0, -3.0, -4.0, -9.0, 2.0, 9.0, -3.0, 1.0, -8.0, -8.0, 0.0, 9.0));
	var[1][1][2] = (mat4x3(-8.0, 9.0, -9.0, 4.0, -4.0, 3.0, -4.0, -1.0, -6.0, -7.0, 7.0, 6.0));
	var[2][0][0] = (mat4x3(-9.0, -7.0, 2.0, 2.0, 6.0, 9.0, 9.0, 5.0, -3.0, -4.0, -1.0, -5.0));
	var[2][0][1] = (mat4x3(-8.0, -4.0, -2.0, 7.0, 3.0, -9.0, 8.0, 1.0, -1.0, -7.0, -6.0, 2.0));
	var[2][0][2] = (mat4x3(-3.0, -7.0, 7.0, -5.0, 5.0, -8.0, 4.0, 8.0, -9.0, 6.0, -3.0, 2.0));
	var[2][1][0] = (mat4x3(-6.0, 5.0, 8.0, 3.0, -8.0, 8.0, -6.0, -2.0, 5.0, 6.0, 4.0, 8.0));
	var[2][1][1] = (mat4x3(-9.0, 0.0, -2.0, -2.0, 9.0, 5.0, 0.0, -8.0, -1.0, 0.0, -6.0, 6.0));
	var[2][1][2] = (mat4x3(-4.0, 1.0, -2.0, -8.0, -6.0, 8.0, 0.0, 0.0, -5.0, 8.0, -1.0, -7.0));
	var[3][0][0] = (mat4x3(3.0, -8.0, 6.0, -2.0, 8.0, -2.0, -2.0, -5.0, -1.0, -7.0, -9.0, 3.0));
	var[3][0][1] = (mat4x3(-6.0, -9.0, -4.0, -6.0, -1.0, -8.0, 9.0, 6.0, -8.0, -6.0, -5.0, 1.0));
	var[3][0][2] = (mat4x3(-1.0, -9.0, 4.0, 0.0, 9.0, 3.0, 5.0, 7.0, -4.0, -7.0, 3.0, 9.0));
	var[3][1][0] = (mat4x3(-2.0, -2.0, 5.0, -5.0, -4.0, -9.0, -9.0, 1.0, -1.0, -8.0, 2.0, -9.0));
	var[3][1][1] = (mat4x3(-2.0, 3.0, 5.0, -9.0, -2.0, -6.0, 8.0, 6.0, 6.0, -9.0, 2.0, 5.0));
	var[3][1][2] = (mat4x3(-7.0, -4.0, -5.0, -3.0, 0.0, 4.0, 0.0, -4.0, -9.0, -5.0, -6.0, -2.0));
}
#version 450
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
	i16vec2 var[4][2][3];
};

bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(var[0][0][0]), ivec2(3, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(var[0][0][1]), ivec2(8, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(var[0][0][2]), ivec2(-4, 2)) && allOk;
	allOk = compare_i16vec2(ivec2(var[0][1][0]), ivec2(-1, 2)) && allOk;
	allOk = compare_i16vec2(ivec2(var[0][1][1]), ivec2(0, -4)) && allOk;
	allOk = compare_i16vec2(ivec2(var[0][1][2]), ivec2(-2, -2)) && allOk;
	allOk = compare_i16vec2(ivec2(var[1][0][0]), ivec2(-1, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(var[1][0][1]), ivec2(-1, -9)) && allOk;
	allOk = compare_i16vec2(ivec2(var[1][0][2]), ivec2(-1, -7)) && allOk;
	allOk = compare_i16vec2(ivec2(var[1][1][0]), ivec2(1, 0)) && allOk;
	allOk = compare_i16vec2(ivec2(var[1][1][1]), ivec2(-5, -5)) && allOk;
	allOk = compare_i16vec2(ivec2(var[1][1][2]), ivec2(-8, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(var[2][0][0]), ivec2(-6, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(var[2][0][1]), ivec2(-5, 6)) && allOk;
	allOk = compare_i16vec2(ivec2(var[2][0][2]), ivec2(-1, 8)) && allOk;
	allOk = compare_i16vec2(ivec2(var[2][1][0]), ivec2(-2, -8)) && allOk;
	allOk = compare_i16vec2(ivec2(var[2][1][1]), ivec2(-6, 7)) && allOk;
	allOk = compare_i16vec2(ivec2(var[2][1][2]), ivec2(8, -4)) && allOk;
	allOk = compare_i16vec2(ivec2(var[3][0][0]), ivec2(1, 1)) && allOk;
	allOk = compare_i16vec2(ivec2(var[3][0][1]), ivec2(6, -6)) && allOk;
	allOk = compare_i16vec2(ivec2(var[3][0][2]), ivec2(1, 1)) && allOk;
	allOk = compare_i16vec2(ivec2(var[3][1][0]), ivec2(0, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(var[3][1][1]), ivec2(-2, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(var[3][1][2]), ivec2(-6, 6)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = i16vec2(ivec2(6, -2));
	var[0][0][1] = i16vec2(ivec2(-2, -8));
	var[0][0][2] = i16vec2(ivec2(3, 5));
	var[0][1][0] = i16vec2(ivec2(6, 9));
	var[0][1][1] = i16vec2(ivec2(0, 9));
	var[0][1][2] = i16vec2(ivec2(0, 5));
	var[1][0][0] = i16vec2(ivec2(-9, -9));
	var[1][0][1] = i16vec2(ivec2(-4, -3));
	var[1][0][2] = i16vec2(ivec2(-2, 6));
	var[1][1][0] = i16vec2(ivec2(9, -8));
	var[1][1][1] = i16vec2(ivec2(4, 6));
	var[1][1][2] = i16vec2(ivec2(-9, -9));
	var[2][0][0] = i16vec2(ivec2(0, -1));
	var[2][0][1] = i16vec2(ivec2(3, -9));
	var[2][0][2] = i16vec2(ivec2(9, -6));
	var[2][1][0] = i16vec2(ivec2(4, 1));
	var[2][1][1] = i16vec2(ivec2(-5, -1));
	var[2][1][2] = i16vec2(ivec2(4, -5));
	var[3][0][0] = i16vec2(ivec2(-1, -7));
	var[3][0][1] = i16vec2(ivec2(-1, -6));
	var[3][0][2] = i16vec2(ivec2(6, 5));
	var[3][1][0] = i16vec2(ivec2(-6, 1));
	var[3][1][1] = i16vec2(ivec2(-8, 4));
	var[3][1][2] = i16vec2(ivec2(-6, 1));
}
#version 450
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
	highp mat3x2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0][0][0], mat3x2(-2.0, -4.0, -6.0, 5.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][1], mat3x2(2.0, 5.0, 9.0, -1.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][2], mat3x2(-6.0, -2.0, -3.0, 2.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][0], mat3x2(-5.0, -1.0, -4.0, 9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][1], mat3x2(1.0, -6.0, -3.0, -3.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][2], mat3x2(1.0, 7.0, 5.0, -5.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][0], mat3x2(-8.0, -4.0, -9.0, 9.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][1], mat3x2(0.0, 4.0, -7.0, -7.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][2], mat3x2(7.0, 1.0, 4.0, 8.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][0], mat3x2(-8.0, -9.0, 7.0, 4.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][1], mat3x2(8.0, -6.0, -5.0, -7.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][2], mat3x2(3.0, 2.0, -1.0, -1.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][0], mat3x2(-5.0, 4.0, 3.0, -8.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][1], mat3x2(4.0, -7.0, -6.0, 9.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][2], mat3x2(3.0, 0.0, -6.0, 7.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][0], mat3x2(-1.0, 2.0, -7.0, 2.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][1], mat3x2(-2.0, -2.0, 5.0, 6.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][2], mat3x2(-4.0, 6.0, -8.0, 8.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][0], mat3x2(-1.0, 5.0, -6.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][1], mat3x2(-4.0, 8.0, 9.0, -3.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][2], mat3x2(-8.0, -9.0, -6.0, -9.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][0], mat3x2(-9.0, 5.0, -9.0, 0.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][1], mat3x2(3.0, -5.0, -4.0, -3.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][2], mat3x2(-2.0, 7.0, 6.0, 6.0, 3.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3x2(2.0, -1.0, 2.0, -8.0, -4.0, 9.0));
	var[0][0][1] = (mat3x2(6.0, 8.0, 5.0, -7.0, -7.0, 0.0));
	var[0][0][2] = (mat3x2(5.0, 8.0, 1.0, -4.0, 1.0, 3.0));
	var[0][1][0] = (mat3x2(-6.0, -4.0, 8.0, 4.0, 5.0, 4.0));
	var[0][1][1] = (mat3x2(8.0, 3.0, 9.0, -4.0, -3.0, -6.0));
	var[0][1][2] = (mat3x2(-9.0, 8.0, 6.0, -7.0, 9.0, 2.0));
	var[1][0][0] = (mat3x2(0.0, -6.0, -9.0, 0.0, 8.0, 7.0));
	var[1][0][1] = (mat3x2(7.0, -7.0, 8.0, -7.0, -8.0, 9.0));
	var[1][0][2] = (mat3x2(-5.0, -9.0, -9.0, -4.0, 7.0, 7.0));
	var[1][1][0] = (mat3x2(-2.0, -3.0, -2.0, -4.0, 5.0, -4.0));
	var[1][1][1] = (mat3x2(9.0, -9.0, -9.0, -6.0, 8.0, 1.0));
	var[1][1][2] = (mat3x2(4.0, -2.0, 0.0, -9.0, 4.0, -2.0));
	var[2][0][0] = (mat3x2(3.0, -9.0, -7.0, 4.0, -8.0, -2.0));
	var[2][0][1] = (mat3x2(9.0, -1.0, 9.0, 7.0, 0.0, 3.0));
	var[2][0][2] = (mat3x2(-6.0, 5.0, -8.0, 1.0, 9.0, 5.0));
	var[2][1][0] = (mat3x2(3.0, 2.0, 8.0, -9.0, -3.0, -7.0));
	var[2][1][1] = (mat3x2(0.0, -5.0, -2.0, -1.0, -6.0, -9.0));
	var[2][1][2] = (mat3x2(-7.0, 8.0, 6.0, 5.0, -3.0, 0.0));
	var[3][0][0] = (mat3x2(-4.0, -3.0, -2.0, 3.0, -1.0, 1.0));
	var[3][0][1] = (mat3x2(-9.0, 4.0, 5.0, -3.0, 8.0, 4.0));
	var[3][0][2] = (mat3x2(8.0, -4.0, -8.0, 7.0, -4.0, 9.0));
	var[3][1][0] = (mat3x2(7.0, 4.0, 0.0, 5.0, 7.0, -2.0));
	var[3][1][1] = (mat3x2(-2.0, 8.0, -3.0, 4.0, 5.0, -1.0));
	var[3][1][2] = (mat3x2(-4.0, 3.0, 7.0, -8.0, 7.0, 3.0));
}
#version 450
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
	highp float var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 7.0) && allOk;
	allOk = compare_float((var[0][0][0]), -1.0) && allOk;
	allOk = compare_float((var[0][0][1]), -6.0) && allOk;
	allOk = compare_float((var[0][0][2]), 0.0) && allOk;
	allOk = compare_float((var[0][1][0]), -3.0) && allOk;
	allOk = compare_float((var[0][1][1]), -7.0) && allOk;
	allOk = compare_float((var[0][1][2]), 8.0) && allOk;
	allOk = compare_float((var[1][0][0]), -7.0) && allOk;
	allOk = compare_float((var[1][0][1]), 5.0) && allOk;
	allOk = compare_float((var[1][0][2]), 4.0) && allOk;
	allOk = compare_float((var[1][1][0]), -9.0) && allOk;
	allOk = compare_float((var[1][1][1]), -4.0) && allOk;
	allOk = compare_float((var[1][1][2]), -4.0) && allOk;
	allOk = compare_float((var[2][0][0]), 2.0) && allOk;
	allOk = compare_float((var[2][0][1]), -1.0) && allOk;
	allOk = compare_float((var[2][0][2]), -6.0) && allOk;
	allOk = compare_float((var[2][1][0]), -5.0) && allOk;
	allOk = compare_float((var[2][1][1]), 9.0) && allOk;
	allOk = compare_float((var[2][1][2]), 7.0) && allOk;
	allOk = compare_float((var[3][0][0]), -2.0) && allOk;
	allOk = compare_float((var[3][0][1]), -1.0) && allOk;
	allOk = compare_float((var[3][0][2]), 1.0) && allOk;
	allOk = compare_float((var[3][1][0]), -7.0) && allOk;
	allOk = compare_float((var[3][1][1]), 8.0) && allOk;
	allOk = compare_float((var[3][1][2]), 1.0) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-2.0);
	var[0][0][0] = (4.0);
	var[0][0][1] = (6.0);
	var[0][0][2] = (7.0);
	var[0][1][0] = (-9.0);
	var[0][1][1] = (-4.0);
	var[0][1][2] = (3.0);
	var[1][0][0] = (-4.0);
	var[1][0][1] = (5.0);
	var[1][0][2] = (-8.0);
	var[1][1][0] = (7.0);
	var[1][1][1] = (6.0);
	var[1][1][2] = (5.0);
	var[2][0][0] = (9.0);
	var[2][0][1] = (-5.0);
	var[2][0][2] = (8.0);
	var[2][1][0] = (4.0);
	var[2][1][1] = (-8.0);
	var[2][1][2] = (5.0);
	var[3][0][0] = (-5.0);
	var[3][0][1] = (6.0);
	var[3][0][2] = (-6.0);
	var[3][1][0] = (8.0);
	var[3][1][1] = (9.0);
	var[3][1][2] = (-5.0);
}
#version 450
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
	f16vec4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(var[0][0][0]), vec4(-8.0, -9.0, 9.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[0][0][1]), vec4(4.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[0][1][0]), vec4(2.0, 3.0, -3.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[0][1][1]), vec4(9.0, -9.0, 0.0, 3.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[0][2][0]), vec4(7.0, -7.0, -3.0, 1.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[0][2][1]), vec4(7.0, 0.0, -2.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[0][3][0]), vec4(1.0, 0.0, -7.0, 0.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[0][3][1]), vec4(-9.0, 0.0, 9.0, -9.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][0][0]), vec4(-8.0, 6.0, 1.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][0][1]), vec4(4.0, 7.0, 5.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][1][0]), vec4(2.0, -2.0, -4.0, -2.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][1][1]), vec4(-6.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][2][0]), vec4(-6.0, -5.0, 8.0, 0.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][2][1]), vec4(-9.0, 7.0, -3.0, -1.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][3][0]), vec4(-5.0, 3.0, 4.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][3][1]), vec4(-5.0, -8.0, 6.0, -5.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][0][0]), vec4(7.0, -4.0, -8.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][0][1]), vec4(-3.0, 6.0, -4.0, 5.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][1][0]), vec4(7.0, 5.0, -9.0, 9.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][1][1]), vec4(8.0, 7.0, 9.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][2][0]), vec4(2.0, 7.0, 0.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][2][1]), vec4(-7.0, 6.0, 0.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][3][0]), vec4(0.0, -8.0, -9.0, 7.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][3][1]), vec4(3.0, 9.0, -3.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = f16vec4(vec4(9.0, -6.0, 2.0, -8.0));
	var[0][0][1] = f16vec4(vec4(-7.0, -4.0, 2.0, -5.0));
	var[0][1][0] = f16vec4(vec4(-6.0, 2.0, -4.0, 8.0));
	var[0][1][1] = f16vec4(vec4(-4.0, -1.0, 8.0, 9.0));
	var[0][2][0] = f16vec4(vec4(8.0, 3.0, -7.0, -9.0));
	var[0][2][1] = f16vec4(vec4(6.0, -8.0, -8.0, 3.0));
	var[0][3][0] = f16vec4(vec4(-3.0, -6.0, 7.0, 3.0));
	var[0][3][1] = f16vec4(vec4(-6.0, -9.0, -2.0, 7.0));
	var[1][0][0] = f16vec4(vec4(9.0, 1.0, -6.0, 3.0));
	var[1][0][1] = f16vec4(vec4(-1.0, 4.0, -1.0, -8.0));
	var[1][1][0] = f16vec4(vec4(0.0, 0.0, -5.0, 5.0));
	var[1][1][1] = f16vec4(vec4(7.0, -6.0, -7.0, -8.0));
	var[1][2][0] = f16vec4(vec4(1.0, -6.0, -6.0, 9.0));
	var[1][2][1] = f16vec4(vec4(9.0, -7.0, 7.0, -4.0));
	var[1][3][0] = f16vec4(vec4(2.0, -6.0, -5.0, 8.0));
	var[1][3][1] = f16vec4(vec4(6.0, 1.0, -5.0, 6.0));
	var[2][0][0] = f16vec4(vec4(5.0, 8.0, 7.0, 0.0));
	var[2][0][1] = f16vec4(vec4(4.0, -5.0, -6.0, -8.0));
	var[2][1][0] = f16vec4(vec4(-3.0, -4.0, -7.0, 0.0));
	var[2][1][1] = f16vec4(vec4(-7.0, -2.0, 7.0, -1.0));
	var[2][2][0] = f16vec4(vec4(-3.0, 0.0, -5.0, -5.0));
	var[2][2][1] = f16vec4(vec4(-6.0, -7.0, -2.0, -8.0));
	var[2][3][0] = f16vec4(vec4(-5.0, -9.0, -6.0, -4.0));
	var[2][3][1] = f16vec4(vec4(-5.0, -8.0, 1.0, 2.0));
}
#version 450
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
	highp mat2x4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0][0][0], mat2x4(-3.0, 3.0, 6.0, 0.0, -2.0, 1.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(0.0, -1.0, 3.0, 9.0, 1.0, 1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(-6.0, -5.0, 8.0, 2.0, -2.0, 9.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(-1.0, 5.0, 0.0, -4.0, 2.0, 3.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[0][2][0], mat2x4(9.0, 0.0, -3.0, 4.0, 4.0, -5.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[0][2][1], mat2x4(-8.0, -3.0, 1.0, 8.0, -8.0, 0.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[0][3][0], mat2x4(1.0, 9.0, -9.0, -8.0, 5.0, -5.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[0][3][1], mat2x4(1.0, -8.0, 8.0, 4.0, 5.0, -7.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(6.0, 1.0, -8.0, 2.0, 2.0, -6.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(1.0, -3.0, -7.0, -4.0, 0.0, -9.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(2.0, 1.0, 0.0, -1.0, -5.0, 2.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(3.0, 3.0, 4.0, 8.0, 4.0, -5.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[1][2][0], mat2x4(-5.0, 5.0, 8.0, -8.0, 4.0, 7.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[1][2][1], mat2x4(5.0, 9.0, 3.0, -3.0, -8.0, 3.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[1][3][0], mat2x4(0.0, 8.0, 4.0, 8.0, -5.0, -2.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[1][3][1], mat2x4(-5.0, 9.0, -7.0, 7.0, 1.0, -9.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(-2.0, 4.0, -8.0, 4.0, 9.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(8.0, 0.0, -3.0, 9.0, 5.0, -3.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(-1.0, 0.0, 0.0, -2.0, -1.0, 1.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(-9.0, 2.0, -8.0, 1.0, 3.0, -7.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[2][2][0], mat2x4(4.0, -7.0, 1.0, -4.0, 7.0, 0.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[2][2][1], mat2x4(8.0, -6.0, 1.0, 8.0, 5.0, 8.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[2][3][0], mat2x4(8.0, 0.0, -5.0, 3.0, 2.0, -6.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[2][3][1], mat2x4(0.0, -5.0, -5.0, 9.0, -4.0, 2.0, -3.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(2.0, 1.0, 7.0, 1.0));
	var[0][0][0][1] = (vec4(-1.0, -8.0, 7.0, 5.0));
	var[0][0][1][0] = (vec4(-7.0, 2.0, -1.0, 4.0));
	var[0][0][1][1] = (vec4(7.0, -4.0, 8.0, -2.0));
	var[0][1][0][0] = (vec4(0.0, -3.0, -2.0, 3.0));
	var[0][1][0][1] = (vec4(-6.0, 8.0, -9.0, -3.0));
	var[0][1][1][0] = (vec4(-9.0, 3.0, -2.0, 6.0));
	var[0][1][1][1] = (vec4(4.0, 7.0, -7.0, 7.0));
	var[0][2][0][0] = (vec4(-4.0, 8.0, 5.0, 5.0));
	var[0][2][0][1] = (vec4(6.0, 7.0, 9.0, 5.0));
	var[0][2][1][0] = (vec4(9.0, 9.0, 2.0, -5.0));
	var[0][2][1][1] = (vec4(5.0, 9.0, -6.0, -8.0));
	var[0][3][0][0] = (vec4(6.0, -5.0, 0.0, 4.0));
	var[0][3][0][1] = (vec4(8.0, -6.0, 8.0, -7.0));
	var[0][3][1][0] = (vec4(8.0, 0.0, 1.0, -6.0));
	var[0][3][1][1] = (vec4(0.0, 1.0, 1.0, -9.0));
	var[1][0][0][0] = (vec4(2.0, 5.0, -2.0, 1.0));
	var[1][0][0][1] = (vec4(1.0, 0.0, -4.0, 1.0));
	var[1][0][1][0] = (vec4(0.0, 5.0, -3.0, 3.0));
	var[1][0][1][1] = (vec4(9.0, -1.0, -7.0, -7.0));
	var[1][1][0][0] = (vec4(5.0, 2.0, 7.0, -9.0));
	var[1][1][0][1] = (vec4(-4.0, -3.0, -2.0, 4.0));
	var[1][1][1][0] = (vec4(-3.0, -8.0, -4.0, 6.0));
	var[1][1][1][1] = (vec4(-1.0, -1.0, 6.0, -8.0));
	var[1][2][0][0] = (vec4(-2.0, 0.0, 7.0, 4.0));
	var[1][2][0][1] = (vec4(8.0, -3.0, -7.0, -6.0));
	var[1][2][1][0] = (vec4(-6.0, -1.0, 5.0, -7.0));
	var[1][2][1][1] = (vec4(-8.0, -6.0, 3.0, -3.0));
	var[1][3][0][0] = (vec4(-6.0, 9.0, 2.0, -5.0));
	var[1][3][0][1] = (vec4(-7.0, -6.0, 3.0, -2.0));
	var[1][3][1][0] = (vec4(1.0, -8.0, 4.0, -7.0));
	var[1][3][1][1] = (vec4(-3.0, 9.0, 4.0, -6.0));
	var[2][0][0][0] = (vec4(1.0, 9.0, -1.0, 8.0));
	var[2][0][0][1] = (vec4(7.0, 6.0, 7.0, -4.0));
	var[2][0][1][0] = (vec4(-4.0, 2.0, -4.0, 6.0));
	var[2][0][1][1] = (vec4(4.0, -1.0, -9.0, 3.0));
	var[2][1][0][0] = (vec4(-4.0, -2.0, -8.0, 4.0));
	var[2][1][0][1] = (vec4(-2.0, 4.0, -8.0, 6.0));
	var[2][1][1][0] = (vec4(4.0, -8.0, 8.0, -8.0));
	var[2][1][1][1] = (vec4(4.0, 0.0, -9.0, 1.0));
	var[2][2][0][0] = (vec4(-4.0, -4.0, 5.0, -9.0));
	var[2][2][0][1] = (vec4(-3.0, 0.0, -2.0, 7.0));
	var[2][2][1][0] = (vec4(3.0, 3.0, -3.0, 9.0));
	var[2][2][1][1] = (vec4(-2.0, 1.0, -8.0, -2.0));
	var[2][3][0][0] = (vec4(-7.0, -3.0, 9.0, -8.0));
	var[2][3][0][1] = (vec4(1.0, -6.0, 7.0, 1.0));
	var[2][3][1][0] = (vec4(5.0, -9.0, 3.0, -2.0));
	var[2][3][1][1] = (vec4(-1.0, 1.0, -7.0, 8.0));
}
#version 450
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

layout(std430, binding = 1) buffer Block
{
	f16vec4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(var[0][0][0]), vec4(-8.0, -9.0, 9.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[0][0][1]), vec4(4.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[0][1][0]), vec4(2.0, 3.0, -3.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[0][1][1]), vec4(9.0, -9.0, 0.0, 3.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[0][2][0]), vec4(7.0, -7.0, -3.0, 1.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[0][2][1]), vec4(7.0, 0.0, -2.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[0][3][0]), vec4(1.0, 0.0, -7.0, 0.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[0][3][1]), vec4(-9.0, 0.0, 9.0, -9.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][0][0]), vec4(-8.0, 6.0, 1.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][0][1]), vec4(4.0, 7.0, 5.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][1][0]), vec4(2.0, -2.0, -4.0, -2.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][1][1]), vec4(-6.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][2][0]), vec4(-6.0, -5.0, 8.0, 0.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][2][1]), vec4(-9.0, 7.0, -3.0, -1.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][3][0]), vec4(-5.0, 3.0, 4.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][3][1]), vec4(-5.0, -8.0, 6.0, -5.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][0][0]), vec4(7.0, -4.0, -8.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][0][1]), vec4(-3.0, 6.0, -4.0, 5.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][1][0]), vec4(7.0, 5.0, -9.0, 9.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][1][1]), vec4(8.0, 7.0, 9.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][2][0]), vec4(2.0, 7.0, 0.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][2][1]), vec4(-7.0, 6.0, 0.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][3][0]), vec4(0.0, -8.0, -9.0, 7.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][3][1]), vec4(3.0, 9.0, -3.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = f16vec4(vec4(9.0, -6.0, 2.0, -8.0));
	var[0][0][1] = f16vec4(vec4(-7.0, -4.0, 2.0, -5.0));
	var[0][1][0] = f16vec4(vec4(-6.0, 2.0, -4.0, 8.0));
	var[0][1][1] = f16vec4(vec4(-4.0, -1.0, 8.0, 9.0));
	var[0][2][0] = f16vec4(vec4(8.0, 3.0, -7.0, -9.0));
	var[0][2][1] = f16vec4(vec4(6.0, -8.0, -8.0, 3.0));
	var[0][3][0] = f16vec4(vec4(-3.0, -6.0, 7.0, 3.0));
	var[0][3][1] = f16vec4(vec4(-6.0, -9.0, -2.0, 7.0));
	var[1][0][0] = f16vec4(vec4(9.0, 1.0, -6.0, 3.0));
	var[1][0][1] = f16vec4(vec4(-1.0, 4.0, -1.0, -8.0));
	var[1][1][0] = f16vec4(vec4(0.0, 0.0, -5.0, 5.0));
	var[1][1][1] = f16vec4(vec4(7.0, -6.0, -7.0, -8.0));
	var[1][2][0] = f16vec4(vec4(1.0, -6.0, -6.0, 9.0));
	var[1][2][1] = f16vec4(vec4(9.0, -7.0, 7.0, -4.0));
	var[1][3][0] = f16vec4(vec4(2.0, -6.0, -5.0, 8.0));
	var[1][3][1] = f16vec4(vec4(6.0, 1.0, -5.0, 6.0));
	var[2][0][0] = f16vec4(vec4(5.0, 8.0, 7.0, 0.0));
	var[2][0][1] = f16vec4(vec4(4.0, -5.0, -6.0, -8.0));
	var[2][1][0] = f16vec4(vec4(-3.0, -4.0, -7.0, 0.0));
	var[2][1][1] = f16vec4(vec4(-7.0, -2.0, 7.0, -1.0));
	var[2][2][0] = f16vec4(vec4(-3.0, 0.0, -5.0, -5.0));
	var[2][2][1] = f16vec4(vec4(-6.0, -7.0, -2.0, -8.0));
	var[2][3][0] = f16vec4(vec4(-5.0, -9.0, -6.0, -4.0));
	var[2][3][1] = f16vec4(vec4(-5.0, -8.0, 1.0, 2.0));
}
#version 450
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
	highp mat2 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(block[0].var, mat2(-7.0, -2.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat2(block[1].var, mat2(0.0, 4.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2(block[2].var, mat2(-2.0, -1.0, -9.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat2(1.0, 2.0, 6.0, -6.0));
	block[1].var = (mat2(2.0, 4.0, 4.0, 7.0));
	block[2].var = (mat2(0.0, 8.0, 0.0, -1.0));
}
#version 450
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
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(block[0].var, mat3(-8.0, -9.0, -7.0, -7.0, 8.0, 7.0, 4.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat3(block[1].var, mat3(5.0, -4.0, 7.0, -4.0, -3.0, 8.0, 7.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3(block[2].var, mat3(1.0, 6.0, 8.0, -9.0, -1.0, 8.0, 8.0, 3.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat3(5.0, 2.0, 8.0, 8.0, 3.0, -2.0, 2.0, -8.0, -5.0));
	block[1].var = (mat3(-6.0, -1.0, 7.0, -5.0, -5.0, 8.0, -2.0, -5.0, 5.0));
	block[2].var = (mat3(3.0, 9.0, -7.0, -2.0, 3.0, 5.0, 5.0, 1.0, -6.0));
}
#version 450
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
	allOk = compare_mat3(block[0].var, mat3(-7.0, -8.0, -9.0, -8.0, 8.0, 6.0, 6.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat3(block[1].var, mat3(9.0, 5.0, -2.0, 9.0, -8.0, 6.0, -3.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat3(block[2].var, mat3(-1.0, -5.0, -7.0, -6.0, 8.0, 8.0, -2.0, -7.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat3(-6.0, 9.0, 1.0, 4.0, -8.0, 5.0, 7.0, 2.0, 2.0));
	block[1].var = (mat3(8.0, -8.0, -2.0, 2.0, 8.0, 4.0, 2.0, 1.0, 7.0));
	block[2].var = (mat3(-2.0, 5.0, 7.0, 4.0, 7.0, -3.0, 9.0, 1.0, 9.0));
}
#version 450
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
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block[0].var[0][0], 9.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -2.0) && allOk;
	allOk = compare_float(block[0].var[0][2], -9.0) && allOk;
	allOk = compare_float(block[0].var[0][3], 2.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -3.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 8.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -1.0) && allOk;
	allOk = compare_float(block[0].var[1][3], 2.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 2.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -5.0) && allOk;
	allOk = compare_float(block[0].var[2][2], -8.0) && allOk;
	allOk = compare_float(block[0].var[2][3], -6.0) && allOk;
	allOk = compare_float(block[0].var[3][0], -6.0) && allOk;
	allOk = compare_float(block[0].var[3][1], -3.0) && allOk;
	allOk = compare_float(block[0].var[3][2], 4.0) && allOk;
	allOk = compare_float(block[0].var[3][3], -9.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(9.0, -2.0, -9.0, 2.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(-3.0, 8.0, -1.0, 2.0)) && allOk;
	allOk = compare_vec4(block[0].var[2], vec4(2.0, -5.0, -8.0, -6.0)) && allOk;
	allOk = compare_vec4(block[0].var[3], vec4(-6.0, -3.0, 4.0, -9.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 0.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 0.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 8.0) && allOk;
	allOk = compare_float(block[1].var[0][3], -6.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 7.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -9.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 0.0) && allOk;
	allOk = compare_float(block[1].var[1][3], 5.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -6.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -4.0) && allOk;
	allOk = compare_float(block[1].var[2][2], -7.0) && allOk;
	allOk = compare_float(block[1].var[2][3], 7.0) && allOk;
	allOk = compare_float(block[1].var[3][0], -3.0) && allOk;
	allOk = compare_float(block[1].var[3][1], 8.0) && allOk;
	allOk = compare_float(block[1].var[3][2], 6.0) && allOk;
	allOk = compare_float(block[1].var[3][3], 1.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(0.0, 0.0, 8.0, -6.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(7.0, -9.0, 0.0, 5.0)) && allOk;
	allOk = compare_vec4(block[1].var[2], vec4(-6.0, -4.0, -7.0, 7.0)) && allOk;
	allOk = compare_vec4(block[1].var[3], vec4(-3.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 4.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 4.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 2.0) && allOk;
	allOk = compare_float(block[2].var[0][3], -6.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 2.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 0.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -9.0) && allOk;
	allOk = compare_float(block[2].var[1][3], -1.0) && allOk;
	allOk = compare_float(block[2].var[2][0], -3.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 4.0) && allOk;
	allOk = compare_float(block[2].var[2][2], -3.0) && allOk;
	allOk = compare_float(block[2].var[2][3], 0.0) && allOk;
	allOk = compare_float(block[2].var[3][0], -2.0) && allOk;
	allOk = compare_float(block[2].var[3][1], -5.0) && allOk;
	allOk = compare_float(block[2].var[3][2], -7.0) && allOk;
	allOk = compare_float(block[2].var[3][3], -1.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(4.0, 4.0, 2.0, -6.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(2.0, 0.0, -9.0, -1.0)) && allOk;
	allOk = compare_vec4(block[2].var[2], vec4(-3.0, 4.0, -3.0, 0.0)) && allOk;
	allOk = compare_vec4(block[2].var[3], vec4(-2.0, -5.0, -7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat4(7.0, 8.0, 6.0, 5.0, 7.0, 7.0, -1.0, -6.0, -2.0, -6.0, 5.0, 9.0, 8.0, -6.0, 9.0, -8.0));
	block[1].var = (mat4(-7.0, -6.0, -1.0, 8.0, 2.0, -9.0, 8.0, -8.0, -3.0, 6.0, -8.0, 3.0, 0.0, -9.0, 1.0, 4.0));
	block[2].var = (mat4(8.0, -2.0, 0.0, -2.0, 9.0, 2.0, -3.0, 0.0, 4.0, -8.0, 3.0, 2.0, 2.0, 2.0, 3.0, -6.0));
}
#version 450
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
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block[0].var[0][0], -8.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 3.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 4.0) && allOk;
	allOk = compare_float(block[0].var[0][3], 4.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -5.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 8.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 6.0) && allOk;
	allOk = compare_float(block[0].var[1][3], 7.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 4.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 5.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 7.0) && allOk;
	allOk = compare_float(block[0].var[2][3], -3.0) && allOk;
	allOk = compare_float(block[0].var[3][0], 0.0) && allOk;
	allOk = compare_float(block[0].var[3][1], 2.0) && allOk;
	allOk = compare_float(block[0].var[3][2], 5.0) && allOk;
	allOk = compare_float(block[0].var[3][3], 8.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(-8.0, 3.0, 4.0, 4.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(-5.0, 8.0, 6.0, 7.0)) && allOk;
	allOk = compare_vec4(block[0].var[2], vec4(4.0, 5.0, 7.0, -3.0)) && allOk;
	allOk = compare_vec4(block[0].var[3], vec4(0.0, 2.0, 5.0, 8.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], -1.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -2.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -3.0) && allOk;
	allOk = compare_float(block[1].var[0][3], 1.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -9.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -9.0) && allOk;
	allOk = compare_float(block[1].var[1][2], -6.0) && allOk;
	allOk = compare_float(block[1].var[1][3], 5.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 6.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 7.0) && allOk;
	allOk = compare_float(block[1].var[2][2], 6.0) && allOk;
	allOk = compare_float(block[1].var[2][3], 1.0) && allOk;
	allOk = compare_float(block[1].var[3][0], -8.0) && allOk;
	allOk = compare_float(block[1].var[3][1], -3.0) && allOk;
	allOk = compare_float(block[1].var[3][2], -3.0) && allOk;
	allOk = compare_float(block[1].var[3][3], 7.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(-1.0, -2.0, -3.0, 1.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(-9.0, -9.0, -6.0, 5.0)) && allOk;
	allOk = compare_vec4(block[1].var[2], vec4(6.0, 7.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec4(block[1].var[3], vec4(-8.0, -3.0, -3.0, 7.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 6.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 0.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 5.0) && allOk;
	allOk = compare_float(block[2].var[0][3], -6.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -1.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -6.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -1.0) && allOk;
	allOk = compare_float(block[2].var[1][3], 6.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 1.0) && allOk;
	allOk = compare_float(block[2].var[2][1], -1.0) && allOk;
	allOk = compare_float(block[2].var[2][2], 3.0) && allOk;
	allOk = compare_float(block[2].var[2][3], -1.0) && allOk;
	allOk = compare_float(block[2].var[3][0], 6.0) && allOk;
	allOk = compare_float(block[2].var[3][1], 4.0) && allOk;
	allOk = compare_float(block[2].var[3][2], -2.0) && allOk;
	allOk = compare_float(block[2].var[3][3], -9.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(6.0, 0.0, 5.0, -6.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(-1.0, -6.0, -1.0, 6.0)) && allOk;
	allOk = compare_vec4(block[2].var[2], vec4(1.0, -1.0, 3.0, -1.0)) && allOk;
	allOk = compare_vec4(block[2].var[3], vec4(6.0, 4.0, -2.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec4(-9.0, 0.0, -1.0, -4.0));
	block[0].var[1] = (vec4(-9.0, -4.0, -9.0, -5.0));
	block[0].var[2] = (vec4(-2.0, 9.0, 0.0, -8.0));
	block[0].var[3] = (vec4(-6.0, -3.0, -8.0, 3.0));
	block[1].var[0] = (vec4(4.0, 9.0, 4.0, -3.0));
	block[1].var[1] = (vec4(7.0, -9.0, 6.0, 5.0));
	block[1].var[2] = (vec4(6.0, -1.0, -3.0, -3.0));
	block[1].var[3] = (vec4(-9.0, 3.0, -9.0, 0.0));
	block[2].var[0] = (vec4(1.0, -4.0, -6.0, 5.0));
	block[2].var[1] = (vec4(2.0, 1.0, 9.0, -4.0));
	block[2].var[2] = (vec4(-7.0, 7.0, 0.0, 7.0));
	block[2].var[3] = (vec4(9.0, 9.0, -5.0, -7.0));
}
#version 450
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
	allOk = compare_float(block[0].var[0][0], 5.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -6.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -5.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 5.0) && allOk;
	allOk = compare_float(block[0].var[2][0], -6.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -1.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(5.0, -6.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(-5.0, 5.0)) && allOk;
	allOk = compare_vec2(block[0].var[2], vec2(-6.0, -1.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], -5.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -6.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -8.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 6.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -3.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 2.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(-8.0, 6.0)) && allOk;
	allOk = compare_vec2(block[1].var[2], vec2(-3.0, 2.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 2.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -8.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 9.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -8.0) && allOk;
	allOk = compare_float(block[2].var[2][0], -3.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 6.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(2.0, -8.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(9.0, -8.0)) && allOk;
	allOk = compare_vec2(block[2].var[2], vec2(-3.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat3x2(-1.0, -5.0, -1.0, -8.0, 7.0, 8.0));
	block[1].var = (mat3x2(-4.0, -8.0, 1.0, 5.0, -2.0, 7.0));
	block[2].var = (mat3x2(4.0, -6.0, 7.0, -6.0, 2.0, 5.0));
}
#version 450
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
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(block[0].var, mat4x3(3.0, 6.0, 1.0, -6.0, -9.0, -8.0, 6.0, 4.0, 5.0, -6.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block[1].var, mat4x3(-1.0, 1.0, 2.0, 9.0, 3.0, 1.0, 1.0, 7.0, -1.0, 8.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block[2].var, mat4x3(9.0, 4.0, 5.0, -9.0, 2.0, 0.0, -9.0, -2.0, 1.0, -7.0, -4.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec3(1.0, 2.0, -5.0));
	block[0].var[1] = (vec3(-3.0, -2.0, 2.0));
	block[0].var[2] = (vec3(-5.0, 9.0, 4.0));
	block[0].var[3] = (vec3(2.0, -4.0, 9.0));
	block[1].var[0] = (vec3(8.0, -4.0, -5.0));
	block[1].var[1] = (vec3(-5.0, 6.0, 8.0));
	block[1].var[2] = (vec3(-7.0, 4.0, -8.0));
	block[1].var[3] = (vec3(-1.0, 1.0, 1.0));
	block[2].var[0] = (vec3(-4.0, 5.0, 7.0));
	block[2].var[1] = (vec3(9.0, 5.0, -7.0));
	block[2].var[2] = (vec3(8.0, 9.0, 0.0));
	block[2].var[3] = (vec3(-3.0, 3.0, 0.0));
}
#version 450
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
	highp mat3 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), -8.0) && allOk;
	allOk = compare_mat3(block[0].var, mat3(-7.0, 8.0, 7.0, 4.0, 4.0, -1.0, -9.0, -7.0, 5.0)) && allOk;
	allOk = compare_float((block[1].padding), -4.0) && allOk;
	allOk = compare_mat3(block[1].var, mat3(7.0, -3.0, -7.0, -4.0, 7.0, 1.0, -3.0, 8.0, -9.0)) && allOk;
	allOk = compare_float((block[2].padding), 8.0) && allOk;
	allOk = compare_mat3(block[2].var, mat3(6.0, 8.0, -6.0, -1.0, 8.0, -2.0, 3.0, -1.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (5.0);
	block[0].var = (mat3(8.0, 3.0, -2.0, 2.0, -8.0, -5.0, 2.0, 8.0, -6.0));
	block[1].padding = (-5.0);
	block[1].var = (mat3(-2.0, -5.0, 5.0, -1.0, 7.0, 3.0, -5.0, 8.0, -2.0));
	block[2].padding = (5.0);
	block[2].var = (mat3(9.0, -7.0, -5.0, 3.0, 5.0, -2.0, 1.0, -6.0, -1.0));
}
#version 450
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
	mediump mat3x4 mB[7];
	highp mat3 mC;
	mediump vec2 mD;
};
struct sB
{
	sA mA;
	mediump mat3x4 mB;
	lowp uvec3 mC;
	highp mat4 mD;
};
layout(std430, row_major, binding = 1) buffer BlockB
{
	sB a[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB.a[0].mA.mA, mat2(-8.0, 0.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[0].mA.mB[0], mat3x4(-6.0, -4.0, 2.0, -1.0, 8.0, -7.0, 7.0, 5.0, -7.0, -2.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[0].mA.mB[1], mat3x4(-1.0, 2.0, -3.0, 5.0, 5.0, 3.0, -9.0, -8.0, -9.0, 2.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[0].mA.mB[2], mat3x4(-5.0, 8.0, 4.0, 2.0, -1.0, -5.0, -1.0, 2.0, 5.0, 7.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[0].mA.mB[3], mat3x4(-4.0, -4.0, 7.0, 6.0, 8.0, -8.0, -2.0, -2.0, -2.0, -4.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[0].mA.mB[4], mat3x4(-2.0, 2.0, -3.0, -9.0, -9.0, 5.0, -9.0, -3.0, 2.0, 1.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[0].mA.mB[5], mat3x4(7.0, -1.0, 5.0, -4.0, -8.0, 8.0, -9.0, 9.0, 7.0, -1.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[0].mA.mB[6], mat3x4(-8.0, -2.0, 2.0, 7.0, -7.0, 7.0, 5.0, -4.0, 7.0, -8.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat3(blockB.a[0].mA.mC, mat3(5.0, 3.0, -3.0, 8.0, -8.0, -4.0, 9.0, -8.0, 9.0)) && allOk;
	allOk = compare_vec2((blockB.a[0].mA.mD), vec2(6.0, -9.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[0].mB, mat3x4(6.0, 6.0, 8.0, 3.0, 5.0, 2.0, -7.0, 3.0, -1.0, -3.0, -7.0, 0.0)) && allOk;
	allOk = compare_uvec3((blockB.a[0].mC), uvec3(9u, 2u, 0u)) && allOk;
	allOk = compare_mat4(blockB.a[0].mD, mat4(6.0, 7.0, -9.0, -6.0, -8.0, 9.0, -4.0, 3.0, -5.0, -4.0, 6.0, 9.0, -8.0, 7.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2(blockB.a[1].mA.mA, mat2(-1.0, -4.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[1].mA.mB[0], mat3x4(-5.0, 4.0, 6.0, 0.0, -6.0, -6.0, 7.0, -4.0, 1.0, 3.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[1].mA.mB[1], mat3x4(-8.0, -4.0, 3.0, -1.0, 0.0, 4.0, 3.0, -7.0, 9.0, 3.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[1].mA.mB[2], mat3x4(4.0, -9.0, 9.0, 1.0, 4.0, -3.0, 0.0, 5.0, -9.0, 1.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[1].mA.mB[3], mat3x4(-4.0, 5.0, 7.0, -9.0, 8.0, -9.0, -8.0, -2.0, -5.0, 2.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[1].mA.mB[4], mat3x4(-8.0, 9.0, -4.0, -6.0, 0.0, 1.0, 8.0, -3.0, -1.0, 0.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[1].mA.mB[5], mat3x4(2.0, -1.0, -9.0, -3.0, 6.0, 8.0, 7.0, 1.0, -1.0, -4.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[1].mA.mB[6], mat3x4(2.0, 2.0, -2.0, -2.0, 2.0, 6.0, -1.0, 6.0, -3.0, 4.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat3(blockB.a[1].mA.mC, mat3(-1.0, -7.0, 1.0, -1.0, -1.0, 4.0, 5.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec2((blockB.a[1].mA.mD), vec2(-3.0, -2.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[1].mB, mat3x4(-4.0, -6.0, -4.0, -9.0, -1.0, 8.0, 8.0, -7.0, -8.0, -2.0, 3.0, 8.0)) && allOk;
	allOk = compare_uvec3((blockB.a[1].mC), uvec3(6u, 5u, 9u)) && allOk;
	allOk = compare_mat4(blockB.a[1].mD, mat4(0.0, -1.0, -8.0, 7.0, 0.0, -4.0, -8.0, -3.0, -9.0, 1.0, 5.0, 2.0, 7.0, 1.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2(blockB.a[2].mA.mA, mat2(-2.0, 1.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[2].mA.mB[0], mat3x4(2.0, -2.0, -5.0, -9.0, 4.0, -9.0, 4.0, 0.0, 1.0, 7.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[2].mA.mB[1], mat3x4(-3.0, 3.0, -1.0, 6.0, 9.0, -8.0, 8.0, 3.0, -4.0, -9.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[2].mA.mB[2], mat3x4(-7.0, -6.0, -7.0, 6.0, 8.0, -8.0, -5.0, 5.0, 3.0, -4.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[2].mA.mB[3], mat3x4(-7.0, 2.0, -6.0, 0.0, -8.0, 8.0, -8.0, 8.0, 0.0, -2.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[2].mA.mB[4], mat3x4(-2.0, 7.0, 9.0, 1.0, -5.0, -6.0, 7.0, -5.0, 1.0, -4.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[2].mA.mB[5], mat3x4(-8.0, 6.0, 5.0, -2.0, -4.0, 7.0, -8.0, -2.0, -4.0, -7.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[2].mA.mB[6], mat3x4(7.0, 9.0, 3.0, 6.0, -2.0, -4.0, 3.0, -9.0, -6.0, 8.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat3(blockB.a[2].mA.mC, mat3(-9.0, 1.0, 9.0, 7.0, 0.0, 0.0, -4.0, -1.0, -3.0)) && allOk;
	allOk = compare_vec2((blockB.a[2].mA.mD), vec2(9.0, -1.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[2].mB, mat3x4(-9.0, 5.0, 0.0, 3.0, 2.0, -1.0, 8.0, 5.0, 4.0, -4.0, -9.0, 8.0)) && allOk;
	allOk = compare_uvec3((blockB.a[2].mC), uvec3(3u, 9u, 0u)) && allOk;
	allOk = compare_mat4(blockB.a[2].mD, mat4(8.0, 0.0, 0.0, -6.0, -7.0, -7.0, -7.0, -7.0, -3.0, 2.0, -1.0, 7.0, 9.0, -8.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat2(blockB.a[3].mA.mA, mat2(1.0, 9.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[3].mA.mB[0], mat3x4(-3.0, -9.0, 6.0, 4.0, 9.0, -3.0, 2.0, 1.0, -5.0, 6.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[3].mA.mB[1], mat3x4(-9.0, -3.0, 3.0, -3.0, -4.0, 4.0, 2.0, -6.0, 4.0, 4.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[3].mA.mB[2], mat3x4(-8.0, 2.0, 0.0, -9.0, 1.0, 0.0, 0.0, -8.0, -7.0, -6.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[3].mA.mB[3], mat3x4(2.0, 6.0, -2.0, -5.0, -9.0, -6.0, 8.0, 1.0, 9.0, 8.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[3].mA.mB[4], mat3x4(-6.0, 7.0, -8.0, 7.0, -8.0, -2.0, 0.0, 7.0, -9.0, 1.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[3].mA.mB[5], mat3x4(-5.0, -9.0, -8.0, -6.0, -2.0, 7.0, 0.0, -6.0, 4.0, -3.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[3].mA.mB[6], mat3x4(8.0, 8.0, 9.0, 9.0, -9.0, 1.0, -5.0, -5.0, -9.0, -4.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3(blockB.a[3].mA.mC, mat3(-6.0, 0.0, -5.0, 6.0, -7.0, 2.0, -4.0, -5.0, 3.0)) && allOk;
	allOk = compare_vec2((blockB.a[3].mA.mD), vec2(7.0, 9.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[3].mB, mat3x4(-8.0, -1.0, -8.0, 9.0, 0.0, -7.0, -1.0, 7.0, -1.0, -1.0, -7.0, 8.0)) && allOk;
	allOk = compare_uvec3((blockB.a[3].mC), uvec3(8u, 2u, 4u)) && allOk;
	allOk = compare_mat4(blockB.a[3].mD, mat4(-7.0, 6.0, -4.0, -9.0, -6.0, -2.0, -3.0, 7.0, -7.0, -7.0, 4.0, 2.0, -3.0, -2.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat2(blockB.a[4].mA.mA, mat2(3.0, 5.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[4].mA.mB[0], mat3x4(0.0, -6.0, 5.0, 0.0, -3.0, 3.0, -3.0, -4.0, 6.0, 5.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[4].mA.mB[1], mat3x4(-8.0, 4.0, -7.0, 4.0, 4.0, 0.0, 1.0, 3.0, -3.0, 2.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[4].mA.mB[2], mat3x4(8.0, -3.0, 4.0, -7.0, 4.0, -2.0, -9.0, -7.0, -5.0, 4.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[4].mA.mB[3], mat3x4(2.0, -7.0, -2.0, 6.0, -3.0, -3.0, 8.0, 4.0, -8.0, -5.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[4].mA.mB[4], mat3x4(-4.0, -6.0, 6.0, 3.0, 3.0, 3.0, 6.0, -2.0, 4.0, 0.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[4].mA.mB[5], mat3x4(7.0, 3.0, 9.0, -7.0, -3.0, 6.0, 0.0, -8.0, 9.0, -6.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[4].mA.mB[6], mat3x4(5.0, 3.0, 8.0, -9.0, -3.0, -1.0, -7.0, 1.0, 7.0, 4.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat3(blockB.a[4].mA.mC, mat3(6.0, 7.0, 0.0, -4.0, 5.0, -7.0, -3.0, -1.0, 6.0)) && allOk;
	allOk = compare_vec2((blockB.a[4].mA.mD), vec2(4.0, 7.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[4].mB, mat3x4(-8.0, -5.0, 5.0, -2.0, -1.0, 1.0, 9.0, 1.0, -4.0, -7.0, 7.0, 9.0)) && allOk;
	allOk = compare_uvec3((blockB.a[4].mC), uvec3(3u, 6u, 2u)) && allOk;
	allOk = compare_mat4(blockB.a[4].mD, mat4(-2.0, -1.0, 8.0, -4.0, -8.0, 9.0, 8.0, -3.0, 4.0, 8.0, -7.0, 6.0, -7.0, 3.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat2(blockB.a[5].mA.mA, mat2(5.0, -2.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[5].mA.mB[0], mat3x4(-6.0, -4.0, 5.0, 5.0, 7.0, 5.0, 9.0, -7.0, -7.0, -5.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[5].mA.mB[1], mat3x4(-4.0, 4.0, -7.0, 0.0, 0.0, -9.0, -6.0, -3.0, 2.0, 7.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[5].mA.mB[2], mat3x4(8.0, -3.0, -1.0, 7.0, -6.0, -1.0, 9.0, -1.0, 7.0, -3.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[5].mA.mB[3], mat3x4(-4.0, 3.0, -7.0, -6.0, 1.0, -5.0, 3.0, -9.0, 4.0, 1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[5].mA.mB[4], mat3x4(6.0, -5.0, 7.0, -8.0, 7.0, 8.0, 5.0, 7.0, -2.0, 4.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[5].mA.mB[5], mat3x4(6.0, -1.0, 7.0, -6.0, 9.0, 1.0, 9.0, -4.0, 6.0, -1.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[5].mA.mB[6], mat3x4(2.0, 4.0, -4.0, -9.0, 5.0, -8.0, 4.0, -8.0, 5.0, -6.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat3(blockB.a[5].mA.mC, mat3(4.0, 7.0, 2.0, 1.0, 9.0, 8.0, 5.0, 2.0, -1.0)) && allOk;
	allOk = compare_vec2((blockB.a[5].mA.mD), vec2(-3.0, 5.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[5].mB, mat3x4(-5.0, -3.0, -1.0, -8.0, -1.0, -7.0, 2.0, -2.0, -8.0, 4.0, 1.0, -8.0)) && allOk;
	allOk = compare_uvec3((blockB.a[5].mC), uvec3(5u, 4u, 0u)) && allOk;
	allOk = compare_mat4(blockB.a[5].mD, mat4(-1.0, -7.0, 9.0, 0.0, 6.0, 3.0, -6.0, -6.0, -7.0, -5.0, 2.0, -9.0, 3.0, 6.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2(blockB.a[6].mA.mA, mat2(-1.0, -5.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[6].mA.mB[0], mat3x4(-8.0, 1.0, -2.0, -3.0, -5.0, -8.0, -8.0, 8.0, -7.0, -3.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[6].mA.mB[1], mat3x4(-7.0, -9.0, -8.0, 7.0, -2.0, -3.0, 9.0, 0.0, 2.0, 5.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[6].mA.mB[2], mat3x4(6.0, 1.0, -3.0, 4.0, 1.0, -8.0, 7.0, 1.0, 9.0, 6.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[6].mA.mB[3], mat3x4(-7.0, 0.0, -7.0, 1.0, -3.0, 8.0, 5.0, 0.0, -4.0, -5.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[6].mA.mB[4], mat3x4(9.0, 9.0, -1.0, 2.0, 6.0, -7.0, 8.0, -5.0, 2.0, -6.0, 0.0, 5.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[6].mA.mB[5], mat3x4(9.0, 7.0, 1.0, 5.0, -6.0, -4.0, -9.0, -2.0, -8.0, -8.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[6].mA.mB[6], mat3x4(2.0, 6.0, 5.0, -5.0, 8.0, -7.0, 6.0, 3.0, 5.0, -7.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3(blockB.a[6].mA.mC, mat3(6.0, -7.0, -9.0, 1.0, 3.0, -4.0, -5.0, 0.0, -7.0)) && allOk;
	allOk = compare_vec2((blockB.a[6].mA.mD), vec2(-7.0, -8.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[6].mB, mat3x4(0.0, -1.0, -6.0, -8.0, 0.0, -9.0, 7.0, 3.0, -1.0, -8.0, -7.0, 3.0)) && allOk;
	allOk = compare_uvec3((blockB.a[6].mC), uvec3(4u, 3u, 6u)) && allOk;
	allOk = compare_mat4(blockB.a[6].mD, mat4(6.0, 3.0, -7.0, -4.0, -6.0, -8.0, 0.0, -4.0, 5.0, 6.0, -7.0, 5.0, -8.0, -1.0, 1.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0].mA.mA = (mat2(-2.0, -3.0, -9.0, -1.0));
	blockB.a[0].mA.mB[0] = (mat3x4(-8.0, -3.0, -1.0, 9.0, -2.0, 0.0, -5.0, 7.0, -6.0, 7.0, -8.0, -9.0));
	blockB.a[0].mA.mB[1] = (mat3x4(-8.0, -3.0, -2.0, 0.0, -4.0, 9.0, 2.0, -6.0, 0.0, 9.0, -6.0, -6.0));
	blockB.a[0].mA.mB[2] = (mat3x4(-4.0, -5.0, -3.0, -2.0, -9.0, 8.0, -1.0, 2.0, 4.0, 8.0, 2.0, -1.0));
	blockB.a[0].mA.mB[3] = (mat3x4(7.0, 2.0, -3.0, -9.0, -1.0, -8.0, 8.0, -5.0, 3.0, 9.0, -7.0, 9.0));
	blockB.a[0].mA.mB[4] = (mat3x4(0.0, 7.0, -4.0, -8.0, -7.0, 3.0, 5.0, -9.0, 7.0, -6.0, -1.0, -7.0));
	blockB.a[0].mA.mB[5] = (mat3x4(-4.0, -1.0, -6.0, 8.0, -1.0, -8.0, 7.0, -9.0, -2.0, 5.0, -5.0, 9.0));
	blockB.a[0].mA.mB[6] = (mat3x4(-1.0, 4.0, -1.0, 9.0, 1.0, -8.0, 3.0, 3.0, -9.0, 2.0, 1.0, 4.0));
	blockB.a[0].mA.mC = (mat3(-7.0, 3.0, -7.0, 5.0, -8.0, -2.0, 2.0, 6.0, 0.0));
	blockB.a[0].mA.mD = (vec2(-6.0, 3.0));
	blockB.a[0].mB = (mat3x4(7.0, -8.0, 3.0, -4.0, -5.0, 7.0, 9.0, 0.0, -5.0, -5.0, -1.0, 1.0));
	blockB.a[0].mC = (uvec3(3u, 9u, 7u));
	blockB.a[0].mD = (mat4(-6.0, -8.0, 8.0, 7.0, -1.0, 2.0, -9.0, 7.0, 2.0, -2.0, 1.0, 1.0, -1.0, 9.0, -9.0, 8.0));
	blockB.a[1].mA.mA = (mat2(-2.0, -7.0, 7.0, -6.0));
	blockB.a[1].mA.mB[0] = (mat3x4(8.0, -3.0, -3.0, 6.0, -9.0, -7.0, 5.0, -3.0, -7.0, -2.0, -5.0, 1.0));
	blockB.a[1].mA.mB[1] = (mat3x4(4.0, -5.0, -6.0, 2.0, -1.0, -4.0, 7.0, 4.0, -3.0, -5.0, -3.0, 3.0));
	blockB.a[1].mA.mB[2] = (mat3x4(-1.0, 3.0, 5.0, 0.0, -4.0, 8.0, 7.0, -1.0, 9.0, -2.0, 9.0, 1.0));
	blockB.a[1].mA.mB[3] = (mat3x4(-7.0, 7.0, 7.0, 5.0, 7.0, 7.0, 4.0, -9.0, -5.0, 8.0, 0.0, 4.0));
	blockB.a[1].mA.mB[4] = (mat3x4(5.0, -1.0, -6.0, 1.0, -6.0, 9.0, 3.0, -2.0, 6.0, -8.0, -7.0, 6.0));
	blockB.a[1].mA.mB[5] = (mat3x4(7.0, 7.0, -7.0, -5.0, 0.0, -8.0, -9.0, -2.0, 1.0, 6.0, -4.0, -4.0));
	blockB.a[1].mA.mB[6] = (mat3x4(0.0, -5.0, -5.0, 6.0, 3.0, -9.0, 9.0, -8.0, 4.0, 0.0, -2.0, 7.0));
	blockB.a[1].mA.mC = (mat3(-5.0, 1.0, -6.0, -1.0, -7.0, 9.0, 3.0, 2.0, -7.0));
	blockB.a[1].mA.mD = (vec2(-9.0, 7.0));
	blockB.a[1].mB = (mat3x4(1.0, 4.0, -4.0, 5.0, 5.0, 2.0, 0.0, -2.0, 1.0, -4.0, 8.0, -8.0));
	blockB.a[1].mC = (uvec3(0u, 2u, 0u));
	blockB.a[1].mD = (mat4(2.0, -9.0, -5.0, -6.0, 6.0, 4.0, -3.0, -6.0, 7.0, 9.0, 4.0, -7.0, 9.0, 8.0, -1.0, -3.0));
	blockB.a[2].mA.mA = (mat2(-5.0, 4.0, -9.0, -6.0));
	blockB.a[2].mA.mB[0] = (mat3x4(1.0, 0.0, 7.0, 6.0, 2.0, -4.0, 4.0, -3.0, 1.0, 8.0, -7.0, -8.0));
	blockB.a[2].mA.mB[1] = (mat3x4(-5.0, -8.0, 6.0, 0.0, 2.0, 7.0, -4.0, 3.0, 4.0, 5.0, 3.0, -1.0));
	blockB.a[2].mA.mB[2] = (mat3x4(-8.0, 7.0, -8.0, 8.0, 3.0, 1.0, 1.0, -8.0, -5.0, -6.0, 7.0, 0.0));
	blockB.a[2].mA.mB[3] = (mat3x4(-9.0, 1.0, -6.0, 7.0, -3.0, 6.0, 8.0, 7.0, -4.0, -8.0, -6.0, 6.0));
	blockB.a[2].mA.mB[4] = (mat3x4(-7.0, 6.0, 4.0, -8.0, 1.0, -1.0, -3.0, 2.0, 2.0, 1.0, 5.0, 4.0));
	blockB.a[2].mA.mB[5] = (mat3x4(-7.0, -5.0, -5.0, 3.0, 2.0, 7.0, -1.0, -5.0, 0.0, 8.0, 4.0, 2.0));
	blockB.a[2].mA.mB[6] = (mat3x4(-8.0, 7.0, 2.0, 6.0, 4.0, 8.0, 9.0, 1.0, -7.0, -3.0, 7.0, 1.0));
	blockB.a[2].mA.mC = (mat3(3.0, -2.0, -1.0, -5.0, -8.0, 8.0, -2.0, -2.0, -4.0));
	blockB.a[2].mA.mD = (vec2(7.0, 9.0));
	blockB.a[2].mB = (mat3x4(9.0, 1.0, -9.0, -1.0, 1.0, 2.0, 4.0, -1.0, -1.0, 8.0, -1.0, 6.0));
	blockB.a[2].mC = (uvec3(8u, 0u, 0u));
	blockB.a[2].mD = (mat4(-7.0, 9.0, 1.0, 2.0, 3.0, 0.0, -6.0, -7.0, 3.0, 0.0, 9.0, -4.0, 0.0, -7.0, 3.0, 2.0));
	blockB.a[3].mA.mA = (mat2(2.0, 4.0, 6.0, 6.0));
	blockB.a[3].mA.mB[0] = (mat3x4(9.0, 5.0, -4.0, -3.0, 2.0, -7.0, -5.0, -2.0, 3.0, -6.0, -1.0, -6.0));
	blockB.a[3].mA.mB[1] = (mat3x4(5.0, -8.0, 9.0, -2.0, 3.0, -9.0, -4.0, -9.0, 7.0, 8.0, -1.0, -5.0));
	blockB.a[3].mA.mB[2] = (mat3x4(5.0, -4.0, -8.0, 6.0, -5.0, 9.0, 9.0, -1.0, -4.0, 7.0, -3.0, 8.0));
	blockB.a[3].mA.mB[3] = (mat3x4(-3.0, -1.0, -3.0, -6.0, -8.0, 7.0, -9.0, 3.0, -2.0, -4.0, -7.0, -6.0));
	blockB.a[3].mA.mB[4] = (mat3x4(6.0, 5.0, -7.0, -9.0, -6.0, -8.0, -4.0, -8.0, -9.0, -2.0, -2.0, 5.0));
	blockB.a[3].mA.mB[5] = (mat3x4(5.0, -3.0, -1.0, -9.0, -5.0, 7.0, 9.0, -4.0, -7.0, -5.0, 0.0, -8.0));
	blockB.a[3].mA.mB[6] = (mat3x4(0.0, -2.0, 2.0, -5.0, -3.0, 6.0, -6.0, 1.0, 1.0, 0.0, 4.0, -2.0));
	blockB.a[3].mA.mC = (mat3(-4.0, 1.0, 6.0, -8.0, -1.0, 2.0, 7.0, -1.0, 0.0));
	blockB.a[3].mA.mD = (vec2(7.0, -2.0));
	blockB.a[3].mB = (mat3x4(2.0, 2.0, -8.0, 5.0, 5.0, -7.0, 1.0, 8.0, 6.0, 1.0, 5.0, 6.0));
	blockB.a[3].mC = (uvec3(4u, 8u, 7u));
	blockB.a[3].mD = (mat4(7.0, 5.0, 9.0, 6.0, -3.0, -5.0, -1.0, 4.0, 0.0, -9.0, -7.0, -9.0, -1.0, 5.0, 3.0, -4.0));
	blockB.a[4].mA.mA = (mat2(-5.0, -9.0, 2.0, -8.0));
	blockB.a[4].mA.mB[0] = (mat3x4(3.0, -6.0, 2.0, -7.0, 3.0, -6.0, -5.0, -8.0, -3.0, -1.0, 4.0, -5.0));
	blockB.a[4].mA.mB[1] = (mat3x4(-6.0, -3.0, 6.0, 7.0, 8.0, -6.0, 2.0, -8.0, 4.0, -4.0, -3.0, -6.0));
	blockB.a[4].mA.mB[2] = (mat3x4(7.0, 6.0, 8.0, -1.0, -1.0, -9.0, -8.0, 2.0, 1.0, -8.0, -6.0, -2.0));
	blockB.a[4].mA.mB[3] = (mat3x4(-5.0, -2.0, -2.0, -1.0, 6.0, 6.0, 4.0, 0.0, 8.0, 0.0, 9.0, 2.0));
	blockB.a[4].mA.mB[4] = (mat3x4(5.0, 9.0, -7.0, -3.0, 7.0, 1.0, -5.0, -3.0, 8.0, 0.0, -1.0, -5.0));
	blockB.a[4].mA.mB[5] = (mat3x4(3.0, -1.0, 5.0, -9.0, 8.0, -6.0, 4.0, 0.0, 1.0, 8.0, 5.0, -4.0));
	blockB.a[4].mA.mB[6] = (mat3x4(1.0, -6.0, 2.0, 3.0, -2.0, -2.0, -8.0, -7.0, 9.0, 3.0, -1.0, -5.0));
	blockB.a[4].mA.mC = (mat3(8.0, -4.0, 3.0, -1.0, -1.0, 2.0, -4.0, 8.0, 5.0));
	blockB.a[4].mA.mD = (vec2(-5.0, 3.0));
	blockB.a[4].mB = (mat3x4(6.0, -5.0, -3.0, -1.0, 3.0, -5.0, 3.0, 0.0, 2.0, 9.0, 1.0, 1.0));
	blockB.a[4].mC = (uvec3(8u, 0u, 5u));
	blockB.a[4].mD = (mat4(7.0, -4.0, -6.0, 4.0, 6.0, 1.0, 1.0, -2.0, 3.0, -4.0, 1.0, -7.0, 8.0, -2.0, -2.0, 0.0));
	blockB.a[5].mA.mA = (mat2(3.0, -6.0, 6.0, 5.0));
	blockB.a[5].mA.mB[0] = (mat3x4(-9.0, -8.0, 7.0, 0.0, 0.0, 9.0, -2.0, 9.0, 3.0, 5.0, 9.0, -7.0));
	blockB.a[5].mA.mB[1] = (mat3x4(5.0, 2.0, -6.0, 5.0, -3.0, 7.0, 3.0, 3.0, 5.0, -7.0, 1.0, -7.0));
	blockB.a[5].mA.mB[2] = (mat3x4(5.0, 6.0, -3.0, -7.0, 3.0, -1.0, -5.0, 2.0, -2.0, 5.0, 8.0, -8.0));
	blockB.a[5].mA.mB[3] = (mat3x4(2.0, 7.0, -6.0, 8.0, -8.0, -7.0, 3.0, -8.0, 0.0, -7.0, 8.0, 3.0));
	blockB.a[5].mA.mB[4] = (mat3x4(5.0, -8.0, -1.0, 5.0, 7.0, -6.0, 6.0, 0.0, 6.0, 6.0, -9.0, 4.0));
	blockB.a[5].mA.mB[5] = (mat3x4(-6.0, 7.0, 7.0, 5.0, 4.0, -7.0, 1.0, -4.0, -1.0, -4.0, 1.0, -6.0));
	blockB.a[5].mA.mB[6] = (mat3x4(6.0, -6.0, -4.0, 1.0, 4.0, -5.0, -3.0, 7.0, -9.0, 6.0, 7.0, -3.0));
	blockB.a[5].mA.mC = (mat3(5.0, -7.0, -7.0, -2.0, -5.0, -8.0, 3.0, -5.0, 3.0));
	blockB.a[5].mA.mD = (vec2(-1.0, -7.0));
	blockB.a[5].mB = (mat3x4(7.0, -2.0, -4.0, 9.0, -6.0, -1.0, 2.0, -1.0, -2.0, -8.0, -7.0, 3.0));
	blockB.a[5].mC = (uvec3(2u, 7u, 8u));
	blockB.a[5].mD = (mat4(5.0, -3.0, 9.0, 2.0, -3.0, -7.0, 8.0, 5.0, -5.0, 6.0, -3.0, 3.0, 0.0, 2.0, -8.0, -5.0));
	blockB.a[6].mA.mA = (mat2(6.0, 3.0, -6.0, 7.0));
	blockB.a[6].mA.mB[0] = (mat3x4(1.0, -2.0, 4.0, -8.0, 3.0, 7.0, -7.0, 1.0, 1.0, -7.0, -2.0, 8.0));
	blockB.a[6].mA.mB[1] = (mat3x4(4.0, -3.0, -4.0, 2.0, -8.0, 0.0, 5.0, -8.0, -9.0, 8.0, -7.0, 2.0));
	blockB.a[6].mA.mB[2] = (mat3x4(3.0, -6.0, -4.0, 5.0, 9.0, 7.0, 8.0, -9.0, -9.0, -9.0, 5.0, -8.0));
	blockB.a[6].mA.mB[3] = (mat3x4(-7.0, -9.0, 0.0, 3.0, -6.0, -1.0, -1.0, -4.0, 4.0, -7.0, -1.0, -6.0));
	blockB.a[6].mA.mB[4] = (mat3x4(-5.0, 6.0, 3.0, 8.0, -5.0, 0.0, 0.0, -2.0, 4.0, -6.0, 1.0, -4.0));
	blockB.a[6].mA.mB[5] = (mat3x4(8.0, -9.0, -2.0, 7.0, -8.0, 5.0, 6.0, -8.0, 0.0, 5.0, -7.0, 6.0));
	blockB.a[6].mA.mB[6] = (mat3x4(0.0, 9.0, 5.0, 7.0, 1.0, -2.0, 7.0, 9.0, 9.0, -6.0, 7.0, -7.0));
	blockB.a[6].mA.mC = (mat3(7.0, 9.0, -3.0, 8.0, 3.0, -9.0, -6.0, -8.0, -6.0));
	blockB.a[6].mA.mD = (vec2(-3.0, -6.0));
	blockB.a[6].mB = (mat3x4(-1.0, 9.0, -4.0, 2.0, 4.0, 0.0, -9.0, -3.0, -3.0, 0.0, 9.0, -7.0));
	blockB.a[6].mC = (uvec3(4u, 7u, 8u));
	blockB.a[6].mD = (mat4(3.0, 2.0, 7.0, -2.0, -8.0, 0.0, -9.0, -1.0, -4.0, -3.0, 1.0, -9.0, 0.0, -6.0, -8.0, -2.0));
}
#version 450
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
	lowp int mA;
	bvec2 mB;
	lowp uint mC;
};
struct sB
{
	highp vec3 mA;
	highp mat3x2 mB;
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	highp mat2 a;
	bvec3 b;
	lowp ivec4 c;
	sA d;
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	bvec3 e[5];
	sB f;
	bvec3 g;
} blockC;
layout(std140, row_major, binding = 3) buffer BlockD
{
	bool h;
	bool i[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.b), bvec3(false, false, false)) && allOk;
	allOk = compare_int((blockB.d.mA), 0) && allOk;
	allOk = compare_bvec2((blockB.d.mB), bvec2(false, false)) && allOk;
	allOk = compare_uint((blockB.d.mC), 8u) && allOk;
	allOk = compare_vec3((blockC.f.mA), vec3(7.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3x2(blockC.f.mB, mat3x2(-8.0, 1.0, 6.0, -5.0, 3.0, 6.0)) && allOk;
	allOk = compare_bool((h), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2(-5.0, 4.0, -9.0, -7.0));
	blockB.d.mA = (-8);
	blockB.d.mB = (bvec2(false, true));
	blockB.d.mC = (1u);
	blockC.e[0] = (bvec3(false, true, false));
	blockC.e[1] = (bvec3(false, false, true));
	blockC.e[2] = (bvec3(true, false, false));
	blockC.e[3] = (bvec3(false, false, true));
	blockC.e[4] = (bvec3(true, true, true));
	blockC.f.mA = (vec3(-1.0, -7.0, 7.0));
	blockC.f.mB = (mat3x2(4.0, -3.0, 1.0, 6.0, 5.0, 8.0));
	blockC.g = (bvec3(true, false, false));
	h = (false);
	i[0] = (true);
	i[1] = (true);
	i[2] = (true);
	i[3] = (false);
	i[4] = (false);
	i[5] = (true);
}
#version 450
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
	highp float mB;
	lowp mat4x3 mC;
	mediump uint mD;
};
struct sB
{
	sA mA;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	bvec3 a;
	mediump mat3 b[1];
	mediump uvec2 c;
	mediump mat4x3 d;
	sB e[];
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	highp vec4 f;
	highp mat3x2 g[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((a), bvec3(true, true, false)) && allOk;
	allOk = compare_uvec2((c), uvec2(1u, 2u)) && allOk;
	allOk = compare_mat4x3(d, mat4x3(-8.0, 2.0, 1.0, 7.0, 6.0, 6.0, -1.0, 1.0, -8.0, 2.0, 1.0, -9.0)) && allOk;
	allOk = compare_vec4((blockC.f), vec4(1.0, 5.0, 9.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec3(true, true, true));
	b[0] = (mat3(-8.0, -4.0, 9.0, 7.0, 5.0, -2.0, 6.0, 7.0, 6.0));
	c = (uvec2(3u, 7u));
	d = (mat4x3(7.0, 0.0, 2.0, 5.0, -8.0, 6.0, -3.0, -8.0, 6.0, 1.0, 5.0, -9.0));
	blockC.f = (vec4(-9.0, 6.0, 8.0, 1.0));
	blockC.g[0] = (mat3x2(-3.0, 1.0, -2.0, -4.0, -8.0, -7.0));
	blockC.g[1] = (mat3x2(7.0, -1.0, 9.0, -1.0, 9.0, 0.0));
	blockC.g[2] = (mat3x2(-6.0, 9.0, -6.0, 0.0, 7.0, -6.0));
	blockC.g[3] = (mat3x2(7.0, -6.0, 4.0, 1.0, -6.0, -1.0));
}
#version 450
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
	lowp mat3 mA;
	lowp ivec3 mB;
};
struct sC
{
	bvec3 mA;
	highp uvec3 mB;
	highp int mC;
	sB mD;
};
layout(std140, binding = 1) buffer BlockB
{
	lowp ivec3 a;
	sA b[];
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	highp ivec3 c;
	sC d[];
} blockC[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.b[0].mA, mat4x3(9.0, -1.0, 0.0, -3.0, 9.0, -2.0, 0.0, 3.0, -3.0, 2.0, -3.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0].mA = (mat4x3(-7.0, -3.0, -9.0, 1.0, 2.0, 8.0, -2.0, 5.0, -7.0, -5.0, -9.0, -9.0));
	blockC[0].c = (ivec3(-7, 3, 1));
	blockC[1].c = (ivec3(0, -8, 4));
}
#version 450
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
	layout(offset = 16) bvec2 b;
	layout(offset = 24) lowp float c;
	layout(offset = 32) highp ivec3 d[1];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.a), vec4(6.0, -3.0, -3.0, -5.0)) && allOk;
	allOk = compare_bvec2((blockB.b), bvec2(true, true)) && allOk;
	allOk = compare_ivec3((blockB.d[0]), ivec3(9, -2, 6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (bvec2(false, true));
	blockB.c = (-4.0);
	blockB.d[0] = (ivec3(-9, -3, -6));
}
#version 450
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
	bool a[1];
	bvec4 b;
	lowp mat4x3 c;
	highp ivec3 d;
	highp ivec3 e[][2];
} blockB[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB[0].b), bvec4(true, true, true, true)) && allOk;
	allOk = compare_mat4x3(blockB[0].c, mat4x3(8.0, 1.0, 8.0, 1.0, 6.0, 7.0, -9.0, 3.0, 3.0, 7.0, -4.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].d = (ivec3(-6, 9, -9));
	blockB[0].e[0][0] = (ivec3(4, -3, -3));
	blockB[0].e[0][1] = (ivec3(6, -2, -2));
	blockB[0].e[1][0] = (ivec3(5, -1, -4));
	blockB[0].e[1][1] = (ivec3(-9, -6, 4));
	blockB[0].e[2][0] = (ivec3(-3, -9, -1));
	blockB[0].e[2][1] = (ivec3(-4, 0, -7));
	blockB[0].e[3][0] = (ivec3(9, 1, -3));
	blockB[0].e[3][1] = (ivec3(-7, -3, 4));
	blockB[0].e[4][0] = (ivec3(-4, 4, -5));
	blockB[0].e[4][1] = (ivec3(-7, 1, -7));
	blockB[0].e[5][0] = (ivec3(3, 2, -6));
	blockB[0].e[5][1] = (ivec3(8, -8, 6));
	blockB[0].e[6][0] = (ivec3(-1, 7, -5));
	blockB[0].e[6][1] = (ivec3(0, -1, 0));
	blockB[0].e[7][0] = (ivec3(1, 8, -3));
	blockB[0].e[7][1] = (ivec3(5, 6, -4));
}
#version 450
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
	mediump mat4 mB;
	mediump mat4 mC;
	lowp mat4 mD;
};
struct sB
{
	sA mA;
};
struct sC
{
	bool mA;
	highp mat4x2 mB;
	highp mat4x3 mC;
	mediump mat2x3 mD;
};
layout(scalar, row_major, binding = 1) buffer BlockB
{
	mediump int a[6];
	highp uvec4 b;
	sB c;
	mediump uvec3 d;
	bvec2 e[];
} blockB;
layout(scalar, binding = 2) buffer BlockC
{
	highp mat3x4 f;
	lowp ivec4 g;
	highp float h[8];
	sC i[][7];
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
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.b), uvec4(7u, 5u, 3u, 8u)) && allOk;
	allOk = compare_mat3x2(blockB.c.mA.mA, mat3x2(9.0, -4.0, 1.0, 5.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat4(blockB.c.mA.mB, mat4(-1.0, -8.0, -1.0, -3.0, -2.0, 3.0, 2.0, 0.0, 4.0, 6.0, -5.0, -8.0, 5.0, -4.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat4(blockB.c.mA.mC, mat4(8.0, -7.0, 1.0, -6.0, -2.0, -3.0, -5.0, 2.0, -1.0, -9.0, 6.0, -1.0, 4.0, -5.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat4(blockB.c.mA.mD, mat4(-7.0, -2.0, -7.0, -4.0, -6.0, -5.0, 4.0, -9.0, 7.0, -5.0, -6.0, -5.0, -5.0, 6.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat3x4(f, mat3x4(-3.0, -7.0, -4.0, 6.0, -5.0, -5.0, -7.0, -9.0, -2.0, -8.0, 3.0, -4.0)) && allOk;
	allOk = compare_ivec4((g), ivec4(7, -5, 1, 5)) && allOk;
	allOk = compare_float((h[0]), -4.0) && allOk;
	allOk = compare_float((h[1]), -8.0) && allOk;
	allOk = compare_float((h[2]), 1.0) && allOk;
	allOk = compare_float((h[3]), -1.0) && allOk;
	allOk = compare_float((h[4]), -1.0) && allOk;
	allOk = compare_float((h[5]), 3.0) && allOk;
	allOk = compare_float((h[6]), -6.0) && allOk;
	allOk = compare_float((h[7]), 5.0) && allOk;
	allOk = compare_bool((i[0][0].mA), false) && allOk;
	allOk = compare_mat4x2(i[0][0].mB, mat4x2(6.0, 1.0, -1.0, 4.0, 6.0, 8.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x3(i[0][0].mC, mat4x3(-1.0, 6.0, -2.0, 6.0, 8.0, -5.0, 7.0, -7.0, -8.0, 1.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat2x3(i[0][0].mD, mat2x3(8.0, -8.0, -2.0, -5.0, -3.0, 5.0)) && allOk;
	allOk = compare_bool((i[0][1].mA), false) && allOk;
	allOk = compare_mat4x2(i[0][1].mB, mat4x2(-3.0, -2.0, -1.0, -8.0, 7.0, -8.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat4x3(i[0][1].mC, mat4x3(-5.0, -5.0, -2.0, -2.0, 4.0, 7.0, -3.0, -4.0, 0.0, 4.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat2x3(i[0][1].mD, mat2x3(-5.0, 4.0, -3.0, 6.0, 4.0, -9.0)) && allOk;
	allOk = compare_bool((i[0][2].mA), false) && allOk;
	allOk = compare_mat4x2(i[0][2].mB, mat4x2(-7.0, 0.0, 6.0, -4.0, 6.0, -8.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4x3(i[0][2].mC, mat4x3(-4.0, -1.0, 1.0, -1.0, -6.0, 4.0, -3.0, -2.0, -5.0, 6.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat2x3(i[0][2].mD, mat2x3(1.0, -8.0, 4.0, -9.0, -2.0, 7.0)) && allOk;
	allOk = compare_bool((i[0][3].mA), true) && allOk;
	allOk = compare_mat4x2(i[0][3].mB, mat4x2(-5.0, 0.0, 1.0, -4.0, -7.0, -5.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(i[0][3].mC, mat4x3(-2.0, -7.0, -9.0, 3.0, -8.0, -6.0, -8.0, -6.0, 6.0, -5.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x3(i[0][3].mD, mat2x3(-3.0, 2.0, -9.0, -5.0, 1.0, 2.0)) && allOk;
	allOk = compare_bool((i[0][4].mA), false) && allOk;
	allOk = compare_mat4x2(i[0][4].mB, mat4x2(2.0, 0.0, 9.0, -5.0, 1.0, 4.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat4x3(i[0][4].mC, mat4x3(-5.0, -4.0, 6.0, 7.0, -6.0, -7.0, 9.0, -1.0, -9.0, -4.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat2x3(i[0][4].mD, mat2x3(-6.0, -2.0, -1.0, 7.0, 8.0, 1.0)) && allOk;
	allOk = compare_bool((i[0][5].mA), false) && allOk;
	allOk = compare_mat4x2(i[0][5].mB, mat4x2(-6.0, 0.0, -8.0, -6.0, -4.0, 3.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat4x3(i[0][5].mC, mat4x3(-7.0, -9.0, -4.0, 3.0, -5.0, -8.0, -4.0, 8.0, -8.0, 4.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat2x3(i[0][5].mD, mat2x3(1.0, 2.0, -6.0, -8.0, -4.0, 5.0)) && allOk;
	allOk = compare_bool((i[0][6].mA), true) && allOk;
	allOk = compare_mat4x2(i[0][6].mB, mat4x2(-5.0, 8.0, -7.0, -4.0, 9.0, 9.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x3(i[0][6].mC, mat4x3(2.0, 3.0, -4.0, -9.0, 8.0, -9.0, -8.0, -1.0, -4.0, 0.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat2x3(i[0][6].mD, mat2x3(-9.0, -8.0, -6.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_bool((i[1][0].mA), true) && allOk;
	allOk = compare_mat4x2(i[1][0].mB, mat4x2(-8.0, -6.0, -4.0, -7.0, 0.0, 4.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat4x3(i[1][0].mC, mat4x3(-2.0, 1.0, 3.0, 6.0, 4.0, -2.0, -3.0, -7.0, 5.0, 5.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x3(i[1][0].mD, mat2x3(1.0, 7.0, 3.0, 9.0, 5.0, 1.0)) && allOk;
	allOk = compare_bool((i[1][1].mA), true) && allOk;
	allOk = compare_mat4x2(i[1][1].mB, mat4x2(-6.0, 7.0, 3.0, -6.0, 8.0, -4.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x3(i[1][1].mC, mat4x3(1.0, -7.0, 6.0, -2.0, -2.0, -4.0, -7.0, 0.0, 3.0, 3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat2x3(i[1][1].mD, mat2x3(0.0, -2.0, -8.0, -4.0, -8.0, 8.0)) && allOk;
	allOk = compare_bool((i[1][2].mA), false) && allOk;
	allOk = compare_mat4x2(i[1][2].mB, mat4x2(-7.0, 5.0, 9.0, 5.0, 7.0, -8.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat4x3(i[1][2].mC, mat4x3(-1.0, -9.0, -8.0, -7.0, -4.0, -5.0, -9.0, 1.0, 6.0, 5.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2x3(i[1][2].mD, mat2x3(8.0, -3.0, -8.0, -6.0, -9.0, 9.0)) && allOk;
	allOk = compare_bool((i[1][3].mA), false) && allOk;
	allOk = compare_mat4x2(i[1][3].mB, mat4x2(-5.0, 5.0, 3.0, 1.0, 2.0, -3.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(i[1][3].mC, mat4x3(-2.0, -6.0, 6.0, -9.0, 0.0, -4.0, 1.0, -3.0, -3.0, 2.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat2x3(i[1][3].mD, mat2x3(-6.0, 3.0, -2.0, -2.0, -4.0, -9.0)) && allOk;
	allOk = compare_bool((i[1][4].mA), true) && allOk;
	allOk = compare_mat4x2(i[1][4].mB, mat4x2(-7.0, 5.0, 0.0, -6.0, -1.0, 1.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(i[1][4].mC, mat4x3(1.0, -7.0, -4.0, 0.0, -7.0, -3.0, 6.0, 8.0, -7.0, 5.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2x3(i[1][4].mD, mat2x3(4.0, -9.0, 5.0, 8.0, 6.0, 4.0)) && allOk;
	allOk = compare_bool((i[1][5].mA), false) && allOk;
	allOk = compare_mat4x2(i[1][5].mB, mat4x2(-2.0, -1.0, 0.0, -9.0, 3.0, 1.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat4x3(i[1][5].mC, mat4x3(9.0, 3.0, -7.0, 8.0, -5.0, 7.0, -6.0, 3.0, 8.0, 8.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat2x3(i[1][5].mD, mat2x3(9.0, 2.0, 6.0, 2.0, -9.0, -3.0)) && allOk;
	allOk = compare_bool((i[1][6].mA), true) && allOk;
	allOk = compare_mat4x2(i[1][6].mB, mat4x2(0.0, -3.0, 3.0, -4.0, 0.0, -5.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat4x3(i[1][6].mC, mat4x3(8.0, 9.0, 5.0, 6.0, 5.0, 7.0, -4.0, -9.0, -9.0, 7.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat2x3(i[1][6].mD, mat2x3(-1.0, 5.0, -4.0, -6.0, -1.0, 2.0)) && allOk;
	allOk = compare_bool((i[2][0].mA), true) && allOk;
	allOk = compare_mat4x2(i[2][0].mB, mat4x2(-2.0, 9.0, -6.0, 1.0, 3.0, 5.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat4x3(i[2][0].mC, mat4x3(1.0, -8.0, 8.0, 5.0, -1.0, 4.0, 3.0, 0.0, -9.0, 8.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat2x3(i[2][0].mD, mat2x3(-8.0, -9.0, -6.0, 7.0, -5.0, -9.0)) && allOk;
	allOk = compare_bool((i[2][1].mA), true) && allOk;
	allOk = compare_mat4x2(i[2][1].mB, mat4x2(-7.0, -3.0, 0.0, -1.0, 6.0, 9.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat4x3(i[2][1].mC, mat4x3(6.0, -2.0, 7.0, -2.0, -6.0, 1.0, -3.0, 1.0, -3.0, -9.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat2x3(i[2][1].mD, mat2x3(7.0, -8.0, -7.0, 4.0, 6.0, -8.0)) && allOk;
	allOk = compare_bool((i[2][2].mA), false) && allOk;
	allOk = compare_mat4x2(i[2][2].mB, mat4x2(0.0, 9.0, 4.0, 1.0, 6.0, 0.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat4x3(i[2][2].mC, mat4x3(1.0, -1.0, 2.0, -5.0, -9.0, 2.0, -2.0, 2.0, 5.0, -1.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat2x3(i[2][2].mD, mat2x3(-5.0, 7.0, 6.0, 0.0, 9.0, -3.0)) && allOk;
	allOk = compare_bool((i[2][3].mA), false) && allOk;
	allOk = compare_mat4x2(i[2][3].mB, mat4x2(3.0, -1.0, -7.0, 8.0, 0.0, -2.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4x3(i[2][3].mC, mat4x3(9.0, 1.0, 7.0, 9.0, -5.0, -7.0, 5.0, -6.0, 7.0, 5.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2x3(i[2][3].mD, mat2x3(-3.0, -5.0, 3.0, 0.0, 6.0, -1.0)) && allOk;
	allOk = compare_bool((i[2][4].mA), true) && allOk;
	allOk = compare_mat4x2(i[2][4].mB, mat4x2(-9.0, 9.0, 1.0, 0.0, -9.0, -8.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat4x3(i[2][4].mC, mat4x3(3.0, -9.0, 1.0, -5.0, 2.0, 8.0, 1.0, -3.0, -8.0, 6.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat2x3(i[2][4].mD, mat2x3(-7.0, 0.0, 4.0, 1.0, -9.0, 5.0)) && allOk;
	allOk = compare_bool((i[2][5].mA), false) && allOk;
	allOk = compare_mat4x2(i[2][5].mB, mat4x2(-7.0, 9.0, 3.0, -5.0, 7.0, -5.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4x3(i[2][5].mC, mat4x3(-1.0, -5.0, -1.0, 0.0, 1.0, 7.0, -8.0, 4.0, -1.0, 3.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(i[2][5].mD, mat2x3(-8.0, -6.0, -3.0, -7.0, 0.0, 6.0)) && allOk;
	allOk = compare_bool((i[2][6].mA), false) && allOk;
	allOk = compare_mat4x2(i[2][6].mB, mat4x2(-1.0, 6.0, 0.0, -1.0, -4.0, 6.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(i[2][6].mC, mat4x3(-9.0, 2.0, 7.0, -5.0, -9.0, 2.0, -2.0, 5.0, -8.0, 0.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat2x3(i[2][6].mD, mat2x3(9.0, -4.0, -6.0, -1.0, 9.0, 4.0)) && allOk;
	allOk = compare_bool((i[3][0].mA), false) && allOk;
	allOk = compare_mat4x2(i[3][0].mB, mat4x2(5.0, 8.0, -5.0, -7.0, -2.0, 5.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(i[3][0].mC, mat4x3(5.0, 1.0, -6.0, 6.0, 4.0, -3.0, 3.0, -4.0, 3.0, -3.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2x3(i[3][0].mD, mat2x3(-9.0, 3.0, -8.0, -6.0, 2.0, 7.0)) && allOk;
	allOk = compare_bool((i[3][1].mA), true) && allOk;
	allOk = compare_mat4x2(i[3][1].mB, mat4x2(-9.0, 3.0, 3.0, 4.0, 4.0, 3.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat4x3(i[3][1].mC, mat4x3(-1.0, 6.0, 3.0, 5.0, 3.0, -6.0, 9.0, 2.0, -8.0, -6.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat2x3(i[3][1].mD, mat2x3(7.0, -6.0, -2.0, -5.0, 0.0, 3.0)) && allOk;
	allOk = compare_bool((i[3][2].mA), false) && allOk;
	allOk = compare_mat4x2(i[3][2].mB, mat4x2(6.0, -3.0, -3.0, 8.0, 8.0, 7.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4x3(i[3][2].mC, mat4x3(6.0, 8.0, 2.0, -1.0, 3.0, -5.0, -5.0, -3.0, -1.0, -8.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x3(i[3][2].mD, mat2x3(3.0, 2.0, 3.0, 4.0, -1.0, -8.0)) && allOk;
	allOk = compare_bool((i[3][3].mA), false) && allOk;
	allOk = compare_mat4x2(i[3][3].mB, mat4x2(6.0, -9.0, 0.0, 5.0, 1.0, 3.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat4x3(i[3][3].mC, mat4x3(-7.0, 0.0, -8.0, 0.0, 4.0, 3.0, -8.0, 6.0, 2.0, -7.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2x3(i[3][3].mD, mat2x3(-5.0, -4.0, 7.0, -5.0, 4.0, -4.0)) && allOk;
	allOk = compare_bool((i[3][4].mA), false) && allOk;
	allOk = compare_mat4x2(i[3][4].mB, mat4x2(2.0, 2.0, 9.0, -7.0, 3.0, 6.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(i[3][4].mC, mat4x3(-6.0, 3.0, 7.0, -5.0, -8.0, -8.0, -5.0, -7.0, 2.0, 9.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2x3(i[3][4].mD, mat2x3(-5.0, 6.0, -7.0, -7.0, -7.0, -7.0)) && allOk;
	allOk = compare_bool((i[3][5].mA), true) && allOk;
	allOk = compare_mat4x2(i[3][5].mB, mat4x2(3.0, -3.0, 6.0, -7.0, 7.0, -1.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4x3(i[3][5].mC, mat4x3(8.0, -9.0, -8.0, -4.0, 9.0, 5.0, 2.0, -7.0, -6.0, 9.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat2x3(i[3][5].mD, mat2x3(2.0, 8.0, 8.0, 1.0, -6.0, -8.0)) && allOk;
	allOk = compare_bool((i[3][6].mA), true) && allOk;
	allOk = compare_mat4x2(i[3][6].mB, mat4x2(3.0, -6.0, 3.0, 8.0, 9.0, 1.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4x3(i[3][6].mC, mat4x3(1.0, 2.0, 1.0, -2.0, -2.0, 2.0, 0.0, 4.0, -7.0, 2.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat2x3(i[3][6].mD, mat2x3(-7.0, -7.0, -5.0, 9.0, 1.0, 5.0)) && allOk;
	allOk = compare_bool((i[4][0].mA), true) && allOk;
	allOk = compare_mat4x2(i[4][0].mB, mat4x2(-8.0, -7.0, -3.0, -5.0, -5.0, 1.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat4x3(i[4][0].mC, mat4x3(-8.0, -5.0, 3.0, -1.0, -5.0, 4.0, 7.0, -4.0, -7.0, 0.0, -9.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c.mA.mA = (mat3x2(-4.0, -7.0, -5.0, -3.0, -7.0, 1.0));
	blockB.c.mA.mB = (mat4(9.0, 5.0, -7.0, -8.0, -5.0, 5.0, 4.0, 6.0, -1.0, -8.0, 9.0, 5.0, 0.0, -3.0, 0.0, -2.0));
	blockB.c.mA.mC = (mat4(8.0, -2.0, -8.0, -6.0, 5.0, 2.0, 8.0, 5.0, 5.0, -5.0, 2.0, 1.0, 5.0, 9.0, -1.0, 3.0));
	blockB.c.mA.mD = (mat4(-1.0, 3.0, 5.0, -7.0, -7.0, 2.0, 2.0, 6.0, -6.0, -2.0, -4.0, 6.0, 4.0, 4.0, -8.0, 4.0));
	blockB.d = (uvec3(8u, 0u, 4u));
	blockB.e[0] = (bvec2(true, false));
	blockB.e[1] = (bvec2(false, true));
	f = (mat3x4(2.0, 2.0, 3.0, 1.0, 7.0, -1.0, -2.0, 9.0, 3.0, -6.0, 0.0, 7.0));
	h[0] = (-9.0);
	h[1] = (1.0);
	h[2] = (-5.0);
	h[3] = (-4.0);
	h[4] = (-3.0);
	h[5] = (-6.0);
	h[6] = (-9.0);
	h[7] = (0.0);
	i[0][0].mA = (true);
	i[0][0].mB = (mat4x2(-7.0, -1.0, -3.0, 0.0, -7.0, -1.0, -1.0, -2.0));
	i[0][0].mC = (mat4x3(6.0, -2.0, 8.0, -7.0, 6.0, -2.0, 6.0, 3.0, -7.0, 5.0, -2.0, 1.0));
	i[0][0].mD = (mat2x3(-2.0, -4.0, 1.0, 8.0, 8.0, -8.0));
	i[0][1].mA = (true);
	i[0][1].mB = (mat4x2(3.0, -1.0, -4.0, -8.0, 2.0, -1.0, -7.0, 8.0));
	i[0][1].mC = (mat4x3(7.0, -1.0, -7.0, 2.0, -3.0, -4.0, -1.0, -4.0, -3.0, 0.0, -2.0, -3.0));
	i[0][1].mD = (mat2x3(-9.0, 9.0, 1.0, -5.0, -5.0, -3.0));
	i[0][2].mA = (false);
	i[0][2].mB = (mat4x2(8.0, 9.0, -1.0, -2.0, 7.0, 2.0, 6.0, -4.0));
	i[0][2].mC = (mat4x3(-1.0, -7.0, 7.0, 9.0, -3.0, 8.0, 6.0, 4.0, -8.0, -4.0, 9.0, 4.0));
	i[0][2].mD = (mat2x3(-7.0, 4.0, 4.0, 6.0, -8.0, 7.0));
	i[0][3].mA = (false);
	i[0][3].mB = (mat4x2(7.0, 3.0, 5.0, -4.0, -2.0, 9.0, 8.0, -3.0));
	i[0][3].mC = (mat4x3(-8.0, -4.0, -1.0, 8.0, 0.0, 8.0, 3.0, 9.0, -9.0, 6.0, 0.0, -7.0));
	i[0][3].mD = (mat2x3(-1.0, 8.0, 1.0, 9.0, -3.0, -8.0));
	i[0][4].mA = (false);
	i[0][4].mB = (mat4x2(-4.0, -3.0, 1.0, -6.0, 7.0, -5.0, -5.0, -3.0));
	i[0][4].mC = (mat4x3(-1.0, -6.0, -4.0, -8.0, -1.0, -5.0, 5.0, -6.0, 7.0, -6.0, -6.0, 9.0));
	i[0][4].mD = (mat2x3(-3.0, -8.0, 5.0, -1.0, -8.0, -5.0));
	i[0][5].mA = (true);
	i[0][5].mB = (mat4x2(8.0, -5.0, 0.0, 3.0, 9.0, -4.0, -9.0, -5.0));
	i[0][5].mC = (mat4x3(3.0, 2.0, 5.0, -7.0, -1.0, 4.0, -5.0, -8.0, 8.0, -9.0, 4.0, -7.0));
	i[0][5].mD = (mat2x3(-7.0, -4.0, 6.0, -1.0, 8.0, -5.0));
	i[0][6].mA = (true);
	i[0][6].mB = (mat4x2(3.0, 4.0, -8.0, 0.0, -4.0, 6.0, 6.0, -7.0));
	i[0][6].mC = (mat4x3(6.0, 5.0, 8.0, -7.0, 4.0, -5.0, -5.0, 1.0, -6.0, 6.0, -5.0, -2.0));
	i[0][6].mD = (mat2x3(-9.0, 9.0, 0.0, 8.0, 4.0, 0.0));
	i[1][0].mA = (false);
	i[1][0].mB = (mat4x2(-6.0, -8.0, 3.0, -6.0, 0.0, 5.0, -8.0, 0.0));
	i[1][0].mC = (mat4x3(9.0, 1.0, -4.0, 0.0, 2.0, 7.0, -7.0, 8.0, 6.0, 7.0, -4.0, -1.0));
	i[1][0].mD = (mat2x3(-4.0, 6.0, 6.0, 8.0, -1.0, 4.0));
	i[1][1].mA = (false);
	i[1][1].mB = (mat4x2(-8.0, -6.0, -1.0, 3.0, 4.0, -6.0, 9.0, 8.0));
	i[1][1].mC = (mat4x3(5.0, -8.0, -6.0, -9.0, -9.0, -8.0, 4.0, -9.0, 0.0, -9.0, 9.0, 2.0));
	i[1][1].mD = (mat2x3(1.0, -6.0, 7.0, -2.0, 1.0, 0.0));
	i[1][2].mA = (false);
	i[1][2].mB = (mat4x2(-9.0, -2.0, -3.0, 3.0, 1.0, -4.0, -2.0, -2.0));
	i[1][2].mC = (mat4x3(6.0, 1.0, 1.0, 9.0, -5.0, 1.0, 6.0, -5.0, 0.0, -1.0, 1.0, -1.0));
	i[1][2].mD = (mat2x3(8.0, -7.0, -8.0, 5.0, -1.0, 2.0));
	i[1][3].mA = (false);
	i[1][3].mB = (mat4x2(3.0, 8.0, 1.0, 9.0, 4.0, 9.0, 1.0, 5.0));
	i[1][3].mC = (mat4x3(-3.0, 8.0, 0.0, -7.0, 0.0, -6.0, -5.0, -6.0, 6.0, -1.0, -1.0, 8.0));
	i[1][3].mD = (mat2x3(0.0, -7.0, 7.0, 4.0, -7.0, 7.0));
	i[1][4].mA = (true);
	i[1][4].mB = (mat4x2(5.0, -1.0, -4.0, 7.0, 9.0, -4.0, -7.0, 0.0));
	i[1][4].mC = (mat4x3(-9.0, -5.0, -2.0, -6.0, -8.0, 4.0, 7.0, -9.0, 2.0, -4.0, 4.0, -3.0));
	i[1][4].mD = (mat2x3(-4.0, 4.0, -3.0, 4.0, 9.0, 7.0));
	i[1][5].mA = (true);
	i[1][5].mB = (mat4x2(-2.0, -2.0, -4.0, 9.0, 6.0, 7.0, 1.0, 0.0));
	i[1][5].mC = (mat4x3(-7.0, 3.0, -6.0, -3.0, -5.0, 0.0, -2.0, 5.0, 2.0, -3.0, -1.0, 2.0));
	i[1][5].mD = (mat2x3(3.0, 1.0, 3.0, 3.0, -3.0, 4.0));
	i[1][6].mA = (false);
	i[1][6].mB = (mat4x2(8.0, 0.0, -4.0, -5.0, 8.0, -3.0, 7.0, -4.0));
	i[1][6].mC = (mat4x3(2.0, 1.0, 1.0, 0.0, -9.0, 8.0, -6.0, -8.0, 9.0, 1.0, 5.0, -2.0));
	i[1][6].mD = (mat2x3(-8.0, 5.0, 5.0, 5.0, -7.0, 5.0));
	i[2][0].mA = (false);
	i[2][0].mB = (mat4x2(-3.0, 3.0, -5.0, 7.0, 2.0, -2.0, 1.0, -2.0));
	i[2][0].mC = (mat4x3(7.0, 4.0, 2.0, -5.0, -4.0, -2.0, 6.0, 2.0, 1.0, 0.0, -1.0, 1.0));
	i[2][0].mD = (mat2x3(0.0, -6.0, -8.0, 8.0, -8.0, 9.0));
	i[2][1].mA = (true);
	i[2][1].mB = (mat4x2(9.0, -7.0, -2.0, 5.0, 2.0, 8.0, 7.0, 0.0));
	i[2][1].mC = (mat4x3(-7.0, -6.0, 4.0, -3.0, 6.0, -4.0, 3.0, -4.0, -3.0, 6.0, 4.0, 1.0));
	i[2][1].mD = (mat2x3(9.0, -6.0, -1.0, 9.0, -5.0, -7.0));
	i[2][2].mA = (false);
	i[2][2].mB = (mat4x2(7.0, -6.0, -7.0, 0.0, -8.0, 3.0, -3.0, -7.0));
	i[2][2].mC = (mat4x3(-6.0, 8.0, -9.0, -7.0, -6.0, -8.0, 2.0, 0.0, 3.0, -4.0, 6.0, -7.0));
	i[2][2].mD = (mat2x3(-8.0, -1.0, 0.0, -3.0, -9.0, 6.0));
	i[2][3].mA = (false);
	i[2][3].mB = (mat4x2(0.0, -3.0, -9.0, 7.0, -9.0, 4.0, 4.0, -7.0));
	i[2][3].mC = (mat4x3(0.0, -1.0, -2.0, 5.0, -7.0, -9.0, -2.0, -2.0, 4.0, 6.0, 6.0, -5.0));
	i[2][3].mD = (mat2x3(-1.0, -7.0, -9.0, 7.0, -3.0, 3.0));
	i[2][4].mA = (false);
	i[2][4].mB = (mat4x2(4.0, -7.0, -5.0, -9.0, 7.0, 0.0, -3.0, 2.0));
	i[2][4].mC = (mat4x3(8.0, -3.0, 8.0, -5.0, -3.0, -4.0, -5.0, 0.0, 5.0, 4.0, 9.0, 3.0));
	i[2][4].mD = (mat2x3(-7.0, 0.0, 5.0, 6.0, -7.0, 0.0));
	i[2][5].mA = (true);
	i[2][5].mB = (mat4x2(-4.0, -4.0, 4.0, -6.0, 6.0, -7.0, 0.0, -8.0));
	i[2][5].mC = (mat4x3(-1.0, 4.0, -5.0, 1.0, 2.0, 7.0, 8.0, -3.0, 7.0, 4.0, -6.0, -2.0));
	i[2][5].mD = (mat2x3(-7.0, 6.0, 9.0, -3.0, -7.0, -6.0));
	i[2][6].mA = (true);
	i[2][6].mB = (mat4x2(3.0, -6.0, 9.0, -1.0, -8.0, -8.0, -7.0, 0.0));
	i[2][6].mC = (mat4x3(-9.0, 7.0, 6.0, -7.0, -9.0, -1.0, -6.0, -7.0, -7.0, -4.0, -5.0, -2.0));
	i[2][6].mD = (mat2x3(-6.0, 7.0, -7.0, -9.0, -3.0, 8.0));
	i[3][0].mA = (false);
	i[3][0].mB = (mat4x2(3.0, 4.0, -4.0, -2.0, -9.0, 6.0, 5.0, -4.0));
	i[3][0].mC = (mat4x3(1.0, 0.0, -6.0, 1.0, 0.0, 6.0, -2.0, 7.0, 0.0, -1.0, -6.0, 6.0));
	i[3][0].mD = (mat2x3(-8.0, 3.0, 7.0, 0.0, -8.0, 9.0));
	i[3][1].mA = (false);
	i[3][1].mB = (mat4x2(-2.0, 2.0, 9.0, 9.0, 8.0, -6.0, -8.0, -1.0));
	i[3][1].mC = (mat4x3(-2.0, -9.0, -5.0, 6.0, -1.0, -9.0, 5.0, 3.0, -9.0, -7.0, -4.0, 5.0));
	i[3][1].mD = (mat2x3(-3.0, -8.0, -5.0, -1.0, 2.0, 1.0));
	i[3][2].mA = (false);
	i[3][2].mB = (mat4x2(-6.0, -6.0, 7.0, -3.0, -2.0, 5.0, 7.0, 7.0));
	i[3][2].mC = (mat4x3(1.0, 2.0, -5.0, -4.0, -1.0, 5.0, 1.0, 1.0, 9.0, -6.0, -7.0, -6.0));
	i[3][2].mD = (mat2x3(9.0, 9.0, -4.0, 2.0, 9.0, -3.0));
	i[3][3].mA = (false);
	i[3][3].mB = (mat4x2(3.0, 5.0, -3.0, 0.0, 2.0, 0.0, 8.0, -9.0));
	i[3][3].mC = (mat4x3(-9.0, 7.0, 5.0, -3.0, -7.0, 6.0, -8.0, 0.0, 1.0, 4.0, 4.0, -8.0));
	i[3][3].mD = (mat2x3(-8.0, -8.0, 5.0, -2.0, 6.0, 2.0));
	i[3][4].mA = (false);
	i[3][4].mB = (mat4x2(2.0, -2.0, 8.0, -5.0, 6.0, -5.0, -5.0, 7.0));
	i[3][4].mC = (mat4x3(6.0, -2.0, 6.0, 3.0, 8.0, 1.0, -9.0, 6.0, 0.0, 9.0, -3.0, -2.0));
	i[3][4].mD = (mat2x3(9.0, -3.0, -1.0, -9.0, 5.0, -7.0));
	i[3][5].mA = (false);
	i[3][5].mB = (mat4x2(6.0, 9.0, -5.0, -6.0, 1.0, 5.0, 6.0, 6.0));
	i[3][5].mC = (mat4x3(-9.0, 6.0, 5.0, -8.0, -5.0, 2.0, 9.0, -5.0, 9.0, 7.0, -4.0, 6.0));
	i[3][5].mD = (mat2x3(0.0, 6.0, -7.0, -9.0, 9.0, 4.0));
	i[3][6].mA = (false);
	i[3][6].mB = (mat4x2(-1.0, 5.0, -3.0, -2.0, -5.0, -1.0, -1.0, -1.0));
	i[3][6].mC = (mat4x3(-9.0, 4.0, 7.0, -6.0, -1.0, -9.0, -8.0, -6.0, 8.0, -2.0, -4.0, 2.0));
	i[3][6].mD = (mat2x3(-1.0, -2.0, -1.0, 9.0, -4.0, -8.0));
	i[4][0].mA = (false);
	i[4][0].mB = (mat4x2(-8.0, -8.0, -5.0, 3.0, -9.0, 7.0, 2.0, -1.0));
	i[4][0].mC = (mat4x3(-1.0, -2.0, -3.0, -3.0, -3.0, 2.0, -4.0, -2.0, 7.0, -5.0, 1.0, 4.0));
	i[4][0].mD = (mat2x3(-1.0, 2.0, 8.0, -5.0, 6.0, -1.0));
	i[4][1].mA = (false);
	i[4][1].mB = (mat4x2(-7.0, -1.0, -2.0, 0.0, -4.0, -5.0, -7.0, 9.0));
	i[4][1].mC = (mat4x3(-4.0, 6.0, 8.0, -2.0, 1.0, 8.0, 4.0, 1.0, -8.0, -5.0, 3.0, -4.0));
	i[4][1].mD = (mat2x3(-1.0, -3.0, 6.0, 9.0, 8.0, -2.0));
	i[4][2].mA = (true);
	i[4][2].mB = (mat4x2(-3.0, 6.0, -5.0, -1.0, -4.0, 3.0, -6.0, 7.0));
	i[4][2].mC = (mat4x3(3.0, 9.0, -1.0, -7.0, 0.0, -3.0, -1.0, 5.0, 8.0, -5.0, 2.0, -8.0));
	i[4][2].mD = (mat2x3(7.0, 5.0, 3.0, -8.0, 9.0, 8.0));
	i[4][3].mA = (true);
	i[4][3].mB = (mat4x2(6.0, -1.0, -3.0, -2.0, -6.0, 0.0, -2.0, 6.0));
	i[4][3].mC = (mat4x3(5.0, -7.0, 4.0, -8.0, 3.0, -2.0, -7.0, 7.0, 3.0, 4.0, -2.0, -8.0));
	i[4][3].mD = (mat2x3(3.0, -4.0, 8.0, 2.0, -3.0, 7.0));
	i[4][4].mA = (false);
	i[4][4].mB = (mat4x2(-1.0, 1.0, -3.0, -8.0, 0.0, -5.0, -9.0, 4.0));
	i[4][4].mC = (mat4x3(-3.0, 2.0, -9.0, 4.0, 6.0, -2.0, 3.0, 8.0, 8.0, -5.0, -7.0, 2.0));
	i[4][4].mD = (mat2x3(8.0, 4.0, -8.0, 9.0, 0.0, 2.0));
	i[4][5].mA = (true);
	i[4][5].mB = (mat4x2(-7.0, 8.0, 9.0, 2.0, 7.0, 9.0, -9.0, 0.0));
	i[4][5].mC = (mat4x3(2.0, -2.0, -5.0, -9.0, 4.0, -3.0, -9.0, 4.0, -6.0, -2.0, -5.0, -4.0));
	i[4][5].mD = (mat2x3(-3.0, 4.0, -3.0, 0.0, -1.0, -8.0));
	i[4][6].mA = (false);
	i[4][6].mB = (mat4x2(-9.0, 2.0, -6.0, -2.0, -8.0, 1.0, 7.0, 6.0));
	i[4][6].mC = (mat4x3(-8.0, -7.0, -7.0, 8.0, -8.0, 1.0, -1.0, 6.0, 7.0, 8.0, -8.0, 5.0));
	i[4][6].mD = (mat2x3(4.0, 4.0, 7.0, -5.0, -8.0, -7.0));
	i[5][0].mA = (false);
	i[5][0].mB = (mat4x2(6.0, 5.0, 1.0, 0.0, -4.0, 8.0, 7.0, 3.0));
	i[5][0].mC = (mat4x3(-6.0, -1.0, -6.0, 0.0, 0.0, 8.0, -8.0, 9.0, -1.0, -6.0, 1.0, -8.0));
	i[5][0].mD = (mat2x3(4.0, -1.0, -5.0, -6.0, -7.0, -4.0));
	i[5][1].mA = (true);
	i[5][1].mB = (mat4x2(5.0, 6.0, -6.0, 3.0, 1.0, 1.0, 3.0, 3.0));
	i[5][1].mC = (mat4x3(4.0, 8.0, -5.0, 0.0, 9.0, -8.0, 6.0, -7.0, 8.0, -8.0, -5.0, -1.0));
	i[5][1].mD = (mat2x3(0.0, -7.0, 3.0, -2.0, -9.0, -9.0));
	i[5][2].mA = (false);
	i[5][2].mB = (mat4x2(6.0, -9.0, -5.0, 2.0, -3.0, 9.0, -5.0, 8.0));
	i[5][2].mC = (mat4x3(3.0, -9.0, 8.0, 5.0, 9.0, -7.0, 4.0, -2.0, -3.0, 0.0, -9.0, 2.0));
	i[5][2].mD = (mat2x3(-9.0, -9.0, 3.0, 5.0, 9.0, 0.0));
	i[5][3].mA = (true);
	i[5][3].mB = (mat4x2(-5.0, 2.0, 6.0, 0.0, -9.0, -6.0, -3.0, -4.0));
	i[5][3].mC = (mat4x3(-8.0, -7.0, -7.0, 0.0, 4.0, -8.0, 7.0, 2.0, -2.0, 0.0, 0.0, -3.0));
	i[5][3].mD = (mat2x3(2.0, 9.0, 9.0, 1.0, -8.0, -8.0));
	i[5][4].mA = (true);
	i[5][4].mB = (mat4x2(7.0, -4.0, -2.0, -8.0, -4.0, 7.0, 5.0, 8.0));
	i[5][4].mC = (mat4x3(-9.0, -3.0, -5.0, 7.0, -3.0, 1.0, 5.0, 1.0, -8.0, 9.0, 3.0, 4.0));
	i[5][4].mD = (mat2x3(5.0, 4.0, 4.0, 4.0, -4.0, 6.0));
	i[5][5].mA = (false);
	i[5][5].mB = (mat4x2(2.0, -2.0, 1.0, -8.0, -2.0, 7.0, -6.0, 8.0));
	i[5][5].mC = (mat4x3(6.0, 9.0, 6.0, 9.0, -8.0, 7.0, 5.0, -5.0, 4.0, -5.0, 7.0, -6.0));
	i[5][5].mD = (mat2x3(-7.0, 1.0, -2.0, 5.0, -5.0, -9.0));
	i[5][6].mA = (true);
	i[5][6].mB = (mat4x2(-4.0, -6.0, 4.0, -2.0, 5.0, 0.0, -5.0, -6.0));
	i[5][6].mC = (mat4x3(0.0, -8.0, -4.0, 3.0, -5.0, 1.0, 3.0, 6.0, 8.0, -9.0, -2.0, -7.0));
	i[5][6].mD = (mat2x3(-8.0, 4.0, -5.0, -9.0, -3.0, 4.0));
	i[6][0].mA = (true);
	i[6][0].mB = (mat4x2(2.0, 1.0, -2.0, 8.0, 1.0, -7.0, 3.0, -8.0));
	i[6][0].mC = (mat4x3(9.0, -4.0, 2.0, -1.0, -1.0, -7.0, 4.0, -6.0, 1.0, -5.0, 2.0, -1.0));
	i[6][0].mD = (mat2x3(-6.0, 7.0, 3.0, -6.0, -5.0, 8.0));
	i[6][1].mA = (false);
	i[6][1].mB = (mat4x2(-9.0, 1.0, 4.0, 1.0, -1.0, -9.0, -7.0, -5.0));
	i[6][1].mC = (mat4x3(2.0, -6.0, 0.0, 4.0, -1.0, 0.0, -1.0, -9.0, -5.0, -6.0, 0.0, 1.0));
	i[6][1].mD = (mat2x3(6.0, -8.0, -9.0, -9.0, 3.0, -3.0));
	i[6][2].mA = (true);
	i[6][2].mB = (mat4x2(-2.0, -7.0, -9.0, -7.0, -2.0, -7.0, -8.0, 7.0));
	i[6][2].mC = (mat4x3(6.0, -8.0, 0.0, 0.0, -3.0, -7.0, 2.0, 9.0, -3.0, 4.0, -2.0, -2.0));
	i[6][2].mD = (mat2x3(-8.0, -5.0, 2.0, -5.0, 6.0, 9.0));
	i[6][3].mA = (true);
	i[6][3].mB = (mat4x2(-8.0, -1.0, 1.0, 9.0, -6.0, -3.0, -8.0, -5.0));
	i[6][3].mC = (mat4x3(6.0, -1.0, 3.0, -9.0, 0.0, 7.0, 4.0, -2.0, 6.0, 8.0, 0.0, -3.0));
	i[6][3].mD = (mat2x3(-1.0, 2.0, -7.0, -1.0, 5.0, -7.0));
	i[6][4].mA = (false);
	i[6][4].mB = (mat4x2(8.0, -7.0, 7.0, -2.0, 8.0, -9.0, 8.0, -3.0));
	i[6][4].mC = (mat4x3(-5.0, 2.0, -3.0, 5.0, 6.0, 8.0, 1.0, 8.0, 3.0, 9.0, -5.0, 4.0));
	i[6][4].mD = (mat2x3(7.0, -5.0, -2.0, -5.0, 2.0, -6.0));
	i[6][5].mA = (false);
	i[6][5].mB = (mat4x2(-7.0, -3.0, 5.0, 2.0, -4.0, 4.0, 6.0, 4.0));
	i[6][5].mC = (mat4x3(-3.0, 6.0, -8.0, 3.0, -7.0, 8.0, -9.0, -4.0, 5.0, -2.0, 3.0, -9.0));
	i[6][5].mD = (mat2x3(-6.0, 1.0, 8.0, -2.0, 3.0, 3.0));
	i[6][6].mA = (true);
	i[6][6].mB = (mat4x2(-6.0, 1.0, 9.0, -7.0, 6.0, -8.0, -4.0, -1.0));
	i[6][6].mC = (mat4x3(3.0, -7.0, -7.0, -2.0, 0.0, 8.0, 5.0, -9.0, -4.0, -1.0, 7.0, -2.0));
	i[6][6].mD = (mat2x3(9.0, 6.0, 3.0, -5.0, 5.0, 2.0));
	i[7][0].mA = (false);
	i[7][0].mB = (mat4x2(4.0, -9.0, -7.0, -6.0, 3.0, -6.0, 2.0, -9.0));
	i[7][0].mC = (mat4x3(-4.0, -7.0, -7.0, 0.0, 3.0, -6.0, 0.0, 2.0, 6.0, 3.0, -2.0, 6.0));
	i[7][0].mD = (mat2x3(-9.0, -9.0, -4.0, -6.0, 4.0, 3.0));
	i[7][1].mA = (true);
	i[7][1].mB = (mat4x2(8.0, 1.0, -2.0, 3.0, 6.0, -2.0, 5.0, 2.0));
	i[7][1].mC = (mat4x3(-6.0, -8.0, 9.0, 2.0, -2.0, -8.0, -1.0, 6.0, 7.0, -5.0, -4.0, 1.0));
	i[7][1].mD = (mat2x3(-7.0, 1.0, 0.0, 7.0, 3.0, -6.0));
	i[7][2].mA = (true);
	i[7][2].mB = (mat4x2(-1.0, -4.0, -6.0, -9.0, 0.0, -9.0, -6.0, -8.0));
	i[7][2].mC = (mat4x3(5.0, 1.0, 6.0, 0.0, 5.0, -2.0, -5.0, -1.0, -7.0, 2.0, 3.0, -9.0));
	i[7][2].mD = (mat2x3(6.0, 5.0, -6.0, 4.0, -5.0, 2.0));
	i[7][3].mA = (false);
	i[7][3].mB = (mat4x2(6.0, 7.0, 5.0, 5.0, -4.0, -4.0, -1.0, -9.0));
	i[7][3].mC = (mat4x3(-1.0, 8.0, 7.0, -5.0, -3.0, 0.0, 0.0, -3.0, -1.0, -4.0, -4.0, 3.0));
	i[7][3].mD = (mat2x3(7.0, 5.0, 5.0, -5.0, 2.0, 4.0));
	i[7][4].mA = (false);
	i[7][4].mB = (mat4x2(-9.0, -5.0, 3.0, 1.0, 9.0, -9.0, -6.0, 5.0));
	i[7][4].mC = (mat4x3(4.0, 9.0, 4.0, 4.0, 6.0, 4.0, 9.0, 3.0, -3.0, 7.0, -1.0, 0.0));
	i[7][4].mD = (mat2x3(6.0, -7.0, 4.0, 9.0, 4.0, 2.0));
	i[7][5].mA = (false);
	i[7][5].mB = (mat4x2(-3.0, 8.0, 6.0, -6.0, 9.0, -5.0, 8.0, 7.0));
	i[7][5].mC = (mat4x3(-4.0, -1.0, -7.0, 5.0, 8.0, -8.0, -6.0, 1.0, -3.0, 3.0, -1.0, -4.0));
	i[7][5].mD = (mat2x3(-8.0, 9.0, -1.0, 6.0, -6.0, -2.0));
	i[7][6].mA = (true);
	i[7][6].mB = (mat4x2(7.0, -7.0, -8.0, -2.0, -8.0, 0.0, -7.0, -9.0));
	i[7][6].mC = (mat4x3(-6.0, 6.0, 0.0, 7.0, -2.0, -5.0, 9.0, 5.0, -7.0, -3.0, -7.0, -9.0));
	i[7][6].mD = (mat2x3(-6.0, 2.0, 7.0, 0.0, 5.0, 2.0));
}
#version 450
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
	mediump vec2 a[1];
	lowp ivec3 b;
	bvec4 c[1];
	mediump ivec2 d;
	mediump uvec3 e;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB[nonuniformEXT(0)].a[0]), vec2(-7.0, 8.0)) && allOk;
	allOk = compare_ivec3((blockB[nonuniformEXT(0)].b), ivec3(8, 2, 4)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(0)].c[0]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(0)].d), ivec2(-2, -9)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(0)].e), uvec3(6u, 6u, 7u)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(1)].a[0]), vec2(0.0, -9.0)) && allOk;
	allOk = compare_ivec3((blockB[nonuniformEXT(1)].b), ivec3(7, 0, -2)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(1)].c[0]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(1)].d), ivec2(8, 9)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(1)].e), uvec3(2u, 7u, 9u)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(2)].a[0]), vec2(3.0, 8.0)) && allOk;
	allOk = compare_ivec3((blockB[nonuniformEXT(2)].b), ivec3(7, 9, -3)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(2)].c[0]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(2)].d), ivec2(5, 0)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(2)].e), uvec3(2u, 7u, 0u)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(3)].a[0]), vec2(3.0, 8.0)) && allOk;
	allOk = compare_ivec3((blockB[nonuniformEXT(3)].b), ivec3(-4, 8, 0)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(3)].c[0]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(3)].d), ivec2(-9, -1)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(3)].e), uvec3(3u, 1u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a[0] = (vec2(0.0, -7.0));
	blockB[nonuniformEXT(0)].b = (ivec3(3, -2, 2));
	blockB[nonuniformEXT(0)].c[0] = (bvec4(false, true, false, true));
	blockB[nonuniformEXT(0)].d = (ivec2(3, -3));
	blockB[nonuniformEXT(1)].a[0] = (vec2(5.0, -6.0));
	blockB[nonuniformEXT(1)].b = (ivec3(-1, -2, 2));
	blockB[nonuniformEXT(1)].c[0] = (bvec4(true, true, false, false));
	blockB[nonuniformEXT(1)].d = (ivec2(-2, -2));
	blockB[nonuniformEXT(2)].a[0] = (vec2(-8.0, 1.0));
	blockB[nonuniformEXT(2)].b = (ivec3(-3, -1, 3));
	blockB[nonuniformEXT(2)].c[0] = (bvec4(true, true, true, true));
	blockB[nonuniformEXT(2)].d = (ivec2(9, -8));
	blockB[nonuniformEXT(3)].a[0] = (vec2(0.0, 4.0));
	blockB[nonuniformEXT(3)].b = (ivec3(6, 1, -4));
	blockB[nonuniformEXT(3)].c[0] = (bvec4(false, false, false, false));
	blockB[nonuniformEXT(3)].d = (ivec2(5, 2));
}
#version 450
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
	lowp int a;
	lowp vec2 b;
	highp uint c;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB[nonuniformEXT(0)].a), 3) && allOk;
	allOk = compare_uint((blockB[nonuniformEXT(0)].c), 8u) && allOk;
	allOk = compare_int((blockB[nonuniformEXT(1)].a), 6) && allOk;
	allOk = compare_uint((blockB[nonuniformEXT(1)].c), 5u) && allOk;
	allOk = compare_int((blockB[nonuniformEXT(2)].a), 8) && allOk;
	allOk = compare_uint((blockB[nonuniformEXT(2)].c), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	highp vec2 a;
	bvec3 b[];
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	bool c;
	lowp mat2 d;
	sA e;
	i16vec3 f[];
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	lowp mat4x3 g;
	f16vec2 h;
	i16vec2 i;
} blockD[1];
layout(std430, binding = 4) buffer BlockE
{
	bvec3 j;
	bvec4 k;
	int16_t l;
	highp float m;
	bool n[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((b[0]), bvec3(false, false, false)) && allOk;
	allOk = compare_mat2(blockC.d, mat2(-4.0, 0.0, -2.0, -5.0)) && allOk;
	allOk = compare_vec2((blockC.e.mA), vec2(1.0, 5.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockC.f[0]), ivec3(1, -6, 9)) && allOk;
	allOk = compare_mat4x3(blockD[0].g, mat4x3(8.0, 3.0, 7.0, 5.0, -6.0, 5.0, -9.0, -2.0, 4.0, -1.0, -1.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockD[0].h), vec2(2.0, -6.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD[0].i), ivec2(8, -7)) && allOk;
	allOk = compare_float((m), 2.0) && allOk;
	allOk = compare_bool((n[0]), true) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec2(-2.0, -9.0));
	blockC.c = (true);
	blockC.d = (mat2(-9.0, 4.0, -6.0, 2.0));
	blockC.e.mA = (vec2(6.0, 4.0));
	blockC.f[0] = i16vec3(ivec3(6, -5, 2));
	blockD[0].g = (mat4x3(-9.0, -8.0, 3.0, 6.0, -6.0, 5.0, 6.0, -6.0, 3.0, 7.0, -8.0, -2.0));
	blockD[0].h = f16vec2(vec2(-6.0, -3.0));
	blockD[0].i = i16vec2(ivec2(0, 7));
	l = int16_t(-2);
	m = (2.0);
	n[0] = (true);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, binding = 1) readonly buffer BlockB
{
	highp uvec4 a[];
};
layout(std430, column_major, binding = 2) buffer BlockC
{
	mediump mat4 b[];
} blockC[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockC[0].b[0], mat4(-1.0, 6.0, 0.0, -9.0, 1.0, 8.0, 1.0, -2.0, -8.0, -6.0, -1.0, -8.0, -7.0, 7.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat4(blockC[0].b[1], mat4(-6.0, 5.0, -2.0, -8.0, -1.0, -6.0, 5.0, 3.0, 3.0, -9.0, 4.0, 8.0, 5.0, -4.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4(blockC[0].b[2], mat4(4.0, -2.0, -5.0, -9.0, -7.0, 6.0, -3.0, 6.0, 4.0, 1.0, -3.0, 4.0, 0.0, -4.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat4(blockC[1].b[0], mat4(-1.0, 6.0, 8.0, -2.0, 6.0, 1.0, -2.0, -3.0, -5.0, -7.0, 4.0, -2.0, 5.0, 9.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat4(blockC[1].b[1], mat4(-6.0, 3.0, 8.0, 5.0, 4.0, 7.0, -2.0, -1.0, -2.0, -6.0, 3.0, 8.0, 6.0, -9.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat4(blockC[1].b[2], mat4(1.0, -6.0, -5.0, 0.0, 1.0, 1.0, -5.0, 8.0, 1.0, -6.0, -7.0, 8.0, -6.0, -3.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat4(blockC[1].b[3], mat4(-9.0, 9.0, 7.0, 2.0, -3.0, -8.0, 0.0, 5.0, 1.0, -1.0, 9.0, -4.0, -8.0, -8.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat4(blockC[1].b[4], mat4(3.0, 3.0, 1.0, -6.0, -8.0, 5.0, -3.0, -6.0, 8.0, -5.0, 1.0, 8.0, -1.0, -2.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat4(blockC[1].b[5], mat4(7.0, 6.0, 1.0, 2.0, 2.0, 9.0, 5.0, -7.0, -9.0, -8.0, 6.0, -3.0, 3.0, -5.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat4(blockC[1].b[6], mat4(-5.0, 0.0, 5.0, 3.0, -5.0, -8.0, -3.0, 0.0, 3.0, -8.0, -8.0, -7.0, 8.0, 4.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat4(blockC[2].b[0], mat4(-6.0, 7.0, 9.0, -5.0, -4.0, 7.0, 5.0, -5.0, 3.0, -7.0, -5.0, -9.0, -1.0, 3.0, -5.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC[0].b[0] = (mat4(3.0, 0.0, -9.0, -6.0, 3.0, 4.0, -1.0, -4.0, -7.0, -8.0, -3.0, 6.0, 5.0, -2.0, -1.0, -4.0));
	blockC[0].b[1] = (mat4(-8.0, 2.0, 0.0, 3.0, 9.0, -8.0, -9.0, -2.0, 0.0, 2.0, 6.0, -7.0, 3.0, 9.0, 8.0, 1.0));
	blockC[0].b[2] = (mat4(7.0, -9.0, 2.0, 7.0, 0.0, -8.0, -4.0, -2.0, -6.0, -2.0, 0.0, -4.0, -4.0, -9.0, 1.0, 5.0));
	blockC[1].b[0] = (mat4(-8.0, -8.0, 9.0, -4.0, 9.0, -7.0, 5.0, 9.0, 3.0, 6.0, -8.0, 2.0, -3.0, 9.0, -5.0, -1.0));
	blockC[1].b[1] = (mat4(0.0, -3.0, 7.0, 4.0, 1.0, 5.0, 4.0, -6.0, -7.0, -2.0, 4.0, -8.0, -4.0, -5.0, 9.0, -4.0));
	blockC[1].b[2] = (mat4(5.0, 1.0, -5.0, 9.0, 0.0, -8.0, -7.0, -6.0, -8.0, 2.0, 0.0, -3.0, 4.0, -3.0, -5.0, -9.0));
	blockC[1].b[3] = (mat4(4.0, 2.0, -4.0, -2.0, -3.0, -2.0, -5.0, 2.0, -5.0, -9.0, -8.0, -1.0, 1.0, 8.0, -6.0, -3.0));
	blockC[1].b[4] = (mat4(-4.0, 3.0, -6.0, -9.0, -3.0, -7.0, 5.0, 7.0, -3.0, -9.0, -4.0, 6.0, 3.0, -9.0, 0.0, 0.0));
	blockC[1].b[5] = (mat4(-4.0, 8.0, 2.0, 9.0, 2.0, -2.0, -5.0, -2.0, -5.0, 8.0, 6.0, 2.0, 4.0, 9.0, -6.0, -7.0));
	blockC[1].b[6] = (mat4(0.0, 7.0, 4.0, 8.0, 9.0, 4.0, 9.0, 3.0, 3.0, 5.0, 3.0, 5.0, 0.0, 1.0, 7.0, -3.0));
	blockC[2].b[0] = (mat4(-3.0, -3.0, 1.0, -8.0, -1.0, -4.0, 8.0, -9.0, -7.0, 5.0, -4.0, -4.0, -3.0, -6.0, 0.0, -6.0));
}
#version 450
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
	layout(offset = 0) u16vec2 a;
	layout(offset = 4) uint16_t b;
	layout(offset = 8) bvec2 c;
	layout(offset = 16) mediump ivec4 d;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) float16_t e;
	layout(offset = 2) u16vec4 f;
	layout(offset = 12) mediump uint g[1];
	layout(offset = 16) f16vec4 h;
	layout(offset = 24) bool i;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((c), bvec2(true, false)) && allOk;
	allOk = compare_ivec4((d), ivec4(9, -4, -6, -1)) && allOk;
	allOk = compare_float16_t(float(blockC.e), -1.0) && allOk;
	allOk = compare_u16vec4(uvec4(blockC.f), uvec4(4u, 1u, 3u, 8u)) && allOk;
	allOk = compare_uint((blockC.g[0]), 2u) && allOk;
	allOk = compare_f16vec4(vec4(blockC.h), vec4(-2.0, -4.0, -9.0, 8.0)) && allOk;
	allOk = compare_bool((blockC.i), false) && allOk;
    if (allOk)
        ac_numPassed++;

	a = u16vec2(uvec2(4u, 1u));
	b = uint16_t(0u);
	c = (bvec2(false, true));
	d = (ivec4(-6, 3, -7, 8));
	blockC.e = float16_t(5.0);
	blockC.g[0] = (8u);
	blockC.h = f16vec4(vec4(-1.0, 4.0, -4.0, -6.0));
}
#version 450
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
	layout(offset = 0) u16vec2 a;
	layout(offset = 4) highp vec2 b;
	layout(offset = 12) float16_t c[1];
	layout(offset = 16) i16vec4 d;
} blockB[3];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) bvec3 e;
	layout(offset = 16) bvec4 f;
	layout(offset = 32) lowp uint g;
	layout(offset = 48) bvec4 h;
	layout(offset = 64) i16vec4 i;
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
	allOk = compare_bvec4((f), bvec4(false, false, true, false)) && allOk;
	allOk = compare_uint((g), 2u) && allOk;
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
	e = (bvec3(true, true, true));
	f = (bvec4(true, false, false, true));
	g = (1u);
	h = (bvec4(false, true, true, true));
	i = i16vec4(ivec4(8, -8, -8, -1));
}
#version 450
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
struct sB
{
	highp mat4x2 mA;
	float16_t mB;
	lowp mat2x3 mC;
	bvec3 mD;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	i16vec4 a;
	lowp uvec2 b[];
} blockB;
layout(scalar, binding = 2) buffer BlockC
{
	sA c;
	i16vec3 d;
	highp uvec4 e[];
};
layout(scalar, binding = 3) readonly buffer BlockD
{
	float16_t f[];
};
layout(scalar, binding = 4) buffer BlockE
{
	lowp ivec4 g;
	mediump mat4x2 h;
	sB i[8];
	mediump ivec4 j;
	mediump ivec2 k[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(blockB.a), ivec4(-7, 3, 4, -6)) && allOk;
	allOk = compare_uvec2((blockB.b[0]), uvec2(5u, 0u)) && allOk;
	allOk = compare_uvec2((blockB.b[1]), uvec2(1u, 3u)) && allOk;
	allOk = compare_uvec2((blockB.b[2]), uvec2(9u, 3u)) && allOk;
	allOk = compare_uvec2((blockB.b[3]), uvec2(5u, 0u)) && allOk;
	allOk = compare_ivec3((c.mA), ivec3(2, 9, 6)) && allOk;
	allOk = compare_i16vec3(ivec3(d), ivec3(9, 1, 4)) && allOk;
	allOk = compare_uvec4((e[0]), uvec4(8u, 7u, 5u, 1u)) && allOk;
	allOk = compare_uvec4((e[1]), uvec4(7u, 6u, 5u, 2u)) && allOk;
	allOk = compare_uvec4((e[2]), uvec4(3u, 7u, 5u, 4u)) && allOk;
	allOk = compare_uvec4((e[3]), uvec4(2u, 9u, 3u, 2u)) && allOk;
	allOk = compare_ivec4((g), ivec4(-2, -5, 6, 3)) && allOk;
	allOk = compare_mat4x2(i[0].mA, mat4x2(-6.0, 3.0, -9.0, 8.0, 8.0, -7.0, 8.0, 9.0)) && allOk;
	allOk = compare_float16_t(float(i[0].mB), -1.0) && allOk;
	allOk = compare_mat2x3(i[0].mC, mat2x3(4.0, 2.0, -9.0, 9.0, 3.0, -7.0)) && allOk;
	allOk = compare_bvec3((i[0].mD), bvec3(true, false, false)) && allOk;
	allOk = compare_mat4x2(i[1].mA, mat4x2(9.0, -5.0, 5.0, 3.0, 5.0, -6.0, -9.0, -3.0)) && allOk;
	allOk = compare_float16_t(float(i[1].mB), 2.0) && allOk;
	allOk = compare_mat2x3(i[1].mC, mat2x3(-1.0, -1.0, 8.0, -3.0, 5.0, 7.0)) && allOk;
	allOk = compare_bvec3((i[1].mD), bvec3(false, false, false)) && allOk;
	allOk = compare_mat4x2(i[2].mA, mat4x2(1.0, -2.0, 9.0, -8.0, 2.0, -1.0, 5.0, -7.0)) && allOk;
	allOk = compare_float16_t(float(i[2].mB), 7.0) && allOk;
	allOk = compare_mat2x3(i[2].mC, mat2x3(-9.0, -4.0, -4.0, -7.0, 3.0, 8.0)) && allOk;
	allOk = compare_bvec3((i[2].mD), bvec3(false, true, false)) && allOk;
	allOk = compare_mat4x2(i[3].mA, mat4x2(5.0, -2.0, 3.0, -5.0, -3.0, -4.0, -3.0, -8.0)) && allOk;
	allOk = compare_float16_t(float(i[3].mB), -7.0) && allOk;
	allOk = compare_mat2x3(i[3].mC, mat2x3(-1.0, -3.0, -7.0, 2.0, -2.0, -5.0)) && allOk;
	allOk = compare_bvec3((i[3].mD), bvec3(true, true, false)) && allOk;
	allOk = compare_mat4x2(i[4].mA, mat4x2(9.0, 8.0, -9.0, 9.0, 3.0, 3.0, -2.0, -1.0)) && allOk;
	allOk = compare_float16_t(float(i[4].mB), 3.0) && allOk;
	allOk = compare_mat2x3(i[4].mC, mat2x3(-8.0, -1.0, -3.0, -2.0, -5.0, 4.0)) && allOk;
	allOk = compare_bvec3((i[4].mD), bvec3(false, false, false)) && allOk;
	allOk = compare_mat4x2(i[5].mA, mat4x2(6.0, -1.0, 5.0, -9.0, -8.0, 2.0, 6.0, 3.0)) && allOk;
	allOk = compare_float16_t(float(i[5].mB), 7.0) && allOk;
	allOk = compare_mat2x3(i[5].mC, mat2x3(8.0, -7.0, -6.0, 7.0, 6.0, -8.0)) && allOk;
	allOk = compare_bvec3((i[5].mD), bvec3(true, true, false)) && allOk;
	allOk = compare_mat4x2(i[6].mA, mat4x2(-8.0, -9.0, 3.0, 4.0, 0.0, -4.0, 9.0, 7.0)) && allOk;
	allOk = compare_float16_t(float(i[6].mB), 0.0) && allOk;
	allOk = compare_mat2x3(i[6].mC, mat2x3(-8.0, -5.0, -7.0, 1.0, 6.0, -2.0)) && allOk;
	allOk = compare_bvec3((i[6].mD), bvec3(true, true, false)) && allOk;
	allOk = compare_mat4x2(i[7].mA, mat4x2(-1.0, 0.0, 4.0, -7.0, 3.0, 9.0, -8.0, -3.0)) && allOk;
	allOk = compare_float16_t(float(i[7].mB), 7.0) && allOk;
	allOk = compare_mat2x3(i[7].mC, mat2x3(8.0, 7.0, 6.0, -2.0, 1.0, -9.0)) && allOk;
	allOk = compare_bvec3((i[7].mD), bvec3(true, true, false)) && allOk;
	allOk = compare_ivec4((j), ivec4(9, 0, 1, -6)) && allOk;
	allOk = compare_ivec2((k[0]), ivec2(8, -6)) && allOk;
	allOk = compare_ivec2((k[1]), ivec2(2, 2)) && allOk;
	allOk = compare_ivec2((k[2]), ivec2(-4, -4)) && allOk;
	allOk = compare_ivec2((k[3]), ivec2(-6, 9)) && allOk;
	allOk = compare_ivec2((k[4]), ivec2(-4, -5)) && allOk;
	allOk = compare_ivec2((k[5]), ivec2(9, -7)) && allOk;
	allOk = compare_ivec2((k[6]), ivec2(2, 6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i16vec4(ivec4(0, -2, -1, 6));
	c.mA = (ivec3(-8, -1, -5));
	d = i16vec3(ivec3(0, -6, 0));
	e[0] = (uvec4(0u, 1u, 5u, 4u));
	e[1] = (uvec4(3u, 4u, 0u, 9u));
	e[2] = (uvec4(1u, 8u, 5u, 2u));
	e[3] = (uvec4(6u, 5u, 5u, 0u));
	g = (ivec4(-7, -7, -9, -8));
	h = (mat4x2(8.0, 6.0, -7.0, -6.0, -4.0, 5.0, -9.0, 8.0));
	i[0].mA = (mat4x2(-9.0, 2.0, -2.0, 5.0, 9.0, 3.0, 0.0, 6.0));
	i[0].mB = float16_t(8.0);
	i[0].mC = (mat2x3(1.0, -3.0, 5.0, 6.0, -3.0, -3.0));
	i[0].mD = (bvec3(true, true, true));
	i[1].mA = (mat4x2(-2.0, -4.0, 5.0, 1.0, -9.0, 2.0, 3.0, -9.0));
	i[1].mB = float16_t(-3.0);
	i[1].mC = (mat2x3(-1.0, -4.0, -1.0, 1.0, 3.0, 8.0));
	i[1].mD = (bvec3(true, true, false));
	i[2].mA = (mat4x2(6.0, -2.0, 9.0, -9.0, 1.0, 9.0, -4.0, 5.0));
	i[2].mB = float16_t(-1.0);
	i[2].mC = (mat2x3(4.0, -7.0, 4.0, 1.0, -8.0, -4.0));
	i[2].mD = (bvec3(true, false, true));
	i[3].mA = (mat4x2(-8.0, 9.0, -8.0, -5.0, 6.0, -5.0, 4.0, 8.0));
	i[3].mB = float16_t(5.0);
	i[3].mC = (mat2x3(-8.0, 3.0, -4.0, -7.0, 7.0, 3.0));
	i[3].mD = (bvec3(false, true, true));
	i[4].mA = (mat4x2(-1.0, -1.0, -3.0, -8.0, -3.0, -9.0, 1.0, 6.0));
	i[4].mB = float16_t(2.0);
	i[4].mC = (mat2x3(7.0, -9.0, 5.0, -5.0, 1.0, -5.0));
	i[4].mD = (bvec3(false, false, false));
	i[5].mA = (mat4x2(3.0, -3.0, -3.0, -7.0, -3.0, -1.0, 9.0, 0.0));
	i[5].mB = float16_t(-3.0);
	i[5].mC = (mat2x3(3.0, -5.0, -5.0, -3.0, -2.0, -8.0));
	i[5].mD = (bvec3(false, true, false));
	i[6].mA = (mat4x2(-1.0, 3.0, -9.0, 3.0, 2.0, -4.0, -2.0, 1.0));
	i[6].mB = float16_t(1.0);
	i[6].mC = (mat2x3(5.0, -2.0, -8.0, -5.0, -9.0, -6.0));
	i[6].mD = (bvec3(false, true, false));
	i[7].mA = (mat4x2(9.0, 7.0, 1.0, 9.0, 1.0, -4.0, -7.0, 0.0));
	i[7].mB = float16_t(8.0);
	i[7].mC = (mat2x3(1.0, 9.0, -4.0, -6.0, -8.0, -7.0));
	i[7].mD = (bvec3(false, true, false));
	j = (ivec4(5, 4, -5, -2));
	k[0] = (ivec2(1, 3));
	k[1] = (ivec2(-3, -7));
	k[2] = (ivec2(-5, 5));
	k[3] = (ivec2(3, 9));
	k[4] = (ivec2(8, -9));
	k[5] = (ivec2(6, 2));
	k[6] = (ivec2(-5, 8));
}
#version 450
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
	highp uvec4 a;
	mediump mat3x4 b;
} blockB[];

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

layout(std140, column_major, binding = 1) buffer BlockB
{
	mediump vec2 a;
	highp uvec3 b;
	lowp mat2 c;
	int8_t d;
	lowp mat3x2 e;
} blockB;
layout(std140, row_major, binding = 2) buffer BlockC
{
	i8vec4 f;
	mediump mat2x3 g;
	int8_t h;
	u8vec3 i;
	highp uvec3 j[];
} blockC[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(-9.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockB.e, mat3x2(1.0, -6.0, -8.0, -5.0, 9.0, 7.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC[0].f), ivec4(4294967288, 1, 5, 4294967291)) && allOk;
	allOk = compare_mat2x3(blockC[0].g, mat2x3(-8.0, 7.0, 8.0, -7.0, -5.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec2(-9.0, -3.0));
	blockB.c = (mat2(9.0, -5.0, 2.0, 1.0));
	blockB.e = (mat3x2(6.0, 2.0, 9.0, 8.0, 5.0, -5.0));
	blockC[0].f = i8vec4(ivec4(8, 4294967295, 7, 4294967287));
	blockC[0].g = (mat2x3(-3.0, 6.0, -4.0, -1.0, -2.0, 9.0));
	blockC[0].h = int8_t(4294967292);
	blockC[0].j[0] = (uvec3(0u, 5u, 5u));
}
#version 450
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
	lowp mat3x4 a;
	mediump mat3x2 b;
	lowp float c[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(a, mat3x4(7.0, 3.0, 2.0, -8.0, -4.0, 7.0, -1.0, 0.0, 4.0, -3.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3x2(b, mat3x2(6.0, -6.0, -6.0, 0.0, -3.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (mat3x2(-8.0, 2.0, -8.0, -8.0, -4.0, -2.0));
	c[0] = (1.0);
	c[1] = (7.0);
	c[2] = (6.0);
	c[3] = (-3.0);
	c[4] = (-9.0);
}
#version 450
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
	layout(offset = 0) lowp vec3 a[1];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.a[0]), vec3(4.0, -1.0, 1.0)) && allOk;
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

layout(binding = 1) buffer BlockB
{
	layout(offset = 0) i8vec2 a;
	layout(offset = 16) lowp vec3 b[1];
	layout(offset = 32) highp uvec2 c;
	layout(offset = 40) i8vec3 d;
	layout(offset = 48) mediump vec4 e;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) i8vec2 f;
	layout(offset = 2) i8vec2 g;
} blockC[1];
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) u8vec2 h;
	layout(offset = 2) i8vec3 i;
	layout(offset = 16) mediump uvec4 j;
	layout(offset = 32) mediump ivec2 k;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(a), ivec2(4, 2)) && allOk;
	allOk = compare_uvec2((c), uvec2(0u, 1u)) && allOk;
	allOk = compare_vec4((e), vec4(3.0, 1.0, -6.0, -6.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC[0].f), ivec2(4, 2)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC[0].g), ivec2(4294967295, 3)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD.h), uvec2(8u, 7u)) && allOk;
	allOk = compare_i8vec3(ivec3(blockD.i), ivec3(1, 9, 2)) && allOk;
	allOk = compare_uvec4((blockD.j), uvec4(8u, 7u, 6u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	b[0] = (vec3(-1.0, -5.0, -1.0));
	c = (uvec2(5u, 2u));
	d = i8vec3(ivec3(9, 6, 7));
	e = (vec4(4.0, 3.0, 9.0, 4.0));
	blockC[0].g = i8vec2(ivec2(4294967288, 4294967293));
	blockD.i = i8vec3(ivec3(7, 4294967290, 4294967293));
	blockD.j = (uvec4(6u, 5u, 4u, 4u));
	blockD.k = (ivec2(-4, -3));
}
#version 450
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
	highp ivec4 mA[6];
};
struct sB
{
	lowp ivec2 mA[6];
};
layout(scalar, binding = 1) readonly buffer BlockB
{
	bvec3 a;
	mediump mat4x3 b[];
};
layout(scalar, binding = 2) buffer BlockC
{
	bvec4 c;
	highp int d;
	sA e;
	sB f[];
} blockC;
layout(scalar, row_major, binding = 3) buffer BlockD
{
	highp int g;
	highp ivec4 h[];
} blockD[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((a), bvec3(true, false, false)) && allOk;
	allOk = compare_mat4x3(b[0], mat4x3(5.0, 5.0, 5.0, -5.0, -2.0, -9.0, 1.0, -6.0, -8.0, -5.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat4x3(b[1], mat4x3(-8.0, 1.0, 5.0, -5.0, -8.0, -7.0, 7.0, -5.0, 8.0, -5.0, 7.0, -8.0)) && allOk;
	allOk = compare_bvec4((blockC.c), bvec4(true, true, true, false)) && allOk;
	allOk = compare_ivec4((blockC.e.mA[0]), ivec4(-4, -1, 6, -7)) && allOk;
	allOk = compare_ivec4((blockC.e.mA[1]), ivec4(-9, 8, 0, -4)) && allOk;
	allOk = compare_ivec4((blockC.e.mA[2]), ivec4(-6, -1, 5, 1)) && allOk;
	allOk = compare_ivec4((blockC.e.mA[3]), ivec4(-5, -8, -6, 6)) && allOk;
	allOk = compare_ivec4((blockC.e.mA[4]), ivec4(9, 9, -6, -6)) && allOk;
	allOk = compare_ivec4((blockC.e.mA[5]), ivec4(-3, 6, -3, -3)) && allOk;
	allOk = compare_ivec2((blockC.f[0].mA[0]), ivec2(-1, -1)) && allOk;
	allOk = compare_ivec2((blockC.f[0].mA[1]), ivec2(9, 6)) && allOk;
	allOk = compare_ivec2((blockC.f[0].mA[2]), ivec2(3, 8)) && allOk;
	allOk = compare_ivec2((blockC.f[0].mA[3]), ivec2(-7, 0)) && allOk;
	allOk = compare_ivec2((blockC.f[0].mA[4]), ivec2(1, 7)) && allOk;
	allOk = compare_ivec2((blockC.f[0].mA[5]), ivec2(-2, -9)) && allOk;
	allOk = compare_ivec2((blockC.f[1].mA[0]), ivec2(-5, -6)) && allOk;
	allOk = compare_ivec2((blockC.f[1].mA[1]), ivec2(4, -9)) && allOk;
	allOk = compare_ivec2((blockC.f[1].mA[2]), ivec2(-7, 8)) && allOk;
	allOk = compare_ivec2((blockC.f[1].mA[3]), ivec2(-7, -6)) && allOk;
	allOk = compare_ivec2((blockC.f[1].mA[4]), ivec2(-9, 2)) && allOk;
	allOk = compare_ivec2((blockC.f[1].mA[5]), ivec2(7, 3)) && allOk;
	allOk = compare_ivec2((blockC.f[2].mA[0]), ivec2(-4, -9)) && allOk;
	allOk = compare_ivec2((blockC.f[2].mA[1]), ivec2(-3, 0)) && allOk;
	allOk = compare_ivec2((blockC.f[2].mA[2]), ivec2(4, 9)) && allOk;
	allOk = compare_ivec2((blockC.f[2].mA[3]), ivec2(5, 7)) && allOk;
	allOk = compare_ivec2((blockC.f[2].mA[4]), ivec2(-3, -7)) && allOk;
	allOk = compare_ivec2((blockC.f[2].mA[5]), ivec2(0, -5)) && allOk;
	allOk = compare_ivec2((blockC.f[3].mA[0]), ivec2(-1, 7)) && allOk;
	allOk = compare_ivec2((blockC.f[3].mA[1]), ivec2(2, 7)) && allOk;
	allOk = compare_ivec2((blockC.f[3].mA[2]), ivec2(7, -3)) && allOk;
	allOk = compare_ivec2((blockC.f[3].mA[3]), ivec2(-7, -7)) && allOk;
	allOk = compare_ivec2((blockC.f[3].mA[4]), ivec2(1, -2)) && allOk;
	allOk = compare_ivec2((blockC.f[3].mA[5]), ivec2(2, 2)) && allOk;
	allOk = compare_ivec2((blockC.f[4].mA[0]), ivec2(-8, -3)) && allOk;
	allOk = compare_ivec2((blockC.f[4].mA[1]), ivec2(-1, 6)) && allOk;
	allOk = compare_ivec2((blockC.f[4].mA[2]), ivec2(7, 4)) && allOk;
	allOk = compare_ivec2((blockC.f[4].mA[3]), ivec2(3, 4)) && allOk;
	allOk = compare_ivec2((blockC.f[4].mA[4]), ivec2(-1, -7)) && allOk;
	allOk = compare_ivec2((blockC.f[4].mA[5]), ivec2(-8, 1)) && allOk;
	allOk = compare_ivec2((blockC.f[5].mA[0]), ivec2(-1, 3)) && allOk;
	allOk = compare_ivec2((blockC.f[5].mA[1]), ivec2(-2, -2)) && allOk;
	allOk = compare_ivec2((blockC.f[5].mA[2]), ivec2(7, -2)) && allOk;
	allOk = compare_ivec2((blockC.f[5].mA[3]), ivec2(7, -4)) && allOk;
	allOk = compare_ivec2((blockC.f[5].mA[4]), ivec2(-8, -4)) && allOk;
	allOk = compare_ivec2((blockC.f[5].mA[5]), ivec2(-9, -7)) && allOk;
	allOk = compare_ivec2((blockC.f[6].mA[0]), ivec2(0, 4)) && allOk;
	allOk = compare_ivec2((blockC.f[6].mA[1]), ivec2(-6, 2)) && allOk;
	allOk = compare_ivec2((blockC.f[6].mA[2]), ivec2(5, -6)) && allOk;
	allOk = compare_ivec2((blockC.f[6].mA[3]), ivec2(6, 7)) && allOk;
	allOk = compare_ivec2((blockC.f[6].mA[4]), ivec2(8, 0)) && allOk;
	allOk = compare_ivec2((blockC.f[6].mA[5]), ivec2(7, 9)) && allOk;
	allOk = compare_int((blockD[0].g), 6) && allOk;
	allOk = compare_int((blockD[1].g), 1) && allOk;
	allOk = compare_int((blockD[2].g), 4) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.d = (-4);
	blockC.e.mA[0] = (ivec4(-4, -7, -1, 9));
	blockC.e.mA[1] = (ivec4(-8, 6, 2, -1));
	blockC.e.mA[2] = (ivec4(0, 2, -2, -1));
	blockC.e.mA[3] = (ivec4(3, 0, -8, 9));
	blockC.e.mA[4] = (ivec4(2, 1, -2, -3));
	blockC.e.mA[5] = (ivec4(-1, 2, -5, 4));
	blockC.f[0].mA[0] = (ivec2(-6, -5));
	blockC.f[0].mA[1] = (ivec2(-3, -5));
	blockC.f[0].mA[2] = (ivec2(6, 6));
	blockC.f[0].mA[3] = (ivec2(-1, -3));
	blockC.f[0].mA[4] = (ivec2(-7, -3));
	blockC.f[0].mA[5] = (ivec2(-6, -2));
	blockC.f[1].mA[0] = (ivec2(0, -2));
	blockC.f[1].mA[1] = (ivec2(-3, -8));
	blockC.f[1].mA[2] = (ivec2(1, 8));
	blockC.f[1].mA[3] = (ivec2(-6, -3));
	blockC.f[1].mA[4] = (ivec2(1, 6));
	blockC.f[1].mA[5] = (ivec2(-6, -9));
	blockC.f[2].mA[0] = (ivec2(6, 8));
	blockC.f[2].mA[1] = (ivec2(-8, 9));
	blockC.f[2].mA[2] = (ivec2(5, -6));
	blockC.f[2].mA[3] = (ivec2(-6, -1));
	blockC.f[2].mA[4] = (ivec2(-6, -2));
	blockC.f[2].mA[5] = (ivec2(3, -4));
	blockC.f[3].mA[0] = (ivec2(7, -6));
	blockC.f[3].mA[1] = (ivec2(-9, -3));
	blockC.f[3].mA[2] = (ivec2(1, 8));
	blockC.f[3].mA[3] = (ivec2(7, -9));
	blockC.f[3].mA[4] = (ivec2(6, -4));
	blockC.f[3].mA[5] = (ivec2(4, -5));
	blockC.f[4].mA[0] = (ivec2(5, -1));
	blockC.f[4].mA[1] = (ivec2(8, 1));
	blockC.f[4].mA[2] = (ivec2(-2, 0));
	blockC.f[4].mA[3] = (ivec2(0, -7));
	blockC.f[4].mA[4] = (ivec2(-4, 9));
	blockC.f[4].mA[5] = (ivec2(-2, 6));
	blockC.f[5].mA[0] = (ivec2(6, 4));
	blockC.f[5].mA[1] = (ivec2(5, -9));
	blockC.f[5].mA[2] = (ivec2(-6, -6));
	blockC.f[5].mA[3] = (ivec2(-2, -4));
	blockC.f[5].mA[4] = (ivec2(-6, 3));
	blockC.f[5].mA[5] = (ivec2(-4, -9));
	blockC.f[6].mA[0] = (ivec2(0, 1));
	blockC.f[6].mA[1] = (ivec2(4, 3));
	blockC.f[6].mA[2] = (ivec2(7, 1));
	blockC.f[6].mA[3] = (ivec2(2, 6));
	blockC.f[6].mA[4] = (ivec2(1, 4));
	blockC.f[6].mA[5] = (ivec2(-8, 2));
	blockD[0].g = (2);
	blockD[1].g = (0);
	blockD[2].g = (4);
}
#version 450
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
	mediump uint var;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((var), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std140, column_major, binding = 1) readonly buffer Block
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

}
#version 450
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
	u8vec2 var;
};

bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(var), uvec2(3u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	f16vec2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(var), vec2(-6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	bvec4 var;
};

bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((var), bvec4(true, false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float(var[0][0], -2.0) && allOk;
	allOk = compare_float(var[0][1], -8.0) && allOk;
	allOk = compare_float(var[0][2], 8.0) && allOk;
	allOk = compare_float(var[1][0], 1.0) && allOk;
	allOk = compare_float(var[1][1], -6.0) && allOk;
	allOk = compare_float(var[1][2], 9.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-2.0, -8.0, 8.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(1.0, -6.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat3x2(var, mat3x2(-7.0, 3.0, -6.0, -6.0, 2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat4x3(var, mat4x3(-7.0, -2.0, 9.0, 1.0, 7.0, 8.0, 6.0, -6.0, -1.0, 4.0, -6.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump uvec2 var;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((padding), 3u) && allOk;
	allOk = compare_uvec2((var), uvec2(3u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	lowp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_mat2x4(var, mat2x4(-4.0, 7.0, 6.0, -1.0, -7.0, -7.0, -5.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), 8.0) && allOk;
	allOk = compare_mat3x4(var, mat3x4(-3.0, 1.0, 4.0, -6.0, 6.0, 8.0, -7.0, -4.0, -8.0, -2.0, -6.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat3x4(var[0], mat3x4(2.0, 9.0, 7.0, -5.0, 2.0, 3.0, 6.0, 6.0, 9.0, -9.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(-4.0, 6.0, 9.0, 4.0, 9.0, 3.0, 2.0, -4.0, -7.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(3.0, -5.0, 6.0, -3.0, 3.0, 2.0, 7.0, -3.0, -7.0, 0.0, 1.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat4x3(var[0], mat4x3(-1.0, -7.0, 8.0, 5.0, -5.0, 7.0, -9.0, 5.0, 0.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(7.0, -9.0, 6.0, 0.0, -8.0, -3.0, -6.0, 8.0, 8.0, -7.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(1.0, 0.0, 7.0, -2.0, 4.0, 9.0, 9.0, 8.0, -2.0, -2.0, -4.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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

}
#version 450
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
	allOk = compare_mat2x3(var[0], mat2x3(1.0, -3.0, 8.0, -6.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(4.0, -9.0, -8.0, -2.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(-7.0, -2.0, 0.0, -6.0, 5.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	u8vec3 var[3];
};

bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(var[0]), uvec3(4u, 3u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1]), uvec3(1u, 4u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2]), uvec3(8u, 6u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	bool padding;
	bool var[3];
};

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((padding), false) && allOk;
	allOk = compare_bool((var[0]), true) && allOk;
	allOk = compare_bool((var[1]), true) && allOk;
	allOk = compare_bool((var[2]), false) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_mat4(var[0], mat4(-1.0, -3.0, 3.0, 6.0, 5.0, 1.0, -3.0, -2.0, 3.0, -6.0, -8.0, 8.0, 9.0, -9.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(5.0, 3.0, -9.0, -5.0, -8.0, 6.0, -6.0, -7.0, -6.0, 0.0, 6.0, -7.0, 2.0, 9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(-4.0, 4.0, 3.0, -8.0, 1.0, -1.0, 7.0, 4.0, -2.0, 1.0, -3.0, -4.0, 5.0, 8.0, -1.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), 0.0) && allOk;
	allOk = compare_mat3x2(var[0], mat3x2(5.0, 2.0, -5.0, 9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(-9.0, 0.0, -5.0, 3.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(-2.0, 6.0, -3.0, -4.0, -9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3x4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_mat3x4(var[0], mat3x4(7.0, 2.0, -5.0, -4.0, 6.0, 5.0, 2.0, 9.0, -7.0, -7.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(-9.0, 0.0, -9.0, -4.0, 7.0, -1.0, -8.0, -5.0, -9.0, 1.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(-5.0, -7.0, -9.0, 6.0, -8.0, -6.0, -8.0, 5.0, 1.0, 9.0, 3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4x3 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0], mat4x3(-1.0, -7.0, 8.0, 5.0, -5.0, 7.0, -9.0, 5.0, 0.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(7.0, -9.0, 6.0, 0.0, -8.0, -3.0, -6.0, 8.0, 8.0, -7.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(1.0, 0.0, 7.0, -2.0, 4.0, 9.0, 9.0, 8.0, -2.0, -2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[3], mat4x3(-9.0, -4.0, -6.0, -5.0, 7.0, 2.0, -7.0, 7.0, -9.0, -2.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[4], mat4x3(-9.0, 7.0, -2.0, 5.0, -7.0, -5.0, 3.0, -9.0, 2.0, -7.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[5], mat4x3(3.0, -7.0, -4.0, -1.0, -5.0, 4.0, -4.0, -9.0, 6.0, 6.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[6], mat4x3(-3.0, 7.0, 3.0, 4.0, -3.0, -1.0, 0.0, -4.0, 3.0, 9.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[7], mat4x3(5.0, -6.0, -2.0, 1.0, 5.0, -8.0, -3.0, -1.0, 1.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[8], mat4x3(6.0, 1.0, 3.0, -8.0, 4.0, -1.0, -3.0, 8.0, -6.0, 9.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[9], mat4x3(5.0, -6.0, 2.0, -3.0, -5.0, 5.0, -4.0, -7.0, 2.0, 2.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[10], mat4x3(5.0, 3.0, -8.0, 6.0, 8.0, 5.0, -3.0, -3.0, 3.0, 3.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[11], mat4x3(-7.0, -1.0, 3.0, -3.0, 2.0, 9.0, 0.0, -7.0, 3.0, -1.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[12], mat4x3(2.0, -3.0, 7.0, -7.0, -3.0, -9.0, 0.0, 4.0, 2.0, -2.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[13], mat4x3(7.0, -3.0, 5.0, -8.0, 3.0, -8.0, 3.0, 6.0, 3.0, 7.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[14], mat4x3(0.0, -9.0, -2.0, -4.0, -7.0, 3.0, -9.0, 6.0, -1.0, 1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[15], mat4x3(3.0, 8.0, -7.0, -3.0, 4.0, 9.0, 4.0, -3.0, -3.0, 0.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[16], mat4x3(-9.0, -2.0, 5.0, 9.0, -9.0, 7.0, -7.0, -8.0, 2.0, -8.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[17], mat4x3(4.0, -3.0, 9.0, -4.0, 9.0, 3.0, -2.0, 9.0, 0.0, -3.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[18], mat4x3(3.0, 2.0, -1.0, -2.0, -5.0, 9.0, -1.0, -2.0, 6.0, -5.0, -6.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(scalar, row_major, binding = 1) readonly buffer Block
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

}
#version 450
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

}
#version 450
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
	lowp vec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((block.var), vec4(-7.0, 4.0, 3.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (vec4(-2.0, -3.0, 0.0, 1.0));
}
#version 450
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
	allOk = compare_mat2(block.var, mat2(-6.0, 3.0, 2.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(7.0, 5.0));
	block.var[1] = (vec2(0.0, 7.0));
}
#version 450
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
	allOk = compare_mat2(block.var, mat2(-8.0, 4.0, -2.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(-1.0, -9.0));
	block.var[1] = (vec2(0.0, -5.0));
}
#version 450
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

layout(std140, row_major, buffer_reference) buffer Block
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
	allOk = compare_float(block.var[0][1], 5.0) && allOk;
	allOk = compare_float(block.var[0][2], 0.0) && allOk;
	allOk = compare_float(block.var[0][3], -8.0) && allOk;
	allOk = compare_float(block.var[1][0], 6.0) && allOk;
	allOk = compare_float(block.var[1][1], 9.0) && allOk;
	allOk = compare_float(block.var[1][2], -2.0) && allOk;
	allOk = compare_float(block.var[1][3], -2.0) && allOk;
	allOk = compare_float(block.var[2][0], -1.0) && allOk;
	allOk = compare_float(block.var[2][1], 0.0) && allOk;
	allOk = compare_float(block.var[2][2], 1.0) && allOk;
	allOk = compare_float(block.var[2][3], 4.0) && allOk;
	allOk = compare_float(block.var[3][0], 2.0) && allOk;
	allOk = compare_float(block.var[3][1], -4.0) && allOk;
	allOk = compare_float(block.var[3][2], -5.0) && allOk;
	allOk = compare_float(block.var[3][3], -2.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-7.0, 5.0, 0.0, -8.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(6.0, 9.0, -2.0, -2.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(-1.0, 0.0, 1.0, 4.0)) && allOk;
	allOk = compare_vec4(block.var[3], vec4(2.0, -4.0, -5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(-9.0, -7.0, -8.0, -9.0));
	block.var[1] = (vec4(5.0, 0.0, 3.0, -7.0));
	block.var[2] = (vec4(9.0, -4.0, -5.0, 2.0));
	block.var[3] = (vec4(-2.0, 4.0, 1.0, 9.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var, mat2x3(-9.0, 1.0, 0.0, 2.0, 1.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x3(6.0, -5.0, 9.0, 0.0, 5.0, 3.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var, mat3x4(1.0, 9.0, 9.0, 9.0, -4.0, 5.0, -6.0, 5.0, 4.0, -3.0, 0.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x4(5.0, -7.0, -7.0, 0.0, -8.0, -1.0, -6.0, -6.0, 4.0, 6.0, 1.0, 0.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var, mat4x3(-2.0, 4.0, -1.0, -2.0, 7.0, 7.0, 9.0, -5.0, -1.0, 8.0, 2.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x3(4.0, -8.0, 3.0, 6.0, -8.0, 8.0, -7.0, 4.0, -4.0, -7.0, -4.0, 0.0));
}
#version 450
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
	lowp vec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((block.var), vec3(3.0, 4.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (vec3(-8.0, -5.0, 8.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var, mat2x3(6.0, -8.0, -3.0, 3.0, -9.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x3(3.0, 3.0, 6.0, 4.0, -3.0, 2.0));
}
#version 450
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
	allOk = compare_float((block.padding), 8.0) && allOk;
	allOk = compare_float(block.var[0][0], -3.0) && allOk;
	allOk = compare_float(block.var[0][1], 2.0) && allOk;
	allOk = compare_float(block.var[0][2], 9.0) && allOk;
	allOk = compare_float(block.var[0][3], -9.0) && allOk;
	allOk = compare_float(block.var[1][0], -6.0) && allOk;
	allOk = compare_float(block.var[1][1], 9.0) && allOk;
	allOk = compare_float(block.var[1][2], 4.0) && allOk;
	allOk = compare_float(block.var[1][3], 0.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-3.0, 2.0, 9.0, -9.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-6.0, 9.0, 4.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (0.0);
	block.var = (mat2x4(-2.0, -8.0, -1.0, 8.0, 1.0, 1.0, 2.0, -5.0));
}
#version 450
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
	allOk = compare_float((block.padding), -6.0) && allOk;
	allOk = compare_mat3x2(block.var, mat3x2(-6.0, 8.0, -5.0, -4.0, 6.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-1.0);
	block.var = (mat3x2(-3.0, -6.0, -5.0, -4.0, 5.0, -3.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.padding), -9.0) && allOk;
	allOk = compare_float(block.var[0][0], 9.0) && allOk;
	allOk = compare_float(block.var[0][1], 1.0) && allOk;
	allOk = compare_float(block.var[0][2], 9.0) && allOk;
	allOk = compare_float(block.var[1][0], -1.0) && allOk;
	allOk = compare_float(block.var[1][1], -8.0) && allOk;
	allOk = compare_float(block.var[1][2], -2.0) && allOk;
	allOk = compare_float(block.var[2][0], 8.0) && allOk;
	allOk = compare_float(block.var[2][1], 3.0) && allOk;
	allOk = compare_float(block.var[2][2], 0.0) && allOk;
	allOk = compare_float(block.var[3][0], 5.0) && allOk;
	allOk = compare_float(block.var[3][1], -1.0) && allOk;
	allOk = compare_float(block.var[3][2], -2.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(9.0, 1.0, 9.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-1.0, -8.0, -2.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(8.0, 3.0, 0.0)) && allOk;
	allOk = compare_vec3(block.var[3], vec3(5.0, -1.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-5.0);
	block.var[0] = (vec3(8.0, 1.0, -5.0));
	block.var[1] = (vec3(5.0, 1.0, -8.0));
	block.var[2] = (vec3(-8.0, -7.0, -6.0));
	block.var[3] = (vec3(1.0, 7.0, -4.0));
}
#version 450
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
	i8vec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(block.padding), 4294967293) && allOk;
	allOk = compare_i8vec4(ivec4(block.var), ivec4(4294967289, 4294967295, 8, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = int8_t(4294967294);
	block.var = i8vec4(ivec4(4294967292, 4294967290, 4294967289, 4294967291));
}
#version 450
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
	highp uint var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((block.var[0]), 3u) && allOk;
	allOk = compare_uint((block.var[1]), 6u) && allOk;
	allOk = compare_uint((block.var[2]), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (7u);
	block.var[1] = (9u);
	block.var[2] = (1u);
}
#version 450
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

layout(scalar, column_major, buffer_reference) buffer Block
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
	allOk = compare_float((block.padding), -1.0) && allOk;
	allOk = compare_mat3x2(block.var[0], mat3x2(4.0, -9.0, -1.0, -8.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1], mat3x2(6.0, 3.0, 1.0, 8.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2], mat3x2(-3.0, 3.0, -3.0, -4.0, 8.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-2.0);
	block.var[0] = (mat3x2(-2.0, -8.0, 0.0, -9.0, 9.0, 0.0));
	block.var[1] = (mat3x2(1.0, -3.0, -6.0, -5.0, -7.0, 5.0));
	block.var[2] = (mat3x2(-4.0, 8.0, -1.0, -8.0, 1.0, 2.0));
}
#version 450
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
	u16vec4 var[3];
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
	allOk = compare_u16vec4(uvec4(block.var[0]), uvec4(0u, 8u, 3u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1]), uvec4(7u, 5u, 4u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2]), uvec4(7u, 1u, 8u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = uint16_t(0u);
	block.var[0] = u16vec4(uvec4(6u, 9u, 4u, 5u));
	block.var[1] = u16vec4(uvec4(0u, 1u, 0u, 7u));
	block.var[2] = u16vec4(uvec4(6u, 5u, 9u, 8u));
}
#version 450
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
	allOk = compare_mat4(block.var[0], mat4(9.0, 0.0, -9.0, -9.0, 5.0, -4.0, 8.0, 7.0, 8.0, -4.0, -5.0, -7.0, 8.0, 9.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[1], mat4(3.0, 4.0, 1.0, -3.0, 3.0, -2.0, -9.0, 6.0, -5.0, 3.0, 1.0, 3.0, -4.0, -9.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[2], mat4(6.0, -8.0, 2.0, 0.0, -3.0, -8.0, 3.0, -7.0, 8.0, -5.0, -6.0, -1.0, -7.0, 5.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[3], mat4(8.0, -5.0, -2.0, -1.0, 5.0, 7.0, 2.0, 7.0, 0.0, 5.0, 9.0, 7.0, -5.0, 9.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[4], mat4(8.0, 7.0, 1.0, -9.0, 8.0, 7.0, -3.0, 1.0, -5.0, 0.0, 7.0, -9.0, -9.0, 1.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[5], mat4(-7.0, 4.0, -4.0, 2.0, -2.0, 6.0, 3.0, -1.0, -9.0, 1.0, 2.0, -8.0, -1.0, 3.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[6], mat4(-7.0, -9.0, 9.0, 6.0, -7.0, 9.0, 7.0, 4.0, 8.0, -5.0, 3.0, 2.0, 2.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[7], mat4(5.0, -2.0, 7.0, 6.0, -3.0, 2.0, -4.0, -5.0, -6.0, 7.0, 1.0, 1.0, 4.0, -5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[8], mat4(-6.0, 8.0, 6.0, 9.0, -2.0, -8.0, 3.0, 5.0, 0.0, -8.0, 8.0, -3.0, 2.0, -8.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[9], mat4(6.0, 4.0, -5.0, 5.0, -6.0, 1.0, -9.0, 6.0, -7.0, 3.0, 1.0, 0.0, 2.0, -7.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[10], mat4(4.0, -6.0, 8.0, -5.0, 7.0, 6.0, 1.0, -6.0, -2.0, 0.0, 1.0, 0.0, -6.0, -8.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[11], mat4(-4.0, -7.0, -7.0, 1.0, 4.0, -7.0, 4.0, -1.0, -3.0, -7.0, 6.0, 9.0, 3.0, 7.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[12], mat4(-3.0, 6.0, 6.0, -1.0, -2.0, -7.0, 1.0, 0.0, -5.0, 3.0, -7.0, 2.0, 6.0, 9.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[13], mat4(5.0, -4.0, -3.0, 9.0, -8.0, -9.0, 2.0, 5.0, -3.0, -3.0, -4.0, 9.0, -2.0, -8.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[14], mat4(-9.0, 0.0, 3.0, 0.0, 6.0, -5.0, 8.0, 6.0, -3.0, -9.0, -1.0, 2.0, 3.0, -7.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[15], mat4(9.0, -8.0, -7.0, -1.0, -3.0, 9.0, -4.0, -9.0, 3.0, -3.0, -7.0, -7.0, 3.0, 1.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[16], mat4(3.0, 0.0, 5.0, -1.0, 2.0, 2.0, -2.0, 3.0, -9.0, 7.0, 0.0, -8.0, -4.0, -2.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[17], mat4(-2.0, 8.0, -8.0, -3.0, 0.0, -5.0, 4.0, -3.0, -1.0, -8.0, 4.0, -2.0, -7.0, 0.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[18], mat4(1.0, 5.0, -7.0, -8.0, 2.0, 4.0, -9.0, -7.0, -4.0, 6.0, -7.0, 0.0, 5.0, 3.0, -3.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4(-3.0, -8.0, 5.0, -8.0, 8.0, -2.0, 8.0, 1.0, -9.0, 5.0, -7.0, -7.0, -5.0, -8.0, 9.0, -1.0));
	block.var[1] = (mat4(1.0, 6.0, -3.0, 2.0, -1.0, -8.0, -2.0, 0.0, -9.0, 3.0, 5.0, -5.0, -1.0, 1.0, -5.0, -2.0));
	block.var[2] = (mat4(1.0, -7.0, 1.0, 9.0, -4.0, 9.0, 7.0, 0.0, -4.0, -7.0, -9.0, -6.0, 0.0, -9.0, -8.0, -5.0));
	block.var[3] = (mat4(2.0, 3.0, 0.0, 3.0, 8.0, 6.0, -2.0, -6.0, 3.0, -5.0, 3.0, 5.0, -3.0, -2.0, 8.0, -1.0));
	block.var[4] = (mat4(-4.0, -1.0, -9.0, -2.0, 9.0, 7.0, -3.0, -1.0, 9.0, 1.0, -5.0, -1.0, -4.0, -2.0, 9.0, -1.0));
	block.var[5] = (mat4(-5.0, -1.0, 2.0, 4.0, -8.0, -6.0, 8.0, -7.0, -5.0, 2.0, -1.0, -8.0, -1.0, -6.0, 5.0, -4.0));
	block.var[6] = (mat4(3.0, 6.0, 4.0, 6.0, 0.0, 3.0, 8.0, 0.0, 2.0, -1.0, 4.0, 8.0, 1.0, 3.0, 6.0, 2.0));
	block.var[7] = (mat4(1.0, 2.0, 4.0, -4.0, -6.0, 6.0, -8.0, 2.0, 4.0, 0.0, -6.0, 4.0, 1.0, 7.0, 3.0, -3.0));
	block.var[8] = (mat4(2.0, 4.0, -5.0, 3.0, 6.0, 0.0, 1.0, -8.0, 0.0, -1.0, 2.0, 3.0, 3.0, 6.0, 9.0, 4.0));
	block.var[9] = (mat4(8.0, 9.0, 2.0, -7.0, 5.0, -9.0, 8.0, -4.0, 5.0, -1.0, -2.0, 4.0, 8.0, -4.0, 4.0, -1.0));
	block.var[10] = (mat4(-8.0, 6.0, -7.0, -1.0, 0.0, -7.0, 5.0, -1.0, -7.0, -2.0, -5.0, 6.0, -7.0, -9.0, -7.0, -8.0));
	block.var[11] = (mat4(-2.0, 0.0, 5.0, 7.0, 4.0, 4.0, 9.0, -9.0, 6.0, 5.0, -7.0, -1.0, -1.0, 5.0, -9.0, -1.0));
	block.var[12] = (mat4(5.0, 1.0, 7.0, 8.0, 0.0, -3.0, 8.0, 5.0, -2.0, -2.0, -1.0, -2.0, 4.0, -6.0, 1.0, 5.0));
	block.var[13] = (mat4(-1.0, 8.0, 6.0, 8.0, -7.0, -4.0, -5.0, -8.0, 5.0, 0.0, 7.0, -8.0, 8.0, -2.0, 6.0, 5.0));
	block.var[14] = (mat4(2.0, 8.0, -1.0, 1.0, -9.0, -1.0, 9.0, -4.0, 9.0, 4.0, -2.0, 9.0, 6.0, 7.0, 1.0, 3.0));
	block.var[15] = (mat4(-7.0, -5.0, 2.0, -5.0, 8.0, -5.0, -6.0, 3.0, -5.0, -8.0, 1.0, -1.0, 1.0, 2.0, -5.0, 3.0));
	block.var[16] = (mat4(7.0, 2.0, 8.0, -4.0, -1.0, 2.0, 4.0, 1.0, 9.0, 7.0, -6.0, 7.0, 7.0, -5.0, 0.0, 3.0));
	block.var[17] = (mat4(-4.0, -1.0, -2.0, -3.0, 6.0, 2.0, 7.0, 0.0, 3.0, 4.0, -4.0, 2.0, 8.0, -4.0, 7.0, -4.0));
	block.var[18] = (mat4(-2.0, -1.0, 8.0, 8.0, -9.0, 9.0, 6.0, -1.0, 3.0, -9.0, -4.0, -6.0, -2.0, 6.0, -7.0, 3.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0], mat4(3.0, 8.0, 5.0, -7.0, -4.0, 0.0, -1.0, -9.0, 2.0, 9.0, 5.0, 5.0, 6.0, 9.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[1], mat4(8.0, 1.0, -3.0, 1.0, 0.0, -7.0, -4.0, 0.0, 1.0, -6.0, -7.0, 5.0, 2.0, 0.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[2], mat4(-5.0, 8.0, 2.0, 3.0, 8.0, -6.0, 7.0, 9.0, -3.0, 7.0, -8.0, -5.0, 6.0, 4.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[3], mat4(7.0, 0.0, -6.0, -1.0, 5.0, 0.0, -3.0, -3.0, 6.0, -5.0, 1.0, 4.0, -5.0, -7.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[4], mat4(-2.0, -3.0, 2.0, -9.0, 6.0, -8.0, 8.0, 2.0, -3.0, -9.0, 8.0, 1.0, -4.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[5], mat4(9.0, -2.0, -1.0, -7.0, 6.0, -6.0, -3.0, -9.0, -3.0, -7.0, -2.0, 2.0, -9.0, -2.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[6], mat4(2.0, -3.0, 7.0, 9.0, 7.0, -1.0, 3.0, 6.0, -3.0, 2.0, -2.0, 7.0, -9.0, 0.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[7], mat4(-2.0, -1.0, -6.0, -6.0, 5.0, -8.0, 7.0, 3.0, -6.0, 4.0, -8.0, -1.0, 1.0, 4.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[8], mat4(-7.0, -2.0, -4.0, -6.0, -6.0, 8.0, 5.0, -4.0, -7.0, 7.0, -4.0, -9.0, -7.0, -1.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[9], mat4(5.0, -4.0, -1.0, -3.0, 3.0, 2.0, 1.0, -6.0, 3.0, 5.0, -4.0, 0.0, 2.0, -4.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[10], mat4(-6.0, -9.0, -6.0, -9.0, -4.0, 2.0, 5.0, 4.0, -6.0, -2.0, -5.0, 7.0, 9.0, -4.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[11], mat4(-2.0, 1.0, -2.0, 0.0, -7.0, 2.0, -6.0, -5.0, 2.0, -1.0, -8.0, 8.0, 2.0, -9.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[12], mat4(4.0, 4.0, 9.0, -7.0, 9.0, 2.0, 3.0, 7.0, 0.0, -9.0, 2.0, -1.0, -8.0, -7.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[13], mat4(0.0, -3.0, -1.0, -1.0, -6.0, 1.0, -8.0, 1.0, 5.0, 0.0, 2.0, -1.0, -1.0, -6.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[14], mat4(7.0, 5.0, -2.0, -4.0, 0.0, 1.0, -6.0, -3.0, -1.0, -7.0, -7.0, -6.0, 1.0, -4.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[15], mat4(8.0, -3.0, 9.0, 6.0, -2.0, -9.0, 4.0, 5.0, 6.0, 4.0, -3.0, -8.0, 6.0, 5.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[16], mat4(-2.0, 5.0, 8.0, 4.0, -4.0, 9.0, 3.0, -5.0, 1.0, -6.0, 1.0, -5.0, 8.0, 7.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[17], mat4(3.0, 0.0, -3.0, 3.0, 2.0, -8.0, -7.0, 8.0, -3.0, 2.0, -9.0, -7.0, 1.0, -5.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[18], mat4(0.0, 0.0, -1.0, 0.0, -9.0, 5.0, 4.0, 0.0, -6.0, -7.0, 1.0, -9.0, -4.0, -4.0, 0.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec4(-7.0, -2.0, 7.0, -7.0));
	block.var[0][1] = (vec4(2.0, -4.0, 3.0, -5.0));
	block.var[0][2] = (vec4(2.0, 3.0, 8.0, 8.0));
	block.var[0][3] = (vec4(3.0, 0.0, -4.0, -1.0));
	block.var[1][0] = (vec4(-3.0, 0.0, 8.0, 1.0));
	block.var[1][1] = (vec4(-8.0, 9.0, 2.0, 7.0));
	block.var[1][2] = (vec4(-2.0, -7.0, -9.0, 1.0));
	block.var[1][3] = (vec4(6.0, -9.0, -1.0, -5.0));
	block.var[2][0] = (vec4(-6.0, -3.0, 7.0, -1.0));
	block.var[2][1] = (vec4(0.0, -1.0, -2.0, 1.0));
	block.var[2][2] = (vec4(-3.0, -1.0, -4.0, 7.0));
	block.var[2][3] = (vec4(-3.0, 1.0, 1.0, -9.0));
	block.var[3][0] = (vec4(-3.0, 2.0, 9.0, -4.0));
	block.var[3][1] = (vec4(2.0, 9.0, -9.0, -2.0));
	block.var[3][2] = (vec4(-1.0, 1.0, -9.0, 0.0));
	block.var[3][3] = (vec4(-7.0, 7.0, -3.0, -9.0));
	block.var[4][0] = (vec4(-1.0, 0.0, 7.0, 7.0));
	block.var[4][1] = (vec4(-5.0, -2.0, -6.0, 0.0));
	block.var[4][2] = (vec4(-2.0, 1.0, -2.0, 4.0));
	block.var[4][3] = (vec4(4.0, 0.0, 0.0, -2.0));
	block.var[5][0] = (vec4(4.0, 7.0, -5.0, -3.0));
	block.var[5][1] = (vec4(9.0, 1.0, 5.0, 5.0));
	block.var[5][2] = (vec4(9.0, -4.0, -6.0, 8.0));
	block.var[5][3] = (vec4(1.0, -5.0, 5.0, -3.0));
	block.var[6][0] = (vec4(-4.0, -3.0, 4.0, -8.0));
	block.var[6][1] = (vec4(-2.0, 0.0, -8.0, 2.0));
	block.var[6][2] = (vec4(-3.0, -5.0, 3.0, -2.0));
	block.var[6][3] = (vec4(-9.0, -8.0, -3.0, 5.0));
	block.var[7][0] = (vec4(-9.0, 6.0, -6.0, 7.0));
	block.var[7][1] = (vec4(-8.0, 2.0, 7.0, -5.0));
	block.var[7][2] = (vec4(0.0, -4.0, -7.0, 6.0));
	block.var[7][3] = (vec4(0.0, 0.0, 4.0, -5.0));
	block.var[8][0] = (vec4(-1.0, -9.0, -7.0, 5.0));
	block.var[8][1] = (vec4(3.0, 9.0, -8.0, -6.0));
	block.var[8][2] = (vec4(-3.0, 6.0, -9.0, 4.0));
	block.var[8][3] = (vec4(6.0, -6.0, -6.0, -2.0));
	block.var[9][0] = (vec4(-8.0, -3.0, -8.0, 5.0));
	block.var[9][1] = (vec4(6.0, -9.0, -7.0, -7.0));
	block.var[9][2] = (vec4(6.0, 1.0, 0.0, -3.0));
	block.var[9][3] = (vec4(4.0, 1.0, -7.0, 4.0));
	block.var[10][0] = (vec4(6.0, 4.0, 3.0, -5.0));
	block.var[10][1] = (vec4(-8.0, 0.0, -2.0, 7.0));
	block.var[10][2] = (vec4(5.0, -1.0, -3.0, -2.0));
	block.var[10][3] = (vec4(-6.0, -9.0, -3.0, 5.0));
	block.var[11][0] = (vec4(8.0, 7.0, -4.0, 1.0));
	block.var[11][1] = (vec4(6.0, -9.0, 8.0, 3.0));
	block.var[11][2] = (vec4(-6.0, -7.0, 7.0, -1.0));
	block.var[11][3] = (vec4(-7.0, 6.0, -5.0, 9.0));
	block.var[12][0] = (vec4(-3.0, 9.0, 5.0, -2.0));
	block.var[12][1] = (vec4(-7.0, 3.0, 3.0, 1.0));
	block.var[12][2] = (vec4(-7.0, -9.0, -5.0, -7.0));
	block.var[12][3] = (vec4(-7.0, -8.0, -2.0, -8.0));
	block.var[13][0] = (vec4(3.0, 7.0, 3.0, 7.0));
	block.var[13][1] = (vec4(-8.0, 9.0, -9.0, -9.0));
	block.var[13][2] = (vec4(3.0, -4.0, -8.0, 3.0));
	block.var[13][3] = (vec4(9.0, -7.0, -5.0, -5.0));
	block.var[14][0] = (vec4(2.0, 2.0, -3.0, 9.0));
	block.var[14][1] = (vec4(0.0, -6.0, 7.0, 1.0));
	block.var[14][2] = (vec4(-1.0, 2.0, -7.0, 2.0));
	block.var[14][3] = (vec4(-1.0, -6.0, -8.0, 1.0));
	block.var[15][0] = (vec4(1.0, -4.0, -6.0, -4.0));
	block.var[15][1] = (vec4(-9.0, 0.0, -2.0, 6.0));
	block.var[15][2] = (vec4(3.0, 3.0, 4.0, -6.0));
	block.var[15][3] = (vec4(-7.0, 9.0, -1.0, 6.0));
	block.var[16][0] = (vec4(-8.0, -1.0, 0.0, -8.0));
	block.var[16][1] = (vec4(3.0, -1.0, 9.0, -7.0));
	block.var[16][2] = (vec4(-4.0, 7.0, 9.0, -5.0));
	block.var[16][3] = (vec4(2.0, -8.0, 7.0, 8.0));
	block.var[17][0] = (vec4(1.0, -8.0, -3.0, -8.0));
	block.var[17][1] = (vec4(-8.0, -6.0, -2.0, -9.0));
	block.var[17][2] = (vec4(-4.0, 4.0, -9.0, -5.0));
	block.var[17][3] = (vec4(-2.0, 9.0, -7.0, -6.0));
	block.var[18][0] = (vec4(-2.0, -9.0, -3.0, -3.0));
	block.var[18][1] = (vec4(-3.0, 0.0, -7.0, 1.0));
	block.var[18][2] = (vec4(6.0, -1.0, 3.0, 4.0));
	block.var[18][3] = (vec4(8.0, 7.0, 7.0, -9.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0], mat4x2(0.0, 6.0, -3.0, 7.0, 1.0, -8.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(2.0, -3.0, -5.0, 5.0, 5.0, 1.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(1.0, 1.0, -2.0, -3.0, -9.0, 3.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[3], mat4x2(6.0, -2.0, -9.0, 5.0, -5.0, -6.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[4], mat4x2(5.0, -3.0, 5.0, 6.0, -4.0, -8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[5], mat4x2(-5.0, 4.0, -9.0, 6.0, 8.0, -3.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[6], mat4x2(9.0, 5.0, 0.0, -5.0, 6.0, -8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[7], mat4x2(2.0, 6.0, -5.0, 2.0, -8.0, -2.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[8], mat4x2(6.0, -1.0, 6.0, -3.0, 4.0, 0.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[9], mat4x2(-5.0, 8.0, 8.0, -7.0, 4.0, 6.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[10], mat4x2(-9.0, -8.0, 9.0, -2.0, -7.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[11], mat4x2(-5.0, 0.0, 3.0, 9.0, -8.0, -1.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[12], mat4x2(-2.0, -6.0, 4.0, 4.0, 5.0, -9.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[13], mat4x2(-3.0, 4.0, 3.0, -2.0, -5.0, 0.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[14], mat4x2(-3.0, 4.0, -5.0, -8.0, 5.0, -3.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[15], mat4x2(3.0, 4.0, -7.0, 4.0, -9.0, 4.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[16], mat4x2(-7.0, 4.0, -9.0, -9.0, -6.0, 2.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[17], mat4x2(-6.0, 6.0, -7.0, -6.0, -7.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[18], mat4x2(1.0, -7.0, -5.0, 9.0, -9.0, -1.0, 6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4x2(8.0, -5.0, 3.0, 0.0, -9.0, 4.0, -5.0, 3.0));
	block.var[1] = (mat4x2(6.0, 3.0, 6.0, -6.0, 0.0, -3.0, -2.0, -4.0));
	block.var[2] = (mat4x2(5.0, 4.0, 1.0, 0.0, 7.0, -9.0, -4.0, 5.0));
	block.var[3] = (mat4x2(6.0, 1.0, 0.0, 3.0, 2.0, -5.0, -4.0, 5.0));
	block.var[4] = (mat4x2(5.0, -4.0, -7.0, -8.0, 9.0, -4.0, 5.0, 5.0));
	block.var[5] = (mat4x2(-1.0, 6.0, -6.0, 5.0, 4.0, -3.0, 1.0, -4.0));
	block.var[6] = (mat4x2(1.0, -6.0, 2.0, 4.0, 7.0, 1.0, 9.0, 5.0));
	block.var[7] = (mat4x2(8.0, -7.0, 6.0, -7.0, -4.0, 5.0, 3.0, -2.0));
	block.var[8] = (mat4x2(-2.0, -5.0, -1.0, 1.0, -8.0, 4.0, 9.0, 2.0));
	block.var[9] = (mat4x2(-5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 1.0, 1.0));
	block.var[10] = (mat4x2(1.0, -9.0, -1.0, 6.0, -9.0, -7.0, -8.0, 8.0));
	block.var[11] = (mat4x2(-2.0, 7.0, 8.0, -9.0, 4.0, -3.0, 0.0, -7.0));
	block.var[12] = (mat4x2(4.0, 9.0, -8.0, 5.0, 3.0, 3.0, -4.0, 8.0));
	block.var[13] = (mat4x2(-7.0, 2.0, 2.0, -4.0, 6.0, -1.0, 1.0, 1.0));
	block.var[14] = (mat4x2(-9.0, 7.0, 9.0, -1.0, 3.0, -9.0, 2.0, -2.0));
	block.var[15] = (mat4x2(4.0, 1.0, 2.0, 3.0, 5.0, -3.0, -8.0, -1.0));
	block.var[16] = (mat4x2(2.0, 6.0, -3.0, 8.0, 3.0, -4.0, 8.0, 5.0));
	block.var[17] = (mat4x2(-4.0, 6.0, 7.0, -3.0, 1.0, 9.0, 7.0, 4.0));
	block.var[18] = (mat4x2(8.0, -7.0, 4.0, 5.0, -8.0, -6.0, -7.0, 1.0));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
{
	u16vec3 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(block.var[0]), uvec3(1u, 0u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1]), uvec3(9u, 0u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2]), uvec3(7u, 1u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[3]), uvec3(0u, 4u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[4]), uvec3(9u, 7u, 2u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[5]), uvec3(1u, 0u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[6]), uvec3(6u, 8u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[7]), uvec3(5u, 6u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[8]), uvec3(3u, 3u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[9]), uvec3(1u, 0u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[10]), uvec3(1u, 3u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[11]), uvec3(3u, 6u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[12]), uvec3(9u, 4u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[13]), uvec3(9u, 1u, 4u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[14]), uvec3(8u, 5u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[15]), uvec3(3u, 1u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[16]), uvec3(8u, 0u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[17]), uvec3(2u, 3u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[18]), uvec3(6u, 1u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = u16vec3(uvec3(1u, 2u, 6u));
	block.var[1] = u16vec3(uvec3(8u, 3u, 3u));
	block.var[2] = u16vec3(uvec3(4u, 4u, 9u));
	block.var[3] = u16vec3(uvec3(7u, 5u, 4u));
	block.var[4] = u16vec3(uvec3(5u, 6u, 5u));
	block.var[5] = u16vec3(uvec3(7u, 0u, 6u));
	block.var[6] = u16vec3(uvec3(4u, 7u, 0u));
	block.var[7] = u16vec3(uvec3(4u, 2u, 1u));
	block.var[8] = u16vec3(uvec3(0u, 2u, 8u));
	block.var[9] = u16vec3(uvec3(0u, 7u, 0u));
	block.var[10] = u16vec3(uvec3(2u, 8u, 7u));
	block.var[11] = u16vec3(uvec3(1u, 2u, 8u));
	block.var[12] = u16vec3(uvec3(1u, 3u, 3u));
	block.var[13] = u16vec3(uvec3(0u, 2u, 2u));
	block.var[14] = u16vec3(uvec3(7u, 9u, 1u));
	block.var[15] = u16vec3(uvec3(2u, 8u, 7u));
	block.var[16] = u16vec3(uvec3(9u, 6u, 3u));
	block.var[17] = u16vec3(uvec3(2u, 0u, 6u));
	block.var[18] = u16vec3(uvec3(6u, 1u, 7u));
}
#version 450
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
	allOk = compare_mat3(block.var[0], mat3(-9.0, -4.0, 2.0, 9.0, 6.0, -2.0, 1.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(6.0, 3.0, 2.0, 7.0, 4.0, 2.0, 3.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(6.0, 3.0, 7.0, -4.0, -2.0, -7.0, -6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[3], mat3(8.0, -8.0, 9.0, -5.0, 1.0, 4.0, -5.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[4], mat3(3.0, -6.0, -5.0, 8.0, -7.0, -1.0, 7.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[5], mat3(-3.0, 9.0, -3.0, -6.0, -2.0, -9.0, 4.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[6], mat3(-9.0, -7.0, 6.0, 9.0, 7.0, 9.0, -3.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[7], mat3(9.0, -2.0, 1.0, 4.0, 4.0, 6.0, -1.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[8], mat3(-5.0, 6.0, 1.0, -6.0, -3.0, -8.0, -9.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[9], mat3(-7.0, 8.0, -9.0, 5.0, -3.0, 6.0, 5.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[10], mat3(-4.0, 7.0, -7.0, -7.0, -4.0, 4.0, -5.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[11], mat3(2.0, 6.0, -4.0, -8.0, -5.0, -4.0, -7.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[12], mat3(6.0, 2.0, -2.0, -8.0, 6.0, -8.0, 9.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[13], mat3(2.0, -5.0, -3.0, 8.0, -9.0, -7.0, 1.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[14], mat3(4.0, 7.0, -9.0, 5.0, 0.0, -7.0, -9.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[15], mat3(-1.0, -3.0, 9.0, -3.0, 4.0, 3.0, 3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[16], mat3(6.0, 8.0, -8.0, 7.0, -1.0, 4.0, 0.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[17], mat3(2.0, 8.0, 8.0, -5.0, 4.0, -5.0, 8.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[18], mat3(8.0, 6.0, -5.0, 8.0, 3.0, 2.0, -2.0, 5.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3(-1.0, -8.0, 7.0, -5.0, 5.0, 6.0, 0.0, -8.0, -6.0));
	block.var[1] = (mat3(-4.0, 3.0, 7.0, 1.0, -1.0, 9.0, 6.0, 2.0, 9.0));
	block.var[2] = (mat3(-6.0, 8.0, 0.0, 1.0, 4.0, 6.0, -9.0, -9.0, 2.0));
	block.var[3] = (mat3(8.0, -1.0, 9.0, 9.0, 7.0, -5.0, -5.0, -8.0, 8.0));
	block.var[4] = (mat3(-2.0, 9.0, 8.0, -9.0, 3.0, 2.0, 9.0, 1.0, 2.0));
	block.var[5] = (mat3(-9.0, -7.0, -5.0, -3.0, 7.0, 2.0, -1.0, 1.0, 2.0));
	block.var[6] = (mat3(-2.0, 9.0, 0.0, 0.0, -3.0, -9.0, -6.0, 5.0, 0.0));
	block.var[7] = (mat3(-5.0, 6.0, 3.0, -2.0, 5.0, 6.0, 9.0, -9.0, 8.0));
	block.var[8] = (mat3(6.0, 6.0, -9.0, -8.0, -3.0, -7.0, 6.0, -1.0, -6.0));
	block.var[9] = (mat3(-1.0, 6.0, -1.0, 1.0, -5.0, -8.0, 2.0, -7.0, -4.0));
	block.var[10] = (mat3(3.0, -9.0, 2.0, -1.0, 4.0, 3.0, -2.0, 9.0, -3.0));
	block.var[11] = (mat3(-6.0, -9.0, 6.0, 9.0, 0.0, 3.0, 8.0, -4.0, -4.0));
	block.var[12] = (mat3(1.0, -8.0, 4.0, 5.0, 7.0, 9.0, 5.0, 8.0, -6.0));
	block.var[13] = (mat3(-9.0, -5.0, 9.0, 8.0, -9.0, -8.0, -5.0, 6.0, -7.0));
	block.var[14] = (mat3(2.0, 4.0, 5.0, -8.0, -2.0, 8.0, 6.0, 2.0, -9.0));
	block.var[15] = (mat3(-8.0, 1.0, -1.0, 7.0, -2.0, -3.0, 5.0, 3.0, 0.0));
	block.var[16] = (mat3(-1.0, -2.0, -3.0, 3.0, -9.0, -3.0, -4.0, -7.0, -5.0));
	block.var[17] = (mat3(-8.0, 9.0, 8.0, 8.0, 4.0, 5.0, 1.0, 8.0, 7.0));
	block.var[18] = (mat3(2.0, 2.0, -3.0, 0.0, 0.0, 9.0, 3.0, 9.0, 2.0));
}
#version 450
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
	u16vec3 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(block.var[0]), uvec3(1u, 0u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1]), uvec3(9u, 0u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2]), uvec3(7u, 1u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[3]), uvec3(0u, 4u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[4]), uvec3(9u, 7u, 2u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[5]), uvec3(1u, 0u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[6]), uvec3(6u, 8u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[7]), uvec3(5u, 6u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[8]), uvec3(3u, 3u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[9]), uvec3(1u, 0u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[10]), uvec3(1u, 3u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[11]), uvec3(3u, 6u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[12]), uvec3(9u, 4u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[13]), uvec3(9u, 1u, 4u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[14]), uvec3(8u, 5u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[15]), uvec3(3u, 1u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[16]), uvec3(8u, 0u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[17]), uvec3(2u, 3u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[18]), uvec3(6u, 1u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = u16vec3(uvec3(1u, 2u, 6u));
	block.var[1] = u16vec3(uvec3(8u, 3u, 3u));
	block.var[2] = u16vec3(uvec3(4u, 4u, 9u));
	block.var[3] = u16vec3(uvec3(7u, 5u, 4u));
	block.var[4] = u16vec3(uvec3(5u, 6u, 5u));
	block.var[5] = u16vec3(uvec3(7u, 0u, 6u));
	block.var[6] = u16vec3(uvec3(4u, 7u, 0u));
	block.var[7] = u16vec3(uvec3(4u, 2u, 1u));
	block.var[8] = u16vec3(uvec3(0u, 2u, 8u));
	block.var[9] = u16vec3(uvec3(0u, 7u, 0u));
	block.var[10] = u16vec3(uvec3(2u, 8u, 7u));
	block.var[11] = u16vec3(uvec3(1u, 2u, 8u));
	block.var[12] = u16vec3(uvec3(1u, 3u, 3u));
	block.var[13] = u16vec3(uvec3(0u, 2u, 2u));
	block.var[14] = u16vec3(uvec3(7u, 9u, 1u));
	block.var[15] = u16vec3(uvec3(2u, 8u, 7u));
	block.var[16] = u16vec3(uvec3(9u, 6u, 3u));
	block.var[17] = u16vec3(uvec3(2u, 0u, 6u));
	block.var[18] = u16vec3(uvec3(6u, 1u, 7u));
}
#version 450
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

layout(std140, buffer_reference) buffer Block
{
	highp uvec3 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((block.var[0][0]), uvec3(9u, 6u, 4u)) && allOk;
	allOk = compare_uvec3((block.var[0][1]), uvec3(7u, 2u, 7u)) && allOk;
	allOk = compare_uvec3((block.var[0][2]), uvec3(5u, 0u, 2u)) && allOk;
	allOk = compare_uvec3((block.var[1][0]), uvec3(6u, 8u, 0u)) && allOk;
	allOk = compare_uvec3((block.var[1][1]), uvec3(3u, 5u, 1u)) && allOk;
	allOk = compare_uvec3((block.var[1][2]), uvec3(7u, 2u, 3u)) && allOk;
	allOk = compare_uvec3((block.var[2][0]), uvec3(2u, 1u, 7u)) && allOk;
	allOk = compare_uvec3((block.var[2][1]), uvec3(1u, 5u, 4u)) && allOk;
	allOk = compare_uvec3((block.var[2][2]), uvec3(0u, 4u, 3u)) && allOk;
	allOk = compare_uvec3((block.var[3][0]), uvec3(1u, 4u, 3u)) && allOk;
	allOk = compare_uvec3((block.var[3][1]), uvec3(8u, 9u, 0u)) && allOk;
	allOk = compare_uvec3((block.var[3][2]), uvec3(7u, 2u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (uvec3(3u, 5u, 6u));
	block.var[0][1] = (uvec3(5u, 4u, 5u));
	block.var[0][2] = (uvec3(4u, 9u, 4u));
	block.var[1][0] = (uvec3(4u, 7u, 7u));
	block.var[1][1] = (uvec3(0u, 2u, 9u));
	block.var[1][2] = (uvec3(4u, 7u, 8u));
	block.var[2][0] = (uvec3(9u, 4u, 3u));
	block.var[2][1] = (uvec3(5u, 8u, 0u));
	block.var[2][2] = (uvec3(5u, 4u, 6u));
	block.var[3][0] = (uvec3(7u, 7u, 5u));
	block.var[3][1] = (uvec3(3u, 7u, 0u));
	block.var[3][2] = (uvec3(8u, 1u, 2u));
}
#version 450
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

layout(std430, row_major, buffer_reference) buffer Block
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
	allOk = compare_mat3x4(block.var[0][0], mat3x4(5.0, -7.0, -9.0, 4.0, 5.0, 3.0, -7.0, -3.0, 7.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1], mat3x4(-9.0, 7.0, -4.0, 5.0, -9.0, -5.0, 2.0, 6.0, -3.0, -5.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2], mat3x4(4.0, 1.0, 3.0, -1.0, -3.0, -2.0, 2.0, 7.0, 5.0, -1.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0], mat3x4(5.0, 1.0, -8.0, -9.0, -6.0, 4.0, 0.0, -9.0, 0.0, -1.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1], mat3x4(-3.0, 6.0, 3.0, 0.0, -4.0, 2.0, 4.0, 3.0, -4.0, 9.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2], mat3x4(-1.0, 6.0, 5.0, -4.0, -5.0, 7.0, -4.0, -5.0, 8.0, -9.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0], mat3x4(2.0, 3.0, 2.0, 5.0, -4.0, -4.0, 2.0, 8.0, 5.0, -5.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1], mat3x4(-3.0, 3.0, -2.0, 6.0, 9.0, -7.0, 8.0, 8.0, 1.0, 9.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2], mat3x4(1.0, -2.0, 4.0, 2.0, 7.0, -2.0, -9.0, 6.0, -4.0, 0.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0], mat3x4(6.0, -8.0, 1.0, 3.0, 2.0, -7.0, 4.0, -9.0, -7.0, 0.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1], mat3x4(-8.0, 4.0, 3.0, 2.0, 2.0, 0.0, -5.0, -4.0, 7.0, 3.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][2], mat3x4(2.0, 0.0, -3.0, 3.0, -7.0, 7.0, -8.0, 9.0, -2.0, 5.0, 8.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat3x4(0.0, 2.0, -8.0, -3.0, 5.0, -1.0, 3.0, -5.0, -9.0, -7.0, 8.0, -9.0));
	block.var[0][1] = (mat3x4(0.0, -5.0, 1.0, -9.0, -1.0, 4.0, 7.0, 4.0, -4.0, -6.0, 0.0, -5.0));
	block.var[0][2] = (mat3x4(-7.0, 5.0, -9.0, -3.0, -7.0, 7.0, 1.0, -4.0, 7.0, -8.0, -2.0, -9.0));
	block.var[1][0] = (mat3x4(0.0, -2.0, -8.0, -5.0, 0.0, 5.0, -2.0, -1.0, 5.0, 8.0, -3.0, 1.0));
	block.var[1][1] = (mat3x4(-1.0, 7.0, 7.0, 7.0, 2.0, -7.0, 8.0, -3.0, -8.0, -2.0, -5.0, -6.0));
	block.var[1][2] = (mat3x4(5.0, 8.0, 9.0, 8.0, 7.0, 0.0, 9.0, 7.0, -3.0, -7.0, -6.0, -5.0));
	block.var[2][0] = (mat3x4(-7.0, -8.0, -2.0, 9.0, -8.0, 3.0, 9.0, 9.0, 5.0, -8.0, -1.0, 2.0));
	block.var[2][1] = (mat3x4(1.0, 5.0, 7.0, 5.0, -4.0, -7.0, -5.0, -9.0, -1.0, 6.0, 2.0, 4.0));
	block.var[2][2] = (mat3x4(-1.0, 2.0, 3.0, -5.0, -6.0, -4.0, 4.0, -7.0, -1.0, 8.0, -9.0, 2.0));
	block.var[3][0] = (mat3x4(-2.0, 9.0, -8.0, 3.0, -5.0, 6.0, -8.0, 3.0, -8.0, 6.0, 6.0, -8.0));
	block.var[3][1] = (mat3x4(-3.0, 2.0, 8.0, 3.0, -1.0, 0.0, -7.0, 5.0, 3.0, 2.0, 9.0, -2.0));
	block.var[3][2] = (mat3x4(-7.0, -5.0, -3.0, 6.0, -7.0, -8.0, -4.0, 1.0, 0.0, 0.0, 1.0, 9.0));
}
#version 450
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
	allOk = compare_float((block.padding), -8.0) && allOk;
	allOk = compare_mat3(block.var[0][0], mat3(-7.0, 8.0, 7.0, 4.0, 4.0, -1.0, -9.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[0][1], mat3(-4.0, -3.0, 8.0, 7.0, -3.0, -7.0, -4.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[0][2], mat3(-9.0, -1.0, 8.0, 8.0, 3.0, -1.0, 6.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[1][0], mat3(-2.0, 3.0, 7.0, 0.0, 0.0, 1.0, 4.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[1][1], mat3(4.0, 6.0, 8.0, 8.0, 6.0, 3.0, 1.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[1][2], mat3(8.0, 3.0, 9.0, 3.0, 8.0, -8.0, 0.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[2][0], mat3(-7.0, 4.0, -2.0, -5.0, -4.0, 5.0, 7.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[2][1], mat3(-9.0, -9.0, 6.0, -6.0, -9.0, -8.0, 2.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[2][2], mat3(4.0, -6.0, -6.0, -7.0, -6.0, -6.0, -3.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[3][0], mat3(5.0, -4.0, -6.0, -5.0, -8.0, -3.0, 6.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[3][1], mat3(-2.0, 4.0, -8.0, 0.0, -3.0, -6.0, -1.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[3][2], mat3(-7.0, 4.0, -8.0, 4.0, -8.0, -5.0, 6.0, 8.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (5.0);
	block.var[0][0] = (mat3(8.0, 3.0, -2.0, 2.0, -8.0, -5.0, 2.0, 8.0, -6.0));
	block.var[0][1] = (mat3(-5.0, -5.0, 8.0, -2.0, -5.0, 5.0, -1.0, 7.0, 3.0));
	block.var[0][2] = (mat3(-2.0, 3.0, 5.0, 5.0, 1.0, -6.0, 9.0, -7.0, -5.0));
	block.var[1][0] = (mat3(-2.0, -6.0, 2.0, -1.0, 0.0, 2.0, 4.0, 9.0, 9.0));
	block.var[1][1] = (mat3(6.0, 8.0, 4.0, 5.0, -2.0, -5.0, -5.0, 7.0, 7.0));
	block.var[1][2] = (mat3(-3.0, -8.0, 1.0, -4.0, 7.0, 1.0, -1.0, 1.0, 5.0));
	block.var[2][0] = (mat3(8.0, 9.0, 6.0, -1.0, 5.0, -2.0, 8.0, -1.0, 1.0));
	block.var[2][1] = (mat3(8.0, 1.0, 2.0, 4.0, -7.0, 3.0, 4.0, -8.0, -1.0));
	block.var[2][2] = (mat3(2.0, -1.0, -7.0, 7.0, -8.0, -6.0, -5.0, 2.0, 5.0));
	block.var[3][0] = (mat3(2.0, -9.0, -9.0, -2.0, 1.0, 8.0, -9.0, 2.0, -4.0));
	block.var[3][1] = (mat3(5.0, -2.0, 2.0, 3.0, 3.0, -8.0, 8.0, -5.0, 0.0));
	block.var[3][2] = (mat3(2.0, -5.0, -9.0, 4.0, 6.0, -3.0, 2.0, 6.0, -9.0));
}
#version 450
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
	allOk = compare_float((block.padding), 2.0) && allOk;
	allOk = compare_mat2x3(block.var[0][0], mat2x3(-7.0, 8.0, 7.0, -6.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1], mat2x3(-2.0, 1.0, -7.0, -8.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2], mat2x3(7.0, 2.0, -2.0, -3.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0], mat2x3(5.0, 9.0, -2.0, -6.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1], mat2x3(7.0, 9.0, 5.0, -5.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2], mat2x3(4.0, -6.0, -4.0, -7.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0], mat2x3(9.0, 8.0, -5.0, 0.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1], mat2x3(-3.0, -8.0, 0.0, -2.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2], mat2x3(9.0, 4.0, -4.0, -7.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0], mat2x3(-8.0, 0.0, -2.0, 3.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1], mat2x3(2.0, 2.0, 8.0, 5.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][2], mat2x3(9.0, -3.0, -8.0, 0.0, -4.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (0.0);
	block.var[0][0] = (mat2x3(6.0, 9.0, 9.0, -8.0, 7.0, 5.0));
	block.var[0][1] = (mat2x3(-1.0, -9.0, 0.0, 8.0, 1.0, -7.0));
	block.var[0][2] = (mat2x3(2.0, 4.0, -8.0, 4.0, 4.0, -4.0));
	block.var[1][0] = (mat2x3(3.0, 7.0, -5.0, -6.0, 7.0, 3.0));
	block.var[1][1] = (mat2x3(8.0, -7.0, -7.0, -6.0, 2.0, -8.0));
	block.var[1][2] = (mat2x3(8.0, -7.0, -2.0, 5.0, 7.0, 4.0));
	block.var[2][0] = (mat2x3(-7.0, -7.0, 6.0, -8.0, -8.0, 7.0));
	block.var[2][1] = (mat2x3(-8.0, 4.0, 7.0, 0.0, 3.0, 9.0));
	block.var[2][2] = (mat2x3(4.0, 7.0, 4.0, -7.0, 6.0, 1.0));
	block.var[3][0] = (mat2x3(3.0, 2.0, -1.0, -8.0, -8.0, 2.0));
	block.var[3][1] = (mat2x3(9.0, -3.0, -1.0, -2.0, -1.0, -1.0));
	block.var[3][2] = (mat2x3(8.0, 1.0, -6.0, -9.0, -3.0, -1.0));
}
#version 450
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
	allOk = compare_float((block.padding), -7.0) && allOk;
	allOk = compare_mat2x4(block.var[0][0], mat2x4(-7.0, -8.0, 1.0, -7.0, 8.0, 3.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1], mat2x4(3.0, -9.0, -2.0, -1.0, 3.0, -5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2], mat2x4(-2.0, 8.0, -6.0, 4.0, 6.0, -4.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0], mat2x4(2.0, -7.0, -5.0, 3.0, -1.0, -1.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1], mat2x4(8.0, -7.0, 1.0, -3.0, -9.0, 1.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2], mat2x4(2.0, 5.0, 6.0, -5.0, -1.0, 0.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0], mat2x4(0.0, -1.0, -8.0, 6.0, 2.0, -8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1], mat2x4(-3.0, -4.0, -5.0, 2.0, -2.0, -4.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2], mat2x4(2.0, 3.0, 5.0, 4.0, -7.0, 8.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0], mat2x4(-7.0, 7.0, 2.0, -8.0, 0.0, -4.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1], mat2x4(-1.0, -7.0, 8.0, 8.0, -7.0, -5.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][2], mat2x4(9.0, -7.0, -6.0, 1.0, 0.0, -6.0, -2.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (4.0);
	block.var[0][0] = (mat2x4(5.0, -4.0, -9.0, -9.0, 9.0, 1.0, 2.0, 5.0));
	block.var[0][1] = (mat2x4(5.0, -1.0, -3.0, -2.0, -4.0, -4.0, 8.0, 8.0));
	block.var[0][2] = (mat2x4(3.0, 1.0, -6.0, 2.0, 2.0, 5.0, 4.0, -3.0));
	block.var[1][0] = (mat2x4(-6.0, -3.0, -2.0, -9.0, 4.0, 7.0, -8.0, -6.0));
	block.var[1][1] = (mat2x4(2.0, 7.0, 4.0, -7.0, 7.0, 6.0, -2.0, -8.0));
	block.var[1][2] = (mat2x4(-9.0, -3.0, 5.0, -6.0, 4.0, 3.0, -6.0, -5.0));
	block.var[2][0] = (mat2x4(-9.0, 1.0, -2.0, -6.0, 8.0, 2.0, 0.0, 0.0));
	block.var[2][1] = (mat2x4(-1.0, -3.0, -3.0, -9.0, 6.0, 7.0, -2.0, 7.0));
	block.var[2][2] = (mat2x4(-1.0, 9.0, 0.0, 7.0, -5.0, 9.0, -1.0, 6.0));
	block.var[3][0] = (mat2x4(1.0, -8.0, -4.0, -9.0, -8.0, -2.0, 3.0, -7.0));
	block.var[3][1] = (mat2x4(5.0, 7.0, 7.0, -3.0, 0.0, -8.0, -1.0, 1.0));
	block.var[3][2] = (mat2x4(-3.0, 0.0, -4.0, 5.0, -9.0, 2.0, -9.0, 8.0));
}
#version 450
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
	allOk = compare_float((block.padding), 3.0) && allOk;
	allOk = compare_mat4x3(block.var[0][0], mat4x3(6.0, 1.0, -6.0, -9.0, -8.0, 6.0, 4.0, 5.0, -6.0, -1.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1], mat4x3(1.0, 2.0, 9.0, 3.0, 1.0, 1.0, 7.0, -1.0, 8.0, 1.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2], mat4x3(4.0, 5.0, -9.0, 2.0, 0.0, -9.0, -2.0, 1.0, -7.0, -4.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0], mat4x3(-5.0, -5.0, 8.0, -6.0, 8.0, -7.0, -4.0, -1.0, 2.0, -4.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1], mat4x3(8.0, 5.0, 8.0, -2.0, 2.0, -5.0, -4.0, -3.0, 8.0, -8.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2], mat4x3(-4.0, 3.0, -9.0, 7.0, 8.0, -7.0, -7.0, 6.0, -2.0, -1.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0], mat4x3(0.0, 6.0, -2.0, 7.0, 3.0, 6.0, -7.0, 3.0, -8.0, -4.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1], mat4x3(0.0, -7.0, 9.0, -7.0, -6.0, -5.0, 2.0, 8.0, 6.0, 1.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2], mat4x3(-1.0, -6.0, 5.0, 6.0, -1.0, -1.0, -3.0, -1.0, 5.0, -7.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0], mat4x3(6.0, 4.0, 7.0, 3.0, -8.0, 0.0, 3.0, -4.0, 2.0, 8.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1], mat4x3(-4.0, 3.0, 9.0, 2.0, 9.0, 2.0, -5.0, -7.0, -1.0, 6.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][2], mat4x3(-7.0, 9.0, -8.0, -1.0, 0.0, 5.0, 6.0, 4.0, -7.0, -8.0, 9.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (1.0);
	block.var[0][0][0] = (vec3(2.0, -5.0, -3.0));
	block.var[0][0][1] = (vec3(-2.0, 2.0, -5.0));
	block.var[0][0][2] = (vec3(9.0, 4.0, 2.0));
	block.var[0][0][3] = (vec3(-4.0, 9.0, 8.0));
	block.var[0][1][0] = (vec3(-4.0, -5.0, -5.0));
	block.var[0][1][1] = (vec3(6.0, 8.0, -7.0));
	block.var[0][1][2] = (vec3(4.0, -8.0, -1.0));
	block.var[0][1][3] = (vec3(1.0, 1.0, -4.0));
	block.var[0][2][0] = (vec3(5.0, 7.0, 9.0));
	block.var[0][2][1] = (vec3(5.0, -7.0, 8.0));
	block.var[0][2][2] = (vec3(9.0, 0.0, -3.0));
	block.var[0][2][3] = (vec3(3.0, 0.0, 7.0));
	block.var[1][0][0] = (vec3(-8.0, -7.0, 2.0));
	block.var[1][0][1] = (vec3(7.0, 5.0, 5.0));
	block.var[1][0][2] = (vec3(-7.0, 0.0, -2.0));
	block.var[1][0][3] = (vec3(9.0, -7.0, 2.0));
	block.var[1][1][0] = (vec3(-9.0, 0.0, 9.0));
	block.var[1][1][1] = (vec3(-2.0, -8.0, -9.0));
	block.var[1][1][2] = (vec3(5.0, 9.0, 0.0));
	block.var[1][1][3] = (vec3(8.0, -9.0, 2.0));
	block.var[1][2][0] = (vec3(1.0, -7.0, -7.0));
	block.var[1][2][1] = (vec3(8.0, 7.0, 8.0));
	block.var[1][2][2] = (vec3(-8.0, -5.0, 5.0));
	block.var[1][2][3] = (vec3(1.0, -3.0, 2.0));
	block.var[2][0][0] = (vec3(5.0, 2.0, 2.0));
	block.var[2][0][1] = (vec3(3.0, -2.0, 5.0));
	block.var[2][0][2] = (vec3(4.0, 6.0, -1.0));
	block.var[2][0][3] = (vec3(5.0, 6.0, 1.0));
	block.var[2][1][0] = (vec3(2.0, -4.0, 9.0));
	block.var[2][1][1] = (vec3(-1.0, 6.0, 9.0));
	block.var[2][1][2] = (vec3(-1.0, -2.0, -1.0));
	block.var[2][1][3] = (vec3(-8.0, 3.0, -4.0));
	block.var[2][2][0] = (vec3(1.0, -4.0, 4.0));
	block.var[2][2][1] = (vec3(2.0, 0.0, 1.0));
	block.var[2][2][2] = (vec3(-6.0, 1.0, -7.0));
	block.var[2][2][3] = (vec3(-9.0, 8.0, 1.0));
	block.var[3][0][0] = (vec3(9.0, -4.0, 1.0));
	block.var[3][0][1] = (vec3(-5.0, 9.0, 2.0));
	block.var[3][0][2] = (vec3(-1.0, -1.0, 5.0));
	block.var[3][0][3] = (vec3(7.0, -4.0, -2.0));
	block.var[3][1][0] = (vec3(9.0, -4.0, -4.0));
	block.var[3][1][1] = (vec3(4.0, -1.0, 0.0));
	block.var[3][1][2] = (vec3(7.0, 9.0, -8.0));
	block.var[3][1][3] = (vec3(3.0, 9.0, -7.0));
	block.var[3][2][0] = (vec3(-1.0, -9.0, -7.0));
	block.var[3][2][1] = (vec3(3.0, 5.0, -7.0));
	block.var[3][2][2] = (vec3(1.0, -1.0, -5.0));
	block.var[3][2][3] = (vec3(-7.0, 7.0, -5.0));
}
#version 450
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
	highp ivec2 var[4][2][3];
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
	allOk = compare_ivec2((block.var[0][0][2]), ivec2(-8, 8)) && allOk;
	allOk = compare_ivec2((block.var[0][1][0]), ivec2(-4, 1)) && allOk;
	allOk = compare_ivec2((block.var[0][1][1]), ivec2(-3, -1)) && allOk;
	allOk = compare_ivec2((block.var[0][1][2]), ivec2(2, 1)) && allOk;
	allOk = compare_ivec2((block.var[1][0][0]), ivec2(-2, -6)) && allOk;
	allOk = compare_ivec2((block.var[1][0][1]), ivec2(6, 2)) && allOk;
	allOk = compare_ivec2((block.var[1][0][2]), ivec2(-2, 7)) && allOk;
	allOk = compare_ivec2((block.var[1][1][0]), ivec2(-4, -3)) && allOk;
	allOk = compare_ivec2((block.var[1][1][1]), ivec2(-9, 0)) && allOk;
	allOk = compare_ivec2((block.var[1][1][2]), ivec2(9, 8)) && allOk;
	allOk = compare_ivec2((block.var[2][0][0]), ivec2(-1, -1)) && allOk;
	allOk = compare_ivec2((block.var[2][0][1]), ivec2(0, 8)) && allOk;
	allOk = compare_ivec2((block.var[2][0][2]), ivec2(-9, -5)) && allOk;
	allOk = compare_ivec2((block.var[2][1][0]), ivec2(6, 3)) && allOk;
	allOk = compare_ivec2((block.var[2][1][1]), ivec2(-5, -3)) && allOk;
	allOk = compare_ivec2((block.var[2][1][2]), ivec2(-4, 7)) && allOk;
	allOk = compare_ivec2((block.var[3][0][0]), ivec2(6, 4)) && allOk;
	allOk = compare_ivec2((block.var[3][0][1]), ivec2(-8, 3)) && allOk;
	allOk = compare_ivec2((block.var[3][0][2]), ivec2(7, -6)) && allOk;
	allOk = compare_ivec2((block.var[3][1][0]), ivec2(-3, -4)) && allOk;
	allOk = compare_ivec2((block.var[3][1][1]), ivec2(8, -5)) && allOk;
	allOk = compare_ivec2((block.var[3][1][2]), ivec2(-2, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (ivec2(-6, 8));
	block.var[0][0][1] = (ivec2(3, -1));
	block.var[0][0][2] = (ivec2(-5, -2));
	block.var[0][1][0] = (ivec2(4, 1));
	block.var[0][1][1] = (ivec2(1, 9));
	block.var[0][1][2] = (ivec2(-2, -9));
	block.var[1][0][0] = (ivec2(0, -2));
	block.var[1][0][1] = (ivec2(5, 2));
	block.var[1][0][2] = (ivec2(-8, 4));
	block.var[1][1][0] = (ivec2(9, 6));
	block.var[1][1][1] = (ivec2(-8, 1));
	block.var[1][1][2] = (ivec2(-3, 2));
	block.var[2][0][0] = (ivec2(-6, -4));
	block.var[2][0][1] = (ivec2(3, -2));
	block.var[2][0][2] = (ivec2(5, -7));
	block.var[2][1][0] = (ivec2(-3, -1));
	block.var[2][1][1] = (ivec2(-4, 6));
	block.var[2][1][2] = (ivec2(-4, -7));
	block.var[3][0][0] = (ivec2(-3, 4));
	block.var[3][0][1] = (ivec2(1, 6));
	block.var[3][0][2] = (ivec2(8, 7));
	block.var[3][1][0] = (ivec2(-9, 1));
	block.var[3][1][1] = (ivec2(8, 1));
	block.var[3][1][2] = (ivec2(-8, 3));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(-2.0, -4.0, -6.0, 5.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(2.0, 5.0, 9.0, -1.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][2], mat3x2(-6.0, -2.0, -3.0, 2.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(-5.0, -1.0, -4.0, 9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(1.0, -6.0, -3.0, -3.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][2], mat3x2(1.0, 7.0, 5.0, -5.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(-8.0, -4.0, -9.0, 9.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(0.0, 4.0, -7.0, -7.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][2], mat3x2(7.0, 1.0, 4.0, 8.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(-8.0, -9.0, 7.0, 4.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(8.0, -6.0, -5.0, -7.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][2], mat3x2(3.0, 2.0, -1.0, -1.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(-5.0, 4.0, 3.0, -8.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(4.0, -7.0, -6.0, 9.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][2], mat3x2(3.0, 0.0, -6.0, 7.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(-1.0, 2.0, -7.0, 2.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(-2.0, -2.0, 5.0, 6.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][2], mat3x2(-4.0, 6.0, -8.0, 8.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][0], mat3x2(-1.0, 5.0, -6.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][1], mat3x2(-4.0, 8.0, 9.0, -3.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][2], mat3x2(-8.0, -9.0, -6.0, -9.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][0], mat3x2(-9.0, 5.0, -9.0, 0.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][1], mat3x2(3.0, -5.0, -4.0, -3.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][2], mat3x2(-2.0, 7.0, 6.0, 6.0, 3.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3x2(2.0, -1.0, 2.0, -8.0, -4.0, 9.0));
	block.var[0][0][1] = (mat3x2(6.0, 8.0, 5.0, -7.0, -7.0, 0.0));
	block.var[0][0][2] = (mat3x2(5.0, 8.0, 1.0, -4.0, 1.0, 3.0));
	block.var[0][1][0] = (mat3x2(-6.0, -4.0, 8.0, 4.0, 5.0, 4.0));
	block.var[0][1][1] = (mat3x2(8.0, 3.0, 9.0, -4.0, -3.0, -6.0));
	block.var[0][1][2] = (mat3x2(-9.0, 8.0, 6.0, -7.0, 9.0, 2.0));
	block.var[1][0][0] = (mat3x2(0.0, -6.0, -9.0, 0.0, 8.0, 7.0));
	block.var[1][0][1] = (mat3x2(7.0, -7.0, 8.0, -7.0, -8.0, 9.0));
	block.var[1][0][2] = (mat3x2(-5.0, -9.0, -9.0, -4.0, 7.0, 7.0));
	block.var[1][1][0] = (mat3x2(-2.0, -3.0, -2.0, -4.0, 5.0, -4.0));
	block.var[1][1][1] = (mat3x2(9.0, -9.0, -9.0, -6.0, 8.0, 1.0));
	block.var[1][1][2] = (mat3x2(4.0, -2.0, 0.0, -9.0, 4.0, -2.0));
	block.var[2][0][0] = (mat3x2(3.0, -9.0, -7.0, 4.0, -8.0, -2.0));
	block.var[2][0][1] = (mat3x2(9.0, -1.0, 9.0, 7.0, 0.0, 3.0));
	block.var[2][0][2] = (mat3x2(-6.0, 5.0, -8.0, 1.0, 9.0, 5.0));
	block.var[2][1][0] = (mat3x2(3.0, 2.0, 8.0, -9.0, -3.0, -7.0));
	block.var[2][1][1] = (mat3x2(0.0, -5.0, -2.0, -1.0, -6.0, -9.0));
	block.var[2][1][2] = (mat3x2(-7.0, 8.0, 6.0, 5.0, -3.0, 0.0));
	block.var[3][0][0] = (mat3x2(-4.0, -3.0, -2.0, 3.0, -1.0, 1.0));
	block.var[3][0][1] = (mat3x2(-9.0, 4.0, 5.0, -3.0, 8.0, 4.0));
	block.var[3][0][2] = (mat3x2(8.0, -4.0, -8.0, 7.0, -4.0, 9.0));
	block.var[3][1][0] = (mat3x2(7.0, 4.0, 0.0, 5.0, 7.0, -2.0));
	block.var[3][1][1] = (mat3x2(-2.0, 8.0, -3.0, 4.0, 5.0, -1.0));
	block.var[3][1][2] = (mat3x2(-4.0, 3.0, 7.0, -8.0, 7.0, 3.0));
}
#version 450
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
	allOk = compare_float((block.padding), 2.0) && allOk;
	allOk = compare_mat3(block.var[0][0][0], mat3(-3.0, 4.0, 5.0, -1.0, 7.0, 7.0, 0.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(-3.0, 0.0, -1.0, -5.0, 6.0, 9.0, 4.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][2], mat3(8.0, 3.0, -2.0, -1.0, 8.0, -2.0, 4.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(5.0, -5.0, 9.0, 1.0, 1.0, 5.0, 9.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(5.0, 4.0, 8.0, -9.0, 9.0, 2.0, 8.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][2], mat3(-2.0, -4.0, 3.0, 5.0, -9.0, 0.0, 8.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(-3.0, -4.0, 7.0, -1.0, 9.0, -7.0, 8.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(5.0, -2.0, 0.0, 7.0, -3.0, 1.0, -6.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][2], mat3(8.0, -9.0, -1.0, -4.0, 4.0, -3.0, 9.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(-4.0, -9.0, 0.0, 9.0, -3.0, 0.0, 0.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(-6.0, -1.0, -4.0, 8.0, -3.0, 3.0, -2.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][2], mat3(-8.0, 2.0, -4.0, -7.0, 7.0, 3.0, 2.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(2.0, -6.0, -2.0, -2.0, 3.0, -5.0, 8.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(-9.0, -5.0, 8.0, -7.0, 2.0, -9.0, 0.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][2], mat3(5.0, 4.0, 9.0, 7.0, 8.0, -2.0, 6.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(-8.0, -2.0, -1.0, 8.0, 3.0, 0.0, 2.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(1.0, -4.0, 4.0, 2.0, -7.0, 2.0, 4.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][2], mat3(8.0, 7.0, 0.0, 8.0, -5.0, -5.0, -1.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][0], mat3(-1.0, 6.0, 0.0, -2.0, -1.0, -1.0, -6.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][1], mat3(-4.0, -9.0, 2.0, 5.0, 1.0, -1.0, 1.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][2], mat3(1.0, 2.0, 2.0, -5.0, 1.0, -1.0, 9.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][0], mat3(8.0, -8.0, 8.0, -5.0, -1.0, -1.0, -1.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][1], mat3(6.0, -6.0, -5.0, 2.0, 5.0, 7.0, -3.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][2], mat3(1.0, 5.0, 9.0, 2.0, -4.0, -8.0, 5.0, 6.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (3.0);
	block.var[0][0][0][0] = (vec3(2.0, 4.0, 6.0));
	block.var[0][0][0][1] = (vec3(2.0, -9.0, 0.0));
	block.var[0][0][0][2] = (vec3(-9.0, 3.0, -7.0));
	block.var[0][0][1][0] = (vec3(-4.0, -4.0, 5.0));
	block.var[0][0][1][1] = (vec3(-4.0, 1.0, -7.0));
	block.var[0][0][1][2] = (vec3(3.0, -3.0, 7.0));
	block.var[0][0][2][0] = (vec3(8.0, 2.0, 5.0));
	block.var[0][0][2][1] = (vec3(-9.0, 7.0, -2.0));
	block.var[0][0][2][2] = (vec3(9.0, -7.0, -7.0));
	block.var[0][1][0][0] = (vec3(8.0, -5.0, 4.0));
	block.var[0][1][0][1] = (vec3(1.0, -7.0, 3.0));
	block.var[0][1][0][2] = (vec3(1.0, -4.0, -3.0));
	block.var[0][1][1][0] = (vec3(8.0, 1.0, -8.0));
	block.var[0][1][1][1] = (vec3(5.0, 9.0, -2.0));
	block.var[0][1][1][2] = (vec3(-3.0, 6.0, 4.0));
	block.var[0][1][2][0] = (vec3(-6.0, 5.0, -4.0));
	block.var[0][1][2][1] = (vec3(5.0, -3.0, 3.0));
	block.var[0][1][2][2] = (vec3(-7.0, 4.0, 8.0));
	block.var[1][0][0][0] = (vec3(-1.0, 1.0, 0.0));
	block.var[1][0][0][1] = (vec3(7.0, 7.0, 9.0));
	block.var[1][0][0][2] = (vec3(3.0, 4.0, 4.0));
	block.var[1][0][1][0] = (vec3(9.0, 1.0, -6.0));
	block.var[1][0][1][1] = (vec3(7.0, -6.0, -1.0));
	block.var[1][0][1][2] = (vec3(4.0, -3.0, -5.0));
	block.var[1][0][2][0] = (vec3(-8.0, -9.0, 6.0));
	block.var[1][0][2][1] = (vec3(2.0, -2.0, -7.0));
	block.var[1][0][2][2] = (vec3(-2.0, -7.0, 6.0));
	block.var[1][1][0][0] = (vec3(6.0, 5.0, 1.0));
	block.var[1][1][0][1] = (vec3(7.0, 9.0, 0.0));
	block.var[1][1][0][2] = (vec3(6.0, 1.0, -7.0));
	block.var[1][1][1][0] = (vec3(4.0, -8.0, -8.0));
	block.var[1][1][1][1] = (vec3(8.0, 9.0, -9.0));
	block.var[1][1][1][2] = (vec3(8.0, 6.0, -8.0));
	block.var[1][1][2][0] = (vec3(4.0, -6.0, -4.0));
	block.var[1][1][2][1] = (vec3(-6.0, 0.0, 0.0));
	block.var[1][1][2][2] = (vec3(-3.0, -7.0, -3.0));
	block.var[2][0][0][0] = (vec3(9.0, 2.0, -4.0));
	block.var[2][0][0][1] = (vec3(-9.0, -5.0, 4.0));
	block.var[2][0][0][2] = (vec3(-2.0, -1.0, -1.0));
	block.var[2][0][1][0] = (vec3(-1.0, 3.0, 0.0));
	block.var[2][0][1][1] = (vec3(-7.0, 1.0, -6.0));
	block.var[2][0][1][2] = (vec3(-6.0, 9.0, 0.0));
	block.var[2][0][2][0] = (vec3(8.0, 6.0, 4.0));
	block.var[2][0][2][1] = (vec3(7.0, -4.0, 4.0));
	block.var[2][0][2][2] = (vec3(-6.0, 0.0, -6.0));
	block.var[2][1][0][0] = (vec3(-2.0, 3.0, -3.0));
	block.var[2][1][0][1] = (vec3(-1.0, 5.0, -8.0));
	block.var[2][1][0][2] = (vec3(-9.0, 1.0, 3.0));
	block.var[2][1][1][0] = (vec3(-7.0, -8.0, -8.0));
	block.var[2][1][1][1] = (vec3(-6.0, 2.0, -1.0));
	block.var[2][1][1][2] = (vec3(-4.0, 8.0, 5.0));
	block.var[2][1][2][0] = (vec3(-4.0, -5.0, 5.0));
	block.var[2][1][2][1] = (vec3(-6.0, 8.0, -7.0));
	block.var[2][1][2][2] = (vec3(1.0, 3.0, 0.0));
	block.var[3][0][0][0] = (vec3(0.0, -8.0, 6.0));
	block.var[3][0][0][1] = (vec3(-7.0, -2.0, 7.0));
	block.var[3][0][0][2] = (vec3(3.0, -3.0, 4.0));
	block.var[3][0][1][0] = (vec3(-6.0, 7.0, 1.0));
	block.var[3][0][1][1] = (vec3(6.0, 3.0, 0.0));
	block.var[3][0][1][2] = (vec3(-8.0, 1.0, -2.0));
	block.var[3][0][2][0] = (vec3(1.0, 3.0, 4.0));
	block.var[3][0][2][1] = (vec3(5.0, -3.0, -6.0));
	block.var[3][0][2][2] = (vec3(-9.0, 9.0, -7.0));
	block.var[3][1][0][0] = (vec3(-3.0, -5.0, 3.0));
	block.var[3][1][0][1] = (vec3(-3.0, -4.0, -7.0));
	block.var[3][1][0][2] = (vec3(-1.0, -9.0, -5.0));
	block.var[3][1][1][0] = (vec3(-3.0, -1.0, -3.0));
	block.var[3][1][1][1] = (vec3(3.0, 3.0, 9.0));
	block.var[3][1][1][2] = (vec3(4.0, -6.0, -6.0));
	block.var[3][1][2][0] = (vec3(5.0, 6.0, 7.0));
	block.var[3][1][2][1] = (vec3(-1.0, -3.0, -3.0));
	block.var[3][1][2][2] = (vec3(-4.0, -5.0, -1.0));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
{
	bvec2 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((block.var[0][0][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[0][0][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[0][1][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[0][1][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[0][2][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[0][2][1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[0][3][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[0][3][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[1][0][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[1][0][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[1][1][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[1][1][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[1][2][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[1][2][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[1][3][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[1][3][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[2][0][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[2][0][1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((block.var[2][1][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[2][1][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[2][2][0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((block.var[2][2][1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((block.var[2][3][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[2][3][1]), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (bvec2(true, false));
	block.var[0][0][1] = (bvec2(true, true));
	block.var[0][1][0] = (bvec2(false, false));
	block.var[0][1][1] = (bvec2(false, true));
	block.var[0][2][0] = (bvec2(false, true));
	block.var[0][2][1] = (bvec2(true, true));
	block.var[0][3][0] = (bvec2(true, false));
	block.var[0][3][1] = (bvec2(true, false));
	block.var[1][0][0] = (bvec2(false, false));
	block.var[1][0][1] = (bvec2(false, false));
	block.var[1][1][0] = (bvec2(true, true));
	block.var[1][1][1] = (bvec2(false, false));
	block.var[1][2][0] = (bvec2(false, false));
	block.var[1][2][1] = (bvec2(true, true));
	block.var[1][3][0] = (bvec2(true, false));
	block.var[1][3][1] = (bvec2(false, false));
	block.var[2][0][0] = (bvec2(false, true));
	block.var[2][0][1] = (bvec2(true, true));
	block.var[2][1][0] = (bvec2(true, false));
	block.var[2][1][1] = (bvec2(true, false));
	block.var[2][2][0] = (bvec2(true, false));
	block.var[2][2][1] = (bvec2(false, false));
	block.var[2][3][0] = (bvec2(false, false));
	block.var[2][3][1] = (bvec2(false, true));
}
#version 450
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
	allOk = compare_mat2(block.var[0][0][0], mat2(-7.0, -2.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(0.0, 4.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(2.0, -7.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(-7.0, 8.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[0][2][0], mat2(-8.0, 7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[0][2][1], mat2(-8.0, 1.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[0][3][0], mat2(4.0, 4.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[0][3][1], mat2(-3.0, -7.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(-2.0, -1.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(6.0, -4.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(3.0, -1.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(2.0, -7.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[1][2][0], mat2(-3.0, -8.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[1][2][1], mat2(5.0, -3.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[1][3][0], mat2(5.0, -7.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[1][3][1], mat2(-3.0, -7.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(3.0, 2.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(8.0, -3.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(1.0, 7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(-5.0, -4.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[2][2][0], mat2(-9.0, 0.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[2][2][1], mat2(9.0, 6.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[2][3][0], mat2(6.0, -2.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[2][3][1], mat2(2.0, 7.0, 8.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2(1.0, 2.0, 6.0, -6.0));
	block.var[0][0][1] = (mat2(2.0, 4.0, 4.0, 7.0));
	block.var[0][1][0] = (mat2(1.0, -8.0, -9.0, -7.0));
	block.var[0][1][1] = (mat2(1.0, -2.0, -6.0, -8.0));
	block.var[0][2][0] = (mat2(5.0, 1.0, -7.0, -2.0));
	block.var[0][2][1] = (mat2(-8.0, -9.0, 4.0, -4.0));
	block.var[0][3][0] = (mat2(9.0, 4.0, -3.0, -3.0));
	block.var[0][3][1] = (mat2(0.0, -1.0, -5.0, -6.0));
	block.var[1][0][0] = (mat2(0.0, 8.0, 0.0, -1.0));
	block.var[1][0][1] = (mat2(8.0, -4.0, -5.0, 7.0));
	block.var[1][1][0] = (mat2(-6.0, -6.0, 2.0, -9.0));
	block.var[1][1][1] = (mat2(9.0, 0.0, -3.0, -7.0));
	block.var[1][2][0] = (mat2(-7.0, -9.0, -5.0, 3.0));
	block.var[1][2][1] = (mat2(-1.0, -1.0, -6.0, -3.0));
	block.var[1][3][0] = (mat2(-8.0, 0.0, 8.0, 8.0));
	block.var[1][3][1] = (mat2(-3.0, -9.0, 5.0, -2.0));
	block.var[2][0][0] = (mat2(-3.0, -1.0, 0.0, 6.0));
	block.var[2][0][1] = (mat2(-6.0, 7.0, 4.0, -7.0));
	block.var[2][1][0] = (mat2(8.0, 8.0, 7.0, -3.0));
	block.var[2][1][1] = (mat2(7.0, 2.0, -8.0, -7.0));
	block.var[2][2][0] = (mat2(-9.0, -4.0, -8.0, -1.0));
	block.var[2][2][1] = (mat2(-8.0, 1.0, -2.0, 9.0));
	block.var[2][3][0] = (mat2(1.0, 9.0, -3.0, -5.0));
	block.var[2][3][1] = (mat2(-3.0, 5.0, 0.0, -9.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0][0][0], mat2x3(1.0, -3.0, 8.0, -6.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][1], mat2x3(4.0, -9.0, -8.0, -2.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][0], mat2x3(1.0, 7.0, 8.0, -2.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][1], mat2x3(-8.0, -9.0, -2.0, 7.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2][0], mat2x3(-8.0, -8.0, 8.0, -4.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2][1], mat2x3(-5.0, 9.0, -6.0, 9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][3][0], mat2x3(9.0, -9.0, 3.0, -4.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][3][1], mat2x3(-6.0, 0.0, -2.0, 2.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][0], mat2x3(-7.0, -2.0, 0.0, -6.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][1], mat2x3(0.0, -5.0, -8.0, -2.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][0], mat2x3(-5.0, -5.0, 6.0, 2.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][1], mat2x3(7.0, 0.0, 2.0, 4.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2][0], mat2x3(4.0, 2.0, 6.0, 8.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2][1], mat2x3(-3.0, 7.0, -7.0, -6.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][3][0], mat2x3(-1.0, -5.0, 0.0, -2.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][3][1], mat2x3(1.0, -6.0, -2.0, -1.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][0], mat2x3(8.0, 5.0, -3.0, -8.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][1], mat2x3(-6.0, -2.0, 1.0, -3.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][0], mat2x3(4.0, -9.0, 5.0, 3.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][1], mat2x3(1.0, 5.0, -6.0, 4.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2][0], mat2x3(-6.0, -9.0, -2.0, 1.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2][1], mat2x3(8.0, -6.0, -6.0, -3.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][3][0], mat2x3(-2.0, 3.0, 0.0, -6.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][3][1], mat2x3(0.0, 5.0, 8.0, -1.0, 9.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec3(-7.0, -8.0, 7.0));
	block.var[0][0][0][1] = (vec3(-6.0, -3.0, -4.0));
	block.var[0][0][1][0] = (vec3(3.0, -8.0, -9.0));
	block.var[0][0][1][1] = (vec3(-2.0, 5.0, 6.0));
	block.var[0][1][0][0] = (vec3(-6.0, 3.0, 9.0));
	block.var[0][1][0][1] = (vec3(3.0, -2.0, -9.0));
	block.var[0][1][1][0] = (vec3(-7.0, -8.0, -6.0));
	block.var[0][1][1][1] = (vec3(-7.0, 2.0, -3.0));
	block.var[0][2][0][0] = (vec3(5.0, 5.0, -4.0));
	block.var[0][2][0][1] = (vec3(1.0, -9.0, 1.0));
	block.var[0][2][1][0] = (vec3(3.0, 0.0, -6.0));
	block.var[0][2][1][1] = (vec3(5.0, -6.0, -6.0));
	block.var[0][3][0][0] = (vec3(1.0, -4.0, 2.0));
	block.var[0][3][0][1] = (vec3(0.0, 1.0, -8.0));
	block.var[0][3][1][0] = (vec3(-3.0, -9.0, 6.0));
	block.var[0][3][1][1] = (vec3(-3.0, 6.0, 6.0));
	block.var[1][0][0][0] = (vec3(6.0, -5.0, -7.0));
	block.var[1][0][0][1] = (vec3(1.0, 1.0, -3.0));
	block.var[1][0][1][0] = (vec3(9.0, -7.0, 2.0));
	block.var[1][0][1][1] = (vec3(5.0, -4.0, 6.0));
	block.var[1][1][0][0] = (vec3(1.0, -1.0, 8.0));
	block.var[1][1][0][1] = (vec3(7.0, -2.0, -6.0));
	block.var[1][1][1][0] = (vec3(-1.0, -1.0, -5.0));
	block.var[1][1][1][1] = (vec3(-1.0, 1.0, -1.0));
	block.var[1][2][0][0] = (vec3(7.0, 1.0, -9.0));
	block.var[1][2][0][1] = (vec3(7.0, -8.0, -1.0));
	block.var[1][2][1][0] = (vec3(5.0, -3.0, 9.0));
	block.var[1][2][1][1] = (vec3(-6.0, 4.0, -4.0));
	block.var[1][3][0][0] = (vec3(-6.0, 1.0, 4.0));
	block.var[1][3][0][1] = (vec3(7.0, 9.0, -9.0));
	block.var[1][3][1][0] = (vec3(-1.0, -8.0, 8.0));
	block.var[1][3][1][1] = (vec3(7.0, 1.0, -4.0));
	block.var[2][0][0][0] = (vec3(-3.0, -8.0, 6.0));
	block.var[2][0][0][1] = (vec3(8.0, 2.0, 4.0));
	block.var[2][0][1][0] = (vec3(0.0, 8.0, 0.0));
	block.var[2][0][1][1] = (vec3(-2.0, 1.0, -3.0));
	block.var[2][1][0][0] = (vec3(5.0, 5.0, -6.0));
	block.var[2][1][0][1] = (vec3(6.0, 7.0, -2.0));
	block.var[2][1][1][0] = (vec3(-5.0, -7.0, -1.0));
	block.var[2][1][1][1] = (vec3(4.0, -3.0, -7.0));
	block.var[2][2][0][0] = (vec3(2.0, 5.0, 0.0));
	block.var[2][2][0][1] = (vec3(1.0, -8.0, 0.0));
	block.var[2][2][1][0] = (vec3(7.0, -2.0, -7.0));
	block.var[2][2][1][1] = (vec3(-6.0, -5.0, 3.0));
	block.var[2][3][0][0] = (vec3(-3.0, 5.0, -5.0));
	block.var[2][3][0][1] = (vec3(4.0, 1.0, 9.0));
	block.var[2][3][1][0] = (vec3(3.0, -8.0, 6.0));
	block.var[2][3][1][1] = (vec3(-7.0, -7.0, -1.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0][0][0], mat2(-5.0, -2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(-2.0, -4.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(9.0, 8.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(-1.0, -8.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[0][2][0], mat2(7.0, 8.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[0][2][1], mat2(9.0, 8.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[0][3][0], mat2(4.0, -9.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[0][3][1], mat2(-1.0, 9.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(-9.0, 9.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(8.0, -3.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(8.0, -4.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(3.0, 3.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[1][2][0], mat2(3.0, 3.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[1][2][1], mat2(-3.0, -8.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[1][3][0], mat2(5.0, 3.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[1][3][1], mat2(7.0, -4.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(9.0, -8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(8.0, -2.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(0.0, -3.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(8.0, -5.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[2][2][0], mat2(6.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[2][2][1], mat2(-2.0, -9.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[2][3][0], mat2(-5.0, 9.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[2][3][1], mat2(9.0, 2.0, 3.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2(-2.0, -8.0, -7.0, 9.0));
	block.var[0][0][1] = (mat2(2.0, 2.0, -4.0, -5.0));
	block.var[0][1][0] = (mat2(5.0, -3.0, -3.0, 6.0));
	block.var[0][1][1] = (mat2(-4.0, -6.0, -2.0, -6.0));
	block.var[0][2][0] = (mat2(5.0, 7.0, 7.0, -8.0));
	block.var[0][2][1] = (mat2(7.0, -9.0, -2.0, 4.0));
	block.var[0][3][0] = (mat2(-8.0, 1.0, -1.0, -3.0));
	block.var[0][3][1] = (mat2(6.0, -9.0, -7.0, 6.0));
	block.var[1][0][0] = (mat2(-1.0, -4.0, 0.0, -1.0));
	block.var[1][0][1] = (mat2(0.0, 4.0, -3.0, -4.0));
	block.var[1][1][0] = (mat2(-3.0, -4.0, -7.0, -9.0));
	block.var[1][1][1] = (mat2(8.0, 2.0, -6.0, 9.0));
	block.var[1][2][0] = (mat2(3.0, 3.0, 3.0, -6.0));
	block.var[1][2][1] = (mat2(-4.0, -8.0, -2.0, 5.0));
	block.var[1][3][0] = (mat2(-6.0, -2.0, 6.0, 0.0));
	block.var[1][3][1] = (mat2(-4.0, -4.0, -6.0, -7.0));
	block.var[2][0][0] = (mat2(-6.0, 0.0, 5.0, 1.0));
	block.var[2][0][1] = (mat2(-6.0, 9.0, 5.0, 9.0));
	block.var[2][1][0] = (mat2(-5.0, -2.0, 4.0, 9.0));
	block.var[2][1][1] = (mat2(4.0, 7.0, 4.0, -8.0));
	block.var[2][2][0] = (mat2(-3.0, 5.0, 0.0, -2.0));
	block.var[2][2][1] = (mat2(-3.0, 0.0, -9.0, 1.0));
	block.var[2][3][0] = (mat2(1.0, 6.0, -7.0, 7.0));
	block.var[2][3][1] = (mat2(9.0, -8.0, 3.0, -7.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0][0][0], mat3x4(-6.0, 2.0, 7.0, -8.0, 9.0, -6.0, 1.0, 9.0, -9.0, 1.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][1], mat3x4(-8.0, -5.0, -5.0, 5.0, -5.0, -3.0, 2.0, 1.0, 2.0, 8.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(2.0, 6.0, -1.0, 0.0, 8.0, 9.0, 6.0, 2.0, 2.0, 5.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(2.0, 6.0, 8.0, 7.0, -7.0, 9.0, 5.0, 7.0, 1.0, 1.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][0], mat3x4(5.0, 2.0, -1.0, 6.0, -6.0, 4.0, 2.0, 5.0, 9.0, 7.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][1], mat3x4(-2.0, -5.0, 0.0, 0.0, 2.0, 5.0, 8.0, -5.0, 7.0, 5.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][0], mat3x4(-2.0, -9.0, 2.0, -8.0, -3.0, 1.0, -5.0, 1.0, 3.0, 1.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][1], mat3x4(3.0, -7.0, -4.0, -9.0, 6.0, 5.0, 0.0, -1.0, -4.0, -3.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(3.0, 7.0, -5.0, 5.0, 6.0, -3.0, 8.0, -1.0, -1.0, -1.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(3.0, 2.0, 8.0, 7.0, 5.0, 9.0, -1.0, -1.0, -5.0, -3.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(1.0, 9.0, -1.0, -4.0, 9.0, -9.0, 9.0, 3.0, -1.0, -5.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(-1.0, 0.0, -4.0, -5.0, -8.0, 9.0, 5.0, -7.0, 6.0, -6.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][0], mat3x4(-7.0, -9.0, 9.0, 1.0, -6.0, 3.0, 9.0, 6.0, -4.0, -6.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][1], mat3x4(0.0, -4.0, 4.0, -6.0, 0.0, -7.0, -2.0, 2.0, 1.0, 2.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][0], mat3x4(-9.0, 4.0, 0.0, -9.0, 6.0, -2.0, -9.0, 9.0, 1.0, 8.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][1], mat3x4(-4.0, -7.0, 1.0, 0.0, 6.0, -8.0, 9.0, -2.0, 3.0, 4.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(4.0, -6.0, -8.0, 7.0, 0.0, -7.0, -9.0, 1.0, 0.0, -4.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(7.0, 9.0, 6.0, 6.0, 5.0, -9.0, 3.0, -1.0, -1.0, 4.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(-8.0, -3.0, -4.0, -7.0, 2.0, 4.0, 4.0, -8.0, 0.0, -9.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(-5.0, -2.0, 0.0, -8.0, -7.0, -1.0, -3.0, 0.0, 4.0, 9.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][0], mat3x4(-4.0, -6.0, -6.0, 3.0, -4.0, 7.0, -9.0, 0.0, 4.0, 0.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][1], mat3x4(-7.0, -8.0, -8.0, -8.0, 9.0, 7.0, -9.0, -6.0, -2.0, 3.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][0], mat3x4(-6.0, 3.0, 7.0, 1.0, -9.0, -5.0, 4.0, 9.0, 4.0, -7.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][1], mat3x4(-8.0, -4.0, -3.0, -5.0, -2.0, -8.0, 2.0, -1.0, 4.0, 7.0, 5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3x4(0.0, 0.0, -5.0, -3.0, -2.0, -8.0, -3.0, 0.0, -6.0, -6.0, 8.0, 5.0));
	block.var[0][0][1] = (mat3x4(8.0, 1.0, 7.0, 4.0, -7.0, -3.0, -4.0, 0.0, 6.0, 9.0, -2.0, 5.0));
	block.var[0][1][0] = (mat3x4(-2.0, -7.0, -5.0, -7.0, -6.0, 8.0, 4.0, -6.0, 5.0, 6.0, -5.0, 8.0));
	block.var[0][1][1] = (mat3x4(-8.0, 8.0, -7.0, -4.0, -6.0, -9.0, 3.0, -6.0, -1.0, -2.0, -2.0, 2.0));
	block.var[0][2][0] = (mat3x4(-7.0, 8.0, 5.0, -1.0, 0.0, 6.0, 7.0, -1.0, 3.0, 5.0, -7.0, 2.0));
	block.var[0][2][1] = (mat3x4(9.0, -2.0, -7.0, -4.0, 7.0, 9.0, 9.0, -2.0, -7.0, -3.0, 9.0, 9.0));
	block.var[0][3][0] = (mat3x4(-5.0, 9.0, -5.0, 5.0, -4.0, 7.0, 7.0, -1.0, -9.0, 8.0, 2.0, -5.0));
	block.var[0][3][1] = (mat3x4(-4.0, 4.0, -6.0, 7.0, 7.0, 0.0, -4.0, -5.0, 3.0, -2.0, -4.0, -9.0));
	block.var[1][0][0] = (mat3x4(8.0, -2.0, 7.0, 3.0, -8.0, -8.0, 5.0, -7.0, -9.0, 1.0, 9.0, -3.0));
	block.var[1][0][1] = (mat3x4(-9.0, 4.0, -1.0, 0.0, 4.0, -3.0, -5.0, -7.0, 1.0, 2.0, -2.0, -6.0));
	block.var[1][1][0] = (mat3x4(6.0, -1.0, -9.0, -5.0, -4.0, 3.0, -7.0, 1.0, 2.0, 1.0, -1.0, 6.0));
	block.var[1][1][1] = (mat3x4(5.0, 5.0, -9.0, -4.0, 9.0, -4.0, 7.0, -6.0, 2.0, 1.0, -6.0, 1.0));
	block.var[1][2][0] = (mat3x4(4.0, -7.0, 5.0, -1.0, -8.0, -1.0, -1.0, 1.0, -1.0, 6.0, 6.0, 9.0));
	block.var[1][2][1] = (mat3x4(3.0, 1.0, 7.0, 6.0, 8.0, 1.0, 8.0, -5.0, -5.0, -9.0, -1.0, -9.0));
	block.var[1][3][0] = (mat3x4(9.0, 0.0, -3.0, -8.0, 1.0, -4.0, 4.0, 3.0, 4.0, -8.0, 6.0, 7.0));
	block.var[1][3][1] = (mat3x4(-6.0, -3.0, 9.0, 1.0, -6.0, 0.0, -9.0, -9.0, -2.0, -6.0, 0.0, 2.0));
	block.var[2][0][0] = (mat3x4(3.0, 1.0, -1.0, -3.0, 5.0, 8.0, 1.0, 3.0, -9.0, 1.0, -2.0, 9.0));
	block.var[2][0][1] = (mat3x4(1.0, 5.0, 2.0, 4.0, 6.0, 3.0, 7.0, 0.0, 8.0, 8.0, -2.0, 7.0));
	block.var[2][1][0] = (mat3x4(-4.0, 7.0, -5.0, 0.0, 4.0, 0.0, 0.0, 0.0, 4.0, 0.0, -1.0, -9.0));
	block.var[2][1][1] = (mat3x4(-1.0, 3.0, -6.0, 6.0, 3.0, 8.0, 4.0, 4.0, 7.0, 8.0, 1.0, 7.0));
	block.var[2][2][0] = (mat3x4(-1.0, 6.0, 3.0, -9.0, -4.0, -5.0, 2.0, -2.0, -2.0, -2.0, -2.0, 2.0));
	block.var[2][2][1] = (mat3x4(-7.0, -4.0, 6.0, -9.0, 6.0, -3.0, -9.0, 6.0, 3.0, 2.0, -5.0, -9.0));
	block.var[2][3][0] = (mat3x4(-4.0, 1.0, 0.0, -2.0, 8.0, 2.0, 9.0, 3.0, -5.0, -2.0, -4.0, 0.0));
	block.var[2][3][1] = (mat3x4(-3.0, -7.0, -4.0, 2.0, 1.0, -7.0, 2.0, 9.0, 1.0, -1.0, -2.0, 3.0));
}
#version 450
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
	u16vec2 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(block.var[0][0][0]), uvec2(8u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[0][0][1]), uvec2(2u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[0][1][0]), uvec2(8u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[0][1][1]), uvec2(7u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[0][2][0]), uvec2(7u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[0][2][1]), uvec2(7u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[0][3][0]), uvec2(1u, 0u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[0][3][1]), uvec2(0u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[1][0][0]), uvec2(6u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[1][0][1]), uvec2(7u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[1][1][0]), uvec2(2u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[1][1][1]), uvec2(5u, 5u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[1][2][0]), uvec2(3u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[1][2][1]), uvec2(4u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[1][3][0]), uvec2(9u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[1][3][1]), uvec2(7u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[2][0][0]), uvec2(0u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[2][0][1]), uvec2(1u, 3u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[2][1][0]), uvec2(4u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[2][1][1]), uvec2(6u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[2][2][0]), uvec2(3u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[2][2][1]), uvec2(1u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[2][3][0]), uvec2(3u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[2][3][1]), uvec2(2u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = u16vec2(uvec2(8u, 0u));
	block.var[0][0][1] = u16vec2(uvec2(6u, 0u));
	block.var[0][1][0] = u16vec2(uvec2(1u, 1u));
	block.var[0][1][1] = u16vec2(uvec2(2u, 8u));
	block.var[0][2][0] = u16vec2(uvec2(7u, 0u));
	block.var[0][2][1] = u16vec2(uvec2(3u, 9u));
	block.var[0][3][0] = u16vec2(uvec2(7u, 6u));
	block.var[0][3][1] = u16vec2(uvec2(4u, 4u));
	block.var[1][0][0] = u16vec2(uvec2(6u, 9u));
	block.var[1][0][1] = u16vec2(uvec2(3u, 2u));
	block.var[1][1][0] = u16vec2(uvec2(1u, 5u));
	block.var[1][1][1] = u16vec2(uvec2(0u, 2u));
	block.var[1][2][0] = u16vec2(uvec2(8u, 9u));
	block.var[1][2][1] = u16vec2(uvec2(1u, 2u));
	block.var[1][3][0] = u16vec2(uvec2(6u, 4u));
	block.var[1][3][1] = u16vec2(uvec2(5u, 7u));
	block.var[2][0][0] = u16vec2(uvec2(9u, 2u));
	block.var[2][0][1] = u16vec2(uvec2(4u, 5u));
	block.var[2][1][0] = u16vec2(uvec2(3u, 8u));
	block.var[2][1][1] = u16vec2(uvec2(1u, 8u));
	block.var[2][2][0] = u16vec2(uvec2(5u, 7u));
	block.var[2][2][1] = u16vec2(uvec2(9u, 9u));
	block.var[2][3][0] = u16vec2(uvec2(9u, 3u));
	block.var[2][3][1] = u16vec2(uvec2(3u, 2u));
}
#version 450
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
	allOk = compare_mat3(block.t[0].a, mat3(0.0, -7.0, 8.0, -4.0, 6.0, -2.0, -9.0, -2.0, 8.0)) && allOk;
	allOk = compare_ivec3((block.t[0].b[0].a), ivec3(8, -7, 9)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[0]), ivec2(-8, 8)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[1]), ivec2(4, 0)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[2]), ivec2(0, 5)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[3]), ivec2(-2, 8)) && allOk;
	allOk = compare_vec4((block.t[0].b[0].c), vec4(-2.0, 8.0, 6.0, -9.0)) && allOk;
	allOk = compare_ivec3((block.t[0].b[1].a), ivec3(2, -9, 4)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[0]), ivec2(1, 6)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[1]), ivec2(9, -8)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[2]), ivec2(5, -6)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[3]), ivec2(8, -9)) && allOk;
	allOk = compare_vec4((block.t[0].b[1].c), vec4(3.0, 4.0, -6.0, -6.0)) && allOk;
	allOk = compare_ivec3((block.t[0].b[2].a), ivec3(-3, -7, -6)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[0]), ivec2(5, -1)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[1]), ivec2(8, 5)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[2]), ivec2(-2, -1)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[3]), ivec2(8, 1)) && allOk;
	allOk = compare_vec4((block.t[0].b[2].c), vec4(-1.0, -5.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3(block.t[1].a, mat3(4.0, -2.0, -2.0, -1.0, 7.0, 2.0, 6.0, 0.0, 9.0)) && allOk;
	allOk = compare_ivec3((block.t[1].b[0].a), ivec3(8, -7, -3)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[0]), ivec2(4, -7)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[1]), ivec2(5, 1)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[2]), ivec2(4, 0)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[3]), ivec2(-8, 5)) && allOk;
	allOk = compare_vec4((block.t[1].b[0].c), vec4(9.0, -7.0, -6.0, -1.0)) && allOk;
	allOk = compare_ivec3((block.t[1].b[1].a), ivec3(2, -3, -2)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[0]), ivec2(0, 6)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[1]), ivec2(9, 5)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[2]), ivec2(-6, -8)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[3]), ivec2(-3, -7)) && allOk;
	allOk = compare_vec4((block.t[1].b[1].c), vec4(0.0, -4.0, 3.0, 7.0)) && allOk;
	allOk = compare_ivec3((block.t[1].b[2].a), ivec3(9, -9, -8)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[0]), ivec2(8, -6)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[1]), ivec2(-9, -6)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[2]), ivec2(-3, -1)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[3]), ivec2(3, -4)) && allOk;
	allOk = compare_vec4((block.t[1].b[2].c), vec4(9.0, 4.0, 7.0, -5.0)) && allOk;
	allOk = compare_uint((block.u), 5u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s.a = (ivec3(2, -3, 7));
	block.s.b[0] = (ivec2(0, -9));
	block.s.b[1] = (ivec2(6, 1));
	block.s.b[2] = (ivec2(-9, -8));
	block.s.b[3] = (ivec2(-6, 5));
	block.s.c = (vec4(4.0, -2.0, -8.0, 3.0));
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
	allOk = compare_uvec2((block.s[0].a), uvec2(0u, 6u)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[0], mat2x4(8.0, 2.0, -7.0, -2.0, -2.0, -2.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[1], mat2x4(7.0, 5.0, -8.0, -8.0, -3.0, 0.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[2], mat2x4(1.0, -6.0, 4.0, -9.0, 3.0, -7.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[3], mat2x4(-1.0, 6.0, -1.0, -3.0, -4.0, -8.0, -7.0, -8.0)) && allOk;
	allOk = compare_vec3((block.s[0].c), vec3(7.0, 1.0, 0.0)) && allOk;
	allOk = compare_uvec2((block.s[1].a), uvec2(5u, 2u)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[0], mat2x4(-6.0, 3.0, -4.0, 1.0, 1.0, -7.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[1], mat2x4(5.0, 5.0, -9.0, 3.0, -1.0, -5.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[2], mat2x4(-7.0, 8.0, -3.0, 1.0, -5.0, 8.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[3], mat2x4(-6.0, 3.0, 0.0, -6.0, 8.0, -5.0, -8.0, 1.0)) && allOk;
	allOk = compare_vec3((block.s[1].c), vec3(-2.0, -5.0, 9.0)) && allOk;
	allOk = compare_uvec2((block.s[2].a), uvec2(8u, 0u)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[0], mat2x4(-6.0, -6.0, -4.0, 9.0, 2.0, -1.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[1], mat2x4(7.0, -5.0, -5.0, -6.0, 2.0, -4.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[2], mat2x4(-5.0, 7.0, -1.0, 6.0, 7.0, 5.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[3], mat2x4(-6.0, 4.0, 1.0, -6.0, 4.0, -1.0, -9.0, -3.0)) && allOk;
	allOk = compare_vec3((block.s[2].c), vec3(-7.0, 5.0, 3.0)) && allOk;
	allOk = compare_uvec2((block.s[3].a), uvec2(4u, 1u)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[0], mat2x4(1.0, 4.0, -6.0, -9.0, -1.0, 1.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[1], mat2x4(-6.0, -3.0, -6.0, -4.0, -3.0, -8.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[2], mat2x4(6.0, -9.0, 9.0, 7.0, -1.0, 6.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[3], mat2x4(0.0, 0.0, -1.0, 5.0, 8.0, 9.0, 8.0, 4.0)) && allOk;
	allOk = compare_vec3((block.s[3].c), vec3(2.0, -5.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.v = (3u);
	block.s[0].a = (uvec2(0u, 6u));
	block.s[0].b[0][0] = (vec4(2.0, -5.0, 0.0, -7.0));
	block.s[0].b[0][1] = (vec4(9.0, 9.0, -1.0, -4.0));
	block.s[0].b[1][0] = (vec4(4.0, -4.0, 9.0, 8.0));
	block.s[0].b[1][1] = (vec4(0.0, -8.0, -7.0, -1.0));
	block.s[0].b[2][0] = (vec4(-1.0, -7.0, -3.0, 6.0));
	block.s[0].b[2][1] = (vec4(-5.0, 4.0, -9.0, 3.0));
	block.s[0].b[3][0] = (vec4(-6.0, 1.0, -5.0, 9.0));
	block.s[0].b[3][1] = (vec4(1.0, 4.0, -5.0, -1.0));
	block.s[0].c = (vec3(6.0, 5.0, -9.0));
	block.s[1].a = (uvec2(1u, 2u));
	block.s[1].b[0][0] = (vec4(8.0, -9.0, 7.0, -4.0));
	block.s[1].b[0][1] = (vec4(3.0, 9.0, 8.0, 5.0));
	block.s[1].b[1][0] = (vec4(-9.0, 2.0, -5.0, 0.0));
	block.s[1].b[1][1] = (vec4(2.0, -3.0, -6.0, -9.0));
	block.s[1].b[2][0] = (vec4(-6.0, 6.0, -3.0, -5.0));
	block.s[1].b[2][1] = (vec4(5.0, -2.0, -5.0, 7.0));
	block.s[1].b[3][0] = (vec4(-7.0, 5.0, -1.0, 3.0));
	block.s[1].b[3][1] = (vec4(-5.0, 1.0, -5.0, -7.0));
	block.s[1].c = (vec3(-1.0, 5.0, -6.0));
	block.s[2].a = (uvec2(7u, 8u));
	block.s[2].b[0][0] = (vec4(-4.0, -7.0, -4.0, -3.0));
	block.s[2].b[0][1] = (vec4(-4.0, 7.0, 2.0, -3.0));
	block.s[2].b[1][0] = (vec4(2.0, 2.0, 1.0, 2.0));
	block.s[2].b[1][1] = (vec4(-7.0, -6.0, -8.0, 6.0));
	block.s[2].b[2][0] = (vec4(3.0, 0.0, 5.0, -9.0));
	block.s[2].b[2][1] = (vec4(2.0, -3.0, -7.0, -2.0));
	block.s[2].b[3][0] = (vec4(8.0, 6.0, -2.0, -3.0));
	block.s[2].b[3][1] = (vec4(2.0, 4.0, -7.0, 7.0));
	block.s[2].c = (vec3(-2.0, -1.0, 6.0));
	block.s[3].a = (uvec2(9u, 9u));
	block.s[3].b[0][0] = (vec4(-7.0, -7.0, -8.0, 5.0));
	block.s[3].b[0][1] = (vec4(5.0, -1.0, -2.0, -1.0));
	block.s[3].b[1][0] = (vec4(-8.0, -9.0, 2.0, -2.0));
	block.s[3].b[1][1] = (vec4(6.0, 4.0, -2.0, -6.0));
	block.s[3].b[2][0] = (vec4(7.0, -1.0, 7.0, 0.0));
	block.s[3].b[2][1] = (vec4(-6.0, -8.0, 8.0, 9.0));
	block.s[3].b[3][0] = (vec4(-6.0, -9.0, -9.0, 1.0));
	block.s[3].b[3][1] = (vec4(-9.0, -8.0, -2.0, 5.0));
	block.s[3].c = (vec3(-4.0, -4.0, -7.0));
}
#version 450
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
layout(scalar, buffer_reference) buffer Block
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
	allOk = compare_uvec2((block.s[0].a), uvec2(6u, 3u)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[0], mat2x4(-9.0, 9.0, 4.0, 3.0, -7.0, 4.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[1], mat2x4(8.0, -4.0, 6.0, -2.0, -9.0, -2.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[2], mat2x4(-2.0, -2.0, -1.0, 7.0, 2.0, 6.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[3], mat2x4(8.0, -7.0, 9.0, 8.0, -7.0, -3.0, -8.0, 8.0)) && allOk;
	allOk = compare_vec3((block.s[0].c), vec3(7.0, -3.0, 7.0)) && allOk;
	allOk = compare_uvec2((block.s[1].a), uvec2(4u, 0u)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[0], mat2x4(4.0, 0.0, 0.0, 5.0, -2.0, 8.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[1], mat2x4(5.0, 1.0, 4.0, 0.0, -8.0, 5.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[2], mat2x4(6.0, -9.0, 9.0, -7.0, -6.0, -1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[3], mat2x4(4.0, 2.0, -3.0, -2.0, 1.0, 6.0, 9.0, -8.0)) && allOk;
	allOk = compare_vec3((block.s[1].c), vec3(-5.0, 3.0, 5.0)) && allOk;
	allOk = compare_uvec2((block.s[2].a), uvec2(4u, 4u)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[0], mat2x4(5.0, -6.0, 8.0, -9.0, 0.0, 6.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[1], mat2x4(-6.0, -8.0, -3.0, -7.0, 3.0, 4.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[2], mat2x4(0.0, -4.0, 3.0, 7.0, -3.0, -7.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[3], mat2x4(-9.0, -8.0, 5.0, -1.0, 8.0, 5.0, -2.0, -1.0)) && allOk;
	allOk = compare_vec3((block.s[2].c), vec3(9.0, 0.0, 2.0)) && allOk;
	allOk = compare_uvec2((block.s[3].a), uvec2(9u, 7u)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[0], mat2x4(8.0, 1.0, 8.0, -6.0, -9.0, -6.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[1], mat2x4(3.0, -4.0, -1.0, -5.0, -5.0, -4.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[2], mat2x4(7.0, -5.0, -4.0, -5.0, 3.0, 4.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[3], mat2x4(1.0, 8.0, 2.0, -5.0, 3.0, -4.0, -8.0, 4.0)) && allOk;
	allOk = compare_vec3((block.s[3].c), vec3(-3.0, -3.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.v = (2u);
	block.s[0].a = (uvec2(3u, 4u));
	block.s[0].b[0][0] = (vec4(4.0, -2.0, -8.0, 3.0));
	block.s[0].b[0][1] = (vec4(7.0, -4.0, -3.0, -3.0));
	block.s[0].b[1][0] = (vec4(-4.0, 2.0, -2.0, -8.0));
	block.s[0].b[1][1] = (vec4(-5.0, 6.0, -2.0, -5.0));
	block.s[0].b[2][0] = (vec4(-2.0, 3.0, -7.0, 5.0));
	block.s[0].b[2][1] = (vec4(8.0, 0.0, 4.0, -4.0));
	block.s[0].b[3][0] = (vec4(-7.0, -7.0, 1.0, 5.0));
	block.s[0].b[3][1] = (vec4(2.0, 0.0, -9.0, -6.0));
	block.s[0].c = (vec3(2.0, 9.0, -8.0));
	block.s[1].a = (uvec2(2u, 5u));
	block.s[1].b[0][0] = (vec4(-7.0, -7.0, 9.0, -1.0));
	block.s[1].b[0][1] = (vec4(-4.0, 4.0, -7.0, 5.0));
	block.s[1].b[1][0] = (vec4(5.0, -7.0, 4.0, -7.0));
	block.s[1].b[1][1] = (vec4(1.0, 6.0, 8.0, 9.0));
	block.s[1].b[2][0] = (vec4(5.0, 6.0, -7.0, -9.0));
	block.s[1].b[2][1] = (vec4(1.0, 2.0, 5.0, 0.0));
	block.s[1].b[3][0] = (vec4(0.0, -1.0, 9.0, -1.0));
	block.s[1].b[3][1] = (vec4(-2.0, 1.0, -2.0, -4.0));
	block.s[1].c = (vec3(9.0, 6.0, 6.0));
	block.s[2].a = (uvec2(1u, 9u));
	block.s[2].b[0][0] = (vec4(-7.0, -9.0, -8.0, -3.0));
	block.s[2].b[0][1] = (vec4(-1.0, 7.0, -7.0, -1.0));
	block.s[2].b[1][0] = (vec4(-6.0, -5.0, 9.0, 2.0));
	block.s[2].b[1][1] = (vec4(-8.0, -5.0, -7.0, -6.0));
	block.s[2].b[2][0] = (vec4(3.0, -4.0, -9.0, 8.0));
	block.s[2].b[2][1] = (vec4(1.0, 4.0, -5.0, -4.0));
	block.s[2].b[3][0] = (vec4(7.0, 0.0, -1.0, 7.0));
	block.s[2].b[3][1] = (vec4(4.0, -5.0, -8.0, -9.0));
	block.s[2].c = (vec3(3.0, 8.0, -5.0));
	block.s[3].a = (uvec2(4u, 0u));
	block.s[3].b[0][0] = (vec4(7.0, -5.0, -4.0, -6.0));
	block.s[3].b[0][1] = (vec4(-9.0, -3.0, -4.0, 0.0));
	block.s[3].b[1][0] = (vec4(8.0, 9.0, -5.0, -5.0));
	block.s[3].b[1][1] = (vec4(-2.0, -8.0, -2.0, -3.0));
	block.s[3].b[2][0] = (vec4(-5.0, 0.0, -2.0, -8.0));
	block.s[3].b[2][1] = (vec4(0.0, 2.0, 3.0, 6.0));
	block.s[3].b[3][0] = (vec4(7.0, 5.0, 9.0, 5.0));
	block.s[3].b[3][1] = (vec4(-2.0, -2.0, 0.0, 6.0));
	block.s[3].c = (vec3(-7.0, 9.0, -9.0));
}
#version 450
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
	allOk = compare_mat4(block[0].var, mat4(6.0, 9.0, -9.0, 2.0, -1.0, -3.0, 3.0, 6.0, 5.0, 1.0, -3.0, -2.0, 3.0, -6.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(block[1].var, mat4(8.0, 2.0, 9.0, 5.0, 5.0, 3.0, -9.0, -5.0, -8.0, 6.0, -6.0, -7.0, -6.0, 0.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat4(block[2].var, mat4(-3.0, 5.0, 8.0, -1.0, -4.0, 4.0, 3.0, -8.0, 1.0, -1.0, 7.0, 4.0, -2.0, 1.0, -3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec4(0.0, -7.0, -8.0, 3.0));
	block[0].var[1] = (vec4(-4.0, 2.0, 2.0, 9.0));
	block[0].var[2] = (vec4(0.0, 4.0, -1.0, -5.0));
	block[0].var[3] = (vec4(4.0, 0.0, -6.0, -6.0));
	block[1].var[0] = (vec4(-6.0, 3.0, 9.0, -6.0));
	block[1].var[1] = (vec4(2.0, 5.0, 4.0, -7.0));
	block[1].var[2] = (vec4(1.0, -4.0, 3.0, 5.0));
	block[1].var[3] = (vec4(-6.0, 0.0, -6.0, -4.0));
	block[2].var[0] = (vec4(1.0, 6.0, 0.0, 8.0));
	block[2].var[1] = (vec4(-9.0, 0.0, 8.0, 4.0));
	block[2].var[2] = (vec4(-2.0, -5.0, -6.0, -8.0));
	block[2].var[3] = (vec4(-5.0, 8.0, 8.0, -7.0));
}
#version 450
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

layout(std430, row_major, buffer_reference) buffer Block
{
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
	allOk = compare_mat4(block[0].var, mat4(0.0, 6.0, -9.0, 9.0, -2.0, -7.0, -4.0, -6.0, 1.0, -5.0, 2.0, -7.0, 8.0, 2.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat4(block[1].var, mat4(2.0, 8.0, 1.0, 7.0, -1.0, -6.0, 8.0, -2.0, -2.0, 6.0, -7.0, 7.0, 9.0, -7.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(block[2].var, mat4(-9.0, -4.0, -7.0, -3.0, -5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 6.0, 1.0, -8.0, -3.0, 6.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat4(-6.0, 6.0, -9.0, 9.0, 5.0, -1.0, 2.0, -9.0, 1.0, -5.0, -2.0, -8.0, 8.0, 8.0, 1.0, -8.0));
	block[1].var = (mat4(-6.0, 3.0, -2.0, 2.0, -2.0, 6.0, -2.0, -6.0, 9.0, 1.0, 3.0, -1.0, -2.0, 1.0, 7.0, 0.0));
	block[2].var = (mat4(-7.0, -7.0, 8.0, 1.0, -4.0, 7.0, 8.0, -3.0, 3.0, -4.0, 7.0, -3.0, -2.0, 9.0, -2.0, 6.0));
}
#version 450
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
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(block[0].var, mat4x2(4.0, -5.0, -2.0, 7.0, 3.0, 2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block[1].var, mat4x2(-7.0, -1.0, -9.0, 4.0, -9.0, -4.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block[2].var, mat4x2(-7.0, -7.0, 4.0, 6.0, 6.0, -6.0, -1.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec2(2.0, -4.0));
	block[0].var[1] = (vec2(-5.0, 3.0));
	block[0].var[2] = (vec2(7.0, 1.0));
	block[0].var[3] = (vec2(8.0, -5.0));
	block[1].var[0] = (vec2(7.0, -3.0));
	block[1].var[1] = (vec2(1.0, -6.0));
	block[1].var[2] = (vec2(9.0, -3.0));
	block[1].var[3] = (vec2(1.0, -5.0));
	block[2].var[0] = (vec2(-8.0, 4.0));
	block[2].var[1] = (vec2(5.0, -9.0));
	block[2].var[2] = (vec2(1.0, -5.0));
	block[2].var[3] = (vec2(-4.0, -2.0));
}
#version 450
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
	u16vec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

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
	allOk = compare_float((blockA.a), 2.0) && allOk;
	allOk = compare_mat2(blockA.c, mat2(-3.0, -4.0, 0.0, -5.0)) && allOk;
	allOk = compare_ivec2((blockB.b), ivec2(-2, 0)) && allOk;
	allOk = compare_bool((blockB.d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (-3.0);
	blockB.a = (mat3(-2.0, -1.0, -6.0, -6.0, 7.0, 1.0, 8.0, 8.0, 9.0));
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
	allOk = compare_float((blockA.a), -4.0) && allOk;
	allOk = compare_float(blockA.c[0][0], 5.0) && allOk;
	allOk = compare_float(blockA.c[0][1], 2.0) && allOk;
	allOk = compare_float(blockA.c[1][0], -3.0) && allOk;
	allOk = compare_float(blockA.c[1][1], 7.0) && allOk;
	allOk = compare_vec2(blockA.c[0], vec2(5.0, 2.0)) && allOk;
	allOk = compare_vec2(blockA.c[1], vec2(-3.0, 7.0)) && allOk;
	allOk = compare_ivec2((blockB.b), ivec2(-4, 9)) && allOk;
	allOk = compare_bool((blockB.d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (0.0);
	blockB.a = (mat3(-9.0, 5.0, -5.0, 3.0, -9.0, 6.0, 9.0, 2.0, -1.0));
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

struct sA
{
	bvec4 mA[5];
};
struct sB
{
	lowp mat4 mA[6];
	mediump vec2 mB;
	lowp vec2 mC;
};
struct sC
{
	mediump mat2 mA;
	bvec2 mB;
	highp vec4 mC;
	mediump mat3x2 mD;
};
struct sD
{
	highp mat4x2 mA;
	bvec2 mB;
	mediump ivec4 mC;
	sC mD;
};
layout(std430, buffer_reference) buffer BlockB
{
	sA a;
	mediump int b;
};
layout(std430, buffer_reference) buffer BlockC
{
	highp mat3x4 c;
	highp uvec4 d[];
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	lowp vec2 e;
	mediump mat3x2 f;
	lowp mat3x2 g;
	sB h;
	sD i[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a.mA[0]), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec4((blockB.a.mA[1]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((blockB.a.mA[2]), bvec4(false, true, false, false)) && allOk;
	allOk = compare_bvec4((blockB.a.mA[3]), bvec4(false, false, false, false)) && allOk;
	allOk = compare_bvec4((blockB.a.mA[4]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_int((blockB.b), -8) && allOk;
	allOk = compare_mat3x4(blockC.c, mat3x4(4.0, -8.0, -3.0, -1.0, 4.0, -9.0, 7.0, 1.0, -4.0, 7.0, -6.0, 0.0)) && allOk;
	allOk = compare_uvec4((blockC.d[0]), uvec4(4u, 4u, 1u, 6u)) && allOk;
	allOk = compare_uvec4((blockC.d[1]), uvec4(3u, 8u, 3u, 9u)) && allOk;
	allOk = compare_uvec4((blockC.d[2]), uvec4(5u, 9u, 8u, 9u)) && allOk;
	allOk = compare_uvec4((blockC.d[3]), uvec4(9u, 6u, 3u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA[0] = (bvec4(true, false, true, false));
	blockB.a.mA[1] = (bvec4(false, false, true, false));
	blockB.a.mA[2] = (bvec4(false, true, false, false));
	blockB.a.mA[3] = (bvec4(false, true, false, true));
	blockB.a.mA[4] = (bvec4(false, false, true, true));
	blockB.b = (5);
	blockC.c = (mat3x4(-5.0, -2.0, -4.0, -4.0, -9.0, -5.0, 4.0, -3.0, -8.0, -8.0, 9.0, 4.0));
	blockC.d[0] = (uvec4(4u, 8u, 0u, 1u));
	blockC.d[1] = (uvec4(2u, 0u, 2u, 3u));
	blockC.d[2] = (uvec4(5u, 7u, 2u, 5u));
	blockC.d[3] = (uvec4(5u, 1u, 6u, 5u));
	blockD.e = (vec2(-4.0, -9.0));
	blockD.f = (mat3x2(7.0, 9.0, -1.0, 2.0, -8.0, 5.0));
	blockD.h.mA[0] = (mat4(-5.0, -6.0, 7.0, 6.0, 8.0, 2.0, -6.0, -6.0, -4.0, 7.0, -2.0, 1.0, 6.0, 8.0, 8.0, -8.0));
	blockD.h.mA[1] = (mat4(1.0, 0.0, 1.0, 3.0, -8.0, 1.0, 6.0, 6.0, 6.0, -9.0, 0.0, -6.0, -7.0, -4.0, 2.0, -2.0));
	blockD.h.mA[2] = (mat4(4.0, 9.0, -6.0, 6.0, 9.0, -3.0, 1.0, -5.0, -7.0, -1.0, 9.0, -2.0, -1.0, 7.0, -8.0, 2.0));
	blockD.h.mA[3] = (mat4(1.0, -8.0, -6.0, -8.0, 7.0, 6.0, 4.0, -9.0, -9.0, 3.0, 2.0, -7.0, 9.0, -5.0, 7.0, 0.0));
	blockD.h.mA[4] = (mat4(-7.0, -8.0, -3.0, 3.0, 8.0, 5.0, -8.0, 3.0, -5.0, 0.0, -2.0, -7.0, -2.0, -5.0, -4.0, -1.0));
	blockD.h.mA[5] = (mat4(-9.0, -4.0, 9.0, 3.0, 0.0, 6.0, 8.0, 7.0, -5.0, 0.0, 0.0, -8.0, 1.0, -8.0, -7.0, -9.0));
	blockD.h.mB = (vec2(1.0, 9.0));
	blockD.h.mC = (vec2(-5.0, -8.0));
	blockD.i[0].mA = (mat4x2(9.0, -4.0, -6.0, 4.0, 7.0, -7.0, 6.0, 1.0));
	blockD.i[0].mB = (bvec2(true, false));
	blockD.i[0].mC = (ivec4(8, 3, -1, -3));
	blockD.i[0].mD.mA = (mat2(3.0, 6.0, 4.0, 8.0));
	blockD.i[0].mD.mB = (bvec2(false, true));
	blockD.i[0].mD.mC = (vec4(-2.0, -3.0, 5.0, -1.0));
	blockD.i[0].mD.mD = (mat3x2(-9.0, -1.0, 8.0, -9.0, 4.0, -1.0));
	blockD.i[1].mA = (mat4x2(-5.0, -1.0, -2.0, 0.0, 7.0, 2.0, -9.0, 3.0));
	blockD.i[1].mB = (bvec2(false, true));
	blockD.i[1].mC = (ivec4(-2, -2, -9, 1));
	blockD.i[1].mD.mA = (mat2(-8.0, -4.0, -9.0, -4.0));
	blockD.i[1].mD.mB = (bvec2(false, true));
	blockD.i[1].mD.mC = (vec4(-5.0, -9.0, 7.0, -7.0));
	blockD.i[1].mD.mD = (mat3x2(4.0, -3.0, 7.0, -9.0, -3.0, 4.0));
}
#version 450
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
	lowp mat3x2 a;
	lowp mat4 b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (mat3x2(5.0, -5.0, 3.0, 9.0, -5.0, -5.0));
	blockB[1].a = (mat3x2(3.0, 9.0, -3.0, 5.0, 9.0, 4.0));
	blockB[2].a = (mat3x2(7.0, -3.0, -1.0, -6.0, 5.0, 5.0));
}
#version 450
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
	lowp mat4 b;
	lowp float c;
	lowp mat4x2 d;
	lowp uvec2 e;
};
layout(std430, buffer_reference) buffer BlockC
{
	lowp uvec2 f;
	highp vec2 g[5];
	highp int h;
	lowp uvec4 i;
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	bvec2 j[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB[0].a), 1) && allOk;
	allOk = compare_mat4(blockB[0].b, mat4(-8.0, 7.0, -4.0, -9.0, 0.0, -2.0, -3.0, -3.0, -6.0, -8.0, 6.0, -6.0, 3.0, 9.0, -7.0, 3.0)) && allOk;
	allOk = compare_float((blockB[0].c), 0.0) && allOk;
	allOk = compare_mat4x2(blockB[0].d, mat4x2(0.0, 5.0, -8.0, 9.0, 3.0, -8.0, -4.0, 9.0)) && allOk;
	allOk = compare_int((blockB[1].a), 3) && allOk;
	allOk = compare_mat4(blockB[1].b, mat4(9.0, -7.0, -9.0, 7.0, -9.0, -6.0, -4.0, 3.0, 8.0, -1.0, -4.0, 1.0, 6.0, -2.0, -7.0, -1.0)) && allOk;
	allOk = compare_float((blockB[1].c), -8.0) && allOk;
	allOk = compare_mat4x2(blockB[1].d, mat4x2(-4.0, -6.0, 7.0, -1.0, -5.0, -5.0, 6.0, -1.0)) && allOk;
	allOk = compare_int((blockB[2].a), -5) && allOk;
	allOk = compare_mat4(blockB[2].b, mat4(1.0, 7.0, 1.0, -1.0, -4.0, -1.0, 2.0, 9.0, 5.0, 2.0, 3.0, 7.0, -6.0, 7.0, 4.0, -9.0)) && allOk;
	allOk = compare_float((blockB[2].c), -6.0) && allOk;
	allOk = compare_mat4x2(blockB[2].d, mat4x2(7.0, -2.0, 3.0, 6.0, 9.0, -1.0, -4.0, 5.0)) && allOk;
	allOk = compare_uvec2((blockC.f), uvec2(0u, 0u)) && allOk;
	allOk = compare_vec2((blockC.g[0]), vec2(5.0, -4.0)) && allOk;
	allOk = compare_vec2((blockC.g[1]), vec2(7.0, -1.0)) && allOk;
	allOk = compare_vec2((blockC.g[2]), vec2(8.0, -6.0)) && allOk;
	allOk = compare_vec2((blockC.g[3]), vec2(-2.0, 8.0)) && allOk;
	allOk = compare_vec2((blockC.g[4]), vec2(-1.0, 1.0)) && allOk;
	allOk = compare_int((blockC.h), 5) && allOk;
	allOk = compare_bvec2((blockD.j[0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockD.j[1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockD.j[2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockD.j[3]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockD.j[4]), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (-7);
	blockB[0].b = (mat4(9.0, 6.0, -4.0, -9.0, -3.0, 2.0, -5.0, 1.0, -9.0, -8.0, 5.0, -1.0, -9.0, -4.0, 4.0, -6.0));
	blockB[0].c = (9.0);
	blockB[1].a = (-4);
	blockB[1].b = (mat4(-4.0, -2.0, -2.0, -5.0, -9.0, 9.0, 6.0, 3.0, 7.0, -6.0, -1.0, -3.0, -2.0, 9.0, -6.0, 1.0));
	blockB[1].c = (6.0);
	blockB[2].a = (0);
	blockB[2].b = (mat4(4.0, 2.0, -5.0, -5.0, 2.0, -5.0, 0.0, -2.0, -3.0, -3.0, 5.0, -6.0, -1.0, -9.0, -4.0, -6.0));
	blockB[2].c = (9.0);
	blockC.f = (uvec2(6u, 3u));
	blockC.g[0] = (vec2(3.0, -7.0));
	blockC.g[1] = (vec2(-5.0, 6.0));
	blockC.g[2] = (vec2(-1.0, 7.0));
	blockC.g[3] = (vec2(5.0, -9.0));
	blockC.g[4] = (vec2(7.0, -8.0));
	blockC.h = (-1);
	blockC.i = (uvec4(1u, 6u, 6u, 4u));
	blockD.j[0] = (bvec2(false, false));
	blockD.j[1] = (bvec2(true, true));
	blockD.j[2] = (bvec2(true, false));
	blockD.j[3] = (bvec2(true, false));
	blockD.j[4] = (bvec2(true, true));
}
#version 450
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
	layout(offset = 0) lowp vec2 a;
	layout(offset = 16) bvec4 b;
	layout(offset = 32) highp uint c;
	layout(offset = 36) bvec3 d;
	layout(offset = 48) lowp int e;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) lowp int f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.b), bvec4(true, false, true, true)) && allOk;
	allOk = compare_uint((blockB.c), 1u) && allOk;
	allOk = compare_bvec3((blockB.d), bvec3(true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec2(-1.0, -4.0));
	blockB.c = (2u);
	blockB.d = (bvec3(true, false, false));
	blockB.e = (-2);
	blockC.f = (5);
}
#version 450
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
	bvec4 a;
	lowp mat2 b;
	lowp vec4 c[];
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	mediump mat4x3 d;
	bool e;
};
layout(scalar, row_major, buffer_reference) buffer BlockD
{
	mediump ivec2 f;
	bvec2 g;
	lowp uvec3 h;
	highp ivec2 i[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, false, false, false)) && allOk;
	allOk = compare_mat2(blockB.b, mat2(1.0, 3.0, 9.0, -5.0)) && allOk;
	allOk = compare_vec4((blockB.c[0]), vec4(-8.0, -6.0, 0.0, 7.0)) && allOk;
	allOk = compare_vec4((blockB.c[1]), vec4(-1.0, -1.0, 6.0, -5.0)) && allOk;
	allOk = compare_vec4((blockB.c[2]), vec4(5.0, -6.0, 5.0, -7.0)) && allOk;
	allOk = compare_vec4((blockB.c[3]), vec4(-4.0, -7.0, -7.0, 0.0)) && allOk;
	allOk = compare_vec4((blockB.c[4]), vec4(6.0, -7.0, 5.0, -9.0)) && allOk;
	allOk = compare_vec4((blockB.c[5]), vec4(3.0, -2.0, 6.0, -2.0)) && allOk;
	allOk = compare_vec4((blockB.c[6]), vec4(1.0, -6.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat4x3(blockC.d, mat4x3(7.0, 9.0, 1.0, -8.0, 1.0, 6.0, -5.0, 3.0, 6.0, 9.0, 9.0, -1.0)) && allOk;
	allOk = compare_ivec2((blockD[0].f), ivec2(-3, 3)) && allOk;
	allOk = compare_bvec2((blockD[0].g), bvec2(true, true)) && allOk;
	allOk = compare_uvec3((blockD[0].h), uvec3(6u, 4u, 8u)) && allOk;
	allOk = compare_ivec2((blockD[0].i[0]), ivec2(9, -4)) && allOk;
	allOk = compare_ivec2((blockD[0].i[1]), ivec2(9, 8)) && allOk;
	allOk = compare_ivec2((blockD[0].i[2]), ivec2(9, 1)) && allOk;
	allOk = compare_ivec2((blockD[0].i[3]), ivec2(-6, -7)) && allOk;
	allOk = compare_ivec2((blockD[1].f), ivec2(-7, 1)) && allOk;
	allOk = compare_bvec2((blockD[1].g), bvec2(true, false)) && allOk;
	allOk = compare_uvec3((blockD[1].h), uvec3(6u, 3u, 7u)) && allOk;
	allOk = compare_ivec2((blockD[1].i[0]), ivec2(-8, -9)) && allOk;
	allOk = compare_ivec2((blockD[1].i[1]), ivec2(2, -6)) && allOk;
	allOk = compare_ivec2((blockD[1].i[2]), ivec2(9, -5)) && allOk;
	allOk = compare_ivec2((blockD[1].i[3]), ivec2(5, 8)) && allOk;
	allOk = compare_ivec2((blockD[2].f), ivec2(2, 7)) && allOk;
	allOk = compare_bvec2((blockD[2].g), bvec2(true, true)) && allOk;
	allOk = compare_uvec3((blockD[2].h), uvec3(7u, 4u, 9u)) && allOk;
	allOk = compare_ivec2((blockD[2].i[0]), ivec2(-7, -5)) && allOk;
	allOk = compare_ivec2((blockD[2].i[1]), ivec2(3, 0)) && allOk;
	allOk = compare_ivec2((blockD[2].i[2]), ivec2(-6, 2)) && allOk;
	allOk = compare_ivec2((blockD[2].i[3]), ivec2(-8, 6)) && allOk;
	allOk = compare_ivec2((blockD[2].i[4]), ivec2(2, -6)) && allOk;
	allOk = compare_ivec2((blockD[2].i[5]), ivec2(7, -7)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec4(true, false, true, true));
	blockB.c[0] = (vec4(5.0, 2.0, -4.0, -8.0));
	blockB.c[1] = (vec4(0.0, 9.0, 3.0, 1.0));
	blockB.c[2] = (vec4(-6.0, 4.0, -4.0, -6.0));
	blockB.c[3] = (vec4(9.0, 3.0, 7.0, 7.0));
	blockB.c[4] = (vec4(-8.0, 5.0, -2.0, -7.0));
	blockB.c[5] = (vec4(-2.0, 5.0, 0.0, -1.0));
	blockB.c[6] = (vec4(5.0, 4.0, -9.0, -1.0));
	blockC.d = (mat4x3(-1.0, 7.0, -1.0, -7.0, 7.0, 4.0, -3.0, 1.0, 6.0, 5.0, 8.0, 5.0));
	blockD[0].f = (ivec2(-1, -1));
	blockD[0].g = (bvec2(false, true));
	blockD[1].f = (ivec2(2, -5));
	blockD[1].g = (bvec2(false, false));
	blockD[2].f = (ivec2(-1, 0));
	blockD[2].g = (bvec2(false, false));
}
#version 450
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
	mediump ivec4 mB;
};
struct sB
{
	highp uint mA;
	sA mB;
	mediump vec4 mC;
};
layout(scalar, column_major, buffer_reference) buffer BlockB
{
	mediump uint a;
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	highp mat4x3 b;
	highp float c[];
};
layout(scalar, buffer_reference) buffer BlockD
{
	highp uvec4 d;
	mediump mat2x3 e;
};
layout(scalar, buffer_reference) buffer BlockE
{
	mediump vec4 f;
	sB g;
	highp vec3 h;
	highp ivec2 i[][3];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[1];
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 1u) && allOk;
	allOk = compare_mat4x3(blockC[0].b, mat4x3(6.0, 6.0, -9.0, 5.0, -8.0, 4.0, 9.0, 2.0, -4.0, -8.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat2x3(blockD.e, mat2x3(1.0, 5.0, -2.0, -4.0, -8.0, -5.0)) && allOk;
	allOk = compare_vec4((blockE.f), vec4(-3.0, 7.0, 8.0, -8.0)) && allOk;
	allOk = compare_uint((blockE.g.mA), 4u) && allOk;
	allOk = compare_mat4(blockE.g.mB.mA, mat4(-4.0, 0.0, 1.0, 0.0, -6.0, 6.0, -7.0, 8.0, -8.0, -3.0, -7.0, -9.0, 2.0, 3.0, 3.0, -3.0)) && allOk;
	allOk = compare_ivec4((blockE.g.mB.mB), ivec4(-4, 8, -2, 5)) && allOk;
	allOk = compare_vec4((blockE.g.mC), vec4(-7.0, 5.0, 8.0, -5.0)) && allOk;
	allOk = compare_ivec2((blockE.i[0][0]), ivec2(8, -7)) && allOk;
	allOk = compare_ivec2((blockE.i[0][1]), ivec2(-1, -1)) && allOk;
	allOk = compare_ivec2((blockE.i[0][2]), ivec2(9, 2)) && allOk;
	allOk = compare_ivec2((blockE.i[1][0]), ivec2(-9, -5)) && allOk;
	allOk = compare_ivec2((blockE.i[1][1]), ivec2(-2, 1)) && allOk;
	allOk = compare_ivec2((blockE.i[1][2]), ivec2(-9, -1)) && allOk;
	allOk = compare_ivec2((blockE.i[2][0]), ivec2(-3, -1)) && allOk;
	allOk = compare_ivec2((blockE.i[2][1]), ivec2(1, 9)) && allOk;
	allOk = compare_ivec2((blockE.i[2][2]), ivec2(-1, 5)) && allOk;
	allOk = compare_ivec2((blockE.i[3][0]), ivec2(6, -6)) && allOk;
	allOk = compare_ivec2((blockE.i[3][1]), ivec2(-5, -1)) && allOk;
	allOk = compare_ivec2((blockE.i[3][2]), ivec2(0, -5)) && allOk;
	allOk = compare_ivec2((blockE.i[4][0]), ivec2(8, -9)) && allOk;
	allOk = compare_ivec2((blockE.i[4][1]), ivec2(1, 8)) && allOk;
	allOk = compare_ivec2((blockE.i[4][2]), ivec2(2, 0)) && allOk;
	allOk = compare_ivec2((blockE.i[5][0]), ivec2(9, -9)) && allOk;
	allOk = compare_ivec2((blockE.i[5][1]), ivec2(-5, 3)) && allOk;
	allOk = compare_ivec2((blockE.i[5][2]), ivec2(-9, -4)) && allOk;
	allOk = compare_ivec2((blockE.i[6][0]), ivec2(-1, 1)) && allOk;
	allOk = compare_ivec2((blockE.i[6][1]), ivec2(-9, -4)) && allOk;
	allOk = compare_ivec2((blockE.i[6][2]), ivec2(6, -1)) && allOk;
	allOk = compare_ivec2((blockE.i[7][0]), ivec2(7, 9)) && allOk;
	allOk = compare_ivec2((blockE.i[7][1]), ivec2(5, -2)) && allOk;
	allOk = compare_ivec2((blockE.i[7][2]), ivec2(0, -7)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (7u);
	blockC[0].c[0] = (9.0);
	blockC[0].c[1] = (3.0);
	blockC[0].c[2] = (-6.0);
	blockC[0].c[3] = (-7.0);
	blockC[0].c[4] = (-9.0);
	blockD.e = (mat2x3(-2.0, -8.0, -2.0, 0.0, -1.0, 2.0));
	blockE.f = (vec4(2.0, -6.0, 6.0, -3.0));
	blockE.g.mA = (5u);
	blockE.g.mB.mA = (mat4(-7.0, 4.0, 7.0, 1.0, 4.0, -5.0, -6.0, -4.0, 5.0, -7.0, 9.0, -2.0, 5.0, -1.0, 7.0, 2.0));
	blockE.g.mB.mB = (ivec4(-2, -9, -2, 1));
	blockE.g.mC = (vec4(-2.0, -8.0, -2.0, -3.0));
	blockE.h = (vec3(-5.0, -1.0, -7.0));
}
#version 450
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
	highp int mB;
	bvec2 mC;
	mediump mat2x3 mD;
};
layout(scalar, row_major, buffer_reference) buffer BlockB
{
	highp mat4x2 a;
	highp mat3 b[6];
	lowp float c;
	mediump mat3x2 d;
	bvec2 e[];
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	mediump float f;
	sA g;
	lowp mat4 h;
	bool i[];
};
layout(scalar, buffer_reference) buffer BlockD
{
	highp ivec3 j[];
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
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.d, mat3x2(4.0, -4.0, 4.0, 3.0, 7.0, 1.0)) && allOk;
	allOk = compare_bvec2((blockB.e[0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockB.e[1]), bvec2(false, true)) && allOk;
	allOk = compare_uvec4((blockC.g.mA), uvec4(6u, 0u, 2u, 9u)) && allOk;
	allOk = compare_int((blockC.g.mB), -1) && allOk;
	allOk = compare_bvec2((blockC.g.mC), bvec2(false, false)) && allOk;
	allOk = compare_mat2x3(blockC.g.mD, mat2x3(-1.0, 8.0, 4.0, 0.0, -4.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (mat3(-6.0, 6.0, 3.0, -6.0, -9.0, 9.0, 5.0, 2.0, 5.0));
	blockB.b[1] = (mat3(1.0, -2.0, 6.0, 8.0, 6.0, 9.0, -7.0, 8.0, -5.0));
	blockB.b[2] = (mat3(1.0, 1.0, 0.0, 5.0, 7.0, -6.0, 0.0, 3.0, 1.0));
	blockB.b[3] = (mat3(6.0, 1.0, -4.0, -7.0, -9.0, -6.0, -1.0, -6.0, 5.0));
	blockB.b[4] = (mat3(6.0, 3.0, 1.0, -3.0, -1.0, 7.0, 7.0, 1.0, -9.0));
	blockB.b[5] = (mat3(-7.0, -2.0, -1.0, -1.0, -5.0, 8.0, -4.0, -8.0, 0.0));
	blockB.c = (7.0);
	blockB.d = (mat3x2(3.0, -6.0, -1.0, -7.0, -3.0, 5.0));
	blockB.e[0] = (bvec2(true, true));
	blockB.e[1] = (bvec2(true, true));
	blockC.f = (-1.0);
	blockC.g.mA = (uvec4(8u, 2u, 4u, 2u));
	blockC.g.mB = (7);
	blockC.g.mC = (bvec2(true, false));
	blockC.g.mD = (mat2x3(9.0, 3.0, -8.0, -6.0, 0.0, 8.0));
	blockD.j[0] = (ivec3(5, -6, 5));
	blockD.j[1] = (ivec3(5, 0, -9));
}
#version 450
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
	bool b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (mat4x3(7.0, -8.0, -6.0, -6.0, 3.0, 5.0, -1.0, 2.0, 9.0, 3.0, -7.0, -7.0));
	blockB[nonuniformEXT(0)].b = (false);
	blockB[nonuniformEXT(1)].a = (mat4x3(1.0, 7.0, -3.0, -2.0, 4.0, -2.0, 3.0, -7.0, 8.0, -6.0, 1.0, -8.0));
	blockB[nonuniformEXT(1)].b = (false);
}
#version 450
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
	lowp vec3 a;
	mediump uvec4 b;
	lowp mat3x2 c;
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	f16vec2 d[1];
	highp uint e;
	lowp mat3 f;
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
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.b), uvec4(8u, 1u, 5u, 1u)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0]), vec2(7.0, -7.0)) && allOk;
	allOk = compare_uint((blockC.e), 1u) && allOk;
	allOk = compare_mat3(blockC.f, mat3(-4.0, 2.0, 6.0, 8.0, 0.0, -5.0, -1.0, 1.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec3(-6.0, -2.0, 3.0));
	blockB.b = (uvec4(2u, 9u, 4u, 8u));
	blockC.d[0] = f16vec2(vec2(-3.0, 7.0));
	blockC.e = (1u);
	blockC.f = (mat3(2.0, 3.0, 4.0, -7.0, 2.0, 9.0, 1.0, -7.0, -8.0));
}
#version 450
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
	bvec2 e[];
};
layout(std430, buffer_reference) buffer BlockC
{
	lowp vec4 f[1];
	mediump ivec4 g;
	int16_t h;
	bool i[];
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
	allOk = compare_int16_t(int(blockC.h), -6) && allOk;
	allOk = compare_bool((blockC.i[0]), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = u16vec4(uvec4(1u, 1u, 6u, 4u));
	blockB.c = (mat4x3(9.0, 4.0, 0.0, 4.0, 5.0, -2.0, 4.0, -6.0, 5.0, -4.0, 9.0, 1.0));
	blockB.d = (vec2(4.0, -5.0));
	blockB.e[0] = (bvec2(false, true));
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
	lowp vec4 a;
	lowp mat4x2 b[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	u16vec2 c;
	u16vec3 d[1];
	uint16_t e;
	lowp mat2 f[][3];
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
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.a), vec4(0.0, 3.0, 3.0, 2.0)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.c), uvec2(6u, 4u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.d[0]), uvec3(1u, 5u, 5u)) && allOk;
	allOk = compare_uint16_t(uint(blockC.e), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (mat4x2(-5.0, -9.0, -5.0, 2.0, 0.0, -4.0, -1.0, -8.0));
	blockB.b[1] = (mat4x2(-4.0, -7.0, 8.0, -4.0, 6.0, -2.0, -3.0, -9.0));
	blockB.b[2] = (mat4x2(-8.0, 1.0, -5.0, 7.0, 9.0, 9.0, -1.0, -8.0));
	blockB.b[3] = (mat4x2(-6.0, 4.0, 4.0, 6.0, 8.0, -9.0, -8.0, 5.0));
	blockB.b[4] = (mat4x2(6.0, -1.0, 1.0, -3.0, 3.0, -8.0, 0.0, -6.0));
	blockB.b[5] = (mat4x2(3.0, -9.0, 2.0, 1.0, 7.0, -9.0, 2.0, 6.0));
	blockB.b[6] = (mat4x2(2.0, -8.0, -1.0, -7.0, 2.0, 8.0, -5.0, -9.0));
	blockC.e = uint16_t(8u);
	blockC.f[0][0] = (mat2(4.0, -7.0, -1.0, -2.0));
	blockC.f[0][1] = (mat2(-2.0, -8.0, -7.0, -9.0));
	blockC.f[0][2] = (mat2(-2.0, 0.0, 6.0, -7.0));
	blockC.f[1][0] = (mat2(3.0, -1.0, -7.0, -5.0));
	blockC.f[1][1] = (mat2(1.0, -3.0, 4.0, 4.0));
	blockC.f[1][2] = (mat2(5.0, 7.0, 0.0, -5.0));
	blockC.f[2][0] = (mat2(0.0, 0.0, -3.0, 8.0));
	blockC.f[2][1] = (mat2(-6.0, -6.0, 4.0, -7.0));
	blockC.f[2][2] = (mat2(-6.0, -6.0, 7.0, -5.0));
}
#version 450
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
	i16vec3 mA;
	lowp vec2 mB[3];
	u16vec2 mC;
	highp mat2x3 mD;
};
struct sB
{
	highp vec3 mA;
};
layout(std140, buffer_reference) buffer BlockB
{
	mediump mat4x3 a;
	highp ivec2 b;
	i16vec4 c[];
};
layout(std140, buffer_reference) buffer BlockC
{
	float16_t d;
	mediump mat3x2 e[];
};
layout(std140, row_major, buffer_reference) readonly buffer BlockD
{
	sA f[];
};
layout(std140, row_major, buffer_reference) buffer BlockE
{
	sB g[];
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.b), ivec2(-2, 0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB.c[0]), ivec4(9, -1, -9, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB.c[1]), ivec4(-9, 6, 1, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB.c[2]), ivec4(0, 2, 5, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB.c[3]), ivec4(4, 1, -7, -5)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB.c[4]), ivec4(1, 2, -7, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB.c[5]), ivec4(-6, -9, -8, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB.c[6]), ivec4(-5, 9, -9, -2)) && allOk;
	allOk = compare_float16_t(float(blockC.d), 6.0) && allOk;
	allOk = compare_mat3x2(blockC.e[0], mat3x2(-7.0, 8.0, 3.0, 9.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockC.e[1], mat3x2(7.0, 3.0, -3.0, 8.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3x2(blockC.e[2], mat3x2(-3.0, -3.0, -3.0, 3.0, 3.0, 2.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockD.f[0].mA), ivec3(3, 1, 9)) && allOk;
	allOk = compare_vec2((blockD.f[0].mB[0]), vec2(-4.0, 4.0)) && allOk;
	allOk = compare_vec2((blockD.f[0].mB[1]), vec2(8.0, 2.0)) && allOk;
	allOk = compare_vec2((blockD.f[0].mB[2]), vec2(3.0, 0.0)) && allOk;
	allOk = compare_u16vec2(uvec2(blockD.f[0].mC), uvec2(1u, 0u)) && allOk;
	allOk = compare_mat2x3(blockD.f[0].mD, mat2x3(-8.0, 1.0, -7.0, -2.0, 1.0, -9.0)) && allOk;
	allOk = compare_vec3((blockE.g[0].mA), vec3(-6.0, 4.0, 0.0)) && allOk;
	allOk = compare_vec3((blockE.g[1].mA), vec3(-3.0, -3.0, 9.0)) && allOk;
	allOk = compare_vec3((blockE.g[2].mA), vec3(-1.0, -8.0, -9.0)) && allOk;
	allOk = compare_vec3((blockE.g[3].mA), vec3(-7.0, -2.0, -6.0)) && allOk;
	allOk = compare_vec3((blockE.g[4].mA), vec3(0.0, 5.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x3(8.0, 9.0, -5.0, 5.0, -4.0, 2.0, -1.0, 9.0, -3.0, 5.0, -8.0, -2.0));
	blockB.c[0] = i16vec4(ivec4(-2, -8, -6, 9));
	blockB.c[1] = i16vec4(ivec4(4, -5, 5, -1));
	blockB.c[2] = i16vec4(ivec4(4, -7, 5, -6));
	blockB.c[3] = i16vec4(ivec4(4, -3, 9, 0));
	blockB.c[4] = i16vec4(ivec4(-8, 6, -8, -7));
	blockB.c[5] = i16vec4(ivec4(-2, 5, 1, 3));
	blockB.c[6] = i16vec4(ivec4(-3, -1, 1, -6));
	blockC.e[0] = (mat3x2(-4.0, -2.0, 8.0, -7.0, 4.0, 0.0));
	blockC.e[1] = (mat3x2(7.0, 2.0, -4.0, 1.0, 6.0, -2.0));
	blockC.e[2] = (mat3x2(5.0, 7.0, -9.0, -4.0, 7.0, -9.0));
	blockE.g[0].mA = (vec3(2.0, 0.0, 8.0));
	blockE.g[1].mA = (vec3(8.0, -2.0, -6.0));
	blockE.g[2].mA = (vec3(7.0, 1.0, 9.0));
	blockE.g[3].mA = (vec3(-1.0, -8.0, 1.0));
	blockE.g[4].mA = (vec3(0.0, -2.0, -8.0));
}
#version 450
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
	mediump mat3x4 a;
	uint16_t b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB[nonuniformEXT(0)].a, mat3x4(-8.0, -9.0, -9.0, 3.0, 3.0, 0.0, -5.0, -2.0, 3.0, 4.0, 1.0, 4.0)) && allOk;
	allOk = compare_uint16_t(uint(blockB[nonuniformEXT(0)].b), 9u) && allOk;
	allOk = compare_mat3x4(blockB[nonuniformEXT(1)].a, mat3x4(9.0, -1.0, -8.0, 5.0, 1.0, 5.0, -7.0, 4.0, 7.0, 2.0, -6.0, 8.0)) && allOk;
	allOk = compare_uint16_t(uint(blockB[nonuniformEXT(1)].b), 1u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (mat3x4(7.0, -8.0, -6.0, -6.0, 3.0, 5.0, -1.0, 2.0, 9.0, 3.0, -7.0, -7.0));
	blockB[nonuniformEXT(0)].b = uint16_t(1u);
	blockB[nonuniformEXT(1)].a = (mat3x4(1.0, 7.0, -3.0, -2.0, 4.0, -2.0, 3.0, -7.0, 8.0, -6.0, 1.0, -8.0));
	blockB[nonuniformEXT(1)].b = uint16_t(7u);
}
#version 450
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
	bool b;
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
	allOk = compare_bool((blockB.b), false) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	bool a[1];
	highp uvec2 b;
	lowp ivec4 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a[0]), true) && allOk;
	allOk = compare_uvec2((blockB.b), uvec2(7u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c[0] = (ivec4(1, -7, -4, -4));
}
#version 450
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
	mediump mat3x2 mB;
	int8_t mC;
	mediump uint mD;
};
struct sB
{
	bvec4 mA;
};
layout(std140, row_major, buffer_reference) readonly buffer BlockB
{
	uint8_t a;
};
layout(std140, column_major, buffer_reference) readonly buffer BlockC
{
	sA b[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	u8vec4 c;
	mediump ivec2 d;
	sB e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockC.b[0].mA, mat2(3.0, 3.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(blockC.b[0].mB, mat3x2(-7.0, 3.0, 6.0, 2.0, 3.0, 3.0)) && allOk;
	allOk = compare_int8_t(int(blockC.b[0].mC), 4294967288) && allOk;
	allOk = compare_uint((blockC.b[0].mD), 3u) && allOk;
	allOk = compare_mat2(blockC.b[1].mA, mat2(-3.0, 1.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(blockC.b[1].mB, mat3x2(3.0, 5.0, -5.0, -2.0, -6.0, 6.0)) && allOk;
	allOk = compare_int8_t(int(blockC.b[1].mC), 7) && allOk;
	allOk = compare_uint((blockC.b[1].mD), 6u) && allOk;
	allOk = compare_ivec2((blockD.d), ivec2(-4, -4)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockD.c = u8vec4(uvec4(2u, 3u, 9u, 4u));
}
#version 450
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
	u8vec2 a;
	highp uvec4 b;
	u8vec3 c;
	mediump ivec4 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(blockB.c), uvec3(7u, 6u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = u8vec3(uvec3(9u, 3u, 3u));
	blockB.d[0] = (ivec4(8, 0, -8, -9));
}
#version 450
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
	highp mat4 b;
	highp vec3 c;
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	highp ivec4 d;
	mediump uvec4 e;
	mediump int f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(blockB.a), uvec2(7u, 1u)) && allOk;
	allOk = compare_vec3((blockB.c), vec3(-7.0, -9.0, -3.0)) && allOk;
	allOk = compare_uvec4((blockC.e), uvec4(7u, 2u, 7u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (vec3(-4.0, -2.0, 4.0));
	blockC.d = (ivec4(-2, 3, 0, -8));
	blockC.e = (uvec4(3u, 9u, 1u, 0u));
	blockC.f = (-2);
}
#version 450
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
	highp mat2x3 a;
	highp mat4x3 b[6];
	lowp int c[3];
	lowp uvec2 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB.a, mat2x3(-9.0, 9.0, 2.0, 0.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x3(blockB.b[0], mat4x3(5.0, -5.0, -2.0, -9.0, 1.0, -6.0, -8.0, -5.0, 9.0, 7.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat4x3(blockB.b[1], mat4x3(5.0, -5.0, -8.0, -7.0, 7.0, -5.0, 8.0, -5.0, 7.0, -8.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat4x3(blockB.b[2], mat4x3(5.0, 0.0, -2.0, 3.0, 0.0, 8.0, -4.0, -1.0, 6.0, -7.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockB.b[3], mat4x3(0.0, -4.0, -6.0, -1.0, 5.0, 1.0, -5.0, -8.0, -6.0, 6.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat4x3(blockB.b[4], mat4x3(-6.0, -6.0, -3.0, 6.0, -3.0, -3.0, -1.0, -1.0, 9.0, 6.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockB.b[5], mat4x3(-7.0, 0.0, 1.0, 7.0, -2.0, -9.0, -5.0, -6.0, 4.0, -9.0, -7.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2x3(-9.0, -3.0, 8.0, 0.0, -3.0, 9.0));
	blockB.b[0] = (mat4x3(-5.0, 2.0, 1.0, 8.0, 6.0, 2.0, 9.0, 8.0, 5.0, -5.0, 8.0, -1.0));
	blockB.b[1] = (mat4x3(7.0, -9.0, -3.0, -1.0, 6.0, -2.0, -4.0, 9.0, -4.0, 2.0, -4.0, 4.0));
	blockB.b[2] = (mat4x3(-8.0, -4.0, 1.0, -4.0, -4.0, -7.0, -1.0, 9.0, -8.0, 6.0, 2.0, -1.0));
	blockB.b[3] = (mat4x3(0.0, 2.0, -2.0, -1.0, 3.0, 0.0, -8.0, 9.0, 2.0, 1.0, -2.0, -3.0));
	blockB.b[4] = (mat4x3(-1.0, 2.0, -5.0, 4.0, -6.0, -5.0, -3.0, -5.0, 6.0, 6.0, -1.0, -3.0));
	blockB.b[5] = (mat4x3(-7.0, -3.0, -6.0, -2.0, 0.0, -2.0, -3.0, -8.0, 1.0, 8.0, -6.0, -3.0));
}
#version 450
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
	mediump uvec2 mB;
	lowp uvec4 mC;
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	highp uvec4 a;
	highp mat4 b;
	lowp mat4 c;
	bool d[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	mediump mat4 e[2];
	sA f[];
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	u8vec4 g[7];
	uint8_t h;
	lowp vec2 i;
	bvec2 j[4];
	bool k[];
};
layout(std430, buffer_reference) buffer BlockE
{
	mediump mat3 l[8];
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.c, mat4(1.0, 5.0, -7.0, -7.0, -6.0, 6.0, -5.0, 5.0, 0.0, 4.0, 1.0, -6.0, 2.0, 1.0, 2.0, -9.0)) && allOk;
	allOk = compare_bool((blockB.d[0]), false) && allOk;
	allOk = compare_mat4(blockC.e[0], mat4(8.0, -5.0, 9.0, -9.0, -2.0, 6.0, -7.0, 8.0, 3.0, 9.0, 7.0, 9.0, 7.0, 3.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4(blockC.e[1], mat4(1.0, -8.0, -3.0, -3.0, -3.0, 3.0, 3.0, 2.0, 3.0, 1.0, 9.0, -4.0, 4.0, 8.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4x3(blockC.f[0].mA, mat4x3(0.0, -1.0, -9.0, -8.0, -2.0, 1.0, 1.0, -7.0, -9.0, -6.0, 4.0, 0.0)) && allOk;
	allOk = compare_uvec2((blockC.f[0].mB), uvec2(0u, 4u)) && allOk;
	allOk = compare_uvec4((blockC.f[0].mC), uvec4(7u, 1u, 4u, 6u)) && allOk;
	allOk = compare_mat4x3(blockC.f[1].mA, mat4x3(-3.0, -3.0, 9.0, -1.0, -8.0, -9.0, -7.0, -2.0, -6.0, 0.0, 5.0, 8.0)) && allOk;
	allOk = compare_uvec2((blockC.f[1].mB), uvec2(3u, 2u)) && allOk;
	allOk = compare_uvec4((blockC.f[1].mC), uvec4(2u, 5u, 0u, 7u)) && allOk;
	allOk = compare_mat4x3(blockC.f[2].mA, mat4x3(5.0, 5.0, 3.0, 2.0, -8.0, 5.0, -7.0, 6.0, -9.0, -3.0, 7.0, 0.0)) && allOk;
	allOk = compare_uvec2((blockC.f[2].mB), uvec2(2u, 1u)) && allOk;
	allOk = compare_uvec4((blockC.f[2].mC), uvec4(2u, 3u, 4u, 3u)) && allOk;
	allOk = compare_mat4x3(blockC.f[3].mA, mat4x3(9.0, 1.0, -9.0, -5.0, -9.0, 4.0, 7.0, 7.0, -1.0, -7.0, -5.0, 4.0)) && allOk;
	allOk = compare_uvec2((blockC.f[3].mB), uvec2(7u, 8u)) && allOk;
	allOk = compare_uvec4((blockC.f[3].mC), uvec4(8u, 9u, 1u, 9u)) && allOk;
	allOk = compare_uint8_t(uint(blockD.h), 0u) && allOk;
	allOk = compare_vec2((blockD.i), vec2(1.0, -3.0)) && allOk;
	allOk = compare_bvec2((blockD.j[0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockD.j[1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockD.j[2]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockD.j[3]), bvec2(false, true)) && allOk;
	allOk = compare_bool((blockD.k[0]), false) && allOk;
	allOk = compare_bool((blockD.k[1]), true) && allOk;
	allOk = compare_bool((blockD.k[2]), false) && allOk;
	allOk = compare_bool((blockD.k[3]), true) && allOk;
	allOk = compare_bool((blockD.k[4]), true) && allOk;
	allOk = compare_bool((blockD.k[5]), false) && allOk;
	allOk = compare_bool((blockD.k[6]), false) && allOk;
	allOk = compare_bool((blockD.k[7]), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat4(-4.0, -3.0, 4.0, -6.0, 2.0, 5.0, 1.0, 9.0, -1.0, -8.0, -2.0, 4.0, 9.0, -2.0, -8.0, -5.0));
	blockB.c = (mat4(5.0, 5.0, 9.0, -8.0, -1.0, -6.0, 0.0, -7.0, 4.0, 4.0, -8.0, -2.0, -7.0, -3.0, 6.0, 5.0));
	blockC.e[0] = (mat4(3.0, -3.0, -1.0, 1.0, -6.0, -5.0, -4.0, -2.0, 8.0, -7.0, 4.0, 0.0, 7.0, 2.0, -4.0, 1.0));
	blockC.e[1] = (mat4(6.0, -2.0, 5.0, 7.0, -9.0, -4.0, 7.0, -9.0, 7.0, 7.0, -8.0, 5.0, -2.0, -3.0, -9.0, 7.0));
	blockC.f[0].mA = (mat4x3(-4.0, -6.0, 3.0, -7.0, -4.0, 2.0, -4.0, -3.0, 3.0, 2.0, 0.0, 8.0));
	blockC.f[0].mB = (uvec2(6u, 6u));
	blockC.f[0].mC = (uvec4(2u, 2u, 4u, 0u));
	blockC.f[1].mA = (mat4x3(8.0, -2.0, -6.0, 7.0, 1.0, 9.0, -1.0, -8.0, 1.0, 0.0, -2.0, -8.0));
	blockC.f[1].mB = (uvec2(7u, 3u));
	blockC.f[1].mC = (uvec4(3u, 4u, 3u, 3u));
	blockC.f[2].mA = (mat4x3(7.0, -6.0, -5.0, -6.0, -7.0, -5.0, 9.0, 6.0, 8.0, 0.0, 1.0, 0.0));
	blockC.f[2].mB = (uvec2(8u, 6u));
	blockC.f[2].mC = (uvec4(3u, 1u, 6u, 2u));
	blockC.f[3].mA = (mat4x3(-7.0, 8.0, 5.0, -1.0, 3.0, -2.0, -5.0, -7.0, 9.0, -9.0, 7.0, -4.0));
	blockC.f[3].mB = (uvec2(3u, 8u));
	blockC.f[3].mC = (uvec4(1u, 3u, 9u, 4u));
	blockD.g[0] = u8vec4(uvec4(6u, 8u, 7u, 4u));
	blockD.g[1] = u8vec4(uvec4(3u, 5u, 5u, 7u));
	blockD.g[2] = u8vec4(uvec4(5u, 9u, 0u, 2u));
	blockD.g[3] = u8vec4(uvec4(8u, 8u, 4u, 2u));
	blockD.g[4] = u8vec4(uvec4(4u, 5u, 4u, 5u));
	blockD.g[5] = u8vec4(uvec4(9u, 5u, 7u, 8u));
	blockD.g[6] = u8vec4(uvec4(7u, 3u, 9u, 7u));
	blockD.i = (vec2(-7.0, -4.0));
	blockD.j[0] = (bvec2(false, false));
	blockD.j[1] = (bvec2(false, true));
	blockD.j[2] = (bvec2(false, false));
	blockD.j[3] = (bvec2(false, true));
	blockE.l[0] = (mat3(1.0, -2.0, 3.0, -2.0, -2.0, -1.0, -2.0, 0.0, -6.0));
	blockE.l[1] = (mat3(0.0, 2.0, -1.0, 3.0, 1.0, 6.0, 4.0, 9.0, 3.0));
	blockE.l[2] = (mat3(3.0, -9.0, 3.0, 6.0, -8.0, 9.0, -8.0, 3.0, 7.0));
	blockE.l[3] = (mat3(3.0, -8.0, -2.0, 5.0, -4.0, -1.0, 2.0, -8.0, -8.0));
	blockE.l[4] = (mat3(8.0, 0.0, 1.0, 8.0, -8.0, -5.0, 5.0, -5.0, 9.0));
	blockE.l[5] = (mat3(5.0, 2.0, -4.0, -8.0, 5.0, -8.0, -2.0, 1.0, -8.0));
	blockE.l[6] = (mat3(-8.0, -6.0, 5.0, -7.0, 9.0, -2.0, -4.0, -4.0, -8.0));
	blockE.l[7] = (mat3(1.0, -3.0, 7.0, 9.0, -5.0, -3.0, 1.0, -4.0, -8.0));
}
#version 450
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
	highp mat3x2 mB;
};
layout(std430, column_major, buffer_reference) buffer BlockB
{
	highp mat4x2 a;
	highp uvec2 b;
	mediump uvec3 c;
	u8vec2 d;
	i8vec3 e[];
};
layout(std140, column_major, buffer_reference) readonly buffer BlockC
{
	mediump vec4 f;
	bvec4 g;
	sA h[7];
	lowp mat2x3 i;
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.b), uvec2(4u, 4u)) && allOk;
	allOk = compare_uvec3((blockB.c), uvec3(7u, 0u, 6u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB.d), uvec2(1u, 6u)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.e[0]), ivec3(4294967290, 4294967291, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.e[1]), ivec3(4294967293, 5, 3)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.e[2]), ivec3(4294967293, 5, 4294967289)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.e[3]), ivec3(1, 9, 4294967294)) && allOk;
	allOk = compare_bvec4((blockC.g), bvec4(true, true, true, false)) && allOk;
	allOk = compare_mat2x3(blockC.i, mat2x3(-5.0, 9.0, -9.0, -3.0, 7.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x2(-8.0, -4.0, -7.0, 2.0, -2.0, 1.0, 6.0, -8.0));
	blockB.c = (uvec3(7u, 3u, 5u));
	blockB.d = u8vec2(uvec2(5u, 4u));
	blockB.e[0] = i8vec3(ivec3(6, 4294967291, 4294967292));
	blockB.e[1] = i8vec3(ivec3(8, 4294967289, 4));
	blockB.e[2] = i8vec3(ivec3(4294967293, 4294967293, 5));
	blockB.e[3] = i8vec3(ivec3(6, 7, 4294967288));
}
#version 450
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
	layout(offset = 16) u8vec2 b;
	layout(offset = 18) i8vec2 c;
	layout(offset = 20) mediump uvec3 d;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) highp uvec2 e;
	layout(offset = 16) highp vec4 f;
	layout(offset = 32) i8vec4 g;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, true, true, true)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB.b), uvec2(4u, 9u)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.c), ivec2(4294967288, 6)) && allOk;
	allOk = compare_uvec3((blockB.d), uvec3(0u, 9u, 1u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.g), ivec4(9, 3, 4294967288, 4294967292)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec4(true, false, true, false));
	blockB.b = u8vec2(uvec2(8u, 7u));
	blockB.c = i8vec2(ivec2(1, 4294967287));
	blockB.d = (uvec3(3u, 8u, 9u));
	blockC.e = (uvec2(9u, 2u));
	blockC.f = (vec4(4.0, -6.0, 9.0, -1.0));
}
#version 450
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
	lowp float mB;
	u8vec2 mC;
};
layout(scalar, row_major, buffer_reference) buffer BlockB
{
	sA a;
	lowp mat4x2 b;
	bvec2 c;
	i8vec4 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB.b, mat4x2(8.0, -5.0, -9.0, -2.0, -1.0, 5.0, 6.0, -6.0)) && allOk;
	allOk = compare_bvec2((blockB.c), bvec2(false, true)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.d[0]), ivec4(4294967289, 4, 4294967294, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.d[1]), ivec4(4294967290, 5, 4294967292, 4)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.d[2]), ivec4(0, 4, 4294967289, 4)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.d[3]), ivec4(4294967291, 3, 0, 4294967289)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA = (ivec3(0, -7, -2));
	blockB.a.mB = (-6.0);
	blockB.a.mC = u8vec2(uvec2(5u, 6u));
	blockB.d[0] = i8vec4(ivec4(7, 4294967292, 4294967288, 4294967289));
	blockB.d[1] = i8vec4(ivec4(9, 7, 4294967292, 4294967294));
	blockB.d[2] = i8vec4(ivec4(4294967292, 8, 4294967289, 8));
	blockB.d[3] = i8vec4(ivec4(4294967292, 4294967293, 4294967293, 9));
}
