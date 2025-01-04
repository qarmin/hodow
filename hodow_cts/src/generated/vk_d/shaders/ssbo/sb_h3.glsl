#version 450
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
	lowp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 4.0) && allOk;
	allOk = compare_float(var[0][1], -8.0) && allOk;
	allOk = compare_float(var[0][2], -1.0) && allOk;
	allOk = compare_float(var[1][0], -8.0) && allOk;
	allOk = compare_float(var[1][1], -9.0) && allOk;
	allOk = compare_float(var[1][2], 4.0) && allOk;
	allOk = compare_vec3(var[0], vec3(4.0, -8.0, -1.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-8.0, -9.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2x3(7.0, -2.0, -7.0, 8.0, -4.0, 9.0));
}
#version 450
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
	mediump mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var, mat2x4(-7.0, -6.0, -6.0, -9.0, -6.0, -9.0, 1.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(7.0, 2.0, 0.0, 0.0));
	var[1] = (vec4(8.0, -3.0, -2.0, 7.0));
}
#version 450
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
	mediump mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var, mat3x2(-2.0, -2.0, 2.0, -8.0, -6.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec2(1.0, -9.0));
	var[1] = (vec2(-5.0, 5.0));
	var[2] = (vec2(6.0, 5.0));
}
#version 450
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

layout(std430, binding = 1) buffer Block
{
	lowp uint var;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((var), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (6u);
}
#version 450
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

layout(std430, binding = 1) buffer Block
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

	var = (uvec4(2u, 1u, 9u, 1u));
}
#version 450
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

	var[0] = (vec4(9.0, 0.0, -4.0, 9.0));
	var[1] = (vec4(-6.0, 6.0, -7.0, -9.0));
	var[2] = (vec4(-7.0, 0.0, -5.0, -8.0));
}
#version 450
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

layout(scalar, column_major, binding = 1) buffer Block
{
	float padding;
	lowp mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_mat2(var, mat2(7.0, -3.0, -2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-1.0);
	var = (mat2(0.0, -7.0, 5.0, -3.0));
}
#version 450
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
	allOk = compare_float((padding), -6.0) && allOk;
	allOk = compare_float(var[0][0], -3.0) && allOk;
	allOk = compare_float(var[0][1], -5.0) && allOk;
	allOk = compare_float(var[1][0], -3.0) && allOk;
	allOk = compare_float(var[1][1], -1.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-3.0, -5.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-3.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (8.0);
	var = (mat2(2.0, 1.0, 1.0, 6.0));
}
#version 450
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
	allOk = compare_float((padding), 4.0) && allOk;
	allOk = compare_mat3(var, mat3(-7.0, 7.0, -7.0, -5.0, 6.0, -8.0, -3.0, 1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-5.0);
	var = (mat3(-2.0, 2.0, -5.0, 6.0, 3.0, -8.0, -3.0, -5.0, -9.0));
}
#version 450
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
	highp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_mat4(var, mat4(5.0, 6.0, -3.0, 3.0, 8.0, -6.0, 6.0, 4.0, 6.0, 4.0, 6.0, 4.0, 5.0, -2.0, 9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-8.0);
	var = (mat4(8.0, -7.0, -7.0, 5.0, 9.0, -3.0, -7.0, 6.0, -4.0, -3.0, 0.0, -4.0, -5.0, 5.0, 0.0, 8.0));
}
#version 450
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
	allOk = compare_float((padding), -9.0) && allOk;
	allOk = compare_mat4(var, mat4(-5.0, -6.0, -1.0, 3.0, -5.0, 1.0, -3.0, 9.0, 1.0, 5.0, 0.0, -4.0, -9.0, 4.0, 3.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (6.0);
	var[0] = (vec4(-1.0, -2.0, -5.0, 5.0));
	var[1] = (vec4(-2.0, -8.0, -2.0, 3.0));
	var[2] = (vec4(1.0, -9.0, 1.0, 0.0));
	var[3] = (vec4(3.0, 9.0, 7.0, -7.0));
}
#version 450
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
	mediump mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_mat2x3(var, mat2x3(3.0, -9.0, -5.0, -8.0, -3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (3.0);
	var = (mat2x3(4.0, -3.0, 2.0, 3.0, 6.0, 8.0));
}
#version 450
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
	i8vec4 var;
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(padding), 4294967293) && allOk;
	allOk = compare_i8vec4(ivec4(var), ivec4(4294967289, 4294967295, 8, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = int8_t(4294967294);
	var = i8vec4(ivec4(4294967292, 4294967290, 4294967289, 4294967291));
}
#version 450
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
	highp mat4 var[3];
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
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4(7.0, 8.0, 6.0, 5.0, 7.0, 7.0, -1.0, -6.0, -2.0, -6.0, 5.0, 9.0, 8.0, -6.0, 9.0, -8.0));
	var[1] = (mat4(-7.0, -6.0, -1.0, 8.0, 2.0, -9.0, 8.0, -8.0, -3.0, 6.0, -8.0, 3.0, 0.0, -9.0, 1.0, 4.0));
	var[2] = (mat4(8.0, -2.0, 0.0, -2.0, 9.0, 2.0, -3.0, 0.0, 4.0, -8.0, 3.0, 2.0, 2.0, 2.0, 3.0, -6.0));
}
#version 450
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

	var[0][0] = (vec4(-3.0, -5.0, 2.0, 5.0));
	var[0][1] = (vec4(-2.0, -3.0, 9.0, -2.0));
	var[0][2] = (vec4(-6.0, 7.0, 4.0, -6.0));
	var[1][0] = (vec4(2.0, 6.0, 9.0, -2.0));
	var[1][1] = (vec4(7.0, 9.0, 0.0, 0.0));
	var[1][2] = (vec4(8.0, -3.0, 0.0, 3.0));
	var[2][0] = (vec4(-6.0, 1.0, 9.0, 6.0));
	var[2][1] = (vec4(-9.0, -9.0, 2.0, -4.0));
	var[2][2] = (vec4(-8.0, 5.0, -1.0, 9.0));
}
#version 450
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
	i8vec4 var[3];
};

bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(var[0]), ivec4(4294967293, 4294967289, 4294967295, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1]), ivec4(5, 4294967288, 4294967292, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2]), ivec4(3, 3, 4294967290, 4294967293)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = i8vec4(ivec4(4294967294, 4294967292, 4294967290, 4294967289));
	var[1] = i8vec4(ivec4(4294967291, 4294967291, 4, 4294967290));
	var[2] = i8vec4(ivec4(4294967295, 4294967287, 4294967293, 8));
}
#version 450
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
	highp ivec4 var[3];
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((padding), -7) && allOk;
	allOk = compare_ivec4((var[0]), ivec4(9, -5, 6, 3)) && allOk;
	allOk = compare_ivec4((var[1]), ivec4(4, 2, -3, -3)) && allOk;
	allOk = compare_ivec4((var[2]), ivec4(-3, -5, -5, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (5);
	var[0] = (ivec4(-9, 5, -6, -2));
	var[1] = (ivec4(-4, 1, -9, 7));
	var[2] = (ivec4(3, 6, 8, 6));
}
#version 450
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
	bvec4 var[3];
};

bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((padding), true) && allOk;
	allOk = compare_bvec4((var[0]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((var[1]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec4((var[2]), bvec4(false, true, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (true);
	var[0] = (bvec4(true, true, false, true));
	var[1] = (bvec4(false, false, false, false));
	var[2] = (bvec4(true, true, true, true));
}
#version 450
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
	allOk = compare_float((padding), -8.0) && allOk;
	allOk = compare_mat4(var[0], mat4(-5.0, 8.0, 6.0, 7.0, 4.0, 5.0, 7.0, -3.0, 0.0, 2.0, 5.0, 8.0, 3.0, 4.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(-9.0, -9.0, -6.0, 5.0, 6.0, 7.0, 6.0, 1.0, -8.0, -3.0, -3.0, 7.0, -2.0, -3.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(-1.0, -6.0, -1.0, 6.0, 1.0, -1.0, 3.0, -1.0, 6.0, 4.0, -2.0, -9.0, 0.0, 5.0, -6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-9.0);
	var[0][0] = (vec4(-9.0, -4.0, -9.0, -5.0));
	var[0][1] = (vec4(-2.0, 9.0, 0.0, -8.0));
	var[0][2] = (vec4(-6.0, -3.0, -8.0, 3.0));
	var[0][3] = (vec4(0.0, -1.0, -4.0, 4.0));
	var[1][0] = (vec4(7.0, -9.0, 6.0, 5.0));
	var[1][1] = (vec4(6.0, -1.0, -3.0, -3.0));
	var[1][2] = (vec4(-9.0, 3.0, -9.0, 0.0));
	var[1][3] = (vec4(9.0, 4.0, -3.0, 1.0));
	var[2][0] = (vec4(2.0, 1.0, 9.0, -4.0));
	var[2][1] = (vec4(-7.0, 7.0, 0.0, 7.0));
	var[2][2] = (vec4(9.0, 9.0, -5.0, -7.0));
	var[2][3] = (vec4(-4.0, -6.0, 5.0, -9.0));
}
#version 450
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
	i16vec2 var[3];
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(padding), 3) && allOk;
	allOk = compare_i16vec2(ivec2(var[0]), ivec2(-1, 8)) && allOk;
	allOk = compare_i16vec2(ivec2(var[1]), ivec2(-3, -4)) && allOk;
	allOk = compare_i16vec2(ivec2(var[2]), ivec2(2, -1)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = int16_t(6);
	var[0] = i16vec2(ivec2(-2, -2));
	var[1] = i16vec2(ivec2(-8, 3));
	var[2] = i16vec2(ivec2(5, -9));
}
#version 450
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
	allOk = compare_mat4x2(var[0], mat4x2(9.0, 2.0, -3.0, -5.0, -5.0, -4.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(7.0, 7.0, -8.0, 9.0, -7.0, -5.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(-9.0, 8.0, 3.0, -7.0, 5.0, 3.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[3], mat4x2(7.0, -4.0, -4.0, -6.0, 9.0, -3.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[4], mat4x2(-2.0, 5.0, 6.0, 4.0, -6.0, -2.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[5], mat4x2(-5.0, 9.0, -4.0, -6.0, 4.0, -5.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[6], mat4x2(-4.0, 9.0, -1.0, -6.0, 5.0, 3.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[7], mat4x2(-7.0, -7.0, -9.0, 9.0, 5.0, 8.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[8], mat4x2(-6.0, -5.0, -7.0, -3.0, 6.0, -7.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[9], mat4x2(7.0, -9.0, -5.0, -3.0, -6.0, -9.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[10], mat4x2(-4.0, -9.0, 9.0, -7.0, -6.0, -8.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[11], mat4x2(8.0, 6.0, 7.0, -6.0, 0.0, 0.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[12], mat4x2(7.0, -5.0, 4.0, -9.0, 5.0, 5.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[13], mat4x2(2.0, 9.0, -6.0, -6.0, 2.0, 8.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[14], mat4x2(-6.0, 9.0, -3.0, -1.0, 3.0, 8.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[15], mat4x2(-7.0, -7.0, -6.0, 2.0, 3.0, -7.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[16], mat4x2(8.0, -4.0, 1.0, 3.0, 4.0, -2.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[17], mat4x2(6.0, -4.0, -6.0, 6.0, -8.0, 8.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[18], mat4x2(1.0, 0.0, 3.0, -4.0, -6.0, 5.0, -1.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4x2(-9.0, 9.0, 1.0, 5.0, 0.0, 6.0, 3.0, 6.0));
	var[1] = (mat4x2(-5.0, -7.0, 8.0, -6.0, 1.0, -3.0, 2.0, 4.0));
	var[2] = (mat4x2(8.0, -2.0, 6.0, 6.0, 1.0, -9.0, 9.0, -3.0));
	var[3] = (mat4x2(2.0, 0.0, -9.0, -3.0, -1.0, 1.0, 8.0, 1.0));
	var[4] = (mat4x2(-3.0, 6.0, -3.0, -6.0, -7.0, 2.0, 2.0, 7.0));
	var[5] = (mat4x2(3.0, -6.0, -7.0, -9.0, 6.0, 3.0, 6.0, 3.0));
	var[6] = (mat4x2(-8.0, 5.0, -9.0, -8.0, -8.0, -4.0, -5.0, -5.0));
	var[7] = (mat4x2(-6.0, 1.0, 7.0, 7.0, -9.0, 6.0, -8.0, -3.0));
	var[8] = (mat4x2(4.0, -4.0, 8.0, -6.0, 5.0, 3.0, 3.0, 2.0));
	var[9] = (mat4x2(2.0, -3.0, 9.0, 9.0, -2.0, 0.0, -5.0, -2.0));
	var[10] = (mat4x2(3.0, 5.0, 8.0, 9.0, -2.0, -1.0, 3.0, -2.0));
	var[11] = (mat4x2(7.0, 5.0, 1.0, -1.0, 2.0, 8.0, 7.0, 7.0));
	var[12] = (mat4x2(9.0, -8.0, 1.0, 3.0, 1.0, -5.0, -5.0, -5.0));
	var[13] = (mat4x2(2.0, -5.0, 1.0, 5.0, -5.0, 1.0, -2.0, -4.0));
	var[14] = (mat4x2(0.0, -1.0, -2.0, 7.0, 1.0, -5.0, -2.0, -9.0));
	var[15] = (mat4x2(-1.0, -5.0, -2.0, 4.0, 6.0, 1.0, -4.0, 9.0));
	var[16] = (mat4x2(3.0, -5.0, -9.0, -6.0, -1.0, 2.0, -9.0, 3.0));
	var[17] = (mat4x2(-9.0, 2.0, -3.0, -1.0, -3.0, -6.0, -9.0, 9.0));
	var[18] = (mat4x2(1.0, -8.0, 1.0, -6.0, 0.0, -2.0, 2.0, -8.0));
}
#version 450
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
	i8vec4 var[];
};

bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(var[0]), ivec4(4294967293, 4294967289, 4294967295, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1]), ivec4(5, 4294967288, 4294967292, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2]), ivec4(3, 3, 4294967290, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(var[3]), ivec4(4294967289, 4294967292, 4294967291, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(var[4]), ivec4(1, 4294967288, 8, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(var[5]), ivec4(0, 3, 4294967294, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(var[6]), ivec4(1, 4294967295, 4294967292, 6)) && allOk;
	allOk = compare_i8vec4(ivec4(var[7]), ivec4(4294967291, 5, 4294967289, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(var[8]), ivec4(7, 2, 2, 4)) && allOk;
	allOk = compare_i8vec4(ivec4(var[9]), ivec4(4294967295, 9, 4294967287, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(var[10]), ivec4(8, 4294967290, 4294967289, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(var[11]), ivec4(4294967293, 4294967288, 9, 2)) && allOk;
	allOk = compare_i8vec4(ivec4(var[12]), ivec4(4294967293, 4294967294, 4, 2)) && allOk;
	allOk = compare_i8vec4(ivec4(var[13]), ivec4(4294967289, 6, 8, 5)) && allOk;
	allOk = compare_i8vec4(ivec4(var[14]), ivec4(4294967290, 4294967289, 4294967295, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(var[15]), ivec4(4294967293, 4294967287, 4294967292, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(var[16]), ivec4(5, 4294967290, 4294967294, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(var[17]), ivec4(9, 3, 7, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(var[18]), ivec4(4294967287, 4294967291, 5, 4294967294)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = i8vec4(ivec4(4294967294, 4294967292, 4294967290, 4294967289));
	var[1] = i8vec4(ivec4(4294967291, 4294967291, 4, 4294967290));
	var[2] = i8vec4(ivec4(4294967295, 4294967287, 4294967293, 8));
	var[3] = i8vec4(ivec4(6, 4, 9, 4294967287));
	var[4] = i8vec4(ivec4(4294967295, 4294967292, 4294967287, 3));
	var[5] = i8vec4(ivec4(9, 4294967288, 4294967290, 4294967287));
	var[6] = i8vec4(ivec4(8, 5, 4, 5));
	var[7] = i8vec4(ivec4(5, 4294967289, 4294967287, 4294967294));
	var[8] = i8vec4(ivec4(4294967291, 4294967291, 4, 5));
	var[9] = i8vec4(ivec4(4294967293, 4294967294, 4294967289, 4294967291));
	var[10] = i8vec4(ivec4(2, 5, 4, 6));
	var[11] = i8vec4(ivec4(4294967292, 7, 8, 9));
	var[12] = i8vec4(ivec4(3, 4294967293, 4294967290, 4294967290));
	var[13] = i8vec4(ivec4(8, 4294967289, 4294967292, 2));
	var[14] = i8vec4(ivec4(4294967295, 9, 4294967295, 6));
	var[15] = i8vec4(ivec4(6, 4294967289, 4294967293, 4294967289));
	var[16] = i8vec4(ivec4(6, 7, 5, 5));
	var[17] = i8vec4(ivec4(4294967291, 4, 3, 4294967290));
	var[18] = i8vec4(ivec4(1, 0, 5, 0));
}
#version 450
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

	var[0][0] = (vec2(6.0, -2.0));
	var[0][1] = (vec2(2.0, 8.0));
	var[0][2] = (vec2(-5.0, 3.0));
	var[0][3] = (vec2(-1.0, -7.0));
	var[1][0] = (vec2(4.0, 2.0));
	var[1][1] = (vec2(-4.0, 8.0));
	var[1][2] = (vec2(3.0, 8.0));
	var[1][3] = (vec2(-1.0, 6.0));
	var[2][0] = (vec2(-8.0, 2.0));
	var[2][1] = (vec2(-5.0, 5.0));
	var[2][2] = (vec2(-4.0, -9.0));
	var[2][3] = (vec2(0.0, 4.0));
	var[3][0] = (vec2(8.0, 2.0));
	var[3][1] = (vec2(-3.0, 2.0));
	var[3][2] = (vec2(-4.0, -4.0));
	var[3][3] = (vec2(2.0, -8.0));
	var[4][0] = (vec2(-4.0, 8.0));
	var[4][1] = (vec2(5.0, 7.0));
	var[4][2] = (vec2(-4.0, 6.0));
	var[4][3] = (vec2(8.0, 4.0));
	var[5][0] = (vec2(-9.0, -7.0));
	var[5][1] = (vec2(7.0, -5.0));
	var[5][2] = (vec2(1.0, -9.0));
	var[5][3] = (vec2(9.0, 5.0));
	var[6][0] = (vec2(7.0, 3.0));
	var[6][1] = (vec2(3.0, 3.0));
	var[6][2] = (vec2(-5.0, -9.0));
	var[6][3] = (vec2(2.0, 9.0));
	var[7][0] = (vec2(3.0, 8.0));
	var[7][1] = (vec2(3.0, -4.0));
	var[7][2] = (vec2(6.0, 1.0));
	var[7][3] = (vec2(-3.0, 1.0));
	var[8][0] = (vec2(-5.0, -2.0));
	var[8][1] = (vec2(7.0, 8.0));
	var[8][2] = (vec2(4.0, 7.0));
	var[8][3] = (vec2(-1.0, -8.0));
	var[9][0] = (vec2(-6.0, -6.0));
	var[9][1] = (vec2(-4.0, -2.0));
	var[9][2] = (vec2(3.0, 8.0));
	var[9][3] = (vec2(4.0, 4.0));
	var[10][0] = (vec2(-7.0, -6.0));
	var[10][1] = (vec2(8.0, -6.0));
	var[10][2] = (vec2(8.0, -3.0));
	var[10][3] = (vec2(-7.0, 0.0));
	var[11][0] = (vec2(-9.0, 2.0));
	var[11][1] = (vec2(-9.0, 7.0));
	var[11][2] = (vec2(-2.0, 2.0));
	var[11][3] = (vec2(-6.0, -1.0));
	var[12][0] = (vec2(1.0, 7.0));
	var[12][1] = (vec2(0.0, -4.0));
	var[12][2] = (vec2(-1.0, 5.0));
	var[12][3] = (vec2(9.0, -8.0));
	var[13][0] = (vec2(-3.0, 8.0));
	var[13][1] = (vec2(-1.0, 7.0));
	var[13][2] = (vec2(5.0, -7.0));
	var[13][3] = (vec2(8.0, 0.0));
	var[14][0] = (vec2(-5.0, 7.0));
	var[14][1] = (vec2(8.0, 9.0));
	var[14][2] = (vec2(8.0, 9.0));
	var[14][3] = (vec2(1.0, 9.0));
	var[15][0] = (vec2(-9.0, 8.0));
	var[15][1] = (vec2(-2.0, 9.0));
	var[15][2] = (vec2(6.0, 6.0));
	var[15][3] = (vec2(3.0, -5.0));
	var[16][0] = (vec2(1.0, -4.0));
	var[16][1] = (vec2(-5.0, 7.0));
	var[16][2] = (vec2(-8.0, 7.0));
	var[16][3] = (vec2(-1.0, -1.0));
	var[17][0] = (vec2(-2.0, -7.0));
	var[17][1] = (vec2(4.0, -8.0));
	var[17][2] = (vec2(2.0, 4.0));
	var[17][3] = (vec2(3.0, 1.0));
	var[18][0] = (vec2(7.0, 8.0));
	var[18][1] = (vec2(2.0, -9.0));
	var[18][2] = (vec2(-8.0, -9.0));
	var[18][3] = (vec2(-1.0, -3.0));
}
#version 450
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

layout(scalar, binding = 1) buffer Block
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

layout(std140, binding = 1) buffer Block
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

layout(std430, binding = 1) buffer Block
{
	highp vec3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((var[0][0]), vec3(7.0, 9.0, -6.0)) && allOk;
	allOk = compare_vec3((var[0][1]), vec3(-9.0, 5.0, -8.0)) && allOk;
	allOk = compare_vec3((var[0][2]), vec3(1.0, -1.0, 7.0)) && allOk;
	allOk = compare_vec3((var[1][0]), vec3(-1.0, -9.0, 3.0)) && allOk;
	allOk = compare_vec3((var[1][1]), vec3(-7.0, -2.0, -4.0)) && allOk;
	allOk = compare_vec3((var[1][2]), vec3(3.0, 3.0, 6.0)) && allOk;
	allOk = compare_vec3((var[2][0]), vec3(1.0, -4.0, 0.0)) && allOk;
	allOk = compare_vec3((var[2][1]), vec3(5.0, 6.0, 5.0)) && allOk;
	allOk = compare_vec3((var[2][2]), vec3(-3.0, 5.0, 7.0)) && allOk;
	allOk = compare_vec3((var[3][0]), vec3(8.0, 5.0, 8.0)) && allOk;
	allOk = compare_vec3((var[3][1]), vec3(5.0, -8.0, -5.0)) && allOk;
	allOk = compare_vec3((var[3][2]), vec3(-7.0, -3.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec3(5.0, 4.0, 7.0));
	var[0][1] = (vec3(8.0, -2.0, 7.0));
	var[0][2] = (vec3(-5.0, -7.0, 9.0));
	var[1][0] = (vec3(6.0, 6.0, 0.0));
	var[1][1] = (vec3(-5.0, 2.0, -8.0));
	var[1][2] = (vec3(5.0, 0.0, 2.0));
	var[2][0] = (vec3(0.0, 5.0, 1.0));
	var[2][1] = (vec3(-5.0, 0.0, 1.0));
	var[2][2] = (vec3(0.0, 7.0, -2.0));
	var[3][0] = (vec3(-2.0, 8.0, -1.0));
	var[3][1] = (vec3(-1.0, 5.0, 1.0));
	var[3][2] = (vec3(-1.0, -3.0, 8.0));
}
#version 450
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
	highp mat2x4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0][0], mat2x4(-9.0, -2.0, -2.0, -1.0, -8.0, -3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[0][1], mat2x4(-4.0, 1.0, 0.0, -7.0, 3.0, -6.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[0][2], mat2x4(5.0, 4.0, -2.0, 4.0, 2.0, -4.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[1][0], mat2x4(2.0, -7.0, -6.0, -5.0, 6.0, 3.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][1], mat2x4(0.0, -7.0, 0.0, 0.0, 6.0, -7.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][2], mat2x4(-4.0, -2.0, -3.0, 7.0, -4.0, 6.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[2][0], mat2x4(-3.0, 2.0, -6.0, -2.0, -7.0, -5.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[2][1], mat2x4(-8.0, 4.0, -2.0, 8.0, 5.0, -2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[2][2], mat2x4(-1.0, -5.0, -5.0, 6.0, -9.0, 1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[3][0], mat2x4(3.0, 8.0, -1.0, 5.0, -1.0, 8.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[3][1], mat2x4(3.0, -9.0, -2.0, 3.0, -1.0, -9.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[3][2], mat2x4(-2.0, 8.0, -1.0, 6.0, -7.0, 7.0, 5.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec4(-3.0, 4.0, -6.0, 2.0));
	var[0][0][1] = (vec4(-4.0, -6.0, -3.0, 6.0));
	var[0][1][0] = (vec4(-5.0, 1.0, 6.0, 1.0));
	var[0][1][1] = (vec4(1.0, 7.0, 0.0, 9.0));
	var[0][2][0] = (vec4(8.0, 6.0, -7.0, -4.0));
	var[0][2][1] = (vec4(-6.0, 5.0, 5.0, -6.0));
	var[1][0][0] = (vec4(5.0, -4.0, 0.0, 2.0));
	var[1][0][1] = (vec4(-8.0, 6.0, 9.0, 4.0));
	var[1][1][0] = (vec4(-8.0, 0.0, -2.0, -3.0));
	var[1][1][1] = (vec4(-7.0, 4.0, 2.0, -2.0));
	var[1][2][0] = (vec4(2.0, 3.0, 8.0, -9.0));
	var[1][2][1] = (vec4(-7.0, 3.0, -4.0, -7.0));
	var[2][0][0] = (vec4(-3.0, -1.0, -6.0, -2.0));
	var[2][0][1] = (vec4(-8.0, 6.0, 0.0, 4.0));
	var[2][1][0] = (vec4(0.0, -8.0, -6.0, 7.0));
	var[2][1][1] = (vec4(3.0, -7.0, -4.0, 3.0));
	var[2][2][0] = (vec4(-8.0, 2.0, 8.0, -7.0));
	var[2][2][1] = (vec4(5.0, -9.0, 7.0, 7.0));
	var[3][0][0] = (vec4(6.0, 7.0, -7.0, 4.0));
	var[3][0][1] = (vec4(0.0, 8.0, -1.0, -1.0));
	var[3][1][0] = (vec4(4.0, -5.0, 4.0, 6.0));
	var[3][1][1] = (vec4(9.0, 0.0, 5.0, -9.0));
	var[3][2][0] = (vec4(2.0, 0.0, -8.0, 6.0));
	var[3][2][1] = (vec4(1.0, 2.0, 2.0, -6.0));
}
#version 450
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
	highp mat3x2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0][0], mat3x2(-5.0, 7.0, -1.0, -4.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[0][1], mat3x2(-5.0, 7.0, -4.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[0][2], mat3x2(8.0, -3.0, 3.0, -5.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[1][0], mat3x2(-8.0, -4.0, 7.0, 3.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[1][1], mat3x2(0.0, 9.0, -4.0, -9.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[1][2], mat3x2(0.0, 9.0, 2.0, -2.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[2][0], mat3x2(0.0, 6.0, -2.0, 6.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[2][1], mat3x2(1.0, 5.0, 8.0, 3.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[2][2], mat3x2(0.0, 9.0, -2.0, 3.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[3][0], mat3x2(-3.0, 4.0, 1.0, -5.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[3][1], mat3x2(1.0, -8.0, -7.0, -8.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[3][2], mat3x2(-5.0, -4.0, 7.0, 3.0, 3.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec2(-8.0, -4.0));
	var[0][0][1] = (vec2(-3.0, 5.0));
	var[0][0][2] = (vec2(-9.0, 4.0));
	var[0][1][0] = (vec2(-2.0, -1.0));
	var[0][1][1] = (vec2(8.0, 3.0));
	var[0][1][2] = (vec2(7.0, 2.0));
	var[0][2][0] = (vec2(-4.0, 4.0));
	var[0][2][1] = (vec2(3.0, -6.0));
	var[0][2][2] = (vec2(-4.0, 3.0));
	var[1][0][0] = (vec2(4.0, 6.0));
	var[1][0][1] = (vec2(3.0, 6.0));
	var[1][0][2] = (vec2(-2.0, -9.0));
	var[1][1][0] = (vec2(-9.0, 0.0));
	var[1][1][1] = (vec2(-4.0, 9.0));
	var[1][1][2] = (vec2(-1.0, -1.0));
	var[1][2][0] = (vec2(-8.0, 6.0));
	var[1][2][1] = (vec2(5.0, -2.0));
	var[1][2][2] = (vec2(1.0, 4.0));
	var[2][0][0] = (vec2(2.0, -5.0));
	var[2][0][1] = (vec2(-5.0, -9.0));
	var[2][0][2] = (vec2(-7.0, 3.0));
	var[2][1][0] = (vec2(-1.0, 0.0));
	var[2][1][1] = (vec2(-1.0, 4.0));
	var[2][1][2] = (vec2(-1.0, -6.0));
	var[2][2][0] = (vec2(-8.0, -6.0));
	var[2][2][1] = (vec2(8.0, 7.0));
	var[2][2][2] = (vec2(4.0, -9.0));
	var[3][0][0] = (vec2(-4.0, -1.0));
	var[3][0][1] = (vec2(-3.0, -2.0));
	var[3][0][2] = (vec2(-5.0, -2.0));
	var[3][1][0] = (vec2(-7.0, -3.0));
	var[3][1][1] = (vec2(5.0, 4.0));
	var[3][1][2] = (vec2(4.0, 1.0));
	var[3][2][0] = (vec2(-3.0, -6.0));
	var[3][2][1] = (vec2(-4.0, -2.0));
	var[3][2][2] = (vec2(-5.0, -7.0));
}
#version 450
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
	highp int var[4][3];
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((padding), 6) && allOk;
	allOk = compare_int((var[0][0]), 0) && allOk;
	allOk = compare_int((var[0][1]), 9) && allOk;
	allOk = compare_int((var[0][2]), -6) && allOk;
	allOk = compare_int((var[1][0]), -9) && allOk;
	allOk = compare_int((var[1][1]), -8) && allOk;
	allOk = compare_int((var[1][2]), 8) && allOk;
	allOk = compare_int((var[2][0]), -9) && allOk;
	allOk = compare_int((var[2][1]), -1) && allOk;
	allOk = compare_int((var[2][2]), 0) && allOk;
	allOk = compare_int((var[3][0]), -9) && allOk;
	allOk = compare_int((var[3][1]), 5) && allOk;
	allOk = compare_int((var[3][2]), 5) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (8);
	var[0][0] = (2);
	var[0][1] = (-5);
	var[0][2] = (0);
	var[1][0] = (-7);
	var[1][1] = (-7);
	var[1][2] = (-8);
	var[2][0] = (6);
	var[2][1] = (-6);
	var[2][2] = (6);
	var[3][0] = (-5);
	var[3][1] = (5);
	var[3][2] = (-4);
}
#version 450
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
	highp uint var[4][3];
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((padding), 3u) && allOk;
	allOk = compare_uint((var[0][0]), 6u) && allOk;
	allOk = compare_uint((var[0][1]), 9u) && allOk;
	allOk = compare_uint((var[0][2]), 0u) && allOk;
	allOk = compare_uint((var[1][0]), 3u) && allOk;
	allOk = compare_uint((var[1][1]), 7u) && allOk;
	allOk = compare_uint((var[1][2]), 6u) && allOk;
	allOk = compare_uint((var[2][0]), 4u) && allOk;
	allOk = compare_uint((var[2][1]), 2u) && allOk;
	allOk = compare_uint((var[2][2]), 5u) && allOk;
	allOk = compare_uint((var[3][0]), 7u) && allOk;
	allOk = compare_uint((var[3][1]), 5u) && allOk;
	allOk = compare_uint((var[3][2]), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (7u);
	var[0][0] = (9u);
	var[0][1] = (1u);
	var[0][2] = (0u);
	var[1][0] = (7u);
	var[1][1] = (7u);
	var[1][2] = (4u);
	var[2][0] = (8u);
	var[2][1] = (7u);
	var[2][2] = (5u);
	var[3][0] = (7u);
	var[3][1] = (2u);
	var[3][2] = (7u);
}
#version 450
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
	bvec4 var[4][3];
};

bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((padding), true) && allOk;
	allOk = compare_bvec4((var[0][0]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((var[0][1]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec4((var[0][2]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((var[1][0]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((var[1][1]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((var[1][2]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((var[2][0]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((var[2][1]), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bvec4((var[2][2]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((var[3][0]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec4((var[3][1]), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bvec4((var[3][2]), bvec4(true, true, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (true);
	var[0][0] = (bvec4(true, true, false, true));
	var[0][1] = (bvec4(false, false, false, false));
	var[0][2] = (bvec4(true, true, true, true));
	var[1][0] = (bvec4(true, true, false, true));
	var[1][1] = (bvec4(false, true, false, true));
	var[1][2] = (bvec4(false, false, true, false));
	var[2][0] = (bvec4(true, true, false, true));
	var[2][1] = (bvec4(true, true, false, false));
	var[2][2] = (bvec4(false, true, true, true));
	var[3][0] = (bvec4(false, true, false, true));
	var[3][1] = (bvec4(true, true, true, false));
	var[3][2] = (bvec4(true, false, true, false));
}
#version 450
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
	highp mat2x4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_mat2x4(var[0][0], mat2x4(8.0, 6.0, -5.0, -7.0, -1.0, 8.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[0][1], mat2x4(-3.0, -3.0, 3.0, 9.0, 3.0, 2.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[0][2], mat2x4(-8.0, 9.0, -7.0, 5.0, -2.0, 7.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[1][0], mat2x4(-7.0, -9.0, 1.0, -3.0, -5.0, -4.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[1][1], mat2x4(0.0, 8.0, -4.0, -8.0, 4.0, -2.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[1][2], mat2x4(-8.0, -2.0, 1.0, -7.0, 7.0, -6.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[2][0], mat2x4(-5.0, 3.0, -6.0, -6.0, -6.0, -7.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[2][1], mat2x4(-4.0, -7.0, -1.0, -6.0, -5.0, 2.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[2][2], mat2x4(9.0, 3.0, 4.0, -2.0, 8.0, -5.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[3][0], mat2x4(1.0, 5.0, -9.0, 7.0, 2.0, -7.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[3][1], mat2x4(0.0, -8.0, 8.0, 2.0, 9.0, 6.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[3][2], mat2x4(3.0, -8.0, 0.0, -3.0, -4.0, -1.0, -3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (1.0);
	var[0][0] = (mat2x4(9.0, -7.0, -1.0, 7.0, -5.0, 3.0, -4.0, -1.0));
	var[0][1] = (mat2x4(-4.0, -6.0, -7.0, 3.0, 5.0, 1.0, -1.0, 9.0));
	var[0][2] = (mat2x4(-9.0, -3.0, -7.0, 3.0, 9.0, -5.0, -9.0, -7.0));
	var[1][0] = (mat2x4(-4.0, -2.0, -7.0, -9.0, 1.0, -6.0, 2.0, 0.0));
	var[1][1] = (mat2x4(-4.0, -2.0, 7.0, 9.0, -5.0, -2.0, -7.0, 3.0));
	var[1][2] = (mat2x4(-8.0, 1.0, 7.0, 5.0, -5.0, 7.0, -9.0, 4.0));
	var[2][0] = (mat2x4(-7.0, 8.0, 0.0, 4.0, 0.0, -9.0, 2.0, -2.0));
	var[2][1] = (mat2x4(1.0, -6.0, -9.0, -2.0, -7.0, 1.0, -5.0, -8.0));
	var[2][2] = (mat2x4(7.0, 1.0, 7.0, -3.0, -1.0, 5.0, -8.0, 2.0));
	var[3][0] = (mat2x4(9.0, -6.0, 0.0, 1.0, -7.0, -8.0, 5.0, 5.0));
	var[3][1] = (mat2x4(-9.0, 9.0, 8.0, -3.0, -6.0, 3.0, 4.0, -6.0));
	var[3][2] = (mat2x4(-9.0, 2.0, 9.0, -2.0, 3.0, 6.0, 5.0, 7.0));
}
#version 450
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
	allOk = compare_float((padding), -9.0) && allOk;
	allOk = compare_mat2x4(var[0][0], mat2x4(-8.0, -3.0, -8.0, 8.0, -2.0, -2.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[0][1], mat2x4(3.0, -6.0, 9.0, -3.0, 1.0, 0.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[0][2], mat2x4(2.0, -4.0, 5.0, -1.0, 4.0, -2.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[1][0], mat2x4(6.0, 3.0, 4.0, -9.0, -7.0, -6.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[1][1], mat2x4(6.0, -7.0, -3.0, -9.0, -7.0, 0.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[1][2], mat2x4(-4.0, 6.0, -2.0, 8.0, -2.0, -3.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[2][0], mat2x4(-7.0, -5.0, 1.0, 8.0, 2.0, -6.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[2][1], mat2x4(5.0, -2.0, -2.0, -7.0, 4.0, -2.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[2][2], mat2x4(-9.0, 1.0, -5.0, -1.0, -5.0, -5.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[3][0], mat2x4(-1.0, 8.0, -9.0, -8.0, 8.0, -1.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[3][1], mat2x4(-1.0, -9.0, -2.0, -3.0, -9.0, -2.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[3][2], mat2x4(-7.0, 7.0, 5.0, 3.0, 8.0, -1.0, 6.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-3.0);
	var[0][0][0] = (vec4(-4.0, -6.0, -3.0, 6.0));
	var[0][0][1] = (vec4(4.0, -6.0, 2.0, -5.0));
	var[0][1][0] = (vec4(1.0, 7.0, 0.0, 9.0));
	var[0][1][1] = (vec4(1.0, 6.0, 1.0, 8.0));
	var[0][2][0] = (vec4(-6.0, 5.0, 5.0, -6.0));
	var[0][2][1] = (vec4(6.0, -7.0, -4.0, 5.0));
	var[1][0][0] = (vec4(-8.0, 6.0, 9.0, 4.0));
	var[1][0][1] = (vec4(-4.0, 0.0, 2.0, -8.0));
	var[1][1][0] = (vec4(-7.0, 4.0, 2.0, -2.0));
	var[1][1][1] = (vec4(0.0, -2.0, -3.0, 2.0));
	var[1][2][0] = (vec4(-7.0, 3.0, -4.0, -7.0));
	var[1][2][1] = (vec4(3.0, 8.0, -9.0, -3.0));
	var[2][0][0] = (vec4(-8.0, 6.0, 0.0, 4.0));
	var[2][0][1] = (vec4(-1.0, -6.0, -2.0, 0.0));
	var[2][1][0] = (vec4(3.0, -7.0, -4.0, 3.0));
	var[2][1][1] = (vec4(-8.0, -6.0, 7.0, -8.0));
	var[2][2][0] = (vec4(5.0, -9.0, 7.0, 7.0));
	var[2][2][1] = (vec4(2.0, 8.0, -7.0, 6.0));
	var[3][0][0] = (vec4(0.0, 8.0, -1.0, -1.0));
	var[3][0][1] = (vec4(7.0, -7.0, 4.0, 4.0));
	var[3][1][0] = (vec4(9.0, 0.0, 5.0, -9.0));
	var[3][1][1] = (vec4(-5.0, 4.0, 6.0, 2.0));
	var[3][2][0] = (vec4(1.0, 2.0, 2.0, -6.0));
	var[3][2][1] = (vec4(0.0, -8.0, 6.0, 5.0));
}
#version 450
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
	i8vec2 var[4][3];
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(padding), 4294967288) && allOk;
	allOk = compare_i8vec2(ivec2(var[0][0]), ivec2(4294967293, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(var[0][1]), ivec2(9, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(var[0][2]), ivec2(1, 4294967288)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][0]), ivec2(4294967293, 4294967290)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][1]), ivec2(4294967287, 4294967289)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][2]), ivec2(2, 4294967287)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][0]), ivec2(7, 6)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][1]), ivec2(0, 3)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][2]), ivec2(7, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(var[3][0]), ivec2(4294967293, 6)) && allOk;
	allOk = compare_i8vec2(ivec2(var[3][1]), ivec2(9, 3)) && allOk;
	allOk = compare_i8vec2(ivec2(var[3][2]), ivec2(1, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = int8_t(0);
	var[0][0] = i8vec2(ivec2(8, 4294967292));
	var[0][1] = i8vec2(ivec2(9, 4294967294));
	var[0][2] = i8vec2(ivec2(4294967295, 8));
	var[1][0] = i8vec2(ivec2(4294967290, 8));
	var[1][1] = i8vec2(ivec2(4294967289, 7));
	var[1][2] = i8vec2(ivec2(4294967294, 4294967293));
	var[2][0] = i8vec2(ivec2(4294967293, 4294967290));
	var[2][1] = i8vec2(ivec2(3, 4294967295));
	var[2][2] = i8vec2(ivec2(8, 5));
	var[3][0] = i8vec2(ivec2(8, 4294967293));
	var[3][1] = i8vec2(ivec2(4294967292, 4294967287));
	var[3][2] = i8vec2(ivec2(6, 4294967293));
}
#version 450
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
	allOk = compare_mat4x3(var[0][0][0], mat4x3(3.0, 6.0, 1.0, -6.0, -9.0, -8.0, 6.0, 4.0, 5.0, -6.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(-1.0, 1.0, 2.0, 9.0, 3.0, 1.0, 1.0, 7.0, -1.0, 8.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][2], mat4x3(9.0, 4.0, 5.0, -9.0, 2.0, 0.0, -9.0, -2.0, 1.0, -7.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(7.0, -9.0, 1.0, -8.0, -1.0, -4.0, -7.0, -5.0, 8.0, -9.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(-5.0, 9.0, 1.0, 3.0, 0.0, -5.0, 3.0, 4.0, -5.0, 1.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][2], mat4x3(7.0, -8.0, -6.0, 5.0, -1.0, -9.0, 2.0, -2.0, 6.0, -5.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(-5.0, -5.0, -5.0, 8.0, -6.0, 8.0, -7.0, -4.0, -1.0, 2.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(-5.0, 8.0, 5.0, 8.0, -2.0, 2.0, -5.0, -4.0, -3.0, 8.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][2], mat4x3(5.0, -4.0, 3.0, -9.0, 7.0, 8.0, -7.0, -7.0, 6.0, -2.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(-9.0, -8.0, -9.0, -3.0, -2.0, 8.0, 4.0, 3.0, -8.0, -6.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(8.0, -3.0, -6.0, 8.0, -2.0, 8.0, 9.0, 0.0, 1.0, -3.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][2], mat4x3(7.0, 0.0, 3.0, 4.0, -5.0, -8.0, 5.0, 0.0, 8.0, 2.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(-3.0, 0.0, 6.0, -2.0, 7.0, 3.0, 6.0, -7.0, 3.0, -8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(-1.0, 0.0, -7.0, 9.0, -7.0, -6.0, -5.0, 2.0, 8.0, 6.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][2], mat4x3(7.0, -1.0, -6.0, 5.0, 6.0, -1.0, -1.0, -3.0, -1.0, 5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(-8.0, 1.0, -1.0, -1.0, -9.0, 7.0, -4.0, 0.0, -7.0, -9.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(5.0, -9.0, 6.0, -3.0, 3.0, -7.0, 3.0, -1.0, 2.0, -7.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][2], mat4x3(-9.0, 1.0, 7.0, 0.0, 0.0, -4.0, 3.0, -4.0, -6.0, -7.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][0], mat4x3(2.0, 6.0, 4.0, 7.0, 3.0, -8.0, 0.0, 3.0, -4.0, 2.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][1], mat4x3(2.0, -4.0, 3.0, 9.0, 2.0, 9.0, 2.0, -5.0, -7.0, -1.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][2], mat4x3(-7.0, -7.0, 9.0, -8.0, -1.0, 0.0, 5.0, 6.0, 4.0, -7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][0], mat4x3(-4.0, -2.0, -1.0, -2.0, -5.0, -7.0, -6.0, 8.0, -9.0, -3.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][1], mat4x3(9.0, 8.0, -4.0, -7.0, 9.0, 5.0, -7.0, 3.0, -2.0, -4.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][2], mat4x3(5.0, 4.0, -4.0, -7.0, 7.0, -2.0, 9.0, 5.0, 1.0, -9.0, 0.0, 2.0)) && allOk;
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
	var[0][0][2][0] = (vec3(-4.0, 5.0, 7.0));
	var[0][0][2][1] = (vec3(9.0, 5.0, -7.0));
	var[0][0][2][2] = (vec3(8.0, 9.0, 0.0));
	var[0][0][2][3] = (vec3(-3.0, 3.0, 0.0));
	var[0][1][0][0] = (vec3(-5.0, 3.0, -5.0));
	var[0][1][0][1] = (vec3(-6.0, 6.0, 3.0));
	var[0][1][0][2] = (vec3(-6.0, 0.0, -5.0));
	var[0][1][0][3] = (vec3(-9.0, 8.0, -8.0));
	var[0][1][1][0] = (vec3(-5.0, 2.0, -7.0));
	var[0][1][1][1] = (vec3(-1.0, -2.0, 7.0));
	var[0][1][1][2] = (vec3(4.0, -7.0, 7.0));
	var[0][1][1][3] = (vec3(-3.0, 7.0, 6.0));
	var[0][1][2][0] = (vec3(9.0, -2.0, 2.0));
	var[0][1][2][1] = (vec3(-3.0, -6.0, 3.0));
	var[0][1][2][2] = (vec3(7.0, -7.0, -1.0));
	var[0][1][2][3] = (vec3(0.0, 1.0, -3.0));
	var[1][0][0][0] = (vec3(7.0, -8.0, -7.0));
	var[1][0][0][1] = (vec3(2.0, 7.0, 5.0));
	var[1][0][0][2] = (vec3(5.0, -7.0, 0.0));
	var[1][0][0][3] = (vec3(-2.0, 9.0, -7.0));
	var[1][0][1][0] = (vec3(2.0, -9.0, 0.0));
	var[1][0][1][1] = (vec3(9.0, -2.0, -8.0));
	var[1][0][1][2] = (vec3(-9.0, 5.0, 9.0));
	var[1][0][1][3] = (vec3(0.0, 8.0, -9.0));
	var[1][0][2][0] = (vec3(2.0, 1.0, -7.0));
	var[1][0][2][1] = (vec3(-7.0, 8.0, 7.0));
	var[1][0][2][2] = (vec3(8.0, -8.0, -5.0));
	var[1][0][2][3] = (vec3(5.0, 1.0, -3.0));
	var[1][1][0][0] = (vec3(-6.0, 6.0, 2.0));
	var[1][1][0][1] = (vec3(-5.0, 0.0, 4.0));
	var[1][1][0][2] = (vec3(7.0, -6.0, -6.0));
	var[1][1][0][3] = (vec3(3.0, 8.0, 1.0));
	var[1][1][1][0] = (vec3(-3.0, -1.0, 7.0));
	var[1][1][1][1] = (vec3(-2.0, -7.0, -9.0));
	var[1][1][1][2] = (vec3(-8.0, -1.0, 4.0));
	var[1][1][1][3] = (vec3(0.0, -2.0, -5.0));
	var[1][1][2][0] = (vec3(2.0, -7.0, 3.0));
	var[1][1][2][1] = (vec3(-2.0, 4.0, -6.0));
	var[1][1][2][2] = (vec3(8.0, -7.0, -9.0));
	var[1][1][2][3] = (vec3(-4.0, 5.0, 4.0));
	var[2][0][0][0] = (vec3(2.0, 5.0, 2.0));
	var[2][0][0][1] = (vec3(2.0, 3.0, -2.0));
	var[2][0][0][2] = (vec3(5.0, 4.0, 6.0));
	var[2][0][0][3] = (vec3(-1.0, 5.0, 6.0));
	var[2][0][1][0] = (vec3(1.0, 2.0, -4.0));
	var[2][0][1][1] = (vec3(9.0, -1.0, 6.0));
	var[2][0][1][2] = (vec3(9.0, -1.0, -2.0));
	var[2][0][1][3] = (vec3(-1.0, -8.0, 3.0));
	var[2][0][2][0] = (vec3(-4.0, 1.0, -4.0));
	var[2][0][2][1] = (vec3(4.0, 2.0, 0.0));
	var[2][0][2][2] = (vec3(1.0, -6.0, 1.0));
	var[2][0][2][3] = (vec3(-7.0, -9.0, 8.0));
	var[2][1][0][0] = (vec3(1.0, -1.0, 8.0));
	var[2][1][0][1] = (vec3(8.0, 3.0, -9.0));
	var[2][1][0][2] = (vec3(1.0, -1.0, -7.0));
	var[2][1][0][3] = (vec3(-1.0, -7.0, -5.0));
	var[2][1][1][0] = (vec3(-5.0, 1.0, 8.0));
	var[2][1][1][1] = (vec3(5.0, 5.0, -8.0));
	var[2][1][1][2] = (vec3(-8.0, 2.0, 8.0));
	var[2][1][1][3] = (vec3(2.0, -8.0, -6.0));
	var[2][1][2][0] = (vec3(-9.0, 1.0, 5.0));
	var[2][1][2][1] = (vec3(4.0, 5.0, 1.0));
	var[2][1][2][2] = (vec3(-7.0, 4.0, -5.0));
	var[2][1][2][3] = (vec3(4.0, 8.0, 8.0));
	var[3][0][0][0] = (vec3(1.0, 9.0, -4.0));
	var[3][0][0][1] = (vec3(1.0, -5.0, 9.0));
	var[3][0][0][2] = (vec3(2.0, -1.0, -1.0));
	var[3][0][0][3] = (vec3(5.0, 7.0, -4.0));
	var[3][0][1][0] = (vec3(-2.0, 9.0, -4.0));
	var[3][0][1][1] = (vec3(-4.0, 4.0, -1.0));
	var[3][0][1][2] = (vec3(0.0, 7.0, 9.0));
	var[3][0][1][3] = (vec3(-8.0, 3.0, 9.0));
	var[3][0][2][0] = (vec3(-7.0, -1.0, -9.0));
	var[3][0][2][1] = (vec3(-7.0, 3.0, 5.0));
	var[3][0][2][2] = (vec3(-7.0, 1.0, -1.0));
	var[3][0][2][3] = (vec3(-5.0, -7.0, 7.0));
	var[3][1][0][0] = (vec3(-4.0, -2.0, -5.0));
	var[3][1][0][1] = (vec3(-5.0, -9.0, 8.0));
	var[3][1][0][2] = (vec3(4.0, 8.0, 0.0));
	var[3][1][0][3] = (vec3(0.0, 9.0, 5.0));
	var[3][1][1][0] = (vec3(-3.0, 8.0, 6.0));
	var[3][1][1][1] = (vec3(7.0, 8.0, -7.0));
	var[3][1][1][2] = (vec3(-3.0, -6.0, -2.0));
	var[3][1][1][3] = (vec3(-6.0, 0.0, -8.0));
	var[3][1][2][0] = (vec3(-6.0, 0.0, 6.0));
	var[3][1][2][1] = (vec3(-1.0, 6.0, -7.0));
	var[3][1][2][2] = (vec3(7.0, 0.0, 1.0));
	var[3][1][2][3] = (vec3(-8.0, 2.0, 7.0));
}
#version 450
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
	highp mat3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat3(var[0][0][0], mat3(-9.0, 7.0, 0.0, -1.0, -8.0, 0.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(8.0, -4.0, -1.0, 5.0, -5.0, -9.0, -6.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat3(var[0][0][2], mat3(-9.0, 4.0, 5.0, -4.0, -4.0, 6.0, 2.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(0.0, 6.0, 4.0, -2.0, 0.0, 6.0, -4.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(-5.0, -1.0, -6.0, 1.0, -4.0, 2.0, -6.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat3(var[0][1][2], mat3(-9.0, 3.0, -9.0, 7.0, -5.0, 5.0, 5.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(-8.0, 1.0, -2.0, 6.0, 7.0, 4.0, -7.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(-6.0, -4.0, -1.0, -5.0, 3.0, 3.0, -3.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat3(var[1][0][2], mat3(1.0, 6.0, -7.0, 4.0, -7.0, -8.0, -1.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(-7.0, 1.0, 6.0, -5.0, 2.0, -5.0, 1.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(8.0, -8.0, 1.0, -3.0, -3.0, -6.0, -1.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat3(var[1][1][2], mat3(3.0, -9.0, -4.0, 3.0, -4.0, 8.0, -9.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(-3.0, 5.0, 3.0, -7.0, -5.0, 0.0, -3.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(0.0, -4.0, 2.0, 4.0, -3.0, 6.0, 4.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat3(var[2][0][2], mat3(-2.0, 5.0, 9.0, 8.0, -3.0, -5.0, -5.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(8.0, 5.0, -4.0, 1.0, 8.0, -7.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(1.0, -5.0, 9.0, 0.0, -3.0, 6.0, -5.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3(var[2][1][2], mat3(-6.0, 5.0, 4.0, 2.0, -6.0, -6.0, -6.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3(var[3][0][0], mat3(0.0, 8.0, -3.0, 5.0, -5.0, 0.0, 8.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat3(var[3][0][1], mat3(-3.0, -8.0, -6.0, -2.0, -4.0, -5.0, 3.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3(var[3][0][2], mat3(-1.0, 4.0, 7.0, -7.0, 4.0, -7.0, 2.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat3(var[3][1][0], mat3(1.0, -4.0, -3.0, 1.0, -2.0, -6.0, -8.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat3(var[3][1][1], mat3(-1.0, -3.0, 7.0, -3.0, -5.0, -1.0, -9.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3(var[3][1][2], mat3(-4.0, -7.0, 8.0, 2.0, 6.0, -7.0, 1.0, 6.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (7.0);
	var[0][0][0] = (mat3(-8.0, -8.0, -4.0, -3.0, 5.0, -3.0, -3.0, -1.0, 5.0));
	var[0][0][1] = (mat3(1.0, -3.0, 9.0, 1.0, 5.0, 0.0, 5.0, -1.0, -7.0));
	var[0][0][2] = (mat3(4.0, 1.0, -6.0, 3.0, 6.0, 1.0, 9.0, 3.0, -9.0));
	var[0][1][0] = (mat3(4.0, 1.0, 4.0, 5.0, -8.0, 0.0, 4.0, -7.0, -3.0));
	var[0][1][1] = (mat3(2.0, 7.0, -9.0, -9.0, -4.0, 6.0, -9.0, 9.0, -6.0));
	var[0][1][2] = (mat3(9.0, 8.0, -8.0, -9.0, -8.0, 2.0, 4.0, 8.0, -5.0));
	var[1][0][0] = (mat3(3.0, -7.0, 6.0, -9.0, 3.0, -9.0, 3.0, -6.0, 4.0));
	var[1][0][1] = (mat3(7.0, -6.0, -7.0, 1.0, -3.0, -6.0, -2.0, 5.0, 7.0));
	var[1][0][2] = (mat3(-6.0, -2.0, -8.0, 7.0, 1.0, 3.0, 4.0, 0.0, 5.0));
	var[1][1][0] = (mat3(6.0, -5.0, 3.0, -2.0, -2.0, -3.0, -3.0, 8.0, 1.0));
	var[1][1][1] = (mat3(-1.0, -6.0, -7.0, -4.0, -9.0, 9.0, -4.0, -3.0, 8.0));
	var[1][1][2] = (mat3(7.0, -9.0, 3.0, -6.0, 1.0, -4.0, -4.0, 3.0, 0.0));
	var[2][0][0] = (mat3(4.0, -6.0, -9.0, -4.0, 6.0, -1.0, 8.0, -6.0, -3.0));
	var[2][0][1] = (mat3(6.0, -9.0, 2.0, -5.0, 0.0, -7.0, -5.0, -3.0, -4.0));
	var[2][0][2] = (mat3(-4.0, 8.0, -8.0, -7.0, 7.0, -4.0, -7.0, 8.0, -8.0));
	var[2][1][0] = (mat3(7.0, -3.0, -5.0, -1.0, 1.0, -7.0, 1.0, -9.0, 0.0));
	var[2][1][1] = (mat3(7.0, 5.0, -6.0, 4.0, -6.0, 2.0, -3.0, 4.0, 7.0));
	var[2][1][2] = (mat3(6.0, 0.0, -2.0, -9.0, 3.0, 8.0, 9.0, -8.0, 8.0));
	var[3][0][0] = (mat3(-8.0, -8.0, 1.0, -5.0, -6.0, 8.0, -1.0, 2.0, -3.0));
	var[3][0][1] = (mat3(-8.0, 4.0, 8.0, -2.0, 3.0, -5.0, -9.0, -3.0, 3.0));
	var[3][0][2] = (mat3(-2.0, -2.0, -3.0, 9.0, -6.0, 3.0, 5.0, 5.0, -2.0));
	var[3][1][0] = (mat3(-8.0, -8.0, -9.0, -1.0, 4.0, 9.0, 9.0, -4.0, 0.0));
	var[3][1][1] = (mat3(-4.0, -8.0, 9.0, 2.0, 6.0, -7.0, 5.0, -8.0, -9.0));
	var[3][1][2] = (mat3(-6.0, -3.0, 1.0, -9.0, -5.0, 5.0, 4.0, 5.0, 7.0));
}
#version 450
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
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_mat4(var[0][0][0], mat4(6.0, 7.0, 5.0, 2.0, -4.0, 0.0, 8.0, 3.0, 3.0, 9.0, 8.0, -2.0, 7.0, 0.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(1.0, 9.0, 1.0, -2.0, -7.0, 3.0, 5.0, 2.0, -8.0, 8.0, -1.0, -4.0, -5.0, 8.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[0][0][2], mat4(1.0, 1.0, -6.0, 5.0, -8.0, -6.0, -3.0, -4.0, 8.0, 9.0, -9.0, -4.0, -2.0, -8.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(4.0, 8.0, 3.0, 4.0, -3.0, -4.0, -1.0, -4.0, 5.0, -4.0, 7.0, -7.0, 3.0, -2.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(-2.0, 6.0, 9.0, 8.0, -2.0, 0.0, 5.0, -9.0, 5.0, -1.0, 4.0, -3.0, 8.0, 0.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat4(var[0][1][2], mat4(-2.0, 6.0, -1.0, 9.0, 9.0, -9.0, 0.0, 4.0, -3.0, 4.0, 1.0, -1.0, 3.0, -9.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(-7.0, 7.0, -7.0, 4.0, 1.0, -4.0, -7.0, 6.0, -4.0, -3.0, -1.0, -2.0, -9.0, -4.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(-8.0, 2.0, 0.0, -4.0, 1.0, 6.0, 1.0, 2.0, -1.0, -8.0, -9.0, -1.0, -9.0, -2.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4(var[1][0][2], mat4(-3.0, -4.0, -8.0, 3.0, 1.0, 4.0, -4.0, -2.0, 6.0, -8.0, 3.0, 7.0, 5.0, 4.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(-2.0, 2.0, -3.0, 4.0, -1.0, 6.0, -4.0, 3.0, 0.0, 8.0, 1.0, -9.0, 8.0, -2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(-7.0, -9.0, 0.0, -1.0, -2.0, -1.0, 9.0, -9.0, 0.0, -4.0, -1.0, -6.0, 2.0, 3.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat4(var[1][1][2], mat4(-9.0, -3.0, 9.0, -7.0, -2.0, 7.0, 7.0, 1.0, 9.0, -4.0, 7.0, 0.0, 3.0, 5.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(8.0, 3.0, 5.0, 3.0, 4.0, 5.0, 4.0, -2.0, -6.0, -8.0, -4.0, -5.0, -1.0, 8.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(-1.0, -2.0, -6.0, -8.0, 2.0, 9.0, -9.0, 2.0, -3.0, 5.0, -1.0, -5.0, -4.0, -5.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4(var[2][0][2], mat4(9.0, 2.0, -3.0, -5.0, 5.0, 4.0, -6.0, -7.0, -1.0, -4.0, 6.0, -7.0, -9.0, 3.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(6.0, -9.0, -8.0, -5.0, -5.0, 8.0, 1.0, 7.0, -6.0, -8.0, 7.0, -7.0, -3.0, -2.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(-8.0, 9.0, 1.0, 3.0, -9.0, 9.0, -2.0, -7.0, 2.0, 9.0, -7.0, -5.0, 5.0, 7.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat4(var[2][1][2], mat4(-4.0, -8.0, -3.0, -3.0, 0.0, 3.0, 9.0, 7.0, 2.0, 4.0, 6.0, -9.0, 8.0, 8.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat4(var[3][0][0], mat4(-1.0, 3.0, -4.0, 5.0, -7.0, -2.0, 3.0, 0.0, -1.0, 7.0, 5.0, -6.0, -1.0, -7.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat4(var[3][0][1], mat4(-9.0, -6.0, 7.0, 6.0, 4.0, -5.0, 0.0, 8.0, -4.0, -3.0, -6.0, -7.0, 4.0, -4.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4(var[3][0][2], mat4(4.0, -8.0, 7.0, -3.0, 2.0, -9.0, -8.0, 8.0, 9.0, -5.0, 0.0, 4.0, 3.0, -9.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat4(var[3][1][0], mat4(-2.0, 1.0, -4.0, 8.0, -8.0, -5.0, -7.0, 8.0, -9.0, 4.0, 3.0, 2.0, 9.0, -3.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat4(var[3][1][1], mat4(-4.0, 9.0, 3.0, -5.0, -7.0, 0.0, 3.0, -3.0, 6.0, -9.0, 9.0, 9.0, 8.0, 9.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat4(var[3][1][2], mat4(7.0, -7.0, -6.0, 0.0, -3.0, -2.0, 5.0, 2.0, -1.0, 0.0, -8.0, 1.0, -4.0, -7.0, 9.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-3.0);
	var[0][0][0][0] = (vec4(-6.0, 8.0, 7.0, -8.0));
	var[0][0][0][1] = (vec4(6.0, 1.0, -6.0, 6.0));
	var[0][0][0][2] = (vec4(0.0, -6.0, 3.0, 3.0));
	var[0][0][0][3] = (vec4(3.0, -3.0, 2.0, -8.0));
	var[0][0][1][0] = (vec4(9.0, -6.0, 6.0, 1.0));
	var[0][0][1][1] = (vec4(9.0, -7.0, 4.0, -5.0));
	var[0][0][1][2] = (vec4(5.0, -6.0, 5.0, 7.0));
	var[0][0][1][3] = (vec4(7.0, -5.0, -9.0, 7.0));
	var[0][0][2][0] = (vec4(-2.0, -1.0, -4.0, -3.0));
	var[0][0][2][1] = (vec4(3.0, -8.0, 7.0, -8.0));
	var[0][0][2][2] = (vec4(-5.0, -9.0, -1.0, 0.0));
	var[0][0][2][3] = (vec4(-7.0, 7.0, 8.0, -6.0));
	var[0][1][0][0] = (vec4(-9.0, 9.0, 7.0, -9.0));
	var[0][1][0][1] = (vec4(5.0, 1.0, -4.0, -1.0));
	var[0][1][0][2] = (vec4(-2.0, 1.0, 5.0, -1.0));
	var[0][1][0][3] = (vec4(-5.0, 7.0, -6.0, 1.0));
	var[0][1][1][0] = (vec4(0.0, 9.0, -3.0, 7.0));
	var[0][1][1][1] = (vec4(0.0, -6.0, -7.0, -8.0));
	var[0][1][1][2] = (vec4(1.0, -2.0, 9.0, 0.0));
	var[0][1][1][3] = (vec4(-2.0, 6.0, -1.0, -5.0));
	var[0][1][2][0] = (vec4(-1.0, -3.0, 5.0, -7.0));
	var[0][1][2][1] = (vec4(4.0, 5.0, -9.0, -1.0));
	var[0][1][2][2] = (vec4(0.0, 8.0, 8.0, -3.0));
	var[0][1][2][3] = (vec4(4.0, -4.0, -4.0, 5.0));
	var[1][0][0][0] = (vec4(-6.0, -1.0, 6.0, 3.0));
	var[1][0][0][1] = (vec4(5.0, -8.0, 3.0, 1.0));
	var[1][0][0][2] = (vec4(-1.0, 3.0, -5.0, 4.0));
	var[1][0][0][3] = (vec4(-4.0, 3.0, 4.0, -4.0));
	var[1][0][1][0] = (vec4(-8.0, 4.0, 5.0, -5.0));
	var[1][0][1][1] = (vec4(0.0, -3.0, -4.0, 5.0));
	var[1][0][1][2] = (vec4(-4.0, -7.0, 4.0, -3.0));
	var[1][0][1][3] = (vec4(9.0, 3.0, -4.0, -3.0));
	var[1][0][2][0] = (vec4(-9.0, 6.0, -3.0, -6.0));
	var[1][0][2][1] = (vec4(-1.0, 8.0, 3.0, -2.0));
	var[1][0][2][2] = (vec4(9.0, -2.0, -3.0, -8.0));
	var[1][0][2][3] = (vec4(3.0, -8.0, 5.0, 7.0));
	var[1][1][0][0] = (vec4(8.0, -8.0, -1.0, -7.0));
	var[1][1][0][1] = (vec4(8.0, 4.0, -1.0, -1.0));
	var[1][1][0][2] = (vec4(-9.0, 3.0, 2.0, 4.0));
	var[1][1][0][3] = (vec4(-2.0, 7.0, 5.0, 0.0));
	var[1][1][1][0] = (vec4(-5.0, 2.0, 2.0, 4.0));
	var[1][1][1][1] = (vec4(4.0, -9.0, 3.0, 1.0));
	var[1][1][1][2] = (vec4(0.0, 5.0, -8.0, -3.0));
	var[1][1][1][3] = (vec4(-3.0, 3.0, -6.0, -5.0));
	var[1][1][2][0] = (vec4(9.0, 0.0, -6.0, -2.0));
	var[1][1][2][1] = (vec4(-4.0, 3.0, 1.0, 4.0));
	var[1][1][2][2] = (vec4(1.0, -3.0, 6.0, -2.0));
	var[1][1][2][3] = (vec4(-7.0, -7.0, 9.0, -2.0));
	var[2][0][0][0] = (vec4(-2.0, -7.0, 3.0, 8.0));
	var[2][0][0][1] = (vec4(-7.0, -6.0, 4.0, -4.0));
	var[2][0][0][2] = (vec4(6.0, -2.0, -7.0, 7.0));
	var[2][0][0][3] = (vec4(8.0, -8.0, -2.0, -8.0));
	var[2][0][1][0] = (vec4(3.0, 9.0, 3.0, 1.0));
	var[2][0][1][1] = (vec4(-3.0, -5.0, -8.0, -7.0));
	var[2][0][1][2] = (vec4(5.0, -1.0, -6.0, 8.0));
	var[2][0][1][3] = (vec4(-8.0, 4.0, 8.0, 6.0));
	var[2][0][2][0] = (vec4(-5.0, 4.0, -3.0, -1.0));
	var[2][0][2][1] = (vec4(-8.0, 3.0, 5.0, 0.0));
	var[2][0][2][2] = (vec4(7.0, 6.0, -4.0, 1.0));
	var[2][0][2][3] = (vec4(4.0, 3.0, 6.0, -3.0));
	var[2][1][0][0] = (vec4(-6.0, -2.0, -5.0, -9.0));
	var[2][1][0][1] = (vec4(4.0, 4.0, -5.0, -1.0));
	var[2][1][0][2] = (vec4(-1.0, 0.0, -7.0, 5.0));
	var[2][1][0][3] = (vec4(7.0, -3.0, -7.0, 9.0));
	var[2][1][1][0] = (vec4(-7.0, 5.0, 1.0, -7.0));
	var[2][1][1][1] = (vec4(4.0, 8.0, -9.0, 6.0));
	var[2][1][1][2] = (vec4(2.0, -8.0, 8.0, 3.0));
	var[2][1][1][3] = (vec4(6.0, 9.0, 6.0, -4.0));
	var[2][1][2][0] = (vec4(-8.0, -1.0, 1.0, 0.0));
	var[2][1][2][1] = (vec4(5.0, 8.0, 6.0, 3.0));
	var[2][1][2][2] = (vec4(8.0, -7.0, -1.0, 2.0));
	var[2][1][2][3] = (vec4(3.0, 7.0, 3.0, -2.0));
	var[3][0][0][0] = (vec4(-8.0, -6.0, 5.0, -9.0));
	var[3][0][0][1] = (vec4(-3.0, 0.0, -1.0, -5.0));
	var[3][0][0][2] = (vec4(9.0, -8.0, -9.0, -1.0));
	var[3][0][0][3] = (vec4(2.0, 5.0, 6.0, 2.0));
	var[3][0][1][0] = (vec4(3.0, 8.0, 8.0, -7.0));
	var[3][0][1][1] = (vec4(-1.0, 5.0, -3.0, 5.0));
	var[3][0][1][2] = (vec4(-3.0, -4.0, 6.0, -6.0));
	var[3][0][1][3] = (vec4(-5.0, 7.0, -6.0, 7.0));
	var[3][0][2][0] = (vec4(-3.0, -8.0, 1.0, 1.0));
	var[3][0][2][1] = (vec4(2.0, 3.0, 1.0, 5.0));
	var[3][0][2][2] = (vec4(-2.0, 2.0, -2.0, -9.0));
	var[3][0][2][3] = (vec4(-1.0, 2.0, -1.0, 8.0));
	var[3][1][0][0] = (vec4(-1.0, 0.0, -2.0, 7.0));
	var[3][1][0][1] = (vec4(-6.0, 5.0, 5.0, -9.0));
	var[3][1][0][2] = (vec4(-8.0, -5.0, 0.0, -2.0));
	var[3][1][0][3] = (vec4(3.0, 8.0, 4.0, -2.0));
	var[3][1][1][0] = (vec4(-3.0, -9.0, 9.0, -6.0));
	var[3][1][1][1] = (vec4(-1.0, -3.0, 3.0, -7.0));
	var[3][1][1][2] = (vec4(5.0, -6.0, 8.0, 0.0));
	var[3][1][1][3] = (vec4(-5.0, 0.0, 4.0, -2.0));
	var[3][1][2][0] = (vec4(-9.0, -1.0, -2.0, 2.0));
	var[3][1][2][1] = (vec4(-4.0, -6.0, -5.0, 4.0));
	var[3][1][2][2] = (vec4(-4.0, 7.0, 2.0, 3.0));
	var[3][1][2][3] = (vec4(2.0, -2.0, -5.0, -9.0));
}
#version 450
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

layout(std140, column_major, binding = 1) buffer Block
{
	highp mat2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0][0][0], mat2(-2.0, 3.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(8.0, 2.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(9.0, -3.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(-2.0, 8.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2(var[0][2][0], mat2(6.0, -3.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat2(var[0][2][1], mat2(3.0, 6.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat2(var[0][3][0], mat2(6.0, -8.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2(var[0][3][1], mat2(8.0, 4.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(3.0, 2.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(5.0, 8.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(3.0, 5.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(-8.0, -1.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1][2][0], mat2(3.0, -9.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1][2][1], mat2(6.0, -4.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat2(var[1][3][0], mat2(6.0, 4.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2(var[1][3][1], mat2(5.0, -3.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(-7.0, 8.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(-6.0, 2.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(-6.0, 9.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(-7.0, 1.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat2(var[2][2][0], mat2(0.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat2(var[2][2][1], mat2(-4.0, 8.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2(var[2][3][0], mat2(-6.0, -7.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2(var[2][3][1], mat2(-8.0, -2.0, -3.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec2(5.0, -4.0));
	var[0][0][0][1] = (vec2(5.0, 1.0));
	var[0][0][1][0] = (vec2(-8.0, -1.0));
	var[0][0][1][1] = (vec2(9.0, -8.0));
	var[0][1][0][0] = (vec2(4.0, -3.0));
	var[0][1][0][1] = (vec2(6.0, 7.0));
	var[0][1][1][0] = (vec2(-7.0, -9.0));
	var[0][1][1][1] = (vec2(5.0, 0.0));
	var[0][2][0][0] = (vec2(7.0, 7.0));
	var[0][2][0][1] = (vec2(0.0, 2.0));
	var[0][2][1][0] = (vec2(4.0, -7.0));
	var[0][2][1][1] = (vec2(-5.0, -7.0));
	var[0][3][0][0] = (vec2(4.0, -2.0));
	var[0][3][0][1] = (vec2(6.0, 1.0));
	var[0][3][1][0] = (vec2(-2.0, -8.0));
	var[0][3][1][1] = (vec2(9.0, 1.0));
	var[1][0][0][0] = (vec2(5.0, -4.0));
	var[1][0][0][1] = (vec2(5.0, -2.0));
	var[1][0][1][0] = (vec2(9.0, -9.0));
	var[1][0][1][1] = (vec2(-1.0, 6.0));
	var[1][1][0][0] = (vec2(9.0, 2.0));
	var[1][1][0][1] = (vec2(1.0, -6.0));
	var[1][1][1][0] = (vec2(8.0, -8.0));
	var[1][1][1][1] = (vec2(5.0, -5.0));
	var[1][2][0][0] = (vec2(8.0, 2.0));
	var[1][2][0][1] = (vec2(1.0, -1.0));
	var[1][2][1][0] = (vec2(9.0, 0.0));
	var[1][2][1][1] = (vec2(-8.0, -9.0));
	var[1][3][0][0] = (vec2(3.0, 4.0));
	var[1][3][0][1] = (vec2(-1.0, 5.0));
	var[1][3][1][0] = (vec2(2.0, -6.0));
	var[1][3][1][1] = (vec2(7.0, -4.0));
	var[2][0][0][0] = (vec2(-4.0, 7.0));
	var[2][0][0][1] = (vec2(-8.0, 1.0));
	var[2][0][1][0] = (vec2(4.0, -4.0));
	var[2][0][1][1] = (vec2(6.0, -5.0));
	var[2][1][0][0] = (vec2(-5.0, 4.0));
	var[2][1][0][1] = (vec2(5.0, 0.0));
	var[2][1][1][0] = (vec2(6.0, 9.0));
	var[2][1][1][1] = (vec2(5.0, -8.0));
	var[2][2][0][0] = (vec2(-2.0, 7.0));
	var[2][2][0][1] = (vec2(8.0, 2.0));
	var[2][2][1][0] = (vec2(-3.0, -3.0));
	var[2][2][1][1] = (vec2(7.0, -2.0));
	var[2][3][0][0] = (vec2(5.0, 3.0));
	var[2][3][0][1] = (vec2(9.0, -9.0));
	var[2][3][1][0] = (vec2(7.0, 1.0));
	var[2][3][1][1] = (vec2(-5.0, -7.0));
}
#version 450
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
	highp mat3 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0][0][0], mat3(-9.0, -4.0, 2.0, 9.0, 6.0, -2.0, 1.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(6.0, 3.0, 2.0, 7.0, 4.0, 2.0, 3.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(-9.0, -7.0, 6.0, 9.0, 7.0, 9.0, -3.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(9.0, -2.0, 1.0, 4.0, 4.0, 6.0, -1.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat3(var[0][2][0], mat3(6.0, 2.0, -2.0, -8.0, 6.0, -8.0, 9.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat3(var[0][2][1], mat3(2.0, -5.0, -3.0, 8.0, -9.0, -7.0, 1.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3(var[0][3][0], mat3(8.0, 6.0, -5.0, 8.0, 3.0, 2.0, -2.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3(var[0][3][1], mat3(3.0, 6.0, -1.0, 9.0, 5.0, -8.0, 3.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(6.0, 3.0, 7.0, -4.0, -2.0, -7.0, -6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(8.0, -8.0, 9.0, -5.0, 1.0, 4.0, -5.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(-5.0, 6.0, 1.0, -6.0, -3.0, -8.0, -9.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(-7.0, 8.0, -9.0, 5.0, -3.0, 6.0, 5.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(var[1][2][0], mat3(4.0, 7.0, -9.0, 5.0, 0.0, -7.0, -9.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3(var[1][2][1], mat3(-1.0, -3.0, 9.0, -3.0, 4.0, 3.0, 3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3(var[1][3][0], mat3(-9.0, -6.0, -1.0, -8.0, 7.0, -5.0, 7.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat3(var[1][3][1], mat3(8.0, -5.0, 6.0, -9.0, -8.0, 9.0, -2.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(3.0, -6.0, -5.0, 8.0, -7.0, -1.0, 7.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(-3.0, 9.0, -3.0, -6.0, -2.0, -9.0, 4.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(-4.0, 7.0, -7.0, -7.0, -4.0, 4.0, -5.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(2.0, 6.0, -4.0, -8.0, -5.0, -4.0, -7.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(var[2][2][0], mat3(6.0, 8.0, -8.0, 7.0, -1.0, 4.0, 0.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3(var[2][2][1], mat3(2.0, 8.0, 8.0, -5.0, 4.0, -5.0, 8.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3(var[2][3][0], mat3(1.0, -4.0, -4.0, 1.0, -5.0, -1.0, -9.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat3(var[2][3][1], mat3(-7.0, -8.0, -7.0, -4.0, -7.0, 6.0, -9.0, 7.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3(-1.0, -8.0, 7.0, -5.0, 5.0, 6.0, 0.0, -8.0, -6.0));
	var[0][0][1] = (mat3(-4.0, 3.0, 7.0, 1.0, -1.0, 9.0, 6.0, 2.0, 9.0));
	var[0][1][0] = (mat3(-2.0, 9.0, 0.0, 0.0, -3.0, -9.0, -6.0, 5.0, 0.0));
	var[0][1][1] = (mat3(-5.0, 6.0, 3.0, -2.0, 5.0, 6.0, 9.0, -9.0, 8.0));
	var[0][2][0] = (mat3(1.0, -8.0, 4.0, 5.0, 7.0, 9.0, 5.0, 8.0, -6.0));
	var[0][2][1] = (mat3(-9.0, -5.0, 9.0, 8.0, -9.0, -8.0, -5.0, 6.0, -7.0));
	var[0][3][0] = (mat3(2.0, 2.0, -3.0, 0.0, 0.0, 9.0, 3.0, 9.0, 2.0));
	var[0][3][1] = (mat3(1.0, -8.0, 5.0, -8.0, -4.0, 5.0, -4.0, 5.0, 3.0));
	var[1][0][0] = (mat3(-6.0, 8.0, 0.0, 1.0, 4.0, 6.0, -9.0, -9.0, 2.0));
	var[1][0][1] = (mat3(8.0, -1.0, 9.0, 9.0, 7.0, -5.0, -5.0, -8.0, 8.0));
	var[1][1][0] = (mat3(6.0, 6.0, -9.0, -8.0, -3.0, -7.0, 6.0, -1.0, -6.0));
	var[1][1][1] = (mat3(-1.0, 6.0, -1.0, 1.0, -5.0, -8.0, 2.0, -7.0, -4.0));
	var[1][2][0] = (mat3(2.0, 4.0, 5.0, -8.0, -2.0, 8.0, 6.0, 2.0, -9.0));
	var[1][2][1] = (mat3(-8.0, 1.0, -1.0, 7.0, -2.0, -3.0, 5.0, 3.0, 0.0));
	var[1][3][0] = (mat3(2.0, 4.0, 4.0, -7.0, -3.0, 4.0, -2.0, -2.0, 9.0));
	var[1][3][1] = (mat3(-1.0, -5.0, -7.0, -6.0, -6.0, 4.0, 0.0, -9.0, 8.0));
	var[2][0][0] = (mat3(-2.0, 9.0, 8.0, -9.0, 3.0, 2.0, 9.0, 1.0, 2.0));
	var[2][0][1] = (mat3(-9.0, -7.0, -5.0, -3.0, 7.0, 2.0, -1.0, 1.0, 2.0));
	var[2][1][0] = (mat3(3.0, -9.0, 2.0, -1.0, 4.0, 3.0, -2.0, 9.0, -3.0));
	var[2][1][1] = (mat3(-6.0, -9.0, 6.0, 9.0, 0.0, 3.0, 8.0, -4.0, -4.0));
	var[2][2][0] = (mat3(-1.0, -2.0, -3.0, 3.0, -9.0, -3.0, -4.0, -7.0, -5.0));
	var[2][2][1] = (mat3(-8.0, 9.0, 8.0, 8.0, 4.0, 5.0, 1.0, 8.0, 7.0));
	var[2][3][0] = (mat3(-2.0, 1.0, -3.0, 1.0, -3.0, -7.0, -3.0, 6.0, -6.0));
	var[2][3][1] = (mat3(3.0, 9.0, 2.0, 3.0, 9.0, -1.0, -7.0, 4.0, 2.0));
}
#version 450
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
	highp mat4x2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0][0][0], mat4x2(0.0, 6.0, -3.0, 7.0, 1.0, -8.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][1], mat4x2(2.0, -3.0, -5.0, 5.0, 5.0, 1.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][0], mat4x2(9.0, 5.0, 0.0, -5.0, 6.0, -8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][1], mat4x2(2.0, 6.0, -5.0, 2.0, -8.0, -2.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[0][2][0], mat4x2(-2.0, -6.0, 4.0, 4.0, 5.0, -9.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[0][2][1], mat4x2(-3.0, 4.0, 3.0, -2.0, -5.0, 0.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[0][3][0], mat4x2(1.0, -7.0, -5.0, 9.0, -9.0, -1.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[0][3][1], mat4x2(-7.0, 7.0, 2.0, 7.0, -3.0, -8.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][0], mat4x2(1.0, 1.0, -2.0, -3.0, -9.0, 3.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][1], mat4x2(6.0, -2.0, -9.0, 5.0, -5.0, -6.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][0], mat4x2(6.0, -1.0, 6.0, -3.0, 4.0, 0.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][1], mat4x2(-5.0, 8.0, 8.0, -7.0, 4.0, 6.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[1][2][0], mat4x2(-3.0, 4.0, -5.0, -8.0, 5.0, -3.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[1][2][1], mat4x2(3.0, 4.0, -7.0, 4.0, -9.0, 4.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[1][3][0], mat4x2(-4.0, -2.0, 8.0, 3.0, -2.0, 8.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[1][3][1], mat4x2(1.0, -7.0, -1.0, 4.0, 4.0, -5.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][0], mat4x2(5.0, -3.0, 5.0, 6.0, -4.0, -8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][1], mat4x2(-5.0, 4.0, -9.0, 6.0, 8.0, -3.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][0], mat4x2(-9.0, -8.0, 9.0, -2.0, -7.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][1], mat4x2(-5.0, 0.0, 3.0, 9.0, -8.0, -1.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[2][2][0], mat4x2(-7.0, 4.0, -9.0, -9.0, -6.0, 2.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[2][2][1], mat4x2(-6.0, 6.0, -7.0, -6.0, -7.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[2][3][0], mat4x2(-2.0, 0.0, -5.0, -8.0, -4.0, -9.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[2][3][1], mat4x2(1.0, 9.0, -1.0, 7.0, -9.0, -1.0, -4.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4x2(8.0, -5.0, 3.0, 0.0, -9.0, 4.0, -5.0, 3.0));
	var[0][0][1] = (mat4x2(6.0, 3.0, 6.0, -6.0, 0.0, -3.0, -2.0, -4.0));
	var[0][1][0] = (mat4x2(1.0, -6.0, 2.0, 4.0, 7.0, 1.0, 9.0, 5.0));
	var[0][1][1] = (mat4x2(8.0, -7.0, 6.0, -7.0, -4.0, 5.0, 3.0, -2.0));
	var[0][2][0] = (mat4x2(4.0, 9.0, -8.0, 5.0, 3.0, 3.0, -4.0, 8.0));
	var[0][2][1] = (mat4x2(-7.0, 2.0, 2.0, -4.0, 6.0, -1.0, 1.0, 1.0));
	var[0][3][0] = (mat4x2(8.0, -7.0, 4.0, 5.0, -8.0, -6.0, -7.0, 1.0));
	var[0][3][1] = (mat4x2(1.0, 6.0, -8.0, -5.0, -6.0, 2.0, -9.0, 0.0));
	var[1][0][0] = (mat4x2(5.0, 4.0, 1.0, 0.0, 7.0, -9.0, -4.0, 5.0));
	var[1][0][1] = (mat4x2(6.0, 1.0, 0.0, 3.0, 2.0, -5.0, -4.0, 5.0));
	var[1][1][0] = (mat4x2(-2.0, -5.0, -1.0, 1.0, -8.0, 4.0, 9.0, 2.0));
	var[1][1][1] = (mat4x2(-5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 1.0, 1.0));
	var[1][2][0] = (mat4x2(-9.0, 7.0, 9.0, -1.0, 3.0, -9.0, 2.0, -2.0));
	var[1][2][1] = (mat4x2(4.0, 1.0, 2.0, 3.0, 5.0, -3.0, -8.0, -1.0));
	var[1][3][0] = (mat4x2(-6.0, 4.0, 2.0, 8.0, 2.0, 4.0, -9.0, 9.0));
	var[1][3][1] = (mat4x2(5.0, -4.0, 5.0, 4.0, -8.0, -6.0, 4.0, 0.0));
	var[2][0][0] = (mat4x2(5.0, -4.0, -7.0, -8.0, 9.0, -4.0, 5.0, 5.0));
	var[2][0][1] = (mat4x2(-1.0, 6.0, -6.0, 5.0, 4.0, -3.0, 1.0, -4.0));
	var[2][1][0] = (mat4x2(1.0, -9.0, -1.0, 6.0, -9.0, -7.0, -8.0, 8.0));
	var[2][1][1] = (mat4x2(-2.0, 7.0, 8.0, -9.0, 4.0, -3.0, 0.0, -7.0));
	var[2][2][0] = (mat4x2(2.0, 6.0, -3.0, 8.0, 3.0, -4.0, 8.0, 5.0));
	var[2][2][1] = (mat4x2(-4.0, 6.0, 7.0, -3.0, 1.0, 9.0, 7.0, 4.0));
	var[2][3][0] = (mat4x2(7.0, -2.0, 3.0, -5.0, -4.0, 1.0, -3.0, 6.0));
	var[2][3][1] = (mat4x2(-3.0, -1.0, 4.0, -1.0, -1.0, -7.0, -7.0, 6.0));
}
#version 450
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
	allOk = compare_mat2x4(var[0][0][0], mat2x4(-2.0, 4.0, 3.0, 6.0, 3.0, -7.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(6.0, 4.0, 0.0, 9.0, -2.0, 9.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(-9.0, -1.0, 5.0, -7.0, -9.0, -6.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(1.0, 2.0, -6.0, 1.0, -5.0, 3.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[0][2][0], mat2x4(6.0, 0.0, 6.0, 8.0, -9.0, 4.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[0][2][1], mat2x4(-9.0, -1.0, 7.0, 9.0, 0.0, -2.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[0][3][0], mat2x4(9.0, -3.0, -7.0, 2.0, -4.0, -3.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[0][3][1], mat2x4(1.0, -8.0, -2.0, 6.0, 8.0, 9.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(1.0, -7.0, 0.0, 6.0, -6.0, 9.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(9.0, -9.0, 3.0, -1.0, -8.0, -5.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(-8.0, 1.0, -5.0, 0.0, 7.0, 5.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(-7.0, -6.0, 2.0, 4.0, -8.0, 4.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[1][2][0], mat2x4(-8.0, 4.0, 8.0, 3.0, -3.0, -8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[1][2][1], mat2x4(-9.0, 6.0, -4.0, -8.0, -5.0, -4.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[1][3][0], mat2x4(-7.0, 3.0, 5.0, -3.0, -6.0, 8.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[1][3][1], mat2x4(-6.0, -9.0, 7.0, 2.0, -1.0, 5.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(6.0, -4.0, -5.0, -3.0, -7.0, 1.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(0.0, -5.0, 1.0, 2.0, 7.0, 2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(-5.0, -2.0, -6.0, -2.0, -6.0, 1.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(2.0, -3.0, -2.0, 4.0, 6.0, -7.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[2][2][0], mat2x4(-8.0, 0.0, 4.0, -6.0, 5.0, 2.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[2][2][1], mat2x4(-1.0, -2.0, 0.0, -7.0, 8.0, -2.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[2][3][0], mat2x4(4.0, 2.0, 9.0, -9.0, -1.0, 9.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[2][3][1], mat2x4(7.0, 8.0, 4.0, -3.0, 7.0, 5.0, 2.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2x4(-5.0, -7.0, -7.0, 0.0, -1.0, -9.0, 5.0, -5.0));
	var[0][0][1] = (mat2x4(0.0, 1.0, 8.0, 9.0, 2.0, 4.0, 5.0, 5.0));
	var[0][1][0] = (mat2x4(0.0, -6.0, -6.0, 6.0, -1.0, 8.0, 4.0, 1.0));
	var[0][1][1] = (mat2x4(-5.0, 4.0, -3.0, 3.0, 1.0, -9.0, -1.0, -2.0));
	var[0][2][0] = (mat2x4(8.0, 3.0, 0.0, -3.0, 5.0, -4.0, 8.0, -3.0));
	var[0][2][1] = (mat2x4(7.0, -1.0, 5.0, 0.0, -5.0, 2.0, -3.0, -8.0));
	var[0][3][0] = (mat2x4(-3.0, -9.0, -7.0, -5.0, -2.0, 8.0, -8.0, -8.0));
	var[0][3][1] = (mat2x4(-5.0, 1.0, -1.0, 8.0, 3.0, 3.0, -4.0, 8.0));
	var[1][0][0] = (mat2x4(3.0, 6.0, 2.0, 7.0, -1.0, -8.0, 7.0, -7.0));
	var[1][0][1] = (mat2x4(-8.0, -9.0, 5.0, -5.0, 5.0, -9.0, -7.0, -2.0));
	var[1][1][0] = (mat2x4(-4.0, -7.0, -9.0, 5.0, -3.0, -7.0, 8.0, 3.0));
	var[1][1][1] = (mat2x4(-1.0, 7.0, 6.0, -6.0, -8.0, -8.0, -4.0, 6.0));
	var[1][2][0] = (mat2x4(-9.0, 5.0, -6.0, -2.0, 0.0, 0.0, -2.0, -9.0));
	var[1][2][1] = (mat2x4(3.0, -5.0, -5.0, -6.0, 3.0, 0.0, -2.0, 5.0));
	var[1][3][0] = (mat2x4(2.0, 5.0, -9.0, 0.0, -3.0, 2.0, -2.0, 9.0));
	var[1][3][1] = (mat2x4(-7.0, -3.0, 5.0, -4.0, -2.0, 0.0, 2.0, -6.0));
	var[2][0][0] = (mat2x4(-5.0, 8.0, -8.0, -8.0, 5.0, 4.0, -2.0, -7.0));
	var[2][0][1] = (mat2x4(-6.0, -7.0, 4.0, -6.0, 9.0, 7.0, 1.0, 7.0));
	var[2][1][0] = (mat2x4(-5.0, 3.0, -1.0, -5.0, 7.0, -3.0, -2.0, -2.0));
	var[2][1][1] = (mat2x4(5.0, 7.0, -6.0, -5.0, -9.0, 3.0, 7.0, 0.0));
	var[2][2][0] = (mat2x4(-9.0, -9.0, 4.0, -7.0, -9.0, -2.0, 5.0, 9.0));
	var[2][2][1] = (mat2x4(0.0, 6.0, -3.0, -4.0, 0.0, -2.0, 8.0, 1.0));
	var[2][3][0] = (mat2x4(2.0, 3.0, 1.0, 6.0, -7.0, -8.0, -7.0, 9.0));
	var[2][3][1] = (mat2x4(-6.0, -2.0, -6.0, -8.0, -5.0, 7.0, 9.0, -5.0));
}
#version 450
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
	highp ivec2 var[][4][2];
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((var[0][0][0]), ivec2(6, -1)) && allOk;
	allOk = compare_ivec2((var[0][0][1]), ivec2(7, -5)) && allOk;
	allOk = compare_ivec2((var[0][1][0]), ivec2(-1, -1)) && allOk;
	allOk = compare_ivec2((var[0][1][1]), ivec2(0, 8)) && allOk;
	allOk = compare_ivec2((var[0][2][0]), ivec2(-4, 1)) && allOk;
	allOk = compare_ivec2((var[0][2][1]), ivec2(-3, -1)) && allOk;
	allOk = compare_ivec2((var[0][3][0]), ivec2(6, 3)) && allOk;
	allOk = compare_ivec2((var[0][3][1]), ivec2(-5, -3)) && allOk;
	allOk = compare_ivec2((var[1][0][0]), ivec2(-8, 8)) && allOk;
	allOk = compare_ivec2((var[1][0][1]), ivec2(-2, -6)) && allOk;
	allOk = compare_ivec2((var[1][1][0]), ivec2(-9, -5)) && allOk;
	allOk = compare_ivec2((var[1][1][1]), ivec2(6, 4)) && allOk;
	allOk = compare_ivec2((var[1][2][0]), ivec2(2, 1)) && allOk;
	allOk = compare_ivec2((var[1][2][1]), ivec2(-4, -3)) && allOk;
	allOk = compare_ivec2((var[1][3][0]), ivec2(-4, 7)) && allOk;
	allOk = compare_ivec2((var[1][3][1]), ivec2(-3, -4)) && allOk;
	allOk = compare_ivec2((var[2][0][0]), ivec2(6, 2)) && allOk;
	allOk = compare_ivec2((var[2][0][1]), ivec2(-2, 7)) && allOk;
	allOk = compare_ivec2((var[2][1][0]), ivec2(-8, 3)) && allOk;
	allOk = compare_ivec2((var[2][1][1]), ivec2(7, -6)) && allOk;
	allOk = compare_ivec2((var[2][2][0]), ivec2(-9, 0)) && allOk;
	allOk = compare_ivec2((var[2][2][1]), ivec2(9, 8)) && allOk;
	allOk = compare_ivec2((var[2][3][0]), ivec2(8, -5)) && allOk;
	allOk = compare_ivec2((var[2][3][1]), ivec2(-2, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (ivec2(-6, 8));
	var[0][0][1] = (ivec2(3, -1));
	var[0][1][0] = (ivec2(-6, -4));
	var[0][1][1] = (ivec2(3, -2));
	var[0][2][0] = (ivec2(4, 1));
	var[0][2][1] = (ivec2(1, 9));
	var[0][3][0] = (ivec2(-3, -1));
	var[0][3][1] = (ivec2(-4, 6));
	var[1][0][0] = (ivec2(-5, -2));
	var[1][0][1] = (ivec2(0, -2));
	var[1][1][0] = (ivec2(5, -7));
	var[1][1][1] = (ivec2(-3, 4));
	var[1][2][0] = (ivec2(-2, -9));
	var[1][2][1] = (ivec2(9, 6));
	var[1][3][0] = (ivec2(-4, -7));
	var[1][3][1] = (ivec2(-9, 1));
	var[2][0][0] = (ivec2(5, 2));
	var[2][0][1] = (ivec2(-8, 4));
	var[2][1][0] = (ivec2(1, 6));
	var[2][1][1] = (ivec2(8, 7));
	var[2][2][0] = (ivec2(-8, 1));
	var[2][2][1] = (ivec2(-3, 2));
	var[2][3][0] = (ivec2(8, 1));
	var[2][3][1] = (ivec2(-8, 3));
}
#version 450
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
	allOk = compare_ivec3((block[0].s[0][0].a), ivec3(7, -9, -9)) && allOk;
	allOk = compare_vec4((block[0].s[0][0].c), vec4(1.0, -1.0, -5.0, -3.0)) && allOk;
	allOk = compare_ivec3((block[0].s[0][1].a), ivec3(-4, 1, -9)) && allOk;
	allOk = compare_vec4((block[0].s[0][1].c), vec4(3.0, -7.0, 2.0, -7.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1][0].a), ivec3(-8, 4, -5)) && allOk;
	allOk = compare_vec4((block[0].s[1][0].c), vec4(-3.0, 9.0, -9.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1][1].a), ivec3(-8, 5, -7)) && allOk;
	allOk = compare_vec4((block[0].s[1][1].c), vec4(-5.0, 1.0, -6.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2][0].a), ivec3(-7, 2, 3)) && allOk;
	allOk = compare_vec4((block[0].s[2][0].c), vec4(-6.0, -4.0, 6.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2][1].a), ivec3(-9, 6, 5)) && allOk;
	allOk = compare_vec4((block[0].s[2][1].c), vec4(-5.0, 8.0, -2.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0][0].a), ivec3(7, 5, 9)) && allOk;
	allOk = compare_vec4((block[1].s[0][0].c), vec4(-4.0, 9.0, 1.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0][1].a), ivec3(4, 2, 6)) && allOk;
	allOk = compare_vec4((block[1].s[0][1].c), vec4(-4.0, 8.0, -2.0, 3.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1][0].a), ivec3(-2, 5, -3)) && allOk;
	allOk = compare_vec4((block[1].s[1][0].c), vec4(-8.0, -8.0, 1.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1][1].a), ivec3(2, 5, -6)) && allOk;
	allOk = compare_vec4((block[1].s[1][1].c), vec4(-5.0, 5.0, 5.0, -1.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0][0].a), ivec3(5, -4, 4)) && allOk;
	allOk = compare_vec4((block[2].s[0][0].c), vec4(6.0, -6.0, -9.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0][1].a), ivec3(1, -6, 7)) && allOk;
	allOk = compare_vec4((block[2].s[0][1].c), vec4(7.0, -9.0, 9.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].v = (vec4(-8.0, 2.0, 3.0, -5.0));
	block[0].s[0][0].a = (ivec3(3, -3, 5));
	block[0].s[0][0].c = (vec4(-1.0, 8.0, 2.0, -1.0));
	block[0].s[0][1].a = (ivec3(7, 1, -1));
	block[0].s[0][1].c = (vec4(7.0, 0.0, -4.0, -2.0));
	block[0].s[1][0].a = (ivec3(-6, -6, -1));
	block[0].s[1][0].c = (vec4(0.0, -9.0, -5.0, -1.0));
	block[0].s[1][1].a = (ivec3(-4, 9, -6));
	block[0].s[1][1].c = (vec4(-4.0, 6.0, -2.0, 5.0));
	block[0].s[2][0].a = (ivec3(-4, -1, -5));
	block[0].s[2][0].c = (vec4(7.0, -2.0, -1.0, 0.0));
	block[0].s[2][1].a = (ivec3(-6, 6, 9));
	block[0].s[2][1].c = (vec4(-6.0, 9.0, -5.0, 4.0));
	block[1].v = (vec4(8.0, -2.0, -2.0, -2.0));
	block[1].s[0][0].a = (ivec3(-7, -4, 9));
	block[1].s[0][0].c = (vec4(-5.0, 2.0, 4.0, -7.0));
	block[1].s[0][1].a = (ivec3(-3, -2, 2));
	block[1].s[0][1].c = (vec4(1.0, -8.0, -4.0, 8.0));
	block[1].s[1][0].a = (ivec3(-8, -1, 9));
	block[1].s[1][0].c = (vec4(7.0, 3.0, 9.0, 6.0));
	block[1].s[1][1].a = (ivec3(6, -8, 9));
	block[1].s[1][1].c = (vec4(1.0, 7.0, -4.0, -2.0));
	block[2].v = (vec4(8.0, -3.0, 8.0, 0.0));
	block[2].s[0][0].a = (ivec3(7, -8, 1));
	block[2].s[0][0].c = (vec4(-9.0, 8.0, -1.0, -2.0));
	block[2].s[0][1].a = (ivec3(-7, -5, 4));
	block[2].s[0][1].c = (vec4(9.0, 6.0, -4.0, 0.0));
}
#version 450
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
	highp uvec4 var;
} block[3];

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((block[0].var), uvec4(4u, 1u, 8u, 2u)) && allOk;
	allOk = compare_uvec4((block[1].var), uvec4(1u, 9u, 5u, 9u)) && allOk;
	allOk = compare_uvec4((block[2].var), uvec4(3u, 6u, 5u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (uvec4(2u, 7u, 2u, 9u));
	block[1].var = (uvec4(7u, 9u, 5u, 1u));
	block[2].var = (uvec4(3u, 4u, 4u, 2u));
}
#version 450
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
	highp mat2x3 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), -2.0) && allOk;
	allOk = compare_mat2x3(block[0].var, mat2x3(3.0, -3.0, 8.0, 7.0, 4.0, -4.0)) && allOk;
	allOk = compare_float((block[1].padding), -6.0) && allOk;
	allOk = compare_mat2x3(block[1].var, mat2x3(-3.0, -8.0, 6.0, -4.0, 1.0, -5.0)) && allOk;
	allOk = compare_float((block[2].padding), 8.0) && allOk;
	allOk = compare_mat2x3(block[2].var, mat2x3(-3.0, 0.0, -4.0, 6.0, -1.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (0.0);
	block[0].var = (mat2x3(4.0, 4.0, 5.0, -5.0, 2.0, 8.0));
	block[1].padding = (-1.0);
	block[1].var = (mat2x3(-2.0, -7.0, -8.0, -2.0, 2.0, -2.0));
	block[2].padding = (7.0);
	block[2].var = (mat2x3(-9.0, 7.0, -7.0, -5.0, 6.0, 8.0));
}
#version 450
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
	lowp ivec4 a;
	lowp uvec3 b;
	lowp mat3 c;
	mediump mat2x3 d;
	lowp vec4 e[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((a), ivec4(-8, -8, 0, -9)) && allOk;
	allOk = compare_mat3(c, mat3(0.0, 1.0, -6.0, -2.0, 5.0, 9.0, -5.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x3(d, mat2x3(3.0, 5.0, 5.0, 7.0, -6.0, -9.0)) && allOk;
	allOk = compare_vec4((e[0]), vec4(-2.0, 4.0, -1.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (uvec3(5u, 6u, 5u));
}
#version 450
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
	mediump uvec2 a;
	mediump ivec4 b;
	mediump uvec3 c;
	mediump mat4x2 d[];
};
layout(std430, row_major, binding = 2) readonly buffer BlockC
{
	mediump mat3x4 e[1];
};
layout(std140, row_major, binding = 3) buffer BlockD
{
	lowp mat3 f;
	bool g;
	lowp ivec3 h[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((c), uvec3(4u, 3u, 2u)) && allOk;
	allOk = compare_mat3(f, mat3(-6.0, -5.0, -5.0, 8.0, 9.0, -3.0, 2.0, 3.0, 0.0)) && allOk;
	allOk = compare_bool((g), false) && allOk;
	allOk = compare_ivec3((h[0]), ivec3(-4, 4, -6)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (ivec4(5, 5, -3, -5));
	c = (uvec3(4u, 2u, 4u));
	d[0] = (mat4x2(2.0, 6.0, 1.0, 9.0, -5.0, 9.0, -3.0, 6.0));
	g = (false);
	h[0] = (ivec3(4, -5, -2));
}
#version 450
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
	highp mat2x3 a[];
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	mediump mat2 b;
	highp mat3 c;
	highp mat4x2 d;
	mediump mat3x4 e;
	bool f[];
} blockC;
layout(std140, column_major, binding = 3) readonly buffer BlockD
{
	highp uint g[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB.a[0], mat2x3(-9.0, 2.0, 5.0, 9.0, 0.0, 5.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[1], mat2x3(5.0, -2.0, 1.0, -5.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[2], mat2x3(-8.0, 9.0, -8.0, -5.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[3], mat2x3(5.0, -8.0, 7.0, -5.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[4], mat2x3(8.0, 7.0, -4.0, -5.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[5], mat2x3(5.0, -2.0, 0.0, 0.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[6], mat2x3(-4.0, 6.0, -9.0, -1.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[7], mat2x3(0.0, -6.0, 5.0, -4.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4x2(blockC.d, mat4x2(-1.0, 9.0, 6.0, 3.0, 8.0, -7.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3x4(blockC.e, mat3x4(7.0, -2.0, -9.0, -5.0, -6.0, 4.0, -9.0, -7.0, 8.0, -7.0, -6.0, -9.0)) && allOk;
	allOk = compare_bool((blockC.f[0]), true) && allOk;
	allOk = compare_bool((blockC.f[1]), false) && allOk;
	allOk = compare_bool((blockC.f[2]), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (mat2(-8.0, 9.0, 2.0, 1.0));
	blockC.c = (mat3(-2.0, -3.0, -1.0, 2.0, -5.0, 4.0, -6.0, -5.0, -3.0));
	blockC.d = (mat4x2(-5.0, 6.0, 6.0, -1.0, -3.0, -7.0, -3.0, -6.0));
	blockC.f[0] = (false);
	blockC.f[1] = (true);
	blockC.f[2] = (false);
}
#version 450
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
	highp mat2x3 mB;
	highp mat2x3 mC;
};
layout(std140, binding = 1) buffer BlockB
{
	bool a;
	bvec2 b;
	lowp mat2x3 c;
	lowp vec2 d;
	lowp vec2 e[];
};
layout(std140, binding = 2) buffer BlockC
{
	bvec4 f;
	lowp ivec3 g;
	lowp ivec4 h;
	highp ivec4 i;
	sA j[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((a), true) && allOk;
	allOk = compare_bvec2((b), bvec2(false, false)) && allOk;
	allOk = compare_vec2((d), vec2(6.0, 8.0)) && allOk;
	allOk = compare_ivec4((h), ivec4(6, -4, -1, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	e[0] = (vec2(3.0, 4.0));
	f = (bvec4(true, false, false, false));
	h = (ivec4(-7, 3, -7, -5));
	i = (ivec4(7, 5, 5, 7));
	j[0].mA = (bvec3(true, false, true));
	j[0].mB = (mat2x3(6.0, 3.0, -7.0, -9.0, -2.0, -9.0));
	j[0].mC = (mat2x3(8.0, -7.0, 2.0, 8.0, -4.0, 1.0));
	j[1].mA = (bvec3(false, true, true));
	j[1].mB = (mat2x3(9.0, 7.0, 0.0, 2.0, 3.0, -4.0));
	j[1].mC = (mat2x3(-7.0, 6.0, -2.0, -4.0, 7.0, -9.0));
	j[2].mA = (bvec3(true, false, false));
	j[2].mB = (mat2x3(-9.0, -5.0, 4.0, -2.0, -3.0, 3.0));
	j[2].mC = (mat2x3(1.0, -9.0, -7.0, -7.0, -7.0, -1.0));
	j[3].mA = (bvec3(false, false, false));
	j[3].mB = (mat2x3(6.0, -6.0, 9.0, -8.0, 4.0, 4.0));
	j[3].mC = (mat2x3(-5.0, -5.0, -9.0, 4.0, -7.0, 3.0));
	j[4].mA = (bvec3(false, false, false));
	j[4].mB = (mat2x3(7.0, -6.0, 7.0, -9.0, -2.0, 3.0));
	j[4].mC = (mat2x3(-6.0, -6.0, 3.0, -5.0, -3.0, 2.0));
	j[5].mA = (bvec3(true, false, true));
	j[5].mB = (mat2x3(-8.0, -8.0, 9.0, 5.0, 1.0, -5.0));
	j[5].mC = (mat2x3(7.0, 5.0, 3.0, 4.0, -1.0, -3.0));
	j[6].mA = (bvec3(false, false, true));
	j[6].mB = (mat2x3(8.0, -4.0, 5.0, 0.0, 6.0, 3.0));
	j[6].mC = (mat2x3(-7.0, -6.0, 6.0, 6.0, 2.0, -7.0));
}
#version 450
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
	highp vec3 mB[4];
	highp uvec3 mC;
	highp uvec2 mD;
};
struct sB
{
	highp mat3x4 mA;
	sA mB;
	mediump uvec4 mC;
	mediump uvec3 mD;
};
layout(std430, row_major, binding = 1) buffer BlockB
{
	mediump ivec2 a;
	mediump mat3x4 b;
	lowp mat3x4 c;
	highp mat2 d;
	mediump mat2 e;
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	lowp vec3 f;
	sB g;
	lowp float h[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(b, mat3x4(-9.0, -7.0, 3.0, -5.0, 3.0, 7.0, 9.0, -2.0, 0.0, -2.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3x4(c, mat3x4(9.0, -6.0, 1.0, 2.0, -1.0, -9.0, -6.0, 5.0, -9.0, 6.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat2(d, mat2(4.0, -7.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2(e, mat2(1.0, -7.0, 2.0, 5.0)) && allOk;
	allOk = compare_vec3((f), vec3(-6.0, -9.0, -8.0)) && allOk;
	allOk = compare_float((h[0]), -7.0) && allOk;
	allOk = compare_float((h[1]), -9.0) && allOk;
	allOk = compare_float((h[2]), -6.0) && allOk;
	allOk = compare_float((h[3]), 4.0) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (ivec2(8, 9));
	c = (mat3x4(-2.0, 9.0, 5.0, -7.0, -8.0, 4.0, -1.0, 5.0, -6.0, -5.0, 4.0, -6.0));
	d = (mat2(4.0, 9.0, -3.0, 0.0));
	e = (mat2(-8.0, -8.0, 6.0, -7.0));
	h[0] = (2.0);
	h[1] = (0.0);
	h[2] = (8.0);
	h[3] = (8.0);
}
#version 450
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
	highp vec4 mB;
};
struct sB
{
	highp mat3x2 mA;
	bool mB;
	sA mC;
};
struct sC
{
	highp mat4 mA;
	mediump vec4 mB;
	highp ivec4 mC;
	mediump uvec4 mD[4];
};
struct sD
{
	mediump float mA;
	mediump mat2x3 mB;
	lowp uvec3 mC;
	lowp uvec3 mD[8];
};
struct sE
{
	mediump mat4 mA;
	lowp mat4 mB;
	mediump mat3 mC;
	highp vec4 mD;
};
layout(std140, binding = 1) buffer BlockB
{
	highp mat3x2 a[6];
	sB b;
	lowp uvec4 c;
	bvec4 d;
	lowp mat4 e[];
} blockB;
layout(std140, row_major, binding = 2) buffer BlockC
{
	sC f;
	highp ivec4 g;
	mediump mat4x2 h[][3];
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	bvec2 i;
} blockD;
layout(std430, column_major, binding = 4) buffer BlockE
{
	highp mat4 j;
	mediump vec3 k;
	mediump int l;
	sD m;
	sE n[];
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
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.a[0], mat3x2(7.0, -4.0, 4.0, 3.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[1], mat3x2(2.0, -1.0, 9.0, -8.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[2], mat3x2(6.0, -6.0, -3.0, -6.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[3], mat3x2(2.0, 9.0, 1.0, -6.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[4], mat3x2(-1.0, 1.0, 3.0, -2.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[5], mat3x2(6.0, 2.0, 6.0, 8.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockB.b.mA, mat3x2(8.0, -5.0, 3.0, -4.0, -8.0, -5.0)) && allOk;
	allOk = compare_bool((blockB.b.mB), true) && allOk;
	allOk = compare_ivec3((blockB.b.mC.mA), ivec3(-9, 5, 3)) && allOk;
	allOk = compare_vec4((blockB.b.mC.mB), vec4(7.0, -8.0, -3.0, -1.0)) && allOk;
	allOk = compare_uvec4((blockB.c), uvec4(6u, 5u, 6u, 3u)) && allOk;
	allOk = compare_bvec4((blockB.d), bvec4(false, true, true, false)) && allOk;
	allOk = compare_mat4(blockB.e[0], mat4(0.0, -7.0, 2.0, 9.0, -1.0, 0.0, 0.0, 8.0, 7.0, 4.0, -2.0, -2.0, -1.0, -3.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat4(blockB.e[1], mat4(-5.0, -9.0, 9.0, 4.0, 6.0, 9.0, 3.0, 0.0, -2.0, -5.0, 4.0, 2.0, 8.0, -4.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat4(blockB.e[2], mat4(-9.0, 8.0, -1.0, 6.0, 9.0, 6.0, 5.0, 8.0, -3.0, 0.0, 5.0, 5.0, -8.0, 1.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4(blockB.e[3], mat4(2.0, 5.0, -4.0, 1.0, -4.0, -8.0, -2.0, 7.0, 3.0, 3.0, 1.0, -8.0, 7.0, 5.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4(blockB.e[4], mat4(6.0, 2.0, 7.0, 6.0, 1.0, 1.0, -2.0, 4.0, 6.0, 5.0, -2.0, 0.0, -3.0, 0.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4(blockC.f.mA, mat4(0.0, -6.0, -4.0, -4.0, -6.0, 3.0, 5.0, 8.0, -5.0, -1.0, -8.0, 5.0, 4.0, -7.0, 8.0, 8.0)) && allOk;
	allOk = compare_vec4((blockC.f.mB), vec4(-1.0, -5.0, -6.0, -4.0)) && allOk;
	allOk = compare_ivec4((blockC.f.mC), ivec4(-2, 4, 6, 3)) && allOk;
	allOk = compare_uvec4((blockC.f.mD[0]), uvec4(4u, 1u, 3u, 3u)) && allOk;
	allOk = compare_uvec4((blockC.f.mD[1]), uvec4(8u, 9u, 0u, 8u)) && allOk;
	allOk = compare_uvec4((blockC.f.mD[2]), uvec4(0u, 4u, 8u, 7u)) && allOk;
	allOk = compare_uvec4((blockC.f.mD[3]), uvec4(4u, 6u, 0u, 8u)) && allOk;
	allOk = compare_ivec4((blockC.g), ivec4(2, -5, -3, -7)) && allOk;
	allOk = compare_bvec2((blockD.i), bvec2(false, false)) && allOk;
	allOk = compare_mat4(n[0].mA, mat4(-8.0, -4.0, -2.0, 4.0, 7.0, 0.0, -8.0, 8.0, 6.0, -1.0, 0.0, -5.0, 0.0, -1.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat4(n[0].mB, mat4(-7.0, -2.0, -7.0, -9.0, 3.0, 5.0, 7.0, 9.0, 8.0, 5.0, 1.0, 2.0, 5.0, 0.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3(n[0].mC, mat3(-5.0, 6.0, -5.0, 6.0, 4.0, -6.0, 9.0, 9.0, -1.0)) && allOk;
	allOk = compare_vec4((n[0].mD), vec4(2.0, 1.0, -9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat3x2(-7.0, -2.0, 8.0, -4.0, -8.0, 5.0));
	blockB.a[1] = (mat3x2(3.0, 3.0, 9.0, -4.0, 3.0, -8.0));
	blockB.a[2] = (mat3x2(-8.0, -8.0, -4.0, 2.0, -8.0, -2.0));
	blockB.a[3] = (mat3x2(1.0, 7.0, 6.0, -3.0, -9.0, 6.0));
	blockB.a[4] = (mat3x2(6.0, -6.0, -5.0, -4.0, -2.0, -5.0));
	blockB.a[5] = (mat3x2(9.0, -5.0, -6.0, 0.0, -6.0, 4.0));
	blockB.b.mA = (mat3x2(-7.0, 9.0, 5.0, 9.0, -9.0, 3.0));
	blockB.b.mB = (false);
	blockB.b.mC.mA = (ivec3(8, 4, 3));
	blockB.b.mC.mB = (vec4(6.0, -3.0, -5.0, 5.0));
	blockB.c = (uvec4(2u, 7u, 1u, 2u));
	blockB.e[0] = (mat4(-5.0, -5.0, -1.0, -4.0, 7.0, -5.0, 1.0, 9.0, -6.0, -5.0, 6.0, 9.0, -1.0, 4.0, -3.0, -6.0));
	blockB.e[1] = (mat4(1.0, 0.0, -9.0, -2.0, -5.0, -5.0, -7.0, 7.0, -3.0, 8.0, 0.0, 7.0, 3.0, -4.0, -2.0, -8.0));
	blockB.e[2] = (mat4(0.0, -2.0, 1.0, 5.0, 4.0, -5.0, -5.0, -1.0, 2.0, -5.0, 3.0, 0.0, 1.0, 8.0, -8.0, 1.0));
	blockB.e[3] = (mat4(-4.0, 7.0, 0.0, 2.0, -9.0, -1.0, 9.0, 9.0, 6.0, 0.0, 3.0, 5.0, 8.0, 2.0, 3.0, -8.0));
	blockB.e[4] = (mat4(1.0, 2.0, -3.0, -8.0, -2.0, 0.0, 3.0, 8.0, -5.0, 8.0, -9.0, 4.0, 1.0, 7.0, 7.0, 5.0));
	blockC.f.mA = (mat4(8.0, 8.0, 4.0, -6.0, -6.0, 5.0, -4.0, 8.0, 8.0, -9.0, 5.0, 8.0, 8.0, -3.0, 6.0, 9.0));
	blockC.f.mB = (vec4(-5.0, 8.0, -1.0, 9.0));
	blockC.f.mC = (ivec4(-4, 2, 0, 3));
	blockC.f.mD[0] = (uvec4(7u, 6u, 7u, 9u));
	blockC.f.mD[1] = (uvec4(3u, 4u, 1u, 2u));
	blockC.f.mD[2] = (uvec4(1u, 4u, 6u, 5u));
	blockC.f.mD[3] = (uvec4(0u, 2u, 8u, 0u));
	blockC.g = (ivec4(7, -3, 7, -4));
	blockD.i = (bvec2(false, false));
	j = (mat4(-9.0, -9.0, -9.0, 3.0, -2.0, -9.0, -8.0, 6.0, 7.0, -5.0, -1.0, 3.0, -4.0, 1.0, 5.0, -5.0));
	k = (vec3(9.0, 8.0, 2.0));
	m.mA = (-6.0);
	m.mB = (mat2x3(5.0, -2.0, -2.0, 8.0, 7.0, -3.0));
	m.mC = (uvec3(3u, 5u, 7u));
	m.mD[0] = (uvec3(0u, 3u, 9u));
	m.mD[1] = (uvec3(1u, 7u, 1u));
	m.mD[2] = (uvec3(1u, 8u, 4u));
	m.mD[3] = (uvec3(2u, 7u, 4u));
	m.mD[4] = (uvec3(8u, 4u, 2u));
	m.mD[5] = (uvec3(5u, 5u, 8u));
	m.mD[6] = (uvec3(6u, 5u, 9u));
	m.mD[7] = (uvec3(7u, 7u, 1u));
	n[0].mA = (mat4(-8.0, 7.0, -6.0, 6.0, 0.0, 4.0, 0.0, 3.0, 6.0, 9.0, -5.0, -6.0, -7.0, -3.0, 9.0, 0.0));
	n[0].mB = (mat4(-4.0, -7.0, 6.0, 9.0, 4.0, -2.0, 7.0, -3.0, 2.0, -4.0, -2.0, 0.0, 5.0, 5.0, 6.0, -4.0));
	n[0].mC = (mat3(-8.0, -6.0, -8.0, -2.0, 7.0, 0.0, 5.0, 3.0, 4.0));
	n[0].mD = (vec4(4.0, -1.0, -1.0, 1.0));
}
#version 450
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
	layout(offset = 0) lowp float a;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump uvec3 b;
	layout(offset = 12) mediump float c;
	layout(offset = 16) mediump ivec4 d;
	layout(offset = 32) highp vec4 e[1];
	layout(offset = 48) highp ivec2 f;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) lowp uvec3 g;
} blockD;
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) bvec3 h;
	layout(offset = 16) lowp ivec3 i;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((a), 0.0) && allOk;
	allOk = compare_uvec3((b), uvec3(0u, 0u, 0u)) && allOk;
	allOk = compare_float((c), 7.0) && allOk;
	allOk = compare_ivec4((d), ivec4(5, -6, 1, 9)) && allOk;
	allOk = compare_vec4((e[0]), vec4(-4.0, -3.0, 4.0, 4.0)) && allOk;
	allOk = compare_ivec2((f), ivec2(9, -9)) && allOk;
	allOk = compare_uvec3((blockD.g), uvec3(0u, 7u, 4u)) && allOk;
	allOk = compare_ivec3((blockE.i), ivec3(-1, 7, -5)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (6.0);
	c = (-7.0);
	f = (ivec2(5, -2));
	blockD.g = (uvec3(6u, 0u, 2u));
	blockE.h = (bvec3(false, false, false));
	blockE.i = (ivec3(7, -2, 1));
}
#version 450
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
	layout(offset = 8) highp uvec2 b;
	layout(offset = 16) mediump uvec3 c;
	layout(offset = 32) lowp vec3 d;
} blockB[3];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump vec4 e[1];
	layout(offset = 16) bvec2 f;
	layout(offset = 24) bool g;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB[0].b), uvec2(8u, 0u)) && allOk;
	allOk = compare_vec3((blockB[0].d), vec3(6.0, -7.0, -5.0)) && allOk;
	allOk = compare_uvec2((blockB[1].b), uvec2(5u, 5u)) && allOk;
	allOk = compare_vec3((blockB[1].d), vec3(-1.0, 3.0, 0.0)) && allOk;
	allOk = compare_uvec2((blockB[2].b), uvec2(7u, 1u)) && allOk;
	allOk = compare_vec3((blockB[2].d), vec3(-8.0, -6.0, -5.0)) && allOk;
	allOk = compare_bvec2((blockC.f), bvec2(false, false)) && allOk;
	allOk = compare_bool((blockC.g), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (ivec2(-3, 7));
	blockB[0].b = (uvec2(0u, 4u));
	blockB[0].c = (uvec3(1u, 8u, 7u));
	blockB[0].d = (vec3(3.0, -1.0, 5.0));
	blockB[1].a = (ivec2(0, -4));
	blockB[1].b = (uvec2(9u, 6u));
	blockB[1].c = (uvec3(1u, 5u, 0u));
	blockB[1].d = (vec3(7.0, 3.0, 5.0));
	blockB[2].a = (ivec2(-7, 4));
	blockB[2].b = (uvec2(9u, 2u));
	blockB[2].c = (uvec3(3u, 4u, 2u));
	blockB[2].d = (vec3(1.0, 5.0, 2.0));
	blockC.e[0] = (vec4(-1.0, -8.0, -5.0, -7.0));
	blockC.g = (false);
}
#version 450
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
	bool a;
	highp ivec2 b[][3][8];
};
layout(std140, binding = 2) buffer BlockC
{
	u16vec2 c[3];
	bvec2 d[7];
	lowp vec2 e[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((a), true) && allOk;
	allOk = compare_ivec2((b[0][0][0]), ivec2(3, -8)) && allOk;
	allOk = compare_ivec2((b[0][0][1]), ivec2(3, -5)) && allOk;
	allOk = compare_ivec2((b[0][0][2]), ivec2(-4, -5)) && allOk;
	allOk = compare_ivec2((b[0][0][3]), ivec2(-3, -2)) && allOk;
	allOk = compare_ivec2((b[0][0][4]), ivec2(-3, 6)) && allOk;
	allOk = compare_ivec2((b[0][0][5]), ivec2(-6, 9)) && allOk;
	allOk = compare_ivec2((b[0][0][6]), ivec2(-2, 5)) && allOk;
	allOk = compare_ivec2((b[0][0][7]), ivec2(-6, -3)) && allOk;
	allOk = compare_ivec2((b[0][1][0]), ivec2(5, -7)) && allOk;
	allOk = compare_ivec2((b[0][1][1]), ivec2(-5, -4)) && allOk;
	allOk = compare_ivec2((b[0][1][2]), ivec2(3, 5)) && allOk;
	allOk = compare_ivec2((b[0][1][3]), ivec2(9, -3)) && allOk;
	allOk = compare_ivec2((b[0][1][4]), ivec2(-6, 6)) && allOk;
	allOk = compare_ivec2((b[0][1][5]), ivec2(6, 0)) && allOk;
	allOk = compare_ivec2((b[0][1][6]), ivec2(1, -9)) && allOk;
	allOk = compare_ivec2((b[0][1][7]), ivec2(2, -2)) && allOk;
	allOk = compare_ivec2((b[0][2][0]), ivec2(-4, -7)) && allOk;
	allOk = compare_ivec2((b[0][2][1]), ivec2(2, -6)) && allOk;
	allOk = compare_ivec2((b[0][2][2]), ivec2(-1, 5)) && allOk;
	allOk = compare_ivec2((b[0][2][3]), ivec2(8, -9)) && allOk;
	allOk = compare_ivec2((b[0][2][4]), ivec2(-6, 2)) && allOk;
	allOk = compare_ivec2((b[0][2][5]), ivec2(-8, -9)) && allOk;
	allOk = compare_ivec2((b[0][2][6]), ivec2(4, -8)) && allOk;
	allOk = compare_ivec2((b[0][2][7]), ivec2(-1, 4)) && allOk;
	allOk = compare_ivec2((b[1][0][0]), ivec2(0, -6)) && allOk;
	allOk = compare_ivec2((b[1][0][1]), ivec2(1, 2)) && allOk;
	allOk = compare_ivec2((b[1][0][2]), ivec2(4, 8)) && allOk;
	allOk = compare_ivec2((b[1][0][3]), ivec2(8, 0)) && allOk;
	allOk = compare_ivec2((b[1][0][4]), ivec2(1, 4)) && allOk;
	allOk = compare_ivec2((b[1][0][5]), ivec2(-9, 9)) && allOk;
	allOk = compare_ivec2((b[1][0][6]), ivec2(7, 2)) && allOk;
	allOk = compare_ivec2((b[1][0][7]), ivec2(-8, 7)) && allOk;
	allOk = compare_ivec2((b[1][1][0]), ivec2(-3, 0)) && allOk;
	allOk = compare_ivec2((b[1][1][1]), ivec2(-4, 4)) && allOk;
	allOk = compare_ivec2((b[1][1][2]), ivec2(0, 9)) && allOk;
	allOk = compare_ivec2((b[1][1][3]), ivec2(-5, 7)) && allOk;
	allOk = compare_ivec2((b[1][1][4]), ivec2(-4, 5)) && allOk;
	allOk = compare_ivec2((b[1][1][5]), ivec2(7, -8)) && allOk;
	allOk = compare_ivec2((b[1][1][6]), ivec2(-1, 8)) && allOk;
	allOk = compare_ivec2((b[1][1][7]), ivec2(8, 7)) && allOk;
	allOk = compare_ivec2((b[1][2][0]), ivec2(-9, -7)) && allOk;
	allOk = compare_ivec2((b[1][2][1]), ivec2(4, 3)) && allOk;
	allOk = compare_ivec2((b[1][2][2]), ivec2(6, 7)) && allOk;
	allOk = compare_ivec2((b[1][2][3]), ivec2(5, 7)) && allOk;
	allOk = compare_ivec2((b[1][2][4]), ivec2(6, 8)) && allOk;
	allOk = compare_ivec2((b[1][2][5]), ivec2(-4, -8)) && allOk;
	allOk = compare_ivec2((b[1][2][6]), ivec2(8, 4)) && allOk;
	allOk = compare_ivec2((b[1][2][7]), ivec2(7, 5)) && allOk;
	allOk = compare_bvec2((d[0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((d[1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((d[2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((d[3]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((d[4]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((d[5]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((d[6]), bvec2(false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	c[0] = u16vec2(uvec2(5u, 7u));
	c[1] = u16vec2(uvec2(7u, 0u));
	c[2] = u16vec2(uvec2(2u, 1u));
	d[0] = (bvec2(true, false));
	d[1] = (bvec2(true, false));
	d[2] = (bvec2(false, true));
	d[3] = (bvec2(true, true));
	d[4] = (bvec2(true, true));
	d[5] = (bvec2(false, false));
	d[6] = (bvec2(true, false));
}
#version 450
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
	f16vec2 mA;
	highp ivec2 mB;
	highp mat2x3 mC;
};
struct sB
{
	mediump vec2 mA;
};
struct sC
{
	bvec3 mA;
	sA mB;
	sB mC;
	i16vec4 mD;
};
struct sD
{
	f16vec2 mA;
	float16_t mB;
	f16vec2 mC;
	highp ivec2 mD;
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	lowp mat3x4 a[];
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	f16vec2 b;
	lowp mat4x3 c[];
} blockC;
layout(std140, column_major, binding = 3) buffer BlockD
{
	sC d;
	sD e;
	i16vec2 f;
	mediump vec3 g[];
} blockD[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(a[0], mat3x4(6.0, 8.0, 8.0, 0.0, -4.0, -5.0, 9.0, -4.0, -6.0, -1.0, -1.0, -2.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.b), vec2(1.0, 6.0)) && allOk;
	allOk = compare_mat4x3(blockC.c[0], mat4x3(5.0, 7.0, -2.0, -4.0, -9.0, 8.0, 3.0, 0.0, 2.0, 1.0, 8.0, 0.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD[0].f), ivec2(7, 2)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD[1].f), ivec2(2, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (mat3x4(-5.0, -3.0, -2.0, 0.0, -6.0, 6.0, -6.0, 3.0, -7.0, 8.0, 5.0, -6.0));
	blockC.c[0] = (mat4x3(2.0, 3.0, -1.0, 4.0, -4.0, -6.0, -7.0, -7.0, -4.0, 8.0, 2.0, -9.0));
	blockD[0].d.mA = (bvec3(true, false, false));
	blockD[0].d.mB.mA = f16vec2(vec2(-6.0, -4.0));
	blockD[0].d.mB.mB = (ivec2(-5, 3));
	blockD[0].d.mB.mC = (mat2x3(-5.0, 6.0, -6.0, -2.0, -8.0, 5.0));
	blockD[0].d.mC.mA = (vec2(-4.0, 8.0));
	blockD[0].d.mD = i16vec4(ivec4(-5, 2, -2, 8));
	blockD[0].f = i16vec2(ivec2(-5, 6));
	blockD[0].g[0] = (vec3(5.0, -6.0, -6.0));
	blockD[1].d.mA = (bvec3(false, true, true));
	blockD[1].d.mB.mA = f16vec2(vec2(-4.0, 5.0));
	blockD[1].d.mB.mB = (ivec2(-9, 5));
	blockD[1].d.mB.mC = (mat2x3(-9.0, -5.0, -1.0, -8.0, -7.0, 8.0));
	blockD[1].d.mC.mA = (vec2(2.0, 8.0));
	blockD[1].d.mD = i16vec4(ivec4(-1, -1, 3, -6));
	blockD[1].f = i16vec2(ivec2(-3, -4));
	blockD[1].g[0] = (vec3(-1.0, 7.0, -9.0));
}
#version 450
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
	lowp mat4 mB;
	lowp mat3x4 mC;
	mediump float mD;
};
layout(std430, row_major, binding = 1) buffer BlockB
{
	bvec2 a;
	uint16_t b[];
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	highp vec3 c[1];
	f16vec2 d;
	highp int e;
	bvec3 f;
	sA g[];
} blockC;
layout(std430, column_major, binding = 3) buffer BlockD
{
	bvec3 h;
	highp uint i;
	i16vec3 j[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockC.e), -9) && allOk;
	allOk = compare_uint((blockD.i), 6u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = uint16_t(6u);
	blockC.f = (bvec3(false, false, true));
	blockC.g[0].mA = (ivec3(9, 5, -6));
	blockC.g[0].mB = (mat4(-1.0, -2.0, 2.0, -3.0, -9.0, -5.0, 3.0, 5.0, -5.0, -2.0, -2.0, 8.0, -3.0, -3.0, -8.0, 1.0));
	blockC.g[0].mC = (mat3x4(-3.0, -1.0, 3.0, 7.0, -4.0, -5.0, -1.0, -3.0, 1.0, -9.0, 8.0, 9.0));
	blockC.g[0].mD = (-8.0);
	blockD.h = (bvec3(false, false, false));
	blockD.i = (1u);
}
#version 450
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
	highp mat2x3 mB;
	highp float mC;
	u16vec3 mD[3];
};
layout(std430, binding = 1) buffer BlockB
{
	mediump mat2x3 a[];
} blockB[3];
layout(std430, column_major, binding = 2) buffer BlockC
{
	sA b[6];
	mediump mat4x3 c;
	i16vec3 d;
	mediump uvec2 e;
	highp float f;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB[0].a[0], mat2x3(9.0, -2.0, -1.0, 7.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2x3(blockB[0].a[1], mat2x3(-7.0, -4.0, 2.0, 8.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2x3(blockB[0].a[2], mat2x3(7.0, 6.0, 2.0, -1.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat2x3(blockB[0].a[3], mat2x3(1.0, 4.0, -7.0, -2.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat2x3(blockB[0].a[4], mat2x3(0.0, -2.0, 8.0, -4.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2x3(blockB[0].a[5], mat2x3(4.0, 1.0, 0.0, 7.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2x3(blockB[0].a[6], mat2x3(-3.0, 2.0, 9.0, 7.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat2x3(blockB[1].a[0], mat2x3(-2.0, -3.0, 1.0, 9.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2x3(blockB[1].a[1], mat2x3(-9.0, -4.0, -3.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(blockB[1].a[2], mat2x3(5.0, 3.0, -2.0, 9.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat2x3(blockB[1].a[3], mat2x3(4.0, -6.0, 2.0, 9.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat2x3(blockB[1].a[4], mat2x3(9.0, 1.0, 3.0, 0.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat2x3(blockB[1].a[5], mat2x3(-7.0, 9.0, 0.0, -4.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat2x3(blockB[1].a[6], mat2x3(3.0, 4.0, 6.0, 4.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x3(blockB[1].a[7], mat2x3(-5.0, 0.0, -5.0, 7.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2x3(blockB[2].a[0], mat2x3(-5.0, -5.0, 8.0, 0.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2x3(blockB[2].a[1], mat2x3(8.0, 6.0, -3.0, 1.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat2x3(blockB[2].a[2], mat2x3(8.0, 5.0, -4.0, 6.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat2x3(blockB[2].a[3], mat2x3(-2.0, -8.0, -9.0, -8.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockC.b[0].mA, mat3x2(-2.0, -3.0, 9.0, -2.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(blockC.b[0].mB, mat2x3(-9.0, -2.0, -4.0, -4.0, 9.0, -5.0)) && allOk;
	allOk = compare_float((blockC.b[0].mC), -8.0) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.b[0].mD[0]), uvec3(9u, 5u, 2u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.b[0].mD[1]), uvec3(8u, 1u, 4u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.b[0].mD[2]), uvec3(9u, 8u, 9u)) && allOk;
	allOk = compare_mat3x2(blockC.b[1].mA, mat3x2(-9.0, -1.0, -2.0, 1.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2x3(blockC.b[1].mB, mat2x3(1.0, 0.0, -9.0, -9.0, 8.0, -8.0)) && allOk;
	allOk = compare_float((blockC.b[1].mC), -5.0) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.b[1].mD[0]), uvec3(0u, 6u, 2u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.b[1].mD[1]), uvec3(8u, 9u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.b[1].mD[2]), uvec3(1u, 3u, 3u)) && allOk;
	allOk = compare_mat3x2(blockC.b[2].mA, mat3x2(9.0, 1.0, 9.0, 8.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat2x3(blockC.b[2].mB, mat2x3(-8.0, -5.0, -1.0, -3.0, 2.0, -6.0)) && allOk;
	allOk = compare_float((blockC.b[2].mC), 0.0) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.b[2].mD[0]), uvec3(9u, 9u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.b[2].mD[1]), uvec3(7u, 9u, 2u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.b[2].mD[2]), uvec3(8u, 0u, 7u)) && allOk;
	allOk = compare_mat3x2(blockC.b[3].mA, mat3x2(1.0, 3.0, 2.0, 9.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat2x3(blockC.b[3].mB, mat2x3(2.0, 9.0, -8.0, -7.0, -7.0, -3.0)) && allOk;
	allOk = compare_float((blockC.b[3].mC), 0.0) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.b[3].mD[0]), uvec3(9u, 6u, 4u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.b[3].mD[1]), uvec3(1u, 8u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.b[3].mD[2]), uvec3(4u, 9u, 6u)) && allOk;
	allOk = compare_mat3x2(blockC.b[4].mA, mat3x2(6.0, -2.0, 3.0, -7.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(blockC.b[4].mB, mat2x3(1.0, -9.0, 6.0, 0.0, 8.0, 0.0)) && allOk;
	allOk = compare_float((blockC.b[4].mC), -1.0) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.b[4].mD[0]), uvec3(8u, 4u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.b[4].mD[1]), uvec3(3u, 1u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.b[4].mD[2]), uvec3(1u, 7u, 4u)) && allOk;
	allOk = compare_mat3x2(blockC.b[5].mA, mat3x2(4.0, 2.0, -8.0, -6.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat2x3(blockC.b[5].mB, mat2x3(-7.0, 8.0, 4.0, 7.0, 5.0, -6.0)) && allOk;
	allOk = compare_float((blockC.b[5].mC), 2.0) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.b[5].mD[0]), uvec3(0u, 9u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.b[5].mD[1]), uvec3(7u, 4u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.b[5].mD[2]), uvec3(2u, 6u, 0u)) && allOk;
	allOk = compare_mat4x3(blockC.c, mat4x3(2.0, 9.0, -9.0, 2.0, 6.0, -8.0, -3.0, 7.0, -7.0, -9.0, -3.0, -7.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockC.d), ivec3(-7, -6, 0)) && allOk;
	allOk = compare_uvec2((blockC.e), uvec2(8u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (mat2x3(1.0, -6.0, -2.0, 5.0, 1.0, -6.0));
	blockB[0].a[1] = (mat2x3(-5.0, -1.0, 4.0, -7.0, -3.0, -5.0));
	blockB[0].a[2] = (mat2x3(7.0, -3.0, -4.0, 3.0, -5.0, -1.0));
	blockB[0].a[3] = (mat2x3(-5.0, -6.0, 6.0, 5.0, -1.0, 2.0));
	blockB[0].a[4] = (mat2x3(8.0, 8.0, -2.0, -7.0, -6.0, 5.0));
	blockB[0].a[5] = (mat2x3(-2.0, -2.0, 6.0, 8.0, -3.0, 7.0));
	blockB[0].a[6] = (mat2x3(9.0, -9.0, -8.0, -5.0, 3.0, -8.0));
	blockB[1].a[0] = (mat2x3(-7.0, -1.0, -1.0, -1.0, 9.0, 1.0));
	blockB[1].a[1] = (mat2x3(1.0, -3.0, -5.0, 0.0, -3.0, -2.0));
	blockB[1].a[2] = (mat2x3(8.0, 3.0, 7.0, -4.0, -2.0, -4.0));
	blockB[1].a[3] = (mat2x3(-8.0, 5.0, -6.0, 8.0, 6.0, 4.0));
	blockB[1].a[4] = (mat2x3(6.0, -4.0, -6.0, 3.0, 1.0, 7.0));
	blockB[1].a[5] = (mat2x3(7.0, 9.0, 0.0, 3.0, -3.0, 4.0));
	blockB[1].a[6] = (mat2x3(-1.0, 6.0, -2.0, 5.0, -6.0, -8.0));
	blockB[1].a[7] = (mat2x3(-5.0, 0.0, 4.0, 3.0, -1.0, 9.0));
	blockB[2].a[0] = (mat2x3(-6.0, -4.0, 3.0, -3.0, -1.0, 6.0));
	blockB[2].a[1] = (mat2x3(-6.0, -4.0, 3.0, 2.0, 9.0, 5.0));
	blockB[2].a[2] = (mat2x3(2.0, -3.0, -7.0, 3.0, 0.0, 7.0));
	blockB[2].a[3] = (mat2x3(-4.0, 4.0, -4.0, 3.0, -4.0, -1.0));
	blockC.b[0].mA = (mat3x2(0.0, -6.0, 4.0, -6.0, -2.0, 6.0));
	blockC.b[0].mB = (mat2x3(-5.0, -1.0, -1.0, 7.0, 4.0, 2.0));
	blockC.b[0].mC = (6.0);
	blockC.b[0].mD[0] = u16vec3(uvec3(6u, 7u, 1u));
	blockC.b[0].mD[1] = u16vec3(uvec3(5u, 3u, 4u));
	blockC.b[0].mD[2] = u16vec3(uvec3(6u, 0u, 7u));
	blockC.b[1].mA = (mat3x2(-9.0, -9.0, -2.0, -7.0, 4.0, -4.0));
	blockC.b[1].mB = (mat2x3(-2.0, -4.0, -6.0, -2.0, 1.0, -7.0));
	blockC.b[1].mC = (8.0);
	blockC.b[1].mD[0] = u16vec3(uvec3(1u, 0u, 1u));
	blockC.b[1].mD[1] = u16vec3(uvec3(5u, 3u, 9u));
	blockC.b[1].mD[2] = u16vec3(uvec3(2u, 4u, 1u));
	blockC.b[2].mA = (mat3x2(-2.0, 5.0, -9.0, -1.0, -1.0, 8.0));
	blockC.b[2].mB = (mat2x3(-6.0, 1.0, 9.0, 9.0, -6.0, 6.0));
	blockC.b[2].mC = (-6.0);
	blockC.b[2].mD[0] = u16vec3(uvec3(9u, 3u, 5u));
	blockC.b[2].mD[1] = u16vec3(uvec3(9u, 4u, 5u));
	blockC.b[2].mD[2] = u16vec3(uvec3(7u, 3u, 1u));
	blockC.b[3].mA = (mat3x2(-8.0, -8.0, 8.0, -7.0, 5.0, -5.0));
	blockC.b[3].mB = (mat2x3(-9.0, 2.0, 5.0, 7.0, 5.0, 8.0));
	blockC.b[3].mC = (8.0);
	blockC.b[3].mD[0] = u16vec3(uvec3(9u, 4u, 4u));
	blockC.b[3].mD[1] = u16vec3(uvec3(9u, 9u, 5u));
	blockC.b[3].mD[2] = u16vec3(uvec3(6u, 9u, 5u));
	blockC.b[4].mA = (mat3x2(-4.0, 4.0, -6.0, -8.0, 8.0, 7.0));
	blockC.b[4].mB = (mat2x3(3.0, 2.0, -6.0, -9.0, -2.0, 9.0));
	blockC.b[4].mC = (5.0);
	blockC.b[4].mD[0] = u16vec3(uvec3(4u, 2u, 0u));
	blockC.b[4].mD[1] = u16vec3(uvec3(7u, 0u, 5u));
	blockC.b[4].mD[2] = u16vec3(uvec3(2u, 9u, 9u));
	blockC.b[5].mA = (mat3x2(4.0, 1.0, 5.0, 1.0, 5.0, 7.0));
	blockC.b[5].mB = (mat2x3(-6.0, -1.0, -3.0, 5.0, 5.0, -7.0));
	blockC.b[5].mC = (0.0);
	blockC.b[5].mD[0] = u16vec3(uvec3(6u, 7u, 2u));
	blockC.b[5].mD[1] = u16vec3(uvec3(8u, 1u, 5u));
	blockC.b[5].mD[2] = u16vec3(uvec3(1u, 1u, 2u));
	blockC.c = (mat4x3(6.0, -6.0, 4.0, 5.0, 9.0, -8.0, 1.0, -7.0, -9.0, 7.0, 4.0, -3.0));
	blockC.e = (uvec2(3u, 4u));
	blockC.f = (3.0);
}
#version 450
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
layout(std140, column_major, binding = 1) buffer BlockB
{
	bvec3 a;
	u16vec4 b;
	lowp mat2 c[2];
	float16_t d[];
} blockB;
layout(std140, row_major, binding = 2) buffer BlockC
{
	i16vec3 e;
	f16vec4 f;
	i16vec2 g[];
} blockC;
layout(std430, column_major, binding = 3) buffer BlockD
{
	lowp mat3x2 h;
	sA i;
	bvec2 j;
	uint16_t k;
	lowp mat2x3 l[];
} blockD[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.a), bvec3(true, false, false)) && allOk;
	allOk = compare_mat2(blockB.c[0], mat2(-2.0, 0.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat2(blockB.c[1], mat2(2.0, -3.0, 8.0, 8.0)) && allOk;
	allOk = compare_float16_t(float(blockB.d[0]), -3.0) && allOk;
	allOk = compare_float16_t(float(blockB.d[1]), 8.0) && allOk;
	allOk = compare_float16_t(float(blockB.d[2]), 5.0) && allOk;
	allOk = compare_float16_t(float(blockB.d[3]), -7.0) && allOk;
	allOk = compare_float16_t(float(blockB.d[4]), -3.0) && allOk;
	allOk = compare_float16_t(float(blockB.d[5]), -9.0) && allOk;
	allOk = compare_float16_t(float(blockB.d[6]), 5.0) && allOk;
	allOk = compare_i16vec3(ivec3(blockC.e), ivec3(-9, 7, 4)) && allOk;
	allOk = compare_i16vec2(ivec2(blockC.g[0]), ivec2(7, -2)) && allOk;
	allOk = compare_i16vec2(ivec2(blockC.g[1]), ivec2(-8, 6)) && allOk;
	allOk = compare_i16vec2(ivec2(blockC.g[2]), ivec2(-3, -8)) && allOk;
	allOk = compare_i16vec2(ivec2(blockC.g[3]), ivec2(-7, -2)) && allOk;
	allOk = compare_mat3x2(blockD[0].h, mat3x2(-8.0, -1.0, -9.0, 1.0, 3.0, -6.0)) && allOk;
	allOk = compare_float((blockD[0].i.mA), -8.0) && allOk;
	allOk = compare_vec3((blockD[0].i.mB), vec3(0.0, 3.0, -8.0)) && allOk;
	allOk = compare_ivec2((blockD[0].i.mC), ivec2(-3, -6)) && allOk;
	allOk = compare_vec2((blockD[0].i.mD), vec2(-9.0, 0.0)) && allOk;
	allOk = compare_bvec2((blockD[0].j), bvec2(false, true)) && allOk;
	allOk = compare_uint16_t(uint(blockD[0].k), 2u) && allOk;
	allOk = compare_mat2x3(blockD[0].l[0], mat2x3(6.0, -3.0, 9.0, 7.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat2x3(blockD[0].l[1], mat2x3(9.0, 7.0, -7.0, 7.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(blockD[1].h, mat3x2(-8.0, -2.0, -1.0, 6.0, 4.0, -1.0)) && allOk;
	allOk = compare_float((blockD[1].i.mA), -7.0) && allOk;
	allOk = compare_vec3((blockD[1].i.mB), vec3(-2.0, 5.0, 6.0)) && allOk;
	allOk = compare_ivec2((blockD[1].i.mC), ivec2(1, 5)) && allOk;
	allOk = compare_vec2((blockD[1].i.mD), vec2(-5.0, -2.0)) && allOk;
	allOk = compare_bvec2((blockD[1].j), bvec2(true, true)) && allOk;
	allOk = compare_uint16_t(uint(blockD[1].k), 1u) && allOk;
	allOk = compare_mat2x3(blockD[1].l[0], mat2x3(2.0, -2.0, 5.0, -9.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2x3(blockD[1].l[1], mat2x3(1.0, 8.0, 1.0, 0.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(blockD[1].l[2], mat2x3(-3.0, -2.0, 4.0, -8.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2x3(blockD[1].l[3], mat2x3(-5.0, 6.0, -2.0, 3.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockD[2].h, mat3x2(-2.0, -8.0, -1.0, 7.0, -9.0, -3.0)) && allOk;
	allOk = compare_float((blockD[2].i.mA), 6.0) && allOk;
	allOk = compare_vec3((blockD[2].i.mB), vec3(-2.0, -7.0, 4.0)) && allOk;
	allOk = compare_ivec2((blockD[2].i.mC), ivec2(5, -8)) && allOk;
	allOk = compare_vec2((blockD[2].i.mD), vec2(-4.0, -4.0)) && allOk;
	allOk = compare_bvec2((blockD[2].j), bvec2(false, true)) && allOk;
	allOk = compare_uint16_t(uint(blockD[2].k), 1u) && allOk;
	allOk = compare_mat2x3(blockD[2].l[0], mat2x3(4.0, 3.0, 1.0, -2.0, 7.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec3(true, false, true));
	blockB.b = u16vec4(uvec4(5u, 3u, 5u, 1u));
	blockB.c[0] = (mat2(-2.0, 5.0, -7.0, -5.0));
	blockB.c[1] = (mat2(-9.0, -9.0, -7.0, 3.0));
	blockB.d[0] = float16_t(1.0);
	blockB.d[1] = float16_t(2.0);
	blockB.d[2] = float16_t(-4.0);
	blockB.d[3] = float16_t(-6.0);
	blockB.d[4] = float16_t(7.0);
	blockB.d[5] = float16_t(1.0);
	blockB.d[6] = float16_t(9.0);
	blockC.e = i16vec3(ivec3(1, 3, 9));
	blockC.f = f16vec4(vec4(6.0, 4.0, -5.0, -6.0));
	blockC.g[0] = i16vec2(ivec2(2, 8));
	blockC.g[1] = i16vec2(ivec2(0, 6));
	blockC.g[2] = i16vec2(ivec2(5, 6));
	blockC.g[3] = i16vec2(ivec2(-3, -8));
	blockD[0].h = (mat3x2(8.0, -8.0, -6.0, -5.0, 0.0, 0.0));
	blockD[0].j = (bvec2(true, false));
	blockD[1].h = (mat3x2(-4.0, 3.0, -7.0, 1.0, -7.0, -5.0));
	blockD[1].j = (bvec2(true, false));
	blockD[2].h = (mat3x2(7.0, -3.0, -5.0, -7.0, -8.0, -8.0));
	blockD[2].j = (bvec2(false, false));
}
#version 450
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
	mediump vec4 a;
	mediump uint b;
	u16vec3 c;
	u16vec4 d;
	float16_t e[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((a), vec4(-4.0, 4.0, -6.0, -2.0)) && allOk;
	allOk = compare_uint((b), 9u) && allOk;
	allOk = compare_u16vec3(uvec3(c), uvec3(5u, 7u, 6u)) && allOk;
	allOk = compare_u16vec4(uvec4(d), uvec4(1u, 8u, 9u, 3u)) && allOk;
	allOk = compare_float16_t(float(e[0]), -6.0) && allOk;
	allOk = compare_float16_t(float(e[1]), -3.0) && allOk;
	allOk = compare_float16_t(float(e[2]), -1.0) && allOk;
	allOk = compare_float16_t(float(e[3]), 4.0) && allOk;
	allOk = compare_float16_t(float(e[4]), 8.0) && allOk;
	allOk = compare_float16_t(float(e[5]), -1.0) && allOk;
	allOk = compare_float16_t(float(e[6]), 6.0) && allOk;
	allOk = compare_float16_t(float(e[7]), 5.0) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (8u);
	c = u16vec3(uvec3(2u, 9u, 3u));
	e[0] = float16_t(-9.0);
	e[1] = float16_t(5.0);
	e[2] = float16_t(4.0);
	e[3] = float16_t(-2.0);
	e[4] = float16_t(-5.0);
	e[5] = float16_t(5.0);
	e[6] = float16_t(-6.0);
	e[7] = float16_t(3.0);
}
#version 450
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
	layout(offset = 0) uint16_t a;
	layout(offset = 16) mediump uvec4 b;
	layout(offset = 32) u16vec4 c;
	layout(offset = 40) i16vec2 d;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) u16vec2 e;
	layout(offset = 4) f16vec3 f;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(blockB.a), 4u) && allOk;
	allOk = compare_uvec4((blockB.b), uvec4(9u, 0u, 0u, 3u)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.d), ivec2(8, -9)) && allOk;
	allOk = compare_u16vec2(uvec2(e), uvec2(9u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = uint16_t(0u);
	blockB.b = (uvec4(3u, 1u, 1u, 6u));
	blockB.c = u16vec4(uvec4(0u, 6u, 5u, 0u));
	blockB.d = i16vec2(ivec2(-7, -3));
	f = f16vec3(vec3(-3.0, -4.0, 3.0));
}
#version 450
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
	u16vec2 a[8];
	i16vec2 b;
	mediump ivec4 c;
	float16_t d;
	highp vec2 e[];
};
layout(scalar, column_major, binding = 2) buffer BlockC
{
	highp vec3 f;
	bool g[];
};
layout(scalar, binding = 3) buffer BlockD
{
	highp mat4 h;
	i16vec4 i;
	i16vec2 j;
	lowp uvec4 k;
	lowp vec3 l[];
} blockD[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(a[0]), uvec2(4u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(a[1]), uvec2(6u, 3u)) && allOk;
	allOk = compare_u16vec2(uvec2(a[2]), uvec2(9u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(a[3]), uvec2(2u, 0u)) && allOk;
	allOk = compare_u16vec2(uvec2(a[4]), uvec2(0u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(a[5]), uvec2(1u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(a[6]), uvec2(9u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(a[7]), uvec2(2u, 6u)) && allOk;
	allOk = compare_i16vec2(ivec2(b), ivec2(5, -5)) && allOk;
	allOk = compare_ivec4((c), ivec4(-2, -6, 6, -8)) && allOk;
	allOk = compare_vec3((f), vec3(-2.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat4(blockD[0].h, mat4(-8.0, -7.0, -6.0, -3.0, 6.0, 6.0, 1.0, 3.0, 4.0, 1.0, 0.0, 9.0, -5.0, -2.0, -3.0, -4.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD[0].i), ivec4(-1, -6, 7, -6)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD[0].j), ivec2(-8, 6)) && allOk;
	allOk = compare_vec3((blockD[0].l[0]), vec3(-7.0, -6.0, -7.0)) && allOk;
	allOk = compare_vec3((blockD[0].l[1]), vec3(0.0, 4.0, 7.0)) && allOk;
	allOk = compare_vec3((blockD[0].l[2]), vec3(2.0, 5.0, -3.0)) && allOk;
	allOk = compare_vec3((blockD[0].l[3]), vec3(6.0, 7.0, 4.0)) && allOk;
	allOk = compare_vec3((blockD[0].l[4]), vec3(5.0, 8.0, 5.0)) && allOk;
	allOk = compare_vec3((blockD[0].l[5]), vec3(7.0, 0.0, 5.0)) && allOk;
	allOk = compare_mat4(blockD[1].h, mat4(8.0, -7.0, -5.0, 7.0, -6.0, 4.0, 9.0, -2.0, 2.0, 3.0, -7.0, -5.0, 9.0, 6.0, 6.0, -2.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD[1].i), ivec4(2, -4, 3, -5)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD[1].j), ivec2(-8, 7)) && allOk;
	allOk = compare_vec3((blockD[1].l[0]), vec3(-4.0, -8.0, 4.0)) && allOk;
	allOk = compare_vec3((blockD[1].l[1]), vec3(8.0, 8.0, 0.0)) && allOk;
	allOk = compare_vec3((blockD[1].l[2]), vec3(-8.0, 0.0, 5.0)) && allOk;
	allOk = compare_vec3((blockD[1].l[3]), vec3(7.0, -4.0, 9.0)) && allOk;
	allOk = compare_vec3((blockD[1].l[4]), vec3(6.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat4(blockD[2].h, mat4(-1.0, -9.0, 4.0, -5.0, 7.0, 7.0, -4.0, 2.0, 8.0, 4.0, 9.0, 0.0, -6.0, -3.0, -3.0, 8.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD[2].i), ivec4(1, -7, -2, -5)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD[2].j), ivec2(2, 6)) && allOk;
	allOk = compare_vec3((blockD[2].l[0]), vec3(4.0, -4.0, 7.0)) && allOk;
	allOk = compare_vec3((blockD[2].l[1]), vec3(8.0, 4.0, 0.0)) && allOk;
	allOk = compare_vec3((blockD[2].l[2]), vec3(5.0, 5.0, 5.0)) && allOk;
	allOk = compare_vec3((blockD[2].l[3]), vec3(-7.0, -3.0, 9.0)) && allOk;
	allOk = compare_vec3((blockD[2].l[4]), vec3(4.0, -2.0, 4.0)) && allOk;
	allOk = compare_vec3((blockD[2].l[5]), vec3(-6.0, 9.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = u16vec2(uvec2(8u, 6u));
	a[1] = u16vec2(uvec2(1u, 3u));
	a[2] = u16vec2(uvec2(3u, 9u));
	a[3] = u16vec2(uvec2(6u, 8u));
	a[4] = u16vec2(uvec2(0u, 5u));
	a[5] = u16vec2(uvec2(7u, 1u));
	a[6] = u16vec2(uvec2(7u, 8u));
	a[7] = u16vec2(uvec2(3u, 0u));
	b = i16vec2(ivec2(-7, -4));
	c = (ivec4(-2, -9, -8, -5));
	d = float16_t(9.0);
	g[0] = (false);
	g[1] = (true);
	g[2] = (false);
	g[3] = (true);
	blockD[0].h = (mat4(7.0, 2.0, -9.0, 1.0, -9.0, 6.0, 2.0, -1.0, 2.0, -5.0, -8.0, -7.0, 8.0, -9.0, 2.0, -2.0));
	blockD[0].i = i16vec4(ivec4(3, -7, 2, 0));
	blockD[0].j = i16vec2(ivec2(4, -1));
	blockD[0].l[0] = (vec3(-8.0, -9.0, -2.0));
	blockD[0].l[1] = (vec3(6.0, 0.0, -7.0));
	blockD[0].l[2] = (vec3(3.0, -7.0, -1.0));
	blockD[0].l[3] = (vec3(-5.0, 1.0, 4.0));
	blockD[0].l[4] = (vec3(-3.0, 4.0, 5.0));
	blockD[0].l[5] = (vec3(0.0, 7.0, -5.0));
	blockD[1].h = (mat4(0.0, -3.0, 0.0, 8.0, -6.0, 4.0, -6.0, -7.0, -6.0, 7.0, -6.0, -5.0, 3.0, 9.0, -3.0, 5.0));
	blockD[1].i = i16vec4(ivec4(9, 4, 7, -3));
	blockD[1].j = i16vec2(ivec2(-1, 1));
	blockD[1].l[0] = (vec3(9.0, 0.0, 4.0));
	blockD[1].l[1] = (vec3(1.0, -4.0, 1.0));
	blockD[1].l[2] = (vec3(-6.0, 3.0, 8.0));
	blockD[1].l[3] = (vec3(4.0, 9.0, 9.0));
	blockD[1].l[4] = (vec3(-4.0, 9.0, -2.0));
	blockD[2].h = (mat4(-7.0, 5.0, 9.0, 0.0, -6.0, -1.0, -7.0, -8.0, 3.0, 7.0, -3.0, -1.0, -6.0, 5.0, 5.0, -2.0));
	blockD[2].i = i16vec4(ivec4(-1, -1, 1, 5));
	blockD[2].j = i16vec2(ivec2(-6, 2));
	blockD[2].l[0] = (vec3(5.0, 0.0, -1.0));
	blockD[2].l[1] = (vec3(8.0, -4.0, -6.0));
	blockD[2].l[2] = (vec3(-2.0, -2.0, -9.0));
	blockD[2].l[3] = (vec3(-8.0, 9.0, 3.0));
	blockD[2].l[4] = (vec3(0.0, 4.0, 4.0));
	blockD[2].l[5] = (vec3(-1.0, 6.0, 3.0));
}
#version 450
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
struct sD
{
	highp vec4 mA;
};
struct sE
{
	sD mA;
};
layout(scalar, binding = 1) buffer BlockB
{
	bvec4 a;
	u16vec2 b;
	sC c;
	lowp mat4x3 d;
	highp mat4 e[];
} blockB;
layout(scalar, row_major, binding = 2) buffer BlockC
{
	u16vec3 f;
	sE g;
	highp vec3 h[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, true, false, true)) && allOk;
	allOk = compare_u16vec2(uvec2(blockB.b), uvec2(0u, 4u)) && allOk;
	allOk = compare_mat4x3(blockB.d, mat4x3(-5.0, 4.0, 7.0, -4.0, 1.0, -1.0, -8.0, 8.0, 0.0, -3.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4(blockB.e[0], mat4(9.0, 0.0, 9.0, -5.0, -9.0, 7.0, -6.0, 1.0, -3.0, -7.0, 1.0, -6.0, -2.0, -6.0, -8.0, 0.0)) && allOk;
	allOk = compare_u16vec3(uvec3(f), uvec3(4u, 4u, 0u)) && allOk;
	allOk = compare_vec4((g.mA.mA), vec4(-1.0, -6.0, -9.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec4(true, true, true, true));
	blockB.d = (mat4x3(-3.0, -4.0, -3.0, 1.0, 0.0, -5.0, 8.0, -3.0, 8.0, 5.0, 0.0, 1.0));
	blockB.e[0] = (mat4(2.0, 6.0, 8.0, 2.0, -3.0, -3.0, -6.0, -5.0, 3.0, 3.0, 0.0, -4.0, -9.0, 0.0, -3.0, -8.0));
	f = u16vec3(uvec3(6u, 3u, 7u));
	g.mA.mA = (vec4(8.0, -9.0, 4.0, -4.0));
}
#version 450
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
	lowp vec2 a;
	lowp int b;
	bool c;
	mediump float d;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(2.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec2(8.0, -2.0));
}
#version 450
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
	u8vec3 a;
	mediump vec3 b[];
};
layout(std430, binding = 2) buffer BlockC
{
	lowp mat3 c;
	lowp vec2 d[1][6];
	lowp float e[];
} blockC;
layout(std430, row_major, binding = 3) buffer BlockD
{
	bvec3 f[][5];
};
layout(std140, binding = 4) buffer BlockE
{
	u8vec4 g;
	mediump float h[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(a), uvec3(3u, 0u, 3u)) && allOk;
	allOk = compare_vec3((b[0]), vec3(-3.0, -1.0, -9.0)) && allOk;
	allOk = compare_vec3((b[1]), vec3(5.0, -7.0, -9.0)) && allOk;
	allOk = compare_vec3((b[2]), vec3(8.0, -4.0, -8.0)) && allOk;
	allOk = compare_vec3((b[3]), vec3(8.0, -8.0, -6.0)) && allOk;
	allOk = compare_vec3((b[4]), vec3(-2.0, 9.0, -2.0)) && allOk;
	allOk = compare_vec3((b[5]), vec3(-2.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3(blockC.c, mat3(7.0, -1.0, 9.0, -5.0, 8.0, 4.0, -9.0, 8.0, -6.0)) && allOk;
	allOk = compare_float((blockC.e[0]), -3.0) && allOk;
	allOk = compare_float((blockC.e[1]), 5.0) && allOk;
	allOk = compare_float((blockC.e[2]), -2.0) && allOk;
	allOk = compare_bvec3((f[0][0]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((f[0][1]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((f[0][2]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((f[0][3]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((f[0][4]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((f[1][0]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((f[1][1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((f[1][2]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((f[1][3]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((f[1][4]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((f[2][0]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((f[2][1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((f[2][2]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((f[2][3]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((f[2][4]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((f[3][0]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((f[3][1]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((f[3][2]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((f[3][3]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((f[3][4]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((f[4][0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((f[4][1]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((f[4][2]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((f[4][3]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((f[4][4]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((f[5][0]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((f[5][1]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((f[5][2]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((f[5][3]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((f[5][4]), bvec3(true, false, false)) && allOk;
	allOk = compare_u8vec4(uvec4(blockE.g), uvec4(1u, 9u, 5u, 5u)) && allOk;
	allOk = compare_float((blockE.h[0]), 7.0) && allOk;
	allOk = compare_float((blockE.h[1]), 6.0) && allOk;
	allOk = compare_float((blockE.h[2]), -2.0) && allOk;
    if (allOk)
        ac_numPassed++;

	a = u8vec3(uvec3(7u, 9u, 4u));
	b[0] = (vec3(5.0, -3.0, -5.0));
	b[1] = (vec3(-8.0, 3.0, -9.0));
	b[2] = (vec3(2.0, 6.0, 1.0));
	b[3] = (vec3(9.0, -5.0, 9.0));
	b[4] = (vec3(-3.0, 6.0, 7.0));
	b[5] = (vec3(-9.0, -6.0, -1.0));
	blockC.c = (mat3(3.0, 5.0, 3.0, 9.0, 8.0, -4.0, -8.0, -5.0, -1.0));
	blockC.d[0][0] = (vec2(2.0, 0.0));
	blockC.d[0][1] = (vec2(5.0, 3.0));
	blockC.d[0][2] = (vec2(-3.0, 2.0));
	blockC.d[0][3] = (vec2(4.0, 4.0));
	blockC.d[0][4] = (vec2(-6.0, 4.0));
	blockC.d[0][5] = (vec2(-5.0, -2.0));
	blockC.e[0] = (-4.0);
	blockC.e[1] = (-5.0);
	blockC.e[2] = (7.0);
	f[0][0] = (bvec3(true, true, true));
	f[0][1] = (bvec3(false, true, false));
	f[0][2] = (bvec3(false, true, true));
	f[0][3] = (bvec3(false, false, false));
	f[0][4] = (bvec3(true, false, true));
	f[1][0] = (bvec3(false, false, true));
	f[1][1] = (bvec3(true, true, false));
	f[1][2] = (bvec3(false, false, false));
	f[1][3] = (bvec3(false, false, false));
	f[1][4] = (bvec3(false, true, true));
	f[2][0] = (bvec3(true, true, true));
	f[2][1] = (bvec3(true, true, true));
	f[2][2] = (bvec3(false, false, false));
	f[2][3] = (bvec3(false, true, true));
	f[2][4] = (bvec3(true, true, true));
	f[3][0] = (bvec3(false, true, false));
	f[3][1] = (bvec3(false, true, true));
	f[3][2] = (bvec3(false, false, true));
	f[3][3] = (bvec3(true, true, true));
	f[3][4] = (bvec3(true, false, true));
	f[4][0] = (bvec3(false, true, true));
	f[4][1] = (bvec3(false, false, false));
	f[4][2] = (bvec3(true, true, false));
	f[4][3] = (bvec3(false, false, true));
	f[4][4] = (bvec3(false, true, true));
	f[5][0] = (bvec3(true, true, true));
	f[5][1] = (bvec3(false, false, false));
	f[5][2] = (bvec3(false, false, false));
	f[5][3] = (bvec3(true, true, false));
	f[5][4] = (bvec3(true, true, false));
	blockE.g = u8vec4(uvec4(3u, 8u, 4u, 9u));
	blockE.h[0] = (6.0);
	blockE.h[1] = (1.0);
	blockE.h[2] = (-7.0);
}
#version 450
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
	i8vec3 a;
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	bvec3 b[];
} blockC;
layout(std140, row_major, binding = 3) buffer BlockD
{
	lowp ivec3 c;
	bvec2 d;
	lowp mat4x2 e[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockC.b[0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((blockC.b[1]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((blockC.b[2]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockC.b[3]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((blockC.b[4]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((blockC.b[5]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((blockC.b[6]), bvec3(false, false, false)) && allOk;
	allOk = compare_ivec3((c), ivec3(1, 8, -5)) && allOk;
	allOk = compare_bvec2((d), bvec2(true, true)) && allOk;
	allOk = compare_mat4x2(e[0], mat4x2(-2.0, -4.0, -4.0, 8.0, 1.0, -4.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat4x2(e[1], mat4x2(-9.0, -4.0, -5.0, -6.0, 5.0, -4.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4x2(e[2], mat4x2(9.0, 1.0, -8.0, 6.0, 2.0, 8.0, 9.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i8vec3(ivec3(4294967290, 4294967294, 3));
	blockC.b[0] = (bvec3(true, true, true));
	blockC.b[1] = (bvec3(false, false, true));
	blockC.b[2] = (bvec3(false, true, false));
	blockC.b[3] = (bvec3(true, false, false));
	blockC.b[4] = (bvec3(false, false, true));
	blockC.b[5] = (bvec3(false, true, false));
	blockC.b[6] = (bvec3(true, false, false));
	c = (ivec3(-5, 7, -5));
	e[0] = (mat4x2(-4.0, -5.0, -9.0, 1.0, 8.0, 4.0, -8.0, 3.0));
	e[1] = (mat4x2(-9.0, 8.0, -3.0, 1.0, 8.0, 8.0, 5.0, 9.0));
	e[2] = (mat4x2(2.0, -9.0, 7.0, 7.0, -2.0, 3.0, -9.0, -9.0));
}
#version 450
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
struct sB
{
	lowp int mA;
	lowp mat4x2 mB;
	lowp vec3 mC;
	lowp uvec3 mD;
};
struct sC
{
	bvec4 mA;
	int8_t mB;
};
struct sD
{
	u8vec3 mA;
	sC mB;
	lowp ivec2 mC;
};
layout(std430, row_major, binding = 1) buffer BlockB
{
	sA a;
	bvec4 b;
	i8vec4 c;
	uint8_t d[];
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	sB e;
	mediump ivec2 f;
	sD g;
	bvec3 h;
	bool i[];
} blockC;
layout(std430, row_major, binding = 3) buffer BlockD
{
	highp vec3 j[][7];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(c), ivec4(9, 4294967292, 4294967293, 4)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.g.mA), uvec3(8u, 2u, 2u)) && allOk;
	allOk = compare_bvec4((blockC.g.mB.mA), bvec4(true, true, true, true)) && allOk;
	allOk = compare_int8_t(int(blockC.g.mB.mB), 6) && allOk;
	allOk = compare_ivec2((blockC.g.mC), ivec2(0, -3)) && allOk;
	allOk = compare_bvec3((blockC.h), bvec3(true, true, false)) && allOk;
	allOk = compare_bool((blockC.i[0]), true) && allOk;
	allOk = compare_bool((blockC.i[1]), false) && allOk;
	allOk = compare_vec3((blockD.j[0][0]), vec3(-9.0, -9.0, -9.0)) && allOk;
	allOk = compare_vec3((blockD.j[0][1]), vec3(-7.0, 7.0, -2.0)) && allOk;
	allOk = compare_vec3((blockD.j[0][2]), vec3(2.0, -4.0, 4.0)) && allOk;
	allOk = compare_vec3((blockD.j[0][3]), vec3(-8.0, 4.0, 8.0)) && allOk;
	allOk = compare_vec3((blockD.j[0][4]), vec3(5.0, -7.0, -8.0)) && allOk;
	allOk = compare_vec3((blockD.j[0][5]), vec3(-5.0, 0.0, 1.0)) && allOk;
	allOk = compare_vec3((blockD.j[0][6]), vec3(-4.0, -9.0, 2.0)) && allOk;
	allOk = compare_vec3((blockD.j[1][0]), vec3(-4.0, -5.0, 1.0)) && allOk;
	allOk = compare_vec3((blockD.j[1][1]), vec3(5.0, 4.0, -7.0)) && allOk;
	allOk = compare_vec3((blockD.j[1][2]), vec3(6.0, 8.0, 0.0)) && allOk;
	allOk = compare_vec3((blockD.j[1][3]), vec3(-7.0, -8.0, -7.0)) && allOk;
	allOk = compare_vec3((blockD.j[1][4]), vec3(-3.0, 3.0, 2.0)) && allOk;
	allOk = compare_vec3((blockD.j[1][5]), vec3(-8.0, -1.0, -7.0)) && allOk;
	allOk = compare_vec3((blockD.j[1][6]), vec3(0.0, 6.0, -5.0)) && allOk;
	allOk = compare_vec3((blockD.j[2][0]), vec3(4.0, -3.0, 7.0)) && allOk;
	allOk = compare_vec3((blockD.j[2][1]), vec3(-5.0, 1.0, 8.0)) && allOk;
	allOk = compare_vec3((blockD.j[2][2]), vec3(0.0, -3.0, -8.0)) && allOk;
	allOk = compare_vec3((blockD.j[2][3]), vec3(6.0, -2.0, 5.0)) && allOk;
	allOk = compare_vec3((blockD.j[2][4]), vec3(8.0, 8.0, -5.0)) && allOk;
	allOk = compare_vec3((blockD.j[2][5]), vec3(4.0, 9.0, -1.0)) && allOk;
	allOk = compare_vec3((blockD.j[2][6]), vec3(-4.0, 2.0, 4.0)) && allOk;
	allOk = compare_vec3((blockD.j[3][0]), vec3(4.0, 0.0, 7.0)) && allOk;
	allOk = compare_vec3((blockD.j[3][1]), vec3(4.0, 8.0, -9.0)) && allOk;
	allOk = compare_vec3((blockD.j[3][2]), vec3(-8.0, 6.0, -4.0)) && allOk;
	allOk = compare_vec3((blockD.j[3][3]), vec3(-4.0, -2.0, 5.0)) && allOk;
	allOk = compare_vec3((blockD.j[3][4]), vec3(0.0, 4.0, 9.0)) && allOk;
	allOk = compare_vec3((blockD.j[3][5]), vec3(5.0, 4.0, 0.0)) && allOk;
	allOk = compare_vec3((blockD.j[3][6]), vec3(9.0, -4.0, 5.0)) && allOk;
	allOk = compare_vec3((blockD.j[4][0]), vec3(2.0, -1.0, 5.0)) && allOk;
	allOk = compare_vec3((blockD.j[4][1]), vec3(1.0, 3.0, 0.0)) && allOk;
	allOk = compare_vec3((blockD.j[4][2]), vec3(-7.0, 9.0, 6.0)) && allOk;
	allOk = compare_vec3((blockD.j[4][3]), vec3(-5.0, 1.0, -8.0)) && allOk;
	allOk = compare_vec3((blockD.j[4][4]), vec3(-2.0, -5.0, -1.0)) && allOk;
	allOk = compare_vec3((blockD.j[4][5]), vec3(-2.0, 9.0, 6.0)) && allOk;
	allOk = compare_vec3((blockD.j[4][6]), vec3(9.0, -6.0, 5.0)) && allOk;
	allOk = compare_vec3((blockD.j[5][0]), vec3(2.0, -5.0, 9.0)) && allOk;
	allOk = compare_vec3((blockD.j[5][1]), vec3(2.0, 6.0, 7.0)) && allOk;
	allOk = compare_vec3((blockD.j[5][2]), vec3(6.0, 9.0, -4.0)) && allOk;
	allOk = compare_vec3((blockD.j[5][3]), vec3(6.0, -1.0, -1.0)) && allOk;
	allOk = compare_vec3((blockD.j[5][4]), vec3(6.0, 3.0, -6.0)) && allOk;
	allOk = compare_vec3((blockD.j[5][5]), vec3(-3.0, 8.0, -1.0)) && allOk;
	allOk = compare_vec3((blockD.j[5][6]), vec3(5.0, 6.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a.mA = (ivec3(6, -1, 0));
	b = (bvec4(false, false, false, true));
	c = i8vec4(ivec4(4294967288, 4294967292, 4294967290, 3));
	d[0] = uint8_t(3u);
	d[1] = uint8_t(2u);
	d[2] = uint8_t(5u);
	d[3] = uint8_t(6u);
	d[4] = uint8_t(0u);
	d[5] = uint8_t(2u);
	d[6] = uint8_t(1u);
	d[7] = uint8_t(9u);
	blockC.g.mA = u8vec3(uvec3(4u, 7u, 4u));
	blockC.g.mB.mA = (bvec4(true, false, true, true));
	blockC.g.mB.mB = int8_t(4294967288);
	blockC.g.mC = (ivec2(5, 6));
	blockC.i[0] = (true);
	blockC.i[1] = (true);
	blockD.j[0][0] = (vec3(-3.0, 0.0, 7.0));
	blockD.j[0][1] = (vec3(-5.0, -5.0, 7.0));
	blockD.j[0][2] = (vec3(8.0, -6.0, 1.0));
	blockD.j[0][3] = (vec3(8.0, -5.0, 4.0));
	blockD.j[0][4] = (vec3(8.0, 5.0, -5.0));
	blockD.j[0][5] = (vec3(-7.0, -3.0, -6.0));
	blockD.j[0][6] = (vec3(4.0, -9.0, 5.0));
	blockD.j[1][0] = (vec3(1.0, -9.0, 6.0));
	blockD.j[1][1] = (vec3(-7.0, -8.0, -2.0));
	blockD.j[1][2] = (vec3(6.0, 4.0, -3.0));
	blockD.j[1][3] = (vec3(4.0, 9.0, -8.0));
	blockD.j[1][4] = (vec3(-8.0, 5.0, -9.0));
	blockD.j[1][5] = (vec3(-3.0, -3.0, -3.0));
	blockD.j[1][6] = (vec3(-1.0, -6.0, 6.0));
	blockD.j[2][0] = (vec3(4.0, -3.0, 8.0));
	blockD.j[2][1] = (vec3(5.0, -7.0, -6.0));
	blockD.j[2][2] = (vec3(0.0, -5.0, -7.0));
	blockD.j[2][3] = (vec3(4.0, -8.0, -7.0));
	blockD.j[2][4] = (vec3(-7.0, -5.0, -3.0));
	blockD.j[2][5] = (vec3(-7.0, -5.0, 3.0));
	blockD.j[2][6] = (vec3(-1.0, -5.0, -9.0));
	blockD.j[3][0] = (vec3(-2.0, -7.0, -6.0));
	blockD.j[3][1] = (vec3(9.0, 4.0, 1.0));
	blockD.j[3][2] = (vec3(-6.0, 8.0, 6.0));
	blockD.j[3][3] = (vec3(-1.0, -4.0, -9.0));
	blockD.j[3][4] = (vec3(-4.0, -7.0, 9.0));
	blockD.j[3][5] = (vec3(0.0, -3.0, 8.0));
	blockD.j[3][6] = (vec3(-5.0, -6.0, 2.0));
	blockD.j[4][0] = (vec3(-1.0, -9.0, -6.0));
	blockD.j[4][1] = (vec3(-1.0, 9.0, -8.0));
	blockD.j[4][2] = (vec3(-2.0, -4.0, -8.0));
	blockD.j[4][3] = (vec3(9.0, 8.0, 9.0));
	blockD.j[4][4] = (vec3(-7.0, 8.0, -6.0));
	blockD.j[4][5] = (vec3(6.0, -7.0, -3.0));
	blockD.j[4][6] = (vec3(-2.0, -5.0, -9.0));
	blockD.j[5][0] = (vec3(6.0, -3.0, -7.0));
	blockD.j[5][1] = (vec3(-8.0, 3.0, -4.0));
	blockD.j[5][2] = (vec3(2.0, 9.0, 7.0));
	blockD.j[5][3] = (vec3(-9.0, -7.0, -2.0));
	blockD.j[5][4] = (vec3(6.0, -3.0, -6.0));
	blockD.j[5][5] = (vec3(2.0, 2.0, 3.0));
	blockD.j[5][6] = (vec3(-9.0, -6.0, 0.0));
}
#version 450
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
	layout(offset = 0) lowp ivec2 a;
	layout(offset = 8) highp uint b;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) bvec4 c;
	layout(offset = 16) mediump ivec3 d;
	layout(offset = 28) u8vec3 e;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) mediump vec2 f;
	layout(offset = 8) i8vec3 g;
	layout(offset = 16) highp vec3 h[1];
	layout(offset = 32) mediump uvec4 i;
	layout(offset = 48) lowp uvec4 j;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((b), 2u) && allOk;
	allOk = compare_bvec4((c), bvec4(false, false, true, false)) && allOk;
	allOk = compare_ivec3((d), ivec3(-4, 9, 7)) && allOk;
	allOk = compare_u8vec3(uvec3(e), uvec3(9u, 9u, 7u)) && allOk;
	allOk = compare_vec2((blockD.f), vec2(-1.0, -8.0)) && allOk;
	allOk = compare_vec3((blockD.h[0]), vec3(0.0, -8.0, 3.0)) && allOk;
	allOk = compare_uvec4((blockD.i), uvec4(7u, 9u, 3u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (ivec2(-1, 9));
	b = (6u);
	c = (bvec4(true, false, false, false));
	d = (ivec3(-7, 3, 6));
	e = u8vec3(uvec3(5u, 0u, 5u));
	blockD.f = (vec2(8.0, 4.0));
	blockD.g = i8vec3(ivec3(9, 1, 0));
	blockD.h[0] = (vec3(-1.0, 4.0, -4.0));
	blockD.j = (uvec4(6u, 8u, 3u, 1u));
}
#version 450
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
	uint8_t mA;
	bvec2 mB;
	lowp mat3x4 mC;
	mediump ivec3 mD;
};
layout(scalar, row_major, binding = 1) buffer BlockB
{
	highp mat2x3 a[8];
	i8vec4 b;
	i8vec4 c;
	lowp mat3x2 d;
	lowp mat4x3 e[];
};
layout(scalar, column_major, binding = 2) buffer BlockC
{
	u8vec2 f;
	lowp mat4x3 g[8];
	lowp uint h[];
} blockC[3];
layout(scalar, binding = 3) buffer BlockD
{
	highp mat4x2 i;
	uint8_t j;
	sA k;
	u8vec2 l[];
} blockD;

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
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(a[0], mat2x3(0.0, 3.0, 0.0, 3.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat2x3(a[1], mat2x3(1.0, -2.0, 3.0, -5.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(a[2], mat2x3(2.0, 3.0, 5.0, 3.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat2x3(a[3], mat2x3(-2.0, 6.0, 7.0, -6.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat2x3(a[4], mat2x3(-9.0, 8.0, 4.0, 9.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat2x3(a[5], mat2x3(-4.0, 9.0, 6.0, 1.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2x3(a[6], mat2x3(-2.0, 1.0, -4.0, -2.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2x3(a[7], mat2x3(9.0, 9.0, -7.0, 1.0, -8.0, -6.0)) && allOk;
	allOk = compare_i8vec4(ivec4(c), ivec4(3, 4, 1, 0)) && allOk;
	allOk = compare_mat3x2(d, mat3x2(9.0, -3.0, -5.0, -4.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat4x3(e[0], mat4x3(-6.0, 6.0, 0.0, 7.0, 8.0, -7.0, -6.0, 9.0, -6.0, -8.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat4x3(e[1], mat4x3(0.0, 5.0, 4.0, 4.0, -3.0, 5.0, 7.0, 6.0, 8.0, 2.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat4x3(e[2], mat4x3(7.0, -7.0, 4.0, 0.0, -5.0, 9.0, 5.0, 7.0, -2.0, 8.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x3(e[3], mat4x3(3.0, 6.0, -4.0, -7.0, 6.0, 3.0, -5.0, -2.0, -5.0, 9.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat4x3(e[4], mat4x3(7.0, 9.0, 8.0, 7.0, -4.0, 8.0, 1.0, -8.0, 0.0, 3.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(e[5], mat4x3(0.0, 9.0, -1.0, 5.0, 6.0, -9.0, 7.0, 2.0, 4.0, -4.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4x3(e[6], mat4x3(7.0, 8.0, -6.0, 7.0, 4.0, -3.0, -4.0, 9.0, -3.0, 2.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat4x3(e[7], mat4x3(1.0, 2.0, -1.0, -7.0, 6.0, 1.0, -2.0, -1.0, 4.0, -5.0, 3.0, -4.0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC[0].f), uvec2(8u, 1u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC[1].f), uvec2(5u, 6u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC[2].f), uvec2(4u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (mat2x3(5.0, 3.0, -5.0, -5.0, 9.0, -5.0));
	a[1] = (mat2x3(0.0, -9.0, -4.0, -1.0, 2.0, -8.0));
	a[2] = (mat2x3(-4.0, 6.0, -7.0, 8.0, -3.0, -4.0));
	a[3] = (mat2x3(-2.0, -8.0, 9.0, -9.0, -5.0, -1.0));
	a[4] = (mat2x3(1.0, 9.0, -6.0, 7.0, -8.0, 4.0));
	a[5] = (mat2x3(8.0, 4.0, -9.0, -8.0, 6.0, 5.0));
	a[6] = (mat2x3(6.0, 3.0, -1.0, 1.0, 0.0, -3.0));
	a[7] = (mat2x3(-8.0, 3.0, 7.0, -6.0, 2.0, 2.0));
	b = i8vec4(ivec4(4294967287, 1, 4294967287, 6));
	c = i8vec4(ivec4(2, 4294967295, 2, 4294967291));
	d = (mat3x2(-8.0, -9.0, -7.0, 2.0, 8.0, -2.0));
	e[0] = (mat4x3(3.0, 4.0, -2.0, -7.0, -1.0, -7.0, 2.0, -7.0, -8.0, 0.0, -2.0, -9.0));
	e[1] = (mat4x3(-2.0, 3.0, 1.0, 6.0, -7.0, 4.0, 0.0, -1.0, -3.0, -7.0, -5.0, 4.0));
	e[2] = (mat4x3(5.0, 0.0, -6.0, 0.0, -3.0, 4.0, 7.0, 0.0, -6.0, -5.0, 8.0, -7.0));
	e[3] = (mat4x3(-6.0, 3.0, 9.0, 7.0, 9.0, 4.0, -6.0, -3.0, 7.0, -5.0, 5.0, -3.0));
	e[4] = (mat4x3(-1.0, -8.0, 4.0, 1.0, 7.0, 1.0, 1.0, 9.0, -4.0, -3.0, 0.0, 1.0));
	e[5] = (mat4x3(-6.0, 9.0, -2.0, 3.0, 9.0, -7.0, 8.0, -4.0, 5.0, 4.0, 9.0, 9.0));
	e[6] = (mat4x3(0.0, -8.0, -1.0, -6.0, 3.0, -6.0, -1.0, 7.0, 5.0, -7.0, -3.0, 5.0));
	e[7] = (mat4x3(-2.0, 5.0, -7.0, -1.0, -6.0, -9.0, -1.0, 2.0, -9.0, 1.0, 6.0, 5.0));
	blockC[0].f = u8vec2(uvec2(0u, 3u));
	blockC[0].g[0] = (mat4x3(8.0, -4.0, -6.0, -2.0, -2.0, -9.0, -8.0, 9.0, 3.0, 0.0, 4.0, 4.0));
	blockC[0].g[1] = (mat4x3(-1.0, 6.0, 3.0, -4.0, 0.0, -8.0, -4.0, 8.0, 6.0, 8.0, -2.0, -4.0));
	blockC[0].g[2] = (mat4x3(6.0, 5.0, -3.0, 2.0, 2.0, 8.0, 8.0, 1.0, -5.0, 3.0, -4.0, -5.0));
	blockC[0].g[3] = (mat4x3(3.0, -8.0, 6.0, 7.0, 6.0, 3.0, -6.0, -7.0, 4.0, 3.0, 4.0, -2.0));
	blockC[0].g[4] = (mat4x3(2.0, 6.0, -3.0, 2.0, 4.0, -2.0, 0.0, 0.0, 3.0, -8.0, -5.0, -4.0));
	blockC[0].g[5] = (mat4x3(1.0, -9.0, -7.0, 8.0, -8.0, 5.0, -5.0, 7.0, -7.0, 9.0, 5.0, 3.0));
	blockC[0].g[6] = (mat4x3(9.0, -4.0, -9.0, 4.0, 1.0, -5.0, -1.0, 6.0, -7.0, 2.0, 5.0, 4.0));
	blockC[0].g[7] = (mat4x3(-5.0, 5.0, 9.0, 5.0, 3.0, -1.0, -6.0, -2.0, -8.0, -8.0, -3.0, -7.0));
	blockC[1].f = u8vec2(uvec2(9u, 3u));
	blockC[1].g[0] = (mat4x3(-4.0, -9.0, 7.0, 2.0, -2.0, 9.0, 5.0, -2.0, 9.0, 4.0, 4.0, -3.0));
	blockC[1].g[1] = (mat4x3(-4.0, -9.0, 2.0, 6.0, 9.0, -1.0, -5.0, 4.0, -4.0, 9.0, 9.0, -6.0));
	blockC[1].g[2] = (mat4x3(-7.0, -8.0, -9.0, -3.0, -1.0, -6.0, -5.0, 8.0, 2.0, 2.0, 7.0, 0.0));
	blockC[1].g[3] = (mat4x3(-5.0, 3.0, 2.0, 3.0, 3.0, 3.0, 3.0, 6.0, 2.0, 2.0, -4.0, 4.0));
	blockC[1].g[4] = (mat4x3(-8.0, -2.0, 3.0, 5.0, -8.0, 0.0, -2.0, -4.0, 1.0, 5.0, 5.0, -1.0));
	blockC[1].g[5] = (mat4x3(1.0, -3.0, 7.0, -9.0, 5.0, -4.0, 2.0, 4.0, -1.0, 9.0, -2.0, -4.0));
	blockC[1].g[6] = (mat4x3(-6.0, 4.0, 5.0, -9.0, -5.0, 2.0, -2.0, 7.0, -7.0, -5.0, -5.0, 4.0));
	blockC[1].g[7] = (mat4x3(7.0, 1.0, 7.0, -4.0, -5.0, 1.0, 8.0, -1.0, -2.0, -6.0, 2.0, -6.0));
	blockC[2].f = u8vec2(uvec2(5u, 3u));
	blockC[2].g[0] = (mat4x3(-9.0, 0.0, 6.0, -2.0, -3.0, -2.0, -2.0, -6.0, 5.0, 7.0, -7.0, 9.0));
	blockC[2].g[1] = (mat4x3(2.0, 7.0, -5.0, 4.0, 7.0, -3.0, 7.0, 8.0, -9.0, 8.0, 3.0, -5.0));
	blockC[2].g[2] = (mat4x3(-2.0, -9.0, -7.0, 6.0, -5.0, 8.0, 0.0, 6.0, -6.0, 7.0, 4.0, 9.0));
	blockC[2].g[3] = (mat4x3(-8.0, 9.0, 7.0, 2.0, -6.0, 6.0, 1.0, 5.0, -1.0, -8.0, 0.0, 2.0));
	blockC[2].g[4] = (mat4x3(3.0, 4.0, -2.0, 3.0, 2.0, -4.0, 7.0, -5.0, 5.0, 2.0, 1.0, 8.0));
	blockC[2].g[5] = (mat4x3(6.0, -9.0, 7.0, -8.0, -5.0, 3.0, 6.0, -8.0, 9.0, -1.0, -2.0, 0.0));
	blockC[2].g[6] = (mat4x3(0.0, -4.0, 1.0, 9.0, 6.0, 2.0, 6.0, 8.0, -3.0, 9.0, -9.0, 0.0));
	blockC[2].g[7] = (mat4x3(-4.0, -9.0, -1.0, -3.0, 3.0, -5.0, 7.0, -3.0, -5.0, 2.0, 7.0, -2.0));
	blockD.k.mA = uint8_t(3u);
	blockD.k.mB = (bvec2(true, false));
	blockD.k.mC = (mat3x4(0.0, 1.0, 6.0, 2.0, -7.0, -1.0, -5.0, 1.0, 8.0, 0.0, -7.0, 4.0));
	blockD.k.mD = (ivec3(-4, 8, -7));
}
#version 450
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
	mediump mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var, mat3(-4.0, 5.0, 1.0, 7.0, 4.0, -7.0, -4.0, 8.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std140, row_major, binding = 1) readonly buffer Block
{
	lowp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var, mat2x4(1.0, -7.0, -7.0, -5.0, -4.0, 7.0, 6.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std140, binding = 1) readonly buffer Block
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

}
#version 450
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

}
#version 450
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
	lowp mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var, mat3x4(2.0, 0.0, 2.0, 1.0, -5.0, 7.0, -3.0, -5.0, 8.0, -5.0, 8.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp ivec3 var;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((var), ivec3(-4, 5, 7)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float(var[0][0], 9.0) && allOk;
	allOk = compare_float(var[0][1], 0.0) && allOk;
	allOk = compare_float(var[0][2], -3.0) && allOk;
	allOk = compare_float(var[1][0], -8.0) && allOk;
	allOk = compare_float(var[1][1], 3.0) && allOk;
	allOk = compare_float(var[1][2], -2.0) && allOk;
	allOk = compare_float(var[2][0], 3.0) && allOk;
	allOk = compare_float(var[2][1], 4.0) && allOk;
	allOk = compare_float(var[2][2], 1.0) && allOk;
	allOk = compare_vec3(var[0], vec3(9.0, 0.0, -3.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-8.0, 3.0, -2.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(3.0, 4.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp int var;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((var), 7) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 2.0) && allOk;
	allOk = compare_mat4(var, mat4(7.0, 4.0, -4.0, -1.0, -9.0, -2.0, 4.0, -5.0, -5.0, -7.0, -8.0, 5.0, 2.0, -1.0, 0.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_float(var[0][0], -7.0) && allOk;
	allOk = compare_float(var[0][1], 8.0) && allOk;
	allOk = compare_float(var[0][2], 6.0) && allOk;
	allOk = compare_float(var[0][3], -6.0) && allOk;
	allOk = compare_float(var[1][0], -7.0) && allOk;
	allOk = compare_float(var[1][1], 8.0) && allOk;
	allOk = compare_float(var[1][2], -2.0) && allOk;
	allOk = compare_float(var[1][3], 7.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-7.0, 8.0, 6.0, -6.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-7.0, 8.0, -2.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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

layout(std430, binding = 1) readonly buffer Block
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

}
#version 450
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
	u16vec3 var[3];
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(padding), 1u) && allOk;
	allOk = compare_u16vec3(uvec3(var[0]), uvec3(0u, 5u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1]), uvec3(0u, 0u, 7u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2]), uvec3(1u, 1u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std140, row_major, binding = 1) readonly buffer Block
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

}
#version 450
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

layout(std140, column_major, binding = 1) readonly buffer Block
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

}
#version 450
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

}
#version 450
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
	highp uvec3 var[];
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((var[0]), uvec3(9u, 6u, 4u)) && allOk;
	allOk = compare_uvec3((var[1]), uvec3(7u, 2u, 7u)) && allOk;
	allOk = compare_uvec3((var[2]), uvec3(5u, 0u, 2u)) && allOk;
	allOk = compare_uvec3((var[3]), uvec3(6u, 8u, 0u)) && allOk;
	allOk = compare_uvec3((var[4]), uvec3(3u, 5u, 1u)) && allOk;
	allOk = compare_uvec3((var[5]), uvec3(7u, 2u, 3u)) && allOk;
	allOk = compare_uvec3((var[6]), uvec3(2u, 1u, 7u)) && allOk;
	allOk = compare_uvec3((var[7]), uvec3(1u, 5u, 4u)) && allOk;
	allOk = compare_uvec3((var[8]), uvec3(0u, 4u, 3u)) && allOk;
	allOk = compare_uvec3((var[9]), uvec3(1u, 4u, 3u)) && allOk;
	allOk = compare_uvec3((var[10]), uvec3(8u, 9u, 0u)) && allOk;
	allOk = compare_uvec3((var[11]), uvec3(7u, 2u, 6u)) && allOk;
	allOk = compare_uvec3((var[12]), uvec3(4u, 0u, 9u)) && allOk;
	allOk = compare_uvec3((var[13]), uvec3(5u, 2u, 4u)) && allOk;
	allOk = compare_uvec3((var[14]), uvec3(6u, 6u, 8u)) && allOk;
	allOk = compare_uvec3((var[15]), uvec3(6u, 7u, 9u)) && allOk;
	allOk = compare_uvec3((var[16]), uvec3(0u, 0u, 6u)) && allOk;
	allOk = compare_uvec3((var[17]), uvec3(0u, 2u, 2u)) && allOk;
	allOk = compare_uvec3((var[18]), uvec3(9u, 3u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat4x2(var[0], mat4x2(4.0, -5.0, -2.0, 7.0, 3.0, 2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(-7.0, -1.0, -9.0, 4.0, -9.0, -4.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(-7.0, -7.0, 4.0, 6.0, 6.0, -6.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[3], mat4x2(-1.0, 1.0, 8.0, 3.0, 5.0, -2.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[4], mat4x2(3.0, 8.0, -6.0, 7.0, 4.0, -6.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[5], mat4x2(-5.0, -6.0, 1.0, 5.0, 0.0, -2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[6], mat4x2(3.0, -9.0, 6.0, -5.0, 3.0, -2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[7], mat4x2(-2.0, 0.0, 8.0, 5.0, -1.0, 3.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[8], mat4x2(-2.0, -7.0, 7.0, 1.0, 2.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[9], mat4x2(1.0, 4.0, 5.0, -1.0, -2.0, 5.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[10], mat4x2(-4.0, 2.0, 1.0, -4.0, 1.0, -1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[11], mat4x2(-9.0, 2.0, -1.0, 8.0, 2.0, 1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[12], mat4x2(-6.0, 3.0, 3.0, -2.0, -1.0, -4.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[13], mat4x2(-9.0, -3.0, 4.0, 8.0, 5.0, 2.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[14], mat4x2(-1.0, 1.0, 5.0, -9.0, -5.0, 2.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[15], mat4x2(8.0, 8.0, -9.0, -1.0, 8.0, 1.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[16], mat4x2(1.0, 4.0, 5.0, -5.0, 0.0, 3.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[17], mat4x2(0.0, 7.0, -7.0, -3.0, -7.0, -5.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[18], mat4x2(1.0, 5.0, -7.0, -1.0, 5.0, 3.0, -2.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(scalar, binding = 1) readonly buffer Block
{
	i16vec4 var[];
};

bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(var[0]), ivec4(-6, -9, 9, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1]), ivec4(-1, -8, 8, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2]), ivec4(3, 4, 0, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(var[3]), ivec4(-2, -4, -9, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(var[4]), ivec4(4, -1, 4, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(var[5]), ivec4(6, 7, -4, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[6]), ivec4(-2, 9, 9, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(var[7]), ivec4(-3, -8, -7, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(var[8]), ivec4(7, -2, -8, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[9]), ivec4(1, 6, 9, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(var[10]), ivec4(1, -3, 9, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[11]), ivec4(4, 8, -6, -2)) && allOk;
	allOk = compare_i16vec4(ivec4(var[12]), ivec4(3, -5, 9, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[13]), ivec4(6, 3, 6, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(var[14]), ivec4(9, -8, -9, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[15]), ivec4(-9, -3, -3, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(var[16]), ivec4(-7, -4, 3, 0)) && allOk;
	allOk = compare_i16vec4(ivec4(var[17]), ivec4(-4, 5, -2, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(var[18]), ivec4(4, -6, 5, -3)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std140, buffer_reference) buffer Block
{
	lowp uvec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((block.var), uvec2(2u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (uvec2(6u, 3u));
}
#version 450
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
	allOk = compare_mat4(block.var, mat4(-2.0, -6.0, 9.0, 2.0, 2.0, -8.0, -2.0, 7.0, -4.0, -6.0, 3.0, 2.0, 9.0, -2.0, -4.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4(-7.0, 6.0, 4.0, 9.0, 8.0, 9.0, 2.0, 6.0, -6.0, 7.0, 1.0, -7.0, 1.0, 4.0, 4.0, -2.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var, mat3x2(-6.0, -5.0, -4.0, -5.0, 2.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x2(-1.0, -3.0, -4.0, 9.0, -7.0, -6.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -6.0) && allOk;
	allOk = compare_float(block.var[0][1], 3.0) && allOk;
	allOk = compare_float(block.var[0][2], 6.0) && allOk;
	allOk = compare_float(block.var[0][3], -9.0) && allOk;
	allOk = compare_float(block.var[1][0], -1.0) && allOk;
	allOk = compare_float(block.var[1][1], 8.0) && allOk;
	allOk = compare_float(block.var[1][2], 5.0) && allOk;
	allOk = compare_float(block.var[1][3], 5.0) && allOk;
	allOk = compare_float(block.var[2][0], -5.0) && allOk;
	allOk = compare_float(block.var[2][1], 5.0) && allOk;
	allOk = compare_float(block.var[2][2], -7.0) && allOk;
	allOk = compare_float(block.var[2][3], 5.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-6.0, 3.0, 6.0, -9.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-1.0, 8.0, 5.0, 5.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(-5.0, 5.0, -7.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x4(-6.0, -1.0, 0.0, -8.0, 5.0, 7.0, -2.0, -2.0, -1.0, -7.0, -3.0, -4.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var, mat4x2(-2.0, 1.0, 8.0, 4.0, 9.0, -4.0, -1.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x2(4.0, 7.0, 1.0, -9.0, -6.0, 7.0, -3.0, 8.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((block.var), vec3(-5.0, -3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (vec3(0.0, 0.0, -2.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 7.0) && allOk;
	allOk = compare_float(block.var[0][1], -2.0) && allOk;
	allOk = compare_float(block.var[1][0], -3.0) && allOk;
	allOk = compare_float(block.var[1][1], 8.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(7.0, -2.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-3.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(2.0, -7.0));
	block.var[1] = (vec2(-5.0, 4.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 9.0) && allOk;
	allOk = compare_float(block.var[0][1], 0.0) && allOk;
	allOk = compare_float(block.var[0][2], -3.0) && allOk;
	allOk = compare_float(block.var[1][0], -8.0) && allOk;
	allOk = compare_float(block.var[1][1], 3.0) && allOk;
	allOk = compare_float(block.var[1][2], -2.0) && allOk;
	allOk = compare_float(block.var[2][0], 3.0) && allOk;
	allOk = compare_float(block.var[2][1], 4.0) && allOk;
	allOk = compare_float(block.var[2][2], 1.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(9.0, 0.0, -3.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-8.0, 3.0, -2.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(3.0, 4.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(7.0, -5.0, -9.0));
	block.var[1] = (vec3(6.0, 6.0, -2.0));
	block.var[2] = (vec3(6.0, 0.0, -8.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 1.0) && allOk;
	allOk = compare_float(block.var[0][1], 1.0) && allOk;
	allOk = compare_float(block.var[0][2], -2.0) && allOk;
	allOk = compare_float(block.var[0][3], 0.0) && allOk;
	allOk = compare_float(block.var[1][0], -1.0) && allOk;
	allOk = compare_float(block.var[1][1], 5.0) && allOk;
	allOk = compare_float(block.var[1][2], 5.0) && allOk;
	allOk = compare_float(block.var[1][3], -5.0) && allOk;
	allOk = compare_float(block.var[2][0], 2.0) && allOk;
	allOk = compare_float(block.var[2][1], -6.0) && allOk;
	allOk = compare_float(block.var[2][2], 4.0) && allOk;
	allOk = compare_float(block.var[2][3], 6.0) && allOk;
	allOk = compare_float(block.var[3][0], 8.0) && allOk;
	allOk = compare_float(block.var[3][1], 1.0) && allOk;
	allOk = compare_float(block.var[3][2], -2.0) && allOk;
	allOk = compare_float(block.var[3][3], -1.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(1.0, 1.0, -2.0, 0.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-1.0, 5.0, 5.0, -5.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(2.0, -6.0, 4.0, 6.0)) && allOk;
	allOk = compare_vec4(block.var[3], vec4(8.0, 1.0, -2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(3.0, 5.0, -1.0, -5.0));
	block.var[1] = (vec4(4.0, 2.0, 8.0, -7.0));
	block.var[2] = (vec4(-2.0, 6.0, -3.0, -1.0));
	block.var[3] = (vec4(-2.0, 5.0, 7.0, 1.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var, mat2x3(-9.0, -1.0, 8.0, -7.0, 7.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x3(-7.0, 9.0, 4.0, 0.0, -8.0, -2.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var, mat2x4(-3.0, -3.0, 1.0, -9.0, 3.0, -3.0, -9.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x4(-4.0, -7.0, 5.0, -2.0, 2.0, -1.0, -3.0, -3.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(block.var, mat3x4(-7.0, 2.0, 0.0, 9.0, 8.0, 1.0, -1.0, 5.0, -1.0, 6.0, 8.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(-5.0, 3.0, -1.0, -4.0));
	block.var[1] = (vec4(4.0, 5.0, 9.0, -8.0));
	block.var[2] = (vec4(-7.0, -1.0, -4.0, 6.0));
}
#version 450
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
	allOk = compare_float(block.var[0][1], 7.0) && allOk;
	allOk = compare_float(block.var[0][2], -3.0) && allOk;
	allOk = compare_float(block.var[1][0], -4.0) && allOk;
	allOk = compare_float(block.var[1][1], 6.0) && allOk;
	allOk = compare_float(block.var[1][2], -8.0) && allOk;
	allOk = compare_float(block.var[2][0], 4.0) && allOk;
	allOk = compare_float(block.var[2][1], -7.0) && allOk;
	allOk = compare_float(block.var[2][2], -5.0) && allOk;
	allOk = compare_float(block.var[3][0], -6.0) && allOk;
	allOk = compare_float(block.var[3][1], 7.0) && allOk;
	allOk = compare_float(block.var[3][2], 5.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-4.0, 7.0, -3.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-4.0, 6.0, -8.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(4.0, -7.0, -5.0)) && allOk;
	allOk = compare_vec3(block.var[3], vec3(-6.0, 7.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x3(3.0, 8.0, 0.0, 6.0, 1.0, 4.0, -1.0, 4.0, 5.0, 9.0, 6.0, 5.0));
}
#version 450
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
	highp vec4 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((block.var[0]), vec4(-5.0, 4.0, -4.0, 6.0)) && allOk;
	allOk = compare_vec4((block.var[1]), vec4(1.0, 4.0, 8.0, 7.0)) && allOk;
	allOk = compare_vec4((block.var[2]), vec4(2.0, -4.0, 3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(-5.0, 8.0, 3.0, -4.0));
	block.var[1] = (vec4(-6.0, -1.0, -3.0, 6.0));
	block.var[2] = (vec4(5.0, -9.0, 4.0, -1.0));
}
#version 450
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
	i8vec3 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(block.var[0]), ivec3(4294967295, 4294967290, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[1]), ivec3(4294967293, 4294967289, 3)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[2]), ivec3(7, 9, 4294967292)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = i8vec3(ivec3(4294967292, 0, 0));
	block.var[1] = i8vec3(ivec3(7, 9, 4294967290));
	block.var[2] = i8vec3(ivec3(4294967288, 9, 4294967288));
}
#version 450
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
	allOk = compare_mat2(block.var[0], mat2(-6.0, 3.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(3.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(9.0, -5.0, -3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec2(-2.0, 1.0));
	block.var[0][1] = (vec2(-7.0, -1.0));
	block.var[1][0] = (vec2(5.0, -3.0));
	block.var[1][1] = (vec2(4.0, 8.0));
	block.var[2][0] = (vec2(-2.0, -6.0));
	block.var[2][1] = (vec2(-5.0, -1.0));
}
#version 450
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
	allOk = compare_float((block.padding), 2.0) && allOk;
	allOk = compare_mat2x3(block.var[0], mat2x3(7.0, -5.0, -9.0, 5.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[1], mat2x3(8.0, 9.0, 2.0, 6.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[2], mat2x3(-5.0, -8.0, 2.0, -2.0, 6.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (1.0);
	block.var[0][0] = (vec3(-3.0, 9.0, -8.0));
	block.var[0][1] = (vec3(-1.0, 1.0, -5.0));
	block.var[1][0] = (vec3(3.0, -3.0, 7.0));
	block.var[1][1] = (vec3(6.0, 6.0, -9.0));
	block.var[2][0] = (vec3(7.0, 0.0, -8.0));
	block.var[2][1] = (vec3(-2.0, -7.0, 0.0));
}
#version 450
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
	allOk = compare_float((block.padding), 5.0) && allOk;
	allOk = compare_mat3x2(block.var[0], mat3x2(-6.0, -5.0, 5.0, -6.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1], mat3x2(-6.0, -8.0, 6.0, -3.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2], mat3x2(-8.0, 9.0, -8.0, -3.0, 6.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-1.0);
	block.var[0] = (mat3x2(-5.0, -1.0, -8.0, 7.0, 8.0, -4.0));
	block.var[1] = (mat3x2(-8.0, 1.0, 5.0, -2.0, 7.0, 4.0));
	block.var[2] = (mat3x2(-6.0, 7.0, -6.0, 2.0, 5.0, 0.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0], mat4x2(-4.0, 6.0, 0.0, -5.0, 0.0, -1.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(-6.0, -1.0, 4.0, 0.0, 2.0, -3.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(-8.0, -1.0, 5.0, 4.0, 9.0, -2.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[3], mat4x2(-5.0, -4.0, 3.0, 6.0, 4.0, 3.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[4], mat4x2(-1.0, -1.0, 3.0, -6.0, 6.0, 2.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[5], mat4x2(2.0, -2.0, -4.0, 7.0, -1.0, -9.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[6], mat4x2(-5.0, 5.0, 5.0, 7.0, 5.0, 2.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[7], mat4x2(9.0, -6.0, 5.0, -9.0, 6.0, 0.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[8], mat4x2(-8.0, 7.0, -6.0, -1.0, -9.0, -7.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[9], mat4x2(5.0, 9.0, 3.0, 7.0, 1.0, -3.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[10], mat4x2(4.0, 5.0, 5.0, 6.0, 2.0, 0.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[11], mat4x2(5.0, -2.0, 4.0, 7.0, -2.0, 4.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[12], mat4x2(8.0, -5.0, -3.0, -5.0, 3.0, -9.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[13], mat4x2(-3.0, 9.0, 0.0, 7.0, 9.0, -6.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[14], mat4x2(-9.0, 3.0, -7.0, -8.0, 7.0, -1.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[15], mat4x2(-7.0, 0.0, -1.0, -5.0, 7.0, -7.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[16], mat4x2(-2.0, 4.0, 6.0, -4.0, 1.0, 5.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[17], mat4x2(9.0, 0.0, 1.0, -9.0, -5.0, 0.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[18], mat4x2(6.0, 1.0, -3.0, -1.0, -3.0, -9.0, -7.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4x2(1.0, 8.0, -9.0, 4.0, 1.0, -5.0, 2.0, -5.0));
	block.var[1] = (mat4x2(8.0, -8.0, 8.0, 3.0, 2.0, -6.0, 3.0, 8.0));
	block.var[2] = (mat4x2(8.0, 9.0, -3.0, -9.0, -2.0, 6.0, -1.0, 6.0));
	block.var[3] = (mat4x2(-5.0, -9.0, -1.0, -9.0, 0.0, -4.0, 2.0, -7.0));
	block.var[4] = (mat4x2(-3.0, -5.0, 1.0, -5.0, -1.0, 7.0, 4.0, 4.0));
	block.var[5] = (mat4x2(-5.0, 2.0, -4.0, -3.0, 0.0, 4.0, -7.0, 5.0));
	block.var[6] = (mat4x2(1.0, -9.0, 0.0, -4.0, 2.0, 9.0, -5.0, -3.0));
	block.var[7] = (mat4x2(6.0, -4.0, -9.0, 5.0, -5.0, -6.0, 8.0, -5.0));
	block.var[8] = (mat4x2(-4.0, -5.0, 6.0, 9.0, -3.0, -4.0, 3.0, -7.0));
	block.var[9] = (mat4x2(-8.0, 8.0, -4.0, -6.0, 0.0, -3.0, -6.0, -4.0));
	block.var[10] = (mat4x2(5.0, 4.0, 5.0, 7.0, 2.0, -7.0, 8.0, -3.0));
	block.var[11] = (mat4x2(8.0, 7.0, 0.0, -5.0, 4.0, 5.0, -6.0, -8.0));
	block.var[12] = (mat4x2(-7.0, 4.0, -8.0, -6.0, -3.0, -4.0, 8.0, -4.0));
	block.var[13] = (mat4x2(6.0, -9.0, -7.0, -3.0, -9.0, -6.0, -3.0, -8.0));
	block.var[14] = (mat4x2(8.0, -4.0, -8.0, 4.0, 0.0, 4.0, -3.0, 8.0));
	block.var[15] = (mat4x2(0.0, 7.0, -2.0, -3.0, -5.0, 6.0, -2.0, 7.0));
	block.var[16] = (mat4x2(4.0, -1.0, 6.0, -2.0, 0.0, 7.0, 0.0, 2.0));
	block.var[17] = (mat4x2(-7.0, -7.0, -6.0, 8.0, -7.0, -4.0, 9.0, 9.0));
	block.var[18] = (mat4x2(4.0, -8.0, -6.0, -3.0, 8.0, -1.0, -5.0, 5.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0], mat4x3(-1.0, -7.0, 8.0, 5.0, -5.0, 7.0, -9.0, 5.0, 0.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[1], mat4x3(7.0, -9.0, 6.0, 0.0, -8.0, -3.0, -6.0, 8.0, 8.0, -7.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[2], mat4x3(1.0, 0.0, 7.0, -2.0, 4.0, 9.0, 9.0, 8.0, -2.0, -2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[3], mat4x3(-9.0, -4.0, -6.0, -5.0, 7.0, 2.0, -7.0, 7.0, -9.0, -2.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[4], mat4x3(-9.0, 7.0, -2.0, 5.0, -7.0, -5.0, 3.0, -9.0, 2.0, -7.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[5], mat4x3(3.0, -7.0, -4.0, -1.0, -5.0, 4.0, -4.0, -9.0, 6.0, 6.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[6], mat4x3(-3.0, 7.0, 3.0, 4.0, -3.0, -1.0, 0.0, -4.0, 3.0, 9.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[7], mat4x3(5.0, -6.0, -2.0, 1.0, 5.0, -8.0, -3.0, -1.0, 1.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[8], mat4x3(6.0, 1.0, 3.0, -8.0, 4.0, -1.0, -3.0, 8.0, -6.0, 9.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[9], mat4x3(5.0, -6.0, 2.0, -3.0, -5.0, 5.0, -4.0, -7.0, 2.0, 2.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[10], mat4x3(5.0, 3.0, -8.0, 6.0, 8.0, 5.0, -3.0, -3.0, 3.0, 3.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[11], mat4x3(-7.0, -1.0, 3.0, -3.0, 2.0, 9.0, 0.0, -7.0, 3.0, -1.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[12], mat4x3(2.0, -3.0, 7.0, -7.0, -3.0, -9.0, 0.0, 4.0, 2.0, -2.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[13], mat4x3(7.0, -3.0, 5.0, -8.0, 3.0, -8.0, 3.0, 6.0, 3.0, 7.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[14], mat4x3(0.0, -9.0, -2.0, -4.0, -7.0, 3.0, -9.0, 6.0, -1.0, 1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[15], mat4x3(3.0, 8.0, -7.0, -3.0, 4.0, 9.0, 4.0, -3.0, -3.0, 0.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[16], mat4x3(-9.0, -2.0, 5.0, 9.0, -9.0, 7.0, -7.0, -8.0, 2.0, -8.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[17], mat4x3(4.0, -3.0, 9.0, -4.0, 9.0, 3.0, -2.0, 9.0, 0.0, -3.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[18], mat4x3(3.0, 2.0, -1.0, -2.0, -5.0, 9.0, -1.0, -2.0, 6.0, -5.0, -6.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4x3(-2.0, 9.0, 6.0, 4.0, 4.0, 3.0, 2.0, 4.0, 6.0, 7.0, -2.0, 2.0));
	block.var[1] = (mat4x3(-8.0, -2.0, 9.0, 9.0, 6.0, -2.0, 4.0, -7.0, 6.0, -7.0, 9.0, 6.0));
	block.var[2] = (mat4x3(6.0, 8.0, 8.0, 9.0, -6.0, 5.0, -3.0, 9.0, -5.0, 9.0, 9.0, -3.0));
	block.var[3] = (mat4x3(-7.0, 2.0, -4.0, -9.0, 7.0, 8.0, 8.0, 3.0, -3.0, -1.0, -5.0, 5.0));
	block.var[4] = (mat4x3(0.0, 1.0, -1.0, -6.0, -2.0, 6.0, -4.0, -8.0, -9.0, 2.0, -1.0, 3.0));
	block.var[5] = (mat4x3(-9.0, -1.0, -4.0, -9.0, 1.0, -1.0, -6.0, 4.0, -3.0, 4.0, -4.0, 4.0));
	block.var[6] = (mat4x3(0.0, 5.0, -1.0, -3.0, 9.0, 3.0, -4.0, 3.0, -6.0, -2.0, -6.0, 8.0));
	block.var[7] = (mat4x3(2.0, 9.0, -6.0, 5.0, 8.0, -3.0, 1.0, 2.0, -1.0, 3.0, -5.0, -5.0));
	block.var[8] = (mat4x3(8.0, 9.0, 0.0, 1.0, 3.0, 4.0, 4.0, 7.0, -1.0, 4.0, 0.0, 6.0));
	block.var[9] = (mat4x3(2.0, 7.0, 3.0, 1.0, 4.0, -1.0, -2.0, -5.0, -9.0, -2.0, -1.0, -6.0));
	block.var[10] = (mat4x3(-1.0, 7.0, 7.0, 4.0, 3.0, -2.0, -1.0, -2.0, -3.0, -4.0, 4.0, -6.0));
	block.var[11] = (mat4x3(9.0, 4.0, 1.0, -2.0, 6.0, 5.0, -8.0, 9.0, 8.0, -5.0, 6.0, 0.0));
	block.var[12] = (mat4x3(7.0, -6.0, 6.0, 6.0, 0.0, 6.0, -2.0, 0.0, 4.0, -2.0, -4.0, 0.0));
	block.var[13] = (mat4x3(0.0, 0.0, 8.0, 0.0, 5.0, -8.0, -7.0, 0.0, 2.0, 1.0, 6.0, -6.0));
	block.var[14] = (mat4x3(-9.0, 8.0, 6.0, 9.0, -9.0, 5.0, -2.0, 2.0, -2.0, 2.0, -6.0, -1.0));
	block.var[15] = (mat4x3(1.0, -7.0, -5.0, 9.0, -4.0, -7.0, -9.0, 7.0, -4.0, 9.0, -3.0, 3.0));
	block.var[16] = (mat4x3(7.0, -7.0, -2.0, -5.0, 7.0, 7.0, -1.0, 6.0, -1.0, 6.0, -9.0, 8.0));
	block.var[17] = (mat4x3(8.0, 7.0, -8.0, 1.0, 9.0, -1.0, -8.0, -3.0, 7.0, 9.0, -5.0, 8.0));
	block.var[18] = (mat4x3(-3.0, -3.0, 9.0, 5.0, -4.0, 6.0, 4.0, -2.0, 9.0, 0.0, -7.0, 3.0));
}
#version 450
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

layout(scalar, buffer_reference) buffer Block
{
	highp vec4 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((block.var[0]), vec4(-5.0, 4.0, -4.0, 6.0)) && allOk;
	allOk = compare_vec4((block.var[1]), vec4(1.0, 4.0, 8.0, 7.0)) && allOk;
	allOk = compare_vec4((block.var[2]), vec4(2.0, -4.0, 3.0, -8.0)) && allOk;
	allOk = compare_vec4((block.var[3]), vec4(-3.0, -3.0, -6.0, -4.0)) && allOk;
	allOk = compare_vec4((block.var[4]), vec4(-1.0, 0.0, -8.0, -8.0)) && allOk;
	allOk = compare_vec4((block.var[5]), vec4(7.0, 1.0, 8.0, -8.0)) && allOk;
	allOk = compare_vec4((block.var[6]), vec4(6.0, 9.0, -5.0, -1.0)) && allOk;
	allOk = compare_vec4((block.var[7]), vec4(8.0, -5.0, -7.0, 0.0)) && allOk;
	allOk = compare_vec4((block.var[8]), vec4(-7.0, 2.0, -6.0, 6.0)) && allOk;
	allOk = compare_vec4((block.var[9]), vec4(-1.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_vec4((block.var[10]), vec4(8.0, 1.0, 8.0, 2.0)) && allOk;
	allOk = compare_vec4((block.var[11]), vec4(3.0, -4.0, 2.0, 1.0)) && allOk;
	allOk = compare_vec4((block.var[12]), vec4(-1.0, 3.0, 2.0, -5.0)) && allOk;
	allOk = compare_vec4((block.var[13]), vec4(9.0, 1.0, -6.0, 3.0)) && allOk;
	allOk = compare_vec4((block.var[14]), vec4(0.0, 6.0, 1.0, -9.0)) && allOk;
	allOk = compare_vec4((block.var[15]), vec4(6.0, -7.0, 0.0, 0.0)) && allOk;
	allOk = compare_vec4((block.var[16]), vec4(8.0, -6.0, 5.0, -4.0)) && allOk;
	allOk = compare_vec4((block.var[17]), vec4(5.0, -5.0, -2.0, -4.0)) && allOk;
	allOk = compare_vec4((block.var[18]), vec4(6.0, -4.0, -2.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(-5.0, 8.0, 3.0, -4.0));
	block.var[1] = (vec4(-6.0, -1.0, -3.0, 6.0));
	block.var[2] = (vec4(5.0, -9.0, 4.0, -1.0));
	block.var[3] = (vec4(-7.0, -6.0, -2.0, -8.0));
	block.var[4] = (vec4(8.0, 7.0, 5.0, 1.0));
	block.var[5] = (vec4(-6.0, -5.0, -8.0, 8.0));
	block.var[6] = (vec4(0.0, 8.0, 4.0, -4.0));
	block.var[7] = (vec4(-8.0, -3.0, 9.0, -7.0));
	block.var[8] = (vec4(-9.0, 2.0, -6.0, 6.0));
	block.var[9] = (vec4(6.0, 2.0, -3.0, 0.0));
	block.var[10] = (vec4(-9.0, 8.0, -8.0, 0.0));
	block.var[11] = (vec4(2.0, 6.0, 6.0, 1.0));
	block.var[12] = (vec4(1.0, 7.0, 1.0, 1.0));
	block.var[13] = (vec4(-7.0, -6.0, -7.0, -4.0));
	block.var[14] = (vec4(8.0, -1.0, -6.0, -8.0));
	block.var[15] = (vec4(9.0, 7.0, -3.0, -8.0));
	block.var[16] = (vec4(-3.0, -9.0, 2.0, 1.0));
	block.var[17] = (vec4(-7.0, 3.0, -5.0, 8.0));
	block.var[18] = (vec4(5.0, -4.0, -5.0, 6.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0], mat2(-5.0, -2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(-2.0, -4.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(-9.0, 9.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[3], mat2(8.0, -3.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[4], mat2(9.0, -8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[5], mat2(8.0, -2.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[6], mat2(9.0, 8.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[7], mat2(-1.0, -8.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[8], mat2(8.0, -4.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[9], mat2(3.0, 3.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[10], mat2(0.0, -3.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[11], mat2(8.0, -5.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[12], mat2(7.0, 8.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[13], mat2(9.0, 8.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[14], mat2(3.0, 3.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[15], mat2(-3.0, -8.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[16], mat2(6.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[17], mat2(-2.0, -9.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[18], mat2(4.0, -9.0, 2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2(-2.0, -8.0, -7.0, 9.0));
	block.var[1] = (mat2(2.0, 2.0, -4.0, -5.0));
	block.var[2] = (mat2(-1.0, -4.0, 0.0, -1.0));
	block.var[3] = (mat2(0.0, 4.0, -3.0, -4.0));
	block.var[4] = (mat2(-6.0, 0.0, 5.0, 1.0));
	block.var[5] = (mat2(-6.0, 9.0, 5.0, 9.0));
	block.var[6] = (mat2(5.0, -3.0, -3.0, 6.0));
	block.var[7] = (mat2(-4.0, -6.0, -2.0, -6.0));
	block.var[8] = (mat2(-3.0, -4.0, -7.0, -9.0));
	block.var[9] = (mat2(8.0, 2.0, -6.0, 9.0));
	block.var[10] = (mat2(-5.0, -2.0, 4.0, 9.0));
	block.var[11] = (mat2(4.0, 7.0, 4.0, -8.0));
	block.var[12] = (mat2(5.0, 7.0, 7.0, -8.0));
	block.var[13] = (mat2(7.0, -9.0, -2.0, 4.0));
	block.var[14] = (mat2(3.0, 3.0, 3.0, -6.0));
	block.var[15] = (mat2(-4.0, -8.0, -2.0, 5.0));
	block.var[16] = (mat2(-3.0, 5.0, 0.0, -2.0));
	block.var[17] = (mat2(-3.0, 0.0, -9.0, 1.0));
	block.var[18] = (mat2(-8.0, 1.0, -1.0, -3.0));
}
#version 450
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
	f16vec2 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(block.var[0]), vec2(-6.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1]), vec2(1.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2]), vec2(6.0, 3.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[3]), vec2(2.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[4]), vec2(8.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[5]), vec2(-7.0, -2.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[6]), vec2(4.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[7]), vec2(3.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[8]), vec2(0.0, -8.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[9]), vec2(8.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[10]), vec2(7.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[11]), vec2(1.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[12]), vec2(4.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[13]), vec2(-9.0, -2.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[14]), vec2(2.0, -4.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[15]), vec2(-3.0, -7.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[16]), vec2(6.0, 9.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[17]), vec2(4.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[18]), vec2(-4.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = f16vec2(vec2(-2.0, 4.0));
	block.var[1] = f16vec2(vec2(-2.0, 4.0));
	block.var[2] = f16vec2(vec2(-1.0, 1.0));
	block.var[3] = f16vec2(vec2(9.0, 4.0));
	block.var[4] = f16vec2(vec2(8.0, -8.0));
	block.var[5] = f16vec2(vec2(1.0, -3.0));
	block.var[6] = f16vec2(vec2(2.0, 2.0));
	block.var[7] = f16vec2(vec2(-6.0, 5.0));
	block.var[8] = f16vec2(vec2(5.0, -7.0));
	block.var[9] = f16vec2(vec2(3.0, 0.0));
	block.var[10] = f16vec2(vec2(-2.0, 3.0));
	block.var[11] = f16vec2(vec2(-6.0, 5.0));
	block.var[12] = f16vec2(vec2(6.0, 0.0));
	block.var[13] = f16vec2(vec2(3.0, 5.0));
	block.var[14] = f16vec2(vec2(9.0, -9.0));
	block.var[15] = f16vec2(vec2(-6.0, 7.0));
	block.var[16] = f16vec2(vec2(3.0, -7.0));
	block.var[17] = f16vec2(vec2(4.0, -5.0));
	block.var[18] = f16vec2(vec2(7.0, -6.0));
}
#version 450
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
	allOk = compare_mat3(block.var[0][0], mat3(-7.0, -8.0, -9.0, -8.0, 8.0, 6.0, 6.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[0][1], mat3(9.0, 5.0, -2.0, 9.0, -8.0, 6.0, -3.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[0][2], mat3(-1.0, -5.0, -7.0, -6.0, 8.0, 8.0, -2.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[1][0], mat3(-7.0, -7.0, 9.0, 5.0, -5.0, 1.0, -2.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[1][1], mat3(8.0, 3.0, 7.0, -8.0, -1.0, -2.0, -9.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[1][2], mat3(4.0, -4.0, -9.0, 1.0, 5.0, 8.0, -8.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[2][0], mat3(5.0, -8.0, -9.0, 7.0, 9.0, -5.0, -5.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[2][1], mat3(1.0, -3.0, -2.0, -9.0, 8.0, 9.0, -8.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[2][2], mat3(-3.0, -2.0, 9.0, 5.0, -3.0, 9.0, 7.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[3][0], mat3(8.0, 8.0, -8.0, -2.0, -9.0, -6.0, -6.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[3][1], mat3(9.0, -8.0, 7.0, -7.0, 7.0, 1.0, 7.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[3][2], mat3(-3.0, 3.0, 3.0, -7.0, -7.0, -7.0, 4.0, 6.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat3(-6.0, 9.0, 1.0, 4.0, -8.0, 5.0, 7.0, 2.0, 2.0));
	block.var[0][1] = (mat3(8.0, -8.0, -2.0, 2.0, 8.0, 4.0, 2.0, 1.0, 7.0));
	block.var[0][2] = (mat3(-2.0, 5.0, 7.0, 4.0, 7.0, -3.0, 9.0, 1.0, 9.0));
	block.var[1][0] = (mat3(2.0, 1.0, 2.0, -5.0, 4.0, 1.0, 4.0, 3.0, -1.0));
	block.var[1][1] = (mat3(-6.0, -8.0, 4.0, 3.0, -3.0, 0.0, -1.0, -8.0, -9.0));
	block.var[1][2] = (mat3(2.0, -3.0, 9.0, -8.0, -3.0, -5.0, 1.0, -9.0, 1.0));
	block.var[2][0] = (mat3(3.0, 5.0, -9.0, 5.0, -8.0, -3.0, -5.0, -7.0, -7.0));
	block.var[2][1] = (mat3(0.0, -4.0, 7.0, 4.0, -5.0, 4.0, 7.0, -1.0, -1.0));
	block.var[2][2] = (mat3(9.0, 7.0, -8.0, -9.0, 3.0, 9.0, 5.0, -5.0, -7.0));
	block.var[3][0] = (mat3(-6.0, -7.0, -2.0, 3.0, 2.0, -9.0, 1.0, -7.0, 3.0));
	block.var[3][1] = (mat3(2.0, 4.0, 1.0, 6.0, -2.0, 6.0, 2.0, 0.0, 3.0));
	block.var[3][2] = (mat3(-8.0, 3.0, 6.0, -4.0, -9.0, -9.0, 5.0, -9.0, -1.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0], mat4x3(3.0, 6.0, 1.0, -6.0, -9.0, -8.0, 6.0, 4.0, 5.0, -6.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1], mat4x3(-1.0, 1.0, 2.0, 9.0, 3.0, 1.0, 1.0, 7.0, -1.0, 8.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2], mat4x3(9.0, 4.0, 5.0, -9.0, 2.0, 0.0, -9.0, -2.0, 1.0, -7.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0], mat4x3(-5.0, -5.0, -5.0, 8.0, -6.0, 8.0, -7.0, -4.0, -1.0, 2.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1], mat4x3(-5.0, 8.0, 5.0, 8.0, -2.0, 2.0, -5.0, -4.0, -3.0, 8.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2], mat4x3(5.0, -4.0, 3.0, -9.0, 7.0, 8.0, -7.0, -7.0, 6.0, -2.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0], mat4x3(-3.0, 0.0, 6.0, -2.0, 7.0, 3.0, 6.0, -7.0, 3.0, -8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1], mat4x3(-1.0, 0.0, -7.0, 9.0, -7.0, -6.0, -5.0, 2.0, 8.0, 6.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2], mat4x3(7.0, -1.0, -6.0, 5.0, 6.0, -1.0, -1.0, -3.0, -1.0, 5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0], mat4x3(2.0, 6.0, 4.0, 7.0, 3.0, -8.0, 0.0, 3.0, -4.0, 2.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1], mat4x3(2.0, -4.0, 3.0, 9.0, 2.0, 9.0, 2.0, -5.0, -7.0, -1.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][2], mat4x3(-7.0, -7.0, 9.0, -8.0, -1.0, 0.0, 5.0, 6.0, 4.0, -7.0, -8.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec3(1.0, 2.0, -5.0));
	block.var[0][0][1] = (vec3(-3.0, -2.0, 2.0));
	block.var[0][0][2] = (vec3(-5.0, 9.0, 4.0));
	block.var[0][0][3] = (vec3(2.0, -4.0, 9.0));
	block.var[0][1][0] = (vec3(8.0, -4.0, -5.0));
	block.var[0][1][1] = (vec3(-5.0, 6.0, 8.0));
	block.var[0][1][2] = (vec3(-7.0, 4.0, -8.0));
	block.var[0][1][3] = (vec3(-1.0, 1.0, 1.0));
	block.var[0][2][0] = (vec3(-4.0, 5.0, 7.0));
	block.var[0][2][1] = (vec3(9.0, 5.0, -7.0));
	block.var[0][2][2] = (vec3(8.0, 9.0, 0.0));
	block.var[0][2][3] = (vec3(-3.0, 3.0, 0.0));
	block.var[1][0][0] = (vec3(7.0, -8.0, -7.0));
	block.var[1][0][1] = (vec3(2.0, 7.0, 5.0));
	block.var[1][0][2] = (vec3(5.0, -7.0, 0.0));
	block.var[1][0][3] = (vec3(-2.0, 9.0, -7.0));
	block.var[1][1][0] = (vec3(2.0, -9.0, 0.0));
	block.var[1][1][1] = (vec3(9.0, -2.0, -8.0));
	block.var[1][1][2] = (vec3(-9.0, 5.0, 9.0));
	block.var[1][1][3] = (vec3(0.0, 8.0, -9.0));
	block.var[1][2][0] = (vec3(2.0, 1.0, -7.0));
	block.var[1][2][1] = (vec3(-7.0, 8.0, 7.0));
	block.var[1][2][2] = (vec3(8.0, -8.0, -5.0));
	block.var[1][2][3] = (vec3(5.0, 1.0, -3.0));
	block.var[2][0][0] = (vec3(2.0, 5.0, 2.0));
	block.var[2][0][1] = (vec3(2.0, 3.0, -2.0));
	block.var[2][0][2] = (vec3(5.0, 4.0, 6.0));
	block.var[2][0][3] = (vec3(-1.0, 5.0, 6.0));
	block.var[2][1][0] = (vec3(1.0, 2.0, -4.0));
	block.var[2][1][1] = (vec3(9.0, -1.0, 6.0));
	block.var[2][1][2] = (vec3(9.0, -1.0, -2.0));
	block.var[2][1][3] = (vec3(-1.0, -8.0, 3.0));
	block.var[2][2][0] = (vec3(-4.0, 1.0, -4.0));
	block.var[2][2][1] = (vec3(4.0, 2.0, 0.0));
	block.var[2][2][2] = (vec3(1.0, -6.0, 1.0));
	block.var[2][2][3] = (vec3(-7.0, -9.0, 8.0));
	block.var[3][0][0] = (vec3(1.0, 9.0, -4.0));
	block.var[3][0][1] = (vec3(1.0, -5.0, 9.0));
	block.var[3][0][2] = (vec3(2.0, -1.0, -1.0));
	block.var[3][0][3] = (vec3(5.0, 7.0, -4.0));
	block.var[3][1][0] = (vec3(-2.0, 9.0, -4.0));
	block.var[3][1][1] = (vec3(-4.0, 4.0, -1.0));
	block.var[3][1][2] = (vec3(0.0, 7.0, 9.0));
	block.var[3][1][3] = (vec3(-8.0, 3.0, 9.0));
	block.var[3][2][0] = (vec3(-7.0, -1.0, -9.0));
	block.var[3][2][1] = (vec3(-7.0, 3.0, 5.0));
	block.var[3][2][2] = (vec3(-7.0, 1.0, -1.0));
	block.var[3][2][3] = (vec3(-5.0, -7.0, 7.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0], mat4x3(-4.0, 6.0, 7.0, -6.0, 2.0, -5.0, 0.0, -2.0, 8.0, -7.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1], mat4x3(-4.0, -5.0, -7.0, 0.0, -7.0, -8.0, -3.0, 1.0, 3.0, 7.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2], mat4x3(-9.0, 5.0, 2.0, -9.0, 9.0, 2.0, 8.0, -7.0, -4.0, 8.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0], mat4x3(-9.0, 3.0, 0.0, 1.0, -4.0, 8.0, 3.0, -7.0, 8.0, -3.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1], mat4x3(9.0, -8.0, -2.0, 4.0, -2.0, -5.0, -8.0, -4.0, -1.0, -9.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2], mat4x3(-3.0, -2.0, 9.0, -5.0, -8.0, 1.0, -7.0, 6.0, -4.0, -6.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0], mat4x3(1.0, -2.0, 6.0, 7.0, -5.0, 9.0, -9.0, 6.0, -8.0, -3.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1], mat4x3(5.0, -9.0, 6.0, 3.0, 3.0, 0.0, 0.0, -6.0, 9.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2], mat4x3(-1.0, -2.0, 2.0, -7.0, -8.0, -5.0, 3.0, -4.0, 5.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0], mat4x3(5.0, 4.0, 1.0, -4.0, -7.0, 2.0, 0.0, 9.0, 7.0, -2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1], mat4x3(-1.0, 6.0, -7.0, -6.0, 3.0, -7.0, -6.0, 4.0, 7.0, 5.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][2], mat4x3(1.0, 6.0, 2.0, 0.0, -4.0, 0.0, 8.0, -8.0, 7.0, 6.0, 3.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec3(-3.0, -6.0, 6.0));
	block.var[0][0][1] = (vec3(1.0, -4.0, -3.0));
	block.var[0][0][2] = (vec3(-3.0, 3.0, -2.0));
	block.var[0][0][3] = (vec3(-7.0, 1.0, -5.0));
	block.var[0][1][0] = (vec3(-1.0, -5.0, 7.0));
	block.var[0][1][1] = (vec3(1.0, -2.0, -4.0));
	block.var[0][1][2] = (vec3(-4.0, -6.0, 5.0));
	block.var[0][1][3] = (vec3(-2.0, 6.0, -9.0));
	block.var[0][2][0] = (vec3(5.0, -5.0, 7.0));
	block.var[0][2][1] = (vec3(-4.0, 8.0, -3.0));
	block.var[0][2][2] = (vec3(-2.0, 0.0, 8.0));
	block.var[0][2][3] = (vec3(-2.0, 6.0, -3.0));
	block.var[1][0][0] = (vec3(-9.0, -2.0, -2.0));
	block.var[1][0][1] = (vec3(7.0, 9.0, -4.0));
	block.var[1][0][2] = (vec3(3.0, 1.0, 0.0));
	block.var[1][0][3] = (vec3(-9.0, -2.0, -7.0));
	block.var[1][1][0] = (vec3(-5.0, -6.0, 5.0));
	block.var[1][1][1] = (vec3(-2.0, -7.0, 5.0));
	block.var[1][1][2] = (vec3(-2.0, -6.0, 4.0));
	block.var[1][1][3] = (vec3(9.0, 5.0, -9.0));
	block.var[1][2][0] = (vec3(-3.0, 3.0, 7.0));
	block.var[1][2][1] = (vec3(3.0, -4.0, -8.0));
	block.var[1][2][2] = (vec3(-2.0, 2.0, -1.0));
	block.var[1][2][3] = (vec3(1.0, -9.0, 9.0));
	block.var[2][0][0] = (vec3(-7.0, -7.0, -7.0));
	block.var[2][0][1] = (vec3(6.0, -9.0, 3.0));
	block.var[2][0][2] = (vec3(-5.0, 2.0, 4.0));
	block.var[2][0][3] = (vec3(-2.0, -4.0, -6.0));
	block.var[2][1][0] = (vec3(-1.0, 5.0, 5.0));
	block.var[2][1][1] = (vec3(-9.0, -3.0, -9.0));
	block.var[2][1][2] = (vec3(3.0, 2.0, 0.0));
	block.var[2][1][3] = (vec3(0.0, -9.0, 7.0));
	block.var[2][2][0] = (vec3(5.0, -5.0, -2.0));
	block.var[2][2][1] = (vec3(6.0, 5.0, -4.0));
	block.var[2][2][2] = (vec3(-2.0, 9.0, -3.0));
	block.var[2][2][3] = (vec3(2.0, 5.0, -4.0));
	block.var[3][0][0] = (vec3(6.0, 4.0, 7.0));
	block.var[3][0][1] = (vec3(1.0, -4.0, -6.0));
	block.var[3][0][2] = (vec3(4.0, -6.0, -5.0));
	block.var[3][0][3] = (vec3(5.0, 6.0, -1.0));
	block.var[3][1][0] = (vec3(6.0, 3.0, -9.0));
	block.var[3][1][1] = (vec3(-7.0, 3.0, -4.0));
	block.var[3][1][2] = (vec3(1.0, 2.0, 6.0));
	block.var[3][1][3] = (vec3(-2.0, 3.0, 7.0));
	block.var[3][2][0] = (vec3(-5.0, 8.0, -9.0));
	block.var[3][2][1] = (vec3(-4.0, -1.0, -9.0));
	block.var[3][2][2] = (vec3(5.0, 5.0, 6.0));
	block.var[3][2][3] = (vec3(-8.0, 1.0, -7.0));
}
#version 450
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
	i8vec4 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(block.var[0][0]), ivec4(4294967293, 4294967289, 4294967295, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[0][1]), ivec4(5, 4294967288, 4294967292, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[0][2]), ivec4(3, 3, 4294967290, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][0]), ivec4(4294967289, 4294967292, 4294967291, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][1]), ivec4(1, 4294967288, 8, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][2]), ivec4(0, 3, 4294967294, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][0]), ivec4(1, 4294967295, 4294967292, 6)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][1]), ivec4(4294967291, 5, 4294967289, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][2]), ivec4(7, 2, 2, 4)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[3][0]), ivec4(4294967295, 9, 4294967287, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[3][1]), ivec4(8, 4294967290, 4294967289, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[3][2]), ivec4(4294967293, 4294967288, 9, 2)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = i8vec4(ivec4(4294967294, 4294967292, 4294967290, 4294967289));
	block.var[0][1] = i8vec4(ivec4(4294967291, 4294967291, 4, 4294967290));
	block.var[0][2] = i8vec4(ivec4(4294967295, 4294967287, 4294967293, 8));
	block.var[1][0] = i8vec4(ivec4(6, 4, 9, 4294967287));
	block.var[1][1] = i8vec4(ivec4(4294967295, 4294967292, 4294967287, 3));
	block.var[1][2] = i8vec4(ivec4(9, 4294967288, 4294967290, 4294967287));
	block.var[2][0] = i8vec4(ivec4(8, 5, 4, 5));
	block.var[2][1] = i8vec4(ivec4(5, 4294967289, 4294967287, 4294967294));
	block.var[2][2] = i8vec4(ivec4(4294967291, 4294967291, 4, 5));
	block.var[3][0] = i8vec4(ivec4(4294967293, 4294967294, 4294967289, 4294967291));
	block.var[3][1] = i8vec4(ivec4(2, 5, 4, 6));
	block.var[3][2] = i8vec4(ivec4(4294967292, 7, 8, 9));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0], mat3x2(-8.0, -5.0, -1.0, 5.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1], mat3x2(7.0, -5.0, -1.0, -7.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2], mat3x2(3.0, 7.0, 0.0, 5.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0], mat3x2(5.0, -5.0, -4.0, 5.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1], mat3x2(4.0, -6.0, -8.0, -7.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2], mat3x2(1.0, 3.0, 6.0, 9.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0], mat3x2(-5.0, -8.0, -9.0, 9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1], mat3x2(-8.0, 8.0, -1.0, -4.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2], mat3x2(2.0, 8.0, 8.0, -5.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0], mat3x2(-9.0, 8.0, -3.0, -8.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1], mat3x2(-5.0, 7.0, 5.0, -3.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][2], mat3x2(-6.0, -3.0, -1.0, -1.0, -3.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec2(-4.0, -6.0));
	block.var[0][0][1] = (vec2(1.0, -3.0));
	block.var[0][0][2] = (vec2(-1.0, -9.0));
	block.var[0][1][0] = (vec2(3.0, -2.0));
	block.var[0][1][1] = (vec2(5.0, -8.0));
	block.var[0][1][2] = (vec2(2.0, -9.0));
	block.var[0][2][0] = (vec2(1.0, -5.0));
	block.var[0][2][1] = (vec2(0.0, -2.0));
	block.var[0][2][2] = (vec2(2.0, -1.0));
	block.var[1][0][0] = (vec2(-7.0, 9.0));
	block.var[1][0][1] = (vec2(-8.0, 7.0));
	block.var[1][0][2] = (vec2(1.0, -9.0));
	block.var[1][1][0] = (vec2(-5.0, -5.0));
	block.var[1][1][1] = (vec2(9.0, 3.0));
	block.var[1][1][2] = (vec2(-3.0, -6.0));
	block.var[1][2][0] = (vec2(1.0, 3.0));
	block.var[1][2][1] = (vec2(-3.0, -4.0));
	block.var[1][2][2] = (vec2(-9.0, 4.0));
	block.var[2][0][0] = (vec2(-2.0, -3.0));
	block.var[2][0][1] = (vec2(-5.0, 1.0));
	block.var[2][0][2] = (vec2(-5.0, 8.0));
	block.var[2][1][0] = (vec2(7.0, 8.0));
	block.var[2][1][1] = (vec2(-1.0, -3.0));
	block.var[2][1][2] = (vec2(-8.0, 5.0));
	block.var[2][2][0] = (vec2(6.0, 6.0));
	block.var[2][2][1] = (vec2(0.0, -8.0));
	block.var[2][2][2] = (vec2(-6.0, -4.0));
	block.var[3][0][0] = (vec2(-6.0, -5.0));
	block.var[3][0][1] = (vec2(8.0, 5.0));
	block.var[3][0][2] = (vec2(-9.0, 0.0));
	block.var[3][1][0] = (vec2(6.0, -3.0));
	block.var[3][1][1] = (vec2(6.0, 0.0));
	block.var[3][1][2] = (vec2(1.0, 6.0));
	block.var[3][2][0] = (vec2(4.0, 4.0));
	block.var[3][2][1] = (vec2(0.0, -1.0));
	block.var[3][2][2] = (vec2(-2.0, 2.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0], mat4x2(0.0, 6.0, -3.0, 7.0, 1.0, -8.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1], mat4x2(2.0, -3.0, -5.0, 5.0, 5.0, 1.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2], mat4x2(1.0, 1.0, -2.0, -3.0, -9.0, 3.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0], mat4x2(6.0, -2.0, -9.0, 5.0, -5.0, -6.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1], mat4x2(5.0, -3.0, 5.0, 6.0, -4.0, -8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2], mat4x2(-5.0, 4.0, -9.0, 6.0, 8.0, -3.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0], mat4x2(9.0, 5.0, 0.0, -5.0, 6.0, -8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1], mat4x2(2.0, 6.0, -5.0, 2.0, -8.0, -2.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2], mat4x2(6.0, -1.0, 6.0, -3.0, 4.0, 0.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0], mat4x2(-5.0, 8.0, 8.0, -7.0, 4.0, 6.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1], mat4x2(-9.0, -8.0, 9.0, -2.0, -7.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][2], mat4x2(-5.0, 0.0, 3.0, 9.0, -8.0, -1.0, 4.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat4x2(8.0, -5.0, 3.0, 0.0, -9.0, 4.0, -5.0, 3.0));
	block.var[0][1] = (mat4x2(6.0, 3.0, 6.0, -6.0, 0.0, -3.0, -2.0, -4.0));
	block.var[0][2] = (mat4x2(5.0, 4.0, 1.0, 0.0, 7.0, -9.0, -4.0, 5.0));
	block.var[1][0] = (mat4x2(6.0, 1.0, 0.0, 3.0, 2.0, -5.0, -4.0, 5.0));
	block.var[1][1] = (mat4x2(5.0, -4.0, -7.0, -8.0, 9.0, -4.0, 5.0, 5.0));
	block.var[1][2] = (mat4x2(-1.0, 6.0, -6.0, 5.0, 4.0, -3.0, 1.0, -4.0));
	block.var[2][0] = (mat4x2(1.0, -6.0, 2.0, 4.0, 7.0, 1.0, 9.0, 5.0));
	block.var[2][1] = (mat4x2(8.0, -7.0, 6.0, -7.0, -4.0, 5.0, 3.0, -2.0));
	block.var[2][2] = (mat4x2(-2.0, -5.0, -1.0, 1.0, -8.0, 4.0, 9.0, 2.0));
	block.var[3][0] = (mat4x2(-5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 1.0, 1.0));
	block.var[3][1] = (mat4x2(1.0, -9.0, -1.0, 6.0, -9.0, -7.0, -8.0, 8.0));
	block.var[3][2] = (mat4x2(-2.0, 7.0, 8.0, -9.0, 4.0, -3.0, 0.0, -7.0));
}
#version 450
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
	uint16_t var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(block.var[0][0]), 9u) && allOk;
	allOk = compare_uint16_t(uint(block.var[0][1]), 5u) && allOk;
	allOk = compare_uint16_t(uint(block.var[0][2]), 4u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][0]), 1u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][1]), 0u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][2]), 9u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][0]), 2u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][1]), 0u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][2]), 6u) && allOk;
	allOk = compare_uint16_t(uint(block.var[3][0]), 9u) && allOk;
	allOk = compare_uint16_t(uint(block.var[3][1]), 8u) && allOk;
	allOk = compare_uint16_t(uint(block.var[3][2]), 1u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = uint16_t(9u);
	block.var[0][1] = uint16_t(1u);
	block.var[0][2] = uint16_t(1u);
	block.var[1][0] = uint16_t(0u);
	block.var[1][1] = uint16_t(7u);
	block.var[1][2] = uint16_t(5u);
	block.var[2][0] = uint16_t(8u);
	block.var[2][1] = uint16_t(1u);
	block.var[2][2] = uint16_t(9u);
	block.var[3][0] = uint16_t(7u);
	block.var[3][1] = uint16_t(2u);
	block.var[3][2] = uint16_t(6u);
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(-8.0, -5.0, -1.0, 5.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(7.0, -5.0, -1.0, -7.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][2], mat3x2(3.0, 7.0, 0.0, 5.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(-5.0, -1.0, -9.0, 4.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(-1.0, 6.0, 2.0, 9.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][2], mat3x2(4.0, 7.0, 5.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(5.0, -5.0, -4.0, 5.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(4.0, -6.0, -8.0, -7.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][2], mat3x2(1.0, 3.0, 6.0, 9.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(1.0, -8.0, 5.0, 4.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(3.0, -9.0, 0.0, 9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][2], mat3x2(5.0, -7.0, -7.0, -4.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(-5.0, -8.0, -9.0, 9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(-8.0, 8.0, -1.0, -4.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][2], mat3x2(2.0, 8.0, 8.0, -5.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(-3.0, 8.0, 5.0, 5.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(-5.0, 5.0, 8.0, 9.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][2], mat3x2(4.0, 4.0, 6.0, 3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][0], mat3x2(-9.0, 8.0, -3.0, -8.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][1], mat3x2(-5.0, 7.0, 5.0, -3.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][2], mat3x2(-6.0, -3.0, -1.0, -1.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][0], mat3x2(-9.0, -9.0, -1.0, 8.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][1], mat3x2(-6.0, -8.0, -1.0, 6.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][2], mat3x2(-3.0, -6.0, 1.0, -9.0, 2.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(-4.0, -6.0));
	block.var[0][0][0][1] = (vec2(1.0, -3.0));
	block.var[0][0][0][2] = (vec2(-1.0, -9.0));
	block.var[0][0][1][0] = (vec2(3.0, -2.0));
	block.var[0][0][1][1] = (vec2(5.0, -8.0));
	block.var[0][0][1][2] = (vec2(2.0, -9.0));
	block.var[0][0][2][0] = (vec2(1.0, -5.0));
	block.var[0][0][2][1] = (vec2(0.0, -2.0));
	block.var[0][0][2][2] = (vec2(2.0, -1.0));
	block.var[0][1][0][0] = (vec2(-1.0, -9.0));
	block.var[0][1][0][1] = (vec2(-8.0, 9.0));
	block.var[0][1][0][2] = (vec2(-1.0, -6.0));
	block.var[0][1][1][0] = (vec2(-5.0, 7.0));
	block.var[0][1][1][1] = (vec2(-8.0, -6.0));
	block.var[0][1][1][2] = (vec2(1.0, -5.0));
	block.var[0][1][2][0] = (vec2(-3.0, 8.0));
	block.var[0][1][2][1] = (vec2(-2.0, 3.0));
	block.var[0][1][2][2] = (vec2(-2.0, 5.0));
	block.var[1][0][0][0] = (vec2(-7.0, 9.0));
	block.var[1][0][0][1] = (vec2(-8.0, 7.0));
	block.var[1][0][0][2] = (vec2(1.0, -9.0));
	block.var[1][0][1][0] = (vec2(-5.0, -5.0));
	block.var[1][0][1][1] = (vec2(9.0, 3.0));
	block.var[1][0][1][2] = (vec2(-3.0, -6.0));
	block.var[1][0][2][0] = (vec2(1.0, 3.0));
	block.var[1][0][2][1] = (vec2(-3.0, -4.0));
	block.var[1][0][2][2] = (vec2(-9.0, 4.0));
	block.var[1][1][0][0] = (vec2(7.0, -3.0));
	block.var[1][1][0][1] = (vec2(4.0, 5.0));
	block.var[1][1][0][2] = (vec2(-9.0, 3.0));
	block.var[1][1][1][0] = (vec2(6.0, -1.0));
	block.var[1][1][1][1] = (vec2(-6.0, -5.0));
	block.var[1][1][1][2] = (vec2(7.0, -6.0));
	block.var[1][1][2][0] = (vec2(1.0, 8.0));
	block.var[1][1][2][1] = (vec2(7.0, -1.0));
	block.var[1][1][2][2] = (vec2(2.0, 6.0));
	block.var[2][0][0][0] = (vec2(-2.0, -3.0));
	block.var[2][0][0][1] = (vec2(-5.0, 1.0));
	block.var[2][0][0][2] = (vec2(-5.0, 8.0));
	block.var[2][0][1][0] = (vec2(7.0, 8.0));
	block.var[2][0][1][1] = (vec2(-1.0, -3.0));
	block.var[2][0][1][2] = (vec2(-8.0, 5.0));
	block.var[2][0][2][0] = (vec2(6.0, 6.0));
	block.var[2][0][2][1] = (vec2(0.0, -8.0));
	block.var[2][0][2][2] = (vec2(-6.0, -4.0));
	block.var[2][1][0][0] = (vec2(-6.0, 5.0));
	block.var[2][1][0][1] = (vec2(6.0, -8.0));
	block.var[2][1][0][2] = (vec2(-2.0, -1.0));
	block.var[2][1][1][0] = (vec2(-3.0, -3.0));
	block.var[2][1][1][1] = (vec2(-5.0, 8.0));
	block.var[2][1][1][2] = (vec2(8.0, -7.0));
	block.var[2][1][2][0] = (vec2(-6.0, 6.0));
	block.var[2][1][2][1] = (vec2(-9.0, 5.0));
	block.var[2][1][2][2] = (vec2(-5.0, 8.0));
	block.var[3][0][0][0] = (vec2(-6.0, -5.0));
	block.var[3][0][0][1] = (vec2(8.0, 5.0));
	block.var[3][0][0][2] = (vec2(-9.0, 0.0));
	block.var[3][0][1][0] = (vec2(6.0, -3.0));
	block.var[3][0][1][1] = (vec2(6.0, 0.0));
	block.var[3][0][1][2] = (vec2(1.0, 6.0));
	block.var[3][0][2][0] = (vec2(4.0, 4.0));
	block.var[3][0][2][1] = (vec2(0.0, -1.0));
	block.var[3][0][2][2] = (vec2(-2.0, 2.0));
	block.var[3][1][0][0] = (vec2(4.0, -5.0));
	block.var[3][1][0][1] = (vec2(1.0, 4.0));
	block.var[3][1][0][2] = (vec2(8.0, 1.0));
	block.var[3][1][1][0] = (vec2(8.0, -4.0));
	block.var[3][1][1][1] = (vec2(-6.0, 2.0));
	block.var[3][1][1][2] = (vec2(-5.0, -5.0));
	block.var[3][1][2][0] = (vec2(-4.0, 1.0));
	block.var[3][1][2][1] = (vec2(2.0, 4.0));
	block.var[3][1][2][2] = (vec2(-6.0, 8.0));
}
#version 450
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
	allOk = compare_float((block.padding), 1.0) && allOk;
	allOk = compare_mat2x3(block.var[0][0][0], mat2x3(-6.0, 2.0, 1.0, -3.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][1], mat2x3(-2.0, 7.0, -9.0, -9.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][2], mat2x3(-6.0, 5.0, -6.0, -2.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][0], mat2x3(-4.0, -4.0, -3.0, -8.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][1], mat2x3(9.0, 5.0, -3.0, 9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][2], mat2x3(8.0, -5.0, 3.0, 2.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][0], mat2x3(-2.0, 9.0, -1.0, -5.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][1], mat2x3(-8.0, 1.0, -5.0, 5.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][2], mat2x3(-3.0, 2.0, 9.0, -2.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][0], mat2x3(-6.0, -3.0, 7.0, 7.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][1], mat2x3(1.0, 8.0, 3.0, -9.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][2], mat2x3(-3.0, 9.0, 5.0, -6.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][0], mat2x3(-2.0, 9.0, -4.0, 7.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][1], mat2x3(7.0, 6.0, 8.0, -9.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][2], mat2x3(2.0, 3.0, -1.0, -5.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][0], mat2x3(-4.0, -3.0, 4.0, -9.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][1], mat2x3(2.0, -1.0, -4.0, 0.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][2], mat2x3(-2.0, 5.0, -6.0, -5.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][0], mat2x3(4.0, 9.0, 6.0, 0.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][1], mat2x3(3.0, -6.0, 0.0, -9.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][2], mat2x3(4.0, 1.0, -6.0, 5.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][0], mat2x3(-1.0, -9.0, 2.0, -6.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][1], mat2x3(-6.0, 8.0, 9.0, 3.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][2], mat2x3(-1.0, 9.0, 0.0, 5.0, 8.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-7.0);
	block.var[0][0][0][0] = (vec3(-6.0, -3.0, -4.0));
	block.var[0][0][0][1] = (vec3(-8.0, 7.0, 3.0));
	block.var[0][0][1][0] = (vec3(-2.0, 5.0, 6.0));
	block.var[0][0][1][1] = (vec3(-8.0, -9.0, 6.0));
	block.var[0][0][2][0] = (vec3(1.0, 1.0, -3.0));
	block.var[0][0][2][1] = (vec3(-5.0, -7.0, 9.0));
	block.var[0][1][0][0] = (vec3(1.0, -9.0, 1.0));
	block.var[0][1][0][1] = (vec3(5.0, -4.0, 3.0));
	block.var[0][1][1][0] = (vec3(5.0, -6.0, -6.0));
	block.var[0][1][1][1] = (vec3(0.0, -6.0, 7.0));
	block.var[0][1][2][0] = (vec3(7.0, -8.0, -1.0));
	block.var[0][1][2][1] = (vec3(1.0, -9.0, 5.0));
	block.var[1][0][0][0] = (vec3(5.0, -4.0, 6.0));
	block.var[1][0][0][1] = (vec3(-7.0, 2.0, -3.0));
	block.var[1][0][1][0] = (vec3(8.0, 2.0, 4.0));
	block.var[1][0][1][1] = (vec3(-8.0, 6.0, 0.0));
	block.var[1][0][2][0] = (vec3(-2.0, 1.0, -3.0));
	block.var[1][0][2][1] = (vec3(8.0, 0.0, -6.0));
	block.var[1][1][0][0] = (vec3(-6.0, 4.0, -4.0));
	block.var[1][1][0][1] = (vec3(-3.0, 9.0, 2.0));
	block.var[1][1][1][0] = (vec3(1.0, -8.0, 0.0));
	block.var[1][1][1][1] = (vec3(5.0, 0.0, 7.0));
	block.var[1][1][2][0] = (vec3(-6.0, -5.0, 3.0));
	block.var[1][1][2][1] = (vec3(-2.0, -7.0, 1.0));
	block.var[2][0][0][0] = (vec3(3.0, -2.0, -9.0));
	block.var[2][0][0][1] = (vec3(3.0, 9.0, -7.0));
	block.var[2][0][1][0] = (vec3(-7.0, 2.0, -3.0));
	block.var[2][0][1][1] = (vec3(-8.0, -6.0, 1.0));
	block.var[2][0][2][0] = (vec3(7.0, -2.0, -6.0));
	block.var[2][0][2][1] = (vec3(-1.0, 8.0, -1.0));
	block.var[2][1][0][0] = (vec3(0.0, 1.0, -8.0));
	block.var[2][1][0][1] = (vec3(-4.0, 2.0, -3.0));
	block.var[2][1][1][0] = (vec3(-3.0, 6.0, 6.0));
	block.var[2][1][1][1] = (vec3(-9.0, 6.0, -6.0));
	block.var[2][1][2][0] = (vec3(7.0, 9.0, -9.0));
	block.var[2][1][2][1] = (vec3(1.0, 4.0, -1.0));
	block.var[3][0][0][0] = (vec3(-1.0, 1.0, -1.0));
	block.var[3][0][0][1] = (vec3(-1.0, -5.0, 5.0));
	block.var[3][0][1][0] = (vec3(6.0, 7.0, -2.0));
	block.var[3][0][1][1] = (vec3(5.0, -6.0, -5.0));
	block.var[3][0][2][0] = (vec3(4.0, -3.0, -7.0));
	block.var[3][0][2][1] = (vec3(-7.0, -1.0, 5.0));
	block.var[3][1][0][0] = (vec3(7.0, 1.0, -4.0));
	block.var[3][1][0][1] = (vec3(-8.0, 8.0, -3.0));
	block.var[3][1][1][0] = (vec3(4.0, 1.0, 9.0));
	block.var[3][1][1][1] = (vec3(5.0, -5.0, 3.0));
	block.var[3][1][2][0] = (vec3(-7.0, -7.0, -1.0));
	block.var[3][1][2][1] = (vec3(-8.0, 6.0, -6.0));
}
#version 450
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

layout(std430, column_major, buffer_reference) buffer Block
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
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(-1.0, 4.0, -9.0, -1.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(-8.0, 6.0, 3.0, 1.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(8.0, -8.0, -7.0, 7.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(3.0, 9.0, -2.0, 2.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][0], mat3x2(-7.0, 3.0, -2.0, 8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][1], mat3x2(0.0, 9.0, -3.0, 8.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][0], mat3x2(-9.0, 9.0, 5.0, -2.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][1], mat3x2(-3.0, 6.0, 4.0, 5.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(-8.0, -3.0, 3.0, -3.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(1.0, 1.0, -3.0, -8.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(-3.0, 9.0, 6.0, 2.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(7.0, 1.0, 1.0, 8.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][0], mat3x2(8.0, -3.0, 6.0, 0.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][1], mat3x2(6.0, -8.0, 1.0, -6.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][0], mat3x2(2.0, -9.0, -7.0, 3.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][1], mat3x2(-3.0, 9.0, 2.0, -2.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(2.0, 8.0, 7.0, 7.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(-4.0, -7.0, 1.0, -1.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(2.0, 7.0, -2.0, -4.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(-8.0, -1.0, -7.0, 9.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][0], mat3x2(8.0, 9.0, 4.0, 6.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][1], mat3x2(1.0, -7.0, 6.0, 0.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][0], mat3x2(-3.0, 1.0, 6.0, 9.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][1], mat3x2(2.0, -2.0, -9.0, -3.0, -9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3x2(-2.0, -2.0, -8.0, 0.0, -9.0, 9.0));
	block.var[0][0][1] = (mat3x2(0.0, 1.0, -3.0, -6.0, -5.0, -7.0));
	block.var[0][1][0] = (mat3x2(-5.0, -4.0, -8.0, 9.0, -9.0, -8.0));
	block.var[0][1][1] = (mat3x2(8.0, -4.0, 1.0, -1.0, 7.0, 0.0));
	block.var[0][2][0] = (mat3x2(-7.0, -7.0, -1.0, 1.0, -5.0, 2.0));
	block.var[0][2][1] = (mat3x2(5.0, 5.0, 3.0, -9.0, 7.0, -4.0));
	block.var[0][3][0] = (mat3x2(-2.0, -4.0, 7.0, -2.0, 0.0, 0.0));
	block.var[0][3][1] = (mat3x2(-4.0, 1.0, -6.0, -5.0, -1.0, 0.0));
	block.var[1][0][0] = (mat3x2(5.0, -4.0, 8.0, -1.0, -8.0, 1.0));
	block.var[1][0][1] = (mat3x2(2.0, 1.0, -5.0, 0.0, -3.0, 1.0));
	block.var[1][1][0] = (mat3x2(1.0, -3.0, 6.0, -4.0, -6.0, -5.0));
	block.var[1][1][1] = (mat3x2(-6.0, -4.0, 6.0, 4.0, 2.0, -8.0));
	block.var[1][2][0] = (mat3x2(-1.0, -7.0, -6.0, -4.0, -4.0, 8.0));
	block.var[1][2][1] = (mat3x2(3.0, -5.0, 8.0, 6.0, 0.0, -2.0));
	block.var[1][3][0] = (mat3x2(-7.0, -3.0, -5.0, -9.0, 7.0, -3.0));
	block.var[1][3][1] = (mat3x2(4.0, 1.0, 0.0, 2.0, -6.0, -1.0));
	block.var[2][0][0] = (mat3x2(-4.0, 4.0, 5.0, -5.0, -6.0, 3.0));
	block.var[2][0][1] = (mat3x2(1.0, -2.0, 3.0, -8.0, -6.0, 2.0));
	block.var[2][1][0] = (mat3x2(2.0, 1.0, -3.0, -3.0, -5.0, -1.0));
	block.var[2][1][1] = (mat3x2(6.0, 9.0, 9.0, 9.0, -4.0, 8.0));
	block.var[2][2][0] = (mat3x2(9.0, -9.0, -7.0, -9.0, -9.0, 4.0));
	block.var[2][2][1] = (mat3x2(5.0, 9.0, 6.0, -1.0, 0.0, -2.0));
	block.var[2][3][0] = (mat3x2(-4.0, 4.0, 0.0, -1.0, -4.0, -4.0));
	block.var[2][3][1] = (mat3x2(-2.0, 9.0, 8.0, 9.0, -3.0, -7.0));
}
#version 450
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

layout(scalar, buffer_reference) buffer Block
{
	i16vec4 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(block.var[0][0][0]), ivec4(-6, -9, 9, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[0][0][1]), ivec4(-1, -8, 8, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[0][1][0]), ivec4(-2, 9, 9, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[0][1][1]), ivec4(-3, -8, -7, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[0][2][0]), ivec4(3, -5, 9, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[0][2][1]), ivec4(6, 3, 6, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[0][3][0]), ivec4(4, -6, 5, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[0][3][1]), ivec4(5, -2, 3, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][0][0]), ivec4(3, 4, 0, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][0][1]), ivec4(-2, -4, -9, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][1][0]), ivec4(7, -2, -8, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][1][1]), ivec4(1, 6, 9, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][2][0]), ivec4(9, -8, -9, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][2][1]), ivec4(-9, -3, -3, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][3][0]), ivec4(0, 5, -8, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][3][1]), ivec4(-6, 7, 7, 2)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][0][0]), ivec4(4, -1, 4, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][0][1]), ivec4(6, 7, -4, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][1][0]), ivec4(1, -3, 9, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][1][1]), ivec4(4, 8, -6, -2)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][2][0]), ivec4(-7, -4, 3, 0)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][2][1]), ivec4(-4, 5, -2, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][3][0]), ivec4(-5, 7, 3, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][3][1]), ivec4(-4, 7, 8, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = i16vec4(ivec4(-4, -8, -4, 9));
	block.var[0][0][1] = i16vec4(ivec4(2, 7, -4, 4));
	block.var[0][1][0] = i16vec4(ivec4(-9, -1, -8, -1));
	block.var[0][1][1] = i16vec4(ivec4(-1, -6, 5, 2));
	block.var[0][2][0] = i16vec4(ivec4(7, -1, 8, -5));
	block.var[0][2][1] = i16vec4(ivec4(-9, -6, -2, -2));
	block.var[0][3][0] = i16vec4(ivec4(7, 6, 4, -1));
	block.var[0][3][1] = i16vec4(ivec4(8, 3, 4, 5));
	block.var[1][0][0] = i16vec4(ivec4(8, 9, 5, 1));
	block.var[1][0][1] = i16vec4(ivec4(-3, 3, 8, 7));
	block.var[1][1][0] = i16vec4(ivec4(-3, 8, -7, -2));
	block.var[1][1][1] = i16vec4(ivec4(9, 7, 6, -9));
	block.var[1][2][0] = i16vec4(ivec4(-3, 8, 7, -4));
	block.var[1][2][1] = i16vec4(ivec4(-2, 0, 6, -2));
	block.var[1][3][0] = i16vec4(ivec4(-3, 5, -8, -5));
	block.var[1][3][1] = i16vec4(ivec4(9, 3, -3, 9));
	block.var[2][0][0] = i16vec4(ivec4(2, 6, -9, 9));
	block.var[2][0][1] = i16vec4(ivec4(-2, 4, -8, -7));
	block.var[2][1][0] = i16vec4(ivec4(5, -3, 8, 5));
	block.var[2][1][1] = i16vec4(ivec4(-6, -9, -6, 2));
	block.var[2][2][0] = i16vec4(ivec4(6, -5, -6, -3));
	block.var[2][2][1] = i16vec4(ivec4(4, -4, -4, 9));
	block.var[2][3][0] = i16vec4(ivec4(1, -5, 8, -2));
	block.var[2][3][1] = i16vec4(ivec4(7, -6, -6, 0));
}
#version 450
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
	allOk = compare_ivec3((block[0].s.a), ivec3(-2, 8, 0)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(-9.0, -5.0, 4.0, -2.0, -7.0, 9.0, -8.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(-2.0, -6.0, 3.0, -7.0, -5.0, 8.0, -7.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(5.0, 0.0, 0.0, -6.0, 7.0, 3.0, 1.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(-4.0, -8.0, 7.0, 8.0, 3.0, 9.0, 8.0, 6.0, -9.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(7.0, 8.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3(block[0].t.a, mat3(2.0, 8.0, -1.0, 6.0, 0.0, 4.0, 9.0, 0.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[0].t.b.a), ivec3(5, -1, 8)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[0], mat3(4.0, -3.0, -6.0, 6.0, 0.0, 9.0, -7.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[1], mat3(-4.0, 6.0, -5.0, 6.0, 9.0, -3.0, 8.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[2], mat3(-6.0, -4.0, -2.0, 6.0, -7.0, -5.0, 6.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[3], mat3(-7.0, 9.0, 2.0, 5.0, 9.0, -1.0, -4.0, 3.0, 9.0)) && allOk;
	allOk = compare_vec4((block[0].t.b.c), vec4(3.0, -6.0, 0.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(2, 5, -5)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(-5.0, 5.0, 2.0, -2.0, 9.0, 7.0, -2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(2.0, 1.0, -6.0, 7.0, 0.0, -8.0, 7.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(7.0, -1.0, 1.0, -4.0, -2.0, 3.0, 6.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(-3.0, -3.0, 9.0, 8.0, 0.0, 4.0, 1.0, 4.0, -1.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(1.0, 1.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat3(block[1].t.a, mat3(5.0, -4.0, 1.0, 6.0, 3.0, 9.0, -4.0, 6.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[1].t.b.a), ivec3(4, -2, 7)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[0], mat3(-6.0, 1.0, -4.0, -1.0, 6.0, 0.0, -5.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[1], mat3(-6.0, 1.0, 7.0, -6.0, 1.0, -5.0, -8.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[2], mat3(1.0, 0.0, 9.0, -8.0, 9.0, 2.0, -2.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[3], mat3(-3.0, 5.0, -5.0, -4.0, 2.0, 2.0, -6.0, 4.0, 3.0)) && allOk;
	allOk = compare_vec4((block[1].t.b.c), vec4(1.0, -6.0, 2.0, 3.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(0, 8, 8)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(-8.0, -7.0, 7.0, -1.0, -7.0, -9.0, -2.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(-1.0, -6.0, -6.0, 8.0, 2.0, 9.0, 5.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(4.0, -5.0, 2.0, -4.0, -9.0, 5.0, -7.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(1.0, 2.0, -3.0, -3.0, -1.0, 7.0, 1.0, 0.0, 7.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(8.0, -7.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3(block[2].t.a, mat3(-1.0, 0.0, -3.0, 8.0, 2.0, -6.0, -8.0, -1.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[2].t.b.a), ivec3(2, 3, -3)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[0], mat3(-5.0, 3.0, 8.0, 5.0, -2.0, 5.0, 0.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[1], mat3(4.0, 2.0, -1.0, 1.0, -5.0, -6.0, -8.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[2], mat3(-2.0, -1.0, -4.0, 8.0, -4.0, 8.0, 0.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[3], mat3(0.0, -2.0, -9.0, 9.0, -6.0, 2.0, 6.0, -5.0, 8.0)) && allOk;
	allOk = compare_vec4((block[2].t.b.c), vec4(9.0, -4.0, -5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].t.a = (mat3(6.0, 3.0, 4.0, 6.0, 7.0, 8.0, 5.0, 1.0, 2.0));
	block[0].t.b.a = (ivec3(4, -6, -7));
	block[0].t.b.b[0] = (mat3(-6.0, -2.0, 9.0, 0.0, -6.0, -7.0, 7.0, -5.0, 5.0));
	block[0].t.b.b[1] = (mat3(9.0, 7.0, -2.0, -9.0, -2.0, 6.0, 8.0, 1.0, -5.0));
	block[0].t.b.b[2] = (mat3(-4.0, 0.0, 2.0, -1.0, 1.0, 5.0, 2.0, 4.0, 5.0));
	block[0].t.b.b[3] = (mat3(8.0, 6.0, 7.0, 9.0, -1.0, 5.0, 5.0, -6.0, -7.0));
	block[0].t.b.c = (vec4(-4.0, 2.0, -1.0, 5.0));
	block[0].u = (1u);
	block[1].t.a = (mat3(-6.0, 1.0, 6.0, -6.0, 3.0, -3.0, -9.0, 3.0, 6.0));
	block[1].t.b.a = (ivec3(9, 6, 4));
	block[1].t.b.b[0] = (mat3(-9.0, 7.0, -2.0, 1.0, 2.0, -6.0, 2.0, 3.0, -3.0));
	block[1].t.b.b[1] = (mat3(8.0, 1.0, 0.0, -1.0, 8.0, -9.0, -5.0, 9.0, 6.0));
	block[1].t.b.b[2] = (mat3(-1.0, -5.0, -8.0, 3.0, -3.0, -3.0, -7.0, 0.0, -4.0));
	block[1].t.b.b[3] = (mat3(-4.0, -9.0, -8.0, 9.0, -2.0, 4.0, 0.0, 1.0, 8.0));
	block[1].t.b.c = (vec4(5.0, -6.0, -6.0, 2.0));
	block[1].u = (3u);
	block[2].t.a = (mat3(-1.0, -1.0, -4.0, -6.0, -8.0, 3.0, 4.0, 1.0, 0.0));
	block[2].t.b.a = (ivec3(8, -4, 2));
	block[2].t.b.b[0] = (mat3(-9.0, -4.0, -6.0, 2.0, 3.0, -4.0, 6.0, 4.0, -4.0));
	block[2].t.b.b[1] = (mat3(-9.0, -2.0, 3.0, 6.0, -5.0, 7.0, 8.0, -6.0, 1.0));
	block[2].t.b.b[2] = (mat3(-4.0, -9.0, 7.0, 4.0, -4.0, 0.0, 6.0, -5.0, -2.0));
	block[2].t.b.b[3] = (mat3(-1.0, 0.0, 2.0, -9.0, 8.0, -9.0, -2.0, -2.0, -8.0));
	block[2].t.b.c = (vec4(-7.0, 7.0, -8.0, -5.0));
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
	allOk = compare_ivec3((block.s[0][0].a), ivec3(-8, -2, -7)) && allOk;
	allOk = compare_vec4((block.s[0][0].c), vec4(8.0, -3.0, 3.0, 8.0)) && allOk;
	allOk = compare_ivec3((block.s[0][1].a), ivec3(-8, -6, 2)) && allOk;
	allOk = compare_vec4((block.s[0][1].c), vec4(1.0, 9.0, 2.0, -5.0)) && allOk;
	allOk = compare_ivec3((block.s[1][0].a), ivec3(-1, 8, -5)) && allOk;
	allOk = compare_vec4((block.s[1][0].c), vec4(4.0, -6.0, -1.0, -7.0)) && allOk;
	allOk = compare_ivec3((block.s[1][1].a), ivec3(6, 3, -1)) && allOk;
	allOk = compare_vec4((block.s[1][1].c), vec4(5.0, -6.0, 0.0, -4.0)) && allOk;
	allOk = compare_ivec3((block.s[2][0].a), ivec3(-1, -8, -2)) && allOk;
	allOk = compare_vec4((block.s[2][0].c), vec4(-4.0, 7.0, 5.0, 5.0)) && allOk;
	allOk = compare_ivec3((block.s[2][1].a), ivec3(-9, 7, 1)) && allOk;
	allOk = compare_vec4((block.s[2][1].c), vec4(-7.0, 0.0, 2.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.v = (vec4(1.0, 5.0, -4.0, 6.0));
	block.s[0][0].a = (ivec3(-4, -7, -1));
	block.s[0][0].c = (vec4(-4.0, -3.0, -9.0, 3.0));
	block.s[0][1].a = (ivec3(-7, -9, 4));
	block.s[0][1].c = (vec4(0.0, 0.0, -4.0, 2.0));
	block.s[1][0].a = (ivec3(-7, 1, -9));
	block.s[1][0].c = (vec4(5.0, -9.0, 5.0, 2.0));
	block.s[1][1].a = (ivec3(4, -6, 1));
	block.s[1][1].c = (vec4(-8.0, -5.0, 2.0, 4.0));
	block.s[2][0].a = (ivec3(-4, -7, -5));
	block.s[2][0].c = (vec4(5.0, -2.0, -1.0, 3.0));
	block.s[2][1].a = (ivec3(-9, -5, -7));
	block.s[2][1].c = (vec4(-8.0, -4.0, -8.0, 7.0));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
{
	highp mat2 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

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
	allOk = compare_float((block[0].padding), 1.0) && allOk;
	allOk = compare_float(block[0].var[0][0], 6.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 7.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 5.0) && allOk;
	allOk = compare_float(block[0].var[0][3], 2.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -4.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 0.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 8.0) && allOk;
	allOk = compare_float(block[0].var[1][3], 3.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 3.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 9.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 8.0) && allOk;
	allOk = compare_float(block[0].var[2][3], -2.0) && allOk;
	allOk = compare_float(block[0].var[3][0], 7.0) && allOk;
	allOk = compare_float(block[0].var[3][1], 0.0) && allOk;
	allOk = compare_float(block[0].var[3][2], 3.0) && allOk;
	allOk = compare_float(block[0].var[3][3], -1.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(6.0, 7.0, 5.0, 2.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(-4.0, 0.0, 8.0, 3.0)) && allOk;
	allOk = compare_vec4(block[0].var[2], vec4(3.0, 9.0, 8.0, -2.0)) && allOk;
	allOk = compare_vec4(block[0].var[3], vec4(7.0, 0.0, 3.0, -1.0)) && allOk;
	allOk = compare_float((block[1].padding), 1.0) && allOk;
	allOk = compare_float(block[1].var[0][0], 9.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 1.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -2.0) && allOk;
	allOk = compare_float(block[1].var[0][3], -7.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 3.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 5.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 2.0) && allOk;
	allOk = compare_float(block[1].var[1][3], -8.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 8.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -1.0) && allOk;
	allOk = compare_float(block[1].var[2][2], -4.0) && allOk;
	allOk = compare_float(block[1].var[2][3], -5.0) && allOk;
	allOk = compare_float(block[1].var[3][0], 8.0) && allOk;
	allOk = compare_float(block[1].var[3][1], 4.0) && allOk;
	allOk = compare_float(block[1].var[3][2], -9.0) && allOk;
	allOk = compare_float(block[1].var[3][3], 1.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(9.0, 1.0, -2.0, -7.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(3.0, 5.0, 2.0, -8.0)) && allOk;
	allOk = compare_vec4(block[1].var[2], vec4(8.0, -1.0, -4.0, -5.0)) && allOk;
	allOk = compare_vec4(block[1].var[3], vec4(8.0, 4.0, -9.0, 1.0)) && allOk;
	allOk = compare_float((block[2].padding), 1.0) && allOk;
	allOk = compare_float(block[2].var[0][0], -6.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 5.0) && allOk;
	allOk = compare_float(block[2].var[0][2], -8.0) && allOk;
	allOk = compare_float(block[2].var[0][3], -6.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -3.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -4.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 8.0) && allOk;
	allOk = compare_float(block[2].var[1][3], 9.0) && allOk;
	allOk = compare_float(block[2].var[2][0], -9.0) && allOk;
	allOk = compare_float(block[2].var[2][1], -4.0) && allOk;
	allOk = compare_float(block[2].var[2][2], -2.0) && allOk;
	allOk = compare_float(block[2].var[2][3], -8.0) && allOk;
	allOk = compare_float(block[2].var[3][0], 8.0) && allOk;
	allOk = compare_float(block[2].var[3][1], -7.0) && allOk;
	allOk = compare_float(block[2].var[3][2], -7.0) && allOk;
	allOk = compare_float(block[2].var[3][3], 7.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(-6.0, 5.0, -8.0, -6.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(-3.0, -4.0, 8.0, 9.0)) && allOk;
	allOk = compare_vec4(block[2].var[2], vec4(-9.0, -4.0, -2.0, -8.0)) && allOk;
	allOk = compare_vec4(block[2].var[3], vec4(8.0, -7.0, -7.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-3.0);
	block[0].var[0] = (vec4(-6.0, 8.0, 7.0, -8.0));
	block[0].var[1] = (vec4(6.0, 1.0, -6.0, 6.0));
	block[0].var[2] = (vec4(0.0, -6.0, 3.0, 3.0));
	block[0].var[3] = (vec4(3.0, -3.0, 2.0, -8.0));
	block[1].padding = (9.0);
	block[1].var[0] = (vec4(-6.0, 6.0, 1.0, 9.0));
	block[1].var[1] = (vec4(-7.0, 4.0, -5.0, 5.0));
	block[1].var[2] = (vec4(-6.0, 5.0, 7.0, 7.0));
	block[1].var[3] = (vec4(-5.0, -9.0, 7.0, -2.0));
	block[2].padding = (-1.0);
	block[2].var[0] = (vec4(-4.0, -3.0, 3.0, -8.0));
	block[2].var[1] = (vec4(7.0, -8.0, -5.0, -9.0));
	block[2].var[2] = (vec4(-1.0, 0.0, -7.0, 7.0));
	block[2].var[3] = (vec4(8.0, -6.0, -6.0, -1.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), -5.0) && allOk;
	allOk = compare_mat2x4(block[0].var, mat2x4(8.0, 6.0, -5.0, -7.0, -1.0, 8.0, -8.0, 5.0)) && allOk;
	allOk = compare_float((block[1].padding), -3.0) && allOk;
	allOk = compare_mat2x4(block[1].var, mat2x4(-3.0, 3.0, 9.0, 3.0, 2.0, 4.0, 9.0, -8.0)) && allOk;
	allOk = compare_float((block[2].padding), 9.0) && allOk;
	allOk = compare_mat2x4(block[2].var, mat2x4(-7.0, 5.0, -2.0, 7.0, -9.0, 6.0, -7.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (1.0);
	block[0].var = (mat2x4(9.0, -7.0, -1.0, 7.0, -5.0, 3.0, -4.0, -1.0));
	block[1].padding = (-4.0);
	block[1].var = (mat2x4(-6.0, -7.0, 3.0, 5.0, 1.0, -1.0, 9.0, -9.0));
	block[2].padding = (-3.0);
	block[2].var = (mat2x4(-7.0, 3.0, 9.0, -5.0, -9.0, -7.0, -4.0, -2.0));
}
#version 450
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
	bool a;
	mediump float b;
	mediump float c;
	mediump uint d;
	lowp int e;
};
layout(std430, buffer_reference) buffer BlockC
{
	mediump uint f;
	highp uint g;
	highp int h;
};
layout(std430, buffer_reference) buffer BlockD
{
	bool i;
	highp int j[1];
	mediump int k;
	lowp float l;
};
layout(std430, buffer_reference) readonly buffer BlockE
{
	bool m;
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

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.b), -6.0) && allOk;
	allOk = compare_uint((blockB.d), 9u) && allOk;
	allOk = compare_int((blockB.e), -2) && allOk;
	allOk = compare_uint((blockC.f), 7u) && allOk;
	allOk = compare_float((blockD.l), -6.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
	blockB.b = (5.0);
	blockB.c = (1.0);
	blockB.e = (-3);
	blockC.f = (9u);
	blockC.h = (-9);
	blockD.l = (5.0);
}
#version 450
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
	mediump vec4 a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.a), vec4(-8.0, -2.0, 9.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp uint a;
	mediump ivec4 b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 7u) && allOk;
	allOk = compare_ivec4((blockB.b[0]), ivec4(-3, 2, -4, 4)) && allOk;
	allOk = compare_ivec4((blockB.b[1]), ivec4(6, -2, -5, -3)) && allOk;
	allOk = compare_ivec4((blockB.b[2]), ivec4(-3, 1, -3, 8)) && allOk;
	allOk = compare_ivec4((blockB.b[3]), ivec4(7, 3, 3, -4)) && allOk;
	allOk = compare_ivec4((blockB.b[4]), ivec4(8, -7, -9, -3)) && allOk;
	allOk = compare_ivec4((blockB.b[5]), ivec4(4, -3, -7, -7)) && allOk;
	allOk = compare_ivec4((blockB.b[6]), ivec4(-1, 9, -6, 8)) && allOk;
	allOk = compare_ivec4((blockB.b[7]), ivec4(-4, 4, 1, -6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (7u);
	blockB.b[0] = (ivec4(7, -2, 6, 0));
	blockB.b[1] = (ivec4(5, 9, -5, 4));
	blockB.b[2] = (ivec4(7, -1, 6, 5));
	blockB.b[3] = (ivec4(8, 6, 2, -7));
	blockB.b[4] = (ivec4(-2, -4, -2, 4));
	blockB.b[5] = (ivec4(-2, 3, 0, -8));
	blockB.b[6] = (ivec4(6, -7, 4, 6));
	blockB.b[7] = (ivec4(-2, -5, 3, 0));
}
#version 450
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
	lowp vec4 e[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	bvec3 f;
	bool g;
	lowp vec4 h;
	bvec2 i[5];
	highp uvec2 j[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(0.0, -6.0)) && allOk;
	allOk = compare_mat4(blockB.b, mat4(9.0, -5.0, 0.0, 3.0, 7.0, -1.0, -8.0, 2.0, 8.0, -2.0, -2.0, 4.0, -7.0, -2.0, -1.0, 1.0)) && allOk;
	allOk = compare_vec4((blockB.e[0]), vec4(1.0, -6.0, -7.0, 2.0)) && allOk;
	allOk = compare_vec4((blockB.e[1]), vec4(8.0, -2.0, 8.0, 0.0)) && allOk;
	allOk = compare_vec4((blockB.e[2]), vec4(2.0, 2.0, -2.0, 3.0)) && allOk;
	allOk = compare_vec4((blockB.e[3]), vec4(-6.0, 7.0, -7.0, 9.0)) && allOk;
	allOk = compare_bvec3((blockC.f), bvec3(false, true, false)) && allOk;
	allOk = compare_bool((blockC.g), false) && allOk;
	allOk = compare_vec4((blockC.h), vec4(-8.0, 0.0, 6.0, 7.0)) && allOk;
	allOk = compare_bvec2((blockC.i[0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockC.i[1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC.i[2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC.i[3]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockC.i[4]), bvec2(false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat4(-9.0, 0.0, 9.0, 2.0, -6.0, 6.0, -6.0, 3.0, 5.0, -8.0, -7.0, -8.0, 3.0, -6.0, -9.0, 9.0));
	blockC.f = (bvec3(true, true, false));
	blockC.g = (false);
	blockC.h = (vec4(-9.0, 2.0, -4.0, 1.0));
}
#version 450
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
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	mediump vec3 a;
	highp float b;
	bool c[4];
	highp mat4 d;
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	lowp uvec4 e;
	highp float f;
	sA g;
	highp uvec3 h;
	mediump ivec3 i[];
};
layout(std140, buffer_reference) buffer BlockD
{
	lowp int j;
	highp mat2 k;
	lowp float l;
	bvec3 m;
	mediump mat4x3 n[];
};
layout(std140, row_major, buffer_reference) buffer BlockE
{
	lowp vec2 o;
	mediump mat2x3 p;
	highp ivec3 q;
	bvec2 r[];
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
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.a), vec3(0.0, 3.0, 3.0)) && allOk;
	allOk = compare_bool((blockB.c[0]), false) && allOk;
	allOk = compare_bool((blockB.c[1]), true) && allOk;
	allOk = compare_bool((blockB.c[2]), false) && allOk;
	allOk = compare_bool((blockB.c[3]), true) && allOk;
	allOk = compare_mat4(blockB.d, mat4(3.0, 3.0, -2.0, 7.0, 6.0, 3.0, -6.0, -3.0, 2.0, 5.0, 6.0, -9.0, 3.0, -5.0, -8.0, 9.0)) && allOk;
	allOk = compare_uvec4((blockC.e), uvec4(9u, 6u, 2u, 6u)) && allOk;
	allOk = compare_float((blockC.f), -4.0) && allOk;
	allOk = compare_int((blockD.j), 7) && allOk;
	allOk = compare_mat2(blockD.k, mat2(-4.0, -5.0, 9.0, 1.0)) && allOk;
	allOk = compare_float((blockD.l), 9.0) && allOk;
	allOk = compare_ivec3((blockE[0].q), ivec3(4, 9, -2)) && allOk;
	allOk = compare_bvec2((blockE[0].r[0]), bvec2(false, false)) && allOk;
	allOk = compare_ivec3((blockE[1].q), ivec3(3, -5, -8)) && allOk;
	allOk = compare_bvec2((blockE[1].r[0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE[1].r[1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE[1].r[2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE[1].r[3]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE[1].r[4]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE[1].r[5]), bvec2(true, false)) && allOk;
	allOk = compare_ivec3((blockE[2].q), ivec3(7, 7, -4)) && allOk;
	allOk = compare_bvec2((blockE[2].r[0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE[2].r[1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE[2].r[2]), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.d = (mat4(-8.0, -3.0, -9.0, -1.0, -4.0, -7.0, -8.0, 1.0, 8.0, -4.0, -5.0, 7.0, 6.0, -2.0, 9.0, 9.0));
	blockC.e = (uvec4(9u, 4u, 2u, 0u));
	blockC.f = (-8.0);
	blockC.g.mA = (false);
	blockC.g.mB = (false);
	blockC.h = (uvec3(0u, 8u, 1u));
	blockC.i[0] = (ivec3(1, 3, 0));
	blockD.j = (-1);
	blockD.l = (2.0);
	blockD.m = (bvec3(true, true, false));
	blockE[0].o = (vec2(0.0, 7.0));
	blockE[1].o = (vec2(3.0, 9.0));
	blockE[2].o = (vec2(-7.0, 5.0));
}
#version 450
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
	layout(offset = 8) highp uvec2 b;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump uint c;
	layout(offset = 4) mediump ivec2 d;
	layout(offset = 12) highp float e;
	layout(offset = 16) mediump vec2 f;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) bvec4 g;
	layout(offset = 16) mediump int h;
	layout(offset = 20) bool i;
	layout(offset = 24) highp uvec2 j;
	layout(offset = 32) bvec3 k[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a), bvec2(true, false)) && allOk;
	allOk = compare_uvec2((blockB.b), uvec2(9u, 9u)) && allOk;
	allOk = compare_uint((blockC.c), 6u) && allOk;
	allOk = compare_ivec2((blockC.d), ivec2(-2, -6)) && allOk;
	allOk = compare_vec2((blockC.f), vec2(9.0, 7.0)) && allOk;
	allOk = compare_bvec4((blockD.g), bvec4(false, false, true, false)) && allOk;
	allOk = compare_int((blockD.h), -8) && allOk;
	allOk = compare_bool((blockD.i), true) && allOk;
	allOk = compare_uvec2((blockD.j), uvec2(8u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, false));
	blockC.c = (8u);
	blockC.e = (-7.0);
	blockC.f = (vec2(3.0, 6.0));
	blockD.g = (bvec4(false, true, false, true));
	blockD.j = (uvec2(0u, 7u));
	blockD.k[0] = (bvec3(true, false, false));
}
#version 450
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
	layout(offset = 16) mediump uint b;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump uvec3 c;
	layout(offset = 16) highp vec4 d;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) highp vec4 e;
	layout(offset = 16) highp vec3 f;
	layout(offset = 32) highp uvec2 g[1];
	layout(offset = 40) lowp uvec2 h;
	layout(offset = 48) bool i;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) bool j;
	layout(offset = 4) lowp uvec2 k;
	layout(offset = 16) mediump vec3 l;
	layout(offset = 28) bool m;
	layout(offset = 32) highp uint n;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC[2];
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockC[0].c), uvec3(2u, 8u, 8u)) && allOk;
	allOk = compare_vec4((blockC[0].d), vec4(-1.0, -4.0, -8.0, 7.0)) && allOk;
	allOk = compare_uvec3((blockC[1].c), uvec3(2u, 8u, 3u)) && allOk;
	allOk = compare_vec4((blockC[1].d), vec4(6.0, 9.0, 4.0, 5.0)) && allOk;
	allOk = compare_vec4((blockD.e), vec4(-9.0, 0.0, 1.0, 9.0)) && allOk;
	allOk = compare_bool((blockD.i), false) && allOk;
	allOk = compare_bool((blockE.j), true) && allOk;
	allOk = compare_uvec2((blockE.k), uvec2(6u, 3u)) && allOk;
	allOk = compare_vec3((blockE.l), vec3(0.0, -2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (bvec4(true, true, true, true));
	blockB[0].b = (9u);
	blockC[0].c = (uvec3(7u, 8u, 8u));
	blockC[1].c = (uvec3(1u, 6u, 1u));
	blockD.f = (vec3(3.0, -8.0, -8.0));
	blockD.g[0] = (uvec2(6u, 4u));
	blockD.h = (uvec2(0u, 1u));
	blockD.i = (true);
	blockE.j = (false);
	blockE.k = (uvec2(8u, 3u));
	blockE.m = (true);
	blockE.n = (3u);
}
#version 450
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
	mediump vec3 b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB[nonuniformEXT(0)].a), ivec2(-2, 4)) && allOk;
	allOk = compare_vec3((blockB[nonuniformEXT(0)].b), vec3(3.0, -8.0, 3.0)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(1)].a), ivec2(-5, -4)) && allOk;
	allOk = compare_vec3((blockB[nonuniformEXT(1)].b), vec3(-5.0, -3.0, -2.0)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(2)].a), ivec2(-3, 6)) && allOk;
	allOk = compare_vec3((blockB[nonuniformEXT(2)].b), vec3(-6.0, 9.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (ivec2(-7, 3));
	blockB[nonuniformEXT(0)].b = (vec3(-9.0, -7.0, -4.0));
	blockB[nonuniformEXT(1)].a = (ivec2(-1, 9));
	blockB[nonuniformEXT(1)].b = (vec3(-4.0, -4.0, 3.0));
	blockB[nonuniformEXT(2)].a = (ivec2(-7, -4));
	blockB[nonuniformEXT(2)].b = (vec3(0.0, -7.0, -9.0));
}
#version 450
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
	highp vec2 a;
	bvec4 b;
	lowp mat4x3 c;
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	lowp vec4 d;
	uint16_t e;
	i16vec3 f;
	lowp int g;
};
layout(std140, buffer_reference) buffer BlockD
{
	uint16_t h;
	mediump uint i;
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.b), bvec4(true, true, true, true)) && allOk;
	allOk = compare_vec4((blockC.d), vec4(-1.0, -5.0, 5.0, 3.0)) && allOk;
	allOk = compare_uint16_t(uint(blockC.e), 5u) && allOk;
	allOk = compare_uint16_t(uint(blockD.h), 4u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec2(3.0, -4.0));
	blockB.b = (bvec4(false, true, false, false));
	blockB.c = (mat4x3(-4.0, -9.0, -2.0, 0.0, 9.0, 8.0, -5.0, 4.0, -6.0, -8.0, -5.0, 0.0));
	blockC.f = i16vec3(ivec3(0, 6, -5));
	blockC.g = (5);
	blockD.i = (5u);
}
#version 450
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
	uint16_t a;
	bool b;
	highp vec2 c[1];
	mediump mat4x3 d;
	lowp vec2 e;
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	i16vec2 f;
	lowp mat4x3 g;
	lowp uint h[1];
	highp mat4x3 i;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.c[0]), vec2(-5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(blockB.d, mat4x3(3.0, 7.0, -1.0, -8.0, 2.0, 8.0, -2.0, -2.0, 4.0, -7.0, -2.0, -1.0)) && allOk;
	allOk = compare_vec2((blockB.e), vec2(1.0, -1.0)) && allOk;
	allOk = compare_mat4x3(blockC.g, mat4x3(-7.0, -7.0, 8.0, 4.0, 2.0, 0.0, 1.0, 8.0, 2.0, -6.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat4x3(blockC.i, mat4x3(3.0, 9.0, 3.0, -6.0, -2.0, -8.0, 7.0, 7.0, -8.0, -7.0, 6.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = uint16_t(5u);
	blockB.b = (true);
	blockB.e = (vec2(9.0, -9.0));
	blockC.h[0] = (4u);
	blockC.i = (mat4x3(-3.0, 2.0, -3.0, 2.0, -8.0, 0.0, 0.0, -5.0, 8.0, 0.0, -3.0, -9.0));
}
#version 450
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
};
layout(std140, buffer_reference) buffer BlockB
{
	f16vec3 a;
	u16vec2 b;
	i16vec4 c;
	highp float d;
	bool e[];
};
layout(std430, row_major, buffer_reference) readonly buffer BlockC
{
	i16vec4 f[];
};
layout(std140, row_major, buffer_reference) readonly buffer BlockD
{
	mediump ivec2 g;
};
layout(std140, column_major, buffer_reference) buffer BlockE
{
	sA h;
	lowp mat3x4 i;
	i16vec3 j;
	u16vec4 k;
	mediump mat2x3 l;
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
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(blockB.c), ivec4(3, 7, -1, -8)) && allOk;
	allOk = compare_bool((blockB.e[0]), false) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.f[0]), ivec4(-2, -2, 4, -7)) && allOk;
	allOk = compare_ivec2((blockD.g), ivec2(-2, -1)) && allOk;
	allOk = compare_mat3x4(blockE.i, mat3x4(-2.0, 3.0, -6.0, 7.0, -7.0, 9.0, -2.0, 7.0, 6.0, 3.0, -8.0, -8.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockE.k), uvec4(8u, 6u, 1u, 7u)) && allOk;
	allOk = compare_mat2x3(blockE.l, mat2x3(2.0, -3.0, 6.0, 1.0, 7.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = u16vec2(uvec2(2u, 4u));
	blockB.c = i16vec4(ivec4(2, -6, 6, -6));
	blockB.e[0] = (true);
	blockE.h.mA = (mat4(-9.0, 9.0, 8.0, -1.0, -4.0, 0.0, -4.0, 2.0, 1.0, 2.0, 9.0, -3.0, -2.0, -6.0, -2.0, 5.0));
	blockE.i = (mat3x4(-3.0, 2.0, 0.0, 0.0, 2.0, -8.0, -5.0, -3.0, -3.0, 0.0, 8.0, -9.0));
	blockE.j = i16vec3(ivec3(2, -4, 1));
	blockE.k = u16vec4(uvec4(1u, 6u, 4u, 3u));
	blockE.l = (mat2x3(-2.0, 7.0, -9.0, 3.0, 8.0, 2.0));
}
#version 450
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
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	int16_t a;
	bool b[][7];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	float16_t c[7];
	f16vec3 d;
	u16vec3 e;
	mediump mat3x4 f;
};
layout(std430, buffer_reference) buffer BlockD
{
	bvec3 g;
	highp mat3x4 h;
	sA i[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.b[0][0]), true) && allOk;
	allOk = compare_bool((blockB.b[0][1]), false) && allOk;
	allOk = compare_bool((blockB.b[0][2]), true) && allOk;
	allOk = compare_bool((blockB.b[0][3]), false) && allOk;
	allOk = compare_bool((blockB.b[0][4]), true) && allOk;
	allOk = compare_bool((blockB.b[0][5]), false) && allOk;
	allOk = compare_bool((blockB.b[0][6]), false) && allOk;
	allOk = compare_bool((blockB.b[1][0]), true) && allOk;
	allOk = compare_bool((blockB.b[1][1]), true) && allOk;
	allOk = compare_bool((blockB.b[1][2]), true) && allOk;
	allOk = compare_bool((blockB.b[1][3]), false) && allOk;
	allOk = compare_bool((blockB.b[1][4]), true) && allOk;
	allOk = compare_bool((blockB.b[1][5]), false) && allOk;
	allOk = compare_bool((blockB.b[1][6]), true) && allOk;
	allOk = compare_bool((blockB.b[2][0]), true) && allOk;
	allOk = compare_bool((blockB.b[2][1]), false) && allOk;
	allOk = compare_bool((blockB.b[2][2]), true) && allOk;
	allOk = compare_bool((blockB.b[2][3]), true) && allOk;
	allOk = compare_bool((blockB.b[2][4]), false) && allOk;
	allOk = compare_bool((blockB.b[2][5]), true) && allOk;
	allOk = compare_bool((blockB.b[2][6]), true) && allOk;
	allOk = compare_bool((blockB.b[3][0]), true) && allOk;
	allOk = compare_bool((blockB.b[3][1]), false) && allOk;
	allOk = compare_bool((blockB.b[3][2]), true) && allOk;
	allOk = compare_bool((blockB.b[3][3]), true) && allOk;
	allOk = compare_bool((blockB.b[3][4]), true) && allOk;
	allOk = compare_bool((blockB.b[3][5]), false) && allOk;
	allOk = compare_bool((blockB.b[3][6]), false) && allOk;
	allOk = compare_bool((blockB.b[4][0]), false) && allOk;
	allOk = compare_bool((blockB.b[4][1]), true) && allOk;
	allOk = compare_bool((blockB.b[4][2]), false) && allOk;
	allOk = compare_bool((blockB.b[4][3]), false) && allOk;
	allOk = compare_bool((blockB.b[4][4]), true) && allOk;
	allOk = compare_bool((blockB.b[4][5]), false) && allOk;
	allOk = compare_bool((blockB.b[4][6]), true) && allOk;
	allOk = compare_bool((blockB.b[5][0]), true) && allOk;
	allOk = compare_bool((blockB.b[5][1]), false) && allOk;
	allOk = compare_bool((blockB.b[5][2]), false) && allOk;
	allOk = compare_bool((blockB.b[5][3]), false) && allOk;
	allOk = compare_bool((blockB.b[5][4]), false) && allOk;
	allOk = compare_bool((blockB.b[5][5]), false) && allOk;
	allOk = compare_bool((blockB.b[5][6]), false) && allOk;
	allOk = compare_bool((blockB.b[6][0]), true) && allOk;
	allOk = compare_bool((blockB.b[6][1]), false) && allOk;
	allOk = compare_bool((blockB.b[6][2]), true) && allOk;
	allOk = compare_bool((blockB.b[6][3]), false) && allOk;
	allOk = compare_bool((blockB.b[6][4]), true) && allOk;
	allOk = compare_bool((blockB.b[6][5]), false) && allOk;
	allOk = compare_bool((blockB.b[6][6]), true) && allOk;
	allOk = compare_float16_t(float(blockC.c[0]), 5.0) && allOk;
	allOk = compare_float16_t(float(blockC.c[1]), 4.0) && allOk;
	allOk = compare_float16_t(float(blockC.c[2]), 7.0) && allOk;
	allOk = compare_float16_t(float(blockC.c[3]), -2.0) && allOk;
	allOk = compare_float16_t(float(blockC.c[4]), -1.0) && allOk;
	allOk = compare_float16_t(float(blockC.c[5]), -2.0) && allOk;
	allOk = compare_float16_t(float(blockC.c[6]), -6.0) && allOk;
	allOk = compare_f16vec3(vec3(blockC.d), vec3(3.0, 8.0, 6.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.e), uvec3(2u, 9u, 0u)) && allOk;
	allOk = compare_mat3x4(blockD.h, mat3x4(-1.0, -9.0, 9.0, 7.0, 2.0, -3.0, -8.0, 0.0, 5.0, 1.0, -1.0, 9.0)) && allOk;
	allOk = compare_float((blockD.i[0].mA), -4.0) && allOk;
	allOk = compare_float((blockD.i[1].mA), -8.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = int16_t(1);
	blockB.b[0][0] = (true);
	blockB.b[0][1] = (false);
	blockB.b[0][2] = (true);
	blockB.b[0][3] = (true);
	blockB.b[0][4] = (false);
	blockB.b[0][5] = (false);
	blockB.b[0][6] = (true);
	blockB.b[1][0] = (false);
	blockB.b[1][1] = (true);
	blockB.b[1][2] = (true);
	blockB.b[1][3] = (false);
	blockB.b[1][4] = (true);
	blockB.b[1][5] = (false);
	blockB.b[1][6] = (true);
	blockB.b[2][0] = (true);
	blockB.b[2][1] = (false);
	blockB.b[2][2] = (false);
	blockB.b[2][3] = (true);
	blockB.b[2][4] = (true);
	blockB.b[2][5] = (false);
	blockB.b[2][6] = (false);
	blockB.b[3][0] = (true);
	blockB.b[3][1] = (true);
	blockB.b[3][2] = (true);
	blockB.b[3][3] = (false);
	blockB.b[3][4] = (true);
	blockB.b[3][5] = (true);
	blockB.b[3][6] = (false);
	blockB.b[4][0] = (true);
	blockB.b[4][1] = (true);
	blockB.b[4][2] = (true);
	blockB.b[4][3] = (false);
	blockB.b[4][4] = (true);
	blockB.b[4][5] = (true);
	blockB.b[4][6] = (true);
	blockB.b[5][0] = (false);
	blockB.b[5][1] = (true);
	blockB.b[5][2] = (true);
	blockB.b[5][3] = (true);
	blockB.b[5][4] = (true);
	blockB.b[5][5] = (true);
	blockB.b[5][6] = (true);
	blockB.b[6][0] = (true);
	blockB.b[6][1] = (false);
	blockB.b[6][2] = (false);
	blockB.b[6][3] = (false);
	blockB.b[6][4] = (true);
	blockB.b[6][5] = (false);
	blockB.b[6][6] = (false);
	blockC.c[0] = float16_t(-7.0);
	blockC.c[1] = float16_t(-2.0);
	blockC.c[2] = float16_t(4.0);
	blockC.c[3] = float16_t(-8.0);
	blockC.c[4] = float16_t(-4.0);
	blockC.c[5] = float16_t(-5.0);
	blockC.c[6] = float16_t(9.0);
	blockC.d = f16vec3(vec3(-4.0, 5.0, 1.0));
	blockC.e = u16vec3(uvec3(2u, 5u, 2u));
	blockD.g = (bvec3(true, true, true));
	blockD.h = (mat3x4(2.0, -5.0, -9.0, -8.0, -1.0, 1.0, 8.0, -6.0, -3.0, -4.0, 3.0, -6.0));
	blockD.i[0].mA = (-9.0);
	blockD.i[1].mA = (-3.0);
}
#version 450
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
	bvec3 a;
	mediump mat4 b;
	f16vec2 c;
	highp mat4x2 d[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	i16vec2 e;
	mediump mat3 f;
	highp mat3x2 g;
	u16vec3 h[2];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.a), bvec3(true, false, false)) && allOk;
	allOk = compare_f16vec2(vec2(blockB.c), vec2(3.0, 5.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[0], mat4x2(2.0, 0.0, -9.0, 1.0, 0.0, -8.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[1], mat4x2(3.0, 1.0, -5.0, -8.0, 5.0, 2.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[2], mat4x2(1.0, -6.0, 8.0, -9.0, -3.0, -5.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[3], mat4x2(-8.0, 8.0, -8.0, 4.0, 3.0, -1.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[4], mat4x2(-6.0, -4.0, 8.0, 9.0, -6.0, 9.0, 2.0, 5.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockC.e), ivec2(-2, 4)) && allOk;
	allOk = compare_mat3x2(blockC.g, mat3x2(4.0, -7.0, -1.0, 1.0, 1.0, -7.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.h[0]), uvec3(2u, 8u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.h[1]), uvec3(6u, 6u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat4(0.0, 7.0, 9.0, 4.0, 8.0, 1.0, -6.0, 0.0, 0.0, 2.0, -3.0, 4.0, 8.0, -5.0, 9.0, 5.0));
	blockB.c = f16vec2(vec2(-2.0, 4.0));
	blockB.d[0] = (mat4x2(-6.0, 1.0, 5.0, 4.0, -4.0, -5.0, 9.0, 8.0));
	blockB.d[1] = (mat4x2(-5.0, -6.0, 4.0, 9.0, -9.0, -8.0, -1.0, -4.0));
	blockB.d[2] = (mat4x2(-9.0, 1.0, 9.0, -6.0, -2.0, -2.0, 3.0, 5.0));
	blockB.d[3] = (mat4x2(-3.0, -2.0, 4.0, 2.0, 7.0, -2.0, -1.0, 1.0));
	blockB.d[4] = (mat4x2(0.0, 7.0, 2.0, -3.0, -9.0, -5.0, 0.0, 8.0));
	blockC.e = i16vec2(ivec2(2, 2));
	blockC.f = (mat3(-2.0, -1.0, 4.0, -3.0, -1.0, -2.0, 2.0, -3.0, -1.0));
	blockC.h[0] = u16vec3(uvec3(4u, 5u, 0u));
	blockC.h[1] = u16vec3(uvec3(1u, 8u, 7u));
}
#version 450
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
	lowp mat4x2 a;
	lowp ivec4 b[][1];
};
layout(std430, buffer_reference) buffer BlockC
{
	highp mat3x2 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockC.c, mat3x2(-6.0, -5.0, -3.0, -4.0, -5.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x2(5.0, 1.0, 7.0, -2.0, -9.0, -1.0, -6.0, -3.0));
	blockB.b[0][0] = (ivec4(-9, -9, -2, -4));
	blockB.b[1][0] = (ivec4(-4, 3, 4, 9));
	blockB.b[2][0] = (ivec4(1, 2, -6, 5));
	blockB.b[3][0] = (ivec4(9, 2, -1, -7));
	blockB.b[4][0] = (ivec4(3, -7, -5, 7));
	blockB.b[5][0] = (ivec4(5, 5, 7, -3));
	blockB.b[6][0] = (ivec4(2, -2, 9, 5));
	blockC.c = (mat3x2(7.0, -5.0, 9.0, -3.0, 8.0, -3.0));
}
#version 450
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
	layout(offset = 8) highp uvec2 b;
	layout(offset = 16) float16_t c;
	layout(offset = 32) highp uvec4 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(blockB.a), vec3(6.0, -3.0, -3.0)) && allOk;
	allOk = compare_uvec2((blockB.b), uvec2(8u, 9u)) && allOk;
	allOk = compare_uvec4((blockB.d), uvec4(7u, 4u, 2u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = f16vec3(vec3(-8.0, 7.0, -5.0));
	blockB.b = (uvec2(4u, 9u));
	blockB.c = float16_t(0.0);
	blockB.d = (uvec4(3u, 5u, 1u, 5u));
}
#version 450
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
	lowp uvec4 c;
	i8vec3 d;
	u8vec4 e[1];
};
layout(std430, buffer_reference) buffer BlockC
{
	mediump ivec3 f;
	i8vec3 g;
	bool h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.b), bvec2(false, false)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.d), ivec3(4294967290, 0, 7)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB.e[0]), uvec4(3u, 8u, 1u, 8u)) && allOk;
	allOk = compare_bool((blockC.h), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (bvec2(true, true));
	blockB.c = (uvec4(5u, 6u, 3u, 1u));
	blockB.d = i8vec3(ivec3(2, 4294967292, 4294967288));
	blockB.e[0] = u8vec4(uvec4(3u, 9u, 8u, 1u));
	blockC.g = i8vec3(ivec3(4294967290, 9, 3));
	blockC.h = (true);
}
#version 450
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
	mediump uint c[];
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp int d;
	mediump uint e[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	highp uint f;
	bool g;
};
layout(std140, column_major, buffer_reference) buffer BlockE
{
	lowp vec4 h;
	highp uvec4 i;
	highp ivec4 j;
	mediump mat4x3 k[];
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(blockB.a), uvec2(7u, 9u)) && allOk;
	allOk = compare_mat4(blockB.b, mat4(-7.0, -3.0, 3.0, 8.0, 9.0, 9.0, -3.0, 8.0, -1.0, -2.0, 2.0, -3.0, 0.0, 0.0, -3.0, 8.0)) && allOk;
	allOk = compare_uint((blockB.c[0]), 4u) && allOk;
	allOk = compare_uint((blockB.c[1]), 8u) && allOk;
	allOk = compare_uint((blockB.c[2]), 9u) && allOk;
	allOk = compare_uint((blockB.c[3]), 0u) && allOk;
	allOk = compare_uint((blockB.c[4]), 4u) && allOk;
	allOk = compare_int((blockC.d), -9) && allOk;
	allOk = compare_uint((blockC.e[0]), 2u) && allOk;
	allOk = compare_uint((blockC.e[1]), 4u) && allOk;
	allOk = compare_uint((blockC.e[2]), 3u) && allOk;
	allOk = compare_uint((blockC.e[3]), 0u) && allOk;
	allOk = compare_uint((blockC.e[4]), 3u) && allOk;
	allOk = compare_bool((blockD.g), true) && allOk;
	allOk = compare_vec4((blockE.h), vec4(-8.0, 6.0, -3.0, -8.0)) && allOk;
	allOk = compare_uvec4((blockE.i), uvec4(1u, 0u, 4u, 7u)) && allOk;
	allOk = compare_ivec4((blockE.j), ivec4(-9, 1, 3, -6)) && allOk;
	allOk = compare_mat4x3(blockE.k[0], mat4x3(-8.0, 0.0, 3.0, -8.0, -3.0, -6.0, -9.0, 0.0, 9.0, 0.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat4x3(blockE.k[1], mat4x3(6.0, -3.0, 9.0, 7.0, 8.0, 8.0, 9.0, 7.0, -7.0, 7.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat4x3(blockE.k[2], mat4x3(-8.0, -2.0, -1.0, 6.0, 4.0, -1.0, -7.0, -2.0, 5.0, 6.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat4x3(blockE.k[3], mat4x3(-5.0, -2.0, 8.0, -5.0, 0.0, -3.0, 4.0, 2.0, -2.0, 5.0, -9.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c[0] = (8u);
	blockB.c[1] = (7u);
	blockB.c[2] = (5u);
	blockB.c[3] = (4u);
	blockB.c[4] = (6u);
	blockC.e[0] = (0u);
	blockC.e[1] = (2u);
	blockC.e[2] = (3u);
	blockC.e[3] = (3u);
	blockC.e[4] = (8u);
	blockD.g = (true);
	blockE.h = (vec4(8.0, 0.0, 6.0, 5.0));
	blockE.i = (uvec4(4u, 7u, 0u, 4u));
	blockE.k[0] = (mat4x3(0.0, 2.0, -1.0, -4.0, -3.0, 0.0, 5.0, -3.0, 7.0, 4.0, 0.0, -3.0));
	blockE.k[1] = (mat4x3(-8.0, -4.0, -1.0, -5.0, 1.0, -7.0, 2.0, -4.0, 1.0, -2.0, -8.0, 3.0));
	blockE.k[2] = (mat4x3(-7.0, -4.0, 3.0, -7.0, 1.0, -7.0, -5.0, 5.0, -5.0, -6.0, -6.0, -6.0));
	blockE.k[3] = (mat4x3(-3.0, 2.0, 9.0, -3.0, -7.0, -9.0, 8.0, 6.0, -1.0, 6.0, -9.0, 0.0));
}
#version 450
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
	int8_t a[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	highp ivec2 b;
	mediump float c;
	lowp mat2x3 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockC.b), ivec2(8, 8)) && allOk;
	allOk = compare_float((blockC.c), 2.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = int8_t(0);
	blockC.b = (ivec2(-7, 3));
	blockC.c = (-2.0);
}
#version 450
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
	int8_t a[];
};
layout(std430, buffer_reference) buffer BlockC
{
	highp mat2x3 b;
	i8vec2 c[];
};
layout(std430, buffer_reference) buffer BlockD
{
	i8vec3 d;
};
layout(std430, column_major, buffer_reference) buffer BlockE
{
	lowp vec3 e[];
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
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockC.b, mat2x3(3.0, -2.0, 9.0, -9.0, -1.0, -9.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockD.d), ivec3(6, 4294967291, 4294967288)) && allOk;
	allOk = compare_vec3((blockE.e[0]), vec3(2.0, 7.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (mat2x3(-2.0, 3.0, -5.0, -4.0, 5.0, -9.0));
	blockC.c[0] = i8vec2(ivec2(8, 1));
	blockD.d = i8vec3(ivec3(9, 5, 4294967292));
	blockE.e[0] = (vec3(-9.0, -3.0, 7.0));
}
#version 450
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
layout(std430, buffer_reference) readonly buffer BlockB
{
	bvec3 a;
	mediump ivec4 b[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	uint8_t c;
	sA d;
	bvec4 e;
	mediump mat3 f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.a), bvec3(true, true, false)) && allOk;
	allOk = compare_ivec4((blockB.b[0]), ivec4(-4, 4, 5, 3)) && allOk;
	allOk = compare_ivec4((blockB.b[1]), ivec4(7, 5, 1, -2)) && allOk;
	allOk = compare_ivec4((blockB.b[2]), ivec4(6, 3, -6, -9)) && allOk;
	allOk = compare_ivec4((blockB.b[3]), ivec4(-9, 3, 8, 8)) && allOk;
	allOk = compare_ivec4((blockB.b[4]), ivec4(-6, 2, -6, -8)) && allOk;
	allOk = compare_ivec4((blockB.b[5]), ivec4(9, -9, 8, -6)) && allOk;
	allOk = compare_ivec4((blockB.b[6]), ivec4(-5, -9, -3, -5)) && allOk;
	allOk = compare_uint8_t(uint(blockC[0].c), 2u) && allOk;
	allOk = compare_mat3(blockC[0].f[0], mat3(-2.0, 2.0, -1.0, 8.0, -8.0, 9.0, -3.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3(blockC[0].f[1], mat3(-8.0, -7.0, 4.0, -5.0, 4.0, 7.0, -4.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat3(blockC[0].f[2], mat3(-8.0, 8.0, 0.0, -3.0, 1.0, -6.0, 9.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3(blockC[0].f[3], mat3(-5.0, -9.0, 7.0, -6.0, 1.0, -3.0, -7.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3(blockC[0].f[4], mat3(-2.0, -6.0, -8.0, 0.0, -8.0, 1.0, -8.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3(blockC[0].f[5], mat3(-9.0, -8.0, -2.0, 8.0, 7.0, -2.0, -5.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3(blockC[0].f[6], mat3(4.0, -9.0, 6.0, -8.0, -7.0, 9.0, 9.0, -7.0, -8.0)) && allOk;
	allOk = compare_uint8_t(uint(blockC[1].c), 4u) && allOk;
	allOk = compare_mat3(blockC[1].f[0], mat3(-7.0, 9.0, -3.0, -8.0, 8.0, 4.0, -6.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3(blockC[1].f[1], mat3(2.0, -1.0, 0.0, 5.0, -2.0, -8.0, 9.0, -3.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC[0].c = uint8_t(9u);
	blockC[0].e = (bvec4(false, true, true, false));
	blockC[0].f[0] = (mat3(-5.0, -2.0, -3.0, -4.0, 3.0, 1.0, -2.0, -3.0, -9.0));
	blockC[0].f[1] = (mat3(9.0, -1.0, -3.0, -4.0, -3.0, 1.0, 0.0, -5.0, 8.0));
	blockC[0].f[2] = (mat3(-3.0, 8.0, 5.0, 0.0, 1.0, 2.0, 6.0, 8.0, 2.0));
	blockC[0].f[3] = (mat3(-3.0, -3.0, -6.0, -5.0, 3.0, 3.0, 0.0, -4.0, -9.0));
	blockC[0].f[4] = (mat3(0.0, -3.0, -8.0, 8.0, -7.0, -7.0, 8.0, -9.0, 4.0));
	blockC[0].f[5] = (mat3(-4.0, -1.0, 6.0, -7.0, -1.0, -7.0, 7.0, -5.0, 1.0));
	blockC[0].f[6] = (mat3(-4.0, 8.0, 4.0, -7.0, -8.0, 6.0, -8.0, 6.0, -9.0));
	blockC[1].c = uint8_t(7u);
	blockC[1].e = (bvec4(false, false, false, false));
	blockC[1].f[0] = (mat3(-8.0, 9.0, 3.0, 7.0, 7.0, -1.0, -9.0, -3.0, -2.0));
	blockC[1].f[1] = (mat3(-4.0, 2.0, 0.0, -8.0, -8.0, 0.0, 3.0, 7.0, 5.0));
}
#version 450
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
struct sB
{
	int8_t mA;
	lowp vec2 mB;
	mediump mat3 mC;
};
struct sC
{
	sB mA[8];
	u8vec2 mB;
	i8vec4 mC[6];
};
struct sD
{
	i8vec3 mA;
	mediump uint mB;
};
layout(std430, column_major, buffer_reference) buffer BlockB
{
	lowp mat2 a;
	mediump vec4 b;
	bvec3 c;
	sA d;
	highp mat2 e[][3];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	sC f;
	bvec3 g;
	highp int h;
	sD i[];
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
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.b), vec4(-4.0, 4.0, 0.0, 7.0)) && allOk;
	allOk = compare_int8_t(int(blockC.f.mA[0].mA), 2) && allOk;
	allOk = compare_vec2((blockC.f.mA[0].mB), vec2(2.0, 2.0)) && allOk;
	allOk = compare_mat3(blockC.f.mA[0].mC, mat3(9.0, 6.0, 6.0, 7.0, 1.0, -5.0, 0.0, 4.0, 7.0)) && allOk;
	allOk = compare_int8_t(int(blockC.f.mA[1].mA), 0) && allOk;
	allOk = compare_vec2((blockC.f.mA[1].mB), vec2(7.0, -7.0)) && allOk;
	allOk = compare_mat3(blockC.f.mA[1].mC, mat3(-4.0, -4.0, 7.0, -4.0, -7.0, 9.0, -9.0, 7.0, 6.0)) && allOk;
	allOk = compare_int8_t(int(blockC.f.mA[2].mA), 6) && allOk;
	allOk = compare_vec2((blockC.f.mA[2].mB), vec2(9.0, 7.0)) && allOk;
	allOk = compare_mat3(blockC.f.mA[2].mC, mat3(-5.0, -2.0, -4.0, -2.0, 2.0, -3.0, 7.0, 8.0, -7.0)) && allOk;
	allOk = compare_int8_t(int(blockC.f.mA[3].mA), 4294967292) && allOk;
	allOk = compare_vec2((blockC.f.mA[3].mB), vec2(8.0, -4.0)) && allOk;
	allOk = compare_mat3(blockC.f.mA[3].mC, mat3(-7.0, -8.0, 2.0, 3.0, -5.0, 7.0, 4.0, -1.0, 7.0)) && allOk;
	allOk = compare_int8_t(int(blockC.f.mA[4].mA), 7) && allOk;
	allOk = compare_vec2((blockC.f.mA[4].mB), vec2(-9.0, 9.0)) && allOk;
	allOk = compare_mat3(blockC.f.mA[4].mC, mat3(-1.0, 4.0, 8.0, -7.0, 0.0, 3.0, -3.0, -1.0, 9.0)) && allOk;
	allOk = compare_int8_t(int(blockC.f.mA[5].mA), 3) && allOk;
	allOk = compare_vec2((blockC.f.mA[5].mB), vec2(-3.0, -3.0)) && allOk;
	allOk = compare_mat3(blockC.f.mA[5].mC, mat3(-2.0, 5.0, -9.0, -3.0, 9.0, -1.0, -1.0, 1.0, 8.0)) && allOk;
	allOk = compare_int8_t(int(blockC.f.mA[6].mA), 4294967291) && allOk;
	allOk = compare_vec2((blockC.f.mA[6].mB), vec2(7.0, 4.0)) && allOk;
	allOk = compare_mat3(blockC.f.mA[6].mC, mat3(6.0, 4.0, 4.0, -8.0, 9.0, 6.0, -3.0, 5.0, 4.0)) && allOk;
	allOk = compare_int8_t(int(blockC.f.mA[7].mA), 4294967295) && allOk;
	allOk = compare_vec2((blockC.f.mA[7].mB), vec2(4.0, 4.0)) && allOk;
	allOk = compare_mat3(blockC.f.mA[7].mC, mat3(3.0, -9.0, -1.0, -1.0, -7.0, 7.0, 3.0, 2.0, 8.0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.f.mB), uvec2(5u, 7u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.f.mC[0]), ivec4(4, 2, 4294967287, 4294967291)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.f.mC[1]), ivec4(4294967289, 6, 4294967294, 9)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.f.mC[2]), ivec4(4294967295, 9, 4294967291, 2)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.f.mC[3]), ivec4(4294967292, 4294967291, 4294967295, 6)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.f.mC[4]), ivec4(0, 4294967292, 2, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.f.mC[5]), ivec4(4294967290, 3, 4294967289, 4294967293)) && allOk;
	allOk = compare_int((blockC.h), -3) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2(7.0, 7.0, 1.0, -6.0));
	blockB.b = (vec4(-1.0, 9.0, 3.0, -5.0));
	blockB.c = (bvec3(false, false, true));
	blockB.d.mA = (-6.0);
	blockB.d.mB = (uvec2(8u, 6u));
	blockC.i[0].mA = i8vec3(ivec3(4294967288, 7, 4));
	blockC.i[0].mB = (5u);
	blockC.i[1].mA = i8vec3(ivec3(0, 6, 5));
	blockC.i[1].mB = (0u);
	blockC.i[2].mA = i8vec3(ivec3(4294967291, 4, 5));
	blockC.i[2].mB = (3u);
	blockC.i[3].mA = i8vec3(ivec3(4, 4294967293, 2));
	blockC.i[3].mB = (7u);
	blockC.i[4].mA = i8vec3(ivec3(6, 4294967292, 1));
	blockC.i[4].mB = (4u);
	blockC.i[5].mA = i8vec3(ivec3(2, 4294967295, 4294967293));
	blockC.i[5].mB = (3u);
	blockC.i[6].mA = i8vec3(ivec3(4294967295, 4294967292, 4294967290));
	blockC.i[6].mB = (6u);
	blockC.i[7].mA = i8vec3(ivec3(4294967290, 4294967293, 4294967288));
	blockC.i[7].mB = (2u);
}
#version 450
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
	u8vec2 mA[3];
	mediump uvec2 mB;
	lowp mat3 mC;
};
struct sB
{
	lowp uvec4 mA;
	i8vec4 mB;
};
struct sC
{
	lowp uvec3 mA;
	mediump mat2 mB;
	uint8_t mC;
	lowp mat4 mD;
};
struct sD
{
	uint8_t mA;
};
struct sE
{
	mediump mat3 mA;
	uint8_t mB;
	lowp uvec4 mC;
	highp ivec2 mD;
};
struct sF
{
	sE mA;
	bool mB;
	mediump mat4x2 mC;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	highp vec2 a;
	u8vec4 b;
	sA c[];
};
layout(std140, buffer_reference) buffer BlockC
{
	sB d;
	lowp uvec4 e;
	u8vec4 f;
	i8vec2 g;
	u8vec2 h[][1];
};
layout(std140, buffer_reference) buffer BlockD
{
	i8vec4 i;
	sC j[1];
	lowp mat3x2 k;
	sD l[2];
	lowp vec4 m;
};
layout(std430, buffer_reference) buffer BlockE
{
	mediump mat2x3 n;
	bool o[8];
	highp uvec4 p;
	lowp ivec2 q;
	sF r[];
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
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(-7.0, 3.0)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB.b), uvec4(6u, 4u, 5u, 0u)) && allOk;
	allOk = compare_uvec4((blockC.e), uvec4(3u, 0u, 4u, 6u)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.g), ivec2(4294967294, 4294967295)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.h[0][0]), uvec2(5u, 6u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.h[1][0]), uvec2(1u, 7u)) && allOk;
	allOk = compare_uvec3((blockD.j[0].mA), uvec3(8u, 7u, 5u)) && allOk;
	allOk = compare_mat2(blockD.j[0].mB, mat2(4.0, 0.0, -4.0, 9.0)) && allOk;
	allOk = compare_uint8_t(uint(blockD.j[0].mC), 2u) && allOk;
	allOk = compare_mat4(blockD.j[0].mD, mat4(-1.0, 0.0, 4.0, -7.0, 3.0, 9.0, -8.0, -3.0, -1.0, 2.0, 7.0, -7.0, 3.0, 7.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2x3(blockE[0].n, mat2x3(-9.0, -4.0, -4.0, -7.0, 3.0, 8.0)) && allOk;
	allOk = compare_bool((blockE[0].o[0]), false) && allOk;
	allOk = compare_bool((blockE[0].o[1]), false) && allOk;
	allOk = compare_bool((blockE[0].o[2]), false) && allOk;
	allOk = compare_bool((blockE[0].o[3]), true) && allOk;
	allOk = compare_bool((blockE[0].o[4]), false) && allOk;
	allOk = compare_bool((blockE[0].o[5]), true) && allOk;
	allOk = compare_bool((blockE[0].o[6]), false) && allOk;
	allOk = compare_bool((blockE[0].o[7]), true) && allOk;
	allOk = compare_uvec4((blockE[0].p), uvec4(3u, 1u, 2u, 7u)) && allOk;
	allOk = compare_mat2x3(blockE[1].n, mat2x3(-6.0, 2.0, 2.0, -4.0, -4.0, -6.0)) && allOk;
	allOk = compare_bool((blockE[1].o[0]), true) && allOk;
	allOk = compare_bool((blockE[1].o[1]), false) && allOk;
	allOk = compare_bool((blockE[1].o[2]), true) && allOk;
	allOk = compare_bool((blockE[1].o[3]), false) && allOk;
	allOk = compare_bool((blockE[1].o[4]), false) && allOk;
	allOk = compare_bool((blockE[1].o[5]), false) && allOk;
	allOk = compare_bool((blockE[1].o[6]), true) && allOk;
	allOk = compare_bool((blockE[1].o[7]), false) && allOk;
	allOk = compare_uvec4((blockE[1].p), uvec4(0u, 4u, 8u, 5u)) && allOk;
	allOk = compare_mat2x3(blockE[2].n, mat2x3(5.0, 1.0, 2.0, -3.0, 9.0, 0.0)) && allOk;
	allOk = compare_bool((blockE[2].o[0]), false) && allOk;
	allOk = compare_bool((blockE[2].o[1]), true) && allOk;
	allOk = compare_bool((blockE[2].o[2]), false) && allOk;
	allOk = compare_bool((blockE[2].o[3]), true) && allOk;
	allOk = compare_bool((blockE[2].o[4]), true) && allOk;
	allOk = compare_bool((blockE[2].o[5]), true) && allOk;
	allOk = compare_bool((blockE[2].o[6]), false) && allOk;
	allOk = compare_bool((blockE[2].o[7]), true) && allOk;
	allOk = compare_uvec4((blockE[2].p), uvec4(0u, 6u, 2u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c[0].mA[0] = u8vec2(uvec2(6u, 2u));
	blockB.c[0].mA[1] = u8vec2(uvec2(7u, 9u));
	blockB.c[0].mA[2] = u8vec2(uvec2(8u, 0u));
	blockB.c[0].mB = (uvec2(6u, 5u));
	blockB.c[0].mC = (mat3(8.0, -7.0, 8.0, 4.0, -9.0, 6.0, -7.0, -8.0, -7.0));
	blockB.c[1].mA[0] = u8vec2(uvec2(8u, 1u));
	blockB.c[1].mA[1] = u8vec2(uvec2(8u, 9u));
	blockB.c[1].mA[2] = u8vec2(uvec2(5u, 5u));
	blockB.c[1].mB = (uvec2(5u, 0u));
	blockB.c[1].mC = (mat3(-6.0, -9.0, 2.0, -4.0, 8.0, -2.0, 5.0, -9.0, 5.0));
	blockB.c[2].mA[0] = u8vec2(uvec2(0u, 1u));
	blockB.c[2].mA[1] = u8vec2(uvec2(5u, 4u));
	blockB.c[2].mA[2] = u8vec2(uvec2(3u, 4u));
	blockB.c[2].mB = (uvec2(0u, 1u));
	blockB.c[2].mC = (mat3(9.0, 6.0, 5.0, 3.0, -2.0, 1.0, 0.0, -4.0, -9.0));
	blockB.c[3].mA[0] = u8vec2(uvec2(0u, 9u));
	blockB.c[3].mA[1] = u8vec2(uvec2(1u, 8u));
	blockB.c[3].mA[2] = u8vec2(uvec2(5u, 2u));
	blockB.c[3].mB = (uvec2(9u, 0u));
	blockB.c[3].mC = (mat3(2.0, 6.0, -9.0, 3.0, -2.0, 1.0, -9.0, 9.0, 9.0));
	blockC.d.mA = (uvec4(9u, 5u, 1u, 1u));
	blockC.d.mB = i8vec4(ivec4(4294967288, 4294967291, 6, 4294967291));
	blockC.e = (uvec4(6u, 3u, 2u, 6u));
	blockC.f = u8vec4(uvec4(2u, 4u, 4u, 8u));
	blockC.g = i8vec2(ivec2(1, 6));
	blockC.h[0][0] = u8vec2(uvec2(3u, 7u));
	blockC.h[1][0] = u8vec2(uvec2(9u, 1u));
	blockD.i = i8vec4(ivec4(4294967293, 4294967295, 9, 0));
	blockD.l[0].mA = uint8_t(9u);
	blockD.l[1].mA = uint8_t(0u);
	blockD.m = (vec4(-1.0, 1.0, 3.0, 8.0));
	blockE[0].n = (mat2x3(4.0, -7.0, 4.0, 1.0, -8.0, -4.0));
	blockE[0].o[0] = (true);
	blockE[0].o[1] = (false);
	blockE[0].o[2] = (false);
	blockE[0].o[3] = (false);
	blockE[0].o[4] = (true);
	blockE[0].o[5] = (true);
	blockE[0].o[6] = (true);
	blockE[0].o[7] = (true);
	blockE[0].p = (uvec4(3u, 9u, 1u, 2u));
	blockE[0].r[0].mA.mA = (mat3(-2.0, -8.0, -5.0, -9.0, -6.0, 1.0, 9.0, -4.0, -6.0));
	blockE[0].r[0].mA.mB = uint8_t(7u);
	blockE[0].r[0].mA.mC = (uvec4(0u, 8u, 3u, 2u));
	blockE[0].r[0].mA.mD = (ivec2(-8, -1));
	blockE[0].r[0].mB = (false);
	blockE[0].r[0].mC = (mat4x2(6.0, -4.0, -7.0, -5.0, -1.0, -1.0, 0.0, 1.0));
	blockE[0].r[1].mA.mA = (mat3(-8.0, -7.0, -2.0, -2.0, -9.0, 8.0, 4.0, 7.0, 3.0));
	blockE[0].r[1].mA.mB = uint8_t(5u);
	blockE[0].r[1].mA.mC = (uvec4(7u, 8u, 0u, 2u));
	blockE[0].r[1].mA.mD = (ivec2(3, -5));
	blockE[0].r[1].mB = (false);
	blockE[0].r[1].mC = (mat4x2(-4.0, 8.0, 3.0, 8.0, -6.0, 5.0, 4.0, -5.0));
	blockE[1].n = (mat2x3(-2.0, 1.0, 3.0, -3.0, -7.0, -5.0));
	blockE[1].o[0] = (true);
	blockE[1].o[1] = (false);
	blockE[1].o[2] = (true);
	blockE[1].o[3] = (true);
	blockE[1].o[4] = (false);
	blockE[1].o[5] = (false);
	blockE[1].o[6] = (true);
	blockE[1].o[7] = (true);
	blockE[1].p = (uvec4(2u, 9u, 0u, 8u));
	blockE[1].r[0].mA.mA = (mat3(1.0, 0.0, 4.0, -5.0, 1.0, 1.0, 7.0, -2.0, 8.0));
	blockE[1].r[0].mA.mB = uint8_t(6u);
	blockE[1].r[0].mA.mC = (uvec4(9u, 0u, 2u, 4u));
	blockE[1].r[0].mA.mD = (ivec2(-2, 5));
	blockE[1].r[0].mB = (true);
	blockE[1].r[0].mC = (mat4x2(-6.0, 0.0, 0.0, -8.0, -6.0, 7.0, 3.0, -7.0));
	blockE[1].r[1].mA.mA = (mat3(-5.0, 1.0, 3.0, 4.0, -7.0, 8.0, 8.0, -4.0, 9.0));
	blockE[1].r[1].mA.mB = uint8_t(0u);
	blockE[1].r[1].mA.mC = (uvec4(1u, 3u, 2u, 9u));
	blockE[1].r[1].mA.mD = (ivec2(-8, 7));
	blockE[1].r[1].mB = (true);
	blockE[1].r[1].mC = (mat4x2(-2.0, 8.0, -5.0, -8.0, -7.0, -2.0, -8.0, 2.0));
	blockE[1].r[2].mA.mA = (mat3(-7.0, 1.0, 4.0, -4.0, 1.0, -9.0, 2.0, -9.0, -6.0));
	blockE[1].r[2].mA.mB = uint8_t(3u);
	blockE[1].r[2].mA.mC = (uvec4(7u, 1u, 2u, 5u));
	blockE[1].r[2].mA.mD = (ivec2(5, -4));
	blockE[1].r[2].mB = (false);
	blockE[1].r[2].mC = (mat4x2(9.0, 0.0, -2.0, 8.0, -7.0, 4.0, -9.0, 5.0));
	blockE[1].r[3].mA.mA = (mat3(7.0, 2.0, -4.0, 0.0, 9.0, 0.0, 1.0, -4.0, -7.0));
	blockE[1].r[3].mA.mB = uint8_t(8u);
	blockE[1].r[3].mA.mC = (uvec4(2u, 7u, 5u, 0u));
	blockE[1].r[3].mA.mD = (ivec2(-1, 5));
	blockE[1].r[3].mB = (false);
	blockE[1].r[3].mC = (mat4x2(0.0, 7.0, 2.0, -3.0, 0.0, -2.0, -1.0, -4.0));
	blockE[1].r[4].mA.mA = (mat3(-7.0, 2.0, -5.0, -7.0, 7.0, -3.0, -4.0, -6.0, 5.0));
	blockE[1].r[4].mA.mB = uint8_t(5u);
	blockE[1].r[4].mA.mC = (uvec4(5u, 3u, 9u, 4u));
	blockE[1].r[4].mA.mD = (ivec2(3, 8));
	blockE[1].r[4].mB = (true);
	blockE[1].r[4].mC = (mat4x2(-5.0, 4.0, 4.0, 1.0, 5.0, 5.0, 9.0, -3.0));
	blockE[1].r[5].mA.mA = (mat3(-7.0, -9.0, 0.0, 3.0, 0.0, 0.0, 4.0, 8.0, 0.0));
	blockE[1].r[5].mA.mB = uint8_t(7u);
	blockE[1].r[5].mA.mC = (uvec4(1u, 6u, 0u, 4u));
	blockE[1].r[5].mA.mD = (ivec2(4, 3));
	blockE[1].r[5].mB = (true);
	blockE[1].r[5].mC = (mat4x2(5.0, -9.0, 2.0, -4.0, -2.0, -7.0, 8.0, 5.0));
	blockE[1].r[6].mA.mA = (mat3(-8.0, -9.0, -7.0, 1.0, -6.0, 8.0, -1.0, 2.0, 2.0));
	blockE[1].r[6].mA.mB = uint8_t(7u);
	blockE[1].r[6].mA.mC = (uvec4(6u, 2u, 5u, 9u));
	blockE[1].r[6].mA.mD = (ivec2(2, 3));
	blockE[1].r[6].mB = (false);
	blockE[1].r[6].mC = (mat4x2(-4.0, -2.0, -9.0, -8.0, 9.0, 1.0, -1.0, -7.0));
	blockE[1].r[7].mA.mA = (mat3(6.0, -3.0, -5.0, -5.0, 1.0, 7.0, 1.0, 2.0, -7.0));
	blockE[1].r[7].mA.mB = uint8_t(2u);
	blockE[1].r[7].mA.mC = (uvec4(6u, 3u, 0u, 0u));
	blockE[1].r[7].mA.mD = (ivec2(0, 1));
	blockE[1].r[7].mB = (true);
	blockE[1].r[7].mC = (mat4x2(6.0, -2.0, -4.0, -9.0, -3.0, -7.0, 2.0, 0.0));
	blockE[2].n = (mat2x3(-8.0, 8.0, -5.0, 3.0, -8.0, -1.0));
	blockE[2].o[0] = (true);
	blockE[2].o[1] = (false);
	blockE[2].o[2] = (false);
	blockE[2].o[3] = (true);
	blockE[2].o[4] = (true);
	blockE[2].o[5] = (true);
	blockE[2].o[6] = (true);
	blockE[2].o[7] = (true);
	blockE[2].p = (uvec4(2u, 8u, 8u, 1u));
	blockE[2].r[0].mA.mA = (mat3(6.0, 7.0, 6.0, -3.0, 7.0, 4.0, -8.0, 0.0, 7.0));
	blockE[2].r[0].mA.mB = uint8_t(6u);
	blockE[2].r[0].mA.mC = (uvec4(3u, 5u, 1u, 3u));
	blockE[2].r[0].mA.mD = (ivec2(-3, 8));
	blockE[2].r[0].mB = (true);
	blockE[2].r[0].mC = (mat4x2(-8.0, -1.0, -8.0, -3.0, 2.0, 0.0, 8.0, -7.0));
	blockE[2].r[1].mA.mA = (mat3(0.0, -5.0, 0.0, -6.0, 4.0, -1.0, 8.0, -5.0, -8.0));
	blockE[2].r[1].mA.mB = uint8_t(1u);
	blockE[2].r[1].mA.mC = (uvec4(7u, 1u, 0u, 7u));
	blockE[2].r[1].mA.mD = (ivec2(0, -3));
	blockE[2].r[1].mB = (false);
	blockE[2].r[1].mC = (mat4x2(8.0, -5.0, -8.0, 7.0, -8.0, 4.0, -1.0, -9.0));
	blockE[2].r[2].mA.mA = (mat3(2.0, 6.0, 6.0, -5.0, -3.0, 3.0, -8.0, 4.0, -1.0));
	blockE[2].r[2].mA.mB = uint8_t(9u);
	blockE[2].r[2].mA.mC = (uvec4(6u, 5u, 1u, 6u));
	blockE[2].r[2].mA.mD = (ivec2(7, -4));
	blockE[2].r[2].mB = (true);
	blockE[2].r[2].mC = (mat4x2(7.0, 0.0, 9.0, -9.0, -2.0, 0.0, -1.0, -1.0));
	blockE[2].r[3].mA.mA = (mat3(4.0, 4.0, -2.0, 1.0, 3.0, -3.0, 2.0, -4.0, -8.0));
	blockE[2].r[3].mA.mB = uint8_t(4u);
	blockE[2].r[3].mA.mC = (uvec4(7u, 4u, 3u, 0u));
	blockE[2].r[3].mA.mD = (ivec2(-5, -3));
	blockE[2].r[3].mB = (true);
	blockE[2].r[3].mC = (mat4x2(-8.0, -2.0, 2.0, -6.0, 4.0, 5.0, 0.0, -8.0));
}
#version 450
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
	u8vec4 mB;
	mediump mat2x3 mC;
	highp mat4x2 mD;
};
struct sB
{
	mediump vec2 mA;
	i8vec2 mB[6];
	mediump mat3x4 mC;
	mediump vec4 mD;
};
struct sC
{
	sB mA;
	i8vec2 mB;
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	mediump uvec2 a;
	bvec4 b;
	sA c;
	lowp mat3x2 d[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	sC e;
	lowp uvec2 f;
	mediump uvec4 g[];
};
layout(std140, buffer_reference) buffer BlockD
{
	lowp mat2 h;
	highp mat2 i;
	u8vec3 j;
	mediump uvec3 k[];
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
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a), uvec2(7u, 9u)) && allOk;
	allOk = compare_bvec4((blockB.b), bvec4(false, false, true, true)) && allOk;
	allOk = compare_uvec2((blockC.f), uvec2(3u, 1u)) && allOk;
	allOk = compare_uvec4((blockC.g[0]), uvec4(8u, 9u, 4u, 6u)) && allOk;
	allOk = compare_mat2(blockD[0].h, mat2(-9.0, -3.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat2(blockD[0].i, mat2(-7.0, 4.0, 5.0, -8.0)) && allOk;
	allOk = compare_uvec3((blockD[0].k[0]), uvec3(4u, 9u, 1u)) && allOk;
	allOk = compare_uvec3((blockD[0].k[1]), uvec3(0u, 9u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec2(7u, 5u));
	blockC.f = (uvec2(3u, 6u));
	blockD[0].h = (mat2(-8.0, 1.0, 6.0, 6.0));
	blockD[0].i = (mat2(-6.0, -4.0, -7.0, -9.0));
}
#version 450
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
	mediump ivec3 a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec3(6, 3, -9));
}
#version 450
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
	lowp ivec2 a[];
};
layout(std140, buffer_reference) buffer BlockC
{
	i8vec2 b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a[0]), ivec2(0, 7)) && allOk;
	allOk = compare_ivec2((blockB.a[1]), ivec2(4, -8)) && allOk;
	allOk = compare_ivec2((blockB.a[2]), ivec2(-2, -7)) && allOk;
	allOk = compare_ivec2((blockB.a[3]), ivec2(1, 0)) && allOk;
	allOk = compare_ivec2((blockB.a[4]), ivec2(5, 7)) && allOk;
	allOk = compare_ivec2((blockB.a[5]), ivec2(-2, -5)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.b[0]), ivec2(4294967295, 4294967287)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.b[1]), ivec2(4294967293, 4294967292)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.b[2]), ivec2(6, 4294967287)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.b[3]), ivec2(4294967295, 4294967290)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b[0] = i8vec2(ivec2(4, 9));
	blockC.b[1] = i8vec2(ivec2(4294967287, 4294967291));
	blockC.b[2] = i8vec2(ivec2(8, 3));
	blockC.b[3] = i8vec2(ivec2(4294967295, 7));
}
#version 450
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
	layout(offset = 12) int8_t b;
	layout(offset = 13) int8_t c;
	layout(offset = 16) lowp uvec3 d;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) u8vec4 e;
	layout(offset = 4) uint8_t f[1];
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) lowp ivec4 g;
	layout(offset = 16) uint8_t h[1];
	layout(offset = 20) highp float i;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[2];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.a), vec3(2.0, 5.0, -2.0)) && allOk;
	allOk = compare_int8_t(int(blockB.b), 1) && allOk;
	allOk = compare_int8_t(int(blockB.c), 2) && allOk;
	allOk = compare_ivec4((blockD.g), ivec4(-8, -5, 9, -1)) && allOk;
	allOk = compare_uint8_t(uint(blockD.h[0]), 3u) && allOk;
	allOk = compare_float((blockD.i), -5.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec3(8.0, 3.0, 6.0));
	blockB.b = int8_t(4294967292);
	blockB.d = (uvec3(4u, 5u, 4u));
	blockC[0].e = u8vec4(uvec4(4u, 1u, 3u, 6u));
	blockC[0].f[0] = uint8_t(8u);
	blockC[1].e = u8vec4(uvec4(2u, 0u, 5u, 6u));
	blockC[1].f[0] = uint8_t(8u);
	blockD.g = (ivec4(-9, 9, 7, -1));
	blockD.h[0] = uint8_t(3u);
	blockD.i = (-5.0);
}
#version 450
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
	uint8_t mA;
	lowp float mB;
};
layout(scalar, row_major, buffer_reference) readonly buffer BlockB
{
	bool a[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	highp ivec2 b;
	highp vec4 c;
	int8_t d[][6];
};
layout(scalar, buffer_reference) buffer BlockD
{
	lowp mat3 e;
	sA f;
	highp mat4 g;
	lowp mat2 h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a[0]), true) && allOk;
	allOk = compare_bool((blockB.a[1]), true) && allOk;
	allOk = compare_bool((blockB.a[2]), true) && allOk;
	allOk = compare_bool((blockB.a[3]), true) && allOk;
	allOk = compare_bool((blockB.a[4]), false) && allOk;
	allOk = compare_bool((blockB.a[5]), true) && allOk;
	allOk = compare_vec4((blockC.c), vec4(4.0, 3.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3(blockD[0].e, mat3(7.0, 6.0, -2.0, 9.0, 0.0, -1.0, 5.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat4(blockD[0].g, mat4(3.0, 0.0, 3.0, -3.0, -2.0, -6.0, -7.0, -7.0, 3.0, -6.0, 6.0, -3.0, 8.0, -4.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat2(blockD[0].h[0], mat2(3.0, 4.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat2(blockD[0].h[1], mat2(2.0, -2.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat2(blockD[0].h[2], mat2(-4.0, -4.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat2(blockD[0].h[3], mat2(-2.0, 8.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(blockD[0].h[4], mat2(0.0, -6.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat2(blockD[0].h[5], mat2(4.0, -8.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(blockD[1].e, mat3(5.0, -6.0, -9.0, -2.0, 8.0, 9.0, -3.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4(blockD[1].g, mat4(7.0, 0.0, 2.0, -7.0, -5.0, -6.0, -9.0, -4.0, -1.0, 0.0, 9.0, -9.0, -6.0, 9.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat2(blockD[1].h[0], mat2(-4.0, -5.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2(blockD[1].h[1], mat2(-5.0, 3.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2(blockD[1].h[2], mat2(-7.0, -5.0, 0.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (ivec2(5, -2));
	blockC.c = (vec4(8.0, -2.0, 7.0, 7.0));
	blockC.d[0][0] = int8_t(1);
	blockC.d[0][1] = int8_t(4294967287);
	blockC.d[0][2] = int8_t(4);
	blockC.d[0][3] = int8_t(5);
	blockC.d[0][4] = int8_t(9);
	blockC.d[0][5] = int8_t(4294967291);
	blockC.d[1][0] = int8_t(4294967287);
	blockC.d[1][1] = int8_t(4294967287);
	blockC.d[1][2] = int8_t(4294967289);
	blockC.d[1][3] = int8_t(5);
	blockC.d[1][4] = int8_t(8);
	blockC.d[1][5] = int8_t(4294967287);
	blockC.d[2][0] = int8_t(1);
	blockC.d[2][1] = int8_t(3);
	blockC.d[2][2] = int8_t(4294967293);
	blockC.d[2][3] = int8_t(4294967287);
	blockC.d[2][4] = int8_t(4294967290);
	blockC.d[2][5] = int8_t(9);
	blockC.d[3][0] = int8_t(4294967290);
	blockC.d[3][1] = int8_t(4294967290);
	blockC.d[3][2] = int8_t(0);
	blockC.d[3][3] = int8_t(9);
	blockC.d[3][4] = int8_t(1);
	blockC.d[3][5] = int8_t(6);
	blockC.d[4][0] = int8_t(6);
	blockC.d[4][1] = int8_t(4294967295);
	blockC.d[4][2] = int8_t(6);
	blockC.d[4][3] = int8_t(7);
	blockC.d[4][4] = int8_t(5);
	blockC.d[4][5] = int8_t(2);
	blockC.d[5][0] = int8_t(4294967290);
	blockC.d[5][1] = int8_t(9);
	blockC.d[5][2] = int8_t(6);
	blockC.d[5][3] = int8_t(3);
	blockC.d[5][4] = int8_t(0);
	blockC.d[5][5] = int8_t(4294967289);
	blockD[0].f.mA = uint8_t(7u);
	blockD[0].f.mB = (-8.0);
	blockD[1].f.mA = uint8_t(2u);
	blockD[1].f.mB = (2.0);
}
#version 450
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
	layout(offset = 0) mediump uvec4 a[1];
	layout(offset = 16) u8vec4 b;
	layout(offset = 20) i8vec4 c;
	layout(offset = 24) mediump mat2x3 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB[nonuniformEXT(0)].d, mat2x3(7.0, -1.0, -5.0, -1.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat2x3(blockB[nonuniformEXT(1)].d, mat2x3(-2.0, -2.0, -6.0, 6.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat2x3(blockB[nonuniformEXT(2)].d, mat2x3(-1.0, -3.0, 2.0, -5.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat2x3(blockB[nonuniformEXT(3)].d, mat2x3(-7.0, 1.0, -2.0, -7.0, -6.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a[0] = (uvec4(3u, 2u, 9u, 0u));
	blockB[nonuniformEXT(0)].b = u8vec4(uvec4(7u, 6u, 4u, 0u));
	blockB[nonuniformEXT(0)].c = i8vec4(ivec4(4294967291, 4294967291, 4294967289, 5));
	blockB[nonuniformEXT(0)].d = (mat2x3(2.0, -8.0, 9.0, -4.0, 0.0, 3.0));
	blockB[nonuniformEXT(1)].a[0] = (uvec4(1u, 3u, 8u, 2u));
	blockB[nonuniformEXT(1)].b = u8vec4(uvec4(9u, 0u, 6u, 2u));
	blockB[nonuniformEXT(1)].c = i8vec4(ivec4(7, 4294967288, 5, 4294967294));
	blockB[nonuniformEXT(1)].d = (mat2x3(-7.0, 5.0, -1.0, -2.0, 0.0, 5.0));
	blockB[nonuniformEXT(2)].a[0] = (uvec4(5u, 0u, 1u, 6u));
	blockB[nonuniformEXT(2)].b = u8vec4(uvec4(6u, 4u, 1u, 9u));
	blockB[nonuniformEXT(2)].c = i8vec4(ivec4(4, 4294967293, 1, 6));
	blockB[nonuniformEXT(2)].d = (mat2x3(5.0, 5.0, -1.0, 8.0, -1.0, -1.0));
	blockB[nonuniformEXT(3)].a[0] = (uvec4(9u, 3u, 7u, 5u));
	blockB[nonuniformEXT(3)].b = u8vec4(uvec4(9u, 8u, 8u, 3u));
	blockB[nonuniformEXT(3)].c = i8vec4(ivec4(3, 4294967290, 1, 4294967295));
	blockB[nonuniformEXT(3)].d = (mat2x3(-1.0, 2.0, -4.0, 1.0, -5.0, 4.0));
}
#version 450
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
	bvec4 a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

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
